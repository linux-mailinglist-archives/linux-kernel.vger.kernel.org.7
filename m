Return-Path: <linux-kernel+bounces-736981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4DEB0A621
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6330C5A7AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C4A2DE1E2;
	Fri, 18 Jul 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=truongsinh.pro header.i=@truongsinh.pro header.b="dgvr9Rs0"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8192DCF65
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848458; cv=none; b=PqEuoOmUT5jkOQXSKDbvp7AOXlyBFaRT2Hi+yYvb6royQBzPjtPsl32waMM4BvLEKFQC0LhWXAUiPCyL3F/46XBSiLOYNaSQZrhFUq8eg4AAsLfAZZeaYtsHUHNjsbdqx+VOGmFbRfp8FxgJqaLna6CGZMPoJjLPBTqNoxyIevc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848458; c=relaxed/simple;
	bh=UR/3lYqWlr6+TFIphcrSb08358WsAG5Jc3tmyhuBNUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7Go7hBB92CKP7Ikj9BdCB9KAbc2OX8+PXeQChI9cEj6pFSfDXLib7YRlTYMh7fhIe7y3vxDMtUCmgmdJI///6CuRF2uVEGICsGwUIFVCW+poTJ6t2i5vlrzhuQSS7iDcgojV8PPTI5iKFKfL2p4UjicVdgs41cTcM39WXjXuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truongsinh.pro; spf=pass smtp.mailfrom=truongsinh.pro; dkim=pass (1024-bit key) header.d=truongsinh.pro header.i=@truongsinh.pro header.b=dgvr9Rs0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truongsinh.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truongsinh.pro
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23649faf69fso19648845ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=truongsinh.pro; s=google; t=1752848455; x=1753453255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHc6EgBSaCyhHUt4iMs1slcS/3iZ0njcmmeqo15tlyw=;
        b=dgvr9Rs0cXzqBZy48+wxsP50DX+Du2DdZQo4blS8VXuqAthHGQOCVp9ivff+q2fRHs
         LcCYf2SQAQnLs03Dfe9/zkPeXeavKYFqgtZDalYQ3RLd8/x8jzAupVtGzYCX/pSl4zNv
         yCTNEQ2UIncr/wM0aHeei9K9rItci6YIaC6uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752848455; x=1753453255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHc6EgBSaCyhHUt4iMs1slcS/3iZ0njcmmeqo15tlyw=;
        b=A7sLez/yemzM5G98DFIt2a8SvBu0uOzrsHPorjkbYGwGVA0ZH/2JvR4nxzwkYNhFHe
         TYfwea/ZF+YG/nwagWOXJ1+fDBDtOyMagajTLYNh9rBXDmkN9E7nY668KMBt2alJG8E0
         E29OzrWmAR7JXf/vKzIA6+YvElYv0QYkZnPDBALHEs9FaVHasetIFsEaqEBJKwpp1FeC
         pkmyagHLQtjbdo4EPGT4n9lfsdfXsFTskzTN+wnVM5/DW59sseXnPrU6fnqX8AiH6uxN
         oEH9wATKfpvcEyDkrC8fahSvpH3c7rlcWpcbj8EBmrmI6fVLgDqT3tpIGQ71pEbDw1tM
         gaUg==
X-Gm-Message-State: AOJu0YxOSSSrAMiuPE5n0z0blqgIHVfBNGbEyX7/sRoJ9HfKQQU3ktnN
	QRWo+AtyKh3uMWMpYoVsaZMJYoXMSkR0a9w34l2w2zhCp1n1b+mPqvJWIJ03I1EFOPQ=
X-Gm-Gg: ASbGncsqV3i7OQs6d044WHdbCQul90lnXeDUhsAmBRRlq9uWCV3HOgwRTBlpF/mcVEi
	IQzmmk+FcJJGAboLSl/Sbs7c8IVDIv5xbKOGJ1TMbOnnNfpeWBs7UAs/wxje+O/nvBwgdoR71NM
	L12fdqWEMhcrqEas2feOFG6ng73BlskqDRPD9NXDISNT/d9LYvsgczXa8cnmKUFYwszrH+BqibO
	IFgcgUWd4Jxdn2LdOjxy5eW9o1lGP5lGVgRuIL+sEFybFdC9WvYFDL7IJbb30aDf/UC1a+2PUnL
	EUbS3VukTGKdPDOmhBFBPKFV0R5hKjPvaueWqPQnmFdyP6npIGZqMyTqAH3QBSc17yW37O0s0b8
	5jFlEjXcx5ZRJG3hh8hOTtE5H5ZF36iyM
X-Google-Smtp-Source: AGHT+IE8URDevzEmHo34O8MknMpqxByTBGGoC9vivJaSg8dUHx3zY0Y6AH3iU7VKdlP+uWE4s+hcvw==
X-Received: by 2002:a17:903:3bc5:b0:235:6e7:8df2 with SMTP id d9443c01a7336-23e2575a8d6mr154254985ad.41.1752848455514;
        Fri, 18 Jul 2025 07:20:55 -0700 (PDT)
Received: from gti14.tail9399b.ts.net ([71.212.150.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d5asm14070575ad.15.2025.07.18.07.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:20:55 -0700 (PDT)
From: TruongSinh Tran-Nguyen <i@truongsinh.pro>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	TruongSinh Tran-Nguyen <i@truongsinh.pro>
Subject: [PATCH] rust: Add #[must_use] to Lock::try_lock, GlobalLock::try_lock, and XArray::try_lock
Date: Fri, 18 Jul 2025 07:20:26 -0700
Message-ID: <20250718142026.2232366-1-i@truongsinh.pro>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These methods return an RAII guard that unlocks the lock when dropped.
If the return value is ignored, the lock is released immediately,
which is likely not the intended behavior.

This addresses issue #1133 in the rust-for-linux project.

Signed-off-by: TruongSinh Tran-Nguyen <i@truongsinh.pro>
---
 rust/kernel/sync/lock.rs        | 1 +
 rust/kernel/sync/lock/global.rs | 1 +
 rust/kernel/xarray.rs           | 1 +
 3 files changed, 3 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index e82fa5be289c..1c2ddade6d6d 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -175,6 +175,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
     /// Tries to acquire the lock.
     ///
     /// Returns a guard that can be used to access the data protected by the lock if successful.
+    #[must_use = "the lock unlocks immediately when the guard is unused"]
     pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index d65f94b5caf2..fdce038b5e0a 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -84,6 +84,7 @@ pub fn lock(&'static self) -> GlobalGuard<B> {
     }
 
     /// Try to lock this global lock.
+    #[must_use = "the lock unlocks immediately when the guard is unused"]
     pub fn try_lock(&'static self) -> Option<GlobalGuard<B>> {
         Some(GlobalGuard {
             inner: self.inner.try_lock()?,
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 75719e7bb491..3cca717a3cb4 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -118,6 +118,7 @@ fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
     }
 
     /// Attempts to lock the [`XArray`] for exclusive access.
+    #[must_use = "the lock unlocks immediately when the guard is unused"]
     pub fn try_lock(&self) -> Option<Guard<'_, T>> {
         // SAFETY: `self.xa` is always valid by the type invariant.
         if (unsafe { bindings::xa_trylock(self.xa.get()) } != 0) {
-- 
2.43.0



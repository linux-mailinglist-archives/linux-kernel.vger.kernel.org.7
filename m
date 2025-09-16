Return-Path: <linux-kernel+bounces-818606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA27FB593E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1076C1899B17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41768302758;
	Tue, 16 Sep 2025 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbq6pb5K"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746229B8E1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019134; cv=none; b=T4YlQ/54epmhdxZPIoN9HhUt3Nth7VRy9Gv1xkd2yhF/j9MApoSDx/JP0sxNlNlGZHBwfKgBqLYwm2jTQ5KH798oOxTNpd98es+PrHzxphHYVMsAkqp0UneGkySEJMn163I4/OKt+08lzKwFfv6hE3vwOnebQZfldRkfcmW2Hks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019134; c=relaxed/simple;
	bh=fQUUkOhQmmCC6m91ZNRljm8byQCPbXUd4rBcIXzTIGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CX+j6dPJ5G29RJUWkhcLmPQCXddRDLU/iJMBt5HYrHVx0smIrR3BQsb4M4Nh1Ulg/Xu9bVl8Um3jeUDktjFNEmjsRrS2otI+A2d2nrzFRyKWB4tRHRPhKEfe9+hkcPhC7CCU+DrM0EoMNRte9pyIVCQYSH1Ls5/EysfIh+DSN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tbq6pb5K; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-77615d6af4fso4731357b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758019132; x=1758623932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JEmdwk5PDuo0ptW6KhEWo51Ba8M17k+tkrZHbZtMGw=;
        b=Tbq6pb5KSrkw71cM4ibwtUhi6pDks7uPfSL7Ljf9r8JKplbi2juWWWsaDJiZjcYqZA
         /IIj7YN0uGqkSUoPphxpWa1km02aXv3fCdoBLG3QGIcaDZa3Ko1ioMPE48TqlEQktYue
         zMUrpCdAWtFZCbVfNoLGvvgw0D74DhO20sPRkFmjShJtNdQYNR9i/HtW6P/5itG68vYs
         8VJ0pelGvl9lz2ZIKFXkCTr0HxcrGskwgV9gqYQFXUi18BKAlJrDXL6k2e0a99s8ZC53
         7PcgmplV2B2x5qA2BArEJ3fWsF8nvn5j8GdDTKs44AxfTuHl43RxHMC1mlldiFEHPHp7
         ts8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019132; x=1758623932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JEmdwk5PDuo0ptW6KhEWo51Ba8M17k+tkrZHbZtMGw=;
        b=DcLZAGOliU9AOoM9w9kgNjwvM/0ZA7fV04R8W8JUe093r6GGqImRjiFGHZbuTAbdPq
         EG6P4MKVkkFn+3CbMu7q12gTaPsyAtHN0sg0ov8uS85foF7MePe1i87DV9emJGfisbwJ
         HC65uLZ7Jjlg1l7oOrGizV1bTILfrrd10JGArOTgQ5bptpk+Ex0c3hLQAFXLuqlkmY8H
         7VJ2gqczUtKlrd7DkZGxRTTR3lmZRSGAviHktP0mFftUd6IzfSmdKEZjJpZm7IGF86aP
         1sPZ0vIeLyQnUu+HlGZFmRCLtA3pT03N+JQf2oOMBLhROlJyiSYc/SJDHzrPlhUG8O5s
         Q2lA==
X-Forwarded-Encrypted: i=1; AJvYcCUmlQBHfhYogJDdvwqGm6aEj2QzGvq3ejCJdvH+EgOhckmAKIekflsOLdSR/dv27x3kWXYXWgKL8iOPv9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQJDvCX86BG73BXpWXb0km+zWxAZdoZLTujiap2cduTcP/Z06
	Ci1aYNWx/gztXr+SbHeZIhPkvafYlhuwK0F9biikrrJQNz8oIze8z1A=
X-Gm-Gg: ASbGnct2imTSUT2fjh2LlgrMRDbFUxouypHTEM3Gexzx+pSPodhZNkGpzwio/OvskcO
	233B4ES3Bh01Ry5kZFmAGmAZDq0ge3WOZyrclJx2l/Ndxj5U8qFYMyd/nPijp1is/Mpy2qG0+C5
	+FmYVSqyXwrAa4pwEqc4+MOMpZj2nJpxxMxRhylnw2or3F5CC/JlAg/z+Vx4yLBTcnEPx1qWryY
	pgdXmgldmpeaK2NsW7izhaLqlM2EbiP+9rC2h+Jo7c0UaVLF8RdIT/w24Kk6OpadKayGsa9Ejpf
	gMYveaKTzxlhmMTbiBTh63gkt5GwY5WHVn5F0kJxa83sCn/rbRkgOF2WgzKPjkwctZmR1hLBWlH
	cyajEGHmmpavTyeXRw5CSCg128QJBfLeavivnN/fqYtUYIxSwvclnH6LP85yQUmcjA8j9abmWn9
	ejIlASEtcOfHQSwkzgdghu
X-Google-Smtp-Source: AGHT+IGgntFeqlFJt2FVnZrMvo4YLsqqcUo7P0ZDCpRS98MLHdkW+VcUerx3r4BZs7mmj6AIYsXfNQ==
X-Received: by 2002:a05:6a20:72a3:b0:250:9175:96e8 with SMTP id adf61e73a8af0-2602c718d10mr20502990637.45.1758019132475;
        Tue, 16 Sep 2025 03:38:52 -0700 (PDT)
Received: from codespaces-8c10cd.3gx5x4kts4veljes22u4ri2f3b.ix.internal.cloudapp.net ([23.97.62.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a35b8cdbsm14027994a12.8.2025.09.16.03.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:38:52 -0700 (PDT)
From: JaimeF <jaimefine6@gmail.com>
To: gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com
Cc: david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaime Fan <jaimefine6@gmail.com>,
	onur-ozkan <contact@onurozkan.dev>
Subject: [PATCH] Fixed "initialialized" typo in auxiliary.rs
Date: Tue, 16 Sep 2025 10:38:38 +0000
Message-ID: <20250916103839.17202-1-jaimefine6@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaime Fan <jaimefine6@gmail.com>

Suggested-by: onur-ozkan <contact@onurozkan.dev>
Link: https://github.com/Rust-for-Linux/linux/issues/1187
Signed-off-by: Jaime F <jaimefine6@gmail.com>
---
 rust/kernel/auxiliary.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 58be09871..129eae8ff 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -317,12 +317,12 @@ pub fn new(parent: &device::Device, name: &CStr, id: u32, modname: &CStr) -> Res
 
         // SAFETY:
         // - `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`, which has
-        //   been initialialized,
+        //   been initialized,
         // - `modname.as_char_ptr()` is a NULL terminated string.
         let ret = unsafe { bindings::__auxiliary_device_add(adev, modname.as_char_ptr()) };
         if ret != 0 {
             // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
-            // which has been initialialized.
+            // which has been initialized.
             unsafe { bindings::auxiliary_device_uninit(adev) };
 
             return Err(Error::from_errno(ret));
-- 
2.50.1



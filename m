Return-Path: <linux-kernel+bounces-774367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D060B2B168
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E673B585E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731FB27BF6C;
	Mon, 18 Aug 2025 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIEYl0PW"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E503451C5;
	Mon, 18 Aug 2025 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544277; cv=none; b=kqMZkkl71b4JG5mBrZxPu+qk4FckGA2lRyj1PvC/zj1SnB+YXF68lJO0jMPSPUx2nkTX2PX7RhXL6Xc7KpnEjrQVkr1sR0yGm2Z2jurvgDhq3BEK/ey+a3WipljAAFheV3KHiAIrgQUrmJBZ4x7lSyyK22/N1/e8gmQnM7EJnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544277; c=relaxed/simple;
	bh=wYlz82j6Cbpk6lBo6uCSvK+t8eRk1ZIBUDIumfwr+To=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l+TXvl3xwAZSvQucYUpZw194GoorzojTPysZigk7cux29bI/xXJFx6Vymp02M/rtinZ3QJ8dxymuWjaSHabs7mRrtJz5iIwrib6gkLUyWnpLUZ5CuJE6GoHJLAKbXeg/ST7+eZ9ULITHcpBqDP1SuGYQ5nnrWPzXwOOJaH6eItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIEYl0PW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2e8bb2e5so4888799b3a.1;
        Mon, 18 Aug 2025 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755544276; x=1756149076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6dR8XcH6tQZt7nJQ8NRC+Ru2i5Y0hd33oRb5YNkr9og=;
        b=XIEYl0PWp9O7wULIKXmpWFL5n08KsyNLw6qCfldYXo2BLPMwzzParPzSkavF7txfeI
         fz9pDfjSCilBS46JJK+EpuOIEuVo8Lvxef5MoRJI6jtBsYdJ7qicBZcWN2vJpGb7N5Xg
         Z7bJD+80z2IqmDLZ5ma5f1VbkE+9SNd8GSDKbi+TLsSdN9N8xLHk4Paj8xk1IkhTp/Ia
         dlWGU1eEhOzj85UOsjA8QNAsl170gLidPK4Cx2S17u8FK9oi6YUQo5fRhj2zfXKdpubc
         j6EJe8H9P8o9dGKwgiDLCVWSmiCATZBm5nRxkH8IPH2UCPzgECflfXm5ze9yIKpi2HeT
         /j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755544276; x=1756149076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dR8XcH6tQZt7nJQ8NRC+Ru2i5Y0hd33oRb5YNkr9og=;
        b=jgsosBTA9a2YLWzHPiEeyB0iNAljhhHxZntTwyS5w7x21+0dVEqzVZiU+UlCOAq6E5
         sqE9P0PgWyaJFNena9fDvk/V4v2Wy3HuGLlREw182sVgVg4RLfcnzD1RVxvAtY/HTJEZ
         x6u93uQl4fOs3uBnhtbrPPvK/3DAPjpszy+ZOObnDrWEcK2/igQOlzwxiRiUsEfTUhVU
         +DhvcpQY7Q7L9zbar6EdYVIMPYNetFTiCQRqgQrlGAXKWIzKWvzHnCrAQgDrw3SUrV0p
         484I/+e2w+27iqpOVsiL+JlODyBWH01oLGRgJehOqo/mI9vR7PIeWnB1ZF5GWH70UE4e
         EsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxtgFCbq4+TNte/zm12H/7aPZaysQYRHlRRAOUISBnKcvTxYHO+Cxhh5RKjvHIBJinc9cGppxYjffo7MM=@vger.kernel.org, AJvYcCXW0Ab6SgqyGu0rJc43nLcvX1QK36e8L6V7HyHNXtiGRLmMLq7GS7pKCaKRVxA99H1vdWTGBS0/4VDaYhp86EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWO6SYjeb0vvPoWzmx8+4NSZ7qRGhVZi9uAO4w2l2o27lF40j
	Xb+u9L+Hzu7uZx4EqdJGWTOZi+B/5JXOmfAi7yjlAqRt5i3USl4ZFWGSPYLrdqD5KM4=
X-Gm-Gg: ASbGncuv0z0e5na2oNIFOp+P/zBhM0yZsjdwx0nTo8+uL7j6Ya+6xIZfj1apLB8zLAT
	BRwQ+Q63eXsxqOlDI6E8kWKmbNszmFJWsnis85ykrnYXI4JD5FQWFeGF8ACqXr/qIAeekM8kT1V
	fTPHcAzMJgYf3Vlfzo2Zgwq4vrwmV49/q9GKsiHIgLya8W/JqFRFB4XgUdiV0t6NZLyMteUExIA
	2ehj5nrt7tESUBIE31f8yA1JrMCVeyBgw9jwzJh2locPb2yYKkulCNToAtZwcpSNQRoleirXsjh
	F/oc/we8OHUD01HCmfnIw1Meyut6sJRRwNFouddJu7/lHgewup4tHcj8H472iouxI5Fk9szj1tN
	EI+mDMooVFM73nfZTciH0+zYSU2kTMpimmLy9
X-Google-Smtp-Source: AGHT+IEbtba1VyycEvfVIdH4oLjjSM763tT2rFigGQxeSjaYYBS947Vk+8Y11bu3Fz4OhD26nufSmA==
X-Received: by 2002:a05:6a20:7d9e:b0:23f:f99d:462b with SMTP id adf61e73a8af0-240d2f3ba45mr19799339637.41.1755544275665;
        Mon, 18 Aug 2025 12:11:15 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d1b93sm371613b3a.3.2025.08.18.12.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 12:11:15 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH] rust: sync: Update ARef and AlwaysRefCounted imports from sync::aref
Date: Tue, 19 Aug 2025 00:40:34 +0530
Message-Id: <20250818191034.523381-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the in-file reference of sync/aref.rs to import `ARef` and
`AlwaysRefCounted` from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Fixes: 07dad44aa9a93 ("rust: kernel: move ARef and AlwaysRefCounted to sync::aref")
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
This follows the commit [1] which moves ARef and AlwaysRefCounted modules to sync/aref.rs.

Apologies, I had missed out on changing the in-file reference call for the modules. This should fix that.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
---
 rust/kernel/sync/aref.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index dbd77bb68617..c53d42cb0734 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -97,7 +97,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// ```
     /// use core::ptr::NonNull;
-    /// use kernel::types::{ARef, AlwaysRefCounted};
+    /// use kernel::sync::aref::{ARef, AlwaysRefCounted};
     ///
     /// struct Empty {}
     ///

base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
-- 
2.34.1



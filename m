Return-Path: <linux-kernel+bounces-867459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438DDC02B52
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB85189AB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32474347FE4;
	Thu, 23 Oct 2025 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgpth9zE"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08334405E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239772; cv=none; b=c6mnnSPVphrZm1bDonUU3fXD4O4dbdSVdX5b3/5dCQ82nevrBUoReK+P3sG09OZ1q9WTNEabug2qBAtNtvMMBlsR+1G2PzvcfNt5xMzXpJrNE6yay9TwFL+QujdwHQaW75bE9EBZqvpoOmY9CIhQndf7c1UXK4JT/rsL4RkxG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239772; c=relaxed/simple;
	bh=OFXY+MUOP+8Y/CCUUhXO0LVlD5TFWIEKLsX65S4vUHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qga0WGxMasqz4U2bH9ELLjhu8aHsVZw2Qqk6uJzDViz5UdGehONfjeo4Rg7aHKmWoNIY9OHxRWJUeNJRws4ndX1xRnwf1nqTV1ZJyY3aLMFCEiefSdpXFwwxopkW9nJgXTWmZSC+4T+B5VCQ/LIY+2SgrbOY7Bu3rFHJnvcGwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgpth9zE; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87c1a760df5so15079376d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761239770; x=1761844570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jNMd4vA/95M+VKKUUTCyOXkzNHKfGBp1ZY+J8a7Y14=;
        b=kgpth9zEapf2Wc+voLSmj3Rp00KQorTjuN6lu9boN4ZuR5jVcI2nSrc92fNB9XJba+
         LeluDkJm2oQ79XkupNCqWA3J+tXkAnxfBMC3lrMCmTAtyHM+QeO9Zl2NDP9wANoT3917
         yNKSud79l0whsTrfb3mIXcyWGwVV6UNEAGgrzz+AKccvmaPq+yZe/A5QL4eVQ+xHDTp2
         YBM2eIF5ZC3qiGjyL1l8RXEuWb4L7NqzlHVf3Qb49w7LOn1LzG2apGQYCBpc6e7Syf0B
         u/4TobM7HTSBR4iAxKP6EqhIuWaxa0RdB0sM2h9usJMUeDOLlNktxXN7YufroIl+Otgp
         ndpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761239770; x=1761844570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jNMd4vA/95M+VKKUUTCyOXkzNHKfGBp1ZY+J8a7Y14=;
        b=IZFYhehXG3A9L20mY9eyXL5O+X9Ga8T0mgKgAJChVg62ALp5sq6mg+Zj+9GIk4Wldt
         X0GmqpvhSrUp/yl/SThyFokippnh2XeQtKGGYi/rMwfUAN4IXxNZEb30FNJJ4qLzysCE
         TiZoBh96zL8BxV0zpKeX0kTwC9Gbb2q6R4zsWUKWBY+gDGiy9zejcCGlC41v6qY46xj4
         QcyPmz2jaYy6/lshm6GOGYFsIyes/MPA7epwrCs8QjdTdVBv+DjeRVung/puAzj2/GPL
         BAoOp1ChxVdi9LExpAG+LUhyESfnXYb3/gYleuSOPiysDVEd7WmbglNvid8EC+7FvQfi
         mf+w==
X-Forwarded-Encrypted: i=1; AJvYcCU04sCruo/MEMQ6toRZSKALgj3mezID99H28vjRvxEX2EhVKaY5PI6KOc1+rx3seX5ID45WvNWdndw5wfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6eCo/UxnsBIISF+HfEvQP0irqekdyg7ZONUFk+8H9YW2XWI9
	iPx9xCvCuYbgaoZQgBHAtRVUnPj3YE2YFlmzpOLyFBHjFvRIhD5I2zmUU/D2Pg==
X-Gm-Gg: ASbGncsTh+vBVu1MIBMT4rPl5zq84nDeqJbR5AWMII08zL86trm2qab1p3pc9oTVEkK
	+jk9OqWaAhlgnhvSDQ20L11UfTng+BU88u/pfDpE3HwYn0R0nGo9G5yTR3uFUQYbsSNf5P9A58n
	/KMqIQxoqwDRluCwomOG5UT4TOmb8pj4VX+tvC5/SsBa/4CY0ETOBcTrpsWQfA5Mgs/XyF8kVl3
	qmUqO6w6yZt96jBf0j15ZARlOlvqBTK/DliTmuYQFMw7LPtfBEfFB9W873bRZqgi5/QZMOrRXho
	b0Gy30qyk1FozjrMUTHcBXF30+nLID+/Z+zFohpSLjPsSs4kxGq3JIrdLResoXGg1GbqXKWrhJ+
	8qshLOCBMXPRiR8gCSjrdQKDLc5+4XXwtvM/LtvN3Be+zT5isBZOlhcZx6jN0u/Xg74Id76oN
X-Google-Smtp-Source: AGHT+IEztWYoBs06abPB+Ng5TILZNZBwSb7b5djQJWRLRDbxap619QyU24vmkV9lb0CaXbn6mXi9sQ==
X-Received: by 2002:ad4:5ca9:0:b0:796:3a6f:f931 with SMTP id 6a1803df08f44-87c2055e0fcmr324235476d6.12.1761239769652;
        Thu, 23 Oct 2025 10:16:09 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e824cc2sm18692156d6.61.2025.10.23.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:16:09 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	John Hubbard <jhubbard@nvidia.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] uaccess: decouple INLINE_COPY_FROM_USER and CONFIG_RUST
Date: Thu, 23 Oct 2025 13:16:06 -0400
Message-ID: <20251023171607.1171534-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1f9a8286bc0c ("uaccess: always export _copy_[from|to]_user with
CONFIG_RUST") exports _copy_{from,to}_user() unconditionally, if RUST
is enabled. This pollutes exported symbols namespace, and spreads RUST
ifdefery in core files.

It's better to declare a corresponding helper under the rust/helpers,
similarly to how non-underscored copy_{from,to}_user() is handled.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 lib/usercopy.c         |  4 ++--
 rust/helpers/uaccess.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/usercopy.c b/lib/usercopy.c
index 7b17b83c8042..b00a3a957de6 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -12,7 +12,7 @@
 
 /* out-of-line parts */
 
-#if !defined(INLINE_COPY_FROM_USER) || defined(CONFIG_RUST)
+#if !defined(INLINE_COPY_FROM_USER)
 unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	return _inline_copy_from_user(to, from, n);
@@ -20,7 +20,7 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
 EXPORT_SYMBOL(_copy_from_user);
 #endif
 
-#if !defined(INLINE_COPY_TO_USER) || defined(CONFIG_RUST)
+#if !defined(INLINE_COPY_TO_USER)
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	return _inline_copy_to_user(to, from, n);
diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
index f49076f813cd..4629b2d15529 100644
--- a/rust/helpers/uaccess.c
+++ b/rust/helpers/uaccess.c
@@ -13,3 +13,15 @@ unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
 {
 	return copy_to_user(to, from, n);
 }
+
+#ifdef INLINE_COPY_FROM_USER
+unsigned long rust_helper__copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return _inline_copy_from_user(to, from, n);
+}
+
+unsigned long rust_helper__copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return _inline_copy_to_user(to, from, n);
+}
+#endif
-- 
2.43.0



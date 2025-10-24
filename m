Return-Path: <linux-kernel+bounces-869135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D0C0711F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2101C0153B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955BE32E727;
	Fri, 24 Oct 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fkj+vaiz"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B0DDAB
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320879; cv=none; b=Uz4brBQXsOrt3910NPpGeRhnzwzlJiQ3n35qIYkEV7SFYmt6FnPSfzu6rDUYtP3XAD15GpTObwiu9tAARZ4d1QuXW//A7iLazbSDerbs4nRzUH8n9u+njozH2JhsL8YrR+/HjMrU8yB8p3VwI+JNNNcD6qRQ7nriJ8MR7dej6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320879; c=relaxed/simple;
	bh=sL0Xw4aPaeswNFK8xt5yLYh1DDP24VYjPSEke3Engqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftNx3chuvrFLFkP70MxrqRdPRS/PbAyzDeLZ2J4MaV7AOWuRIah877y4/8PJjgVTy/1vuRtOEIIn0VzsfVtEoEb5k1WfLZPB5WWw+gt93vQHuYQo/ttKdCiM+TsqDNWfeoaE7lPjq4o4+cp9cU1buZt6RYtkmx5d0yFnQtkiy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fkj+vaiz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-89c81839de7so113187485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761320877; x=1761925677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c98ABj3xpbRsZfxEiGciTaiLegQtoVpeIJalj1quNRg=;
        b=Fkj+vaizfaLHSaLDaHeYSoP/surjoyihE7S+porh765qkZX6yVkS+BTf9HIpcNXjnT
         aDnnZjMvajkxsF6SVJGAybUqQbsEFxOYqHNuBHXBxplBytvleKOZn9sBicmSiPmQCxUm
         zKHhk0jCAA4cLoRCNae5wWMJBAuHgSkdc8qKRjRrxswmzWpZUpFZidmLtvpCEe9QusiO
         2dD6lDxM3J9/OGPjjQ3MGi0+GKkwn/4501WJMw9kzxytzD/ElMbZp6ngcwf83znXyAs2
         CqSHO82ym5u3O0fQE5pmb/jCm+moSlZ8oo0i9YQDLzfkqUQHUZ5GkPU914vqlrywnVTj
         4bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761320877; x=1761925677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c98ABj3xpbRsZfxEiGciTaiLegQtoVpeIJalj1quNRg=;
        b=COmKaPI3uxW+gcikHd4CPcA1/PMBLbyDhGj7Kl3O+YVZ5HwEKMrGGgsW8Ev6BQwcwG
         /E9aNrzkrfB4441LGFRxElIlvrBcALRvFyXR2tQEqehgGkKF2Z5heTPvB9YMhT18kdWE
         Vcj1/26TPFyAa1H6HZSCSVbAoYl81ZrAO4+JXKGr7UOGZkk2/KLhIvIVmZIgoHqyRSyj
         v6Dh8osHZO3wiDv2Yn3/ET6K5mMkF3BXTJCPxIC4XFdZmADI4BVmiHCIRtGTCYBgZMYf
         sYGG0CQJfzqHxO39A53mbMobeg8Y+9kI6aH4rT3TR/gj/ekK5rCK/RQdZe7mVgAuEUGb
         iUQA==
X-Forwarded-Encrypted: i=1; AJvYcCVSg+5vJcAEROjXdSZkTyzLbULehHSsk0lrQ3ad1K6v/QZTxe29Pm0d8laQRC5hPaWrqeJiiMW8dNfiYG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZxfNwF3LblPRQczT7ZxYkvUx2yGaRa30qvb2cyH7f4hJFXjwx
	VW5cE5VJZOzkv3cJDZDQSLUWnyV4Z/s4+peNnrvNSUFg/rhg1v7Th/Mq
X-Gm-Gg: ASbGncsTVEwI8m77caOHzWcJrM2/4v28VBQH0VVhyU7JCzTexHxsJoQUb7O7xVo5/R/
	wecCg77Ld33H/i7SgnDDaet4G7OTrsIDaPTS3neisRYE7rD4z0Kxh+DJ8O5ohdsj4BWj4o9fLME
	dpUuXJKq9lF+lwm+HDKOLIoYzK0czGAW6AOoQvNHS5rzQHiTgpKga+11Ljdm6s5UeKqMfKN3mh5
	Rf6HSvImRh7cSgSre6saP3jOLVF78VKcvuL7w6aBq9+5se9OJgfzI+es1Kxt2/8Dj3PuzR/z2gI
	oENlxOzKSaPvCuF4iO33N4nwCT/ZNDTkTZW/HHy5SXoFe4UMw7PZ/IydnuTemQ76l8ggjgpoJQY
	9+kze/dxefSLMVQrjlpRxphWk+ipJEuGuI8jElFH94KOg8c3a7Bq7mxGrD/zLqNJbmj4e5aDW
X-Google-Smtp-Source: AGHT+IG5d/Igh2rAxkYnUO/bIk8iyTdOzyYDRKx8eTg9W6J7UzBtWd6Tm9w449auP/7WOH3xkBDGwA==
X-Received: by 2002:a05:620a:440a:b0:892:ac2e:39a0 with SMTP id af79cd13be357-892ac2e414bmr2692499685a.7.1761320877096;
        Fri, 24 Oct 2025 08:47:57 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eb9b8d5adfsm7365831cf.17.2025.10.24.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:47:56 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
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
Subject: [PATCH v2] uaccess: decouple INLINE_COPY_FROM_USER and CONFIG_RUST
Date: Fri, 24 Oct 2025 11:47:53 -0400
Message-ID: <20251024154754.99768-1-yury.norov@gmail.com>
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
v2: drop rust part of comment for _copy_from_user() (Alice)

Andrew,

Can you kindly re-apply?

Thanks,
Yury

 include/linux/uaccess.h |  2 --
 lib/usercopy.c          |  4 ++--
 rust/helpers/uaccess.c  | 12 ++++++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1beb5b395d81..01cbd7dd0ba3 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -152,8 +152,6 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
  * directly in the normal copy_to/from_user(), the other ones go
  * through an extern _copy_to/from_user(), which expands the same code
  * here.
- *
- * rust code always uses the extern definition.
  */
 static inline __must_check unsigned long
 _inline_copy_from_user(void *to, const void __user *from, unsigned long n)
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



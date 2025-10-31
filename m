Return-Path: <linux-kernel+bounces-879975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B481C2488C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2DE1A22C44
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF5344050;
	Fri, 31 Oct 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRoYwdGT"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44B344044
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907197; cv=none; b=m+k0UsQIZO4XyvIDtN92eRWgsQvIYmhlWoWh4i3lPzSfHj+d7DesCjfes4MGpiowQmhH3aGmNUB1MOgS2b/tgRVV7MpMeNYg8vu2D7eVw3v2kjYAVPKhOgva0Qjnf8PgQK9ALwWzJcgQkweMe2f/cbLg2Z/UbQMKmKCRyXjMFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907197; c=relaxed/simple;
	bh=vcLYXmPPWTuVenr60nmlwXYSJ0xbKw2uaxTeUxzt5yA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o6FEyl4EqutopI5uKz2RW8rM4oKDZjxsRH6t8Zsd9DD9CUoU661vIxaUfL8d16/RZ5Ga+Oj7ZEssvCKEyJEpo+KEUIIG6nu2DqvDUI2RodmeMT8vEjCAw6Ld+nlsB5TGcx9jaoiiz3fybCFQCz8R8FNMoNW4fwYShL0Hwp0EVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRoYwdGT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4710d174c31so17264005e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907194; x=1762511994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jLxU3doQ2B67TmmcpJW69nrs7h/yjzsvfGdFS0dWxA=;
        b=GRoYwdGTONhqnV9cDNcDlydHTdCHnO04OirmEKlnZIDt6jGjAZIuWiTEM/8khuRZrB
         ExgfNXHeIkq/oemWm1oX20V2z9KbdOx0u0Xrf78CmBQHO791qWmwgbwLiTGh3NzdkfUQ
         QKQmzjOjh9LwMaeAaGxhGy0jnuKg5LUKcj1XmoRYeZdzxtXQm2xNmd1RM0f6k9zRHKeZ
         9fI5F/HPGZp/pqT0iW44ABlZe5mKAaPEX31kxEYA1psx9ApiCq+ahNYpQr9vBeAYDbEZ
         x90D+0lCHGFfkaX2POLEFEeqtPju9dBF15C4tk40F71zhTnS/v2qEENqTyHcx8FszTag
         +q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907194; x=1762511994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jLxU3doQ2B67TmmcpJW69nrs7h/yjzsvfGdFS0dWxA=;
        b=tiFE6xe3hDOt/fWNbPkoR4TvBzxvmZu3kud7/CyPPkv+UZyLbMzavDzV8/iisldNQy
         N9Aurb7kbgAgRGvF6a2rSlk0Y9u7BY6vLZ4vlkLohMzYtxpxs8C9e6yopr1+Gmmwf3jq
         eU4jBkrux38gKzukQUVWOcb5t4fpeXgHuJzTEJqyote0PfIXmqjOCUwH9SPZgQBziQX4
         aO2JZz5ZPshbdkgbTe6BnoGKWpkPu12wVn7YkUVeeSW4DqXZdDB3tpyXJnZWjrM//XPB
         27E6C+4U2gpjzBoXPRSpvNxJZrXRYiDJAcPuvY9bRnFEZ38jUN18PXpEU8mwrUJDYIjn
         Q/Ng==
X-Gm-Message-State: AOJu0Yw+GOhun1Am7yHAU1yYBZ0e4U+y88zk0+MufOB2+6NeZpAFdxyR
	abEIInaik7aTedZk3Yj/rwi1KkH6kDAaYmtQLGzTQZIEAznqT4NAkl7oB5zIA3QQRVNtb8673A=
	=
X-Google-Smtp-Source: AGHT+IHzKlH+Xpl86AaLume6m7PB2ESbuE972ir2JDi9jrl4y4L+sgCVE3nBwQSicAm7jTR3l5P0IM/v
X-Received: from wmga22.prod.google.com ([2002:a05:600c:2d56:b0:477:d9d:9b35])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6692:b0:45d:d1a3:ba6a
 with SMTP id 5b1f17b1804b1-477308a2814mr22900615e9.33.1761907193988; Fri, 31
 Oct 2025 03:39:53 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:07 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5823; i=ardb@kernel.org;
 h=from:subject; bh=Df6A5JOKcxjoUkwm445+Yocxyxyxk/Xv7orllYDUuOg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4rmeezv/vbyRxyjA/UZKZO6jV6a7BH+Ws/Sobk+d9
 lCNIWtNRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIVQGG/74sD1zNeTrnckxU
 1HlRfTPFeOZKtY2yAa+XTo1WfdHNEcbwP/+38E5zsUTHdy63dme/r7BV8et0s3usIb1mut1q5ZB GBgA=
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-31-ardb+git@google.com>
Subject: [PATCH v4 08/21] lib/crc: Switch ARM and arm64 to 'ksimd' scoped
 guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Before modifying the prototypes of kernel_neon_begin() and
kernel_neon_end() to accommodate kernel mode FP/SIMD state buffers
allocated on the stack, move arm64 to the new 'ksimd' scoped guard API,
which encapsulates the calls to those functions.

For symmetry, do the same for 32-bit ARM too.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 lib/crc/arm/crc-t10dif.h   | 16 +++++-----------
 lib/crc/arm/crc32.h        | 11 ++++-------
 lib/crc/arm64/crc-t10dif.h | 16 +++++-----------
 lib/crc/arm64/crc32.h      | 16 ++++++----------
 4 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/lib/crc/arm/crc-t10dif.h b/lib/crc/arm/crc-t10dif.h
index 63441de5e3f1..aaeeab0defb5 100644
--- a/lib/crc/arm/crc-t10dif.h
+++ b/lib/crc/arm/crc-t10dif.h
@@ -5,7 +5,6 @@
  * Copyright (C) 2016 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
-#include <asm/neon.h>
 #include <asm/simd.h>
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
@@ -20,21 +19,16 @@ asmlinkage void crc_t10dif_pmull8(u16 init_crc, const u8 *buf, size_t len,
 static inline u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
 {
 	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE) {
-		if (static_branch_likely(&have_pmull)) {
-			if (likely(may_use_simd())) {
-				kernel_neon_begin();
-				crc = crc_t10dif_pmull64(crc, data, length);
-				kernel_neon_end();
-				return crc;
-			}
+		if (static_branch_likely(&have_pmull) && likely(may_use_simd())) {
+			scoped_ksimd()
+				return crc_t10dif_pmull64(crc, data, length);
 		} else if (length > CRC_T10DIF_PMULL_CHUNK_SIZE &&
 			   static_branch_likely(&have_neon) &&
 			   likely(may_use_simd())) {
 			u8 buf[16] __aligned(16);
 
-			kernel_neon_begin();
-			crc_t10dif_pmull8(crc, data, length, buf);
-			kernel_neon_end();
+			scoped_ksimd()
+				crc_t10dif_pmull8(crc, data, length, buf);
 
 			return crc_t10dif_generic(0, buf, sizeof(buf));
 		}
diff --git a/lib/crc/arm/crc32.h b/lib/crc/arm/crc32.h
index 7b76f52f6907..f33de6b22cd4 100644
--- a/lib/crc/arm/crc32.h
+++ b/lib/crc/arm/crc32.h
@@ -8,7 +8,6 @@
 #include <linux/cpufeature.h>
 
 #include <asm/hwcap.h>
-#include <asm/neon.h>
 #include <asm/simd.h>
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_crc32);
@@ -42,9 +41,8 @@ static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 			len -= n;
 		}
 		n = round_down(len, 16);
-		kernel_neon_begin();
-		crc = crc32_pmull_le(p, n, crc);
-		kernel_neon_end();
+		scoped_ksimd()
+			crc = crc32_pmull_le(p, n, crc);
 		p += n;
 		len -= n;
 	}
@@ -71,9 +69,8 @@ static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 			len -= n;
 		}
 		n = round_down(len, 16);
-		kernel_neon_begin();
-		crc = crc32c_pmull_le(p, n, crc);
-		kernel_neon_end();
+		scoped_ksimd()
+			crc = crc32c_pmull_le(p, n, crc);
 		p += n;
 		len -= n;
 	}
diff --git a/lib/crc/arm64/crc-t10dif.h b/lib/crc/arm64/crc-t10dif.h
index f88db2971805..0de03ab1aeab 100644
--- a/lib/crc/arm64/crc-t10dif.h
+++ b/lib/crc/arm64/crc-t10dif.h
@@ -7,7 +7,6 @@
 
 #include <linux/cpufeature.h>
 
-#include <asm/neon.h>
 #include <asm/simd.h>
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_asimd);
@@ -22,21 +21,16 @@ asmlinkage u16 crc_t10dif_pmull_p64(u16 init_crc, const u8 *buf, size_t len);
 static inline u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
 {
 	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE) {
-		if (static_branch_likely(&have_pmull)) {
-			if (likely(may_use_simd())) {
-				kernel_neon_begin();
-				crc = crc_t10dif_pmull_p64(crc, data, length);
-				kernel_neon_end();
-				return crc;
-			}
+		if (static_branch_likely(&have_pmull) && likely(may_use_simd())) {
+			scoped_ksimd()
+				return crc_t10dif_pmull_p64(crc, data, length);
 		} else if (length > CRC_T10DIF_PMULL_CHUNK_SIZE &&
 			   static_branch_likely(&have_asimd) &&
 			   likely(may_use_simd())) {
 			u8 buf[16];
 
-			kernel_neon_begin();
-			crc_t10dif_pmull_p8(crc, data, length, buf);
-			kernel_neon_end();
+			scoped_ksimd()
+				crc_t10dif_pmull_p8(crc, data, length, buf);
 
 			return crc_t10dif_generic(0, buf, sizeof(buf));
 		}
diff --git a/lib/crc/arm64/crc32.h b/lib/crc/arm64/crc32.h
index 31e649cd40a2..1939a5dee477 100644
--- a/lib/crc/arm64/crc32.h
+++ b/lib/crc/arm64/crc32.h
@@ -2,7 +2,6 @@
 
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
-#include <asm/neon.h>
 #include <asm/simd.h>
 
 // The minimum input length to consider the 4-way interleaved code path
@@ -23,9 +22,8 @@ static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 
 	if (len >= min_len && cpu_have_named_feature(PMULL) &&
 	    likely(may_use_simd())) {
-		kernel_neon_begin();
-		crc = crc32_le_arm64_4way(crc, p, len);
-		kernel_neon_end();
+		scoped_ksimd()
+			crc = crc32_le_arm64_4way(crc, p, len);
 
 		p += round_down(len, 64);
 		len %= 64;
@@ -44,9 +42,8 @@ static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 
 	if (len >= min_len && cpu_have_named_feature(PMULL) &&
 	    likely(may_use_simd())) {
-		kernel_neon_begin();
-		crc = crc32c_le_arm64_4way(crc, p, len);
-		kernel_neon_end();
+		scoped_ksimd()
+			crc = crc32c_le_arm64_4way(crc, p, len);
 
 		p += round_down(len, 64);
 		len %= 64;
@@ -65,9 +62,8 @@ static inline u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
 
 	if (len >= min_len && cpu_have_named_feature(PMULL) &&
 	    likely(may_use_simd())) {
-		kernel_neon_begin();
-		crc = crc32_be_arm64_4way(crc, p, len);
-		kernel_neon_end();
+		scoped_ksimd()
+			crc = crc32_be_arm64_4way(crc, p, len);
 
 		p += round_down(len, 64);
 		len %= 64;
-- 
2.51.1.930.gacf6e81ea2-goog



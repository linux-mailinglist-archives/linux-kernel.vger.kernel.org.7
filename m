Return-Path: <linux-kernel+bounces-870057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81954C09CCB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AA804F088A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B13314D3B;
	Sat, 25 Oct 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2WTiFvK"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E1C31194C
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410467; cv=none; b=meSEBN+FJWUIdDMDQ0gPbZ2RZHdszE1uV8keC+Bt6gQ5Hx72G4mgKbd33zTtJPDzhztJe3B8gLkp5Ga3CcNexILd7kHJrwEfXh2okVpijT0PcoViFF6zMjUs37DCIqroj3Ux1w4H9o2VZHvEsuhTrf7h14vxRYzQ60nMQOs32SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410467; c=relaxed/simple;
	bh=/FqtaDoZDiEkgJ775gUA1lnv4tNmr3AkN5xeLieFs6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBTPZv01zUDkBa7OYja85OYrx7TWrmaReoplX2rlFLeTMGDcf8WKNvq7zDTzI3dJGcwA62fVjq8z1+atgSR1jJmVugi4riAjudGC+iwPW5Sci/CnhKjmUnXnpNT6Mecebw8WhED3L7ZASHuknViAhI5KHYrG7i3it8cdNG3EERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2WTiFvK; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-89f4779fe03so75715085a.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410464; x=1762015264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSxoEFGAAolVhXFywte18CkthEXwJuFOJ2hIbnLSDSg=;
        b=A2WTiFvKW012MPlO3NSsz7bZsmDUpB6Nz/56w4BEHypZbx7SQKn92AO9AOB9Qx6+Fk
         reoZ7FRasRvyNHfZHlWOXe5VkqN8xrMqno0Hh/JJwIjGnYwxtRUGGp4ho2/URhj6C28R
         hdthsQBgyYZiVoy+PRQ6rVDKV8yA4wYKMDeRHySs4pK/mzMDEtkHXn+5IYng3YgH1m32
         Xk6pWoWqgc/ztYxOooIotks+csnOxuPAcvd5YTebUIACaqQ/FJLwe2P6muPFYgWKOjB9
         cDXeAumq10/VBsAqbWvzIh/ix2HXQXs2oMlddvbzs6ust0By7NviIvIG85oDMKwlzqKh
         zd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410464; x=1762015264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSxoEFGAAolVhXFywte18CkthEXwJuFOJ2hIbnLSDSg=;
        b=urSzhBTUbAoHZcfreQKJvDlfMDcEoWu45DzerBKPnocPRU5TogDlGNhSyi/p3GSnN9
         OmNCW+yxAGhkxBFX6+jRwF8BM6srF4v0Wj8N2GCwzFSlfSgmKKx3nrputLqvqoKuSzZA
         0BMmKFJUo5nXyhhqT0kYghZJgyO9TfqYdo4Vx02MKkUr1urkoMh5DCKsllS9buylAv0q
         x1jowoFZY7x4VB+0Rbu2uQMiwAWgAB36wMXYohpI8c7Lzw4ifSehi/MgOMBrFNEQcf2Z
         MPwA3cAmu13nW7WoEN7JGo0DeJRF4Pn7GKBVPeQ3yrlF3bQKHcthBMGphV8V2UWkcQOq
         9SVw==
X-Forwarded-Encrypted: i=1; AJvYcCX+ibSAtjC4xcla2q5hcZrMZ+yJvI2Q7RX6KmR4sAGo1Nm/05Rl2oR3tPct6A5RGoMyfzt3ARjVcZ6/ZUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYCpVNWc3XM7gNKGGQXfjQdTncYpIodLc0EiBg+QrU5n8pIun2
	0h9OkJjKRsgljKcUGFPykuLY1EUhU0hsXK8+8MiZhW3pu7/LTxSx6fQN
X-Gm-Gg: ASbGncvSIbytmuN/bT7dgXE5lG5wio2OquGXBL2vJ6wwnG5psLbfekOipvBe9XqSotk
	Wt0m5fQyNtDUIcCQ2IW6msFXPq37A5Ok1E09OAUjYpzcTs/Ukoh5IgZn1buVnFrz2Iot/A3hXCD
	NzBRnPmDBYt/MCmxlHR+mhaxXl5bcCZCGsjGf0nOBcTXOe/HIQUsP/5QrY0iwm6avF+4FIGQOsi
	jbya1yyu00yimA6rWsncCK0q+AS1/Gx6tlYHBm87fn+WOMpNK+5CJglOBiTqROQh0qeA/pTeANP
	nqAuD3gN4H7w83cra4SBU0k7w/GyTcUcYZVxR1ShUfmTGiYZyx7qPfp2+qcqiDVK3jmh7GtCHDY
	n0UyRq2rYcyHZFBJoEeMiDspc8gq0eB7c+4ixQJKJrPxiM/tKyYIjcRP+3Mesv+aH4rHA9AkWg5
	RcqKdzNUk=
X-Google-Smtp-Source: AGHT+IEJ+VGIE9njWqp738nyLBuC4v8CoidtGMfLmNNjfj41Zy6EVk/dYE8QJdM3J56MYC03DWdagw==
X-Received: by 2002:a05:620a:2990:b0:829:b669:c791 with SMTP id af79cd13be357-890712b8ca4mr3696698185a.78.1761410464404;
        Sat, 25 Oct 2025 09:41:04 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f262716efsm172607385a.59.2025.10.25.09.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:03 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/21] bitmap: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:11 -0400
Message-ID: <20251025164023.308884-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. Switch to a more natural
BITS(low, high) mask generator, or FIRST/LAST_BITS() as appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/bitmap.h |  4 ++--
 include/linux/find.h   | 34 +++++++++++++++++-----------------
 lib/bitmap.c           |  2 +-
 lib/test_bitmap.c      | 14 +++++++-------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index fbe2d12bceab..3bed29f1780b 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -473,7 +473,7 @@ void bitmap_set(unsigned long *map, unsigned int start, unsigned int nbits)
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__set_bit(start, map);
 	else if (small_const_nbits(start + nbits))
-		*map |= GENMASK(start + nbits - 1, start);
+		*map |= BITS(start, start + nbits - 1);
 	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
@@ -489,7 +489,7 @@ void bitmap_clear(unsigned long *map, unsigned int start, unsigned int nbits)
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__clear_bit(start, map);
 	else if (small_const_nbits(start + nbits))
-		*map &= ~GENMASK(start + nbits - 1, start);
+		*map &= ~BITS(start, start + nbits - 1);
 	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
diff --git a/include/linux/find.h b/include/linux/find.h
index 9d720ad92bc1..24d7266fd02b 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -66,7 +66,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr & GENMASK(size - 1, offset);
+		val = *addr & BITS(offset, size - 1);
 		return val ? __ffs(val) : size;
 	}
 
@@ -96,7 +96,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr1 & *addr2 & GENMASK(size - 1, offset);
+		val = *addr1 & *addr2 & BITS(offset, size - 1);
 		return val ? __ffs(val) : size;
 	}
 
@@ -127,7 +127,7 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr1 & ~*addr2 & GENMASK(size - 1, offset);
+		val = *addr1 & ~*addr2 & BITS(offset, size - 1);
 		return val ? __ffs(val) : size;
 	}
 
@@ -157,7 +157,7 @@ unsigned long find_next_or_bit(const unsigned long *addr1,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = (*addr1 | *addr2) & GENMASK(size - 1, offset);
+		val = (*addr1 | *addr2) & BITS(offset, size - 1);
 		return val ? __ffs(val) : size;
 	}
 
@@ -185,7 +185,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr | ~GENMASK(size - 1, offset);
+		val = *addr | ~BITS(offset, size - 1);
 		return val == ~0UL ? size : ffz(val);
 	}
 
@@ -206,7 +206,7 @@ static __always_inline
 unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr & GENMASK(size - 1, 0);
+		unsigned long val = *addr & FIRST_BITS(size);
 
 		return val ? __ffs(val) : size;
 	}
@@ -235,7 +235,7 @@ unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsign
 		return size;
 
 	if (small_const_nbits(size)) {
-		unsigned long val =  *addr & GENMASK(size - 1, 0);
+		unsigned long val =  *addr & FIRST_BITS(size);
 
 		return val ? fns(val, n) : size;
 	}
@@ -261,7 +261,7 @@ unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *
 		return size;
 
 	if (small_const_nbits(size)) {
-		unsigned long val =  *addr1 & *addr2 & GENMASK(size - 1, 0);
+		unsigned long val =  *addr1 & *addr2 & FIRST_BITS(size);
 
 		return val ? fns(val, n) : size;
 	}
@@ -291,7 +291,7 @@ unsigned long find_nth_and_andnot_bit(const unsigned long *addr1,
 		return size;
 
 	if (small_const_nbits(size)) {
-		unsigned long val =  *addr1 & *addr2 & (~*addr3) & GENMASK(size - 1, 0);
+		unsigned long val =  *addr1 & *addr2 & (~*addr3) & FIRST_BITS(size);
 
 		return val ? fns(val, n) : size;
 	}
@@ -315,7 +315,7 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 				 unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
+		unsigned long val = *addr1 & *addr2 & FIRST_BITS(size);
 
 		return val ? __ffs(val) : size;
 	}
@@ -339,7 +339,7 @@ unsigned long find_first_andnot_bit(const unsigned long *addr1,
 				 unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr1 & (~*addr2) & GENMASK(size - 1, 0);
+		unsigned long val = *addr1 & (~*addr2) & FIRST_BITS(size);
 
 		return val ? __ffs(val) : size;
 	}
@@ -364,7 +364,7 @@ unsigned long find_first_and_and_bit(const unsigned long *addr1,
 				     unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr1 & *addr2 & *addr3 & GENMASK(size - 1, 0);
+		unsigned long val = *addr1 & *addr2 & *addr3 & FIRST_BITS(size);
 
 		return val ? __ffs(val) : size;
 	}
@@ -385,7 +385,7 @@ static __always_inline
 unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr | ~GENMASK(size - 1, 0);
+		unsigned long val = *addr | ~FIRST_BITS(size);
 
 		return val == ~0UL ? size : ffz(val);
 	}
@@ -406,7 +406,7 @@ static __always_inline
 unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr & GENMASK(size - 1, 0);
+		unsigned long val = *addr & FIRST_BITS(size);
 
 		return val ? __fls(val) : size;
 	}
@@ -537,7 +537,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		if (unlikely(offset >= size))
 			return size;
 
-		val = swab(val) | ~GENMASK(size - 1, offset);
+		val = swab(val) | ~BITS(offset, size - 1);
 		return val == ~0UL ? size : ffz(val);
 	}
 
@@ -550,7 +550,7 @@ static __always_inline
 unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = swab(*(const unsigned long *)addr) | ~GENMASK(size - 1, 0);
+		unsigned long val = swab(*(const unsigned long *)addr) | ~FIRST_BITS(size);
 
 		return val == ~0UL ? size : ffz(val);
 	}
@@ -570,7 +570,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 		if (unlikely(offset >= size))
 			return size;
 
-		val = swab(val) & GENMASK(size - 1, offset);
+		val = swab(val) & BITS(offset, size - 1);
 		return val ? __ffs(val) : size;
 	}
 
diff --git a/lib/bitmap.c b/lib/bitmap.c
index b97692854966..ec11cc36624e 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -876,7 +876,7 @@ void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits)
 
 	/* Clear tail bits in the last element of array beyond nbits. */
 	if (nbits % 64)
-		buf[-1] &= GENMASK_ULL((nbits - 1) % 64, 0);
+		buf[-1] &= FIRST_BITS_ULL(nbits);
 }
 EXPORT_SYMBOL(bitmap_to_arr64);
 #endif
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index c83829ef557f..c198fc7a66d2 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -692,10 +692,10 @@ static void __init test_bitmap_arr64(void)
 		}
 
 		if ((nbits % 64) &&
-		    (arr[(nbits - 1) / 64] & ~GENMASK_ULL((nbits - 1) % 64, 0))) {
+		    (arr[(nbits - 1) / 64] & ~FIRST_BITS_ULL(nbits))) {
 			pr_err("bitmap_to_arr64(nbits == %d): tail is not safely cleared: 0x%016llx (must be 0x%016llx)\n",
 			       nbits, arr[(nbits - 1) / 64],
-			       GENMASK_ULL((nbits - 1) % 64, 0));
+			       FIRST_BITS_ULL(nbits));
 			failed_tests++;
 		}
 
@@ -1217,7 +1217,7 @@ static void __init test_bitmap_const_eval(void)
 	 * in runtime.
 	 */
 
-	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
+	/* Equals to `unsigned long bitmap[1] = { BITS(5, 6), }` */
 	bitmap_clear(bitmap, 0, BITS_PER_LONG);
 	if (!test_bit(7, bitmap))
 		bitmap_set(bitmap, 5, 2);
@@ -1229,9 +1229,9 @@ static void __init test_bitmap_const_eval(void)
 	/* Equals to `unsigned long var = BIT(25)` */
 	var |= BIT(25);
 	if (var & BIT(0))
-		var ^= GENMASK(9, 6);
+		var ^= BITS(6, 9);
 
-	/* __const_hweight<32|64>(GENMASK(6, 5)) == 2 */
+	/* __const_hweight<32|64>(BITS(5, 6)) == 2 */
 	res = bitmap_weight(bitmap, 20);
 	BUILD_BUG_ON(!__builtin_constant_p(res));
 	BUILD_BUG_ON(res != 2);
@@ -1241,8 +1241,8 @@ static void __init test_bitmap_const_eval(void)
 	BUILD_BUG_ON(!__builtin_constant_p(res));
 	BUILD_BUG_ON(!res);
 
-	/* BIT(2) & GENMASK(14, 8) == 0 */
-	res = initvar & GENMASK(14, 8);
+	/* BIT(2) & BITS(8, 14) == 0 */
+	res = initvar & BITS(8, 14);
 	BUILD_BUG_ON(!__builtin_constant_p(res));
 	BUILD_BUG_ON(res);
 
-- 
2.43.0



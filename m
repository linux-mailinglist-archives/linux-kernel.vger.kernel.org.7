Return-Path: <linux-kernel+bounces-870033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE473C09B60
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECAA1C8021D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4F30DD36;
	Sat, 25 Oct 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2dLhgpi"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63730ACE1
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410005; cv=none; b=GSZEJ/u2ZMSZxPZOszOb6kQG5nPAm8PH0NByEE1vxiTJFv7TzopvrGB+AY20gudq51emoIx5/reFXa4tVKsN6rpJE0CVErNXQ35ghmF6Lp2Q+/DBzA6ZAHQcyS53gao7RVOj2zqsbY9GmwG3kLHw9RFPevlKH+RqQVwsQuLw7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410005; c=relaxed/simple;
	bh=/FqtaDoZDiEkgJ775gUA1lnv4tNmr3AkN5xeLieFs6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9RMlC6Nn3/8y4TLdhdAMvpHfhc/ySVFbAIzPeizDShjcn3apitceLGD3NL2iHu9XvbobGYVvhoBdOZDvECdyyp/cECq9bpPLx0bljMzm34JjFrlzd0e/ykCMsmcMFX0KQVb7xCAJVwIyLQZr0R4few0W8QvKaMaKcr/FvMd3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2dLhgpi; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4e3117ea7a2so36144441cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410000; x=1762014800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSxoEFGAAolVhXFywte18CkthEXwJuFOJ2hIbnLSDSg=;
        b=d2dLhgpik+l7LTkQEQ+GQEuerIDG704GlZnNJiYr5Lltuvmu6ClmZ0i49K7lVePRjb
         yYOrB6ELEk5fsBbgTvnFXDQOql+60pWyQIqVh13mN1xoBdaNMWLUWXraLyoCIbOwP9+B
         zcYBaGe04CllApiUTNtZJYrTl3AvtdegUqh5nY2JHpE36NElmiz8QFXg6T9Q98pkpi/h
         1dU3WoMPsgJpl0jAFfEuTQ7+hwLjQv2Ssc5HZ1MEk6/6Y5w6B3f9wsZRBoVBuZIamsKo
         1Pge2MeDO8g4xgal7zcQA5gasssL+qQCe/uu2sNSN7nwW7iuB4qakoE42+NsPO9kcDw6
         YbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410000; x=1762014800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSxoEFGAAolVhXFywte18CkthEXwJuFOJ2hIbnLSDSg=;
        b=f+9NFF1WH49mQdtUXHAtA8iaeZyia7lzPsAEGZ5d3WttRYDLAQoY2Jj08kU9SXdXIm
         4hFPcAY0a6q17j1jWmmqjksy0JFCiIIZO9dC/E0pVrDUb/G3zx2HQbw9aWp3AaL7/YFo
         yBVOIoHuwFuWANSn176aE+FRc/ygAaMsmwW4X1FZkkQXvu0Jfka29itDYGZLyu4hwIxY
         fsUd1bsCIYWKMtgI9Ak02/tGg1Y0zPe4bogUxXDIMzm6XmvbqfOJ/rSke1a4qLV0hl1j
         0AJHw2a627QEGMhVYnp1os+YzNHBe3n5F67vB2Gj728L+CmaxspDZsJGrr/ngmW+kGu/
         HeBw==
X-Forwarded-Encrypted: i=1; AJvYcCVUgqXMIFDv5tWzNPorP262Y+5bQaTn5AyvfdA2fsdZIZh0By/fBtQ+3JkISrOzIGRDZdbE42VlihTkbCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxzGHirA11JwTFTiDdEcjBDoucmvxStF8BEF9TnB01yB/G+z/K
	iIQJ/0w94SorTUiUtuZmiaqzyj9Lgdy6RxqzSeaQPHTtNqXCaiZCflrH
X-Gm-Gg: ASbGnct/7lOxce5i4lUIvNGdASoKx5T5Mf8lk1aMIlKLhHQZlH2kmyUTCtpC7Z9cHFf
	V1zrbrlR7r0Tqd1R6jN95bn+W0rDYvHId3da3w8CyAw4+HhG3jli1EaBqUKopnx69H607MPzfn3
	N1y0A1IEHAHmEFVXFkT/sVPE7PFcQ/m7IwqiVO5pPEsmZiqDnKIce8xXaV2yNWSbjlhDykDcrAn
	Nf9ogSOPaUHPC6h35Y6Wu6lpRytrdWoQ1JFHevfBWzrfUc8LeUx/M4Fmig/pGDoy15+19b+EIY4
	r6RfiCkUMs8hXvlvW+qnB2SZm+Nm3s5vqphTg15HKARb86qRhDkqZPncR0j9PTyrhAsAdJ/YPuX
	6hxZ+xrMMagFZlrQA+h9vCa8PD+ZviJ7vOoAg6GMK0k+en/IYN4KZDqYYNYLUKr8gHqhvWFGv
X-Google-Smtp-Source: AGHT+IFwY9Y3BAwsQLIpG2h0HJ31eBt8/+nMYp6HoC42JMSxN357FYrFvS1io5FJ90lWGu4fEjCzyg==
X-Received: by 2002:a05:622a:4d48:b0:4eb:a915:c213 with SMTP id d75a77b69052e-4eba915c5a0mr20033121cf.65.1761410000104;
        Sat, 25 Oct 2025 09:33:20 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48ca5bcsm16552366d6.13.2025.10.25.09.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:19 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 12/21] bitmap: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:32:54 -0400
Message-ID: <20251025163305.306787-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
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



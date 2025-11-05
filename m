Return-Path: <linux-kernel+bounces-887246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B910EC37A57
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA573A1032
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A3D34B662;
	Wed,  5 Nov 2025 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4rUUjaU"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C9347BBE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373461; cv=none; b=G5emPpadDmuTKrQPckr7xp6p8Jt93s1zB8J1bK5MVx44FPxuH+O8vaMJ8yM822zhf1i8BYR1wUNGEAynDfVOygDEWPPitbniIZhwXmSbyfIxoHbiGhj7064kVDXhclIpIuAwHPTfWmj1ilk1YUdLZaxTXS3nfN5lHq0D5U/9a0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373461; c=relaxed/simple;
	bh=mDaZKjqXz4ljxzmOjQjNiJfdKq/E8XB6DbTrYhSWAXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAUd+CgBFVXZg4fynloI7glgpsdwVir83nu15NFVlHnPtW1lWfPOaoSLOHYcFp46AV5QSacgFd8FMwFoxLAsIA3YlL28Gmam8UOZxI0/6u+TTe5BhAW9jWMNDO7eNNVbbDRj8jNzR4QbEHVl1wX8Z88HdoyGnGeJyvJoE/Tj9mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4rUUjaU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42557c5cedcso159225f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373457; x=1762978257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGQCHSX+VBuD1rwvjJ6Wh0BG1UvLo9/YmQdrfi1ZSTU=;
        b=E4rUUjaUjef8YEHFaLxYsO7yRs5zOCtLwqhJuN8K0SlmaEUeEFUXddUVoMvglNN9ZA
         zauk1wasQJRKtJQ8PM2FPJ9NHpWWRmHnSAaAJhWIaZxtFQjDWIsllPy0BdxJanB6rnNb
         j2Pf3FT3xmT1eiUmg3ezHghInZL8DwKyjES/q29urrxnemVAqHOQe/iiuV+/4EoUOr68
         Yj91tV/7BxjTDOePcfETiraUzDu64AWXldgMiIWjP0iYEFJ3x4RCpdLK8vNdmbR2JOr8
         Er7c94G8IjPXMw7SbUB9DM1KUiCweiVEPwUcb0g1cwnNQE9rAAhC8+Oj/0Cra1i0/B+N
         lK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373457; x=1762978257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGQCHSX+VBuD1rwvjJ6Wh0BG1UvLo9/YmQdrfi1ZSTU=;
        b=qSit2TYDpdPl2eA5yoiyQ6gwGfUeSURkVX0/Yr+phZc8T8SBkRDJG5h37vdNHmbufZ
         T7XDEAqmTxOufBhCuJWFU2IeyL0YiseF2Hq6nUrIcUq46mNIUBzQWQLLPZJJSV7XDPBi
         sVxfOwGYjN5yzcWihOokYanHtM9gltCXD9OtTtVwZZ4dIAE0c3DKTPeYKSqetPppI3e2
         q7SypdqSOwIBGx/mVhxIsf1rKvb6QxM/ivUTClZMmi0BeZvFnFBjGgATufAuqkfbbEQb
         clIMl3KWmwSfDtGNnkEchGitneim85iQJCpWEKAfVNxKrx9uYtJP33C4Zb3WDTb12uay
         Sm5A==
X-Forwarded-Encrypted: i=1; AJvYcCUXcHpw0YuzUDRCKwrGbkaO8gvdx0x6kndf4ujqDJr+03kqWhXIdCE5H/1hpyJbmXjVWEXTolLaU3w9pjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLfjYvubrxAHXVKjXOAeZVPeeFYIxKOCHBGj1x1pwLOCmBdUE
	Sl96OTpiZClad1aY2OFxBjKztRK85v0Qgo3+TdojSiJMbdJuoneyunec
X-Gm-Gg: ASbGncvQsO/kO8asJFoO93jqPQmA/WnM60BBL9uKEHUf34LDYPo4WvQuv+hdZb2e3Q7
	yAEclSiY/cUXzmXndDxyMF4Nsw44FAYkjGJNShVFjflHce4Joonu8zplhm2sGGuVNxMI+q2NFDU
	cDrvbnIdVtjk6VoK3r6cMFo6o6jlPdScA4NcQHrdPHRgLrwRp/LKgW+KnfTjYU9z7mZPs9NSDQN
	SMy/0s+yZhVWc0pkUgx5dNyBSbmXQiW67a+sIZItQTBKgcwRZSpDGUQlE1DE4il43FHjI5yRbkj
	5DejWQQXdu4NlpsPDMgLX1DfN5wxjeLODp5W6BnsSA7W4yhW+usJrgNi9lbA088/WDS+BVNSVoa
	qb7IbPM0GdzMBJP15c5ZG5b195k21eR9sQGpNzKEiHYqsAfbQAnmAReaRAuTD6t4ru7pRG6yf3R
	u9OR9H/iu2OzPHy8RD7QMYoWiNOFlsXfkIayUu6MEIs5vpm3cS1YH7GYi81mxgu/uolYKIwH80
X-Google-Smtp-Source: AGHT+IHEC6a0tb0CmYj1fixrjFAg0hcYGOZWGSCeLDUOu/kqJ+eVN76eroHUy1G9kEWbbuy8Nw3iWQ==
X-Received: by 2002:a05:6000:4304:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-429e32e17c1mr3926274f8f.14.1762373457246;
        Wed, 05 Nov 2025 12:10:57 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm619857f8f.17.2025.11.05.12.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:10:57 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	u.kleine-koenig@baylibre.com,
	Nicolas Pitre <npitre@baylibre.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Li RongQing <lirongqing@baidu.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org
Subject: [PATCH v5 next 8/9] lib: mul_u64_u64_div_u64() Optimise the divide code
Date: Wed,  5 Nov 2025 20:10:34 +0000
Message-Id: <20251105201035.64043-9-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105201035.64043-1-david.laight.linux@gmail.com>
References: <20251105201035.64043-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the bit by bit algorithm with one that generates 16 bits
per iteration on 32bit architectures and 32 bits on 64bit ones.

On my zen 5 this reduces the time for the tests (using the generic
code) from ~3350ns to ~1000ns.

Running the 32bit algorithm on 64bit x86 takes ~1500ns.
It'll be slightly slower on a real 32bit system, mostly due
to register pressure.

The savings for 32bit x86 are much higher (tested in userspace).
The worst case (lots of bits in the quotient) drops from ~900 clocks
to ~130 (pretty much independant of the arguments).
Other 32bit architectures may see better savings.

It is possibly to optimise for divisors that span less than
__LONG_WIDTH__/2 bits. However I suspect they don't happen that often
and it doesn't remove any slow cpu divide instructions which dominate
the result.

Typical improvements for 64bit random divides:
               old     new
sandy bridge:  470     150
haswell:       400     144
piledriver:    960     467   I think rdpmc is very slow.
zen5:          244      80
(Timing is 'rdpmc; mul_div(); rdpmc' with the multiply depending on the
first rdpmc and the second rdpmc depending on the quotient.)

Object code (64bit x86 test program): old 0x173 new 0x141.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
---

Algorithm unchanged since v3.

 lib/math/div64.c | 124 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 39 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index bb57a48ce36a..d1e92ea24fce 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -190,7 +190,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
 #define mul_add(a, b, c) add_u64_u32(mul_u32_u32(a, b), c)
 
 #if defined(__SIZEOF_INT128__) && !defined(test_mul_u64_add_u64_div_u64)
-
 static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
 {
 	/* native 64x64=128 bits multiplication */
@@ -199,9 +198,7 @@ static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
 	*p_lo = prod;
 	return prod >> 64;
 }
-
 #else
-
 static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
 {
 	/* perform a 64x64=128 bits multiplication in 32bit chunks */
@@ -216,12 +213,37 @@ static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
 	*p_lo = (y << 32) + (u32)x;
 	return add_u64_u32(z, y >> 32);
 }
+#endif
+
+#ifndef BITS_PER_ITER
+#define BITS_PER_ITER (__LONG_WIDTH__ >= 64 ? 32 : 16)
+#endif
+
+#if BITS_PER_ITER == 32
+#define mul_u64_long_add_u64(p_lo, a, b, c) mul_u64_u64_add_u64(p_lo, a, b, c)
+#define add_u64_long(a, b) ((a) + (b))
+#else
+#undef BITS_PER_ITER
+#define BITS_PER_ITER 16
+static inline u32 mul_u64_long_add_u64(u64 *p_lo, u64 a, u32 b, u64 c)
+{
+	u64 n_lo = mul_add(a, b, c);
+	u64 n_med = mul_add(a >> 32, b, c >> 32);
+
+	n_med = add_u64_u32(n_med, n_lo >> 32);
+	*p_lo = n_med << 32 | (u32)n_lo;
+	return n_med >> 32;
+}
 
+#define add_u64_long(a, b) add_u64_u32(a, b)
 #endif
 
 u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
 {
-	u64 n_lo, n_hi;
+	unsigned long d_msig, q_digit;
+	unsigned int reps, d_z_hi;
+	u64 quotient, n_lo, n_hi;
+	u32 overflow;
 
 	n_hi = mul_u64_u64_add_u64(&n_lo, a, b, c);
 
@@ -240,46 +262,70 @@ u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
 		return ~0ULL;
 	}
 
-	int shift = __builtin_ctzll(d);
-
-	/* try reducing the fraction in case the dividend becomes <= 64 bits */
-	if ((n_hi >> shift) == 0) {
-		u64 n = shift ? (n_lo >> shift) | (n_hi << (64 - shift)) : n_lo;
-
-		return div64_u64(n, d >> shift);
-		/*
-		 * The remainder value if needed would be:
-		 *   res = div64_u64_rem(n, d >> shift, &rem);
-		 *   rem = (rem << shift) + (n_lo - (n << shift));
-		 */
+	/* Left align the divisor, shifting the dividend to match */
+	d_z_hi = __builtin_clzll(d);
+	if (d_z_hi) {
+		d <<= d_z_hi;
+		n_hi = n_hi << d_z_hi | n_lo >> (64 - d_z_hi);
+		n_lo <<= d_z_hi;
 	}
 
-	/* Do the full 128 by 64 bits division */
-
-	shift = __builtin_clzll(d);
-	d <<= shift;
-
-	int p = 64 + shift;
-	u64 res = 0;
-	bool carry;
+	reps = 64 / BITS_PER_ITER;
+	/* Optimise loop count for small dividends */
+	if (!(u32)(n_hi >> 32)) {
+		reps -= 32 / BITS_PER_ITER;
+		n_hi = n_hi << 32 | n_lo >> 32;
+		n_lo <<= 32;
+	}
+#if BITS_PER_ITER == 16
+	if (!(u32)(n_hi >> 48)) {
+		reps--;
+		n_hi = add_u64_u32(n_hi << 16, n_lo >> 48);
+		n_lo <<= 16;
+	}
+#endif
 
-	do {
-		carry = n_hi >> 63;
-		shift = carry ? 1 : __builtin_clzll(n_hi);
-		if (p < shift)
-			break;
-		p -= shift;
-		n_hi <<= shift;
-		n_hi |= n_lo >> (64 - shift);
-		n_lo <<= shift;
-		if (carry || (n_hi >= d)) {
-			n_hi -= d;
-			res |= 1ULL << p;
+	/* Invert the dividend so we can use add instead of subtract. */
+	n_lo = ~n_lo;
+	n_hi = ~n_hi;
+
+	/*
+	 * Get the most significant BITS_PER_ITER bits of the divisor.
+	 * This is used to get a low 'guestimate' of the quotient digit.
+	 */
+	d_msig = (d >> (64 - BITS_PER_ITER)) + 1;
+
+	/*
+	 * Now do a 'long division' with BITS_PER_ITER bit 'digits'.
+	 * The 'guess' quotient digit can be low and BITS_PER_ITER+1 bits.
+	 * The worst case is dividing ~0 by 0x8000 which requires two subtracts.
+	 */
+	quotient = 0;
+	while (reps--) {
+		q_digit = (unsigned long)(~n_hi >> (64 - 2 * BITS_PER_ITER)) / d_msig;
+		/* Shift 'n' left to align with the product q_digit * d */
+		overflow = n_hi >> (64 - BITS_PER_ITER);
+		n_hi = add_u64_u32(n_hi << BITS_PER_ITER, n_lo >> (64 - BITS_PER_ITER));
+		n_lo <<= BITS_PER_ITER;
+		/* Add product to negated divisor */
+		overflow += mul_u64_long_add_u64(&n_hi, d, q_digit, n_hi);
+		/* Adjust for the q_digit 'guestimate' being low */
+		while (overflow < 0xffffffff >> (32 - BITS_PER_ITER)) {
+			q_digit++;
+			n_hi += d;
+			overflow += n_hi < d;
 		}
-	} while (n_hi);
-	/* The remainder value if needed would be n_hi << p */
+		quotient = add_u64_long(quotient << BITS_PER_ITER, q_digit);
+	}
 
-	return res;
+	/*
+	 * The above only ensures the remainder doesn't overflow,
+	 * it can still be possible to add (aka subtract) another copy
+	 * of the divisor.
+	 */
+	if ((n_hi + d) > n_hi)
+		quotient++;
+	return quotient;
 }
 #if !defined(test_mul_u64_add_u64_div_u64)
 EXPORT_SYMBOL(mul_u64_add_u64_div_u64);
-- 
2.39.5



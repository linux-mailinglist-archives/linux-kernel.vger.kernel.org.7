Return-Path: <linux-kernel+bounces-876850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39940C1C89E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A185D4E5A03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D33559F4;
	Wed, 29 Oct 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jokPCtqR"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4E354ADA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759563; cv=none; b=geIgO4II2wQsrE9VCoCjElQE0l4Hu+GC6pYT+LkeRNNyJre/rcYJ7EY/5czcgaeFCX4f2kh919F1pgmfFfr8cD0Lj5dtOm/N+OB/149J13OlCic4hiDonxmSaBgZ0jXDxA8tw3dLaJnyiy9ykfD3oA4lPs7YrNfqMz3+iijcafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759563; c=relaxed/simple;
	bh=lGdJFEw9ZrLRN8+wHLowhZQJmVyVzgrAF4ZGEKbDKpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CBzF3rIV0jVDWrN4CBnJLOiiOc/c5GzoBDoydvbB60+hKk3IWpj7k+JfPtWjtv9LrpbSMS7IzXL1qd2U/oh7CX65+5Ac543S09++s7mHNs/fCObFjwTBZLFVpWgb8aS39Ck0OryBvehYlnoP33ore9t1RlBGhVq2b/vuFnKRL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jokPCtqR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so608725e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759559; x=1762364359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4k8wTMJbnOldNXby8wSilNtSncUAyWpauPZkY67AaQ=;
        b=jokPCtqR/h15eEyN/nugtkfwpS2I2tvc+rwuFNw5JAvwVM7D/SLSNGlhfyShWXwEhn
         4cEWGc3Oz1Rv0hdPxPQ0YLi9/kAfHQpoAQyIgE9Xx31JDMSQrJnouSXcPGcPLm7kE59u
         vx8iEBbCGtrETzDr7ihzuD0rGd6N1qle4f5qhySb1j0tHOmoF1+kn/Svr0fEBZSFGJzS
         WB7iKU+lVXooYde40y3yGvZbJEfDkE+WTfaMdhqruyG7cvzdwvbUxN2iLhOhiVzgZpEX
         dBkU9gFMfVPbsoODO6q881hhtqPx6dTVVVLRERVjDDMIewN/4EnS69MluShQql46wvSr
         O3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759559; x=1762364359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4k8wTMJbnOldNXby8wSilNtSncUAyWpauPZkY67AaQ=;
        b=TR1Vkd4GPhudob2tggP9/RhZ5uCIOBM7lsFV4aGbT7ZTwJ+nqUy54w6Q4+ZkYLKBgb
         zJDlKCrStPQcQ95BrtuZJZ/EtRfYUzT8mUQzW+UZA5/MUsYNNkt1k7fnoC99fpa0NT6X
         2lqsoGvg3asw0NVo6MZw0BkcDCkonhuT8j+tDvWMn0azNd8V305gUrlvJ2yPUh+C0Pzr
         EEwWZGbvuYvaAfCLDZctzVf0EHZOjHcsBXEnADcBNqOfvSjIrrGexgLfntnTSmtkTEmB
         v8Skg+DA4yRTypbnOLtBAGOYwdsSkZE+K1NQ7nD5mc/rlVRWcREkCwJW1NHWN8VaoOvx
         whFg==
X-Forwarded-Encrypted: i=1; AJvYcCUDte1/XLRaFjbyc0Rr1jF/cNsXGa6eis/IpqUNh3bjJWgcQVo8Zk1XIhMJTC4CEbKZLS8EhCJQMxJb1Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDrRtxx49XS89gD18Al33lpJjaTsw2jyDrpSq3VS0PUgkc6fX
	fTZ53F4+Bf/jDcLC/zxhLtXzAWA7gWd54Yie7hBmOKDHHfsMvvhziAvJ
X-Gm-Gg: ASbGnculG+s0pyXpINRqo2AxEmP2+58Yi9f5u1Y2VRmECXn+gRNTA2OP5oUB4cSLVjA
	QPkMh3p+r7wxpKiQ2h9mzS5wx4UfawUFNtU1Tp8E+a+ayEimzkBW0+t5W/nOCtfTGEZto7/Zxtb
	3FfIG0vbKXlqAiHWv+3hqKfqAghMb8Y8WagQ2fH4z/mHXNWg1CZ0LaUKi2bQkO9UoG8RaDGyZwb
	kghD29VegMqNMLV0P31bLw4eQIyruGIr64GbsuWZ2k+93BPcvnOxdSLK0J5YXRUkYXyAY/75HcZ
	un0sggG3xRBwX7rf4ua2xAgMX2Nj3UcUao1WHwJOjd+0LrWRmAW9kxNSEstk9LMPJVXXwNM4jEO
	zWRG3ueHk3SP5Elo2lQKyPCjx9ql1YphI6ZQz3Hp28IUNkyixxYIDqAvzNpHpnb8tCmv9eZXXBo
	2W1h85yLuZvEmBLEk5uRtRDA6CAFYFKPBs4nQ2yIgIq91a9faOwpFPCiLTU4KW
X-Google-Smtp-Source: AGHT+IFtPujlMsLoj3kRnKO3734HIPu4CLpfKHbGaZyOmvULCHsRYFPy4ZY8ZVzUlcZNSEIxivN0Lw==
X-Received: by 2002:a05:600c:3e08:b0:475:daa7:ec60 with SMTP id 5b1f17b1804b1-4771e1cc7e6mr37879755e9.21.1761759558836;
        Wed, 29 Oct 2025 10:39:18 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm70646865e9.17.2025.10.29.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:39:18 -0700 (PDT)
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
	Yu Kuai <yukuai3@huawei.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org
Subject: [PATCH v4 next 8/9] lib: mul_u64_u64_div_u64() Optimise the divide code
Date: Wed, 29 Oct 2025 17:38:27 +0000
Message-Id: <20251029173828.3682-9-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251029173828.3682-1-david.laight.linux@gmail.com>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
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

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Algorithm unchanged from v3.

 lib/math/div64.c | 124 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 39 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index f6da7b5fb69e..4e4e962261c3 100644
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
 	if (!n_hi)
 		return div64_u64(n_lo, d);
 
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



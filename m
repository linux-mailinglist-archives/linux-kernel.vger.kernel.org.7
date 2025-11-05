Return-Path: <linux-kernel+bounces-887245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D61C37A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78AF24F911B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48734B19F;
	Wed,  5 Nov 2025 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqEEoSqO"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55132FDC42
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373460; cv=none; b=c1sSIjvr4tLwi+TU7K6NJlETMFd0xI2inBO7lNpGqJfehWNR1Lrhdcie/Z1wDbaP9VU2+5OMXDcdI4iRcDN4Dc64RU5ioPnFQQdyhxcaaHNSpjkJXzgL5Tp/Ju405/9+hAgx1N5DZTXSl9M54xWGg84wRAZY9cvBgsUiWatuJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373460; c=relaxed/simple;
	bh=SgoqsqYg/Z87Xt+blLgphWyz2/h1WWrB/dz2hqYSOog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPy4LW99djAKrprm13i2sdwQucKwPy5aiAgBwNd4rIcsjGffaYjRr9HdI0Xr59wQRHN7Hzda9wrz06Wljk+6OwOlTdFOfbVQsl+KcuOa2q9ql0/sgcFKtMUDfm+b+BEeHZAZv8FbS7Zwb8wwOMXxaqF8nVohlaQDKlgTNI9Ij+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqEEoSqO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471b80b994bso1779585e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373457; x=1762978257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioBpYKTwK4o/CnDejM7nHinzWtOoVutc6otbb7BtldQ=;
        b=UqEEoSqOx3vPxfFKM0DweT5H7U4Na1jgcLKu/XD1JGecjit8uYO/7f0CFunsD2YbcA
         V22A3LUlItSoZCmX/pc9lQ2QTS+i0Srz2yy17o5pZBuFrNRu9y5dgPW2uuYVonYTfa0u
         v1xnikLfZgoIN0o+LKXH7Sgym485ScaoEXpWQJEP+Hic+tO5dloLDe1/e6gbxNIV3OLy
         QIWVBfA0qpXjIC9fMJztjyDoNbdKZMDHTNaVpEff9lj97YlFr+x+Uxu6u1uh1QgBGIdW
         1xBkWFaAL9TugOjpdMbJfsrsoO/R7mKvjqTTvapGmgdYZHNwTjLglk5NT8nIsJ6xRx0R
         YgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373457; x=1762978257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioBpYKTwK4o/CnDejM7nHinzWtOoVutc6otbb7BtldQ=;
        b=QAK6latamlAWxbRh90qmfKGfGJr99xhm6nBAJQyTt0ZwjuAJMHUDULRw97xeZpur7s
         rRzbCBVhN51OzbUip0SKPciqL41qkYdjzpi+fYNlVn2Uk1nu7dV4OsUIKUQO4NAHth9j
         dC5irCcuDwAfZUQjJka8sEr6w45qRSqbp2e8LUoS2LTO7enjLemcHr8Iff/cTTtbX6j/
         ZBPULbAsGjIIGsrr9euowa9s6x8+QNOTCR8zIDLGg1IrHZdFg9AM63bJR2I88jZdKOgR
         RP4Qb5GoCM925Cw40KL0+X5hMG7YtaWs0Z1NsaEt8hpkbLfuI8M3SYFT1n0jyT44iqZK
         GzNg==
X-Forwarded-Encrypted: i=1; AJvYcCW6oF4nBesXiQj3sgMz4suENcQFDVkXN+MqHHLsYq5WLpK9WH7ofjqIQPfgIE7toUv1sSo0oXV69IF6rGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykF4fcriDdmTUxuvsHXwQieV4YIrsAWk9oLL2DnPkbXFKFyjUy
	SWIKDz4DLeZ7ruxvMDNK5vAx0BzUwC+6BwUoF1gnbKoEq2K7HiSwMui7
X-Gm-Gg: ASbGncvIgSeRXOtKuOX3LxVIBl/Im6Bthvy/NTT/F/KnBGsdxKatP+K0lW54mpa3tCm
	SnzxhzMIzIE2bwHVLhzXMaUU2JqPzUYV9hiehCeQethudIA+jjxIHQhx+IUWkIcsTg1aGS/iwYy
	DDhOSNnQlfHTGD+OnoSjJGaFrrUoj332GhYNPtQ2xEOPIn/4N3k6HEzeDN4jphI4hEi3FFWTISr
	KqqdKS1XsTV7sAuUHOKZVV7QE6gaYg8zZMz/1u1EAiQsXrCYpWDgDJtvXPmtD8Z4i+VjRbteyne
	2TtwU7iqgoS+dQo0FPXu0+CKXQ0WMzM/ZvOtfXL5ixt+LTokghRYIH28zgmIHmuOQO00FO0X9ID
	EY9Pz5R0InbdvtA/9BYKkM9lgqiGFA+Nw471jJNxJmJqByznbTZQCz80cnO6FuDI7x2jZdNsUab
	2A7eGsxa2o8A4wGQupsEwflpZ2hFdNJUCnhiH/c2HGh8wQisVt2edAOR4kquVXDHZo/XUKZ2m0
X-Google-Smtp-Source: AGHT+IE+9/YK8eZOcut9+nmbfSnkrcIvMeeHYF1njwZC5YB1F3HW27Ghq/iNGnkGlJpcwA46TxpESQ==
X-Received: by 2002:a05:600c:458c:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-4775cdf4322mr46701735e9.21.1762373456453;
        Wed, 05 Nov 2025 12:10:56 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm619857f8f.17.2025.11.05.12.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:10:56 -0800 (PST)
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
Subject: [PATCH v5 next 7/9] lib: mul_u64_u64_div_u64() optimise multiply on 32bit x86
Date: Wed,  5 Nov 2025 20:10:33 +0000
Message-Id: <20251105201035.64043-8-david.laight.linux@gmail.com>
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

gcc generates horrid code for both ((u64)u32_a * u32_b) and (u64_a + u32_b).
As well as the extra instructions it can generate a lot of spills to stack
(including spills of constant zeros and even multiplies by constant zero).

mul_u32_u32() already exists to optimise the multiply.
Add a similar add_u64_32() for the addition.
Disable both for clang - it generates better code without them.

Move the 64x64 => 128 multiply into a static inline helper function
for code clarity.
No need for the a/b_hi/lo variables, the implicit casts on the function
calls do the work for us.
Should have minimal effect on the generated code.

Use mul_u32_u32() and add_u64_u32() in the 64x64 => 128 multiply
in mul_u64_add_u64_div_u64().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
---

Changes for v4:
- merge in patch 8.
- Add comments about gcc being 'broken' for mixed 32/64 bit maths.
  clang doesn't have the same issues.
- Use a #define for define mul_add() to avoid 'defined but not used'
  errors.

 arch/x86/include/asm/div64.h | 19 +++++++++++++++++
 include/linux/math64.h       | 11 ++++++++++
 lib/math/div64.c             | 40 +++++++++++++++++++++++-------------
 3 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index 6d8a3de3f43a..30fd06ede751 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -60,6 +60,12 @@ static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
 }
 #define div_u64_rem	div_u64_rem
 
+/*
+ * gcc tends to zero extend 32bit values and do full 64bit maths.
+ * Define asm functions that avoid this.
+ * (clang generates better code for the C versions.)
+ */
+#ifndef __clang__
 static inline u64 mul_u32_u32(u32 a, u32 b)
 {
 	u32 high, low;
@@ -71,6 +77,19 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 }
 #define mul_u32_u32 mul_u32_u32
 
+static inline u64 add_u64_u32(u64 a, u32 b)
+{
+	u32 high = a >> 32, low = a;
+
+	asm ("addl %[b], %[low]; adcl $0, %[high]"
+		: [low] "+r" (low), [high] "+r" (high)
+		: [b] "rm" (b) );
+
+	return low | (u64)high << 32;
+}
+#define add_u64_u32 add_u64_u32
+#endif
+
 /*
  * __div64_32() is never called on x86, so prevent the
  * generic definition from getting built.
diff --git a/include/linux/math64.h b/include/linux/math64.h
index e889d850b7f1..cc305206d89f 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -158,6 +158,17 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 }
 #endif
 
+#ifndef add_u64_u32
+/*
+ * Many a GCC version also messes this up.
+ * Zero extending b and then spilling everything to stack.
+ */
+static inline u64 add_u64_u32(u64 a, u32 b)
+{
+	return a + b;
+}
+#endif
+
 #if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
 
 #ifndef mul_u64_u32_shr
diff --git a/lib/math/div64.c b/lib/math/div64.c
index 18a9ba26c418..bb57a48ce36a 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -186,33 +186,45 @@ EXPORT_SYMBOL(iter_div_u64_rem);
 #endif
 
 #if !defined(mul_u64_add_u64_div_u64) || defined(test_mul_u64_add_u64_div_u64)
-u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
-{
+
+#define mul_add(a, b, c) add_u64_u32(mul_u32_u32(a, b), c)
+
 #if defined(__SIZEOF_INT128__) && !defined(test_mul_u64_add_u64_div_u64)
 
+static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
+{
 	/* native 64x64=128 bits multiplication */
 	u128 prod = (u128)a * b + c;
-	u64 n_lo = prod, n_hi = prod >> 64;
+
+	*p_lo = prod;
+	return prod >> 64;
+}
 
 #else
 
-	/* perform a 64x64=128 bits multiplication manually */
-	u32 a_lo = a, a_hi = a >> 32, b_lo = b, b_hi = b >> 32;
+static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
+{
+	/* perform a 64x64=128 bits multiplication in 32bit chunks */
 	u64 x, y, z;
 
 	/* Since (x-1)(x-1) + 2(x-1) == x.x - 1 two u32 can be added to a u64 */
-	x = (u64)a_lo * b_lo + (u32)c;
-	y = (u64)a_lo * b_hi + (u32)(c >> 32);
-	y += (u32)(x >> 32);
-	z = (u64)a_hi * b_hi + (u32)(y >> 32);
-	y = (u64)a_hi * b_lo + (u32)y;
-	z += (u32)(y >> 32);
-	x = (y << 32) + (u32)x;
-
-	u64 n_lo = x, n_hi = z;
+	x = mul_add(a, b, c);
+	y = mul_add(a, b >> 32, c >> 32);
+	y = add_u64_u32(y, x >> 32);
+	z = mul_add(a >> 32, b >> 32, y >> 32);
+	y = mul_add(a >> 32, b, y);
+	*p_lo = (y << 32) + (u32)x;
+	return add_u64_u32(z, y >> 32);
+}
 
 #endif
 
+u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
+{
+	u64 n_lo, n_hi;
+
+	n_hi = mul_u64_u64_add_u64(&n_lo, a, b, c);
+
 	if (!n_hi)
 		return div64_u64(n_lo, d);
 
-- 
2.39.5



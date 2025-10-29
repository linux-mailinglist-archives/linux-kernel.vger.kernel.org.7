Return-Path: <linux-kernel+bounces-876849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E346C1C835
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A18519C0206
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C06B3559D0;
	Wed, 29 Oct 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltoonu9h"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CEA1A9F96
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759562; cv=none; b=aUpERoXIy+AGyRs86aMCiJHX4maH01f8tG7iYRJYlJGkOl7umGxsCZ3hG+hL4/+jrccxSWvxz+m/2Ch7IHrYCFS1rfJ+N+BAVLyvUTD1L8fq2uTKHmNBo4jDD1QbHFkIFbWbIYHZHpSQixuV1hjALdfjvn+r9DEWriMbH2VvswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759562; c=relaxed/simple;
	bh=Z3FqXguUg8T1r6oH2VNVIbBBg9pZco2x6EyPSCHtG0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uO7RQpRTsXBywRF5BhcPPXTb7AYmanywqoCCN1Bf3Ha9uIKvBcrLwNh3FrvmhNdsCJSbLRkVXIh1yENNr91o48w1sb0l9LiI0PZyU4taxLUK9FyZZonKYq3Le8EYBmLaAU84SWzXtC8IqrPEcFn+/hB3ai23tTtlXFSu0gfLGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltoonu9h; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso727595e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759558; x=1762364358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rOHLgMiqxXYiPO+1o8K7NwRMVoG3THlCo2i4GBN/+c=;
        b=ltoonu9hAlLp9v92S7hSN4zqLU/GbhG/OY74v0EkbC68LXrvb7/1qoIkYRvY4p3fwK
         N1cWZngoppn2TQxZQw7if2WieF3qkaaXueiA2tjmIELOAOrAe5Qp1ZeZkoyZE60sXcQf
         nPUqLwfaam9lRs3WIC1dHDRIZJy5U821VQw7LCuu0vaVbX25Rrd2KGhPaSGw9bSq11aG
         MPumSyrMUL9Qp2p0ONt46uRJNhIZ9nRQP9lx2sYKac3bjUyfjizmvOgwChvXXLnOliTr
         mjVDxwclc5IAQTHjWtwbeq234xq+x/V7YXLNQuBknUFNQdDGnVjM9LQggB9Iuh/Siwi9
         +Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759558; x=1762364358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rOHLgMiqxXYiPO+1o8K7NwRMVoG3THlCo2i4GBN/+c=;
        b=b/7EgPpZ04euv9+AzmfCqB2fRkWsZCWuRMvN9q4bpclsV+jShiz9PEKrTGl2mPGC4r
         zTR4Oyiw78yiu3h+/jAbKttwTq2TGNfg9UyUE+ullmGjw4JTjB54vQjIb5kID9ShJP43
         8eqCQM/2PvgWzPU/2SGQwESLEtNt7PGaR6NML5M6fwkqWCrUhSh1UbBoIeKhnehaBFkg
         +UpRj8sZotbpdeTX8uFartNOnJbUQ28TpDN/XkyyTC6YDHnRbYbMfwxhg3uOP7zLevCT
         C/SDtC9hjUifu8Q5nDznWNBTA+VTu6/FfZEl6/2wa2wZxMtN+RQuSqeYlClC0ogjyfzq
         X1NA==
X-Forwarded-Encrypted: i=1; AJvYcCVPjGeSQsip7yHC9CV8TcvLLpXSk9r2q2zWBFfB5HoqPxigqbPMKNJQYu0C43XQDGZgyNJ6vEKfxlcHu0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfCpxK2ysWmCE4LxG1zuZGPyHsqHKD9XUpshBkfXIJwBVgSebY
	FFM8sSiRb8fZcblqRBazJmkWMgIJEjzXU+ncgIbia4X9zaEYkQ/q/ACb
X-Gm-Gg: ASbGncvupSRJ/ENQieY2X4vw2uWuLkH6VWHRlHvVh/iW4wHs+9GxCZMIcoftEnNlItE
	mVlkDxZFiIQasEulapsvApygbTXggPk5c1fO0kIYrkCyPZBEJpqZpY5uJ0vq3vgq0nR6cgZ1eLC
	Lh3MIrk3hVP8944Rvqg4iar+ZH2zNKy1bjHbcc6ZrOBPNQz9yrkGczEGL51Phbt92tSU47Twhpg
	/HB5tZacSZRqy0TJCvD9tVL46Io5zfNNR1Kipyh+DzOisFAO6RS7RqYHFKKDlM/KaAu5rfG2q/8
	AQtGZJqO8P0ZvqgP/+QdKyEjmM2hvwAOAvyiSdXf5vZjEalEkwPOwH1X3ubCtbhIWqsFdhyFW+s
	LoCPkhlIXEA56MbCQS8dqsSp7aR3wvN3obmFGFV40U8SVP7YXBzDksYsW46b0n6WY3PqxT7U+KH
	6KXZgcBBwzXbMoZFc3QeXCG5VUZcj/d4jGpqk3WXx9y9AWCzX4+gWbE3Bg0P0M
X-Google-Smtp-Source: AGHT+IEu+ef78TU5BohY955TnLfLd2FOTrbixoN6WxzQUUhRNw24BuA/i4qVmfrFqxuIN5aC3Q1pwA==
X-Received: by 2002:a05:600c:628e:b0:477:19ad:1c43 with SMTP id 5b1f17b1804b1-477267115fcmr2089875e9.5.1761759558078;
        Wed, 29 Oct 2025 10:39:18 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm70646865e9.17.2025.10.29.10.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:39:17 -0700 (PDT)
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
Subject: [PATCH v4 next 7/9] lib: mul_u64_u64_div_u64() optimise multiply on 32bit x86
Date: Wed, 29 Oct 2025 17:38:26 +0000
Message-Id: <20251029173828.3682-8-david.laight.linux@gmail.com>
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
---

Changes for v4:
- merge in patch 8.
- Add comments about gcc being 'broken' for mixed 32/64 bit maths.
  clang doesn't have the same issues.
- use a #defdine for define mul_add() to avoid 'defined but not used'
  errors.

 arch/x86/include/asm/div64.h | 19 +++++++++++++++++
 include/linux/math64.h       | 11 ++++++++++
 lib/math/div64.c             | 40 +++++++++++++++++++++++-------------
 3 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index cabdc2d5a68f..a18c045aa8a1 100644
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
index f92e7160feb6..f6da7b5fb69e 100644
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
 	if (unlikely(n_hi >= d)) {
 		/* trigger runtime exception if divisor is zero */
 		if (d == 0) {
-- 
2.39.5



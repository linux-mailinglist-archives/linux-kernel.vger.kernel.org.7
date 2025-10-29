Return-Path: <linux-kernel+bounces-876846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BADC1C932
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE01622B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B08355040;
	Wed, 29 Oct 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL7TgNV9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA023546F4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759560; cv=none; b=GRfUFKT/FHca5h5Q8Jlp3+iHhT0E5r3cm/i7tqNZ4/NBcPxI3+nua0b5EFbrtYxqj5+V4YBNhi3qwynY9B/DchjQTTRXd44ONfTeRO+1QQ6O60HjZ4giZRb+th1gWV+kDIu37FfH/vyrJsNaEhGnkz33h2lB2zCT+qFgg5J6u1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759560; c=relaxed/simple;
	bh=w7pJ3g4XS3B0VnuXhUk6tjBfi0ZN1H7G2PtYS2dY3R8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIfEHIiJ/8oAqr7XUyv7M6ZcPHfp2qiGlQAJaCLfKkzTNBcnrH+g24b6DjcE38FvkXErUBnpe9mytq4EQ/86eRU3kBx/0tjwqiptWjA4n1LU4idg7pye/yUm6wvviBIts0Fw2OlY7lQUwAOG7B0ICCb1gm2u/y8Kk1ChV5bcH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL7TgNV9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475e01db75aso614825e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759556; x=1762364356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4ZF1zncuIOrL9kOPKjGtIkvHUHy+10iJnWf37+9Phc=;
        b=ZL7TgNV91jgu1TKHOSbggRvyiXqRI26OiWEhg3CUJnOzPRh8gJf4NRu0r0DK60H3uq
         QqM5oUAU6o22YVmxXcVT19vIzmzBY9nGiqvaRK4gIGFNsalzwfX4DkfBc9o6xR4qbUTL
         /ScdczqkodP4xtSRZcOXTpW+v6twkxPe5KALMtlvp3EPzNrJWvp4qZgV16Lvo0DOnyC6
         NZilOa/nLp5BYAL3Xe4ojr78NGxqnip5Oz38iTEiSztt0pB/dvi5WK6bVivXRe01bVA1
         NRuyvPbyZZ6npLihvZBjWT/2e8P/lofKEMbC64ivh2S8whcAqp+yCH9yRbsY5dMrDic2
         Sa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759556; x=1762364356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4ZF1zncuIOrL9kOPKjGtIkvHUHy+10iJnWf37+9Phc=;
        b=ho7a0NlvWS12kxk5h2JlXrrEozPESGTRDdariyCE0Y4BwezxCrtZ13h82r0Ml9/wLl
         dI93ZtttRbVf7AU8MaYiwJUOjMhJWmz4CzliJOiv3YSI1xCnLHIc14XY7LJi0WAmB3Pk
         Ad8Qvc/6FOL0MKHOKVkKxG1qOyh7mtNX4Al/G2OTOaTsjlgX7TLeelW7gBo9s9xIm21x
         fr/uhHQN/BNLtirTcwWVtHGh1J+T+v/LSiwGjsiGUPEZtYkx/U1lSs4ql50S3RbLjxFK
         kQnbyb3/8RwlzgVOAVWTJgI/UodxcRANhuMNkaXzS11tGRTkIBesP6YVxkwH98J9hr+i
         uZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhIlIhX/yhqgtEr4Cjww8N8+FcUK4H4LsVJ/f5wiZCyYOPb+g534XuYhtvv/GICBheVp/UFiMdvgoKx2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3cZ+dWv1qB39qBCRDqUvJ9jfPQP2oHxWtNQ3mH3Mll61U2w1
	T0zatHnvqDc/A93RjOOSLWeAcv844aDbSlFI+9Czyg1vDcj7YsGok7TT
X-Gm-Gg: ASbGncsysV5LpgBB/7B3UbQ38qSSjiJQ6J5/V1KQBo60gJqQWzChfVXmXY7AyXOOD40
	GAT5WUiRo4G30RHdUdjMT1QMm8RKS9i5j2Mz6qYYDfOwxXm7xuonS3usqFvWqA2/kYCGwW2+8tq
	40oO45JVp483PL1FJi4igVX1VM3rYfhEP9NRj38D60FxWfLsImPMeTIq65oj74Kzg2wNtrrE7uZ
	hu9yX0MGBQGcx6YMgCJlOuXalC+qx/KKLasUEYaJ7bq5zlNAzOIIkHKvnvjY8cSTvk0z+5tK3kZ
	PCUSAoblEVWBOQrxA1ePccEyaWksId8wn9rA7UQJTEhdv5HSPzvkanV1SINA04KFubZ00wFiLPf
	WNZVXHDQ6afBWOkCtFGMQWbGJ9j1W7idlM9aYCKlw1FwoExYk9OqmDPFUvTfbdCx0YYKjD4T8Ra
	Ge0ErvJA4P+6eOeMVPij3aavCBZrNMw9F/z6zhnu98f3v3AiGI2L3EiAwWWb49
X-Google-Smtp-Source: AGHT+IEhgS9pPNkz3DZhn7/xPbpimfCyqBOfDjpGD6ckoRsCLWpga4S8wuc7B3GmpJWexkTfjphShQ==
X-Received: by 2002:a05:600d:8307:b0:471:133c:4b9a with SMTP id 5b1f17b1804b1-47722c8d852mr15725615e9.6.1761759555648;
        Wed, 29 Oct 2025 10:39:15 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm70646865e9.17.2025.10.29.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:39:15 -0700 (PDT)
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
Subject: [PATCH v4 next 4/9] lib: Add mul_u64_add_u64_div_u64() and mul_u64_u64_div_u64_roundup()
Date: Wed, 29 Oct 2025 17:38:23 +0000
Message-Id: <20251029173828.3682-5-david.laight.linux@gmail.com>
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

The existing mul_u64_u64_div_u64() rounds down, a 'rounding up'
variant needs 'divisor - 1' adding in between the multiply and
divide so cannot easily be done by a caller.

Add mul_u64_add_u64_div_u64(a, b, c, d) that calculates (a * b + c)/d
and implement the 'round down' and 'round up' using it.

Update the x86-64 asm to optimise for 'c' being a constant zero.

Add kerndoc definitions for all three functions.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Changes for v2 (formally patch 1/3):
- Reinstate the early call to div64_u64() on 32bit when 'c' is zero.
  Although I'm not convinced the path is common enough to be worth
  the two ilog2() calls.

Changes for v3 (formally patch 3/4):
- The early call to div64_u64() has been removed by patch 3.
  Pretty much guaranteed to be a pessimisation.

Changes for v4:
- For x86-64 split the multiply, add and divide into three asm blocks.
  (gcc makes a pigs breakfast of (u128)a * b + c)
- Change the kerndoc since divide by zero will (probably) fault.

 arch/x86/include/asm/div64.h | 20 +++++++++------
 include/linux/math64.h       | 48 +++++++++++++++++++++++++++++++++++-
 lib/math/div64.c             | 14 ++++++-----
 3 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index 9931e4c7d73f..cabdc2d5a68f 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -84,21 +84,25 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
  * Will generate an #DE when the result doesn't fit u64, could fix with an
  * __ex_table[] entry when it becomes an issue.
  */
-static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
+static inline u64 mul_u64_add_u64_div_u64(u64 rax, u64 mul, u64 add, u64 div)
 {
-	u64 q;
+	u64 rdx;
 
-	asm ("mulq %2; divq %3" : "=a" (q)
-				: "a" (a), "rm" (mul), "rm" (div)
-				: "rdx");
+	asm ("mulq %[mul]" : "+a" (rax), "=d" (rdx) : [mul] "rm" (mul));
 
-	return q;
+	if (statically_true(add))
+		asm ("addq %[add], %[lo]; adcq $0, %[hi]" :
+			[lo] "+r" (rax), [hi] "+r" (rdx) : [add] "irm" (add));
+
+	asm ("divq %[div]" : "+a" (rax), "+d" (rdx) : [div] "rm" (div));
+
+	return rax;
 }
-#define mul_u64_u64_div_u64 mul_u64_u64_div_u64
+#define mul_u64_add_u64_div_u64 mul_u64_add_u64_div_u64
 
 static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 div)
 {
-	return mul_u64_u64_div_u64(a, mul, div);
+	return mul_u64_add_u64_div_u64(a, mul, 0, div);
 }
 #define mul_u64_u32_div	mul_u64_u32_div
 
diff --git a/include/linux/math64.h b/include/linux/math64.h
index 6aaccc1626ab..e889d850b7f1 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -282,7 +282,53 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 }
 #endif /* mul_u64_u32_div */
 
-u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
+/**
+ * mul_u64_add_u64_div_u64 - unsigned 64bit multiply, add, and divide
+ * @a: first unsigned 64bit multiplicand
+ * @b: second unsigned 64bit multiplicand
+ * @c: unsigned 64bit addend
+ * @d: unsigned 64bit divisor
+ *
+ * Multiply two 64bit values together to generate a 128bit product
+ * add a third value and then divide by a fourth.
+ * The Generic code divides by 0 if @d is zero and returns ~0 on overflow.
+ * Architecture specific code may trap on zero or overflow.
+ *
+ * Return: (@a * @b + @c) / @d
+ */
+u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d);
+
+/**
+ * mul_u64_u64_div_u64 - unsigned 64bit multiply and divide
+ * @a: first unsigned 64bit multiplicand
+ * @b: second unsigned 64bit multiplicand
+ * @d: unsigned 64bit divisor
+ *
+ * Multiply two 64bit values together to generate a 128bit product
+ * and then divide by a third value.
+ * The Generic code divides by 0 if @d is zero and returns ~0 on overflow.
+ * Architecture specific code may trap on zero or overflow.
+ *
+ * Return: @a * @b / @d
+ */
+#define mul_u64_u64_div_u64(a, b, d) mul_u64_add_u64_div_u64(a, b, 0, d)
+
+/**
+ * mul_u64_u64_div_u64_roundup - unsigned 64bit multiply and divide rounded up
+ * @a: first unsigned 64bit multiplicand
+ * @b: second unsigned 64bit multiplicand
+ * @d: unsigned 64bit divisor
+ *
+ * Multiply two 64bit values together to generate a 128bit product
+ * and then divide and round up.
+ * The Generic code divides by 0 if @d is zero and returns ~0 on overflow.
+ * Architecture specific code may trap on zero or overflow.
+ *
+ * Return: (@a * @b + @d - 1) / @d
+ */
+#define mul_u64_u64_div_u64_roundup(a, b, d) \
+	({ u64 _tmp = (d); mul_u64_add_u64_div_u64(a, b, _tmp - 1, _tmp); })
+
 
 /**
  * DIV64_U64_ROUND_UP - unsigned 64bit divide with 64bit divisor rounded up
diff --git a/lib/math/div64.c b/lib/math/div64.c
index 7158d141b6e9..25295daebde9 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -183,13 +183,13 @@ u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 }
 EXPORT_SYMBOL(iter_div_u64_rem);
 
-#ifndef mul_u64_u64_div_u64
-u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
+#ifndef mul_u64_add_u64_div_u64
+u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
 {
 #if defined(__SIZEOF_INT128__)
 
 	/* native 64x64=128 bits multiplication */
-	u128 prod = (u128)a * b;
+	u128 prod = (u128)a * b + c;
 	u64 n_lo = prod, n_hi = prod >> 64;
 
 #else
@@ -198,8 +198,10 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
 	u32 a_lo = a, a_hi = a >> 32, b_lo = b, b_hi = b >> 32;
 	u64 x, y, z;
 
-	x = (u64)a_lo * b_lo;
-	y = (u64)a_lo * b_hi + (u32)(x >> 32);
+	/* Since (x-1)(x-1) + 2(x-1) == x.x - 1 two u32 can be added to a u64 */
+	x = (u64)a_lo * b_lo + (u32)c;
+	y = (u64)a_lo * b_hi + (u32)(c >> 32);
+	y += (u32)(x >> 32);
 	z = (u64)a_hi * b_hi + (u32)(y >> 32);
 	y = (u64)a_hi * b_lo + (u32)y;
 	z += (u32)(y >> 32);
@@ -265,5 +267,5 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
 
 	return res;
 }
-EXPORT_SYMBOL(mul_u64_u64_div_u64);
+EXPORT_SYMBOL(mul_u64_add_u64_div_u64);
 #endif
-- 
2.39.5



Return-Path: <linux-kernel+bounces-887242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B05C37A56
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A72B94F585B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACF346FC8;
	Wed,  5 Nov 2025 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLGvVFWb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C803451C4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373458; cv=none; b=axGVdiO5dgfzbGHKjsO4zRA67Q/bcBHm8N+gtTaV9rX97YpT98IyDgDucdDpsmFglIxmaFqH2wNS2zcfQonC9ZwAZZ6g065+nFnW6TZTg4Eqc6hxiu8zVfN3wu5I+LYCkUzv+NNBf2WJoOowF79PqDAA+VMZtNPXzAFTSq8glHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373458; c=relaxed/simple;
	bh=LQF+5DOroykS0egwdIZIn1wgypURQ/kr06ARZbD7kXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNVb8pRoksO6KnKtX6FM5bByjZ4KseGlJ2kitXwzqgQ21HpzCeZJfoXfL5Xi6lBhQo9P7mH0e5+4zBaDBSyJzCFSpWEBOhE/Fs5ekm/pwFGgVcoCNEaZnIPrBTcyLPGZFLAWI5uJKWtCZT2HIlv/fUacUOp5BcVlrOpxB/WRNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLGvVFWb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477632b0621so317775e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373454; x=1762978254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkRmlGhQ3RIhH+UDlv2Rx49yULgpizS+/KVzccR++lw=;
        b=JLGvVFWbAEkUSS/DgSfhyjfnv9MsK1D1KrTj7eg0j4qffywF8CSmcbrm2b1mj6SeeS
         2VCKoK7SjN6u/hRuxNg36qgLABSlKO3BWiMw/Z+plgnmPyEqQtgUg+G8T5a/CeP/Bq7g
         J+7lOP/0k/3YHm9+Nwhk/TcShyp47ouN9ZHLgbKhXNH8+Iwiwwy5aj0o323/SWuOl7oY
         rQX75Tq6dIfRtISLHTpG4bY0P7tiC0+ru/GCD/F+xyXTk2WeFJz1rNHmF6+9+l6i/KmP
         KQwblcP4Mz7X/+OTke94aIvLom61GdjBOfPqd9YRcQg8VL9tLosYGiAhjKGv1rK5Lziy
         mJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373454; x=1762978254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkRmlGhQ3RIhH+UDlv2Rx49yULgpizS+/KVzccR++lw=;
        b=d4Hkld4h+7aoA3oUxpCFBLad0XVztJcvwMtUAo8MUCQT1pjPF0Y6ow2XpK8+KfPbQ1
         CvVlHohxjT2xXPaR5+k1YJBqKEsGgmJJxTMf37CzuE2Fo9GOb1sgGEqFHtvgUpUO0blz
         9RIoN7QmbXLJ+T8rAHv8+vOwjj5yYs0UmnVLfpHb43/7PoZBXUqBxsPrpu94xWfhkzbF
         o0gnvrTRCXwMGOcfOvw/acktN5iMYiF/d+TE6oGaVo0w4NJAN+ZtB9hFdBsWF7/KaIx7
         omXeA7ydcBfMAsMIZTLxSScOe0AzmY9+knJYzF6ano1r7/f3quLJKwGVEfJ/sYsEymza
         s8mA==
X-Forwarded-Encrypted: i=1; AJvYcCUpYl1biErtLKrEzVZHbl5cxUkGCIWATbK2FttioaC3fL52mH0vvnrRYO15iojetaMeWj/o1eCMaZuEByY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMHbp9qoZo542IE0csig62dTokQla4PXyDRGLylysrP2AsewJ
	4zy6mXay+YFXHxmXGa1QbjYonZcgmd8a3eD9ob35Q+4f8dKXUocHZzPn
X-Gm-Gg: ASbGncvuhr3kQpVf2zD/sMlbDpOz2VWCgk3anlV1s1tcqJDwq25LXQr07SYdlJar4Ii
	1MCt4aj19XDxBb3AJCOuULjUQrT7awEGTyctFPI3WA/LkqHYUkAoqQHC4cnvMXQbiuFBUmvWnLs
	c/LR5kn5tCUzsaUtI3M4zEvBKm3YDvot0pRPl6hEx4W4JsE/4tbMxZmi4s5LlJ93UlWDKle5Zeo
	ukMdAD8F36133jCOL5KVHER5DrdPUjXCHl6/MvJb4AL/jErRatl1v8uDpR973DHyh/recREX1lL
	KvksDl1Uef0f0GM8o5J5YvF1CObsbK+itfieJSnm57tc4wAkFwfucUY78ejKXv02t0DsYExpViA
	I7QmQw6nzQa+bBYFJn4sBvgVkBmsUcztHDwiwb5q5iqOYEcY0I5U6XuiXGgAUc42cXO50BdsD4x
	EjHB+3nEgSRKEIvw08C06VqlQXLTMPebBzzEjvj86BRlRdkGGR/8Cs767poLIgoV54G3ZlJgRN
X-Google-Smtp-Source: AGHT+IFXG1S5UtuGGZsKT7XgyGdRJCZnI3LB9sBEb0GEql+LqqFAXg/5KZmRt5O8aqAfZKR7qj7S0A==
X-Received: by 2002:a05:600c:8b84:b0:475:d8c8:6894 with SMTP id 5b1f17b1804b1-4775cdbec8fmr34636355e9.9.1762373454240;
        Wed, 05 Nov 2025 12:10:54 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm619857f8f.17.2025.11.05.12.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:10:54 -0800 (PST)
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
Subject: [PATCH v5 next 4/9] lib: Add mul_u64_add_u64_div_u64() and mul_u64_u64_div_u64_roundup()
Date: Wed,  5 Nov 2025 20:10:30 +0000
Message-Id: <20251105201035.64043-5-david.laight.linux@gmail.com>
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

The existing mul_u64_u64_div_u64() rounds down, a 'rounding up'
variant needs 'divisor - 1' adding in between the multiply and
divide so cannot easily be done by a caller.

Add mul_u64_add_u64_div_u64(a, b, c, d) that calculates (a * b + c)/d
and implement the 'round down' and 'round up' using it.

Update the x86-64 asm to optimise for 'c' being a constant zero.

Add kerndoc definitions for all three functions.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
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

Changes for v5:
- Fix test that excludes the add/adc asm block for constant zero 'add'.

 arch/x86/include/asm/div64.h | 20 +++++++++------
 include/linux/math64.h       | 48 +++++++++++++++++++++++++++++++++++-
 lib/math/div64.c             | 14 ++++++-----
 3 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index 9931e4c7d73f..6d8a3de3f43a 100644
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
+	if (!statically_true(!add))
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
index 4a4b1aa9e6e1..a88391b8ada0 100644
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



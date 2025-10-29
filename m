Return-Path: <linux-kernel+bounces-876848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C773FC1CABB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC626601C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4439355809;
	Wed, 29 Oct 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYkH+7LG"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691193446B5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759561; cv=none; b=lXSg1jvVzS59V961iMT5E2kA+MAoxHSin30Eg172BBQDfE19PQt3LkLIDLXNd7VvjluCGpR/tdt/dLha5ZtRvs92jThLIQ0NRMQLu33hPIpNLWED06v0RTd5GKXdlkIa63Tuu0T6za/iBEJZ3+ZmcrqG7fXscphktxVK3K2OQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759561; c=relaxed/simple;
	bh=UCLOuHRe9JTMAMFSws4hOXFjQBZHy75iVHd2PkK7mQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqvz+HCBm1NPByXSK/IHDQq7xXJdvbSKTQVnD3bLhEjFc1rydeIjO3R3jx9TMgfvf6rCjSXbGaqYB6N6Z7SCiL2MY/PQJTWcA9nJtkIDJaxr2nu3nxRwT/XqUVF2+7jqG7vq+ShL/HjjkQnd3WddDXm1feOkenZk9me8h2iw5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYkH+7LG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471191ac79dso1126415e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759557; x=1762364357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edTaeeVtqohQLLYXZn1p4Mx6bseq0sNKUYhIKbAAn3o=;
        b=IYkH+7LGFNLhHyHKa+dXU8KQIvHIpzgyToNCMYvYTNG0g/Dj7OdTzTgPsrnjH387ub
         x4L9Jg/BEZaGSmF5BXDJlgigJ16gepBZRN0bhj9bwUylzQs7bvX0F3V/K1URG+sT9YYS
         S+gUOaCbS8bqmbk+t81bocWcFtMzmjgee20EEsnE3SRYRPVFBTEpFxh9M/dTlZSmAsp3
         SfqTH1SnGV7qrGPUtPx1FnvVU7s+yNOxcj5PT5mNb7IWw7x60raqoAv6hSE6UirTkffz
         3XUwREXGsUoYn6uTzC4a4OcSRZJXufTgXtn8wwS379WqDG6FzOqP4f496vw32nO+yfGr
         nJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759557; x=1762364357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edTaeeVtqohQLLYXZn1p4Mx6bseq0sNKUYhIKbAAn3o=;
        b=W6ZEgOabkprmrSpmlki4HTr9fEdEC7sgzcoiUKnOFkBHWE5C55XV4yeXjJKBDPVhTQ
         VWoI34+3nAC127oV3WxMn7utEHTrCnMPKmghCANeMN5EG6ES2pm2pvK412v19ImuD8MM
         WZZlMH7gyNEbZ9Wxa8YtaJmBdyNk3m+0mfMYmGmL422gf8ecoeTfFcat/CvLSD9Fa+ML
         AqoX4cQOErLayrn1Zz6XQ0c94E4eXuv5pqaiwHkHLxxvHQYW8b7lPJEzh2JtYPlcr3+n
         Ss6K0bgGhzydIz2wEeugcNUceEQWHkYDRiun/HAZoc/vnHF7w6Ffm7JEBvmR1/rMVCpT
         BXnA==
X-Forwarded-Encrypted: i=1; AJvYcCXl2IeWL7Ru5/LvwocfMEpmKpR5U0aBsx3T1PW7tayrgpoAEnkMBndGdsu+YigTcyU2NTjrKN2e1Xcgyes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMfrKGL7/lRPfpam0xZdoptA60qZdH4b5OIqSYwT4i/wY9p7pA
	p4Tqf3zatSpmeR4ks5uE00+mYXx7/5YYH33Fmo/ysCSKcF+g5PYtkaU8
X-Gm-Gg: ASbGnctqkYDrdIqfiH0c0ndpGeKm1c2Wj2Rij7LNPIGH3ujhm29bFQ0Cv6tKif39DwP
	5Fd/08INJBgfs17ARtugrpqdeKJEQfRIiw3idehK5Zx1UGX53wzGRJNhxOAbhI1fn2uELS+Pc0Z
	tnUqxfpEK/rjASJWpqSpAuEWm4H6Spie8GRw0jHZo9YPJaeq3lm+LrbW2YnAm9IQ0Pse7G+00ft
	5m+P5BDFIwsRB1gwYLi27+XfAG4a5wKyJrgXJVDQN2xINBpEvdUwKuXXmx5SdD54OUhHIRbDBxX
	Z5ockZYnrTlbKNX4Etc5fb3QuGpUWwTLPDGKo1ZhQrsGGkHfyyNGtOWDVi/N53nBLx3R2Jzqy3X
	Zz0KuZi2Gwz6xpGlCN7l0DRF/Cu1ab7XwzNTOWVrlPKKI3Cqbkti/LblcNHX6/HifyMXh343amR
	80/y2ht5rPgHOsEOtKTILlWR8LMrk84gYsKp3ZvS8JSYztmYysI9ndNx48fYWHTjwiD/RfTPg=
X-Google-Smtp-Source: AGHT+IEa++kmTpR/Sg1CLMMa4kRHbHLSYdevatxIQ21q/SlUuM94yltxHoX05TYGMgJzOyf0gR8BYA==
X-Received: by 2002:a05:600c:1d1c:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-4771e1c9da8mr30359655e9.1.1761759557231;
        Wed, 29 Oct 2025 10:39:17 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm70646865e9.17.2025.10.29.10.39.16
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
Subject: [PATCH v4 next 6/9] lib: test_mul_u64_u64_div_u64: Test both generic and arch versions
Date: Wed, 29 Oct 2025 17:38:25 +0000
Message-Id: <20251029173828.3682-7-david.laight.linux@gmail.com>
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

Change the #if in div64.c so that test_mul_u64_u64_div_u64.c
can compile and test the generic version (including the 'long multiply')
on architectures (eg amd64) that define their own copy.

Test the kernel version and the locally compiled version on all arch.
Output the time taken (in ns) on the 'test completed' trace.

For reference, on my zen 5, the optimised version takes ~220ns and the
generic version ~3350ns.
Using the native multiply saves ~200ns and adding back the ilog2() 'optimisation'
test adds ~50ms.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Changes for v4:
- Fix build on non x86 (eg arm32)

 lib/math/div64.c                    |  8 +++--
 lib/math/test_mul_u64_u64_div_u64.c | 51 +++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index 25295daebde9..f92e7160feb6 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -177,16 +177,18 @@ EXPORT_SYMBOL(div64_s64);
  * Iterative div/mod for use when dividend is not expected to be much
  * bigger than divisor.
  */
+#ifndef iter_div_u64_rem
 u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 {
 	return __iter_div_u64_rem(dividend, divisor, remainder);
 }
 EXPORT_SYMBOL(iter_div_u64_rem);
+#endif
 
-#ifndef mul_u64_add_u64_div_u64
+#if !defined(mul_u64_add_u64_div_u64) || defined(test_mul_u64_add_u64_div_u64)
 u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
 {
-#if defined(__SIZEOF_INT128__)
+#if defined(__SIZEOF_INT128__) && !defined(test_mul_u64_add_u64_div_u64)
 
 	/* native 64x64=128 bits multiplication */
 	u128 prod = (u128)a * b + c;
@@ -267,5 +269,7 @@ u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
 
 	return res;
 }
+#if !defined(test_mul_u64_add_u64_div_u64)
 EXPORT_SYMBOL(mul_u64_add_u64_div_u64);
 #endif
+#endif
diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/test_mul_u64_u64_div_u64.c
index 4d5e4e5dac67..a3c5e54f37ef 100644
--- a/lib/math/test_mul_u64_u64_div_u64.c
+++ b/lib/math/test_mul_u64_u64_div_u64.c
@@ -73,21 +73,34 @@ done
 
  */
 
-static int __init test_init(void)
+static u64 test_mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d);
+
+static int __init test_run(unsigned int fn_no, const char *fn_name)
 {
+	u64 start_time;
 	int errors = 0;
 	int tests = 0;
 	int i;
 
-	pr_info("Starting mul_u64_u64_div_u64() test\n");
+	start_time = ktime_get_ns();
 
 	for (i = 0; i < ARRAY_SIZE(test_values); i++) {
 		u64 a = test_values[i].a;
 		u64 b = test_values[i].b;
 		u64 d = test_values[i].d;
 		u64 expected_result = test_values[i].result;
-		u64 result = mul_u64_u64_div_u64(a, b, d);
-		u64 result_up = mul_u64_u64_div_u64_roundup(a, b, d);
+		u64 result, result_up;
+
+		switch (fn_no) {
+		default:
+			result = mul_u64_u64_div_u64(a, b, d);
+			result_up = mul_u64_u64_div_u64_roundup(a, b, d);
+			break;
+		case 1:
+			result = test_mul_u64_add_u64_div_u64(a, b, 0, d);
+			result_up = test_mul_u64_add_u64_div_u64(a, b, d - 1, d);
+			break;
+		}
 
 		tests += 2;
 
@@ -106,15 +119,39 @@ static int __init test_init(void)
 		}
 	}
 
-	pr_info("Completed mul_u64_u64_div_u64() test, %d tests, %d errors\n",
-		tests, errors);
-	return errors ? -EINVAL : 0;
+	pr_info("Completed %s() test, %d tests, %d errors, %llu ns\n",
+		fn_name, tests, errors, ktime_get_ns() - start_time);
+	return errors;
+}
+
+static int __init test_init(void)
+{
+	pr_info("Starting mul_u64_u64_div_u64() test\n");
+	if (test_run(0, "mul_u64_u64_div_u64"))
+		return -EINVAL;
+	if (test_run(1, "test_mul_u64_u64_div_u64"))
+		return -EINVAL;
+	return 0;
 }
 
 static void __exit test_exit(void)
 {
 }
 
+/* Compile the generic mul_u64_add_u64_div_u64() code */
+#define __div64_32 __div64_32
+#define div_s64_rem div_s64_rem
+#define div64_u64_rem div64_u64_rem
+#define div64_u64 div64_u64
+#define div64_s64 div64_s64
+#define iter_div_u64_rem iter_div_u64_rem
+
+#undef mul_u64_add_u64_div_u64
+#define mul_u64_add_u64_div_u64 test_mul_u64_add_u64_div_u64
+#define test_mul_u64_add_u64_div_u64 test_mul_u64_add_u64_div_u64
+
+#include "div64.c"
+
 module_init(test_init);
 module_exit(test_exit);
 
-- 
2.39.5



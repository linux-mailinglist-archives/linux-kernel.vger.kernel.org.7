Return-Path: <linux-kernel+bounces-887244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B50C37A50
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE643B77A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3698F34A767;
	Wed,  5 Nov 2025 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+lyJ/Ic"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D3346764
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373459; cv=none; b=oWae96bJZsfIxEei0u7GU01DGHH1DhtflREKKJCkrcZTZkB/YmkssnSgHuItaL+Zkv1IhSkWfOwbIPn59ds7biKuhoBylGLSS1g3ovFG7hYHbCkZrDa9E8uZluWLtg3ECrJgAvpWkJxvaXD1D4gLk2v7lyYrtoPS76CVqz0OJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373459; c=relaxed/simple;
	bh=nQcgUg1tamkssa25I7SceYXz9LMVdMlx1H4xuC6WOO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BR1i7G/EOKVkeiI4iaKoyP/s8Dfm+PWgQR+5rwOJUSBdejtrVCW7pAjxEMLA+/UJw+eciEGcntnWIMZLLjtMj+POqg3ZatgaST8QrsvzMZOy3D9iOztpdnWMgZgaOUadihywdtKS+dkYzjD7c0/490gucEN0vSCYj2RL1zhVkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+lyJ/Ic; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429b895458cso143150f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373456; x=1762978256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II8Ps1o8HVI6iyVPZpBUMlThSw7mZMjPEJaIwTAG0oE=;
        b=m+lyJ/Icsfb9zzjbCXY1L3504Hjj9ix+4qL0eJzeTCtKMCr+AnmVKDgP1OlT6ovh1U
         KI4QQkgTRA809x5lBO3ZXzQ0U/YlvvAEamPCt9joWE4HNHHQHcy+Nx4DeB5Ugrf+ASA6
         Szx5mXPRRfk2s7hlsx2zHJRlbXFLI/4bAaU6AwMulIeVW4vHXslFUcaUG7lXqUhwhiGh
         sGUwPTmscInFmdf9meICUoK6ot5WNXMTDZ6OB9cKlIxeFKVLKpa4YE2JAuam3vI5g20Q
         2t6nF+b0ejL7ptuHWO0mcTWqTwkgqLdGU95ObUoJY8mSNNpyuyMl2XRSQEYaE3BceE8z
         +BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373456; x=1762978256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II8Ps1o8HVI6iyVPZpBUMlThSw7mZMjPEJaIwTAG0oE=;
        b=bw5iE5cGbakvP//ilX9FkbO/MLfyVGIhhLZ/EV/0bW1AEeZ82DSAchq+jgN0UlMjsP
         7yPH6DSsFNPEPwRa4oOCKtJTJA8pXq4TV4iFSds78T5ccapPRYitJ4Fe2+TRqEro/KKx
         zQ9JKIiDxVTQ5bHF/mhSmPoRGw4WkqbMF5738aHQuJIvfK9ZD8VSpFrVi8UIb189DaQ0
         7uIA41o9jHCXCSUD11DJcXbE7KMQyLn1sE9zGRHxeiwdIJ66wa2AoQ10OqIX9uYkM/tR
         2R7oFfSK9PFjMo8rw8F/ve7yl56R+AV59FyL19gVBoEz9ZZ12lwD6L2Xgh0kmgcxagAl
         Jh5A==
X-Forwarded-Encrypted: i=1; AJvYcCWkSGzb8tlzihXV+u4r2S2Ma0COavpaLXMG5D5MB78el5MnBO2/T1qTSbKfg3FjjhkvUwYNJ8EM4TwFk60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1u6kmmYYDRJrG8JsFUMqA6lke3n33onkFhSfKnT7mAzCNHJ33
	tmLYeaStEG+/F9AbJq7XH2yEHboeLgC3T4MQCL/XlVce5UQnxeF8N4/B+TJC5g==
X-Gm-Gg: ASbGncuaQ15Irt+EsVpIfkxAhDJap8dvaZQCjOUu//5y0skSTFh8mWTL1TpWuE/g32c
	xoVotae61UFg8tksTVe+l+i8mndEeuxspppro2eL5nYLmSyv6cdpEdaA4USyRSM8s5FyvWjGpS/
	MYryR++hJlUU15FcZrhf5WZzZyHVWqk2Cj8PieH9OrLVFh+QXSfqkliwQVTpkJfIaQ9u26nqwvk
	5HySZ6mwCbLl9F+INMAiya2Bdi423yisM7MmSBU1Yr+DVmF6duNcCAhvAaDo91TlTuh/f3Uwgmt
	EUOLnuzli8WZCTpRNVCC4KTPVysFmFPamsAC73tQe7x5xfyypUFP5i2tnUCs/ltT6dfufVzya6H
	dzVJ3eR6XbbfVdTPz9nVditOR/+XXC5pEss6tjHHjlVDyTZMWnCOImwG1lg6u6trlyA0eXkLh6G
	GYIbR/E3DbQrgfNnti9Wcy00dlZRJmkgAsiUuTbSM7/nhH6kLL3tMdvENVPneC+w==
X-Google-Smtp-Source: AGHT+IFY/hfFUcD5QeTt/6rC82/eckDEwN1+xJtfeQzmZxu7KUWEW9CJn2N6Pg3PBnCs5EhLLZ9/XQ==
X-Received: by 2002:a05:6000:1889:b0:429:c4bb:fbd9 with SMTP id ffacd0b85a97d-429e32e43d8mr3860797f8f.17.1762373455729;
        Wed, 05 Nov 2025 12:10:55 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm619857f8f.17.2025.11.05.12.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:10:55 -0800 (PST)
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
Subject: [PATCH v5 next 6/9] lib: test_mul_u64_u64_div_u64: Test both generic and arch versions
Date: Wed,  5 Nov 2025 20:10:32 +0000
Message-Id: <20251105201035.64043-7-david.laight.linux@gmail.com>
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
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
---

Changes for v4:
- Fix build on non x86 (eg arm32)

Changes for v5:
- Fix build on 32bit x86

 lib/math/div64.c                    |  8 +++--
 lib/math/test_mul_u64_u64_div_u64.c | 52 +++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index a88391b8ada0..18a9ba26c418 100644
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
index 4d5e4e5dac67..d8d2c18c4614 100644
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
 
@@ -106,15 +119,40 @@ static int __init test_init(void)
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
+#undef __div64_32
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



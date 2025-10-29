Return-Path: <linux-kernel+bounces-876847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA2C1C892
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38C024E519B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12FA355811;
	Wed, 29 Oct 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvYTQF4O"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4ED3546FA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759561; cv=none; b=QUKaEXtJ1r7ZPvX4/hCwrNfqQYMwXlh2i6pajJ9vQ9rsP/c4NbLiANPM6VudQcawIIUh2PfbmqQ1Ad6qzhjV1ZmIz+KV53vjK7MVJp0QjzUghNK11xDECSzB1Te/qe43NDlhN+hFD3Z58MxX2KxNDn6sK8M6pw+LgYT/WV/eySw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759561; c=relaxed/simple;
	bh=brQAKaBI2JfxL3nHimpmQqMYkcAGVahG+LND6RewIig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0bFs+DUelSyHYv4Dk8GkoV/nZ46kAkz+J9T2D42rY0ByFxlbdwU0enVjhsLGK6sldPsXEO7F94PLsQtwO0ZOJ87DwuRqqzsjfi6Xmvgpl9RL6Mj55svVgwqP23pr1KIqsteL+GMY8B5Bef5XODIB+JoscPqciBTb6Fez/uWtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvYTQF4O; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4711b95226dso1634295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759557; x=1762364357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7HOVAqPQPihhZufx2AkZx0/NAZTeNOfsgPjqdl0hO8=;
        b=RvYTQF4OxdAChN9ssfyJn/TFdrOS6CaXp/M+hXZW+knXqSHvBYSxgQmOTmBHg61Mih
         Mdn8BdAgufPvXvyYka/H6ep2L3yjqt59wQt5cJEn38EyNqkFJ7O3deF0SfiHv/CktixV
         URwfT4Q1l8xeT7L9zH8iTXKs9EoTPbU3aFs454wf+RxgwqQJ9y/RmVQ0f6eWy+0KPGsy
         x44UfbGgBLDjA/ekXxLlc7Atb+btUSvDD6zatR37DsZ0umK63LoJ2MoeU2ZS7HJmkUlx
         CEv5hLM4IIQeQ2BhD1biAjG9ETuPJunoP8wQveqGayr6jXtz9WjEzqi1eV4wmZVeXGOs
         wpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759557; x=1762364357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7HOVAqPQPihhZufx2AkZx0/NAZTeNOfsgPjqdl0hO8=;
        b=rkXKU8as08gBr1ifeAekKNPscW1Ou3M6POlQEm6lk7CJYlXPBQmR+bG1PDm2nUnvZG
         RD4VLmC4TPdadNk1HgLo4RxGhdWGhPVSD9gBI6Bsru34rNagPSDX7gFbJQHtScuXD0ea
         e+S3LJKfcsI2fgnv84bRf6xN8UN6ccNOaD8qE2PttHhqVYgQfjjJPJNU9bSSvtalD2WG
         FSwJAtGTdJtt289gOlELDf3U5BGX4/foKYTTnZWm7iBmYn8YpefNBImmXP4mGQocYmoU
         tnv+bR5FS24dhz7IVzFLJ4Cyn17CWE7/waoko6lATdAQrSVryI/HXschVkrnBn+mTwGu
         zwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYI6n9ROCcBdVo4GdIhJAYeAb5dzu7ESr8D5fHSWHKxQ336UlZ/PS0lsPHVL51jdZWVR7d8Hx2mKqFfLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymTpxpCW94BHA3/fXDGMNP9caHKuStu1RX55zf8RsxS8g1hHCR
	SYfNStdZwno9padnK3ACE236vx0Sl9EIJwTEb/TChUvvL52IeFfbngvH
X-Gm-Gg: ASbGncv9aJpr7/cH+p12bJKTVHOniNnxlk74Wt6MnAl+sIl4ZoeC2BzhYqfXUlNedac
	JE9AG8rUpuEwhwjhOX4zrQo0pQu4DYLvvlFJaPcMl6HqWZ+zVm6hWSLC73Cjifubb7C0dSl86cR
	+W83lIqlNXwN8Yo+/9nIJwd653ZwKGCdHW/zxU2paVPZbxM2uVyKbl+OxpXgXvmFx6M8p/L3OJs
	NEc3kvag/i7W5/x45CQgpaiByggfdoB88qV6Z/TE1uyFFGDgopIE3DySJTE6LAbx1WqitDXchc2
	cPwywbK3hHZLx4dyPXVo5FhbL0wdwkl3Bd4qun3JsF5a7oO1d36xmgl4+ocw2h/oHvmC7NfOdn2
	NLhDC/O3GVvOeDw5AWoicVFIuVGuP9UnkIKdU2mNtluSxDrbTMtcmPUzkZuQCNNk+bUBTSxanDm
	GH1JtzYcK0lkPmfru3tBq8XZngjzGWuRO9k0AGB3yGf4oI9GTF29Pef3KNaqxb
X-Google-Smtp-Source: AGHT+IGFqmYWf+rtSScU1XDloRcGj38Kn6CXlOyj9qu6LQygMLJUmRHYLZRh5gN1e522TppcU6eDUg==
X-Received: by 2002:a05:600c:1f93:b0:477:1bb6:17e5 with SMTP id 5b1f17b1804b1-4771e3fbbf8mr31470175e9.30.1761759556433;
        Wed, 29 Oct 2025 10:39:16 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm70646865e9.17.2025.10.29.10.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:39:16 -0700 (PDT)
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
Subject: [PATCH v4 next 5/9] lib: Add tests for mul_u64_u64_div_u64_roundup()
Date: Wed, 29 Oct 2025 17:38:24 +0000
Message-Id: <20251029173828.3682-6-david.laight.linux@gmail.com>
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

Replicate the existing mul_u64_u64_div_u64() test cases with round up.
Update the shell script that verifies the table, remove the comment
markers so that it can be directly pasted into a shell.

Rename the divisor from 'c' to 'd' to match mul_u64_add_u64_div_u64().

It any tests fail then fail the module load with -EINVAL.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Changes for v3:
- Rename 'c' to 'd' to match mul_u64_add_u64_div_u64()

Changes for v4:
- Fix shell script that verifies the table

 lib/math/test_mul_u64_u64_div_u64.c | 122 +++++++++++++++++-----------
 1 file changed, 73 insertions(+), 49 deletions(-)

diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/test_mul_u64_u64_div_u64.c
index 58d058de4e73..4d5e4e5dac67 100644
--- a/lib/math/test_mul_u64_u64_div_u64.c
+++ b/lib/math/test_mul_u64_u64_div_u64.c
@@ -10,61 +10,73 @@
 #include <linux/printk.h>
 #include <linux/math64.h>
 
-typedef struct { u64 a; u64 b; u64 c; u64 result; } test_params;
+typedef struct { u64 a; u64 b; u64 d; u64 result; uint round_up;} test_params;
 
 static test_params test_values[] = {
 /* this contains many edge values followed by a couple random values */
-{                0xb,                0x7,                0x3,               0x19 },
-{         0xffff0000,         0xffff0000,                0xf, 0x1110eeef00000000 },
-{         0xffffffff,         0xffffffff,                0x1, 0xfffffffe00000001 },
-{         0xffffffff,         0xffffffff,                0x2, 0x7fffffff00000000 },
-{        0x1ffffffff,         0xffffffff,                0x2, 0xfffffffe80000000 },
-{        0x1ffffffff,         0xffffffff,                0x3, 0xaaaaaaa9aaaaaaab },
-{        0x1ffffffff,        0x1ffffffff,                0x4, 0xffffffff00000000 },
-{ 0xffff000000000000, 0xffff000000000000, 0xffff000000000001, 0xfffeffffffffffff },
-{ 0x3333333333333333, 0x3333333333333333, 0x5555555555555555, 0x1eb851eb851eb851 },
-{ 0x7fffffffffffffff,                0x2,                0x3, 0x5555555555555554 },
-{ 0xffffffffffffffff,                0x2, 0x8000000000000000,                0x3 },
-{ 0xffffffffffffffff,                0x2, 0xc000000000000000,                0x2 },
-{ 0xffffffffffffffff, 0x4000000000000004, 0x8000000000000000, 0x8000000000000007 },
-{ 0xffffffffffffffff, 0x4000000000000001, 0x8000000000000000, 0x8000000000000001 },
-{ 0xffffffffffffffff, 0x8000000000000001, 0xffffffffffffffff, 0x8000000000000001 },
-{ 0xfffffffffffffffe, 0x8000000000000001, 0xffffffffffffffff, 0x8000000000000000 },
-{ 0xffffffffffffffff, 0x8000000000000001, 0xfffffffffffffffe, 0x8000000000000001 },
-{ 0xffffffffffffffff, 0x8000000000000001, 0xfffffffffffffffd, 0x8000000000000002 },
-{ 0x7fffffffffffffff, 0xffffffffffffffff, 0xc000000000000000, 0xaaaaaaaaaaaaaaa8 },
-{ 0xffffffffffffffff, 0x7fffffffffffffff, 0xa000000000000000, 0xccccccccccccccca },
-{ 0xffffffffffffffff, 0x7fffffffffffffff, 0x9000000000000000, 0xe38e38e38e38e38b },
-{ 0x7fffffffffffffff, 0x7fffffffffffffff, 0x5000000000000000, 0xccccccccccccccc9 },
-{ 0xffffffffffffffff, 0xfffffffffffffffe, 0xffffffffffffffff, 0xfffffffffffffffe },
-{ 0xe6102d256d7ea3ae, 0x70a77d0be4c31201, 0xd63ec35ab3220357, 0x78f8bf8cc86c6e18 },
-{ 0xf53bae05cb86c6e1, 0x3847b32d2f8d32e0, 0xcfd4f55a647f403c, 0x42687f79d8998d35 },
-{ 0x9951c5498f941092, 0x1f8c8bfdf287a251, 0xa3c8dc5f81ea3fe2, 0x1d887cb25900091f },
-{ 0x374fee9daa1bb2bb, 0x0d0bfbff7b8ae3ef, 0xc169337bd42d5179, 0x03bb2dbaffcbb961 },
-{ 0xeac0d03ac10eeaf0, 0x89be05dfa162ed9b, 0x92bb1679a41f0e4b, 0xdc5f5cc9e270d216 },
+{                0xb,                0x7,                0x3,               0x19, 1 },
+{         0xffff0000,         0xffff0000,                0xf, 0x1110eeef00000000, 0 },
+{         0xffffffff,         0xffffffff,                0x1, 0xfffffffe00000001, 0 },
+{         0xffffffff,         0xffffffff,                0x2, 0x7fffffff00000000, 1 },
+{        0x1ffffffff,         0xffffffff,                0x2, 0xfffffffe80000000, 1 },
+{        0x1ffffffff,         0xffffffff,                0x3, 0xaaaaaaa9aaaaaaab, 0 },
+{        0x1ffffffff,        0x1ffffffff,                0x4, 0xffffffff00000000, 1 },
+{ 0xffff000000000000, 0xffff000000000000, 0xffff000000000001, 0xfffeffffffffffff, 1 },
+{ 0x3333333333333333, 0x3333333333333333, 0x5555555555555555, 0x1eb851eb851eb851, 1 },
+{ 0x7fffffffffffffff,                0x2,                0x3, 0x5555555555555554, 1 },
+{ 0xffffffffffffffff,                0x2, 0x8000000000000000,                0x3, 1 },
+{ 0xffffffffffffffff,                0x2, 0xc000000000000000,                0x2, 1 },
+{ 0xffffffffffffffff, 0x4000000000000004, 0x8000000000000000, 0x8000000000000007, 1 },
+{ 0xffffffffffffffff, 0x4000000000000001, 0x8000000000000000, 0x8000000000000001, 1 },
+{ 0xffffffffffffffff, 0x8000000000000001, 0xffffffffffffffff, 0x8000000000000001, 0 },
+{ 0xfffffffffffffffe, 0x8000000000000001, 0xffffffffffffffff, 0x8000000000000000, 1 },
+{ 0xffffffffffffffff, 0x8000000000000001, 0xfffffffffffffffe, 0x8000000000000001, 1 },
+{ 0xffffffffffffffff, 0x8000000000000001, 0xfffffffffffffffd, 0x8000000000000002, 1 },
+{ 0x7fffffffffffffff, 0xffffffffffffffff, 0xc000000000000000, 0xaaaaaaaaaaaaaaa8, 1 },
+{ 0xffffffffffffffff, 0x7fffffffffffffff, 0xa000000000000000, 0xccccccccccccccca, 1 },
+{ 0xffffffffffffffff, 0x7fffffffffffffff, 0x9000000000000000, 0xe38e38e38e38e38b, 1 },
+{ 0x7fffffffffffffff, 0x7fffffffffffffff, 0x5000000000000000, 0xccccccccccccccc9, 1 },
+{ 0xffffffffffffffff, 0xfffffffffffffffe, 0xffffffffffffffff, 0xfffffffffffffffe, 0 },
+{ 0xe6102d256d7ea3ae, 0x70a77d0be4c31201, 0xd63ec35ab3220357, 0x78f8bf8cc86c6e18, 1 },
+{ 0xf53bae05cb86c6e1, 0x3847b32d2f8d32e0, 0xcfd4f55a647f403c, 0x42687f79d8998d35, 1 },
+{ 0x9951c5498f941092, 0x1f8c8bfdf287a251, 0xa3c8dc5f81ea3fe2, 0x1d887cb25900091f, 1 },
+{ 0x374fee9daa1bb2bb, 0x0d0bfbff7b8ae3ef, 0xc169337bd42d5179, 0x03bb2dbaffcbb961, 1 },
+{ 0xeac0d03ac10eeaf0, 0x89be05dfa162ed9b, 0x92bb1679a41f0e4b, 0xdc5f5cc9e270d216, 1 },
 };
 
 /*
  * The above table can be verified with the following shell script:
- *
- * #!/bin/sh
- * sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\1 \2 \3 \4/p' \
- *     lib/math/test_mul_u64_u64_div_u64.c |
- * while read a b c r; do
- *   expected=$( printf "obase=16; ibase=16; %X * %X / %X\n" $a $b $c | bc )
- *   given=$( printf "%X\n" $r )
- *   if [ "$expected" = "$given" ]; then
- *     echo "$a * $b / $c = $r OK"
- *   else
- *     echo "$a * $b / $c = $r is wrong" >&2
- *     echo "should be equivalent to 0x$expected" >&2
- *     exit 1
- *   fi
- * done
+
+#!/bin/sh
+sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\1 \2 \3 \4 \5/p' \
+    lib/math/test_mul_u64_u64_div_u64.c |
+while read a b d r e; do
+  expected=$( printf "obase=16; ibase=16; %X * %X / %X\n" $a $b $d | bc )
+  given=$( printf "%X\n" $r )
+  if [ "$expected" = "$given" ]; then
+    echo "$a * $b  / $d = $r OK"
+  else
+    echo "$a * $b  / $d = $r is wrong" >&2
+    echo "should be equivalent to 0x$expected" >&2
+    exit 1
+  fi
+  expected=$( printf "obase=16; ibase=16; (%X * %X + %X) / %X\n" $a $b $((d-1)) $d | bc )
+  given=$( printf "%X\n" $((r + e)) )
+  if [ "$expected" = "$given" ]; then
+    echo "$a * $b +/ $d = $(printf '%#x' $((r + e))) OK"
+  else
+    echo "$a * $b +/ $d = $(printf '%#x' $((r + e))) is wrong" >&2
+    echo "should be equivalent to 0x$expected" >&2
+    exit 1
+  fi
+done
+
  */
 
 static int __init test_init(void)
 {
+	int errors = 0;
+	int tests = 0;
 	int i;
 
 	pr_info("Starting mul_u64_u64_div_u64() test\n");
@@ -72,19 +84,31 @@ static int __init test_init(void)
 	for (i = 0; i < ARRAY_SIZE(test_values); i++) {
 		u64 a = test_values[i].a;
 		u64 b = test_values[i].b;
-		u64 c = test_values[i].c;
+		u64 d = test_values[i].d;
 		u64 expected_result = test_values[i].result;
-		u64 result = mul_u64_u64_div_u64(a, b, c);
+		u64 result = mul_u64_u64_div_u64(a, b, d);
+		u64 result_up = mul_u64_u64_div_u64_roundup(a, b, d);
+
+		tests += 2;
 
 		if (result != expected_result) {
-			pr_err("ERROR: 0x%016llx * 0x%016llx / 0x%016llx\n", a, b, c);
+			pr_err("ERROR: 0x%016llx * 0x%016llx / 0x%016llx\n", a, b, d);
 			pr_err("ERROR: expected result: %016llx\n", expected_result);
 			pr_err("ERROR: obtained result: %016llx\n", result);
+			errors++;
+		}
+		expected_result += test_values[i].round_up;
+		if (result_up != expected_result) {
+			pr_err("ERROR: 0x%016llx * 0x%016llx +/ 0x%016llx\n", a, b, d);
+			pr_err("ERROR: expected result: %016llx\n", expected_result);
+			pr_err("ERROR: obtained result: %016llx\n", result_up);
+			errors++;
 		}
 	}
 
-	pr_info("Completed mul_u64_u64_div_u64() test\n");
-	return 0;
+	pr_info("Completed mul_u64_u64_div_u64() test, %d tests, %d errors\n",
+		tests, errors);
+	return errors ? -EINVAL : 0;
 }
 
 static void __exit test_exit(void)
-- 
2.39.5



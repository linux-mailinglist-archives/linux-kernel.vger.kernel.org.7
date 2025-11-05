Return-Path: <linux-kernel+bounces-887243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A6BC37A53
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780BA188B8F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BDF348884;
	Wed,  5 Nov 2025 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8D84cAy"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED42345CC6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373458; cv=none; b=XGHYA3ybOcO1+HNTa+8wsHO8nn0tccXdfh+HP5ZNbm1zeEhOFtu5kOZZUjT+mAqiu5n8QyL+1Sf1U0+ZeAMwgZfh+fhsbjA9hfz7cIhKivnXgtK8A8QLjgD3fUlnYio/5xVbO909tOa7x4oq1XqoM6aIvw3g8ntRr19hECu99Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373458; c=relaxed/simple;
	bh=SE1UQRnPEKhTNhIK/TT/prwPCxvLiTm6vXZUGaBu40M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBLwfNonvidlNFklVLXJXYE2S159MLyKl9XTTGUTXVopnjk1QsJEvDmtZeJ3hqyCvFqRtOjroKF38cTw6JJohVUSSf4fgf5bYQnxap7kYE0IH6gZzt6FozuG5ZXQ857EvED+lwo/RME9+LwAumiOcX5nfvBE8gDDqPYltSAG25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8D84cAy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso157804f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373455; x=1762978255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnISXxbbuCs9wWXUfoIS/DH5ed/+RGS24ZfJrQTNFHc=;
        b=R8D84cAyNVc/lCTj+doH008wfmQusq2v0YtGfH5Z1OBqk4wR/XmssBEtsFydH10IdG
         wrBtOthV0xbOqZ4K8uKC7YcQtB2Qvz9zprSyrGiBd2UwJnXG13+pMau+GetzYONgpm2O
         Vs6ayrq5D+lziaGRsWrML5EJI0qwIBrt5PxhgONPxkWCoK+c2zThQEwFO9jwZAZczyy/
         6YyrAkaSqfe6jV2bVXPHkCqOeUSgbbjNLVG4rzq0xn56wohpNulGXGdTS7mMuebGxseo
         FUluzKTCL7TjUnoRCo/aYfHqdVMsKzMiQBni1VMEfpbUV8XP7UBE/KfUuMQ3cyhCJd1l
         fJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373455; x=1762978255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tnISXxbbuCs9wWXUfoIS/DH5ed/+RGS24ZfJrQTNFHc=;
        b=ioczsUU26yxH4yOKeYszsWcNvywSYsVWEF+9w6i4ufH60TBpPyTQMm03+9sSePhlgM
         aitchYy1DkNbWmaHNHWhX8hFO7F6cV917WmfRiFIEgL42IctmjLdH9flcTxvd4U9LTKS
         DEhz+j0Ch0Hb/81MWzTK3OrfYFM05n5COBQQwD/S4rJlXjkICA0KlXDMPKs/832mpykA
         Ck0GtHFzeBwIO3a2BdPDoHGMhDpRe9X2KChhmyfe0E2/DKtir07ZqX91lOAA4vNkUNG3
         lUpBBSHQDNN3rw1MzSP0OCSMxb6+R2QSm58uQLOZIIF/mR7ueov3fcRi+2asaRPRnrMw
         mCrg==
X-Forwarded-Encrypted: i=1; AJvYcCVC9MU9Ac5Mkf0wZiRqe611tdsnvZvK0iB6W3AwTHnD6kKEA8CJmIrX8BE/mBmhroJh7EfcX72dDz1luyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJkg6vQ5DfT+8xD4VJ1bYEGJpyfOsog+SkhmfODk6FBsKk/6mM
	oyvIBQxwfjgfTqjOW2dvyHHBxsk0Bxr8N4f7vOTBTLDwwIVeAa7DFlPQ
X-Gm-Gg: ASbGnct02uDhmDWzBayjDH4E47M7Ezqa3p9xJPPGf5zoI0VKOK1zOuuDnBmUHBcla3R
	CMT7BmO+eUGtKJhaXn161v6NieC4814SHx/rdDVhZNIGQCPZNgYy6q7SpaSPs/inunnq+9VooCJ
	VzA1ALpQXBxuomEg06ytXNTf10w9ExpyDMhVsYKPl9atIMv2vIX0sBJonQ6bYCh3ryPsRxvXNFL
	GuXJ3mGt/GnGD8FetIBki5p0W3sEoaEXoaIq0PyYjyuuI07NrmTQMRC+eu76DedVoyJWjga0TKO
	LnL+h1Pj0nZaZSi4PQU6A+xNgaEvgY8mG3fDkqZ5iaNSYzhjTFgzokCjh5y+3Jgg66eQKn/tovI
	QYwrbaZVKCqmnTAIQ2zeHB7QXuYfmigebx0uGlG2Q8k7VTFE71qrl5/Ha4pJau0iDJ0/2J0ICtu
	ou3mNoJYHQ+kg1VZDHGmbwGtANu25NSLvrBOPnzz/zdFd6DlFmsm+QiKDb1gqOnZopQIjL52OF
X-Google-Smtp-Source: AGHT+IEJznuzPxKOkxO5jMoPlA9leM3O1XtF3OXGMcU9U8E9hG/y7HhGXncxOeNL9Mpo/1nwg5LPAg==
X-Received: by 2002:a05:6000:3111:b0:429:d253:8619 with SMTP id ffacd0b85a97d-429eb12faebmr628051f8f.5.1762373454939;
        Wed, 05 Nov 2025 12:10:54 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm619857f8f.17.2025.11.05.12.10.54
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
Subject: [PATCH v5 next 5/9] lib: Add tests for mul_u64_u64_div_u64_roundup()
Date: Wed,  5 Nov 2025 20:10:31 +0000
Message-Id: <20251105201035.64043-6-david.laight.linux@gmail.com>
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

Replicate the existing mul_u64_u64_div_u64() test cases with round up.
Update the shell script that verifies the table, remove the comment
markers so that it can be directly pasted into a shell.

Rename the divisor from 'c' to 'd' to match mul_u64_add_u64_div_u64().

It any tests fail then fail the module load with -EINVAL.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
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



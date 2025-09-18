Return-Path: <linux-kernel+bounces-804473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE3B47799
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 23:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0D7A08351
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9AF2C08C4;
	Sat,  6 Sep 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHpEawtO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC882BF3CC;
	Sat,  6 Sep 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757194623; cv=none; b=BnGCZW/TByBmNFih8tKfpZhh+17pxbid0RZkAOe124aAmfTEe4K1X9Tt8MRt9i4Y0V2ENo4fbq9tw9S9uhrlHe3FfAoy/m4Sv4wWNthHh2eY2SybKlRK7+zM0RoKsxiv3DiL44Nh66nLcdgaeUYAvw4PMQXKImr4N3KZsvF3N1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757194623; c=relaxed/simple;
	bh=tzGI0nGLAWdIcbdPPsgLKUoZLaVZT1uXpdHfuiLD0g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtUBsexvjcB+9jvlAp+XTGiFyhNna575tbEB80SApzmsLH+vyE0kRoD4je8b9oLljJH19J093+bW+XhI79tZPobmYzokTJYds0qEdKzdRHRcbC8oQwbkUCHq7wJXyCRNk4d1AhvwK7SM+aYxsAuQ/CcaYL4zNIXKVVhlax1iKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHpEawtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4550C4CEE7;
	Sat,  6 Sep 2025 21:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757194623;
	bh=tzGI0nGLAWdIcbdPPsgLKUoZLaVZT1uXpdHfuiLD0g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHpEawtOaPMFgazeibQBP4YKM4CphYALdcZ5G0xnacCc6i8Ak32AsUJpFuOVUzJzz
	 Jj4wAKaqjNGnPQuORFGDndAHzzGw/h3QgB66ELqxwB1XJzXvpa1ZKXjqgNAgVVntFn
	 qj2267pYscDwQuziV9Sl/7b94Re54nq+y8CpH+Lge2eGc0VLyUJNNoMQdzair8ju4e
	 j5u9Y2SMCHLEyY/aiqqurKQzyxH3ezm+NpUieTZx3JFRvAHcLQFmyF1FFii9C168kk
	 QGPT8s31r3SqK/9fvdeNIzYR9gHAQ3yGpuP9zhMWreu2KEwpeYkzo8lFCM6DLq1qx6
	 lqVdy+qFmaf5w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Zhiqi Song <songzhiqi1@huawei.com>,
	Longfang Liu <liulongfang@huawei.com>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 07/12] lib/crypto: tests: Migrate Curve25519 self-test to KUnit
Date: Sat,  6 Sep 2025 14:35:18 -0700
Message-ID: <20250906213523.84915-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250906213523.84915-1-ebiggers@kernel.org>
References: <20250906213523.84915-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the Curve25519 test from an ad-hoc self-test to a KUnit test.

Generally keep the same test logic for now, just translated to KUnit.
There's one exception, which is that I dropped the incomplete test of
curve25519_generic().  The approach I'm taking to cover the different
implementations with the KUnit tests is to just rely on booting kernels
in QEMU with different '-cpu' options, rather than try to make the tests
(incompletely) test multiple implementations on one CPU.  This way, both
the test and the library API are simpler.

This commit makes the file lib/crypto/curve25519.c no longer needed, as
its only purpose was to call the self-test.  However, keep it for now,
since a later commit will add code to it again.

Temporarily omit the default value of CRYPTO_SELFTESTS that the other
lib/crypto/ KUnit tests have.  It would cause a recursive kconfig
dependency, since the Curve25519 code is still entangled with CRYPTO.  A
later commit will fix that.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/crypto/curve25519.h                   |  2 -
 lib/crypto/Makefile                           |  1 -
 lib/crypto/curve25519.c                       |  3 -
 lib/crypto/tests/Kconfig                      |  9 +++
 lib/crypto/tests/Makefile                     |  1 +
 .../curve25519_kunit.c}                       | 70 +++++++++++--------
 6 files changed, 49 insertions(+), 37 deletions(-)
 rename lib/crypto/{curve25519-selftest.c => tests/curve25519_kunit.c} (97%)

diff --git a/include/crypto/curve25519.h b/include/crypto/curve25519.h
index ece6a9b5fafc8..4e6dc840b1592 100644
--- a/include/crypto/curve25519.h
+++ b/include/crypto/curve25519.h
@@ -26,12 +26,10 @@ void curve25519_arch(u8 out[CURVE25519_KEY_SIZE],
 		     const u8 point[CURVE25519_KEY_SIZE]);
 
 void curve25519_base_arch(u8 pub[CURVE25519_KEY_SIZE],
 			  const u8 secret[CURVE25519_KEY_SIZE]);
 
-bool curve25519_selftest(void);
-
 static inline
 bool __must_check curve25519(u8 mypublic[CURVE25519_KEY_SIZE],
 			     const u8 secret[CURVE25519_KEY_SIZE],
 			     const u8 basepoint[CURVE25519_KEY_SIZE])
 {
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index ad27c5bf99e11..6c3be971ace09 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -85,11 +85,10 @@ ifeq ($(call clang-min-version, 180000),)
 KASAN_SANITIZE_curve25519-hacl64.o := n
 endif
 
 obj-$(CONFIG_CRYPTO_LIB_CURVE25519)		+= libcurve25519.o
 libcurve25519-y					+= curve25519.o
-libcurve25519-$(CONFIG_CRYPTO_SELFTESTS)	+= curve25519-selftest.o
 
 obj-$(CONFIG_CRYPTO_LIB_DES)			+= libdes.o
 libdes-y					:= des.o
 
 ################################################################################
diff --git a/lib/crypto/curve25519.c b/lib/crypto/curve25519.c
index 6850b76a80c9e..25f16777865bf 100644
--- a/lib/crypto/curve25519.c
+++ b/lib/crypto/curve25519.c
@@ -13,13 +13,10 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
 static int __init curve25519_init(void)
 {
-	if (IS_ENABLED(CONFIG_CRYPTO_SELFTESTS) &&
-	    WARN_ON(!curve25519_selftest()))
-		return -ENODEV;
 	return 0;
 }
 
 static void __exit curve25519_exit(void)
 {
diff --git a/lib/crypto/tests/Kconfig b/lib/crypto/tests/Kconfig
index fd341aa12f157..eaca60d3e0a36 100644
--- a/lib/crypto/tests/Kconfig
+++ b/lib/crypto/tests/Kconfig
@@ -8,10 +8,19 @@ config CRYPTO_LIB_BLAKE2S_KUNIT_TEST
 	# No need to select CRYPTO_LIB_BLAKE2S here, as that option doesn't
 	# exist; the BLAKE2s code is always built-in for the /dev/random driver.
 	help
 	  KUnit tests for the BLAKE2s cryptographic hash function.
 
+config CRYPTO_LIB_CURVE25519_KUNIT_TEST
+	tristate "KUnit tests for Curve25519" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select CRYPTO_LIB_BENCHMARK_VISIBLE
+	select CRYPTO_LIB_CURVE25519
+	help
+	  KUnit tests for the Curve25519 Diffie-Hellman function.
+
 config CRYPTO_LIB_MD5_KUNIT_TEST
 	tristate "KUnit tests for MD5" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
diff --git a/lib/crypto/tests/Makefile b/lib/crypto/tests/Makefile
index be7de929af2cc..a71fad19922ba 100644
--- a/lib/crypto/tests/Makefile
+++ b/lib/crypto/tests/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 obj-$(CONFIG_CRYPTO_LIB_BLAKE2S_KUNIT_TEST) += blake2s_kunit.o
+obj-$(CONFIG_CRYPTO_LIB_CURVE25519_KUNIT_TEST) += curve25519_kunit.o
 obj-$(CONFIG_CRYPTO_LIB_MD5_KUNIT_TEST) += md5_kunit.o
 obj-$(CONFIG_CRYPTO_LIB_POLY1305_KUNIT_TEST) += poly1305_kunit.o
 obj-$(CONFIG_CRYPTO_LIB_SHA1_KUNIT_TEST) += sha1_kunit.o
 obj-$(CONFIG_CRYPTO_LIB_SHA256_KUNIT_TEST) += sha224_kunit.o sha256_kunit.o
 obj-$(CONFIG_CRYPTO_LIB_SHA512_KUNIT_TEST) += sha384_kunit.o sha512_kunit.o
diff --git a/lib/crypto/curve25519-selftest.c b/lib/crypto/tests/curve25519_kunit.c
similarity index 97%
rename from lib/crypto/curve25519-selftest.c
rename to lib/crypto/tests/curve25519_kunit.c
index c85e85381e788..0d1c46ca74018 100644
--- a/lib/crypto/curve25519-selftest.c
+++ b/lib/crypto/tests/curve25519_kunit.c
@@ -2,18 +2,19 @@
 /*
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
 #include <crypto/curve25519.h>
+#include <kunit/test.h>
 
 struct curve25519_test_vector {
 	u8 private[CURVE25519_KEY_SIZE];
 	u8 public[CURVE25519_KEY_SIZE];
 	u8 result[CURVE25519_KEY_SIZE];
 	bool valid;
 };
-static const struct curve25519_test_vector curve25519_test_vectors[] __initconst = {
+static const struct curve25519_test_vector curve25519_test_vectors[] = {
 	{
 		.private = { 0x77, 0x07, 0x6d, 0x0a, 0x73, 0x18, 0xa5, 0x7d,
 			     0x3c, 0x16, 0xc1, 0x72, 0x51, 0xb2, 0x66, 0x45,
 			     0xdf, 0x4c, 0x2f, 0x87, 0xeb, 0xc0, 0x99, 0x2a,
 			     0xb1, 0x77, 0xfb, 0xa5, 0x1d, 0xb9, 0x2c, 0x2a },
@@ -1278,44 +1279,51 @@ static const struct curve25519_test_vector curve25519_test_vectors[] __initconst
 			    0xd9, 0x8b, 0xb9, 0x1b, 0x3e, 0x0b, 0xe0, 0x35 },
 		.valid = true
 	}
 };
 
-bool __init curve25519_selftest(void)
+static void test_curve25519(struct kunit *test)
 {
-	bool success = true, ret, ret2;
-	size_t i = 0, j;
-	u8 in[CURVE25519_KEY_SIZE];
-	u8 out[CURVE25519_KEY_SIZE], out2[CURVE25519_KEY_SIZE],
-	   out3[CURVE25519_KEY_SIZE];
+	for (size_t i = 0; i < ARRAY_SIZE(curve25519_test_vectors); ++i) {
+		const struct curve25519_test_vector *vec =
+			&curve25519_test_vectors[i];
+		u8 out[CURVE25519_KEY_SIZE] = {};
+		bool ret;
 
-	for (i = 0; i < ARRAY_SIZE(curve25519_test_vectors); ++i) {
-		memset(out, 0, CURVE25519_KEY_SIZE);
-		ret = curve25519(out, curve25519_test_vectors[i].private,
-				 curve25519_test_vectors[i].public);
-		if (ret != curve25519_test_vectors[i].valid ||
-		    memcmp(out, curve25519_test_vectors[i].result,
-			   CURVE25519_KEY_SIZE)) {
-			pr_err("curve25519 self-test %zu: FAIL\n", i + 1);
-			success = false;
-		}
+		ret = curve25519(out, vec->private, vec->public);
+		KUNIT_EXPECT_EQ_MSG(test, ret, vec->valid,
+				    "Wrong return value with test vector %zu",
+				    i);
+		KUNIT_EXPECT_MEMEQ_MSG(test, out, vec->result, sizeof(out),
+				       "Wrong output with test vector %zu", i);
 	}
+}
+
+static void test_curve25519_basepoint(struct kunit *test)
+{
+	for (size_t i = 0; i < 5; ++i) {
+		u8 in[CURVE25519_KEY_SIZE];
+		u8 out[CURVE25519_KEY_SIZE];
+		u8 out2[CURVE25519_KEY_SIZE];
+		bool ret, ret2;
 
-	for (i = 0; i < 5; ++i) {
 		get_random_bytes(in, sizeof(in));
 		ret = curve25519_generate_public(out, in);
 		ret2 = curve25519(out2, in, (u8[CURVE25519_KEY_SIZE]){ 9 });
-		curve25519_generic(out3, in, (u8[CURVE25519_KEY_SIZE]){ 9 });
-		if (ret != ret2 ||
-		    memcmp(out, out2, CURVE25519_KEY_SIZE) ||
-		    memcmp(out, out3, CURVE25519_KEY_SIZE)) {
-			pr_err("curve25519 basepoint self-test %zu: FAIL: input - 0x",
-			       i + 1);
-			for (j = CURVE25519_KEY_SIZE; j-- > 0;)
-				printk(KERN_CONT "%02x", in[j]);
-			printk(KERN_CONT "\n");
-			success = false;
-		}
+		KUNIT_EXPECT_EQ_MSG(test, ret, ret2,
+				    "in=%*phN", CURVE25519_KEY_SIZE, in);
+		KUNIT_EXPECT_MEMEQ_MSG(test, out, out2, CURVE25519_KEY_SIZE,
+				       "in=%*phN", CURVE25519_KEY_SIZE, in);
 	}
-
-	return success;
 }
+
+static struct kunit_case curve25519_test_cases[] = {
+	KUNIT_CASE(test_curve25519),
+	KUNIT_CASE(test_curve25519_basepoint),
+	{},
+};
+
+static struct kunit_suite curve25519_test_suite = {
+	.name = "curve25519",
+	.test_cases = curve25519_test_cases,
+};
+kunit_test_suite(curve25519_test_suite);
-- 
2.50.1



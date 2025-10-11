Return-Path: <linux-kernel+bounces-848910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD28DBCECCC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71521895857
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8629F111A8;
	Sat, 11 Oct 2025 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI5Giac4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60EEDF76;
	Sat, 11 Oct 2025 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760141527; cv=none; b=ppn0E5OUNYx0gugXM4Fklix5FOITCHwj+9sOCO9CMvaIPDH5ZGs/1sw8/htKLxlJehVMWUSsVs+kSErBSXWOlYYDu5CCZWqKXPSE5UYaPbD29BdVxUNYxe0Hle/EmOm6j01Zq72Gh6fvCKhXbVdHw/6QjejRpUWIMOyqwcbdO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760141527; c=relaxed/simple;
	bh=nFF+IusTKX/qdwbbl1m8cNUw77rpHuvkWWy9T8iXdUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koQQiWXnvI4/WdMBuGEdo9h2EwHKXr9Gb1ay1YycILnPzSmt4nGg4qTpPuBq5XNOu/oQBvXWJ34hPVWacnQR6Q73AD3aJhUujLEFVSGwMayq99sfwIK+Os6EUbkt/vBIxJjyYguf0gOtkUn38ZjnB5BqH4/gS/f1GzXULLP8q+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI5Giac4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABBEC4CEF1;
	Sat, 11 Oct 2025 00:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760141527;
	bh=nFF+IusTKX/qdwbbl1m8cNUw77rpHuvkWWy9T8iXdUw=;
	h=From:To:Cc:Subject:Date:From;
	b=nI5Giac4Rrz7YUM7T90IAAo6BFLnnUCaELBclsp7irzUAIEgYmMKrqyPm6qWtlEk0
	 M1ZPZHszq20PuKajBn3dt66bQbfR+jDuDfkmW3XIi7Hgv0vtp92YYGchM9SOJ7vdCq
	 yqKKlT/9CYGGwYEEEB0KCvrxZnr1ijHIoaqPQmh6tc1qQNLSLiGKz93txBg8cnv1SO
	 r3zwg6TpSDiwDKNJV/kRBTqyi3yNI+KQZBGJOWzSiRI8JfIkqQ5DHNmqcU0HQDYN5J
	 xPhOhPpCw1eNZ86raTo+Ayu4e77pViuNnyYJgcELeoVH83ZZKsTwj9xnBiuKWDVnEa
	 169+3fTTLnT4Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Joachim Vandersmissen <git@jvdsn.com>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2] lib/crypto: Add FIPS self-tests for SHA-1 and SHA-2
Date: Fri, 10 Oct 2025 17:10:47 -0700
Message-ID: <20251011001047.51886-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add FIPS cryptographic algorithm self-tests for all SHA-1 and SHA-2
algorithms.  Following the "Implementation Guidance for FIPS 140-3"
document, to achieve this it's sufficient to just test a single test
vector for each of HMAC-SHA1, HMAC-SHA256, and HMAC-SHA512.

Just run these tests in the initcalls, following the example of e.g.
crypto/kdf_sp800108.c.  Note that this should meet the FIPS self-test
requirement even in the built-in case, given that the initcalls run
before userspace, storage, network, etc. are accessible.

This does not fix a regression, seeing as lib/ has had SHA-1 support
since 2005 and SHA-256 support since 2018.  Neither ever had FIPS
self-tests.  Moreover, fips=1 support has always been an unfinished
feature upstream.  However, with lib/ now being used more widely, it's
now seeing more scrutiny and people seem to want these now.

Link: https://lore.kernel.org/linux-crypto/20250917184856.GA2560@quark/
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

Changed in v2: 
    - Call them "cryptographic algorithm self-tests" instead of
      "pre-operational self-tests".
    - Add more details to commit message.
    - Fix purgatory build error by omitting the tests from there.

 lib/crypto/fips.h                   | 38 +++++++++++++++++++++++++++++
 lib/crypto/sha1.c                   | 19 ++++++++++++++-
 lib/crypto/sha256.c                 | 26 +++++++++++++++++---
 lib/crypto/sha512.c                 | 19 ++++++++++++++-
 scripts/crypto/gen-fips-testvecs.py | 32 ++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 6 deletions(-)
 create mode 100644 lib/crypto/fips.h
 create mode 100755 scripts/crypto/gen-fips-testvecs.py

diff --git a/lib/crypto/fips.h b/lib/crypto/fips.h
new file mode 100644
index 0000000000000..78a1bdd33a151
--- /dev/null
+++ b/lib/crypto/fips.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* This file was generated by: gen-fips-testvecs.py */
+
+#include <linux/fips.h>
+
+static const u8 fips_test_data[] __initconst __maybe_unused = {
+	0x66, 0x69, 0x70, 0x73, 0x20, 0x74, 0x65, 0x73,
+	0x74, 0x20, 0x64, 0x61, 0x74, 0x61, 0x00, 0x00,
+};
+
+static const u8 fips_test_key[] __initconst __maybe_unused = {
+	0x66, 0x69, 0x70, 0x73, 0x20, 0x74, 0x65, 0x73,
+	0x74, 0x20, 0x6b, 0x65, 0x79, 0x00, 0x00, 0x00,
+};
+
+static const u8 fips_test_hmac_sha1_value[] __initconst __maybe_unused = {
+	0x29, 0xa9, 0x88, 0xb8, 0x5c, 0xb4, 0xaf, 0x4b,
+	0x97, 0x2a, 0xee, 0x87, 0x5b, 0x0a, 0x02, 0x55,
+	0x99, 0xbf, 0x86, 0x78,
+};
+
+static const u8 fips_test_hmac_sha256_value[] __initconst __maybe_unused = {
+	0x59, 0x25, 0x85, 0xcc, 0x40, 0xe9, 0x64, 0x2f,
+	0xe9, 0xbf, 0x82, 0xb7, 0xd3, 0x15, 0x3d, 0x43,
+	0x22, 0x0b, 0x4c, 0x00, 0x90, 0x14, 0x25, 0xcf,
+	0x9e, 0x13, 0x2b, 0xc2, 0x30, 0xe6, 0xe8, 0x93,
+};
+
+static const u8 fips_test_hmac_sha512_value[] __initconst __maybe_unused = {
+	0x6b, 0xea, 0x5d, 0x27, 0x49, 0x5b, 0x3f, 0xea,
+	0xde, 0x2d, 0xfa, 0x32, 0x75, 0xdb, 0x77, 0xc8,
+	0x26, 0xe9, 0x4e, 0x95, 0x4d, 0xad, 0x88, 0x02,
+	0x87, 0xf9, 0x52, 0x0a, 0xd1, 0x92, 0x80, 0x1d,
+	0x92, 0x7e, 0x3c, 0xbd, 0xb1, 0x3c, 0x49, 0x98,
+	0x44, 0x9c, 0x8f, 0xee, 0x3f, 0x02, 0x71, 0x51,
+	0x57, 0x0b, 0x15, 0x38, 0x95, 0xd8, 0xa3, 0x81,
+	0xba, 0xb3, 0x15, 0x37, 0x5c, 0x6d, 0x57, 0x2b,
+};
diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
index 5904e4ae85d24..52788278cd17f 100644
--- a/lib/crypto/sha1.c
+++ b/lib/crypto/sha1.c
@@ -10,10 +10,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/unaligned.h>
 #include <linux/wordpart.h>
+#include "fips.h"
 
 static const struct sha1_block_state sha1_iv = {
 	.h = { SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4 },
 };
 
@@ -328,14 +329,30 @@ void hmac_sha1_usingrawkey(const u8 *raw_key, size_t raw_key_len,
 	hmac_sha1_update(&ctx, data, data_len);
 	hmac_sha1_final(&ctx, out);
 }
 EXPORT_SYMBOL_GPL(hmac_sha1_usingrawkey);
 
-#ifdef sha1_mod_init_arch
+#if defined(sha1_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
 static int __init sha1_mod_init(void)
 {
+#ifdef sha1_mod_init_arch
 	sha1_mod_init_arch();
+#endif
+	if (fips_enabled) {
+		/*
+		 * FIPS cryptographic algorithm self-test.  As per the FIPS
+		 * Implementation Guidance, testing HMAC-SHA1 satisfies the test
+		 * requirement for SHA-1 too.
+		 */
+		u8 mac[SHA1_DIGEST_SIZE];
+
+		hmac_sha1_usingrawkey(fips_test_key, sizeof(fips_test_key),
+				      fips_test_data, sizeof(fips_test_data),
+				      mac);
+		if (memcmp(fips_test_hmac_sha1_value, mac, sizeof(mac)) != 0)
+			panic("sha1: FIPS self-test failed\n");
+	}
 	return 0;
 }
 subsys_initcall(sha1_mod_init);
 
 static void __exit sha1_mod_exit(void)
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 881b935418cea..5d6b77e7e1416 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -15,10 +15,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/unaligned.h>
 #include <linux/wordpart.h>
+#include "fips.h"
 
 static const struct sha256_block_state sha224_iv = {
 	.h = {
 		SHA224_H0, SHA224_H1, SHA224_H2, SHA224_H3,
 		SHA224_H4, SHA224_H5, SHA224_H6, SHA224_H7,
@@ -267,12 +268,12 @@ void sha256(const u8 *data, size_t len, u8 out[SHA256_DIGEST_SIZE])
 	sha256_final(&ctx, out);
 }
 EXPORT_SYMBOL(sha256);
 
 /*
- * Pre-boot environment (as indicated by __DISABLE_EXPORTS being defined)
- * doesn't need either HMAC support or interleaved hashing support
+ * Pre-boot environments (as indicated by __DISABLE_EXPORTS being defined) just
+ * need the generic SHA-256 code.  Omit all other features from them.
  */
 #ifndef __DISABLE_EXPORTS
 
 #ifndef sha256_finup_2x_arch
 static bool sha256_finup_2x_arch(const struct __sha256_ctx *ctx,
@@ -475,23 +476,40 @@ void hmac_sha256_usingrawkey(const u8 *raw_key, size_t raw_key_len,
 	hmac_sha256_init_usingrawkey(&ctx, raw_key, raw_key_len);
 	hmac_sha256_update(&ctx, data, data_len);
 	hmac_sha256_final(&ctx, out);
 }
 EXPORT_SYMBOL_GPL(hmac_sha256_usingrawkey);
-#endif /* !__DISABLE_EXPORTS */
 
-#ifdef sha256_mod_init_arch
+#if defined(sha256_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
 static int __init sha256_mod_init(void)
 {
+#ifdef sha256_mod_init_arch
 	sha256_mod_init_arch();
+#endif
+	if (fips_enabled) {
+		/*
+		 * FIPS cryptographic algorithm self-test.  As per the FIPS
+		 * Implementation Guidance, testing HMAC-SHA256 satisfies the
+		 * test requirement for SHA-224, SHA-256, and HMAC-SHA224 too.
+		 */
+		u8 mac[SHA256_DIGEST_SIZE];
+
+		hmac_sha256_usingrawkey(fips_test_key, sizeof(fips_test_key),
+					fips_test_data, sizeof(fips_test_data),
+					mac);
+		if (memcmp(fips_test_hmac_sha256_value, mac, sizeof(mac)) != 0)
+			panic("sha256: FIPS self-test failed\n");
+	}
 	return 0;
 }
 subsys_initcall(sha256_mod_init);
 
 static void __exit sha256_mod_exit(void)
 {
 }
 module_exit(sha256_mod_exit);
 #endif
 
+#endif /* !__DISABLE_EXPORTS */
+
 MODULE_DESCRIPTION("SHA-224, SHA-256, HMAC-SHA224, and HMAC-SHA256 library functions");
 MODULE_LICENSE("GPL");
diff --git a/lib/crypto/sha512.c b/lib/crypto/sha512.c
index d8062188be98a..605eab51aabd5 100644
--- a/lib/crypto/sha512.c
+++ b/lib/crypto/sha512.c
@@ -15,10 +15,11 @@
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/string.h>
 #include <linux/unaligned.h>
 #include <linux/wordpart.h>
+#include "fips.h"
 
 static const struct sha512_block_state sha384_iv = {
 	.h = {
 		SHA384_H0, SHA384_H1, SHA384_H2, SHA384_H3,
 		SHA384_H4, SHA384_H5, SHA384_H6, SHA384_H7,
@@ -403,14 +404,30 @@ void hmac_sha512_usingrawkey(const u8 *raw_key, size_t raw_key_len,
 	hmac_sha512_update(&ctx, data, data_len);
 	hmac_sha512_final(&ctx, out);
 }
 EXPORT_SYMBOL_GPL(hmac_sha512_usingrawkey);
 
-#ifdef sha512_mod_init_arch
+#if defined(sha512_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
 static int __init sha512_mod_init(void)
 {
+#ifdef sha512_mod_init_arch
 	sha512_mod_init_arch();
+#endif
+	if (fips_enabled) {
+		/*
+		 * FIPS cryptographic algorithm self-test.  As per the FIPS
+		 * Implementation Guidance, testing HMAC-SHA512 satisfies the
+		 * test requirement for SHA-384, SHA-512, and HMAC-SHA384 too.
+		 */
+		u8 mac[SHA512_DIGEST_SIZE];
+
+		hmac_sha512_usingrawkey(fips_test_key, sizeof(fips_test_key),
+					fips_test_data, sizeof(fips_test_data),
+					mac);
+		if (memcmp(fips_test_hmac_sha512_value, mac, sizeof(mac)) != 0)
+			panic("sha512: FIPS self-test failed\n");
+	}
 	return 0;
 }
 subsys_initcall(sha512_mod_init);
 
 static void __exit sha512_mod_exit(void)
diff --git a/scripts/crypto/gen-fips-testvecs.py b/scripts/crypto/gen-fips-testvecs.py
new file mode 100755
index 0000000000000..2956f88b764ae
--- /dev/null
+++ b/scripts/crypto/gen-fips-testvecs.py
@@ -0,0 +1,32 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Script that generates lib/crypto/fips.h
+#
+# Copyright 2025 Google LLC
+
+import hmac
+
+fips_test_data = b"fips test data\0\0"
+fips_test_key = b"fips test key\0\0\0"
+
+def print_static_u8_array_definition(name, value):
+    print('')
+    print(f'static const u8 {name}[] __initconst __maybe_unused = {{')
+    for i in range(0, len(value), 8):
+        line = '\t' + ''.join(f'0x{b:02x}, ' for b in value[i:i+8])
+        print(f'{line.rstrip()}')
+    print('};')
+
+print('/* SPDX-License-Identifier: GPL-2.0-or-later */')
+print(f'/* This file was generated by: gen-fips-testvecs.py */')
+print()
+print('#include <linux/fips.h>')
+
+print_static_u8_array_definition("fips_test_data", fips_test_data)
+print_static_u8_array_definition("fips_test_key", fips_test_key)
+
+for alg in 'sha1', 'sha256', 'sha512':
+    ctx = hmac.new(fips_test_key, digestmod=alg)
+    ctx.update(fips_test_data)
+    print_static_u8_array_definition(f'fips_test_hmac_{alg}_value', ctx.digest())

base-commit: 8bd9238e511d02831022ff0270865c54ccc482d6
-- 
2.51.0



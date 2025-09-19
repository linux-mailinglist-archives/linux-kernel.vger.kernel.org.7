Return-Path: <linux-kernel+bounces-824779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7DFB8A22A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377755846AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44469317709;
	Fri, 19 Sep 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifi/w9ye"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE23161A7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293889; cv=none; b=GrCu2IMygmWGR3ObEVWSWEY43fwewgO+SN2ZU4F3fSYeLyY8JPleCg4h8Dw9LUDpiCzwBOjXW5hsMOtZr6YGQji9/kcio+PqD2OMO46oVZmPIUWhPdN2BIZTHnSItHJRxmyNw0OYI8bp4EY+bNGXsxz/HLuh6vZEiRxRD5GzQv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293889; c=relaxed/simple;
	bh=dpLQzjfBI0xMu3e0xhjAEBQgs/fUasFxh/U//MgBt5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO6iT+xwKMlkNh0g09drqzZXDaz60Rn4Po9w/NrFseb8K8fwU2OnHedaZfy6gYCdWjbtb9eC+Ceyxc6ucEJOyToM9M6QxykVbbQIh+WuTjXIhQsEQPXDy2HPcfbWi+d+d1swXp/wHFm4SD2hPJwAgOC+wNYiB9Hf0jRnRocXaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifi/w9ye; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so21750985e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758293885; x=1758898685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kKd/JXPbzTz5+ezoQ1J+mpBYdbScAPUDVkzXIQoH/8=;
        b=Ifi/w9ye3sQ7Va4AU6+hEhrxNtSxF+8i84izK0DbVa4LyXjlM8sVsQJ6DIc1ST26B8
         Ht4x4LlAf78tlgMLDTA6BglxfD9jRnWEPbbpbjXbaO825PdOnR03+LX71gWU3kaIe5fZ
         Az6cNnAmT/Hsm6/I77gtr3HqTLI2vW9nAcfjJPwo2nPuDbdPFHxXmTidXk9XdjEL0B0B
         3wCZpByw9H1hcRo8dWRujAQy4G9ztsmILr+x/uUmkVuKg33galxihY/l1QJJ5TAT+7Sq
         HeS9IfzOAmbD10kL+yeAeNMSpTbvzMKEC7cuavo3fa+b1E5G7s8fYIn/nJh3litmKAk7
         nCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293885; x=1758898685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kKd/JXPbzTz5+ezoQ1J+mpBYdbScAPUDVkzXIQoH/8=;
        b=l2gRHK2YG4KuWUo0SeHIbmKtR0LClFcwAmDTvZMRr4jJXpEAHw2ePprBZFs1/czkJT
         y6bcQHXRCFOn9Ye9tDMHeKzCkYT6rxcdDAwY03TGZ1BJT2UH3UM5/6fDH3C+p2ZnedR8
         Uc2TMRZ+zee8/5/tuBy5GIMBh6sE7+XQp/LqCef5ofkQUYP6BMaUzExoyBB3KX4ucXGu
         dpLyeEkrRpp0S9lX5gINm1L8RZPLQFi4Lu3DnQYYyTR194edxfmoUkcxJ+zzNdiJMDaQ
         8RD+w5fejbS4NNrOT9hEQl9C7gDJRN6Uj9G3DF8wW5pq+UjDKt9O8dzBwcC5UQkD4w3p
         wBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQCsDiQIJT9VpGeMWNuXs1sFLFpU1g0vpqPLBWpZegSYr9yfuJo3Q+CMYUazvOup1uYOOiuUNkFiqkDhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgsNJ5fyz1oIYn6w5aa6YIGJX3pnGnB5fwxVEpwAcwRR/uYMvv
	O8PoWQ93l9HOW/bM9IEtKJrFsIQql8jw7Fz3ylL4Dc6QHo24kwKIlRqp
X-Gm-Gg: ASbGncsxD+O/XhtnDqzINzVrjpojNCxPJRsWYymcAYtC1O6VWJLhR0RwKh2JemU2oUc
	Q+WM7/6UVOHF1dGeqkmZn6J+ujf6qdHOiOTU9xnjau9MOrupPCpW7NDA0HYgk/fmn2nNLPohRcy
	1HeWJ3uCZum4FVD7w2/KD3KbN7k+lg7QWeiIX4S0TB+2QH39D8MVhrXISppbA7T3XYjg/bskEpT
	fIN7XDakft2Sn5qjBs8ffNLbaoxx5kp3WlmZpw3DgvqFE88VliQ/MEneScG4UzKOeStZglSqsbd
	8ainzpvU8IiC/AmQmcIqlNe8iHoTZpcSWiPgwZrRkj6uESiKJQZFkUjkEAMA2BBegyTE9lgxyWh
	sCdwt9vWXDQrxxxsenpflEyIs0/nWK7cM+F7oIg1umawfsFNSx9cdzisHtNkQDIeOhOQLtEAd9t
	fIt1+9j147wnWwB+w=
X-Google-Smtp-Source: AGHT+IGPZQtZaXpB5KQ16hieOpy0bgFcG29LZPkxphuKGCWvRd3WuhUNDUxdZ3+qFBNVj+jHlwKp4w==
X-Received: by 2002:a05:600c:c4ab:b0:45f:2919:5e91 with SMTP id 5b1f17b1804b1-467e7f7e36dmr43014905e9.16.1758293884348;
        Fri, 19 Sep 2025 07:58:04 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (124.62.78.34.bc.googleusercontent.com. [34.78.62.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm8551386f8f.37.2025.09.19.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:58:03 -0700 (PDT)
From: Ethan Graham <ethan.w.s.graham@gmail.com>
To: ethangraham@google.com,
	glider@google.com
Cc: andreyknvl@gmail.com,
	andy@kernel.org,
	brauner@kernel.org,
	brendan.higgins@linux.dev,
	davem@davemloft.net,
	davidgow@google.com,
	dhowells@redhat.com,
	dvyukov@google.com,
	elver@google.com,
	herbert@gondor.apana.org.au,
	ignat@cloudflare.com,
	jack@suse.cz,
	jannh@google.com,
	johannes@sipsolutions.net,
	kasan-dev@googlegroups.com,
	kees@kernel.org,
	kunit-dev@googlegroups.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lukas@wunner.de,
	rmoar@google.com,
	shuah@kernel.org,
	sj@kernel.org,
	tarasmadan@google.com
Subject: [PATCH v2 07/10] crypto: implement KFuzzTest targets for PKCS7 and RSA parsing
Date: Fri, 19 Sep 2025 14:57:47 +0000
Message-ID: <20250919145750.3448393-8-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
In-Reply-To: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Graham <ethangraham@google.com>

Add KFuzzTest targets for pkcs7_parse_message, rsa_parse_pub_key, and
rsa_parse_priv_key to serve as real-world examples of how the framework
is used.

These functions are ideal candidates for KFuzzTest as they perform
complex parsing of user-controlled data but are not directly exposed at
the syscall boundary. This makes them difficult to exercise with
traditional fuzzing tools and showcases the primary strength of the
KFuzzTest framework: providing an interface to fuzz internal functions.

To validate the effectiveness of the framework on these new targets, we
injected two artificial bugs and let syzkaller fuzz the targets in an
attempt to catch them.

The first of these was calling the asn1 decoder with an incorrect input
from pkcs7_parse_message, like so:

- ret = asn1_ber_decoder(&pkcs7_decoder, ctx, data, datalen);
+ ret = asn1_ber_decoder(&pkcs7_decoder, ctx, data, datalen + 1);

The second was bug deeper inside of asn1_ber_decoder itself, like so:

- for (len = 0; n > 0; n--)
+ for (len = 0; n >= 0; n--)

syzkaller was able to trigger these bugs, and the associated KASAN
slab-out-of-bounds reports, within seconds.

The targets are defined within crypto/asymmetric-keys/tests.

Signed-off-by: Ethan Graham <ethangraham@google.com>
Reviewed-by: Ignat Korchagin <ignat@cloudflare.com>

---
PR v2:
- Make fuzz targets also depend on the KConfig options needed for the
  functions they are fuzzing, CONFIG_PKCS7_MESSAGE_PARSER and
  CONFIG_CRYPTO_RSA respectively.
- Fix build issues pointed out by the kernel test robot <lkp@intel.com>.
- Account for return value of pkcs7_parse_message, and free resources if
  the function call succeeds.
PR v1:
- Change the fuzz target build to depend on CONFIG_KFUZZTEST=y,
  eliminating the need for a separate config option for each individual
  file as suggested by Ignat Korchagin.
- Remove KFUZZTEST_EXPECT_LE on the length of the `key` field inside of
  the fuzz targets. A maximum length is now set inside of the core input
  parsing logic.
RFC v2:
- Move KFuzzTest targets outside of the source files into dedicated
  _kfuzz.c files under /crypto/asymmetric_keys/tests/ as suggested by
  Ignat Korchagin and Eric Biggers.
---
---
 crypto/asymmetric_keys/Makefile               |  2 +
 crypto/asymmetric_keys/tests/Makefile         |  4 ++
 crypto/asymmetric_keys/tests/pkcs7_kfuzz.c    | 26 +++++++++++++
 .../asymmetric_keys/tests/rsa_helper_kfuzz.c  | 38 +++++++++++++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 crypto/asymmetric_keys/tests/Makefile
 create mode 100644 crypto/asymmetric_keys/tests/pkcs7_kfuzz.c
 create mode 100644 crypto/asymmetric_keys/tests/rsa_helper_kfuzz.c

diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index bc65d3b98dcb..77b825aee6b2 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -67,6 +67,8 @@ obj-$(CONFIG_PKCS7_TEST_KEY) += pkcs7_test_key.o
 pkcs7_test_key-y := \
 	pkcs7_key_type.o
 
+obj-y += tests/
+
 #
 # Signed PE binary-wrapped key handling
 #
diff --git a/crypto/asymmetric_keys/tests/Makefile b/crypto/asymmetric_keys/tests/Makefile
new file mode 100644
index 000000000000..023d6a65fb89
--- /dev/null
+++ b/crypto/asymmetric_keys/tests/Makefile
@@ -0,0 +1,4 @@
+pkcs7-kfuzz-y := $(and $(CONFIG_KFUZZTEST),$(CONFIG_PKCS7_MESSAGE_PARSER))
+rsa-helper-kfuzz-y := $(and $(CONFIG_KFUZZTEST),$(CONFIG_CRYPTO_RSA))
+obj-$(pkcs7-kfuzz-y) += pkcs7_kfuzz.o
+obj-$(rsa-helper-kfuzz-y) += rsa_helper_kfuzz.o
diff --git a/crypto/asymmetric_keys/tests/pkcs7_kfuzz.c b/crypto/asymmetric_keys/tests/pkcs7_kfuzz.c
new file mode 100644
index 000000000000..c801f6b59de2
--- /dev/null
+++ b/crypto/asymmetric_keys/tests/pkcs7_kfuzz.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PKCS#7 parser KFuzzTest target
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <crypto/pkcs7.h>
+#include <linux/kfuzztest.h>
+
+struct pkcs7_parse_message_arg {
+	const void *data;
+	size_t datalen;
+};
+
+FUZZ_TEST(test_pkcs7_parse_message, struct pkcs7_parse_message_arg)
+{
+	struct pkcs7_message *msg;
+
+	KFUZZTEST_EXPECT_NOT_NULL(pkcs7_parse_message_arg, data);
+	KFUZZTEST_ANNOTATE_ARRAY(pkcs7_parse_message_arg, data);
+	KFUZZTEST_ANNOTATE_LEN(pkcs7_parse_message_arg, datalen, data);
+
+	msg = pkcs7_parse_message(arg->data, arg->datalen);
+	if (msg && !IS_ERR(msg))
+		kfree(msg);
+}
diff --git a/crypto/asymmetric_keys/tests/rsa_helper_kfuzz.c b/crypto/asymmetric_keys/tests/rsa_helper_kfuzz.c
new file mode 100644
index 000000000000..bd29ed5e8c82
--- /dev/null
+++ b/crypto/asymmetric_keys/tests/rsa_helper_kfuzz.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RSA key extract helper KFuzzTest targets
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <linux/kfuzztest.h>
+#include <crypto/internal/rsa.h>
+
+struct rsa_parse_pub_key_arg {
+	const void *key;
+	size_t key_len;
+};
+
+FUZZ_TEST(test_rsa_parse_pub_key, struct rsa_parse_pub_key_arg)
+{
+	KFUZZTEST_EXPECT_NOT_NULL(rsa_parse_pub_key_arg, key);
+	KFUZZTEST_ANNOTATE_ARRAY(rsa_parse_pub_key_arg, key);
+	KFUZZTEST_ANNOTATE_LEN(rsa_parse_pub_key_arg, key_len, key);
+
+	struct rsa_key out;
+	rsa_parse_pub_key(&out, arg->key, arg->key_len);
+}
+
+struct rsa_parse_priv_key_arg {
+	const void *key;
+	size_t key_len;
+};
+
+FUZZ_TEST(test_rsa_parse_priv_key, struct rsa_parse_priv_key_arg)
+{
+	KFUZZTEST_EXPECT_NOT_NULL(rsa_parse_priv_key_arg, key);
+	KFUZZTEST_ANNOTATE_ARRAY(rsa_parse_priv_key_arg, key);
+	KFUZZTEST_ANNOTATE_LEN(rsa_parse_priv_key_arg, key_len, key);
+
+	struct rsa_key out;
+	rsa_parse_priv_key(&out, arg->key, arg->key_len);
+}
-- 
2.51.0.470.ga7dc726c21-goog



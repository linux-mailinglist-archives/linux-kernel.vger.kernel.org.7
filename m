Return-Path: <linux-kernel+bounces-818424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCBAB5918F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DD31BC51E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C84429C343;
	Tue, 16 Sep 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNhub0gK"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED229B229
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013291; cv=none; b=uMRzaiCaHRG94bpMsdWuKlWcNj9Tzr2CkudDyvI8r7c5AU3gmJvffj0p7ZMnG9+1V1SHc+94qI1/NqJAJ4HMWmTEeRLFlMRDzdisgNMbr1b9bLHQmusi9LM3LPJ68ie3ScqyMpo6FiVUjBhdhgVRrD7AlXkj9OGWcBLnwUUPNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013291; c=relaxed/simple;
	bh=5p5lfP6HUCJ6tM1PM09VVWmrB48/epMFUrdxYERWB00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1IMICA7s/XpZkf95LZO5EuKKqV4vaOBTx7EwCH4Z8yRRJJLiayL3hkuUiQdyTEZCaGa4CfytZ5IFJ7eJyH9jJIsPS8gRC5trvU7dfR8KrQkJjsDgIzmBOdf/6bdDbK7lQ2djYWMYLlkDaiQKjai79lv2s62l/hac1gzapBB9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNhub0gK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so47335425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758013287; x=1758618087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX0GE1tFaVdaJ+X5gME1f6NzrpcsI0lAH1DHePnNN9I=;
        b=eNhub0gK53w/8PQl8swXPk2s3Pgx4dAqnxvF+BhC+yC3xIHLj604WLYHi/IgLjoLtR
         K9Swk5/TdaIAI5sKGeni7och0LAR3GOJGAVXQ5HDSJpltdrXu3OWlNdPzxbehmmSZXg5
         +PzmpUJl53IYz0BankVyAahGr7KVBxI1plPHuq93lNRZNNl5jaRSHGow5Qhv/eKO+o7N
         rcJiUVfuQ52ZZfLPaz06nZKGzwMLnbTF9Hg74vjmlJT+8cPXQsxkxv5Y7M6H03jVcpUz
         ZHJi4QbJCD9fxyORvZ5tfbiVWwtQouY/eSfQZEq8cBhkjJU7Hj/1p6BJyteczbpStW5i
         XJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013287; x=1758618087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eX0GE1tFaVdaJ+X5gME1f6NzrpcsI0lAH1DHePnNN9I=;
        b=sNCq3Zf8+MhStIdDQ9ZnLN5eYk4MiCJkKXbfglCDHzjvhqZ5rVqwQrpDg1r5hEF6p5
         zic2/yeKUrJ5JILxBHnSaaf+40TwNO9wkrpnnh33R0gMCtd+Z26cC86Ue2uUK2tnrPFk
         qmHrgbXxRK/1VC3qV2GBBEyKAMsijJVW9lms7HOI3d5OWTdE9nEr1LYSFwMSfVOhaM11
         O6IDJcVlxmpwg/cuQtPbEpl96nIjALJ8bCfSGrV2ejMF6UnZVUBA7jAAQPInOI953AxK
         ER3KC421NsgazDQYn/YJvDtQuEFEYly0jXsU9lFf74kvfUTUAaiyvqRa1rVlI5F7DmCJ
         J7lA==
X-Forwarded-Encrypted: i=1; AJvYcCV7IPqE8kXwJF0T6M7nwwTjTTLsGDG3D/0qtgX41vpZj5hYyZ1p8acUp6C4iwXSHA//maqOKIJEm3eNwEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjEdredrMw0v9Uiig/u+p0yyMjvI6AhC24j6xMhDQKXuk6dih
	2QVoHLaLuJso+9pU9U9P4p9mmSwF1CuUNutSR61HnT6Ma3o3lZrCYRXM
X-Gm-Gg: ASbGncvdBwOdJUTbe0U8+aataep5+oF382iJAXg2Nr9ETxqRxGHlx8Vb53ZB0vJj0VO
	CaUHsM/OKGIFJgRMaTx7ujG/QxZ+VCpz0VnGIXBMZQO8zcdMUSK9iv72CR0fYj3sfS16sBRDt8G
	LIdx7RdO57uGSCQ3HlEkmULeCRKnBeR61YHH+gTWUNSdaYnpFKJx6zYrXQ+4Ucn5p9ozBLuxwGy
	a1UQa7DO3BsZ2RfFr4yt0oiQ8PBUQC7F9WLesXsYj/p5eP3uc31jdGFeUTJL1MSo4FI+viDblcJ
	JFYzKB9w4JbHavN02lQrO+DRiCL8GK1dsdmGUx7+tAWBYaYmJHsRBJQMH+Buq02ReisRFkNAaLw
	WofothkghJ0/r6Nx+0GBMv6v65AmyewXe599vzjXYVSciGgz3/24Q+P4tWtkW8DqW4o//mAvu6f
	WsA91yjpWf5Upet5ptvawnw2E=
X-Google-Smtp-Source: AGHT+IG4rWU9dUsfNI/GTT2ZfR/FJQxnX0XoO3ls2sTIzkMGJlfRV3ER/lT2KNe6XIHz3tv6/6a9lw==
X-Received: by 2002:a05:6000:2001:b0:3eb:86fb:bcd9 with SMTP id ffacd0b85a97d-3eb86fbbfb9mr4536453f8f.12.1758013287060;
        Tue, 16 Sep 2025 02:01:27 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (42.16.79.34.bc.googleusercontent.com. [34.79.16.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037186e5sm212975035e9.5.2025.09.16.02.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:01:26 -0700 (PDT)
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
	tarasmadan@google.com
Subject: [PATCH v1 07/10] crypto: implement KFuzzTest targets for PKCS7 and RSA parsing
Date: Tue, 16 Sep 2025 09:01:06 +0000
Message-ID: <20250916090109.91132-8-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250916090109.91132-1-ethan.w.s.graham@gmail.com>
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com>
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

The targets are defined within /lib/tests, alongside existing KUnit
tests.

Signed-off-by: Ethan Graham <ethangraham@google.com>

---
v3:
- Change the fuzz target build to depend on CONFIG_KFUZZTEST=y,
  eliminating the need for a separate config option for each individual
  file as suggested by Ignat Korchagin.
- Remove KFUZZTEST_EXPECT_LE on the length of the `key` field inside of
  the fuzz targets. A maximum length is now set inside of the core input
  parsing logic.
v2:
- Move KFuzzTest targets outside of the source files into dedicated
  _kfuzz.c files under /crypto/asymmetric_keys/tests/ as suggested by
  Ignat Korchagin and Eric Biggers.
---
---
 crypto/asymmetric_keys/Makefile               |  2 +
 crypto/asymmetric_keys/tests/Makefile         |  2 +
 crypto/asymmetric_keys/tests/pkcs7_kfuzz.c    | 22 +++++++++++
 .../asymmetric_keys/tests/rsa_helper_kfuzz.c  | 38 +++++++++++++++++++
 4 files changed, 64 insertions(+)
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
index 000000000000..4ffe0bbe9530
--- /dev/null
+++ b/crypto/asymmetric_keys/tests/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_KFUZZTEST) += pkcs7_kfuzz.o
+obj-$(CONFIG_KFUZZTEST) += rsa_helper_kfuzz.o
diff --git a/crypto/asymmetric_keys/tests/pkcs7_kfuzz.c b/crypto/asymmetric_keys/tests/pkcs7_kfuzz.c
new file mode 100644
index 000000000000..37e02ba517d8
--- /dev/null
+++ b/crypto/asymmetric_keys/tests/pkcs7_kfuzz.c
@@ -0,0 +1,22 @@
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
+	KFUZZTEST_EXPECT_NOT_NULL(pkcs7_parse_message_arg, data);
+	KFUZZTEST_ANNOTATE_ARRAY(pkcs7_parse_message_arg, data);
+	KFUZZTEST_ANNOTATE_LEN(pkcs7_parse_message_arg, datalen, data);
+
+	pkcs7_parse_message(arg->data, arg->datalen);
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
2.51.0.384.g4c02a37b29-goog



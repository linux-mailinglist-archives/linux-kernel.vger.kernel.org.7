Return-Path: <linux-kernel+bounces-766761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDBAB24AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C761BC3AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C2D2EBDC6;
	Wed, 13 Aug 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azPFY3uC"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE72EAB88
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092326; cv=none; b=EnHZmZJakVnlQrOIIwfpZIRqFVqfvx0VMlGaHk9RfM9USgBNfoHugz9ef9jkqtcIwnqG///8RN9EH6s8Kf4RswYtjdA7EECbiGA4/ty3P48BaDKBkzGUFfvV4tmIkMZgrygG9EOwraqIvfHbeHtXWItv3mQBvAAtSxcOvVH4jdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092326; c=relaxed/simple;
	bh=UZMHOj4dcWuDePMWBKn/lmZBU3O7jroj1pLSG5PDHcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaccTnzEqZXopNCn9NOndHPizU4OasfezcrveE+H8VcIQC28Pd+EU/b1JMynYAYsGFTQwbbZbYjzV3VpECH0P3QgfkdAJ+NJ562rJRKW3GXtPaGWXq5OaMTTSwwoYwPuMvFcwkxHk/bVhnJhf+okVdWPwPddoP1PwQw9Uy8+ink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azPFY3uC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459fdc391c6so38002095e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755092323; x=1755697123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08hbUSvRcagfemg83g47pFkXwfN5ra3fR8Zxn3xb4d4=;
        b=azPFY3uClkmv+vjB4u6lXP8SdRd5SCDegOOP7PqndU2pMUJKRJWhI9T/fpkbCqwXiY
         CxIHOGoqzmX/W5HbuswMP307woPgigrlIdsJqGIlCDqAyiJXnjlT9IxMYEChFfqd4Ja1
         jdPL2yTAROph4P3sHyJsY769+zAIWZAzMHCkDgKrW+v4OQgQuWYZkmgaGHUaf738wTLo
         NVRqibQWBBObqOJUYtQezcEPPU9n2AHuM0L60WM02vb2CluzHGVeRJ9mxQD3JoYs7HRY
         qhj2OWCZZR9RXy+jSC5td8RtnQdg4sDRwnwDk8Kp5zmxxkudXQ9E1Ibo6HJ/tARodklX
         z2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092323; x=1755697123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08hbUSvRcagfemg83g47pFkXwfN5ra3fR8Zxn3xb4d4=;
        b=iQPHVRy2ibeILmv9jg8N/Qe652WXqNQG0FfrKqn6lPb3ktJwM3T6ni/K/bfv7J7gwP
         g0RhHpg4bg5NDuJgD7UhhwxHVX8LQZ0LKF2VtBG/CJWZxnOEJkZG0uBUJrxfWkOf7+oD
         xmu9ZCZUsCXGZ4lefVsJR1NTLkYn+tGyRlXOnG2byITv2X2s8Remrc7QelKdnLjo/bfE
         LnJQOuyRauN9KVoJwFEc0961N39gP3n0bgwbyM6+VVFibqxmw4ueyLK2UZ6TlXU/szPn
         LbAW07Ap5yVEcWovAVE/etF6CMRMWbZjwW3q0nZBnd4Nsez6lzxgAaboFAkxOZOd8ozz
         qZqw==
X-Forwarded-Encrypted: i=1; AJvYcCW7Afx7YfCzqltzYL/e2jaRMgpTSxUaGXBPX5q6oXA8q/O6gx/fUQzYYRfcQneOIO3ffoDHdXWlP8s2KiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZh8GS9nx073t5lLFCM2Gz8H1evxj/kYDq67K/GR1barjaWXa
	+FRM+vLZS0mILwPBflLoXx9OsPUXxBj4sz4HCoGPp8LZ8DLSkeQN2rbD
X-Gm-Gg: ASbGncvkUAOoZnmR+NcuYgPL5/vXJPsm8gj9APaW7DTZP7R9OKexZ3hVf7b0kbnBlbk
	vut744XvgvqOHQ94tWdTrMLgoqNx42YEA/wBdi8KdH2vdC7QrVA+9dvez+RyQVZP4g+/OFdhZoN
	un4/ss4mEQIAqgmND/BF1lFbR5dYHZoyrkINRKTuEYzMrHB/aRXQ+qC/TXh5xy9a5+aK99pgvH0
	veE1lQVFd1mcRlCvEEs6ttl2laIgnNFlv9fyV0Qgdh9oU1oWZnnNzmwhHJzrx6HvKur4XzwMv3b
	Tf+WOmZpmnScps/kEvhh0vXgZaQ34S4YqbfQWQHy3LRSI27zwT5T0bsG97tpSZh5/6jmDp06BjM
	aIWq52OuQiH9u2u94a0tJhcLxS6ZL+oObolqwPhxnOk/GzNgeMz5fbFbsmUClGmFGEZ24y2STA3
	QVnWq8CotjiyouePMn+pecJJkFWw==
X-Google-Smtp-Source: AGHT+IH/vHQLEUqCTkHELdcv4FlcQ/pK5AuwNwJHyQdHRE3adkmaZLxp5+wlXgNH0eI9cVeElhHRKg==
X-Received: by 2002:a05:600c:1c86:b0:458:b01c:8f with SMTP id 5b1f17b1804b1-45a1a80e6femr1190105e9.8.1755092323030;
        Wed, 13 Aug 2025 06:38:43 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (87.220.76.34.bc.googleusercontent.com. [34.76.220.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm25677444f8f.69.2025.08.13.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:38:42 -0700 (PDT)
From: Ethan Graham <ethan.w.s.graham@gmail.com>
To: ethangraham@google.com,
	glider@google.com
Cc: andreyknvl@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@google.com,
	dvyukov@google.com,
	jannh@google.com,
	elver@google.com,
	rmoar@google.com,
	shuah@kernel.org,
	tarasmadan@google.com,
	kasan-dev@googlegroups.com,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 RFC 5/6] kfuzztest: add KFuzzTest sample fuzz targets
Date: Wed, 13 Aug 2025 13:38:11 +0000
Message-ID: <20250813133812.926145-6-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
In-Reply-To: <20250813133812.926145-1-ethan.w.s.graham@gmail.com>
References: <20250813133812.926145-1-ethan.w.s.graham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Graham <ethangraham@google.com>

Add two simple fuzz target samples to demonstrate the KFuzzTest API and
provide basic self-tests for the framework.

These examples showcase how a developer can define a fuzz target using
the FUZZ_TEST(), constraint, and annotation macros, and serve as runtime
sanity checks for the core logic. For example, they test that out-of-bounds
memory accesses into poisoned padding regions are correctly detected in a
KASAN build.

These have been tested by writing syzkaller-generated inputs into their
debugfs 'input' files and verifying that the correct KASAN reports were
triggered.

Signed-off-by: Ethan Graham <ethangraham@google.com>
---
 samples/Kconfig                               |  7 +++
 samples/Makefile                              |  1 +
 samples/kfuzztest/Makefile                    |  3 ++
 samples/kfuzztest/overflow_on_nested_buffer.c | 52 +++++++++++++++++++
 samples/kfuzztest/underflow_on_buffer.c       | 41 +++++++++++++++
 5 files changed, 104 insertions(+)
 create mode 100644 samples/kfuzztest/Makefile
 create mode 100644 samples/kfuzztest/overflow_on_nested_buffer.c
 create mode 100644 samples/kfuzztest/underflow_on_buffer.c

diff --git a/samples/Kconfig b/samples/Kconfig
index ffef99950206..4be51a21d010 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -321,6 +321,13 @@ config SAMPLE_HUNG_TASK
 	  if 2 or more processes read the same file concurrently, it will
 	  be detected by the hung_task watchdog.
 
+config SAMPLE_KFUZZTEST
+	bool "Build KFuzzTest sample targets"
+	depends on KFUZZTEST
+	help
+	  Build KFuzzTest sample targets that serve as selftests for input
+	  deserialization and inter-region redzone poisoning logic.
+
 source "samples/rust/Kconfig"
 
 source "samples/damon/Kconfig"
diff --git a/samples/Makefile b/samples/Makefile
index 07641e177bd8..3a0e7f744f44 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -44,4 +44,5 @@ obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_MTIER)	+= damon/
 obj-$(CONFIG_SAMPLE_HUNG_TASK)		+= hung_task/
+obj-$(CONFIG_SAMPLE_KFUZZTEST)		+= kfuzztest/
 obj-$(CONFIG_SAMPLE_TSM_MR)		+= tsm-mr/
diff --git a/samples/kfuzztest/Makefile b/samples/kfuzztest/Makefile
new file mode 100644
index 000000000000..4f8709876c9e
--- /dev/null
+++ b/samples/kfuzztest/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SAMPLE_KFUZZTEST) += overflow_on_nested_buffer.o underflow_on_buffer.o
diff --git a/samples/kfuzztest/overflow_on_nested_buffer.c b/samples/kfuzztest/overflow_on_nested_buffer.c
new file mode 100644
index 000000000000..8b4bab1d6d4a
--- /dev/null
+++ b/samples/kfuzztest/overflow_on_nested_buffer.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains a KFuzzTest example target that ensures that a buffer
+ * overflow on a nested region triggers a KASAN OOB access report.
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <linux/kfuzztest.h>
+
+static void overflow_on_nested_buffer(const char *a, size_t a_len, const char *b, size_t b_len)
+{
+	size_t i;
+	pr_info("a = [%px, %px)", a, a + a_len);
+	pr_info("b = [%px, %px)", b, b + b_len);
+
+	/* Ensure that all bytes in arg->b are accessible. */
+	for (i = 0; i < b_len; i++)
+		READ_ONCE(b[i]);
+	/*
+	 * Check that all bytes in arg->a are accessible, and provoke an OOB on
+	 * the first byte to the right of the buffer which will trigger a KASAN
+	 * report.
+	 */
+	for (i = 0; i <= a_len; i++)
+		READ_ONCE(a[i]);
+}
+
+struct nested_buffers {
+	const char *a;
+	size_t a_len;
+	const char *b;
+	size_t b_len;
+};
+
+/**
+ * The KFuzzTest input format specifies that struct nested buffers should
+ * be expanded as:
+ *
+ * | a | b | pad[8] | *a | pad[8] | *b |
+ *
+ * where the padded regions are poisoned. We expect to trigger a KASAN report by
+ * overflowing one byte into the `a` buffer.
+ */
+FUZZ_TEST(test_overflow_on_nested_buffer, struct nested_buffers)
+{
+	KFUZZTEST_EXPECT_NOT_NULL(nested_buffers, a);
+	KFUZZTEST_EXPECT_NOT_NULL(nested_buffers, b);
+	KFUZZTEST_ANNOTATE_LEN(nested_buffers, a_len, a);
+	KFUZZTEST_ANNOTATE_LEN(nested_buffers, b_len, b);
+
+	overflow_on_nested_buffer(arg->a, arg->a_len, arg->b, arg->b_len);
+}
diff --git a/samples/kfuzztest/underflow_on_buffer.c b/samples/kfuzztest/underflow_on_buffer.c
new file mode 100644
index 000000000000..fbe214274037
--- /dev/null
+++ b/samples/kfuzztest/underflow_on_buffer.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains a KFuzzTest example target that ensures that a buffer
+ * underflow on a region triggers a KASAN OOB access report.
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <linux/kfuzztest.h>
+
+static void underflow_on_buffer(char *buf, size_t buflen)
+{
+	size_t i;
+
+	pr_info("buf = [%px, %px)", buf, buf + buflen);
+
+	/* First ensure that all bytes in arg->b are accessible. */
+	for (i = 0; i < buflen; i++)
+		READ_ONCE(buf[i]);
+	/*
+	 * Provoke a buffer overflow on the first byte preceding b, triggering
+	 * a KASAN report.
+	 */
+	READ_ONCE(*((char *)buf - 1));
+}
+
+struct some_buffer {
+	char *buf;
+	size_t buflen;
+};
+
+/**
+ * Tests that the region between struct some_buffer and the expanded *buf field
+ * is correctly poisoned by accessing the first byte before *buf.
+ */
+FUZZ_TEST(test_underflow_on_buffer, struct some_buffer)
+{
+	KFUZZTEST_EXPECT_NOT_NULL(some_buffer, buf);
+	KFUZZTEST_ANNOTATE_LEN(some_buffer, buflen, buf);
+
+	underflow_on_buffer(arg->buf, arg->buflen);
+}
-- 
2.51.0.rc0.205.g4a044479a3-goog



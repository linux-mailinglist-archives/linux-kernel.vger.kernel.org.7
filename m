Return-Path: <linux-kernel+bounces-824777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D776B8A248
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36735B615DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A901831691D;
	Fri, 19 Sep 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE4DWBJj"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92433314D0F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293888; cv=none; b=ozvven+nuhkuoadVsHkhL5HZV7+lDNz0KtuP4yiuA7GE2Mh53KpL8p26+osVWt85KFt4TrZZZGfuLhhcaxDuQANN3oh2Zvz1AaSseB9wWx2R/HgzW2GlQazoI9zDNEAIUlCI1gwtpEKlHqVbpzkaxNFuLpmJ8RTNrwZRBBx784g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293888; c=relaxed/simple;
	bh=mIlo3nceWEuwDvP6l8Crl7X/GDGSd6mMK6Fbkmnwpd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfQMadDDPleraFQCU/fl3Na6tP/qScS04kNKIZSlil5e14svcgsQSFGFNpbL1og2dT8NS3PvhRk4J2r8OLrvSZh4HbSMOqbzzV3zlz89APtgMQcpjOOXII66vlKyfBiV/kJxlGG/0K3UITud6Mde8fhPFW8KWlz3IzHDwothHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE4DWBJj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so946468f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758293884; x=1758898684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBXsJ3eFBRBXMY0OnOP/8+Wo598xHcjcSo7yO9rMMTI=;
        b=UE4DWBJjwYTUE05avpdV29htcXeZSuUcwbdcFjoCMaXtHQTSITOo8g7ycSfH0h28uW
         CKPLXVmHFxr87cw09YBPQUJZBjBy7gKzymz6xsMrR7LNYosxTvIvD+Xt53KX8YtIkY+6
         I/gDubCYTcPeFjZQdJzUhHe1ha2IKhy5BzCyziwTZ1U1iQiNBB/dTZCdRJZBru5TrBb5
         ybmI9VCjz5A49T21Ar8o6MAbJz6vaExa4gVWTEUdI6IjJP6dO0T6AebVmTN2cJHiiGyt
         CerAEgrGFcyoMOFp3VUrSoCKg0/1YnYZv3te9TVsnH2jpYH5f6ZXR0qbKo5aQK7bDnqz
         JH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293884; x=1758898684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBXsJ3eFBRBXMY0OnOP/8+Wo598xHcjcSo7yO9rMMTI=;
        b=NJzPH5ky+NBpfHYLONpD7Xik1rvX7oAmzBiL2KhUzGnKvc7m/dIui2/qqx6FCUoGqF
         rZwtJCT0PbePRaq9XIlbwKi+dZU5u6gcirXhwc1mcntKHHlaY/RhXz1yPaL0ZXrQSTdo
         GyK2ignYc4JIL4vifrNwdpDbWt3Efq0ZoGNB8u0lK2+uxxvJueFAHO1ig7NSbxr5l1QI
         f2hDcHyNB93XGlliRFkeNw+GNmQC6kZhXOBfzfCGHorVeyuK8dg6n4u6nNngEyzUluf+
         0K0UdIIjeu0lhlb68dHk31uyT+q/1tgQdAW66z6txR3cd30+0ILBKMFv+9jkpvqwUtIt
         kZYA==
X-Forwarded-Encrypted: i=1; AJvYcCUCLVHwTlnPT9mNN6oITqIp3XhJzt/5G/UTV/K7WqcZW5PIMICjxnc5DhIJUJ8oilqxBdZeoaGC53jtSQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAQfIgydPKVVWEUrbuToFBS06fwRqsZDVAbrZY4D6/+c3aqty
	tJDR59yf6H7OsmfZNcCXmiI3L45fBRHS39i9hwtHugQcK9liRZFpCCej
X-Gm-Gg: ASbGncvUlIshKmk+u7aIJIlY/b9b0mPTThJ8Y4loSNMAop0qqA8zf/9qtSmuW1RDZF3
	e1PwTaUbgJrNP0WB5fFaYZXjiNNE5DY7OX+g2yqNKP7g868NYelTPhR8TzNg4e7RMlfpTQm79n0
	L19E1BkA+rUYYMM7Jxn8x+SXfaYOpR12g+oe7cqCxDZKzhbGpkUH5wXcKdZCuLQ2AFlVHhTz8Q4
	e/6aYDC6YA6+Q7kTrHO2jphNBN8Zkb2tyJIGBDiWz/BqI9N48gP4ciHlcd+/6qpE72D/2HHgimF
	LSMPj+QcTEUBIJj5Qb06+IBf8UOXUqrvJwTu9gdPXc46bYJr53nOU+eTwZYqYiCvbR6WHHxRAiY
	bSWN/e2L+dr3shHw4BY1H5LjUsuN/s3gslpsHTfmN/puBLWS2WPtPLMXFhpXuZmZszVybHGZyZS
	UxLJ0EgptR2wD6PSo=
X-Google-Smtp-Source: AGHT+IEbUl2JCzptHoApCryobfgPX9okNUcS7jfuNyAQmqaUFFRa2xXzjiLnSNK61qJ4zpujJuNB3w==
X-Received: by 2002:a5d:524d:0:b0:3f2:97a6:db6b with SMTP id ffacd0b85a97d-3f297a70589mr290499f8f.3.1758293883676;
        Fri, 19 Sep 2025 07:58:03 -0700 (PDT)
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
Subject: [PATCH v2 06/10] kfuzztest: add KFuzzTest sample fuzz targets
Date: Fri, 19 Sep 2025 14:57:46 +0000
Message-ID: <20250919145750.3448393-7-ethan.w.s.graham@gmail.com>
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

Add two simple fuzz target samples to demonstrate the KFuzzTest API and
provide basic self-tests for the framework.

These examples showcase how a developer can define a fuzz target using
the FUZZ_TEST(), constraint, and annotation macros, and serve as runtime
sanity checks for the core logic. For example, they test that
out-of-bounds memory accesses into poisoned padding regions are
correctly detected in a KASAN build.

These have been tested by writing syzkaller-generated inputs into their
debugfs 'input' files and verifying that the correct KASAN reports were
triggered.

Signed-off-by: Ethan Graham <ethangraham@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

---
PR v2:
- Fix build issues pointed out by the kernel test robot <lkp@intel.com>.
---
---
 samples/Kconfig                               |  7 ++
 samples/Makefile                              |  1 +
 samples/kfuzztest/Makefile                    |  3 +
 samples/kfuzztest/overflow_on_nested_buffer.c | 71 +++++++++++++++++++
 samples/kfuzztest/underflow_on_buffer.c       | 59 +++++++++++++++
 5 files changed, 141 insertions(+)
 create mode 100644 samples/kfuzztest/Makefile
 create mode 100644 samples/kfuzztest/overflow_on_nested_buffer.c
 create mode 100644 samples/kfuzztest/underflow_on_buffer.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 6e072a5f1ed8..5209dd9d7a5c 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -320,6 +320,13 @@ config SAMPLE_HUNG_TASK
 	  Reading these files with multiple processes triggers hung task
 	  detection by holding locks for a long time (256 seconds).
 
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
index 000000000000..2f1c3ff9f750
--- /dev/null
+++ b/samples/kfuzztest/overflow_on_nested_buffer.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains a KFuzzTest example target that ensures that a buffer
+ * overflow on a nested region triggers a KASAN OOB access report.
+ *
+ * Copyright 2025 Google LLC
+ */
+
+/**
+ * DOC: test_overflow_on_nested_buffer
+ *
+ * This test uses a struct with two distinct dynamically allocated buffers.
+ * It checks that KFuzzTest's memory layout correctly poisons the memory
+ * regions and that KASAN can detect an overflow when reading one byte past the
+ * end of the first buffer (`a`).
+ *
+ * It can be invoked with kfuzztest-bridge using the following command:
+ *
+ * ./kfuzztest-bridge \
+ *   "nested_buffers { ptr[a] len[a, u64] ptr[b] len[b, u64] }; \
+ *   a { arr[u8, 64] }; b { arr[u8, 64] };" \
+ *   "test_overflow_on_nested_buffer" /dev/urandom
+ *
+ * The first argument describes the C struct `nested_buffers` and specifies that
+ * both `a` and `b` are pointers to arrays of 64 bytes.
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
index 000000000000..02704a1bfebb
--- /dev/null
+++ b/samples/kfuzztest/underflow_on_buffer.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains a KFuzzTest example target that ensures that a buffer
+ * underflow on a region triggers a KASAN OOB access report.
+ *
+ * Copyright 2025 Google LLC
+ */
+
+/**
+ * DOC: test_underflow_on_buffer
+ *
+ * This test ensures that the region between the metadata struct and the
+ * dynamically allocated buffer is poisoned. It provokes a one-byte underflow
+ * on the buffer, which should be caught by KASAN.
+ *
+ * It can be invoked with kfuzztest-bridge using the following command:
+ *
+ * ./kfuzztest-bridge \
+ *   "some_buffer { ptr[buf] len[buf, u64]}; buf { arr[u8, 128] };" \
+ *   "test_underflow_on_buffer" /dev/urandom
+ *
+ * The first argument describes the C struct `some_buffer` and specifies that
+ * `buf` is a pointer to an array of 128 bytes. The second argument is the test
+ * name, and the third is a seed file.
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
2.51.0.470.ga7dc726c21-goog



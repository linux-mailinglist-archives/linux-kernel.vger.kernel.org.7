Return-Path: <linux-kernel+bounces-752039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54648B170B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3A13AAFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E2824DCED;
	Thu, 31 Jul 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qY+Vli6W"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFBE2C15BC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962740; cv=none; b=puHAoMc6T9p4AbMtuYpPF+MwR+sM9ZJGM9LpBRHqr5FP37cwsBEwgSbaVWb4n85dTPnaFOfLP3lwZV9pt2nm4E4r9DysPaoyrmIAVcBIFXkIw9F/ugvMPh9CDw+JuglCkSaAhNSjFxN15yhixrH9Jml2C60xAvXasAoNG7mxq8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962740; c=relaxed/simple;
	bh=8s1lFStlYqBNb80I1bimebpW/X9YENeLEuBPuYPSvg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h9BibzIsuXl+phIN4GUs9t8siG85q1RHF3y42OrGZMcqxbrFHT2/XYCx5UZUlDXJkw4JG1vJEoSd5HE7a3tR7/QJAFuVa6jOMQp8j0eKHfOSiExw85QeoItmmEfmCkGmZsHkVMSr9m/jrIFfxq3wBYmlSu+HYqjPUhuTmu8jbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qY+Vli6W; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45867ac308dso4073435e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753962737; x=1754567537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3x7t3g1azUi3Bhe5e/NuO4vXpKA7reEhObrUhymgs0=;
        b=qY+Vli6WzSRuHGCrJ52RA5kTJLQHCdel/oy2z4m5LFwpvtW0BznvsnuQucMzTRicwp
         zINfvcKx7BKiVE7nHJVcxtmq2OJ17AhdRnEnGhHGr+kJ4321rHWDjNxFFw9VVlpZ+w+U
         UhgGUNzAX99qKszaeWrf0uNP91WoZxlQVyUYXTgHZN6jfw6fhXW02PBQ6SuP2K0o7EmR
         2oBzn+SoB3fb+XLkpdL+yhTym41Gi3TPT5Sxq42qQSuelYl+xV30qMaW0iRXMwA30atR
         xR9YtWc0WXLzcBfxmDNoJZQtTPPv+b/YvdqkfJfsQ5nhOHd/b7MvggUsT1Yv/yIbl7Yd
         Sy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962737; x=1754567537;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3x7t3g1azUi3Bhe5e/NuO4vXpKA7reEhObrUhymgs0=;
        b=Lr6Ftmux9q8gcwwpQ0qyHrZzRUwkc7f+WhStHJ3S/gxb+9CgJWpLGO/S7TTX25uQNt
         iUCFUGiRtuv2ygEAid3kiNGjOkPTwJ0rK3+nFMLxRJn2q4mNiaCpD2fOmhiyNwP1gboG
         BqQwqNjOhugPP18AEZCVyXXVWfA/jBl2kPI1Ooz6iEc7PQPPdJqjyeDG7Tw+lUy1NPOh
         I1xhX1Kmkzden2uVwbiQKJImsv/0WrLF1iE1MOu1y46Lo4sBuTqrNYgDpQyA0WZKxm7T
         ROes978kHmBBiaGsZERcf7+E2+FcfrXClagHYvBWxmyY14JLWa/erlHzF0okJ6YKA05N
         Y6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV6TVNZFVyVRsrjYbIIhaCiloTB5gFFc5R0+2GgQ+2gaRT7jy6LM/gmzyBJZe4NdUtlLpeGNAhEabOKueY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfGCySOFQXq09xWO37SjX2GGA2SDOmsZKUfoqSTaASx8IplIvS
	V/fNotpdXN5CXqpzvYaWN9BVA46mD63pPPjNC8TwGkk+mdbjIH4taH3aWNHYwfUgIftGaU23xtY
	YdbNIkg==
X-Google-Smtp-Source: AGHT+IExHF1OViXisfAJMuA5wloCcYI2HYLmUzRgw6/gntLBPE9zL+3/cH0aWSPIIgcd2egwFV35D5XJkfY=
X-Received: from wmbet10.prod.google.com ([2002:a05:600c:818a:b0:458:8d91:62dd])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b6e:b0:456:27a4:50ad
 with SMTP id 5b1f17b1804b1-45892be4bf9mr54021785e9.33.1753962736912; Thu, 31
 Jul 2025 04:52:16 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:51:38 +0200
In-Reply-To: <20250731115139.3035888-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731115139.3035888-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731115139.3035888-10-glider@google.com>
Subject: [PATCH v4 09/10] kcov: selftests: add kcov_test
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Implement test fixtures for testing different combinations of coverage
collection modes:
 - unique and non-unique coverage;
 - collecting PCs and comparison arguments;
 - mapping the buffer as RO and RW.

To build:
 $ make -C tools/testing/selftests/kcov kcov_test

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v4:
 - Per Dmitry Vyukov's request, add CONFIG_KCOV_UNIQUE=y to the
   list of required configs
v3:
 - Address comments by Dmitry Vyukov:
   - add tools/testing/selftests/kcov/config
   - add ifdefs to KCOV_UNIQUE_ENABLE and KCOV_RESET_TRACE
 - Properly handle/reset the coverage buffer when collecting unique
   coverage

Change-Id: I0793f1b91685873c77bcb222a03f64321244df8f
---
 MAINTAINERS                              |   1 +
 tools/testing/selftests/kcov/Makefile    |   6 +
 tools/testing/selftests/kcov/config      |   2 +
 tools/testing/selftests/kcov/kcov_test.c | 401 +++++++++++++++++++++++
 4 files changed, 410 insertions(+)
 create mode 100644 tools/testing/selftests/kcov/Makefile
 create mode 100644 tools/testing/selftests/kcov/config
 create mode 100644 tools/testing/selftests/kcov/kcov_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6906eb9d88dae..c1d64cef693b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13018,6 +13018,7 @@ F:	include/linux/kcov_types.h
 F:	include/uapi/linux/kcov.h
 F:	kernel/kcov.c
 F:	scripts/Makefile.kcov
+F:	tools/testing/selftests/kcov/
 
 KCSAN
 M:	Marco Elver <elver@google.com>
diff --git a/tools/testing/selftests/kcov/Makefile b/tools/testing/selftests/kcov/Makefile
new file mode 100644
index 0000000000000..08abf8b60bcf9
--- /dev/null
+++ b/tools/testing/selftests/kcov/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+LDFLAGS += -static
+
+TEST_GEN_PROGS := kcov_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/kcov/config b/tools/testing/selftests/kcov/config
new file mode 100644
index 0000000000000..ba0c1a0bc8bf2
--- /dev/null
+++ b/tools/testing/selftests/kcov/config
@@ -0,0 +1,2 @@
+CONFIG_KCOV=y
+CONFIG_KCOV_UNIQUE=y
diff --git a/tools/testing/selftests/kcov/kcov_test.c b/tools/testing/selftests/kcov/kcov_test.c
new file mode 100644
index 0000000000000..daf12aeb374b5
--- /dev/null
+++ b/tools/testing/selftests/kcov/kcov_test.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test the kernel coverage (/sys/kernel/debug/kcov).
+ *
+ * Copyright 2025 Google LLC.
+ */
+#include <fcntl.h>
+#include <linux/kcov.h>
+#include <stdint.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+/* Normally these defines should be provided by linux/kcov.h, but they aren't there yet. */
+#ifndef KCOV_UNIQUE_ENABLE
+#define KCOV_UNIQUE_ENABLE _IOW('c', 103, unsigned long)
+#endif
+#ifndef KCOV_RESET_TRACE
+#define KCOV_RESET_TRACE _IO('c', 104)
+#endif
+
+#define COVER_SIZE (64 << 10)
+#define BITMAP_SIZE (4 << 10)
+
+#define DEBUG_COVER_PCS 0
+
+FIXTURE(kcov)
+{
+	int fd;
+	unsigned long *mapping;
+	size_t mapping_size;
+};
+
+FIXTURE_VARIANT(kcov)
+{
+	int mode;
+	bool fast_reset;
+	bool map_readonly;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(kcov, mode_trace_pc)
+{
+	/* clang-format on */
+	.mode = KCOV_TRACE_PC,
+	.fast_reset = true,
+	.map_readonly = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(kcov, mode_trace_cmp)
+{
+	/* clang-format on */
+	.mode = KCOV_TRACE_CMP,
+	.fast_reset = true,
+	.map_readonly = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(kcov, reset_ioctl_rw)
+{
+	/* clang-format on */
+	.mode = KCOV_TRACE_PC,
+	.fast_reset = false,
+	.map_readonly = false,
+};
+
+FIXTURE_VARIANT_ADD(kcov, reset_ioctl_ro)
+/* clang-format off */
+{
+	/* clang-format on */
+	.mode = KCOV_TRACE_PC,
+	.fast_reset = false,
+	.map_readonly = true,
+};
+
+int kcov_open_init(struct __test_metadata *_metadata, unsigned long size,
+		   int prot, unsigned long **out_mapping)
+{
+	unsigned long *mapping;
+
+	/* A single fd descriptor allows coverage collection on a single thread. */
+	int fd = open("/sys/kernel/debug/kcov", O_RDWR);
+
+	ASSERT_NE(fd, -1)
+	{
+		perror("open");
+	}
+
+	EXPECT_EQ(ioctl(fd, KCOV_INIT_TRACE, size), 0)
+	{
+		perror("ioctl KCOV_INIT_TRACE");
+		close(fd);
+	}
+
+	/* Mmap buffer shared between kernel- and user-space. */
+	mapping = (unsigned long *)mmap(NULL, size * sizeof(unsigned long),
+					prot, MAP_SHARED, fd, 0);
+	ASSERT_NE((void *)mapping, MAP_FAILED)
+	{
+		perror("mmap");
+		close(fd);
+	}
+	*out_mapping = mapping;
+
+	return fd;
+}
+
+FIXTURE_SETUP(kcov)
+{
+	int prot = variant->map_readonly ? PROT_READ : (PROT_READ | PROT_WRITE);
+
+	/* Read-only mapping is incompatible with fast reset. */
+	ASSERT_FALSE(variant->map_readonly && variant->fast_reset);
+
+	self->mapping_size = COVER_SIZE;
+	self->fd = kcov_open_init(_metadata, self->mapping_size, prot,
+				  &(self->mapping));
+
+	/* Enable coverage collection on the current thread. */
+	EXPECT_EQ(ioctl(self->fd, KCOV_ENABLE, variant->mode), 0)
+	{
+		perror("ioctl KCOV_ENABLE");
+		/* Cleanup will be handled by FIXTURE_TEARDOWN. */
+		return;
+	}
+}
+
+void kcov_uninit_close(struct __test_metadata *_metadata, int fd,
+		       unsigned long *mapping, size_t size)
+{
+	/* Disable coverage collection for the current thread. */
+	EXPECT_EQ(ioctl(fd, KCOV_DISABLE, 0), 0)
+	{
+		perror("ioctl KCOV_DISABLE");
+	}
+
+	/* Free resources. */
+	EXPECT_EQ(munmap(mapping, size * sizeof(unsigned long)), 0)
+	{
+		perror("munmap");
+	}
+
+	EXPECT_EQ(close(fd), 0)
+	{
+		perror("close");
+	}
+}
+
+FIXTURE_TEARDOWN(kcov)
+{
+	kcov_uninit_close(_metadata, self->fd, self->mapping,
+			  self->mapping_size);
+}
+
+void dump_collected_pcs(struct __test_metadata *_metadata, unsigned long *cover,
+			size_t start, size_t end)
+{
+	int i = 0;
+
+	TH_LOG("Collected %lu PCs", end - start);
+#if DEBUG_COVER_PCS
+	for (i = start; i < end; i++)
+		TH_LOG("0x%lx", cover[i + 1]);
+#endif
+}
+
+/* Coverage collection helper without assertions. */
+unsigned long collect_coverage_unchecked(struct __test_metadata *_metadata,
+					 unsigned long *cover, bool dump)
+{
+	unsigned long before, after;
+
+	before = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
+	/*
+	 * Call the target syscall call. Here we use read(-1, NULL, 0) as an example.
+	 * This will likely return an error (-EFAULT or -EBADF), but the goal is to
+	 * collect coverage for the syscall's entry/exit paths.
+	 */
+	read(-1, NULL, 0);
+
+	after = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
+
+	if (dump)
+		dump_collected_pcs(_metadata, cover, before, after);
+	return after - before;
+}
+
+unsigned long collect_coverage_once(struct __test_metadata *_metadata,
+				    unsigned long *cover)
+{
+	unsigned long collected =
+		collect_coverage_unchecked(_metadata, cover, /*dump*/ true);
+
+	/* Coverage must be non-zero. */
+	EXPECT_GT(collected, 0);
+	return collected;
+}
+
+void reset_coverage(struct __test_metadata *_metadata, bool fast, int fd,
+		    unsigned long *mapping)
+{
+	unsigned long count;
+
+	if (fast) {
+		__atomic_store_n(&mapping[0], 0, __ATOMIC_RELAXED);
+	} else {
+		EXPECT_EQ(ioctl(fd, KCOV_RESET_TRACE, 0), 0)
+		{
+			perror("ioctl KCOV_RESET_TRACE");
+		}
+		count = __atomic_load_n(&mapping[0], __ATOMIC_RELAXED);
+		EXPECT_NE(count, 0);
+	}
+}
+
+TEST_F(kcov, kcov_basic_syscall_coverage)
+{
+	unsigned long first, second, before, after, i;
+
+	/* Reset coverage that may be left over from the fixture setup. */
+	reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
+
+	/* Collect the coverage for a single syscall two times in a row. */
+	first = collect_coverage_once(_metadata, self->mapping);
+	second = collect_coverage_once(_metadata, self->mapping);
+	/* Collected coverage should not differ too much. */
+	EXPECT_GT(first * 10, second);
+	EXPECT_GT(second * 10, first);
+
+	/* Now reset the buffer and collect the coverage again. */
+	reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
+	collect_coverage_once(_metadata, self->mapping);
+
+	/* Now try many times to fill up the buffer. */
+	reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
+	while (collect_coverage_unchecked(_metadata, self->mapping,
+					  /*dump*/ false)) {
+		/* Do nothing. */
+	}
+	before = __atomic_load_n(&(self->mapping[0]), __ATOMIC_RELAXED);
+	/*
+	 * Resetting with ioctl may still generate some coverage, but much less
+	 * than there was before.
+	 */
+	reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
+	after = __atomic_load_n(&(self->mapping[0]), __ATOMIC_RELAXED);
+	EXPECT_GT(before, after);
+	/* Collecting coverage after reset will now succeed. */
+	collect_coverage_once(_metadata, self->mapping);
+}
+
+FIXTURE(kcov_uniq)
+{
+	int fd;
+	unsigned long *mapping;
+	size_t mapping_size;
+	unsigned long *bitmap;
+	size_t bitmap_size;
+	unsigned long *cover;
+	size_t cover_size;
+};
+
+FIXTURE_VARIANT(kcov_uniq)
+{
+	bool fast_reset;
+	bool map_readonly;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(kcov_uniq, fast_rw)
+{
+	/* clang-format on */
+	.fast_reset = true,
+	.map_readonly = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(kcov_uniq, slow_rw)
+{
+	/* clang-format on */
+	.fast_reset = false,
+	.map_readonly = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(kcov_uniq, slow_ro)
+{
+	/* clang-format on */
+	.fast_reset = false,
+	.map_readonly = true,
+};
+
+FIXTURE_SETUP(kcov_uniq)
+{
+	int prot = variant->map_readonly ? PROT_READ : (PROT_READ | PROT_WRITE);
+
+	/* Read-only mapping is incompatible with fast reset. */
+	ASSERT_FALSE(variant->map_readonly && variant->fast_reset);
+
+	self->mapping_size = COVER_SIZE;
+	self->fd = kcov_open_init(_metadata, self->mapping_size, prot,
+				  &(self->mapping));
+
+	self->bitmap = self->mapping;
+	self->bitmap_size = BITMAP_SIZE;
+	/*
+	 * Enable unique coverage collection on the current thread. Carve out
+	 * self->bitmap_size unsigned long's for the bitmap.
+	 */
+	EXPECT_EQ(ioctl(self->fd, KCOV_UNIQUE_ENABLE, self->bitmap_size), 0)
+	{
+		perror("ioctl KCOV_ENABLE");
+		/* Cleanup will be handled by FIXTURE_TEARDOWN. */
+		return;
+	}
+	self->cover = self->mapping + BITMAP_SIZE;
+	self->cover_size = self->mapping_size - BITMAP_SIZE;
+}
+
+FIXTURE_TEARDOWN(kcov_uniq)
+{
+	kcov_uninit_close(_metadata, self->fd, self->mapping,
+			  self->mapping_size);
+}
+
+void reset_uniq_coverage(struct __test_metadata *_metadata, bool fast, int fd,
+			 unsigned long *bitmap, unsigned long *cover)
+{
+	unsigned long count;
+
+	if (fast) {
+		/*
+		 * Resetting the buffer for unique coverage collection requires
+		 * zeroing out the bitmap and cover[0]. We are assuming that
+		 * the coverage buffer immediately follows the bitmap, as they
+		 * belong to the same memory mapping.
+		 */
+		if (cover > bitmap)
+			memset(bitmap, 0, sizeof(unsigned long) * (cover - bitmap));
+		__atomic_store_n(&cover[0], 0, __ATOMIC_RELAXED);
+	} else {
+		EXPECT_EQ(ioctl(fd, KCOV_RESET_TRACE, 0), 0)
+		{
+			perror("ioctl KCOV_RESET_TRACE");
+		}
+		count = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
+		EXPECT_NE(count, 0);
+	}
+}
+
+TEST_F(kcov_uniq, kcov_uniq_coverage)
+{
+	unsigned long first, second, before, after, i;
+
+	/* Reset coverage that may be left over from the fixture setup. */
+	reset_uniq_coverage(_metadata, variant->fast_reset, self->fd, self->bitmap, self->cover);
+
+	/*
+	 * Collect the coverage for a single syscall two times in a row.
+	 * Use collect_coverage_unchecked(), because it may return zero coverage.
+	 */
+	first = collect_coverage_unchecked(_metadata, self->cover,
+					   /*dump*/ true);
+	second = collect_coverage_unchecked(_metadata, self->cover,
+					    /*dump*/ true);
+
+	/* Now reset the buffer and collect the coverage again. */
+	reset_uniq_coverage(_metadata, variant->fast_reset, self->fd, self->bitmap, self->cover);
+	collect_coverage_once(_metadata, self->cover);
+
+	/* Now try many times to saturate the unique coverage bitmap. */
+	reset_uniq_coverage(_metadata, variant->fast_reset, self->fd, self->bitmap, self->cover);
+	for (i = 0; i < 1000; i++)
+		collect_coverage_unchecked(_metadata, self->cover,
+					   /*dump*/ false);
+
+	/* Another invocation of collect_coverage_unchecked() should not produce new coverage. */
+	EXPECT_EQ(collect_coverage_unchecked(_metadata, self->cover,
+					     /*dump*/ false),
+		  0);
+
+	before = __atomic_load_n(&(self->cover[0]), __ATOMIC_RELAXED);
+	/*
+	 * Resetting with ioctl may still generate some coverage, but much less
+	 * than there was before.
+	 */
+	reset_uniq_coverage(_metadata, variant->fast_reset, self->fd, self->bitmap, self->cover);
+	after = __atomic_load_n(&(self->cover[0]), __ATOMIC_RELAXED);
+	EXPECT_GT(before, after);
+	/* Collecting coverage after reset will now succeed. */
+	collect_coverage_once(_metadata, self->cover);
+}
+
+TEST_HARNESS_MAIN
-- 
2.50.1.552.g942d659e1b-goog



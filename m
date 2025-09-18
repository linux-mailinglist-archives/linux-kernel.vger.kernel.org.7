Return-Path: <linux-kernel+bounces-766760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6455FB24ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355B75859F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938682EBDC5;
	Wed, 13 Aug 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgTspBk3"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778E2EAB6A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092326; cv=none; b=bw9n+Pjbv5/Hqj+at4eXfjBKRQEyGYSV0/kTOrphHylMyMuHee8ucGR7nBS1Ly3KyBqJ6q+wGXe28gELaNCUgpUsmfjJNgBNkq3wOa+zmsnTA7XQizKp32igY435Sj+bA3emFLCHY/BvZT0vOaYVYfSA/oSLECV87YeIZDlkxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092326; c=relaxed/simple;
	bh=v5Q3Xn8pa41ckJim5ITQm4P5k3uWaLJtrBCtN7c4kUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpirHLNjNFoi9v1eUEk9u18mrtwlO0qY+O0KU1jHyMTUlIU5K/YMxjjM0d2kw2Uv6yj3+k48wsRuvG+teE2fLZNtWddbmwyPdXwEb3jgIjuxurtzftMODjkVBmOpjvE9qo2+n+HU0E3918nd0vhatiau/gAlzMXoscXbFjCPIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgTspBk3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b913a76ba9so1672600f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755092322; x=1755697122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT8XtIdCS6vk3GGdGM60wvLV9ckvUvGKm1mza8YtIpw=;
        b=AgTspBk3uzRr+uK++jjJfZYF2S6sX6MKGnAQfcwkYxr/3RZlp7KV7RVuQCLXsjZbow
         i4QuvnHA1WPAOT2pGrsDPRCWoVz4M+w3cgIqrPRZhxaqKmnMUGli3hnlWtU1Ahy+HpV0
         VAmO1boZjSXwhy1/WGBQXsO/lSkTA5NwRkT0SOvPuCH5Pa7VoJA/PG7ip4rzcjHur17k
         qbj3YG98FTJAbnY1BqeHkhpRXrcNBA0c67HM6NtiU8/8QsG7xc/U49WPbnkhqcvMAqzc
         VGCHCgyuaqJF+2VuyJ4Si87sX8kDkAYd60GBN0btUFDroqzt4I1VOZPFwDxQIeIUterj
         vMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092322; x=1755697122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fT8XtIdCS6vk3GGdGM60wvLV9ckvUvGKm1mza8YtIpw=;
        b=gsqJY10cqhHx7z+uICtJz1at0uJypvQGbMjwIKX7zw4zxglrEObVCFhnIs+D+q2JJa
         AyPO2jrT8VxvmDnosxc8XyLrMR3/oL2pZs7p7C+Ok5HCayCyx1Ez2Ql3M3RlC6gs2Z8q
         mfPZdaHZNVOa8dhNpav9+2Y+htE0ZGwqlFgUSTN0c9ZlLm0cyXXlQcoh6LrQO8hZnc4p
         Chei/AN8d8AWhlSwfFawE+zVfu4yzI7F0D0H0QbXwz0hm1mxBJL+UpYKXS/Cduie9tdt
         sINYW+FL0UuLni6LShgIWUr4H6w4hTZG3YaNiHDJygzIJlZtKQiU3oqyGm9WQB/C2Rs4
         qoOA==
X-Forwarded-Encrypted: i=1; AJvYcCUNLGwXP3b6manGkHBdHgXpJFl/nq7wQwCs5MMjww1HpNn/p+QJyRMfPvRtSVbZC3MZjiMygwe+MSVVjRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVT5tXgmcof+k8sWc/dTkdAp3DhbsRCAdjFJMjm9k7YmPkpeM
	U34F1OHPQ63vB3geADJSd1iDwiv793D1/ccJbZy3wldu8yW6UiolmFqX
X-Gm-Gg: ASbGncs91Q5jTuIDlaYZVYqh85LMErCXBhmkkc0Nk5L3eQZSPKmWmjxkoTHgMUqosb4
	rFQCo4eH9kSimryR7OA83P67zAaJrkClik9rSPIb4tIM7pPdnfRwNf3jsh9VITwUF+uvItFqs5f
	yPOAUfySa766bZZ6gLEusx44Srg7hhfdKOyODs1lwr5AJcq0wa12DnZFY6roISni8jkcqyERBUG
	7ryhAzAYRgtM+a0W5UAfoG/E1unbtG78bJ9srycASF+UTCWT06Kr0gdgmuvn+lvgyogYIHBS/EY
	uYZrezGeefrCmDuAyfAu1sN7rzMnRLJEM0cNXTtloHe8Gpd9OECA93+ztMGR8shRsqEz1ZSsgqq
	PLJPFPjiRAwVguFFu7CJP6tcid3dBoBXozxW6p6Wy8Epvl1BwS4hoCtK0gl3t4rkQkHccmo+keA
	9ZpwAz5xFYuMG1Z6w=
X-Google-Smtp-Source: AGHT+IG3CJoU5aNy+ncGbe3vgt9XmR0hiIDWH1GBUd5ER+QfQEnq5bQhyK7xzwpgftq1Sivqu1Fxdw==
X-Received: by 2002:a05:6000:26c9:b0:3b8:d6ae:6705 with SMTP id ffacd0b85a97d-3b917ea1577mr2096491f8f.30.1755092322216;
        Wed, 13 Aug 2025 06:38:42 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (87.220.76.34.bc.googleusercontent.com. [34.76.220.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm25677444f8f.69.2025.08.13.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:38:41 -0700 (PDT)
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
Subject: [PATCH v1 RFC 4/6] kfuzztest: add ReST documentation
Date: Wed, 13 Aug 2025 13:38:10 +0000
Message-ID: <20250813133812.926145-5-ethan.w.s.graham@gmail.com>
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

Add Documentation/dev-tools/kfuzztest.rst and reference it in the
dev-tools index.

Signed-off-by: Ethan Graham <ethangraham@google.com>
---
 Documentation/dev-tools/index.rst     |   1 +
 Documentation/dev-tools/kfuzztest.rst | 279 ++++++++++++++++++++++++++
 2 files changed, 280 insertions(+)
 create mode 100644 Documentation/dev-tools/kfuzztest.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 65c54b27a60b..00ccc4da003b 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -32,6 +32,7 @@ Documentation/process/debugging/index.rst
    kfence
    kselftest
    kunit/index
+   kfuzztest
    ktap
    checkuapi
    gpio-sloppy-logic-analyzer
diff --git a/Documentation/dev-tools/kfuzztest.rst b/Documentation/dev-tools/kfuzztest.rst
new file mode 100644
index 000000000000..7fdc4914b966
--- /dev/null
+++ b/Documentation/dev-tools/kfuzztest.rst
@@ -0,0 +1,279 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright 2025 Google LLC
+
+=========================================
+Kernel Fuzz Testing Framework (KFuzzTest)
+=========================================
+
+Overview
+========
+
+The Kernel Fuzz Testing Framework (KFuzzTest) is a framework designed to expose
+internal kernel functions to a userspace fuzzing engine.
+
+It is intended for testing stateless or low-state functions that are difficult
+to reach from the system call interface, such as routines involved in file
+format parsing or complex data transformations. This provides a method for
+in-situ fuzzing of kernel code without requiring that it be built as a separate
+userspace library or that its dependencies be stubbed out.
+
+The framework consists of four main components:
+
+1.  An API, based on the ``FUZZ_TEST`` macro, for defining test targets
+    directly in the kernel tree.
+2.  A binary serialization format for passing complex, pointer-rich data
+    structures from userspace to the kernel.
+3.  A ``debugfs`` interface through which a userspace fuzzer submits
+    serialized test inputs.
+4.  Metadata embedded in dedicated ELF sections of the ``vmlinux`` binary to
+    allow for the discovery of available fuzz targets by external tooling.
+
+.. warning::
+   KFuzzTest is a debugging and testing tool. It exposes internal kernel
+   functions to userspace with minimal sanitization and is designed for
+   use in controlled test environments only. It must **NEVER** be enabled
+   in production kernels.
+
+Supported Architectures
+=======================
+
+KFuzzTest is currently only supported for x86_64.
+
+Usage
+=====
+
+To enable KFuzzTest, configure the kernel with::
+
+	CONFIG_KFUZZTEST=y
+
+which depends on ``CONFIG_DEBUGFS`` for receiving userspace inputs, and
+``CONFIG_DEBUG_KERNEL`` as an additional guardrail for preventing KFuzzTest
+from finding its way into a production build accidentally.
+
+The KFuzzTest sample fuzz targets can be built in with
+``CONFIG_SAMPLE_KFUZZTEST``.
+
+KFuzzTest currently only supports code that is built into the kernel, as the
+core module's startup process discovers fuzz targets, constraints, and
+annotations from a dedicated ELF section during startup.
+
+Declaring a KFuzzTest target
+----------------------------
+
+A fuzz target is defined directly in a .c file, typically alongside the function
+being tested. This process involves three main parts: defining an input
+structure, writing the test body using the ``FUZZ_TEST`` macro, and optionally
+adding metadata for the fuzzer.
+
+The following example illustrates how to create a fuzz target for a function
+``int process_data(const char *data, size_t len)``.
+
+.. code-block:: c
+
+	/*
+	 * 1. Define a struct to model the inputs for the function under test.
+	 *    Each field corresponds to an argument needed by the function.
+	 */
+	struct process_data_inputs {
+		const char *data;
+		size_t len;
+	};
+
+	/*
+	 * 2. Define the fuzz target using the FUZZ_TEST macro.
+	 *    The first parameter is a unique name for the target.
+	 *    The second parameter is the input struct defined above.
+	 */
+	FUZZ_TEST(test_process_data, struct process_data_inputs)
+	{
+		/*
+		 * Within this body, the 'arg' variable is a pointer to a
+		 * fully initialized 'struct process_data_inputs'.
+		 */
+
+		/*
+		 * 3. (Optional) Add constraints to define preconditions.
+		 *    This check ensures 'arg->data' is not NULL. If the condition
+		 *    is not met, the test exits early. This also creates metadata
+		 *    to inform the fuzzer.
+		 */
+		KFUZZTEST_EXPECT_NOT_NULL(process_data_inputs, data);
+
+		/*
+		 * 4. (Optional) Add annotations to provide semantic hints.
+		 *    This annotation informs the fuzzer that the 'len' field
+		 *    is the length of the buffer pointed to by 'data'.
+		 *    Annotations do not add any runtime checks.
+		 */
+		KFUZZTEST_ANNOTATE_LEN(process_data_inputs, len, data);
+
+		/*
+		 * 5. Call the kernel function with the provided inputs.
+		 *    Memory errors like out-of-bounds accesses on 'arg->data' will
+		 *    be detected by KASAN or other memory error detection tools.
+		 */
+		process_data(arg->data, arg->len);
+	}
+
+KFuzzTest provides two families of macros to improve the quality of fuzzing:
+
+- ``KFUZZTEST_EXPECT_*``: These macros define constraints, which are
+  preconditions that must be true for the test to proceed. They are enforced
+  with a runtime check in the kernel. If a check fails, the current test run is
+  aborted. This metadata helps the userspace fuzzer avoid generating invalid
+  inputs.
+
+- ``KFUZZTEST_ANNOTATE_*``: These macros define annotations, which are purely
+  semantic hints for the fuzzer. They do not add any runtime checks and exist
+  only to help the fuzzer generate more intelligent and structurally correct
+  inputs. For example, KFUZZTEST_ANNOTATE_LEN links a size field to a pointer
+  field, which is a common pattern in C APIs.
+
+Metadata
+--------
+
+Macros ``FUZZ_TEST``, `KFUZZTEST_EXPECT_*`` and ``KFUZZTEST_ANNOTATE_*`` embed
+metadata into several sections within the main ``.data`` section of the final
+``vmlinux`` binary; ``.kfuzztest_target``, ``.kfuzztest_constraint`` and
+``.kfuzztest_annotation`` respectively.
+
+This serves two purposes:
+
+1. The core module uses the ``.kfuzztest_target`` section at boot to discover
+   every ``FUZZ_TEST`` instance and create its ``debugfs`` directory and
+   ``input`` file.
+2. Userspace fuzzers can read this metadata from the ``vmlinux`` binary to
+   discover targets and learn about their rules and structure in order to
+   generate correct and effective inputs.
+
+The metadata in the ``.kfuzztest_*`` sections consists of arrays of fixed-size C
+structs (e.g., ``struct kfuzztest_target``). Fields within these structs that
+are pointers, such as ``name`` or ``arg_type_name``, contain addresses that
+point to other locations in the ``vmlinux`` binary. A userspace tool that
+parsing the ELF file must resolve these pointers to read the data that they
+reference. For example, to get a target's name, a tool must:
+
+1. Read the ``struct kfuzztest_target`` from the ``.kfuzztest_target`` section.
+2. Read the address in the ``.name`` field.
+3. Use that address to locate and read null-terminated string from its position
+   elsewhere in the binary (e.g., ``.rodata``).
+
+Tooling Dependencies
+--------------------
+
+For userspace tools to parse the ``vmlinux`` binary and make use of emitted
+KFuzzTest metadata, the kernel must be compiled with DWARF debug information.
+This is required for tools to understand the layout of C structs, resolve type
+information, and correctly interpret constraints and annotations.
+
+When using KFuzzTest with automated fuzzing tools, either
+``CONFIG_DEBUG_INFO_DWARF4`` or ``CONFIG_DEBUG_INFO_DWARF5`` should be enabled.
+
+Input Format
+============
+
+KFuzzTest targets receive their inputs from userspace via a write to a dedicated
+debugfs ``/sys/kernel/debug/kfuzztest/<test-name>/input``.
+
+The data written to this file must be a single binary blob that follows a
+specific serialization format. This format is designed to allow complex,
+pointer-rich C structures to be represented in a flat buffer, requiring only a
+single kernel allocation and copy from userspace.
+
+An input is first prefixed by an 8-byte header containing a magic value in the
+first four bytes, defined as ``KFUZZTEST_HEADER_MAGIC`` in
+`<include/linux/kfuzztest.h>``, and a version number in the subsequent four
+bytes.
+
+Version 0
+---------
+
+In version 0 (i.e., when the version number in the 8-byte header is equal to 0),
+the input format consists of three main parts laid out sequentially: a region
+array, a relocation table, and the payload.::
+
+    +----------------+---------------------+-----------+----------------+
+    |  region array  |  relocation table   |  padding  |    payload     |
+    +----------------+---------------------+-----------+----------------+
+
+Region Array
+^^^^^^^^^^^^
+
+This component is a header that describes how the raw data in the Payload is
+partitioned into logical memory regions. It consists of a count of regions
+followed by an array of ``struct reloc_region``, where each entry defines a
+single region with its size and offset from the start of the payload.
+
+.. code-block:: c
+
+	struct reloc_region {
+		uint32_t offset;
+		uint32_t size;
+	};
+
+	struct reloc_region_array {
+		uint32_t num_regions;
+		struct reloc_region regions[];
+	};
+
+By convention, region 0 represents the top-level input struct that is passed
+as the arg variable to the FUZZ_TEST body. Subsequent regions typically
+represent data buffers pointed to by fields within that struct. Region array
+entries must be ordered by offset ascending, and must not overlap with one
+another.
+
+To satisfy C language alignment requirements and prevent potential hardware
+faults, the memory address of each region's data must be correctly aligned for
+the type it represents. The framework allocates a base buffer that is suitably
+aligned for any C type. Therefore, the userspace tool that generates the input
+is responsible for calculating each region's offset within the payload to ensure
+this alignment is maintained.
+
+Relocation Table
+^^^^^^^^^^^^^^^^
+
+The relocation table provides the instructions for the kernel to "hydrate" the
+payload by patching pointer fields. It contains an array of
+``struct reloc_entry`` items. Each entry acts as a linking instruction,
+specifying:
+
+- The location of a pointer that needs to be patched (identified by a region
+  ID and an offset within that region).
+
+- The target region that the pointer should point to (identified by the
+  target's region ID) or ``KFUZZTEST_REGIONID_NULL`` if the pointer is ``NULL``.
+
+This table also specifies the amount of padding between its end and the start
+of the payload, which should be at least 8 bytes.
+
+.. code-block:: c
+
+	struct reloc_entry {
+		uint32_t region_id;
+		uint32_t region_offset;
+		uint32_t value;
+	};
+
+	struct reloc_table {
+		uint32_t num_entries;
+		uint32_t padding_size;
+		struct reloc_entry entries[];
+    };
+
+Payload
+^^^^^^^
+
+The payload contains the raw binary data for all regions, concatenated together
+according to their specified offsets.
+
+- Alignment: The start of the payload must be aligned to the most restrictive
+  alignment requirement of all its constituent regions. The framework ensures
+  that each region within the payload is then placed at an offset that respects
+  its own type's alignment.
+
+- Padding and Poisoning: The space between the end of one region's data and the
+  beginning of the next must be sufficient for padding. In KASAN builds,
+  KFuzzTest poisons this unused padding, allowing for precise detection of
+  out-of-bounds memory accesses between adjacent buffers. This padding should
+  be at least ``KFUZZTEST_POISON_SIZE`` bytes as defined in
+  `include/linux/kfuzztest.h``.
-- 
2.51.0.rc0.205.g4a044479a3-goog



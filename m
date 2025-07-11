Return-Path: <linux-kernel+bounces-727627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B5BB01D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311EF1CA521F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0682D23BA;
	Fri, 11 Jul 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="x2YCXnem"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEB29AAFC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240002; cv=none; b=qthYqS/R7T8mvAipjrsjxiGNAr5Y0y9+VQfICJCmxurDup9yW51nreXxG8661gyeMJwv4bJVFfeA+aF3GsVIwgwHGCMguZY35d2c/uHUJflewkyy4NMyrEPnc///j5jQzQoOo8vW1SK57N1c8vhSOtce7ujyQpeYCEerTpfFyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240002; c=relaxed/simple;
	bh=HQrEf5cxYsPuilWdbZhEN6kTQHr6QXxvfSFQxNr1Prw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6o4npM3QTi//BXekcl+43oQO3gMud6c0fA7g75HcY1RbuWC14IE512bsj0zXI16kEWe6ym3cjqJ+D11v+7OV9ilkbwhMKEsz/7zcdC1ifntevdwwVTeObsTGTQv9Zprtn6MOkoMICy5VmnU9sMXJnIBu5uxdeXiKKXrDihySrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=x2YCXnem; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235d6de331fso24632525ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752239999; x=1752844799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6//hd5/2Hzqt0npYzE6gaxMoRCrJFz+kATaycN9jSlk=;
        b=x2YCXnemXgxgnJhZBtXUsoABa0L4EwlND3wP0S0B43ZQYQ1KZ5N7ymQ9pkyPLjlW4U
         Cpy0/A7VXAH7sZN5aW21sFidCRC5vbYNYL4MXpq04Bii7L7e764jexg3ddX8yxPc0pXC
         a1esYYxECCOVeZLbOiNj2OkYBTLdocGS4C1YcRIZ0TWKo16xrT3hKh2TypRKw3dJ02xa
         nBbjyMWOvKjqjvFDZ6ghzFZ/yHEJv/hUJmfZFnU1FQLk248LmTiS2ig0zjeiBaLpMAbe
         B9dqjF0IbmjYH7dsNnlGDuQjxUF7v8N9fDVZzH0j5geL2X1DeFMKK2vyqS8CgRGYuFlG
         /KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752239999; x=1752844799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6//hd5/2Hzqt0npYzE6gaxMoRCrJFz+kATaycN9jSlk=;
        b=ZJFK6Y8WpMRRJJjxVTudCy7CK5L619l5b6j4JHlXBpQTkoVjPWQe/Gk32dey5ZTsAq
         Um1Yb6N3C1akSQtoh9d/lLUCuho7uwvkhBxQZZvIXPEK9gWiv/syXPLSwDHv4TBzR2Vr
         P5PM4tcr68vWaQaLiVlbTJDDmb/Cxi4zhqlItWqx08y/UhOb1On9m5SnIFPUbB3+JLaD
         Oj/aBU76BBmRaXmtLQ1PleQp43zJHc1uwKwM5K6wJ3qddco4P/i/g87u06l2rv0Eemnh
         ULtwgsWlAMwqE9sVQaGLDmlXGAmsGYvgmC1GG+0Be2UNH0nm6rRIRCKZJJlXVNzCH6OP
         aMDQ==
X-Gm-Message-State: AOJu0Yx4mXUGLkjsle917hXFz0jOGkYkkXZCVlh9vOd+Tv9umxbsz0cN
	zuxkwxm9P99N7rAEVw1Nz+yH2AntgpatxhH6uZ/AKpfFE6PDvNnJh2fU6EApXX3trr5151J/pvs
	dSL7C
X-Gm-Gg: ASbGncslHHSQ+YiVmeQ/tkr+EIVuw0G/xzsnN6haoc40eEnlChSYN+f+KpiqvmltZen
	VgQmbZ4A6S7Jf2XZTW3IQYxiW2C1vk1r923tB3Bw/NNaeXwNjw8H050EShV0j1c3Sa44IFgEILq
	abqIRRWuNFL3gdZ6onIJLCzujxC3glknc7EUR6ohOEE4CkT273muVcvUbIS8cFCqIOTq5SWPMGH
	7rhj+wn30eQcOUnDfpAy326ys5MPlNeUpT+YOi6X84S26OxP/pQuHfUQ+3XbZgqFfHNc3hqiuUg
	g/5/Z7Ft/uCM6uV+94LjFkFjYmJK7332gSVDUNLxx1N7LJm03RFJJEoJUX2m4I1Gs1tIw2WvG1K
	+zb+6UQkM8Jp2WQ==
X-Google-Smtp-Source: AGHT+IHxrRQsPtuvfbXx6QfQiO/WeYYzyL8cHrvNDnYrHbvIxocomxFbz25k5rB1zAsStkf+RMEFpw==
X-Received: by 2002:a17:903:a4f:b0:235:f70:fd39 with SMTP id d9443c01a7336-23dede2e17cmr37632915ad.10.1752239998668;
        Fri, 11 Jul 2025 06:19:58 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52e261sm5158486a12.2.2025.07.11.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 06:19:57 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andreas Schwab <schwab@suse.de>
Subject: [PATCH v5] selftests: riscv: add misaligned access testing
Date: Fri, 11 Jul 2025 13:19:24 +0000
Message-ID: <20250711131925.112485-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This selftest tests all the currently emulated instructions (except for
the RV32 compressed ones which are left as a future exercise for a RV32
user). For the FPU instructions, all the FPU registers are tested.

Signed-off-by: Clément Léger <cleger@rivosinc.com>

---

This commits needs [1] for the test to be passed or it will fail due to
missing sign extension.

Note: This test can be executed using an SBI that support FWFT or that
delegates misaligned traps by default. If using QEMU, you will need
the patches mentioned at [2] so that misaligned accesses will generate
a trap.

Note: This commit was part of a series [3] that was partially merged.

Note: the remaining checkpatch errors are not applicable to this tests
which is a userspace one and does not use the kernel headers. Macros
with complex values can not be enclosed in do while loop since they are
generating functions.

Link: https://lore.kernel.org/linux-riscv/mvmikk0goil.fsf@suse.de/ [1]
Link: https://lore.kernel.org/all/20241211211933.198792-1-fkonrad@amd.com/ [2]
Link: https://lore.kernel.org/linux-riscv/20250422162324.956065-1-cleger@rivosinc.com/ [3]

V5:
 - Sign extend LWU return value
 - Added sign extensions tests
 - Tests multiples values for GP load/store

V4:
 - Fixed a typo in test name s/load/store

V3:
 - Fixed a segfault and a sign extension error found when compiling with
  -O<x>, x != 0 (Alex)
 - Use inline assembly to generate the sigbus and avoid GCC
   optimizations

V2:
 - Fix commit description
 - Fix a few errors reported by checkpatch.pl
---
 tools/testing/selftests/riscv/Makefile        |   2 +-
 .../selftests/riscv/misaligned/.gitignore     |   1 +
 .../selftests/riscv/misaligned/Makefile       |  12 +
 .../selftests/riscv/misaligned/common.S       |  33 ++
 .../testing/selftests/riscv/misaligned/fpu.S  | 180 +++++++++++
 tools/testing/selftests/riscv/misaligned/gp.S | 113 +++++++
 .../selftests/riscv/misaligned/misaligned.c   | 288 ++++++++++++++++++
 7 files changed, 628 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/misaligned/.gitignore
 create mode 100644 tools/testing/selftests/riscv/misaligned/Makefile
 create mode 100644 tools/testing/selftests/riscv/misaligned/common.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/fpu.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/gp.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/misaligned.c

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 099b8c1f46f8..95a98ceeb3b3 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector
+RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector misaligned
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/misaligned/.gitignore b/tools/testing/selftests/riscv/misaligned/.gitignore
new file mode 100644
index 000000000000..5eff15a1f981
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/.gitignore
@@ -0,0 +1 @@
+misaligned
diff --git a/tools/testing/selftests/riscv/misaligned/Makefile b/tools/testing/selftests/riscv/misaligned/Makefile
new file mode 100644
index 000000000000..1aa40110c50d
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 ARM Limited
+# Originally tools/testing/arm64/abi/Makefile
+
+CFLAGS += -I$(top_srcdir)/tools/include
+
+TEST_GEN_PROGS := misaligned
+
+include ../../lib.mk
+
+$(OUTPUT)/misaligned: misaligned.c fpu.S gp.S
+	$(CC) -g3 -static -o$@ -march=rv64imafdc $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/misaligned/common.S b/tools/testing/selftests/riscv/misaligned/common.S
new file mode 100644
index 000000000000..8fa00035bd5d
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/common.S
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Rivos Inc.
+ *
+ * Authors:
+ *     Clément Léger <cleger@rivosinc.com>
+ */
+
+.macro lb_sb temp, offset, src, dst
+	lb \temp, \offset(\src)
+	sb \temp, \offset(\dst)
+.endm
+
+.macro copy_long_to temp, src, dst
+	lb_sb \temp, 0, \src, \dst,
+	lb_sb \temp, 1, \src, \dst,
+	lb_sb \temp, 2, \src, \dst,
+	lb_sb \temp, 3, \src, \dst,
+	lb_sb \temp, 4, \src, \dst,
+	lb_sb \temp, 5, \src, \dst,
+	lb_sb \temp, 6, \src, \dst,
+	lb_sb \temp, 7, \src, \dst,
+.endm
+
+.macro sp_stack_prologue offset
+	addi sp, sp, -8
+	sub sp, sp, \offset
+.endm
+
+.macro sp_stack_epilogue offset
+	add sp, sp, \offset
+	addi sp, sp, 8
+.endm
diff --git a/tools/testing/selftests/riscv/misaligned/fpu.S b/tools/testing/selftests/riscv/misaligned/fpu.S
new file mode 100644
index 000000000000..a7ad4430a424
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/fpu.S
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Rivos Inc.
+ *
+ * Authors:
+ *     Clément Léger <cleger@rivosinc.com>
+ */
+
+#include "common.S"
+
+#define CASE_ALIGN		4
+
+.macro fpu_load_inst fpreg, inst, precision, load_reg
+.align CASE_ALIGN
+	\inst \fpreg, 0(\load_reg)
+	fmv.\precision fa0, \fpreg
+	j 2f
+.endm
+
+#define flw(__fpreg) fpu_load_inst __fpreg, flw, s, a4
+#define fld(__fpreg) fpu_load_inst __fpreg, fld, d, a4
+#define c_flw(__fpreg) fpu_load_inst __fpreg, c.flw, s, a4
+#define c_fld(__fpreg) fpu_load_inst __fpreg, c.fld, d, a4
+#define c_fldsp(__fpreg) fpu_load_inst __fpreg, c.fldsp, d, sp
+
+.macro fpu_store_inst fpreg, inst, precision, store_reg
+.align CASE_ALIGN
+	fmv.\precision \fpreg, fa0
+	\inst \fpreg, 0(\store_reg)
+	j 2f
+.endm
+
+#define fsw(__fpreg) fpu_store_inst __fpreg, fsw, s, a4
+#define fsd(__fpreg) fpu_store_inst __fpreg, fsd, d, a4
+#define c_fsw(__fpreg) fpu_store_inst __fpreg, c.fsw, s, a4
+#define c_fsd(__fpreg) fpu_store_inst __fpreg, c.fsd, d, a4
+#define c_fsdsp(__fpreg) fpu_store_inst __fpreg, c.fsdsp, d, sp
+
+.macro fp_test_prologue
+	move a4, a1
+	/*
+	 * Compute jump offset to store the correct FP register since we don't
+	 * have indirect FP register access (or at least we don't use this
+	 * extension so that works on all archs)
+	 */
+	sll t0, a0, CASE_ALIGN
+	la t2, 1f
+	add t0, t0, t2
+	jr t0
+.align	CASE_ALIGN
+1:
+.endm
+
+.macro fp_test_prologue_compressed
+	/* FP registers for compressed instructions starts from 8 to 16 */
+	addi a0, a0, -8
+	fp_test_prologue
+.endm
+
+#define fp_test_body_compressed(__inst_func) \
+	__inst_func(f8); \
+	__inst_func(f9); \
+	__inst_func(f10); \
+	__inst_func(f11); \
+	__inst_func(f12); \
+	__inst_func(f13); \
+	__inst_func(f14); \
+	__inst_func(f15); \
+2:
+
+#define fp_test_body(__inst_func) \
+	__inst_func(f0); \
+	__inst_func(f1); \
+	__inst_func(f2); \
+	__inst_func(f3); \
+	__inst_func(f4); \
+	__inst_func(f5); \
+	__inst_func(f6); \
+	__inst_func(f7); \
+	__inst_func(f8); \
+	__inst_func(f9); \
+	__inst_func(f10); \
+	__inst_func(f11); \
+	__inst_func(f12); \
+	__inst_func(f13); \
+	__inst_func(f14); \
+	__inst_func(f15); \
+	__inst_func(f16); \
+	__inst_func(f17); \
+	__inst_func(f18); \
+	__inst_func(f19); \
+	__inst_func(f20); \
+	__inst_func(f21); \
+	__inst_func(f22); \
+	__inst_func(f23); \
+	__inst_func(f24); \
+	__inst_func(f25); \
+	__inst_func(f26); \
+	__inst_func(f27); \
+	__inst_func(f28); \
+	__inst_func(f29); \
+	__inst_func(f30); \
+	__inst_func(f31); \
+2:
+.text
+
+#define __gen_test_inst(__inst, __suffix) \
+.global test_ ## __inst; \
+test_ ## __inst:; \
+	fp_test_prologue ## __suffix; \
+	fp_test_body ## __suffix(__inst); \
+	ret
+
+#define gen_test_inst_compressed(__inst) \
+	.option arch,+c; \
+	__gen_test_inst(c_ ## __inst, _compressed)
+
+#define gen_test_inst(__inst) \
+	.balign 16; \
+	.option push; \
+	.option arch,-c; \
+	__gen_test_inst(__inst, ); \
+	.option pop
+
+.macro fp_test_prologue_load_compressed_sp
+	copy_long_to t0, a1, sp
+.endm
+
+.macro fp_test_epilogue_load_compressed_sp
+.endm
+
+.macro fp_test_prologue_store_compressed_sp
+.endm
+
+.macro fp_test_epilogue_store_compressed_sp
+	copy_long_to t0, sp, a1
+.endm
+
+#define gen_inst_compressed_sp(__inst, __type) \
+	.global test_c_ ## __inst ## sp; \
+	test_c_ ## __inst ## sp:; \
+		sp_stack_prologue a2; \
+		fp_test_prologue_## __type ## _compressed_sp; \
+		fp_test_prologue_compressed; \
+		fp_test_body_compressed(c_ ## __inst ## sp); \
+		fp_test_epilogue_## __type ## _compressed_sp; \
+		sp_stack_epilogue a2; \
+		ret
+
+#define gen_test_load_compressed_sp(__inst) gen_inst_compressed_sp(__inst, load)
+#define gen_test_store_compressed_sp(__inst) gen_inst_compressed_sp(__inst, store)
+
+/*
+ * float_fsw_reg - Set a FP register from a register containing the value
+ * a0 = FP register index to be set
+ * a1 = addr where to store register value
+ * a2 = address offset
+ * a3 = value to be store
+ */
+gen_test_inst(fsw)
+
+/*
+ * float_flw_reg - Get a FP register value and return it
+ * a0 = FP register index to be retrieved
+ * a1 = addr to load register from
+ * a2 = address offset
+ */
+gen_test_inst(flw)
+
+gen_test_inst(fsd)
+#ifdef __riscv_compressed
+gen_test_inst_compressed(fsd)
+gen_test_store_compressed_sp(fsd)
+#endif
+
+gen_test_inst(fld)
+#ifdef __riscv_compressed
+gen_test_inst_compressed(fld)
+gen_test_load_compressed_sp(fld)
+#endif
diff --git a/tools/testing/selftests/riscv/misaligned/gp.S b/tools/testing/selftests/riscv/misaligned/gp.S
new file mode 100644
index 000000000000..5abec5ccc828
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/gp.S
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Rivos Inc.
+ *
+ * Authors:
+ *     Clément Léger <cleger@rivosinc.com>
+ */
+
+#include "common.S"
+
+.text
+
+.macro __gen_test_inst inst, src_reg
+	\inst a2, 0(\src_reg)
+	move a0, a2
+.endm
+
+.macro gen_func_header func_name, rvc
+	.option arch,\rvc
+	.global test_\func_name
+	test_\func_name:
+.endm
+
+.macro gen_test_inst inst
+	.option push
+	gen_func_header \inst, -c
+	__gen_test_inst \inst, a0
+	.option pop
+	ret
+.endm
+
+.macro gen_test_lwu
+	.option push
+	gen_func_header lwu, -c
+	__gen_test_inst lwu, a0
+	.option pop
+	# RISC-V ABI states that C expect a sign extended 32 bits integer
+	sext.w a0, a0
+	ret
+.endm
+
+.macro __gen_test_inst_c name, src_reg
+	.option push
+	gen_func_header c_\name, +c
+	 __gen_test_inst c.\name, \src_reg
+	.option pop
+	ret
+.endm
+
+.macro gen_test_inst_c name
+ 	__gen_test_inst_c \name, a0
+.endm
+
+
+.macro gen_test_inst_c_ldsp
+	.option push
+	gen_func_header c_ldsp, +c
+	sp_stack_prologue a1
+	copy_long_to t0, a0, sp
+	c.ldsp a0, 0(sp)
+	sp_stack_epilogue a1
+	.option pop
+	ret
+.endm
+
+.macro lb_sp_sb_a0 reg, offset
+	lb_sb \reg, \offset, sp, a0
+.endm
+
+.macro gen_test_inst_c_sdsp
+	.option push
+	gen_func_header c_sdsp, +c
+	/* Misalign stack pointer */
+	sp_stack_prologue a1
+	/* Misalign access */
+	c.sdsp a2, 0(sp)
+	copy_long_to t0, sp, a0
+	sp_stack_epilogue a1
+	.option pop
+	ret
+.endm
+
+
+ /*
+ * a0 = addr to load from
+ * a1 = address offset
+ * a2 = value to be loaded
+ */
+gen_test_inst lh
+gen_test_inst lhu
+gen_test_inst lw
+gen_test_lwu
+gen_test_inst ld
+#ifdef __riscv_compressed
+gen_test_inst_c lw
+gen_test_inst_c ld
+gen_test_inst_c_ldsp
+#endif
+
+/*
+ * a0 = addr where to store value
+ * a1 = address offset
+ * a2 = value to be stored
+ */
+gen_test_inst sh
+gen_test_inst sw
+gen_test_inst sd
+#ifdef __riscv_compressed
+gen_test_inst_c sw
+gen_test_inst_c sd
+gen_test_inst_c_sdsp
+#endif
+
diff --git a/tools/testing/selftests/riscv/misaligned/misaligned.c b/tools/testing/selftests/riscv/misaligned/misaligned.c
new file mode 100644
index 000000000000..57ddcbdc947c
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/misaligned.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Rivos Inc.
+ *
+ * Authors:
+ *     Clément Léger <cleger@rivosinc.com>
+ */
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/ptrace.h>
+#include "../../kselftest_harness.h"
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <float.h>
+#include <errno.h>
+#include <math.h>
+#include <string.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <ucontext.h>
+
+#include <sys/prctl.h>
+
+#define stringify(s) __stringify(s)
+#define __stringify(s) #s
+
+#define U8_MAX		((u8)~0U)
+#define S8_MAX		((s8)(U8_MAX >> 1))
+#define S8_MIN		((s8)(-S8_MAX - 1))
+#define U16_MAX		((u16)~0U)
+#define S16_MAX		((s16)(U16_MAX >> 1))
+#define S16_MIN		((s16)(-S16_MAX - 1))
+#define U32_MAX		((u32)~0U)
+#define U32_MIN		((u32)0)
+#define S32_MAX		((s32)(U32_MAX >> 1))
+#define S32_MIN		((s32)(-S32_MAX - 1))
+#define U64_MAX		((u64)~0ULL)
+#define S64_MAX		((s64)(U64_MAX >> 1))
+#define S64_MIN		((s64)(-S64_MAX - 1))
+
+#define int16_TEST_VALUES	{S16_MIN, S16_MIN/2, -1, 1, S16_MAX/2, S16_MAX}
+#define int32_TEST_VALUES	{S32_MIN, S32_MIN/2, -1, 1, S32_MAX/2, S32_MAX}
+#define int64_TEST_VALUES	{S64_MIN, S64_MIN/2, -1, 1, S64_MAX/2, S64_MAX}
+#define uint16_TEST_VALUES	{0, U16_MAX/2, U16_MAX}
+#define uint32_TEST_VALUES	{0, U32_MAX/2, U32_MAX}
+
+#define float_TEST_VALUES	{FLT_MIN, FLT_MIN/2, FLT_MAX/2, FLT_MAX}
+#define double_TEST_VALUES	{DBL_MIN, DBL_MIN/2, DBL_MAX/2, DBL_MAX}
+
+static bool float_equal(float a, float b)
+{
+	float scaled_epsilon;
+	float difference = fabsf(a - b);
+
+	// Scale to the largest value.
+	a = fabsf(a);
+	b = fabsf(b);
+	if (a > b)
+		scaled_epsilon = FLT_EPSILON * a;
+	else
+		scaled_epsilon = FLT_EPSILON * b;
+
+	return difference <= scaled_epsilon;
+}
+
+static bool double_equal(double a, double b)
+{
+	double scaled_epsilon;
+	double difference = fabsl(a - b);
+
+	// Scale to the largest value.
+	a = fabs(a);
+	b = fabs(b);
+	if (a > b)
+		scaled_epsilon = DBL_EPSILON * a;
+	else
+		scaled_epsilon = DBL_EPSILON * b;
+
+	return difference <= scaled_epsilon;
+}
+
+#define fpu_load_proto(__inst, __type) \
+extern __type test_ ## __inst(unsigned long fp_reg, void *addr, unsigned long offset, __type value)
+
+fpu_load_proto(flw, float);
+fpu_load_proto(fld, double);
+fpu_load_proto(c_flw, float);
+fpu_load_proto(c_fld, double);
+fpu_load_proto(c_fldsp, double);
+
+#define fpu_store_proto(__inst, __type) \
+extern void test_ ## __inst(unsigned long fp_reg, void *addr, unsigned long offset, __type value)
+
+fpu_store_proto(fsw, float);
+fpu_store_proto(fsd, double);
+fpu_store_proto(c_fsw, float);
+fpu_store_proto(c_fsd, double);
+fpu_store_proto(c_fsdsp, double);
+
+#define gp_load_proto(__inst, __type) \
+extern __type test_ ## __inst(void *addr, unsigned long offset, __type value)
+
+gp_load_proto(lh, int16_t);
+gp_load_proto(lhu, uint16_t);
+gp_load_proto(lw, int32_t);
+gp_load_proto(lwu, uint32_t);
+gp_load_proto(ld, int64_t);
+gp_load_proto(c_lw, int32_t);
+gp_load_proto(c_ld, int64_t);
+gp_load_proto(c_ldsp, int64_t);
+
+#define gp_store_proto(__inst, __type) \
+extern void test_ ## __inst(void *addr, unsigned long offset, __type value)
+
+gp_store_proto(sh, int16_t);
+gp_store_proto(sw, int32_t);
+gp_store_proto(sd, int64_t);
+gp_store_proto(c_sw, int32_t);
+gp_store_proto(c_sd, int64_t);
+gp_store_proto(c_sdsp, int64_t);
+
+#define TEST_GP_LOAD(__inst, __type_size, __type)					\
+TEST(gp_load_ ## __inst)								\
+{											\
+	int offset, ret, val_i;								\
+	uint8_t buf[16] __attribute__((aligned(16)));					\
+	__type ## __type_size ## _t test_val[] = __type ## __type_size ## _TEST_VALUES;	\
+											\
+	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);				\
+	ASSERT_EQ(ret, 0);								\
+											\
+	for (offset = 1; offset < (__type_size) / 8; offset++) {			\
+		for (val_i = 0; val_i < ARRAY_SIZE(test_val); val_i++) {		\
+			__type ## __type_size ## _t ref_val = test_val[val_i];		\
+			__type ## __type_size ## _t *ptr =				\
+					(__type ## __type_size ## _t *)(buf + offset);	\
+			memcpy(ptr, &ref_val, sizeof(ref_val));				\
+			__type ## __type_size ## _t val =				\
+						test_ ## __inst(ptr, offset, ref_val);	\
+			EXPECT_EQ(ref_val, val);					\
+		}									\
+	}										\
+}
+
+TEST_GP_LOAD(lh, 16, int)
+TEST_GP_LOAD(lhu, 16, uint)
+TEST_GP_LOAD(lw, 32, int)
+TEST_GP_LOAD(lwu, 32, uint)
+TEST_GP_LOAD(ld, 64, int)
+#ifdef __riscv_compressed
+TEST_GP_LOAD(c_lw, 32, int)
+TEST_GP_LOAD(c_ld, 64, int)
+TEST_GP_LOAD(c_ldsp, 64, int)
+#endif
+
+#define TEST_GP_STORE(__inst, __type_size, __type)				\
+TEST(gp_store_ ## __inst)							\
+{										\
+	int offset, ret, val_i;							\
+	uint8_t buf[16] __attribute__((aligned(16)));				\
+	__type ## __type_size ## _t test_val[] =				\
+					__type ## __type_size ## _TEST_VALUES;	\
+										\
+	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);			\
+	ASSERT_EQ(ret, 0);							\
+										\
+	for (val_i = 0; val_i < ARRAY_SIZE(test_val); val_i++) {		\
+		__type ## __type_size ## _t ref_val = test_val[val_i];		\
+		for (offset = 1; offset < (__type_size) / 8; offset++) {	\
+			__type ## __type_size ## _t val = ref_val;		\
+			__type ## __type_size ## _t *ptr =			\
+				 (__type ## __type_size ## _t *)(buf + offset); \
+			memset(ptr, 0, sizeof(val));				\
+			test_ ## __inst(ptr, offset, val);			\
+			memcpy(&val, ptr, sizeof(val));				\
+			EXPECT_EQ(ref_val, val);				\
+		}								\
+	}									\
+}
+
+TEST_GP_STORE(sh, 16, int)
+TEST_GP_STORE(sw, 32, int)
+TEST_GP_STORE(sd, 64, int)
+#ifdef __riscv_compressed
+TEST_GP_STORE(c_sw, 32, int)
+TEST_GP_STORE(c_sd, 64, int)
+TEST_GP_STORE(c_sdsp, 64, int)
+#endif
+
+#define __TEST_FPU_LOAD(__type, __inst, __reg_start, __reg_end)					\
+TEST(fpu_load_ ## __inst)									\
+{												\
+	int ret, offset, fp_reg, val_i;								\
+	uint8_t buf[16] __attribute__((aligned(16)));						\
+	__type test_val[] = __type ## _TEST_VALUES;						\
+												\
+	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);					\
+	ASSERT_EQ(ret, 0);									\
+												\
+	for (fp_reg = __reg_start; fp_reg < __reg_end; fp_reg++) {				\
+		for (offset = 1; offset < 4; offset++) {					\
+			for (val_i = 0; val_i < ARRAY_SIZE(test_val); val_i++) {		\
+				__type val, ref_val = test_val[val_i];				\
+				void *load_addr = (buf + offset);				\
+												\
+				memcpy(load_addr, &ref_val, sizeof(ref_val));			\
+				val = test_ ## __inst(fp_reg, load_addr, offset, ref_val);	\
+				EXPECT_TRUE(__type ##_equal(val, ref_val));			\
+			}									\
+		}										\
+	}											\
+}
+
+#define TEST_FPU_LOAD(__type, __inst) \
+	__TEST_FPU_LOAD(__type, __inst, 0, 32)
+#define TEST_FPU_LOAD_COMPRESSED(__type, __inst) \
+	__TEST_FPU_LOAD(__type, __inst, 8, 16)
+
+TEST_FPU_LOAD(float, flw)
+TEST_FPU_LOAD(double, fld)
+#ifdef __riscv_compressed
+TEST_FPU_LOAD_COMPRESSED(double, c_fld)
+TEST_FPU_LOAD_COMPRESSED(double, c_fldsp)
+#endif
+
+#define __TEST_FPU_STORE(__type, __inst, __reg_start, __reg_end)			\
+TEST(fpu_store_ ## __inst)								\
+{											\
+	int ret, offset, fp_reg, val_i;							\
+	uint8_t buf[16] __attribute__((aligned(16)));					\
+	__type test_val[] = __type ## _TEST_VALUES;					\
+											\
+	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);				\
+	ASSERT_EQ(ret, 0);								\
+											\
+	for (fp_reg = __reg_start; fp_reg < __reg_end; fp_reg++) {			\
+		for (offset = 1; offset < 4; offset++) {				\
+			for (val_i = 0; val_i < ARRAY_SIZE(test_val); val_i++) {	\
+				__type val, ref_val = test_val[val_i];			\
+											\
+				void *store_addr = (buf + offset);			\
+											\
+				test_ ## __inst(fp_reg, store_addr, offset, ref_val);	\
+				memcpy(&val, store_addr, sizeof(val));			\
+				EXPECT_TRUE(__type ## _equal(val, ref_val));		\
+			}								\
+		}									\
+	}										\
+}
+#define TEST_FPU_STORE(__type, __inst) \
+	__TEST_FPU_STORE(__type, __inst, 0, 32)
+#define TEST_FPU_STORE_COMPRESSED(__type, __inst) \
+	__TEST_FPU_STORE(__type, __inst, 8, 16)
+
+TEST_FPU_STORE(float, fsw)
+TEST_FPU_STORE(double, fsd)
+#ifdef __riscv_compressed
+TEST_FPU_STORE_COMPRESSED(double, c_fsd)
+TEST_FPU_STORE_COMPRESSED(double, c_fsdsp)
+#endif
+
+TEST_SIGNAL(gen_sigbus, SIGBUS)
+{
+	uint32_t val = 0xDEADBEEF;
+	uint8_t buf[16] __attribute__((aligned(16)));
+	int ret;
+
+	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_SIGBUS);
+	ASSERT_EQ(ret, 0);
+
+	asm volatile("sw %0, 1(%1)" : : "r"(val), "r"(buf) : "memory");
+}
+
+int main(int argc, char **argv)
+{
+	int ret, val;
+
+	ret = prctl(PR_GET_UNALIGN, &val);
+	if (ret == -1 && errno == EINVAL)
+		ksft_exit_skip("SKIP GET_UNALIGN_CTL not supported\n");
+
+	exit(test_harness_run(argc, argv));
+}
-- 
2.43.0



Return-Path: <linux-kernel+bounces-820558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3E5B7CF28
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFCE1C0276D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572435691E;
	Wed, 17 Sep 2025 11:27:30 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C062932D5C2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108449; cv=none; b=RFdFOU/80pRENI4U2ri88iCzrE/eFguvmBCi1oWOgOutIUNhcHOrIgNeLwf2bG4bse59siuAz5py+2Du2XG54EyG8mK+DUQud2ffrRhatbTUcWZ9B0hFmo+QKaKBA9VBMGvw4qieZRTxxHb5ZlmMe8aTQy+bJwnFIThDLGHf574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108449; c=relaxed/simple;
	bh=Yhh2ADC9r6JmtVYufkxeK0MbVvfLJkwJDU8kBVyEgIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtY0HT4GBRN+aEs6Pc647fLKIzcJEDkzZlTg9Utd9GPW9cVw4D4+2B2h3zqBDLJVTJ8JLN42rzYMKne0OG6HlCBCdkfgBNWKsX8DxwABuqp+PiUSlVbu/xyjHSOEaG0czViALQx4qKIChD2ZO9M8H5wBnRkBYK0qIjc5b30bLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx_tIbm8poHlkLAA--.24320S3;
	Wed, 17 Sep 2025 19:27:23 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxQ+QVm8por2abAA--.39884S4;
	Wed, 17 Sep 2025 19:27:20 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] LoongArch: Fix unreachable instruction warnings about head.S
Date: Wed, 17 Sep 2025 19:27:15 +0800
Message-ID: <20250917112716.24415-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250917112716.24415-1-yangtiezhu@loongson.cn>
References: <20250917112716.24415-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxQ+QVm8por2abAA--.39884S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JFWUXrykZry8Kr17uw17Arc_yoW7AFWrpF
	47C3yDArZ8uF1qvw4UGa1a93yavan8Xr4qqF1UGa4rA3yqv3Z2q3Wvyr17XFyqgw4j9F4r
	Wr4UKrWqka4jy3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxU4AhLUUUUU

When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
following objtool warnings:

  vmlinux.o: warning: objtool: .head.text+0x0: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x18: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x38: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x3c: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x40: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x44: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x54: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x58: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x6c: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x84: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x94: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x9c: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0xc4: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0xf8: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0xfc: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x104: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x10c: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x11c: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x120: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x124: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x144: unreachable instruction
  vmlinux.o: warning: objtool: kernel_entry+0x0: unreachable instruction
  vmlinux.o: warning: objtool: smpboot_entry+0x0: unreachable instruction

All of the above instructions are in arch/loongarch/kernel/head.S,
and there is "OBJECT_FILES_NON_STANDARD_head.o := y" in Makefile
to skip objtool checking for head.o, but OBJECT_FILES_NON_STANDARD
does not work for link time validation of vmlinux.o according to
tools/objtool/Documentation/objtool.txt.

After many discussions, it is not proper to ignore .head.text section
in objtool or put them from text section to data section, so just give
UNWIND_HINT_UNDEFINED to fix the warnings in the image header and also
give UNWIND_HINT_END_OF_STACK to fix the warnings in the entry points.

By the way, ASM_BUG() can be removed due to unnecessary, otherwise there
are following warnings:

  kernel_entry+0xf4: start_kernel() missing __noreturn
  in .c/.h or NORETURN() in noreturns.h

  smpboot_entry+0x68: start_secondary() missing __noreturn
  in .c/.h or NORETURN() in noreturns.h

This is because the previous instructions of kernel_entry+0xf4 and
smpboot_entry+0x68 are the 'bl' instructions, start_kernel() and
start_secondary() are the respective call destination symbols which
are noreturn functions, then the 'bl' instructions are already marked
as dead end in annotate_call_site().

For now, it is time to remove "OBJECT_FILES_NON_STANDARD_head.o := y"
in arch/loongarch/kernel/Makefile.

Link: https://lore.kernel.org/lkml/20250814083651.GR4067720@noisy.programming.kicks-ass.net/
Link: https://lore.kernel.org/lkml/CAAhV-H6A_swQmqpWHp6ryAEvc96CAMOMd2ZGyJEVNMsJfLkz6w@mail.gmail.com/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/Makefile | 2 --
 arch/loongarch/kernel/head.S   | 7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 6f5a4574a911..4302c5b0a201 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -3,8 +3,6 @@
 # Makefile for the Linux/LoongArch kernel.
 #
 
-OBJECT_FILES_NON_STANDARD_head.o := y
-
 always-$(KBUILD_BUILTIN)	:= vmlinux.lds
 
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index e3865e92a917..c62dab32a06b 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -20,6 +20,7 @@
 	__HEAD
 
 _head:
+	UNWIND_HINT_UNDEFINED
 	.word	IMAGE_DOS_SIGNATURE	/* "MZ", MS-DOS header */
 	.org	0x8
 	.dword	_kernel_entry		/* Kernel entry point (physical address) */
@@ -42,6 +43,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
 	.align 12
 
 SYM_CODE_START(kernel_entry)			# kernel entry point
+	UNWIND_HINT_END_OF_STACK
 
 	/* Config direct window and set PG */
 	SETUP_DMWINS	t0
@@ -109,8 +111,6 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 #endif
 
 	bl		start_kernel
-	ASM_BUG()
-
 SYM_CODE_END(kernel_entry)
 
 #ifdef CONFIG_SMP
@@ -120,6 +120,7 @@ SYM_CODE_END(kernel_entry)
  * function after setting up the stack and tp registers.
  */
 SYM_CODE_START(smpboot_entry)
+	UNWIND_HINT_END_OF_STACK
 
 	SETUP_DMWINS	t0
 	JUMP_VIRT_ADDR	t0, t1
@@ -142,8 +143,6 @@ SYM_CODE_START(smpboot_entry)
 	ld.d		tp, t0, CPU_BOOT_TINFO
 
 	bl		start_secondary
-	ASM_BUG()
-
 SYM_CODE_END(smpboot_entry)
 
 #endif /* CONFIG_SMP */
-- 
2.42.0



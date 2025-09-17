Return-Path: <linux-kernel+bounces-819818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E90B7EAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE47F4E21A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299AF221DB5;
	Wed, 17 Sep 2025 01:10:26 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732D212B2F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071425; cv=none; b=TipadwULITbkWpgmSu2Jp2kxAvSC8zcXn08uzn3QenfH8xeDwJ5b6a8NuhP1sR2CfqlPJxI4yaX1IgSnzl7xBfZoK/hJecitfzh61iq3YwxgC5goXeZcin3gMru5Zc3HcNxvtzALHK6XNuHqI4aU4G5L+WVkzH8KJeHJyGesWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071425; c=relaxed/simple;
	bh=BAIPU8rlA97jKSZnfb7y8zKgt9TXDAgT/6jsp+7GqfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOWbGz2kWG1wxR+7Jt/rCyt75vyR1z29PUiTxtI0Nz9QUg7TKhlYrSQGYsBznzpnTRF8T+v7opk7/faSVBwGg017DZWaAWsMSIC/lippuXRdIWCHZwbFnfCi0FYKTT8YkXelVsgFzoIxpdSgl0ZIr49QbLHZ/Q2N6glsSDci+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxvr99CspoLS4LAA--.22821S3;
	Wed, 17 Sep 2025 09:10:21 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxE+RwCsposWOaAA--.35728S5;
	Wed, 17 Sep 2025 09:10:20 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] objtool/LoongArch: Fix unreachable instruction warnings about entry points
Date: Wed, 17 Sep 2025 09:10:06 +0800
Message-ID: <20250917011007.4540-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250917011007.4540-1-yangtiezhu@loongson.cn>
References: <20250917011007.4540-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+RwCsposWOaAA--.35728S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF45KF1rKw4kAw4rKr18tFc_yoW5Zr1fpF
	43Cr4DXrZ5CrnFyw1UJayrurWjv3ZrWw43W3WDGryrA39Fq3ZFqw40vrnrXFyqga1UKay0
	gF4rtF9F9F4UA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8XyCJUUUUU==

When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
following objtool warnings:

  vmlinux.o: warning: objtool: kernel_entry+0x0: unreachable instruction
  vmlinux.o: warning: objtool: smpboot_entry+0x0: unreachable instruction

kernel_entry() and smpboot_entry() are in arch/loongarch/kernel/head.S,
there is "OBJECT_FILES_NON_STANDARD_head.o := y" to skip objtool checking
for head.o, but the STACK_FRAME_NON_STANDARD macro does not work for link
time validation of vmlinux.o according to objtool documentation, just give
a proper unwind hint to fix the warnings.

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
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/Makefile | 2 --
 arch/loongarch/kernel/head.S   | 6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

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
index 6ce999586757..c62dab32a06b 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -43,6 +43,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
 	.align 12
 
 SYM_CODE_START(kernel_entry)			# kernel entry point
+	UNWIND_HINT_END_OF_STACK
 
 	/* Config direct window and set PG */
 	SETUP_DMWINS	t0
@@ -110,8 +111,6 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 #endif
 
 	bl		start_kernel
-	ASM_BUG()
-
 SYM_CODE_END(kernel_entry)
 
 #ifdef CONFIG_SMP
@@ -121,6 +120,7 @@ SYM_CODE_END(kernel_entry)
  * function after setting up the stack and tp registers.
  */
 SYM_CODE_START(smpboot_entry)
+	UNWIND_HINT_END_OF_STACK
 
 	SETUP_DMWINS	t0
 	JUMP_VIRT_ADDR	t0, t1
@@ -143,8 +143,6 @@ SYM_CODE_START(smpboot_entry)
 	ld.d		tp, t0, CPU_BOOT_TINFO
 
 	bl		start_secondary
-	ASM_BUG()
-
 SYM_CODE_END(smpboot_entry)
 
 #endif /* CONFIG_SMP */
-- 
2.42.0



Return-Path: <linux-kernel+bounces-615566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B300A97F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 08:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB08E189A0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 06:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6E8266F00;
	Wed, 23 Apr 2025 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xP4ATp71"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629B1F470E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389969; cv=none; b=O2m6upXDuaVNQUNR+aCQsQXtFoqy1sfVOCTrw3+/oMdDn4uwYWj0DeKVPDDODDtjAxTWXY0z+3sAbsmCGjwoSNiaVEuyWtKzROV4pDgzkxnlqVKlPsqXbBZQTO4e/tNriO4aoo9blO1MTiw/9IEkPZEYB8dPsg+Wav1eU/Yj3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389969; c=relaxed/simple;
	bh=DxrSWnpFckiMld3vwlw418/zVtmUdHv6wc55mEnh0wE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I90WYdMNcBp9JcwUWesZzXUWcIlC9hijMEIc2ibm0R4YgCL6z7T2PTLXh9Pd3D60bhCGSzWzeCyIRwUl1v2vi6t0TeLo7L4nm8fEFmzUqZCCv0dLpoAxEjMZuKnHivl/KyLiaruaJkgJP8ZvVDksuEhSzhxUqpqtvX/U+XHH5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xP4ATp71; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745389963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mAos8/aQyj6DBdVLSFmwtAA6vwhiiZEJ9ulPWYZBsOI=;
	b=xP4ATp71YUw+Mp8qNQg3kR+bZhcxLoBrXFKHs0hgLDS39Y1n6YSMUkOYK3phpcmCI3Im4Y
	U1PEunLVcyFXOcKoA2O5O5MfZbt3IJFmbdrT1vbh4YZ/5iSrmZ5YDkHOo0tLwCZX9LrNMh
	ZYoUVAAgCLZvzGrdE4+PAMqew4XV5DY=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] LoongArch: Enable HAVE_ARCH_STACKLEAK
Date: Wed, 23 Apr 2025 14:31:47 +0800
Message-Id: <20250423063147.69178-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Add support for the stackleak feature. It initialize the stack with the
poison value before returning from system calls which improves the kernel
security.

At the same time, disables the plugin in EFI stub code because EFI stub
is out of scope for the protection.

Tested on 3A5000 (enable CONFIG_GCC_PLUGIN_STACKLEAK and CONFIG_LKDTM):
 # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
 # dmesg
   lkdtm: Performing direct entry STACKLEAK_ERASING
   lkdtm: stackleak stack usage:
      high offset: 320 bytes
      current:     448 bytes
      lowest:      1264 bytes
      tracked:     1264 bytes
      untracked:   208 bytes
      poisoned:    14528 bytes
      low offset:  64 bytes
   lkdtm: OK: the rest of the thread stack is properly erased

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/Kconfig                    | 1 +
 arch/loongarch/include/asm/entry-common.h | 8 +-------
 arch/loongarch/include/asm/stacktrace.h   | 5 +++++
 arch/loongarch/kernel/entry.S             | 9 +++++++++
 drivers/firmware/efi/libstub/Makefile     | 2 +-
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 067c0b994648..3a6bfcab2dde 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -122,6 +122,7 @@ config LOONGARCH
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
diff --git a/arch/loongarch/include/asm/entry-common.h b/arch/loongarch/include/asm/entry-common.h
index 0fe2a098ded9..a7a6af490f86 100644
--- a/arch/loongarch/include/asm/entry-common.h
+++ b/arch/loongarch/include/asm/entry-common.h
@@ -2,12 +2,6 @@
 #ifndef ARCH_LOONGARCH_ENTRY_COMMON_H
 #define ARCH_LOONGARCH_ENTRY_COMMON_H
 
-#include <linux/sched.h>
-#include <linux/processor.h>
-
-static inline bool on_thread_stack(void)
-{
-	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
-}
+#include <asm/stacktrace.h>
 
 #endif
diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
index fc8b64773794..3861beb96002 100644
--- a/arch/loongarch/include/asm/stacktrace.h
+++ b/arch/loongarch/include/asm/stacktrace.h
@@ -31,6 +31,11 @@ bool in_irq_stack(unsigned long stack, struct stack_info *info);
 bool in_task_stack(unsigned long stack, struct task_struct *task, struct stack_info *info);
 int get_stack_info(unsigned long stack, struct task_struct *task, struct stack_info *info);
 
+static inline bool on_thread_stack(void)
+{
+	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
+}
+
 #define STR_LONG_L    __stringify(LONG_L)
 #define STR_LONG_S    __stringify(LONG_S)
 #define STR_LONGSIZE  __stringify(LONGSIZE)
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index 48e7e34e355e..27dcb3a66b2b 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -16,6 +16,12 @@
 #include <asm/thread_info.h>
 #include <asm/unwind_hints.h>
 
+	.macro STACKLEAK_ERASE
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl		stackleak_erase_on_task_stack
+#endif
+	.endm
+
 	.text
 	.cfi_sections	.debug_frame
 	.align	5
@@ -73,6 +79,7 @@ SYM_CODE_START(handle_syscall)
 	move		a0, sp
 	bl		do_syscall
 
+	STACKLEAK_ERASE
 	RESTORE_ALL_AND_RET
 SYM_CODE_END(handle_syscall)
 _ASM_NOKPROBE(handle_syscall)
@@ -82,6 +89,7 @@ SYM_CODE_START(ret_from_fork)
 	bl		schedule_tail		# a0 = struct task_struct *prev
 	move		a0, sp
 	bl 		syscall_exit_to_user_mode
+	STACKLEAK_ERASE
 	RESTORE_STATIC
 	RESTORE_SOME
 	RESTORE_SP_AND_RET
@@ -94,6 +102,7 @@ SYM_CODE_START(ret_from_kernel_thread)
 	jirl		ra, s0, 0
 	move		a0, sp
 	bl		syscall_exit_to_user_mode
+	STACKLEAK_ERASE
 	RESTORE_STATIC
 	RESTORE_SOME
 	RESTORE_SP_AND_RET
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d23a1b9fed75..b97981d63d2f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -31,7 +31,7 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   $(DISABLE_STACKLEAK_PLUGIN)
 cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax \
 				   $(DISABLE_STACKLEAK_PLUGIN)
-cflags-$(CONFIG_LOONGARCH)	+= -fpie
+cflags-$(CONFIG_LOONGARCH)	+= -fpie $(DISABLE_STACKLEAK_PLUGIN)
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
 
-- 
2.38.1



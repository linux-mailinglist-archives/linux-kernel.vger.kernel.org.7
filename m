Return-Path: <linux-kernel+bounces-891382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C435C4291B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1A214E99B1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C5C2E5B2A;
	Sat,  8 Nov 2025 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmessiOE"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C372E3AEA
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589170; cv=none; b=ORnqlJzGll/ireq1Am/i0xR701BfOrT3jVTscJY1H9jMV7o6aCzWFHrvnrCG8oXu+IgS+EQRK6he7N9znrTUjQOblB92ySEcYHXLwKRdLnOtFlRg2+O5f9xQ2Esl+uhaks9XCJWS+WTA26OoTbF7CDhdByHWSxwrVW7fSJhhYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589170; c=relaxed/simple;
	bh=ohZr8TN+3EzzLa/zdEUa/3GcfCV2x/KsAaalXoHEw/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BN/2GFVoxG7HMgC7VEBwCgaXq7xKtQbWYGowKjJo7FnhVCrQ5kaeL4u3H5KxrXRFih39Nk93l4rWVPcMmwgz7WCptv6sFvi5JTnrv1yra7JGyhQZd7P+/+8Y4S8wQ9TPQgFxKyDNJwA+jUxLC76NyPjAvfcyr9yLFLEAtkVU3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmessiOE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297d4a56f97so8516945ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589166; x=1763193966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo64Q14KD7RJjz3s47AhqXDA7DbhSnhy3sX7mHpz33g=;
        b=WmessiOEmshltWF7TU4b2eIVvyvkZoKDT350Q2VzycdeGiaWDQW8urPCZgXZYA4nlC
         P365C5mTrOwC9JfuXWfpM/Vf3dgAY84RYoESyNirHdmziNwwKSt6SEpbYxWdJj182mt8
         BE3kthX6SeJeUnw3Tk+PIL+liKIYZW3Q+vfGuKplMzGVVztlLN4tuajqXLZpRTsX5qJe
         5d/AZ6GyMk5w1zOPs3EnC5Mdt65IKqGYSaVNSK0xp81RdoiCqYI9IpZEymsKSOU/mQ9n
         B9ss3DkOxfy2xOIu94h3+xFYpuQn78PcDO8b+sw3hayr6Bcgn2Z6IxdB/IhZSd8chce+
         MDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589166; x=1763193966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fo64Q14KD7RJjz3s47AhqXDA7DbhSnhy3sX7mHpz33g=;
        b=cKOkQ+rnCVMnZ2LaQnO62jl5b8k3qlNBoGlHyc37As7Rtt/n2cTKiwUrG0TQ08EpMT
         MA2q8tKIg4ZnZ1qj3JkEKknIOYR8L7538Mc8xxvT371NeBxeRWkLrJo3dNwPeltjI9bD
         e55tgjsfcZshIk7fL6ttC/YP2Ll1KvlSlZlo/nS49NzpeEoCeRGuSZZAmIIhi0C8qQCO
         kIhp+kh+9wO+aBqRviHj7UvzGCVEU3dgTgvKTv7o80YGm03eILWXuhffHO7AlEp3Lr2D
         pyKNoiemMgzv47e5zfeXVM34NW4xFLF9wnYzRgO/BvMeLADAAYzbv1gFX3dD+Bpf8GZb
         gyDw==
X-Forwarded-Encrypted: i=1; AJvYcCUiaSEqrbSXwkMXTLrNVtsSg31ZJGCXWRGmipiaxooXhPwFqNPDxDuuhE+Eqd/UNH6I4sKCSiD5g271s04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRft9NgjcyIA2J/h+eOMxRK07iPlhlS0iUpAi0tkF4JoSdYHr
	yjKrsdodrZpjqzZOD9jux8L9Shcqhlhes+5Duh+1A1qyOQPfN+ebjhq4
X-Gm-Gg: ASbGnctEgP3O4owZ3VVzxBCm/hosL3oPYa/xokuykZFi0bF+wonYCH9cm6A4PLH+B77
	/njDvE1G8FMKA6mzMthhmIi+iplxqw/Wpg8nVMD9GcHkNfhGcEMZEfml+1ChqgT3aI/uaB5ij7F
	ptzGUtlp5UQHcd4NpMPjKnCTjej+Ibk4D3sS3bN6ZUwBrSHAV9cXh1I+LMCfRbDEVfHh3/c5wZs
	aQHmNo3H6ONiPzE9pcr0LWyfz9BU5WedWcN9nIaF4Uy/hPratrbzEvNVGOpRIyguGXYIMIhNdPn
	HCnf9NSkqfISAeB6pdYUC5+5qdIJorbqGw5gS7M9LDQQQKNdL9CEK6EnXX8OPLJ8uifJnrMS7NO
	gwuUjASlCvae5We4hSgq775PRw//4AEyR7rioeAydIKjEJ/yyQftL1msmroL4yoGT/yLuwQHDTx
	9B3ck11e2CsXx8FIl6kPDcIwM3mpbDFO/8VQT7dUtLVJn3rg==
X-Google-Smtp-Source: AGHT+IEuRYykMljnZYhL+TbH5FurVSKavUEug22jUuvZ3baInb7oeHFpVuOBsBNWV5IN8PKWIaLSRw==
X-Received: by 2002:a17:903:1b2e:b0:26c:e270:6dad with SMTP id d9443c01a7336-297e57151ecmr21195745ad.60.1762589166317;
        Sat, 08 Nov 2025 00:06:06 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cc6595sm81710455ad.98.2025.11.08.00.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:05 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B755E11388CD; Sat,  8 Nov 2025 17:06:03 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 04/13] x86/um: nommu: syscall handling
Date: Sat,  8 Nov 2025 17:05:39 +0900
Message-ID: <b23f1464f32b0701b298b0f43bc0aa0e5de1e6f5.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces an entry point of syscall interface for !MMU
mode. It uses an entry function, __kernel_vsyscall, a kernel-wide global
symbol accessible from any locations.

Although it isn't in the scope of this commit, it can be also exposed
via vdso image which is directly accessible from userspace. A standard
library (i.e., libc) can utilize this entry point to implement syscall
wrapper; we can also use this by hooking syscall for unmodified userspace
applications/libraries, which will be implemented in the subsequent
commit.

This only supports 64-bit mode of x86 architecture.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/x86/um/Makefile              |   4 ++
 arch/x86/um/asm/syscall.h         |   6 ++
 arch/x86/um/nommu/Makefile        |   8 +++
 arch/x86/um/nommu/do_syscall_64.c |  32 +++++++++
 arch/x86/um/nommu/entry_64.S      | 112 ++++++++++++++++++++++++++++++
 arch/x86/um/nommu/syscalls.h      |  16 +++++
 6 files changed, 178 insertions(+)
 create mode 100644 arch/x86/um/nommu/Makefile
 create mode 100644 arch/x86/um/nommu/do_syscall_64.c
 create mode 100644 arch/x86/um/nommu/entry_64.S
 create mode 100644 arch/x86/um/nommu/syscalls.h

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index f9ea75bf43ac..39693807755a 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -31,6 +31,10 @@ obj-y += mem_64.o syscalls_64.o vdso/
 subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o \
 	../lib/memmove_64.o ../lib/memset_64.o
 
+ifneq ($(CONFIG_MMU),y)
+obj-y += nommu/
+endif
+
 endif
 
 subarch-$(CONFIG_MODULES) += ../kernel/module.o
diff --git a/arch/x86/um/asm/syscall.h b/arch/x86/um/asm/syscall.h
index d6208d0fad51..bb4f6f011667 100644
--- a/arch/x86/um/asm/syscall.h
+++ b/arch/x86/um/asm/syscall.h
@@ -20,4 +20,10 @@ static inline int syscall_get_arch(struct task_struct *task)
 #endif
 }
 
+#ifndef CONFIG_MMU
+extern void do_syscall_64(struct pt_regs *regs);
+extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
+			      int64_t a4, int64_t a5, int64_t a6);
+#endif
+
 #endif /* __UM_ASM_SYSCALL_H */
diff --git a/arch/x86/um/nommu/Makefile b/arch/x86/um/nommu/Makefile
new file mode 100644
index 000000000000..d72c63afffa5
--- /dev/null
+++ b/arch/x86/um/nommu/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+ifeq ($(CONFIG_X86_32),y)
+	BITS := 32
+else
+	BITS := 64
+endif
+
+obj-y = do_syscall_$(BITS).o entry_$(BITS).o
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
new file mode 100644
index 000000000000..292d7c578622
--- /dev/null
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <kern_util.h>
+#include <asm/syscall.h>
+#include <os.h>
+
+__visible void do_syscall_64(struct pt_regs *regs)
+{
+	int syscall;
+
+	syscall = PT_SYSCALL_NR(regs->regs.gp);
+	UPT_SYSCALL_NR(&regs->regs) = syscall;
+
+	if (likely(syscall < NR_syscalls)) {
+		unsigned long ret;
+
+		ret = (*sys_call_table[syscall])(UPT_SYSCALL_ARG1(&regs->regs),
+						 UPT_SYSCALL_ARG2(&regs->regs),
+						 UPT_SYSCALL_ARG3(&regs->regs),
+						 UPT_SYSCALL_ARG4(&regs->regs),
+						 UPT_SYSCALL_ARG5(&regs->regs),
+						 UPT_SYSCALL_ARG6(&regs->regs));
+		PT_REGS_SET_SYSCALL_RETURN(regs, ret);
+	}
+
+	PT_REGS_SYSCALL_RET(regs) = regs->regs.gp[HOST_AX];
+
+	/* handle tasks and signals at the end */
+	interrupt_end();
+}
diff --git a/arch/x86/um/nommu/entry_64.S b/arch/x86/um/nommu/entry_64.S
new file mode 100644
index 000000000000..485c578aae64
--- /dev/null
+++ b/arch/x86/um/nommu/entry_64.S
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/errno.h>
+
+#include <linux/linkage.h>
+#include <asm/percpu.h>
+#include <asm/desc.h>
+
+#include "../entry/calling.h"
+
+#ifdef CONFIG_SMP
+#error need to stash these variables somewhere else
+#endif
+
+#define UM_GLOBAL_VAR(x) .data; .align 8; .globl x; x:; .long 0
+
+UM_GLOBAL_VAR(current_top_of_stack)
+UM_GLOBAL_VAR(current_ptregs)
+
+.code64
+.section .entry.text, "ax"
+
+.align 8
+#undef ENTRY
+#define ENTRY(x) .text; .globl x; .type x,%function; x:
+#undef END
+#define END(x)   .size x, . - x
+
+/*
+ * %rcx has the return address (we set it before entering __kernel_vsyscall).
+ *
+ * Registers on entry:
+ * rax  system call number
+ * rcx  return address
+ * rdi  arg0
+ * rsi  arg1
+ * rdx  arg2
+ * r10  arg3
+ * r8   arg4
+ * r9   arg5
+ *
+ * (note: we are allowed to mess with r11: r11 is callee-clobbered
+ * register in C ABI)
+ */
+ENTRY(__kernel_vsyscall)
+
+	movq	%rsp, %r11
+
+	/* Point rsp to the top of the ptregs array, so we can
+           just fill it with a bunch of push'es. */
+	movq	current_ptregs, %rsp
+
+	/* 8 bytes * 20 registers (plus 8 for the push) */
+	addq	$168, %rsp
+
+	/* Construct struct pt_regs on stack */
+	pushq	$0		/* pt_regs->ss (index 20) */
+	pushq   %r11		/* pt_regs->sp */
+	pushfq			/* pt_regs->flags */
+	pushq	$0		/* pt_regs->cs */
+	pushq	%rcx		/* pt_regs->ip */
+	pushq	%rax		/* pt_regs->orig_ax */
+
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
+
+	mov %rsp, %rdi
+
+	/*
+	 * Switch to current top of stack, so "current->" points
+	 * to the right task.
+	 */
+	movq	current_top_of_stack, %rsp
+
+	call	do_syscall_64
+
+	jmp	userspace
+
+END(__kernel_vsyscall)
+
+/*
+ * common userspace returning routine
+ *
+ * all procedures like syscalls, signal handlers, umh processes, will gate
+ * this routine to properly configure registers/stacks.
+ *
+ * void userspace(struct uml_pt_regs *regs)
+ */
+ENTRY(userspace)
+
+	/* clear direction flag to meet ABI */
+	cld
+	/* align the stack for x86_64 ABI */
+	and     $-0x10, %rsp
+	/* Handle any immediate reschedules or signals */
+	call	interrupt_end
+
+	movq	current_ptregs, %rsp
+
+	POP_REGS
+
+	addq	$8, %rsp	/* skip orig_ax */
+	popq	%rcx		/* pt_regs->ip */
+	addq	$8, %rsp	/* skip cs */
+	addq	$8, %rsp	/* skip flags */
+	popq	%rsp
+
+	/*
+	* not return w/ ret but w/ jmp as the stack is already popped before
+	* entering __kernel_vsyscall
+	*/
+	jmp	*%rcx
+
+END(userspace)
diff --git a/arch/x86/um/nommu/syscalls.h b/arch/x86/um/nommu/syscalls.h
new file mode 100644
index 000000000000..a2433756b1fc
--- /dev/null
+++ b/arch/x86/um/nommu/syscalls.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_SYSCALLS_H
+#define __UM_NOMMU_SYSCALLS_H
+
+
+#define task_top_of_stack(task) \
+({									\
+	unsigned long __ptr = (unsigned long)task->stack;	\
+	__ptr += THREAD_SIZE;			\
+	__ptr;					\
+})
+
+extern long current_top_of_stack;
+extern long current_ptregs;
+
+#endif
-- 
2.43.0



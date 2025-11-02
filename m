Return-Path: <linux-kernel+bounces-881710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 074EDC28CB8
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF513ACF0F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2102264CC;
	Sun,  2 Nov 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T38cZKoa"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792B26AAAB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762076997; cv=none; b=Bc6kezb9nLVHU5xeguz2MZzC6k/hYEfFW9oZz+8zyKGeo3PC2jFVxjNuaf9X637AU+xDO/hPJVX11ap/uUjYjAGFIgnt+Xo5bDoLTNAgiB6MM9YuPLcebG4W2Qe4GETqtIIZnlAmIVtJ0rUhs1AsP5TyPF86IBSXYQo1VWlhorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762076997; c=relaxed/simple;
	bh=Z6qZSB5ccwxVgYVj98AksF/DlcdpqcgoKyj9hpY/Brg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHsVq+CHujVbIbvH0ch2NDb2Zzz4as+eHYZgEIJS0LgZ93nrcUoWMUqqGYr8RRUzdvg6xgqo9y/ScUZ7qVQd3EOuYFvaUDJr88C8ar6ipPpJBZceCUV/TEErx7NB4zTlFivT7mCE/uzrYsyHNJl8cFikrnYn/MrSdcOup+N64GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T38cZKoa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-28a5b8b12a1so36785905ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076995; x=1762681795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNruZWOB1A9W2xPWfDeeJw/PtthshopimV+lzxEm4to=;
        b=T38cZKoaemDfKrpH0+ta8blcm0wfz0MwYgy//cVHMw7zLWylvMBY7WxOj8XkIKUlL7
         MmDqBbh2ncRe23s5NviKIK4S73nLiWfcEXVRk0fium8ryTboCDeNfTz1R1bu3CQmE5a7
         MC3BLp6tEBC4ihNtruEUR4C+wbUduaIJUAEovvHlJ5ZtGOS1XFpsHHK9IskskR5B4PKp
         l8VG+jKZ+01LG/EDERupUdOjaNZ1LnarfxBFJk6a4qsF9vHE6LMNTGIUTjgcDq+EB0qo
         Pcn/O0HsZV76cuAKRjzk4g7UPcgKCM36PV1B6RnsFr1wsnHc+eJ2fRDEXwnhXNj8F2Lr
         inqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076995; x=1762681795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNruZWOB1A9W2xPWfDeeJw/PtthshopimV+lzxEm4to=;
        b=kKa5axVuNNKBidV/5NHtrEba7aa0E656OO/9wKJ+6hSDU5+Gv1MzGn7Yp/nCu8GEWq
         eLNK4Rg2BH916VsJWtg7ZjDDogavE2Ecu1klktjoSWBKhR4xBAKvf2QYY1b7xgK+Mn0R
         G6kl1MJfVG4ypIp9yTx/xoOQLJVsCBAoyorxowZxnYJsNfZ2FnbeGQ47pk0tB7JtNwQU
         1KoglOG4sF9zyikRG29Hb1FvtqsRL5l56aJ2cw5KrqWUDM7tg6yxhmGT+Be0RtOm74SK
         lbrNVEORly6vttmyOqFsJZ3bY6cjDNmPCG9hxRcL/RUDLG1vM/M6QbwKCkHFtKj7mTjL
         lksQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjBdvR5I9S33upwdKCRXBt5d4dmRsDC68mFwrviZiashK5NZ6hjF9vPK+tsfy5dwNZn3Y5QJhfN/VCvMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwuvmvdE1yjaNnzpGujPSZsKwOvAmi0ZjIuJ3FEKbCs7h5PCVi
	Xd1CFV6duR8TOkFwB5bK4eSzeMJl0j95nUJPIsPz4VevfOp+7DqmCmkA
X-Gm-Gg: ASbGncsUw2nRoQ4ZcKxyN/G2/tv5w2Nphp+RNvNoKrVLCBI1OY2com7eHy4fhcOAfXo
	rDWkSZZ4etnrZ32sP2vCa9MAK+PvnOGcwUojo6oRMAEjerZJLkGbAbG1ViBM5ZEi2u318CDjYDi
	xm6Q4Ew2IakdrojdbbiGWIcED0x3z7LLNBZX1FO+DRjac+St3TRn/RsbOMtJ5ThH+UUE80eooPJ
	H65EPtTKHuh6Np/2+I8/fRgsT4Xf0wIokRA6lKhF+mpD8Gw2mH7qBc8BCuksr3a0SRY2Q3yB1Xs
	ma00WFX7gVRFGt4WBBrupht43Imwpjz2bOMYDGUjVqpe4OBcU+tnVitdogjo1IYX5sSMYQzHo6t
	/lmYtHrmhHW2ySPgKZkU+jdoLODZaRNuQPrhWY9vTOJgWt1UMoBcnVcQ8c5f7Dghp7o0A5M8v7R
	gdg9yPbqDmidoFO7M8cJrKaDqcN+tuY20+QIRE2mc3cC/HAakK35xwQHML
X-Google-Smtp-Source: AGHT+IFkoW2S8Nm2549TybzP/Qjnm/HVrzvPiD3jHPwRPqbA7kzapN9ZpSAsI/ISg985qkSCINlgQQ==
X-Received: by 2002:a17:902:f68f:b0:261:6d61:f28d with SMTP id d9443c01a7336-2951a4aa201mr116295275ad.50.1762076994796;
        Sun, 02 Nov 2025 01:49:54 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29564fb531asm38273845ad.14.2025.11.02.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:54 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0686F1123805; Sun,  2 Nov 2025 18:49:48 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 04/13] x86/um: nommu: syscall handling
Date: Sun,  2 Nov 2025 18:49:29 +0900
Message-ID: <c4609c653db31ec3a6595bb03f34d2331cf9d543.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
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
index b42c31cd2390..227af2a987e2 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -32,6 +32,10 @@ obj-y += syscalls_64.o vdso/
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



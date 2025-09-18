Return-Path: <linux-kernel+bounces-822071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55973B82F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73501C24338
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FA628B4E1;
	Thu, 18 Sep 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BILWPuBS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041A27E1DC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172594; cv=none; b=q/pdeIVxEtGnxO64t+deFTLz8AHXsiypqb2KihB/v8VRcagJO6a8yRog40Uz0FR+dp494A3r/oWzNh9nw7WbOBHWt5hGZFBVVZgAmhC5MbqMrftNaVDJzAmxRQpXCrjK6voXbqQu72UpRTbecXBiG0N2gkI/PsMkOd6ky6DOuzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172594; c=relaxed/simple;
	bh=Z6qZSB5ccwxVgYVj98AksF/DlcdpqcgoKyj9hpY/Brg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXIHL7lBmgCBhwG7sg1cz3NCOmqvQNcE8JcKoiLDCAn+PrGhNTe27uckg3d4KZzMc+bFOOgok6Lm3JMikh2fB3+7q8tkGT0KdJkXxMtFkWpfhRirF9XgPQdASSCUaDvEzGy5DqRrjB6d7lGMjjE52QEhjkGOYBoPUAvLwlvQlaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BILWPuBS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2698e4795ebso2356755ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172591; x=1758777391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNruZWOB1A9W2xPWfDeeJw/PtthshopimV+lzxEm4to=;
        b=BILWPuBS861KpUGocDcp19/hWLMUgF6tITpf8G7zG0E/DhewSqa706J9yyH0s+dIsT
         ADoFEvLtmD2SEXxPGwww7awup+5U1H8IoP8t35nf2duMpOrIv8/n+Y8JY7US9kW974AA
         3PnLtCBZzqXFGPnM63q2DDtVn+GEvaldQgsZ+18w7RKb9CcaQR4oue8FJG7iuBiGv9or
         14U/p6FTxbmBHP8lQNRjUqX4pYHcsBQj0RkOb8r6HvesUW93GFSdJ+2VwViPJJggzDUa
         3208UGQtQ/VkUYxdHWxu2VbWbHGxWX2RQBlQHc8QeN89sHUP6eXvV+c2hmIbZqICUlrz
         S71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172591; x=1758777391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNruZWOB1A9W2xPWfDeeJw/PtthshopimV+lzxEm4to=;
        b=GrodupRLvw2YzXHN3cE1XwVIMhkNf8CCFM5lryizzIMEewWVuWK+9gVRYbwf0F2jJ+
         nFi9oxzpAlC+8VjCLfF/0EnW7Cm4xMbOuwEYIH1hUvIyEWCdV/JpYdvdC2LEdkpLOHP3
         9ZAOtxo525keVMQHBz1QjDnVupseVN/qVFgJDJZMd04BGH7nkHIkReBGIXPP5fiZ2j5r
         xd+iwRQ42Pj8VugLnX5t5HCldUHVuWEezTkaxOHQlikanEe/gPUd5JPMkeyOtsIF9dr4
         lH+bvX8i0Xk2E5O3X6No1KBheJEU2mfpx0xtcsB4xsS9uw2Wnvj1mipG02aDPD8mzlHT
         kdtg==
X-Forwarded-Encrypted: i=1; AJvYcCUmE8JaVr2o7wIK5kCBYnIt4MRYqibPjp2BP7f0XQcELQ3zI8yMSxqPt7HiEIXYuWglUUnL/vL9pxXyAfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKkPsNtxXKwVRLlRUn49UZ1miJAJgGd2U25Z5qYwtB252/CVF
	h/tROTWubEQ0GbujnoWZXhSfdScSpQaHXtYF+DkvTEr/aCcLT9y1siDz
X-Gm-Gg: ASbGncsCueIzn+DUmCzDhV/rudFluPLcunm5VYqtlCznLKeiVv1lpa4yMduHUdraIRC
	HXmkVvcANGJtv1HjrjnrJcWZ8e36g3kFVqYJPwWLGUS8iYc6hIkerMPpsw1tcqTVKUw5V2NJUgA
	gD+UnvXBJB/9uqIFeRRMVH4FFs4mGlEBcllIaqb33+PU0Y4UkP0ERaBl9jFrCvVhlEmkoe89ilP
	/B/iM+HlYvNFWyDybnJTXn9DCRTuKUnYUz4A0XkTQan0p9QKz5U3GoS3DsFrgw3mmtOubwmRtH8
	ws8bOmy7gzsu0RtufaDs3vjsIk/kR88bTWIfrbE3fJE3hFmdKvrqg8rhulTi7U/Co862jHwFENa
	gjgb85q2TmnQIaC4eTA9Vlw7i5jGr9mvRF5ZgiTJG1AH2Xc+tXzD4e+F34mQayY9a3NMv2Z88Gt
	sbpzKOOzdvM3plqBSVEYrrYg==
X-Google-Smtp-Source: AGHT+IGDcPCTQRDQJloTH9BdqlAOj6e2/TUJJrtVUeXUVjBEic4MtyF8+jxmHyt7EO3Nq8kgKfGCdw==
X-Received: by 2002:a17:902:d504:b0:258:9d26:1860 with SMTP id d9443c01a7336-26813902e19mr67208525ad.40.1758172590685;
        Wed, 17 Sep 2025 22:16:30 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deeb1sm12286825ad.78.2025.09.17.22.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:30 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4EAD71061EE8; Thu, 18 Sep 2025 14:16:28 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 04/14] x86/um: nommu: syscall handling
Date: Thu, 18 Sep 2025 14:15:57 +0900
Message-ID: <99a54b96cee85275692ca01fe4a0ef0d83996f0f.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
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



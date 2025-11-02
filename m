Return-Path: <linux-kernel+bounces-881708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CB8C28CB2
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A4514E35BA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFA26B77D;
	Sun,  2 Nov 2025 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWylnObL"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43883247DE1
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762076995; cv=none; b=c4f2YMM4K6ZFZu/OBbOE1I6Yz60sj+zUun1X3NolWG7uJRaOVVQ+9+fFQAVZXmdowN3AfrwhDl5Zxpf7dHGiMSDNa4AcC1Uu6uIyQJH9fyrPvJZrAyvI3lhDBTCL6/GvW5DHaIu4U2Egb6K+EMeSE7QlIu+GGR6XpaJeDxWaKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762076995; c=relaxed/simple;
	bh=3h4KHxjf6Nj7gUR5Fq6oVdei/yT1yZ6RSKyCcwa/FeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o03nrJGQMDmzPnVMdWfb1kvKN/kMn+aP1AKUvd2QTErh9LHVRqXmzks9rAOJqdGSBAZU4wAOv2TQ5rBLkWdR9Z9k931Y2AossawgUqk/jnvKMb8uUElLWCqzcye99dR7w7IaLphaJ436keWjOLSWV4snQV/x++VVsDrFcBiPZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWylnObL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b996c8db896so527842a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076992; x=1762681792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5g26G/COfPvrLkIRmt5b7hYWmBBdOf28rjYEzX22+c=;
        b=aWylnObLe0J5Rg9jWgmSzl0gmcxh+LiYpo5hZl9cvF0xoAfGo8sZeP863hU8HOegD1
         FwP5SqN5JAP8KIRNLPvUind/nOTC9bhf/8RRYl6RsaF+hR1uUVJvuAgEPxFSxMzozQWH
         5HGonzRs8roT7hmOMg1I56P3cpqIiC1EPd0RaC81Kqd1stHQ1KUZOQVVQ8Tp44m5GvEI
         p3UShq264QqaSOZ57Vt5ERiG4N+JnbfjghbeSVoiagiXyPMXG1OALGtYpplD4BpHhlaq
         OJrnU9nwURkt/0FXbYTRXHl8iBvMVVnu6RyVQpWbi/P4CUG2dRjaQ2OIHinJ7ocr28dr
         ZPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076992; x=1762681792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5g26G/COfPvrLkIRmt5b7hYWmBBdOf28rjYEzX22+c=;
        b=ks05GBwyfkzq1wGZshd/4wnDWW7pKzEisdz7VBTjFrbns4eet++PqA3nsBpVV1+vMG
         pWeLrjcJb6GFTt1DprCTygZ1bqUcBQjHexN2xCEygTSXv3nuUv9eSHfDtkc7k+OE5d2X
         vJtUO2oNedv3X/hKKNWtCVJArfAuMh4Z5V7bULEHL0Co+0Oxhjewrh5jFgLhliLw5Fu7
         Ccgpwu/o+RutH0kYSv86RWN6dyE0vDMbxuOi/vSWJL8ajq5i7os6ldeX44G3YS/jiwQf
         ehKQXDwzuJrhYcj3KZZgPLBMrCMa62kEUT8C+YD+R07Xwnnk0UVp8mVSxo3LN47kyo+a
         lVjg==
X-Forwarded-Encrypted: i=1; AJvYcCU3f2POiQBmsKFh6hmh++heS+cgQ6EL3eQqRm0o5qdV0BhPhnCcl/lJewpFICCS9C90s3qGHmKQNwNgjZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0u4FiHvYkEDklf5VQfKEsMP9XCjkURoiNhdE/yj1qYHs9fy+T
	ZxRJ53z3bl5vvyJIszHhDlKfVcHKtlU5628LgcRAgZDoqC44x/HfW4Lm
X-Gm-Gg: ASbGncvf50winwrurDJfA/tkDD3hLK/op+NMK7Nce4zrL4/m9W0jyVAHYWyFgQSXTur
	101U20s8F6pZ0XHkS1vSAfi61zHRmLjH4HNXAH+jEktSoK9hk5qrLuiESSw9v/S6u2YuBJ/tahV
	JLJuTBCIclI/Nt4h1VyXwkq3M1MWCtGXVRLkZelph8U6BzJlpJHmDKa0jbp8LfZ3EDRN2NoxWzm
	UjOtk9a0FH50Mx0Cny1snDjRtnJZaw+4z9Rd5OR7xGrxXuuzDH6e/hii1Ro4IvNHgpJA510OdfQ
	EspH/U8HEFYjiu0hIQFtwUbPwPXgU84ZxdeOs6QEJjt8Bvf6/phN9G5SRNuvqr2d/wb9MukO4qA
	oBChS7dhK4S2pyCtJPS/hEUGSWGwsY9GEf3zOZqjVSZOjHdiLId3jxmhfb2LauPT3A5th2RPYpU
	HP5eQ0415c1sChhxW9uYMHN/RPqnqPX1PmRJnVjnobhFTEuw==
X-Google-Smtp-Source: AGHT+IE4ZJuOJv/lZZjeLKVBUjHez5Y01sXUDedOJUP9w8GA2DbzhYNRv1LwyZd82LKqaI0ufh3+IQ==
X-Received: by 2002:a17:902:d2d0:b0:295:49ab:3593 with SMTP id d9443c01a7336-29549ab53edmr87061675ad.29.1762076992361;
        Sun, 02 Nov 2025 01:49:52 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29554cba950sm50950775ad.97.2025.11.02.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:50 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id AAAAD1123801; Sun,  2 Nov 2025 18:49:44 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 02/13] um: decouple MMU specific code from the common part
Date: Sun,  2 Nov 2025 18:49:27 +0900
Message-ID: <08489faaad68a17037e1f24b2a39d8fc3b021c61.1762075876.git.thehajime@gmail.com>
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

This splits the memory, process related code with common and MMU
specific parts in order to avoid ifdefs in .c file and duplication
between MMU and !MMU.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/kernel/Makefile         |   5 +-
 arch/um/kernel/mem-pgtable.c    |  55 ++++++++++++++
 arch/um/kernel/mem.c            |  35 ---------
 arch/um/kernel/process.c        |  38 ++++++++++
 arch/um/kernel/skas/process.c   |  37 ---------
 arch/um/os-Linux/Makefile       |   3 +-
 arch/um/os-Linux/process.c      | 129 ++++++++++++++++++++++++++++++++
 arch/um/os-Linux/skas/process.c | 127 -------------------------------
 8 files changed, 227 insertions(+), 202 deletions(-)
 create mode 100644 arch/um/kernel/mem-pgtable.c

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index be60bc451b3f..76d36751973e 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -16,9 +16,10 @@ always-$(KBUILD_BUILTIN) := vmlinux.lds
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
-	signal.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o kmsg_dump.o capflags.o skas/
+	signal.o sysrq.o time.o \
+	um_arch.o umid.o kmsg_dump.o capflags.o
 obj-y += load_file.o
+obj-$(CONFIG_MMU) += mem-pgtable.o tlb.o trap.o skas/
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/mem-pgtable.c b/arch/um/kernel/mem-pgtable.c
new file mode 100644
index 000000000000..549da1d3bff0
--- /dev/null
+++ b/arch/um/kernel/mem-pgtable.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ */
+
+#include <linux/stddef.h>
+#include <linux/module.h>
+#include <linux/memblock.h>
+#include <linux/swap.h>
+#include <linux/slab.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <as-layout.h>
+#include <init.h>
+#include <kern.h>
+#include <kern_util.h>
+#include <mem_user.h>
+#include <os.h>
+#include <um_malloc.h>
+
+
+/* Allocate and free page tables. */
+
+pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+
+	if (pgd) {
+		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+		memcpy(pgd + USER_PTRS_PER_PGD,
+		       swapper_pg_dir + USER_PTRS_PER_PGD,
+		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	}
+	return pgd;
+}
+
+static const pgprot_t protection_map[16] = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE | VM_READ]				= PAGE_COPY,
+	[VM_EXEC]					= PAGE_READONLY,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
+};
+DECLARE_VM_GET_PAGE_PROT
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index dc938715ec9d..52cd906e3896 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -6,7 +6,6 @@
 #include <linux/stddef.h>
 #include <linux/module.h>
 #include <linux/memblock.h>
-#include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -214,45 +213,11 @@ void free_initmem(void)
 {
 }
 
-/* Allocate and free page tables. */
-
-pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd = __pgd_alloc(mm, 0);
-
-	if (pgd)
-		memcpy(pgd + USER_PTRS_PER_PGD,
-		       swapper_pg_dir + USER_PTRS_PER_PGD,
-		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-
-	return pgd;
-}
-
 void *uml_kmalloc(int size, int flags)
 {
 	return kmalloc(size, flags);
 }
 
-static const pgprot_t protection_map[16] = {
-	[VM_NONE]					= PAGE_NONE,
-	[VM_READ]					= PAGE_READONLY,
-	[VM_WRITE]					= PAGE_COPY,
-	[VM_WRITE | VM_READ]				= PAGE_COPY,
-	[VM_EXEC]					= PAGE_READONLY,
-	[VM_EXEC | VM_READ]				= PAGE_READONLY,
-	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
-	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY,
-	[VM_SHARED]					= PAGE_NONE,
-	[VM_SHARED | VM_READ]				= PAGE_READONLY,
-	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
-	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
-	[VM_SHARED | VM_EXEC]				= PAGE_READONLY,
-	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY,
-	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED,
-	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
-};
-DECLARE_VM_GET_PAGE_PROT
-
 void mark_rodata_ro(void)
 {
 	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 63b38a3f73f7..b07c1f120910 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -25,6 +25,7 @@
 #include <linux/tick.h>
 #include <linux/threads.h>
 #include <linux/resume_user_mode.h>
+#include <linux/start_kernel.h>
 #include <asm/current.h>
 #include <asm/mmu_context.h>
 #include <asm/switch_to.h>
@@ -307,3 +308,40 @@ unsigned long __get_wchan(struct task_struct *p)
 
 	return 0;
 }
+
+extern void start_kernel(void);
+
+static int __init start_kernel_proc(void *unused)
+{
+	block_signals_trace();
+
+	start_kernel();
+	return 0;
+}
+
+char cpu_irqstacks[NR_CPUS][THREAD_SIZE] __aligned(THREAD_SIZE);
+
+int __init start_uml(void)
+{
+	stack_protections((unsigned long) &cpu_irqstacks[0]);
+	set_sigstack(cpu_irqstacks[0], THREAD_SIZE);
+
+	init_new_thread_signals();
+
+	init_task.thread.request.thread.proc = start_kernel_proc;
+	init_task.thread.request.thread.arg = NULL;
+	return start_idle_thread(task_stack_page(&init_task),
+				 &init_task.thread.switch_buf);
+}
+
+static DEFINE_SPINLOCK(initial_jmpbuf_spinlock);
+
+void initial_jmpbuf_lock(void)
+{
+	spin_lock_irq(&initial_jmpbuf_spinlock);
+}
+
+void initial_jmpbuf_unlock(void)
+{
+	spin_unlock_irq(&initial_jmpbuf_spinlock);
+}
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 4a7673b0261a..d643854942bc 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -17,31 +17,6 @@
 #include <skas.h>
 #include <kern_util.h>
 
-extern void start_kernel(void);
-
-static int __init start_kernel_proc(void *unused)
-{
-	block_signals_trace();
-
-	start_kernel();
-	return 0;
-}
-
-char cpu_irqstacks[NR_CPUS][THREAD_SIZE] __aligned(THREAD_SIZE);
-
-int __init start_uml(void)
-{
-	stack_protections((unsigned long) &cpu_irqstacks[0]);
-	set_sigstack(cpu_irqstacks[0], THREAD_SIZE);
-
-	init_new_thread_signals();
-
-	init_task.thread.request.thread.proc = start_kernel_proc;
-	init_task.thread.request.thread.arg = NULL;
-	return start_idle_thread(task_stack_page(&init_task),
-				 &init_task.thread.switch_buf);
-}
-
 unsigned long current_stub_stack(void)
 {
 	if (current->mm == NULL)
@@ -65,15 +40,3 @@ void current_mm_sync(void)
 
 	um_tlb_sync(current->mm);
 }
-
-static DEFINE_SPINLOCK(initial_jmpbuf_spinlock);
-
-void initial_jmpbuf_lock(void)
-{
-	spin_lock_irq(&initial_jmpbuf_spinlock);
-}
-
-void initial_jmpbuf_unlock(void)
-{
-	spin_unlock_irq(&initial_jmpbuf_spinlock);
-}
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 70c73c22f715..051679d78aae 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -8,7 +8,8 @@ KCOV_INSTRUMENT                := n
 
 obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o user_syms.o util.o skas/
+	umid.o user_syms.o util.o
+obj-$(CONFIG_MMU) += skas/
 
 CFLAGS_signal.o += -Wframe-larger-than=4096
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 3a2a84ab9325..c50fa865d8c7 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -6,6 +6,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
 #include <signal.h>
@@ -17,10 +18,16 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
+#include <linux/threads.h>
 #include <init.h>
 #include <longjmp.h>
 #include <os.h>
 #include <skas/skas.h>
+#include <as-layout.h>
+#include <kern_util.h>
+
+int using_seccomp;
+static int unscheduled_userspace_iterations;
 
 void os_alarm_process(int pid)
 {
@@ -209,3 +216,125 @@ int os_futex_wake(void *uaddr)
 				NULL, NULL, 0));
 	return r < 0 ? -errno : r;
 }
+
+int is_skas_winch(int pid, int fd, void *data)
+{
+	return pid == getpgrp();
+}
+
+void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
+{
+	(*buf)[0].JB_IP = (unsigned long) handler;
+	(*buf)[0].JB_SP = (unsigned long) stack + UM_THREAD_SIZE -
+		sizeof(void *);
+}
+
+#define INIT_JMP_NEW_THREAD 0
+#define INIT_JMP_CALLBACK 1
+#define INIT_JMP_HALT 2
+#define INIT_JMP_REBOOT 3
+
+void switch_threads(jmp_buf *me, jmp_buf *you)
+{
+	unscheduled_userspace_iterations = 0;
+
+	if (UML_SETJMP(me) == 0)
+		UML_LONGJMP(you, 1);
+}
+
+static jmp_buf initial_jmpbuf;
+
+static __thread void (*cb_proc)(void *arg);
+static __thread void *cb_arg;
+static __thread jmp_buf *cb_back;
+
+int start_idle_thread(void *stack, jmp_buf *switch_buf)
+{
+	int n;
+
+	set_handler(SIGWINCH);
+
+	/*
+	 * Can't use UML_SETJMP or UML_LONGJMP here because they save
+	 * and restore signals, with the possible side-effect of
+	 * trying to handle any signals which came when they were
+	 * blocked, which can't be done on this stack.
+	 * Signals must be blocked when jumping back here and restored
+	 * after returning to the jumper.
+	 */
+	n = setjmp(initial_jmpbuf);
+	switch (n) {
+	case INIT_JMP_NEW_THREAD:
+		(*switch_buf)[0].JB_IP = (unsigned long) uml_finishsetup;
+		(*switch_buf)[0].JB_SP = (unsigned long) stack +
+			UM_THREAD_SIZE - sizeof(void *);
+		break;
+	case INIT_JMP_CALLBACK:
+		(*cb_proc)(cb_arg);
+		longjmp(*cb_back, 1);
+		break;
+	case INIT_JMP_HALT:
+		kmalloc_ok = 0;
+		return 0;
+	case INIT_JMP_REBOOT:
+		kmalloc_ok = 0;
+		return 1;
+	default:
+		printk(UM_KERN_ERR "Bad sigsetjmp return in %s - %d\n",
+		       __func__, n);
+		fatal_sigsegv();
+	}
+	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	printk(UM_KERN_ERR "impossible long jump!");
+	fatal_sigsegv();
+	return 0;
+}
+
+void initial_thread_cb_skas(void (*proc)(void *), void *arg)
+{
+	jmp_buf here;
+
+	cb_proc = proc;
+	cb_arg = arg;
+	cb_back = &here;
+
+	initial_jmpbuf_lock();
+	if (UML_SETJMP(&here) == 0)
+		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
+	initial_jmpbuf_unlock();
+
+	cb_proc = NULL;
+	cb_arg = NULL;
+	cb_back = NULL;
+}
+
+void halt_skas(void)
+{
+	initial_jmpbuf_lock();
+	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
+	/* unreachable */
+}
+
+static bool noreboot;
+
+static int __init noreboot_cmd_param(char *str, int *add)
+{
+	*add = 0;
+	noreboot = true;
+	return 0;
+}
+
+__uml_setup("noreboot", noreboot_cmd_param,
+"noreboot\n"
+"    Rather than rebooting, exit always, akin to QEMU's -no-reboot option.\n"
+"    This is useful if you're using CONFIG_PANIC_TIMEOUT in order to catch\n"
+"    crashes in CI\n\n");
+
+void reboot_skas(void)
+{
+	initial_jmpbuf_lock();
+	UML_LONGJMP(&initial_jmpbuf, noreboot ? INIT_JMP_HALT : INIT_JMP_REBOOT);
+	/* unreachable */
+}
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d6c22f8aa06d..01814ad82f5d 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -18,7 +18,6 @@
 #include <sys/stat.h>
 #include <sys/socket.h>
 #include <asm/unistd.h>
-#include <as-layout.h>
 #include <init.h>
 #include <kern_util.h>
 #include <mem.h>
@@ -29,16 +28,10 @@
 #include <sysdep/stub.h>
 #include <sysdep/mcontext.h>
 #include <linux/futex.h>
-#include <linux/threads.h>
 #include <timetravel.h>
 #include <asm-generic/rwonce.h>
 #include "../internal.h"
 
-int is_skas_winch(int pid, int fd, void *data)
-{
-	return pid == getpgrp();
-}
-
 static const char *ptrace_reg_name(int idx)
 {
 #define R(n) case HOST_##n: return #n
@@ -426,8 +419,6 @@ static int __init init_stub_exe_fd(void)
 }
 __initcall(init_stub_exe_fd);
 
-int using_seccomp;
-
 /**
  * start_userspace() - prepare a new userspace process
  * @mm_id: The corresponding struct mm_id
@@ -540,7 +531,6 @@ int start_userspace(struct mm_id *mm_id)
 	return err;
 }
 
-static int unscheduled_userspace_iterations;
 extern unsigned long tt_extra_sched_jiffies;
 
 void userspace(struct uml_pt_regs *regs)
@@ -789,120 +779,3 @@ void userspace(struct uml_pt_regs *regs)
 		}
 	}
 }
-
-void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
-{
-	(*buf)[0].JB_IP = (unsigned long) handler;
-	(*buf)[0].JB_SP = (unsigned long) stack + UM_THREAD_SIZE -
-		sizeof(void *);
-}
-
-#define INIT_JMP_NEW_THREAD 0
-#define INIT_JMP_CALLBACK 1
-#define INIT_JMP_HALT 2
-#define INIT_JMP_REBOOT 3
-
-void switch_threads(jmp_buf *me, jmp_buf *you)
-{
-	unscheduled_userspace_iterations = 0;
-
-	if (UML_SETJMP(me) == 0)
-		UML_LONGJMP(you, 1);
-}
-
-static jmp_buf initial_jmpbuf;
-
-static __thread void (*cb_proc)(void *arg);
-static __thread void *cb_arg;
-static __thread jmp_buf *cb_back;
-
-int start_idle_thread(void *stack, jmp_buf *switch_buf)
-{
-	int n;
-
-	set_handler(SIGWINCH);
-
-	/*
-	 * Can't use UML_SETJMP or UML_LONGJMP here because they save
-	 * and restore signals, with the possible side-effect of
-	 * trying to handle any signals which came when they were
-	 * blocked, which can't be done on this stack.
-	 * Signals must be blocked when jumping back here and restored
-	 * after returning to the jumper.
-	 */
-	n = setjmp(initial_jmpbuf);
-	switch (n) {
-	case INIT_JMP_NEW_THREAD:
-		(*switch_buf)[0].JB_IP = (unsigned long) uml_finishsetup;
-		(*switch_buf)[0].JB_SP = (unsigned long) stack +
-			UM_THREAD_SIZE - sizeof(void *);
-		break;
-	case INIT_JMP_CALLBACK:
-		(*cb_proc)(cb_arg);
-		longjmp(*cb_back, 1);
-		break;
-	case INIT_JMP_HALT:
-		kmalloc_ok = 0;
-		return 0;
-	case INIT_JMP_REBOOT:
-		kmalloc_ok = 0;
-		return 1;
-	default:
-		printk(UM_KERN_ERR "Bad sigsetjmp return in %s - %d\n",
-		       __func__, n);
-		fatal_sigsegv();
-	}
-	longjmp(*switch_buf, 1);
-
-	/* unreachable */
-	printk(UM_KERN_ERR "impossible long jump!");
-	fatal_sigsegv();
-	return 0;
-}
-
-void initial_thread_cb_skas(void (*proc)(void *), void *arg)
-{
-	jmp_buf here;
-
-	cb_proc = proc;
-	cb_arg = arg;
-	cb_back = &here;
-
-	initial_jmpbuf_lock();
-	if (UML_SETJMP(&here) == 0)
-		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
-	initial_jmpbuf_unlock();
-
-	cb_proc = NULL;
-	cb_arg = NULL;
-	cb_back = NULL;
-}
-
-void halt_skas(void)
-{
-	initial_jmpbuf_lock();
-	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
-	/* unreachable */
-}
-
-static bool noreboot;
-
-static int __init noreboot_cmd_param(char *str, int *add)
-{
-	*add = 0;
-	noreboot = true;
-	return 0;
-}
-
-__uml_setup("noreboot", noreboot_cmd_param,
-"noreboot\n"
-"    Rather than rebooting, exit always, akin to QEMU's -no-reboot option.\n"
-"    This is useful if you're using CONFIG_PANIC_TIMEOUT in order to catch\n"
-"    crashes in CI\n\n");
-
-void reboot_skas(void)
-{
-	initial_jmpbuf_lock();
-	UML_LONGJMP(&initial_jmpbuf, noreboot ? INIT_JMP_HALT : INIT_JMP_REBOOT);
-	/* unreachable */
-}
-- 
2.43.0



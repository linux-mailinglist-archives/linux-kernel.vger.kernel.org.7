Return-Path: <linux-kernel+bounces-891387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C886CC42936
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FD73B3E6E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7A2E9759;
	Sat,  8 Nov 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGKGPkMX"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448002E1EEE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589180; cv=none; b=CIXnwdMEuSo0nk0fEgXclbUBdYpQJFn6JvyHHGwfkShpQtIjqEQGvSv0nAiyZq6lJQASCeCQRS4olNvduFeDXMj+4I15nEvJfR12eOHuOU6Mz9jeVKkkt1zPIIYk9RsCkk7ATVcFAF+V1V9k8YXVrKhrT4oeWlpgNgqa/7S4b6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589180; c=relaxed/simple;
	bh=Q1RsL2/EtjIgu5QYIPwEJ1zosyelA3KCSVkAQjDY+RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9fxg/vM+m+5O5nK1hDGIF6WQ2WsLUQf9eVbb+RFAtfeUYylsINYyEnChMcUSVlhSom5NtK9XYagFu8ukE0Wj/inPIuNWEDgC/stkpIjU27QLg8HdhEXm1RfUqFu4F2TT8RwOEXolhZp2MRgLKi0zJfSNJ7vgUd7W7jLxkaoKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGKGPkMX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so283129b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589177; x=1763193977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZpI4L1Kh98JdhM/QsHv9mwFGGWJGOR2fxfWgHIsbW8=;
        b=SGKGPkMXwZDm7JCcBQyqbjg05yRCY/k2OLab9JtFp1Ww+jZLYBIALXpzaralP2/fhS
         Evj5/kD4Ugawr0y06JDCshyV/bWH9YB2jFaEY5ASOfteec+gwzBD6OOqLVGddpnmw/LW
         vIW5yHWZ2irDzK+Murj5X4fxidu+6R7u42tgaV0FKLAAZ0nNw9Z/nclBC1fAESRFF2p7
         gffTCWxzXbX+63ocGYCGLpUK+Z+kVBOUpgMMu++P023YimYCuvrJ6fSwl2y3hfNuAuiw
         WBR9D02Z9iRukX1rkgTjsg9Tdk/tm3JwJByP4dvT34ZP8uDH7hoZKgqIioK1IuYod0JJ
         7OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589177; x=1763193977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZpI4L1Kh98JdhM/QsHv9mwFGGWJGOR2fxfWgHIsbW8=;
        b=YUskaAzbG4FsudddV8W135+CEn8SlgAyoz4EM9lWBmF/fKpt7XCB3kwEVzRXV2tdAB
         VsQdvuivddama1xF3X664XyIHBjdmf7AFwqPoc5+vEQEX1s95uIB4dNlz6amwangbK/R
         RIli8sryYZ7YZ8E/JpsYDc4l0H70aVocnsiQ+qTn/HFoxywUG7//CnXyYHZbvtS7lNuE
         lCrB4lAk2CQJXZ4pyfqIbaW7Yu66Kt11uoDgX/F5T94ul4xh6cbcewd5cl62H3c2jPjJ
         wuretQ0Hc7HbFogxrQE+K0WCLGrtLtO4DXeHsEkA3Y7WC8mcLKI61abqQbRvXu70A9gy
         LZlA==
X-Forwarded-Encrypted: i=1; AJvYcCU5w+cGpWM722KS7nAJQbLdJvcE4qXNR2JgUxydYp9aIebMv0r50c3QLgw/WqAfO6v58p/RX56GO01h7Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt49ja77eo9HKyoOyN/8XOu1NGt96uvspfjW4W6ae6jXLWyMpQ
	rOIYjZ68/FPNgOEdGokDj8SbA4lsTOf3w40SF4JzAdAggM7MZADI6lzV
X-Gm-Gg: ASbGnctR/ywAZOdbA7pcsJhwp0Wc9wrQTJywJyG/4VI4lLVHk9hn61qJPUfexvqBoVK
	zO2nc5WBrQPN6w1GO+2fyPwXsltE2izAnbkPB/F9mf0tklt0QOjmS1jkguX3K/7DFrIVu/j8Fh8
	7v0c13rZn2W7zJBzxAL3ZbDf/V5j1dG00Lc+XE2yAl0XOF6roC2Qy1Nq4zIa//qhOiqot3J8U3K
	5bvbeWrbsvYhTUqZHfu9dMBJEhZNWeYLLkV6Y/LDiZ9w3VMCB+J5ACvlZc+RwAHQRf2EzXW/FcG
	5NCp/garBd1V8JhZns3ODXK/N/HjFALq1pJ2b03Stax7eDMHro3KRNYHOTNVVNu7XSamY53Gt5y
	r5trb0mv6BvIxhMGN67v7ervIJ+iZM4NhL91U+yh+wR/MWpaWSnC9W7t4HooBwsceBHAb3vz+c0
	Mh6B9MNnJm9qZYUBzlFJfaGnIyPhQQJxzfIrkxJWAJqVnmuKPatH7iGL/Q
X-Google-Smtp-Source: AGHT+IEtQahKb/xhxpS9blrirl5D/G2IB7a8vh9pAl760xoGpH+7uMEuvrcbi80xszZ6UIWdzZ2HYQ==
X-Received: by 2002:a05:6a20:9144:b0:350:fa56:3f45 with SMTP id adf61e73a8af0-353a335664dmr2653669637.35.1762589177334;
        Sat, 08 Nov 2025 00:06:17 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba9024e6e17sm7053523a12.34.2025.11.08.00.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:16 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id EB81211388D7; Sat,  8 Nov 2025 17:06:14 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 09/13] x86/um: nommu: signal handling
Date: Sat,  8 Nov 2025 17:05:44 +0900
Message-ID: <c3d41609286993562214359a6158997e9de06551.1762588860.git.thehajime@gmail.com>
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

This commit updates the behavior of signal handling under !MMU
environment. It adds the alignment code for signal frame as the frame
is used in userspace as-is.

floating point register is carefully handling upon entry/leave of
syscall routine so that signal handlers can read/write the contents of
the register.

It also adds the follow up routine for SIGSEGV as a signal delivery runs
in the same stack frame while we have to avoid endless SIGSEGV.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/shared/kern_util.h    |   4 +
 arch/um/nommu/Makefile                |   2 +-
 arch/um/nommu/os-Linux/signal.c       |   8 +
 arch/um/nommu/trap.c                  | 201 ++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c             |   3 +-
 arch/x86/um/nommu/do_syscall_64.c     |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c |  11 ++
 arch/x86/um/shared/sysdep/mcontext.h  |   1 +
 arch/x86/um/shared/sysdep/ptrace.h    |   2 +-
 9 files changed, 235 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/nommu/trap.c

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 7798f16a4677..46c8d6336ca1 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -70,4 +70,8 @@ void um_idle_sleep(void);
 
 void kasan_map_memory(void *start, size_t len);
 
+#ifndef CONFIG_MMU
+extern void nommu_relay_signal(void *ptr);
+#endif
+
 #endif
diff --git a/arch/um/nommu/Makefile b/arch/um/nommu/Makefile
index baab7c2f57c2..096221590cfd 100644
--- a/arch/um/nommu/Makefile
+++ b/arch/um/nommu/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := os-Linux/
+obj-y := trap.o os-Linux/
diff --git a/arch/um/nommu/os-Linux/signal.c b/arch/um/nommu/os-Linux/signal.c
index 19043b9652e2..6febb178dcda 100644
--- a/arch/um/nommu/os-Linux/signal.c
+++ b/arch/um/nommu/os-Linux/signal.c
@@ -5,6 +5,7 @@
 #include <os.h>
 #include <sysdep/mcontext.h>
 #include <sys/ucontext.h>
+#include <as-layout.h>
 
 void sigsys_handler(int sig, struct siginfo *si,
 		    struct uml_pt_regs *regs, void *ptr)
@@ -14,3 +15,10 @@ void sigsys_handler(int sig, struct siginfo *si,
 	/* hook syscall via SIGSYS */
 	set_mc_sigsys_hook(mc);
 }
+
+void nommu_relay_signal(void *ptr)
+{
+	mcontext_t *mc = (mcontext_t *) ptr;
+
+	set_mc_relay_signal(mc);
+}
diff --git a/arch/um/nommu/trap.c b/arch/um/nommu/trap.c
new file mode 100644
index 000000000000..430297517455
--- /dev/null
+++ b/arch/um/nommu/trap.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/hardirq.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/sched/debug.h>
+#include <asm/current.h>
+#include <asm/tlbflush.h>
+#include <arch.h>
+#include <as-layout.h>
+#include <kern_util.h>
+#include <os.h>
+#include <skas.h>
+
+/*
+ * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
+ * segv().
+ */
+int handle_page_fault(unsigned long address, unsigned long ip,
+		      int is_write, int is_user, int *code_out)
+{
+	/* !MMU has no pagefault */
+	return -EFAULT;
+}
+
+static void show_segv_info(struct uml_pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+	struct faultinfo *fi = UPT_FAULTINFO(regs);
+
+	if (!unhandled_signal(tsk, SIGSEGV))
+		return;
+
+	pr_warn_ratelimited("%s%s[%d]: segfault at %lx ip %p sp %p error %x",
+			    task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
+			    tsk->comm, task_pid_nr(tsk), FAULT_ADDRESS(*fi),
+			    (void *)UPT_IP(regs), (void *)UPT_SP(regs),
+			    fi->error_code);
+}
+
+static void bad_segv(struct faultinfo fi, unsigned long ip)
+{
+	current->thread.arch.faultinfo = fi;
+	force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *) FAULT_ADDRESS(fi));
+}
+
+void fatal_sigsegv(void)
+{
+	force_fatal_sig(SIGSEGV);
+	do_signal(&current->thread.regs);
+	/*
+	 * This is to tell gcc that we're not returning - do_signal
+	 * can, in general, return, but in this case, it's not, since
+	 * we just got a fatal SIGSEGV queued.
+	 */
+	os_dump_core();
+}
+
+/**
+ * segv_handler() - the SIGSEGV handler
+ * @sig:	the signal number
+ * @unused_si:	the signal info struct; unused in this handler
+ * @regs:	the ptrace register information
+ *
+ * The handler first extracts the faultinfo from the UML ptrace regs struct.
+ * If the userfault did not happen in an UML userspace process, bad_segv is called.
+ * Otherwise the signal did happen in a cloned userspace process, handle it.
+ */
+void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
+		  void *mc)
+{
+	struct faultinfo *fi = UPT_FAULTINFO(regs);
+
+	/* !MMU specific part; detection of userspace */
+	/* mark is_user=1 when the IP is from userspace code. */
+	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) < high_physmem)
+		regs->is_user = 1;
+
+	if (UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)) {
+		show_segv_info(regs);
+		bad_segv(*fi, UPT_IP(regs));
+		return;
+	}
+	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs, mc);
+
+	/* !MMU specific part; detection of userspace */
+	relay_signal(sig, unused_si, regs, mc);
+}
+
+/*
+ * We give a *copy* of the faultinfo in the regs to segv.
+ * This must be done, since nesting SEGVs could overwrite
+ * the info in the regs. A pointer to the info then would
+ * give us bad data!
+ */
+unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
+		   struct uml_pt_regs *regs, void *mc)
+{
+	int si_code;
+	int err;
+	int is_write = FAULT_WRITE(fi);
+	unsigned long address = FAULT_ADDRESS(fi);
+
+	if (!is_user && regs)
+		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
+
+	if (current->mm == NULL) {
+		show_regs(container_of(regs, struct pt_regs, regs));
+		panic("Segfault with no mm");
+	} else if (!is_user && address > PAGE_SIZE && address < TASK_SIZE) {
+		show_regs(container_of(regs, struct pt_regs, regs));
+		panic("Kernel tried to access user memory at addr 0x%lx, ip 0x%lx",
+		       address, ip);
+	}
+
+	if (SEGV_IS_FIXABLE(&fi))
+		err = handle_page_fault(address, ip, is_write, is_user,
+					&si_code);
+	else {
+		err = -EFAULT;
+		/*
+		 * A thread accessed NULL, we get a fault, but CR2 is invalid.
+		 * This code is used in __do_copy_from_user() of TT mode.
+		 * XXX tt mode is gone, so maybe this isn't needed any more
+		 */
+		address = 0;
+	}
+
+	if (!err)
+		goto out;
+	else if (!is_user && arch_fixup(ip, regs))
+		goto out;
+
+	if (!is_user) {
+		show_regs(container_of(regs, struct pt_regs, regs));
+		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
+		      address, ip);
+	}
+
+	show_segv_info(regs);
+
+	if (err == -EACCES) {
+		current->thread.arch.faultinfo = fi;
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
+	} else {
+		WARN_ON_ONCE(err != -EFAULT);
+		current->thread.arch.faultinfo = fi;
+		force_sig_fault(SIGSEGV, si_code, (void __user *) address);
+	}
+
+out:
+	if (regs)
+		current->thread.segv_regs = NULL;
+
+	return 0;
+}
+
+void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs,
+		  void *mc)
+{
+	int code, err;
+
+	/* !MMU specific part; detection of userspace */
+	/* mark is_user=1 when the IP is from userspace code. */
+	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) < high_physmem)
+		regs->is_user = 1;
+
+	if (!UPT_IS_USER(regs)) {
+		if (sig == SIGBUS)
+			pr_err("Bus error - the host /dev/shm or /tmp mount likely just ran out of space\n");
+		panic("Kernel mode signal %d", sig);
+	}
+	/* if is_user==1, set return to userspace sig handler to relay signal */
+	nommu_relay_signal(mc);
+
+	arch_examine_signal(sig, regs);
+
+	/* Is the signal layout for the signal known?
+	 * Signal data must be scrubbed to prevent information leaks.
+	 */
+	code = si->si_code;
+	err = si->si_errno;
+	if ((err == 0) && (siginfo_layout(sig, code) == SIL_FAULT)) {
+		struct faultinfo *fi = UPT_FAULTINFO(regs);
+
+		current->thread.arch.faultinfo = *fi;
+		force_sig_fault(sig, code, (void __user *)FAULT_ADDRESS(*fi));
+	} else {
+		pr_err("Attempted to relay unknown signal %d (si_code = %d) with errno %d\n",
+		       sig, code, err);
+		force_sig(sig);
+	}
+}
+
+void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
+	   void *mc)
+{
+	do_IRQ(WINCH_IRQ, regs);
+}
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 2f6795cd884c..28754f56c42b 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -41,9 +41,10 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	int save_errno = errno;
 
 	r.is_user = 0;
+	if (mc)
+		get_regs_from_mc(&r, mc);
 	if (sig == SIGSEGV) {
 		/* For segfaults, we want the data from the sigcontext. */
-		get_regs_from_mc(&r, mc);
 		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
 	}
 
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
index 9bc630995df9..cf5a347ee9b1 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -44,6 +44,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* set fs register to the original host one */
 	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
 
+	/* save fp registers */
+	asm volatile("fxsaveq %0" : "=m"(*(struct _xstate *)regs->regs.fp));
+
 	if (likely(syscall < NR_syscalls)) {
 		unsigned long ret;
 
@@ -61,6 +64,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* handle tasks and signals at the end */
 	interrupt_end();
 
+	/* restore fp registers */
+	asm volatile("fxrstorq %0" : : "m"((current->thread.regs.regs.fp)));
+
 	/* restore back fs register to userspace configured one */
 	os_x86_arch_prctl(0, ARCH_SET_FS,
 		      (void *)(current->thread.regs.regs.gp[FS_BASE
diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/os-Linux/mcontext.c
index b62a6195096f..afa20f1e235a 100644
--- a/arch/x86/um/nommu/os-Linux/mcontext.c
+++ b/arch/x86/um/nommu/os-Linux/mcontext.c
@@ -4,10 +4,21 @@
 #include <asm/ptrace.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/mcontext.h>
+#include <os.h>
+#include "../syscalls.h"
 
 extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
 			      int64_t a4, int64_t a5, int64_t a6);
 
+void set_mc_relay_signal(mcontext_t *mc)
+{
+	/* configure stack and userspace returning routine as
+	 * instruction pointer
+	 */
+	mc->gregs[REG_RSP] = (unsigned long) current_top_of_stack;
+	mc->gregs[REG_RIP] = (unsigned long) userspace;
+}
+
 void set_mc_sigsys_hook(mcontext_t *mc)
 {
 	mc->gregs[REG_RCX] = mc->gregs[REG_RIP];
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index 9a0d6087f357..82a5f38b350f 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -19,6 +19,7 @@ extern int set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
 
 #ifndef CONFIG_MMU
 extern void set_mc_sigsys_hook(mcontext_t *mc);
+extern void set_mc_relay_signal(mcontext_t *mc);
 #endif
 
 #ifdef __i386__
diff --git a/arch/x86/um/shared/sysdep/ptrace.h b/arch/x86/um/shared/sysdep/ptrace.h
index 572ea2d79131..6ed6bb1ca50e 100644
--- a/arch/x86/um/shared/sysdep/ptrace.h
+++ b/arch/x86/um/shared/sysdep/ptrace.h
@@ -53,7 +53,7 @@ struct uml_pt_regs {
 	int is_user;
 
 	/* Dynamically sized FP registers (holds an XSTATE) */
-	unsigned long fp[];
+	unsigned long fp[] __attribute__((aligned(16)));
 };
 
 #define EMPTY_UML_PT_REGS { }
-- 
2.43.0



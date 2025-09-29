Return-Path: <linux-kernel+bounces-836051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ED7BA8A05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3CC3BD59F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B312241673;
	Mon, 29 Sep 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q9FYwDDT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M55FIJ4x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC16A2C11E7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138146; cv=none; b=q8V0ircE4KAt+1IrSkh8kSe12LXNrp3gSl9UnxAWI12KH6As5Xx5Ts2kU6wMTJl6DI51d1XG8WiUfu446bajoezsws7H+FKZ+5/BqbJRuAtTRRR/q9usHirF2gdeoCtX3JZNPUj7dpeZ2WVTop+ooVf5f5gUcaHk72GpwA18atw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138146; c=relaxed/simple;
	bh=qjlQudrjSseXx3c797hhjWkkGPx0+2UqjCwGViC5Vao=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=jgaaLQVzLZ/CMMDGMVKQSpQF7okPkeUpjGg6mrJoQicwDl6xjde4kPPjynFBxCpl3oDHnKnnb10UsWp8vFJ+C6k0Yxkjo03aY7G/YY3Jx1xyJ5TuKWYkneiKtNGt32xPhn7iH8z3IOhZ3fr9CGSJY9s5tthGE+gv2Q7BJ8AMRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q9FYwDDT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M55FIJ4x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759138136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MuM6dxwYRvwht+AD9Fc50Yyh7RjG672LA3Jri4nOW+M=;
	b=q9FYwDDT7tIKbhwgVvDcwCdo3FisA3skk8bxqrcUTVRWXPshH6PgcPv5UA/qA5E302PfPL
	7fRDvyuRhv2meCGyt4cBrLGqWKHHq6oiweYJdtwEn70EXu6zm20d6U5WvLWbM3lSsyQ4XW
	NF7zezJ1tHtHxhYWTm/LnL8OKoWz/proxy1Yem7tSHnnL3zYtdQDIfNVYQ7q0jI1WhP7c3
	5zC17tErWYkae2rQ6dRrev1F5OISIxAXyXUq3i3NP2xqKsoD9R8Uf/Y+9LfhCwT8iE+h+Z
	OJz8hAA90yhI5wqOPbr70knBfh2z/eJiFN7bRlTsxLYwoDj0bnckG+SEAsJMPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759138136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MuM6dxwYRvwht+AD9Fc50Yyh7RjG672LA3Jri4nOW+M=;
	b=M55FIJ4xAXtvzk8OdF5frF1xeFrNFAscB6c+mKq70yL5xOwVcxB+13qeHeEMNWuhNbU71U
	r30WZ1/psDKHpkBQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/core for v6.18-rc1
Message-ID: <175913807599.495041.10251515322736195577.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 11:28:54 +0200 (CEST)

Linus,

please pull the latest core/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2025-0=
9-29

up to:  3ec09344b01a: LoongArch: Fix bitflag conflict for TIF_FIXADE

A set of changes to consolidate the generic TIF bits accross architectures

All architectures define the same set of generic TIF bits. This makes it
pointlessly hard to add a new generic TIF bit or to change an existing one.

Provide a generic variant and convert the architectures which utilize the
generic entry code over to use it. The TIF space is divided into 16 generic
bits and 16 architecture specific bits, which turned out to provide enough
space on both sides.

Thanks,

	tglx

------------------>
Sven Schnelle (1):
      s390/entry: Remove unused TIF flags

Thomas Gleixner (5):
      asm-generic: Provide generic TIF infrastructure
      x86: Use generic TIF bits
      s390: Use generic TIF bits
      loongarch: Use generic TIF bits
      riscv: Use generic TIF bits

Yao Zi (1):
      LoongArch: Fix bitflag conflict for TIF_FIXADE


 arch/Kconfig                             |  4 ++
 arch/loongarch/Kconfig                   |  1 +
 arch/loongarch/include/asm/thread_info.h | 76 ++++++++++++++----------------=
--
 arch/riscv/Kconfig                       |  1 +
 arch/riscv/include/asm/thread_info.h     | 31 ++++++-------
 arch/s390/Kconfig                        |  1 +
 arch/s390/include/asm/thread_info.h      | 50 +++++++--------------
 arch/x86/Kconfig                         |  1 +
 arch/x86/include/asm/thread_info.h       | 76 +++++++++++++-----------------=
--
 include/asm-generic/thread_info_tif.h    | 48 ++++++++++++++++++++
 10 files changed, 150 insertions(+), 139 deletions(-)
 create mode 100644 include/asm-generic/thread_info_tif.h

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..c20df40a7220 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1730,6 +1730,10 @@ config ARCH_VMLINUX_NEEDS_RELOCS
 	  relocations preserved. This is used by some architectures to
 	  construct bespoke relocation tables for KASLR.
=20
+# Select if architecture uses the common generic TIF bits
+config HAVE_GENERIC_TIF_BITS
+       bool
+
 source "kernel/gcov/Kconfig"
=20
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38c40ac..2e90d862ebb3 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -140,6 +140,7 @@ config LOONGARCH
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
 	select HAVE_EXIT_THREAD
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/includ=
e/asm/thread_info.h
index 9dfa2ef00816..4d7117fcdc78 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -65,50 +65,42 @@ register unsigned long current_stack_pointer __asm__("$sp=
");
  *   access
  * - pending work-to-be-done flags are in LSW
  * - other flags in MSW
+ *
+ * Tell the generic TIF infrastructure which special bits loongarch supports
  */
-#define TIF_NEED_RESCHED	0	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	1	/* lazy rescheduling necessary */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
-#define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
-#define TIF_RESTORE_SIGMASK	5	/* restore signal mask in do_signal() */
-#define TIF_NOHZ		6	/* in adaptive nohz mode */
-#define TIF_UPROBE		7	/* breakpointed or singlestepping */
-#define TIF_USEDFPU		8	/* FPU was used by this task this quantum (SMP) */
-#define TIF_USEDSIMD		9	/* SIMD has been used this quantum */
-#define TIF_MEMDIE		10	/* is terminating due to OOM killer */
-#define TIF_FIXADE		11	/* Fix address errors in software */
-#define TIF_LOGADE		12	/* Log address errors to syslog */
-#define TIF_32BIT_REGS		13	/* 32-bit general purpose registers */
-#define TIF_32BIT_ADDR		14	/* 32-bit address space */
-#define TIF_LOAD_WATCH		15	/* If set, load watch registers */
-#define TIF_SINGLESTEP		16	/* Single Step */
-#define TIF_LSX_CTX_LIVE	17	/* LSX context must be preserved */
-#define TIF_LASX_CTX_LIVE	18	/* LASX context must be preserved */
-#define TIF_USEDLBT		19	/* LBT was used by this task this quantum (SMP) */
-#define TIF_LBT_CTX_LIVE	20	/* LBT context must be preserved */
-#define TIF_PATCH_PENDING	21	/* pending live patching update */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_RESTORE_SIGMASK
+
+#include <asm-generic/thread_info_tif.h>
+
+/* Architecture specific bits */
+#define TIF_NOHZ		16	/* in adaptive nohz mode */
+#define TIF_USEDFPU		17	/* FPU was used by this task this quantum (SMP) */
+#define TIF_USEDSIMD		18	/* SIMD has been used this quantum */
+#define TIF_FIXADE		19	/* Fix address errors in software */
+#define TIF_LOGADE		20	/* Log address errors to syslog */
+#define TIF_32BIT_REGS		21	/* 32-bit general purpose registers */
+#define TIF_32BIT_ADDR		22	/* 32-bit address space */
+#define TIF_LOAD_WATCH		23	/* If set, load watch registers */
+#define TIF_SINGLESTEP		24	/* Single Step */
+#define TIF_LSX_CTX_LIVE	25	/* LSX context must be preserved */
+#define TIF_LASX_CTX_LIVE	26	/* LASX context must be preserved */
+#define TIF_USEDLBT		27	/* LBT was used by this task this quantum (SMP) */
+#define TIF_LBT_CTX_LIVE	28	/* LBT context must be preserved */
=20
-#define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
-#define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
-#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
-#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
-#define _TIF_NOHZ		(1<<TIF_NOHZ)
-#define _TIF_UPROBE		(1<<TIF_UPROBE)
-#define _TIF_USEDFPU		(1<<TIF_USEDFPU)
-#define _TIF_USEDSIMD		(1<<TIF_USEDSIMD)
-#define _TIF_FIXADE		(1<<TIF_FIXADE)
-#define _TIF_LOGADE		(1<<TIF_LOGADE)
-#define _TIF_32BIT_REGS		(1<<TIF_32BIT_REGS)
-#define _TIF_32BIT_ADDR		(1<<TIF_32BIT_ADDR)
-#define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
-#define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
-#define _TIF_LSX_CTX_LIVE	(1<<TIF_LSX_CTX_LIVE)
-#define _TIF_LASX_CTX_LIVE	(1<<TIF_LASX_CTX_LIVE)
-#define _TIF_USEDLBT		(1<<TIF_USEDLBT)
-#define _TIF_LBT_CTX_LIVE	(1<<TIF_LBT_CTX_LIVE)
-#define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
+#define _TIF_NOHZ		BIT(TIF_NOHZ)
+#define _TIF_USEDFPU		BIT(TIF_USEDFPU)
+#define _TIF_USEDSIMD		BIT(TIF_USEDSIMD)
+#define _TIF_FIXADE		BIT(TIF_FIXADE)
+#define _TIF_LOGADE		BIT(TIF_LOGADE)
+#define _TIF_32BIT_REGS		BIT(TIF_32BIT_REGS)
+#define _TIF_32BIT_ADDR		BIT(TIF_32BIT_ADDR)
+#define _TIF_LOAD_WATCH		BIT(TIF_LOAD_WATCH)
+#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
+#define _TIF_LSX_CTX_LIVE	BIT(TIF_LSX_CTX_LIVE)
+#define _TIF_LASX_CTX_LIVE	BIT(TIF_LASX_CTX_LIVE)
+#define _TIF_USEDLBT		BIT(TIF_USEDLBT)
+#define _TIF_LBT_CTX_LIVE	BIT(TIF_LBT_CTX_LIVE)
=20
 #endif /* __KERNEL__ */
 #endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 51dcd8eaa243..0c280614a284 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -161,6 +161,7 @@ config RISCV
 	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && HAVE_DYNAMIC_FTRACE
 	select HAVE_EBPF_JIT if MMU
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/th=
read_info.h
index f5916a70879a..a315b0261b9d 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -107,23 +107,18 @@ int arch_dup_task_struct(struct task_struct *dst, struc=
t task_struct *src);
  * - pending work-to-be-done flags are in lowest half-word
  * - other flags in upper half-word(s)
  */
-#define TIF_NEED_RESCHED	0	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	1       /* Lazy rescheduling needed */
-#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
-#define TIF_SIGPENDING		3	/* signal pending */
-#define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
-#define TIF_MEMDIE		5	/* is terminating due to OOM killer */
-#define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
-#define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
-#define TIF_32BIT		11	/* compat-mode 32bit process */
-#define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to us=
er */
-
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
-#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
+
+/*
+ * Tell the generic TIF infrastructure which bits riscv supports
+ */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_RESTORE_SIGMASK
+
+#include <asm-generic/thread_info_tif.h>
+
+#define TIF_32BIT			16	/* compat-mode 32bit process */
+#define TIF_RISCV_V_DEFER_RESTORE	17	/* restore Vector before returing to us=
er */
+
+#define _TIF_RISCV_V_DEFER_RESTORE	BIT(TIF_RISCV_V_DEFER_RESTORE)
=20
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf680c26a33c..f991ab92e391 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -199,6 +199,7 @@ config S390
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY
 	select HAVE_FTRACE_GRAPH_FUNC
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thre=
ad_info.h
index f6ed2c8192c8..7878e9bfbf07 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -56,49 +56,31 @@ void arch_setup_new_exec(void);
=20
 /*
  * thread information flags bit numbers
+ *
+ * Tell the generic TIF infrastructure which special bits s390 supports
  */
-#define TIF_NOTIFY_RESUME	0	/* callback before returning to user */
-#define TIF_SIGPENDING		1	/* signal pending */
-#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	3	/* lazy rescheduling needed */
-#define TIF_UPROBE		4	/* breakpointed or single-stepping */
-#define TIF_PATCH_PENDING	5	/* pending live patching update */
-#define TIF_ASCE_PRIMARY	6	/* primary asce is kernel asce */
-#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
-#define TIF_GUARDED_STORAGE	8	/* load guarded storage control block */
-#define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
-#define TIF_PER_TRAP		10	/* Need to handle PER trap on exit to usermode */
-#define TIF_31BIT		16	/* 32bit process */
-#define TIF_MEMDIE		17	/* is terminating due to OOM killer */
-#define TIF_RESTORE_SIGMASK	18	/* restore signal mask in do_signal() */
-#define TIF_SINGLE_STEP		19	/* This task is single stepped */
-#define TIF_BLOCK_STEP		20	/* This task is block stepped */
-#define TIF_UPROBE_SINGLESTEP	21	/* This task is uprobe single stepped */
-#define TIF_SYSCALL_TRACE	24	/* syscall trace active */
-#define TIF_SYSCALL_AUDIT	25	/* syscall auditing active */
-#define TIF_SECCOMP		26	/* secure computing */
-#define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_RESTORE_SIGMASK
+
+#include <asm-generic/thread_info_tif.h>
+
+/* Architecture specific bits */
+#define TIF_ASCE_PRIMARY	16	/* primary asce is kernel asce */
+#define TIF_GUARDED_STORAGE	17	/* load guarded storage control block */
+#define TIF_ISOLATE_BP_GUEST	18	/* Run KVM guests with isolated BP */
+#define TIF_PER_TRAP		19	/* Need to handle PER trap on exit to usermode */
+#define TIF_31BIT		20	/* 32bit process */
+#define TIF_SINGLE_STEP		21	/* This task is single stepped */
+#define TIF_BLOCK_STEP		22	/* This task is block stepped */
+#define TIF_UPROBE_SINGLESTEP	23	/* This task is uprobe single stepped */
=20
-#define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	BIT(TIF_NEED_RESCHED_LAZY)
-#define _TIF_UPROBE		BIT(TIF_UPROBE)
-#define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
 #define _TIF_ASCE_PRIMARY	BIT(TIF_ASCE_PRIMARY)
-#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
 #define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
 #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
 #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
 #define _TIF_31BIT		BIT(TIF_31BIT)
-#define _TIF_MEMDIE		BIT(TIF_MEMDIE)
-#define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
 #define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)
 #define _TIF_BLOCK_STEP		BIT(TIF_BLOCK_STEP)
 #define _TIF_UPROBE_SINGLESTEP	BIT(TIF_UPROBE_SINGLESTEP)
-#define _TIF_SYSCALL_TRACE	BIT(TIF_SYSCALL_TRACE)
-#define _TIF_SYSCALL_AUDIT	BIT(TIF_SYSCALL_AUDIT)
-#define _TIF_SECCOMP		BIT(TIF_SECCOMP)
-#define _TIF_SYSCALL_TRACEPOINT	BIT(TIF_SYSCALL_TRACEPOINT)
=20
 #endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52c8910ba2ef..70b94e025f41 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -239,6 +239,7 @@ config X86
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA			if X86_32
 	select HAVE_EXIT_THREAD
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_GRAPH_FUNC		if HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread=
_info.h
index 9282465eea21..e71e0e8362ed 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -80,56 +80,42 @@ struct thread_info {
 #endif
=20
 /*
- * thread information flags
- * - these are process state flags that various assembly files
- *   may need to access
+ * Tell the generic TIF infrastructure which bits x86 supports
  */
-#define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling needed */
-#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
-#define TIF_SSBD		6	/* Speculative store bypass disable */
-#define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
-#define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
-#define TIF_UPROBE		12	/* breakpointed or singlestepping */
-#define TIF_PATCH_PENDING	13	/* pending live patching update */
-#define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
-#define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
-#define TIF_NOTSC		16	/* TSC is not accessible in userland */
-#define TIF_NOTIFY_SIGNAL	17	/* signal notifications exist */
-#define TIF_MEMDIE		20	/* is terminating due to OOM killer */
-#define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_POLLING_NRFLAG
+#define HAVE_TIF_SINGLESTEP
+
+#include <asm-generic/thread_info_tif.h>
+
+/* Architecture specific TIF space starts at 16 */
+#define TIF_SSBD		16	/* Speculative store bypass disable */
+#define TIF_SPEC_IB		17	/* Indirect branch speculation mitigation */
+#define TIF_SPEC_L1D_FLUSH	18	/* Flush L1D on mm switches (processes) */
+#define TIF_NEED_FPU_LOAD	19	/* load FPU on return to userspace */
+#define TIF_NOCPUID		20	/* CPUID is not accessible in userland */
+#define TIF_NOTSC		21	/* TSC is not accessible in userland */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
 #define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context =
switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
-#define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
+#define TIF_SINGLESTEP		25	/* reenable singlestep on user return*/
+#define TIF_BLOCKSTEP		26	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
-#define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
-
-#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
-#define _TIF_SSBD		(1 << TIF_SSBD)
-#define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-#define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
-#define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
-#define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
-#define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
-#define _TIF_NOCPUID		(1 << TIF_NOCPUID)
-#define _TIF_NOTSC		(1 << TIF_NOTSC)
-#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
-#define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
-#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
-#define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
-#define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
-#define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
-#define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define TIF_ADDR32		28	/* 32-bit address space on 64 bits */
+
+#define _TIF_SSBD		BIT(TIF_SSBD)
+#define _TIF_SPEC_IB		BIT(TIF_SPEC_IB)
+#define _TIF_SPEC_L1D_FLUSH	BIT(TIF_SPEC_L1D_FLUSH)
+#define _TIF_NEED_FPU_LOAD	BIT(TIF_NEED_FPU_LOAD)
+#define _TIF_NOCPUID		BIT(TIF_NOCPUID)
+#define _TIF_NOTSC		BIT(TIF_NOTSC)
+#define _TIF_IO_BITMAP		BIT(TIF_IO_BITMAP)
+#define _TIF_SPEC_FORCE_UPDATE	BIT(TIF_SPEC_FORCE_UPDATE)
+#define _TIF_FORCED_TF		BIT(TIF_FORCED_TF)
+#define _TIF_BLOCKSTEP		BIT(TIF_BLOCKSTEP)
+#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
+#define _TIF_LAZY_MMU_UPDATES	BIT(TIF_LAZY_MMU_UPDATES)
+#define _TIF_ADDR32		BIT(TIF_ADDR32)
=20
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/thre=
ad_info_tif.h
new file mode 100644
index 000000000000..ee3793e9b1a4
--- /dev/null
+++ b/include/asm-generic/thread_info_tif.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_THREAD_INFO_TIF_H_
+#define _ASM_GENERIC_THREAD_INFO_TIF_H_
+
+#include <vdso/bits.h>
+
+/* Bits 16-31 are reserved for architecture specific purposes */
+
+#define TIF_NOTIFY_RESUME	0	// callback before returning to user
+#define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
+
+#define TIF_SIGPENDING		1	// signal pending
+#define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
+
+#define TIF_NOTIFY_SIGNAL	2	// signal notifications exist
+#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
+
+#define TIF_MEMDIE		3	// is terminating due to OOM killer
+#define _TIF_MEMDIE		BIT(TIF_MEMDIE)
+
+#define TIF_NEED_RESCHED	4	// rescheduling necessary
+#define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
+
+#ifdef HAVE_TIF_NEED_RESCHED_LAZY
+# define TIF_NEED_RESCHED_LAZY	5	// Lazy rescheduling needed
+# define _TIF_NEED_RESCHED_LAZY	BIT(TIF_NEED_RESCHED_LAZY)
+#endif
+
+#ifdef HAVE_TIF_POLLING_NRFLAG
+# define TIF_POLLING_NRFLAG	6	// idle is polling for TIF_NEED_RESCHED
+# define _TIF_POLLING_NRFLAG	BIT(TIF_POLLING_NRFLAG)
+#endif
+
+#define TIF_USER_RETURN_NOTIFY	7	// notify kernel of userspace return
+#define _TIF_USER_RETURN_NOTIFY	BIT(TIF_USER_RETURN_NOTIFY)
+
+#define TIF_UPROBE		8	// breakpointed or singlestepping
+#define _TIF_UPROBE		BIT(TIF_UPROBE)
+
+#define TIF_PATCH_PENDING	9	// pending live patching update
+#define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
+
+#ifdef HAVE_TIF_RESTORE_SIGMASK
+# define TIF_RESTORE_SIGMASK	10	// Restore signal mask in do_signal() */
+# define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
+#endif
+
+#endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */



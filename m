Return-Path: <linux-kernel+bounces-736295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00732B09B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52EBA45D57
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09421E5207;
	Fri, 18 Jul 2025 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YfpUArpo"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8701417578
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818874; cv=none; b=Tu6F3iFb1wKH2OyKJBQ/5wdKFRDJcT01hOyUUAVwqwiMsSk5iJjAQ3LojZpidX56J53PAnsIUyivk9fMax96rN+BbNtnJKxPxbjTKG5qpff5hp1Vj2wkAHzJGETgg/cFcQ0Rx47egPs3dCSZSt1JOs+K9yhwx1EgAtkr9FBUq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818874; c=relaxed/simple;
	bh=WKsmDsvHkM2YdV1l30cRnyx2nzQrtcCoU4uj/sOTtTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZyMAUJ6jDUMdCmgGZEb+7NmDBmGZB0U5WYrAtuUZKYtPCQe/Et+GbzhnrNFD5BVZQt2fRNMgZj4Eb90JUVkJnLRx4BHhY6BSsY2kIwnS+cxKhJ5DN8PiuZ2HL3FvxEJ2RzZe1UDKuryCkoTzeqphkevrhY/4k/MLvsr3idKEBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=YfpUArpo; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nH
	Kf+W5xu8MvnmiXQoE9yWAqzLLh/eEVPFSkiS4AmYk=; b=YfpUArpoofsGNZtGCX
	TBaKTu2BS/+50xY8fCNppyQdL3rC7PsLJriUPd4pR71JqsFOIvoVxx4bNzgNWsei
	8ITmXX/dUaviMkmZwG+ZrW96EnyNb5UxCgA5/F+E1tAd6dhL6B73NQsOhiHUzUjb
	DZKtRfm8W2D9Tj8aug/Zv/AJA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3pzWP5HlopgiRAQ--.35541S2;
	Fri, 18 Jul 2025 14:07:12 +0800 (CST)
From: XingxingQiao <mnlife@126.com>
To: linux-kernel@vger.kernel.org,
	joel.granados@kernel.org,
	bsegall@google.com,
	brauner@kernel.org,
	wei.liu@kernel.org,
	peterz@infradead.org
Cc: XingxingQiao <mnlife@126.com>
Subject: [RFC] rt_ipc: a new IPC mechanism called rt_ipc (real-time IPC)
Date: Fri, 18 Jul 2025 14:06:34 +0800
Message-ID: <20250718060634.469032-1-mnlife@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3pzWP5HlopgiRAQ--.35541S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfKw1DKFWDKF18Gw47Jw18Xwb_yoWrArW5Ko
	W3GF47Cr1xJFnFqFWrGrZ7JrW3XrWDKrW8Gws5tFs7ZF1Ivan8Wayjka13Z3W5ury0vr45
	A3y0qw1fXa1IqFn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRFAp1UUUUU
X-CM-SenderInfo: ppqoxwbh6rjloofrz/1tbi5AeO9mh5tlmEOQACsa

This patch set proposes a new IPC mechanism for the Linux kernel called rt_ipc (real-time IPC).
This is refers to this paper: https://www.usenix.org/legacy/publications/library/proceedings/sf94/full_papers/ford.pdf

Similar in concept to Android Binder or Linux local sockets, rt_ipc is designed
with a 'migrating thread model' to achieve significant real-time performance advantages.

Motivation

The primary motivation behind rt_ipc is to provide a high-performance,
real-time IPC mechanism that addresses the limitations of traditional IPC methods,
particularly concerning latency and priority management. This is achieved by
implementing an IPC mechanism based on the migrating thread model,
where a single thread abstraction moves between tasks during an RPC,
with the server code being passively executed.

The value rt_ipc provides can be elaborated along these axes:

1. Accelerated Communication Performance:

Traditional IPC mechanisms, particularly those based on the 'static thread model',
involve two distinct threads (client and server) and necessitate multiple
thread-to-thread context switches, synchronization, and rescheduling.
This process introduces overhead, including scheduler delays due to wait and
wake-up operations. In contrast, rt_ipc leverages a migrating thread model
where the entire RPC operation is performed by a single thread that temporarily
transitions into the server task. This design eliminates the need for synchronization,
rescheduling, or a full context switch, significantly reducing communication latency.
Preliminary benchmarks demonstrate a notable performance improvement:
for 1,000,000 server-client data exchanges, rt_ipc completes in approximately 1.055 seconds,
whereas traditional Linux local sockets require 3.35 seconds.

2. Optimized Context Management:
The migrating thread model in rt_ipc avoids the overhead of a complete process
context switch. Instead, only a partial context switch is performed where
the kernel switches the address space and a subset of CPU registers,
such as the user stack pointer, without switching threads or priorities,
and without involving the scheduler. This approach simplifies kernel code and
improves RPC performance.

3. Prevention of Priority Inversion:

proxy-exec can solve the scheduling priority inversion problem: https://github.com/johnstultz-work/linux-dev/

But rt_ipc provides different solutions:
In systems utilizing a static thread model, when a high-priority client initiates an RPC,
control is transferred to a separate server thread, which may have its own
independent scheduling parameters and attributes. This can lead to classic problems
such as starvation and priority inversion, where a high-priority client is
forced to contend with lower-priority server threads. rt_ipc addresses this by
allowing the server's function to directly inherit the client process's attributes.
By having the client's thread migrate and execute the server's code,
the client's own computational resources (including its priority and scheduling attributes)
are utilized to provide services to itself. This inherent mechanism within
the migrating thread model effectively mitigates the priority inversion problem.

Signed-off-by: XingxingQiao <mnlife@126.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   3 +
 arch/x86/include/asm/rt_ipc.h          |  78 ++++++
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/kernel/rt_ipc.c               | 361 +++++++++++++++++++++++++
 arch/x86/kernel/signal.c               |  41 +--
 include/linux/rt_ipc.h                 |  11 +
 include/linux/sched.h                  |   7 +-
 init/Kconfig                           |   4 +
 init/init_task.c                       |   4 +
 ipc/Makefile                           |   1 +
 ipc/rt_ipc.c                           | 141 ++++++++++
 kernel/exit.c                          |   4 +-
 kernel/fork.c                          |   7 +-
 kernel/sched/core.c                    |  36 +++
 tools/rt_ipc_userspace/Makefile        |  13 +
 tools/rt_ipc_userspace/rt_ipc_action.c | 162 +++++++++++
 tools/rt_ipc_userspace/rt_ipc_action.h |  56 ++++
 tools/rt_ipc_userspace/rt_ipc_client.c |  89 ++++++
 tools/rt_ipc_userspace/rt_ipc_server.c |  64 +++++
 19 files changed, 1062 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/include/asm/rt_ipc.h
 create mode 100644 arch/x86/kernel/rt_ipc.c
 create mode 100644 include/linux/rt_ipc.h
 create mode 100644 ipc/rt_ipc.c
 create mode 100644 tools/rt_ipc_userspace/Makefile
 create mode 100755 tools/rt_ipc_userspace/rt_ipc_action.c
 create mode 100755 tools/rt_ipc_userspace/rt_ipc_action.h
 create mode 100755 tools/rt_ipc_userspace/rt_ipc_client.c
 create mode 100755 tools/rt_ipc_userspace/rt_ipc_server.c

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index cfb5ca41e30d..1b8b98df9a03 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -391,6 +391,9 @@
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
 467	common	open_tree_attr		sys_open_tree_attr
+468	common	rt_ipc_register		sys_rt_ipc_register
+469	common	rt_ipc_invoke		sys_rt_ipc_invoke
+470	common	rt_ipc_return		sys_rt_ipc_return
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/x86/include/asm/rt_ipc.h b/arch/x86/include/asm/rt_ipc.h
new file mode 100644
index 000000000000..c3dbae8eba4c
--- /dev/null
+++ b/arch/x86/include/asm/rt_ipc.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_RT_IPC_H
+#define _ASM_X86_RT_IPC_H
+
+#include <linux/signal_types.h>
+#include <linux/spinlock_types.h>
+#include <asm/ucontext.h>
+
+#define RT_IPC_ACTIVATION_THREAD_NUM 8
+
+typedef struct rt_ipc_info {
+	size_t		write_size;	/* bytes to write */
+	size_t		write_consumed;	/* bytes consumed by driver */
+	uintptr_t	write_buffer;
+	size_t		read_size;	/* bytes to read */
+	size_t		read_consumed;	/* bytes consumed by driver */
+	uintptr_t	read_buffer;
+} rt_ipc_info_t;
+
+struct rt_ipc_action {
+	void (*entry)(unsigned cmd, rt_ipc_info_t *info);
+	void (*restorer)(void);
+	int flags;
+};
+
+struct rt_ipc_migrate_context {
+	struct task_struct *group_leader;
+	struct files_struct *files;
+	struct fs_struct *fs;
+	struct sighand_struct *sighand;
+	struct signal_struct *signal;
+	struct pid *thread_pid;
+	pid_t pid;
+	pid_t tgid;
+	struct rseq *rseq;
+	u32 rseq_sig;
+	unsigned long rseq_event_mask;
+	struct mm_struct *mm;
+	struct mm_struct *active_mm;
+	struct nsproxy *nsproxy;
+	unsigned long min_flt;
+	unsigned long maj_flt;
+	unsigned long fsbase;
+};
+
+struct rt_ipc_context {
+	struct pt_regs regs;
+	unsigned long trap_nr;
+	unsigned long error_code;
+	unsigned long gs;
+	unsigned long fs;
+	unsigned long cr2;
+};
+
+struct rt_ipc_activation {
+	struct list_head activation_link;
+
+	size_t stack;
+	struct rt_ipc_info __user *info;
+	struct rt_ipc_action *act;
+	struct task_struct *s;
+	struct task_struct *c;
+
+	struct rt_ipc_migrate_context context;
+	struct rt_ipc_context server_ctx;
+	struct rt_ipc_context client_ctx;
+};
+
+struct rt_ipc_frame {
+	void __user *pretcode;
+	struct rt_ipc_info info;
+};
+
+int rt_ipc_config_activation(struct task_struct *task);
+int rt_ipc_migrate_thread(struct rt_ipc_activation *activation, unsigned int cmd, struct rt_ipc_info *info);
+
+extern void rt_ipc_context_switch(struct task_struct *next);
+#endif /* _ASM_X86_RT_IPC_H */
\ No newline at end of file
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0d2a6d953be9..77d401993aeb 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -166,3 +166,5 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
+
+obj-$(CONFIG_RT_IPC)		+= rt_ipc.o
diff --git a/arch/x86/kernel/rt_ipc.c b/arch/x86/kernel/rt_ipc.c
new file mode 100644
index 000000000000..cb24ad603b15
--- /dev/null
+++ b/arch/x86/kernel/rt_ipc.c
@@ -0,0 +1,361 @@
+#define pr_fmt(fmt) "[%s:%d] " fmt, __func__, __LINE__
+
+#include "linux/sched.h"
+#include <linux/signal.h>
+#include <linux/syscalls.h>
+#include <linux/smp.h>
+#include <asm/sighandling.h>
+#include <asm/sigframe.h>
+#include <linux/fdtable.h>
+#include <linux/fs_struct.h>
+#include <linux/moduleparam.h>
+#include <linux/rt_ipc.h>
+
+static bool rt_ipc_dbg = false;
+core_param(rt_ipc_dbg, rt_ipc_dbg, bool, 0644);
+
+#define WARN1(fmt, args...) ({ \
+	WARN(rt_ipc_dbg, fmt, ##args); \
+})
+
+#define pr_info1(fmt, args...) { \
+if (rt_ipc_dbg) \
+	pr_info(fmt, ##args); \
+}
+
+static void pr_context(struct pt_regs *regs)
+{
+	pr_info1("di : %016lx si : %016lx bp : %016lx sp : %016lx\n", regs->di, regs->si, regs->bp, regs->sp);
+	pr_info1("bx : %016lx dx : %016lx cx : %016lx ax : %016lx\n", regs->bx, regs->dx, regs->cx, regs->ax);
+	pr_info1("r8 : %016lx r9 : %016lx r10: %016lx r11: %016lx\n", regs->r8, regs->r9, regs->r10, regs->r11);
+	pr_info1("r12: %016lx r13: %016lx r14: %016lx r15: %016lx\n", regs->r12, regs->r13, regs->r14, regs->r15);
+	pr_info1("trap_nr: %016lx error_code: %016lx ip: %016lx flag: %016lx\n",
+		current->thread.trap_nr, current->thread.error_code, regs->ip, regs->flags);
+	pr_info1("cs: %016x ss: %016x cr2: %016lx cr3: %016lx\n", regs->cs, regs->ss, current->thread.cr2, __read_cr3());
+}
+
+/*
+ * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
+ * alone.  Using this generally makes no sense unless
+ * user_64bit_mode(regs) would return true.
+ */
+static void force_valid_ss(struct pt_regs *regs)
+{
+	u32 ar;
+	asm volatile ("lar %[old_ss], %[ar]\n\t"
+		      "jz 1f\n\t"		/* If invalid: */
+		      "xorl %[ar], %[ar]\n\t"	/* set ar = 0 */
+		      "1:"
+		      : [ar] "=r" (ar)
+		      : [old_ss] "rm" ((u16)regs->ss));
+
+	/*
+	 * For a valid 64-bit user context, we need DPL 3, type
+	 * read-write data or read-write exp-down data, and S and P
+	 * set.  We can't use VERW because VERW doesn't check the
+	 * P bit.
+	 */
+	ar &= AR_DPL_MASK | AR_S | AR_P | AR_TYPE_MASK;
+	if (ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA) &&
+	    ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
+		regs->ss = __USER_DS;
+}
+
+static int x64_setup_rt_ipc_frame(struct rt_ipc_activation *activation, struct pt_regs *regs, unsigned int cmd, struct rt_ipc_info *info)
+{
+	struct rt_ipc_frame __user *frame;
+	void __user *fp = NULL;
+
+	frame = get_sigframe(NULL, regs, sizeof(struct rt_ipc_frame), &fp);
+
+	if (!user_access_begin(frame, sizeof(*frame))) {
+		pr_err("%s:%d handler: 0x%lx\n", __func__, __LINE__, (unsigned long)frame);
+		return -EFAULT;
+	}
+
+	/* Set up to return from userspace.  If provided, use a stub
+	   already in userspace.  */
+	unsafe_put_user(activation->act->restorer, &frame->pretcode, Efault);
+	user_access_end();
+
+	if (copy_to_user(&frame->info, info , sizeof(struct rt_ipc_info)))
+		return -EFAULT;
+
+	pr_info1("&frame->info: %llx", (u64)(&frame->info));
+	/* TODO: process frame->info */
+
+	regs->di = cmd;
+	regs->ax = 0;
+
+	regs->si = (unsigned long)&frame->info;
+
+	regs->ip = (unsigned long)activation->act->entry;
+
+	regs->sp = (unsigned long)frame;
+
+	regs->cs = __USER_CS;
+
+	if (unlikely(regs->ss != __USER_DS))
+		force_valid_ss(regs);
+
+	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+static void save_context(struct rt_ipc_context *ctx, struct pt_regs *regs)
+{
+	ctx->regs = *regs;
+	ctx->trap_nr = current->thread.trap_nr;
+	ctx->error_code = current->thread.error_code;
+	ctx->gs = 0;
+	ctx->fs = 0;
+	ctx->cr2 = current->thread.cr2;
+	/* TODO: fpstate save restore */
+}
+
+static void restore_context(struct rt_ipc_context *ctx, struct pt_regs *regs)
+{
+	current->restart_block.fn = do_no_restart_syscall;
+
+	ctx->regs.flags = (regs->flags & ~FIX_EFLAGS) | (ctx->regs.flags & FIX_EFLAGS);
+
+	*regs = ctx->regs;
+
+	regs->cs |= 0x03;
+	regs->ss |= 0x03;
+	regs->orig_ax = -1;
+}
+
+int rt_ipc_config_activation(struct task_struct *task)
+{
+	struct pt_regs *regs = task_pt_regs(task);
+	struct rt_ipc_activation *activation;
+
+	list_for_each_entry(activation, &task->rt_ipc_activation_free, activation_link) {
+		save_context(&activation->server_ctx, regs);
+
+		pr_info("activation pid: %d stack: %016lx\n", activation->s->pid, activation->stack);
+	}
+
+	pr_context(regs);
+
+	WARN1("%s:%d\n", __func__, __LINE__);
+	pr_info("%s:%d pid: %d\n", __func__, __LINE__, current->pid);
+
+	return 0;
+}
+
+static void save_task_context(struct task_struct *p, struct rt_ipc_activation *act)
+{
+	act->context.files = p->files;
+	act->context.fs = p->fs;
+	act->context.sighand = p->sighand;
+	act->context.signal = p->signal;
+	act->context.thread_pid = p->thread_pid;
+	act->context.pid = p->pid;
+	act->context.tgid = p->tgid;
+	act->context.rseq = p->rseq;
+	act->context.rseq_sig = p->rseq_sig;
+	act->context.rseq_event_mask = p->rseq_event_mask;
+	act->context.mm = p->mm;
+	act->context.active_mm = p->active_mm;
+	act->context.nsproxy = p->nsproxy;
+	act->context.min_flt = p->min_flt;
+	act->context.maj_flt = p->maj_flt;
+	act->context.fsbase = p->thread.fsbase;
+	act->context.group_leader = p->group_leader;
+}
+
+#define CONFIG_SWITCH_THREAD_GROUP 1
+
+static void migrate_thread(struct task_struct *c, struct task_struct *s, struct rt_ipc_activation *act)
+{
+	save_task_context(c, act);
+
+	atomic_inc(&s->files->count);
+	c->files = s->files;
+
+	c->fs->users++;
+	c->fs = s->fs;
+
+	c->rseq = s->rseq;
+	c->rseq_sig = s->rseq_sig;
+	c->rseq_event_mask = s->rseq_event_mask;
+
+	atomic_inc(&s->mm->mm_users);
+	c->mm = s->mm;
+	c->active_mm = s->mm;
+
+	c->nsproxy = s->nsproxy;
+
+	c->min_flt = s->min_flt;
+	c->maj_flt = s->maj_flt;
+
+	/* fsbase register for glibc tls, thread local storage */
+	c->thread.fsbase = s->thread.fsbase;
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wrfsbase(c->thread.fsbase);
+	}
+}
+
+static void restore_thread_from_upcall(struct task_struct *c, struct task_struct *s, struct rt_ipc_activation *act)
+{
+	struct rt_ipc_migrate_context *ctx = &act->context;
+
+	c->files = ctx->files;
+	atomic_dec(&s->files->count);
+
+	c->fs = ctx->fs;
+	s->fs->users--;
+
+	c->rseq = ctx->rseq;
+	c->rseq_sig = ctx->rseq_sig;
+	c->rseq_event_mask = ctx->rseq_event_mask;
+
+	c->mm = ctx->mm;
+	c->active_mm = ctx->active_mm;
+	atomic_dec(&s->mm->mm_users);
+
+	c->nsproxy = ctx->nsproxy;
+
+	c->min_flt = ctx->min_flt;
+	c->maj_flt = ctx->maj_flt;
+
+	c->thread.fsbase = ctx->fsbase;
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wrfsbase(c->thread.fsbase);
+	}
+}
+
+static void upcall_setup(struct rt_ipc_activation *activation, unsigned int cmd, struct rt_ipc_info *info)
+{
+	struct pt_regs *regs = current_pt_regs();
+	unsigned long flags;
+	spinlock_t *lock = &activation->s->sighand->siglock;
+	pr_info1("c->fsbase: %016lx s->fsbase: %016lx\n", activation->c->thread.fsbase, activation->s->thread.fsbase);
+	pr_context(regs);
+	pr_info1("pt_regs: %px\n", regs);
+	WARN1("%s:%d s->mm->mm_users: %d READ_ONCE(c->__state): %d READ_ONCE(s->__state): %d\n",
+		__func__, __LINE__, atomic_read(&activation->s->mm->mm_users), READ_ONCE(activation->c->__state), READ_ONCE(activation->s->__state));
+
+	save_context(&activation->client_ctx, regs);
+
+	spin_lock_irqsave(lock, flags);
+
+	migrate_thread(activation->c, activation->s, activation);
+
+	rt_ipc_context_switch(activation->c);
+	spin_unlock_irqrestore(lock, flags);
+
+	restore_context(&activation->server_ctx, regs);
+
+	regs->sp = activation->stack;
+
+	if (x64_setup_rt_ipc_frame(activation, regs, cmd, info) < 0) {
+		pr_err("setup rt ipc frame failed\n");
+		goto out;
+	}
+
+	pr_context(regs);
+
+	pr_info1("c->fsbase: %016lx s->fsbase: %016lx\n", activation->c->thread.fsbase, activation->s->thread.fsbase);
+	WARN1("%s:%d\n", __func__, __LINE__);
+	pr_info1("%s:%d handler: %016lx %016lx\n", __func__, __LINE__, (size_t)activation->act->entry, (size_t)activation->act->restorer);
+
+	return;
+
+out:
+	signal_fault(regs, activation, "rt_ipc_migrate_thread");
+}
+
+int rt_ipc_migrate_thread(struct rt_ipc_activation *activation, unsigned int cmd, struct rt_ipc_info *info)
+{
+	activation->c = current;
+
+	upcall_setup(activation, cmd, info);
+
+	list_add(&activation->activation_link, &current->rt_ipc_activation_in_use);
+
+	return 0;
+}
+
+static void clear_activation_info(struct rt_ipc_activation *activation)
+{
+	activation->c = NULL;
+}
+
+static int rt_ipc_return(struct pt_regs *regs, struct rt_ipc_info *info)
+{
+	unsigned long flags;
+	spinlock_t *sighand_lock;
+	spinlock_t *rt_ipc_lock;
+
+	struct rt_ipc_activation *activation =
+		list_first_entry_or_null(&current->rt_ipc_activation_in_use, struct rt_ipc_activation, activation_link);
+	if (!activation) {
+		pr_err("invaild activation\n");
+		return -EFAULT;
+	}
+
+	sighand_lock = &activation->s->sighand->siglock;
+	rt_ipc_lock = &activation->s->group_leader->rt_ipc_lock;
+
+	spin_lock_irqsave(sighand_lock, flags);
+
+	restore_thread_from_upcall(activation->c, activation->s, activation);
+	rt_ipc_context_switch(activation->c);
+
+	spin_unlock_irqrestore(sighand_lock, flags);
+
+	restore_context(&activation->client_ctx, regs);
+
+	spin_lock_irqsave(rt_ipc_lock, flags);
+	clear_activation_info(activation);
+	list_move(&activation->activation_link, &activation->s->group_leader->rt_ipc_activation_free);
+	spin_unlock_irqrestore(rt_ipc_lock, flags);
+
+	pr_info1("READ_ONCE(c->__state): %d READ_ONCE(s->__state): %d current: %d\n",
+		READ_ONCE(current->__state), READ_ONCE(activation->s->__state), READ_ONCE(current->__state));
+	WARN1("%s:%d\n", __func__, __LINE__);
+	pr_info1("c->fsbase: %016lx s->fsbase: %016lx\n", current->thread.fsbase, activation->s->thread.fsbase);
+	pr_context(regs);
+
+	if (copy_to_user(activation->info, info , sizeof(struct rt_ipc_info))) {
+		pr_err("activation->info: %lx info: %lx", (size_t)activation->info, (size_t)info);
+		return -EFAULT;
+	}
+	return 0;
+}
+
+SYSCALL_DEFINE0(rt_ipc_return)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_ipc_frame __user *frame;
+	struct rt_ipc_info info;
+
+	frame = (struct rt_ipc_frame __user *)(regs->sp - sizeof(long));
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+
+	pr_info1("&frame->info: %lx regs->si: %lx", (size_t)(&frame->info), regs->si);
+
+	if (copy_from_user(&info, &frame->info, sizeof(info))) {
+		goto badframe;
+	}
+	/* TODO: process frame->info */
+
+	if (rt_ipc_return(regs, &info) < 0) {
+		goto badframe;
+	}
+
+	regs->ax = 0;
+
+	return regs->ax;
+
+badframe:
+	signal_fault(regs, frame, "rt_ipc_return");
+	return 0;
+}
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 2404233336ab..788be933768f 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -94,8 +94,8 @@ void __user *
 get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	     void __user **fpstate)
 {
-	struct k_sigaction *ka = &ksig->ka;
-	int ia32_frame = is_ia32_frame(ksig);
+	struct k_sigaction *ka;
+	int ia32_frame = ksig ? is_ia32_frame(ksig) : 0;
 	/* Default to using normal stack */
 	bool nested_altstack = on_sig_stack(regs->sp);
 	bool entering_altstack = false;
@@ -108,25 +108,28 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	if (!ia32_frame)
 		sp -= 128;
 
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ka->sa.sa_flags & SA_ONSTACK) {
-		/*
-		 * This checks nested_altstack via sas_ss_flags(). Sensible
-		 * programs use SS_AUTODISARM, which disables that check, and
-		 * programs that don't use SS_AUTODISARM get compatible.
-		 */
-		if (sas_ss_flags(sp) == 0) {
-			sp = current->sas_ss_sp + current->sas_ss_size;
+	if (ksig) {
+		 ka = &ksig->ka;
+		/* This is the X/Open sanctioned signal stack switching.  */
+		if (ka->sa.sa_flags & SA_ONSTACK) {
+			/*
+			* This checks nested_altstack via sas_ss_flags(). Sensible
+			* programs use SS_AUTODISARM, which disables that check, and
+			* programs that don't use SS_AUTODISARM get compatible.
+			*/
+			if (sas_ss_flags(sp) == 0) {
+				sp = current->sas_ss_sp + current->sas_ss_size;
+				entering_altstack = true;
+			}
+		} else if (ia32_frame &&
+			!nested_altstack &&
+			regs->ss != __USER_DS &&
+			!(ka->sa.sa_flags & SA_RESTORER) &&
+			ka->sa.sa_restorer) {
+			/* This is the legacy signal stack switching. */
+			sp = (unsigned long) ka->sa.sa_restorer;
 			entering_altstack = true;
 		}
-	} else if (ia32_frame &&
-		   !nested_altstack &&
-		   regs->ss != __USER_DS &&
-		   !(ka->sa.sa_flags & SA_RESTORER) &&
-		   ka->sa.sa_restorer) {
-		/* This is the legacy signal stack switching. */
-		sp = (unsigned long) ka->sa.sa_restorer;
-		entering_altstack = true;
 	}
 
 	sp = fpu__alloc_mathframe(sp, ia32_frame, &buf_fx, &math_size);
diff --git a/include/linux/rt_ipc.h b/include/linux/rt_ipc.h
new file mode 100644
index 000000000000..6089ec12515d
--- /dev/null
+++ b/include/linux/rt_ipc.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_RT_IPC_H__
+#define __LINUX_RT_IPC_H__
+
+#ifdef CONFIG_RT_IPC
+#include <asm/rt_ipc.h>
+
+void rt_ipc_deregister(struct task_struct *tsk);
+#endif
+
+#endif /* __LINUX_RT_IPC_H__ */
\ No newline at end of file
diff --git a/include/linux/sched.h b/include/linux/sched.h
index aa9c5be7a632..c44ac36d756d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -47,6 +47,7 @@
 #include <linux/uidgid_types.h>
 #include <linux/tracepoint-defs.h>
 #include <asm/kmap_size.h>
+#include <linux/rt_ipc.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -1625,7 +1626,11 @@ struct task_struct {
 #ifdef CONFIG_RETHOOK
 	struct llist_head               rethooks;
 #endif
-
+#ifdef CONFIG_RT_IPC
+	struct list_head rt_ipc_activation_free;
+	struct list_head rt_ipc_activation_in_use;
+	spinlock_t rt_ipc_lock;
+#endif
 #ifdef CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH
 	/*
 	 * If L1D flush is supported on mm context switch
diff --git a/init/Kconfig b/init/Kconfig
index 666783eb50ab..6a4f5be7d934 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -437,6 +437,10 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
+config RT_IPC
+	bool "Migrating thread model"
+	def_bool n
+
 config POSIX_MQUEUE
 	bool "POSIX Message Queues"
 	depends on NET
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..0ff488738cef 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -143,6 +143,10 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.timer_slack_ns = 50000, /* 50 usec default slack */
 	.thread_pid	= &init_struct_pid,
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
+#ifdef CONFIG_RT_IPC
+	.rt_ipc_activation_in_use = LIST_HEAD_INIT(init_task.rt_ipc_activation_in_use),
+	.rt_ipc_activation_free = LIST_HEAD_INIT(init_task.rt_ipc_activation_free),
+#endif
 #ifdef CONFIG_AUDIT
 	.loginuid	= INVALID_UID,
 	.sessionid	= AUDIT_SID_UNSET,
diff --git a/ipc/Makefile b/ipc/Makefile
index c2558c430f51..460b45d579a3 100644
--- a/ipc/Makefile
+++ b/ipc/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_POSIX_MQUEUE) += mqueue.o msgutil.o
 obj-$(CONFIG_IPC_NS) += namespace.o
 obj-$(CONFIG_POSIX_MQUEUE_SYSCTL) += mq_sysctl.o
 
+obj-$(CONFIG_RT_IPC) += rt_ipc.o
diff --git a/ipc/rt_ipc.c b/ipc/rt_ipc.c
new file mode 100644
index 000000000000..0d61e33dc7c8
--- /dev/null
+++ b/ipc/rt_ipc.c
@@ -0,0 +1,141 @@
+#define pr_fmt(fmt) "[%s:%d] " fmt, __func__, __LINE__
+
+#include <linux/rculist.h>
+#include <linux/idr.h>
+#include <linux/syscalls.h>
+#include <linux/rt_ipc.h>
+
+static __maybe_unused __cacheline_aligned_in_smp DEFINE_SPINLOCK(rt_ipc_lock);
+
+void rt_ipc_deregister(struct task_struct *tsk)
+{
+	struct rt_ipc_activation *activation, *tmp;
+	struct rt_ipc_action *act = NULL;
+
+	list_for_each_entry_safe(activation, tmp, &tsk->rt_ipc_activation_free, activation_link) {
+		act = activation->act;
+		list_del_init(&activation->activation_link);
+		kfree(activation);
+	}
+
+	if (act)
+		kfree(act);
+
+	pr_debug("task: %s tsk->pid: %d\n", tsk->comm, tsk->pid);
+}
+
+SYSCALL_DEFINE1(rt_ipc_register, const struct rt_ipc_action __user *, act)
+{
+	struct rt_ipc_action *kact;
+	struct rt_ipc_activation *activation;
+	struct task_struct *p;
+	spinlock_t *rt_ipc_lock, *sighand_lock;
+	int ret;
+
+	if (!act) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	kact = kmalloc(sizeof(*kact), GFP_KERNEL);
+	if (!kact) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (copy_from_user(kact, act, sizeof(*act))) {
+		ret = -EFAULT;
+		goto out_free_act;
+	}
+
+	rt_ipc_lock = &current->group_leader->rt_ipc_lock;
+	sighand_lock = &current->group_leader->sighand->siglock;
+
+	spin_lock_init(&current->group_leader->rt_ipc_lock);
+
+	spin_lock_irq(sighand_lock);
+
+	for_each_thread(current, p) {
+		activation = kzalloc(sizeof(*activation), GFP_KERNEL);
+		BUG_ON(activation == NULL);
+
+		activation->stack = round_down(task_pt_regs(p)->sp, 128) - 8;
+		activation->s = p;
+		activation->act = kact;
+
+		spin_lock_irq(rt_ipc_lock);
+		list_add_tail(&activation->activation_link, &current->group_leader->rt_ipc_activation_free);
+		spin_unlock_irq(rt_ipc_lock);
+	}
+
+	spin_unlock_irq(sighand_lock);
+
+	ret = rt_ipc_config_activation(current->group_leader);
+	if (ret < 0) {
+		// TODO: activation free
+		goto out_free_act;
+	}
+
+	return ret;
+
+out_free_act:
+	kfree(act);
+out:
+	return ret;
+}
+
+static struct rt_ipc_activation *get_available_activation(struct task_struct *task)
+{
+	struct rt_ipc_activation *activation, *tmp;
+
+	list_for_each_entry_safe(activation, tmp, &task->rt_ipc_activation_free, activation_link) {
+		list_del_init(&activation->activation_link);
+		return activation;
+	}
+
+	return NULL;
+}
+
+SYSCALL_DEFINE3(rt_ipc_invoke, pid_t, pid, unsigned int __user, cmd, size_t __user *, args)
+{
+	struct rt_ipc_activation *activation;
+	spinlock_t *lock;
+	struct task_struct *p;
+	unsigned long flags;
+	int errno = -EINVAL;
+	struct rt_ipc_info info;
+
+	if (copy_from_user(&info, args, sizeof(info))) {
+		return -EFAULT;
+	}
+
+	if (pid < 0)
+		return errno;
+
+	rcu_read_lock();
+	p = pid_task(find_vpid(pid), PIDTYPE_PID);
+	rcu_read_unlock();
+
+	if (!p)
+		return -ESRCH;
+
+	lock = &p->group_leader->rt_ipc_lock;
+
+	spin_lock_irqsave(lock, flags);
+
+	activation = get_available_activation(p->group_leader);
+	if (!activation) {
+		spin_unlock_irqrestore(lock, flags);
+		return errno;
+	}
+
+	spin_unlock_irqrestore(lock, flags);
+
+	activation->info = (void *)args;
+
+	pr_debug("stack: %016lx pid: %d\n", activation->stack, current->pid);
+
+	errno = rt_ipc_migrate_thread(activation, cmd, &info);
+
+	return errno;
+}
\ No newline at end of file
diff --git a/kernel/exit.c b/kernel/exit.c
index bb184a67ac73..4f5fe3e50b35 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -963,7 +963,9 @@ void __noreturn do_exit(long code)
 	exit_task_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);
-
+#ifdef CONFIG_RT_IPC
+	rt_ipc_deregister(tsk);
+#endif
 	sched_autogroup_exit_task(tsk);
 	cgroup_exit(tsk);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38b..09c407394337 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -122,6 +122,8 @@
 
 #include <kunit/visibility.h>
 
+#include <linux/rt_ipc.h>
+
 /*
  * Minimum number of threads to boot the kernel
  */
@@ -2418,7 +2420,10 @@ __latent_entropy struct task_struct *copy_process(
 	user_events_fork(p, clone_flags);
 
 	copy_oom_score_adj(clone_flags, p);
-
+#ifdef CONFIG_RT_IPC
+	INIT_LIST_HEAD(&p->rt_ipc_activation_in_use);
+	INIT_LIST_HEAD(&p->rt_ipc_activation_free);
+#endif
 	return p;
 
 bad_fork_core_free:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81c6df746df1..7835bfc1f93c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5400,6 +5400,42 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	return finish_task_switch(prev);
 }
 
+#ifdef CONFIG_RT_IPC
+void rt_ipc_context_switch(struct task_struct *next)
+{
+	struct task_struct *prev;
+	unsigned long flags;
+	struct rq *rq;
+	int cpu;
+
+	cpu = smp_processor_id();
+	rq = cpu_rq(cpu);
+	prev = rq->curr;
+
+	raw_spin_rq_lock_irqsave(rq, flags);
+
+	membarrier_switch_mm(rq, prev->active_mm, next->mm);
+	/*
+	 * sys_membarrier() requires an smp_mb() between setting
+	 * rq->curr / membarrier_switch_mm() and returning to userspace.
+	 *
+	 * The below provides this either through switch_mm(), or in
+	 * case 'prev->active_mm == next->mm' through
+	 * finish_task_switch()'s mmdrop().
+	 */
+	switch_mm_irqs_off(prev->active_mm, next->mm, next);
+	lru_gen_use_mm(next->mm);
+
+	/* switch_mm_cid() requires the memory barriers above. */
+	// switch_mm_cid(rq, prev, next);
+
+	__switch_to(prev, next);
+	barrier();
+
+	raw_spin_rq_unlock_irqrestore(rq, flags);
+}
+#endif
+
 /*
  * nr_running and nr_context_switches:
  *
diff --git a/tools/rt_ipc_userspace/Makefile b/tools/rt_ipc_userspace/Makefile
new file mode 100644
index 000000000000..2e0656bb1e3f
--- /dev/null
+++ b/tools/rt_ipc_userspace/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS = -Wall -Wextra -g -I.
+PROGS := rt_ipc_server rt_ipc_client
+
+all: $(PROGS)
+%: %.c
+	$(CC) $(CFLAGS) rt_ipc_action.c -o $@ $^
+
+clean:
+	$(RM) $(PROGS)
+
+.PHONY: all clean
diff --git a/tools/rt_ipc_userspace/rt_ipc_action.c b/tools/rt_ipc_userspace/rt_ipc_action.c
new file mode 100755
index 000000000000..ea1217408a9b
--- /dev/null
+++ b/tools/rt_ipc_userspace/rt_ipc_action.c
@@ -0,0 +1,162 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <assert.h>
+#include <errno.h>
+#include <pthread.h>
+#include <limits.h>
+#include <sys/resource.h>
+#include <sys/sysinfo.h>
+#include <sys/mman.h>
+
+#include "rt_ipc_action.h"
+
+#define RT_IPC_RESTORER 0x04000000
+
+#define LP_SIZE "8"
+# define CFI_STRINGIFY(Name) CFI_STRINGIFY2 (Name)
+# define CFI_STRINGIFY2(Name) #Name
+# define attribute_hidden __attribute__ ((visibility ("hidden")))
+
+/* Align a value by rounding down to closest size.
+   e.g. Using size of 4096, we get this behavior:
+	{4095, 4096, 4097} = {0, 4096, 4096}.  */
+#define ALIGN_DOWN(base, size)	((base) & -((__typeof__ (base)) (size)))
+
+/* Align a value by rounding up to closest size.
+   e.g. Using size of 4096, we get this behavior:
+	{4095, 4096, 4097} = {4096, 4096, 8192}.
+
+  Note: The size argument has side effects (expanded multiple times).  */
+#define ALIGN_UP(base, size)	ALIGN_DOWN ((base) + (size) - 1, (size))
+
+#define UCHAR_WIDTH 8
+//#define ULONG_WIDTH 64
+#define __NSIG_WORDS (ALIGN_UP ((_NSIG - 1), ULONG_WIDTH) / ULONG_WIDTH)
+#define __NSIG_BYTES (__NSIG_WORDS * (ULONG_WIDTH / UCHAR_WIDTH))
+
+#define STUB(act, sigsetsize) (sigsetsize)
+
+#ifdef RT_IPC_RESTORER
+#define HAS_RT_IPC_RESTORER 1
+#endif
+
+extern void restore_rt (void) asm ("__restore_rt") attribute_hidden;
+
+#define SET_RT_IPC_RESTORER(kact, act)			\
+  (kact)->flags = (act)->flags | RT_IPC_RESTORER;	\
+  (kact)->rt_ipc_restorer = &restore_rt
+
+#define do_cfa_expr						\
+  "	.byte 0x0f\n"		/* DW_CFA_def_cfa_expression */	\
+  "	.uleb128 2f-1f\n"	/* length */			\
+  "1:	.byte 0x77\n"		/* DW_OP_breg7 */		\
+  "	.byte 0x06\n"		/* DW_OP_deref */		\
+  "2:"
+
+#define do_expr(regno, offset)					\
+  "	.byte 0x10\n"		/* DW_CFA_expression */		\
+  "	.uleb128 " CFI_STRINGIFY (regno) "\n"			\
+  "	.uleb128 2f-1f\n"	/* length */			\
+  "1:	.byte 0x77\n"		/* DW_OP_breg7 */		\
+  "2:"
+
+#define RESTORE(name, syscall) RESTORE2 (name, syscall)
+# define RESTORE2(name, syscall) \
+asm									\
+  (									\
+   /* `nop' for debuggers assuming `call' should not disalign the code.  */ \
+   "	nop\n"								\
+   ".align 16\n"							\
+   ".LSTART_" #name ":\n"						\
+   "	.type __" #name ",@function\n"					\
+   "__" #name ":\n"							\
+   "	movq $" #syscall ", %rax\n"					\
+   "	syscall\n"							\
+   ".LEND_" #name ":\n"							\
+   ".section .eh_frame,\"a\",@progbits\n"				\
+   ".LSTARTFRAME_" #name ":\n"						\
+   "	.long .LENDCIE_" #name "-.LSTARTCIE_" #name "\n"		\
+   ".LSTARTCIE_" #name ":\n"						\
+   "	.long 0\n"	/* CIE ID */					\
+   "	.byte 1\n"	/* Version number */				\
+   "	.string \"zRS\"\n" /* NUL-terminated augmentation string */	\
+   "	.uleb128 1\n"	/* Code alignment factor */			\
+   "	.sleb128 -8\n"	/* Data alignment factor */			\
+   "	.uleb128 16\n"	/* Return address register column (rip) */	\
+   /* Augmentation value length */					\
+   "	.uleb128 .LENDAUGMNT_" #name "-.LSTARTAUGMNT_" #name "\n"	\
+   ".LSTARTAUGMNT_" #name ":\n"						\
+   "	.byte 0x1b\n"	/* DW_EH_PE_pcrel|DW_EH_PE_sdata4. */		\
+   ".LENDAUGMNT_" #name ":\n"						\
+   "	.align " LP_SIZE "\n"						\
+   ".LENDCIE_" #name ":\n"						\
+   "	.long .LENDFDE_" #name "-.LSTARTFDE_" #name "\n" /* FDE len */	\
+   ".LSTARTFDE_" #name ":\n"						\
+   "	.long .LSTARTFDE_" #name "-.LSTARTFRAME_" #name "\n" /* CIE */	\
+   /* `LSTART_' is subtracted 1 as debuggers assume a `call' here.  */	\
+   "	.long (.LSTART_" #name "-1)-.\n" /* PC-relative start addr.  */	\
+   "	.long .LEND_" #name "-(.LSTART_" #name "-1)\n"			\
+   "	.uleb128 0\n"			/* FDE augmentation length */	\
+   do_cfa_expr								\
+   do_expr (8 /* r8 */, oR8)						\
+   do_expr (9 /* r9 */, oR9)						\
+   do_expr (10 /* r10 */, oR10)						\
+   do_expr (11 /* r11 */, oR11)						\
+   do_expr (12 /* r12 */, oR12)						\
+   do_expr (13 /* r13 */, oR13)						\
+   do_expr (14 /* r14 */, oR14)						\
+   do_expr (15 /* r15 */, oR15)						\
+   do_expr (5 /* rdi */, oRDI)						\
+   do_expr (4 /* rsi */, oRSI)						\
+   do_expr (6 /* rbp */, oRBP)						\
+   do_expr (3 /* rbx */, oRBX)						\
+   do_expr (1 /* rdx */, oRDX)						\
+   do_expr (0 /* rax */, oRAX)						\
+   do_expr (2 /* rcx */, oRCX)						\
+   do_expr (7 /* rsp */, oRSP)						\
+   do_expr (16 /* rip */, oRIP)						\
+   /* libgcc-4.1.1 has only `DWARF_FRAME_REGISTERS == 17'.  */		\
+   /* do_expr (49 |* rflags *|, oEFL) */				\
+   /* `cs'/`ds'/`fs' are unaligned and a different size.  */		\
+   /* gas: Error: register save offset not a multiple of 8  */		\
+   "	.align " LP_SIZE "\n"						\
+   ".LENDFDE_" #name ":\n"						\
+   "	.previous\n"							\
+   );
+/* The return code for realtime-signals.  */
+RESTORE (restore_rt, __NR_rt_ipc_return)
+
+void *test(void __maybe_unused *data)
+{
+    while (1) {
+        //printf("[%s:%d] pid: %d tid: %d ppid: %d\n", __func__, __LINE__, getpid(), gettid(), getppid());
+        sleep(INT_MAX);
+    }
+    return NULL;
+}
+
+int rt_ipc_action(const struct rt_ipc_action *act)
+{
+    int result;
+    struct rt_ipc_action kact;
+    pthread_t ptrd;
+
+    if (!act) {
+        return -EINVAL;
+    }
+
+    kact.activation = act->activation;
+
+    SET_RT_IPC_RESTORER (&kact, act);
+
+    for (int i = 0; i < RT_IPC_ACTIVATION_THREAD_NUM; ++i) {
+        int res = pthread_create(&ptrd, NULL, test, NULL);
+        assert(res == 0);
+    }
+
+    //pr_info("pid: %d activation: %p rt_ipc_restorer: %p\n", getpid(), kact.activation, kact.rt_ipc_restorer);
+
+    result = syscall(SYS_rt_ipc_register, act ? &kact : NULL);
+    return result;
+}
diff --git a/tools/rt_ipc_userspace/rt_ipc_action.h b/tools/rt_ipc_userspace/rt_ipc_action.h
new file mode 100755
index 000000000000..ce1d11eb8530
--- /dev/null
+++ b/tools/rt_ipc_userspace/rt_ipc_action.h
@@ -0,0 +1,56 @@
+#ifndef __RT_IPC_ACTION_H
+#define __RT_IPC_ACTION_H
+#include <stddef.h>
+
+#define RT_IPC_ACTIVATION_THREAD_NUM 8
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+typedef struct rt_ipcinfo {
+	size_t write_size;
+	size_t write_buffer;
+	size_t read_size;
+	size_t read_buffer;
+} rt_ipcinfo_t;
+
+struct rt_ipc_action {
+	void (*activation)(unsigned cmd, rt_ipcinfo_t *info);
+	void (*rt_ipc_restorer)(void);
+	int flags;
+};
+
+#define __NR_rt_ipc_register 468
+#define __NR_rt_ipc_invoke 469
+#define __NR_rt_ipc_return 470
+
+#define SYS_rt_ipc_register __NR_rt_ipc_register
+#define SYS_rt_ipc_invoke __NR_rt_ipc_invoke
+#define SYS_rt_ipc_return __NR_rt_ipc_return
+
+#define NONE "\033[m"
+#define RED "\033[0;32;31m"
+#define LIGHT_RED "\033[1;31m"
+#define GREEN "\033[0;32;32m"
+#define LIGHT_GREEN "\033[1;32m"
+#define BLUE "\033[0;32;34m"
+#define LIGHT_BLUE "\033[1;34m"
+#define DARY_GRAY "\033[1;30m"
+#define CYAN "\033[0;36m"
+#define LIGHT_CYAN "\033[1;36m"
+#define PURPLE "\033[0;35m"
+#define LIGHT_PURPLE "\033[1;35m"
+#define BROWN "\033[0;33m"
+#define YELLOW "\033[1;33m"
+#define LIGHT_GRAY "\033[0;37m"
+#define WHITE "\033[1;37m"
+
+#if 0
+#define pr_info(fmt, ...) printf("[%s:%d]: " fmt, __func__, __LINE__, ##__VA_ARGS__)
+#define pr_err(fmt, ...) printf(RED"[%s:%d]: " fmt NONE, __func__, __LINE__, ##__VA_ARGS__)
+#else
+#define pr_info(fmt, ...) printf(fmt, ##__VA_ARGS__)
+#define pr_err(fmt, ...) printf(RED fmt NONE, ##__VA_ARGS__)
+#endif
+
+int rt_ipc_action(const struct rt_ipc_action *act);
+
+#endif /* __RT_IPC_ACTION_H */
diff --git a/tools/rt_ipc_userspace/rt_ipc_client.c b/tools/rt_ipc_userspace/rt_ipc_client.c
new file mode 100755
index 000000000000..c0af767a9829
--- /dev/null
+++ b/tools/rt_ipc_userspace/rt_ipc_client.c
@@ -0,0 +1,89 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/time.h>
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+
+#include "rt_ipc_action.h"
+
+#define PAGE_SIZE (1 << 12)
+
+#define STACK_SIZE (PAGE_SIZE << 1)
+
+/*
+int syscall(SYS_rt_sigqueueinfo, pid_t tgid, int sig, siginfo_t *info);
+int syscall(SYS_rt_tgsigqueueinfo, pid_t tgid, pid_t tid, int sig, siginfo_t *info);
+*/
+
+#define handle_error_en(en, msg) \
+               do { errno = en; perror(msg); exit(EXIT_FAILURE); } while (0)
+
+static volatile unsigned long long cnt;
+
+static void *thread_entry(void *args)
+{
+    struct rt_ipcinfo info;
+    unsigned int cmd = 0x5a5a;
+    int ret;
+    info.write_size = 1234;
+
+    while (cnt++ != 100000) {
+        ret = syscall(SYS_rt_ipc_invoke, *(int *)args, cmd, &info);
+        if (ret < 0)
+            printf("exit from migrating %d\n", gettid());
+        //sleep(1);
+    }
+    printf("rt_ipc client: %ld\n", info.write_size);
+    //sleep(0);
+    return NULL;
+}
+
+int find_pid_by_name(const char *process_name) {
+    char command[256];
+    snprintf(command, sizeof(command), "pgrep %s", process_name);
+
+    FILE *fp = popen(command, "r");
+    if (fp == NULL) {
+        perror("Error opening pipe");
+        return -1;
+    }
+
+    int pid;
+    if (fscanf(fp, "%d", &pid) == 1) {
+        pclose(fp);
+        return pid;
+    } else {
+        pclose(fp);
+        return -1; // Process not found
+    }
+}
+
+int main(int argc, char **argv)
+{
+    pid_t pid;
+    struct timeval t1, t2;
+
+    pid = find_pid_by_name("server_rt_ipc");
+    if (pid < 0) {
+        return pid;
+    }
+
+    printf("client pid %d send syscall SYS_rt_ipc_migrating to server pid: %d\n", getpid(), pid);
+
+    gettimeofday(&t1, NULL);
+
+    thread_entry(&pid);
+
+    gettimeofday(&t2, NULL);
+
+    __time_t sec = t2.tv_sec - t1.tv_sec;
+    __suseconds_t usec = sec * 1000000 + t2.tv_usec - t1.tv_usec;
+
+    printf("time usage sec: %lds usec: %ldus pid %d\n", sec, usec, getpid());
+
+    return 0;
+}
diff --git a/tools/rt_ipc_userspace/rt_ipc_server.c b/tools/rt_ipc_userspace/rt_ipc_server.c
new file mode 100755
index 000000000000..c0b75269ea9e
--- /dev/null
+++ b/tools/rt_ipc_userspace/rt_ipc_server.c
@@ -0,0 +1,64 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <errno.h>
+
+#include "rt_ipc_action.h"
+
+void entry(unsigned cmd, rt_ipcinfo_t *info);
+
+int main(void)
+{
+    struct rt_ipc_action act;
+
+    act.activation = entry;
+    int ret = rt_ipc_action(&act);
+
+    if (ret < 0) {
+        pr_err("fatal: rt ipc action error\n");
+        return -EINVAL;
+    }
+
+    pr_info("pid: %d entry: %p\n", getpid(), entry);
+
+    while(1)
+    {
+        sleep(INT_MAX);
+        pr_info("wait for the signal\n");
+    }
+
+    return 0;
+}
+
+volatile int g_test;
+#define CONFIG_FILE_OP 0
+
+static volatile unsigned long long cnt;
+
+void entry(unsigned int cmd, rt_ipcinfo_t *info)
+{
+    g_test = gettid();
+#if CONFIG_FILE_OP
+    FILE *f = fopen("/tmp/123.txt", "w+");
+    if (f == NULL) {
+	    pr_info("fopen failed with error: %d\n", errno);
+	    return;
+    }
+    char buf[100];
+    int a = 0;
+    int b = 1;
+    a = b;
+    b = a;
+    g_test = getpid();
+
+    snprintf(buf, 100, "receive cmd %x pid: %d g_test; %d\n", cmd, getpid(), g_test);
+    fwrite(buf, strlen(buf) + 1, 1, f);
+    fclose(f);
+#endif
+    info->write_size = cnt;
+    if (++cnt % 10000 == 0)
+        pr_info("message from client: pid: %d cmd: %08x cnt: %lld, info->write_size: %ld\n", g_test, cmd, cnt, info->write_size);
+    //sleep(5);
+}
-- 
2.43.0



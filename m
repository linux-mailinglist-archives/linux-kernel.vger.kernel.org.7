Return-Path: <linux-kernel+bounces-871105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252DC0C742
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BF018A48CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2F4311977;
	Mon, 27 Oct 2025 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jTEuZnJI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mj2BVX0d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA13311589
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554697; cv=none; b=fDWr78rsNBuUUZgW1QIMX0mO1xqY6idQTETxBc3ug011A+yeb6+fNmBg3rXc8vfuJ02HlnjV+lhlS2xQsoi3vMeS96unZhE9oSYs/eAoko7rfK38CmkGDcQqPRGULRZb1FmHgibD9Jg7S9ulEQiRoOyk7DPL0tjKDH6yeBNi1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554697; c=relaxed/simple;
	bh=B+Y+pOXitQoaWLJ1kcDAfzI0A9do8rK8pEI6PVmIT1g=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lOoUz9+trujiV4hdJA5cHVQAYyxQaUzgRbkzz9P4/+7LUuNXrQ78MwtoCqsN55JWR93Rxs9Yh7kLCZKy2jcXmuhSNk1TewCR5ZCOeXUYwFK92BXFtTXj45kvfBAuIRiFRH3jecNm3P8OuKxa5utVTjcZdNMu03UHxlpgyVw0TuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jTEuZnJI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mj2BVX0d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084307.027916598@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KX9qzElSLVZczNJHncTxzo6fDg8+4rvI+ShPqh1Vaw4=;
	b=jTEuZnJIGLujry9LcleT2VLsPVFX2rzpJYTx07hkkiLx5gBP7NeGkns4VCxqbPzsawI2kZ
	MPv5/8Otb/PIQKiG04EDkIuuynednuAl21VHd2JGyzMbD957DDco2cJMdpSGsYDOnGQ+pz
	uDNZPo20yYlW0b4hZlfz7RsaEgN44Id2VmyO/JUOUssOHHj57ebb6I62i+E2FxYLFuVmrv
	lOr8TrwG5VRZrCMhHK3oahLF27+EAGRRflFwftjDYTbWTfuz54W8q0gML0KSf+pq5RYv9c
	132IIU0o09wPl5/EbuUQ5CCKVDrEfCqtpHorU4+inOz4H3uO5jvdBGIPs5XzxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KX9qzElSLVZczNJHncTxzo6fDg8+4rvI+ShPqh1Vaw4=;
	b=mj2BVX0d+R2jFcDuDd6L2f4nvREY02u4LAGtDYQKQwq4BeJ1XHEOgiPAQ2fAnEiCUToJxn
	EkqEg41VwGNPbrAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V6 17/31] rseq: Expose lightweight statistics in debugfs
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:52 +0100 (CET)

Analyzing the call frequency without actually using tracing is helpful for
analysis of this infrastructure. The overhead is minimal as it just
increments a per CPU counter associated to each operation.

The debugfs readout provides a racy sum of all counters.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/rseq.h       |   16 ---------
 include/linux/rseq_entry.h |   49 +++++++++++++++++++++++++++
 init/Kconfig               |   12 ++++++
 kernel/rseq.c              |   79 +++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 133 insertions(+), 23 deletions(-)
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -29,21 +29,6 @@ static inline void rseq_sched_switch_eve
 	}
 }
 
-static __always_inline void rseq_exit_to_user_mode(void)
-{
-	struct rseq_event *ev = &current->rseq.event;
-
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
-		WARN_ON_ONCE(ev->sched_switch);
-
-	/*
-	 * Ensure that event (especially user_irq) is cleared when the
-	 * interrupt did not result in a schedule and therefore the
-	 * rseq processing did not clear it.
-	 */
-	ev->events = 0;
-}
-
 /*
  * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
  * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
@@ -92,7 +77,6 @@ static inline void rseq_sched_switch_eve
 static inline void rseq_virt_userspace_exit(void) { }
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
 static inline void rseq_execve(struct task_struct *t) { }
-static inline void rseq_exit_to_user_mode(void) { }
 #endif  /* !CONFIG_RSEQ */
 
 #ifdef CONFIG_DEBUG_RSEQ
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -2,6 +2,37 @@
 #ifndef _LINUX_RSEQ_ENTRY_H
 #define _LINUX_RSEQ_ENTRY_H
 
+/* Must be outside the CONFIG_RSEQ guard to resolve the stubs */
+#ifdef CONFIG_RSEQ_STATS
+#include <linux/percpu.h>
+
+struct rseq_stats {
+	unsigned long	exit;
+	unsigned long	signal;
+	unsigned long	slowpath;
+	unsigned long	ids;
+	unsigned long	cs;
+	unsigned long	clear;
+	unsigned long	fixup;
+};
+
+DECLARE_PER_CPU(struct rseq_stats, rseq_stats);
+
+/*
+ * Slow path has interrupts and preemption enabled, but the fast path
+ * runs with interrupts disabled so there is no point in having the
+ * preemption checks implied in __this_cpu_inc() for every operation.
+ */
+#ifdef RSEQ_BUILD_SLOW_PATH
+#define rseq_stat_inc(which)	this_cpu_inc((which))
+#else
+#define rseq_stat_inc(which)	raw_cpu_inc((which))
+#endif
+
+#else /* CONFIG_RSEQ_STATS */
+#define rseq_stat_inc(x)	do { } while (0)
+#endif /* !CONFIG_RSEQ_STATS */
+
 #ifdef CONFIG_RSEQ
 #include <linux/rseq.h>
 
@@ -39,8 +70,26 @@ static __always_inline void rseq_note_us
 		current->rseq.event.user_irq = true;
 }
 
+static __always_inline void rseq_exit_to_user_mode(void)
+{
+	struct rseq_event *ev = &current->rseq.event;
+
+	rseq_stat_inc(rseq_stats.exit);
+
+	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+		WARN_ON_ONCE(ev->sched_switch);
+
+	/*
+	 * Ensure that event (especially user_irq) is cleared when the
+	 * interrupt did not result in a schedule and therefore the
+	 * rseq processing did not clear it.
+	 */
+	ev->events = 0;
+}
+
 #else /* CONFIG_RSEQ */
 static inline void rseq_note_user_irq_entry(void) { }
+static inline void rseq_exit_to_user_mode(void) { }
 #endif /* !CONFIG_RSEQ */
 
 #endif /* _LINUX_RSEQ_ENTRY_H */
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1913,6 +1913,18 @@ config RSEQ
 
 	  If unsure, say Y.
 
+config RSEQ_STATS
+	default n
+	bool "Enable lightweight statistics of restartable sequences" if EXPERT
+	depends on RSEQ && DEBUG_FS
+	help
+	  Enable lightweight counters which expose information about the
+	  frequency of RSEQ operations via debugfs. Mostly interesting for
+	  kernel debugging or performance analysis. While lightweight it's
+	  still adding code into the user/kernel mode transitions.
+
+	  If unsure, say N.
+
 config DEBUG_RSEQ
 	default n
 	bool "Enable debugging of rseq() system call" if EXPERT
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -67,12 +67,16 @@
  *   F1. <failure>
  */
 
+/* Required to select the proper per_cpu ops for rseq_stats_inc() */
+#define RSEQ_BUILD_SLOW_PATH
+
+#include <linux/debugfs.h>
+#include <linux/ratelimit.h>
+#include <linux/rseq_entry.h>
 #include <linux/sched.h>
-#include <linux/uaccess.h>
 #include <linux/syscalls.h>
-#include <linux/rseq_entry.h>
+#include <linux/uaccess.h>
 #include <linux/types.h>
-#include <linux/ratelimit.h>
 #include <asm/ptrace.h>
 
 #define CREATE_TRACE_POINTS
@@ -108,6 +112,56 @@ void __rseq_trace_ip_fixup(unsigned long
 }
 #endif /* CONFIG_TRACEPOINTS */
 
+#ifdef CONFIG_RSEQ_STATS
+DEFINE_PER_CPU(struct rseq_stats, rseq_stats);
+
+static int rseq_debug_show(struct seq_file *m, void *p)
+{
+	struct rseq_stats stats = { };
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		stats.exit	+= data_race(per_cpu(rseq_stats.exit, cpu));
+		stats.signal	+= data_race(per_cpu(rseq_stats.signal, cpu));
+		stats.slowpath	+= data_race(per_cpu(rseq_stats.slowpath, cpu));
+		stats.ids	+= data_race(per_cpu(rseq_stats.ids, cpu));
+		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
+		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
+		stats.fixup	+= data_race(per_cpu(rseq_stats.fixup, cpu));
+	}
+
+	seq_printf(m, "exit:   %16lu\n", stats.exit);
+	seq_printf(m, "signal: %16lu\n", stats.signal);
+	seq_printf(m, "slowp:  %16lu\n", stats.slowpath);
+	seq_printf(m, "ids:    %16lu\n", stats.ids);
+	seq_printf(m, "cs:     %16lu\n", stats.cs);
+	seq_printf(m, "clear:  %16lu\n", stats.clear);
+	seq_printf(m, "fixup:  %16lu\n", stats.fixup);
+	return 0;
+}
+
+static int rseq_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rseq_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_ops = {
+	.open		= rseq_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init rseq_debugfs_init(void)
+{
+	struct dentry *root_dir = debugfs_create_dir("rseq", NULL);
+
+	debugfs_create_file("stats", 0444, root_dir, NULL, &dfs_ops);
+	return 0;
+}
+__initcall(rseq_debugfs_init);
+#endif /* CONFIG_RSEQ_STATS */
+
 #ifdef CONFIG_DEBUG_RSEQ
 static struct rseq *rseq_kernel_fields(struct task_struct *t)
 {
@@ -187,12 +241,13 @@ static int rseq_update_cpu_node_id(struc
 	u32 node_id = cpu_to_node(cpu_id);
 	u32 mm_cid = task_mm_cid(t);
 
-	/*
-	 * Validate read-only rseq fields.
-	 */
+	rseq_stat_inc(rseq_stats.ids);
+
+	/* Validate read-only rseq fields on debug kernels */
 	if (rseq_validate_ro_fields(t))
 		goto efault;
 	WARN_ON_ONCE((int) mm_cid < 0);
+
 	if (!user_write_access_begin(rseq, t->rseq.len))
 		goto efault;
 
@@ -403,6 +458,8 @@ static int rseq_ip_fixup(struct pt_regs
 	struct rseq_cs rseq_cs;
 	int ret;
 
+	rseq_stat_inc(rseq_stats.cs);
+
 	ret = rseq_get_rseq_cs(t, &rseq_cs);
 	if (ret)
 		return ret;
@@ -412,8 +469,10 @@ static int rseq_ip_fixup(struct pt_regs
 	 * If not nested over a rseq critical section, restart is useless.
 	 * Clear the rseq_cs pointer and return.
 	 */
-	if (!in_rseq_cs(ip, &rseq_cs))
+	if (!in_rseq_cs(ip, &rseq_cs)) {
+		rseq_stat_inc(rseq_stats.clear);
 		return clear_rseq_cs(t->rseq.usrptr);
+	}
 	ret = rseq_check_flags(t, rseq_cs.flags);
 	if (ret < 0)
 		return ret;
@@ -422,6 +481,7 @@ static int rseq_ip_fixup(struct pt_regs
 	ret = clear_rseq_cs(t->rseq.usrptr);
 	if (ret)
 		return ret;
+	rseq_stat_inc(rseq_stats.fixup);
 	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
 			    rseq_cs.abort_ip);
 	instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
@@ -462,6 +522,11 @@ void __rseq_handle_notify_resume(struct
 	if (unlikely(t->flags & PF_EXITING))
 		return;
 
+	if (ksig)
+		rseq_stat_inc(rseq_stats.signal);
+	else
+		rseq_stat_inc(rseq_stats.slowpath);
+
 	/*
 	 * Read and clear the event pending bit first. If the task
 	 * was not preempted or migrated or a signal is on the way,



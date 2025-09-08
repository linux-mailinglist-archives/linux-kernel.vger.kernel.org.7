Return-Path: <linux-kernel+bounces-806806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2119DB49C0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F524E209E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEB22E0419;
	Mon,  8 Sep 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOIPGnWx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="82ZbU5tE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5630F80D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367125; cv=none; b=WAfDBHDNcag2GHmuhUkLUg1D8xtfGYOdR82s79IbHwNrUFa2pZ2HVo0aW/sJmUTo7hS33W73XubI1SBs0IP0BVoao28mPs9OARu2LGECXrrJ9iEgxO6OnWiktY0g4I1cvssjuIZIGqdaIl7EARPO3FGDkAmf2DCTJsfNlGAEPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367125; c=relaxed/simple;
	bh=tkY6TyWLZnxlX2CvzQjJnuoyECsAPsntUaoTD9p74Xk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=NQXwW8ua8Q0MsyTT+GsvcyOU3V3mRGlbLRp+ehvwr15S3dCV6jGZv7hsvH0z0dpjdKvZCQjLHSxsfzaCKI0g2sX1nTSz4mO246NFeWQ06g2wTweG1cjqoN2wH+r7Y/8EoU6NLX5KGJUoUNu896QVQ581KAYObef+E/CkIdARM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOIPGnWx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=82ZbU5tE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.352693438@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uz/wDdZ2PG+mD8ZeRXgbQ7e7ARxWzor5Yg0a1tdjLN4=;
	b=UOIPGnWx/1R26IZcJvFpEtOE6dgyISP4tRmfJQvENbLr4duGIZW22VYfTWTn7/XdlqB4LK
	OQulL3xTG/LMwjPVtz8GGdRaFYnuhzlxoB8I2Fm5/nRZsynoQyLF5raffCYKybe4utIuyb
	lZa7ajCfCoqrKlJgKsDCB6rE3TAH02pAcEEeDrESOWyAbqTFd6RTl+51Zd3a6tFlgB4OHo
	bEKv9SBiTSbl0KBCPSN/Kw995nQkr6Z39XYREwRKA2bzxIXcLAnvOJY4J/oPcMVUzIlEvH
	ociHdYdetvQSjeacvj77Ge0tKWhuuYYO0HgxJxDtxP5GUViQaP+3PhqWJ2zMnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uz/wDdZ2PG+mD8ZeRXgbQ7e7ARxWzor5Yg0a1tdjLN4=;
	b=82ZbU5tEeosxvV/bjFAOpsWLv3T99ojFhPoIAtTBDXW+gF27dU8xvFJGUGQ5odu+3KTu4R
	wFD3ZeUSyMwoHiDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V4 17/36] rseq: Expose lightweight statistics in debugfs
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:59 +0200 (CEST)

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
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
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
@@ -1883,6 +1883,18 @@ config RSEQ
 
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
-#include <linux/rseq.h>
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



Return-Path: <linux-kernel+bounces-744647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A1BB10F82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1FB1CC8756
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A5E2ECE93;
	Thu, 24 Jul 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XukVVQlR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46D2EA754
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373806; cv=none; b=bb/64fjGiqni+ivWE7pa8x/Tt58Uu4IgjVnKwcFtpwZVrvighz86egvBItGqp8dW4ClDOudBvqjOyEKoPVHTXkNOSPu9UtqEe3XN6Tm9uC+5g2nOSyEFehjlYf3TgqdwcscJRCcFMrQrnwudI0dEpcxkiPGpQJSC0uMa/QVyaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373806; c=relaxed/simple;
	bh=Dk2uBqAaEyU+9YNl9B7qppe8hsBQPkJpVcViQ1sbPRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4tIx4ZPsWFFMTcvD1kY9r4uImjA8e3R1nJfGKgyvGFXzCcNvXhPTHipvu5E9CNo7BhTHtv5NIPm4qE7or7PEbIg6938MtGTJho4648nF3ObSJehvvTq30+N44SFVMp4U0Sbblh/F+Svyi9YbeOTPXsSd+sIqzmVXipDZFa0jVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XukVVQlR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRQit012138;
	Thu, 24 Jul 2025 16:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=vqk2l
	l6MWgjWxJ8C30AC0qKFhaYhTvHky64a2KS4hKc=; b=XukVVQlRyVOeCVRMvCVSI
	BjmMu1Bl9xH3WOg0hc7N9nBRGFQF7Gaaiwe5eky4NFKzcr3dPex4UcCs6TBf6Xq7
	qkkB5lZtDfXNn5hu8LGCerq0kv9N1Y4pxDQHj/aoxgSghMruPZLFbP0O1dKFOQ6p
	PTAdE+FIz2NUlkxEo83b9+2/16Jcms8A95mPixgBYdPifPFjxJrbREeVlJNDQpIa
	koyxvZeAou5dYzx3ZUvA+HyiYpqF3H8vbmk4fAqttU9TVYFpsRBOZaQpDw6yNkvW
	Cjtcdeq4un4I9FZsCtKTMps/0ttksdjDg4FfcCH2alEhm/GoYKnDoexWyWd4Bi09
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hpj266-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OFkbHW014357;
	Thu, 24 Jul 2025 16:16:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNI034466;
	Thu, 24 Jul 2025 16:16:28 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:28 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 01/11] sched: Scheduler time slice extension
Date: Thu, 24 Jul 2025 16:16:15 +0000
Message-ID: <20250724161625.2360309-2-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240123
X-Proofpoint-ORIG-GUID: vZgGG94iwQDrBSceGQBcJWq5BMoXmQV6
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=68825c5d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=2YheWpswMuxJmFNZD14A:9
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12061
X-Proofpoint-GUID: vZgGG94iwQDrBSceGQBcJWq5BMoXmQV6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfX0NIwHTJ5FDNg
 6BNbGrciq2wu8H2hNM9gnO/XZsZeOVkLld2Zp1UkiP+cBBrZGrM8EWbz4Vky11b25qz4mEvZsAZ
 4Kk4SK3eFgpMfYgTtnZ4kFGSQiRXHsBN9oweHVEK+ZpNXxi6kK2oE/vJKkDwYTclGzgZCzQETDh
 xVvb9QsKbjnfOUtn7klM7Ah/MZvOvCmDLwVOPqMGpt4jWs5ko/6WJ+q5ESzvBdZ7h0lhF0DioXP
 FtbOCjOGPjYS4rgoLcrDPEBq+HxfYmk6/7Mmd9vKXVBCKjBruoVpeYLm/XlJn4Wu//AbKsOUGvk
 FWC7Zo8HUbt1fybCwSEwVOuNsDRJQ5s4NlAgi72oW3yeCxmeLUVkgmb9oX+jhHFDw/ONRtU5Bfs
 RFmzOnd9J5fkUk5GNQr8rnxkpwSuI2D70gwSMIYnmi8WXxt721/UHabIcuwHyUUtTJZ4zUOa

Add support for a thread to request extending its execution time slice on
the cpu. The extra cpu time granted would help in allowing the thread to
complete executing the critical section and drop any locks without getting
preempted. The thread would request this cpu time extension, by setting a
bit in the restartable sequences(rseq) structure registered with the kernel.

Kernel will grant a 30us extension on the cpu, when it sees the bit set.
With the help of a timer, kernel force preempts the thread if it is still
running on the cpu when the 30us timer expires. The thread should yield
the cpu by making a system call after completing the critical section.

Suggested-by: Peter Ziljstra <peterz@infradead.org>
Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/entry-common.h | 14 +++++++++----
 include/linux/sched.h        | 28 ++++++++++++++++++++++++++
 include/uapi/linux/rseq.h    |  7 +++++++
 init/Kconfig                 |  7 +++++++
 kernel/entry/common.c        | 28 ++++++++++++++++++++++----
 kernel/rseq.c                | 38 ++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c          | 15 ++++++++++++++
 kernel/sched/syscalls.c      |  4 ++++
 8 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index f94f3fdf15fc..7b258d2510f8 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -304,7 +304,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs);
  * exit_to_user_mode_loop - do any pending work before leaving to user space
  */
 unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-				     unsigned long ti_work);
+				     unsigned long ti_work, bool irq);
 
 /**
  * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
@@ -316,7 +316,7 @@ unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
  *    EXIT_TO_USER_MODE_WORK are set
  * 4) check that interrupts are still disabled
  */
-static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs, bool irq)
 {
 	unsigned long ti_work;
 
@@ -327,7 +327,10 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	ti_work = read_thread_flags();
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
+		ti_work = exit_to_user_mode_loop(regs, ti_work, irq);
+
+	if (IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY) && irq)
+		rseq_delay_resched_arm_timer();
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
@@ -396,6 +399,9 @@ static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
 
 	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
 
+	/* Reschedule if scheduler time delay was granted */
+	rseq_delay_set_need_resched();
+
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
 			local_irq_enable();
@@ -411,7 +417,7 @@ static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
 	if (unlikely(work & SYSCALL_WORK_EXIT))
 		syscall_exit_work(regs, work);
 	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
+	exit_to_user_mode_prepare(regs, false);
 }
 
 /**
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5bcf44ae6c79..5d2819afd481 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -338,6 +338,7 @@ extern int __must_check io_schedule_prepare(void);
 extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
+extern void hrtick_local_start(u64 delay);
 
 /* wrapper function to trace from this header file */
 DECLARE_TRACEPOINT(sched_set_state_tp);
@@ -1048,6 +1049,7 @@ struct task_struct {
 	unsigned                        in_thrashing:1;
 #endif
 	unsigned			in_nf_duplicate:1;
+	unsigned			rseq_delay_resched:2;
 #ifdef CONFIG_PREEMPT_RT
 	struct netdev_xmit		net_xmit;
 #endif
@@ -1711,6 +1713,13 @@ static inline char task_state_to_char(struct task_struct *tsk)
 
 extern struct pid *cad_pid;
 
+/*
+ * Used in tsk->rseq_delay_resched.
+ */
+#define	RSEQ_RESCHED_DELAY_NONE		0	/* tsk->rseq not registered */
+#define	RSEQ_RESCHED_DELAY_PROBE	1	/* Evaluate tsk->rseq->flags */
+#define	RSEQ_RESCHED_DELAY_REQUESTED	2	/* Request to delay reschedule successful */
+
 /*
  * Per process flags
  */
@@ -2245,6 +2254,25 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 unsigned long sched_cpu_util(int cpu);
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_RSEQ_RESCHED_DELAY
+extern bool __rseq_delay_resched(void);
+extern void rseq_delay_resched_arm_timer(void);
+extern void rseq_delay_resched_tick(void);
+static inline bool rseq_delay_set_need_resched(void)
+{
+    if (current->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED) {
+	    set_tsk_need_resched(current);
+	    return true;
+    }
+    return false;
+}
+#else
+static inline bool __rseq_delay_resched(void) { return false; }
+static inline void rseq_delay_resched_arm_timer(void) { }
+static inline void rseq_delay_resched_tick(void) { }
+static inline bool rseq_delay_set_need_resched(void) { return false; }
+#endif
+
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index c233aae5eac9..25fc636b17d5 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -26,6 +26,7 @@ enum rseq_cs_flags_bit {
 	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
 	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
+	RSEQ_CS_FLAG_DELAY_RESCHED_BIT		= 3,
 };
 
 enum rseq_cs_flags {
@@ -35,6 +36,8 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+	RSEQ_CS_FLAG_DELAY_RESCHED		=
+		(1U << RSEQ_CS_FLAG_DELAY_RESCHED_BIT),
 };
 
 /*
@@ -128,6 +131,10 @@ struct rseq {
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
 	 *     Inhibit instruction sequence block restart on migration for
 	 *     this thread.
+	 * - RSEQ_CS_FLAG_DELAY_RESCHED
+	 *     Request by user thread to delay preemption. With use
+	 *     of a timer, kernel grants extra cpu time upto 30us for this
+	 *     thread before being rescheduled.
 	 */
 	__u32 flags;
 
diff --git a/init/Kconfig b/init/Kconfig
index ce76e913aa2b..3005abab77cf 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1130,6 +1130,13 @@ config SCHED_MM_CID
 	def_bool y
 	depends on SMP && RSEQ
 
+config RSEQ_RESCHED_DELAY
+	def_bool y
+	depends on SMP && RSEQ && SCHED_HRTICK
+	help
+	  This feature enables a thread to request extending its time slice on
+	  the cpu by delaying preemption.
+
 config UCLAMP_TASK_GROUP
 	bool "Utilization clamping per group of tasks"
 	depends on CGROUP_SCHED
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index a8dd1f27417c..3d2d670980ec 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -82,13 +82,31 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
+static inline bool rseq_delay_resched(unsigned long ti_work)
+{
+	if (!IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
+		return false;
+
+	if (unlikely(current->rseq_delay_resched != RSEQ_RESCHED_DELAY_PROBE))
+		return false;
+
+	if (!(ti_work & (_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_LAZY)))
+		return false;
+
+	if (__rseq_delay_resched()) {
+		clear_tsk_need_resched(current);
+		return true;
+	}
+	return false;
+}
+
 /**
  * exit_to_user_mode_loop - do any pending work before leaving to user space
  * @regs:	Pointer to pt_regs on entry stack
  * @ti_work:	TIF work flags as read by the caller
  */
 __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-						     unsigned long ti_work)
+						     unsigned long ti_work, bool irq)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -98,8 +116,10 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
-			schedule();
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
+		       if (likely(!irq || !rseq_delay_resched(ti_work)))
+			       schedule();
+		}
 
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
@@ -181,7 +201,7 @@ noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
+	exit_to_user_mode_prepare(regs, true);
 	instrumentation_end();
 	exit_to_user_mode();
 }
diff --git a/kernel/rseq.c b/kernel/rseq.c
index b7a1ec327e81..8b6af4e12142 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -448,6 +448,40 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	force_sigsegv(sig);
 }
 
+#ifdef	CONFIG_RSEQ_RESCHED_DELAY
+bool __rseq_delay_resched(void)
+{
+	struct task_struct *t = current;
+	u32 flags;
+
+	if (copy_from_user_nofault(&flags, &t->rseq->flags, sizeof(flags)))
+		return false;
+
+	if (!(flags & RSEQ_CS_FLAG_DELAY_RESCHED))
+		return false;
+
+	flags &= ~RSEQ_CS_FLAG_DELAY_RESCHED;
+	if (copy_to_user_nofault(&t->rseq->flags, &flags, sizeof(flags)))
+		return false;
+
+	t->rseq_delay_resched = RSEQ_RESCHED_DELAY_REQUESTED;
+
+	return true;
+}
+
+void rseq_delay_resched_arm_timer(void)
+{
+	if (unlikely(current->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED))
+		hrtick_local_start(30 * NSEC_PER_USEC);
+}
+
+void rseq_delay_resched_tick(void)
+{
+	if (current->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED)
+		set_tsk_need_resched(current);
+}
+#endif /* CONFIG_RSEQ_RESCHED_DELAY */
+
 #ifdef CONFIG_DEBUG_RSEQ
 
 /*
@@ -493,6 +527,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		current->rseq = NULL;
 		current->rseq_sig = 0;
 		current->rseq_len = 0;
+		if (IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
+			current->rseq_delay_resched = RSEQ_RESCHED_DELAY_NONE;
 		return 0;
 	}
 
@@ -561,6 +597,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	current->rseq = rseq;
 	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
+	if (IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
+		current->rseq_delay_resched = RSEQ_RESCHED_DELAY_PROBE;
 
 	/*
 	 * If rseq was previously inactive, and has just been
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4ad7cf3cfdca..e75ecbb2c1f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -845,6 +845,8 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	WARN_ON_ONCE(cpu_of(rq) != smp_processor_id());
 
+	rseq_delay_resched_tick();
+
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 	rq->donor->sched_class->task_tick(rq, rq->curr, 1);
@@ -918,6 +920,16 @@ void hrtick_start(struct rq *rq, u64 delay)
 
 #endif /* CONFIG_SMP */
 
+void hrtick_local_start(u64 delay)
+{
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
+
+	rq_lock(rq, &rf);
+	hrtick_start(rq, delay);
+	rq_unlock(rq, &rf);
+}
+
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
@@ -6740,6 +6752,9 @@ static void __sched notrace __schedule(int sched_mode)
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+	if (IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY) &&
+	    prev->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED)
+		prev->rseq_delay_resched = RSEQ_RESCHED_DELAY_PROBE;
 	rq->last_seen_need_resched_ns = 0;
 
 	is_switch = prev != next;
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ee5641757838..e684a77ed1fb 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1379,6 +1379,10 @@ static void do_sched_yield(void)
  */
 SYSCALL_DEFINE0(sched_yield)
 {
+	/* Reschedule if scheduler time delay was granted */
+	if (rseq_delay_set_need_resched())
+		return 0;
+
 	do_sched_yield();
 	return 0;
 }
-- 
2.43.5



Return-Path: <linux-kernel+bounces-865017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563FFBFC1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981316267E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7CE351FD4;
	Wed, 22 Oct 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kGmxk5lf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3XMnTAIy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE33502A0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137744; cv=none; b=e5J/uW2XbTdX4MKi82lNg4bKP0GmsdwfS1HZYjOAcG2w6fPRRw9+jVzBkysR79Jc03rlR4DFl4H0BqNXivxsgktcG5FWFTaVavH1f2uo7A25gqiYnjLF3cM1jZXmYiCZX/ICZnZYfjJrbzf4C4+QX1McnXsYCjbQVIBYGbl3Z7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137744; c=relaxed/simple;
	bh=m8U83tUlAlyeYTr8iD02VWhe/sx5MGcfJ7PwWeS2mzM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kxC7jFqXGep3dD+J+PL1ApT3AW1X+a/xENtuRX0LI77OX7p+58nNdrShsu6xDkdg0Q0oWVQmzHEkj22i9JXs2Iz3rNW7L/HmNBXognUcVtHGAy+W3Hxhko2CpUbY9UOyRf0HSkrVMBSQI6MPRfQXQNk+3p+EQI23I0s3FGOsKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kGmxk5lf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3XMnTAIy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110556.459733969@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=m0tY8szn+J/LYEJUNkiXtf9MnRwnD0rTBrtH84gIKoQ=;
	b=kGmxk5lfzYYc8HHw+NTQe35exUfbSitbjiPMC2NEJo9kNtnxWh/mMpRTBO9LVjnGSrAfAe
	Q5UU3lFeox+r+xKuvNrsr/6ssXqIwgShr14rAqB1FI/151lYUu1zsXDpb8ow50fKXMbb9Q
	pCwCZ10sfrdjS8P0lZ6ip59eX0UXn6OHOZRvrqo3SO8PI7v3PbdZhar4d6FNPmMPW1jY16
	9aOeO+pUh1KeKcFTl2DWOn3KnA0Wd+Sv/vCIeqT6Y9hKSzA5PPCl7kOmxoF7kb0SLezSf7
	dh7H/LMq5CUTjMV/o9/HSGI3X80WQLiKwv29UMZlRN1DcUEWbv+3l+Bg+zvwgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=m0tY8szn+J/LYEJUNkiXtf9MnRwnD0rTBrtH84gIKoQ=;
	b=3XMnTAIyj8cz/yUQ/jFoUearQWnwfC/E2gLz/sftR3YiCE23LUu/2+jcKQxLTPEquKnGov
	fRvp8UFchzXDxxDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>
Subject: [patch V2 17/20] sched/mmcid: Provide CID ownership mode fixup
 functions
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:40 +0200 (CEST)

CIDs are either owned by tasks or by CPUs. The ownership mode depends on
the number of tasks related to a MM and the number of CPUs on which these
tasks are theoretically allowed to run on. Theoretically because that
number is the superset of CPU affinities of all tasks which only grows and
never shrinks.

Switching to per CPU mode happens when the user count becomes greater than
the maximum number of CIDs, which is calculated by:

	opt_cids = min(mm_cid::nr_cpus_allowed, mm_cid::users);
	max_cids = min(1.25 * opt_cids, nr_cpu_ids);

The +25% allowance is useful for tight CPU masks in scenarios where only a
few threads are created and destroyed to avoid frequent mode
switches. Though this allowance shrinks, the closer opt_cids becomes to
nr_cpu_ids, which is the (unfortunate) hard ABI limit.

At the point of switching to per CPU mode the new user is not yet visible
in the system, so the task which initiated the fork() runs the fixup
function: mm_cid_fixup_tasks_to_cpu() walks the thread list and either
transfers each tasks owned CID to the CPU the task runs on or drops it into
the CID pool if a task is not on a CPU at that point in time. Tasks which
schedule in before the task walk reaches them do the handover in
mm_cid_schedin(). When mm_cid_fixup_tasks_to_cpus() completes it's
guaranteed that no task related to that MM owns a CID anymore.

Switching back to task mode happens when the user count goes below the
threshold which was recorded on the per CPU mode switch:

	pcpu_thrs = min(opt_cids - (opt_cids / 4), nr_cpu_ids / 2);

This threshold is updated when a affinity change increases the number of
allowed CPUs for the MM, which might cause a switch back to per task mode.

If the switch back was initiated by a exiting task, then that task runs the
fixup function. If it was initiated by a affinity change, then it's run
either in the deferred update function in context of a workqueue or by a
task which forks a new one or by a task which exits. Whatever happens
first. mm_cid_fixup_cpus_to_task() walks through the possible CPUs and
either transfers the CPU owned CIDs to a related task which runs on the CPU
or drops it into the pool. Tasks which schedule in on a CPU which the walk
did not cover yet do the handover themself.

This transition from CPU to per task ownership happens in two phases:

 1) mm:mm_cid.transit contains MM_CID_TRANSIT. This is OR'ed on the task
    CID and denotes that the CID is only temporarily owned by the
    task. When it schedules out the task drops the CID back into the
    pool if this bit is set.

 2) The initiating context walks the per CPU space and after completion
    clears mm:mm_cid.transit. After that point the CIDs are strictly
    task owned again.

This two phase transition is required to prevent CID space exhaustion
during the transition as a direct transfer of ownership would fail if
two tasks are scheduled in on the same CPU before the fixup freed per
CPU CIDs.

When mm_cid_fixup_cpus_to_tasks() completes it's guaranteed that no CID
related to that MM is owned by a CPU anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix CPU to task owner mode
---
 include/linux/rseq_types.h |   10 +
 kernel/sched/core.c        |  277 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 261 insertions(+), 26 deletions(-)

--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -127,8 +127,9 @@ struct mm_cid_pcpu {
  * @users:		The number of tasks sharing this MM. Seperate from mm::mm_users
  *			as that is modified by mmget()/mm_put() by other entities which
  *			do not actually share the MM.
- * @lock:		Spinlock to protect all fields except @pcpu. It also protects
- *			the MM cid cpumask and the MM cidmask bitmap.
+ * @pcpu_thrs:		Threshold for switching back from per CPU mode
+ * @update_deferred:	A deferred switch back to per task mode is pending.
+ * @lock:		Spinlock to protect against affinity setting which can't take @mutex
  * @mutex:		Mutex to serialize forks and exits related to this mm
  */
 struct mm_mm_cid {
@@ -137,8 +138,13 @@ struct mm_mm_cid {
 	unsigned int		percpu;
 	unsigned int		transit;
 	unsigned int		max_cids;
+
+	/* Low frequency modified */
 	unsigned int		nr_cpus_allowed;
 	unsigned int		users;
+	unsigned int		pcpu_thrs;
+	unsigned int		update_deferred;
+
 	raw_spinlock_t		lock;
 	struct mutex		mutex;
 }____cacheline_aligned_in_smp;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10394,43 +10394,269 @@ void call_trace_sched_update_nr_running(
  * the task needs to drop the CID into the pool when scheduling out.  Both
  * bits (ONCPU and TRANSIT) are filtered out by task_cid() when the CID is
  * actualy handed over to user space in the RSEQ memory.
+ *
+ * Mode switching:
+ *
+ * Switching to per CPU mode happens when the user count becomes greater
+ * than the maximum number of CIDs, which is calculated by:
+ *
+ *	opt_cids = min(mm_cid::nr_cpus_allowed, mm_cid::users);
+ *	max_cids = min(1.25 * opt_cids, num_possible_cpus());
+ *
+ * The +25% allowance is useful for tight CPU masks in scenarios where only
+ * a few threads are created and destroyed to avoid frequent mode
+ * switches. Though this allowance shrinks, the closer opt_cids becomes to
+ * num_possible_cpus(), which is the (unfortunate) hard ABI limit.
+ *
+ * At the point of switching to per CPU mode the new user is not yet
+ * visible in the system, so the task which initiated the fork() runs the
+ * fixup function: mm_cid_fixup_tasks_to_cpu() walks the thread list and
+ * either transfers each tasks owned CID to the CPU the task runs on or
+ * drops it into the CID pool if a task is not on a CPU at that point in
+ * time. Tasks which schedule in before the task walk reaches them do the
+ * handover in mm_cid_schedin(). When mm_cid_fixup_tasks_to_cpus() completes
+ * it's guaranteed that no task related to that MM owns a CID anymore.
+ *
+ * Switching back to task mode happens when the user count goes below the
+ * threshold which was recorded on the per CPU mode switch:
+ *
+ *	pcpu_thrs = min(opt_cids - (opt_cids / 4), num_possible_cpus() / 2);
+ *
+ * This threshold is updated when a affinity change increases the number of
+ * allowed CPUs for the MM, which might cause a switch back to per task
+ * mode.
+ *
+ * If the switch back was initiated by a exiting task, then that task runs
+ * the fixup function. If it was initiated by a affinity change, then it's
+ * run either in the deferred update function in context of a workqueue or
+ * by a task which forks a new one or by a task which exits. Whatever
+ * happens first. mm_cid_fixup_cpus_to_task() walks through the possible
+ * CPUs and either transfers the CPU owned CIDs to a related task which
+ * runs on the CPU or drops it into the pool. Tasks which schedule in on a
+ * CPU which the walk did not cover yet do the handover themself.
+ *
+ * This transition from CPU to per task ownership happens in two phases:
+ *
+ *  1) mm:mm_cid.transit contains MM_CID_TRANSIT This is OR'ed on the task
+ *     CID and denotes that the CID is only temporarily owned by the
+ *     task. When it schedules out the task drops the CID back into the
+ *     pool if this bit is set.
+ *
+ *  2) The initiating context walks the per CPU space and after completion
+ *     clears mm:mm_cid.transit. So after that point the CIDs are strictly
+ *     task owned again.
+ *
+ * This two phase transition is required to prevent CID space exhaustion
+ * during the transition as a direct transfer of ownership would fail if
+ * two tasks are scheduled in on the same CPU before the fixup freed per
+ * CPU CIDs.
+ *
+ * When mm_cid_fixup_cpus_to_tasks() completes it's guaranteed that no CID
+ * related to that MM is owned by a CPU anymore.
  */
 
 /*
  * Update the CID range properties when the constraints change. Invoked via
  * fork(), exit() and affinity changes
  */
-static void mm_update_max_cids(struct mm_struct *mm)
+static void __mm_update_max_cids(struct mm_mm_cid *mc)
+{
+	unsigned int opt_cids, max_cids;
+
+	/* Calculate the new optimal constraint */
+	opt_cids = min(mc->nr_cpus_allowed, mc->users);
+
+	/* Adjust the maximum CIDs to +25% limited by the number of possible CPUs */
+	max_cids = min(opt_cids + (opt_cids / 4), num_possible_cpus());
+	WRITE_ONCE(mc->max_cids, max_cids);
+}
+
+static inline unsigned int mm_cid_calc_pcpu_thrs(struct mm_mm_cid *mc)
+{
+	unsigned int opt_cids;
+
+	opt_cids = min(mc->nr_cpus_allowed, mc->users);
+	return min(opt_cids - opt_cids / 4, num_possible_cpus() / 2);
+}
+
+static bool mm_update_max_cids(struct mm_struct *mm)
 {
 	struct mm_mm_cid *mc = &mm->mm_cid;
-	unsigned int max_cids;
 
 	lockdep_assert_held(&mm->mm_cid.lock);
 
-	/* Calculate the new maximum constraint */
-	max_cids = min(mc->nr_cpus_allowed, mc->users);
-	WRITE_ONCE(mc->max_cids, max_cids);
+	/* Clear deferred mode switch flag. A change is handled by the caller */
+	mc->update_deferred = false;
+	__mm_update_max_cids(mc);
+
+	/* Check whether owner mode must be changed */
+	if (!mc->percpu) {
+		/* Enable per CPU mode when the number of users is above max_cids */
+		if (mc->users > mc->max_cids)
+			mc->pcpu_thrs = mm_cid_calc_pcpu_thrs(mc);
+	} else {
+		/* Switch back to per task if user count under threshold */
+		if (mc->users < mc->pcpu_thrs)
+			mc->pcpu_thrs = 0;
+	}
+
+	/* Mode change required? */
+	if (!!mc->percpu == !!mc->pcpu_thrs)
+		return false;
+	/* When switching back to per TASK mode, set the transition flag */
+	if (!mc->pcpu_thrs)
+		WRITE_ONCE(mc->transit, MM_CID_TRANSIT);
+	WRITE_ONCE(mc->percpu, !!mc->pcpu_thrs);
+	return true;
 }
 
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
 {
 	struct cpumask *mm_allowed;
+	struct mm_mm_cid *mc;
 	unsigned int weight;
 
 	if (!mm || !READ_ONCE(mm->mm_cid.users))
 		return;
-
 	/*
 	 * mm::mm_cid::mm_cpus_allowed is the superset of each threads
 	 * allowed CPUs mask which means it can only grow.
 	 */
-	guard(raw_spinlock)(&mm->mm_cid.lock);
+	mc = &mm->mm_cid;
+	guard(raw_spinlock)(&mc->lock);
 	mm_allowed = mm_cpus_allowed(mm);
 	weight = cpumask_or_and_calc_weight(mm_allowed, mm_allowed, affmsk);
-	if (weight == mm->mm_cid.nr_cpus_allowed)
+	if (weight == mc->nr_cpus_allowed)
+		return;
+
+	WRITE_ONCE(mc->nr_cpus_allowed, weight);
+	__mm_update_max_cids(mc);
+	if (!mc->percpu)
 		return;
-	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
-	mm_update_max_cids(mm);
+
+	/* Adjust the threshold to the wider set */
+	mc->pcpu_thrs = mm_cid_calc_pcpu_thrs(mc);
+
+	/* Scheduling of deferred mode switch goes here */
+}
+
+static inline void mm_cid_transit_to_task(struct task_struct *t, struct mm_cid_pcpu *pcp)
+{
+	if (cid_on_cpu(t->mm_cid.cid)) {
+		unsigned int cid = cpu_cid_to_cid(t->mm_cid.cid);
+
+		t->mm_cid.cid = cid_to_transit_cid(cid);
+		pcp->cid = t->mm_cid.cid;
+	}
+}
+
+static void __maybe_unused mm_cid_fixup_cpus_to_tasks(struct mm_struct *mm)
+{
+	unsigned int cpu;
+
+	/* Walk the CPUs and fixup all stale CIDs */
+	for_each_possible_cpu(cpu) {
+		struct mm_cid_pcpu *pcp = per_cpu_ptr(mm->mm_cid.pcpu, cpu);
+		struct rq *rq = cpu_rq(cpu);
+
+		/* Remote access to mm::mm_cid::pcpu requires rq_lock */
+		guard(rq_lock_irq)(rq);
+		/* Is the CID still owned by the CPU? */
+		if (cid_on_cpu(pcp->cid)) {
+			/*
+			 * If rq->curr has @mm, transfer it with the
+			 * transition bit set. Otherwise drop it.
+			 */
+			if (rq->curr->mm == mm && rq->curr->mm_cid.active)
+				mm_cid_transit_to_task(rq->curr, pcp);
+			else
+				mm_drop_cid_on_cpu(mm, pcp);
+
+		} else if (rq->curr->mm == mm && rq->curr->mm_cid.active) {
+			unsigned int cid = rq->curr->mm_cid.cid;
+
+			/* Ensure it has the transition bit set */
+			if (!cid_in_transit(cid)) {
+				cid = cid_to_transit_cid(cid);
+				rq->curr->mm_cid.cid = cid;
+				pcp->cid = cid;
+			}
+		}
+	}
+	/* Clear the transition bit */
+	WRITE_ONCE(mm->mm_cid.transit, 0);
+}
+
+static inline void mm_cid_transfer_to_cpu(struct task_struct *t, struct mm_cid_pcpu *pcp)
+{
+	if (cid_on_task(t->mm_cid.cid)) {
+		t->mm_cid.cid = cid_to_cpu_cid(t->mm_cid.cid);
+		pcp->cid = t->mm_cid.cid;
+	}
+}
+
+static bool mm_cid_fixup_task_to_cpu(struct task_struct *t, struct mm_struct *mm)
+{
+	/* Remote access to mm::mm_cid::pcpu requires rq_lock */
+	guard(task_rq_lock)(t);
+	/* If the task is not active it is not in the users count */
+	if (!t->mm_cid.active)
+		return false;
+	if (cid_on_task(t->mm_cid.cid)) {
+		/* If running on the CPU, transfer the CID, otherwise drop it */
+		if (task_rq(t)->curr == t)
+			mm_cid_transfer_to_cpu(t, per_cpu_ptr(mm->mm_cid.pcpu, task_cpu(t)));
+		else
+			mm_unset_cid_on_task(t);
+	}
+	return true;
+}
+
+static void __maybe_unused mm_cid_fixup_tasks_to_cpus(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct task_struct *p, *t;
+	unsigned int users;
+
+	/*
+	 * This can obviously race with a concurrent affinity change, which
+	 * increases the number of allowed CPUs for this mm, but that does
+	 * not affect the mode and only changes the CID constraints. A
+	 * possible switch back to per task mode happens either in the
+	 * deferred handler function or in the next fork()/exit().
+	 *
+	 * The caller has already transferred. The newly incoming task is
+	 * already accounted for, but not yet visible.
+	 */
+	users = mm->mm_cid.users - 2;
+	if (!users)
+		return;
+
+	guard(rcu)();
+	for_other_threads(current, t) {
+		if (mm_cid_fixup_task_to_cpu(t, mm))
+			users--;
+	}
+
+	if (!users)
+		return;
+
+	/* Happens only for VM_CLONE processes. */
+	for_each_process_thread(p, t) {
+		if (t == current || t->mm != mm)
+			continue;
+		if (mm_cid_fixup_task_to_cpu(t, mm)) {
+			if (--users == 0)
+				return;
+		}
+	}
+}
+
+static bool sched_mm_cid_add_user(struct task_struct *t, struct mm_struct *mm)
+{
+	t->mm_cid.active = 1;
+	mm->mm_cid.users++;
+	return mm_update_max_cids(mm);
 }
 
 void sched_mm_cid_fork(struct task_struct *t)
@@ -10440,12 +10666,19 @@ void sched_mm_cid_fork(struct task_struc
 	WARN_ON_ONCE(!mm || t->mm_cid.cid != MM_CID_UNSET);
 
 	guard(mutex)(&mm->mm_cid.mutex);
-	guard(raw_spinlock)(&mm->mm_cid.lock);
-	t->mm_cid.active = 1;
-	mm->mm_cid.users++;
-	/* Preset last_cid for mm_cid_select() */
-	t->mm_cid.last_cid = READ_ONCE(mm->mm_cid.max_cids) - 1;
-	mm_update_max_cids(mm);
+	scoped_guard(raw_spinlock, &mm->mm_cid.lock) {
+		sched_mm_cid_add_user(t, mm);
+		/* Preset last_cid for mm_cid_select() */
+		t->mm_cid.last_cid = mm->mm_cid.max_cids - 1;
+	}
+}
+
+static bool sched_mm_cid_remove_user(struct task_struct *t)
+{
+	t->mm_cid.active = 0;
+	mm_unset_cid_on_task(t);
+	t->mm->mm_cid.users--;
+	return mm_update_max_cids(t->mm);
 }
 
 /*
@@ -10460,14 +10693,8 @@ void sched_mm_cid_exit(struct task_struc
 		return;
 
 	guard(mutex)(&mm->mm_cid.mutex);
-	guard(raw_spinlock)(&mm->mm_cid.lock);
-	t->mm_cid.active = 0;
-	mm->mm_cid.users--;
-	if (t->mm_cid.cid != MM_CID_UNSET) {
-		clear_bit(t->mm_cid.cid, mm_cidmask(mm));
-		t->mm_cid.cid = MM_CID_UNSET;
-	}
-	mm_update_max_cids(mm);
+	scoped_guard(raw_spinlock, &mm->mm_cid.lock)
+		sched_mm_cid_remove_user(t);
 }
 
 /* Deactivate MM CID allocation across execve() */
@@ -10496,6 +10723,8 @@ void mm_init_cid(struct mm_struct *mm, s
 	mm->mm_cid.percpu = 0;
 	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
 	mm->mm_cid.users = 0;
+	mm->mm_cid.pcpu_thrs = 0;
+	mm->mm_cid.update_deferred = 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
 	mutex_init(&mm->mm_cid.mutex);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);



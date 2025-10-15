Return-Path: <linux-kernel+bounces-854981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D040ABDFE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B721354273E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168E3431FD;
	Wed, 15 Oct 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VJ4Zjp1S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5I9A+xl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48533EB05
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549399; cv=none; b=onkIsjhNxWMQqr5UpTaSWN3RZRmtPefpygzpLUZmQDVtDZAtSoaAdEt+EDxPszm1+Xft51zIyZ5yCCg+ISyQ6L3s4pBwQqxkSt9IftXXUBD8mPFUuCxbM9QTaZudqF5wBjaIf54pKUXrCse6/KQWmvhRnQ5zd2oZeJ5S05lnH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549399; c=relaxed/simple;
	bh=mOQPtcaiRCLqZ/b7tbn9dVat/xil8Rd4/tkz8Q6Eds8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=uAlIjtWAlRDsrdpM7Do3gQsIgjtvCtso632LAYEdcUn1tLqSaun/W8PNasnR3Eq3JYWu6hXjdhLa3e88qmMMZUY9kupKVk64JMz6yiLscf6ttFM8TJ9SEHMOXY6dyeiJrpz4HkRFZ65tHKgUNZtd7voUhIf6/w1E9iJFEldYfbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VJ4Zjp1S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d5I9A+xl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172835.313805515@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/s0DG47jXUf/Vwc4iZhFxfx8t5KUk/sbBFCf8Rh8hY4=;
	b=VJ4Zjp1S0Zm0YRw5Zys4D6gChwK43Yggjgs8Dt2McYhQ45/7qxeuXfyvXCiNb6JyNS8hD5
	euO6IUmalyYcvIXNXHVuWUv9Km0b+KDfo6ap7FUWJaoqja6P1XzVxLzr40NGdy8T8hQyz7
	4fR9jopTNmKpwC9nCTIOazUL3pci3owfLXpCR+Z4EmvIOrCaOOYrEoYv1/JpyQeAVIj+jx
	ZrAO8GFFxNur4t23rbeDhDtuVThl7KDmZbDgl3C7n0P49PtHQBMkkfabqZD3tASVDDiQlo
	SZQXoS8jN9m95/w+niAY5KdA2TNyqS91riDq5qc+Fi8tDy9TKw3dlIDuHMikGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/s0DG47jXUf/Vwc4iZhFxfx8t5KUk/sbBFCf8Rh8hY4=;
	b=d5I9A+xloS3l/d0fjD06ouJZiwwpEkbwk98kFw7xkd7pgK/kE0Rwzfw3FwrHqY4srXUrMY
	bXtFidhNmleHqHCw==
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
 TCMalloc Team <tcmalloc-eng@google.com>
Subject: [patch 16/19] sched/mmcid: Provide CID ownership mode fixup functions
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:54 +0200 (CEST)

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

As the goal is to avoid serialization of the scheduler hotpath, this
requires that the switch back threshold is maximally nr_cpu_ids / 2.
Otherwise the CID space might become exhausted when tasks are scheduled in
on CPUs which already transferred ownership before the fixup function was
able to free or transfer enough CIDs. That would result in a live lock
because the task loops in mm_get_cid() with runqueue lock held and the
fixup function is stuck on that runqueue lock.

When mm_cid_fixup_cpus_to_tasks() completes it's guaranteed that no CID
related to that MM is owned by a CPU anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq_types.h |   10 +
 kernel/sched/core.c        |  251 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 234 insertions(+), 27 deletions(-)

--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -125,8 +125,9 @@ struct mm_cid_pcpu {
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
@@ -134,8 +135,13 @@ struct mm_mm_cid {
 	struct mm_cid_pcpu	__percpu *pcpu;
 	unsigned int		percpu;
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
@@ -10425,27 +10425,116 @@ void call_trace_sched_update_nr_running(
  * by a CPU (stored in mm::mm_cid.pcpu::cid). CIDs owned by CPUs have the
  * MM_CID_ONCPU bit set. This bit is filtered out by task_cid() when it
  * is actualy handed over to user space in the RSEQ memory.
+ *
+ * Mode switching:
+ *
+ * Switching to per CPU mode happens when the user count becomes greater
+ * than the maximum number of CIDs, which is calculated by:
+ *
+ *	opt_cids = min(mm_cid::nr_cpus_allowed, mm_cid::users);
+ *	max_cids = min(1.25 * opt_cids, nr_cpu_ids);
+ *
+ * The +25% allowance is useful for tight CPU masks in scenarios where only
+ * a few threads are created and destroyed to avoid frequent mode
+ * switches. Though this allowance shrinks, the closer opt_cids becomes to
+ * nr_cpu_ids, which is the (unfortunate) hard ABI limit.
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
+ *	pcpu_thrs = min(opt_cids - (opt_cids / 4), nr_cpu_ids / 2);
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
+ * As the goal is to avoid serialization of the scheduler hotpath, this
+ * requires that the switch back threshold is maximally nr_cpu_ids / 2.
+ * Otherwise the CID space might become exhausted when tasks are scheduled
+ * in on CPUs which already transferred ownership before the fixup function
+ * was able to free or transfer enough CIDs. That would result in a live
+ * lock because the task loops in mm_get_cid() with runqueue lock held and
+ * the fixup function is stuck on that runqueue lock.
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
+	/* Adjust the maximum CIDs to +25% limited by nr_cpu_ids */
+	max_cids = min(opt_cids + (opt_cids / 4), nr_cpu_ids);
+	WRITE_ONCE(mc->max_cids, max_cids);
+}
+
+static inline unsigned int mm_cid_calc_pcpu_thrs(struct mm_mm_cid *mc)
+{
+	unsigned int opt_cids;
+
+	opt_cids = min(mc->nr_cpus_allowed, mc->users);
+	/* See mode switch documentation above! */
+	return min(opt_cids - opt_cids / 4, nr_cpu_ids / 2);
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
+	WRITE_ONCE(mc->percpu, !!mc->pcpu_thrs);
+	return true;
 }
 
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
 {
 	struct cpumask *mm_allowed;
+	struct mm_mm_cid *mc;
 	unsigned int weight;
 
 	/*
@@ -10455,21 +10544,130 @@ static inline void mm_update_cpus_allowe
 	if (!mm || READ_ONCE(mm->mm_cid.nr_cpus_allowed) == nr_cpu_ids ||
 	    !READ_ONCE(mm->mm_cid.users))
 		return;
-
 	/*
 	 * mm::mm_cid::mm_cpus_allowed is the superset of each threads
 	 * allowed CPUs mask which means it can only grow.
 	 */
-	guard(raw_spinlock)(&mm->mm_cid.lock);
+	mc = &mm->mm_cid;
+	guard(raw_spinlock)(&mc->lock);
 	/* Check again under the lock */
-	if (mm->mm_cid.nr_cpus_allowed == nr_cpu_ids || !mm->mm_cid.users)
+	if (mc->nr_cpus_allowed == nr_cpu_ids || !mc->users)
 		return;
+
 	mm_allowed = mm_cpus_allowed(mm);
 	weight = cpumask_or_weight(mm_allowed, mm_allowed, affmsk);
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
+static inline void mm_cid_transfer_to_task(struct task_struct *t, struct mm_cid_pcpu *pcp)
+{
+	if (cid_on_cpu(t->mm_cid.cid)) {
+		t->mm_cid.cid = cpu_cid_to_cid(t->mm_cid.cid);
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
+		if (cid_on_cpu(pcp->cid)) {
+			/* If rq->curr has @mm, fix it up right here */
+			if (rq->curr->mm == mm && rq->curr->mm_cid.active)
+				mm_cid_transfer_to_task(rq->curr, pcp);
+			else
+				mm_drop_cid_on_cpu(mm, pcp);
+		}
+	}
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
+	if (t->mm != mm)
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
+		mm_cid_fixup_task_to_cpu(t, mm);
+		users--;
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
@@ -10479,12 +10677,19 @@ void sched_mm_cid_fork(struct task_struc
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
@@ -10499,14 +10704,8 @@ void sched_mm_cid_exit(struct task_struc
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
@@ -10535,6 +10734,8 @@ void mm_init_cid(struct mm_struct *mm, s
 	mm->mm_cid.percpu = 0;
 	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
 	mm->mm_cid.users = 0;
+	mm->mm_cid.pcpu_thrs = 0;
+	mm->mm_cid.update_deferred = 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
 	mutex_init(&mm->mm_cid.mutex);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);



Return-Path: <linux-kernel+bounces-865002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E54BFC141
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FB262015B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE86A348443;
	Wed, 22 Oct 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T1Nerhna";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qs72A9Zz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED803446B2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137726; cv=none; b=LRH00KCzKaWSRXrmeIqvApPrsuP4ETAEDaQN6Jb44RXzRO0sBqXZUFlQr4+ckRnC4jtl2vNr1xxb+1O1OX22DPi0MHJXL9rrx9NoKQ42LGrpxPy2HCNtIphC44jOo0yHErGEOawrnpzp4+IB2/qwHACTcTvjkKJkq1VqdN8fHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137726; c=relaxed/simple;
	bh=q90TjAU1J0cL88w/cMy3B2cs523Sg3jGQ7IrAUpWhZo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DT7rBfeJGP4lYZdnyOAFY43z2SRkCobYAAQxuCHFZCuIfoi8/EdNfb03mTkuSzv20xuMXp+mLQwfhlkHrJBlWPeiBnqz05Y4fqpBkjJLIlVihp9/0hurXPQCPnOp5FZx/F0bWyiPwr2mJcX5xow9+08gU/6+Hmg8j9pbRWBGnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T1Nerhna; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qs72A9Zz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110555.458290368@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2NMV4HjPEEUdEi1WEPFBZ8SJx95+D+W3gSgLdwMyQSg=;
	b=T1NerhnamNnu6+QG/bTDPly/TRy5sNA9bzfq2EbPzTkllGFTPassekKv+A5fniLYfV0oGc
	AUq4z1eqW3ogOeKGhWZSOhpttc5Tw05jrNubKvp6euyfz9wUMhGkTkxnbUGWsJL1fpt3X4
	H0/bcILWJMEtCVXznmlP7OSdK0+uWbflte48fntorvP6aHQg0x3CMyUpBdVJfxnTSHTpME
	G2uGGdxCsEo22fygFFnUHNUXNbnb0x5JBAB2WQ415zVx/C9KecF/RdbHN2WTfOHl9J1FaH
	BUngavD3V1Z9Sbn0WuIWKjXr86yTaDS/iiy0NuHhWn1Ds7GN1PqngoofasfEqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2NMV4HjPEEUdEi1WEPFBZ8SJx95+D+W3gSgLdwMyQSg=;
	b=Qs72A9ZzJ1vQg5pwWvTwa1j7mpcta4tNmTadlCdpfSXE0IIDBgr3w0l36Vue7yvOiSu855
	ezIge1UwDXsqMyBA==
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
Subject: [patch V2 01/20] sched/mmcid: Revert the complex CID management
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:20 +0200 (CEST)

The CID management is a complex beast, which affects both scheduling and
task migration. The compaction mechanism forces random tasks of a process
into task work on exit to user space causing latency spikes.

Revert back to the initial simple bitmap allocating mechanics, which are
known to have scalability issues as that allows to gradually build up a
replacement functionality in a reviewable way.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mm_types.h |   53 ----
 kernel/fork.c            |    5 
 kernel/sched/core.c      |  514 +----------------------------------------------
 kernel/sched/sched.h     |  291 +++-----------------------
 4 files changed, 64 insertions(+), 799 deletions(-)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/87tt0k3oks.ffs@tglx


--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -922,13 +922,9 @@ struct vm_area_struct {
 #define vma_policy(vma) NULL
 #endif
 
-#ifdef CONFIG_SCHED_MM_CID
 struct mm_cid {
-	u64 time;
-	int cid;
-	int recent_cid;
+	unsigned int cid;
 };
-#endif
 
 /*
  * Opaque type representing current mm_struct flag state. Must be accessed via
@@ -1000,12 +996,6 @@ struct mm_struct {
 		 * runqueue locks.
 		 */
 		struct mm_cid __percpu *pcpu_cid;
-		/*
-		 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
-		 *
-		 * When the next mm_cid scan is due (in jiffies).
-		 */
-		unsigned long mm_cid_next_scan;
 		/**
 		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
 		 *
@@ -1014,14 +1004,6 @@ struct mm_struct {
 		 */
 		unsigned int nr_cpus_allowed;
 		/**
-		 * @max_nr_cid: Maximum number of allowed concurrency
-		 *              IDs allocated.
-		 *
-		 * Track the highest number of allowed concurrency IDs
-		 * allocated for the mm.
-		 */
-		atomic_t max_nr_cid;
-		/**
 		 * @cpus_allowed_lock: Lock protecting mm cpus_allowed.
 		 *
 		 * Provide mutual exclusion for mm cpus_allowed and
@@ -1371,35 +1353,7 @@ static inline void vma_iter_init(struct
 
 #ifdef CONFIG_SCHED_MM_CID
 
-enum mm_cid_state {
-	MM_CID_UNSET = -1U,		/* Unset state has lazy_put flag set. */
-	MM_CID_LAZY_PUT = (1U << 31),
-};
-
-static inline bool mm_cid_is_unset(int cid)
-{
-	return cid == MM_CID_UNSET;
-}
-
-static inline bool mm_cid_is_lazy_put(int cid)
-{
-	return !mm_cid_is_unset(cid) && (cid & MM_CID_LAZY_PUT);
-}
-
-static inline bool mm_cid_is_valid(int cid)
-{
-	return !(cid & MM_CID_LAZY_PUT);
-}
-
-static inline int mm_cid_set_lazy_put(int cid)
-{
-	return cid | MM_CID_LAZY_PUT;
-}
-
-static inline int mm_cid_clear_lazy_put(int cid)
-{
-	return cid & ~MM_CID_LAZY_PUT;
-}
+#define	MM_CID_UNSET	(~0U)
 
 /*
  * mm_cpus_allowed: Union of all mm's threads allowed CPUs.
@@ -1432,11 +1386,8 @@ static inline void mm_init_cid(struct mm
 		struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, i);
 
 		pcpu_cid->cid = MM_CID_UNSET;
-		pcpu_cid->recent_cid = MM_CID_UNSET;
-		pcpu_cid->time = 0;
 	}
 	mm->nr_cpus_allowed = p->nr_cpus_allowed;
-	atomic_set(&mm->max_nr_cid, 0);
 	raw_spin_lock_init(&mm->cpus_allowed_lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	cpumask_clear(mm_cidmask(mm));
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -955,10 +955,9 @@ static struct task_struct *dup_task_stru
 #endif
 
 #ifdef CONFIG_SCHED_MM_CID
-	tsk->mm_cid = -1;
-	tsk->last_mm_cid = -1;
+	tsk->mm_cid = MM_CID_UNSET;
+	tsk->last_mm_cid = MM_CID_UNSET;
 	tsk->mm_cid_active = 0;
-	tsk->migrate_from_cpu = -1;
 #endif
 	return tsk;
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2128,8 +2128,6 @@ void activate_task(struct rq *rq, struct
 {
 	if (task_on_rq_migrating(p))
 		flags |= ENQUEUE_MIGRATED;
-	if (flags & ENQUEUE_MIGRATED)
-		sched_mm_cid_migrate_to(rq, p);
 
 	enqueue_task(rq, p, flags);
 
@@ -3329,7 +3327,6 @@ void set_task_cpu(struct task_struct *p,
 		if (p->sched_class->migrate_task_rq)
 			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
-		sched_mm_cid_migrate_from(p);
 		perf_event_task_migrate(p);
 	}
 
@@ -5312,8 +5309,7 @@ context_switch(struct rq *rq, struct tas
 		}
 	}
 
-	/* switch_mm_cid() requires the memory barriers above. */
-	switch_mm_cid(rq, prev, next);
+	switch_mm_cid(prev, next);
 
 	/*
 	 * Tell rseq that the task was scheduled in. Must be after
@@ -5604,7 +5600,6 @@ void sched_tick(void)
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
-	task_tick_mm_cid(rq, donor);
 	scx_tick(rq);
 
 	rq_unlock(rq, &rf);
@@ -10374,522 +10369,47 @@ void call_trace_sched_update_nr_running(
 }
 
 #ifdef CONFIG_SCHED_MM_CID
-
 /*
- * @cid_lock: Guarantee forward-progress of cid allocation.
- *
- * Concurrency ID allocation within a bitmap is mostly lock-free. The cid_lock
- * is only used when contention is detected by the lock-free allocation so
- * forward progress can be guaranteed.
- */
-DEFINE_RAW_SPINLOCK(cid_lock);
-
-/*
- * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
- *
- * When @use_cid_lock is 0, the cid allocation is lock-free. When contention is
- * detected, it is set to 1 to ensure that all newly coming allocations are
- * serialized by @cid_lock until the allocation which detected contention
- * completes and sets @use_cid_lock back to 0. This guarantees forward progress
- * of a cid allocation.
- */
-int use_cid_lock;
-
-/*
- * mm_cid remote-clear implements a lock-free algorithm to clear per-mm/cpu cid
- * concurrently with respect to the execution of the source runqueue context
- * switch.
- *
- * There is one basic properties we want to guarantee here:
- *
- * (1) Remote-clear should _never_ mark a per-cpu cid UNSET when it is actively
- * used by a task. That would lead to concurrent allocation of the cid and
- * userspace corruption.
- *
- * Provide this guarantee by introducing a Dekker memory ordering to guarantee
- * that a pair of loads observe at least one of a pair of stores, which can be
- * shown as:
- *
- *      X = Y = 0
- *
- *      w[X]=1          w[Y]=1
- *      MB              MB
- *      r[Y]=y          r[X]=x
- *
- * Which guarantees that x==0 && y==0 is impossible. But rather than using
- * values 0 and 1, this algorithm cares about specific state transitions of the
- * runqueue current task (as updated by the scheduler context switch), and the
- * per-mm/cpu cid value.
- *
- * Let's introduce task (Y) which has task->mm == mm and task (N) which has
- * task->mm != mm for the rest of the discussion. There are two scheduler state
- * transitions on context switch we care about:
- *
- * (TSA) Store to rq->curr with transition from (N) to (Y)
- *
- * (TSB) Store to rq->curr with transition from (Y) to (N)
- *
- * On the remote-clear side, there is one transition we care about:
- *
- * (TMA) cmpxchg to *pcpu_cid to set the LAZY flag
- *
- * There is also a transition to UNSET state which can be performed from all
- * sides (scheduler, remote-clear). It is always performed with a cmpxchg which
- * guarantees that only a single thread will succeed:
- *
- * (TMB) cmpxchg to *pcpu_cid to mark UNSET
- *
- * Just to be clear, what we do _not_ want to happen is a transition to UNSET
- * when a thread is actively using the cid (property (1)).
- *
- * Let's looks at the relevant combinations of TSA/TSB, and TMA transitions.
- *
- * Scenario A) (TSA)+(TMA) (from next task perspective)
- *
- * CPU0                                      CPU1
- *
- * Context switch CS-1                       Remote-clear
- *   - store to rq->curr: (N)->(Y) (TSA)     - cmpxchg to *pcpu_id to LAZY (TMA)
- *                                             (implied barrier after cmpxchg)
- *   - switch_mm_cid()
- *     - memory barrier (see switch_mm_cid()
- *       comment explaining how this barrier
- *       is combined with other scheduler
- *       barriers)
- *     - mm_cid_get (next)
- *       - READ_ONCE(*pcpu_cid)              - rcu_dereference(src_rq->curr)
- *
- * This Dekker ensures that either task (Y) is observed by the
- * rcu_dereference() or the LAZY flag is observed by READ_ONCE(), or both are
- * observed.
- *
- * If task (Y) store is observed by rcu_dereference(), it means that there is
- * still an active task on the cpu. Remote-clear will therefore not transition
- * to UNSET, which fulfills property (1).
- *
- * If task (Y) is not observed, but the lazy flag is observed by READ_ONCE(),
- * it will move its state to UNSET, which clears the percpu cid perhaps
- * uselessly (which is not an issue for correctness). Because task (Y) is not
- * observed, CPU1 can move ahead to set the state to UNSET. Because moving
- * state to UNSET is done with a cmpxchg expecting that the old state has the
- * LAZY flag set, only one thread will successfully UNSET.
- *
- * If both states (LAZY flag and task (Y)) are observed, the thread on CPU0
- * will observe the LAZY flag and transition to UNSET (perhaps uselessly), and
- * CPU1 will observe task (Y) and do nothing more, which is fine.
- *
- * What we are effectively preventing with this Dekker is a scenario where
- * neither LAZY flag nor store (Y) are observed, which would fail property (1)
- * because this would UNSET a cid which is actively used.
+ * When a task exits, the MM CID held by the task is not longer required as
+ * the task cannot return to user space.
  */
-
-void sched_mm_cid_migrate_from(struct task_struct *t)
-{
-	t->migrate_from_cpu = task_cpu(t);
-}
-
-static
-int __sched_mm_cid_migrate_from_fetch_cid(struct rq *src_rq,
-					  struct task_struct *t,
-					  struct mm_cid *src_pcpu_cid)
-{
-	struct mm_struct *mm = t->mm;
-	struct task_struct *src_task;
-	int src_cid, last_mm_cid;
-
-	if (!mm)
-		return -1;
-
-	last_mm_cid = t->last_mm_cid;
-	/*
-	 * If the migrated task has no last cid, or if the current
-	 * task on src rq uses the cid, it means the source cid does not need
-	 * to be moved to the destination cpu.
-	 */
-	if (last_mm_cid == -1)
-		return -1;
-	src_cid = READ_ONCE(src_pcpu_cid->cid);
-	if (!mm_cid_is_valid(src_cid) || last_mm_cid != src_cid)
-		return -1;
-
-	/*
-	 * If we observe an active task using the mm on this rq, it means we
-	 * are not the last task to be migrated from this cpu for this mm, so
-	 * there is no need to move src_cid to the destination cpu.
-	 */
-	guard(rcu)();
-	src_task = rcu_dereference(src_rq->curr);
-	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
-		t->last_mm_cid = -1;
-		return -1;
-	}
-
-	return src_cid;
-}
-
-static
-int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
-					      struct task_struct *t,
-					      struct mm_cid *src_pcpu_cid,
-					      int src_cid)
-{
-	struct task_struct *src_task;
-	struct mm_struct *mm = t->mm;
-	int lazy_cid;
-
-	if (src_cid == -1)
-		return -1;
-
-	/*
-	 * Attempt to clear the source cpu cid to move it to the destination
-	 * cpu.
-	 */
-	lazy_cid = mm_cid_set_lazy_put(src_cid);
-	if (!try_cmpxchg(&src_pcpu_cid->cid, &src_cid, lazy_cid))
-		return -1;
-
-	/*
-	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
-	 * rq->curr->mm matches the scheduler barrier in context_switch()
-	 * between store to rq->curr and load of prev and next task's
-	 * per-mm/cpu cid.
-	 *
-	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
-	 * rq->curr->mm_cid_active matches the barrier in
-	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
-	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
-	 * load of per-mm/cpu cid.
-	 */
-
-	/*
-	 * If we observe an active task using the mm on this rq after setting
-	 * the lazy-put flag, this task will be responsible for transitioning
-	 * from lazy-put flag set to MM_CID_UNSET.
-	 */
-	scoped_guard (rcu) {
-		src_task = rcu_dereference(src_rq->curr);
-		if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
-			/*
-			 * We observed an active task for this mm, there is therefore
-			 * no point in moving this cid to the destination cpu.
-			 */
-			t->last_mm_cid = -1;
-			return -1;
-		}
-	}
-
-	/*
-	 * The src_cid is unused, so it can be unset.
-	 */
-	if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
-		return -1;
-	WRITE_ONCE(src_pcpu_cid->recent_cid, MM_CID_UNSET);
-	return src_cid;
-}
-
-/*
- * Migration to dst cpu. Called with dst_rq lock held.
- * Interrupts are disabled, which keeps the window of cid ownership without the
- * source rq lock held small.
- */
-void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
-{
-	struct mm_cid *src_pcpu_cid, *dst_pcpu_cid;
-	struct mm_struct *mm = t->mm;
-	int src_cid, src_cpu;
-	bool dst_cid_is_set;
-	struct rq *src_rq;
-
-	lockdep_assert_rq_held(dst_rq);
-
-	if (!mm)
-		return;
-	src_cpu = t->migrate_from_cpu;
-	if (src_cpu == -1) {
-		t->last_mm_cid = -1;
-		return;
-	}
-	/*
-	 * Move the src cid if the dst cid is unset. This keeps id
-	 * allocation closest to 0 in cases where few threads migrate around
-	 * many CPUs.
-	 *
-	 * If destination cid or recent cid is already set, we may have
-	 * to just clear the src cid to ensure compactness in frequent
-	 * migrations scenarios.
-	 *
-	 * It is not useful to clear the src cid when the number of threads is
-	 * greater or equal to the number of allowed CPUs, because user-space
-	 * can expect that the number of allowed cids can reach the number of
-	 * allowed CPUs.
-	 */
-	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
-	dst_cid_is_set = !mm_cid_is_unset(READ_ONCE(dst_pcpu_cid->cid)) ||
-			 !mm_cid_is_unset(READ_ONCE(dst_pcpu_cid->recent_cid));
-	if (dst_cid_is_set && atomic_read(&mm->mm_users) >= READ_ONCE(mm->nr_cpus_allowed))
-		return;
-	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, src_cpu);
-	src_rq = cpu_rq(src_cpu);
-	src_cid = __sched_mm_cid_migrate_from_fetch_cid(src_rq, t, src_pcpu_cid);
-	if (src_cid == -1)
-		return;
-	src_cid = __sched_mm_cid_migrate_from_try_steal_cid(src_rq, t, src_pcpu_cid,
-							    src_cid);
-	if (src_cid == -1)
-		return;
-	if (dst_cid_is_set) {
-		__mm_cid_put(mm, src_cid);
-		return;
-	}
-	/* Move src_cid to dst cpu. */
-	mm_cid_snapshot_time(dst_rq, mm);
-	WRITE_ONCE(dst_pcpu_cid->cid, src_cid);
-	WRITE_ONCE(dst_pcpu_cid->recent_cid, src_cid);
-}
-
-static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_cid,
-				      int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *t;
-	int cid, lazy_cid;
-
-	cid = READ_ONCE(pcpu_cid->cid);
-	if (!mm_cid_is_valid(cid))
-		return;
-
-	/*
-	 * Clear the cpu cid if it is set to keep cid allocation compact.  If
-	 * there happens to be other tasks left on the source cpu using this
-	 * mm, the next task using this mm will reallocate its cid on context
-	 * switch.
-	 */
-	lazy_cid = mm_cid_set_lazy_put(cid);
-	if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
-		return;
-
-	/*
-	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
-	 * rq->curr->mm matches the scheduler barrier in context_switch()
-	 * between store to rq->curr and load of prev and next task's
-	 * per-mm/cpu cid.
-	 *
-	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
-	 * rq->curr->mm_cid_active matches the barrier in
-	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
-	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
-	 * load of per-mm/cpu cid.
-	 */
-
-	/*
-	 * If we observe an active task using the mm on this rq after setting
-	 * the lazy-put flag, that task will be responsible for transitioning
-	 * from lazy-put flag set to MM_CID_UNSET.
-	 */
-	scoped_guard (rcu) {
-		t = rcu_dereference(rq->curr);
-		if (READ_ONCE(t->mm_cid_active) && t->mm == mm)
-			return;
-	}
-
-	/*
-	 * The cid is unused, so it can be unset.
-	 * Disable interrupts to keep the window of cid ownership without rq
-	 * lock small.
-	 */
-	scoped_guard (irqsave) {
-		if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
-			__mm_cid_put(mm, cid);
-	}
-}
-
-static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-	struct mm_cid *pcpu_cid;
-	struct task_struct *curr;
-	u64 rq_clock;
-
-	/*
-	 * rq->clock load is racy on 32-bit but one spurious clear once in a
-	 * while is irrelevant.
-	 */
-	rq_clock = READ_ONCE(rq->clock);
-	pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu);
-
-	/*
-	 * In order to take care of infrequently scheduled tasks, bump the time
-	 * snapshot associated with this cid if an active task using the mm is
-	 * observed on this rq.
-	 */
-	scoped_guard (rcu) {
-		curr = rcu_dereference(rq->curr);
-		if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
-			WRITE_ONCE(pcpu_cid->time, rq_clock);
-			return;
-		}
-	}
-
-	if (rq_clock < pcpu_cid->time + SCHED_MM_CID_PERIOD_NS)
-		return;
-	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
-}
-
-static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
-					     int weight)
-{
-	struct mm_cid *pcpu_cid;
-	int cid;
-
-	pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu);
-	cid = READ_ONCE(pcpu_cid->cid);
-	if (!mm_cid_is_valid(cid) || cid < weight)
-		return;
-	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
-}
-
-static void task_mm_cid_work(struct callback_head *work)
-{
-	unsigned long now = jiffies, old_scan, next_scan;
-	struct task_struct *t = current;
-	struct cpumask *cidmask;
-	struct mm_struct *mm;
-	int weight, cpu;
-
-	WARN_ON_ONCE(t != container_of(work, struct task_struct, cid_work));
-
-	work->next = work;	/* Prevent double-add */
-	if (t->flags & PF_EXITING)
-		return;
-	mm = t->mm;
-	if (!mm)
-		return;
-	old_scan = READ_ONCE(mm->mm_cid_next_scan);
-	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
-	if (!old_scan) {
-		unsigned long res;
-
-		res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
-		if (res != old_scan)
-			old_scan = res;
-		else
-			old_scan = next_scan;
-	}
-	if (time_before(now, old_scan))
-		return;
-	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
-		return;
-	cidmask = mm_cidmask(mm);
-	/* Clear cids that were not recently used. */
-	for_each_possible_cpu(cpu)
-		sched_mm_cid_remote_clear_old(mm, cpu);
-	weight = cpumask_weight(cidmask);
-	/*
-	 * Clear cids that are greater or equal to the cidmask weight to
-	 * recompact it.
-	 */
-	for_each_possible_cpu(cpu)
-		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
-}
-
-void init_sched_mm_cid(struct task_struct *t)
-{
-	struct mm_struct *mm = t->mm;
-	int mm_users = 0;
-
-	if (mm) {
-		mm_users = atomic_read(&mm->mm_users);
-		if (mm_users == 1)
-			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
-	}
-	t->cid_work.next = &t->cid_work;	/* Protect against double add */
-	init_task_work(&t->cid_work, task_mm_cid_work);
-}
-
-void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
-{
-	struct callback_head *work = &curr->cid_work;
-	unsigned long now = jiffies;
-
-	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
-	    work->next != work)
-		return;
-	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
-		return;
-
-	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME);
-}
-
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq *rq;
 
-	if (!mm)
+	if (!mm || !t->mm_cid_active)
 		return;
 
-	preempt_disable();
-	rq = this_rq();
-	guard(rq_lock_irqsave)(rq);
-	preempt_enable_no_resched();	/* holding spinlock */
-	WRITE_ONCE(t->mm_cid_active, 0);
-	/*
-	 * Store t->mm_cid_active before loading per-mm/cpu cid.
-	 * Matches barrier in sched_mm_cid_remote_clear_old().
-	 */
-	smp_mb();
-	mm_cid_put(mm);
-	t->last_mm_cid = t->mm_cid = -1;
+	guard(preempt)();
+	t->mm_cid_active = 0;
+	if (t->mm_cid != MM_CID_UNSET) {
+		cpumask_clear_cpu(t->mm_cid, mm_cidmask(mm));
+		t->mm_cid = MM_CID_UNSET;
+	}
 }
 
+/* Deactivate MM CID allocation across execve() */
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
-	struct mm_struct *mm = t->mm;
-	struct rq *rq;
-
-	if (!mm)
-		return;
-
-	preempt_disable();
-	rq = this_rq();
-	guard(rq_lock_irqsave)(rq);
-	preempt_enable_no_resched();	/* holding spinlock */
-	WRITE_ONCE(t->mm_cid_active, 0);
-	/*
-	 * Store t->mm_cid_active before loading per-mm/cpu cid.
-	 * Matches barrier in sched_mm_cid_remote_clear_old().
-	 */
-	smp_mb();
-	mm_cid_put(mm);
-	t->last_mm_cid = t->mm_cid = -1;
+	sched_mm_cid_exit_signals(t);
 }
 
+/* Reactivate MM CID after successful execve() */
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq *rq;
 
 	if (!mm)
 		return;
 
-	preempt_disable();
-	rq = this_rq();
-	scoped_guard (rq_lock_irqsave, rq) {
-		preempt_enable_no_resched();	/* holding spinlock */
-		WRITE_ONCE(t->mm_cid_active, 1);
-		/*
-		 * Store t->mm_cid_active before loading per-mm/cpu cid.
-		 * Matches barrier in sched_mm_cid_remote_clear_old().
-		 */
-		smp_mb();
-		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, t, mm);
-	}
+	guard(preempt)();
+	t->mm_cid_active = 1;
+	mm_cid_select(t);
 }
 
 void sched_mm_cid_fork(struct task_struct *t)
 {
-	WARN_ON_ONCE(!t->mm || t->mm_cid != -1);
+	WARN_ON_ONCE(!t->mm || t->mm_cid != MM_CID_UNSET);
 	t->mm_cid_active = 1;
 }
 #endif /* CONFIG_SCHED_MM_CID */
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3539,288 +3539,83 @@ extern void sched_dynamic_update(int mod
 extern const char *preempt_modes[];
 
 #ifdef CONFIG_SCHED_MM_CID
-
-#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
-#define MM_CID_SCAN_DELAY	100			/* 100ms */
-
-extern raw_spinlock_t cid_lock;
-extern int use_cid_lock;
-
-extern void sched_mm_cid_migrate_from(struct task_struct *t);
-extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
-extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
-extern void init_sched_mm_cid(struct task_struct *t);
-
-static inline void __mm_cid_put(struct mm_struct *mm, int cid)
-{
-	if (cid < 0)
-		return;
-	cpumask_clear_cpu(cid, mm_cidmask(mm));
-}
-
-/*
- * The per-mm/cpu cid can have the MM_CID_LAZY_PUT flag set or transition to
- * the MM_CID_UNSET state without holding the rq lock, but the rq lock needs to
- * be held to transition to other states.
- *
- * State transitions synchronized with cmpxchg or try_cmpxchg need to be
- * consistent across CPUs, which prevents use of this_cpu_cmpxchg.
- */
-static inline void mm_cid_put_lazy(struct task_struct *t)
+static inline void init_sched_mm_cid(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	int cid;
+	unsigned int max_cid;
 
-	lockdep_assert_irqs_disabled();
-	cid = __this_cpu_read(pcpu_cid->cid);
-	if (!mm_cid_is_lazy_put(cid) ||
-	    !try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
+	if (!mm)
 		return;
-	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
-}
-
-static inline int mm_cid_pcpu_unset(struct mm_struct *mm)
-{
-	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	int cid, res;
 
-	lockdep_assert_irqs_disabled();
-	cid = __this_cpu_read(pcpu_cid->cid);
-	for (;;) {
-		if (mm_cid_is_unset(cid))
-			return MM_CID_UNSET;
-		/*
-		 * Attempt transition from valid or lazy-put to unset.
-		 */
-		res = cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
-		if (res == cid)
-			break;
-		cid = res;
-	}
-	return cid;
+	/* Preset last_mm_cid */
+	max_cid = min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm_users));
+	t->last_mm_cid = max_cid - 1;
 }
 
-static inline void mm_cid_put(struct mm_struct *mm)
+static inline bool __mm_cid_get(struct task_struct *t, unsigned int cid, unsigned int max_cids)
 {
-	int cid;
+	struct mm_struct *mm = t->mm;
 
-	lockdep_assert_irqs_disabled();
-	cid = mm_cid_pcpu_unset(mm);
-	if (cid == MM_CID_UNSET)
-		return;
-	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+	if (cid >= max_cids)
+		return false;
+	if (cpumask_test_and_set_cpu(cid, mm_cidmask(mm)))
+		return false;
+	t->mm_cid = t->last_mm_cid = cid;
+	__this_cpu_write(mm->pcpu_cid->cid, cid);
+	return true;
 }
 
-static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
+static inline bool mm_cid_get(struct task_struct *t)
 {
-	struct cpumask *cidmask = mm_cidmask(mm);
-	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	int cid, max_nr_cid, allowed_max_nr_cid;
+	struct mm_struct *mm = t->mm;
+	unsigned int max_cids;
 
-	/*
-	 * After shrinking the number of threads or reducing the number
-	 * of allowed cpus, reduce the value of max_nr_cid so expansion
-	 * of cid allocation will preserve cache locality if the number
-	 * of threads or allowed cpus increase again.
-	 */
-	max_nr_cid = atomic_read(&mm->max_nr_cid);
-	while ((allowed_max_nr_cid = min_t(int, READ_ONCE(mm->nr_cpus_allowed),
-					   atomic_read(&mm->mm_users))),
-	       max_nr_cid > allowed_max_nr_cid) {
-		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into max_nr_cid. */
-		if (atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid, allowed_max_nr_cid)) {
-			max_nr_cid = allowed_max_nr_cid;
-			break;
-		}
-	}
-	/* Try to re-use recent cid. This improves cache locality. */
-	cid = __this_cpu_read(pcpu_cid->recent_cid);
-	if (!mm_cid_is_unset(cid) && cid < max_nr_cid &&
-	    !cpumask_test_and_set_cpu(cid, cidmask))
-		return cid;
-	/*
-	 * Expand cid allocation if the maximum number of concurrency
-	 * IDs allocated (max_nr_cid) is below the number cpus allowed
-	 * and number of threads. Expanding cid allocation as much as
-	 * possible improves cache locality.
-	 */
-	cid = max_nr_cid;
-	while (cid < READ_ONCE(mm->nr_cpus_allowed) && cid < atomic_read(&mm->mm_users)) {
-		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into cid. */
-		if (!atomic_try_cmpxchg(&mm->max_nr_cid, &cid, cid + 1))
-			continue;
-		if (!cpumask_test_and_set_cpu(cid, cidmask))
-			return cid;
-	}
-	/*
-	 * Find the first available concurrency id.
-	 * Retry finding first zero bit if the mask is temporarily
-	 * filled. This only happens during concurrent remote-clear
-	 * which owns a cid without holding a rq lock.
-	 */
-	for (;;) {
-		cid = cpumask_first_zero(cidmask);
-		if (cid < READ_ONCE(mm->nr_cpus_allowed))
-			break;
-		cpu_relax();
-	}
-	if (cpumask_test_and_set_cpu(cid, cidmask))
-		return -1;
+	max_cids = min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm_users));
 
-	return cid;
-}
+	/* Try to reuse the last CID of this task */
+	if (__mm_cid_get(t, t->last_mm_cid, max_cids))
+		return true;
 
-/*
- * Save a snapshot of the current runqueue time of this cpu
- * with the per-cpu cid value, allowing to estimate how recently it was used.
- */
-static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
-{
-	struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(rq));
+	/* Try to reuse the last CID of this mm on this CPU */
+	if (__mm_cid_get(t, __this_cpu_read(mm->pcpu_cid->cid), max_cids))
+		return true;
 
-	lockdep_assert_rq_held(rq);
-	WRITE_ONCE(pcpu_cid->time, rq->clock);
+	/* Try the first zero bit in the cidmask. */
+	return __mm_cid_get(t, cpumask_first_zero(mm_cidmask(mm)), max_cids);
 }
 
-static inline int __mm_cid_get(struct rq *rq, struct task_struct *t,
-			       struct mm_struct *mm)
+static inline void mm_cid_select(struct task_struct *t)
 {
-	int cid;
-
-	/*
-	 * All allocations (even those using the cid_lock) are lock-free. If
-	 * use_cid_lock is set, hold the cid_lock to perform cid allocation to
-	 * guarantee forward progress.
-	 */
-	if (!READ_ONCE(use_cid_lock)) {
-		cid = __mm_cid_try_get(t, mm);
-		if (cid >= 0)
-			goto end;
-		raw_spin_lock(&cid_lock);
-	} else {
-		raw_spin_lock(&cid_lock);
-		cid = __mm_cid_try_get(t, mm);
-		if (cid >= 0)
-			goto unlock;
-	}
-
-	/*
-	 * cid concurrently allocated. Retry while forcing following
-	 * allocations to use the cid_lock to ensure forward progress.
-	 */
-	WRITE_ONCE(use_cid_lock, 1);
 	/*
-	 * Set use_cid_lock before allocation. Only care about program order
-	 * because this is only required for forward progress.
+	 * mm_cid_get() can fail when the maximum CID, which is determined
+	 * by min(mm->nr_cpus_allowed, mm->mm_users) changes concurrently.
+	 * That's a transient failure as there cannot be more tasks
+	 * concurrently on a CPU (or about to be scheduled in) than that.
 	 */
-	barrier();
-	/*
-	 * Retry until it succeeds. It is guaranteed to eventually succeed once
-	 * all newcoming allocations observe the use_cid_lock flag set.
-	 */
-	do {
-		cid = __mm_cid_try_get(t, mm);
-		cpu_relax();
-	} while (cid < 0);
-	/*
-	 * Allocate before clearing use_cid_lock. Only care about
-	 * program order because this is for forward progress.
-	 */
-	barrier();
-	WRITE_ONCE(use_cid_lock, 0);
-unlock:
-	raw_spin_unlock(&cid_lock);
-end:
-	mm_cid_snapshot_time(rq, mm);
-
-	return cid;
-}
-
-static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
-			     struct mm_struct *mm)
-{
-	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	struct cpumask *cpumask;
-	int cid;
-
-	lockdep_assert_rq_held(rq);
-	cpumask = mm_cidmask(mm);
-	cid = __this_cpu_read(pcpu_cid->cid);
-	if (mm_cid_is_valid(cid)) {
-		mm_cid_snapshot_time(rq, mm);
-		return cid;
-	}
-	if (mm_cid_is_lazy_put(cid)) {
-		if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
-			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+	for (;;) {
+		if (mm_cid_get(t))
+			break;
 	}
-	cid = __mm_cid_get(rq, t, mm);
-	__this_cpu_write(pcpu_cid->cid, cid);
-	__this_cpu_write(pcpu_cid->recent_cid, cid);
-
-	return cid;
 }
 
-static inline void switch_mm_cid(struct rq *rq,
-				 struct task_struct *prev,
-				 struct task_struct *next)
+static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
 {
-	/*
-	 * Provide a memory barrier between rq->curr store and load of
-	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
-	 *
-	 * Should be adapted if context_switch() is modified.
-	 */
-	if (!next->mm) {                                // to kernel
-		/*
-		 * user -> kernel transition does not guarantee a barrier, but
-		 * we can use the fact that it performs an atomic operation in
-		 * mmgrab().
-		 */
-		if (prev->mm)                           // from user
-			smp_mb__after_mmgrab();
-		/*
-		 * kernel -> kernel transition does not change rq->curr->mm
-		 * state. It stays NULL.
-		 */
-	} else {                                        // to user
-		/*
-		 * kernel -> user transition does not provide a barrier
-		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
-		 * Provide it here.
-		 */
-		if (!prev->mm) {                        // from kernel
-			smp_mb();
-		} else {				// from user
-			/*
-			 * user->user transition relies on an implicit
-			 * memory barrier in switch_mm() when
-			 * current->mm changes. If the architecture
-			 * switch_mm() does not have an implicit memory
-			 * barrier, it is emitted here.  If current->mm
-			 * is unchanged, no barrier is needed.
-			 */
-			smp_mb__after_switch_mm();
-		}
-	}
 	if (prev->mm_cid_active) {
-		mm_cid_snapshot_time(rq, prev->mm);
-		mm_cid_put_lazy(prev);
-		prev->mm_cid = -1;
+		if (prev->mm_cid != MM_CID_UNSET)
+			cpumask_clear_cpu(prev->mm_cid, mm_cidmask(prev->mm));
+		prev->mm_cid = MM_CID_UNSET;
 	}
+
 	if (next->mm_cid_active) {
-		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next, next->mm);
+		mm_cid_select(next);
 		rseq_sched_set_task_mm_cid(next, next->mm_cid);
 	}
 }
 
 #else /* !CONFIG_SCHED_MM_CID: */
-static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
-static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
-static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
-static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
 static inline void init_sched_mm_cid(struct task_struct *t) { }
+static inline void mm_cid_select(struct task_struct *t) { }
+static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
 #endif /* !CONFIG_SCHED_MM_CID */
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);



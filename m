Return-Path: <linux-kernel+bounces-839728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1412EBB2432
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9323519C8228
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7B26A8D2;
	Thu,  2 Oct 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oan4Wl1U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E1mhSHhy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBB1F16B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759368131; cv=none; b=B9CO0NWJBzNFB5wftzd3cDqau0fi8Vp847Ve/yIaeAfltEm/+7UM/Ca7zvIlKoMly0b1fNhkfXg7bAFm/8KgC1fS6aFpRh2f7a6baKbPvUjViy0Vn+oGMDKAOjP8mncnSGY9alV/u/qE55YFq3EqeZHVkUH/sfpdhzoXlMFT3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759368131; c=relaxed/simple;
	bh=FkhJ0bn/dLik5yr81XwhILcK9FmXeiA+QBiMy0wZ/u8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iu74mQ6N+oXzt+nwCaHtrk2aj0b2khhA0w+adL+MeWLeYta50OsLyLKj/+JRIvf9qXnyWVeHSUZbyrf8dw4UqGx4BhsLz2aMths56P2Pt3UVBuVEV4MQmmW4T7i7c3Z2W+D8OLw4tF/0R7eM1h68cdNUVF9Ft+v2HUbBQnGwLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oan4Wl1U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E1mhSHhy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759368127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G5HhcgVdGP3xqgtLy3Tc/szbjeC6+qay+6ptLrUyw/k=;
	b=Oan4Wl1U0bc9RAq+4m5qU7jk/gvkevlQvjyEZSOi3LdL9rbY0M5FKkEmeJjVBJ/vAbYY5P
	oeZL4QWBAVH2vtd13z36h0Xm543vJdF3KEHDO9m5/JQsgdFfifO7fO3AW4ZuzDeyfHPQVS
	oB4Uatsk+W9x6yK3mVHkzoXZy7Q2DZ5syF02Li9EntetXAjudJrnKAA1U1zVObYRFdnVEr
	vDqUVtGtPMWZBdKtyNCTQzcXMV4WoBqIcToqzXhr9P7BLLZziblMKCQHAVqhSu2ncNcEwc
	p5LafiONXZXDpEZ6xdtPux2YbOGRUrP4jup0R1QwuHj4RxWuc61QjR3IrJiDpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759368127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G5HhcgVdGP3xqgtLy3Tc/szbjeC6+qay+6ptLrUyw/k=;
	b=E1mhSHhy/7wACo/iZUzp2+hwOWkOvXEgLvUtGiJji4IoPtcEpEErLdhf/7zrVGX+5qlREo
	dHeDEwxFKHlra9Dw==
To: Gabriele Monaco <gmonaco@redhat.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, "Paul E.
 McKenney" <paulmck@kernel.org>, Gautham R. Shenoy
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2 2/4] rseq: Run the mm_cid_compaction from
 rseq_handle_notify_resume()
In-Reply-To: <87tt0k3oks.ffs@tglx>
References: <87tt0k3oks.ffs@tglx>
Date: Thu, 02 Oct 2025 03:22:06 +0200
Message-ID: <87o6qq2j41.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 30 2025 at 00:01, Thomas Gleixner wrote:
> On Wed, Sep 24 2025 at 17:22, Gabriele Monaco wrote:
> I'm definitely not claiming that it will hold up in real wider testing,
> but those initial results tell me that this is definitely more
> worthwhile to explore further than trying to apply hacky bandaids to the
> existing implementation.
>
> There are some rough edges in it:
>
>   - the above #A -> #B -> #C allocation order might be not ideal.

And actually it is not for the case where there is a massive back to
back scheduling of threads which share the mm because that makes the
cidmask operations contended. Thanks to Mathieu and Peter for pointing
it out.

Though it actually needs a micro benchmark to see it in perf. Neither
hackbench in threaded mode nor other obnoxious test cases show it.

But after trying a few approaches and utter frustration I decided to
ignore it for a while and then look at it with a fresh mind again. The
solution was there in plain sight as the current implementation does
something similar in the middle of the maze:

  If the scheduled out (previous) and the scheduled in (next) task share
  the mm, then just inheriting the CID from the previous task w/o
  touching the CID mask makes that prominent cpumask fiddling in perf
  top go away completely.

With that the overhead of __schedule() in perf top actually becomes
smaller than with the original base implementation (rseq/perf branch).
That's on bare metal with hyperthreading enabled.

           Intel SKL               AMD Zen3
CPUs:      112                     256      
base:      5.1% __schedule         4.4% __schedule
patch-v1: 10.2% __schedule        11.2% __schedule 
patch-v2:  4.9% __schedule         3.8% __schedule

Cool, right?

But then I really have reached the limits of my performance testing
abilities. Any benchmark I threw at the lot and especially a simple
malloc comparison benchmark:

      https://github.com/f18m/malloc-benchmarks

which runs the benchmark magic against various malloc libraries, gives
me incomprehensible results, which vary from run to run on the same
kernel and end up in both directions of improvement or regression.

The malloc-benchmark seems to amplify the improvements/regressions
around the scalability points which are on the mainline base line
already, so I assume that's some weak spot of those libraries.

Anyway, I've applied the delta patch below to my devel branch:

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid

I'd really appreciate help from people who actually have the relevant
benchmarks and know how to do actually reproducible evaluations and
comparisons.

The interesting evaluation points are:

    1) upstream Linus

and then the commits in

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid

    2) 1822acbae2c9 ("rseq: Switch to TIF_RSEQ if supported")

       which is the big rseq rework

    3) a769dbb7a22a ("sched: Simplify MM CID management")

       the v1 hack

    4) abd407e145f2 ("sched: More CID hackery")

       the below

Thanks,

        tglx
---
Subject: sched: More CID hackery
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 01 Oct 2025 21:38:48 +0200

Add content here...

Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mm_types.h |   41 ++++++++++++++++++++++-------------------
 include/linux/sched.h    |    4 +---
 kernel/fork.c            |    1 +
 kernel/sched/core.c      |   36 +++++++++++++++++++-----------------
 kernel/sched/sched.h     |   33 +++++++++++++++++++++++++--------
 kernel/signal.c          |    4 ++--
 6 files changed, 70 insertions(+), 49 deletions(-)

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -919,7 +919,7 @@ struct vm_area_struct {
 #define vma_policy(vma) NULL
 #endif
 
-struct mm_cid {
+struct mm_cid_pcpu {
 	unsigned int cid;
 };
 
@@ -977,27 +977,23 @@ struct mm_struct {
 
 #ifdef CONFIG_SCHED_MM_CID
 		/**
-		 * @pcpu_cid: Per-cpu current cid.
-		 *
-		 * Keep track of the currently allocated mm_cid for each cpu.
-		 * The per-cpu mm_cid values are serialized by their respective
-		 * runqueue locks.
+		 * @pcpu_cid: Per-cpu CID storage
 		 */
-		struct mm_cid __percpu *pcpu_cid;
+		struct mm_cid_pcpu __percpu *pcpu_cid;
 		/**
 		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
 		 *
-		 * Number of CPUs allowed in the union of all mm's
-		 * threads allowed CPUs.
+		 * Number of CPUs allowed in the union of all mm's threads
+		 * allowed CPUs. It only grows, but can never shrink.
 		 */
 		unsigned int nr_cpus_allowed;
+		unsigned int mm_cid_users;
+		unsigned int mm_max_cid;
+
 		/**
-		 * @cpus_allowed_lock: Lock protecting mm cpus_allowed.
-		 *
-		 * Provide mutual exclusion for mm cpus_allowed and
-		 * mm nr_cpus_allowed updates.
+		 * @mm_cid_lock: Lock protecting the above
 		 */
-		raw_spinlock_t cpus_allowed_lock;
+		raw_spinlock_t mm_cid_lock;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -1332,19 +1328,19 @@ static inline void mm_init_cid(struct mm
 	int i;
 
 	for_each_possible_cpu(i) {
-		struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, i);
+		struct mm_cid_pcpu *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, i);
 
 		pcpu_cid->cid = MM_CID_UNSET;
 	}
 	mm->nr_cpus_allowed = p->nr_cpus_allowed;
-	raw_spin_lock_init(&mm->cpus_allowed_lock);
+	raw_spin_lock_init(&mm->mm_cid_lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	cpumask_clear(mm_cidmask(mm));
 }
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
 {
-	mm->pcpu_cid = alloc_percpu_noprof(struct mm_cid);
+	mm->pcpu_cid = alloc_percpu_noprof(struct mm_cid_pcpu);
 	if (!mm->pcpu_cid)
 		return -ENOMEM;
 	mm_init_cid(mm, p);
@@ -1363,6 +1359,13 @@ static inline unsigned int mm_cid_size(v
 	return 2 * cpumask_size();	/* mm_cpus_allowed(), mm_cidmask(). */
 }
 
+static inline void mm_update_max_cid(struct mm_struct *mm)
+{
+	unsigned int max_cid = min(mm->nr_cpus_allowed, mm->mm_cid_users);
+
+	WRITE_ONCE(mm->mm_max_cid, max_cid);
+}
+
 static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask)
 {
 	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
@@ -1370,10 +1373,10 @@ static inline void mm_set_cpus_allowed(s
 	if (!mm)
 		return;
 	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
-	raw_spin_lock(&mm->cpus_allowed_lock);
+	guard(raw_spinlock)(&mm->mm_cid_lock);
 	cpumask_or(mm_allowed, mm_allowed, cpumask);
 	WRITE_ONCE(mm->nr_cpus_allowed, cpumask_weight(mm_allowed));
-	raw_spin_unlock(&mm->cpus_allowed_lock);
+	mm_update_max_cid(mm);
 }
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1405,9 +1405,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_MM_CID
 	int				mm_cid;		/* Current cid in mm */
 	int				last_mm_cid;	/* Most recent cid in mm */
-	int				migrate_from_cpu;
 	int				mm_cid_active;	/* Whether cid bitmap is active */
-	struct callback_head		cid_work;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
@@ -2299,7 +2297,7 @@ static __always_inline void alloc_tag_re
 void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
 void sched_mm_cid_fork(struct task_struct *t);
-void sched_mm_cid_exit_signals(struct task_struct *t);
+void sched_mm_cid_exit(struct task_struct *t);
 static inline int task_mm_cid(struct task_struct *t)
 {
 	return t->mm_cid;
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2449,6 +2449,7 @@ static bool need_futex_hash_allocate_def
 	exit_task_namespaces(p);
 bad_fork_cleanup_mm:
 	if (p->mm) {
+		sched_mm_cid_exit(p);
 		mm_clear_owner(p->mm, p);
 		mmput(p->mm);
 	}
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10408,44 +10408,46 @@ void call_trace_sched_update_nr_running(
  * When a task exits, the MM CID held by the task is not longer required as
  * the task cannot return to user space.
  */
-void sched_mm_cid_exit_signals(struct task_struct *t)
+void sched_mm_cid_exit(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
 
 	if (!mm || !t->mm_cid_active)
 		return;
 
-	guard(preempt)();
+	guard(raw_spinlock_irq)(&mm->mm_cid_lock);
 	t->mm_cid_active = 0;
 	if (t->mm_cid != MM_CID_UNSET) {
 		cpumask_clear_cpu(t->mm_cid, mm_cidmask(mm));
 		t->mm_cid = MM_CID_UNSET;
 	}
+	mm->mm_cid_users--;
+	mm_update_max_cid(mm);
 }
 
-/* Deactivate MM CID allocation across execve() */
-void sched_mm_cid_before_execve(struct task_struct *t)
-{
-	sched_mm_cid_exit_signals(t);
-}
-
-/* Reactivate MM CID after successful execve() */
-void sched_mm_cid_after_execve(struct task_struct *t)
+void sched_mm_cid_fork(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
 
-	if (!mm)
-		return;
+	WARN_ON_ONCE(!mm || t->mm_cid != MM_CID_UNSET);
 
-	guard(preempt)();
+	guard(raw_spinlock_irq)(&mm->mm_cid_lock);
 	t->mm_cid_active = 1;
-	mm_cid_select(t);
+	mm->mm_cid_users++;
+	mm_update_max_cid(mm);
 }
 
-void sched_mm_cid_fork(struct task_struct *t)
+/* Deactivate MM CID allocation across execve() */
+void sched_mm_cid_before_execve(struct task_struct *t)
 {
-	WARN_ON_ONCE(!t->mm || t->mm_cid != MM_CID_UNSET);
-	t->mm_cid_active = 1;
+	sched_mm_cid_exit(t);
+}
+
+/* Reactivate MM CID after successful execve() */
+void sched_mm_cid_after_execve(struct task_struct *t)
+{
+	if (t->mm)
+		sched_mm_cid_fork(t);
 }
 #endif /* CONFIG_SCHED_MM_CID */
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3518,7 +3518,7 @@ static inline void init_sched_mm_cid(str
 		return;
 
 	/* Preset last_mm_cid */
-	max_cid = min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm_users));
+	max_cid = READ_ONCE(mm->mm_max_cid);
 	t->last_mm_cid = max_cid - 1;
 }
 
@@ -3531,7 +3531,7 @@ static inline bool __mm_cid_get(struct t
 	if (cpumask_test_and_set_cpu(cid, mm_cidmask(mm)))
 		return false;
 	t->mm_cid = t->last_mm_cid = cid;
-	__this_cpu_write(mm->pcpu_cid->cid, cid);
+	__this_cpu_write(t->mm->pcpu_cid->cid, cid);
 	return true;
 }
 
@@ -3540,7 +3540,7 @@ static inline bool mm_cid_get(struct tas
 	struct mm_struct *mm = t->mm;
 	unsigned int max_cid;
 
-	max_cid = min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm_users));
+	max_cid = READ_ONCE(mm->mm_max_cid);
 
 	/* Try to reuse the last CID of this task */
 	if (__mm_cid_get(t, t->last_mm_cid, max_cid))
@@ -3568,14 +3568,31 @@ static inline void mm_cid_select(struct
 	}
 }
 
-static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
+static inline bool mm_cid_inherit(struct task_struct *prev, struct task_struct *next)
 {
-	if (prev->mm_cid_active) {
-		if (prev->mm_cid != MM_CID_UNSET)
-			cpumask_clear_cpu(prev->mm_cid, mm_cidmask(prev->mm));
-		prev->mm_cid = MM_CID_UNSET;
+	unsigned int cid = prev->mm_cid;
+
+	if (!prev->mm_cid_active || cid == MM_CID_UNSET)
+		return false;
+
+	prev->mm_cid = MM_CID_UNSET;
+
+	if (!next->mm_cid_active || prev->mm != next->mm ||
+	    cid >= READ_ONCE(prev->mm->mm_max_cid)) {
+		cpumask_clear_cpu(cid, mm_cidmask(prev->mm));
+		return false;
 	}
 
+	next->mm_cid = next->last_mm_cid = cid;
+	rseq_sched_set_task_mm_cid(next, cid);
+	return true;
+}
+
+static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
+{
+	if (mm_cid_inherit(prev, next))
+		return;
+
 	if (next->mm_cid_active) {
 		mm_cid_select(next);
 		rseq_sched_set_task_mm_cid(next, next->mm_cid);
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3125,7 +3125,7 @@ void exit_signals(struct task_struct *ts
 	cgroup_threadgroup_change_begin(tsk);
 
 	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
-		sched_mm_cid_exit_signals(tsk);
+		sched_mm_cid_exit(tsk);
 		tsk->flags |= PF_EXITING;
 		cgroup_threadgroup_change_end(tsk);
 		return;
@@ -3136,7 +3136,7 @@ void exit_signals(struct task_struct *ts
 	 * From now this task is not visible for group-wide signals,
 	 * see wants_signal(), do_signal_stop().
 	 */
-	sched_mm_cid_exit_signals(tsk);
+	sched_mm_cid_exit(tsk);
 	tsk->flags |= PF_EXITING;
 
 	cgroup_threadgroup_change_end(tsk);








   



Return-Path: <linux-kernel+bounces-865016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A83BFC16B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7CF3A83E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726BB351FB7;
	Wed, 22 Oct 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="blBUkjoa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q4qLi6t8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92034FF4E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137743; cv=none; b=YjnGDqOmYuGXpt8wBG047P/Kdum3v+mZSIrFkIUT+AH/AvC0MA/nAJiPM3J7GC3m7OKaANM31ihJKq8IPQaN8XEn9xRu+Z4iEj27JHm4sGmuKFUIStyM8i+FyimobSZPtSEI018O8hefUWjBp4v4lWCKKpGTjYM+8fQMwgvo+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137743; c=relaxed/simple;
	bh=xCUKtbYHYrEUhe/5kTe16Y0mAzYli+u0iaE3XImUUzM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HYDHljjuURNYlBM7ntxhzoz3c97BjDMPnggBTiHmE6UuJghrNaekdgNBaDtjR2DAyxv6ueqOB4bkHc5nf4g4734KB1A9demnAZ4+H1n8V6wZ3ybjA+6TkIA5PVygT9B4ElAMPeR2/YP4BeV2l+WVbjTek2pfMW/svP4K4iMZ6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=blBUkjoa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q4qLi6t8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110556.399477196@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2ecRtsPcmkrRlC4SHI9jS/j/6nJKkkbLGPpbUOMleQY=;
	b=blBUkjoaPc6R3f7ohVY4wKLhKpe6IYgu6cgn7+ovS1Mj386f8VROHXzdmjVMsHAdgot8oE
	scxOCI581Te7zRc2EemOKkhVDy0oiXthz/sqtbRqBfsTifx3JawlOBR4tQa05eMeMfG0t7
	btopyR8IBNXYH2IQ2WugkkP4U9rzC0PJCSnw0sc9zgFYzk1zgRdzgUMtmJ8P2Gieb6GimC
	MMgCnqy3IDfWvsipHbKoLZK4aEZOatzuy4sk5JHjcJHmaT8NRTOBZoflNz72qu2gPHlJKj
	u1F0NF0V9+bbL9eHwbglBl6pybU2lQckzbNGl7rN7cBG5sXLvkxtdIqZGqykUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2ecRtsPcmkrRlC4SHI9jS/j/6nJKkkbLGPpbUOMleQY=;
	b=Q4qLi6t8oEF7QkL0l6r6Kyc7dWMSa3tbATI2Wq543Er1u9OqYV86JsV1qKyu4g89zDwXfr
	0Sf81ATX3Myn8BDg==
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
Subject: [patch V2 16/20] sched/mmcid: Provide new scheduler CID mechanism
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:39 +0200 (CEST)

The MM CID management has two fundamental requirements:

  1) It has to guarantee that at no given point in time the same CID is
     used by concurrent tasks in userspace.

  2) The CID space must not exceed the number of possible CPUs in a
     system. While most allocators (glibc, tcmalloc, jemalloc) do not
     care about that, there seems to be at least some LTTng library
     depending on it.

The CID space compaction itself is not a functional correctness
requirement, it is only a useful optimization mechanism to reduce the
memory foot print in unused user space pools.

The optimal CID space is:

    min(nr_tasks, nr_cpus_allowed);

Where @nr_tasks is the number of actual user space threads associated to
the mm and @nr_cpus_allowed is the superset of all task affinities. It is
growth only as it would be insane to take a racy snapshot of all task
affinities when the affinity of one task changes just do redo it 2
milliseconds later when the next task changes it's affinity.

That means that as long as the number of tasks is lower or equal than the
number of CPUs allowed, each task owns a CID. If the number of tasks
exceeds the number of CPUs allowed it switches to per CPU mode, where the
CPUs own the CIDs and the tasks borrow them as long as they are scheduled
in.

For transition periods CIDs can go beyond the optimal space as long as they
don't go beyond the number of possible CPUs.

The current upstream implementation tries to keep the CID with the task
even in overcommit situations, which complicates task migration. It also
has to do the CID space consolidation work from a task work in the exit to
user space path. As that work is assigned to a random task related to a MM
this can inflict unwanted exit latencies.

Implement the context switch parts of a strict ownership mechanism to
address this.

This removes most of the work from the task which schedules out. Only
during transitioning from per CPU to per task ownership it is required to
drop the CID when leaving the CPU to prevent CID space exhaustion. Other
than that scheduling out is just a single check and branch.

The task which schedules in has to check whether:

    1) The ownership mode changed
    2) The CID is within the optimal CID space

In stable situations this results in zero work. The only short disruption
is when ownership mode changes or when the associated CID is not in the
optimal CID space. The latter only happens when tasks exit and therefore
the optimal CID space shrinks.

That mechanism is strictly optimized for the common case where no change
happens. The only case where it actually causes a temporary one time spike
is on mode changes when and only when a lot of tasks related to a MM
schedule exactly at the same time and have eventually to compete on
allocating a CID from the bitmap.

In the sysbench test case which triggered the spinlock contention in the
initial CID code, __schedule() drops significantly in perf top on a 128
Core (256 threads) machine when running sysbench with 255 threads, which
fits into the task mode limit of 256 together with the parent thread:

  Upstream  rseq/perf branch  +CID rework  
  0.42%     0.37%             0.32%          [k] __schedule

Increasing the number of threads to 256, which puts the test process into
per CPU mode looks about the same.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Adjust to the mode transition changes
---
 include/linux/rseq.h       |    8 +-
 include/linux/rseq_types.h |    5 +
 kernel/sched/core.c        |    1 
 kernel/sched/sched.h       |  149 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 158 insertions(+), 5 deletions(-)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -73,13 +73,13 @@ static __always_inline void rseq_sched_s
 }
 
 /*
- * Invoked from __set_task_cpu() when a task migrates to enforce an IDs
- * update.
+ * Invoked from __set_task_cpu() when a task migrates or from
+ * mm_cid_schedin() when the CID changes to enforce an IDs update.
  *
  * This does not raise TIF_NOTIFY_RESUME as that happens in
  * rseq_sched_switch_event().
  */
-static __always_inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu)
+static __always_inline void rseq_sched_set_ids_changed(struct task_struct *t)
 {
 	t->rseq.event.ids_changed = true;
 }
@@ -169,7 +169,7 @@ static inline void rseq_fork(struct task
 static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
-static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
+static inline void rseq_sched_set_ids_changed(struct task_struct *t) { }
 static inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigned int cid) { }
 static inline void rseq_force_update(void) { }
 static inline void rseq_virt_userspace_exit(void) { }
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -119,6 +119,8 @@ struct mm_cid_pcpu {
 /**
  * struct mm_mm_cid - Storage for per MM CID data
  * @pcpu:		Per CPU storage for CIDs associated to a CPU
+ * @percpu:		Set, when CIDs are in per CPU mode
+ * @transit:		Set to MM_CID_TRANSIT during a mode change transition phase
  * @max_cids:		The exclusive maximum CID value for allocation and convergance
  * @nr_cpus_allowed:	The number of CPUs in the per MM allowed CPUs map. The map
  *			is growth only.
@@ -130,7 +132,10 @@ struct mm_cid_pcpu {
  * @mutex:		Mutex to serialize forks and exits related to this mm
  */
 struct mm_mm_cid {
+	/* Hotpath read mostly members */
 	struct mm_cid_pcpu	__percpu *pcpu;
+	unsigned int		percpu;
+	unsigned int		transit;
 	unsigned int		max_cids;
 	unsigned int		nr_cpus_allowed;
 	unsigned int		users;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10493,6 +10493,7 @@ void mm_init_cid(struct mm_struct *mm, s
 		per_cpu_ptr(pcpu, cpu)->cid = MM_CID_UNSET;
 
 	mm->mm_cid.max_cids = 0;
+	mm->mm_cid.percpu = 0;
 	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
 	mm->mm_cid.users = 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2208,7 +2208,7 @@ static inline void __set_task_cpu(struct
 	smp_wmb();
 	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 	p->wake_cpu = cpu;
-	rseq_sched_set_task_cpu(p, cpu);
+	rseq_sched_set_ids_changed(p);
 #endif /* CONFIG_SMP */
 }
 
@@ -3597,6 +3597,152 @@ static __always_inline void mm_drop_cid_
 	mm_drop_cid(mm, pcp->cid);
 }
 
+static inline unsigned int __mm_get_cid(struct mm_struct *mm, unsigned int max_cids)
+{
+	unsigned int cid = find_first_zero_bit(mm_cidmask(mm), max_cids);
+
+	if (cid >= max_cids)
+		return MM_CID_UNSET;
+	if (test_and_set_bit(cid, mm_cidmask(mm)))
+		return MM_CID_UNSET;
+	return cid;
+}
+
+static inline unsigned int mm_get_cid(struct mm_struct *mm)
+{
+	unsigned int cid = __mm_get_cid(mm, READ_ONCE(mm->mm_cid.max_cids));
+
+	for (; cid == MM_CID_UNSET; cpu_relax())
+		cid = __mm_get_cid(mm, num_possible_cpus());
+
+	return cid;
+}
+
+static inline unsigned int mm_cid_converge(struct mm_struct *mm, unsigned int orig_cid,
+					   unsigned int max_cids)
+{
+	unsigned int new_cid, cid = cpu_cid_to_cid(orig_cid);
+
+	/* Is it in the optimal CID space? */
+	if (likely(cid < max_cids))
+		return orig_cid;
+
+	/* Try to find one in the optimal space. Otherwise keep the provided. */
+	new_cid = __mm_get_cid(mm, max_cids);
+	if (new_cid != MM_CID_UNSET) {
+		mm_drop_cid(mm, cid);
+		/* Preserve the ONCPU mode of the original CID */
+		return new_cid | (orig_cid & MM_CID_ONCPU);
+	}
+	return orig_cid;
+}
+
+static __always_inline void mm_cid_update_task_cid(struct task_struct *t, unsigned int cid)
+{
+	if (t->mm_cid.cid != cid) {
+		t->mm_cid.cid = cid;
+		rseq_sched_set_ids_changed(t);
+	}
+}
+
+static __always_inline void mm_cid_update_pcpu_cid(struct mm_struct *mm, unsigned int cid)
+{
+	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
+}
+
+static __always_inline void mm_cid_from_cpu(struct task_struct *t, unsigned int cpu_cid)
+{
+	unsigned int max_cids, tcid = t->mm_cid.cid;
+	struct mm_struct *mm = t->mm;
+
+	max_cids = READ_ONCE(mm->mm_cid.max_cids);
+	/* Optimize for the common case where both have the ONCPU bit set */
+	if (likely(cid_on_cpu(cpu_cid & tcid))) {
+		if (likely(cpu_cid_to_cid(cpu_cid) < max_cids)) {
+			mm_cid_update_task_cid(t, cpu_cid);
+			return;
+		}
+		/* Try to converge into the optimal CID space */
+		cpu_cid = mm_cid_converge(mm, cpu_cid, max_cids);
+	} else {
+		/* Hand over or drop the task owned CID */
+		if (cid_on_task(tcid)) {
+			if (cid_on_cpu(cpu_cid))
+				mm_unset_cid_on_task(t);
+			else
+				cpu_cid = cid_to_cpu_cid(tcid);
+		}
+		/* Still nothing, allocate a new one */
+		if (!cid_on_cpu(cpu_cid))
+			cpu_cid = cid_to_cpu_cid(mm_get_cid(mm));
+	}
+	mm_cid_update_pcpu_cid(mm, cpu_cid);
+	mm_cid_update_task_cid(t, cpu_cid);
+}
+
+static __always_inline void mm_cid_from_task(struct task_struct *t, unsigned int cpu_cid)
+{
+	unsigned int max_cids, tcid = t->mm_cid.cid;
+	struct mm_struct *mm = t->mm;
+
+	max_cids = READ_ONCE(mm->mm_cid.max_cids);
+	/* Optimize for the common case, where both have the ONCPU bit clear */
+	if (likely(cid_on_task(tcid | cpu_cid))) {
+		if (likely(tcid < max_cids)) {
+			mm_cid_update_pcpu_cid(mm, tcid);
+			return;
+		}
+		/* Try to converge into the optimal CID space */
+		tcid = mm_cid_converge(mm, tcid, max_cids);
+	} else {
+		/* Hand over or drop the CPU owned CID */
+		if (cid_on_cpu(cpu_cid)) {
+			if (cid_on_task(tcid))
+				mm_drop_cid_on_cpu(mm, this_cpu_ptr(mm->mm_cid.pcpu));
+			else
+				tcid = cpu_cid_to_cid(cpu_cid);
+		}
+		/* Still nothing, allocate a new one */
+		if (!cid_on_task(tcid))
+			tcid = mm_get_cid(mm);
+		/* Set the transition mode flag if required */
+		tcid |= READ_ONCE(mm->mm_cid.transit);
+	}
+	mm_cid_update_pcpu_cid(mm, tcid);
+	mm_cid_update_task_cid(t, tcid);
+}
+
+static __always_inline void mm_cid_schedin(struct task_struct *next)
+{
+	struct mm_struct *mm = next->mm;
+	unsigned int cpu_cid;
+
+	if (!next->mm_cid.active)
+		return;
+
+	cpu_cid = __this_cpu_read(mm->mm_cid.pcpu->cid);
+	if (likely(!READ_ONCE(mm->mm_cid.percpu)))
+		mm_cid_from_task(next, cpu_cid);
+	else
+		mm_cid_from_cpu(next, cpu_cid);
+}
+
+static __always_inline void mm_cid_schedout(struct task_struct *prev)
+{
+	/* During mode transitions CIDs are temporary and need to be dropped */
+	if (likely(!cid_in_transit(prev->mm_cid.cid)))
+		return;
+
+	mm_drop_cid(prev->mm, cid_from_transit_cid(prev->mm_cid.cid));
+	prev->mm_cid.cid = MM_CID_UNSET;
+}
+
+static inline void mm_cid_switch_to(struct task_struct *prev, struct task_struct *next)
+{
+	mm_cid_schedout(prev);
+	mm_cid_schedin(next);
+}
+
 /* Active implementation */
 static inline void init_sched_mm_cid(struct task_struct *t)
 {
@@ -3674,6 +3820,7 @@ static inline void switch_mm_cid(struct
 #else /* !CONFIG_SCHED_MM_CID: */
 static inline void mm_cid_select(struct task_struct *t) { }
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
+static inline void mm_cid_switch_to(struct task_struct *prev, struct task_struct *next) { }
 #endif /* !CONFIG_SCHED_MM_CID */
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);



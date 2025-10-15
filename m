Return-Path: <linux-kernel+bounces-854982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1ADBDFDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F3894F4713
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32423431ED;
	Wed, 15 Oct 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wMZXJv/V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s41i1sDl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CEC3431E9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549399; cv=none; b=d0hUebjwCAmMh64d3+Vq1kIWLOZSvC1kJkFKBzXsV46+Hge9ly9F9ue2CHZb5S4sfKWSzT+uQO0YP+GHw8K4fkEvKJjE6/Fvig2ilLvuoVqGR7m/Vo0I+8vbSxKNyexscpMMIKWl8kEvHWGx3NW9bkmNXjPcspiHZNUxpj5Raeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549399; c=relaxed/simple;
	bh=Xxod1oyqga6XkJag5SeJ8gPZM5QaRoiDKgy19Ybg7qM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LQFnF15bUc9q/WkGoWJWIZ7AkpHIoua9f8CJHrArH9VSJmLLDYK2fowvVSs9kVp1+S94POnW1yrytWDKAsuu3f4NEnTaibywhpoc9tmKrpsiEF3NrqaMkyqxcppzbkumYZfMjgFA8gQ26oW/GqFFX9EqfQUWcPf5nroVtgLelZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wMZXJv/V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s41i1sDl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172835.252130919@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Qlc2E7wHHwQG2HHxnIWIivpMdawkwpkQBf7obNqOoSw=;
	b=wMZXJv/V0jStj9CaD+Tu32neP/BLCkfi7sIa3rtRHL+dZsHYBkY915GZbtiD64/jUqbPJl
	Fw5nCCkrrYbkKr7FP9ZEEYmJW+svJdIGXPpzVOG8pCnUvqycD2cHMri4Cx2GYUAwpknK3I
	gsXF23ZJjbg9V2Ziy+8t35EW2Md65qE/oolA1pv+cN7gtHkUWnEByoNOnDbm1tTiejiuOK
	ry2MX7viF8ja9eJ7JAd6tTIb130gv1LI+J8zFthnbJhWYPKypzWiuo6OFKMJunRHB92s7t
	YDWNZ8SR4cXp3HM98hHPmeNPIkxfbB58ATBN+pjDwmXFT4rIX6I3lSpy/+VktA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Qlc2E7wHHwQG2HHxnIWIivpMdawkwpkQBf7obNqOoSw=;
	b=s41i1sDlKBknisEkDp/RrJRKhAbryzfwjrcYXTaOOANCa6ck74p8OvRMGpuDlcgpgvbd2m
	YlPO4vkthVIV+EAg==
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
Subject: [patch 15/19] sched/mmcid: Provide new scheduler CID mechanism
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:52 +0200 (CEST)

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

This removes all work from a task which schedules out. That's a benefit as
tasks which schedule out have the related shared mm:mm_cid data and the per
CPU storage cache cold when the task has a big enough cache foot print
while doing work in user space as perf top clearly shows.

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
 include/linux/rseq.h       |    8 +-
 include/linux/rseq_types.h |    3 +
 kernel/sched/core.c        |    1 
 kernel/sched/sched.h       |  130 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 137 insertions(+), 5 deletions(-)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -71,13 +71,13 @@ static __always_inline void rseq_sched_s
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
@@ -176,7 +176,7 @@ static inline void rseq_fork(struct task
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
@@ -118,6 +118,7 @@ struct mm_cid_pcpu {
 /**
  * struct mm_mm_cid - Storage for per MM CID data
  * @pcpu:		Per CPU storage for CIDs associated to a CPU
+ * @percpu:		Set, when CIDs are in per CPU mode
  * @max_cids:		The exclusive maximum CID value for allocation and convergance
  * @nr_cpus_allowed:	The number of CPUs in the per MM allowed CPUs map. The map
  *			is growth only.
@@ -129,7 +130,9 @@ struct mm_cid_pcpu {
  * @mutex:		Mutex to serialize forks and exits related to this mm
  */
 struct mm_mm_cid {
+	/* Hotpath read mostly members */
 	struct mm_cid_pcpu	__percpu *pcpu;
+	unsigned int		percpu;
 	unsigned int		max_cids;
 	unsigned int		nr_cpus_allowed;
 	unsigned int		users;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10532,6 +10532,7 @@ void mm_init_cid(struct mm_struct *mm, s
 		per_cpu_ptr(pcpu, cpu)->cid = MM_CID_UNSET;
 
 	mm->mm_cid.max_cids = 0;
+	mm->mm_cid.percpu = 0;
 	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
 	mm->mm_cid.users = 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2206,7 +2206,7 @@ static inline void __set_task_cpu(struct
 	smp_wmb();
 	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 	p->wake_cpu = cpu;
-	rseq_sched_set_task_cpu(p, cpu);
+	rseq_sched_set_ids_changed(p);
 #endif /* CONFIG_SMP */
 }
 
@@ -3577,6 +3577,134 @@ static __always_inline void mm_drop_cid_
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
+		cid = __mm_get_cid(mm, nr_cpu_ids);
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
 /* Active implementation */
 static inline void init_sched_mm_cid(struct task_struct *t)
 {



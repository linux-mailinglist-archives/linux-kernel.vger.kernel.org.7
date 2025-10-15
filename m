Return-Path: <linux-kernel+bounces-854978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ECCBDFDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48ED3354AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1A342C96;
	Wed, 15 Oct 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="432gjQMG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+48rji1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97F342C81
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549391; cv=none; b=q9iB+VHNA7FUV/ipOYwKXb7VpfaUcrF7iQ8RMNFWANc825xIJHnkfMnNL1KdEeU8zmOEDgG562+IjoQx3iONN0NYbmMCbaAMob/3+g++hOv8yYdc8cpDf6jK5ZRhu6jYBiSKLvCeYDBCUjud+Z8T98gvP6Gstx+3JPZiDvDffEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549391; c=relaxed/simple;
	bh=JTJkJjiUOE8/izhGx/Wm+O58YQgBD7ZsC87IE88+cMg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SVg9C9/oPMrPP4q66+A86x7S5Oa527yb6wrASgskrC7JHHYdw8j9DIHnpL+43jZWoq9AMLl8IhGAf8RITmtO0DyZIRE58fykAh4vHy4Tahwm3WpWY80e/aZRsJlI7mlBlzx8LrkLBa4ESlQKUI6fyD3KACG9K39VfqLIZrMlDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=432gjQMG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+48rji1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172835.068114686@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ov/K9g3aVE2nIBgc7w2Mu8zuwzO5UAbpBaMU43faj8c=;
	b=432gjQMG6B14rpa7HPhBkhHnflgxs2aVrcXFyj7cwhYXpmtpuef8IcZjzF61+Uds9COLVt
	zETUIuzHGIYSuBNxNSgde695L4C4xtVn+Bke4kkeUy+7BwoW4+Pk6H3MVa/IHYG6KFqWsF
	hSEGmjyhBeakj40KUIuhw1OsKI3UO3zcH+Nhb3FgzuuAvqZcWwnUGkKC2XHDQDLDRpyG3V
	bwQFuGDbZMTiBWR4JXPmEwwOE7uKHUeDzocaeRDVYYBDcYazbMXV3/5/Buee/R7V1e/1dx
	gaMBF7sGC4TxHVwsXJPG9SlWHpyM2aEemEbN4vtTNUwJjUxsKiEe2W2zwLjYLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ov/K9g3aVE2nIBgc7w2Mu8zuwzO5UAbpBaMU43faj8c=;
	b=J+48rji1XS5OnpW4W4EPH+CIgdIqxW7JTlDzUvueuZgRbCpU0dzb9jYtAm3gOAH8WsllIm
	oOfF93CZm50Yx8BA==
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
Subject: [patch 12/19] sched/mmcid: Provide precomputed maximal value
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:46 +0200 (CEST)

Reading mm::mm_users and mm:::mm_cid::nr_cpus_allowed everytime to compute
the maximal CID value is just wasteful as that value is only changing on
fork(), exit() and eventually when the affinity changes.

So it can be easily precomputed at those points and provided in mm::mm_cid
for consumption in the hot path.

But there is an issue with using mm::mm_users for accounting because that
does not necessarily reflect the number of user space tasks as other kernel
code can take temporary references on the MM which skew the picture.

Solve that by adding a users counter to struct mm_mm_cid, which is modified
by fork() and exit() and used for precomputing under mm_mm_cid::lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq_types.h |    6 ++++
 kernel/fork.c              |    1 
 kernel/sched/core.c        |   66 ++++++++++++++++++++++++++++++++-------------
 kernel/sched/sched.h       |    3 --
 4 files changed, 56 insertions(+), 20 deletions(-)

--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -117,14 +117,20 @@ struct mm_cid_pcpu {
 /**
  * struct mm_mm_cid - Storage for per MM CID data
  * @pcpu:		Per CPU storage for CIDs associated to a CPU
+ * @max_cids:		The exclusive maximum CID value for allocation and convergance
  * @nr_cpus_allowed:	The number of CPUs in the per MM allowed CPUs map. The map
  *			is growth only.
+ * @users:		The number of tasks sharing this MM. Seperate from mm::mm_users
+ *			as that is modified by mmget()/mm_put() by other entities which
+ *			do not actually share the MM.
  * @lock:		Spinlock to protect all fields except @pcpu. It also protects
  *			the MM cid cpumask and the MM cidmask bitmap.
  */
 struct mm_mm_cid {
 	struct mm_cid_pcpu	__percpu *pcpu;
+	unsigned int		max_cids;
 	unsigned int		nr_cpus_allowed;
+	unsigned int		users;
 	raw_spinlock_t		lock;
 }____cacheline_aligned_in_smp;
 #else /* CONFIG_SCHED_MM_CID */
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
@@ -4517,7 +4517,6 @@ static void __sched_fork(unsigned long c
 	init_numa_balancing(clone_flags, p);
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
-	init_sched_mm_cid(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -10403,15 +10402,32 @@ void call_trace_sched_update_nr_running(
 
 #ifdef CONFIG_SCHED_MM_CID
 /*
- * When a task exits, the MM CID held by the task is not longer required as
- * the task cannot return to user space.
+ * Update the CID range properties when the constraints change. Invoked via
+ * fork(), exit() and affinity changes
  */
+static void mm_update_max_cids(struct mm_struct *mm)
+{
+	struct mm_mm_cid *mc = &mm->mm_cid;
+	unsigned int max_cids;
+
+	lockdep_assert_held(&mm->mm_cid.lock);
+
+	/* Calculate the new maximum constraint */
+	max_cids = min(mc->nr_cpus_allowed, mc->users);
+	WRITE_ONCE(mc->max_cids, max_cids);
+}
+
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
 {
 	struct cpumask *mm_allowed;
 	unsigned int weight;
 
-	if (!mm || READ_ONCE(mm->mm_cid.nr_cpus_allowed) == nr_cpu_ids)
+	/*
+	 * Nothing to do when the mask is already maxed out or the user
+	 * count dropped to zero.
+	 */
+	if (!mm || READ_ONCE(mm->mm_cid.nr_cpus_allowed) == nr_cpu_ids ||
+	    !READ_ONCE(mm->mm_cid.users))
 		return;
 
 	/*
@@ -10420,13 +10436,34 @@ static inline void mm_update_cpus_allowe
 	 */
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	/* Check again under the lock */
-	if (mm->mm_cid.nr_cpus_allowed == nr_cpu_ids)
+	if (mm->mm_cid.nr_cpus_allowed == nr_cpu_ids || !mm->mm_cid.users)
 		return;
 	mm_allowed = mm_cpus_allowed(mm);
 	weight = cpumask_or_weight(mm_allowed, mm_allowed, affmsk);
+	if (weight == mm->mm_cid.nr_cpus_allowed)
+		return;
 	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
+	mm_update_max_cids(mm);
 }
 
+void sched_mm_cid_fork(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+
+	WARN_ON_ONCE(!mm || t->mm_cid.cid != MM_CID_UNSET);
+
+	guard(raw_spinlock)(&mm->mm_cid.lock);
+	t->mm_cid.active = 1;
+	mm->mm_cid.users++;
+	/* Preset last_cid for mm_cid_select() */
+	t->mm_cid.last_cid = READ_ONCE(mm->mm_cid.max_cids) - 1;
+	mm_update_max_cids(mm);
+}
+
+/*
+ * When a task exits, the MM CID held by the task is not longer required as
+ * the task cannot return to user space.
+ */
 void sched_mm_cid_exit(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
@@ -10434,12 +10471,14 @@ void sched_mm_cid_exit(struct task_struc
 	if (!mm || !t->mm_cid.active)
 		return;
 
-	guard(preempt)();
+	guard(raw_spinlock)(&mm->mm_cid.lock);
 	t->mm_cid.active = 0;
+	mm->mm_cid.users--;
 	if (t->mm_cid.cid != MM_CID_UNSET) {
 		clear_bit(t->mm_cid.cid, mm_cidmask(mm));
 		t->mm_cid.cid = MM_CID_UNSET;
 	}
+	mm_update_max_cids(mm);
 }
 
 /* Deactivate MM CID allocation across execve() */
@@ -10451,22 +10490,11 @@ void sched_mm_cid_before_execve(struct t
 /* Reactivate MM CID after successful execve() */
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
-	struct mm_struct *mm = t->mm;
-
-	if (!mm)
-		return;
-
+	sched_mm_cid_fork(t);
 	guard(preempt)();
-	t->mm_cid.active = 1;
 	mm_cid_select(t);
 }
 
-void sched_mm_cid_fork(struct task_struct *t)
-{
-	WARN_ON_ONCE(!t->mm || t->mm_cid.cid != MM_CID_UNSET);
-	t->mm_cid.active = 1;
-}
-
 void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
 {
 	struct mm_cid_pcpu __percpu *pcpu = mm->mm_cid.pcpu;
@@ -10475,7 +10503,9 @@ void mm_init_cid(struct mm_struct *mm, s
 	for_each_possible_cpu(cpu)
 		per_cpu_ptr(pcpu, cpu)->cid = MM_CID_UNSET;
 
+	mm->mm_cid.max_cids = 0;
 	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
+	mm->mm_cid.users = 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	bitmap_zero(mm_cidmask(mm), nr_cpu_ids);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3565,7 +3565,7 @@ static inline bool mm_cid_get(struct tas
 	struct mm_struct *mm = t->mm;
 	unsigned int max_cids;
 
-	max_cids = min_t(int, READ_ONCE(mm->mm_cid.nr_cpus_allowed), atomic_read(&mm->mm_users));
+	max_cids = READ_ONCE(mm->mm_cid.max_cids);
 
 	/* Try to reuse the last CID of this task */
 	if (__mm_cid_get(t, t->mm_cid.last_cid, max_cids))
@@ -3608,7 +3608,6 @@ static inline void switch_mm_cid(struct
 }
 
 #else /* !CONFIG_SCHED_MM_CID: */
-static inline void init_sched_mm_cid(struct task_struct *t) { }
 static inline void mm_cid_select(struct task_struct *t) { }
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
 #endif /* !CONFIG_SCHED_MM_CID */



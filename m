Return-Path: <linux-kernel+bounces-865001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD0BFC0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61F7620C10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BB0347BD5;
	Wed, 22 Oct 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EYphd/s0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yV8Isbbv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCE7346E4C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137725; cv=none; b=nYn0JMDF1bi3znCBV5rEzCcQCAz2AN9fG79PBj+sMamgcedHvaQRb1MacLT6H1KihfMLWCL4umvdnkOJ+hMGS5iKHzmm7ECrPjF6E5K64jZhySx6YP9mO+8iKcjIJpGNqKzci38FBG1PlxCusky9/slsGGZ2yIRkxcO0JDOu0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137725; c=relaxed/simple;
	bh=l84oqeVvwpIwwwLn7xMWKKgxZ399CfJFwUNWuy3cHgw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=giVdHokDAgoxOKl1fx2PSqHxA2hsp6oZUT+R6bBECa+rDahw+V73xP7EIoMu3yRmZqamzWbrkbyZTugZj3Z+lCRSSq+cMsaY3BlQyQzRjYFOC9If0Dza89297HGWOMkEtpN39Ki8WW2+/akchBcveCmsOInH3tW4MAAgDU1iJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EYphd/s0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yV8Isbbv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110555.522151028@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=T0blajzcjCuEIFJRMYeXiHwYt/OuvzjxCG2KF3qhRk0=;
	b=EYphd/s0nFfjq/q7idtaBawkAXDZLPxWdLGArn1CkxuB2TdF+RpUGAChKX0MhxaAvRqsPh
	4W+47hfut+7CDDOFZKfe2igbO3uUkSDJjPTyE9WzwWfRipG/osycwvVz8BxlDH57dQ1yGN
	E2vl34J3onF4LMB9j27qDtZQ5ZhNIzao9Ce8ZYfWOiym1X64oPa/Ogg2u2KochZBh8RiEi
	k+VfOxrTkB3EZ/PYi0oisoIEjyfRe/ivowtg/7CtiYErDcz26NKFgocueo1qcZiKxP4siN
	Rsk0oGoZg/YuifS7DvZ8nRPIWmfk6rgEdYX5fmtRRV6FZSWIo3JJev8dSOs9sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=T0blajzcjCuEIFJRMYeXiHwYt/OuvzjxCG2KF3qhRk0=;
	b=yV8IsbbvAqPfBbrKT+W9ilIuBeEEBnL1yNjkBYhIt86oDR0g6SGErGzNEVh2KQTH+cyp7o
	h8nm1+TbdykiKiBA==
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
Subject: [patch V2 02/20] sched/mmcid: Use proper data structures
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:22 +0200 (CEST)

Having a lot of CID functionality specific members in struct task_struct
and struct mm_struct is not really making the code easier to read.

Encapsulate the CID specific parts in data structures and keep them
seperate from the stuff they are embedded in.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mm_types.h   |   56 +++++++++++----------------------------------
 include/linux/rseq_types.h |   42 +++++++++++++++++++++++++++++++++
 include/linux/sched.h      |   11 +-------
 init/init_task.c           |    3 ++
 kernel/fork.c              |    6 ++--
 kernel/sched/core.c        |   16 ++++++------
 kernel/sched/sched.h       |   26 ++++++++++----------
 7 files changed, 85 insertions(+), 75 deletions(-)

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -20,6 +20,7 @@
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
 #include <linux/types.h>
+#include <linux/rseq_types.h>
 #include <linux/bitmap.h>
 
 #include <asm/mmu.h>
@@ -922,10 +923,6 @@ struct vm_area_struct {
 #define vma_policy(vma) NULL
 #endif
 
-struct mm_cid {
-	unsigned int cid;
-};
-
 /*
  * Opaque type representing current mm_struct flag state. Must be accessed via
  * mm_flags_xxx() helper functions.
@@ -987,30 +984,9 @@ struct mm_struct {
 		 */
 		atomic_t mm_users;
 
-#ifdef CONFIG_SCHED_MM_CID
-		/**
-		 * @pcpu_cid: Per-cpu current cid.
-		 *
-		 * Keep track of the currently allocated mm_cid for each cpu.
-		 * The per-cpu mm_cid values are serialized by their respective
-		 * runqueue locks.
-		 */
-		struct mm_cid __percpu *pcpu_cid;
-		/**
-		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
-		 *
-		 * Number of CPUs allowed in the union of all mm's
-		 * threads allowed CPUs.
-		 */
-		unsigned int nr_cpus_allowed;
-		/**
-		 * @cpus_allowed_lock: Lock protecting mm cpus_allowed.
-		 *
-		 * Provide mutual exclusion for mm cpus_allowed and
-		 * mm nr_cpus_allowed updates.
-		 */
-		raw_spinlock_t cpus_allowed_lock;
-#endif
+		/* MM CID related storage */
+		struct mm_mm_cid mm_cid;
+
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
 #endif
@@ -1352,9 +1328,6 @@ static inline void vma_iter_init(struct
 }
 
 #ifdef CONFIG_SCHED_MM_CID
-
-#define	MM_CID_UNSET	(~0U)
-
 /*
  * mm_cpus_allowed: Union of all mm's threads allowed CPUs.
  */
@@ -1383,20 +1356,20 @@ static inline void mm_init_cid(struct mm
 	int i;
 
 	for_each_possible_cpu(i) {
-		struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, i);
+		struct mm_cid_pcpu *pcpu = per_cpu_ptr(mm->mm_cid.pcpu, i);
 
-		pcpu_cid->cid = MM_CID_UNSET;
+		pcpu->cid = MM_CID_UNSET;
 	}
-	mm->nr_cpus_allowed = p->nr_cpus_allowed;
-	raw_spin_lock_init(&mm->cpus_allowed_lock);
+	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
+	raw_spin_lock_init(&mm->mm_cid.lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	cpumask_clear(mm_cidmask(mm));
 }
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
 {
-	mm->pcpu_cid = alloc_percpu_noprof(struct mm_cid);
-	if (!mm->pcpu_cid)
+	mm->mm_cid.pcpu = alloc_percpu_noprof(struct mm_cid_pcpu);
+	if (!mm->mm_cid.pcpu)
 		return -ENOMEM;
 	mm_init_cid(mm, p);
 	return 0;
@@ -1405,8 +1378,8 @@ static inline int mm_alloc_cid_noprof(st
 
 static inline void mm_destroy_cid(struct mm_struct *mm)
 {
-	free_percpu(mm->pcpu_cid);
-	mm->pcpu_cid = NULL;
+	free_percpu(mm->mm_cid.pcpu);
+	mm->mm_cid.pcpu = NULL;
 }
 
 static inline unsigned int mm_cid_size(void)
@@ -1421,10 +1394,9 @@ static inline void mm_set_cpus_allowed(s
 	if (!mm)
 		return;
 	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
-	raw_spin_lock(&mm->cpus_allowed_lock);
+	guard(raw_spinlock)(&mm->mm_cid.lock);
 	cpumask_or(mm_allowed, mm_allowed, cpumask);
-	WRITE_ONCE(mm->nr_cpus_allowed, cpumask_weight(mm_allowed));
-	raw_spin_unlock(&mm->cpus_allowed_lock);
+	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
 }
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -90,4 +90,46 @@ struct rseq_data {
 struct rseq_data { };
 #endif /* !CONFIG_RSEQ */
 
+#ifdef CONFIG_SCHED_MM_CID
+
+#define MM_CID_UNSET	(~0U)
+
+/**
+ * struct sched_mm_cid - Storage for per task MM CID data
+ * @active:	MM CID is active for the task
+ * @cid:	The CID associated to the task
+ * @last_cid:	The last CID associated to the task
+ */
+struct sched_mm_cid {
+	unsigned int		active;
+	unsigned int		cid;
+	unsigned int		last_cid;
+};
+
+/**
+ * struct mm_cid_pcpu - Storage for per CPU MM_CID data
+ * @cid:	The CID associated to the CPU
+ */
+struct mm_cid_pcpu {
+	unsigned int	cid;
+};
+
+/**
+ * struct mm_mm_cid - Storage for per MM CID data
+ * @pcpu:		Per CPU storage for CIDs associated to a CPU
+ * @nr_cpus_allowed:	The number of CPUs in the per MM allowed CPUs map. The map
+ *			is growth only.
+ * @lock:		Spinlock to protect all fields except @pcpu. It also protects
+ *			the MM cid cpumask and the MM cidmask bitmap.
+ */
+struct mm_mm_cid {
+	struct mm_cid_pcpu	__percpu *pcpu;
+	unsigned int		nr_cpus_allowed;
+	raw_spinlock_t		lock;
+};
+#else /* CONFIG_SCHED_MM_CID */
+struct mm_mm_cid { };
+struct sched_mm_cid { };
+#endif /* !CONFIG_SCHED_MM_CID */
+
 #endif
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1407,14 +1407,7 @@ struct task_struct {
 #endif /* CONFIG_NUMA_BALANCING */
 
 	struct rseq_data		rseq;
-
-#ifdef CONFIG_SCHED_MM_CID
-	int				mm_cid;		/* Current cid in mm */
-	int				last_mm_cid;	/* Most recent cid in mm */
-	int				migrate_from_cpu;
-	int				mm_cid_active;	/* Whether cid bitmap is active */
-	struct callback_head		cid_work;
-#endif
+	struct sched_mm_cid		mm_cid;
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 
@@ -2308,7 +2301,7 @@ void sched_mm_cid_fork(struct task_struc
 void sched_mm_cid_exit_signals(struct task_struct *t);
 static inline int task_mm_cid(struct task_struct *t)
 {
-	return t->mm_cid;
+	return t->mm_cid.cid;
 }
 #else
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -223,6 +223,9 @@ struct task_struct init_task __aligned(L
 #ifdef CONFIG_SECCOMP_FILTER
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_SCHED_MM_CID
+	.mm_cid		= { .cid = MM_CID_UNSET, },
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -955,9 +955,9 @@ static struct task_struct *dup_task_stru
 #endif
 
 #ifdef CONFIG_SCHED_MM_CID
-	tsk->mm_cid = MM_CID_UNSET;
-	tsk->last_mm_cid = MM_CID_UNSET;
-	tsk->mm_cid_active = 0;
+	tsk->mm_cid.cid = MM_CID_UNSET;
+	tsk->mm_cid.last_cid = MM_CID_UNSET;
+	tsk->mm_cid.active = 0;
 #endif
 	return tsk;
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10377,14 +10377,14 @@ void sched_mm_cid_exit_signals(struct ta
 {
 	struct mm_struct *mm = t->mm;
 
-	if (!mm || !t->mm_cid_active)
+	if (!mm || !t->mm_cid.active)
 		return;
 
 	guard(preempt)();
-	t->mm_cid_active = 0;
-	if (t->mm_cid != MM_CID_UNSET) {
-		cpumask_clear_cpu(t->mm_cid, mm_cidmask(mm));
-		t->mm_cid = MM_CID_UNSET;
+	t->mm_cid.active = 0;
+	if (t->mm_cid.cid != MM_CID_UNSET) {
+		cpumask_clear_cpu(t->mm_cid.cid, mm_cidmask(mm));
+		t->mm_cid.cid = MM_CID_UNSET;
 	}
 }
 
@@ -10403,14 +10403,14 @@ void sched_mm_cid_after_execve(struct ta
 		return;
 
 	guard(preempt)();
-	t->mm_cid_active = 1;
+	t->mm_cid.active = 1;
 	mm_cid_select(t);
 }
 
 void sched_mm_cid_fork(struct task_struct *t)
 {
-	WARN_ON_ONCE(!t->mm || t->mm_cid != MM_CID_UNSET);
-	t->mm_cid_active = 1;
+	WARN_ON_ONCE(!t->mm || t->mm_cid.cid != MM_CID_UNSET);
+	t->mm_cid.active = 1;
 }
 #endif /* CONFIG_SCHED_MM_CID */
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3548,8 +3548,8 @@ static inline void init_sched_mm_cid(str
 		return;
 
 	/* Preset last_mm_cid */
-	max_cid = min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm_users));
-	t->last_mm_cid = max_cid - 1;
+	max_cid = min_t(int, READ_ONCE(mm->mm_cid.nr_cpus_allowed), atomic_read(&mm->mm_users));
+	t->mm_cid.last_cid = max_cid - 1;
 }
 
 static inline bool __mm_cid_get(struct task_struct *t, unsigned int cid, unsigned int max_cids)
@@ -3560,8 +3560,8 @@ static inline bool __mm_cid_get(struct t
 		return false;
 	if (cpumask_test_and_set_cpu(cid, mm_cidmask(mm)))
 		return false;
-	t->mm_cid = t->last_mm_cid = cid;
-	__this_cpu_write(mm->pcpu_cid->cid, cid);
+	t->mm_cid.cid = t->mm_cid.last_cid = cid;
+	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
 	return true;
 }
 
@@ -3570,14 +3570,14 @@ static inline bool mm_cid_get(struct tas
 	struct mm_struct *mm = t->mm;
 	unsigned int max_cids;
 
-	max_cids = min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm_users));
+	max_cids = min_t(int, READ_ONCE(mm->mm_cid.nr_cpus_allowed), atomic_read(&mm->mm_users));
 
 	/* Try to reuse the last CID of this task */
-	if (__mm_cid_get(t, t->last_mm_cid, max_cids))
+	if (__mm_cid_get(t, t->mm_cid.last_cid, max_cids))
 		return true;
 
 	/* Try to reuse the last CID of this mm on this CPU */
-	if (__mm_cid_get(t, __this_cpu_read(mm->pcpu_cid->cid), max_cids))
+	if (__mm_cid_get(t, __this_cpu_read(mm->mm_cid.pcpu->cid), max_cids))
 		return true;
 
 	/* Try the first zero bit in the cidmask. */
@@ -3600,15 +3600,15 @@ static inline void mm_cid_select(struct
 
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
 {
-	if (prev->mm_cid_active) {
-		if (prev->mm_cid != MM_CID_UNSET)
-			cpumask_clear_cpu(prev->mm_cid, mm_cidmask(prev->mm));
-		prev->mm_cid = MM_CID_UNSET;
+	if (prev->mm_cid.active) {
+		if (prev->mm_cid.cid != MM_CID_UNSET)
+			cpumask_clear_cpu(prev->mm_cid.cid, mm_cidmask(prev->mm));
+		prev->mm_cid.cid = MM_CID_UNSET;
 	}
 
-	if (next->mm_cid_active) {
+	if (next->mm_cid.active) {
 		mm_cid_select(next);
-		rseq_sched_set_task_mm_cid(next, next->mm_cid);
+		rseq_sched_set_task_mm_cid(next, next->mm_cid.cid);
 	}
 }
 



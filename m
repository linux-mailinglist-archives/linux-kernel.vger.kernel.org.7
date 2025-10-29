Return-Path: <linux-kernel+bounces-876129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E2C1AA82
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AE415892EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A98834F461;
	Wed, 29 Oct 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lEqPlxE4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rbfm/ehr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3C934F492
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743375; cv=none; b=IsUzcpWKcAiY9kumXDYtiXLNZjkc7M0dC5FNK5wmT84E+Zrhe+IFeUXqCcB5s5s8X9jCXaQMMcDXI1nr3vW2DsLwR4mnURDsnxjHb4L6C3bE8j2vlF1CtPP33H4UKoor6uQ/E+0z9pWH3dQtB9M8Vzl9alpKutmpf6vQh41rshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743375; c=relaxed/simple;
	bh=s9jMiqPO4ZJ+nLpTjIce+ge0wM/maPey74EQLNv0Zxg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ifjA3JxLxIp8nD/SuTF313nnAo4R2hQNKwGmr8LAq06LASZ81/zltmFLY6DGimBpiezMYZTdib9DuTxFRFQGre812xROIX5iv8uVNipbjydpOpMKiOR8gQ8S3I5+t3XXunNb25zd8iAVKPEKkSIaHxT35Tt3qSafmlb4o71nZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lEqPlxE4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rbfm/ehr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124516.468663211@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yobgRdtA+fYOK5cSL2kEuxt7oqiqc9NxwUxcjAWUeBQ=;
	b=lEqPlxE4PtIRuXi9cnAgO0OkBh5+2MFy2TaUDdlxINBSP0rojhitkBSiEwQE4rRhb8qWHx
	bI/O/qr7tpQasYPTX+U3JvomErvyGp0U7t7PQhcqk4t+RA3/3Zl+OM5Bjuj3ZG0WDV0oj3
	cJU2q+2YMP43KTpeIlWojG0Poj6BRytWRYClNIlqRWzw7/yZo4POXDSy1GMa0WKrDlMhvu
	1XSgTkcjS0BBgM3lppeFOCxiMKYrivEjfWBZY6tqc4PAkLO6LDcioCVXX0iOwVzDPxHxG/
	eZReIC858EUUrxH1LXen3fAStR/tChZlMPHxW0foDLV8uXuQbWeAVh8B8wdm7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yobgRdtA+fYOK5cSL2kEuxt7oqiqc9NxwUxcjAWUeBQ=;
	b=Rbfm/ehrY8Ge4ydjFveI6lvEeIWBJJYouktwYzx77/NZVCJQy/lW3it2bsn7B/MYF9DPEA
	puruaecRSzeOhrDA==
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
 Yury Norov <yury.norov@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [patch V3 19/20] sched/mmcid: Implement deferred mode change
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:30 +0100 (CET)

When affinity changes cause an increase of the number of CPUs allowed for
tasks which are related to a MM, that might results in a situation where
the ownership mode can go back from per CPU mode to per task mode.

As affinity changes happen with runqueue lock held there is no way to do
the actual mode change and required fixup right there.

Add the infrastructure to defer it to a workqueue. The scheduled work can
race with a fork() or exit(). Whatever happens first takes care of it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq_types.h |    8 ++++++
 kernel/sched/core.c        |   58 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 7 deletions(-)

--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -2,7 +2,9 @@
 #ifndef _LINUX_RSEQ_TYPES_H
 #define _LINUX_RSEQ_TYPES_H
 
+#include <linux/irq_work_types.h>
 #include <linux/types.h>
+#include <linux/workqueue_types.h>
 
 #ifdef CONFIG_RSEQ
 struct rseq;
@@ -129,6 +131,8 @@ struct mm_cid_pcpu {
  *			do not actually share the MM.
  * @pcpu_thrs:		Threshold for switching back from per CPU mode
  * @update_deferred:	A deferred switch back to per task mode is pending.
+ * @irq_work:		irq_work to handle the affinity mode change case
+ * @work:		Regular work to handle the affinity mode change case
  * @lock:		Spinlock to protect against affinity setting which can't take @mutex
  * @mutex:		Mutex to serialize forks and exits related to this mm
  */
@@ -145,6 +149,10 @@ struct mm_mm_cid {
 	unsigned int		pcpu_thrs;
 	unsigned int		update_deferred;
 
+	/* Rarely used. Moves @lock and @mutex into the second cacheline */
+	struct irq_work		irq_work;
+	struct work_struct	work;
+
 	raw_spinlock_t		lock;
 	struct mutex		mutex;
 }____cacheline_aligned_in_smp;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10536,8 +10536,17 @@ static inline void mm_update_cpus_allowe
 
 	/* Adjust the threshold to the wider set */
 	mc->pcpu_thrs = mm_cid_calc_pcpu_thrs(mc);
+	/* Switch back to per task mode? */
+	if (mc->users >= mc->pcpu_thrs)
+		return;
+
+	/* Don't queue twice */
+	if (mc->update_deferred)
+		return;
 
-	/* Scheduling of deferred mode switch goes here */
+	/* Queue the irq work, which schedules the real work */
+	mc->update_deferred = true;
+	irq_work_queue(&mc->irq_work);
 }
 
 static inline void mm_cid_transit_to_task(struct task_struct *t, struct mm_cid_pcpu *pcp)
@@ -10550,7 +10559,7 @@ static inline void mm_cid_transit_to_tas
 	}
 }
 
-static void __maybe_unused mm_cid_fixup_cpus_to_tasks(struct mm_struct *mm)
+static void mm_cid_fixup_cpus_to_tasks(struct mm_struct *mm)
 {
 	unsigned int cpu;
 
@@ -10711,14 +10720,47 @@ void sched_mm_cid_after_execve(struct ta
 	mm_cid_select(t);
 }
 
-void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
+static void mm_cid_work_fn(struct work_struct *work)
 {
-	struct mm_cid_pcpu __percpu *pcpu = mm->mm_cid.pcpu;
-	int cpu;
+	struct mm_struct *mm = container_of(work, struct mm_struct, mm_cid.work);
+
+	/* Make it compile, but not functional yet */
+	if (!IS_ENABLED(CONFIG_NEW_MM_CID))
+		return;
 
-	for_each_possible_cpu(cpu)
-		per_cpu_ptr(pcpu, cpu)->cid = MM_CID_UNSET;
+	guard(mutex)(&mm->mm_cid.mutex);
+	/* Did the last user task exit already? */
+	if (!mm->mm_cid.users)
+		return;
 
+	scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
+		/* Have fork() or exit() handled it already? */
+		if (!mm->mm_cid.update_deferred)
+			return;
+		/* This clears mm_cid::update_deferred */
+		if (!mm_update_max_cids(mm))
+			return;
+		/* Affinity changes can only switch back to task mode */
+		if (WARN_ON_ONCE(mm->mm_cid.percpu))
+			return;
+	}
+	mm_cid_fixup_cpus_to_tasks(mm);
+}
+
+static void mm_cid_irq_work(struct irq_work *work)
+{
+	struct mm_struct *mm = container_of(work, struct mm_struct, mm_cid.irq_work);
+
+	/*
+	 * Needs to be unconditional because mm_cid::lock cannot be held
+	 * when scheduling work as mm_update_cpus_allowed() nests inside
+	 * rq::lock and schedule_work() might end up in wakeup...
+	 */
+	schedule_work(&mm->mm_cid.work);
+}
+
+void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
+{
 	mm->mm_cid.max_cids = 0;
 	mm->mm_cid.percpu = 0;
 	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
@@ -10727,6 +10769,8 @@ void mm_init_cid(struct mm_struct *mm, s
 	mm->mm_cid.update_deferred = 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
 	mutex_init(&mm->mm_cid.mutex);
+	mm->mm_cid.irq_work = IRQ_WORK_INIT_HARD(mm_cid_irq_work);
+	INIT_WORK(&mm->mm_cid.work, mm_cid_work_fn);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	bitmap_zero(mm_cidmask(mm), bitmap_size(num_possible_cpus()));
 }



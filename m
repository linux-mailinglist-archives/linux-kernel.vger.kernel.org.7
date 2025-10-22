Return-Path: <linux-kernel+bounces-865020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7DBBFC17D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992753BC75A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE2355059;
	Wed, 22 Oct 2025 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/qbiEal";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pAzgI6Ix"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B66351FD8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137748; cv=none; b=N2TaHmFKtWKh46M1XreI743RDdRtg7MZl2RlAd5JYtF8nt9kTUoA2DdBOzZGsMmuQAq5zt4buViLQU0VZpCbUJQEsZ2FHz0pqotI4trOIt+eXeGH0aWAS4x9H52/EEohZ59yxPFbYlC5akGdZztPGW0KUp2f8CZW+QFNSO/4a3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137748; c=relaxed/simple;
	bh=F75qxiXKkV8lPxhTQpMkybpHr1CYvYGGAHwOi1rvPlk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=CL6wGhipCm8oWeUTBkN71VaEkra3IdQiUWJeiyVxHWh/e+G0HAOFoMccS0hb6XRpNxwlxmy5/949B6vNcAgmhsuZye0WIUFaCLPmu6n0trbS4ZBNwi8KcjHvskUkJrdNxpyqChWpsw52inJRhznEQhOfJ73I8BnWArPwFH7dk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/qbiEal; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pAzgI6Ix; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110556.645043284@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BSKx7Zg2VXl6FgRMTDKlT+nL6S8tAsFb8A0mWyeH2BI=;
	b=D/qbiEalRCDXp3C4hZBitZmlwjehsxz1orAopRy8jEDmIOHzNEsiinLhV9KsHAAXV4g7jk
	7pCn75QIwgPy4KqU2xq3mXZBTYgF8fNvUCj1w6T7fzuirTOnAA5tGoRwAI9fMBM9OjqoXp
	j0EHzsxVjtyuPsjVHE880G+gdMi5qvE4GCjZQl634h+LhM3/pxPZ4VUe9fG9kEzrxYr7Cl
	Jx5hE0xmm+bc0lq6YNeL5PoVV/DTOf12QdKdxDJe3hoXU97Wu/MFRVMRw3U8eoVLDIQkln
	dJQeLLxKjE8g+Kd65TlegiaaC1trtHCt8BaTeE5XSwl3Pj+WrbwcIi0o81LGEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BSKx7Zg2VXl6FgRMTDKlT+nL6S8tAsFb8A0mWyeH2BI=;
	b=pAzgI6Ixg+eyel/jnYB4iWNZQ9y1Y+biVROCuVaUcxTLMyvKu1Xj7v8QPo8XbjILVa9zA1
	eeHaDrUTkGyJW3Cg==
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
Subject: [patch V2 20/20] sched/mmcid: Switch over to the new mechanism
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:44 +0200 (CEST)

Now that all pieces are in place, change the implementations of
sched_mm_cid_fork() and sched_mm_cid_exit() to adhere to the new strict
ownership scheme and switch context_switch() over to use the new
mm_cid_schedin() functionality.

The common case is that there is no mode change required, which makes
fork() and exit() just update the user count and the constraints.

In case that a new user would exceed the CID space limit the fork() context
handles the transition to per CPU mode with mm::mm_cid::mutex held. exit()
handles the transition back to per task mode when the user count drops
below the switch back threshold. fork() might also be forced to handle a
deferred switch back to per task mode, when a affinity change increased the
number of allowed CPUs enough.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq.h       |   19 -------
 include/linux/rseq_types.h |    8 +--
 kernel/fork.c              |    1 
 kernel/sched/core.c        |  115 ++++++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h       |   76 -----------------------------
 5 files changed, 103 insertions(+), 116 deletions(-)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -84,24 +84,6 @@ static __always_inline void rseq_sched_s
 	t->rseq.event.ids_changed = true;
 }
 
-/*
- * Invoked from switch_mm_cid() in context switch when the task gets a MM
- * CID assigned.
- *
- * This does not raise TIF_NOTIFY_RESUME as that happens in
- * rseq_sched_switch_event().
- */
-static __always_inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigned int cid)
-{
-	/*
-	 * Requires a comparison as the switch_mm_cid() code does not
-	 * provide a conditional for it readily. So avoid excessive updates
-	 * when nothing changes.
-	 */
-	if (t->rseq.ids.mm_cid != cid)
-		t->rseq.event.ids_changed = true;
-}
-
 /* Enforce a full update after RSEQ registration and when execve() failed */
 static inline void rseq_force_update(void)
 {
@@ -170,7 +152,6 @@ static inline void rseq_handle_slowpath(
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
 static inline void rseq_sched_set_ids_changed(struct task_struct *t) { }
-static inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigned int cid) { }
 static inline void rseq_force_update(void) { }
 static inline void rseq_virt_userspace_exit(void) { }
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -101,18 +101,18 @@ struct rseq_data { };
 /**
  * struct sched_mm_cid - Storage for per task MM CID data
  * @active:	MM CID is active for the task
- * @cid:	The CID associated to the task
- * @last_cid:	The last CID associated to the task
+ * @cid:	The CID associated to the task either permanently or
+ *		borrowed from the CPU
  */
 struct sched_mm_cid {
 	unsigned int		active;
 	unsigned int		cid;
-	unsigned int		last_cid;
 };
 
 /**
  * struct mm_cid_pcpu - Storage for per CPU MM_CID data
- * @cid:	The CID associated to the CPU
+ * @cid:	The CID associated to the CPU either permanently or
+ *		while a task with a CID is running
  */
 struct mm_cid_pcpu {
 	unsigned int	cid;
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -956,7 +956,6 @@ static struct task_struct *dup_task_stru
 
 #ifdef CONFIG_SCHED_MM_CID
 	tsk->mm_cid.cid = MM_CID_UNSET;
-	tsk->mm_cid.last_cid = MM_CID_UNSET;
 	tsk->mm_cid.active = 0;
 #endif
 	return tsk;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5307,7 +5307,7 @@ context_switch(struct rq *rq, struct tas
 		}
 	}
 
-	switch_mm_cid(prev, next);
+	mm_cid_switch_to(prev, next);
 
 	/*
 	 * Tell rseq that the task was scheduled in. Must be after
@@ -10621,7 +10621,7 @@ static bool mm_cid_fixup_task_to_cpu(str
 	return true;
 }
 
-static void __maybe_unused mm_cid_fixup_tasks_to_cpus(void)
+static void mm_cid_fixup_tasks_to_cpus(void)
 {
 	struct mm_struct *mm = current->mm;
 	struct task_struct *p, *t;
@@ -10671,25 +10671,81 @@ static bool sched_mm_cid_add_user(struct
 void sched_mm_cid_fork(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
+	bool percpu;
 
 	WARN_ON_ONCE(!mm || t->mm_cid.cid != MM_CID_UNSET);
 
 	guard(mutex)(&mm->mm_cid.mutex);
-	scoped_guard(raw_spinlock, &mm->mm_cid.lock) {
-		sched_mm_cid_add_user(t, mm);
-		/* Preset last_cid for mm_cid_select() */
-		t->mm_cid.last_cid = mm->mm_cid.max_cids - 1;
+	scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
+		struct mm_cid_pcpu *pcp = this_cpu_ptr(mm->mm_cid.pcpu);
+
+		/* First user ? */
+		if (!mm->mm_cid.users) {
+			sched_mm_cid_add_user(t, mm);
+			t->mm_cid.cid = mm_get_cid(mm);
+			/* Required for execve() */
+			pcp->cid = t->mm_cid.cid;
+			return;
+		}
+
+		if (!sched_mm_cid_add_user(t, mm)) {
+			if (!mm->mm_cid.percpu)
+				t->mm_cid.cid = mm_get_cid(mm);
+			return;
+		}
+
+		/* Handle the mode change and transfer current's CID */
+		percpu = !!mm->mm_cid.percpu;
+		if (!percpu)
+			mm_cid_transit_to_task(current, pcp);
+		else
+			mm_cid_transfer_to_cpu(current, pcp);
+	}
+
+	if (percpu) {
+		mm_cid_fixup_tasks_to_cpus();
+	} else {
+		mm_cid_fixup_cpus_to_tasks(mm);
+		t->mm_cid.cid = mm_get_cid(mm);
 	}
 }
 
 static bool sched_mm_cid_remove_user(struct task_struct *t)
 {
 	t->mm_cid.active = 0;
-	mm_unset_cid_on_task(t);
+	scoped_guard(preempt) {
+		/* Clear the transition bit */
+		t->mm_cid.cid = cid_from_transit_cid(t->mm_cid.cid);
+		mm_unset_cid_on_task(t);
+	}
 	t->mm->mm_cid.users--;
 	return mm_update_max_cids(t->mm);
 }
 
+static bool __sched_mm_cid_exit(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+
+	if (!sched_mm_cid_remove_user(t))
+		return false;
+	/*
+	 * Contrary to fork() this only deals with a switch back to per
+	 * task mode either because the above decreased users or an
+	 * affinity change increased the number of allowed CPUs and the
+	 * deferred fixup did not run yet.
+	 */
+	if (WARN_ON_ONCE(mm->mm_cid.percpu))
+		return false;
+	/*
+	 * A failed fork(2) cleanup never gets here, so @current must have
+	 * the same MM as @t. That's true for exit() and the failed
+	 * pthread_create() cleanup case.
+	 */
+	if (WARN_ON_ONCE(current->mm != mm))
+		return false;
+	return true;
+}
+
 /*
  * When a task exits, the MM CID held by the task is not longer required as
  * the task cannot return to user space.
@@ -10700,10 +10756,43 @@ void sched_mm_cid_exit(struct task_struc
 
 	if (!mm || !t->mm_cid.active)
 		return;
+	/*
+	 * Ensure that only one instance is doing MM CID operations within
+	 * a MM. The common case is uncontended. The rare fixup case adds
+	 * some overhead.
+	 */
+	scoped_guard(mutex, &mm->mm_cid.mutex) {
+		/* mm_cid::mutex is sufficient to protect mm_cid::users */
+		if (likely(mm->mm_cid.users > 1)) {
+			scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
+				if (!__sched_mm_cid_exit(t))
+					return;
+				/* Mode change required. Transfer currents CID */
+				mm_cid_transit_to_task(current, this_cpu_ptr(mm->mm_cid.pcpu));
+			}
+			mm_cid_fixup_cpus_to_tasks(mm);
+			return;
+		}
+		/* Last user */
+		scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
+			/* Required across execve() */
+			if (t == current)
+				mm_cid_transit_to_task(t, this_cpu_ptr(mm->mm_cid.pcpu));
+			/* Ignore mode change. There is nothing to do. */
+			sched_mm_cid_remove_user(t);
+		}
+	}
 
-	guard(mutex)(&mm->mm_cid.mutex);
-	scoped_guard(raw_spinlock, &mm->mm_cid.lock)
-		sched_mm_cid_remove_user(t);
+	/*
+	 * As this is the last user (execve(), process exit or failed
+	 * fork(2)) there is no concurrency anymore.
+	 *
+	 * Synchronize eventally pending work to ensure that there are no
+	 * dangling references left. @t->mm_cid.users is zero so nothing
+	 * can queue this work anymore.
+	 */
+	irq_work_sync(&mm->mm_cid.irq_work);
+	cancel_work_sync(&mm->mm_cid.work);
 }
 
 /* Deactivate MM CID allocation across execve() */
@@ -10716,18 +10805,12 @@ void sched_mm_cid_before_execve(struct t
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	sched_mm_cid_fork(t);
-	guard(preempt)();
-	mm_cid_select(t);
 }
 
 static void mm_cid_work_fn(struct work_struct *work)
 {
 	struct mm_struct *mm = container_of(work, struct mm_struct, mm_cid.work);
 
-	/* Make it compile, but not functional yet */
-	if (!IS_ENABLED(CONFIG_NEW_MM_CID))
-		return;
-
 	guard(mutex)(&mm->mm_cid.mutex);
 	/* Did the last user task exit already? */
 	if (!mm->mm_cid.users)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3743,83 +3743,7 @@ static inline void mm_cid_switch_to(stru
 	mm_cid_schedin(next);
 }
 
-/* Active implementation */
-static inline void init_sched_mm_cid(struct task_struct *t)
-{
-	struct mm_struct *mm = t->mm;
-	unsigned int max_cid;
-
-	if (!mm)
-		return;
-
-	/* Preset last_mm_cid */
-	max_cid = min_t(int, READ_ONCE(mm->mm_cid.nr_cpus_allowed), atomic_read(&mm->mm_users));
-	t->mm_cid.last_cid = max_cid - 1;
-}
-
-static inline bool __mm_cid_get(struct task_struct *t, unsigned int cid, unsigned int max_cids)
-{
-	struct mm_struct *mm = t->mm;
-
-	if (cid >= max_cids)
-		return false;
-	if (test_and_set_bit(cid, mm_cidmask(mm)))
-		return false;
-	t->mm_cid.cid = t->mm_cid.last_cid = cid;
-	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
-	return true;
-}
-
-static inline bool mm_cid_get(struct task_struct *t)
-{
-	struct mm_struct *mm = t->mm;
-	unsigned int max_cids;
-
-	max_cids = READ_ONCE(mm->mm_cid.max_cids);
-
-	/* Try to reuse the last CID of this task */
-	if (__mm_cid_get(t, t->mm_cid.last_cid, max_cids))
-		return true;
-
-	/* Try to reuse the last CID of this mm on this CPU */
-	if (__mm_cid_get(t, __this_cpu_read(mm->mm_cid.pcpu->cid), max_cids))
-		return true;
-
-	/* Try the first zero bit in the cidmask. */
-	return __mm_cid_get(t, find_first_zero_bit(mm_cidmask(mm), num_possible_cpus()), max_cids);
-}
-
-static inline void mm_cid_select(struct task_struct *t)
-{
-	/*
-	 * mm_cid_get() can fail when the maximum CID, which is determined
-	 * by min(mm->nr_cpus_allowed, mm->mm_users) changes concurrently.
-	 * That's a transient failure as there cannot be more tasks
-	 * concurrently on a CPU (or about to be scheduled in) than that.
-	 */
-	for (;;) {
-		if (mm_cid_get(t))
-			break;
-	}
-}
-
-static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
-{
-	if (prev->mm_cid.active) {
-		if (prev->mm_cid.cid != MM_CID_UNSET)
-			clear_bit(prev->mm_cid.cid, mm_cidmask(prev->mm));
-		prev->mm_cid.cid = MM_CID_UNSET;
-	}
-
-	if (next->mm_cid.active) {
-		mm_cid_select(next);
-		rseq_sched_set_task_mm_cid(next, next->mm_cid.cid);
-	}
-}
-
 #else /* !CONFIG_SCHED_MM_CID: */
-static inline void mm_cid_select(struct task_struct *t) { }
-static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
 static inline void mm_cid_switch_to(struct task_struct *prev, struct task_struct *next) { }
 #endif /* !CONFIG_SCHED_MM_CID */
 



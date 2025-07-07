Return-Path: <linux-kernel+bounces-720059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B1AAFB675
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D012F1891FBD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DA02BEC52;
	Mon,  7 Jul 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRvgGpRp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC87288506
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899732; cv=none; b=TEqD5ZF/sBPYYFfvnHxCkGeh5emB5dt/JKfYfuBdSEL5RMwi7YyBh6nijKVprrwliQ6Ff3NBh7SAsdcXXmuiAJogMt6QqSSNrktaXSqGNCmlASw1gZOjAlJ9WfbQq5ChK3Ad1cZ3RNQTythbMmRoqhxVRcciBx6ZIFq2Q4V0BGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899732; c=relaxed/simple;
	bh=OT85XUTCiK/u9HH8EcciN5jyQveiKYRgfcBGYDbsKLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkwIftRF6QmT09aKicpP00KgOj/MXfNqaI1SKy2rtWSj3ubBOfPPNnUAKPDjF1Kiv70V/NtUxhpCb457NJscoeGyHAE+kBXkrGCKd2jH6BN5Jd1ETrkngZ+c/bo/5J3NnALrl46CTLMZ8ZJJ7wW+7MZ4+hxVilF/jAw/CRzvG1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRvgGpRp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751899728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3YnxnC/FgU308ft+qHvN/C9UDnmZxA2+M7xo4oEPhY=;
	b=WRvgGpRpSS9wFxhFQJkBCzIvuFDo+e8dNX+QbUX01wJBefApBnC/oCIX7cKpLsSEiWpY8q
	sUmJ7itDaWN4v9cwa7FZdfHduZ5BUzMgqM9rXN31sWonpErryX/n8/fg+luJWMwW45wdB3
	1KjaHdWNTb25TqqLzrBQoIicpfwuqxE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-aRKoOQhAP125QnKMmBrPTA-1; Mon,
 07 Jul 2025 10:48:45 -0400
X-MC-Unique: aRKoOQhAP125QnKMmBrPTA-1
X-Mimecast-MFC-AGG-ID: aRKoOQhAP125QnKMmBrPTA_1751899724
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 086981944A83;
	Mon,  7 Jul 2025 14:48:44 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.226.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 455F3180035E;
	Mon,  7 Jul 2025 14:48:38 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-mm@kvack.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.org>
Subject: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer
Date: Mon,  7 Jul 2025 16:48:23 +0200
Message-ID: <20250707144824.117014-3-gmonaco@redhat.com>
In-Reply-To: <20250707144824.117014-1-gmonaco@redhat.com>
References: <20250707144824.117014-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, the task_mm_cid_work function is called in a task work
triggered by a scheduler tick to frequently compact the mm_cids of each
process. This can delay the execution of the corresponding thread for
the entire duration of the function, negatively affecting the response
in case of real time tasks. In practice, we observe task_mm_cid_work
increasing the latency of 30-35us on a 128 cores system, this order of
magnitude is meaningful under PREEMPT_RT.

Run the task_mm_cid_work in a new timer connected to the mm_struct
rather than in the task context before returning to userspace.

This timer is initialised with the mm and disabled before freeing it.
The timer is armed while returning to userspace in
__rseq_handle_notify_resume, with an expiration of MM_CID_SCAN_DELAY.
To make sure this happens predictably also on long running tasks,
trigger a call to __rseq_handle_notify_resume also from the scheduler
tick if the runtime exceeded a 100ms threshold.

The main advantage of this change is that the function can be offloaded
to a different CPU and even preempted by RT tasks.

Moreover, this new behaviour is more predictable with periodic tasks
with short runtime, which may rarely run during a scheduler tick.
Now, the timer is always scheduled when the task returns to userspace.

The timer is disabled during mmdrop, since the function cannot sleep in
all kernel configurations, we cannot wait for a possibly running timer
to terminate. Make sure the mm is valid in case the task is terminating
by reserving it with mmgrab/mmdrop, returning prematurely if the timer
handler is really the last user while it gets to run.
This situation is unlikely since the timer is not armed for exiting
tasks, but it cannot be ruled out.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/mm_types.h |  23 +++++++--
 include/linux/sched.h    |   8 ++-
 kernel/rseq.c            |   2 +
 kernel/sched/core.c      | 103 +++++++++++++++++++++------------------
 kernel/sched/sched.h     |   8 +--
 5 files changed, 88 insertions(+), 56 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d6b91e8a66d6d..9c159cf70a16c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -990,11 +990,11 @@ struct mm_struct {
 		 */
 		struct mm_cid __percpu *pcpu_cid;
 		/*
-		 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
+		 * @mm_cid_next_scan: Last mm_cid scan (in jiffies).
 		 *
-		 * When the next mm_cid scan is due (in jiffies).
+		 * When the last mm_cid scan occurred (in jiffies).
 		 */
-		unsigned long mm_cid_next_scan;
+		unsigned long mm_cid_last_scan;
 		/**
 		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
 		 *
@@ -1017,6 +1017,10 @@ struct mm_struct {
 		 * mm nr_cpus_allowed updates.
 		 */
 		raw_spinlock_t cpus_allowed_lock;
+		/*
+		 * @cid_timer: Timer to run the mm_cid scan.
+		 */
+		struct timer_list cid_timer;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -1321,6 +1325,8 @@ enum mm_cid_state {
 	MM_CID_LAZY_PUT = (1U << 31),
 };
 
+extern void task_mm_cid_scan(struct timer_list *timer);
+
 static inline bool mm_cid_is_unset(int cid)
 {
 	return cid == MM_CID_UNSET;
@@ -1393,12 +1399,14 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
 	if (!mm->pcpu_cid)
 		return -ENOMEM;
 	mm_init_cid(mm, p);
+	timer_setup(&mm->cid_timer, task_mm_cid_scan, TIMER_DEFERRABLE);
 	return 0;
 }
 #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
 
 static inline void mm_destroy_cid(struct mm_struct *mm)
 {
+	timer_shutdown(&mm->cid_timer);
 	free_percpu(mm->pcpu_cid);
 	mm->pcpu_cid = NULL;
 }
@@ -1420,6 +1428,11 @@ static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumas
 	WRITE_ONCE(mm->nr_cpus_allowed, cpumask_weight(mm_allowed));
 	raw_spin_unlock(&mm->cpus_allowed_lock);
 }
+
+static inline bool mm_cid_scan_pending(struct mm_struct *mm)
+{
+	return mm && timer_pending(&mm->cid_timer);
+}
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
 static inline int mm_alloc_cid(struct mm_struct *mm, struct task_struct *p) { return 0; }
@@ -1430,6 +1443,10 @@ static inline unsigned int mm_cid_size(void)
 	return 0;
 }
 static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask) { }
+static inline bool mm_cid_scan_pending(struct mm_struct *mm)
+{
+	return false;
+}
 #endif /* CONFIG_SCHED_MM_CID */
 
 struct mmu_gather;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64beb52c..e90bc52dece3e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1432,7 +1432,7 @@ struct task_struct {
 	int				last_mm_cid;	/* Most recent cid in mm */
 	int				migrate_from_cpu;
 	int				mm_cid_active;	/* Whether cid bitmap is active */
-	struct callback_head		cid_work;
+	unsigned long			last_cid_reset;	/* Time of last reset in jiffies */
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
@@ -2277,4 +2277,10 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
 
+#ifdef CONFIG_SCHED_MM_CID
+extern void task_queue_mm_cid(struct task_struct *curr);
+#else
+static inline void task_queue_mm_cid(struct task_struct *curr) { }
+#endif
+
 #endif
diff --git a/kernel/rseq.c b/kernel/rseq.c
index b7a1ec327e811..9ce0f79e35bfb 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -441,6 +441,8 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	}
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
+	if (!mm_cid_scan_pending(t->mm))
+		task_queue_mm_cid(t);
 	return;
 
 error:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ec68fc686bd74..ed316f0a31d9d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4542,7 +4542,6 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
-	init_sched_mm_cid(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -10594,37 +10593,15 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
 	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
 }
 
-static void task_mm_cid_work(struct callback_head *work)
+void task_mm_cid_scan(struct timer_list *timer)
 {
-	unsigned long now = jiffies, old_scan, next_scan;
-	struct task_struct *t = current;
 	struct cpumask *cidmask;
-	struct mm_struct *mm;
+	struct mm_struct *mm = container_of(timer, struct mm_struct, cid_timer);
 	int weight, cpu;
 
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
+	/* We are the last user, process already terminated. */
+	if (atomic_read(&mm->mm_count) == 1)
+		goto out_drop;
 	cidmask = mm_cidmask(mm);
 	/* Clear cids that were not recently used. */
 	for_each_possible_cpu(cpu)
@@ -10636,35 +10613,65 @@ static void task_mm_cid_work(struct callback_head *work)
 	 */
 	for_each_possible_cpu(cpu)
 		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
+	WRITE_ONCE(mm->mm_cid_last_scan, jiffies);
+out_drop:
+	mmdrop(mm);
 }
 
-void init_sched_mm_cid(struct task_struct *t)
+void task_tick_mm_cid(struct rq *rq, struct task_struct *t)
 {
-	struct mm_struct *mm = t->mm;
-	int mm_users = 0;
+	u64 rtime = t->se.sum_exec_runtime - t->se.prev_sum_exec_runtime;
 
-	if (mm) {
-		mm_users = atomic_read(&mm->mm_users);
-		if (mm_users == 1)
-			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
+	/*
+	 * If a task is running unpreempted for a long time, it won't get its
+	 * mm_cid compacted and won't update its mm_cid value after a
+	 * compaction occurs.
+	 * For such a task, this function does two things:
+	 * A) trigger the mm_cid recompaction,
+	 * B) trigger an update of the task's rseq->mm_cid field at some point
+	 * after recompaction, so it can get a mm_cid value closer to 0.
+	 * A change in the mm_cid triggers an rseq_preempt.
+	 *
+	 * B occurs once after the compaction work completes, both A and B
+	 * don't run as long as the compaction work is pending.
+	 */
+	if (!t->mm || (t->flags & (PF_EXITING | PF_KTHREAD)) ||
+	    mm_cid_scan_pending(t->mm))
+		return;
+	if (rtime < RSEQ_UNPREEMPTED_THRESHOLD)
+		return;
+	if (time_after(t->mm->mm_cid_last_scan, t->last_cid_reset)) {
+		/* Update mm_cid field */
+		int old_cid = t->mm_cid;
+
+		if (!t->mm_cid_active)
+			return;
+		mm_cid_snapshot_time(rq, t->mm);
+		mm_cid_put_lazy(t);
+		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, t, t->mm);
+		if (old_cid != t->mm_cid)
+			rseq_preempt(t);
+	} else {
+		/* Trigger mm_cid recompaction */
+		rseq_set_notify_resume(t);
 	}
-	t->cid_work.next = &t->cid_work;	/* Protect against double add */
-	init_task_work(&t->cid_work, task_mm_cid_work);
 }
 
-void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
+void task_queue_mm_cid(struct task_struct *curr)
 {
-	struct callback_head *work = &curr->cid_work;
-	unsigned long now = jiffies;
+	int requeued;
 
-	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
-	    work->next != work)
-		return;
-	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
-		return;
-
-	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME);
+	/*
+	 * @curr must be a user thread and the timer must not be pending.
+	 * Access to this timer is not serialised across threads sharing the
+	 * same mm: ensure racing threads don't postpone enqueued timers and
+	 * don't mmgrab() if they didn't enqueue the timer themselves.
+	 * mmgrab() is necessary to ensure the mm exists until the timer runs.
+	 */
+	requeued = timer_reduce(&curr->mm->cid_timer,
+				jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY));
+	if (!requeued && timer_pending(&curr->mm->cid_timer))
+		mmgrab(curr->mm);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bb5998295e..3e72323fbde06 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3606,14 +3606,14 @@ extern const char *preempt_modes[];
 
 #define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
 #define MM_CID_SCAN_DELAY	100			/* 100ms */
+#define RSEQ_UNPREEMPTED_THRESHOLD	SCHED_MM_CID_PERIOD_NS
 
 extern raw_spinlock_t cid_lock;
 extern int use_cid_lock;
 
 extern void sched_mm_cid_migrate_from(struct task_struct *t);
 extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
-extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
-extern void init_sched_mm_cid(struct task_struct *t);
+extern void task_tick_mm_cid(struct rq *rq, struct task_struct *t);
 
 static inline void __mm_cid_put(struct mm_struct *mm, int cid)
 {
@@ -3809,6 +3809,7 @@ static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
 	int cid;
 
 	lockdep_assert_rq_held(rq);
+	t->last_cid_reset = jiffies;
 	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
@@ -3881,8 +3882,7 @@ static inline void switch_mm_cid(struct rq *rq,
 static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
 static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
 static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
-static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
-static inline void init_sched_mm_cid(struct task_struct *t) { }
+static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *t) { }
 #endif /* !CONFIG_SCHED_MM_CID */
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
-- 
2.50.0



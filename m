Return-Path: <linux-kernel+bounces-733919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4FDB07AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D931C25868
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236342F4A03;
	Wed, 16 Jul 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+YWym5q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF472F5336
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682018; cv=none; b=pumXi7uoj0h97xehbJvu2BFwloaTH0mgUn9guj2LU2q0iMrV+npm3q0i6teJH40DGUBfaqfRigphA1kwHqxE+fo60078U5OAZOZuImBDQBX127bSSx4HFmlfNaD55GL88jDWRNvZM4MZWVyTGah2cHBm/KRO2bG+31IfXkFQk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682018; c=relaxed/simple;
	bh=ifMnAwGYNxyxP5tsydOHaDt5x413efy5X35ku/pADAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8LjDQmE17ibuGXzve5uFWx3br1IUd9SdKPIATKLK7bNb0DpZ4YZ0RFbmxZ5PiU9LgRJQ9s9QOBW5IqjKJMWXhxYJ6CfA3OYtDZRDG24PztQnRrWxe9tIqK6ucnPFBtwUZGD+XoucCz9viJf5O6dihxFpWaL9OW2aj3oDN8FkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+YWym5q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752682015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkHMZF+W7s2KVUTf3+zNGyNPfFECcfwDxIyxKbBuCS4=;
	b=i+YWym5qAP0p+h0HtNlUTFjXzN3d/HuzvIUbhefBajLW5SENSRNOMhQAndCptzxJzx655z
	FfRNGPAtsz0h6b4URfibAH5JtuQTwAVkF4WSyPxjTvJ1bqeV2sqo2j2ghK+dX7fDqlculQ
	R5fZCdWX1H3997DE4tKa/guaeNLrthw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-n75QxM0UM3OWc2VkwffocQ-1; Wed,
 16 Jul 2025 12:06:52 -0400
X-MC-Unique: n75QxM0UM3OWc2VkwffocQ-1
X-Mimecast-MFC-AGG-ID: n75QxM0UM3OWc2VkwffocQ_1752682010
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D3101800283;
	Wed, 16 Jul 2025 16:06:50 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B48B319560AB;
	Wed, 16 Jul 2025 16:06:45 +0000 (UTC)
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
Subject: [PATCH v2 2/4] rseq: Run the mm_cid_compaction from rseq_handle_notify_resume()
Date: Wed, 16 Jul 2025 18:06:06 +0200
Message-ID: <20250716160603.138385-8-gmonaco@redhat.com>
In-Reply-To: <20250716160603.138385-6-gmonaco@redhat.com>
References: <20250716160603.138385-6-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently the mm_cid_compaction is triggered by the scheduler tick and
runs in a task_work, behaviour is more unpredictable with periodic tasks
with short runtime, which may rarely run during a tick.

Run the mm_cid_compaction from the rseq_handle_notify_resume() call,
which runs from resume_user_mode_work. Since the context is the same
where the task_work would run, skip this step and call the compaction
function directly.
The compaction function still exits prematurely in case the scan is not
required, that is when the pseudo-period of 100ms did not elapse.

Keep a tick handler used for long running tasks that are never preempted
(i.e. that never call rseq_handle_notify_resume), which triggers a
compaction and mm_cid update only in that case.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/mm.h       |  2 ++
 include/linux/mm_types.h | 11 ++++++++
 include/linux/sched.h    |  2 +-
 kernel/rseq.c            |  2 ++
 kernel/sched/core.c      | 55 +++++++++++++++++++++++++---------------
 kernel/sched/sched.h     |  2 ++
 6 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fa538feaa8d95..cc8c1c9ae26c1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2294,6 +2294,7 @@ void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
 void sched_mm_cid_fork(struct task_struct *t);
 void sched_mm_cid_exit_signals(struct task_struct *t);
+void task_mm_cid_work(struct task_struct *t);
 static inline int task_mm_cid(struct task_struct *t)
 {
 	return t->mm_cid;
@@ -2303,6 +2304,7 @@ static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_fork(struct task_struct *t) { }
 static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
+static inline void task_mm_cid_work(struct task_struct *t) { }
 static inline int task_mm_cid(struct task_struct *t)
 {
 	/*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d6b91e8a66d6d..e6d6e468e64b4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1420,6 +1420,13 @@ static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumas
 	WRITE_ONCE(mm->nr_cpus_allowed, cpumask_weight(mm_allowed));
 	raw_spin_unlock(&mm->cpus_allowed_lock);
 }
+
+static inline bool mm_cid_needs_scan(struct mm_struct *mm)
+{
+	if (!mm)
+		return false;
+	return time_after(jiffies, READ_ONCE(mm->mm_cid_next_scan));
+}
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
 static inline int mm_alloc_cid(struct mm_struct *mm, struct task_struct *p) { return 0; }
@@ -1430,6 +1437,10 @@ static inline unsigned int mm_cid_size(void)
 	return 0;
 }
 static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask) { }
+static inline bool mm_cid_needs_scan(struct mm_struct *mm)
+{
+	return false;
+}
 #endif /* CONFIG_SCHED_MM_CID */
 
 struct mmu_gather;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index aa9c5be7a6325..a75f61cea2271 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1428,7 +1428,7 @@ struct task_struct {
 	int				last_mm_cid;	/* Most recent cid in mm */
 	int				migrate_from_cpu;
 	int				mm_cid_active;	/* Whether cid bitmap is active */
-	struct callback_head		cid_work;
+	unsigned long			last_cid_reset;	/* Time of last reset in jiffies */
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
diff --git a/kernel/rseq.c b/kernel/rseq.c
index b7a1ec327e811..100f81e330dc6 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -441,6 +441,8 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	}
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
+	/* The mm_cid compaction returns prematurely if scan is not needed. */
+	task_mm_cid_work(t);
 	return;
 
 error:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81c6df746df17..27b856a1cb0a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10589,22 +10589,13 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
 	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
 }
 
-static void task_mm_cid_work(struct callback_head *work)
+void task_mm_cid_work(struct task_struct *t)
 {
 	unsigned long now = jiffies, old_scan, next_scan;
-	struct task_struct *t = current;
 	struct cpumask *cidmask;
-	struct mm_struct *mm;
 	int weight, cpu;
+	struct mm_struct *mm = t->mm;
 
-	WARN_ON_ONCE(t != container_of(work, struct task_struct, cid_work));
-
-	work->next = work;	/* Prevent double-add */
-	if (t->flags & PF_EXITING)
-		return;
-	mm = t->mm;
-	if (!mm)
-		return;
 	old_scan = READ_ONCE(mm->mm_cid_next_scan);
 	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	if (!old_scan) {
@@ -10643,23 +10634,47 @@ void init_sched_mm_cid(struct task_struct *t)
 		if (mm_users == 1)
 			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	}
-	t->cid_work.next = &t->cid_work;	/* Protect against double add */
-	init_task_work(&t->cid_work, task_mm_cid_work);
 }
 
 void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
 {
-	struct callback_head *work = &curr->cid_work;
-	unsigned long now = jiffies;
+	u64 rtime = curr->se.sum_exec_runtime - curr->se.prev_sum_exec_runtime;
 
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
+	 * B occurs once after the compaction work completes, neither A nor B
+	 * run as long as the compaction work is pending, the task is exiting
+	 * or is not a userspace task.
+	 */
 	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
-	    work->next != work)
+	    test_tsk_thread_flag(curr, TIF_NOTIFY_RESUME))
 		return;
-	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
+	if (rtime < RSEQ_UNPREEMPTED_THRESHOLD)
 		return;
-
-	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME);
+	if (mm_cid_needs_scan(curr->mm)) {
+		/* Trigger mm_cid recompaction */
+		rseq_set_notify_resume(curr);
+	} else if (time_after(jiffies, curr->last_cid_reset +
+			      msecs_to_jiffies(MM_CID_SCAN_DELAY))) {
+		/* Update mm_cid field */
+		int old_cid = curr->mm_cid;
+
+		if (!curr->mm_cid_active)
+			return;
+		mm_cid_snapshot_time(rq, curr->mm);
+		mm_cid_put_lazy(curr);
+		curr->last_mm_cid = curr->mm_cid = mm_cid_get(rq, curr, curr->mm);
+		if (old_cid != curr->mm_cid)
+			rseq_preempt(curr);
+	}
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bb5998295e..90a5b58188232 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3606,6 +3606,7 @@ extern const char *preempt_modes[];
 
 #define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
 #define MM_CID_SCAN_DELAY	100			/* 100ms */
+#define RSEQ_UNPREEMPTED_THRESHOLD	SCHED_MM_CID_PERIOD_NS
 
 extern raw_spinlock_t cid_lock;
 extern int use_cid_lock;
@@ -3809,6 +3810,7 @@ static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
 	int cid;
 
 	lockdep_assert_rq_held(rq);
+	t->last_cid_reset = jiffies;
 	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
-- 
2.50.1



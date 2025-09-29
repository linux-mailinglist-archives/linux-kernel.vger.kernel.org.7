Return-Path: <linux-kernel+bounces-836242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3A6BA9156
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A2B3BC5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE73301719;
	Mon, 29 Sep 2025 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzvAlmj0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDE3016F4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146172; cv=none; b=MN/wUDpictXM/WhtUjLmKiP2rKI35sdjd/jY2q9JlF67i51ATDYXii50z8J7y+idGvfvjJCaWRagFwnuWQ8dinyNsNFMgI/7mvHdnnxjrnmZce9IdcMZZSGgUQhanN7GDiO+LqQ7gC69r99a6O4YiHrOpp5/Asu0DNj3+/tc7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146172; c=relaxed/simple;
	bh=NVkJuyFvVSph3d5MHnsgHxK+tQEIOzZq5ZOGLTj93MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSOCYr8NdsnAjT1Re15M06cSjj3qqr+y3NRLFRskaAYd4hxn3kpPEYryjEtW0Dk2z9krh1pq5UPN75Xc25kU+6r4w8qasHOCJRh/wZx9YyBODzzKu2OyF+G4pPy17jYho3IVI6cWhQdmNZKw8bSC63YIYx0DEysf9EvfLhvFpUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzvAlmj0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759146169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+m5epJ6K/whUJPxjsxB575rCI33qv3BELyaIusqhK1A=;
	b=CzvAlmj0bBc2vROw6zSrmqsR8SJFFiUFIrnhI6emA2/i06ywD/UCgeWkcTli8s/xVoXdoF
	MfdW42CTUB2jsG2J6mFt8ji5lYviv/hERZLnhR2N0sEM3DKiwHiIP6zyhQvMtViyCutGM/
	SEGdX+ZtNSvA+RNBfqFxNTyhJVwlEX4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-4TJ6sOxrNB-cmljfbUtAYg-1; Mon,
 29 Sep 2025 07:42:44 -0400
X-MC-Unique: 4TJ6sOxrNB-cmljfbUtAYg-1
X-Mimecast-MFC-AGG-ID: 4TJ6sOxrNB-cmljfbUtAYg_1759146163
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21BA5180047F;
	Mon, 29 Sep 2025 11:42:43 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5C1B19560B4;
	Mon, 29 Sep 2025 11:42:38 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v3 2/4] rseq: Schedule the mm_cid_compaction from rseq_sched_switch_event()
Date: Mon, 29 Sep 2025 13:42:23 +0200
Message-ID: <20250929114225.36172-3-gmonaco@redhat.com>
In-Reply-To: <20250929114225.36172-1-gmonaco@redhat.com>
References: <20250929114225.36172-1-gmonaco@redhat.com>
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

Schedule the mm_cid_compaction from the rseq_sched_switch_event() call
only if the scan is required, that is when the pseudo-period of 100ms
elapsed.

Keep a tick handler used for long running tasks that are never preempted
(i.e. that never call rseq_sched_switch_event), which triggers a
compaction and mm_cid update only in that case.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/mm_types.h | 11 +++++++++
 include/linux/rseq.h     |  3 +++
 include/linux/sched.h    |  3 +++
 kernel/sched/core.c      | 48 ++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h     |  2 ++
 5 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 08bc2442db93..5dab88707014 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1424,6 +1424,13 @@ static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumas
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
@@ -1434,6 +1441,10 @@ static inline unsigned int mm_cid_size(void)
 	return 0;
 }
 static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask) { }
+static inline bool mm_cid_needs_scan(struct mm_struct *mm)
+{
+	return false;
+}
 #endif /* CONFIG_SCHED_MM_CID */
 
 struct mmu_gather;
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index b8ea95011ec3..12eecde46ff5 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -4,6 +4,7 @@
 
 #ifdef CONFIG_RSEQ
 #include <linux/sched.h>
+#include <linux/mm_types.h>
 
 void __rseq_handle_slowpath(struct pt_regs *regs);
 
@@ -68,6 +69,8 @@ static __always_inline void rseq_sched_switch_event(struct task_struct *t)
 			rseq_raise_notify_resume(t);
 		}
 	}
+	if (mm_cid_needs_scan(t->mm))
+		task_add_mm_cid(t);
 }
 
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 857ed17d443b..80c1afb2087d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1407,6 +1407,7 @@ struct task_struct {
 	int				last_mm_cid;	/* Most recent cid in mm */
 	int				migrate_from_cpu;
 	int				mm_cid_active;	/* Whether cid bitmap is active */
+	unsigned long			last_cid_reset;	/* Time of last reset in jiffies */
 	struct callback_head		cid_work;
 #endif
 
@@ -2300,6 +2301,7 @@ void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
 void sched_mm_cid_fork(struct task_struct *t);
 void sched_mm_cid_exit_signals(struct task_struct *t);
+void task_add_mm_cid(struct task_struct *t);
 static inline int task_mm_cid(struct task_struct *t)
 {
 	return t->mm_cid;
@@ -2309,6 +2311,7 @@ static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_fork(struct task_struct *t) { }
 static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
+static inline void task_add_mm_cid(struct task_struct *t) { }
 static inline int task_mm_cid(struct task_struct *t)
 {
 	/*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e742a655c9a8..30652bb4a223 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10840,19 +10840,53 @@ void init_sched_mm_cid(struct task_struct *t)
 	init_task_work(&t->cid_work, task_mm_cid_work);
 }
 
+void task_add_mm_cid(struct task_struct *t)
+{
+	struct callback_head *work = &t->cid_work;
+
+	if (work->next != work)
+		return;
+	/* No page allocation under rq lock */
+	task_work_add(t, work, TWA_RESUME);
+}
+
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
+		task_add_mm_cid(curr);
+	} else if (time_after(jiffies, curr->last_cid_reset +
+			      msecs_to_jiffies(MM_CID_SCAN_DELAY))) {
+		/* Update mm_cid field */
+		if (!curr->mm_cid_active)
+			return;
+		mm_cid_snapshot_time(rq, curr->mm);
+		mm_cid_put_lazy(curr);
+		curr->last_mm_cid = curr->mm_cid = mm_cid_get(rq, curr, curr->mm);
+		rseq_sched_set_task_mm_cid(curr, curr->mm_cid);
+		rseq_sched_switch_event(curr);
+	}
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8f14d231e7a7..8c0fb3b0fb35 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3512,6 +3512,7 @@ extern const char *preempt_modes[];
 
 #define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
 #define MM_CID_SCAN_DELAY	100			/* 100ms */
+#define RSEQ_UNPREEMPTED_THRESHOLD	SCHED_MM_CID_PERIOD_NS
 
 extern raw_spinlock_t cid_lock;
 extern int use_cid_lock;
@@ -3715,6 +3716,7 @@ static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
 	int cid;
 
 	lockdep_assert_rq_held(rq);
+	t->last_cid_reset = jiffies;
 	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
-- 
2.51.0



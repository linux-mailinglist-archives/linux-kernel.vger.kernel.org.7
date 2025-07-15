Return-Path: <linux-kernel+bounces-731333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368E9B052AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4453A3DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F69274B3D;
	Tue, 15 Jul 2025 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AWwYbZZP"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B802749C0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563866; cv=none; b=fnq1xHT1GrNuzA1v93fk9gmzDhIA8fasOHVtiT+k2uxQtX4XYnUflrsLtQAwQLbuZLN27VdIGFFtN2IGsab9MloC4DN7U1OVHQzUE5ICBv8kFC2Px+oWRcPu8eQ7gpr6eh3QfgPc55GALYYfx7cOpwok5eLWplPQrGeABofY8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563866; c=relaxed/simple;
	bh=EO27zZ3NbgfYQWfFdQ3XqCbTw5QQ9uRlrR2JkES++X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PnkJDmnJBts/nCKif8IBhMzYawIVYGElSrK9gJAottizeUVLzyniJI+SoEf+duUYW7fk9Ew5H60CMkOzynamX/qdF3UOJuj15wbGeweIMown36bMZp8zU+W7ctou+nvP6BJ271Kl9YpvtYJMLJ2J3ByWIWMwStjODGKUeRZsZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AWwYbZZP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313f68bc519so3954591a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752563862; x=1753168662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWH+y5+o9+l4hCSFs30fOj6t5scjaLBcpXmImmkgyN4=;
        b=AWwYbZZPUN1z5qecixfP5FiSMtUNe7dSZKe4Hbzhf9WtM7fBUeLRWmBPis9oBMONCg
         k64lx4a1kTvJvg80/ny8HcZLsQKoiemC9A3GU9FWZShbKnnB0o2jMov2Xmp7TPeUY5C5
         x9on2qs+BA4StUjQV0PSuz1gobo5B//hB7/1GBcgsgeVMOJ5/zVFZCEH8sHEXJwcS9+T
         2PP6XMBW87x/KD3oyujJYGkORRq9s1LSjxn2EBzrPWQ55ANNxKTJ2kksweJKoHcumlKZ
         lig059bssdletWmKeMDv64SzlV51rChJXUrmOzvDdJDwzd7AwlGL+2Ve9PatXhAfxsrL
         voMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563862; x=1753168662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWH+y5+o9+l4hCSFs30fOj6t5scjaLBcpXmImmkgyN4=;
        b=Mf40ZERs6xqLYKA93IKFmxq6Bn8bx4qCRStvobRYKbBbahYjbZMRYeaJxLmGwPNTUh
         2rAc25xd9szAtQhpy8GpZWqOADLjJLHlQUGZXDFa4fag6mtf0o8fTswGIwiKB4N0SOff
         aUPLvGG11ZNLoPaR0T2TKNGlZE+kYd1tGfqm0DRhOTO1KnIvlVaGGTD0pN94evc2MmPU
         qS8RQyy6vWT776Fo9Hv3rsgg3SHDjnntCuzPlMWw3bpvE9S6T1aRD1a6TWK7OgdhrvwT
         M1FHrN478Y+cs7NNrHCU5bgnHjSi/FFOPjxmJM/SjNweXoz0q+zCOr6AgWvml2ehkOTA
         DztA==
X-Gm-Message-State: AOJu0YwUi3HedAQ/OyBPs/BcSZvKXmpyVB41AWH+P+65R3om6X7x8GSG
	FXwMOQtKwvfv/19s72n8QL9J0gnRRtFp80EdsHV4VCBvecPHhhKsCFDZ4ihoRMnwmw==
X-Gm-Gg: ASbGncu3lpP9ZrpRqJEqxA0iQXwHZYoRn4DlAQRcuLp6HdrULQIIc944FyV6fSHMH2c
	NfeSZYBKFLUWE84Z0pcQDRFInTMaZb+GeqKnJK5dJjzKWDXPdc+q0HSPDcVbqrlKgh2AefKPXq7
	rsqGlU4wOb0I1LHdnyDglRQgnbT8PkDF3LIhN95Vg7nqwOKVcqV05Na4CMyp7yQAIOmqn5G0DcG
	oyw1Hbb2dCMBtYB+tm7q2QfVDRHmUA1fF12dQAt2j/NpCTElu57mg+FCLg9T+7kpLAuDTZfdmp1
	xlRS7GiJ4bXywxjfcmklZpM4O1VHgXwsA9EXd8H5tFlp9eNR7gB0HGU2u8eo39V9M+ZBjm2eBiy
	jivlbP0N4gcoKNjxOEoDn8JFTUnvyOOQLVdpIVUwBaB2RFfDD8KEmKEdqOzpsO5kAqjYz2oWF6x
	LAfMI=
X-Google-Smtp-Source: AGHT+IFL/H0XKiagj4z0DlhafqTYOLisx8byr8iid7vHV7XAcH7riVF00cMDd9AlRHKGFKqAzJjVIg==
X-Received: by 2002:a17:90b:46:b0:311:a561:86f3 with SMTP id 98e67ed59e1d1-31c4f48baa6mr25595808a91.6.1752563861982;
        Tue, 15 Jul 2025 00:17:41 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017c9dasm15013418a91.25.2025.07.15.00.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:17:41 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Date: Tue, 15 Jul 2025 15:16:56 +0800
Message-Id: <20250715071658.267-4-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715071658.267-1-ziqianlu@bytedance.com>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

In current throttle model, when a cfs_rq is throttled, its entity will
be dequeued from cpu's rq, making tasks attached to it not able to run,
thus achiveing the throttle target.

This has a drawback though: assume a task is a reader of percpu_rwsem
and is waiting. When it gets woken, it can not run till its task group's
next period comes, which can be a relatively long time. Waiting writer
will have to wait longer due to this and it also makes further reader
build up and eventually trigger task hung.

To improve this situation, change the throttle model to task based, i.e.
when a cfs_rq is throttled, record its throttled status but do not remove
it from cpu's rq. Instead, for tasks that belong to this cfs_rq, when
they get picked, add a task work to them so that when they return
to user, they can be dequeued there. In this way, tasks throttled will
not hold any kernel resources. And on unthrottle, enqueue back those
tasks so they can continue to run.

Throttled cfs_rq's PELT clock is handled differently now: previously the
cfs_rq's PELT clock is stopped once it entered throttled state but since
now tasks(in kernel mode) can continue to run, change the behaviour to
stop PELT clock only when the throttled cfs_rq has no tasks left.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # tag on pick
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c  | 336 ++++++++++++++++++++++---------------------
 kernel/sched/pelt.h  |   4 +-
 kernel/sched/sched.h |   3 +-
 3 files changed, 176 insertions(+), 167 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54c2a4df6a5d1..0eeea7f2e693d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5285,18 +5285,23 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if (cfs_rq->nr_queued == 1) {
 		check_enqueue_throttle(cfs_rq);
-		if (!throttled_hierarchy(cfs_rq)) {
-			list_add_leaf_cfs_rq(cfs_rq);
-		} else {
+		list_add_leaf_cfs_rq(cfs_rq);
 #ifdef CONFIG_CFS_BANDWIDTH
+		if (throttled_hierarchy(cfs_rq)) {
 			struct rq *rq = rq_of(cfs_rq);
 
 			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
 				cfs_rq->throttled_clock = rq_clock(rq);
 			if (!cfs_rq->throttled_clock_self)
 				cfs_rq->throttled_clock_self = rq_clock(rq);
-#endif
+
+			if (cfs_rq->pelt_clock_throttled) {
+				cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
+					cfs_rq->throttled_clock_pelt;
+				cfs_rq->pelt_clock_throttled = 0;
+			}
 		}
+#endif
 	}
 }
 
@@ -5335,8 +5340,6 @@ static void set_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable--;
-		if (cfs_rq_throttled(cfs_rq))
-			break;
 	}
 }
 
@@ -5357,8 +5360,6 @@ static void clear_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable++;
-		if (cfs_rq_throttled(cfs_rq))
-			break;
 	}
 }
 
@@ -5444,8 +5445,18 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (flags & DEQUEUE_DELAYED)
 		finish_delayed_dequeue_entity(se);
 
-	if (cfs_rq->nr_queued == 0)
+	if (cfs_rq->nr_queued == 0) {
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
+#ifdef CONFIG_CFS_BANDWIDTH
+		if (throttled_hierarchy(cfs_rq)) {
+			struct rq *rq = rq_of(cfs_rq);
+
+			list_del_leaf_cfs_rq(cfs_rq);
+			cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
+			cfs_rq->pelt_clock_throttled = 1;
+		}
+#endif
+	}
 
 	return true;
 }
@@ -5784,6 +5795,10 @@ static void throttle_cfs_rq_work(struct callback_head *work)
 		WARN_ON_ONCE(p->throttled || !list_empty(&p->throttle_node));
 		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
 		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
+		/*
+		 * Must not set throttled before dequeue or dequeue will
+		 * mistakenly regard this task as an already throttled one.
+		 */
 		p->throttled = true;
 		resched_curr(rq);
 	}
@@ -5797,32 +5812,119 @@ void init_cfs_throttle_work(struct task_struct *p)
 	INIT_LIST_HEAD(&p->throttle_node);
 }
 
+/*
+ * Task is throttled and someone wants to dequeue it again:
+ * it could be sched/core when core needs to do things like
+ * task affinity change, task group change, task sched class
+ * change etc. and in these cases, DEQUEUE_SLEEP is not set;
+ * or the task is blocked after throttled due to freezer etc.
+ * and in these cases, DEQUEUE_SLEEP is set.
+ */
+static void detach_task_cfs_rq(struct task_struct *p);
+static void dequeue_throttled_task(struct task_struct *p, int flags)
+{
+	WARN_ON_ONCE(p->se.on_rq);
+	list_del_init(&p->throttle_node);
+
+	/* task blocked after throttled */
+	if (flags & DEQUEUE_SLEEP) {
+		p->throttled = false;
+		return;
+	}
+
+	/*
+	 * task is migrating off its old cfs_rq, detach
+	 * the task's load from its old cfs_rq.
+	 */
+	if (task_on_rq_migrating(p))
+		detach_task_cfs_rq(p);
+}
+
+static bool enqueue_throttled_task(struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(&p->se);
+
+	/*
+	 * If the throttled task is enqueued to a throttled cfs_rq,
+	 * take the fast path by directly put the task on target
+	 * cfs_rq's limbo list, except when p is current because
+	 * the following race can cause p's group_node left in rq's
+	 * cfs_tasks list when it's throttled:
+	 *
+	 *        cpuX                       cpuY
+	 *   taskA ret2user
+	 *  throttle_cfs_rq_work()    sched_move_task(taskA)
+	 *  task_rq_lock acquired
+	 *  dequeue_task_fair(taskA)
+	 *  task_rq_lock released
+	 *                            task_rq_lock acquired
+	 *                            task_current_donor(taskA) == true
+	 *                            task_on_rq_queued(taskA) == true
+	 *                            dequeue_task(taskA)
+	 *                            put_prev_task(taskA)
+	 *                            sched_change_group()
+	 *                            enqueue_task(taskA) -> taskA's new cfs_rq
+	 *                                                   is throttled, go
+	 *                                                   fast path and skip
+	 *                                                   actual enqueue
+	 *                            set_next_task(taskA)
+	 *                          __set_next_task_fair(taskA)
+	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
+	 *  schedule()
+	 *
+	 * And in the above race case, the task's current cfs_rq is in the same
+	 * rq as its previous cfs_rq because sched_move_task() doesn't migrate
+	 * task so we can use its current cfs_rq to derive rq and test if the
+	 * task is current.
+	 */
+	if (throttled_hierarchy(cfs_rq) &&
+	    !task_current_donor(rq_of(cfs_rq), p)) {
+		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
+		return true;
+	}
+
+	/* we can't take the fast path, do an actual enqueue*/
+	p->throttled = false;
+	return false;
+}
+
+static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags);
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct task_struct *p, *tmp;
+
+	if (--cfs_rq->throttle_count)
+		return 0;
 
-	cfs_rq->throttle_count--;
-	if (!cfs_rq->throttle_count) {
+	if (cfs_rq->pelt_clock_throttled) {
 		cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
 					     cfs_rq->throttled_clock_pelt;
+		cfs_rq->pelt_clock_throttled = 0;
+	}
 
-		/* Add cfs_rq with load or one or more already running entities to the list */
-		if (!cfs_rq_is_decayed(cfs_rq))
-			list_add_leaf_cfs_rq(cfs_rq);
+	if (cfs_rq->throttled_clock_self) {
+		u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
 
-		if (cfs_rq->throttled_clock_self) {
-			u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
+		cfs_rq->throttled_clock_self = 0;
 
-			cfs_rq->throttled_clock_self = 0;
+		if (WARN_ON_ONCE((s64)delta < 0))
+			delta = 0;
 
-			if (WARN_ON_ONCE((s64)delta < 0))
-				delta = 0;
+		cfs_rq->throttled_clock_self_time += delta;
+	}
 
-			cfs_rq->throttled_clock_self_time += delta;
-		}
+	/* Re-enqueue the tasks that have been throttled at this level. */
+	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
+		list_del_init(&p->throttle_node);
+		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
 	}
 
+	/* Add cfs_rq with load or one or more already running entities to the list */
+	if (!cfs_rq_is_decayed(cfs_rq))
+		list_add_leaf_cfs_rq(cfs_rq);
+
 	return 0;
 }
 
@@ -5851,17 +5953,25 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	struct rq *rq = data;
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
 
+	if (cfs_rq->throttle_count++)
+		return 0;
+
+
 	/* group is entering throttled state, stop time */
-	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
+	WARN_ON_ONCE(cfs_rq->throttled_clock_self);
+	if (cfs_rq->nr_queued)
+		cfs_rq->throttled_clock_self = rq_clock(rq);
+	else {
+		/*
+		 * For cfs_rqs that still have entities enqueued, PELT clock
+		 * stop happens at dequeue time when all entities are dequeued.
+		 */
 		list_del_leaf_cfs_rq(cfs_rq);
-
-		WARN_ON_ONCE(cfs_rq->throttled_clock_self);
-		if (cfs_rq->nr_queued)
-			cfs_rq->throttled_clock_self = rq_clock(rq);
+		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
+		cfs_rq->pelt_clock_throttled = 1;
 	}
-	cfs_rq->throttle_count++;
 
+	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
 	return 0;
 }
 
@@ -5869,8 +5979,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
+	int dequeue = 1;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5893,68 +6002,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	if (!dequeue)
 		return false;  /* Throttle no longer required. */
 
-	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
-
 	/* freeze hierarchy runnable averages while throttled */
 	rcu_read_lock();
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();
 
-	queued_delta = cfs_rq->h_nr_queued;
-	runnable_delta = cfs_rq->h_nr_runnable;
-	idle_delta = cfs_rq->h_nr_idle;
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-		int flags;
-
-		/* throttled entity or throttle-on-deactivate */
-		if (!se->on_rq)
-			goto done;
-
-		/*
-		 * Abuse SPECIAL to avoid delayed dequeue in this instance.
-		 * This avoids teaching dequeue_entities() about throttled
-		 * entities and keeps things relatively simple.
-		 */
-		flags = DEQUEUE_SLEEP | DEQUEUE_SPECIAL;
-		if (se->sched_delayed)
-			flags |= DEQUEUE_DELAYED;
-		dequeue_entity(qcfs_rq, se, flags);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta = cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued -= queued_delta;
-		qcfs_rq->h_nr_runnable -= runnable_delta;
-		qcfs_rq->h_nr_idle -= idle_delta;
-
-		if (qcfs_rq->load.weight) {
-			/* Avoid re-evaluating load for this entity: */
-			se = parent_entity(se);
-			break;
-		}
-	}
-
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-		/* throttled entity or throttle-on-deactivate */
-		if (!se->on_rq)
-			goto done;
-
-		update_load_avg(qcfs_rq, se, 0);
-		se_update_runnable(se);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta = cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued -= queued_delta;
-		qcfs_rq->h_nr_runnable -= runnable_delta;
-		qcfs_rq->h_nr_idle -= idle_delta;
-	}
-
-	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, queued_delta);
-done:
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
@@ -5970,9 +6022,20 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_delta;
-	long rq_h_nr_queued = rq->cfs.h_nr_queued;
+	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
+
+	/*
+	 * It's possible we are called with !runtime_remaining due to things
+	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
+	 * unthrottled us with a positive runtime_remaining but other still
+	 * running entities consumed those runtime before we reached here.
+	 *
+	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
+	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
+	 * throttle, which is not supposed to happen on unthrottle path.
+	 */
+	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
+		return;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -6002,62 +6065,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			if (list_add_leaf_cfs_rq(cfs_rq_of(se)))
 				break;
 		}
-		goto unthrottle_throttle;
 	}
 
-	queued_delta = cfs_rq->h_nr_queued;
-	runnable_delta = cfs_rq->h_nr_runnable;
-	idle_delta = cfs_rq->h_nr_idle;
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-
-		/* Handle any unfinished DELAY_DEQUEUE business first. */
-		if (se->sched_delayed) {
-			int flags = DEQUEUE_SLEEP | DEQUEUE_DELAYED;
-
-			dequeue_entity(qcfs_rq, se, flags);
-		} else if (se->on_rq)
-			break;
-		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta = cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued += queued_delta;
-		qcfs_rq->h_nr_runnable += runnable_delta;
-		qcfs_rq->h_nr_idle += idle_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
-	}
-
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-
-		update_load_avg(qcfs_rq, se, UPDATE_TG);
-		se_update_runnable(se);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta = cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued += queued_delta;
-		qcfs_rq->h_nr_runnable += runnable_delta;
-		qcfs_rq->h_nr_idle += idle_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
-	}
-
-	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
-		dl_server_start(&rq->fair_server);
-
-	/* At this point se is NULL and we are at root level*/
-	add_nr_running(rq, queued_delta);
-
-unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
@@ -6711,6 +6720,8 @@ static inline void sync_throttle(struct task_group *tg, int cpu) {}
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 static void task_throttle_setup_work(struct task_struct *p) {}
 static bool task_is_throttled(struct task_struct *p) { return false; }
+static void dequeue_throttled_task(struct task_struct *p, int flags) {}
+static bool enqueue_throttled_task(struct task_struct *p) { return false; }
 
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {
@@ -6903,6 +6914,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	u64 slice = 0;
 
+	if (unlikely(task_is_throttled(p) && enqueue_throttled_task(p)))
+		return;
+
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
@@ -6955,10 +6969,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
-
 		flags = ENQUEUE_WAKEUP;
 	}
 
@@ -6980,10 +6990,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
 	}
 
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
@@ -7013,7 +7019,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		check_update_overutilized_status(rq);
 
-enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
@@ -7068,10 +7073,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			return 0;
-
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			slice = cfs_rq_min_slice(cfs_rq);
@@ -7108,10 +7109,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			return 0;
 	}
 
 	sub_nr_running(rq, h_nr_queued);
@@ -7145,6 +7142,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (unlikely(task_is_throttled(p))) {
+		dequeue_throttled_task(p, flags);
+		return true;
+	}
+
 	if (!p->se.sched_delayed)
 		util_est_dequeue(&rq->cfs, p);
 
@@ -8813,19 +8815,22 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
+	struct task_struct *p;
+	bool throttled;
 
 again:
 	cfs_rq = &rq->cfs;
 	if (!cfs_rq->nr_queued)
 		return NULL;
 
+	throttled = false;
+
 	do {
 		/* Might not have done put_prev_entity() */
 		if (cfs_rq->curr && cfs_rq->curr->on_rq)
 			update_curr(cfs_rq);
 
-		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
-			goto again;
+		throttled |= check_cfs_rq_runtime(cfs_rq);
 
 		se = pick_next_entity(rq, cfs_rq);
 		if (!se)
@@ -8833,7 +8838,10 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
-	return task_of(se);
+	p = task_of(se);
+	if (unlikely(throttled))
+		task_throttle_setup_work(p);
+	return p;
 }
 
 static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 62c3fa543c0f2..f921302dc40fb 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -162,7 +162,7 @@ static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
 	u64 throttled;
 
-	if (unlikely(cfs_rq->throttle_count))
+	if (unlikely(cfs_rq->pelt_clock_throttled))
 		throttled = U64_MAX;
 	else
 		throttled = cfs_rq->throttled_clock_pelt_time;
@@ -173,7 +173,7 @@ static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 /* rq->task_clock normalized against any time this cfs_rq has spent throttled */
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
-	if (unlikely(cfs_rq->throttle_count))
+	if (unlikely(cfs_rq->pelt_clock_throttled))
 		return cfs_rq->throttled_clock_pelt - cfs_rq->throttled_clock_pelt_time;
 
 	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b0c9559992d8a..fc697d4bf6685 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -737,7 +737,8 @@ struct cfs_rq {
 	u64			throttled_clock_pelt_time;
 	u64			throttled_clock_self;
 	u64			throttled_clock_self_time;
-	int			throttled;
+	int			throttled:1;
+	int			pelt_clock_throttled:1;
 	int			throttle_count;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
-- 
2.39.5



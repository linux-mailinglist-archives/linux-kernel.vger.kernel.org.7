Return-Path: <linux-kernel+bounces-791337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F78B3B598
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B532F3B4494
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A70928C849;
	Fri, 29 Aug 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DSWso1/M"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA9298CC4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455138; cv=none; b=syizVQB1Nuo/Shy+umgFaJSGyktwl/3lEWWu66FCBpcoNNvDbcObawR/SX7ZmGnk+uw+OZJFYYw/Nocv47A1Jz1Gdr6mWLVsA24AGPkJQlS7sJU4kHfBtw0Li1VhAH5LOm58CAWIUGj0Id0TD8uZHYAyqHyljVZEq3Q7q0rS7GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455138; c=relaxed/simple;
	bh=f16LplJfFogQzGMf1+03mGY7khY6CGhpYoYuhKsfGf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pPufH02LHXg8j5pJ06VImHBSH44ecyQ2dCfkonw2Hpiy04/NUym6MCfuhgoTKat5zMxTx4NrMqbmc+HFjSFaZe7pCKabROA5V32iPwEUmRBYPNHUb03VOUAkn4SrUzWLbW+fYifOxL6yNqOuD3xvPelUGJPl7SimMVDuBt72BzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DSWso1/M; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772301f8ae2so232499b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756455135; x=1757059935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POqlX2zkLtDdXsVyxbBcR47lmyvdRFHDML8CpUGljyY=;
        b=DSWso1/Moj3WOlWXo55yvaISbzyWtIu81sXdJzLc742jKEm9HjwFjsWi/+n44iXgHd
         94Gz/p4oKfkBgTcrjItC+qpDde4Gk9qWLyDBYLDVr9iYl8U9Oxk8qLtub7kbuTtWtCtP
         G49vs0LEBRPXd+6zrLAfZaohlCNXXutVv0pe1u2nUkhJCGNZhDeEoottLPJb7MQ21352
         bi7kWeVl2/WfKHlx/CftEOZ5OX5hDP2yIC0MiAifYLB3/6JqTXpGthV27Xe/sSZK8r6x
         EcTbITq4zuRDzrgWWj2MtOQS2K/kpyMUZshW5d85DRRggqIadfLeyOnkMzF+ZEudkuCa
         spFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756455135; x=1757059935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POqlX2zkLtDdXsVyxbBcR47lmyvdRFHDML8CpUGljyY=;
        b=CkKzl9+cQKsvPL8wBcuArTkHSruBCtj88ofbzcKjTLPQMTt2qkikAI+2wx3yBFDFsk
         SWJyCI9VPScLAM5hZl7R7DQ1E95K0Hb0Eu+8UEeAGQKKLQ1qATmVc/eRX6AoYoGoAvHI
         7FrRqTihWIem0ajNI63J7jef7+gflaTxGjRoCYd7TKUzZYsxjxd0dmGha9dILQ9CG/Qt
         ZbuMzA9KBxbtsvbkDDRAR2cxWpsQBMsYHqsJ0zmpYX9ObFz+Q5UicknRV2q4gfukr7UO
         8k7Hb8OxNu335pbexdTb+XlUj8+qQueC4jxlI7paR00rqX22KdQLOWUuxgq/asXtcjLg
         usUw==
X-Gm-Message-State: AOJu0YznqxCOIC68kFqfk4q544c/N1NbOZ/c/ft4Meypb2xpBwc8AFGN
	BCGrIiLqPawEfgrZktws/smS+/wp8cNGsVYkQcBa18RSyQhtWVCjRXCQxHPqMyw+0Q==
X-Gm-Gg: ASbGnct0irEc/Qt7yPD0LqrdmXcUxnQqtlBXo8mZ+dmixUm0PFmQnDffXS1vEj/eQi+
	4BXbY/QHn3R+DcSTL7kbJBYRtWcI+nwcYyWPSunMFhBC9w16lvkxq8sNBG85wsbShuSMqFFCt+h
	iBBp1ZALW3IotEOF1duKESiDt9rtc8OW4trHfE/6NPsdqfMhXPe02XYoPnhc2FRcQew5Y1To9K9
	xrBcbhIrSIOtjPqGajioW9gng4WM7z3uCErts6joI5npX1wp6hn3QziwS25MCEp0dpmfgFXGnef
	W/y81roIImivM1jpED/8OO+8t4G/peFUTkSBAjUUUq32B7nL4eQFMXULqC7mXRAIMtCzsREtSvO
	Is3Y95ge0lSfZml2UhuLNrpc/uvac5/a1QdCmyEPfyI+JSFLjOgbDaCc/zTMlqGzgJh9r8AjOzQ
	KR92k=
X-Google-Smtp-Source: AGHT+IG71vCARpB4He7ujXEKdgBLZPZ0VugH0kUlAWuIR5GneGku24VDkW6G83VpGg8Fjrt0U4X8pQ==
X-Received: by 2002:a05:6a00:190e:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-7702fa10026mr34554695b3a.1.1756455135376;
        Fri, 29 Aug 2025 01:12:15 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2da9c6sm1601419b3a.42.2025.08.29.01.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:12:14 -0700 (PDT)
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
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Date: Fri, 29 Aug 2025 16:11:18 +0800
Message-Id: <20250829081120.806-4-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829081120.806-1-ziqianlu@bytedance.com>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
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
stop PELT clock when the throttled cfs_rq has no tasks left.

Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # tag on pick
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c  | 341 ++++++++++++++++++++++---------------------
 kernel/sched/pelt.h  |   4 +-
 kernel/sched/sched.h |   3 +-
 3 files changed, 181 insertions(+), 167 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dab4ed86d0c82..25b1014d4ef86 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5291,18 +5291,23 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
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
 
@@ -5341,8 +5346,6 @@ static void set_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable--;
-		if (cfs_rq_throttled(cfs_rq))
-			break;
 	}
 }
 
@@ -5363,8 +5366,6 @@ static void clear_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable++;
-		if (cfs_rq_throttled(cfs_rq))
-			break;
 	}
 }
 
@@ -5450,8 +5451,18 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -5790,6 +5801,10 @@ static void throttle_cfs_rq_work(struct callback_head *work)
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
@@ -5803,32 +5818,124 @@ void init_cfs_throttle_work(struct task_struct *p)
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
+	/* @p should have gone through dequeue_throttled_task() first */
+	WARN_ON_ONCE(!list_empty(&p->throttle_node));
+
+	/*
+	 * If the throttled task @p is enqueued to a throttled cfs_rq,
+	 * take the fast path by directly putting the task on the
+	 * target cfs_rq's limbo list.
+	 *
+	 * Do not do that when @p is current because the following race can
+	 * cause @p's group_node to be incorectly re-insterted in its rq's
+	 * cfs_tasks list, despite being throttled:
+	 *
+	 *     cpuX                       cpuY
+	 *   p ret2user
+	 *  throttle_cfs_rq_work()  sched_move_task(p)
+	 *  LOCK task_rq_lock
+	 *  dequeue_task_fair(p)
+	 *  UNLOCK task_rq_lock
+	 *                          LOCK task_rq_lock
+	 *                          task_current_donor(p) == true
+	 *                          task_on_rq_queued(p) == true
+	 *                          dequeue_task(p)
+	 *                          put_prev_task(p)
+	 *                          sched_change_group()
+	 *                          enqueue_task(p) -> p's new cfs_rq
+	 *                                             is throttled, go
+	 *                                             fast path and skip
+	 *                                             actual enqueue
+	 *                          set_next_task(p)
+	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
+	 *  schedule()
+	 *
+	 * In the above race case, @p current cfs_rq is in the same rq as
+	 * its previous cfs_rq because sched_move_task() only moves a task
+	 * to a different group from the same rq, so we can use its current
+	 * cfs_rq to derive rq and test if the task is current.
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
+		p->throttled = false;
+		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
 	}
 
+	/* Add cfs_rq with load or one or more already running entities to the list */
+	if (!cfs_rq_is_decayed(cfs_rq))
+		list_add_leaf_cfs_rq(cfs_rq);
+
 	return 0;
 }
 
@@ -5857,17 +5964,25 @@ static int tg_throttle_down(struct task_group *tg, void *data)
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
 
@@ -5875,8 +5990,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
+	int dequeue = 1;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5899,68 +6013,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -5976,9 +6033,20 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
 
@@ -6008,62 +6076,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			if (list_add_leaf_cfs_rq(cfs_rq_of(se)))
 				break;
 		}
-		goto unthrottle_throttle;
-	}
-
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
 	}
 
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
@@ -6717,6 +6731,8 @@ static inline void sync_throttle(struct task_group *tg, int cpu) {}
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 static void task_throttle_setup_work(struct task_struct *p) {}
 static bool task_is_throttled(struct task_struct *p) { return false; }
+static void dequeue_throttled_task(struct task_struct *p, int flags) {}
+static bool enqueue_throttled_task(struct task_struct *p) { return false; }
 
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {
@@ -6909,6 +6925,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	u64 slice = 0;
 
+	if (task_is_throttled(p) && enqueue_throttled_task(p))
+		return;
+
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
@@ -6961,10 +6980,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
-
 		flags = ENQUEUE_WAKEUP;
 	}
 
@@ -6986,10 +7001,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
 	}
 
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
@@ -7019,7 +7030,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		check_update_overutilized_status(rq);
 
-enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
@@ -7074,10 +7084,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			return 0;
-
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			slice = cfs_rq_min_slice(cfs_rq);
@@ -7114,10 +7120,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			return 0;
 	}
 
 	sub_nr_running(rq, h_nr_queued);
@@ -7151,6 +7153,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (task_is_throttled(p)) {
+		dequeue_throttled_task(p, flags);
+		return true;
+	}
+
 	if (!p->se.sched_delayed)
 		util_est_dequeue(&rq->cfs, p);
 
@@ -8819,19 +8826,22 @@ static struct task_struct *pick_task_fair(struct rq *rq)
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
@@ -8839,7 +8849,10 @@ static struct task_struct *pick_task_fair(struct rq *rq)
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
index 06cc7722226b4..528af3ef8fc1e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -738,7 +738,8 @@ struct cfs_rq {
 	u64			throttled_clock_pelt_time;
 	u64			throttled_clock_self;
 	u64			throttled_clock_self_time;
-	int			throttled;
+	bool			throttled:1;
+	bool			pelt_clock_throttled:1;
 	int			throttle_count;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
-- 
2.39.5



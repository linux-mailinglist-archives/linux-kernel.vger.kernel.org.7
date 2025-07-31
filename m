Return-Path: <linux-kernel+bounces-751963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6E7B16FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268D6585D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A3F2BE7DA;
	Thu, 31 Jul 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KExVs5X+"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F512BDC2C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959351; cv=none; b=rc4TZ4UwFVG/waM0AFCuWRJS9VgInx1oOEzYnR9i8cikorydfQU3mtgZvtUdnfmVV+6tmD9mCmf/9J9QPzPV9kS1ZbnPxVzZ/bagWD3qw5gRqGzaMRwpKm+koZA27IQsv8LPBI/Uioxes/j1BcyVbZCZVS+7ATOiHsI8C1jt1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959351; c=relaxed/simple;
	bh=m9XIExoPBwNvEZE0FWjJD8V4F+TozE8xFK5348SptMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7qoTHttA0msqAWnA9E4pQbA3YhW2OUVJAeML50xIqlU1k7GgzWfuAXgu0P2UZiPftSQM+E19RJJhnhrCEQlDj6WmW6hRVEbfQ8EnDvth8KCb5WzFKk34LCfMC2E1NS3iqMVepY+podw2hV2eR9w3/ZFJAu/f8dAtLCZq0d2iJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KExVs5X+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45892deb246so1522315e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959348; x=1754564148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DswH3BpDRcb2kXY69HQrOvfA/HLUjfYY/+tBjVrNqnw=;
        b=KExVs5X+OQ4fyoRgrkuFkc60I6l1q4AVo1u5fYN6UyRoJt5ThY01BpSDLQ9o5fNJHk
         QEeBElSyqgM83SCQLLuwTVJuRp/2aL2xISGUf6xi7o8xXPqkhc+BtpX1CBqtL3EfMpMR
         HOPCjo4vHvr+IuXHFhhM0vf29lScs2HaFbCyfQr5fo67UB5+2MT4IYmdUrUJwZ+qyshp
         vOtrVxwrBn+yjbufWCI7fW5Y3/YH4RPOm7taDb/8OO8YemmmqMSzuYKzWGiq1TaJRSiK
         8oro7bKKZu+C49g4Bnj4hkr8gFadSh+MQg9nKf17FdYwcACJg8bRqLOjpMm1c1+Mnxfi
         n+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959348; x=1754564148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DswH3BpDRcb2kXY69HQrOvfA/HLUjfYY/+tBjVrNqnw=;
        b=F65a/THk7iqQanC218ffmAGLbaBkWfl3h9YNtAr58QbEKzOyZ3qGflHxuuL6rmqEno
         HDW1RwB8jkWtBNqfDIlTPdrhEbJYdkCf7nKamLRnIyPimvoWRZ61ARUfNTq4zvp3UGsZ
         U5KCBG2H3UaMnanCbSGLpp2zzEYRLhbCFxY1pjKrNMzt3oIXRirAc+mhnGFK3KbjrnA7
         owqlwYQHJ7Flcnr7W4Np1nsgKku8nv8Voii/CdBxwztDls8ZUOvuysckJuxAiDRbIDNY
         pa7YjGSHbQkUBe+VSeCsjSLoNLN5GK6qgaYDo4VRD18FeqdrfsykJFZfJwG2tTGIIIWG
         f49w==
X-Gm-Message-State: AOJu0YyxKm8DDKwZq3fydPDf+fcluAM2z1KQl1yhy2XlhwIpCz+rUPha
	MPyn9XLv+NaUWF2M6Jf6/4Srzu/bvH9Lp+uW7gW05mhN5cRFgLBjPVo1
X-Gm-Gg: ASbGncuoWQzlmaai1PYnzxW5z0rzhTvtmJawyw7KHhWXf+kwJOXskkx7rztXONYyocM
	bNmyeMn+8+FQgq6vWDLyheVaBIoXV+0DFDQXSP/2MBwS72qL6iX471teAI9UDegvTDJ0TTwGVZV
	AZrDulMBiS7X0ZCw9BnlBvqlphmXVLzOpEonNwWfOGaAveXHhxY8sE+2Az8ZC1hAWoJgRrdYU8z
	d5CXlxSIqfi1fv/IRR14GR+FV6POBjDHlnFmuwdxIr7Q1tCC1HnCcxSELc1HvzW9hOlxBi3PfSi
	wY9rVNspDCQvsNWtQCSrZgWRXAVmFYvFzn+tTfw1WMTRDsluHmXBAFtzOCsBJ2wa8/ZpL8p5mAB
	gXtPb0BaB6Nvi5PP5Pgc=
X-Google-Smtp-Source: AGHT+IF4zckHj1HngwZI7aRLjnFn4G32ocR4jamL7mIqk+6zZVfquwfo2LNore8dtKeo4rQ3PmHGKA==
X-Received: by 2002:a05:600c:4713:b0:456:2b2a:5f41 with SMTP id 5b1f17b1804b1-45892bdd2a9mr57753805e9.32.1753959347721;
        Thu, 31 Jul 2025 03:55:47 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:47 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v2 04/25] sched/rt: Pass an rt_rq instead of an rq where needed
Date: Thu, 31 Jul 2025 12:55:22 +0200
Message-ID: <20250731105543.40832-5-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>
References: <20250731105543.40832-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luca abeni <luca.abeni@santannapisa.it>

Make rt.c code access the runqueue through the rt_rq data structure rather than
passing an rq pointer directly. This allows future patches to define rt_rq data
structures which do not refer only to the global runqueue, but also to local
cgroup runqueues (rt_rq is not always equal to &rq->rt).

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c | 83 +++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7936d433373..945e3d705cc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -370,9 +370,9 @@ static inline void rt_clear_overload(struct rq *rq)
 	cpumask_clear_cpu(rq->cpu, rq->rd->rto_mask);
 }
 
-static inline int has_pushable_tasks(struct rq *rq)
+static inline int has_pushable_tasks(struct rt_rq *rt_rq)
 {
-	return !plist_head_empty(&rq->rt.pushable_tasks);
+	return !plist_head_empty(&rt_rq->pushable_tasks);
 }
 
 static DEFINE_PER_CPU(struct balance_callback, rt_push_head);
@@ -383,7 +383,7 @@ static void pull_rt_task(struct rq *);
 
 static inline void rt_queue_push_tasks(struct rq *rq)
 {
-	if (!has_pushable_tasks(rq))
+	if (!has_pushable_tasks(&rq->rt))
 		return;
 
 	queue_balance_callback(rq, &per_cpu(rt_push_head, rq->cpu), push_rt_tasks);
@@ -394,37 +394,37 @@ static inline void rt_queue_pull_task(struct rq *rq)
 	queue_balance_callback(rq, &per_cpu(rt_pull_head, rq->cpu), pull_rt_task);
 }
 
-static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
+static void enqueue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 {
-	plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
+	plist_del(&p->pushable_tasks, &rt_rq->pushable_tasks);
 	plist_node_init(&p->pushable_tasks, p->prio);
-	plist_add(&p->pushable_tasks, &rq->rt.pushable_tasks);
+	plist_add(&p->pushable_tasks, &rt_rq->pushable_tasks);
 
 	/* Update the highest prio pushable task */
-	if (p->prio < rq->rt.highest_prio.next)
-		rq->rt.highest_prio.next = p->prio;
+	if (p->prio < rt_rq->highest_prio.next)
+		rt_rq->highest_prio.next = p->prio;
 
-	if (!rq->rt.overloaded) {
-		rt_set_overload(rq);
-		rq->rt.overloaded = 1;
+	if (!rt_rq->overloaded) {
+		rt_set_overload(rq_of_rt_rq(rt_rq));
+		rt_rq->overloaded = 1;
 	}
 }
 
-static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
+static void dequeue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 {
-	plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
+	plist_del(&p->pushable_tasks, &rt_rq->pushable_tasks);
 
 	/* Update the new highest prio pushable task */
-	if (has_pushable_tasks(rq)) {
-		p = plist_first_entry(&rq->rt.pushable_tasks,
+	if (has_pushable_tasks(rt_rq)) {
+		p = plist_first_entry(&rt_rq->pushable_tasks,
 				      struct task_struct, pushable_tasks);
-		rq->rt.highest_prio.next = p->prio;
+		rt_rq->highest_prio.next = p->prio;
 	} else {
-		rq->rt.highest_prio.next = MAX_RT_PRIO-1;
+		rt_rq->highest_prio.next = MAX_RT_PRIO-1;
 
-		if (rq->rt.overloaded) {
-			rt_clear_overload(rq);
-			rq->rt.overloaded = 0;
+		if (rt_rq->overloaded) {
+			rt_clear_overload(rq_of_rt_rq(rt_rq));
+			rt_rq->overloaded = 0;
 		}
 	}
 }
@@ -1431,6 +1431,7 @@ static void
 enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
 
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
@@ -1444,17 +1445,18 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 		return;
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
-		enqueue_pushable_task(rq, p);
+		enqueue_pushable_task(rt_rq, p);
 }
 
 static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
 
 	update_curr_rt(rq);
 	dequeue_rt_entity(rt_se, flags);
 
-	dequeue_pushable_task(rq, p);
+	dequeue_pushable_task(rt_rq, p);
 
 	return true;
 }
@@ -1639,14 +1641,14 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
-	struct rt_rq *rt_rq = &rq->rt;
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
 
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_rt_rq(&p->rt))
 		update_stats_wait_end_rt(rt_rq, rt_se);
 
 	/* The running task is never eligible for pushing */
-	dequeue_pushable_task(rq, p);
+	dequeue_pushable_task(rt_rq, p);
 
 	if (!first)
 		return;
@@ -1710,7 +1712,7 @@ static struct task_struct *pick_task_rt(struct rq *rq)
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
-	struct rt_rq *rt_rq = &rq->rt;
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
 
 	if (on_rt_rq(&p->rt))
 		update_stats_wait_start_rt(rt_rq, rt_se);
@@ -1726,7 +1728,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
 	 * if it is still active
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
-		enqueue_pushable_task(rq, p);
+		enqueue_pushable_task(rt_rq, p);
 }
 
 /* Only try algorithms three times */
@@ -1736,16 +1738,16 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
  * Return the highest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise
  */
-static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
+static struct task_struct *pick_highest_pushable_task(struct rt_rq *rt_rq, int cpu)
 {
-	struct plist_head *head = &rq->rt.pushable_tasks;
+	struct plist_head *head = &rt_rq->pushable_tasks;
 	struct task_struct *p;
 
-	if (!has_pushable_tasks(rq))
+	if (!has_pushable_tasks(rt_rq))
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (task_is_pushable(rq, p, cpu))
+		if (task_is_pushable(rq_of_rt_rq(rt_rq), p, cpu))
 			return p;
 	}
 
@@ -1845,14 +1847,15 @@ static int find_lowest_rq(struct task_struct *task)
 	return -1;
 }
 
-static struct task_struct *pick_next_pushable_task(struct rq *rq)
+static struct task_struct *pick_next_pushable_task(struct rt_rq *rt_rq)
 {
+	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct task_struct *p;
 
-	if (!has_pushable_tasks(rq))
+	if (!has_pushable_tasks(rt_rq))
 		return NULL;
 
-	p = plist_first_entry(&rq->rt.pushable_tasks,
+	p = plist_first_entry(&rt_rq->pushable_tasks,
 			      struct task_struct, pushable_tasks);
 
 	BUG_ON(rq->cpu != task_cpu(p));
@@ -1905,7 +1908,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 */
 			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task != pick_next_pushable_task(rq))) {
+				     task != pick_next_pushable_task(&rq->rt))) {
 
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
@@ -1939,7 +1942,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	if (!rq->rt.overloaded)
 		return 0;
 
-	next_task = pick_next_pushable_task(rq);
+	next_task = pick_next_pushable_task(&rq->rt);
 	if (!next_task)
 		return 0;
 
@@ -2014,7 +2017,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * run-queue and is also still the next task eligible for
 		 * pushing.
 		 */
-		task = pick_next_pushable_task(rq);
+		task = pick_next_pushable_task(&rq->rt);
 		if (task == next_task) {
 			/*
 			 * The task hasn't migrated, and is still the next
@@ -2202,7 +2205,7 @@ void rto_push_irq_work_func(struct irq_work *work)
 	 * We do not need to grab the lock to check for has_pushable_tasks.
 	 * When it gets updated, a check is made if a push is possible.
 	 */
-	if (has_pushable_tasks(rq)) {
+	if (has_pushable_tasks(&rq->rt)) {
 		raw_spin_rq_lock(rq);
 		while (push_rt_task(rq, true))
 			;
@@ -2231,6 +2234,7 @@ static void pull_rt_task(struct rq *this_rq)
 	int this_cpu = this_rq->cpu, cpu;
 	bool resched = false;
 	struct task_struct *p, *push_task;
+	struct rt_rq *src_rt_rq;
 	struct rq *src_rq;
 	int rt_overload_count = rt_overloaded(this_rq);
 
@@ -2260,6 +2264,7 @@ static void pull_rt_task(struct rq *this_rq)
 			continue;
 
 		src_rq = cpu_rq(cpu);
+		src_rt_rq = &src_rq->rt;
 
 		/*
 		 * Don't bother taking the src_rq->lock if the next highest
@@ -2268,7 +2273,7 @@ static void pull_rt_task(struct rq *this_rq)
 		 * logically higher, the src_rq will push this task away.
 		 * And if its going logically lower, we do not care
 		 */
-		if (src_rq->rt.highest_prio.next >=
+		if (src_rt_rq->highest_prio.next >=
 		    this_rq->rt.highest_prio.curr)
 			continue;
 
@@ -2284,7 +2289,7 @@ static void pull_rt_task(struct rq *this_rq)
 		 * We can pull only a task, which is pushable
 		 * on its rq, and no others.
 		 */
-		p = pick_highest_pushable_task(src_rq, this_cpu);
+		p = pick_highest_pushable_task(src_rt_rq, this_cpu);
 
 		/*
 		 * Do we have an RT task that preempts
-- 
2.50.1



Return-Path: <linux-kernel+bounces-836017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1ABBA895A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6281885735
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8463299931;
	Mon, 29 Sep 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRMk+o9b"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993128641F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137749; cv=none; b=u8/Ay7tn7jmXr/Q1A39tzSW4266B6Z2Ag7Lxt5KyTlaNzOaA7MQxI3o61yjmz2MKvMVk9A+XB4csXbXn3C34htAOd8F5VL5xXQ2cUx9f+vCLN/4i7Dv1s1tSpSCfRX13n8O9cjB2/gHu4dCgHQHE8EZ2N1Z1kbhav46jA92UJMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137749; c=relaxed/simple;
	bh=jciHxDfXeBXjUy/dxJ8pfOaiWCeNGNngLrWuDvXssKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIeascRYUfXcVm312//hGUP1E/lM0elRUoQQvwpQ/ii8D3/RX0gC8dBOmWquvwhdkDq9XGusH7nbxPy5/fV3xTlJYss9p92Eww1FZiBY1Sk9EF8iZipDCapN2eBluXJtc3ZCTAYEwkgVR5o7jDq/ZdMQC8hufN8PEJy1fGyoJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRMk+o9b; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07e3a77b72so897926166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137746; x=1759742546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gggYPJJA1Zkq3x0Mc0f9JOTzS0urDfAEbiSwWlZGS5s=;
        b=nRMk+o9bhNbu2WYi+kViyz0gmgV5zfFd39rvzua4r3eQPG2HUUWWvicgwK8OA3avqd
         t8HllAIfbeIsfq/Yq+Pn8TA5sNlH+oRJtng99r5IWkqRFitS8T0ja4Ac8gFiSSivolAV
         o1vJAjQJH1NgxCmfvKAJUpfVZOFrUT7qjQ0zJQQ5zIstKVecii/2/i6jEmkUmNvH4HG1
         ChHL22xFySGr/fbYwmM3oJSFitGoCsl1CTXiIAGeEbhDy+qardltkb+M11V8NsqP4sdQ
         9HFQJOBXnJM+dfPi/28IOy6LesAR1MnsVxrQb7w+Ay3ykrVsKDe42n4c578ZRsrA2Xai
         Te6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137746; x=1759742546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gggYPJJA1Zkq3x0Mc0f9JOTzS0urDfAEbiSwWlZGS5s=;
        b=vglfQkukuF2v/1UqaNH6a3zM6ZJDgVV9XZv7fP+O9uR52yA21+/bsWnhJi10MKEkA/
         JtAuzWBvScbT6Qayfy1UwrniueFjeBy0QxSd1a1ydODmOCsUcvJ77oxhP/Q2/XkEH/MJ
         ua3RhE+mQxeB1wYdgHdylKP4UBFIrSoEzczUoJvor20SseXsCQi2BbOnePaCxW8ELiKa
         uN0oCyceUNBbvNFDLUqtNg7MGzcvETIuHozgazEBOIrbjzqWfL96L6cBSA3tNpzkzjz1
         c4M8in6/qFTo5vttz4Qu4jiJwjSQsz97KtEMte/kPr6fmduiA7YMKGLMC3/jHfo2N0j5
         ErIw==
X-Gm-Message-State: AOJu0YzMjT5Pu0nq4N3Sg7IH53DHU4mbltMSWpbnMxe+exUx3UHgKNLQ
	0D6hOltGDOJLhJikr2RgaLB6kOvh9r3oBW2PdShIslyaZKpY8UpM32w6
X-Gm-Gg: ASbGncvlFTBTSji0NeRMFvg4yVS1VVqmyQdq6FEaTvYKO2a8c/YgzAtFlB3xPc51rY3
	+pjALus8Agd2p2A+fpisgAwAJtpZB+tQ37FO+f25A7gpAA2zyjENsgV4o8QkMk0mdBGWFCT0ffq
	SgdDseeYal35NaraL+s4jAPESM2t4xGbXAeuHLknQTNLdZiZ4N/FmFlryfiWVf4STgfMQvLnvPr
	kTmB09c4KxxSzgiZg5uy/1HMpt7e0kZzSXax1eBeQvZOsjnzWdX9GlotU75dFlcGR6/RbvWBDe+
	updNyvJKwlQO1niKuECpzbAjB0rjNGBomag5PptVTeTnMOmuW4Tl2ks6Mc3RRzJjxrlk/IIfsGz
	K7AivdkZmBpHzLjZOA7BZ19fVdMOkMQ==
X-Google-Smtp-Source: AGHT+IFcawAFjjtrBu72ZmutGJat4fOVwMnAHz+aI0KZt43YXA2uZneYZ92vjrSPuYCxKe+Amm5iqQ==
X-Received: by 2002:a17:907:971c:b0:af9:8739:10ca with SMTP id a640c23a62f3a-b3a12358b98mr811166766b.28.1759137745462;
        Mon, 29 Sep 2025 02:22:25 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:25 -0700 (PDT)
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
Subject: [RFC PATCH v3 03/24] sched/rt: Pass an rt_rq instead of an rq where needed
Date: Mon, 29 Sep 2025 11:22:00 +0200
Message-ID: <20250929092221.10947-4-yurand2000@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929092221.10947-1-yurand2000@gmail.com>
References: <20250929092221.10947-1-yurand2000@gmail.com>
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
 kernel/sched/rt.c | 99 ++++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7936d433373..a7d063d2303 100644
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
@@ -381,50 +381,54 @@ static DEFINE_PER_CPU(struct balance_callback, rt_pull_head);
 static void push_rt_tasks(struct rq *);
 static void pull_rt_task(struct rq *);
 
-static inline void rt_queue_push_tasks(struct rq *rq)
+static inline void rt_queue_push_tasks(struct rt_rq * rt_rq)
 {
-	if (!has_pushable_tasks(rq))
+	struct rq *rq = container_of(rt_rq, struct rq, rt);
+
+	if (!has_pushable_tasks(rt_rq))
 		return;
 
 	queue_balance_callback(rq, &per_cpu(rt_push_head, rq->cpu), push_rt_tasks);
 }
 
-static inline void rt_queue_pull_task(struct rq *rq)
+static inline void rt_queue_pull_task(struct rt_rq * rt_rq)
 {
+	struct rq *rq = container_of(rt_rq, struct rq, rt);
+
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
@@ -1431,6 +1435,7 @@ static void
 enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
 
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
@@ -1444,17 +1449,18 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
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
@@ -1639,14 +1645,14 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
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
@@ -1659,7 +1665,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	if (rq->donor->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
-	rt_queue_push_tasks(rq);
+	rt_queue_push_tasks(rt_rq);
 }
 
 static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
@@ -1710,7 +1716,7 @@ static struct task_struct *pick_task_rt(struct rq *rq)
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
-	struct rt_rq *rt_rq = &rq->rt;
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
 
 	if (on_rt_rq(&p->rt))
 		update_stats_wait_start_rt(rt_rq, rt_se);
@@ -1726,7 +1732,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
 	 * if it is still active
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
-		enqueue_pushable_task(rq, p);
+		enqueue_pushable_task(rt_rq, p);
 }
 
 /* Only try algorithms three times */
@@ -1736,16 +1742,16 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
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
 
@@ -1845,14 +1851,15 @@ static int find_lowest_rq(struct task_struct *task)
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
@@ -1905,7 +1912,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 */
 			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task != pick_next_pushable_task(rq))) {
+				     task != pick_next_pushable_task(&rq->rt))) {
 
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
@@ -1939,7 +1946,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	if (!rq->rt.overloaded)
 		return 0;
 
-	next_task = pick_next_pushable_task(rq);
+	next_task = pick_next_pushable_task(&rq->rt);
 	if (!next_task)
 		return 0;
 
@@ -2014,7 +2021,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * run-queue and is also still the next task eligible for
 		 * pushing.
 		 */
-		task = pick_next_pushable_task(rq);
+		task = pick_next_pushable_task(&rq->rt);
 		if (task == next_task) {
 			/*
 			 * The task hasn't migrated, and is still the next
@@ -2202,7 +2209,7 @@ void rto_push_irq_work_func(struct irq_work *work)
 	 * We do not need to grab the lock to check for has_pushable_tasks.
 	 * When it gets updated, a check is made if a push is possible.
 	 */
-	if (has_pushable_tasks(rq)) {
+	if (has_pushable_tasks(&rq->rt)) {
 		raw_spin_rq_lock(rq);
 		while (push_rt_task(rq, true))
 			;
@@ -2231,6 +2238,7 @@ static void pull_rt_task(struct rq *this_rq)
 	int this_cpu = this_rq->cpu, cpu;
 	bool resched = false;
 	struct task_struct *p, *push_task;
+	struct rt_rq *src_rt_rq;
 	struct rq *src_rq;
 	int rt_overload_count = rt_overloaded(this_rq);
 
@@ -2260,6 +2268,7 @@ static void pull_rt_task(struct rq *this_rq)
 			continue;
 
 		src_rq = cpu_rq(cpu);
+		src_rt_rq = &src_rq->rt;
 
 		/*
 		 * Don't bother taking the src_rq->lock if the next highest
@@ -2268,7 +2277,7 @@ static void pull_rt_task(struct rq *this_rq)
 		 * logically higher, the src_rq will push this task away.
 		 * And if its going logically lower, we do not care
 		 */
-		if (src_rq->rt.highest_prio.next >=
+		if (src_rt_rq->highest_prio.next >=
 		    this_rq->rt.highest_prio.curr)
 			continue;
 
@@ -2284,7 +2293,7 @@ static void pull_rt_task(struct rq *this_rq)
 		 * We can pull only a task, which is pushable
 		 * on its rq, and no others.
 		 */
-		p = pick_highest_pushable_task(src_rq, this_cpu);
+		p = pick_highest_pushable_task(src_rt_rq, this_cpu);
 
 		/*
 		 * Do we have an RT task that preempts
@@ -2390,7 +2399,7 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
 		return;
 
-	rt_queue_pull_task(rq);
+	rt_queue_pull_task(rt_rq_of_se(&p->rt));
 }
 
 void __init init_sched_rt_class(void)
@@ -2426,7 +2435,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (task_on_rq_queued(p)) {
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
-			rt_queue_push_tasks(rq);
+			rt_queue_push_tasks(rt_rq_of_se(&p->rt));
 		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
@@ -2448,7 +2457,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * may need to pull tasks to this runqueue.
 		 */
 		if (oldprio < p->prio)
-			rt_queue_pull_task(rq);
+			rt_queue_pull_task(rt_rq_of_se(&p->rt));
 
 		/*
 		 * If there's a higher priority task waiting to run
-- 
2.51.0



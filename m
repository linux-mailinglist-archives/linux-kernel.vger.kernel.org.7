Return-Path: <linux-kernel+bounces-751980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB6FB16FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F303B3B0ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5EE2D3725;
	Thu, 31 Jul 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0t+uOoC"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B482D0C6B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959365; cv=none; b=UFX0UsmYOp/iNfQ6cCxWM+eiueYTAsk5CLEodRLFSuXM9GPVlN1a4pFxNmpnBstD+IVlJsz7xk0iR3ARRfNAEGp1iqW28o+IOqstDLIV+b/bs5yr57Z5CrjfE0h8WQWWD5H+H2Pz2mUY7B4D2lQW5eVQwWNRCFuKZWRhSeZqEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959365; c=relaxed/simple;
	bh=K12u59/Jdto8wGdYTXc18vqTil4fRVAsVNrZ2T5FNPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHHR4VcqqmAXaDMEX4LZlvH4jp+LS8+1qvUmfoUAxFoDlpZ83bBYnU3b1j+0bpwT6NaQUHfxNZQ1dp+OXEq6k5wiyo8V8dzfzRDtQepcDkmkbqYu7Q5NuO+sNFf9wEF0aIdlkWZPyNuF0FaKMwpAdThzRnmYGwasN4O1+ihzTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0t+uOoC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so615294f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959360; x=1754564160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6POCJpohgM1qd3Vfj0hh2gC5FtaPdLsrtNLQFlwev7M=;
        b=I0t+uOoCO7OjPUczrYzIz5NbB+2XKk1Ldke5HUELZP0ONKk2TT+fAdW6J9Qw0p893r
         DshDe1RocrkY3KpH8yKIEOJCpCGdgUwTB44ZIonWAyjdY7ucNBRda7gU35orUcr4NKzQ
         loJYO5Apvmlk2ARU9kHaTeww1tQ9GEE+ePAJF1it0byFybcsFq+IOWdirFf14zh4tC2j
         ixwMkDTaZolPjmfkS2Ah5o4jnZ5RZ83BH4o+DkpVMmddcltBc/0I1IyZmwOUS+v34T+y
         Ew+kYc9em3qpB4KtBESdGryOwfMojd4h/6u5+wTD+u4xYZmzl5ToZlCZFFzzPkNPL/IO
         Qx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959360; x=1754564160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6POCJpohgM1qd3Vfj0hh2gC5FtaPdLsrtNLQFlwev7M=;
        b=isLiU1srC1L/ZZOF4cqlHsQco3MHrtvQt29k7hvMYFnqM+AzkGlskmuN2QYvaYJmbd
         9nZ9/ZwDOEDHu+Q3NShI7UE86NGLqlmaGtV/yrdKlPp0xCaNCf0KQVUvVtcZNrizDX1S
         pM7jIkw3SmYPS01REq1L1GN2vYq9seVmzYWLOprhWoAWirHv6WKZTkijbscq9lDIYF6l
         IkfJJyitIDSEFDYFK7f0QJuktsPsjj2sQ5S1W2YHnGZS4/1CldxMVrFasLSbCzrqpZfO
         8YbionV2f1OBVgLxlpCvEGuJreROjCb8YIEFUAXgrGa9h5sI8J6znzNsOhOUoUHOiNIm
         Zsiw==
X-Gm-Message-State: AOJu0YynE92keMqrsaeHU8v/czYrgtm/Y5SC3/nU3JRmgCEtDbtkWZPZ
	1Dp0yAYls97k2EDkr/VYD9KQ8GeAaKARiEi7r/Hpin8B0LLa0AqyBVQA
X-Gm-Gg: ASbGncsveErsddCjginDKki90XancBxOvynWJ4eh/W6h5AnCrwRT6HoRY+hLSyPJhJs
	dGVQ5GHH+9oEDl2iq6ZHH0RQ5IKwkKHaukDZYZjjktMrkRzJ3NvH0FJUeRra485m5Osi/Yl6X/w
	0VWlycD6+8yFrGv68n9IAgJEHXPsEOJnwHRtjUSqr2HL19OqQ/lmFhyoauUZNuWfUxHjNQKGuD7
	0IEHOuRjP/sq8eX2rTVjkyWkbcCeK8J7ePdA+rOii8h4QKvZkWr+d2Z+Fpb9fmZjyOA5tuQ01ut
	wdp8ehLq89FlJBBm3ElCziJuZxNQHbwqPinWTGQ2ShzQzVdUKNfS8TjM3ZO2GlPR30+GFKXpF+q
	G5Pt2oMlVzIhnpFEHLcM=
X-Google-Smtp-Source: AGHT+IFTLt3dOQNeazPOHMKBHCZZ9hnVACfWv/yBY7T2W+KYoSLQf39dT6WIFJ+YvM3FLhvm8ml+hA==
X-Received: by 2002:a05:6000:2210:b0:3b7:75ee:1eb0 with SMTP id ffacd0b85a97d-3b794ffddc2mr5814369f8f.38.1753959360338;
        Thu, 31 Jul 2025 03:56:00 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:56:00 -0700 (PDT)
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
Subject: [RFC PATCH v2 20/25] sched/rt: Add rt-cgroup migration
Date: Thu, 31 Jul 2025 12:55:38 +0200
Message-ID: <20250731105543.40832-21-yurand2000@gmail.com>
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

When the runtime is exhausted in a RT CGroup, the scheduler checks for
another non-throttled runqueue and, if available, migrates the tasks.

The bandwidth (runtime/period) chosen for a certain cgroup is replicated on
every core of the system, therefore, in an SMP system with M cores, the
total available bandwidth is the given runtime/period multiplied by M.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/rt.c    | 471 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   5 +
 2 files changed, 468 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 29b51251fdc..2fdb2657554 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1,3 +1,4 @@
+#pragma GCC diagnostic ignored "-Wunused-function"
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Real-Time Scheduling Class (mapped to the SCHED_FIFO and SCHED_RR
@@ -84,6 +85,8 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	plist_head_init(&rt_rq->pushable_tasks);
 }
 
+static void group_pull_rt_task(struct rt_rq *this_rt_rq);
+
 #ifdef CONFIG_RT_GROUP_SCHED
 
 void unregister_rt_sched_group(struct task_group *tg)
@@ -289,6 +292,45 @@ static inline void rt_queue_pull_task(struct rq *rq)
 	queue_balance_callback(rq, &per_cpu(rt_pull_head, rq->cpu), pull_rt_task);
 }
 
+#ifdef CONFIG_RT_GROUP_SCHED
+static DEFINE_PER_CPU(struct balance_callback, rt_group_push_head);
+static DEFINE_PER_CPU(struct balance_callback, rt_group_pull_head);
+static void push_group_rt_tasks(struct rq *);
+static void pull_group_rt_tasks(struct rq *);
+
+static void rt_queue_push_from_group(struct rq *rq, struct rt_rq *rt_rq)
+{
+	BUG_ON(rt_rq == NULL);
+	BUG_ON(rt_rq->rq != rq);
+
+	if (rq->rq_to_push_from)
+		return;
+
+	rq->rq_to_push_from = container_of(rt_rq, struct rq, rt);
+	queue_balance_callback(rq, &per_cpu(rt_group_push_head, rq->cpu),
+			       push_group_rt_tasks);
+}
+
+static void rt_queue_pull_to_group(struct rq *rq, struct rt_rq *rt_rq)
+{
+	struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+	BUG_ON(rt_rq == NULL);
+	BUG_ON(!is_dl_group(rt_rq));
+	BUG_ON(rt_rq->rq != rq);
+
+	if (dl_se->dl_throttled || rq->rq_to_pull_to)
+		return;
+
+	rq->rq_to_pull_to = container_of(rt_rq, struct rq, rt);
+	queue_balance_callback(rq, &per_cpu(rt_group_pull_head, rq->cpu),
+			       pull_group_rt_tasks);
+}
+#else
+static inline void rt_queue_push_from_group(struct rq *rq, struct rt_rq *rt_rq) {};
+static inline void rt_queue_pull_to_group(struct rq *rq, struct rt_rq *rt_rq) {};
+#endif
+
 static void enqueue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 {
 	plist_del(&p->pushable_tasks, &rt_rq->pushable_tasks);
@@ -1277,6 +1319,8 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
  */
 static int push_rt_task(struct rq *rq, bool pull)
 {
+	BUG_ON(is_dl_group(&rq->rt));
+
 	struct task_struct *next_task;
 	struct rq *lowest_rq;
 	int ret = 0;
@@ -1573,6 +1617,8 @@ void rto_push_irq_work_func(struct irq_work *work)
 
 static void pull_rt_task(struct rq *this_rq)
 {
+	BUG_ON(is_dl_group(&this_rq->rt));
+
 	int this_cpu = this_rq->cpu, cpu;
 	bool resched = false;
 	struct task_struct *p, *push_task;
@@ -1683,27 +1729,436 @@ static void pull_rt_task(struct rq *this_rq)
 }
 
 #ifdef CONFIG_RT_GROUP_SCHED
-static int group_push_rt_task(struct rt_rq *rt_rq)
+/*
+ * Find the lowest priority runqueue among the runqueues of the same
+ * task group. Unlike find_lowest_rt(), this does not mean that the
+ * lowest priority cpu is running tasks from this runqueue.
+ */
+static int group_find_lowest_rt_rq(struct task_struct *task, struct rt_rq* task_rt_rq)
+{
+	struct sched_domain *sd;
+	struct cpumask mask, *lowest_mask = &mask;
+	struct sched_dl_entity *dl_se;
+	struct rt_rq *rt_rq;
+	int prio, lowest_prio;
+	int cpu, this_cpu = smp_processor_id();
+
+	BUG_ON(task->sched_task_group != task_rt_rq->tg);
+
+	if (task->nr_cpus_allowed == 1)
+		return -1; /* No other targets possible */
+
+	lowest_prio = task->prio - 1;
+	cpumask_clear(lowest_mask);
+	for_each_cpu_and(cpu, cpu_online_mask, task->cpus_ptr) {
+		dl_se = task_rt_rq->tg->dl_se[cpu];
+		rt_rq = &dl_se->my_q->rt;
+		prio = rt_rq->highest_prio.curr;
+
+		/*
+		 * If we're on asym system ensure we consider the different capacities
+		 * of the CPUs when searching for the lowest_mask.
+		 */
+		if (dl_se->dl_throttled || !rt_task_fits_capacity(task, cpu))
+			continue;
+
+		if (prio >= lowest_prio) {
+			if (prio > lowest_prio) {
+				cpumask_clear(lowest_mask);
+				lowest_prio = prio;
+			}
+
+			cpumask_set_cpu(cpu, lowest_mask);
+		}
+	}
+
+	if (cpumask_empty(lowest_mask))
+		return -1;
+
+	/*
+	 * At this point we have built a mask of CPUs representing the
+	 * lowest priority tasks in the system.  Now we want to elect
+	 * the best one based on our affinity and topology.
+	 *
+	 * We prioritize the last CPU that the task executed on since
+	 * it is most likely cache-hot in that location.
+	 */
+	cpu = task_cpu(task);
+	if (cpumask_test_cpu(cpu, lowest_mask))
+		return cpu;
+
+	/*
+	 * Otherwise, we consult the sched_domains span maps to figure
+	 * out which CPU is logically closest to our hot cache data.
+	 */
+	if (!cpumask_test_cpu(this_cpu, lowest_mask))
+		this_cpu = -1; /* Skip this_cpu opt if not among lowest */
+
+	rcu_read_lock();
+	for_each_domain(cpu, sd) {
+		if (sd->flags & SD_WAKE_AFFINE) {
+			int best_cpu;
+
+			/*
+			 * "this_cpu" is cheaper to preempt than a
+			 * remote processor.
+			 */
+			if (this_cpu != -1 &&
+			    cpumask_test_cpu(this_cpu, sched_domain_span(sd))) {
+				rcu_read_unlock();
+				return this_cpu;
+			}
+
+			best_cpu = cpumask_any_and_distribute(lowest_mask,
+							      sched_domain_span(sd));
+			if (best_cpu < nr_cpu_ids) {
+				rcu_read_unlock();
+				return best_cpu;
+			}
+		}
+	}
+	rcu_read_unlock();
+
+	/*
+	 * And finally, if there were no matches within the domains
+	 * just give the caller *something* to work with from the compatible
+	 * locations.
+	 */
+	if (this_cpu != -1)
+		return this_cpu;
+
+	cpu = cpumask_any_distribute(lowest_mask);
+	if (cpu < nr_cpu_ids)
+		return cpu;
+
+	return -1;
+}
+
+/*
+ * Find and lock the lowest priority runqueue among the runqueues
+ * of the same task group. Unlike find_lock_lowest_rt(), this does not
+ * mean that the lowest priority cpu is running tasks from this runqueue.
+ */
+static struct rt_rq* group_find_lock_lowest_rt_rq(struct task_struct *task, struct rt_rq *rt_rq)
+{
+	struct rq *rq = rq_of_rt_rq(rt_rq);
+	struct rq *lowest_rq;
+	struct rt_rq *lowest_rt_rq = NULL;
+	struct sched_dl_entity *lowest_dl_se;
+	int tries, cpu;
+
+	BUG_ON(task->sched_task_group != rt_rq->tg);
+
+	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
+		cpu = group_find_lowest_rt_rq(task, rt_rq);
+
+		if ((cpu == -1) || (cpu == rq->cpu))
+			break;
+
+		lowest_dl_se = rt_rq->tg->dl_se[cpu];
+		lowest_rt_rq = &lowest_dl_se->my_q->rt;
+		lowest_rq = cpu_rq(cpu);
+
+		if (lowest_rt_rq->highest_prio.curr <= task->prio) {
+			/*
+			 * Target rq has tasks of equal or higher priority,
+			 * retrying does not release any lock and is unlikely
+			 * to yield a different result.
+			 */
+			lowest_rt_rq = NULL;
+			break;
+		}
+
+		/* if the prio of this runqueue changed, try again */
+		if (double_lock_balance(rq, lowest_rq)) {
+			/*
+			 * We had to unlock the run queue. In
+			 * the mean time, task could have
+			 * migrated already or had its affinity changed.
+			 * Also make sure that it wasn't scheduled on its rq.
+			 * It is possible the task was scheduled, set
+			 * "migrate_disabled" and then got preempted, so we must
+			 * check the task migration disable flag here too.
+			 */
+			if (unlikely(is_migration_disabled(task) ||
+				     lowest_dl_se->dl_throttled ||
+				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
+				     task != pick_next_pushable_task(rt_rq))) {
+
+				double_unlock_balance(rq, lowest_rq);
+				lowest_rt_rq = NULL;
+				break;
+			}
+		}
+
+		/* If this rq is still suitable use it. */
+		if (lowest_rt_rq->highest_prio.curr > task->prio)
+			break;
+
+		/* try again */
+		double_unlock_balance(rq, lowest_rq);
+		lowest_rt_rq = NULL;
+	}
+
+	return lowest_rt_rq;
+}
+
+static int group_push_rt_task(struct rt_rq *rt_rq, bool pull)
 {
+	BUG_ON(!is_dl_group(rt_rq));
+
 	struct rq *rq = rq_of_rt_rq(rt_rq);
+	struct task_struct *next_task;
+	struct rq *lowest_rq;
+	struct rt_rq *lowest_rt_rq;
+	int ret = 0;
+
+	if (!rt_rq->overloaded)
+		return 0;
+
+	next_task = pick_next_pushable_task(rt_rq);
+	if (!next_task)
+		return 0;
+
+retry:
+	if (is_migration_disabled(next_task)) {
+		struct task_struct *push_task = NULL;
+		int cpu;
+
+		if (!pull || rq->push_busy)
+			return 0;
+
+		/*
+		 * If the current task does not belong to the same task group
+		 * we cannot push it away.
+		 */
+		if (rq->curr->sched_task_group != rt_rq->tg)
+			return 0;
+
+		/*
+		 * Invoking group_find_lowest_rt_rq() on anything but an RT task doesn't
+		 * make sense. Per the above priority check, curr has to
+		 * be of higher priority than next_task, so no need to
+		 * reschedule when bailing out.
+		 *
+		 * Note that the stoppers are masqueraded as SCHED_FIFO
+		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
+		 */
+		if (rq->curr->sched_class != &rt_sched_class)
+			return 0;
+
+		cpu = group_find_lowest_rt_rq(rq->curr, rt_rq);
+		if (cpu == -1 || cpu == rq->cpu)
+			return 0;
+
+		/*
+		 * Given we found a CPU with lower priority than @next_task,
+		 * therefore it should be running. However we cannot migrate it
+		 * to this other CPU, instead attempt to push the current
+		 * running task on this CPU away.
+		 */
+		push_task = get_push_task(rq);
+		if (push_task) {
+			preempt_disable();
+			raw_spin_rq_unlock(rq);
+			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
+					    push_task, &rq->push_work);
+			preempt_enable();
+			raw_spin_rq_lock(rq);
+		}
 
-	if (is_dl_group(rt_rq))
 		return 0;
+	}
+
+	if (WARN_ON(next_task == rq->curr))
+		return 0;
+
+	/* We might release rq lock */
+	get_task_struct(next_task);
+
+	/* group_find_lock_lowest_rq locks the rq if found */
+	lowest_rt_rq = group_find_lock_lowest_rt_rq(next_task, rt_rq);
+	if (!lowest_rt_rq) {
+		struct task_struct *task;
+		/*
+		 * group_find_lock_lowest_rt_rq releases rq->lock
+		 * so it is possible that next_task has migrated.
+		 *
+		 * We need to make sure that the task is still on the same
+		 * run-queue and is also still the next task eligible for
+		 * pushing.
+		 */
+		task = pick_next_pushable_task(rt_rq);
+		if (task == next_task) {
+			/*
+			 * The task hasn't migrated, and is still the next
+			 * eligible task, but we failed to find a run-queue
+			 * to push it to.  Do not retry in this case, since
+			 * other CPUs will pull from us when ready.
+			 */
+			goto out;
+		}
+
+		if (!task)
+			/* No more tasks, just exit */
+			goto out;
+
+		/*
+		 * Something has shifted, try again.
+		 */
+		put_task_struct(next_task);
+		next_task = task;
+		goto retry;
+	}
+
+	lowest_rq = rq_of_rt_rq(lowest_rt_rq);
+
+	move_queued_task_locked(rq, lowest_rq, next_task);
+	resched_curr(lowest_rq);
+	ret = 1;
+
+	double_unlock_balance(rq, lowest_rq);
+out:
+	put_task_struct(next_task);
+
+	return ret;
+}
+
+static void group_pull_rt_task(struct rt_rq *this_rt_rq)
+{
+	BUG_ON(!is_dl_group(this_rt_rq));
+
+	struct rq *this_rq = rq_of_rt_rq(this_rt_rq);
+	int this_cpu = this_rq->cpu, cpu;
+	bool resched = false;
+	struct task_struct *p, *push_task = NULL;
+	struct rt_rq *src_rt_rq;
+	struct rq *src_rq;
+	struct sched_dl_entity *src_dl_se;
+
+	for_each_online_cpu(cpu) {
+		if (this_cpu == cpu)
+			continue;
 
-	return push_rt_task(rq, false);
+		src_dl_se = this_rt_rq->tg->dl_se[cpu];
+		src_rt_rq = &src_dl_se->my_q->rt;
+
+		if (src_rt_rq->rt_nr_running <= 1 && !src_dl_se->dl_throttled)
+			continue;
+
+		src_rq = rq_of_rt_rq(src_rt_rq);
+
+		/*
+		 * Don't bother taking the src_rq->lock if the next highest
+		 * task is known to be lower-priority than our current task.
+		 * This may look racy, but if this value is about to go
+		 * logically higher, the src_rq will push this task away.
+		 * And if its going logically lower, we do not care
+		 */
+		if (src_rt_rq->highest_prio.next >=
+		    this_rt_rq->highest_prio.curr)
+			continue;
+
+		/*
+		 * We can potentially drop this_rq's lock in
+		 * double_lock_balance, and another CPU could
+		 * alter this_rq
+		 */
+		push_task = NULL;
+		double_lock_balance(this_rq, src_rq);
+
+		/*
+		 * We can pull only a task, which is pushable
+		 * on its rq, and no others.
+		 */
+		p = pick_highest_pushable_task(src_rt_rq, this_cpu);
+
+		/*
+		 * Do we have an RT task that preempts
+		 * the to-be-scheduled task?
+		 */
+		if (p && (p->prio < this_rt_rq->highest_prio.curr)) {
+			WARN_ON(p == src_rq->curr);
+			WARN_ON(!task_on_rq_queued(p));
+
+			/*
+			 * There's a chance that p is higher in priority
+			 * than what's currently running on its CPU.
+			 * This is just that p is waking up and hasn't
+			 * had a chance to schedule. We only pull
+			 * p if it is lower in priority than the
+			 * current task on the run queue
+			 */
+			if (p->prio < src_rq->curr->prio)
+				goto skip;
+
+			if (is_migration_disabled(p)) {
+				/*
+				 * If the current task does not belong to the same task group
+				 * we cannot push it away.
+				 */
+				if (src_rq->curr->sched_task_group != this_rt_rq->tg)
+					goto skip;
+
+				push_task = get_push_task(src_rq);
+			} else {
+				move_queued_task_locked(src_rq, this_rq, p);
+				resched = true;
+			}
+			/*
+			 * We continue with the search, just in
+			 * case there's an even higher prio task
+			 * in another runqueue. (low likelihood
+			 * but possible)
+			 */
+		}
+skip:
+		double_unlock_balance(this_rq, src_rq);
+
+		if (push_task) {
+			preempt_disable();
+			raw_spin_rq_unlock(this_rq);
+			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
+					    push_task, &src_rq->push_work);
+			preempt_enable();
+			raw_spin_rq_lock(this_rq);
+		}
+	}
+
+	if (resched)
+		resched_curr(this_rq);
 }
 
 static void group_push_rt_tasks(struct rt_rq *rt_rq)
 {
-	while (group_push_rt_task(rt_rq))
+	while (group_push_rt_task(rt_rq, false))
 		;
 }
-#else
-static void group_push_rt_tasks(struct rt_rq *rt_rq)
+
+static void push_group_rt_tasks(struct rq *rq)
 {
-	push_rt_tasks(rq_of_rt_rq(rt_rq));
+	BUG_ON(rq->rq_to_push_from == NULL);
+
+	if ((rq->rq_to_push_from->rt.rt_nr_running > 1) ||
+	    (dl_group_of(&rq->rq_to_push_from->rt)->dl_throttled == 1)) {
+		group_push_rt_task(&rq->rq_to_push_from->rt, false);
+	}
+
+	rq->rq_to_push_from = NULL;
 }
-#endif
+
+static void pull_group_rt_tasks(struct rq *rq)
+{
+	BUG_ON(rq->rq_to_pull_to == NULL);
+	BUG_ON(rq->rq_to_pull_to->rt.rq != rq);
+
+	group_pull_rt_task(&rq->rq_to_pull_to->rt);
+	rq->rq_to_pull_to = NULL;
+}
+#else /* CONFIG_RT_GROUP_SCHED */
+static void group_pull_rt_task(struct rt_rq *this_rt_rq) { }
+static void group_push_rt_tasks(struct rt_rq *rt_rq) { }
+#endif /* CONFIG_RT_GROUP_SCHED */
 
 /*
  * If we are not running and we are not going to reschedule soon, we should
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3dd2ede6d35..10e29f37f9b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1282,6 +1282,11 @@ struct rq {
 	call_single_data_t	cfsb_csd;
 	struct list_head	cfsb_csd_list;
 #endif
+
+#ifdef CONFIG_RT_GROUP_SCHED
+	struct rq		*rq_to_push_from;
+	struct rq		*rq_to_pull_to;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.50.1



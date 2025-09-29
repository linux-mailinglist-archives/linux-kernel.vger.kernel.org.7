Return-Path: <linux-kernel+bounces-836033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A93BA8990
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34603B5AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9962D3A9E;
	Mon, 29 Sep 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsjexBXM"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348B2D12EB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137762; cv=none; b=QO4V2ksAfBuGLyiSHwFETwPF+QNBqa6f3pHKIELX6dX4gCLbarGUojmokUusSr8AvenIru7DN2t62oY9Zgr2SytZg0tpxxwe1uJ/1nD+HHjWBW6xTMihe+3JemI8jWgR4y5TwwL3XvxE5ZMA7EPlpfu34jiARXBPwbtu+7FGb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137762; c=relaxed/simple;
	bh=fxG+bTxB07LCi9Ts9lL1Yl3nrlWVjIIv8vHQOIlnXQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBPzfaDzo2EIWnzAKDoySAQi6OWaa7TWEnY56SAJLUjGUybtsgmVoesM5yCC4FsK16CATHEAF2WtBmGq1WSKZNDiIZCviKAFPJyaLHiYxT6SSuinpJ+EsipxFlmQTmnF4O9VU4zn7IgWWpi0aIwwjTZT7I1EC1g+zBpe8mOSyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsjexBXM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3ee18913c0so133110666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137758; x=1759742558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sruGDAIuG3pHlYCEj+2RbEEqGhhXQxwPKteoyiFJfm0=;
        b=lsjexBXMu4H+YBug8YlV7mwJ0j3dvEUBuvgek5UrbJAISHOQyzJY7JE89wPy+oTm2p
         cuf5flMW2cZ5N+JIIlkSbnL/j4eOenR+9+OFPZ4QtoWJnut+TXhekKBUoFRLvK8g6DX6
         Fo7kvywj1chZeSMxXu5jlpWb5N1QF0Vqzm+nVBmyD35JlmHwBPKccNLytDdKWms2gDlL
         NhEamDtsSVSofyBJgrlY+WdCciXpZuedo39cqWmrk2ETo4T8Q7hzxSuyZOnbdwgnCuvC
         sEFhG/1YBE2BpBcxyGF/02l1kmbLUyQDgfKj4FpR6O5whRllbnFGXTOqAScab2vj/NZW
         zWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137758; x=1759742558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sruGDAIuG3pHlYCEj+2RbEEqGhhXQxwPKteoyiFJfm0=;
        b=a+3iTKJnm0QTk3D4dW/0lVRNX+RTBo653heiTdQt7+bgOylBsIl5NK85xNAP76RIRF
         Vm0g608gJ+km0qKXBT4+keNm8EoVawDkAu0+CRuGJu5gtE9vZ/LhmwLee9dVVUhWXDCS
         PFT/5pyf6ERQjw3WCz4BxSl70ahFlbjdzgk/8/AKht2O6LCY95B2H602EnJg5aErqQ/Y
         4035o2o4T78CTTEHSdJmaw6VZ9w104ByVshImBDl+hxBc5WcqrGsSJFNQ/V4wggetqxr
         UOzfLb+C6mxh98hLuTp+y9Usc7bHhdKgbb7ouTv8X5cO+nuhndOINko9onkJNSo6AmTJ
         YFpw==
X-Gm-Message-State: AOJu0Yx2TIwe/Rvt41cZdsHYIYSrzP9vD9laDvcdwXujRe+Ba0NZF2Hh
	oQ4X+YZIyDotpaQcQfi/Yo30I47rPEyjX4puT3wMmKNbTQWi1rTA3ss+
X-Gm-Gg: ASbGncsnGVMITqX70OMeDpqB2LVqihp2H700AMMbAmDzA8xcBjFfOCQB96MBsVlXP9u
	s/lOzdcLV2pREITjn7+6Y6ggxXLSQLGdgfEBO6Eum8ynZnYco8BlUePGQqIrEjhDD0SNU8TFWlM
	2Ojk/hnAPRzMq/eLVC9MWxy7QF/tPJdPHYx17TKjal9oAcanOwREepXoZ5XJLXvEm78QDBhlHtx
	ADgrU+e9Vm+MSSXfFMDLL/ilDPdt91UCFzb9qtnGJznKfNcQZYXNaPaCXTz1QNUp3+ruzpDdYZB
	kj6WqH62JyMKJZSF2fQrT92IVx+rZgvAzTvNRM2Qh/vP+jyzPIA2anonOBRXrh3qvZ+5MZgSDle
	A7V3fm+JJec65L3Askr4Whzp1xg0kcg==
X-Google-Smtp-Source: AGHT+IF7xM4d9a5Oa2BSywkR/hoC2YErIuLnwL9Uxt8xadFiyU0NjsTWrgCgLmXYsxeiJSgifomyBg==
X-Received: by 2002:a17:907:3d91:b0:b0e:d477:4961 with SMTP id a640c23a62f3a-b34b8d96245mr1725701166b.23.1759137757691;
        Mon, 29 Sep 2025 02:22:37 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:37 -0700 (PDT)
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
Subject: [RFC PATCH v3 19/24] sched/rt: Add rt-cgroup migration
Date: Mon, 29 Sep 2025 11:22:16 +0200
Message-ID: <20250929092221.10947-20-yurand2000@gmail.com>
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
 kernel/sched/rt.c    | 495 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  10 +
 2 files changed, 505 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 17ad91261cb..1fbcac14fc9 100644
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
@@ -136,6 +139,7 @@ void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
 		struct sched_dl_entity *dl_se, int cpu,
 		struct sched_dl_entity *parent)
 {
+	served_rq->cpu = cpu;
 	served_rq->rt.highest_prio.curr = MAX_RT_PRIO-1;
 	served_rq->rt.rq = cpu_rq(cpu);
 	served_rq->rt.tg = tg;
@@ -299,6 +303,53 @@ static inline void rt_queue_pull_task(struct rt_rq * rt_rq)
 	queue_balance_callback(rq, &per_cpu(rt_pull_head, rq->cpu), pull_rt_task);
 }
 
+#ifdef CONFIG_RT_GROUP_SCHED
+static DEFINE_PER_CPU(struct balance_callback, rt_group_push_head);
+static DEFINE_PER_CPU(struct balance_callback, rt_group_pull_head);
+static void group_push_rt_tasks_callback(struct rq *);
+static void group_pull_rt_task_callback(struct rq *);
+
+static void rt_queue_push_from_group(struct rt_rq *rt_rq)
+{
+	struct rq *rq = container_of(rt_rq, struct rq, rt);
+	struct rq *global_rq = cpu_rq(rq->cpu);
+
+	BUG_ON(rt_rq == NULL);
+	BUG_ON(rt_rq->rq != global_rq);
+
+	if (global_rq->rq_to_push_from)
+		return;
+
+	if (!has_pushable_tasks(rt_rq))
+		return;
+
+	global_rq->rq_to_push_from = rq;
+	queue_balance_callback(global_rq, &per_cpu(rt_group_push_head, global_rq->cpu),
+			       group_push_rt_tasks_callback);
+}
+
+static void rt_queue_pull_to_group(struct rt_rq *rt_rq)
+{
+	struct rq *rq = container_of(rt_rq, struct rq, rt);
+	struct rq *global_rq = cpu_rq(rq->cpu);
+	struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+	BUG_ON(rt_rq == NULL);
+	BUG_ON(!is_dl_group(rt_rq));
+	BUG_ON(rt_rq->rq != global_rq);
+
+	if (dl_se->dl_throttled || global_rq->rq_to_pull_to)
+		return;
+
+	global_rq->rq_to_pull_to = rq;
+	queue_balance_callback(global_rq, &per_cpu(rt_group_pull_head, global_rq->cpu),
+			       group_pull_rt_task_callback);
+}
+#else
+static inline void rt_queue_push_from_group(struct rt_rq *rt_rq) {};
+static inline void rt_queue_pull_to_group(struct rt_rq *rt_rq) {};
+#endif
+
 static void enqueue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 {
 	plist_del(&p->pushable_tasks, &rt_rq->pushable_tasks);
@@ -1303,6 +1354,8 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
  */
 static int push_rt_task(struct rq *rq, bool pull)
 {
+	BUG_ON(is_dl_group(&rq->rt));
+
 	struct task_struct *next_task;
 	struct rq *lowest_rq;
 	int ret = 0;
@@ -1599,6 +1652,8 @@ void rto_push_irq_work_func(struct irq_work *work)
 
 static void pull_rt_task(struct rq *this_rq)
 {
+	BUG_ON(is_dl_group(&this_rq->rt));
+
 	int this_cpu = this_rq->cpu, cpu;
 	bool resched = false;
 	struct task_struct *p, *push_task;
@@ -1708,6 +1763,446 @@ static void pull_rt_task(struct rq *this_rq)
 		resched_curr(this_rq);
 }
 
+#ifdef CONFIG_RT_GROUP_SCHED
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
+{
+	BUG_ON(!is_dl_group(rt_rq));
+
+	struct rq *rq = rq_of_rt_rq(rt_rq);
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
+
+		return 0;
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
+
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
+			if (src_rq->curr->sched_task_group == this_rt_rq->tg &&
+			    p->prio < src_rq->curr->prio)
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
+}
+
+static void group_push_rt_tasks(struct rt_rq *rt_rq)
+{
+	while (group_push_rt_task(rt_rq, false))
+		;
+}
+
+static void group_push_rt_tasks_callback(struct rq *global_rq)
+{
+	struct rt_rq *rt_rq = &global_rq->rq_to_push_from->rt;
+
+	BUG_ON(global_rq->rq_to_push_from == NULL);
+	BUG_ON(rt_rq->rq != global_rq);
+
+	if ((rt_rq->rt_nr_running > 1) ||
+	    (dl_group_of(rt_rq)->dl_throttled == 1)) {
+
+		while (group_push_rt_task(rt_rq, false))
+			;
+	}
+
+	global_rq->rq_to_push_from = NULL;
+}
+
+static void group_pull_rt_task_callback(struct rq *global_rq)
+{
+	struct rt_rq *rt_rq = &global_rq->rq_to_pull_to->rt;
+
+	BUG_ON(global_rq->rq_to_pull_to == NULL);
+	BUG_ON(rt_rq->rq != global_rq);
+
+	group_pull_rt_task(rt_rq);
+	global_rq->rq_to_pull_to = NULL;
+}
+#else /* CONFIG_RT_GROUP_SCHED */
+static void group_pull_rt_task(struct rt_rq *this_rt_rq) { }
+static void group_push_rt_tasks(struct rt_rq *rt_rq) { }
+#endif /* CONFIG_RT_GROUP_SCHED */
+
 /*
  * If we are not running and we are not going to reschedule soon, we should
  * try to push tasks away now
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 55631d93e02..4e287aaa72f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1282,6 +1282,16 @@ struct rq {
 	call_single_data_t	cfsb_csd;
 	struct list_head	cfsb_csd_list;
 #endif
+
+#ifdef CONFIG_RT_GROUP_SCHED
+	/*
+	 * Balance callbacks operate only on global runqueues.
+	 * These pointers allow referencing cgroup specific runqueues
+	 * for balancing operations.
+	 */
+	struct rq		*rq_to_push_from;
+	struct rq		*rq_to_pull_to;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.51.0



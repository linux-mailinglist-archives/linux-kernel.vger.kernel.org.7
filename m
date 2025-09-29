Return-Path: <linux-kernel+bounces-836026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56EBA8975
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0FF189DF1E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062B2C376B;
	Mon, 29 Sep 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+QECEvO"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF152C15BC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137756; cv=none; b=uT36RWpt/k/PDuB58+n7+xYqsCKkh2V/I/Mn7h+PCoc1dSjOYFoA4TvJGVs4zBriaut3Kt+VtuiZHuiu0zVE4nJcLYkCT+NTQ81eY2WrRL10Y/vYOM72Lam2+eXpNWZA0u42H7Lrg/fQTd3wa6soMU8tIuiG6fL9BC80MYaAUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137756; c=relaxed/simple;
	bh=BwH/PxaUKt6ws7RHR35k6Zp2DnWln8HMf2+ObNT5XMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXq9gB9ISccGZoB43zbuwAYhSEyvJpUyvI3QUJQ3yQczkh0EwdJL6b3yMb5oW+y9MuUcnGdDtUl6+sVy+GY7UM31sEKgcJ6K+1k9rJpZoOed81YE5l3lAfwaAxxTCFF2raESEtwLpdiBBhyy5X4fDBD6wWLkH2MsMBGvPwlK3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+QECEvO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fc2d92d34so7980172a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137752; x=1759742552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q0EwLJfZBwPemnG8QeZQUc6RbkgXm11UO0MNIXaVYo=;
        b=P+QECEvO1hdPs7RosuYOKFsLZTbx7C9oju/YhK9uAjlULn/TCj+tg0Ti4vyJiS7CAr
         WBITf3KlDbjy76i/CXTJMML1rPKzZGcX2Cu5Lel03PTfs/ZdULgJ+HYaAQgsDSGeApJY
         fcJyg/aKU9guov9N4owqDRWpKCmMupM4b63mO5huvik04MLdNONJm5TCO2tP9wsMtCyA
         xyCo8M/7K/6sfOEqMgfQeFQvd/YP4VOnrwhy/Zu3wzS4xbo8+lts7BN4+Xc1q8YuwhTg
         Rq2L14l+PHb4xEOd73f8cxWcLPt7ELfKQ6dK8c7s4Vf2B59lsDqQG8RAyyiS63EhJFez
         06TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137752; x=1759742552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Q0EwLJfZBwPemnG8QeZQUc6RbkgXm11UO0MNIXaVYo=;
        b=QVwvnoRb4giz7Kjm9zP2x1MyVnaR9VwC8IIWyAVtvoaFOHVK/UVR9d1hyKiCbwBfxe
         QIBdHvQ0OuS+x9FvsTkSK2r/AuK7dFUO2J5swNfEKscfUftLO4uKCNtdzoyg89pREo32
         nq9apKMkAlidnLxnnvBQyHfnTxXuKtrSDa7h1LsYRoyp68G7y/XMF7CG5myRniGy3cHR
         Q5DZsTSRyJvt6lKlb5l9nqwrWPJ1/Sn7yY2MTU7Uqgq22myjj2Jh8Tzro/0s3o36Qs6M
         Ezl/Be4sJ1fsGYtqksTdeTc4oLFFXmAnhecOnQXThCDN0kld+oHyYbgyDpI4WOpNDHja
         6WAA==
X-Gm-Message-State: AOJu0YzmgNbBc2Nxueksjkf9XzFN348LtchV0DUqefemq4CUOMmjiGkX
	igCWmnlLWCqEh9P8xSSPHHRsm7w8wv53p89HIamtTMLPTVT/ITiI1ulA
X-Gm-Gg: ASbGnctzW6GY+nKTVGXdh0X266bwpyjMuuWGHyT7jVAX9LePohMeg5eVnH4cGT8cI45
	rrbNJq3mtgdn0obkVqM8zpAuuJSrpy1iiCLT7wVJWZWcxC3iZj2L8307b3jpkDxrZjX5v8zmhuz
	re4vOwJGpi0Y3P27AqLwXgBVxcirQVPcw3f8HIsT4K70wWzXm2aIlyUxRhfSivVNrLv3+yDVkZ1
	xlrnOhhaQxQ2jVxuxZThILqChU1OYnd8QyQDu/vt3pKO4BjKJdcLJiJ+0atbAEB2AYOX7x1dA/r
	b9QqoDexLQDwlRz4WvtTL4FdbZMS6Dctj28qqPl96Y4/2paDyDz8tqlH62+mAzJIVOTKadIQV1V
	Url8YjY3eNeqLM5OCHyw=
X-Google-Smtp-Source: AGHT+IG6Ja8q+uUOfXqXgMp6HaNsgVjHaNzUOnk5CK5fJWUFd3O1nCODhM1aQM2bbdLHZWvGNr763A==
X-Received: by 2002:a17:907:9446:b0:b04:aa9d:2240 with SMTP id a640c23a62f3a-b34bde135e3mr1686360266b.39.1759137752416;
        Mon, 29 Sep 2025 02:22:32 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:32 -0700 (PDT)
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
Subject: [RFC PATCH v3 12/24] sched/rt: Update task event callbacks for HCBS scheduling
Date: Mon, 29 Sep 2025 11:22:09 +0200
Message-ID: <20250929092221.10947-13-yurand2000@gmail.com>
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

Update wakeup_preempt_rt, switched_{from/to}_rt and prio_changed_rt with
rt-cgroup's specific preemption rules.
Add checks whether a rt-task can be attached or not to a rt-cgroup.
Update task_is_throttled_rt for SCHED_CORE.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/rt.c       | 88 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/syscalls.c | 13 ++++++
 3 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e5b4facee24..2cfbe3b7b17 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9346,7 +9346,7 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		goto scx_check;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		if (!sched_rt_can_attach(css_tg(css), task))
+		if (rt_task(task) && !sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
 	}
 scx_check:
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index d9442f64c6b..ce114823fe7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -946,6 +946,50 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct task_struct *donor = rq->donor;
 
+	if (!rt_group_sched_enabled())
+		goto no_group_sched;
+
+	/*
+	 * Preemption checks are different if the waking task and the current
+	 * task are running on the global runqueue or in a cgroup.
+	 * The following rules apply:
+	 *   - dl-tasks (and equally dl_servers) always preempt FIFO/RR tasks.
+	 *     - if curr is inside a cgroup (i.e. run by a dl_server) and
+	 *       waking is not, do nothing.
+	 *     - if waking is inside a cgroup but not curr, always reschedule.
+	 *   - if they are both on the global runqueue, run the standard code.
+	 *   - if they are both in the same cgroup, check for tasks priorities.
+	 *   - if they are both in a cgroup, but not the same one, check whether
+	 *     the woken task's dl_server preempts the current's dl_server.
+	 */
+	if (is_dl_group(rt_rq_of_se(&p->rt)) &&
+	    is_dl_group(rt_rq_of_se(&rq->curr->rt))) {
+		struct sched_dl_entity *woken_dl_se, *curr_dl_se;
+
+		woken_dl_se = dl_group_of(rt_rq_of_se(&p->rt));
+		curr_dl_se = dl_group_of(rt_rq_of_se(&rq->curr->rt));
+
+		if (rt_rq_of_se(&p->rt)->tg == rt_rq_of_se(&rq->curr->rt)->tg) {
+			if (p->prio < rq->curr->prio)
+				resched_curr(rq);
+
+			return;
+		}
+
+		if (dl_entity_preempt(woken_dl_se, curr_dl_se))
+			resched_curr(rq);
+
+		return;
+
+	} else if (is_dl_group(rt_rq_of_se(&p->rt))) {
+		resched_curr(rq);
+		return;
+
+	} else if (is_dl_group(rt_rq_of_se(&rq->curr->rt))) {
+		return;
+	}
+
+no_group_sched:
 	if (p->prio < donor->prio) {
 		resched_curr(rq);
 		return;
@@ -1705,6 +1749,8 @@ static void rq_offline_rt(struct rq *rq)
  */
 static void switched_from_rt(struct rq *rq, struct task_struct *p)
 {
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
+
 	/*
 	 * If there are other RT tasks then we will reschedule
 	 * and the scheduling of the other RT tasks will handle
@@ -1712,10 +1758,11 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	 * we may need to handle the pulling of RT tasks
 	 * now.
 	 */
-	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
+	if (!task_on_rq_queued(p) || rt_rq->rt_nr_running)
 		return;
 
-	rt_queue_pull_task(rt_rq_of_se(&p->rt));
+	if (!IS_ENABLED(CONFIG_RT_GROUP_SCHED))
+		rt_queue_pull_task(rt_rq);
 }
 
 void __init init_sched_rt_class(void)
@@ -1750,8 +1797,17 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 * then see if we can move to another run queue.
 	 */
 	if (task_on_rq_queued(p)) {
+
+#ifndef CONFIG_RT_GROUP_SCHED
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rt_rq_of_se(&p->rt));
+#else
+		if (rt_rq_of_se(&p->rt)->overloaded) {
+		} else {
+			if (p->prio < rq->curr->prio)
+				resched_curr(rq);
+		}
+#endif
 		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
@@ -1764,6 +1820,8 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 static void
 prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 {
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
+
 	if (!task_on_rq_queued(p))
 		return;
 
@@ -1772,16 +1830,25 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * If our priority decreases while running, we
 		 * may need to pull tasks to this runqueue.
 		 */
-		if (oldprio < p->prio)
-			rt_queue_pull_task(rt_rq_of_se(&p->rt));
+		if (!IS_ENABLED(CONFIG_RT_GROUP_SCHED) && oldprio < p->prio)
+			rt_queue_pull_task(rt_rq);
 
 		/*
 		 * If there's a higher priority task waiting to run
 		 * then reschedule.
 		 */
-		if (p->prio > rq->rt.highest_prio.curr)
+		if (p->prio > rt_rq->highest_prio.curr)
 			resched_curr(rq);
 	} else {
+		/*
+		 * This task is not running, thus we check against the currently
+		 * running task for preemption. We can preempt only if both tasks are
+		 * in the same cgroup or on the global runqueue.
+		 */
+		if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) &&
+		    rt_rq_of_se(&p->rt)->tg != rt_rq_of_se(&rq->curr->rt)->tg)
+			return;
+
 		/*
 		 * This task is not running, but if it is
 		 * greater than the current running task
@@ -1876,7 +1943,16 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 #ifdef CONFIG_SCHED_CORE
 static int task_is_throttled_rt(struct task_struct *p, int cpu)
 {
+#ifdef CONFIG_RT_GROUP_SCHED
+	struct rt_rq *rt_rq;
+
+	rt_rq = task_group(p)->rt_rq[cpu];
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
+
+	return dl_group_of(rt_rq)->dl_throttled;
+#else
 	return 0;
+#endif
 }
 #endif /* CONFIG_SCHED_CORE */
 
@@ -2131,7 +2207,7 @@ static int sched_rt_global_constraints(void)
 int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 {
 	/* Don't accept real-time tasks when there is no way for them to run */
-	if (rt_group_sched_enabled() && rt_task(tsk) && tg->rt_bandwidth.rt_runtime == 0)
+	if (rt_group_sched_enabled() && tg->dl_bandwidth.dl_runtime == 0)
 		return 0;
 
 	return 1;
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 93a9c03b28e..71f20be6f29 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -626,6 +626,19 @@ int __sched_setscheduler(struct task_struct *p,
 change:
 
 	if (user) {
+#ifdef CONFIG_RT_GROUP_SCHED
+		/*
+		 * Do not allow real-time tasks into groups that have no runtime
+		 * assigned.
+		 */
+		if (rt_group_sched_enabled() &&
+				dl_bandwidth_enabled() && rt_policy(policy) &&
+				!sched_rt_can_attach(task_group(p), p) &&
+				!task_group_is_autogroup(task_group(p))) {
+			retval = -EPERM;
+			goto unlock;
+		}
+#endif
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
 				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
 			cpumask_t *span = rq->rd->span;
-- 
2.51.0



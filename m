Return-Path: <linux-kernel+bounces-751972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42EB16FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA0A17BC8A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADB2C3252;
	Thu, 31 Jul 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3TpfjXn"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0E2C08C1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959359; cv=none; b=bBEfz6jD4ALOXLXoPnrpouPsejlhujKQVKsPaOxgZCD1QCmQ4mhvbIN3vFeIkGqycqXO+ZLhCH0dZBEH5RYvLMBrCbmjbCincvUG5GIr4aOoOkH3OGqcbHKV8/pIU74fVCu9WNkL+vc3WYkjyDsvkWu8Px9ZRA8wo1dfyl7vijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959359; c=relaxed/simple;
	bh=AVckV5NwmShnHX3/Ld3i0C0oi6LECmS+Pgn/BVXJQn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8MSnQDM1jSThfvZWJHupGEwQfPifpQ9JsEx/TDXCHDI5mDUuvlJcQYpff417Gk2Jqum4rLg04ChmY5mlgLn5P1NBDiKrSUEn8YX5o684AovIu7KPD1thej3zpmXUDLcUqWuqaRy+1S7wHBA3lfdVPtuMjZKIeI4xobZ3Sf4eB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3TpfjXn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7823559a5so488521f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959355; x=1754564155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJBdY2a1s0dCZdurrikDScRYILWYnnIvEZxcIlp4hRs=;
        b=S3TpfjXnwP1n8FzSwtTrnmSrn5NZJZxWsySAu9kzJzDj2EBKx6aZ3u2/9A8kDH7Fpq
         dKEn8zPV+l8tRYTm2TuEH721QB7hKOqwg+fHk/4qjxrRypJbxtvsHsiLjNhgKoOM+pnF
         pZ+FQzcKkMYhVxG9tVkvQXbC3fCqdSzmVnz47s9O0bcUr0UjLCHhpjU8exhp8dEWjhxQ
         KKCrCK7BjoSPEVmZn7WX+cr6m8XUzweRozVny/QcsK8JDuj4ub+sEY2AHTPZUvOiejEV
         sDZAqhMzrO2FtVRbOLRNmhM5ZewGsKqIZ9tqxzCPVyjRdNfJt6rCED5MaLxaPC/G/neD
         ecpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959355; x=1754564155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJBdY2a1s0dCZdurrikDScRYILWYnnIvEZxcIlp4hRs=;
        b=uYAJqZ4xnX/NvFAMRf6JVKgseMVHx2oXhs4gPHhE4CVls2bHUV6GatL8gF1YGdQROJ
         BtxiOZN1pyX6KVqj6FtngdZwORS2xxeGhR8TIFosczz/Ll4r/rUTV3GKRgU/BB+noQAc
         V1yTgeBhkJ0GVQP53b0kwUYzMZE+H6LSMfC6m86/yjyarNeicbyhF1jUSwnDjTHIsfic
         dsaKWdHXzcdaQIVAiQkOTBlYVW/h3SlALFX2qI0ebJHE4yqD6zY/uHLbyOaTD/GiFI0m
         5QOlLy/MoTyzyIqSn9XEVm/RNOjviYqq5zeovSuU6F1reWa3N18M34ADl8kujAwM6MLN
         KPmA==
X-Gm-Message-State: AOJu0YxgqiIK82NbK1qf8nVdJhR9tLPdG3ZbfeW+ZWhO/nkB+fE9oDpK
	pTN8EqllE+aCMPJkHAj6fJyW6I4fPO1QCNADThwqkVw72ZJLAvxoqKya
X-Gm-Gg: ASbGncvEueUieyvfqPihRxkFOMske+FjB9eAkN4rKbtnmvdUvnmRuHTX7sJli3ZvEhl
	jQjhNR57M6euPgMdoyP/DpShYWw2Gi/Ouck26Ugib1feit23DdP6liaHLDeotojZQpjXKf40ESo
	5MkpWZhwpkptGfp/SJVmyl5/4u3yM+tRcsO2GmPB7hVolFPq/dSgkMoHBORM1uwPbNte165rSaU
	2dtAgcN62dIEnov3wjLjGAptQu/Be9fsgs1pcwv4+/qUHu/sENJUeKc+pDwUHYKfFol/eXGovct
	C0yGzjzvRr+yuAZVoF8TsX/Ew63H+Oey1ydjIac9WycGt3LHbYUVY91kiyoAGifswjs+bSc462P
	VfYDUjRR1ItBej+FLftw=
X-Google-Smtp-Source: AGHT+IHHCwhtDRLgfAHxopC2dYxs4PgDo3S+VW/1bljunXIHJUQIPFl4YAQ22KG1t3RIjmPSR9VMzQ==
X-Received: by 2002:a05:6000:2008:b0:3b7:931d:379a with SMTP id ffacd0b85a97d-3b79503d691mr4575955f8f.58.1753959354901;
        Thu, 31 Jul 2025 03:55:54 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:54 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/25] sched/rt: Add HCBS related checks and operations for rt tasks
Date: Thu, 31 Jul 2025 12:55:31 +0200
Message-ID: <20250731105543.40832-14-yurand2000@gmail.com>
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

Add checks wheter a task belongs to the root cgroup or a rt-cgroup, since HCBS
reuses the rt classes' scheduler, and operate accordingly where needed.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/core.c     |   3 +
 kernel/sched/deadline.c |  16 ++++-
 kernel/sched/rt.c       | 147 +++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h    |   6 +-
 kernel/sched/syscalls.c |  13 ++++
 5 files changed, 171 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a69cb906c3..6173684a02b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2196,6 +2196,9 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct task_struct *donor = rq->donor;
 
+	if (is_dl_group(rt_rq_of_se(&p->rt)) && task_has_rt_policy(p))
+		resched_curr(rq);
+
 	if (p->sched_class == donor->sched_class)
 		donor->sched_class->wakeup_preempt(rq, p, flags);
 	else if (sched_class_above(p->sched_class, donor->sched_class))
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 264838c4a85..b948000f29f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1866,7 +1866,13 @@ void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 	u64 deadline = dl_se->deadline;
 
 	dl_rq->dl_nr_running++;
-	add_nr_running(rq_of_dl_rq(dl_rq), 1);
+	if (!dl_server(dl_se) || dl_se == &rq_of_dl_rq(dl_rq)->fair_server) {
+		add_nr_running(rq_of_dl_rq(dl_rq), 1);
+	} else {
+		struct rt_rq *rt_rq = &dl_se->my_q->rt;
+
+		add_nr_running(rq_of_dl_rq(dl_rq), rt_rq->rt_nr_running);
+	}
 
 	inc_dl_deadline(dl_rq, deadline);
 }
@@ -1876,7 +1882,13 @@ void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
 	WARN_ON(!dl_rq->dl_nr_running);
 	dl_rq->dl_nr_running--;
-	sub_nr_running(rq_of_dl_rq(dl_rq), 1);
+	if (!dl_server(dl_se) || dl_se == &rq_of_dl_rq(dl_rq)->fair_server) {
+		sub_nr_running(rq_of_dl_rq(dl_rq), 1);
+	} else {
+		struct rt_rq *rt_rq = &dl_se->my_q->rt;
+
+		sub_nr_running(rq_of_dl_rq(dl_rq), rt_rq->rt_nr_running);
+	}
 
 	dec_dl_deadline(dl_rq, dl_se->deadline);
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9c4ac6875a2..83695e11db4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -419,6 +419,7 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *donor = rq->donor;
+	struct rt_rq *rt_rq;
 	s64 delta_exec;
 
 	if (donor->sched_class != &rt_sched_class)
@@ -428,8 +429,18 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	if (!rt_bandwidth_enabled())
+	if (!rt_group_sched_enabled())
 		return;
+
+	if (!dl_bandwidth_enabled())
+		return;
+
+	rt_rq = rt_rq_of_se(&donor->rt);
+	if (is_dl_group(rt_rq)) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		dl_server_update(dl_se, delta_exec);
+	}
 }
 
 static void
@@ -440,7 +451,7 @@ inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 	/*
 	 * Change rq's cpupri only if rt_rq is the top queue.
 	 */
-	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && &rq->rt != rt_rq)
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
 		return;
 
 	if (rq->online && prio < prev_prio)
@@ -455,7 +466,7 @@ dec_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 	/*
 	 * Change rq's cpupri only if rt_rq is the top queue.
 	 */
-	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && &rq->rt != rt_rq)
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
 		return;
 
 	if (rq->online && rt_rq->highest_prio.curr != prev_prio)
@@ -524,6 +535,15 @@ void inc_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	rt_rq->rr_nr_running += rt_se_rr_nr_running(rt_se);
 
 	inc_rt_prio(rt_rq, rt_se_prio(rt_se));
+
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq)) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		if (!dl_se->dl_throttled)
+			add_nr_running(rq_of_rt_rq(rt_rq), 1);
+	} else {
+		add_nr_running(rq_of_rt_rq(rt_rq), 1);
+	}
 }
 
 static inline
@@ -534,6 +554,15 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	rt_rq->rr_nr_running -= rt_se_rr_nr_running(rt_se);
 
 	dec_rt_prio(rt_rq, rt_se_prio(rt_se));
+
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq)) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		if (!dl_se->dl_throttled)
+			sub_nr_running(rq_of_rt_rq(rt_rq), 1);
+	} else {
+		sub_nr_running(rq_of_rt_rq(rt_rq), 1);
+	}
 }
 
 /*
@@ -715,6 +744,14 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	check_schedstat_required();
 	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
 
+	/* Task arriving in an idle group of tasks. */
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) &&
+	    is_dl_group(rt_rq) && rt_rq->rt_nr_running == 0) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		dl_server_start(dl_se);
+	}
+
 	enqueue_rt_entity(rt_se, flags);
 
 	if (task_is_blocked(p))
@@ -734,6 +771,14 @@ static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	dequeue_pushable_task(rt_rq, p);
 
+	/* Last task of the task group. */
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) &&
+	    is_dl_group(rt_rq) && rt_rq->rt_nr_running == 0) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		dl_server_stop(dl_se);
+	}
+
 	return true;
 }
 
@@ -891,6 +936,34 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct task_struct *donor = rq->donor;
 
+	if (!rt_group_sched_enabled())
+		goto no_group_sched;
+
+	if (is_dl_group(rt_rq_of_se(&p->rt)) &&
+	    is_dl_group(rt_rq_of_se(&rq->curr->rt))) {
+		struct sched_dl_entity *dl_se, *curr_dl_se;
+
+		dl_se = dl_group_of(rt_rq_of_se(&p->rt));
+		curr_dl_se = dl_group_of(rt_rq_of_se(&rq->curr->rt));
+
+		if (dl_entity_preempt(dl_se, curr_dl_se)) {
+			resched_curr(rq);
+			return;
+		} else if (!dl_entity_preempt(curr_dl_se, dl_se)) {
+			if (p->prio < rq->curr->prio) {
+				resched_curr(rq);
+				return;
+			}
+		}
+		return;
+	} else if (is_dl_group(rt_rq_of_se(&p->rt))) {
+		resched_curr(rq);
+		return;
+	} else if (is_dl_group(rt_rq_of_se(&rq->curr->rt))) {
+		return;
+	}
+
+no_group_sched:
 	if (p->prio < donor->prio) {
 		resched_curr(rq);
 		return;
@@ -1609,12 +1682,36 @@ static void pull_rt_task(struct rq *this_rq)
 		resched_curr(this_rq);
 }
 
+#ifdef CONFIG_RT_GROUP_SCHED
+static int group_push_rt_task(struct rt_rq *rt_rq)
+{
+	struct rq *rq = rq_of_rt_rq(rt_rq);
+
+	if (is_dl_group(rt_rq))
+		return 0;
+
+	return push_rt_task(rq, false);
+}
+
+static void group_push_rt_tasks(struct rt_rq *rt_rq)
+{
+	while (group_push_rt_task(rt_rq))
+		;
+}
+#else
+static void group_push_rt_tasks(struct rt_rq *rt_rq)
+{
+	push_rt_tasks(rq_of_rt_rq(rt_rq));
+}
+#endif
+
 /*
  * If we are not running and we are not going to reschedule soon, we should
  * try to push tasks away now
  */
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
 	bool need_to_push = !task_on_cpu(rq, p) &&
 			    !test_tsk_need_resched(rq->curr) &&
 			    p->nr_cpus_allowed > 1 &&
@@ -1623,7 +1720,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 			     rq->donor->prio <= p->prio);
 
 	if (need_to_push)
-		push_rt_tasks(rq);
+		group_push_rt_tasks(rt_rq);
 }
 
 /* Assumes rq->lock is held */
@@ -1632,6 +1729,7 @@ static void rq_online_rt(struct rq *rq)
 	if (rq->rt.overloaded)
 		rt_set_overload(rq);
 
+	/*FIXME: Enable the dl server! */
 	cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio.curr);
 }
 
@@ -1641,6 +1739,7 @@ static void rq_offline_rt(struct rq *rq)
 	if (rq->rt.overloaded)
 		rt_clear_overload(rq);
 
+	/* FIXME: Disable the dl server! */
 	cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_INVALID);
 }
 
@@ -1650,6 +1749,8 @@ static void rq_offline_rt(struct rq *rq)
  */
 static void switched_from_rt(struct rq *rq, struct task_struct *p)
 {
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
+
 	/*
 	 * If there are other RT tasks then we will reschedule
 	 * and the scheduling of the other RT tasks will handle
@@ -1657,10 +1758,11 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	 * we may need to handle the pulling of RT tasks
 	 * now.
 	 */
-	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
+	if (!task_on_rq_queued(p) || rt_rq->rt_nr_running)
 		return;
 
-	rt_queue_pull_task(rq);
+	if (!IS_ENABLED(CONFIG_RT_GROUP_SCHED))
+		rt_queue_pull_task(rq);
 }
 
 void __init init_sched_rt_class(void)
@@ -1695,8 +1797,17 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 * then see if we can move to another run queue.
 	 */
 	if (task_on_rq_queued(p)) {
+
+#ifndef CONFIG_RT_GROUP_SCHED
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
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
@@ -1709,6 +1820,8 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 static void
 prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 {
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
+
 	if (!task_on_rq_queued(p))
 		return;
 
@@ -1717,16 +1830,25 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * If our priority decreases while running, we
 		 * may need to pull tasks to this runqueue.
 		 */
-		if (oldprio < p->prio)
+		if (!IS_ENABLED(CONFIG_RT_GROUP_SCHED) && oldprio < p->prio)
 			rt_queue_pull_task(rq);
 
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
@@ -1821,7 +1943,16 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
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
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 611e3757fea..8bf8af7064f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2171,7 +2171,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 	if (!rt_group_sched_enabled())
 		tg = &root_task_group;
 	p->rt.rt_rq  = tg->rt_rq[cpu];
-	p->rt.parent = tg->rt_se[cpu];
+	p->dl.dl_rq  = &cpu_rq(cpu)->dl;
 #endif /* CONFIG_RT_GROUP_SCHED */
 }
 
@@ -2727,6 +2727,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 static inline void sub_nr_running(struct rq *rq, unsigned count)
 {
+	BUG_ON(rq->nr_running < count);
 	rq->nr_running -= count;
 	if (trace_sched_update_nr_running_tp_enabled()) {
 		call_trace_sched_update_nr_running(rq, -count);
@@ -3057,9 +3058,6 @@ extern bool sched_smp_initialized;
 #ifdef CONFIG_RT_GROUP_SCHED
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_SCHED_DEBUG
-	WARN_ON_ONCE(rt_se->my_q);
-#endif
 	return container_of(rt_se, struct task_struct, rt);
 }
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 93a9c03b28e..7c1f7649477 100644
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
+				task_group(p)->dl_bandwidth.dl_runtime == 0 &&
+				!task_group_is_autogroup(task_group(p))) {
+			retval = -EPERM;
+			goto unlock;
+		}
+#endif
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
 				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
 			cpumask_t *span = rq->rd->span;
-- 
2.50.1



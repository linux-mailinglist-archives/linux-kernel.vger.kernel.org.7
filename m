Return-Path: <linux-kernel+bounces-836025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049FFBA8972
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C143B8231
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F5B2C2ABF;
	Mon, 29 Sep 2025 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWDcNhYh"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5662C11EE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137755; cv=none; b=EXT5O6nq3BXOpYnbd2iKt4n7qXDkcGNGsladLWhALotOCLqhLIEi3ms2osQjWRXBhKyVq0O82XjtTVftWkjnzmx7K+xzX5H4euCTVWST2ajVxhx+ZtmrZBs6mO0I78YKK9c6p1k0RBjRVsoS3vmuCtzwaeuYSavFY2UTWeGspLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137755; c=relaxed/simple;
	bh=V4wngCUgQ/YZWcT/RBmIppyvJKtBN2bYG/baemQJjbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky7648TudT1PWDrgtO7y5WvLmUYXKNgGngtI0rclHkD3dve7Y20bQzYv+M0In8RgB5YnvwkyBfMvXsxVVU57fJgt690/yiPzQWxVBZz0fr1uPDlJiz6PLtXGoQ0UmRwgiQnGvZRdsIc7SVPXE3OTZV5vQZJF/4X7skqZ/8r1KCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWDcNhYh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3727611d76so593431666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137752; x=1759742552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dKw2ZUbysIQMVVKyG+B5HZc8IIYQ0mINr1zfzu0iXM=;
        b=SWDcNhYhvrxrRzjdpwBr/m/NXcVNRsBtbZMbBrzERB0frDXjwMt7/Vo8bjbgWWxe5u
         sIhkkPzDlkqs+lFuPQKXqmpcPGqMdvorfXeO0xATJZ4eeeyqezwESbofPZAkQ7lwlRpc
         57pTiv+I62f9fqyCCwtvATKt/zqj3YVjKDytgOdFD5xLfK03W9ouSIiMRbHyG0e2JB7/
         jfDwk9vXaRjWJicWAL4HrvS2bbAuOqkIH7j3W7RmrYaTbZ18UPqb+SXAO0fqR9YmINLQ
         lagyihkL3YwuyQnq//T6BvTCbSOCsx5xYLFGPdM7QQLKOse/JYNhTvwq8zecA2fZPw2j
         yyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137752; x=1759742552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dKw2ZUbysIQMVVKyG+B5HZc8IIYQ0mINr1zfzu0iXM=;
        b=i7XX5bJiGM86ptjQl9vte+kSEX2MVi4lxy4gqpPYsXupFalsDTXEy17PNXXj6IjNNH
         /K5QXMCq888Wivv/SAtOfnJ7wBtcmCEG52ahzh2IWZMjVeIYz02MdxE+Otn9GRf07Hp7
         ygMtzzmczTPjz1JODhCVnOB6NffQ2CcwUGLFWCIPzG3WGAPVXTbU3YwbbCtjeU3ab2+m
         /uRUamOtT7WcBPeNYp2SJsPkMC6dkeQF6Asjp5ZCs8XnF/QnxXSETeamEnF7zP5xJkur
         qsUclrGCyeS+i+MYeemDBlcGIxFfIIMe9Ix57B05v5RcEAmLlpP+p5st6ukKWFW5/4TR
         9QzA==
X-Gm-Message-State: AOJu0Yxpqt71g2YkIXy2rM5SkDOUbgVoxPpecPsHImNV2HML96C2rOAc
	dmxnNfjDEeRx4uI1PjUJOO8Si/m2r5RSu/WAlAcXykqqYvN1JC127t/m
X-Gm-Gg: ASbGnctOVT55TXLoQoALga48BNgouXdXODHbNg6ezm5y6KqR8Q5dPr8j4fwJh4M0nVT
	qWt7TWtzKCHwa5e+OYjreH3+dOtJfo1zUQecXMLaNV03SwKz8rGYRTxt1GSjAOInJ9eah0NCEjD
	Mwq9grr3MJZ7QWNLar0L6+3NKfLEp+lwVAoNHQ8i8j34v0v4R+sSbfXkn9AulgrWR8IN/swrWln
	Rpq43BUSYYC4uiLfftaZjr/9Za8xVhqJS2xe6+H+fR+CrZSWBbV+DcMvqnN7aC8i4gefBlWBbE2
	iX2L2k3fcHLw3l1y+NYfM28wn5U/Asmv05J1ebxfjYvjC4IIvHZhDLIfQl6IjigjD/ER34R7R/I
	wW0IcAI6rTE7hPGh0vvXV8zJJolI+gZGrguxHeaOt
X-Google-Smtp-Source: AGHT+IGWOU4/onOPYt9ps0wf3cHeWpNMN3b9aoRdpnIwYN2/m2SasnTRFEqxZCFa27kB0CeiMFmK1A==
X-Received: by 2002:a17:907:1c15:b0:afe:87bd:da59 with SMTP id a640c23a62f3a-b34be2f5318mr1753833066b.42.1759137751408;
        Mon, 29 Sep 2025 02:22:31 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:31 -0700 (PDT)
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
Subject: [RFC PATCH v3 11/24] sched/rt: Add rt-cgroups' dl-servers operations.
Date: Mon, 29 Sep 2025 11:22:08 +0200
Message-ID: <20250929092221.10947-12-yurand2000@gmail.com>
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

Implement the servers' functions that pick the next eligible task to run.
Enable/Disable dl-servers on task enqueue/dequeue when necessary.
Update dl-servers on task update.
Account the number of active rt-tasks in the cgroups' specific runqueue.
Account the number of active rt-tasks on the global counter of active tasks when
a cgroup is enqueued/dequeued (dl-server started/stopped).
Update rq's cpuprio only if the cgroup's is root control group.
Record which dl_server is managing a task when it changes runqueue.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 16 ++++++---
 kernel/sched/rt.c       | 79 ++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h    |  3 +-
 3 files changed, 85 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 754bfe231b4..1293b9a252b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1869,9 +1869,13 @@ void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 	u64 deadline = dl_se->deadline;
 
 	dl_rq->dl_nr_running++;
-
-	if (!dl_server(dl_se))
+	if (!dl_server(dl_se)) {
 		add_nr_running(rq_of_dl_rq(dl_rq), 1);
+	} else if (dl_se != &rq_of_dl_rq(dl_rq)->fair_server) {
+		struct rt_rq *rt_rq = &dl_se->my_q->rt;
+
+		add_nr_running(rq_of_dl_rq(dl_rq), rt_rq->rt_nr_running);
+	}
 
 	inc_dl_deadline(dl_rq, deadline);
 }
@@ -1881,9 +1885,13 @@ void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
 	WARN_ON(!dl_rq->dl_nr_running);
 	dl_rq->dl_nr_running--;
-
-	if (!dl_server(dl_se))
+	if (!dl_server(dl_se)) {
 		sub_nr_running(rq_of_dl_rq(dl_rq), 1);
+	} else if (dl_se != &rq_of_dl_rq(dl_rq)->fair_server) {
+		struct rt_rq *rt_rq = &dl_se->my_q->rt;
+
+		sub_nr_running(rq_of_dl_rq(dl_rq), rt_rq->rt_nr_running);
+	}
 
 	dec_dl_deadline(dl_rq, dl_se->deadline);
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3094f59d0c8..d9442f64c6b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -144,14 +144,27 @@ void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
 	tg->dl_se[cpu] = dl_se;
 }
 
+static struct task_struct *_pick_next_task_rt(struct rt_rq *rt_rq);
+static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first);
+
 static bool rt_server_has_tasks(struct sched_dl_entity *dl_se)
 {
-	return false;
+	return !!dl_se->my_q->rt.rt_nr_running;
 }
 
 static struct task_struct *rt_server_pick(struct sched_dl_entity *dl_se)
 {
-	return NULL;
+	struct rt_rq *rt_rq = &dl_se->my_q->rt;
+	struct rq *rq = rq_of_rt_rq(rt_rq);
+	struct task_struct *p;
+
+	if (dl_se->my_q->rt.rt_nr_running == 0)
+		return NULL;
+
+	p = _pick_next_task_rt(rt_rq);
+	set_next_task_rt(rq, p, true);
+
+	return p;
 }
 
 int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
@@ -416,6 +429,7 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *donor = rq->donor;
+	struct rt_rq *rt_rq;
 	s64 delta_exec;
 
 	if (donor->sched_class != &rt_sched_class)
@@ -425,8 +439,18 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	if (!rt_bandwidth_enabled())
+	if (!rt_group_sched_enabled())
+		return;
+
+	if (!dl_bandwidth_enabled())
 		return;
+
+	rt_rq = rt_rq_of_se(&donor->rt);
+	if (is_dl_group(rt_rq)) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		dl_server_update(dl_se, delta_exec);
+	}
 }
 
 static void
@@ -437,7 +461,7 @@ inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 	/*
 	 * Change rq's cpupri only if rt_rq is the top queue.
 	 */
-	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && &rq->rt != rt_rq)
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
 		return;
 
 	if (rq->online && prio < prev_prio)
@@ -452,7 +476,7 @@ dec_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 	/*
 	 * Change rq's cpupri only if rt_rq is the top queue.
 	 */
-	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && &rq->rt != rt_rq)
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
 		return;
 
 	if (rq->online && rt_rq->highest_prio.curr != prev_prio)
@@ -521,6 +545,15 @@ void inc_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
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
@@ -531,6 +564,15 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
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
@@ -712,6 +754,14 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
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
@@ -731,6 +781,14 @@ static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
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
 
@@ -953,9 +1011,14 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 	return next;
 }
 
-static struct task_struct *_pick_next_task_rt(struct rq *rq)
+static struct task_struct *_pick_next_task_rt(struct rt_rq *rt_rq)
 {
-	return NULL;
+	struct sched_rt_entity *rt_se;
+
+	rt_se = pick_next_rt_entity(rt_rq);
+	BUG_ON(!rt_se);
+
+	return rt_task_of(rt_se);
 }
 
 static struct task_struct *pick_task_rt(struct rq *rq)
@@ -965,7 +1028,7 @@ static struct task_struct *pick_task_rt(struct rq *rq)
 	if (!sched_rt_runnable(rq))
 		return NULL;
 
-	p = _pick_next_task_rt(rq);
+	p = _pick_next_task_rt(&rq->rt);
 
 	return p;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9853f321363..b2c87541257 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2170,7 +2170,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 	if (!rt_group_sched_enabled())
 		tg = &root_task_group;
 	p->rt.rt_rq  = tg->rt_rq[cpu];
-	p->rt.parent = tg->rt_se[cpu];
+	p->dl.dl_rq  = &cpu_rq(cpu)->dl;
 #endif /* CONFIG_RT_GROUP_SCHED */
 }
 
@@ -2726,6 +2726,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 static inline void sub_nr_running(struct rq *rq, unsigned count)
 {
+	BUG_ON(rq->nr_running < count);
 	rq->nr_running -= count;
 	if (trace_sched_update_nr_running_tp_enabled()) {
 		call_trace_sched_update_nr_running(rq, -count);
-- 
2.51.0



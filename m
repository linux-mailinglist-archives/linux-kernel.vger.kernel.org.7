Return-Path: <linux-kernel+bounces-798906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757BEB42487
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C0C189894E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0024C31354F;
	Wed,  3 Sep 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NFRUAu5k"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB9320A15
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912191; cv=none; b=hVg7Rl3bkVff/SdfFx7LxSEfu4TTyJ6JR3+Om35ehTuA8GppEuAfHpBf7dDhYmgVoW4XA43+sx9W8WJ4K2N7Kf97mcVSt0UwjUrGHdO98PXL6wBiXLjFsD0zukwXP9p1lfjfuJRhAHLPsKo5NK9a1rRZkwFIExYJ9TFEMJMoPHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912191; c=relaxed/simple;
	bh=qLecQka6HFxLzOrBlZFfGTh062nsD3HVcEENONBoVb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBKRFrossFDbwtwTyz7v6+mHsx1BrHikzIa8QDAdqH2nXtcJZVh2uwU7hIEu+qO2cDvXKMNb3gDbOfOPbwdKlGmKRkbprx1y4bd2KULTwg+/hic7nnhln7C3n5rDuNg2/4lcHIH1i80uXfSRg0R4X0MtoXjW9wq4u7cr41nlz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NFRUAu5k; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756912185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z8AV0OJds+fFH71HcwghCBdJfs0C/HrPFWiOzLPMsfE=;
	b=NFRUAu5kkMaTQEbhf78td4dSfU4W0yom7HwQz5aOchScrzZ7DYNhqRHsifdS/4vELbSb6z
	dIRpSYU8ZxKtjBNFyLSvmGpeq/xzsXDIj/v/VgPW3ihbZmsiqcYOuRlCcJP+B8Mn4cjkdE
	fU49pe616WukmMiSgEmHWLaTIkjGPCk=
From: Yajun Deng <yajun.deng@linux.dev>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] sched/rt: pass rq and task_struct pointers to update_stats functions
Date: Wed,  3 Sep 2025 15:08:24 +0000
Message-ID: <20250903150824.16960-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

These __update_stats functions only require the rq and task_struct
parameters. All update_stats functions convert the rt_rq to rq and the
rt_se to task_struct. And all callers of update_stats will get the
rt_rq from the rq and the rt_se from the task_struct.

The rq_of_rt_rq() always returns the top-level rq, which is unique for
each CPU. The rt_task_of() is only available for the task_struct. They
are doing the convering and being converted. However, these conversions
don't change anything.

Just pass the rq and task_struct pointers to these update_stats functions.
If it don't have a task_struct pointer, call rt_entity_is_task() to ensure
the task isn't NULL.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/rt.c | 91 ++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 73 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 390f3d08abbe..feef4508efca 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1212,107 +1212,56 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
 	rt_se->on_list = 0;
 }
 
-static inline struct sched_statistics *
-__schedstats_from_rt_se(struct sched_rt_entity *rt_se)
-{
-	/* schedstats is not supported for rt group. */
-	if (!rt_entity_is_task(rt_se))
-		return NULL;
-
-	return &rt_task_of(rt_se)->stats;
-}
-
 static inline void
-update_stats_wait_start_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+update_stats_wait_start_rt(struct rq *rq, struct task_struct *p)
 {
-	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
-
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
-	stats = __schedstats_from_rt_se(rt_se);
-	if (!stats)
-		return;
-
-	__update_stats_wait_start(rq_of_rt_rq(rt_rq), p, stats);
+	__update_stats_wait_start(rq, p, &p->stats);
 }
 
 static inline void
-update_stats_enqueue_sleeper_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+update_stats_enqueue_sleeper_rt(struct rq *rq, struct task_struct *p)
 {
-	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
-
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
-	stats = __schedstats_from_rt_se(rt_se);
-	if (!stats)
-		return;
-
-	__update_stats_enqueue_sleeper(rq_of_rt_rq(rt_rq), p, stats);
+	__update_stats_enqueue_sleeper(rq, p, &p->stats);
 }
 
 static inline void
-update_stats_enqueue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
-			int flags)
+update_stats_enqueue_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (!schedstat_enabled())
-		return;
-
 	if (flags & ENQUEUE_WAKEUP)
-		update_stats_enqueue_sleeper_rt(rt_rq, rt_se);
+		update_stats_enqueue_sleeper_rt(rq, p);
 }
 
 static inline void
-update_stats_wait_end_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+update_stats_wait_end_rt(struct rq *rq, struct task_struct *p)
 {
-	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
-
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
-	stats = __schedstats_from_rt_se(rt_se);
-	if (!stats)
-		return;
-
-	__update_stats_wait_end(rq_of_rt_rq(rt_rq), p, stats);
+	__update_stats_wait_end(rq, p, &p->stats);
 }
 
 static inline void
-update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
-			int flags)
+update_stats_dequeue_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	struct task_struct *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
 	if ((flags & DEQUEUE_SLEEP) && p) {
 		unsigned int state;
 
 		state = READ_ONCE(p->__state);
 		if (state & TASK_INTERRUPTIBLE)
-			__schedstat_set(p->stats.sleep_start,
-					rq_clock(rq_of_rt_rq(rt_rq)));
+			__schedstat_set(p->stats.sleep_start, rq_clock(rq));
 
 		if (state & TASK_UNINTERRUPTIBLE)
-			__schedstat_set(p->stats.block_start,
-					rq_clock(rq_of_rt_rq(rt_rq)));
+			__schedstat_set(p->stats.block_start, rq_clock(rq));
 	}
 }
 
@@ -1392,7 +1341,8 @@ static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
-	update_stats_enqueue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+	if (rt_entity_is_task(rt_se))
+		update_stats_enqueue_rt(rq, rt_task_of(rt_se), flags);
 
 	dequeue_rt_stack(rt_se, flags);
 	for_each_sched_rt_entity(rt_se)
@@ -1404,7 +1354,8 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
-	update_stats_dequeue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+	if (rt_entity_is_task(rt_se))
+		update_stats_dequeue_rt(rq, rt_task_of(rt_se), flags);
 
 	dequeue_rt_stack(rt_se, flags);
 
@@ -1429,7 +1380,7 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 		rt_se->timeout = 0;
 
 	check_schedstat_required();
-	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
+	update_stats_wait_start_rt(rq_of_rt_se(rt_se), p);
 
 	enqueue_rt_entity(rt_se, flags);
 
@@ -1631,12 +1582,9 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
-	struct sched_rt_entity *rt_se = &p->rt;
-	struct rt_rq *rt_rq = &rq->rt;
-
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_rt_rq(&p->rt))
-		update_stats_wait_end_rt(rt_rq, rt_se);
+		update_stats_wait_end_rt(rq, p);
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
@@ -1702,11 +1650,8 @@ static struct task_struct *pick_task_rt(struct rq *rq)
 
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
-	struct sched_rt_entity *rt_se = &p->rt;
-	struct rt_rq *rt_rq = &rq->rt;
-
 	if (on_rt_rq(&p->rt))
-		update_stats_wait_start_rt(rt_rq, rt_se);
+		update_stats_wait_start_rt(rq, p);
 
 	update_curr_rt(rq);
 
-- 
2.25.1



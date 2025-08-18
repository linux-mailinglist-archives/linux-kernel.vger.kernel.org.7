Return-Path: <linux-kernel+bounces-772935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7170B29989
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B7B7B064C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0FE2737FD;
	Mon, 18 Aug 2025 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YJs+Qs9z"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C214AD0D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497859; cv=none; b=AhGIuAdQjhSeEGBmiQXAi7r9vU2uszAH6vPO8mjS33m6CzAYWNetCMmcNR1dzYgAuXmzFXXSCkPI/hYToNeN3C+GvztFd8Zq+PlPRgNO5zlGiHILByWGtFXluMe5ysl1SAyzsiu78Ki4P8nwX7U2kQBss9BpRIB/y7K9pZlSxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497859; c=relaxed/simple;
	bh=MY6dzYdagwYzeWEpTKZpLiO8Q62k/HWkvf1Bl9993zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZtNohSryGxTdgIiKuWn5kvQi8wZ6QLWSQMuNCyu0x7/x8iPDXN2bYDd447bMW0AIiVVsnrAs9UzbLNAAkkOVcIfPNaTE8+GWHnf96RZP0KBc0seEGSEinMucjJk26maebYJmQm7DxLmvB1N0Ff4OkMa91vFPkA0xeU9Jwm4lA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YJs+Qs9z; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755497852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gLzRYaKFgcfr4F1dDlIXhotX6yn+7RtW4XXeXfTA+SU=;
	b=YJs+Qs9zh5m9yWLJlZev7jg96B/B9hPQxW3DjXy/YsB1uhtH17YF+AaQVDWzy4kgBwRsuQ
	PKmjzNT73Azer2k6pVLvxYn9wIKwPiGn/ZoEfHfKUdZTpu1/S7gZPWP0R4+bgR7BYEratU
	eUgXQvWh9iqaEbhtq3W00YWHz6vKgyk=
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
Subject: [PATCH] sched/rt: Remove the unnecessary CONFIG_RT_GROUP_SCHED
Date: Mon, 18 Aug 2025 14:17:16 +0800
Message-Id: <20250818061716.1168820-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

After commit 5f6bd380c7bd ("sched/rt: Remove default bandwidth control"),
these bandwidth control members are only initialized when
CONFIG_RT_GROUP_SCHED is enabled.

Remove the unnecessary CONFIG_RT_GROUP_SCHED from init_rt_rq() and
initialize the members in init_tg_rt_entry().

In sched_init(), the rt_runtime of rt_bandwidth will be initialized by
global_rt_runtime(), so we can unify the rt_runtime of rt_rq by it in
init_tg_rt_entry().

Also, remove the unnecessary CONFIG_RT_GROUP_SCHED in rt_se_prio().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/core.c |  6 ------
 kernel/sched/rt.c   | 17 +++++------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..e9d6ceead9f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8772,12 +8772,6 @@ void __init sched_init(void)
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_RT_GROUP_SCHED
-		/*
-		 * This is required for init cpu because rt.c:__enable_runtime()
-		 * starts working after scheduler_running, which is not the case
-		 * yet.
-		 */
-		rq->rt.rt_runtime = global_rt_runtime();
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
 		rq->sd = NULL;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7936d4333731..390f3d08abbe 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -84,14 +84,6 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	plist_head_init(&rt_rq->pushable_tasks);
 	/* We start is dequeued state, because no RT tasks are queued */
 	rt_rq->rt_queued = 0;
-
-#ifdef CONFIG_RT_GROUP_SCHED
-	rt_rq->rt_time = 0;
-	rt_rq->rt_throttled = 0;
-	rt_rq->rt_runtime = 0;
-	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
-	rt_rq->tg = &root_task_group;
-#endif
 }
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -229,10 +221,14 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
+	rt_rq->rt_time = 0;
+	rt_rq->rt_throttled = 0;
 	rt_rq->rt_nr_boosted = 0;
+	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
+
 	rt_rq->rq = rq;
 	rt_rq->tg = tg;
+	rt_rq->rt_runtime = tg->rt_bandwidth.rt_runtime;
 
 	tg->rt_rq[cpu] = rt_rq;
 	tg->rt_se[cpu] = rt_se;
@@ -280,7 +276,6 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 			goto err_free_rq;
 
 		init_rt_rq(rt_rq);
-		rt_rq->rt_runtime = tg->rt_bandwidth.rt_runtime;
 		init_tg_rt_entry(tg, rt_rq, rt_se, i, parent->rt_se[i]);
 	}
 
@@ -957,12 +952,10 @@ static void __disable_runtime(struct rq *rq) { }
 
 static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_RT_GROUP_SCHED
 	struct rt_rq *rt_rq = group_rt_rq(rt_se);
 
 	if (rt_rq)
 		return rt_rq->highest_prio.curr;
-#endif
 
 	return rt_task_of(rt_se)->prio;
 }
-- 
2.25.1



Return-Path: <linux-kernel+bounces-751969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A1B16FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5337B3FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301CA2C08D9;
	Thu, 31 Jul 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4mXsLxU"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B162BEFF0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959356; cv=none; b=I4qPK4rmymUlPjf6YGvqyTQ56fKTYBG+WORXtbdG/kluu2Z2Af15FPeia+getTFIFm1WNUIRNTwbXW1g7ooBTOJY58waby/tkuD0ovdQtzmV6sRjKomrskVoFEEtfBbFO8rfq4biGrTQAXYtR+DaippBpc8ys079IZ35ykzl6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959356; c=relaxed/simple;
	bh=y/m1xuIauJkrYvt1YIYbjMXrR9vbZJTyFydAQZV8SOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUwVX4rHoSCuTD4Enq/A0fji/WRRE6QUwSiL51NG0daMPeBu6hN0RZG53O/DJYryNoBG/WpB4PjmTHdC7P5ryTsZuW9oXsk7Ojo/o1OoDZ+HyDfEWsvoCcORxoq7B1VtpYiRHqKZqp1Rq1pAhTkmCGP/qFW1Vu28+N6dV4jh8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4mXsLxU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso684277f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959352; x=1754564152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uyGZGqhZLBvXN5S0wAqgq7D0Qe29eTkjq/bpY1CEUY=;
        b=J4mXsLxUq71LfgkJOW0VGP7tSNK6Rxn4UAAiHkNniqTJE3Hz5p4TgaVL5mhYrd4hGL
         HavQh8KqIB66nS/JlF7DUTZsh4k4p4e0o5F8uaz92LpUERARr1t7ycJwBUJ/Tk1f9XDY
         7kgBZN24OpULlHE1pR7CzAAV0jVe9y2GjoP1ZRk8IPosI7n+yhvBIyV6AU4bgH5nE+bo
         0UwRg/rFXD7OJBfCkmJFOv2QNXw7Jzet8Yh1O9jY45okeOuB6eh5f6nj0fY3RA2vU3Jp
         YlW1CLDHaCtavPW4tsiOPR5dAyqZAEbQHWTHLepqEtWP6NRcV1+0EgDzv8Qm3Tt8ljYW
         yqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959352; x=1754564152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uyGZGqhZLBvXN5S0wAqgq7D0Qe29eTkjq/bpY1CEUY=;
        b=TiaPPkkPGuDBVtdNa8QEJbqqrnWmGwVz2nRi7hkzq6cugJuPDXTZ9d1/NhuAI5Ob65
         whnXufOIaYBzdB2HaIAypNsN/ejhsZBzvfkMvdriz9Yzvhfjp+XfVu4aScxe8BJ3Ge7l
         z31YvGonyjwD8yrYC8b1DJowZxdj43PNHgZhwtyuzkbruZAuvRlgT6PBj84svC0nUzme
         3xWIpVNQj7fVUbJ0Pu8ul0vGb0HmgnfZVyZn8iwiBm9it0OReFqe06DtRePtZCUz6d0v
         ihDhHM1881YrtedErHgXq8fwqEaj7/R8JBDjpUFsU6kR6OtG3FbjTURnqRt8aw6gM5Te
         5Nzw==
X-Gm-Message-State: AOJu0YyvA2ecuo/eh56MPiUywgBvFFfvn+Y60RQokI8yGAuRPgeSe9QS
	KmzIb/YxE1eF+3KBPuNEpPCNg1YbkfIxxruVZyNUagFtsQC98AnNPpW3
X-Gm-Gg: ASbGnctbNMOOBeKAToCn9tKWMB6d1v70K4w8m6phK95Bz2rqhNzcQJb5qL7SC5rJjh3
	OLFdEPaDxuF7wX1HSk2M3ExZJEr5B24L6TOA9QyWS0JVrDq1kFwOoUgknQjfMVVLO7XXw7TxZlc
	On4oj/UOGc5F36INjdol4WiWhSQWckQO6F3rzXXLiYhYBYe7H+ZbIhecxLndO5gEFkYOyC3K3rJ
	Ab/26KcuUhFs+ynKxIUbBchsUgkX5yKx5vgxlvOSpFnU6dl8vZ0msQF0iQlJqktBpShBWZb+/Dw
	KBnv2DfZiJDFEY7O/7+Jw0SyPTytBUFXk9aJnquUaAzLwZuZjBVpfXlqwSrpax7QtBUn1HSl249
	YXvj4dZ4tqMHCjUj4ij0ZXe2YlNC0Og==
X-Google-Smtp-Source: AGHT+IGvxapxj8Q5c8Lp8FXTmJ8VG/Tz+ri2W75A14HZcpDfDBCoBuLYrT8UVhnKqrBRMS8+t1zXPg==
X-Received: by 2002:a5d:64cd:0:b0:3b7:9c38:e8a5 with SMTP id ffacd0b85a97d-3b79c38e968mr1922605f8f.56.1753959352482;
        Thu, 31 Jul 2025 03:55:52 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:52 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/25] sched/core: Initialize root_task_group
Date: Thu, 31 Jul 2025 12:55:28 +0200
Message-ID: <20250731105543.40832-11-yurand2000@gmail.com>
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

Add the initialization function for task_group's dl_servers.
Initialize the default bandwidth for rt-cgroups and the root control group.
Add utility functions to check (and get) if a rt_rq entity is connected to a
real-time cgroup.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/autogroup.c |  4 ++--
 kernel/sched/core.c      |  9 +++++++--
 kernel/sched/deadline.c  |  8 ++++++++
 kernel/sched/rt.c        | 18 ++++++++----------
 kernel/sched/sched.h     | 32 +++++++++++++++++++++++++++++---
 5 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index cdea931aae3..017eadc0a0a 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -52,7 +52,7 @@ static inline void autogroup_destroy(struct kref *kref)
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	/* We've redirected RT tasks to the root task group... */
-	ag->tg->rt_se = NULL;
+	ag->tg->dl_se = NULL;
 	ag->tg->rt_rq = NULL;
 #endif
 	sched_release_group(ag->tg);
@@ -109,7 +109,7 @@ static inline struct autogroup *autogroup_create(void)
 	 * the policy change to proceed.
 	 */
 	free_rt_sched_group(tg);
-	tg->rt_se = root_task_group.rt_se;
+	tg->dl_se = root_task_group.dl_se;
 	tg->rt_rq = root_task_group.rt_rq;
 #endif /* CONFIG_RT_GROUP_SCHED */
 	tg->autogroup = ag;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 42587a3c71f..3a69cb906c3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8703,7 +8703,7 @@ void __init sched_init(void)
 		scx_tg_init(&root_task_group);
 #endif /* CONFIG_EXT_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
-		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
+		root_task_group.dl_se = (struct sched_dl_entity **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
 
 		root_task_group.rt_rq = (struct rt_rq **)ptr;
@@ -8714,6 +8714,11 @@ void __init sched_init(void)
 
 	init_defrootdomain();
 
+#ifdef CONFIG_RT_GROUP_SCHED
+	init_dl_bandwidth(&root_task_group.dl_bandwidth,
+			global_rt_period(), global_rt_runtime());
+#endif /* CONFIG_RT_GROUP_SCHED */
+
 #ifdef CONFIG_CGROUP_SCHED
 	task_group_cache = KMEM_CACHE(task_group, 0);
 
@@ -8765,7 +8770,7 @@ void __init sched_init(void)
 		 * starts working after scheduler_running, which is not the case
 		 * yet.
 		 */
-		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
+		init_tg_rt_entry(&root_task_group, rq, NULL, i, NULL);
 #endif
 		rq->sd = NULL;
 		rq->rd = NULL;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 55b7f883815..b8228f553fe 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -538,6 +538,14 @@ static inline int is_leftmost(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq
 
 static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
 
+void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime)
+{
+	raw_spin_lock_init(&dl_b->dl_runtime_lock);
+	dl_b->dl_period = period;
+	dl_b->dl_runtime = runtime;
+}
+
+
 void init_dl_bw(struct dl_bw *dl_b)
 {
 	raw_spin_lock_init(&dl_b->lock);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a6282784978..38178003184 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -97,18 +97,16 @@ void free_rt_sched_group(struct task_group *tg)
 		return;
 }
 
-void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
-		struct sched_rt_entity *rt_se, int cpu,
-		struct sched_rt_entity *parent)
+void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
+		struct sched_dl_entity *dl_se, int cpu,
+		struct sched_dl_entity *parent)
 {
-	struct rq *rq = cpu_rq(cpu);
+	served_rq->rt.highest_prio.curr = MAX_RT_PRIO-1;
+	served_rq->rt.rq = cpu_rq(cpu);
+	served_rq->rt.tg = tg;
 
-	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
-	rt_rq->rq = rq;
-	rt_rq->tg = tg;
-
-	tg->rt_rq[cpu] = rt_rq;
-	tg->rt_se[cpu] = rt_se;
+	tg->rt_rq[cpu] = &served_rq->rt;
+	tg->dl_se[cpu] = dl_se;
 }
 
 int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2a7601d400c..3283d824859 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -577,9 +577,9 @@ extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 extern bool cfs_task_bw_constrained(struct task_struct *p);
 
-extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
-		struct sched_rt_entity *rt_se, int cpu,
-		struct sched_rt_entity *parent);
+extern void init_tg_rt_entry(struct task_group *tg, struct rq *s_rq,
+		struct sched_dl_entity *rt_se, int cpu,
+		struct sched_dl_entity *parent);
 extern int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us);
 extern int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us);
 extern long sched_group_rt_runtime(struct task_group *tg);
@@ -2669,6 +2669,7 @@ extern void resched_curr(struct rq *rq);
 extern void resched_curr_lazy(struct rq *rq);
 extern void resched_cpu(int cpu);
 
+void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
 extern void init_dl_entity(struct sched_dl_entity *dl_se);
 
 #define BW_SHIFT		20
@@ -3077,6 +3078,21 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
 
 	return rt_rq->rq;
 }
+
+static inline int is_dl_group(struct rt_rq *rt_rq)
+{
+	return rt_rq->tg != &root_task_group;
+}
+
+/*
+ * Return the scheduling entity of this group of tasks.
+ */
+static inline struct sched_dl_entity *dl_group_of(struct rt_rq *rt_rq)
+{
+	BUG_ON(!is_dl_group(rt_rq));
+
+	return rt_rq->tg->dl_se[cpu_of(rt_rq->rq)];
+}
 #else
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
@@ -3101,6 +3117,16 @@ static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 
 	return &rq->rt;
 }
+
+static inline int is_dl_group(struct rt_rq *rt_rq)
+{
+	return 0;
+}
+
+static inline struct sched_dl_entity *dl_group_of(struct rt_rq *rt_rq)
+{
+	return NULL;
+}
 #endif
 
 DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
-- 
2.50.1



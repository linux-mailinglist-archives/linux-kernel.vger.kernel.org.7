Return-Path: <linux-kernel+bounces-889763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E4C3E753
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 05:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBA93ACCC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 04:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9D4289E06;
	Fri,  7 Nov 2025 04:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2JhR1Kl"
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A72459D9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490297; cv=none; b=JwXkoIDmJgMxtgPgjVqyAuZBdxc/IlTeN98+5ck8G/sH1QMc4AoMqaQF9F+0nUn4sA7DfYMk68buZ4AeTZSeVhUEhqtaNO6BDxH8XvRiIsUGaCebX5uhcHxlvrxAPt9hUnmIFQKdtTrOZz6wkbk3thavWU1XnyIbhqKhPv7hD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490297; c=relaxed/simple;
	bh=10iLhoesYzQ1FgJMpzu8BAAG0JfBAkZ6tKI8R/+tGKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPQUSD3fMSY+SEU1PxbPku6zHuuNRocfJSbGDzTmIS92XMCVxrx/IMJoU+0rbIEEpZ4cVRBUZMBJZK7+9+JqkRQMQfrOKTy4n+c7D9W2CXtiAH+kYplucL+3+XxEKdtjgAzcBEOfD+Ir4lmet+aVnWuv83hS2npdhjkZpDn/g6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2JhR1Kl; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88050bdc2abso11608896d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 20:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762490294; x=1763095094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc7zg0Xip4caBhiUMibaoPI31CF6EpscUiD6C+IhJbQ=;
        b=i2JhR1KlusdoZPCbu7Tb/Le0l19w1UDlqr7sQ4EfAb6kDPiGMOlmI2ADDE1itP2I6m
         gfL3izf0dMEySqlN9wY/FHOEY8BjdK3BgI7Mxs1SgOQBKXFhRgiMJ1b5FKW5DLXgMv+e
         sIPTqvMrWSoQMREV9BDK5/PyBejZnH921JS19Ah44vNsAhXcECcRuVb8OSyjcNy9kf89
         e2cjKe16aw6eLW90aNPxpvpJi3XbOpwJcOxFhzF3IXisyAuwk5FShv0iL4SE9PxcYyVe
         P6Gvx8JHRnpoqI98q4icD1e48Cra/fROheA01KRr0uuSSe7aYqdmIr5TLLqNq38QpJti
         FklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762490294; x=1763095094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc7zg0Xip4caBhiUMibaoPI31CF6EpscUiD6C+IhJbQ=;
        b=XjTcQ1nrz8AaFhlGpCPx74K8BW18pVxDheZ4wDZ3rqNXoWUKNT9KXNwhbeFaMv2+6l
         FOhY7NVxI+rHANzEnYEDeamKNKQhXyiOOsmVvF64GLzf6QLeBG6Z0yIZ+URiuDWqOD56
         3GNqnq+T+JEmvVMvTzY59dmrGf8hmB3TU2jGYvKclwi96v+DvFBvezJsP4aBeskVOMJU
         XaLFqrrYBoPqXeaulgElx8NcEn2JhzXQMBbDYugBv0P+ds7te/EEbcGLTrY03egJ+Rac
         +CmDcvERtYh8QR59YJ/DbYVYieA2zBQ+v5xATTXP7MP7+I0DeD8yonfUHvUkeyhyP4yu
         LCdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYprdS3Rx+79vZxakFjoIYIn0TB/f9mxCkJ6yh//ccWHDhs1geWamUAwAIy/cQGdn9N2NTsTMiAaDwUP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFE5tVKtUYySt7EM6rdIw37N15giSdW+G4iirvu8LSQY9qI0xU
	ZWlM/XKDzyFcp+3fygY2/xnfEI87bTk3kamIQjs2TcISMhq2TZ5rxhVOymcMU6xUupJEEWMnVPw
	XMUgzwGc5jg==
X-Google-Smtp-Source: AGHT+IEXXfOC6WiTmBRsaeV/hP7iJz1LUUe+hCuTmTAu+/MeSBoWRoIJxo5en8MR3W8t+cG5HEPXVs5DDs8Z
X-Received: from qva12.prod.google.com ([2002:a05:6214:800c:b0:882:2f2f:9dc])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:ad4:5f0a:0:b0:880:501f:5dd
 with SMTP id 6a1803df08f44-88167afb540mr25484026d6.14.1762490294378; Thu, 06
 Nov 2025 20:38:14 -0800 (PST)
Date: Fri,  7 Nov 2025 04:38:05 +0000
In-Reply-To: <20251107043807.1758889-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107043807.1758889-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107043807.1758889-4-zecheng@google.com>
Subject: [PATCH v5 3/3] sched/fair: Allocate both cfs_rq and sched_entity with per-cpu
From: Zecheng Li <zecheng@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Rik van Riel <riel@surriel.com>, Chris Mason <clm@fb.com>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Xu Liu <xliuprof@google.com>, 
	Blake Jones <blakejones@google.com>, Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

To remove the cfs_rq pointer array in task_group, allocate the combined
cfs_rq and sched_entity using the per-cpu allocator.

This patch implements the following:

- Changes task_group->cfs_rq from struct cfs_rq ** to struct cfs_rq
__percpu *.

- Updates memory allocation in alloc_fair_sched_group() and
free_fair_sched_group() to use alloc_percpu() and free_percpu()
respectively.

- Uses the inline accessor tg_cfs_rq(tg, cpu) with per_cpu_ptr() to
retrieve the pointer to cfs_rq for the given task group and CPU.

- Replaces direct accesses tg->cfs_rq[cpu] with calls to the new
tg_cfs_rq(tg, cpu) helper.

- Handles the root_task_group: since struct rq is already a per-cpu
variable (runqueues), its embedded cfs_rq (rq->cfs) is also per-cpu.
Therefore, we assign root_task_group.cfs_rq = &runqueues.cfs.

- Cleanup the code in initializing the root task group.

This change places each CPU's cfs_rq and sched_entity in its local
per-cpu memory area to remove the per-task_group pointer arrays.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 kernel/sched/core.c  | 35 ++++++++++-----------------
 kernel/sched/fair.c  | 57 +++++++++++++++++---------------------------
 kernel/sched/sched.h | 13 ++++++----
 3 files changed, 44 insertions(+), 61 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 12ebe1b4c8ae..376d27f4bbdb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8542,7 +8542,7 @@ static struct kmem_cache *task_group_cache __ro_after_init;
 
 void __init sched_init(void)
 {
-	unsigned long ptr = 0;
+	unsigned long __maybe_unused ptr = 0;
 	int i;
 
 	/* Make sure the linker didn't screw up */
@@ -8558,33 +8558,24 @@ void __init sched_init(void)
 	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	ptr += nr_cpu_ids * sizeof(void **);
-#endif
-#ifdef CONFIG_RT_GROUP_SCHED
-	ptr += 2 * nr_cpu_ids * sizeof(void **);
-#endif
-	if (ptr) {
-		ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
+	root_task_group.cfs_rq = &runqueues.cfs;
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
-
-		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
-		init_cfs_bandwidth(&root_task_group.cfs_bandwidth, NULL);
+	root_task_group.shares = ROOT_TASK_GROUP_LOAD;
+	init_cfs_bandwidth(&root_task_group.cfs_bandwidth, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_EXT_GROUP_SCHED
-		scx_tg_init(&root_task_group);
+	scx_tg_init(&root_task_group);
 #endif /* CONFIG_EXT_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
-		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	ptr += 2 * nr_cpu_ids * sizeof(void **);
+	ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
+	root_task_group.rt_se = (struct sched_rt_entity **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-		root_task_group.rt_rq = (struct rt_rq **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.rt_rq = (struct rt_rq **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
 #endif /* CONFIG_RT_GROUP_SCHED */
-	}
 
 	init_defrootdomain();
 
@@ -9483,7 +9474,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
 	}
 
 	for_each_online_cpu(i) {
-		struct cfs_rq *cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *cfs_rq = tg_cfs_rq(tg, i);
 		struct rq *rq = cfs_rq->rq;
 
 		guard(rq_lock_irq)(rq);
@@ -9651,7 +9642,7 @@ static u64 throttled_time_self(struct task_group *tg)
 	u64 total = 0;
 
 	for_each_possible_cpu(i) {
-		total += READ_ONCE(tg->cfs_rq[i]->throttled_clock_self_time);
+		total += READ_ONCE(tg_cfs_rq(tg, i)->throttled_clock_self_time);
 	}
 
 	return total;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f9fb07d73a03..a5403f5900d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -327,7 +327,7 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 	 * to a tree or when we reach the top of the tree
 	 */
 	if (cfs_rq->tg->parent &&
-	    cfs_rq->tg->parent->cfs_rq[cpu]->on_list) {
+	    tg_cfs_rq(cfs_rq->tg->parent, cpu)->on_list) {
 		/*
 		 * If parent is already on the list, we add the child
 		 * just before. Thanks to circular linked property of
@@ -335,7 +335,7 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 		 * of the list that starts by parent.
 		 */
 		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
-			&(cfs_rq->tg->parent->cfs_rq[cpu]->leaf_cfs_rq_list));
+			&(tg_cfs_rq(cfs_rq->tg->parent, cpu)->leaf_cfs_rq_list));
 		/*
 		 * The branch is now connected to its tree so we can
 		 * reset tmp_alone_branch to the beginning of the
@@ -4141,7 +4141,7 @@ static void __maybe_unused clear_tg_offline_cfs_rqs(struct rq *rq)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
-		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+		struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
 
 		clear_tg_load_avg(cfs_rq);
 	}
@@ -5739,7 +5739,7 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 
 static inline int lb_throttled_hierarchy(struct task_struct *p, int dst_cpu)
 {
-	return throttled_hierarchy(task_group(p)->cfs_rq[dst_cpu]);
+	return throttled_hierarchy(tg_cfs_rq(task_group(p), dst_cpu));
 }
 
 static inline bool task_is_throttled(struct task_struct *p)
@@ -5885,7 +5885,7 @@ static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags);
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
-	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
 	struct task_struct *p, *tmp;
 
 	if (--cfs_rq->throttle_count)
@@ -5956,7 +5956,7 @@ static void record_throttle_clock(struct cfs_rq *cfs_rq)
 static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
-	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
 
 	if (cfs_rq->throttle_count++)
 		return 0;
@@ -6432,8 +6432,8 @@ static void sync_throttle(struct task_group *tg, int cpu)
 	if (!tg->parent)
 		return;
 
-	cfs_rq = tg->cfs_rq[cpu];
-	pcfs_rq = tg->parent->cfs_rq[cpu];
+	cfs_rq = tg_cfs_rq(tg, cpu);
+	pcfs_rq = tg_cfs_rq(tg->parent, cpu);
 
 	cfs_rq->throttle_count = pcfs_rq->throttle_count;
 	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
@@ -6625,7 +6625,7 @@ static void __maybe_unused update_runtime_enabled(struct rq *rq)
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
 		struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
-		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+		struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
 
 		raw_spin_lock(&cfs_b->lock);
 		cfs_rq->runtime_enabled = cfs_b->quota != RUNTIME_INF;
@@ -6654,7 +6654,7 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
-		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+		struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
 
 		if (!cfs_rq->runtime_enabled)
 			continue;
@@ -9357,7 +9357,7 @@ static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_
 	struct cfs_rq *dst_cfs_rq;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	dst_cfs_rq = task_group(p)->cfs_rq[dest_cpu];
+	dst_cfs_rq = tg_cfs_rq(task_group(p), dest_cpu);
 #else
 	dst_cfs_rq = &cpu_rq(dest_cpu)->cfs;
 #endif
@@ -13094,7 +13094,7 @@ static int task_is_throttled_fair(struct task_struct *p, int cpu)
 	struct cfs_rq *cfs_rq;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	cfs_rq = task_group(p)->cfs_rq[cpu];
+	cfs_rq = tg_cfs_rq(task_group(p), cpu);
 #else
 	cfs_rq = &cpu_rq(cpu)->cfs;
 #endif
@@ -13354,42 +13354,31 @@ static void task_change_group_fair(struct task_struct *p)
 
 void free_fair_sched_group(struct task_group *tg)
 {
-	int i;
-
-	for_each_possible_cpu(i) {
-		if (tg->cfs_rq && tg->cfs_rq[i]) {
-			struct cfs_rq_with_se *combined =
-				container_of(tg->cfs_rq[i], struct cfs_rq_with_se, cfs_rq);
-			kfree(combined);
-		}
-	}
-
-	kfree(tg->cfs_rq);
+	free_percpu(tg->cfs_rq);
 }
 
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 {
-	struct cfs_rq_with_se *combined;
+	struct cfs_rq_with_se __percpu *combined;
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
 	int i;
 
-	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
-	if (!tg->cfs_rq)
+	combined = alloc_percpu_gfp(struct cfs_rq_with_se, GFP_KERNEL);
+	if (!combined)
 		goto err;
 
+	tg->cfs_rq = &combined->cfs_rq;
 	tg->shares = NICE_0_LOAD;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg), tg_cfs_bandwidth(parent));
 
 	for_each_possible_cpu(i) {
-		combined = kzalloc_node(sizeof(struct cfs_rq_with_se),
-				      GFP_KERNEL, cpu_to_node(i));
-		if (!combined)
+		cfs_rq = tg_cfs_rq(tg, i);
+		if (!cfs_rq)
 			goto err;
 
-		cfs_rq = &combined->cfs_rq;
-		se = &combined->se;
+		se = tg_se(tg, i);
 		init_cfs_rq(cfs_rq);
 		init_tg_cfs_entry(tg, cfs_rq, se, i, tg_se(parent, i));
 		init_entity_runnable_average(se);
@@ -13426,7 +13415,7 @@ void unregister_fair_sched_group(struct task_group *tg)
 	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
 	for_each_possible_cpu(cpu) {
-		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
+		struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu);
 		struct sched_entity *se = tg_se(tg, cpu);
 		struct rq *rq = cpu_rq(cpu);
 
@@ -13463,8 +13452,6 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	cfs_rq->rq = rq;
 	init_cfs_rq_runtime(cfs_rq);
 
-	tg->cfs_rq[cpu] = cfs_rq;
-
 	/* se could be NULL for root_task_group */
 	if (!se)
 		return;
@@ -13557,7 +13544,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
 		struct sched_entity *se = tg_se(tg, i);
-		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *grp_cfs_rq = tg_cfs_rq(tg, i);
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
 		struct rq_flags rf;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1133910a13c2..132e6098c058 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -477,7 +477,7 @@ struct task_group {
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* runqueue "owned" by this group on each CPU */
-	struct cfs_rq		**cfs_rq;
+	struct cfs_rq __percpu	*cfs_rq;
 	unsigned long		shares;
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
@@ -1607,6 +1607,11 @@ static inline struct task_struct *task_of(struct sched_entity *se)
 	WARN_ON_ONCE(!entity_is_task(se));
 	return container_of(se, struct task_struct, se);
 }
+/* Access a specific CPU's cfs_rq from a task group */
+static inline struct cfs_rq *tg_cfs_rq(struct task_group *tg, int cpu)
+{
+	return per_cpu_ptr(tg->cfs_rq, cpu);
+}
 
 static inline struct sched_entity *tg_se(struct task_group *tg, int cpu)
 {
@@ -1614,7 +1619,7 @@ static inline struct sched_entity *tg_se(struct task_group *tg, int cpu)
 		return NULL;
 
 	struct cfs_rq_with_se *combined =
-		container_of(tg->cfs_rq[cpu], struct cfs_rq_with_se, cfs_rq);
+		container_of(tg_cfs_rq(tg, cpu), struct cfs_rq_with_se, cfs_rq);
 	return &combined->se;
 }
 
@@ -2199,8 +2204,8 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 #endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
-	p->se.cfs_rq = tg->cfs_rq[cpu];
+	set_task_rq_fair(&p->se, p->se.cfs_rq, tg_cfs_rq(tg, cpu));
+	p->se.cfs_rq = tg_cfs_rq(tg, cpu);
 	p->se.parent = tg_se(tg, cpu);
 	p->se.depth = p->se.parent ? p->se.parent->depth + 1 : 0;
 #endif
-- 
2.51.2.1041.gc1ab5b90ca-goog



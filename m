Return-Path: <linux-kernel+bounces-799331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B385B42A20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59CF1BC8182
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1DD36C075;
	Wed,  3 Sep 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kr0lKcjM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892D36999D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928716; cv=none; b=uXozn9VUnre4SrMK4gTqPyWOKwZMge2+JQvetzCsOQNQNjOpfW45OhbnpSeTXJCqGJh82+U5RXRJWjdkbweGKFojREBM0pk3IXdnMX17bCwTumpyMoGNNqlGgIEv0xOmoYp349IAqPRT7tEgc+IR9nY/4PrPs2yrdlM9Vkx3i5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928716; c=relaxed/simple;
	bh=yeNTnbTZHiN8c1nGkA0zioSsJAz8wd4K7GS/fVdBAU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TxEI50VY8dcWde9RdnR0jNIf+by30ZjEM+QiM10w1nTCrjo9ULBYJcDg03etoJFNRRlDz07YUK0ceIcopA5elKef/kixCHHFX8EMpA6roib7nTyZ+adZEccTb2lYcfN+krYASbxSHMZOhZsiCBgh5MXoZa3mvb4CDt+PwNO5V2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kr0lKcjM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71d603bf1c4so4585507b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756928711; x=1757533511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GG48k3biDVzwK4t/1L7jbByzp/D3GDddVkiJ5P6Qq+o=;
        b=Kr0lKcjMq0P9Hn3+pjePTIS77eJTB9qljQGGQBgY2yVjTiiF72m3rHQuGQIXuNBNX+
         rJC5Qy9S9fk2fZ2Jtu9pMu+6obQd5sv4ubLs9VfLkP8YsQu/Nb39B4C9o2dzOCSABL2P
         ynPNs5w0+D7XV33KeJ1RqwmGZAaXEWnvVMHct3C+cewWtiXH8TzWC4sgeUueBQ/8XbMb
         MJtJr/3lb1uRdHOjjQCfAa1RVml0hbIC1an2UMsBuD5cIG99Oa49sDziW6l687jJeZZL
         D3cCskeo3q6JtwWBMGqwR6nRJsP9p0IQSa1uAlwbSjADIIHnCPC12MawQYRcKff9Nv0l
         xBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756928711; x=1757533511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GG48k3biDVzwK4t/1L7jbByzp/D3GDddVkiJ5P6Qq+o=;
        b=AugyO+Jz0Le5ick/BYmcPfK7OBGmdqoWNklAisPVFXIhXzCqTIz6ZTPr3O5lj4XJje
         vqonkE06NQxff6QpTQhV9Xkuq/Rw9W/yg8ZwO47fZHOjgUzpQTLnuG1Ap7gIg47xQ5JW
         +/6TnzTkxdGQKgaycrMGm8IwYr7Nx1HDx+1OE5VTvTK5cJj65qOZuDeJoSrhWWVlu1LC
         Oqd7PvC2GzF6riTZeDXUkT0M9PxT/KPr4y+BuJwgUTsoFSufgEDlTl719sWgtA/iysAL
         Y4lEFT+rIed1OLLaJnUuFQLwFQJ4NVzCEhe8vkMj75EqlPCKJycI5pJeGbsB7xlAxJAk
         WUIg==
X-Forwarded-Encrypted: i=1; AJvYcCVhKb5gYMJfMrf2yqwIfUj4x9bjPcmyxeXwCOZcqOD3ySHKySsfpCqmnv4ieL3VsCEY96Dv7U6YmrMKpoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPxAlevp7biVr+MbsVcJHnaBmrBbjyZfYPf9pQmNwDPplTAoN
	7DSGs7XfYMHnSUE5uJLt5g5F65ZlgiiPEhVulf/4Yqed3YPbbVmgvB0cVTS25Fs4JKkL4QfBDPx
	K9mIUjkGoAw==
X-Google-Smtp-Source: AGHT+IGB9OFaRNFhLGuEFvu5jHvJV5f5vxk/k6yWY4OlIds6qF4P39SVTU8d8MEQR9NIDMzHNgUdc3qOC/2g
X-Received: from ywmv11.prod.google.com ([2002:a81:fa0b:0:b0:71f:ea49:b54f])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:6608:b0:722:7324:dc42
 with SMTP id 00721157ae682-7227656be12mr189350117b3.47.1756928711497; Wed, 03
 Sep 2025 12:45:11 -0700 (PDT)
Date: Wed,  3 Sep 2025 19:45:02 +0000
In-Reply-To: <20250903194503.1679687-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903194503.1679687-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903194503.1679687-4-zecheng@google.com>
Subject: [PATCH v4 3/3] sched/fair: Allocate both cfs_rq and sched_entity with per-cpu
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
 kernel/sched/core.c  | 35 +++++++++++-----------------
 kernel/sched/fair.c  | 55 +++++++++++++++++---------------------------
 kernel/sched/sched.h | 13 +++++++----
 3 files changed, 43 insertions(+), 60 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 11efddf383ed..cbc97fd5b69c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8675,7 +8675,7 @@ static struct kmem_cache *task_group_cache __ro_after_init;
 
 void __init sched_init(void)
 {
-	unsigned long ptr = 0;
+	unsigned long __maybe_unused ptr = 0;
 	int i;
 
 	/* Make sure the linker didn't screw up */
@@ -8691,33 +8691,24 @@ void __init sched_init(void)
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
 
@@ -9633,7 +9624,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
 	}
 
 	for_each_online_cpu(i) {
-		struct cfs_rq *cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *cfs_rq = tg_cfs_rq(tg, i);
 		struct rq *rq = cfs_rq->rq;
 
 		guard(rq_lock_irq)(rq);
@@ -9801,7 +9792,7 @@ static u64 throttled_time_self(struct task_group *tg)
 	u64 total = 0;
 
 	for_each_possible_cpu(i) {
-		total += READ_ONCE(tg->cfs_rq[i]->throttled_clock_self_time);
+		total += READ_ONCE(tg_cfs_rq(tg, i)->throttled_clock_self_time);
 	}
 
 	return total;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8777e288f0e0..4a32ed5411e6 100644
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
@@ -4144,7 +4144,7 @@ static void __maybe_unused clear_tg_offline_cfs_rqs(struct rq *rq)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
-		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+		struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
 
 		clear_tg_load_avg(cfs_rq);
 	}
@@ -5878,7 +5878,7 @@ static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags);
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
-	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
 	struct task_struct *p, *tmp;
 
 	if (--cfs_rq->throttle_count)
@@ -5949,7 +5949,7 @@ static void record_throttle_clock(struct cfs_rq *cfs_rq)
 static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
-	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
 
 	if (cfs_rq->throttle_count++)
 		return 0;
@@ -6425,8 +6425,8 @@ static void sync_throttle(struct task_group *tg, int cpu)
 	if (!tg->parent)
 		return;
 
-	cfs_rq = tg->cfs_rq[cpu];
-	pcfs_rq = tg->parent->cfs_rq[cpu];
+	cfs_rq = tg_cfs_rq(tg, cpu);
+	pcfs_rq = tg_cfs_rq(tg->parent, cpu);
 
 	cfs_rq->throttle_count = pcfs_rq->throttle_count;
 	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
@@ -6608,7 +6608,7 @@ static void __maybe_unused update_runtime_enabled(struct rq *rq)
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
 		struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
-		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+		struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
 
 		raw_spin_lock(&cfs_b->lock);
 		cfs_rq->runtime_enabled = cfs_b->quota != RUNTIME_INF;
@@ -6637,7 +6637,7 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
-		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+		struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
 
 		if (!cfs_rq->runtime_enabled)
 			continue;
@@ -9336,7 +9336,7 @@ static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_
 	struct cfs_rq *dst_cfs_rq;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	dst_cfs_rq = task_group(p)->cfs_rq[dest_cpu];
+	dst_cfs_rq = tg_cfs_rq(task_group(p), dest_cpu);
 #else
 	dst_cfs_rq = &cpu_rq(dest_cpu)->cfs;
 #endif
@@ -13068,7 +13068,7 @@ static int task_is_throttled_fair(struct task_struct *p, int cpu)
 	struct cfs_rq *cfs_rq;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	cfs_rq = task_group(p)->cfs_rq[cpu];
+	cfs_rq = tg_cfs_rq(task_group(p), cpu);
 #else
 	cfs_rq = &cpu_rq(cpu)->cfs;
 #endif
@@ -13316,42 +13316,31 @@ static void task_change_group_fair(struct task_struct *p)
 
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
@@ -13388,7 +13377,7 @@ void unregister_fair_sched_group(struct task_group *tg)
 	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
 	for_each_possible_cpu(cpu) {
-		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
+		struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu);
 		struct sched_entity *se = tg_se(tg, cpu);
 		struct rq *rq = cpu_rq(cpu);
 
@@ -13425,8 +13414,6 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	cfs_rq->rq = rq;
 	init_cfs_rq_runtime(cfs_rq);
 
-	tg->cfs_rq[cpu] = cfs_rq;
-
 	/* se could be NULL for root_task_group */
 	if (!se)
 		return;
@@ -13519,7 +13506,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
 		struct sched_entity *se = tg_se(tg, i);
-		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *grp_cfs_rq = tg_cfs_rq(tg, i);
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
 		struct rq_flags rf;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2b350c25f116..1bd85a062e19 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -453,7 +453,7 @@ struct task_group {
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* runqueue "owned" by this group on each CPU */
-	struct cfs_rq		**cfs_rq;
+	struct cfs_rq __percpu	*cfs_rq;
 	unsigned long		shares;
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
@@ -1581,6 +1581,11 @@ static inline struct task_struct *task_of(struct sched_entity *se)
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
@@ -1588,7 +1593,7 @@ static inline struct sched_entity *tg_se(struct task_group *tg, int cpu)
 		return NULL;
 
 	struct cfs_rq_with_se *combined =
-		container_of(tg->cfs_rq[cpu], struct cfs_rq_with_se, cfs_rq);
+		container_of(tg_cfs_rq(tg, cpu), struct cfs_rq_with_se, cfs_rq);
 	return &combined->se;
 }
 
@@ -2168,8 +2173,8 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
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
2.51.0.338.gd7d06c2dae-goog



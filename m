Return-Path: <linux-kernel+bounces-889762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79841C3E750
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 05:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5293ACFED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 04:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F1927B34C;
	Fri,  7 Nov 2025 04:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCsXQHOa"
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056A1A256E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490296; cv=none; b=a4HOtDYzm6z++YOZvj20HMQnonJqigBkUoNsBb4SVHi5hpl6Tow5hJyMPTAa7mw90pLWA/1qEadt4HJO8H2giA5OsQFuBazNutdday5rYVKpf0FqhS/ynSTFXjQDqakVoCme6jhKtCv+ZnW6TAuVKD9tMxWT0gpAxrpXpn4FBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490296; c=relaxed/simple;
	bh=5FSVN6t16HUTQUIrBQI90gbY5f9LW3PO/Osyuixyd/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DhIjueQhLM6f0sDqzpc0SrlVbCtS8Ao012KsY8sBMJ5+kClKWgiun9s6u1PnY6RcnLDDA8DabZIKzKExcFoiqhKCpSeQ/qvzKcEfk21oV2cyXrJRsoTkYSH5uszHoQEnHcX93/mpP7nXxWAjSLP2zfPEZPpRn6wTZb/RBtNx/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCsXQHOa; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8803f43073bso11364456d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 20:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762490293; x=1763095093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBWFEtspIzrg97TaHeeXIiA08f/quVSUywNGx/mI/Pw=;
        b=TCsXQHOaMKNTBI9G05WgB4tslVihnBnD4buoJRiMEWSiIu2tvOtMppYSm4UWD6AAy8
         u7pz7yg8bliuFUtIG4XyiSk8dqmSKjCE1kbj89Ns+Pq2bR4LgKDqtb9WDqYNg6aKTHSq
         7SIq/obxiwt/S/rIW5U2NpRDBDX1ISZLOxJ9B0Cr4d5QLg8mcDhSD+TGlq+w86AletmU
         rdbznG0c6l1+Yf9bh4BFcOiw/eb5CeSHnEsAfEIPyQAjHfJFY+H9/jBSNBl9ye+MFsug
         5m3h4KFzdPqN9Lqmk2AygB1CQTgRcRjHC0TAR1XaRA+dAg8Z7p/z2sDn52Oj/rrapwUf
         nnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762490293; x=1763095093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBWFEtspIzrg97TaHeeXIiA08f/quVSUywNGx/mI/Pw=;
        b=nSWzI5FU7jpIa0vIi60m0sczcbau0dKbF/aDqT8aVWpkRgLIh/fMR/LCZThulCFHpC
         5vdjIGM4bfFhnsSnCCRvduCzUfFAHF78XkwpJlsxczAjc/WELgypv2mWg76Wksf+MTdh
         UUZjAK+KCthViOoOvF0y/0Kjmzwy8ONsgm2eXQ9xAmjJX6bPuNq+rn58cCNdTgiYv8Cr
         4eirnbRBi90qo0Jh6gvejPH+9mH/AEFNUfEqSLeZChaYLwDLb40YgQddnMcV/ov9GERH
         AhRWp+k+tbVFxuEjUpR3Gwpi72TfG3KFlhL0mLx0FZJU19t4z4QSjD60ykzScZ73tAmi
         Qhyg==
X-Forwarded-Encrypted: i=1; AJvYcCU6YpWg2eKX4JGlb7wljekL2y4wtFCIGCUyQUS/kCG+m8c7W136yv+EPHx3IbXI7BHWvLmBN32OqxkHi6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4pEscXoqxladqh0jbV88mBRjfrh3HZlsUfzZ4vIv+UAuLrghS
	R08AKuIjdCLtO6buM+FybGV1pXBu8CPncjUU1ZBGNw/y81veqnHsAN7xrs4wq1eQz9+g7TG7pVo
	fM/fZroDfzA==
X-Google-Smtp-Source: AGHT+IE3kMhQogVWInfOC9o2A17iW8RABljN9iQmNQ36igUtZH+jBCvHZZ0MiPoyZTkK1d8FkyMyeeFEnXxF
X-Received: from qvc1.prod.google.com ([2002:a05:6214:8101:b0:880:4abb:71c2])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:1313:b0:880:4eeb:3661
 with SMTP id 6a1803df08f44-8817678f529mr27356246d6.63.1762490293150; Thu, 06
 Nov 2025 20:38:13 -0800 (PST)
Date: Fri,  7 Nov 2025 04:38:04 +0000
In-Reply-To: <20251107043807.1758889-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107043807.1758889-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107043807.1758889-3-zecheng@google.com>
Subject: [PATCH v5 2/3] sched/fair: Remove task_group->se pointer array
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

Now that struct sched_entity is co-located with struct cfs_rq for
non-root task groups, the task_group->se pointer array is redundant. The
associated sched_entity can be loaded directly from the cfs_rq.

This patch performs the access conversion with the helpers:

- is_root_task_group(tg): checks if a task group is the root task group.
It compares the task group's address with the global root_task_group
variable.

- tg_se(tg, cpu): retrieves the cfs_rq and returns the address of the
co-located se. This function checks if tg is the root task group to
ensure behaving the same of previous tg->se[cpu]. Replaces all accesses
that use the tg->se[cpu] pointer array with calls to the new tg_se(tg,
cpu) accessor.

- cfs_rq_se(cfs_rq): simplifies access paths like cfs_rq->tg->se[...] to
use the co-located sched_entity. This function also checks if tg is the
root task group to ensure same behavior.

Since tg_se is not in very hot code paths, and the branch is a register
comparison with an immediate value (`&root_task_group`), the performance
impact is expected to be negligible.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 kernel/sched/core.c  |  7 ++-----
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 27 ++++++++++-----------------
 kernel/sched/sched.h | 29 ++++++++++++++++++++++++-----
 4 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67b5f2faab36..12ebe1b4c8ae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8558,7 +8558,7 @@ void __init sched_init(void)
 	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	ptr += 2 * nr_cpu_ids * sizeof(void **);
+	ptr += nr_cpu_ids * sizeof(void **);
 #endif
 #ifdef CONFIG_RT_GROUP_SCHED
 	ptr += 2 * nr_cpu_ids * sizeof(void **);
@@ -8567,9 +8567,6 @@ void __init sched_init(void)
 		ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-		root_task_group.se = (struct sched_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
-
 		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
 
@@ -9635,7 +9632,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 		int i;
 
 		for_each_possible_cpu(i) {
-			stats = __schedstats_from_se(tg->se[i]);
+			stats = __schedstats_from_se(tg_se(tg, i));
 			ws += schedstat_val(stats->wait_sum);
 		}
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 02e16b70a790..16542596d4b0 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -644,7 +644,7 @@ void dirty_sched_domain_sysctl(int cpu)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group *tg)
 {
-	struct sched_entity *se = tg->se[cpu];
+	struct sched_entity *se = tg_se(tg, cpu);
 
 #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
 #define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	\
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1676119e302b..f9fb07d73a03 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6021,7 +6021,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
+	struct sched_entity *se;
 
 	/*
 	 * It's possible we are called with !runtime_remaining due to things
@@ -6036,7 +6036,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
 		return;
 
-	se = cfs_rq->tg->se[cpu_of(rq)];
+	se = cfs_rq_se(cfs_rq);
 
 	cfs_rq->throttled = 0;
 
@@ -9788,7 +9788,6 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
 	struct cfs_rq *cfs_rq, *pos;
 	bool decayed = false;
-	int cpu = cpu_of(rq);
 
 	/*
 	 * Iterates the task_group tree in a bottom up fashion, see
@@ -9808,7 +9807,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		}
 
 		/* Propagate pending load changes to the parent, if any: */
-		se = cfs_rq->tg->se[cpu];
+		se = cfs_rq_se(cfs_rq);
 		if (se && !skip_blocked_update(se))
 			update_load_avg(cfs_rq_of(se), se, UPDATE_TG);
 
@@ -9834,8 +9833,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
  */
 static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 {
-	struct rq *rq = rq_of(cfs_rq);
-	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
+	struct sched_entity *se = cfs_rq_se(cfs_rq);
 	unsigned long now = jiffies;
 	unsigned long load;
 
@@ -13367,7 +13365,6 @@ void free_fair_sched_group(struct task_group *tg)
 	}
 
 	kfree(tg->cfs_rq);
-	kfree(tg->se);
 }
 
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
@@ -13380,9 +13377,6 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
 	if (!tg->cfs_rq)
 		goto err;
-	tg->se = kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);
-	if (!tg->se)
-		goto err;
 
 	tg->shares = NICE_0_LOAD;
 
@@ -13397,7 +13391,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		cfs_rq = &combined->cfs_rq;
 		se = &combined->se;
 		init_cfs_rq(cfs_rq);
-		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
+		init_tg_cfs_entry(tg, cfs_rq, se, i, tg_se(parent, i));
 		init_entity_runnable_average(se);
 	}
 
@@ -13416,7 +13410,7 @@ void online_fair_sched_group(struct task_group *tg)
 
 	for_each_possible_cpu(i) {
 		rq = cpu_rq(i);
-		se = tg->se[i];
+		se = tg_se(tg, i);
 		rq_lock_irq(rq, &rf);
 		update_rq_clock(rq);
 		attach_entity_cfs_rq(se);
@@ -13433,7 +13427,7 @@ void unregister_fair_sched_group(struct task_group *tg)
 
 	for_each_possible_cpu(cpu) {
 		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
-		struct sched_entity *se = tg->se[cpu];
+		struct sched_entity *se = tg_se(tg, cpu);
 		struct rq *rq = cpu_rq(cpu);
 
 		if (se) {
@@ -13470,7 +13464,6 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	init_cfs_rq_runtime(cfs_rq);
 
 	tg->cfs_rq[cpu] = cfs_rq;
-	tg->se[cpu] = se;
 
 	/* se could be NULL for root_task_group */
 	if (!se)
@@ -13501,7 +13494,7 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	/*
 	 * We can't change the weight of the root cgroup.
 	 */
-	if (!tg->se[0])
+	if (is_root_task_group(tg))
 		return -EINVAL;
 
 	shares = clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));
@@ -13512,7 +13505,7 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	tg->shares = shares;
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
-		struct sched_entity *se = tg->se[i];
+		struct sched_entity *se = tg_se(tg, i);
 		struct rq_flags rf;
 
 		/* Propagate contribution to hierarchy */
@@ -13563,7 +13556,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
-		struct sched_entity *se = tg->se[i];
+		struct sched_entity *se = tg_se(tg, i);
 		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8db53f4d4d06..1133910a13c2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -476,8 +476,6 @@ struct task_group {
 #endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	/* schedulable entities of this group on each CPU */
-	struct sched_entity	**se;
 	/* runqueue "owned" by this group on each CPU */
 	struct cfs_rq		**cfs_rq;
 	unsigned long		shares;
@@ -923,7 +921,8 @@ struct dl_rq {
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-
+/* Check whether a task group is root tg */
+#define is_root_task_group(tg) ((tg) == &root_task_group)
 /* An entity is a task if it doesn't "own" a runqueue */
 #define entity_is_task(se)	(!se->my_q)
 
@@ -1609,6 +1608,26 @@ static inline struct task_struct *task_of(struct sched_entity *se)
 	return container_of(se, struct task_struct, se);
 }
 
+static inline struct sched_entity *tg_se(struct task_group *tg, int cpu)
+{
+	if (is_root_task_group(tg))
+		return NULL;
+
+	struct cfs_rq_with_se *combined =
+		container_of(tg->cfs_rq[cpu], struct cfs_rq_with_se, cfs_rq);
+	return &combined->se;
+}
+
+static inline struct sched_entity *cfs_rq_se(struct cfs_rq *cfs_rq)
+{
+	if (is_root_task_group(cfs_rq->tg))
+		return NULL;
+
+	struct cfs_rq_with_se *combined =
+		container_of(cfs_rq, struct cfs_rq_with_se, cfs_rq);
+	return &combined->se;
+}
+
 static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
 {
 	return p->se.cfs_rq;
@@ -2182,8 +2201,8 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
 	p->se.cfs_rq = tg->cfs_rq[cpu];
-	p->se.parent = tg->se[cpu];
-	p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
+	p->se.parent = tg_se(tg, cpu);
+	p->se.depth = p->se.parent ? p->se.parent->depth + 1 : 0;
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
-- 
2.51.2.1041.gc1ab5b90ca-goog



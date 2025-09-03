Return-Path: <linux-kernel+bounces-799330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43591B42A1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402E41BC827D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E8369996;
	Wed,  3 Sep 2025 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYnWsYgd"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6A369963
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928713; cv=none; b=twIztyVr9u0JJjkfrlRY5+ZrTUrxm9p6aQKGZDFD0EgoWwn4x/0NUPaPzkNXuh1OY+6FNgkJ93ixbLBxiZP8URaIuUJLu1vA40x6WFQBF0G1zJvxWe2nuC4tiZ0kuIyCotCDKBU/sn06Vbs4S+kHQKFG2t+ihdqdDcGVVme627w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928713; c=relaxed/simple;
	bh=FMBiWzNwTzzlN5GTyRqSv0FYEs/GD6WMfrSmQIzif10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lz9AVhFWLJGc6kwEYvAYx58RDlb7kLVy4/nMdGjSgVboF+KgtmcV6xtSoT0nFbLHnPZoIXxyVy+zi+U8YbM99mbI5lB+BB6TXQpLW/GEMjr+JeVDVEITwoUi7ibe+8+nyh4Bvs30PqHsB9ue+k36mZEx0SA9rLxKyxpBkxptOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYnWsYgd; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-80584b42d15so62266785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756928710; x=1757533510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2AZ1QGVNuCg4PV0LCwZKcF9MIi5NqekDv2CLRHczJ3E=;
        b=DYnWsYgdyze23OWrCGqLqTTUGGQjydDNL3Amzn3kN1As4Pz1gFUtbPPL/WuwY20mcb
         +F5eFr44hEdsUWpUtt5VGA49xV72vxPy+zJj32pc+dOl13tF5kwo1H5vc+sKdv2cFJrG
         LM0VOcl9BFChwzY+wopmfASGiPLtfephzc5MCARbjEw1oQN7xbWflMvfqhiqDpCW2H32
         qeDXSvKwK1hw/Y13/zO1PWacxiPqyfI0o/xsGk1/YEgT5PczW8myAoIpmzqX2gOGNcPT
         lEwd/MwmYpnF/ZU4nORgnpy80twa+a+F3Y74OnDWBMNNilKd5sPVZpjFSgC6LAEQDAHl
         Zp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756928710; x=1757533510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AZ1QGVNuCg4PV0LCwZKcF9MIi5NqekDv2CLRHczJ3E=;
        b=lNsWdSeHPpMK5afJmup+7U2IsIJ82zMg9KyQgOns2YCsNrItGeQV8oV2Cx2utRT1TT
         8LGgg9bQhb/v6a7qcL1FJ40eyCQqC8PcQAmipZyPhVI1oHF8ja7hS/3rCJi3WJwC/78q
         rSeL8olkKcKEKLowrjmlUtlD9bogiUBy9dYNMu8mGguJ3dGvnO92D/BO11LhPksrUEpp
         af46VOtgo4dgVeQXLD0al7eYytBcWXqm9YAcrdXd0hwFSanw2dR3AQyMEnmBlFIyxy4j
         DfITqGAAKyKZRc3VO9nSFHT/5mK1ktjuWh6+/osJKuVvQfH2aE4d0iibZyBNmhOuqZ1p
         Xvkw==
X-Forwarded-Encrypted: i=1; AJvYcCXP3hYhvUJsbKPJPxNUmRo+En/+0A1tgcwtBVNVhQRFAYfnKzIN1bINyi4GdWwUcXUfRsqJCTJgem2o2Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCKpm9fqwoCpVyO4nYddz8xXQbBMO//NL069p8amwq08+MLM4t
	kHSUN3XxAKjrv6OKyHdaQx4C/kFLFdIkQ/Kkw1dGuLP7RBOb8f7ZJIr2QDRN+m1XMa1H46H/6eT
	vpGluWXmG9w==
X-Google-Smtp-Source: AGHT+IHv23SMUkd7fwdpw2+BVynRXXTL1YDNbdD21QcOQYgGUL0ZBwr2CMUnzubMXyKpHgBGLDOSQuQ2JBL2
X-Received: from qknqb2.prod.google.com ([2002:a05:620a:6502:b0:80e:b15:b019])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:3909:b0:7e9:f820:2b7e
 with SMTP id af79cd13be357-7ff2cbd845dmr1659910385a.84.1756928710177; Wed, 03
 Sep 2025 12:45:10 -0700 (PDT)
Date: Wed,  3 Sep 2025 19:45:01 +0000
In-Reply-To: <20250903194503.1679687-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903194503.1679687-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903194503.1679687-3-zecheng@google.com>
Subject: [PATCH v4 2/3] sched/fair: Remove task_group->se pointer array
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
index feb750aae71b..11efddf383ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8691,7 +8691,7 @@ void __init sched_init(void)
 	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	ptr += 2 * nr_cpu_ids * sizeof(void **);
+	ptr += nr_cpu_ids * sizeof(void **);
 #endif
 #ifdef CONFIG_RT_GROUP_SCHED
 	ptr += 2 * nr_cpu_ids * sizeof(void **);
@@ -8700,9 +8700,6 @@ void __init sched_init(void)
 		ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-		root_task_group.se = (struct sched_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
-
 		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
 
@@ -9785,7 +9782,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
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
index fc8bc2d4614f..8777e288f0e0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6014,7 +6014,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
+	struct sched_entity *se;
 
 	/*
 	 * It's possible we are called with !runtime_remaining due to things
@@ -6029,7 +6029,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
 		return;
 
-	se = cfs_rq->tg->se[cpu_of(rq)];
+	se = cfs_rq_se(cfs_rq);
 
 	cfs_rq->throttled = 0;
 
@@ -9763,7 +9763,6 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
 	struct cfs_rq *cfs_rq, *pos;
 	bool decayed = false;
-	int cpu = cpu_of(rq);
 
 	/*
 	 * Iterates the task_group tree in a bottom up fashion, see
@@ -9783,7 +9782,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		}
 
 		/* Propagate pending load changes to the parent, if any: */
-		se = cfs_rq->tg->se[cpu];
+		se = cfs_rq_se(cfs_rq);
 		if (se && !skip_blocked_update(se))
 			update_load_avg(cfs_rq_of(se), se, UPDATE_TG);
 
@@ -9809,8 +9808,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
  */
 static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 {
-	struct rq *rq = rq_of(cfs_rq);
-	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
+	struct sched_entity *se = cfs_rq_se(cfs_rq);
 	unsigned long now = jiffies;
 	unsigned long load;
 
@@ -13329,7 +13327,6 @@ void free_fair_sched_group(struct task_group *tg)
 	}
 
 	kfree(tg->cfs_rq);
-	kfree(tg->se);
 }
 
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
@@ -13342,9 +13339,6 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
 	if (!tg->cfs_rq)
 		goto err;
-	tg->se = kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);
-	if (!tg->se)
-		goto err;
 
 	tg->shares = NICE_0_LOAD;
 
@@ -13359,7 +13353,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		cfs_rq = &combined->cfs_rq;
 		se = &combined->se;
 		init_cfs_rq(cfs_rq);
-		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
+		init_tg_cfs_entry(tg, cfs_rq, se, i, tg_se(parent, i));
 		init_entity_runnable_average(se);
 	}
 
@@ -13378,7 +13372,7 @@ void online_fair_sched_group(struct task_group *tg)
 
 	for_each_possible_cpu(i) {
 		rq = cpu_rq(i);
-		se = tg->se[i];
+		se = tg_se(tg, i);
 		rq_lock_irq(rq, &rf);
 		update_rq_clock(rq);
 		attach_entity_cfs_rq(se);
@@ -13395,7 +13389,7 @@ void unregister_fair_sched_group(struct task_group *tg)
 
 	for_each_possible_cpu(cpu) {
 		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
-		struct sched_entity *se = tg->se[cpu];
+		struct sched_entity *se = tg_se(tg, cpu);
 		struct rq *rq = cpu_rq(cpu);
 
 		if (se) {
@@ -13432,7 +13426,6 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	init_cfs_rq_runtime(cfs_rq);
 
 	tg->cfs_rq[cpu] = cfs_rq;
-	tg->se[cpu] = se;
 
 	/* se could be NULL for root_task_group */
 	if (!se)
@@ -13463,7 +13456,7 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	/*
 	 * We can't change the weight of the root cgroup.
 	 */
-	if (!tg->se[0])
+	if (is_root_task_group(tg))
 		return -EINVAL;
 
 	shares = clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));
@@ -13474,7 +13467,7 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	tg->shares = shares;
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
-		struct sched_entity *se = tg->se[i];
+		struct sched_entity *se = tg_se(tg, i);
 		struct rq_flags rf;
 
 		/* Propagate contribution to hierarchy */
@@ -13525,7 +13518,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
-		struct sched_entity *se = tg->se[i];
+		struct sched_entity *se = tg_se(tg, i);
 		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8b37de788eeb..2b350c25f116 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -452,8 +452,6 @@ struct task_group {
 #endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	/* schedulable entities of this group on each CPU */
-	struct sched_entity	**se;
 	/* runqueue "owned" by this group on each CPU */
 	struct cfs_rq		**cfs_rq;
 	unsigned long		shares;
@@ -899,7 +897,8 @@ struct dl_rq {
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-
+/* Check whether a task group is root tg */
+#define is_root_task_group(tg) ((tg) == &root_task_group)
 /* An entity is a task if it doesn't "own" a runqueue */
 #define entity_is_task(se)	(!se->my_q)
 
@@ -1583,6 +1582,26 @@ static inline struct task_struct *task_of(struct sched_entity *se)
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
@@ -2151,8 +2170,8 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
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
2.51.0.338.gd7d06c2dae-goog



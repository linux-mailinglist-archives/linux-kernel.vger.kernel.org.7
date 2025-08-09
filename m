Return-Path: <linux-kernel+bounces-760955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98125B1F244
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FD718991C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1966275B1C;
	Sat,  9 Aug 2025 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyvdr92q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E92472BA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716438; cv=none; b=oP/KP8CT9PyG8F223CbqjTnw5fAnuBqC4qrJsRtJ4FhmBZN2qpqY1eTd8fjtB3IjDADG3eDf23ECJS0GGe21q95Lgbd8aoZ2d1dhrh9ekTQMUxybtv0qdhdWt0awWabB+mPE502GRGKAWZIXsyFrdxhb/zbs1b9+pJ2xhI3lh0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716438; c=relaxed/simple;
	bh=2aEa4h1fI5J4/1AEUoGjg0eQXawj82V6LxqSqdQWKjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLlyXwmAlVBfL8ugZpWuJv/cYDUhBSgXTmsJA1VoG4McRZM9A+e9EyJW9FEw5BbRwioynILfrxFhAe4zM1FRKim6rhs5NDIaRMWKq7+xJ+DXnEZ4q4gjxkB8JnCe7RI2fcforxvMACn4NmxTFkZ0407GDkQ+uKE5393PmwyageE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyvdr92q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716436; x=1786252436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2aEa4h1fI5J4/1AEUoGjg0eQXawj82V6LxqSqdQWKjc=;
  b=jyvdr92qHqcE9M3jPHv+fDdx/YNY3xnAId3qtw3C2QzAwffEVL4ZQTBS
   CePnqJIrCnZ2R6zfimwVCnLdiYu5OvVZ5ChHHhlNO+ZL+HID3ktCe7O2w
   48m583KvcVHXVXNpkpIfS7DLrauwwN0nhjxTOtWhNNA6tX0C3umtnps9k
   I2871JFWkVEb0mXhuELAw1LEqE+pk38njQNVgLdHwoT5vvi9CMGrEAr/N
   RU5gBb080A9sLYEGTtpnWCaPKZUTFqtKi9ostEazBVphHyMbIcwyMjLxO
   F+hAW/C7GT5rTxqDXPHnZ6JnGmHGoIMYcwTWKxDujBKbcjIHs9lsLI5Ay
   w==;
X-CSE-ConnectionGUID: frbwZBVeQsyYvImCyN450Q==
X-CSE-MsgGUID: O9BLeD00TFuab4r38fYeEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="79620417"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="79620417"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:13:55 -0700
X-CSE-ConnectionGUID: 57mN5EeXQnOL1PlRN1msdQ==
X-CSE-MsgGUID: ZdnU+8XKSQuiZvpeY/fMpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165844039"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2025 22:13:50 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Libo Chen <libo.chen@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>,
	Len Brown <len.brown@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 21/28] sched: Introduce a static key to enable cache aware only for multi LLCs
Date: Sat,  9 Aug 2025 13:07:47 +0800
Message-Id: <fa45f8eb38ab06d02847d57195c6304af3107c70.1754712565.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1754712565.git.tim.c.chen@linux.intel.com>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there are more than one LLCs in the node, the
cache aware scheduling is enabled. Otherwise, the
cache aware scheduling is disabled.

The definition of multiple LLCs in a node is that
every node in the system should have more than one
LLC. For example, if node0, node1, and node2 each
have 4 LLCs, while node3 has 1 LLC (possibly due
to CPU hotplug), cache-aware scheduling should be
disabled.

Suggested-by: Libo Chen <libo.chen@oracle.com>
Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 31 ++++++++++++++++++++++---------
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 22 ++++++++++++++++++++--
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e61f9e1f628..194ec594561b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1175,6 +1175,8 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 #define EPOCH_PERIOD	(HZ/100)	/* 10 ms */
 #define EPOCH_OLD	5		/* 50 ms */
 
+DEFINE_STATIC_KEY_FALSE(sched_cache_present);
+
 static int llc_id(int cpu)
 {
 	if (cpu < 0)
@@ -1318,7 +1320,8 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	unsigned long epoch;
 	int mm_sched_llc = -1;
 
-	if (!sched_feat(SCHED_CACHE))
+	if (!sched_feat(SCHED_CACHE) ||
+	    !static_branch_likely(&sched_cache_present))
 		return;
 
 	if (p->sched_class != &fair_sched_class)
@@ -1366,7 +1369,8 @@ static void task_tick_cache(struct rq *rq, struct task_struct *p)
 	struct callback_head *work = &p->cache_work;
 	struct mm_struct *mm = p->mm;
 
-	if (!sched_feat(SCHED_CACHE))
+	if (!sched_feat(SCHED_CACHE) ||
+	    !static_branch_likely(&sched_cache_present))
 		return;
 
 	if (!mm || !mm->pcpu_sched)
@@ -9063,7 +9067,8 @@ static int select_cache_cpu(struct task_struct *p, int prev_cpu)
 	struct mm_struct *mm = p->mm;
 	int cpu;
 
-	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_WAKE))
+	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_WAKE) ||
+	    !static_branch_likely(&sched_cache_present))
 		return prev_cpu;
 
 	if (!mm || p->nr_cpus_allowed == 1)
@@ -10024,6 +10029,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 #ifdef CONFIG_SCHED_CACHE
 	if (sched_feat(SCHED_CACHE) && sched_feat(SCHED_CACHE_LB) &&
+	   static_branch_likely(&sched_cache_present) &&
 	    get_migrate_hint(env->src_cpu, env->dst_cpu, p) == mig_forbid)
 		return 0;
 #endif
@@ -10109,7 +10115,8 @@ static struct list_head
 	LIST_HEAD(no_pref_llc);
 	LIST_HEAD(pref_other_llc);
 
-	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB))
+	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB) ||
+	    !static_branch_likely(&sched_cache_present))
 		return tasks;
 
 	if (cpus_share_cache(env->dst_cpu, env->src_cpu))
@@ -10295,6 +10302,7 @@ static int detach_tasks(struct lb_env *env)
 		 * they are tasks that prefer the current LLC.
 		 */
 		if (sched_feat(SCHED_CACHE) && sched_feat(SCHED_CACHE_LB) &&
+		    static_branch_likely(&sched_cache_present) &&
 		    p->preferred_llc != -1 &&
 		    llc_id(env->src_cpu) == p->preferred_llc)
 			break;
@@ -10952,7 +10960,8 @@ static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 	struct sched_domain *child = env->sd->child;
 	int llc;
 
-	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB))
+	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB) ||
+	    !static_branch_likely(&sched_cache_present))
 		return false;
 
 	if (env->sd->flags & SD_SHARE_LLC)
@@ -11064,7 +11073,8 @@ static void update_sg_if_llc(struct lb_env *env, struct sg_lb_stats *sgs,
 	struct sched_domain_shared *sd_share;
 
 	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE ||
-	    !sched_feat(SCHED_CACHE_LB))
+	    !sched_feat(SCHED_CACHE_LB) ||
+	    !static_branch_likely(&sched_cache_present))
 		return;
 
 	/* only care the sched domain that spans 1 LLC */
@@ -11126,7 +11136,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			*sg_overutilized = 1;
 
 #ifdef CONFIG_SCHED_CACHE
-		if (sched_feat(SCHED_CACHE) && sched_feat(SCHED_CACHE_LB)) {
+		if (sched_feat(SCHED_CACHE) && sched_feat(SCHED_CACHE_LB) &&
+		    static_branch_likely(&sched_cache_present)) {
 			int j;
 
 			for (j = 0; j < max_llcs; ++j)
@@ -12412,7 +12423,8 @@ imbalanced_active_balance(struct lb_env *env)
 static inline bool
 break_llc_locality(struct lb_env *env)
 {
-	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB))
+	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB) ||
+	    !static_branch_likely(&sched_cache_present))
 		return 0;
 
 	if (cpus_share_cache(env->src_cpu, env->dst_cpu))
@@ -12914,7 +12926,8 @@ static int active_load_balance_cpu_stop(void *data)
 #ifdef CONFIG_SCHED_CACHE
 		int llc = llc_idx(target_cpu);
 
-		if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB))
+		if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB) ||
+		    !static_branch_likely(&sched_cache_present))
 			goto out_unlock;
 
 		if (llc < 0)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4464b92767ad..3e60618a88e9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2857,6 +2857,7 @@ extern unsigned int sysctl_numa_balancing_hot_threshold;
 #ifdef CONFIG_SCHED_CACHE
 extern unsigned int sysctl_llc_aggr_cap;
 extern unsigned int sysctl_llc_aggr_imb;
+extern struct static_key_false sched_cache_present;
 #endif
 
 #ifdef CONFIG_SCHED_HRTICK
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 91a2b7f65fee..8483c02b4d28 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2476,6 +2476,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	int i, ret = -ENOMEM;
 	bool has_asym = false;
 	bool has_cluster = false;
+	bool llc_has_parent_sd = false;
+	unsigned int multi_llcs_node = 1;
 
 #ifdef CONFIG_SCHED_CACHE
 	if (max_llcs < 0) {
@@ -2545,6 +2547,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 				struct sched_domain __rcu *top_p;
 				unsigned int nr_llcs;
 
+				if (!llc_has_parent_sd)
+					llc_has_parent_sd = true;
 				/*
 				 * For a single LLC per node, allow an
 				 * imbalance up to 12.5% of the node. This is
@@ -2566,10 +2570,19 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 				 * between LLCs and memory channels.
 				 */
 				nr_llcs = sd->span_weight / child->span_weight;
-				if (nr_llcs == 1)
+				/*
+				 * iff all nodes have multiple LLCs, the
+				 * multi_llcs_node will be set to 1. If
+				 * there is at least 1 node having 1 single
+				 * LLC, the multi_llcs_node remains 0.
+				 */
+				if (nr_llcs == 1) {
 					imb = sd->span_weight >> 3;
-				else
+					multi_llcs_node = 0;
+				} else {
 					imb = nr_llcs;
+					multi_llcs_node &= 1;
+				}
 				imb = max(1U, imb);
 				sd->imb_numa_nr = imb;
 
@@ -2617,6 +2630,11 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_cluster)
 		static_branch_inc_cpuslocked(&sched_cluster_active);
 
+#ifdef CONFIG_SCHED_CACHE
+	if (llc_has_parent_sd && multi_llcs_node && !sched_asym_cpucap_active())
+		static_branch_inc_cpuslocked(&sched_cache_present);
+#endif
+
 	if (rq && sched_debug_verbose)
 		pr_info("root domain span: %*pbl\n", cpumask_pr_args(cpu_map));
 
-- 
2.25.1



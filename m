Return-Path: <linux-kernel+bounces-849238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B66BCFA8A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C78DC4E8C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D4E283CA7;
	Sat, 11 Oct 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSwa/WAK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19068204096
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206704; cv=none; b=EzlLh3pSj7Y4f8RITAS280jAzGdfSil0Uvmf2s0iDBWXhjbTN9kKcwe8yCBI8vI/kpxwAU/q6SDZiBXRODyVXxt+x1ZEHGNytyNVJ+14VdLcKLUF/bWqEXXojGdMU1nZFeYor5k/Gwn2eBMXY7mjVq+req3REwzEV/z7PNxWJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206704; c=relaxed/simple;
	bh=BGRV8Sqvoh/cH0/obDDFWGIX+d3J6kT5RHYq4DeXAFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naTQ9gtxsiPYap1e7sRA67shhCjtvQU5+UWYPmFmFnsa1NV0CLod+8tcKlUn52BHYuXFMHk+KQi3AhpPSOC+Tysfot4R/EhnOjDucwfpslAmfKl+rwCfOrGMnq3fjOG/h3r7EnuLxz8dxpUfqriJzedrFrStvfO37iAPvvF5HVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSwa/WAK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206702; x=1791742702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BGRV8Sqvoh/cH0/obDDFWGIX+d3J6kT5RHYq4DeXAFQ=;
  b=LSwa/WAKvGAX6RIYpQ7iNqrlvhm/Szlkb5ZlWCgbajQDsBhTiTWg/PPi
   Nxj6VEs7MSoZptgkIvxX8jl3FQca3deDnRuhlinmaGbJYu3LY3ZP4p3jp
   4+hBugKd3GkfwcLlWr+3IrP84r9gwdtMmKlDccI1G07f4s4tirTBoEDsm
   gJ8uA3qrKlx1xYMf/sgz5udiByo4NeRPGdBdJ+bYBTDvNTGeTE9k4bBmi
   0OuSxEI9YhInAS8s2mr8VnpZwUVjixmAO4g6ZwRHW42PucNrjAj/v7YoU
   sfJ1aDaIb4/pD7oTExOcJxChABHQZAXGQ1b9F1jBoWdX4w8mb0HwbQJ+I
   A==;
X-CSE-ConnectionGUID: V6kqtIYCR06jkGZvnWCLsQ==
X-CSE-MsgGUID: XSPXCIWWQjiVjOSNzEq1Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339631"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339631"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:20 -0700
X-CSE-ConnectionGUID: wcTW2V7hQHun3H1J8na2Fw==
X-CSE-MsgGUID: zfpr8MStR5yuJxzDpmsnpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487184"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:20 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Chen Yu <yu.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
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
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] sched/fair: Record per-LLC utilization to guide cache-aware scheduling decisions
Date: Sat, 11 Oct 2025 11:24:39 -0700
Message-Id: <7684e7381c61a2a0d0580790340d4daa5349e48c.1760206683.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1760206683.git.tim.c.chen@linux.intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Yu <yu.c.chen@intel.com>

When a system becomes busy and a process’s preferred LLC is
saturated with too many threads, tasks within that LLC migrate
frequently. These in LLC migrations introduce latency and degrade
performance. To avoid this, task aggregation should be suppressed when
the preferred LLC is overloaded, which requires a metric to indicate
LLC utilization.

Record per LLC utilization/cpu capacity during periodic load
balancing. These statistics will be used in later patches to decide
whether tasks should be aggregated into their preferred LLC.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/sched/topology.h |  4 ++
 kernel/sched/fair.c            | 73 ++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 5263746b63e8..fa25db00fdb6 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -77,6 +77,10 @@ struct sched_domain_shared {
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
 	int		nr_idle_scan;
+#ifdef CONFIG_SCHED_CACHE
+	unsigned long	util_avg;
+	unsigned long	capacity ____cacheline_aligned_in_smp;
+#endif
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a2ea002f4fd6..1ebb0d99a906 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9559,6 +9559,29 @@ static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_
 	return 0;
 }
 
+#ifdef CONFIG_SCHED_CACHE
+/* Called from load balancing paths with rcu_read_lock held */
+static __maybe_unused bool get_llc_stats(int cpu, unsigned long *util,
+					 unsigned long *cap)
+{
+	struct sched_domain_shared *sd_share;
+
+	sd_share = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (!sd_share)
+		return false;
+
+	*util = READ_ONCE(sd_share->util_avg);
+	*cap = READ_ONCE(sd_share->capacity);
+
+	return true;
+}
+#else
+static inline bool get_llc_stats(int cpu, unsigned long *util,
+				 unsigned long *cap)
+{
+	return false;
+}
+#endif
 /*
  * can_migrate_task - may task p from runqueue rq be migrated to this_cpu?
  */
@@ -10529,6 +10552,55 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	return check_cpu_capacity(rq, sd);
 }
 
+#ifdef CONFIG_SCHED_CACHE
+/*
+ * Record the statistics for this scheduler group for later
+ * use. These values guide load balancing on aggregating tasks
+ * to a LLC.
+ */
+static void record_sg_llc_stats(struct lb_env *env,
+				struct sg_lb_stats *sgs,
+				struct sched_group *group)
+{
+	/*
+	 * Find the child domain on env->dst_cpu. This domain
+	 * is either the domain that spans this group(if the
+	 * group is a local group), or the sibling domain of
+	 * this group.
+	 */
+	struct sched_domain *sd = env->sd->child;
+	struct sched_domain_shared *sd_share;
+
+	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE)
+		return;
+
+	/* only care about sched domains spanning a LLC */
+	if (sd != rcu_dereference(per_cpu(sd_llc, env->dst_cpu)))
+		return;
+
+	/*
+	 * At this point we know this group spans a LLC domain.
+	 * Record the statistic of this group in its corresponding
+	 * shared LLC domain.
+	 */
+	sd_share = rcu_dereference(per_cpu(sd_llc_shared,
+					   cpumask_first(sched_group_span(group))));
+	if (!sd_share)
+		return;
+
+	if (READ_ONCE(sd_share->util_avg) != sgs->group_util)
+		WRITE_ONCE(sd_share->util_avg, sgs->group_util);
+
+	if (unlikely(READ_ONCE(sd_share->capacity) != sgs->group_capacity))
+		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
+}
+#else
+static inline void record_sg_llc_stats(struct lb_env *env, struct sg_lb_stats *sgs,
+				       struct sched_group *group)
+{
+}
+#endif
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10618,6 +10690,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
+	record_sg_llc_stats(env, sgs, group);
 	/* Computing avg_load makes sense only when group is overloaded */
 	if (sgs->group_type == group_overloaded)
 		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
-- 
2.32.0



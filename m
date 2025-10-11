Return-Path: <linux-kernel+bounces-849246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76628BCFAA5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0334075D2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C779328725E;
	Sat, 11 Oct 2025 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Loa6o7d1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13BA28505C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206711; cv=none; b=EhBerRhJhQXPW7xGyw0P5bxJnRZLdUKLIQ12NKKqVw4ZWFGkcALuZ8VykNWnycAafmMkb5kBWaZT15xr3ZuPia1hqPYipqCAVEd34Wn9NgZ7h0Lqr4/FQP1HOI9Yp9naliJ5jjs5uaj5L1/4fJBsGwV0wle3JatN24KLVnEBxK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206711; c=relaxed/simple;
	bh=QoFubbb8wiPjhz5y3pWF+17tV+P2bIxeqL8wpFi1nfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XF3a1nw/8EN0FU+PNi1yIJ/227PxHRBRy24uDZNEkqQuRuIG35Ap7GIvbGG+L1n9ZlEPV0A8eM5UvEqTGNXZktaeA+OJjX4avu9hw9uu6rqowoIWWNlLa6/0iuozmn5jhIZJJqDbWB7j1stg+x51fnwnSbNrDkb2H27S3usCnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Loa6o7d1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206709; x=1791742709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QoFubbb8wiPjhz5y3pWF+17tV+P2bIxeqL8wpFi1nfk=;
  b=Loa6o7d1Mzs3ouslW83UWTdxmyggGuWTcpizCbNq+GcghqOrvTfXSRIV
   0EP9sedHVH3VdKCqAQHV/ZX3VHfUXCRKy9+NcdVchFLL8bKi/9buFRwhw
   ZWmkcnGopsf975TA51MaL7sh2sNrOAvPuHmiA1plKNFBBesobcOlf5xbr
   aZ9W/S+Mv3Ykf28JPDwOIYzvtKZi5pCgwvqz5wqJHrujBfUq//kuxX1xD
   44PevqjxkAnPNbnm/C3CdQgNXiNta5xW/ZKmACOzIkYXaOsL8kl9jvdQl
   4VJ6pV7RaGBpMqmBXGMhRqdKmN0HSByZ1kvmH46v45jRNYG2/U+7kgbrO
   A==;
X-CSE-ConnectionGUID: 7OsmkTE2T2eIFyDjRKp/ig==
X-CSE-MsgGUID: oqLf97jbSIOB+8Rk4LLqqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339788"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339788"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:28 -0700
X-CSE-ConnectionGUID: jHLQbWxOTR2E4C2/k5j7Wg==
X-CSE-MsgGUID: sQhO8wOTQIuj4/5Og2eBgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487222"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:27 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
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
	Aubrey Li <aubrey.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] sched/fair: Prioritize tasks preferring destination LLC during balancing
Date: Sat, 11 Oct 2025 11:24:47 -0700
Message-Id: <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1760206683.git.tim.c.chen@linux.intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During LLC load balancing, first check for tasks that prefer the
destination LLC and balance them to it before others.

Mark source sched groups containing tasks preferring non local LLCs
with the group_llc_balance flag. This ensures the load balancer later
pulls or pushes these tasks toward their preferred LLCs.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cbd1e97bca4b..af7b578eaa06 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9822,8 +9822,7 @@ static __maybe_unused enum llc_mig can_migrate_llc_task(int src_cpu, int dst_cpu
 	else
 		return mig_unrestricted;
 
-	return can_migrate_llc(src_cpu, dst_cpu,
-			       task_util(p), to_pref);
+	return can_migrate_llc(src_cpu, dst_cpu, task_util(p), to_pref);
 }
 
 #else
@@ -10394,6 +10393,7 @@ struct sg_lb_stats {
 	enum group_type group_type;
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
 	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
+	unsigned int group_llc_balance;		/* Tasks should be moved to preferred LLC */
 	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -10849,11 +10849,45 @@ static void record_sg_llc_stats(struct lb_env *env,
 	if (unlikely(READ_ONCE(sd_share->capacity) != sgs->group_capacity))
 		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
 }
+
+/*
+ * Do LLC balance on sched group that contains LLC, and have tasks preferring
+ * to run on LLC in idle dst_cpu.
+ */
+static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
+			       struct sched_group *group)
+{
+	struct sched_domain *child = env->sd->child;
+	int llc;
+
+	if (!sched_cache_enabled())
+		return false;
+
+	if (env->sd->flags & SD_SHARE_LLC)
+		return false;
+
+	/* only care about task migration among LLCs */
+	if (child && !(child->flags & SD_SHARE_LLC))
+		return false;
+
+	llc = llc_idx(env->dst_cpu);
+	if (sgs->nr_pref_llc[llc] > 0 &&
+	    can_migrate_llc(env->src_cpu, env->dst_cpu, 0, true) == mig_llc)
+		return true;
+
+	return false;
+}
 #else
 static inline void record_sg_llc_stats(struct lb_env *env, struct sg_lb_stats *sgs,
 				       struct sched_group *group)
 {
 }
+
+static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
+			       struct sched_group *group)
+{
+	return false;
+}
 #endif
 
 /**
@@ -10954,6 +10988,11 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
 	record_sg_llc_stats(env, sgs, group);
+
+	/* Check for tasks in this group can be moved to their preferred LLC */
+	if (!local_group && llc_balance(env, sgs, group))
+		sgs->group_llc_balance = 1;
+
 	/* Computing avg_load makes sense only when group is overloaded */
 	if (sgs->group_type == group_overloaded)
 		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
-- 
2.32.0



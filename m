Return-Path: <linux-kernel+bounces-849249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442FBCFAAB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2EE189A597
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C402328850F;
	Sat, 11 Oct 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdkwbeJq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0E286D56
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206713; cv=none; b=GHTSZiD43H1BP9udGQWGRTSdycj0dFbwOFNYssvdtvgDyjDEnOhEZuZ3tF7d4Oxq4KjVh/REHJdk8e5qmA0nk91pFvjTrD7ew0sadW9X2+TjejBiKi+Z4u/nZlJeGc29rI3I01ytNZfNGLLusPB2P/4mVx6bLIuv9bhIea7/KOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206713; c=relaxed/simple;
	bh=4nb/OF/m6vG5cWGZuJFatpxTHqyXyCOJlbLckp109KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z43NaTPGAIlscL0L7fDhRwzngl1+8YayCbuXKnJJO/leht3IttqnVKWti2tJx4O3Ad4+Bxa7ijhsxQg7lysYNstcyC73l5FTr0P11m80kqmUiNRrC4pt99E80BCBIbFo2SatFJnTKT4Q1ux117UKVwuy6P9Rh922Z1naN6x4Wgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdkwbeJq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206711; x=1791742711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4nb/OF/m6vG5cWGZuJFatpxTHqyXyCOJlbLckp109KU=;
  b=JdkwbeJqpvNLxxR/C5J1ZH6Sc5bkBzINB0NUowykgcoSMh+IrKTz9SEs
   3TI4U2WqUZ4fGfcXVpbX1N2vbaAfyQUv4dhr3bMb1WSUcBz4dSrMfVdBf
   Gdlpc/LwIyV72Eyt8t+mfF176Y/vv2GuGHN9WuXsK8/fBvzDMB20NsZLB
   QBg0I+M7oRSQsaiygrqnGBFHiCS3p2JbXoqghWgigPrv6u1iqo8HXxcYs
   HtDa1JUkhRKqPvvWxmzbfQzJYS+Coi/HVD3eewtzP+ILLi56XMzOKLHfR
   iZqHJ/1cq2a50rc7YQNpk4EmPQ7vkE0qnNCf9o39KpjsRQh5qnu3HCaul
   A==;
X-CSE-ConnectionGUID: VRcX2cnOQSeMAY0e8g4K3w==
X-CSE-MsgGUID: SPoQqM3DQk6EyvXMnqQjmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339847"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339847"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:31 -0700
X-CSE-ConnectionGUID: pKVZhrKMR8K6LBYqzMOqAA==
X-CSE-MsgGUID: CK8cGt1oRtCxjPN4nS/YdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487238"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:30 -0700
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
Subject: [PATCH 13/19] sched/fair: Handle moving single tasks to/from their preferred LLC
Date: Sat, 11 Oct 2025 11:24:50 -0700
Message-Id: <231864b303906a60491bbb9eb7b2e3f083bff248.1760206683.git.tim.c.chen@linux.intel.com>
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

If the busiest runqueue has only one task, active balancing may be
invoked to move it. However, before migration, check whether the task
is running on its preferred LLC.

Do not move a lone task to another LLC if it would move the task
away from its preferred LLC or cause excessive imbalance between LLCs.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 62 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bec6354d7841..19ba9c1b9a63 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9826,12 +9826,53 @@ static __maybe_unused enum llc_mig can_migrate_llc_task(int src_cpu, int dst_cpu
 	return can_migrate_llc(src_cpu, dst_cpu, task_util(p), to_pref);
 }
 
+static inline bool
+break_llc_locality(struct lb_env *env)
+{
+	if (!sched_cache_enabled())
+		return false;
+
+	if (cpus_share_cache(env->src_cpu, env->dst_cpu))
+		return false;
+	/*
+	 * All tasks prefer to stay on their current CPU.
+	 * Do not pull a task from its preferred CPU if:
+	 * 1. It is the only task running there; OR
+	 * 2. Migrating it away from its preferred LLC would violate
+	 *    the cache-aware scheduling policy.
+	 */
+	if (env->src_rq->nr_pref_llc_running == env->src_rq->cfs.h_nr_runnable) {
+		unsigned long util = 0;
+		struct task_struct *cur;
+
+		if (env->src_rq->nr_running <= 1)
+			return true;
+
+		rcu_read_lock();
+		cur = rcu_dereference(env->src_rq->curr);
+		if (cur)
+			util = task_util(cur);
+		rcu_read_unlock();
+
+		if (can_migrate_llc(env->src_cpu, env->dst_cpu,
+				    util, false) == mig_forbid)
+			return true;
+	}
+
+	return false;
+}
 #else
 static inline bool get_llc_stats(int cpu, unsigned long *util,
 				 unsigned long *cap)
 {
 	return false;
 }
+
+static inline bool
+break_llc_locality(struct lb_env *env)
+{
+	return false;
+}
 #endif
 /*
  * can_migrate_task - may task p from runqueue rq be migrated to this_cpu?
@@ -12247,6 +12288,9 @@ static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
+	if (break_llc_locality(env))
+		return 0;
+
 	if (asym_active_balance(env))
 		return 1;
 
@@ -12266,7 +12310,8 @@ static int need_active_balance(struct lb_env *env)
 			return 1;
 	}
 
-	if (env->migration_type == migrate_misfit)
+	if (env->migration_type == migrate_misfit ||
+	    env->migration_type == migrate_llc_task)
 		return 1;
 
 	return 0;
@@ -12711,9 +12756,20 @@ static int active_load_balance_cpu_stop(void *data)
 		goto out_unlock;
 
 	/* Is there any task to move? */
-	if (busiest_rq->nr_running <= 1)
-		goto out_unlock;
+	if (busiest_rq->nr_running <= 1) {
+#ifdef CONFIG_SCHED_CACHE
+		int llc = llc_idx(target_cpu);
 
+		if (!sched_cache_enabled())
+			goto out_unlock;
+
+		if (llc < 0)
+			goto out_unlock;
+		/* don't migrate if no task prefers target */
+		if (busiest_rq->nr_pref_llc[llc] < 1)
+#endif
+			goto out_unlock;
+	}
 	/*
 	 * This condition is "impossible", if it occurs
 	 * we need to fix it. Originally reported by
-- 
2.32.0



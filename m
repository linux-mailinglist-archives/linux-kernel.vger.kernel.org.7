Return-Path: <linux-kernel+bounces-849240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C434BCFA90
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68457189A2D0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6330928466A;
	Sat, 11 Oct 2025 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHqKXCIn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9FE27F75F
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206705; cv=none; b=toy7mYgrkMShyfYM+pYJVnlk2kT96KNiv5DNY2SPeZNG+C4hUMbzxW+QMLoY5P4G0gxMEqPJZD1oRcx17kku+G6SaznXM9qHf6TbjE3y6E+5eW6mFGs9F7x17MH+po42oQIBeMuQONsrqKSl7XLcK2ag8qWKJC1Xr5w/c8efzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206705; c=relaxed/simple;
	bh=DdyW/r2KQaOAUhZji+A8n5cKTc9SCv7SgRP3P8o/I+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BrQQpH91F+AYLu9pNsP5vrblllGBIiYSrf9Tqy9EYC4wS0n0udak+gKeFf8J19+3f0P2Q81tPIF74K0DC5ETs6YeanXYBydnXlUojA//lO1O300HBm7E4ONxjKjmsrUvcSI3JT5Le3EHo8kdx7whhv843/P3GIna7MP3njXDV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHqKXCIn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206704; x=1791742704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DdyW/r2KQaOAUhZji+A8n5cKTc9SCv7SgRP3P8o/I+A=;
  b=BHqKXCInpJ9FMs87LCbtbTr8sCx+I94vOdw+YhnA01VGi2y2vrviHuha
   44dYUBEYMQCSqJ0LZTT2V+2kshxkaTOgIYxGLcnue8xZcdvJE+tFA1vNK
   e3l/bHsCjqNkzuXBC7xQTcdlcOk0RWIbIkbhlcUaSh6K3yuxlVHUHJcmE
   r0xmWO+olPuADPa5P30u0Ohf3HcjIqBXZsxBvV5VI21iprKzNU2fqZx7i
   dnB6Mbk+VkrpWYKhn8UVMBHAO40Hwj1qg7dTaTpQfAWXx8+nbbBZeHxKl
   1QcSW4+uLMzTxhbUTINvxL6mxdB/i7FkzCBGLbgZ013YwkDLFD2+4CBnX
   w==;
X-CSE-ConnectionGUID: XU0Bp+klQCiSCfmyOaBeOA==
X-CSE-MsgGUID: qUdy5aE4QB+ndas2O3JrjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339674"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339674"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:22 -0700
X-CSE-ConnectionGUID: veyEE6PBTGirh+PomEioDQ==
X-CSE-MsgGUID: eht/GZN/S/ekMdaQtDO0ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487193"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:22 -0700
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
Subject: [PATCH 04/19] sched/fair: Introduce a static key to enable cache aware only for multi LLCs
Date: Sat, 11 Oct 2025 11:24:41 -0700
Message-Id: <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
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

From: Chen Yu <yu.c.chen@intel.com>

Enable cache-aware load balancing only if at least 1 NUMA node has
more than one LLC.

Suggested-by: Libo Chen <libo.chen@oracle.com>
Suggested-by: Adam Li <adamli@os.amperecomputing.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c     | 15 ++++++++++++---
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 14 ++++++++++++--
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd080468ddc9..3d643449c48c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1208,6 +1208,14 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
 __read_mostly unsigned int llc_overload_pct       = 50;
 __read_mostly unsigned int llc_imb_pct            = 20;
 
+DEFINE_STATIC_KEY_FALSE(sched_cache_allowed);
+
+static inline bool sched_cache_enabled(void)
+{
+	return sched_feat(SCHED_CACHE) &&
+		static_branch_likely(&sched_cache_allowed);
+}
+
 static int llc_id(int cpu)
 {
 	if (cpu < 0)
@@ -1294,7 +1302,7 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	struct mm_sched *pcpu_sched;
 	unsigned long epoch;
 
-	if (!sched_feat(SCHED_CACHE))
+	if (!sched_cache_enabled())
 		return;
 
 	if (p->sched_class != &fair_sched_class)
@@ -1330,7 +1338,7 @@ static void task_tick_cache(struct rq *rq, struct task_struct *p)
 	struct callback_head *work = &p->cache_work;
 	struct mm_struct *mm = p->mm;
 
-	if (!sched_feat(SCHED_CACHE))
+	if (!sched_cache_enabled())
 		return;
 
 	if (!mm || !mm->pcpu_sched)
@@ -10716,7 +10724,8 @@ static void record_sg_llc_stats(struct lb_env *env,
 	struct sched_domain *sd = env->sd->child;
 	struct sched_domain_shared *sd_share;
 
-	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE)
+	if (!sched_cache_enabled() ||
+	    env->idle == CPU_NEWLY_IDLE)
 		return;
 
 	/* only care about sched domains spanning a LLC */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a52c96064b36..60f1e51685ec 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2800,6 +2800,7 @@ extern unsigned int sysctl_numa_balancing_hot_threshold;
 #ifdef CONFIG_SCHED_CACHE
 extern unsigned int llc_overload_pct;
 extern unsigned int llc_imb_pct;
+extern struct static_key_false sched_cache_allowed;
 #endif
 
 #ifdef CONFIG_SCHED_HRTICK
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6e2f54169e66..2675db980f70 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2444,6 +2444,7 @@ static int
 build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *attr)
 {
 	enum s_alloc alloc_state = sa_none;
+	bool has_multi_llcs = false;
 	struct sched_domain *sd;
 	struct s_data d;
 	struct rq *rq = NULL;
@@ -2530,10 +2531,12 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 				 * between LLCs and memory channels.
 				 */
 				nr_llcs = sd->span_weight / child->span_weight;
-				if (nr_llcs == 1)
+				if (nr_llcs == 1) {
 					imb = sd->span_weight >> 3;
-				else
+				} else {
 					imb = nr_llcs;
+					has_multi_llcs = true;
+				}
 				imb = max(1U, imb);
 				sd->imb_numa_nr = imb;
 
@@ -2581,6 +2584,13 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_cluster)
 		static_branch_inc_cpuslocked(&sched_cluster_active);
 
+#ifdef CONFIG_SCHED_CACHE
+	if (has_multi_llcs) {
+		static_branch_enable_cpuslocked(&sched_cache_allowed);
+		pr_info("Cache aware load balance enabled.\n");
+	}
+#endif
+
 	if (rq && sched_debug_verbose)
 		pr_info("root domain span: %*pbl\n", cpumask_pr_args(cpu_map));
 
-- 
2.32.0



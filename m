Return-Path: <linux-kernel+bounces-760939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E84B1F232
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A83566E9D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F210274B39;
	Sat,  9 Aug 2025 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XB8zwFIH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24CE21D3E1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716147; cv=none; b=LI4h+6OJWZaBS0TR7Q3NBzoXkmy9JmDvvsP0v6h3Wr+GpKZR5W1whx1t+MpULY/tpCopCTQwtk+d4eHYbBbXGG8tw911CUm66GpfCtas8ctsmrrtOtpyFMSEQ1wSEmj4dWMkrZhPa8ugb3u+CyP9djkHSe8sZ2gx2yAfRIPx9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716147; c=relaxed/simple;
	bh=euRWyMdufoCin//rgMJ4T3fWMZpHw1jQB7L14khTmb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhwU+egXgnivL5wAIp8WWClNxp4yT7p2+qq0OVtPsZHuRHUqSefqGa8Mw69mD2l/SvPpXJI146UF1gIL0OohXuZVBnBx9uuzjtJB0fwJPdjrZGa51C5jL55hj27fGIPyUJpmNwnKZK7cVsQFji5MJ9gcLGaigOLthcWnAQfM4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XB8zwFIH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716146; x=1786252146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=euRWyMdufoCin//rgMJ4T3fWMZpHw1jQB7L14khTmb4=;
  b=XB8zwFIHW5tROwSjY+TkhHve8zxklhKn+ovNLIF8SV5U0iIW3uisGZ+h
   hY/ESXsB+pgUaisyny/yy5pPLNKo8MGtQy5YXsFvNJCRR/qBzsPTciwpd
   DWKZJ1KhyMu77ycu6eYUAzqZuN/gRnxFRxIu0gB+CDzvdaP0yW6Alm3q2
   6uSDm53TwoaOggR9d3iPh9Z+dpDEn90e2yYpi8OZHptMKcxOxMQuhOE8g
   XyVt9GJRY6uXVn+Xhk0ObrEJv4d8fU3+v015Xl9/d69ko5uk8uOcrTvoC
   5KhPHr2patZHHRizOM78ma1nH5m9MLqfkUzr1tVCq2xOpXisttW9XZBQc
   Q==;
X-CSE-ConnectionGUID: fZf0KiitSgGguAZwYKknTQ==
X-CSE-MsgGUID: qtUqGlf/QgGtoI55sDwkdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57137770"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57137770"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:09:05 -0700
X-CSE-ConnectionGUID: 7a50TPFuTq2l0110KDRwEA==
X-CSE-MsgGUID: IsqZoesVQLiHgA5hLOCuhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165374544"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa006.fm.intel.com with ESMTP; 08 Aug 2025 22:09:00 -0700
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
Subject: [RFC PATCH v4 06/28] sched: Save the per LLC utilization for better cache aware scheduling
Date: Sat,  9 Aug 2025 13:02:54 +0800
Message-Id: <d77d4db175adc09cd01fdee097c16bc3e52c8be2.1754712565.git.tim.c.chen@linux.intel.com>
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

When a system gets busy and a process's preferred LLC
is saturated by too many threads within this process, there are significant
in-LLC task migrations within its preferred LLC. This leads to migration
latency and degrades performance. Ideally, task aggregation should be
inhibited if the task's preferred LLC is overloaded. This implies that a
metric is needed to indicate whether the LLC is busy.

Store the per-LLC utilization calculated via periodic load
balancing. These statistics will be used in subsequent patches to
determine whether tasks should be aggregated to their preferred LLC.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched/topology.h |  3 ++
 kernel/sched/fair.c            | 53 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 198bb5cc1774..692f8a703b93 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -78,6 +78,9 @@ struct sched_domain_shared {
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
 	int		nr_idle_scan;
+#ifdef CONFIG_SCHED_CACHE
+	unsigned long	util_avg;
+#endif
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9e3c6f0eb934..4f79b7652642 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8828,6 +8828,22 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 #ifdef CONFIG_SCHED_CACHE
 static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle);
 
+/* expected to be protected by rcu_read_lock() */
+static bool get_llc_stats(int cpu, unsigned long *util,
+			  unsigned long *cap)
+{
+	struct sched_domain_shared *sd_share;
+
+	sd_share = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (!sd_share)
+		return false;
+
+	*util = READ_ONCE(sd_share->util_avg);
+	*cap = per_cpu(sd_llc_size, cpu) * SCHED_CAPACITY_SCALE;
+
+	return true;
+}
+
 static int select_cache_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct mm_struct *mm = p->mm;
@@ -10670,6 +10686,42 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	return check_cpu_capacity(rq, sd);
 }
 
+#ifdef CONFIG_SCHED_CACHE
+/*
+ * Save this sched group's statistic for later use:
+ * The task wakeup and load balance can make better
+ * decision based on these statistics.
+ */
+static void update_sg_if_llc(struct lb_env *env, struct sg_lb_stats *sgs,
+			     struct sched_group *group)
+{
+	/* Find the sched domain that spans this group. */
+	struct sched_domain *sd = env->sd->child;
+	struct sched_domain_shared *sd_share;
+
+	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE)
+		return;
+
+	/* only care the sched domain that spans 1 LLC */
+	if (!sd || !(sd->flags & SD_SHARE_LLC) ||
+	    !sd->parent || (sd->parent->flags & SD_SHARE_LLC))
+		return;
+
+	sd_share = rcu_dereference(per_cpu(sd_llc_shared,
+				  cpumask_first(sched_group_span(group))));
+	if (!sd_share)
+		return;
+
+	if (likely(READ_ONCE(sd_share->util_avg) != sgs->group_util))
+		WRITE_ONCE(sd_share->util_avg, sgs->group_util);
+}
+#else
+static inline void update_sg_if_llc(struct lb_env *env, struct sg_lb_stats *sgs,
+				    struct sched_group *group)
+{
+}
+#endif
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10759,6 +10811,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
+	update_sg_if_llc(env, sgs, group);
 	/* Computing avg_load makes sense only when group is overloaded */
 	if (sgs->group_type == group_overloaded)
 		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
-- 
2.25.1



Return-Path: <linux-kernel+bounces-849239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 980E9BCFA93
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6DAB4E4201
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6829A283FD3;
	Sat, 11 Oct 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7smfE6o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9012652B7
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206704; cv=none; b=oUXwn7ZLltUxrcsLLRQdMkG+rOj3I6N99RIlDJViVMyN84ZxeHx7+Ziq9zOEmnN6HNfk258hdIef+3nAkETeBkCnWEbZ8Lcj64n3OoXf0SrXkICA1KPwc1TZ230lpQNfogVeErSJlu4VOhrgueBPexZRP8Ng8MlzAqpdxuV0fQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206704; c=relaxed/simple;
	bh=ogKsGwPqpnqTItrkOZHQAqJw6k94DPs+hyTioL4d/Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h155j6xc5cDWdV6bfIecXus0Znq8M6zidqbVhtVjeQT/UoiHcyIrY8v1abXoVw27R0/39P2bQUH4GyYEjMOV8PSTvlLp8J+kYh4mcI1SSe5ftkudSs2ubZG59uaM4B6xXwz85tEAhPwwNkRLqFlmW7J/wyi3Ynw+ec/ie7a3Ft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7smfE6o; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206702; x=1791742702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ogKsGwPqpnqTItrkOZHQAqJw6k94DPs+hyTioL4d/Ig=;
  b=n7smfE6oCjv1Z9pv/7dg2JDtqoMwaTw0XnoJhqh6krIk55XD846r100l
   CQyKNCviKGlIlQvhs/a27sgH4IgQduwhbRn6XT0KlUibkjI+C8DxLau1W
   bQGlFOBkWVF6N/GWfn6y0ss98uylK337lt84xU7aPoM+QWTzjR+VkOrKT
   0bIzxevMwLmEG4vuOleJ69vSQP6G0PZSGpGrTBTnbFEemOJQO4Ufh8Z3S
   CBvnKym+IUG+WQx9TQa+cFfFXkPxhSkobYj2dyGq+CWyc4oBsOiaaIfuN
   mb6/NAGjVnTGTjlIsC3a7QsDovld1JkhMvVnrniOZGCbMVHv6vrIMp6no
   g==;
X-CSE-ConnectionGUID: y8Q0FIVVTeyqh+iA7G7QGw==
X-CSE-MsgGUID: NHnFhDxxRvChXLKbODkIZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339652"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339652"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:21 -0700
X-CSE-ConnectionGUID: r3BrcjKDSJONY4pZr3YdUQ==
X-CSE-MsgGUID: 9FSjHRHPTQWyN3aom4KQIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487189"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:21 -0700
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
Subject: [PATCH 03/19] sched/fair: Introduce helper functions to enforce LLC migration policy
Date: Sat, 11 Oct 2025 11:24:40 -0700
Message-Id: <d6830774db8e260af4da728c44e9f899376a0ea6.1760206683.git.tim.c.chen@linux.intel.com>
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

Cache-aware scheduling aggregates threads onto their preferred LLC,
mainly through load balancing. When the preferred LLC becomes
saturated, more threads are still placed there, increasing latency.
A mechanism is needed to limit aggregation so that the preferred LLC
does not become overloaded.

Introduce helper functions can_migrate_llc() and
can_migrate_llc_task() to enforce the LLC migration policy:

  1. Aggregate a task to its preferred LLC if both source and
     destination LLCs are not too busy (<50% utilization, tunable),
     or if doing so will not leave the preferred LLC much more
     imbalanced than the non-preferred one (>20% utilization
     difference, tunable, similar to imbalance_pct of the LLC domain).
  2. Allow moving a task from overloaded preferred LLC to a non preferred
     LLC if this will not cause the non preferred LLC to become
     too imbalanced to cause a later migration back.
  3. If both LLCs are too busy, let the generic load balance to spread
     the tasks.

This hysteresis prevents tasks from being migrated into and out of the
preferred LLC frequently (back and forth): the threshold for migrating
a task out of its preferred LLC is higher than that for migrating it
into the LLC.

Since aggregation tends to make the preferred LLC busier than others,
the imbalance tolerance is controlled by llc_imb_pct. If set to 0,
tasks may still aggregate to the preferred LLC as long as it is
not more utilized than the source LLC, preserving the preference.

Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/debug.c |   4 ++
 kernel/sched/fair.c  | 145 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |   5 ++
 3 files changed, 154 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 02e16b70a790..57bb04ebbf96 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -523,6 +523,10 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_SCHED_CACHE
+	debugfs_create_u32("llc_overload_pct", 0644, debugfs_sched, &llc_overload_pct);
+	debugfs_create_u32("llc_imb_pct", 0644, debugfs_sched, &llc_imb_pct);
+#endif
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	debugfs_fair_server_init();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ebb0d99a906..cd080468ddc9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1205,6 +1205,9 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
 #define EPOCH_PERIOD	(HZ / 100)	/* 10 ms */
 #define EPOCH_LLC_AFFINITY_TIMEOUT	5	/* 50 ms */
 
+__read_mostly unsigned int llc_overload_pct       = 50;
+__read_mostly unsigned int llc_imb_pct            = 20;
+
 static int llc_id(int cpu)
 {
 	if (cpu < 0)
@@ -9560,6 +9563,27 @@ static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_
 }
 
 #ifdef CONFIG_SCHED_CACHE
+/*
+ * The margin used when comparing LLC utilization with CPU capacity.
+ * Parameter llc_overload_pct determines the LLC load level where
+ * active LLC aggregation is done.
+ * Derived from fits_capacity().
+ *
+ * (default: ~50%)
+ */
+#define fits_llc_capacity(util, max)	\
+	((util) * 100 < (max) * llc_overload_pct)
+
+/*
+ * The margin used when comparing utilization.
+ * is 'util1' noticeably greater than 'util2'
+ * Derived from capacity_greater().
+ * Bias is in perentage.
+ */
+/* Allows dst util to be bigger than src util by up to bias percent */
+#define util_greater(util1, util2) \
+	((util1) * 100 > (util2) * (100 + llc_imb_pct))
+
 /* Called from load balancing paths with rcu_read_lock held */
 static __maybe_unused bool get_llc_stats(int cpu, unsigned long *util,
 					 unsigned long *cap)
@@ -9575,6 +9599,127 @@ static __maybe_unused bool get_llc_stats(int cpu, unsigned long *util,
 
 	return true;
 }
+
+/*
+ * Decision matrix according to the LLC utilization. To
+ * decide whether we can do task aggregation across LLC.
+ *
+ * By default, 50% is the threshold to treat the LLC as busy,
+ * and 20% is the utilization imbalance percentage to decide
+ * if the preferred LLC is busier than the non-preferred LLC.
+ *
+ * 1. moving towards the preferred LLC, dst is the preferred
+ *    LLC, src is not.
+ *
+ * src \ dst      30%  40%  50%  60%
+ * 30%            Y    Y    Y    N
+ * 40%            Y    Y    Y    Y
+ * 50%            Y    Y    G    G
+ * 60%            Y    Y    G    G
+ *
+ * 2. moving out of the preferred LLC, src is the preferred
+ *    LLC, dst is not:
+ *
+ * src \ dst      30%  40%  50%  60%
+ * 30%            N    N    N    N
+ * 40%            N    N    N    N
+ * 50%            N    N    G    G
+ * 60%            Y    N    G    G
+ *
+ * src :      src_util
+ * dst :      dst_util
+ * Y :        Yes, migrate
+ * N :        No, do not migrate
+ * G :        let the Generic load balance to even the load.
+ *
+ * The intention is that if both LLCs are quite busy, cache aware
+ * load balance should not be performed, and generic load balance
+ * should take effect. However, if one is busy and the other is not,
+ * the preferred LLC capacity(50%) and imbalance criteria(20%) should
+ * be considered to determine whether LLC aggregation should be
+ * performed to bias the load towards the preferred LLC.
+ */
+
+/* migration decision, 3 states are orthogonal. */
+enum llc_mig {
+	mig_forbid = 0,		/* N: Don't migrate task, respect LLC preference */
+	mig_llc,		/* Y: Do LLC preference based migration */
+	mig_unrestricted	/* G: Don't restrict generic load balance migration */
+};
+
+static enum llc_mig can_migrate_llc(int src_cpu, int dst_cpu,
+				    unsigned long tsk_util,
+				    bool to_pref)
+{
+	unsigned long src_util, dst_util, src_cap, dst_cap;
+
+	if (!get_llc_stats(src_cpu, &src_util, &src_cap) ||
+	    !get_llc_stats(dst_cpu, &dst_util, &dst_cap))
+		return mig_unrestricted;
+
+	if (!fits_llc_capacity(dst_util, dst_cap) &&
+	    !fits_llc_capacity(src_util, src_cap))
+		return mig_unrestricted;
+
+	src_util = src_util < tsk_util ? 0 : src_util - tsk_util;
+	dst_util = dst_util + tsk_util;
+	if (to_pref) {
+		/*
+		 * llc_imb_pct is the imbalance allowed between
+		 * preferred LLC and non-preferred LLC.
+		 * Don't migrate if we will get preferred LLC too
+		 * heavily loaded and if the dest is much busier
+		 * than the src, in which case migration will
+		 * increase the imbalance too much.
+		 */
+		if (!fits_llc_capacity(dst_util, dst_cap) &&
+		    util_greater(dst_util, src_util))
+			return mig_forbid;
+	} else {
+		/*
+		 * Don't migrate if we will leave preferred LLC
+		 * too idle, or if this migration leads to the
+		 * non-preferred LLC falls within sysctl_aggr_imb percent
+		 * of preferred LLC, leading to migration again
+		 * back to preferred LLC.
+		 */
+		if (fits_llc_capacity(src_util, src_cap) ||
+		    !util_greater(src_util, dst_util))
+			return mig_forbid;
+	}
+	return mig_llc;
+}
+
+/*
+ * Check if task p can migrate from src_cpu to dst_cpu
+ * in terms of cache aware load balance.
+ */
+static __maybe_unused enum llc_mig can_migrate_llc_task(int src_cpu, int dst_cpu,
+							struct task_struct *p)
+{
+	struct mm_struct *mm;
+	bool to_pref;
+	int cpu;
+
+	mm = p->mm;
+	if (!mm)
+		return mig_unrestricted;
+
+	cpu = mm->mm_sched_cpu;
+	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
+		return mig_unrestricted;
+
+	if (cpus_share_cache(dst_cpu, cpu))
+		to_pref = true;
+	else if (cpus_share_cache(src_cpu, cpu))
+		to_pref = false;
+	else
+		return mig_unrestricted;
+
+	return can_migrate_llc(src_cpu, dst_cpu,
+			       task_util(p), to_pref);
+}
+
 #else
 static inline bool get_llc_stats(int cpu, unsigned long *util,
 				 unsigned long *cap)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2ded8d3d0ecc..a52c96064b36 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2797,6 +2797,11 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 
+#ifdef CONFIG_SCHED_CACHE
+extern unsigned int llc_overload_pct;
+extern unsigned int llc_imb_pct;
+#endif
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
-- 
2.32.0



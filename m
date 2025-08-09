Return-Path: <linux-kernel+bounces-760940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E63B1F233
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CE46220C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3503A274B43;
	Sat,  9 Aug 2025 05:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZoFv+co"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097E125D6
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716161; cv=none; b=Rm7TcpHSNUIIoFYEPwrZQSk2+mFBFaIi8Biv/YBu8NhjoOpqLYiSDc8n/N7a+PcWKj1D5lN8yxsfXFZpqwNZo9V27otdxT/bMNi/j+pCcQsy85gMx6mqoYUfLUdWB0a4zERaoznppBe6okhDs8L/kX4GGnSX8g32CRW4pXc/jS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716161; c=relaxed/simple;
	bh=V4wQFWsJMut3Mv4WM/pNBpXZswfWqWCXgqNTuOQgQwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tR/Eg9pwE3kfKHQ1XrSvfns7tRo1/54dBTa3Mcw/Vf9PUP5J9yjcpYZjzIWQ96CkLtFqrg19Zl0Cj25CGXm9QEsmQiICsQrbY8sep3kg5LmP1PeugdTFvBMNkphNKcutc0NLmiPwdKekqx5gwUaOM5x4KAy1UaLJ56yS2wqthlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZoFv+co; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716160; x=1786252160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V4wQFWsJMut3Mv4WM/pNBpXZswfWqWCXgqNTuOQgQwc=;
  b=cZoFv+cooYycPX6fhTDFz3M70RpTXLjWW54A4RKCHWeGADL7LpNgffxW
   gBfRlECeZkPmt7ZbNEgFqOrc7h37RbVfI0hpXkfJXAbSVhFqX1dyT3XdI
   KBuYaf5c3EOsWZOREhMvQUtHsoLmWta+xL56O2v1gsR3leEwTYp2Wagee
   zuCK7oxtqjbXilAu6g6eLj5fAL1la9xryvQW3Hx9lwncNu2ChThNoNOIL
   8rqMMvopoFaWOd9vVKtpzIX0eyrh2S0jAjm/gycY3Z9ipQFIzNCz17K0J
   RJ7dwofq53rsYOMlEnDTxOs2VjSm+OkCdnAYfR59wl5PkmnVd8HuSY4K7
   g==;
X-CSE-ConnectionGUID: U6TaVEBsQ1urnPH9VT6FpQ==
X-CSE-MsgGUID: xLUFPU/zRaayB1BNHTCWGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57137798"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57137798"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:09:19 -0700
X-CSE-ConnectionGUID: MAk8xVHNTeiRA2GQcBH6/g==
X-CSE-MsgGUID: rE8RpT+sQLqRJLnxvLOvng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165374559"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa006.fm.intel.com with ESMTP; 08 Aug 2025 22:09:13 -0700
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
Subject: [RFC PATCH v4 07/28] sched: Add helper function to decide whether to allow cache aware scheduling
Date: Sat,  9 Aug 2025 13:03:10 +0800
Message-Id: <701c7be7f0e69582d9ad0c25025ec2e133e73fbb.1754712565.git.tim.c.chen@linux.intel.com>
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

From: Tim Chen <tim.c.chen@linux.intel.com>

Cache-aware scheduling is designed to aggregate threads into their
preferred LLC, either via the task wake up path or the load balancing
path. One side effect is that when the preferred LLC is saturated,
more threads will continue to be stacked on it, degrading the workload's
latency. A strategy is needed to prevent this aggregation from going too
far such that the preferred LLC is too overloaded.

Introduce helper function _get_migrate_hint() to implement the
LLC migration policy:

1) A task is aggregated to its preferred LLC if both source/dest LLC
   are not too busy (<50% utilization, tunable), or the preferred
   LLC will not be too out of balanced from the non preferred LLC
   (>20% utilization, tunable, close to imbalance_pct of the LLC
   domain).
2) Allow a task to be moved from the preferred LLC to the
   non-preferred one if the non-preferred LLC will not be too out
   of balanced from the preferred prompting an aggregation task
   migration later.  We are still experimenting with the aggregation
   and migration policy. Some other possibilities are policy based
   on LLC's load or average number of tasks running.  Those could
   be tried out by tweaking _get_migrate_hint().

The function _get_migrate_hint() returns migration suggestions for
the upper-level functions.

Aggregation will tend to make utilization on the preferred LLC to
be more than the non-preferred one. Parameter "sysctl_llc_aggr_imb"
is the imbalance allowed. If it is set to 0, as long as the preferred
LLC is not utilized more than the source LLC, we could still aggregate
towards the preferred LLC and a preference could still be there.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/debug.c |   4 ++
 kernel/sched/fair.c  | 110 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   5 ++
 3 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 557246880a7e..682fd91a42a0 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -532,6 +532,10 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
 #endif
 
+#ifdef CONFIG_SCHED_CACHE
+	debugfs_create_u32("llc_aggr_cap", 0644, debugfs_sched, &sysctl_llc_aggr_cap);
+	debugfs_create_u32("llc_aggr_imb", 0644, debugfs_sched, &sysctl_llc_aggr_imb);
+#endif
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	debugfs_fair_server_init();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4f79b7652642..3128dbcf0a36 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8826,7 +8826,39 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 }
 
 #ifdef CONFIG_SCHED_CACHE
-static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle);
+static long __migrate_degrades_locality(struct task_struct *p,
+					int src_cpu, int dst_cpu,
+					bool idle);
+__read_mostly unsigned int sysctl_llc_aggr_cap       = 50;
+__read_mostly unsigned int sysctl_llc_aggr_imb       = 20;
+
+/*
+ * The margin used when comparing LLC utilization with CPU capacity.
+ * Parameter sysctl_llc_aggr_cap determines the LLC load level where
+ * active LLC aggregation is done.
+ * Derived from fits_capacity().
+ *
+ * (default: ~50%)
+ */
+#define fits_llc_capacity(util, max)	\
+	((util) * 100 < (max) * sysctl_llc_aggr_cap)
+
+/*
+ * The margin used when comparing utilization.
+ * is 'util1' noticeably greater than 'util2'
+ * Derived from capacity_greater().
+ * Bias is in perentage.
+ */
+/* Allows dst util to be bigger than src util by up to bias percent */
+#define util_greater(util1, util2) \
+	((util1) * 100 > (util2) * (100 + sysctl_llc_aggr_imb))
+
+enum llc_mig_hint {
+	mig_allow = 0,
+	mig_ignore,
+	mig_forbid
+};
+
 
 /* expected to be protected by rcu_read_lock() */
 static bool get_llc_stats(int cpu, unsigned long *util,
@@ -8844,6 +8876,82 @@ static bool get_llc_stats(int cpu, unsigned long *util,
 	return true;
 }
 
+static enum llc_mig_hint _get_migrate_hint(int src_cpu, int dst_cpu,
+					   unsigned long tsk_util,
+					   bool to_pref)
+{
+	unsigned long src_util, dst_util, src_cap, dst_cap;
+
+	if (cpus_share_cache(src_cpu, dst_cpu))
+		return mig_allow;
+
+	if (!get_llc_stats(src_cpu, &src_util, &src_cap) ||
+	    !get_llc_stats(dst_cpu, &dst_util, &dst_cap))
+		return mig_ignore;
+
+	if (!fits_llc_capacity(dst_util, dst_cap) &&
+	    !fits_llc_capacity(src_util, src_cap))
+		return mig_ignore;
+
+	src_util = src_util < tsk_util ? 0 : src_util - tsk_util;
+	dst_util = dst_util + tsk_util;
+	if (to_pref) {
+		/*
+		 * sysctl_llc_aggr_imb is the imbalance allowed between
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
+	return mig_allow;
+}
+
+/*
+ * Give suggestion when task p is migrated from src_cpu to dst_cpu.
+ */
+static __maybe_unused enum llc_mig_hint get_migrate_hint(int src_cpu, int dst_cpu,
+							 struct task_struct *p)
+{
+	struct mm_struct *mm;
+	int cpu;
+
+	if (cpus_share_cache(src_cpu, dst_cpu))
+		return mig_allow;
+
+	mm = p->mm;
+	if (!mm)
+		return mig_allow;
+
+	cpu = mm->mm_sched_cpu;
+	if (cpu < 0)
+		return mig_allow;
+
+	if (cpus_share_cache(dst_cpu, cpu))
+		return _get_migrate_hint(src_cpu, dst_cpu,
+					 task_util(p), true);
+	else if (cpus_share_cache(src_cpu, cpu))
+		return _get_migrate_hint(src_cpu, dst_cpu,
+					 task_util(p), false);
+	else
+		return mig_allow;
+}
+
 static int select_cache_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct mm_struct *mm = p->mm;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f4ab45ecca86..83552aab74fb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2844,6 +2844,11 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 
+#ifdef CONFIG_SCHED_CACHE
+extern unsigned int sysctl_llc_aggr_cap;
+extern unsigned int sysctl_llc_aggr_imb;
+#endif
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
-- 
2.25.1



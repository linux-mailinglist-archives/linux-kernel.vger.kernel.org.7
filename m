Return-Path: <linux-kernel+bounces-849255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D90CBCFAB4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BC118863BA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13789283FE0;
	Sat, 11 Oct 2025 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOR0vW8+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E8128D850
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206719; cv=none; b=Xx1TJtOzMlihMYBSPUxuHxJ0Qjx1gDS60TVsBbaW2YAWG207+fLDuebhtY/m9byeKfuUMx/7RVc7mR4xE94pKemXSaF1s6z/Ug1MSbyJDL/f+gYUVN9JWyZVsl4nskC5I36GvI9Reswdcqif7FIqp4+OT03g4Ursen0Zl0KoJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206719; c=relaxed/simple;
	bh=6DqahwvJ4pGTYe3R6NSaO1UYdqKyQR0MiqAECtQawPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqNPDsqjikNan+1NtjFEbAg77jx9c3inhDW4V8l0uRiJhbQOXCuc9b1G6bYocgAvzvRSIQ0C9pHEOzGrnitQnTKHR4lM01jV+sq5AGE2Z0YUwNbJ3G2iOFzcz198JhG1QAmKUE7Vocf7AQigiloGd31ZcAGpFcHlx+XOPevHRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOR0vW8+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206717; x=1791742717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6DqahwvJ4pGTYe3R6NSaO1UYdqKyQR0MiqAECtQawPE=;
  b=iOR0vW8+BW1BG+CuQKpeekNgIJXVik0HqP3JsArGSk608O/BAqQp2/2V
   NevdC5FBoGU0UJqaEBq3eyHXjM8fq6f/t4e0BsD23dpBBveuXe++OVX8Y
   Aapb+EWCp+mFsFeSqc6EHn1EKVQFE1axOMUnDuAWrAcUGMdrmUl0Sqt8l
   gPm1isDiRNA4VWnGAtuiefQtTbQsCK7LA3hCWV2kYbD78VwasjvY/a8Zs
   eIWoDg9eon7/Ajv/YxTCU8u2KHeYWmlazBkEjZ2+x2uGykUr+ha3ebndP
   Ilvnp7dapSvlsm6l5tNbjmODs4GBS1SErTGbDlGwNscJODVWeB1whKGtb
   g==;
X-CSE-ConnectionGUID: iwkdIGQ9QpepiaCCmITr2A==
X-CSE-MsgGUID: vpqcAnIxSGm05xalZwxCuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339958"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339958"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:36 -0700
X-CSE-ConnectionGUID: l0yVaxC3RhO6SKkG+8NgJA==
X-CSE-MsgGUID: KHjGlLwMQh2OAr5o5sZaPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487263"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:36 -0700
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
Subject: [PATCH 19/19] sched/fair: Add user control to adjust the tolerance of cache-aware scheduling
Date: Sat, 11 Oct 2025 11:24:56 -0700
Message-Id: <afe7603c37fe76064d769ce9d78df494347a748c.1760206683.git.tim.c.chen@linux.intel.com>
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

With sched_cache enabled, the scheduler uses a process's RSS as a
proxy for its LLC footprint to determine if aggregating tasks on the
preferred LLC could cause cache contention. If RSS exceeds the LLC
size, aggregation is skipped. Some workloads with large RSS but small
actual memory footprints may still benefit from aggregation. Since
the kernel cannot efficiently track per-task cache usage (resctrl is
user-space only), userspace can provide a more accurate hint.

Introduce /sys/kernel/debug/sched/llc_aggr_tolerance to let
users control how strictly RSS limits aggregation. Values range from
0 to 100:

  - 0: Cache-aware scheduling is disabled.
  - 1: Strict; tasks with RSS larger than LLC size are skipped.
  - 100: Aggressive; tasks are aggregated regardless of RSS.

For example, with a 32MB L3 cache:

  - llc_aggr_tolerance=1 -> tasks with RSS > 32MB are skipped.
  - llc_aggr_tolerance=99 -> tasks with RSS > 784GB are skipped
    (784GB = (1 + (99 - 1) * 256) * 32MB).

Similarly, /sys/kernel/debug/sched/llc_aggr_tolerance also controls
how strictly the number of active threads is considered when doing
cache aware load balance. The number of SMTs is also considered.
High SMT counts reduce the aggregation capacity, preventing excessive
task aggregation on SMT-heavy systems like Power10/Power11.

For example, with 8 Cores/16 CPUs in a L3:

  - llc_aggr_tolerance=1 -> tasks with nr_running > 8 are skipped.
  - llc_aggr_tolerance=99 -> tasks with nr_running > 785 are skipped
    785 = (1 + (99 - 1) * 8).

Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reported-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reported-by: Tingyin Duan <tingyin.duan@gmail.com>
Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/debug.c | 56 ++++++++++++++++++++++++++++++--
 kernel/sched/fair.c  | 76 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  3 ++
 3 files changed, 126 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 57bb04ebbf96..cfcd8b436cc5 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -169,6 +169,50 @@ static const struct file_operations sched_feat_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SCHED_CACHE
+#define SCHED_CACHE_CREATE_CONTROL(name)			  \
+static ssize_t sched_cache_write_##name(struct file *filp,	  \
+					const char __user *ubuf,  \
+					size_t cnt, loff_t *ppos) \
+{								  \
+	char buf[16];						  \
+	unsigned int percent;					  \
+	if (cnt > 15)						  \
+		cnt = 15;					  \
+	if (copy_from_user(&buf, ubuf, cnt))			  \
+		return -EFAULT;					  \
+	buf[cnt] = '\0';					  \
+	if (kstrtouint(buf, 10, &percent))			  \
+		return -EINVAL;					  \
+	if (percent > 100)					  \
+		return -EINVAL;					  \
+	llc_##name = percent;					  \
+	*ppos += cnt;						  \
+	return cnt;						  \
+}								  \
+static int sched_cache_show_##name(struct seq_file *m, void *v)	  \
+{								  \
+	seq_printf(m, "%d\n", llc_##name);			  \
+	return 0;						  \
+}								  \
+static int sched_cache_open_##name(struct inode *inode,		  \
+				   struct file *filp)		  \
+{								  \
+	return single_open(filp, sched_cache_show_##name, NULL);  \
+}								  \
+static const struct file_operations sched_cache_fops_##name = {	  \
+	.open		= sched_cache_open_##name,		  \
+	.write		= sched_cache_write_##name,		  \
+	.read		= seq_read,				  \
+	.llseek		= seq_lseek,				  \
+	.release	= single_release,			  \
+}
+
+SCHED_CACHE_CREATE_CONTROL(overload_pct);
+SCHED_CACHE_CREATE_CONTROL(imb_pct);
+SCHED_CACHE_CREATE_CONTROL(aggr_tolerance);
+#endif /* SCHED_CACHE */
+
 static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
 				   size_t cnt, loff_t *ppos)
 {
@@ -524,8 +568,16 @@ static __init int sched_init_debug(void)
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_SCHED_CACHE
-	debugfs_create_u32("llc_overload_pct", 0644, debugfs_sched, &llc_overload_pct);
-	debugfs_create_u32("llc_imb_pct", 0644, debugfs_sched, &llc_imb_pct);
+	debugfs_create_file("llc_overload_pct", 0644, debugfs_sched, NULL,
+			    &sched_cache_fops_overload_pct);
+	debugfs_create_file("llc_imb_pct", 0644, debugfs_sched, NULL,
+			    &sched_cache_fops_imb_pct);
+	debugfs_create_file("llc_aggr_tolerance", 0644, debugfs_sched, NULL,
+			    &sched_cache_fops_aggr_tolerance);
+	debugfs_create_u32("llc_epoch_period", 0644, debugfs_sched,
+			   &llc_epoch_period);
+	debugfs_create_u32("llc_epoch_affinity_timeout", 0644, debugfs_sched,
+			   &llc_epoch_affinity_timeout);
 #endif
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46dfcd2a01b3..f9084e2f9ef2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1207,9 +1207,62 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
 
 __read_mostly unsigned int llc_overload_pct       = 50;
 __read_mostly unsigned int llc_imb_pct            = 20;
+__read_mostly unsigned int llc_aggr_tolerance     = 1;
+__read_mostly unsigned int llc_epoch_period       = EPOCH_PERIOD;
+__read_mostly unsigned int llc_epoch_affinity_timeout = EPOCH_LLC_AFFINITY_TIMEOUT;
 
 DEFINE_STATIC_KEY_FALSE(sched_cache_allowed);
 
+static inline int get_sched_cache_scale(int mul)
+{
+	if (!llc_aggr_tolerance)
+		return 0;
+
+	if (llc_aggr_tolerance == 100)
+		return INT_MAX;
+
+	return (1 + (llc_aggr_tolerance - 1) * mul);
+}
+
+static inline int get_sched_cache_rss_scale(void)
+{
+	/*
+	 * Suppose the L3 size is 32MB. If the
+	 * llc_aggr_tolerance is 1:
+	 * When the RSS is larger than 32MB,
+	 * the process is regarded as exceeding
+	 * the LLC capacity. If the
+	 * llc_aggr_tolerance is 99:
+	 * When the RSS is larger than 784GB,
+	 * the process is regarded as exceeding
+	 * the LLC capacity:
+	 * 784GB = (1 + (99 - 1) * 256) * 32MB
+	 */
+	return get_sched_cache_scale(256);
+}
+
+static inline int get_sched_cache_nr_scale(void)
+{
+	/*
+	 * Suppose the number of Cores in LLC is 8.
+	 * Every core has 2 SMTs.
+	 * If the llc_aggr_tolerance is 1: When the
+	 * nr_running is larger than 8, the process
+	 * is regarded as exceeding the LLC capacity.
+	 * If the llc_aggr_tolerance is 99:
+	 * When the nr_running is larger than 785,
+	 * the process is regarded as exceeding
+	 * the LLC capacity:
+	 * 785 = 1 + (99 - 1) * 8
+	 */
+	return get_sched_cache_scale(1);
+}
+
+static inline int get_sched_cache_cap_scale(void)
+{
+	return (llc_overload_pct / cpu_smt_num_threads);
+}
+
 static inline bool sched_cache_enabled(void)
 {
 	return sched_feat(SCHED_CACHE) &&
@@ -1245,6 +1298,7 @@ static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
 	struct cacheinfo *ci;
 	unsigned long rss;
 	unsigned int llc;
+	int scale;
 
 	/*
 	 * get_cpu_cacheinfo_level() can not be used
@@ -1269,19 +1323,27 @@ static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
 	rss = get_mm_counter(mm, MM_ANONPAGES) +
 		get_mm_counter(mm, MM_SHMEMPAGES);
 
-	return (llc <= (rss * PAGE_SIZE));
+	scale = get_sched_cache_rss_scale();
+	if (scale == INT_MAX)
+		return false;
+
+	return ((llc * scale) <= (rss * PAGE_SIZE));
 }
 
 static bool exceed_llc_nr(struct mm_struct *mm, int cpu)
 {
-	int smt_nr = 1;
+	int smt_nr = 1, scale;
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active())
 		smt_nr = cpumask_weight(cpu_smt_mask(cpu));
 #endif
 
-	return ((mm->nr_running_avg * smt_nr) > per_cpu(sd_llc_size, cpu));
+	scale = get_sched_cache_nr_scale();
+	if (scale == INT_MAX)
+		return false;
+
+	return ((mm->nr_running_avg * smt_nr) > (scale * per_cpu(sd_llc_size, cpu)));
 }
 
 static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
@@ -1370,9 +1432,9 @@ static inline void __update_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
 	long delta = now - rq->cpu_epoch_next;
 
 	if (delta > 0) {
-		n = (delta + EPOCH_PERIOD - 1) / EPOCH_PERIOD;
+		n = (delta + llc_epoch_period - 1) / llc_epoch_period;
 		rq->cpu_epoch += n;
-		rq->cpu_epoch_next += n * EPOCH_PERIOD;
+		rq->cpu_epoch_next += n * llc_epoch_period;
 		__shr_u64(&rq->cpu_runtime, n);
 	}
 
@@ -1432,7 +1494,7 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	 * has only 1 thread, or has too many active threads, invalidate
 	 * its preferred state.
 	 */
-	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_LLC_AFFINITY_TIMEOUT ||
+	if (epoch - READ_ONCE(mm->mm_sched_epoch) > llc_epoch_affinity_timeout ||
 	    get_nr_threads(p) <= 1 ||
 	    exceed_llc_nr(mm, cpu_of(rq)) ||
 	    exceed_llc_capacity(mm, cpu_of(rq))) {
@@ -9749,7 +9811,7 @@ static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_
  * (default: ~50%)
  */
 #define fits_llc_capacity(util, max)	\
-	((util) * 100 < (max) * llc_overload_pct)
+	((util) * 100 < (max) * get_sched_cache_cap_scale())
 
 /*
  * The margin used when comparing utilization.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b801d32d5fba..97e8558b0530 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2810,6 +2810,9 @@ extern unsigned int sysctl_numa_balancing_hot_threshold;
 #ifdef CONFIG_SCHED_CACHE
 extern unsigned int llc_overload_pct;
 extern unsigned int llc_imb_pct;
+extern unsigned int llc_aggr_tolerance;
+extern unsigned int llc_epoch_period;
+extern unsigned int llc_epoch_affinity_timeout;
 extern struct static_key_false sched_cache_allowed;
 #endif
 
-- 
2.32.0



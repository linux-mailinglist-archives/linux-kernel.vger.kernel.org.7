Return-Path: <linux-kernel+bounces-760961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EDDB1F24A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDEE7A8F29
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525B02797A9;
	Sat,  9 Aug 2025 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y90Y97GH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD69278E77
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716517; cv=none; b=f0wCf0A1e24ot1gDONm8873CUbeJO7p+XOYXyd1L81oXyHjWyDUgzMJcD0hJ3DF8nImLeld/DZRB4Rw1t1WEKTNhLr+PgIxdQt1pezZAV7PflwC9pScJMoIsibbNOHtKzaO++na+m07o/7UQdsk+sPTfO2f6+LpbJhepVHPoteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716517; c=relaxed/simple;
	bh=/Ba0fCfCtChaUyr8nA+Reo2+vDWT1X8nPBpOr+cNYjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EDkKLloCKeEh8IprYHQ5cLYC7XD5yrfwdWMtkoq85n7q8KXHTNKJtaTomDYe5XtQCLNBxnEyUumHNx4/C6VKj/drV2J40y00jxpuHKC2otW2Agu5fvbDIBaIndWVIczwxgu3StyAleOP2GSxyPvAaYACU8MlGinZXBKpz5KxMhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y90Y97GH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716515; x=1786252515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Ba0fCfCtChaUyr8nA+Reo2+vDWT1X8nPBpOr+cNYjk=;
  b=Y90Y97GHLKUMgwRE30WxTWa+nQqnGyCMmuH77cLq8i/vdaPuuN2Ktztv
   zBg5w7QsE4Tap803U0WzbsFCGqUe1e5QS4yNcC38D0ELqu1BwsHy6z+jR
   WhnmKOXM13ylYTNfpsosT8H/fTVU1o4HavW4jD2mb3Xd/w2lpl/NwsKv1
   lUdWhkLxUWSHTQXwZSwGQLULWx/qg/CpYON81o3vjH2gAxshxAoSNBtaB
   P0r4Ex0Lc94pbcpxMXlN2Yvf/QybuyXM6p6DUPSf0Ju1um2BF6tKB2GEf
   jmV33bJNWsB01mTnWfFZ55QI4h+P2NvGIgzeEkg3JsyzHbN7Qffq9u85f
   Q==;
X-CSE-ConnectionGUID: ktJ3gmikQC2MxSJlFd01xQ==
X-CSE-MsgGUID: gbMwARUNRLGJ2ccZVMMRBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56260030"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56260030"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:15:13 -0700
X-CSE-ConnectionGUID: lbKBkeQYTzKHrxkrdXEGtA==
X-CSE-MsgGUID: NxMJcQ1jQD24A6f12YxIFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165476192"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa007.jf.intel.com with ESMTP; 08 Aug 2025 22:15:08 -0700
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
Subject: [RFC PATCH v4 27/28] sched: Allow the user space to tune the scale factor for RSS comparison
Date: Sat,  9 Aug 2025 13:09:02 +0800
Message-Id: <81c197882b7c9f4325a5cb32f8a9d1e1fc900297.1754712565.git.tim.c.chen@linux.intel.com>
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

sched_cache compares the process's resident pages with
the size of the LLC to determine whether task aggregation
on the preferred LLC might cause cache contention. If the
former is larger than the latter, skip cache-aware task
aggregation. However, some workloads with large resident
pages have a small memory footprint; such workloads could
benefit from cache-aware scheduling. The kernel lacks a
efficient mechanism to track the task's memory footprint
(yes, we have resctrl, but it is for user-space query,
and not process scope), so it is up to userspace to pass
this hint to the kernel.

Introduce /sys/kernel/debug/sched/sched_cache_ignore_rss
to control the extent to which users ignore the RSS
restriction. This value ranges from 0 to 100. A value of
0 means that the user disables the cache aware scheduling.
1 means if a process's RSS is larger than the LLC size,
cache-aware scheduling will be skipped. 100 means cache
aware scheduling is alwasy enabled regardless of RSS size.
N (between 1 and 100) means turn off cache aware scheduling
when RSS is greater than (N-1) * 256 * LLC size

For example, suppose the L3 size is 32MB. If the
sysctl_sched_cache_ignore_rss is 1: When the RSS is larger
than 32MB, the process is regarded as exceeding the LLC capacity.
If the sysctl_sched_cache_ignore_rss is 99: When the RSS is
larger than 784GB, the process is regarded as exceeding the
LLC capacity(please refer to the code):
784GB = (1 + (99 - 1) * 256) * 32MB

Additionally, the number of SMTs is also considered for
sysctl_sched_cache_aggr_cap; if there are many SMTs in the core,
sysctl_llc_aggr_cap will be reduced. This inhibits task aggregation
from cache-aware scheduling on systems with a high number of SMTs,
like Power 10 and Power 11.

Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reported-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/debug.c | 82 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/fair.c  | 10 ++++--
 kernel/sched/sched.h |  3 +-
 3 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 7a9ec03704b9..6676fc2a8c08 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -166,6 +166,83 @@ static const struct file_operations sched_feat_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SCHED_CACHE
+#define SCHED_CACHE_CREATE_CONTROL(name, val)			  \
+static int sysctl_sched_cache_##name = val;			  \
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
+	sysctl_sched_cache_##name = percent;			  \
+	*ppos += cnt;						  \
+	return cnt;						  \
+}								  \
+static int sched_cache_show_##name(struct seq_file *m, void *v)	  \
+{								  \
+	seq_printf(m, "%d\n", sysctl_sched_cache_##name);	  \
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
+SCHED_CACHE_CREATE_CONTROL(ignore_rss, 1);
+int get_sched_cache_rss_scale(void)
+{
+	if (!sysctl_sched_cache_ignore_rss)
+		return 0;
+
+	if (sysctl_sched_cache_ignore_rss >= 100)
+		return INT_MAX;
+	/*
+	 * Suppose the L3 size is 32MB. If the
+	 * sysctl_sched_cache_ignore_rss is 1:
+	 * When the RSS is larger than 32MB,
+	 * the process is regarded as exceeding
+	 * the LLC capacity. If the
+	 * sysctl_sched_cache_ignore_rss is 99:
+	 * When the RSS is larger than 784GB,
+	 * the process is regarded as exceeding
+	 * the LLC capacity:
+	 * 784GB = (1 + (99 - 1) * 256) * 32MB
+	 */
+	return (1 + (sysctl_sched_cache_ignore_rss - 1) * 256);
+}
+
+SCHED_CACHE_CREATE_CONTROL(aggr_cap, 50);
+int get_sched_cache_cap_scale(void)
+{
+	int smt_nr = 1;
+
+#ifdef CONFIG_SCHED_SMT
+	if (sched_smt_active())
+		smt_nr =
+			cpumask_weight(cpu_smt_mask(raw_smp_processor_id()));
+#endif
+	return (sysctl_sched_cache_aggr_cap / smt_nr);
+}
+#endif /* SCHED_CACHE */
+
 #ifdef CONFIG_SMP
 
 static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
@@ -533,10 +610,13 @@ static __init int sched_init_debug(void)
 #endif
 
 #ifdef CONFIG_SCHED_CACHE
-	debugfs_create_u32("llc_aggr_cap", 0644, debugfs_sched, &sysctl_llc_aggr_cap);
 	debugfs_create_u32("llc_aggr_imb", 0644, debugfs_sched, &sysctl_llc_aggr_imb);
 	debugfs_create_u32("llc_period", 0644, debugfs_sched, &sysctl_llc_period);
 	debugfs_create_u32("llc_old", 0644, debugfs_sched, &sysctl_llc_old);
+	debugfs_create_file("llc_aggr_cap", 0644, debugfs_sched, NULL,
+			    &sched_cache_fops_aggr_cap);
+	debugfs_create_file("llc_ignore_rss", 0644, debugfs_sched, NULL,
+			    &sched_cache_fops_ignore_rss);
 #endif
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cbda7dad1305..018825f04063 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1211,6 +1211,7 @@ static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
 	struct cacheinfo *l3_leaf;
 	unsigned long rss;
 	unsigned int llc;
+	int scale;
 
 	/*
 	 * get_cpu_cacheinfo_level() can not be used
@@ -1230,7 +1231,11 @@ static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
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
@@ -9037,7 +9042,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 static long __migrate_degrades_locality(struct task_struct *p,
 					int src_cpu, int dst_cpu,
 					bool idle);
-__read_mostly unsigned int sysctl_llc_aggr_cap       = 50;
 __read_mostly unsigned int sysctl_llc_aggr_imb       = 20;
 
 /*
@@ -9049,7 +9053,7 @@ __read_mostly unsigned int sysctl_llc_aggr_imb       = 20;
  * (default: ~50%)
  */
 #define fits_llc_capacity(util, max)	\
-	((util) * 100 < (max) * sysctl_llc_aggr_cap)
+	((util) * 100 < (max) * get_sched_cache_cap_scale())
 
 /*
  * The margin used when comparing utilization.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d752d64d4acd..eaeca4e77ead 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2855,11 +2855,12 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 
 #ifdef CONFIG_SCHED_CACHE
-extern unsigned int sysctl_llc_aggr_cap;
 extern unsigned int sysctl_llc_aggr_imb;
 extern struct static_key_false sched_cache_present;
 extern unsigned int sysctl_llc_period;
 extern unsigned int sysctl_llc_old;
+int get_sched_cache_rss_scale(void);
+int get_sched_cache_cap_scale(void);
 #endif
 
 #ifdef CONFIG_SCHED_HRTICK
-- 
2.25.1



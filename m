Return-Path: <linux-kernel+bounces-760941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7B5B1F234
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFFF188BBAC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE14275872;
	Sat,  9 Aug 2025 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OW5YzRQl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24F2749D5
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716177; cv=none; b=NNJRjopqrRbhFk19x1BndJWZ90HqNxRnx0H7JE+07eSr/bdUJMU/c0NJ3LB2cV94Rsi1R1AdGM1d2xlML1jh2RnTHB1Dzdvr0qBwgdFuA8zjncQEUZO6kHF1Y2GSQmE70Toj/gzstTrxtr3JAqld0iuOXw9GF3i3gZmGNxoXo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716177; c=relaxed/simple;
	bh=Q9WyVWFAxaya8q+BQJRZR5gSlB4xoSQBTrL3eFp0H3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJCxUgjq3LhGvzfQnlmgDk0eZNcoMO3+ooDXAn+dS2XPaoAD00XBVRhoIDDmzlGUakQWDO9E3wgaByP2px0tcqYpCXMaz1PTKVbRf0IMfCL7wmj/Pl6WrMp5Uk7woFJsPxrVPRghCGLe/mewLfBt3ueL13B0csiHsH9qkS/YD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OW5YzRQl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716176; x=1786252176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q9WyVWFAxaya8q+BQJRZR5gSlB4xoSQBTrL3eFp0H3k=;
  b=OW5YzRQlQh/nBHXwqrjN0l8Y7LfITnFjeexFpLxenGyiJvbsUX2LdH+f
   NmdygIjqrdclruZgedLbBxuvOrc8rS64ODYq+fjwfwXQVB0yteRfnTP/u
   KUJ6NLJp7E5qLizUurKDYQ/CQ8WhKvO+A1CCWJcny7Ywyk5pWHn0+ihL2
   fyfKV1cKZRnLjLxVHkt7AZCj9E7OPIlGwDuDChPwUD61pbaKxh7wR9gpr
   q7g35VzJcDGPAJtv/VzN73wW2yx/6zcGH0VLxrR+XHBCqIvDlMHA2v4f0
   DYgKaiB40pfFiu4dwUi7Ps3HxC6vxt6/7c8fQVryZXz/WrZQ5I8EfdNEJ
   A==;
X-CSE-ConnectionGUID: Y02Bl/8pShaUv1kRhHj39A==
X-CSE-MsgGUID: 3/idV79SS1m5g1kaTEBzDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57137811"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57137811"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:09:34 -0700
X-CSE-ConnectionGUID: XuuWOYxBTOOma0SA+bSkWg==
X-CSE-MsgGUID: Ip2uRtmWRum9W2ItftRIPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165374575"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa006.fm.intel.com with ESMTP; 08 Aug 2025 22:09:28 -0700
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
Subject: [RFC PATCH v4 08/28] sched: Set up LLC indexing
Date: Sat,  9 Aug 2025 13:03:24 +0800
Message-Id: <959d897daadc28b8115c97df04eec2af0fd79c5d.1754712565.git.tim.c.chen@linux.intel.com>
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

Prepare for indexing arrays that track in each run queue: the number
of tasks preferring current LLC and each of the other LLC.

The reason to introduce LLC index is because the per LLC-scope data
is needed to do cache aware load balancing. However, the native lld_id
is usually the first CPU of that LLC domain, which is not continuous,
which might waste the space if the per LLC-scope data is stored
in an array (in current implementation).

In the future, this LLC index could be removed after
the native llc_id is used as the key to search into xarray based
array.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/sched.h   |  3 +++
 kernel/sched/fair.c     | 12 ++++++++++++
 kernel/sched/sched.h    |  2 ++
 kernel/sched/topology.c | 29 +++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 02ff8b8be25b..81d92e8097f5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -809,6 +809,9 @@ struct kmap_ctrl {
 #endif
 };
 
+/* XXX need fix to not use magic number */
+#define MAX_LLC 64
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3128dbcf0a36..f5075d287c51 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1183,6 +1183,18 @@ static int llc_id(int cpu)
 	return per_cpu(sd_llc_id, cpu);
 }
 
+/*
+ * continuous index.
+ * TBD: replace by xarray with key llc_id()
+ */
+static inline int llc_idx(int cpu)
+{
+	if (cpu < 0)
+		return -1;
+
+	return per_cpu(sd_llc_idx, cpu);
+}
+
 void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
 {
 	unsigned long epoch;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 83552aab74fb..c37c74dfce25 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2056,6 +2056,7 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
+DECLARE_PER_CPU(int, sd_llc_idx);
 DECLARE_PER_CPU(int, sd_share_id);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
@@ -2064,6 +2065,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 
 extern struct static_key_false sched_asym_cpucapacity;
 extern struct static_key_false sched_cluster_active;
+extern int max_llcs;
 
 static __always_inline bool sched_asym_cpucap_active(void)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b958fe48e020..91a2b7f65fee 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -657,6 +657,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
+DEFINE_PER_CPU(int, sd_llc_idx);
 DEFINE_PER_CPU(int, sd_share_id);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
@@ -666,6 +667,25 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
 
+int max_llcs = -1;
+
+static void update_llc_idx(int cpu)
+{
+#ifdef CONFIG_SCHED_CACHE
+	int idx = -1, llc_id = -1;
+
+	llc_id = per_cpu(sd_llc_id, cpu);
+	idx = per_cpu(sd_llc_idx, llc_id);
+
+	if (idx < 0) {
+		idx = max_llcs++;
+		BUG_ON(idx > MAX_LLC);
+		per_cpu(sd_llc_idx, llc_id) = idx;
+	}
+	per_cpu(sd_llc_idx, cpu) = idx;
+#endif
+}
+
 static void update_top_cache_domain(int cpu)
 {
 	struct sched_domain_shared *sds = NULL;
@@ -684,6 +704,7 @@ static void update_top_cache_domain(int cpu)
 	per_cpu(sd_llc_size, cpu) = size;
 	per_cpu(sd_llc_id, cpu) = id;
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
+	update_llc_idx(cpu);
 
 	sd = lowest_flag_domain(cpu, SD_CLUSTER);
 	if (sd)
@@ -2456,6 +2477,14 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	bool has_asym = false;
 	bool has_cluster = false;
 
+#ifdef CONFIG_SCHED_CACHE
+	if (max_llcs < 0) {
+		for_each_possible_cpu(i)
+			per_cpu(sd_llc_idx, i) = -1;
+		max_llcs = 0;
+	}
+#endif
+
 	if (WARN_ON(cpumask_empty(cpu_map)))
 		goto error;
 
-- 
2.25.1



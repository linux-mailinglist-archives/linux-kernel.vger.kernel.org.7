Return-Path: <linux-kernel+bounces-849242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46BBCFAA2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96F2D4EB90B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6339C2857C2;
	Sat, 11 Oct 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzReY9Ll"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E929283153
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206706; cv=none; b=l9o+r3tPneRXt3UimsPhWTyfqr4rcCBrkqPagUsuj236psyVrtVREf1eV9bh9i5x6sqiX/93/2fGTQOd3tDyAfM2x8nQDBG2tniRFTa1AjKlI5Hs36x8WGu+npNUTYaShkti1wSxrqntJys6VhwZ+aL+o6PQ3k1GyXMU2JJL3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206706; c=relaxed/simple;
	bh=KmODaaWe2UFjj11ibL17qZDBWmMYCsJpeBqEebS+qwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDjhwzZYr3m7pwdhzj9TlyV526H5WJLBGHEilCqY27+WQSI1yxnPWT6k5Mm6bFKl/0I+sfGQBi/7HzzHe1S3ts6bk23EZaJB+w94GLEZKAcc8cSHQMDIbKKzGRMgBrwPnT0sZBkKxiooppSIJhtXCA86kWL70YWS1bZ1PVuSOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzReY9Ll; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206705; x=1791742705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmODaaWe2UFjj11ibL17qZDBWmMYCsJpeBqEebS+qwU=;
  b=BzReY9LlEh9sk7OgZDcp2VjjY3mwnRzW5hp4d8rSX40TSJQm31n7pNsD
   pGDX4pGNqIL2dKhB0TWBOakqdMqoEJBGhhFnbP0SML4ddRpmP22b3hhKk
   66OBjK6EOlIiBTx96elcU0fwjNnZqBKTvf/i3IuC2HlilzxwoimPLi7ym
   OqUTRkCWmlqgJ5BjvtUEaD2eb97VkiEAs6iUC5FsMQPohIZRE0ZJGIQT2
   rLWb4YevoZUYtWiZQU/yYmcq5sU7eCp84d/YBPYTw8uDxW2au989TrB9t
   olL4givIBdX+ieIJw7430Yz/Es1H+8Ji46MflznNqafshDKBuL8HbpSmx
   A==;
X-CSE-ConnectionGUID: xTVpDyXiQYmCxiG8vc8uKg==
X-CSE-MsgGUID: ouYA76mXSo+MkfJ9ZAYryA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339693"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339693"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:23 -0700
X-CSE-ConnectionGUID: Vda9/GgFQc2uyKt8dn0epA==
X-CSE-MsgGUID: 2SFdpXMCSGKC8Z5YqgWCow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487198"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:23 -0700
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
Subject: [PATCH 05/19] sched/fair: Add LLC index mapping for CPUs
Date: Sat, 11 Oct 2025 11:24:42 -0700
Message-Id: <7d75af576986cf447a171ce11f5e8a15a692e780.1760206683.git.tim.c.chen@linux.intel.com>
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

Introduce an index mapping between CPUs and their LLCs. This provides
a continuous per LLC index needed for cache-aware load balancing in
later patches.

The existing per_cpu llc_id usually points to the first CPU of the
LLC domain, which is sparse and unsuitable as an array index. Using
llc_id directly would waste memory.

With the new mapping, CPUs in the same LLC share a continuous index:

  per_cpu(llc_idx, CPU=0...15)  = 0
  per_cpu(llc_idx, CPU=16...31) = 1
  per_cpu(llc_idx, CPU=32...47) = 2
  ...

The maximum number of LLCs is limited by CONFIG_NR_LLCS. If the number
of LLCs available exceeds CONFIG_NR_LLCS, the cache aware load balance
is disabled. To further save memory, this array could be converted to
dynamic allocation in the future, or the LLC index could be made NUMA
node-wide.

As mentioned by Adam, if there is no domain with SD_SHARE_LLC, the
function update_llc_idx() should not be invoked to update the index;
otherwise, it will generate an invalid index.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/threads.h | 10 +++++++++
 init/Kconfig            |  9 ++++++++
 kernel/sched/fair.c     | 11 ++++++++++
 kernel/sched/sched.h    |  2 ++
 kernel/sched/topology.c | 47 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 79 insertions(+)

diff --git a/include/linux/threads.h b/include/linux/threads.h
index 1674a471b0b4..2c9b1adfe024 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -20,6 +20,16 @@
 /* Places which use this should consider cpumask_var_t. */
 #define NR_CPUS		CONFIG_NR_CPUS
 
+#ifndef CONFIG_NR_LLCS
+#define CONFIG_NR_LLCS 1
+#endif
+
+#if CONFIG_NR_LLCS > NR_CPUS
+#define NR_LLCS		NR_CPUS
+#else
+#define NR_LLCS		CONFIG_NR_LLCS
+#endif
+
 #define MIN_THREADS_LEFT_FOR_ROOT 4
 
 /*
diff --git a/init/Kconfig b/init/Kconfig
index 4e625db7920a..6e4c96ccdda0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -981,6 +981,15 @@ config SCHED_CACHE
 	  resources within the same cache domain, reducing cache misses and
 	  lowering data access latency.
 
+config NR_LLCS
+	int "Maximum number of Last Level Caches"
+	range 2 1024
+	depends on SMP && SCHED_CACHE
+	default 64
+	help
+	  This allows you to specify the maximum number of last level caches
+	  this kernel will support for cache aware scheduling.
+
 config NUMA_BALANCING_DEFAULT_ENABLED
 	bool "Automatically enable NUMA aware memory/task placement"
 	default y
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3d643449c48c..61c129bde8b6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1224,6 +1224,17 @@ static int llc_id(int cpu)
 	return per_cpu(sd_llc_id, cpu);
 }
 
+/*
+ * continuous LLC index, starting from 0.
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
index 60f1e51685ec..b448ad6dc51d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2039,6 +2039,7 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
+DECLARE_PER_CPU(int, sd_llc_idx);
 DECLARE_PER_CPU(int, sd_share_id);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
@@ -2047,6 +2048,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 
 extern struct static_key_false sched_asym_cpucapacity;
 extern struct static_key_false sched_cluster_active;
+extern int max_llcs;
 
 static __always_inline bool sched_asym_cpucap_active(void)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 2675db980f70..4bd033060f1d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -659,6 +659,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
+DEFINE_PER_CPU(int, sd_llc_idx);
 DEFINE_PER_CPU(int, sd_share_id);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
@@ -668,6 +669,40 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
 
+int max_llcs = -1;
+
+static void update_llc_idx(int cpu)
+{
+#ifdef CONFIG_SCHED_CACHE
+	int idx = -1, llc_id = -1;
+
+	if (max_llcs > NR_LLCS)
+		return;
+
+	llc_id = per_cpu(sd_llc_id, cpu);
+	idx = per_cpu(sd_llc_idx, llc_id);
+
+	/*
+	 * A new LLC is detected, increase the index
+	 * by 1.
+	 */
+	if (idx < 0) {
+		idx = max_llcs++;
+
+		if (max_llcs > NR_LLCS) {
+			if (static_branch_unlikely(&sched_cache_allowed))
+				static_branch_disable_cpuslocked(&sched_cache_allowed);
+
+			pr_warn_once("CONFIG_NR_LLCS is too small, disable cache aware load balance\n");
+			return;
+		}
+
+		per_cpu(sd_llc_idx, llc_id) = idx;
+	}
+	per_cpu(sd_llc_idx, cpu) = idx;
+#endif
+}
+
 static void update_top_cache_domain(int cpu)
 {
 	struct sched_domain_shared *sds = NULL;
@@ -687,6 +722,10 @@ static void update_top_cache_domain(int cpu)
 	per_cpu(sd_llc_id, cpu) = id;
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
 
+	/* only update the llc index for domain with SD_SHARE_LLC */
+	if (sd)
+		update_llc_idx(cpu);
+
 	sd = lowest_flag_domain(cpu, SD_CLUSTER);
 	if (sd)
 		id = cpumask_first(sched_domain_span(sd));
@@ -2452,6 +2491,14 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
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
2.32.0



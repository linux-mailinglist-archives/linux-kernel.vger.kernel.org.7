Return-Path: <linux-kernel+bounces-849254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BEABCFAC6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A3684EB042
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E11295DB8;
	Sat, 11 Oct 2025 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyspbvXX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76C28C03B
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206717; cv=none; b=Gsl1htdC3Y7gJ6c3ywcidI/bSse8yUz6irs7/iI8KWV8rK5Ae95mMS6V4kE386ZpRZ64YVuSevPlw/gCCcGexlKVEsnpJGvjAMVnB6E3r26Sb5PQDcAwlJhgczIF0vnORN//ryXKWaGJdpyTLOi1a78IAJp76Mm0Cc1+XjF2rGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206717; c=relaxed/simple;
	bh=RPMOV8sl+NtxUoril7y0k9+l4VyTXFWW/dE0ALAKhro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hT0pK7n3dH+PZ5LGb1wwP8mkt2A7mUf1PCIeydCbZfOqNSbSKOwNGkxWRp3xr4aPGGtMx1eK61Xyt7h2YGrFfvdSUCRdLGNS2BunlIUuq8SqGdxHIK829DTsOGKBUbEPWJzj/d6E4FC8xaBfUuz6ugBEq47VdX8vEtuc1XwNFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyspbvXX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206716; x=1791742716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RPMOV8sl+NtxUoril7y0k9+l4VyTXFWW/dE0ALAKhro=;
  b=eyspbvXX6JZaLuPx9mP9k7AsJvdPNK3nA7Eu1n1ZjnjSeOqzlt2GEvCx
   IIbDfmBwRBwDACT7YDm/5WXc6cuJLsO02ejx9sBoouGuZkUHl1/nB7J2O
   i/e0/jcb0J2buciIQ3OvuzUhegT0ZaiQoJUm0tinSNJAyHv/2LoJKLT6E
   1wncP9sm103omUQyz2nIdzytwxhPLCdaTXt3R4jfGDM0HbNy1TRA5Ex3O
   eiDpNNIsPslVI7J8r5viBVFuJFJIfp1atbqNY5xQ3zDqGyLEqF5FJMEHK
   BGBjTx2SYuiM3sv4eOtztesROh9S4vRoc6wieYXXgBwOgrHLMjZB8S3CI
   A==;
X-CSE-ConnectionGUID: 15+3n+5PQLG8KotmRvuIMw==
X-CSE-MsgGUID: Dj1GwDBDRtWs7ASTeti8MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339940"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339940"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:35 -0700
X-CSE-ConnectionGUID: O+LhKbX0QNyBYwHUAp0ttw==
X-CSE-MsgGUID: PfPvzLkATc2Ca+B9H6Dwng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487259"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:35 -0700
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
Subject: [PATCH 18/19] sched/fair: Avoid cache-aware scheduling for memory-heavy processes
Date: Sat, 11 Oct 2025 11:24:55 -0700
Message-Id: <00da49fd590b95baad0525660bda4c0ba178243d.1760206683.git.tim.c.chen@linux.intel.com>
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

Prateek and Tingyin reported that memory-intensive workloads (such as
stream) can saturate memory bandwidth and caches on the preferred LLC
when sched_cache aggregates too many threads.

To mitigate this, estimate a process's memory footprint by comparing
its RSS (anonymous and shared pages) to the size of the LLC. If RSS
exceeds the LLC size, skip cache-aware scheduling.

Note that RSS is only an approximation of the memory footprint.
By default, the comparison is strict, but a later patch will allow
users to provide a hint to adjust this threshold.

According to the test from Adam, some systems do not have shared L3
but with shared L2 as clusters. In this case, the L2 becomes the LLC[1].

Link[1]: https://lore.kernel.org/all/3cb6ebc7-a2fd-42b3-8739-b00e28a09cb6@os.amperecomputing.com/

Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/cacheinfo.h | 21 ++++++++++------
 kernel/sched/fair.c       | 51 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index c8f4f0a0b874..82d0d59ca0e1 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -113,18 +113,11 @@ int acpi_get_cache_info(unsigned int cpu,
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
-/*
- * Get the cacheinfo structure for the cache associated with @cpu at
- * level @level.
- * cpuhp lock must be held.
- */
-static inline struct cacheinfo *get_cpu_cacheinfo_level(int cpu, int level)
+static inline struct cacheinfo *_get_cpu_cacheinfo_level(int cpu, int level)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
 	int i;
 
-	lockdep_assert_cpus_held();
-
 	for (i = 0; i < ci->num_leaves; i++) {
 		if (ci->info_list[i].level == level) {
 			if (ci->info_list[i].attributes & CACHE_ID)
@@ -136,6 +129,18 @@ static inline struct cacheinfo *get_cpu_cacheinfo_level(int cpu, int level)
 	return NULL;
 }
 
+/*
+ * Get the cacheinfo structure for the cache associated with @cpu at
+ * level @level.
+ * cpuhp lock must be held.
+ */
+static inline struct cacheinfo *get_cpu_cacheinfo_level(int cpu, int level)
+{
+	lockdep_assert_cpus_held();
+
+	return _get_cpu_cacheinfo_level(cpu, level);
+}
+
 /*
  * Get the id of the cache associated with @cpu at level @level.
  * cpuhp lock must be held.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6b8eace79eee..46dfcd2a01b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1240,6 +1240,38 @@ static inline int pref_llc_idx(struct task_struct *p)
 	return llc_idx(p->preferred_llc);
 }
 
+static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
+{
+	struct cacheinfo *ci;
+	unsigned long rss;
+	unsigned int llc;
+
+	/*
+	 * get_cpu_cacheinfo_level() can not be used
+	 * because it requires the cpu_hotplug_lock
+	 * to be held. Use _get_cpu_cacheinfo_level()
+	 * directly because the 'cpu' can not be
+	 * offlined at the moment.
+	 */
+	ci = _get_cpu_cacheinfo_level(cpu, 3);
+	if (!ci) {
+		/*
+		 * On system without L3 but with shared L2,
+		 * L2 becomes the LLC.
+		 */
+		ci = _get_cpu_cacheinfo_level(cpu, 2);
+		if (!ci)
+			return true;
+	}
+
+	llc = ci->size;
+
+	rss = get_mm_counter(mm, MM_ANONPAGES) +
+		get_mm_counter(mm, MM_SHMEMPAGES);
+
+	return (llc <= (rss * PAGE_SIZE));
+}
+
 static bool exceed_llc_nr(struct mm_struct *mm, int cpu)
 {
 	int smt_nr = 1;
@@ -1402,7 +1434,8 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	 */
 	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_LLC_AFFINITY_TIMEOUT ||
 	    get_nr_threads(p) <= 1 ||
-	    exceed_llc_nr(mm, cpu_of(rq))) {
+	    exceed_llc_nr(mm, cpu_of(rq)) ||
+	    exceed_llc_capacity(mm, cpu_of(rq))) {
 		if (mm->mm_sched_cpu != -1)
 			mm->mm_sched_cpu = -1;
 	}
@@ -1486,6 +1519,14 @@ static void __no_profile task_cache_work(struct callback_head *work)
 		return;
 	}
 
+	/*
+	 * Do not check exceed_llc_nr() because
+	 * the active number of threads needs to
+	 * been updated anyway.
+	 */
+	if (exceed_llc_capacity(mm, curr_cpu))
+		return;
+
 	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
 		return;
 
@@ -9845,8 +9886,12 @@ static enum llc_mig can_migrate_llc_task(int src_cpu, int dst_cpu,
 	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
 		return mig_unrestricted;
 
-	 /* skip cache aware load balance for single/too many threads */
-	if (get_nr_threads(p) <= 1 || exceed_llc_nr(mm, dst_cpu))
+	/*
+	 * skip cache aware load balance for single/too many threads
+	 * or large footprint.
+	 */
+	if (get_nr_threads(p) <= 1 || exceed_llc_nr(mm, dst_cpu) ||
+	    exceed_llc_capacity(mm, dst_cpu))
 		return mig_unrestricted;
 
 	if (cpus_share_cache(dst_cpu, cpu))
-- 
2.32.0



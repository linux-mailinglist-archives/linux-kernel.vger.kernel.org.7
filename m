Return-Path: <linux-kernel+bounces-760960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA0B1F249
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612365869BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C417A274B39;
	Sat,  9 Aug 2025 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eixROvUd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E67221540
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716500; cv=none; b=MmUb4c5SUS1z0wOntqBT1lBWA98RaJXvOGOJgyKpL3css2V1PB3tSyqGl6uL4LpYMOyo+rKX3+Or66/w3kvy4IrnK/1zKzbYlsK4uG0lHZdaI/ylANl1HNqUIDGNZvHQU/rlxzJ01GSoxw4kvO56Gsq+Q3Dt9ImEFj8vhMltr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716500; c=relaxed/simple;
	bh=ihWK71wp/q5X7Akw0a3NfcmXIvV26+nk2ItbYopgMBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jLyq+PE48ZqCxRzNfCECXbgKXorBAOraTW1R5D8fjI5Zh6EGFB8ZxO9LxYUE8qGvLCGMlNFmK1+oj1nTLMrg0x4R6BkGXURfRaIdO4gl1uU8D++Mr+VA477bh1glz9u1Ll6+Hks8Jtf0M6xJo+lTeh2jLF0wW7on+hBzGyeTVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eixROvUd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716498; x=1786252498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ihWK71wp/q5X7Akw0a3NfcmXIvV26+nk2ItbYopgMBI=;
  b=eixROvUdtZ+jX6c9PUzsFkzZYy58X17+XSMG4TAKB4dMmEuzDFKNJS5/
   y6mSE9FUJZqVr6Z/MJgBg/rnrSxKx4WNtLRYRaKlxeoov9FqlTgFQ0cm3
   xrL/E9j5rOidep+PGoL8jF0Vi5sxq3zlPOp19TXKYmYCBYSnGBQNe2AtY
   mgT3vaD7Elxg79E7NgAUMSiS4MZSj26K4v5ujKu8dsw3shTBxA6CvPmPO
   rVrBtoWLK3XI3ZTP4tki0uiAJIjOH7fmVd/U18FdmdONY3ZWGGHpTVNYs
   SDtMc5zQFr8yS7suux1xYdFcGTMSbKUOlN8esjYEKijdSJZB/ZI2rOcmc
   Q==;
X-CSE-ConnectionGUID: 2OIbjhYrRs6bZ6T4QRg5pg==
X-CSE-MsgGUID: 1Tg83zzKRiy+BCTOQqeOJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56260022"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56260022"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:14:58 -0700
X-CSE-ConnectionGUID: iiCU+no/RZqZ47l6ZSVsuQ==
X-CSE-MsgGUID: gBZUGA4RTmG67FOC847xZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165476169"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa007.jf.intel.com with ESMTP; 08 Aug 2025 22:14:52 -0700
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
Subject: [RFC PATCH v4 26/28] sched: Do not enable cache aware scheduling for process with large RSS
Date: Sat,  9 Aug 2025 13:08:49 +0800
Message-Id: <881a665a94858d4fb6f13491f4dffe58c8fc3870.1754712565.git.tim.c.chen@linux.intel.com>
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

It has been reported that when running memory-intensive workloads
such as stream, sched_cache may saturate the memory bandwidth on
the preferred LLC.

To prevent this from happening, evaluate the process's memory
footprint by checking the size of RSS (anonymous pages and shared
pages) and comparing it to the size of the LLC. If the former is
larger, skip cache-aware scheduling. This is because if tasks
do not actually share data, aggregating tasks with large RSS will
likely result in cache contention and performance depredation.

However, in theory, RSS is not the same as memory footprint.
This is just an estimated approach to prevent over-aggregation.
The default behavior is to strictly compare the size of RSS with
the size of the LLC. The next patch will introduce a user-provided
hint to customize this comparison.

Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 47 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4bf794f170cf..cbda7dad1305 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1205,6 +1205,34 @@ static inline int pref_llc_idx(struct task_struct *p)
 	return llc_idx(p->preferred_llc);
 }
 
+static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci;
+	struct cacheinfo *l3_leaf;
+	unsigned long rss;
+	unsigned int llc;
+
+	/*
+	 * get_cpu_cacheinfo_level() can not be used
+	 * because it requires the cpu_hotplug_lock
+	 * to be held. Use get_cpu_cacheinfo()
+	 * directly because the 'cpu' can not be
+	 * offlined at the moment.
+	 */
+	this_cpu_ci = get_cpu_cacheinfo(cpu);
+	if (!this_cpu_ci->info_list ||
+	    this_cpu_ci->num_leaves < 3)
+		return true;
+
+	l3_leaf = this_cpu_ci->info_list + 3;
+	llc = l3_leaf->size;
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
@@ -1363,7 +1391,8 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	 */
 	if (epoch - READ_ONCE(mm->mm_sched_epoch) > sysctl_llc_old ||
 	    get_nr_threads(p) <= 1 ||
-	    exceed_llc_nr(mm, cpu_of(rq))) {
+	    exceed_llc_nr(mm, cpu_of(rq)) ||
+	    exceed_llc_capacity(mm, cpu_of(rq))) {
 		mm->mm_sched_cpu = -1;
 		pcpu_sched->occ = 0;
 	}
@@ -1448,6 +1477,14 @@ static void __no_profile task_cache_work(struct callback_head *work)
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
 
@@ -9113,8 +9150,12 @@ static __maybe_unused enum llc_mig_hint get_migrate_hint(int src_cpu, int dst_cp
 	if (cpu < 0)
 		return mig_allow;
 
-	 /* skip cache aware load balance for single/too many threads */
-	if (get_nr_threads(p) <= 1 || exceed_llc_nr(mm, dst_cpu))
+	/*
+	 * skip cache aware load balance for single/too many threads
+	 * and large footprint.
+	 */
+	if (get_nr_threads(p) <= 1 || exceed_llc_nr(mm, dst_cpu) ||
+	    exceed_llc_capacity(mm, dst_cpu))
 		return mig_allow;
 
 	if (cpus_share_cache(dst_cpu, cpu))
-- 
2.25.1



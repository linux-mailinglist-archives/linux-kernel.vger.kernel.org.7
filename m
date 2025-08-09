Return-Path: <linux-kernel+bounces-760935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC43EB1F22E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D4C3B68DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D627587D;
	Sat,  9 Aug 2025 05:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1tFeu3x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A021D3E1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716057; cv=none; b=gkWBJvwJg5iw9w3Hcj2a+7isBgs+dQ6fQDbY6wOnLy8+dyj/K69iJ9MXZ3iC+AHiVKMdhhAQoR1l9wBbUy+BDlfe78+DRZUcHT2UIqJWtHq9xcndAunehdB/pDXNo95Uc+pmFlmpm5x4k3E0kzRAGeqzAXJ2da+LetkIln18z8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716057; c=relaxed/simple;
	bh=0AeD1Ue2wq1wzi/RuwjSxpYJG1oGbIqRn0kfUtN8vWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ezySzW6WeP6U1sHlrXJpD4tSHCfswUkVtMkKRoY8mH+Is59q9EsKFce/r5LHpaugK4Vf9AWVbLfOfFJGgeU54XDE5BxdVqKFZzyDDz9t1/tqydhF9wFSbw/pomx2BYrO+hWtoQKyQHnIN8AUaxQhvGebuiVcyUt9i8bQDwF00zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1tFeu3x; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716056; x=1786252056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AeD1Ue2wq1wzi/RuwjSxpYJG1oGbIqRn0kfUtN8vWQ=;
  b=L1tFeu3xpYyhkd6vtGYa4ACOStVJ3enDl+olXnAD4THPx7m0Kc/94fQX
   0NFLzELjFB+k0dXkFEcvhvn2VXQNCEOqpU4KBJdAapmZmEa5Kw2a3uSD5
   5xGm04sNo/62GAtkSLJDhfLmYvSib+2Y+m+5iYRVQYWZMC9fcPoUUOJIk
   57s73MqGMxeACxAjkhR9PE504WxXvkEUrsCDlWBeU6A00KrTz8w5uJ8fg
   62R1OQ44QJ5eTLS/469R4lFtouEYqw6B8JU9gex0GxRi5dRP00WgMGCoV
   CD4HfPgwZPIsG54V4ibpdGi2Z/RSrK2prH4PrMvMSdJ5asPDTFjEDlvfI
   Q==;
X-CSE-ConnectionGUID: lQLqoBuSQl6aw8VZynnN4g==
X-CSE-MsgGUID: yMcXhXa1RZSWwEf2YK1T6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57137717"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57137717"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:07:36 -0700
X-CSE-ConnectionGUID: ofaF5mj0TIucF4p9yS/Zvw==
X-CSE-MsgGUID: bcXwCarVSY2Y3E4fjnIy5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170730164"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2025 22:07:29 -0700
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
Subject: [RFC PATCH v4 02/28] sched: Several fixes for cache aware scheduling
Date: Sat,  9 Aug 2025 13:01:15 +0800
Message-Id: <84ceaca0a1de853284b4fc9888af806b03cde8bb.1754712565.git.tim.c.chen@linux.intel.com>
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

1. Fix compile error on percpu allocation.
2. Enqueue to the target CPU rather than the current CPU.
3. NULL LLC sched domain check(Libo Chen).
4. Introduce sched feature SCHED_CACHE to control cache aware scheduling
5. Fix unsigned occupancy initialization to -1.
6. If there is only 1 thread in the process, no need to enable cache
   awareness
7. Add __maybe_unused to __migrate_degrades_locality() to
   avoid compile warnings.
8. Do not enable gcov coverage for task_cache_work() and
   fraction_mm_sched() to avoid softlockup by gcov.
9. Make CONFIG_SCHED_CACHE depending on CONFIG_SMP to
   avoid compile error on non-SMP system like microblaze
   architecture.
10. Do not enable account cache aware statistics in
    account_mm_sched() for non-normal tasks, as it could
    be invoked by RT tasks.(Shrikanth Hegde)
11. Place cpu_epoch related fields in a dedicated cache line
    to avoid interfering with clock_idle* fields.
    (Shrikanth Hegde)

Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/mm_types.h |  4 ++--
 init/Kconfig             |  4 ++++
 kernel/sched/fair.c      | 41 +++++++++++++++++++++++++++-------------
 kernel/sched/features.h  |  1 +
 kernel/sched/sched.h     |  2 +-
 5 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cf26ad8b41ab..41a598a44361 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1450,11 +1450,11 @@ static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumas
 #endif /* CONFIG_SCHED_MM_CID */
 
 #ifdef CONFIG_SCHED_CACHE
-extern void mm_init_sched(struct mm_struct *mm, struct mm_sched *pcpu_sched);
+void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *pcpu_sched);
 
 static inline int mm_alloc_sched_noprof(struct mm_struct *mm)
 {
-	struct mm_sched *pcpu_sched = alloc_percpu_noprof(struct mm_sched);
+	struct mm_sched __percpu *pcpu_sched = alloc_percpu_noprof(struct mm_sched);
 	if (!pcpu_sched)
 		return -ENOMEM;
 
diff --git a/init/Kconfig b/init/Kconfig
index 27f4012347f9..4bab39a5254c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -950,6 +950,10 @@ config NUMA_BALANCING
 config SCHED_CACHE
 	bool "Cache aware scheduler"
 	default y
+	depends on SMP
+	help
+	  If set, the scheduler will try to aggregate tasks in the same process to
+	  a single LLC if possible.
 
 config NUMA_BALANCING_DEFAULT_ENABLED
 	bool "Automatically enable NUMA aware memory/task placement"
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e3897cd7696d..e97ab46509e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1175,7 +1175,7 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 #define EPOCH_PERIOD	(HZ/100)	/* 10 ms */
 #define EPOCH_OLD	5		/* 50 ms */
 
-void mm_init_sched(struct mm_struct *mm, struct mm_sched *_pcpu_sched)
+void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
 {
 	unsigned long epoch;
 	int i;
@@ -1186,7 +1186,7 @@ void mm_init_sched(struct mm_struct *mm, struct mm_sched *_pcpu_sched)
 
 		pcpu_sched->runtime = 0;
 		pcpu_sched->epoch = epoch = rq->cpu_epoch;
-		pcpu_sched->occ = -1;
+		pcpu_sched->occ = 0;
 	}
 
 	raw_spin_lock_init(&mm->mm_sched_lock);
@@ -1227,7 +1227,7 @@ static inline void __update_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
 	}
 }
 
-static unsigned long fraction_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
+static unsigned long __no_profile fraction_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
 {
 	guard(raw_spinlock_irqsave)(&rq->cpu_epoch_lock);
 
@@ -1248,13 +1248,18 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	struct mm_sched *pcpu_sched;
 	unsigned long epoch;
 
+	if (!sched_feat(SCHED_CACHE))
+		return;
+
+	if (p->sched_class != &fair_sched_class)
+		return;
 	/*
 	 * init_task and kthreads don't be having no mm
 	 */
 	if (!mm || !mm->pcpu_sched)
 		return;
 
-	pcpu_sched = this_cpu_ptr(p->mm->pcpu_sched);
+	pcpu_sched = per_cpu_ptr(p->mm->pcpu_sched, cpu_of(rq));
 
 	scoped_guard (raw_spinlock, &rq->cpu_epoch_lock) {
 		__update_mm_sched(rq, pcpu_sched);
@@ -1264,12 +1269,14 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	}
 
 	/*
-	 * If this task hasn't hit task_cache_work() for a while, invalidate
+	 * If this task hasn't hit task_cache_work() for a while, or it
+	 * has only 1 thread, invalidate
 	 * it's preferred state.
 	 */
-	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_OLD) {
+	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_OLD ||
+	    get_nr_threads(p) <= 1) {
 		mm->mm_sched_cpu = -1;
-		pcpu_sched->occ = -1;
+		pcpu_sched->occ = 0;
 	}
 }
 
@@ -1278,6 +1285,9 @@ static void task_tick_cache(struct rq *rq, struct task_struct *p)
 	struct callback_head *work = &p->cache_work;
 	struct mm_struct *mm = p->mm;
 
+	if (!sched_feat(SCHED_CACHE))
+		return;
+
 	if (!mm || !mm->pcpu_sched)
 		return;
 
@@ -1286,16 +1296,13 @@ static void task_tick_cache(struct rq *rq, struct task_struct *p)
 
 	guard(raw_spinlock)(&mm->mm_sched_lock);
 
-	if (mm->mm_sched_epoch == rq->cpu_epoch)
-		return;
-
 	if (work->next == work) {
 		task_work_add(p, work, TWA_RESUME);
 		WRITE_ONCE(mm->mm_sched_epoch, rq->cpu_epoch);
 	}
 }
 
-static void task_cache_work(struct callback_head *work)
+static void __no_profile task_cache_work(struct callback_head *work)
 {
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
@@ -1322,6 +1329,9 @@ static void task_cache_work(struct callback_head *work)
 			unsigned long occ, m_occ = 0, a_occ = 0;
 			int m_cpu = -1, nr = 0, i;
 
+			if (!sd)
+				continue;
+
 			for_each_cpu(i, sched_domain_span(sd)) {
 				occ = fraction_mm_sched(cpu_rq(i),
 							per_cpu_ptr(mm->pcpu_sched, i));
@@ -8815,6 +8825,9 @@ static int select_cache_cpu(struct task_struct *p, int prev_cpu)
 	struct mm_struct *mm = p->mm;
 	int cpu;
 
+	if (!sched_feat(SCHED_CACHE))
+		return prev_cpu;
+
 	if (!mm || p->nr_cpus_allowed == 1)
 		return prev_cpu;
 
@@ -9569,7 +9582,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 		return 0;
 
 #ifdef CONFIG_SCHED_CACHE
-	if (p->mm && p->mm->pcpu_sched) {
+	if (sched_feat(SCHED_CACHE) && p->mm && p->mm->pcpu_sched) {
 		/*
 		 * XXX things like Skylake have non-inclusive L3 and might not
 		 * like this L3 centric view. What to do about L2 stickyness ?
@@ -9647,7 +9660,9 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 }
 
 #else
-static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle)
+static __maybe_unused long __migrate_degrades_locality(struct task_struct *p,
+						       int src_cpu, int dst_cpu,
+						       bool idle)
 {
 	return 0;
 }
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 3c12d9f93331..d2af7bfd36bf 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -87,6 +87,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_UTIL, true)
 
+SCHED_FEAT(SCHED_CACHE, true)
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
  * in a single rq->lock section. Default disabled because the
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 839463027ab0..f4ab45ecca86 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1174,7 +1174,7 @@ struct rq {
 	u64			clock_idle_copy;
 #endif
 #ifdef CONFIG_SCHED_CACHE
-	raw_spinlock_t		cpu_epoch_lock;
+	raw_spinlock_t		cpu_epoch_lock ____cacheline_aligned;
 	u64			cpu_runtime;
 	unsigned long		cpu_epoch;
 	unsigned long		cpu_epoch_next;
-- 
2.25.1



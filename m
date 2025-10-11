Return-Path: <linux-kernel+bounces-849237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39642BCFA8D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2693A4E8DC7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3C283C90;
	Sat, 11 Oct 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fA7dEfIE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46062169AD2
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206703; cv=none; b=RpWLRsxlJTzhlJSNJ6YDnnOidsJ7oCIJ0QG0EXS7VFoOFFRWiuWYlsET6M5MjOkyE+dnQih3vxbVtcm+li+EdUZBeyP5FVticeDHkmuoWPHZblewToySaE5iRFgZqZZMrF2/g7ww+IHVQ3wb1PmaWoyqrDBaIo5To0g72h92TRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206703; c=relaxed/simple;
	bh=eCGUZmunSjVOsoqwxe8kKF4T+jrOyKsftgZkbuwe1Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJa7XLmNRAgs2IV6jX9+J3RTiz2TA7hXn5NgC4yjWKV75coBs2eumwHZZgG2HlZqrxNZy2yyHAMM73rFnrDZIvG+RpHWxcfbJopVHrre/vMQ3HJJFjQUmhaAwWCfX+5CuF2S3mkLLbQPk1FwQMpFRQzmQi7ZRNOguwaR+/BIBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fA7dEfIE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206701; x=1791742701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eCGUZmunSjVOsoqwxe8kKF4T+jrOyKsftgZkbuwe1Jo=;
  b=fA7dEfIE91ULN1jqc64owLAysrWyqWsDA5nuO1+sgcIA15Yn8yYj6iw4
   55VPKl3g+xYXhPmGyE7a0LZvFUc9YG3ckmUpqO0pvf6oo1RJcM13mS3yi
   KNsM4bbd9aFpNPTftzZGqryw94QrGirzar7JNUNOk0MJqRkziOVPLHnOi
   iVfGn7SOaI4LzDDzlorOXwaeFstT3f2UVe0Cr2vAWBdxYyDop0Z+G9hqb
   BhSDn+aeXU8OqAYP/xGpt3Ce8cbnDhTJhA+r5jzej1xMspSEeS1p/SQOm
   slC+k3w/mm9HPugo6aL39ZyshlQHrAN4qvnJBJT/5GnR6bFHs9O0IKtHz
   w==;
X-CSE-ConnectionGUID: AwkM8kCOR6yXxOyCyDBj4Q==
X-CSE-MsgGUID: FBEmDsF5QKC61vf0MqpBmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339614"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339614"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:19 -0700
X-CSE-ConnectionGUID: HGgPT3dBQFm59TiA7l3rfA==
X-CSE-MsgGUID: SlOHviQzSgGRjsbScX9f4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487181"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:19 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
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
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware load balancing
Date: Sat, 11 Oct 2025 11:24:38 -0700
Message-Id: <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1760206683.git.tim.c.chen@linux.intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Cache-aware load balancing aims to aggregate tasks with potential
shared resources into the same cache domain. This approach enhances
cache locality, thereby optimizing system performance by reducing
cache misses and improving data access efficiency.

In the current implementation, threads within the same process are
considered as entities that potentially share resources.
Cache-aware load balancing monitors the CPU occupancy of each cache
domain for every process. Based on this monitoring, it endeavors to
migrate threads within a given process to its cache-hot domains,
with the goal of maximizing cache locality.

It is an attempt at modelling cache affinity. While the patch series
only targets LLC, it could very well be extended to clusters (L2),
or other kind of domains grouping inside a node.

As it stands, the mechanism only computes a CPU within the LLC that
has the highest recent runtime; this CPU is then used in the load
balance path in subsequent patches to steer toward this LLC.

More elaborate measures could be added later in NUMA_BALANCING: for
example, migrating task A to its preferred LLC when it has spare CPU
capacity, or swapping task A with another running task B in task A’s
preferred LLC.

Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/mm_types.h |  44 ++++++
 include/linux/sched.h    |   4 +
 init/Kconfig             |  11 ++
 kernel/fork.c            |   6 +
 kernel/sched/core.c      |   6 +
 kernel/sched/fair.c      | 288 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h  |   1 +
 kernel/sched/sched.h     |   8 ++
 8 files changed, 368 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 08bc2442db93..3ca557c2f36d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -927,6 +927,11 @@ struct mm_cid {
 };
 #endif
 
+struct mm_sched {
+	u64 runtime;
+	unsigned long epoch;
+};
+
 struct kioctx_table;
 struct iommu_mm_data;
 struct mm_struct {
@@ -1017,6 +1022,17 @@ struct mm_struct {
 		 */
 		raw_spinlock_t cpus_allowed_lock;
 #endif
+#ifdef CONFIG_SCHED_CACHE
+		/*
+		 * Track per-cpu-per-process occupancy as a proxy for cache residency.
+		 * See account_mm_sched() and ...
+		 */
+		struct mm_sched __percpu *pcpu_sched;
+		raw_spinlock_t mm_sched_lock;
+		unsigned long mm_sched_epoch;
+		int mm_sched_cpu;
+#endif
+
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
 #endif
@@ -1436,6 +1452,34 @@ static inline unsigned int mm_cid_size(void)
 static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask) { }
 #endif /* CONFIG_SCHED_MM_CID */
 
+#ifdef CONFIG_SCHED_CACHE
+void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *pcpu_sched);
+
+static inline int mm_alloc_sched_noprof(struct mm_struct *mm)
+{
+	struct mm_sched __percpu *pcpu_sched = alloc_percpu_noprof(struct mm_sched);
+
+	if (!pcpu_sched)
+		return -ENOMEM;
+
+	mm_init_sched(mm, pcpu_sched);
+	return 0;
+}
+
+#define mm_alloc_sched(...)	alloc_hooks(mm_alloc_sched_noprof(__VA_ARGS__))
+
+static inline void mm_destroy_sched(struct mm_struct *mm)
+{
+	free_percpu(mm->pcpu_sched);
+	mm->pcpu_sched = NULL;
+}
+#else /* !CONFIG_SCHED_CACHE */
+
+static inline int mm_alloc_sched(struct mm_struct *mm) { return 0; }
+static inline void mm_destroy_sched(struct mm_struct *mm) { }
+
+#endif /* CONFIG_SCHED_CACHE */
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b833350..d7ddb7ce6c4b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1400,6 +1400,10 @@ struct task_struct {
 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_SCHED_CACHE
+	struct callback_head		cache_work;
+#endif
+
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
 	u32 rseq_len;
diff --git a/init/Kconfig b/init/Kconfig
index e3eb63eadc87..4e625db7920a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -970,6 +970,17 @@ config NUMA_BALANCING
 
 	  This system will be inactive on UMA systems.
 
+config SCHED_CACHE
+	bool "Cache aware load balance"
+	default y
+	depends on SMP
+	help
+	  When enabled, the scheduler will attempt to aggregate tasks from
+	  the same process onto a single Last Level Cache (LLC) domain when
+	  possible. This improves cache locality by keeping tasks that share
+	  resources within the same cache domain, reducing cache misses and
+	  lowering data access latency.
+
 config NUMA_BALANCING_DEFAULT_ENABLED
 	bool "Automatically enable NUMA aware memory/task placement"
 	default y
diff --git a/kernel/fork.c b/kernel/fork.c
index c4ada32598bd..9cd6efe2926d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -680,6 +680,7 @@ void __mmdrop(struct mm_struct *mm)
 	cleanup_lazy_tlbs(mm);
 
 	WARN_ON_ONCE(mm == current->active_mm);
+	mm_destroy_sched(mm);
 	mm_free_pgd(mm);
 	mm_free_id(mm);
 	destroy_context(mm);
@@ -1079,6 +1080,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_cid(mm, p))
 		goto fail_cid;
 
+	if (mm_alloc_sched(mm))
+		goto fail_sched;
+
 	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
 				     NR_MM_COUNTERS))
 		goto fail_pcpu;
@@ -1088,6 +1092,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	return mm;
 
 fail_pcpu:
+	mm_destroy_sched(mm);
+fail_sched:
 	mm_destroy_cid(mm);
 fail_cid:
 	destroy_context(mm);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..79d15e904d12 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4520,6 +4520,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 	init_sched_mm_cid(p);
+	init_sched_mm(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -8821,6 +8822,11 @@ void __init sched_init(void)
 
 		rq->core_cookie = 0UL;
 #endif
+#ifdef CONFIG_SCHED_CACHE
+		raw_spin_lock_init(&rq->cpu_epoch_lock);
+		rq->cpu_epoch_next = jiffies;
+#endif
+
 		zalloc_cpumask_var_node(&rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));
 	}
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..a2ea002f4fd6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1152,6 +1152,8 @@ void post_init_entity_util_avg(struct task_struct *p)
 	sa->runnable_avg = sa->util_avg;
 }
 
+static inline void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec);
+
 static s64 update_se(struct rq *rq, struct sched_entity *se)
 {
 	u64 now = rq_clock_task(rq);
@@ -1174,6 +1176,7 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
 
 		trace_sched_stat_runtime(running, delta_exec);
 		account_group_exec_runtime(running, delta_exec);
+		account_mm_sched(rq, donor, delta_exec);
 
 		/* cgroup time is always accounted against the donor */
 		cgroup_account_cputime(donor, delta_exec);
@@ -1193,6 +1196,289 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
 	return delta_exec;
 }
 
+#ifdef CONFIG_SCHED_CACHE
+
+/*
+ * XXX numbers come from a place the sun don't shine -- probably wants to be SD
+ * tunable or so.
+ */
+#define EPOCH_PERIOD	(HZ / 100)	/* 10 ms */
+#define EPOCH_LLC_AFFINITY_TIMEOUT	5	/* 50 ms */
+
+static int llc_id(int cpu)
+{
+	if (cpu < 0)
+		return -1;
+
+	return per_cpu(sd_llc_id, cpu);
+}
+
+void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
+{
+	unsigned long epoch;
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct mm_sched *pcpu_sched = per_cpu_ptr(_pcpu_sched, i);
+		struct rq *rq = cpu_rq(i);
+
+		pcpu_sched->runtime = 0;
+		pcpu_sched->epoch = rq->cpu_epoch;
+		epoch = rq->cpu_epoch;
+	}
+
+	raw_spin_lock_init(&mm->mm_sched_lock);
+	mm->mm_sched_epoch = epoch;
+	mm->mm_sched_cpu = -1;
+
+	/*
+	 * The update to mm->pcpu_sched should not be reordered
+	 * before initialization to mm's other fields, in case
+	 * the readers may get invalid mm_sched_epoch, etc.
+	 */
+	smp_store_release(&mm->pcpu_sched, _pcpu_sched);
+}
+
+/* because why would C be fully specified */
+static __always_inline void __shr_u64(u64 *val, unsigned int n)
+{
+	if (n >= 64) {
+		*val = 0;
+		return;
+	}
+	*val >>= n;
+}
+
+static inline void __update_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
+{
+	lockdep_assert_held(&rq->cpu_epoch_lock);
+
+	unsigned long n, now = jiffies;
+	long delta = now - rq->cpu_epoch_next;
+
+	if (delta > 0) {
+		n = (delta + EPOCH_PERIOD - 1) / EPOCH_PERIOD;
+		rq->cpu_epoch += n;
+		rq->cpu_epoch_next += n * EPOCH_PERIOD;
+		__shr_u64(&rq->cpu_runtime, n);
+	}
+
+	n = rq->cpu_epoch - pcpu_sched->epoch;
+	if (n) {
+		pcpu_sched->epoch += n;
+		__shr_u64(&pcpu_sched->runtime, n);
+	}
+}
+
+static unsigned long __no_profile fraction_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
+{
+	guard(raw_spinlock_irqsave)(&rq->cpu_epoch_lock);
+
+	__update_mm_sched(rq, pcpu_sched);
+
+	/*
+	 * Runtime is a geometric series (r=0.5) and as such will sum to twice
+	 * the accumulation period, this means the multiplcation here should
+	 * not overflow.
+	 */
+	return div64_u64(NICE_0_LOAD * pcpu_sched->runtime, rq->cpu_runtime + 1);
+}
+
+static inline
+void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
+{
+	struct mm_struct *mm = p->mm;
+	struct mm_sched *pcpu_sched;
+	unsigned long epoch;
+
+	if (!sched_feat(SCHED_CACHE))
+		return;
+
+	if (p->sched_class != &fair_sched_class)
+		return;
+	/*
+	 * init_task and kthreads don't having mm
+	 */
+	if (!mm || !mm->pcpu_sched)
+		return;
+
+	pcpu_sched = per_cpu_ptr(p->mm->pcpu_sched, cpu_of(rq));
+
+	scoped_guard (raw_spinlock, &rq->cpu_epoch_lock) {
+		__update_mm_sched(rq, pcpu_sched);
+		pcpu_sched->runtime += delta_exec;
+		rq->cpu_runtime += delta_exec;
+		epoch = rq->cpu_epoch;
+	}
+
+	/*
+	 * If this task hasn't hit task_cache_work() for a while, or it
+	 * has only 1 thread, invalidate its preferred state.
+	 */
+	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_LLC_AFFINITY_TIMEOUT ||
+	    get_nr_threads(p) <= 1) {
+		if (mm->mm_sched_cpu != -1)
+			mm->mm_sched_cpu = -1;
+	}
+}
+
+static void task_tick_cache(struct rq *rq, struct task_struct *p)
+{
+	struct callback_head *work = &p->cache_work;
+	struct mm_struct *mm = p->mm;
+
+	if (!sched_feat(SCHED_CACHE))
+		return;
+
+	if (!mm || !mm->pcpu_sched)
+		return;
+
+	if (mm->mm_sched_epoch == rq->cpu_epoch)
+		return;
+
+	guard(raw_spinlock)(&mm->mm_sched_lock);
+
+	if (work->next == work) {
+		task_work_add(p, work, TWA_RESUME);
+		WRITE_ONCE(mm->mm_sched_epoch, rq->cpu_epoch);
+	}
+}
+
+static void get_scan_cpumasks(cpumask_var_t cpus, int cache_cpu,
+			      int pref_nid, int curr_cpu)
+{
+#ifdef CONFIG_NUMA_BALANCING
+	/* First honor the task's preferred node. */
+	if (pref_nid != NUMA_NO_NODE)
+		cpumask_or(cpus, cpus, cpumask_of_node(pref_nid));
+#endif
+
+	/* Next honor the task's cache CPU if it is not included. */
+	if (cache_cpu != -1 && !cpumask_test_cpu(cache_cpu, cpus))
+		cpumask_or(cpus, cpus,
+			   cpumask_of_node(cpu_to_node(cache_cpu)));
+
+	/*
+	 * Lastly make sure that the task's current running node is
+	 * considered.
+	 */
+	if (!cpumask_test_cpu(curr_cpu, cpus))
+		cpumask_or(cpus, cpus, cpumask_of_node(cpu_to_node(curr_cpu)));
+}
+
+static void __no_profile task_cache_work(struct callback_head *work)
+{
+	struct task_struct *p = current;
+	struct mm_struct *mm = p->mm;
+	unsigned long m_a_occ = 0;
+	unsigned long curr_m_a_occ = 0;
+	int cpu, m_a_cpu = -1, cache_cpu,
+	    pref_nid = NUMA_NO_NODE, curr_cpu;
+	cpumask_var_t cpus;
+
+	WARN_ON_ONCE(work != &p->cache_work);
+
+	work->next = work;
+
+	if (p->flags & PF_EXITING)
+		return;
+
+	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
+		return;
+
+	curr_cpu = task_cpu(p);
+	cache_cpu = mm->mm_sched_cpu;
+#ifdef CONFIG_NUMA_BALANCING
+	if (static_branch_likely(&sched_numa_balancing))
+		pref_nid = p->numa_preferred_nid;
+#endif
+
+	scoped_guard (cpus_read_lock) {
+		get_scan_cpumasks(cpus, cache_cpu,
+				  pref_nid, curr_cpu);
+
+		for_each_cpu(cpu, cpus) {
+			/* XXX sched_cluster_active */
+			struct sched_domain *sd = per_cpu(sd_llc, cpu);
+			unsigned long occ, m_occ = 0, a_occ = 0;
+			int m_cpu = -1, i;
+
+			if (!sd)
+				continue;
+
+			for_each_cpu(i, sched_domain_span(sd)) {
+				occ = fraction_mm_sched(cpu_rq(i),
+							per_cpu_ptr(mm->pcpu_sched, i));
+				a_occ += occ;
+				if (occ > m_occ) {
+					m_occ = occ;
+					m_cpu = i;
+				}
+			}
+
+			/*
+			 * Compare the accumulated occupancy of each LLC. The
+			 * reason for using accumulated occupancy rather than average
+			 * per CPU occupancy is that it works better in asymmetric LLC
+			 * scenarios.
+			 * For example, if there are 2 threads in a 4CPU LLC and 3
+			 * threads in an 8CPU LLC, it might be better to choose the one
+			 * with 3 threads. However, this would not be the case if the
+			 * occupancy is divided by the number of CPUs in an LLC (i.e.,
+			 * if average per CPU occupancy is used).
+			 * Besides, NUMA balancing fault statistics behave similarly:
+			 * the total number of faults per node is compared rather than
+			 * the average number of faults per CPU. This strategy is also
+			 * followed here.
+			 */
+			if (a_occ > m_a_occ) {
+				m_a_occ = a_occ;
+				m_a_cpu = m_cpu;
+			}
+
+			if (llc_id(cpu) == llc_id(mm->mm_sched_cpu))
+				curr_m_a_occ = a_occ;
+
+			cpumask_andnot(cpus, cpus, sched_domain_span(sd));
+		}
+	}
+
+	if (m_a_occ > (2 * curr_m_a_occ)) {
+		/*
+		 * Avoid switching mm_sched_cpu too fast.
+		 * The reason to choose 2X is because:
+		 * 1. It is better to keep the preferred LLC stable,
+		 *    rather than changing it frequently and cause migrations
+		 * 2. 2X means the new preferred LLC has at least 1 more
+		 *    busy CPU than the old one(200% vs 100%, eg)
+		 * 3. 2X is chosen based on test results, as it delivers
+		 *    the optimal performance gain so far.
+		 */
+		mm->mm_sched_cpu = m_a_cpu;
+	}
+
+	free_cpumask_var(cpus);
+}
+
+void init_sched_mm(struct task_struct *p)
+{
+	struct callback_head *work = &p->cache_work;
+
+	init_task_work(work, task_cache_work);
+	work->next = work;
+}
+
+#else
+
+static inline void account_mm_sched(struct rq *rq, struct task_struct *p,
+				    s64 delta_exec) { }
+
+void init_sched_mm(struct task_struct *p) { }
+
+static void task_tick_cache(struct rq *rq, struct task_struct *p) { }
+
+#endif
+
 /*
  * Used by other classes to account runtime.
  */
@@ -13031,6 +13317,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
+	task_tick_cache(rq, curr);
+
 	update_misfit_status(curr, rq);
 	check_update_overutilized_status(task_rq(curr));
 
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
index be9745d104f7..2ded8d3d0ecc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1166,6 +1166,12 @@ struct rq {
 	u64			clock_pelt_idle_copy;
 	u64			clock_idle_copy;
 #endif
+#ifdef CONFIG_SCHED_CACHE
+	raw_spinlock_t		cpu_epoch_lock ____cacheline_aligned;
+	u64			cpu_runtime;
+	unsigned long		cpu_epoch;
+	unsigned long		cpu_epoch_next;
+#endif
 
 	atomic_t		nr_iowait;
 
@@ -3790,6 +3796,8 @@ static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
 static inline void init_sched_mm_cid(struct task_struct *t) { }
 #endif /* !CONFIG_SCHED_MM_CID */
 
+extern void init_sched_mm(struct task_struct *p);
+
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 static inline
-- 
2.32.0



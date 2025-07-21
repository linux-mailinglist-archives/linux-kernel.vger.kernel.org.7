Return-Path: <linux-kernel+bounces-738723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA19B0BC53
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C1D189AD3B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0C21D3C6;
	Mon, 21 Jul 2025 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEhoEY2u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E521B9E0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078011; cv=none; b=bMhA65CU+31nO7xnr7PPBAAuM7ee4dV1DYprRG3v2X7str9sRGfaX4Qz0HGH5g1KeAt+Dvl/WJ3w6zWemYk5T6OwtmqLuIolYeSS+VFefeHIVLQmnBWw0Yrjt9v5MnWKN5VizscFdu/5j4AcY4yFbETZH4SHnMnR0fzLO+5jxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078011; c=relaxed/simple;
	bh=ap4XLQAIoworGtNPcCnPBhKrBrOdDNQkuLuqycJaVKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwOSvkh2S8+bslM1le2hU2PnE4iV2onN1/hSGSTn6z0qDWBzwjU/gDMQDkwUrTJ9Rks40n2kHRBj+tom0HbK/9FayrOeQ6nun944Q8n67FGu110yoaZoYLXG4lt2yuj3H1KnmspiVNZ3kJUsKAVxU0nQedUA9U2housIGf2JSOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEhoEY2u; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753078010; x=1784614010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ap4XLQAIoworGtNPcCnPBhKrBrOdDNQkuLuqycJaVKw=;
  b=JEhoEY2udr6JuIbrmNnzDwLjqJGSVIYntAhfXeKFJ12N/jDxbAjdJJat
   bHZNuQOYgT98ncQwHf+SbhW4IJbLiMXn0nCZBYWNKMEwKRXxfKwq5uZWy
   I7RR2838l/BG6Wx+juGMnPU4U6fJJvn+lbJfzpLv0Alx02ZnkGJprtUPa
   yVqUlaqL23yhDnHScbH9nUtngEyUUJejneMCZMAxkfA5ce7ugOlOIPdcU
   r2dtHxZT3nFhLir7FXysaQy6sRUl8XME2hhtPxdLrvZ93c4sx44mglh/c
   zeVsg+a7Tu/p6LMdBcza7xnVNFQoP0vGB+Y5L0irMxuFCbt18/L97ecr9
   A==;
X-CSE-ConnectionGUID: QXEObxF3Qo60BUfPmTfr2Q==
X-CSE-MsgGUID: AYntC2vCR0uJMv97qErAsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="54994983"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="54994983"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 23:06:50 -0700
X-CSE-ConnectionGUID: aFJEc/e7SsOJSGAR+rIBJw==
X-CSE-MsgGUID: 7fh+AIb7TyC9LsSM+/nlUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="189696170"
Received: from linux-pnp-server-17.sh.intel.com ([10.239.166.49])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jul 2025 23:06:47 -0700
From: Pan Deng <pan.deng@intel.com>
To: peterz@infradead.org,
	mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	tianyou.li@intel.com,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	pan.deng@intel.com
Subject: [PATCH v2 4/4] sched/rt: Split cpupri_vec->cpumask to per NUMA node to reduce contention
Date: Mon, 21 Jul 2025 14:10:26 +0800
Message-ID: <a3207ebf537bbe5605ff5454f63b5604d83a04a0.1753076363.git.pan.deng@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1753076363.git.pan.deng@intel.com>
References: <cover.1753076363.git.pan.deng@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running a multi-instance FFmpeg workload on HCC system, significant
contention is observed on bitmap of `cpupri_vec->cpumask`.

The SUT is a 2-socket machine with 240 physical cores and 480 logical
CPUs. 60 FFmpeg instances are launched, each pinned to 4 physical cores
(8 logical CPUs) for transcoding tasks. Sub-threads use RT priority 99
with FIFO scheduling. FPS is used as score.

perf c2c tool reveals:
cpumask (bitmap) cache line of `cpupri_vec->mask`:
- bits are loaded during cpupri_find
- bits are stored during cpupri_set
- cycles per load: ~2.2K to 8.7K

This change splits `cpupri_vec->cpumask` into per-NUMA-node data to
mitigate false sharing.

As a result:
- FPS improves by ~3.8%
- Kernel cycles% drops from ~20% to ~18.7%
- Cache line contention is mitigated, perf-c2c shows cycles per load
  drops from ~2.2K-8.7K to ~0.5K-2.2K
- stress-ng cyclic benchmark is improved ~5.9%, command:
  stress-ng/stress-ng --cyclic $(nproc) --cyclic-policy fifo   \
                      --timeout 30 --minimize --metrics
- rt-tests/pi_stress is improved ~9.3%, command:
  rt-tests/pi_stress -D 30 -g $(($(nproc) / 2))

Note: CONFIG_CPUMASK_OFFSTACK=n remains unchanged.

Appendix:
1. Perf c2c report of `cpupri_vec->mask` bitmap cache line:
-------  -------  ------  ------  ------  ------  ------------------------
 Rmt      Lcl     Store   Data    Load    Total    Symbol
Hitm%    Hitm%   L1 Hit%  offset  cycles  records
-------  -------  ------  ------  ------  ------  ------------------------
 155       39       39    0xff14d52c4682d800
-------  -------  ------  ------  ------  ------  ------------------------
43.23%   43.59%    0.00%  0x0     3489    415   _find_first_and_bit
 3.23%    5.13%    0.00%  0x0     3478    107   __bitmap_and
 3.23%    0.00%    0.00%  0x0     2712    33    _find_first_and_bit
 1.94%    0.00%    7.69%  0x0     5992    33    cpupri_set
 0.00%    0.00%    5.13%  0x0     3733    19    cpupri_set
12.90%   12.82%    0.00%  0x8     3452    297   _find_first_and_bit
 1.29%    2.56%    0.00%  0x8     3007    117   __bitmap_and
 0.00%    5.13%    0.00%  0x8     3041    20    _find_first_and_bit
 0.00%    2.56%    2.56%  0x8     2374    22    cpupri_set
 0.00%    0.00%    7.69%  0x8     4194    38    cpupri_set
 8.39%    2.56%    0.00%  0x10    3336    264   _find_first_and_bit
 3.23%    0.00%    0.00%  0x10    3023    46    _find_first_and_bit
 2.58%    0.00%    0.00%  0x10    3040    130   __bitmap_and
 1.29%    0.00%   12.82%  0x10    4075    34    cpupri_set
 0.00%    0.00%    2.56%  0x10    2197    19    cpupri_set
 0.00%    2.56%    7.69%  0x18    4085    27    cpupri_set
 0.00%    2.56%    0.00%  0x18    3128    220   _find_first_and_bit
 0.00%    0.00%    5.13%  0x18    3028    20    cpupri_set
 2.58%    2.56%    0.00%  0x20    3089    198   _find_first_and_bit
 1.29%    0.00%    5.13%  0x20    5114    29    cpupri_set
 0.65%    2.56%    0.00%  0x20    3224    96    __bitmap_and
 0.65%    0.00%    7.69%  0x20    4392    31    cpupri_set
 2.58%    0.00%    0.00%  0x28    3327    214   _find_first_and_bit
 0.65%    2.56%    5.13%  0x28    5252    31    cpupri_set
 0.65%    0.00%    7.69%  0x28    8755    25    cpupri_set
 0.65%    0.00%    0.00%  0x28    4414    14    _find_first_and_bit
 1.29%    2.56%    0.00%  0x30    3139    171   _find_first_and_bit
 0.65%    0.00%    7.69%  0x30    2185    18    cpupri_set
 0.65%    0.00%    0.00%  0x30    3404    108   __bitmap_and
 0.00%    0.00%    2.56%  0x30    5542    21    cpupri_set
 3.23%    5.13%    0.00%  0x38    3493    190   _find_first_and_bit
 3.23%    2.56%    0.00%  0x38    3171    108   __bitmap_and
 0.00%    2.56%    7.69%  0x38    3285    14    cpupri_set
 0.00%    0.00%    5.13%  0x38    4035    27    cpupri_set

Signed-off-by: Pan Deng <pan.deng@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/cpupri.c | 200 ++++++++++++++++++++++++++++++++++++++----
 kernel/sched/cpupri.h |   4 +
 2 files changed, 186 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 42c40cfdf836..306b6baff4cd 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -64,6 +64,143 @@ static int convert_prio(int prio)
 	return cpupri;
 }
 
+#ifdef	CONFIG_CPUMASK_OFFSTACK
+static inline int alloc_vec_masks(struct cpupri_vec *vec)
+{
+	int i;
+
+	for (i = 0; i < nr_node_ids; i++) {
+		if (!zalloc_cpumask_var_node(&vec->masks[i], GFP_KERNEL, i))
+			goto cleanup;
+
+		// Clear masks of cur node, set others
+		bitmap_complement(cpumask_bits(vec->masks[i]),
+			cpumask_bits(cpumask_of_node(i)), small_cpumask_bits);
+	}
+	return 0;
+
+cleanup:
+	while (i--)
+		free_cpumask_var(vec->masks[i]);
+	return -ENOMEM;
+}
+
+static inline void free_vec_masks(struct cpupri_vec *vec)
+{
+	for (int i = 0; i < nr_node_ids; i++)
+		free_cpumask_var(vec->masks[i]);
+}
+
+static inline int setup_vec_mask_var_ts(struct cpupri *cp)
+{
+	int i;
+
+	for (i = 0; i < CPUPRI_NR_PRIORITIES; i++) {
+		struct cpupri_vec *vec = &cp->pri_to_cpu[i];
+
+		vec->masks = kcalloc(nr_node_ids, sizeof(cpumask_var_t), GFP_KERNEL);
+		if (!vec->masks)
+			goto cleanup;
+	}
+	return 0;
+
+cleanup:
+	/* Free any already allocated masks */
+	while (i--) {
+		kfree(cp->pri_to_cpu[i].masks);
+		cp->pri_to_cpu[i].masks = NULL;
+	}
+
+	return -ENOMEM;
+}
+
+static inline void free_vec_mask_var_ts(struct cpupri *cp)
+{
+	for (int i = 0; i < CPUPRI_NR_PRIORITIES; i++) {
+		kfree(cp->pri_to_cpu[i].masks);
+		cp->pri_to_cpu[i].masks = NULL;
+	}
+}
+
+static inline int
+available_cpu_in_nodes(struct task_struct *p, struct cpupri_vec *vec)
+{
+	int cur_node = numa_node_id();
+
+	for (int i = 0; i < nr_node_ids; i++) {
+		int nid = (cur_node + i) % nr_node_ids;
+
+		if (cpumask_first_and_and(&p->cpus_mask, vec->masks[nid],
+					cpumask_of_node(nid)) < nr_cpu_ids)
+			return 1;
+	}
+
+	return 0;
+}
+
+#define available_cpu_in_vec available_cpu_in_nodes
+
+#else /* !CONFIG_CPUMASK_OFFSTACK */
+
+static inline int alloc_vec_masks(struct cpupri_vec *vec)
+{
+	if (!zalloc_cpumask_var(&vec->mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_vec_masks(struct cpupri_vec *vec)
+{
+	free_cpumask_var(vec->mask);
+}
+
+static inline int setup_vec_mask_var_ts(struct cpupri *cp)
+{
+	return 0;
+}
+
+static inline void free_vec_mask_var_ts(struct cpupri *cp)
+{
+}
+
+static inline int
+available_cpu_in_vec(struct task_struct *p, struct cpupri_vec *vec)
+{
+	if (cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids)
+		return 0;
+
+	return 1;
+}
+#endif
+
+static inline int alloc_all_masks(struct cpupri *cp)
+{
+	int i;
+
+	for (i = 0; i < CPUPRI_NR_PRIORITIES; i++) {
+		if (alloc_vec_masks(&cp->pri_to_cpu[i]))
+			goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	while (i--)
+		free_vec_masks(&cp->pri_to_cpu[i]);
+
+	return -ENOMEM;
+}
+
+static inline void setup_vec_counts(struct cpupri *cp)
+{
+	for (int i = 0; i < CPUPRI_NR_PRIORITIES; i++) {
+		struct cpupri_vec *vec = &cp->pri_to_cpu[i];
+
+		atomic_set(&vec->count, 0);
+	}
+}
+
 static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 				struct cpumask *lowest_mask, int idx)
 {
@@ -96,11 +233,24 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 	if (skip)
 		return 0;
 
-	if (cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids)
+	if (!available_cpu_in_vec(p, vec))
 		return 0;
 
+#ifdef	CONFIG_CPUMASK_OFFSTACK
+	struct cpumask *cpupri_mask = lowest_mask;
+
+	// available && lowest_mask
+	if (lowest_mask) {
+		cpumask_copy(cpupri_mask, vec->masks[0]);
+		for (int nid = 1; nid < nr_node_ids; nid++)
+			cpumask_and(cpupri_mask, cpupri_mask, vec->masks[nid]);
+	}
+#else
+	struct cpumask *cpupri_mask = vec->mask;
+#endif
+
 	if (lowest_mask) {
-		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+		cpumask_and(lowest_mask, &p->cpus_mask, cpupri_mask);
 		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
 
 		/*
@@ -229,7 +379,11 @@ void cpupri_set(struct cpupri *cp, int cpu, int newpri)
 	if (likely(newpri != CPUPRI_INVALID)) {
 		struct cpupri_vec *vec = &cp->pri_to_cpu[newpri];
 
+#ifdef	CONFIG_CPUMASK_OFFSTACK
+		cpumask_set_cpu(cpu, vec->masks[cpu_to_node(cpu)]);
+#else
 		cpumask_set_cpu(cpu, vec->mask);
+#endif
 		/*
 		 * When adding a new vector, we update the mask first,
 		 * do a write memory barrier, and then update the count, to
@@ -263,7 +417,11 @@ void cpupri_set(struct cpupri *cp, int cpu, int newpri)
 		 */
 		atomic_dec(&(vec)->count);
 		smp_mb__after_atomic();
+#ifdef	CONFIG_CPUMASK_OFFSTACK
+		cpumask_clear_cpu(cpu, vec->masks[cpu_to_node(cpu)]);
+#else
 		cpumask_clear_cpu(cpu, vec->mask);
+#endif
 	}
 
 	*currpri = newpri;
@@ -279,26 +437,31 @@ int cpupri_init(struct cpupri *cp)
 {
 	int i;
 
-	for (i = 0; i < CPUPRI_NR_PRIORITIES; i++) {
-		struct cpupri_vec *vec = &cp->pri_to_cpu[i];
-
-		atomic_set(&vec->count, 0);
-		if (!zalloc_cpumask_var(&vec->mask, GFP_KERNEL))
-			goto cleanup;
-	}
-
+	/* Allocate the cpu_to_pri array */
 	cp->cpu_to_pri = kcalloc(nr_cpu_ids, sizeof(int), GFP_KERNEL);
 	if (!cp->cpu_to_pri)
-		goto cleanup;
+		return -ENOMEM;
 
+	/* Initialize all CPUs to invalid priority */
 	for_each_possible_cpu(i)
 		cp->cpu_to_pri[i] = CPUPRI_INVALID;
 
+	/* Setup priority vectors */
+	setup_vec_counts(cp);
+	if (setup_vec_mask_var_ts(cp))
+		goto fail_setup_vectors;
+
+	/* Allocate masks for each priority vector */
+	if (alloc_all_masks(cp))
+		goto fail_alloc_masks;
+
 	return 0;
 
-cleanup:
-	for (i--; i >= 0; i--)
-		free_cpumask_var(cp->pri_to_cpu[i].mask);
+fail_alloc_masks:
+	free_vec_mask_var_ts(cp);
+
+fail_setup_vectors:
+	kfree(cp->cpu_to_pri);
 	return -ENOMEM;
 }
 
@@ -308,9 +471,10 @@ int cpupri_init(struct cpupri *cp)
  */
 void cpupri_cleanup(struct cpupri *cp)
 {
-	int i;
-
 	kfree(cp->cpu_to_pri);
-	for (i = 0; i < CPUPRI_NR_PRIORITIES; i++)
-		free_cpumask_var(cp->pri_to_cpu[i].mask);
+
+	for (int i = 0; i < CPUPRI_NR_PRIORITIES; i++)
+		free_vec_masks(&cp->pri_to_cpu[i]);
+
+	free_vec_mask_var_ts(cp);
 }
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index 245b0fa626be..c53f1f4dad86 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -9,7 +9,11 @@
 
 struct cpupri_vec {
 	atomic_t		count;
+#ifdef CONFIG_CPUMASK_OFFSTACK
+	cpumask_var_t		*masks	____cacheline_aligned;
+#else
 	cpumask_var_t		mask	____cacheline_aligned;
+#endif
 };
 
 struct cpupri {
-- 
2.43.5



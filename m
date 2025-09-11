Return-Path: <linux-kernel+bounces-812676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84072B53B52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6DE1CC4370
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C23A36935B;
	Thu, 11 Sep 2025 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7ICjXw9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC93112BB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615045; cv=none; b=s3lCbT5H/DQcHt/sUw2ZGbCyhmYj1tcw/1gJURic5IZdS89u9xcXC3ETImTDC9ykKZagqPhYB0Kep6q6/OHaSrCIM0GAL34svMBGXRL3D5Jau6ydxvcHjGHwWy7MsXgmmMBO3bxF8CBZZDMDPoV6RDKyZTusGG1Wk+tOJiecQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615045; c=relaxed/simple;
	bh=lw6+r78TMSunY1gbvy8K8XKaxLYAB3K+WlDRp5/dB4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqT3eFgGOlNiHZUy/UMxJcVVcKs6rbCPNb38AYRnc4gkdPmS8MvhTbpFnbMaF21laIYNJGKOKv/DGZaUahoBLJyuj/N14nOi91f8LchcbCQubWEu3EXD+PvSA6kCbk0Xx5tz1IEEa/F2r6XOTfQo/H6LbbfDA5k5uNqL7PCUoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7ICjXw9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757615044; x=1789151044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lw6+r78TMSunY1gbvy8K8XKaxLYAB3K+WlDRp5/dB4s=;
  b=G7ICjXw95idSMcb12NT2Lz1wZDqB4mCK+Siqd9BxYaIdtM6wuMYC9bXX
   9ywjFEnbBWmFselGC0hRW5rHrgALR5sQyIFuJIXJOHInP8DtfC+bZyFL+
   iyhYDnVSrzjWLpwv+YjiGhGRMdjDx7eb5iNEwLxBPb5HUJOMVe4cbkcbW
   R2CCXI52UciRZhZphO48tLQF+czgXr3VxwdU2c9GORYuqPknVHjq62p99
   VR0CKVOFXsSKk7kZV3UcXMc/hsg5YbSzHbcirQI5se4gD1E4MC+zOzxzG
   XOzDQKPBJS6FEBta9p/BCdS7o3TWruDWPbUHsgXB7eHnUi6DLEaegfT6U
   Q==;
X-CSE-ConnectionGUID: cy44lVqDSgWNl4Ef0E+zMQ==
X-CSE-MsgGUID: sa2jJ/gpTqiD5SYJ44D0uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="77413635"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="77413635"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 11:24:03 -0700
X-CSE-ConnectionGUID: vSF677PpQwiHcj7sd4I3Hw==
X-CSE-MsgGUID: HMX+tb56R7ajBUp1I7EYMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="173058308"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2025 11:24:03 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Libo Chen <libo.chen@oracle.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH v3 1/2] sched: Create architecture specific sched domain distances
Date: Thu, 11 Sep 2025 11:30:56 -0700
Message-Id: <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1757614784.git.tim.c.chen@linux.intel.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow architecture specific sched domain NUMA distances that can be
modified from NUMA node distances for the purpose of building NUMA
sched domains.

The actual NUMA distances are kept separately.  This allows for NUMA
domain levels modification when building sched domains for specific
architectures.

Consolidate the recording of unique NUMA distances in an array to
sched_record_numa_dist() so the function can be reused to record NUMA
distances when the NUMA distance metric is changed.

No functional change if there's no arch specific NUMA distances
are being defined.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/sched/topology.h |   2 +
 kernel/sched/topology.c        | 114 ++++++++++++++++++++++++++++-----
 2 files changed, 99 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 5263746b63e8..4f58e78ca52e 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -59,6 +59,8 @@ static inline int cpu_numa_flags(void)
 #endif
 
 extern int arch_asym_cpu_priority(int cpu);
+extern int arch_sched_node_distance(int from, int to);
+extern int sched_avg_remote_numa_distance;
 
 struct sched_domain_attr {
 	int relax_domain_level;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133bb8a4..6c0ff62322cb 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1591,10 +1591,13 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
 enum numa_topology_type sched_numa_topology_type;
 
 static int			sched_domains_numa_levels;
+static int			sched_numa_node_levels;
 static int			sched_domains_curr_level;
 
 int				sched_max_numa_distance;
+int				sched_avg_remote_numa_distance;
 static int			*sched_domains_numa_distance;
+static int			*sched_numa_node_distance;
 static struct cpumask		***sched_domains_numa_masks;
 #endif /* CONFIG_NUMA */
 
@@ -1808,10 +1811,10 @@ bool find_numa_distance(int distance)
 		return true;
 
 	rcu_read_lock();
-	distances = rcu_dereference(sched_domains_numa_distance);
+	distances = rcu_dereference(sched_numa_node_distance);
 	if (!distances)
 		goto unlock;
-	for (i = 0; i < sched_domains_numa_levels; i++) {
+	for (i = 0; i < sched_numa_node_levels; i++) {
 		if (distances[i] == distance) {
 			found = true;
 			break;
@@ -1887,14 +1890,32 @@ static void init_numa_topology_type(int offline_node)
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
-void sched_init_numa(int offline_node)
+/*
+ * Architecture could modify NUMA distance, to change
+ * grouping of NUMA nodes and number of NUMA levels when creating
+ * NUMA level sched domains.
+ *
+ * One NUMA level is created for each unique
+ * arch_sched_node_distance.
+ */
+int __weak arch_sched_node_distance(int from, int to)
+{
+	return node_distance(from, to);
+}
+
+static int numa_node_dist(int i, int j)
+{
+	return node_distance(i, j);
+}
+
+static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
+		int **dist, int *levels)
+
 {
-	struct sched_domain_topology_level *tl;
 	unsigned long *distance_map;
 	int nr_levels = 0;
 	int i, j;
 	int *distances;
-	struct cpumask ***masks;
 
 	/*
 	 * O(nr_nodes^2) de-duplicating selection sort -- in order to find the
@@ -1902,17 +1923,17 @@ void sched_init_numa(int offline_node)
 	 */
 	distance_map = bitmap_alloc(NR_DISTANCE_VALUES, GFP_KERNEL);
 	if (!distance_map)
-		return;
+		return -ENOMEM;
 
 	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
 	for_each_cpu_node_but(i, offline_node) {
 		for_each_cpu_node_but(j, offline_node) {
-			int distance = node_distance(i, j);
+			int distance = n_dist(i, j);
 
 			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
 				sched_numa_warn("Invalid distance value range");
 				bitmap_free(distance_map);
-				return;
+				return -EINVAL;
 			}
 
 			bitmap_set(distance_map, distance, 1);
@@ -1927,17 +1948,66 @@ void sched_init_numa(int offline_node)
 	distances = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
 	if (!distances) {
 		bitmap_free(distance_map);
-		return;
+		return -ENOMEM;
 	}
-
 	for (i = 0, j = 0; i < nr_levels; i++, j++) {
 		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
 		distances[i] = j;
 	}
-	rcu_assign_pointer(sched_domains_numa_distance, distances);
+	*dist = distances;
+	*levels = nr_levels;
 
 	bitmap_free(distance_map);
 
+	return 0;
+}
+
+static int avg_remote_numa_distance(int offline_node)
+{
+	int i, j;
+	int distance, nr_remote = 0, total_distance = 0;
+
+	for_each_cpu_node_but(i, offline_node) {
+		for_each_cpu_node_but(j, offline_node) {
+			distance = node_distance(i, j);
+
+			if (distance >= REMOTE_DISTANCE) {
+				nr_remote++;
+				total_distance += distance;
+			}
+		}
+	}
+	if (nr_remote)
+		return total_distance / nr_remote;
+	else
+		return REMOTE_DISTANCE;
+}
+
+void sched_init_numa(int offline_node)
+{
+	struct sched_domain_topology_level *tl;
+	int nr_levels, nr_node_levels;
+	int i, j;
+	int *distances, *domain_distances;
+	struct cpumask ***masks;
+
+	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances,
+				   &nr_node_levels))
+		return;
+
+	WRITE_ONCE(sched_avg_remote_numa_distance,
+		   avg_remote_numa_distance(offline_node));
+
+	if (sched_record_numa_dist(offline_node,
+				   arch_sched_node_distance, &domain_distances,
+				   &nr_levels)) {
+		kfree(distances);
+		return;
+	}
+	rcu_assign_pointer(sched_numa_node_distance, distances);
+	WRITE_ONCE(sched_max_numa_distance, distances[nr_node_levels - 1]);
+	WRITE_ONCE(sched_numa_node_levels, nr_node_levels);
+
 	/*
 	 * 'nr_levels' contains the number of unique distances
 	 *
@@ -1954,6 +2024,8 @@ void sched_init_numa(int offline_node)
 	 *
 	 * We reset it to 'nr_levels' at the end of this function.
 	 */
+	rcu_assign_pointer(sched_domains_numa_distance, domain_distances);
+
 	sched_domains_numa_levels = 0;
 
 	masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
@@ -1979,10 +2051,13 @@ void sched_init_numa(int offline_node)
 			masks[i][j] = mask;
 
 			for_each_cpu_node_but(k, offline_node) {
-				if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
+				if (sched_debug() &&
+				    (arch_sched_node_distance(j, k) !=
+				     arch_sched_node_distance(k, j)))
 					sched_numa_warn("Node-distance not symmetric");
 
-				if (node_distance(j, k) > sched_domains_numa_distance[i])
+				if (arch_sched_node_distance(j, k) >
+				    sched_domains_numa_distance[i])
 					continue;
 
 				cpumask_or(mask, mask, cpumask_of_node(k));
@@ -2022,7 +2097,6 @@ void sched_init_numa(int offline_node)
 	sched_domain_topology = tl;
 
 	sched_domains_numa_levels = nr_levels;
-	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
 
 	init_numa_topology_type(offline_node);
 }
@@ -2030,14 +2104,18 @@ void sched_init_numa(int offline_node)
 
 static void sched_reset_numa(void)
 {
-	int nr_levels, *distances;
+	int nr_levels, *distances, *dom_distances;
 	struct cpumask ***masks;
 
 	nr_levels = sched_domains_numa_levels;
+	sched_numa_node_levels = 0;
 	sched_domains_numa_levels = 0;
 	sched_max_numa_distance = 0;
+	sched_avg_remote_numa_distance = 0;
 	sched_numa_topology_type = NUMA_DIRECT;
-	distances = sched_domains_numa_distance;
+	distances = sched_numa_node_distance;
+	dom_distances = sched_domains_numa_distance;
+	rcu_assign_pointer(sched_numa_node_distance, NULL);
 	rcu_assign_pointer(sched_domains_numa_distance, NULL);
 	masks = sched_domains_numa_masks;
 	rcu_assign_pointer(sched_domains_numa_masks, NULL);
@@ -2054,6 +2132,7 @@ static void sched_reset_numa(void)
 			kfree(masks[i]);
 		}
 		kfree(masks);
+		kfree(dom_distances);
 	}
 	if (sched_domain_topology_saved) {
 		kfree(sched_domain_topology);
@@ -2092,7 +2171,8 @@ void sched_domains_numa_masks_set(unsigned int cpu)
 				continue;
 
 			/* Set ourselves in the remote node's masks */
-			if (node_distance(j, node) <= sched_domains_numa_distance[i])
+			if (arch_sched_node_distance(j, node) <=
+			    sched_domains_numa_distance[i])
 				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
 		}
 	}
-- 
2.32.0



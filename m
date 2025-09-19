Return-Path: <linux-kernel+bounces-825044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F786B8ACBA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD581C24932
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BF7322A35;
	Fri, 19 Sep 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9XBeUdR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3B3218C8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303820; cv=none; b=ZKO474HqFIoq2KdzR7/XVaXEWrBcGXB+w1zUMlaL/JLbFI5pxtOSMxj1pbXNNy50lVEcr5lGIrlMNfI+fQO2VtsmvgiVVPaykbv8ef1OJ4RvWFxCRouCH1pVLPyA0EbDwSOxRaaU3tHFPTNe20/NreaS8tByzTfTiDS4XltaPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303820; c=relaxed/simple;
	bh=g2PyzMfnTbZiBNiMxrdnOBQliKWms9V5xHJ7iY+fZ6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCKzeKDzGMPBaeUugZKf5TfwXfWJKAYv28z3bckykTpGqLC/pm7eS6+/Ewqr43tHc6r2rx3Pa1wAuqnAZkJNrBs/PxfmD+7hHx8fAR/2hLnFHFpW19VH5jDdmZ5xTbkzDaMH/pfDAMIK07UjwuR+VRrcCxs2JSJXLMKnhQBbwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9XBeUdR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758303817; x=1789839817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g2PyzMfnTbZiBNiMxrdnOBQliKWms9V5xHJ7iY+fZ6Q=;
  b=n9XBeUdRb/tmv8GCfkwkotcqLU+9feIm0T2oMEd0Y+nLduLA2Sqe4QU0
   U/7zNl6AQgbWn/d16qzLmP8MNsoll0/3rvmYbbCHrXJzrIUVUmCceksj7
   6FzrPd6T6enZD0duHumVe3MnFEcsrxf4tRiVetR4E2rKA/qM9s5gnlNQn
   +0q9Z+KbAbSRgArWWHYZajj7INrvp0APEGjnY5vgWzsCPs5TAm57R/rHa
   JiVJn+1sFz8rX5Rcd791Nk82sK6YFljJqqn2UKBrMMKK5L/HXr+bi2hRr
   xNu4jah8fBpjuubw99IxOUokzEL7sKyfoT5pnxW1+zxPNZKx3NW4Ve2QT
   A==;
X-CSE-ConnectionGUID: CQ6SG6GoTMKe+NsUKa9b3A==
X-CSE-MsgGUID: HIUsi0XNSySBANJ/CgB2ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60769818"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60769818"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:43:36 -0700
X-CSE-ConnectionGUID: CxzwIVIkRCG5uXMi3OogHA==
X-CSE-MsgGUID: PJD5jqn0QayRHxY/vba4RA==
X-ExtLoop1: 1
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa003.fm.intel.com with ESMTP; 19 Sep 2025 10:43:36 -0700
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
	Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH v4 1/2] sched: Create architecture specific sched domain distances
Date: Fri, 19 Sep 2025 10:50:11 -0700
Message-Id: <990005f249897c6ef2e7d998c68836eba604f346.1758234869.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1758234869.git.tim.c.chen@linux.intel.com>
References: <cover.1758234869.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow architecture specific sched domain NUMA distances that are
modified from actual NUMA node distances for the purpose of building
NUMA sched domains.

Keep actual NUMA distances separately if modified distances
are used for building sched domains. Such distances
are still needed as NUMA balancing benefits from finding the
NUMA nodes that are actually closer to a task numa_group.

Consolidate the recording of unique NUMA distances in an array to
sched_record_numa_dist() so the function can be reused to record NUMA
distances when the NUMA distance metric is changed.

No functional change and additional distance array
allocated if there're no arch specific NUMA distances
being defined.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/sched/topology.h |   1 +
 kernel/sched/topology.c        | 117 ++++++++++++++++++++++++++-------
 2 files changed, 96 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 5263746b63e8..2d2d29553df8 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -56,6 +56,7 @@ static inline int cpu_numa_flags(void)
 {
 	return SD_NUMA;
 }
+extern int arch_sched_node_distance(int from, int to);
 #endif
 
 extern int arch_asym_cpu_priority(int cpu);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6e2f54169e66..f25e4402c63e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1591,10 +1591,12 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
 enum numa_topology_type sched_numa_topology_type;
 
 static int			sched_domains_numa_levels;
+static int			sched_numa_node_levels;
 static int			sched_domains_curr_level;
 
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
+static int			*sched_numa_node_distance;
 static struct cpumask		***sched_domains_numa_masks;
 #endif /* CONFIG_NUMA */
 
@@ -1808,10 +1810,10 @@ bool find_numa_distance(int distance)
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
@@ -1887,14 +1889,48 @@ static void init_numa_topology_type(int offline_node)
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
-void sched_init_numa(int offline_node)
+/*
+ * An architecture could modify its NUMA distance, to change
+ * grouping of NUMA nodes and number of NUMA levels when creating
+ * NUMA level sched domains.
+ *
+ * A NUMA level is created for each unique
+ * arch_sched_node_distance.
+ */
+static bool __modified_sched_node_dist = true;
+
+int __weak arch_sched_node_distance(int from, int to)
 {
-	struct sched_domain_topology_level *tl;
-	unsigned long *distance_map;
+	if (__modified_sched_node_dist)
+		__modified_sched_node_dist = false;
+
+	return node_distance(from, to);
+}
+
+static bool modified_sched_node_distance(void)
+{
+	/*
+	 * Call arch_sched_node_distance()
+	 * to determine if arch_sched_node_distance
+	 * has been modified from node_distance()
+	 * to arch specific distance.
+	 */
+	arch_sched_node_distance(0, 0);
+	return __modified_sched_node_dist;
+}
+
+static int numa_node_dist(int i, int j)
+{
+	return node_distance(i, j);
+}
+
+static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
+				  int **dist, int *levels)
+{
+	unsigned long *distance_map __free(bitmap) = NULL;
 	int nr_levels = 0;
 	int i, j;
 	int *distances;
-	struct cpumask ***masks;
 
 	/*
 	 * O(nr_nodes^2) de-duplicating selection sort -- in order to find the
@@ -1902,17 +1938,16 @@ void sched_init_numa(int offline_node)
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
-				bitmap_free(distance_map);
-				return;
+				return -EINVAL;
 			}
 
 			bitmap_set(distance_map, distance, 1);
@@ -1925,18 +1960,46 @@ void sched_init_numa(int offline_node)
 	nr_levels = bitmap_weight(distance_map, NR_DISTANCE_VALUES);
 
 	distances = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
-	if (!distances) {
-		bitmap_free(distance_map);
-		return;
-	}
+	if (!distances)
+		return -ENOMEM;
 
 	for (i = 0, j = 0; i < nr_levels; i++, j++) {
 		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
 		distances[i] = j;
 	}
-	rcu_assign_pointer(sched_domains_numa_distance, distances);
+	*dist = distances;
+	*levels = nr_levels;
+
+	return 0;
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
+	/* Record the NUMA distances from SLIT table */
+	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances,
+				   &nr_node_levels))
+		return;
 
-	bitmap_free(distance_map);
+	/* Record modified NUMA distances for building sched domains */
+	if (modified_sched_node_distance()) {
+		if (sched_record_numa_dist(offline_node, arch_sched_node_distance,
+					   &domain_distances, &nr_levels)) {
+			kfree(distances);
+			return;
+		}
+	} else {
+		domain_distances = distances;
+		nr_levels = nr_node_levels;
+	}
+	rcu_assign_pointer(sched_numa_node_distance, distances);
+	WRITE_ONCE(sched_max_numa_distance, distances[nr_node_levels - 1]);
+	WRITE_ONCE(sched_numa_node_levels, nr_node_levels);
 
 	/*
 	 * 'nr_levels' contains the number of unique distances
@@ -1954,6 +2017,8 @@ void sched_init_numa(int offline_node)
 	 *
 	 * We reset it to 'nr_levels' at the end of this function.
 	 */
+	rcu_assign_pointer(sched_domains_numa_distance, domain_distances);
+
 	sched_domains_numa_levels = 0;
 
 	masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
@@ -1979,10 +2044,13 @@ void sched_init_numa(int offline_node)
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
@@ -2022,7 +2090,6 @@ void sched_init_numa(int offline_node)
 	sched_domain_topology = tl;
 
 	sched_domains_numa_levels = nr_levels;
-	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
 
 	init_numa_topology_type(offline_node);
 }
@@ -2030,14 +2097,18 @@ void sched_init_numa(int offline_node)
 
 static void sched_reset_numa(void)
 {
-	int nr_levels, *distances;
+	int nr_levels, *distances, *dom_distances = NULL;
 	struct cpumask ***masks;
 
 	nr_levels = sched_domains_numa_levels;
+	sched_numa_node_levels = 0;
 	sched_domains_numa_levels = 0;
 	sched_max_numa_distance = 0;
 	sched_numa_topology_type = NUMA_DIRECT;
-	distances = sched_domains_numa_distance;
+	distances = sched_numa_node_distance;
+	if (sched_numa_node_distance != sched_domains_numa_distance)
+		dom_distances = sched_domains_numa_distance;
+	rcu_assign_pointer(sched_numa_node_distance, NULL);
 	rcu_assign_pointer(sched_domains_numa_distance, NULL);
 	masks = sched_domains_numa_masks;
 	rcu_assign_pointer(sched_domains_numa_masks, NULL);
@@ -2046,6 +2117,7 @@ static void sched_reset_numa(void)
 
 		synchronize_rcu();
 		kfree(distances);
+		kfree(dom_distances);
 		for (i = 0; i < nr_levels && masks; i++) {
 			if (!masks[i])
 				continue;
@@ -2092,7 +2164,8 @@ void sched_domains_numa_masks_set(unsigned int cpu)
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



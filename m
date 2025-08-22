Return-Path: <linux-kernel+bounces-782666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C2B32362
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88780B6416C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676F2877F5;
	Fri, 22 Aug 2025 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXlvJtcV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81324679A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893248; cv=none; b=rH2sivCtQvk+AkpCinCrtYdWW6wgCVbOPC0Q6yWCiUBKihUero5SdYsjMfun47wq5n6i7uY1r+DAsXerowyubhoIfaFKxKLzveGbKXadVxEvcaWy/SrH4j4/ZM/kqLkKa/DqGNuXUrGVwipayFuOEK3uugSC5QY45Z1ZR2fL+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893248; c=relaxed/simple;
	bh=kmcIvANx/AgHuf7FNEKdlFhuanXpYUOQb3BQURLxuMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7h3sI+q+8Ppvm2+YxFeWQWbzBBFxqRgN3bD9z6YQRCR938beLpBrPgFcVejMA23jsb6P4Yfm/r70m4s0Y8gYHLqRsWfN3tU8VOcmxDu+bVX8prcnt69uO8fjVBc8nFoRHZdfORGGBR3xZt/K7cCAPPJLTrhm969EPKYa+rEWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXlvJtcV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755893246; x=1787429246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kmcIvANx/AgHuf7FNEKdlFhuanXpYUOQb3BQURLxuMM=;
  b=YXlvJtcV0nDhA7BZKOV8XQfTUXBVZVHU+tUiiIaxlzDqUMJ0JGUf/L1l
   fU0VkzDC452Il5Q4AQ0r35z63TIYDUuTuQu8t3wQpUhkL3vfODFvLIsBq
   GfHOsDnAkThNa9H3cJ8xvCMzOtKSGQXQExtA+8EZiDgKPPPgZ+aOFZi1d
   EFnIYWdPJj3eOdpOHvs7c1UI/oKIQlxotgWcRdrE0WnHQJGP31KGZEKwQ
   4qPityaZM81C+apugiMqGzlJtCaTw2u/kDekGA2cAgrCO9Zhbgrc8VXB/
   oSeMqHpXJIZkn1/Pxli3q0Uz+eLQK/4zMF8pgKz4J80fcv1abSF73OK0j
   w==;
X-CSE-ConnectionGUID: jTpw0AW1RAe+iR64AFbB+g==
X-CSE-MsgGUID: VTts1/mAQaaumeR2DyQzYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57224585"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="57224585"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 13:07:24 -0700
X-CSE-ConnectionGUID: f07wQEb7TZaPzziqMq15+w==
X-CSE-MsgGUID: wuyAEdaXSwqfdM8dn1Hilg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169145763"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa008.fm.intel.com with ESMTP; 22 Aug 2025 13:07:23 -0700
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
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH 2/2] sched: Fix sched domain build error for GNR-X, CWF-X in SNC-3 mode
Date: Fri, 22 Aug 2025 13:14:15 -0700
Message-Id: <86ddfe75510497829a84e696b29bfdd7a4940009.1755893468.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1755893468.git.tim.c.chen@linux.intel.com>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for Granite Rapids X (GNR) and Clearwater Forest X
(CWF) to have up to 3 dies per package. When sub-numa cluster (SNC-3)
is enabled, each die will become a separate NUMA node in the package
with different distances between dies within the same package.

For example, on GNR-X, we see the following numa distances for a 2 socket
system with 3 dies per socket:

        package 1       package2
            ----------------
            |               |
        ---------       ---------
        |   0   |       |   3   |
        ---------       ---------
            |               |
        ---------       ---------
        |   1   |       |   4   |
        ---------       ---------
            |               |
        ---------       ---------
        |   2   |       |   5   |
        ---------       ---------
            |               |
            ----------------

node distances:
node     0    1    2    3    4    5
   0:   10   15   17   21   28   26
   1:   15   10   15   23   26   23
   2:   17   15   10   26   23   21
   3:   21   28   26   10   15   17
   4:   23   26   23   15   10   15
   5:   26   23   21   17   15   10

The node distances above led to 2 problems:

1. Asymmetric routes taken between nodes in different packages led to
asymmetric scheduler domain perspective depending on which node you
are on.  Current scheduler code failed to build domains properly with
asymmetric distances.

2. Multiple remote distances to respective tiles on remote package create
too many levels of domain hierarchies grouping different nodes between
remote packages.

For example, the above GNR-X topology lead to NUMA domains below:

Sched domains from the perspective of a CPU in node 0, where the number
in bracket represent node number.

NUMA-level 1	[0,1] [2]
NUMA-level 2	[0,1,2] [3]
NUMA-level 3	[0,1,2,3] [5]
NUMA-level 4	[0,1,2,3,5] [4]

Sched domains from the perspective of a CPU in node 4
NUMA-level 1	[4] [3,5]
NUMA-level 2	[3,4,5] [0,2]
NUMA-level 3	[0,2,3,4,5] [1]

Scheduler group peers for load balancing from the perspective of CPU 0
and 4 are different.  Improper task could be chosen for load balancing
between groups such as [0,2,3,4,5] [1].  Ideally you should choose nodes
in 0 or 2 that are in same package as node 1 first.  But instead tasks
in the remote package node 3, 4, 5 could be chosen with an equal chance
and could lead to excessive remote package migrations and imbalance of
load between packages.  We should not group partial remote nodes and
local nodes together.

Simplify the remote distances for CWF-X and GNR-X for the purpose of
sched domains building, which maintains symmetry and leads to a more
reasonable load balance hierarchy.

The sched domains from the perspective of a CPU in node 0 NUMA-level 1
is now
NUMA-level 1	[0,1] [2]
NUMA-level 2	[0,1,2] [3,4,5]

The sched domains from the perspective of a CPU in node 4 NUMA-level 1
is now
NUMA-level 1	[4] [3,5]
NUMA-level 2	[3,4,5] [0,1,2]

We have the same balancing perspective from node 0 or node 4.  Loads are
now balanced equally between packages.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
---
 arch/x86/kernel/smpboot.c      | 28 ++++++++++++++++++++++++++++
 include/linux/sched/topology.h |  1 +
 kernel/sched/topology.c        | 25 +++++++++++++++++++------
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 33e166f6ab12..c425e84c88b5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -515,6 +515,34 @@ static void __init build_sched_topology(void)
 	set_sched_topology(topology);
 }
 
+int sched_node_distance(int from, int to)
+{
+	int d = node_distance(from, to);
+
+	if (!x86_has_numa_in_package)
+		return d;
+
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_GRANITERAPIDS_X:
+	case INTEL_ATOM_DARKMONT_X:
+		if (d < REMOTE_DISTANCE)
+			return d;
+
+		/*
+		 * Trim finer distance tuning for nodes in remote package
+		 * for the purpose of building sched domains.
+		 * Put NUMA nodes in each remote package in a single sched group.
+		 * Simplify NUMA domains and avoid extra NUMA levels including different
+		 * NUMA nodes in remote packages.
+		 *
+		 * GNR-x and CWF-X has GLUELESS-MESH topology with SNC
+		 * turned on.
+		 */
+		d = (d / 10) * 10;
+	}
+	return d;
+}
+
 void set_cpu_sibling_map(int cpu)
 {
 	bool has_smt = __max_threads_per_core > 1;
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 5263746b63e8..3b62226394af 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -59,6 +59,7 @@ static inline int cpu_numa_flags(void)
 #endif
 
 extern int arch_asym_cpu_priority(int cpu);
+extern int sched_node_distance(int from, int to);
 
 struct sched_domain_attr {
 	int relax_domain_level;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9a7ac67e3d63..3f485da994a7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1804,7 +1804,7 @@ bool find_numa_distance(int distance)
 	bool found = false;
 	int i, *distances;
 
-	if (distance == node_distance(0, 0))
+	if (distance == sched_node_distance(0, 0))
 		return true;
 
 	rcu_read_lock();
@@ -1887,6 +1887,15 @@ static void init_numa_topology_type(int offline_node)
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
+/*
+ * Architecture could simplify NUMA distance, to avoid
+ * creating too many NUMA levels when SNC is turned on.
+ */
+int __weak sched_node_distance(int from, int to)
+{
+	return node_distance(from, to);
+}
+
 void sched_init_numa(int offline_node)
 {
 	struct sched_domain_topology_level *tl;
@@ -1894,6 +1903,7 @@ void sched_init_numa(int offline_node)
 	int nr_levels = 0;
 	int i, j;
 	int *distances;
+	int max_dist = 0;
 	struct cpumask ***masks;
 
 	/*
@@ -1907,7 +1917,10 @@ void sched_init_numa(int offline_node)
 	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
 	for_each_cpu_node_but(i, offline_node) {
 		for_each_cpu_node_but(j, offline_node) {
-			int distance = node_distance(i, j);
+			int distance = sched_node_distance(i, j);
+
+			if (node_distance(i,j) > max_dist)
+				max_dist = node_distance(i,j);
 
 			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
 				sched_numa_warn("Invalid distance value range");
@@ -1979,10 +1992,10 @@ void sched_init_numa(int offline_node)
 			masks[i][j] = mask;
 
 			for_each_cpu_node_but(k, offline_node) {
-				if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
+				if (sched_debug() && (sched_node_distance(j, k) != sched_node_distance(k, j)))
 					sched_numa_warn("Node-distance not symmetric");
 
-				if (node_distance(j, k) > sched_domains_numa_distance[i])
+				if (sched_node_distance(j, k) > sched_domains_numa_distance[i])
 					continue;
 
 				cpumask_or(mask, mask, cpumask_of_node(k));
@@ -2022,7 +2035,7 @@ void sched_init_numa(int offline_node)
 	sched_domain_topology = tl;
 
 	sched_domains_numa_levels = nr_levels;
-	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
+	WRITE_ONCE(sched_max_numa_distance, max_dist);
 
 	init_numa_topology_type(offline_node);
 }
@@ -2092,7 +2105,7 @@ void sched_domains_numa_masks_set(unsigned int cpu)
 				continue;
 
 			/* Set ourselves in the remote node's masks */
-			if (node_distance(j, node) <= sched_domains_numa_distance[i])
+			if (sched_node_distance(j, node) <= sched_domains_numa_distance[i])
 				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
 		}
 	}
-- 
2.32.0



Return-Path: <linux-kernel+bounces-868006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A60CC04217
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC043A75C5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14958258CE8;
	Fri, 24 Oct 2025 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PV8TnfUG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F314B06C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273260; cv=none; b=oiBgMAR8JbUN4jqCKgUecua9z5anNbUwnklimZjYgIGb9vnQM57vocgRCg2C/v6vCzKcLr+z4/etmtvznIck/RWZIbKuFMXSAu/d6jJb2wY2gRAaagv7QORU7v763+vrByKuePoNG84ht0YcZzG6R+07aX+XXTntItR9moCR19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273260; c=relaxed/simple;
	bh=1RrVKYLExvh2qmlc0BJ6Or1i2dHqMzPUAJahlaS46Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C13NiVuRwpfG3ISsJsNnK3HFGYaGqUNSEAlfqhkpLRrRInoeggDA3lGaYI3ag6KjfTwGYUdrlrPhBUX+39zURAEYsTRh54KOW031JGJbmuy9JtyvVXMCOTPmvOczbgfTN85dGyQM7/eySVptqgz51XZb8C4B1FuJPDiFpWavxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PV8TnfUG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761273258; x=1792809258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1RrVKYLExvh2qmlc0BJ6Or1i2dHqMzPUAJahlaS46Cw=;
  b=PV8TnfUGlQKWyQxO96mQGI2hDafqeYrnlRYfI3VdrVc3dnE8thOFcO/d
   2g5MIioE386GJ8s99tqlgN9/FIFqEfcg+t+VNpFYhIT9Ac4wJyxq4REE/
   Jm2hizvaY0NP6nTKMBzkPAQs1iKfY4nbgONhVpzGJdDiAciIZEDIrZy4L
   SpYbO9OVp+r1GwP7a6S/zFkRQ+sbaRgUl0eq1xMHqZGBPvVGv5L+rpb39
   KskzQFPZ4ES8BV9eM8l6koIFhr8uZp569l5tOdccwbIz/ZuC8jwHcuIlH
   6aYJmihU38WbEN4WrNT7c8OlUszLu1n2ENptz1Fr8rlbq9ZrXZ2M2SSlq
   A==;
X-CSE-ConnectionGUID: A6xYNrmPT3y8cslVYY82zg==
X-CSE-MsgGUID: N9FqGMd/TsOzYpZB1NMG0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67289505"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67289505"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:34:17 -0700
X-CSE-ConnectionGUID: 6OykCOhxSjKwVXV6U+PnRQ==
X-CSE-MsgGUID: NyuBCTLZRWSbMfCMxYkrGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="207965386"
Received: from linux-pnp-server-11.sh.intel.com ([10.239.176.178])
  by fmviesa002.fm.intel.com with ESMTP; 23 Oct 2025 19:34:15 -0700
From: Wangyang Guo <wangyang.guo@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Wangyang Guo <wangyang.guo@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Liang <dan.liang@intel.com>
Subject: [PATCH] lib/group_cpus: make group CPU cluster aware
Date: Fri, 24 Oct 2025 10:30:38 +0800
Message-ID: <20251024023038.872616-1-wangyang.guo@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As CPU core counts increase, the number of NVMe IRQs may be smaller than
the total number of CPUs. This forces multiple CPUs to share the same
IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
performance penalty can be observed on some platforms.

This patch improves IRQ affinity by grouping CPUs by cluster within each
NUMA domain, ensuring better locality between CPUs and their assigned
NVMe IRQs.

Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Tested-by: Dan Liang <dan.liang@intel.com>
Signed-off-by: Wangyang Guo <wangyang.guo@intel.com>
---
 lib/group_cpus.c | 269 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 204 insertions(+), 65 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 6d08ac05f371..56ca6193736d 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -114,48 +114,15 @@ static int ncpus_cmp_func(const void *l, const void *r)
 	return ln->ncpus - rn->ncpus;
 }
 
-/*
- * Allocate group number for each node, so that for each node:
- *
- * 1) the allocated number is >= 1
- *
- * 2) the allocated number is <= active CPU number of this node
- *
- * The actual allocated total groups may be less than @numgrps when
- * active total CPU number is less than @numgrps.
- *
- * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
- * for each node.
- */
-static void alloc_nodes_groups(unsigned int numgrps,
-			       cpumask_var_t *node_to_cpumask,
-			       const struct cpumask *cpu_mask,
-			       const nodemask_t nodemsk,
-			       struct cpumask *nmsk,
-			       struct node_groups *node_groups)
+static void alloc_groups_to_nodes(unsigned int numgrps,
+				  unsigned int numcpus,
+				  struct node_groups *node_groups,
+				  unsigned int num_nodes)
 {
-	unsigned n, remaining_ncpus = 0;
-
-	for (n = 0; n < nr_node_ids; n++) {
-		node_groups[n].id = n;
-		node_groups[n].ncpus = UINT_MAX;
-	}
-
-	for_each_node_mask(n, nodemsk) {
-		unsigned ncpus;
-
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
-		ncpus = cpumask_weight(nmsk);
+	unsigned int n, remaining_ncpus = numcpus;
+	unsigned int  ngroups, ncpus;
 
-		if (!ncpus)
-			continue;
-		remaining_ncpus += ncpus;
-		node_groups[n].ncpus = ncpus;
-	}
-
-	numgrps = min_t(unsigned, remaining_ncpus, numgrps);
-
-	sort(node_groups, nr_node_ids, sizeof(node_groups[0]),
+	sort(node_groups, num_nodes, sizeof(node_groups[0]),
 	     ncpus_cmp_func, NULL);
 
 	/*
@@ -226,9 +193,8 @@ static void alloc_nodes_groups(unsigned int numgrps,
 	 * finally for each node X: grps(X) <= ncpu(X).
 	 *
 	 */
-	for (n = 0; n < nr_node_ids; n++) {
-		unsigned ngroups, ncpus;
 
+	for (n = 0; n < num_nodes; n++) {
 		if (node_groups[n].ncpus == UINT_MAX)
 			continue;
 
@@ -246,12 +212,199 @@ static void alloc_nodes_groups(unsigned int numgrps,
 	}
 }
 
+/*
+ * Allocate group number for each node, so that for each node:
+ *
+ * 1) the allocated number is >= 1
+ *
+ * 2) the allocated number is <= active CPU number of this node
+ *
+ * The actual allocated total groups may be less than @numgrps when
+ * active total CPU number is less than @numgrps.
+ *
+ * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
+ * for each node.
+ */
+static void alloc_nodes_groups(unsigned int numgrps,
+			       cpumask_var_t *node_to_cpumask,
+			       const struct cpumask *cpu_mask,
+			       const nodemask_t nodemsk,
+			       struct cpumask *nmsk,
+			       struct node_groups *node_groups)
+{
+	unsigned int n, numcpus = 0;
+
+	for (n = 0; n < nr_node_ids; n++) {
+		node_groups[n].id = n;
+		node_groups[n].ncpus = UINT_MAX;
+	}
+
+	for_each_node_mask(n, nodemsk) {
+		unsigned int ncpus;
+
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		ncpus = cpumask_weight(nmsk);
+
+		if (!ncpus)
+			continue;
+		numcpus += ncpus;
+		node_groups[n].ncpus = ncpus;
+	}
+
+	numgrps = min_t(unsigned int, numcpus, numgrps);
+	alloc_groups_to_nodes(numgrps, numcpus, node_groups, nr_node_ids);
+}
+
+static void assign_cpus_to_groups(unsigned int ncpus,
+				  struct cpumask *nmsk,
+				  struct node_groups *nv,
+				  struct cpumask *masks,
+				  unsigned int *curgrp,
+				  unsigned int last_grp)
+{
+	unsigned int v, cpus_per_grp, extra_grps;
+	/* Account for rounding errors */
+	extra_grps = ncpus - nv->ngroups * (ncpus / nv->ngroups);
+
+	/* Spread allocated groups on CPUs of the current node */
+	for (v = 0; v < nv->ngroups; v++, *curgrp += 1) {
+		cpus_per_grp = ncpus / nv->ngroups;
+
+		/* Account for extra groups to compensate rounding errors */
+		if (extra_grps) {
+			cpus_per_grp++;
+			--extra_grps;
+		}
+
+		/*
+		 * wrapping has to be considered given 'startgrp'
+		 * may start anywhere
+		 */
+		if (*curgrp >= last_grp)
+			*curgrp = 0;
+		grp_spread_init_one(&masks[*curgrp], nmsk, cpus_per_grp);
+	}
+}
+
+static int alloc_cluster_groups(unsigned int ncpus,
+				unsigned int ngroups,
+				struct cpumask *node_cpumask,
+				cpumask_var_t msk,
+				const struct cpumask ***clusters_ptr,
+				struct node_groups **cluster_groups_ptr)
+{
+	unsigned int ncluster = 0;
+	unsigned int cpu, nc, n;
+	const struct cpumask *cluster_mask;
+	const struct cpumask **clusters;
+	struct node_groups *cluster_groups;
+
+	cpumask_copy(msk, node_cpumask);
+
+	/* Probe how many clusters in this node. */
+	while (1) {
+		cpu = cpumask_first(msk);
+		if (cpu >= nr_cpu_ids)
+			break;
+
+		cluster_mask = topology_cluster_cpumask(cpu);
+		/* Clean out CPUs on the same cluster. */
+		cpumask_andnot(msk, msk, cluster_mask);
+		ncluster++;
+	}
+
+	/* If ngroups < ncluster, cross cluster is inevitable, skip. */
+	if (ncluster == 0 || ncluster > ngroups)
+		goto no_cluster;
+
+	/* Allocate memory based on cluster number. */
+	clusters = kcalloc(ncluster, sizeof(struct cpumask *), GFP_KERNEL);
+	if (!clusters)
+		goto no_cluster;
+	cluster_groups = kcalloc(ncluster, sizeof(struct node_groups), GFP_KERNEL);
+	if (!cluster_groups)
+		goto fail_cluster_groups;
+
+	/* Filling cluster info for later process. */
+	cpumask_copy(msk, node_cpumask);
+	for (n = 0; n < ncluster; n++) {
+		cpu = cpumask_first(msk);
+		cluster_mask = topology_cluster_cpumask(cpu);
+		nc = cpumask_weight_and(cluster_mask, node_cpumask);
+		clusters[n] = cluster_mask;
+		cluster_groups[n].id = n;
+		cluster_groups[n].ncpus = nc;
+		cpumask_andnot(msk, msk, cluster_mask);
+	}
+
+	alloc_groups_to_nodes(ngroups, ncpus, cluster_groups, ncluster);
+
+	*clusters_ptr = clusters;
+	*cluster_groups_ptr = cluster_groups;
+	return ncluster;
+
+ fail_cluster_groups:
+	kfree(clusters);
+ no_cluster:
+	return 0;
+}
+
+/*
+ * Try group CPUs evenly for cluster locality within a NUMA node.
+ *
+ * Return: true if success, false otherwise.
+ */
+static bool __try_group_cluster_cpus(unsigned int ncpus,
+				     unsigned int ngroups,
+				     struct cpumask *node_cpumask,
+				     struct cpumask *masks,
+				     unsigned int *curgrp,
+				     unsigned int last_grp)
+{
+	struct node_groups *cluster_groups;
+	const struct cpumask **clusters;
+	unsigned int ncluster;
+	bool ret = false;
+	cpumask_var_t nmsk;
+	unsigned int i, nc;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+		goto fail_nmsk_alloc;
+
+	ncluster = alloc_cluster_groups(ncpus, ngroups, node_cpumask, nmsk,
+					&clusters, &cluster_groups);
+
+	if (ncluster == 0)
+		goto fail_no_clusters;
+
+	for (i = 0; i < ncluster; i++) {
+		struct node_groups *nv = &cluster_groups[i];
+
+		/* Get the cpus on this cluster. */
+		cpumask_and(nmsk, node_cpumask, clusters[nv->id]);
+		nc = cpumask_weight(nmsk);
+		if (!nc)
+			continue;
+		WARN_ON_ONCE(nv->ngroups > nc);
+
+		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
+	}
+
+	ret = true;
+	kfree(cluster_groups);
+	kfree(clusters);
+ fail_no_clusters:
+	free_cpumask_var(nmsk);
+ fail_nmsk_alloc:
+	return ret;
+}
+
 static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 			       cpumask_var_t *node_to_cpumask,
 			       const struct cpumask *cpu_mask,
 			       struct cpumask *nmsk, struct cpumask *masks)
 {
-	unsigned int i, n, nodes, cpus_per_grp, extra_grps, done = 0;
+	unsigned int i, n, nodes, done = 0;
 	unsigned int last_grp = numgrps;
 	unsigned int curgrp = startgrp;
 	nodemask_t nodemsk = NODE_MASK_NONE;
@@ -287,7 +440,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 	alloc_nodes_groups(numgrps, node_to_cpumask, cpu_mask,
 			   nodemsk, nmsk, node_groups);
 	for (i = 0; i < nr_node_ids; i++) {
-		unsigned int ncpus, v;
+		unsigned int ncpus;
 		struct node_groups *nv = &node_groups[i];
 
 		if (nv->ngroups == UINT_MAX)
@@ -301,28 +454,14 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 
 		WARN_ON_ONCE(nv->ngroups > ncpus);
 
-		/* Account for rounding errors */
-		extra_grps = ncpus - nv->ngroups * (ncpus / nv->ngroups);
-
-		/* Spread allocated groups on CPUs of the current node */
-		for (v = 0; v < nv->ngroups; v++, curgrp++) {
-			cpus_per_grp = ncpus / nv->ngroups;
-
-			/* Account for extra groups to compensate rounding errors */
-			if (extra_grps) {
-				cpus_per_grp++;
-				--extra_grps;
-			}
-
-			/*
-			 * wrapping has to be considered given 'startgrp'
-			 * may start anywhere
-			 */
-			if (curgrp >= last_grp)
-				curgrp = 0;
-			grp_spread_init_one(&masks[curgrp], nmsk,
-						cpus_per_grp);
+		if (__try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
+					     masks, &curgrp, last_grp)) {
+			done += nv->ngroups;
+			continue;
 		}
+
+		assign_cpus_to_groups(ncpus, nmsk, nv, masks, &curgrp,
+				      last_grp);
 		done += nv->ngroups;
 	}
 	kfree(node_groups);
-- 
2.47.3



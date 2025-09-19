Return-Path: <linux-kernel+bounces-825045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B50B8ACBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE9B1C24997
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81407322A3F;
	Fri, 19 Sep 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFlDkCBA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB81322554
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303820; cv=none; b=I/Yprt7TsIpLHEP5ZLuImG76S1zozCVmUgQBcAv/JdBaI7dfj0U4XkhIeSefCYBKR2KPkF853LiLA+e9nAcAb3+cgQh8dCo1wTOX5pWJSzeI//I4JVBIj+SW+I/CPu/zlQQ5WNiZbFgon8HBD5CVSXR0yiyHeL0YKMzkUMj3xBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303820; c=relaxed/simple;
	bh=vtmbCaMrGpMhdFFHIMArqSiGZME1PQ1ZxZNPh5kLcEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2H3cNkZkEA+H7oyt1NkdpOJBJ5DYW5bl8QTqt8S06obUnIS4f8rFHWqamZHv/qVaLqqj+jZqzywdc+gUfE83wirjm087Kh0gWkKtm1r3RyoGz+dQqdM93+EGaafLoLtx7+uZCk3UrNW+rqWxNeDSlX3jSJhiFdZ4ToYkKZXDsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFlDkCBA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758303818; x=1789839818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vtmbCaMrGpMhdFFHIMArqSiGZME1PQ1ZxZNPh5kLcEM=;
  b=XFlDkCBAyZPtabGqgcIKa1HX8ZNKzOZ7mhCnlRgK43tFANiqda1Bl5CI
   cvlwIR+Y1Ya5TFdt51559cEBATTkRCqm0J5zJASM8AjR5+AfOLO+Rut4Y
   Iw0RxUxm886jPj9Z6pMC+MzbhJ89moyynCk4gyeLDCxDNSxHwiJ1i0HeN
   5pUr4wchlRt53w/fc/5ylwZ6nXaif6EUhGHhxE9i6exmTr6n9TrUxbH3l
   7vjH97IVWCPHwBI+PiN4g5f97fzanJdLYO/rl1CowtXJvQeigflgJXbj0
   WBmTia3AeNWvujHdYfOmd6adg5c2IgXxFC+Go5EmWkG7hHJKSgFtvrEja
   Q==;
X-CSE-ConnectionGUID: aY5xHx9oT/6jwjxwNYkoWQ==
X-CSE-MsgGUID: W7kKbkoyR8iIqyJB4JIt6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60769826"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60769826"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:43:38 -0700
X-CSE-ConnectionGUID: cXun3dPtQkCrn5LnwcB/kA==
X-CSE-MsgGUID: y8RytfXeSTOohFsfMIdf3w==
X-ExtLoop1: 1
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa003.fm.intel.com with ESMTP; 19 Sep 2025 10:43:38 -0700
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
Subject: [PATCH v4 2/2] sched/topology: Fix sched domain build error for GNR, CWF in SNC-3 mode
Date: Fri, 19 Sep 2025 10:50:12 -0700
Message-Id: <21bfb2fc7b69a4f2d19502de18357dc1ec9caa71.1758234869.git.tim.c.chen@linux.intel.com>
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

It is possible for Granite Rapids (GNR) and Clearwater Forest
(CWF) to have up to 3 dies per package. When sub-numa cluster (SNC-3)
is enabled, each die will become a separate NUMA node in the package
with different distances between dies within the same package.

For example, on GNR, we see the following numa distances for a 2 socket
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
0:   	10   15   17   21   28   26
1:   	15   10   15   23   26   23
2:   	17   15   10   26   23   21
3:   	21   28   26   10   15   17
4:   	23   26   23   15   10   15
5:   	26   23   21   17   15   10

The node distances above led to 2 problems:

1. Asymmetric routes taken between nodes in different packages led to
asymmetric scheduler domain perspective depending on which node you
are on.  Current scheduler code failed to build domains properly with
asymmetric distances.

2. Multiple remote distances to respective tiles on remote package create
too many levels of domain hierarchies grouping different nodes between
remote packages.

For example, the above GNR topology lead to NUMA domains below:

Sched domains from the perspective of a CPU in node 0, where the number
in bracket represent node number.

NUMA-level 1    [0,1] [2]
NUMA-level 2    [0,1,2] [3]
NUMA-level 3    [0,1,2,3] [5]
NUMA-level 4    [0,1,2,3,5] [4]

Sched domains from the perspective of a CPU in node 4
NUMA-level 1    [4] [3,5]
NUMA-level 2    [3,4,5] [0,2]
NUMA-level 3    [0,2,3,4,5] [1]

Scheduler group peers for load balancing from the perspective of CPU 0
and 4 are different.  Improper task could be chosen for load balancing
between groups such as [0,2,3,4,5] [1].  Ideally you should choose nodes
in 0 or 2 that are in same package as node 1 first.  But instead tasks
in the remote package node 3, 4, 5 could be chosen with an equal chance
and could lead to excessive remote package migrations and imbalance of
load between packages.  We should not group partial remote nodes and
local nodes together.
Simplify the remote distances for CWF and GNR for the purpose of
sched domains building, which maintains symmetry and leads to a more
reasonable load balance hierarchy.

The sched domains from the perspective of a CPU in node 0 NUMA-level 1
is now
NUMA-level 1    [0,1] [2]
NUMA-level 2    [0,1,2] [3,4,5]

The sched domains from the perspective of a CPU in node 4 NUMA-level 1
is now
NUMA-level 1    [4] [3,5]
NUMA-level 2    [3,4,5] [0,1,2]

We have the same balancing perspective from node 0 or node 4.  Loads are
now balanced equally between packages.

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 33e166f6ab12..d6b772990ec2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -515,6 +515,76 @@ static void __init build_sched_topology(void)
 	set_sched_topology(topology);
 }
 
+#ifdef CONFIG_NUMA
+static int sched_avg_remote_distance;
+static int avg_remote_numa_distance(void)
+{
+	int i, j;
+	int distance, nr_remote, total_distance;
+
+	if (sched_avg_remote_distance > 0)
+		return sched_avg_remote_distance;
+
+	nr_remote = 0;
+	total_distance = 0;
+	for_each_node_state(i, N_CPU) {
+		for_each_node_state(j, N_CPU) {
+			distance = node_distance(i, j);
+
+			if (distance >= REMOTE_DISTANCE) {
+				nr_remote++;
+				total_distance += distance;
+			}
+		}
+	}
+	if (nr_remote)
+		sched_avg_remote_distance = total_distance / nr_remote;
+	else
+		sched_avg_remote_distance = REMOTE_DISTANCE;
+
+	return sched_avg_remote_distance;
+}
+
+int arch_sched_node_distance(int from, int to)
+{
+	int d = node_distance(from, to);
+
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_GRANITERAPIDS_X:
+	case INTEL_ATOM_DARKMONT_X:
+
+		if (!x86_has_numa_in_package || topology_max_packages() == 1 ||
+		    d < REMOTE_DISTANCE)
+			return d;
+
+		/*
+		 * With SNC enabled, there could be too many levels of remote
+		 * NUMA node distances, creating NUMA domain levels
+		 * including local nodes and partial remote nodes.
+		 *
+		 * Trim finer distance tuning for NUMA nodes in remote package
+		 * for the purpose of building sched domains. Group NUMA nodes
+		 * in the remote package in the same sched group.
+		 * Simplify NUMA domains and avoid extra NUMA levels including
+		 * different remote NUMA nodes and local nodes.
+		 *
+		 * GNR and CWF don't expect systmes with more than 2 packages
+		 * and more than 2 hops between packages. Single average remote
+		 * distance won't be appropriate if there are more than 2
+		 * packages as average distance to different remote packages
+		 * could be different.
+		 */
+		WARN_ONCE(topology_max_packages() > 2,
+			  "sched: Expect only up to 2 packages for GNR or CWF, "
+			  "but saw %d packages when building sched domains.",
+			  topology_max_packages());
+
+		d = avg_remote_numa_distance();
+	}
+	return d;
+}
+#endif /* CONFIG_NUMA */
+
 void set_cpu_sibling_map(int cpu)
 {
 	bool has_smt = __max_threads_per_core > 1;
-- 
2.32.0



Return-Path: <linux-kernel+bounces-812677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB80B53B53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56F01CC43D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5DC369982;
	Thu, 11 Sep 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1l45Rkv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E036809B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615046; cv=none; b=SPfYCXjcxsBJjv27xcy9sHqSVHzuguvsrgOz6aFTgKamuCw6ZeLPEdrCB6cAY5PJrae825CBhjeUeohRFFeY06oqWhroAYgT5NsKVFX/HQ5SEPIJmAPTbZHsI7l4KkWQD/W8INQWaMEBC9oV2I3H6V3RQ9vZAWQeA2PVcuixe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615046; c=relaxed/simple;
	bh=V9BznF2Pb/TnOldcpMEp9IpbwXPfPKAjSWmMSHWv27U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TO5UGDKQCOcbn6+f+DfbIuT3YRtYRRsfVT7opv1SuFM/h+3P2xqZmdLD25BOsLRCibJVtsbGLpMAWL+mutGiJh+QtJMgoednxR7HutI8R5B1K2BPZYv0brHIU+2Dk6uf6KMzw0/EVSxwhTSe2DwucD6bevuQbviE2Xh7ZgkQF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1l45Rkv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757615045; x=1789151045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V9BznF2Pb/TnOldcpMEp9IpbwXPfPKAjSWmMSHWv27U=;
  b=H1l45RkvQ3/hxaEvCE+eerkrXXim8W25ji3KGfjQFF3SDsTX/O1WTd8p
   qrdAe6QnHk6c7j+SFkYRIidg1CTYH60Wg5vJ6JLXehlcv+myehztRJiUa
   ZYQOA9CCmi79DXYzFD8SJUgXqKpmXMtBEC8AADimEV8LNwuoIJKzC/miF
   /797E2rvnbqCj/nbLLbAaap/9RaYvJpzGfrNmoNWl04XqIWN2qJgz9BTR
   XVGYPuKZWDrZ8U+0R7m4VId1r+AWWhy5hh1SFtRckaOgLpvrEoFEMEogz
   lLDJEIVLTY4YnFL0maysZyeqbDvfq6VNYCO83R8yL/bo3WeIv3pdKA8Rq
   g==;
X-CSE-ConnectionGUID: 3K7g4pjpTr6kjOvMI92d3A==
X-CSE-MsgGUID: 9+HCiur+RDu731bbCmeJFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="77413648"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="77413648"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 11:24:04 -0700
X-CSE-ConnectionGUID: 2OkQa8MRTZqXV8QROiQoVw==
X-CSE-MsgGUID: Dbhzcl7CSyOmme73+bc4Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="173058313"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2025 11:24:04 -0700
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
Subject: [PATCH v3 2/2] sched: Fix sched domain build error for GNR, CWF in SNC-3 mode
Date: Thu, 11 Sep 2025 11:30:57 -0700
Message-Id: <208a0a8278a28521e7bbc5114cf9899d31875d15.1757614784.git.tim.c.chen@linux.intel.com>
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

For example, the above GNR-X topology lead to NUMA domains below:

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
Simplify the remote distances for CWF-X and GNR-X for the purpose of
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
 arch/x86/kernel/smpboot.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 33e166f6ab12..3f894c525e49 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -515,6 +515,34 @@ static void __init build_sched_topology(void)
 	set_sched_topology(topology);
 }
 
+int arch_sched_node_distance(int from, int to)
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
+		 * for the purpose of building sched domains.  Put NUMA nodes
+		 * in each remote package in the same sched group.
+		 * Simplify NUMA domains and avoid extra NUMA levels including
+		 * different NUMA nodes in remote packages.
+		 *
+		 * GNR and CWF don't expect systmes with more than 2 packages
+		 * and more than 2 hops between packages.
+		 */
+		d = sched_avg_remote_numa_distance;
+	}
+	return d;
+}
+
 void set_cpu_sibling_map(int cpu)
 {
 	bool has_smt = __max_threads_per_core > 1;
-- 
2.32.0



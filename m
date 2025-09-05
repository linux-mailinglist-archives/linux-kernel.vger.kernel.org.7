Return-Path: <linux-kernel+bounces-803551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4B7B46240
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E511B227F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573C27467F;
	Fri,  5 Sep 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbqpgLIz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C3267B12
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096972; cv=none; b=IrrLnbYtCsFjzvr+uPcHVOTRsgmood+mqWdHFt7aFH7dEPVKQMJZyMzipKdOIX/BCsSOIVjla877djaZcDI728vrau43/cVO0qKn8TFW6KvxnWUBAhXK52LAqxqOUBMqzrmMq2ZXlp33xIu65NNHYODvNbTz1MsRbA7daAAVPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096972; c=relaxed/simple;
	bh=TJrjwblla40PWTt/UlYDXqgDomVS+SIW/Cz0hqOAefE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYI9ZvS03RpD8KAN7e+tXkOwZZx51nf5QPGZg7r0RnDSL273T3vRgIQvQm0o92rpzCVLuL//09cymhG+i2jqZSMaor8zotJgBrxRS2eJy3On9k2kqemROB6RiHWju15GPgXareYQ7WCKAKddm5PxTAm43eJXoQz5fOIDWGPAFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbqpgLIz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757096970; x=1788632970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TJrjwblla40PWTt/UlYDXqgDomVS+SIW/Cz0hqOAefE=;
  b=lbqpgLIzAkFKCA7jTGnnN0SoQMpqNJtMPdYiNlN+2QDSZ8zKuqQiunUU
   r4B9PvPx8mXGaPEX5fyj+jJcZl9RoIIYoCNEgETRZaifyA62WmzFdoZ7w
   pg631WKCMrP6SWWDSc24cCxwjuWBAm6TCSNXiFPGb0bsh3TzphAL+9D+7
   St8WAaNKFoQ5Ub2qhJ867yG7TnDgWuxpfFt0NzztwacyPkvtF0/utDmq5
   00ws1peY0m6Yi0O5pxmbqwKpL+Bc07fmGYDDFclg+hAfsuil4dMt6Gs6h
   Az5uCybhKZzTobVwTcdGH4ckvN5iEaZG1t2JVpvTsIg46yYd8H6k+iTfL
   g==;
X-CSE-ConnectionGUID: OuoHYQxaQAaals0Yi3DnyQ==
X-CSE-MsgGUID: 394Yhc12SYWTZI3DhZWmLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="63281091"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="63281091"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 11:29:30 -0700
X-CSE-ConnectionGUID: 0/972cx1QnW11umyYLM+7A==
X-CSE-MsgGUID: 2waXvBh0QWCWpCUNPH/6ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="177456544"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa005.jf.intel.com with ESMTP; 05 Sep 2025 11:29:30 -0700
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
Subject: [PATCH v2 2/2] sched: Fix sched domain build error for GNR, CWF in SNC-3 mode
Date: Fri,  5 Sep 2025 11:36:25 -0700
Message-Id: <7cf61ac1dbe665bac68bfee344f2eb2906915fd7.1757097030.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1757097030.git.tim.c.chen@linux.intel.com>
References: <cover.1757097030.git.tim.c.chen@linux.intel.com>
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

For example, on GNR, we see the following NUMA distances for a 2 socket
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



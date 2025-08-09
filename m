Return-Path: <linux-kernel+bounces-760957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D891B1F246
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D278189CC08
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4812777E1;
	Sat,  9 Aug 2025 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkaLairD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEB275872
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716461; cv=none; b=IojQ3o0319gniGMl43HTVAIglRucNSyn6f7mIZ2sA6nGcNZlUGEZWY6057tDsNZ4vk1O+nB32WSiImkG1cA4P3bSQwXMpAQf17p3nQR/jrpVdHP7V0+mJDJgG2Sf7l8Ti7krqUFqfX2pqdYZqFCdot+k/yWtmOk0EJDIuVmMV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716461; c=relaxed/simple;
	bh=vn8SQoDAOd07cpCKj326vCb8D/qCqZCs9BwVgi4KoVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMXTmQv0twXoDtxt8UL0eicbBf9o7Tfv//e1wCHtE99sZhtB/nIU8wVaymmbbfxF6XMzVWor4WdG/qxhSD/wWJ4vwz9cuiTjtjsAycEcLvPhT9aUF3kUVc4kwE6SAX+4OTFtFFHuRXxnq1R/3zLjD9SIRWfAHwReiV3b07cgCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkaLairD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716461; x=1786252461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vn8SQoDAOd07cpCKj326vCb8D/qCqZCs9BwVgi4KoVg=;
  b=nkaLairDDjkysNs4UHTZ5xKHewoxOhkUNj9VyNX4tbdn4A+qnsAVwMle
   R5heWKuCY8Flip8hzeFiNi/CFABQw9zu7obpiMTotWoXuYrKrGBh3HoZh
   lmLG5GkRobIJvrI3ad/N+LP8GAWOX5LCCD9ciXh9NpYENpuy7gVq79Rno
   lOPq4XCXPVEuiMBh+0Se3GxDjUG9K2DZWlyzewIOPzwn2XZvGRXdUZ3Ot
   w3MIJHSIsVA80TETVQPqTJE71E/W3dHyU/Fc9CdibOzm0oeRAQl7UFWIV
   RWX9ArTsi+Tp+Wc1c8CtMey1/OwsGiNy5hIgFduA1bpZq8LLDwe4VQMBf
   g==;
X-CSE-ConnectionGUID: Uof0EABPSOGTbrf//bNl/A==
X-CSE-MsgGUID: G6Abi0pKRMKI/T1SAuVRiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60860044"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60860044"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:14:20 -0700
X-CSE-ConnectionGUID: Y7bYuOZeSdOfQBAqGM3CtQ==
X-CSE-MsgGUID: edOp5vWRTYOveGm/1PiD4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="169693142"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa003.jf.intel.com with ESMTP; 08 Aug 2025 22:14:14 -0700
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
Subject: [RFC PATCH v4 23/28] sched: Scan a task's preferred node for preferred LLC
Date: Sat,  9 Aug 2025 13:08:11 +0800
Message-Id: <178bf43d7cbc9b2c9aea408dd56b87391067df37.1754712565.git.tim.c.chen@linux.intel.com>
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

When sched_cache is enabled, fully scanning all online
CPUs to find the hottest one is very costly. As a first
step, limit the scan to only the CPUs within the task's
preferred node. If the node containing the task's preferred
LLC is not in the CPU scan mask, add it. Additionally, if
the node where the current task is running is not in the
scan mask, add it too.

Suggested-by: Jianyong Wu <jianyong.wu@outlook.com>
Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 64f757ad39fc..420d3a080990 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1390,13 +1390,36 @@ static void task_tick_cache(struct rq *rq, struct task_struct *p)
 	}
 }
 
+static void get_scan_cpumasks(cpumask_var_t cpus, int cache_cpu,
+			      int pref_nid, int curr_cpu)
+{
+#ifdef CONFIG_NUMA_BALANCING
+	/* first honor the task's preferred node */
+	if (pref_nid != NUMA_NO_NODE)
+		cpumask_or(cpus, cpus, cpumask_of_node(pref_nid));
+#endif
+
+	/* secondly honor the task's cache CPU if it is not included */
+	if (cache_cpu != -1 && !cpumask_test_cpu(cache_cpu, cpus))
+		cpumask_or(cpus, cpus,
+			   cpumask_of_node(cpu_to_node(cache_cpu)));
+
+	/*
+	 * Thirdly honor the task's current running node
+	 * as the last resort.
+	 */
+	if (!cpumask_test_cpu(curr_cpu, cpus))
+		cpumask_or(cpus, cpus, cpumask_of_node(cpu_to_node(curr_cpu)));
+}
+
 static void __no_profile task_cache_work(struct callback_head *work)
 {
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
 	unsigned long m_a_occ = 0;
 	unsigned long last_m_a_occ = 0;
-	int cpu, m_a_cpu = -1;
+	int cpu, m_a_cpu = -1, cache_cpu,
+	    pref_nid = NUMA_NO_NODE, curr_cpu = smp_processor_id();
 	cpumask_var_t cpus;
 
 	WARN_ON_ONCE(work != &p->cache_work);
@@ -1406,11 +1429,18 @@ static void __no_profile task_cache_work(struct callback_head *work)
 	if (p->flags & PF_EXITING)
 		return;
 
-	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
 		return;
 
+	cache_cpu = mm->mm_sched_cpu;
+#ifdef CONFIG_NUMA_BALANCING
+	if (static_branch_likely(&sched_numa_balancing))
+		pref_nid = p->numa_preferred_nid;
+#endif
+
 	scoped_guard (cpus_read_lock) {
-		cpumask_copy(cpus, cpu_online_mask);
+		get_scan_cpumasks(cpus, cache_cpu,
+				  pref_nid, curr_cpu);
 
 		for_each_cpu(cpu, cpus) {
 			/* XXX sched_cluster_active */
-- 
2.25.1



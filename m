Return-Path: <linux-kernel+bounces-849248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FCFBCFAA8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E419B189A5A7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8552882A6;
	Sat, 11 Oct 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEVJOxO1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5F28642E
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206712; cv=none; b=CcfwsAyp1OHHqY4mNPYPcN6bUrl09ci4+a/v8FtP9azgYQzfS6lmRwWajeweUonIlhrYSa3k3Uk+3iau8s00TJMHIq9pc69gZThbuJO24GmjHBtcGot6LsPzytIaUPaB8oNg5fj064BJxFXz948iENpfk/rfsglOKxpcJkX9wG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206712; c=relaxed/simple;
	bh=y1sB/ng56N+mvnxojmgS/eclR6zFHdcgY5tqVpcDUNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ScMEWl2DOAQMR5u9bpXgwKEadirbrSNG1X0vBv1Qm5M7qzeQRW6zyzR/0wZ49Stn9ftQ28uc0NLCvRH6mwbydhKFD3kpg3JgxWk9NBUU+Qnt+t7g3WQ/pDx7wFSEDUiofgdlic68Cqje1J43vJo7n57s1boIMbDvvtchvPGoTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEVJOxO1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206711; x=1791742711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y1sB/ng56N+mvnxojmgS/eclR6zFHdcgY5tqVpcDUNQ=;
  b=WEVJOxO1Uy4x+GEHukYgK7cjQhJ+ZPzArevJFx6r0uwjLvVHXCsCVf0d
   U5oZ9qGbRNsQ961+swsJygnl0Xp69gaKKJFDcVvaKlw28OYtLWeCcKxy5
   4DN0Azrktm8AXYGwp3idVSw3VynSmNbW2dqVmCfWn3Np2iYv1w7hTpRfb
   SetW2PMNCXc4Fk5w1ve3GEJ9Bax25e3mUvpabN2XIbAEnlZu4rHyR3ovD
   1WzBrpK45tvGmB0FKRXCfsKbMFF1KdXCgjW4lAJ2KU2k2bhxv6SPWDjA8
   0qVm8erW2mgP7HqJHVa71uZn8ehzzZAPeMVO4wyBDdQns/j8tkr67uAC6
   w==;
X-CSE-ConnectionGUID: osVAgR9XSEi43ydURnxquA==
X-CSE-MsgGUID: sgSrXMaOTSCJRnEynSu6Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339827"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339827"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:30 -0700
X-CSE-ConnectionGUID: U/XiMYdrQLyr4smIn6sKwQ==
X-CSE-MsgGUID: iE4re5OqR+eOwHWBOdmfKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487233"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:29 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
	Aubrey Li <aubrey.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] sched/fair: Add migrate_llc_task migration type for cache-aware balancing
Date: Sat, 11 Oct 2025 11:24:49 -0700
Message-Id: <f22827867d2c245c00063a3fa9f2aeddddaacca1.1760206683.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1760206683.git.tim.c.chen@linux.intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new migration type, migrate_llc_task, to support
cache-aware load balancing.

After identifying the busiest sched_group (having the most tasks
preferring the destination LLC), mark migrations with this type.
During load balancing, each runqueue in the busiest sched_group is
examined, and the runqueue with the highest number of tasks preferring
the destination CPU is selected as the busiest runqueue.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8469ec528cb1..bec6354d7841 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9504,7 +9504,8 @@ enum migration_type {
 	migrate_load = 0,
 	migrate_util,
 	migrate_task,
-	migrate_misfit
+	migrate_misfit,
+	migrate_llc_task
 };
 
 #define LBF_ALL_PINNED	0x01
@@ -10082,6 +10083,10 @@ static int detach_tasks(struct lb_env *env)
 			env->imbalance -= util;
 			break;
 
+		case migrate_llc_task:
+			env->imbalance--;
+			break;
+
 		case migrate_task:
 			env->imbalance--;
 			break;
@@ -11733,6 +11738,15 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		return;
 	}
 
+#ifdef CONFIG_SCHED_CACHE
+	if (busiest->group_llc_balance) {
+		/* Move a task that prefer local LLC */
+		env->migration_type = migrate_llc_task;
+		env->imbalance = 1;
+		return;
+	}
+#endif
+
 	if (busiest->group_type == group_imbalanced) {
 		/*
 		 * In the group_imb case we cannot rely on group-wide averages
@@ -12041,6 +12055,10 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 	struct rq *busiest = NULL, *rq;
 	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
 	unsigned int busiest_nr = 0;
+#ifdef CONFIG_SCHED_CACHE
+	unsigned int busiest_pref_llc = 0;
+	int dst_llc;
+#endif
 	int i;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
@@ -12149,6 +12167,16 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 			}
 			break;
 
+		case migrate_llc_task:
+#ifdef CONFIG_SCHED_CACHE
+			dst_llc = llc_idx(env->dst_cpu);
+			if (!cpus_share_cache(env->dst_cpu, rq->cpu) &&
+			    busiest_pref_llc < rq->nr_pref_llc[dst_llc]) {
+				busiest_pref_llc = rq->nr_pref_llc[dst_llc];
+				busiest = rq;
+			}
+#endif
+			break;
 		case migrate_task:
 			if (busiest_nr < nr_running) {
 				busiest_nr = nr_running;
@@ -12331,6 +12359,8 @@ static void update_lb_imbalance_stat(struct lb_env *env, struct sched_domain *sd
 	case migrate_misfit:
 		__schedstat_add(sd->lb_imbalance_misfit[idle], env->imbalance);
 		break;
+	case migrate_llc_task:
+		break;
 	}
 }
 
-- 
2.32.0



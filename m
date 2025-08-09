Return-Path: <linux-kernel+bounces-760952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59521B1F241
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E086D7A1A29
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A652749D5;
	Sat,  9 Aug 2025 05:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNX9P8Zh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D46274B39
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716401; cv=none; b=gwUxPhraVHLm64bXQSb1oNwdX318HEEFGQP3NJIRjG0ej1HembqLwL/AMdMnKs2idXx3KEfcQggsIlJeGxPd86ymVhFs/rlGwCRgO+oHKZRTtPkeotIYE6Skr2Z90a1CPa/LNaWTM1XdHnwRmA1ybF/xRMbrR1KLLpNUD058xfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716401; c=relaxed/simple;
	bh=s+rR7wC7UnAbjuxbPj5c6/L98TvboEiREJprAaugmo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ex3plSrAdkKiiWgy1wFo/qOyi1KRMrAmvUSGgR+Sl7c+uHNitZ3FkYOzLvNN2Kk7bcRKDLWQu/zjHkM0B/ktpD3735kBxpJu0PJ8IZ58b18B0w/r7VUcJthi/o2hdqN358rDx5jLpz4Z9VU9UsOwUlIB1nTwdFObyEGsDbo1DD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNX9P8Zh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716400; x=1786252400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+rR7wC7UnAbjuxbPj5c6/L98TvboEiREJprAaugmo8=;
  b=ZNX9P8Zhh4or6QRvyIGlsqU0K0XXUdzdv+gCoKT4EcsJWyPrUrrpjeh6
   Qmj8TTDc2Q3+gYj6uSTMIaEUdV5BvlkAcN9NnwrPfjzZslpxwRyFTPJTx
   KtvP4Sp2C8p5ushx8yObLd6nOXcFZSnue19p3r5NoF227rlrE4GYeUWKq
   dM+U0/Nq/0qZLmHe33WFqOXqLI4gmE0PevCwc5pjj8qUenPxHW1kXvWF+
   3fvMGqOlhGBBzPmI9Nt4so8fHdQ0chc/atY+kOpU5fgp8EHxTRIRoH0Lz
   6bGZ08Lr6XkBPeiz62J27S7cC3PWHkwpEOh1gP4JN0l7CxroHUJGaT1Ve
   g==;
X-CSE-ConnectionGUID: b1FzoNUSROqCeN8PP7hLeA==
X-CSE-MsgGUID: PpjmRF1hSJmGHpUlPRMqJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56768565"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56768565"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:13:19 -0700
X-CSE-ConnectionGUID: TVpwBJFnSOm4LFGDl/UL7A==
X-CSE-MsgGUID: vYNYzwHuTSmQtfe59f1VcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="189180352"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa002.fm.intel.com with ESMTP; 08 Aug 2025 22:13:13 -0700
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
Subject: [RFC PATCH v4 18/28] sched: Do not migrate task if it is moving out of its preferred LLC
Date: Sat,  9 Aug 2025 13:07:10 +0800
Message-Id: <081010e2c9cd8f4b3c9aa6d1b98fbe9438cd3c06.1754712565.git.tim.c.chen@linux.intel.com>
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

From: Tim Chen <tim.c.chen@linux.intel.com>

In the final step of task migration during load balancing,
can_migrate_task() is used to determine whether a task can
be moved to the destination. If the task has an LLC preference,
consider this preference when moving it out of its preferred LLC.
With this check in place, there is no need to retain the task's
cache-hot CPU check in task_hot(); remove it accordingly.

Besides, add more checks in detach_tasks() to avoid choosing
tasks that prefer their current LLC.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8d5792b9e658..22b7a7fe538e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9822,17 +9822,6 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	if (sysctl_sched_migration_cost == 0)
 		return 0;
 
-#ifdef CONFIG_SCHED_CACHE
-	if (sched_feat(SCHED_CACHE) && p->mm && p->mm->pcpu_sched) {
-		/*
-		 * XXX things like Skylake have non-inclusive L3 and might not
-		 * like this L3 centric view. What to do about L2 stickyness ?
-		 */
-		return per_cpu_ptr(p->mm->pcpu_sched, env->src_cpu)->occ >
-		       per_cpu_ptr(p->mm->pcpu_sched, env->dst_cpu)->occ;
-	}
-#endif
-
 	delta = rq_clock_task(env->src_rq) - p->se.exec_start;
 
 	return delta < (s64)sysctl_sched_migration_cost;
@@ -10029,6 +10018,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (env->flags & LBF_ACTIVE_LB)
 		return 1;
 
+#ifdef CONFIG_SCHED_CACHE
+	if (sched_feat(SCHED_CACHE) &&
+	    get_migrate_hint(env->src_cpu, env->dst_cpu, p) == mig_forbid)
+		return 0;
+#endif
+
 	degrades = migrate_degrades_locality(p, env);
 	if (!degrades)
 		hot = task_hot(p, env);
@@ -10289,6 +10284,17 @@ static int detach_tasks(struct lb_env *env)
 		if (env->imbalance <= 0)
 			break;
 
+#ifdef CONFIG_SCHED_CACHE
+		/*
+		 * Don't detach more tasks if remaining tasks want to stay:
+		 * The tasks have already been sorted by order_tasks_by_llc(),
+		 * they are tasks that prefer the current LLC.
+		 */
+		if (sched_feat(SCHED_CACHE) && p->preferred_llc != -1 &&
+		    llc_id(env->src_cpu) == p->preferred_llc)
+			break;
+#endif
+
 		continue;
 next:
 		if (p->sched_task_hot)
-- 
2.25.1



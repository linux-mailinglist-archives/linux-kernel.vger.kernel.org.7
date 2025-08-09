Return-Path: <linux-kernel+bounces-760950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10556B1F23F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24071896E1A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56F262FE7;
	Sat,  9 Aug 2025 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DO7eB20K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82CABA36
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716375; cv=none; b=aS7CLs0yVWKaF6OGVkXK8ZAgy8yUgUakdznwWDtZD4N9gQ9eA7tWRxrHj1IeAjaqTL8M+VmHHPvI8FEcOuDBcfH3oVpULXvb4/xFnoBCpg/mVg6MCRCvDJrLWdumxn7wi15V2NyagC2GII5gOWOj3odj3IWvyB3Ywa1aJoBDB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716375; c=relaxed/simple;
	bh=fRnw1t3Rh9UYvT00ArjMcNIiB37mwFZbA2eVDMCUX9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RJUo8ambmNBfq+wvLRlOCmiE/W7wpbkuJF7yL9JEQZ65V62F8oCjVmz3qVgLvkV3PLO6TzjT6umm4UV9UMY1fHNephBb+kWs8mVMmZ6rPjQkthPxxV8sRM5GBZAKF/4w8+2Bp7vO3sUeIwn+6xlZ35XOq6ECCeBWwM5GJsRHcEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DO7eB20K; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716374; x=1786252374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fRnw1t3Rh9UYvT00ArjMcNIiB37mwFZbA2eVDMCUX9M=;
  b=DO7eB20K/f/MVe9m5JNfhy4n46O8ccIoioHjrTsbuwZlLpqzzksjVlAv
   FSWzb4JVfyBHYiQaKCDVfK0CkNncYJ22CpRHB1RwD3zGRfwsq6x9aCRQH
   TKpWNRyQsj3e8nZiDG6U1hLeWNbIKj/X6uKv56QKiYVXkZeKHyR4Zqnxi
   U5rknviHlsICE9lsjONRBpod6oRa32YfBF17V6dJ4X6Vo8cglEVlG/FKh
   aqYrgjA98DE4rWoYD97vabGK2LMtYuZO47cKW4wuRsI+yu4gtqm55Wgcy
   1wWRnlj7aVuWb9SYbQgGx83xtwUCYP9X9i36gO7Eb2NFdoWyrm8YyDqHa
   g==;
X-CSE-ConnectionGUID: 0oJuosNIQM23ggPBmbF4UQ==
X-CSE-MsgGUID: LCnyHPYNSYquGLfPEsgHmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56932555"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56932555"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:12:53 -0700
X-CSE-ConnectionGUID: 0pVJsl26T9OrBTO7kMP8BQ==
X-CSE-MsgGUID: o19YVeMBQCulANK7Q6DXLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="164703753"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa006.jf.intel.com with ESMTP; 08 Aug 2025 22:12:47 -0700
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
Subject: [RFC PATCH v4 16/28] sched: Consider LLC locality for active balance
Date: Sat,  9 Aug 2025 13:06:42 +0800
Message-Id: <38d036cf946223b46a20ad60ccf13f9dcb316240.1754712565.git.tim.c.chen@linux.intel.com>
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

If busiest run queue has only one task, active balance is enlisted
to actually move the task.  However, before moving the task,
we should consider whether we are moving the task from its preferred
LLC.

Don't move the single running task in a run queue to another LLC, if
we are moving it from its desired LLC, or moving it will cause too much
imbalance between the LLCs.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 51 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a301b56dd2b4..592a4034e760 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12332,10 +12332,43 @@ imbalanced_active_balance(struct lb_env *env)
 	return 0;
 }
 
+#ifdef CONFIG_SCHED_CACHE
+static inline bool
+break_llc_locality(struct lb_env *env)
+{
+	if (!sched_feat(SCHED_CACHE))
+		return 0;
+
+	if (cpus_share_cache(env->src_cpu, env->dst_cpu))
+		return 0;
+	/*
+	 * All tasks want to stay put. Move only if LLC is
+	 * heavily loaded or don't pull a task from its
+	 * preferred CPU if it is the only one running.
+	 */
+	if (env->src_rq->nr_pref_llc_running == env->src_rq->cfs.h_nr_runnable &&
+	    (env->src_rq->nr_running <= 1 ||
+	    _get_migrate_hint(env->src_cpu, env->dst_cpu,
+			      0, false) == mig_forbid))
+		return 1;
+
+	return 0;
+}
+#else
+static inline bool
+break_llc_locality(struct lb_env *env)
+{
+	return 0;
+}
+#endif
+
 static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
+	if (break_llc_locality(env))
+		return 0;
+
 	if (asym_active_balance(env))
 		return 1;
 
@@ -12355,7 +12388,8 @@ static int need_active_balance(struct lb_env *env)
 			return 1;
 	}
 
-	if (env->migration_type == migrate_misfit)
+	if (env->migration_type == migrate_misfit ||
+	    env->migration_type == migrate_llc_task)
 		return 1;
 
 	return 0;
@@ -12800,9 +12834,20 @@ static int active_load_balance_cpu_stop(void *data)
 		goto out_unlock;
 
 	/* Is there any task to move? */
-	if (busiest_rq->nr_running <= 1)
-		goto out_unlock;
+	if (busiest_rq->nr_running <= 1) {
+#ifdef CONFIG_SCHED_CACHE
+		int llc = llc_idx(target_cpu);
 
+		if (!sched_feat(SCHED_CACHE))
+			goto out_unlock;
+
+		if (llc < 0)
+			goto out_unlock;
+		/* don't migrate if task does not prefer target */
+		if (busiest_rq->nr_pref_llc[llc] < 1)
+#endif
+			goto out_unlock;
+	}
 	/*
 	 * This condition is "impossible", if it occurs
 	 * we need to fix it. Originally reported by
-- 
2.25.1



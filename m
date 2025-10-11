Return-Path: <linux-kernel+bounces-849250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D28BCFAB1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B0A34E9FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2CA289E08;
	Sat, 11 Oct 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3CAEs3w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D42874EA
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206714; cv=none; b=P5dnBcm/QdLKKHwOdHn/8WuPNdfAOl/PRiR2K2uOEI4cNFkN+3QA9gv1poGLydzEv/LcejqEay5DpC4q4pFVQXAYgNISmcWGnnkZt2WJ1RNwtLhNEUFXZhx40ubXDsBOhhphD04ToZpipNp3wabmP7EXcOk+GqqMg1ATyjn68eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206714; c=relaxed/simple;
	bh=7mAc5fCb/Yw4KmiNv5+1hXXuEie+xn7lqzFvEVfM5lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4DMRiSFceKlJzje7FYPpzQtMciS8INZnGsYmfTeHw6oUtErbWyqEJzurxfkaj/0e2BYrqNZ34Rdy0dGMjqeQWLbOVlQosaArztC6x5+Kes0uifkkB7Pj+Ot9ll7+ydHo4UrJOvNc7oKS/beZOgPG9FPfh7UCSuuvvMEgE2IUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3CAEs3w; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206712; x=1791742712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mAc5fCb/Yw4KmiNv5+1hXXuEie+xn7lqzFvEVfM5lI=;
  b=H3CAEs3wXo6bis/3Dkhtptw+Q7vtaAFDMqK8g5XXqpoTWnnoOviYRAT9
   w6Ikfty6wJNr1MlZJ1pp/FTRrzxJpmwm8JYX2yaBiDeoJDyx/agfVsZPY
   MklgYKNASSHcEaoYoXP3gsqWfSwXldul6nD1Cye5tqr86XkWjK3gJK3C2
   XHWF6ABgRrpsZ6WaBAuzrKten6FRqGkbA1i+aWIRwXqoWsGPVsgAC8AT4
   v51P3tS4APRavdFpCNPn2xNzJPdUZAW7dgqXMB0AkpdRadIZ72DIu+BFu
   J9oJpUAr+gFfhWThceV6xrW/Bi4Emncs3GIHURfaahEgiLmzNa/UX2/Km
   w==;
X-CSE-ConnectionGUID: L4/6SpgURcKa2MOypuG0Tw==
X-CSE-MsgGUID: s8jp3cejRyWqoo8mO6QU6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339866"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339866"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:32 -0700
X-CSE-ConnectionGUID: IV2+5+btQ3GmLWn4UVfGIA==
X-CSE-MsgGUID: Ti8qIpzsSjywiCl630piRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487243"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:31 -0700
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
Subject: [PATCH 14/19] sched/fair: Consider LLC preference when selecting tasks for load balancing
Date: Sat, 11 Oct 2025 11:24:51 -0700
Message-Id: <26e7bfa88163e13ba1ebefbb54ecf5f42d84f884.1760206683.git.tim.c.chen@linux.intel.com>
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

Currently, task selection from the busiest runqueue ignores LLC
preferences. Reorder tasks in the busiest queue to prioritize selection
as follows:

  1. Tasks preferring the destination CPU's LLC
  2. Tasks with no LLC preference
  3. Tasks preferring an LLC different from their current one
  4. Tasks preferring the LLC they are currently on

This improves the likelihood that tasks are migrated to their
preferred LLC.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 66 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19ba9c1b9a63..0fafbfedb21d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10036,6 +10036,68 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 	return NULL;
 }
 
+#ifdef CONFIG_SCHED_CACHE
+/*
+ * Prepare lists to detach tasks in the following order:
+ * 1. tasks that prefer dst cpu's LLC
+ * 2. tasks that have no preference in LLC
+ * 3. tasks that prefer LLC other than the ones they are on
+ * 4. tasks that prefer the LLC that they are currently on.
+ */
+static struct list_head
+*order_tasks_by_llc(struct lb_env *env, struct list_head *tasks)
+{
+	struct task_struct *p;
+	LIST_HEAD(pref_old_llc);
+	LIST_HEAD(pref_new_llc);
+	LIST_HEAD(no_pref_llc);
+	LIST_HEAD(pref_other_llc);
+
+	if (!sched_cache_enabled())
+		return tasks;
+
+	if (cpus_share_cache(env->dst_cpu, env->src_cpu))
+		return tasks;
+
+	while (!list_empty(tasks)) {
+		p = list_last_entry(tasks, struct task_struct, se.group_node);
+
+		if (p->preferred_llc == llc_id(env->dst_cpu)) {
+			list_move(&p->se.group_node, &pref_new_llc);
+			continue;
+		}
+
+		if (p->preferred_llc == llc_id(env->src_cpu)) {
+			list_move(&p->se.group_node, &pref_old_llc);
+			continue;
+		}
+
+		if (p->preferred_llc == -1) {
+			list_move(&p->se.group_node, &no_pref_llc);
+			continue;
+		}
+
+		list_move(&p->se.group_node, &pref_other_llc);
+	}
+
+	/*
+	 * We detach tasks from list tail in detach tasks.  Put tasks
+	 * to be chosen first at end of list.
+	 */
+	list_splice(&pref_new_llc, tasks);
+	list_splice(&no_pref_llc, tasks);
+	list_splice(&pref_other_llc, tasks);
+	list_splice(&pref_old_llc, tasks);
+	return tasks;
+}
+#else
+static inline struct list_head
+*order_tasks_by_llc(struct lb_env *env, struct list_head *tasks)
+{
+	return tasks;
+}
+#endif
+
 /*
  * detach_tasks() -- tries to detach up to imbalance load/util/tasks from
  * busiest_rq, as part of a balancing operation within domain "sd".
@@ -10044,7 +10106,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
  */
 static int detach_tasks(struct lb_env *env)
 {
-	struct list_head *tasks = &env->src_rq->cfs_tasks;
+	struct list_head *tasks;
 	unsigned long util, load;
 	struct task_struct *p;
 	int detached = 0;
@@ -10063,6 +10125,8 @@ static int detach_tasks(struct lb_env *env)
 	if (env->imbalance <= 0)
 		return 0;
 
+	tasks = order_tasks_by_llc(env, &env->src_rq->cfs_tasks);
+
 	while (!list_empty(tasks)) {
 		/*
 		 * We don't want to steal all, otherwise we may be treated likewise,
-- 
2.32.0



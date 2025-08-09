Return-Path: <linux-kernel+bounces-760951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A8B1F240
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07147267C7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656AF274B39;
	Sat,  9 Aug 2025 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3ntFCoX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58996226CFC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716388; cv=none; b=ToNlzHkLLYiYeK8T8BsAhwwVTQMjfVDgwARwIDYa+wyZ8Eu38JHaFmFWhEHDz8Y4QXb3R7dulNjX2NJYnlkPmQ0FB+POvt2GUZ/4GvwbMKz42XqpgP66/Git+tq6B67e0BFqrfwmVgwWN0fqYa7Y2mT9Jw28QbyFm7zODtPY6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716388; c=relaxed/simple;
	bh=sTSG237di6kHrTi+M/LVG5ENiqilE30WO0gE5TPh2Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k07/zqOO54KVW2SXRP1BcFCx9O6eoCI0J3Yg2JN4fa4l56WOxmJSEvLVg2Qq4TaVlBV1mD6qAvItCmcERw1UNU4TYSdIrJB+dIamh6hR7WzT6I/vQu1VEkz4aED2Kp/nidg5cbmW5fT2HqFSYZjL/i79XRYjNuUmf9W31GhMzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3ntFCoX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716387; x=1786252387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sTSG237di6kHrTi+M/LVG5ENiqilE30WO0gE5TPh2Qg=;
  b=G3ntFCoXyBZCYeCFd2XdSpKtKywszwsAL7iG155Ga7pmma4DufkDAk1j
   J0oIixy6CX3G2NDetf51jJCmgOaHTwM5/Zyy62tX553kTkCWxQYisiVUg
   1tLtppV/kH9sI0k6oKldvrjqqgkVdJpDQWrsW6zAURpZZQre0+t9sB2DH
   giDN1ULvFcnaQhebg6L8k2Sk3KyDkVnyIgPtuntXxM6AYlGGbknUXkX/S
   gDEJ0HpmTVhkCqcyfcxY/dueuq+yt+7fItoY/olEIlSogszYxJCyn99+x
   O91JFgRzp1p1is0mJ7huD6m3c93Mm1gkIWBIs7CmYnQAnn6h0ZqAcvxVv
   Q==;
X-CSE-ConnectionGUID: RA52ecx/Ti+wEdDxJMLnkg==
X-CSE-MsgGUID: /5YdSh1jQj+Ywel/XofIvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56768552"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56768552"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:13:06 -0700
X-CSE-ConnectionGUID: +bCrWry6RQe4Sex8ybOxpA==
X-CSE-MsgGUID: IbTHoJawTVyJKtMAWCm2+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="189180343"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa002.fm.intel.com with ESMTP; 08 Aug 2025 22:13:01 -0700
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
Subject: [RFC PATCH v4 17/28] sched: Consider LLC preference when picking tasks from busiest queue
Date: Sat,  9 Aug 2025 13:06:58 +0800
Message-Id: <fe8ae3521256d58c52e8ece2a03f0d95ced1b15c.1754712565.git.tim.c.chen@linux.intel.com>
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

When picking tasks from busiest queue for load balance, we currently
do not consider LLC preference.

Order the task in the busiest queue such that we picked the tasks in the
following order:
	1. tasks that prefer dst cpu's LLC
	2. tasks that have no preference in LLC
	3. tasks that prefer LLC other than the ones they are on
	4. tasks that prefer the LLC that they are currently on

This will allow tasks better chances to wind up in its preferred LLC.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 66 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 592a4034e760..8d5792b9e658 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10093,6 +10093,68 @@ static struct task_struct *detach_one_task(struct lb_env *env)
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
+	if (!sched_feat(SCHED_CACHE))
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
@@ -10101,7 +10163,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
  */
 static int detach_tasks(struct lb_env *env)
 {
-	struct list_head *tasks = &env->src_rq->cfs_tasks;
+	struct list_head *tasks;
 	unsigned long util, load;
 	struct task_struct *p;
 	int detached = 0;
@@ -10120,6 +10182,8 @@ static int detach_tasks(struct lb_env *env)
 	if (env->imbalance <= 0)
 		return 0;
 
+	tasks = order_tasks_by_llc(env, &env->src_rq->cfs_tasks);
+
 	while (!list_empty(tasks)) {
 		/*
 		 * We don't want to steal all, otherwise we may be treated likewise,
-- 
2.25.1



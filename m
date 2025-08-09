Return-Path: <linux-kernel+bounces-760947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D3B1F23C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8350B162F5F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BB226CFC;
	Sat,  9 Aug 2025 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuSndoFC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717515665C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716315; cv=none; b=V21sVGbgLQDQ3LIjl4XUJrmJ9J0H7EnLAxMhWiHDhYvdTQf37ITQq1SLcLqEU8QZBleGBd5opQCrWn9ZA+ka3UsL0gAkAAWeYPjzH6uXv6zStuJq71dJWgYewm9hUHjq7qSX6lm/Lgw0QNQVBR235FBzMEr5TtJzqy9vbdAZgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716315; c=relaxed/simple;
	bh=AIuQrSu/5y/S9TIWqFOGCV+S6deOxyVrovvWy4SL2kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OloMkMGj39oyisSI/elKEAvpy20hxc65DCBP77XOsD6DM1R+a5A5Da/ppqs7Z7p3GBtilMBdNOBeSCw4CLzWnpi/GbZs0twrI/jHBj75g3QWh2U+l9MnhNx5slK4wgHsVE88KJtcO1SMNVHstEsw3B+CP/Ty6sI5OGUAf63XtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuSndoFC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716314; x=1786252314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AIuQrSu/5y/S9TIWqFOGCV+S6deOxyVrovvWy4SL2kw=;
  b=ZuSndoFC4541nSvbCP6cEW/FYV1l8zzkJP80vf6pWY1ZOHgg/RVomY/T
   Ti6yNCB58L0Sd4kxkaI5sPLuF7vCi3M5pS05/bm13pSUnPEFFjtsLUyj2
   f9POeHNiXdDCLJm6AbH5YNMJHTMKKxVu+wmWQOJyUA2JQAjfjhd4Y2l7i
   hwHCcBSXZp9fOvMWTMVoUR8/ktX+69hF3c7sKUUgsZ3Ez6EVCyQ/ijbHd
   VIyS49HPzpJp2UXMWArIqJMLsn/1xm4WXUpNNwWGCUSD+Ru4vQomDx8lv
   I+sL/FNJq4W7oKMEvp16XyroY9GrTk18XR9yqRbCDZM1KnkZXCppQk2n8
   g==;
X-CSE-ConnectionGUID: UjPqhATKTouUNB6GDkUddg==
X-CSE-MsgGUID: rAOe+a/mQeqiUy/XHrFejQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56259917"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56259917"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:11:53 -0700
X-CSE-ConnectionGUID: WVRUnOqXSoeMjZHQRQuF4Q==
X-CSE-MsgGUID: AGpfHQaOSwWVkoL9IadjUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165475971"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa007.jf.intel.com with ESMTP; 08 Aug 2025 22:11:48 -0700
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
Subject: [RFC PATCH v4 13/28] sched: Tag the sched group as llc_balance if it has tasks prefer other LLC
Date: Sat,  9 Aug 2025 13:05:44 +0800
Message-Id: <c111a2b0837ba1616a558f5797d63294e062c33d.1754712565.git.tim.c.chen@linux.intel.com>
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

During load balancing between LLCs, check whether there are tasks
preferring the destination LLC. If so, balance those tasks to the
destination LLC first.

Tag the sched_group that has tasks preferring to run on other LLCs
(non-local) with the group_llc_balance flag. This way, the load
balancer will later attempt to pull/push these tasks to their
preferred LLCs.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f1697658c3b8..30ebc7d1b999 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10491,6 +10491,7 @@ struct sg_lb_stats {
 	enum group_type group_type;
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
 	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
+	unsigned int group_llc_balance;		/* Tasks should be moved to preferred LLC */
 	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -10855,6 +10856,43 @@ static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 	return false;
 }
 
+/*
+ * Do LLC balance on sched group that contains LLC, and have tasks preferring
+ * to run on LLC in idle dst_cpu.
+ */
+#ifdef CONFIG_SCHED_CACHE
+static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
+			       struct sched_group *group)
+{
+	struct sched_domain *child = env->sd->child;
+	int llc;
+
+	if (!sched_feat(SCHED_CACHE))
+		return false;
+
+	if (env->sd->flags & SD_SHARE_LLC)
+		return false;
+
+	/* only care about task migration among LLCs */
+	if (child && !(child->flags & SD_SHARE_LLC))
+		return false;
+
+	llc = llc_idx(env->dst_cpu);
+	if (sgs->nr_pref_llc[llc] > 0 &&
+	    _get_migrate_hint(env->src_cpu, env->dst_cpu,
+			      0, true) == mig_allow)
+		return true;
+
+	return false;
+}
+#else
+static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
+			       struct sched_group *group)
+{
+	return false;
+}
+#endif
+
 static inline long sibling_imbalance(struct lb_env *env,
 				    struct sd_lb_stats *sds,
 				    struct sg_lb_stats *busiest,
@@ -11037,6 +11075,11 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
 	update_sg_if_llc(env, sgs, group);
+
+	/* Check for tasks in this group can be moved to their preferred LLC */
+	if (!local_group && llc_balance(env, sgs, group))
+		sgs->group_llc_balance = 1;
+
 	/* Computing avg_load makes sense only when group is overloaded */
 	if (sgs->group_type == group_overloaded)
 		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
-- 
2.25.1



Return-Path: <linux-kernel+bounces-760948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AFBB1F23D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A163170174
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957AA23E25B;
	Sat,  9 Aug 2025 05:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEuihH0+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDCBA36
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716330; cv=none; b=aQ1DuKtufh+Odr/LorF9O/fM51njWURpIhUr0LEbL04DjrjFm+d09C28slCF+44U9FtSmiimp1pCffRh1R/fvm2ZZoxIwYLoRUwe6OyK5cj/+TCojsQvg2MTs+TBXvkqNEX58rHKytdwSZsbXZQ7b/69UrXdxM0ua0rXL6iOtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716330; c=relaxed/simple;
	bh=O81QutAo6orLIIDwAsw0ZMG10IN4T/AEDQCSSIJxqyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5xozr9Mtp5uu2TvfPRuTYtKe4U1Wvg6adAEEQYPp3XhL43lFnMD5WFxuPpA676GFAHZvR3sqXgli2n0l/wcn29K4BggdO2CKIje4lN3tYfPeo9MARoA5x4puu9zfIoLrFm8QyrapPsLUWke2Sltghaenw5fxTvdXdEsap9QY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEuihH0+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716328; x=1786252328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O81QutAo6orLIIDwAsw0ZMG10IN4T/AEDQCSSIJxqyQ=;
  b=MEuihH0+FVuXmARwKbtg3ZEInFXwZofL2oeZFz8hAFncHiYR3thGt37w
   r1T1tf3lEswVj9+r/pBIBCI/p6tNeK/mU9z44eSxhHK5hkAbm4U0pK2Yd
   kJSRq/e/BjJbTfq0wdmHL+xZeKBs3wZgVSLF/cjxbK8xkGolfMsNQtISm
   W3cnADlN4qbVKCTxsMFINRPYiR7F/yD1Oj5rfzQ0wt0MvGxsmxI+X3NFf
   9X2WdZwnrcjBg1uRuKw5Ke2i5+i08CMFggHeD7mmAh+bcE6otZUr5bfyT
   1/s8kOVFgN6mguEbs8JSr9oz3bIDVZO52aj/iKxcnT/mwWA+dnZZTC1UF
   g==;
X-CSE-ConnectionGUID: 7CDD+sx7Si6bye2RdBQ3gA==
X-CSE-MsgGUID: jib9w3+fQbenCvLznD37kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56259932"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56259932"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:12:07 -0700
X-CSE-ConnectionGUID: DOXrAiV0Se6h6BcziixHkw==
X-CSE-MsgGUID: PSBpAuryS0CRK6OjhNz0bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165475987"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa007.jf.intel.com with ESMTP; 08 Aug 2025 22:12:02 -0700
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
Subject: [RFC PATCH v4 14/28] sched: Introduce update_llc_busiest() to deal with groups having preferred LLC tasks
Date: Sat,  9 Aug 2025 13:05:58 +0800
Message-Id: <bf3d8e42cd09bb23a296d26528624e835e6a520d.1754712565.git.tim.c.chen@linux.intel.com>
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

The load balancer attempts to identify the busiest sched_group with
the highest load and migrates some tasks to a less busy sched_group
to distribute the load across different CPUs.

When cache-aware scheduling is enabled, the busiest sched_group is
defined as the one with the highest number of tasks preferring to run
on the destination LLC. If the busiest group has llc_balance tag,
the cache aware load balance will be launched.

Introduce the helper function update_llc_busiest() to identify
such sched group with most tasks preferring the destination LLC.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 30ebc7d1b999..b8cc85291351 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10885,12 +10885,36 @@ static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 
 	return false;
 }
+
+static bool update_llc_busiest(struct lb_env *env,
+			       struct sg_lb_stats *busiest,
+			       struct sg_lb_stats *sgs)
+{
+	int idx;
+
+	/* Only the candidate with llc_balance need to be taken care of */
+	if (!sgs->group_llc_balance)
+		return false;
+
+	/*
+	 * There are more tasks that want to run on dst_cpu's LLC.
+	 */
+	idx = llc_idx(env->dst_cpu);
+	return sgs->nr_pref_llc[idx] > busiest->nr_pref_llc[idx];
+}
 #else
 static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 			       struct sched_group *group)
 {
 	return false;
 }
+
+static bool update_llc_busiest(struct lb_env *env,
+			       struct sg_lb_stats *busiest,
+			       struct sg_lb_stats *sgs)
+{
+	return false;
+}
 #endif
 
 static inline long sibling_imbalance(struct lb_env *env,
@@ -11122,6 +11146,14 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	     sds->local_stat.group_type != group_has_spare))
 		return false;
 
+	/* deal with prefer LLC load balance, if failed, fall into normal load balance */
+	if (update_llc_busiest(env, busiest, sgs))
+		return true;
+
+	/* if there is already a busy group, skip the normal load balance */
+	if (busiest->group_llc_balance)
+		return false;
+
 	if (sgs->group_type > busiest->group_type)
 		return true;
 
@@ -12029,9 +12061,11 @@ static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
 	/*
 	 * Try to move all excess tasks to a sibling domain of the busiest
 	 * group's child domain.
+	 * Also do so if we can move some tasks that prefer the local LLC.
 	 */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
-	    sibling_imbalance(env, &sds, busiest, local) > 1)
+	    (busiest->group_llc_balance ||
+	    sibling_imbalance(env, &sds, busiest, local) > 1))
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded) {
-- 
2.25.1



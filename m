Return-Path: <linux-kernel+bounces-760953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EC9B1F242
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A407F18967F1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC84275872;
	Sat,  9 Aug 2025 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fv6T2jfF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E605BA36
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716413; cv=none; b=Y5DY4uVXJj/NXx4xa+vIglUy/e0Mz3lC23M4GrgHNX8VTYhXYab2lfrFY6mo9TrkT8w/WQHHy0ath+3g82U7f7w+5f8oq86hgIXxPEP3isbuKS9ryw2kjNuMOw6y8wqF8EHfhI4CaEef8Gm0ym0TuNTWKHvhA39IckSeqYVQ55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716413; c=relaxed/simple;
	bh=rJfyf/57CaUPFk3O70t1/xBAt4kiiSb/LUukMkIaaWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BbGezSEvMdgtuVQGY5ll4boKLDz3xf/HaQKe/BbQh2RvAxEla/bMNlbvy7fNRiyq6jqUio9sHSAT2xUSQfMGzvU0gbx6uABWuPs54UhyitX7QqsGpuhPSoWaqfjMJ+JchZxUZEza6Pv3LtvE1xF1YB8vYubCHFqLzoIDWZeEypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fv6T2jfF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716412; x=1786252412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rJfyf/57CaUPFk3O70t1/xBAt4kiiSb/LUukMkIaaWI=;
  b=Fv6T2jfFSgH2501Wvsd9NAJpLZ95G3qQ2wpS+brwkLJI4Z9OwbGNI010
   TXV31asmWoF9+Q+nOOHJAmbtTXBwCofZZc4StvBRsyudecftX7Wk1PRur
   u7QKz2FJNo0ci4Owq3KzhsOU/Zu+KxpkANT6PW233G4v7L1dfPrJmuTsr
   kc0L6AcVmncnIjhBRuMo0p6BD/uY9llqRtu1k1OnH8I9Jcei+J4SP8kPW
   Qrss/vUTJVcjLGz++sDQq5rXiSF8X5srU5tRisTDzgzNNua10vFLKF5a/
   +MoDPmHcbzf2Z88/IRgSh6BUtg+yyb4sVeKEc69v7SY3AfaN4pHBsvMby
   w==;
X-CSE-ConnectionGUID: yRiWx0TaSqSHcni4YwFu1Q==
X-CSE-MsgGUID: KOLdWXj6RXq5qKElN0Zavw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="79620355"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="79620355"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:13:31 -0700
X-CSE-ConnectionGUID: 66tPf5k4Q3+atsnA5jm4Jg==
X-CSE-MsgGUID: 4d6H20jNRjW/omJZg3lPVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165844013"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2025 22:13:26 -0700
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
Subject: [RFC PATCH v4 19/28] sched: Introduce SCHED_CACHE_LB to control cache aware load balance
Date: Sat,  9 Aug 2025 13:07:23 +0800
Message-Id: <eba3303cdab63e2d96dcc630d153004e4afb88f3.1754712565.git.tim.c.chen@linux.intel.com>
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

Introduce the SCHED_CACHE_LB sched feature to enable or disable
cache aware load balance in the schduler.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c     | 18 ++++++++++--------
 kernel/sched/features.h |  1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 22b7a7fe538e..9843d4e1d84f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10019,7 +10019,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 1;
 
 #ifdef CONFIG_SCHED_CACHE
-	if (sched_feat(SCHED_CACHE) &&
+	if (sched_feat(SCHED_CACHE) && sched_feat(SCHED_CACHE_LB) &&
 	    get_migrate_hint(env->src_cpu, env->dst_cpu, p) == mig_forbid)
 		return 0;
 #endif
@@ -10105,7 +10105,7 @@ static struct list_head
 	LIST_HEAD(no_pref_llc);
 	LIST_HEAD(pref_other_llc);
 
-	if (!sched_feat(SCHED_CACHE))
+	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB))
 		return tasks;
 
 	if (cpus_share_cache(env->dst_cpu, env->src_cpu))
@@ -10290,7 +10290,8 @@ static int detach_tasks(struct lb_env *env)
 		 * The tasks have already been sorted by order_tasks_by_llc(),
 		 * they are tasks that prefer the current LLC.
 		 */
-		if (sched_feat(SCHED_CACHE) && p->preferred_llc != -1 &&
+		if (sched_feat(SCHED_CACHE) && sched_feat(SCHED_CACHE_LB) &&
+		    p->preferred_llc != -1 &&
 		    llc_id(env->src_cpu) == p->preferred_llc)
 			break;
 #endif
@@ -10947,7 +10948,7 @@ static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 	struct sched_domain *child = env->sd->child;
 	int llc;
 
-	if (!sched_feat(SCHED_CACHE))
+	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB))
 		return false;
 
 	if (env->sd->flags & SD_SHARE_LLC)
@@ -11058,7 +11059,8 @@ static void update_sg_if_llc(struct lb_env *env, struct sg_lb_stats *sgs,
 	struct sched_domain *sd = env->sd->child;
 	struct sched_domain_shared *sd_share;
 
-	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE)
+	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE ||
+	    !sched_feat(SCHED_CACHE_LB))
 		return;
 
 	/* only care the sched domain that spans 1 LLC */
@@ -11120,7 +11122,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			*sg_overutilized = 1;
 
 #ifdef CONFIG_SCHED_CACHE
-		if (sched_feat(SCHED_CACHE)) {
+		if (sched_feat(SCHED_CACHE) && sched_feat(SCHED_CACHE_LB)) {
 			int j;
 
 			for (j = 0; j < max_llcs; ++j)
@@ -12406,7 +12408,7 @@ imbalanced_active_balance(struct lb_env *env)
 static inline bool
 break_llc_locality(struct lb_env *env)
 {
-	if (!sched_feat(SCHED_CACHE))
+	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB))
 		return 0;
 
 	if (cpus_share_cache(env->src_cpu, env->dst_cpu))
@@ -12908,7 +12910,7 @@ static int active_load_balance_cpu_stop(void *data)
 #ifdef CONFIG_SCHED_CACHE
 		int llc = llc_idx(target_cpu);
 
-		if (!sched_feat(SCHED_CACHE))
+		if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_LB))
 			goto out_unlock;
 
 		if (llc < 0)
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index d2af7bfd36bf..11dbd74cd365 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -88,6 +88,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
 SCHED_FEAT(SIS_UTIL, true)
 
 SCHED_FEAT(SCHED_CACHE, true)
+SCHED_FEAT(SCHED_CACHE_LB, true)
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
  * in a single rq->lock section. Default disabled because the
-- 
2.25.1



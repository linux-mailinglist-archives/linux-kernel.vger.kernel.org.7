Return-Path: <linux-kernel+bounces-760949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65607B1F23E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B79188FE72
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734CE275872;
	Sat,  9 Aug 2025 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEnIOB1/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC501DE3BE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716359; cv=none; b=QbiGTyG3g2KE4hVHW5ANIWTpqVt3p0S/zxdB0gitjC7ulgs6vf7jEjdLirjHI7kaK+ztqqN/rCqTa/6hfausklfNc4rz8dYqp0CG6Y6YgxkKUwvBQIrp/KqxhxJRz+O3v6tp0XTYU16LxAdHr+C5BFN93tNkPr76wtjETRyaMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716359; c=relaxed/simple;
	bh=yGnpZ6FlvoEQkStNXEnYs/+BqL2dRHGniBRSc7+bEyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m1yPm73VBI2YcbcZuIT/BdavdjC/l3BdlBwnghR8mggxNfB23vX6iBYsgIl3jTAM5i/J7m6oqk0xrxs69iqlLFQ90jQ8hbG1d9nYsXQ1qBKpwmo+MO9karhCFAgqXxtek2+Fw6jBNSgn4f3uTQlC2jV9TQHxB0EG1HVMEE5ZgXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEnIOB1/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716358; x=1786252358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yGnpZ6FlvoEQkStNXEnYs/+BqL2dRHGniBRSc7+bEyI=;
  b=TEnIOB1/ILlwqYFTI6kKipRVVwx6DRo7Bg6DA7Rv5STVaUTCs0KWpJvq
   Z6xP+XRjxHgLpyN1tALXTPQatPAmzpP8yoIO81oaWxQRxnjTqFILCkrJF
   kCtJQ/VZjCEhVc7wgV23PMjUStSCtMH0P9OW3KNu8Za5Pnw7tMZySzv3t
   NECmaJZ84sMsSF0CtDUsuTqG088mMNcuu4rS+3dzRuIJxgZ7St1Ds47Z9
   1QQxPYZElaPgiDkZBfePvDHM5kCX7XSWYlmCxqKtAeHU7eYkQHevmw80h
   wEnmX47OYGWTIQssLuDSa8NOAiVjB27DwhzduhCcmV9MOJn0mr3hsf+ZP
   A==;
X-CSE-ConnectionGUID: lvcsmsR8QjyFBqcujWQmiQ==
X-CSE-MsgGUID: bzzKp3XeT8WmtT0FxfRmoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56932532"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56932532"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:12:37 -0700
X-CSE-ConnectionGUID: cebyh5CzSdq9bdRIx+9UHw==
X-CSE-MsgGUID: 291hr3FsSYCIyZnbCahMKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="164703738"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa006.jf.intel.com with ESMTP; 08 Aug 2025 22:12:31 -0700
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
Subject: [RFC PATCH v4 15/28] sched: Introduce a new migration_type to track the preferred LLC load balance
Date: Sat,  9 Aug 2025 13:06:27 +0800
Message-Id: <b2ac5df723e9995d5b336282c639cc484ac1b884.1754712565.git.tim.c.chen@linux.intel.com>
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

Introduce a new migration type named migrate_llc_task to facilitate
cache-aware load balancing.

After the busiest sched_group is identified as the one that needs
migration due to having most tasks preferring destination LLC, tag the
migration type as the newly introduced migrate_llc_task. During load
balancing, each runqueue within the busiest preferred-LLC sched_group
is checked, and the runqueue with the highest number of tasks preferring
to run on the destination CPU is chosen as the busiest runqueue.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b8cc85291351..a301b56dd2b4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9746,7 +9746,8 @@ enum migration_type {
 	migrate_load = 0,
 	migrate_util,
 	migrate_task,
-	migrate_misfit
+	migrate_misfit,
+	migrate_llc_task
 };
 
 #define LBF_ALL_PINNED	0x01
@@ -10180,6 +10181,15 @@ static int detach_tasks(struct lb_env *env)
 			env->imbalance -= util;
 			break;
 
+		case migrate_llc_task:
+			/*
+			 * Since can_migrate_task() succeed, when we reach here, it means that p
+			 * can be migrated even if dst_cpu is not p's preferred_llc, because there
+			 * are no idle cores for p to do in-llc load balance.
+			 */
+			env->imbalance--;
+			break;
+
 		case migrate_task:
 			env->imbalance--;
 			break;
@@ -11817,6 +11827,15 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
@@ -12125,6 +12144,10 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 	struct rq *busiest = NULL, *rq;
 	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
 	unsigned int busiest_nr = 0;
+#ifdef CONFIG_SCHED_CACHE
+	unsigned int busiest_pref_llc = 0;
+	int dst_llc;
+#endif
 	int i;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
@@ -12233,6 +12256,16 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
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
@@ -12415,6 +12448,8 @@ static void update_lb_imbalance_stat(struct lb_env *env, struct sched_domain *sd
 	case migrate_misfit:
 		__schedstat_add(sd->lb_imbalance_misfit[idle], env->imbalance);
 		break;
+	case migrate_llc_task:
+		break;
 	}
 }
 
-- 
2.25.1



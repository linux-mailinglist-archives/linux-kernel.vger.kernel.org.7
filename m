Return-Path: <linux-kernel+bounces-849247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A16BCFAAE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34D6D4ED2A8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A7A287275;
	Sat, 11 Oct 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9YkqrBb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3802857E0
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206711; cv=none; b=t2IkYrrS4OEW0rLnZ4Ph2aLp/ob7UBcUobZQPFlHPmpcJEG5m0pUt/86mOssLKuYpjefjiUDrjFelfxhjAxq8hkNJqtOEMJPbTz+zzT3SsVZRdrqKE8v+5YoRbLqXRQPim2ll3DhWUtUyVjcOo+wuodh/CEa974mbGOLa7mTgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206711; c=relaxed/simple;
	bh=XiIsNrTg0GfmfpcWJwni6hIdWkEEq9nbQ2y28gcjQcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFlB5zhIcHUsbSOo/sD1pZdSFz7frR0zFFzgb5/20MqZiItU17WC0G8ifB7ANEAoWHl+sZ1UBTS2HXkckShm7SoSJJXvPBbw6XxQCBJK6yrElYIzS1CzXKAx7vBmkFFghPyfHOK4JpsmMAKYxqatpcWaHZwO7N1+tqHPYDwlFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9YkqrBb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206709; x=1791742709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XiIsNrTg0GfmfpcWJwni6hIdWkEEq9nbQ2y28gcjQcw=;
  b=Y9YkqrBbsakXirsuA3GK7ppNmtxnJk2cm0iimpzRLvMdIlTwXGPf3Jxq
   CO6EwYbc/Esxx5TDgaH0h7SVW6eQY5e38xqt9oEwqeMZQtQ13URaPfC2Q
   Mwk/v0qwxo5jXbC8xa2O9JpbH1ZyVCsabZmLtbPS2e8WfQbQS4lgRoeof
   RbwLkRXbWC69JnwGxh3aUM7ZF9q8ziMLuIK7nYhL3utheouiHtWkbs+nW
   RBMmwNo592e9Wh6g7Ht+Vdc051U+njdgUo7aZRqY6DlKoIGZaJJSG2c0W
   jAF73DWLcSoTQT2Ii9M9dPOTvOCcojIDgIVpILvlasXm0wG4u+s+OJFGn
   Q==;
X-CSE-ConnectionGUID: bcFBDLOoTw6TYukUkbI3wQ==
X-CSE-MsgGUID: 0WEdTBqUR0WG7HuYHYySDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339807"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339807"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:29 -0700
X-CSE-ConnectionGUID: teKUgYrNS8ayzrTmALf01w==
X-CSE-MsgGUID: OBuR3uU9Q8qKO64uzC8h4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487230"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:28 -0700
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
Subject: [PATCH 11/19] sched/fair: Identify busiest sched_group for LLC-aware load balancing
Date: Sat, 11 Oct 2025 11:24:48 -0700
Message-Id: <fcdf37780eeb409cf10925f8b8dcef486c92b218.1760206683.git.tim.c.chen@linux.intel.com>
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

The load balancer selects the busiest sched_group and migrates tasks
to less busy groups to distribute load across CPUs.

With cache-aware scheduling enabled, the busiest sched_group is
the one with most tasks preferring the destination LLC. If
the group has the llc_balance flag set, cache aware load balancing is
triggered.

Introduce the helper function update_llc_busiest() to identify the
sched_group with the most tasks preferring the destination LLC.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af7b578eaa06..8469ec528cb1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10877,6 +10877,23 @@ static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 
 	return false;
 }
+
+static bool update_llc_busiest(struct lb_env *env,
+			       struct sg_lb_stats *busiest,
+			       struct sg_lb_stats *sgs)
+{
+	int idx;
+
+	/* Only the candidate with llc_balance needs to be taken care of */
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
 static inline void record_sg_llc_stats(struct lb_env *env, struct sg_lb_stats *sgs,
 				       struct sched_group *group)
@@ -10888,6 +10905,13 @@ static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
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
 
 /**
@@ -11035,6 +11059,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	     sds->local_stat.group_type != group_has_spare))
 		return false;
 
+	/* deal with prefer LLC load balance, if failed, fall into normal load balance */
+	if (update_llc_busiest(env, busiest, sgs))
+		return true;
+
+	/*
+	 * If the busiest group has tasks with LLC preference,
+	 * skip normal load balance.
+	 */
+	if (busiest->group_llc_balance)
+		return false;
+
 	if (sgs->group_type > busiest->group_type)
 		return true;
 
@@ -11942,9 +11977,11 @@ static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
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
2.32.0



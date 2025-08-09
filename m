Return-Path: <linux-kernel+bounces-760944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C237CB1F239
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6559B622911
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA885275872;
	Sat,  9 Aug 2025 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geKQjfK/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB411DE3BE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716235; cv=none; b=lYq4sXXnPZXpun4uCiODi1V3d/oXpyY0WTO8EB77SDdlY6hzvunzTarb/1BsD6HfY68VzKdZ/P3gkg6eJSWY/V4zZO3lamlWGMLfuQQ9r0QtHrs78GolCQXrw2NP8BYJ0Ju1m5iSnICs6lWRkPa7xXiHxKjTT1AzsfOnMwn7rTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716235; c=relaxed/simple;
	bh=mMOSEbE/HppEmtkHE5TulvZHAhAbaSvHHXGxGBzFcgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3HRMLmVG1MFAS1qP6GNt/s6/77Uh+WddEprQ5Z3l8TxNvB+P4AvujK8AWnshyXFcGmTbARtQ+BIJgmdYZlbH9m8Qs+2XeS6vuXVoCzJlMxbKBnl0JQB9Z0xEIolcdu+YlhDSc69qnES+cWMESyBPPowQbtqjplsmzkh92xzVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geKQjfK/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716234; x=1786252234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mMOSEbE/HppEmtkHE5TulvZHAhAbaSvHHXGxGBzFcgU=;
  b=geKQjfK/ENQzxJIVdaSMSI44R3jzrRtlLAcLLVwYHZqNhRHgxmIbm8PU
   XiWO/MC/iDc0e7d2LUmRe0CKRrydnkWRCT7V1d5Ru83rqB+7K/+RrZNhk
   +2sQx23IAdQbusICOeU5sYoOB7pa5uDZu1oWLgGvhnJwEFa2V+2w+qxj2
   m6YwMTmZ4b38bn4agOoOn4ktTclSJFaj3Mp772dwNENS9tmK3L6FTfdSK
   gtxcuwqrQMw1U7n0bVzf8SFtoDVy9euo9ZcsqmS67rcCdjvv8Sewo0TTC
   69ZCq755Kkj3SVTPSNh4ROx9trC8pZSNM1tAluNyLdBtgKLb9L4vwsHnZ
   g==;
X-CSE-ConnectionGUID: gBIugcE8QvyHdtE7rR2INg==
X-CSE-MsgGUID: omeDEy9ySEOEIT5GfzHbDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57019934"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57019934"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:10:33 -0700
X-CSE-ConnectionGUID: 3IoQ+9+0SaCZvxJgCfv5ug==
X-CSE-MsgGUID: 3gf5XiXlTDy8oJdmBqQc4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="169705062"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2025 22:10:27 -0700
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
Subject: [RFC PATCH v4 11/28] sched: Introduce per runqueue task LLC preference counter
Date: Sat,  9 Aug 2025 13:04:18 +0800
Message-Id: <fc52347ecefb756cb3a9a7d90874e7c502fa55e0.1754712565.git.tim.c.chen@linux.intel.com>
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

Each runqueue is assigned a static array, where each element indicates
the number of tasks preferring a particular LLC mapped to the
array index.

For example, rq->nr_pref_llc[3] = 2 signifies that there are 2 tasks on
this runqueue which prefer to run within LLC3 (indexed from 0 to MAX_LLC
across the entire system). With this information, the load balancer can
make better decisions to select the busiest runqueue and migrate tasks
to their preferred LLC domains.

Note: The static array could be converted to an xarray in the future.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c  | 42 ++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |  1 +
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f964d5a44fcc..cfae71ee870b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1195,22 +1195,51 @@ static inline int llc_idx(int cpu)
 	return per_cpu(sd_llc_idx, cpu);
 }
 
+static inline int pref_llc_idx(struct task_struct *p)
+{
+	return llc_idx(p->preferred_llc);
+}
+
 static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
 {
+	int pref_llc;
+
 	if (!sched_feat(SCHED_CACHE))
 		return;
 
 	rq->nr_llc_running += (p->preferred_llc != -1);
 	rq->nr_pref_llc_running += (p->preferred_llc == task_llc(p));
+
+	if (p->preferred_llc < 0)
+		return;
+
+	pref_llc = pref_llc_idx(p);
+	if (pref_llc < 0)
+		return;
+
+	++rq->nr_pref_llc[pref_llc];
 }
 
 static void account_llc_dequeue(struct rq *rq, struct task_struct *p)
 {
+	int pref_llc;
+
 	if (!sched_feat(SCHED_CACHE))
 		return;
 
 	rq->nr_llc_running -= (p->preferred_llc != -1);
 	rq->nr_pref_llc_running -= (p->preferred_llc == task_llc(p));
+
+	if (p->preferred_llc < 0)
+		return;
+
+	pref_llc = pref_llc_idx(p);
+	if (pref_llc < 0)
+		return;
+
+	/* avoid negative counter */
+	if (rq->nr_pref_llc[pref_llc] > 0)
+		--rq->nr_pref_llc[pref_llc];
 }
 
 void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
@@ -1279,6 +1308,8 @@ static unsigned long __no_profile fraction_mm_sched(struct rq *rq, struct mm_sch
 	return div64_u64(NICE_0_LOAD * pcpu_sched->runtime, rq->cpu_runtime + 1);
 }
 
+static unsigned int task_running_on_cpu(int cpu, struct task_struct *p);
+
 static inline
 void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 {
@@ -1321,7 +1352,9 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	if (mm->mm_sched_cpu != -1)
 		mm_sched_llc = per_cpu(sd_llc_id, mm->mm_sched_cpu);
 
-	if (p->preferred_llc != mm_sched_llc) {
+	/* task not on rq accounted later in account_entity_enqueue() */
+	if (task_running_on_cpu(rq->cpu, p) &&
+	    p->preferred_llc != mm_sched_llc) {
 		account_llc_dequeue(rq, p);
 		p->preferred_llc = mm_sched_llc;
 		account_llc_enqueue(rq, p);
@@ -1431,11 +1464,16 @@ void init_sched_mm(struct task_struct *p)
 
 void reset_llc_stats(struct rq *rq)
 {
+	int i;
+
 	if (!sched_feat(SCHED_CACHE))
 		return;
 
-	if (rq->nr_llc_running)
+	if (rq->nr_llc_running) {
+		for (i = 0; i < MAX_LLC; ++i)
+			rq->nr_pref_llc[i] = 0;
 		rq->nr_llc_running = 0;
+	}
 
 	rq->nr_pref_llc_running = 0;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8026e2c66e9f..4464b92767ad 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1109,6 +1109,7 @@ struct rq {
 #ifdef CONFIG_SCHED_CACHE
 	unsigned int		nr_pref_llc_running;
 	unsigned int		nr_llc_running;
+	unsigned int		nr_pref_llc[MAX_LLC];
 #endif
 #ifdef CONFIG_NO_HZ_COMMON
 #ifdef CONFIG_SMP
-- 
2.25.1



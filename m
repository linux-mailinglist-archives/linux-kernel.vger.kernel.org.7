Return-Path: <linux-kernel+bounces-760959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C9CB1F248
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54E5581792
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59F2749D5;
	Sat,  9 Aug 2025 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtFt/v4t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B93262FE7
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716487; cv=none; b=SwLkLgdtnhX6+OqLa78yMZ0B4CsWLaf64/W+OI5unQJxwjCB9iC7AOkHjHIaNJ3elBvx03DMvZl1I9GsmU+4HfwjpJKe6RPlgB+vcyUgYbcDZyIBhWoXYSKefXUoVChQUkXZnD99yesLvH9Ng14G5w2CQagDetRVGrHCe4izAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716487; c=relaxed/simple;
	bh=NXUgKwlBD+LbS7BQoNhwYmUMMNvH06C+9x5ABL9KQvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hLGB1Xa+0uSZNB/dGK1ZYaVry91TulpBPgnDTPCsKPDTIPOxhNaZZ9Cuzpbo38IwKkY5uJgzEZ1uUGrD/s/RAk4WaWJnoklk4db0h0lc6DTb3DdY///Tx0rE+4HGY8/VgFkFtuHBrA6i2cPS9Gpq8iWYdaB6+MhIJDjLW2gw96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtFt/v4t; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716485; x=1786252485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXUgKwlBD+LbS7BQoNhwYmUMMNvH06C+9x5ABL9KQvU=;
  b=JtFt/v4t08KznPLSFaAfIMnOlZCZo8kJRJT+HfIrOEKXEd/dqH+lrk/a
   pIz5BUtjCYdr/a4c7pZ1o1bWZFwpHGC/M6S2vru19uOo+9h+a6+cDG4JL
   yM5/aSH0L5HRBrhBX4JQAp/3MD69CoaWhFe+GdocmtVOMYwP+erObftt/
   1RQRwVjl1GoMs0U6JSVWCb5Sk5EwLmq/bSRzlsfuwbMavl7fO/aSz0Urq
   XtvO5DV6xrhsk1Y77keeRc1mlMUGjry5fYahbKbwyaOxyKFtrNAFVv1mP
   qRCo9H1Kh+G72Foi9f3RFJzd/ky65xGF3aC6FH86kLP/zxm2pRC6gsTTi
   w==;
X-CSE-ConnectionGUID: IHbXoWNLTlyKIkz7HGkE0w==
X-CSE-MsgGUID: A4HbKv+ySb+99UGpcOUEYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56259994"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56259994"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:14:45 -0700
X-CSE-ConnectionGUID: tRxkh/5RR2W0QaPbtyXBXw==
X-CSE-MsgGUID: kEi0G4T2TKO4l03CeelQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165476161"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa007.jf.intel.com with ESMTP; 08 Aug 2025 22:14:39 -0700
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
Subject: [RFC PATCH v4 25/28] sched: Skip cache aware scheduling if the process has many active threads
Date: Sat,  9 Aug 2025 13:08:36 +0800
Message-Id: <463bc54a283c1b908ea286ce67f301e2d1d39ea1.1754712565.git.tim.c.chen@linux.intel.com>
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

If the number of active threads within the process
exceeds the number of Cores(divided by SMTs number)
in the LLC, do not enable cache-aware scheduling.
This is because there is a risk of cache contention
within the preferred LLC when too many threads are
present.

Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2577b4225c3f..4bf794f170cf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1205,6 +1205,18 @@ static inline int pref_llc_idx(struct task_struct *p)
 	return llc_idx(p->preferred_llc);
 }
 
+static bool exceed_llc_nr(struct mm_struct *mm, int cpu)
+{
+	int smt_nr = 1;
+
+#ifdef CONFIG_SCHED_SMT
+	if (sched_smt_active())
+		smt_nr = cpumask_weight(cpu_smt_mask(cpu));
+#endif
+
+	return ((mm->nr_running_avg * smt_nr) > per_cpu(sd_llc_size, cpu));
+}
+
 static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
 {
 	int pref_llc;
@@ -1350,7 +1362,8 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	 * it's preferred state.
 	 */
 	if (epoch - READ_ONCE(mm->mm_sched_epoch) > sysctl_llc_old ||
-	    get_nr_threads(p) <= 1) {
+	    get_nr_threads(p) <= 1 ||
+	    exceed_llc_nr(mm, cpu_of(rq))) {
 		mm->mm_sched_cpu = -1;
 		pcpu_sched->occ = 0;
 	}
@@ -1430,6 +1443,11 @@ static void __no_profile task_cache_work(struct callback_head *work)
 	if (p->flags & PF_EXITING)
 		return;
 
+	if (get_nr_threads(p) <= 1) {
+		mm->mm_sched_cpu = -1;
+		return;
+	}
+
 	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
 		return;
 
@@ -9095,6 +9113,10 @@ static __maybe_unused enum llc_mig_hint get_migrate_hint(int src_cpu, int dst_cp
 	if (cpu < 0)
 		return mig_allow;
 
+	 /* skip cache aware load balance for single/too many threads */
+	if (get_nr_threads(p) <= 1 || exceed_llc_nr(mm, dst_cpu))
+		return mig_allow;
+
 	if (cpus_share_cache(dst_cpu, cpu))
 		return _get_migrate_hint(src_cpu, dst_cpu,
 					 task_util(p), true);
-- 
2.25.1



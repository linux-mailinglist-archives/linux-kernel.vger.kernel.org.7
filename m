Return-Path: <linux-kernel+bounces-849253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1588FBCFABB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37663AE4B5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393F28E5F3;
	Sat, 11 Oct 2025 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrCuBiww"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBF228B400
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206717; cv=none; b=YyEz/CWTR29mSwIUaPFMfMePzkOh+JM5Sy6daDO5bi2qr7vVNV19xi6LQHHFuh3wAPmGhaJZO0psSS/hmmAhEm9YYTN/Jgc2pWxCyI+xWhQCLC7I/PnTVjCiCQif4wqMsrxoWCBWSb2OUxPbQQvBrskdsdNoyUkJX7OfjisrPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206717; c=relaxed/simple;
	bh=1ZlncHncPiFtSdZrBk62iQ7LoAdWu/umRn9XHDFyiec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDrry+jPMrDILm/r9QUVZNGIrsE561nMMRjz9ay5n5LBA0g4KQ5jFwtQhbKMvroO4a5axJHedJTHbl6aSfvc0uCnQwzJq+eaxxOqXVEOWsoi3zdhUNBrxg97Vqp+GrazIyVFmuyXj145vhjyv4Ug8nfP5dYxkUNSPkfjany2j50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrCuBiww; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206715; x=1791742715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ZlncHncPiFtSdZrBk62iQ7LoAdWu/umRn9XHDFyiec=;
  b=lrCuBiwwXTTaUUesVoUKShmqNypNMcjFctaFnNlL8Jy17kFhV1UkeZza
   ZuX0GXcNA+d1mgjVrCdwx7TgVROgGBNK4U8k00nbzT6TvTcewZUk7QGtM
   ze+FjZ8AcXNEy5AhOAJw/Pg8vbtTnZ1loNcqp57iteVrKQqHWUMDyfSYU
   8P+nCqWidGuZDOqQcaEjQH4wD2Jn2+QsEcLHNMZnZLw6R3C8jci7hl1aG
   MGxs8mPuw6pSR4ah1MI8YVoYS5wwLulLaJK/V5D02tGg7pdRILUMNtqsB
   x0389trQkin/UccLwrCAMIGVL3znx7/2JW/py3nOY6EKojcOWTOyEIt0N
   Q==;
X-CSE-ConnectionGUID: WfwYlMtNQVe279pYYOUBnA==
X-CSE-MsgGUID: AjSkDrsURkOZNf5ZbyXbNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339923"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339923"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:35 -0700
X-CSE-ConnectionGUID: ezHUeA30SCiDTeB7wo76Nw==
X-CSE-MsgGUID: YeYwMr00ThmPUWDQc0+YAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487255"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:34 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Chen Yu <yu.c.chen@intel.com>,
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
	Tim Chen <tim.c.chen@linux.intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] sched/fair: Disable cache aware scheduling for processes with high thread counts
Date: Sat, 11 Oct 2025 11:24:54 -0700
Message-Id: <a098a60d9b4fc8ccea3392096f8bb0cf03af070b.1760206683.git.tim.c.chen@linux.intel.com>
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

From: Chen Yu <yu.c.chen@intel.com>

If the number of active threads within the process
exceeds the number of Cores(divided by SMTs number)
in the LLC, do not enable cache-aware scheduling.
This is because there is a risk of cache contention
within the preferred LLC when too many threads are
present.

Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 79d109f8a09f..6b8eace79eee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1240,6 +1240,18 @@ static inline int pref_llc_idx(struct task_struct *p)
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
@@ -1385,10 +1397,12 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 
 	/*
 	 * If this task hasn't hit task_cache_work() for a while, or it
-	 * has only 1 thread, invalidate its preferred state.
+	 * has only 1 thread, or has too many active threads, invalidate
+	 * its preferred state.
 	 */
 	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_LLC_AFFINITY_TIMEOUT ||
-	    get_nr_threads(p) <= 1) {
+	    get_nr_threads(p) <= 1 ||
+	    exceed_llc_nr(mm, cpu_of(rq))) {
 		if (mm->mm_sched_cpu != -1)
 			mm->mm_sched_cpu = -1;
 	}
@@ -1467,6 +1481,11 @@ static void __no_profile task_cache_work(struct callback_head *work)
 	if (p->flags & PF_EXITING)
 		return;
 
+	if (get_nr_threads(p) <= 1) {
+		mm->mm_sched_cpu = -1;
+		return;
+	}
+
 	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
 		return;
 
@@ -9826,6 +9845,10 @@ static enum llc_mig can_migrate_llc_task(int src_cpu, int dst_cpu,
 	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
 		return mig_unrestricted;
 
+	 /* skip cache aware load balance for single/too many threads */
+	if (get_nr_threads(p) <= 1 || exceed_llc_nr(mm, dst_cpu))
+		return mig_unrestricted;
+
 	if (cpus_share_cache(dst_cpu, cpu))
 		to_pref = true;
 	else if (cpus_share_cache(src_cpu, cpu))
-- 
2.32.0



Return-Path: <linux-kernel+bounces-849244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88BBCFA96
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5237189A392
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D49E2857C7;
	Sat, 11 Oct 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiTdX6Q6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D3284688
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206708; cv=none; b=W6A0Asy9e3NNDRL2ti9BvFY1go+vAlduaKJd1rmOWRr4k4IHRIEpHNJhix4g/v1mdJgDI06CWQ3sQC5YxuLOry9f66mT2W5iUkNoO1AMOa7iJYVMhxygC7dgS1riRk+Xr61GHZrfTq3glOqKoHqMJR1ChGEEIDFSijs9KJo91LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206708; c=relaxed/simple;
	bh=qUQDFYZ38LNpr9WfzaoIX7ySGKszvby265gkxQF4WK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzr/dGrFdG1v5FdOJ/f9StnRIpzjJ5uOjWV+sYvWDeYE/dxtVTZG5FXWR8UqlK4jv7ZYYOlRDJRmdwLszrh1cbzNE43kw7ueGEnBAbSwzUyXo12aLw3ckNHZHHjqr9uTbTYz7GDrN3J5K862edN4cdJHoI9buyHUDzdCkXfIheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiTdX6Q6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206707; x=1791742707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qUQDFYZ38LNpr9WfzaoIX7ySGKszvby265gkxQF4WK0=;
  b=MiTdX6Q6R/zAjqSeS2bqz6JnSO+lVjbu/CGoRS4W48TnANXSK7FbeFq8
   HIHNTysTrwhHCzP1gtYr6N2x0eFio/feVeyFBD5UytM6ahWF0SC67agMj
   jWOkCg+WyPpJSmb2V4GE3mePGb9vm7kjvgiTp1tcN15ClNGhVOTqusLqF
   ueDZKLr7dTfEr95oP3PXRNzKFZfqVSGN5aLDywe826XmjT29nykVCoMh+
   U9I8MAfHqzZxWLRDx+EC8+DhJZRsWw9B7dXqvyz67FsBnLG+HHYrAB479
   +0mKNo9XBbRlGAtlUlqUTEvej+mP00q1dndiGmLH/nY7e+wci1WK/1VQo
   g==;
X-CSE-ConnectionGUID: e2RK1jGJT9eTlAZZ8FMWJQ==
X-CSE-MsgGUID: se6P+xZrTfOL+/m4zXf2xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339748"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339748"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:26 -0700
X-CSE-ConnectionGUID: Lb/G/3cTR6W6ajd8OWjDtQ==
X-CSE-MsgGUID: f0zaj3jsRd+gLA/rNNvR9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487214"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:26 -0700
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
Subject: [PATCH 08/19] sched/fair: Introduce per runqueue task LLC preference counter
Date: Sat, 11 Oct 2025 11:24:45 -0700
Message-Id: <a002ffc53c06bfa0ef0700631b0cb5413bdbf06c.1760206683.git.tim.c.chen@linux.intel.com>
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

Each runqueue is assigned a static array where each element tracks
the number of tasks preferring a given LLC, indexed from 0 to
NR_LLCS.

For example, rq->nr_pref_llc[3] = 2 signifies that there are 2 tasks on
this runqueue which prefer to run within LLC3 (indexed from 0 to NR_LLCS

The load balancer can use this information to identify busy runqueues
and migrate tasks to their preferred LLC domains.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c  | 35 +++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fd315937c0cf..b7a68fe7601b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1235,22 +1235,51 @@ static inline int llc_idx(int cpu)
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
 	if (!sched_cache_enabled())
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
 	if (!sched_cache_enabled())
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
@@ -1524,10 +1553,16 @@ void init_sched_mm(struct task_struct *p)
 
 void reset_llc_stats(struct rq *rq)
 {
+	int i = 0;
+
 	if (!sched_cache_enabled())
 		return;
 
 	rq->nr_llc_running = 0;
+
+	for (i = 0; i < max_llcs; ++i)
+		rq->nr_pref_llc[i] = 0;
+
 	rq->nr_pref_llc_running = 0;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3ab64067acc6..b801d32d5fba 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1101,6 +1101,7 @@ struct rq {
 #ifdef CONFIG_SCHED_CACHE
 	unsigned int		nr_pref_llc_running;
 	unsigned int		nr_llc_running;
+	unsigned int		nr_pref_llc[NR_LLCS];
 #endif
 #ifdef CONFIG_NO_HZ_COMMON
 	unsigned long		last_blocked_load_update_tick;
-- 
2.32.0



Return-Path: <linux-kernel+bounces-849243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C7BCFA97
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4298334A54F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80F2857F8;
	Sat, 11 Oct 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvsjlkoW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7966283FE1
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206707; cv=none; b=Jt9YvY3nM/0EYBih4PVmiKQ2QzO4ZDLh2TKnGqMyWerCIfIM0CWceRhOpjM2iQwiUHzLszpycQZ+UQorhwMqEi3t7Erkuc8eVsgIO7guz2r8zCqiEsDc75hJulbNVOIh4Hf5WtkLCN2FDwtJ+pKaDQzjrmQsv/RTGx24LhvBhds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206707; c=relaxed/simple;
	bh=42DlMZ/oW4HLhFoIJCetdcfblbinqNDtbjQrvZGBme0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrDaFPl16+dUYVfNSWRpTD87yz4MK7/HdghB7ILX5xXggJN8vYLmcy4RQj7oE9weOCdcBzd1EZg476MST0VNTm2z3r/YGhIw0/+VWbtq1PKhfCTIEnPZWnJryrgw70ZRp0r4XDiQwz/h8bzHoZp9hMCEYHtSbHfUHW8eNSYr5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvsjlkoW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206706; x=1791742706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=42DlMZ/oW4HLhFoIJCetdcfblbinqNDtbjQrvZGBme0=;
  b=GvsjlkoWqX+zgP+tTee0MXcNRVBTPQkZKjOLBXZh33p44VICJNCiih6g
   bdtLdnWwRkrJ2u2n2AVNyKIqQq+ELwCHQ1bUAIVe5B+Rq8F/WdKivkeVK
   qCMdNHmRRRa8ijhdo6AEjjUZeHNS6/1dPU14KFq5zOdeXfuxJL5tGjlxb
   ZtqhKFOWrFhhFPJwUw1KWb7C0rBkSGVoUeZH3ORagBu6Ud545g9bPF/M+
   p6sJSBNbnSNsdtDoZzzIKVmezgct+rLH0giyW0IcdjAUJlzYg6VsmVomk
   Zm8UHf1s2hBr8fNdeC7UuXGFmty4d2atXckCM+YB8PsOqI0JwqlHCMSZ2
   A==;
X-CSE-ConnectionGUID: uKPzZGMbTiObyQydogOwGQ==
X-CSE-MsgGUID: QbxPW0yzQ4WA7VOf/APdAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339729"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339729"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:25 -0700
X-CSE-ConnectionGUID: GxY9AWlwTACW1S97eEsWGg==
X-CSE-MsgGUID: +oNXqS3kSkOTENG/ySm5FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487208"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:25 -0700
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
Subject: [PATCH 07/19] sched/fair: Track LLC-preferred tasks per runqueue
Date: Sat, 11 Oct 2025 11:24:44 -0700
Message-Id: <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
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

For each runqueue, track the number of tasks with an LLC preference
and how many of them are running on their preferred LLC. This mirrors
nr_numa_running and nr_preferred_running for NUMA balancing, and will
be used by cache-aware load balancing in later patches.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c  | 12 +++++++++++
 kernel/sched/fair.c  | 47 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  7 +++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 79d15e904d12..5940756e2da3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -529,6 +529,18 @@ void __trace_set_current_state(int state_value)
 }
 EXPORT_SYMBOL(__trace_set_current_state);
 
+#ifdef CONFIG_SMP
+int task_llc(const struct task_struct *p)
+{
+	return per_cpu(sd_llc_id, task_cpu(p));
+}
+#else
+int task_llc(const struct task_struct *p)
+{
+	return 0;
+}
+#endif
+
 /*
  * Serialization rules:
  *
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d6167a029c47..fd315937c0cf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1235,6 +1235,24 @@ static inline int llc_idx(int cpu)
 	return per_cpu(sd_llc_idx, cpu);
 }
 
+static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
+{
+	if (!sched_cache_enabled())
+		return;
+
+	rq->nr_llc_running += (p->preferred_llc != -1);
+	rq->nr_pref_llc_running += (p->preferred_llc == task_llc(p));
+}
+
+static void account_llc_dequeue(struct rq *rq, struct task_struct *p)
+{
+	if (!sched_cache_enabled())
+		return;
+
+	rq->nr_llc_running -= (p->preferred_llc != -1);
+	rq->nr_pref_llc_running -= (p->preferred_llc == task_llc(p));
+}
+
 void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
 {
 	unsigned long epoch;
@@ -1306,6 +1324,8 @@ static unsigned long __no_profile fraction_mm_sched(struct rq *rq, struct mm_sch
 	return div64_u64(NICE_0_LOAD * pcpu_sched->runtime, rq->cpu_runtime + 1);
 }
 
+static unsigned int task_running_on_cpu(int cpu, struct task_struct *p);
+
 static inline
 void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 {
@@ -1347,8 +1367,13 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	if (mm->mm_sched_cpu != -1)
 		mm_sched_llc = per_cpu(sd_llc_id, mm->mm_sched_cpu);
 
-	if (p->preferred_llc != mm_sched_llc)
+	/* task not on rq accounted later in account_entity_enqueue() */
+	if (task_running_on_cpu(rq->cpu, p) &&
+	    p->preferred_llc != mm_sched_llc) {
+		account_llc_dequeue(rq, p);
 		p->preferred_llc = mm_sched_llc;
+		account_llc_enqueue(rq, p);
+	}
 }
 
 static void task_tick_cache(struct rq *rq, struct task_struct *p)
@@ -1497,6 +1522,15 @@ void init_sched_mm(struct task_struct *p)
 	work->next = work;
 }
 
+void reset_llc_stats(struct rq *rq)
+{
+	if (!sched_cache_enabled())
+		return;
+
+	rq->nr_llc_running = 0;
+	rq->nr_pref_llc_running = 0;
+}
+
 #else
 
 static inline void account_mm_sched(struct rq *rq, struct task_struct *p,
@@ -1506,6 +1540,11 @@ void init_sched_mm(struct task_struct *p) { }
 
 static void task_tick_cache(struct rq *rq, struct task_struct *p) { }
 
+static void account_llc_enqueue(struct rq *rq, struct task_struct *p) {}
+
+static void account_llc_dequeue(struct rq *rq, struct task_struct *p) {}
+
+void reset_llc_stats(struct rq *rq) {}
 #endif
 
 /*
@@ -3999,6 +4038,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		struct rq *rq = rq_of(cfs_rq);
 
 		account_numa_enqueue(rq, task_of(se));
+		account_llc_enqueue(rq, task_of(se));
 		list_add(&se->group_node, &rq->cfs_tasks);
 	}
 	cfs_rq->nr_queued++;
@@ -4010,9 +4050,14 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	update_load_sub(&cfs_rq->load, se->load.weight);
 	if (entity_is_task(se)) {
 		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
+		account_llc_dequeue(rq_of(cfs_rq), task_of(se));
 		list_del_init(&se->group_node);
 	}
 	cfs_rq->nr_queued--;
+
+	/* safeguard to clear the cache aware data */
+	if (!parent_entity(se) && !cfs_rq->nr_queued)
+		reset_llc_stats(rq_of(cfs_rq));
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b448ad6dc51d..3ab64067acc6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1098,6 +1098,10 @@ struct rq {
 	unsigned int		nr_preferred_running;
 	unsigned int		numa_migrate_on;
 #endif
+#ifdef CONFIG_SCHED_CACHE
+	unsigned int		nr_pref_llc_running;
+	unsigned int		nr_llc_running;
+#endif
 #ifdef CONFIG_NO_HZ_COMMON
 	unsigned long		last_blocked_load_update_tick;
 	unsigned int		has_blocked_load;
@@ -1952,6 +1956,9 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #endif /* !CONFIG_NUMA_BALANCING */
 
+void reset_llc_stats(struct rq *rq);
+int task_llc(const struct task_struct *p);
+
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct balance_callback *head,
-- 
2.32.0



Return-Path: <linux-kernel+bounces-760943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73C3B1F238
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593833BDA1A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BBF2749D5;
	Sat,  9 Aug 2025 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A43oUD+X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D17157E6B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716215; cv=none; b=YUFlGTDaJF85FWib/Q7a+Wsp38xQlzoRV7AlyUsBs2T1Nm/D3GTDbCOLCu/JYT4Bz1kY7FBLiNzXW6SeRLGEdj+kiCkLEbPCq1Dkw53ko18P2N2wbe+qOYsR7L33XPzRdv8x7pin6JN4QQ3K2vGxPtYxzPr3f13C84cowPsbc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716215; c=relaxed/simple;
	bh=z06d0DcakiSO/sbAcrP1nzo0jya94AyoNYzp6vdKu+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ie5cAVqHtvb8rhtiw/uv2b7q9XOHp9GEaOPJqeh1V5G10tNLgO252LhnRQe82GxwRDsA9JqO8Z/Pn7dGb6/9pzL+eDl4+d0jt7D8uohXyByy5gEgRhnGJ+jOPjC5jrJlsyqSb7bw9iDQtCUKZPX6LrQnQOAMGwjypK1vT60zh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A43oUD+X; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716214; x=1786252214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z06d0DcakiSO/sbAcrP1nzo0jya94AyoNYzp6vdKu+E=;
  b=A43oUD+XrpEd//+VfIwxy0/clww1jBOSaqukWPErBvX/YdTyCblU2SZc
   2RzVMdCc8oIYfY7mAnN+bu4TlDneL5nuPMn8idWsUe/ibRoK5MwcfHrk1
   4wf705GDHnZFwZzx7MaW2tVbkko9eMPuBBX9wEZV9YRSNvgsYWWcfkB9f
   X09DYxiaF6aoyy46GVmca0RePk7ZqdJVl5uzZAHcWSo20QuUXb6HVtKNk
   d843I5ITdrSq6lu1g0W1GAYdjZ+obzYIC4503sdpdA31Ura1IlPBWiexd
   +xto3bCIJV99nwMfneStXQQK9UCe9VrSRX+40SkrUq9jsfJUv0KlPZ3A8
   Q==;
X-CSE-ConnectionGUID: plGWHn/OT2iWZBXIShk1/w==
X-CSE-MsgGUID: HnPTC8sbTiuVF1BIb62/Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68139903"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68139903"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:10:13 -0700
X-CSE-ConnectionGUID: UNc6FU+9Rn6IWN1WcGQpPA==
X-CSE-MsgGUID: H1SRXM8VR6yqBYvNRQaDcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165891283"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2025 22:10:07 -0700
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
Subject: [RFC PATCH v4 10/28] sched: Calculate the number of tasks that have LLC preference on a runqueue
Date: Sat,  9 Aug 2025 13:04:04 +0800
Message-Id: <bd767d696636f233f30f334d41f46ce45c256948.1754712565.git.tim.c.chen@linux.intel.com>
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

Track for each run queue, the number of tasks that have a LLC preference
and how many of those tasks are running in its preferred LLC.  This is
similar to nr_numa_running and nr_preferred_running for NUMA balance,
and will be used by the cache-aware load balancing in subsequent patches.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c  | 12 +++++++++++
 kernel/sched/fair.c  | 51 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  7 ++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a5fb3057b1c4..a97a8039ce91 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -499,6 +499,18 @@ void __trace_set_current_state(int state_value)
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
index 94ad84ba19e1..f964d5a44fcc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1195,6 +1195,24 @@ static inline int llc_idx(int cpu)
 	return per_cpu(sd_llc_idx, cpu);
 }
 
+static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
+{
+	if (!sched_feat(SCHED_CACHE))
+		return;
+
+	rq->nr_llc_running += (p->preferred_llc != -1);
+	rq->nr_pref_llc_running += (p->preferred_llc == task_llc(p));
+}
+
+static void account_llc_dequeue(struct rq *rq, struct task_struct *p)
+{
+	if (!sched_feat(SCHED_CACHE))
+		return;
+
+	rq->nr_llc_running -= (p->preferred_llc != -1);
+	rq->nr_pref_llc_running -= (p->preferred_llc == task_llc(p));
+}
+
 void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
 {
 	unsigned long epoch;
@@ -1303,8 +1321,11 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	if (mm->mm_sched_cpu != -1)
 		mm_sched_llc = per_cpu(sd_llc_id, mm->mm_sched_cpu);
 
-	if (p->preferred_llc != mm_sched_llc)
+	if (p->preferred_llc != mm_sched_llc) {
+		account_llc_dequeue(rq, p);
 		p->preferred_llc = mm_sched_llc;
+		account_llc_enqueue(rq, p);
+	}
 }
 
 static void task_tick_cache(struct rq *rq, struct task_struct *p)
@@ -1408,6 +1429,17 @@ void init_sched_mm(struct task_struct *p)
 	work->next = work;
 }
 
+void reset_llc_stats(struct rq *rq)
+{
+	if (!sched_feat(SCHED_CACHE))
+		return;
+
+	if (rq->nr_llc_running)
+		rq->nr_llc_running = 0;
+
+	rq->nr_pref_llc_running = 0;
+}
+
 #else
 
 static inline void account_mm_sched(struct rq *rq, struct task_struct *p,
@@ -1418,6 +1450,17 @@ void init_sched_mm(struct task_struct *p) { }
 
 static void task_tick_cache(struct rq *rq, struct task_struct *p) { }
 
+static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
+{
+}
+
+static void account_llc_dequeue(struct rq *rq, struct task_struct *p)
+{
+}
+
+void reset_llc_stats(struct rq *rq)
+{
+}
 #endif
 
 static inline
@@ -3957,6 +4000,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		struct rq *rq = rq_of(cfs_rq);
 
 		account_numa_enqueue(rq, task_of(se));
+		account_llc_enqueue(rq, task_of(se));
 		list_add(&se->group_node, &rq->cfs_tasks);
 	}
 #endif
@@ -3970,10 +4014,15 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
+		account_llc_dequeue(rq_of(cfs_rq), task_of(se));
 		list_del_init(&se->group_node);
 	}
 #endif
 	cfs_rq->nr_queued--;
+
+	/* safeguard? */
+	if (!parent_entity(se) && !cfs_rq->nr_queued)
+		reset_llc_stats(rq_of(cfs_rq));
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c37c74dfce25..8026e2c66e9f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1106,6 +1106,10 @@ struct rq {
 	unsigned int		nr_preferred_running;
 	unsigned int		numa_migrate_on;
 #endif
+#ifdef CONFIG_SCHED_CACHE
+	unsigned int		nr_pref_llc_running;
+	unsigned int		nr_llc_running;
+#endif
 #ifdef CONFIG_NO_HZ_COMMON
 #ifdef CONFIG_SMP
 	unsigned long		last_blocked_load_update_tick;
@@ -1967,6 +1971,9 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #endif /* !CONFIG_NUMA_BALANCING */
 
+void reset_llc_stats(struct rq *rq);
+int task_llc(const struct task_struct *p);
+
 #ifdef CONFIG_SMP
 
 static inline void
-- 
2.25.1



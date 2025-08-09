Return-Path: <linux-kernel+bounces-760962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D921B1F24B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985DA586AAC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE62827587D;
	Sat,  9 Aug 2025 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZT0jTXM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE12797BD
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716532; cv=none; b=Q3Lu9iJcgpkY3JofeQsI3NuQ1TQam6CIlO+tdvTSCRjGAjVblky3W53EIomiHy80dmktuPQdtHxgcRNWPE+j/bg5BQe6GDtHnoJUJTNFKCR/9DYjJgajvDVOAMxm+f5X8nLVN12/qTm5fIAB7ohPRpMT5XEfcEaB2rgn4WdJjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716532; c=relaxed/simple;
	bh=Qnj+s91JA/iUJUPb0vlHFoRsDjRZdaL0BuPbFnDHlf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Id7UAlt3jf4R+5/V26lYDKIMUvQ2sWz1U1L6PxHG7qpC1Y2DBCKgalLglN7phNtyW+llMFcUZ8TM/8hPX4zlNTja13GIfazsivILfGOPcNG17Rvk+pJ6zxYEFCqME/cFa0umvr+QT0QzQ/sIQRDaZpzSMHofa4VucqncRSPHNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZT0jTXM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716528; x=1786252528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qnj+s91JA/iUJUPb0vlHFoRsDjRZdaL0BuPbFnDHlf4=;
  b=KZT0jTXMrwi6hPfQPUBt2UhPb6fUrWeb/O3CDNims/uo7a2fRVzB96ni
   iAcBIq7cRPl82Mb6WAlg3t8qyCFKa4+mARu2XOEG/1TlTOTPJpPcEFd23
   uyE/VkcDEWP2Pk6IHBPTbmMmpwS9xu2Sc2pif7fu4IJ95Ou4he7GApWaO
   MXcgjRuqD2lXHrJW2ZCh04Xx6L3C8w5eBUkk3oAlp2wVkN4HgtgEp9ORv
   Z96q81Q0Wd5WaHbBqUBeZQ2vuQf9nOsBlZZ3rd4ahEG7C3LjJGEU6HHLi
   KLNOB6OypoKBQux1+HQWGMGe9cMObuKZXq8mFwxxNatSDn+GrcGALRB6K
   A==;
X-CSE-ConnectionGUID: jbgqMP0qR/OvQDc48pzOPw==
X-CSE-MsgGUID: hEeOV4ycSKW7r3RHicCLKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68514913"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68514913"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:15:27 -0700
X-CSE-ConnectionGUID: RhK2nh/kRuuYh7KksFDbdw==
X-CSE-MsgGUID: nLJQ9FRIRdmfFlE8PcQEEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166275369"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2025 22:15:20 -0700
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
Subject: [RFC PATCH v4 28/28] sched: Add ftrace to track cache aware load balance and hottest CPU changes
Date: Sat,  9 Aug 2025 13:09:17 +0800
Message-Id: <3e3622a5b2129b56741989f15a8debabec064de9.1754712565.git.tim.c.chen@linux.intel.com>
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

Introduce 3 trace events:

1.
The average time spent scanning CPUs and calculating occupancy
in each sample period. This event can be used to track the
overhead of cache-aware scheduling.

2.
The footprint when switching to a new mm_sched_cpu (a cache-hot CPU).
This event can be used to track whether there is any abnormal
bouncing of mm_sched_cpu.

3.
The footprint of load balancing when migrating a task between CPUs.
This event can be used to track whether cache-aware load balancing
behaves as expected.

All these events can be used with bpftrace to gain a basic
understanding of whether cache-aware scheduling is effective.

Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/trace/events/sched.h | 93 ++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c          | 25 ++++++++--
 2 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3..398180c18946 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -10,6 +10,99 @@
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
 
+TRACE_EVENT(sched_scan_cost,
+
+	TP_PROTO(struct task_struct *t, u64 cost, int nr,
+		 u64 old_running, u64 new_running),
+
+	TP_ARGS(t, cost, nr, old_running, new_running),
+
+	TP_STRUCT__entry(
+		__array(	char,	comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	pid			)
+		__field(	u64,	cost			)
+		__field(	int,	nr			)
+		__field(	u64,	old_running		)
+		__field(	u64,	new_running		)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->pid	= t->pid;
+		__entry->cost	= cost;
+		__entry->nr	= nr;
+		__entry->old_running	= old_running;
+		__entry->new_running	= new_running;
+	),
+
+	TP_printk("comm=%s pid=%d cost=%llu nr=%d old_r=%lld new_r=%lld",
+		  __entry->comm, __entry->pid,
+		  __entry->cost, __entry->nr,
+		  __entry->old_running, __entry->new_running)
+);
+
+TRACE_EVENT(sched_cache_work,
+
+	TP_PROTO(struct task_struct *t, int pref_cpu, int pref_llc,
+		 int new_cpu, int new_llc),
+
+	TP_ARGS(t, pref_cpu, pref_llc, new_cpu, new_llc),
+
+	TP_STRUCT__entry(
+		__array(	char,	comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	pid			)
+		__field(	int,	pref_cpu		)
+		__field(	int,	pref_llc		)
+		__field(	int,	new_cpu			)
+		__field(	int,	new_llc			)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->pid	= t->pid;
+		__entry->pref_cpu	= pref_cpu;
+		__entry->pref_llc	= pref_llc;
+		__entry->new_cpu	= new_cpu;
+		__entry->new_llc	= new_llc;
+	),
+
+	TP_printk("comm=%s pid=%d pref_cpu=%d pref_llc=%d attach_cpu=%d attach_llc=%d",
+		  __entry->comm, __entry->pid,
+		  __entry->pref_cpu, __entry->pref_llc,
+		  __entry->new_cpu, __entry->new_llc)
+);
+
+TRACE_EVENT(sched_attach_task,
+
+	TP_PROTO(struct task_struct *t, int pref_cpu, int pref_llc,
+		 int attach_cpu, int attach_llc),
+
+	TP_ARGS(t, pref_cpu, pref_llc, attach_cpu, attach_llc),
+
+	TP_STRUCT__entry(
+		__array(	char,	comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	pid			)
+		__field(	int,	pref_cpu		)
+		__field(	int,	pref_llc		)
+		__field(	int,	attach_cpu		)
+		__field(	int,	attach_llc		)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->pid	= t->pid;
+		__entry->pref_cpu	= pref_cpu;
+		__entry->pref_llc	= pref_llc;
+		__entry->attach_cpu	= attach_cpu;
+		__entry->attach_llc	= attach_llc;
+	),
+
+	TP_printk("comm=%s pid=%d pref_cpu=%d pref_llc=%d attach_cpu=%d attach_llc=%d",
+		  __entry->comm, __entry->pid,
+		  __entry->pref_cpu, __entry->pref_llc,
+		  __entry->attach_cpu, __entry->attach_llc)
+);
+
 /*
  * Tracepoint for calling kthread_stop, performed to end a kthread:
  */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 018825f04063..cb2c33ee0d92 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1467,8 +1467,9 @@ static void __no_profile task_cache_work(struct callback_head *work)
 	unsigned long last_m_a_occ = 0;
 	int cpu, m_a_cpu = -1, cache_cpu,
 	    pref_nid = NUMA_NO_NODE, curr_cpu = smp_processor_id(),
-	    nr_running = 0;
+	    nr_running = 0, nr_scan = 0;
 	cpumask_var_t cpus;
+	u64 t0, scan_cost = 0;
 
 	WARN_ON_ONCE(work != &p->cache_work);
 
@@ -1499,6 +1500,7 @@ static void __no_profile task_cache_work(struct callback_head *work)
 		pref_nid = p->numa_preferred_nid;
 #endif
 
+	t0 = sched_clock_cpu(curr_cpu);
 	scoped_guard (cpus_read_lock) {
 		get_scan_cpumasks(cpus, cache_cpu,
 				  pref_nid, curr_cpu);
@@ -1521,6 +1523,7 @@ static void __no_profile task_cache_work(struct callback_head *work)
 					m_cpu = i;
 				}
 				nr++;
+				nr_scan++;
 
 				rcu_read_lock();
 				cur = rcu_dereference(cpu_rq(i)->curr);
@@ -1529,8 +1532,8 @@ static void __no_profile task_cache_work(struct callback_head *work)
 					nr_running++;
 				rcu_read_unlock();
 
-				trace_printk("(%d) occ: %ld m_occ: %ld m_cpu: %d nr: %d\n",
-					     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
+				//trace_printk("(%d) occ: %ld m_occ: %ld m_cpu: %d nr: %d\n",
+				//	     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
 			}
 
 			// a_occ /= nr;
@@ -1541,8 +1544,8 @@ static void __no_profile task_cache_work(struct callback_head *work)
 			if (llc_id(cpu) == llc_id(mm->mm_sched_cpu))
 				last_m_a_occ = a_occ;
 
-			trace_printk("(%d) a_occ: %ld m_a_occ: %ld\n",
-				     per_cpu(sd_llc_id, cpu), a_occ, m_a_occ);
+			//trace_printk("(%d) a_occ: %ld m_a_occ: %ld\n",
+			//	     per_cpu(sd_llc_id, cpu), a_occ, m_a_occ);
 
 			for_each_cpu(i, sched_domain_span(sd)) {
 				/* XXX threshold ? */
@@ -1553,12 +1556,17 @@ static void __no_profile task_cache_work(struct callback_head *work)
 		}
 	}
 
+	scan_cost = sched_clock_cpu(curr_cpu) - t0;
+
 	if (m_a_occ > (2 * last_m_a_occ)) {
 		/* avoid the bouncing of mm_sched_cpu */
+		trace_sched_cache_work(p, mm->mm_sched_cpu, llc_id(mm->mm_sched_cpu),
+					m_a_cpu, llc_id(m_a_cpu));
 		mm->mm_sched_cpu = m_a_cpu;
 	}
 
 	update_avg(&mm->nr_running_avg, nr_running);
+	trace_sched_scan_cost(p, scan_cost, nr_scan, mm->nr_running_avg, nr_running);
 	free_cpumask_var(cpus);
 }
 
@@ -10443,6 +10451,13 @@ static void attach_task(struct rq *rq, struct task_struct *p)
 {
 	lockdep_assert_rq_held(rq);
 
+#ifdef CONFIG_SCHED_CACHE
+	if (p->mm)
+		trace_sched_attach_task(p,
+					p->mm->mm_sched_cpu,
+					p->mm->mm_sched_cpu != -1 ? llc_id(p->mm->mm_sched_cpu) : -1,
+					cpu_of(rq), llc_id(cpu_of(rq)));
+#endif
 	WARN_ON_ONCE(task_rq(p) != rq);
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
 	wakeup_preempt(rq, p, 0);
-- 
2.25.1



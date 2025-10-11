Return-Path: <linux-kernel+bounces-849252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D3BCFAC0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E27E54EDAE1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8132328C864;
	Sat, 11 Oct 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQVK1fUD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F11288C02
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206715; cv=none; b=msFA8TC41v9oEIuXxPkwmaUs9Guya5oz4k0g+kGWjFkx5t6zbq1fE/hqkiyOdPEhHS8cUTNX+aARYrbMu+YFzDRmUGhKnyOYkbiJD/UnEPwa2emEYG8RrqlU6lMxzm4wiDBJLxqnLLfKGSPXyWwXrM560Mia1tgl6K9uKsnEgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206715; c=relaxed/simple;
	bh=Tofl2LDuzdO5QbpLjDZ3W55iV9tdiYron5fWReifyPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIYwSq6151qmo6KEbEr6KofmYMtBvZvl9VphDwsqPX3hTLP897hu66I6LFuek1xE2EdzY5hJ64po/YPEKcNn99hwknIHDQx8uamJBxPh8I2WV7/JQ8MBTxUclp3YSgTWiAJSRjNR9EBM7PkdUJqtsU69m11ei/HsbibGYzaOOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQVK1fUD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206714; x=1791742714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tofl2LDuzdO5QbpLjDZ3W55iV9tdiYron5fWReifyPw=;
  b=TQVK1fUDtuFQmuxj0h/H6B3W/u2cJ2GkGOiUH7Lt/dRtHWxu09UqD683
   GE9GznGGwwF/Ima7vRS1ctHwsI6Xpw4SijdVGn66soleS5/ydNjcGaSKg
   ygudPZpTfNaQrBfM0sFvdqPmdg50LMShstL+8pxYWf160UzvXjzOECyon
   VuIxmxxlfPMnN2wMIOyjbQiDBL/LsnnHbGArR4IFK3zGWts6KMkvPzkiR
   EwWOPnHMmqriXFYLM8wcDjSverDfcRP6MlQsXXusYG7bdxJhhuwymEiBB
   InFNxWr5/xEksEDfouM5jLx/TVwLUkF4o8vAQ8HbkYgDi57JrvvbuA4Mr
   g==;
X-CSE-ConnectionGUID: dN0cE9kLQ3yeKYNXwwT83A==
X-CSE-MsgGUID: KDX51V55RvaEAIpyi8Kcxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339905"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339905"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:34 -0700
X-CSE-ConnectionGUID: SHt2rwkJR6+JML7EmRAXVw==
X-CSE-MsgGUID: 7457bVysSBes9Wezrb15EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487250"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:33 -0700
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
Subject: [PATCH 16/19] sched/fair: Exclude processes with many threads from cache-aware scheduling
Date: Sat, 11 Oct 2025 11:24:53 -0700
Message-Id: <637cdb8ab11b1b978d697ed744cc402d32443ecc.1760206683.git.tim.c.chen@linux.intel.com>
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

A performance regression was observed by Prateek when running hackbench
with many threads per process (high fd count). To avoid this, processes
with a large number of active threads are excluded from cache-aware
scheduling.

With sched_cache enabled, record the number of active threads in each
process during the periodic task_cache_work(). While iterating over
CPUs, if the currently running task belongs to the same process as the
task that launched task_cache_work(), increment the active thread count.

If the count exceeds the number of CPUs in the process's preferred LLC,
sched_cache will avoid aggregating too many threads into a single LLC
domain.

Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3ca557c2f36d..b307f81b2fde 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1031,6 +1031,7 @@ struct mm_struct {
 		raw_spinlock_t mm_sched_lock;
 		unsigned long mm_sched_epoch;
 		int mm_sched_cpu;
+		u64 nr_running_avg ____cacheline_aligned_in_smp;
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 65ff7c306a2f..79d109f8a09f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1451,12 +1451,13 @@ static void get_scan_cpumasks(cpumask_var_t cpus, int cache_cpu,
 
 static void __no_profile task_cache_work(struct callback_head *work)
 {
-	struct task_struct *p = current;
+	struct task_struct *p = current, *cur;
 	struct mm_struct *mm = p->mm;
 	unsigned long m_a_occ = 0;
 	unsigned long curr_m_a_occ = 0;
 	int cpu, m_a_cpu = -1, cache_cpu,
-	    pref_nid = NUMA_NO_NODE, curr_cpu;
+	    pref_nid = NUMA_NO_NODE, curr_cpu,
+	    nr_running = 0;
 	cpumask_var_t cpus;
 
 	WARN_ON_ONCE(work != &p->cache_work);
@@ -1497,6 +1498,14 @@ static void __no_profile task_cache_work(struct callback_head *work)
 					m_occ = occ;
 					m_cpu = i;
 				}
+
+				rcu_read_lock();
+				cur = rcu_dereference(cpu_rq(i)->curr);
+				if (cur && !(cur->flags & (PF_EXITING | PF_KTHREAD)) &&
+				    cur->mm == mm)
+					nr_running++;
+				rcu_read_unlock();
+
 			}
 
 			/*
@@ -1540,6 +1549,7 @@ static void __no_profile task_cache_work(struct callback_head *work)
 		mm->mm_sched_cpu = m_a_cpu;
 	}
 
+	update_avg(&mm->nr_running_avg, nr_running);
 	free_cpumask_var(cpus);
 }
 
-- 
2.32.0



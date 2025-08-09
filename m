Return-Path: <linux-kernel+bounces-760958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E68DB1F247
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA52581910
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776E275B0F;
	Sat,  9 Aug 2025 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmFy4oU1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057372472BA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716474; cv=none; b=VIfN6Nj+OmuTvjcAQC5ue6+EJDcsfkI76dqTW3x38qtgbZ4hqzLAXpZlXfM9DlKB8dKo57i5wMslwoWbzJnvNz1ykOFHxPfoi2S93m+jstGBBseKp1ztbQwQ2K61GTrnAqbJdZm7pnjXyKLjWHy5vyrtWh/xw7PspOvnpd6AKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716474; c=relaxed/simple;
	bh=FSWaU6wjxtUO8jXpCphgNEzz4lxAHBHSTH4IiVUyBUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjsKAevWGzT+p1INgbZoPieajKhnft6CnQg6Bbk4u1Z+7t5XRC0bswqFYNyS3V/ZFpoWqhCw4RYtVBZI+9IiO7g1Q46JsT7+09UPlrjZPLkzbNiFJI/DRRGFHTenkxTcke+8xYuOm3RbKap9vjHJ6muwNQMS05rVf9nebWSot00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmFy4oU1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716473; x=1786252473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FSWaU6wjxtUO8jXpCphgNEzz4lxAHBHSTH4IiVUyBUk=;
  b=gmFy4oU1sZtwQyMYwHB8SIoIYYE5hI8m7TFKqp6zqiVd8rnbxM1bMhLC
   74RYM+I/O6xKXfeu/UVzPgl1+lq9og33Njeix9LSwjF6dc54BAfz6kZpm
   XSL2l8zGvHKS024WUDTZLsjKB3ozB4WcNBoQCDO/MuFQPfhhiy+fkzGjd
   GRjfmZ2nZEDzv9f+jC+e5CY8l12nBabKfqFG4La0LMDW1GFk7YsYd275+
   ppat6y66psYB1mii4x1wz+0D3WFtxDecRb9O1Al2JUDYi696b9W2OMbl/
   S6cwP0rZ5li5OyXKhxjLqGgxHrmb3hYgWbTMhafNcMH8p7GmxPK8BizEQ
   Q==;
X-CSE-ConnectionGUID: hfmQ09kFSka1PTGb3z++tA==
X-CSE-MsgGUID: jqX5qpmwT2awTicWyNB8Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60860082"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60860082"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:14:32 -0700
X-CSE-ConnectionGUID: UKKGkDsGRSSXIWvNvv1UIw==
X-CSE-MsgGUID: AYQBgKAjRwGDzbPfQLudxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="169693165"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa003.jf.intel.com with ESMTP; 08 Aug 2025 22:14:26 -0700
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
Subject: [RFC PATCH v4 24/28] sched: Record average number of runninhg tasks per process
Date: Sat,  9 Aug 2025 13:08:23 +0800
Message-Id: <f76bd466650791d1d4893bb66d973dc2861f473f.1754712565.git.tim.c.chen@linux.intel.com>
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

Performance regression was found when running hackbench
with many threads per process(the fd number is high).
To avoid this regression, process having a large number
of active threads should be excluded from cache aware
scheduling.

With sched_cache enabled, record the number of active threads within
the process. This calculation occurs in the periodic task_cache_work():
when iterating over the CPUs, check the currently running task on that
CPU; if the running task belongs to the same process as the task that
launches task_cache_work(), increment the active thread count by 1.

If the number exceeds the number of CPUs in the preferred LLC,
sched_cache is prevented from aggregating too many threads in one
LLC domain.

Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 41a598a44361..13b715357ccb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1033,6 +1033,7 @@ struct mm_struct {
 		raw_spinlock_t mm_sched_lock;
 		unsigned long mm_sched_epoch;
 		int mm_sched_cpu;
+		u64 nr_running_avg;
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 420d3a080990..2577b4225c3f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1414,12 +1414,13 @@ static void get_scan_cpumasks(cpumask_var_t cpus, int cache_cpu,
 
 static void __no_profile task_cache_work(struct callback_head *work)
 {
-	struct task_struct *p = current;
+	struct task_struct *p = current, *cur;
 	struct mm_struct *mm = p->mm;
 	unsigned long m_a_occ = 0;
 	unsigned long last_m_a_occ = 0;
 	int cpu, m_a_cpu = -1, cache_cpu,
-	    pref_nid = NUMA_NO_NODE, curr_cpu = smp_processor_id();
+	    pref_nid = NUMA_NO_NODE, curr_cpu = smp_processor_id(),
+	    nr_running = 0;
 	cpumask_var_t cpus;
 
 	WARN_ON_ONCE(work != &p->cache_work);
@@ -1460,6 +1461,14 @@ static void __no_profile task_cache_work(struct callback_head *work)
 					m_cpu = i;
 				}
 				nr++;
+
+				rcu_read_lock();
+				cur = rcu_dereference(cpu_rq(i)->curr);
+				if (cur && !(cur->flags & (PF_EXITING | PF_KTHREAD)) &&
+				    cur->mm == mm)
+					nr_running++;
+				rcu_read_unlock();
+
 				trace_printk("(%d) occ: %ld m_occ: %ld m_cpu: %d nr: %d\n",
 					     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
 			}
@@ -1489,6 +1498,7 @@ static void __no_profile task_cache_work(struct callback_head *work)
 		mm->mm_sched_cpu = m_a_cpu;
 	}
 
+	update_avg(&mm->nr_running_avg, nr_running);
 	free_cpumask_var(cpus);
 }
 
-- 
2.25.1



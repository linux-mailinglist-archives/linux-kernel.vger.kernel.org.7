Return-Path: <linux-kernel+bounces-889519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C73A0C3DD01
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65D154ED92D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABBC3570B1;
	Thu,  6 Nov 2025 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMZOy2vj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567C3563C2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471228; cv=none; b=Z60T3vhKzqTHarrZbZy4ISsctf5iUeFCKABh3K8iTNZzXtnHARPithZEALExgZ0PEbRdcW5coD0szMf1/T1HqfW9KhqOzgX+rKVqv2ncXVExjbP1tsz1dKBaQyjaHZgNCQ8Pfzv7m4cddZBz0BjenIJAYEMX6Zwj7rIcBRgbP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471228; c=relaxed/simple;
	bh=T3RJFoH+nuwdeanLQGJHH7JSy/tIyQuVHHfys3kvoXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/iC1RKQBP1Tbb5mRmwN0FWjgG7S6VCTP74dNkbpKwmO0D1v5mIwR5S7QXNKJxVA54u25HheYWo19JN2SpIPWPfkVPfBueN2Lxo0kxbo2Cp3ttcaiVyOIbGiozMCRA4NaG+aRkLxc7zVNXdcFdeB1pZxegHSAx0aq7+KO6e2mxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMZOy2vj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762471226; x=1794007226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T3RJFoH+nuwdeanLQGJHH7JSy/tIyQuVHHfys3kvoXo=;
  b=iMZOy2vjDZNkF7Esasa5AjusGXXpsSv3bdFh+8xgx4LfyDacXoecDy1s
   DmMyGEWGv5OAPa9Ff6NgVyF6dfVkdKh3B7eNwYjIrJXtpKd/afgPbGBLP
   NyKrqIJLrDtlkdXU+i812YHK8XDIHxPDgxOc+P8PzDjfAkFb/MuGVHnVg
   94b3VG6sUgsSexjUxUNzGtBvFdA2vhRxa4fATema/spk8y/N+gCp0WUOy
   JpAeyoMLHQ634TROPYp/SoDUVTJcPLI8WWgnxAepD2YFq1iOPe3w4OW8q
   +se10eEBmF83juKML/777O8KGLRV1jnaAptBz/KuXoIaA/U7/BGXl0hmr
   A==;
X-CSE-ConnectionGUID: 7T3Y8mfxRQ6MiYe+4xoYVQ==
X-CSE-MsgGUID: u9EhERobQoCa6zJNPz1rvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="75311748"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="75311748"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 15:20:25 -0800
X-CSE-ConnectionGUID: R1GT/0trQUGRMNFJE+V8qg==
X-CSE-MsgGUID: jc4BtH3iSmibiBonSf/5Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="191988067"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa003.jf.intel.com with ESMTP; 06 Nov 2025 15:20:25 -0800
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Chen Yu <yu.c.chen@intel.com>,
	Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v3] sched/fair: Skip sched_balance_running cmpxchg when balance is not due
Date: Thu,  6 Nov 2025 15:27:02 -0800
Message-Id: <52fcd1e8582a6b014a70f0ce7795ce0d88cd63a8.1762470554.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NUMA sched domain sets the SD_SERIALIZE flag by default, allowing
only one NUMA load balancing operation to run system-wide at a time.

Currently, each sched group leader directly under NUMA domain attempts
to acquire the global sched_balance_running flag via cmpxchg() before
checking whether load balancing is due or whether it is the designated
load balancer for that NUMA domain. On systems with a large number
of cores, this causes significant cache contention on the shared
sched_balance_running flag.

This patch reduces unnecessary cmpxchg() operations by first checking
that the balancer is the designated leader for a NUMA domain from
should_we_balance(), and the balance interval has expired before
trying to acquire sched_balance_running to load balance a NUMA
domain.

On a 2-socket Granite Rapids system with sub-NUMA clustering enabled,
running an OLTP workload, 7.8% of total CPU cycles were previously spent
in sched_balance_domain() contending on sched_balance_running before
this change.

         : 104              static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
         : 105              {
         : 106              return arch_cmpxchg(&v->counter, old, new);
    0.00 :   ffffffff81326e6c:       xor    %eax,%eax
    0.00 :   ffffffff81326e6e:       mov    $0x1,%ecx
    0.00 :   ffffffff81326e73:       lock cmpxchg %ecx,0x2394195(%rip)        # ffffffff836bb010 <sched_balance_running>
         : 110              sched_balance_domains():
         : 12234            if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
   99.39 :   ffffffff81326e7b:       test   %eax,%eax
    0.00 :   ffffffff81326e7d:       jne    ffffffff81326e99 <sched_balance_domains+0x209>
         : 12238            if (time_after_eq(jiffies, sd->last_balance + interval)) {
    0.00 :   ffffffff81326e7f:       mov    0x14e2b3a(%rip),%rax        # ffffffff828099c0 <jiffies_64>
    0.00 :   ffffffff81326e86:       sub    0x48(%r14),%rax
    0.00 :   ffffffff81326e8a:       cmp    %rdx,%rax

After applying this fix, sched_balance_domain() is gone from the profile
and there is a 5% throughput improvement.

Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Mohini Narkhede <mohini.narkhede@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

---
v3:
1. Move check balance time to after should_we_balance()
link to v2: https://lore.kernel.org/lkml/248b775fc9030989c829d4061f6f85ae33dabe45.1761682932.git.tim.c.chen@linux.intel.com/

v2:
1. Rearrange the patch to get rid of an indent level per Peter's
   suggestion.
2. Updated the data from new run by OLTP team.

link to v1: https://lore.kernel.org/lkml/e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com/

---
 kernel/sched/fair.c | 56 ++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..c3bbff9b582d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11732,6 +11732,21 @@ static void update_lb_imbalance_stat(struct lb_env *env, struct sched_domain *sd
 	}
 }
 
+/*
+ * This flag serializes load-balancing passes over large domains
+ * (above the NODE topology level) - only one load-balancing instance
+ * may run at a time, to reduce overhead on very large systems with
+ * lots of CPUs and large NUMA distances.
+ *
+ * - Note that load-balancing passes triggered while another one
+ *   is executing are skipped and not re-tried.
+ *
+ * - Also note that this does not serialize rebalance_domains()
+ *   execution, as non-SD_SERIALIZE domains will still be
+ *   load-balanced in parallel.
+ */
+static atomic_t sched_balance_running = ATOMIC_INIT(0);
+
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -11757,6 +11772,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
 	};
+	int need_unlock = false;
 
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
 
@@ -11768,6 +11784,13 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		goto out_balanced;
 	}
 
+	if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
+		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
+			goto out_balanced;
+		}
+		need_unlock = true;
+	}
+
 	group = sched_balance_find_src_group(&env);
 	if (!group) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
@@ -11892,6 +11915,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
 				env.loop_break = SCHED_NR_MIGRATE_BREAK;
+				if (need_unlock)
+					atomic_set_release(&sched_balance_running, 0);
+
 				goto redo;
 			}
 			goto out_all_pinned;
@@ -12008,6 +12034,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
 out:
+	if (need_unlock)
+		atomic_set_release(&sched_balance_running, 0);
+
 	return ld_moved;
 }
 
@@ -12132,21 +12161,6 @@ static int active_load_balance_cpu_stop(void *data)
 	return 0;
 }
 
-/*
- * This flag serializes load-balancing passes over large domains
- * (above the NODE topology level) - only one load-balancing instance
- * may run at a time, to reduce overhead on very large systems with
- * lots of CPUs and large NUMA distances.
- *
- * - Note that load-balancing passes triggered while another one
- *   is executing are skipped and not re-tried.
- *
- * - Also note that this does not serialize rebalance_domains()
- *   execution, as non-SD_SERIALIZE domains will still be
- *   load-balanced in parallel.
- */
-static atomic_t sched_balance_running = ATOMIC_INIT(0);
-
 /*
  * Scale the max sched_balance_rq interval with the number of CPUs in the system.
  * This trades load-balance latency on larger machines for less cross talk.
@@ -12202,7 +12216,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 	/* Earliest time when we have to do rebalance again */
 	unsigned long next_balance = jiffies + 60*HZ;
 	int update_next_balance = 0;
-	int need_serialize, need_decay = 0;
+	int need_decay = 0;
 	u64 max_cost = 0;
 
 	rcu_read_lock();
@@ -12226,13 +12240,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 
 		interval = get_sd_balance_interval(sd, busy);
-
-		need_serialize = sd->flags & SD_SERIALIZE;
-		if (need_serialize) {
-			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
-				goto out;
-		}
-
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
 			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
 				/*
@@ -12246,9 +12253,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 			sd->last_balance = jiffies;
 			interval = get_sd_balance_interval(sd, busy);
 		}
-		if (need_serialize)
-			atomic_set_release(&sched_balance_running, 0);
-out:
 		if (time_after(next_balance, sd->last_balance + interval)) {
 			next_balance = sd->last_balance + interval;
 			update_next_balance = 1;
-- 
2.32.0



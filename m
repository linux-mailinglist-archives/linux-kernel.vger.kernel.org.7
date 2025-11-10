Return-Path: <linux-kernel+bounces-893903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D30C489F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8923A878E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE118C26;
	Mon, 10 Nov 2025 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2IcJZRh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48A27B345
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800055; cv=none; b=LQSGIoVpqck/Q8B9Hz+RlonXUtJvHjMoG2B01P3XaQUk5pZjApwrHVBu09GehDv1SAZOmwFCFwOWMKh+Tqkno+TwKxoTODrkB8HlMqkXxlMkiJvsPQsPtHDDVmeVXSKsMC5l2QrQRGB6YqhIvR5aT4aWZc4fj3Rymnp+fLAkf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800055; c=relaxed/simple;
	bh=8rZZMh889EnA9nlAve+yXj47Rh7/pDgM7wMNGTbOqow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iLzqTb9jKijlybNSY9IS5nJ8FmRj7Gw/le+WMxp2R+ZdXdMIB8aBEx4a/6No1L70N67h6i2L3JdK0Vf4CPWPyiQbTI9NCgPEB3V5BRFEtH4ORJh6PFBhm79EOXTpH1WHzcxWmUIuAbP4iu+zyR2n2piNXiWHZspM1Sx6Fgkrjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2IcJZRh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762800054; x=1794336054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8rZZMh889EnA9nlAve+yXj47Rh7/pDgM7wMNGTbOqow=;
  b=l2IcJZRhvnOuqcbBFPb+Pp8NQSLBnN86s0rDuxMq1QcvgrSb6LSUveUz
   1b4lExojdRbIKa14DqgeO1nDC0y/OKmo2aXJ43BuYd09sjSsEZxGsZW5Z
   6bCuj5W6g1q3Smazt2WZ1J5pNh/OmSFba9pghiBDH4FcDXQS8t/1Z7GUO
   /GPiMlR/F8tp+YP2259DQqTwQqEcc6V0ZJLV7Agpu9VxdjPqj0P7RpEnB
   q0cKvoRJAwiZYx96K4Cz/L935qkxR67+rsWNiBsvdEKf91suA7MdLvJ34
   mqSR95MKjVpo9pLD8IDhpKrfTRufSg00foD+LjdGLuC9cCE/SHC4tGSMq
   A==;
X-CSE-ConnectionGUID: JeF26OBbR0C/sJ+o/x9/vQ==
X-CSE-MsgGUID: sskPRlERT3CgI88HDlZZjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="63861327"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="63861327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 10:40:53 -0800
X-CSE-ConnectionGUID: P0wSgfDpQnKP/u/ntVMYYw==
X-CSE-MsgGUID: fcZZ3wpoQk2Jry4uZK0bhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="192850826"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa003.jf.intel.com with ESMTP; 10 Nov 2025 10:40:53 -0800
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
Subject: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when balance is not due
Date: Mon, 10 Nov 2025 10:47:35 -0800
Message-Id: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
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
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Mohini Narkhede <mohini.narkhede@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

---
v4:
1. Allow NEWLY_IDLE balance with SD_SERIALIZE domain to be serialized.
2. Reorganize need_unlock to be bool and initialize it again for the
   redo case.
link to v3: https://lore.kernel.org/lkml/52fcd1e8582a6b014a70f0ce7795ce0d88cd63a8.1762470554.git.tim.c.chen@linux.intel.com/

v3:
1. Move check balance time to after should_we_balance()
link to v2: https://lore.kernel.org/lkml/248b775fc9030989c829d4061f6f85ae33dabe45.1761682932.git.tim.c.chen@linux.intel.com/

v2:
1. Rearrange the patch to get rid of an indent level per Peter's
   suggestion.
2. Updated the data from new run by OLTP team.

link to v1: https://lore.kernel.org/lkml/e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com/

---
 kernel/sched/fair.c | 57 ++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..43c5ec039633 100644
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
@@ -11757,17 +11772,26 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
 	};
+	bool need_unlock;
 
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
 
 	schedstat_inc(sd->lb_count[idle]);
 
 redo:
+	need_unlock = false;
 	if (!should_we_balance(&env)) {
 		*continue_balancing = 0;
 		goto out_balanced;
 	}
 
+	if (sd->flags & SD_SERIALIZE) {
+		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
+			goto out_balanced;
+		}
+		need_unlock = true;
+	}
+
 	group = sched_balance_find_src_group(&env);
 	if (!group) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
@@ -11892,6 +11916,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
 				env.loop_break = SCHED_NR_MIGRATE_BREAK;
+				if (need_unlock)
+					atomic_set_release(&sched_balance_running, 0);
+
 				goto redo;
 			}
 			goto out_all_pinned;
@@ -12008,6 +12035,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
 out:
+	if (need_unlock)
+		atomic_set_release(&sched_balance_running, 0);
+
 	return ld_moved;
 }
 
@@ -12132,21 +12162,6 @@ static int active_load_balance_cpu_stop(void *data)
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
@@ -12202,7 +12217,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 	/* Earliest time when we have to do rebalance again */
 	unsigned long next_balance = jiffies + 60*HZ;
 	int update_next_balance = 0;
-	int need_serialize, need_decay = 0;
+	int need_decay = 0;
 	u64 max_cost = 0;
 
 	rcu_read_lock();
@@ -12226,13 +12241,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
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
@@ -12246,9 +12254,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
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



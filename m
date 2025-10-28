Return-Path: <linux-kernel+bounces-874635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C190EC16BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC143A54FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5578267B89;
	Tue, 28 Oct 2025 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkAvcBCU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DCC8CE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682610; cv=none; b=DhvF+m+5VzgruaReZZQFykmazVt8haN8XZrrFCzGHOKkYapETLUAQj74H/GlOqC05kDR2hSBoRDA4E8fUvwBH6vITR1/K1XAILqcD0ZKQ66UR6hAV8KjS1Y/41YfTaY4xLsb+OWM6AlQ46/r6KvMO8SiJWTHe4P1C7SWLlF2kz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682610; c=relaxed/simple;
	bh=bjWoD/QQIw7BZqWjVxwtv5BSU1enw2Lp1vGiEuHB1fM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CtcFEj56mQVb4vy1cPe+sTfDB/ZaEaPJyNCxf4ypR1qMJUm6rJyG8AgD3nRBCxZWKh8KOVOGR19LBVidljX/4i9z49CkFcDZedrpjbJfUKf25uxOfKf09ETTfX0ZhSIS0SmwqruAdImPVIrHX7zPqMY9keTazXSwzkWHvlIvjhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkAvcBCU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761682608; x=1793218608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bjWoD/QQIw7BZqWjVxwtv5BSU1enw2Lp1vGiEuHB1fM=;
  b=GkAvcBCUde1pnYZRQ8zNGCJhx/VPyQZScf8MSv8j9m3oslyNu3yd+HoL
   vurK8C7rzC8jCZHe8UiUAE5k0PjpFV+dp9/KuIyDLfNtXY7ntWTvslHpe
   eUnPh/Xw5cU1sBKROm3H3m/ZrlnJvivEbbmGNP/kABrlpPVmw6+Z0ag10
   JdpgHmUVPZo+XbixxXT3n+P5DyLRdIxk6ZNp4cNe6zr/vEVwRtgtK8LsU
   3/55GztD3ctnj4BJmqKe8TgwxeVbH0wz+51jAApiBWKxl9sKKTdHmF6KP
   qarVmmCwQH84idE4mhvOVO09Fmqc+yYRQLGvLAP4QbZ+iRgek674vuBs3
   A==;
X-CSE-ConnectionGUID: MvmgqFTpQ/aLZqd64kS1Ow==
X-CSE-MsgGUID: n3Oy5dRGSi6SYL4VjGzKcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63944502"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="63944502"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:16:47 -0700
X-CSE-ConnectionGUID: xn/e0EKeQv6OhzJO1E8dww==
X-CSE-MsgGUID: 1RlI6c38Skqst6huCxhIVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="189503741"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa003.jf.intel.com with ESMTP; 28 Oct 2025 13:16:47 -0700
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
Subject: [PATCH v2] sched/fair: Skip sched_balance_running cmpxchg when balance is not due
Date: Tue, 28 Oct 2025 13:23:30 -0700
Message-Id: <248b775fc9030989c829d4061f6f85ae33dabe45.1761682932.git.tim.c.chen@linux.intel.com>
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

Currently, each MC group leader in a NUMA domain attempts to acquire
the global sched_balance_running flag via cmpxchg() before checking
whether load balancing is due or whether it is the designated leader for
that NUMA domain. On systems with a large number of cores, this causes
significant cache contention on the shared sched_balance_running flag.

This patch reduces unnecessary cmpxchg() operations by first checking
whether the balance interval has expired. If load balancing is not due,
the attempt to acquire sched_balance_running is skipped entirely.

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

After applying this fix, sched_balance_domain() is gone from
the profile and there is a 8% throughput improvement.

v2:
1. Rearrange the patch to get rid of an indent level per Peter's
   suggestion.
2. Updated the data from new run by OLTP team.

link to v1: https://lore.kernel.org/lkml/e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com/

Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Mohini Narkhede <mohini.narkhede@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..a10c95e11ea5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12226,6 +12226,8 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 
 		interval = get_sd_balance_interval(sd, busy);
+		if (time_before(jiffies, sd->last_balance + interval))
+			goto out;
 
 		need_serialize = sd->flags & SD_SERIALIZE;
 		if (need_serialize) {
@@ -12233,19 +12235,18 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 				goto out;
 		}
 
-		if (time_after_eq(jiffies, sd->last_balance + interval)) {
-			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
-				/*
-				 * The LBF_DST_PINNED logic could have changed
-				 * env->dst_cpu, so we can't know our idle
-				 * state even if we migrated tasks. Update it.
-				 */
-				idle = idle_cpu(cpu);
-				busy = !idle && !sched_idle_cpu(cpu);
-			}
-			sd->last_balance = jiffies;
-			interval = get_sd_balance_interval(sd, busy);
+		if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
+			/*
+			 * The LBF_DST_PINNED logic could have changed
+			 * env->dst_cpu, so we can't know our idle
+			 * state even if we migrated tasks. Update it.
+			 */
+			idle = idle_cpu(cpu);
+			busy = !idle && !sched_idle_cpu(cpu);
 		}
+		sd->last_balance = jiffies;
+		interval = get_sd_balance_interval(sd, busy);
+
 		if (need_serialize)
 			atomic_set_release(&sched_balance_running, 0);
 out:
-- 
2.32.0



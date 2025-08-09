Return-Path: <linux-kernel+bounces-760945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF3B1F23A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E522567BFC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF602749D5;
	Sat,  9 Aug 2025 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnHR/vdK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60C2472BA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716251; cv=none; b=ADP9uISEjTXXmrZUS4riveuGfD0WO35c5rz53HhmhWNMrD8Dv6NEgTvyjQYnfTc2u3LwbGoaDVNp6SSxFFbbtfw/FH7XlH762INSbgUPWTafzzs+ATW6FN2x9nPTJmp96ZH+mnf1JNlGrm30zuWW2dvWodZS8ErATrdpAPxPp5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716251; c=relaxed/simple;
	bh=aqSPvY6s7QQr//GlOU5D+JTqKry164SNV/VZUR7Kspk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/5xtGUzGrKxeHEjmp10AAMihG56pqeTBrBMPkuq4PHQwrU2AfkoQsDB4Y9TtiCy7GzKfao5LjE7hgoUByuq8rYZKjatFGSKo04f1EvdsfMKnnI+kvm1KPBegBNQVntmqPVlcdaoa8X2w/mUXe+QOHkdUYdt1Sj1Q17LdJWTtvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnHR/vdK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716250; x=1786252250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aqSPvY6s7QQr//GlOU5D+JTqKry164SNV/VZUR7Kspk=;
  b=hnHR/vdKO7tdLOhgecBrJ/L6XtQ1BO8dVbYIB82zj+iOPcT1jV8xsoaQ
   qVvNm13ubKRb17a6vcXBW7sO0sqESiBXEDAA3LOy6nrman47fi+cJF4GK
   /APwE4CIXL2nHpsyP/5wUxfP2JBnuaAMw69BpWv3yxh4gHtAvKYTTGlqu
   yYAwTm4DfQnzeKlTLUohbS6ngMAvDbvMCBqHRIliyvHmG2k+p5eyDajr2
   YczcwUmYJan/0n1K6JWf7awWcuI7A08+OPYkjN3MABdDHrz0f/nYtETcb
   muTOyFAlK1kHzNTlu61gC8CfjRqlA8omMF+AZVXL7YPft7aD6yFC9a32S
   Q==;
X-CSE-ConnectionGUID: 5tGpMziNRzOAuvg9CBzp+w==
X-CSE-MsgGUID: RdOEUAbzTDSASRaq4EwAIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57019960"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57019960"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:10:49 -0700
X-CSE-ConnectionGUID: DegXMsyUTHGOiD9Y2cNnrw==
X-CSE-MsgGUID: A+KDxoubRjeA2xjTkEMmBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="169705082"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2025 22:10:44 -0700
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
Subject: [RFC PATCH v4 12/28] sched: Calculate the total number of preferred LLC tasks during load balance
Date: Sat,  9 Aug 2025 13:04:39 +0800
Message-Id: <4145385d4ce232e10cae713c8449d459c325db46.1754712565.git.tim.c.chen@linux.intel.com>
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

During load balancing between LLCs, gather the number of tasks
on each runqueue of a source LLC.

For example, consider a system with 4 sched groups LLC0, LLC1,
..., LLC3. We are balancing towards LLC3 and LLC0 has 3 tasks
preferring LLC3, LLC1 has 2 tasks preferring LLC3 and LLC2 has
1 task preferring LLC3. LLC0 with most tasks preferring LLC3
will be chosen as the busiest LLC to pick the tasks from.

The number of tasks preferring the destination LLC are gathered
from each run queue for a source LLC.

For example, consider the sched_group LLC0 with two CPUs, CPU0
and CPU1. On CPU0, 2 tasks prefer to run on LLC3, and on CPU1,
one task prefers LLC3. The total number of tasks preferring
LLC3 in LLC0 is 2 + 1 = 3.

These statistics enable the load balancer to select tasks from
a sched_group that best aligns tasks with their preferred LLCs.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfae71ee870b..f1697658c3b8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10496,6 +10496,9 @@ struct sg_lb_stats {
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
 #endif
+#ifdef CONFIG_SCHED_CACHE
+	unsigned int nr_pref_llc[MAX_LLC];
+#endif
 };
 
 /*
@@ -10974,6 +10977,14 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (cpu_overutilized(i))
 			*sg_overutilized = 1;
 
+#ifdef CONFIG_SCHED_CACHE
+		if (sched_feat(SCHED_CACHE)) {
+			int j;
+
+			for (j = 0; j < max_llcs; ++j)
+				sgs->nr_pref_llc[j] += rq->nr_pref_llc[j];
+		}
+#endif
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
 		 */
-- 
2.25.1



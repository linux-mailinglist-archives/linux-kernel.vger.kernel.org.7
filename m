Return-Path: <linux-kernel+bounces-849245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42502BCFA9C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3873A420198
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E45285CBD;
	Sat, 11 Oct 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3R+hIU0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A92848A1
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206709; cv=none; b=OEtiMJ0EXsYmk/b2RpkCvrola+Tb5ZlnJVLLgRLqGiICx7t2qJcij9yw0SgiiThPPPTMrbIdFBAm4w8howvUGPAJFc0ItOZDXO+gwbi0GCrU/MRny5Tre78B7YMgEyxZMXkI05Eu0+fODpObrBBk2c09F8OXQKZ4o5hgptBzDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206709; c=relaxed/simple;
	bh=PKtlvEc8jJzYEmRgIquRSV3KaK94Gb12wRaccvthO/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6bK9CIrnn+dpoeG8RJW1aH3SE1Yc7QYj7Dgh7cqTjdsd3fsWZdu3E2SAwDjyqT5ptCJzWnqjXDoxnW3sFv/aeRC7QnnQkB9bTzAgmfskcoHsp0hZI6c042fUlYpwgsk0j6PmWc4xM8hZNNktu5sqG8t6W1tVMFc+pGngTuF0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3R+hIU0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206708; x=1791742708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PKtlvEc8jJzYEmRgIquRSV3KaK94Gb12wRaccvthO/I=;
  b=n3R+hIU0WDMCAOT74Si47T0DHUQFpP/mOPOr4EFjzfrMTg20mocMFVue
   SPJYeD3u+HI/S8DzRBSopnypgjipAk03R2jKWcm5OSqY338iFWIhO44pH
   Rkbh2OZ1rpYHNaif/qBdzoG/S0GRuxE4+p6SgnYPob1i1tRz5kFPtKtWI
   Em/YtXT8s7M8i1lwEkDGhNlIAeWj5yl5FVsHoShyMoDnOs/ZKpz9fa1vH
   yY+/JK9y5B5Rh8CVo9sz+iLl5gL/zxPW+ETtFRKayHPWInq1R4rGuUz8D
   OVUSiTUoZeUSI+4YJPz+v9iatJmNEpwFlvZeVYR4+WsdGyv8IT5qlNl3i
   g==;
X-CSE-ConnectionGUID: VcC/511LSz6QngP8mD/4Fw==
X-CSE-MsgGUID: cm5ykdK+Tza9czQo0iIcIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339767"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339767"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:27 -0700
X-CSE-ConnectionGUID: +fnFCaxeROy1X1/2M3UOCQ==
X-CSE-MsgGUID: cAIBkdx0SvqbyNLUptq1pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487219"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:27 -0700
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
Subject: [PATCH 09/19] sched/fair: Count tasks prefering each LLC in a sched group
Date: Sat, 11 Oct 2025 11:24:46 -0700
Message-Id: <00e5f2cb6eadc3738e33858d3c4563a0775ee1c0.1760206683.git.tim.c.chen@linux.intel.com>
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

During LLC load balancing, tabulate the number of tasks on each runqueue
that prefer a given destination LLC in a sched group.

For example, consider a system with 4 LLC sched groups (LLC0 to LLC3)
balancing towards LLC3. LLC0 has 3 tasks preferring LLC3, LLC1 has
2, and LLC2 has 1. LLC0, having the most tasks preferring LLC3, is
selected as the busiest source to pick tasks from.

Within a source LLC, the total number of tasks preferring a destination
LLC is computed by summing counts across all CPUs in that runqueue. For
instance, if LLC0 has CPU0 with 2 tasks and CPU1 with 1 task preferring
LLC3, the total for LLC0 is 3.

These statistics allow the load balancer to choose tasks from source
sched groups that best match their preferred LLCs.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b7a68fe7601b..cbd1e97bca4b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10399,6 +10399,9 @@ struct sg_lb_stats {
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
 #endif
+#ifdef CONFIG_SCHED_CACHE
+	unsigned int nr_pref_llc[NR_LLCS];
+#endif
 };
 
 /*
@@ -10891,6 +10894,14 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (cpu_overutilized(i))
 			*sg_overutilized = 1;
 
+#ifdef CONFIG_SCHED_CACHE
+		if (sched_cache_enabled()) {
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
2.32.0



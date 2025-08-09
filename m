Return-Path: <linux-kernel+bounces-760954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE018B1F243
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47A0179E17
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E382262FE7;
	Sat,  9 Aug 2025 05:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBrobR1i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4A02749D5
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716425; cv=none; b=VIDdU39lmJxSYrHB9S4l1mh0boKZZki9BLORb9qgZo0xYyJtYcfX+m2EFuLna+wvMqdM3b9jRoxWjfYX98zrEOAuWNoH8zCG6FpNq8YiKHKq1NGdKxQHVgzOOiLG5uy1qO9t7Wa4goaOHrkQI+arcKezllgcvY4ibca99xDzFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716425; c=relaxed/simple;
	bh=YdhYlPfOzBX2JmU404dp2rIw4uGKUk0/reO/wjvEcdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AeIzKWJSFg2pTtYt5o5Vz8pc3/BIn9Yhzjs5gEx3/9nVXOR8/67BRRpJDX5hibfRtV6EY8e/fAEY/Zxa+8RbAe6m0nXD1z5eRZPQvlghGCpOjLX0XPm2maXH0OgysqVx3VFMCsFbO52VsoQD2p85NC594bUHYDFoDa6p7TKhhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBrobR1i; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716424; x=1786252424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YdhYlPfOzBX2JmU404dp2rIw4uGKUk0/reO/wjvEcdA=;
  b=RBrobR1iwxBeJZoLKXMRg5MQx8WGXo8muZpXStdx9iyAK264sfhIG/qu
   joL4lEprzIBRw8X03Yy5P97hTPxpboN85pYrMB8bQ6FHQo9ybNckkrA6U
   Fm88MiZ42tIDdBFytUX2SY9R5LIWL4D6l7uxGHF/7t9G2tSrGXQZrLdmV
   kEXY08yQyIUpqXqtLN/Fts7veKj7eYDCqo12PTEZYQ6XGxrwnt4HlyW3a
   b9OPJyXpEcpsigfeiakBxz87spvYkl6NsSdiBGHP8WsVh/XlkJ8G7/XfP
   bZjJOX3ekGPt6NQIeusuWhHKU/YI3AgkFy7IeRU2nggpBNO+zFRf78cN1
   w==;
X-CSE-ConnectionGUID: 6JJ7KzVjTq2D3T0a9H1P9w==
X-CSE-MsgGUID: pH0Ms/VYRfa3u1EQ9lfZ0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="79620375"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="79620375"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:13:44 -0700
X-CSE-ConnectionGUID: p2RcioaZTnKrvWCzoclFkA==
X-CSE-MsgGUID: 7ArRWLtgSgqBcLoFA2nIvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165844031"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2025 22:13:38 -0700
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
Subject: [RFC PATCH v4 20/28] sched: Introduce SCHED_CACHE_WAKE to control LLC aggregation on wake up
Date: Sat,  9 Aug 2025 13:07:35 +0800
Message-Id: <144358df73cbb8c7d24f757fc40cb068be603bed.1754712565.git.tim.c.chen@linux.intel.com>
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

Introduce SCHED_CACHE_WAKE feature to enable or disable cache-aware
wake up. Disable this feature by default because cache-aware wakeup
is overly aggressive in stacking wakees of the same process on the
same LLC, if they are frequently woken up.

The wake ups can be much more frequent than load balances, adding
much overhead when load balance alone for LLC aggregation is sufficient.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c     | 6 +++++-
 kernel/sched/features.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9843d4e1d84f..6e61f9e1f628 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9063,7 +9063,7 @@ static int select_cache_cpu(struct task_struct *p, int prev_cpu)
 	struct mm_struct *mm = p->mm;
 	int cpu;
 
-	if (!sched_feat(SCHED_CACHE))
+	if (!sched_feat(SCHED_CACHE) || !sched_feat(SCHED_CACHE_WAKE))
 		return prev_cpu;
 
 	if (!mm || p->nr_cpus_allowed == 1)
@@ -9076,6 +9076,10 @@ static int select_cache_cpu(struct task_struct *p, int prev_cpu)
 	if (cpus_share_cache(cpu, prev_cpu))
 		return prev_cpu;
 
+	if (_get_migrate_hint(prev_cpu, cpu,
+			      task_util(p), true) == mig_forbid)
+		return prev_cpu;
+
 	if (static_branch_likely(&sched_numa_balancing) &&
 	    __migrate_degrades_locality(p, prev_cpu, cpu, false) > 0) {
 		/*
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 11dbd74cd365..44b408cf0dd4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -89,6 +89,7 @@ SCHED_FEAT(SIS_UTIL, true)
 
 SCHED_FEAT(SCHED_CACHE, true)
 SCHED_FEAT(SCHED_CACHE_LB, true)
+SCHED_FEAT(SCHED_CACHE_WAKE, false)
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
  * in a single rq->lock section. Default disabled because the
-- 
2.25.1



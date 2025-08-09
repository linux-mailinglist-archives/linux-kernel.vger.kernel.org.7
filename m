Return-Path: <linux-kernel+bounces-760942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34747B1F237
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3852418958D0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4021DC9A3;
	Sat,  9 Aug 2025 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jA/q+1HC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6D15665C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716202; cv=none; b=b2L1GhXR1bKfaGNtSt2TSFJgivwyGWl/zG0ke7CHSqEAcHuFzHVF+Vph/AG5ZfJphDMNbIxy4SUFIumjAOZK2TB0Z4jGWHlzOvGKs9kRxGy3WkdJTVEO3FLULtEJnBKj5AORTkYZlfIB4LE4Izx1MQm/ZkRn8Sz9XQb/WKOg49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716202; c=relaxed/simple;
	bh=yDyElrdoJP1owudVvXOmuFFmGrAdqlZ/3LSJv9270PI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3HhsKTtfxpLA3rJndUgWlhiEvEp59nMppnJBuBt3n57eWQsLpmRNumx60yqEWTiU+2a0Akk/6QCT1AAxHoly+zNGqSyQJ4Og7AOKWr039BhdBdB9rB0XwOlLRo6MBk6oRA3xZMgTm/i1/Glk/eLvpJOrXxvUAqHVunt8/0Gy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jA/q+1HC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716201; x=1786252201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yDyElrdoJP1owudVvXOmuFFmGrAdqlZ/3LSJv9270PI=;
  b=jA/q+1HCZoWL9/if9zUiP2RagKNIlzVG2/9XmXTq+Ai1+idEA3GniBpc
   0U+c7IPLnvxvaiyKdJCCUu5unbGE6uc4OZCK3b3LFPBZpAbM8stdCZMnd
   Wj/PbIIK7iHErHRNJoSuTG2Hz3Kd1S2DZTWM7lcoF8Rml/dJplEh3gVCt
   vpngwG0Zm9NV0fxTmPcRsqshl1tnvy4tttj+WdiTSfQEPhYj49I+gD0bh
   3UQewsPVTarSIp+hr1KFG3cogmN+Rd4lGhrxiPXp8zr5spR5put/n5Xyn
   1MEtslmziwaMvG+ZfcPPao0HwFNVTDTVL4ngyCM61uwjqrVJWtD3T8BQ/
   Q==;
X-CSE-ConnectionGUID: W/xDy5btSjOwlHAt10VALQ==
X-CSE-MsgGUID: hD1wAyqHT7WAJ49GLugw0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68139885"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68139885"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:10:00 -0700
X-CSE-ConnectionGUID: c2jIhCe2THSYJtrA2gygJg==
X-CSE-MsgGUID: PCF36aw+QPy8wB+b//2Ymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165891237"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2025 22:09:54 -0700
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
Subject: [RFC PATCH v4 09/28] sched: Introduce task preferred LLC field
Date: Sat,  9 Aug 2025 13:03:50 +0800
Message-Id: <a8e889738dbb543c2d3844c1f1089aabc6b94bef.1754712565.git.tim.c.chen@linux.intel.com>
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

With cache aware scheduling enabled, each process is assigned
a preferred LLC id, which will be used to quickly identify
the LLC domain this thread prefers to run. This is similar to
numa_preferred_nid for NUMA balance.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/sched.h | 1 +
 init/init_task.c      | 3 +++
 kernel/sched/fair.c   | 7 +++++++
 3 files changed, 11 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 81d92e8097f5..ac4973728c3e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1408,6 +1408,7 @@ struct task_struct {
 
 #ifdef CONFIG_SCHED_CACHE
 	struct callback_head		cache_work;
+	int				preferred_llc;
 #endif
 
 #ifdef CONFIG_RSEQ
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..5fffbe766f57 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -188,6 +188,9 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.numa_group	= NULL,
 	.numa_faults	= NULL,
 #endif
+#ifdef CONFIG_SCHED_CACHE
+	.preferred_llc  = -1,
+#endif
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	.kasan_depth	= 1,
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f5075d287c51..94ad84ba19e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1267,6 +1267,7 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	struct mm_struct *mm = p->mm;
 	struct mm_sched *pcpu_sched;
 	unsigned long epoch;
+	int mm_sched_llc = -1;
 
 	if (!sched_feat(SCHED_CACHE))
 		return;
@@ -1298,6 +1299,12 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 		mm->mm_sched_cpu = -1;
 		pcpu_sched->occ = 0;
 	}
+
+	if (mm->mm_sched_cpu != -1)
+		mm_sched_llc = per_cpu(sd_llc_id, mm->mm_sched_cpu);
+
+	if (p->preferred_llc != mm_sched_llc)
+		p->preferred_llc = mm_sched_llc;
 }
 
 static void task_tick_cache(struct rq *rq, struct task_struct *p)
-- 
2.25.1



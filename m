Return-Path: <linux-kernel+bounces-849241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD62BCFA9F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB4D34E9478
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3109E2853F2;
	Sat, 11 Oct 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maHNOTTa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93492836B1
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206706; cv=none; b=S6xTZtgG4gDit+VImk9W2UzS4qpXEGkcWHMUVoYyOSnpNNw4aucqYAXSSje8zYLjl3z3dX3Jt3ztt7bwcuxWrRrv6qxUGactOiUWUNrvSPN2VWKScV6w3ksMM6saX0NH5ZC3WBABiX0+fpwQlzvqkQFNz80/YqP8x3hbG8jBKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206706; c=relaxed/simple;
	bh=9oov8ViGgsZaxAZzpTlsnaOcdJ/Jv8NLa7EsoSw2oPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JsV8TTkODWXWFKIKrzZGo3NxMw8hU5p/OWk4qVG3F1HoqgFqWBsu2TcQGUVWw1R9rnOAFP+1s9fHghtr+g8SHhcTCX8Srq+6rXX7gAPQLfCi2R3P+f6W+h6FG6DDQXFxrgsSAi265RFjsNyqSNVDyYiSw0j1kUou9k2jg/TFWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maHNOTTa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206705; x=1791742705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9oov8ViGgsZaxAZzpTlsnaOcdJ/Jv8NLa7EsoSw2oPE=;
  b=maHNOTTaUom4zOfjF9aQgzk/EHInefpcQXQBpZ407o2A6QAh7rtx4d1V
   uIUh04rGM6MxEKMGQGzPbEcwmEUVnQVNQXhq0m60vo8GIlq3nI3UFHh2/
   okHOmrxdhoN3uwbNZN5d2mGAMO3ADHunEGtbLYRsJ5ffyJXYwvK9ZYj6n
   ZqWJDYCygmb5LDln/D3icLbLhH8Zm6QWr4yAgVZQ73wl/I3EgDdp+pIYb
   aLimiW5HUOhIlD+krR4Rg02sINFyPrZ2h5VJdZ1v01hMqilwa2zgPVcWi
   tEJ0OmQs9iwf0mBA0kNnJx5l2NSvLy+2FE84H8lwtH6U/4ySfKAnmdVGc
   Q==;
X-CSE-ConnectionGUID: LhZ9XN5ESr6ORNd5zvY9sA==
X-CSE-MsgGUID: UBKHEBpdQNSkGD6fqT87jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339711"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339711"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:24 -0700
X-CSE-ConnectionGUID: M/4LVw/6Qg626wVKqENzqw==
X-CSE-MsgGUID: hqk2hnIER+q1aJ8R3vcczQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487203"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:24 -0700
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
Subject: [PATCH 06/19] sched/fair: Assign preferred LLC ID to processes
Date: Sat, 11 Oct 2025 11:24:43 -0700
Message-Id: <cfa266cd6ea6fa30cbf7b07573992f18f786955e.1760206683.git.tim.c.chen@linux.intel.com>
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

With cache-aware scheduling enabled, each task is assigned a
preferred LLC ID. This allows quick identification of the LLC domain
where the task prefers to run, similar to numa_preferred_nid in
NUMA balancing.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/sched.h | 1 +
 init/init_task.c      | 3 +++
 kernel/sched/fair.c   | 7 +++++++
 3 files changed, 11 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d7ddb7ce6c4b..8a5e4038cd5c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1402,6 +1402,7 @@ struct task_struct {
 
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
index 61c129bde8b6..d6167a029c47 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1312,6 +1312,7 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	struct mm_struct *mm = p->mm;
 	struct mm_sched *pcpu_sched;
 	unsigned long epoch;
+	int mm_sched_llc = -1;
 
 	if (!sched_cache_enabled())
 		return;
@@ -1342,6 +1343,12 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 		if (mm->mm_sched_cpu != -1)
 			mm->mm_sched_cpu = -1;
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
2.32.0



Return-Path: <linux-kernel+bounces-840849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62990BB58F2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20534825F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DAF25F780;
	Thu,  2 Oct 2025 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wbvefx0a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78E2E403
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445616; cv=none; b=eRWTcAEaIDlrVT0Vzy5fBI/Kve0cse2Z5uIGxDA5L5Hmf045NMipiyJEsuFr4TQ0APfHv5Kqs4NutehyJgbwgJQSb2fUQ5VR2IP3j8JrIC2JtEBJbdKs7IjyKbUbrPayQO4vhxEQshoPm7Uq+IRg7TDXIL3/fY2bSF55R2hn5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445616; c=relaxed/simple;
	bh=TPxLZuKAZbF1jjrTZM0SUyipMSUfNxa+s1mG1m24iUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=keYwaL+pkdoqtGHbiOFCNJziDkbcw0rrBAuICpzRpaB1eGD2Nd18AzoaLD/60L0csMiGKTpN8sCkQCuLIdbSBIvK/l9u1bqYRx2J38Bj9/N5wszSOQ4CppKIAsiyiqTMranQQleA5P1x6E814iIYmEBPcPCcu0CtPqZGdNDOLNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wbvefx0a; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759445614; x=1790981614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TPxLZuKAZbF1jjrTZM0SUyipMSUfNxa+s1mG1m24iUY=;
  b=Wbvefx0aar6N02JsOREhi3ME0Gl5v6Vh3Y0CqRXqCwGxbX3yrMP93aZD
   ujE9ojEkY5sJSOs9wW/+ypC5pA10xe78g5LGbgsS75uH8zCNRkhgEDXYy
   KFhVrHM2bqtHC9I4sphIs8puiomvpt4L3wpxELH8HvKbaJ5LTxN0Y5J2i
   HuGAeDs1I82qHonhftNGw81HYsR23TFh4pasTfEA6dQY5Xm8hR93LYOTU
   XEWMojHYzMrBhhe21XDzy9ec9saghxZkFA1Zcjm6yYbMm100PBOtztZb1
   haKJTZNARGDJ3zKwjIFNsNAGm1GjqyMP73YpxikKo9LcYAtfbNhwsnb2/
   w==;
X-CSE-ConnectionGUID: pGuSFFclQQCLpE406wZy6g==
X-CSE-MsgGUID: /Ty5TFTwQIGDoGzscP2ICg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61645447"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="61645447"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 15:53:33 -0700
X-CSE-ConnectionGUID: 9vXTMcjhS4++U5FUTDUhIg==
X-CSE-MsgGUID: l6XS7XbhR9a/0FnLzzpgtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="179591480"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa009.fm.intel.com with ESMTP; 02 Oct 2025 15:53:33 -0700
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
Subject: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg when balance is not due
Date: Thu,  2 Oct 2025 16:00:12 -0700
Message-Id: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repost comments:

There have been past discussions about avoiding serialization in load
balancing, but no objections were raised to this patch itself during
its last posting:
https://lore.kernel.org/lkml/20250416035823.1846307-1-tim.c.chen@linux.intel.com/

Vincent and Chen Yu have already provided their Reviewed-by tags.

We recently encountered this issue again on a 2-socket, 240-core
Clearwater Forest server running SPECjbb. In this case, 14% of CPU
cycles were wasted on unnecessary acquisitions of
sched_balance_running. This reinforces the need for the change, and we
hope it can be merged.

Tim

---

During load balancing, balancing at the LLC level and above must be
serialized. The scheduler currently checks the atomic
`sched_balance_running` flag before verifying whether a balance is
actually due. This causes high contention, as multiple CPUs may attempt
to acquire the flag concurrently.

On a 2-socket Granite Rapids system with sub-NUMA clustering enabled
and running OLTP workloads, 7.6% of CPU cycles were spent on cmpxchg
operations for `sched_balance_running`. In most cases, the attempt
aborts immediately after acquisition because the load balance time is
not yet due.

Fix this by checking whether a balance is due *before* trying to
acquire `sched_balance_running`. This avoids many wasted acquisitions
and reduces the cmpxchg overhead in `sched_balance_domain()` from 7.6%
to 0.05%. As a result, OLTP throughput improves by 11%.

Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8ce56a8d507f..bedd785c4a39 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12126,13 +12126,13 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 
 		interval = get_sd_balance_interval(sd, busy);
 
-		need_serialize = sd->flags & SD_SERIALIZE;
-		if (need_serialize) {
-			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
-				goto out;
-		}
-
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
+			need_serialize = sd->flags & SD_SERIALIZE;
+			if (need_serialize) {
+				if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
+					goto out;
+			}
+
 			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
 				/*
 				 * The LBF_DST_PINNED logic could have changed
@@ -12144,9 +12144,9 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 			}
 			sd->last_balance = jiffies;
 			interval = get_sd_balance_interval(sd, busy);
+			if (need_serialize)
+				atomic_set_release(&sched_balance_running, 0);
 		}
-		if (need_serialize)
-			atomic_set_release(&sched_balance_running, 0);
 out:
 		if (time_after(next_balance, sd->last_balance + interval)) {
 			next_balance = sd->last_balance + interval;
-- 
2.32.0



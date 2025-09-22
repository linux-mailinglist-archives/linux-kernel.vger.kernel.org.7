Return-Path: <linux-kernel+bounces-827210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A7B9128A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2985424271
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3CA3093C3;
	Mon, 22 Sep 2025 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LKDkbZje"
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941883081A8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544874; cv=none; b=naxfEQxlu+fB7NM10zWVvEI2ItVpEX9BIgxl52Q3wNg1F0Jb8D0aT+hNEap7ntW/XVHDh3/5wXphtEGOi794bBoyRQHhvvsZahnGJrXyvrx+dDJKR6WmNyvd6ngT1wKlFra75qDXMOsu05gKUMhpEZlRwn1iLuQLCfy0nx6HyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544874; c=relaxed/simple;
	bh=lHiyIX9bGuVzwTz5m0YFqeLu0Dr0xvsVn8gw4+3KUmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5MivTVvdU0dbZKrS3i/flRA2NFSTyd5qz/lysgA/2BsY4tziJIXE41v8JE4052y0R/nUf8qPFrE6tyydK0N5imFu7eRg/pBTKkdXHVyuXWMDWV0Y+uwfRelpyAlVLvJtbJtZ0MDrLGSET0Ryt7U8V7FXGKJnrVFpr8tBpVD2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LKDkbZje; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758544871; x=1790080871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YySKg3TXYuCaKbbwvti+jSac7ZDfip0GnEqCMdXQqXE=;
  b=LKDkbZjevGMGFsnWr7ypkiylewekibmK0WTcX5GYzTecbWJBL8vXthW1
   CzZmLAb8tnwUfaButFUHDuF3ALp2On/8tZ1U8JAT0DQGQP2ymKiVmwUwG
   cNk6gdKmiegBT8/deKrQdsswJKdNyOsFjTgdZVFyNPVSqOCxgpEWinySp
   OOi7memTq5IlzJ8PoOsXrTwSS/ZrllLnaVGlVO3Qv1LigjWqsP2JygAkF
   LSgorLPLoSKsWigsI5danjwUY6LFSLnRYZTCDFiZWnhfDuwV2ptEBm3RM
   bm56HRDj6XZKKi2VB86l0foYuugR+ljj2rSTVA/iv6e0KVLW5uATm+emX
   g==;
X-CSE-ConnectionGUID: 6j5+wCStTCC31FN1JHIYSA==
X-CSE-MsgGUID: tmg5z7jXRuKbnkwM4dLTOA==
X-IronPort-AV: E=Sophos;i="6.18,285,1751241600"; 
   d="scan'208";a="2484248"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 12:40:58 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:4387]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.2.208:2525] with esmtp (Farcaster)
 id bacbf2c8-65f9-45d0-b9c4-8c261b6287b2; Mon, 22 Sep 2025 12:40:58 +0000 (UTC)
X-Farcaster-Flow-ID: bacbf2c8-65f9-45d0-b9c4-8c261b6287b2
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 12:40:57 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.222) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 12:40:50 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <mingo@redhat.com>, <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
Subject: [PATCH 3/4] sched/fair: Add cookie checks on wake idle path
Date: Mon, 22 Sep 2025 14:39:24 +0200
Message-ID: <64a2df7604e82d42a966b62b479479a97d545e76.1758543008.git.sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758543008.git.sieberf@amazon.com>
References: <cover.1758543008.git.sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The wake_affine_idle() function determines whether the previous CPU or the
waking CPU are suitable for running a waking task. Currently it does not
consider core scheduling constraints.

Add cookie compatibility checks to prevent considering a CPU idle when
placing the task there would immediately cause force idle due to an
incompatible sibling task. This reduces unnecessary force idle scenarios
in the wake-up path.

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
---
 kernel/sched/fair.c  | 19 +++++++++++++------
 kernel/sched/sched.h | 33 ++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 67746899809e..78b36225a039 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7235,7 +7235,7 @@ static int wake_wide(struct task_struct *p)
  *			  for the overloaded case.
  */
 static int
-wake_affine_idle(int this_cpu, int prev_cpu, int sync)
+wake_affine_idle(struct task_struct *p, int this_cpu, int prev_cpu, int sync)
 {
 	/*
 	 * If this_cpu is idle, it implies the wakeup is from interrupt
@@ -7249,17 +7249,24 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	 * a cpufreq perspective, it's better to have higher utilisation
 	 * on one CPU.
 	 */
-	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
-		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
+	if (available_idle_cpu(this_cpu) &&
+		cpus_share_cache(this_cpu, prev_cpu) &&
+		sched_core_cookie_match(cpu_rq(this_cpu), p)) {
+		return available_idle_cpu(prev_cpu) &&
+			sched_core_cookie_match(cpu_rq(prev_cpu), p) ?
+			prev_cpu : this_cpu;
+	}
 
 	if (sync) {
 		struct rq *rq = cpu_rq(this_cpu);
 
-		if ((rq->nr_running - cfs_h_nr_delayed(rq)) == 1)
+		if (((rq->nr_running - cfs_h_nr_delayed(rq)) == 1) &&
+		    sched_core_cookie_match_sync(rq, p))
 			return this_cpu;
 	}
 
-	if (available_idle_cpu(prev_cpu))
+	if (available_idle_cpu(prev_cpu) &&
+		sched_core_cookie_match(cpu_rq(prev_cpu), p))
 		return prev_cpu;
 
 	return nr_cpumask_bits;
@@ -7314,7 +7321,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	int target = nr_cpumask_bits;
 
 	if (sched_feat(WA_IDLE))
-		target = wake_affine_idle(this_cpu, prev_cpu, sync);
+		target = wake_affine_idle(p, this_cpu, prev_cpu, sync);
 
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4e7080123a4c..97cc8c66519e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1386,27 +1386,41 @@ extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_f
  * A special case is that the task's cookie always matches with CPU's core
  * cookie if the CPU is in an idle core.
  */
-static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
+static inline bool __sched_core_cookie_match(struct rq *rq,
+					     struct task_struct *p,
+					     bool sync)
 {
-	bool idle_core = true;
 	int cpu;
 
 	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
 	if (!sched_core_enabled(rq))
 		return true;
 
+	if (rq->core->core_cookie == p->core_cookie)
+		return true;
+
 	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
-		if (!available_idle_cpu(cpu)) {
-			idle_core = false;
-			break;
-		}
+		if (sync && cpu_of(rq) == cpu)
+			continue;
+		if (!available_idle_cpu(cpu))
+			return false;
 	}
 
 	/*
 	 * A CPU in an idle core is always the best choice for tasks with
 	 * cookies.
 	 */
-	return idle_core || rq->core->core_cookie == p->core_cookie;
+	return true;
+}
+
+static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	return __sched_core_cookie_match(rq, p, false);
+}
+
+static inline bool sched_core_cookie_match_sync(struct rq *rq, struct task_struct *p)
+{
+	return __sched_core_cookie_match(rq, p, true);
 }
 
 static inline bool sched_group_cookie_match(struct rq *rq,
@@ -1464,6 +1478,11 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 	return true;
 }
 
+static inline bool sched_core_cookie_match_sync(struct rq *rq, struct task_struct *p)
+{
+	return true;
+}
+
 static inline bool sched_group_cookie_match(struct rq *rq,
 					    struct task_struct *p,
 					    struct sched_group *group)
-- 
2.43.0




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07



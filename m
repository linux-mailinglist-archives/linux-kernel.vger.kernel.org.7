Return-Path: <linux-kernel+bounces-730907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 770C4B04C44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FDD1AA0FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143D2459E1;
	Mon, 14 Jul 2025 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/uSsZ+Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01A126F0A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535771; cv=none; b=EA5OTk6bVNey7AzJWpbYv2q65o2HmqUw/nWSM/fflNoXFvWKIs5ovD46vriTKjVCyDJ7spane4eUzWJi/m13dMwOCt0Vbeedctgd4WB08vIdPpgykzcheM9goemUSNDUzJsuH2JawvmsUZIzwknxXosqE+89T12g/Lu+0ou5orI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535771; c=relaxed/simple;
	bh=9lpKrA2ZZdvS9r9T1azcHLeWuluBNKZeDSTH0hQdONA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYNuUSF/ubRs82EGSEikhWVoZlDvMkzELWaYLMYrJaWA1AKKPch3v8RJZ8i0aB2TTC6xcQlbG1JLRrdt6Ecgpi0o5AawDf+3aNQ0s13g/s2SRiO2DUCuWMlWOVv58at1eKAUMm3VQO1/Z6bAFpoQmODfPNXzbnmbDRhbleNbR/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/uSsZ+Q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752535769; x=1784071769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9lpKrA2ZZdvS9r9T1azcHLeWuluBNKZeDSTH0hQdONA=;
  b=l/uSsZ+QRcrQGjP7lkTDqsLBiXJeLKeEvLoqAXkkw2otp7k/v9u0/I8T
   bcvqr/ckmgsLmua0R95tXB6+tM55pW8fKIpxkJK3brXQtMiwVvCCLjafd
   ahL9Xh18rUEPWfgPqi1To96HRosTYG7S9FGAadO38akYc/Zsr0EiYaXCU
   1kXPctFpmUg4azdwgQsT+z+ZsAmJsrN04yEtqeNz9C/rHw6L/uKoQigOs
   QuOqZQ+okMg53jL/4CtKm0+e5vDdKPx/f2y/nS/ERrLLy4yebw24Q8vIG
   aD0veU6IVK85izyDCjuIpD/o5t9vYHSjLhiviwVBoIjCjlGkbD/SZWC2D
   A==;
X-CSE-ConnectionGUID: bD7wdelKQFazB3n/FH+08A==
X-CSE-MsgGUID: kDOqIJYJTB6hptq7s8rzPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57350438"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="57350438"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 16:29:28 -0700
X-CSE-ConnectionGUID: BcmVzP6PTyCPJ+A7+/JD2A==
X-CSE-MsgGUID: NjRNO+U6SOetWUVJPnSGXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="194223439"
Received: from vcostago-mobl3.jf.intel.com ([10.98.36.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 16:29:29 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: linux-kernel@vger.kernel.org
Cc: tim.c.chen@intel.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [RFC] sched/fair: Mitigate the impact of retrieving tg->load_avg
Date: Mon, 14 Jul 2025 16:29:14 -0700
Message-ID: <20250714232915.523679-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce the impact of update_cfs_group()/update_load_avg() by reducing
the frequency that tg->load_avg is retrieved.

This is "the other side" of commit 1528c661c24b ("sched/fair:
Ratelimit update to tg->load_avg"), which reduced the frequency of the
"store" side, now it's reducing the frequency of the "load" side.

Sending as a RFC because I want to point out that there is still
contention when updating/loading the load_avg of a group, I do not
believe that this particular piece of code is the solution.

On a series[1] with a similar objective (and independent), it was
pointed out that perhaps the effort was best spent on something like
this:

https://lore.kernel.org/all/20190906191237.27006-1-riel@surriel.com/

Would that be the way to go?

Just to make it a bit more fancy, some perf numbers, running:

$ ./schbench -r 60

* current master:
-   68.38%     0.05%  schbench         schbench                     [.] worker_thread
   - 68.37% worker_thread
      - 56.70% asm_sysvec_apic_timer_interrupt
         - 56.10% sysvec_apic_timer_interrupt
            - 54.32% __sysvec_apic_timer_interrupt
               - 54.11% hrtimer_interrupt
                  - 49.99% __hrtimer_run_queues
                     - 48.08% tick_nohz_handler
                        - 47.02% update_process_times
                           - 39.41% sched_tick
                              - 27.31% task_tick_fair
                                   12.88% update_cfs_group
                                 - 9.61% update_load_avg
                                      3.52% __update_load_avg_cfs_rq
                                      0.72% __update_load_avg_se

* patched kernel:
-   66.27%     0.05%  schbench         schbench                     [.] worker_thread
   - 66.26% worker_thread
      - 52.47% asm_sysvec_apic_timer_interrupt
         - 51.87% sysvec_apic_timer_interrupt
            - 50.19% __sysvec_apic_timer_interrupt
               - 49.97% hrtimer_interrupt
                  - 45.06% __hrtimer_run_queues
                     - 42.77% tick_nohz_handler
                        - 41.64% update_process_times
                           - 33.32% sched_tick
                              - 19.33% task_tick_fair
                                 - 7.72% update_load_avg
                                      4.24% __update_load_avg_cfs_rq
                                      0.80% __update_load_avg_se
                                   6.63% update_cfs_group

I can see some improvements in schbench, but seem to be in the noise.

[1] https://lore.kernel.org/all/20250605142851.GU39944@noisy.programming.kicks-ass.net/

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb..c23c6e45f49d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3980,6 +3980,7 @@ static void update_cfs_group(struct sched_entity *se)
 {
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
 	long shares;
+	u64 now;
 
 	/*
 	 * When a group becomes empty, preserve its weight. This matters for
@@ -3991,6 +3992,14 @@ static void update_cfs_group(struct sched_entity *se)
 	if (throttled_hierarchy(gcfs_rq))
 		return;
 
+	/*
+	 * For migration heavy workloads, access to tg->load_avg can be
+	 * unbound. Limit the update rate to at most once per ms.
+	 */
+	now = sched_clock_cpu(cpu_of(rq_of(gcfs_rq)));
+	if (now - gcfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
+		return;
+
 #ifndef CONFIG_SMP
 	shares = READ_ONCE(gcfs_rq->tg->shares);
 #else
-- 
2.50.1



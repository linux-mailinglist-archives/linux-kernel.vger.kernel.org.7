Return-Path: <linux-kernel+bounces-882722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C52C2B3C7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8849918933ED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3653016E5;
	Mon,  3 Nov 2025 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="f5/Dudfw"
Received: from mail12.out.titan.email (mail12.out.titan.email [18.198.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3103002A6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167936; cv=none; b=GbBMvkmjX9C0YZJKmZIF4Tnk8ZgnX2U+gGSIFk7uCh2kxFWC+M9SilhEkP5A7Yx0ONR+EXw00kx1AQeX0h4k/oN5oIOZ9OrhXjVsMODXzujsCEZDdCHbDMk+ye4t5Tsdyt4py4ieUhuc8fFdBXIg1uNJNyTKFN3Uxb7hn0kxirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167936; c=relaxed/simple;
	bh=RJiQh0fn70Qt8HZ4464d+IkW9vY5Y4avI/iLVB8OjLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNg0LkerHSmK19DTwP6cEEFFSR5zBJarIFJ187NEsZ6EcN1RF3RzbHQ9Ec7y2oxogRCiolXubJTsIT9Qm79TrAGOPK+31WsQ+lH1nlO6huAt/BxK4gHJHd2o47AnPz8F5hxfKj+xgJFU0VJWFgF8HP4vXxS25vyWKBw9YXQhiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=f5/Dudfw; arc=none smtp.client-ip=18.198.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4d0TJh10N2z4vxc;
	Mon,  3 Nov 2025 11:05:24 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=l4KEJYUVU1ZJel5TkyCetEKX/2WXPoP3gS4L1oT06FI=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=from:to:cc:in-reply-to:mime-version:message-id:subject:date:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1762167924; v=1;
	b=f5/DudfwRWlo9YPmqtQhxp6fMCxKKN7Yw3UnU0LRK2ICTKmIHch9r99HUZdjvoJYtEKEf3eB
	yJIJ/F+ShUPnV4y/TVVw4mvYVuJnV14vxGcPFwZ0nWzmQRN/bNVO3EqFYcxWTShFliFEiHODqst
	+kpWRVXcFCfJFQ6EnmTJ8J6Y=
Received: from morpheus.112glenside.lan (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4d0TJg3XHNz4vxk;
	Mon,  3 Nov 2025 11:05:23 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with EEVDF goals
Date: Mon,  3 Nov 2025 11:04:45 +0000
Message-ID: <20251103110445.3503887-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103110445.3503887-1-mgorman@techsingularity.net>
References: <20251103110445.3503887-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1762167923960564691.2237.2697725694371776351@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=AMAIbF65 c=1 sm=1 tr=0 ts=69088c73
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8 a=u0Zm40m9y2-Q5bzOmhEA:9
	a=L2g4Dz8VuBQ37YGmWQah:22

Reimplement NEXT_BUDDY preemption to take into account the deadline and
eligibility of the wakee with respect to the waker. In the event
multiple buddies could be considered, the one with the earliest deadline
is selected.

Sync wakeups are treated differently to every other type of wakeup. The
WF_SYNC assumption is that the waker promises to sleep in the very near
future. This is violated in enough cases that WF_SYNC should be treated
as a suggestion instead of a contract. If a waker does go to sleep almost
immediately then the delay in wakeup is negligible. In all other cases,
it's throttled based on the accumulated runtime of the waker so there is
a chance that some batched wakeups have been issued before preemption.

For all other wakeups, preemption happens if the wakee has a earlier
deadline than the waker and eligible to run.

While many workloads were tested, the two main targets were a modified
dbench4 benchmark and hackbench because the are on opposite ends of the
spectrum -- one prefers throughput by avoiding preemption and the other
relies on preemption.

First is the dbench throughput data even though it is a poor metric but
it is the default metric. The test machine is a 2-socket machine and the
backing filesystem is XFS as a lot of the IO work is dispatched to kernel
threads. It's important to note that these results are not representative
across all machines, especially Zen machines, as different bottlenecks
are exposed on different machines and filesystems.

dbench4 Throughput (misleading but traditional)
                            6.18-rc1               6.18-rc1
                             vanilla   sched-preemptnext-v4
Hmean     1       1268.80 (   0.00%)     1268.92 (   0.01%)
Hmean     4       3971.74 (   0.00%)     3952.44 (  -0.49%)
Hmean     7       5548.23 (   0.00%)     5375.49 *  -3.11%*
Hmean     12      7310.86 (   0.00%)     7080.80 (  -3.15%)
Hmean     21      8874.53 (   0.00%)     9044.30 (   1.91%)
Hmean     30      9361.93 (   0.00%)    10430.80 *  11.42%*
Hmean     48      9540.14 (   0.00%)    11786.28 *  23.54%*
Hmean     79      9208.74 (   0.00%)    11910.07 *  29.33%*
Hmean     110     8573.12 (   0.00%)    11571.03 *  34.97%*
Hmean     141     7791.33 (   0.00%)    11151.69 *  43.13%*
Hmean     160     7666.60 (   0.00%)    10661.53 *  39.06%*

As throughput is misleading, the benchmark is modified to use a short
loadfile report the completion time duration in milliseconds.

dbench4 Loadfile Execution Time
                             6.18-rc1               6.18-rc1
                              vanilla   sched-preemptnext-v4
Amean      1         14.62 (   0.00%)       14.69 (  -0.50%)
Amean      4         18.76 (   0.00%)       18.88 (  -0.63%)
Amean      7         23.71 (   0.00%)       24.52 (  -3.43%)
Amean      12        31.25 (   0.00%)       32.20 (  -3.03%)
Amean      21        45.12 (   0.00%)       44.19 (   2.05%)
Amean      30        61.07 (   0.00%)       54.74 (  10.35%)
Amean      48        95.91 (   0.00%)       77.52 (  19.18%)
Amean      79       163.38 (   0.00%)      126.04 (  22.85%)
Amean      110      243.91 (   0.00%)      179.93 (  26.23%)
Amean      141      343.47 (   0.00%)      240.03 (  30.12%)
Amean      160      401.15 (   0.00%)      284.92 (  28.98%)

That is still looking good and the variance is reduced quite a bit with
the caveat that different CPU families may yield different results.

Fairness is a concern so the next report tracks how many milliseconds
does it take for all clients to complete a workfile. This one is tricky
because dbench makes no effort to synchronise clients so the durations at
benchmark start time differ substantially from typical runtimes. Depending
on the configuration, the benchmark can be dominated by the timing of
fsync of different clients. This problem could be mitigated by warming up
the benchmark for a number of minutes but it's a matter of opinion whether
that counts as an evasion of inconvenient results.

dbench4 All Clients Loadfile Execution Time
                             6.18-rc1               6.18-rc1
                              vanilla   sched-preemptnext-v4
Amean      1         15.06 (   0.00%)       15.10 (  -0.27%)
Amean      4        603.81 (   0.00%)     1451.94 (-140.46%)
Amean      7        855.32 (   0.00%)     1116.68 ( -30.56%)
Amean      12      1890.02 (   0.00%)     2075.98 (  -9.84%)
Amean      21      3195.23 (   0.00%)     2508.86 (  21.48%)
Amean      30     13919.53 (   0.00%)     3324.58 (  76.12%)
Amean      48     25246.07 (   0.00%)     4146.10 (  83.58%)
Amean      79     29701.84 (   0.00%)    21338.68 (  28.16%)
Amean      110    22803.03 (   0.00%)    29502.47 ( -29.38%)
Amean      141    36356.07 (   0.00%)    25292.07 (  30.43%)
Amean      160    17046.71 (   0.00%)    27043.67 ( -58.64%)
Stddev     1          0.47 (   0.00%)        0.46 (   2.84%)
Stddev     4        395.24 (   0.00%)      782.96 ( -98.10%)
Stddev     7        467.24 (   0.00%)      738.26 ( -58.00%)
Stddev     12      1071.43 (   0.00%)     1124.78 (  -4.98%)
Stddev     21      1694.50 (   0.00%)     1463.27 (  13.65%)
Stddev     30      7945.63 (   0.00%)     1889.19 (  76.22%)
Stddev     48     14339.51 (   0.00%)     2226.59 (  84.47%)
Stddev     79     16620.91 (   0.00%)    12027.14 (  27.64%)
Stddev     110    12912.15 (   0.00%)    16601.77 ( -28.57%)
Stddev     141    20700.13 (   0.00%)    13624.50 (  34.18%)
Stddev     160     9079.16 (   0.00%)    15729.63 ( -73.25%)

This is more of a mixed bag but it at least shows that fairness
is not crippled.

The hackbench results are more neutral but this is still important.
It's possible to boost the dbench figures by a large amount but only by
crippling the performance of a workload like hackbench.

hackbench-process-pipes
                          6.18-rc1             6.18-rc1
                             vanilla   sched-preemptnext-v4
Amean     1        0.2657 (   0.00%)      0.2120 (  20.20%)
Amean     4        0.6107 (   0.00%)      0.6120 (  -0.22%)
Amean     7        0.7923 (   0.00%)      0.7307 (   7.78%)
Amean     12       1.1500 (   0.00%)      1.1480 (   0.17%)
Amean     21       1.7950 (   0.00%)      1.8207 (  -1.43%)
Amean     30       2.3207 (   0.00%)      2.5340 *  -9.19%*
Amean     48       3.5023 (   0.00%)      4.0047 * -14.34%*
Amean     79       4.8093 (   0.00%)      5.3137 * -10.49%*
Amean     110      6.1160 (   0.00%)      6.5287 *  -6.75%*
Amean     141      7.4763 (   0.00%)      7.9553 *  -6.41%*
Amean     172      8.9560 (   0.00%)      9.3977 *  -4.93%*
Amean     203     10.4783 (   0.00%)     11.0160 *  -5.13%*
Amean     234     12.4977 (   0.00%)     13.5510 (  -8.43%)
Amean     265     14.7003 (   0.00%)     15.6950 *  -6.77%*
Amean     296     16.1007 (   0.00%)     17.0860 *  -6.12%*

Processes using pipes are impacted but the variance (not presented)
is bad enough that it's close to noise. These results are not always
reproducible. If executed across multiple reboots, it may show neutral or
small gains so the worst measured results are presented.

Hackbench using sockets is more reliably neutral as the wakeup
mechanisms are different between sockets and pipes.

hackbench-process-sockets
                          6.18-rc1             6.18-rc1
                             vanilla   sched-preemptnext-v4
Amean     1        0.3073 (   0.00%)      0.3187 (  -3.69%)
Amean     4        0.7863 (   0.00%)      0.7850 (   0.17%)
Amean     7        1.3670 (   0.00%)      1.3747 (  -0.56%)
Amean     12       2.1337 (   0.00%)      2.1450 (  -0.53%)
Amean     21       3.4683 (   0.00%)      3.4293 (   1.12%)
Amean     30       4.7247 (   0.00%)      4.8000 (  -1.59%)
Amean     48       7.6097 (   0.00%)      7.6943 (  -1.11%)
Amean     79      14.7957 (   0.00%)     15.3353 (  -3.65%)
Amean     110     21.3413 (   0.00%)     21.5753 (  -1.10%)
Amean     141     29.0503 (   0.00%)     28.8740 (   0.61%)
Amean     172     36.4660 (   0.00%)     35.7207 (   2.04%)
Amean     203     39.7177 (   0.00%)     39.7343 (  -0.04%)
Amean     234     42.1120 (   0.00%)     43.0177 (  -2.15%)
Amean     265     45.7830 (   0.00%)     46.9863 (  -2.63%)
Amean     296     50.7043 (   0.00%)     50.7017 (   0.01%)

As schbench has been mentioned in numerous bugs recently, the results
are interesting. A test case that represents the default schbench
behaviour is

schbench Wakeup Latency (usec)
                                       6.18.0-rc1             6.18.0-rc1
                                          vanilla   sched-preemptnext-v4
Amean     Wakeup-50th-80          7.17 (   0.00%)        6.00 *  16.28%*
Amean     Wakeup-90th-80         46.56 (   0.00%)       19.61 *  57.88%*
Amean     Wakeup-99th-80        119.61 (   0.00%)       87.28 *  27.03%*
Amean     Wakeup-99.9th-80     3193.78 (   0.00%)      367.00 *  88.51%*
Amean     Wakeup-max-80        3874.28 (   0.00%)     3951.39 (  -1.99%)


schbench Requests Per Second (ops/sec)
                                  6.18.0-rc1             6.18.0-rc1
                                     vanilla sched-preemptnext-v4r1
Hmean     RPS-20th-80     8900.91 (   0.00%)     9167.86 *   3.00%*
Hmean     RPS-50th-80     8987.41 (   0.00%)     9213.06 *   2.51%*
Hmean     RPS-90th-80     9123.73 (   0.00%)     9263.80 (   1.54%)
Hmean     RPS-max-80      9193.50 (   0.00%)     9282.18 (   0.96%)

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 145 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 123 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc0b7ce8a65d..688bf010f444 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -955,6 +955,16 @@ static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq, bool protect)
 	if (cfs_rq->nr_queued == 1)
 		return curr && curr->on_rq ? curr : se;
 
+	/*
+	 * Picking the ->next buddy will affect latency but not fairness.
+	 */
+	if (sched_feat(PICK_BUDDY) &&
+	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
+		/* ->next will never be delayed */
+		WARN_ON_ONCE(cfs_rq->next->sched_delayed);
+		return cfs_rq->next;
+	}
+
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
@@ -1193,6 +1203,8 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
 	return delta_exec;
 }
 
+static void set_next_buddy(struct sched_entity *se);
+
 /*
  * Used by other classes to account runtime.
  */
@@ -5512,16 +5524,6 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *se;
 
-	/*
-	 * Picking the ->next buddy will affect latency but not fairness.
-	 */
-	if (sched_feat(PICK_BUDDY) &&
-	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
-		/* ->next will never be delayed */
-		WARN_ON_ONCE(cfs_rq->next->sched_delayed);
-		return cfs_rq->next;
-	}
-
 	se = pick_eevdf(cfs_rq);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
@@ -7028,8 +7030,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	hrtick_update(rq);
 }
 
-static void set_next_buddy(struct sched_entity *se);
-
 /*
  * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
  * failing half-way through and resume the dequeue later.
@@ -8725,6 +8725,91 @@ static void set_next_buddy(struct sched_entity *se)
 	}
 }
 
+enum preempt_wakeup_action {
+	PREEMPT_WAKEUP_NONE,		/* No action on the buddy */
+	PREEMPT_WAKEUP_SHORT,		/* Override current's slice
+					 * protection to allow
+					 * preemption.
+					 */
+	PREEMPT_WAKEUP_NEXT,		/* Check next is most eligible
+					 * before rescheduling.
+					 */
+	PREEMPT_WAKEUP_RESCHED,		/* Plain reschedule */
+};
+
+static inline enum preempt_wakeup_action
+__do_preempt_buddy(struct rq *rq, struct cfs_rq *cfs_rq, int wake_flags,
+		 struct sched_entity *pse, struct sched_entity *se)
+{
+	bool pse_before;
+
+	/*
+	 * Ignore wakee preemption on WF_FORK as it is less likely that
+	 * there is shared data as exec often follow fork. Do not
+	 * preempt for tasks that are sched_delayed as it would violate
+	 * EEVDF to forcibly queue an ineligible task.
+	 */
+	if ((wake_flags & WF_FORK) || pse->sched_delayed)
+		return PREEMPT_WAKEUP_NONE;
+
+	/* Reschedule if waker is no longer eligible. */
+	if (in_task() && !entity_eligible(cfs_rq, se))
+		return PREEMPT_WAKEUP_RESCHED;
+
+	/*
+	 * Keep existing buddy if the deadline is sooner than pse.
+	 * The older buddy may be cache cold and completely unrelated
+	 * to the current wakeup but that is unpredictable where as
+	 * obeying the deadline is more in line with EEVDF objectives.
+	 */
+	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
+		return PREEMPT_WAKEUP_NEXT;
+
+	set_next_buddy(pse);
+
+	/*
+	 * WF_SYNC|WF_TTWU indicates the waker expects to sleep but it is not
+	 * strictly enforced because the hint is either misunderstood or
+	 * multiple tasks must be woken up.
+	 */
+	pse_before = entity_before(pse, se);
+	if (wake_flags & WF_SYNC) {
+		u64 delta = rq_clock_task(rq) - se->exec_start;
+		u64 threshold = sysctl_sched_migration_cost;
+
+		/*
+		 * WF_SYNC without WF_TTWU is not expected so warn if it
+		 * happens even though it is likely harmless.
+		 */
+		WARN_ON_ONCE(!(wake_flags & WF_TTWU));
+
+		if ((s64)delta < 0)
+			delta = 0;
+
+		/*
+		 * WF_RQ_SELECTED implies the tasks are stacking on a
+		 * CPU when they could run on other CPUs. Reduce the
+		 * threshold before preemption is allowed to an
+		 * arbitrary lower value as it is more likely (but not
+		 * guaranteed) the waker requires the wakee to finish.
+		 */
+		if (wake_flags & WF_RQ_SELECTED)
+			threshold >>= 2;
+
+		/*
+		 * As WF_SYNC is not strictly obeyed, allow some runtime for
+		 * batch wakeups to be issued.
+		 */
+		if (pse_before && delta >= threshold)
+			return PREEMPT_WAKEUP_RESCHED;
+
+		return PREEMPT_WAKEUP_NONE;
+	}
+
+	return PREEMPT_WAKEUP_NEXT;
+}
+
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -8734,7 +8819,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	struct sched_entity *se = &donor->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
-	bool do_preempt_short = false;
+	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_NONE;
 
 	if (unlikely(se == pse))
 		return;
@@ -8748,10 +8833,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (task_is_throttled(p))
 		return;
 
-	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
-		set_next_buddy(pse);
-	}
-
 	/*
 	 * We can come here with TIF_NEED_RESCHED already set from new task
 	 * wake up path.
@@ -8783,7 +8864,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 		 * When non-idle entity preempt an idle entity,
 		 * don't give idle entity slice protection.
 		 */
-		do_preempt_short = true;
+		preempt_action = PREEMPT_WAKEUP_SHORT;
 		goto preempt;
 	}
 
@@ -8802,21 +8883,41 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * If @p has a shorter slice than current and @p is eligible, override
 	 * current's slice protection in order to allow preemption.
 	 */
-	do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
+	if (sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice)) {
+		preempt_action = PREEMPT_WAKEUP_SHORT;
+	} else {
+		/*
+		 * If @p potentially is completing work required by current then
+		 * consider preemption.
+		 */
+		preempt_action = __do_preempt_buddy(rq, cfs_rq, wake_flags,
+						      pse, se);
+	}
+
+	switch (preempt_action) {
+	case PREEMPT_WAKEUP_NONE:
+		return;
+	case PREEMPT_WAKEUP_RESCHED:
+		goto preempt;
+	case PREEMPT_WAKEUP_SHORT:
+		fallthrough;
+	case PREEMPT_WAKEUP_NEXT:
+		break;
+	}
 
 	/*
 	 * If @p has become the most eligible task, force preemption.
 	 */
-	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
+	if (__pick_eevdf(cfs_rq, preempt_action != PREEMPT_WAKEUP_SHORT) == pse)
 		goto preempt;
 
-	if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
+	if (sched_feat(RUN_TO_PARITY))
 		update_protect_slice(cfs_rq, se);
 
 	return;
 
 preempt:
-	if (do_preempt_short)
+	if (preempt_action == PREEMPT_WAKEUP_SHORT)
 		cancel_protect_slice(se);
 
 	resched_curr_lazy(rq);
-- 
2.51.0



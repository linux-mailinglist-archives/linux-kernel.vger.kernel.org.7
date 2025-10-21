Return-Path: <linux-kernel+bounces-863127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD67BF7165
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EE5546130
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6B338F38;
	Tue, 21 Oct 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="gyLblOAn"
Received: from mail13.out.titan.email (mail13.out.titan.email [18.198.78.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97481AA8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.78.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056952; cv=none; b=UJ6Y4/EXyu2M5aZmXVPvBz4eQ/agcO3fACekHDmxppTqkdgZvUOswHvqytrlPGDEH5NoKQraOAJnWUqmwBLfEeJ2JuzEWENth65WFEXLK7vg6WFZFboLiloXxS3eGbZD74OZjwULUGXHmaCN68Og8yI8vp8WOq48Kf6t64hmRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056952; c=relaxed/simple;
	bh=cNiVcLO4tmriaUGYoS3Vrt/D7BKDd7SJ/MQaZcxtYKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5TUC+9b0B0RWhWopsZOsOCxH0nkS3Sxf4sFF8hNF/xTJe6Kk1Ui4aCEzHivlFIauw82YZT5EDHetkwOLXgdnuWtRvcjZ4PwuGwc55mTCkR5qmSztJzW81bJ8Xm/m5hYT7ZA1lHXtMsSC/akjAG99m/JWx5mQNkjl5PoCLddV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=gyLblOAn; arc=none smtp.client-ip=18.198.78.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4crZRh0t8Mz4vxc;
	Tue, 21 Oct 2025 14:29:04 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=/RBDbQMmjkuaHE7VYekVQH6m/M4Uy1uIbt6z5pofCzQ=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=to:mime-version:from:cc:in-reply-to:references:subject:date:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1761056944; v=1;
	b=gyLblOAnWl/cylpOloF7PcbPi5ig76+UBp7rcbVhSq6Ed4R1tKWX1/6Vop8jopdA+Vmi9hYI
	+mxDuCQPp7WcaG2h7m6njtbpi76Qo5pjXc+gTURzA+v2Qs2gN3pfXXO/TNHOAqWjLIJnnue6gWO
	Oy0H4UOFoMP+1x8ZfWY2vRo0=
Received: from morpheus.112glenside.lan (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4crZRg3Mwjz4vxH;
	Tue, 21 Oct 2025 14:29:03 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with EEVDF goals
Date: Tue, 21 Oct 2025 15:28:24 +0100
Message-ID: <20251021142824.3747201-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021142824.3747201-1-mgorman@techsingularity.net>
References: <20251021142824.3747201-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1761056943935479570.2237.1947000623164996086@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=Rqw/LDmK c=1 sm=1 tr=0 ts=68f798af
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8 a=x5qEnlsdewY2P8x_8gIA:9
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
                             vanilla   sched-preemptnext-v2
Hmean     1       1268.80 (   0.00%)     1285.93 *   1.35%*
Hmean     4       3971.74 (   0.00%)     3851.10 *  -3.04%*
Hmean     7       5548.23 (   0.00%)     5507.07 (  -0.74%)
Hmean     12      7310.86 (   0.00%)     7205.37 (  -1.44%)
Hmean     21      8874.53 (   0.00%)     9193.66 *   3.60%*
Hmean     30      9361.93 (   0.00%)    10552.03 *  12.71%*
Hmean     48      9540.14 (   0.00%)    11936.22 *  25.12%*
Hmean     79      9208.74 (   0.00%)    12367.06 *  34.30%*
Hmean     110     8573.12 (   0.00%)    12114.01 *  41.30%*
Hmean     141     7791.33 (   0.00%)    11391.60 *  46.21%*
Hmean     160     7666.60 (   0.00%)    10789.23 *  40.73%*

As throughput is misleading, the benchmark is modified to use a short
loadfile report the completion time duration in milliseconds.

dbench4 Loadfile Execution Time
                             6.18-rc1               6.18-rc1
                              vanilla   sched-preemptnext-v2
Amean      1         14.62 (   0.00%)       14.21 (   2.80%)
Amean      4         18.76 (   0.00%)       19.45 (  -3.67%)
Amean      7         23.71 (   0.00%)       23.82 (  -0.48%)
Amean      12        31.25 (   0.00%)       31.78 (  -1.69%)
Amean      21        45.12 (   0.00%)       43.53 (   3.52%)
Amean      30        61.07 (   0.00%)       54.13 (  11.37%)
Amean      48        95.91 (   0.00%)       76.51 (  20.23%)
Amean      79       163.38 (   0.00%)      121.46 (  25.66%)
Amean      110      243.91 (   0.00%)      172.56 (  29.25%)
Amean      141      343.47 (   0.00%)      236.07 (  31.27%)
Amean      160      401.15 (   0.00%)      283.64 (  29.29%)
Stddev     1          0.52 (   0.00%)        0.44 (  15.50%)
Stddev     4          1.36 (   0.00%)        1.42 (  -4.91%)
Stddev     7          1.88 (   0.00%)        1.84 (   2.27%)
Stddev     12         3.06 (   0.00%)        2.55 (  16.57%)
Stddev     21         5.78 (   0.00%)        3.70 (  35.90%)
Stddev     30         9.85 (   0.00%)        5.10 (  48.26%)
Stddev     48        22.31 (   0.00%)        8.30 (  62.79%)
Stddev     79        35.96 (   0.00%)       16.79 (  53.31%)
Stddev     110       59.04 (   0.00%)       30.08 (  49.04%)
Stddev     141       85.38 (   0.00%)       47.05 (  44.89%)
Stddev     160       96.38 (   0.00%)       47.27 (  50.95%)

That is still looking good and the variance is reduced quite a bit.
Finally, fairness is a concern so the next report tracks how many
milliseconds does it take for all clients to complete a workfile. This
one is tricky because dbench makes to effort to synchronise clients so
the durations at benchmark start time differ substantially from typical
runtimes. This problem could be mitigated by warming up the benchmark
for a number of minutes but it's a matter of opinion whether that
counts as an evasion of inconvenient results.

dbench4 All Clients Loadfile Execution Time
                             6.18-rc1               6.18-rc1
                              vanilla   sched-preemptnext-v2
Amean      1         14.93 (   0.00%)       14.91 (   0.11%)
Amean      4        348.88 (   0.00%)      277.06 (  20.59%)
Amean      7        722.94 (   0.00%)      991.70 ( -37.18%)
Amean      12      2055.72 (   0.00%)     2684.48 ( -30.59%)
Amean      21      4393.85 (   0.00%)     2625.79 (  40.24%)
Amean      30      6119.84 (   0.00%)     2491.15 (  59.29%)
Amean      48     20600.85 (   0.00%)     6717.61 (  67.39%)
Amean      79     22677.38 (   0.00%)    21866.80 (   3.57%)
Amean      110    35937.71 (   0.00%)    22517.63 (  37.34%)
Amean      141    25104.66 (   0.00%)    29897.08 ( -19.09%)
Amean      160    23843.74 (   0.00%)    23106.66 (   3.09%)
Stddev     1          0.50 (   0.00%)        0.46 (   6.67%)
Stddev     4        201.33 (   0.00%)      130.13 (  35.36%)
Stddev     7        471.94 (   0.00%)      641.69 ( -35.97%)
Stddev     12      1401.94 (   0.00%)     1750.14 ( -24.84%)
Stddev     21      2519.12 (   0.00%)     1416.77 (  43.76%)
Stddev     30      3469.05 (   0.00%)     1293.37 (  62.72%)
Stddev     48     11521.49 (   0.00%)     3846.34 (  66.62%)
Stddev     79     12849.21 (   0.00%)    12275.89 (   4.46%)
Stddev     110    20362.88 (   0.00%)    12989.46 (  36.21%)
Stddev     141    13768.42 (   0.00%)    17108.34 ( -24.26%)
Stddev     160    13196.34 (   0.00%)    13029.75 (   1.26%)

This is more of a mixed bag but it at least shows that fairness
is not crippled.

The hackbench results are more neutral but this is still important.
It's possible to boost the dbench figures by a large amount but only by
crippling the performance of a workload like hackbench.

hackbench-process-pipes
                          6.18-rc1             6.18-rc1
                             vanilla   sched-preemptnext-v2
Amean     1        0.2657 (   0.00%)      0.2180 (  17.94%)
Amean     4        0.6107 (   0.00%)      0.5237 (  14.25%)
Amean     7        0.7923 (   0.00%)      0.7357 (   7.15%)
Amean     12       1.1500 (   0.00%)      1.1210 (   2.52%)
Amean     21       1.7950 (   0.00%)      1.8220 (  -1.50%)
Amean     30       2.3207 (   0.00%)      2.5337 *  -9.18%*
Amean     48       3.5023 (   0.00%)      4.0057 * -14.37%*
Amean     79       4.8093 (   0.00%)      5.1827 *  -7.76%*
Amean     110      6.1160 (   0.00%)      6.5667 *  -7.37%*
Amean     141      7.4763 (   0.00%)      7.9413 *  -6.22%*
Amean     172      8.9560 (   0.00%)      9.5543 *  -6.68%*
Amean     203     10.4783 (   0.00%)     11.3620 *  -8.43%*
Amean     234     12.4977 (   0.00%)     13.6183 (  -8.97%)
Amean     265     14.7003 (   0.00%)     15.3720 *  -4.57%*
Amean     296     16.1007 (   0.00%)     17.2463 *  -7.12%*

Processes using pipes are impacted but the variance (not presented)
is bad enough that it's close to noise. These results are not always
reproducible. If executed across multiple reboots, it may show neutral or
small gains so the worst measured results are presented.

Hackbench using sockets is more reliably neutral as the wakeup
mechanisms are different between sockets and pipes.

hackbench-process-sockets
                          6.18-rc1             6.18-rc1
                             vanilla   sched-preemptnext-v2
Amean     1        0.3073 (   0.00%)      0.3333 (  -8.46%)
Amean     4        0.7863 (   0.00%)      0.7350 (   6.53%)
Amean     7        1.3670 (   0.00%)      1.3580 (   0.66%)
Amean     12       2.1337 (   0.00%)      2.1320 (   0.08%)
Amean     21       3.4683 (   0.00%)      3.4677 (   0.02%)
Amean     30       4.7247 (   0.00%)      4.8200 (  -2.02%)
Amean     48       7.6097 (   0.00%)      7.8383 (  -3.00%)
Amean     79      14.7957 (   0.00%)     15.2863 (  -3.32%)
Amean     110     21.3413 (   0.00%)     21.7297 (  -1.82%)
Amean     141     29.0503 (   0.00%)     29.1197 (  -0.24%)
Amean     172     36.4660 (   0.00%)     36.3173 (   0.41%)
Amean     203     39.7177 (   0.00%)     40.2843 (  -1.43%)
Amean     234     42.1120 (   0.00%)     43.8480 (  -4.12%)
Amean     265     45.7830 (   0.00%)     48.1233 (  -5.11%)
Amean     296     50.7043 (   0.00%)     54.2533 (  -7.00%)

As schbench has been mentioned in numerous bugs recently, the results
are interesting. A test case that represents the default schbench
behaviour is

schbench Wakeup Latency (usec)
                                       6.18.0-rc1             6.18.0-rc1
                                          vanilla sched-preemptnext-v2r1
Amean     Wakeup-50th-80          7.17 (   0.00%)        6.00 *  16.28%*
Amean     Wakeup-90th-80         46.56 (   0.00%)       20.56 *  55.85%*
Amean     Wakeup-99th-80        119.61 (   0.00%)       88.83 (  25.73%)
Amean     Wakeup-99.9th-80     3193.78 (   0.00%)      339.78 *  89.36%*
Amean     Wakeup-max-80        3874.28 (   0.00%)     3942.06 (  -1.75%)

schbench Requests Per Second (ops/sec)
                                  6.18.0-rc1             6.18.0-rc1
                                     vanilla sched-preemptnext-v2r1
Hmean     RPS-20th-80     8900.91 (   0.00%)     9148.18 *   2.78%*
Hmean     RPS-50th-80     8987.41 (   0.00%)     9199.72 (   2.36%)
Hmean     RPS-90th-80     9123.73 (   0.00%)     9233.56 (   1.20%)
Hmean     RPS-max-80      9193.50 (   0.00%)     9249.84 (   0.61%)

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 131 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 111 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc0b7ce8a65d..26413062009b 100644
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
 
@@ -1193,6 +1203,82 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
 	return delta_exec;
 }
 
+enum preempt_wakeup_action {
+	PREEMPT_WAKEUP_NONE,		/* No action on the buddy */
+	PREEMPT_WAKEUP_NEXT,		/* Check next is most eligible
+					 * before rescheduling.
+					 */
+	PREEMPT_WAKEUP_RESCHED,		/* Plain reschedule */
+};
+
+static void set_next_buddy(struct sched_entity *se);
+
+static inline enum preempt_wakeup_action
+__do_preempt_buddy(struct rq *rq, struct cfs_rq *cfs_rq, int wake_flags,
+		 struct sched_entity *pse, struct sched_entity *se,
+		 s64 delta)
+{
+	bool pse_before;
+
+	/*
+	 * Ignore wakee preemption on WF_WORK as it is less likely that
+	 * there is shared data as exec often follow fork. Do not
+	 * preempt for tasks that are sched_delayed as it would violate
+	 * EEVDF to forcibly queue an ineligible task.
+	 */
+	if (!sched_feat(NEXT_BUDDY) ||
+	    (wake_flags & WF_FORK) ||
+	    (pse->sched_delayed)) {
+		return PREEMPT_WAKEUP_NONE;
+	}
+
+	/* Reschedule if waker is no longer eligible. */
+	if (!entity_eligible(cfs_rq, se)) {
+		resched_curr_lazy(rq);
+		return PREEMPT_WAKEUP_RESCHED;
+	}
+
+	/*
+	 * Keep existing buddy if the deadline is sooner than pse.
+	 * The downside is that the older buddy may be cache cold
+	 * but that is unpredictable where as an earlier deadline
+	 * is absolute.
+	 */
+	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
+		return PREEMPT_WAKEUP_NONE;
+
+	set_next_buddy(pse);
+
+	/*
+	 * WF_SYNC|WF_TTWU indicates the waker expects to sleep but it is not
+	 * strictly enforced because the hint is either misunderstood or
+	 * multiple tasks must be woken up.
+	 */
+	pse_before = entity_before(pse, se);
+	if ((wake_flags & (WF_TTWU|WF_SYNC)) == (WF_TTWU|WF_SYNC)) {
+		/*
+		 * WF_RQ_SELECTED implies the tasks are stacking on a
+		 * CPU when they could run on other CPUs. Only consider
+		 * reschedule if pse deadline expires before se.
+		 */
+		if ((wake_flags & WF_RQ_SELECTED) &&
+		    delta < sysctl_sched_migration_cost && pse_before) {
+			return PREEMPT_WAKEUP_NONE;
+		}
+
+		/*
+		 * As WF_SYNC is not strictly obeyed, allow some runtime for
+		 * batch wakeups to be issued.
+		 */
+		if (pse_before && delta >= sysctl_sched_migration_cost)
+			return PREEMPT_WAKEUP_RESCHED;
+
+		return PREEMPT_WAKEUP_NONE;
+	}
+
+	return PREEMPT_WAKEUP_NEXT;
+}
+
 /*
  * Used by other classes to account runtime.
  */
@@ -5512,16 +5598,6 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
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
@@ -7028,8 +7104,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	hrtick_update(rq);
 }
 
-static void set_next_buddy(struct sched_entity *se);
-
 /*
  * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
  * failing half-way through and resume the dequeue later.
@@ -8734,7 +8808,8 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	struct sched_entity *se = &donor->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
-	bool do_preempt_short = false;
+	enum preempt_wakeup_action do_preempt_short = PREEMPT_WAKEUP_NONE;
+	s64 delta;
 
 	if (unlikely(se == pse))
 		return;
@@ -8748,10 +8823,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (task_is_throttled(p))
 		return;
 
-	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
-		set_next_buddy(pse);
-	}
-
 	/*
 	 * We can come here with TIF_NEED_RESCHED already set from new task
 	 * wake up path.
@@ -8783,7 +8854,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 		 * When non-idle entity preempt an idle entity,
 		 * don't give idle entity slice protection.
 		 */
-		do_preempt_short = true;
+		do_preempt_short = PREEMPT_WAKEUP_NEXT;
 		goto preempt;
 	}
 
@@ -8797,12 +8868,31 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 		return;
 
 	cfs_rq = cfs_rq_of(se);
+	delta = rq_clock_task(rq) - se->exec_start;
 	update_curr(cfs_rq);
 	/*
 	 * If @p has a shorter slice than current and @p is eligible, override
 	 * current's slice protection in order to allow preemption.
 	 */
-	do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
+	if (sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice)) {
+		do_preempt_short = PREEMPT_WAKEUP_NEXT;
+	} else {
+		/*
+		 * If @p potentially is completing work required by current then
+		 * consider preemption.
+		 */
+		do_preempt_short = __do_preempt_buddy(rq, cfs_rq, wake_flags,
+						      pse, se, delta);
+	}
+
+	switch (do_preempt_short) {
+	case PREEMPT_WAKEUP_NONE:
+		goto update_slice;
+	case PREEMPT_WAKEUP_RESCHED:
+		goto preempt;
+	case PREEMPT_WAKEUP_NEXT:
+		break;
+	}
 
 	/*
 	 * If @p has become the most eligible task, force preemption.
@@ -8810,7 +8900,8 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
 		goto preempt;
 
-	if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
+update_slice:
+	if (sched_feat(RUN_TO_PARITY) && do_preempt_short != PREEMPT_WAKEUP_NONE)
 		update_protect_slice(cfs_rq, se);
 
 	return;
-- 
2.51.0



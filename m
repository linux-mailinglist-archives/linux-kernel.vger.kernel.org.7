Return-Path: <linux-kernel+bounces-891514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5CC42D35
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 14:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D323ACFE4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE351A4F3C;
	Sat,  8 Nov 2025 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpGI1R2q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D51891AB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762607544; cv=none; b=Frfk8TwB0X1OwZfQgUFl7aU+E6rw16TX66OSoIR4PeQu4NYFuxDCPEwvnJ1T3Dso0uzSj5ap7LzRMqHqd3Om1hnpNGilqRw8mdqfgA7ZnDKVe+MsBGn8/cNkWMU5/BfnGzgKfDggOYfT3S8xrsIKR4YUcgQRmIh/WFRu8XXWfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762607544; c=relaxed/simple;
	bh=PXJiQY4ILAQ5DLy4e0aKa19QrLr+vIBtDAgOMtJG6Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nOCSe0uhWaNtyp89oB0M2z5nMr7XBLWElt8+SIVXlfFBWhHKpUT/zB6ork16OV++kRZHrzqBVIuTasL3Ihp6pK55rrOFIhpQKCD0cYuhI+pO9lz7jmQBmGFOoEw2qnbgIYm49EoR6cjMz7nvv+J21i7gcm5CTMTIqWZMjwR8Bjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpGI1R2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE35CC116C6;
	Sat,  8 Nov 2025 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762607544;
	bh=PXJiQY4ILAQ5DLy4e0aKa19QrLr+vIBtDAgOMtJG6Wk=;
	h=Date:From:To:Cc:Subject:From;
	b=TpGI1R2qeiH5rzzNGRp/ga0OQkyG6VsdtfuLJYeBGoVB6Sutt6iICFyZ7F+ntHMqj
	 glUYRIbRRGU3x0c0pZiBFmbcSs5WJZtMbfA23TmW4wLzm/uUAQoYCEIYFRaVUPGgtM
	 JQPTFEcRtUGfg5uI/Orkgpx0XmgOTPPUpa+yt4h9RD/UqnZfrfkF9lqWAZA61ySAXI
	 e1WfzaOJE5b+/HT1mubxAP678X0VVHuhuuj8DhsdjxPx2CINr3eiuldP7GZ321m8cb
	 jvEKUrEXUQexIVlCy4r7V6dZciB93Zr6dbroCXb89u6qEcUCvzHX6kzXHq7o30DqbN
	 HHs6J8q24OPWg==
Date: Sat, 8 Nov 2025 14:12:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] scheduler fix
Message-ID: <aQ9BsTHEl9jdRtUm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-11-08

   # HEAD: 956dfda6a70885f18c0f8236a461aa2bc4f556ad sched/fair: Prevent cfs_rq from being unthrottled with zero runtime_remaining

Fix a group-throttling bug in the fair scheduler.

 Thanks,

	Ingo

------------------>
Aaron Lu (1):
      sched/fair: Prevent cfs_rq from being unthrottled with zero runtime_remaining


 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 15 ++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67b48e2..f754a60de848 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9606,7 +9606,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
 
 		guard(rq_lock_irq)(rq);
 		cfs_rq->runtime_enabled = runtime_enabled;
-		cfs_rq->runtime_remaining = 0;
+		cfs_rq->runtime_remaining = 1;
 
 		if (cfs_rq->throttled)
 			unthrottle_cfs_rq(cfs_rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..5b752324270b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6024,20 +6024,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
 
 	/*
-	 * It's possible we are called with !runtime_remaining due to things
-	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
-	 * unthrottled us with a positive runtime_remaining but other still
-	 * running entities consumed those runtime before we reached here.
+	 * It's possible we are called with runtime_remaining < 0 due to things
+	 * like async unthrottled us with a positive runtime_remaining but other
+	 * still running entities consumed those runtime before we reached here.
 	 *
-	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
-	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
-	 * throttle, which is not supposed to happen on unthrottle path.
+	 * We can't unthrottle this cfs_rq without any runtime remaining because
+	 * any enqueue in tg_unthrottle_up() will immediately trigger a throttle,
+	 * which is not supposed to happen on unthrottle path.
 	 */
 	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
 		return;
 
-	se = cfs_rq->tg->se[cpu_of(rq)];
-
 	cfs_rq->throttled = 0;
 
 	update_rq_clock(rq);


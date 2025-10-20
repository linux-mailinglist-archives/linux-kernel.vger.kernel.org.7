Return-Path: <linux-kernel+bounces-863431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4692BF7DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56EFC4F78DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD35F34D4E0;
	Tue, 21 Oct 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sXE59hUR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED234C154
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067144; cv=none; b=pDd0l2a4g2D0Aiv9Rv9tgN1E8HvXBOl6Z+g34bwUNM8jflVfBM+LqV6f0zrAxcFsyp9pV9MyzZnITgA0bwiTSnIrxTYaJiS3RQOCCjW6eV/gNXQNbS/wDEqzgpv74rW8uRJFalUJJs9DZVJjxmLi/+eo1N83688QEZ2ehz1A6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067144; c=relaxed/simple;
	bh=m6cgEKFb9Arb2rpn+O7xymJWuEJWSwMU/kcoNfCboUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc7Jt/TjIkTeVq32nevGiH08y+7IJMw1q5unOKjzVJu2FSrA7YLpWPgAwYO2HkFo0rvb2w5tbz5TS5NRgB0h3gBGOFLmxHJsijEkPgcRA4Clf9XrSZFXBGLfsj3SsvhVTXzD2Wq29TCkgSKweej1eNlDdqeNDUYOt70Fm8evx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sXE59hUR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WlUXui7GwTvf97inAADBil42qeMdpvTeuIuUzihHJwQ=; b=sXE59hUROmmKm3yIb3FTqx6uzM
	9XlEAIWJsDF7u5tsJmbsOgf9KknWWG3ph7wsa4k7o/SuaQ4zVcmha6B/mwzxy3R533B8PkvbcJzct
	vQ7kouelA0ay/TDFOwXYXmYQSaxvRPKrXht8Hx+td2sZUZvJpqONGSJvTYv3Rgq9k2gne0Nfn1fpO
	0vor30TaH1YX+waWoGm2JkYXMmEoQbSY7momW9V+naPcG+Eu6zTpAGnR/QVieggKeO3oPXGFi7frb
	SJqRVaNheI1DUDQfxA2GpXhyFkYFwcsdJ4EvUVaAM3va7Ab6eEDHf0zO/THZ5fR5+XISePMsKxpf1
	2g4qr7mw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0e-0000000DsZH-3ioI;
	Tue, 21 Oct 2025 17:18:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 345F63030B3; Mon, 20 Oct 2025 16:11:30 +0200 (CEST)
Date: Mon, 20 Oct 2025 16:11:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>, arighi@nvidia.com
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
References: <20251007122904.31611-1-gmonaco@redhat.com>
 <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
 <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
 <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
 <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
 <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>

On Wed, Oct 15, 2025 at 07:40:18AM +0200, Juri Lelli wrote:
> On 14/10/25 21:33, Peter Zijlstra wrote:
> > On Tue, Oct 14, 2025 at 06:01:10PM +0200, Juri Lelli wrote:
> > 
> > > Shouldn't idle time be accounted (subtracted from runtime) as well, though?
> > 
> > Argh, indeed. Then I suppose we should look at bringing some of that
> > 'idle-for-whole-period' logic to try and actually stop the timer at some
> > point if nothing happens.
> 
> That was my initial thought. If we get to that replenish after a whole
> idle period elapsed, stop the timer (resetting state), so that we can go
> back at defer mode with the next enqueue from fair.

Finally staring at this again; and I'm, as expected, confused again.

So put_prev_task_idle() calls dl_server_update_idle_time(). But this is
only called when we context switch away from idle. The dl_server_timer()
interrupt won't see this, because the interrupt doesn't schedule.

Worse, dl_server_update_idle() only updates p->se.exec_start when it
actually did the update. This means that if !dl_defer, it won't advance
the time, and then when dl_defer it will still see the old timestamp and
include the !dl_defer time.

Also, the enqueue_task_fair() callsite of dl_server_update_idle_time()
is dodgy as heck, the !nr_running check seems to want to ensures p ==
rq->idle, but I'm not sure it actually does.

So how about something like this for starters?

---
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7b7671060bf9..963b85dbc477 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1166,8 +1166,12 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 		sched_clock_tick();
 		update_rq_clock(rq);
 
-		if (!dl_se->dl_runtime)
-			return HRTIMER_NORESTART;
+		/*
+		 * Make sure current has propagated its pending runtime into
+		 * any relevant server through calling dl_server_update() and
+		 * friends.
+		 */
+		rq->curr->sched_class->update_curr(rq);
 
 		if (dl_se->dl_defer_armed) {
 			/*
@@ -1543,35 +1547,16 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * as time available for the fair server, avoiding a penalty for the
  * rt scheduler that did not consumed that time.
  */
-void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	s64 delta_exec;
-
-	if (!rq->fair_server.dl_defer)
-		return;
-
-	/* no need to discount more */
-	if (rq->fair_server.runtime < 0)
-		return;
-
-	delta_exec = rq_clock_task(rq) - p->se.exec_start;
-	if (delta_exec < 0)
-		return;
-
-	rq->fair_server.runtime -= delta_exec;
-
-	if (rq->fair_server.runtime < 0) {
-		rq->fair_server.dl_defer_running = 0;
-		rq->fair_server.runtime = 0;
-	}
-
-	p->se.exec_start = rq_clock_task(rq);
+	if (dl_se->dl_server_active && dl_se->dl_runtime && dl_se->dl_defer)
+		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime = fair server disabled */
-	if (dl_se->dl_runtime)
+	if (dl_se->dl_server_active && dl_se->dl_runtime)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
@@ -1582,6 +1567,11 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
 
+	/*
+	 * Update the current task to 'now'.
+	 */
+	rq->curr->sched_class->update_curr(rq);
+
 	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
 		return;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cee1793e8277..c94c996360e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1239,8 +1239,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		 *    against fair_server such that it can account for this time
 		 *    and possibly avoid running this period.
 		 */
-		if (dl_server_active(&rq->fair_server))
-			dl_server_update(&rq->fair_server, delta_exec);
+		dl_server_update(&rq->fair_server, delta_exec);
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
@@ -6996,12 +6995,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			h_nr_idle = 1;
 	}
 
-	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
-		/* Account for idle runtime */
-		if (!rq->nr_running)
-			dl_server_update_idle_time(rq, rq->curr);
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
 		dl_server_start(&rq->fair_server);
-	}
 
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c39b089d4f09..89cfc26ada46 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -452,9 +452,11 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 	resched_curr(rq);
 }
 
+static void update_curr_idle(struct rq *rq);
+
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
-	dl_server_update_idle_time(rq, prev);
+	update_curr_idle(rq);
 	scx_update_idle(rq, false, true);
 }
 
@@ -511,6 +513,17 @@ prio_changed_idle(struct rq *rq, struct task_struct *p, int oldprio)
 
 static void update_curr_idle(struct rq *rq)
 {
+	struct sched_entity *se = &rq->idle->se;
+	u64 now = rq_clock_task(rq);
+	s64 delta_exec;
+
+	delta_exec = now - se->exec_start;
+	if (unlikely(delta_exec <= 0))
+		return;
+
+	se->exec_start = now;
+
+	dl_server_update_idle(&rq->fair_server, delta_exec);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f5d07067f60..3bb1e59c5944 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -405,6 +405,7 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s6
  * naturally thottled to once per period, avoiding high context switch
  * workloads from spamming the hrtimer program/cancel paths.
  */
+extern void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
@@ -412,8 +413,6 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);
 
-extern void dl_server_update_idle_time(struct rq *rq,
-		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,


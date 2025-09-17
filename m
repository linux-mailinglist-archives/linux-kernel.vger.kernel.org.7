Return-Path: <linux-kernel+bounces-820673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADA9B7D9BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D7E1BC0805
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A624C076;
	Wed, 17 Sep 2025 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UKHve4Zm"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECFE21FF5B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111991; cv=none; b=UHdT/zN6/ScJcjTJTYoi7X9bW+FzxJKgtYtBmTDNuK2L43Z/LRwl+rMBr2g7HtkQwXN5AQW8yGnChlnLYXFVvZQO9K7N1XHPJYfwpMEYNwEvxHutdWNqJWhxBFu+V5xufiBDvEUlsrSYXHgW7Lbx9OEG2J2O86ilKNmNpGlbyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111991; c=relaxed/simple;
	bh=jfWi3kvxLwaivOaLF/QYtCJaijQx5hWXWay926//8EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmRlnc2pG2GKxtz+TH1WLQTcxJFk7YvOeBr8yhjihtw/MAtpJtVo1zCAZ+QV/DqQ3uDt6EZa/EmcJLqDsHPWZ5Sk60UwBW1oSlRekd7ITRc/878XT4ewl+9ZJJZfO0vF7oORzUSs+E/HyexbgwFdjSrdRI6zIoyC9SgAvV94O1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UKHve4Zm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VtS6ju9MSgbkGY/XtCYESN8ItEESiSccYZhTWeb/iec=; b=UKHve4ZmGVG2YjKNJ0F8ISiP7x
	hDi0RWuMTPAdJvtBYQJMoykzsAQ8xOv8ELu7qHvw202MwJjQ/DInSNyErWhfyBR9qkxO95A7WYjZk
	FpEzHUiccbGr2pQzugypHRBOWs8QsQa5l6cmPtUXl1JwGLBBgqZPa0WWT5W301lnu+K7cJ1+8sV52
	if4MY8e+Dx8tiY3a75aJcREAbxVlzk5s4BuTyate3goEHN0FXkx72rdZM0HTz1KbXK/GSf2qAu0sJ
	GMT8Y4euO59Q7sxeeD7qh9lGeo0OF6Gq1mcNtbq+kMM17Kkxx0PqGmsMGgwnCvhel2FqSKnNPP+QK
	aOyOpZMw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyrEn-0000000CY5t-0Lk0;
	Wed, 17 Sep 2025 12:26:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0C06B30056B; Wed, 17 Sep 2025 14:26:16 +0200 (CEST)
Date: Wed, 17 Sep 2025 14:26:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
Message-ID: <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com>
 <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>
 <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
 <CANDhNCqK3VBAxxWMsDez8xkX0vcTStWjRMR95pksUM6Q26Ctyw@mail.gmail.com>
 <20250917093441.GU3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917093441.GU3419281@noisy.programming.kicks-ass.net>

On Wed, Sep 17, 2025 at 11:34:42AM +0200, Peter Zijlstra wrote:

> Yes. This makes sense.
> 
> The old code would disable the dl_server when fair tasks drops to 0
> so even though we had that yield in __pick_task_dl(), we'd never hit it.
> So the moment another fair task shows up (0->1) we re-enqueue the
> dl_server (using update_dl_entity() / CBS wakeup rules) and continue
> consuming bandwidth.
> 
> However, since we're now not stopping the thing, we hit that yield,
> getting this pretty terrible behaviour where we will only run fair tasks
> until there are none and then yield our entire period, forcing another
> task to wait until the next cycle.
> 
> Let me go have a play, surely we can do better.

Can you please try:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent

That's yesterdays patch and the below. Its compile tested only, but
with a bit of luck it'll actually work ;-)

---
Subject: sched/deadline: Fix dl_server behaviour
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Sep 17 12:03:20 CEST 2025

John reported undesirable behaviour with the dl_server since commit:
cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling").

When starving fair tasks on purpose (starting spinning FIFO tasks),
his fair workload, which often goes (briefly) idle, would delay fair
invocations for a second, running one invocation per second was both
unexpected and terribly slow.

The reason this happens is that when dl_se->server_pick_task() returns
NULL, indicating no runnable tasks, it would yield, pushing any later
jobs out a whole period (1 second).

Instead simply stop the server. This should restore behaviour in that
a later wakeup (which restarts the server) will be able to continue
running (subject to the CBS wakeup rules).

Notably, this does not re-introduce the behaviour cccb45d7c4295 set
out to solve, any start/stop cycle is naturally throttled by the timer
period (no active cancel).

Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
Reported-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |    1 -
 kernel/sched/deadline.c |   23 ++---------------------
 kernel/sched/sched.h    |   33 +++++++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 24 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -706,7 +706,6 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
-	unsigned int			dl_server_idle    : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1571,10 +1571,8 @@ void dl_server_update_idle_time(struct r
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime = fair server disabled */
-	if (dl_se->dl_runtime) {
-		dl_se->dl_server_idle = 0;
+	if (dl_se->dl_runtime)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
-	}
 }
 
 void dl_server_start(struct sched_dl_entity *dl_se)
@@ -1602,20 +1600,6 @@ void dl_server_stop(struct sched_dl_enti
 	dl_se->dl_server_active = 0;
 }
 
-static bool dl_server_stopped(struct sched_dl_entity *dl_se)
-{
-	if (!dl_se->dl_server_active)
-		return true;
-
-	if (dl_se->dl_server_idle) {
-		dl_server_stop(dl_se);
-		return true;
-	}
-
-	dl_se->dl_server_idle = 1;
-	return false;
-}
-
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_pick_f pick_task)
 {
@@ -2384,10 +2368,7 @@ static struct task_struct *__pick_task_d
 	if (dl_server(dl_se)) {
 		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
-			if (!dl_server_stopped(dl_se)) {
-				dl_se->dl_yielded = 1;
-				update_curr_dl_se(rq, dl_se, 0);
-			}
+			dl_server_stop(dl_se);
 			goto again;
 		}
 		rq->dl_server = dl_se;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -371,10 +371,39 @@ extern s64 dl_scaled_delta_exec(struct r
  *   dl_server_update() -- called from update_curr_common(), propagates runtime
  *                         to the server.
  *
- *   dl_server_start()
- *   dl_server_stop()  -- start/stop the server when it has (no) tasks.
+ *   dl_server_start() -- start the server when it has tasks; it will stop
+ *			  automatically when there are no more tasks, per
+ *			  dl_se::server_pick() returning NULL.
+ *
+ *   dl_server_stop() -- (force) stop the server; use when updating
+ *                       parameters.
  *
  *   dl_server_init() -- initializes the server.
+ *
+ * When started the dl_server will (per dl_defer) schedule a timer for its
+ * zero-laxity point -- that is, unlike regular EDF tasks which run ASAP, a
+ * server will run at the very end of its period.
+ *
+ * This is done such that any runtime from the target class can be accounted
+ * against the server -- through dl_server_update() above -- such that when it
+ * becomes time to run, it might already be out of runtime and get deferred
+ * until the next period. In this case dl_server_timer() will alternate
+ * between defer and replenish but never actually enqueue the server.
+ *
+ * Only when the target class does not manage to exhaust the server's runtime
+ * (there's actualy starvation in the given period), will the dl_server get on
+ * the runqueue. Once queued it will pick tasks from the target class and run
+ * them until either its runtime is exhaused, at which point its back to
+ * dl_server_timer, or until there are no more tasks to run, at which point
+ * the dl_server stops itself.
+ *
+ * By stopping at this point the dl_server retains bandwidth, which, if a new
+ * task wakes up imminently (starting the server again), can be used --
+ * subject to CBS wakeup rules -- without having to wait for the next period.
+ *
+ * Additionally, because of the dl_defer behaviour the start/stop behaviour is
+ * naturally thottled to once per period, avoiding high context switch
+ * workloads from spamming the hrtimer program/cancel paths.
  */
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);


Return-Path: <linux-kernel+bounces-881027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A087FC273DA
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 01:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E11E44E7DA1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 00:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FEC8C1F;
	Sat,  1 Nov 2025 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dJic4WAl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60C2566
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955267; cv=none; b=Ni9tUr0eWG7kkouGSN5sVhj2JLVvxVoW0SHvuKUGQr5xpqBRaP4bYiwqvra0Kd4JZDKCqGhCqEIakUIs7M+0BgP13FhxotoxxYy/YFJd/q3BMwZbA6zN7G4AN+YLAPksH2jOeBJodJ84ZkNNiithrjURJJP1AaOAuwcw1fgGgoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955267; c=relaxed/simple;
	bh=xz6Huae52+zjZSFtZZ1TJEXOgb6jwELyBu5h7d3nmeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE1QashQ+imLxCn0/a0H3k0fnjrGHnXxFlE41h/CvvPl0XAuLTtYOXOFX53C3AKzudZ2JD0ASfdvjEKPc24zCz8Xwopj8jgwuIN50mCHkRqX9Ifr8EPbZQs2lhNq6IsM0qpMFqT1NrhSK1sxdB4dFUIyAHWwNTvhwC7YnhT2Ib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dJic4WAl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wJBWqGhCLnUh6VL+1eyRUTUHV9N2HpITphi3s8ups4k=; b=dJic4WAlm9fOUnTaMLlbRD5uBk
	tAYuVRnrFl9xE2APFhnynw6d6FmllChUazCuP8fqYu5AtdeVQ4+82bdD+Fv9kocLO/f7Y2gS5nu+A
	xT+R8NMc3jh/w6NRIVaphv3kcXW1hZFtzkGpNjwGvOxb2K4EsmW93DzKlkfsscoh5rUumxZrrV7V7
	Mh4LWG/8wfVmHbGHXf2E3LmFsfF3w6yF9jV+knC6aBi2XwtUpL8oIN+aKu4c2xl7tUp/sXcMz1Xit
	ZpPZMbeB6oNtYRhh5inbM3U41M/U6+BMiY+0HJnnsE1b72HW9ZFOjJii4qqOasDfYfPREI/wWdsoy
	JniFDWxA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEz3B-0000000Bz81-3y3j;
	Sat, 01 Nov 2025 00:00:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB3F5300289; Sat, 01 Nov 2025 01:00:57 +0100 (CET)
Date: Sat, 1 Nov 2025 01:00:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>, arighi@nvidia.com
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251101000057.GA2184199@noisy.programming.kicks-ass.net>
References: <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
 <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
 <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>
 <20251031152005.GT3245006@noisy.programming.kicks-ass.net>
 <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com>
 <20251031154455.GU3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031154455.GU3245006@noisy.programming.kicks-ass.net>

On Fri, Oct 31, 2025 at 04:44:55PM +0100, Peter Zijlstra wrote:

> Anyway, back to noodling on how to make it stop on idle :-)

This seems to behave (at least, it did before the cleanup). 

It has the fancy comment, ascii-art and everything. Hopefully we'll all
get less confused when looking at this in the future.

---
 include/linux/sched.h   |   15 +--
 kernel/sched/deadline.c |  233 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 240 insertions(+), 8 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -685,20 +685,22 @@ struct sched_dl_entity {
 	 *
 	 * @dl_server tells if this is a server entity.
 	 *
-	 * @dl_defer tells if this is a deferred or regular server. For
-	 * now only defer server exists.
-	 *
-	 * @dl_defer_armed tells if the deferrable server is waiting
-	 * for the replenishment timer to activate it.
-	 *
 	 * @dl_server_active tells if the dlserver is active(started).
 	 * dlserver is started on first cfs enqueue on an idle runqueue
 	 * and is stopped when a dequeue results in 0 cfs tasks on the
 	 * runqueue. In other words, dlserver is active only when cpu's
 	 * runqueue has atleast one cfs task.
 	 *
+	 * @dl_defer tells if this is a deferred or regular server. For
+	 * now only defer server exists.
+	 *
+	 * @dl_defer_armed tells if the deferrable server is waiting
+	 * for the replenishment timer to activate it.
+	 *
 	 * @dl_defer_running tells if the deferrable server is actually
 	 * running, skipping the defer phase.
+	 *
+	 * @dl_defer_idle tracks idle state
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_yielded        : 1;
@@ -709,6 +711,7 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
+	unsigned int			dl_defer_idle     : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1173,6 +1173,11 @@ static enum hrtimer_restart dl_server_ti
 		 */
 		rq->curr->sched_class->update_curr(rq);
 
+		if (dl_se->dl_defer_idle) {
+			dl_server_stop(dl_se);
+			return HRTIMER_NORESTART;
+		}
+
 		if (dl_se->dl_defer_armed) {
 			/*
 			 * First check if the server could consume runtime in background.
@@ -1420,10 +1425,11 @@ s64 dl_scaled_delta_exec(struct rq *rq,
 }
 
 static inline void
-update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
-			int flags);
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se, int flags);
+
 static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
+	bool idle = rq->curr == rq->idle;
 	s64 scaled_delta_exec;
 
 	if (unlikely(delta_exec <= 0)) {
@@ -1444,6 +1450,9 @@ static void update_curr_dl_se(struct rq
 
 	dl_se->runtime -= scaled_delta_exec;
 
+	if (dl_se->dl_defer_idle && !idle)
+		dl_se->dl_defer_idle = 0;
+
 	/*
 	 * The fair server can consume its runtime while throttled (not queued/
 	 * running as regular CFS).
@@ -1454,6 +1463,29 @@ static void update_curr_dl_se(struct rq
 	 */
 	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
 		/*
+		 * Non-servers would never get time accounted while throttled.
+		 */
+		WARN_ON_ONCE(!dl_server(dl_se));
+
+		/*
+		 * While the server is marked idle, do not push out the
+		 * activation further, instead wait for the period timer
+		 * to lapse and stop the server.
+		 */
+		if (dl_se->dl_defer_idle && idle) {
+			/*
+			 * The timer is at the zero-laxity point, this means
+			 * dl_server_stop() / dl_server_start() can happen
+			 * while now < deadline. This means update_dl_entity()
+			 * will not replenish. Additionally start_dl_timer()
+			 * will be set for 'deadline - runtime'. Negative
+			 * runtime will not do.
+			 */
+			dl_se->runtime = 0;
+			return;
+		}
+
+		/*
 		 * If the server was previously activated - the starving condition
 		 * took place, it this point it went away because the fair scheduler
 		 * was able to get runtime in background. So return to the initial
@@ -1465,6 +1497,9 @@ static void update_curr_dl_se(struct rq
 
 		replenish_dl_new_period(dl_se, dl_se->rq);
 
+		if (idle)
+			dl_se->dl_defer_idle = 1;
+
 		/*
 		 * Not being able to start the timer seems problematic. If it could not
 		 * be started for whatever reason, we need to "unthrottle" the DL server
@@ -1560,6 +1595,199 @@ void dl_server_update(struct sched_dl_en
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
+/*
+ * dl_server && dl_defer:
+ *
+ *                                        6
+ *                            +--------------------+
+ *                            v                    |
+ *     +-------------+  4   +-----------+  5     +------------------+
+ * +-> |   A:init    | <--- | D:running | -----> | E:replenish-wait |
+ * |   +-------------+      +-----------+        +------------------+
+ * |     |         |    1     ^    ^               |
+ * |     | 1       +----------+    | 3             |
+ * |     v                         |               |
+ * |   +--------------------------------+   2      |
+ * |   |                                | ----+    |
+ * | 8 |       B:zero_laxity-wait       |     |    |
+ * |   |                                | <---+    |
+ * |   +--------------------------------+          |
+ * |     |              ^     ^           2        |
+ * |     | 7            | 2   +--------------------+
+ * |     v              |
+ * |   +-------------+  |
+ * +-- | C:idle-wait | -+
+ *     +-------------+
+ *       ^ 7       |
+ *       +---------+
+ *
+ *
+ * [A] - init
+ *   dl_server_active = 0
+ *   dl_throttled = 0
+ *   dl_defer_armed = 0
+ *   dl_defer_running = 0/1
+ *   dl_defer_idle = 0
+ *
+ * [B] - zero_laxity-wait
+ *   dl_server_active = 1
+ *   dl_throttled = 1
+ *   dl_defer_armed = 1
+ *   dl_defer_running = 0
+ *   dl_defer_idle = 0
+ *
+ * [C] - idle-wait
+ *   dl_server_active = 1
+ *   dl_throttled = 1
+ *   dl_defer_armed = 1
+ *   dl_defer_running = 0
+ *   dl_defer_idle = 1
+ *
+ * [D] - running
+ *   dl_server_active = 1
+ *   dl_throttled = 0
+ *   dl_defer_armed = 0
+ *   dl_defer_running = 1
+ *   dl_defer_idle = 0
+ *
+ * [E] - replenish-wait
+ *   dl_server_active = 1
+ *   dl_throttled = 1
+ *   dl_defer_armed = 0
+ *   dl_defer_running = 1
+ *   dl_defer_idle = 0
+ *
+ *
+ * [1] A->B, A->D
+ * dl_server_start()
+ *   dl_server_active = 1;
+ *   enqueue_dl_entity()
+ *     update_dl_entity(WAKEUP)
+ *       if (!dl_defer_running)
+ *         dl_defer_armed = 1;
+ *         dl_throttled = 1;
+ *     if (dl_throttled && start_dl_timer())
+ *       return;
+ *       // start server into waiting for zero-laxity
+ *     __enqueue_dl_entity();
+ *     // start running
+ *
+ * // deplete server runtime from client-class
+ * [2] B->B, C->B, E->B
+ * dl_server_update()
+ *   update_curr_dl_se()
+ *     if (dl_defer_idle)
+ *       dl_defer_idle = 0;
+ *     if (dl_defer && dl_throttled && dl_runtime_exceeded())
+ *       dl_defer_running = 0;
+ *       hrtimer_try_to_cancel();   // stop timer
+ *       replenish_dl_new_period()
+ *         // fwd period
+ *         dl_throttled = 1;
+ *         dl_defer_armed = 1;
+ *       start_dl_timer();        // restart timer
+ *       // back into waiting for zero-laxity
+ *
+ * // timer actually fires means we have runtime
+ * [3] B->D
+ * dl_server_timer()
+ *   if (dl_defer_armed)
+ *     dl_defer_running = 1;
+ *   enqueue_dl_entity(REPLENISH)
+ *     replenish_dl_entity()
+ *       // fwd period
+ *       if (dl_throttled)
+ *         dl_throttled = 0;
+ *       if (dl_defer_armed)
+ *         dl_defer_armed = 0;
+ *     __enqueue_dl_entity();
+ *     // goto [4]
+ *
+ * // schedule server
+ * [4] D->A
+ * pick_task_dl()
+ *   p = server_pick_task();
+ *   if (!p)
+ *     dl_server_stop()
+ *       dequeue_dl_entity();
+ *       hrtimer_try_to_cancel();
+ *       dl_defer_armed = 0;
+ *       dl_throttled = 0;
+ *       dl_server_active = 0;
+ *       // goto [1]
+ *   return p;
+ *
+ * // server running
+ * [5] D->E
+ * update_curr_dl_se()
+ *   if (dl_runtime_exceeded())
+ *     dl_throttled = 1;
+ *     dequeue_dl_entity();
+ *     start_dl_timer();
+ *     // replenish-timer
+ *
+ * // server exchausted
+ * [6] E->D
+ * dl_server_timer()
+ *   enqueue_dl_entity(REPLENISH)
+ *     replenish_dl_entity()
+ *       fwd-period
+ *       if (dl_throttled)
+ *         dl_throttled = 0;
+ *     __enqueue_dl_entity();
+ *     // goto [4]
+ *
+ * // deplete server runtime from idle
+ * [7] B->C, C->C
+ * dl_server_update_idle()
+ *   update_curr_dl_se()
+ *     if (dl_defer && dl_throttled && dl_runtime_exceeded())
+ *       if (dl_defer_idle)
+ *         return;
+ *       dl_defer_running = 0;
+ *       hrtimer_try_to_cancel();
+ *       replenish_dl_new_period()
+ *         // fwd period
+ *         dl_throttled = 1;
+ *         dl_defer_armed = 1;
+ *       dl_defer_idle = 1;
+ *       start_dl_timer();        // restart timer
+ *
+ * // stop idle server
+ * [8] C->A
+ * dl_server_timer()
+ *   if (dl_defer_idle)
+ *     dl_server_stop();
+ *
+ *
+ * digraph dl_server {
+ *   "A:init" -> "B:zero_laxity-wait"             [label="1:dl_server_start"]
+ *   "A:init" -> "D:running"                      [label="1:dl_server_start"]
+ *   "B:zero_laxity-wait" -> "B:zero_laxity-wait" [label="2:dl_server_update"]
+ *   "B:zero_laxity-wait" -> "C:idle-wait"        [label="7:dl_server_update_idle"]
+ *   "B:zero_laxity-wait" -> "D:running"          [label="3:dl_server_timer"]
+ *   "C:idle-wait" -> "C:idle-wait"               [label="7:dl_server_update_idle"]
+ *   "C:idle-wait" -> "B:zero_laxity-wait"        [label="2:dl_server_update"]
+ *   "C:idle-wait" -> "A:init"                    [label="8:dl_server_timer"]
+ *   "D:running" -> "A:init"                      [label="4:pick_task_dl"]
+ *   "D:running" -> "E:replenish-wait"            [label="5:update_curr_dl_se"]
+ *   "E:replenish-wait" -> "B:zero_laxity-wait"   [label="2:dl_server_update"]
+ *   "E:replenish-wait" -> "D:running"            [label="6:dl_server_timer"]
+ * }
+ *
+ *
+ * Notes:
+ *
+ *  - When there are fair tasks running the most likely loop is [2]->[2].
+ *    the dl_server never actually runs, the timer never fires.
+ *
+ *  - When there is actual fair starvation; the timer fires and starts the
+ *    dl_server. This will then throttle and replenish like a normal DL
+ *    task. Notably it will not 'defer' again.
+ *
+ *  - When idle it will push the activation forward once, and then wait
+ *    for the timer to hit or a non-idle update to restart things.
+ */
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
@@ -1590,6 +1818,7 @@ void dl_server_stop(struct sched_dl_enti
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_defer_idle = 0;
 	dl_se->dl_server_active = 0;
 }
 


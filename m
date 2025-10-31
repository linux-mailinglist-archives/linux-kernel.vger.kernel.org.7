Return-Path: <linux-kernel+bounces-880239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD540C252C4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB7B3BBE00
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC5934A77F;
	Fri, 31 Oct 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GqzB85ya"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991993446DD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915953; cv=none; b=JrklDRQRkix4U2Y9qPth4VH6SZC2ZUOHhwnFzv2ggeR8jYoX6N51bsJsDowmnFgeeYfhbma7ThoqECjEscPGvXvfQ/kIzYardc/VHkoIylXEBhED6sFFkDCD/HcF1NqbNYkcCY1XkVB2O8g0sWECyIK7q+thKEKYucHRhhHSM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915953; c=relaxed/simple;
	bh=otj2Q0H44kaMLpL8S/Pe6SUdozZ4C10pF5ZbBm5j6u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPtUBiF1GUXG8UtG/1ti8bmgi00OakBiTXsLXVpiG1UrXiEbstVPJH2H1zR8NGIpQSsNnLf/WPpwY3dxkdOixrQOlZNb/KksMPiTR2Zuv+8CZL5txE3B5opoGdZa/8DIhqpPVXQ0oH+kan65xe7x/VIsJdrf6DMtwAOwGKlndUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GqzB85ya; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aRPDrXNPlaqnk1HfwtWWK8qZAcRzcSwOSrQk/jb9Qtw=; b=GqzB85yadf+goDrbJqZRE0zu8Y
	uN6b5OCApGbiTRSixaIISEfzFQOqnoXeMzJKH2OcHxwtUXmGvi2fbchg2zadDd7piBZ9xWIrDhYvj
	V3VtOTWPAGww5TPTFnkW0jkJkktbthKcHA7m/BSb1T2Mw/1XmJ51QdGXxa4oDyChhsBo+Eq2v8L9K
	fS1+NSPgplj246Rdr5xJrs7rUYSKdYzS+TzX1t/35Ca7ZV7PuIpRfFWDSlzO+AVWgSnWDN1L3xlhV
	1KgFzl1pLgIlAObd7SVHAudYQ7G7pTTtFuIK/StnyksLZ1SSSGwxTrJkpvrfVUn0Gaeu7yNZDji4J
	LbqDxkBw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEop5-0000000FiLc-4B3I;
	Fri, 31 Oct 2025 13:05:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B790530029E; Fri, 31 Oct 2025 14:05:43 +0100 (CET)
Date: Fri, 31 Oct 2025 14:05:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>, arighi@nvidia.com
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
References: <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
 <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
 <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
 <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
 <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030184205.GB2989771@noisy.programming.kicks-ass.net>

On Thu, Oct 30, 2025 at 07:42:05PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 22, 2025 at 12:11:51PM +0200, Gabriele Monaco wrote:
> 
> Sorry, finally cycling back to this.
> 
> > > So how about something like this for starters?
> > > 
> > 
> > Thanks Peter for sharing this patch, I run it through my test and the model
> > seems to pass (i.e. no more boosting after deadline). What I found curious
> > however, is that throughout the test, servers went only through replenish
> > events.
> > The system under test is mostly idle (6 periodic dl tasks on a 16 CPUs virtme-ng
> > VM), so I expect not to see any task boosted by the servers, but in 5 minutes I
> > didn't even observe any start/stop for the server.
> > 
> > I'm not sure why this is happening, but looking at traces it seems replenish
> > occurs more often and perhaps doesn't let the server stop:
> > 
> > <idle>-0     [009] d.h3.    14.312395: (+950124) event_nomiss:         -9: idle x dl_replenish_idle -> idle
> > <idle>-0     [009] d.h3.    14.312401: (+6)     sched_dl_replenish:   comm=server pid=-9 runtime=50000000 deadline=15253307235 yielded=0
> > <idle>-0     [009] d.h3.    15.262771: (+950370) event_nomiss:         -9: idle x dl_replenish_idle -> idle
> > <idle>-0     [009] d.h3.    15.262781: (+10)    sched_dl_replenish:   comm=server pid=-9 runtime=50000000 deadline=16203668554 yielded=0
> > <idle>-0     [009] d.h3.    16.213117: (+950336) event_nomiss:         -9: idle x dl_replenish_idle -> idle
> > <idle>-0     [009] d.h3.    16.213123: (+6)     sched_dl_replenish:   comm=server pid=-9 runtime=50000000 deadline=17154029879 yielded=0
> > 
> > Is this expected?
> 
> Sort of, that was next on the list. Let me see if I can make it stop a
> little more.

OK, so I've gone over things again and all I got was a comment.

That is, today I think it all works as expected.

The dl_server will stop once the fair class goes idle long enough. Can
you confirm this?

---
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1152,6 +1152,94 @@ static void __push_dl_task(struct rq *rq
 /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
 static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
 
+
+/*
+ * dl_server && dl_defer:
+ *   dl_defer_armed = 0
+ *   dl_defer_running = 0
+ *   dl_throttled = 0
+ *
+ * [1] dl_server_start()
+ *   dl_server_active = 1;
+ *   enqueue_dl_entity()
+ *     update_dl_entity(WAKEUP)
+ *       if (!dl_defer_running)
+ *         dl_defer_armed = 1;
+ *         dl_defer_throttled = 1;
+ *     if (dl_throttled && start_dl_timer())
+ *       return;
+ *       // start server into waiting for zero-laxity
+ *
+ * // deplete server runtime from fair-class
+ * [2] update_curr_dl_se()
+ *   if (dl_defer && dl_throttled && dl_runtime_exceeded())
+ *     dl_defer_running = 0;
+ *     hrtimer_try_to_cancel();   // stop timer
+ *     replenish_dl_new_period()
+ *       // advance period
+ *       dl_throttled = 1;
+ *       dl_defer_armed = 1;
+ *       start_dl_timer();        // restart timer
+ *       // back into waiting for zero-laxity
+ *
+ * // timer actually fires means we have runtime
+ * [4] dl_server_timer()
+ *   if (dl_defer_armed)
+ *     dl_defer_running = 1;
+ *   enqueue_dl_entity(REPLENISH)
+ *     replenish_dl_entity()
+ *       opt-fwd-period
+ *       if (dl_throttled)
+ *         dl_throttled = 0;
+ *       if (dl_defer_armed)
+ *         dl_defer_armed = 0;
+ *     __enqueue_dl_entity();
+ *     // server queued
+ *
+ * // schedule server
+ * [5] pick_task_dl()
+ *   p = server_pick_task();
+ *   if (!p)
+ *     dl_server_stop()
+ *       dequeue_dl_entity();
+ *       hrtimer_try_to_cancel();
+ *       dl_defer_armed = 0;
+ *       dl_throttled = 0;
+ *       dl_server_active = 0;
+ *       // goto [1]
+ *
+ * // server running
+ * [6] update_curr_dl_se()
+ *   if (dl_runtime_exceeded())
+ *     dl_throttled = 1;
+ *     dequeue_dl_entity();
+ *     start_dl_timer();
+ *     // replenish-timer
+ *
+ * // goto [2]
+ *
+ * [7] dl_server_timer()
+ *   enqueue_dl_entity(REPLENISH)
+ *     replenish_dl_entity()
+ *       fwd-period
+ *       if (dl_throttled)
+ *         dl_throttled = 0;
+ *     __enqueue_dl_entity();
+ *     // goto [5]
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
+ *  - When fair goes idle, it will not consume dl_server budget so the server
+ *    will start. However, it will find there are no fair tasks to run and
+ *    stop itself.
+ */
 static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = rq_of_dl_se(dl_se);


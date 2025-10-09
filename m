Return-Path: <linux-kernel+bounces-846734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C6BC8DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E55CC4FA04E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A362DFA3A;
	Thu,  9 Oct 2025 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A6BUAYXO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6666246BA8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010202; cv=none; b=Yq7gSVQiBt5JpvEylttElIhUckPMS0XF2h8GX4ZH+Bv2vE/oi1cffnyYNRJs1n87UzvrL0mqgSPSOiRUxM4GRuOM9fUjXi0C63+kyun5JDoSAOZEL6GH6RcKo483SnAI7YsfUoNfcKRvQj5MGfebXjxbJb6g1uBnyOVGGBh8EH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010202; c=relaxed/simple;
	bh=IHqohkJbqGCruh/lKBOvvH6BpmA0z3uOvX7U3yTR9t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoKgAofH4Fqz0OLK/344uWe+eooKdP1PfR5AE5KFcx6owMFWZrdFBnf+xYZeXWCkyOV5BH+L+O2nh3Epk6Chpo1wKeusKHdqWNtKU4dUVxFxrGSedUpgX6v/61+JPANjkTAWP1mRCl/1DwqvI2VIf/KAoC2bBM/qKLm6HPduMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A6BUAYXO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fUFDebjlqC2UTLgFQXvGZG+AiKQR+d5BUndpPyeG84I=; b=A6BUAYXOutq6dmqRPFZyVNISvx
	Q9KrwjNLHcnRtKyZBhpGIqe+u6/vQ5LpXvFaqGMdrnVr8YAzdvSc6diF7Wrbk7gmDZTMUAAukxbeF
	vo+O2caC9YFj28JpImUSfE8BCJMWPsKhXqb+pW/+3YHajJDRsKbEkBVOefFQs0ZqroXdjUthGu37W
	ruR1eqXxucaWPT1bB1G5X7keW9OduRVVB243uUlwllWGDPKnUnFsAzwNwS/94caQ0EHdRcApteRup
	UFuH7IB8GyJ6BkhhrWcqjuRfYlffZ3GmvnwNzTQu2N/NOCqjgGlFuENXiaB6To7zlcymz9vy5Hu+k
	LZiYLwkw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6p31-00000001QD4-2rmQ;
	Thu, 09 Oct 2025 11:43:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 95C38300342; Thu, 09 Oct 2025 13:43:02 +0200 (CEST)
Date: Thu, 9 Oct 2025 13:43:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [PATCH v22 2/6] sched/locking: Add blocked_on_state to provide
 necessary tri-state for proxy return-migration
Message-ID: <20251009114302.GI3245006@noisy.programming.kicks-ass.net>
References: <20250926032931.27663-1-jstultz@google.com>
 <20250926032931.27663-3-jstultz@google.com>
 <20251008112603.GU3419281@noisy.programming.kicks-ass.net>
 <CANDhNCpSNyOkcuUZvpZK5FQhL8oxQEax2wUStdRAV_ns2z7n_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCpSNyOkcuUZvpZK5FQhL8oxQEax2wUStdRAV_ns2z7n_A@mail.gmail.com>

On Wed, Oct 08, 2025 at 05:07:26PM -0700, John Stultz wrote:

> > I'm thinking that suggesting didn't work out somehow, but I'm still not
> > sure I understand why.
> 
> So the main issue is about where we end up setting the task to
> BO_WAKING (via set_blocked_on_waking()). This is done in
> __mutex_unlock_slowpath(), __ww_mutex_die(), and __ww_mutex_wound().
> And in those cases, we are already holding the mutex->wait_lock, and
> sometimes a task's blocked_lock, without the rq lock.  So we can't
> just grab the rq lock out of order, and we probably shouldn't drop and
> try to reacquire the blocked_lock and wait_lock there.

Oh bugger. In my head the scheduler locks still nest inside wait_lock,
but we've flipped that such that schedule() / find_proxy_task() can take
it inside rq->lock.

Yes that does complicate things.

So suppose we have this ww_mutex cycle thing:

		  ,-+-*	Mutex-1 <-.
	Task-A ---' |		  | ,--	Task-B
		    `->	Mutex-2 *-+-'

Where Task-A holds Mutex-1 and tries to acquire Mutex-2, and
where Task-B holds Mutex-2 and tries to acquire Mutex-1.

Then the blocked_on->owner chain will go in circles.

        Task-A  -> Mutex-2
          ^          |
          |          v
        Mutex-1 <- Task-B

We need two things:

 - find_proxy_task() to stop iterating the circle;

 - the woken task to 'unblock' and run, such that it can back-off and
   re-try the transaction.


Now, the current code does:

	__clear_task_blocked_on();
	wake_q_add();

And surely clearing ->blocked_on is sufficient to break the cycle.

Suppose it is Task-B that is made to back-off, then we have:

  Task-A -> Mutex-2 -> Task-B (no further blocked_on)

and it would attempt to run Task-B. Or worse, it could directly pick
Task-B and run it, without ever getting into find_proxy_task().

Now, here is a problem because Task-B might not be runnable on the CPU
it is currently on; and because !task_is_blocked() we don't get into the
proxy paths, so nobody is going to fix this up.

Ideally we would have dequeued Task-B alongside of clearing
->blocked_on, but alas, lock inversion spoils things.

> Though, one approach that I just thought of would be to have a special
> wake_up_q call, which would handle dequeuing the blocked_on tasks on
> the wake_q before doing the wakeup?  I can give that a try.

I think this is racy worse than you considered. CPU1 could be inside
schedule() trying to pick Task-B while CPU2 does that wound/die thing.
No spurious wakeup required.


Anyway, since the actual value of ->blocked_on doesn't matter in this
case (we really want it to be NULL, but can't because we need someone to
go back migrate the thing), why not simply use something like:

#define PROXY_STOP ((struct mutex *)(-1L))

	__set_task_blocked_on(task, PROXY_STOP);

Then, have find_proxy_task() fix it up?


Random thoughts:

 - we should probably have something like:

	next = pick_next_task();
	rq_set_donor(next)
	if (unlikely(task_is_blocked()) {
		...
	}
+	WARN_ON_ONCE(next->__state);

   at all times the task we end up picking should be in RUNNABLE state.

 - similarly, we should have ttwu() check ->blocked_on is NULL ||
   PROXY_STOP, waking a task that still has a blocked_on relation can't
   be right -- ooh, dang race conditions :/ perhaps DEBUG_MUTEX and
   serialize on wait_lock.

 - I'm confliced on having TTWU fix up PROXY_STOP; strictly not required
   I think, but might improve performance -- if so, include numbers in
   patch that adds it -- which should be a separate patch from the one
   that adds PROXY_STOP.

 - since find_proxy_task() can do a lock-break, it should probably
   re-try the pick if, at the end, a higher runqueue is modified than
   the task we ended up with.

   Also see this thread:

      https://lkml.kernel.org/r/20251006105453.522934521@infradead.org

   eg. something like:

	rq->queue_mask = 0;
	// code with rq-lock-break
   	if (rq_modified_above(rq, next->sched_class))
		return NULL;


I'm still confused on BO_RUNNABLE -- you set that around
optimistic-spin, probably because you want to retain the ->blocked_on
relation, but also you have to run that thing to make progress. There
are a few other sites that use it, but those are more confusing still.

Please try and clarify this.

Anyway, if that is indeed it, you could do this by (ab)using the LSB of
the ->blocked_on pointer I suppose (you could make PROXY_STOP -2).



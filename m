Return-Path: <linux-kernel+bounces-845352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0723BC48D3
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B3924E8256
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33E92F6562;
	Wed,  8 Oct 2025 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVVfsYwI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C921767A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922779; cv=none; b=TG0af2RwtyaV81VwLygv3Ygj1pepY+fso1i/+bvz4+dyEmtqfBhvFp+2T81oxKf3SaJTlPt4KIANql/eOpLm6c4y+D+p3rPN9fhgh/jwMvI5E0/RviPrNjxYVy1jY8zxCOoENnE68n+G3hHW88nnF7jKZCkCXNrES2iRZFjMu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922779; c=relaxed/simple;
	bh=pU/LeL0BDNULA3Qn5EUADo9AjEx+0IDSanHDAZBLtSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0IOtr8llpL9duwQPaPwM1ijZTs7dKrtjn9ZMVqhBxRwaZq8UmBXd9iodRwT3FAdJ3E+436z9n4HxQU8mfCoDh+d2jG08Rw0KMw2+AyVq1uY80EqsEdcK/eZOlXpI7MGmLJ3scdT++ZmLhSZzhNW7U+wz4UE0v0OdvU+F8unvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BVVfsYwI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R373+0XLF4+cg4TjiwC78BGPI3GmHAsdBLimF0fyVvA=; b=BVVfsYwIm4201/iL1YTrOcOtxd
	CMhan15A1wGOE1pZPV+D7L0tWmTgzDuwWiZVTjuUx73pKACzN3YqH3R1eFaQnmoq8FVPgbtAihhhs
	V93/HAtFQJaSeZXu1HZkaQ3G3l+52giBPCEZLSrBbiHq9XdSp9xgKUtoWs9/oUZcGKp82NQm9QzP4
	+ijY2dMXdIpC5rkAcawmN2KuhTH5mK306tKdphh6F7f/v5HQQyFNFh8vA8F9Jb36KTu1vnHbZHNnY
	VtrA3hYSc286ceiXTp6ML6TdKzi+Z3Hu/cmztqvnguvybU9UcnAYbEvgpUW6tS9H+fea9ux7E4mWx
	in39Xy4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6SJ0-00000003n5o-3o2j;
	Wed, 08 Oct 2025 11:26:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A66F4300220; Wed, 08 Oct 2025 13:26:03 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:26:03 +0200
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
Message-ID: <20251008112603.GU3419281@noisy.programming.kicks-ass.net>
References: <20250926032931.27663-1-jstultz@google.com>
 <20250926032931.27663-3-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926032931.27663-3-jstultz@google.com>

On Fri, Sep 26, 2025 at 03:29:10AM +0000, John Stultz wrote:
> As we add functionality to proxy execution, we may migrate a
> donor task to a runqueue where it can't run due to cpu affinity.
> Thus, we must be careful to ensure we return-migrate the task
> back to a cpu in its cpumask when it becomes unblocked.
> 
> Thus we need more then just a binary concept of the task being
> blocked on a mutex or not.
> 
> So add a blocked_on_state value to the task, that allows the
> task to move through BO_RUNNING -> BO_BLOCKED -> BO_WAKING
> and back to BO_RUNNING. This provides a guard state in
> BO_WAKING so we can know the task is no longer blocked
> but we don't want to run it until we have potentially
> done return migration, back to a usable cpu.
> 
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  include/linux/sched.h     | 92 +++++++++++++++++++++++++++++++++------
>  init/init_task.c          |  3 ++
>  kernel/fork.c             |  3 ++
>  kernel/locking/mutex.c    | 15 ++++---
>  kernel/locking/ww_mutex.h | 20 ++++-----
>  kernel/sched/core.c       | 45 +++++++++++++++++--
>  kernel/sched/sched.h      |  6 ++-
>  7 files changed, 146 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index cb4e81d9d9b67..8245940783c77 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -813,6 +813,12 @@ struct kmap_ctrl {
>  #endif
>  };
>  
> +enum blocked_on_state {
> +	BO_RUNNABLE,
> +	BO_BLOCKED,
> +	BO_WAKING,
> +};

I am still struggling with all this.

  RUNNABLE is !p->blocked_on
  BLOCKED is !!p->blocked_on
  WAKING is !!p->blocked_on but you need magical beans

I'm not sure I follow the argument above, and there is a distinct lack
of comments with this enum explaining the states (although there are
some comments scattered across the patch itself).

Last time we talked about this:

  https://lkml.kernel.org/r/20241216165419.GE35539@noisy.programming.kicks-ass.net

I was equally confused; and suggested not having the WAKING state by
simply dequeueing the offending task and letting ttwu() sort it out --
since we know a wakeup will be coming our way.

I'm thinking that suggesting didn't work out somehow, but I'm still not
sure I understand why.

There is this comment:


+               /*
+                * If a ww_mutex hits the die/wound case, it marks the task as
+                * BO_WAKING and calls try_to_wake_up(), so that the mutex
+                * cycle can be broken and we avoid a deadlock.
+                *
+                * However, if at that moment, we are here on the cpu which the
+                * die/wounded task is enqueued, we might loop on the cycle as
+                * BO_WAKING still causes task_is_blocked() to return true
+                * (since we want return migration to occur before we run the
+                * task).
+                *
+                * Unfortunately since we hold the rq lock, it will block
+                * try_to_wake_up from completing and doing the return
+                * migration.
+                *
+                * So when we hit a !BO_BLOCKED task briefly schedule idle
+                * so we release the rq and let the wakeup complete.
+                */
+               if (p->blocked_on_state != BO_BLOCKED)
+                       return proxy_resched_idle(rq);


Which I presume tries to clarify things, but that only had me scratching
my head again. Why would you need task_is_blocked() to affect return
migration?




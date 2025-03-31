Return-Path: <linux-kernel+bounces-582469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972EBA76D79
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 21:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7A23A8037
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA52153FC;
	Mon, 31 Mar 2025 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfvVRYzC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D7193079
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743449091; cv=none; b=PFzGW9Sy325FflaaVG2o60FvvkC3aBKBNEs43ATo5Up7expYoFtgd+TmYdCf8lfyq9e901MLV43ev//KyEZ88ebEr6iSBRFPN0V+znyx4C4TRof930NDVgBrzrDoGyE1ukx3zUwLvoHkUsPDZ5XDttwPcsbZgSqwtxAEtF0reBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743449091; c=relaxed/simple;
	bh=VYNlyZ27WDW+K1NGm92+9R++6AJIimE1cv42eG8h00M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb0H47kq2g8XAzjNm8a7oIuP7YcJnZKeLsH3R+lv9FYI8T397tbvHcvlX5Zw6tpzPTu7rk7DKm0xb4yE/hNyLPne1lBPi9yzgpFyCpCocfuUQeAOxtEgk0z2O2xCQ1OKy6gM9opXN15gBejZTqUhxx/CVnOG7FXfl55zi1As01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfvVRYzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD17C4CEE3;
	Mon, 31 Mar 2025 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743449090;
	bh=VYNlyZ27WDW+K1NGm92+9R++6AJIimE1cv42eG8h00M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfvVRYzCJ3iqYLJH20hov3a1hl5FE5VVJisIIhh4fAf0ZGmXzvNJu0e4cXd0Lp7LJ
	 xQoVKoJCZ76MIrjHpcaulzloaBGIQ9CxV3t3XMpuDotp3pHk6c7BsyzWp2Q9KKFeiQ
	 D4wHk8la4Pfytu1ohFWW26zPu+ACQ12EsWP7ltVxfeCmn3cppk3U67YIMBCkKUhIIv
	 DCA6f+tZvzGeD/aaucyo9IBp5+qhPCSVtPs8q4QsM9ROO279vwADPjCVNrYBD1HO9J
	 Ea29oyvj5RCs/HoN8V8uWIVLIqXbOK4+s4RV5+rAzXTaS6R127Mh0zx1TkqNeW+aLk
	 31cMzR/zEg3uQ==
Date: Mon, 31 Mar 2025 21:24:47 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>, Yi Lai <yi1.lai@linux.intel.com>,
	syzbot+3c4321e10eea460eb606@syzkaller.appspotmail.com
Subject: Re: [PATCH] perf: Fix hang while freeing sigtrap event
Message-ID: <Z-rr_2OkAoeAUSzg@pavilion.home>
References: <20250304135446.18905-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304135446.18905-1-frederic@kernel.org>

Ping.

Le Tue, Mar 04, 2025 at 02:54:46PM +0100, Frederic Weisbecker a �crit :
> Perf can hang while freeing a sigtrap event if a related deferred
> signal hadn't managed to be sent before the file got closed:
> 
> perf_event_overflow()
>    task_work_add(perf_pending_task)
> 
> fput()
>    task_work_add(____fput())
> 
> task_work_run()
>     ____fput()
>         perf_release()
>             perf_event_release_kernel()
>                 _free_event()
>                     perf_pending_task_sync()
>                         task_work_cancel() -> FAILED
>                         rcuwait_wait_event()
> 
> Once task_work_run() is running, the list of pending callbacks is
> removed from the task_struct and from this point on task_work_cancel()
> can't remove any pending and not yet started work items, hence the
> task_work_cancel() failure and the hang on rcuwait_wait_event().
> 
> Task work could be changed to remove one work at a time, so a work
> running on the current task can always cancel a pending one, however
> the wait / wake design is still subject to inverted dependencies when
> remote targets are involved, as pictured by Oleg:
> 
> T1                                                      T2
> ---                                                    ---
> fd = perf_event_open(pid => T2->pid);                  fd = perf_event_open(pid => T1->pid);
> close(fd)                                              close(fd)
>     <IRQ>                                                  <IRQ>
>     perf_event_overflow()                                  perf_event_overflow()
>        task_work_add(perf_pending_task)                        task_work_add(perf_pending_task)
>     </IRQ>                                                 </IRQ>
>     fput()                                                 fput()
>         task_work_add(____fput())                              task_work_add(____fput())
> 
>     task_work_run()                                        task_work_run()
>         ____fput()                                             ____fput()
>             perf_release()                                         perf_release()
>                 perf_event_release_kernel()                            perf_event_release_kernel()
>                     _free_event()                                          _free_event()
>                         perf_pending_task_sync()                               perf_pending_task_sync()
>                             rcuwait_wait_event()                                   rcuwait_wait_event()
> 
> Therefore the only option left is to acquire the event reference count
> upon queueing the perf task work and release it from the task work, just
> like it was done before 3a5465418f5f ("perf: Fix event leak upon exec and file release")
> but without the leaks it fixed.
> 
> Some adjustments are necessary to make it work:
> 
> * A child event might dereference its parent upon freeing. Care must be
>   taken to release the parent last.
> 
> * Some places assuming the event doesn't have any reference held and
>   therefore can be freed right away must instead put the reference and
>   let the reference counting to its job.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Reported-by: "Yi Lai" <yi1.lai@linux.intel.com>
> Closes: https://lore.kernel.org/all/Zx9Losv4YcJowaP%2F@ly-workstation/
> Reported-by: syzbot+3c4321e10eea460eb606@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/673adf75.050a0220.87769.0024.GAE@google.com/
> Fixes: 3a5465418f5f ("perf: Fix event leak upon exec and file release")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/perf_event.h |  1 -
>  kernel/events/core.c       | 64 +++++++++++---------------------------
>  2 files changed, 18 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 76f4265efee9..4e8970da6953 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -832,7 +832,6 @@ struct perf_event {
>  	struct irq_work			pending_disable_irq;
>  	struct callback_head		pending_task;
>  	unsigned int			pending_work;
> -	struct rcuwait			pending_work_wait;
>  
>  	atomic_t			event_limit;
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b2334d27511b..253791d99e21 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5355,30 +5355,6 @@ static bool exclusive_event_installable(struct perf_event *event,
>  
>  static void perf_free_addr_filters(struct perf_event *event);
>  
> -static void perf_pending_task_sync(struct perf_event *event)
> -{
> -	struct callback_head *head = &event->pending_task;
> -
> -	if (!event->pending_work)
> -		return;
> -	/*
> -	 * If the task is queued to the current task's queue, we
> -	 * obviously can't wait for it to complete. Simply cancel it.
> -	 */
> -	if (task_work_cancel(current, head)) {
> -		event->pending_work = 0;
> -		local_dec(&event->ctx->nr_no_switch_fast);
> -		return;
> -	}
> -
> -	/*
> -	 * All accesses related to the event are within the same RCU section in
> -	 * perf_pending_task(). The RCU grace period before the event is freed
> -	 * will make sure all those accesses are complete by then.
> -	 */
> -	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
> -}
> -
>  /* vs perf_event_alloc() error */
>  static void __free_event(struct perf_event *event)
>  {
> @@ -5433,7 +5409,6 @@ static void _free_event(struct perf_event *event)
>  {
>  	irq_work_sync(&event->pending_irq);
>  	irq_work_sync(&event->pending_disable_irq);
> -	perf_pending_task_sync(event);
>  
>  	unaccount_event(event);
>  
> @@ -5526,10 +5501,17 @@ static void perf_remove_from_owner(struct perf_event *event)
>  
>  static void put_event(struct perf_event *event)
>  {
> +	struct perf_event *parent;
> +
>  	if (!atomic_long_dec_and_test(&event->refcount))
>  		return;
>  
> +	parent = event->parent;
>  	_free_event(event);
> +
> +	/* Matches the refcount bump in inherit_event() */
> +	if (parent)
> +		put_event(parent);
>  }
>  
>  /*
> @@ -5613,11 +5595,6 @@ int perf_event_release_kernel(struct perf_event *event)
>  		if (tmp == child) {
>  			perf_remove_from_context(child, DETACH_GROUP);
>  			list_move(&child->child_list, &free_list);
> -			/*
> -			 * This matches the refcount bump in inherit_event();
> -			 * this can't be the last reference.
> -			 */
> -			put_event(event);
>  		} else {
>  			var = &ctx->refcount;
>  		}
> @@ -5643,7 +5620,8 @@ int perf_event_release_kernel(struct perf_event *event)
>  		void *var = &child->ctx->refcount;
>  
>  		list_del(&child->child_list);
> -		free_event(child);
> +		/* Last reference unless ->pending_task work is pending */
> +		put_event(child);
>  
>  		/*
>  		 * Wake any perf_event_free_task() waiting for this event to be
> @@ -5654,7 +5632,11 @@ int perf_event_release_kernel(struct perf_event *event)
>  	}
>  
>  no_ctx:
> -	put_event(event); /* Must be the 'last' reference */
> +	/*
> +	 * Last reference unless ->pending_task work is pending on this event
> +	 * or any of its children.
> +	 */
> +	put_event(event);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(perf_event_release_kernel);
> @@ -7065,12 +7047,6 @@ static void perf_pending_task(struct callback_head *head)
>  	struct perf_event *event = container_of(head, struct perf_event, pending_task);
>  	int rctx;
>  
> -	/*
> -	 * All accesses to the event must belong to the same implicit RCU read-side
> -	 * critical section as the ->pending_work reset. See comment in
> -	 * perf_pending_task_sync().
> -	 */
> -	rcu_read_lock();
>  	/*
>  	 * If we 'fail' here, that's OK, it means recursion is already disabled
>  	 * and we won't recurse 'further'.
> @@ -7081,9 +7057,8 @@ static void perf_pending_task(struct callback_head *head)
>  		event->pending_work = 0;
>  		perf_sigtrap(event);
>  		local_dec(&event->ctx->nr_no_switch_fast);
> -		rcuwait_wake_up(&event->pending_work_wait);
>  	}
> -	rcu_read_unlock();
> +	put_event(event);
>  
>  	if (rctx >= 0)
>  		perf_swevent_put_recursion_context(rctx);
> @@ -10030,6 +10005,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  		    !task_work_add(current, &event->pending_task, notify_mode)) {
>  			event->pending_work = pending_id;
>  			local_inc(&event->ctx->nr_no_switch_fast);
> +			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
>  
>  			event->pending_addr = 0;
>  			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
> @@ -12382,7 +12358,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	init_irq_work(&event->pending_irq, perf_pending_irq);
>  	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
>  	init_task_work(&event->pending_task, perf_pending_task);
> -	rcuwait_init(&event->pending_work_wait);
>  
>  	mutex_init(&event->mmap_mutex);
>  	raw_spin_lock_init(&event->addr_filters.lock);
> @@ -13512,8 +13487,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
>  		 * Kick perf_poll() for is_event_hup();
>  		 */
>  		perf_event_wakeup(parent_event);
> -		free_event(event);
> -		put_event(parent_event);
> +		put_event(event);
>  		return;
>  	}
>  
> @@ -13631,13 +13605,11 @@ static void perf_free_event(struct perf_event *event,
>  	list_del_init(&event->child_list);
>  	mutex_unlock(&parent->child_mutex);
>  
> -	put_event(parent);
> -
>  	raw_spin_lock_irq(&ctx->lock);
>  	perf_group_detach(event);
>  	list_del_event(event, ctx);
>  	raw_spin_unlock_irq(&ctx->lock);
> -	free_event(event);
> +	put_event(event);
>  }
>  
>  /*
> -- 
> 2.48.1
> 


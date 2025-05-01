Return-Path: <linux-kernel+bounces-628915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD1CAA649D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 22:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AA67A6D12
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FA824EF6F;
	Thu,  1 May 2025 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPxV/6Wc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59D22578C;
	Thu,  1 May 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746130455; cv=none; b=PvBsw1d1SfqsYz0OaW4/JtGEfKMNjaAvjB2i21/MVyBsZHtle+JuQOWg2xuSMQkJk9crB6XvEZdYxRwW5+MvlOzQosVDKj5+i0sfzBwzqoS2MdxHhxKS6JyDn4K3YyH3F6MDIs+mkDbcKhADEQVG8cGlTzqI0ZsF3nmOI8S/MXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746130455; c=relaxed/simple;
	bh=hGwoM83sjWfRbwfkKdXA3OT9c/iEckOa4Ug0tmR7y/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjZWYk1dUd6i0hpxGpueOHFS1EypsVQ0pnBUG5TOxJAjlXHEwe0HHXsvNW2etO6CzV3y0lCazuwdV/DZeNQhykVLnpnoJKpLqwwr07bypf1/pLOmYjlaWlu7MwAX8ifqyi6+Eou3tKDQTZqbqRjtJUZe2ngAeerYyyD08z1NCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPxV/6Wc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6F0C4CEE3;
	Thu,  1 May 2025 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746130453;
	bh=hGwoM83sjWfRbwfkKdXA3OT9c/iEckOa4Ug0tmR7y/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPxV/6Wc8vSM69Y838jMbp7QByoDYIAYiwVQ4/IdcV1hTbaqxMi2+Ohkl7u/yESbK
	 O/FJTdP+gpCIx7og1sSbPDXFKaFzqZLULYdld+EMaf23ij5MZOjeAxmrqhlk7gonOM
	 TJpYiZTZBGLiiBvccvFOh/eHrRnakLUW/lRnkWIHrQyPFRk+zk8HQ2VM9AFL21bYg/
	 HQwrFTDhFPhKCA02/QNS+fajU7r8rRFepQxwf0shmcBb2/fsE7hVP89M5JtKMmm12f
	 kUc9xxjfZmAEPsdwpeyW7LWT0cKhlNqKOhlf0q99WBKfj6Xhv9gKoTKezF7gkYKzS1
	 Y6P4R6mrOmx9A==
Date: Thu, 1 May 2025 13:14:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
	Blake Jones <blakejones@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH v6 5/5] perf: Support deferred user callchains for per
 CPU events
Message-ID: <aBPWE7ItDhEnSpav@google.com>
References: <20250501013202.997535180@goodmis.org>
 <20250501013506.751321323@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250501013506.751321323@goodmis.org>

Hi Steve,

On Wed, Apr 30, 2025 at 09:32:07PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The deferred unwinder works fine for task events (events that trace only a
> specific task), as it can use a task_work from an interrupt or NMI and
> when the task goes back to user space it will call the event's callback to
> do the deferred unwinding.
> 
> But for per CPU events things are not so simple. When a per CPU event
> wants a deferred unwinding to occur, it can not simply use a task_work as
> there's a many to many relationship. If the task migrates and another task
> is scheduled in where the per CPU event wants a deferred unwinding to
> occur on that task as well, and the task that migrated to another CPU has
> that CPU's event want to unwind it too, each CPU may need unwinding from
> more than one task, and each task may has requests from many CPUs.
> 
> To solve this, when a per CPU event is created that has defer_callchain
> attribute set, it will do a lookup from a global list
> (unwind_deferred_list), for a perf_unwind_deferred descriptor that has the
> id that matches the PID of the current task's group_leader.

Nice, it'd work well with the perf tools at least.

> 
> If it is not found, then it will create one and add it to the global list.
> This descriptor contains an array of all possible CPUs, where each element
> is a perf_unwind_cpu descriptor.
> 
> The perf_unwind_cpu descriptor has a list of all the per CPU events that
> is tracing the matching CPU that corresponds to its index in the array,
> where the events belong to a task that has the same group_leader.
> It also has a processing bit and rcuwait to handle removal.
> 
> For each occupied perf_unwind_cpu descriptor in the array, the
> perf_deferred_unwind descriptor increments its nr_cpu_events. When a
> perf_unwind_cpu descriptor is empty, the nr_cpu_events is decremented.
> This is used to know when to free the perf_deferred_unwind descriptor, as
> when it become empty, it is no longer referenced.
> 
> Finally, the perf_deferred_unwind descriptor has an id that holds the PID
> of the group_leader for the tasks that the events were created by.
> 
> When a second (or more) per CPU event is created where the
> perf_deferred_unwind descriptor is already created, it just adds itself to
> the perf_unwind_cpu array of that descriptor. Updating the necessary
> counter.
> 
> Each of these perf_deferred_unwind descriptors have a unwind_work that
> registers with the deferred unwind infrastructure via
> unwind_deferred_init(), where it also registers a callback to
> perf_event_deferred_cpu().
> 
> Now when a per CPU event requests a deferred unwinding, it calls
> unwind_deferred_request() with the associated perf_deferred_unwind
> descriptor. It is expected that the program that uses this has events on
> all CPUs, as the deferred trace may not be called on the CPU event that
> requested it. That is, the task may migrate and its user stack trace will
> be recorded on the CPU event of the CPU that it exits back to user space
> on.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/perf_event.h |   5 +
>  kernel/events/core.c       | 226 +++++++++++++++++++++++++++++++++----
>  2 files changed, 206 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 10603a8344d3..c12b4894c4e1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -683,6 +683,7 @@ struct swevent_hlist {
>  struct bpf_prog;
>  struct perf_cgroup;
>  struct perf_buffer;
> +struct perf_unwind_deferred;
>  
>  struct pmu_event_list {
>  	raw_spinlock_t		lock;
> @@ -835,6 +836,9 @@ struct perf_event {
>  	struct callback_head		pending_unwind_work;
>  	struct rcuwait			pending_unwind_wait;
>  
> +	struct perf_unwind_deferred	*unwind_deferred;
> +	struct list_head		unwind_list;
> +
>  	atomic_t			event_limit;
>  
>  	/* address range filters */
> @@ -875,6 +879,7 @@ struct perf_event {
>  #ifdef CONFIG_SECURITY
>  	void *security;
>  #endif
> +
>  	struct list_head		sb_list;
>  	struct list_head		pmu_list;
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a5d9c6220589..f0c3b8878276 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5537,10 +5537,128 @@ static bool exclusive_event_installable(struct perf_event *event,
>  	return true;
>  }
>  
> +/* Holds a list of per CPU events that registered for deferred unwinding */
> +struct perf_unwind_cpu {
> +	struct list_head	list;
> +	struct rcuwait		pending_unwind_wait;
> +	int			processing;
> +};
> +
> +struct perf_unwind_deferred {
> +	struct list_head	list;
> +	struct unwind_work	unwind_work;
> +	struct perf_unwind_cpu	*cpu_events;
> +	int			nr_cpu_events;
> +	int			id;
> +};
> +
> +static DEFINE_MUTEX(unwind_deferred_mutex);
> +static LIST_HEAD(unwind_deferred_list);
> +
> +static void perf_event_deferred_cpu(struct unwind_work *work,
> +				    struct unwind_stacktrace *trace, u64 cookie);
> +
> +static int perf_add_unwind_deferred(struct perf_event *event)
> +{
> +	struct perf_unwind_deferred *defer;
> +	int id = current->group_leader->pid;
> +	bool found = false;
> +	int ret = 0;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	guard(mutex)(&unwind_deferred_mutex);
> +
> +	list_for_each_entry(defer, &unwind_deferred_list, list) {
> +		if (defer->id == id) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		defer = kzalloc(sizeof(*defer), GFP_KERNEL);
> +		if (!defer)
> +			return -ENOMEM;
> +		list_add(&defer->list, &unwind_deferred_list);
> +		defer->id = id;
> +	}
> +
> +	if (!defer->nr_cpu_events) {
> +		defer->cpu_events = kcalloc(num_possible_cpus(),
> +					    sizeof(*defer->cpu_events),
> +					    GFP_KERNEL);
> +		if (!defer->cpu_events) {
> +			ret = -ENOMEM;
> +			goto free;
> +		}
> +		for (int cpu = 0; cpu < num_possible_cpus(); cpu++) {
> +			rcuwait_init(&defer->cpu_events[cpu].pending_unwind_wait);
> +			INIT_LIST_HEAD(&defer->cpu_events[cpu].list);
> +		}
> +
> +		ret = unwind_deferred_init(&defer->unwind_work,
> +					   perf_event_deferred_cpu);
> +		if (ret)
> +			goto free;
> +	}
> +
> +	if (list_empty(&defer->cpu_events[event->cpu].list))
> +		defer->nr_cpu_events++;
> +	list_add_tail_rcu(&event->unwind_list, &defer->cpu_events[event->cpu].list);
> +
> +	event->unwind_deferred = defer;
> +	return 0;
> +free:
> +	if (found)
> +		return ret;
> +
> +	list_del(&defer->list);
> +	kfree(defer->cpu_events);
> +	kfree(defer);
> +	return ret;
> +}
> +
> +static void perf_remove_unwind_deferred(struct perf_event *event)
> +{
> +	struct perf_unwind_deferred *defer = event->unwind_deferred;
> +	struct perf_unwind_cpu *cpu_unwind;
> +
> +	if (!defer)
> +		return;
> +
> +	guard(mutex)(&unwind_deferred_mutex);
> +	list_del_rcu(&event->unwind_list);
> +
> +	cpu_unwind = &defer->cpu_events[event->cpu];
> +
> +	if (list_empty(&cpu_unwind->list)) {
> +		defer->nr_cpu_events--;
> +		if (!defer->nr_cpu_events)
> +			unwind_deferred_cancel(&defer->unwind_work);
> +	}
> +	/* Make sure perf_event_deferred_cpu() is done with this event */
> +	rcuwait_wait_event(&cpu_unwind->pending_unwind_wait,
> +				   !cpu_unwind->processing, TASK_UNINTERRUPTIBLE);
> +
> +	event->unwind_deferred = NULL;
> +
> +	/* Is this still being used by other per CPU events? */
> +	if (defer->nr_cpu_events)
> +		return;
> +
> +	list_del(&defer->list);
> +	kfree(defer->cpu_events);
> +	kfree(defer);
> +}
> +
>  static void perf_pending_unwind_sync(struct perf_event *event)
>  {
>  	might_sleep();
>  
> +	perf_remove_unwind_deferred(event);
> +
>  	if (!event->pending_unwind_callback)
>  		return;
>  
> @@ -5568,33 +5686,19 @@ struct perf_callchain_deferred_event {
>  	u64				ips[];
>  };
>  
> -static void perf_event_callchain_deferred(struct callback_head *work)
> +static void perf_event_callchain_deferred(struct perf_event *event,
> +					  struct unwind_stacktrace *trace)
>  {
> -	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
>  	struct perf_callchain_deferred_event deferred_event;
>  	u64 callchain_context = PERF_CONTEXT_USER;
> -	struct unwind_stacktrace trace;
>  	struct perf_output_handle handle;
>  	struct perf_sample_data data;
>  	u64 nr;
>  
> -	if (!event->pending_unwind_callback)
> -		return;
> -
> -	if (unwind_deferred_trace(&trace) < 0)
> -		goto out;
> -
> -	/*
> -	 * All accesses to the event must belong to the same implicit RCU
> -	 * read-side critical section as the ->pending_unwind_callback reset.
> -	 * See comment in perf_pending_unwind_sync().
> -	 */
> -	guard(rcu)();
> -
>  	if (current->flags & PF_KTHREAD)
> -		goto out;
> +		return;
>  
> -	nr = trace.nr + 1 ; /* '+1' == callchain_context */
> +	nr = trace->nr + 1 ; /* '+1' == callchain_context */
>  
>  	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
>  	deferred_event.header.misc = PERF_RECORD_MISC_USER;
> @@ -5605,21 +5709,74 @@ static void perf_event_callchain_deferred(struct callback_head *work)
>  	perf_event_header__init_id(&deferred_event.header, &data, event);
>  
>  	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
> -		goto out;
> +		return;
>  
>  	perf_output_put(&handle, deferred_event);
>  	perf_output_put(&handle, callchain_context);
> -	perf_output_copy(&handle, trace.entries, trace.nr * sizeof(u64));
> +	perf_output_copy(&handle, trace->entries, trace->nr * sizeof(u64));
>  	perf_event__output_id_sample(event, &handle, &data);
>  
>  	perf_output_end(&handle);
> +}
> +
> +/* Deferred unwinding callback for task specific events */
> +static void perf_event_deferred_task(struct callback_head *work)
> +{
> +	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
> +	struct unwind_stacktrace trace;
> +
> +	if (!event->pending_unwind_callback)
> +		return;
> +
> +	if (unwind_deferred_trace(&trace) >= 0) {
> +
> +		/*
> +		 * All accesses to the event must belong to the same implicit RCU
> +		 * read-side critical section as the ->pending_unwind_callback reset.
> +		 * See comment in perf_pending_unwind_sync().
> +		 */
> +		guard(rcu)();
> +		perf_event_callchain_deferred(event, &trace);
> +	}
>  
> -out:
>  	event->pending_unwind_callback = 0;
>  	local_dec(&event->ctx->nr_no_switch_fast);
>  	rcuwait_wake_up(&event->pending_unwind_wait);
>  }
>  
> +/* Deferred unwinding callback for per CPU events */
> +static void perf_event_deferred_cpu(struct unwind_work *work,
> +				    struct unwind_stacktrace *trace, u64 cookie)
> +{
> +	struct perf_unwind_deferred *defer =
> +		container_of(work, struct perf_unwind_deferred, unwind_work);
> +	struct perf_unwind_cpu *cpu_unwind;
> +	struct perf_event *event;
> +	int cpu;
> +
> +	guard(rcu)();
> +	guard(preempt)();
> +
> +	cpu = smp_processor_id();
> +	cpu_unwind = &defer->cpu_events[cpu];
> +
> +	WRITE_ONCE(cpu_unwind->processing, 1);
> +	/*
> +	 * Make sure the above is seen for the rcuwait in
> +	 * perf_remove_unwind_deferred() before iterating the loop.
> +	 */
> +	smp_mb();
> +
> +	list_for_each_entry_rcu(event, &cpu_unwind->list, unwind_list) {
> +		perf_event_callchain_deferred(event, trace);
> +		/* Only the first CPU event gets the trace */
> +		break;

I guess this is to emit a callchain record when more than one events
requested the deferred callchains for the same task like:

  $ perf record -a -e cycles,instructions

right?


> +	}
> +
> +	WRITE_ONCE(cpu_unwind->processing, 0);
> +	rcuwait_wake_up(&cpu_unwind->pending_unwind_wait);
> +}
> +
>  static void perf_free_addr_filters(struct perf_event *event);
>  
>  /* vs perf_event_alloc() error */
> @@ -8198,6 +8355,15 @@ static int deferred_request_nmi(struct perf_event *event)
>  	return 0;
>  }
>  
> +static int deferred_unwind_request(struct perf_unwind_deferred *defer)
> +{
> +	u64 cookie;
> +	int ret;
> +
> +	ret = unwind_deferred_request(&defer->unwind_work, &cookie);
> +	return ret < 0 ? ret : 0;
> +}
> +
>  /*
>   * Returns:
>  *     > 0 : if already queued.
> @@ -8210,11 +8376,14 @@ static int deferred_request(struct perf_event *event)
>  	int pending;
>  	int ret;
>  
> -	/* Only defer for task events */
> -	if (!event->ctx->task)
> +	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
>  		return -EINVAL;
>  
> -	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
> +	if (event->unwind_deferred)
> +		return deferred_unwind_request(event->unwind_deferred);
> +
> +	/* Per CPU events should have had unwind_deferred set! */
> +	if (WARN_ON_ONCE(!event->ctx->task))
>  		return -EINVAL;
>  
>  	if (in_nmi())
> @@ -13100,13 +13269,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  		}
>  	}
>  
> +	/* Setup unwind deferring for per CPU events */
> +	if (event->attr.defer_callchain && !task) {

As I said it should handle per-task and per-CPU events.  How about this?

	if (event->attr.defer_callchain) {
		if (event->cpu >= 0) {
			err = perf_add_unwind_deferred(event);
			if (err)
				return ERR_PTR(err);
		} else {
			init_task_work(&event->pending_unwind_work,
					perf_event_callchain_deferred,
					perf_event_deferred_task);
		}
	}

> +		err = perf_add_unwind_deferred(event);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
>  	err = security_perf_event_alloc(event);
>  	if (err)
>  		return ERR_PTR(err);
>  
>  	if (event->attr.defer_callchain)
>  		init_task_work(&event->pending_unwind_work,
> -			       perf_event_callchain_deferred);
> +			       perf_event_deferred_task);

And you can remove here.

Thanks,
Namhyung

>  
>  	/* symmetric to unaccount_event() in _free_event() */
>  	account_event(event);
> -- 
> 2.47.2
> 
> 


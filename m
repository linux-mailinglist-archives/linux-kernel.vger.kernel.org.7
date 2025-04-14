Return-Path: <linux-kernel+bounces-602004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC4EA87507
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 02:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FB2188D30A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 00:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB2B148857;
	Mon, 14 Apr 2025 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hk8nCMkE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3958F66
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744591036; cv=none; b=GS4ES67iZBfN2ZHAQ/rb0eCXTbfqmfBhM7o/XzvA4vgjd1XUBeFlnU6BjmmgnmqvASeYHsxB97Iqj2w1A5yoP8x0mppR1ijDLdyrRivRfsQ6+itSkbY1O8TedjGo7lLdsZtZcvgjFMnc2PM0MJHGAcRBO05rSZsjA/NETWb3Qfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744591036; c=relaxed/simple;
	bh=XFJb5dDe4J3sgJ1rT3nyntFu3i34wv0KrOPlGG5B2tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6CDr4snYQ+ZMkZhhTN7mx2ryKCKgqfNMb3bNoQM+9OA+lWnLneRSGjDq+nbeid16p+sJGyOcQsoYP4AVOFJjNZoXurZJxgFD7cvacatnCw7DbzvSihrJz0ATxSal1I0+Ljanj6SH+n+ay+5AaGvm1QVLBXVNQBgVHJxJmrOSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hk8nCMkE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744591035; x=1776127035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XFJb5dDe4J3sgJ1rT3nyntFu3i34wv0KrOPlGG5B2tA=;
  b=hk8nCMkEE/6BbhhoEWTKgPAzoaG1I/cPDru/0Gcwlkz6g5nRdAMVqea5
   s4XbTvLFxevH9J0WntviS6RyotRC7gHkQ/aG9Kx7DsjKdmDCUG6tKIfPw
   bC41lIb1FCCb5UN3HF/7UAEKSjAsYgqFCuDUGNn4o7HyjcWm84TdkpiNY
   C42DWqUrA9kMxdne1CMaV1RA845xd37MnHKsruCxQXL0Q4E6VrAs48dar
   qbkkoto9V5F9GxONYRUsC0AB5x2C4nvAOTClSARUtMUckJqSv0/9oUcz8
   TeWScIB2ZdHdJ2ey1FjKPLZb9M3ny+2RgmKAgvxoBIhrnWGTpo8KJlACs
   A==;
X-CSE-ConnectionGUID: +Yx1evSNQkKMR3Fsy2Ah9w==
X-CSE-MsgGUID: oVbHKIpMTS+dggvccSHDnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46059544"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="46059544"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 17:37:14 -0700
X-CSE-ConnectionGUID: NMW+6fbySN+FnuJHa53NvQ==
X-CSE-MsgGUID: UCuu4CxMTkCDjAP9JcLDzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="129996319"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 17:37:10 -0700
Message-ID: <a0e3eccd-314a-4073-a570-0fe7b27c25c8@linux.intel.com>
Date: Mon, 14 Apr 2025 08:37:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
 ravi.bangoria@amd.com, lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
References: <20250307193305.486326750@infradead.org>
 <20250307193723.525402029@infradead.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250307193723.525402029@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/8/2025 3:33 AM, Peter Zijlstra wrote:
> Previously it was only safe to call perf_pmu_unregister() if there
> were no active events of that pmu around -- which was impossible to
> guarantee since it races all sorts against perf_init_event().
>
> Rework the whole thing by:
>
>  - keeping track of all events for a given pmu
>
>  - 'hiding' the pmu from perf_init_event()
>
>  - waiting for the appropriate (s)rcu grace periods such that all
>    prior references to the PMU will be completed
>
>  - detaching all still existing events of that pmu (see first point)
>    and moving them to a new REVOKED state.
>
>  - actually freeing the pmu data.
>
> Where notably the new REVOKED state must inhibit all event actions
> from reaching code that wants to use event->pmu.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/perf_event.h |   15 +-
>  kernel/events/core.c       |  294 ++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 274 insertions(+), 35 deletions(-)
>
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -325,6 +325,9 @@ struct perf_output_handle;
>  struct pmu {
>  	struct list_head		entry;
>  
> +	spinlock_t			events_lock;
> +	struct list_head		events;
> +
>  	struct module			*module;
>  	struct device			*dev;
>  	struct device			*parent;
> @@ -632,9 +635,10 @@ struct perf_addr_filter_range {
>   * enum perf_event_state - the states of an event:
>   */
>  enum perf_event_state {
> -	PERF_EVENT_STATE_DEAD		= -4,
> -	PERF_EVENT_STATE_EXIT		= -3,
> -	PERF_EVENT_STATE_ERROR		= -2,
> +	PERF_EVENT_STATE_DEAD		= -5,
> +	PERF_EVENT_STATE_REVOKED	= -4, /* pmu gone, must not touch */
> +	PERF_EVENT_STATE_EXIT		= -3, /* task died, still inherit */
> +	PERF_EVENT_STATE_ERROR		= -2, /* scheduling error, can enable */
>  	PERF_EVENT_STATE_OFF		= -1,
>  	PERF_EVENT_STATE_INACTIVE	=  0,
>  	PERF_EVENT_STATE_ACTIVE		=  1,
> @@ -875,6 +879,7 @@ struct perf_event {
>  	void *security;
>  #endif
>  	struct list_head		sb_list;
> +	struct list_head		pmu_list;
>  
>  	/*
>  	 * Certain events gets forwarded to another pmu internally by over-
> @@ -1132,7 +1137,7 @@ extern void perf_aux_output_flag(struct
>  extern void perf_event_itrace_started(struct perf_event *event);
>  
>  extern int perf_pmu_register(struct pmu *pmu, const char *name, int type);
> -extern void perf_pmu_unregister(struct pmu *pmu);
> +extern int perf_pmu_unregister(struct pmu *pmu);
>  
>  extern void __perf_event_task_sched_in(struct task_struct *prev,
>  				       struct task_struct *task);
> @@ -1734,7 +1739,7 @@ static inline bool needs_branch_stack(st
>  
>  static inline bool has_aux(struct perf_event *event)
>  {
> -	return event->pmu->setup_aux;
> +	return event->pmu && event->pmu->setup_aux;
>  }
>  
>  static inline bool has_aux_action(struct perf_event *event)
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -207,6 +207,7 @@ static void perf_ctx_unlock(struct perf_
>  }
>  
>  #define TASK_TOMBSTONE ((void *)-1L)
> +#define EVENT_TOMBSTONE ((void *)-1L)
>  
>  static bool is_kernel_event(struct perf_event *event)
>  {
> @@ -2348,6 +2349,11 @@ static void perf_child_detach(struct per
>  
>  	sync_child_event(event);
>  	list_del_init(&event->child_list);
> +	/*
> +	 * Cannot set to NULL, as that would confuse the situation vs
> +	 * not being a child event. See for example unaccount_event().
> +	 */
> +	event->parent = EVENT_TOMBSTONE;
>  }
>  
>  static bool is_orphaned_event(struct perf_event *event)
> @@ -2469,7 +2475,9 @@ ctx_time_update_event(struct perf_event_
>  
>  #define DETACH_GROUP	0x01UL
>  #define DETACH_CHILD	0x02UL
> -#define DETACH_DEAD	0x04UL
> +#define DETACH_EXIT	0x04UL
> +#define DETACH_REVOKE	0x08UL
> +#define DETACH_DEAD	0x10UL
>  
>  /*
>   * Cross CPU call to remove a performance event
> @@ -2484,6 +2492,7 @@ __perf_remove_from_context(struct perf_e
>  			   void *info)
>  {
>  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
> +	enum perf_event_state state = PERF_EVENT_STATE_OFF;
>  	unsigned long flags = (unsigned long)info;
>  
>  	ctx_time_update(cpuctx, ctx);
> @@ -2492,16 +2501,22 @@ __perf_remove_from_context(struct perf_e
>  	 * Ensure event_sched_out() switches to OFF, at the very least
>  	 * this avoids raising perf_pending_task() at this time.
>  	 */
> -	if (flags & DETACH_DEAD)
> +	if (flags & DETACH_EXIT)
> +		state = PERF_EVENT_STATE_EXIT;
> +	if (flags & DETACH_REVOKE)
> +		state = PERF_EVENT_STATE_REVOKED;
> +	if (flags & DETACH_DEAD) {
>  		event->pending_disable = 1;
> +		state = PERF_EVENT_STATE_DEAD;
> +	}
>  	event_sched_out(event, ctx);
>  	if (flags & DETACH_GROUP)
>  		perf_group_detach(event);
>  	if (flags & DETACH_CHILD)
>  		perf_child_detach(event);
>  	list_del_event(event, ctx);
> -	if (flags & DETACH_DEAD)
> -		event->state = PERF_EVENT_STATE_DEAD;
> +
> +	event->state = min(event->state, state);
>  
>  	if (!pmu_ctx->nr_events) {
>  		pmu_ctx->rotate_necessary = 0;
> @@ -4560,7 +4575,8 @@ static void perf_event_enable_on_exec(st
>  
>  static void perf_remove_from_owner(struct perf_event *event);
>  static void perf_event_exit_event(struct perf_event *event,
> -				  struct perf_event_context *ctx);
> +				  struct perf_event_context *ctx,
> +				  bool revoke);
>  
>  /*
>   * Removes all events from the current task that have been marked
> @@ -4587,7 +4603,7 @@ static void perf_event_remove_on_exec(st
>  
>  		modified = true;
>  
> -		perf_event_exit_event(event, ctx);
> +		perf_event_exit_event(event, ctx, false);
>  	}
>  
>  	raw_spin_lock_irqsave(&ctx->lock, flags);
> @@ -5187,6 +5203,7 @@ static bool is_sb_event(struct perf_even
>  	    attr->context_switch || attr->text_poke ||
>  	    attr->bpf_event)
>  		return true;
> +
>  	return false;
>  }
>  
> @@ -5388,6 +5405,8 @@ static void perf_pending_task_sync(struc
>  /* vs perf_event_alloc() error */
>  static void __free_event(struct perf_event *event)
>  {
> +	struct pmu *pmu = event->pmu;
> +
>  	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
>  		put_callchain_buffers();
>  
> @@ -5414,6 +5433,7 @@ static void __free_event(struct perf_eve
>  		 * put_pmu_ctx() needs an event->ctx reference, because of
>  		 * epc->ctx.
>  		 */
> +		WARN_ON_ONCE(!pmu);
>  		WARN_ON_ONCE(!event->ctx);
>  		WARN_ON_ONCE(event->pmu_ctx->ctx != event->ctx);
>  		put_pmu_ctx(event->pmu_ctx);
> @@ -5426,8 +5446,13 @@ static void __free_event(struct perf_eve
>  	if (event->ctx)
>  		put_ctx(event->ctx);
>  
> -	if (event->pmu)
> -		module_put(event->pmu->module);
> +	if (pmu) {
> +		module_put(pmu->module);
> +		scoped_guard (spinlock, &pmu->events_lock) {
> +			list_del(&event->pmu_list);
> +			wake_up_var(pmu);
> +		}
> +	}
>  
>  	call_rcu(&event->rcu_head, free_event_rcu);
>  }
> @@ -5575,7 +5600,11 @@ int perf_event_release_kernel(struct per
>  	 * Thus this guarantees that we will in fact observe and kill _ALL_
>  	 * child events.
>  	 */
> -	perf_remove_from_context(event, DETACH_GROUP|DETACH_DEAD);
> +	if (event->state > PERF_EVENT_STATE_REVOKED) {
> +		perf_remove_from_context(event, DETACH_GROUP|DETACH_DEAD);
> +	} else {
> +		event->state = PERF_EVENT_STATE_DEAD;
> +	}
>  
>  	perf_event_ctx_unlock(event, ctx);
>  
> @@ -5628,7 +5657,7 @@ int perf_event_release_kernel(struct per
>  		mutex_unlock(&ctx->mutex);
>  
>  		if (child)
> -			free_event(child);
> +			put_event(child);
>  		put_ctx(ctx);
>  
>  		goto again;
> @@ -5863,7 +5892,7 @@ __perf_read(struct perf_event *event, ch
>  	 * error state (i.e. because it was pinned but it couldn't be
>  	 * scheduled on to the CPU at some point).
>  	 */
> -	if (event->state == PERF_EVENT_STATE_ERROR)
> +	if (event->state <= PERF_EVENT_STATE_ERROR)
>  		return 0;
>  
>  	if (count < event->read_size)
> @@ -5902,8 +5931,14 @@ static __poll_t perf_poll(struct file *f
>  	struct perf_buffer *rb;
>  	__poll_t events = EPOLLHUP;
>  
> +	if (event->state <= PERF_EVENT_STATE_REVOKED)
> +		return EPOLLERR;
> +
>  	poll_wait(file, &event->waitq, wait);
>  
> +	if (event->state <= PERF_EVENT_STATE_REVOKED)
> +		return EPOLLERR;
> +
>  	if (is_event_hup(event))
>  		return events;
>  
> @@ -6078,6 +6113,9 @@ static long _perf_ioctl(struct perf_even
>  	void (*func)(struct perf_event *);
>  	u32 flags = arg;
>  
> +	if (event->state <= PERF_EVENT_STATE_REVOKED)
> +		return -ENODEV;
> +
>  	switch (cmd) {
>  	case PERF_EVENT_IOC_ENABLE:
>  		func = _perf_event_enable;
> @@ -6453,9 +6491,22 @@ void ring_buffer_put(struct perf_buffer
>  	call_rcu(&rb->rcu_head, rb_free_rcu);
>  }
>  
> +typedef void (*mapped_f)(struct perf_event *event, struct mm_struct *mm);
> +
> +#define get_mapped(event, func)			\
> +({	struct pmu *pmu;			\
> +	mapped_f f = NULL;			\
> +	guard(rcu)();				\
> +	pmu = READ_ONCE(event->pmu);		\
> +	if (pmu)				\
> +		f = pmu->func;			\
> +	f;					\
> +})
> +
>  static void perf_mmap_open(struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = vma->vm_file->private_data;
> +	mapped_f mapped = get_mapped(event, event_mapped);
>  
>  	atomic_inc(&event->mmap_count);
>  	atomic_inc(&event->rb->mmap_count);
> @@ -6463,8 +6514,8 @@ static void perf_mmap_open(struct vm_are
>  	if (vma->vm_pgoff)
>  		atomic_inc(&event->rb->aux_mmap_count);
>  
> -	if (event->pmu->event_mapped)
> -		event->pmu->event_mapped(event, vma->vm_mm);
> +	if (mapped)
> +		mapped(event, vma->vm_mm);
>  }
>  
>  static void perf_pmu_output_stop(struct perf_event *event);
> @@ -6480,14 +6531,16 @@ static void perf_pmu_output_stop(struct
>  static void perf_mmap_close(struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = vma->vm_file->private_data;
> +	mapped_f unmapped = get_mapped(event, event_unmapped);
>  	struct perf_buffer *rb = ring_buffer_get(event);
>  	struct user_struct *mmap_user = rb->mmap_user;
>  	int mmap_locked = rb->mmap_locked;
>  	unsigned long size = perf_data_size(rb);
>  	bool detach_rest = false;
>  
> -	if (event->pmu->event_unmapped)
> -		event->pmu->event_unmapped(event, vma->vm_mm);
> +	/* FIXIES vs perf_pmu_unregister() */
> +	if (unmapped)
> +		unmapped(event, vma->vm_mm);
>  
>  	/*
>  	 * The AUX buffer is strictly a sub-buffer, serialize using aux_mutex
> @@ -6680,6 +6733,7 @@ static int perf_mmap(struct file *file,
>  	unsigned long nr_pages;
>  	long user_extra = 0, extra = 0;
>  	int ret, flags = 0;
> +	mapped_f mapped;
>  
>  	/*
>  	 * Don't allow mmap() of inherited per-task counters. This would
> @@ -6710,6 +6764,16 @@ static int perf_mmap(struct file *file,
>  	mutex_lock(&event->mmap_mutex);
>  	ret = -EINVAL;
>  
> +	/*
> +	 * This relies on __pmu_detach_event() taking mmap_mutex after marking
> +	 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
> +	 * will detach the rb created here.
> +	 */
> +	if (event->state <= PERF_EVENT_STATE_REVOKED) {
> +		ret = -ENODEV;
> +		goto unlock;
> +	}
> +
>  	if (vma->vm_pgoff == 0) {
>  		nr_pages -= 1;
>  
> @@ -6888,8 +6952,9 @@ static int perf_mmap(struct file *file,
>  	if (!ret)
>  		ret = map_range(rb, vma);
>  
> -	if (!ret && event->pmu->event_mapped)
> -		event->pmu->event_mapped(event, vma->vm_mm);
> +	mapped = get_mapped(event, event_mapped);
> +	if (mapped)
> +		mapped(event, vma->vm_mm);
>  
>  	return ret;
>  }
> @@ -6900,6 +6965,9 @@ static int perf_fasync(int fd, struct fi
>  	struct perf_event *event = filp->private_data;
>  	int retval;
>  
> +	if (event->state <= PERF_EVENT_STATE_REVOKED)
> +		return -ENODEV;
> +
>  	inode_lock(inode);
>  	retval = fasync_helper(fd, filp, on, &event->fasync);
>  	inode_unlock(inode);
> @@ -10866,6 +10934,9 @@ static int __perf_event_set_bpf_prog(str
>  {
>  	bool is_kprobe, is_uprobe, is_tracepoint, is_syscall_tp;
>  
> +	if (event->state <= PERF_EVENT_STATE_REVOKED)
> +		return -ENODEV;
> +
>  	if (!perf_event_is_tracing(event))
>  		return perf_event_set_bpf_handler(event, prog, bpf_cookie);
>  
> @@ -12049,6 +12120,9 @@ int perf_pmu_register(struct pmu *_pmu,
>  	if (!pmu->event_idx)
>  		pmu->event_idx = perf_event_idx_default;
>  
> +	INIT_LIST_HEAD(&pmu->events);
> +	spin_lock_init(&pmu->events_lock);
> +
>  	/*
>  	 * Now that the PMU is complete, make it visible to perf_try_init_event().
>  	 */
> @@ -12062,21 +12136,143 @@ int perf_pmu_register(struct pmu *_pmu,
>  }
>  EXPORT_SYMBOL_GPL(perf_pmu_register);
>  
> -void perf_pmu_unregister(struct pmu *pmu)
> +static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
> +			       struct perf_event_context *ctx)
> +{
> +	/*
> +	 * De-schedule the event and mark it REVOKED.
> +	 */
> +	perf_event_exit_event(event, ctx, true);
> +
> +	/*
> +	 * All _free_event() bits that rely on event->pmu:
> +	 *
> +	 * Notably, perf_mmap() relies on the ordering here.
> +	 */
> +	scoped_guard (mutex, &event->mmap_mutex) {
> +		WARN_ON_ONCE(pmu->event_unmapped);
> +		/*
> +		 * Mostly an empty lock sequence, such that perf_mmap(), which
> +		 * relies on mmap_mutex, is sure to observe the state change.
> +		 */
> +	}
> +
> +	perf_event_free_bpf_prog(event);
> +	perf_free_addr_filters(event);
> +
> +	if (event->destroy) {
> +		event->destroy(event);
> +		event->destroy = NULL;
> +	}
> +
> +	if (event->pmu_ctx) {
> +		put_pmu_ctx(event->pmu_ctx);
> +		event->pmu_ctx = NULL;
> +	}
> +
> +	exclusive_event_destroy(event);
> +	module_put(pmu->module);
> +
> +	event->pmu = NULL; /* force fault instead of UAF */
> +}
> +
> +static void pmu_detach_event(struct pmu *pmu, struct perf_event *event)
> +{
> +	struct perf_event_context *ctx;
> +
> +	ctx = perf_event_ctx_lock(event);
> +	__pmu_detach_event(pmu, event, ctx);
> +	perf_event_ctx_unlock(event, ctx);
> +
> +	scoped_guard (spinlock, &pmu->events_lock)
> +		list_del(&event->pmu_list);
> +}
> +
> +static struct perf_event *pmu_get_event(struct pmu *pmu)
> +{
> +	struct perf_event *event;
> +
> +	guard(spinlock)(&pmu->events_lock);
> +	list_for_each_entry(event, &pmu->events, pmu_list) {
> +		if (atomic_long_inc_not_zero(&event->refcount))
> +			return event;
> +	}
> +
> +	return NULL;
> +}
> +
> +static bool pmu_empty(struct pmu *pmu)
> +{
> +	guard(spinlock)(&pmu->events_lock);
> +	return list_empty(&pmu->events);
> +}
> +
> +static void pmu_detach_events(struct pmu *pmu)
> +{
> +	struct perf_event *event;
> +
> +	for (;;) {
> +		event = pmu_get_event(pmu);
> +		if (!event)
> +			break;
> +
> +		pmu_detach_event(pmu, event);
> +		put_event(event);
> +	}
> +
> +	/*
> +	 * wait for pending _free_event()s
> +	 */
> +	wait_var_event(pmu, pmu_empty(pmu));
> +}
> +
> +int perf_pmu_unregister(struct pmu *pmu)
>  {
>  	scoped_guard (mutex, &pmus_lock) {
> +		if (!idr_cmpxchg(&pmu_idr, pmu->type, pmu, NULL))
> +			return -EINVAL;
> +
>  		list_del_rcu(&pmu->entry);
> -		idr_remove(&pmu_idr, pmu->type);
>  	}
>  
>  	/*
>  	 * We dereference the pmu list under both SRCU and regular RCU, so
>  	 * synchronize against both of those.
> +	 *
> +	 * Notably, the entirety of event creation, from perf_init_event()
> +	 * (which will now fail, because of the above) until
> +	 * perf_install_in_context() should be under SRCU such that
> +	 * this synchronizes against event creation. This avoids trying to
> +	 * detach events that are not fully formed.
>  	 */
>  	synchronize_srcu(&pmus_srcu);
>  	synchronize_rcu();
>  
> +	if (pmu->event_unmapped && !pmu_empty(pmu)) {
> +		/*
> +		 * Can't force remove events when pmu::event_unmapped()
> +		 * is used in perf_mmap_close().
> +		 */
> +		guard(mutex)(&pmus_lock);
> +		idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu);
> +		list_add_rcu(&pmu->entry, &pmus);
> +		return -EBUSY;
> +	}
> +
> +	scoped_guard (mutex, &pmus_lock)
> +		idr_remove(&pmu_idr, pmu->type);
> +
> +	/*
> +	 * PMU is removed from the pmus list, so no new events will
> +	 * be created, now take care of the existing ones.
> +	 */
> +	pmu_detach_events(pmu);
> +
> +	/*
> +	 * PMU is unused, make it go away.
> +	 */
>  	perf_pmu_free(pmu);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(perf_pmu_unregister);
>  
> @@ -12170,7 +12366,7 @@ static struct pmu *perf_init_event(struc
>  	struct pmu *pmu;
>  	int type, ret;
>  
> -	guard(srcu)(&pmus_srcu);
> +	guard(srcu)(&pmus_srcu); /* pmu idr/list access */
>  
>  	/*
>  	 * Save original type before calling pmu->event_init() since certain
> @@ -12394,6 +12590,7 @@ perf_event_alloc(struct perf_event_attr
>  	INIT_LIST_HEAD(&event->active_entry);
>  	INIT_LIST_HEAD(&event->addr_filters.list);
>  	INIT_HLIST_NODE(&event->hlist_entry);
> +	INIT_LIST_HEAD(&event->pmu_list);
>  
>  
>  	init_waitqueue_head(&event->waitq);
> @@ -12561,6 +12758,13 @@ perf_event_alloc(struct perf_event_attr
>  	/* symmetric to unaccount_event() in _free_event() */
>  	account_event(event);
>  
> +	/*
> +	 * Event creation should be under SRCU, see perf_pmu_unregister().
> +	 */
> +	lockdep_assert_held(&pmus_srcu);
> +	scoped_guard (spinlock, &pmu->events_lock)
> +		list_add(&event->pmu_list, &pmu->events);
> +
>  	return_ptr(event);
>  }
>  
> @@ -12760,6 +12964,9 @@ perf_event_set_output(struct perf_event
>  		goto unlock;
>  
>  	if (output_event) {
> +		if (output_event->state <= PERF_EVENT_STATE_REVOKED)
> +			goto unlock;
> +
>  		/* get the rb we want to redirect to */
>  		rb = ring_buffer_get(output_event);
>  		if (!rb)
> @@ -12941,6 +13148,11 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (event_fd < 0)
>  		return event_fd;
>  
> +	/*
> +	 * Event creation should be under SRCU, see perf_pmu_unregister().
> +	 */
> +	guard(srcu)(&pmus_srcu);
> +
>  	CLASS(fd, group)(group_fd);     // group_fd == -1 => empty
>  	if (group_fd != -1) {
>  		if (!is_perf_file(group)) {
> @@ -12948,6 +13160,10 @@ SYSCALL_DEFINE5(perf_event_open,
>  			goto err_fd;
>  		}
>  		group_leader = fd_file(group)->private_data;
> +		if (group_leader->state <= PERF_EVENT_STATE_REVOKED) {
> +			err = -ENODEV;
> +			goto err_fd;
> +		}
>  		if (flags & PERF_FLAG_FD_OUTPUT)
>  			output_event = group_leader;
>  		if (flags & PERF_FLAG_FD_NO_GROUP)
> @@ -13281,6 +13497,11 @@ perf_event_create_kernel_counter(struct
>  	if (attr->aux_output || attr->aux_action)
>  		return ERR_PTR(-EINVAL);
>  
> +	/*
> +	 * Event creation should be under SRCU, see perf_pmu_unregister().
> +	 */
> +	guard(srcu)(&pmus_srcu);
> +
>  	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
>  				 overflow_handler, context, -1);
>  	if (IS_ERR(event)) {
> @@ -13492,10 +13713,14 @@ static void sync_child_event(struct perf
>  }
>  
>  static void
> -perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
> +perf_event_exit_event(struct perf_event *event,
> +		      struct perf_event_context *ctx, bool revoke)
>  {
>  	struct perf_event *parent_event = event->parent;
> -	unsigned long detach_flags = 0;
> +	unsigned long detach_flags = DETACH_EXIT;
> +
> +	if (parent_event == EVENT_TOMBSTONE)
> +		parent_event = NULL;
>  
>  	if (parent_event) {
>  		/*
> @@ -13510,16 +13735,14 @@ perf_event_exit_event(struct perf_event
>  		 * Do destroy all inherited groups, we don't care about those
>  		 * and being thorough is better.
>  		 */
> -		detach_flags = DETACH_GROUP | DETACH_CHILD;
> +		detach_flags |= DETACH_GROUP | DETACH_CHILD;
>  		mutex_lock(&parent_event->child_mutex);
>  	}
>  
> -	perf_remove_from_context(event, detach_flags);
> +	if (revoke)
> +		detach_flags |= DETACH_GROUP | DETACH_REVOKE;
>  
> -	raw_spin_lock_irq(&ctx->lock);
> -	if (event->state > PERF_EVENT_STATE_EXIT)
> -		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
> -	raw_spin_unlock_irq(&ctx->lock);
> +	perf_remove_from_context(event, detach_flags);
>  
>  	/*
>  	 * Child events can be freed.
> @@ -13530,7 +13753,10 @@ perf_event_exit_event(struct perf_event
>  		 * Kick perf_poll() for is_event_hup();
>  		 */
>  		perf_event_wakeup(parent_event);
> -		free_event(event);
> +		/*
> +		 * pmu_detach_event() will have an extra refcount.
> +		 */
> +		put_event(event);
>  		put_event(parent_event);
>  		return;
>  	}
> @@ -13596,7 +13822,7 @@ static void perf_event_exit_task_context
>  		perf_event_task(task, ctx, 0);
>  
>  	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
> -		perf_event_exit_event(child_event, ctx);
> +		perf_event_exit_event(child_event, ctx, false);
>  
>  	mutex_unlock(&ctx->mutex);
>  
> @@ -13743,6 +13969,14 @@ inherit_event(struct perf_event *parent_
>  	if (parent_event->parent)
>  		parent_event = parent_event->parent;
>  
> +	if (parent_event->state <= PERF_EVENT_STATE_REVOKED)
> +		return NULL;
> +
> +	/*
> +	 * Event creation should be under SRCU, see perf_pmu_unregister().
> +	 */
> +	guard(srcu)(&pmus_srcu);
> +
>  	child_event = perf_event_alloc(&parent_event->attr,
>  					   parent_event->cpu,
>  					   child,
>
Hi Perter,

It seems this patch would break the task attached events counting like the
below command shows.

sudo ./perf stat true

 Performance counter stats for 'true':

     <not counted> msec task-clock
     <not counted>      context-switches
     <not counted>      cpu-migrations
     <not counted>      page-faults
     <not counted>      instructions
     <not counted>      cycles
     <not counted>      branches
     <not counted>      branch-misses

       0.002615279 seconds time elapsed

       0.002771000 seconds user
       0.000000000 seconds sys


Thanks,

Dapeng Mi



>


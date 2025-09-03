Return-Path: <linux-kernel+bounces-798867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B71B4240C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D1C7ABB74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693643090CF;
	Wed,  3 Sep 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CVK91dJx"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2833074A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911106; cv=none; b=HS3P8CgL5Z9YTuYL9F+K+wRVrUWRZEQnQ2uBQ+Prz2vEGhif8ESk/AFwTD2Q/3wpzUi2HuQ+pa57OMY8KbTF9cZd9PqtJ+idkGceKmMTzfvMeuivJpKM3DhRZdT1z4wfzl34r2/w0uHZLnc5Bmdqt4u02e0YG58bq/9m0jMaGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911106; c=relaxed/simple;
	bh=MfjgjH72QP1QwhsEKZEHmb0HoV5tx/kMkT/zQKRelNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpYfXVTDqUiZtHnUBTGwufBP4YDkz6kWPaFhaGQLDJdqjWYYQkeZ7BVYpc3nlTd4q/7HvsXPyNXeQ/xC1gof8gLWnkb6+RErBAMZvexO+BNmku3/klmOmAPEFXeutUIsff/k1dxX2+Cf/fLZ9QjZ7O5iwV0IQmFnT/KikBx7KbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CVK91dJx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YBvcfYmp5JBwxs4ANkYq7hS+zVBUW3GpMyglyjOVBwE=; b=CVK91dJxZXa70HrQGuFvkAcwzv
	rCLqLsL3CGSRBf03Pms487159Uy39ni+nfxyEhpXgHITXIgKMQDUIJ3OAWDCKTPrnuTlOyJwMbt7J
	gC+0w44e/caEMfHGfweBqT113xFFvg4y1q5IuD66ivAHyERpWu1cd4eeyCTjOPCBiIWF87CDmAhvp
	5qHY4Av3kAJ4guyjuI67BAaERudOaPqvS5sUeP6sLZ7rolrdvtKi6vUd3UjqOXcdofOKgZpta5Sln
	lmx6/1SNbsMcFpVbty8P/XxSd9Ps8e2V8y8tWFhscr1DqztHmzcZ6fMoP8p9rHSyRCe49haOsgM4l
	GObolJAw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utopZ-00000004BFT-3Bct;
	Wed, 03 Sep 2025 14:51:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 828B3300220; Wed, 03 Sep 2025 16:51:24 +0200 (CEST)
Date: Wed, 3 Sep 2025 16:51:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829081120.806-4-ziqianlu@bytedance.com>

On Fri, Aug 29, 2025 at 04:11:18PM +0800, Aaron Lu wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index dab4ed86d0c82..25b1014d4ef86 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5291,18 +5291,23 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  
>  	if (cfs_rq->nr_queued == 1) {
>  		check_enqueue_throttle(cfs_rq);
> -		if (!throttled_hierarchy(cfs_rq)) {
> -			list_add_leaf_cfs_rq(cfs_rq);
> -		} else {
> +		list_add_leaf_cfs_rq(cfs_rq);
>  #ifdef CONFIG_CFS_BANDWIDTH
> +		if (throttled_hierarchy(cfs_rq)) {
>  			struct rq *rq = rq_of(cfs_rq);
>  
>  			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
>  				cfs_rq->throttled_clock = rq_clock(rq);
>  			if (!cfs_rq->throttled_clock_self)
>  				cfs_rq->throttled_clock_self = rq_clock(rq);
> -#endif
> +
> +			if (cfs_rq->pelt_clock_throttled) {
> +				cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> +					cfs_rq->throttled_clock_pelt;
> +				cfs_rq->pelt_clock_throttled = 0;
> +			}
>  		}
> +#endif
>  	}
>  }
>  

> @@ -5450,8 +5451,18 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	if (flags & DEQUEUE_DELAYED)
>  		finish_delayed_dequeue_entity(se);
>  
> -	if (cfs_rq->nr_queued == 0)
> +	if (cfs_rq->nr_queued == 0) {
>  		update_idle_cfs_rq_clock_pelt(cfs_rq);
> +#ifdef CONFIG_CFS_BANDWIDTH
> +		if (throttled_hierarchy(cfs_rq)) {
> +			struct rq *rq = rq_of(cfs_rq);
> +
> +			list_del_leaf_cfs_rq(cfs_rq);
> +			cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> +			cfs_rq->pelt_clock_throttled = 1;
> +		}
> +#endif
> +	}
>  
>  	return true;
>  }

> @@ -6717,6 +6731,8 @@ static inline void sync_throttle(struct task_group *tg, int cpu) {}
>  static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
>  static void task_throttle_setup_work(struct task_struct *p) {}
>  static bool task_is_throttled(struct task_struct *p) { return false; }
> +static void dequeue_throttled_task(struct task_struct *p, int flags) {}
> +static bool enqueue_throttled_task(struct task_struct *p) { return false; }
>  
>  static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
>  {
> @@ -6909,6 +6925,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	int rq_h_nr_queued = rq->cfs.h_nr_queued;
>  	u64 slice = 0;
>  
> +	if (task_is_throttled(p) && enqueue_throttled_task(p))
> +		return;
> +
>  	/*
>  	 * The code below (indirectly) updates schedutil which looks at
>  	 * the cfs_rq utilization to select a frequency.
> @@ -6961,10 +6980,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		if (cfs_rq_is_idle(cfs_rq))
>  			h_nr_idle = 1;
>  
> -		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> -			goto enqueue_throttle;
> -
>  		flags = ENQUEUE_WAKEUP;
>  	}
>  
> @@ -6986,10 +7001,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  
>  		if (cfs_rq_is_idle(cfs_rq))
>  			h_nr_idle = 1;
> -
> -		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> -			goto enqueue_throttle;
>  	}
>  
>  	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
> @@ -7019,7 +7030,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (!task_new)
>  		check_update_overutilized_status(rq);
>  
> -enqueue_throttle:
>  	assert_list_leaf_cfs_rq(rq);
>  
>  	hrtick_update(rq);
> @@ -7074,10 +7084,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  		if (cfs_rq_is_idle(cfs_rq))
>  			h_nr_idle = h_nr_queued;
>  
> -		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> -			return 0;
> -
>  		/* Don't dequeue parent if it has other entities besides us */
>  		if (cfs_rq->load.weight) {
>  			slice = cfs_rq_min_slice(cfs_rq);
> @@ -7114,10 +7120,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  
>  		if (cfs_rq_is_idle(cfs_rq))
>  			h_nr_idle = h_nr_queued;
> -
> -		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> -			return 0;
>  	}
>  
>  	sub_nr_running(rq, h_nr_queued);
> @@ -7151,6 +7153,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>   */
>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  {
> +	if (task_is_throttled(p)) {
> +		dequeue_throttled_task(p, flags);
> +		return true;
> +	}
> +
>  	if (!p->se.sched_delayed)
>  		util_est_dequeue(&rq->cfs, p);
>  

OK, so this makes it so that either a task is fully enqueued (all
cfs_rq's) or full not. A group cfs_rq is only marked throttled when all
its tasks are gone, and unthrottled when a task gets added. Right?

But propagate_entity_cfs_rq() is still doing the old thing, and has a
if (cfs_rq_throttled(cfs_rq)) break; inside the for_each_sched_entity()
iteration.

This seems somewhat inconsistent; or am I missing something ? 



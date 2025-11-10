Return-Path: <linux-kernel+bounces-892557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA30FC4559B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AB7B4E8DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF032F7440;
	Mon, 10 Nov 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XIyEdig/"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EB2EA470
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762834; cv=none; b=ZaV/8p8ugFpZB6KXjxS4kYYNIno6Aigc85OGrciUB4nDlTzFIiePA2I6xhkbEW5UXX+MU5FWgFEy+ENT4jo7pKJ8T1zwHZzY8aOLsq+aBm8kyJVczX1XTJWfMQxjopdCP/1G+PtqT1FVwLkVAeo77DRESw/9O2e+fJkzdFMTkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762834; c=relaxed/simple;
	bh=N2seGgamKVNJkxiemETbJGpGIEpLgQfWLsV3JObAZa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeCmMfOuGiPRZbb0Lpj6V6PHJzzPlqjLnWq3XeEyRR1Ihbe5FafBGCODVufdN+hRNIt//1CUBZDtwe4yEmaCWKlO+mCwE6Re8QB0ifdGPGhEfSXyFVM8ZeFf4X/m1TgAPWu7Di6mkDmCj6KCcDKqv6ioqEtDyguZhzMgoXhR0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XIyEdig/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 09:20:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762762820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZN0nrp1CAT/vmr1lLJgZKJRO7oN7a+g/HfUBe+2ir8=;
	b=XIyEdig/KEOHtk1AD4na15CBWanjuuWeF3sTQFXQfK9U3cCIREGLGzr8BosTKOXxYNH7bf
	mdkFwue37BfhFLwfXq51iCOmVhJhFlwxmmOCH45QwS5eODHQXlKGsJOQuee72FsuIT0nsI
	LTnO0KiJwFHm236Csfe4l8uzAZCcs34=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] sched_ext: Exit dispatch and move operations
 immediately when aborting
Message-ID: <aRGgP4UQwgOdhgwj@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-7-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Tejun,

On Sun, Nov 09, 2025 at 08:31:05AM -1000, Tejun Heo wrote:
> 62dcbab8b0ef ("sched_ext: Avoid live-locking bypass mode switching") introduced
> the breather mechanism to inject delays during bypass mode switching. It
> maintains operation semantics unchanged while reducing lock contention to avoid
> live-locks on large NUMA systems.
> 
> However, the breather only activates when exiting the scheduler, so there's no
> need to maintain operation semantics. Simplify by exiting dispatch and move
> operations immediately when scx_aborting is set. In consume_dispatch_q(), break
> out of the task iteration loop. In scx_dsq_move(), return early before
> acquiring locks.
> 
> This also fixes cases the breather mechanism cannot handle. When a large system
> has many runnable threads affinitized to different CPU subsets and the BPF
> scheduler places them all into a single DSQ, many CPUs can scan the DSQ
> concurrently for tasks they can run. This can cause DSQ and RQ locks to be held
> for extended periods, leading to various failure modes. The breather cannot
> solve this because once in the consume loop, there's no exit. The new mechanism
> fixes this by exiting the loop immediately.
> 
> The bypass DSQ is exempted to ensure the bypass mechanism itself can make
> progress.
> 
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 62 ++++++++++++++--------------------------------
>  1 file changed, 18 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 905d01f74687..afa89ca3659e 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1821,48 +1821,11 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  	return dst_rq;
>  }
>  
> -/*
> - * A poorly behaving BPF scheduler can live-lock the system by e.g. incessantly
> - * banging on the same DSQ on a large NUMA system to the point where switching
> - * to the bypass mode can take a long time. Inject artificial delays while the
> - * bypass mode is switching to guarantee timely completion.
> - */
> -static void scx_breather(struct rq *rq)
> -{
> -	u64 until;
> -
> -	lockdep_assert_rq_held(rq);
> -
> -	if (likely(!READ_ONCE(scx_aborting)))
> -		return;
> -
> -	raw_spin_rq_unlock(rq);
> -
> -	until = ktime_get_ns() + NSEC_PER_MSEC;
> -
> -	do {
> -		int cnt = 1024;
> -		while (READ_ONCE(scx_aborting) && --cnt)
> -			cpu_relax();
> -	} while (READ_ONCE(scx_aborting) &&
> -		 time_before64(ktime_get_ns(), until));
> -
> -	raw_spin_rq_lock(rq);
> -}
> -
>  static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
>  			       struct scx_dispatch_q *dsq)
>  {
>  	struct task_struct *p;
>  retry:
> -	/*
> -	 * This retry loop can repeatedly race against scx_bypass() dequeueing
> -	 * tasks from @dsq trying to put the system into the bypass mode. On
> -	 * some multi-socket machines (e.g. 2x Intel 8480c), this can live-lock
> -	 * the machine into soft lockups. Give a breather.
> -	 */
> -	scx_breather(rq);
> -
>  	/*
>  	 * The caller can't expect to successfully consume a task if the task's
>  	 * addition to @dsq isn't guaranteed to be visible somehow. Test
> @@ -1876,6 +1839,17 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
>  	nldsq_for_each_task(p, dsq) {
>  		struct rq *task_rq = task_rq(p);
>  
> +		/*
> +		 * This loop can lead to multiple lockup scenarios, e.g. the BPF
> +		 * scheduler can put an enormous number of affinitized tasks into
> +		 * a contended DSQ, or the outer retry loop can repeatedly race
> +		 * against scx_bypass() dequeueing tasks from @dsq trying to put
> +		 * the system into the bypass mode. This can easily live-lock the
> +		 * machine. If aborting, exit from all non-bypass DSQs.
> +		 */
> +		if (unlikely(READ_ONCE(scx_aborting)) && dsq->id != SCX_DSQ_BYPASS)
> +			break;
> +
>  		if (rq == task_rq) {
>  			task_unlink_from_dsq(p, dsq);
>  			move_local_task_to_local_dsq(p, 0, dsq, rq);
> @@ -5635,6 +5609,13 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
>  		return false;
>  
> +	/*
> +	 * If the BPF scheduler keeps calling this function repeatedly, it can
> +	 * cause similar live-lock conditions as consume_dispatch_q().
> +	 */
> +	if (unlikely(scx_aborting))

READ_ONCE(scx_aborting)?

Thanks,
-Andrea

> +		return false;
> +
>  	/*
>  	 * Can be called from either ops.dispatch() locking this_rq() or any
>  	 * context where no rq lock is held. If latter, lock @p's task_rq which
> @@ -5655,13 +5636,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  		raw_spin_rq_lock(src_rq);
>  	}
>  
> -	/*
> -	 * If the BPF scheduler keeps calling this function repeatedly, it can
> -	 * cause similar live-lock conditions as consume_dispatch_q(). Insert a
> -	 * breather if necessary.
> -	 */
> -	scx_breather(src_rq);
> -
>  	locked_rq = src_rq;
>  	raw_spin_lock(&src_dsq->lock);
>  
> -- 
> 2.51.1
> 


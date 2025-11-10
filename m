Return-Path: <linux-kernel+bounces-892512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BCEC453F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2065D3B346C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBB62EBBA8;
	Mon, 10 Nov 2025 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t3xYshP9"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131822655B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760730; cv=none; b=smVNJiZ4W+FIwCZAYIQUeIxs2K2xX5RhRRgW9YaqLijALUIyuOGRSJVxh8rv9w85VaFjLnqxZCMdotJgv+cRtMpz61eDl6YJoKJRv0jgY8UOfT3AAqHM/Wk1jE4ehykZPUaPDcxgaxWQbOOwjSkhUCWgdx6Km8Ib+jrEm/nnCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760730; c=relaxed/simple;
	bh=ncDctEUMO/adI2xf/pRdMsLcKZ6EDpu1v0yyHcCMpJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifYXcMQTHlFr/90+dMxaKX3ZT60FEFpCTQyXcx7wuLFV3kG+4hNfFtNRTpmBtDSkgND/WhE0NM2i3SogiOTgOs8K7nGkRYOHOl/+cM8H3CoJi/HLBlqqhqAZAOesYlVPCQR9FMb466S2Xkkxrdb5huxIq7um+hUw4dJ3JjoBz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t3xYshP9; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 08:45:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762760715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G8F/pw6LTCKV6xhOO+Wo1kL7fBJ9QgyPyoV576NkuV4=;
	b=t3xYshP9pVNCqLzSkKd7kUo4nbdXrJ7ad2mbBgZM1a5+WuIWDbULFiT0QTZOTFR59PH917
	6ZZA9LV9zH2HynlPQ2sYKPrbvPbhMpdXeRKQP3Ol8Owr93tZwePsX/Fx5HEK2d2GIh1vjy
	YZsCDnHBJk5J9LPOn9KrCsK5s6ov/0A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] sched_ext: Simplify breather mechanism with
 scx_aborting flag
Message-ID: <aRGX_3UR_dPLTTrn@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-6-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 09, 2025 at 08:31:04AM -1000, Tejun Heo wrote:
> The breather mechanism was introduced in 62dcbab8b0ef ("sched_ext: Avoid
> live-locking bypass mode switching") and e32c260195e6 ("sched_ext: Enable the
> ops breather and eject BPF scheduler on softlockup") to prevent live-locks by
> injecting delays when CPUs are trapped in dispatch paths.
> 
> Currently, it uses scx_breather_depth (atomic_t) and scx_in_softlockup
> (unsigned long) with separate increment/decrement and cleanup operations. The
> breather is only activated when aborting, so tie it directly to the exit
> mechanism. Replace both variables with scx_aborting flag set when exit is
> claimed and cleared after bypass is enabled. Introduce scx_claim_exit() to
> consolidate exit_kind claiming and breather enablement. This eliminates
> scx_clear_softlockup() and simplifies scx_softlockup() and scx_bypass().
> 
> The breather mechanism will be replaced by a different abort mechanism in a
> future patch. This simplification prepares for that change.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 54 +++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 4b8b91494947..905d01f74687 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -33,9 +33,8 @@ static DEFINE_MUTEX(scx_enable_mutex);
>  DEFINE_STATIC_KEY_FALSE(__scx_enabled);
>  DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
>  static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
> -static unsigned long scx_in_softlockup;
> -static atomic_t scx_breather_depth = ATOMIC_INIT(0);
>  static int scx_bypass_depth;
> +static bool scx_aborting;
>  static bool scx_init_task_enabled;
>  static bool scx_switching_all;
>  DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
> @@ -1834,7 +1833,7 @@ static void scx_breather(struct rq *rq)
>  
>  	lockdep_assert_rq_held(rq);
>  
> -	if (likely(!atomic_read(&scx_breather_depth)))
> +	if (likely(!READ_ONCE(scx_aborting)))
>  		return;
>  
>  	raw_spin_rq_unlock(rq);
> @@ -1843,9 +1842,9 @@ static void scx_breather(struct rq *rq)
>  
>  	do {
>  		int cnt = 1024;
> -		while (atomic_read(&scx_breather_depth) && --cnt)
> +		while (READ_ONCE(scx_aborting) && --cnt)
>  			cpu_relax();
> -	} while (atomic_read(&scx_breather_depth) &&
> +	} while (READ_ONCE(scx_aborting) &&
>  		 time_before64(ktime_get_ns(), until));
>  
>  	raw_spin_rq_lock(rq);
> @@ -3740,30 +3739,14 @@ void scx_softlockup(u32 dur_s)
>  		goto out_unlock;
>  	}
>  
> -	/* allow only one instance, cleared at the end of scx_bypass() */
> -	if (test_and_set_bit(0, &scx_in_softlockup))
> -		goto out_unlock;
> -
>  	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU%d stuck for %us, disabling \"%s\"\n",
>  			smp_processor_id(), dur_s, scx_root->ops.name);
>  
> -	/*
> -	 * Some CPUs may be trapped in the dispatch paths. Enable breather
> -	 * immediately; otherwise, we might even be able to get to scx_bypass().
> -	 */
> -	atomic_inc(&scx_breather_depth);
> -
>  	scx_error(sch, "soft lockup - CPU#%d stuck for %us", smp_processor_id(), dur_s);
>  out_unlock:
>  	rcu_read_unlock();
>  }
>  
> -static void scx_clear_softlockup(void)
> -{
> -	if (test_and_clear_bit(0, &scx_in_softlockup))
> -		atomic_dec(&scx_breather_depth);
> -}
> -
>  /**
>   * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
>   * @bypass: true for bypass, false for unbypass
> @@ -3826,8 +3809,6 @@ static void scx_bypass(bool bypass)
>  				      ktime_get_ns() - bypass_timestamp);
>  	}
>  
> -	atomic_inc(&scx_breather_depth);
> -
>  	/*
>  	 * No task property is changing. We just need to make sure all currently
>  	 * queued tasks are re-queued according to the new scx_rq_bypassing()
> @@ -3883,10 +3864,8 @@ static void scx_bypass(bool bypass)
>  		raw_spin_rq_unlock(rq);
>  	}
>  
> -	atomic_dec(&scx_breather_depth);
>  unlock:
>  	raw_spin_unlock_irqrestore(&bypass_lock, flags);
> -	scx_clear_softlockup();
>  }
>  
>  static void free_exit_info(struct scx_exit_info *ei)
> @@ -3981,6 +3960,7 @@ static void scx_disable_workfn(struct kthread_work *work)
>  
>  	/* guarantee forward progress by bypassing scx_ops */
>  	scx_bypass(true);
> +	WRITE_ONCE(scx_aborting, false);
>  
>  	switch (scx_set_enable_state(SCX_DISABLING)) {
>  	case SCX_DISABLING:
> @@ -4103,9 +4083,24 @@ static void scx_disable_workfn(struct kthread_work *work)
>  	scx_bypass(false);
>  }
>  
> -static void scx_disable(enum scx_exit_kind kind)
> +static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
>  {
>  	int none = SCX_EXIT_NONE;
> +
> +	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
> +		return false;
> +
> +	/*
> +	 * Some CPUs may be trapped in the dispatch paths. Enable breather
> +	 * immediately; otherwise, we might not even be able to get to
> +	 * scx_bypass().
> +	 */
> +	WRITE_ONCE(scx_aborting, true);
> +	return true;
> +}
> +
> +static void scx_disable(enum scx_exit_kind kind)
> +{
>  	struct scx_sched *sch;
>  
>  	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
> @@ -4114,7 +4109,7 @@ static void scx_disable(enum scx_exit_kind kind)
>  	rcu_read_lock();
>  	sch = rcu_dereference(scx_root);
>  	if (sch) {
> -		atomic_try_cmpxchg(&sch->exit_kind, &none, kind);
> +		scx_claim_exit(sch, kind);
>  		kthread_queue_work(sch->helper, &sch->disable_work);
>  	}
>  	rcu_read_unlock();
> @@ -4435,9 +4430,8 @@ static void scx_vexit(struct scx_sched *sch,
>  		      const char *fmt, va_list args)
>  {
>  	struct scx_exit_info *ei = sch->exit_info;
> -	int none = SCX_EXIT_NONE;
>  
> -	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
> +	if (!scx_claim_exit(sch, kind))
>  		return;
>  
>  	ei->exit_code = exit_code;
> @@ -4653,6 +4647,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	 */
>  	WARN_ON_ONCE(scx_set_enable_state(SCX_ENABLING) != SCX_DISABLED);
>  	WARN_ON_ONCE(scx_root);
> +	if (WARN_ON_ONCE(READ_ONCE(scx_aborting)))
> +		WRITE_ONCE(scx_aborting, false);
>  
>  	atomic_long_set(&scx_nr_rejected, 0);
>  
> -- 
> 2.51.1
> 


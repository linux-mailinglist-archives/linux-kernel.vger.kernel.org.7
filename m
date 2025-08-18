Return-Path: <linux-kernel+bounces-774193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2475B2AFBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321133BE285
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8B22D2490;
	Mon, 18 Aug 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fB5uHMwB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549442D2481
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539288; cv=none; b=shxVwr6+x0EuTPMy75TC9NfxYVk3maADpQBlKyb7lcQ50QCbF+8oP1Sam26Fx388nqkY2zlnWpjnV5A5CMH9Ff1b6sjPzhbOWqW0UDuKEr2dtWJ1hMm5t3S80dZcKWN/M85EkxetMgH9Oiugp7qrTwV3SpU57OUkq9u5gaImXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539288; c=relaxed/simple;
	bh=7rgF92qv1icGeOC8Y9yv8wjgQIJmlrxF3A4oGmf99Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFr9w29+JMviQx22wmajjLsf/IPi4UrfpbziCLjuLUQ5Sw5tkcW4ZyHBQEewW2BNW4lUjTZCiKRerQKAWecrXJ3M40UPxvh47RiubQzNSxid/1QFHBk70G0d787ma/IvCPmxCJSh9deJwKUjMzi4DYffcm4Z+6jHh35IfHWC9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fB5uHMwB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ALvBuHNgounyw0+1k0c6W+txCotIJM5mmmpjMiqQK5Q=; b=fB5uHMwBSIxVO0XYNHLZNGLhHx
	fLOXsKMNtPR5BnyL+uwZVjGt5k8WCVT6vbXXSN7E4rSxM7D/D/XZXPE2MzuOpM7lnraZKpVQvWr8s
	Q0ohR50l0hDcnFZ8AD0OrfOSmtc4XL74lyAJ+zUhUxJkn+FtAPeo8R9VJbEMHImyvR638MgEnqMMF
	MItjAVzt+j5XrPC2vgwJ8oOnVUuSaCKnHKm5tq0b5CScx4j0bKW4EyxHuCTnlWLaTNW3PlUYBeF0W
	gb9KSBY+yb4eAvD4te8UXTAVGohp8e5pm/v9CwExj81MFVhsSnn1qBbvw96xVSRtR/cOQXJmIj02P
	y6x1KZig==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo3xZ-00000009IwW-1Vuk;
	Mon, 18 Aug 2025 17:47:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 88E0730034B; Mon, 18 Aug 2025 19:47:53 +0200 (CEST)
Date: Mon, 18 Aug 2025 19:47:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: liuwenfang <liuwenfang@honor.com>
Cc: 'Tejun Heo' <tj@kernel.org>, 'David Vernet' <void@manifault.com>,
	'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>,
	'Ingo Molnar' <mingo@redhat.com>,
	'Juri Lelli' <juri.lelli@redhat.com>,
	'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	'Ben Segall' <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>,
	'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Message-ID: <20250818174753.GA846072@noisy.programming.kicks-ass.net>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>
 <aHlvpRIcymNPPWh9@slm.duckdns.org>
 <46cef95e02d64b35a9d9d51d5debee22@honor.com>
 <6ccd5ef5752d4cc1818e152f6b3458b0@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ccd5ef5752d4cc1818e152f6b3458b0@honor.com>

On Sun, Jul 20, 2025 at 09:36:22AM +0000, liuwenfang wrote:
> Fix pnt_seq calculation for all transitions.

This doesn't even begin to be an adequate changelog.

And please, don't put an out of line function call in
put_prev_set_next_task(.

> Signed-off-by: Wenfang Liu liuwenfang@honor.com
> ---
>  kernel/sched/ext.c   | 23 ++++++++++++++---------
>  kernel/sched/fair.c  |  3 +++
>  kernel/sched/sched.h |  8 ++++++++
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f5133249f..93e03b7d0 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3191,14 +3191,6 @@ static void switch_class(struct rq *rq, struct task_struct *next)
>  {
>  	const struct sched_class *next_class = next->sched_class;
>  
> -#ifdef CONFIG_SMP
> -	/*
> -	 * Pairs with the smp_load_acquire() issued by a CPU in
> -	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
> -	 * resched.
> -	 */
> -	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
> -#endif
>  	if (!static_branch_unlikely(&scx_ops_cpu_preempt))
>  		return;
>  
> @@ -3233,6 +3225,19 @@ static void switch_class(struct rq *rq, struct task_struct *next)
>  	}
>  }
>  
> +void scx_put_prev_set_next(struct rq *rq, struct task_struct *prev,
> +			   struct task_struct *next)
> +{
> +#ifdef CONFIG_SMP
> +	/*
> +	 * Pairs with the smp_load_acquire() issued by a CPU in
> +	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
> +	 * resched.
> +	 */
> +	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
> +#endif
> +}
> +
>  static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  			      struct task_struct *next)
>  {
> @@ -5966,7 +5971,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  		if (cpu != cpu_of(this_rq)) {
>  			/*
>  			 * Pairs with smp_store_release() issued by this CPU in
> -			 * switch_class() on the resched path.
> +			 * scx_put_prev_set_next() on the resched path.
>  			 *
>  			 * We busy-wait here to guarantee that no other task can
>  			 * be scheduled on our core before the target CPU has
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0fb9bf995..50d757e92 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8887,6 +8887,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  
>  	__put_prev_set_next_dl_server(rq, prev, p);
>  
> +	if (scx_enabled())
> +		scx_put_prev_set_next(rq, prev, p);
> +
>  	/*
>  	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
>  	 * likely that a next task is from the same cgroup as the current.
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 47972f34e..bcb7f175c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1738,12 +1738,17 @@ static inline void scx_rq_clock_invalidate(struct rq *rq)
>  	WRITE_ONCE(rq->scx.flags, rq->scx.flags & ~SCX_RQ_CLK_VALID);
>  }
>  
> +void scx_put_prev_set_next(struct rq *rq, struct task_struct *prev,
> +			   struct task_struct *next);
>  #else /* !CONFIG_SCHED_CLASS_EXT */
>  #define scx_enabled()		false
>  #define scx_switched_all()	false
>  
>  static inline void scx_rq_clock_update(struct rq *rq, u64 clock) {}
>  static inline void scx_rq_clock_invalidate(struct rq *rq) {}
> +static inline void scx_put_prev_set_next(struct rq *rq,
> +					 struct task_struct *prev,
> +					 struct task_struct *next) {}
>  #endif /* !CONFIG_SCHED_CLASS_EXT */
>  
>  /*
> @@ -2465,6 +2470,9 @@ static inline void put_prev_set_next_task(struct rq *rq,
>  
>  	__put_prev_set_next_dl_server(rq, prev, next);
>  
> +	if (scx_enabled())
> +		scx_put_prev_set_next(rq, prev, next);
> +
>  	if (next == prev)
>  		return;
>  
> -- 
> 2.17.1


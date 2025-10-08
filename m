Return-Path: <linux-kernel+bounces-845517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB5FBC538F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DF319E0D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF3928488A;
	Wed,  8 Oct 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I3pOfsrQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27FD224B09
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930360; cv=none; b=msrkMOv2OhwaVHLU44EGMxEnK+oskgS41uGqSC17ER1SK6ZmuniQaML8K3WS3hjt4hK8fy/Gpb8Ffr1Lmi5sZKvoXaaIFAvOGjlJsge/KeHNJm+sdr5vtVDXIND4DcfwFzQ00w6UC7YZjI5tWh2Ock9iorle4QaFRf/tyhR/jxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930360; c=relaxed/simple;
	bh=cOstajPzyUJtcM4hc5XuNTeAcYg9t5vjF/7qJ+2ZWco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZPYxoovh9trLoasnRzBcVHrVmFO9uuZ+pvcPmj+PNEqdGguflQqAnp0hkTwTdI7oGNFexQ8mtTAyTxeSh5UKp7yeT0G1eQevhQZE7uuQpTDQPhR8bLzp4oPTAXwBSNNm5Gj5jjlkx/Rsyf49GOAA3jkP5T3qnFMHnhxNcdi7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I3pOfsrQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z9BTf0kjhOBu5265nWwITS42Sx9g3D10faulOiMKk6s=; b=I3pOfsrQYSeLhYZbk1YKhX/2Le
	WaGvm/sut2gx8iZqppWQtrhTK+zFr6Oub/FC/HQche+THyjmVMZsgnT6ztS/aoCpVLIBRCh9ZB3NR
	GfnuguGdeGYmb6EiLtVTsEkWJurfbtxOJzW3Mkld5CD3hpT4sLDe8MNEutut59Vxj3cLT+PkerDP2
	KwyHzmXsnWS1uWWNDD9QifAtKKYo+MGY8QpVV0RqPLvYtX6KbiPIK2PthkN7GhWhCR1snJMUqLQWk
	iiVZf8E3aqquCcSVb+mbn9LPTPLnTixAffiAM08BUSE2oMmuEz2ms75Mm7lazyHJMa0GgSb4evM1c
	OjkSkzfQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6UHH-00000005w0e-0f9q;
	Wed, 08 Oct 2025 13:32:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 65E49300400; Wed, 08 Oct 2025 15:32:23 +0200 (CEST)
Date: Wed, 8 Oct 2025 15:32:23 +0200
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
Subject: Re: [PATCH v22 4/6] sched: Handle blocked-waiter migration (and
 return migration)
Message-ID: <20251008133223.GT4067720@noisy.programming.kicks-ass.net>
References: <20250926032931.27663-1-jstultz@google.com>
 <20250926032931.27663-5-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926032931.27663-5-jstultz@google.com>

On Fri, Sep 26, 2025 at 03:29:12AM +0000, John Stultz wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7bba05c07a79d..d063d2c9bd5aa 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3157,6 +3157,14 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
>  
>  	__do_set_cpus_allowed(p, ctx);
>  
> +	/*
> +	 * It might be that the p->wake_cpu is no longer
> +	 * allowed, so set it to the dest_cpu so return
> +	 * migration doesn't send it to an invalid cpu
> +	 */

This comment isn't quite right; ->wake_cpu is a mere preference, it does
not have correctness concerns. That is, it is okay for ->wake_cpu to not
be inside cpus_allowed.

> +	if (!is_cpu_allowed(p, p->wake_cpu))
> +		p->wake_cpu = dest_cpu;
> +
>  	return affine_move_task(rq, p, rf, dest_cpu, ctx->flags);
>  
>  out:
> @@ -3717,6 +3725,72 @@ static inline void ttwu_do_wakeup(struct task_struct *p)
>  	trace_sched_wakeup(p);
>  }
>  
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +static inline void proxy_set_task_cpu(struct task_struct *p, int cpu)
> +{
> +	unsigned int wake_cpu;
> +
> +	/*
> +	 * Since we are enqueuing a blocked task on a cpu it may
> +	 * not be able to run on, preserve wake_cpu when we
> +	 * __set_task_cpu so we can return the task to where it
> +	 * was previously runnable.
> +	 */
> +	wake_cpu = p->wake_cpu;
> +	__set_task_cpu(p, cpu);
> +	p->wake_cpu = wake_cpu;

Humm, perhaps add an argument to __set_task_cpu() to not set ->wake_cpu
instead?

> +}
> +
> +static bool proxy_task_runnable_but_waking(struct task_struct *p)
> +{
> +	if (!sched_proxy_exec())
> +		return false;
> +	return (READ_ONCE(p->__state) == TASK_RUNNING &&
> +		READ_ONCE(p->blocked_on_state) == BO_WAKING);
> +}
> +
> +/*
> + * Checks to see if task p has been proxy-migrated to another rq
> + * and needs to be returned. If so, we deactivate the task here
> + * so that it can be properly woken up on the p->wake_cpu
> + * (or whichever cpu select_task_rq() picks at the bottom of
> + * try_to_wake_up()
> + */
> +static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
> +{
> +	bool ret = false;
> +
> +	if (!sched_proxy_exec())
> +		return false;
> +
> +	raw_spin_lock(&p->blocked_lock);
> +	if (__get_task_blocked_on(p) && p->blocked_on_state == BO_WAKING) {
> +		if (!task_current(rq, p) && (p->wake_cpu != cpu_of(rq))) {
> +			if (task_current_donor(rq, p)) {
> +				put_prev_task(rq, p);
> +				rq_set_donor(rq, rq->idle);
> +			}
> +			deactivate_task(rq, p, DEQUEUE_NOCLOCK);
> +			ret = true;
> +		}
> +		__set_blocked_on_runnable(p);
> +		resched_curr(rq);
> +	}
> +	raw_spin_unlock(&p->blocked_lock);
> +	return ret;
> +}
> +#else /* !CONFIG_SCHED_PROXY_EXEC */
> +static bool proxy_task_runnable_but_waking(struct task_struct *p)
> +{
> +	return false;
> +}
> +
> +static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_SCHED_PROXY_EXEC */
> +
>  static void
>  ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
>  		 struct rq_flags *rf)
> @@ -3802,6 +3876,8 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  		update_rq_clock(rq);
>  		if (p->se.sched_delayed)
>  			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> +		if (proxy_needs_return(rq, p))
> +			goto out;
>  		if (!task_on_cpu(rq, p)) {
>  			/*
>  			 * When on_rq && !on_cpu the task is preempted, see if
> @@ -3812,6 +3888,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  		ttwu_do_wakeup(p);
>  		ret = 1;
>  	}
> +out:
>  	__task_rq_unlock(rq, &rf);
>  
>  	return ret;
> @@ -4199,6 +4276,8 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  		 *    it disabling IRQs (this allows not taking ->pi_lock).
>  		 */
>  		WARN_ON_ONCE(p->se.sched_delayed);
> +		/* If current is waking up, we know we can run here, so set BO_RUNNBLE */
> +		set_blocked_on_runnable(p);
>  		if (!ttwu_state_match(p, state, &success))
>  			goto out;
>  
> @@ -4215,8 +4294,15 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 */
>  	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
>  		smp_mb__after_spinlock();
> -		if (!ttwu_state_match(p, state, &success))
> -			break;
> +		if (!ttwu_state_match(p, state, &success)) {
> +			/*
> +			 * If we're already TASK_RUNNING, and BO_WAKING
> +			 * continue on to ttwu_runnable check to force
> +			 * proxy_needs_return evaluation
> +			 */
> +			if (!proxy_task_runnable_but_waking(p))
> +				break;
> +		}
>  
>  		trace_sched_waking(p);

Oh gawd :-( why !?!? 

So AFAICT this makes ttwu() do dequeue when it finds WAKING, and then it
falls through to do the normal wakeup. So why can't we do dequeue to
begin with -- instead of setting WAKING in the first place?




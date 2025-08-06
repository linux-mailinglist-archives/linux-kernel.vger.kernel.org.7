Return-Path: <linux-kernel+bounces-758314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F9B1CD7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C443721CC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF221B196;
	Wed,  6 Aug 2025 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTzOUv+M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SnczAjWb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897F1A08BC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512444; cv=none; b=BRSbS3jsh4TIObs+5NRD/lhEeJ+FzuWdq/APVdSKFtUkDoxXQZYKgJuHs+a57S7EqPSPwx+pPfVk3V8lDRC7pztLYkkHnnXie0dtm+KdsPRy5Qwd3dOyzcl71svy9fxgAOGSn5/EVEqCnYMrI7Uks0md5O5X6PsY8mnPmTm1zZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512444; c=relaxed/simple;
	bh=732xNOI9lDW7wosAvZKiAD+0V1bnfWPInKwUoKwJBbU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=rTTzPa6yMKib/jfCV0smjnL6+GxH7z3hSy7GO4kQH5vVIUVtroe4ojMg2o4wup5DnSWMFi0lgW+0tvE4SoAUNIZcqBCQWBkV9Vq992iLby5JfK3Osc8d+aKqt1HkjiK90ejWJuBuRbxgYhySHhtT9u3hlvmoM3SD33ZzQoMtjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTzOUv+M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SnczAjWb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754512441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=5o9d0B3vWx4XvoPEwqJ67ZUHr/gSPghmkPH9XGmO9Lg=;
	b=MTzOUv+MPdx+9swT2KIdWTkMBGpzhtkKbnniOUE7QRWLfdeMpJyZ1Nr+cHELAalEBL7Prq
	nI7EEXm5/q3e/K9HsceNVarmuFoyue1L9Oc/0KJsXSkYpk0kPlWO+CptD3txojtVcH8/pr
	AqBNCu4V0XGCvEtaa9W4hdwYK27oj2XgshQxDPmTXmE3Yw1IeZQpz02R9MDfgXSP2vBozv
	4Kh/9vP102GWVD4XD+q4rKx+EEm5l7kdUWEsovIASv228gFz0UXntyjKN9MOQd8JTLTV6l
	X7LhErpO+/t6O4ROOdmzlUHK3XsazZ2uEgjA/8+I9ysilz+XKa6/ZNYx2vudQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754512441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=5o9d0B3vWx4XvoPEwqJ67ZUHr/gSPghmkPH9XGmO9Lg=;
	b=SnczAjWb6EkkEIRMwyFX172te8OvbE14jw92BWj6YJl3ras+SZuUJQlDim2bkkomatqDJL
	c10NwtIGys34uKAA==
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, bigeasy@linutronix.de,
 kprateek.nayak@amd.com, vineethr@linux.ibm.com,
 prakash.sangappa@oracle.com
Subject: Re: [PATCH V7 01/11] sched: Scheduler time slice extension
In-Reply-To: <20250724161625.2360309-2-prakash.sangappa@oracle.com>
Date: Wed, 06 Aug 2025 22:34:00 +0200
Message-ID: <87ms8cchqf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 16:16, Prakash Sangappa wrote:
> @@ -304,7 +304,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs);
>   * exit_to_user_mode_loop - do any pending work before leaving to user space
>   */
>  unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> -				     unsigned long ti_work);
> +				     unsigned long ti_work, bool irq);

I know the kernel-doc already lacks the description for the existing
arguments, but adding more undocumented ones is not the right thing
either.

Also please name this argument 'from_irq' to make it clear what this is
about.

>  /**
>   * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
> @@ -316,7 +316,7 @@ unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>   *    EXIT_TO_USER_MODE_WORK are set
>   * 4) check that interrupts are still disabled
>   */
> -static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
> +static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs, bool irq)

New argument not documented in kernel-doc.

>  {
>  	unsigned long ti_work;
>  
> @@ -327,7 +327,10 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
>  
>  	ti_work = read_thread_flags();
>  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
> -		ti_work = exit_to_user_mode_loop(regs, ti_work);
> +		ti_work = exit_to_user_mode_loop(regs, ti_work, irq);
> +
> +	if (IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY) && irq)
> +		rseq_delay_resched_arm_timer();

This is still an unconditional function call which is a NOOP for
everyone who does not use this. It's not that hard to inline the
check. How often do I have to explain that?

>  	arch_exit_to_user_mode_prepare(regs, ti_work);
>  
> @@ -396,6 +399,9 @@ static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
>  
>  	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
>  
> +	/* Reschedule if scheduler time delay was granted */

This is not rescheduling. It sets NEED_RESCHED, which is a completely
different thing.

> +	rseq_delay_set_need_resched();

I fundamentally hate this hack as it goes out to user space with
NEED_RESCHED set and absolutely zero debug mechanism which validates
it. Currently going out with NEED_RESCHED set is a plain bug, rigthfully
so.

But now this muck comes along and sets the flag, which is semantically
just wrong and ill defined.

The point is that NEED_RESCHED has been cleared by requesting and
granting the extension, which means the task can go out to userspace,
until it either relinquishes the CPU or hrtick() whacks it over the
head.

And your muck requires this insane hack with sched_yield():

>  SYSCALL_DEFINE0(sched_yield)
>  {
> +	/* Reschedule if scheduler time delay was granted */
> +	if (rseq_delay_set_need_resched())
> +		return 0;
> +
>  	do_sched_yield();
>  	return 0;
>  }

That's just completely wrong. Relinquishing the CPU should be possible
by any arbitrary syscall and not require to make sched_yield() more
ill-defined as it is already.

The obvious way to solve both issues is to clear NEED_RESCHED when
the delay is granted and then do in syscall_enter_from_user_mode_work()

        rseq_delay_sys_enter()
        {
             if (unlikely(current->rseq_delay_resched == GRANTED)) {
		    set_tsk_need_resched(current);
                    schedule();
             }       
        }     	

No?

It's debatable whether the schedule() there is necessary. Removing it
would allow the task to either complete the syscall and reschedule on
exit to user space or go to sleep in the syscall. But that's a trivial
detail.

The important point is that the NEED_RESCHED semantics stay sane and the
problem is solved right on the next syscall entry.

This delay is not for extending CPU time accross syscalls, it's solely
to allow user space to complete a _user space_ critical
section. Everything else is just wrong and we don't implement it as an
invitation for abuse.

For the record: I used GRANTED on purpose, because REQUESTED is
bogus. At the point where __rseq_delay_resched() is invoked _AND_
observes the user space request, it grants the delay, no?

This random nomenclature is just making this stuff annoyingly hard to
follow.

> +static inline bool rseq_delay_resched(unsigned long ti_work)
> +{
> +	if (!IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
> +		return false;
> +
> +	if (unlikely(current->rseq_delay_resched != RSEQ_RESCHED_DELAY_PROBE))
> +		return false;

Why unlikely? The majority of applications do not use this.

> +
> +	if (!(ti_work & (_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_LAZY)))
> +		return false;

The caller already established that one of these flags is set, no?

> +	if (__rseq_delay_resched()) {
> +		clear_tsk_need_resched(current);

Why has this to be inline and is not done in __rseq_delay_resched()?

> +		return true;
> +	}
> +	return false;

>  /**
>   * exit_to_user_mode_loop - do any pending work before leaving to user space
>   * @regs:	Pointer to pt_regs on entry stack
>   * @ti_work:	TIF work flags as read by the caller
>   */
>  __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> -						     unsigned long ti_work)
> +						     unsigned long ti_work, bool irq)
>  {

Same comments as above.

> +#ifdef	CONFIG_RSEQ_RESCHED_DELAY
> +bool __rseq_delay_resched(void)
> +{
> +	struct task_struct *t = current;
> +	u32 flags;
> +
> +	if (copy_from_user_nofault(&flags, &t->rseq->flags, sizeof(flags)))
> +		return false;
> +
> +	if (!(flags & RSEQ_CS_FLAG_DELAY_RESCHED))
> +		return false;
> +
> +	flags &= ~RSEQ_CS_FLAG_DELAY_RESCHED;
> +	if (copy_to_user_nofault(&t->rseq->flags, &flags, sizeof(flags)))
> +		return false;
> +
> +	t->rseq_delay_resched = RSEQ_RESCHED_DELAY_REQUESTED;
> +
> +	return true;
> +}
> +
> +void rseq_delay_resched_arm_timer(void)
> +{
> +	if (unlikely(current->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED))
> +		hrtick_local_start(30 * NSEC_PER_USEC);
> +}
> +
> +void rseq_delay_resched_tick(void)
> +{
> +	if (current->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED)
> +		set_tsk_need_resched(current);

Small enough to inline into hrtick() with a IS_ENABLED() guard, no?

> +}
> +#endif /* CONFIG_RSEQ_RESCHED_DELAY */
> +
>  #ifdef CONFIG_DEBUG_RSEQ
>  
>  /*
> @@ -493,6 +527,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>  		current->rseq = NULL;
>  		current->rseq_sig = 0;
>  		current->rseq_len = 0;
> +		if (IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
> +			current->rseq_delay_resched = RSEQ_RESCHED_DELAY_NONE;

What's that conditional for?

t->rseq_delay_resched is unconditionally available. Your choice of
optimizing the irrelevant places is amazing.

>  		return 0;
>  	}
>  
> @@ -561,6 +597,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>  	current->rseq = rseq;
>  	current->rseq_len = rseq_len;
>  	current->rseq_sig = sig;
> +	if (IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
> +		current->rseq_delay_resched = RSEQ_RESCHED_DELAY_PROBE;

Why is this done unconditionally for rseq?

So that any rseq user needs to do a function call and a copy_from_user()
just for nothing?

A task, which needs this muck, can very well opt-in for this and leave
everybody else unaffected, no?

prctl() exists for a reason and that allows even filtering out the
request to enable it if the sysadmin sets up filters accordingly.

As code which wants to utilize this has to be modified anyway, adding
the prctl() is not a unreasonable requirement.

>  	clear_preempt_need_resched();
> +	if (IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY) &&
> +	    prev->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED)
> +		prev->rseq_delay_resched = RSEQ_RESCHED_DELAY_PROBE;

Yet another code conditional for no reason. These are two bits and you can
use them smart:

#define ENABLED		1
#define GRANTED		3

So you can just go and do

   prev->rseq_delay_resched &= RSEQ_RESCHED_DELAY_ENABLED;

which clears the GRANTED bit without a conditional and that's correct
whether the ENABLED bit was set or not.

In the syscall exit path you then do:

static inline bool rseq_delay_resched(void)
{
   if (prev->rseq_delay_resched != ENABLED)
   	return false;
   return __rseq_delay_resched();
}

and __rseq_delay_resched() does:

    rseq_delay_resched = GRANTED;

No?

Thanks,

        tglx


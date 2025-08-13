Return-Path: <linux-kernel+bounces-767194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2119BB25067
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B133BB146
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FE128B3F8;
	Wed, 13 Aug 2025 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frgRTpkO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="37Tml7Tp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D5289809
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104181; cv=none; b=GMyU93OJfTbsFi/A3UgWgFFva5rZCRj0ASCTIpIGPJTc2gPcvNzPzdnzDYq1L7uOIh1FkKd9S6W7Cj53/wxGR5jMyd0z5gskWQnWN+6ZsbLx/mc2+ACUzwa9AB3fiDIDA2oN9D5dntNh4b8s88i6Jj53gSbPbkZIw97CKKf0J5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104181; c=relaxed/simple;
	bh=Aat3P72xuHZxKVk4UdJ7YeDr9UHquLCMr0Ej3tAnSlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TIr5LVvVfjasktlg2/pW5mDiFaCNvGU/cUnwNtKqRaCcRfAqVegwx3MDkSFmcozAIT6BXWloNNZa+HXJAw9vUhPXMjOssJyXKugFbqmBY+I4KgPjx/isEff7NYm+G5wY3dUKwjWIvW1YAN3haNZCkjS/lApU1BUYs34AmMEio1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frgRTpkO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=37Tml7Tp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755104177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM0GhTiT1PHAMkxhAOaCR9FRej4epI4UQNHvhBNbcqk=;
	b=frgRTpkOHVwapO6QhKZTqGvrKxXkCvSbz2dHg84kuZ/FnSTa/6QzJgrRVBbY0iwgfb63ou
	T31s8fczzzz9PI2NsVhQK6EqvzjpZrTBO4Z1usS7nGCzLJ02KkKUuVofY3CmWXW2VH7KTE
	CYRx30cIpui+NI97o/uSCjJJUl4/n/qTt2Ue4UlKCZnut3y/LI9sohdCBdl5hPADfA+19j
	ydUGiDtNbWeeop7ZzA5KMjMlhjwWN6RdEjal6oMZpoJEf70O5Ang+mgqrkv7Mxq1OWTzF0
	gnWtyXwMNyN0QHfp+njubuIWD0Y5NbMOQPZMhxyAIoJ6PiZzGft/tI2EESbv+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755104177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM0GhTiT1PHAMkxhAOaCR9FRej4epI4UQNHvhBNbcqk=;
	b=37Tml7TpJZ9MUikmgQtpXvMhCF9E8/Joqg/LbR8RnHEuZrk7rTm9nQGqrrW+iquT6c00py
	IUvNuoa8Olqm5vAw==
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org"
 <rostedt@goodmis.org>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "vineethr@linux.ibm.com"
 <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
In-Reply-To: <20250813161927.CFYHxNIv@linutronix.de>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-3-prakash.sangappa@oracle.com>
 <87a54bcmd7.ffs@tglx> <BF199244-10DF-4B84-99AF-DDA125F775E4@oracle.com>
 <87o6smb3a0.ffs@tglx> <20250813161927.CFYHxNIv@linutronix.de>
Date: Wed, 13 Aug 2025 18:56:16 +0200
Message-ID: <87jz376tzj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13 2025 at 18:19, bigeasy@linutronix.de wrote:
> I spent some time on the review. I tried to test it but for some reason
> userland always segfaults. This is not subject to your changes because
> param_test (from tools/testing/selftests/rseq) also segfaults. Also on a
> Debian v6.12. So this must be something else and maybe glibc related.

Hrm. I did not run the rseq tests. I only used the test I wrote, but
that works and the underlying glibc uses rseq too, but I might have
screwed up there. As I said it's POC. I'm about to send out the polished
version, which survive the selftests nicely :)

> On 2025-08-11 11:45:11 [+0200], Thomas Gleixner wrote:
>> +static __always_inline void rseq_slice_extension_timer(void);
>> +
>> +static __always_inline void rseq_exit_to_user_mode(void)
>
> Is this __always_inline required?

To prevent stupid compilers to put it out of line.

>> +static inline bool rseq_slice_extension_enabled(void) { return false; }
>> +static inline bool rseq_slice_extension_resched(void) { return false; }
>> +static inline bool rseq_syscall_enter_work(long syscall) { return false=
; }
>> +static __always_inline void rseq_slice_extension_timer(void) { }
>
> why is this one so special and seends __always_inline while the other
> are fine with inline?

Copy and pasta :)

>> +static inline bool rseq_reset_slice_extension(struct task_struct *curr)
>> +{
>> +	if (!rseq_slice_extension_enabled())
>> +		return true;
>> +
>> +	if (likely(!(curr->rseq_slice_extension & RSEQ_SLICE_EXTENSION_GRANTED=
)))
>> +		return true;
>
> We shouldn't get preempted because this would require an interrupt. But
> we could receive a signal which would bring us here, right?

Signal or a another round through the decision function, when
NEED_RESCHED was raised again.

> If an extension was not granted but userland enabled it set
> RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT, shouldn't we clear
> RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT indicating that we scheduled?

No. The user space flow is:

    set(REQUEST);
    critical_section();
    if (!test_and_clear_bit(REQUEST)) {
    	if (test_bit(GRANTED))
           sched_yield();
    }

This is not meant as a 'we scheduled' indicator, which is useless after
the fact. That's what critical sections are for.

> Or we keep things as they are because the signal handler is subject the
> same kind of extensions? The signal handler has a list of functions
> which are signal safe and that might end up in a syscall.
>
>> +	if (likely(!curr->rseq_event_mask))
>> +		return true;
>
> Why don't you need to clear SYSCALL_RSEQ_SLICE if !rseq_event_mask ?

The problem is that rseq_handle_notify_resume() is invoked
unconditionally when TIF_NOTIFY_RESUME is set, which can be set by other
functionalities too. So when nothing happened (no migration, signal,
preemption) then there is no point to revoke it, no?

My rework addresses that:

  https://lore.kernel.org/lkml/20250813155941.014821755@linutronix.de/

That's just preparatory work for this time slice muck :)

>> +
>> +	clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
>> +	curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_ENABLED;
>> +
>> +	return __rseq_reset_slice_extension(curr);
>> +}
>> +
>> +/*
>> + * Invoked from syscall entry if a time slice extension was granted and=
 the
>> + * kernel did not clear it before user space left the critical section.
>> + */
>> +bool rseq_syscall_enter_work(long syscall)
>> +{
>> +	struct task_struct *curr =3D current;
>> +	unsigned int slext =3D curr->rseq_slice_extension;
>> +
>> +	clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
>> +	curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_ENABLED;
>> +
>> +	/*
>> +	 * Kernel internal state inconsistency. SYSCALL_RSEQ_SLICE can only
>> +	 * be set when state is GRANTED!
>> +	 */
>> +	if (WARN_ON_ONCE(slext !=3D RSEQ_SLICE_EXTENSION_GRANTED))
>> +		return false;
>> +
>> +	set_tsk_need_resched(curr);
>> +
>> +	if (unlikely(!__rseq_reset_slice_extension(curr) || syscall !=3D __NR_=
sched_yield))
>> +		force_sigsegv(0);
>> +
>> +	/* Abort syscall to reschedule immediately */
>
> If the syscall is the sched_yield() as expected then you still abort it.
> You avoid the "scheduling" request from the do_sched_yield() (and
> everything the syscall does) and perform your schedule request due to
> the NEED_RESCHED flag above in exit_to_user_mode_loop().
> This explains why sched_yield(2) returns a return code !=3D 0 even the man
> page and the kernel function always returns 0. errno will be set in
> userland and the syscall tracer will bypass sched_yield in its trace.

I took the liberty to optimize it that way. It's also useful to see
whether this raced against the kernel:

    	if (test_bit(GRANTED))
-> Interrupt
		sched_yield();

that race can't be avoided. If the kernel wins, then sched_yield()
returns 0. We might change that later, but this makes a lot of sense
conceptually. Ideally we have a dedicated mechanism instead of relying
on sched_yield(), but that's bikeshed painting territory.

>> +	return true;
>> +}
>> +
>> +bool __rseq_grant_slice_extension(unsigned int slext)
>> +{
>> +	struct task_struct *curr =3D current;
>> +	u32 rflags;
>> +
>> +	if (unlikely(get_user(rflags, &curr->rseq->flags)))
>> +		goto die;
>> +
>> +	/*
>> +	 * Happens when exit_to_user_mode_loop() loops and has
>> +	 * TIF_NEED_RESCHED* set again. Clear the grant and schedule.
>> +	 */
>
> Not only that. Also if userland does not finish its critical section
> before a subsequent scheduling request happens.

Correct.

>> +	if (unlikely(slext =3D=3D RSEQ_SLICE_EXTENSION_GRANTED)) {
>> +		curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_ENABLED;
>> +		clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
>> +		if (!rseq_clear_slice_granted(curr, rflags))
>> +			goto die;
>> +		return false;
>> +	}
>> +
>> +	/* User space set the flag. That's a violation of the contract. */
>> +	if (unlikely(rflags & RSEQ_CS_FLAG_SLICE_EXT_GRANTED))
>> +		goto die;
>> +
>> +	/* User space is not interrested. */
>> +	if (likely(!(rflags & RSEQ_CS_FLAG_SLICE_EXT_REQUEST)))
>> +		return false;
>> +
>> +	/*
>> +	 * Don't bother if the rseq event mask has bits pending. The task
>> +	 * was preempted.
>> +	 */
>> +	if (curr->rseq_event_mask)
>> +		return false;
>> +
>> +	/* Grant the request and update user space */
>> +	rflags &=3D ~RSEQ_CS_FLAG_SLICE_EXT_REQUEST;
>> +	rflags |=3D RSEQ_CS_FLAG_SLICE_EXT_GRANTED;
>> +	if (unlikely(put_user(rflags, &curr->rseq->flags)))
>> +		goto die;
>> +
>> +	curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_GRANTED;
>> +	set_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
>> +	clear_tsk_need_resched(curr);
>
> If you keep doing this also for NEED_RESCHED then you should clear the
> preemption counter via
> 	clear_preempt_need_resched();
>
> otherwise you could stumble upon a spinlock_t on your way out and visit
> the scheduler anyway.

Hmm. Good point.

> Enforcing is one thing. The documentation should mention that you must
> not invoke any syscalls other than sched_yield() after setting
> RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT or you get the segfault thrown at
> you.
> Your testcase does clock_gettime(). This works as long as the syscall
> can be handled via vDSO.

Of course :)

>> +	// CHECKME: Is this correct?
>> +	if (rseq_slice_extension_resched())
>> +		return HRTIMER_NORESTART;
>> +
>
> You shouldn't need to return early HRTIMER_NORESTART in hrtick().
> If the extension is not yet granted then rseq_slice_extension_resched()
> returns false and the task_tick() below does the usual thing setting
> RESCHED_LAZY. This will be cleared on return to userland granting an
> extension, arming the timer again.
> If this fires for the second time then let the sched_class->task_tick do
> the usual and set RESCHED_LAZY. Given that we return from IRQ
> exit_to_user_mode_loop() will clear the grant and go to schedule().

No. This is all wrong and I implemented a dedicated timer for this as
the abuse of HRTICK is daft and depending on the scheduler state (HRTICK
can be disabled) this might cause hard to diagnose subtle surprises.

>> +void hrtick_extend_timeslice(ktime_t nsecs)
>> +{
>> +	struct rq *rq =3D this_rq();
>> +
>> +	guard(rq_lock_irqsave)(rq);
>> +	hrtimer_start(&rq->hrtick_timer, nsecs, HRTIMER_MODE_REL_PINNED_HARD);
>
> You arm the timer after granting an extension. So it run for some time,
> got a scheduling request and now you extend it and keep the timer to
> honour it. If the user does yield before the timer fires then schedule()
> should clear the timer. I *think* you need update __schedule() because
> it has
> |         if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
> |                 hrtick_clear(rq);
>
> and HRTICK is disabled by default
> | grep -i hrtick --color /sys/kernel/debug/sched/features
> | PLACE_LAG =E2=80=A6 NO_HRTICK NO_HRTICK_DL =E2=80=A6

See new code :)
> gcc has __atomic_fetch_and() and __atomic_fetch_or() provided as
> built-ins.
> There is atomic_fetch_and_explicit() and atomic_fetch_or_explicit()
> provided by <stdatomic.h>. Mostly the same magic.
>
> If you use this like
> |  static inline int test_and_clear_bit(unsigned long *ptr, unsigned int =
bit)
> |  {
> |          return __atomic_fetch_and(ptr, ~(1 << bit), __ATOMIC_RELAXED) =
& (1 << bit);
> |  }
>
> the gcc will emit btr. Sadly the lock prefix will be there, too. On the
> plus side you would have logic for every architecture.

I know, but the whole point is to avoid the LOCK prefix because it's not
necessary in this context and slows things down. The only requirement is
CPU local atomicity vs. an interrupt/exception/NMI or whatever the CPU
uses to mess things up. You need LOCK if you have cross CPU concurrency,
which is not the case here. The LOCK is very measurable when you use
this pattern with a high frequency and that's what the people who long
for this do :)

Thanks,

        tglx







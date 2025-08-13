Return-Path: <linux-kernel+bounces-767136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E3DB24FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E536843AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB364288510;
	Wed, 13 Aug 2025 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ei93uZqX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3u6or27k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481D2882C0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101972; cv=none; b=btMz0vBjC19W+UxL6nf4gHI3S8HIyteuzwPCw48aeahn1udg2xVn3OP2s7b+30bjOm7Pl5CAiq41ck9IjlaS8HlCHXv+7ZRFwtW7uNhFwnN+yS027GA3f2v8M7id/6aGszQnXKexCwoeuANByX/c1NlW8wNz9vi80kFMQvPYHPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101972; c=relaxed/simple;
	bh=IFvU7jlgiFKfUc/wnT2YVuhWAwsBleV7crs6t9p6oBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+w4wAZJnFGjs4zaZOCO5+Ru6CK9CN1fVoROYIORwHfZXQM05bIdpV5DflKk+iqWeuyrXVMePeYp88ZPZN/Jx/hXR6cuc50ncoopAVTr/D9q1bPfBnb99brCpoEf5CF2fJTCMA9hacm2WNlS9wu429rUmVRQ5qsrk9O+A2oCJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ei93uZqX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3u6or27k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Aug 2025 18:19:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755101969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2nDylor15Cs8et9izg5weApcfxFF+I1sKLLh1Qq7ps=;
	b=ei93uZqXM1TYUCxeIAsgq/rogZHYfbsCB+AEOtPiA9RD2W3S8pcmuGFyvlMj0EimpHMqD/
	+zxP3DW+qYUP7jQ9vk923zlWAT5AarpKm2FcwrEFf04ee0zYMbekPryVUyZC0M1Rxm8HGF
	TBFTAejyNKwajZ3tEIiPz2uYM44ZUx+izEh2cCessEZitJLlaGxI5XqPbWJdsUz8MRF7xa
	20uCMhI3PpJOfYUqtNBvO/zirI0GXPe2V18Q54VH/FYV98UrVcfixeGdKYSQXfWGebvpcc
	LjqhY7EZOW534p7nthllH9x9EjDhEwvjCkx/F4Ybgz3G/Tqs8FIhNpYqMMwkNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755101969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2nDylor15Cs8et9izg5weApcfxFF+I1sKLLh1Qq7ps=;
	b=3u6or27k2pptjZs3Q0msJ2/3GGzU9S+XMj7/ltRpZlVoTEv9kyiFWM+tT4GvFiQjhGDlm6
	rv3zyBQPXTTJ4wBg==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"vineethr@linux.ibm.com" <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
Message-ID: <20250813161927.CFYHxNIv@linutronix.de>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-3-prakash.sangappa@oracle.com>
 <87a54bcmd7.ffs@tglx>
 <BF199244-10DF-4B84-99AF-DDA125F775E4@oracle.com>
 <87o6smb3a0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87o6smb3a0.ffs@tglx>

I spent some time on the review. I tried to test it but for some reason
userland always segfaults. This is not subject to your changes because
param_test (from tools/testing/selftests/rseq) also segfaults. Also on a
Debian v6.12. So this must be something else and maybe glibc related.

On 2025-08-11 11:45:11 [+0200], Thomas Gleixner wrote:
=E2=80=A6
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -4,6 +4,7 @@
> =20
>  #ifdef CONFIG_RSEQ
> =20
> +#include <linux/jump_label.h>
>  #include <linux/preempt.h>
>  #include <linux/sched.h>
> =20
> @@ -61,6 +62,20 @@ static inline void rseq_migrate(struct t
>  	rseq_set_notify_resume(t);
>  }
> =20
> +static __always_inline void rseq_slice_extension_timer(void);
> +
> +static __always_inline void rseq_exit_to_user_mode(void)

Is this __always_inline required?

> +{
> +	rseq_slice_extension_timer();
> +	/*
> +	 * Clear the event mask so it does not contain stale bits when
> +	 * coming back from user space.
> +	 */
> +	current->rseq_event_mask =3D 0;
> +}
> +
> +static inline void rseq_slice_fork(struct task_struct *t, bool inherit);
> +
>  /*
>   * If parent process has a registered restartable sequences area, the
>   * child inherits. Unregister rseq for a clone with CLONE_VM set.
> @@ -86,46 +103,127 @@ static inline void rseq_execve(struct ta
=E2=80=A6

> -#else
> -
> -static inline void rseq_syscall(struct pt_regs *regs)
> +#else /* CONFIG_RSEQ_SLICE_EXTENSION */
> +static inline bool rseq_slice_extension_enabled(void) { return false; }
> +static inline bool rseq_slice_extension_resched(void) { return false; }
> +static inline bool rseq_syscall_enter_work(long syscall) { return false;=
 }
> +static __always_inline void rseq_slice_extension_timer(void) { }

why is this one so special and seends __always_inline while the other
are fine with inline?

> +static inline int rseq_slice_extension_prctl(unsigned long arg2, unsigne=
d long arg3)
>  {
> +	return -EINVAL;
>  }
=E2=80=A6
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -571,3 +591,189 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
=E2=80=A6
> +static bool __rseq_reset_slice_extension(struct task_struct *curr)
> +{
> +	u32 rflags;
> +
> +	if (get_user(rflags, &curr->rseq->flags))
> +		return false;
> +	return rseq_clear_slice_granted(curr, rflags);
> +}
> +
> +static inline bool rseq_reset_slice_extension(struct task_struct *curr)
> +{
> +	if (!rseq_slice_extension_enabled())
> +		return true;
> +
> +	if (likely(!(curr->rseq_slice_extension & RSEQ_SLICE_EXTENSION_GRANTED)=
))
> +		return true;

We shouldn't get preempted because this would require an interrupt. But
we could receive a signal which would bring us here, right?

If an extension was not granted but userland enabled it set
RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT, shouldn't we clear
RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT indicating that we scheduled?
Or we keep things as they are because the signal handler is subject the
same kind of extensions? The signal handler has a list of functions
which are signal safe and that might end up in a syscall.

> +	if (likely(!curr->rseq_event_mask))
> +		return true;

Why don't you need to clear SYSCALL_RSEQ_SLICE if !rseq_event_mask ?

> +
> +	clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
> +	curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_ENABLED;
> +
> +	return __rseq_reset_slice_extension(curr);
> +}
> +
> +/*
> + * Invoked from syscall entry if a time slice extension was granted and =
the
> + * kernel did not clear it before user space left the critical section.
> + */
> +bool rseq_syscall_enter_work(long syscall)
> +{
> +	struct task_struct *curr =3D current;
> +	unsigned int slext =3D curr->rseq_slice_extension;
> +
> +	clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
> +	curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_ENABLED;
> +
> +	/*
> +	 * Kernel internal state inconsistency. SYSCALL_RSEQ_SLICE can only
> +	 * be set when state is GRANTED!
> +	 */
> +	if (WARN_ON_ONCE(slext !=3D RSEQ_SLICE_EXTENSION_GRANTED))
> +		return false;
> +
> +	set_tsk_need_resched(curr);
> +
> +	if (unlikely(!__rseq_reset_slice_extension(curr) || syscall !=3D __NR_s=
ched_yield))
> +		force_sigsegv(0);
> +
> +	/* Abort syscall to reschedule immediately */

If the syscall is the sched_yield() as expected then you still abort it.
You avoid the "scheduling" request from the do_sched_yield() (and
everything the syscall does) and perform your schedule request due to
the NEED_RESCHED flag above in exit_to_user_mode_loop().
This explains why sched_yield(2) returns a return code !=3D 0 even the man
page and the kernel function always returns 0. errno will be set in
userland and the syscall tracer will bypass sched_yield in its trace.


> +	return true;
> +}
> +
> +bool __rseq_grant_slice_extension(unsigned int slext)
> +{
> +	struct task_struct *curr =3D current;
> +	u32 rflags;
> +
> +	if (unlikely(get_user(rflags, &curr->rseq->flags)))
> +		goto die;
> +
> +	/*
> +	 * Happens when exit_to_user_mode_loop() loops and has
> +	 * TIF_NEED_RESCHED* set again. Clear the grant and schedule.
> +	 */

Not only that. Also if userland does not finish its critical section
before a subsequent scheduling request happens.

> +	if (unlikely(slext =3D=3D RSEQ_SLICE_EXTENSION_GRANTED)) {
> +		curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_ENABLED;
> +		clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
> +		if (!rseq_clear_slice_granted(curr, rflags))
> +			goto die;
> +		return false;
> +	}
> +
> +	/* User space set the flag. That's a violation of the contract. */
> +	if (unlikely(rflags & RSEQ_CS_FLAG_SLICE_EXT_GRANTED))
> +		goto die;
> +
> +	/* User space is not interrested. */
> +	if (likely(!(rflags & RSEQ_CS_FLAG_SLICE_EXT_REQUEST)))
> +		return false;
> +
> +	/*
> +	 * Don't bother if the rseq event mask has bits pending. The task
> +	 * was preempted.
> +	 */
> +	if (curr->rseq_event_mask)
> +		return false;
> +
> +	/* Grant the request and update user space */
> +	rflags &=3D ~RSEQ_CS_FLAG_SLICE_EXT_REQUEST;
> +	rflags |=3D RSEQ_CS_FLAG_SLICE_EXT_GRANTED;
> +	if (unlikely(put_user(rflags, &curr->rseq->flags)))
> +		goto die;
> +
> +	curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_GRANTED;
> +	set_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
> +	clear_tsk_need_resched(curr);

If you keep doing this also for NEED_RESCHED then you should clear the
preemption counter via
	clear_preempt_need_resched();

otherwise you could stumble upon a spinlock_t on your way out and visit
the scheduler anyway.

> +	return true;
> +die:
> +	force_sig(SIGSEGV);
> +	return false;
> +}
=E2=80=A6
> --- /dev/null
> +++ b/Documentation/userspace-api/rseq.rst
> @@ -0,0 +1,92 @@
=E2=80=A6
> +If the request bit is still set when the leaving the critical section, u=
ser
> +space can clear it and continue.
> +
> +If the granted bit is set, then user space has to invoke sched_yield() w=
hen
                                                            sched_yield(2)

> +leaving the critical section to relinquish the CPU. The kernel enforces
> +this by arming a timer to prevent misbehaving user space from abusing th=
is
> +mechanism.
> +

Enforcing is one thing. The documentation should mention that you must
not invoke any syscalls other than sched_yield() after setting
RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT or you get the segfault thrown at
you.
Your testcase does clock_gettime(). This works as long as the syscall
can be handled via vDSO.

=E2=80=A6
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1883,6 +1883,18 @@ config RSEQ
> =20
>  	  If unsure, say Y.
> =20
> +config RSEQ_SLICE_EXTENSION
> +	bool "Enable rseq based time slice extension mechanism"
> +	depends on RSEQ && SCHED_HRTICK
> +	help
> +          Allows userspace to request a limited time slice extension when
an expanded tab

> +	  returning from an interrupt to user space via the RSEQ shared
> +	  data ABI. If granted, that allows to complete a critical section,
> +	  so that other threads are not stuck on a conflicted resource,
> +	  while the task is scheduled out.
> +
> +	  If unsure, say N.
> +
>  config DEBUG_RSEQ
>  	default n
>  	bool "Enable debugging of rseq() system call" if EXPERT
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -873,6 +874,10 @@ static enum hrtimer_restart hrtick(struc
> =20
>  	WARN_ON_ONCE(cpu_of(rq) !=3D smp_processor_id());
> =20
> +	// CHECKME: Is this correct?
> +	if (rseq_slice_extension_resched())
> +		return HRTIMER_NORESTART;
> +

You shouldn't need to return early HRTIMER_NORESTART in hrtick().
If the extension is not yet granted then rseq_slice_extension_resched()
returns false and the task_tick() below does the usual thing setting
RESCHED_LAZY. This will be cleared on return to userland granting an
extension, arming the timer again.
If this fires for the second time then let the sched_class->task_tick do
the usual and set RESCHED_LAZY. Given that we return from IRQ
exit_to_user_mode_loop() will clear the grant and go to schedule().

>  	rq_lock(rq, &rf);
>  	update_rq_clock(rq);
>  	rq->donor->sched_class->task_tick(rq, rq->curr, 1);
> @@ -902,6 +907,14 @@ static void __hrtick_start(void *arg)
>  	rq_unlock(rq, &rf);
>  }
> =20
> +void hrtick_extend_timeslice(ktime_t nsecs)
> +{
> +	struct rq *rq =3D this_rq();
> +
> +	guard(rq_lock_irqsave)(rq);
> +	hrtimer_start(&rq->hrtick_timer, nsecs, HRTIMER_MODE_REL_PINNED_HARD);

You arm the timer after granting an extension. So it run for some time,
got a scheduling request and now you extend it and keep the timer to
honour it. If the user does yield before the timer fires then schedule()
should clear the timer. I *think* you need update __schedule() because
it has
|         if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
|                 hrtick_clear(rq);

and HRTICK is disabled by default
| grep -i hrtick --color /sys/kernel/debug/sched/features
| PLACE_LAG =E2=80=A6 NO_HRTICK NO_HRTICK_DL =E2=80=A6

> +}
> +
>  /*
>   * Called to set the hrtick timer state.
>   *
=E2=80=A6
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/slice_test.c
> @@ -0,0 +1,205 @@
=E2=80=A6
> +#if defined(__x86_64__) || defined(__i386__)
> +
> +static __always_inline bool local_test_and_clear_bit(unsigned int bit,
> +						     volatile unsigned int *addr)
> +{
> +	bool res;
> +
> +	asm inline volatile("btrl %[__bit], %[__addr]\n"
> +			    : [__addr] "+m" (*addr), "=3D@cc" "c" (res)
> +			    : [__bit] "Ir" (bit)
> +			    : "memory");
> +	return res;
> +}
> +
> +static __always_inline void local_set_bit(unsigned int bit, volatile uns=
igned int *addr)
> +{
> +	volatile char *caddr =3D (void *)(addr) + (bit / BITS_PER_BYTE);
> +
> +	asm inline volatile("orb %b[__bit],%[__addr]\n"
> +			    : [__addr] "+m" (*caddr)
> +			    : [__bit] "iq" (1U << (bit & (BITS_PER_BYTE - 1)))
> +			    : "memory");
> +}

gcc has __atomic_fetch_and() and __atomic_fetch_or() provided as
built-ins.
There is atomic_fetch_and_explicit() and atomic_fetch_or_explicit()
provided by <stdatomic.h>. Mostly the same magic.

If you use this like
|  static inline int test_and_clear_bit(unsigned long *ptr, unsigned int bi=
t)
|  {
|          return __atomic_fetch_and(ptr, ~(1 << bit), __ATOMIC_RELAXED) & =
(1 << bit);
|  }

the gcc will emit btr. Sadly the lock prefix will be there, too. On the
plus side you would have logic for every architecture.

=E2=80=A6

Sebastian


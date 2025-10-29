Return-Path: <linux-kernel+bounces-876646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F26C1BF43
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41DA19C0D64
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E1833F39E;
	Wed, 29 Oct 2025 16:03:38 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5FB2F12AD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753817; cv=none; b=h5jgGUC2IHtkPFBC9erc9wQz0P2gvD2xEodWM/59FIakjcbJk/q1cI7mKRHJ4iyV6THXPjLXbbGQplgNln9BiAhTaNAhBeSUoBwhox75peBiVMJoBcxinIkBQVOGt/O31FoMqYsi/zccOfqXQ2EvsfElLk07I/9Z7DVBs7Nt8bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753817; c=relaxed/simple;
	bh=RLmLNepNt4y1usBIQOElsE3i6vwT8HjkuoRyppd20Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtAW+dwcWxNwOZhM9/YwbUo/8yuigdVXJHj6RtLvCnkqaGQnbBAXrwltwW+yytAu/mnPdNLEgGi7qCq+eWYDm+/Y4f2TKmlR1kRUKp+RctU/rpngD0dEXhm+nfkbvBQ/ClBfIxgx9Bbrue+G9ZOvJKYhV++PGdsGzE3zY9Dg3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C3A47160762;
	Wed, 29 Oct 2025 16:03:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 81BED20013;
	Wed, 29 Oct 2025 16:03:25 +0000 (UTC)
Date: Wed, 29 Oct 2025 12:04:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V6 19/31] rseq: Provide and use rseq_update_user_cs()
Message-ID: <20251029120405.569f9376@gandalf.local.home>
In-Reply-To: <20251027084307.151465632@linutronix.de>
References: <20251027084220.785525188@linutronix.de>
	<20251027084307.151465632@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qp4gsfk7t7fsmz8srpet8qj145zishtg
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 81BED20013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+IeyBF9dp5xgNNbdToVW2C83rfxSLvfNs=
X-HE-Tag: 1761753805-359847
X-HE-Meta: U2FsdGVkX1+GEl2JPMywOFy2WrI884rNtfk6Oyck2Hh4nPi2WI8T1aRtwzbn0JfUPmbDmosuzCGSt8z0N/XThr+wwJGke75SVrW/5RFrIXo6DqCbiUAgsA+xwyg9wR9SGcV/9zfhF5rBMNJjdmvNXAwj7MaPVXA11fBhGAQROiGgcdvNRuiz85CV1r8RBsMsIVy5IeJ2NZ4+e1QpKotyaDC7DF35JXiHu2tPTYuTGabfxlZmpeFByPAVOW+4jIMPys9imsi4yp+rYTGeLw+sTEt8lviveNEnoBXdUwZ9fTZuKfKIThc4WJwRS3ObYrUK

On Mon, 27 Oct 2025 09:44:57 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

>  include/linux/rseq_entry.h |  206 +++++++++++++++++++++++++++++++++++++
>  include/linux/rseq_types.h |   11 +-
>  kernel/rseq.c              |  244 +++++++++++++--------------------------------
>  3 files changed, 290 insertions(+), 171 deletions(-)
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -36,6 +36,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
>  #ifdef CONFIG_RSEQ
>  #include <linux/jump_label.h>
>  #include <linux/rseq.h>
> +#include <linux/uaccess.h>
>  
>  #include <linux/tracepoint-defs.h>
>  
> @@ -67,12 +68,217 @@ static inline void rseq_trace_ip_fixup(u
>  
>  DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
>  
> +#ifdef RSEQ_BUILD_SLOW_PATH
> +#define rseq_inline
> +#else
> +#define rseq_inline __always_inline
> +#endif
> +
> +bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);

So rseq_debug_update_user_cs() is always declared.

> +
>  static __always_inline void rseq_note_user_irq_entry(void)
>  {
>  	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
>  		current->rseq.event.user_irq = true;
>  }
>  
> +/*
> + * Check whether there is a valid critical section and whether the
> + * instruction pointer in @regs is inside the critical section.
> + *
> + *  - If the critical section is invalid, terminate the task.
> + *
> + *  - If valid and the instruction pointer is inside, set it to the abort IP
> + *
> + *  - If valid and the instruction pointer is outside, clear the critical
> + *    section address.
> + *
> + * Returns true, if the section was valid and either fixup or clear was
> + * done, false otherwise.
> + *
> + * In the failure case task::rseq_event::fatal is set when a invalid
> + * section was found. It's clear when the failure was an unresolved page
> + * fault.
> + *
> + * If inlined into the exit to user path with interrupts disabled, the
> + * caller has to protect against page faults with pagefault_disable().
> + *
> + * In preemptible task context this would be counterproductive as the page
> + * faults could not be fully resolved. As a consequence unresolved page
> + * faults in task context are fatal too.
> + */
> +
> +#ifdef RSEQ_BUILD_SLOW_PATH

But the function is only defined if RSEQ_BUILD_SLOW_PATH is defined.

> +/*
> + * The debug version is put out of line, but kept here so the code stays
> + * together.
> + *
> + * @csaddr has already been checked by the caller to be in user space
> + */
> +bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs,
> +			       unsigned long csaddr)
> +{
> +	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
> +	u64 start_ip, abort_ip, offset, cs_end, head, tasksize = TASK_SIZE;
> +	unsigned long ip = instruction_pointer(regs);
> +	u64 __user *uc_head = (u64 __user *) ucs;
> +	u32 usig, __user *uc_sig;
> +
> +	scoped_user_rw_access(ucs, efault) {
> +		/*
> +		 * Evaluate the user pile and exit if one of the conditions
> +		 * is not fulfilled.
> +		 */
> +		unsafe_get_user(start_ip, &ucs->start_ip, efault);
> +		if (unlikely(start_ip >= tasksize))
> +			goto die;
> +		/* If outside, just clear the critical section. */
> +		if (ip < start_ip)
> +			goto clear;
> +
> +		unsafe_get_user(offset, &ucs->post_commit_offset, efault);
> +		cs_end = start_ip + offset;
> +		/* Check for overflow and wraparound */
> +		if (unlikely(cs_end >= tasksize || cs_end < start_ip))
> +			goto die;
> +
> +		/* If not inside, clear it. */
> +		if (ip >= cs_end)
> +			goto clear;
> +
> +		unsafe_get_user(abort_ip, &ucs->abort_ip, efault);
> +		/* Ensure it's "valid" */
> +		if (unlikely(abort_ip >= tasksize || abort_ip < sizeof(*uc_sig)))
> +			goto die;
> +		/* Validate that the abort IP is not in the critical section */
> +		if (unlikely(abort_ip - start_ip < offset))
> +			goto die;
> +
> +		/*
> +		 * Check version and flags for 0. No point in emitting
> +		 * deprecated warnings before dying. That could be done in
> +		 * the slow path eventually, but *shrug*.
> +		 */
> +		unsafe_get_user(head, uc_head, efault);
> +		if (unlikely(head))
> +			goto die;
> +
> +		/* abort_ip - 4 is >= 0. See abort_ip check above */
> +		uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
> +		unsafe_get_user(usig, uc_sig, efault);
> +		if (unlikely(usig != t->rseq.sig))
> +			goto die;
> +
> +		/* rseq_event.user_irq is only valid if CONFIG_GENERIC_IRQ_ENTRY=y */
> +		if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
> +			/* If not in interrupt from user context, let it die */
> +			if (unlikely(!t->rseq.event.user_irq))
> +				goto die;
> +		}
> +		unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, efault);
> +		instruction_pointer_set(regs, (unsigned long)abort_ip);
> +		rseq_stat_inc(rseq_stats.fixup);
> +		break;
> +	clear:
> +		unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, efault);
> +		rseq_stat_inc(rseq_stats.clear);
> +		abort_ip = 0ULL;
> +	}
> +
> +	if (unlikely(abort_ip))
> +		rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
> +	return true;
> +die:
> +	t->rseq.event.fatal = true;
> +efault:
> +	return false;
> +}
> +

There's no:

#else

bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs,
			       unsigned long csaddr)
{
	return false;
}

> +#endif /* RSEQ_BUILD_SLOW_PATH */
> +
> +/*
> + * This only ensures that abort_ip is in the user address space and
> + * validates that it is preceded by the signature.
> + *
> + * No other sanity checks are done here, that's what the debug code is for.
> + */
> +static rseq_inline bool
> +rseq_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr)
> +{
> +	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
> +	unsigned long ip = instruction_pointer(regs);
> +	u64 start_ip, abort_ip, offset;
> +	u32 usig, __user *uc_sig;
> +
> +	rseq_stat_inc(rseq_stats.cs);
> +
> +	if (unlikely(csaddr >= TASK_SIZE)) {
> +		t->rseq.event.fatal = true;
> +		return false;
> +	}
> +
> +	if (static_branch_unlikely(&rseq_debug_enabled))
> +		return rseq_debug_update_user_cs(t, regs, csaddr);

Wouldn't the above reference to rseq_debug_update_user_cs() fail to build
if RSEQ_BUILD_SLOW_PATH is not defined?

Or am I missing something?

I see that it looks like RSEQ_BUILD_SLOW_PATH is always defined, but why
have this logic if it can't be not defined?

-- Steve

> +
> +	scoped_user_rw_access(ucs, efault) {
> +		unsafe_get_user(start_ip, &ucs->start_ip, efault);
> +		unsafe_get_user(offset, &ucs->post_commit_offset, efault);
> +		unsafe_get_user(abort_ip, &ucs->abort_ip, efault);
> +
> +		/*
> +		 * No sanity checks. If user space screwed it up, it can
> +		 * keep the pieces. That's what debug code is for.
> +		 *
> +		 * If outside, just clear the critical section.
> +		 */
> +		if (ip - start_ip >= offset)
> +			goto clear;
> +
> +		/*
> +		 * Two requirements for @abort_ip:
> +		 *   - Must be in user space as x86 IRET would happily return to
> +		 *     the kernel.
> +		 *   - The four bytes preceding the instruction at @abort_ip must
> +		 *     contain the signature.
> +		 *
> +		 * The latter protects against the following attack vector:
> +		 *
> +		 * An attacker with limited abilities to write, creates a critical
> +		 * section descriptor, sets the abort IP to a library function or
> +		 * some other ROP gadget and stores the address of the descriptor
> +		 * in TLS::rseq::rseq_cs. An RSEQ abort would then evade ROP
> +		 * protection.
> +		 */
> +		if (abort_ip >= TASK_SIZE || abort_ip < sizeof(*uc_sig))
> +			goto die;
> +
> +		/* The address is guaranteed to be >= 0 and < TASK_SIZE */
> +		uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
> +		unsafe_get_user(usig, uc_sig, efault);
> +		if (unlikely(usig != t->rseq.sig))
> +			goto die;
> +
> +		/* Invalidate the critical section */
> +		unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, efault);
> +		/* Update the instruction pointer */
> +		instruction_pointer_set(regs, (unsigned long)abort_ip);
> +		rseq_stat_inc(rseq_stats.fixup);
> +		break;
> +	clear:
> +		unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, efault);
> +		rseq_stat_inc(rseq_stats.clear);
> +		abort_ip = 0ULL;
> +	}
> +
> +	if (unlikely(abort_ip))
> +		rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
> +	return true;
> +die:
> +	t->rseq.event.fatal = true;
> +efault:
> +	return false;
> +}


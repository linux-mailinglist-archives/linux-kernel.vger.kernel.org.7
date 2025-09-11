Return-Path: <linux-kernel+bounces-812550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A15B53993
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57BBAA1566
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34E32C312;
	Thu, 11 Sep 2025 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zkjQ+igX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUAxik4t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E511DD525
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609256; cv=none; b=MGthANE+VViccTbs/QZg265ZkR/Y5mF9YRm9xzmmO+Kh7VlxzWpYYBPyOWZokka2L4Jr7bL2Ag8zhCV6GEV0bqG0uJnx48kP5xF5GSU0DFmMeOWAD4+W8HATU86Ml7wajmF0645zsVdEkmaltwVTj21ForTM9I7/OrpVr038pdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609256; c=relaxed/simple;
	bh=5gddVgaX3DvwJqmF8F/Mb6/AzXWmPwiqBh6Td1u1+T0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JA/B/hO5uTh1jMNGdxh35zdamjW02XKSsQ4wmiRFx4hAENCzUO0BMJSQH9+pIrXc6htkJGU1WNf+TRIhn3XmbeisfBvwsB4bjgFVChACmxSzpxZB6yi6dKTyzb6ogHfP1xtQBF0VzFc2VI1Z06YQtleR1uq1QZ+hS4GfAt4slrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zkjQ+igX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MUAxik4t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757609253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=raBHxfmcscu09lNUTpsPOSmO5iYHVMUPKLEm6x9Ej4Q=;
	b=zkjQ+igXg4C0A9y9R2Ces3BTMOjpaUD99x2RITo+WxLzmWOHm8FOLdfc8/fMhDOZgKoixf
	tenIj5NI3G7imMsDLEjhOU52v2tEYh2K/uiE60rkaeKO3Fxr940qCLDCTxT4rnzrRlSPgZ
	a3E6g+d7R2NWETuQwgWjp56TLQUrEbGrn+2cf1syhHIeMt7c1Od0nVDEZbQnsYypuiETLy
	2BeqES0I2pHLaxQEZ3rkSWTE9g2xGao9DruXpJBYsXKsyOE/eeFHhYLCKF5p0fRR8HzNFF
	0/kdcTfNNJmBUIVzVFV41UsoirRBgjePWkUsp9Dp5umj0xs+bFOxVRJQy36UuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757609253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=raBHxfmcscu09lNUTpsPOSmO5iYHVMUPKLEm6x9Ej4Q=;
	b=MUAxik4tcrqvRwrMvAAz7alRsAVzsNraI6qUs621l9g61NAUHGPJwhzUky/vjff84ceUc9
	aeW21b8t/sMeN9Dg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V4 28/36] rseq: Switch to fast path processing on exit
 to user
In-Reply-To: <84d9beb2-85e7-4fc0-b403-0514bd87ae8b@efficios.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212927.058801648@linutronix.de>
 <84d9beb2-85e7-4fc0-b403-0514bd87ae8b@efficios.com>
Date: Thu, 11 Sep 2025 18:47:32 +0200
Message-ID: <87v7lpq6l7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 11 2025 at 10:44, Mathieu Desnoyers wrote:
> On 2025-09-08 17:32, Thomas Gleixner wrote:
>>   void __rseq_signal_deliver(int sig, struct pt_regs *regs);
>> @@ -142,11 +148,16 @@ static inline void rseq_fork(struct task
>>   	} else {
>>   		t->rseq = current->rseq;
>>   		t->rseq.ids.cpu_cid = ~0ULL;
>
> As discussed earlier, do we really want to clear cpu_cid here, or
> copy from parent ? If we keep the parent's cached values, I suspect

Suspicion is not really a good engineering principle.

> we can skip the page fault on return from fork in many cases.

I doubt that it's many cases, see below.

>> +		/*
>> +		 * If it has rseq, force it into the slow path right away
>> +		 * because it is guaranteed to fault.
>> +		 */
>> +		t->rseq.event.slowpath = t->rseq.event.has_rseq;
>
> I think we can do better here. It's only guaranteed to fault if:
>
> - has_rseq is set, AND
>    - cpu or cid has changed compared to the cached value OR
>    - rseq_cs user pointer is non-NULL.
>
> Otherwise we should be able to handle the return from fork from the fast
> path just with loads from the rseq area, or am I missing something ?

The normal case is that the fault is pretty much guaranteed to happen
because the scheduler places the child on a different CPU and therefore
the CPU/MM IDs need to be updated anyway.

The only cases where this is not true, are when there is no capacity to
do so or on UP or the parent was affine to a single CPU, which is what
the child inherits.

Now for those cases the only time, where such an optimization would be
meaningful is when the child is so short lived, that it does not
schedule.  Otherwise you just procrastinate the fault to a later point
in time.

The point is that it will fault in the vast majority of cases and then
the fault will happen in the fast path first, which means the exit code
has to go another round through the work loop instead of forcing the
fault right away on the first exit in the slowpath, where it can be
actually resolved.

> Thanks,
>
> Mathieu

Your method of ending a mail with a greeting and then continuing to
reply downwards is pretty annoying. I almost missed the below if I
wouldn't have tried to trim the reply.

>>   	}
>>   }
>>   
>>   #else /* CONFIG_RSEQ */
>> -static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
>> +static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
>>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
>>   static inline void rseq_sched_switch_event(struct task_struct *t) { }
>>   static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1911,7 +1911,7 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
>>   config DEBUG_RSEQ
>>   	default n
>>   	bool "Enable debugging of rseq() system call" if EXPERT
>> -	depends on RSEQ && DEBUG_KERNEL
>> +	depends on RSEQ && DEBUG_KERNEL && !GENERIC_ENTRY
>
> I'm confused about this hunk. Perhaps this belongs to a different
> commit ?

This is attached to wiring up the fast path in GENERIC_ENTRY, because
the fastpath, which does debug when enabled through the static key, is
at the end of the exit to user work loop and therefore the extra round
through the detached debug muck can be avoided.

While on !GENERIC_ENTRY architectures the processing happens always in
the TIF_NOTIFY_RESUME slowpath, so the extra debug muck is required, no?

> Mathieu

<TRIM pointless leftovers>

      Can you please trim your replies?

</>

Thanks,

        tglx


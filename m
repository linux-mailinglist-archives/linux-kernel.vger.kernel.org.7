Return-Path: <linux-kernel+bounces-783022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034EAB3288C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3412AC378B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E28D245014;
	Sat, 23 Aug 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cQssaDns";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SD5/Aya"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED623D7E5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755952306; cv=none; b=AiyQJOBZ+caVLbZkXyHn5XbC7vHqbxVcOddMtOnH/0VLdcets6HoDCtaIoi8qEsVBm0ecduigX28zssecDCXHjH3JwJKBzIBmbadE/Qh2WplAa+yWNZaAy/drKSLqH76h9YE/K/OG2d/A/cWlUkibBETG6yyNzYCxV9eLXkSphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755952306; c=relaxed/simple;
	bh=u9pYVAZQLy619ukhz3EMKz8q7O3/4KJWfuSj04WHBEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BUGCtPDMiBgzhdWHegxY+IPu2Bb58IFY90ENhJao+KWNjgtHGR6v9I0E2t+LVzmoGF2BHrbQyf0MzhCY4HJPPS89b6SjZk6aytUGjj9C3gsxeJUrWLXrxDufWhvhkg/EL9MS2SSlwRzmeh9ats3w0pUT+RmpVDMl7TRVTe58Mr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cQssaDns; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SD5/Aya; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755952297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUPLZTbyEN/y9FmCUBslUeyTjbXq5tWUjfyOTTNHAsA=;
	b=cQssaDns+aj4EOZd/GnasxSzjpI03qDNENtaHcNHdzAX3PlieV0R89wrEeXH4f432RHRca
	jGRQgXspXwq5924+ZXJhWRiEtU3GU/umF6Q5ULgMcWjwOvnfvH4r1syGrkEmonVs0KWrjI
	71VDhUuT7m7gKzSTRm9V0s4qrtbtCt6OUmL7UsaW6ZWu+c7IFLqIS/5HgtLpbWYq30nb6e
	n/8MFZ4fqa216bki6IMwEzZgB3+iC+jixyU8m2iCqrE9MolIUcU/WKy8eimQxmekwIDVnU
	GuUp9975WhblrVwJdwsWsHV9rTWkrGKLDIxLR2cSmHgbiO6hIevkZDe4LzpfKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755952297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUPLZTbyEN/y9FmCUBslUeyTjbXq5tWUjfyOTTNHAsA=;
	b=1SD5/Aya7HEE7kBZHcjq7BUGncz84A84sx9WFKfw9++P5Bqp3luO16vBA+Y3pPmDyG3X+y
	5ONduc5fx45/Q/Cw==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] rseq: Protect event mask against membarrier IPI
In-Reply-To: <a2f916f1-0693-41aa-be72-465d84da5123@efficios.com>
References: <87o6sj6z95.ffs@tglx>
 <a2f916f1-0693-41aa-be72-465d84da5123@efficios.com>
Date: Sat, 23 Aug 2025 14:31:35 +0200
Message-ID: <87tt1yw76g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 20 2025 at 09:23, Mathieu Desnoyers wrote:
> On 2025-08-13 11:02, Thomas Gleixner wrote:
> We should also update this comment in include/linux/sched.h:
>
>          /*
>           * RmW on rseq_event_mask must be performed atomically
>           * with respect to preemption.
>           */
>          unsigned long rseq_event_mask;
>
> to e.g.:
>
> /*
>   * RmW on rseq_event_mask must be performed atomically
>   * with respect to preemption and membarrier IPIs.
>   */

True.

>> +
>>   /*
>>    * Map the event mask on the user-space ABI enum rseq_cs_flags
>>    * for direct mask checks.
>> @@ -41,9 +47,8 @@ static inline void rseq_handle_notify_re
>>   static inline void rseq_signal_deliver(struct ksignal *ksig,
>>   				       struct pt_regs *regs)
>>   {
>> -	preempt_disable();
>> -	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
>> -	preempt_enable();
>> +	scoped_guard(RSEQ_EVENT_GUARD)
>> +		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
>
> Then we have more to worry about interaction of the following
> rseq events with membarrier IPI:
>
> - rseq_preempt, rseq_migrate, rseq_signal_deliver.
>
> Both rseq_preempt and rseq_migrate are documented as only being required
> to be called with preempt off, not irq off.

They are always invoked from the middle of the scheduler with interrupts
disabled, so just the documentation is wrong.

> Can we just move the event sources requiring preempt-off to their own
> word, and use a separate word for membarrier IPI instead ? This would
> allow us to partition the problem into two distinct states each
> protected by their respective mechanism.

signal delivery can just use set_bit() which is atomic vs. the IPI no?

But as I pointed out in the other series, we don't need that whole zoo
of event bits at all. There is absolutely no point.

signal delivery does not need to set an event in the first place. It can
just unconditionally invoke this stuff, no?

Thanks,

        tglx




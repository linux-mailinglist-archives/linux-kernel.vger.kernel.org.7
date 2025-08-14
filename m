Return-Path: <linux-kernel+bounces-768893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E2AB26731
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249D01CC42CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0C03009E6;
	Thu, 14 Aug 2025 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dwkmqEeu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dC/GQYvH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210292FE07B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177890; cv=none; b=HkgRNIUUN+FwuA/ia3KZIAt0F5OXuyBZOFw18SSVx3SUCtKy97n/dynpX+Vjeoy+xHyxZVbBYbOQ9rNhzpbYhymYRttc0lYFB1Ht4QBA502Ofgv6uypcJjOrz9HJN7DvmS06UZzBr9OYSZ4ePYPXH5NUrM3xeaxniD2KmcUuC20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177890; c=relaxed/simple;
	bh=P9A9uYDpB5v7dcNyjAnX+vyoi4yhEaRpvaOKne6e/Tk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gnpHGGPSbu8aqbtvVRNI3A84FoWCCr6vkCCCryIiqbCJYsXcTe9voQpLaB3rXBgRy+evXlKrGmALTYjvwBzEwvg44UhP3VMpBIG8Fb3cgXKH7a/08B0luMrlJMurikWWf+FIyqVjPnPcJznzEGOgEN0GdY9KnpilBHH/WiiYeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dwkmqEeu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dC/GQYvH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755177883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npD+lzjG4bTzN9c7tET1zW6okR7Ccty4vJT2zShelPE=;
	b=dwkmqEeunRQna5yQHtdYZnaXo69rs/VZwcCYcCDHVLjIrjYAUHt/3vD2mikgwHVoU8VV+A
	qJ4dCIawfeHuaUmmQj+0NDioHOv6SUshP+KgEwWojzF9P5pGE7pM45m8rK2IyuyTWVxDkr
	ztyIURdlSLLdR5tQyclByAyelblGFkuvWFgTvIlZZi1UE15ohAalwyGTl6M9oro2TgTUnK
	G3ZZmBIAMUQhXAsobwkb1c5e9IUj2eHVmMeBXTl0XwEqeRQs2cVr8bpz62wUznSxEW0vWP
	vofVLtKIeRrilbAnv4bkj5kFGesFOumBv+Jy6quzYqfU9qkoA/r1tmUZhR0BQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755177883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npD+lzjG4bTzN9c7tET1zW6okR7Ccty4vJT2zShelPE=;
	b=dC/GQYvHR4A6IafVw88aMy/AY2Z/jl4LdppqpAtHmpUldUqmHrA/LkB2dn6+QF9tTV+Bej
	kGSJqMsIwxl7xVBQ==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, Jens
 Axboe <axboe@kernel.dk>
Subject: Re: [patch 10/11] rseq: Skip fixup when returning from a syscall
In-Reply-To: <20250814085426.GS4067720@noisy.programming.kicks-ass.net>
References: <20250813155941.014821755@linutronix.de>
 <20250813162824.420583910@linutronix.de>
 <20250814085426.GS4067720@noisy.programming.kicks-ass.net>
Date: Thu, 14 Aug 2025 15:24:41 +0200
Message-ID: <874iua6nom.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 14 2025 at 10:54, Peter Zijlstra wrote:
> On Wed, Aug 13, 2025 at 06:29:37PM +0200, Thomas Gleixner wrote:
>
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -408,6 +408,22 @@ static int rseq_ip_fixup(struct pt_regs
>>  	return 0;
>>  }
>>  
>> +static inline bool rseq_ignore_event(bool from_irq, bool ksig)
>> +{
>> +	/*
>> +	 * On architectures which do not select_GENERIC_ENTRY
>> +	 * @from_irq is not usable.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || !IS_ENABLED(CONFIG_GENERIC_ENTRY))
>> +		return false;
>> +
>> +	/*
>> +	 * Avoid the heavy lifting when this is a return from syscall,
>> +	 * i.e. not from interrupt and not from signal delivery.
>> +	 */
>> +	return !from_irq && !ksig;
>> +}
>> +
>>  /*
>>   * This resume handler must always be executed between any of:
>>   * - preemption,
>
>> @@ -467,6 +484,9 @@ void __rseq_handle_notify_resume(struct
>>  			t->rseq_event_pending = false;
>>  		}
>>  
>> +		if (rseq_ignore_event(from_irq, !!ksig))
>> +			event = false;
>> +
>>  		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
>>  			ret = rseq_ip_fixup(regs, event);
>>  			if (unlikely(ret < 0))
>> 
>
> You now have a double check for CONFIG_DEBUG_RSEQ.
>
> Since the value of @event is immaterial when DEBUG_RSEQ, might as well
> remove it from rseq_ignore_event(), right?

Not really. debug wants the event preserved even if it's !from_irq

Yes, it's not pretty, but I wanted to preserve the debug behaviour as
much as it goes.


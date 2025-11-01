Return-Path: <linux-kernel+bounces-881593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B500C28844
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 23:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A293AF900
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 22:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F7A29992A;
	Sat,  1 Nov 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BUR/Tn3k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qjaNNTID"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3392566
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762037953; cv=none; b=Hgbk9p8s+5bo3IQVAxYsvwSn1WlA1ofPBEHNcnYdvK93y02LYW7scp8pJeN4ii7ACFFtl7+jOYnqOfyUMzVfealjkMbdKLE+9EGcB1csPPhX4Mh9zEwOYeV304mjugLpM49MwxXn7/LE4n4yDXdUqao68rekSM66FqTsdL2hcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762037953; c=relaxed/simple;
	bh=Tf2DS2Gr5T/fYs+ignvAhfeUXfWXoYmReVXxz4l8TMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UnrYCoxXmaagrJWjCVgBUXO9CmmrJ1j2609opYmmYumoI+lX6gSnTfjYOIohxfG2TrUlgcs/mNGyFG+1uYRQd0g69koljkEADG9dmYPc7Nk5+JiPaYP+kI8hLU4YYUN+6++HUwmM/LuJNqkex4GrIgpmA7dGB3X0z47gB+gAv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BUR/Tn3k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qjaNNTID; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762037950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlQVfxesiPBr5LLf09SJrMEOQz7ygOrMc1zMq2EC5Yo=;
	b=BUR/Tn3kw747LUKJ8UIr108Iqqqw1f8lvwnWzcGZUFCgXHzN0/fl3nDWkzLQrpXuX+KI2R
	yc8glqY6x/hpS6ER252UHkpO1O7ivUarVzrywo0VoGcHt8jg4451nrH9+1t+ozOMrHjIWT
	bAtmIVeVdVm8y6fC57VaUWBYnMMExsWMI00DoykDDGhgYK6j46pEeyr2Yq5I6P7mQfaldK
	ClrsSm8Swj6WofH6S5ohZhTY+1/c+pLj34rwaDI4agW8JblDOl+KfpWfcUdAfL+IB12Qo8
	tIWyE3LG+mN6omdCbZLQASOHY2u0RjOYUL3JnM5djPwc9rT0ohCENB+r8U6P5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762037950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlQVfxesiPBr5LLf09SJrMEOQz7ygOrMc1zMq2EC5Yo=;
	b=qjaNNTIDKDO6Jy5KTGjg5QkPoQx6eF0eQlUAnVYuqS/78sKGTBE3eMgBBCiJrXsyZ7OWlr
	Nt9jfwJq2sDjjuCQ==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, Jens Axboe
 <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim
 Chen <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>, Shrikanth
 Hegde <sshegde@linux.ibm.com>
Subject: Re: [patch V3 09/20] cpumask: Cache num_possible_cpus()
In-Reply-To: <87sef1tnui.ffs@tglx>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.846126176@linutronix.de>
 <938a1d18-c7b0-45d6-ac4b-4c1246e08044@efficios.com> <87sef1tnui.ffs@tglx>
Date: Sat, 01 Nov 2025 23:59:09 +0100
Message-ID: <87wm49we9u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 22:11, Thomas Gleixner wrote:

> On Wed, Oct 29 2025 at 11:54, Mathieu Desnoyers wrote:
>> On 2025-10-29 09:09, Thomas Gleixner wrote:
>> [...]
>>>   
>>> +void set_cpu_possible(unsigned int cpu, bool possible)
>>
>> Unless I'm missing something, I suspect that "set_cpu_possible()" should
>> be marked as __init.
>
> Good point!

And only wishful thinking as set_cpu_possible() is wrongly used in code
which is not marked __init all over the architecture zoo. Cleaning that
up is yet another massive patch series dealing with mostly unmaintained
code. A nice task for people who want to get started with kernel
development. :)

On anything contemporary invoking set_cpu_possible() after init is going
to crash and burn because the related cpumask and variables are marked
RO at that point.

I've just addded a comment to that effect above the function to prevent
people from trying casually.

Thanks,

        tglx


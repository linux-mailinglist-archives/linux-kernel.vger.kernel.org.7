Return-Path: <linux-kernel+bounces-759179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59674B1D9A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1801B5606BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005A9263F34;
	Thu,  7 Aug 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QbDAS5Db";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w6xs1OAm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7B2620C3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575656; cv=none; b=hlnRxkN/RrkQuIlQ5Iwiv0mhfgmuDfyDVxLAzGH0uzyJNEKojvCzv4IhXP1IvXbI8Tn82wE1dqmOFByhfCzukmIH3yoJwCvJKteKWJB/I7SL0wUNA5Hr/5c+cRkm/tYFeK9aY7sdgH4JbC908BLVC60lie7A+DYKm+6bMNnnznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575656; c=relaxed/simple;
	bh=mTm+gwIgvkpiRwQPC3B8VPg0Z7Cs2YVbvxb/F0MgYuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AZnvT3M0ceMOueBShLQW4dHFbb6O9xvfA4z8zgupu6iwFbg/7YG6tiDpcFPW9mxxLu+4k+FFq1dG6Q8388HTx/Lpdt1/XzhGEP5w1JRFcEnf1LMoncrkM3AJahi5mApe41mTHEi8DOK9Cvcvruic4c9GeXl9FvGsotIL9R16oNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QbDAS5Db; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w6xs1OAm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754575652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nGHZ1UOkZls6Db24gK9k+FLfZav4jhSqk3ERVQACu+U=;
	b=QbDAS5DbjQ4bmjZl1BMzu0Ict02XcYx8WKRFi6T9Z2qaOPdymQrNjupe6FMWhY8sfEmssS
	Mu2DS0qDPyqDiVxRrEiAVhgT6n7lgq5OPDZEA7E/lVecg17zYinoXxxq4jlHFh8es+vgMw
	02B7YUvLwBOG9jb38cWFvQM9lKSlvElgedNM5ld+myQx9AZIBG2Q99qaeDZ55XaLTQ0TwO
	enhPC1zbosMpmPIyggrOS12LizQuY60GrRKYRuRJkAicLiXH+uM4z4Mvs6QyYWu5ReG4xt
	dOBEnuevamN0HTPWXSwo6VAQd7UbRrgysmPf/gOQoeMUAd9XDYNKWl6F/WuLSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754575652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nGHZ1UOkZls6Db24gK9k+FLfZav4jhSqk3ERVQACu+U=;
	b=w6xs1OAmdZPXJNbdCoqYwlWSvCl57L1tptg3hQLYLgvCB1M490M+KGFtRdYY/t2aIhC6aU
	fCZechSKJ5blQrDQ==
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, bigeasy@linutronix.de,
 kprateek.nayak@amd.com, vineethr@linux.ibm.com,
 prakash.sangappa@oracle.com
Subject: Re: [PATCH V7 01/11] sched: Scheduler time slice extension
In-Reply-To: <87ms8cchqf.ffs@tglx>
References: <87ms8cchqf.ffs@tglx>
Date: Thu, 07 Aug 2025 16:07:31 +0200
Message-ID: <874iujcjj0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 06 2025 at 22:34, Thomas Gleixner wrote:
> On Thu, Jul 24 2025 at 16:16, Prakash Sangappa wrote:
>> @@ -396,6 +399,9 @@ static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
>>  
>>  	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
>>  
>> +	/* Reschedule if scheduler time delay was granted */
>
> This is not rescheduling. It sets NEED_RESCHED, which is a completely
> different thing.
>
>> +	rseq_delay_set_need_resched();
>
> I fundamentally hate this hack as it goes out to user space with
> NEED_RESCHED set and absolutely zero debug mechanism which validates
> it. Currently going out with NEED_RESCHED set is a plain bug, rigthfully
> so.
>
> But now this muck comes along and sets the flag, which is semantically
> just wrong and ill defined.
>
> The point is that NEED_RESCHED has been cleared by requesting and
> granting the extension, which means the task can go out to userspace,
> until it either relinquishes the CPU or hrtick() whacks it over the
> head.

Sorry. I misread this. It's placed before it enters the exit work loop
and not afterwards. I got lost in this maze. :(

> The obvious way to solve both issues is to clear NEED_RESCHED when
> the delay is granted and then do in syscall_enter_from_user_mode_work()
>
>         rseq_delay_sys_enter()
>         {
>              if (unlikely(current->rseq_delay_resched == GRANTED)) {
> 		    set_tsk_need_resched(current);
>                     schedule();
>              }       
>         }     	
>
> No?
>
> It's debatable whether the schedule() there is necessary. Removing it
> would allow the task to either complete the syscall and reschedule on
> exit to user space or go to sleep in the syscall. But that's a trivial
> detail.

But, the most important thing is that doing it at entry allows to debug
this stuff for correctness.

I can kinda see that a sched_yield() shortcut might be the right thing
to do for relinguishing the CPU, but if that's the user space contract,
then any other syscall needs to be caught and not silently papered over
at return from syscall.

Let me think about this some more.





Return-Path: <linux-kernel+bounces-760069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3920B1E61E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13740584318
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E16273D88;
	Fri,  8 Aug 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zkbMBcUA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bHp69Efb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73507272E70
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647173; cv=none; b=nza04RoylBmKchQzaedV8Zk0ImgF+DYaDjpJ6iAaXZI3/2DD2buoFqoYq8vG6pGl1dYXeZqg24XbyJXh+s24CxhLVbd+iT+nLLjav4JQqdrbn6x+FPCEoZRPyI9wFUDxlVTMLKAyS8y0JgjoBcttQ1bpGPEa158N462sk2etrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647173; c=relaxed/simple;
	bh=ZlGNUWscmNgAVHs4Pule3kWBj1D1AEtJq7nx5Kbm2/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4fuYbERrYEFXB/Gl6BDq8QsmOi7p7stsZr2n/q8hLAcUsZYJnctv5AFkMOvbIySFNd49IO6Y2Dh6QFsjudMu+X7aX28xcn9HSJ4YbEmYr6Ps6sIPiSNu0tzEZcRH9JeMapXQZWQZVpuaY2TRnRX/OQXwm89r5mtuiAFluBUi/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zkbMBcUA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bHp69Efb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Aug 2025 11:59:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754647168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McgP06yZKE6UPa1j2RwQxZ2e83lX6Pw7FWo9EIDtH+s=;
	b=zkbMBcUApvTMjv31oZoMc1M64CR/0AyvI/WXxG+C3pTD0WsN26+my9+XRO+gOZkA5TzhhR
	WGJjasUu5mClRWKizwuS8qB6AzHUnSpPJxZ+eepLVHmx/i+6ojs2Jed0d1U81KDbOB6kWM
	7u4LhZomWavAwj5IfsTzwO1XHmSqLSmhy6epzM+9RkhKnjcrt46qwn2ide1ImnRCg0gfx2
	SMoXzm0QG8xxZ/eyoiIbUfvJCTlc9kTq6N73B62Wlg75EVJlqbeCvK1/RV3Zd2Uh/0HD7w
	O8zE57srGcZMkXzNLL8sr8aUk84E9/eplUM7vkTKlvMZnQJCLz/aGAfk+N9tfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754647168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McgP06yZKE6UPa1j2RwQxZ2e83lX6Pw7FWo9EIDtH+s=;
	b=bHp69Efb0heO7kPBrT26cfrrFmiyIQp4TIh4BQQMtUbaxoXH/dWI3+299Z3Y50sM2mrPHz
	X1pU0T5tIBt487Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"vineethr@linux.ibm.com" <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 01/11] sched: Scheduler time slice extension
Message-ID: <20250808095927.cS9gMdhp@linutronix.de>
References: <20250724161625.2360309-2-prakash.sangappa@oracle.com>
 <87ms8cchqf.ffs@tglx>
 <20250807154929.4Wpr6V4N@linutronix.de>
 <BCFBCCEA-8D24-4835-8C28-74D93F5EF38B@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BCFBCCEA-8D24-4835-8C28-74D93F5EF38B@oracle.com>

On 2025-08-07 16:56:33 [+0000], Prakash Sangappa wrote:
> >>> + if (__rseq_delay_resched()) {
> >>> + clear_tsk_need_resched(current);
> >> 
> >> Why has this to be inline and is not done in __rseq_delay_resched()?
> > 
> > A SCHED_OTHER wake up sets _TIF_NEED_RESCHED_LAZY so
> > clear_tsk_need_resched() will revoke this granting an extension.
> > 
> > The RT/DL wake up will set _TIF_NEED_RESCHED and
> > clear_tsk_need_resched() will also clear it. However this one
> > additionally sets set_preempt_need_resched() so the next preempt
> > disable/ enable combo will lead to a scheduling event. A remote wakeup
> > will trigger an IPI (scheduler_ipi()) which also does
> > set_preempt_need_resched().
> > 
> > If I understand this correct then a RT/DL wake up while the task is in
> > kernel-mode should lead to a scheduling event assuming we pass a
> > spinlock_t (ignoring the irq argument).
> > Should the task be in user-mode then we return to user mode with the TIF
> > flag cleared and the NEED-RESCHED flag folded into the preemption
> > counter.
> > 
> > I am once again asking to limit this to _TIF_NEED_RESCHED_LAZY.
> 
> Would the proposal(patches 7-11) to have an API/Mechanism, as Thomas suggested,
> for RT threads to indicate not to be delayed address the concern?.  
> Also there is the proposal to have a kernel parameter to disable delaying 
> RT threads in general, when granting extra time to the running task.

While I appreciate the effort I don't see the need for this
functionality atm. I would say just get the basic infrastructure
focusing on LAZY preempt and ignore the wakes for tasks with elevated
priority. If this works reliably and people indeed ask for delayed
wakes for RT threads then this can be added assuming you have enough
flexibility in the API to allow it. Then you would also have a use-case
on how to implement it.

Looking at 07/11, you set a task_sched::sched_nodelay if this is
requested. In 09/11 you set TIF_NEED_RESCHED_NODELAY if that flag is
set. In 08/11 you use that flag additionally for wake ups and propagate
it for the architecture. Puh.
If a task needs to set this flag first in order to be excluded from the
delayed wake ups then I don't see how this can work for kernel threads
such as the threaded interrupts or a user thread which is PI-boosted and
inherits the RT priority.

On the other hand lets assume you check and clear only
TIF_NEED_RESCHED_LAZY. Lets say people ask to extend the delayed wakes
to certain userland RT threads. Then you could add a prctl() to turn
TIF_NEED_RESCHED into TIF_NEED_RESCHED_LAZY for the "marked" threads.
Saying I don't mind if this particular thread gets delayed.
If this is needed for all threads in system you could do a system wide
sysctl and so on.
You would get all this without another TIF bit and tracing would keep
showing reliably a N or L flag.

> Thanks,
> -Prakash
> 
Sebastian


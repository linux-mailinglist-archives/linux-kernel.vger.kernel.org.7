Return-Path: <linux-kernel+bounces-828549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65117B94DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B9619033DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB883168EA;
	Tue, 23 Sep 2025 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sfzk3iOs"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AA2EDD5D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613973; cv=none; b=NmVTBlN8MkjA7neezEqAYbk260gWQ1CB+ko4txQAuIztPxIuuj+oGHNfOUw3ivjokFAJBrS/OXrMn9uZCLBKr+cIXQ+UnTgOIRv2esBtTw3tSLbQWT+/o7r2O7Hs4kC6+Gp7ETju/xMZEuaYbFfuGN0GjiTevo4cBqgToX05aRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613973; c=relaxed/simple;
	bh=QZF4SbfDPraY3a0t+sUh+3cyG7V6Za1PWzyHrOwBB0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug8rgqAd+rF7f/281r5fRmckBoO6ZB5xF/cZg0dsPVQiH5nzvb0rheAlbSxifFhl3YlbBhyHD/ySrkCkjgSPMjNryih6O9Y2yDmQURNsdJ1PeldLb8O1LalJxUbH3aHOEcJYqp3JnFE8gwRKwwZxZS0jumGa4CVY6l+jlr2N+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sfzk3iOs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ry/70i496GYQd/L/jZNjZCWQ14QoDhhBilMzwzUUfTI=; b=Sfzk3iOskM8hOjTT5gz0WGwuRV
	1+oHZrODxMNBCWYIQH3BhprNKiCjOC7TieFKx/4ddhfOawT7nh0K2i4JWa053FIA9Qcsthni4XvtJ
	4S7j5B11qh/3TPdYkRtCgOLL0LWtRbM4Ff93zQMeWgSFmFLPkJ487dqtjyHlF39f/18sKJC/pTZwP
	SAnVbgiYViY5iIehHTa5Wx4R4VYaZqkj2KuBIuR+8xg1LFdVOVif9ypeLSAOvvBZtu5CBpSd0vi+f
	TGSThGB5LmDmOwmgrWFguv54ZPcYttKfp2xFHCDmaHmMuBevZ/ImgL73BR7ld87BmxU+9pJ3ua/S2
	+3J6Zh7Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0xpJ-000000077Na-0PE9;
	Tue, 23 Sep 2025 07:52:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0FDBE303005; Tue, 23 Sep 2025 09:52:40 +0200 (CEST)
Date: Tue, 23 Sep 2025 09:52:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: arnd@arndb.de, anna-maria@linutronix.de, frederic@kernel.org,
	luto@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	oliver.sang@intel.com
Subject: Re: [RFC][PATCH 7/8] entry,hrtimer: Push reprogramming timers into
 the interrupt return path
Message-ID: <20250923075240.GT3245006@noisy.programming.kicks-ass.net>
References: <20250918075219.091828500@infradead.org>
 <20250918080206.180399724@infradead.org>
 <875xdd8oag.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xdd8oag.ffs@tglx>

On Sat, Sep 20, 2025 at 11:29:43AM +0200, Thomas Gleixner wrote:
> On Thu, Sep 18 2025 at 09:52, Peter Zijlstra wrote:
> > Currently hrtimer_interrupt() runs expired timers, which can re-arm
> > themselves, after which it computes the next expiration time and
> > re-programs the hardware.
> >
> > However, things like HRTICK, a highres timer driving preemption,
> > cannot re-arm itself at the point of running, since the next task has
> > not been determined yet. The schedule() in the interrupt return path
> > will switch to the next task, which then causes a new hrtimer to be
> > programmed.
> >
> > This then results in reprogramming the hardware at least twice, once
> > after running the timers, and once upon selecting the new task.
> >
> > Notably, *both* events happen in the interrupt.
> >
> > By pushing the hrtimer reprogram all the way into the interrupt return
> > path, it runs after schedule() and this double reprogram can be
> > avoided.
> >
> > XXX: 0-day is unhappy with this patch -- it is reporting lockups that
> > very much look like a timer goes missing. Am unable to reproduce.
> > Notable: the lockup goes away when the workloads are ran without perf
> > monitors.
> 
> After staring at it for a while, I have two observations.
> 
> 1) In the 0-day report the lockup detector triggers on a spinlock
>    contention in futex_wait_setup()
> 
>    I'm not really seeing how that's related to a missing timer.
> 
>    Without knowing what the other CPUs are doing and what holds the
>    lock, it's pretty much impossible to tell what the hell is going on.
> 
>    So that might need a back trace triggered on all CPUs and perhaps
>    some debug output in the backtrace about the hrtimer state.
> 
>    On the CPU where the lockup is detected, the timer is working.

Fair enough; I was thinking it got stuck on a missing timeout, but
indeed, that needs verifying.

> 2) I came up with the following scenario, which is broken with this
>    delayed rearm.
> 
>    Assume this happens on the timekeeping CPU.
> 
>       hrtimer_interrupt()
>         expire_timers();
>         set(TIF_REARM);
> 
>       exit_to_user_mode_prepare()
>         handle_tif_muck()
>           ...
>           to = jiffies + 2;
>           while (!cond() && time_before(jiffies, to))
>           	relax();
> 
>      If cond() does not become true for whatever reason, then this won't
>      make progress ever because the tick hrtimer which increments
>      jiffies is not happening.
> 
>      It can also be a wait on a remote CPU preventing progress
>      indirectly or a subtle dependency on a timer (timer list or
>      hrtimer) to expire.
> 
>   I have no idea whether that's related to the reported 0-day fallout,
>   but it definitely is a real problem lurking in the dark.

Argh... that exit_to_user_mode_loop() thing enables IRQs. Yes, buggered
something mighty.

Let me haz a poke.


Return-Path: <linux-kernel+bounces-783545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95CB32EDA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102761B228C5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CDF267B90;
	Sun, 24 Aug 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tPJSFdkm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BziSSvRT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62E42048
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756028668; cv=none; b=iRwprPTrzI5ZarUzHObfDS1jXLQlUpuT/f+q5DjW5OsvCGVkTKQLFBHuFB/JJp2NLgMBrIpgP+zJl7hveSVVVWoUfGlT3J5ycnox5BXkuZInNqzzJ+fNwMBIFJ2L3A3XV5iRwigA1aT9NkBqXSAZu5n2dyWzSDYxm0mEM/wtLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756028668; c=relaxed/simple;
	bh=bwAx0gOdSDBJhsmSk3Dv0Kwls2ChYV/kU/XODa1T/gU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=naqcnMNkR177r0zzaDptxbzXJGDxfV7vEaoUE/6qvTpS4g63MU6kNBr6O41OGOS7hj9Ak9GIgtOIpAYhBmQeJyRkXwiIFxzJ+N9FZbbGvb/yDDCfBtv6iAwl5TUolRTF6byeGs+RzDwzVhN/XtmnCao18uIAK4SVDMxTsCn1xsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tPJSFdkm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BziSSvRT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756028665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQMMtO22bXIJtnCOx9/j4weHP8eTSMSU56KhTBQGbRE=;
	b=tPJSFdkmTt7fZTElhQcbd6Z2l+wWFbFbtUwc46K7xRGCpv2wuOsnUNSNHLSuXt4ZeGzvhW
	2NoMvZavR3yCSTvSqyB2SjRLTQf4ux08QsWA4brhUf/UKceunuuz0mIdzb93lGFY7x1/7d
	YUQShqfaiGTPMOjf9ksdRHH7+xJN11Hi3zHBuigUM81OhbGsj/2IXtKBPMjVNzJVrAeLPC
	VS/rY2pb7i3HmFfgMF6tXDg3vXHjbbqiRvgfP0wGFxDbx3N5+AJokyaLlfWCa2qAt4AMXQ
	coTOJ37LrH1pb2EFQjqEkd0CHEuBjguYpZVWQwDFMdbKiBWRRwnTTBpsaPjV2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756028665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQMMtO22bXIJtnCOx9/j4weHP8eTSMSU56KhTBQGbRE=;
	b=BziSSvRTTHT3KfW67LAEFFnxRs5oVooOiiqb2MYo0U4X7qMSTFffjMp67brxiAt2TcdOgA
	9OROyQRk6e6nQkCA==
To: Jirka Hladky <jhladky@redhat.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, john.stultz@linaro.org,
 anna-maria@linutronix.de
Cc: Philip Auld <pauld@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>, Miroslav Lichvar
 <mlichvar@redhat.com>, Luke Yang <luyang@redhat.com>, Jan Jurca
 <jjurca@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [REGRESSION] 76% performance loss in timer workloads caused by
 513793bc6ab3 "posix-timers: Make signal delivery consistent"
In-Reply-To: <CAE4VaGBZzpkfkBXbiuED8Pv-UnjQ5xSk+t=dAdwSjv=u7-b8pw@mail.gmail.com>
References: <CAE4VaGBZzpkfkBXbiuED8Pv-UnjQ5xSk+t=dAdwSjv=u7-b8pw@mail.gmail.com>
Date: Sun, 24 Aug 2025 11:44:23 +0200
Message-ID: <87sehh2gw8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 16 2025 at 18:38, Jirka Hladky wrote:
> I'm reporting a performance regression in kernel 6.13 that causes a
> 76% performance loss in timer-heavy workloads.

Are you talking about real world workloads or about the stress-ng bogosity?

> Through kernel bisection, we have identified the root cause as commit
> 513793bc6ab331b947111e8efaf8fcef33fb83e5.
>
> Summary
>
> Regression: 76% performance drop in applications using nanosleep()/POSIX timers
>  * 4.3x increase in timer overruns and voluntary context switches
>   * Dramatic drop in timer completion rate (76% -> 20%)
>   * Over 99% of timers fail to expire when timer migration is disabled in 6.13
> Root Cause: commit 513793bc6ab3 "posix-timers: Make signal delivery consistent"
> Impact: Timer signal delivery mechanism broken
> Reproducer: stress-ng --timer workload on any system.

That does:

arm_timer()
{
     timer.it_value.tv_sec = ...;
     timer.it_value.tv_nsec = ...;

     timer.it_interval.tv_sec = timer.it_value.tv_sec;
     timer.it_interval.tv_nsec = timer.it_value.tv_nsec;

     timer_settime(....&timer);
}

and in the signal handler it does:

     ...
     timer_getoverrun();
     arm_timer();

So from the kernel POV this means:

user space starts timer
arm_timer()
    ....    
        hrtimer_start()
    ...
        hrtimer_expire()
          raise_signal()

   signal_delivery()
        if (interval > 0)
#1          hrtimer_start()

user space signal_handler()
     
arm_timer()

        hrtimer_cancel();

#2      clear pending and overrun

        hrtimer_start();

So it's exactly doing what user space asks for.

Older kernels accounted for overruns and pending signals which might
have accumulated between #1 and #2, which is undefined behaviour as user
space cannot longer differentiate to which arming the expiry or the
overruns belong.

So clearing it when rearmed is the obvious correct thing to do because
it makes it consistent, no?

The same applies for the disarm scenario:

arm_timer()
     ...
     expires()
       raise_signal()

disarm_timer()
     ...
     discard signal

Older kernels did not discard it, but that makes zero sense because
after disarming the timer both the signal and the overrun becomes
immediately meaningless, no?

And this has nothing to do with timer migration or whatever, that's just
a matter of correctness.

If you can point me to a real world workload, which uses timers
correctly and does not just do random stuff with them, I'm happy to look
into it.

But this stress-ng thing is just made up nonsense which created bogus
statistics forever. So comparing bogus numbers is not an indicator for
a real regression.

Thanks,

        tglx


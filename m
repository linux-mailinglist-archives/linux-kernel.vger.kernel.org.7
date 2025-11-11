Return-Path: <linux-kernel+bounces-895571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92822C4E4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D533634CD77
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A40F31076A;
	Tue, 11 Nov 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V4MENSUm"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6B30EF87
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870157; cv=none; b=soAxcFNgAdKkqd7SNIwCbn9+kfwJEgmaEZ4KhbSWiaboxaAJ0gCZmja1nr5SfOztRTWU9DPq0e00YM8YJujwbWpjkwXOo0JaS6jdQM4Ez1wIGXuTSE8uOirr73NKtBQpNDNSKWOnY/+4+Dihkt8ngh1froy7uqARLoU3PpJkWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870157; c=relaxed/simple;
	bh=Nwdrbwu9R6Ra9hLkS3f4v3Kvermla15iatxPAyjp2Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtzLwmmpfAhsu9W5Q9qhRWQgX3xHk+0PxP4HMZWpfPrX0HXRp6IQlRVR7Vz6EvdNJNO7wwvNjLITVmkJvivj6ihNMufnXy4Msq/Tc2waPJc2aKXn+zOsUMg9VHJ+xtka1g+cIBeS4TAQKYdKeZNtQ5Ny7m8sef7jtwBWTNkOxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V4MENSUm; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762870149; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=3fEIfMGG/me+YTdgYV6rgKBoM5/zmURUXuXqu6nFbg0=;
	b=V4MENSUmX0oDkt9tf4NA31EeBxT49jAtTzcZxa+25eb7lSRmPadScexKLbkXiU2zyWhMZC4Udsxq4s0I6i3Mg9EpTynDsDv1RY1Wpvrflh69T8uwZsL34ORuLX6iSoaSC59zfk/zDqgLNWdd+DLLR/wTtIQDk9cKsWxWZbdLzJk=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WsC-u-V_1762870149 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 22:09:09 +0800
Date: Tue, 11 Nov 2025 22:09:08 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] watchdog: add lockup_sys_info sysctl to dump sys
 info on system lockup
Message-ID: <aRNDhCZR4uRL5IzJ@U-2FWC9VHC-2323.local>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-4-feng.tang@linux.alibaba.com>
 <aRM5bXr4erUqpl_e@pathway>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRM5bXr4erUqpl_e@pathway>

On Tue, Nov 11, 2025 at 02:26:05PM +0100, Petr Mladek wrote:
> On Thu 2025-11-06 10:30:32, Feng Tang wrote:
> > When soft/hard lockup happens, developers may need different kinds of
> > system information (call-stacks, memory info, locks, etc.) to help debugging.
> > 
> > Add 'lockup_sys_info' sysctl knob to take human readable string like
> > "tasks,mem,timers,locks,ftrace,...", and when system lockup happens, all
> > requested information will be dumped. (refer kernel/sys_info.c for more
> > details).
> > 
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -53,6 +54,13 @@ static int __read_mostly watchdog_hardlockup_available;
> >  struct cpumask watchdog_cpumask __read_mostly;
> >  unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
> >  
> > +/*
> > + * A bitmask to control what kinds of system info to be printed when
> > + * system lockup is detected, it could be task, memory, lock etc. Refer
> > + * include/linux/sys_info.h for detailed bit definition.
> > + */
> > +static unsigned long lockup_si_mask;
> > +
> >  #ifdef CONFIG_HARDLOCKUP_DETECTOR
> >  
> >  # ifdef CONFIG_SMP
> > @@ -240,6 +248,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
> >  				clear_bit_unlock(0, &hard_lockup_nmi_warn);
> >  		}
> 
> The code right above printed backtaces from all CPUs when
> sysctl_hardlockup_all_cpu_backtrace.
> 
> > +		sys_info(lockup_si_mask);
> 
> And sys_info() could print it again when SYS_INFO_ALL_BT
> bit is set. The hard lockup detector should use the same
> trick as the softlockup detector in watchdog_timer_fn().

Yes, I missed that. Thanks for the catching!

> >  		if (hardlockup_panic)
> >  			nmi_panic(regs, "Hard LOCKUP");
> >  
> > @@ -746,9 +755,11 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >  	unsigned long touch_ts, period_ts, now;
> >  	struct pt_regs *regs = get_irq_regs();
> >  	int duration;
> > -	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
> > +	int softlockup_all_cpu_backtrace;
> >  	unsigned long flags;
> >  
> > +	softlockup_all_cpu_backtrace = (lockup_si_mask & SYS_INFO_ALL_BT) ?
> > +					1 : sysctl_softlockup_all_cpu_backtrace;
> >  	if (!watchdog_enabled)
> >  		return HRTIMER_NORESTART;
> >  
> > @@ -846,6 +857,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >  		}
> >  
> >  		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
> > +		sys_info(lockup_si_mask & ~SYS_INFO_ALL_BT);
> >  		if (softlockup_panic)
> >  			panic("softlockup: hung tasks");
> >  	}
> > @@ -1178,6 +1190,13 @@ static const struct ctl_table watchdog_sysctls[] = {
> >  		.mode		= 0644,
> >  		.proc_handler	= proc_watchdog_cpumask,
> >  	},
> > +	{
> > +		.procname	= "lockup_sys_info",
> > +		.data		= &lockup_si_mask,
> > +		.maxlen         = sizeof(lockup_si_mask),
> > +		.mode		= 0644,
> > +		.proc_handler	= sysctl_sys_info_handler,
> > +	},
> 
> There already exists:
> 
> 	+ hardlockup_all_cpu_backtrace
> 	+ hardlockup_panic
> 	+ softlockup_all_cpu_backtrace
> 	+ softlockup_panic
> 
> IMHO, it would make sense to introduce separate:
> 
> 	+ hardlockup_sys_info
> 	+ softlockup_sys_info

Make sense to me, will do.

Thanks,
Feng


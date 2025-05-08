Return-Path: <linux-kernel+bounces-639113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AFEAAF312
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 07:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB92546802D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 05:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673032139D2;
	Thu,  8 May 2025 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yn/JVKKm"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A59136A
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746683122; cv=none; b=QMCKGuNPETurBKPUuD7U0KcFXELThKrNk1SNcgePseFPXYwCPj742EOsETuo+3JYn8KUT6TM8kU0XauHOu21WkUzntVLpJyFXDZ2PdNVZCXQdC7br8zrWWtKwys6NCRH2obYDUSfQAPi0soUPQHaUuHwhmKPjHpPFLcLZgayATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746683122; c=relaxed/simple;
	bh=FB9f6IVd609o+G9xayU7fVt5zLMyXTB2Wk2y/kROpLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrxn5GQIwK9hFd5G9Ncar0wHtL1iH9a1z3HZ4Jk2MM3fWylVVQ+aMMW3Ut/vA8SWiU2DQ84I+clexpPAe3gB7OMk0jx5tfIC/uLFJhOw0xN5bNxmOpZD0Xw/ov0bIstyKBUlsShNfJJ/fFz6cQ5Qvz2mi38bTR85aYo24IEtfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yn/JVKKm; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746683115; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=O3vNOpi48vOliJI6USQodPMEp9/pxxBw8nB5HQsOt0w=;
	b=yn/JVKKmnqkCbq5KN8vEyWWzpAOL5QufUVyle1NbknYVeE7cjP83I+kyK4PQJMZzf6FW3Qd2syrybPP5qIU+ppdD0GmCvEC4EALs6hdIqCghCZ+nji2VQwHrqTS3EnymTVjrJhlnj6YnWU3PqKIo91CfFrDS6cQcdVsDzfkZwds=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WZzhTaE_1746683114 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 May 2025 13:45:15 +0800
Date: Thu, 8 May 2025 13:45:14 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] kernel/hung_task: add option to dump system info
 when hung task detected
Message-ID: <aBxE6jXwjIDRdr1z@U-2FWC9VHC-2323.local>
References: <20250507104322.30700-1-feng.tang@linux.alibaba.com>
 <20250507104322.30700-3-feng.tang@linux.alibaba.com>
 <6eb27fe4-9dad-4ea5-afd0-a5d1e3f60acb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6eb27fe4-9dad-4ea5-afd0-a5d1e3f60acb@linux.dev>

Hi Lance,

Many thanks for the review!

On Thu, May 08, 2025 at 11:02:22AM +0800, Lance Yang wrote:
> Hi Feng,
> 
> Thanks for the patch series!
> 
> On 2025/5/7 18:43, Feng Tang wrote:
> > Kernel panic code utilizes sys_show_info() to dump needed system
> > information to help debugging. Similarly, add this debug option for
> > task hung case, and 'hungtask_print' is the knob to control what
> > information should be printed out.
> > 
> > Also clean up the code about dumping locks and triggering backtrace
> > for all CPUs. One todo may be to merge this 'hungtask_print' with
> > some sysctl knobs in hung_task.c.
> > 
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> >   kernel/hung_task.c | 29 ++++++++++++++++-------------
> >   1 file changed, 16 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index dc898ec93463..8229637be2c7 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -58,12 +58,20 @@ static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
> >   static int __read_mostly sysctl_hung_task_warnings = 10;
> >   static int __read_mostly did_panic;
> > -static bool hung_task_show_lock;
> >   static bool hung_task_call_panic;
> > -static bool hung_task_show_all_bt;
> >   static struct task_struct *watchdog_task;
> > +/*
> > + * A bitmask to control what kinds of system info to be printed when a
> > + * hung task is detected, it could be task, memory, lock etc. Refer panic.h
> > + * for details of bit definition.
> > + */
> > +unsigned long hungtask_print;
> > +core_param(hungtask_print, hungtask_print, ulong, 0644);
> 
> how about lockup_debug_print_mask?

The 3/3 patch has a 'lockup_print' as it is for soft/hard lockup :).
The name follows the existing 'panic_print', and indeed it's actually
a bitmask, how about 'hung_print_mask'?

> 
> It could be useful for debugging, but there are a few concerns:
> 
> 1) SYS_PRINT_* vs. hung_task_* priority conflict
> - If SYS_PRINT_ALL_CPU_BT is set on the command line but
> hung_task_all_cpu_backtrace is disabled, which one wins?
> - Or should SYS_PRINT_ALL_CPU_BT force-enable hung_task_all_cpu_backtrace?

With this patch, the 'hungtask_print' and hung_task_all_cpu_backtrace
will be ORed, so yes, if user sets SYS_PRINT_ALL_CPU_BT explicitly, the
all-cpu-backtrace will be printed.

While the default value for hungtask_print is 0, and no system info will
be dumped by default.

Long term wise, I'm not sure if sysctl_hung_task_all_cpu_backtracemay 
could be removed as its function can be covered by this print_mask knob.

> 2) Duplicate prints
> With SYS_PRINT_BLOCKED_TASKS enabled, processes in D state will be printed
> twice, right?

Good point. As sys_show_info() is a general API helper, the user may chose
not to set SYS_PRINT_BLOCKED_TASKS when debugging task hung.

In one recent bug we debugged with this patch, when the first "task hung" was
shown, there were already dozens of tasks were in D state, which just hadn't
hit the 120 seconds limit yet, and dumping them all helped in that case.

> Also, we really should document how those command-line parameters work ;)

Exactly! It currently just said 'refer panic.h' in code comment, maybe I
should copy those definitions here as comments. How do you think? 

Thanks,
Feng

> Thansk,
> Lance
> 
> > +
> > +static unsigned long cur_hungtask_print;
> > +
> >   #ifdef CONFIG_SMP
> >   /*
> >    * Should we dump all CPUs backtraces in a hung task event?
> > @@ -163,11 +171,12 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >   	 */
> >   	sysctl_hung_task_detect_count++;
> > +	cur_hungtask_print = hungtask_print;
> >   	trace_sched_process_hang(t);
> >   	if (sysctl_hung_task_panic) {
> >   		console_verbose();
> > -		hung_task_show_lock = true;
> > +		cur_hungtask_print |= SYS_PRINT_LOCK_INFO;
> >   		hung_task_call_panic = true;
> >   	}
> > @@ -190,10 +199,10 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >   			" disables this message.\n");
> >   		sched_show_task(t);
> >   		debug_show_blocker(t);
> > -		hung_task_show_lock = true;
> > +		cur_hungtask_print |= SYS_PRINT_LOCK_INFO;
> >   		if (sysctl_hung_task_all_cpu_backtrace)
> > -			hung_task_show_all_bt = true;
> > +			cur_hungtask_print |= SYS_PRINT_ALL_CPU_BT;
> >   		if (!sysctl_hung_task_warnings)
> >   			pr_info("Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings\n");
> >   	}
> > @@ -242,7 +251,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> >   	if (test_taint(TAINT_DIE) || did_panic)
> >   		return;
> > -	hung_task_show_lock = false;
> > +	cur_hungtask_print = 0;
> >   	rcu_read_lock();
> >   	for_each_process_thread(g, t) {
> >   		unsigned int state;
> > @@ -266,14 +275,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> >   	}
> >    unlock:
> >   	rcu_read_unlock();
> > -	if (hung_task_show_lock)
> > -		debug_show_all_locks();
> > -
> > -	if (hung_task_show_all_bt) {
> > -		hung_task_show_all_bt = false;
> > -		trigger_all_cpu_backtrace();
> > -	}
> > +	sys_show_info(cur_hungtask_print);
> >   	if (hung_task_call_panic)
> >   		panic("hung_task: blocked tasks");
> >   }


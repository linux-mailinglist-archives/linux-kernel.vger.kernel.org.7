Return-Path: <linux-kernel+bounces-895517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4EC4E246
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7CD7343D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B8C33ADA7;
	Tue, 11 Nov 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p0sppPvi"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211432F28EB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868281; cv=none; b=dgVKQe23EGIhKUdbt8CCgOV2peTbXHlJeohxzEdqgUqsP2xipSOowtIw3cKP4mJYIiTaGxTQtjt/cpMJO8ecAB/MoPn9lyYYSMX6s1wpkkJmLuPCwKU/0MDmZNupX2DwO1808DTC+le+2jGieG0YOPHc257wFba4XoCzLdpYrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868281; c=relaxed/simple;
	bh=YNQL5SKfM+jpMNhErLoV/0zsWX+kykfzmZSN1N+doaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzIx12QXPw8Db8qif/bXjLbfVpr+cXRWONy75eENn3i4UcFR/VSPXoMnqj+DwAEgx43YcFglKwzap8+JHnwYYrsyV3yFdfcasQd3+EwaaK/Tw3cR7YfivUs4DWqLkumahFozGXGDPwsurrV8ILxKsB2aYSzyDxjC96pKXTFGjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p0sppPvi; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762868274; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=HsNstYk+5rtzrxRtZDXucMaJcSGksdme1RvPM52n96E=;
	b=p0sppPviXPr1jUkvoYUUleDTi2woY3c9zWzfmAP/Gzv/ls0N+Gf8YrPI92IqtPUPf6XgeFqJ98shWwfWNZaVMvaH2SCKBFAe0vFKeijrtO5GTHJQlQKWT/ztDLoq8TWPTalBmMA1hoFe9zZSibLvn7fSM8L8ETXzrpdT107bZDY=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WsBpWuY_1762868273 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 21:37:54 +0800
Date: Tue, 11 Nov 2025 21:37:53 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hung_task: Add hung_task_sys_info sysctl to dump sys
 info on task-hung
Message-ID: <aRM8MU2sTew26SBl@U-2FWC9VHC-2323.local>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-3-feng.tang@linux.alibaba.com>
 <aRInLdgKCzaVeyG0@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRInLdgKCzaVeyG0@pathway.suse.cz>

Hi Petr,

On Mon, Nov 10, 2025 at 06:55:57PM +0100, Petr Mladek wrote:
> On Thu 2025-11-06 10:30:31, Feng Tang wrote:
> > When task-hung happens, developers may need different kinds of system
> > information (call-stacks, memory info, locks, etc.) to help debugging.
> > 
> > Add 'hung_task_sys_info' sysctl knob to take human readable string like
> > "tasks,mem,timers,locks,ftrace,...", and when task-hung happens, all
> > requested information will be dumped. (refer kernel/sys_info.c for more
> > details).
> > 
> > Meanwhile, the newly introduced sys_info() call is used to unify some
> > existing info-dumping knobs.
> > 
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -60,12 +61,23 @@ static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
> >  static int __read_mostly sysctl_hung_task_warnings = 10;
> >  
> >  static int __read_mostly did_panic;
> > -static bool hung_task_show_lock;
> >  static bool hung_task_call_panic;
> > -static bool hung_task_show_all_bt;
> >  
> >  static struct task_struct *watchdog_task;
> >  
> > +/*
> > + * A bitmask to control what kinds of system info to be printed when
> > + * a hung task is detected, it could be task, memory, lock etc. Refer
> > + * include/linux/sys_info.h for detailed bit definition.
> > + */
> > +static unsigned long hung_task_si_mask;
> > +
> > +/*
> > + * There are several sysctl knobs, and this serves as the runtime
> > + * effective sys_info knob
> > + */
> > +static unsigned long cur_si_mask;
> 
> It seems that this variable is used to pass information between
> check_hung_task() and check_hung_uninterruptible_tasks().
> 
> And "hung_task_show_lock" and "hung_task_show_all_bt" had the same
> purpose.
> 
> If I get it correctly, we could move these decisions to
> check_hung_uninterruptible_tasks() and avoid the global
> variable.
> 
> I think that it even makes the code a bit cleaner.
> 
> Something like this on top of this patch:
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 5f0275b2c742..c2a0dfce1e56 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -71,12 +71,6 @@ static struct task_struct *watchdog_task;
>   */
>  static unsigned long hung_task_si_mask;
>  
> -/*
> - * There are several sysctl knobs, and this serves as the runtime
> - * effective sys_info knob
> - */
> -static unsigned long cur_si_mask;
> -
>  #ifdef CONFIG_SMP
>  /*
>   * Should we dump all CPUs backtraces in a hung task event?
> @@ -229,11 +223,8 @@ static inline void debug_show_blocker(struct task_struct *task, unsigned long ti
>  }
>  #endif
>  
> -static void check_hung_task(struct task_struct *t, unsigned long timeout,
> -		unsigned long prev_detect_count)
> +static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  {
> -	unsigned long total_hung_task;
> -
>  	if (!task_is_hung(t, timeout))
>  		return;
>  
> @@ -243,16 +234,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout,
>  	 */
>  	sysctl_hung_task_detect_count++;
>  
> -	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
>  	trace_sched_process_hang(t);
>  
> -	cur_si_mask = hung_task_si_mask;
> -	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
> -		console_verbose();
> -		cur_si_mask |= SYS_INFO_LOCKS;
> -		hung_task_call_panic = true;
> -	}
> -
>  	/*
>  	 * Ok, the task did not get scheduled for more than 2 minutes,
>  	 * complain:
> @@ -272,10 +255,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout,
>  			" disables this message.\n");
>  		sched_show_task(t);
>  		debug_show_blocker(t, timeout);
> -		cur_si_mask |= SYS_INFO_LOCKS;
>  
> -		if (sysctl_hung_task_all_cpu_backtrace)
> -			cur_si_mask |= SYS_INFO_ALL_BT;
>  		if (!sysctl_hung_task_warnings)
>  			pr_info("Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings\n");
>  	}
> @@ -315,8 +295,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  {
>  	int max_count = sysctl_hung_task_check_count;
>  	unsigned long last_break = jiffies;
> +	unsigned long total_hung_task;
>  	struct task_struct *g, *t;
>  	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
> +	unsigned long si_mask;
>  
>  	/*
>  	 * If the system crashed already then all bets are off,
> @@ -325,6 +307,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  	if (test_taint(TAINT_DIE) || did_panic)
>  		return;
>  
> +	si_mask = hung_task_si_mask;
> +	if (sysctl_hung_task_warnings || hung_task_call_panic) {
> +		si_mask |= SYS_INFO_LOCKS;
> +
> +		if (sysctl_hung_task_all_cpu_backtrace)
> +			si_mask |= SYS_INFO_ALL_BT;
> +	}
> +
>  	rcu_read_lock();
>  	for_each_process_thread(g, t) {
>  
> @@ -336,16 +326,20 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  			last_break = jiffies;
>  		}
>  
> -		check_hung_task(t, timeout, prev_detect_count);
> +		check_hung_task(t, timeout);
>  	}
>   unlock:
>  	rcu_read_unlock();
>  
> -	if (unlikely(cur_si_mask)) {
> -		sys_info(cur_si_mask);
> -		cur_si_mask = 0;
> +	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
> +	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
> +		console_verbose();
> +		hung_task_call_panic = true;
>  	}
>  
> +	if (unlikely(si_mask))
> +		sys_info(si_mask);
> +
>  	if (hung_task_call_panic)
>  		panic("hung_task: blocked tasks");
>  }
> 
> What do you think?

The cleanup looks great to me.

> Hmm, maybe, we might still need to pass "prev_detect_count" and
> keep "console_verbose()" in check_hung_task().

I think moving the console_verbose() here is fine, as the msg printing
in check_hung_task() is mostly pr_err() and pr_info() already.

Thanks,
Feng

> 
> Best Regards,
> Petr


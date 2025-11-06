Return-Path: <linux-kernel+bounces-887796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B1DC391C3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 05:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A36BD4E2B65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 04:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08012C21C0;
	Thu,  6 Nov 2025 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HLmQDBwM"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7272175BF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 04:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762404556; cv=none; b=Y9NxUeX0ScjPyoCFG8fDBa2WHf9Pe4Jl9/fJMEk8SptZuAYcZA+zeADS9iTNDpfYqwetJExI4r9KsuVskpanfx2OwVZDa1L6V3dGIsXZb2PDLP78FpTHwDjCJM96IIx/umm/GOdhYjOoijUnXqo1giGC8cgk9c6upFzc6tUtOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762404556; c=relaxed/simple;
	bh=DaXAlj8JblPAjO5bWQU1Zg3FrFOWeWEku85KyWvoPSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCGh6asQNc6Txbit/d/4q5dvnKCUqUDFRYPXd/PEVh5tcgdAD6V3Ig1dTybL/Z8XKcNF8jLrmYn/7tLDhEKcWMmXD1ipo3Xy1Rt/Cluc2vtrmA3Cw4nPrttu/177ojfy+PwFl+lQdcMU4bE0WOsJiXazbkGzloZk5IYD7CvJSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HLmQDBwM; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762404539; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=hveDkFOYYmOMs9eLitfKUolNxOoYD1TWAO9nN3vGzlc=;
	b=HLmQDBwMfZfzOmUok+yoqVQwJECQgVsJAdMC+dRY1HcAAutRsXoYdxBUD+LtJom/m2jpZ2cxAVidOifoMFwLDeOYpdHVh7OsthMphKtW3DGSLNcpAnDUBJk7iCxLNCAC4xbTVS0i15E7zUY35jgSUwQddIKjN4fpiCaGi0IeRyE=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WroLZx6_1762404538 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 12:48:59 +0800
Date: Thu, 6 Nov 2025 12:48:58 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <ioworker0@gmail.com>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/3] hung_task: Add hung_task_sys_info sysctl to dump sys
 info on task-hung
Message-ID: <aQwoukY-yU0bSX5f@U-2FWC9VHC-2323.local>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-3-feng.tang@linux.alibaba.com>
 <572e1211-79e2-4b8e-b36f-4eeca125427c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <572e1211-79e2-4b8e-b36f-4eeca125427c@linux.dev>

On Thu, Nov 06, 2025 at 11:28:12AM +0800, Lance Yang wrote:
> 
> 
> On 2025/11/6 10:30, Feng Tang wrote:
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
> 
> Thanks! Just one nit below.
> 
> > 
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> >   Documentation/admin-guide/sysctl/kernel.rst |  5 +++
> >   kernel/hung_task.c                          | 39 +++++++++++++++------
> >   2 files changed, 33 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > index a397eeccaea7..45b4408dad31 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -422,6 +422,11 @@ the system boot.
> >   This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
> > +hung_task_sys_info
> > +==================
> > +A comma separated list of extra system information to be dumped when
> > +hung task is detected, for example, "tasks,mem,timers,locks,...".
> > +Refer 'panic_sys_info' section below for more details.
> >   hung_task_timeout_secs
> >   ======================
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index 84b4b049faa5..102be5a8e75a 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -24,6 +24,7 @@
> >   #include <linux/sched/sysctl.h>
> >   #include <linux/hung_task.h>
> >   #include <linux/rwsem.h>
> > +#include <linux/sys_info.h>
> >   #include <trace/events/sched.h>
> > @@ -60,12 +61,23 @@ static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
> >   static int __read_mostly sysctl_hung_task_warnings = 10;
> >   static int __read_mostly did_panic;
> > -static bool hung_task_show_lock;
> >   static bool hung_task_call_panic;
> > -static bool hung_task_show_all_bt;
> >   static struct task_struct *watchdog_task;
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
> 
> Nit: let's make the comment for cur_si_mask even more explicit.
> +/*
> + * The effective sys_info mask for the current detection cycle. It
> + * aggregates the base hung_task_si_mask and any flags triggered
> + * by other conditions within this cycle. It is cleared after use.
> + */
> > +static unsigned long cur_si_mask;
> 
> That makes its lifecycle (aggregate, use, and clear) super obvious ;)

Yep. Thanks for the imporovement! Will take.

> With that, LGTM!
> 
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
Thanks!

- Feng


Return-Path: <linux-kernel+bounces-834492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7DBA4CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46198626486
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B853278156;
	Fri, 26 Sep 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjroutgB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4D230270;
	Fri, 26 Sep 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909726; cv=none; b=D3xd+g27nr6yTauUjpswZm3dDLyfBE3DIsj8ztBJoZMx1XDGmLjtc80jxufH/xv215Vttvs7hXN6BdwSAXVs8ySMh4A2Zve9rK1FFG8rPeB6z/nzz2i3OWVWb5H1p5jWDCRBGjWL8ZcLaGIe42/QsxI9/lEUfaVpFMmq8PRyank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909726; c=relaxed/simple;
	bh=Owx5RhQKmwytc4KFlTa7J1L5/ly/QxMLOTPwzCneccE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvHxxPNsR3S4KRAMk0qkNeYKpUtRPFXkg8cPhcgCVgRwM8GzJdL+9R3Z3NWCb9v4uYOmS5k0Fzwbh2Et/vh+mouIpaQovQV5T3QKnQA3616h+qCuih31RcBrYo0cSUBd0xwc2QpXekWhJRdg+EuYArRQqfz25zBcrAIhP2wCNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjroutgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB75C4CEF4;
	Fri, 26 Sep 2025 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758909725;
	bh=Owx5RhQKmwytc4KFlTa7J1L5/ly/QxMLOTPwzCneccE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hjroutgBh2yBKKPkXr6bDMpp4wX0pjxtZvMwF87B1mpY5D7oDFdb5znzWTISyn6Md
	 /HbhJrgJ25j3nPmkHqbFFRoAaZ6PKdpHW/FpYO878TPRNEBb25/sSgx5xZu/pIGetF
	 1PLuec0zmI5AN/IGEfcqw7EBnn6/rdX9h0gCzwmoxSgaGKnrF3aEHs5xMeFlJWE+8r
	 RckWKZZ2KTaucoVg9YOeBVDWbauqfSdYinxH4RkiSI4PZVBHzxpC83+q8XuBK5osua
	 wnj0KmQHCDnCHFWEYRbcucaMhwziK/h0YGa6fpulcJUB+PZJyAxmmLL2Gg1tyOkMUM
	 xrrNPV6n6wyow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A547CE16D2; Fri, 26 Sep 2025 11:02:03 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:02:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: lirongqing <lirongqing@baidu.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, arnd@arndb.de,
	feng.tang@linux.alibaba.com, joel.granados@kernel.org,
	kees@kernel.org, rostedt@goodmis.org, pauld@redhat.com,
	pawan.kumar.gupta@linux.intel.com, mhiramat@kernel.org,
	dave.hansen@linux.intel.com, corbet@lwn.net,
	akpm@linux-foundation.org, mingo@kernel.org
Subject: Re: [PATCH] hung_task: Panic after fixed number of hung tasks
Message-ID: <81514e1d-4a10-4466-8a87-2d4b0927195b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250925060605.2659-1-lirongqing@baidu.com>
 <8c4cd66c-9c3f-411a-82df-0130b78e889c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c4cd66c-9c3f-411a-82df-0130b78e889c@linux.dev>

On Thu, Sep 25, 2025 at 06:26:00PM +0800, Lance Yang wrote:
> 
> Thanks for the patch!
> 
> On 2025/9/25 14:06, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > Currently, when hung_task_panic is enabled, kernel will panic immediately
> > upon detecting the first hung task. However, some hung tasks are transient
> > and the system can recover fully, while others are unrecoverable and
> > trigger consecutive hung task reports, and a panic is expected.
> 
> The new hung_task_count_to_panic relies on an absolute count, but I
> assume the real indicator you're trying to capture is the trend or
> rate of increase over a time window (e.g., "panic if count increases
> by 5 in 10 minutes").
> 
> IMHO, this kind of time-windowed, trend-based logic seems much more
> flexible and better suited for a userspace monitoring agent :)
> 
> In other words, why is this the right place for this feature?

A possibly related question is "why are RCU CPU stall warnings implemented
in the kernel instead of in userspace?"  One reason is that by the
time that things get bad enough to trigger an RCU CPU stall warning,
userspace might not be capable of doing much of anything.  Thus, there
is an uncomfortably high probability that orchestrating RCU CPU stall
warnings from userspace would cause these warnings to be lost entirely.

Similar reasoning might (or might not) apply to the hung-task mechanism.

							Thanx, Paul

> Please sell it to us ;)
> Lance
> 
> > 
> > This commit adds a new sysctl parameter hung_task_count_to_panic to allows
> > specifying the number of consecutive hung tasks that must be detected
> > before triggering a kernel panic. This provides finer control for
> > environments where transient hangs maybe happen but persistent hangs should
> > still be fatal.
> > 
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >   Documentation/admin-guide/sysctl/kernel.rst |  6 ++++++
> >   kernel/hung_task.c                          | 14 +++++++++++++-
> >   2 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > index 8b49eab..4240e7b 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -405,6 +405,12 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
> >   1 Panic immediately.
> >   = =================================================
> > +hung_task_count_to_panic
> > +=====================
> > +
> > +When set to a non-zero value, after the number of consecutive hung task
> > +occur, the kernel will triggers a panic
> > +
> >   hung_task_check_count
> >   =====================
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index 8708a12..87a6421 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -83,6 +83,8 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
> >   static unsigned int __read_mostly sysctl_hung_task_panic =
> >   	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
> > +static unsigned int __read_mostly sysctl_hung_task_count_to_panic;
> > +
> >   static int
> >   hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
> >   {
> > @@ -219,7 +221,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >   	trace_sched_process_hang(t);
> > -	if (sysctl_hung_task_panic) {
> > +	if (sysctl_hung_task_panic ||
> > +	    (sysctl_hung_task_count_to_panic &&
> > +	     (sysctl_hung_task_detect_count >= sysctl_hung_task_count_to_panic))) {
> >   		console_verbose();
> >   		hung_task_show_lock = true;
> >   		hung_task_call_panic = true;
> > @@ -388,6 +392,14 @@ static const struct ctl_table hung_task_sysctls[] = {
> >   		.extra2		= SYSCTL_ONE,
> >   	},
> >   	{
> > +		.procname	= "hung_task_count_to_panic",
> > +		.data		= &sysctl_hung_task_count_to_panic,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= proc_dointvec_minmax,
> > +		.extra1		= SYSCTL_ZERO,
> > +	},
> > +	{
> >   		.procname	= "hung_task_check_count",
> >   		.data		= &sysctl_hung_task_check_count,
> >   		.maxlen		= sizeof(int),
> 


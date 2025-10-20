Return-Path: <linux-kernel+bounces-863428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DFBF7D92
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EACB74F0861
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C334C131;
	Tue, 21 Oct 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lNI6oyK8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B234B680
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067141; cv=none; b=disArZmvT8iNOipKuMgLGq4WkGJgugHYnLSKc06zu7jq/d54F6XGECjtRFuipggWdIACjplPuo1pY619P0Y7PA8Dx1rEWr8ANfxt1NaQRPUc8iP+j+XT/csJyzLnfZgkwLGWYG96rOOkPSRW4PPPiOBbJbZwuKTQEKl9QxnzY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067141; c=relaxed/simple;
	bh=RJrfKsiyRw3LWx6cSqw2J7OFDC5KSARgchcirEtQCaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp4ZKuTSoEireWwO9DqQREEesQ7LCjoQAOA6BcdtvoeVKsE6El09ZJcvnoQ8gviWD9na2i/6kHb19qsgOxZc/V0TUzxaX+t2KwqRHi7ojCj2fhW/5orx6MjVZtkIJr6X0QngwNct13pzLsql8oJFPK+/gUDJD2Fm5s+gpwR6E4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lNI6oyK8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GspiutU/bgInSnOkKAThoUjKi2zsnbls2dJdmUyf1uQ=; b=lNI6oyK8bW4BazpU6/kN3n4ox3
	FeZFJ34CwyBhKvfKS1EsKc426ET49v4/6d3ISvlDQg+nbvWE+u74bquXQXXc6AQmCROlS9RuMzEBc
	Am3N3GGQG5WuTPE/JIVH9usOSxme3R19hpeQBG+mCsCLhLDniGHGCW6apsA9SWwiMPs3TSuQJDJSV
	nX5zWlLuzpSlb6t3XqIHdVpR0GyF6w9vkKahFUyVoGJatAVUqi5QHCMJfImYHvPyfKSheFkxam2m/
	a3MxCqEE0hNLqIFexBk11BnDeEOU+K7ON4tj+gTiEALFl145QaQFlQ1z+kmHAC8uP36bo9SNSQy/7
	mX2UPuKA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0d-0000000DsXY-1AGp;
	Tue, 21 Oct 2025 17:18:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E89F93030A3; Mon, 20 Oct 2025 12:16:02 +0200 (CEST)
Date: Mon, 20 Oct 2025 12:16:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] unwind: Add comment to unwind_deferred_task_exit()
Message-ID: <20251020101602.GK3419281@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080118.893367437@infradead.org>
 <20251001113505.25281444@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001113505.25281444@gandalf.local.home>

On Wed, Oct 01, 2025 at 11:35:05AM -0400, Steven Rostedt wrote:
> On Wed, 24 Sep 2025 09:59:53 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Explain why unwind_deferred_task_exit() exist and its constraints.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/exit.c |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -934,7 +934,6 @@ void __noreturn do_exit(long code)
> >  
> >  	tsk->exit_code = code;
> >  	taskstats_exit(tsk, group_dead);
> > -	unwind_deferred_task_exit(tsk);
> >  	trace_sched_process_exit(tsk, group_dead);
> >  
> >  	/*
> > @@ -945,6 +944,12 @@ void __noreturn do_exit(long code)
> >  	 * gets woken up by child-exit notifications.
> >  	 */
> >  	perf_event_exit_task(tsk);
> > +	/*
> > +	 * PF_EXITING (above) ensures unwind_deferred_request() will no
> > +	 * longer add new unwinds. While exit_mm() (below) will destroy the
> > +	 * abaility to do unwinds.
> 
> 
> I would state that it also flushes any unwind that is currently pending, as
> exit_mm() will prevent it from happening.

It now reads:

+       /*
+        * PF_EXITING (above) ensures unwind_deferred_request() will no
+        * longer add new unwinds. While exit_mm() (below) will destroy the
+        * abaility to do unwinds. So flush any pending unwinds here.
+        */
+       unwind_deferred_task_exit(tsk);



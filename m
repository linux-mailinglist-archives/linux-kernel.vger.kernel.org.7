Return-Path: <linux-kernel+bounces-822252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 920A8B83631
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD921C27A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF282EDD78;
	Thu, 18 Sep 2025 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ljdupphk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA682ED167;
	Thu, 18 Sep 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181544; cv=none; b=T2iRdlZ63B4a9piRmeuW/BOj1bMSCjso9P6fgZUbhvj3fVKag2sU9O0wY5+OtXuJpyuNylKuUeP3sMen2coQMxzICRiY8mQojMh0Rl0OsPzXkbVKBBTj4xd+8bzGVx+ukrLRYzWfrVbg9XxZal4ETY4ApmSmnA/OCuHwtfjnWSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181544; c=relaxed/simple;
	bh=s+WC4uTzB6N8Mo2Odh9TmAHpFcEEJQ9zdbOEZ9eh4iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiRSy9xqrq+XqIA0iFv8HVNYsZZZ9Dw38vv8a3xS+Vo/ZhT1WaeUdD3puPpifXxwafHG20L/jwBtrFJeSgroh2ACyCyUHXYqYTpWHa35t297yv05lBCwbBqrBNMBSJWPZnPFTNJKLfMj1e1OyhIu5uM1yOyir7LaQewtZqvXlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ljdupphk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o3niHjvUHc9LZUPhWlwJW8Oz1fReIPGyHTzQXs+P65c=; b=ljdupphkO1Pa1doVZvpZgTQ66C
	F0FsFK5B/5T0itrgU8K7UI5taynItBKImLv1FFPbkVG00W6rn5y/oFHJZD/rGKHhttfwifsi+o6LH
	7Bc2IwB04e4LAKHo1wiPqPgh80t38cgLzJ9n9nw7W4LY4Twq4Uu/xB8Lc0DF4YDGmgL2ux95Y+gx9
	zE5LxabErWvBoavwITAOI3B8EVMAbcoPOVaNvU9toULmyonR2CBMcWI37ALZFT3ByPGMyFlizMqia
	DJMvxo4yvPkr88wAHtFv75e625DCG/auETR7J5X/RfN5OyiB1BjvEXgymFc9SYaoV5QXGemkBHtNj
	fqNi+GuA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Kj-0000000FCgs-3vXT;
	Thu, 18 Sep 2025 07:45:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AC335300328; Thu, 18 Sep 2025 09:45:36 +0200 (CEST)
Date: Thu, 18 Sep 2025 09:45:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:sched/hrtick] [entry,hrtimer,x86] ebf33ab570:
 BUG:soft_lockup-CPU##stuck_for#s![pthread_mutex1_:#]
Message-ID: <20250918074536.GE3289052@noisy.programming.kicks-ass.net>
References: <202509081329.81f1ed82-lkp@intel.com>
 <20250911073304.GN4067720@noisy.programming.kicks-ass.net>
 <aMN/e2MHdJaaGT6z@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMN/e2MHdJaaGT6z@xsang-OptiPlex-9020>

On Fri, Sep 12, 2025 at 10:03:39AM +0800, Oliver Sang wrote:
> hi, Peter Zijlstra,
> 
> On Thu, Sep 11, 2025 at 09:33:04AM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 08, 2025 at 01:24:54PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![pthread_mutex1_:#]" on:
> > > 
> > > commit: ebf33ab5707c7c9ea25e3c03540b1329ad9aff1d ("entry,hrtimer,x86: Push reprogramming timers into the interrupt return path")
> > > https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/hrtick
> > > 
> > > in testcase: will-it-scale
> > > version: will-it-scale-x86_64-75f66e4-1_20250906
> > > with following parameters:
> > > 
> > > 	nr_task: 100%
> > > 	mode: thread
> > > 	test: pthread_mutex1
> > > 	cpufreq_governor: performance
> > > 
> > > 
> > > 
> > > config: x86_64-rhel-9.4
> > > compiler: gcc-13
> > > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > 
> > 
> > Is this the same issue again as last time? Eg. disabling all the perf
> > monitors makes it go?
> 
> yes, if disabling all monitors, the issue disappeared.

Could you try the below? I can't convince myself it can make a
difference, but while rebasing the patches I noted that we set the TIF
flag while holding cpu_base->lock, and clear after dropping it.

Still, its all on the local CPU with IRQs disabled, so it should not
matter.

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1989,8 +1989,8 @@ void _hrtimer_rearm(void)
 		now = hrtimer_update_base(cpu_base);
 		expires_next = hrtimer_update_next_event(cpu_base);
 		__hrtimer_rearm(cpu_base, now, expires_next);
+		clear_thread_flag(TIF_HRTIMER_REARM);
 	}
-	clear_thread_flag(TIF_HRTIMER_REARM);
 }
 #endif /* TIF_HRTIMER_REARM */
 #endif /* !CONFIG_HIGH_RES_TIMERS */


Anyway, I'll go post these patches, maybe someone else spots the fail.
I'll be sure to make a note this patch has issues.

Thanks!


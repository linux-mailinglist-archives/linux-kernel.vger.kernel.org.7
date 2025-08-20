Return-Path: <linux-kernel+bounces-777328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B0DB2D80A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96177B20BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82912E54DD;
	Wed, 20 Aug 2025 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ltGswQly"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963BC2DFA32
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681515; cv=none; b=NWuLroAHtadJ0PV5ga29D8U0EcOOUi1U2AKSqtYHzZ3YrkOaH+veO0n1alY3QMyMEjLiVqtvEw7dLvrwzDXjkQNBlNahzRjMcVR0MUzHahcSlxrw6Go0PMWb7jSjGWUb6zPcbUzHU5EMlcl6QLf8LupCU5fIZ5WN1bcP0R+8X6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681515; c=relaxed/simple;
	bh=Ws28LsztFhLqFyqo2T3iy8AB6LQgq6iLz8SRWQYdO4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni9ufhX8JNIU+eQulEXw0Gj4XDVDTLJn0pdVfWAaqyygdL63GA2v7mz1Gwy8yaQWvNmswKScwar7mbukuklv7WNwE2G3e0v6kHWkdRRxlbC+LefXGJB/g5d6SMdLTr7/ncA1ryFiE2R2oRe3GSfC4yQ43u8r/j7Yu06vJu7K9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ltGswQly; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f/e/WOXQQlSy5sYCjmNE7aAP4BRJV4RO5qr0dUsOGP0=; b=ltGswQlyuzcJMyKXSrxona8q1l
	74/wzbp8jaI3pVKqEyH3ahLS+VPGGqQmMwFvVwaI1Ewu6paQN1lUgJx6yxcUFmPUqs2oG4RWz5npA
	nNhkwd1QxGcIw6b3SSdLQ770VcAnbDfgW9TIfVJ9bl3+MtPMhEwnvZDIxvWMXlP5dLcAPOigdRRF/
	5Jn+QNJCwEM2BYi8VHAtUUqpAXwPtQAJ7QztYzg/pqqSoEKJA9lpHQjqsXpcoJFLKqq6MDRcU2LP7
	I+V9R2xQZVtrobwCDeL8AziGbzPvaG4ox2mucRcqOA3t1E2wpGHVjkETxGuTMF8EIu33vkJixSu6W
	HVfPEdYw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoexP-00000003wFD-0heU;
	Wed, 20 Aug 2025 09:18:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D2680300385; Wed, 20 Aug 2025 11:18:10 +0200 (CEST)
Date: Wed, 20 Aug 2025 11:18:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: 'Tejun Heo' <tj@kernel.org>
Cc: liuwenfang <liuwenfang@honor.com>, 'David Vernet' <void@manifault.com>,
	'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>,
	'Ingo Molnar' <mingo@redhat.com>,
	'Juri Lelli' <juri.lelli@redhat.com>,
	'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	'Ben Segall' <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>,
	'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v4 2/3] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Message-ID: <20250820091810.GK3245006@noisy.programming.kicks-ass.net>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
 <814bebd2ad844b08993836fd8e7274b8@honor.com>
 <228ebd9e6ed3437996dffe15735a9caa@honor.com>
 <8d64c74118c6440f81bcf5a4ac6b9f00@honor.com>
 <20250819074736.GD3245006@noisy.programming.kicks-ass.net>
 <aKUWoePcNPcnJT1D@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKUWoePcNPcnJT1D@slm.duckdns.org>

On Tue, Aug 19, 2025 at 02:28:17PM -1000, 'Tejun Heo' wrote:
> Hello, Peter.
> 
> (cc'ing Joel for the @rf addition to pick_task())
> 
> On Tue, Aug 19, 2025 at 09:47:36AM +0200, Peter Zijlstra wrote:
> ...
> > You're now asking for a 3rd call out to do something like:
> > 
> >   ->balance() -- ready a task for pick
> >   ->pick() -- picks a random other task
> >   ->put_prev() -- oops, our task didn't get picked, stick it back
> > 
> > Which is bloody ludicrous. So no. We're not doing this.
> > 
> > Why can't pick DTRT ?
> 
> This is unfortunate, but, given how things are set up right now, I think we
> probably need the last one. Taking a step back and also considering the
> proposed @rf addition to pick():
> 
> - The reason why SCX needs to do most of its dispatch operations in
>   balance() is because the kernel side doesn't know which tasks are going to
>   execute on which CPU until the task is actually picked for execution, so
>   all picking must be preceded by balance() where tasks can be moved across
>   rqs.
> 
> - There's a gap between balance() and pick_task() where a successful return
>   from balance() doesn't guarantee that the corresponding pick() would be
>   called. This seems intentional to guarantee that no matter what happens
>   during balance(), pick_task() of the highest priority class with a pending
>   task is guaranteed to get the CPU.

Yep, somewhat important that ;-)

>   This guarantee changes if we add @rf to pick_task() and let it unlock and
>   relock. A higher priority task may get queued while the rq lock is
>   released and then the lower priority pick_task() may still return a task
>   of its own.

No, this would be broken. This guarantee must not change.

What you can do however is something like:

again:
   p = pick_local_task();
   if (!p) {
     unlock(rq, rf);
     // get yourself a local task
     lock(rq, rf);
     if (higher-class-task-available(rq)) {
       // roll back whatever state
       return RETRY_TASK;
     }
     goto again;
   }

   return p;

> - SCX's ops.cpu_acquire() and .cpu_release() are to tell the BPF scheduler
>   that a CPU is available for running SCX tasks or not. We want to tell the
>   BPF side that a CPU became available before its ops.dispatch() is called -
>   ie. before balance(). So, IIUC, this is where the problem is. Because
>   there's a gap between balance() and pick_task(), the CPU might get taken
>   by a higher priority sched class inbetween. If that happens, we need to
>   tell the BPF scheduler that it lost the CPU. However, if the previous task
>   wasn't a SCX one, there's currently no place to tell so.
> 
>   IOW, SCX needs to invoke ops.cpu_released() when a CPU is taken between
>   its balance() and pick_task(); however, that can happen when both prev and
>   next tasks are !SCX tasks, so it needs something which is always called.
> 
> If @rf is added to pick_task() so that we can merge balance() into
> pick_task(), that'd be simplify these. SCX wouldn't need balance index
> boosting and can handle cpu_acquire/release() within pick_task(). What do
> you think?

That's more or less what I suggested here:

  https://lkml.kernel.org/r/20250819100838.GH3245006@noisy.programming.kicks-ass.net




Return-Path: <linux-kernel+bounces-801170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1261DB440D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19741CC04B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352412820B9;
	Thu,  4 Sep 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="TUe8qsC7"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE6280A5C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000623; cv=none; b=IOf05J0PZc6z7/ekgL2fVNTQsfk5x/T43taTnJU/6dhJfVqnx85LI+4vaTl/JNgWgu9QQil2UdfRXyuKwa22OfzWfxBcKfWIp9Bj/4YrZz3vvvZyL+u0e9PGUFpC6wSjFyCddxHsZBTS/Rmyg7SCKIgPQlgMTh4hvGRscx34xY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000623; c=relaxed/simple;
	bh=KXEOHoL2IljyKBxu8Y79Yi8jr6Uz6kzCnhgXnhSYtzQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I7pEURg3txDUYQrs6MZb/T6v5Wq7PtGX3l/c+mdYgzlg6gQEgvtxy2p6Xttg/WIqYY8wB5Ahrq1o9s/KHKEGns198rN6u15SHskxpOcSAda9GmBGgL4pLLKdP3Kt3JdKtsxnelADk2hRgwg8ZHY8MtPAjbv69MTxEqpQ7rlMxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=TUe8qsC7; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1757000074;
	bh=KXEOHoL2IljyKBxu8Y79Yi8jr6Uz6kzCnhgXnhSYtzQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=TUe8qsC7rK8DS04FfwPJkQ7plHdwzzwyJDU9pFnwWBh5+BQZWe31kcdJWVlqGduN6
	 C3vvWYlxgoPpVWos63iu7JV/VSKjyrTs90bE4BHl1sJS2uYeWX13CRILD+g1IUKZRU
	 06mHQNRihL+GxflvjTiJ48xg1jDoFurAn0X+gH2A=
Received: by gentwo.org (Postfix, from userid 1003)
	id B184D40196; Thu,  4 Sep 2025 08:34:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B046F40195;
	Thu,  4 Sep 2025 08:34:34 -0700 (PDT)
Date: Thu, 4 Sep 2025 08:34:34 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Frederic Weisbecker <frederic@kernel.org>
cc: Valentin Schneider <vschneid@redhat.com>, 
    Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com, 
    peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
    dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
    mgorman@suse.de, linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <aLmaJEU-WwVmVdYI@localhost.localdomain>
Message-ID: <9c8a2b87-5062-08a6-5a27-f53d986b1be2@gentwo.org>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com> <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com> <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <f6869880-1f7c-a39b-dc8e-4c3a84ba51ef@gentwo.org> <aLmaJEU-WwVmVdYI@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1600876637-1757000074=:557901"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1600876637-1757000074=:557901
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 4 Sep 2025, Frederic Weisbecker wrote:

> Le Wed, Aug 20, 2025 at 10:31:24AM -0700, Christoph Lameter (Ampere) a écrit :
> > On Wed, 20 Aug 2025, Valentin Schneider wrote:
> >
> > > My first question would be: is NOHZ_FULL really right for your workload?
> >
> > Yes performance is improved. AI workloads are like HPC workloads in that
> > they need to do compute and then rendezvous for data exchange.
>
> Ok, I was about to say that this is the first known (for me) usecase of
> nohz_full that is about performance and doesn't strictly require low-latency
> guarantee. But...

For me it was always about both. Low latency is required for a high number
of compute cycles in HPC apps. It is a requiremen for high performance
parallelized compute.

> > The more frequent rendezvous can be performed the better the performance
> > numbers will be.
>
> ...that is low-latency requirement...for performance :-)

Yea thats why we want this in HPC/HFT and AI applications.

> That's an argument _not_ in favour of dynamic balancing such as ILB, even for
> this usecase in nohz_full (all the other usecases of nohz_full I know really
> want static affinity and no balancing at all).
>
> So I have to ask, what would be wrong with static affinities to these tasks?

Static affinities are great but they keep the tick active and thus the
rendevous can be off off one or the other compute thread.

> > hohz full has been reworked somewhat since the early days and works in a
> > more general way today.
>
> Not sure about that. Although it was not initially intended to, it has
> been very single purpose since the early days: ie: run a single task in
> userspace without being disturbed.

The restrictions have been reduced from what I see in the code and
syscalls are possible without incurring a 2 second penalty of ticks.


> > > Here AIUI you're relying on the scheduler load balancing to distribute work
> > > to the NOHZ_FULL CPUs, so you're going to be penalized a lot by the
> > > NOHZ_FULL context switch overheads. What's the point? Wouldn't you have
> > > less overhead with just NOHZ_IDLE?
> >
> > The benchmarks show a regression of 10-20% if the tick is operational.
>
> Impressive!
>
> > The context switch overhead is negligible since the cpus are doing compute
> > and not system calls.
>
> And not many syscalls, right?

Periodically the data needs to be saved but that can be done from special
threads or after a large number of compute cycles is complete.
--8323329-1600876637-1757000074=:557901--


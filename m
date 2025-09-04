Return-Path: <linux-kernel+bounces-801226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15742B44263
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A103BC71F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F4F2F2900;
	Thu,  4 Sep 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht6wTSRK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFE286D46
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002414; cv=none; b=eRMvvKtvlToYzjDx8HtrJ5TYltd4LE3S5RfUcACnJWlTZDTevSZ4nGWWQn/+li9BWNYnoMkoON8COvlWfD2BCxCYFW0/jSOeHE6aI1WY4x8bYtsxiLfXDGS6/ap8rhrfOf+eHXhpcg3HYL4bFfXUrot+7ItuatvCGgAgByV1JkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002414; c=relaxed/simple;
	bh=dv6SMV0DaOi5LFJM3NwQYE7i2BXbmhwpP1vBhMKrjJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHVXrfoLKZweVYaWhUdNUCAFlL8r1mCSzhqveXw3ug8RVJyfKg7oY3aydiElnUrAITdrMUe3Yt/+H4DlxaNVaXytuRQbHWpDryKISEtVw/tFwBnySXSNzKQCEp1Zx2fP0M2wWjZmgUk/n5BvMuD+zD0dFiSVIIYZFwaahDQPEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht6wTSRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B109CC4CEF0;
	Thu,  4 Sep 2025 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757002414;
	bh=dv6SMV0DaOi5LFJM3NwQYE7i2BXbmhwpP1vBhMKrjJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ht6wTSRKcJ3QQu1QMTt/vCWDwib6pJE40RPkXefzMlo4DDJN/TBQu8TaA4J6jk1T1
	 cl66eZoxQ8Nc5k6FfM7AdXQigEc9WdHpEBFYCjBfmFS6i5MMi+44iYF4phv3gAUEBm
	 SCCsXvm6c/0OOej+3M4FgN++0x5y1S9gS+VCtFs+A80fyAAl/4Aq8dzzRLy+z6PywC
	 f1VFtKboEsq9vSC/2UTebb9owqd5O/XrSXFWgOj1kfiXHpKXzsSG6JCbCGnaCDzLb5
	 vda3M7FsKBFTXl+7kI3uLCXQsRQXWmIT71Dr+yAliKEN8IixmpgTIo2ZzJptzDTB9y
	 0w0P6Rqn9blLg==
Date: Thu, 4 Sep 2025 18:13:31 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for ILB
 CPU
Message-ID: <aLm6q5-4bZ78cM5P@localhost.localdomain>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <f6869880-1f7c-a39b-dc8e-4c3a84ba51ef@gentwo.org>
 <aLmaJEU-WwVmVdYI@localhost.localdomain>
 <9c8a2b87-5062-08a6-5a27-f53d986b1be2@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c8a2b87-5062-08a6-5a27-f53d986b1be2@gentwo.org>

Le Thu, Sep 04, 2025 at 08:34:34AM -0700, Christoph Lameter (Ampere) a écrit :
> On Thu, 4 Sep 2025, Frederic Weisbecker wrote:
> 
> > Le Wed, Aug 20, 2025 at 10:31:24AM -0700, Christoph Lameter (Ampere) a écrit :
> > > On Wed, 20 Aug 2025, Valentin Schneider wrote:
> > >
> > > > My first question would be: is NOHZ_FULL really right for your workload?
> > >
> > > Yes performance is improved. AI workloads are like HPC workloads in that
> > > they need to do compute and then rendezvous for data exchange.
> >
> > Ok, I was about to say that this is the first known (for me) usecase of
> > nohz_full that is about performance and doesn't strictly require low-latency
> > guarantee. But...
> 
> For me it was always about both. Low latency is required for a high number
> of compute cycles in HPC apps. It is a requiremen for high performance
> parallelized compute.

Right, it's just that until now I was used to workloads that would even
be broken if the occasional jitter reached some threshold, which doesn't
appear to be your case.

> 
> > > The more frequent rendezvous can be performed the better the performance
> > > numbers will be.
> >
> > ...that is low-latency requirement...for performance :-)
> 
> Yea thats why we want this in HPC/HFT and AI applications.

Ok.

> > That's an argument _not_ in favour of dynamic balancing such as ILB, even for
> > this usecase in nohz_full (all the other usecases of nohz_full I know really
> > want static affinity and no balancing at all).
> >
> > So I have to ask, what would be wrong with static affinities to these tasks?
> 
> Static affinities are great but they keep the tick active and thus the
> rendevous can be off off one or the other compute thread.

How do static affinities keep the tick active?

> 
> > > hohz full has been reworked somewhat since the early days and works in a
> > > more general way today.
> >
> > Not sure about that. Although it was not initially intended to, it has
> > been very single purpose since the early days: ie: run a single task in
> > userspace without being disturbed.
> 
> The restrictions have been reduced from what I see in the code and
> syscalls are possible without incurring a 2 second penalty of ticks.

Yes the isolation has been improved overall but the basic constraints remain.

> > > > Here AIUI you're relying on the scheduler load balancing to distribute work
> > > > to the NOHZ_FULL CPUs, so you're going to be penalized a lot by the
> > > > NOHZ_FULL context switch overheads. What's the point? Wouldn't you have
> > > > less overhead with just NOHZ_IDLE?
> > >
> > > The benchmarks show a regression of 10-20% if the tick is operational.
> >
> > Impressive!
> >
> > > The context switch overhead is negligible since the cpus are doing compute
> > > and not system calls.
> >
> > And not many syscalls, right?
> 
> Periodically the data needs to be saved but that can be done from special
> threads or after a large number of compute cycles is complete.

Got it!

Thanks.

-- 
Frederic Weisbecker
SUSE Labs


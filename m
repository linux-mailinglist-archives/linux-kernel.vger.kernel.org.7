Return-Path: <linux-kernel+bounces-800930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5589B43DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C095A055B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCDD2FDC49;
	Thu,  4 Sep 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt0aqSfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D5A2D6621
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994088; cv=none; b=Kpfm/4f+TjbGsgx99RmFEr/sQXIcHwQTtZlbP0lrSriGnPq+GETRstR39DtZkC7eKeT54S7yDH67LgzMA6SlwWGrCGXViUZr75IZipzBGLPofU/I087rybRSR4X9CH3jRnvn4/SReoidZk9WYEUn2jmwktjeyARrjZsDlf6uJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994088; c=relaxed/simple;
	bh=Y2Yup84jUEEgw2Mvut9LTPgE+8rkTtRuaafXIM2ivd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/Q+WsZDyugn+9n2E27vpVES07FdRGqqSrLF382H65C8PLKnHdlSjznk4pNihA+45eLmgUVwID1s39eL9lsKiefv16OskY370Zw+Sd2mNAulJtM/ckKT1S1KuTDxjxwiJ29hpWGvFAaW6VGBsWNIwYYOAI13nA2qmYqEvBtSlHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt0aqSfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531F6C4CEF0;
	Thu,  4 Sep 2025 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756994087;
	bh=Y2Yup84jUEEgw2Mvut9LTPgE+8rkTtRuaafXIM2ivd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qt0aqSfIa8OvsfCoXLvtFyU/7HsApY3WefMPti3NF7N8Ob8GR0hlb/up3ZdNvwmJh
	 VyapO9w5xRRZF/Zzx7BEOo6rnPz7QRCEvUacFT7HknzupaTss1bJFsdyWKikS/2QlF
	 Lue35omGZ4ApI1O9XbgqlYxxs0CqKiletwYp4wXyOEcxpJhIEZxr+zz8+G/R7PLzd0
	 wdz6ATW0CRXlsn4uBxwDPG3Rcpg8UIA5PaIkjd9Ea52puA486q8tmiNzkAakNY4ir0
	 wqgekbZ9mMGtxfbiD1AdBZD7cV6SUQ/H6AGOzu38wLMU5LbnXqibMEGd6dcFz1tGAm
	 KvjEKJs7bNdUA==
Date: Thu, 4 Sep 2025 15:54:44 +0200
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
Message-ID: <aLmaJEU-WwVmVdYI@localhost.localdomain>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <f6869880-1f7c-a39b-dc8e-4c3a84ba51ef@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6869880-1f7c-a39b-dc8e-4c3a84ba51ef@gentwo.org>

Le Wed, Aug 20, 2025 at 10:31:24AM -0700, Christoph Lameter (Ampere) a écrit :
> On Wed, 20 Aug 2025, Valentin Schneider wrote:
> 
> > My first question would be: is NOHZ_FULL really right for your workload?
> 
> Yes performance is improved. AI workloads are like HPC workloads in that
> they need to do compute and then rendezvous for data exchange.

Ok, I was about to say that this is the first known (for me) usecase of
nohz_full that is about performance and doesn't strictly require low-latency
guarantee. But...

> Variations
> in the runtime due to timer ticks cause idle periods where the rendezvous
> cannot be completed because some cpus are delayed.
> 
> The more frequent rendezvous can be performed the better the performance
> numbers will be.

...that is low-latency requirement...for performance :-)

That's an argument _not_ in favour of dynamic balancing such as ILB, even for
this usecase in nohz_full (all the other usecases of nohz_full I know really
want static affinity and no balancing at all).

So I have to ask, what would be wrong with static affinities to these tasks?

> 
> > It's mainly designed to be used with always-running userspace
> tasks, > generally affined to a CPU by the system administrator.
> 
> hohz full has been reworked somewhat since the early days and works in a
> more general way today.

Not sure about that. Although it was not initially intended to, it has
been very single purpose since the early days: ie: run a single task in
userspace without being disturbed.

> > Here AIUI you're relying on the scheduler load balancing to distribute work
> > to the NOHZ_FULL CPUs, so you're going to be penalized a lot by the
> > NOHZ_FULL context switch overheads. What's the point? Wouldn't you have
> > less overhead with just NOHZ_IDLE?
> 
> The benchmarks show a regression of 10-20% if the tick is operational.

Impressive!

> The context switch overhead is negligible since the cpus are doing compute
> and not system calls.

And not many syscalls, right?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs


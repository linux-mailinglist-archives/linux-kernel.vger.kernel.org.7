Return-Path: <linux-kernel+bounces-778331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EA2B2E43B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4241728FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42926F2A7;
	Wed, 20 Aug 2025 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="N8pHv3nC"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675B266B6B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711765; cv=none; b=o0aU1+S/G9d+DpGREfhZfqKQhSS+Y2Z9EgB8Tkp9eJdxA6Ykgl3FeIYlgM5pYWLQtIoc0T4+ueOVKKEPnfrQt2bXFsQRsKS7W9QTHhx0zYDZ1qT8XX/QASVCYUikG4e6IYHjrXqCNRwmn7ZLGhWpN0u/ikW4kNduFUJIHZoBSFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711765; c=relaxed/simple;
	bh=H4VXOd1Cr86+o8akleVO9UVFS506QVn2VCww5irrRYE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GBnYg/VnTS8rqWBzXrraOeuvvVjzkw01EmzL2vMflzQUNxaR+3r7RbK7PqhqGTqIy1CZutcDcCGJnmJ2c7T6DrPY9mWPyMPI0iC7NtJjPesYIvfz2ClIhri04bKQMjj2slhh1DiFt/0VO99oBocp7cYf5DzYk0XkqO8e8IQKJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=N8pHv3nC; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1755711084;
	bh=H4VXOd1Cr86+o8akleVO9UVFS506QVn2VCww5irrRYE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=N8pHv3nCy2D7KJ5hD+q46wTQT0yBh3jRcO7tU6q7DT4UlUEW/h0yiSMKzTOPByTWC
	 CGMNCGdGdLXXuUZUywQh3e0VX9MJNbipAaRnwkjndcKqfkwBlEjtPeWIEI9rq/gVQa
	 h4BlYiztmemC4pXv87nH3cik+obRqGjL9pm3AT90=
Received: by gentwo.org (Postfix, from userid 1003)
	id 9D0A640195; Wed, 20 Aug 2025 10:31:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 99C34400CA;
	Wed, 20 Aug 2025 10:31:24 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:31:24 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Valentin Schneider <vschneid@redhat.com>
cc: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com, 
    peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
    dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
    mgorman@suse.de, frederic@kernel.org, linux-kernel@vger.kernel.org, 
    patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Message-ID: <f6869880-1f7c-a39b-dc8e-4c3a84ba51ef@gentwo.org>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com> <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com> <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 Aug 2025, Valentin Schneider wrote:

> My first question would be: is NOHZ_FULL really right for your workload?

Yes performance is improved. AI workloads are like HPC workloads in that
they need to do compute and then rendezvous for data exchange. Variations
in the runtime due to timer ticks cause idle periods where the rendezvous
cannot be completed because some cpus are delayed.

The more frequent rendezvous can be performed the better the performance
numbers will be.

> It's mainly designed to be used with always-running userspace
tasks, > generally affined to a CPU by the system administrator.

hohz full has been reworked somewhat since the early days and works in a
more general way today.

> Here AIUI you're relying on the scheduler load balancing to distribute work
> to the NOHZ_FULL CPUs, so you're going to be penalized a lot by the
> NOHZ_FULL context switch overheads. What's the point? Wouldn't you have
> less overhead with just NOHZ_IDLE?

The benchmarks show a regression of 10-20% if the tick is operational.
The context switch overhead is negligible since the cpus are doing compute
and not system calls.

> As for the actual balancing, yeah if you have idle NOHZ_FULL CPUs they
> won't do the periodic balance; the residual 1Hz remote tick doesn't do that
> either. But they should still do the newidle balance to pull work before
> going tickless idle, and wakeup balance should help as well, albeit that
> also depends on your topology.

That should work in general and not depend on any hardware topology. In
this case we have a linear sched domain including all processors.


Return-Path: <linux-kernel+bounces-876454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B2C1B9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553CB584963
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C38325738;
	Wed, 29 Oct 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qnE0C8Eh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029472C3277
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749721; cv=none; b=hsBbuxRKIAXEfZNtwJwGEhClaHOwI6IY3Ko+0Hz9QJiP+DfiCmIw/ksBsMvOfcIQQUaBlYes/L1YHzywy0xqEcutE6Mcwlo+RV5sY2rm0+zO5o939GQj/qy0FRZc7Cg8G+M6Q3wM3chVAekMHeAhf+nDvDwccMPUNqa97A0vM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749721; c=relaxed/simple;
	bh=ZWlywKbxPtxI/X8cmcuuLQ4tkLG0DqW8vNF0jsT0UcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rkj7adbMUJ0DdGpEE9T7FIDt3FSC5P8cXIBR4FCII3jyA/Oye7jmsoQt8qLZOOlgVIBmYSBfIPsUP+4IAmWzyqZckSC7oEDKWZlNtqEaSI9EDl6XHxw0K2RB8NDiFJY8BReRlxd0EcZNcJpsZCxi1HfvYJjae4Xj0DP5YlhKdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qnE0C8Eh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=eQacS9QMYE7r7UxW5Hbt1tuV7oN84m94ni3qJwW6oQM=; b=qnE0C8EhnGCqp9ZEkTolWcVnBT
	Pcv1cv2gMwyrTzkFRbDvG5V3TjFUNoir+Hv55kCenlvitcllLy75MX5mTf5Mt43WKHJI0pMBMBUO+
	M0oaU23dPihbIN8A7dUskJ93EoGzNX39kS4tBag5JtNZ9b9sWlvxgDsCWk94w9vOLZMzoMBG0x72k
	M3n36li9/JH+0P1FFD5WR3ku2+R4UnHhZ6UAjE7TgcoXABsFnsUGx8ykl9oXoKgARGai2mwy3TxDM
	xl5ZN+3K6/gWehB+mY23PePYxYOsGcFvIhDuPLPoJ4gKvfe3nUYd4PqwBzM+uT5csGgZExHA2RV0L
	2MNDjHRw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE6iF-000000073km-1sAN;
	Wed, 29 Oct 2025 13:59:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A9847300323; Wed, 29 Oct 2025 15:55:13 +0100 (CET)
Date: Wed, 29 Oct 2025 15:55:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] sched/stats: Optimize /proc/schedstat printing
Message-ID: <20251029145513.GO3245006@noisy.programming.kicks-ass.net>
References: <aQIRg9EaBSX2rrGx@shell.ilvokhin.com>
 <20251029140755.GF4067720@noisy.programming.kicks-ass.net>
 <aQIoySXrIVcKXXGS@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQIoySXrIVcKXXGS@shell.ilvokhin.com>

On Wed, Oct 29, 2025 at 02:46:33PM +0000, Dmitry Ilvokhin wrote:
> On Wed, Oct 29, 2025 at 03:07:55PM +0100, Peter Zijlstra wrote:
> > On Wed, Oct 29, 2025 at 01:07:15PM +0000, Dmitry Ilvokhin wrote:
> > > Function seq_printf supports rich format string for decimals printing,
> > > but there is no need for it in /proc/schedstat, since majority of the
> > > data is space separared decimals. Use seq_put_decimal_ull instead as
> > > faster alternative.
> > > 
> > > Performance counter stats (truncated) for sh -c 'cat /proc/schedstat >
> > > /dev/null' before and after applying the patch from machine with 72 CPUs
> > > are below.
> > > 
> > > Before:
> > > 
> > >       2.94 msec task-clock               #    0.820 CPUs utilized
> > >          1      context-switches         #  340.551 /sec
> > >          0      cpu-migrations           #    0.000 /sec
> > >        340      page-faults              #  115.787 K/sec
> > > 10,327,200      instructions             #    1.89  insn per cycle
> > >                                          #    0.10  stalled cycles per insn
> > >  5,458,307      cycles                   #    1.859 GHz
> > >  1,052,733      stalled-cycles-frontend  #   19.29% frontend cycles idle
> > >  2,066,321      branches                 #  703.687 M/sec
> > >     25,621      branch-misses            #    1.24% of all branches
> > > 
> > > 0.00357974 +- 0.00000209 seconds time elapsed  ( +-  0.06% )
> > > 
> > > After:
> > > 
> > >       2.50 msec task-clock              #    0.785 CPUs utilized
> > >          1      context-switches        #  399.780 /sec
> > >          0      cpu-migrations          #    0.000 /sec
> > >        340      page-faults             #  135.925 K/sec
> > >  7,371,867      instructions            #    1.59  insn per cycle
> > >                                         #    0.13  stalled cycles per insn
> > >  4,647,053      cycles                  #    1.858 GHz
> > >    986,487      stalled-cycles-frontend #   21.23% frontend cycles idle
> > >  1,591,374      branches                #  636.199 M/sec
> > >     28,973      branch-misses           #    1.82% of all branches
> > > 
> > > 0.00318461 +- 0.00000295 seconds time elapsed  ( +-  0.09% )
> > > 
> > > This is ~11% (relative) improvement in time elapsed.
> > 
> > Yeah, but who cares? Why do we want less obvious code for a silly stats
> > file?
> 
> Thanks for the feedback, Peter.
> 
> Fair point that /proc/schedstat isn’t a hot path in the kernel itself,
> but it is a hot path for monitoring software (Prometheus for example).

Aliens! I like Xenomorphs :-) But I doubt that's what you're talking
about.

> In large fleets, these files are polled periodically (often every few
> seconds) on every machine. The cumulative overhead adds up quickly
> across thousands of nodes, so reducing the cost of generating these
> stats does have a measurable operational impact. With the ongoing trend
> toward higher core counts per machine, this cost becomes even more
> noticeable over time.
> 
> I've tried to keep the code as readable as possible, but I understand if
> you think an ~11% improvement isn't worth the added complexity. If you
> have suggestions for making the code cleaner or the intent clearer, I’d
> be happy to rework it.

What are they doing this for? I would much rather rework all this such
that all the schedstat crap becomes tracepoints and all the existing
cruft optional consumers of that.

Like I argued here:

  https://lkml.kernel.org/r/20250703141800.GX1613200@noisy.programming.kicks-ass.net

Then people can consume them however makes most sense, ideally with a
binary interface if it is high bandwidth.


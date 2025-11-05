Return-Path: <linux-kernel+bounces-886670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59800C36462
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF142624FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E214632E6A3;
	Wed,  5 Nov 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="2zxtOpuc"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF32C21DE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355093; cv=none; b=sdNR1wdF//eLTkhD4EK7/N0ZKs+vh0obTMpQ0l+uUup1T0kMb+fIlnpyS0BoN+m4CZJRGqIOiquYS9YJqJ704eJDWFOt4SHfjJl6w+xahFshFoK1xGTFOBIHZ3wWnw9Pv0JCmifhryfC4gABxETal6E738oIsp2f++26LX4qbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355093; c=relaxed/simple;
	bh=Mt1QCESqgGejJLVoSOulkJQrrMyV+/X1WW2OkPibHI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxlL7bmXypXdUaWeUGhv5lKCcU0sHUViJFbTflg411ZtgN/TCHEmif3Ip1kCID1B8/gcUDgjLEmFXxIw7MvkqYjFUDce3ZqEVm1a5AIvMhcICa5qJXLEWFDCyL5AmVPNwj8kFlFIoc/a3f2Z4iqM6uUSwRjIP4Sub+LhqOmKcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=2zxtOpuc; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 778359B35C;
	Wed, 05 Nov 2025 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1762355082;
	bh=Rmb+xL4wShSDVmH5+T4zXZPqT/861b/jOiVmGEz0Wes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2zxtOpucbKrW/Mpwva4+ULP9Vq35ztDEnsvMk65EUJVnFNG4ZL+90QpLO1OziOObg
	 Ivn9rKIodFrA4DSy/7amfmzVdjgaJIWLlV8ReJMzHFwPKOuNulf92s7K9MeT4YtZvF
	 yodNyyooYQioFFyi9Mf/37Q67utSLuUVvZsZayhw=
Date: Wed, 5 Nov 2025 15:04:23 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] sched/stats: Optimize /proc/schedstat printing
Message-ID: <aQtndzCnEmAD5C-L@shell.ilvokhin.com>
References: <aQIRg9EaBSX2rrGx@shell.ilvokhin.com>
 <20251029140755.GF4067720@noisy.programming.kicks-ass.net>
 <aQIoySXrIVcKXXGS@shell.ilvokhin.com>
 <20251029145513.GO3245006@noisy.programming.kicks-ass.net>
 <aQI3k8tqJD4L0u_c@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQI3k8tqJD4L0u_c@shell.ilvokhin.com>

On Wed, Oct 29, 2025 at 03:49:43PM +0000, Dmitry Ilvokhin wrote:
> On Wed, Oct 29, 2025 at 03:55:13PM +0100, Peter Zijlstra wrote:
> > On Wed, Oct 29, 2025 at 02:46:33PM +0000, Dmitry Ilvokhin wrote:
> > > On Wed, Oct 29, 2025 at 03:07:55PM +0100, Peter Zijlstra wrote:
> > > > On Wed, Oct 29, 2025 at 01:07:15PM +0000, Dmitry Ilvokhin wrote:
> > > > > Function seq_printf supports rich format string for decimals printing,
> > > > > but there is no need for it in /proc/schedstat, since majority of the
> > > > > data is space separared decimals. Use seq_put_decimal_ull instead as
> > > > > faster alternative.
> > > > > 
> > > > > Performance counter stats (truncated) for sh -c 'cat /proc/schedstat >
> > > > > /dev/null' before and after applying the patch from machine with 72 CPUs
> > > > > are below.
> > > > > 
> > > > > Before:
> > > > > 
> > > > >       2.94 msec task-clock               #    0.820 CPUs utilized
> > > > >          1      context-switches         #  340.551 /sec
> > > > >          0      cpu-migrations           #    0.000 /sec
> > > > >        340      page-faults              #  115.787 K/sec
> > > > > 10,327,200      instructions             #    1.89  insn per cycle
> > > > >                                          #    0.10  stalled cycles per insn
> > > > >  5,458,307      cycles                   #    1.859 GHz
> > > > >  1,052,733      stalled-cycles-frontend  #   19.29% frontend cycles idle
> > > > >  2,066,321      branches                 #  703.687 M/sec
> > > > >     25,621      branch-misses            #    1.24% of all branches
> > > > > 
> > > > > 0.00357974 +- 0.00000209 seconds time elapsed  ( +-  0.06% )
> > > > > 
> > > > > After:
> > > > > 
> > > > >       2.50 msec task-clock              #    0.785 CPUs utilized
> > > > >          1      context-switches        #  399.780 /sec
> > > > >          0      cpu-migrations          #    0.000 /sec
> > > > >        340      page-faults             #  135.925 K/sec
> > > > >  7,371,867      instructions            #    1.59  insn per cycle
> > > > >                                         #    0.13  stalled cycles per insn
> > > > >  4,647,053      cycles                  #    1.858 GHz
> > > > >    986,487      stalled-cycles-frontend #   21.23% frontend cycles idle
> > > > >  1,591,374      branches                #  636.199 M/sec
> > > > >     28,973      branch-misses           #    1.82% of all branches
> > > > > 
> > > > > 0.00318461 +- 0.00000295 seconds time elapsed  ( +-  0.09% )
> > > > > 
> > > > > This is ~11% (relative) improvement in time elapsed.
> > > > 
> > > > Yeah, but who cares? Why do we want less obvious code for a silly stats
> > > > file?
> > > 
> > > Thanks for the feedback, Peter.
> > > 
> > > Fair point that /proc/schedstat isn’t a hot path in the kernel itself,
> > > but it is a hot path for monitoring software (Prometheus for example).
> > 
> > Aliens! I like Xenomorphs :-) But I doubt that's what you're talking
> > about.
> > 
> > > In large fleets, these files are polled periodically (often every few
> > > seconds) on every machine. The cumulative overhead adds up quickly
> > > across thousands of nodes, so reducing the cost of generating these
> > > stats does have a measurable operational impact. With the ongoing trend
> > > toward higher core counts per machine, this cost becomes even more
> > > noticeable over time.
> > > 
> > > I've tried to keep the code as readable as possible, but I understand if
> > > you think an ~11% improvement isn't worth the added complexity. If you
> > > have suggestions for making the code cleaner or the intent clearer, I’d
> > > be happy to rework it.
> > 
> > What are they doing this for? I would much rather rework all this such
> > that all the schedstat crap becomes tracepoints and all the existing
> > cruft optional consumers of that.
> > 
> 
> One common use case for /proc/schedstat that I'm aware of is post-mortem
> analysis of scheduler behavior, for example, debugging latency,
> fairness, or throughput issues after they have occurred. Continuous
> polling is often done to preserve historical data, since it’s often
> unclear in advance which metrics will be useful for future
> investigation. I doubt historical data from /proc/schedstat is something
> average users monitor daily, but kernel developers or performance
> engineers are likely to use it for more in-depth analysis.
> 
> > Like I argued here:
> > 
> >   https://lkml.kernel.org/r/20250703141800.GX1613200@noisy.programming.kicks-ass.net
> > 
> > Then people can consume them however makes most sense, ideally with a
> > binary interface if it is high bandwidth.
> 
> I also agree that a binary interface would be a better long-term
> approach, not only because the text interface has formatting costs on
> the kernel side, but also due to parsing overhead in userspace. However,
> implementing a full binary interface is a larger project: other files
> like /proc/interrupts could benefit as well. I chose to start with a
> smaller-scale change because the /proc interface is unlikely to
> disappear soon, and even with better solutions available, existing
> software will continue to use it for some time.

Hi Peter,

I wanted to follow up to make sure I fully understand your position and
to confirm whether there's any path forward for this change exploring
binary interface path, or if you'd prefer to leave things as they are.

To briefly recap, my motivation was practical: while I agree that a
binary interface or tracepoints would be a better long-term solution,
the current text-based /proc/schedstat is still widely used in existing
tools. In large-scale environments, even small improvements in the
efficiency of generating these stats can have a measurable operational
impact, especially as core counts continue to rise.

I tried to keep the change minimal and focused, aiming for a
straightforward improvement without adding significant complexity. 

I also want to make sure that the arguments for this change haven't
fallen between the cracks, and that the practical reasons for making the
text version faster are fully considered. My goal is to close the loop
on this topic, so if you feel this patch isn't justified, I'm happy to
defer to your judgment. 

Thanks again for your time and feedback.


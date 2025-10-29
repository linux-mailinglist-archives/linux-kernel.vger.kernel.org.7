Return-Path: <linux-kernel+bounces-876432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B221C1BD78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF386661E38
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5CC2EBB90;
	Wed, 29 Oct 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="al12+fsj"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0C19F12D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749201; cv=none; b=XnHAHtd7oT+SEC2YfYWe1KGZMPB+Jm6WMTXI3zF+Kq8nXtt543TIIyA9dtX1QQn8pBNIzOKCcI8/umKOxsZWDUyRsXL30h1zkWRsTduHoMvDznRoS7m+DpcoN44AcIX/G9Qw9as77nTeaazr4cWQKME2SSjHoMXlbWZii9xyvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749201; c=relaxed/simple;
	bh=ngJAnlOKqYRtbwucuVGSwMfSaWkoeSQJh2mut5Zoti0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/dQCF1QaIuaL64qMisAr5MYALlLJkT1PJxWe2pJ7SvtxYt1RfwfGVkXYG0lkW31f2FegqCRE8P4Efi/DHHT97FihXlBAlw9bY47vs09C7MDMUoPraKZMeiZ40G+N9ipDBVNfrqd9cc/6n7osgq2S4jC5Ogr1MvyGwHz4EEBVNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=al12+fsj; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 802649B0B6;
	Wed, 29 Oct 2025 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1761749196;
	bh=x+mUewU0uubR5x+mt98SMi5/L+FjReZ5CAZTwZR8n6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=al12+fsjNs19YkMdP1Ke4eqTcDWxXcn+DuxDw5ZTJcUw31UnLLYjJFJgZL5IOTTab
	 XOOTiqS9IMy9O4LbjMJh5WwROzrxDvmXV6E3UZ2w32uuHDDYh/gQUrhJxy7hYeUkL6
	 cf+iwydtdvxIsmel2OaWK+aBVmInnqPrTWFr65rM=
Date: Wed, 29 Oct 2025 14:46:33 +0000
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
Message-ID: <aQIoySXrIVcKXXGS@shell.ilvokhin.com>
References: <aQIRg9EaBSX2rrGx@shell.ilvokhin.com>
 <20251029140755.GF4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029140755.GF4067720@noisy.programming.kicks-ass.net>

On Wed, Oct 29, 2025 at 03:07:55PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 29, 2025 at 01:07:15PM +0000, Dmitry Ilvokhin wrote:
> > Function seq_printf supports rich format string for decimals printing,
> > but there is no need for it in /proc/schedstat, since majority of the
> > data is space separared decimals. Use seq_put_decimal_ull instead as
> > faster alternative.
> > 
> > Performance counter stats (truncated) for sh -c 'cat /proc/schedstat >
> > /dev/null' before and after applying the patch from machine with 72 CPUs
> > are below.
> > 
> > Before:
> > 
> >       2.94 msec task-clock               #    0.820 CPUs utilized
> >          1      context-switches         #  340.551 /sec
> >          0      cpu-migrations           #    0.000 /sec
> >        340      page-faults              #  115.787 K/sec
> > 10,327,200      instructions             #    1.89  insn per cycle
> >                                          #    0.10  stalled cycles per insn
> >  5,458,307      cycles                   #    1.859 GHz
> >  1,052,733      stalled-cycles-frontend  #   19.29% frontend cycles idle
> >  2,066,321      branches                 #  703.687 M/sec
> >     25,621      branch-misses            #    1.24% of all branches
> > 
> > 0.00357974 +- 0.00000209 seconds time elapsed  ( +-  0.06% )
> > 
> > After:
> > 
> >       2.50 msec task-clock              #    0.785 CPUs utilized
> >          1      context-switches        #  399.780 /sec
> >          0      cpu-migrations          #    0.000 /sec
> >        340      page-faults             #  135.925 K/sec
> >  7,371,867      instructions            #    1.59  insn per cycle
> >                                         #    0.13  stalled cycles per insn
> >  4,647,053      cycles                  #    1.858 GHz
> >    986,487      stalled-cycles-frontend #   21.23% frontend cycles idle
> >  1,591,374      branches                #  636.199 M/sec
> >     28,973      branch-misses           #    1.82% of all branches
> > 
> > 0.00318461 +- 0.00000295 seconds time elapsed  ( +-  0.09% )
> > 
> > This is ~11% (relative) improvement in time elapsed.
> 
> Yeah, but who cares? Why do we want less obvious code for a silly stats
> file?

Thanks for the feedback, Peter.

Fair point that /proc/schedstat isn’t a hot path in the kernel itself,
but it is a hot path for monitoring software (Prometheus for example).
In large fleets, these files are polled periodically (often every few
seconds) on every machine. The cumulative overhead adds up quickly
across thousands of nodes, so reducing the cost of generating these
stats does have a measurable operational impact. With the ongoing trend
toward higher core counts per machine, this cost becomes even more
noticeable over time.

I've tried to keep the code as readable as possible, but I understand if
you think an ~11% improvement isn't worth the added complexity. If you
have suggestions for making the code cleaner or the intent clearer, I’d
be happy to rework it.


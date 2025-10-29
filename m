Return-Path: <linux-kernel+bounces-876315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A7AC1B298
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F01C263CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A22DAFCA;
	Wed, 29 Oct 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lFZNSCVs"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F228B4F0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746892; cv=none; b=Kwp8SFbQUzWIreRwsPQigrWHFDD1et58Q2sNsfFilLXUoJt+C2Hf4Y/+r0E9lD+v/kA0esEkRN+nUoL43cfoATQJOq4BJjPgi7nEbpZ+RJe5SAEuY1Al1Un46npY6MZKiILTtY2zvCRDodlks1Lwao8qEquK84b3kY0NANe/yTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746892; c=relaxed/simple;
	bh=vgplDEI2cURAK710QiiFa6EaaEVkPFraJNb6vsw3aEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPTEAXimSgrIbRskUBCV40n+h/qtyQJuxzKdfDT7zRzOXmV5KJoGOmuPA5gej9HKhlU2E/cIll1LOgWpVLDdivbkI5ILdshWiC0RUKrLqKJ8JMk+IMKwdIOdz94d3BlBpVtpaAUiboHxRuU/ayf9Kqh5G/Fg/7CCXRBO7/XmQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lFZNSCVs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eyTFgjCtlAFz41bPRe0AiqKzbpcg+fQtnl2er0W0fDo=; b=lFZNSCVsF/nT0Mw0/1NSmt4zHJ
	agMu3urzhT27A34Oc8B8VpZgZ8NDuO+EXNuHMycdlqoSccEUdOnoxY7QaGC7kSP89RE+TLWmTZL3J
	bZl9XyoxzOwJCFboBBeWdlxa01sEPPmUQbzy4eI03qScbnNFTzO2qhQt5suZaUgVP0rNJ1tprClTH
	szayLs4jsfyFhrKNxtu5H8GdjEXE42m5f2sAU73aC3JpSaq6jxERKBa/D56iMEqfGifR4sVGMla01
	3PPdiw2/zIdSYbPllCN6jgVF2a811bJYzLbQ53d9OKI1pyzqYUuEQFIOzCUD/GWbIQi1LEOfDJFPC
	0R/uOtyQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE5yT-00000006wGy-0URG;
	Wed, 29 Oct 2025 13:12:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1A62D300289; Wed, 29 Oct 2025 15:07:55 +0100 (CET)
Date: Wed, 29 Oct 2025 15:07:55 +0100
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
Message-ID: <20251029140755.GF4067720@noisy.programming.kicks-ass.net>
References: <aQIRg9EaBSX2rrGx@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQIRg9EaBSX2rrGx@shell.ilvokhin.com>

On Wed, Oct 29, 2025 at 01:07:15PM +0000, Dmitry Ilvokhin wrote:
> Function seq_printf supports rich format string for decimals printing,
> but there is no need for it in /proc/schedstat, since majority of the
> data is space separared decimals. Use seq_put_decimal_ull instead as
> faster alternative.
> 
> Performance counter stats (truncated) for sh -c 'cat /proc/schedstat >
> /dev/null' before and after applying the patch from machine with 72 CPUs
> are below.
> 
> Before:
> 
>       2.94 msec task-clock               #    0.820 CPUs utilized
>          1      context-switches         #  340.551 /sec
>          0      cpu-migrations           #    0.000 /sec
>        340      page-faults              #  115.787 K/sec
> 10,327,200      instructions             #    1.89  insn per cycle
>                                          #    0.10  stalled cycles per insn
>  5,458,307      cycles                   #    1.859 GHz
>  1,052,733      stalled-cycles-frontend  #   19.29% frontend cycles idle
>  2,066,321      branches                 #  703.687 M/sec
>     25,621      branch-misses            #    1.24% of all branches
> 
> 0.00357974 +- 0.00000209 seconds time elapsed  ( +-  0.06% )
> 
> After:
> 
>       2.50 msec task-clock              #    0.785 CPUs utilized
>          1      context-switches        #  399.780 /sec
>          0      cpu-migrations          #    0.000 /sec
>        340      page-faults             #  135.925 K/sec
>  7,371,867      instructions            #    1.59  insn per cycle
>                                         #    0.13  stalled cycles per insn
>  4,647,053      cycles                  #    1.858 GHz
>    986,487      stalled-cycles-frontend #   21.23% frontend cycles idle
>  1,591,374      branches                #  636.199 M/sec
>     28,973      branch-misses           #    1.82% of all branches
> 
> 0.00318461 +- 0.00000295 seconds time elapsed  ( +-  0.09% )
> 
> This is ~11% (relative) improvement in time elapsed.

Yeah, but who cares? Why do we want less obvious code for a silly stats
file?


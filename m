Return-Path: <linux-kernel+bounces-872298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3943BC0FDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBFB3A1D53
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077B031960D;
	Mon, 27 Oct 2025 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="ca9S0yEC"
Received: from mail13.out.titan.email (mail13.out.titan.email [18.198.78.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6A314D16
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.78.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588417; cv=none; b=F4MjNkzCa+yB+TQcP68yHslycS9NyUNKAW3lLGUvSegc6NszwVFVRl3lDJxvNLbkgHCiRKZj9itNGLwD5YCR7KmBv7YPgdspQTdMPI8pjw89du5EmuC4gjgv9vqOR1tHriPBeZyyIz9jDWoYuZZYT8vFIKCFYHtfrtsb+hv80j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588417; c=relaxed/simple;
	bh=+hd9bb6phLoMieUc1q8gJN1P3JIvM7ZNg0Jv2rbCBAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL+8VUKDXnSnpVcsWNBxFIg96wZBcGq0cslzKRQpFo578ka6oF0nZvQq6d7qUgtmGblnv2vvRBCspCebLy+5411yGh4FFI2JvTi0ZekomX5I2sihXGv280wmRoI1sSP/35WP33PrXDF7gZ2yoOhAv6OGnzkxM4orEQSaTBIqewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=ca9S0yEC; arc=none smtp.client-ip=18.198.78.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4cwM063xGGz4vxJ;
	Mon, 27 Oct 2025 18:06:46 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=lhqpZ1rlvY7nHMufUQetHLF9pj/jPmf9pd4VX3Kixhc=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=mime-version:date:message-id:references:from:cc:in-reply-to:to:subject:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1761588406; v=1;
	b=ca9S0yECM8Hyjvt96IDdCxmb4tkYmBsdHdS6swXKF2JyP3JPLYzCvBCOMMrLQ79H/3g+plC1
	r18Wj1Vqfh+qRI7VA0RYtZAg6OCd7M/N7aipY85jKVzbxQ4kagU48FrtuxVUebqk4mDPnkHefcE
	el7jp34ahZWJR9zu1OnVYRaE=
Received: from techsingularity.net (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4cwM054yFQz4vxD;
	Mon, 27 Oct 2025 18:06:45 +0000 (UTC)
Date: Mon, 27 Oct 2025 18:06:39 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>, 
	Doug Nelson <doug.nelson@intel.com>, Mohini Narkhede <mohini.narkhede@intel.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Skip useless sched_balance_running acquisition if
 load balance is not due
Message-ID: <4gvjwli7prddt5xkvqmbhrrcbpjph7b7dd6xcbbz7fudotgfib@5ytyxeo3b4ej>
References: <20250416035823.1846307-1-tim.c.chen@linux.intel.com>
 <CAKfTPtA7sLeddYsRU=uftcYt4RpEbWNHWx36tBDzGuPxu8oEmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtA7sLeddYsRU=uftcYt4RpEbWNHWx36tBDzGuPxu8oEmg@mail.gmail.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1761588406345317458.2237.4472037527126828400@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=Rqw/LDmK c=1 sm=1 tr=0 ts=68ffb4b6
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
	a=R_Myd5XaAAAA:8 a=jD4jJHs5_3joPnLVgjoA:9 a=PUjeQqilurYA:10
	a=cvBusfyB2V15izCimMoJ:22 a=L2g4Dz8VuBQ37YGmWQah:22

On Fri, Jun 06, 2025 at 03:51:34PM +0200, Vincent Guittot wrote:
> On Wed, 16 Apr 2025 at 05:51, Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >
> > At load balance time, balance of last level cache domains and
> > above needs to be serialized. The scheduler checks the atomic var
> > sched_balance_running first and then see if time is due for a load
> > balance. This is an expensive operation as multiple CPUs can attempt
> > sched_balance_running acquisition at the same time.
> >
> > On a 2 socket Granite Rapid systems enabling sub-numa cluster and
> > running OLTP workloads, 7.6% of cpu cycles are spent on cmpxchg of
> > sched_balance_running.  Most of the time, a balance attempt is aborted
> > immediately after acquiring sched_balance_running as load balance time
> > is not due.
> >
> > Instead, check balance due time first before acquiring
> > sched_balance_running. This skips many useless acquisitions
> > of sched_balance_running and knocks the 7.6% CPU overhead on
> > sched_balance_domain() down to 0.05%.  Throughput of the OLTP workload
> > improved by 11%.
> >
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Reported-by: Mohini Narkhede <mohini.narkhede@intel.com>
> > Tested-by: Mohini Narkhede <mohini.narkhede@intel.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 

Reviewed-by: Mel Gorman <mgorman@techsingularity.net>

I've been missing for a while and even now on reduced workload so I'm
only looking at this patch now. It was never merged, but why? It looks
like a no-brainer to avoid an atomic operation with minimal effort even
if it only applies to balancing across NUMA domains.

Performance looks better for a small number of workloads on multi-socket
machines including some Zen variants. Most results were neutral which is
not very surprising given the path affected. I made no effort to determine
how hot this particular path is for any of the tested workloads but nothing
obviously superceded this patch or made it irrelevant.

-- 
Mel Gorman
SUSE Labs


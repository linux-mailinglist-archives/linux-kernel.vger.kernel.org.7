Return-Path: <linux-kernel+bounces-852201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E405DBD86E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9029D351C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639772E7648;
	Tue, 14 Oct 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KKsyhsqz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4132225D546
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433982; cv=none; b=hjFL/v9C0nA9808n2DCIGN+mT/TM0bDVVvB0PlFsOzJpPj60GyXmNIC9vXcTSMZfNT6Ns3rrbs/bg/1m1473qWIRyMHMYOSYoNXuaFsFgnp1EjCfuj0nYoiCcUeDE2D+j6lBfyWp7gT5UuyZAPc+n/MeyDHndjna4BeWKxYEXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433982; c=relaxed/simple;
	bh=Pq0Pr5LxfMbQk2jGn3iVLVQKAQNS3zRXlXJ7B3ENcTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP9o0WIn5cq5ztn4ofzhKXbqGbyQw1wzAGtsHLybwPG7uKXSy1MsKBHme7JLyK71dpbCiB/Qe16GxoomYAwfxUhA6Rnj10n9qRDxJSaeYyQ3mdjPvzUEx8laIIpeNyKOoV5TxTnkxeJDrnHLJSkxEs4LPvz/z3Nx3F4ciVkHKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KKsyhsqz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q9mcpFO+Weyij5VzcLoF8BzNqh6m5wjI0irU4lbTXLk=; b=KKsyhsqzfut2L0+NEBtPFTnceI
	g/wJJYm8N3gwB0DwhdnGeegXDZketINdXGKC5zpXpo0JcYJ588gWAjkbv3I+K6SRhuZ6CtNNX655j
	euVOlLTjYLOQt7MQ7rM/69gJezemCtfzC5jtmn8gcikR32ADY2EVApj12rGNH/8BMbQqoEY7DjgMF
	iCSf8eUHuW1bI+hJc6FTuSjxASQLOunEZdwQ+bN5MPxdGRcGfmqvzKqCY38fxr97BhvSyER/k/Q4k
	53AHeX/oXG1b5Q5oSvRwixEx1I29X0K5Hn+WhtHaM25Rt56a4K6ybWbjxG1q0/+DqecBcxqjvgQUJ
	/lxar/Vg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8bIL-00000007k6A-3LGZ;
	Tue, 14 Oct 2025 09:26:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1EBC5300289; Tue, 14 Oct 2025 11:26:14 +0200 (CEST)
Date: Tue, 14 Oct 2025 11:26:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
	Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
Message-ID: <20251014092614.GL4067720@noisy.programming.kicks-ass.net>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <49dba7ff-8be6-40cf-9aa7-b0a5cb2f77c3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49dba7ff-8be6-40cf-9aa7-b0a5cb2f77c3@intel.com>

On Tue, Oct 14, 2025 at 12:32:57AM +0800, Chen, Yu C wrote:
> On 10/13/2025 10:26 PM, Peter Zijlstra wrote:
> > On Thu, Oct 02, 2025 at 04:00:12PM -0700, Tim Chen wrote:
> > 
> > > During load balancing, balancing at the LLC level and above must be
> > > serialized.
> > 
> > I would argue the wording here, there is no *must*, they *are*. Per the
> > current rules SD_NUMA and up get SD_SERIALIZE.
> > 
> > This is a *very* old thing, done by Christoph Lameter back when he was
> > at SGI. I'm not sure this default is still valid or not. Someone would
> > have to investigate. An alternative would be moving it into
> > node_reclaim_distance or somesuch.
> > 
> 
> Do you mean the following:
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 444bdfdab731..436c899d8da2 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1697,11 +1697,16 @@ sd_init(struct sched_domain_topology_level *tl,
>                 sd->cache_nice_tries = 2;
> 
>                 sd->flags &= ~SD_PREFER_SIBLING;
> -               sd->flags |= SD_SERIALIZE;
>                 if (sched_domains_numa_distance[tl->numa_level] >
> node_reclaim_distance) {
>                         sd->flags &= ~(SD_BALANCE_EXEC |
>                                        SD_BALANCE_FORK |
>                                        SD_WAKE_AFFINE);
> +                       /*
> +                        * Nodes that are far away need to be serialized to
> +                        * reduce the overhead of long-distance task
> migration
> +                        * caused by load balancing.
> +                        */
> +                       sd->flags |= SD_SERIALIZE;
>                 }
> 
> We can launch some tests to see if removing SD_SERIALIZE would
> bring any impact.

Yeah, something like that. But lets first get this other thing sorted. I
agree that the SD_SERIALIZE thing is in the wrong place.


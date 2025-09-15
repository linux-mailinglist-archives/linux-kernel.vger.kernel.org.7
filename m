Return-Path: <linux-kernel+bounces-816975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E048B57BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF561716D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AAE2F619D;
	Mon, 15 Sep 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+ZUr+4w"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584B30C35D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940393; cv=none; b=kh9PgBTQ/55/vBPpid/jLdD4yeG9i+rt8zIDmGDO3JdBNxqCDKDNOHy13Pl5AyOaHKoNkaKy263o1+sy1rtuBBLKx8Fr7sTs++YvIiv0iHOhg2QiWdzaG17zaQVe/zfELRkulKLST8PSbmj90rg5B3ePIGC7I2Nxu/WbkiP0RWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940393; c=relaxed/simple;
	bh=8K3qhCEVntYpqks6hbAZVbzX91LPYALD7hZrna3Wf1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us8wBemqhODglY3LXIW1XFmN1CrKoFksDyrz0qEXmR0wb8/cS7I3DcbIJutSbFZsaKFwOSuiZQz/ZxUNmsYWSLgBZ6+W6udZSsuA4iuPC73jTzij8Agq1WlKqK5GG7tC3iEDnEVLbrrXD/5MTdfaPde7q5Tt6laemQ4sSfhe9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j+ZUr+4w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=roxWxZNd5RHeZx94bFohg6BtZ/O98eZ2QkoC0PlCjtY=; b=j+ZUr+4wnN6x16bHsluNhzynt7
	lQJ0tyiSKDe8FLHi0FzbEtzjYW4rEHCiOSNEFDoPB4oCGfIeXkJrY9/5pV32y3Grk+HNLPQ+CVaok
	ejaytGRyUhT9TtmPfaV75gSb5MIp11cFxoEV1VULk/AyrfXtsyhzkn2UdM2wEN1QAUJtWpRIsBB3g
	SPxk5lqNkSc6pBwOKvoE34SdE1n2B3Ctwbr8MrarUweHVr6yRyRx6f8lOufOqG9vZx1nw5qR8CQHO
	EEnkDyjNOAUydSLBwD9C98AkzURikgA7LSlycACxEqVnsctHwaut/7VFgJ1UJwEmAk9nZ/h4LXysY
	k9t5WbXQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8aq-0000000FRCA-19y2;
	Mon, 15 Sep 2025 12:46:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5575B302E03; Mon, 15 Sep 2025 14:46:00 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:46:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Libo Chen <libo.chen@oracle.com>,
	Abel Wu <wuyun.abel@bytedance.com>, Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [PATCH v3 2/2] sched: Fix sched domain build error for GNR, CWF
 in SNC-3 mode
Message-ID: <20250915124600.GE3245006@noisy.programming.kicks-ass.net>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
 <208a0a8278a28521e7bbc5114cf9899d31875d15.1757614784.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208a0a8278a28521e7bbc5114cf9899d31875d15.1757614784.git.tim.c.chen@linux.intel.com>

On Thu, Sep 11, 2025 at 11:30:57AM -0700, Tim Chen wrote:
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 33e166f6ab12..3f894c525e49 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -515,6 +515,34 @@ static void __init build_sched_topology(void)
>  	set_sched_topology(topology);
>  }
>  
> +int arch_sched_node_distance(int from, int to)
> +{
> +	int d = node_distance(from, to);
> +
> +	if (!x86_has_numa_in_package)
> +		return d;
> +
> +	switch (boot_cpu_data.x86_vfm) {
> +	case INTEL_GRANITERAPIDS_X:
> +	case INTEL_ATOM_DARKMONT_X:
> +		if (d < REMOTE_DISTANCE)
> +			return d;
> +
> +		/*
> +		 * Trim finer distance tuning for nodes in remote package
> +		 * for the purpose of building sched domains.  Put NUMA nodes
> +		 * in each remote package in the same sched group.
> +		 * Simplify NUMA domains and avoid extra NUMA levels including
> +		 * different NUMA nodes in remote packages.
> +		 *
> +		 * GNR and CWF don't expect systmes with more than 2 packages
> +		 * and more than 2 hops between packages.
> +		 */
> +		d = sched_avg_remote_numa_distance;

So all of that avg_remote crap should live here, and in this patch. It
really should not be in generic code.

You really need to assert this 'expectation', otherwise weird stuff will
happen. The whole 'avg_remote' thing hard relies on there being a single
remote package.

> +	}
> +	return d;
> +}


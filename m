Return-Path: <linux-kernel+bounces-784183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B126FB337BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A86317E9F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0925291B;
	Mon, 25 Aug 2025 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ah8DNCxH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C5130A73
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756106759; cv=none; b=VELS8ljNZAxrlmdBPNGBvaUnvnkwQhdZDbbLxrINBg9MODFETT99qqq35u2W/2f236HbxDNywSXzg9lwRKDC8JzF7OSOoqekVJm+1pn4D1zP1CRKr+BLsEjKCcOHeWipKMou4IqF0xIKkd5eBFnB7VwNG95k8reWUwjsY0kgz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756106759; c=relaxed/simple;
	bh=AHIIU0+ZC+9R1gH0cjKqitz1FwOTVro4XBG2cFmd/Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAwI8uwSWDikxRQ9kIO/dLvdteghootTWwm3sUaCKXVqeukqOmL07FpqhJ4Z6bYEC6gWdM2075viuCrWp8RrDb8+B7Dj7g4BWGRbbQyqWDuwUOHtwU2j0eAHB5Lca9mxMHRPeFixhCs9s6O4A36/8azh/APnoVfuZltMfMCn8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ah8DNCxH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9PmugqEy/gKURug30iJO4BHRPIp9ZGM4OExCH/uyXxc=; b=ah8DNCxHFoRk+pfzPnnvPw0Xlt
	faUc6xs7UZrSSX2jEgxt2bDRtmmDUWxFXnSQ9Zun2yzu5/qg6KvjSdrSAy52FfJ68suYY08HQ3jV9
	cUfu5J+kVMXRt23oF/4lklmsddTqnYn50ySJUflrjNqZHyZBV+t7e3Liifa/aMutGTGufk4UgidoP
	7tKpHdeNEKppdJrM7TafGNGG+VPZLEobImvG3VT7VX999MI9xeoA/LBxMsuy4KuXjMo1JCIvvykPD
	OsdFme4KQ+//MPDg1HpwP7MN2ZNAO3rNjxe6KRanSYFymKrRj+tmQQ7L/2wr+uIRVquy/RoWTuu04
	TbUjWy0g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqRaF-00000007OuY-0O8E;
	Mon, 25 Aug 2025 07:25:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A206330033D; Mon, 25 Aug 2025 09:25:38 +0200 (CEST)
Date: Mon, 25 Aug 2025 09:25:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
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
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/2] sched: topology: Fix topology validation error
Message-ID: <20250825072538.GP3245006@noisy.programming.kicks-ass.net>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
 <a3de98387abad28592e6ab591f3ff6107fe01dc1.1755893468.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3de98387abad28592e6ab591f3ff6107fe01dc1.1755893468.git.tim.c.chen@linux.intel.com>

On Fri, Aug 22, 2025 at 01:14:14PM -0700, Tim Chen wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> As sd_numa_mask() (the function behind tl->mask() for the NUMA levels
> of the topology) depends on the value of sched_domains_curr_level,
> it's possible to be iterating over a level while, sd_numa_mask()
> thinks we are in another, causing the topology validation to fail (for
> valid cases).
> 
> Set sched_domains_curr_level to the current topology level while
> iterating.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/topology.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 977e133bb8a4..9a7ac67e3d63 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2394,6 +2394,14 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
>  	for_each_sd_topology(tl) {
>  		int tl_common_flags = 0;
>  
> +#ifdef CONFIG_NUMA
> +		/*
> +		 * sd_numa_mask() (one of the possible values of
> +		 * tl->mask()) depends on the current level to work
> +		 * correctly.
> +		 */

This is propagating that ugly hack from sd_init(), isn't it. Except its
pretending like its sane code... And for what?

> +		sched_domains_curr_level = tl->numa_level;
> +#endif
>  		if (tl->sd_flags)
>  			tl_common_flags = (*tl->sd_flags)();
>  
		if (tl_common_flags & SD_NUMA)
			continue;

So how does this make any difference ?

We should never get to calling tl->mask() for NUMA.


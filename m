Return-Path: <linux-kernel+bounces-784383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EDDB33AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522E018868F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3852C08BF;
	Mon, 25 Aug 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WuZY0fjg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100F280CF1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113805; cv=none; b=msTsnJo+okEWCizOj7vh03TqsJ/pxJoTOlqumxNw589TL5Dx3b8ZOZpCwtz4RoVdz5oqe9rxwov1CNb0zRMhjO1eq1MZQQClvISsb8BQXcEuouw/ReBjz6lAne4C2vGGL55jIsgYh/uBKkAZC4oKk60+wSOY6JdHdjeK/0m7258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113805; c=relaxed/simple;
	bh=mbiywVb4Wrg7M/IiTpe1OcjcESnXshqvkDIvakmHVus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0uTrcmgcPQgTH7DlUTA8kE1t8vaE+qHGRVJFJafNJTOG8prQq8jcuV0gdHCsYVQ+R+QuRYO4QQ2g5crvCTtxeBCds+zUEu6p+7F1Vtr9ECWki1ZEKn4rBs1jLKpB8Tad1jxzn0wcLGeAOu2xGkOkRJXsll8RY9RGXLoNaJxP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WuZY0fjg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3rGRqOlzNkFuqNDj9PPNc1mEXzy/nDP4b5Hqzb6LomE=; b=WuZY0fjgjsRQSUb3Yp+u+r0GYL
	UNyvaEdeHEoAvO887vh5/HNkMkxttH5QYK2cxG4j9M9583Pvr9bTRHs0HMriat+XxEmnMDd6rLmZ4
	fudsVPkShH2T4QGxemYsi8csP6iwuvWvI/lVZMnwzQet2cuDFADJ/uuraZ3yp5oAOwgkFBJzlr5od
	bkgtiRYVwGMS/AW2x5ngD2t+247XlDX8Qy9p4vFJV4yGb1U8OZDeSqW3yuJfjDGmhsv0UX6ISrTHd
	FCdCiuC40dqBZvBXEm0BXY4DiPo9cPnYOoDigT/dX3OiCYTpIKvR5sGd1lcBrjyfwPT3DsfZCEsar
	5dzr/2qA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTPz-00000009usz-1IqE;
	Mon, 25 Aug 2025 09:23:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7E1263002ED; Mon, 25 Aug 2025 11:23:11 +0200 (CEST)
Date: Mon, 25 Aug 2025 11:23:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Libo Chen <libo.chen@oracle.com>,
	Abel Wu <wuyun.abel@bytedance.com>, Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/2] sched: topology: Fix topology validation error
Message-ID: <20250825092311.GH4068168@noisy.programming.kicks-ass.net>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
 <a3de98387abad28592e6ab591f3ff6107fe01dc1.1755893468.git.tim.c.chen@linux.intel.com>
 <67c2b6bc-7a05-46a5-a409-a51f28f94c64@amd.com>
 <20250825075807.GR3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825075807.GR3245006@noisy.programming.kicks-ass.net>

On Mon, Aug 25, 2025 at 09:58:07AM +0200, Peter Zijlstra wrote:
> On Mon, Aug 25, 2025 at 08:48:29AM +0530, K Prateek Nayak wrote:
> > Hello Tim, Vinicius,
> > 
> > On 8/23/2025 1:44 AM, Tim Chen wrote:
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -2394,6 +2394,14 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
> > >  	for_each_sd_topology(tl) {
> > >  		int tl_common_flags = 0;
> > >  
> > > +#ifdef CONFIG_NUMA
> > > +		/*
> > > +		 * sd_numa_mask() (one of the possible values of
> > > +		 * tl->mask()) depends on the current level to work
> > > +		 * correctly.
> > > +		 */
> > > +		sched_domains_curr_level = tl->numa_level;
> > > +#endif
> > 
> > A similar solution was proposed in [1] and after a few iterations, we
> > arrived at [2] as a potential solution to this issue. Now that the merge
> > window is behind us, Peter would it be possible to pick one of these up?
> > 
> > P.S. Leon has confirmed this solved the splat of their deployments too
> > on an earlier version [3].
> > 
> > [1] https://lore.kernel.org/lkml/20250624041235.1589-1-kprateek.nayak@amd.com/
> > [2] https://lore.kernel.org/lkml/20250715040824.893-1-kprateek.nayak@amd.com/
> > [3] https://lore.kernel.org/lkml/20250720104136.GI402218@unreal/
> 
> I'm sure that's stuck somewhere in my holiday backlog ... Let me go try
> and find it.

Replied there.

  https://lkml.kernel.org/r/20250825091910.GT3245006@noisy.programming.kicks-ass.net


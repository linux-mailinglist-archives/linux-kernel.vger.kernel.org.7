Return-Path: <linux-kernel+bounces-855677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE1BE1F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4659C3B302F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0972C2FABFE;
	Thu, 16 Oct 2025 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YTFbDkD2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E618024
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600466; cv=none; b=GXCL9SzmObrFTdrolNT69i/PwrwsWsNMuShB5roGXlqaUWUm1X67EiZSggvPn1FiMaikPrHmq7bF43iq0/YTURfECWka/yHn5U9ZWMkx6YT/PwRkd89WyTuciZpH+l1NOvkAnHBw2EM5Fz6fTnQI0vOdtG4pU4CojMd3W9gfPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600466; c=relaxed/simple;
	bh=Fup1vFbNmBkUZQoA3QUEeql7GGJw+t+MaKUfaCBQc6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhXj9i4SBtIS8sr2quLFcTHpegyUvyHxeJxUxJeSIixL5cehLNknrCZ+WycyzFhxgfrzo0ffyHoelsoK1SxckwDEzjS2jgLirRLaGJ1bqxMzFoZBNbsKLtwVyeYlsU8IvLSMkLgWzentxw5qeH9QF2pc9PNOWL5nHfpPOMiOr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YTFbDkD2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+W0C4tyTouRQMMSvh/W0piKcep9xR4b682+mPek2OrY=; b=YTFbDkD2EupxuCaBsij4QRxCte
	b3axQhOpHdYsBo61wjP6mT4Bj4ZGxwKFgn6gahBBmiFhq8DgkKcXaEIFPm6A+IjfPPSJk8V54rI0i
	tvdhrV6G133pYhR2Wu00o77KkRm8Vp+8mIdl4gm3SuY2gY8MTs2rQMI0LzkhFamMa9sGhVnoLrMkZ
	2XRHLySI2zg4Kh8RcsiLTCq5v3U4L77KhDafqGDbHM0D62fZA9wvVn0c75tAaf7ZJQ2dsr5ClFKO/
	d4yFNdOBNBeT72wKrMqGQY5HGDQqnKjAVUNScz9ga94bMXxfNiQleT9WdNJG4lpgxfNtNAtyxzhzH
	QRbxsfjg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9Ib9-0000000GQoI-2KfR;
	Thu, 16 Oct 2025 07:40:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 513333001D4; Thu, 16 Oct 2025 09:40:32 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:40:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
Message-ID: <20251016074032.GX3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015110450.GO3289052@noisy.programming.kicks-ass.net>
 <15b871f2-49b8-4b62-926d-31f93ad49f51@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15b871f2-49b8-4b62-926d-31f93ad49f51@intel.com>

On Thu, Oct 16, 2025 at 12:25:27AM +0800, Chen, Yu C wrote:
> On 10/15/2025 7:04 PM, Peter Zijlstra wrote:
> > On Sat, Oct 11, 2025 at 11:24:41AM -0700, Tim Chen wrote:
> > > From: Chen Yu <yu.c.chen@intel.com>
> > > 
> > > Enable cache-aware load balancing only if at least 1 NUMA node has
> > > more than one LLC.
> > > 
> > > Suggested-by: Libo Chen <libo.chen@oracle.com>
> > > Suggested-by: Adam Li <adamli@os.amperecomputing.com>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > ---
> > >   kernel/sched/fair.c     | 15 ++++++++++++---
> > >   kernel/sched/sched.h    |  1 +
> > >   kernel/sched/topology.c | 14 ++++++++++++--
> > >   3 files changed, 25 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index cd080468ddc9..3d643449c48c 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -1208,6 +1208,14 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
> > >   __read_mostly unsigned int llc_overload_pct       = 50;
> > >   __read_mostly unsigned int llc_imb_pct            = 20;
> > > +DEFINE_STATIC_KEY_FALSE(sched_cache_allowed);
> > > +
> > > +static inline bool sched_cache_enabled(void)
> > > +{
> > > +	return sched_feat(SCHED_CACHE) &&
> > > +		static_branch_likely(&sched_cache_allowed);
> > > +}
> > 
> > Urgh; do we really need _2_ static keys stacked for this? I'm thinking
> > one should be well enough.
> 
> SCHED_CACHE allows user space to turn on/off the feature at runtime,
> while sched_cache_allow is a hardware capability. This capability is
>  disabled if there are no multiple LLCs within one node. I’m not sure
> if using one key could support the above two scenarios.

Of course it can! There is one decision 'is cache aware crap enabled',
you only need one branch for that. You just need to make the code that
sets the branch state a little more complicated.

Things like sysctl/kernel/sched_schedstats
sysctl/kernel/sched_energy_aware debugfs/sched/numa_balancing all work
like this.

Take the sched_energy_aware one, that is very similar; it will only
enable if the topology supports energy aware stuff. But then still lets
userspace disable it.

Same for this. The static branch condition should be:
'topology-has-multi-llc && userspace-wants-it'.


Return-Path: <linux-kernel+bounces-784220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B86D7B3384E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912CB18960D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED47298CD5;
	Mon, 25 Aug 2025 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dOJZKwj4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F562882CC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108621; cv=none; b=pNagsJEJ3En33Uy0Lr4mpVVfH9g7q60A03r7tInTAcKtmk0/scDKaMe7cJSRt8MRfoHPBRRA2onXZWp/4XcIk3IYUxtdtKZkWHtjy6EYkSFQsVCtdynJtpt1cYOLus2OpNeA3RNdK252uwKN4vuIEX0h9Lbfqguh/BHLC5d9isw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108621; c=relaxed/simple;
	bh=zrR7XMABDhMTJECD45nVsjYnWUp0Y6PS7dMmGjtm0uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5vQOICBQXph69BW1rH0wrzSdb3ixZ9WAMclRGu0mS792G6jRubx6iGYB5HyFeE9CzKUPjQnB3KV4XCNWjfQCkA69E/coQk+ufHyjjHt3Tkrty6gf4tBHMWv0rls2MoBzpEoGIEfePq1iVt6/9xGPdILtSMkNFivjHYES3LlDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dOJZKwj4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ougs+rHCkaIhdPeCZhoUIh51Oe7lb1hKIxpeB732pMs=; b=dOJZKwj46s4J/aP7YGV4XRtUOU
	3M2VV0S72VkYk4ykDAlZXTDOcbBor9m6mb2fWfia8v2/gl04AJA9sAfbbesPC3uToYoo5BNf+2i/Q
	kGcUseYn6cIOncmE11VGEYIjv8jiN7CWqIPGiL+bdW0EBurGX5Lro0HDG8R17QGeOm/Y8BaSQDldO
	N26YUYyZKBRIdU8fsHCWyKhMLnlKMN3dN57vznlqh07SFE8ubXk7IjXIkF9mEpFSOZnh/gPO10utW
	WAx+X4uQzpmtuP30WESyQ07yMUZhWXtGyHmdLEkPMDwW03Y2TlwlA2n+CugPH6PLpheVdzfAJcg8j
	Y2KLi49g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqS4I-000000082Ft-1tKI;
	Mon, 25 Aug 2025 07:56:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 349CC3002ED; Mon, 25 Aug 2025 09:56:42 +0200 (CEST)
Date: Mon, 25 Aug 2025 09:56:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Libo Chen <libo.chen@oracle.com>,
	Abel Wu <wuyun.abel@bytedance.com>, Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Chen Yu <yu.chen.surf@foxmail.com>
Subject: Re: [PATCH 2/2] sched: Fix sched domain build error for GNR-X, CWF-X
 in SNC-3 mode
Message-ID: <20250825075642.GQ3245006@noisy.programming.kicks-ass.net>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
 <86ddfe75510497829a84e696b29bfdd7a4940009.1755893468.git.tim.c.chen@linux.intel.com>
 <c03c0137-931f-4dc9-b2c6-d01d4eb60010@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03c0137-931f-4dc9-b2c6-d01d4eb60010@intel.com>

On Mon, Aug 25, 2025 at 01:08:39PM +0800, Chen, Yu C wrote:
> On 8/23/2025 4:14 AM, Tim Chen wrote:
> > It is possible for Granite Rapids X (GNR) and Clearwater Forest X
> > (CWF) to have up to 3 dies per package. When sub-numa cluster (SNC-3)
> > is enabled, each die will become a separate NUMA node in the package
> > with different distances between dies within the same package.
> > 
> > For example, on GNR-X, we see the following numa distances for a 2 socket
> > system with 3 dies per socket:
> > 
> >          package 1       package2
> >              ----------------
> >              |               |
> >          ---------       ---------
> >          |   0   |       |   3   |
> >          ---------       ---------
> >              |               |
> >          ---------       ---------
> >          |   1   |       |   4   |
> >          ---------       ---------
> >              |               |
> >          ---------       ---------
> >          |   2   |       |   5   |
> >          ---------       ---------
> >              |               |
> >              ----------------
> > 
> > node distances:
> > node     0    1    2    3    4    5
> >     0:   10   15   17   21   28   26
> >     1:   15   10   15   23   26   23
> >     2:   17   15   10   26   23   21
> >     3:   21   28   26   10   15   17
> >     4:   23   26   23   15   10   15
> >     5:   26   23   21   17   15   10
> > 

> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 33e166f6ab12..c425e84c88b5 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -515,6 +515,34 @@ static void __init build_sched_topology(void)
> >   	set_sched_topology(topology);
> >   }
> > +int sched_node_distance(int from, int to)
> > +{
> > +	int d = node_distance(from, to);
> > +
> > +	if (!x86_has_numa_in_package)
> > +		return d;
> > +
> > +	switch (boot_cpu_data.x86_vfm) {
> > +	case INTEL_GRANITERAPIDS_X:
> > +	case INTEL_ATOM_DARKMONT_X:
> > +		if (d < REMOTE_DISTANCE)
> > +			return d;
> > +
> > +		/*
> > +		 * Trim finer distance tuning for nodes in remote package
> > +		 * for the purpose of building sched domains.
> > +		 * Put NUMA nodes in each remote package in a single sched group.
> > +		 * Simplify NUMA domains and avoid extra NUMA levels including different
> > +		 * NUMA nodes in remote packages.
> > +		 *
> > +		 * GNR-x and CWF-X has GLUELESS-MESH topology with SNC
> > +		 * turned on.
> > +		 */
> > +		d = (d / 10) * 10;
> 
> Does the '10' here mean that, the distance of the hierarchy socket
> is 10 from SLIT table? For example, from a socket0 point of view,
> the distance of socket1 to socket0 is within [20, 29), the distance
> of socket2 to socket0 is [30,39), and so on. If this is the case,
> maybe add a comment above for future reference.

This is all because of the ACPI SLIT distance definitions I suppose, 10
for local and 20 for remote (which IMO is actively wrong, since it
mandates distances that are not relative performance).

Additionally, the table above magically has all the remote distances in
the range of [20,29] and so the strip 1s thing works.

The problem of course is that the SLIT table is fully under control of
the BIOS and random BIOS monkey could cause this to not be so making the
above code not work as intended. Eg. if the remote distances ends up
being in the range of [20,35] or whatever, then it all goes sideways.

( There is a history of manupulating the SLIT table to influence
scheduler behaviour of OS of choice :-/ )

Similarly, when doing a 4 node system, it is possible a 2 hop distances
doesn't align nicely with the 10s and we're up a creek again.

This is all very fragile. A much better way would be to allocate a new
SLIT table, identify the (local) clusters and replace all remote
instances with an average.

Eg. since (21+28+26+23+26+23+26+23+21)/9 ~ 24, you end up with:

 node     0    1    2    3    4    5
     0:   10   15   17   24   24   24
     1:   15   10   15   24   24   24
     2:   17   15   10   24   24   24
     3:   24   24   24   10   15   17
     4:   24   24   24   15   10   15
     5:   24   24   24   17   15   10




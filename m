Return-Path: <linux-kernel+bounces-680476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EABAD45FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 00:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24234178873
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 22:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D4925D546;
	Tue, 10 Jun 2025 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qm5Pm4O7"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15B1442F4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594680; cv=none; b=A8w6R7cVOPfpjSuOd+M+4Nnen0MHpb6qpS1+6napIQtwJHeh6Q1W9TvNic9/I3cmMYDT+2K5b9mpB2TAYo0kjP+xh7Qm6rVSqE2JAP67pzcuD+lDRxiga/qzIvbPi7GlEhMM1o6CY7s029dmsetsiFChfeSQ79A3i02Qns5laQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594680; c=relaxed/simple;
	bh=MRCA5gigBB12gHq8b+uPLnP70ZYR7F2Kp2X02sHv340=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp1xzaXp0rig4l9IHC/IvvQSciksiqXEoUrnn6oq1k3T67fmbHMZ/tl6JWjyBE2A3EkhN2o8gJbH7gNnmO7BmAuhNJ9kQwsEYampmKqL/URX+QRsEo67yNZegcaMgDa5p85tzSq9owon8mcvSTZ7a+KRZZ/sTfYwE3w8w81JfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qm5Pm4O7; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Jun 2025 15:31:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749594674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vd5c7+zpIFxx088X8wapBIhJBo1Up9NuD1sLD2mdoiU=;
	b=qm5Pm4O7hNmP8p6fGEp8Cj96t7jzkuSBcT1Whh4vxvdY2C9QUf/qLN5wleStRoeAb2OLTm
	93HjPupqxMfpEWRpne2BzfFyvjP6oOZO1Op/rHGAmJXIuKKe7FYZ+n5hlbd2F0zcr3lfSc
	ULqNBOaxu3iWDDdEWvtGThgfwXWYZeE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/3] cgroup: make css_rstat_updated nmi safe
Message-ID: <35ppn2muk4bsyosca4nxnbv5l6qv4ov2cxg5ksypst5ldf5zc4@vwrpziws4wjy>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
 <20250609225611.3967338-3-shakeel.butt@linux.dev>
 <aEijC1iHehAxdsfi@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEijC1iHehAxdsfi@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 10, 2025 at 11:26:35AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jun 09, 2025 at 03:56:10PM -0700, Shakeel Butt wrote:
> ...
> > +	self = &rstatc->lnode;
> > +	if (!try_cmpxchg(&(rstatc->lnode.next), &self, NULL))
> >  		return;
> >  
> > +	llist_add(&rstatc->lnode, lhead);
> 
> I may be missing something but when you say multiple inserters, you mean the
> function being re-entered from stacked contexts - ie. process context, BH,
> irq, nmi?

Yes.

> If so, would it make sense to make the nmi and non-nmi paths use
> separate lnode? In non-nmi path, we can just disable irq and test whether
> lnode is empty and add it. nmi path can just test whether its lnode is empty
> and add it. I suppose nmi's don't nest, right? If they do, we can do
> try_cmpxchg() there I suppose.
> 
> While the actual addition to the list would be relatively low frequency,
> css_rstat_updated() itself can be called pretty frequently. Before, the hot
> path was early exit after data_race(css_rstat_cpu(css, cpu)->updated_next).
> After, the hot path is now !try_cmpxchg() which doesn't seem great.
> 

Couple of lines above I have llist_on_list(&rstatc->lnode) check which
should be as cheap as data_race(css_rstat_cpu(css, cpu)->updated_next). 
So, I can add lnode for nmi and non-nmi contexts (with irqs disabled)
but I think that is not needed. Actually I ran the netperf benchmark (36
parallel instances) and I see no significant differences with and
without the patch.

Thanks for taking a look.
Shakeel


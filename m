Return-Path: <linux-kernel+bounces-636644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C6AACE09
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 21:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1168523A44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815182B2CF;
	Tue,  6 May 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WgHMedeS"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C793B1AB
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559829; cv=none; b=sSKGaiVfSS4PQ1LV0kT2RxQd8D/6NJj0VlA4fZoMlqYM5cnp2I0dIKY+BrCxpLSYhKuk72tuNgI/KCGuHj05gVAEn1gdh2j5rotWAiNwwN7sfy3CWGuSC2y37FDI0AH1Hzq/fPuWAai3FN9DluqkJc7YtYPs6A4lHgk4o0jZTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559829; c=relaxed/simple;
	bh=evOuE7aB+74YsfoELzd7nolFPAtsEaVvGiSs0mHtAbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjO/x2GR2McNQ4oQApxvwfqd7A1m91mXD9hnt0aRJrmXrwizQmNU/Z/0p540OfD2gcOIZ8JlRKTA2djz9REEBhXlaMfVrstISsRQ9JV2ezBQL0HAB3MHx0m4BfXu4ucNOXrvZwh+K3OiXdi40jb6uvgt+28plv/Kv6qz2dmfVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WgHMedeS; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 May 2025 12:30:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746559824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Db7MspoP+g08mHEp6RilCFjIi85bP/lhDWJS4kUMnGA=;
	b=WgHMedeStoJSRNGI5VPxIeFmszKMKGVN84MrVLAxJ/1hLXKDKsbQ+ltgT4OqupjK1mnVnh
	YmFcqpGYpnyHXjUXEWg2gUz/ypJXo6z5pm+YzOdHFSGWcgT7d/KHDKxNng5Gdn05emiz4h
	SlUp/GBNVP0wd2MFonT/+O6b3MOwKro=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] cgroup: make css_rstat_updated nmi safe
Message-ID: <mie6pn3q4epjgfm4kdilqmx55d6zowpmf7tfjm6a3bxuilza7y@nmt7xr3vctbu>
References: <20250429061211.1295443-1-shakeel.butt@linux.dev>
 <20250429061211.1295443-4-shakeel.butt@linux.dev>
 <aBIiNMXIl6vyaNQ6@Asmaa.>
 <6u7ccequ5ye3e4iqblcdeqsigindo3xjpsvkdb6hyaw7cpjddc@u2ujv7ymlxc6>
 <aBnZMBJ-OOEXvpUa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBnZMBJ-OOEXvpUa@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 06, 2025 at 09:41:04AM +0000, Yosry Ahmed wrote:
> On Thu, May 01, 2025 at 03:10:20PM -0700, Shakeel Butt wrote:
> > On Wed, Apr 30, 2025 at 06:14:28AM -0700, Yosry Ahmed wrote:
> > [...]
> > > > +
> > > > +	if (!_css_rstat_cpu_trylock(css, cpu, &flags)) {
> > > 
> > > 
> > > IIUC this trylock will only fail if a BPF program runs in NMI context
> > > and tries to update cgroup stats, interrupting a context that is already
> > > holding the lock (i.e. updating or flushing stats).
> > > 
> > 
> > Correct (though note that flushing side can be on a different CPU).
> > 
> > > How often does this happen in practice tho? Is it worth the complexity?
> > 
> > This is about correctness, so even a chance of occurance need the
> > solution.
> 
> Right, my question was more about the need to special case NMIs, see
> below.
> 
> > 
> > > 
> > > I wonder if it's better if we make css_rstat_updated() inherently
> > > lockless instead.
> > > 
> > > What if css_rstat_updated() always just adds to a lockless tree,
> > 
> > Here I assume you meant lockless list instead of tree.
> 
> Yeah, in a sense. I meant using lockless lists to implement the rstat
> tree instead of normal linked lists.
> 
> > 
> > > and we
> > > defer constructing the proper tree to the flushing side? This should
> > > make updates generally faster and avoids locking or disabling interrupts
> > > in the fast path. We essentially push more work to the flushing side.
> > > 
> > > We may be able to consolidate some of the code too if all the logic
> > > manipulating the tree is on the flushing side.
> > > 
> > > WDYT? Am I missing something here?
> > > 
> > 
> > Yes this can be done but I don't think we need to tie that to current
> > series. I think we can start with lockless in the nmi context and then
> > iteratively make css_rstat_updated() lockless for all contexts.
> 
> My question is basically whether it would be simpler to actually make it
> all lockless than special casing NMIs. With this patch we have two
> different paths and a deferred list that we process at a later point. I
> think it may be simpler if we just make it all lockless to begin with.
> Then we would have a single path and no special deferred processing.
> 
> WDYT?

So, in the update side, always add to the lockless list (if not already)
and on the flush side, built the udpate tree from the lockless list and
flush it. Hopefully this tree building and flushing can be done in a
more optimized way. Is this what you are suggesting?


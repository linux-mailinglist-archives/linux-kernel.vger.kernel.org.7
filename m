Return-Path: <linux-kernel+bounces-777725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D4BB2DD21
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F6D04E22BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C5331A042;
	Wed, 20 Aug 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="lT0lBpYf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ghRXDfDR"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA73308F11
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694704; cv=none; b=rBSKqf7i4UTEbM2HZrjKi4vmTok73lkhkdJ7lKEHM5gs92jDwAj4mNxenkGWysze6BYEjWMwdkdmp+pUcfJursVZiw8mhb4B1hRI7XEKEK7Z1B6XaaiaUcua6uVISCLjRbyHIIkUonOAR18K7JB0MRJMGZi5zVNIEzaAwA4azgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694704; c=relaxed/simple;
	bh=+I4+TkLLbHArQp0sRrr2pPuND6uRxKXdIx4RVwLLJGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0XtMWsxUhF9KiLgjWNu9lQvW77FJjLD67kICW0YUDjpuNXqnbXcEX6WCP0oP3cTYgHTsiuUq78vrq+iFt3BL7FigROnANEFgz7nXKU8lWN30xPyHUu4nPKQ3umKVjrlXFmFpsI1eWLe4F5VLTQNtuQBGvpstqIa7sCC4DAizM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=lT0lBpYf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ghRXDfDR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 9BB76EC08CA;
	Wed, 20 Aug 2025 08:58:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 20 Aug 2025 08:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1755694700; x=
	1755781100; bh=0wsGx0mAlZVoMlqY3YzRKD0yjauwkX1n/YWAvB+PZcA=; b=l
	T0lBpYfanUhN9GxgC5VP7dA3SFHzSpFOxvKxKVPNyW85QOaYSCAcEhdJ5ndmDwzM
	mQ2vRxIT212ZPeGogVoiujTXPhWjFSFOHwXfoe5iXbhDmjUpCC6wUj5Ohel2tEpw
	9SsikI3ltYXtSMRxoSxlqC3vAFKOKDSs+95ReOoaUwEaIBhb8D0/Tm7QZZdMP1Rs
	B4xv3P02KaybnlZbv6+2NJJu9LSE5/Bjp9FKZpWFtFn1gAiHXreLVGKXUYwP05uq
	ancKxTKw8jtNq7H2QfgoW1juLVqEVYf4YOxXIjq1CCfQA/mcKwXTIdwJ4yVBWLk5
	1mVNYZF9rfpX2vjmrNPtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755694700; x=1755781100; bh=0wsGx0mAlZVoMlqY3YzRKD0yjauwkX1n/YW
	AvB+PZcA=; b=ghRXDfDR6cq4ZaBhAqZTkfK91U5D2lmmmQCOwhvTr1gFm39pSkv
	Mob3O9d+wqkBskkxXQP2HvHGZJhMAOkLDIzcK+M0p6CsinFIa80FrcBgRZxx9hrk
	UnBpXgPNIK7v3hacqwyYuCksNmrykR6W0IpWJmy7SI9xp59GQ9QhGvAZ2RVqEAuf
	+BJUZz62xzplL6bCMoRy/CS41I1Fx+RN2LD5XkfShQlzFyeH1gyjO8o5ubvMhV7j
	GGOISeZiLBevWcN2uLVc28psZQgEV6/x7gtRdbaa+92erBmaSrCISy+FUiSOr37u
	o3gacTzobQcoxkhgprzcO+zQBoqnBIvsKLg==
X-ME-Sender: <xms:a8alaO7m6bzlkI-e5GAgu826TdPmhkSO3oSjDw8YwlGYIfauW6VT-w>
    <xme:a8alaD_Yd9nsUiXAt1SUa2u1ACqAx0BuTYqIL2xeP73e0o4tcppx4aNlvy-svqW6B
    XF20NyTb3pKpTXS9sI>
X-ME-Received: <xmr:a8alaIyi0pmAb_bpMXJ8a9zVLfH0rUGAga247GmZ_a65t7OB6dRRv9mewVSu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhrghkvggvlhdrsghuthhtse
    hlihhnuhigrdguvghvpdhrtghpthhtohepjhhoshhhuhgrrdhhrghhnhhjhiesghhmrghi
    lhdrtghomhdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdrohhrghdprhgtph
    htthhopegtlhhmsehfsgdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhho
    uhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipd
    hrtghpthhtohepshhurhgvnhgssehgohhglhgvrdgtohhmpdhrtghpthhtohepmhhhohgt
    khhosehsuhhsvgdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghhoohhglhgvrd
    gtohhm
X-ME-Proxy: <xmx:a8alaKFaNQIAE1_v9rISkD9ON5DAaeweWQiDe3JYR6YI5fAEtLX-XQ>
    <xmx:a8alaLO7cismCRVmooK_wrIYqEMEUL5Cssc2uzzKFNuFJRW980L-Mg>
    <xmx:a8alaBfEWC6ONWM9Pr6UdWmbS2hTXchelQ7MN2cfadebezcPvHidiw>
    <xmx:a8alaATf3BqwDkC0B5FoahWuxdG3L3puwiqIGM-S-c9NhmyMC8snXQ>
    <xmx:bMalaGpUTqr-rMEyOLbMK1kqqL-_OJ4uc-AAPIDuQrPeuhMRp7o_QRXP>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 08:58:18 -0400 (EDT)
Date: Wed, 20 Aug 2025 13:58:15 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@gogle.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in
 batch freeing
Message-ID: <wuuz7itgcjb7vu466k6nwxfjiy4ytx7ip3yvauqucwlpqqibri@bpxnpevzermg>
References: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
 <k6fpx5adh45t4jrxgiccq7acubwcgmi746crggxi6e4oihtvpt@thks5zrn53n3>
 <x3xp3cj6wpgxu5mjsd62fzvuzpn2mxpvlk6sau65si7bk6ncu5@dx6jbuacy42i>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x3xp3cj6wpgxu5mjsd62fzvuzpn2mxpvlk6sau65si7bk6ncu5@dx6jbuacy42i>

On Tue, Aug 19, 2025 at 10:15:39AM -0700, Shakeel Butt wrote:
> On Tue, Aug 19, 2025 at 10:15:13AM +0100, Kiryl Shutsemau wrote:
> > On Mon, Aug 18, 2025 at 11:58:03AM -0700, Joshua Hahn wrote:
> > > While testing workloads with high sustained memory pressure on large machines
> > > (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> > > Further investigation showed that the lock in free_pcppages_bulk was being held
> > > for a long time, even being held while 2k+ pages were being freed.
> > > 
> > > Instead of holding the lock for the entirety of the freeing, check to see if
> > > the zone lock is contended every pcp->batch pages. If there is contention,
> > > relinquish the lock so that other processors have a change to grab the lock
> > > and perform critical work.
> > 
> > Hm. It doesn't necessary to be contention on the lock, but just that you
> > holding the lock for too long so the CPU is not available for the scheduler.
> > 
> > > In our fleet, we have seen that performing batched lock freeing has led to
> > > significantly lower rates of softlockups, while incurring relatively small
> > > regressions (relative to the workload and relative to the variation).
> > > 
> > > The following are a few synthetic benchmarks:
> > > 
> > > Test 1: Small machine (30G RAM, 36 CPUs)
> > > 
> > > stress-ng --vm 30 --vm-bytes 1G -M -t 100
> > > +----------------------+---------------+-----------+
> > > |        Metric        | Variation (%) | Delta (%) |
> > > +----------------------+---------------+-----------+
> > > | bogo ops             |        0.0076 |   -0.0183 |
> > > | bogo ops/s (real)    |        0.0064 |   -0.0207 |
> > > | bogo ops/s (usr+sys) |        0.3151 |   +0.4141 |
> > > +----------------------+---------------+-----------+
> > > 
> > > stress-ng --vm 20 --vm-bytes 3G -M -t 100
> > > +----------------------+---------------+-----------+
> > > |        Metric        | Variation (%) | Delta (%) |
> > > +----------------------+---------------+-----------+
> > > | bogo ops             |        0.0295 |   -0.0078 |
> > > | bogo ops/s (real)    |        0.0267 |   -0.0177 |
> > > | bogo ops/s (usr+sys) |        1.7079 |   -0.0096 |
> > > +----------------------+---------------+-----------+
> > > 
> > > Test 2: Big machine (250G RAM, 176 CPUs)
> > > 
> > > stress-ng --vm 50 --vm-bytes 5G -M -t 100
> > > +----------------------+---------------+-----------+
> > > |        Metric        | Variation (%) | Delta (%) |
> > > +----------------------+---------------+-----------+
> > > | bogo ops             |        0.0362 |   -0.0187 |
> > > | bogo ops/s (real)    |        0.0391 |   -0.0220 |
> > > | bogo ops/s (usr+sys) |        2.9603 |   +1.3758 |
> > > +----------------------+---------------+-----------+
> > > 
> > > stress-ng --vm 10 --vm-bytes 30G -M -t 100
> > > +----------------------+---------------+-----------+
> > > |        Metric        | Variation (%) | Delta (%) |
> > > +----------------------+---------------+-----------+
> > > | bogo ops             |        2.3130 |   -0.0754 |
> > > | bogo ops/s (real)    |        3.3069 |   -0.8579 |
> > > | bogo ops/s (usr+sys) |        4.0369 |   -1.1985 |
> > > +----------------------+---------------+-----------+
> > > 
> > > Suggested-by: Chris Mason <clm@fb.com>
> > > Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > > 
> > > ---
> > >  mm/page_alloc.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index a8a84c3b5fe5..bd7a8da3e159 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1238,6 +1238,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> > >  	 * below while (list_empty(list)) loop.
> > >  	 */
> > >  	count = min(pcp->count, count);
> > > +	if (!count)
> > > +		return;
> > >  
> > >  	/* Ensure requested pindex is drained first. */
> > >  	pindex = pindex - 1;
> > > @@ -1247,6 +1249,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> > >  	while (count > 0) {
> > >  		struct list_head *list;
> > >  		int nr_pages;
> > > +		int batch = min(count, pcp->batch);
> > >  
> > >  		/* Remove pages from lists in a round-robin fashion. */
> > >  		do {
> > > @@ -1267,12 +1270,22 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> > >  
> > >  			/* must delete to avoid corrupting pcp list */
> > >  			list_del(&page->pcp_list);
> > > +			batch -= nr_pages;
> > >  			count -= nr_pages;
> > >  			pcp->count -= nr_pages;
> > >  
> > >  			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
> > >  			trace_mm_page_pcpu_drain(page, order, mt);
> > > -		} while (count > 0 && !list_empty(list));
> > > +		} while (batch > 0 && !list_empty(list));
> > > +
> > > +		/*
> > > +		 * Prevent starving the lock for other users; every pcp->batch
> > > +		 * pages freed, relinquish the zone lock if it is contended.
> > > +		 */
> > > +		if (count && spin_is_contended(&zone->lock)) {
> > 
> > I would rather drop the count thing and do something like this:
> > 
> > 		if (need_resched() || spin_needbreak(&zone->lock) {
> > 			spin_unlock_irqrestore(&zone->lock, flags);
> > 			cond_resched();
> 
> Can this function be called from non-sleepable context?

No, it cannot.

And looking at the locking context -- caller holds pcp->lock -- looks
like my proposal with need_resched()/cond_resched() doesn't work.

We need to either push for wider rework and make cond_resched() happen
upper by the stack or ignore it and have cpu_relax() called on the lock
drop.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


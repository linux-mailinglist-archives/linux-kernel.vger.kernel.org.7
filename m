Return-Path: <linux-kernel+bounces-854498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF396BDE848
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4416504C91
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD531C3BE0;
	Wed, 15 Oct 2025 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fI/btDQ+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D688A1AA1F4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532171; cv=none; b=NiqUwQOrfiKtAPLHQLwmz8DG9KYKKL4J4uxDCbfVwdi88UjfZ1A0p4hZwB01RQCRNa1ppp2N0ln7PivUHHZQy2HXGdt0J4r7gB56j2eRTWh/xQNwOHKCcqDagmzcE0Y2pAq+wKFxRH8Un007ONCpYHcdVEBPawYTG7I3hm586vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532171; c=relaxed/simple;
	bh=j7g19LkkBRNKphGE70ZdVHJG/RQkQfyoNt7/TZZy6a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/kUNihP1jD+3HFVLA7ulVRIVL1MhQhblcgT4nITSLkbCrvujeetcWzxO5R+93c2KSAbymT0wgQ8f/GW2ZkV8bJDJUBwEl1Vv6QAA/YfEczIDozarax5HtGE3pthGxgZdpUL6D1VHVN1hmoY7kHm3zHJ53jNuWZ8ZnXGkFza2Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fI/btDQ+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YpvuTPdKEnG8kh0LAxrV4kemX2pr+zKEL9tcOV5VL8I=; b=fI/btDQ+F9gEXnHWCjEAcad140
	urwS1uun98p1hrl8iEQruMZQDp/zBFQmQBXo4R7HSpcZhdzduMnyZliYgxf6irVaT8nlXM4iLJIzp
	iLYcp7lv4oI5G37fONOIxl83ONG5babsrJ72ldiswk2uHDCoR9tkHaFl8IQ3k+3vk5YqEdnKKtmD3
	HGZHqEy8IX22QrnZHwzdyL7pdAfllhIavAgcgSWaL5oGZOSSoL20Qi1UDwYBN4UXlEzrA7TJSUD+h
	uu/dzmXvMuT50FUYCM+vXb13hamajcBDrWY56/uxMJbUCfmrUwVffupW2p9zaTkfSJCdig8ElmCC9
	UH14x4Rw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v90q6-0000000FRPV-0xq4;
	Wed, 15 Oct 2025 12:42:46 +0000
Date: Wed, 15 Oct 2025 13:42:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aO-Wxj7al7I-IadV@casper.infradead.org>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO9Z90vphRcyFv2n@milan>
 <aO97BjvNZNh0UV3u@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO97BjvNZNh0UV3u@fedora>

On Wed, Oct 15, 2025 at 03:44:22AM -0700, Vishal Moola (Oracle) wrote:
> On Wed, Oct 15, 2025 at 10:23:19AM +0200, Uladzislau Rezki wrote:
> > >  	int i;
> > > +	gfp_t large_gfp = (gfp & ~__GFP_DIRECT_RECLAIM) | __GFP_NOWARN;
> > > +	unsigned int large_order = ilog2(nr_pages - nr_allocated);
> > >
> > If large_order is > MAX_ORDER - 1 then there is no need even try
> > larger_order attempt.

Oh, I meant to mention that too.  Yes, this should be min(MAX_ORDER, ilog2()).

> > Maybe it is worth to drop/warn if __GFP_COMP is set also?
> 
> split_page() has a BUG_ON(PageCompound) within, so we don't need one out
> here for now.

I don't think people actually call vmalloc() with __GFP_COMP set, but
clearing it would do no harm here.

> > The concern is then if it is a waste of high-order pages. Because we can
> > easily go with a single page allocator. Whereas someone in a system can not.
> 
> I feel like if we have high order pages available we'd rather allocate
> those. Since the buddy allocator just coalesces the pages when they're
> freed again, as soon as these allocations free up we are much more
> likely to have large order pages ready to go again.

My PoV is different from either of you -- that we actually want
to allocate the high-order pages when we can because it reduces
fragmentation.  If we allocate five separate pages to satisfy a 20kB
allocation, those may come from five different 2MB pages (since they're
probably coming from the pcp lists which after a sufficiently long period
of running will be a jumble).  Whereas if we allocate an order-2 page
and an order-0 page, those can come from at most two 2MB pages.

I understand the "allocating order-0 pages helps by using up the remnants
of previous allocations" argument.  But I think on the whole we need to
be doing larger allocations where possible, not smaller ones.



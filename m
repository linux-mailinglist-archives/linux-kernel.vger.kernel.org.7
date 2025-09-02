Return-Path: <linux-kernel+bounces-797265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3931B40E21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C31F1B650A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D491A34DCCA;
	Tue,  2 Sep 2025 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+WgA7Cv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64726C384
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842770; cv=none; b=S0g7Um2ufsnHekXEzQC25zwWDpFFMy1SH2bLvtfD9VAsdxSn2GJwxFeLgq75KP8GDxrMAdVzhLxMsKcxD+pfxL6cMZJZvZ6ZkbY0MZzoNBN8uc9rFYItdPSOnnBgmGB2MpsVsZh6lUCvdRAjTD54a9fzg8ApAe7HnXzKYIPxmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842770; c=relaxed/simple;
	bh=y64uVsO1eZs6OzeU4OzgZTGsY5ypgEtXG72eVFAxEEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyGvpCTtfCC9UrEsLa4LmtbPB/vddoFNkTJyIZxP3robkKXp5F98BglKcJkYr1NsmOskJM72ur03jD78Mg0HerlSXwu1R23rDgBcjYZdQexv7XTTQtKrLlRX8hS6p+mHu3Q+6x1nUSlGlRX5LvkIEYsjLqoodtVOTeH3uHX3/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p+WgA7Cv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rlojIfTuIlTc8Wo9xot7aej39JoIWDQCWyib0x3FC3w=; b=p+WgA7CvNZSwF15FR4yWHDSRY5
	tyFVdG1asANnYNi2TkrNonIZwLmemLm+gZmA9Om8bmOO8pTsSrp0yUXdQAJdM33GAhUsGEPjABq2x
	N7c+4+0eV5eRomQ7xDtjslFzACXWtLPttzqpUNyZdAzvO4F4nxjRU5JpipP8aKEeALU5gQC66VyDh
	BOZXLPwflxiYWHMg4NB51KnENKgKOzm3nQbV1CPivSJzIlt4qeO50NHb5WB4fQbBzIv53VEvcfCH6
	mGhgyg53gHT1DkIsg4wO0PJgcmr8avjV5jN2qOV70CVDdxT04wfCf0v6F9/jVLNAXxSesaikZHlrR
	bcRbIDiw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utX3c-0000000ArnQ-16hV;
	Tue, 02 Sep 2025 19:52:44 +0000
Date: Tue, 2 Sep 2025 20:52:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: tag kernel stack pages
Message-ID: <aLdLDEW2d3hK4gUV@casper.infradead.org>
References: <20250820202029.1909925-1-vishal.moola@gmail.com>
 <96148baf-f008-449b-988b-ea4f07d18528@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96148baf-f008-449b-988b-ea4f07d18528@redhat.com>

On Thu, Aug 21, 2025 at 02:44:31PM +0200, David Hildenbrand wrote:
> On 20.08.25 22:20, Vishal Moola (Oracle) wrote:
> > Currently, we have no way to distinguish a kernel stack page from an
> > unidentified page. Being able to track this information can be
> > beneficial for optimizing kernel memory usage (i.e. analyzing
> > fragmentation, location etc.). Knowing a page is being used for a kernel
> > stack gives us more insight about pages that are certainly immovable and
> > important to kernel functionality.
> 
> It's a very niche use case. Anything that's not clearly a folio or a special
> movable_ops page is certainly immovable. So we can identify pretty reliable
> what's movable and what's not.
> 
> Happy to learn how you would want to use that knowledge to reduce
> fragmentation. :)
> 
> So this reads a bit hand-wavy.

I have a theory that we should always be attempting to do aligned
allocations if we can, falling back to individual allocations if
we can't.  This is an attempt to gather some data to inform us whether
that theory is true, and to help us measure whether any effort we
take to improve that situation is effective.

Eyeballing the output of tools/testing/page-types certainly lends
some credence to this.  On x86-64 with its 16KiB stacks and 4KiB
page size, we often see four consecutive pages allocated as type
KernelStack, and as you'd expect only about 25% of the time are they
aligned to a 16KiB boundary.  That is, at least 75% of the time they
prevent _two_ order-2 pages from being available.

As you say, they're not movable.  I'm not sure if it makes sense to
go to the effort of making them movable; it'd require interacting
with the scheduler (to prevent the task we're relocating from
being scheduled), and I don't think the realtime people would be
terribly keen on that idea.  So that isn't one of the ideas we
have on the table for improving matters.

Ideas we have been batting around:

 - Have kernel stacks try to do an order-N allocation and vmap()
   the result, fall back to current implementation
 - Have vmalloc try to do an order-N allocation, fall back down the
   orders on failure to allocate
 - Change the alloc_bulk implementation to do the order-N allocation
   and fall back

I'm sure other possibilities also exist.

> staring at [1], we allocate from vmalloc, so I would assume that these will
> be vmalloc-typed pages in the future and we cannot change the type later.
> 
> [1] https://kernelnewbies.org/MatthewWilcox/Memdescs

I see the vmalloc subtype as being a "we don't know any better" type.
We could allocate another subtype of type 0 to mean "kernel stacks"
and have it be implicit that kernel stacks are allocated from vmalloc.
This would probably require that we have a vmalloc interface that lets us
specify a subtype, which I think is probably something we'd want anyway.

I think it's fine to say "This doesn't add enough value to merge it
upstream".  I will note one minor advantage which is that typing these
pages as PGTY_kstack today prevents them from being inadvertently mapped
to userspace (whether by malicious code or innocent bug).


Return-Path: <linux-kernel+bounces-822604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88036B84428
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4386C5822EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4AA2F5A15;
	Thu, 18 Sep 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQM8OClx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89F23ABA0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193475; cv=none; b=CHFzlEpvqEQbmS5orwZyVlE92MiwC+0nPlwFe8HlPm9j7VsWjVrK3OJ8jukdOxuW6+X5Gly/4US6AscEOrLvhjNDABuweSfr8BN3yRHsR4wvScaa2Nlp4hbqYQBufKY3sluhMhat8rep7d93VDk9bPe6IrxTDeyWaBcIlnuFmJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193475; c=relaxed/simple;
	bh=NojJZ78hZ55rnnC8I9+5CwqPB0jcr195D5wT3H9zTxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6khX6a3MDk8E8plX6FZoppLYpW6tiEsYAvs7k4H5pnn7HWNU3mxqEZfOx6XyHPSouHrB8rkpuei+06gNB846I+1KCwTfP+7gcPJ+ncP7hKe4lGopVWw5GtKofwLeEnCtXMBHm6X8XkcGtZqKPsm7MFajPy1LuIoJ+fEfJDMb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQM8OClx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F35C4CEE7;
	Thu, 18 Sep 2025 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758193475;
	bh=NojJZ78hZ55rnnC8I9+5CwqPB0jcr195D5wT3H9zTxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQM8OClx5HgL5ZvYw9JdwnDSMBMqgop7DN5U1oBDH5u7NKxtvBIRZrHZpC+mii0VM
	 A/WZhFzpYbLjlUdWUz0QgklN1gUYyyKtJJASgRdpa3UzIDbMdRvFpsmopVfchHdbBt
	 Dxp7GO0SprZwOYRJYkiy7eNVYWs4EYt7Y3Mu2LDKcf1MXYmdPZZXKTWannvjeIarQV
	 /OqDRIzFlRBTEK7bSqw62VusRiNY5MASWXVeHcJWbPs+jqBMVuSt51gOluj5arU3zw
	 meNAbq1dRLWQ2kM9d5yXEXYJFe8kEWBQe8wpNRwE7pPjMEQ8+RvQgZZOfwWDd1yxDI
	 owCfxJVMadMPA==
Date: Thu, 18 Sep 2025 14:04:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] kho: replace kho_preserve_phys() with
 kho_preserve_pages()
Message-ID: <aMvnO2FH-cYzNPGl@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
 <20250917174033.3810435-3-rppt@kernel.org>
 <mafs05xdggifr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs05xdggifr.fsf@kernel.org>

Hi Pratyush,

On Thu, Sep 18, 2025 at 12:32:08PM +0200, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Wed, Sep 17 2025, Mike Rapoport wrote:
> 
> >  /**
> > - * kho_preserve_phys - preserve a physically contiguous range across kexec.
> > - * @phys: physical address of the range.
> > - * @size: size of the range.
> > + * kho_preserve_pages - preserve contiguous pages across kexec
> > + * @page: first page in the list.
> > + * @nr_pages: number of pages.
> >   *
> > - * Instructs KHO to preserve the memory range from @phys to @phys + @size
> > - * across kexec.
> > + * Preserve a contiguous list of order 0 pages. Must be restored using
> > + * kho_restore_page() on each order 0 page.
> 
> This is not true. The pages are preserved with the maximum order
> possible.
> 
> 	while (pfn < end_pfn) {
> 		const unsigned int order =
> 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> 
> 		err = __kho_preserve_order(track, pfn, order);
> 		[...]
> 
> So four 0-order pages will be preserved as one 2-order page. Restoring
> them as four 0-order pages is wrong. And my proposed patch for checking
> the magic [0] will uncover this exact bug.
> 
> I think you should either change the logic to always preserve at order
> 0, or maybe add a kho_restore_pages() that replicates the same order
> calculation.

Heh, it seems I shot myself in the foot when I suggested to move the sanity
checks to kho_restore_page() :-D

We surely don't want to preserve contiguous chunks of order-0 pages as
order 0, so kho_restore_pages() it is.
 
> [0] https://lore.kernel.org/lkml/20250917125725.665-2-pratyush@kernel.org/
> 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 117d963e677c..6ec3eaa4e8d1 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2516,8 +2516,10 @@ static int reserve_mem_kho_finalize(struct kho_serialization *ser)
> >  
> >  	for (i = 0; i < reserved_mem_count; i++) {
> >  		struct reserve_mem_table *map = &reserved_mem_table[i];
> > +		struct page *page = phys_to_page(map->start);
> > +		unsigned int nr_pages = map->size >> PAGE_SHIFT;
> >  
> > -		err |= kho_preserve_phys(map->start, map->size);
> > +		err |= kho_preserve_pages(page, nr_pages);
> 
> Unrelated to this patch, but since there is no
> kho_restore_{phys,pages}(), won't the reserve_mem memory end up with
> uninitialized struct pages, since preserved pages are
> memblock_reserved_mark_noinit()?

True, this is something we need to fix.
 
> That would also be a case for kho_restore_pages() I suppose?

Yes, just need to find the right place to stick it.
We cannot call kho_restore_pages() in reserve_mem_kho_revive() because at
that point there's still no memory map.

-- 
Sincerely yours,
Mike.


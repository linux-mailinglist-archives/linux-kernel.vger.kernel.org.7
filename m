Return-Path: <linux-kernel+bounces-820996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83249B7FFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876D95419DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5756929B8DB;
	Wed, 17 Sep 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju8TW1WS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044633C776
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118810; cv=none; b=XlEEz2fK971SBAwYamGJerdrVnmnQUXYK8jxpvjFYBbNTP1AwmpHn8kHJAZGFCd97Vsc2g8IEcNrHV3D3iBl7We5mIolenG/DQ1DqBmlm9hbHp+XAmE0Shb0W3MFS6+jCBUmkeJcRbJRjwYDS8/UdpOvvgn1+puD4gGy0T+aa2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118810; c=relaxed/simple;
	bh=1fjNIj619Fl+lLd9OP9BUcAClw93Z2hY3H7Nlzzv4Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2jcdLLUwkiwjo7oOLoyg+LmbvWUMMavZ+Wo73Fvc9sxdxicA0t6oT4BqWZMdK91at9E+81LjmrrrZAe08vOC3PD08IUQ1WxikiuRVBZsTFClGszR26jZ93LacoT8HZXwMd1xhPA4QyXpvewa46nZfYZdfCtzoiUSw07aUNgtFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju8TW1WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2755DC4CEE7;
	Wed, 17 Sep 2025 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758118810;
	bh=1fjNIj619Fl+lLd9OP9BUcAClw93Z2hY3H7Nlzzv4Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ju8TW1WScXt7+y9B+mBjAUjPB6rGDTaKFMxURMULY0VyrjYthHysu2s88SjtAJQpG
	 mzP4tBVg1zaZTFh3yqoccghCFL1QjSbWjaZW1CqldgddDSlBbXb/wMHtWCZpKSSwRc
	 2X4S0ARuzdLtzIs1qqD7yN6tNmCSlr0WGuJgPHrAvYLhbrowIQMhFv8rTsEgQX/OiR
	 aJfA6WGjh5POC9hS56bLHgvApJENr5TlMIYpqBE6VkavRK1t2V1THv+eYVAFXXZGbr
	 cneR41EUGbtu7cVpMgoh4iQL76Hf0VIQhO4XX1hV1Ol/GApYf7QyTHTD91FKkg4q03
	 uc22WkIx6j9sw==
Date: Wed, 17 Sep 2025 17:20:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Potapenko <glider@google.com>, akpm@linux-foundation.org,
	vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	elver@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
	Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH v1] mm/memblock: Correct totalram_pages accounting with
 KMSAN
Message-ID: <aMrDk9ypD20H6zpx@kernel.org>
References: <20250917123250.3597556-1-glider@google.com>
 <aba22290-3577-44fa-97b3-71abd3429de7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aba22290-3577-44fa-97b3-71abd3429de7@redhat.com>

On Wed, Sep 17, 2025 at 03:29:51PM +0200, David Hildenbrand wrote:
> On 17.09.25 14:32, Alexander Potapenko wrote:
> > When KMSAN is enabled, `kmsan_memblock_free_pages()` can hold back pages
> > for metadata instead of returning them to the early allocator. The callers,
> > however, would unconditionally increment `totalram_pages`, assuming the
> > pages were always freed. This resulted in an incorrect calculation of the
> > total available RAM, causing the kernel to believe it had more memory than
> > it actually did.
> > 
> > This patch refactors `memblock_free_pages()` to return the number of pages
> > it successfully frees. If KMSAN stashes the pages, the function now
> > returns 0; otherwise, it returns the number of pages in the block.
> > 
> > The callers in `memblock.c` have been updated to use this return value,
> > ensuring that `totalram_pages` is incremented only by the number of pages
> > actually returned to the allocator. This corrects the total RAM accounting
> > when KMSAN is active.
> > 
> > Cc: Aleksandr Nogikh <nogikh@google.com>
> > Fixes: 3c2065098260 ("init: kmsan: call KMSAN initialization routines")
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >   mm/internal.h |  4 ++--
> >   mm/memblock.c | 18 +++++++++---------
> >   mm/mm_init.c  |  9 +++++----
> >   3 files changed, 16 insertions(+), 15 deletions(-)
> > 
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 45b725c3dc030..ae1ee6e02eff9 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -742,8 +742,8 @@ static inline void clear_zone_contiguous(struct zone *zone)
> >   extern int __isolate_free_page(struct page *page, unsigned int order);
> >   extern void __putback_isolated_page(struct page *page, unsigned int order,
> >   				    int mt);
> > -extern void memblock_free_pages(struct page *page, unsigned long pfn,
> > -					unsigned int order);
> > +extern unsigned long memblock_free_pages(struct page *page, unsigned long pfn,
> > +					 unsigned int order);
> >   extern void __free_pages_core(struct page *page, unsigned int order,
> >   		enum meminit_context context);
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 117d963e677c9..de7ff644d8f4f 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1834,10 +1834,9 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
> >   	cursor = PFN_UP(base);
> >   	end = PFN_DOWN(base + size);
> > -	for (; cursor < end; cursor++) {
> > -		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
> > -		totalram_pages_inc();
> > -	}
> > +	for (; cursor < end; cursor++)
> > +		totalram_pages_add(
> > +			memblock_free_pages(pfn_to_page(cursor), cursor, 0));
> >   }
> 
> That part is clear. But for readability we should probably just do
> 
> if (memblock_free_pages(pfn_to_page(cursor), cursor, 0))
> 	totalram_pages_inc();
> 
> Or use a temp variable as an alternative.

I prefer this one and totalram_pages_add() after the loop 
 
> LGTM
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.


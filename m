Return-Path: <linux-kernel+bounces-853710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DD3BDC628
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DF63E01DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CA72D97AF;
	Wed, 15 Oct 2025 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dfy4W9ST"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77E2BE647
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760500606; cv=none; b=mMHFAtYuDZ60XM8ap3ae47ZmCOIZ9AsmGREK7l2+B9+6f5DDFgYWoPXATckb15GWh2cM9/dUs+PwAmwoqMCpaaWVf/ToYNn4BHf4YsUYuk/scBtFmG55I4G5HQpJIpNYoAV3nsoAjuFAr2a3FHDormycfpGhctGxuZjVHxMWaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760500606; c=relaxed/simple;
	bh=jA5QQO6Dlx+leHkRUxGtr8R6pAFzgCqfBcJzR5Agj9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw8RS+xeT3WqaKm0Fju1XgjsdxVgdAgV9qwtrG+5I2Y4hidpqpCAAoL7KstVUyDwNC+z76Km/VWwva4BlVmauI+y0Ywam1GKNNI8OSS++4DVRUdmd6lUOIiaMpji3LDoxgaD/rhrryNVQr+yy7sn2UIMahcP/YaDUU5dV7ksUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dfy4W9ST; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iC+bIt3lh+BcXGKI7RLWlb4Z81tpVxVGePCWF8n6Ebs=; b=Dfy4W9ST4fZL+AhcctsetPE2Ob
	pKlsWlOvB8nHjBMDjEJLCSV+dFeMUlOr4aixUpIupF9GOeOETVMCjw+pD+gkoLMEDWYvUMbVLtYAZ
	8Ynj4mV1Su0Npo2kSgZ2QB49Zj95eIB1Z9Sq9C7YPP3wlpsZ4NbjL56cbSJwwq8QhOyZzE+ZtOnIa
	eJEZ7T0qqWrJwmz6GIye1H6x16OLHKmAiICtjcBd2qnC7VbE33dKT2a8JKFRyCvuV9eQ6o3xXkb69
	ytGzAs9Xl7tHOxZJlS0Y4gpb0FPtPA7JYXFjM7WAnLpetgysoFT7jw9ZpgXWssxZganBc97+AuAvB
	h7s/OOzg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8sd0-00000006r1M-2K2w;
	Wed, 15 Oct 2025 03:56:42 +0000
Date: Wed, 15 Oct 2025 04:56:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aO8behuGn5jVo28K@casper.infradead.org>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014182754.4329-1-vishal.moola@gmail.com>

On Tue, Oct 14, 2025 at 11:27:54AM -0700, Vishal Moola (Oracle) wrote:
> Running 1000 iterations of allocations on a small 4GB system finds:
> 
> 1000 2mb allocations:
> 	[Baseline]			[This patch]
> 	real    46.310s			real    34.380s
> 	user    0.001s			user    0.008s
> 	sys     46.058s			sys     34.152s
> 
> 10000 200kb allocations:
> 	[Baseline]			[This patch]
> 	real    56.104s			real    43.946s
> 	user    0.001s			user    0.003s
> 	sys     55.375s			sys     43.259s
> 
> 10000 20kb allocations:
> 	[Baseline]			[This patch]
> 	real    0m8.438s		real    0m9.160s
> 	user    0m0.001s		user    0m0.002s
> 	sys     0m7.936s		sys     0m8.671s

I'd be more confident in the 20kB numbers if you'd done 10x more
iterations.

Also, I think 20kB is probably an _interesting_ number, but it's not
going to display your change to its best advantage.  A 32kB allocation
will look much better, for example.

Also, can you go into more detail of the test?  Based on our off-list
conversation, we were talking about allocating something like 100MB
of memory (in these various sizes) then freeing it, just to be sure
that we're measuring the performance of the buddy allocator and
not the PCP list.

> This is an RFC, comments and thoughts are welcomed. There is a
> clear benefit to be had for large allocations, but there is
> some regression for smaller allocations.

Also we think that there's probably a later win to be had by
not splitting the page we allocated.

At some point, we should also start allocating frozen pages
for vmalloc.  That's going to be interesting for the users which
map vmalloc pages to userspace.

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 97cef2cc14d3..0a25e5cf841c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3621,6 +3621,38 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	unsigned int nr_allocated = 0;
>  	struct page *page;
>  	int i;
> +	gfp_t large_gfp = (gfp & ~__GFP_DIRECT_RECLAIM) | __GFP_NOWARN;
> +	unsigned int large_order = ilog2(nr_pages - nr_allocated);
> +
> +	/*
> +	 * Initially, attempt to have the page allocator give us large order
> +	 * pages. Do not attempt allocating smaller than order chunks since
> +	 * __vmap_pages_range() expects physically contigous pages of exactly
> +	 * order long chunks.
> +	 */
> +	while (large_order > order && nr_allocated < nr_pages) {
> +		/*
> +		 * High-order nofail allocations are really expensive and
> +		 * potentially dangerous (pre-mature OOM, disruptive reclaim
> +		 * and compaction etc.
> +		 */
> +		if (gfp & __GFP_NOFAIL)
> +			break;

sure, but we could just clear NOFAIL from the large_gfp flags instead
of giving up on this path so quickly?

> +		if (nid == NUMA_NO_NODE)
> +			page = alloc_pages_noprof(large_gfp, large_order);
> +		else
> +			page = alloc_pages_node_noprof(nid, large_gfp, large_order);
> +
> +		if (unlikely(!page))
> +			break;

I'm not entirely convinced here.  We might want to fall back to the next
larger size.  eg if we try to allocate an order-6 page, and there's not
one readily available, perhaps we should try to allocate an order-5 page
instead of falling back to the bulk allocator?

> @@ -3665,7 +3697,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		}
>  	}
>  
> -	/* High-order pages or fallback path if "bulk" fails. */
> +	/* High-order arch pages or fallback path if "bulk" fails. */

I'm not quite clear what this comment change is meant to convey?


Return-Path: <linux-kernel+bounces-854183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F029BDDC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AC019C2D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714DF31A540;
	Wed, 15 Oct 2025 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw+mKOcT"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0A30BB9A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520535; cv=none; b=TcAwZiMsMe3uyvZdNm5OzFDz7fSP2EzBL0qmMUMVdHHbnfXLopEHiRkN3oCmZlxQxl6b2H3THaSjn2uKS1pputjaaVVg8kds4eMBRxBzIIL340F8+33dgW3o4pAmymOiA8EZmLIuZIxji3vX8UBDHZfj/49SRWpNksr9+cbPXik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520535; c=relaxed/simple;
	bh=w9oSLVXl1abaIXQNkcjtI8UuvOw0MoekmgA7+KAt4xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0fPUN+tXV2WySnXcSF4xRv34AolbmqIOEos/lQkJE+UNB9F25otB+zxmjLCQKoHzY8bbEdG10Jeqbekenuak4TuT7vvDeXvoHN/gOjd1jU3SGbm/OwS+X3RC8gCgYYYB/5ZFvxE4Apr4B/sM7bW75NP3p5F/s/4bYc3hh68ZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw+mKOcT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46b303f755aso55785555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760520532; x=1761125332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hp2fYKx0k402gU8wOiSoX7ghMVY2eXtiYBiomEBCu00=;
        b=Lw+mKOcTUuy5Ri0WVqPg7aYYFXIRFT2HViHCep+Y/g1k/kI6lQVPGKeBcyOYA9pEbi
         bfYVOEgnlEZDmlyojbxgQa7E40UFgEfpdY06VWvOe7QnuuRwKumO/6eBTskBnsgdoSPs
         DmNMsJdG2AHYDhK1LzeF9+/0jRZ/NajlmP7VEOHACKbH0Whe74ez6WoRP1rTqDVfXqLm
         Sg31rLwFPJfBY1weuoQxf/ovXv9UIRd2tWgtvuMaKG0B3zrNs53A7vLtHA7/HTVbu42A
         tx9uFH/Ho4co+j56JqfJlrWaQrSOAOIlWwUOyBeJfY/PjkvGTrlJFOyzXcbt/mArnUR1
         MrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760520532; x=1761125332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp2fYKx0k402gU8wOiSoX7ghMVY2eXtiYBiomEBCu00=;
        b=NIQNJo39MGiHK+AdW5NZQI0qkwaKiKH29c+O5gyIBomFwpnfjwXzEKKClvta8Ur5uS
         tg2mcqkIGpUQdaUYjdbphJx5PvKtGWyZRXtgwbtljEdPqZwD0nV3sXgsZMFpV64BW8Q/
         qE4ggwOmfwKqM+kn3PY5fp7NwaLVEN0UuKitojsz5r0kQDBSoJ7ep03YklCnwR0tqXM5
         6X/kD0+ZpbwyBRHvchQrJe+ojDvv+oONeBatEZPcfpFd5QxKTVOg5GidkjA5j0rr4z+a
         uzGeU7Gs4+xFiJM7g6Rd40UeTdl9kshcTW03uL0ooaBkjVktNLAP25Yj/5tTxie8gCcH
         mtMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFtKDjefNzHX1PWjY2B+I1AhvXX7yOWojY2Gs8qUULmYCPMwyYMwRaHZUIhk0VXnaO4s0pcHK+78feGSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXUm9f5SFYOh4Ltms6FJA+JKkw2N1TPHT4Dw23NSM5t4esiAo
	9KL+l2fcSswCbWL7BdMbkdB8wvWziV13dNqTOwQ6Zw9oObU9+PEzSCvi
X-Gm-Gg: ASbGncujIsPB1GUxT66Nl9sARKnkkjqSsOfHG0FZDDe0IgwJIEsoH5PYRDdOL+PFoM5
	yLCtLPp7Ou9qmSGkRo3tJvzoQLHAT4CJXllYkht8X31NqOk/W/f2F7UhGXRP/v00QrPEX15YPzH
	sQtTykHsAqefMsw5yAUVztzz4jidsIhlQvi3JWgwQiJ6Ta6p/rnQ+Ky9dSBKabaEek35zGW69U+
	+6FlhEg8WeyNCYUaF83lDZvsZ/P4Nv6JKilOVW8uJ7NOXCECq1E7Treub0TQ6QkimxWz5PUKhva
	kQd6iwHjbv17HCb5VuRekggJpRqmqTouqACsCI38NCM7XSuM7Hgn8E114iI+4Qo5eYKN3x0ET43
	QU/88x9VEiHykpn1Mobu+6ktrvU4fhMhT7xk=
X-Google-Smtp-Source: AGHT+IGhErKOy64d9/b2jMz0wYrCY+Ob/EHUO0qOvgBR2Gdz3Vtc7ebOk0y6bVbTKFpbvvdrluUWvw==
X-Received: by 2002:a05:6000:1a8f:b0:3ec:db8b:cbf1 with SMTP id ffacd0b85a97d-42666ac7279mr18043977f8f.24.1760520531741;
        Wed, 15 Oct 2025 02:28:51 -0700 (PDT)
Received: from fedora ([31.94.20.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582a9csm28053606f8f.12.2025.10.15.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:28:51 -0700 (PDT)
Date: Wed, 15 Oct 2025 02:28:49 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aO9pUS3zLHsap81f@fedora>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO8behuGn5jVo28K@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO8behuGn5jVo28K@casper.infradead.org>

On Wed, Oct 15, 2025 at 04:56:42AM +0100, Matthew Wilcox wrote:
> On Tue, Oct 14, 2025 at 11:27:54AM -0700, Vishal Moola (Oracle) wrote:
> > Running 1000 iterations of allocations on a small 4GB system finds:
> > 
> > 1000 2mb allocations:
> > 	[Baseline]			[This patch]
> > 	real    46.310s			real    34.380s
> > 	user    0.001s			user    0.008s
> > 	sys     46.058s			sys     34.152s
> > 
> > 10000 200kb allocations:
> > 	[Baseline]			[This patch]
> > 	real    56.104s			real    43.946s
> > 	user    0.001s			user    0.003s
> > 	sys     55.375s			sys     43.259s
> > 
> > 10000 20kb allocations:
> > 	[Baseline]			[This patch]
> > 	real    0m8.438s		real    0m9.160s
> > 	user    0m0.001s		user    0m0.002s
> > 	sys     0m7.936s		sys     0m8.671s
> 
> I'd be more confident in the 20kB numbers if you'd done 10x more
> iterations.

I actually ran my a number of times to mitigate the effects of possibly
too small sample sizes, so I do have that number for you too:

[Baseline]			[This patch]
real    1m28.119s		real    1m32.630s
user    0m0.012s		user    0m0.011s
sys     1m23.270s		sys     1m28.529s

> Also, I think 20kB is probably an _interesting_ number, but it's not
> going to display your change to its best advantage.  A 32kB allocation
> will look much better, for example.

I provided those particular numbers to showcase the beneficial cases as
well as the regression case.

I ended up finding that allocating sizes <=20k had noticeable
regressions, while [20k, 90k] was approximately the same, and >= 90k had
improvements (getting more and more noticeable as size grows in
magnitude).

> Also, can you go into more detail of the test?  Based on our off-list
> conversation, we were talking about allocating something like 100MB
> of memory (in these various sizes) then freeing it, just to be sure
> that we're measuring the performance of the buddy allocator and
> not the PCP list.

Yup.

What I did to get the numbers above was: call vmalloc() n number of
times on that particular size, then free all those allocations. Then,
I did 1000 iterations of that to get a better average.

So none of these allocations were freed until all the allocations were
done, every single time.

> > This is an RFC, comments and thoughts are welcomed. There is a
> > clear benefit to be had for large allocations, but there is
> > some regression for smaller allocations.
> 
> Also we think that there's probably a later win to be had by
> not splitting the page we allocated.
> 
> At some point, we should also start allocating frozen pages
> for vmalloc.  That's going to be interesting for the users which
> map vmalloc pages to userspace.
> 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 97cef2cc14d3..0a25e5cf841c 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3621,6 +3621,38 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  	unsigned int nr_allocated = 0;
> >  	struct page *page;
> >  	int i;
> > +	gfp_t large_gfp = (gfp & ~__GFP_DIRECT_RECLAIM) | __GFP_NOWARN;
> > +	unsigned int large_order = ilog2(nr_pages - nr_allocated);
> > +
> > +	/*
> > +	 * Initially, attempt to have the page allocator give us large order
> > +	 * pages. Do not attempt allocating smaller than order chunks since
> > +	 * __vmap_pages_range() expects physically contigous pages of exactly
> > +	 * order long chunks.
> > +	 */
> > +	while (large_order > order && nr_allocated < nr_pages) {
> > +		/*
> > +		 * High-order nofail allocations are really expensive and
> > +		 * potentially dangerous (pre-mature OOM, disruptive reclaim
> > +		 * and compaction etc.
> > +		 */
> > +		if (gfp & __GFP_NOFAIL)
> > +			break;
> 
> sure, but we could just clear NOFAIL from the large_gfp flags instead
> of giving up on this path so quickly?

Yeah I'll do that.

> > +		if (nid == NUMA_NO_NODE)
> > +			page = alloc_pages_noprof(large_gfp, large_order);
> > +		else
> > +			page = alloc_pages_node_noprof(nid, large_gfp, large_order);
> > +
> > +		if (unlikely(!page))
> > +			break;
> 
> I'm not entirely convinced here.  We might want to fall back to the next
> larger size.  eg if we try to allocate an order-6 page, and there's not
> one readily available, perhaps we should try to allocate an order-5 page
> instead of falling back to the bulk allocator?

I'll try that out and see how that affects the numbers.

> > @@ -3665,7 +3697,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  		}
> >  	}
> >  
> > -	/* High-order pages or fallback path if "bulk" fails. */
> > +	/* High-order arch pages or fallback path if "bulk" fails. */
> 
> I'm not quite clear what this comment change is meant to convey?

Ah that was a comment I had inserted to remind myself that the passed in
order is tied to the HAVE_ARCH_HUGE_VMALLOC config. I meant to leave
that out.


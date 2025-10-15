Return-Path: <linux-kernel+bounces-854307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6935BDE108
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 713524E1A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5362131B803;
	Wed, 15 Oct 2025 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSJYCK/H"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2B315D59
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525069; cv=none; b=j9GboZAt2GGpi8Z3B4qWbIg0Dz5pnAsipKrQOxKWsjIR7O/mTAAn9bfNeINRbCRJhS+R+x0CilkIg1zkrx/WLu9HMwmF2zuUT7treyTUXydRmcm/BL0O+XcFUrWBiI2PU28qvXIdPCpjfesU0hHKzAj9T9hStCDtpCZqRNOE/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525069; c=relaxed/simple;
	bh=29AU9NtvNm3uovoHHCmvVbVan27+LinWRG50GhzUWos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9ftAiieSMjDo9Ba8G6xaQpgSv9rPW5Df/MZ16+qqOavX8feZsN/ZuC/7lC2tsGseIZcvo1cFJWsXXNP6tWHlzZex9Vh3L+lm2pQ0U8DlvNWCrpbbE4VLLXL6t0VOU9YS7C5C9v1QRK+uhDCQXGtm3iAaLDH6SGP+qixPjrkgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSJYCK/H; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so66833135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760525065; x=1761129865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja98IX4O3cTLH8elNwZHWRY1chVsyxH3oWvi7WUQjeY=;
        b=bSJYCK/HJ7r4xGKT4rSu4IoYbn8LPiaIAxd5565Z/ea5TUGcMChfkiuz0sSzIyxPyJ
         70X/nyUiiiO9AdDOjJslR0JtGonXQ6c4YwmbxkhQOtLO+HCdKqU1H/UhaqFkqXF4y7pl
         AKY60iuhVbQvHyq+LUzLiuAxy4KqW+ee1G1gWqkYrMDaHkrWwyMAQrVeZb1GsgHrNbdR
         VOTtn3TQqwES37yWXgexujNDik6nGTQt2xQlPlCNFQLYYNmapreblNSr8+7GbwP19DEP
         9kiwfJGVZ+ijP7m3rAFAccdYKI2hg9k0HydIF48NXaLr6PgazB1UX2J5QSH0MBOdfdw1
         ktwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525065; x=1761129865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja98IX4O3cTLH8elNwZHWRY1chVsyxH3oWvi7WUQjeY=;
        b=ronVOUDOHienT39TAvpbgboQyMJO6WQF6iVJjwsySKcf/K2fUf0LHuBBQtJ2lHBziE
         6Ip3bn/D2ZowK81rIsr/GSIgN0HKimRc8wM36MCu4ADbIM5OFshH1Zr4hDCtrGZnomwt
         LWeeL8cXVgV10XzoOxNe4i/HI0713SBcm7P5u7b+g/EiwBhbiHemGnX6aXwRgPknTw6u
         kEmyiWWzSEnCe/G6GZvWPh7lG0qzTtCko7GBZ7pKQZVoajkeJ49O8FJ7cQJxDzotneE9
         1mC91t3OED4FSDzorQt+sqMm3Uw3CQeKLE9fkaSRh6s5OKAESiOxNmJz2XOZqFL/lkJw
         qcew==
X-Forwarded-Encrypted: i=1; AJvYcCV9b9kp5dBAHYOrhc7bAbuJbdeF5Vj7TjkY0UgBu5vWJVDDoQeHbjaRe8Do9lGCse0FLuIR7NIFBe69aZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Utb4jvQ6cbqaQxo9fdLDR5RNmTqxMjbDdtE81gfhxI8kxNPS
	cPpgZol7hak20ajGxkJodiVsT1I7NSCSwagRlyzEiJfuWFqiSGAbl0DwVz0j+MwJ
X-Gm-Gg: ASbGncs7EYp4iM+dlU2LVIQdgT8D7oBpWZ7mmb6ZdqlPNU1r0Z/P/n+CwG4/q30nIMY
	zfppZtORT64kilhjkVp+IcGzdOTTYoD9hatU24/ovw+MA1ehtrpAW22dyHbc8c2qCO0AeNEaSUo
	MoDhBGNCShxqPQSy5unbkCyKl8Ge5sgAHtAjjzqokMX7Hkt8ocVtrmUhCRgTnneOfZh7yG2BmTP
	BKbNulH7GZB7B4/3vTouQSjb/LXhJlmmvTTqO0iN2nOMCceSS94KUTdiJ9DgusE4LHPGau94fKv
	cGUBZiiezvWRcAhhNHp1674X4XS8i0Oe+rhDZJZN+fE/wy/5YnU92UJyKStC/FeW0KSzVVIjHTC
	KYibkeySDIgpjm0t03dAnW+YY8WOrPJ/y6iL4FBpP71eA5w==
X-Google-Smtp-Source: AGHT+IG61k8TsU+nB/wUHMVmWo7EiG1XXr0JninDaZK/tiZZ7l9Az3/JlEMJMgkqkdZo6AaTLocEaA==
X-Received: by 2002:a05:600c:1907:b0:470:ff87:6c2d with SMTP id 5b1f17b1804b1-470ff8770dcmr13266675e9.29.1760525064699;
        Wed, 15 Oct 2025 03:44:24 -0700 (PDT)
Received: from fedora ([31.94.20.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab5250ddsm170242205e9.6.2025.10.15.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:44:24 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:44:22 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aO97BjvNZNh0UV3u@fedora>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO9Z90vphRcyFv2n@milan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO9Z90vphRcyFv2n@milan>

On Wed, Oct 15, 2025 at 10:23:19AM +0200, Uladzislau Rezki wrote:
> On Tue, Oct 14, 2025 at 11:27:54AM -0700, Vishal Moola (Oracle) wrote:
> > Sometimes, vm_area_alloc_pages() will want many pages from the buddy
> > allocator. Rather than making requests to the buddy allocator for at
> > most 100 pages at a time, we can eagerly request large order pages a
> > smaller number of times.
> > 
> > We still split the large order pages down to order-0 as the rest of the
> > vmalloc code (and some callers) depend on it. We still defer to the bulk
> > allocator and fallback path in case of order-0 pages or failure.
> > 
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
> > 
> > This is an RFC, comments and thoughts are welcomed. There is a
> > clear benefit to be had for large allocations, but there is
> > some regression for smaller allocations.
> > 
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  mm/vmalloc.c | 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> > 
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
> >
> If large_order is > MAX_ORDER - 1 then there is no need even try
> larger_order attempt.
> 
> >> unsigned int large_order = ilog2(nr_pages - nr_allocated);
> I think, it is better to introduce "remaining" variable which
> is nr_pages - nr_allocated. And on entry "remaining" can be set
> to just nr_pages because "nr_allocated" is zero.

I like the idea too.

> Maybe it is worth to drop/warn if __GFP_COMP is set also?

split_page() has a BUG_ON(PageCompound) within, so we don't need one out
here for now.

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
> > +		if (nid == NUMA_NO_NODE)
> > +			page = alloc_pages_noprof(large_gfp, large_order);
> > +		else
> > +			page = alloc_pages_node_noprof(nid, large_gfp, large_order);
> > +
> > +		if (unlikely(!page))
> > +			break;
> > +
> > +		split_page(page, large_order);
> > +		for (i = 0; i < (1U << large_order); i++)
> > +			pages[nr_allocated + i] = page + i;
> > +
> > +		nr_allocated += 1U << large_order;
> > +		large_order = ilog2(nr_pages - nr_allocated);
> > +	}
> >  
> So this is a third path for page allocation. The question is should we
> try all orders? Like already noted by Matthew, if there is no 5-order
> page but there is 4-order page? Try until we check all orders. For
> example we can get different order pages to fulfill the request.
>
> The concern is then if it is a waste of high-order pages. Because we can
> easily go with a single page allocator. Whereas someone in a system can not.

I feel like if we have high order pages available we'd rather allocate
those. Since the buddy allocator just coalesces the pages when they're
freed again, as soon as these allocations free up we are much more
likely to have large order pages ready to go again.

> Apart of that, maybe we can drop the bulk_path instead of having three paths?

Probably. I'd say that just depends on whether we care about maintaining
the optimizations for smaller vmallocs() - which I have no strong opinion
on.

> --
> Uladzislau Rezki


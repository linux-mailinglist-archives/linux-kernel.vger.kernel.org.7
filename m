Return-Path: <linux-kernel+bounces-854588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7873EBDECC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 364DE4ED2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603DA23FC49;
	Wed, 15 Oct 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJR0gt5j"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1822B8A6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535776; cv=none; b=cXP305NObcMXZ3Oi8VfprbtzPMIefBgcW7yHZ6lYEimpAcNz+UpavqAjr1Rzb/nkQZekAdqwqxD4FcZQyqoTMLxkiFMZC+Cx9j2eZqxlZTO5sHfr5RkB8RREpsuwUQh90O2Ljwca0TxEqc7Ybp1VtxhzkG+p3CfZtrQciSlk7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535776; c=relaxed/simple;
	bh=Qga1X+CkbPJJ/wjjAt6QVdT5KD7GDcRuOoTF46PQbHs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uudf0AcQ0RFj22vCvMbN9h1hQdc4ji3LqIo3x8BGA9YgHt4USV+Ujn4/3ndToCrFkOiUDT8RvWXW71t30pKZSHJV4Zz/YvYuKoq3rsHRskXw/A3dJQX92ca5d9i1OCHIuyoWys5GwNairNht8G3cjcJZHiyGBYjAOtE8i8c7YR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJR0gt5j; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so7315551e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760535773; x=1761140573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4BAAdWpTo7kdkSn1s2ZaiJLRC7v+maKfFZOfYvdC5U=;
        b=dJR0gt5j99r5D3Mvcd9jVYbjB7i00o8nnC8cxT5gU31Hv7UoQ53mqKYx/ptkffAEeU
         DF6gjH+Cuv54IHD22TxiWiJjsSrIK81oQ1QchKgXKYMbZAK+1/ujtYYGcc1pdWwS9qsK
         j4RaCDEsGY1Rqoa3qJYFC/HQXauwjGtLdwxkXlHGp8c3uVs4l5W7ahvNcZKLMGprFU6u
         PP1VjDm8jOGpLK2gjsDK0I9gcGn8rjazyu9Ba/CltrVjO1gd2+Xb5qEAzca3bq5AOVWd
         hlGIlcSfeH3ql2Hg3euEB30ueD3rLa9Y3sKau1N+Rg3TpRutluItHm35C9W7Kqg+1d3o
         RklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760535773; x=1761140573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4BAAdWpTo7kdkSn1s2ZaiJLRC7v+maKfFZOfYvdC5U=;
        b=DibgC+Ncba6SCdm4o8yGJ8eFvnPYkOXCQbDonkkqFjxaBXw18MD6MJq25ek9mSGg2t
         kuoUfgNunGjmqRHcI0wpW2y3O294OCDbopT6oQEHAK3je77+h3QxwzfGB6FWJpc1YF4j
         Z3/JMYafjz/TXzGQj+Vu6ovdJ/S+Ebdh90SFgrezrCOamKSVevXvcnYN02xSzNgwN6Nh
         9So+nb35dc2j2hm9VKL0AdX3GpfIKjIpmwsdpeAva18SD9g+XLJYlrv3Cmm3ym3hicEN
         K6gEwtyc7ag/GL2dArrNjAOIbB2ZRcTFFoa+Eva2jTh0TpN21nrvHpDanyqmEsemzNgL
         82eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIOTd9B4NoG9ArohAWuTIxSeFaxBpbJ9VtzcfuIe0Q+OLA3Nbt7DWr8A5UlHzHLHQw6Qb9dQiqVk4qWgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIzMRI6INiGqD0gddb7TZ6mKu3xI7lAPYu79sds3zFJGj2Ve0
	8NvDPGuDXPBRw5d+0ZQE5NZZuN5MUhr+vAOnEM5GQXDW9q8pA6/iz7whbZyb74t8
X-Gm-Gg: ASbGnct0ECO3JQ29usoXQ8KTb8UxqdfVtIh/FIybreLErA+nOOxcXzRFIa/3wCYcOdH
	c1nE4LWkTRRp1lVLHcKl6tGefJEi5ANt1ZOmykYCVVEVyrHFrXx1WVjGV1f2P3QYMdw7hj8ibeU
	46esDyNpAj12Gw8n//6iLa6H4mkfxjQcEZ0KB/KdC6dmyVeC/uwQSB9Fpvq2HNuidlUt5fMsXAf
	K7dDM1C80Kt68h/0uSW+0rBs2ktcGSEi6IYcKZ6ohXIURoJBj+C1BJWI08/vG+IeLDVctWu9iFA
	ZM52+xh6hbDaBT92du3Lw9Mmz4pz4AAhQQbq9grqt6avBqqAep2LVCd9MTwwGFcMU6gxMW7f9Et
	ocoy0ETO7
X-Google-Smtp-Source: AGHT+IE4CBzGf+pfUMzaLmENf0m0ABzFMayERas37FKG/vTFO9UrtjuBcJdv1VdnwKssMMa2kCUO9A==
X-Received: by 2002:a05:6512:3ca6:b0:56b:f8b9:fbdc with SMTP id 2adb3069b0e04-5906dc183acmr7954235e87.25.1760535772616;
        Wed, 15 Oct 2025 06:42:52 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e21sm6221048e87.2.2025.10.15.06.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:42:52 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 15 Oct 2025 15:42:50 +0200
To: Matthew Wilcox <willy@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aO-k2hBimow9oYuR@milan>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO9Z90vphRcyFv2n@milan>
 <aO97BjvNZNh0UV3u@fedora>
 <aO-Wxj7al7I-IadV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO-Wxj7al7I-IadV@casper.infradead.org>

On Wed, Oct 15, 2025 at 01:42:46PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 15, 2025 at 03:44:22AM -0700, Vishal Moola (Oracle) wrote:
> > On Wed, Oct 15, 2025 at 10:23:19AM +0200, Uladzislau Rezki wrote:
> > > >  	int i;
> > > > +	gfp_t large_gfp = (gfp & ~__GFP_DIRECT_RECLAIM) | __GFP_NOWARN;
> > > > +	unsigned int large_order = ilog2(nr_pages - nr_allocated);
> > > >
> > > If large_order is > MAX_ORDER - 1 then there is no need even try
> > > larger_order attempt.
> 
> Oh, I meant to mention that too.  Yes, this should be min(MAX_ORDER, ilog2()).
> 
> > > Maybe it is worth to drop/warn if __GFP_COMP is set also?
> > 
> > split_page() has a BUG_ON(PageCompound) within, so we don't need one out
> > here for now.
> 
> I don't think people actually call vmalloc() with __GFP_COMP set, but
> clearing it would do no harm here.
> 
Agree. We do not want BUG_ON() in split_page(). I think it is better to
control this even though nobody invokes vmalloc() with __GFP_COMP.

> > > The concern is then if it is a waste of high-order pages. Because we can
> > > easily go with a single page allocator. Whereas someone in a system can not.
> > 
> > I feel like if we have high order pages available we'd rather allocate
> > those. Since the buddy allocator just coalesces the pages when they're
> > freed again, as soon as these allocations free up we are much more
> > likely to have large order pages ready to go again.
> 
> My PoV is different from either of you -- that we actually want
> to allocate the high-order pages when we can because it reduces
> fragmentation.  If we allocate five separate pages to satisfy a 20kB
> allocation, those may come from five different 2MB pages (since they're
> probably coming from the pcp lists which after a sufficiently long period
> of running will be a jumble).  Whereas if we allocate an order-2 page
> and an order-0 page, those can come from at most two 2MB pages.
> 
> I understand the "allocating order-0 pages helps by using up the remnants
> of previous allocations" argument.  But I think on the whole we need to
> be doing larger allocations where possible, not smaller ones.
> 
OK, i see. Then we can start from highest "fit" order as starting point
and switch to lower ones if failing. Fallback to bulk or single page
allocator if it is still not enough pages.

Thank you!

--
Uladzislau Rezki


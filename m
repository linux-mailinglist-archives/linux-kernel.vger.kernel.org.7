Return-Path: <linux-kernel+bounces-686164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3885BAD93D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 19:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B1D1E12FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86A225419;
	Fri, 13 Jun 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X86C7AEH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604CC2135DE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836306; cv=none; b=adJVXogHNeRDxjz1NsBjwJnZsS9AxHxqONP4IR5I16qsO2eVHlE0jSFkYEerv/swDco05veEw71wzBgMJNLQVcQrIKUnI4xzq4Fw805yIvXpasJ2QlmVoTg3jQ6PstPBLmv2cGhbRlrFdfjKdT8FDFJV6+ddp1m0jR/HzR9fZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836306; c=relaxed/simple;
	bh=GCsZBLLMeFDWpwrjFxnJA4jeQPHtN7xz5n0A14nqUpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SenxU1YqxnZj0+gReVknSPYtl1pun3qHtxcujdW/yRXjRQIrZoGaAgUrig3hUhOcv/vT0NVgmIUuRsdl5udd3qWO7n2+dQjuLemuRWll8I97ExytytsteoTFdNnA98k+6+Gf3scm2nvR0jlXlIHGx2BW3+JN40Be6NO3JRN3K9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X86C7AEH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749836303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gd00oNRhCZA9bl4FEuwlqWv3NB9O4qFOmwNNS6VXqoc=;
	b=X86C7AEH8AqPpN4sJcDEeSwIi5E1yGGKH+4pIa9Y8AAhPJfogaF5gqLbrEkRHZ1Nw1Otbx
	Am3bIYW2Ughpxc90w0G0aZg76ylv3Ily9HpdzoYugWenRCYXW4nvM8Up1dyp+NOo0iqNqb
	sbuOw6G2AUNJO/SJK3H5z0Mz6gy6dEE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-wxPz17kTOiam0-j6C269oQ-1; Fri, 13 Jun 2025 13:38:22 -0400
X-MC-Unique: wxPz17kTOiam0-j6C269oQ-1
X-Mimecast-MFC-AGG-ID: wxPz17kTOiam0-j6C269oQ_1749836301
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddcfb7b921so2498525ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 10:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749836301; x=1750441101;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gd00oNRhCZA9bl4FEuwlqWv3NB9O4qFOmwNNS6VXqoc=;
        b=D3lq8oZLU7RRjIG0mqMqePkWIYys0R8u+CyyvHgvIs/AIfzuxNwCtHOQbuIJ+Wxw8n
         E3LCb/jr22tQoicdKIty1e0v/SOILdzTNz3S3KtCIUGBUwon5b9wXahlhNHtWAn5QXtM
         110DZqDNKOykr4RbLK8j8FiCqgYauToQhiruG7xsjZGCPK6OyWxFO8CARL6ACvhGU0C4
         WHXzDkNSlWCYHBKXA7JzhgY0YhKIXDok8j3DopwjPluLG2UNHQJD9IFgkkGgVtlkfLPX
         anUm8ERU6IfjNg+jxexQ3ZIyGDeP9X71/8HhZ16zNS+EGUnwsTrFp4HTU88eYgQc7PYv
         k0hA==
X-Forwarded-Encrypted: i=1; AJvYcCU6vUWpYgu8xej304t5AptBQv9QoHemqThh4kUomtjESyZHn+en/1S6z4kssjWqTYmmoi85Zjp4RasZ3II=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA34RF6tnLkXAFiVL6duU/XxuBfcdkN0N4oNPiCBBfjp1y5gYg
	3biTaZg9NuP5tYHMXG7e06WFzYh5H0w+t1vurydtjH4kayJs9lM3c+sQnDpnk4qiO1wDGR6weNv
	K661td2Dy/6BfUT68btqDobnrBTJtFJnUCzp6dQVTKwYL5DZ5wDPDBwjSyBcYYTyTlw==
X-Gm-Gg: ASbGncvidFIWrhscC+0Ri/t10NNHMjV8akge8I/knUWjFmtUFIhHRTaN+u9J1fY8C6O
	4R8It+gv5AkjaQVRhNII2uPn8mh8edxhYDyCmVVZsx/Rrbm6PVbwWIHm/J0dhME05vP02Y4WF91
	SfMyeHFAUNXzBzD9w4M7I+WT5hPIcR1ilmARqylyCtoX705Y2jOoD5DvQYroXmu+zR8BcR/WS0e
	ibZN3F7KgVU1JAVbffb0CYnb+WWD6BsXy2U29re4d8kSsvBK8FiQ+35Jf9jBBGs4gkNSKBQeAIP
	U8boxMlgfwu1+7UxXCsMLn7uqw==
X-Received: by 2002:a05:6e02:1c25:b0:3db:72f7:d7c3 with SMTP id e9e14a558f8ab-3de07da97f8mr1669455ab.3.1749836301295;
        Fri, 13 Jun 2025 10:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBOmEPkV4fSOvfJCBdCCdGSMnxwXbYmdpRxCmhRxQRYrTknNFKXlc/k+8Iqa3cISRD+98o9Q==
X-Received: by 2002:a05:6e02:1c25:b0:3db:72f7:d7c3 with SMTP id e9e14a558f8ab-3de07da97f8mr1669265ab.3.1749836300739;
        Fri, 13 Jun 2025 10:38:20 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de01a45455sm4340865ab.45.2025.06.13.10.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:38:20 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:38:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: lizhe.67@bytedance.com
Cc: david@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterx@redhat.com
Subject: Re: [RFC v2] vfio/type1: optimize vfio_unpin_pages_remote() for
 large folio
Message-ID: <20250613113818.584bec0a.alex.williamson@redhat.com>
In-Reply-To: <20250613062920.68801-1-lizhe.67@bytedance.com>
References: <20250612163239.5e45afc6.alex.williamson@redhat.com>
	<20250613062920.68801-1-lizhe.67@bytedance.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 14:29:20 +0800
lizhe.67@bytedance.com wrote:

> On Thu, 12 Jun 2025 16:32:39 -0600, alex.williamson@redhat.com wrote:
> 
> > >  drivers/vfio/vfio_iommu_type1.c | 53 +++++++++++++++++++++++++--------
> > >  1 file changed, 41 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > index 28ee4b8d39ae..2f6c0074d7b3 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -469,17 +469,28 @@ static bool is_invalid_reserved_pfn(unsigned long pfn)
> > >  	return true;
> > >  }
> > >  
> > > -static int put_pfn(unsigned long pfn, int prot)
> > > +static inline void _put_pfns(struct page *page, int npages, int prot)
> > >  {
> > > -	if (!is_invalid_reserved_pfn(pfn)) {
> > > -		struct page *page = pfn_to_page(pfn);
> > > +	unpin_user_page_range_dirty_lock(page, npages, prot & IOMMU_WRITE);
> > > +}
> > >  
> > > -		unpin_user_pages_dirty_lock(&page, 1, prot & IOMMU_WRITE);
> > > -		return 1;
> > > +/*
> > > + * The caller must ensure that these npages PFNs belong to the same folio.
> > > + */
> > > +static inline int put_pfns(unsigned long pfn, int npages, int prot)
> > > +{
> > > +	if (!is_invalid_reserved_pfn(pfn)) {
> > > +		_put_pfns(pfn_to_page(pfn), npages, prot);
> > > +		return npages;
> > >  	}
> > >  	return 0;
> > >  }
> > >  
> > > +static inline int put_pfn(unsigned long pfn, int prot)
> > > +{
> > > +	return put_pfns(pfn, 1, prot);
> > > +}
> > > +
> > >  #define VFIO_BATCH_MAX_CAPACITY (PAGE_SIZE / sizeof(struct page *))
> > >  
> > >  static void __vfio_batch_init(struct vfio_batch *batch, bool single)
> > > @@ -805,15 +816,33 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
> > >  				    unsigned long pfn, unsigned long npage,
> > >  				    bool do_accounting)
> > >  {
> > > -	long unlocked = 0, locked = 0;
> > > -	long i;
> > > +	long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
> > >  
> > > -	for (i = 0; i < npage; i++, iova += PAGE_SIZE) {
> > > -		if (put_pfn(pfn++, dma->prot)) {
> > > -			unlocked++;
> > > -			if (vfio_find_vpfn(dma, iova))
> > > -				locked++;
> > > +	while (npage) {
> > > +		struct folio *folio;
> > > +		struct page *page;
> > > +		long step = 1;
> > > +
> > > +		if (is_invalid_reserved_pfn(pfn))
> > > +			goto next;
> > > +
> > > +		page = pfn_to_page(pfn);
> > > +		folio = page_folio(page);
> > > +
> > > +		if (!folio_test_large(folio)) {
> > > +			_put_pfns(page, 1, dma->prot);
> > > +		} else {
> > > +			step = min_t(long, npage,
> > > +				folio_nr_pages(folio) -
> > > +				folio_page_idx(folio, page));
> > > +			_put_pfns(page, step, dma->prot);
> > >  		}
> > > +
> > > +		unlocked += step;
> > > +next:  
> > 
> > Usage of @step is inconsistent, goto isn't really necessary either, how
> > about:
> > 
> > 	while (npage) {
> > 		unsigned long step = 1;
> > 
> > 		if (!is_invalid_reserved_pfn(pfn)) {
> > 			struct page *page = pfn_to_page(pfn);
> > 			struct folio *folio = page_folio(page);
> > 			long nr_pages = folio_nr_pages(folio);
> > 
> > 			if (nr_pages > 1)
> > 				step = min_t(long, npage,
> > 					nr_pages -
> > 					folio_page_idx(folio, page));
> > 
> > 			_put_pfns(page, step, dma->prot);
> > 			unlocked += step;
> > 		}
> >   
> 
> That's great. This implementation is much better.
> 
> I'm a bit uncertain about the best type to use for the 'step'
> variable here. I've been trying to keep things consistent with the
> put_pfn() function, so I set the type of the second parameter in
> _put_pfns() to 'int'(we pass 'step' as the second argument to
> _put_pfns()).
> 
> Using unsigned long for 'step' should definitely work here, as the
> number of pages in a large folio currently falls within the range
> that can be represented by an int. However, there is still a
> potential risk of truncation that we need to be mindful of.
> 
> > > +		pfn += step;
> > > +		iova += PAGE_SIZE * step;
> > > +		npage -= step;
> > >  	}
> > >  
> > >  	if (do_accounting)  
> > 
> > AIUI, the idea is that we know we have npage contiguous pfns and we
> > currently test invalid/reserved, call pfn_to_page(), call
> > unpin_user_pages_dirty_lock(), and test vpfn for each individually.
> >
> > This instead wants to batch the vpfn accounted pfns using the range
> > helper added for the mapping patch,  
> 
> Yes. We use vpfn_pages() just to track the locked pages.
> 
> > infer that continuous pfns have the
> > same invalid/reserved state, the pages are sequential, and that we can
> > use the end of the folio to mark any inflections in those assumptions
> > otherwise.  Do I have that correct?  
> 
> Yes. I think we're definitely on the same page here.
> 
> > I think this could be split into two patches, one simply batching the
> > vpfn accounting and the next introducing the folio dependency.  The
> > contributions of each to the overall performance improvement would be
> > interesting.  
> 
> I've made an initial attempt, and here are the two patches after
> splitting them up.
> 
> 1. batch-vpfn-accounting-patch:
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 28ee4b8d39ae..c8ddcee5aa68 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -805,16 +805,12 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
>  				    unsigned long pfn, unsigned long npage,
>  				    bool do_accounting)
>  {
> -	long unlocked = 0, locked = 0;
> +	long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
>  	long i;
>  
> -	for (i = 0; i < npage; i++, iova += PAGE_SIZE) {
> -		if (put_pfn(pfn++, dma->prot)) {
> +	for (i = 0; i < npage; i++, iova += PAGE_SIZE)
> +		if (put_pfn(pfn++, dma->prot))
>  			unlocked++;
> -			if (vfio_find_vpfn(dma, iova))
> -				locked++;
> -		}
> -	}
>  
>  	if (do_accounting)
>  		vfio_lock_acct(dma, locked - unlocked, true);
> -----------------
> 
> 2. large-folio-optimization-patch:
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c8ddcee5aa68..48c2ba4ba4eb 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -469,17 +469,28 @@ static bool is_invalid_reserved_pfn(unsigned long pfn)
>  	return true;
>  }
>  
> -static int put_pfn(unsigned long pfn, int prot)
> +static inline void _put_pfns(struct page *page, int npages, int prot)
>  {
> -	if (!is_invalid_reserved_pfn(pfn)) {
> -		struct page *page = pfn_to_page(pfn);
> +	unpin_user_page_range_dirty_lock(page, npages, prot & IOMMU_WRITE);
> +}
>  
> -		unpin_user_pages_dirty_lock(&page, 1, prot & IOMMU_WRITE);
> -		return 1;
> +/*
> + * The caller must ensure that these npages PFNs belong to the same folio.
> + */
> +static inline int put_pfns(unsigned long pfn, int npages, int prot)
> +{
> +	if (!is_invalid_reserved_pfn(pfn)) {
> +		_put_pfns(pfn_to_page(pfn), npages, prot);
> +		return npages;
>  	}
>  	return 0;
>  }
>  
> +static inline int put_pfn(unsigned long pfn, int prot)
> +{
> +	return put_pfns(pfn, 1, prot);
> +}
> +
>  #define VFIO_BATCH_MAX_CAPACITY (PAGE_SIZE / sizeof(struct page *))
>  
>  static void __vfio_batch_init(struct vfio_batch *batch, bool single)
> @@ -806,11 +817,28 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
>  				    bool do_accounting)
>  {
>  	long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
> -	long i;
>  
> -	for (i = 0; i < npage; i++, iova += PAGE_SIZE)
> -		if (put_pfn(pfn++, dma->prot))
> -			unlocked++;
> +	while (npage) {
> +		long step = 1;
> +
> +		if (!is_invalid_reserved_pfn(pfn)) {
> +			struct page *page = pfn_to_page(pfn);
> +			struct folio *folio = page_folio(page);
> +			long nr_pages = folio_nr_pages(folio);
> +
> +			if (nr_pages > 1)
> +				step = min_t(long, npage,
> +					nr_pages -
> +					folio_page_idx(folio, page));
> +
> +			_put_pfns(page, step, dma->prot);
> +			unlocked += step;
> +		}
> +
> +		pfn += step;
> +		iova += PAGE_SIZE * step;
> +		npage -= step;
> +	}
>  
>  	if (do_accounting)
>  		vfio_lock_acct(dma, locked - unlocked, true);
> -----------------
> 
> Here are the results of the performance tests.
> 
> Base(v6.15):
> ./vfio-pci-mem-dma-map 0000:03:00.0 16
> ------- AVERAGE (MADV_HUGEPAGE) --------
> VFIO MAP DMA in 0.048 s (333.5 GB/s)
> VFIO UNMAP DMA in 0.139 s (115.1 GB/s)
> ------- AVERAGE (MAP_POPULATE) --------
> VFIO MAP DMA in 0.273 s (58.6 GB/s)
> VFIO UNMAP DMA in 0.302 s (52.9 GB/s)
> ------- AVERAGE (HUGETLBFS) --------
> VFIO MAP DMA in 0.052 s (305.3 GB/s)
> VFIO UNMAP DMA in 0.141 s (113.8 GB/s)
> 
> Base + Map + batch-vpfn-accounting-patch:
> ------- AVERAGE (MADV_HUGEPAGE) --------
> VFIO MAP DMA in 0.027 s (591.1 GB/s)
> VFIO UNMAP DMA in 0.138 s (115.7 GB/s)
> ------- AVERAGE (MAP_POPULATE) --------
> VFIO MAP DMA in 0.292 s (54.8 GB/s)
> VFIO UNMAP DMA in 0.308 s (52.0 GB/s)
> ------- AVERAGE (HUGETLBFS) --------
> VFIO MAP DMA in 0.032 s (505.5 GB/s)
> VFIO UNMAP DMA in 0.140 s (114.1 GB/s)
> 
> Base + Map + batch-vpfn-accounting-patch + large-folio-optimization-patch:
> ------- AVERAGE (MADV_HUGEPAGE) --------
> VFIO MAP DMA in 0.027 s (591.2 GB/s)
> VFIO UNMAP DMA in 0.049 s (327.6 GB/s)
> ------- AVERAGE (MAP_POPULATE) --------
> VFIO MAP DMA in 0.291 s (55.0 GB/s)
> VFIO UNMAP DMA in 0.306 s (52.3 GB/s)
> ------- AVERAGE (HUGETLBFS) --------
> VFIO MAP DMA in 0.032 s (498.3 GB/s)
> VFIO UNMAP DMA in 0.049 s (326.2 GB/s)
> 
> It seems that batching the vpfn accounting doesn't seem to have much
> of an impact in my environment. Perhaps this is because the rbtree
> for vfpn is empty, allowing vfio_find_vpfn to execute quickly?

Right, the rbtree is generally empty, but I thought it might still have
some benefit.  It might, but it's probably below the noise threshold of
the test.  I think it still makes sense to split the patches, the first
change is logically separate and the second patch builds on it.

long seems fine for the type of step.  Do note though that the previous
patch on the mapping side used nr_pages as the increment size, it might
make sense to be consistent and use something different for the folio
nr_pages and replace "step" with "nr_pages".

Also please add a comment explaining the use of the folio as a basis
for inferring that we won't have an inflection in invalid/reserved
state for the remaining extent of the folio and that the folio has
sequential pages and therefore reflects the contiguous pfn range.
Thanks,

Alex



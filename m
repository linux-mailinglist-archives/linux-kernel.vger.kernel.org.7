Return-Path: <linux-kernel+bounces-661033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0315AC25A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 16:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94BDD7BA68E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC8296FAE;
	Fri, 23 May 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2WnApOl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D880296FA7
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012064; cv=none; b=Xt7sidhUAAJpL8MbC5DLQ1h8aGNkuTgw9odScCJ1Y0t/JR61wETLh0Rr/XsvVUxg2vwSu7S0uxPXBxroLf8t+ebwEnAAo8Sy7r9dr2YqSzsUUrtfekeFBVZfOmpPh1a1oHy0zIy58AwZtKFqr2+R+KmNGLe0GE2WiwlVFgDrkvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012064; c=relaxed/simple;
	bh=rFtwkMunMcBHKQZm8B8dG3UJUD52y3dVjuicztqe+HA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJ3mO5RvCuuobgwRvGUIhztSg7Kku7Vk1RopIaK/NiXSAySTk0Z8xBZHQZZ95gxkRg8qozud6JMhuYzRmTnYwdohiaS0tNNjM0zWv1l7hMvjkrkdGUGgDpJnzjmCbic57nMLQ7X/Q8wDghiiOsP6/c2h0dgT4xujmoR/mgc3YqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2WnApOl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748012060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WNoy5VROWa8mUUKqIWUmhgx92gy7/Y2SXxhoTdbkKI=;
	b=Z2WnApOlMmU3CE8gOp5ZG6Y94stvjkDgYfKog9Tnef1GJv/xz/u6RyUdS61wlrgv5V3CUl
	p7CBSyhOGN/cUOdux12YMFuGwW1S1PAMz6Puk9ZXC7U1H5UZ8Wq8aXHkoZkHTyFbWQhqOl
	RBWZRchIjodPbJjIcfdenkrk1bXv5lY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-dyRMTjskOHaLPQryVqv0qQ-1; Fri, 23 May 2025 10:54:19 -0400
X-MC-Unique: dyRMTjskOHaLPQryVqv0qQ-1
X-Mimecast-MFC-AGG-ID: dyRMTjskOHaLPQryVqv0qQ_1748012058
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85df98f62d1so166421839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 07:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748012058; x=1748616858;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WNoy5VROWa8mUUKqIWUmhgx92gy7/Y2SXxhoTdbkKI=;
        b=NtOnGezTt15l7er84IfUe5XCBk1sF/euKQ7TQmjD/i/uvRpX82qaYWi4/rG7yPJ5g6
         sTX9sY/FCCj1dT0TR3id+4qFptDyoZp6rdBqfVXfAKrq/M9YbY/Ngo243WMLo4Q4QVI6
         V9CeHumQXLcP3cm8xtmFWz8XSBUyrHgo7LxUyI4TEe33QIEAdsRQ7xZAcDdHx00/zDtA
         SwkFJsQpctlCzOv54eXRuVc2ehBlv+h1kTFHHAdDYbIjMLmPt0V4/WKlfVjpjafHKqzF
         1ozpEiQ/UiPLfsYViWtzG6PYwwpO6QKYNdc5VgJz80mpY5SilnCoqOflWnSuID2BfeeN
         qMpA==
X-Forwarded-Encrypted: i=1; AJvYcCUmwbmnlNxJhpvjMnChrttA/9ilYPj22bsRuGmukQed6NecHQLRUjgi54GBWnLFHXn2DYikFp2QLBfu+hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCjaQJJpYdd/X7blCUBn6gVOeoLjV7zpe2wa7X6PVcoD13OJT
	VIQbJ8B4MekTNe1binAEd0xAKl1wuy2iikEpiJS2aDURLJEAIT771+YYX72wkHNy0bM7o8pcZBX
	7zpKqxmwvhsyq4cmy3QCwI4xgzM2S5VrqK3VWQg/gpCt9kFLpHrpf8OAOuC44DJHmUg==
X-Gm-Gg: ASbGncvXIgFyh3oL7gytYrMyw2VTjfS6R3pWmrJbDqIa+A4AzQEovM6AxMH4Yx9cbFW
	uYJQbYeEnAqta5Lj3WgErM+5CFTAu+MioT/HjavWPeGZGZccOp9vh4UGK+/qj+z4rJSxms5/S0y
	IyP3GHrEYiSM09D68Dv/rn5ZNjqy+n+3p+Dm7HaJPkZqDaoAQTeORCqGK1IOo+Jevj1YBnxT7vm
	+M7BV7WxL0sTtnTcqkyOXWQTm9ke9SDtLbcaSvZoKNAPhZDegTjq9L7Z/vhTJ+QNHvrMkXcGJD5
	+tiFLrm/flRclAc=
X-Received: by 2002:a05:6602:1513:b0:85d:9799:8476 with SMTP id ca18e2360f4ac-86cb05ff861mr84637439f.1.1748012058326;
        Fri, 23 May 2025 07:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ/B9g89+VDvpeHeLYQeDXh5HxGKep5dMwsFYNRNVhpTBlzcImCm9eLa3dV9y0GRvELMb4hA==
X-Received: by 2002:a05:6602:1513:b0:85d:9799:8476 with SMTP id ca18e2360f4ac-86cb05ff861mr84636439f.1.1748012057841;
        Fri, 23 May 2025 07:54:17 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3b1c9esm3575243173.38.2025.05.23.07.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:54:17 -0700 (PDT)
Date: Fri, 23 May 2025 08:54:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: lizhe.67@bytedance.com
Cc: david@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 muchun.song@linux.dev, peterx@redhat.com
Subject: Re: [PATCH v4] vfio/type1: optimize vfio_pin_pages_remote() for
 large folio
Message-ID: <20250523085415.6f316c84.alex.williamson@redhat.com>
In-Reply-To: <20250523034238.35879-1-lizhe.67@bytedance.com>
References: <20250522145207.01734386.alex.williamson@redhat.com>
	<20250523034238.35879-1-lizhe.67@bytedance.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 11:42:38 +0800
lizhe.67@bytedance.com wrote:

> On Thu, 22 May 2025 14:52:07 -0600, alex.williamson@redhat.com wrote: 
> 
> > On Thu, 22 May 2025 16:25:24 +0800
> > lizhe.67@bytedance.com wrote:
> >   
> > > On Thu, 22 May 2025 09:22:50 +0200, david@redhat.com wrote:
> > >   
> > > >On 22.05.25 05:49, lizhe.67@bytedance.com wrote:    
> > > >> On Wed, 21 May 2025 13:17:11 -0600, alex.williamson@redhat.com wrote:
> > > >>     
> > > >>>> From: Li Zhe <lizhe.67@bytedance.com>
> > > >>>>
> > > >>>> When vfio_pin_pages_remote() is called with a range of addresses that
> > > >>>> includes large folios, the function currently performs individual
> > > >>>> statistics counting operations for each page. This can lead to significant
> > > >>>> performance overheads, especially when dealing with large ranges of pages.
> > > >>>>
> > > >>>> This patch optimize this process by batching the statistics counting
> > > >>>> operations.
> > > >>>>
> > > >>>> The performance test results for completing the 8G VFIO IOMMU DMA mapping,
> > > >>>> obtained through trace-cmd, are as follows. In this case, the 8G virtual
> > > >>>> address space has been mapped to physical memory using hugetlbfs with
> > > >>>> pagesize=2M.
> > > >>>>
> > > >>>> Before this patch:
> > > >>>> funcgraph_entry:      # 33813.703 us |  vfio_pin_map_dma();
> > > >>>>
> > > >>>> After this patch:
> > > >>>> funcgraph_entry:      # 16071.378 us |  vfio_pin_map_dma();
> > > >>>>
> > > >>>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> > > >>>> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > > >>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > >>>> ---    
> > > >>>
> > > >>> Given the discussion on v3, this is currently a Nak.  Follow-up in that
> > > >>> thread if there are further ideas how to salvage this.  Thanks,    
> > > >> 
> > > >> How about considering the solution David mentioned to check whether the
> > > >> pages or PFNs are actually consecutive?
> > > >> 
> > > >> I have conducted a preliminary attempt, and the performance testing
> > > >> revealed that the time consumption is approximately 18,000 microseconds.
> > > >> Compared to the previous 33,000 microseconds, this also represents a
> > > >> significant improvement.
> > > >> 
> > > >> The modification is quite straightforward. The code below reflects the
> > > >> changes I have made based on this patch.
> > > >> 
> > > >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > >> index bd46ed9361fe..1cc1f76d4020 100644
> > > >> --- a/drivers/vfio/vfio_iommu_type1.c
> > > >> +++ b/drivers/vfio/vfio_iommu_type1.c
> > > >> @@ -627,6 +627,19 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
> > > >>          return ret;
> > > >>   }
> > > >>   
> > > >> +static inline long continuous_page_num(struct vfio_batch *batch, long npage)
> > > >> +{
> > > >> +       long i;
> > > >> +       unsigned long next_pfn = page_to_pfn(batch->pages[batch->offset]) + 1;
> > > >> +
> > > >> +       for (i = 1; i < npage; ++i) {
> > > >> +               if (page_to_pfn(batch->pages[batch->offset + i]) != next_pfn)
> > > >> +                       break;
> > > >> +               next_pfn++;
> > > >> +       }
> > > >> +       return i;
> > > >> +}    
> > > >
> > > >
> > > >What might be faster is obtaining the folio, and then calculating the 
> > > >next expected page pointer, comparing whether the page pointers match.
> > > >
> > > >Essentially, using folio_page() to calculate the expected next page.
> > > >
> > > >nth_page() is a simple pointer arithmetic with CONFIG_SPARSEMEM_VMEMMAP, 
> > > >so that might be rather fast.
> > > >
> > > >
> > > >So we'd obtain
> > > >
> > > >start_idx = folio_idx(folio, batch->pages[batch->offset]);    
> > > 
> > > Do you mean using folio_page_idx()?
> > >   
> > > >and then check for
> > > >
> > > >batch->pages[batch->offset + i] == folio_page(folio, start_idx + i)    
> > > 
> > > Thank you for your reminder. This is indeed a better solution.
> > > The updated code might look like this:
> > > 
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > index bd46ed9361fe..f9a11b1d8433 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -627,6 +627,20 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
> > >         return ret;
> > >  }
> > >  
> > > +static inline long continuous_pages_num(struct folio *folio,
> > > +               struct vfio_batch *batch, long npage)  
> > 
> > Note this becomes long enough that we should just let the compiler
> > decide whether to inline or not.  
> 
> Thank you! The 'inline' here indeed needs to be removed.
> 
> > > +{
> > > +       long i;
> > > +       unsigned long start_idx =
> > > +                       folio_page_idx(folio, batch->pages[batch->offset]);
> > > +
> > > +       for (i = 1; i < npage; ++i)
> > > +               if (batch->pages[batch->offset + i] !=
> > > +                               folio_page(folio, start_idx + i))
> > > +                       break;
> > > +       return i;
> > > +}
> > > +
> > >  /*
> > >   * Attempt to pin pages.  We really don't want to track all the pfns and
> > >   * the iommu can only map chunks of consecutive pfns anyway, so get the
> > > @@ -708,8 +722,12 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
> > >                          */
> > >                         nr_pages = min_t(long, batch->size, folio_nr_pages(folio) -
> > >                                                 folio_page_idx(folio, batch->pages[batch->offset]));
> > > -                       if (nr_pages > 1 && vfio_find_vpfn_range(dma, iova, nr_pages))
> > > -                               nr_pages = 1;
> > > +                       if (nr_pages > 1) {
> > > +                               if (vfio_find_vpfn_range(dma, iova, nr_pages))
> > > +                                       nr_pages = 1;
> > > +                               else
> > > +                                       nr_pages = continuous_pages_num(folio, batch, nr_pages);
> > > +                       }  
> > 
> > 
> > I think we can refactor this a bit better and maybe if we're going to
> > the trouble of comparing pages we can be a bit more resilient to pages
> > already accounted as vpfns.  I took a shot at it, compile tested only,
> > is there still a worthwhile gain?
> > 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 0ac56072af9f..e8bba32148f7 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -319,7 +319,13 @@ static void vfio_dma_bitmap_free_all(struct vfio_iommu *iommu)
> >  /*
> >   * Helper Functions for host iova-pfn list
> >   */
> > -static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
> > +
> > +/*
> > + * Find the first vfio_pfn that overlapping the range
> > + * [iova_start, iova_end) in rb tree.
> > + */
> > +static struct vfio_pfn *vfio_find_vpfn_range(struct vfio_dma *dma,
> > +		dma_addr_t iova_start, dma_addr_t iova_end)
> >  {
> >  	struct vfio_pfn *vpfn;
> >  	struct rb_node *node = dma->pfn_list.rb_node;
> > @@ -327,9 +333,9 @@ static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
> >  	while (node) {
> >  		vpfn = rb_entry(node, struct vfio_pfn, node);
> >  
> > -		if (iova < vpfn->iova)
> > +		if (iova_end <= vpfn->iova)
> >  			node = node->rb_left;
> > -		else if (iova > vpfn->iova)
> > +		else if (iova_start > vpfn->iova)
> >  			node = node->rb_right;
> >  		else
> >  			return vpfn;
> > @@ -337,6 +343,11 @@ static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
> >  	return NULL;
> >  }
> >  
> > +static inline struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
> > +{
> > +	return vfio_find_vpfn_range(dma, iova, iova + PAGE_SIZE);
> > +}
> > +
> >  static void vfio_link_pfn(struct vfio_dma *dma,
> >  			  struct vfio_pfn *new)
> >  {
> > @@ -615,6 +626,43 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
> >  	return ret;
> >  }
> >  
> > +static long contig_pages(struct vfio_dma *dma,
> > +			 struct vfio_batch *batch, dma_addr_t iova)
> > +{
> > +	struct page *page = batch->pages[batch->offset];
> > +	struct folio *folio = page_folio(page);
> > +	long idx = folio_page_idx(folio, page);
> > +	long max = min_t(long, batch->size, folio_nr_pages(folio) - idx);
> > +	long nr_pages;
> > +
> > +	for (nr_pages = 1; nr_pages < max; nr_pages++) {
> > +		if (batch->pages[batch->offset + nr_pages] !=
> > +		    folio_page(folio, idx + nr_pages))
> > +			break;
> > +	}
> > +
> > +	return nr_pages;
> > +}
> > +
> > +static long vpfn_pages(struct vfio_dma *dma,
> > +		       dma_addr_t iova_start, long nr_pages)
> > +{
> > +	dma_addr_t iova_end = iova_start + (nr_pages << PAGE_SHIFT);
> > +	struct vfio_pfn *vpfn;
> > +	long count = 0;
> > +
> > +	do {
> > +		vpfn = vfio_find_vpfn_range(dma, iova_start, iova_end);  
> 
> I am somehow confused here. Function vfio_find_vpfn_range()is designed
> to find, through the rbtree, the node that is closest to the root node
> and satisfies the condition within the range [iova_start, iova_end),
> rather than the node closest to iova_start? Or perhaps I have
> misunderstood something?

Sorry, that's an oversight on my part.  We might forego the _range
version and just do an inline walk of the tree counting the number of
already accounted pfns within the range.  Thanks,

Alex

> > +		if (likely(!vpfn))
> > +			break;
> > +
> > +		count++;
> > +		iova_start = vpfn->iova + PAGE_SIZE;
> > +	} while (iova_start < iova_end);
> > +
> > +	return count;
> > +}
> > +
> >  /*
> >   * Attempt to pin pages.  We really don't want to track all the pfns and
> >   * the iommu can only map chunks of consecutive pfns anyway, so get the
> > @@ -681,32 +729,40 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
> >  		 * and rsvd here, and therefore continues to use the batch.
> >  		 */
> >  		while (true) {
> > +			long nr_pages, acct_pages = 0;
> > +
> >  			if (pfn != *pfn_base + pinned ||
> >  			    rsvd != is_invalid_reserved_pfn(pfn))
> >  				goto out;
> >  
> > +			nr_pages = contig_pages(dma, batch, iova);
> > +			if (!rsvd) {
> > +				acct_pages = nr_pages;
> > +				acct_pages -= vpfn_pages(dma, iova, nr_pages);
> > +			}
> > +
> >  			/*
> >  			 * Reserved pages aren't counted against the user,
> >  			 * externally pinned pages are already counted against
> >  			 * the user.
> >  			 */
> > -			if (!rsvd && !vfio_find_vpfn(dma, iova)) {
> > +			if (acct_pages) {
> >  				if (!dma->lock_cap &&
> > -				    mm->locked_vm + lock_acct + 1 > limit) {
> > +				    mm->locked_vm + lock_acct + acct_pages > limit) {
> >  					pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
> >  						__func__, limit << PAGE_SHIFT);
> >  					ret = -ENOMEM;
> >  					goto unpin_out;
> >  				}
> > -				lock_acct++;
> > +				lock_acct += acct_pages;
> >  			}
> >  
> > -			pinned++;
> > -			npage--;
> > -			vaddr += PAGE_SIZE;
> > -			iova += PAGE_SIZE;
> > -			batch->offset++;
> > -			batch->size--;
> > +			pinned += nr_pages;
> > +			npage -= nr_pages;
> > +			vaddr += PAGE_SIZE * nr_pages;
> > +			iova += PAGE_SIZE * nr_pages;
> > +			batch->offset += nr_pages;
> > +			batch->size -= nr_pages;
> >  
> >  			if (!batch->size)
> >  				break;  
> 
> Thanks,
> Zhe
> 



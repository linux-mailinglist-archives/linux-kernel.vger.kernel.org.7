Return-Path: <linux-kernel+bounces-728312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B068B02670
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8346F5A2F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4751FDE02;
	Fri, 11 Jul 2025 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu/kR/Fr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF91DC075
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269731; cv=none; b=HnOjAv//o8oqhT8DKB63XT7V6Oy+N7FCIW1282J3VhFpDOmcxB+jiM7D1HdeGXy3hc0qOaLCLX72AkXGXLPh01fQRHIaWN9Ll0lkEEeptEdsZ5lTesfeib90EbGbvpTnBU+ZitAQBOCNT6aKCpotj/NI7myTzc6mCgXI86pFnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269731; c=relaxed/simple;
	bh=OUcUNJcRYDEm75ZahQ2/IVIkiNvpeKnv3wB3UibZRHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXNlptJKz+prKo6TkqMqIaZAFLlzuQUZdye6C53jhP0MQzn5C9/sISEAy7LNeZlTOoH7hICvVVcXuoLXGxaGIy3V5tpB8I+EMNFIGzUfj3HfcOEtjZCgRWGn60wNdUwaf6qXYi0tUgQ2YPtFjwLPHCrWRG84/H7ihAsXYHzWonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tu/kR/Fr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752269728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgkWm7qRDs+Q41tEmKDUfbmdZCqmGjrzM3iUWhFiHo4=;
	b=Tu/kR/FrLWKB7x+NplPxx3Y1Z7SpgUaa0gN1tp9tcTOMgm5r1JhUGbItbx8sv1tJpDI/Pf
	pZXioQSfS9ELrYYYlWjP7eLw1nG+hM27YyQ6KpclZY9Sh/433h5vW3xUhjgX2H8TRtmSzT
	6qm/3p9W0x9kur9ARZ6bS8w89mI3/Ps=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-7yvrbVD2Nxubc06yIlRJ3g-1; Fri, 11 Jul 2025 17:35:27 -0400
X-MC-Unique: 7yvrbVD2Nxubc06yIlRJ3g-1
X-Mimecast-MFC-AGG-ID: 7yvrbVD2Nxubc06yIlRJ3g_1752269726
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87333a93bd9so10047139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752269726; x=1752874526;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgkWm7qRDs+Q41tEmKDUfbmdZCqmGjrzM3iUWhFiHo4=;
        b=ayIQzeozQdNWOjkWH1eH4M8Bah+7DXZgLOb1Fqp+otlam+kw56EOmj3PODc3BsHhB1
         ok1HQfpmyUXGFEidXRfh0VYHGdOGMHLTPdfGiGf3oe4KxGpPuQ6eCjSKGGrAWs0/+cIj
         AxmGfyo5YPbafzidB1MHNbvtBPtXi7VU481XGNLXxTBm4U4MQyBCoiBW4sUqo4u0XzwV
         PycgeeaOHvmfP582H/xsTDb/VYf03ygUa6Pc/PcZahKVk50UPxLZ/md3dc7Z0AsT6l9u
         dFsmdlZ93AhR8ycp1/3eD61dWayy11F9khHBq/y2k/jAR2vr+Scx8BSf6V7IRnGRSRLB
         3FUA==
X-Forwarded-Encrypted: i=1; AJvYcCWKxcJe+cAbPYSZsLs3wJLp/XqHC3BbFW2tN5atkQvVk+kzD78aq6P46/FcPjTz02BayQuaS/Lo2Jngos4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOmcpXiLALGZ+r3xsQwmmjqoLDW8GM4TvrW5qMzQsyuBQA1Sy
	QJu76vMGI8Ow4O6OS40XEpIASkeLqbdPEFK3zV7TrzfZO4bc2Hc7KUdMYSdb9nWND2OoFNoSKjt
	LPLJRfaQXdPFMKcN4sWMr/qRSwtgUn486hXNNpTaL2BrAqu3bGAkh96tZS2alEKLSXA==
X-Gm-Gg: ASbGncsj2tnJMOUOfWk8ui51IFeEenXUCcWtIa4nzAWRceY/bBQfcy1bVlsNRCJDhyC
	ko/Kxo5ZFVWtx1OWY6R1vn5FusYzrGsu9MdBR7El3OAChywCUnYkEjI075aYE06hJm6D9AVKCHp
	yJrM9Z55kSFTQkc5eeBcYBBLMcSiqS2gbpmBWwj6J5JNTTzv2nywSNlYe6p0r0CrKCOc3ylbXrc
	W7fGI1/C9KeDv39OoTT5PyycFTa7k8ls1S6EUt1jnmkEeH7EFgpDbHDCRbwKmY7IIvko4e/oun7
	RT0gQYVmNy/YE8cysotp6FP6823K88o5Q/xD3od9lyM=
X-Received: by 2002:a05:6602:1688:b0:85e:12c1:fe90 with SMTP id ca18e2360f4ac-879792f8fbemr145243239f.5.1752269726187;
        Fri, 11 Jul 2025 14:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgzikGdHj30Bq9CuVwdpEt36LfpGDi5nuIaLVIiPS6ipxZYS3T0Muy4zgTBSWsG9GGcy2HpQ==
X-Received: by 2002:a05:6602:1688:b0:85e:12c1:fe90 with SMTP id ca18e2360f4ac-879792f8fbemr145242639f.5.1752269725706;
        Fri, 11 Jul 2025 14:35:25 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556b1d379sm989950173.129.2025.07.11.14.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 14:35:25 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:35:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: lizhe.67@bytedance.com
Cc: akpm@linux-foundation.org, david@redhat.com, jgg@ziepe.ca,
 peterx@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 2/5] vfio/type1: optimize vfio_pin_pages_remote()
Message-ID: <20250711153523.42d68ec0.alex.williamson@redhat.com>
In-Reply-To: <20250710085355.54208-3-lizhe.67@bytedance.com>
References: <20250710085355.54208-1-lizhe.67@bytedance.com>
	<20250710085355.54208-3-lizhe.67@bytedance.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 16:53:52 +0800
lizhe.67@bytedance.com wrote:

> From: Li Zhe <lizhe.67@bytedance.com>
> 
> When vfio_pin_pages_remote() is called with a range of addresses that
> includes large folios, the function currently performs individual
> statistics counting operations for each page. This can lead to significant
> performance overheads, especially when dealing with large ranges of pages.
> Batch processing of statistical counting operations can effectively enhance
> performance.
> 
> In addition, the pages obtained through longterm GUP are neither invalid
> nor reserved. Therefore, we can reduce the overhead associated with some
> calls to function is_invalid_reserved_pfn().
> 
> The performance test results for completing the 16G VFIO IOMMU DMA mapping
> are as follows.
> 
> Base(v6.16-rc4):
> ------- AVERAGE (MADV_HUGEPAGE) --------
> VFIO MAP DMA in 0.047 s (340.2 GB/s)
> ------- AVERAGE (MAP_POPULATE) --------
> VFIO MAP DMA in 0.280 s (57.2 GB/s)
> ------- AVERAGE (HUGETLBFS) --------
> VFIO MAP DMA in 0.052 s (310.5 GB/s)
> 
> With this patch:
> ------- AVERAGE (MADV_HUGEPAGE) --------
> VFIO MAP DMA in 0.027 s (602.1 GB/s)
> ------- AVERAGE (MAP_POPULATE) --------
> VFIO MAP DMA in 0.257 s (62.4 GB/s)
> ------- AVERAGE (HUGETLBFS) --------
> VFIO MAP DMA in 0.031 s (517.4 GB/s)
> 
> For large folio, we achieve an over 40% performance improvement.
> For small folios, the performance test results indicate a
> slight improvement.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 83 ++++++++++++++++++++++++++++-----
>  1 file changed, 71 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 1136d7ac6b59..6909275e46c2 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -318,7 +318,13 @@ static void vfio_dma_bitmap_free_all(struct vfio_iommu *iommu)
>  /*
>   * Helper Functions for host iova-pfn list
>   */
> -static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
> +
> +/*
> + * Find the highest vfio_pfn that overlapping the range
> + * [iova_start, iova_end) in rb tree.
> + */
> +static struct vfio_pfn *vfio_find_vpfn_range(struct vfio_dma *dma,
> +		dma_addr_t iova_start, dma_addr_t iova_end)
>  {
>  	struct vfio_pfn *vpfn;
>  	struct rb_node *node = dma->pfn_list.rb_node;
> @@ -326,9 +332,9 @@ static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
>  	while (node) {
>  		vpfn = rb_entry(node, struct vfio_pfn, node);
>  
> -		if (iova < vpfn->iova)
> +		if (iova_end <= vpfn->iova)
>  			node = node->rb_left;
> -		else if (iova > vpfn->iova)
> +		else if (iova_start > vpfn->iova)
>  			node = node->rb_right;
>  		else
>  			return vpfn;
> @@ -336,6 +342,11 @@ static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
>  	return NULL;
>  }
>  
> +static inline struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
> +{
> +	return vfio_find_vpfn_range(dma, iova, iova + PAGE_SIZE);
> +}
> +
>  static void vfio_link_pfn(struct vfio_dma *dma,
>  			  struct vfio_pfn *new)
>  {
> @@ -614,6 +625,39 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>  	return ret;
>  }
>  
> +
> +static long vpfn_pages(struct vfio_dma *dma,
> +		dma_addr_t iova_start, long nr_pages)
> +{
> +	dma_addr_t iova_end = iova_start + (nr_pages << PAGE_SHIFT);
> +	struct vfio_pfn *top = vfio_find_vpfn_range(dma, iova_start, iova_end);
> +	long ret = 1;
> +	struct vfio_pfn *vpfn;
> +	struct rb_node *prev;
> +	struct rb_node *next;
> +
> +	if (likely(!top))
> +		return 0;
> +
> +	prev = next = &top->node;
> +
> +	while ((prev = rb_prev(prev))) {
> +		vpfn = rb_entry(prev, struct vfio_pfn, node);
> +		if (vpfn->iova < iova_start)
> +			break;
> +		ret++;
> +	}
> +
> +	while ((next = rb_next(next))) {
> +		vpfn = rb_entry(next, struct vfio_pfn, node);
> +		if (vpfn->iova >= iova_end)
> +			break;
> +		ret++;
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * Attempt to pin pages.  We really don't want to track all the pfns and
>   * the iommu can only map chunks of consecutive pfns anyway, so get the
> @@ -680,32 +724,47 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
>  		 * and rsvd here, and therefore continues to use the batch.
>  		 */
>  		while (true) {
> +			long nr_pages, acct_pages = 0;
> +
>  			if (pfn != *pfn_base + pinned ||
>  			    rsvd != is_invalid_reserved_pfn(pfn))
>  				goto out;
>  
> +			/*
> +			 * Using GUP with the FOLL_LONGTERM in
> +			 * vaddr_get_pfns() will not return invalid
> +			 * or reserved pages.
> +			 */
> +			nr_pages = num_pages_contiguous(
> +					&batch->pages[batch->offset],
> +					batch->size);
> +			if (!rsvd) {
> +				acct_pages = nr_pages;
> +				acct_pages -= vpfn_pages(dma, iova, nr_pages);
> +			}
> +
>  			/*
>  			 * Reserved pages aren't counted against the user,
>  			 * externally pinned pages are already counted against
>  			 * the user.
>  			 */
> -			if (!rsvd && !vfio_find_vpfn(dma, iova)) {
> +			if (acct_pages) {
>  				if (!dma->lock_cap &&
> -				    mm->locked_vm + lock_acct + 1 > limit) {
> +				     mm->locked_vm + lock_acct + acct_pages > limit) {

Don't resend, I'll fix on commit, but there's still a gratuitous
difference in leading white space from the original.  Otherwise the
series looks good to me but I'll give Jason a little more time to
provide reviews since he's been so active in the thread (though he'd
rather we just use iommufd ;).  Thanks,

Alex

>  					pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
>  						__func__, limit << PAGE_SHIFT);
>  					ret = -ENOMEM;
>  					goto unpin_out;
>  				}
> -				lock_acct++;
> +				lock_acct += acct_pages;
>  			}
>  
> -			pinned++;
> -			npage--;
> -			vaddr += PAGE_SIZE;
> -			iova += PAGE_SIZE;
> -			batch->offset++;
> -			batch->size--;
> +			pinned += nr_pages;
> +			npage -= nr_pages;
> +			vaddr += PAGE_SIZE * nr_pages;
> +			iova += PAGE_SIZE * nr_pages;
> +			batch->offset += nr_pages;
> +			batch->size -= nr_pages;
>  
>  			if (!batch->size)
>  				break;



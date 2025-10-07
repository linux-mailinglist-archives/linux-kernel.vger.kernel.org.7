Return-Path: <linux-kernel+bounces-844753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6863ABC2AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F9494E5B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071F246BA9;
	Tue,  7 Oct 2025 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MN685wzZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC223B63C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869822; cv=none; b=Y/I718RfbmDHDfOjbwJfCjb1NGU8a6dtKkWsY+s3FPeE5K/MJzNjcpGeEc1ag/M9nRb8V5Vbrs0x4S8Uoabafsoa4qF8lb3eBdJSuo+hcOOTZOwsLDNEDFqCD00rNSRMzb3s2ZPQaKMUyoSuTeLgLayxYHx+CXyZYK5R7jH3IAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869822; c=relaxed/simple;
	bh=0/GE8UG1GvkI0APV00a143D2Nf5DngIi8pyOwroXZVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGkV5KUCdvV7q1vZwHjPKvtWbfdrJLpS2xtVzXLXJtdvbDmlA39hTEXFziv3YogE5iQi+jxKTxLZ9nHoA2s51m7bS70DBJULOS6tUIftMP2NU5wv1ufuygKTYXswhwowcG0p0PmAD+SRDa+HYJYZeMQ+8Q2cWPSCuAZMHhClrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MN685wzZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759869816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gyd2tSRqsMjb9vSXM5Y5lYTcuEZTqWpCxKzpqaqt5I=;
	b=MN685wzZtVw2/wE9+ydRgedHS+fBV1ly5CLlF6FZu7YMPqmS+IYkUciI1GQ5+8Rk2eu1KB
	Btqqbe3Mc4O/cGZfZZZ1NhKzUyiFW4KFtBlMetHn2n0iCSDKaZ62dUH7NVdyZT5M7ytPD1
	a7h7duuqWP3nHQHUYM82tXzezoJdOiQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-yxS6hi3tP_mhZLOWVrtYMQ-1; Tue, 07 Oct 2025 16:43:35 -0400
X-MC-Unique: yxS6hi3tP_mhZLOWVrtYMQ-1
X-Mimecast-MFC-AGG-ID: yxS6hi3tP_mhZLOWVrtYMQ_1759869814
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257fce57faso4273365ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759869814; x=1760474614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Gyd2tSRqsMjb9vSXM5Y5lYTcuEZTqWpCxKzpqaqt5I=;
        b=ao/n1+iFCWKafUoBzGIB7AaUl9AzQSGGLGLqz/+LeN86r2btK7OXqqgHz8iqqudamx
         YZfHjcqhRwOO0oOPQXiHtkD+AbhMqLcFhxUnXFUehTkHkNTcYatAGtYWHbWhfubXYOc/
         G+eMrDCV+nbqIeM7i7qkX2nKMQkOKyEZF+oSk2zX2GNeoZ2eTdrsIpOqs2xII9ZByZwi
         wAYKo16pSOIaFn9glBh+1m6JMQ8aWtHTZ31qEJJhxpDGPHYbZ3fQYDYiBzCo54acbMKH
         ZPydiJlBfX5diXJklfAciduQzqETGa8Engfa3NbFO4DpRBvPpC8xPrfbZy2Xki3aTUKQ
         tf0A==
X-Forwarded-Encrypted: i=1; AJvYcCVgSmAhSjQ3pZFK+4vwePyXQkK7Zl/ac0raB9CVUAN9nl3ujo5BjF47WiewF6UnUGxWOEd+QCV8hpZFDu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7H4te42FWX9Wtvw+mbtEIgBbpxOtsfS47GIkPsj48mOkhigc5
	JAGOTctnxWgDnvxrHqMC01i8C6GST6Ff5W+jmkVHemyQEco6jy+jrcCIvnECIrBfLhcJj8zcZRO
	VaqPdtOSqqvmydGW9Ni7n/LySnDNOS2RJ3vkwqGvrW7s1YWPiNSe0iCQf2LEFrxZHpA==
X-Gm-Gg: ASbGncvCX3K3VIeS2M99TZLMVUj3lwaJU/cyC4veLWobpzorKRkOUFsA8Falv8CaIMP
	1pTWHkKhoouCebJ0KL5tya5ROYoaS56vaWxruT/Ab28isxC+weGkSPYr5u/X9fb68+q09qVIBUG
	niahOcBFGonr/IQFy1Uw3xF/wm/AW6N6oYbFQIT3FcQBJijnyzaupZVPVspV2nokZPkXCBDwkle
	uA9gWOwWhLbOOTEzIbm+l23sKKr8N56ZpH+f86czObx8snfKBBVgxAntXcT6T2aEOacBn1jHot9
	ZNpVEiEUnHz6wb+9ruIXZPZ7CEDJUwIb65TiopCwzVDtJLC0
X-Received: by 2002:a05:6e02:1fca:b0:425:4a14:812e with SMTP id e9e14a558f8ab-42f8741030fmr2732025ab.7.1759869814347;
        Tue, 07 Oct 2025 13:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEXz88lqbA7H5/fblEcQci97VP9+1bRQ9c31YrtcoYijDWLkvqedHIjFKGGKcIwRDafuJErw==
X-Received: by 2002:a05:6e02:1fca:b0:425:4a14:812e with SMTP id e9e14a558f8ab-42f8741030fmr2731925ab.7.1759869813787;
        Tue, 07 Oct 2025 13:43:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f3474sm68730825ab.9.2025.10.07.13.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:43:32 -0700 (PDT)
Date: Tue, 7 Oct 2025 14:43:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio: fix VFIO_IOMMU_UNMAP_DMA when end of range would
 overflow u64
Message-ID: <20251007144328.186fc0d2.alex.williamson@redhat.com>
In-Reply-To: <aOSWA46X1XsH7pwP@devgpu015.cco6.facebook.com>
References: <20251005-fix-unmap-v1-1-6687732ed44e@fb.com>
	<20251006121618.GA3365647@ziepe.ca>
	<aOPuU0O6PlOjd/Xs@devgpu015.cco6.facebook.com>
	<20251006225039.GA3441843@ziepe.ca>
	<aORhMMOU5p3j69ld@devgpu015.cco6.facebook.com>
	<68e18f2c-79ad-45ec-99b9-99ff68ba5438@oracle.com>
	<aOSWA46X1XsH7pwP@devgpu015.cco6.facebook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Oct 2025 21:24:35 -0700
Alex Mastro <amastro@fb.com> wrote:
> 
> I do like the explicitness of the check_* functions over the older style wrap
> checks.
> 
> Below is my partially validated attempt at a more comprehensive fix if we were
> to try and make end of address space mappings work, rather than blanking out
> the last page.

I prefer this approach, thanks for tackling it.  Consider splitting
into a few patches for easier review, ex. discrete input sanitizing with
proper overflow checking, refactoring the fast/slow handlers to
increment iova in the caller, remainder to tie it all together.  A few
comments inline below. 

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 08242d8ce2ca..66a25de35446 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -28,6 +28,7 @@
>  #include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
> +#include <linux/overflow.h>
>  #include <linux/kthread.h>
>  #include <linux/rbtree.h>
>  #include <linux/sched/signal.h>
> @@ -165,12 +166,14 @@ static struct vfio_dma *vfio_find_dma(struct vfio_iommu *iommu,
>  {
>  	struct rb_node *node = iommu->dma_list.rb_node;
>  
> +	BUG_ON(size == 0);
> +
>  	while (node) {
>  		struct vfio_dma *dma = rb_entry(node, struct vfio_dma, node);
>  
> -		if (start + size <= dma->iova)
> +		if (start + size - 1 < dma->iova)
>  			node = node->rb_left;
> -		else if (start >= dma->iova + dma->size)
> +		else if (start > dma->iova + dma->size - 1)
>  			node = node->rb_right;
>  		else
>  			return dma;
> @@ -186,10 +189,12 @@ static struct rb_node *vfio_find_dma_first_node(struct vfio_iommu *iommu,
>  	struct rb_node *node = iommu->dma_list.rb_node;
>  	struct vfio_dma *dma_res = NULL;
>  
> +	BUG_ON(size == 0);
> +
>  	while (node) {
>  		struct vfio_dma *dma = rb_entry(node, struct vfio_dma, node);
>  
> -		if (start < dma->iova + dma->size) {
> +		if (start <= dma->iova + dma->size - 1) {
>  			res = node;
>  			dma_res = dma;
>  			if (start >= dma->iova)
> @@ -199,7 +204,7 @@ static struct rb_node *vfio_find_dma_first_node(struct vfio_iommu *iommu,
>  			node = node->rb_right;
>  		}
>  	}
> -	if (res && size && dma_res->iova > start + size - 1)
> +	if (res && dma_res->iova > start + size - 1)
>  		res = NULL;
>  	return res;
>  }
> @@ -213,7 +218,7 @@ static void vfio_link_dma(struct vfio_iommu *iommu, struct vfio_dma *new)
>  		parent = *link;
>  		dma = rb_entry(parent, struct vfio_dma, node);
>  
> -		if (new->iova + new->size <= dma->iova)
> +		if (new->iova + new->size - 1 < dma->iova)
>  			link = &(*link)->rb_left;
>  		else
>  			link = &(*link)->rb_right;
> @@ -825,14 +830,24 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>  	unsigned long remote_vaddr;
>  	struct vfio_dma *dma;
>  	bool do_accounting;
> +	u64 end, to_pin;

end looks like a dma_addr_t and to_pin ought to be a size_t, right?
Maybe iova_end and iova_size?

>  
> -	if (!iommu || !pages)
> +	if (!iommu || !pages || npage < 0)
>  		return -EINVAL;
>  
>  	/* Supported for v2 version only */
>  	if (!iommu->v2)
>  		return -EACCES;
>  
> +	if (npage == 0)
> +		return 0;
> +
> +	if (check_mul_overflow(npage, PAGE_SIZE, &to_pin))
> +		return -EINVAL;
> +
> +	if (check_add_overflow(user_iova, to_pin - 1, &end))
> +		return -EINVAL;
> +

Why not the same checks on vfio_iommu_type1_unpin_pages()?

>  	mutex_lock(&iommu->lock);
>  
>  	if (WARN_ONCE(iommu->vaddr_invalid_count,
> @@ -997,7 +1012,7 @@ static long vfio_sync_unpin(struct vfio_dma *dma, struct vfio_domain *domain,
>  #define VFIO_IOMMU_TLB_SYNC_MAX		512
>  
>  static size_t unmap_unpin_fast(struct vfio_domain *domain,
> -			       struct vfio_dma *dma, dma_addr_t *iova,
> +			       struct vfio_dma *dma, dma_addr_t iova,
>  			       size_t len, phys_addr_t phys, long *unlocked,
>  			       struct list_head *unmapped_list,
>  			       int *unmapped_cnt,
> @@ -1007,18 +1022,16 @@ static size_t unmap_unpin_fast(struct vfio_domain *domain,
>  	struct vfio_regions *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>  
>  	if (entry) {
> -		unmapped = iommu_unmap_fast(domain->domain, *iova, len,
> +		unmapped = iommu_unmap_fast(domain->domain, iova, len,
>  					    iotlb_gather);
>  
>  		if (!unmapped) {
>  			kfree(entry);
>  		} else {
> -			entry->iova = *iova;
> +			entry->iova = iova;
>  			entry->phys = phys;
>  			entry->len  = unmapped;
>  			list_add_tail(&entry->list, unmapped_list);
> -
> -			*iova += unmapped;
>  			(*unmapped_cnt)++;
>  		}
>  	}
> @@ -1037,18 +1050,17 @@ static size_t unmap_unpin_fast(struct vfio_domain *domain,
>  }
>  
>  static size_t unmap_unpin_slow(struct vfio_domain *domain,
> -			       struct vfio_dma *dma, dma_addr_t *iova,
> +			       struct vfio_dma *dma, dma_addr_t iova,
>  			       size_t len, phys_addr_t phys,
>  			       long *unlocked)
>  {
> -	size_t unmapped = iommu_unmap(domain->domain, *iova, len);
> +	size_t unmapped = iommu_unmap(domain->domain, iova, len);
>  
>  	if (unmapped) {
> -		*unlocked += vfio_unpin_pages_remote(dma, *iova,
> +		*unlocked += vfio_unpin_pages_remote(dma, iova,
>  						     phys >> PAGE_SHIFT,
>  						     unmapped >> PAGE_SHIFT,
>  						     false);
> -		*iova += unmapped;
>  		cond_resched();
>  	}
>  	return unmapped;
> @@ -1057,12 +1069,12 @@ static size_t unmap_unpin_slow(struct vfio_domain *domain,
>  static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  			     bool do_accounting)
>  {
> -	dma_addr_t iova = dma->iova, end = dma->iova + dma->size;
>  	struct vfio_domain *domain, *d;
>  	LIST_HEAD(unmapped_region_list);
>  	struct iommu_iotlb_gather iotlb_gather;
>  	int unmapped_region_cnt = 0;
>  	long unlocked = 0;
> +	size_t pos = 0;
>  
>  	if (!dma->size)
>  		return 0;
> @@ -1086,13 +1098,14 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  	}
>  
>  	iommu_iotlb_gather_init(&iotlb_gather);
> -	while (iova < end) {
> +	while (pos < dma->size) {
>  		size_t unmapped, len;
>  		phys_addr_t phys, next;
> +		dma_addr_t iova = dma->iova + pos;
>  
>  		phys = iommu_iova_to_phys(domain->domain, iova);
>  		if (WARN_ON(!phys)) {
> -			iova += PAGE_SIZE;
> +			pos += PAGE_SIZE;
>  			continue;
>  		}
>  
> @@ -1101,7 +1114,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
>  		 */
> -		for (len = PAGE_SIZE; iova + len < end; len += PAGE_SIZE) {
> +		for (len = PAGE_SIZE; len + pos < dma->size; len += PAGE_SIZE) {
>  			next = iommu_iova_to_phys(domain->domain, iova + len);
>  			if (next != phys + len)
>  				break;
> @@ -1111,16 +1124,18 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  		 * First, try to use fast unmap/unpin. In case of failure,
>  		 * switch to slow unmap/unpin path.
>  		 */
> -		unmapped = unmap_unpin_fast(domain, dma, &iova, len, phys,
> +		unmapped = unmap_unpin_fast(domain, dma, iova, len, phys,
>  					    &unlocked, &unmapped_region_list,
>  					    &unmapped_region_cnt,
>  					    &iotlb_gather);
>  		if (!unmapped) {
> -			unmapped = unmap_unpin_slow(domain, dma, &iova, len,
> +			unmapped = unmap_unpin_slow(domain, dma, iova, len,
>  						    phys, &unlocked);
>  			if (WARN_ON(!unmapped))
>  				break;
>  		}
> +
> +		pos += unmapped;
>  	}
>  
>  	dma->iommu_mapped = false;
> @@ -1212,7 +1227,7 @@ static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
>  }
>  
>  static int vfio_iova_dirty_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
> -				  dma_addr_t iova, size_t size, size_t pgsize)
> +				  dma_addr_t iova, u64 end, size_t pgsize)
>  {
>  	struct vfio_dma *dma;
>  	struct rb_node *n;
> @@ -1229,8 +1244,8 @@ static int vfio_iova_dirty_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
>  	if (dma && dma->iova != iova)
>  		return -EINVAL;
>  
> -	dma = vfio_find_dma(iommu, iova + size - 1, 0);
> -	if (dma && dma->iova + dma->size != iova + size)
> +	dma = vfio_find_dma(iommu, end, 1);
> +	if (dma && dma->iova + dma->size - 1 != end)
>  		return -EINVAL;
>  
>  	for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
> @@ -1239,7 +1254,7 @@ static int vfio_iova_dirty_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
>  		if (dma->iova < iova)
>  			continue;
>  
> -		if (dma->iova > iova + size - 1)
> +		if (dma->iova > end)
>  			break;
>  
>  		ret = update_user_bitmap(bitmap, iommu, dma, iova, pgsize);
> @@ -1305,6 +1320,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  	unsigned long pgshift;
>  	dma_addr_t iova = unmap->iova;
>  	u64 size = unmap->size;
> +	u64 unmap_end;
>  	bool unmap_all = unmap->flags & VFIO_DMA_UNMAP_FLAG_ALL;
>  	bool invalidate_vaddr = unmap->flags & VFIO_DMA_UNMAP_FLAG_VADDR;
>  	struct rb_node *n, *first_n;
> @@ -1327,11 +1343,13 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  		if (iova || size)
>  			goto unlock;
>  		size = U64_MAX;
> -	} else if (!size || size & (pgsize - 1) ||
> -		   iova + size - 1 < iova || size > SIZE_MAX) {
> +	} else if (!size || size & (pgsize - 1) || size > SIZE_MAX) {
>  		goto unlock;
>  	}
>  
> +	if (check_add_overflow(iova, size - 1, &unmap_end))
> +		goto unlock;
> +
>  	/* When dirty tracking is enabled, allow only min supported pgsize */
>  	if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
>  	    (!iommu->dirty_page_tracking || (bitmap->pgsize != pgsize))) {
> @@ -1376,8 +1394,8 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  		if (dma && dma->iova != iova)
>  			goto unlock;
>  
> -		dma = vfio_find_dma(iommu, iova + size - 1, 0);
> -		if (dma && dma->iova + dma->size != iova + size)
> +		dma = vfio_find_dma(iommu, unmap_end, 1);
> +		if (dma && dma->iova + dma->size - 1 != unmap_end)
>  			goto unlock;
>  	}
>  
> @@ -1386,7 +1404,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  
>  	while (n) {
>  		dma = rb_entry(n, struct vfio_dma, node);
> -		if (dma->iova > iova + size - 1)
> +		if (dma->iova > unmap_end)
>  			break;
>  
>  		if (!iommu->v2 && iova > dma->iova)
> @@ -1713,12 +1731,12 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>  
>  	for (; n; n = rb_next(n)) {
>  		struct vfio_dma *dma;
> -		dma_addr_t iova;
> +		size_t pos = 0;
>  
>  		dma = rb_entry(n, struct vfio_dma, node);
> -		iova = dma->iova;
>  
> -		while (iova < dma->iova + dma->size) {
> +		while (pos < dma->size) {
> +			dma_addr_t iova = dma->iova + pos;
>  			phys_addr_t phys;
>  			size_t size;
>  
> @@ -1734,14 +1752,15 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>  				phys = iommu_iova_to_phys(d->domain, iova);
>  
>  				if (WARN_ON(!phys)) {
> -					iova += PAGE_SIZE;
> +					pos += PAGE_SIZE;
>  					continue;
>  				}
>  
> +

Extra white space

>  				size = PAGE_SIZE;
>  				p = phys + size;
>  				i = iova + size;
> -				while (i < dma->iova + dma->size &&
> +				while (size + pos < dma->size &&
>  				       p == iommu_iova_to_phys(d->domain, i)) {
>  					size += PAGE_SIZE;
>  					p += PAGE_SIZE;

I think the else branch after this has some use cases too, (iova -
dma->iova) just becomes 'pos' in calculating vaddr, 'n' should be
calculated as (dma->size - pos).

> @@ -1782,7 +1801,7 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>  				goto unwind;
>  			}
>  
> -			iova += size;
> +			pos += size;
>  		}
>  	}
>  
> @@ -1799,29 +1818,29 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>  unwind:
>  	for (; n; n = rb_prev(n)) {
>  		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
> -		dma_addr_t iova;
> +		size_t pos = 0;
>  
>  		if (dma->iommu_mapped) {
>  			iommu_unmap(domain->domain, dma->iova, dma->size);
>  			continue;
>  		}
>  
> -		iova = dma->iova;
> -		while (iova < dma->iova + dma->size) {
> +		while (pos < dma->size) {
> +			dma_addr_t iova = dma->iova + pos;
>  			phys_addr_t phys, p;
>  			size_t size;
>  			dma_addr_t i;
>  
>  			phys = iommu_iova_to_phys(domain->domain, iova);
>  			if (!phys) {
> -				iova += PAGE_SIZE;
> +				pos += PAGE_SIZE;
>  				continue;
>  			}
>  
>  			size = PAGE_SIZE;
>  			p = phys + size;
>  			i = iova + size;
> -			while (i < dma->iova + dma->size &&
> +			while (pos + size < dma->size &&
>  			       p == iommu_iova_to_phys(domain->domain, i)) {
>  				size += PAGE_SIZE;
>  				p += PAGE_SIZE;
> @@ -2908,6 +2927,7 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>  		unsigned long pgshift;
>  		size_t data_size = dirty.argsz - minsz;
>  		size_t iommu_pgsize;
> +		u64 end;

Seems like a dma_addr_t.  range_end?  Thanks,

Alex

>  
>  		if (!data_size || data_size < sizeof(range))
>  			return -EINVAL;
> @@ -2916,8 +2936,12 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>  				   sizeof(range)))
>  			return -EFAULT;
>  
> -		if (range.iova + range.size < range.iova)
> +		if (range.size == 0)
> +			return 0;
> +
> +		if (check_add_overflow(range.iova, range.size - 1, &end))
>  			return -EINVAL;
> +
>  		if (!access_ok((void __user *)range.bitmap.data,
>  			       range.bitmap.size))
>  			return -EINVAL;
> @@ -2949,7 +2973,7 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>  		if (iommu->dirty_page_tracking)
>  			ret = vfio_iova_dirty_bitmap(range.bitmap.data,
>  						     iommu, range.iova,
> -						     range.size,
> +						     end,
>  						     range.bitmap.pgsize);
>  		else
>  			ret = -EINVAL;
> 



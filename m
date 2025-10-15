Return-Path: <linux-kernel+bounces-854546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC27BDEAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49EE3A33C9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DE2324B3A;
	Wed, 15 Oct 2025 13:11:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2382331DDBF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533876; cv=none; b=Jkk6VZvc2A6nwxNWwtLkiaTILxW8Ie9Se2dX9EWpUjUxXbOUfa/o35MgkWRWIEBwG8i5h/1j/9Pap3/0SoPQiG6HqA0h+9TUrVV1RRRGRNAeofxYx0HjvWmVV21fni/Y0RiTvFAFp6PoHsuiURUJeN/if//JPB3Oi592Bx9tKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533876; c=relaxed/simple;
	bh=FCrezLL+fz2WxYB88awUcRSRgCG3C2NTzgMLRm104g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDL5sXvoLdulx8/MmkJDryFh0WUOwC8dK4ZIX3aPa8kJu+hW6UpQXlXSut/L6WXLFv8Q4ammJZeE5e4CoeqirHDx4BvbWmokcroxP4fQdurX9K52BmOLnMBos9jB7meEnU/FS15AoebLRssASVE5lG6zfxrTW45EzD1IYWVl/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BBB1106F;
	Wed, 15 Oct 2025 06:11:05 -0700 (PDT)
Received: from [10.1.31.33] (e122027.cambridge.arm.com [10.1.31.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCC633F6A8;
	Wed, 15 Oct 2025 06:11:10 -0700 (PDT)
Message-ID: <30ffe224-d456-414a-8b92-3379f55a6bcb@arm.com>
Date: Wed, 15 Oct 2025 14:11:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/12] drm/panfrost: Handle page mapping failure
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251015000930.356073-1-adrian.larumbe@collabora.com>
 <20251015000930.356073-7-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251015000930.356073-7-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/10/2025 01:09, Adrián Larumbe wrote:
> When mapping the pages of a BO, either a heap type at page fault time or
> else a non-heap BO at object creation time, if the ARM page table mapping
> function fails, we unmap what had been mapped so far and bail out.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 49 ++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index ba32d99ed854..099e6797b2b5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -393,13 +393,32 @@ static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
>  	pm_runtime_put_autosuspend(pfdev->base.dev);
>  }
>  
> +static void mmu_unmap_range(struct panfrost_mmu *mmu, u64 iova, size_t len)
> +{
> +	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
> +	size_t pgsize, unmapped_len = 0;
> +	size_t unmapped_page, pgcount;
> +
> +	while (unmapped_len < len) {
> +		pgsize = get_pgsize(iova, len - unmapped_len, &pgcount);
> +
> +		unmapped_page = ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
> +		WARN_ON(unmapped_page != pgsize * pgcount);
> +
> +		iova += pgsize * pgcount;
> +		unmapped_len += pgsize * pgcount;
> +	}
> +}
> +
>  static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
>  		      u64 iova, int prot, struct sg_table *sgt)
>  {
>  	unsigned int count;
>  	struct scatterlist *sgl;
>  	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
> +	size_t total_mapped = 0;
>  	u64 start_iova = iova;
> +	int ret;
>  
>  	for_each_sgtable_dma_sg(sgt, sgl, count) {
>  		unsigned long paddr = sg_dma_address(sgl);
> @@ -413,10 +432,14 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
>  			size_t pgcount, mapped = 0;
>  			size_t pgsize = get_pgsize(iova | paddr, len, &pgcount);
>  
> -			ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
> +			ret = ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
>  				       GFP_KERNEL, &mapped);
> +			if (ret)
> +				goto err_unmap_pages;
> +
>  			/* Don't get stuck if things have gone wrong */
>  			mapped = max(mapped, pgsize);
> +			total_mapped += mapped;
>  			iova += mapped;
>  			paddr += mapped;
>  			len -= mapped;
> @@ -426,6 +449,10 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
>  	panfrost_mmu_flush_range(pfdev, mmu, start_iova, iova - start_iova);
>  
>  	return 0;
> +
> +err_unmap_pages:
> +	mmu_unmap_range(mmu, start_iova, total_mapped);
> +	return ret;
>  }
>  
>  int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
> @@ -436,6 +463,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>  	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
>  	struct sg_table *sgt;
>  	int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE;
> +	int ret;
>  
>  	if (WARN_ON(mapping->active))
>  		return 0;
> @@ -447,11 +475,18 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>  	if (WARN_ON(IS_ERR(sgt)))
>  		return PTR_ERR(sgt);
>  
> -	mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
> -		   prot, sgt);
> +	ret = mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
> +			 prot, sgt);
> +	if (ret)
> +		goto err_put_pages;
> +
>  	mapping->active = true;
>  
>  	return 0;
> +
> +err_put_pages:
> +	drm_gem_shmem_put_pages_locked(shmem);
> +	return ret;
>  }
>  
>  void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)
> @@ -636,8 +671,10 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  	if (ret)
>  		goto err_map;
>  
> -	mmu_map_sg(pfdev, bomapping->mmu, addr,
> -		   IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
> +	ret = mmu_map_sg(pfdev, bomapping->mmu, addr,
> +			 IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
> +	if (ret)
> +		goto err_mmu_map_sg;
>  
>  	bomapping->active = true;
>  	bo->heap_rss_size += SZ_2M;
> @@ -651,6 +688,8 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  
>  	return 0;
>  
> +err_mmu_map_sg:
> +	dma_unmap_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);
>  err_map:
>  	sg_free_table(sgt);
>  err_unlock:



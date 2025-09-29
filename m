Return-Path: <linux-kernel+bounces-836281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E805ABA92F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E743C20A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB33054CB;
	Mon, 29 Sep 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ONMTucB"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6A221FD4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148473; cv=none; b=aUfEohRIteHfxPwsFEo9ToKuxCvM2dxSHldz/Mp0xMWps8DW42pU2lhsdVjxrUYTSuBprqyDX8Ya4tMgqazDZBObDgXlHlCoCdELbKHZI+OeKOujAzyGxEDf2rtR1VTF6L7+6go6rPFBGWJRHQe/mTh6dd+yqXuv3deAN1eJwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148473; c=relaxed/simple;
	bh=FWduxyhH//iGBcxtUSZRZnP2YGaDx1vWzrh4UQTg9o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjoF/726HqJdwp8fif8TGeP+gV/XLRoagMDUHVApLpJ89zGC+lySWHYfdpZjwMiPFTK+oSA+2ZxYaeMyScDp2GDzRnteBng9Sg6T1BbAfHXLYUiLLobN+KS4IGP+qKypNdf5QhlwtFGwQEuSRyICHwt+e+w/A1C22kWPOoMEY0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ONMTucB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso124645e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759148470; x=1759753270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5O337N0PYzsdhyufllfit8PgCqTUUbHIq+q5cDEVCsM=;
        b=4ONMTucB4DzfVX17ua5xD6Volx3f9qdn1CDjRsNVCTVevYlO8wMvJn8FOWAo2dk810
         FN2o1MCwWNIhrZTW1I9b3eno5crqFUZ8135pJqtQ3Mbrt9j6cLbypAcN8XrtUyjliv2v
         Qnp8HicNgoPqirEYDXuMOOOnq3nA7sPlDpwrUuiGSpWwSlqy/razXLOOdh4Ff8bELztV
         tNYFr6Z/YT/r72pT8+vVDuqCbop1B23iwn3jKJLlQgGNCi+sIiO17A7ctI81VyH+XCme
         gpllJyji26SC7oxNduA2rMkbb+9AX4kIe2JtZ9zcr3ebdTGXdu1MeefC96jmIxGHn5s8
         t6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759148470; x=1759753270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O337N0PYzsdhyufllfit8PgCqTUUbHIq+q5cDEVCsM=;
        b=blwtybU7PvXXf5tXzCupg96sk/vH/K5To4abjJO0Hgemg53qAOkVYRVqaEelAyt1gV
         efUSA6vv1IafVtj70FYMFQWy9cgJV5rVqfod3DEYO66rLSD2yGMlqt8sdws87K+19vZM
         lIsKaov99NA1XbQclbqGJ3ZUu0015QCV3nDtQkUbJgXWPbwehYIWvKx8/l6FXu0lY2IJ
         rZ+zLv83v4pIyifHyeo9BgA6pmH37NhyHjEFF0JK7CumwCAnO3Dk9O8ycHj4JJpvIIFK
         9OBs3E02olyyFaM73VchARZqiIt3NxdfUFR4m3xO76nMN4gR5ESSA2vCqVkCWnPHYY9M
         /A8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlImwfTfgJKgGKWh/Q7NNbQJz99IauN1sUdA/ovJO5rQArAVTMo/te5p9KfXUXwJohPK5YG9HGEDDT3wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzs6DfbBTVl5Y3Eg4bajTGyBmsmt0E+4eKbP6g+ZCqkjVEqEaK
	/VhhBFw0I+nHxNI/O6PD1OXnM0GN5UjtfJx+tvQQQPm30OaoUDTydp6nFfjhtF17hg==
X-Gm-Gg: ASbGncvo0pVxfklr/8AJjh0rGcW2BNdGEgrZJxSocnUOWunGaLSijM1hMp6ParINVEL
	kVBZkBMwSQFyYolhMvHvzUMsI5K9AYS4vJrKoThbD7Ofe8IK2F2hZ+wKvb2l3QDeub2QslCBzBc
	metwBQ44L28ahJu7ZL9aqvF193E2pj3hsrYTjSwY90sWYjClX6kWgdmwTBi+In4iX9ZI+8fl040
	9Lryb+AwyF/3ZOe2K7bP5W9molNs5DMyKh3878yux8qBr/IToCrsSFUnWsZsgQfTJZeadceqqPv
	BkD1vFXgBt2HZetJUsMhREGs3mjZuHNIyH9Fh7L34QU/3V3WPO1F3Uf8p+aHNcENNSHb+Wa+1i7
	hnLS1mC8ngmd9fgNJKoVjcR9wZlrkG+DrYp+TNzsWQWqoIbmJTfYGE5BtUMzW77+tZPven1Ssgb
	c3RF5wWrl2zM5s
X-Google-Smtp-Source: AGHT+IH9QHjbFtr4ulBiflfGto8TOKRCXPewb2xZU1HqH+exBgIMy3OCdzYm+syELDHA9vXZKCVfmw==
X-Received: by 2002:a05:600c:a413:b0:45d:f6a6:a13e with SMTP id 5b1f17b1804b1-46e57589541mr380425e9.1.1759148469473;
        Mon, 29 Sep 2025 05:21:09 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb017sm18108463f8f.3.2025.09.29.05.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:21:08 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:21:05 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map
 callback
Message-ID: <aNp5sS7VpPirrRGE@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927223953.936562-1-danielmentz@google.com>

On Sat, Sep 27, 2025 at 10:39:52PM +0000, Daniel Mentz wrote:
> On systems with a non-coherent SMMU, the CPU must perform cache
> maintenance operations (CMOs) after updating page table entries (PTEs).
> This ensures that the SMMU reads the latest version of the descriptors
> and not stale data from memory.
> 
> This requirement can lead to significant performance overhead,
> especially when mapping long scatter-gather lists where each sg entry
> maps into an iommu_map() call that only covers 4KB of address space.
> 
> In such scenarios, each small mapping operation modifies a single 8-byte
> PTE but triggers a cache clean for the entire cache line (e.g., 64
> bytes). This results in the same cache line being cleaned repeatedly,
> once for each PTE it contains.
> 
> A more efficient implementation performs the cache clean operation only
> after updating all descriptors that are co-located in the same cache
> line. This patch introduces a mechanism to defer and batch the cache
> maintenance:
> 
> A new boolean flag, defer_sync_pte, is added to struct io_pgtable_cfg.
> When this flag is set, the arm-lpae backend will skip the cache sync
> operation for leaf entries within its .map_pages implementation.
> 
> A new callback, .iotlb_sync_map, is added to struct io_pgtable_ops.
> After performing a series of mapping operations, the caller is
> responsible for invoking this callback for the entire IOVA range. This
> function then walks the page tables for the specified range and performs
> the necessary cache clean operations for all the modified PTEs.
> 
> This allows for a single, efficient cache maintenance operation to cover
> multiple PTE updates, significantly reducing overhead for workloads that
> perform many small, contiguous mappings.
> 
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 66 +++++++++++++++++++++++++++++++++-
>  include/linux/io-pgtable.h     |  7 ++++
>  2 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 7e8e2216c294..a970eefb07fb 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -353,7 +353,7 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>  	for (i = 0; i < num_entries; i++)
>  		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
>  
> -	if (!cfg->coherent_walk)
> +	if (!cfg->coherent_walk && !cfg->defer_sync_pte)
>  		__arm_lpae_sync_pte(ptep, num_entries, cfg);
>  }
>  
> @@ -582,6 +582,69 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>  	return ret;
>  }
>  
> +static int __arm_lpae_iotlb_sync_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
> +			      size_t size, int lvl, arm_lpae_iopte *ptep)
> +{
> +	struct io_pgtable *iop = &data->iop;
> +	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +	int ret = 0, num_entries, max_entries;
> +	unsigned long iova_offset, sync_idx_start, sync_idx_end;
> +	int i, shift, synced_entries = 0;
> +
> +	shift = (ARM_LPAE_LVL_SHIFT(lvl - 1, data) + ARM_LPAE_PGD_IDX(lvl - 1, data));
> +	iova_offset = iova & ((1ULL << shift) - 1);
> +	sync_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> +	sync_idx_end = (iova_offset + size + block_size - ARM_LPAE_GRANULE(data)) >>
> +		ARM_LPAE_LVL_SHIFT(lvl, data);
> +	max_entries = arm_lpae_max_entries(sync_idx_start, data);
> +	num_entries = min_t(unsigned long, sync_idx_end - sync_idx_start, max_entries);
> +	ptep += sync_idx_start;
> +
> +	if (lvl < (ARM_LPAE_MAX_LEVELS - 1)) {
> +		for (i = 0; i < num_entries; i++) {
> +			arm_lpae_iopte pte = READ_ONCE(ptep[i]);
> +			unsigned long synced;
> +
> +			WARN_ON(!pte);
> +
> +			if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
> +				int n = i - synced_entries;
> +
> +				if (n) {
> +					__arm_lpae_sync_pte(&ptep[synced_entries], n, &iop->cfg);
> +					synced_entries += n;
> +				}
> +				ret = __arm_lpae_iotlb_sync_map(data, iova, size, lvl + 1,
> +								iopte_deref(pte, data));
> +				synced_entries++;
> +			}
> +			synced = block_size - (iova & (block_size - 1));
> +			size -= synced;
> +			iova += synced;
> +		}
> +	}
> +
> +	if (synced_entries != num_entries)
> +		__arm_lpae_sync_pte(&ptep[synced_entries], num_entries - synced_entries, &iop->cfg);
> +
> +	return ret;
> +}

Can't we rely on the exisiting generic table walker "__arm_lpae_iopte_walk",
instead writing a new one, that is already used for iova_to_phys and dirty bit.

Thanks,
Mostafa

> +
> +static int arm_lpae_iotlb_sync_map(struct io_pgtable_ops *ops, unsigned long iova,
> +			    size_t size)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +	arm_lpae_iopte *ptep = data->pgd;
> +	int lvl = data->start_level;
> +	long iaext = (s64)iova >> cfg->ias;
> +
> +	WARN_ON(!size);
> +	WARN_ON(iaext);
> +
> +	return __arm_lpae_iotlb_sync_map(data, iova, size, lvl, ptep);
> +}
> +
>  static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
>  				    arm_lpae_iopte *ptep)
>  {
> @@ -949,6 +1012,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>  	data->iop.ops = (struct io_pgtable_ops) {
>  		.map_pages	= arm_lpae_map_pages,
>  		.unmap_pages	= arm_lpae_unmap_pages,
> +		.iotlb_sync_map	= cfg->coherent_walk ? NULL : arm_lpae_iotlb_sync_map,
>  		.iova_to_phys	= arm_lpae_iova_to_phys,
>  		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
>  		.pgtable_walk	= arm_lpae_pgtable_walk,
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 138fbd89b1e6..c4927dbc0f61 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -57,6 +57,9 @@ struct iommu_flush_ops {
>   * @oas:           Output address (paddr) size, in bits.
>   * @coherent_walk  A flag to indicate whether or not page table walks made
>   *                 by the IOMMU are coherent with the CPU caches.
> + * @defer_sync_pte A flag to indicate whether pte sync operations for leaf
> + *                 entries shall be skipped during calls to .map_pages. A
> + *                 subsequent call to .iotlb_sync_map is required.
>   * @tlb:           TLB management callbacks for this set of tables.
>   * @iommu_dev:     The device representing the DMA configuration for the
>   *                 page table walker.
> @@ -110,6 +113,7 @@ struct io_pgtable_cfg {
>  	unsigned int			ias;
>  	unsigned int			oas;
>  	bool				coherent_walk;
> +	bool				defer_sync_pte;
>  	const struct iommu_flush_ops	*tlb;
>  	struct device			*iommu_dev;
>  
> @@ -204,6 +208,7 @@ struct arm_lpae_io_pgtable_walk_data {
>   * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
>   * @iova_to_phys: Translate iova to physical address.
>   * @pgtable_walk: (optional) Perform a page table walk for a given iova.
> + * @iotlb_sync_map: Sync ptes (Required for non-coherent page table walks)
>   *
>   * These functions map directly onto the iommu_ops member functions with
>   * the same names.
> @@ -222,6 +227,8 @@ struct io_pgtable_ops {
>  				    unsigned long iova, size_t size,
>  				    unsigned long flags,
>  				    struct iommu_dirty_bitmap *dirty);
> +	int (*iotlb_sync_map)(struct io_pgtable_ops *ops, unsigned long iova,
> +			      size_t size);
>  };
>  
>  /**
> -- 
> 2.51.0.570.gb178f27e6d-goog
> 


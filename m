Return-Path: <linux-kernel+bounces-702463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A5AE82B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 14:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57651698AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572A25E452;
	Wed, 25 Jun 2025 12:29:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B37800
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854562; cv=none; b=lmZ+938PejBr92H87/ejM9DcBgpUDxMD8lw65eNLrPT2GJNPYmDA5wU3jTnoFJiqz1Dwwg8ohP7qs+rIwGgt61L5wC53vjEgRv6e6e5vWUIRhQc/ztVnOCZGpd4y2M+F/3zfhNUWAXFs4FG68a1qmB4PndM6Kg5Sq8/NR0dXPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854562; c=relaxed/simple;
	bh=CguZlLibNJQ8+DvWfFIbiKXn0D5O7pmOOPle6BkZZxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2iNlBFo571ynf+fKlOUinjXqzNmeCdt9bsgT/FUyLMNWDVmmSDI55qj7ST+fJpYxfzJZmHbSnSIgdGubz3gmfdWqtt45OPOpt+F7u0+aJ/q5cNGtKCctWQ2VjGAkjGl/4H3Jmi0hNXdumNd6E1nJb1PfdQ8vyi70INtIzvL6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91136106F;
	Wed, 25 Jun 2025 05:28:59 -0700 (PDT)
Received: from [10.57.31.57] (unknown [10.57.31.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5ED43F66E;
	Wed, 25 Jun 2025 05:29:16 -0700 (PDT)
Message-ID: <e01be912-fe6b-420b-a911-700b338c9bd0@arm.com>
Date: Wed, 25 Jun 2025 13:29:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: clear SME flag for mmio pages
To: YangWencheng <east.moutain.yang@gmail.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250625064802.3640589-1-east.moutain.yang@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250625064802.3640589-1-east.moutain.yang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-25 7:48 am, YangWencheng wrote:
> If paddr is a mmio address, clear the SME flag. It makes no sense to
> set SME bit on MMIO address.

Arguably it also doesn't make sense for callers to be mapping MMIO 
addresses without IOMMU_MMIO...

> ---
>   drivers/iommu/amd/io_pgtable.c    | 6 ++++--
>   drivers/iommu/amd/io_pgtable_v2.c | 6 +++++-
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> index 4d308c071134..88b204449c2c 100644
> --- a/drivers/iommu/amd/io_pgtable.c
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -352,15 +352,17 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>   			updated = true;
>   
>   		if (count > 1) {
> -			__pte = PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
> +			__pte = PAGE_SIZE_PTE(paddr, pgsize);
>   			__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
>   		} else
> -			__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
> +			__pte = paddr | IOMMU_PTE_PR | IOMMU_PTE_FC;
>   
>   		if (prot & IOMMU_PROT_IR)
>   			__pte |= IOMMU_PTE_IR;
>   		if (prot & IOMMU_PROT_IW)
>   			__pte |= IOMMU_PTE_IW;
> +		if (pfn_valid(__phys_to_pfn(paddr)))

As usual, pfn_valid() isn't really appropriate for this anyway, since 
all it means is "does a struct page exist?", and in general it is 
entirely possible for (reserved) pages to exist for non-RAM addresses.

Thanks,
Robin.

> +			__pte = __sme_set(__pte);
>   
>   		for (i = 0; i < count; ++i)
>   			pte[i] = __pte;
> diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
> index b47941353ccb..b301fb8e58fa 100644
> --- a/drivers/iommu/amd/io_pgtable_v2.c
> +++ b/drivers/iommu/amd/io_pgtable_v2.c
> @@ -65,7 +65,11 @@ static u64 set_pte_attr(u64 paddr, u64 pg_size, int prot)
>   {
>   	u64 pte;
>   
> -	pte = __sme_set(paddr & PM_ADDR_MASK);
> +	if (pfn_valid(__phys_to_pfn(paddr)))
> +		pte = __sme_set(paddr & PM_ADDR_MASK);
> +	else
> +		pte = paddr & PM_ADDR_MASK;
> +
>   	pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
>   	pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
>   



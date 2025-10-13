Return-Path: <linux-kernel+bounces-850228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112BABD24D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582331899E35
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764432DECA0;
	Mon, 13 Oct 2025 09:30:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828CFBE49
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347829; cv=none; b=PC/EW0rvCJY5tDOb+nV5IwRP9gK2XVwzFmVRYoSiN3pMWG9RbnbruC13MnZbNyHgyvosMLXN7Nj10krZvGAZsVdwVtlAZqoYpK6ZxCVjPnBp42SGSx2siH/3pubJUX6wyHEypMgDLvOxGO/CvBTBSHaYfnfFpfIf3gp5SJ3RTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347829; c=relaxed/simple;
	bh=hBbESBlN61qET13/+oGKrIrSgYN5bO4ucTlr8npNOww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5t3hOmRH2GZJ8LkhMSwmVDLi6zuErczjm27VfRDG8gvt+0MIcLfONmOuIJPHUDs6HUcrocmzsDMbDIeF7vuvEzmyzDMfuuIN+JWiVLNcFG8kIwy5odNCAbaZ1iioTd4Rn7Y2ERfu1BVwaQmZRSAxqRaBPm20UfvyIMxnZsATQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C69D212FC;
	Mon, 13 Oct 2025 02:30:18 -0700 (PDT)
Received: from [10.57.83.188] (unknown [10.57.83.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F2BA3F6A8;
	Mon, 13 Oct 2025 02:30:23 -0700 (PDT)
Message-ID: <80156b07-245b-4668-9ad0-bb88cae5e85a@arm.com>
Date: Mon, 13 Oct 2025 10:30:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64/mm: Rename try_pgd_pgtable_alloc_init_mm
Content-Language: en-GB
To: Linu Cherian <linu.cherian@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>
References: <20251013080220.2027757-1-linu.cherian@arm.com>
 <20251013080220.2027757-3-linu.cherian@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251013080220.2027757-3-linu.cherian@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2025 09:02, Linu Cherian wrote:
> With BUG_ON in pgd_pgtable_alloc_init_mm moved up to higher layer,
> gfp flags is the only difference between try_pgd_pgtable_alloc_init_mm
> and pgd_pgtable_alloc_init_mm. Hence rename the "try" version
> to pgd_pgtable_alloc_init_mm_gfp.
> 
> Signed-off-by: Linu Cherian <linu.cherian@arm.com>

One nit below, but either way:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 34602339c1bf..ede591346196 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -559,7 +559,7 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>  }
>  
>  static phys_addr_t
> -try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
> +pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
>  {
>  	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
>  }

nit: Given this renaming, it might be clearer for pgd_pgtable_alloc_init_mm() to
call pgd_pgtable_alloc_init_mm_gfp() instead of calling __pgd_pgtable_alloc()
directly?

> @@ -594,7 +594,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>  	pte_t *ptep;
>  	int i;
>  
> -	pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE, gfp);
> +	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
>  	if (pte_phys == INVALID_PHYS_ADDR)
>  		return -ENOMEM;
>  	ptep = (pte_t *)phys_to_virt(pte_phys);
> @@ -639,7 +639,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>  	pmd_t *pmdp;
>  	int i;
>  
> -	pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD, gfp);
> +	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
>  	if (pmd_phys == INVALID_PHYS_ADDR)
>  		return -ENOMEM;
>  	pmdp = (pmd_t *)phys_to_virt(pmd_phys);



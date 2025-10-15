Return-Path: <linux-kernel+bounces-854735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B05BDF443
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A59C487FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFC2D6E63;
	Wed, 15 Oct 2025 15:03:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DDC2D3EFD
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540588; cv=none; b=CK1iot8ZPYSLUlJ0Vs5z4r3RWANE0KUKHCRTp9RzSah0DXGf5YMssKzNP9iIjFHuxsgoCCWXpHKzKOwyobxcigg2V4pLZlv6Yw9/KGQ4rviC9TgMJmvPdQrbfX9NZHYvUpUCLwq79je4s7TvgkSApqqpjeJCKhe57fxhZgcz59Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540588; c=relaxed/simple;
	bh=aHvrE4xI7TMRv5VI6ZiXUpZFy/NUBy1khN24mx1a1X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhJwQsNDEAIK3HfuuVcUDQQeAsNeJIYI+KJG2bl0P3niMTBH5qk1V9Is2V/7LlvhkSxVb2hpLzl+UgtTdLkJzu5cYQ3ysH148xY6FbUYm/Hdn67jOqbUfFul+jK2wWY1d7+/e/CKLs4ioV6DhZmEaEXbRFILJ79BSXssvUB4Iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12F1A1655;
	Wed, 15 Oct 2025 08:02:58 -0700 (PDT)
Received: from [10.1.38.178] (XHFQ2J9959.cambridge.arm.com [10.1.38.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7C073F738;
	Wed, 15 Oct 2025 08:03:03 -0700 (PDT)
Message-ID: <dc1d3d1f-4d72-41b0-a9a5-9d2b7e2784b1@arm.com>
Date: Wed, 15 Oct 2025 16:03:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64/mm: Rename try_pgd_pgtable_alloc_init_mm
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
References: <20251015112758.2701604-1-linu.cherian@arm.com>
 <20251015112758.2701604-3-linu.cherian@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251015112758.2701604-3-linu.cherian@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2025 12:27, Linu Cherian wrote:
> With BUG_ON in pgd_pgtable_alloc_init_mm moved up to higher layer,
> gfp flags is the only difference between try_pgd_pgtable_alloc_init_mm
> and pgd_pgtable_alloc_init_mm. Hence rename the "try" version
> to pgd_pgtable_alloc_init_mm_gfp.
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Linu Cherian <linu.cherian@arm.com>

LGTM:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
> Changelog
> v3:
> * Update  pgd_pgtable_alloc_init_mm to make use of 
>   pgd_pgtable_alloc_init_mm_gfp
> 
>  arch/arm64/mm/mmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 638cb4df31a9..80786d3167e7 100644
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
> @@ -567,7 +567,7 @@ try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
>  static phys_addr_t __maybe_unused
>  pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>  {
> -	return __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
> +	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
>  }
>  
>  static phys_addr_t
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



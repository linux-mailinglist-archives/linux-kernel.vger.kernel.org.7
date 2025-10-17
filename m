Return-Path: <linux-kernel+bounces-857826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85836BE805C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02F54502847
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A60631064E;
	Fri, 17 Oct 2025 10:14:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468A30F7E4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696079; cv=none; b=Zcg/6C5Pfkc7v6N5HP23wZlb20JhdCombOKWNb8EKhuTmr9dxek6xA68XFfZHUqq742T7TSaARcjfUpORAO2ulRjroxYmRSAfHROGsFZyqV0TlUMruQGwm9PvnK8os0Qki2yK7P4GFxFOwYDB6tAVfaM6F8JHQONl3RT4sbcQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696079; c=relaxed/simple;
	bh=ROA3+5qaWE/8NTHqxvNFP0tarbA48jVEEAai9Pm43go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSb/PfpuyPpL5iU0jfZKwRJKQfuL8cB2hiLUmc5nNJ1h90+D+tNtM1Ae0hDl00v/pCsgkKMk/X7k+mdWjOylMX8Id2R+puFGgCSxnIKh7sWlUw3+a3KiFAltIrzQ+YaiPaK2g4k9ORkrdYxGJo5TTAMpo36HjTUzjLGm3peD+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 023021595;
	Fri, 17 Oct 2025 03:14:30 -0700 (PDT)
Received: from [10.163.39.14] (unknown [10.163.39.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAB8D3F59E;
	Fri, 17 Oct 2025 03:14:33 -0700 (PDT)
Message-ID: <8bb759bc-3fb4-4c15-869a-6cfc83752031@arm.com>
Date: Fri, 17 Oct 2025 15:44:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64/mm: Rename try_pgd_pgtable_alloc_init_mm
To: Linu Cherian <linu.cherian@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>
References: <20251017051437.2836080-1-linu.cherian@arm.com>
 <20251017051437.2836080-3-linu.cherian@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251017051437.2836080-3-linu.cherian@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/25 10:44 AM, Linu Cherian wrote:
> With BUG_ON in pgd_pgtable_alloc_init_mm moved up to higher layer,
> gfp flags is the only difference between try_pgd_pgtable_alloc_init_mm
> and pgd_pgtable_alloc_init_mm. Hence rename the "try" version
> to pgd_pgtable_alloc_init_mm_gfp.
> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Linu Cherian <linu.cherian@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> Changelog:
> v4:
> No changes.
> 
>  arch/arm64/mm/mmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 99555ebbab38..f604a7983de3 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -560,7 +560,7 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>  }
>  
>  static phys_addr_t
> -try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
> +pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
>  {
>  	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
>  }
> @@ -568,7 +568,7 @@ try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
>  static phys_addr_t __maybe_unused
>  pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>  {
> -	return __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
> +	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
>  }
>  
>  static phys_addr_t
> @@ -595,7 +595,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>  	pte_t *ptep;
>  	int i;
>  
> -	pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE, gfp);
> +	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
>  	if (pte_phys == INVALID_PHYS_ADDR)
>  		return -ENOMEM;
>  	ptep = (pte_t *)phys_to_virt(pte_phys);
> @@ -640,7 +640,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>  	pmd_t *pmdp;
>  	int i;
>  
> -	pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD, gfp);
> +	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
>  	if (pmd_phys == INVALID_PHYS_ADDR)
>  		return -ENOMEM;
>  	pmdp = (pmd_t *)phys_to_virt(pmd_phys);



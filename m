Return-Path: <linux-kernel+bounces-850224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E7BD2491
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2E73A5050
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0190D2FB0BA;
	Mon, 13 Oct 2025 09:26:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9521FDA89
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347618; cv=none; b=LG0WeSzsK1AS5J3BAgm4gdp5JhN9txZSOKjnSRebJOAR9c7pL+0WyyuMPIeOQeDjQBG3mhtnKgljPSW7wuNhjuWaThJqoEANNtmdBRZs4kXowxcJtUoNbCcrKKLXqaQG/aEcvXVP1RHqWEH6jqZIbf3Z+m07I5SOd2OyOSmLDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347618; c=relaxed/simple;
	bh=ZU17mZkEGpBKGmJxTsyMPeF/7aXxozH1vPhbiOF9D7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gy0fkskOG7F0zKi2vLQqRgGNP9oMS2nXXBDTvCHWhRFoqEGKAsoB3XH61CHDU06Alvh60EirQxwN3/XXrXba4E8JVtqsDHKAc/mEd5pP47ZTgPod3FQTs8wmTkSB6vTdcmpAp1OAUQDhvqxzRyDth8AD6rXOkhEaaIiAmI0FQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B79D12FC;
	Mon, 13 Oct 2025 02:26:46 -0700 (PDT)
Received: from [10.57.83.188] (unknown [10.57.83.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C35F3F6A8;
	Mon, 13 Oct 2025 02:26:51 -0700 (PDT)
Message-ID: <8ff71d51-8f42-4197-a2a9-8733f23a8669@arm.com>
Date: Mon, 13 Oct 2025 10:26:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64/mm: Allow __create_pgd_mapping() to
 propagate pgtable_alloc() errors
Content-Language: en-GB
To: Linu Cherian <linu.cherian@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>
References: <20251013080220.2027757-1-linu.cherian@arm.com>
 <20251013080220.2027757-2-linu.cherian@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251013080220.2027757-2-linu.cherian@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2025 09:02, Linu Cherian wrote:
> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> 
> arch_add_memory() is used to hotplug memory into a system but as a part
> of its implementation it calls __create_pgd_mapping(), which uses
> pgtable_alloc() in order to build intermediate page tables. As this path
> was initally only used during early boot pgtable_alloc() is designed to
> BUG_ON() on failure. However, in the event that memory hotplug is
> attempted when the system's memory is extremely tight and the allocation
> were to fail, it would lead to panicking the system, which is not
> desirable. Hence update __create_pgd_mapping and all it's callers to be
> non void and propagate -ENOMEM on allocation failure to allow system to
> fail gracefully.
> 
> But during early boot if there is an allocation failure, we want the
> system to panic, hence create a wrapper around __create_pgd_mapping()
> called early_create_pgd_mapping() which is designed to panic, if ret
> is non zero value. All the init calls are updated to use this wrapper
> rather than the modified __create_pgd_mapping() to restore
> functionality.
> 
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> Signed-off-by: Linu Cherian <linu.cherian@arm.com>

Do we need a Fixes: (and cc stable) here?

> ---
> Changelog:
> 
> v2:
> * With cleanup merged as part of, "arm64: mm: Move KPTI helpers to mmu.c"
>   changes required in patch 2 got much simplified and 
>   squashed to patch 1 itself.
> * Make use of INVALID_PHYS_ADDR for error checks instead of 0.  
> * Do early function return where we do not have any
>   common cleanup in return path.
> * Remove redundant variable initialization
> * Changed BUG_ON to panic
> * Renamed ___create_pgd_mapping to early_create_pgd_mapping  
> 
>  arch/arm64/mm/mmu.c | 202 ++++++++++++++++++++++++++++----------------
>  1 file changed, 129 insertions(+), 73 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b8d37eb037fc..34602339c1bf 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -49,6 +49,8 @@
>  #define NO_CONT_MAPPINGS	BIT(1)
>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>  
> +#define INVALID_PHYS_ADDR	(-1ULL)
> +
>  DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
>  
>  u64 kimage_voffset __ro_after_init;
> @@ -194,11 +196,11 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  	} while (ptep++, addr += PAGE_SIZE, addr != end);
>  }
>  
> -static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> -				unsigned long end, phys_addr_t phys,
> -				pgprot_t prot,
> -				phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> -				int flags)
> +static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> +			       unsigned long end, phys_addr_t phys,
> +			       pgprot_t prot,
> +			       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +			       int flags)
>  {
>  	unsigned long next;
>  	pmd_t pmd = READ_ONCE(*pmdp);
> @@ -213,6 +215,8 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  			pmdval |= PMD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pte_phys = pgtable_alloc(TABLE_PTE);
> +		if (pte_phys == INVALID_PHYS_ADDR)
> +			return -ENOMEM;
>  		ptep = pte_set_fixmap(pte_phys);
>  		init_clear_pgtable(ptep);
>  		ptep += pte_index(addr);
> @@ -244,12 +248,15 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  	 * walker.
>  	 */
>  	pte_clear_fixmap();
> +
> +	return 0;
>  }
>  
> -static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
> -		     phys_addr_t phys, pgprot_t prot,
> -		     phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags)
> +static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
> +		    phys_addr_t phys, pgprot_t prot,
> +		    phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags)
>  {
> +	int ret;
>  	unsigned long next;
>  
>  	do {
> @@ -269,22 +276,27 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  			BUG_ON(!pgattr_change_is_safe(pmd_val(old_pmd),
>  						      READ_ONCE(pmd_val(*pmdp))));
>  		} else {
> -			alloc_init_cont_pte(pmdp, addr, next, phys, prot,
> -					    pgtable_alloc, flags);
> +			ret = alloc_init_cont_pte(pmdp, addr, next, phys, prot,
> +						  pgtable_alloc, flags);
> +			if (ret)
> +				return ret;
>  
>  			BUG_ON(pmd_val(old_pmd) != 0 &&
>  			       pmd_val(old_pmd) != READ_ONCE(pmd_val(*pmdp)));
>  		}
>  		phys += next - addr;
>  	} while (pmdp++, addr = next, addr != end);
> +
> +	return 0;
>  }
>  
> -static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
> -				unsigned long end, phys_addr_t phys,
> -				pgprot_t prot,
> -				phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> -				int flags)
> +static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
> +			       unsigned long end, phys_addr_t phys,
> +			       pgprot_t prot,
> +			       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +			       int flags)
>  {
> +	int ret;
>  	unsigned long next;
>  	pud_t pud = READ_ONCE(*pudp);
>  	pmd_t *pmdp;
> @@ -301,6 +313,8 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  			pudval |= PUD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pmd_phys = pgtable_alloc(TABLE_PMD);
> +		if (pmd_phys == INVALID_PHYS_ADDR)
> +			return -ENOMEM;
>  		pmdp = pmd_set_fixmap(pmd_phys);
>  		init_clear_pgtable(pmdp);
>  		pmdp += pmd_index(addr);
> @@ -320,20 +334,26 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  		    (flags & NO_CONT_MAPPINGS) == 0)
>  			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
> -		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
> +		ret = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
> +		if (ret)
> +			goto out;
>  
>  		pmdp += pmd_index(next) - pmd_index(addr);
>  		phys += next - addr;
>  	} while (addr = next, addr != end);
>  
> +out:
>  	pmd_clear_fixmap();
> +
> +	return ret;
>  }
>  
> -static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
> -			   phys_addr_t phys, pgprot_t prot,
> -			   phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> -			   int flags)
> +static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
> +			  phys_addr_t phys, pgprot_t prot,
> +			  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +			  int flags)
>  {
> +	int ret;
>  	unsigned long next;
>  	p4d_t p4d = READ_ONCE(*p4dp);
>  	pud_t *pudp;
> @@ -346,6 +366,8 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  			p4dval |= P4D_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pud_phys = pgtable_alloc(TABLE_PUD);
> +		if (pud_phys == INVALID_PHYS_ADDR)
> +			return -ENOMEM;
>  		pudp = pud_set_fixmap(pud_phys);
>  		init_clear_pgtable(pudp);
>  		pudp += pud_index(addr);
> @@ -375,8 +397,10 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  			BUG_ON(!pgattr_change_is_safe(pud_val(old_pud),
>  						      READ_ONCE(pud_val(*pudp))));
>  		} else {
> -			alloc_init_cont_pmd(pudp, addr, next, phys, prot,
> -					    pgtable_alloc, flags);
> +			ret = alloc_init_cont_pmd(pudp, addr, next, phys, prot,
> +						  pgtable_alloc, flags);
> +			if (ret)
> +				goto out;
>  
>  			BUG_ON(pud_val(old_pud) != 0 &&
>  			       pud_val(old_pud) != READ_ONCE(pud_val(*pudp)));
> @@ -384,14 +408,18 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  		phys += next - addr;
>  	} while (pudp++, addr = next, addr != end);
>  
> +out:
>  	pud_clear_fixmap();
> +
> +	return ret;

I think ret could technically be uninitialized here if we only went through the
do/while once and took the if branch? Perhaps init it to 0?

>  }
>  
> -static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
> -			   phys_addr_t phys, pgprot_t prot,
> -			   phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> -			   int flags)
> +static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
> +			  phys_addr_t phys, pgprot_t prot,
> +			  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +			  int flags)
>  {
> +	int ret;
>  	unsigned long next;
>  	pgd_t pgd = READ_ONCE(*pgdp);
>  	p4d_t *p4dp;
> @@ -404,6 +432,8 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  			pgdval |= PGD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		p4d_phys = pgtable_alloc(TABLE_P4D);
> +		if (p4d_phys == INVALID_PHYS_ADDR)
> +			return -ENOMEM;
>  		p4dp = p4d_set_fixmap(p4d_phys);
>  		init_clear_pgtable(p4dp);
>  		p4dp += p4d_index(addr);
> @@ -418,8 +448,10 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  
>  		next = p4d_addr_end(addr, end);
>  
> -		alloc_init_pud(p4dp, addr, next, phys, prot,
> -			       pgtable_alloc, flags);
> +		ret = alloc_init_pud(p4dp, addr, next, phys, prot,
> +				     pgtable_alloc, flags);
> +		if (ret)
> +			goto out;
>  
>  		BUG_ON(p4d_val(old_p4d) != 0 &&
>  		       p4d_val(old_p4d) != READ_ONCE(p4d_val(*p4dp)));
> @@ -427,15 +459,19 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  		phys += next - addr;
>  	} while (p4dp++, addr = next, addr != end);
>  
> +out:
>  	p4d_clear_fixmap();
> +
> +	return ret;
>  }
>  
> -static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
> -					unsigned long virt, phys_addr_t size,
> -					pgprot_t prot,
> -					phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> -					int flags)
> +static int __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
> +				       unsigned long virt, phys_addr_t size,
> +				       pgprot_t prot,
> +				       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +				       int flags)
>  {
> +	int ret;
>  	unsigned long addr, end, next;
>  	pgd_t *pgdp = pgd_offset_pgd(pgdir, virt);
>  
> @@ -444,7 +480,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>  	 * within a page, we cannot map the region as the caller expects.
>  	 */
>  	if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
> -		return;
> +		return -EINVAL;
>  
>  	phys &= PAGE_MASK;
>  	addr = virt & PAGE_MASK;
> @@ -452,25 +488,45 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>  
>  	do {
>  		next = pgd_addr_end(addr, end);
> -		alloc_init_p4d(pgdp, addr, next, phys, prot, pgtable_alloc,
> -			       flags);
> +		ret = alloc_init_p4d(pgdp, addr, next, phys, prot, pgtable_alloc,
> +				     flags);
> +		if (ret)
> +			return ret;
>  		phys += next - addr;
>  	} while (pgdp++, addr = next, addr != end);
> +
> +	return 0;
>  }
>  
> -static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> -				 unsigned long virt, phys_addr_t size,
> -				 pgprot_t prot,
> -				 phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> -				 int flags)
> +static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> +				unsigned long virt, phys_addr_t size,
> +				pgprot_t prot,
> +				phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +				int flags)
>  {
> +	int ret;
> +
>  	mutex_lock(&fixmap_lock);
> -	__create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
> -				    pgtable_alloc, flags);
> +	ret = __create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
> +					  pgtable_alloc, flags);
>  	mutex_unlock(&fixmap_lock);
> +
> +	return ret;
>  }
>  
> -#define INVALID_PHYS_ADDR	(-1ULL)
> +static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> +				     unsigned long virt, phys_addr_t size,
> +				     pgprot_t prot,
> +				     phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +				     int flags)
> +{
> +	int ret;
> +
> +	ret = __create_pgd_mapping(pgdir, phys, virt, size, prot, pgtable_alloc,
> +				   flags);
> +	if (ret)
> +		panic("Failed to create page tables\n");
> +}
>  
>  static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>  				       enum pgtable_type pgtable_type)
> @@ -511,21 +567,13 @@ try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
>  static phys_addr_t __maybe_unused
>  pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>  {
> -	phys_addr_t pa;
> -
> -	pa = __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
> -	BUG_ON(pa == INVALID_PHYS_ADDR);
> -	return pa;
> +	return __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
>  }
>  
>  static phys_addr_t
>  pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
>  {
> -	phys_addr_t pa;
> -
> -	pa = __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
> -	BUG_ON(pa == INVALID_PHYS_ADDR);
> -	return pa;
> +	return  __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
>  }
>  
>  static void split_contpte(pte_t *ptep)
> @@ -903,8 +951,8 @@ void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
>  			&phys, virt);
>  		return;
>  	}
> -	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
> -			     NO_CONT_MAPPINGS);
> +	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
> +				 NO_CONT_MAPPINGS);
>  }
>  
>  void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
> @@ -918,8 +966,8 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  	if (page_mappings_only)
>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
> -	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
> -			     pgd_pgtable_alloc_special_mm, flags);
> +	early_create_pgd_mapping(mm->pgd, phys, virt, size, prot,
> +				 pgd_pgtable_alloc_special_mm, flags);
>  }
>  
>  static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
> @@ -931,8 +979,8 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
>  		return;
>  	}
>  
> -	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
> -			     NO_CONT_MAPPINGS);
> +	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
> +				 NO_CONT_MAPPINGS);
>  
>  	/* flush the TLBs after updating live kernel mappings */
>  	flush_tlb_kernel_range(virt, virt + size);
> @@ -941,8 +989,8 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
>  static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
>  				  phys_addr_t end, pgprot_t prot, int flags)
>  {
> -	__create_pgd_mapping(pgdp, start, __phys_to_virt(start), end - start,
> -			     prot, early_pgtable_alloc, flags);
> +	early_create_pgd_mapping(pgdp, start, __phys_to_virt(start), end - start,
> +				 prot, early_pgtable_alloc, flags);
>  }
>  
>  void __init mark_linear_text_alias_ro(void)
> @@ -1178,9 +1226,10 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>  		// covers the PTE[] page itself, the remaining entries are free
>  		// to be used as a ad-hoc fixmap.
>  		//
> -		__create_pgd_mapping_locked(kpti_ng_temp_pgd, __pa(alloc),
> -					    KPTI_NG_TEMP_VA, PAGE_SIZE, PAGE_KERNEL,
> -					    kpti_ng_pgd_alloc, 0);
> +		if (__create_pgd_mapping_locked(kpti_ng_temp_pgd, __pa(alloc),
> +						KPTI_NG_TEMP_VA, PAGE_SIZE, PAGE_KERNEL,
> +						kpti_ng_pgd_alloc, 0))
> +			panic("Failed to create page tables\n");
>  	}
>  
>  	cpu_install_idmap();
> @@ -1233,9 +1282,9 @@ static int __init map_entry_trampoline(void)
>  
>  	/* Map only the text into the trampoline page table */
>  	memset(tramp_pg_dir, 0, PGD_SIZE);
> -	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS,
> -			     entry_tramp_text_size(), prot,
> -			     pgd_pgtable_alloc_init_mm, NO_BLOCK_MAPPINGS);
> +	early_create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS,
> +				 entry_tramp_text_size(), prot,
> +				 pgd_pgtable_alloc_init_mm, NO_BLOCK_MAPPINGS);
>  
>  	/* Map both the text and data into the kernel page table */
>  	for (i = 0; i < DIV_ROUND_UP(entry_tramp_text_size(), PAGE_SIZE); i++)
> @@ -1877,23 +1926,30 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	if (force_pte_mapping())
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
> -	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> -			     size, params->pgprot, pgd_pgtable_alloc_init_mm,
> -			     flags);
> +	ret = __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> +				   size, params->pgprot, pgd_pgtable_alloc_init_mm,
> +				   flags);
> +
> +	if (ret)
> +		goto out;
>  
>  	memblock_clear_nomap(start, size);
>  
>  	ret = __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>  			   params);
>  	if (ret)
> -		__remove_pgd_mapping(swapper_pg_dir,
> -				     __phys_to_virt(start), size);
> +		goto out;
>  	else {
>  		/* Address of hotplugged memory can be smaller */
>  		max_pfn = max(max_pfn, PFN_UP(start + size));
>  		max_low_pfn = max_pfn;
>  	}

nit: given the if now does a goto, there is no need for this to be wrapped in an
else block.

Thanks,
Ryan

>  
> +	return 0;
> +
> +out:
> +	__remove_pgd_mapping(swapper_pg_dir,
> +			     __phys_to_virt(start), size);
>  	return ret;
>  }
>  



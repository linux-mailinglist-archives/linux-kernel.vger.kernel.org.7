Return-Path: <linux-kernel+bounces-753507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C8B183F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21521C25393
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8302C24A076;
	Fri,  1 Aug 2025 14:35:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837A246786
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058932; cv=none; b=F5CjQezs6mQQ0DT7Wf+bSHl2FKYU8e+PKSJn9y3hoTFxvA8qG/PB1IVq9OdmET4DnHhDcocIpg+D99bnrXOB7jKElvYGTdxMioZakbbVvkuQPMj9iDMr2DSaIu8m7N1wNgEVpb/E5dLaoDXeyBVuFa6jq3LT+Tg31fmpD/lry8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058932; c=relaxed/simple;
	bh=RAyb9ilXWSZq4ISmgwRBUEYLVYR6MFvxRkA8eIrveU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHL12IsSjp8PgZ98J/9negflH5kfIrgzSdU1yjnGj+of27YoPlRTXfa6Oyx2B3P14+y1y61UkHlylWqjenviMqWpLV+D/vTpi9WQ8dtDoWziEMqbIuRvfgvrbEJOqFNQ1d6MBHNZ7nF+cKYgOLERzTdOY9SrfGV7vSEVS70peQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A2091516;
	Fri,  1 Aug 2025 07:35:21 -0700 (PDT)
Received: from [10.57.87.210] (unknown [10.57.87.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 383D63F673;
	Fri,  1 Aug 2025 07:35:27 -0700 (PDT)
Message-ID: <0e86671e-18bb-4f3b-9294-c583299ad49e@arm.com>
Date: Fri, 1 Aug 2025 15:35:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
 <20250724221216.1998696-4-yang@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250724221216.1998696-4-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 23:11, Yang Shi wrote:
> When rodata=full is specified, kernel linear mapping has to be mapped at
> PTE level since large page table can't be split due to break-before-make
> rule on ARM64.
> 
> This resulted in a couple of problems:
>   - performance degradation
>   - more TLB pressure
>   - memory waste for kernel page table
> 
> With FEAT_BBM level 2 support, splitting large block page table to
> smaller ones doesn't need to make the page table entry invalid anymore.
> This allows kernel split large block mapping on the fly.
> 
> Add kernel page table split support and use large block mapping by
> default when FEAT_BBM level 2 is supported for rodata=full.  When
> changing permissions for kernel linear mapping, the page table will be
> split to smaller size.
> 
> The machine without FEAT_BBM level 2 will fallback to have kernel linear
> mapping PTE-mapped when rodata=full.
> 
> With this we saw significant performance boost with some benchmarks and
> much less memory consumption on my AmpereOne machine (192 cores, 1P) with
> 256GB memory.
> 
> * Memory use after boot
> Before:
> MemTotal:       258988984 kB
> MemFree:        254821700 kB
> 
> After:
> MemTotal:       259505132 kB
> MemFree:        255410264 kB
> 
> Around 500MB more memory are free to use.  The larger the machine, the
> more memory saved.
> 
> * Memcached
> We saw performance degradation when running Memcached benchmark with
> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
> With this patchset we saw ops/sec is increased by around 3.5%, P99
> latency is reduced by around 9.6%.
> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
> MPKI is reduced by 28.5%.
> 
> The benchmark data is now on par with rodata=on too.
> 
> * Disk encryption (dm-crypt) benchmark
> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
> encryption (by dm-crypt).
> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>     --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>     --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>     --name=iops-test-job --eta-newline=1 --size 100G
> 
> The IOPS is increased by 90% - 150% (the variance is high, but the worst
> number of good case is around 90% more than the best number of bad case).
> The bandwidth is increased and the avg clat is reduced proportionally.
> 
> * Sequential file read
> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
> The bandwidth is increased by 150%.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  34 ++++
>  arch/arm64/include/asm/mmu.h        |   1 +
>  arch/arm64/include/asm/pgtable.h    |   5 +
>  arch/arm64/kernel/cpufeature.c      |  31 +--
>  arch/arm64/mm/mmu.c                 | 293 +++++++++++++++++++++++++++-
>  arch/arm64/mm/pageattr.c            |   4 +
>  6 files changed, 333 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index bf13d676aae2..d0d394cc837d 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -871,6 +871,40 @@ static inline bool system_supports_pmuv3(void)
>  	return cpus_have_final_cap(ARM64_HAS_PMUV3);
>  }
>  
> +static inline bool bbml2_noabort_available(void)
> +{
> +	/*
> +	 * We want to allow usage of BBML2 in as wide a range of kernel contexts
> +	 * as possible. This list is therefore an allow-list of known-good
> +	 * implementations that both support BBML2 and additionally, fulfill the
> +	 * extra constraint of never generating TLB conflict aborts when using
> +	 * the relaxed BBML2 semantics (such aborts make use of BBML2 in certain
> +	 * kernel contexts difficult to prove safe against recursive aborts).
> +	 *
> +	 * Note that implementations can only be considered "known-good" if their
> +	 * implementors attest to the fact that the implementation never raises
> +	 * TLB conflict aborts for BBML2 mapping granularity changes.
> +	 */
> +	static const struct midr_range supports_bbml2_noabort_list[] = {
> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
> +		{}
> +	};
> +
> +	/* Does our cpu guarantee to never raise TLB conflict aborts? */
> +	if (!is_midr_in_range_list(supports_bbml2_noabort_list))
> +		return false;
> +
> +	/*
> +	 * We currently ignore the ID_AA64MMFR2_EL1 register, and only care
> +	 * about whether the MIDR check passes.
> +	 */
> +
> +	return true;
> +}

I don't think this function should be inline. Won't we end up duplicating the
midr list everywhere? Suggest moving back to cpufeature.c.

> +
>  static inline bool system_supports_bbml2_noabort(void)
>  {
>  	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 6e8aa8e72601..57f4b25e6f33 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -71,6 +71,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  			       pgprot_t prot, bool page_mappings_only);
>  extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>  extern void mark_linear_text_alias_ro(void);
> +extern int split_kernel_pgtable_mapping(unsigned long start, unsigned long end);
>  
>  /*
>   * This check is triggered during the early boot before the cpufeature
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index ba63c8736666..ad2a6a7e86b0 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -371,6 +371,11 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
>  	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
>  }
>  
> +static inline pmd_t pmd_mknoncont(pmd_t pmd)
> +{
> +	return __pmd(pmd_val(pmd) & ~PMD_SECT_CONT);
> +}
> +
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>  static inline int pte_uffd_wp(pte_t pte)
>  {
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d2a8a509a58e..1c96016a7a41 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2215,36 +2215,7 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>  
>  static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
>  {
> -	/*
> -	 * We want to allow usage of BBML2 in as wide a range of kernel contexts
> -	 * as possible. This list is therefore an allow-list of known-good
> -	 * implementations that both support BBML2 and additionally, fulfill the
> -	 * extra constraint of never generating TLB conflict aborts when using
> -	 * the relaxed BBML2 semantics (such aborts make use of BBML2 in certain
> -	 * kernel contexts difficult to prove safe against recursive aborts).
> -	 *
> -	 * Note that implementations can only be considered "known-good" if their
> -	 * implementors attest to the fact that the implementation never raises
> -	 * TLB conflict aborts for BBML2 mapping granularity changes.
> -	 */
> -	static const struct midr_range supports_bbml2_noabort_list[] = {
> -		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> -		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> -		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
> -		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
> -		{}
> -	};
> -
> -	/* Does our cpu guarantee to never raise TLB conflict aborts? */
> -	if (!is_midr_in_range_list(supports_bbml2_noabort_list))
> -		return false;
> -
> -	/*
> -	 * We currently ignore the ID_AA64MMFR2_EL1 register, and only care
> -	 * about whether the MIDR check passes.
> -	 */
> -
> -	return true;
> +	return bbml2_noabort_available();
>  }
>  
>  #ifdef CONFIG_ARM64_PAN
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 3d5fb37424ab..f63b39613571 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -480,6 +480,8 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>  			     int flags);
>  #endif
>  
> +#define INVALID_PHYS_ADDR	-1
> +
>  static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>  				       enum pgtable_type pgtable_type)
>  {
> @@ -487,7 +489,9 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>  	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
>  	phys_addr_t pa;
>  
> -	BUG_ON(!ptdesc);
> +	if (!ptdesc)
> +		return INVALID_PHYS_ADDR;
> +
>  	pa = page_to_phys(ptdesc_page(ptdesc));
>  
>  	switch (pgtable_type) {
> @@ -509,15 +513,29 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>  }
>  
>  static phys_addr_t __maybe_unused
> -pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
> +split_pgtable_alloc(enum pgtable_type pgtable_type)
>  {
>  	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
>  }
>  
> +static phys_addr_t __maybe_unused
> +pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
> +{
> +	phys_addr_t pa;
> +
> +	pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
> +	BUG_ON(pa == INVALID_PHYS_ADDR);
> +	return pa;
> +}
> +
>  static phys_addr_t
>  pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
>  {
> -	return __pgd_pgtable_alloc(NULL, pgtable_type);
> +	phys_addr_t pa;
> +
> +	pa = __pgd_pgtable_alloc(NULL, pgtable_type);
> +	BUG_ON(pa == INVALID_PHYS_ADDR);
> +	return pa;
>  }

The allocation all looks clean to me now. Thanks.

>  
>  /*
> @@ -552,6 +570,254 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  			     pgd_pgtable_alloc_special_mm, flags);
>  }
>  
> +static DEFINE_MUTEX(pgtable_split_lock);
> +
> +static int split_cont_pte(pmd_t *pmdp, unsigned long addr, unsigned long end)
> +{
> +	pte_t *ptep;
> +	unsigned long next;
> +	unsigned int nr;
> +	unsigned long span;
> +
> +	ptep = pte_offset_kernel(pmdp, addr);
> +
> +	do {
> +		pte_t *_ptep;
> +
> +		nr = 0;
> +		next = pte_cont_addr_end(addr, end);
> +		if (next < end)
> +			nr = max(nr, ((end - next) / CONT_PTE_SIZE));
> +		span = nr * CONT_PTE_SIZE;
> +
> +		_ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
> +		ptep += pte_index(next) - pte_index(addr) + nr * CONT_PTES;
> +
> +		if (((addr | next) & ~CONT_PTE_MASK) == 0)
> +			continue;
> +
> +		if (!pte_cont(__ptep_get(_ptep)))
> +			continue;
> +
> +		for (int i = 0; i < CONT_PTES; i++, _ptep++)
> +			__set_pte(_ptep, pte_mknoncont(__ptep_get(_ptep)));
> +	} while (addr = next + span, addr != end);
> +
> +	return 0;
> +}
> +
> +static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end)
> +{
> +	unsigned long next;
> +	unsigned int nr;
> +	unsigned long span;
> +	int ret = 0;
> +
> +	do {
> +		pmd_t pmd;
> +
> +		nr = 1;
> +		next = pmd_addr_end(addr, end);
> +		if (next < end)
> +			nr = max(nr, ((end - next) / PMD_SIZE));
> +		span = (nr - 1) * PMD_SIZE;
> +
> +		if (((addr | next) & ~PMD_MASK) == 0)
> +			continue;
> +
> +		pmd = pmdp_get(pmdp);
> +		if (pmd_leaf(pmd)) {
> +			phys_addr_t pte_phys;
> +			pte_t *ptep;
> +			pmdval_t pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN |
> +					  PMD_TABLE_AF;
> +			unsigned long pfn = pmd_pfn(pmd);
> +			pgprot_t prot = pmd_pgprot(pmd);
> +
> +			pte_phys = split_pgtable_alloc(TABLE_PTE);
> +			if (pte_phys == INVALID_PHYS_ADDR)
> +				return -ENOMEM;
> +
> +			if (pgprot_val(prot) & PMD_SECT_PXN)
> +				pmdval |= PMD_TABLE_PXN;
> +
> +			prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) |
> +					PTE_TYPE_PAGE);
> +			prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> +			ptep = (pte_t *)phys_to_virt(pte_phys);
> +			for (int i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
> +				__set_pte(ptep, pfn_pte(pfn, prot));
> +
> +			dsb(ishst);
> +
> +			__pmd_populate(pmdp, pte_phys, pmdval);
> +		}
> +
> +		ret = split_cont_pte(pmdp, addr, next);
> +		if (ret)
> +			break;
> +	} while (pmdp += nr, addr = next + span, addr != end);
> +
> +	return ret;
> +}
> +
> +static int split_cont_pmd(pud_t *pudp, unsigned long addr, unsigned long end)
> +{
> +	pmd_t *pmdp;
> +	unsigned long next;
> +	unsigned int nr;
> +	unsigned long span;
> +	int ret = 0;
> +
> +	pmdp = pmd_offset(pudp, addr);
> +
> +	do {
> +		pmd_t *_pmdp;
> +
> +		nr = 0;
> +		next = pmd_cont_addr_end(addr, end);
> +		if (next < end)
> +			nr = max(nr, ((end - next) / CONT_PMD_SIZE));
> +		span = nr * CONT_PMD_SIZE;
> +
> +		if (((addr | next) & ~CONT_PMD_MASK) == 0) {
> +			pmdp += pmd_index(next) - pmd_index(addr) +
> +				nr * CONT_PMDS;
> +			continue;
> +		}
> +
> +		_pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
> +		if (!pmd_cont(pmdp_get(_pmdp)))
> +			goto split;
> +
> +		for (int i = 0; i < CONT_PMDS; i++, _pmdp++)
> +			set_pmd(_pmdp, pmd_mknoncont(pmdp_get(_pmdp)));
> +
> +split:
> +		ret = split_pmd(pmdp, addr, next);
> +		if (ret)
> +			break;
> +
> +		pmdp += pmd_index(next) - pmd_index(addr) + nr * CONT_PMDS;
> +	} while (addr = next + span, addr != end);
> +
> +	return ret;
> +}
> +
> +static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end)
> +{
> +	pud_t *pudp;
> +	unsigned long next;
> +	unsigned int nr;
> +	unsigned long span;
> +	int ret = 0;
> +
> +	pudp = pud_offset(p4dp, addr);
> +
> +	do {
> +		pud_t pud;
> +
> +		nr = 1;
> +		next = pud_addr_end(addr, end);
> +		if (next < end)
> +			nr = max(nr, ((end - next) / PUD_SIZE));
> +		span = (nr - 1) * PUD_SIZE;
> +
> +		if (((addr | next) & ~PUD_MASK) == 0)
> +			continue;
> +
> +		pud = pudp_get(pudp);
> +		if (pud_leaf(pud)) {
> +			phys_addr_t pmd_phys;
> +			pmd_t *pmdp;
> +			pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN |
> +					  PUD_TABLE_AF;
> +			unsigned long pfn = pud_pfn(pud);
> +			pgprot_t prot = pud_pgprot(pud);
> +			unsigned int step = PMD_SIZE >> PAGE_SHIFT;
> +
> +			pmd_phys = split_pgtable_alloc(TABLE_PMD);
> +			if (pmd_phys == INVALID_PHYS_ADDR)
> +				return -ENOMEM;
> +
> +			if (pgprot_val(prot) & PMD_SECT_PXN)
> +				pudval |= PUD_TABLE_PXN;
> +
> +			prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) |
> +					PMD_TYPE_SECT);
> +			prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> +			pmdp = (pmd_t *)phys_to_virt(pmd_phys);
> +			for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
> +				set_pmd(pmdp, pfn_pmd(pfn, prot));
> +				pfn += step;
> +			}
> +
> +			dsb(ishst);
> +
> +			__pud_populate(pudp, pmd_phys, pudval);
> +		}
> +
> +		ret = split_cont_pmd(pudp, addr, next);
> +		if (ret)
> +			break;
> +	} while (pudp += nr, addr = next + span, addr != end);
> +
> +	return ret;
> +}
> +
> +static int split_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end)
> +{
> +	p4d_t *p4dp;
> +	unsigned long next;
> +	int ret = 0;
> +
> +	p4dp = p4d_offset(pgdp, addr);
> +
> +	do {
> +		next = p4d_addr_end(addr, end);
> +
> +		ret = split_pud(p4dp, addr, next);
> +		if (ret)
> +			break;
> +	} while (p4dp++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +static int split_pgd(pgd_t *pgdp, unsigned long addr, unsigned long end)
> +{
> +	unsigned long next;
> +	int ret = 0;
> +
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		ret = split_p4d(pgdp, addr, next);
> +		if (ret)
> +			break;
> +	} while (pgdp++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +int split_kernel_pgtable_mapping(unsigned long start, unsigned long end)
> +{
> +	int ret;
> +
> +	if (!system_supports_bbml2_noabort())
> +		return 0;
> +
> +	if (start != PAGE_ALIGN(start) || end != PAGE_ALIGN(end))
> +		return -EINVAL;
> +
> +	mutex_lock(&pgtable_split_lock);

On reflection, I agree this lock approach is simpler than my suggestion to do it
locklessly and I doubt this will become a bottleneck. Given x86 does it this
way, I guess it's fine.

> +	arch_enter_lazy_mmu_mode();
> +	ret = split_pgd(pgd_offset_k(start), start, end);

My instinct still remains that it would be better not to iterate over the range
here, but instead call a "split(start); split(end);" since we just want to split
the start and end. So the code would be simpler and probably more performant if
we get rid of all the iteration.

But I'm guessing you are going to enhance this infra in the next patch to
support splitting all entries in the range for the system-doesn't-support-bbml case?

Anyway, I'll take a look at the next patch then come back to review the details
of split_pgd().

> +	arch_leave_lazy_mmu_mode();
> +	mutex_unlock(&pgtable_split_lock);
> +
> +	return ret;
> +}
> +
>  static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
>  				phys_addr_t size, pgprot_t prot)
>  {
> @@ -639,6 +905,20 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>  
>  #endif /* CONFIG_KFENCE */
>  
> +bool linear_map_requires_bbml2;

Until the next patch, you're only using this variable in this file, so at the
very least, it should be static for now. But I'm proposing below it should be
removed entirely.

> +
> +static inline bool force_pte_mapping(void)
> +{
> +	/*
> +	 * Can't use cpufeature API to determine whether BBM level 2
> +	 * is supported or not since cpufeature have not been
> +	 * finalized yet.
> +	 */
> +	return (!bbml2_noabort_available() && (rodata_full ||
> +		arm64_kfence_can_set_direct_map() || is_realm_world())) ||
> +		debug_pagealloc_enabled();
> +}
> +
>  static void __init map_mem(pgd_t *pgdp)
>  {
>  	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
> @@ -664,7 +944,9 @@ static void __init map_mem(pgd_t *pgdp)
>  
>  	early_kfence_pool = arm64_kfence_alloc_pool();
>  
> -	if (can_set_direct_map())
> +	linear_map_requires_bbml2 = !force_pte_mapping() && rodata_full;

This looks wrong; what about the kfence_can_set_direct_map and is_realm_world
conditions?

perhaps:

	linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map()

> +
> +	if (force_pte_mapping())
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
>  	/*
> @@ -1366,7 +1648,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  
>  	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>  
> -	if (can_set_direct_map())
> +	if (force_pte_mapping() ||
> +	    (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()))

So force_pte_mapping() isn't actually returning what it sounds like it is; it's
returning whether you would have to force pte mapping based on the current cpu's
support for bbml2. Perhaps it would be better to implement force_pte_mapping()  as:

static inline bool force_pte_mapping(void)
{
	bool bbml2 = (system_capabilities_finalized() &&
			system_supports_bbml2_noabort()) ||
			bbml2_noabort_available();

	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
			   is_realm_world())) ||
		debug_pagealloc_enabled();
}

Then we can just use force_pte_mapping() in both the boot and runtime paths
without any adjustment based on linear_map_requires_bbml2. So you could drop
linear_map_requires_bbml2 entirely, until the next patch at least.

>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
>  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index c6a85000fa0e..6566aa9d8abb 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -140,6 +140,10 @@ static int update_range_prot(unsigned long start, unsigned long size,
>  	data.set_mask = set_mask;
>  	data.clear_mask = clear_mask;
>  
> +	ret = split_kernel_pgtable_mapping(start, start + size);
> +	if (WARN_ON_ONCE(ret))

I'm on the fence as to whether this warning is desirable. Would we normally want
to warn in an OOM situation, or just unwind and carry on?

Thanks,
Ryan


> +		return ret;
> +
>  	arch_enter_lazy_mmu_mode();
>  
>  	/*



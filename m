Return-Path: <linux-kernel+bounces-852135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65612BD83EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97478427517
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4A30FF2B;
	Tue, 14 Oct 2025 08:43:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CB930FF1E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431429; cv=none; b=dsegGFs932wt8OPInobxo38+YQIP+zk6Z4DRmpb42Nb+rpn6yTR8y7Yn3zQ6m1nW/N0vHD2SgpJojyi7dsiLwhwfgEBBGYNPYKTuLW2JMms4yvC09gNBmKYKsHecHlaJnv1KiEk469TD1eoNPBWimDLtoL7kbMeR8Z21rP1OL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431429; c=relaxed/simple;
	bh=1aBJImo6cF5jG2gW6WHM0vPf7XQpzXgoY73njuJm0hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JG6RbqP5GhWwkrcDqIIclaLjFa7avldjJlbeCSdJFNqEAcUvcNoSeiXc08O3G1Rm+i0yPkMth/yw1W9Y6eDadeobKxIf0JSNTVcM0Kb1nTaacN4iT58A6FQLoTlYC6o8k/TFghXgo0tKT2C1OYQUwtgd4fALrMc+fBRMOFQdJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6A61A9A;
	Tue, 14 Oct 2025 01:43:39 -0700 (PDT)
Received: from [10.57.83.223] (unknown [10.57.83.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4CFD3F6A8;
	Tue, 14 Oct 2025 01:43:45 -0700 (PDT)
Message-ID: <91f6da2f-1968-4c23-a534-20b463463faf@arm.com>
Date: Tue, 14 Oct 2025 09:43:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: show direct mapping use in /proc/meminfo
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013235118.3072941-1-yang@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251013235118.3072941-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 00:51, Yang Shi wrote:
> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
> rodata=full"), the direct mapping may be split on some machines instead
> keeping static since boot. It makes more sense to show the direct mapping
> use in /proc/meminfo than before.

It's possible to divine this information from
/sys/kernel/debug/kernel_page_tables. Dev even has a script to post-process that
to provide summary stats on how much memory is mapped by each block size.

Admittedly, this file is in debugfs and is not usually enabled for production
builds, but Dev's patch Commit fa93b45fd397 ("arm64: Enable vmalloc-huge with
ptdump"), merged for v6.18-rc1 gives us a path to enabling by default I think?

But I can see the benefits of having this easily available, and I notice that
other arches are already doing this. So I guess it makes sense to be consistent.

> This patch will make /proc/meminfo show the direct mapping use like the
> below (4K base page size):
> DirectMap4K:	   94792 kB
> DirectMap64K:	  134208 kB
> DirectMap2M:	 1173504 kB
> DirectMap32M:	 5636096 kB
> DirectMap1G:	529530880 kB

nit: x86, s390 and powerpc use a lower case "k" for DirectMap4k; perhaps we
should follow suit? (despite being ugly). Although I think that's usually used
to denote base-10 (i.e. 1000 bytes)? That's not the case here, we want base-2.

> 
> Although just the machines which support BBML2_NOABORT can split the
> direct mapping, show it on all machines regardless of BBML2_NOABORT so
> that the users have consistent view in order to avoid confusion.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/mm/mmu.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b8d37eb037fc..e5da0f521e58 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -29,6 +29,7 @@
>  #include <linux/mm_inline.h>
>  #include <linux/pagewalk.h>
>  #include <linux/stop_machine.h>
> +#include <linux/proc_fs.h>
>  
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
> @@ -51,6 +52,17 @@
>  
>  DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
>  
> +enum direct_map_type {
> +	PTE,
> +	CONT_PTE,
> +	PMD,
> +	CONT_PMD,
> +	PUD,
> +	NR_DIRECT_MAP_TYPE,
> +};
> +
> +unsigned long direct_map_cnt[NR_DIRECT_MAP_TYPE];

I wonder if it would be cleaner to store this in bytes rather than blocks? Then
in the code you can just add PAGE_SIZE, CONT_PTE_SIZE, PMD_SIZE, etc as
appropriate, then the reporting function becomes simpler; everything is just
shifted by 10 to get kB; no need for the shift array.

> +
>  u64 kimage_voffset __ro_after_init;
>  EXPORT_SYMBOL(kimage_voffset);
>  
> @@ -171,6 +183,60 @@ static void init_clear_pgtable(void *table)
>  	dsb(ishst);
>  }
>  
> +void arch_report_meminfo(struct seq_file *m)
> +{
> +	char *size[NR_DIRECT_MAP_TYPE];
> +	unsigned int shift[NR_DIRECT_MAP_TYPE];
> +
> +#if defined(CONFIG_ARM64_4K_PAGES)
> +	size[PTE] = "4K";
> +	size[CONT_PTE] = "64K";
> +	size[PMD] = "2M";
> +	size[CONT_PMD] = "32M";
> +	size[PUD] = "1G";
> +
> +	shift[PTE] = 2;
> +	shift[CONT_PTE] = 6;
> +	shift[PMD] = 11;
> +	shift[CONT_PMD] = 15;
> +	shift[PUD] = 20;
> +#elif defined(CONFIG_ARM64_16K_PAGES)
> +	size[PTE] = "16K";
> +	size[CONT_PTE] = "2M";
> +	size[PMD] = "32M";
> +	size[CONT_PMD] = "1G";
> +
> +	shift[PTE] = 4;
> +	shift[CONT_PTE] = 11;
> +	shift[PMD] = 15;
> +	shift[CONT_PMD] = 20;
> +#elif defined(CONFIG_ARM64_64K_PAGES)
> +	size[PTE] = "64K";
> +	size[CONT_PTE] = "2M";
> +	size[PMD] = "512M";
> +	size[CONT_PMD] = "16G";
> +
> +	shift[PTE] = 6;
> +	shift[CONT_PTE] = 11;
> +	shift[PMD] = 19;
> +	shift[CONT_PMD] = 24;
> +#endif

The ifdeffery is quite ugly. I think we can get rid of the shift array as per
above. I was hoping there might be a kernel function that we could pass
PAGE_SIZE, PMD_SIZE, etc to and it would give us an appropriate string but I
can't find anything. I guess keping the ifdef for size[] is the most pragmatic.

> +
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[PTE], direct_map_cnt[PTE] << shift[PTE]);
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[CONT_PTE],
> +			direct_map_cnt[CONT_PTE] << shift[CONT_PTE]);
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[PMD], direct_map_cnt[PMD] << shift[PMD]);
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[CONT_PMD],
> +			direct_map_cnt[CONT_PMD] << shift[CONT_PMD]);
> +	if (pud_sect_supported())
> +		seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[PUD], direct_map_cnt[PUD] << shift[PUD]);
> +}
> +
>  static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  		     phys_addr_t phys, pgprot_t prot)
>  {
> @@ -183,6 +249,9 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  		 */
>  		__set_pte_nosync(ptep, pfn_pte(__phys_to_pfn(phys), prot));
>  
> +		if (!(pgprot_val(prot) & PTE_CONT))
> +			direct_map_cnt[PTE]++;

If adding size in bytes, you could just always add PAGE_SIZE here, but select
the bucket based on PTE_CONT?

> +
>  		/*
>  		 * After the PTE entry has been populated once, we
>  		 * only allow updates to the permission attributes.
> @@ -229,8 +298,10 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  
>  		/* use a contiguous mapping if the range is suitably aligned */
>  		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> -		    (flags & NO_CONT_MAPPINGS) == 0)
> +		    (flags & NO_CONT_MAPPINGS) == 0) {
>  			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> +			direct_map_cnt[CONT_PTE]++;

Then you don't need this.

> +		}
>  
>  		init_pte(ptep, addr, next, phys, __prot);
>  
> @@ -262,6 +333,9 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>  			pmd_set_huge(pmdp, phys, prot);
>  
> +			if (!(pgprot_val(prot) & PTE_CONT))
> +				direct_map_cnt[PMD]++;

Same here...

> +
>  			/*
>  			 * After the PMD entry has been populated once, we
>  			 * only allow updates to the permission attributes.
> @@ -317,8 +391,10 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  
>  		/* use a contiguous mapping if the range is suitably aligned */
>  		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
> -		    (flags & NO_CONT_MAPPINGS) == 0)
> +		    (flags & NO_CONT_MAPPINGS) == 0) {
>  			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> +			direct_map_cnt[CONT_PMD]++;

Then this can go too.

> +		}
>  
>  		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
>  
> @@ -368,6 +444,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>  			pud_set_huge(pudp, phys, prot);
>  
> +			direct_map_cnt[PUD]++;
>  			/*
>  			 * After the PUD entry has been populated once, we
>  			 * only allow updates to the permission attributes.
> @@ -532,9 +609,13 @@ static void split_contpte(pte_t *ptep)
>  {
>  	int i;
>  
> +	direct_map_cnt[CONT_PTE]--;
> +
>  	ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
>  	for (i = 0; i < CONT_PTES; i++, ptep++)
>  		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
> +
> +	direct_map_cnt[PTE] += CONT_PTES;
>  }
>  
>  static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> @@ -559,8 +640,10 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>  	if (to_cont)
>  		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
> +	direct_map_cnt[PMD]--;
>  	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>  		__set_pte(ptep, pfn_pte(pfn, prot));
> +	direct_map_cnt[CONT_PTE] += PTRS_PER_PTE / CONT_PTES;
>  
>  	/*
>  	 * Ensure the pte entries are visible to the table walker by the time
> @@ -576,9 +659,13 @@ static void split_contpmd(pmd_t *pmdp)
>  {
>  	int i;
>  
> +	direct_map_cnt[CONT_PMD]--;
> +
>  	pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
>  	for (i = 0; i < CONT_PMDS; i++, pmdp++)
>  		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
> +
> +	direct_map_cnt[PMD] += CONT_PMDS;
>  }
>  
>  static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> @@ -604,8 +691,10 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>  	if (to_cont)
>  		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
> +	direct_map_cnt[PUD]--;
>  	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
>  		set_pmd(pmdp, pfn_pmd(pfn, prot));
> +	direct_map_cnt[CONT_PMD] += PTRS_PER_PMD/CONT_PMDS;
>  
>  	/*
>  	 * Ensure the pmd entries are visible to the table walker by the time



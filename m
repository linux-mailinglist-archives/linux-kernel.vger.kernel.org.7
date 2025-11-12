Return-Path: <linux-kernel+bounces-896951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2054BC519A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C82188F9E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0B301032;
	Wed, 12 Nov 2025 10:16:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0962F9984
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942571; cv=none; b=cgenWIH1/jF5rGoZnB/tjilSK7ux6NTW8aRZianDHCzDAX/8A9T44HHQR5OgA2hN8RwPkpWosABswnRtI7/HsvJ+zEdtXrRDm2yi87rpufBmsTbwc8ll+5/vztVYC4D2S7dqwXezjBMKFOOblADxEyWmsGPY2+ojsUdG2VVQ6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942571; c=relaxed/simple;
	bh=Fw3Uo3g+eQ/Tkbr7QgOBAK2XH/aCaiR8M3RgU+QI78o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piRwRTAMv881ZLs9rasrJkHYICZDn9O7XBfGqdznx/c3qFWwJiHyLL0c4rY2UH23vawdGi8DHWo7l3ydSUGjcrl6mj1NulaE6L78GeHuumIQ69MMWcH7G406eVCjkAUAVzHVnCAXRHhrJSq400MV3L+za8aBIwJ//sx5c4SyZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5403F1515;
	Wed, 12 Nov 2025 02:16:01 -0800 (PST)
Received: from [10.1.34.178] (XHFQ2J9959.cambridge.arm.com [10.1.34.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 220DF3F5A1;
	Wed, 12 Nov 2025 02:16:07 -0800 (PST)
Message-ID: <3af5d651-5363-47f7-b828-702d9a0c881c@arm.com>
Date: Wed, 12 Nov 2025 10:16:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arm64: mm: show direct mapping use in /proc/meminfo
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251023215210.501168-1-yang@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251023215210.501168-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yang,


On 23/10/2025 22:52, Yang Shi wrote:
> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
> rodata=full"), the direct mapping may be split on some machines instead
> keeping static since boot. It makes more sense to show the direct mapping
> use in /proc/meminfo than before.
> This patch will make /proc/meminfo show the direct mapping use like the
> below (4K base page size):
> DirectMap4K:	   94792 kB
> DirectMap64K:	  134208 kB
> DirectMap2M:	 1173504 kB
> DirectMap32M:	 5636096 kB
> DirectMap1G:	529530880 kB

I have a long-term aspiration to enable "per-process page size", where each user
space process can use a different page size. The first step is to be able to
emulate a page size to the process which is larger than the kernel's. For that
reason, I really dislike introducing new ABI that exposes the geometry of the
kernel page tables to user space. I'd really like to be clear on what use case
benefits from this sort of information before we add it.

nit: arm64 tends to use the term "linear map" not "direct map". I'm not sure why
or what the history is. Given this is arch-specific should we be aligning on the
architecture's terminology here? I don't know...

> 
> Although just the machines which support BBML2_NOABORT can split the
> direct mapping, show it on all machines regardless of BBML2_NOABORT so
> that the users have consistent view in order to avoid confusion.
> 
> Although ptdump also can tell the direct map use, but it needs to dump
> the whole kernel page table. It is costly and overkilling. It is also
> in debugfs which may not be enabled by all distros. So showing direct
> map use in /proc/meminfo seems more convenient and has less overhead.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/mm/mmu.c | 86 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> v2: * Counted in size instead of the number of entries per Ryan
>     * Removed shift array per Ryan
>     * Use lower case "k" per Ryan
>     * Fixed a couple of build warnings reported by kernel test robot
>     * Fixed a couple of poential miscounts 
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b8d37eb037fc..7207b55d0046 100644
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
> +static unsigned long direct_map_size[NR_DIRECT_MAP_TYPE];

I wonder if you should wrap all the adds and subtracts into a helper function,
which can then be defined as a nop when !CONFIG_PROC_FS. It means we only need
direct_map_size[] when PROC_FS is enabled too.

e.g.

#ifdef CONFIG_PROC_FS
static unsigned long direct_map_size[NR_DIRECT_MAP_TYPE];

static inline void direct_map_meminfo_add(unsigned long size,
					  enum direct_map_type type)
{
	direct_map_size[type] += size;
}

static inline void direct_map_meminfo_sub(unsigned long size,
					  enum direct_map_type type)
{
	direct_map_size[type] -= size;
}
#else
static inline void direct_map_meminfo_add(unsigned long size,
					  enum direct_map_type type) {}
static inline void direct_map_meminfo_sub(unsigned long size,
					  enum direct_map_type type) {}
#endif

Then use it like this:
direct_map_meminfo_sub(next - addr, PMD);
direct_map_meminfo_add(next - addr, to_cont ? CONT_PTE : PTE);

> +
>  u64 kimage_voffset __ro_after_init;
>  EXPORT_SYMBOL(kimage_voffset);
>  
> @@ -171,6 +183,45 @@ static void init_clear_pgtable(void *table)
>  	dsb(ishst);
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +void arch_report_meminfo(struct seq_file *m)
> +{
> +	char *size[NR_DIRECT_MAP_TYPE];
> +
> +#if defined(CONFIG_ARM64_4K_PAGES)
> +	size[PTE] = "4k";
> +	size[CONT_PTE] = "64k";
> +	size[PMD] = "2M";
> +	size[CONT_PMD] = "32M";
> +	size[PUD] = "1G";
> +#elif defined(CONFIG_ARM64_16K_PAGES)
> +	size[PTE] = "16k";
> +	size[CONT_PTE] = "2M";
> +	size[PMD] = "32M";
> +	size[CONT_PMD] = "1G";
> +#elif defined(CONFIG_ARM64_64K_PAGES)
> +	size[PTE] = "64k";
> +	size[CONT_PTE] = "2M";
> +	size[PMD] = "512M";
> +	size[CONT_PMD] = "16G";
> +#endif
> +
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[PTE], direct_map_size[PTE] >> 10);
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[CONT_PTE],
> +			direct_map_size[CONT_PTE] >> 10);
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[PMD], direct_map_size[PMD] >> 10);
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[CONT_PMD],
> +			direct_map_size[CONT_PMD] >> 10);
> +	if (pud_sect_supported())
> +		seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[PUD], direct_map_size[PUD] >> 10);
> +}
> +#endif
> +
>  static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  		     phys_addr_t phys, pgprot_t prot)
>  {
> @@ -234,6 +285,11 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  
>  		init_pte(ptep, addr, next, phys, __prot);
>  
> +		if (pgprot_val(__prot) & PTE_CONT)
> +			direct_map_size[CONT_PTE] += next - addr;
> +		else
> +			direct_map_size[PTE] += next - addr;
> +
>  		ptep += pte_index(next) - pte_index(addr);
>  		phys += next - addr;
>  	} while (addr = next, addr != end);
> @@ -262,6 +318,17 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>  			pmd_set_huge(pmdp, phys, prot);
>  
> +			/*
> +			 * It is possible to have mappings allow cont mapping
> +			 * but disallow block mapping. For example,
> +			 * map_entry_trampoline().
> +			 * So we have to increase CONT_PMD and PMD size here
> +			 * to avoid double counting.
> +			 */
> +			if (pgprot_val(prot) & PTE_CONT)
> +				direct_map_size[CONT_PMD] += next - addr;
> +			else
> +				direct_map_size[PMD] += next - addr;
>  			/*
>  			 * After the PMD entry has been populated once, we
>  			 * only allow updates to the permission attributes.
> @@ -368,6 +435,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>  			pud_set_huge(pudp, phys, prot);
>  
> +			direct_map_size[PUD] += next - addr;

I think this (and all the lower levels) are likely over-accounting. For example,
__kpti_install_ng_mappings() and map_entry_trampoline() reuse the infra to
create separate pgtables. Then you have fixmap, which uses
create_mapping_noalloc(), efi which uses create_pgd_mapping() and
update_mapping_prot() used to change permissions for various parts of the kernel
image. They all reuse the infra too.

>  			/*
>  			 * After the PUD entry has been populated once, we
>  			 * only allow updates to the permission attributes.
> @@ -532,9 +600,13 @@ static void split_contpte(pte_t *ptep)
>  {
>  	int i;
>  
> +	direct_map_size[CONT_PTE] -= CONT_PTE_SIZE;
> +
>  	ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
>  	for (i = 0; i < CONT_PTES; i++, ptep++)
>  		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
> +
> +	direct_map_size[PTE] += CONT_PTE_SIZE;

Similar issue: we aspire to reuse this split_* infra for regions other than the
linear map - e.g. vmalloc. So I don't like the idea of baking in an assumption
that any split is definitely targetting the linear map.

I guess if you pass the start and end VA to the add/subtract function, it could
fitler based on whether the region is within the linear map region?

Overall, I'm personally not a huge fan of adding this capability. I'd need to
understand the use case to change my mind. But I'm not the maintainer so perhaps
my opinion isn't all that important ;-)

Thanks,
Ryan

>  }
>  
>  static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> @@ -559,8 +631,13 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>  	if (to_cont)
>  		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
> +	direct_map_size[PMD] -= PMD_SIZE;
>  	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>  		__set_pte(ptep, pfn_pte(pfn, prot));
> +	if (to_cont)
> +		direct_map_size[CONT_PTE] += PMD_SIZE;
> +	else
> +		direct_map_size[PTE] += PMD_SIZE;
>  
>  	/*
>  	 * Ensure the pte entries are visible to the table walker by the time
> @@ -576,9 +653,13 @@ static void split_contpmd(pmd_t *pmdp)
>  {
>  	int i;
>  
> +	direct_map_size[CONT_PMD] -= CONT_PMD_SIZE;
> +
>  	pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
>  	for (i = 0; i < CONT_PMDS; i++, pmdp++)
>  		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
> +
> +	direct_map_size[PMD] += CONT_PMD_SIZE;
>  }
>  
>  static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> @@ -604,8 +685,13 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>  	if (to_cont)
>  		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
> +	direct_map_size[PUD] -= PUD_SIZE;
>  	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
>  		set_pmd(pmdp, pfn_pmd(pfn, prot));
> +	if (to_cont)
> +		direct_map_size[CONT_PMD] += PUD_SIZE;
> +	else
> +		direct_map_size[PMD] += PUD_SIZE;
>  
>  	/*
>  	 * Ensure the pmd entries are visible to the table walker by the time



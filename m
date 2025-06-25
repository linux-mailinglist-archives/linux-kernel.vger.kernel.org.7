Return-Path: <linux-kernel+bounces-702321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36868AE80D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B663B77DC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A8F2BDC39;
	Wed, 25 Jun 2025 11:20:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8109225A330
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850419; cv=none; b=qCvh7VDlQmWzrRPHCi+Ei+K022ktdvhP8wjh6U/viV4++8ZqxiUNa/lu+4xs/cFa4Fv3Cud5Fvzea2qcGi/XR53GK/gmOFAQWAzGjGlHIoYH3YgxJbEozZvyatDRDWOr6cEIBvJ2U6hCaMXleAxftgFYAQ94Fz3MeDiiCWnKFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850419; c=relaxed/simple;
	bh=qLPnTBOGjWKvya0CPvaIoaDSwAHpeD6twCZCdChVXoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjI/joImgEq1nTSq//5abfwArBQt5xIf0HIhO9PD4a6fHhmTYL4m/uf1YZlsL3akNTsRMY+m8AJdRormVWVZjgATQXZO7hlcvZnSokSG9kyLVyRIjcuhdnqPNodrCC4yYoCVeNU2zA5ur+Qc9WWgy2JOqgpnmWLN0R14t01AjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A82C5106F;
	Wed, 25 Jun 2025 04:19:58 -0700 (PDT)
Received: from [10.57.84.221] (unknown [10.57.84.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6DE03F58B;
	Wed, 25 Jun 2025 04:20:13 -0700 (PDT)
Message-ID: <16959652-d9cf-4365-892a-a4b5825d0f02@arm.com>
Date: Wed, 25 Jun 2025 12:20:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: pageattr: Use pagewalk API to change memory
 permissions
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 catalin.marinas@arm.com, will@kernel.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, steven.price@arm.com,
 gshan@redhat.com, linux-arm-kernel@lists.infradead.org,
 yang@os.amperecomputing.com, anshuman.khandual@arm.com
References: <20250613134352.65994-1-dev.jain@arm.com>
 <20250613134352.65994-2-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250613134352.65994-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/2025 14:43, Dev Jain wrote:
> arm64 currently changes permissions on vmalloc objects locklessly, via
> apply_to_page_range, whose limitation is to deny changing permissions for
> block mappings. Therefore, we move away to use the generic pagewalk API,
> thus paving the path for enabling huge mappings by default on kernel space
> mappings, thus leading to more efficient TLB usage. However, the API
> currently enforces the init_mm.mmap_lock to be held. To avoid the
> unnecessary bottleneck of the mmap_lock for our usecase, this patch
> extends this generic API to be used locklessly, so as to retain the
> existing behaviour for changing permissions. Apart from this reason, it is
> noted at [1] that KFENCE can manipulate kernel pgtable entries during
> softirqs. It does this by calling set_memory_valid() -> __change_memory_common().
> This being a non-sleepable context, we cannot take the init_mm mmap lock.
> 
> Add comments to highlight the conditions under which we can use the
> lockless variant - no underlying VMA, and the user having exclusive control
> over the range, thus guaranteeing no concurrent access.
> 
> Since arm64 cannot handle kernel live mapping splitting without BBML2,
> we require that the start and end of a given range lie on block mapping
> boundaries. Return -EINVAL in case a partial block mapping is detected;
> add a corresponding comment in ___change_memory_common() to warn that
> eliminating such a condition is the responsibility of the caller.
> 
> apply_to_page_range() currently performs all pte level callbacks while in
> lazy mmu mode. Since arm64 can optimize performance by batching barriers
> when modifying kernel pgtables in lazy mmu mode, we would like to continue
> to benefit from this optimisation. Unfortunately walk_kernel_page_table_range()
> does not use lazy mmu mode. However, since the pagewalk framework is not
> allocating any memory, we can safely bracket the whole operation inside
> lazy mmu mode ourselves. Therefore, wrap the call to
> walk_kernel_page_table_range() with the lazy MMU helpers.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/89d0ad18-4772-4d8f-ae8a-7c48d26a927e@arm.com/
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM; with the nits raised by other folks addressed:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  arch/arm64/mm/pageattr.c | 157 +++++++++++++++++++++++++++++++--------
>  include/linux/pagewalk.h |   3 +
>  mm/pagewalk.c            |  26 +++++++
>  3 files changed, 154 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 04d4a8f676db..cfc5279f27a2 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -8,6 +8,7 @@
>  #include <linux/mem_encrypt.h>
>  #include <linux/sched.h>
>  #include <linux/vmalloc.h>
> +#include <linux/pagewalk.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/pgtable-prot.h>
> @@ -20,6 +21,99 @@ struct page_change_data {
>  	pgprot_t clear_mask;
>  };
>  
> +static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
> +{
> +	struct page_change_data *masks = walk->private;
> +
> +	val &= ~(pgprot_val(masks->clear_mask));
> +	val |= (pgprot_val(masks->set_mask));
> +
> +	return val;
> +}
> +
> +static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pgd_t val = pgdp_get(pgd);
> +
> +	if (pgd_leaf(val)) {
> +		if (WARN_ON_ONCE((next - addr) != PGDIR_SIZE))
> +			return -EINVAL;
> +		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
> +		set_pgd(pgd, val);
> +		walk->action = ACTION_CONTINUE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	p4d_t val = p4dp_get(p4d);
> +
> +	if (p4d_leaf(val)) {
> +		if (WARN_ON_ONCE((next - addr) != P4D_SIZE))
> +			return -EINVAL;
> +		val = __p4d(set_pageattr_masks(p4d_val(val), walk));
> +		set_p4d(p4d, val);
> +		walk->action = ACTION_CONTINUE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pud_t val = pudp_get(pud);
> +
> +	if (pud_leaf(val)) {
> +		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
> +			return -EINVAL;
> +		val = __pud(set_pageattr_masks(pud_val(val), walk));
> +		set_pud(pud, val);
> +		walk->action = ACTION_CONTINUE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pmd_t val = pmdp_get(pmd);
> +
> +	if (pmd_leaf(val)) {
> +		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
> +			return -EINVAL;
> +		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
> +		set_pmd(pmd, val);
> +		walk->action = ACTION_CONTINUE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t val = __ptep_get(pte);
> +
> +	val = __pte(set_pageattr_masks(pte_val(val), walk));
> +	__set_pte(pte, val);
> +
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops pageattr_ops = {
> +	.pgd_entry	= pageattr_pgd_entry,
> +	.p4d_entry	= pageattr_p4d_entry,
> +	.pud_entry	= pageattr_pud_entry,
> +	.pmd_entry	= pageattr_pmd_entry,
> +	.pte_entry	= pageattr_pte_entry,
> +};
> +
>  bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
>  
>  bool can_set_direct_map(void)
> @@ -37,22 +131,7 @@ bool can_set_direct_map(void)
>  		arm64_kfence_can_set_direct_map() || is_realm_world();
>  }
>  
> -static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
> -{
> -	struct page_change_data *cdata = data;
> -	pte_t pte = __ptep_get(ptep);
> -
> -	pte = clear_pte_bit(pte, cdata->clear_mask);
> -	pte = set_pte_bit(pte, cdata->set_mask);
> -
> -	__set_pte(ptep, pte);
> -	return 0;
> -}
> -
> -/*
> - * This function assumes that the range is mapped with PAGE_SIZE pages.
> - */
> -static int __change_memory_common(unsigned long start, unsigned long size,
> +static int ___change_memory_common(unsigned long start, unsigned long size,
>  				pgprot_t set_mask, pgprot_t clear_mask)
>  {
>  	struct page_change_data data;
> @@ -61,9 +140,28 @@ static int __change_memory_common(unsigned long start, unsigned long size,
>  	data.set_mask = set_mask;
>  	data.clear_mask = clear_mask;
>  
> -	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
> -					&data);
> +	arch_enter_lazy_mmu_mode();
> +
> +	/*
> +	 * The caller must ensure that the range we are operating on does not
> +	 * partially overlap a block mapping. Any such case should either not
> +	 * exist, or must be eliminated by splitting the mapping - which for
> +	 * kernel mappings can be done only on BBML2 systems.
> +	 *
> +	 */
> +	ret = walk_kernel_page_table_range_lockless(start, start + size,
> +						    &pageattr_ops, NULL, &data);
> +	arch_leave_lazy_mmu_mode();
> +
> +	return ret;
> +}
>  
> +static int __change_memory_common(unsigned long start, unsigned long size,
> +				  pgprot_t set_mask, pgprot_t clear_mask)
> +{
> +	int ret;
> +
> +	ret = ___change_memory_common(start, size, set_mask, clear_mask);
>  	/*
>  	 * If the memory is being made valid without changing any other bits
>  	 * then a TLBI isn't required as a non-valid entry cannot be cached in
> @@ -71,6 +169,7 @@ static int __change_memory_common(unsigned long start, unsigned long size,
>  	 */
>  	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
>  		flush_tlb_kernel_range(start, start + size);
> +
>  	return ret;
>  }
>  
> @@ -174,32 +273,26 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
>  
>  int set_direct_map_invalid_noflush(struct page *page)
>  {
> -	struct page_change_data data = {
> -		.set_mask = __pgprot(0),
> -		.clear_mask = __pgprot(PTE_VALID),
> -	};
> +	pgprot_t clear_mask = __pgprot(PTE_VALID);
> +	pgprot_t set_mask = __pgprot(0);
>  
>  	if (!can_set_direct_map())
>  		return 0;
>  
> -	return apply_to_page_range(&init_mm,
> -				   (unsigned long)page_address(page),
> -				   PAGE_SIZE, change_page_range, &data);
> +	return ___change_memory_common((unsigned long)page_address(page),
> +					PAGE_SIZE, set_mask, clear_mask);
>  }
>  
>  int set_direct_map_default_noflush(struct page *page)
>  {
> -	struct page_change_data data = {
> -		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
> -		.clear_mask = __pgprot(PTE_RDONLY),
> -	};
> +	pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
> +	pgprot_t clear_mask = __pgprot(PTE_RDONLY);
>  
>  	if (!can_set_direct_map())
>  		return 0;
>  
> -	return apply_to_page_range(&init_mm,
> -				   (unsigned long)page_address(page),
> -				   PAGE_SIZE, change_page_range, &data);
> +	return ___change_memory_common((unsigned long)page_address(page),
> +					PAGE_SIZE, set_mask, clear_mask);
>  }
>  
>  static int __set_memory_enc_dec(unsigned long addr,
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index 8ac2f6d6d2a3..79ab8c754dff 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -132,6 +132,9 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>  int walk_kernel_page_table_range(unsigned long start,
>  		unsigned long end, const struct mm_walk_ops *ops,
>  		pgd_t *pgd, void *private);
> +int walk_kernel_page_table_range_lockless(unsigned long start,
> +		unsigned long end, const struct mm_walk_ops *ops,
> +		pgd_t *pgd, void *private);
>  int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end, const struct mm_walk_ops *ops,
>  			void *private);
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index ff5299eca687..7446984b2154 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -632,6 +632,32 @@ int walk_kernel_page_table_range(unsigned long start, unsigned long end,
>  	return walk_pgd_range(start, end, &walk);
>  }
>  
> +/*
> + * Use this function to walk the kernel page tables locklessly. It should be
> + * guaranteed that the caller has exclusive access over the range they are
> + * operating on - that there should be no concurrent access, for example,
> + * changing permissions for vmalloc objects.
> + */
> +int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end,
> +		const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
> +{
> +	struct mm_struct *mm = &init_mm;
> +	struct mm_walk walk = {
> +		.ops		= ops,
> +		.mm		= mm,
> +		.pgd		= pgd,
> +		.private	= private,
> +		.no_vma		= true
> +	};
> +
> +	if (start >= end)
> +		return -EINVAL;
> +	if (!check_ops_valid(ops))
> +		return -EINVAL;
> +
> +	return walk_pgd_range(start, end, &walk);
> +}
> +
>  /**
>   * walk_page_range_debug - walk a range of pagetables not backed by a vma
>   * @mm:		mm_struct representing the target process of page table walk



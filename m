Return-Path: <linux-kernel+bounces-740705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D48A1B0D822
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC311C26B53
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BC02DAFDB;
	Tue, 22 Jul 2025 11:26:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87137288C33
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183575; cv=none; b=aMOyFqtB/Vubq5jGPdsoZHo+2/IDkJk+VPbzAVUS74Ayvo2582E6BO/gIyWP5+4IyajaEodoXFEOlkZPuSXFWnxDAyXe3xK1SY5eYoK+aKz0SujHZbQa4UFy+O02dAFHpVk9tj1iwBTXphSLCux7+LhEIScdXP2KAKB5OFOuaRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183575; c=relaxed/simple;
	bh=lbkkBmS+V+CmfSsRflihVrZqd7jwmECrPn0vHuEYzNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBeMO/g8AEOwBKgOVRlAFSWyXPCGbn+ies2ZHOi05FAl18mm8Bj9qwtQ597eTD3tM7P3X7wg9B6DG8ltz1awgF1n3aGp3vEHhU1AAgatAApPrUMWFUjH5MGmRkVCaQUtgDYi87p/XX12y58cEmkZVnuC9rSnOZKmsOxHGuTYGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE64152B;
	Tue, 22 Jul 2025 04:26:07 -0700 (PDT)
Received: from [10.1.30.167] (XHFQ2J9959.cambridge.arm.com [10.1.30.167])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD9293F66E;
	Tue, 22 Jul 2025 04:26:09 -0700 (PDT)
Message-ID: <3b105623-95c2-4d4b-b49f-dd087eaa652b@arm.com>
Date: Tue, 22 Jul 2025 12:26:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] mm: Optimize mprotect() for MM_CP_PROT_NUMA by
 batch-skipping PTEs
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
 joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-3-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250718090244.21092-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2025 10:02, Dev Jain wrote:
> For the MM_CP_PROT_NUMA skipping case, observe that, if we skip an
> iteration due to the underlying folio satisfying any of the skip
> conditions, then for all subsequent ptes which map the same folio, the
> iteration will be skipped for them too. Therefore, we can optimize
> by using folio_pte_batch() to batch skip the iterations.
> 
> Use prot_numa_skip() introduced in the previous patch to determine whether
> we need to skip the iteration. Change its signature to have a double
> pointer to a folio, which will be used by mprotect_folio_pte_batch() to
> determine the number of iterations we can safely skip.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/mprotect.c | 55 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 2a9c73bd0778..97adc62c50ab 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -83,28 +83,43 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  	return pte_dirty(pte);
>  }
>  
> +static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
> +				    pte_t pte, int max_nr_ptes)
> +{
> +	/* No underlying folio, so cannot batch */
> +	if (!folio)
> +		return 1;
> +
> +	if (!folio_test_large(folio))
> +		return 1;
> +
> +	return folio_pte_batch(folio, ptep, pte, max_nr_ptes);
> +}
> +
>  static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
> -			   pte_t oldpte, pte_t *pte, int target_node)
> +			   pte_t oldpte, pte_t *pte, int target_node,
> +			   struct folio **foliop)
>  {
> -	struct folio *folio;
> +	struct folio *folio = NULL;
> +	bool ret = true;
>  	bool toptier;
>  	int nid;
>  
>  	/* Avoid TLB flush if possible */
>  	if (pte_protnone(oldpte))
> -		return true;
> +		goto skip;
>  
>  	folio = vm_normal_folio(vma, addr, oldpte);
>  	if (!folio)
> -		return true;
> +		goto skip;
>  
>  	if (folio_is_zone_device(folio) || folio_test_ksm(folio))
> -		return true;
> +		goto skip;
>  
>  	/* Also skip shared copy-on-write pages */
>  	if (is_cow_mapping(vma->vm_flags) &&
>  	    (folio_maybe_dma_pinned(folio) || folio_maybe_mapped_shared(folio)))
> -		return true;
> +		goto skip;
>  
>  	/*
>  	 * While migration can move some dirty pages,
> @@ -112,7 +127,7 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>  	 * context.
>  	 */
>  	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
> -		return true;
> +		goto skip;
>  
>  	/*
>  	 * Don't mess with PTEs if page is already on the node
> @@ -120,7 +135,7 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>  	 */
>  	nid = folio_nid(folio);
>  	if (target_node == nid)
> -		return true;
> +		goto skip;
>  
>  	toptier = node_is_toptier(nid);
>  
> @@ -129,11 +144,15 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>  	 * balancing is disabled
>  	 */
>  	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) && toptier)
> -		return true;
> +		goto skip;
>  
> +	ret = false;
>  	if (folio_use_access_time(folio))
>  		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
> -	return false;
> +
> +skip:
> +	*foliop = folio;
> +	return ret;
>  }
>  
>  static long change_pte_range(struct mmu_gather *tlb,
> @@ -147,6 +166,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>  	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>  	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
> +	int nr_ptes;
>  
>  	tlb_change_page_size(tlb, PAGE_SIZE);
>  	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> @@ -161,8 +181,11 @@ static long change_pte_range(struct mmu_gather *tlb,
>  	flush_tlb_batched_pending(vma->vm_mm);
>  	arch_enter_lazy_mmu_mode();
>  	do {
> +		nr_ptes = 1;
>  		oldpte = ptep_get(pte);
>  		if (pte_present(oldpte)) {
> +			int max_nr_ptes = (end - addr) >> PAGE_SHIFT;
> +			struct folio *folio;
>  			pte_t ptent;
>  
>  			/*
> @@ -170,9 +193,15 @@ static long change_pte_range(struct mmu_gather *tlb,
>  			 * pages. See similar comment in change_huge_pmd.
>  			 */
>  			if (prot_numa) {
> -				if (prot_numa_skip(vma, addr, oldpte, pte,
> -						   target_node))
> +				int ret = prot_numa_skip(vma, addr, oldpte, pte,
> +							 target_node, &folio);
> +				if (ret) {
> +
> +					/* determine batch to skip */
> +					nr_ptes = mprotect_folio_pte_batch(folio,
> +						  pte, oldpte, max_nr_ptes);
>  					continue;
> +				}
>  			}
>  
>  			oldpte = ptep_modify_prot_start(vma, addr, pte);
> @@ -289,7 +318,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>  				pages++;
>  			}
>  		}
> -	} while (pte++, addr += PAGE_SIZE, addr != end);
> +	} while (pte += nr_ptes, addr += nr_ptes * PAGE_SIZE, addr != end);
>  	arch_leave_lazy_mmu_mode();
>  	pte_unmap_unlock(pte - 1, ptl);
>  



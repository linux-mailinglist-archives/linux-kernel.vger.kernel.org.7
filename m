Return-Path: <linux-kernel+bounces-853578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A564ABDC058
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7C33AE2E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3253B2FB084;
	Wed, 15 Oct 2025 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZggVZyWe"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140A2FB0B5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492898; cv=none; b=U6jSP7jiwdn48WczgnJfL5kEIUExBWle1h8IaRN9Sq2VfXVNFiWgkirGFcfcz/5zOEXW9PhlHiU1/sjwQVD0mP6JeFAmgujsun5SWkvD/o8dkWrgGnS9e/BP1j3H3roHDepLFYHU9eY8dccghzG43nxBZHSI8a2fQQqf6DceJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492898; c=relaxed/simple;
	bh=RjHUPwMWfdNexAovzhoKmoO8IIDB1TyCbeQ0c57MvUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcwpIBMhmJ5qlYdWr+kEf3kZKqWi24g4J+ogJRJZWa0piMCkBKt2mPbJVeQzhTZmkukbbv7hrcKlaWWgA5nfdmkZUIRE7+VvkKljOMNeDYdTGY8ip37LlaYONzzQ8koc/hqPx0hYigkNye+/88xEJuLD8JhSqWXOH07wHwmcuic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZggVZyWe; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8e7c7078-7757-44d2-b44a-aa8cf17cabd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760492893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1M0LsUtUJWc3UcAMyUSgMgp//nDL5rn5P9GaTVaKto=;
	b=ZggVZyWexZbda70QG4IIWn47nc9R+H8nnh3pl/dtUdOmnMXcJlJa5d1sGUVxCWo4SFTwOC
	cNsAR4HQxB+pacY/fzRVxL97cFJKKRdRv86A+lFgbPGnjY3ERwnGa2tYv1ba9+/CAyr1ga
	yBTRltVwJqaq0dFG9v+YrdP4qIOVsfw=
Date: Wed, 15 Oct 2025 09:48:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v3 3/3] mm/khugepaged: merge PTE scanning logic
 into a new helper
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251008043748.45554-1-lance.yang@linux.dev>
 <20251008043748.45554-4-lance.yang@linux.dev>
 <04734f2d-ea1f-487c-b01c-c3d6e1b4a778@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <04734f2d-ea1f-487c-b01c-c3d6e1b4a778@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/15 01:41, Lorenzo Stoakes wrote:
> OK so this patch _is_ based on [0] already being applied then?
> 
> I don't see any is_swap_pte() here so presumably so right?
> 
> Can we just respin these series and put them together? Because now I've
> reviewed a bunch of stuff in [0], which this series depends upon, and
> you're saying we should now review on this instead of that and it's a bit
> of a mess.
> 
> Once review here is dealt with can you combine [0] into this series please?

Got it, thanks!

> 
> For [0] I would like you to reinstate the is_swap_pte() conditional as
> (copiously :) discussed over there.
> 
> [0}: https://lore.kernel.org/all/20251008032657.72406-1-lance.yang@linux.dev/
> 
> Thanks, Lorenzo
> 
> On Wed, Oct 08, 2025 at 12:37:48PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>> and __collapse_huge_page_isolate() was almost duplicated.
>>
>> This patch cleans things up by moving all the common PTE checking logic
>> into a new shared helper, thp_collapse_check_pte(). While at it, we use
>> vm_normal_folio() instead of vm_normal_page().
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 243 ++++++++++++++++++++++++++----------------------
>>   1 file changed, 130 insertions(+), 113 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index b5c0295c3414..7116caae1fa4 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -61,6 +61,12 @@ enum scan_result {
>>   	SCAN_PAGE_FILLED,
>>   };
>>
>> +enum pte_check_result {
>> +	PTE_CHECK_SUCCEED,
>> +	PTE_CHECK_CONTINUE,
>> +	PTE_CHECK_FAIL,
>> +};
>> +
>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/huge_memory.h>
>>
>> @@ -533,62 +539,139 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>>   	}
>>   }
>>
>> +/*
>> + * thp_collapse_check_pte - Check if a PTE is suitable for THP collapse
>> + * @pte:           The PTE to check
>> + * @vma:           The VMA the PTE belongs to
>> + * @addr:          The virtual address corresponding to this PTE
>> + * @foliop:        On success, used to return a pointer to the folio
>> + *                 Must be non-NULL
>> + * @none_or_zero:  Counter for none/zero PTEs. Must be non-NULL
>> + * @unmapped:      Counter for swap PTEs. Can be NULL if not scanning swaps
>> + * @shared:        Counter for shared pages. Must be non-NULL
>> + * @scan_result:   Used to return the failure reason (SCAN_*) on a
>> + *                 PTE_CHECK_FAIL return. Must be non-NULL
>> + * @cc:            Collapse control settings
>> + *
>> + * Returns:
>> + *   PTE_CHECK_SUCCEED  - PTE is suitable, proceed with further checks
>> + *   PTE_CHECK_CONTINUE - Skip this PTE and continue scanning
>> + *   PTE_CHECK_FAIL     - Abort collapse scan
>> + */
>> +static inline int thp_collapse_check_pte(pte_t pte, struct vm_area_struct *vma,
>> +		unsigned long addr, struct folio **foliop, int *none_or_zero,
>> +		int *unmapped, int *shared, int *scan_result,
>> +		struct collapse_control *cc)
>> +{
>> +	struct folio *folio = NULL;
>> +
>> +	if (pte_none(pte) || is_zero_pfn(pte_pfn(pte))) {
>> +		(*none_or_zero)++;
>> +		if (!userfaultfd_armed(vma) &&
>> +		    (!cc->is_khugepaged ||
>> +		     *none_or_zero <= khugepaged_max_ptes_none)) {
>> +			return PTE_CHECK_CONTINUE;
>> +		} else {
>> +			*scan_result = SCAN_EXCEED_NONE_PTE;
>> +			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> +			return PTE_CHECK_FAIL;
>> +		}
>> +	} else if (!pte_present(pte)) {
>> +		if (!unmapped) {
>> +			*scan_result = SCAN_PTE_NON_PRESENT;
>> +			return PTE_CHECK_FAIL;
>> +		}
>> +
>> +		if (non_swap_entry(pte_to_swp_entry(pte))) {
>> +			*scan_result = SCAN_PTE_NON_PRESENT;
>> +			return PTE_CHECK_FAIL;
>> +		}
>> +
>> +		(*unmapped)++;
>> +		if (!cc->is_khugepaged ||
>> +		    *unmapped <= khugepaged_max_ptes_swap) {
>> +			/*
>> +			 * Always be strict with uffd-wp enabled swap
>> +			 * entries. Please see comment below for
>> +			 * pte_uffd_wp().
>> +			 */
>> +			if (pte_swp_uffd_wp(pte)) {
>> +				*scan_result = SCAN_PTE_UFFD_WP;
>> +				return PTE_CHECK_FAIL;
>> +			}
>> +			return PTE_CHECK_CONTINUE;
>> +		} else {
>> +			*scan_result = SCAN_EXCEED_SWAP_PTE;
>> +			count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>> +			return PTE_CHECK_FAIL;
>> +		}
>> +	} else if (pte_uffd_wp(pte)) {
>> +		/*
>> +		 * Don't collapse the page if any of the small PTEs are
>> +		 * armed with uffd write protection. Here we can also mark
>> +		 * the new huge pmd as write protected if any of the small
>> +		 * ones is marked but that could bring unknown userfault
>> +		 * messages that falls outside of the registered range.
>> +		 * So, just be simple.
>> +		 */
>> +		*scan_result = SCAN_PTE_UFFD_WP;
>> +		return PTE_CHECK_FAIL;
>> +	}
>> +
>> +	folio = vm_normal_folio(vma, addr, pte);
>> +	if (unlikely(!folio) || unlikely(folio_is_zone_device(folio))) {
>> +		*scan_result = SCAN_PAGE_NULL;
>> +		return PTE_CHECK_FAIL;
>> +	}
>> +
>> +	if (!folio_test_anon(folio)) {
>> +		VM_WARN_ON_FOLIO(true, folio);
>> +		*scan_result = SCAN_PAGE_ANON;
>> +		return PTE_CHECK_FAIL;
>> +	}
>> +
>> +	/*
>> +	 * We treat a single page as shared if any part of the THP
>> +	 * is shared.
>> +	 */
>> +	if (folio_maybe_mapped_shared(folio)) {
>> +		(*shared)++;
>> +		if (cc->is_khugepaged && *shared > khugepaged_max_ptes_shared) {
>> +			*scan_result = SCAN_EXCEED_SHARED_PTE;
>> +			count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>> +			return PTE_CHECK_FAIL;
>> +		}
>> +	}
>> +
>> +	*foliop = folio;
>> +
>> +	return PTE_CHECK_SUCCEED;
>> +}
>> +
>>   static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>   					unsigned long start_addr,
>>   					pte_t *pte,
>>   					struct collapse_control *cc,
>>   					struct list_head *compound_pagelist)
>>   {
>> -	struct page *page = NULL;
>>   	struct folio *folio = NULL;
>>   	unsigned long addr = start_addr;
>>   	pte_t *_pte;
>>   	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>> +	int pte_check_res;
>>
>>   	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>>   	     _pte++, addr += PAGE_SIZE) {
>>   		pte_t pteval = ptep_get(_pte);
>> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> -			++none_or_zero;
>> -			if (!userfaultfd_armed(vma) &&
>> -			    (!cc->is_khugepaged ||
>> -			     none_or_zero <= khugepaged_max_ptes_none)) {
>> -				continue;
>> -			} else {
>> -				result = SCAN_EXCEED_NONE_PTE;
>> -				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> -				goto out;
>> -			}
>> -		} else if (!pte_present(pteval)) {
>> -			result = SCAN_PTE_NON_PRESENT;
>> -			goto out;
>> -		} else if (pte_uffd_wp(pteval)) {
>> -			result = SCAN_PTE_UFFD_WP;
>> -			goto out;
>> -		}
>> -		page = vm_normal_page(vma, addr, pteval);
>> -		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
>> -			result = SCAN_PAGE_NULL;
>> -			goto out;
>> -		}
>>
>> -		folio = page_folio(page);
>> -		if (!folio_test_anon(folio)) {
>> -			VM_WARN_ON_FOLIO(true, folio);
>> -			result = SCAN_PAGE_ANON;
>> -			goto out;
>> -		}
>> +		pte_check_res = thp_collapse_check_pte(pteval, vma, addr,
>> +					&folio, &none_or_zero, NULL, &shared,
>> +					&result, cc);
>>
>> -		/* See hpage_collapse_scan_pmd(). */
>> -		if (folio_maybe_mapped_shared(folio)) {
>> -			++shared;
>> -			if (cc->is_khugepaged &&
>> -			    shared > khugepaged_max_ptes_shared) {
>> -				result = SCAN_EXCEED_SHARED_PTE;
>> -				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>> -				goto out;
>> -			}
>> -		}
>> +		if (pte_check_res == PTE_CHECK_CONTINUE)
>> +			continue;
>> +		else if (pte_check_res == PTE_CHECK_FAIL)
>> +			goto out;
>>
>>   		if (folio_test_large(folio)) {
>>   			struct folio *f;
>> @@ -1264,11 +1347,11 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>   	pte_t *pte, *_pte;
>>   	int result = SCAN_FAIL, referenced = 0;
>>   	int none_or_zero = 0, shared = 0;
>> -	struct page *page = NULL;
>>   	struct folio *folio = NULL;
>>   	unsigned long addr;
>>   	spinlock_t *ptl;
>>   	int node = NUMA_NO_NODE, unmapped = 0;
>> +	int pte_check_res;
>>
>>   	VM_BUG_ON(start_addr & ~HPAGE_PMD_MASK);
>>
>> @@ -1287,81 +1370,15 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>   	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>   	     _pte++, addr += PAGE_SIZE) {
>>   		pte_t pteval = ptep_get(_pte);
>> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> -			++none_or_zero;
>> -			if (!userfaultfd_armed(vma) &&
>> -			    (!cc->is_khugepaged ||
>> -			     none_or_zero <= khugepaged_max_ptes_none)) {
>> -				continue;
>> -			} else {
>> -				result = SCAN_EXCEED_NONE_PTE;
>> -				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> -				goto out_unmap;
>> -			}
>> -		} else if (!pte_present(pteval)) {
>> -			if (non_swap_entry(pte_to_swp_entry(pteval))) {
>> -				result = SCAN_PTE_NON_PRESENT;
>> -				goto out_unmap;
>> -			}
>>
>> -			++unmapped;
>> -			if (!cc->is_khugepaged ||
>> -			    unmapped <= khugepaged_max_ptes_swap) {
>> -				/*
>> -				 * Always be strict with uffd-wp
>> -				 * enabled swap entries.  Please see
>> -				 * comment below for pte_uffd_wp().
>> -				 */
>> -				if (pte_swp_uffd_wp(pteval)) {
>> -					result = SCAN_PTE_UFFD_WP;
>> -					goto out_unmap;
>> -				}
>> -				continue;
>> -			} else {
>> -				result = SCAN_EXCEED_SWAP_PTE;
>> -				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>> -				goto out_unmap;
>> -			}
>> -		} else if (pte_uffd_wp(pteval)) {
>> -			/*
>> -			 * Don't collapse the page if any of the small
>> -			 * PTEs are armed with uffd write protection.
>> -			 * Here we can also mark the new huge pmd as
>> -			 * write protected if any of the small ones is
>> -			 * marked but that could bring unknown
>> -			 * userfault messages that falls outside of
>> -			 * the registered range.  So, just be simple.
>> -			 */
>> -			result = SCAN_PTE_UFFD_WP;
>> -			goto out_unmap;
>> -		}
>> +		pte_check_res = thp_collapse_check_pte(pteval, vma, addr,
>> +					&folio, &none_or_zero, &unmapped,
>> +					&shared, &result, cc);
>>
>> -		page = vm_normal_page(vma, addr, pteval);
>> -		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
>> -			result = SCAN_PAGE_NULL;
>> -			goto out_unmap;
>> -		}
>> -		folio = page_folio(page);
>> -
>> -		if (!folio_test_anon(folio)) {
>> -			VM_WARN_ON_FOLIO(true, folio);
>> -			result = SCAN_PAGE_ANON;
>> +		if (pte_check_res == PTE_CHECK_CONTINUE)
>> +			continue;
>> +		else if (pte_check_res == PTE_CHECK_FAIL)
>>   			goto out_unmap;
>> -		}
>> -
>> -		/*
>> -		 * We treat a single page as shared if any part of the THP
>> -		 * is shared.
>> -		 */
>> -		if (folio_maybe_mapped_shared(folio)) {
>> -			++shared;
>> -			if (cc->is_khugepaged &&
>> -			    shared > khugepaged_max_ptes_shared) {
>> -				result = SCAN_EXCEED_SHARED_PTE;
>> -				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>> -				goto out_unmap;
>> -			}
>> -		}
>>
>>   		/*
>>   		 * Record which node the original page is from and save this
>> --
>> 2.49.0
>>



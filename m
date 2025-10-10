Return-Path: <linux-kernel+bounces-848309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC81BBCD5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B02406AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D22F3C38;
	Fri, 10 Oct 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xI5Zj1LN"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D4287268
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104555; cv=none; b=jniCHJMFDLCoqeNYz2Bwbdylec5KInzwXHH3jrtxQGLjVhfq3gkNW4tqOSiJRpuAINam5Z8YCT9SjaS7Pu909XS0E8sjR/aUuU4Hqi8mwRHdbGfJcf5PI/QiV8yL1uxPuPIzP7wAqd2Q1FnibgFemNJsAK1rEA7nWLlie4a+Umk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104555; c=relaxed/simple;
	bh=HDJ442ubSwLsQo8lBI0RqSY55wS3kAHQ5rKQMNPNsHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkSXpD/ACmUYWIucwMT0iMCr9AdVdESQG8BbGl47C6ArHuMSQEuXPcjwGqBSPY9eVSgJNYhpWyVVZIpcNmjxroqvve2WacT4DKiLKe/waVew5PnO8RZgIBagqSk5mbiG9Uq6i+m87YS94J5jCCjmwvnEmlRvDuU55/Dl94pRJaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xI5Zj1LN; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ed89aa31-a70a-4ad4-aa20-2e130b1e9975@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760104549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WezYJv/TQcaWcgp9xK9sF6BvbI2Dj8h1xqPvqxsmVPk=;
	b=xI5Zj1LNgN/99YsxuLbpMaw39XGggpmkiJVWP2Vq2VBFmz5GpA3oZuwb8bCBmgi+ccwPMk
	sFciYzubaLyMi54rXx2vzFlzKFeQz48PpElY/mo2h0hqZ4G6cVmU/qSSq1B5BQtoX9e4/7
	SLENs2JF4g0Zqh94MqatcPQIZMXaMig=
Date: Fri, 10 Oct 2025 21:55:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v3 3/3] mm/khugepaged: merge PTE scanning logic
 into a new helper
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251008043748.45554-1-lance.yang@linux.dev>
 <20251008043748.45554-4-lance.yang@linux.dev>
 <20251010132950.yx6bmvub3a46gcl3@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251010132950.yx6bmvub3a46gcl3@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/10 21:29, Wei Yang wrote:
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
>> mm/khugepaged.c | 243 ++++++++++++++++++++++++++----------------------
>> 1 file changed, 130 insertions(+), 113 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index b5c0295c3414..7116caae1fa4 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -61,6 +61,12 @@ enum scan_result {
>> 	SCAN_PAGE_FILLED,
>> };
>>
>> +enum pte_check_result {
>> +	PTE_CHECK_SUCCEED,
>> +	PTE_CHECK_CONTINUE,
>> +	PTE_CHECK_FAIL,
>> +};
>> +
>> #define CREATE_TRACE_POINTS
>> #include <trace/events/huge_memory.h>
>>
>> @@ -533,62 +539,139 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>> 	}
>> }
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
> 
> This one looks much better.
> 
> While my personal feeling is this is not a complete work to merge the scanning
> logic. We still have folio_expected_ref_count() and pte_young() check present
> both in __collapse_huge_page_isolate() and huge_collapse_scan_pmd().

Yep, good catch!

There's definitely more that can be done. For now, let's keep this patch
as-is to avoid making it too complex. Let's get this one in first, and
then we can work on the next step :)



Return-Path: <linux-kernel+bounces-848455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6BBCDCFB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92D440804D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620772FABFA;
	Fri, 10 Oct 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NTnmzvmL"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAAC2FA0DF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110475; cv=none; b=nLIc7Cc7IcV4f24AeQsk8txyh8gZaw+Q6DxKpHdpv0EyNb00DJzQt9/YKoIPGgFTdmDtLD9EDrbm1dSyK4jKSG/3UdhaQt0AGM8rFNIYfOP8bmaHoSWnySRyQnZhT00oLGt8wRETJyhNdC/ukJ4pnB7EnJuQSBQfS1Z6L+0yXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110475; c=relaxed/simple;
	bh=L4IvhMroY4iYBrC3di0nY8VoKX2tEH0eXJKF2I6BZT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGoB9C1fgculpUlFbZV5i6Jsr43pUnofJ4OFyrqhESQZZGEBvo35ZPE08Xm+eM1jEx4aQxF6exY6udp7WJBoVYznjJH6DzHdHqvW1bS2XiG2Bh46arGSouSu6ctYHtBiZX/pHQ2RyrX2A0Z1FZxB7RdaOiAYVZkjhO3J3LZujB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NTnmzvmL; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73bbc22f-2739-4f0e-b8d7-b8e344a3fead@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760110471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4qsKbpNSIpA/NVXxQj6liAluALHkPVnznxBwYjjPvc=;
	b=NTnmzvmLuwBW42Vk6+G3ozKCQJmkscoHymC893MAgN1qpa4PviLFOlDB1uQxBSZgx+l+XC
	i5mjGyk+JMIUsIJmmI0jtEJF0NJrj7lm1+32dA/+0+UkSEhUm3zNpnBN4nx76fkZ2f6EGY
	edCr0qTAYdQRDkYmxDewwapgxliu5O0=
Date: Fri, 10 Oct 2025 23:34:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 dev.jain@arm.com, hughd@google.com, ioworker0@gmail.com,
 kirill@shutemov.name, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com,
 richard.weiyang@gmail.com
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <3ABDAD81-A650-4C9A-BB4B-5515180F0743@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <3ABDAD81-A650-4C9A-BB4B-5515180F0743@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/10 23:21, Zi Yan wrote:
> On 7 Oct 2025, at 23:26, Lance Yang wrote:
> 
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Currently, special non-swap entries (like PTE markers) are not caught
>> early in hpage_collapse_scan_pmd(), leading to failures deep in the
>> swap-in logic.
>>
>> A function that is called __collapse_huge_page_swapin() and documented
>> to "Bring missing pages in from swap" will handle other types as well.
>>
>> As analyzed by David[1], we could have ended up with the following
>> entry types right before do_swap_page():
>>
>>    (1) Migration entries. We would have waited.
>>        -> Maybe worth it to wait, maybe not. We suspect we don't stumble
>>           into that frequently such that we don't care. We could always
>>           unlock this separately later.
>>
>>    (2) Device-exclusive entries. We would have converted to non-exclusive.
>>        -> See make_device_exclusive(), we cannot tolerate PMD entries and
>>           have to split them through FOLL_SPLIT_PMD. As popped up during
>>           a recent discussion, collapsing here is actually
>>           counter-productive, because the next conversion will PTE-map
>>           it again.
>>        -> Ok to not collapse.
>>
>>    (3) Device-private entries. We would have migrated to RAM.
>>        -> Device-private still does not support THPs, so collapsing right
>>           now just means that the next device access would split the
>>           folio again.
>>        -> Ok to not collapse.
>>
>>    (4) HWPoison entries
>>        -> Cannot collapse
>>
>>    (5) Markers
>>        -> Cannot collapse
>>
>> First, this patch adds an early check for these non-swap entries. If
>> any one is found, the scan is aborted immediately with the
>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>> work. While at it, convert pte_swp_uffd_wp_any() to pte_swp_uffd_wp()
>> since we are in the swap pte branch.
>>
>> Second, as Wei pointed out[3], we may have a chance to get a non-swap
>> entry, since we will drop and re-acquire the mmap lock before
>> __collapse_huge_page_swapin(). To handle this, we also add a
>> non_swap_entry() check there.
>>
>> Note that we can unlock later what we really need, and not account it
>> towards max_swap_ptes.
>>
>> [1] https://lore.kernel.org/linux-mm/09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com
>> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
>> [3] https://lore.kernel.org/linux-mm/20251005010511.ysek2nqojebqngf3@master
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> v2 -> v3:
>>   - Collect Acked-by from David - thanks!
>>   - Collect Reviewed-by from Wei and Dev - thanks!
>>   - Add a non_swap_entry() check in __collapse_huge_page_swapin() (per Wei
>>     and David) - thanks!
>>   - Rework the changelog to incorporate David's detailed analysis of
>>     non-swap entry types - thanks!!!
>>   - https://lore.kernel.org/linux-mm/20251001032251.85888-1-lance.yang@linux.dev/
>>
>> v1 -> v2:
>>   - Skip all non-present entries except swap entries (per David) thanks!
>>   - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/
>>
>>   mm/khugepaged.c | 37 +++++++++++++++++++++++--------------
>>   1 file changed, 23 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index abe54f0043c7..bec3e268dc76 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1020,6 +1020,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>>   		if (!is_swap_pte(vmf.orig_pte))
>>   			continue;
>>
>> +		if (non_swap_entry(pte_to_swp_entry(vmf.orig_pte))) {
>> +			result = SCAN_PTE_NON_PRESENT;
>> +			goto out;
>> +		}
>> +
>>   		vmf.pte = pte;
>>   		vmf.ptl = ptl;
>>   		ret = do_swap_page(&vmf);
>> @@ -1281,7 +1286,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>   	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>   	     _pte++, addr += PAGE_SIZE) {
>>   		pte_t pteval = ptep_get(_pte);
>> -		if (is_swap_pte(pteval)) {
>> +		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> +			++none_or_zero;
>> +			if (!userfaultfd_armed(vma) &&
>> +			    (!cc->is_khugepaged ||
>> +			     none_or_zero <= khugepaged_max_ptes_none)) {
>> +				continue;
>> +			} else {
>> +				result = SCAN_EXCEED_NONE_PTE;
>> +				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> +				goto out_unmap;
>> +			}
>> +		} else if (!pte_present(pteval)) {
>> +			if (non_swap_entry(pte_to_swp_entry(pteval))) { 
>> +				result = SCAN_PTE_NON_PRESENT;
>> +				goto out_unmap;
>> +			}
>> +
>>   			++unmapped;
>>   			if (!cc->is_khugepaged ||
>>   			    unmapped <= khugepaged_max_ptes_swap) {
>> @@ -1290,7 +1311,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>   				 * enabled swap entries.  Please see
>>   				 * comment below for pte_uffd_wp().
>>   				 */
>> -				if (pte_swp_uffd_wp_any(pteval)) {
>> +				if (pte_swp_uffd_wp(pteval)) {
> 
> pte_swp_uffd_wp_any() returns true for both pte_swp_uffd_wp() and
> pte_marker_uffd_wp(). Why is it OK to just check pte_swp_uffd_wp() here?

+		} else if (!pte_present(pteval)) {
+			if (non_swap_entry(pte_to_swp_entry(pteval))) { <--
+				result = SCAN_PTE_NON_PRESENT;
+				goto out_unmap;
+			}

IIUC, we have just handled all non-swap entries above (which would
include pte_marker_uffd_wp()), right?

> 
>>   					result = SCAN_PTE_UFFD_WP;
>>   					goto out_unmap;
>>   				}
>> @@ -1301,18 +1322,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>   				goto out_unmap;
>>   			}
>>   		}
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
>> -		}
>>   		if (pte_uffd_wp(pteval)) {
>>   			/*
>>   			 * Don't collapse the page if any of the small
>> -- 
>> 2.49.0
> 
> 
> --
> Best Regards,
> Yan, Zi



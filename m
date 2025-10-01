Return-Path: <linux-kernel+bounces-838743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC4BBB00DC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDAF19205CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F729D270;
	Wed,  1 Oct 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CEz9D/G6"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6F28E3F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315703; cv=none; b=gOosTvIH98r5zHWXEBR3CKlmExRxoIyw0lboSjfN3bZ1l4o7Bkjs0FAp54T373ppFk70R4DuVdA9m3972D5naasHPg139MMKEhSN5Wc7qzYfMNj2CXPGLOxKaJtfuwnumWiGGceCN8wp2gti2GCP4+KqdhJXuz5dDv5ALpE7VEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315703; c=relaxed/simple;
	bh=4lXUcMuIHtqcbUKIT2Z48zQTmGdrKHDckKBpOKPtuN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fl47IREO0ToxH73aiISDwMhQVp/pFfwCj9FmNQG2wLCOzVDogPsUH6bo+CM35g9bkmqpw7fYyc/REuRAGuANI+gCIvwfJIwI5HAGrEpJLymE97CxCgbJvq7vGBQNlhGONM4Uq0wiLC2vQdHFto2U26y/FwVLoQ5skkSSqKxRuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CEz9D/G6; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35c9a208-a7e6-41ab-aa3e-dbfdffaf5f44@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759315698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQUujdosur72Brf3SU3nUTaWVwV5A6tLlSLe6abHjBM=;
	b=CEz9D/G6FWs96Xm7MfIttlI2vT8a4OKRqIi+Z63tvSyfSJakEey4bMpwr/5BZiuUl3xD4o
	+4zuHS711gNpBhLZEQ0tqOaVBeqXvlWf/BRBhQjMkPwtVovRtm6EJCnVeVYJb305EAbziK
	FJR2NlqCa6FhRHe/URVjtXXm7qN8MNc=
Date: Wed, 1 Oct 2025 18:48:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com,
 akpm@linux-foundation.org
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <a1df234c-d003-4696-8f1f-609a360fdeda@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a1df234c-d003-4696-8f1f-609a360fdeda@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/1 18:20, Dev Jain wrote:
> 
> On 01/10/25 8:52 am, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Currently, special non-swap entries (like migration, hwpoison, or PTE
>> markers) are not caught early in hpage_collapse_scan_pmd(), leading to
>> failures deep in the swap-in logic.
>>
>> hpage_collapse_scan_pmd()
>>   `- collapse_huge_page()
>>       `- __collapse_huge_page_swapin() -> fails!
>>
>> As David suggested[1], this patch skips any such non-swap entries
>> early. If any one is found, the scan is aborted immediately with the
>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>> work.
>>
>> [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb- 
>> a7c8-1ba64fd6df69@redhat.com
>> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680- 
>> dcd55219c8bd@lucifer.local
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> v1 -> v2:
>>   - Skip all non-present entries except swap entries (per David) thanks!
>>   - https://lore.kernel.org/linux-mm/20250924100207.28332-1- 
>> lance.yang@linux.dev/
>>
>>   mm/khugepaged.c | 32 ++++++++++++++++++--------------
>>   1 file changed, 18 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 7ab2d1a42df3..d0957648db19 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct 
>> mm_struct *mm,
>>       for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>            _pte++, addr += PAGE_SIZE) {
>>           pte_t pteval = ptep_get(_pte);
>> -        if (is_swap_pte(pteval)) {
>> +        if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> +            ++none_or_zero;
>> +            if (!userfaultfd_armed(vma) &&
>> +                (!cc->is_khugepaged ||
>> +                 none_or_zero <= khugepaged_max_ptes_none)) {
>> +                continue;
>> +            } else {
>> +                result = SCAN_EXCEED_NONE_PTE;
>> +                count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> +                goto out_unmap;
>> +            }
>> +        } else if (!pte_present(pteval)) {
> 
> If you are trying to merge this with the _isolate() conditions, we can do
> a micro-optimization here - is_swap_pte, (pte_none && is_zero_pfn), and 
> pte_uffd_wp
> are disjoint conditions, so we can use if-else-if-else-if to write them.

Ah, indeed, thanks!

I think it would fit better into the follow-up patch that unifies the
scanning logic, and I'll make sure to include it there ;p

> 
>> +            if (non_swap_entry(pte_to_swp_entry(pteval))) {
>> +                result = SCAN_PTE_NON_PRESENT;
>> +                goto out_unmap;
>> +            }
>> +
>>               ++unmapped;
>>               if (!cc->is_khugepaged ||
>>                   unmapped <= khugepaged_max_ptes_swap) {
>> @@ -1293,7 +1309,7 @@ static int hpage_collapse_scan_pmd(struct 
>> mm_struct *mm,
>>                    * enabled swap entries.  Please see
>>                    * comment below for pte_uffd_wp().
>>                    */
>> -                if (pte_swp_uffd_wp_any(pteval)) {
>> +                if (pte_swp_uffd_wp(pteval)) {
>>                       result = SCAN_PTE_UFFD_WP;
> 
> Could have mentioned in the changelog "while at it, convert 
> pte_swp_uffd_wp_any to
> pte_swp_uffd_wp since we are in the swap pte branch".

Right, that would have been clearer.

I'll add that if a next version is needed :)

> 
>>                       goto out_unmap;
>>                   }
>> @@ -1304,18 +1320,6 @@ static int hpage_collapse_scan_pmd(struct 
>> mm_struct *mm,
>>                   goto out_unmap;
>>               }
>>           }
>> -        if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> -            ++none_or_zero;
>> -            if (!userfaultfd_armed(vma) &&
>> -                (!cc->is_khugepaged ||
>> -                 none_or_zero <= khugepaged_max_ptes_none)) {
>> -                continue;
>> -            } else {
>> -                result = SCAN_EXCEED_NONE_PTE;
>> -                count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> -                goto out_unmap;
>> -            }
>> -        }
>>           if (pte_uffd_wp(pteval)) {
>>               /*
>>                * Don't collapse the page if any of the small
> 
> Otherwise LGTM
> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>

Cheers!



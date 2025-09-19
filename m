Return-Path: <linux-kernel+bounces-823981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE64B87DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4F3173C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBEB26738B;
	Fri, 19 Sep 2025 04:11:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9185525FA0E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758255111; cv=none; b=jjSTIpbx2A61QN5NBxGyE4ZHF7beE82km6eEf8543Mv+k+I3omZ4oYr8nFSJRpHVG3c1nzYARzfH0rf1mdRbIKOJA0JUX2liVT52AnaqQGhn3ndy/OeSjxYQW9cMgwy7wo1uacXOVu0aRqGve1974j4PNeEMN6Dz61dqPAQ5O3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758255111; c=relaxed/simple;
	bh=CmDuLxpMDxf5AchlYUIvjaFeP+19N3HTntvzKsfXsMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tv/HK4DwUct7GvWZuqxoTL1H+xHyhChcYRCzUdleq09I/7fNDfu+T/eui3NLfOs5rkKtfk42i2k1vTLoPMDZ1RCuvhQ/okqM0CmJSE3GisqTLVw2QCpKkelzff9xolCakFx67sCngTnT6v+Tt9K3mRdbs6sZZ6nw7++EJKdDU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E5AF1758;
	Thu, 18 Sep 2025 21:11:40 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D1413F673;
	Thu, 18 Sep 2025 21:11:38 -0700 (PDT)
Message-ID: <6a6f03df-8dc4-44aa-ad25-40f51ad98266@arm.com>
Date: Fri, 19 Sep 2025 09:41:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
To: David Hildenbrand <david@redhat.com>, Lance Yang <lance.yang@linux.dev>,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, kirill@shutemov.name, hughd@google.com,
 mpenttil@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
 <a696c734-9f88-4d6f-a852-013071a2dd2a@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <a696c734-9f88-4d6f-a852-013071a2dd2a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 19/09/25 12:17 am, David Hildenbrand wrote:
> On 18.09.25 07:04, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
>> lightweight guard regions.
>>
>> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail 
>> when
>> encountering such a range.
>>
>> MADV_COLLAPSE fails deep inside the collapse logic when trying to 
>> swap-in
>> the special marker in __collapse_huge_page_swapin().
>>
>> hpage_collapse_scan_pmd()
>>   `- collapse_huge_page()
>>       `- __collapse_huge_page_swapin() -> fails!
>>
>> khugepaged's behavior is slightly different due to its max_ptes_swap 
>> limit
>> (default 64). It won't fail as deep, but it will still needlessly 
>> scan up
>> to 64 swap entries before bailing out.
>>
>> IMHO, we can and should detect this much earlier.
>>
>> This patch adds a check directly inside the PTE scan loop. If a guard
>> marker is found, the scan is aborted immediately with 
>> SCAN_PTE_NON_PRESENT,
>> avoiding wasted work.
>>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 9ed1af2b5c38..70ebfc7c1f3e 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct 
>> mm_struct *mm,
>>                       result = SCAN_PTE_UFFD_WP;
>>                       goto out_unmap;
>>                   }
>> +                /*
>> +                 * Guard PTE markers are installed by
>> +                 * MADV_GUARD_INSTALL. Any collapse path must
>> +                 * not touch them, so abort the scan immediately
>> +                 * if one is found.
>> +                 */
>> +                if (is_guard_pte_marker(pteval)) {
>> +                    result = SCAN_PTE_NON_PRESENT;
>> +                    goto out_unmap;
>> +                }
>
> Thinking about it, this is interesting.
>
> Essentially we track any non-swap swap entries towards 
> khugepaged_max_ptes_swap, which is rather weird.
>
> I think we might also run into migration entries here and hwpoison 
> entries?
>
> So what about just generalizing this:
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index af5f5c80fe4ed..28f1f4bf0e0a8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1293,7 +1293,24 @@ static int hpage_collapse_scan_pmd(struct 
> mm_struct *mm,
>         for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>              _pte++, _address += PAGE_SIZE) {
>                 pte_t pteval = ptep_get(_pte);
> -               if (is_swap_pte(pteval)) {
> +
> +               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> +                       ++none_or_zero;
> +                       if (!userfaultfd_armed(vma) &&
> +                           (!cc->is_khugepaged ||
> +                            none_or_zero <= khugepaged_max_ptes_none)) {
> +                               continue;
> +                       } else {
> +                               result = SCAN_EXCEED_NONE_PTE;
> + count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +                               goto out_unmap;
> +                       }
> +               } else if (!pte_present(pteval)) {
> +                       if (non_swap_entry(pte_to_swp_entry(pteval))) {
> +                               result = SCAN_PTE_NON_PRESENT;
> +                               goto out_unmap;
> +                       }
> +
>                         ++unmapped;
>                         if (!cc->is_khugepaged ||
>                             unmapped <= khugepaged_max_ptes_swap) {
> @@ -1313,18 +1330,7 @@ static int hpage_collapse_scan_pmd(struct 
> mm_struct *mm,
>                                 goto out_unmap;
>                         }
>                 }
> -               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> -                       ++none_or_zero;
> -                       if (!userfaultfd_armed(vma) &&
> -                           (!cc->is_khugepaged ||
> -                            none_or_zero <= khugepaged_max_ptes_none)) {
> -                               continue;
> -                       } else {
> -                               result = SCAN_EXCEED_NONE_PTE;
> - count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> -                               goto out_unmap;
> -                       }
> -               }
> +
>                 if (pte_uffd_wp(pteval)) {
>                         /*
>                          * Don't collapse the page if any of the small
>
>
> With that, the function flow looks more similar to 
> __collapse_huge_page_isolate(),
> except that we handle swap entries in there now.

This looks good!


>
>
> And with that in place, couldn't we factor out a huge chunk of both 
> scanning
> functions into some helper (passing whether swap entries are allowed 
> or not?).
>
> Yes, I know, refactoring khugepaged, crazy idea.
>


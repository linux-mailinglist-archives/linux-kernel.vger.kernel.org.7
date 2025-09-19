Return-Path: <linux-kernel+bounces-824218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12023B886AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA5E170215
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830962E7162;
	Fri, 19 Sep 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BYbebIN2"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD331306D4D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270439; cv=none; b=lo/cGAdKzURV4qIXpcfuZgsOW90HFbwQ1V0l7uqRivlHQsCTMGaJvw9rQMOKBW2gm0TgDm/YJOrCao8IQih27KQuOK+x5DnZUTYkumckBXJTFhzF4KWEfsXl2uVTJkBvJfDABa3Y1JpKxSOKDdYOsHSyLIHffzpCPZm4tvn2KLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270439; c=relaxed/simple;
	bh=EgmxBvWRf9JqYnofJ9ed2lBWYgz7z8uitx31KvaHBeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1IB7vkYgCUGuQ1HT6/oltmLMN7JufjKscHJ0u5eOfh9niA5jFwWWb/vGNC20omwloMviqPXFhsskfQbiGlfkDTdDDXG0pwuxuNqVpqx5/cIujnyFaCnDyrPseMuYH0mZk34Gva4Mv2S9VYMJxy2FIV122kLwbcSGK5quKvPeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BYbebIN2; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f489325f-695c-4329-a011-60830b74bb4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758270431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5IPepsPTCQyll6N7z1GGSXOwpevduVI0QCfANT/a9s=;
	b=BYbebIN2TMeI3CzIO0kGNmy6bi/trltsui9GUgiNnqDYd+xqryUxxGZpg8R6sySGIAQ9e7
	TRPyoC0zhHmzHDEuFOI5GAE4d3OzaVbEFDSCtSqjo1EPu9Em0HVL+ZSgdQ5vi3f7JDB4Zb
	mwyxbKJeRKHMrL4AeOsx61IXzZEiNOw=
Date: Fri, 19 Sep 2025 16:26:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, kirill@shutemov.name,
 hughd@google.com, mpenttil@redhat.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
 <a696c734-9f88-4d6f-a852-013071a2dd2a@redhat.com>
 <eabd866a-aed3-4e28-a139-13b7c1d4e715@linux.dev>
 <7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/19 15:57, David Hildenbrand wrote:
> On 19.09.25 04:41, Lance Yang wrote:
>>
>>
>> On 2025/9/19 02:47, David Hildenbrand wrote:
>>> On 18.09.25 07:04, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
>>>> lightweight guard regions.
>>>>
>>>> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail 
>>>> when
>>>> encountering such a range.
>>>>
>>>> MADV_COLLAPSE fails deep inside the collapse logic when trying to 
>>>> swap-in
>>>> the special marker in __collapse_huge_page_swapin().
>>>>
>>>> hpage_collapse_scan_pmd()
>>>>    `- collapse_huge_page()
>>>>        `- __collapse_huge_page_swapin() -> fails!
>>>>
>>>> khugepaged's behavior is slightly different due to its max_ptes_swap
>>>> limit
>>>> (default 64). It won't fail as deep, but it will still needlessly 
>>>> scan up
>>>> to 64 swap entries before bailing out.
>>>>
>>>> IMHO, we can and should detect this much earlier.
>>>>
>>>> This patch adds a check directly inside the PTE scan loop. If a guard
>>>> marker is found, the scan is aborted immediately with
>>>> SCAN_PTE_NON_PRESENT,
>>>> avoiding wasted work.
>>>>
>>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>> ---
>>>>    mm/khugepaged.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 9ed1af2b5c38..70ebfc7c1f3e 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct
>>>> mm_struct *mm,
>>>>                        result = SCAN_PTE_UFFD_WP;
>>>>                        goto out_unmap;
>>>>                    }
>>>> +                /*
>>>> +                 * Guard PTE markers are installed by
>>>> +                 * MADV_GUARD_INSTALL. Any collapse path must
>>>> +                 * not touch them, so abort the scan immediately
>>>> +                 * if one is found.
>>>> +                 */
>>>> +                if (is_guard_pte_marker(pteval)) {
>>>> +                    result = SCAN_PTE_NON_PRESENT;
>>>> +                    goto out_unmap;
>>>> +                }
>>>
>>> Thinking about it, this is interesting.
>>>
>>> Essentially we track any non-swap swap entries towards
>>> khugepaged_max_ptes_swap, which is rather weird.
>>>
>>> I think we might also run into migration entries here and hwpoison 
>>> entries?
>>>
>>> So what about just generalizing this:
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index af5f5c80fe4ed..28f1f4bf0e0a8 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1293,7 +1293,24 @@ static int hpage_collapse_scan_pmd(struct
>>> mm_struct *mm,
>>>           for (_address = address, _pte = pte; _pte < pte + 
>>> HPAGE_PMD_NR;
>>>                _pte++, _address += PAGE_SIZE) {
>>>                   pte_t pteval = ptep_get(_pte);
>>> -               if (is_swap_pte(pteval)) {
>>> +
>>> +               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>> +                       ++none_or_zero;
>>> +                       if (!userfaultfd_armed(vma) &&
>>> +                           (!cc->is_khugepaged ||
>>> +                            none_or_zero <= 
>>> khugepaged_max_ptes_none)) {
>>> +                               continue;
>>> +                       } else {
>>> +                               result = SCAN_EXCEED_NONE_PTE;
>>> +                               
>>> count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>> +                               goto out_unmap;
>>> +                       }
>>> +               } else if (!pte_present(pteval)) {
>>> +                       if (non_swap_entry(pte_to_swp_entry(pteval))) {
>>> +                               result = SCAN_PTE_NON_PRESENT;
>>> +                               goto out_unmap;
>>> +                       }
>>> +
>>>                           ++unmapped;
>>>                           if (!cc->is_khugepaged ||
>>>                               unmapped <= khugepaged_max_ptes_swap) {
>>> @@ -1313,18 +1330,7 @@ static int hpage_collapse_scan_pmd(struct
>>> mm_struct *mm,
>>>                                   goto out_unmap;
>>>                           }
>>>                   }
>>> -               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>> -                       ++none_or_zero;
>>> -                       if (!userfaultfd_armed(vma) &&
>>> -                           (!cc->is_khugepaged ||
>>> -                            none_or_zero <= 
>>> khugepaged_max_ptes_none)) {
>>> -                               continue;
>>> -                       } else {
>>> -                               result = SCAN_EXCEED_NONE_PTE;
>>> -                               
>>> count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>> -                               goto out_unmap;
>>> -                       }
>>> -               }
>>> +
>>>                   if (pte_uffd_wp(pteval)) {
>>>                           /*
>>>                            * Don't collapse the page if any of the small
>>>
>>>
>>> With that, the function flow looks more similar to
>>> __collapse_huge_page_isolate(),
>>> except that we handle swap entries in there now.
>>
>> Ah, indeed. I like this crazy idea ;p
>>
>>>
>>>
>>> And with that in place, couldn't we factor out a huge chunk of both
>>> scanning
>>> functions into some helper (passing whether swap entries are allowed or
>>> not?).
>>
>> Yes. Factoring out the common scanning logic into a new helper is a
>> good suggestion. It would clean things up ;)
>>
>>>
>>> Yes, I know, refactoring khugepaged, crazy idea.
>>
>> I'll look into that. But let's do this separately :)
> 
> Right, but let's just skip any non-swap entries early in this patch 
> instead of special-casing only guard ptes.

Ah, right! I missed the other non-swap entries. Will rework this patch
as you suggested!

Cheers,
Lance



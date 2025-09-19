Return-Path: <linux-kernel+bounces-823921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB0B87BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3EE3AD77C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7A3246BB6;
	Fri, 19 Sep 2025 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MKGEJivH"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9662264AD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758249722; cv=none; b=hXKXcT8Fi3a95f4jnIPMPnDgp8qlieArGxERmX0xzBSjiQHES91mnS3x9fNtnRBnP0g+JkY5+GVwLb5mURbgpXLbrdrO7UDAgWLtOPp+gtVT33ndzyNKPIRkIKbUJGdAT/Jft49RFNHr/i/NB8FNvUAMcA8asB1HD0YkgMdxhDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758249722; c=relaxed/simple;
	bh=J5hxMnYbCOSaY19mDdzY05EZhi/RbVb37H/vBA2VIF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiGfaOsz6dpjz/ZlbCx3K7QGOl83b6qjTGiqv9/Xg4cnGztoUYYpAMhzecws5MsGaKnzw7sTU18XhWJnW2orpqRDuAnMTDhDdNF+tE2cuQirkd0QkQZYq8YAdGA4odEe0tynQSSrY/LQHpmL4CjPwfl/OPcLC7uJnpvcZccC7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MKGEJivH; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eabd866a-aed3-4e28-a139-13b7c1d4e715@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758249718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOUYmorl2vXwXIh7NZzsymKhAVYTrNuSDHQ/iAUV2PM=;
	b=MKGEJivHc42R/NfCjKmZBd9XndL1e1w2iM+yb8YZwTHrId6TWcSYGjiKSX7sRiZAHwNOb9
	qieUWzLl8HTtNL7lz++Hv9jmKKrj+ksJOqEEptglJbcoV1CkSnmO/1ZBNiyXMakjXcG+gC
	BEE1Xne7+KnPXT/NAt8Zeu8zjX08zjA=
Date: Fri, 19 Sep 2025 10:41:47 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a696c734-9f88-4d6f-a852-013071a2dd2a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/19 02:47, David Hildenbrand wrote:
> On 18.09.25 07:04, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
>> lightweight guard regions.
>>
>> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail when
>> encountering such a range.
>>
>> MADV_COLLAPSE fails deep inside the collapse logic when trying to swap-in
>> the special marker in __collapse_huge_page_swapin().
>>
>> hpage_collapse_scan_pmd()
>>   `- collapse_huge_page()
>>       `- __collapse_huge_page_swapin() -> fails!
>>
>> khugepaged's behavior is slightly different due to its max_ptes_swap 
>> limit
>> (default 64). It won't fail as deep, but it will still needlessly scan up
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
> I think we might also run into migration entries here and hwpoison entries?
> 
> So what about just generalizing this:
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index af5f5c80fe4ed..28f1f4bf0e0a8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1293,7 +1293,24 @@ static int hpage_collapse_scan_pmd(struct 
> mm_struct *mm,
>          for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>               _pte++, _address += PAGE_SIZE) {
>                  pte_t pteval = ptep_get(_pte);
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
> +                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +                               goto out_unmap;
> +                       }
> +               } else if (!pte_present(pteval)) {
> +                       if (non_swap_entry(pte_to_swp_entry(pteval))) {
> +                               result = SCAN_PTE_NON_PRESENT;
> +                               goto out_unmap;
> +                       }
> +
>                          ++unmapped;
>                          if (!cc->is_khugepaged ||
>                              unmapped <= khugepaged_max_ptes_swap) {
> @@ -1313,18 +1330,7 @@ static int hpage_collapse_scan_pmd(struct 
> mm_struct *mm,
>                                  goto out_unmap;
>                          }
>                  }
> -               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> -                       ++none_or_zero;
> -                       if (!userfaultfd_armed(vma) &&
> -                           (!cc->is_khugepaged ||
> -                            none_or_zero <= khugepaged_max_ptes_none)) {
> -                               continue;
> -                       } else {
> -                               result = SCAN_EXCEED_NONE_PTE;
> -                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> -                               goto out_unmap;
> -                       }
> -               }
> +
>                  if (pte_uffd_wp(pteval)) {
>                          /*
>                           * Don't collapse the page if any of the small
> 
> 
> With that, the function flow looks more similar to 
> __collapse_huge_page_isolate(),
> except that we handle swap entries in there now.

Ah, indeed. I like this crazy idea ;p

> 
> 
> And with that in place, couldn't we factor out a huge chunk of both 
> scanning
> functions into some helper (passing whether swap entries are allowed or 
> not?).

Yes. Factoring out the common scanning logic into a new helper is a
good suggestion. It would clean things up ;)

> 
> Yes, I know, refactoring khugepaged, crazy idea.

I'll look into that. But let's do this separately :)

Cheers,
Lance




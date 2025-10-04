Return-Path: <linux-kernel+bounces-841926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E4BB88B8
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500C43C5649
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B264E1B4257;
	Sat,  4 Oct 2025 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bi1E45ly"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784639FD9
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759547334; cv=none; b=RG7OvkJwcO6t0UiFICTELbId6dy00R/Qgl97CEyDLC0vDzjMUxbZZVlViZ89cdarL6o3iYd6v7n0VBE+epLNIiGrM+R2e67w48Zkj26mjKRFPOXZiN3L/PlLBdTj9DoG8Z7ZOy5YOjWFwbVoSzEjZ0zismO7/rf/Hn0ArZDHc9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759547334; c=relaxed/simple;
	bh=ogkvRpl5jgbLFMsYrPO1gQLgC/yLv4i/cNaVBL6t75g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SF5QUilwCjgQ6TxDzV49n+nrD8Ld2z0koa5pDqffizj27m5ND+HyOyyhgdSkW7PJ1mNsaKa/IgRCYShLwe4G21UhLtCyOoqzJr1eq1rufFx5jmkwWwYeOY9lt9v/yJfW9fW+kJgOkl0Q8pb5iyxtwLQdygR8c+CJBU5Gzs9limE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bi1E45ly; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ecb9ba1-8801-42b8-9575-5add856d0441@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759547330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VH7Jum0STCRvqZ+0XX5TR3xWpnSLpgoUkMhO7MpcgEk=;
	b=bi1E45lyAmGuMPAX85dpy4bq2sam/tjVCrywn8Xl6Pg/gGO8PIxt6apUejVSKZsxuBpjiZ
	mAj0a/Kzw92YoPRyG5UjziWIYipIzm3E51orNfMiAGSHg2n5jVYNim5yfMpTdqResIZwbS
	hgHF7dRMDgQ5SWRuOwfS0yjN33kK+Ck=
Date: Sat, 4 Oct 2025 11:08:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/2] mm/khugepaged: optimize PTE scanning with
 if-else-if-else-if chain
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 lorenzo.stoakes@oracle.com, david@redhat.com, ioworker0@gmail.com,
 richard.weiyang@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-2-lance.yang@linux.dev>
 <b8fc9ab7-a96f-4763-9432-8aa8c3c2a87d@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <b8fc9ab7-a96f-4763-9432-8aa8c3c2a87d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/4 00:33, Dev Jain wrote:
> 
> On 02/10/25 1:02 pm, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> As pointed out by Dev, the PTE checks for disjoint conditions in the
>> scanning loops can be optimized. is_swap_pte, (pte_none && is_zero_pfn),
>> and pte_uffd_wp are mutually exclusive.
>>
>> This patch refactors the loops in both __collapse_huge_page_isolate() and
>> hpage_collapse_scan_pmd() to use a continuous if-else-if-else-if chain
>> instead of separate if blocks.
>>
>> Also, this is a preparatory step to make it easier to merge the
>> almost-duplicated scanning logic in these two functions, as suggested
>> by David.
>>
>> Suggested-by: Dev Jain <dev.jain@arm.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index f4f57ba69d72..808523f92c7b 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -548,8 +548,7 @@ static int __collapse_huge_page_isolate(struct 
>> vm_area_struct *vma,
>>       for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>>            _pte++, addr += PAGE_SIZE) {
>>           pte_t pteval = ptep_get(_pte);
>> -        if (pte_none(pteval) || (pte_present(pteval) &&
>> -                is_zero_pfn(pte_pfn(pteval)))) {
>> +        if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> 
> Should have mentioned in the description that pte_present() is not required
> here, so removing it.

Yep, got it.

> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>

Cheers,
Lance

> 
>>               ++none_or_zero;
>>               if (!userfaultfd_armed(vma) &&
>>                   (!cc->is_khugepaged ||
>> @@ -560,12 +559,10 @@ static int __collapse_huge_page_isolate(struct 
>> vm_area_struct *vma,
>>                   count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>                   goto out;
>>               }
>> -        }
>> -        if (!pte_present(pteval)) {
>> +        } else if (!pte_present(pteval)) {
>>               result = SCAN_PTE_NON_PRESENT;
>>               goto out;
>> -        }
>> -        if (pte_uffd_wp(pteval)) {
>> +        } else if (pte_uffd_wp(pteval)) {
>>               result = SCAN_PTE_UFFD_WP;
>>               goto out;
>>           }
>> @@ -1316,8 +1313,7 @@ static int hpage_collapse_scan_pmd(struct 
>> mm_struct *mm,
>>                   count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>>                   goto out_unmap;
>>               }
>> -        }
>> -        if (pte_uffd_wp(pteval)) {
>> +        } else if (pte_uffd_wp(pteval)) {
>>               /*
>>                * Don't collapse the page if any of the small
>>                * PTEs are armed with uffd write protection.



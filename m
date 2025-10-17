Return-Path: <linux-kernel+bounces-857611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4A2BE741E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4409C1AA0BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E662D3A7C;
	Fri, 17 Oct 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mHdZop5p"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B01B2C029D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690859; cv=none; b=FRDVGkHOLbyOJEN0Y6Qv1KRfilfOnD/DnJE1iiLD+hmQi1ySKIQc7Ry0iMVvkWtG/IrnikxkhlREzqb1PZqEDApoQK/7keUG9GKyiERT5GzilvO263/eaatoYhHXwA0w6PwP9RfRi37xTl+k75ZDbtT42WUPu2TaB+XqdIPFAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690859; c=relaxed/simple;
	bh=V28Kl+5k/pQA7w+DJc/wRQoeqpk5BVezu05zsS8io0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXPMMnmqeYDGbS707VO0wGzuScLFoZeQtgeVGNWd+932T/V+oEHqb0Lj2hMPKsz6ej3vg6HqhT6VcUjJYvxEGwTCflOlI+5kixMxGA7PlOHgdkrpBzKZdbYklR2hY6EQBH6B3u6SjODMmBCK+2jkCv0OLB+cZ1qHvPc9XRaYXq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mHdZop5p; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <13b41a39-cdb1-4537-b4c8-940674c5875d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760690855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD/R4CwZofsKKYJHbZWsPDyQl7J+N7r0zqZT/mrEyfo=;
	b=mHdZop5p1rSOj+z23FxR20Rmj+8SIpqO5da+owwVu1ds+Fx4h6YWK5llE8gAjBkJCtn88S
	Jt/8gTKAoJySK399ijwf7PK+9AAtmT4OnEfh1z0qX/bjoln4vuthbReljSBj1Y8QHHA+rY
	TgFK2ZMw7Mp3pxBdD66TwaDs9jB+vKY=
Date: Fri, 17 Oct 2025 16:47:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with
 pte_present()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Wei Yang
 <richard.weiyang@gmail.com>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251016033643.10848-1-lance.yang@linux.dev>
 <17c4c5f9-6ac8-4914-838f-f511dfbf948f@arm.com>
 <20251017012724.4bo5oj2g6tdmp2fv@master>
 <1674efca-6d4e-4247-8b1c-b6816360d8bb@redhat.com>
 <ab918a83-edb2-4a19-821d-a96de9e097eb@linux.dev>
 <4a7a7fbb-e33e-4033-91e7-efce7915cf7f@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <4a7a7fbb-e33e-4033-91e7-efce7915cf7f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/17 16:43, David Hildenbrand wrote:
> On 17.10.25 10:37, Lance Yang wrote:
>>
>>
>> On 2025/10/17 16:11, David Hildenbrand wrote:
>>> On 17.10.25 03:27, Wei Yang wrote:
>>>> On Thu, Oct 16, 2025 at 11:47:06AM +0530, Dev Jain wrote:
>>>>>
>>>>> On 16/10/25 9:06 am, Lance Yang wrote:
>>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>>
>>>>>> A non-present entry, like a swap PTE, contains completely different
>>>>>> data
>>>>>> (swap type and offset). pte_pfn() doesn't know this, so if we feed 
>>>>>> it a
>>>>>> non-present entry, it will spit out a junk PFN.
>>>>>>
>>>>>> What if that junk PFN happens to match the zeropage's PFN by sheer
>>>>>> chance? While really unlikely, this would be really bad if it did.
>>>>>>
>>>>>> So, let's fix this potential bug by ensuring all calls to 
>>>>>> is_zero_pfn()
>>>>>> in khugepaged.c are properly guarded by a pte_present() check.
>>>>>>
>>>>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>>>> ---
>>>>>>     mm/khugepaged.c | 13 ++++++++-----
>>>>>>     1 file changed, 8 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>>>> index d635d821f611..0341c3d13e9e 100644
>>>>>> --- a/mm/khugepaged.c
>>>>>> +++ b/mm/khugepaged.c
>>>>>> @@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t
>>>>>> *_pte,
>>>>>>             pte_t pteval = ptep_get(_pte);
>>>>>>             unsigned long pfn;
>>>>>> -        if (pte_none(pteval))
>>>>>> +        if (!pte_present(pteval))
>>>>>>                 continue;
>>>>>>             pfn = pte_pfn(pteval);
>>>>>>             if (is_zero_pfn(pfn))
>>>>>> @@ -690,9 +690,10 @@ static void
>>>>>> __collapse_huge_page_copy_succeeded(pte_t *pte,
>>>>>>              address += nr_ptes * PAGE_SIZE) {
>>>>>>             nr_ptes = 1;
>>>>>>             pteval = ptep_get(_pte);
>>>>>> -        if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>>>>> +        if (pte_none(pteval) ||
>>>>>> +            (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
>>>>>>                 add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
>>>>>> -            if (is_zero_pfn(pte_pfn(pteval))) {
>>>>>> +            if (!pte_none(pteval)) {
>>>>>
>>>>> Could save a level of indentation by saying
>>>>> if (pte_none(pteval))
>>>>>      continue;
>>>>>
>>>>
>>>> Vote for this :-)
>>>
>>> I suspect there will be a v2, correct?
>>
>> I was hoping a v2 wouldn't be necessary for this ;p
>>
>> Of course, if we'd prefer a v2, I'm happy to send one out.
> 
> I lost track of what the result will be, so a v2 would be nice at least 
> for me :)

Sure. V2 on the way ;)



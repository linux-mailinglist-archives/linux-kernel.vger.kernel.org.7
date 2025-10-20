Return-Path: <linux-kernel+bounces-861166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC2ABF1F54
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3B094F5D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B72230274;
	Mon, 20 Oct 2025 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nP6Iqe3S"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F71DE4C2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972342; cv=none; b=bZTZnOiWMAb01sD/ePtrz7gH4CcaX1GsSteULOPi30G6i0JfvLlDDEKwO7SKrXCMtpWgXB6mhzBR0i0jBfcoBP4Pwhhd2esAvGEoxSK3kKChvqXLsLbTfCwoRAoUBKWZx8eqW3+EcTbsqyeSBvyUJiYiuHX3g+e3sDkJ/iOfKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972342; c=relaxed/simple;
	bh=kK0Hplkebq3Jrcf6qR3oANpGvK/cEA32zWG+bqxYj90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxiVu7P5ZTZ2SinboUDFmEdKUr/MlLXgD3cZtu+rc9BTDjE9B6DGhtBbYPKHyAUxzo2yhoGZ51T1v9J7OqZiDZuofLoOXlcYM2ihClu3jYzzEkO655y3a9VvWi0BbKQb6p8K3UETCIz/Su5GEzmQa2nh2gJxEH3SeEYe60xumzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nP6Iqe3S; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c1f01a29-e283-4557-8c76-3d17c0233ce8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760972338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0ma2WKO11obahVHhDWDsmsHYDqO6Dhx6s7hPUoAius=;
	b=nP6Iqe3S4byuBHsYB6xrj4GYA5+Um0vVMnkFv+Gt80VtlRWuYhTB4SYNhlbPLfq4urNka7
	o0BfciXYyepX9fLYxx/iHk/ImRU67JfsAk11uGiAk7UaoQcb1Fu5AHNj3pIJJ0jP4D1hXf
	ohtxfJ/XWAKa1+nRV+NlGAJlOKoJWk8=
Date: Mon, 20 Oct 2025 22:58:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: guard is_zero_pfn() calls
 with pte_present()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Wei Yang <richard.weiyang@gmail.com>
References: <20251017093847.36436-1-lance.yang@linux.dev>
 <699b143a-cca4-486c-a4ad-d0be561d4ab2@lucifer.local>
 <b5627e83-489c-4e16-910c-fe7e56912793@linux.dev>
 <2caf088c-e321-428e-afce-b1c11f52bc3f@lucifer.local>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <2caf088c-e321-428e-afce-b1c11f52bc3f@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/20 21:55, Lorenzo Stoakes wrote:
> On Sat, Oct 18, 2025 at 12:33:33AM +0800, Lance Yang wrote:
>>
>>
>> On 2025/10/17 23:44, Lorenzo Stoakes wrote:
>>> On Fri, Oct 17, 2025 at 05:38:47PM +0800, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> A non-present entry, like a swap PTE, contains completely different data
>>>> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
>>>> non-present entry, it will spit out a junk PFN.
>>>
>>> It feels like this somewhat contradicts points I've made on the original series
>>> re the is_swap_pte() stuff. Sigh.
>>
>> My bad. I didn't get your point before ...
> 
> Don't worry, this is a problem that existed already and needs addressing, series
> incoming :)

Nice!

> 
>>
>> And this patch is not intended to touch is_swap_pte() ...
> 
> Ack
> 
>>
>>>
>>> I guess that's _such a mess_ it's hard to avoid though.
>>>
>>> And I guess it's reasonable that !pte_present() means we can't expect a valid
>>> PFN though.
>>
>> Yes, I think we expect a valid PFN must be under pte_present().
> 
> Yes
> 
>>
>>>
>>>>
>>>> What if that junk PFN happens to match the zeropage's PFN by sheer
>>>> chance? While really unlikely, this would be really bad if it did.
>>>>
>>>> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
>>>> in khugepaged.c are properly guarded by a pte_present() check.
>>>>
>>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>
>>> Not sure I really suggested something that strictly contradicts points I
>>> made... but I guess I did suggest guarding this stuff more carefully.
>>
>> Sorry, I didn't catch you again ... Will drop the Suggested-by tag.
> 
> Nah it's fine sorry, I think in general you are doing what I asked.

Thanks for clarifying! I'll keep the Suggested-by tag then ;)

> 
> I'm going to address the is_swap_pte() stuff separately anyway :) have discussed
> with David off-list a lot. Think I have a sensible plan...

That's great to hear!

> 
>>
>>>
>>>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>> ---
>>>> Applies against commit 0f22abd9096e in mm-new.
>>>>
>>>> v1 -> v2:
>>>>    - Collect Reviewed-by from Dev, Wei and Baolin - thanks!
>>>>    - Reduce a level of indentation (per Dev)
>>>>    - https://lore.kernel.org/linux-mm/20251016033643.10848-1-lance.yang@linux.dev/
>>>>
>>>>    mm/khugepaged.c | 29 ++++++++++++++++-------------
>>>>    1 file changed, 16 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index d635d821f611..648d9335de00 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>>>>    		pte_t pteval = ptep_get(_pte);
>>>>    		unsigned long pfn;
>>>>
>>>> -		if (pte_none(pteval))
>>>> +		if (!pte_present(pteval))
>>>>    			continue;
>>>>    		pfn = pte_pfn(pteval);
>>>>    		if (is_zero_pfn(pfn))
>>>> @@ -690,17 +690,18 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>>>>    	     address += nr_ptes * PAGE_SIZE) {
>>>>    		nr_ptes = 1;
>>>>    		pteval = ptep_get(_pte);
>>>> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>>> +		if (pte_none(pteval) ||
>>>> +		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
>>>>    			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
>>>> -			if (is_zero_pfn(pte_pfn(pteval))) {
>>>> -				/*
>>>> -				 * ptl mostly unnecessary.
>>>> -				 */
>>>> -				spin_lock(ptl);
>>>> -				ptep_clear(vma->vm_mm, address, _pte);
>>>> -				spin_unlock(ptl);
>>>> -				ksm_might_unmap_zero_page(vma->vm_mm, pteval);
>>>> -			}
>>>> +			if (pte_none(pteval))
>>>> +				continue;
>>>
>>> Yeah I'm not sure I really love this refactoring.
>>>
>>> Can be:
>>>
>>> 		if (!is_swap_pte(pteval)) {
>>> 			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
>>> 			if (!is_zero_pfn(pte_pfn(pteval)))
>>> 				continue;
>>>
>>> 			...
>>> 		}
>>>
>>> Doing pte_pfn() on a pte_none() PTE is fine.
>>>
>>> Obviously as theree's a lot of hate for is_swap_pte() you could also do:
>>>
>>> 		if (pte_none(pteval) || pte_present(pteval)) {
>>> 			...
>>> 		}
>>>
>>> Which literally open-codes !is_swap_pte().
>>>
>>> At the same time, this makes very clear that PTE none is OK.
>>
>> Emm, I'd prefer the new helper pte_none_or_zero() here:
>>
>> if (pte_none_or_zero(pteval)) {
>> 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
>> 	if (pte_none(pteval))
>> 		continue;
>> 	....
>> }
>> That looks really clean and simple for me ;)
> 
> Haha yeah sure that's better :)

Glad you like the pte_none_or_zero() helper. I'll go with that.

> 
>>
>>>
>>>> +			/*
>>>> +			 * ptl mostly unnecessary.
>>>> +			 */
>>>> +			spin_lock(ptl);
>>>> +			ptep_clear(vma->vm_mm, address, _pte);
>>>> +			spin_unlock(ptl);
>>>> +			ksm_might_unmap_zero_page(vma->vm_mm, pteval);
>>>>    		} else {
>>>>    			struct page *src_page = pte_page(pteval);
>>>>
>>>> @@ -794,7 +795,8 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>>>>    		unsigned long src_addr = address + i * PAGE_SIZE;
>>>>    		struct page *src_page;
>>>>
>>>> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>>> +		if (pte_none(pteval) ||
>>>> +		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
>>>>    			clear_user_highpage(page, src_addr);
>>>>    			continue;
>>>>    		}
>>>> @@ -1294,7 +1296,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>>>    				goto out_unmap;
>>>>    			}
>>>>    		}
>>>> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>>> +		if (pte_none(pteval) ||
>>>> +		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
>>>>    			++none_or_zero;
>>>>    			if (!userfaultfd_armed(vma) &&
>>>>    			    (!cc->is_khugepaged ||
>>>> --
>>>> 2.49.0
>>>>
>>>
>>> I mean all of this seems super gross anyway. We're constantly open-coding the
>>> same check over and over again.
>>>
>>> static inline bool pte_is_none_or_zero(pte_t pteval)
>>> {
>>> 	if (is_swap_pte(pteval))
>>> 		return false;
>>>
>>> 	return is_zero_pfn(pte_pfn(pteval));
>>> }
>>>
>>> Put somewhere in a relevant header file.
>>>
>>> Or again, if there's distaste at is_swap_pte(), and here maybe it's more valid
>>> not to use it (given name of function).
>>>
>>> static inline bool pte_is_none_or_zero(pte_t pteval)
>>> {
>>> 	/* Non-present entries do not have a PFN to check. */
>>> 	if (!pte_present(pteval))
>>> 		return false;
>>>
>>> 	if (pte_none(pteval))
>>> 		return true;
>>>
>>> 	return is_zero_pfn(pte_pfn(pteval));
>>> }
>>
>> Yeah, I'll put pte_none_or_zero() in this file first.
>>
>> static inline bool pte_none_or_zero(pte_t pte)
>> {
>> 	if (pte_none(pte))
>> 		return true;
>> 	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
>> }
> 
> Well I intended this to be in some general header file, but it's not obvious
> actually where would make sense so feel free to put here as a static (no need
> for inline).

Thanks! I will make it a static function in this file for now :)

> 
>>
>>>
>>> I think I'm going to do a series to addres the is_swap_pte() mess actually, as
>>> this whole thing is very frustrating.
>>
>> Excellent! Looking forward to your series to clean that up ;)
> 
> Already started on it :)

Cool! Really looking forward to the is_swap_pte() cleanup series!

Thanks,
Lance



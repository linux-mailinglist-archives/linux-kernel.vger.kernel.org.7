Return-Path: <linux-kernel+bounces-852906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34113BDA330
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328CF18A3D04
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76B12C0F64;
	Tue, 14 Oct 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mc3BGk1l"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194E25BEF2
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454096; cv=none; b=tOFNqWj9bAYCWuTSrmspW3lB78meUv44Q0XbOdLzxe7OBvcY1wf7XIhoIwg4nGdzUemFIWAIfoN70O9FuxkHhJKw4PFWRtiw9QbCH5tnsYVShCOXIs6CqKtJV9pZ5fwhA0qxL6idHhubN7RvwsMyTgw8E/j3o9UqkgRf6/h8Ywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454096; c=relaxed/simple;
	bh=mhe+ISGY1+JYt+BLY6+x29jcecp3fFER7VeOt+v8I3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZ9tHmli32EPFIQ+JMBqdJPkmEIthCf3hT+5waSv/ziCoinxruSb1C07nHglzdbvsgwXOyi/RKuLVPbtwWv9A0cyawYj263lGdmg80PBeumJVT5O9XX0bozbmvLx7qSSwH75vCz7feiPFWWmF1t7QJfDDtFU018JTYKdxSTNW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mc3BGk1l; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d2e5b099-94bd-444d-9946-182807443539@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760454091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AB9j6O3TPji8YNEzc+bgFaMn1t+j1zQSsTJC9AP4fx4=;
	b=mc3BGk1laLOWzAF5w/uZV0flGEZx0baY7aeoTRTSkf+Blbng98lexfcRFo5vWyJFzc98eP
	0pkpMSXcdutVbpE9GhGemQE1cLazHEkR0wheL8UQ2RfZeOpZEQSyeMDgmlpQEX2+LUQaC+
	WdXJX3Hr31s7/2r7jIDxnIUFzo2+4A4=
Date: Tue, 14 Oct 2025 23:01:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, Liam.Howlett@oracle.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, dev.jain@arm.com,
 hughd@google.com, ioworker0@gmail.com, kirill@shutemov.name,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mpenttil@redhat.com,
 npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com,
 richard.weiyang@gmail.com
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
 <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/14 22:39, Lorenzo Stoakes wrote:
> On Tue, Oct 14, 2025 at 10:26:20PM +0800, Lance Yang wrote:
>>
>>
>> On 2025/10/14 19:08, Lorenzo Stoakes wrote:
>>> On Wed, Oct 08, 2025 at 11:26:57AM +0800, Lance Yang wrote:
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index abe54f0043c7..bec3e268dc76 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1020,6 +1020,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>>>>    		if (!is_swap_pte(vmf.orig_pte))
>>>>    			continue;
>>>>
>>>> +		if (non_swap_entry(pte_to_swp_entry(vmf.orig_pte))) {
>>>> +			result = SCAN_PTE_NON_PRESENT;
>>>> +			goto out;
>>>> +		}
>>>
>>> OK seems in line with what we were discussing before...
>>
>> Yep. That's the idea :)
>>
>>>
>>>> +
>>>>    		vmf.pte = pte;
>>>>    		vmf.ptl = ptl;
>>>>    		ret = do_swap_page(&vmf);
>>>> @@ -1281,7 +1286,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>>>    	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>>>    	     _pte++, addr += PAGE_SIZE) {
>>>>    		pte_t pteval = ptep_get(_pte);
>>>> -		if (is_swap_pte(pteval)) {
>>>> +		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>>> +			++none_or_zero;
>>>> +			if (!userfaultfd_armed(vma) &&
>>>> +			    (!cc->is_khugepaged ||
>>>> +			     none_or_zero <= khugepaged_max_ptes_none)) {
>>>> +				continue;
>>>> +			} else {
>>>> +				result = SCAN_EXCEED_NONE_PTE;
>>>> +				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>>> +				goto out_unmap;
>>>> +			}
>>>> +		} else if (!pte_present(pteval)) {
>>>> +			if (non_swap_entry(pte_to_swp_entry(pteval))) {
>>>
>>
>> Thanks for pointing that out!
> 
> You've deleted what I've said here and also not indicated whether you'll do what
> I asked :)
> 
> Please be clearer...

Oh, I didn't delete your comment at all ... It's just below ...

> 
>>>>> Hm but can't this be pte_protnone() at this stage (or something 
else)? And then <-- Here!
>>
>> Yeah. The funny thing is, a protnone pte cannot actually get here, IIUC.
>>
>> ```
>> static inline int pte_protnone(pte_t pte)
>> {
>> 	return (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
>> 		== _PAGE_PROTNONE;
>> }
>>
>> static inline int pte_present(pte_t a)
>> {
>> 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
>> }
>> ```
>>
>> On x86, pte_present() returns true for a protnone pte. And I'd assume
>> other archs behave similarly ...
> 
> This was one example, we may make changes in the future that result in entries
> that are non-present but also non-swap.
> 
> I don't see the point in eliminating this check based on an implicit, open-coded
> assumption that this can never be the case, this is just asking for trouble.
> 
>>
>>> we're just assuming pte_to_swp_entry() is operating on a swap entry when it in
>>> fact might not be?
>>>
>>> Couldn't we end up with false positives here?
>>
>> Emm, I think we're good here and the code is doing the right thing.
> 
> I mean sorry but just - NO - to doing swap operations based on open-coded checks
> that you implicitly feel must imply a swap entry.
> 
> This makes the code a lot more confusing, it opens us up to accidentally
> breaking things in future and has little to no benefit, I don't see why we're
> doing it.
> 
> I don't think every little 'aha X must imply Y so just eliminate Z' idea need be
> implemented, this feels like a sort of 'mathematical reduction of code ignoring
> all other factors'.

Understood. Changing !pte_present() to is_swap_pte() will resolve all your
concerns, right?

```
if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
[...]
} else if (is_swap_pte(pteval)) { <-- Here
	if (non_swap_entry(pte_to_swp_entry(pteval))) {
		[...]
	}
[...]}
```

> 
>>
>>>
>>>> +				result = SCAN_PTE_NON_PRESENT;
>>>> +				goto out_unmap;
>>>> +			}
>>>> +
>>>>    			++unmapped;
>>>>    			if (!cc->is_khugepaged ||
>>>>    			    unmapped <= khugepaged_max_ptes_swap) {
>>>> @@ -1290,7 +1311,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>>>    				 * enabled swap entries.  Please see
>>>>    				 * comment below for pte_uffd_wp().
>>>>    				 */
>>>> -				if (pte_swp_uffd_wp_any(pteval)) {
>>>> +				if (pte_swp_uffd_wp(pteval)) {
>>>
>>> Again you're assuming it's a swap entry but you're not asserting this is a swap
>>> entry in this branch?
>>
>> As we discussed above, the non_swap_entry() check has already kicked out
>> anything that isn't a true swap entry, right?
> 
> This is a different function?
> 
> Actually I'm mistaken here I think - you check in the code above:
> 
> 		if (is_swap_pte(pteval)) {
> 			...
> 		}
> 
> So this is fine, please ignore sorry :)

No worries at all, thanks for double-checking and clarifying!

> 
>>
>>>
>>> Also an aside - I hate, hate, hate how this uffd wp stuff has infiltrated all
>>> kinds of open-coded stuff. It's so gross (not your fault, just a general
>>> comment...)
>>
>> Haha, tell me about it. No argument from me there ;)
> 
> :)
> 
>>
>> Thanks,
>> Lance
> 
> Cheers, Lorenzo



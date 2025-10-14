Return-Path: <linux-kernel+bounces-852816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5DABD9FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4562C1926CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F20248F5A;
	Tue, 14 Oct 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S2d02oP1"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB498347C7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451993; cv=none; b=pholNeU8ZrjdAJJgM6MIpt63KT6B7aGjMOfF/Yiryq1kbX0KNsaQiO8EpF5EWe37uC6KAbeD/1kWxUU6p++z5botrzYUp+SAEvuORxFAG4mylwDnnZMoiaH/daBqUKjZ4l6PvnkCRNAyLo8CPSGvxl92kiNZo0H9urRbxdoAS2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451993; c=relaxed/simple;
	bh=fECXitsFgOAURpKyqkRzkh3dipXrGyd4HeSblTxOJeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F70NZCkgpi6HZHD9oJl8/a5J4dFER8oaOdQu5UmOnn7VnSGlXIm68OGDAR0qbQp2p2OSB33w8Xu9+qWrnmI2nslco4CxnGl5hkHV9OQ6xAZb42xKXans4ZHV8NqTC/wP+Nn/vkziNz6MFkLIoEp2/SRdOpFlS+rsJ5zRQlB4Cis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S2d02oP1; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760451987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKOwPD9G8+OZsBs9+tZFf861qaxj85J1wxUDauqNxYI=;
	b=S2d02oP1UEv0IRpH1hPdj4EYsQk3cuYBa+siMbrG6yg8lsb0Eb54XTRSWFCRjW1mKap5LU
	Lcj0vNxI9p3glvUB3dU0luEwJyWUrP0wvGsGG/YKJGBq7XeW7N9eZ46svhm166sLw1rVV9
	M2GDxG1qcN0Vf8qmrEzHerBdJO7aWc8=
Date: Tue, 14 Oct 2025 22:26:20 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/14 19:08, Lorenzo Stoakes wrote:
> On Wed, Oct 08, 2025 at 11:26:57AM +0800, Lance Yang wrote:
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
> 
> OK seems in line with what we were discussing before...

Yep. That's the idea :)

> 
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
> 

Thanks for pointing that out!

> Hm but can't this be pte_protnone() at this stage (or something else)? And then

Yeah. The funny thing is, a protnone pte cannot actually get here, IIUC.

```
static inline int pte_protnone(pte_t pte)
{
	return (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
		== _PAGE_PROTNONE;
}

static inline int pte_present(pte_t a)
{
	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
}
```

On x86, pte_present() returns true for a protnone pte. And I'd assume
other archs behave similarly ...

> we're just assuming pte_to_swp_entry() is operating on a swap entry when it in
> fact might not be?
> 
> Couldn't we end up with false positives here?

Emm, I think we're good here and the code is doing the right thing.

> 
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
> Again you're assuming it's a swap entry but you're not asserting this is a swap
> entry in this branch?

As we discussed above, the non_swap_entry() check has already kicked out
anything that isn't a true swap entry, right?

> 
> Also an aside - I hate, hate, hate how this uffd wp stuff has infiltrated all
> kinds of open-coded stuff. It's so gross (not your fault, just a general
> comment...)

Haha, tell me about it. No argument from me there ;)

Thanks,
Lance


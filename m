Return-Path: <linux-kernel+bounces-842206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C43BBB937A
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 04:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B833BE783
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 02:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7642715B135;
	Sun,  5 Oct 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HpvFpLx9"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB4146A72
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759630394; cv=none; b=OFtqsqTSc3L9+ayH2FTHuf/xrAtWL1QATggAY2RtCUt7LosiirMawQfzt25FrFn9ZNs7mokNbqmVE1tu2lR2JZA/CjSzDKgPRSxInmyLxApSQcsVCPZzdzBbiSWjE59s8VLdEHPuKD5qxdm62DiK5cpqCM+9m2/5TwHHl+DXRBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759630394; c=relaxed/simple;
	bh=ZIsInwdC7KhL0tgv4pWQYAVHB4cEbWghmr56eHnrrOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nS4yckNin8vc/oMMbjPcOYfQJupZ0BSIXGqWCfT/FuiyblrU9wWeDUTHJQ9F2MdZHRjHOAAeU65x5HwkwhSpS7M6CKMcRt0KZ3Pgy8LqimqiY4XjzaRghszA3wzSrk5PXP2YlGumRt03UABccE2prSGoiWjsQUIkvWA+S4f05Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HpvFpLx9; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <31c3f774-edb7-420a-a6a8-3e21f2abd776@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759630388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OP9wXA53d6BP9LdL5Hoy01dmDI1cUKyIJEndcIwA2f0=;
	b=HpvFpLx9tFKGwu1dZrNOffzNFVUw/fe7sids+KZNIb5yFk2SsMGPgTqkHJnz9R+ktyx1gH
	b58wtfZKAc/08cvjc59ZftyVFiRs7q2iMCA6hZ5zuwburCYu75/klygAGUbZjlC7KfMWKf
	RQmVk/XCRnZoRZuQrEKilTbz8Xi7BGE=
Date: Sun, 5 Oct 2025 10:12:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 dev.jain@arm.com, hughd@google.com, ioworker0@gmail.com,
 kirill@shutemov.name, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <20251001085425.5iq2mgfom6sqkbbx@master>
 <1d09acbf-ccc9-4f06-9392-669c98e34661@linux.dev>
 <20251005010511.ysek2nqojebqngf3@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251005010511.ysek2nqojebqngf3@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/5 09:05, Wei Yang wrote:
> On Wed, Oct 01, 2025 at 06:05:57PM +0800, Lance Yang wrote:
>>
>>
>> On 2025/10/1 16:54, Wei Yang wrote:
>>> On Wed, Oct 01, 2025 at 11:22:51AM +0800, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> Currently, special non-swap entries (like migration, hwpoison, or PTE
>>>> markers) are not caught early in hpage_collapse_scan_pmd(), leading to
>>>> failures deep in the swap-in logic.
>>>>
>>>> hpage_collapse_scan_pmd()
>>>> `- collapse_huge_page()
>>>>       `- __collapse_huge_page_swapin() -> fails!
>>>>
>>>> As David suggested[1], this patch skips any such non-swap entries
>>>> early. If any one is found, the scan is aborted immediately with the
>>>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>>>> work.
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
>>>> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
>>>>
>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>> ---
>>>> v1 -> v2:
>>>> - Skip all non-present entries except swap entries (per David) thanks!
>>>> - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/
>>>>
>>>> mm/khugepaged.c | 32 ++++++++++++++++++--------------
>>>> 1 file changed, 18 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 7ab2d1a42df3..d0957648db19 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>>> 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>>> 	     _pte++, addr += PAGE_SIZE) {
>>>> 		pte_t pteval = ptep_get(_pte);
>>>> -		if (is_swap_pte(pteval)) {
>>>
>>> It looks is_swap_pte() is mis-leading?
>>
>> Hmm.. not to me, IMO. is_swap_pte() just means:
>>
>> !pte_none(pte) && !pte_present(pte)
>>
> 
> Maybe it has some reason.
> 
> I took another look into __collapse_huge_page_swapin(), which just check
> is_swap_pte() before do_swap_page().
> 
> We have filtered non-swap entries in hpage_collapse_scan_pmd(), but we drop
> mmap lock before isolation. This looks we may have a chance to get non-swap
> entry.

Thanks for pointing that out!

Yep, there is a theoretical window between dropping the mmap lock
after the initial scan and re-acquiring it for isolation.

> 
> Do you think it is reasonable to add a non_swap_entry() check before
> do_swap_page()?

However, that seems unlikely in practice. IMHO, the early check in
hpage_collapse_scan_pmd() is sufficient for now, so I'd prefer to
keep it as-is :)




Return-Path: <linux-kernel+bounces-858271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DDDBE98BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B06F5813F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3322D8795;
	Fri, 17 Oct 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HgsDgMKr"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99D3328F3
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713493; cv=none; b=HtqyCrJ+A/+2Y3kZYR588X0fDN5R8rSU+BGglVXYs17piJCppG9PA6iLAdsjKVsHBOGXWzK7F5f1GALc3wbvkf4CV95UtMKu46ya0HQGuNrupojQxMYXnTvQUcz49UXgGTrbIbeoR594Lncy2K9y7dHiwFZgbFAtmUovMwnGugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713493; c=relaxed/simple;
	bh=hraWcx9XM5C+NmD0sradBIZcS7r7jNi6BJAgJ8CCx/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwQuKGGPmb6+JztSIQuvAiIf3CyHuhTJ3A0occ1EyXTrE+On9lXmeSDhOlv9FjCKXGhbnIV8vH9AuPwQWS3CHlwKT+lyE7GbfEhVx8pnDjjzhDyXlk00ENYUEFINjjwNYbBSzncW1VBlVf0MHUuU9U9mzNYBhLrPYOU+mOX4sKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HgsDgMKr; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ab724372-8efa-4642-8240-2f28d090d1c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760713488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ipsUjbeu91dDs7Ml8KfMCH/cB+JE6gc+gafMQFlHgY=;
	b=HgsDgMKryhNnwMN/ITSI0mJHUPe1aoHFEettJVOvu5MMft480FW6TcOIQaa72BlvM81e4i
	BRsSKwH5txiZWj5M8cFMRqLtB0rcB4PJCSbMT6s6xtEvdawatH5R4wtdnpJiZ+qC5IIDJI
	GqkU/Enizl55v/oaRojGF1O2kM4n6ps=
Date: Fri, 17 Oct 2025 23:04:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: guard is_zero_pfn() calls
 with pte_present()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Wei Yang <richard.weiyang@gmail.com>
References: <20251017093847.36436-1-lance.yang@linux.dev>
 <1937040d-5e70-4d9a-b77a-261bf0f4994e@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <1937040d-5e70-4d9a-b77a-261bf0f4994e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/17 22:51, David Hildenbrand wrote:
> On 17.10.25 11:38, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> A non-present entry, like a swap PTE, contains completely different data
>> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
>> non-present entry, it will spit out a junk PFN.
>>
>> What if that junk PFN happens to match the zeropage's PFN by sheer
>> chance? While really unlikely, this would be really bad if it did.
>>
>> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
>> in khugepaged.c are properly guarded by a pte_present() check.
>>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> Applies against commit 0f22abd9096e in mm-new.
>>
>> v1 -> v2:
>>   - Collect Reviewed-by from Dev, Wei and Baolin - thanks!
>>   - Reduce a level of indentation (per Dev)
>>   - https://lore.kernel.org/linux-mm/20251016033643.10848-1- 
>> lance.yang@linux.dev/
>>
>>   mm/khugepaged.c | 29 ++++++++++++++++-------------
>>   1 file changed, 16 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index d635d821f611..648d9335de00 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t 
>> *_pte,
>>           pte_t pteval = ptep_get(_pte);
>>           unsigned long pfn;
>> -        if (pte_none(pteval))
>> +        if (!pte_present(pteval))
>>               continue;
> 
> 
> Isn't it rather that if we would ever get a !pte_none() && ! 
> pte_present() here, something would be deeply flawed?
> 
> I'd much rather spell that out and do here
> 
> VM_WARN_ON_ONCE(!pte_present(pteval));
> 
> keeping the original check.

Right, it's much better to be loud with a VM_WARN if we see
a weird PTE, as Dev also suggested :)

> 
> 
>>           pfn = pte_pfn(pteval);
>>           if (is_zero_pfn(pfn))
>> @@ -690,17 +690,18 @@ static void 
>> __collapse_huge_page_copy_succeeded(pte_t *pte,
>>            address += nr_ptes * PAGE_SIZE) {
>>           nr_ptes = 1;
>>           pteval = ptep_get(_pte);
>> -        if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> +        if (pte_none(pteval) ||
>> +            (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
> 
> This now seems to be a common pattern now :)
> 
> 
> Should we have a simple helper
> 
> static inline void pte_none_or_zero(pte_t pte)
> {
>      if (pte_none(pte))
>          return true;
>      return pte_present(pte) && is_zero_pfn(pte_pfn(pte)
> }
> 
> initially maybe local to this file?

And yeah, that logic is crying out for a new helper.

Thanks!



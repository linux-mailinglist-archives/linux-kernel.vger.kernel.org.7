Return-Path: <linux-kernel+bounces-856794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA83BE5195
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC33E58608A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4761519A6;
	Thu, 16 Oct 2025 18:47:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032C23B0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640442; cv=none; b=RcauSvkdcH9KRshsTLHlfROFu6+Mk2dSMwupAyY7omve/0/5+z/lnUZW3fFVm5eWEXXa9MSxyoRbrAxHhwbTedKZ8AMGqYJSoVQiphKVwCWhv32I/iMk/tllV3SY4mxmMbir4xXAnz321pBvORcU3IgerjNdoMbdYGg/ojzx2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640442; c=relaxed/simple;
	bh=ePExnfyRrFDVPrFHq+McVtgXlvaydmbVEEMYyG45JFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCAFkGiN8kD6XtVErfw3JNfqe0Saaq+Lmx/+RT/hFrNO7m4BQiWbS2JrdeQtOawcjYz2Oz3RUAG2ldIwzQnAt4e8w4jKI/GxfSPTruy9QHEkovii//oGVLCi62/Ed9CCgOEOYhvOOLQKf5hB/ghXWIHqPcTRnGAXnxiDY3fY45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F4F1688;
	Thu, 16 Oct 2025 11:47:12 -0700 (PDT)
Received: from [10.163.66.205] (unknown [10.163.66.205])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D55E3F738;
	Thu, 16 Oct 2025 11:47:17 -0700 (PDT)
Message-ID: <07a70cbf-dbb5-4444-8393-24c49e53a93f@arm.com>
Date: Fri, 17 Oct 2025 00:17:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: mm: make linear mapping permission update more
 robust for patial range
To: Yang Shi <yang@os.amperecomputing.com>, ryan.roberts@arm.com,
 cl@gentwo.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013232803.3065100-1-yang@os.amperecomputing.com>
 <20251013232803.3065100-2-yang@os.amperecomputing.com>
 <00bf0498-8f11-466e-9f2a-f7e656ecddf9@arm.com>
 <8943fe0e-0bf7-49a4-bf58-efe08bfd037d@os.amperecomputing.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <8943fe0e-0bf7-49a4-bf58-efe08bfd037d@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 17/10/25 12:15 am, Yang Shi wrote:
>
>
> On 10/14/25 11:46 PM, Dev Jain wrote:
>>
>> On 14/10/25 4:57 am, Yang Shi wrote:
>>> The commit fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when 
>>> changing
>>> permissions for vmalloc_huge mappings") made permission update for
>>> partial range more robust. But the linear mapping permission update
>>> still assumes update the whole range by iterating from the first page
>>> all the way to the last page of the area.
>>>
>>> Make it more robust by updating the linear mapping permission from the
>>> page mapped by start address, and update the number of numpages.
>>>
>>> Fixes: fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when 
>>> changing permissions for vmalloc_huge mappings")
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>   arch/arm64/mm/pageattr.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>> index 5135f2d66958..c21a2c319028 100644
>>> --- a/arch/arm64/mm/pageattr.c
>>> +++ b/arch/arm64/mm/pageattr.c
>>> @@ -148,7 +148,6 @@ static int change_memory_common(unsigned long 
>>> addr, int numpages,
>>>       unsigned long size = PAGE_SIZE * numpages;
>>>       unsigned long end = start + size;
>>>       struct vm_struct *area;
>>> -    int i;
>>>         if (!PAGE_ALIGNED(addr)) {
>>>           start &= PAGE_MASK;
>>> @@ -184,8 +183,9 @@ static int change_memory_common(unsigned long 
>>> addr, int numpages,
>>>        */
>>>       if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>>                   pgprot_val(clear_mask) == PTE_RDONLY)) {
>>> -        for (i = 0; i < area->nr_pages; i++) {
>>> - __change_memory_common((u64)page_address(area->pages[i]),
>>> +        unsigned long idx = (start - (unsigned long)area->addr) >> 
>>> PAGE_SHIFT;
>>> +        for (int i = 0; i < numpages; i++) {
>>> + __change_memory_common((u64)page_address(area->pages[idx++]),
>>>                              PAGE_SIZE, set_mask, clear_mask);
>>
>> Why not just use idx as the iterator in the for loop? Using i and 
>> then incrementing
>> idx is confusing.
>
> You meant something like:
>
> while (idx < idx + numpages)
>
> It is fine to me.

for loop is simpler :)


>
>>
>> As noted by Ryan, the fixes commit is wrong. The issues persists from 
>> commit c55191e.
>>
>> After fixing these:
>>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>
> Thank you.
>
> Yang
>
>>
>>>           }
>>>       }
>


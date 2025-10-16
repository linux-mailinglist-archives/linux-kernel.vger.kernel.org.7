Return-Path: <linux-kernel+bounces-855573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D55BE1AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C4684F24B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0C7256C71;
	Thu, 16 Oct 2025 06:15:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA8145B3E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595311; cv=none; b=ou74WbiDHaQOzhVgWrjXZOInZS/9BR3L3CmaUUvWI6T7cPkH8nVLwAFkg3NqhBX7vL8Zs+4nVOopEFskiC6R6ktxH/etI1P7Gcm0cTyQ1aROs27AIw9K4/+VtsoQLLneAqw+WjEdOukS65P9GgFd5Uoi4/Zdd5I2tKVBH4t8/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595311; c=relaxed/simple;
	bh=+TT0TfrqkTBN3bSd0lLTo1tVHO96zD6LzEW5XsjCrV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cbylxr2w7PAKNmQoEqS1m9OMDCsuzhlTBs/EyzMPhceAh8Fo9lt/Yd8RO6q68qhxLfis/PpCpcUNtTzw7veA3obGOiW6hoZUPUNx64R5M5SAn0SLvrppbB49yMnfd/TCOqO+nwnTTxRHtX6BZR9RA0NxDTx6J0XtRVlt6JOE1CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B764A1688;
	Wed, 15 Oct 2025 23:15:00 -0700 (PDT)
Received: from [10.163.68.150] (unknown [10.163.68.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD8CB3F738;
	Wed, 15 Oct 2025 23:15:03 -0700 (PDT)
Message-ID: <debdccdd-1a4a-4039-bdc3-64b68525d03c@arm.com>
Date: Thu, 16 Oct 2025 11:45:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with
 pte_present()
To: Lance Yang <lance.yang@linux.dev>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, david@redhat.com
References: <20251016033643.10848-1-lance.yang@linux.dev>
 <ab4e7044-c285-426e-bf9c-fa06a0f47ae9@arm.com>
 <d5d2fe20-9d63-4304-8b36-9708309791ea@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <d5d2fe20-9d63-4304-8b36-9708309791ea@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 16/10/25 11:29 am, Lance Yang wrote:
>
>
> On 2025/10/16 13:34, Dev Jain wrote:
>>
>> On 16/10/25 9:06 am, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> A non-present entry, like a swap PTE, contains completely different 
>>> data
>>> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
>>> non-present entry, it will spit out a junk PFN.
>>>
>>> What if that junk PFN happens to match the zeropage's PFN by sheer
>>> chance? While really unlikely, this would be really bad if it did.
>>>
>>> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
>>> in khugepaged.c are properly guarded by a pte_present() check.
>>>
>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>
>> Thanks, I missed this.
>
> Me too ...
>
>>
>>>   mm/khugepaged.c | 13 ++++++++-----
>>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index d635d821f611..0341c3d13e9e 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t 
>>> *_pte,
>>>           pte_t pteval = ptep_get(_pte);
>>>           unsigned long pfn;
>>> -        if (pte_none(pteval))
>>> +        if (!pte_present(pteval))
>>
>> There should be no chance that we end up with a pteval which is not 
>> none *and*
>> not present, if you look at the callers of release_pte_pages. So 
>> perhaps we
>> should keep this either the same, or, after "if(pte_none(pteval))", do a
>> WARN_ON_ONCE(!pte_present(pteval))?
>
> Good catch! Yeah, but I'd rather not rely on the callers ...
>
> Wouldn't it just be simpler and safer to always have is_zero_pfn() 
> guarded
> by pte_present()?
>
> I don't have a strong opinon here, though ;p

Yeah same, I think we can leave it to what you have done.


>
> Dev, Thanks!
>


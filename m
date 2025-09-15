Return-Path: <linux-kernel+bounces-816085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82183B56F44
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2D3B5362
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1273422422E;
	Mon, 15 Sep 2025 04:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uER8sLex"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC217BEBF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757910290; cv=none; b=USTgJLE3C04FBPKD+06nlN6WKx0ib+wgdMsUqzZ1GtHjpRsyOdLIpeg/W+M38dRSTQEb7WtXbUY3S4Fa851CYb41368BJsd18tfOB8l/69H4+aDw9f0MTHqm0oXPEMfjGxsxfLnA1PsKzKyUijUYroMf5N2aSDq08gLSOMgPRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757910290; c=relaxed/simple;
	bh=PASy16iu6y2521ZrmfszjgkkjV83uibEcXOvOHT3GS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwQpknrluM3oIPIniwX4ePI3MQDnh7Wp/KB5ocTfR3atZq5qmzgwTTH8itYghvXOTQH5w1odIaU5VR+7/Z2+LcW6D3dN/Rj7qhme9vp1hpeTt1ajbyzbCbCYllphO+z4krKxxTjglfFq8l19fykVRMVSxzzSxtwUqW6iGi91Qi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uER8sLex; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <434ecc5a-3aec-4381-8477-8a7d09220051@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757910284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehnEhT9IwpoRpyq7W3B9rNarRzhELO0M7YbeeCPAQMM=;
	b=uER8sLexksdHO9XbHYOptdkH/NAAPFYOzOUJVgerwDt80blqcBLHvrqWNDz7+G4w8LzTlA
	GC+tt+uJ0Ivobr6/GHjNDSAKDmfu6l3H7x9psd+Z+emAk+uqhUL/8aSBrVIEJqT0MZ1zCL
	nTBGcgAtpfaGLLHgFP2UZ8NknmN9Jyk=
Date: Mon, 15 Sep 2025 12:24:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 2/3] mm: clean up and expose is_guard_pte_marker()
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, lorenzo.stoakes@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Kairui Song <kasong@tencent.com>, akpm@linux-foundation.org, david@redhat.com
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-3-lance.yang@linux.dev>
 <e2c6f52b-23c3-40ef-99d3-325a0a3cb4d4@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <e2c6f52b-23c3-40ef-99d3-325a0a3cb4d4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2025/9/15 00:38, Dev Jain wrote:
> 
> On 14/09/25 8:05 pm, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> is_guard_pte_marker() performs a redundant check because it calls both
>> is_pte_marker() and is_guard_swp_entry(), both of which internally check
>> for a PTE marker.
>>
>> is_guard_pte_marker()
>>   |- is_pte_marker()
>>   |   `- is_pte_marker_entry()  // First check
>>   `- is_guard_swp_entry()
>>       `- is_pte_marker_entry()  // Second, redundant check
>>
>> While a modern compiler could likely optimize this away, let's have clean
>> code and not rely on it ;)
>>
>> Also, make it available for hugepage collapsing code.
> 
> The movement of the code should be merged with the next patch.

Thanks for the suggestion ;)

I'd prefer to keep them as separate patches to make them easier to review,
if that's okay.

Cheers,
Lance

> 
>>
>> Cc: Kairui Song <kasong@tencent.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   include/linux/swapops.h | 6 ++++++
>>   mm/madvise.c            | 6 ------
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
>> index 59c5889a4d54..7f5684fa043b 100644
>> --- a/include/linux/swapops.h
>> +++ b/include/linux/swapops.h
>> @@ -469,6 +469,12 @@ static inline int is_guard_swp_entry(swp_entry_t 
>> entry)
>>           (pte_marker_get(entry) & PTE_MARKER_GUARD);
>>   }
>> +static inline bool is_guard_pte_marker(pte_t ptent)
>> +{
>> +    return is_swap_pte(ptent) &&
>> +           is_guard_swp_entry(pte_to_swp_entry(ptent));
>> +}
>> +
>>   /*
>>    * This is a special version to check pte_none() just to cover the 
>> case when
>>    * the pte is a pte marker.  It existed because in many cases the 
>> pte marker
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 35ed4ab0d7c5..bd46e6788fac 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -1069,12 +1069,6 @@ static bool is_valid_guard_vma(struct 
>> vm_area_struct *vma, bool allow_locked)
>>       return !(vma->vm_flags & disallowed);
>>   }
>> -static bool is_guard_pte_marker(pte_t ptent)
>> -{
>> -    return is_pte_marker(ptent) &&
>> -        is_guard_swp_entry(pte_to_swp_entry(ptent));
>> -}
>> -
>>   static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
>>                      unsigned long next, struct mm_walk *walk)
>>   {



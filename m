Return-Path: <linux-kernel+bounces-826726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFF3B8F31B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D15484E113D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3578248F72;
	Mon, 22 Sep 2025 06:50:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C12248B0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523831; cv=none; b=eLEQ0ItColAA7g7SBX0XFXnJPchCpUDq/B5DrSxJ0ZV5CinN8MteQXe7g1BrE2CZuYl5qumTp+rmkjRom64444cmZZ9/4cxVNElf2czrRpS/bc1bWzbPxxqZkuxtGVMuWkzT836EGOpY4nTWOR/WXEEylToB2zbMX+z8Uh5hq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523831; c=relaxed/simple;
	bh=wo21/ZqzXWaKTFPeQOms5Di/5NmSA3utJnAp49gdb78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFbyu/SHMYiLrC3ArQK12n8fEgqPXoQ5GlwGcLYCC/CHf2rLe+sExBlwyAl9Ckr+kARgL4GOcYI2BfBRhOH8MkAzOtXo/38gJnSUA7Ve60CRn4Zvy4OTWciiXJkI0N++VnYNaNTjGmiCu3qaU0nFj4shmxnuhi8D4Rb0umswem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3FAB1515;
	Sun, 21 Sep 2025 23:50:20 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D0783F66E;
	Sun, 21 Sep 2025 23:50:27 -0700 (PDT)
Message-ID: <c468ffc7-bf4f-4b0e-b02f-f926f1c2a836@arm.com>
Date: Mon, 22 Sep 2025 12:20:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove PMD alignment constraint in execmem_vmalloc()
To: Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org
Cc: rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250918093453.75676-1-dev.jain@arm.com>
 <2a7e000c-f075-487e-a750-1fa8d29adfe8@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <2a7e000c-f075-487e-a750-1fa8d29adfe8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 22/09/25 11:32 am, Anshuman Khandual wrote:
>
> On 18/09/25 3:04 PM, Dev Jain wrote:
>> When using vmalloc with VM_ALLOW_HUGE_VMAP flag, it will set the alignment
>> to PMD_SIZE internally, if it deems huge mappings to be eligible.
>> Therefore, setting the alignment in execmem_vmalloc is redundant. Apart
>> from this, it also reduces the probability of allocation in case vmalloc
>> fails to allocate hugepages - in the fallback case, vmalloc tries to use
>> the original alignment and allocate basepages, which unfortunately will
>> again be PMD_SIZE passed over from execmem_vmalloc, thus constraining
>> the search for a free space in vmalloc region.
>>
>> Therefore, remove this constraint.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> mm-selftests pass, but I am not sure if they touch execmem code, and I
>> have no experience with this code.
>>
>>   mm/execmem.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/mm/execmem.c b/mm/execmem.c
>> index 0822305413ec..810a4ba9c924 100644
>> --- a/mm/execmem.c
>> +++ b/mm/execmem.c
>> @@ -38,9 +38,6 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
>>   	if (kasan)
>>   		vm_flags |= VM_DEFER_KMEMLEAK;
>>   
>> -	if (vm_flags & VM_ALLOW_HUGE_VMAP)
>> -		align = PMD_SIZE;
>> -
> So if the above assignment is getting dropped here, probably the local
> variable 'align' could be dropped as well and range->alignment be used
> directly instead ?

Sure, but that isn't a big deal. Replacing with range->aligment will
push the arguments declaration into an extra line in __vmalloc_node_range.
So will prefer not respinning for this triviality, this has already
been pulled into mm-new :)

>>   	p = __vmalloc_node_range(size, align, start, end, gfp_flags,
>>   				 pgprot, vm_flags, NUMA_NO_NODE,
>>   				 __builtin_return_address(0));


Return-Path: <linux-kernel+bounces-848075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE87BCC70D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2716E19E69CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F52C326B;
	Fri, 10 Oct 2025 09:52:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6902ED15A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089946; cv=none; b=eUALdW0cylitmrkkoT6DhTVxJ9gYz3uXgrIs27gpxSYlIN9sn5nx/WJ08wabWQRc6N96A3Bx4pGuyJ9NiI2YVZbAGCRldgt2nQ+PP/kCfjCoRXnQeGr93tnJP6mSftn63YRCQH3gWsn3ktEFD+EZ9qBihA+3QZio5xaEMSCZYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089946; c=relaxed/simple;
	bh=Gg6cDpFQ+vhWrpSqPmeYkh5BxuwaksFefZzEhqvYhss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfUP5nAvgOk5R6bwus/CrZE1WewwXlIuO3nhovROlaY/05IabpXVZ2VLC5qsK9S5oheeY+KE0Caw4lBnF4TTq0PK1hT09J1OPOcfdrgpWMa3gZrWAeAdoKne4wj0F6yLBV3q9KSCpLkDk92aqYiWho38apwMhAEZ/jJ4O1fWwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FF9C1595;
	Fri, 10 Oct 2025 02:52:15 -0700 (PDT)
Received: from [10.57.81.94] (unknown [10.57.81.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 014A93F66E;
	Fri, 10 Oct 2025 02:52:20 -0700 (PDT)
Message-ID: <6f40ee64-6ef6-4741-8319-ae330df881a9@arm.com>
Date: Fri, 10 Oct 2025 10:52:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: pageattr: Explicitly bail out when changing
 permissions for vmalloc_huge mappings
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, Dev Jain <dev.jain@arm.com>,
 catalin.marinas@arm.com, will@kernel.org
Cc: gshan@redhat.com, rppt@kernel.org, steven.price@arm.com,
 suzuki.poulose@arm.com, tianyaxiong@kylinos.cn, ardb@kernel.org,
 david@redhat.com, urezki@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250328062103.79462-1-dev.jain@arm.com>
 <831e9e0c-a61b-40d8-a8d2-747b760ba6b3@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <831e9e0c-a61b-40d8-a8d2-747b760ba6b3@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yang,


On 09/10/2025 21:26, Yang Shi wrote:
> 
> 
> On 3/27/25 11:21 PM, Dev Jain wrote:
>> arm64 uses apply_to_page_range to change permissions for kernel VA mappings,
>> which does not support changing permissions for leaf mappings. This function
>> will change permissions until it encounters a leaf mapping, and will bail
>> out. To avoid this partial change, explicitly disallow changing permissions
>> for VM_ALLOW_HUGE_VMAP mappings.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   arch/arm64/mm/pageattr.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 39fd1f7ff02a..8337c88eec69 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -96,7 +96,7 @@ static int change_memory_common(unsigned long addr, int
>> numpages,
>>        * we are operating on does not result in such splitting.
>>        *
>>        * Let's restrict ourselves to mappings created by vmalloc (or vmap).
>> -     * Those are guaranteed to consist entirely of page mappings, and
>> +     * Disallow VM_ALLOW_HUGE_VMAP vmalloc mappings so that
>>        * splitting is never needed.
>>        *
>>        * So check whether the [addr, addr + size) interval is entirely
>> @@ -105,7 +105,7 @@ static int change_memory_common(unsigned long addr, int
>> numpages,
>>       area = find_vm_area((void *)addr);
>>       if (!area ||
>>           end > (unsigned long)kasan_reset_tag(area->addr) + area->size ||
>> -        !(area->flags & VM_ALLOC))
>> +        ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
>>           return -EINVAL;
> 
> I happened to find this patch when I was looking into fixing "splitting is never
> needed" comment to reflect the latest change with BBML2_NOABORT and tried to
> relax this restriction. I agree with the justification for this patch to make
> the code more robust for permission update on partial range. But the following
> linear mapping permission update code seems still assume partial range update
> never happens:
> 
> for (i = 0; i < area->nr_pages; i++) {
> 
> It iterates all pages for this vm area from the first page then update their
> permissions. So I think we should do the below to make it more robust to partial
> range update like this patch did:

Ahh so the issue is that [addr, addr + numpages * PAGE_SIZE) may only cover a
portion of the vm area? But the current code updates the permissions for the
whole vm area? Ouch...

> 
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -185,8 +185,9 @@ static int change_memory_common(unsigned long addr, int
> numpages,
>          */
>         if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>                             pgprot_val(clear_mask) == PTE_RDONLY)) {
> -               for (i = 0; i < area->nr_pages; i++) {
> -  __change_memory_common((u64)page_address(area->pages[i]),
> +               unsigned long idx = (start - (unsigned long)area->addr) >>
> PAGE_SHIFT;
> +               for (i = 0; i < numpages; i++) {
> +  __change_memory_common((u64)page_address(area->pages[idx++]),
>                                                PAGE_SIZE, set_mask, clear_mask);
>                 }
>         }
> 
> Just build tested. Does it look reasonable?

Yes that looks correct to me! Will you submit a patch?

Thanks,
Ryan

> 
> Thanks,
> Yang
> 
> 
>>         if (!numpages)
> 



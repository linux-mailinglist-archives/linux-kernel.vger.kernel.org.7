Return-Path: <linux-kernel+bounces-668047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D2AC8D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68E63A923F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C6822A1F1;
	Fri, 30 May 2025 11:50:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1641E21D3EC
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605847; cv=none; b=Kda7i0s8klxW2Rs8Iq985gfqNzagsclAjAAE7ArIdgMHq4o9VMEUgltWwIXPYG6UgnO8bhuu23pc6BtPwzXo1nuD+5sDWNcR5bG2b+Hfe/XyB8Xo0ukVBHWKZrKFfT2aBiWXVUIEhC3c32mngBBnauE3cpolFZlTrTgYHTfhzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605847; c=relaxed/simple;
	bh=8J7MijuSmv8BbECeoJk6Iux4Xa8Uk9BEZ3d9RPs87d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2QuP9OHzJTsFoFjKc5KHkLRRj+fKpwCCgneH3oqVPNKnjduRpcTX5bErmAC8HE0+BCVUr0a4vx93tQ7gEF4GjcUDDg83H+OwEiV1hJivXlsGqb2yKJlMz+V2lynHzl9wH+cyw4RG/akrq4TgmgJI11dOo7+TP/Ikk2cj04hAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C679A16F2;
	Fri, 30 May 2025 04:50:27 -0700 (PDT)
Received: from [10.57.95.14] (unknown [10.57.95.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EB2C3F5A1;
	Fri, 30 May 2025 04:50:42 -0700 (PDT)
Message-ID: <4202a03d-dacd-429c-91e6-81a5d05726a4@arm.com>
Date: Fri, 30 May 2025 12:50:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Enable vmalloc-huge with ptdump
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 david@redhat.com
References: <20250530082021.18182-1-dev.jain@arm.com>
 <d2b63b97-232e-4d2e-816b-71fd5b0ffcfa@arm.com>
 <832e84a9-4303-4e21-a88b-94395898fa3e@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <832e84a9-4303-4e21-a88b-94395898fa3e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/05/2025 10:14, Dev Jain wrote:
> 
> On 30/05/25 2:10 pm, Ryan Roberts wrote:
>> On 30/05/2025 09:20, Dev Jain wrote:
>>> arm64 disables vmalloc-huge when kernel page table dumping is enabled,
>>> because an intermediate table may be removed, potentially causing the
>>> ptdump code to dereference an invalid address. We want to be able to
>>> analyze block vs page mappings for kernel mappings with ptdump, so to
>>> enable vmalloc-huge with ptdump, synchronize between page table removal in
>>> pmd_free_pte_page()/pud_free_pmd_page() and ptdump pagetable walking. We
>>> use mmap_read_lock and not write lock because we don't need to synchronize
>>> between two different vm_structs; two vmalloc objects running this same
>>> code path will point to different page tables, hence there is no race.
> 
> My "correction" from race->no problem was incorrect after all :) There will
> be no race too since the vm_struct object has exclusive access to whatever
> table it is clearing.
> 
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   arch/arm64/include/asm/vmalloc.h | 6 ++----
>>>   arch/arm64/mm/mmu.c              | 7 +++++++
>>>   2 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
>>> index 38fafffe699f..28b7173d8693 100644
>>> --- a/arch/arm64/include/asm/vmalloc.h
>>> +++ b/arch/arm64/include/asm/vmalloc.h
>>> @@ -12,15 +12,13 @@ static inline bool arch_vmap_pud_supported(pgprot_t prot)
>>>       /*
>>>        * SW table walks can't handle removal of intermediate entries.
>>>        */
>>> -    return pud_sect_supported() &&
>>> -           !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>>> +    return pud_sect_supported();
>>>   }
>>>     #define arch_vmap_pmd_supported arch_vmap_pmd_supported
>>>   static inline bool arch_vmap_pmd_supported(pgprot_t prot)
>>>   {
>>> -    /* See arch_vmap_pud_supported() */
>>> -    return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>>> +    return true;
>>>   }
>>>     #endif
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index ea6695d53fb9..798cebd9e147 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -1261,7 +1261,11 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>>>       }
>>>         table = pte_offset_kernel(pmdp, addr);
>>> +
>>> +    /* Synchronize against ptdump_walk_pgd() */
>>> +    mmap_read_lock(&init_mm);
>>>       pmd_clear(pmdp);
>>> +    mmap_read_unlock(&init_mm);
>> So this works because ptdump_walk_pgd() takes the write_lock (which is mutually
>> exclusive with any read_lock holders) for the duration of the table walk, so it
>> will either consistently see the pgtables before or after this removal. It will
>> never disappear during the walk, correct?
>>
>> I guess there is a risk of this showing up as contention with other init_mm
>> write_lock holders. But I expect that pmd_free_pte_page()/pud_free_pmd_page()
>> are called sufficiently rarely that the risk is very small. Let's fix any perf
>> problem if/when we see it.
> 
> We can avoid all of that by my initial approach - to wrap the lock around
> CONFIG_PTDUMP_DEBUGFS.
> I don't have a strong opinion, just putting it out there.

(I wrote then failed to send earlier):

It's ugly though. Personally I'd prefer to keep it simple unless we have clear
evidence that its needed. I was just laying out my justification for not needing
to doing the conditional wrapping in this comment.

> 
>>
>>>       __flush_tlb_kernel_pgtable(addr);
>> And the tlbi doesn't need to be serialized because there is no security issue.
>> The walker can be trusted to only dereference memory that it sees as it walks
>> the pgtable (obviously).
>>
>>>       pte_free_kernel(NULL, table);
>>>       return 1;
>>> @@ -1289,7 +1293,10 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>>           pmd_free_pte_page(pmdp, next);
>>>       } while (pmdp++, next += PMD_SIZE, next != end);
>>>   +    /* Synchronize against ptdump_walk_pgd() */
>>> +    mmap_read_lock(&init_mm);
>>>       pud_clear(pudp);
>>> +    mmap_read_unlock(&init_mm);
>> Hmm, so pud_free_pmd_page() is now going to cause us to acquire and release the
>> (upto) lock 513 times (for a 4K kernel). I wonder if there is an argument for
>> clearing the pud first (under the lock), then the pmds can all be cleared
>> without a lock, since the walker won't be able to see the pmds once the pud is
>> cleared.
> 
> Yes, we can isolate the PMD table in case the caller of pmd_free_pte_page is
> pud_free_pmd_page. In this case, vm_struct_1 has exclusive access to the entire
> pmd page, hence no race will occur. But, in case of vmap_try_huge_pmd() being the
> caller, we cannot drop the locks around pmd_free_pte_page. So we can have something
> like
> 
> #ifdef CONFIG_PTDUMP_DEBUGFS
> static inline void ptdump_synchronize_lock(bool flag)
> {
>     if (flag)
>         mmap_read_lock(&init_mm);
> }
> 
> and pass false when the caller is pud_free_pmd_page.
> 
>>
>> Thanks,
>> Ryan
>>
>>>       __flush_tlb_kernel_pgtable(addr);
>>>       pmd_free(NULL, table);
>>>       return 1;



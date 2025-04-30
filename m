Return-Path: <linux-kernel+bounces-626436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207ECAA4324
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 08:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F236A9A7EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 06:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559661E834F;
	Wed, 30 Apr 2025 06:33:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E571E8338
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994780; cv=none; b=fLxk5eAb7UUUHGv/p+B0RCttrW0b1Gh7GFl89xJjcYhQmkGAwO8Aad3NxMZ4rPEa5bLBOB7OMBAsUNrfc0vJlWDdulcHMj5Qufc9IX6BuaK4bS2rD90hktciQC5mBayHmYNMcKOqiH0upBXL0j47PpUicLA1Ab9eonqWSJfCRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994780; c=relaxed/simple;
	bh=b0012qMerLBS1x5+/EtWqZqKiYMV64ZRLDSQkI0kDVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6aiwGXiWKi6EIapYfh0AdxaDt3KFUMW+cq8TTznk/gX2EwU2pDDGBtJp9CPOylc+dhc5KTGznDCMk+wiwGIupDYuMPZbf25NgFRDjWCy3V11HJ0Jnp44vdGZv7GKJVwKQMmsP1tpowHbxqkN0/XPBRhb7r+HDNdSc/MK6xWuF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45A1D12FC;
	Tue, 29 Apr 2025 23:32:51 -0700 (PDT)
Received: from [10.163.79.251] (unknown [10.163.79.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E19923F66E;
	Tue, 29 Apr 2025 23:32:47 -0700 (PDT)
Message-ID: <9856f39d-d9d8-45c1-8e5a-514d21a86d51@arm.com>
Date: Wed, 30 Apr 2025 12:02:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm64: Add batched version of
 ptep_modify_prot_start
To: Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, david@redhat.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
 will@kernel.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 vbabka@suse.cz, jannh@google.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 namit@vmware.com, hughd@google.com, yang@os.amperecomputing.com,
 ziy@nvidia.com
References: <20250429052336.18912-1-dev.jain@arm.com>
 <20250429052336.18912-5-dev.jain@arm.com>
 <e2c10562-2504-434f-9239-32d67955a9af@arm.com>
 <5eebef24-6c98-4407-a4f1-5a97f08b76a4@arm.com>
 <1c0fd43d-8de9-4bd8-af05-83a4d9c8d9e6@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <1c0fd43d-8de9-4bd8-af05-83a4d9c8d9e6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/04/25 11:44 am, Anshuman Khandual wrote:
> 
> 
> On 4/30/25 11:19, Dev Jain wrote:
>>
>>
>> On 30/04/25 11:13 am, Anshuman Khandual wrote:
>>> On 4/29/25 10:53, Dev Jain wrote:
>>>> Override the generic definition to use get_and_clear_full_ptes(), so that
>>>> we do a TLBI possibly only on the "contpte-edges" of the large PTE block,
>>>> instead of doing it for every contpte block, which happens for ptep_get_and_clear().
>>>
>>> Could you please explain what does "contpte-edges" really signify in the
>>> context of large PTE blocks ? Also how TLBI operation only on these edges
>>> will never run into the risk of missing TLB invalidation of some other
>>> mapped areas ?
>>
>> We are doing a TLBI over the whole range already, in the mprotect code:
>> see tlb_flush_pte_range. What the arm64 internal API does, irrespective of the caller, is to do a TLBI for every contpte block in case of unfolding. We don't need that for the intermediate blocks because the caller does that. We do need a TLBI for the start and end contpte block,
>> because in case the range we are invalidating partially covers them, then the caller will not do a TLBI for the non-overlapped PTEs of the block.
> 
> But is not splitting the TLBI flush responsibility between the callers
> (intermediate blocks) and the platform API (contpte-edges) - some what
> problematic from a semantics perspective, and will be more susceptible
> for missing TLB flushes etc ?

I seem to agree that this is a semantic problem. Although, we won't ever 
miss a TLB flush - we will only have extras. It is the responsibility of 
the caller to do the TLBI, the platform API is only checking whether we 
need some more TLBIs.

> 
>> I'll explain some more in the changelog next version.
>>
>>>
>>>>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>>    arch/arm64/include/asm/pgtable.h |  5 +++++
>>>>    arch/arm64/mm/mmu.c              | 12 +++++++++---
>>>>    include/linux/pgtable.h          |  4 ++++
>>>>    mm/pgtable-generic.c             | 16 +++++++++++-----
>>>>    4 files changed, 29 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>> index 2a77f11b78d5..8872ea5f0642 100644
>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>> @@ -1553,6 +1553,11 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
>>>>                        unsigned long addr, pte_t *ptep,
>>>>                        pte_t old_pte, pte_t new_pte);
>>>>    +#define modify_prot_start_ptes modify_prot_start_ptes
>>>> +extern pte_t modify_prot_start_ptes(struct vm_area_struct *vma,
>>>> +                    unsigned long addr, pte_t *ptep,
>>>> +                    unsigned int nr);
>>>> +
>>>>    #ifdef CONFIG_ARM64_CONTPTE
>>>>      /*
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index 8fcf59ba39db..fe60be8774f4 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -1523,7 +1523,8 @@ static int __init prevent_bootmem_remove_init(void)
>>>>    early_initcall(prevent_bootmem_remove_init);
>>>>    #endif
>>>>    -pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>>>> +pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long addr,
>>>> +                 pte_t *ptep, unsigned int nr)
>>>>    {
>>>>        if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
>>>>            /*
>>>> @@ -1532,9 +1533,14 @@ pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte
>>>>             * in cases where cpu is affected with errata #2645198.
>>>>             */
>>>>            if (pte_user_exec(ptep_get(ptep)))
>>>> -            return ptep_clear_flush(vma, addr, ptep);
>>>> +            return clear_flush_ptes(vma, addr, ptep, nr);
>>>>        }
>>>> -    return ptep_get_and_clear(vma->vm_mm, addr, ptep);
>>>> +    return get_and_clear_full_ptes(vma->vm_mm, addr, ptep, nr, 0);
>>>> +}
>>>> +
>>>> +pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>>>> +{
>>>> +    return modify_prot_start_ptes(vma, addr, ptep, 1);
>>>>    }
>>>>      void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index ed287289335f..10cdb87ccecf 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -828,6 +828,10 @@ extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
>>>>                      pte_t *ptep);
>>>>    #endif
>>>>    +extern pte_t clear_flush_ptes(struct vm_area_struct *vma,
>>>> +                  unsigned long address,
>>>> +                  pte_t *ptep, unsigned int nr);
>>>> +
>>>>    #ifndef __HAVE_ARCH_PMDP_HUGE_CLEAR_FLUSH
>>>>    extern pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma,
>>>>                      unsigned long address,
>>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>>> index 5a882f2b10f9..e238f88c3cac 100644
>>>> --- a/mm/pgtable-generic.c
>>>> +++ b/mm/pgtable-generic.c
>>>> @@ -90,17 +90,23 @@ int ptep_clear_flush_young(struct vm_area_struct *vma,
>>>>    }
>>>>    #endif
>>>>    -#ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
>>>> -pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
>>>> -               pte_t *ptep)
>>>> +pte_t clear_flush_ptes(struct vm_area_struct *vma, unsigned long address,
>>>> +               pte_t *ptep, unsigned int nr)
>>>>    {
>>>>        struct mm_struct *mm = (vma)->vm_mm;
>>>>        pte_t pte;
>>>> -    pte = ptep_get_and_clear(mm, address, ptep);
>>>> +    pte = get_and_clear_full_ptes(mm, address, ptep, nr, 0);
>>>>        if (pte_accessible(mm, pte))
>>>> -        flush_tlb_page(vma, address);
>>>> +        flush_tlb_range(vma, address, address + nr * PAGE_SIZE);
>>>>        return pte;
>>>>    }
>>>> +
>>>> +#ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
>>>> +pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
>>>> +               pte_t *ptep)
>>>> +{
>>>> +    return clear_flush_ptes(vma, address, ptep, 1);
>>>> +}
>>>>    #endif
>>>>      #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>
> 



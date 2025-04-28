Return-Path: <linux-kernel+bounces-623153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E6AA9F191
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 14:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A88F17AE19
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030CC267B67;
	Mon, 28 Apr 2025 12:59:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296D8836
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845175; cv=none; b=oqN+FXQzJHmfU2xTxf5/AfkfTS1B2OxdTrGiQGkonJdzTfXQIH5t57SKQpKjozcnj7P4s9KcH5jEAT85neBi9xNIly0R5dFP/eyL9t3I+c02C37h+gn/SstVuIPa17EsmbEhEyYlG0lt94tD9GrMrj3FiLX9c7i9lUaW73JhjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845175; c=relaxed/simple;
	bh=0GQvU8kdMNgMQU00RZEy0992u3ZkS1YUzOHK87urxg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGJD1ahtDUxuaFvNlMr8YNXYLV3qa5gYotbv5jj9WZNtfek+IE2igOg/ndwS01I/9vdceudWbjHzlLBTOCJGkwwBIbHj6VhD/F7muZC5f0CMBeeYxG32NtXXRsCsgwHXW/PT2epxdcPh7q624xrM5BPzgn9JlMj2+94j/DvRsZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 651F21516;
	Mon, 28 Apr 2025 05:59:26 -0700 (PDT)
Received: from [10.163.78.210] (unknown [10.163.78.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B9353F673;
	Mon, 28 Apr 2025 05:59:24 -0700 (PDT)
Message-ID: <083865e8-572b-41b2-9221-3cee01349fab@arm.com>
Date: Mon, 28 Apr 2025 18:29:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] mm: Batch around can_change_pte_writable()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, david@redhat.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
 will@kernel.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
 peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
 baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, namit@vmware.com, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250428120414.12101-1-dev.jain@arm.com>
 <20250428120414.12101-7-dev.jain@arm.com>
 <edf768ec-e874-4ca6-9fd7-b94ccc1c1059@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <edf768ec-e874-4ca6-9fd7-b94ccc1c1059@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/04/25 6:20 pm, Lance Yang wrote:
> Hey Dev,
> 
> On 2025/4/28 20:04, Dev Jain wrote:
>> In preparation for patch 7, we need to properly batch around
>> can_change_pte_writable(). We batch around pte_needs_soft_dirty_wp() by
>> the corresponding fpb flag, we batch around the page-anon exclusive check
>> using folio_maybe_mapped_shared(); modify_prot_start_ptes() collects the
>> dirty and access bits across the batch, therefore batching across
>> pte_dirty(): this is correct since the dirty bit on the PTE really
>> is just an indication that the folio got written to, so even if
>> the PTE is not actually dirty (but one of the PTEs in the batch is),
>> the wp-fault optimization can be made.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   include/linux/mm.h | 4 ++--
>>   mm/gup.c           | 2 +-
>>   mm/huge_memory.c   | 4 ++--
>>   mm/memory.c        | 6 +++---
>>   mm/mprotect.c      | 9 ++++++---
>>   5 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 5eb0d77c4438..ffa02e15863f 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2710,8 +2710,8 @@ int get_cmdline(struct task_struct *task, char 
>> *buffer, int buflen);
>>   #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
>>                           MM_CP_UFFD_WP_RESOLVE)
>> -bool can_change_pte_writable(struct vm_area_struct *vma, unsigned 
>> long addr,
>> -                 pte_t pte);
>> +bool can_change_ptes_writable(struct vm_area_struct *vma, unsigned 
>> long addr,
>> +                 pte_t pte, struct folio *folio, unsigned int nr);
>>   extern long change_protection(struct mmu_gather *tlb,
>>                     struct vm_area_struct *vma, unsigned long start,
>>                     unsigned long end, unsigned long cp_flags);
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 84461d384ae2..6a605fc5f2cb 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -614,7 +614,7 @@ static inline bool can_follow_write_common(struct 
>> page *page,
>>           return false;
>>       /*
>> -     * See can_change_pte_writable(): we broke COW and could map the 
>> page
>> +     * See can_change_ptes_writable(): we broke COW and could map the 
>> page
>>        * writable if we have an exclusive anonymous page ...
>>        */
>>       return page && PageAnon(page) && PageAnonExclusive(page);
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 28c87e0e036f..e5496c0d9e7e 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2032,12 +2032,12 @@ static inline bool 
>> can_change_pmd_writable(struct vm_area_struct *vma,
>>           return false;
>>       if (!(vma->vm_flags & VM_SHARED)) {
>> -        /* See can_change_pte_writable(). */
>> +        /* See can_change_ptes_writable(). */
>>           page = vm_normal_page_pmd(vma, addr, pmd);
>>           return page && PageAnon(page) && PageAnonExclusive(page);
>>       }
>> -    /* See can_change_pte_writable(). */
>> +    /* See can_change_ptes_writable(). */
>>       return pmd_dirty(pmd);
>>   }
>> diff --git a/mm/memory.c b/mm/memory.c
>> index b9e8443aaa86..b1fda3de8d27 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -750,7 +750,7 @@ static void restore_exclusive_pte(struct 
>> vm_area_struct *vma,
>>           pte = pte_mkuffd_wp(pte);
>>       if ((vma->vm_flags & VM_WRITE) &&
>> -        can_change_pte_writable(vma, address, pte)) {
>> +        can_change_ptes_writable(vma, address, pte, NULL, 1)) {
>>           if (folio_test_dirty(folio))
>>               pte = pte_mkdirty(pte);
>>           pte = pte_mkwrite(pte, vma);
>> @@ -5767,7 +5767,7 @@ static void numa_rebuild_large_mapping(struct 
>> vm_fault *vmf, struct vm_area_stru
>>               ptent = pte_modify(ptent, vma->vm_page_prot);
>>               writable = pte_write(ptent);
>>               if (!writable && pte_write_upgrade &&
>> -                can_change_pte_writable(vma, addr, ptent))
>> +                can_change_ptes_writable(vma, addr, ptent, NULL, 1))
>>                   writable = true;
>>           }
>> @@ -5808,7 +5808,7 @@ static vm_fault_t do_numa_page(struct vm_fault 
>> *vmf)
>>        */
>>       writable = pte_write(pte);
>>       if (!writable && pte_write_upgrade &&
>> -        can_change_pte_writable(vma, vmf->address, pte))
>> +        can_change_ptes_writable(vma, vmf->address, pte, NULL, 1))
>>           writable = true;
>>       folio = vm_normal_folio(vma, vmf->address, pte);
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index 33eabc995584..362fd7e5457d 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -40,8 +40,8 @@
>>   #include "internal.h"
>> -bool can_change_pte_writable(struct vm_area_struct *vma, unsigned 
>> long addr,
>> -                 pte_t pte)
>> +bool can_change_ptes_writable(struct vm_area_struct *vma, unsigned 
>> long addr,
>> +                  pte_t pte, struct folio *folio, unsigned int nr)
>>   {
>>       struct page *page;
>> @@ -67,6 +67,9 @@ bool can_change_pte_writable(struct vm_area_struct 
>> *vma, unsigned long addr,
>>            * write-fault handler similarly would map them writable 
>> without
>>            * any additional checks while holding the PT lock.
>>            */
>> +        if (unlikely(nr != 1))
>> +            return !folio_maybe_mapped_shared(folio);
>> +
>>           page = vm_normal_page(vma, addr, pte);
>>           return page && PageAnon(page) && PageAnonExclusive(page);
>>       }
> 
> IIUC, As mentioned in the comment above, we should do the same anonymous 
> check
> to large folios. And folio_maybe_mapped_shared() already handles both 
> order-0
> and large folios nicely, so we could simplify the logic as follows:

Thanks. Although we will have to call vm_normal_folio() in case of 
!folio, since we may not have the folio already for nr == 1 case.

> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 1605e89349d2..df56a30bb241 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -43,8 +43,6 @@
>   bool can_change_ptes_writable(struct vm_area_struct *vma, unsigned 
> long addr,
>                                pte_t pte, struct folio *folio, unsigned 
> int nr)
>   {
> -       struct page *page;
> -
>          if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
>                  return false;
> 
> @@ -67,11 +65,7 @@ bool can_change_ptes_writable(struct vm_area_struct 
> *vma, unsigned long addr,
>                   * write-fault handler similarly would map them 
> writable without
>                   * any additional checks while holding the PT lock.
>                   */
> -               if (unlikely(nr != 1))
> -                       return !folio_maybe_mapped_shared(folio);
> -
> -               page = vm_normal_page(vma, addr, pte);
> -               return page && PageAnon(page) && PageAnonExclusive(page);
> +               return folio_test_anon(folio) && ! 
> folio_maybe_mapped_shared(folio);
>          }
> 
>          VM_WARN_ON_ONCE(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte));
> -- 
> 
> Thanks,
> Lance
> 
>> @@ -222,7 +225,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>>                */
>>               if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>>                   !pte_write(ptent) &&
>> -                can_change_pte_writable(vma, addr, ptent))
>> +                can_change_ptes_writable(vma, addr, ptent, folio, 1))
>>                   ptent = pte_mkwrite(ptent, vma);
>>               ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
> 
> 



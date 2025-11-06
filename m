Return-Path: <linux-kernel+bounces-889073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E3C3CAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D083B4B02
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7093376A5;
	Thu,  6 Nov 2025 16:54:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996D34BA20
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448097; cv=none; b=MAk0C3aWBDaSz/dpuTTFUeJQUSPcI1YAd4zzu5I2OJIgEUVmtgoMk5MP9F2zDCoWyq4uepCzNKP1BxiUSA81AnGq8O8TVovpA8KjbFl36I+MKvPapBP2PdVXkWYiochOJHNqKKsqlTrAUj2vpgELgeGAxYSj18i+DDPpyX8qdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448097; c=relaxed/simple;
	bh=FbJB2CacN1SnW23rA1cwgAD5eJ8EyM8yiTtGvzA/qdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3So8p/saHbyDjWYsfr7/D0s86xhkoZ/90nugMPgO/meegxKKRoAekC03WSPj/U9I6kwGZkRHmAnVXeJEi7AwiJJvZbu8VkyFsh0xbWkvhwFN3zpbpyyvFNWojqxBPKZroMC464dqdwiXU0eNxy+JUExwALXIl+7f+sAYDE587E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7FEB1596;
	Thu,  6 Nov 2025 08:54:46 -0800 (PST)
Received: from [10.1.30.195] (XHFQ2J9959.cambridge.arm.com [10.1.30.195])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E7ED3F694;
	Thu,  6 Nov 2025 08:54:51 -0800 (PST)
Message-ID: <bd10dd8a-8cdc-404e-8259-4d65ca9a650d@arm.com>
Date: Thu, 6 Nov 2025 16:54:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v4 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
Content-Language: en-GB
To: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>,
 Huang Ying <ying.huang@linux.alibaba.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <baohua@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Yin Fengwei <fengwei_yin@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251104095516.7912-1-ying.huang@linux.alibaba.com>
 <20251104095516.7912-3-ying.huang@linux.alibaba.com>
 <2b9fa85b-54ff-415c-9163-461e28b6d660@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2b9fa85b-54ff-415c-9163-461e28b6d660@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/11/2025 09:47, David Hildenbrand (Red Hat) wrote:
> On 04.11.25 10:55, Huang Ying wrote:
>> A multi-thread customer workload with large memory footprint uses
>> fork()/exec() to run some external programs every tens seconds.  When
>> running the workload on an arm64 server machine, it's observed that
>> quite some CPU cycles are spent in the TLB flushing functions.  While
>> running the workload on the x86_64 server machine, it's not.  This
>> causes the performance on arm64 to be much worse than that on x86_64.
>>
>> During the workload running, after fork()/exec() write-protects all
>> pages in the parent process, memory writing in the parent process
>> will cause a write protection fault.  Then the page fault handler
>> will make the PTE/PDE writable if the page can be reused, which is
>> almost always true in the workload.  On arm64, to avoid the write
>> protection fault on other CPUs, the page fault handler flushes the TLB
>> globally with TLBI broadcast after changing the PTE/PDE.  However, this
>> isn't always necessary.  Firstly, it's safe to leave some stale
>> read-only TLB entries as long as they will be flushed finally.
>> Secondly, it's quite possible that the original read-only PTE/PDEs
>> aren't cached in remote TLB at all if the memory footprint is large.
>> In fact, on x86_64, the page fault handler doesn't flush the remote
>> TLB in this situation, which benefits the performance a lot.
>>
>> To improve the performance on arm64, make the write protection fault
>> handler flush the TLB locally instead of globally via TLBI broadcast
>> after making the PTE/PDE writable.  If there are stale read-only TLB
>> entries in the remote CPUs, the page fault handler on these CPUs will
>> regard the page fault as spurious and flush the stale TLB entries.
>>
>> To test the patchset, make the usemem.c from
>> vm-scalability (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-
>> scalability.git).
>> support calling fork()/exec() periodically.  To mimic the behavior of
>> the customer workload, run usemem with 4 threads, access 100GB memory,
>> and call fork()/exec() every 40 seconds.  Test results show that with
>> the patchset the score of usemem improves ~40.6%.  The cycles% of TLB
>> flush functions reduces from ~50.5% to ~0.3% in perf profile.
>>
> 
> All makes sense to me.
> 
> Some smaller comments below.
> 
> [...]
> 
>> +
>> +static inline void local_flush_tlb_page_nonotify(
>> +    struct vm_area_struct *vma, unsigned long uaddr)
> 
> NIT: "struct vm_area_struct *vma" fits onto the previous line.
> 
>> +{
>> +    __local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
>> +    dsb(nsh);
>> +}
>> +
>> +static inline void local_flush_tlb_page(struct vm_area_struct *vma,
>> +                    unsigned long uaddr)
>> +{
>> +    __local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
>> +    mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, uaddr & PAGE_MASK,
>> +                        (uaddr & PAGE_MASK) + PAGE_SIZE);
>> +    dsb(nsh);
>> +}
>> +
>>   static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>>                          unsigned long uaddr)
>>   {
>> @@ -472,6 +512,22 @@ static inline void __flush_tlb_range(struct
>> vm_area_struct *vma,
>>       dsb(ish);
>>   }
>>   +static inline void local_flush_tlb_contpte(struct vm_area_struct *vma,
>> +                       unsigned long addr)
>> +{
>> +    unsigned long asid;
>> +
>> +    addr = round_down(addr, CONT_PTE_SIZE);
>> +
>> +    dsb(nshst);
>> +    asid = ASID(vma->vm_mm);
>> +    __flush_tlb_range_op(vale1, addr, CONT_PTES, PAGE_SIZE, asid,
>> +                 3, true, lpa2_is_enabled());
>> +    mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, addr,
>> +                            addr + CONT_PTE_SIZE);
>> +    dsb(nsh);
>> +}
>> +
>>   static inline void flush_tlb_range(struct vm_area_struct *vma,
>>                      unsigned long start, unsigned long end)
>>   {
>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>> index c0557945939c..589bcf878938 100644
>> --- a/arch/arm64/mm/contpte.c
>> +++ b/arch/arm64/mm/contpte.c
>> @@ -622,8 +622,7 @@ int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>>               __ptep_set_access_flags(vma, addr, ptep, entry, 0);
>>             if (dirty)
>> -            __flush_tlb_range(vma, start_addr, addr,
>> -                            PAGE_SIZE, true, 3);
>> +            local_flush_tlb_contpte(vma, start_addr);
> 
> In this case, we now flush a bigger range than we used to, no?

I don't believe so, no; we are still flushing the same contpte region (i.e. 64K
for 4K base page config).

> 
> Probably I am missing something (should this change be explained in more detail
> in the cover letter), but I'm wondering why this contpte handling wasn't
> required before on this level.

The previous __flush_tlb_range() API was flushing the same region. But that API
broadcasts. We decided not to just create a local version of that API because it
is more complex than it needs to be for this use case.

The whole (arm64-private) TLB flush interface is creeking and needs some
refactoring, which I'm planning to do as a follow up to this.

Thanks,
Ryan

> 
>>       } else {
>>           __contpte_try_unfold(vma->vm_mm, addr, ptep, orig_pte);
>>           __ptep_set_access_flags(vma, addr, ptep, entry, dirty);
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index d816ff44faff..22f54f5afe3f 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -235,7 +235,7 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
>>         /* Invalidate a stale read-only entry */
> 
> I would expand this comment to also explain how remote TLBs are handled very
> briefly -> flush_tlb_fix_spurious_fault().
> 
>>       if (dirty)
>> -        flush_tlb_page(vma, address);
>> +        local_flush_tlb_page(vma, address);
>>       return 1;
>>   }
>>   
> 



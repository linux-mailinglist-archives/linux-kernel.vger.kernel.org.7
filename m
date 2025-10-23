Return-Path: <linux-kernel+bounces-866683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9202C006ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D04FCFE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E25130102A;
	Thu, 23 Oct 2025 10:19:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4CB27EC7C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214741; cv=none; b=exfaFDvGzF9xQlNKqvYAcyOxCdNoQfm3wGalZCZFONo6GFXca67MZyygV9YK2nb6GIv6uHO5qDWdJUYzJNMy4QPYphGfQOgaRGKKjbHseJXb5+G0H5hbGngqgTOtZ/D1KEyHNeADl6zM3vc2VNKXSCq1A0B96gyylY5TzaXiKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214741; c=relaxed/simple;
	bh=uFkaK+Q3v7ERcep9IcbJIVUKMJGVGKIxEWt+xcA9EOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhDb2hYhcEzazEnUmSkvLPkc8PjT+pE9EA83G0vsgCn78hB6vN5ZpXRT30DCCHRAhAROel0jX8lf5X7c0NKZA5rJhI3ZBSbWFSZSkea8rJOW/Ow/lTJu5sr7rUc0qLzXyrAwGHf/iodJjQLdkOm2fBi33BvCsH4J2Z8KfirICdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E50B1516;
	Thu, 23 Oct 2025 03:18:50 -0700 (PDT)
Received: from [10.1.31.176] (XHFQ2J9959.cambridge.arm.com [10.1.31.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A4BA3F59E;
	Thu, 23 Oct 2025 03:18:54 -0700 (PDT)
Message-ID: <bc8f62a8-8e9d-45a2-8d77-e193b12d465d@arm.com>
Date: Thu, 23 Oct 2025 11:18:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, Huang Ying <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Yin Fengwei <fengwei_yin@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-3-ying.huang@linux.alibaba.com>
 <CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Barry, Huang,


On 22/10/2025 05:08, Barry Song wrote:
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index aa89c2e67ebc..35bae2e4bcfe 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -130,12 +130,16 @@ static inline void arch_leave_lazy_mmu_mode(void)
>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>
>>  /*
>> - * Outside of a few very special situations (e.g. hibernation), we always
>> - * use broadcast TLB invalidation instructions, therefore a spurious page
>> - * fault on one CPU which has been handled concurrently by another CPU
>> - * does not need to perform additional invalidation.
>> + * We use local TLB invalidation instruction when reusing page in
>> + * write protection fault handler to avoid TLBI broadcast in the hot
>> + * path.  This will cause spurious page faults if stall read-only TLB
>> + * entries exist.
>>   */
>> -#define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0)
>> +#define flush_tlb_fix_spurious_fault(vma, address, ptep)       \
>> +       local_flush_tlb_page_nonotify(vma, address)
>> +
>> +#define flush_tlb_fix_spurious_fault_pmd(vma, address, pmdp)   \
>> +       local_flush_tlb_page_nonotify(vma, address)
>>
>>  /*
>>   * ZERO_PAGE is a global shared page that is always zero: used
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 18a5dc0c9a54..651b31fd18bb 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -249,6 +249,18 @@ static inline unsigned long get_trans_granule(void)
>>   *             cannot be easily determined, the value TLBI_TTL_UNKNOWN will
>>   *             perform a non-hinted invalidation.
>>   *
>> + *     local_flush_tlb_page(vma, addr)
>> + *             Local variant of flush_tlb_page().  Stale TLB entries may
>> + *             remain in remote CPUs.
>> + *
>> + *     local_flush_tlb_page_nonotify(vma, addr)
>> + *             Same as local_flush_tlb_page() except MMU notifier will not be
>> + *             called.
>> + *
>> + *     local_flush_tlb_contpte_range(vma, start, end)
>> + *             Invalidate the virtual-address range '[start, end)' mapped with
>> + *             contpte on local CPU for the user address space corresponding
>> + *             to 'vma->mm'.  Stale TLB entries may remain in remote CPUs.
>>   *
>>   *     Finally, take a look at asm/tlb.h to see how tlb_flush() is implemented
>>   *     on top of these routines, since that is our interface to the mmu_gather
>> @@ -282,6 +294,33 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>>         mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
>>  }
>>
>> +static inline void __local_flush_tlb_page_nonotify_nosync(
>> +       struct mm_struct *mm, unsigned long uaddr)
>> +{
>> +       unsigned long addr;
>> +
>> +       dsb(nshst);

I've skimmed through this thread so appologies if I've missed some of the
detail, but thought it might be useful to give my opinion as a summary...

> We were issuing dsb(ishst) even for the nosync case, likely to ensure
> PTE visibility across cores. 

The leading dsb prior to issuing the tlbi is to ensure that the HW table
walker(s) will always see the new pte immediately after the tlbi completes.
Without it, you could end up with the old value immediately re-cached after the
tlbi completes. So if you are broadcasting the tlbi, the dsb needs to be to ish.
If you're doing local invalidation, then nsh is sufficient.

"nosync" is just saying that we will not wait for the tlbi to complete. You
still need to issue the leading dsb to ensure that the table walkers see the
latest pte once the tlbi (eventually) completes.

> However, since set_ptes already includes a
> dsb(ishst) in __set_pte_complete(), does this mean we’re being overly
> cautious in __flush_tlb_page_nosync() in many cases?

We only issue a dsb in __set_pte_complete() for kernel ptes. We elide for user
ptes becaue we can safely take a fault (for the case where we transition
invalid->valid) for user mappings and that race will resolve itself with the
help of the PTL. For valid->valid or valid->invalid, there will be an associated
tlb flush, which has the barrier.

> 
> static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>                                            unsigned long uaddr)
> {
>         unsigned long addr;
> 
>         dsb(ishst);
>         addr = __TLBI_VADDR(uaddr, ASID(mm));
>         __tlbi(vale1is, addr);
>         __tlbi_user(vale1is, addr);
>         mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAGE_MASK,
>                                                 (uaddr & PAGE_MASK) +
> PAGE_SIZE);
> }
> 
> On the other hand, __ptep_set_access_flags() doesn’t seem to use
> set_ptes(), so there’s no guarantee the updated PTEs are visible to all
> cores. If a remote CPU later encounters a page fault and performs a TLB
> invalidation, will it still see a stable PTE?

Yes, because the reads and writes are done under the PTL; that synchonizes the
memory for us.

You were discussing the potential value of upgrading the leading dsb from nshst
to ishst during the discussion. IMHO that's neither required nor desirable - the
memory synchonization is handled by the PTL. Overall, this optimization relies
on the premise that synchronizing with remote CPUs is expensive and races are
rare, so we should keep everything local for as long as possible and not worry
about micro-optimizing the efficiency of the race case.

> 
>> +       addr = __TLBI_VADDR(uaddr, ASID(mm));
>> +       __tlbi(vale1, addr);
>> +       __tlbi_user(vale1, addr);
>> +}
>> +
>> +static inline void local_flush_tlb_page_nonotify(
>> +       struct vm_area_struct *vma, unsigned long uaddr)
>> +{
>> +       __local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
>> +       dsb(nsh);
>> +}
>> +
>> +static inline void local_flush_tlb_page(struct vm_area_struct *vma,
>> +                                       unsigned long uaddr)
>> +{
>> +       __local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
>> +       mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, uaddr & PAGE_MASK,
>> +                                               (uaddr & PAGE_MASK) + PAGE_SIZE);
>> +       dsb(nsh);
>> +}
>> +
>>  static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>>                                            unsigned long uaddr)
>>  {
>> @@ -472,6 +511,23 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>>         dsb(ish);
>>  }
>>
> 
> We already have functions like
> __flush_tlb_page_nosync() and __flush_tlb_range_nosync().
> Is there a way to factor out or extract their common parts?
> 
> Is it because of the differences in barriers that this extraction of
> common code isn’t feasible?

I've proposed re-working these functions to add indepednent flags for
sync/nosync, local/broadcast and notify/nonotify. I think that will clean it up
quite a bit. But I was going to wait for this to land first. And also, Will has
an RFC for some other tlbflush API cleanup (converting it to C functions) so
might want to wait for or incorporate that too.

Thanks,
Ryan

> 
> Thanks
> Barry



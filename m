Return-Path: <linux-kernel+bounces-821929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0EB82A24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9541624DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A320299B;
	Thu, 18 Sep 2025 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rDrVJvy1"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2513AC1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758161938; cv=none; b=WsQxpVivrViQAm3zS0Wx90J3dj7yOd45jKlsn/YmYCbRosurivMTkqTHCcbMRNyQ1ik0NTlhr95QhLdUzG8wd3oZ+Vrwi/SCvVzd/y7RNIxIsrfuuWw3Ker76FZ51ACCcDAigkPAG9CagXj8gxBUN+EnCmdvul7bbMIpMKmWFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758161938; c=relaxed/simple;
	bh=2O69CQQYRWHLYGdKs9hWMJxDbdvSseKwKeYiT6CJIm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XW3T27KiNZF6b9yZRhtIvs9Wu5YfBuupYQR9Ucrknsznjffd4KMpsCK3PkRj8/9AyaYoizv+q6HI7umoDncKlLffQZTcCaeKakQEmUc2nw7c5Bs269TlziTwX4538S3KQm0WalqP696LS6YaHr0Re7WLPD2kr6TDzIYrIZ1CxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rDrVJvy1; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758161932; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=gxbRB5XWir6VmFp5xOaBmn7eG9P2Fj+zCnltu72Ma9U=;
	b=rDrVJvy1/CZsUwZOKum15BxmnTYm+W2eNz65U/wKUtS/Aihc8ZloAg/5RpDB2WDyO6VbHKAXAaS2ko/E/yq8rIT+n5mV6mGcZ4UkvMESnYBgcCmxTG6nrHo7svAQ31i9F2us6rkQsRFBe7Fck7Lu2CjNFRJAw/Pd+2l5sGXqBHI=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WoE51RN_1758161930 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 10:18:51 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  David
 Hildenbrand <david@redhat.com>,  Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,  Zi Yan
 <ziy@nvidia.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,  Yang Shi
 <yang@os.amperecomputing.com>,  "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,  Dev Jain <dev.jain@arm.com>,  Barry Song
 <baohua@kernel.org>,  Anshuman Khandual <anshuman.khandual@arm.com>,
  Yicong Yang <yangyicong@hisilicon.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Kevin Brodsky <kevin.brodsky@arm.com>,  Yin
 Fengwei <fengwei_yin@linux.alibaba.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
In-Reply-To: <46dcddec-88a9-4b22-920c-8a3edeb2f027@arm.com> (Ryan Roberts's
	message of "Tue, 16 Sep 2025 09:24:45 +0100")
References: <20250915032946.33203-1-ying.huang@linux.alibaba.com>
	<20250915032946.33203-3-ying.huang@linux.alibaba.com>
	<46dcddec-88a9-4b22-920c-8a3edeb2f027@arm.com>
Date: Thu, 18 Sep 2025 10:18:49 +0800
Message-ID: <87o6r833li.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Ryan,

Thanks for reivew!

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 15/09/2025 04:29, Huang Ying wrote:
>> A multi-thread customer workload with large memory footprint uses
>> fork()/exec() to run some external programs every tens seconds.  When
>> running the workload on an arm64 server machine, it's observed that
>> quite some CPU cycles are spent in the TLB flushing functions.  While
>> running the workload on the x86_64 server machine, it's not.  This
>> causes the performance on arm64 to be much worse than that on x86_64.
>> 
>> During the workload running, after fork()/exec() write-protects all
>> pages in the parent process, memory writing in the parent process
>> will cause a write protection fault.  Then the page fault handler
>> will make the PTE/PDE writable if the page can be reused, which is
>> almost always true in the workload.  On arm64, to avoid the write
>> protection fault on other CPUs, the page fault handler flushes the TLB
>> globally with TLBI broadcast after changing the PTE/PDE.  However, this
>> isn't always necessary.  Firstly, it's safe to leave some stall
>> read-only TLB entries as long as they will be flushed finally.
>> Secondly, it's quite possible that the original read-only PTE/PDEs
>> aren't cached in remote TLB at all if the memory footprint is large.
>> In fact, on x86_64, the page fault handler doesn't flush the remote
>> TLB in this situation, which benefits the performance a lot.
>> 
>> To improve the performance on arm64, make the write protection fault
>> handler flush the TLB locally instead of globally via TLBI broadcast
>> after making the PTE/PDE writable.  If there are stall read-only TLB
>> entries in the remote CPUs, the page fault handler on these CPUs will
>> regard the page fault as spurious and flush the stall TLB entries.
>> 
>> To test the patchset, make the usemem.c from
>> vm-scalability (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git).
>> support calling fork()/exec() periodically.  To mimic the behavior of
>> the customer workload, run usemem with 4 threads, access 100GB memory,
>> and call fork()/exec() every 40 seconds.  Test results show that with
>> the patchset the score of usemem improves ~40.6%.  The cycles% of TLB
>> flush functions reduces from ~50.5% to ~0.3% in perf profile.
>
> Overall, this looks like a simple and useful performance optimization - thanks!
> I'm running this through our performance regression suite to see if it spots any
> workloads where the change slows things down and will report once we have the
> results.

Thanks!

>> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Yang Shi <yang@os.amperecomputing.com>
>> Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Yicong Yang <yangyicong@hisilicon.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
>> Cc: Yin Fengwei <fengwei_yin@linux.alibaba.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> ---
>>  arch/arm64/include/asm/pgtable.h  | 14 ++++++++-----
>>  arch/arm64/include/asm/tlbflush.h | 33 +++++++++++++++++++++++++++++++
>>  arch/arm64/mm/fault.c             |  2 +-
>>  3 files changed, 43 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index abd2dee416b3..a9ed8c9d2c33 100644
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
>> +#define flush_tlb_fix_spurious_fault(vma, address, ptep)	\
>> +	local_flush_tlb_page_nonotify(vma, address)
>> +
>> +#define flush_tlb_fix_spurious_fault_pmd(vma, address, pmdp)	\
>> +	local_flush_tlb_page_nonotify(vma, address)
>
> It's not really clear to me how important doing local tlb flushes for pmds is
> for the performance improvement? I'm guessing most of the win comes from the pte
> level? I suspect you have only added spurious pmd fault handling because the
> arm64 implementation of __ptep_set_access_flags() actually handles both pte and
> pmd levels?
>
> Given the core kernel didn't previously have support for pmd spurious faults, I
> wonder if it would be simpler to drop the first patch and rejig
> __ptep_set_access_flags() so that it has a pgsize parameter and can
> differentiate based on that? I'm on the fence...
>
> If you do end up taking this approach, there is a style I introduced for
> hugetlb, where the function is suffixed with _anysz and it takes a pgsize param:
>
> int __ptep_set_access_flags_anysz(struct vm_area_struct *vma,
> 				  unsigned long address, pte_t *ptep,
> 				  pte_t entry, int dirty, unsigned long pgsize);

From the performance point of view, local TLB flushes don't improve
performance much.  At least in a test similar to the one above, we don't
find observable improvement.

From the design point of view, I personally prefer to use similar logic
between PMD and PTE unless it hurts performance.  IMHO, less different
logic means less mental overhead.  Do you agree?

>>  
>>  /*
>>   * ZERO_PAGE is a global shared page that is always zero: used
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 18a5dc0c9a54..607b67d8f61b 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -282,6 +282,39 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>>  	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
>>  }
>>  
>> +static inline void __local_flush_tlb_page_nonotify_nosync(
>> +	struct mm_struct *mm, unsigned long uaddr)
>> +{
>> +	unsigned long addr;
>> +
>> +	dsb(nshst);
>> +	addr = __TLBI_VADDR(uaddr, ASID(mm));
>> +	__tlbi(vale1, addr);
>> +	__tlbi_user(vale1, addr);
>> +}
>> +
>> +static inline void local_flush_tlb_page_nonotify(
>> +	struct vm_area_struct *vma, unsigned long uaddr)
>> +{
>> +	__local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
>> +	dsb(nsh);
>> +}
>> +
>> +static inline void __local_flush_tlb_page_nosync(
>> +	struct mm_struct *mm, unsigned long uaddr)
>> +{
>> +	__local_flush_tlb_page_nonotify_nosync(mm, uaddr);
>> +	mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAGE_MASK,
>> +						(uaddr & PAGE_MASK) + PAGE_SIZE);
>> +}
>> +
>> +static inline void local_flush_tlb_page(struct vm_area_struct *vma,
>> +					unsigned long uaddr)
>> +{
>> +	__local_flush_tlb_page_nosync(vma->vm_mm, uaddr);
>> +	dsb(nsh);
>> +}
>> +
>
> You're introducing more variants than you're actually using here. I think you
> just need local_flush_tlb_page() and local_flush_tlb_page_nonotify(); you could
> keep __local_flush_tlb_page_nonotify_nosync() and drop
> __local_flush_tlb_page_nosync() since it's not really adding much?

Sure.

> But I'm also wondering if we should tidy up this API in general; we have local
> vs broadcast, sync vs nosync, notify vs nonotify. And page is really just a
> special case of a range. So perhaps it is better to rework the range API to take
> some flags and we can tidy up all of this. I know Will also posted an RFC to
> convert a lot of this to c functions, which should also be included. Not a
> blocker for this change, I don't think, but there should definitely be some
> follow up work to tidy it up. (I'm happy to take it on).

This sounds goo to me.  Thanks for working on this!

>>  static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>>  					   unsigned long uaddr)
>>  {
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index d816ff44faff..22f54f5afe3f 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -235,7 +235,7 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
>>  
>>  	/* Invalidate a stale read-only entry */
>>  	if (dirty)
>> -		flush_tlb_page(vma, address);
>> +		local_flush_tlb_page(vma, address);
>
> Given this is called for both pmds and ptes, it's a bit of an abuse to flush a
> *page*. Yes it is architecturally safe, but it's not exactly self-documenting.
> If we pass in the pgsize (as per above) it could be optimized given we know the
> level and we only want to invalidate the last level. e.g. the local equivalent to:
>
> __flush_tlb_range(vma, address, address + PMD_SIZE, PMD_SIZE, true, 2);
>
> or
>
> __flush_tlb_range(vma, address, address + PAGE_SIZE, PAGE_SIZE, true, 3);
>
> Again though, perhaps that is part of some follow up tidying work?

This sounds good to me too.  And, Yes, I think this can be a follow up
tidying work.

> contpte_ptep_set_access_flags() currently does a (broadcast) __flush_tlb_range()
> on the (pte_write(orig_pte) == pte_write(entry)) path. I think that should be
> changed to a local range invalidation to be consistent with this change.

Yes.  This should be changed too.  However, it means we need a local
variant of __flush_tlb_range() and flush_tlb_mm().  Is it OK to
introduce them first and tidy up later?

>>  	return 1;
>>  }
>>  

---
Best Regards,
Huang, Ying


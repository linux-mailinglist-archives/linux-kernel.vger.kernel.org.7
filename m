Return-Path: <linux-kernel+bounces-891371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C027C428D9
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 08:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C7A3B12DC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F34299ABF;
	Sat,  8 Nov 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AJII9qae"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6D4A0C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762587374; cv=none; b=CydtPbdWkMxCZXRgqIiUbKpdnRBqatirvrX2q3d+rojvX1RW/Ulhvge8Iz2147pN8cPXzr0FL4kdS/hX6gLsTQgWAKXiPU4X+0vOy0sFtcC8sdu8HEezTK1MTzQ5YvgusOncqKBy0jTvVC1YV9f5RtiLUJ9YSH9ljm6OwTELbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762587374; c=relaxed/simple;
	bh=D3ZOdcIuVYh5fR8rD7oiMW05m6SL+qVcyJoRslN/TSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ooZweL2Tl5FTziwXQRKpBa89atDBi2BAmLRt6ETTLMSSGsarXzQTIkzGIFYoIDxau0w8HZ4qb868VAyXsLKp+BGe4cW//G4q56dMEDwuQh81loA1K6NtU2q+nGKWox+G2h8MYvJQfNqwh9Mldit9mSS1+7avZXyWT2xeLjGBHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AJII9qae; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762587361; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=w5hRbEmCZAr8rZpKUXLSHNatmnQ6+I1kl4hbNoJwVz4=;
	b=AJII9qaes+KwuQhee25gsrcVGqrWAVGPp3ztu/xFoWPYPdsPQESTND9C3e7EAdt8VBMr3fKHwLDs2czw3TgiRUAcXxQFZEM0D3oN4V2drU0PX/njcsFdBghm1ynQA/JAAXa9Pbu1QxZ2prBczHCtdKoT/C1Yn9M2wzAS16gEdhA=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wrv9onH_1762586422 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 08 Nov 2025 15:20:23 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Ryan
 Roberts <ryan.roberts@arm.com>,  Barry Song <baohua@kernel.org>,  Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Zi Yan <ziy@nvidia.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Yang Shi <yang@os.amperecomputing.com>,  "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,  Dev Jain <dev.jain@arm.com>,  Anshuman Khandual
 <anshuman.khandual@arm.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,
  Kevin Brodsky <kevin.brodsky@arm.com>,  Yin Fengwei
 <fengwei_yin@linux.alibaba.com>,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH -v4 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
In-Reply-To: <2b9fa85b-54ff-415c-9163-461e28b6d660@gmail.com> (David
	Hildenbrand's message of "Thu, 6 Nov 2025 10:47:10 +0100")
References: <20251104095516.7912-1-ying.huang@linux.alibaba.com>
	<20251104095516.7912-3-ying.huang@linux.alibaba.com>
	<2b9fa85b-54ff-415c-9163-461e28b6d660@gmail.com>
Date: Sat, 08 Nov 2025 15:20:21 +0800
Message-ID: <87qzu97zyi.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, David,

"David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com> writes:

> On 04.11.25 10:55, Huang Ying wrote:
>> A multi-thread customer workload with large memory footprint uses
>> fork()/exec() to run some external programs every tens seconds.  When
>> running the workload on an arm64 server machine, it's observed that
>> quite some CPU cycles are spent in the TLB flushing functions.  While
>> running the workload on the x86_64 server machine, it's not.  This
>> causes the performance on arm64 to be much worse than that on x86_64.
>> During the workload running, after fork()/exec() write-protects all
>> pages in the parent process, memory writing in the parent process
>> will cause a write protection fault.  Then the page fault handler
>> will make the PTE/PDE writable if the page can be reused, which is
>> almost always true in the workload.  On arm64, to avoid the write
>> protection fault on other CPUs, the page fault handler flushes the TLB
>> globally with TLBI broadcast after changing the PTE/PDE.  However, this
>> isn't always necessary.  Firstly, it's safe to leave some stale
>> read-only TLB entries as long as they will be flushed finally.
>> Secondly, it's quite possible that the original read-only PTE/PDEs
>> aren't cached in remote TLB at all if the memory footprint is large.
>> In fact, on x86_64, the page fault handler doesn't flush the remote
>> TLB in this situation, which benefits the performance a lot.
>> To improve the performance on arm64, make the write protection fault
>> handler flush the TLB locally instead of globally via TLBI broadcast
>> after making the PTE/PDE writable.  If there are stale read-only TLB
>> entries in the remote CPUs, the page fault handler on these CPUs will
>> regard the page fault as spurious and flush the stale TLB entries.
>> To test the patchset, make the usemem.c from
>> vm-scalability (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git).
>> support calling fork()/exec() periodically.  To mimic the behavior of
>> the customer workload, run usemem with 4 threads, access 100GB memory,
>> and call fork()/exec() every 40 seconds.  Test results show that with
>> the patchset the score of usemem improves ~40.6%.  The cycles% of TLB
>> flush functions reduces from ~50.5% to ~0.3% in perf profile.
>> 
>
> All makes sense to me.
>
> Some smaller comments below.

Thanks!

> [...]
>
>> +
>> +static inline void local_flush_tlb_page_nonotify(
>> +	struct vm_area_struct *vma, unsigned long uaddr)
>
> NIT: "struct vm_area_struct *vma" fits onto the previous line.

Sure.

>> +{
>> +	__local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
>> +	dsb(nsh);
>> +}
>> +
>> +static inline void local_flush_tlb_page(struct vm_area_struct *vma,
>> +					unsigned long uaddr)
>> +{
>> +	__local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
>> +	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, uaddr & PAGE_MASK,
>> +						(uaddr & PAGE_MASK) + PAGE_SIZE);
>> +	dsb(nsh);
>> +}
>> +
>>   static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>>   					   unsigned long uaddr)
>>   {
>> @@ -472,6 +512,22 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>>   	dsb(ish);
>>   }
>>   +static inline void local_flush_tlb_contpte(struct vm_area_struct
>> *vma,
>> +					   unsigned long addr)
>> +{
>> +	unsigned long asid;
>> +
>> +	addr = round_down(addr, CONT_PTE_SIZE);
>> +
>> +	dsb(nshst);
>> +	asid = ASID(vma->vm_mm);
>> +	__flush_tlb_range_op(vale1, addr, CONT_PTES, PAGE_SIZE, asid,
>> +			     3, true, lpa2_is_enabled());
>> +	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, addr,
>> +						    addr + CONT_PTE_SIZE);
>> +	dsb(nsh);
>> +}
>> +
>>   static inline void flush_tlb_range(struct vm_area_struct *vma,
>>   				   unsigned long start, unsigned long end)
>>   {
>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>> index c0557945939c..589bcf878938 100644
>> --- a/arch/arm64/mm/contpte.c
>> +++ b/arch/arm64/mm/contpte.c
>> @@ -622,8 +622,7 @@ int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>>   			__ptep_set_access_flags(vma, addr, ptep, entry, 0);
>>     		if (dirty)
>> -			__flush_tlb_range(vma, start_addr, addr,
>> -							PAGE_SIZE, true, 3);
>> +			local_flush_tlb_contpte(vma, start_addr);
>
> In this case, we now flush a bigger range than we used to, no?
>
> Probably I am missing something (should this change be explained in
> more detail in the cover letter), but I'm wondering why this contpte
> handling wasn't required before on this level.

As Ryan explained in his replay email.  The flush range doesn't change
here.  We just replace global TLB flush with local TLB flush.

>>   	} else {
>>   		__contpte_try_unfold(vma->vm_mm, addr, ptep, orig_pte);
>>   		__ptep_set_access_flags(vma, addr, ptep, entry, dirty);
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index d816ff44faff..22f54f5afe3f 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -235,7 +235,7 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
>>     	/* Invalidate a stale read-only entry */
>
> I would expand this comment to also explain how remote TLBs are
> handled very briefly -> flush_tlb_fix_spurious_fault().

Sure.

>>   	if (dirty)
>> -		flush_tlb_page(vma, address);
>> +		local_flush_tlb_page(vma, address);
>>   	return 1;
>>   }
>>   

---
Best Regards,
Huang, Ying


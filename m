Return-Path: <linux-kernel+bounces-864346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 889F9BFA933
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD8484F9D98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB532F745B;
	Wed, 22 Oct 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="InR5naqE"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC22F1FFC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118332; cv=none; b=MAXX+r3IgwXCKSKTHh0fP/B7bjI9Fd/0nX6mqH0ufCyf+Janwr4rBt/N5stXoZhmoAm0Ci22/6kdNX15H2tdHQl75Gz8M/96nRi5QZfSkVftjMXQqXN8kNFUyDgbooB/MCgxD0lt+THxcty7ba4Z5ERa1qc+G+2Ha+YybOUfcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118332; c=relaxed/simple;
	bh=unfHBvTALKvQhlwzXn3wOIjur74YW56E5fA5oQ8JoCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G9PermlQ5su2ZszGxUoV6xtMekPayGVomtWg0wdsb7DgaE+a2BJTrHr5DqWwE/jGUCk92ymWvY0fXRHgUls2Te9ahqZnS4O80WV9eeUVqjFXk0B3MZTMBhdWhuVupABk++tpep3gWc1aZZ0ngq47rTNJlZTYMtQgaDgqtw3Y37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=InR5naqE; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761118320; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=QtY8PxEyIubqCZUk80T4fMo0woyvuu6eo6/vRZ5dv8s=;
	b=InR5naqE12shqKfMuSggTZgD8usHpAbCp1sy5++MvTHKbokmqqvBVUH0YwBcyTKGnZafGjaEYwQ0raeIVC62P8rvxIfV1tipTAe2Yl9TgkzL/x8zpphMGNC897AMkyDndkVG1Vk3jUrShQ0iSxOhuQBq5DQFJd9UoKsgBKC/HAs=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqlxQu6_1761118300 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 15:31:58 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  David
 Hildenbrand <david@redhat.com>,  Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,  Zi Yan
 <ziy@nvidia.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,  Ryan
 Roberts <ryan.roberts@arm.com>,  Yang Shi <yang@os.amperecomputing.com>,
  "Christoph Lameter (Ampere)" <cl@gentwo.org>,  Dev Jain
 <dev.jain@arm.com>,  Anshuman Khandual <anshuman.khandual@arm.com>,
  Yicong Yang <yangyicong@hisilicon.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Kevin Brodsky <kevin.brodsky@arm.com>,  Yin
 Fengwei <fengwei_yin@linux.alibaba.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH -v2 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
In-Reply-To: <CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
	(Barry Song's message of "Wed, 22 Oct 2025 17:08:47 +1300")
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
	<20251013092038.6963-3-ying.huang@linux.alibaba.com>
	<CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
Date: Wed, 22 Oct 2025 15:31:39 +0800
Message-ID: <87a51jfl44.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, Barry,

Barry Song <21cnbao@gmail.com> writes:

>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/p=
gtable.h
>> index aa89c2e67ebc..35bae2e4bcfe 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -130,12 +130,16 @@ static inline void arch_leave_lazy_mmu_mode(void)
>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>
>>  /*
>> - * Outside of a few very special situations (e.g. hibernation), we alwa=
ys
>> - * use broadcast TLB invalidation instructions, therefore a spurious pa=
ge
>> - * fault on one CPU which has been handled concurrently by another CPU
>> - * does not need to perform additional invalidation.
>> + * We use local TLB invalidation instruction when reusing page in
>> + * write protection fault handler to avoid TLBI broadcast in the hot
>> + * path.  This will cause spurious page faults if stall read-only TLB
>> + * entries exist.
>>   */
>> -#define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (=
0)
>> +#define flush_tlb_fix_spurious_fault(vma, address, ptep)       \
>> +       local_flush_tlb_page_nonotify(vma, address)
>> +
>> +#define flush_tlb_fix_spurious_fault_pmd(vma, address, pmdp)   \
>> +       local_flush_tlb_page_nonotify(vma, address)
>>
>>  /*
>>   * ZERO_PAGE is a global shared page that is always zero: used
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/=
tlbflush.h
>> index 18a5dc0c9a54..651b31fd18bb 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -249,6 +249,18 @@ static inline unsigned long get_trans_granule(void)
>>   *             cannot be easily determined, the value TLBI_TTL_UNKNOWN =
will
>>   *             perform a non-hinted invalidation.
>>   *
>> + *     local_flush_tlb_page(vma, addr)
>> + *             Local variant of flush_tlb_page().  Stale TLB entries may
>> + *             remain in remote CPUs.
>> + *
>> + *     local_flush_tlb_page_nonotify(vma, addr)
>> + *             Same as local_flush_tlb_page() except MMU notifier will =
not be
>> + *             called.
>> + *
>> + *     local_flush_tlb_contpte_range(vma, start, end)
>> + *             Invalidate the virtual-address range '[start, end)' mapp=
ed with
>> + *             contpte on local CPU for the user address space correspo=
nding
>> + *             to 'vma->mm'.  Stale TLB entries may remain in remote CP=
Us.
>>   *
>>   *     Finally, take a look at asm/tlb.h to see how tlb_flush() is impl=
emented
>>   *     on top of these routines, since that is our interface to the mmu=
_gather
>> @@ -282,6 +294,33 @@ static inline void flush_tlb_mm(struct mm_struct *m=
m)
>>         mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
>>  }
>>
>> +static inline void __local_flush_tlb_page_nonotify_nosync(
>> +       struct mm_struct *mm, unsigned long uaddr)
>> +{
>> +       unsigned long addr;
>> +
>> +       dsb(nshst);
>
> We were issuing dsb(ishst) even for the nosync case, likely to ensure
> PTE visibility across cores. However, since set_ptes already includes a
> dsb(ishst) in __set_pte_complete(), does this mean we=E2=80=99re being ov=
erly
> cautious in __flush_tlb_page_nosync() in many cases?
>
> static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>                                            unsigned long uaddr)
> {
>         unsigned long addr;
>
>         dsb(ishst);
>         addr =3D __TLBI_VADDR(uaddr, ASID(mm));
>         __tlbi(vale1is, addr);
>         __tlbi_user(vale1is, addr);
>         mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAGE_MASK,
>                                                 (uaddr & PAGE_MASK) +
> PAGE_SIZE);
> }

IIUC, _nosync() here means doesn't synchronize with the following code.
It still synchronizes with the previous code, mainly the page table
changing.  And, Yes.  There may be room to improve this.

> On the other hand, __ptep_set_access_flags() doesn=E2=80=99t seem to use
> set_ptes(), so there=E2=80=99s no guarantee the updated PTEs are visible =
to all
> cores. If a remote CPU later encounters a page fault and performs a TLB
> invalidation, will it still see a stable PTE?

I don't think so.  We just flush local TLB in local_flush_tlb_page()
family functions.  So, we only needs to guarantee the page table changes
are available for the local page table walking.  If a page fault occurs
on a remote CPU, we will call local_flush_tlb_page() on the remote CPU.

>> +       addr =3D __TLBI_VADDR(uaddr, ASID(mm));
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
>> +       mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, uaddr & =
PAGE_MASK,
>> +                                               (uaddr & PAGE_MASK) + PA=
GE_SIZE);
>> +       dsb(nsh);
>> +}
>> +
>>  static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>>                                            unsigned long uaddr)
>>  {
>> @@ -472,6 +511,23 @@ static inline void __flush_tlb_range(struct vm_area=
_struct *vma,
>>         dsb(ish);
>>  }
>>
>
> We already have functions like
> __flush_tlb_page_nosync() and __flush_tlb_range_nosync().
> Is there a way to factor out or extract their common parts?
>
> Is it because of the differences in barriers that this extraction of
> common code isn=E2=80=99t feasible?

Yes.  It's a good idea to do some code clean to reduce code duplication.
Ryan has plan to work on this.

---
Best Regards,
Huang, Ying


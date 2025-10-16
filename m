Return-Path: <linux-kernel+bounces-855440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3800BE13B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D4CC4E4EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C141C1F4181;
	Thu, 16 Oct 2025 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WnnVfRxP"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E11A38F9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581386; cv=none; b=o5anfWV/Seyws2+43WfE02TSvQGVZ2hHCZwMDw8uwpsiuPBCl0lT9PjLphH7pHT8kHMyQHnWDdp/I7T6l83RBLGs6TmFumJt/D06ivv3fUn6+ldAdIbIwMg3pn1zaydoLWqgGFV9rhl8XmZJEbJd/3Zr5n2MU2rGSwPuFAvfA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581386; c=relaxed/simple;
	bh=82TtvQdZO4alCttxez/lI09PJ82VeN0a/Em5pXhae0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sm+OGSnaGEYzpvg1VOiwLXhKU/Csq7U8kNP+2kNCro22hyChRk5EcTODnEvsY3g78llbrVc8pQiEpeRirJsoDKeSo0jyQhSah0bsevmc98ZavJiHkswcAJoxZbD0wLFC+E+HQ9nEcS0xqlMF+srd4+/glWk8Vvpl+BVDA06UtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WnnVfRxP; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760581380; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=2iGb4w2CJ/xWobbduV7z9pfLjGzjU59oSShpLUnHZK0=;
	b=WnnVfRxPiTyzLzjSPcsypZI0pLFF0CRHxbgwE2EgmTELXfjYe1tgpVLpJa9DP9TZ1YaAvVjDR+S1z3MPbWzUDdGPf4AHRHgRdndjgiOZ4UzZHytt4yyFkjp16XNONH00ASQ7R6rE9HEah2KPiQvyegAQrQ6STQ9jbpOSNuO5gCg=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqId6gu_1760581378 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 10:22:59 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Vlastimil Babka <vbabka@suse.cz>,  Zi Yan
 <ziy@nvidia.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,  Ryan
 Roberts <ryan.roberts@arm.com>,  Yang Shi <yang@os.amperecomputing.com>,
  "Christoph Lameter (Ampere)" <cl@gentwo.org>,  Dev Jain
 <dev.jain@arm.com>,  Barry Song <baohua@kernel.org>,  Anshuman Khandual
 <anshuman.khandual@arm.com>,  Yicong Yang <yangyicong@hisilicon.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Kevin Brodsky
 <kevin.brodsky@arm.com>,  Yin Fengwei <fengwei_yin@linux.alibaba.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH -v2 1/2] mm: add spurious fault fixing support for huge pmd
In-Reply-To: <d748bc6b-2aff-4cee-a233-008f4d2555fa@lucifer.local> (Lorenzo
	Stoakes's message of "Wed, 15 Oct 2025 12:20:30 +0100")
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
	<20251013092038.6963-2-ying.huang@linux.alibaba.com>
	<4c453dcc-2837-4f1a-905b-3462270f5e31@lucifer.local>
	<87ldlcpnbx.fsf@DESKTOP-5N7EMDA>
	<d748bc6b-2aff-4cee-a233-008f4d2555fa@lucifer.local>
Date: Thu, 16 Oct 2025 10:22:57 +0800
Message-ID: <87bjm7lh4u.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:

> On Wed, Oct 15, 2025 at 04:43:14PM +0800, Huang, Ying wrote:
>> Hi, Lorenzo,
>>
>> Thanks for comments!
>>
>> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:
>>
>> > On Mon, Oct 13, 2025 at 05:20:37PM +0800, Huang Ying wrote:
>> >> In the current kernel, there is spurious fault fixing support for pte,
>> >> but not for huge pmd because no architectures need it. But in the
>> >> next patch in the series, we will change the write protection fault
>> >> handling logic on arm64, so that some stale huge pmd entries may
>> >> remain in the TLB. These entries need to be flushed via the huge pmd
>> >> spurious fault fixing mechanism.
>> >>
>> >> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
>> >
>> > Right now the PTE level spurious fault handling is dealt with in
>> > handle_pte_fault() when ptep_set_access_flags() returns false.
>> >
>> > Now you're updating touch_pmd() which is invoked by follow_huge_pmd() and
>> > huge_pmd_set_accessed().
>> >
>> > 1 - Why are you not adding handling to GUP?
>> >
>> > 2 - Is this the correct level of abstraction? It's really not obvious but
>> >     huge_pmd_set_accessed() is invoked by __handle_mm_fault() on a non-WP,
>> >     non-NUMA hint huge page fault where a page table entry already exists
>> >     but we are faulting anyway (e.g. non-present or read-only writable).
>> >
>> > You don't mention any of this in the commit message, which you need to do
>> > and really need to explain how spurious faults can arise, why you can only
>> > do this at the point of abstraction you do (if you are unable to put it in
>> > actual fault handing-code), and you need to add a bunch more comments to
>> > explain this.
>>
>> This patch adds the spurious PMD page fault fixing based on the spurious
>> PTE page fault fixing.  So, I assumed that the spurious page fault
>> fixing has been documented already.  But you are right, nothing prevents
>> us from improving it further.  Let's try to do that.
>
> I wouldn't make any kind of assumption like this in the kernel :) sadly our
> documentation is often incomplete.
>
>>
>> The page faults may be spurious because of the racy access to the page
>> table.  For example, a non-populated virtual page is accessed on 2 CPUs
>> simultaneously, thus the page faults are triggered on both CPUs.
>> However, it's possible that one CPU (say CPU A) cannot find the reason
>> for the page fault if the other CPU (say CPU B) has changed the page
>> table before the PTE is checked on CPU A.  Most of the time, the
>> spurious page faults can be ignored safely.  However, if the page fault
>> is for the write access, it's possible that a stale read-only TLB entry
>> exists in the local CPU and needs to be flushed on some architectures.
>> This is called the spurious page fault fixing.
>>
>> The spurious page fault fixing only makes sense during page fault
>> handling, so we don't need to do it for GUP.  In fact, I plan to avoid
>> it in all GUP paths in another followup patch.
>
> OK this is great, let's put it all in the kdoc for the new shared spurious
> faulting function! :) and additionally add it to the commit message.

Sure.  Will do it in the next version.

[snip]

>> >>
>> >> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> >> index 32e8457ad535..341622ec80e4 100644
>> >> --- a/include/linux/pgtable.h
>> >> +++ b/include/linux/pgtable.h
>> >> @@ -1232,6 +1232,10 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>> >>  #define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_page(vma, address)
>> >>  #endif
>> >>
>> >> +#ifndef flush_tlb_fix_spurious_fault_pmd
>> >> +#define flush_tlb_fix_spurious_fault_pmd(vma, address, ptep) do { } while (0)
>> >> +#endif
>> >
>> > flush_tlb_fix_spurious_fault(), when the arch doesn't declare it, defaults to
>> > flush_tlb_page() - why do we just do nothing in this case here?
>>
>> Because all architectures do nothing for the spurious PMD page fault
>> fixing until the [2/2] of this series.  Where, we make it necessary to
>> flush the local TLB for spurious PMD page fault fixing on arm64
>> architecture.
>>
>> If we follow the design of flush_tlb_fix_spurious_fault(), we need to
>> change all architecture implementation to do nothing in this patch to
>> keep the current behavior.  I don't think that it's a good idea.  Do
>> you agree?
>
> Yeah probably we should keep the same behaviour as before, which is
> obviously, prior to this series, we did nothing.
>
> I guess in the PTE case we _always_ want to flush the TLB, whereas in the
> PMD case we otherwise don't have any need to at the point at which the
> spurious flush is performed.
>
> But from your explanation above re: the stale TLB entry this _only_ needs
> to be done for architectures which might encounter this problem rather than
> needing a TLB flush in general.
>
> Given we're generalising the code and one case always flushes the TLB and
> the other doesn't maybe it's worth putting a comment in the generalised
> function mentioning this?

I'm not sure whether it's a good idea to document architecture behaviors
in the general code.  The behavior may be changed architecture by
architecture in the future.

[snip]

---
Best Regards,
Huang, Ying


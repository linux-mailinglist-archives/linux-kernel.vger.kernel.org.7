Return-Path: <linux-kernel+bounces-872516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F12C115D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FEC1A28022
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5695E2E5B0D;
	Mon, 27 Oct 2025 20:21:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B23221DAC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596471; cv=none; b=GyWTclvolg++ELAxhbGWdXBbIDIm8bClGk4VToM6KUdMLk41/BG/U9T49fr4OA+OHX+DPE/B4pZxn2Uk3D4HHsIeNA5fP6Biltp4DXy2iNU7WHPnnt4VzE8vbFIwmRZZeOH9OGfWfkJKMoE63PH6zH0wvNk3MWgQEA2WllFQEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596471; c=relaxed/simple;
	bh=X9yXy+m4DDPtz3Bh+N+7vr1oshE+GthHqryt/3BpdyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0g3RXTEha1kB6wwgKpK/GW0qqjKiwZxZjzmyxnUrOQeZ1fM+Ts+vEYRYZVLA/aT+XXWCWbz8Xhk6IJnBWSatWbKNNO/XCYijnUpDKHGXQHm7gemRvVO2nMl9n9ijmPTmWTC5hSeqQygV4to/ykIt6ebR/AHBwdHvVqQIKS8G2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DF34169E;
	Mon, 27 Oct 2025 13:20:59 -0700 (PDT)
Received: from [10.57.86.154] (unknown [10.57.86.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 569CE3F673;
	Mon, 27 Oct 2025 13:21:04 -0700 (PDT)
Message-ID: <60e66dc8-10f1-4c98-8e72-1c0463c5c4e3@arm.com>
Date: Mon, 27 Oct 2025 20:21:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm: Introduce can_pte_batch_count() for PTEs
 batch optimization.
Content-Language: en-GB
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Zhang Qilong <zhangqilong3@huawei.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
 sunnanyong@huawei.com, Dev Jain <dev.jain@arm.com>
References: <20251027140315.907864-1-zhangqilong3@huawei.com>
 <20251027140315.907864-2-zhangqilong3@huawei.com>
 <276b70aa-9853-40cc-8e7d-e790166706b5@redhat.com>
 <0c15f911-cd4c-4ad3-97b7-e7153679f15e@lucifer.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <0c15f911-cd4c-4ad3-97b7-e7153679f15e@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/10/2025 19:51, Lorenzo Stoakes wrote:
> +Dev, Ryan
> 
> Please ensure to keep Dev + Ryan in the loop on all future iterations of this.
> 
> On Mon, Oct 27, 2025 at 08:24:40PM +0100, David Hildenbrand wrote:
>> On 27.10.25 15:03, Zhang Qilong wrote:
>>> Currently, the PTEs batch requires folio access, with the maximum
>>> quantity limited to the PFNs contained within the folio. However,
>>> in certain case (such as mremap_folio_pte_batch and mincore_pte_range),
>>> accessing the folio is unnecessary and expensive.
>>>
>>> For scenarios that do not require folio access, this patch introduces
>>> can_pte_batch_count(). With contiguous physical addresses and identical
>>> PTE attribut bits, we can now process more page table entries at once,
>>> in batch, not just limited to entries mapped within a single folio. On
>>> the other hand, it avoid the folio access.
>>>
>>> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
>>> ---
>>>   mm/internal.h | 76 +++++++++++++++++++++++++++++++++++++++------------
>>>   1 file changed, 58 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 1561fc2ff5b8..92034ca9092d 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -233,61 +233,62 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>>>   		pte = pte_wrprotect(pte);
>>>   	return pte_mkold(pte);
>>>   }
>>>   /**
>>> - * folio_pte_batch_flags - detect a PTE batch for a large folio
>>> - * @folio: The large folio to detect a PTE batch for.
>>> + * can_pte_batch_count - detect a PTE batch in range [ptep, to ptep + max_nr)
>>
>> I really don't like the name.
>>
>> Maybe it's just pte_batch().
> 
> Yeah the name's terrible.
> 
> But I'm iffy about this series as a whole.
> 
> 'can' implies boolean, it should be something like get pte batch or count pte
> batch or something like this. It's silly to partially replace other functions
> also.
> 
> But I've doubtful as to whether any of this will work...
> 
>>
>>>    * @vma: The VMA. Only relevant with FPB_MERGE_WRITE, otherwise can be NULL.
>>>    * @ptep: Page table pointer for the first entry.
>>>    * @ptentp: Pointer to a COPY of the first page table entry whose flags this
>>>    *	    function updates based on @flags if appropriate.
>>>    * @max_nr: The maximum number of table entries to consider.
>>>    * @flags: Flags to modify the PTE batch semantics.
>>>    *
>>> - * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>>> - * pages of the same large folio in a single VMA and a single page table.
>>> + * This interface is designed for this case that do not require folio access.
>>> + * If folio consideration is needed, please call folio_pte_batch_flags instead.
> 
> I'm pretty certain we need to make sure we do not cross folio boundaries, which
> kills this series if so does it not?
> 
> Ryan - can you confirm?

Whenever you call set_ptes() for more than 1 pte, you are signalling that the
architecture is permitted to track only a single access and dirty bit that
covers the whole batch. arm64 takes advantage of this to use it's "contiguous
PTE" HW feature.

The core-mm considers access and dirty properties of a folio, so while fidelity
is lost in the pgtable due to contiguous mappings, the core-mm only cares at the
granularity of a folio, so as long as all the ptes set by a single call to
set_ptes() belong to the same folio, the system isn't losing any fidelity overall.

So to keep things simple, we document that all the pages must belong to the same
folio in set_ptes():

/**
 * set_ptes - Map consecutive pages to a contiguous range of addresses.
 * @mm: Address space to map the pages into.
 * @addr: Address to map the first page at.
 * @ptep: Page table pointer for the first entry.
 * @pte: Page table entry for the first page.
 * @nr: Number of pages to map.
 *
 * When nr==1, initial state of pte may be present or not present, and new state
 * may be present or not present. When nr>1, initial state of all ptes must be
 * not present, and new state must be present.
 *
 * May be overridden by the architecture, or the architecture can define
 * set_pte() and PFN_PTE_SHIFT.
 *
 * Context: The caller holds the page table lock.  The pages all belong
 * to the same folio.  The PTEs are all in the same PMD.
 */

So I guess this new function isn't problematic on it's own, but if the plan is
to use it to decide how to call set_ptes() then it becomes problematic. The side
effect I forsee is writeback amplification because neighouring folios get
erroneously dirtied due to a write to an adjacently mapped one that ends up
sharing a contpte mapping.

But there may be cases where we don't care about access/dirty tracking at all.
PFNMAP? In which case something like this may make sense.

Thanks,
Ryan


> 
>>> + *
>>> + * Detect a PTE batch: consecutive (present) PTEs that map consecutive pages
>>> + * in a single VMA and a single page table.
>>>    *
>>>    * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
>>>    * the accessed bit, writable bit, dirty bit (unless FPB_RESPECT_DIRTY is set)
>>>    * and soft-dirty bit (unless FPB_RESPECT_SOFT_DIRTY is set).
>>>    *
>>> - * @ptep must map any page of the folio. max_nr must be at least one and
>>> + * @ptep point to the first entry in range, max_nr must be at least one and
>>>    * must be limited by the caller so scanning cannot exceed a single VMA and
>>>    * a single page table.
>>>    *
>>>    * Depending on the FPB_MERGE_* flags, the pte stored at @ptentp will
>>>    * be updated: it's crucial that a pointer to a COPY of the first
>>>    * page table entry, obtained through ptep_get(), is provided as @ptentp.
>>>    *
>>> - * This function will be inlined to optimize based on the input parameters;
>>> - * consider using folio_pte_batch() instead if applicable.
>>> + * The following folio_pte_batch_flags() deal with PTEs that mapped in a
>>> + * single folio. However can_pte_batch_count has the capability to handle
>>> + * PTEs that mapped in consecutive folios. If flags is not set, it will ignore
>>> + * the accessed, writable and dirty bits. Once the flags is set, the respect
>>> + * bit(s) will be compared in pte_same(), if the advanced pte_batch_hint()
>>> + * respect pte bit is different, pte_same() will return false and break. This
>>> + * ensures the correctness of handling multiple folio PTEs.
>>> + *
>>> + * This function will be inlined to optimize based on the input parameters.
>>>    *
>>>    * Return: the number of table entries in the batch.
>>>    */
>>
>> I recall trouble if we try batching across folios:
> 
> Yup pretty sure Ryan said we don't/can't in a previous thread. Now cc'd...
> 
>>
>> commit 7b08b74f3d99f6b801250683c751d391128799ec (tag: mm-hotfixes-stable-2025-05-10-14-23)
>> Author: Petr Vaněk <arkamar@atlas.cz>
>> Date:   Fri May 2 23:50:19 2025 +0200
>>
>>     mm: fix folio_pte_batch() on XEN PV
>>     On XEN PV, folio_pte_batch() can incorrectly batch beyond the end of a
>>     folio due to a corner case in pte_advance_pfn().  Specifically, when the
>>     PFN following the folio maps to an invalidated MFN,
>>             expected_pte = pte_advance_pfn(expected_pte, nr);
>>     produces a pte_none().  If the actual next PTE in memory is also
>>     pte_none(), the pte_same() succeeds,
>>             if (!pte_same(pte, expected_pte))
>>                     break;
>>     the loop is not broken, and batching continues into unrelated memory.
>> ...
>>
>>
>> --
>> Cheers
>>
>> David / dhildenb
>>
> 
> Thanks, Lorenzk



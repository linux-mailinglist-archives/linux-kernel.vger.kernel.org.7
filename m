Return-Path: <linux-kernel+bounces-709312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CFAAEDBA2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 13:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94B17A9FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 11:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD92C283CB5;
	Mon, 30 Jun 2025 11:50:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613B5261573
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284250; cv=none; b=Yj4FGG1ws2V+4C+64haLYrO3neHJ32eUA3exQXgezvDSHwqdI7BMzVrY1h4iN1eOeStBFsfzhWcp+7MCukn7ddjd7FC9bgRCslVFZJEarLBfdy8FLTs6bzauBhkhmQMiQYUQX7lrVRRjjW3TsDAMSg2Z/9VmAnASV6j21AuMD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284250; c=relaxed/simple;
	bh=G6HYJtDvUbAjy9DovToqUkXGcOc2HdVDv5pz6R5N5ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KU/UF286RqibkWmb+esXxrT/Tr0jw3+lYmr3MgvJjXQoTQqM2nLPqMwcll/Hx+OXrZ0BkGzT2tnG+IH8DFmuQO6v96iUFlR4OUquISwfsH2pZzQmSvHBwwgqTyb/sUKQfpxPEHuqPndvVwm221zOefd3YmyUkirWS9g6//+eckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B568C1D34;
	Mon, 30 Jun 2025 04:50:31 -0700 (PDT)
Received: from [10.1.34.165] (XHFQ2J9959.cambridge.arm.com [10.1.34.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75F653F6A8;
	Mon, 30 Jun 2025 04:50:43 -0700 (PDT)
Message-ID: <8220a6a2-913a-42d8-9897-7306a624d89b@arm.com>
Date: Mon, 30 Jun 2025 12:50:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] mm: Optimize mprotect() by PTE-batching
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
 joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250628113435.46678-1-dev.jain@arm.com>
 <20250628113435.46678-4-dev.jain@arm.com>
 <41386e41-c1c4-4898-8958-2f4daa92dc7c@arm.com>
 <6ded026a-2df2-4d81-bb70-cd16a58f69e9@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6ded026a-2df2-4d81-bb70-cd16a58f69e9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/06/2025 12:21, Dev Jain wrote:
> 
> On 30/06/25 4:01 pm, Ryan Roberts wrote:
>> On 28/06/2025 12:34, Dev Jain wrote:
>>> Use folio_pte_batch to batch process a large folio. Reuse the folio from
>>> prot_numa case if possible.
>>>
>>> For all cases other than the PageAnonExclusive case, if the case holds true
>>> for one pte in the batch, one can confirm that that case will hold true for
>>> other ptes in the batch too; for pte_needs_soft_dirty_wp(), we do not pass
>>> FPB_IGNORE_SOFT_DIRTY. modify_prot_start_ptes() collects the dirty
>>> and access bits across the batch, therefore batching across
>>> pte_dirty(): this is correct since the dirty bit on the PTE really is
>>> just an indication that the folio got written to, so even if the PTE is
>>> not actually dirty (but one of the PTEs in the batch is), the wp-fault
>>> optimization can be made.
>>>
>>> The crux now is how to batch around the PageAnonExclusive case; we must
>>> check the corresponding condition for every single page. Therefore, from
>>> the large folio batch, we process sub batches of ptes mapping pages with
>>> the same PageAnonExclusive condition, and process that sub batch, then
>>> determine and process the next sub batch, and so on. Note that this does
>>> not cause any extra overhead; if suppose the size of the folio batch
>>> is 512, then the sub batch processing in total will take 512 iterations,
>>> which is the same as what we would have done before.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   mm/mprotect.c | 143 +++++++++++++++++++++++++++++++++++++++++---------
>>>   1 file changed, 117 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>> index 627b0d67cc4a..28c7ce7728ff 100644
>>> --- a/mm/mprotect.c
>>> +++ b/mm/mprotect.c
>>> @@ -40,35 +40,47 @@
>>>     #include "internal.h"
>>>   -bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>>> -                 pte_t pte)
>>> -{
>>> -    struct page *page;
>>> +enum tristate {
>>> +    TRI_FALSE = 0,
>>> +    TRI_TRUE = 1,
>>> +    TRI_MAYBE = -1,
>>> +};
>>>   +/*
>>> + * Returns enum tristate indicating whether the pte can be changed to writable.
>>> + * If TRI_MAYBE is returned, then the folio is anonymous and the user must
>>> + * additionally check PageAnonExclusive() for every page in the desired range.
>>> + */
>>> +static int maybe_change_pte_writable(struct vm_area_struct *vma,
>>> +                     unsigned long addr, pte_t pte,
>>> +                     struct folio *folio)
>>> +{
>>>       if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
>>> -        return false;
>>> +        return TRI_FALSE;
>>>         /* Don't touch entries that are not even readable. */
>>>       if (pte_protnone(pte))
>>> -        return false;
>>> +        return TRI_FALSE;
>>>         /* Do we need write faults for softdirty tracking? */
>>>       if (pte_needs_soft_dirty_wp(vma, pte))
>>> -        return false;
>>> +        return TRI_FALSE;
>>>         /* Do we need write faults for uffd-wp tracking? */
>>>       if (userfaultfd_pte_wp(vma, pte))
>>> -        return false;
>>> +        return TRI_FALSE;
>>>         if (!(vma->vm_flags & VM_SHARED)) {
>>>           /*
>>>            * Writable MAP_PRIVATE mapping: We can only special-case on
>>>            * exclusive anonymous pages, because we know that our
>>>            * write-fault handler similarly would map them writable without
>>> -         * any additional checks while holding the PT lock.
>>> +         * any additional checks while holding the PT lock. So if the
>>> +         * folio is not anonymous, we know we cannot change pte to
>>> +         * writable. If it is anonymous then the caller must further
>>> +         * check that the page is AnonExclusive().
>>>            */
>>> -        page = vm_normal_page(vma, addr, pte);
>>> -        return page && PageAnon(page) && PageAnonExclusive(page);
>>> +        return (!folio || folio_test_anon(folio)) ? TRI_MAYBE : TRI_FALSE;
>>>       }
>>>         VM_WARN_ON_ONCE(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte));
>>> @@ -80,15 +92,61 @@ bool can_change_pte_writable(struct vm_area_struct *vma,
>>> unsigned long addr,
>>>        * FS was already notified and we can simply mark the PTE writable
>>>        * just like the write-fault handler would do.
>>>        */
>>> -    return pte_dirty(pte);
>>> +    return pte_dirty(pte) ? TRI_TRUE : TRI_FALSE;
>>> +}
>>> +
>>> +/*
>>> + * Returns the number of pages within the folio, starting from the page
>>> + * indicated by pgidx and up to pgidx + max_nr, that have the same value of
>>> + * PageAnonExclusive(). Must only be called for anonymous folios. Value of
>>> + * PageAnonExclusive() is returned in *exclusive.
>>> + */
>>> +static int anon_exclusive_batch(struct folio *folio, int pgidx, int max_nr,
>>> +                bool *exclusive)
>>> +{
>>> +    struct page *page;
>>> +    int nr = 1;
>>> +
>>> +    if (!folio) {
>>> +        *exclusive = false;
>>> +        return nr;
>>> +    }
>>> +
>>> +    page = folio_page(folio, pgidx++);
>>> +    *exclusive = PageAnonExclusive(page);
>>> +    while (nr < max_nr) {
>>> +        page = folio_page(folio, pgidx++);
>>> +        if ((*exclusive) != PageAnonExclusive(page))
>> nit: brackets not required around *exclusive.
> 
> Thanks I'll drop it. I have a habit of putting brackets everywhere
> because debugging operator precedence bugs is a nightmare - finally
> the time has come to learn operator precedence!
> 
>>
>>> +            break;
>>> +        nr++;
>>> +    }
>>> +
>>> +    return nr;
>>> +}
>>> +
>>> +bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>>> +                 pte_t pte)
>>> +{
>>> +    struct page *page;
>>> +    int ret;
>>> +
>>> +    ret = maybe_change_pte_writable(vma, addr, pte, NULL);
>>> +    if (ret == TRI_MAYBE) {
>>> +        page = vm_normal_page(vma, addr, pte);
>>> +        ret = page && PageAnon(page) && PageAnonExclusive(page);
>>> +    }
>>> +
>>> +    return ret;
>>>   }
>>>     static int mprotect_folio_pte_batch(struct folio *folio, unsigned long addr,
>>> -        pte_t *ptep, pte_t pte, int max_nr_ptes)
>>> +        pte_t *ptep, pte_t pte, int max_nr_ptes, fpb_t switch_off_flags)
>>>   {
>>> -    const fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>> +    fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>> +
>>> +    flags &= ~switch_off_flags;
>> This is mega confusing when reading the caller. Because the caller passes
>> FPB_IGNORE_SOFT_DIRTY and that actually means DON'T ignore soft dirty.
>>
>> Can't we just pass in the flags we want?
> 
> Yup that is cleaner.
> 
>>
>>>   -    if (!folio || !folio_test_large(folio) || (max_nr_ptes == 1))
>>> +    if (!folio || !folio_test_large(folio))
>> What's the rational for dropping the max_nr_ptes == 1 condition? If you don't
>> need it, why did you add it in the earler patch?
> 
> Stupid me forgot to drop it from the earlier patch.
> 
>>
>>>           return 1;
>>>         return folio_pte_batch(folio, addr, ptep, pte, max_nr_ptes, flags,
>>> @@ -154,7 +212,8 @@ static int prot_numa_skip_ptes(struct folio **foliop,
>>> struct vm_area_struct *vma
>>>       }
>>>     skip_batch:
>>> -    nr_ptes = mprotect_folio_pte_batch(folio, addr, pte, oldpte, max_nr_ptes);
>>> +    nr_ptes = mprotect_folio_pte_batch(folio, addr, pte, oldpte,
>>> +                       max_nr_ptes, 0);
>>>   out:
>>>       *foliop = folio;
>>>       return nr_ptes;
>>> @@ -191,7 +250,10 @@ static long change_pte_range(struct mmu_gather *tlb,
>>>           if (pte_present(oldpte)) {
>>>               int max_nr_ptes = (end - addr) >> PAGE_SHIFT;
>>>               struct folio *folio = NULL;
>>> -            pte_t ptent;
>>> +            int sub_nr_ptes, pgidx = 0;
>>> +            pte_t ptent, newpte;
>>> +            bool sub_set_write;
>>> +            int set_write;
>>>                 /*
>>>                * Avoid trapping faults against the zero or KSM
>>> @@ -206,6 +268,11 @@ static long change_pte_range(struct mmu_gather *tlb,
>>>                       continue;
>>>               }
>>>   +            if (!folio)
>>> +                folio = vm_normal_folio(vma, addr, oldpte);
>>> +
>>> +            nr_ptes = mprotect_folio_pte_batch(folio, addr, pte, oldpte,
>>> +                               max_nr_ptes, FPB_IGNORE_SOFT_DIRTY);
>>  From the other thread, my memory is jogged that this function ignores write
>> permission bit. So I think that's opening up a bug when applied here? If the
>> first pte is writable but the rest are not (COW), doesn't this now make them all
>> writable? I don't *think* that's a problem for the prot_numa use, but I could be
>> wrong.
> 
> No, we are not ignoring the write permission bit. There is no way currently to
> do that via folio_pte_batch. So the pte batch is either entirely writable or
> entirely not.

How are you enforcing that then? Surely folio_pte_batch() is the only thing
looking at the individual PTEs? It's not guaranteed that just because the PTEs
all belong to a single VMA that the permissions are all the same; you could have
an RW private anon VMA which has been forked so all set to COW then individual
PTEs have faulted and broken COW (as an example).


> 
>>
>>>               oldpte = modify_prot_start_ptes(vma, addr, pte, nr_ptes);
>> Even if I'm wrong about ignoring write bit being a bug, I don't think the docs
>> for this function permit write bit to be different across the batch?
>>
>>>               ptent = pte_modify(oldpte, newprot);
>>>   @@ -227,15 +294,39 @@ static long change_pte_range(struct mmu_gather *tlb,
>>>                * example, if a PTE is already dirty and no other
>>>                * COW or special handling is required.
>>>                */
>>> -            if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>>> -                !pte_write(ptent) &&
>>> -                can_change_pte_writable(vma, addr, ptent))
>>> -                ptent = pte_mkwrite(ptent, vma);
>>> -
>>> -            modify_prot_commit_ptes(vma, addr, pte, oldpte, ptent, nr_ptes);
>>> -            if (pte_needs_flush(oldpte, ptent))
>>> -                tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
>>> -            pages++;
>>> +            set_write = (cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>>> +                    !pte_write(ptent);
>>> +            if (set_write)
>>> +                set_write = maybe_change_pte_writable(vma, addr, ptent, folio);
>> Why not just:
>>             set_write = (cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>>                     !pte_write(ptent) &&
>>                     maybe_change_pte_writable(...);
> 
> set_write is an int, which is supposed to span {TRI_MAYBE, TRI_FALSE, TRI_TRUE},
> whereas the RHS of this statement will always return a boolean.
> 
> You proposed it like this in your diff; it took hours for my eyes to catch this : )

Ahh good spot! I don't really love the tristate thing, but couldn't think of
anything better. So I guess it should really be:

		set_write = ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
			    !pte_write(ptent)) ? TRI_MAYBE : TRI_FALSE;
		if (set_write == TRI_MAYBE)
			set_write = maybe_change_pte_writable(...);

That would make it a bit more obvious as to what is going on for the reader?

Thanks,
Ryan

> 
>>
>> ?
>>
>>> +
>>> +            while (nr_ptes) {
>>> +                if (set_write == TRI_MAYBE) {
>>> +                    sub_nr_ptes = anon_exclusive_batch(folio,
>>> +                        pgidx, nr_ptes, &sub_set_write);
>>> +                } else {
>>> +                    sub_nr_ptes = nr_ptes;
>>> +                    sub_set_write = (set_write == TRI_TRUE);
>>> +                }
>>> +
>>> +                if (sub_set_write)
>>> +                    newpte = pte_mkwrite(ptent, vma);
>>> +                else
>>> +                    newpte = ptent;
>>> +
>>> +                modify_prot_commit_ptes(vma, addr, pte, oldpte,
>>> +                            newpte, sub_nr_ptes);
>>> +                if (pte_needs_flush(oldpte, newpte))
>> What did we conclude with pte_needs_flush()? I thought there was an arch where
>> it looked dodgy calling this for just the pte at the head of the batch?
> 
> Powerpc flushes if access bit transitions from set to unset. x86 does that
> for both dirty and access. Both problems are solved by modify_prot_start_ptes()
> which collects a/d bits, both in the generic implementation and the arm64
> implementation.
> 
>>
>> Thanks,
>> Ryan
>>
>>> +                    tlb_flush_pte_range(tlb, addr,
>>> +                        sub_nr_ptes * PAGE_SIZE);
>>> +
>>> +                addr += sub_nr_ptes * PAGE_SIZE;
>>> +                pte += sub_nr_ptes;
>>> +                oldpte = pte_advance_pfn(oldpte, sub_nr_ptes);
>>> +                ptent = pte_advance_pfn(ptent, sub_nr_ptes);
>>> +                nr_ptes -= sub_nr_ptes;
>>> +                pages += sub_nr_ptes;
>>> +                pgidx += sub_nr_ptes;
>>> +            }
>>>           } else if (is_swap_pte(oldpte)) {
>>>               swp_entry_t entry = pte_to_swp_entry(oldpte);
>>>               pte_t newpte;



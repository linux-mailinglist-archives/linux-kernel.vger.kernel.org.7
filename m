Return-Path: <linux-kernel+bounces-759822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656EB1E337
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5EA726339
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A99225C804;
	Fri,  8 Aug 2025 07:19:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007C22FF2D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637594; cv=none; b=UIbFbQSY353UVF4gCOjW3sKDvLeavO/0973J2iJWSNWoc0fJ4tkMhSrK7ROmqm9L+nkd796NpkoPppGcDLxLTRLVMq8VN1z8C8QLQLXXdkODgM3cjlghVC5/x2vxcapmFCHMdVn97LtbNYDzVS4mLXjHHvbAwsGEmGR+7QWCUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637594; c=relaxed/simple;
	bh=8MmdMEtEGnRUCLyxUk/hREryyUAK2oJUbxfoU4enDIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAKlyPL2/CEwQYiapmu1vYAB8eBkF7NjQmEV7CYMpC5OpajMGfZee5Mr32f9jk1/coTzxEbcr+9Li57ZyLeh3BuBcTspShuoRQuGWXmW4wRGkKOa2UyZgPDTjKNdkAj04wOYzMhOQojeY/8r+NGyJqQ2ECOGBxesKyOiME9AFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3D4222EA;
	Fri,  8 Aug 2025 00:19:43 -0700 (PDT)
Received: from [10.57.88.69] (unknown [10.57.88.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCD3A3F673;
	Fri,  8 Aug 2025 00:19:49 -0700 (PDT)
Message-ID: <303b1764-6471-421f-b4c3-6a2585cee2ae@arm.com>
Date: Fri, 8 Aug 2025 08:19:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
Content-Language: en-GB
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <158e6422-fc82-4d6c-a442-2ebe956a66da@redhat.com>
 <3fc75720-8da7-4f6c-bdce-1e1280b8e28f@lucifer.local>
 <6870e24f-dda6-421c-8df8-58294927b62d@arm.com>
 <ae01c6bc-019a-4263-8083-8ab073e72729@lucifer.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ae01c6bc-019a-4263-8083-8ab073e72729@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2025 21:58, Lorenzo Stoakes wrote:
> On Thu, Aug 07, 2025 at 08:56:44PM +0100, Ryan Roberts wrote:
>> On 07/08/2025 20:20, Lorenzo Stoakes wrote:
>>> +cc Ryan for ContPTE stuff.
>>
>> Appologies, I was aware of the other thread and on-going issues but haven't had
>> the bandwidth to follow too closely.
>>
>>>
>>> On Thu, Aug 07, 2025 at 09:10:52PM +0200, David Hildenbrand wrote:
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>
>>> Thanks!
>>>
>>>>
>>>> Wondering whether we could then just use the patch hint instead of going via
>>>> the folio.
>>>>
>>>> IOW,
>>>>
>>>> return pte_batch_hint(ptep, pte);
>>>
>>> Wouldn't that break the A/D stuff? Also this doesn't mean that the PTE won't
>>> have some conflicting flags potentially. The check is empirical:
>>>
>>> static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
>>> {
>>> 	if (!pte_valid_cont(pte))
>>> 		return 1;
>>>
>>> 	return CONT_PTES - (((unsigned long)ptep >> 3) & (CONT_PTES - 1));
>>> }
>>>
>>> So it's 'the most number of PTEs that _might_ coalesce'.
>>
>> No that's not correct; It's "at least this number of ptes _do_ coalesce".
>> folio_pte_batch() may end up returning a larger batch, but never smaller.
> 
> Yup David explained.
> 
> I suggest you rename this from 'hint', because that's not what hint means
> :) unless I'm really misunderstanding what this word means (it's 10pm and I
> started work at 6am so it's currently rather possible).

That's a lot of hours; I certainly appreciate you for putting the effort in and
figuring out the root cause so quickly.

Not sure if some sleep has changed your mind on what "hint" means? I'm pretty
sure David named this function, but for me the name makes sense. The arch is
saying "I know that the pte batch is at least N ptes. It's up to you if you use
that information. I'll still work correctly if you ignore it".

For me, your interpretation of 'the most number of PTEs that _might_ coalesce'
would be a guess, not a hint.

> 
> I understand the con PTE bit is a 'hint' but as I recall you saying at
> LSF/MM 'modern CPUs take the hint'. Which presumably is where this comes
> from, but that's kinda deceptive.
> 
> Anyway the reason I was emphatic here is on the basis that I believe I had
> this explained to met his way, which obviously I or whoever it was (don't
> recall) must have misunderstood. Or perhaps I hallucinated it... :)

FWIW, this is the documentation for the function:

/**
 * pte_batch_hint - Number of pages that can be added to batch without scanning.
 * @ptep: Page table pointer for the entry.
 * @pte: Page table entry.
 *
 * Some architectures know that a set of contiguous ptes all map the same
 * contiguous memory with the same permissions. In this case, it can provide a
 * hint to aid pte batching without the core code needing to scan every pte.
 *
 * An architecture implementation may ignore the PTE accessed state. Further,
 * the dirty state must apply atomically to all the PTEs described by the hint.
 *
 * May be overridden by the architecture, else pte_batch_hint is always 1.
 */

> 
> I see that folio_pte_batch() can get _more_, is this on the basis of there
> being adjacent, physically contiguous contPTE entries that can also be
> batched up?

From folio_pte_batch()'s perspective, they just have to be physically contiguous
and part of the same folio; they are not *required* to be contpte. They could
even have different read/write permissions in the middle of the batch (if the
flags permit); that's one reason why such a batch wouldn't be mapped contpte (a
contpte mapping is logically a single mapping so the permissions must all be the
same).

> 
>>
>> This function is looking to see if ptep is inside a conpte mapping, and if it
>> is, it's returning the number of ptes to the end of the contpte mapping (which
>> is of 64K size and alignment on 4K kernels). A contpte mapping will only exist
>> if the physical memory is appropriately aligned/sized and all belongs to a
>> single folio.
>>
>>>
>>> (note that a bit grossly we'll call it _again_ in folio_pte_batch_flags()).
>>>
>>> I suppose we could not even bother with checking if same folio and _just_ check
>>> if PTEs have consecutive PFNs, which is not very likely if different folio
>>> but... could that break something?
>>
>> Yes something could break; the batch must *all* belong to the same folio.
>> Functions like set_ptes() require that in their documentation, and arm64 depends
>> upon it in order not to screw up the access/dirty bits.
> 
> Turning this around - is a cont pte range guaranteed to belong to only one
> folio?

Yes.

> 
> If so then we can just limit the range to one batched block for the sake of
> mremap that perhaps doesn't necessarily hugely benefit from further
> batching anyway?

Yes.

> 
> Let's take the time to check performance on arm64 hardware.
> 
> Are we able to check to see how things behave if we have small folios only
> in the tested range on arm64

I thought Dev provided numbers for that, but I'll chat with him and ensure we
re-test (and broaden the testing if needed) with the new patch.

> 
>>
>>>
>>> It seems the 'magic' is in set_ptes() on arm64 where it'll know to do the 'right
>>> thing' for a contPTE batch (I may be missing something - please correct me if so
>>> Dev/Ryan).
>>
>> It will all do the right thing functionally no matter how you call it. But if
>> you can set_ptes() (and friends) on full contpte mappings, things are more
>> efficient.
> 
> Yup this is what I was... hinting at ;)

Bravo.

> 
>>
>>>
>>> So actually do we even really care that much about folio?
>>
>> From arm64's perspective, we're happy enough with batches the size of
>> pte_batch_hint(). folio_pte_batch() is a bonus, but certainly not a deal-breaker
>> for this location.
> 
> OK, so I think we should definitely refactor this.
> 
> David pointed out off-list we are duplicating the a/d handing _anyway_ in
> get_and_clear_ptes(). So that bit is just wasted effort, so there's really
> no need to do much that.
> 
>>
>> For the record, I'm pretty sure I was the person pushing for protecting
>> vm_normal_folio() with pte_batch_hint() right at the start of this process :)
> 
> I think you didn't give your hint clearly enough ;)
> 
>>
>> Thanks,
>> Ryan
>>
>>>
>>>>
>>>>
>>>> Not sure if that was discussed at some point before we went into the
>>>> direction of using folios. But there really doesn't seem to be anything
>>>> gained for other architectures here (as raised by Jann).
>>>
>>> Yup... I wonder about the other instances of this... ruh roh.
>>
>> IIRC prior to Dev's mprotect and mremap optimizations, I believe all sites
>> already needed the folio. I haven't actually looked at how mprotect ended up,
>> but maybe worth checking to see if it should protect with pte_batch_hint() too.
> 
> mprotect didn't? I mean let's check.

I think for mprotect, the folio was only previously needed for the numa case. I
have a vague memory that either Dev of I proposed wrapping folio_pte_batch() to
only get the folio and call it if the next PTE had an adjacent PFN (or something
like that). But it was deemed to complex. I might be misremembering... could
have been an internal conversation. I'll chat with Dev about it and revisit.

Thanks,
Ryan

> 
> We definitely need to be careful about other arches.
> 
>>
>> Thanks,
>> Ryan
> 
> Cheers, Lorenzo



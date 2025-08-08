Return-Path: <linux-kernel+bounces-759884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D73B1E3F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E832C189D0F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A424BD03;
	Fri,  8 Aug 2025 07:57:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4004D78F39
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639823; cv=none; b=YLLktMs6YazFv5EDchf7zs63eoajGgkk9pKIidcODK4iuT4GZ4QRs26Um8+VJrN/cRvamJjq5aguZWdWd4UYuneEW3zBfsbFNYfOc4qUEUjeBxETz994dZojDxkq6tZbVXjOb3eP7fc8z5VprgWBZtDK3K8DqjAKMvnu/MaUXYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639823; c=relaxed/simple;
	bh=g8NKVIxv3CpruPHCrFfQTgQX34dwpsYOqeGnq+0yAvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hb88N2EsZC14BCwuHe7FbhYuzikFzLLCocSN0dFCwsF0GUBH0n0ZFOVLHyLMPEYlpJhW3Sx2XPNWBpzdX8px9+hJDukFdwo4UsptQS+fxQw9ECqwB0AB/N8WuXCN/WZVXC0sNeg8ccp7+/P0eODRVgGSVBNAiVt42gCqeq+FhHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3F016F8;
	Fri,  8 Aug 2025 00:56:52 -0700 (PDT)
Received: from [10.57.88.69] (unknown [10.57.88.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F18B3F738;
	Fri,  8 Aug 2025 00:56:58 -0700 (PDT)
Message-ID: <8391c672-1123-4499-8d28-a731f2d88a9e@arm.com>
Date: Fri, 8 Aug 2025 08:56:56 +0100
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
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <158e6422-fc82-4d6c-a442-2ebe956a66da@redhat.com>
 <3fc75720-8da7-4f6c-bdce-1e1280b8e28f@lucifer.local>
 <6870e24f-dda6-421c-8df8-58294927b62d@arm.com>
 <ae01c6bc-019a-4263-8083-8ab073e72729@lucifer.local>
 <303b1764-6471-421f-b4c3-6a2585cee2ae@arm.com>
 <b0d257a4-a37d-41da-92f9-4d1c0a11c30c@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b0d257a4-a37d-41da-92f9-4d1c0a11c30c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/08/2025 08:45, David Hildenbrand wrote:
>>
>> Not sure if some sleep has changed your mind on what "hint" means? I'm pretty
>> sure David named this function, but for me the name makes sense. The arch is
>> saying "I know that the pte batch is at least N ptes. It's up to you if you use
>> that information. I'll still work correctly if you ignore it".
> 
> The last one is the important bit I think.
> 
>>
>> For me, your interpretation of 'the most number of PTEs that _might_ coalesce'
>> would be a guess, not a hint.
> 
> I'm not a native speaker, so I'll let both of you figure that out. To me it
> makes sense as well ... but well, I was involved when creating that function. :)
> 
>>
>>>
>>> I understand the con PTE bit is a 'hint' but as I recall you saying at
>>> LSF/MM 'modern CPUs take the hint'. Which presumably is where this comes
>>> from, but that's kinda deceptive.
>>>
>>> Anyway the reason I was emphatic here is on the basis that I believe I had
>>> this explained to met his way, which obviously I or whoever it was (don't
>>> recall) must have misunderstood. Or perhaps I hallucinated it... :)
>>
>> FWIW, this is the documentation for the function:
>>
>> /**
>>   * pte_batch_hint - Number of pages that can be added to batch without scanning.
>>   * @ptep: Page table pointer for the entry.
>>   * @pte: Page table entry.
>>   *
>>   * Some architectures know that a set of contiguous ptes all map the same
>>   * contiguous memory with the same permissions. In this case, it can provide a
>>   * hint to aid pte batching without the core code needing to scan every pte.
>>   *
>>   * An architecture implementation may ignore the PTE accessed state. Further,
>>   * the dirty state must apply atomically to all the PTEs described by the hint.
>>   *
>>   * May be overridden by the architecture, else pte_batch_hint is always 1.
>>   */
> 
> It's actually ... surprisingly good after reading it again after at least a year.
> 
>>
>>>
>>> I see that folio_pte_batch() can get _more_, is this on the basis of there
>>> being adjacent, physically contiguous contPTE entries that can also be
>>> batched up?
> 
> [...]
> 
>>>>>
>>>>>>
>>>>>>
>>>>>> Not sure if that was discussed at some point before we went into the
>>>>>> direction of using folios. But there really doesn't seem to be anything
>>>>>> gained for other architectures here (as raised by Jann).
>>>>>
>>>>> Yup... I wonder about the other instances of this... ruh roh.
>>>>
>>>> IIRC prior to Dev's mprotect and mremap optimizations, I believe all sites
>>>> already needed the folio. I haven't actually looked at how mprotect ended up,
>>>> but maybe worth checking to see if it should protect with pte_batch_hint() too.
>>>
>>> mprotect didn't? I mean let's check.
>>
>> I think for mprotect, the folio was only previously needed for the numa case. I
>> have a vague memory that either Dev of I proposed wrapping folio_pte_batch() to
>> only get the folio and call it if the next PTE had an adjacent PFN (or something
>> like that). But it was deemed to complex. I might be misremembering... could
>> have been an internal conversation. I'll chat with Dev about it and revisit.
>>
> 
> I am probably to blame here, because I think I rejected early to have arm64-only
> optimization, assuming other arch could benefit here as well with batching. But
> as it seems, batching in mremap() code really only serves the cont-pte managing
> code, and the folio_pte_batch() is really entirely unnecessary.
> 
> In case of mprotect(), I think really only (a) NUMA and (b) anon-folio write-
> upgrade required the folio. So it's a bit more tricky than mremap() here
> where ... the folio is entirely irrelevant.
> 
> One could detect the "anon write-upgrade possible" case early as well, and only
> lookup the folio in that case, otherwise use the straight pte hint.
> 
> So I think there is some room for further improvement.

ACK; Dev, perhaps you can take another look at this and work up a patch to more
agressively avoid vm_normal_folio() for mprotect?

Thanks,
Ryan



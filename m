Return-Path: <linux-kernel+bounces-759452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B957B1DDB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CCB3A1EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B37C22ACEF;
	Thu,  7 Aug 2025 19:56:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571A0155A4D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596613; cv=none; b=UyrE3KyAEr/kyXXtRCXclrdh9gVO5/Kq+X1W+Q0Pmpgl5f3FQhhFoOup1ruB/KTICSTI4UBrNsgITlh8z3Nn7EoxLfYsfh6p5Qp7uNRofr1NS8SLxaNG/AStQdy+YZzO49xDBnY39ElDWQkpAePgBU+ukiZhrxaIc9unMSMSIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596613; c=relaxed/simple;
	bh=x1Ln2q/psX8+A+IIwYMCCPNRQX9QWdn+t9MLKFLP6EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3Le0V2/0LxEYm92HfxCBeAhQPTkXTlFTFXOZYBncZQVqC46RoeuJjrMhOpH83a6LY9RcHGghA30irWAFLtrqK1UioFyW02q1mif005zJP/9RuA/3sdCzzh8t83BAZOkI1x1flMi0V4Cc8/ohXDvKvv7PXkwf5EyWllXX/aZ2bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 244581756;
	Thu,  7 Aug 2025 12:56:41 -0700 (PDT)
Received: from [10.57.87.232] (unknown [10.57.87.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF1EB3F5A1;
	Thu,  7 Aug 2025 12:56:46 -0700 (PDT)
Message-ID: <6870e24f-dda6-421c-8df8-58294927b62d@arm.com>
Date: Thu, 7 Aug 2025 20:56:44 +0100
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
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <158e6422-fc82-4d6c-a442-2ebe956a66da@redhat.com>
 <3fc75720-8da7-4f6c-bdce-1e1280b8e28f@lucifer.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3fc75720-8da7-4f6c-bdce-1e1280b8e28f@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2025 20:20, Lorenzo Stoakes wrote:
> +cc Ryan for ContPTE stuff.

Appologies, I was aware of the other thread and on-going issues but haven't had
the bandwidth to follow too closely.

> 
> On Thu, Aug 07, 2025 at 09:10:52PM +0200, David Hildenbrand wrote:
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks!
> 
>>
>> Wondering whether we could then just use the patch hint instead of going via
>> the folio.
>>
>> IOW,
>>
>> return pte_batch_hint(ptep, pte);
> 
> Wouldn't that break the A/D stuff? Also this doesn't mean that the PTE won't
> have some conflicting flags potentially. The check is empirical:
> 
> static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
> {
> 	if (!pte_valid_cont(pte))
> 		return 1;
> 
> 	return CONT_PTES - (((unsigned long)ptep >> 3) & (CONT_PTES - 1));
> }
> 
> So it's 'the most number of PTEs that _might_ coalesce'.

No that's not correct; It's "at least this number of ptes _do_ coalesce".
folio_pte_batch() may end up returning a larger batch, but never smaller.

This function is looking to see if ptep is inside a conpte mapping, and if it
is, it's returning the number of ptes to the end of the contpte mapping (which
is of 64K size and alignment on 4K kernels). A contpte mapping will only exist
if the physical memory is appropriately aligned/sized and all belongs to a
single folio.

> 
> (note that a bit grossly we'll call it _again_ in folio_pte_batch_flags()).
> 
> I suppose we could not even bother with checking if same folio and _just_ check
> if PTEs have consecutive PFNs, which is not very likely if different folio
> but... could that break something?

Yes something could break; the batch must *all* belong to the same folio.
Functions like set_ptes() require that in their documentation, and arm64 depends
upon it in order not to screw up the access/dirty bits.

> 
> It seems the 'magic' is in set_ptes() on arm64 where it'll know to do the 'right
> thing' for a contPTE batch (I may be missing something - please correct me if so
> Dev/Ryan).

It will all do the right thing functionally no matter how you call it. But if
you can set_ptes() (and friends) on full contpte mappings, things are more
efficient.

> 
> So actually do we even really care that much about folio?

From arm64's perspective, we're happy enough with batches the size of
pte_batch_hint(). folio_pte_batch() is a bonus, but certainly not a deal-breaker
for this location.

For the record, I'm pretty sure I was the person pushing for protecting
vm_normal_folio() with pte_batch_hint() right at the start of this process :)

Thanks,
Ryan

> 
>>
>>
>> Not sure if that was discussed at some point before we went into the
>> direction of using folios. But there really doesn't seem to be anything
>> gained for other architectures here (as raised by Jann).
> 
> Yup... I wonder about the other instances of this... ruh roh.

IIRC prior to Dev's mprotect and mremap optimizations, I believe all sites
already needed the folio. I haven't actually looked at how mprotect ended up,
but maybe worth checking to see if it should protect with pte_batch_hint() too.

Thanks,
Ryan

> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
>>
> 
> Cheers, Lorenzo



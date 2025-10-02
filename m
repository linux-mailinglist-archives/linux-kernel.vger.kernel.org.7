Return-Path: <linux-kernel+bounces-840335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BC1BB421E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B4D16E363
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EF42877DC;
	Thu,  2 Oct 2025 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1FqGB8Y"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285115464D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413913; cv=none; b=bZyrt5nCbGeVjg7rMTgpnH6TScn7BrESqPt4wpTlbsa97mfZqYZXcDj4gAjYIPmcOwdp8F4AHzFWJ/+l7+a8uCyqMtzjq9HRqdCzSlGfe0BzsOBi6R3WGJvNUHvAO9IYPPa6YgwOG6nAYp6h91V++cbmXu6knFWcLscjD2vdQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413913; c=relaxed/simple;
	bh=M0i8Gp+dHG2cICC6YGKhu3v8qz7iYjUyeS1PlpwDNa4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nnNMfBOceIQ2k8aFOMWRt14euGAZk+sUYL0Qvt0fsue0jk0SXTuewWyvqMRmgNuf3tR1bqooSyggu61fNxj8ZWnXSajMEP0UWJUZpxPw3kyt1iACjfHmsFWWHsMcyVl27yb8V2txobnwxAAarAFbN5VMAGgkC4X69bXrUd/n/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1FqGB8Y; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b3d6645acd3so108646566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759413909; x=1760018709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEqoonS/rPWcCApF7kzwVCksNrnIyl6aIHb9y9yvEE0=;
        b=F1FqGB8YZYiNDMyW6lpKz/120baWoaCQbMIxJ6l7MkrDOPOAOgOZfudio523gaJ+Tt
         Mi2JDqv5yGLyapQAxm9JW2N9QF1fUNO05pYL7WiLdhOysDZvkofBmb180kUKN8q+k4bB
         ImTZxqIVUm1WuQ53isLisJUD9mArM3EkzkwZ00Z/rG6ZMqMRAmlBAWan375xMgNJCjcM
         eHe6A3d/VskWKGUwZRkdEv6Q2X8QeowKQRQqOns6VmyVzdqm6HgUAd4sBMdBD1vS43B9
         63J8NOjiJhywWaA+t2C4qWTAYG3Rbwxmgp1vYgymBvEH3Ku46Ls69O3We6DWwWvp+gSb
         aU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759413909; x=1760018709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEqoonS/rPWcCApF7kzwVCksNrnIyl6aIHb9y9yvEE0=;
        b=i1LZilT66V43HGZb0pUQFP7dvVY/215/Vw/Y6+WX5R+x1MR6J8kGgZListngAm3aoI
         qp3Vq+RF+nsQEGvKHZ5oU2PTfHZFKou4tU4Xagk2/igY+DcGc+Qp6SHzeRHzzSx3qrfU
         nw7ikahgl46pbj3gGvqTxUfiO79llecS5UHDEk9zIReMUXetX5inb84VISIaL414wqjv
         T3LbTIzhfm1Pd3ioHAtQVNd9wO00qBXNEne1QFYeJLqiWdx4liNFqnGtzxF1CTUknqEB
         MfhjiqPYR39A1CKEUGHOAWikT1RsAs6NdyeSdIvj2cZgXvdMhku6kN3FxUUEzOnvrIu8
         4jBA==
X-Forwarded-Encrypted: i=1; AJvYcCXrCSzkDfp0A1pwbpMTFQQ/H3pxi52MPeDIpcJcJhL/Jn6WVVJG2Vv82mn4cJbWgmZ+r0SO6m1kTRL8yMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0wQZepHj7Y4AXouCFRV/yV0WA05U2Kgs/r4/Xebgzlzk5Igt
	USWdlShL4qKf1P4/y7mmVvz/RZiX0+1A2z0SlnP/9+3aTQxIsMjUNTE8BhmOCTUAp1y3vxxNERj
	BKgV8nJnDIUyVmw==
X-Google-Smtp-Source: AGHT+IFZaIaqkBKm5mBtTwxMyCC+T8dmRoB9gmf06e1kohCn27zyB8OOh5hVAnGNK78Fss7kY+bx//IvMfh2IA==
X-Received: from ejcsa14.prod.google.com ([2002:a17:907:6d0e:b0:b3c:76f3:6f73])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:948c:b0:b40:33ec:51ea with SMTP id a640c23a62f3a-b46e2436380mr865342866b.6.1759413909288;
 Thu, 02 Oct 2025 07:05:09 -0700 (PDT)
Date: Thu, 02 Oct 2025 14:05:08 +0000
In-Reply-To: <b0fb40f6-8baa-498f-bb88-50113cb80f53@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-4-2d861768041f@google.com> <b0fb40f6-8baa-498f-bb88-50113cb80f53@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD7W6FACMRPU.BXJCZU93UMVQ@google.com>
Subject: Re: [PATCH 04/21] x86/mm/asi: set up asi_nonsensitive_pgd
From: Brendan Jackman <jackmanb@google.com>
To: Dave Hansen <dave.hansen@intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: <peterz@infradead.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<mingo@redhat.com>, <tglx@linutronix.de>, <akpm@linux-foundation.org>, 
	<david@redhat.com>, <derkling@google.com>, <junaids@google.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <reijiw@google.com>, 
	<rientjes@google.com>, <rppt@kernel.org>, <vbabka@suse.cz>, <x86@kernel.org>, 
	<yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed Oct 1, 2025 at 8:28 PM UTC, Dave Hansen wrote:
> On 9/24/25 07:59, Brendan Jackman wrote:
>> Create the initial shared pagetable to hold all the mappings that will
>> be shared among ASI domains.
>> 
>> Mirror the physmap into the ASI pagetables, but with a maximum
>> granularity that's guaranteed to allow changing pageblock sensitivity
>> without having to allocate pagetables, and with everything as
>> non-present.
>
> Could you also talk about what this granularity _actually_ is and why it
> has the property of never requiring page table alloc

Ack, will expand on this (I think from your other comments that you
understand it now, and you're just asking me to improve the commit
message, let me know if I misread that).

>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index e98e85cf15f42db669696ba8195d8fc633351b26..7e0471d46767c63ceade479ae0d1bf738f14904a 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -7,6 +7,7 @@
>>   *  Copyright (C) 2002,2003 Andi Kleen <ak@suse.de>
>>   */
>>  
>> +#include <linux/asi.h>
>>  #include <linux/signal.h>
>>  #include <linux/sched.h>
>>  #include <linux/kernel.h>
>> @@ -746,7 +747,8 @@ phys_pgd_init(pgd_t *pgd_page, unsigned long paddr_start, unsigned long paddr_en
>>  {
>>  	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
>>  
>> -	*pgd_changed = false;
>> +	if (pgd_changed)
>> +		*pgd_changed = false;
>
> This 'pgd_changed' hunk isn't mentioned in the changelog.

Oops, will add a note about that. The alternative would just be to
squash this into the commit that introduces phys_pgd_init(), let me know
if you have a preference.

>> @@ -797,6 +800,24 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
>>  
>>  	paddr_last = phys_pgd_init(init_mm.pgd, paddr_start, paddr_end, page_size_mask,
>>  				   prot, init, &pgd_changed);
>> +
>> +	/*
>> +	 * Set up ASI's unrestricted physmap. This needs to mapped at minimum 2M
>> +	 * size so that regions can be mapped and unmapped at pageblock
>> +	 * granularity without requiring allocations.
>> +	 */
>
> This took me a minute to wrap my head around.
>
> Here, I think you're trying to convey that:
>
>   1. There's a higher-level design decision that all sensitivity will be
>      done at a 2M granularity. A 2MB physical region is either sensitive
>      or not.
>   2. Because of #1, 1GB mappings are not cool because splitting a 1GB
>      mapping into 2MB needs to allocate a page table page.
>   3. 4k mappings are OK because they can also have their permissions
>      changed at a 2MB granularity. It's just more laborious.
>
> The "minimum 2M size" comment really threw me off because that, to me,
> also includes 1G which is a no-no here.

Er yeah sorry that's just wrong, it should say "maximum size".

> I also can't help but wonder if it would have been easier and more
> straightforward to just start this whole exercise at 4k: force all the
> ASI tables to be 4k. Then, later, add the 2MB support and tie to
> pageblocks on after.

This would lead to a much smaller patchset, but I think it creates some
pretty yucky technical debt and complexity of its own. If you're
imagining a world where we just leave most of the allocator as-is, and
just inject "map into ASI" or "unmap from ASI" at the right moments...

I think to make this work you have to do one of:

- Say all free pages are unmapped from the restricted address space, we
  map them on-demand in allocation (if !__GFP_SENSITIVE), and unmap them
  again when they are freed. Because you can't flush the TLB
  synchronously in the free path, you need an async worker to take care
  of that for you.

  This is what we did in the Google implementation (where "don't change
  the page allocator more than you have to" kinda trumps everything) and
  it's pretty nasty. We have lots of knobs we can turn to try and make
  it perform well but in the end it's eventually gonna block deployment
  to some environment or other.

- Say free pages are mapped into the restricted address space. So if you
  get a __GFP_SENSITIVE alloc you unmap the pages and do the TLB flush
  synchronously there, unless we think the caller might be atomic, in
  which case.... I guess we'd have to have a sort of special atomic
  reserve for this? Which... seems like a weaker and more awkward
  version of the thing I'm proposing in this patchset.

  Then when you free the page you need to map it back again, which means
  you need to zero it.

I might have some tunnel-vision on this so please challenge me if it
sounds like I'm missing something.

>> +	if (asi_nonsensitive_pgd) {
>> +		/*
>> +		 * Since most memory is expected to end up sensitive, start with
>> +		 * everything unmapped in this pagetable.
>> +		 */
>> +		pgprot_t prot_np = __pgprot(pgprot_val(prot) & ~_PAGE_PRESENT);
>> +
>> +		VM_BUG_ON((PAGE_SHIFT + pageblock_order) < page_level_shift(PG_LEVEL_2M));
>> +		phys_pgd_init(asi_nonsensitive_pgd, paddr_start, paddr_end, 1 << PG_LEVEL_2M,
>> +			      prot_np, init, NULL);
>> +	}
>
> I'm also kinda wondering what the purpose is of having a whole page
> table full of !_PAGE_PRESENT entries. It would be nice to know how this
> eventually gets turned into something useful.

If you are thinking of the fact that just clearing P doesn't really do
anything for Meltdown/L1TF.. yeah that's true! We'll actually need to
munge the PFN or something too, but here I wanted do just focus on the
broad strokes of integration without worrying too much about individual
CPU mitigations. Flippping _PAGE_PRESENT is already supported by
set_memory.c and IIRC it's good enough for everything newer than
Skylake.

Other than that, these pages being unmapped is the whole point.. later
on, the subset of memory that we don't need to protect will get flipped
to being present. Everything else will trigger a pagefault if touched
and we'll switch address spaces, do the flushing etc.

Sorry if I'm missing your point here...


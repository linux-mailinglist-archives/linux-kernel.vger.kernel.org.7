Return-Path: <linux-kernel+bounces-840543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E43CDBB4A73
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4D319E4E41
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0312673B0;
	Thu,  2 Oct 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zOgtge5F"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4A42A99
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425598; cv=none; b=EPpNhrmLzo7gBvQjIrTORDrW60QARUhYx8GX+spRt218Jhj/U4EfoE/uCxnGRjeJz5Jk96+ScUlShgIa3N8310hGaYvgDcI7gV16T9ek66BUAG0Fbyu0uD4EYnq+AQ1LjWn0Lki6ur8vDrwCwOgV6prmM5UAxOD7vTRdWisDCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425598; c=relaxed/simple;
	bh=oyGxe1swqeRmaF+hx+sZT8Rujo0MHYjkVg2DnWNwzZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ERsXvSsXbFSckTJ3L7PQlDPw5q3he2LVpBHvHCIRVjCeh8ToqkEOOrH+E2WAZr5UQ16YWv+l1ZVM/kJmH3Olq89iZFPWgZidWWE5VNIg6Li+Si1qCeTTFJfVt/nVKPqgAYzDd5hKHEUV5m40FuuaOfQlerh1ccnCKqjC3tE7Ye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zOgtge5F; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so1011335f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759425594; x=1760030394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/f9RjnNhFPseqCNbW6l/omlX3YYRMtWpLdbNIAZycA=;
        b=zOgtge5FniaedgYmUk47m2vz0WOYTfAD9HG7joq3iNPZiTz6GlK63Vmz4ko5Qd+FFa
         TclS+gslXRNA8ZrQkCACbSm3Bc7NO18D5l+Wq+a44LCsGhSfbF4rpScsek7uTxFJArmV
         5ZQun2lU1BUorUJ84V5bKaox/QxnPB0PKrjELcmGZbszNkgsljh8ihATN7HmmphatO+D
         Kq6/lpr8ug6hv/y6oLZX3TzbaX5NCJYV2EmVzdnEbChgeCu6yiZe14/12qP9r5gOg9i9
         VUJba/6rvdRBZ0djeIp6DlhnCnu+1kJBGDBVrdWRvQAPMEn3witOpr+PAxCpBZKsg4Ai
         TV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425594; x=1760030394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/f9RjnNhFPseqCNbW6l/omlX3YYRMtWpLdbNIAZycA=;
        b=vxMHDn3usyMSS+Luc+ILmBAB7aaYKRTLwGBDTykvCmSl7VDmZgQeuGcuMyKZ40icib
         QosA8sN9usb/KpSYKhxjWHHP6TZ5zs1g7KcCeDK4vgr6ioKY/4qwbGpVVVS+DoWS2IoM
         JDjse/uoEhIayePBGKmFXl5S6xDQ7ZR5RNTf8jzti77h8+syiCvRJrzKEm4KV8R+1dzn
         DQWDjyUGxKmte11RbApBTlPOEafqUkdfa2ffBAsfs1RItImitW6yDPEr9kpiPGZ9cW+u
         54Qc/Lt7LsF+MioBxZo28MhcJQzxMtmg859wyCvRQKYBtk7QAHvnf02gbsN0wV3KiweR
         QVLA==
X-Forwarded-Encrypted: i=1; AJvYcCWQGkUH726y9gSA7MmMhBYXiCneU1BnF2TAh8zDV8TRKSPf55J9pYlB13wsoNRj25t1AyccPzU5e+FP8GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLj0f09dPrnCbslwZML3T1/rc4J21ZGC8NgdoV47N7IgIdN5vU
	Wb8huZAjNm4HTgxui71+MabzTA4Kl+mN5fWgWdNt4ZY3uiexXrdpGAagCPvoUanqg77KP1p8D3B
	EOu8DSobOVMR0Rw==
X-Google-Smtp-Source: AGHT+IGNJco/NMaeL5XlYH4pZ0xGoNdRmsQSt9z3k6S15d8LeR/Op1kMCUmxnZKhb7lNdaawLVzb8IJKvGEvSQ==
X-Received: from wmbz25.prod.google.com ([2002:a05:600c:c099:b0:46d:712:e422])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c0ce:b0:46e:59fe:a21b with SMTP id 5b1f17b1804b1-46e711043c2mr426345e9.4.1759425594691;
 Thu, 02 Oct 2025 10:19:54 -0700 (PDT)
Date: Thu, 02 Oct 2025 17:19:54 +0000
In-Reply-To: <9502454a-8065-4a65-9644-2b7fe0ec5f7f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-4-2d861768041f@google.com> <b0fb40f6-8baa-498f-bb88-50113cb80f53@intel.com>
 <DD7W6FACMRPU.BXJCZU93UMVQ@google.com> <9502454a-8065-4a65-9644-2b7fe0ec5f7f@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD80BJMZM5EF.4V737FVJY4F3@google.com>
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

On Thu Oct 2, 2025 at 4:14 PM UTC, Dave Hansen wrote:
> On 10/2/25 07:05, Brendan Jackman wrote:
>> On Wed Oct 1, 2025 at 8:28 PM UTC, Dave Hansen wrote:
> ...>> I also can't help but wonder if it would have been easier and more
>>> straightforward to just start this whole exercise at 4k: force all the
>>> ASI tables to be 4k. Then, later, add the 2MB support and tie to
>>> pageblocks on after.
>> 
>> This would lead to a much smaller patchset, but I think it creates some
>> pretty yucky technical debt and complexity of its own. If you're
>> imagining a world where we just leave most of the allocator as-is, and
>> just inject "map into ASI" or "unmap from ASI" at the right moments...
> ...
>
> I'm trying to separate out the two problems:
>
>  1. Have a set of page tables that never require allocations in order to
>     map or unmap sensitive data.
>  2. Manage each pageblock as either all sensitive or all not sensitive
>
> There is a nonzero set of dependencies to make sure that the pageblock
> size is compatible with the page table mapping size... unless you just
> make the mapping size 4k.
>
> If the mapping size is 4k, the pageblock size can be anything. There's
> no dependency to satisfy.
>
> So I'm not saying to make the sensitive/nonsensitive boundary 4k. Just
> to make the _mapping_ size 4k. Then, come back later, and move the
> mapping size over to 2MB as an optimization.

Ahh thanks, I get your point now. And yep I'm sold, I'll go to 4k for
v2.

>>>> +	if (asi_nonsensitive_pgd) {
>>>> +		/*
>>>> +		 * Since most memory is expected to end up sensitive, start with
>>>> +		 * everything unmapped in this pagetable.
>>>> +		 */
>>>> +		pgprot_t prot_np = __pgprot(pgprot_val(prot) & ~_PAGE_PRESENT);
>>>> +
>>>> +		VM_BUG_ON((PAGE_SHIFT + pageblock_order) < page_level_shift(PG_LEVEL_2M));
>>>> +		phys_pgd_init(asi_nonsensitive_pgd, paddr_start, paddr_end, 1 << PG_LEVEL_2M,
>>>> +			      prot_np, init, NULL);
>>>> +	}
>>>
>>> I'm also kinda wondering what the purpose is of having a whole page
>>> table full of !_PAGE_PRESENT entries. It would be nice to know how this
>>> eventually gets turned into something useful.
>> 
>> If you are thinking of the fact that just clearing P doesn't really do
>> anything for Meltdown/L1TF.. yeah that's true! We'll actually need to
>> munge the PFN or something too, but here I wanted do just focus on the
>> broad strokes of integration without worrying too much about individual
>> CPU mitigations. Flippping _PAGE_PRESENT is already supported by
>> set_memory.c and IIRC it's good enough for everything newer than
>> Skylake.
>> 
>> Other than that, these pages being unmapped is the whole point.. later
>> on, the subset of memory that we don't need to protect will get flipped
>> to being present. Everything else will trigger a pagefault if touched
>> and we'll switch address spaces, do the flushing etc.
>> 
>> Sorry if I'm missing your point here...
>
> What is the point of having a pgd if you can't put it in CR3? If you:
>
> 	write_cr3(asi_nonsensitive_pgd);
>
> you'll just triple fault because all kernel text is !_PAGE_PRESENT.
>
> The critical point is when 'asi_nonsensitive_pgd' is functional enough
> that it can be loaded into CR3 and handle a switch to the normal
> init_mm->pgd.

Hm, are you saying that I should expand the scope of the patchset from
"set up the direct map" to "set up an ASI address space"? If so, yeah I
can do that, I don't think the patchset would get that much bigger. I
only left the other bits out because it feels weird to set up a whole
address space but never actually switch into it. Setting up the logic to
switch into it would make the patchset really big though.

Like I said in the cover letter, I could also always change tack:
we could instead start with all the address-space switching logic, but
just have the two address spaces be clones of each other. Then we could
come back and start poking holes in the ASI one for the second series. I
don't have a really strong opinion about the best place to start, but
I'll stick to my current course unless someone else does have a strong
opinion.


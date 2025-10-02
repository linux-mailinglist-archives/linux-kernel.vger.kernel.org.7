Return-Path: <linux-kernel+bounces-840347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2163BB42B5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D853C1AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94331065A;
	Thu,  2 Oct 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xGtfqaAS"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062763594B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759415467; cv=none; b=UB14O84ET/45QyWr4Qb8uerRi32wQ1+eIqnYs6g0Li2XJu9fjKf/uShDx4GZJMjjJhuwfSihrei1L9HZ8+EfamCUEEsXCmCA+z9lVfKzrNiNajBy0hozeEKw8Wv2nVMqAr4rmEIh4/jWoGmDpmMHqiNgswg89U5nm+VpHk1q8fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759415467; c=relaxed/simple;
	bh=ag6JdXlgXl3KboiLDWma0gSW9S6sKYG4rJSZCyj0lq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EOOMheFxRUUVGn5rdm/vqTdvgMZ2V8SJ3CC+5cMkaA7XHBvHVa9DJP84UYkcmeBhKND0zsF2Yfi9V8JjGtsOPyOizGz78KCC4XU7zmymvTUSctk0vXPEx8/uyRCvw/xVsIpT1wneYX4cZcqWKYzSrY0r66MZUersoCy2k8oAFjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xGtfqaAS; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-637e3a27ddfso1153103a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759415463; x=1760020263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3U0yCIHNLTL7647O2FMhOisTrIzQr/JoD1Esv6My+A=;
        b=xGtfqaASBzQ1WXKiEcVW4nlPoikijXtjTSvffKt5xbooCCFt0H7JHBf3mvDQ1XdGao
         mHfQROv/yy0BbyWwLmMQOgr8p5FcJ9WB8hBZcR9bFMD7aJPsr6Qmp9HrUNs5TjqDv27t
         1s004nsQkNYSoZWyzf6ltR0tQ/HSVy7AMJXXQhDHUs+f1YOYArWGXhi7rnuW1h+ugvhk
         u+/PDnPjlVi1+ZtroBA0IzdeQu6JZ2Mf+zyI8Kop1PC1vcaLrBv7S0gdGMy7jR49MMix
         C4MCmN++AUH278/NiuKW8DxJf0Cmj0Qogdn5pGdYKa7qO83rbei8J9geSKU93QGjcp0U
         l5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759415463; x=1760020263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3U0yCIHNLTL7647O2FMhOisTrIzQr/JoD1Esv6My+A=;
        b=WJL7zeNfcBX3gGNnaCP0Aho3ZUU9jMh9k/liPBLuPQOO8N9hywNiOfXSVwt1UficBH
         bWVNOqx0G8UUM3H8SNRohdMgc9SFqyFiCn58qSwk7kTaTC7IHZAw0ITGSw14lbco68Dz
         TbdltYWttyfhetqezlryubQclvC0uVwW1+4F6Q2o9cIaK5+DTHApq4JH+wLMNj32yohR
         xKC4HsPSgXtk5+OcBY63ui5546TjzHeHYFW09VvSHWi3ToiDTeAZnZZ+oQfY/UNAP4/K
         tf6KTEvDZWPsUpVR+2bGMVBo8sY/kpD2luRjZU1+J/mD7dWTrk7lEknva4oGm84Xep5q
         GOKw==
X-Forwarded-Encrypted: i=1; AJvYcCXj6Aq5CAKFNfitHFc1+DtxTohUl+ogz+XjwGlKQxt9joiLXHzgjapkfmOp4aK9BjlHkB8Qe7wHL5o/E9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SxH0g5fV5tipsRljr39MptLSX1XDjSiW6/z8Tny7HQwpJS3S
	mwyFsfW4c41xobfr7/kaiRMxROIwtKV/JehAzjMOUZcELJwNwfb7GzPtjdNfzJlTCyLAT8m7lKK
	md+SgI7QWEtioXA==
X-Google-Smtp-Source: AGHT+IE8MEQbvPTnpHeVFsAD/pDo+XU5CHB4S/EYPztJT8lypC4YxQYsalKuMeDgFWaBeAm3gcG8mOLS8jK6VQ==
X-Received: from edqp24.prod.google.com ([2002:aa7:d318:0:b0:632:b2e5:2588])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:27d2:b0:637:e253:45d0 with SMTP id 4fb4d7f45d1cf-637e2534824mr2698706a12.11.1759415463266;
 Thu, 02 Oct 2025 07:31:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 14:31:02 +0000
In-Reply-To: <08338619-6aa1-4905-bdf8-bf1a90857307@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-5-2d861768041f@google.com> <08338619-6aa1-4905-bdf8-bf1a90857307@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD7WQ97R8OG6.1CA5E2FU5ISMZ@google.com>
Subject: Re: [PATCH 05/21] x86/mm/pat: mirror direct map changes to ASI
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
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed Oct 1, 2025 at 8:50 PM UTC, Dave Hansen wrote:
> On 9/24/25 07:59, Brendan Jackman wrote:
>> ASI has a separate PGD for the physmap, which needs to be kept in sync
>> with the unrestricted physmap with respect to permissions.
>
> So that leads to another thing... What about vmalloc()? Why doesn't it
> need to be in the ASI pgd?

Oh yeah it does. For the "actually entering the restricted addres space"
patchset, I'll include logic that just shares that region between the
unrestricted and restricted address space, something like this:

https://github.com/torvalds/linux/commit/04fd7a0b0098af48f2f8d9c0343b1edd12987681#diff-ecb3536ec179c07d4b4b387e58e62a9a6e553069cfed22a73448eb2ce5b82aa6R637-R669

Later, we'll want to be able to protect subsets of the vmalloc area
(i.e. unmap them from the restricted address space) too, but that's
something we can think about later I think. Unless I'm mistaken it's
much simpler than for the direct map. Junaid had a minumal solution for
that in his 2022 RFC [0]:

[0] https://lore.kernel.org/all/20220223052223.1202152-12-junaids@google.com/
	
>> +static inline bool is_direct_map(unsigned long vaddr)
>> +{
>> +	return within(vaddr, PAGE_OFFSET,
>> +		      PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT));
>> +}
>>  
>>  static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
>>  			       int primary)
>> @@ -1808,8 +1814,7 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
>>  	 * one virtual address page and its pfn. TBD: numpages can be set based
>>  	 * on the initial value and the level returned by lookup_address().
>>  	 */
>> -	if (within(vaddr, PAGE_OFFSET,
>> -		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT))) {
>> +	if (is_direct_map(vaddr)) {
>>  		cpa->numpages = 1;
>>  		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
>>  		return 0;
>> @@ -1981,6 +1986,27 @@ static int cpa_process_alias(struct cpa_data *cpa)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Having updated the unrestricted PGD, reflect this change in the ASI
>> + * restricted address space too.
>> + */
>> +static inline int mirror_asi_direct_map(struct cpa_data *cpa, int primary)
>> +{
>> +	struct cpa_data asi_cpa = *cpa;
>> +
>> +	if (!asi_enabled_static())
>> +		return 0;
>> +
>> +	/* Only need to do this for the real unrestricted direct map. */
>> +	if ((cpa->pgd && cpa->pgd != init_mm.pgd) || !is_direct_map(*cpa->vaddr))
>> +		return 0;
>> +	VM_WARN_ON_ONCE(!is_direct_map(*cpa->vaddr + (cpa->numpages * PAGE_SIZE)));
>> +
>> +	asi_cpa.pgd = asi_nonsensitive_pgd;
>> +	asi_cpa.curpage = 0;
>
> Please document what functionality this curpage=0 has. It's not clear.

Ack, I'll add some commentary.

>> +	return __change_page_attr(cpa, primary);
>> +}
>
> But let's say someone is doing something silly like:
>
> 	set_memory_np(addr, size);
> 	set_memory_p(addr, size);
>
> Won't that end up in here and make the "unrestricted PGD" have
> _PAGE_PRESENT==1 entries?

Er, yes, that's a bug, thanks for pointing this out. I guess this is
actually broken under debug_pagealloc or something? I should check that.

This code should only mirror the bits that are irrelevant to ASI. 

> Also, could we try and make the nomenclature consistent? We've got
> "unrestricted direct map" and "asi_nonsensitive_pgd" being used (at
> least). Could the terminology be made more consistent?

Hm. It is actually consistent: "unrestricted" is a property of the
address space / execution context. "nonsensitive" is a property of the
memory. Nonsensitive memory is mapped into the unrestricted address
space. asi_nonsensitive_pgd isn't an address space we enter it's just a
holding area (like if we never actually pointed CR3 at init_mm.pgd but
just useed it as a source to clone from).

However.. just because it's consistent doesn't mean it's not confusing.
Do you think we should just squash these two words and call the whole
thing "nonsensitive"? I don't know if "nonsensitive address space" makes
much sense... Is it possible I can fix this by just adding more
comments?

> One subtle thing here is that it's OK to allocate memory here when
> mirroring changes into 'asi_nonsensitive_pgd'. It's just not OK when
> flipping sensitivity. That seems worth a comment.

Ack, will add that.

>>  static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
>>  {
>>  	unsigned long numpages = cpa->numpages;
>> @@ -2007,6 +2033,8 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
>>  		if (!debug_pagealloc_enabled())
>>  			spin_lock(&cpa_lock);
>>  		ret = __change_page_attr(cpa, primary);
>> +		if (!ret)
>> +			ret = mirror_asi_direct_map(cpa, primary);
>>  		if (!debug_pagealloc_enabled())
>>  			spin_unlock(&cpa_lock);
>>  		if (ret)
>> 
>
> Is cpa->pgd ever have any values other than NULL or init_mm->pgd? I
> didn't see anything in a quick grep.

It can also be efi_mm.pgd via sev_es_efi_map_ghcbs_cas().


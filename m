Return-Path: <linux-kernel+bounces-895942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F75C4F52D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 531A034D3F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F8E3730D3;
	Tue, 11 Nov 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huyyrGSt"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764AB3AA1A9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883645; cv=none; b=VjR8b5LRovLiq6yf11NXFq41pETKhG3zkVyoQV6dOF5ep2qbDpIuAZkboW3qQ7Z/lqoUoMsQL/uCXlhDG73r/WKLL3Q6Q5XXrk7dphtJZaS1qzewZj+HGxmVnqAZqvKfLFqCNur+zzXkBnkh0SycfpR4Zf0zJ8E4pyvhEVu60UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883645; c=relaxed/simple;
	bh=wJ56fNFboJSgzZFGGPURDHVJLwzflm+k8qjEcEMl59M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FiZv26PE+/TPaCg8wnS6iy5m8zgQqdGq6I70DD+CyFtxJutnxq5WXfZw8WVIPxUDKisAfP48gpYezFwk0z3kcLq6IokI13eLBuMVyFnwpSCj+911UocyOUCkUn7G1znK4Uc27WBige87pksM89igJibJD2g1XyCOvmNrxJBIE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huyyrGSt; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4777b03b90fso53885e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762883641; x=1763488441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=siZpfgLP5dzbji0XiVCv9b7MoiCCfLbkPmoP4Qg2zlY=;
        b=huyyrGStwLnjLvGYewnaXqTa8K8MgXE2QqxhKYcVJjXXY3f8ZFOeSQRk7tDPVcnNTZ
         ODV6y8pn1UqY/ffTl4D7p5SSXA1MW5PlUN5T9WbaM2rdU9vAQEhE/3tyNhALGOoE3gq0
         2wq4eu4X6LZTyg0TFh0Q07jgXVp9JfLwVrYM/Ef65pJ9fCj1+m+uqUmnnpD1wI/FRg67
         BghZqZg21lHlb2LcYFDgISKTcSMtXV4LKab7Adrkma8pPXWG8YDyvtsDueerkBG7TcKG
         dvxjNpuhpNJc80JNnxP2iTS54NF7PIKXNpXxsh/M+PDLzfrW9mUFnCUrLWT67MTAgs2Z
         ASIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762883641; x=1763488441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=siZpfgLP5dzbji0XiVCv9b7MoiCCfLbkPmoP4Qg2zlY=;
        b=HvmIkqoJhaCoFd6qpXDeTr3tZCyrcRoODlYEJyNjgUCyLIxgBAkBXnyMZHoMH84ehd
         vFKWJnz/DPkai183hHDlmsaf9i6Qc4uiRXL/05XNFe+iNrpKySYyvi8yqZYij8lmS3qH
         lfHlolo3qpiMklBmj9vxSWLJT3Vu1g5lg/m7Xros6LwUpYx+I8d5YgNJVAOxvCBMlc5C
         55RW2GCML6MWwcS83KD2QlvxPlFtXH6Eqj4TTeaaP8xwlWRbPNfiCt+AzPKYvMezcrDt
         +3pdqABqPa27GCEMEeC94MmCueu+9eNVjMkGjASkLiV4tjy6uNZUOZ3ZgwW7S9pTJ7bH
         Hmhw==
X-Forwarded-Encrypted: i=1; AJvYcCXWH3ZjjYhUsVFOK5tsy4A3+c0GnTkjkbvVMuR/D4d3he6ZWRouZPqE5LHDNnAPl5U+BxPoTldUx3ZR4qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEjUzatiQtBvd56FZsPgpOnjUcqQ3t/TohevSKRcla3Gte30B
	PH0rFAO1gDU8TRZu497vZ8h0GhbNjEBHWCBJFwqaTa+wuVnNGaASfxF1DkwGwG5aQ0MiyGmbX6O
	kaDlIH8c310iCxA==
X-Google-Smtp-Source: AGHT+IHnB/R6F1elE6X4v0mXrao282IGqxpFWQpLfCUMAKdx6t7LO867oky5ICmv/qkdodAMAQ3IVjvKrQvXng==
X-Received: from wmgg10.prod.google.com ([2002:a05:600d:a:b0:477:76e1:9b4e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c8a:b0:477:10c4:b4e with SMTP id 5b1f17b1804b1-477871e3943mr2099455e9.41.1762883640647;
 Tue, 11 Nov 2025 09:54:00 -0800 (PST)
Date: Tue, 11 Nov 2025 17:53:59 +0000
In-Reply-To: <20251111145501.GXaRNORRWGIYQ7yFmH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-4-2d861768041f@google.com> <20251111145501.GXaRNORRWGIYQ7yFmH@fat_crate.local>
X-Mailer: aerc 0.21.0
Message-ID: <DE623FVJ73LV.1PIGW7RLYUAX0@google.com>
Subject: Re: [PATCH 04/21] x86/mm/asi: set up asi_nonsensitive_pgd
From: Brendan Jackman <jackmanb@google.com>
To: Borislav Petkov <bp@alien8.de>, Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, <peterz@infradead.org>, 
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>, 
	<akpm@linux-foundation.org>, <david@redhat.com>, <derkling@google.com>, 
	<junaids@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<reijiw@google.com>, <rientjes@google.com>, <rppt@kernel.org>, 
	<vbabka@suse.cz>, <x86@kernel.org>, <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Tue Nov 11, 2025 at 2:55 PM UTC, Borislav Petkov wrote:
> On Wed, Sep 24, 2025 at 02:59:39PM +0000, Brendan Jackman wrote:
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
> This looks weird: so you have some other function - asi_init() - which *must*
> run before this one so that the pgd is allocated. But then you check it here
> and in order to do such a "distributed" init, you export it too.
>
> Instead, I'd simply add a function call here - asi_init_physmap() or whatever
> - which is defined in asi.c and gets *only* called from here. And that
> function returns the pgd or NULL. And then you use phys_pgd_init() on it.

Well, this isn't the only place that refers to asi_nonsensitive_pgd in
this patchset - it's also used as a global from set_memory.c for the
later updates.

Still, you're right about the janky distributed init / setup ordering
issues. So yeah what you suggested with asi_init_physmap() (or whatever
we call it) still makes sense to me, it's just that we'd still have to
export it to set_memory.c

> Also, looking at kernel_map_pages_in_pgd() - and you mentioned set_memory.c
> already - and if I squint my eyes hard enough, it does look like a bunch of
> redundancy between there and init_64.c. But that's nasty code so unifying that
> would be a hard task.

Yeah :/ Some folks pointed out to me that all this logic is kinda
separated between the upper levels of pagetables which are preallocated,
and the lower level ones which are more complicated. So I am still
planning to see if I can come up with some sort of refactoring that only
affects the upper levels.

However, in the meantime I have switched tracks since David H pointed
out an opportunity for me to help out with the guest_memfd stuff [0].
That lets me start getting an interesting subset of this series without
needing any changes to the x86 code just yet.

[0] https://lore.kernel.org/all/20250924151101.2225820-1-patrick.roy@campus.lmu.de/



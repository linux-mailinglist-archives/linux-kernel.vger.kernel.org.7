Return-Path: <linux-kernel+bounces-899626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A35C586F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCE22359C14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C822F5A0B;
	Thu, 13 Nov 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaXIN16e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B32E2E1EF8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047309; cv=none; b=iEJMCrfdE3DgzDZOPM4lGP+ut0j4io0atbW8LRYxWYUMsY1Lc3kHNSE+BsyvAflMT11DkpYDfwkgPkfgWwB835E4Y9eNlFLHP1orv8CPCuLuKsqFWvYt2kV9F+s3H+sCH5ad+DjFjFQo6+YoPSBhbYWIYyKRlXC/7a4TpWW1yTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047309; c=relaxed/simple;
	bh=DDR6lwZeYHTpioGw+6ohDncoc3q5Cexlww6K4aupOIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2KA23kMiCvrPp4+15uK8E3dZWAif4LrJPLtutf9CloyP5oW7ZvWB/2E17tTnNudsWdg+oVrbMbAG4CPmUBytaM3ewGziAHgUC5kGqj2DVZXeY9g2Nbvhay8W+U/V35qRITguaA1Asxcr2k6fPZ6mMGEZWQBPGJiqafFTvaoabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaXIN16e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A83C4CEF7;
	Thu, 13 Nov 2025 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763047307;
	bh=DDR6lwZeYHTpioGw+6ohDncoc3q5Cexlww6K4aupOIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uaXIN16ewn7hEVzRKZDArZ+eJgUCAKSHAt/OloF5MCrMEAN4+PDujpsLttqSSWqVZ
	 mltOkv0VUkTgYtrxwZWW0VuLZG1LR0wC//pusw96qsO51UtUAKmHJP1jkyv+e8zWif
	 oDRaOtAan3PpeL2lp3wJ4mb38iNmLKQEyDAuve9pMq3iIPnjpUH90GV6oMjnaPFzF3
	 5SgxbgErxNpY8LQHDvZme/zp584w4IxmkAR1ibY/hy+lZ9OYnfKhGKJOCBeyRVwGQ2
	 HU14ow4FJeWd7gy6H+MywTHvJzy0KdvvyKRVnAAl3kdlmUJfNnGPKkgFF+fSyBwphb
	 lNQNoU+rFSXGQ==
Message-ID: <3fa6d496-b9de-4b66-a7db-247eebec92ca@kernel.org>
Date: Thu, 13 Nov 2025 16:21:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: fix MAX_FOLIO_ORDER on powerpc configs with
 hugetlb
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Donet Tom
 <donettom@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20251112145632.508687-1-david@kernel.org>
 <eaf2e733-f967-43bb-88e6-7876a28a370c@lucifer.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <eaf2e733-f967-43bb-88e6-7876a28a370c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.25 14:01, Lorenzo Stoakes wrote:
> FYI, trivial to fix but a conflict on mm/Kconfig for mm-new:

Thanks for the review!

Yeah, this fix will have to obviously go in sooner. And it's easy to
resolve.

That's why this patch is already in  mm/mm-hotfixes-unstable.

[...]

> 
> On Wed, Nov 12, 2025 at 03:56:32PM +0100, David Hildenbrand (Red Hat) wrote:
>> In the past, CONFIG_ARCH_HAS_GIGANTIC_PAGE indicated that we support
>> runtime allocation of gigantic hugetlb folios. In the meantime it evolved
>> into a generic way for the architecture to state that it supports
>> gigantic hugetlb folios.
>>
>> In commit fae7d834c43c ("mm: add __dump_folio()") we started using
>> CONFIG_ARCH_HAS_GIGANTIC_PAGE to decide MAX_FOLIO_ORDER: whether we could
> 
> Hm strange commit to introduce this :)

The first commit to be confused about what CONFIG_ARCH_HAS_GIGANTIC_PAGE 
actually means (obviously hugetlb, ... :) ), and which sizes are possible...

[...]

>>
>> To fix it, let's make powerpc select CONFIG_ARCH_HAS_GIGANTIC_PAGE with
>> hugetlb on powerpc, and increase the maximum folio size with hugetlb to 16
>> GiB (possible on arm64 and powerpc). Note that on some powerpc
> 
> I guess this is due to 64 KiB base page possibilities. Fun :)
> 
> Will this cause powerpc to now support gigantic hugetlb pages when it didn't
> before?

It's not really related to 64K IIRC, just the way 
CONFIG_ARCH_FORCE_MAX_ORDER and other things interact with powerpcs ways 
of mapping cont-pmd-like things for hugetlb.

This patch here doesn't change any of that, it just makes us now 
correctly detect that gigantic folios are indeed possible.

> 
>> configurations, whether we actually have gigantic pages
>> depends on the setting of CONFIG_ARCH_FORCE_MAX_ORDER, but there is
>> nothing really problematic about setting it unconditionally: we just try to
>> keep the value small so we can better detect problems in __dump_folio()
>> and inconsistencies around the expected largest folio in the system.
>>
>> Ideally, we'd have a better way to obtain the maximum hugetlb folio size
>> and detect ourselves whether we really end up with gigantic folios. Let's
>> defer bigger changes and fix the warnings first.
> 
> Right.
> 
>>
>> While at it, handle gigantic DAX folios more clearly: DAX can only
>> end up creating gigantic folios with HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD.
> 
> Yes, this is... quite something. Config implying gigantic THP possible but
> actually only relevant to DAX...
> 
>>
>> Add a new Kconfig option HAVE_GIGANTIC_FOLIOS to make both cases
>> clearer. In particular, worry about ARCH_HAS_GIGANTIC_PAGE only with
>> HUGETLB_PAGE.
> 
> Hm, I see:
> 
> config HUGETLB_PAGE
> 	def_bool HUGETLBFS
> 	select XARRAY_MULTI
> 
> 
> Which means (unless I misunderstand Kconfig, very possible :) that this is
> always set if HUGETLBFS is specified.

Yeah, def_bool enforces that both are set.

> Would it be clearer to just check for
> CONFIG_HUGETLBFS?

IMHO, MM code should focus on CONFIG_HUGETLB_PAGE (especially when 
dealing with the page/folio aspects), not the FS part of it.

$ git grep CONFIG_HUGETLB_PAGE | wc -l
45
$ git grep CONFIG_HUGETLBFS | wc -l
7

Unsurprisingly, we are not being completely consistent :)

> 
>>
>> Note: with enabling CONFIG_ARCH_HAS_GIGANTIC_PAGE on powerpc, we will now
>> also allow for runtime allocations of folios in some more powerpc configs.
> 
> Ah OK you're answering the above. I mean I don't think it'll be a problem
> either.
> 
>> I don't think this is a problem, but if it is we could handle it through
>> __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED.
>>
>> While __dump_page()/__dump_folio was also problematic (not handling dumping
>> of tail pages of such gigantic folios correctly), it doesn't relevant
>> critical enough to mark it as a fix.
> 
> Small typo 'it doesn't relevant critical enough' -> 'it doesn't seem
> critical enough' perhaps? Doesn't really matter, only fixup if respin or
> easy for Andrew to fix.

Ah yes, thanks.

> 
> Are you planning to do follow ups then I guess?

As time permits, I think this all needs to be reworked :(

[...]

>> @@ -137,6 +137,7 @@ config PPC
>>   	select ARCH_HAS_DMA_OPS			if PPC64
>>   	select ARCH_HAS_FORTIFY_SOURCE
>>   	select ARCH_HAS_GCOV_PROFILE_ALL
>> +	select ARCH_HAS_GIGANTIC_PAGE		if ARCH_SUPPORTS_HUGETLBFS
> 
> Given we know the architecture can support it (presumably all powerpc
> arches or all that can support hugetlbfs anyway?), this seems reasonable.

powerpc allows for quite some different configs, so I assume there are 
some configs that don't allow ARCH_SUPPORTS_HUGETLBFS.

[...]

>>   /*
>>    * There is no real limit on the folio size. We limit them to the maximum we
>> - * currently expect (e.g., hugetlb, dax).
>> + * currently expect: with hugetlb, we expect no folios larger than 16 GiB.
> 
> Maybe worth saying 'see CONFIG_HAVE_GIGANTIC_FOLIOS definition' or something?

To me that's implied from the initial ifdef. But not strong opinion 
about spelling that out.

> 
>> + */
>> +#define MAX_FOLIO_ORDER		get_order(SZ_16G)
> 
> Hmm, is the base page size somehow runtime adjustable on powerpc? Why isn't
> PUD_ORDER good enough here?

We tried P4D_ORDER but even that doesn't work. I think we effectively 
end up with cont-pmd/cont-PUD mappings (or even cont-p4d, I am not 100% 
sure because the folding code complicates that).

See powerpcs variant of huge_pte_alloc() where we have stuff like

p4d = p4d_offset(pgd_offset(mm, addr), addr);
if (!mm_pud_folded(mm) && sz >= P4D_SIZE)
	return (pte_t *)p4d;

As soon as we go to things like P4D_ORDER we're suddenly in the range of 
512 GiB on x86 etc, so that's also not what we want as an easy fix. (and 
it didn't work)

> 
> Or does powerpc have some way of getting 16 GiB gigantic pages even with 4
> KiB base page size?

IIUC, yes.

Take a look at MMU_PAGE_16G.

There is MMU_PAGE_64G already defined, but it's essentially unused for now.

> 
>> +#else
>> +/*
>> + * Without hugetlb, gigantic folios that are bigger than a single PUD are
>> + * currently impossible.
>>    */
>>   #define MAX_FOLIO_ORDER		PUD_ORDER
>>   #endif
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 0e26f4fc8717b..ca3f146bc7053 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -908,6 +908,13 @@ config PAGE_MAPCOUNT
>>   config PGTABLE_HAS_HUGE_LEAVES
>>   	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
>>
>> +#
>> +# We can end up creating gigantic folio.
>> +#
>> +config HAVE_GIGANTIC_FOLIOS
>> +	def_bool (HUGETLB_PAGE && ARCH_HAS_GIGANTIC_PAGE) || \
>> +		 (ZONE_DEVICE && HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> 
> Maybe worth spelling out in a comment these two cases?

Not sure if the comments wouldn't just explain what we are reading?

"gigantic folios with hugetlb, PUD-sized folios with ZONE_DEVICE"?

-- 
Cheers

David


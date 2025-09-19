Return-Path: <linux-kernel+bounces-824202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009AEB885C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A677ADCA4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224830507B;
	Fri, 19 Sep 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BmeGBByU"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0B26529A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269670; cv=none; b=lNS8YQRNK0+jefPcOW7Axf7AM+I4dom0YNulFWljunjLg9lcyeBGnS1mvImYZBkxkyqZc1s5hB/iD+M0bYLX1EOxo6cGWoRXyXatD1YR4ItfbH8dqP93FHEDsz3zoIuJMnZEDb8yOv7OkGwUZbh5Do+lmILOI5734mhGuT+rUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269670; c=relaxed/simple;
	bh=Nhi3iO5jbSaTidCetxGiiL9mF3Bxbx5GuQv0/+Svhn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGMg3jph67N/XrMLxAaLbudSiI3lmB9vtgZkOB1j+LorpUeMCSHoH7FyAn022UHE+tX73UFiqQrS/kVPmad3EpNYd0wXsIdo4yuN0muH8Leou2a2Fujn7GLzx8hh+vWvMlxws++GHDZZurCYWaTzy2subVcjGAaZnS66lAMPJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BmeGBByU; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4cf41cd5-e93a-412b-b209-4180bd2d4015@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758269664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dc53JcOzdrcUIu2iVuDKY0KAeJ//x1/I8rOfO8TAJ0E=;
	b=BmeGBByUETlTGTM2SzKN9sT+aElM0iDnr9NVCQ0Y4S5LyZS5qVFjUY0/ZQhQcjxmkujkwF
	lcqoAIrEgGu+qx5juQO8M0lGpLChTPtWmm4PXKC8zXPXthowkvLtjPKwUnGPeV4fEL7kE5
	GoVQEabwufMTPdzDfKN5emTG80lC0C8=
Date: Fri, 19 Sep 2025 16:14:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/6] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "usamaarif642@gmail.com" <usamaarif642@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "yuzhao@google.com" <yuzhao@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 =?UTF-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
 "npache@redhat.com" <npache@redhat.com>, "rppt@kernel.org"
 <rppt@kernel.org>, "willy@infradead.org" <willy@infradead.org>,
 "kernel-team@meta.com" <kernel-team@meta.com>,
 "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "cerasuolodomenico@gmail.com" <cerasuolodomenico@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ryncsn@gmail.com" <ryncsn@gmail.com>, "surenb@google.com"
 <surenb@google.com>, "riel@surriel.com" <riel@surriel.com>,
 "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
 =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
 <chinwen.chang@mediatek.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "baohua@kernel.org" <baohua@kernel.org>,
 "kaleshsingh@google.com" <kaleshsingh@google.com>,
 "zhais@google.com" <zhais@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
 <20240830100438.3623486-3-usamaarif642@gmail.com>
 <a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com>
 <434c092b-0f19-47bf-a5fa-ea5b4b36c35e@redhat.com>
 <CABzRoyYWQMFTGYgfC7N=cWMnL_+5Y05=jrMhFjBf1aKOGxzq5g@mail.gmail.com>
 <ebedc478-7519-4e30-854e-f6616a7647b0@redhat.com>
 <120445c8-7250-42e0-ad6a-978020c8fad3@linux.dev>
 <9d2c3e3e-439d-4695-b7c9-21fa52f48ced@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <9d2c3e3e-439d-4695-b7c9-21fa52f48ced@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/19 15:55, David Hildenbrand wrote:
>>> I think where possible we really only want to identify problematic
>>> (tagged) pages and skip them. And we should either look into fixing KSM
>>> as well or finding out why KSM is not affected.
>>
>> Yeah. Seems like we could introduce a new helper,
>> folio_test_mte_tagged(struct
>> folio *folio). By default, it would return false, and architectures like
>> arm64
>> can override it.
> 
> If we add a new helper it should instead express the semantics that we 
> cannot deduplicate.

Agreed.

> 
> For THP, I recall that only some pages might be tagged. So likely we 
> want to check per page.

Yes, a per-page check would be simpler.

> 
>>
>> Looking at the code, the PG_mte_tagged flag is not set for regular THP.
> 
> I think it's supported for THP per page. Only for hugetlb we tag the 
> whole thing through the head page instead of individual pages.

Right. That's exactly what I meant.

> 
>> The MTE
>> status actually comes from the VM_MTE flag in the VMA that maps it.
>>
> 
> During the rmap walk we could check the VMA flag, but there would be no 
> way to just stop the THP shrinker scanning this page early.
> 
>> static inline bool folio_test_hugetlb_mte_tagged(struct folio *folio)
>> {
>>     bool ret = test_bit(PG_mte_tagged, &folio->flags.f);
>>
>>     VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
>>
>>     /*
>>      * If the folio is tagged, ensure ordering with a likely subsequent
>>      * read of the tags.
>>      */
>>     if (ret)
>>         smp_rmb();
>>     return ret;
>> }
>>
>> static inline bool page_mte_tagged(struct page *page)
>> {
>>     bool ret = test_bit(PG_mte_tagged, &page->flags.f);
>>
>>     VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
>>
>>     /*
>>      * If the page is tagged, ensure ordering with a likely subsequent
>>      * read of the tags.
>>      */
>>     if (ret)
>>         smp_rmb();
>>     return ret;
>> }
>>
>> contpte_set_ptes()
>>     __set_ptes()
>>         __set_ptes_anysz()
>>             __sync_cache_and_tags()
>>                 mte_sync_tags()
>>                     set_page_mte_tagged()
>>
>> Then, having the THP shrinker skip any folios that are identified as
>> MTE-tagged.
> 
> Likely we should just do something like (maybe we want better naming)
> 
> #ifndef page_is_mergable
> #define page_is_mergable(page) (true)
> #endif


Maybe something like page_is_optimizable()? Just a thought ;p

> 
> And for arm64 have it be
> 
> #define page_is_mergable(page) (!page_mte_tagged(page))
> 
> 
> And then do
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1f0813b956436..1cac9093918d6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4251,7 +4251,8 @@ static bool thp_underused(struct folio *folio)
> 
>          for (i = 0; i < folio_nr_pages(folio); i++) {
>                  kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
> -               if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
> +               if (page_is_mergable(folio_page(folio, i)) &&
> +                   !memchr_inv(kaddr, 0, PAGE_SIZE)) {
>                          num_zero_pages++;
>                          if (num_zero_pages > khugepaged_max_ptes_none) {
>                                  kunmap_local(kaddr);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 946253c398072..476a9a9091bd3 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -306,6 +306,8 @@ static bool try_to_map_unused_to_zeropage(struct 
> page_vma_mapped_walk *pvmw,
> 
>          if (PageCompound(page))
>                  return false;
> +       if (!page_is_mergable(page))
> +               return false;
>          VM_BUG_ON_PAGE(!PageAnon(page), page);
>          VM_BUG_ON_PAGE(!PageLocked(page), page);
>          VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);

Looks good to me!

> 
> 
> For KSM, similarly just bail out early. But still wondering if this is 
> already checked
> somehow for KSM.

+1 I'm looking for a machine to test it on.



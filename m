Return-Path: <linux-kernel+bounces-824586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5F5B899C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFBD520948
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345B223ABBF;
	Fri, 19 Sep 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLvHzBcn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D92AD16
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287363; cv=none; b=Cf1THk9xw/NeVEBi8+S+gXaIDrl94IyYbMJ9eoQj2QxIVBIDZCDDSv3kzXRKpbHhnWQPagM2o5WiIXWMzGcOwdMyjyqBIcXBKFdb9QhHxL9Zct3jST2SGBvi4dHWxuuZpzKzuXYNqjvoOKJ+aY3XBXidixxy5I3ntjdtot+fye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287363; c=relaxed/simple;
	bh=xKKqepYErRXoXUN7tX1//nGN0JKfkFVo/txdhAsy30A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkE773Mv68SU5Uhxz7tu21fKbutBHiRtIDi8EmokhQqoGL00KKBvQrqcg2wiXv6EYlPGmh6WBY2SlOmlHWkSUroQN0YwvlA1Rzxk35ttrMpsBPwxImYndvdLTOZFIL91qrmvp5r+/PkUCnVjluzHiRPJJuwTB5Wtc57mZv5A5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLvHzBcn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758287359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ovqkR0UKdR/sN2rMZ/4i3G3rJU0T3m7HOdabe1r5GkM=;
	b=GLvHzBcnf0FZk+0oelgD1iPjAUez4FXW5V5NCkkrvV98RdAO7V8Kg752fEaruIfNMEMp4P
	i+6OBJm7VyPbBn2XC0EVDpDGwhWRmeZDvhVAsG3JhS36YreJIRZ7C6OaViPARUMO+GqO6N
	WXjRaaUsUMvriVjv7l4yju1XgsmPmPo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-kLMn9PfWMW6mRL-Fk_ubbQ-1; Fri, 19 Sep 2025 09:09:18 -0400
X-MC-Unique: kLMn9PfWMW6mRL-Fk_ubbQ-1
X-Mimecast-MFC-AGG-ID: kLMn9PfWMW6mRL-Fk_ubbQ_1758287357
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4687ad5c341so6483985e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287357; x=1758892157;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovqkR0UKdR/sN2rMZ/4i3G3rJU0T3m7HOdabe1r5GkM=;
        b=QtcBpWebTSA8qBUIhKWtG2gXnKxWdv9nj3fvjIzr3WLaVztFTPK7M2ku44fA1ABhI7
         vTAupN+yuOLfc8xh6ISN+iagF3Eux+yLQSGmMCeUdeGqfeFaHb4riaz4/0jqLDzFEWcO
         /PjVCuByGUajWT4/y8xuKVPlvbeJudVy6x0SG05/4hANknw9pjXGQYJcHi8FM39s7rV3
         MQ0dsIp5UxewP+ubOR6sR9qdioB+yJ87JP88w9IVW5gNEjJtQfpv1TDEcMjrb34k/cIh
         vEROGcj+4SKfowBRJOTDjInpoM3FLwtOOVkxt1kMQcNKHFbX+UO4Bvo5deny3oh8DXgc
         VrgA==
X-Forwarded-Encrypted: i=1; AJvYcCWbijmvrYB69/yx7kuPvseJS5vZcS102DT3Di3e13ygiL2Kq/jdrR2GaUjOid+bX7P3qA1um/SITz5TwQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAshTY4L/2WbXDcN5aKAIy6029KbbagWJ/2tkbBlBcXce4ikJ2
	uj0ORNhuEvOuPrUzCvsQMoTVy0csbfhdWHOHG0/sV+h+iK4bEDk8715eNOwJjt3CPcIVoAKx2C4
	mEHPRPnW/Qwwl/D5EyY1TEhl5utCn9OZ0zSA4Tuqs5jVi9aHFhmQJrCykXIfWoMgxSA==
X-Gm-Gg: ASbGncvzPtwPkhwvsDzM1c5LFJWlmSMI5FzjP6YM3iI4Xq633DcTPkEKPHutPwpwWTK
	dndRmFKmAC6HD1CAlSFPwjlCQKWL8PtoGTSYMse810xjo4j0vY1dx3PG2bt0+efso9u+tQSj9jv
	C0E9WWBobZFeWxphWv3fGmNtoL0ZvnxZ+uPEHbEXw7IOu4URhTeil1Hov0jqG9cCEel0wB3GIog
	gmpukqn+UcSA97f2dSOrQZJb/MHnzZ1SpgxD7Bn3mZT5pwd/Ukh3htfouQHDfHN58qeKPJouLfj
	mf+AIjgVd6fJeR5O5FhX84/M/obfBz5joq9zz2mnH5rqGRmAU3jG6Nn4lK3LcfVcSg+4ynQb55e
	N4s+RxtyWUHh63Rf1JolKiMXfL9XY0tB/lNMuEv/oqCj+jwbEr+5brPnHGmAfuj20XnZr
X-Received: by 2002:a05:600c:4f52:b0:468:9798:2043 with SMTP id 5b1f17b1804b1-46961fce431mr17004675e9.26.1758287356789;
        Fri, 19 Sep 2025 06:09:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4GRr8aem06VfxNDntrn8WqDyw/HDHqGfVNfE4MfkYd1AhW83MBNY5XfwK4pa+JSgBQolhAA==
X-Received: by 2002:a05:600c:4f52:b0:468:9798:2043 with SMTP id 5b1f17b1804b1-46961fce431mr17004045e9.26.1758287356216;
        Fri, 19 Sep 2025 06:09:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:5600:727b:b2f6:94a1:a51b? (p200300d82f235600727bb2f694a1a51b.dip0.t-ipconnect.de. [2003:d8:2f23:5600:727b:b2f6:94a1:a51b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f1549285c9sm1179821f8f.52.2025.09.19.06.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 06:09:15 -0700 (PDT)
Message-ID: <ca2106a3-4bb2-4457-81af-301fd99fbef4@redhat.com>
Date: Fri, 19 Sep 2025 15:09:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
To: Lance Yang <lance.yang@linux.dev>
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
 <4cf41cd5-e93a-412b-b209-4180bd2d4015@linux.dev>
 <dfb303b9-151b-49ec-b7ef-691c71bd5385@linux.dev>
 <9395a9ca-d865-42d7-9ea1-8e693e4e38e0@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9395a9ca-d865-42d7-9ea1-8e693e4e38e0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.09.25 14:19, Lance Yang wrote:
> Hey David,
> 
> I believe I've found the exact reason why KSM skips MTE-tagged pages ;p
> 
>>
>>
>> On 2025/9/19 16:14, Lance Yang wrote:
>>>
>>>
>>> On 2025/9/19 15:55, David Hildenbrand wrote:
>>>>>> I think where possible we really only want to identify problematic
>>>>>> (tagged) pages and skip them. And we should either look into fixing
>>>>>> KSM
>>>>>> as well or finding out why KSM is not affected.
>>>>>
>>>>> Yeah. Seems like we could introduce a new helper,
>>>>> folio_test_mte_tagged(struct
>>>>> folio *folio). By default, it would return false, and architectures
>>>>> like
>>>>> arm64
>>>>> can override it.
>>>>
>>>> If we add a new helper it should instead express the semantics that
>>>> we cannot deduplicate.
>>>
>>> Agreed.
>>>
>>>>
>>>> For THP, I recall that only some pages might be tagged. So likely we
>>>> want to check per page.
>>>
>>> Yes, a per-page check would be simpler.
>>>
>>>>
>>>>>
>>>>> Looking at the code, the PG_mte_tagged flag is not set for regular THP.
>>>>
>>>> I think it's supported for THP per page. Only for hugetlb we tag the
>>>> whole thing through the head page instead of individual pages.
>>>
>>> Right. That's exactly what I meant.
>>>
>>>>
>>>>> The MTE
>>>>> status actually comes from the VM_MTE flag in the VMA that maps it.
>>>>>
>>>>
>>>> During the rmap walk we could check the VMA flag, but there would be
>>>> no way to just stop the THP shrinker scanning this page early.
>>>>
>>>>> static inline bool folio_test_hugetlb_mte_tagged(struct folio *folio)
>>>>> {
>>>>>      bool ret = test_bit(PG_mte_tagged, &folio->flags.f);
>>>>>
>>>>>      VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
>>>>>
>>>>>      /*
>>>>>       * If the folio is tagged, ensure ordering with a likely subsequent
>>>>>       * read of the tags.
>>>>>       */
>>>>>      if (ret)
>>>>>          smp_rmb();
>>>>>      return ret;
>>>>> }
>>>>>
>>>>> static inline bool page_mte_tagged(struct page *page)
>>>>> {
>>>>>      bool ret = test_bit(PG_mte_tagged, &page->flags.f);
>>>>>
>>>>>      VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
>>>>>
>>>>>      /*
>>>>>       * If the page is tagged, ensure ordering with a likely subsequent
>>>>>       * read of the tags.
>>>>>       */
>>>>>      if (ret)
>>>>>          smp_rmb();
>>>>>      return ret;
>>>>> }
>>>>>
>>>>> contpte_set_ptes()
>>>>>      __set_ptes()
>>>>>          __set_ptes_anysz()
>>>>>              __sync_cache_and_tags()
>>>>>                  mte_sync_tags()
>>>>>                      set_page_mte_tagged()
>>>>>
>>>>> Then, having the THP shrinker skip any folios that are identified as
>>>>> MTE-tagged.
>>>>
>>>> Likely we should just do something like (maybe we want better naming)
>>>>
>>>> #ifndef page_is_mergable
>>>> #define page_is_mergable(page) (true)
>>>> #endif
>>>
>>>
>>> Maybe something like page_is_optimizable()? Just a thought ;p
>>>
>>>>
>>>> And for arm64 have it be
>>>>
>>>> #define page_is_mergable(page) (!page_mte_tagged(page))
>>>>
>>>>
>>>> And then do
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 1f0813b956436..1cac9093918d6 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -4251,7 +4251,8 @@ static bool thp_underused(struct folio *folio)
>>>>
>>>>           for (i = 0; i < folio_nr_pages(folio); i++) {
>>>>                   kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
>>>> -               if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
>>>> +               if (page_is_mergable(folio_page(folio, i)) &&
>>>> +                   !memchr_inv(kaddr, 0, PAGE_SIZE)) {
>>>>                           num_zero_pages++;
>>>>                           if (num_zero_pages >
>>>> khugepaged_max_ptes_none) {
>>>>                                   kunmap_local(kaddr);
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 946253c398072..476a9a9091bd3 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -306,6 +306,8 @@ static bool try_to_map_unused_to_zeropage(struct
>>>> page_vma_mapped_walk *pvmw,
>>>>
>>>>           if (PageCompound(page))
>>>>                   return false;
>>>> +       if (!page_is_mergable(page))
>>>> +               return false;
>>>>           VM_BUG_ON_PAGE(!PageAnon(page), page);
>>>>           VM_BUG_ON_PAGE(!PageLocked(page), page);
>>>>           VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
>>>
>>> Looks good to me!
>>>
>>>>
>>>>
>>>> For KSM, similarly just bail out early. But still wondering if this
>>>> is already checked
>>>> somehow for KSM.
>>>
>>> +1 I'm looking for a machine to test it on.
>>
>> Interestingly, it seems KSM is already skipping MTE-tagged pages. My test,
>> running on a v6.8.0 kernel inside QEMU (with MTE enabled), shows no merging
>> activity for those pages ...
> 
> KSM's call to pages_identical() ultimately leads to memcmp_pages(). The
> arm64 implementation of memcmp_pages() in arch/arm64/kernel/mte.c contains
> a specific check that prevents merging in this case.
> 
> try_to_merge_one_page()
> 	-> pages_identical()
> 		-> !memcmp_pages() Fails!
> 		-> replace_page()
> 
> 
> int memcmp_pages(struct page *page1, struct page *page2)
> {
> 	char *addr1, *addr2;
> 	int ret;
> 
> 	addr1 = page_address(page1);
> 	addr2 = page_address(page2);
> 	ret = memcmp(addr1, addr2, PAGE_SIZE);
> 
> 	if (!system_supports_mte() || ret)
> 		return ret;
> 
> 	/*
> 	 * If the page content is identical but at least one of the pages is
> 	 * tagged, return non-zero to avoid KSM merging. If only one of the
> 	 * pages is tagged, __set_ptes() may zero or change the tags of the
> 	 * other page via mte_sync_tags().
> 	 */
> 	if (page_mte_tagged(page1) || page_mte_tagged(page2))
> 		return addr1 != addr2;
> 
> 	return ret;
> }
> 
> IIUC, if either page is MTE-tagged, memcmp_pages() intentionally returns
> a non-zero value, which in turn causes pages_identical() to return false.

Cool, so we should likely just use that then in the shrinker code. Can 
you send a fix?

-- 
Cheers

David / dhildenb



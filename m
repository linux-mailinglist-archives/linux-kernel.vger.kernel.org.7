Return-Path: <linux-kernel+bounces-727955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A9AB021BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A01FA451C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37C22EF2BA;
	Fri, 11 Jul 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbR/jJOK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DA2EF2A4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251294; cv=none; b=kQybvYe/douj5jRCoRFX/8uZkFrJganAe4iFWGImBHd9GlaBcdVU7isf37X6hV3qFPmD4Y61QV9LPkEN3/HZzhbsBrQTXTrOOtmxpvYcjpPsy+/Mf2Aisnj94mXCElwgUbyLtnq/I9luNoRaRMcWVX1l45/7o0vPy+Lk1W2+KUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251294; c=relaxed/simple;
	bh=bjWEG/BBNJL2h8MVwX2aYK3lXexOTVgAfJTNEX4gyiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8inPFkGj61j6asytSfbweZlF6/JVa2kT73JkN9vvoamKv0tR4PPd1tb1iPyKjB0zy4kRJ9M2K6/BAcONexPWNBKc6b7gMOq4FZfDRhK/foDCf8sugiJLsiJ47DIj8q8rAQzE7xMC9rqHSuifI/rzAYVRj3P7qZSE/HMyU+euz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbR/jJOK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752251288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fWJd+CnUdDV/uKAkKPLkKmaBX3JyB4GaRitllkKh1MQ=;
	b=ZbR/jJOKo0WRLLAT/9C9N9hEUORQgvBLWIrng9SYfPbTtT5A4HYssJ4+sUe8s9xR85bN7U
	K7T2svCyhU6etSKRfxGLhgi8Ypaju2yzteroWQ7S7R/Y6An634eKhD4pnheRRJPQ8atuI1
	tBhVgWmttxs2BnFgI9AFhQyxVblEUKU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-G5_CyrXYN_SKRCuwNX3LcQ-1; Fri, 11 Jul 2025 12:28:07 -0400
X-MC-Unique: G5_CyrXYN_SKRCuwNX3LcQ-1
X-Mimecast-MFC-AGG-ID: G5_CyrXYN_SKRCuwNX3LcQ_1752251286
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso1501654f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251286; x=1752856086;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fWJd+CnUdDV/uKAkKPLkKmaBX3JyB4GaRitllkKh1MQ=;
        b=qpcbJsmRHO4xLFrduNJ+5N871d8uARUPWHVfQqmIFr33nt43qOGy6VSOJGfx+qYyeu
         qGCaO3A9pzdGHka+szLjzGwOrR1bB1H3PIyhgA/RoDQMezT/2FIJ7O++J9/oMhhLzfb3
         BAxkX666RFFnu0GFn6OBuTU5w4VQUVtz0bdKBYDM0vvunWWVmGamc2c1ENyP+5iGnWy8
         vNHhlDLLl3MQx9a9Z9IGT2Bw4XF3skjS/WZavHnbJDqbxWwjLuu5i+3NyBebJhwhTOLx
         k+4CQb6nKmOJrFNTB5T2r90Cw3Ax6Ah7r6IIn5H2mURB7dsxHagd3LT0MFmykYaW4zzn
         ZObg==
X-Forwarded-Encrypted: i=1; AJvYcCXGkZSCI25SkvV7/yy7+aML/7s0/pb1NLyp/SoY60lhv7BKsWmJueNC2zbrfzayJzH6M78594GZDOiy3nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIpnS23i92LD0iobrFYIeMv2UwVoCOgPFJU4dIrmvJ0Nkrwe/r
	N+vkgY2Bq16WuwF7jns7BgplyQzUhj/LA0vfwpdm971A6hN3d9jBI83hAmyabnNGRdVZ+T6pMIZ
	Lk5amXFQda7IgU2Z/Ucphcp+3BOmxc8w3SLpWjNazqe/OLuICKyuD/7ClPzgBOEXGzg==
X-Gm-Gg: ASbGncu5mpsiiLQG15wX/hdbFuN84g7PLsKFDeDs4/hq3Z6EDSS+UNQVzr385mlfHw1
	NK+6zseEOjeFrYFJKS08RnSDgxQNMQMEC9oCQK8s4+CpILD0cnuL8QL//gfwdFcPIKYoGaYVDz9
	r9ueFAAAvsTu5COWWWoJkU7VZomHhwOMoZTKrJBBXwvZSfT3u2/P/ul5T1t0+gZZNBeijMmE+es
	rWc6GYK7YMquFrMAztgXs4HwuGlik5U7NnAhzH4pOoJuRZWF8Ht3wPwu/CTpSOzzFnTl4lcTivQ
	zKhEb4sKOsnrqFidB122Z9cOX6Hc0rxouJLeXRPTBDeG1S1KX4491cptVeM7f5DSl8dbNzgwIsg
	yU5e798W2mUAcYr9RmX1/3FivG/ceVj7Dl58+/8suwiI02d/GWN/eddU1T5GXJNSF7A0=
X-Received: by 2002:a05:6000:42c9:b0:3a4:fc3f:b7fd with SMTP id ffacd0b85a97d-3b5f1868db7mr2525056f8f.19.1752251285885;
        Fri, 11 Jul 2025 09:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvJYBKIreT1YD758/GXs8aVFpMzsAxrGXyvj0Y72QDlEvTumFudxE/yaIxFWY4GkENRbM0BQ==
X-Received: by 2002:a05:6000:42c9:b0:3a4:fc3f:b7fd with SMTP id ffacd0b85a97d-3b5f1868db7mr2525031f8f.19.1752251285270;
        Fri, 11 Jul 2025 09:28:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd43912dsm52112515e9.2.2025.07.11.09.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:28:04 -0700 (PDT)
Message-ID: <0ae2ef3c-b81d-4335-9174-041b5a9c9b14@redhat.com>
Date: Fri, 11 Jul 2025 18:28:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
To: Zi Yan <ziy@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250711030259.3574392-1-ziy@nvidia.com>
 <c7e82a13-aa93-4eb3-8679-29cd32692bd0@redhat.com>
 <2AE055C4-BFFE-4B61-A96A-6DE227422C7B@nvidia.com>
 <3223bd3b-38cc-45d1-8080-d62117df0e85@redhat.com>
 <B9C05B4D-2777-45DC-A229-B4E119B0E9A3@nvidia.com>
 <b38591bb-5827-4e99-97d9-03f74f231c05@redhat.com>
 <0189444A-451E-4DE6-89EF-EB472265F3AA@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0189444A-451E-4DE6-89EF-EB472265F3AA@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.07.25 18:26, Zi Yan wrote:
> On 11 Jul 2025, at 12:03, David Hildenbrand wrote:
> 
>> On 11.07.25 17:40, Zi Yan wrote:
>>> On 11 Jul 2025, at 10:40, David Hildenbrand wrote:
>>>
>>>> On 11.07.25 16:37, Zi Yan wrote:
>>>>> On 11 Jul 2025, at 2:41, David Hildenbrand wrote:
>>>>>
>>>>>> On 11.07.25 05:02, Zi Yan wrote:
>>>>>>> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not related to
>>>>>>> splitting unmapped folio operations. Move them out to the caller, so that
>>>>>>> __split_unmapped_folio() only splits unmapped folios. This makes
>>>>>>> __split_unmapped_folio() reusable.
>>>>>>>
>>>>>>> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
>>>>>>>
>>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>>> ---
>>>>>>> Based on the prior discussion[1], this patch makes
>>>>>>> __split_unmapped_folio() reusable for splitting unmapped folios without
>>>>>>> adding a new boolean unmapped parameter to guard mapping related code.
>>>>>>>
>>>>>>> Another potential benefit is that __split_unmapped_folio() could be
>>>>>>> called on after-split folios by __folio_split() to perform new split
>>>>>>> methods. For example, at deferred split time, unmapped subpages can
>>>>>>> scatter arbitrarily within a large folio, neither uniform nor non-uniform
>>>>>>> split can maximize after-split folio orders for mapped subpages.
>>>>>>> Hopefully, performing __split_unmapped_folio() multiple times can
>>>>>>> achieve the optimal split result.
>>>>>>>
>>>>>>> It passed mm selftests.
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B54845@nvidia.com/
>>>>>>> ---
>>>>>>>
>>>>>>>      mm/huge_memory.c | 275 ++++++++++++++++++++++++-----------------------
>>>>>>>      1 file changed, 139 insertions(+), 136 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>>> index 3eb1c34be601..d97145dfa6c8 100644
>>>>>>> --- a/mm/huge_memory.c
>>>>>>> +++ b/mm/huge_memory.c
>>>>>>> @@ -3396,10 +3396,6 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>>>>>>>       *             order - 1 to new_order).
>>>>>>>       * @split_at: in buddy allocator like split, the folio containing @split_at
>>>>>>>       *            will be split until its order becomes @new_order.
>>>>>>> - * @lock_at: the folio containing @lock_at is left locked for caller.
>>>>>>> - * @list: the after split folios will be added to @list if it is not NULL,
>>>>>>> - *        otherwise to LRU lists.
>>>>>>> - * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
>>>>>>>       * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
>>>>>>>       * @mapping: @folio->mapping
>>>>>>>       * @uniform_split: if the split is uniform or not (buddy allocator like split)
>>>>>>> @@ -3425,51 +3421,27 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>>>>>>>       *    @page, which is split in next for loop.
>>>>>>>       *
>>>>>>>       * After splitting, the caller's folio reference will be transferred to the
>>>>>>> - * folio containing @page. The other folios may be freed if they are not mapped.
>>>>>>> - *
>>>>>>> - * In terms of locking, after splitting,
>>>>>>> - * 1. uniform split leaves @page (or the folio contains it) locked;
>>>>>>> - * 2. buddy allocator like (non-uniform) split leaves @folio locked.
>>>>>>> - *
>>>>>>> + * folio containing @page. The caller needs to unlock and/or free after-split
>>>>>>> + * folios if necessary.
>>>>>>>       *
>>>>>>>       * For !uniform_split, when -ENOMEM is returned, the original folio might be
>>>>>>>       * split. The caller needs to check the input folio.
>>>>>>>       */
>>>>>>>      static int __split_unmapped_folio(struct folio *folio, int new_order,
>>>>>>> -		struct page *split_at, struct page *lock_at,
>>>>>>> -		struct list_head *list, pgoff_t end,
>>>>>>> -		struct xa_state *xas, struct address_space *mapping,
>>>>>>> -		bool uniform_split)
>>>>>>> +				  struct page *split_at, struct xa_state *xas,
>>>>>>> +				  struct address_space *mapping,
>>>>>>> +				  bool uniform_split)
>>>>>>
>>>>>> Use two-tabs indent please (like we already do, I assume).
>>>>>
>>>>> OK. I was using clang-format. It gave me this indentation.
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> @@ -3706,11 +3599,14 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>      {
>>>>>>>      	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>>>>>>>      	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>>>>> +	struct folio *next_folio = folio_next(folio);
>>>>>>>      	bool is_anon = folio_test_anon(folio);
>>>>>>>      	struct address_space *mapping = NULL;
>>>>>>>      	struct anon_vma *anon_vma = NULL;
>>>>>>>      	int order = folio_order(folio);
>>>>>>> +	struct folio *new_folio, *next;
>>>>>>>      	int extra_pins, ret;
>>>>>>> +	int nr_shmem_dropped = 0;
>>>>>>>      	pgoff_t end;
>>>>>>>      	bool is_hzp;
>>>>>>>     @@ -3833,13 +3729,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>      		 */
>>>>>>>      		xas_lock(&xas);
>>>>>>>      		xas_reset(&xas);
>>>>>>> -		if (xas_load(&xas) != folio)
>>>>>>> +		if (xas_load(&xas) != folio) {
>>>>>>> +			ret = -EAGAIN;
>>>>>>>      			goto fail;
>>>>>>> +		}
>>>>>>>      	}
>>>>>>>       	/* Prevent deferred_split_scan() touching ->_refcount */
>>>>>>>      	spin_lock(&ds_queue->split_queue_lock);
>>>>>>>      	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>>>>>>> +		struct address_space *swap_cache = NULL;
>>>>>>> +		struct lruvec *lruvec;
>>>>>>> +
>>>>>>>      		if (folio_order(folio) > 1 &&
>>>>>>>      		    !list_empty(&folio->_deferred_list)) {
>>>>>>>      			ds_queue->split_queue_len--;
>>>>>>> @@ -3873,18 +3774,120 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>      			}
>>>>>>>      		}
>>>>>>>     -		ret = __split_unmapped_folio(folio, new_order,
>>>>>>> -				split_at, lock_at, list, end, &xas, mapping,
>>>>>>> -				uniform_split);
>>>>>>> +		if (folio_test_swapcache(folio)) {
>>>>>>> +			if (mapping) {
>>>>>>> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
>>>>>>> +				ret = -EINVAL;
>>>>>>> +				goto fail;
>>>>>>> +			}
>>>>>>> +
>>>>>>> +			/*
>>>>>>> +			 * a swapcache folio can only be uniformly split to
>>>>>>> +			 * order-0
>>>>>>> +			 */
>>>>>>> +			if (!uniform_split || new_order != 0) {
>>>>>>> +				ret = -EINVAL;
>>>>>>> +				goto fail;
>>>>>>> +			}
>>>>>>> +
>>>>>>> +			swap_cache = swap_address_space(folio->swap);
>>>>>>> +			xa_lock(&swap_cache->i_pages);
>>>>>>> +		}
>>>>>>> +
>>>>>>> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>>>>>>> +		lruvec = folio_lruvec_lock(folio);
>>>>>>> +
>>>>>>> +		ret = __split_unmapped_folio(folio, new_order, split_at, &xas,
>>>>>>> +					     mapping, uniform_split);
>>>>>>> +
>>>>>>> +		/*
>>>>>>> +		 * Unfreeze after-split folios and put them back to the right
>>>>>>> +		 * list. @folio should be kept frozon until page cache entries
>>>>>>> +		 * are updated with all the other after-split folios to prevent
>>>>>>> +		 * others seeing stale page cache entries.
>>>>>>> +		 */
>>>>>>> +		for (new_folio = folio_next(folio); new_folio != next_folio;
>>>>>>> +		     new_folio = next) {
>>>>>>> +			next = folio_next(new_folio);
>>>>>>> +
>>>>>>> +			folio_ref_unfreeze(
>>>>>>> +				new_folio,
>>>>>>> +				1 + ((mapping || swap_cache) ?
>>>>>>> +					     folio_nr_pages(new_folio) :
>>>>>>> +					     0));
>>>>>>
>>>>>> While we are at it, is a way to make this look less than an artistic masterpiece? :)
>>>>>>
>>>>>> expected_refs = ...
>>>>>> folio_ref_unfreeze(new_folio, expected_refs).
>>>>>>
>>>>>>
>>>>>> Can we already make use of folio_expected_ref_count() at that point? Mapcount should be 0 and the folio should be properly setup (e.g., anon, swapcache) IIRC.
>>>>>>
>>>>>> So maybe
>>>>>>
>>>>>> expected_refs = folio_expected_ref_count(new_folio) + 1;
>>>>>> folio_ref_unfreeze(new_folio, expected_refs).
>>>>>>
>>>>>> Would do?
>>>>>
>>>>> I think so. Even further, I think we probably can get rid of can_split_folio()’s
>>>>> pextra_pins and use folio_expected_ref_count() too.
>>>>
>>>> That will only do the right think if we know that the folio is not mapped and that there is no way it can get mapped concurrently.
>>>>
>>>> Otherwise, when freezing, we might ignore a mapping (where we should fail freezing).
>>>
>>> You mean between unmap_folio() and folio_ref_freeze(), a concurrent mapping
>>> happens? So that what folio_expected_ref_count() returns has
>>> folio_mapcount() != 0. You are right. Thanks.
>>
>> Right, but maybe locking prevents that.
>>
>> E.g., a locked anon folio cannot get migrated or swapped in. So the mapcount cannot increase once locked. If already mapped, fork() could duplicate mappings, but in that case there would be at least one mapping already.
>>
>> For the pagecache, I think we always map a folio with the folio lock held: see filemap_map_pages().
>>
>> So *maybe* just checking folio_mapped() before trying to freeze could be good enough, arguing that the mapcount cannot go from 0 -> !0 while the folio is locked.
> 
> Yes, but this is very subtle and fragile. I will keep the code unchanged for
> now. :)

Please clean up that multi-line madness, though ;)

-- 
Cheers,

David / dhildenb



Return-Path: <linux-kernel+bounces-727884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CCAB02112
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9168BA40AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F502ED859;
	Fri, 11 Jul 2025 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZY0l1G2i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E71A0BF3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249801; cv=none; b=Zy8cOJjtoec7dquEQ6ApnC90XVsFii3xg02mxJvIK7jaw8o2S9WsrqtPuh3dLaHFm3W/4X7vvnok1aFYer3z4rpPrvcNLXeiT0Hcg8pJyCCGOjGChEl7xX/5x3q9fjSck3cURqJnyI2tGbUQMMUysVPeD3drELFY9qiDqrbNcco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249801; c=relaxed/simple;
	bh=D3e96QP3mLvAudwmc4PfQsc0lbN0SJRJBnQ5mDz6R9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSUGVM2892Q70Z5vo1gDhoPH8/yKb+8HSbjsI3rWE3iesY2dmiGbxRC+H8rZGAEtdf2Mk4x35uHAMuv2uthWTVn91/VbKruUiCyXvPS9LTP0z7kowFarSr9vrXoWcr5c8lQFnq9dcjWMInS0ifFc20QSgyTwW8MN+B3RXLzTI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZY0l1G2i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752249798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=puVwQL05qd8EEwgC9v5NZXyKB2mpvAnWAfFUVhQ5+Wk=;
	b=ZY0l1G2iWW41r2CAhRnqUgYj3ARDuqeJLYUzcbmLr+9c5WiHyLRiAM9OupO5G1onjUv9qV
	cXSf+Rh5q1xUVIvoEy6NlHVKSJ1vpp7dG7Z0RGC+389Q2Pl6vNIxOALcTj5GXGbeQc12yK
	wfVr3/pSIS7Ui5+1/lfKwinDKrWaZrw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-MVcfUXbQM8yDhFb_9eGe6Q-1; Fri, 11 Jul 2025 12:03:15 -0400
X-MC-Unique: MVcfUXbQM8yDhFb_9eGe6Q-1
X-Mimecast-MFC-AGG-ID: MVcfUXbQM8yDhFb_9eGe6Q_1752249794
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4538f375e86so18036285e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249794; x=1752854594;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=puVwQL05qd8EEwgC9v5NZXyKB2mpvAnWAfFUVhQ5+Wk=;
        b=mVVID+2z//y/iblwpHS3SgHzMJjsdrFatOutIO3kEjYeJ4H1nAFaB3bFY70J8JKDXy
         ZoF2i/Wj6zEeb0CYIuPZjvwHFbkcFenQwY0u6bpoDQKOmQfhLhGBUETurNwlOqKJphNf
         T+Btar1/8QHuIEm4M6YvlkzSvDtz3jPyXUZ1JYdF0M0Td1UJSPS7U+eBeNdmAZyIFnuY
         FydD+BJExXFOZPwLFyXHT8oqRuRpUd6r8pMh2W7SMF1NqLWOTn5yhnYWOVSzy4nl07uu
         sG9DRdAMkJMRCUtLAETLRTUXx75RzZIFIaDSpE/rDwFrUK9GJHbMDbtJy1Ltzj43MsHV
         LA7A==
X-Forwarded-Encrypted: i=1; AJvYcCWtopAtNrqMuGhsfueCDOaSEQ9fZrt+IyI/h5p1UiEA1V8HmcIqaDh/NH9GqhD02kJiucEMg6o4mujaZPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNxgfVsguhplpY+XMPmh4POOHtZwjGGTpLSvCs+n7hoa5vgcA
	3JPnILUJUn/guF/MFswG9xIQyaJRs2tI4gkZzq8qV9zcPT0Q1al0vWzboo6K81Lu/XpxPdD/XAk
	teLjcl8RaBV1l0sRBUMzd5HTf2WZz/bhTBs+jU0w4ffGYrMso9hVpMfui8gY4Yin6Aw==
X-Gm-Gg: ASbGncuwdK04T2C+34cI9cmGsPGtiMpLIYAmy1QUJiyRhDLXK/NbwH3grgx88QY7Uat
	R2u5REcZ92O99UaQRfZrkx0WamCDXEjcP7Gvx4Yi15Rp/qPho3XlvhQ42nnSoLwOHNpm29kark/
	l64x/b2XuN6bBf7OBMgUkGSiMSS53yRhl9gF5RcF5mAnSq24/Rxua0PXM6TlRkAp9KfbyKlR8BH
	aZqVG/uj9S9dveQPOICwm8GT75mza4V1HS0kYxlVANU5yEgD7nOfsCg7uB1NtFFds0+JMwnxdyU
	pgGk9SJAvgIt12B0IsnOt06TdmIEfPD8MnBg3jlEF+t+bab2pqnKY/JXC/+uXNz9uXSnZ+qGqHQ
	gQzt/aCGSxIKPfyXN1VW8Njr9lBBpkWqYgGpRBTGb7lD8cXRCo2nqH20UGblJRu62stM=
X-Received: by 2002:a05:600c:1d98:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-454ec140088mr43816975e9.14.1752249791926;
        Fri, 11 Jul 2025 09:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEXR2qC4ojmg/Msw/Xcv+JPJKO/J68SF+dBoWA2RVsNRRsANbIhVlYqEBoFsKj0KLatOOO9w==
X-Received: by 2002:a05:600c:1d98:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-454ec140088mr43812745e9.14.1752249789076;
        Fri, 11 Jul 2025 09:03:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50fb874sm91231575e9.28.2025.07.11.09.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:03:08 -0700 (PDT)
Message-ID: <b38591bb-5827-4e99-97d9-03f74f231c05@redhat.com>
Date: Fri, 11 Jul 2025 18:03:07 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <B9C05B4D-2777-45DC-A229-B4E119B0E9A3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.07.25 17:40, Zi Yan wrote:
> On 11 Jul 2025, at 10:40, David Hildenbrand wrote:
> 
>> On 11.07.25 16:37, Zi Yan wrote:
>>> On 11 Jul 2025, at 2:41, David Hildenbrand wrote:
>>>
>>>> On 11.07.25 05:02, Zi Yan wrote:
>>>>> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not related to
>>>>> splitting unmapped folio operations. Move them out to the caller, so that
>>>>> __split_unmapped_folio() only splits unmapped folios. This makes
>>>>> __split_unmapped_folio() reusable.
>>>>>
>>>>> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>> Based on the prior discussion[1], this patch makes
>>>>> __split_unmapped_folio() reusable for splitting unmapped folios without
>>>>> adding a new boolean unmapped parameter to guard mapping related code.
>>>>>
>>>>> Another potential benefit is that __split_unmapped_folio() could be
>>>>> called on after-split folios by __folio_split() to perform new split
>>>>> methods. For example, at deferred split time, unmapped subpages can
>>>>> scatter arbitrarily within a large folio, neither uniform nor non-uniform
>>>>> split can maximize after-split folio orders for mapped subpages.
>>>>> Hopefully, performing __split_unmapped_folio() multiple times can
>>>>> achieve the optimal split result.
>>>>>
>>>>> It passed mm selftests.
>>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B54845@nvidia.com/
>>>>> ---
>>>>>
>>>>>     mm/huge_memory.c | 275 ++++++++++++++++++++++++-----------------------
>>>>>     1 file changed, 139 insertions(+), 136 deletions(-)
>>>>>
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index 3eb1c34be601..d97145dfa6c8 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -3396,10 +3396,6 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>>>>>      *             order - 1 to new_order).
>>>>>      * @split_at: in buddy allocator like split, the folio containing @split_at
>>>>>      *            will be split until its order becomes @new_order.
>>>>> - * @lock_at: the folio containing @lock_at is left locked for caller.
>>>>> - * @list: the after split folios will be added to @list if it is not NULL,
>>>>> - *        otherwise to LRU lists.
>>>>> - * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
>>>>>      * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
>>>>>      * @mapping: @folio->mapping
>>>>>      * @uniform_split: if the split is uniform or not (buddy allocator like split)
>>>>> @@ -3425,51 +3421,27 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>>>>>      *    @page, which is split in next for loop.
>>>>>      *
>>>>>      * After splitting, the caller's folio reference will be transferred to the
>>>>> - * folio containing @page. The other folios may be freed if they are not mapped.
>>>>> - *
>>>>> - * In terms of locking, after splitting,
>>>>> - * 1. uniform split leaves @page (or the folio contains it) locked;
>>>>> - * 2. buddy allocator like (non-uniform) split leaves @folio locked.
>>>>> - *
>>>>> + * folio containing @page. The caller needs to unlock and/or free after-split
>>>>> + * folios if necessary.
>>>>>      *
>>>>>      * For !uniform_split, when -ENOMEM is returned, the original folio might be
>>>>>      * split. The caller needs to check the input folio.
>>>>>      */
>>>>>     static int __split_unmapped_folio(struct folio *folio, int new_order,
>>>>> -		struct page *split_at, struct page *lock_at,
>>>>> -		struct list_head *list, pgoff_t end,
>>>>> -		struct xa_state *xas, struct address_space *mapping,
>>>>> -		bool uniform_split)
>>>>> +				  struct page *split_at, struct xa_state *xas,
>>>>> +				  struct address_space *mapping,
>>>>> +				  bool uniform_split)
>>>>
>>>> Use two-tabs indent please (like we already do, I assume).
>>>
>>> OK. I was using clang-format. It gave me this indentation.
>>>>
>>>> [...]
>>>>
>>>>> @@ -3706,11 +3599,14 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>     {
>>>>>     	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>>>>>     	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>>> +	struct folio *next_folio = folio_next(folio);
>>>>>     	bool is_anon = folio_test_anon(folio);
>>>>>     	struct address_space *mapping = NULL;
>>>>>     	struct anon_vma *anon_vma = NULL;
>>>>>     	int order = folio_order(folio);
>>>>> +	struct folio *new_folio, *next;
>>>>>     	int extra_pins, ret;
>>>>> +	int nr_shmem_dropped = 0;
>>>>>     	pgoff_t end;
>>>>>     	bool is_hzp;
>>>>>    @@ -3833,13 +3729,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>     		 */
>>>>>     		xas_lock(&xas);
>>>>>     		xas_reset(&xas);
>>>>> -		if (xas_load(&xas) != folio)
>>>>> +		if (xas_load(&xas) != folio) {
>>>>> +			ret = -EAGAIN;
>>>>>     			goto fail;
>>>>> +		}
>>>>>     	}
>>>>>      	/* Prevent deferred_split_scan() touching ->_refcount */
>>>>>     	spin_lock(&ds_queue->split_queue_lock);
>>>>>     	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>>>>> +		struct address_space *swap_cache = NULL;
>>>>> +		struct lruvec *lruvec;
>>>>> +
>>>>>     		if (folio_order(folio) > 1 &&
>>>>>     		    !list_empty(&folio->_deferred_list)) {
>>>>>     			ds_queue->split_queue_len--;
>>>>> @@ -3873,18 +3774,120 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>     			}
>>>>>     		}
>>>>>    -		ret = __split_unmapped_folio(folio, new_order,
>>>>> -				split_at, lock_at, list, end, &xas, mapping,
>>>>> -				uniform_split);
>>>>> +		if (folio_test_swapcache(folio)) {
>>>>> +			if (mapping) {
>>>>> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
>>>>> +				ret = -EINVAL;
>>>>> +				goto fail;
>>>>> +			}
>>>>> +
>>>>> +			/*
>>>>> +			 * a swapcache folio can only be uniformly split to
>>>>> +			 * order-0
>>>>> +			 */
>>>>> +			if (!uniform_split || new_order != 0) {
>>>>> +				ret = -EINVAL;
>>>>> +				goto fail;
>>>>> +			}
>>>>> +
>>>>> +			swap_cache = swap_address_space(folio->swap);
>>>>> +			xa_lock(&swap_cache->i_pages);
>>>>> +		}
>>>>> +
>>>>> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>>>>> +		lruvec = folio_lruvec_lock(folio);
>>>>> +
>>>>> +		ret = __split_unmapped_folio(folio, new_order, split_at, &xas,
>>>>> +					     mapping, uniform_split);
>>>>> +
>>>>> +		/*
>>>>> +		 * Unfreeze after-split folios and put them back to the right
>>>>> +		 * list. @folio should be kept frozon until page cache entries
>>>>> +		 * are updated with all the other after-split folios to prevent
>>>>> +		 * others seeing stale page cache entries.
>>>>> +		 */
>>>>> +		for (new_folio = folio_next(folio); new_folio != next_folio;
>>>>> +		     new_folio = next) {
>>>>> +			next = folio_next(new_folio);
>>>>> +
>>>>> +			folio_ref_unfreeze(
>>>>> +				new_folio,
>>>>> +				1 + ((mapping || swap_cache) ?
>>>>> +					     folio_nr_pages(new_folio) :
>>>>> +					     0));
>>>>
>>>> While we are at it, is a way to make this look less than an artistic masterpiece? :)
>>>>
>>>> expected_refs = ...
>>>> folio_ref_unfreeze(new_folio, expected_refs).
>>>>
>>>>
>>>> Can we already make use of folio_expected_ref_count() at that point? Mapcount should be 0 and the folio should be properly setup (e.g., anon, swapcache) IIRC.
>>>>
>>>> So maybe
>>>>
>>>> expected_refs = folio_expected_ref_count(new_folio) + 1;
>>>> folio_ref_unfreeze(new_folio, expected_refs).
>>>>
>>>> Would do?
>>>
>>> I think so. Even further, I think we probably can get rid of can_split_folio()’s
>>> pextra_pins and use folio_expected_ref_count() too.
>>
>> That will only do the right think if we know that the folio is not mapped and that there is no way it can get mapped concurrently.
>>
>> Otherwise, when freezing, we might ignore a mapping (where we should fail freezing).
> 
> You mean between unmap_folio() and folio_ref_freeze(), a concurrent mapping
> happens? So that what folio_expected_ref_count() returns has
> folio_mapcount() != 0. You are right. Thanks.

Right, but maybe locking prevents that.

E.g., a locked anon folio cannot get migrated or swapped in. So the 
mapcount cannot increase once locked. If already mapped, fork() could 
duplicate mappings, but in that case there would be at least one mapping 
already.

For the pagecache, I think we always map a folio with the folio lock 
held: see filemap_map_pages().

So *maybe* just checking folio_mapped() before trying to freeze could be 
good enough, arguing that the mapcount cannot go from 0 -> !0 while the 
folio is locked.

-- 
Cheers,

David / dhildenb



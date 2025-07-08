Return-Path: <linux-kernel+bounces-720885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95BAFC1B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5E8189DF56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8BA214801;
	Tue,  8 Jul 2025 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLVP9fsa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6432AEF5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949014; cv=none; b=ItjbBK+K1fqrZjttxvoqgCBib17AuGtixMtNr/yEnMYo4tWK7YKmCwT2lA6wSVSVwQXiYnJ0Y21zskCZSEvww8lqC2AXrigH6GHC31t/o7nxGTx7kmRGrGMuIiW+Rr5SnNVN3xNqVJQBautK8F2SgIK6BvDc3KmAxXZUo9V9fco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949014; c=relaxed/simple;
	bh=jVfFmNENF6NziEUngK9JzJSQfvQ3ipX70XutgiHYr3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBX+PzBvlVXcLfOPAWagTwsK4yjkLeW13Qkm0ltKQNTq8T1860SDbI8vA3fJajPr8OFbTeoJZVTYTEf2n5azhuvLmJQB89hDHhOQEWY8QyOBHHZFL79TRy7Xop0mQSabPdAn0BHioIlaQOKnsIjb/8CPhuZciwodfUNRwX23VCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLVP9fsa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751949011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poK+MyjdqtyS2NtGfpOWZJkbO8wjy+dgyWR6HOHODAo=;
	b=XLVP9fsaZ0M6lMrN8JcHA5zlFRhRMPbE9v2xi8wCpq9Zemg9Zb7rOMdMjTW29OvXWfeKSd
	Qk7CnIHQXara244GdrKZqZtVes5n+OvwB6bVC4jUz9OTB1ToIo7/JAAVrDar5QNZPvRJ6f
	iXcWG13Cz10JQOntC49jaLuBt4zWzdM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-RvoSDJ_FOi63ypxhN1SG9g-1; Tue, 08 Jul 2025 00:30:09 -0400
X-MC-Unique: RvoSDJ_FOi63ypxhN1SG9g-1
X-Mimecast-MFC-AGG-ID: RvoSDJ_FOi63ypxhN1SG9g_1751949008
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-550d7bd9a7fso2928473e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 21:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751949008; x=1752553808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poK+MyjdqtyS2NtGfpOWZJkbO8wjy+dgyWR6HOHODAo=;
        b=Cy+t+TaNEV7EgcOVEiN9bVjvIRNoSXwgoe3M26B6KAWfLMhn5YJrCeJcAFYX20giez
         H5JP6isPGJJE8bA4831rvLyD5K7JXMccLr1K4LrcDhmnI2na7+6MoYLNTLRV11TLwFOb
         GtinzzdKldpi7i7P877LjSDTvk68KYBJ2eGGP48mVNPLsmHhHCKu6nnJrpHecE7irvID
         Z7mlaH3dl+gJVefiGjnJVnuz4uqjSKMVdieh/3wzTCignQRelmeuG3Ntve2YheUqJ00A
         bBWlOnGdjwhkqoH7/WvDiwzjhVtQZ569HJlnomcyB1KSPph9IcUXXDmKWhOIaBuj5Xlh
         hAQw==
X-Forwarded-Encrypted: i=1; AJvYcCV28KY1UMdvnP3z5/XfWHJ7JtwQZnm3fZj3ThpyYrbInPOHQ7jp4eOnWQ88jxFUc6PoO3b3TKvy6ui78lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2S2CmfWxgnRUZx1YFqbUUrsX6SZkP4UDsU7nX9MZtoRhaCRfp
	WkI32mezGvYWwCjw/MWhjayXc0plKH1wIA/6M+RTMeaz4vPDbyb1kyOzdqPx0bFMSuJ8bbrQuzw
	7WBA8zSNqWMqh7lkG6ygAyGo7dNNb1N5BHHurU1aKlobbSGjCUXwM4abyRSl65MVA
X-Gm-Gg: ASbGnct30aUs9wr8A9DRlmkEo9yCDY9Sy8ybFYvGpKy28T3nCwbaHfwGU3WvauVpnX/
	+EfaBbq9377Tu6MrGUKGiMy6+JPIQyEB4wTNGLZDK/yctqfTD0is0IpszKo04RYn5MtMgHx0bvJ
	pOsD+fpOSb8PvGBp14k3hVYNnq3tjPCMO5Ewnv6urT8ejS4upYkogiErrx/95yhwQEOVkzYbwGp
	xvWrfva496ovRop+RczLmKDLKUUJpt3/xb+331MQwrpulmkygnOl3/jB3YgJjWckkrNbq+b3Hz2
	ADF+OuEVGZiGSFh8nd3uQPVpNaALTrvA/rEAaQYsZ28DPMKZ
X-Received: by 2002:a05:6512:138b:b0:554:f9cc:bea5 with SMTP id 2adb3069b0e04-557aa2930d1mr4593647e87.34.1751949008108;
        Mon, 07 Jul 2025 21:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQIVBjkvYjiYeD1myg2B1HudysYqJQWf4weYmho7e0bDcMupyLOoOVufOLQBsczX8y80PeKw==
X-Received: by 2002:a05:6512:138b:b0:554:f9cc:bea5 with SMTP id 2adb3069b0e04-557aa2930d1mr4593621e87.34.1751949007579;
        Mon, 07 Jul 2025 21:30:07 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55638494bb0sm1536665e87.104.2025.07.07.21.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 21:30:06 -0700 (PDT)
Message-ID: <f625e98a-ae1e-4327-8646-a8e5913000d2@redhat.com>
Date: Tue, 8 Jul 2025 07:30:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 03/12] mm/thp: zone_device awareness in THP handling
 code
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-4-balbirs@nvidia.com>
 <fd86a9f9-66b4-4994-908d-af4c6637442e@redhat.com>
 <b84846bd-801f-42b6-b1d4-3d784ddbcd1f@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <b84846bd-801f-42b6-b1d4-3d784ddbcd1f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/8/25 07:20, Balbir Singh wrote:
> On 7/7/25 13:49, Mika Penttilä wrote:
>> On 7/4/25 02:35, Balbir Singh wrote:
>>> Make THP handling code in the mm subsystem for THP pages
>>> aware of zone device pages. Although the code is
>>> designed to be generic when it comes to handling splitting
>>> of pages, the code is designed to work for THP page sizes
>>> corresponding to HPAGE_PMD_NR.
>>>
>>> Modify page_vma_mapped_walk() to return true when a zone
>>> device huge entry is present, enabling try_to_migrate()
>>> and other code migration paths to appropriately process the
>>> entry
>>>
>>> pmd_pfn() does not work well with zone device entries, use
>>> pfn_pmd_entry_to_swap() for checking and comparison as for
>>> zone device entries.
>>>
>>> try_to_map_to_unused_zeropage() does not apply to zone device
>>> entries, zone device entries are ignored in the call.
>>>
>>> Cc: Karol Herbst <kherbst@redhat.com>
>>> Cc: Lyude Paul <lyude@redhat.com>
>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Simona Vetter <simona@ffwll.ch>
>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>> Cc: Shuah Khan <shuah@kernel.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Barry Song <baohua@kernel.org>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> Cc: Jane Chu <jane.chu@oracle.com>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: Donet Tom <donettom@linux.ibm.com>
>>>
>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>> ---
>>>  mm/huge_memory.c     | 153 +++++++++++++++++++++++++++++++------------
>>>  mm/migrate.c         |   2 +
>>>  mm/page_vma_mapped.c |  10 +++
>>>  mm/pgtable-generic.c |   6 ++
>>>  mm/rmap.c            |  19 +++++-
>>>  5 files changed, 146 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index ce130225a8e5..e6e390d0308f 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1711,7 +1711,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>  	if (unlikely(is_swap_pmd(pmd))) {
>>>  		swp_entry_t entry = pmd_to_swp_entry(pmd);
>>>  
>>> -		VM_BUG_ON(!is_pmd_migration_entry(pmd));
>>> +		VM_BUG_ON(!is_pmd_migration_entry(pmd) &&
>>> +				!is_device_private_entry(entry));
>>>  		if (!is_readable_migration_entry(entry)) {
>>>  			entry = make_readable_migration_entry(
>>>  							swp_offset(entry));
>>> @@ -2222,10 +2223,17 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>  		} else if (thp_migration_supported()) {
>>>  			swp_entry_t entry;
>>>  
>>> -			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
>>>  			entry = pmd_to_swp_entry(orig_pmd);
>>>  			folio = pfn_swap_entry_folio(entry);
>>>  			flush_needed = 0;
>>> +
>>> +			VM_BUG_ON(!is_pmd_migration_entry(*pmd) &&
>>> +					!folio_is_device_private(folio));
>>> +
>>> +			if (folio_is_device_private(folio)) {
>>> +				folio_remove_rmap_pmd(folio, folio_page(folio, 0), vma);
>>> +				WARN_ON_ONCE(folio_mapcount(folio) < 0);
>>> +			}
>>>  		} else
>>>  			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
>>>  
>>> @@ -2247,6 +2255,15 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>  				folio_mark_accessed(folio);
>>>  		}
>>>  
>>> +		/*
>>> +		 * Do a folio put on zone device private pages after
>>> +		 * changes to mm_counter, because the folio_put() will
>>> +		 * clean folio->mapping and the folio_test_anon() check
>>> +		 * will not be usable.
>>> +		 */
>>> +		if (folio_is_device_private(folio))
>>> +			folio_put(folio);
>>> +
>>>  		spin_unlock(ptl);
>>>  		if (flush_needed)
>>>  			tlb_remove_page_size(tlb, &folio->page, HPAGE_PMD_SIZE);
>>> @@ -2375,7 +2392,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>  		struct folio *folio = pfn_swap_entry_folio(entry);
>>>  		pmd_t newpmd;
>>>  
>>> -		VM_BUG_ON(!is_pmd_migration_entry(*pmd));
>>> +		VM_BUG_ON(!is_pmd_migration_entry(*pmd) &&
>>> +			  !folio_is_device_private(folio));
>>>  		if (is_writable_migration_entry(entry)) {
>>>  			/*
>>>  			 * A protection check is difficult so
>>> @@ -2388,9 +2406,11 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>  			newpmd = swp_entry_to_pmd(entry);
>>>  			if (pmd_swp_soft_dirty(*pmd))
>>>  				newpmd = pmd_swp_mksoft_dirty(newpmd);
>>> -		} else {
>>> +		} else if (is_writable_device_private_entry(entry)) {
>>> +			newpmd = swp_entry_to_pmd(entry);
>>> +			entry = make_device_exclusive_entry(swp_offset(entry));
>>> +		} else
>>>  			newpmd = *pmd;
>>> -		}
>>>  
>>>  		if (uffd_wp)
>>>  			newpmd = pmd_swp_mkuffd_wp(newpmd);
>>> @@ -2842,16 +2862,20 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>  	struct page *page;
>>>  	pgtable_t pgtable;
>>>  	pmd_t old_pmd, _pmd;
>>> -	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
>>> -	bool anon_exclusive = false, dirty = false;
>>> +	bool young, write, soft_dirty, uffd_wp = false;
>>> +	bool anon_exclusive = false, dirty = false, present = false;
>>>  	unsigned long addr;
>>>  	pte_t *pte;
>>>  	int i;
>>> +	swp_entry_t swp_entry;
>>>  
>>>  	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
>>>  	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
>>>  	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
>>> -	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd));
>>> +
>>> +	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
>>> +			&& !(is_swap_pmd(*pmd) &&
>>> +			is_device_private_entry(pmd_to_swp_entry(*pmd))));
>>>  
>>>  	count_vm_event(THP_SPLIT_PMD);
>>>  
>>> @@ -2899,20 +2923,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>  		return __split_huge_zero_page_pmd(vma, haddr, pmd);
>>>  	}
>>>  
>>> -	pmd_migration = is_pmd_migration_entry(*pmd);
>>> -	if (unlikely(pmd_migration)) {
>>> -		swp_entry_t entry;
>>>  
>>> +	present = pmd_present(*pmd);
>>> +	if (unlikely(!present)) {
>>> +		swp_entry = pmd_to_swp_entry(*pmd);
>>>  		old_pmd = *pmd;
>>> -		entry = pmd_to_swp_entry(old_pmd);
>>> -		page = pfn_swap_entry_to_page(entry);
>>> -		write = is_writable_migration_entry(entry);
>>> +
>>> +		folio = pfn_swap_entry_folio(swp_entry);
>>> +		VM_BUG_ON(!is_migration_entry(swp_entry) &&
>>> +				!is_device_private_entry(swp_entry));
>>> +		page = pfn_swap_entry_to_page(swp_entry);
>>> +		write = is_writable_migration_entry(swp_entry);
>>> +
>>>  		if (PageAnon(page))
>>> -			anon_exclusive = is_readable_exclusive_migration_entry(entry);
>>> -		young = is_migration_entry_young(entry);
>>> -		dirty = is_migration_entry_dirty(entry);
>>> +			anon_exclusive =
>>> +				is_readable_exclusive_migration_entry(swp_entry);
>>>  		soft_dirty = pmd_swp_soft_dirty(old_pmd);
>>>  		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>>> +		young = is_migration_entry_young(swp_entry);
>>> +		dirty = is_migration_entry_dirty(swp_entry);
>>>  	} else {
>> This is where folio_try_share_anon_rmap_pmd() is skipped for device private pages, to which I referred in
>> https://lore.kernel.org/linux-mm/f1e26e18-83db-4c0e-b8d8-0af8ffa8a206@redhat.com/
>>
> Does it matter for device private pages/folios? It does not affect the freeze value.

I think ClearPageAnonExclusive is needed.

>
> Balbir Singh
>
--Mika



Return-Path: <linux-kernel+bounces-756268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C80B1B217
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC864189F5CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6921B9D6;
	Tue,  5 Aug 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZBzct6I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA01F4612
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390121; cv=none; b=uIK7HfpNGCtKct3HzohAqadnjxEeaIRN97kTgr3JMJ2dR6P/hvLgryBK8sw3gZJUK2FN0go2bHggSAIeH+6t33Ak+VsYFGa6t3FULPQBnNJXd06sxe6goULckvNiyKgnudEXLVOipDurDf1FzHiU65i35/AMihYomiRcljUrTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390121; c=relaxed/simple;
	bh=rTWBMo+l3t1CE0pZoKYP3QeQcms2YWcdTgREqMK54CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZxHf60qGl7p83598fJJSsYmmSv7JcgkAbyA/fl8aT2CxpFKuWweY5/qv7kVYXSNzrI2uZPIUhfNlmOWCA66DHIwolvC1W3GmP8QFMJrZ7MU+YpOVvHwnXapFyNuxSsrWcwXlgWT6K+p7gJPdsogZafc7rn2ra7aayHHnF38N9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZBzct6I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754390116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=894SiI2/fY9/koqN6aMtskvCnlH/KvMKu9PCRPNaiDI=;
	b=OZBzct6IG7/ge1wMPJkTxoNSQk8Ac+MRkqnVw1+mE5VOUaJG/9+kz80wZNL+6POU1lEFMD
	x0ObBH9MukBBBo2GcA+VMvADAQq0Aj3iNZpwygLqG4gFAsn3mdD2JhpbQcxO7fm+Bu9FpD
	plnKWzdL3H0IKP6jhV0fEzsVswkV2Dg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520--gQgWye9Mfq3RC5ChpE9bw-1; Tue, 05 Aug 2025 06:35:15 -0400
X-MC-Unique: -gQgWye9Mfq3RC5ChpE9bw-1
X-Mimecast-MFC-AGG-ID: -gQgWye9Mfq3RC5ChpE9bw_1754390114
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-55ba198c6f6so1674749e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390114; x=1754994914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=894SiI2/fY9/koqN6aMtskvCnlH/KvMKu9PCRPNaiDI=;
        b=OiGihkEaI0X/2dkGvEZBy9JW2fxvEHR+out7N9ROu5x2dEr9wFgJe6hYGrNJQEDgBr
         LHGAK1CMvZTGlG7Hb1cuI3cHFzFwCQBLzclKTVGo9q1fXXMswrunfUHR9YQySua2Ujah
         PSbh8HBCwJCbAtJP2OAOBbyxPYfTfRNEfK/HKDiVh7D8Ru0TXH9ZSOp+nDaIqd7svs+u
         yXbR/CTf8rodNCMq5ArH8IYPHlTrgrI3EbzSc1LzamykGtYZIG10vUXj7HYjw/fQMHvN
         1HbT6I/o8ixr5Gj7zViVT4GJFXwNza5hTsc+lim6Qkj+gbllcpKFFm1lfWYPGNe3Vif6
         4UOw==
X-Forwarded-Encrypted: i=1; AJvYcCWaLx1bdHi8DrU6tH9S0QjrNSmB0WvyNazrYDCJ5y0SXS8UhVFP14PWHi0E0GFg24QL0ZanYat9rhdm7y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LvEqTG4iGAt2s6jQG1xD5d0ipaTpIo6z60OahtdR1PWtHrc8
	RZYldacUddl9VrTqdiyeg5WlTMHgcuiEpBQDYIcXxIbxjJIG4Q8drRWr2FOvox/aKDGOdVlD5/9
	EONRWWv2f8m5m13QYtN2C3jg362C6huECcAzZlP1CdMMSBxOjgpoup6h+Nyefpgpx
X-Gm-Gg: ASbGncvsPNlPb8AROWbTK8huoPmvkVML6RtieEARubDZpnJX+9EixYEtKsH7Sd8Biud
	9Ds1hKql+D27FsxRBbzI0tKU2h5nBYmLBxqxyfsttgr0QbmlslRcOaYGmn4MrV5xJh8LZ7KugjQ
	RPa8Y7ns2OQkOySiD9c592YUR4YktW7jtA5MmBWawf9SoU3FsRGO0R+PDnn2o5tP6QAea5Jisxx
	VmruanGPiNX2ybj2Y13DWyfmktNhG3sBo33H73bP6Mjm+9zgXl+04TWXCorurXoDoVatFpcY1o5
	1hzmaprUbspXYYVuk+MmAndscbG558BSkNZeRRMPtY/6CiS5XQ9xnLr2bwPaKBUb+w==
X-Received: by 2002:a05:6512:3b28:b0:55b:822a:3ca2 with SMTP id 2adb3069b0e04-55b97a8b6d4mr3460826e87.13.1754390113661;
        Tue, 05 Aug 2025 03:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMPydzvB1MxHAirhVYP4BK0ywZFVHEmje/lMvvFJjFu+K7Cg8lZTaUjG1l5MvkMhLB1PQbsA==
X-Received: by 2002:a05:6512:3b28:b0:55b:822a:3ca2 with SMTP id 2adb3069b0e04-55b97a8b6d4mr3460793e87.13.1754390113099;
        Tue, 05 Aug 2025 03:35:13 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabf55sm1927641e87.147.2025.08.05.03.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:35:12 -0700 (PDT)
Message-ID: <6a08fa8f-bc39-4389-aa52-d95f82538a91@redhat.com>
Date: Tue, 5 Aug 2025 13:35:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 02/11] mm/thp: zone_device awareness in THP handling code
To: Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <b5fa0989-a64a-4c91-ac34-6fb29ee6d132@redhat.com>
 <EC99D49E-86FF-4A50-A1AA-FC43A7D3716C@nvidia.com>
 <14aeaecc-c394-41bf-ae30-24537eb299d9@nvidia.com>
 <e5dd3f46-c063-45ff-8be7-64ac92534985@redhat.com>
 <71c736e9-eb77-4e8e-bd6a-965a1bbcbaa8@nvidia.com>
 <edbe38d4-3489-4c83-80fb-dc96a7684294@redhat.com>
 <e8f867cf-67f1-413a-a775-835a32861164@nvidia.com>
 <ee06bd19-4831-493f-ae88-f1d8a2fe9fa4@redhat.com>
 <47BC6D8B-7A78-4F2F-9D16-07D6C88C3661@nvidia.com>
 <2406521e-f5be-474e-b653-e5ad38a1d7de@redhat.com>
 <A813C8B0-325E-44F0-8E30-3D0CBACB6BE1@nvidia.com>
 <ab46303e-a891-4f48-8a86-964155a1073d@nvidia.com>
 <920a4f98-a925-4bd6-ad2e-ae842f2f3d94@redhat.com>
 <f3e85850-bc5b-461a-9efc-d1961fb5d340@nvidia.com>
 <196f11f8-1661-40d2-b6b7-64958efd8b3b@redhat.com>
 <ede98867-bc17-4894-a375-d17d8f83dd55@nvidia.com>
 <087e40e6-3b3f-4a02-8270-7e6cfdb56a04@redhat.com>
 <b3f97ffd-2e25-4df6-9da5-65264ee6916b@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <b3f97ffd-2e25-4df6-9da5-65264ee6916b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/5/25 13:27, Balbir Singh wrote:

> On 8/5/25 14:24, Mika Penttilä wrote:
>> Hi,
>>
>> On 8/5/25 07:10, Balbir Singh wrote:
>>> On 8/5/25 09:26, Mika Penttilä wrote:
>>>> Hi,
>>>>
>>>> On 8/5/25 01:46, Balbir Singh wrote:
>>>>> On 8/2/25 22:13, Mika Penttilä wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 8/2/25 13:37, Balbir Singh wrote:
>>>>>>> FYI:
>>>>>>>
>>>>>>> I have the following patch on top of my series that seems to make it work
>>>>>>> without requiring the helper to split device private folios
>>>>>>>
>>>>>> I think this looks much better!
>>>>>>
>>>>> Thanks!
>>>>>
>>>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>>>> ---
>>>>>>>  include/linux/huge_mm.h |  1 -
>>>>>>>  lib/test_hmm.c          | 11 +++++-
>>>>>>>  mm/huge_memory.c        | 76 ++++-------------------------------------
>>>>>>>  mm/migrate_device.c     | 51 +++++++++++++++++++++++++++
>>>>>>>  4 files changed, 67 insertions(+), 72 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>>> index 19e7e3b7c2b7..52d8b435950b 100644
>>>>>>> --- a/include/linux/huge_mm.h
>>>>>>> +++ b/include/linux/huge_mm.h
>>>>>>> @@ -343,7 +343,6 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>>>>>>>  		vm_flags_t vm_flags);
>>>>>>>  
>>>>>>>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>>>>>>> -int split_device_private_folio(struct folio *folio);
>>>>>>>  int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>>>>  		unsigned int new_order, bool unmapped);
>>>>>>>  int min_order_for_split(struct folio *folio);
>>>>>>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>>>>>>> index 341ae2af44ec..444477785882 100644
>>>>>>> --- a/lib/test_hmm.c
>>>>>>> +++ b/lib/test_hmm.c
>>>>>>> @@ -1625,13 +1625,22 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
>>>>>>>  	 * the mirror but here we use it to hold the page for the simulated
>>>>>>>  	 * device memory and that page holds the pointer to the mirror.
>>>>>>>  	 */
>>>>>>> -	rpage = vmf->page->zone_device_data;
>>>>>>> +	rpage = folio_page(page_folio(vmf->page), 0)->zone_device_data;
>>>>>>>  	dmirror = rpage->zone_device_data;
>>>>>>>  
>>>>>>>  	/* FIXME demonstrate how we can adjust migrate range */
>>>>>>>  	order = folio_order(page_folio(vmf->page));
>>>>>>>  	nr = 1 << order;
>>>>>>>  
>>>>>>> +	/*
>>>>>>> +	 * When folios are partially mapped, we can't rely on the folio
>>>>>>> +	 * order of vmf->page as the folio might not be fully split yet
>>>>>>> +	 */
>>>>>>> +	if (vmf->pte) {
>>>>>>> +		order = 0;
>>>>>>> +		nr = 1;
>>>>>>> +	}
>>>>>>> +
>>>>>>>  	/*
>>>>>>>  	 * Consider a per-cpu cache of src and dst pfns, but with
>>>>>>>  	 * large number of cpus that might not scale well.
>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>>> index 1fc1efa219c8..863393dec1f1 100644
>>>>>>> --- a/mm/huge_memory.c
>>>>>>> +++ b/mm/huge_memory.c
>>>>>>> @@ -72,10 +72,6 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
>>>>>>>  					  struct shrink_control *sc);
>>>>>>>  static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>>>>>  					 struct shrink_control *sc);
>>>>>>> -static int __split_unmapped_folio(struct folio *folio, int new_order,
>>>>>>> -		struct page *split_at, struct xa_state *xas,
>>>>>>> -		struct address_space *mapping, bool uniform_split);
>>>>>>> -
>>>>>>>  static bool split_underused_thp = true;
>>>>>>>  
>>>>>>>  static atomic_t huge_zero_refcount;
>>>>>>> @@ -2924,51 +2920,6 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
>>>>>>>  	pmd_populate(mm, pmd, pgtable);
>>>>>>>  }
>>>>>>>  
>>>>>>> -/**
>>>>>>> - * split_huge_device_private_folio - split a huge device private folio into
>>>>>>> - * smaller pages (of order 0), currently used by migrate_device logic to
>>>>>>> - * split folios for pages that are partially mapped
>>>>>>> - *
>>>>>>> - * @folio: the folio to split
>>>>>>> - *
>>>>>>> - * The caller has to hold the folio_lock and a reference via folio_get
>>>>>>> - */
>>>>>>> -int split_device_private_folio(struct folio *folio)
>>>>>>> -{
>>>>>>> -	struct folio *end_folio = folio_next(folio);
>>>>>>> -	struct folio *new_folio;
>>>>>>> -	int ret = 0;
>>>>>>> -
>>>>>>> -	/*
>>>>>>> -	 * Split the folio now. In the case of device
>>>>>>> -	 * private pages, this path is executed when
>>>>>>> -	 * the pmd is split and since freeze is not true
>>>>>>> -	 * it is likely the folio will be deferred_split.
>>>>>>> -	 *
>>>>>>> -	 * With device private pages, deferred splits of
>>>>>>> -	 * folios should be handled here to prevent partial
>>>>>>> -	 * unmaps from causing issues later on in migration
>>>>>>> -	 * and fault handling flows.
>>>>>>> -	 */
>>>>>>> -	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>>> -	ret = __split_unmapped_folio(folio, 0, &folio->page, NULL, NULL, true);
>>>>>>> -	VM_WARN_ON(ret);
>>>>>>> -	for (new_folio = folio_next(folio); new_folio != end_folio;
>>>>>>> -					new_folio = folio_next(new_folio)) {
>>>>>>> -		zone_device_private_split_cb(folio, new_folio);
>>>>>>> -		folio_ref_unfreeze(new_folio, 1 + folio_expected_ref_count(
>>>>>>> -								new_folio));
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	/*
>>>>>>> -	 * Mark the end of the folio split for device private THP
>>>>>>> -	 * split
>>>>>>> -	 */
>>>>>>> -	zone_device_private_split_cb(folio, NULL);
>>>>>>> -	folio_ref_unfreeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>>> -	return ret;
>>>>>>> -}
>>>>>>> -
>>>>>>>  static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>>>  		unsigned long haddr, bool freeze)
>>>>>>>  {
>>>>>>> @@ -3064,30 +3015,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>>>  				freeze = false;
>>>>>>>  			if (!freeze) {
>>>>>>>  				rmap_t rmap_flags = RMAP_NONE;
>>>>>>> -				unsigned long addr = haddr;
>>>>>>> -				struct folio *new_folio;
>>>>>>> -				struct folio *end_folio = folio_next(folio);
>>>>>>>  
>>>>>>>  				if (anon_exclusive)
>>>>>>>  					rmap_flags |= RMAP_EXCLUSIVE;
>>>>>>>  
>>>>>>> -				folio_lock(folio);
>>>>>>> -				folio_get(folio);
>>>>>>> -
>>>>>>> -				split_device_private_folio(folio);
>>>>>>> -
>>>>>>> -				for (new_folio = folio_next(folio);
>>>>>>> -					new_folio != end_folio;
>>>>>>> -					new_folio = folio_next(new_folio)) {
>>>>>>> -					addr += PAGE_SIZE;
>>>>>>> -					folio_unlock(new_folio);
>>>>>>> -					folio_add_anon_rmap_ptes(new_folio,
>>>>>>> -						&new_folio->page, 1,
>>>>>>> -						vma, addr, rmap_flags);
>>>>>>> -				}
>>>>>>> -				folio_unlock(folio);
>>>>>>> -				folio_add_anon_rmap_ptes(folio, &folio->page,
>>>>>>> -						1, vma, haddr, rmap_flags);
>>>>>>> +				folio_ref_add(folio, HPAGE_PMD_NR - 1);
>>>>>>> +				if (anon_exclusive)
>>>>>>> +					rmap_flags |= RMAP_EXCLUSIVE;
>>>>>>> +				folio_add_anon_rmap_ptes(folio, page, HPAGE_PMD_NR,
>>>>>>> +						 vma, haddr, rmap_flags);
>>>>>>>  			}
>>>>>>>  		}
>>>>>>>  
>>>>>>> @@ -4065,7 +4001,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>  	if (nr_shmem_dropped)
>>>>>>>  		shmem_uncharge(mapping->host, nr_shmem_dropped);
>>>>>>>  
>>>>>>> -	if (!ret && is_anon)
>>>>>>> +	if (!ret && is_anon && !folio_is_device_private(folio))
>>>>>>>  		remap_flags = RMP_USE_SHARED_ZEROPAGE;
>>>>>>>  
>>>>>>>  	remap_page(folio, 1 << order, remap_flags);
>>>>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>>>>> index 49962ea19109..4264c0290d08 100644
>>>>>>> --- a/mm/migrate_device.c
>>>>>>> +++ b/mm/migrate_device.c
>>>>>>> @@ -248,6 +248,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>>>>  			 * page table entry. Other special swap entries are not
>>>>>>>  			 * migratable, and we ignore regular swapped page.
>>>>>>>  			 */
>>>>>>> +			struct folio *folio;
>>>>>>> +
>>>>>>>  			entry = pte_to_swp_entry(pte);
>>>>>>>  			if (!is_device_private_entry(entry))
>>>>>>>  				goto next;
>>>>>>> @@ -259,6 +261,55 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>>>>  			    pgmap->owner != migrate->pgmap_owner)
>>>>>>>  				goto next;
>>>>>>>  
>>>>>>> +			folio = page_folio(page);
>>>>>>> +			if (folio_test_large(folio)) {
>>>>>>> +				struct folio *new_folio;
>>>>>>> +				struct folio *new_fault_folio;
>>>>>>> +
>>>>>>> +				/*
>>>>>>> +				 * The reason for finding pmd present with a
>>>>>>> +				 * device private pte and a large folio for the
>>>>>>> +				 * pte is partial unmaps. Split the folio now
>>>>>>> +				 * for the migration to be handled correctly
>>>>>>> +				 */
>>>>>>> +				pte_unmap_unlock(ptep, ptl);
>>>>>>> +
>>>>>>> +				folio_get(folio);
>>>>>>> +				if (folio != fault_folio)
>>>>>>> +					folio_lock(folio);
>>>>>>> +				if (split_folio(folio)) {
>>>>>>> +					if (folio != fault_folio)
>>>>>>> +						folio_unlock(folio);
>>>>>>> +					ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>>>>>> +					goto next;
>>>>>>> +				}
>>>>>>> +
>>>>>> The nouveau migrate_to_ram handler needs adjustment also if split happens.
>>>>>>
>>>>> test_hmm needs adjustment because of the way the backup folios are setup.
>>>> nouveau should check the folio order after the possible split happens.
>>>>
>>> You mean the folio_split callback?
>> no, nouveau_dmem_migrate_to_ram():
>> ..
>>         sfolio = page_folio(vmf->page);
>>         order = folio_order(sfolio);
>> ...
>>         migrate_vma_setup()
>> ..
>> if sfolio is split order still reflects the pre-split order
>>
> Will fix, good catch!
>
>>>>>>> +				/*
>>>>>>> +				 * After the split, get back the extra reference
>>>>>>> +				 * on the fault_page, this reference is checked during
>>>>>>> +				 * folio_migrate_mapping()
>>>>>>> +				 */
>>>>>>> +				if (migrate->fault_page) {
>>>>>>> +					new_fault_folio = page_folio(migrate->fault_page);
>>>>>>> +					folio_get(new_fault_folio);
>>>>>>> +				}
>>>>>>> +
>>>>>>> +				new_folio = page_folio(page);
>>>>>>> +				pfn = page_to_pfn(page);
>>>>>>> +
>>>>>>> +				/*
>>>>>>> +				 * Ensure the lock is held on the correct
>>>>>>> +				 * folio after the split
>>>>>>> +				 */
>>>>>>> +				if (folio != new_folio) {
>>>>>>> +					folio_unlock(folio);
>>>>>>> +					folio_lock(new_folio);
>>>>>>> +				}
>>>>>> Maybe careful not to unlock fault_page ?
>>>>>>
>>>>> split_page will unlock everything but the original folio, the code takes the lock
>>>>> on the folio corresponding to the new folio
>>>> I mean do_swap_page() unlocks folio of fault_page and expects it to remain locked.
>>>>
>>> Not sure I follow what you're trying to elaborate on here
>> do_swap_page:
>> ..
>>         if (trylock_page(vmf->page)) {
>>                 ret = pgmap->ops->migrate_to_ram(vmf);
>>                                <- vmf->page should be locked here even after split
>>                 unlock_page(vmf->page);
>>
> Yep, the split will unlock all tail folios, leaving the just head folio locked
> and this the change, the lock we need to hold is the folio lock associated with
> fault_page, pte entry and not unlock when the cause is a fault. The code seems
> to do the right thing there, let me double check

Yes the fault case is ok. But if migrate not for a fault, we should not leave any page locked

>
> Balbir
> and the code does the right thing there.
>
--Mika



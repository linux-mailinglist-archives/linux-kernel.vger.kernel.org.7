Return-Path: <linux-kernel+bounces-755903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87609B1AD1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FB43B91B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B102139B5;
	Tue,  5 Aug 2025 04:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doRtWLst"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9F1EF0B9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754367887; cv=none; b=iuT08Mm9K4bl9DbznIjc91lSYGFbv5DAU2/upRc7ruELoZLQ9+HuwCzPc6f9rzkdJqLy6HZAFuCCn1chCBWtmaOlUZFywy/ANtcg+vrskUcDGGF7coLuQ4oGEN4bt22GzFbwCgD/8XZZSl9jyLthyKT9BOLIyBs9bIEzQfbsN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754367887; c=relaxed/simple;
	bh=jVSoAZIPhZnQaJQlg+oCLFX64dHD7xlTLh4STp/cQ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATc1IMubqgG3/hBqvo65GJruEJXp8DPk6K5u3qZOfanawyg7bsIu6PZ0m9fA5ykGGzBha7ZYI3ZuPkvNPT8q8XuD/hHZkcNPJKR3W6/ubwmARvKZALnP2k5h316nOjFxOOfyvfGMzJqx3pGu63Q55bQtv5vkP6l/V2TDOqLB1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doRtWLst; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754367884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMAMOBOEqJtPphtd0X+hPY/9bdMZAOIxqSHXSbKc4X4=;
	b=doRtWLstz9JnxD7j8EaYS+7RxBJTgqfr5gXLoDc62U6eeNY6RXBlJX+NvZW02mgR4o8yfd
	YxsYjBqcshoqjq580UD/L1uh3dBPED7cJL9jscPDfh/LdmW3sKikXlDaadnv9vdJGWJFf6
	gQ1HV0uCdY7viH7HkKf29gsUl8te3us=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-Bo0HYqO0NdS3Gk5zjh9s-Q-1; Tue, 05 Aug 2025 00:24:41 -0400
X-MC-Unique: Bo0HYqO0NdS3Gk5zjh9s-Q-1
X-Mimecast-MFC-AGG-ID: Bo0HYqO0NdS3Gk5zjh9s-Q_1754367880
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3322b98b1a6so24030461fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 21:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754367880; x=1754972680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMAMOBOEqJtPphtd0X+hPY/9bdMZAOIxqSHXSbKc4X4=;
        b=okX9XZYwlh2aQOozhbzWlGCxAeM0jg+TIgYpbPzcYgWf5XGqlQcYi0MvzazHhNwakf
         MOSopg+wAsf0R06d6rfnFT2zmDuDkf+9J6mbywvc0CTR81Rec8NL0+7EHkKAuQWK2iL2
         Tr4+BTkjnjoTzwcttiTaPWjF1IlaJVG3x+K9H766HJdfiGvG2ybwmPIFnm+Kh1U9N2n3
         SbpLlhfWRQbc/N00XMFiWXEPkAQdiQ0hgs+q39XAAAv3FzHbTLl7c4Z9VXkHcBGPFA/6
         IqAYMu5dFxFVI4VlT4qM0lRrBh5lH1l/85DOvm+0VGZr9/DTaOGEXy74NVX/heuD1KI8
         Cwpg==
X-Forwarded-Encrypted: i=1; AJvYcCVb/SDpooHZwwnOwty32EVY8MrUfMVzIZekSIP0T9QRZRKHShpwEZhlbWmzhBjR+TnR/1rMD5rgNmggEqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MzrfD4fXhjEDLb5OBP/tp3BPy2cNtTazWDi16GgYlOJcIS46
	ELgmWROAfRn9X2zuNTLNUHnq0odBdtQENPLjH7Y7gdL9CCsslus9pzuHf/e/2wnOvkK8cNBMFfv
	CcyU2te4NZSXptO80j/Y3XHs/nBt3gxzEp6TBiFhBXj1nE4qggUHdU+wj9OmGkbA6
X-Gm-Gg: ASbGnctySKY7yLUAVcwJ42MGLc7hG0Ikr9ES2tMN+yhhbv3gKtH1TvdCylMVBozszbD
	XlRWm4O22uKnnovZHf1DVjer87lh2qXAIMB/gLHKXGiN/wPwbdKwej9vuK0pdQkCvuNr7zfgBqP
	VwmYlvUwwMvHeiAaF1Tyaua7mrCj5SPBoUU76nSDydkBU3crRo0oF9fvl/0lPDY41u4Jrjq0GB/
	ECzUf/S9tBiEZeqOVySadhpjmn5IMn7nCSb2XKwStiqHtP1QDsWX4DoZaceEHWtuV0V6cih3P+p
	VVPjblrZ+fy6F/NfXjhzB6H/16GazDA+9RcBVZSkVwp9KUgmGX4asGsqO49vLzyNBg==
X-Received: by 2002:a05:6512:2210:b0:55b:8827:b7c4 with SMTP id 2adb3069b0e04-55b97b933fbmr2790453e87.40.1754367880257;
        Mon, 04 Aug 2025 21:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL02ize8GRHM9rNlRgyTroZ9wz58VzZXq9iQJXfnMFISrcR6FCo97dbuVFAOEC8WDkwTThqg==
X-Received: by 2002:a05:6512:2210:b0:55b:8827:b7c4 with SMTP id 2adb3069b0e04-55b97b933fbmr2790447e87.40.1754367879738;
        Mon, 04 Aug 2025 21:24:39 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca296csm1832935e87.119.2025.08.04.21.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 21:24:39 -0700 (PDT)
Message-ID: <087e40e6-3b3f-4a02-8270-7e6cfdb56a04@redhat.com>
Date: Tue, 5 Aug 2025 07:24:38 +0300
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
 <9FBDBFB9-8B27-459C-8047-055F90607D60@nvidia.com>
 <11ee9c5e-3e74-4858-bf8d-94daf1530314@redhat.com>
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
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <ede98867-bc17-4894-a375-d17d8f83dd55@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/5/25 07:10, Balbir Singh wrote:
> On 8/5/25 09:26, Mika Penttilä wrote:
>> Hi,
>>
>> On 8/5/25 01:46, Balbir Singh wrote:
>>> On 8/2/25 22:13, Mika Penttilä wrote:
>>>> Hi,
>>>>
>>>> On 8/2/25 13:37, Balbir Singh wrote:
>>>>> FYI:
>>>>>
>>>>> I have the following patch on top of my series that seems to make it work
>>>>> without requiring the helper to split device private folios
>>>>>
>>>> I think this looks much better!
>>>>
>>> Thanks!
>>>
>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>> ---
>>>>>  include/linux/huge_mm.h |  1 -
>>>>>  lib/test_hmm.c          | 11 +++++-
>>>>>  mm/huge_memory.c        | 76 ++++-------------------------------------
>>>>>  mm/migrate_device.c     | 51 +++++++++++++++++++++++++++
>>>>>  4 files changed, 67 insertions(+), 72 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>> index 19e7e3b7c2b7..52d8b435950b 100644
>>>>> --- a/include/linux/huge_mm.h
>>>>> +++ b/include/linux/huge_mm.h
>>>>> @@ -343,7 +343,6 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>>>>>  		vm_flags_t vm_flags);
>>>>>  
>>>>>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>>>>> -int split_device_private_folio(struct folio *folio);
>>>>>  int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>>  		unsigned int new_order, bool unmapped);
>>>>>  int min_order_for_split(struct folio *folio);
>>>>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>>>>> index 341ae2af44ec..444477785882 100644
>>>>> --- a/lib/test_hmm.c
>>>>> +++ b/lib/test_hmm.c
>>>>> @@ -1625,13 +1625,22 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
>>>>>  	 * the mirror but here we use it to hold the page for the simulated
>>>>>  	 * device memory and that page holds the pointer to the mirror.
>>>>>  	 */
>>>>> -	rpage = vmf->page->zone_device_data;
>>>>> +	rpage = folio_page(page_folio(vmf->page), 0)->zone_device_data;
>>>>>  	dmirror = rpage->zone_device_data;
>>>>>  
>>>>>  	/* FIXME demonstrate how we can adjust migrate range */
>>>>>  	order = folio_order(page_folio(vmf->page));
>>>>>  	nr = 1 << order;
>>>>>  
>>>>> +	/*
>>>>> +	 * When folios are partially mapped, we can't rely on the folio
>>>>> +	 * order of vmf->page as the folio might not be fully split yet
>>>>> +	 */
>>>>> +	if (vmf->pte) {
>>>>> +		order = 0;
>>>>> +		nr = 1;
>>>>> +	}
>>>>> +
>>>>>  	/*
>>>>>  	 * Consider a per-cpu cache of src and dst pfns, but with
>>>>>  	 * large number of cpus that might not scale well.
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index 1fc1efa219c8..863393dec1f1 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -72,10 +72,6 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
>>>>>  					  struct shrink_control *sc);
>>>>>  static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>>>  					 struct shrink_control *sc);
>>>>> -static int __split_unmapped_folio(struct folio *folio, int new_order,
>>>>> -		struct page *split_at, struct xa_state *xas,
>>>>> -		struct address_space *mapping, bool uniform_split);
>>>>> -
>>>>>  static bool split_underused_thp = true;
>>>>>  
>>>>>  static atomic_t huge_zero_refcount;
>>>>> @@ -2924,51 +2920,6 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
>>>>>  	pmd_populate(mm, pmd, pgtable);
>>>>>  }
>>>>>  
>>>>> -/**
>>>>> - * split_huge_device_private_folio - split a huge device private folio into
>>>>> - * smaller pages (of order 0), currently used by migrate_device logic to
>>>>> - * split folios for pages that are partially mapped
>>>>> - *
>>>>> - * @folio: the folio to split
>>>>> - *
>>>>> - * The caller has to hold the folio_lock and a reference via folio_get
>>>>> - */
>>>>> -int split_device_private_folio(struct folio *folio)
>>>>> -{
>>>>> -	struct folio *end_folio = folio_next(folio);
>>>>> -	struct folio *new_folio;
>>>>> -	int ret = 0;
>>>>> -
>>>>> -	/*
>>>>> -	 * Split the folio now. In the case of device
>>>>> -	 * private pages, this path is executed when
>>>>> -	 * the pmd is split and since freeze is not true
>>>>> -	 * it is likely the folio will be deferred_split.
>>>>> -	 *
>>>>> -	 * With device private pages, deferred splits of
>>>>> -	 * folios should be handled here to prevent partial
>>>>> -	 * unmaps from causing issues later on in migration
>>>>> -	 * and fault handling flows.
>>>>> -	 */
>>>>> -	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>> -	ret = __split_unmapped_folio(folio, 0, &folio->page, NULL, NULL, true);
>>>>> -	VM_WARN_ON(ret);
>>>>> -	for (new_folio = folio_next(folio); new_folio != end_folio;
>>>>> -					new_folio = folio_next(new_folio)) {
>>>>> -		zone_device_private_split_cb(folio, new_folio);
>>>>> -		folio_ref_unfreeze(new_folio, 1 + folio_expected_ref_count(
>>>>> -								new_folio));
>>>>> -	}
>>>>> -
>>>>> -	/*
>>>>> -	 * Mark the end of the folio split for device private THP
>>>>> -	 * split
>>>>> -	 */
>>>>> -	zone_device_private_split_cb(folio, NULL);
>>>>> -	folio_ref_unfreeze(folio, 1 + folio_expected_ref_count(folio));
>>>>> -	return ret;
>>>>> -}
>>>>> -
>>>>>  static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>  		unsigned long haddr, bool freeze)
>>>>>  {
>>>>> @@ -3064,30 +3015,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>  				freeze = false;
>>>>>  			if (!freeze) {
>>>>>  				rmap_t rmap_flags = RMAP_NONE;
>>>>> -				unsigned long addr = haddr;
>>>>> -				struct folio *new_folio;
>>>>> -				struct folio *end_folio = folio_next(folio);
>>>>>  
>>>>>  				if (anon_exclusive)
>>>>>  					rmap_flags |= RMAP_EXCLUSIVE;
>>>>>  
>>>>> -				folio_lock(folio);
>>>>> -				folio_get(folio);
>>>>> -
>>>>> -				split_device_private_folio(folio);
>>>>> -
>>>>> -				for (new_folio = folio_next(folio);
>>>>> -					new_folio != end_folio;
>>>>> -					new_folio = folio_next(new_folio)) {
>>>>> -					addr += PAGE_SIZE;
>>>>> -					folio_unlock(new_folio);
>>>>> -					folio_add_anon_rmap_ptes(new_folio,
>>>>> -						&new_folio->page, 1,
>>>>> -						vma, addr, rmap_flags);
>>>>> -				}
>>>>> -				folio_unlock(folio);
>>>>> -				folio_add_anon_rmap_ptes(folio, &folio->page,
>>>>> -						1, vma, haddr, rmap_flags);
>>>>> +				folio_ref_add(folio, HPAGE_PMD_NR - 1);
>>>>> +				if (anon_exclusive)
>>>>> +					rmap_flags |= RMAP_EXCLUSIVE;
>>>>> +				folio_add_anon_rmap_ptes(folio, page, HPAGE_PMD_NR,
>>>>> +						 vma, haddr, rmap_flags);
>>>>>  			}
>>>>>  		}
>>>>>  
>>>>> @@ -4065,7 +4001,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>  	if (nr_shmem_dropped)
>>>>>  		shmem_uncharge(mapping->host, nr_shmem_dropped);
>>>>>  
>>>>> -	if (!ret && is_anon)
>>>>> +	if (!ret && is_anon && !folio_is_device_private(folio))
>>>>>  		remap_flags = RMP_USE_SHARED_ZEROPAGE;
>>>>>  
>>>>>  	remap_page(folio, 1 << order, remap_flags);
>>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>>> index 49962ea19109..4264c0290d08 100644
>>>>> --- a/mm/migrate_device.c
>>>>> +++ b/mm/migrate_device.c
>>>>> @@ -248,6 +248,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>>  			 * page table entry. Other special swap entries are not
>>>>>  			 * migratable, and we ignore regular swapped page.
>>>>>  			 */
>>>>> +			struct folio *folio;
>>>>> +
>>>>>  			entry = pte_to_swp_entry(pte);
>>>>>  			if (!is_device_private_entry(entry))
>>>>>  				goto next;
>>>>> @@ -259,6 +261,55 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>>  			    pgmap->owner != migrate->pgmap_owner)
>>>>>  				goto next;
>>>>>  
>>>>> +			folio = page_folio(page);
>>>>> +			if (folio_test_large(folio)) {
>>>>> +				struct folio *new_folio;
>>>>> +				struct folio *new_fault_folio;
>>>>> +
>>>>> +				/*
>>>>> +				 * The reason for finding pmd present with a
>>>>> +				 * device private pte and a large folio for the
>>>>> +				 * pte is partial unmaps. Split the folio now
>>>>> +				 * for the migration to be handled correctly
>>>>> +				 */
>>>>> +				pte_unmap_unlock(ptep, ptl);
>>>>> +
>>>>> +				folio_get(folio);
>>>>> +				if (folio != fault_folio)
>>>>> +					folio_lock(folio);
>>>>> +				if (split_folio(folio)) {
>>>>> +					if (folio != fault_folio)
>>>>> +						folio_unlock(folio);
>>>>> +					ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>>>> +					goto next;
>>>>> +				}
>>>>> +
>>>> The nouveau migrate_to_ram handler needs adjustment also if split happens.
>>>>
>>> test_hmm needs adjustment because of the way the backup folios are setup.
>> nouveau should check the folio order after the possible split happens.
>>
> You mean the folio_split callback?

no, nouveau_dmem_migrate_to_ram():
..
        sfolio = page_folio(vmf->page);
        order = folio_order(sfolio);
...
        migrate_vma_setup()
..
if sfolio is split order still reflects the pre-split order

>
>>>>> +				/*
>>>>> +				 * After the split, get back the extra reference
>>>>> +				 * on the fault_page, this reference is checked during
>>>>> +				 * folio_migrate_mapping()
>>>>> +				 */
>>>>> +				if (migrate->fault_page) {
>>>>> +					new_fault_folio = page_folio(migrate->fault_page);
>>>>> +					folio_get(new_fault_folio);
>>>>> +				}
>>>>> +
>>>>> +				new_folio = page_folio(page);
>>>>> +				pfn = page_to_pfn(page);
>>>>> +
>>>>> +				/*
>>>>> +				 * Ensure the lock is held on the correct
>>>>> +				 * folio after the split
>>>>> +				 */
>>>>> +				if (folio != new_folio) {
>>>>> +					folio_unlock(folio);
>>>>> +					folio_lock(new_folio);
>>>>> +				}
>>>> Maybe careful not to unlock fault_page ?
>>>>
>>> split_page will unlock everything but the original folio, the code takes the lock
>>> on the folio corresponding to the new folio
>> I mean do_swap_page() unlocks folio of fault_page and expects it to remain locked.
>>
> Not sure I follow what you're trying to elaborate on here

do_swap_page:
..
        if (trylock_page(vmf->page)) {
                ret = pgmap->ops->migrate_to_ram(vmf);
                               <- vmf->page should be locked here even after split
                unlock_page(vmf->page);

> Balbir
>
--Mika



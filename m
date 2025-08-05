Return-Path: <linux-kernel+bounces-756278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA8B1B238
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FDC18935F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31DD238C04;
	Tue,  5 Aug 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYjqzzL4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8C2376FC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390822; cv=none; b=ZlbuGWlfPIVohSmqR7hTGZXUKbdSmoT8itDIl53/IJe1OqELw6159aAMnp7wIPalw2wdhb3kjQxqMXDY1kFwaLojL3MnfQdPYNVqmM/rgVNrLzKw/qZfCKEuQYaU6gfkx4N0ky2EAUcO9z+0oXwNRDiaaFsioMxr16DQDzPs148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390822; c=relaxed/simple;
	bh=VBp86IUrGuile9rvR/+BhRH8QefDTYlkuOL6DfbX7hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpljyyEQ0O0hxoeQ+gpvW5t9J2JwibsoZUg4044rBf0cvizlet3X8TAD3AaBeJXlQDV06s2nNM2Xos57yY4h3fsidta8S4CG/l60kU0TUJ8ZT2YOdRd3hfhALoZ53EdjgC05IfHMQSP2EipBojpiNtUhtuDyEabf+VZjt/DYnxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYjqzzL4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754390820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wk5GXKT9wz3dvDgQdeYLI9qgkV6XRvZlyWZQe8HtFwg=;
	b=IYjqzzL4e3GxfKT4ospdpllArqQwSYk2Y5d0Ch8ZGz65BBxSw1Vy6fmXFi8pmPr/vs1Vdm
	hjxBRKPDNUgVOt+t7vatshaaIPMPN6x7KnnEIfPlLaLub4cYVO2wkWxo8/97NURO2ZTlcb
	jkCrzvqxXx0DFfC2G/J1bTdgITLWKHU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-pgTEygjpOMqyfpN6HQ0f2Q-1; Tue, 05 Aug 2025 06:46:58 -0400
X-MC-Unique: pgTEygjpOMqyfpN6HQ0f2Q-1
X-Mimecast-MFC-AGG-ID: pgTEygjpOMqyfpN6HQ0f2Q_1754390817
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55b8422dbdaso2883379e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390817; x=1754995617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wk5GXKT9wz3dvDgQdeYLI9qgkV6XRvZlyWZQe8HtFwg=;
        b=TUVHc9xrknwzyjnuKEe6249s6i5sPyGV90hWOlTo9EhxtdjZryMqKUSaUtxvltq04P
         MLbFRw0UNCSnjUhuywy+7jiqGYUnZ8xMhh6viomcBJb8PML+OI0kT2sik4v8GNyHRxcD
         stNuUu79uKdayuJsmVOPlwyJ5i4jS8sLWHFmgk55+1HlF/bCNnfbs7piRPx6ZgtUG3fS
         uKEeBeWGyhX37ON/lNMOig2fdMUUombaZTwuOdh2u/izvnIjJsnO9hepkCels4wXlk5z
         GkcqvIo9M0q+xCAdTFxy1wiO3EGYoM/dhF7MH57D0mv2UDeCCGVDlXRphtHIVmCLhUIr
         SmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4HV7UEl+auTRYo21GVicy5g2kIc/R6p/uUzFjqiZN656ii+evOPMKGbczf6LmLrP1Q85O6Q0iPpiQ1J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIELEvTRltoPQf+kXJHnIQBZTU/RcbhVjQNUeGoat9/vSKSg2c
	o3cihnqjXCmjYUq3wg5wINYhP+p4SOCzvnBjQNScF2if4etLbEPyBoIpfQi9IAuA/YGWjBH7na0
	4U+N0LVzAHIh9lT+7KqHEibBVsSYf3GfBh2Gk/IbSEw+YaSQya/yIkxBk4MB8tvM8
X-Gm-Gg: ASbGncseOlTTfy2ZC76q/yEpoBRhoekv1p9OknXra/UzGEYWsVVp/BsyX+sl91xfuSM
	DW227zZ7hLbBt9yOYZGssaq9mh3Pmoqjy0aEUQWwYb5mAYx0Yjxjasd5BYkQ6wUoglZfVmt4wdI
	Bs/cto9wOsqSaQPPe/ShI8/35Haoutj0Y8y+wo4shJyeHS7yy/evX2tnTHH5TE2sevSkV2xelat
	QcaASeO/maDvSbjLTGZuRX9o7HN2yl317LwcRGYPD2rxdoU6eHLROvizDTJy9hQcGxW+q/rAIWv
	am7G7iDcLE8jJzyFfBNyll4/JgJ0m9spn+w1ZB6fHhk7kjNyaccxVABrs5gfkM22AA==
X-Received: by 2002:a05:6512:3b07:b0:55b:958f:8c2f with SMTP id 2adb3069b0e04-55b97b9f381mr4069008e87.49.1754390816960;
        Tue, 05 Aug 2025 03:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd9Bp5Ekm55BL1kqJkB8HhmkPyDmXgdV3CuPhFjBM5LjSOKm7EIc8UH12gC8OvPnbsri0MZA==
X-Received: by 2002:a05:6512:3b07:b0:55b:958f:8c2f with SMTP id 2adb3069b0e04-55b97b9f381mr4068990e87.49.1754390816427;
        Tue, 05 Aug 2025 03:46:56 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99041sm1928200e87.81.2025.08.05.03.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:46:55 -0700 (PDT)
Message-ID: <b6ac5739-03a4-4abf-b492-b009ad523474@redhat.com>
Date: Tue, 5 Aug 2025 13:46:55 +0300
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
 <6a08fa8f-bc39-4389-aa52-d95f82538a91@redhat.com>
 <6442f975-6363-4969-a0bf-55d06eec9528@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <6442f975-6363-4969-a0bf-55d06eec9528@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/5/25 13:36, Balbir Singh wrote:
> On 8/5/25 20:35, Mika Penttilä wrote:
>> On 8/5/25 13:27, Balbir Singh wrote:
>>
>>> On 8/5/25 14:24, Mika Penttilä wrote:
>>>> Hi,
>>>>
>>>> On 8/5/25 07:10, Balbir Singh wrote:
>>>>> On 8/5/25 09:26, Mika Penttilä wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 8/5/25 01:46, Balbir Singh wrote:
>>>>>>> On 8/2/25 22:13, Mika Penttilä wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 8/2/25 13:37, Balbir Singh wrote:
>>>>>>>>> FYI:
>>>>>>>>>
>>>>>>>>> I have the following patch on top of my series that seems to make it work
>>>>>>>>> without requiring the helper to split device private folios
>>>>>>>>>
>>>>>>>> I think this looks much better!
>>>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>>>>>> ---
>>>>>>>>>  include/linux/huge_mm.h |  1 -
>>>>>>>>>  lib/test_hmm.c          | 11 +++++-
>>>>>>>>>  mm/huge_memory.c        | 76 ++++-------------------------------------
>>>>>>>>>  mm/migrate_device.c     | 51 +++++++++++++++++++++++++++
>>>>>>>>>  4 files changed, 67 insertions(+), 72 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>>>>> index 19e7e3b7c2b7..52d8b435950b 100644
>>>>>>>>> --- a/include/linux/huge_mm.h
>>>>>>>>> +++ b/include/linux/huge_mm.h
>>>>>>>>> @@ -343,7 +343,6 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>>>>>>>>>  		vm_flags_t vm_flags);
>>>>>>>>>  
>>>>>>>>>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>>>>>>>>> -int split_device_private_folio(struct folio *folio);
>>>>>>>>>  int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>>>>>>  		unsigned int new_order, bool unmapped);
>>>>>>>>>  int min_order_for_split(struct folio *folio);
>>>>>>>>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>>>>>>>>> index 341ae2af44ec..444477785882 100644
>>>>>>>>> --- a/lib/test_hmm.c
>>>>>>>>> +++ b/lib/test_hmm.c
>>>>>>>>> @@ -1625,13 +1625,22 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
>>>>>>>>>  	 * the mirror but here we use it to hold the page for the simulated
>>>>>>>>>  	 * device memory and that page holds the pointer to the mirror.
>>>>>>>>>  	 */
>>>>>>>>> -	rpage = vmf->page->zone_device_data;
>>>>>>>>> +	rpage = folio_page(page_folio(vmf->page), 0)->zone_device_data;
>>>>>>>>>  	dmirror = rpage->zone_device_data;
>>>>>>>>>  
>>>>>>>>>  	/* FIXME demonstrate how we can adjust migrate range */
>>>>>>>>>  	order = folio_order(page_folio(vmf->page));
>>>>>>>>>  	nr = 1 << order;
>>>>>>>>>  
>>>>>>>>> +	/*
>>>>>>>>> +	 * When folios are partially mapped, we can't rely on the folio
>>>>>>>>> +	 * order of vmf->page as the folio might not be fully split yet
>>>>>>>>> +	 */
>>>>>>>>> +	if (vmf->pte) {
>>>>>>>>> +		order = 0;
>>>>>>>>> +		nr = 1;
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>>  	/*
>>>>>>>>>  	 * Consider a per-cpu cache of src and dst pfns, but with
>>>>>>>>>  	 * large number of cpus that might not scale well.
>>>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>>>>> index 1fc1efa219c8..863393dec1f1 100644
>>>>>>>>> --- a/mm/huge_memory.c
>>>>>>>>> +++ b/mm/huge_memory.c
>>>>>>>>> @@ -72,10 +72,6 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
>>>>>>>>>  					  struct shrink_control *sc);
>>>>>>>>>  static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>>>>>>>  					 struct shrink_control *sc);
>>>>>>>>> -static int __split_unmapped_folio(struct folio *folio, int new_order,
>>>>>>>>> -		struct page *split_at, struct xa_state *xas,
>>>>>>>>> -		struct address_space *mapping, bool uniform_split);
>>>>>>>>> -
>>>>>>>>>  static bool split_underused_thp = true;
>>>>>>>>>  
>>>>>>>>>  static atomic_t huge_zero_refcount;
>>>>>>>>> @@ -2924,51 +2920,6 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
>>>>>>>>>  	pmd_populate(mm, pmd, pgtable);
>>>>>>>>>  }
>>>>>>>>>  
>>>>>>>>> -/**
>>>>>>>>> - * split_huge_device_private_folio - split a huge device private folio into
>>>>>>>>> - * smaller pages (of order 0), currently used by migrate_device logic to
>>>>>>>>> - * split folios for pages that are partially mapped
>>>>>>>>> - *
>>>>>>>>> - * @folio: the folio to split
>>>>>>>>> - *
>>>>>>>>> - * The caller has to hold the folio_lock and a reference via folio_get
>>>>>>>>> - */
>>>>>>>>> -int split_device_private_folio(struct folio *folio)
>>>>>>>>> -{
>>>>>>>>> -	struct folio *end_folio = folio_next(folio);
>>>>>>>>> -	struct folio *new_folio;
>>>>>>>>> -	int ret = 0;
>>>>>>>>> -
>>>>>>>>> -	/*
>>>>>>>>> -	 * Split the folio now. In the case of device
>>>>>>>>> -	 * private pages, this path is executed when
>>>>>>>>> -	 * the pmd is split and since freeze is not true
>>>>>>>>> -	 * it is likely the folio will be deferred_split.
>>>>>>>>> -	 *
>>>>>>>>> -	 * With device private pages, deferred splits of
>>>>>>>>> -	 * folios should be handled here to prevent partial
>>>>>>>>> -	 * unmaps from causing issues later on in migration
>>>>>>>>> -	 * and fault handling flows.
>>>>>>>>> -	 */
>>>>>>>>> -	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>>>>> -	ret = __split_unmapped_folio(folio, 0, &folio->page, NULL, NULL, true);
>>>>>>>>> -	VM_WARN_ON(ret);
>>>>>>>>> -	for (new_folio = folio_next(folio); new_folio != end_folio;
>>>>>>>>> -					new_folio = folio_next(new_folio)) {
>>>>>>>>> -		zone_device_private_split_cb(folio, new_folio);
>>>>>>>>> -		folio_ref_unfreeze(new_folio, 1 + folio_expected_ref_count(
>>>>>>>>> -								new_folio));
>>>>>>>>> -	}
>>>>>>>>> -
>>>>>>>>> -	/*
>>>>>>>>> -	 * Mark the end of the folio split for device private THP
>>>>>>>>> -	 * split
>>>>>>>>> -	 */
>>>>>>>>> -	zone_device_private_split_cb(folio, NULL);
>>>>>>>>> -	folio_ref_unfreeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>>>>> -	return ret;
>>>>>>>>> -}
>>>>>>>>> -
>>>>>>>>>  static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>>>>>  		unsigned long haddr, bool freeze)
>>>>>>>>>  {
>>>>>>>>> @@ -3064,30 +3015,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>>>>>  				freeze = false;
>>>>>>>>>  			if (!freeze) {
>>>>>>>>>  				rmap_t rmap_flags = RMAP_NONE;
>>>>>>>>> -				unsigned long addr = haddr;
>>>>>>>>> -				struct folio *new_folio;
>>>>>>>>> -				struct folio *end_folio = folio_next(folio);
>>>>>>>>>  
>>>>>>>>>  				if (anon_exclusive)
>>>>>>>>>  					rmap_flags |= RMAP_EXCLUSIVE;
>>>>>>>>>  
>>>>>>>>> -				folio_lock(folio);
>>>>>>>>> -				folio_get(folio);
>>>>>>>>> -
>>>>>>>>> -				split_device_private_folio(folio);
>>>>>>>>> -
>>>>>>>>> -				for (new_folio = folio_next(folio);
>>>>>>>>> -					new_folio != end_folio;
>>>>>>>>> -					new_folio = folio_next(new_folio)) {
>>>>>>>>> -					addr += PAGE_SIZE;
>>>>>>>>> -					folio_unlock(new_folio);
>>>>>>>>> -					folio_add_anon_rmap_ptes(new_folio,
>>>>>>>>> -						&new_folio->page, 1,
>>>>>>>>> -						vma, addr, rmap_flags);
>>>>>>>>> -				}
>>>>>>>>> -				folio_unlock(folio);
>>>>>>>>> -				folio_add_anon_rmap_ptes(folio, &folio->page,
>>>>>>>>> -						1, vma, haddr, rmap_flags);
>>>>>>>>> +				folio_ref_add(folio, HPAGE_PMD_NR - 1);
>>>>>>>>> +				if (anon_exclusive)
>>>>>>>>> +					rmap_flags |= RMAP_EXCLUSIVE;
>>>>>>>>> +				folio_add_anon_rmap_ptes(folio, page, HPAGE_PMD_NR,
>>>>>>>>> +						 vma, haddr, rmap_flags);
>>>>>>>>>  			}
>>>>>>>>>  		}
>>>>>>>>>  
>>>>>>>>> @@ -4065,7 +4001,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>>>  	if (nr_shmem_dropped)
>>>>>>>>>  		shmem_uncharge(mapping->host, nr_shmem_dropped);
>>>>>>>>>  
>>>>>>>>> -	if (!ret && is_anon)
>>>>>>>>> +	if (!ret && is_anon && !folio_is_device_private(folio))
>>>>>>>>>  		remap_flags = RMP_USE_SHARED_ZEROPAGE;
>>>>>>>>>  
>>>>>>>>>  	remap_page(folio, 1 << order, remap_flags);
>>>>>>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>>>>>>> index 49962ea19109..4264c0290d08 100644
>>>>>>>>> --- a/mm/migrate_device.c
>>>>>>>>> +++ b/mm/migrate_device.c
>>>>>>>>> @@ -248,6 +248,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>>>>>>  			 * page table entry. Other special swap entries are not
>>>>>>>>>  			 * migratable, and we ignore regular swapped page.
>>>>>>>>>  			 */
>>>>>>>>> +			struct folio *folio;
>>>>>>>>> +
>>>>>>>>>  			entry = pte_to_swp_entry(pte);
>>>>>>>>>  			if (!is_device_private_entry(entry))
>>>>>>>>>  				goto next;
>>>>>>>>> @@ -259,6 +261,55 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>>>>>>  			    pgmap->owner != migrate->pgmap_owner)
>>>>>>>>>  				goto next;
>>>>>>>>>  
>>>>>>>>> +			folio = page_folio(page);
>>>>>>>>> +			if (folio_test_large(folio)) {
>>>>>>>>> +				struct folio *new_folio;
>>>>>>>>> +				struct folio *new_fault_folio;
>>>>>>>>> +
>>>>>>>>> +				/*
>>>>>>>>> +				 * The reason for finding pmd present with a
>>>>>>>>> +				 * device private pte and a large folio for the
>>>>>>>>> +				 * pte is partial unmaps. Split the folio now
>>>>>>>>> +				 * for the migration to be handled correctly
>>>>>>>>> +				 */
>>>>>>>>> +				pte_unmap_unlock(ptep, ptl);
>>>>>>>>> +
>>>>>>>>> +				folio_get(folio);
>>>>>>>>> +				if (folio != fault_folio)
>>>>>>>>> +					folio_lock(folio);
>>>>>>>>> +				if (split_folio(folio)) {
>>>>>>>>> +					if (folio != fault_folio)
>>>>>>>>> +						folio_unlock(folio);
>>>>>>>>> +					ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>>>>>>>> +					goto next;
>>>>>>>>> +				}
>>>>>>>>> +
>>>>>>>> The nouveau migrate_to_ram handler needs adjustment also if split happens.
>>>>>>>>
>>>>>>> test_hmm needs adjustment because of the way the backup folios are setup.
>>>>>> nouveau should check the folio order after the possible split happens.
>>>>>>
>>>>> You mean the folio_split callback?
>>>> no, nouveau_dmem_migrate_to_ram():
>>>> ..
>>>>         sfolio = page_folio(vmf->page);
>>>>         order = folio_order(sfolio);
>>>> ...
>>>>         migrate_vma_setup()
>>>> ..
>>>> if sfolio is split order still reflects the pre-split order
>>>>
>>> Will fix, good catch!
>>>
>>>>>>>>> +				/*
>>>>>>>>> +				 * After the split, get back the extra reference
>>>>>>>>> +				 * on the fault_page, this reference is checked during
>>>>>>>>> +				 * folio_migrate_mapping()
>>>>>>>>> +				 */
>>>>>>>>> +				if (migrate->fault_page) {
>>>>>>>>> +					new_fault_folio = page_folio(migrate->fault_page);
>>>>>>>>> +					folio_get(new_fault_folio);
>>>>>>>>> +				}
>>>>>>>>> +
>>>>>>>>> +				new_folio = page_folio(page);
>>>>>>>>> +				pfn = page_to_pfn(page);
>>>>>>>>> +
>>>>>>>>> +				/*
>>>>>>>>> +				 * Ensure the lock is held on the correct
>>>>>>>>> +				 * folio after the split
>>>>>>>>> +				 */
>>>>>>>>> +				if (folio != new_folio) {
>>>>>>>>> +					folio_unlock(folio);
>>>>>>>>> +					folio_lock(new_folio);
>>>>>>>>> +				}
>>>>>>>> Maybe careful not to unlock fault_page ?
>>>>>>>>
>>>>>>> split_page will unlock everything but the original folio, the code takes the lock
>>>>>>> on the folio corresponding to the new folio
>>>>>> I mean do_swap_page() unlocks folio of fault_page and expects it to remain locked.
>>>>>>
>>>>> Not sure I follow what you're trying to elaborate on here
>>>> do_swap_page:
>>>> ..
>>>>         if (trylock_page(vmf->page)) {
>>>>                 ret = pgmap->ops->migrate_to_ram(vmf);
>>>>                                <- vmf->page should be locked here even after split
>>>>                 unlock_page(vmf->page);
>>>>
>>> Yep, the split will unlock all tail folios, leaving the just head folio locked
>>> and this the change, the lock we need to hold is the folio lock associated with
>>> fault_page, pte entry and not unlock when the cause is a fault. The code seems
>>> to do the right thing there, let me double check
>> Yes the fault case is ok. But if migrate not for a fault, we should not leave any page locked
>>
> migrate_vma_finalize() handles this

But we are in migrate_vma_collect_pmd() after the split, and try to collect the pte, locking the page again.
So needs to be unlocked after the split.

>
> Balbir
>



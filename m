Return-Path: <linux-kernel+bounces-765698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68458B23CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3A7188F3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD7C8FE;
	Wed, 13 Aug 2025 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWVvdBO7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F6E4685
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043657; cv=none; b=BN5aP2cA8IWFyO6ieDWfPABJmBFQIknx9d+qX6R4z7lX4XpG84RtxAFSxC/Xuns/+a9QTB7kfP4Xpjp423N5OIEQlso+WDqvXzdGKBtlHF5pcpWP/XiEZA4dDj1zQNLSBkxtBeXZAC3T/Hii9SD2TGiaZPvySBikrL2yEB/OHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043657; c=relaxed/simple;
	bh=2fqkw/lRRTrk3KPaRMlDj8tT2MWA9TSioixIsFc9tsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+6HWp0nscUl7h2xzmxgirRC2EG9eby/KO0+UlhQb3i47k0iSpXc95wFNbPlZlLHirNhSUym1nAijZe67hx/yQyjQUJwS60eelMJnxyplHxIvO7j/8seVFVOmcAsAwD6nTKxyQSZtiLfJNnL+kvCY5tFIIaoSP/G2hPI+OPbEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWVvdBO7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755043653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0a9MFRY1h7MOvR8Wbw07bYMzAo5BjE+mq1YNqJVPV/0=;
	b=eWVvdBO7kaWROlDpyH76CeXgbDoIGb8ozYls2T8GjRxtaf8pNlhFnmKHR5xJ9YbMI9fAlC
	uXRR5C15jRD3SDvX1YKBLCDanjjAwJr7ycrCZdldPfg8UXJp59hXqHFPL7frVH0H8RGVRI
	f8vc62d8waV+rZpApNyxa4vV441CpCA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-4wNsSc2FMQyWHN2977brjQ-1; Tue, 12 Aug 2025 20:07:31 -0400
X-MC-Unique: 4wNsSc2FMQyWHN2977brjQ-1
X-Mimecast-MFC-AGG-ID: 4wNsSc2FMQyWHN2977brjQ_1755043650
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55ba198c6f6so5451731e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755043650; x=1755648450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0a9MFRY1h7MOvR8Wbw07bYMzAo5BjE+mq1YNqJVPV/0=;
        b=TaOTZ/m3qOpYBmatwP65MHNtAgG/JJS4j06c6bqGXkh8PSvSS5ndyZNlyN5AbtE7Vf
         WSmmSyYLY2ElVIM1IoAu/n6haIDQyqomzWCTW8fFwwx7rorTJX53aCeuGl4r9ciUu7cY
         aA4QhS14PGB0xZa3rS6a6kQ1886TQJUdYa02lDvqe7jOi+EidNjkRR7uonAqmTlRFVx5
         fPth1GSIYZHam5AWaMU98Iu2evtF43GZMev8VL4GFuajxYK/Ll87xc6Lzw7k0I01TBEa
         agHr9iKDrmoVTa+LHCR7q+7fF5F0uNjC8UZ+Y1EyNCM/hyWihaZVfgdjm4VMGxxETnqJ
         1pew==
X-Forwarded-Encrypted: i=1; AJvYcCW0tTNpRGgBWO9FD4i1mutVAmCMG+FzAxMHGvDwg9vaHEojffI0n+KTwjGbl0dOY0wzvhgSdQXtE6BclHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQJGh3+Eectv/HKgtsn0ckD6dRTbeR/VZcrX9gH09OsVxJ7Da
	OTZiZZKmKSX2z4YlOLw2czY7enW5CU8gwEAVJW6+yERIKSh/L9arZe/eIhsVBopgS7Qu/bVLTyl
	xTIwuIse7wuiQ5ep1uspvmTT5ylvMSbc4WZI65j666Qy+xs2wjD3n4r0lz63QDUm3
X-Gm-Gg: ASbGncvoAWAneNV3ste82+msliBOKV9gXZZ0a8ASr6YztP1P+obeQdAD/RVS5bXrs6P
	OB0YrxV676gf71akA+YZh7ZZ0VPYp0DJvaBbw0XWni8Mr1bu3d6R5AioxUhplnxYFpKtReWrq7v
	jaLh7nRQ+xg9LwPoVh1yNM95blo4Ce04JlwhOFDUVAxZtwWAbyMQs8pAKDwej6FwO4XOR5QeyAb
	QIwkGSZZMxt6ut0rHHUIwvAi3MAcIhRVH/TIZSbW5m7QSfFIRSccuic1xWPYf11MdNSqLOtJlas
	udUsl+b6lMXDmdJvzHCNqF53ZIfsqZyctwhOE3IplusNNdXUdl8s4XXxXAeMS+1B0Q==
X-Received: by 2002:a05:6512:ba1:b0:55b:8afb:e638 with SMTP id 2adb3069b0e04-55ce03b91b8mr315107e87.28.1755043650224;
        Tue, 12 Aug 2025 17:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoQmb2RmNCvZXTt3hToKciHGnkn/S73hvzckTVORzr7wB8qpotmzY9QkrR7LiLIPfgHMO0bA==
X-Received: by 2002:a05:6512:ba1:b0:55b:8afb:e638 with SMTP id 2adb3069b0e04-55ce03b91b8mr315092e87.28.1755043649706;
        Tue, 12 Aug 2025 17:07:29 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898be9bsm5046839e87.12.2025.08.12.17.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 17:07:29 -0700 (PDT)
Message-ID: <23a3e9b9-ad35-4469-884d-279aac0868de@redhat.com>
Date: Wed, 13 Aug 2025 03:07:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 03/11] mm/migrate_device: THP migration of zone device pages
To: Balbir Singh <balbirs@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250812024036.690064-1-balbirs@nvidia.com>
 <20250812024036.690064-4-balbirs@nvidia.com>
 <81ca37d5-b1ff-46de-8dcc-b222af350c77@redhat.com>
 <9207451b-ebd1-46d5-b277-2adf3028f361@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <9207451b-ebd1-46d5-b277-2adf3028f361@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/13/25 02:36, Balbir Singh wrote:

> On 8/12/25 15:35, Mika Penttilä wrote:
>> Hi,
>>
>> On 8/12/25 05:40, Balbir Singh wrote:
>>
>>> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
>>> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
>>> device pages as compound pages during device pfn migration.
>>>
>>> migrate_device code paths go through the collect, setup
>>> and finalize phases of migration.
>>>
>>> The entries in src and dst arrays passed to these functions still
>>> remain at a PAGE_SIZE granularity. When a compound page is passed,
>>> the first entry has the PFN along with MIGRATE_PFN_COMPOUND
>>> and other flags set (MIGRATE_PFN_MIGRATE, MIGRATE_PFN_VALID), the
>>> remaining entries (HPAGE_PMD_NR - 1) are filled with 0's. This
>>> representation allows for the compound page to be split into smaller
>>> page sizes.
>>>
>>> migrate_vma_collect_hole(), migrate_vma_collect_pmd() are now THP
>>> page aware. Two new helper functions migrate_vma_collect_huge_pmd()
>>> and migrate_vma_insert_huge_pmd_page() have been added.
>>>
>>> migrate_vma_collect_huge_pmd() can collect THP pages, but if for
>>> some reason this fails, there is fallback support to split the folio
>>> and migrate it.
>>>
>>> migrate_vma_insert_huge_pmd_page() closely follows the logic of
>>> migrate_vma_insert_page()
>>>
>>> Support for splitting pages as needed for migration will follow in
>>> later patches in this series.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>>> Cc: Rakie Kim <rakie.kim@sk.com>
>>> Cc: Byungchul Park <byungchul@sk.com>
>>> Cc: Gregory Price <gourry@gourry.net>
>>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>> Cc: Nico Pache <npache@redhat.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Dev Jain <dev.jain@arm.com>
>>> Cc: Barry Song <baohua@kernel.org>
>>> Cc: Lyude Paul <lyude@redhat.com>
>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Simona Vetter <simona@ffwll.ch>
>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>
>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>> ---
>>>  include/linux/migrate.h |   2 +
>>>  mm/migrate_device.c     | 457 ++++++++++++++++++++++++++++++++++------
>>>  2 files changed, 396 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>> index acadd41e0b5c..d9cef0819f91 100644
>>> --- a/include/linux/migrate.h
>>> +++ b/include/linux/migrate.h
>>> @@ -129,6 +129,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>>>  #define MIGRATE_PFN_VALID	(1UL << 0)
>>>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>>>  #define MIGRATE_PFN_WRITE	(1UL << 3)
>>> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>>>  #define MIGRATE_PFN_SHIFT	6
>>>  
>>>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
>>> @@ -147,6 +148,7 @@ enum migrate_vma_direction {
>>>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>>>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
>>>  	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
>>> +	MIGRATE_VMA_SELECT_COMPOUND = 1 << 3,
>>>  };
>>>  
>>>  struct migrate_vma {
>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>> index 0ed337f94fcd..6621bba62710 100644
>>> --- a/mm/migrate_device.c
>>> +++ b/mm/migrate_device.c
>>> @@ -14,6 +14,7 @@
>>>  #include <linux/pagewalk.h>
>>>  #include <linux/rmap.h>
>>>  #include <linux/swapops.h>
>>> +#include <asm/pgalloc.h>
>>>  #include <asm/tlbflush.h>
>>>  #include "internal.h"
>>>  
>>> @@ -44,6 +45,23 @@ static int migrate_vma_collect_hole(unsigned long start,
>>>  	if (!vma_is_anonymous(walk->vma))
>>>  		return migrate_vma_collect_skip(start, end, walk);
>>>  
>>> +	if (thp_migration_supported() &&
>>> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
>>> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
>>> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
>>> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
>>> +						MIGRATE_PFN_COMPOUND;
>>> +		migrate->dst[migrate->npages] = 0;
>>> +		migrate->npages++;
>>> +		migrate->cpages++;
>>> +
>>> +		/*
>>> +		 * Collect the remaining entries as holes, in case we
>>> +		 * need to split later
>>> +		 */
>>> +		return migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
>>> +	}
>>> +
>>>  	for (addr = start; addr < end; addr += PAGE_SIZE) {
>>>  		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
>>>  		migrate->dst[migrate->npages] = 0;
>>> @@ -54,57 +72,151 @@ static int migrate_vma_collect_hole(unsigned long start,
>>>  	return 0;
>>>  }
>>>  
>>> -static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>> -				   unsigned long start,
>>> -				   unsigned long end,
>>> -				   struct mm_walk *walk)
>>> +/**
>>> + * migrate_vma_collect_huge_pmd - collect THP pages without splitting the
>>> + * folio for device private pages.
>>> + * @pmdp: pointer to pmd entry
>>> + * @start: start address of the range for migration
>>> + * @end: end address of the range for migration
>>> + * @walk: mm_walk callback structure
>>> + *
>>> + * Collect the huge pmd entry at @pmdp for migration and set the
>>> + * MIGRATE_PFN_COMPOUND flag in the migrate src entry to indicate that
>>> + * migration will occur at HPAGE_PMD granularity
>>> + */
>>> +static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
>>> +					unsigned long end, struct mm_walk *walk,
>>> +					struct folio *fault_folio)
>>>  {
>>> +	struct mm_struct *mm = walk->mm;
>>> +	struct folio *folio;
>>>  	struct migrate_vma *migrate = walk->private;
>>> -	struct folio *fault_folio = migrate->fault_page ?
>>> -		page_folio(migrate->fault_page) : NULL;
>>> -	struct vm_area_struct *vma = walk->vma;
>>> -	struct mm_struct *mm = vma->vm_mm;
>>> -	unsigned long addr = start, unmapped = 0;
>>>  	spinlock_t *ptl;
>>> -	pte_t *ptep;
>>> +	swp_entry_t entry;
>>> +	int ret;
>>> +	unsigned long write = 0;
>>>  
>>> -again:
>>> -	if (pmd_none(*pmdp))
>>> +	ptl = pmd_lock(mm, pmdp);
>>> +	if (pmd_none(*pmdp)) {
>>> +		spin_unlock(ptl);
>>>  		return migrate_vma_collect_hole(start, end, -1, walk);
>>> +	}
>>>  
>>>  	if (pmd_trans_huge(*pmdp)) {
>>> -		struct folio *folio;
>>> -
>>> -		ptl = pmd_lock(mm, pmdp);
>>> -		if (unlikely(!pmd_trans_huge(*pmdp))) {
>>> +		if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
>>>  			spin_unlock(ptl);
>>> -			goto again;
>>> +			return migrate_vma_collect_skip(start, end, walk);
>>>  		}
>>>  
>>>  		folio = pmd_folio(*pmdp);
>>>  		if (is_huge_zero_folio(folio)) {
>>>  			spin_unlock(ptl);
>>> -			split_huge_pmd(vma, pmdp, addr);
>>> -		} else {
>>> -			int ret;
>>> +			return migrate_vma_collect_hole(start, end, -1, walk);
>>> +		}
>>> +		if (pmd_write(*pmdp))
>>> +			write = MIGRATE_PFN_WRITE;
>>> +	} else if (!pmd_present(*pmdp)) {
>>> +		entry = pmd_to_swp_entry(*pmdp);
>>> +		folio = pfn_swap_entry_folio(entry);
>>> +
>>> +		if (!is_device_private_entry(entry) ||
>>> +			!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
>>> +			(folio->pgmap->owner != migrate->pgmap_owner)) {
>>> +			spin_unlock(ptl);
>>> +			return migrate_vma_collect_skip(start, end, walk);
>>> +		}
>>>  
>>> -			folio_get(folio);
>>> +		if (is_migration_entry(entry)) {
>>> +			migration_entry_wait_on_locked(entry, ptl);
>>>  			spin_unlock(ptl);
>>> -			/* FIXME: we don't expect THP for fault_folio */
>>> -			if (WARN_ON_ONCE(fault_folio == folio))
>>> -				return migrate_vma_collect_skip(start, end,
>>> -								walk);
>>> -			if (unlikely(!folio_trylock(folio)))
>>> -				return migrate_vma_collect_skip(start, end,
>>> -								walk);
>>> -			ret = split_folio(folio);
>>> -			if (fault_folio != folio)
>>> -				folio_unlock(folio);
>>> -			folio_put(folio);
>>> -			if (ret)
>>> -				return migrate_vma_collect_skip(start, end,
>>> -								walk);
>>> +			return -EAGAIN;
>>>  		}
>>> +
>>> +		if (is_writable_device_private_entry(entry))
>>> +			write = MIGRATE_PFN_WRITE;
>>> +	} else {
>>> +		spin_unlock(ptl);
>>> +		return -EAGAIN;
>>> +	}
>>> +
>>> +	folio_get(folio);
>>> +	if (folio != fault_folio && unlikely(!folio_trylock(folio))) {
>>> +		spin_unlock(ptl);
>>> +		folio_put(folio);
>>> +		return migrate_vma_collect_skip(start, end, walk);
>>> +	}
>>> +
>>> +	if (thp_migration_supported() &&
>>> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
>>> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
>>> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
>>> +
>>> +		struct page_vma_mapped_walk pvmw = {
>>> +			.ptl = ptl,
>>> +			.address = start,
>>> +			.pmd = pmdp,
>>> +			.vma = walk->vma,
>>> +		};
>>> +
>>> +		unsigned long pfn = page_to_pfn(folio_page(folio, 0));
>>> +
>>> +		migrate->src[migrate->npages] = migrate_pfn(pfn) | write
>>> +						| MIGRATE_PFN_MIGRATE
>>> +						| MIGRATE_PFN_COMPOUND;
>>> +		migrate->dst[migrate->npages++] = 0;
>>> +		migrate->cpages++;
>>> +		ret = set_pmd_migration_entry(&pvmw, folio_page(folio, 0));
>>> +		if (ret) {
>>> +			migrate->npages--;
>>> +			migrate->cpages--;
>>> +			migrate->src[migrate->npages] = 0;
>>> +			migrate->dst[migrate->npages] = 0;
>>> +			goto fallback;
>>> +		}
>>> +		migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
>>> +		spin_unlock(ptl);
>>> +		return 0;
>>> +	}
>>> +
>>> +fallback:
>>> +	spin_unlock(ptl);
>>> +	if (!folio_test_large(folio))
>>> +		goto done;
>>> +	ret = split_folio(folio);
>>> +	if (fault_folio != folio)
>>> +		folio_unlock(folio);
>>> +	folio_put(folio);
>>> +	if (ret)
>>> +		return migrate_vma_collect_skip(start, end, walk);
>>> +	if (pmd_none(pmdp_get_lockless(pmdp)))
>>> +		return migrate_vma_collect_hole(start, end, -1, walk);
>>> +
>>> +done:
>>> +	return -ENOENT;
>>> +}
>>> +
>>> +static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>> +				   unsigned long start,
>>> +				   unsigned long end,
>>> +				   struct mm_walk *walk)
>>> +{
>>> +	struct migrate_vma *migrate = walk->private;
>>> +	struct vm_area_struct *vma = walk->vma;
>>> +	struct mm_struct *mm = vma->vm_mm;
>>> +	unsigned long addr = start, unmapped = 0;
>>> +	spinlock_t *ptl;
>>> +	struct folio *fault_folio = migrate->fault_page ?
>>> +		page_folio(migrate->fault_page) : NULL;
>>> +	pte_t *ptep;
>>> +
>>> +again:
>>> +	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
>>> +		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
>>> +
>>> +		if (ret == -EAGAIN)
>>> +			goto again;
>>> +		if (ret == 0)
>>> +			return 0;
>>>  	}
>>>  
>>>  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>> @@ -222,8 +334,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>  			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
>>>  		}
>>>  
>>> -		/* FIXME support THP */
>>> -		if (!page || !page->mapping || PageTransCompound(page)) {
>>> +		if (!page || !page->mapping) {
>>>  			mpfn = 0;
>>>  			goto next;
>>>  		}
>>> @@ -394,14 +505,6 @@ static bool migrate_vma_check_page(struct page *page, struct page *fault_page)
>>>  	 */
>>>  	int extra = 1 + (page == fault_page);
>>>  
>>> -	/*
>>> -	 * FIXME support THP (transparent huge page), it is bit more complex to
>>> -	 * check them than regular pages, because they can be mapped with a pmd
>>> -	 * or with a pte (split pte mapping).
>>> -	 */
>>> -	if (folio_test_large(folio))
>>> -		return false;
>>> -
>> You cannot remove this check unless support normal mTHP folios migrate to device, 
>> which I think this series doesn't do, but maybe should?
>>
> mTHP needs to be a follow up series, there are comments in the cover letter. I had an
> assert earlier to prevent other folio sizes, but I've removed it and the interface
> to drivers does not allow for mTHP device private folios.
>
> Balbir
>
pte mapped device private THPs with other sizes also can be created as a result of pmd and folio splits. 
Your should handle them in one place consistently not by different drivers. 
As pointed by Matthew, there's the problem with the fault_page if not split and just ignored.


--Mika



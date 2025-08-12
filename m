Return-Path: <linux-kernel+bounces-764136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147FB21E79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF75F4212D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E82D47EF;
	Tue, 12 Aug 2025 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRqolI7M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F72DECD6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980644; cv=none; b=kHwu3a8QX0cZ+O50egT2REWbnhzkZUXm6zMpdIQu+EOX/GBl2snduuCjRarab/WI1oH3CuGtNgj+m/p1g1rQXC1G15SOjKwXolYSu379qoo3H6ZXjztnv5tD1y007XlId1yggfd318RhPzRt1w/Qx5RKaDlZz6It3QDUmk3PxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980644; c=relaxed/simple;
	bh=4Z3ixsSes/ZaSkCu11vxgLW1o6khHlndFRuhL2jb4GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFxkegGqA8CVEIMgJA5JG4gxeb2oexok3yaeJiLuiRjQSY2asmWM4H7oDzvBEccdByDKQzHAVLYO+dkzac564jcWRXbnMj0i3mD40c/Tt4X2DLwg6k/fcnkPj+w8i4kKBCLfT6Zl9msN5y+k1oaUzjVYxgcUIKqNUbbAGaLi7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRqolI7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754980641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYlPhAxHPbIiKQ+onLP18X95rM8NK7n/QL8pKb4oNjI=;
	b=hRqolI7MYhtt89J36fYNnL4qKTpco/bQYLnDlYleWSZm8kOsY+IJ8/m+/o9lPE5gfkRDKP
	Pqkn0/qDvOEDEQPFtpelyjXGHIAHAJd0cSqVUkn9EkBPs5/QNtIuXt2TB4EPkY6PQy+8u8
	AMYQKgK/X7nB8HI9gQwdl8XZHEV6TZo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396--wD7V4h6NNWVD7kILuPE0w-1; Tue, 12 Aug 2025 02:37:18 -0400
X-MC-Unique: -wD7V4h6NNWVD7kILuPE0w-1
X-Mimecast-MFC-AGG-ID: -wD7V4h6NNWVD7kILuPE0w_1754980637
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55ba1981389so2700492e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754980636; x=1755585436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYlPhAxHPbIiKQ+onLP18X95rM8NK7n/QL8pKb4oNjI=;
        b=GpzYUwmrDn9TwAkHf7k1myTYTgNl95T8a4TkL3TIqXZgcbdAoGgHmXTFwQVLA4c5Sb
         qrBhhILHxp/h8s7Cxtne1jKPPE8A4DFY+PrsEQGcVl2en3HL4IKHqvFyRIb9pdFOIIbu
         NMIibTP4QN3I0ajRXoXSIsth8syge8nwSbRYrZyDz8DmFlAxmILasudYnChdEsqqIVwa
         r9q0OvI+KK0R5pCuRFnpGtBAj66Wa/foNhq4TxNTP/3WmQmKquh6+U+oqQ+f446/cVLp
         10u99YaNikBii74aRZ7PqPFynNNv35ebR8ND7VFy79aMQvh0opqa5UwPvkyAcJhrkUUS
         lpsw==
X-Forwarded-Encrypted: i=1; AJvYcCUhONYX5SEKV4rpUDABg/5M9Ans/FwauFo3m5MwE3QTrgaW5OSH+NC7DoQrOTlkY6w+QFSQwJ1BMCaEYHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGboju7s878p6YRudq96PIrffkYUzm1HyHcGY+iaHwn2cezDi3
	Y9f9JrjF6i9zB+LtcIs7Hf56fHLthwPV4A4szvkRzpHBoT0nC2O5Uo/bGkK4gckP4MF7wj3/PQf
	o/qKQw1HpxfvCS9mroyM7GuemSSAcVFpVRkhPdcjE95aAav5ep5TwPrn6Kxg7L12l
X-Gm-Gg: ASbGncvEBuWeicsIn8ZqZscoxuTFDuRl3us6Vbht0WhJw6daZcSrncejKLTIlpwy975
	iFiOrDRFzg/P83KAu8eWpb/Dt5GCTaI8nHLL44OsxTj7hc7KI9lY0LDJWMGtver3cxEt1GZBY28
	JG9zWlWDOJtayOi22W277z3tcdF4vte3e9ll0kkNMuQLYq6utdGnUIMS0rwaERo3GI2V6MjxNBl
	nR+5FCASoA8eFCRcsAEiSnGk0U2MICM/7coq8Htiq0NXNEcA6VzfvQUDEU7icdbr/PRl9WGlEML
	ew67J1F5DZVfHUNjRTyj/4Wel82zRKDiB1GWFfr4MSJIOlxjqJSyvcjxi/LzGhrVuQ==
X-Received: by 2002:a05:6512:1251:b0:55b:96e4:11b5 with SMTP id 2adb3069b0e04-55cd757e083mr523966e87.1.1754980636437;
        Mon, 11 Aug 2025 23:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXNE2K2pUXmPGN4LQTjJKHSKCjNyEZFrkeCGn38L7Ho/GPlO7/vj+aA2yfKh3KUDZCVTWeJQ==
X-Received: by 2002:a05:6512:1251:b0:55b:96e4:11b5 with SMTP id 2adb3069b0e04-55cd757e083mr523930e87.1.1754980635871;
        Mon, 11 Aug 2025 23:37:15 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cb7c4dsm4717429e87.170.2025.08.11.23.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:37:15 -0700 (PDT)
Message-ID: <0e116c7e-d276-418d-a8cd-47cdd9f2d00d@redhat.com>
Date: Tue, 12 Aug 2025 09:37:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 03/11] mm/migrate_device: THP migration of zone device pages
To: Matthew Brost <matthew.brost@intel.com>
Cc: Balbir Singh <balbirs@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Francois Dugast <francois.dugast@intel.com>
References: <20250812024036.690064-1-balbirs@nvidia.com>
 <20250812024036.690064-4-balbirs@nvidia.com>
 <81ca37d5-b1ff-46de-8dcc-b222af350c77@redhat.com>
 <aJrW/JUBhdlL2Kur@lstrano-desk.jf.intel.com>
 <3df6fbed-7587-44f5-bd12-29e59ecde123@redhat.com>
 <aJrgJvmyeg7YuOQY@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <aJrgJvmyeg7YuOQY@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/12/25 09:33, Matthew Brost wrote:

> On Tue, Aug 12, 2025 at 09:25:29AM +0300, Mika Penttilä wrote:
>> On 8/12/25 08:54, Matthew Brost wrote:
>>
>>> On Tue, Aug 12, 2025 at 08:35:49AM +0300, Mika Penttilä wrote:
>>>> Hi,
>>>>
>>>> On 8/12/25 05:40, Balbir Singh wrote:
>>>>
>>>>> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
>>>>> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
>>>>> device pages as compound pages during device pfn migration.
>>>>>
>>>>> migrate_device code paths go through the collect, setup
>>>>> and finalize phases of migration.
>>>>>
>>>>> The entries in src and dst arrays passed to these functions still
>>>>> remain at a PAGE_SIZE granularity. When a compound page is passed,
>>>>> the first entry has the PFN along with MIGRATE_PFN_COMPOUND
>>>>> and other flags set (MIGRATE_PFN_MIGRATE, MIGRATE_PFN_VALID), the
>>>>> remaining entries (HPAGE_PMD_NR - 1) are filled with 0's. This
>>>>> representation allows for the compound page to be split into smaller
>>>>> page sizes.
>>>>>
>>>>> migrate_vma_collect_hole(), migrate_vma_collect_pmd() are now THP
>>>>> page aware. Two new helper functions migrate_vma_collect_huge_pmd()
>>>>> and migrate_vma_insert_huge_pmd_page() have been added.
>>>>>
>>>>> migrate_vma_collect_huge_pmd() can collect THP pages, but if for
>>>>> some reason this fails, there is fallback support to split the folio
>>>>> and migrate it.
>>>>>
>>>>> migrate_vma_insert_huge_pmd_page() closely follows the logic of
>>>>> migrate_vma_insert_page()
>>>>>
>>>>> Support for splitting pages as needed for migration will follow in
>>>>> later patches in this series.
>>>>>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>>>>> Cc: Rakie Kim <rakie.kim@sk.com>
>>>>> Cc: Byungchul Park <byungchul@sk.com>
>>>>> Cc: Gregory Price <gourry@gourry.net>
>>>>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>>>> Cc: Nico Pache <npache@redhat.com>
>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>> Cc: Dev Jain <dev.jain@arm.com>
>>>>> Cc: Barry Song <baohua@kernel.org>
>>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>>
>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>> ---
>>>>>  include/linux/migrate.h |   2 +
>>>>>  mm/migrate_device.c     | 457 ++++++++++++++++++++++++++++++++++------
>>>>>  2 files changed, 396 insertions(+), 63 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>>>> index acadd41e0b5c..d9cef0819f91 100644
>>>>> --- a/include/linux/migrate.h
>>>>> +++ b/include/linux/migrate.h
>>>>> @@ -129,6 +129,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>>>>>  #define MIGRATE_PFN_VALID	(1UL << 0)
>>>>>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>>>>>  #define MIGRATE_PFN_WRITE	(1UL << 3)
>>>>> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>>>>>  #define MIGRATE_PFN_SHIFT	6
>>>>>  
>>>>>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
>>>>> @@ -147,6 +148,7 @@ enum migrate_vma_direction {
>>>>>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>>>>>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
>>>>>  	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
>>>>> +	MIGRATE_VMA_SELECT_COMPOUND = 1 << 3,
>>>>>  };
>>>>>  
>>>>>  struct migrate_vma {
>>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>>> index 0ed337f94fcd..6621bba62710 100644
>>>>> --- a/mm/migrate_device.c
>>>>> +++ b/mm/migrate_device.c
>>>>> @@ -14,6 +14,7 @@
>>>>>  #include <linux/pagewalk.h>
>>>>>  #include <linux/rmap.h>
>>>>>  #include <linux/swapops.h>
>>>>> +#include <asm/pgalloc.h>
>>>>>  #include <asm/tlbflush.h>
>>>>>  #include "internal.h"
>>>>>  
>>>>> @@ -44,6 +45,23 @@ static int migrate_vma_collect_hole(unsigned long start,
>>>>>  	if (!vma_is_anonymous(walk->vma))
>>>>>  		return migrate_vma_collect_skip(start, end, walk);
>>>>>  
>>>>> +	if (thp_migration_supported() &&
>>>>> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
>>>>> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
>>>>> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
>>>>> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
>>>>> +						MIGRATE_PFN_COMPOUND;
>>>>> +		migrate->dst[migrate->npages] = 0;
>>>>> +		migrate->npages++;
>>>>> +		migrate->cpages++;
>>>>> +
>>>>> +		/*
>>>>> +		 * Collect the remaining entries as holes, in case we
>>>>> +		 * need to split later
>>>>> +		 */
>>>>> +		return migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
>>>>> +	}
>>>>> +
>>>>>  	for (addr = start; addr < end; addr += PAGE_SIZE) {
>>>>>  		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
>>>>>  		migrate->dst[migrate->npages] = 0;
>>>>> @@ -54,57 +72,151 @@ static int migrate_vma_collect_hole(unsigned long start,
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> -static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>> -				   unsigned long start,
>>>>> -				   unsigned long end,
>>>>> -				   struct mm_walk *walk)
>>>>> +/**
>>>>> + * migrate_vma_collect_huge_pmd - collect THP pages without splitting the
>>>>> + * folio for device private pages.
>>>>> + * @pmdp: pointer to pmd entry
>>>>> + * @start: start address of the range for migration
>>>>> + * @end: end address of the range for migration
>>>>> + * @walk: mm_walk callback structure
>>>>> + *
>>>>> + * Collect the huge pmd entry at @pmdp for migration and set the
>>>>> + * MIGRATE_PFN_COMPOUND flag in the migrate src entry to indicate that
>>>>> + * migration will occur at HPAGE_PMD granularity
>>>>> + */
>>>>> +static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
>>>>> +					unsigned long end, struct mm_walk *walk,
>>>>> +					struct folio *fault_folio)
>>>>>  {
>>>>> +	struct mm_struct *mm = walk->mm;
>>>>> +	struct folio *folio;
>>>>>  	struct migrate_vma *migrate = walk->private;
>>>>> -	struct folio *fault_folio = migrate->fault_page ?
>>>>> -		page_folio(migrate->fault_page) : NULL;
>>>>> -	struct vm_area_struct *vma = walk->vma;
>>>>> -	struct mm_struct *mm = vma->vm_mm;
>>>>> -	unsigned long addr = start, unmapped = 0;
>>>>>  	spinlock_t *ptl;
>>>>> -	pte_t *ptep;
>>>>> +	swp_entry_t entry;
>>>>> +	int ret;
>>>>> +	unsigned long write = 0;
>>>>>  
>>>>> -again:
>>>>> -	if (pmd_none(*pmdp))
>>>>> +	ptl = pmd_lock(mm, pmdp);
>>>>> +	if (pmd_none(*pmdp)) {
>>>>> +		spin_unlock(ptl);
>>>>>  		return migrate_vma_collect_hole(start, end, -1, walk);
>>>>> +	}
>>>>>  
>>>>>  	if (pmd_trans_huge(*pmdp)) {
>>>>> -		struct folio *folio;
>>>>> -
>>>>> -		ptl = pmd_lock(mm, pmdp);
>>>>> -		if (unlikely(!pmd_trans_huge(*pmdp))) {
>>>>> +		if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
>>>>>  			spin_unlock(ptl);
>>>>> -			goto again;
>>>>> +			return migrate_vma_collect_skip(start, end, walk);
>>>>>  		}
>>>>>  
>>>>>  		folio = pmd_folio(*pmdp);
>>>>>  		if (is_huge_zero_folio(folio)) {
>>>>>  			spin_unlock(ptl);
>>>>> -			split_huge_pmd(vma, pmdp, addr);
>>>>> -		} else {
>>>>> -			int ret;
>>>>> +			return migrate_vma_collect_hole(start, end, -1, walk);
>>>>> +		}
>>>>> +		if (pmd_write(*pmdp))
>>>>> +			write = MIGRATE_PFN_WRITE;
>>>>> +	} else if (!pmd_present(*pmdp)) {
>>>>> +		entry = pmd_to_swp_entry(*pmdp);
>>>>> +		folio = pfn_swap_entry_folio(entry);
>>>>> +
>>>>> +		if (!is_device_private_entry(entry) ||
>>>>> +			!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
>>>>> +			(folio->pgmap->owner != migrate->pgmap_owner)) {
>>>>> +			spin_unlock(ptl);
>>>>> +			return migrate_vma_collect_skip(start, end, walk);
>>>>> +		}
>>>>>  
>>>>> -			folio_get(folio);
>>>>> +		if (is_migration_entry(entry)) {
>>>>> +			migration_entry_wait_on_locked(entry, ptl);
>>>>>  			spin_unlock(ptl);
>>>>> -			/* FIXME: we don't expect THP for fault_folio */
>>>>> -			if (WARN_ON_ONCE(fault_folio == folio))
>>>>> -				return migrate_vma_collect_skip(start, end,
>>>>> -								walk);
>>>>> -			if (unlikely(!folio_trylock(folio)))
>>>>> -				return migrate_vma_collect_skip(start, end,
>>>>> -								walk);
>>>>> -			ret = split_folio(folio);
>>>>> -			if (fault_folio != folio)
>>>>> -				folio_unlock(folio);
>>>>> -			folio_put(folio);
>>>>> -			if (ret)
>>>>> -				return migrate_vma_collect_skip(start, end,
>>>>> -								walk);
>>>>> +			return -EAGAIN;
>>>>>  		}
>>>>> +
>>>>> +		if (is_writable_device_private_entry(entry))
>>>>> +			write = MIGRATE_PFN_WRITE;
>>>>> +	} else {
>>>>> +		spin_unlock(ptl);
>>>>> +		return -EAGAIN;
>>>>> +	}
>>>>> +
>>>>> +	folio_get(folio);
>>>>> +	if (folio != fault_folio && unlikely(!folio_trylock(folio))) {
>>>>> +		spin_unlock(ptl);
>>>>> +		folio_put(folio);
>>>>> +		return migrate_vma_collect_skip(start, end, walk);
>>>>> +	}
>>>>> +
>>>>> +	if (thp_migration_supported() &&
>>>>> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
>>>>> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
>>>>> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
>>>>> +
>>>>> +		struct page_vma_mapped_walk pvmw = {
>>>>> +			.ptl = ptl,
>>>>> +			.address = start,
>>>>> +			.pmd = pmdp,
>>>>> +			.vma = walk->vma,
>>>>> +		};
>>>>> +
>>>>> +		unsigned long pfn = page_to_pfn(folio_page(folio, 0));
>>>>> +
>>>>> +		migrate->src[migrate->npages] = migrate_pfn(pfn) | write
>>>>> +						| MIGRATE_PFN_MIGRATE
>>>>> +						| MIGRATE_PFN_COMPOUND;
>>>>> +		migrate->dst[migrate->npages++] = 0;
>>>>> +		migrate->cpages++;
>>>>> +		ret = set_pmd_migration_entry(&pvmw, folio_page(folio, 0));
>>>>> +		if (ret) {
>>>>> +			migrate->npages--;
>>>>> +			migrate->cpages--;
>>>>> +			migrate->src[migrate->npages] = 0;
>>>>> +			migrate->dst[migrate->npages] = 0;
>>>>> +			goto fallback;
>>>>> +		}
>>>>> +		migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
>>>>> +		spin_unlock(ptl);
>>>>> +		return 0;
>>>>> +	}
>>>>> +
>>>>> +fallback:
>>>>> +	spin_unlock(ptl);
>>>>> +	if (!folio_test_large(folio))
>>>>> +		goto done;
>>>>> +	ret = split_folio(folio);
>>>>> +	if (fault_folio != folio)
>>>>> +		folio_unlock(folio);
>>>>> +	folio_put(folio);
>>>>> +	if (ret)
>>>>> +		return migrate_vma_collect_skip(start, end, walk);
>>>>> +	if (pmd_none(pmdp_get_lockless(pmdp)))
>>>>> +		return migrate_vma_collect_hole(start, end, -1, walk);
>>>>> +
>>>>> +done:
>>>>> +	return -ENOENT;
>>>>> +}
>>>>> +
>>>>> +static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>> +				   unsigned long start,
>>>>> +				   unsigned long end,
>>>>> +				   struct mm_walk *walk)
>>>>> +{
>>>>> +	struct migrate_vma *migrate = walk->private;
>>>>> +	struct vm_area_struct *vma = walk->vma;
>>>>> +	struct mm_struct *mm = vma->vm_mm;
>>>>> +	unsigned long addr = start, unmapped = 0;
>>>>> +	spinlock_t *ptl;
>>>>> +	struct folio *fault_folio = migrate->fault_page ?
>>>>> +		page_folio(migrate->fault_page) : NULL;
>>>>> +	pte_t *ptep;
>>>>> +
>>>>> +again:
>>>>> +	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
>>>>> +		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
>>>>> +
>>>>> +		if (ret == -EAGAIN)
>>>>> +			goto again;
>>>>> +		if (ret == 0)
>>>>> +			return 0;
>>>>>  	}
>>>>>  
>>>>>  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>>>> @@ -222,8 +334,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>>  			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
>>>>>  		}
>>>>>  
>>>>> -		/* FIXME support THP */
>>>>> -		if (!page || !page->mapping || PageTransCompound(page)) {
>>>>> +		if (!page || !page->mapping) {
>>>>>  			mpfn = 0;
>>>>>  			goto next;
>>>>>  		}
>>>>> @@ -394,14 +505,6 @@ static bool migrate_vma_check_page(struct page *page, struct page *fault_page)
>>>>>  	 */
>>>>>  	int extra = 1 + (page == fault_page);
>>>>>  
>>>>> -	/*
>>>>> -	 * FIXME support THP (transparent huge page), it is bit more complex to
>>>>> -	 * check them than regular pages, because they can be mapped with a pmd
>>>>> -	 * or with a pte (split pte mapping).
>>>>> -	 */
>>>>> -	if (folio_test_large(folio))
>>>>> -		return false;
>>>>> -
>>>> You cannot remove this check unless support normal mTHP folios migrate to device, 
>>>> which I think this series doesn't do, but maybe should?
>>>>
>>> Currently, mTHP should be split upon collection, right? The only way a
>>> THP should be collected is if it directly maps to a PMD. If a THP or
>>> mTHP is found in PTEs (i.e., in migrate_vma_collect_pmd outside of
>>> migrate_vma_collect_huge_pmd), it should be split there. I sent this
>>> logic to Balbir privately, but it appears to have been omitted.
>> I think currently if mTHP is found byte PTEs folio just isn't migrated.
> If this is the fault page, you'd just spin forever. IIRC this how it
> popped in my testing. I'll try to follow up with a fixes patch as I have
> bandwidth.

Uh yes indeed that's a bug!

>
>> Yes maybe they should be just split while collected now. Best would of course
> +1 for now.
>
>> to migrate (like as order-0 pages for device) for not to split all mTHPs.
>> And yes maybe this all controlled by different flag.
>>
> +1 for different flag eventually.
>
> Matt
>
>>> I’m quite sure this missing split is actually an upstream bug, but it
>>> has been suppressed by PMDs being split upon device fault. I have a test
>>> that performs a ton of complete mremap—nonsense no one would normally
>>> do, but which should work—that exposed this. I can rebase on this series
>>> and see if the bug appears, or try the same nonsense without the device
>>> faulting first and splitting the pages, to trigger the bug.
>>>
>>> Matt
>>>
>>>> --Mika
>>>>
>> --Mika
>>



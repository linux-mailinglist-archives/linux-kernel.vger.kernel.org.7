Return-Path: <linux-kernel+bounces-764023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA0B21CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92EA3B4F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC18F265284;
	Tue, 12 Aug 2025 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDLjYtEH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692DE238C24
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754976958; cv=none; b=mIl96rjzJqoUVJlTcunR1a2Xdg2DNx8zPWeyYCA6I7DyacHAQ017pzkI0UUNEvmefB7MRInCXjV1tsYlvONaVyYI3/Rzyhc8y43Ctn999WxOQpE5WtW1ickkxMiV/c6V8cqDXfhsaBO9AjL0SACGn/g3t5pyfY2/6gZ6SARSK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754976958; c=relaxed/simple;
	bh=SUuo1tI9kxI42RyenAjHqQnuYZnPTU3oYTV+lUUxD04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ti0KXTAgxv7uSunYpndVmUif/YWSVP6qfe7kTyPBHg0LJaJqn+R76RQ0SpYv5t5rTB/jydYcHC5aEgQ5SvichFl9JbrC8EijKtyWUN4EMHo9cRatofqlbpnqW/KCW+zgXwasayrvrywvFVMp9cN9B+QW2n+owdRLaBNAbkWl45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDLjYtEH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754976955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HK1aGMXOxQraZ3WR6/QuCjAtP/UzwHLH972ALD6RPk=;
	b=KDLjYtEHASIDnn3CfmOVNZ+7xm3ow6qv+9jHw1FcJxGhoB67ovQU0ajQ1Fm188hQDHendp
	LBvu3eYKjIJgs3QnSLRvchXfVMiXgIgXUR8DIPVls8c90z8Ecq7oY46tlA31n9GQL65Qqo
	Do5dcOc7MCM96Uwdx+fD1y1xNacyF1E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-zuEe_zvsOZeBmSdfctGP5w-1; Tue, 12 Aug 2025 01:35:53 -0400
X-MC-Unique: zuEe_zvsOZeBmSdfctGP5w-1
X-Mimecast-MFC-AGG-ID: zuEe_zvsOZeBmSdfctGP5w_1754976952
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55b92839bd3so1407219e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754976952; x=1755581752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HK1aGMXOxQraZ3WR6/QuCjAtP/UzwHLH972ALD6RPk=;
        b=cbykv0mE3+vHixiPKfbI/d5uqWewnQ1ba2Pb1AgfS7VLlirdx1uod3qUruzN3Rrel/
         CSdOBIOjYvNQ+hgnVPgyhnX5ZAOfcf2vmyLgDN0jtSab4SGU516WnXrJ6V86sklxEKMI
         NQ92LxOQjUS2YKwAM7FsZ66xRzmjWQ/d1GMXQ1IG5npv9YThcBWaTS0Y+ypEZtYyp9PQ
         Ksv9NJwxPw2p7SnAbHO0oxsjCtgtDlWkR/ZDeiCumxo3KED1kh+dXNH8yVp9/u6UD0q9
         wLk8rr2Cc29zlZjJsCnimXBrCnc1OHpD8R285BxPVFS2wtuRDyN2Kk2i12MI5dYidg/V
         wZWA==
X-Forwarded-Encrypted: i=1; AJvYcCVBOt3ul9fuCUz4+vik5M1aLoyhDbZ8upyR6zL90nsEB1cwKaMHv08XVpd9V7ggIPp3DiMkEk+DIHJIrn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gCRQt0xExVAW6hmN4IugXdBmQkT3L6aDtbmXFV2vkwpDMCtz
	7syvA17f2X9xLZNtyLAccUgDcopQNEjP/rQr3RV7Gd0ezLvLHRXpUJdo2YGCBhU5pLWseoFQNEv
	JbdR5jXemQn9BDSjzxyLFUtor5DOt+70oLH8c36ixeXzcK7OKAfJxsQrHD35IQeSo
X-Gm-Gg: ASbGncv2+h1iPfxPg8BykIC77itOKHlSjnSaC8wHr3VmV6sIHQnmK3FraFIm4l4yGj1
	a4wtoL6ogFlFzDcCyeLaCNh2amVPDOEUnLBbf47GqRtGag7VMR4h6nBrdL3zbl2AN1J3sBBOWL4
	qOLZFIktmLq/bj3pLQV22thqmLdwSdMqbZcKck2ety1dr4i/zGephGSjv0vicBu9r+iCl8ycyjI
	y6D7R6h3cye2d/A44DUkg6O9m9DVIbyEgOl2T+8UeeUPUlR/zKjBzYBHGPyT5wWeskN/6Dxib4a
	UJrqfSW1/R3QoZzLEMKnZJ3/lDDk/1MLtDqkQu/cH1kOqyfHtBeu3FkJ+ELqCsP8gw==
X-Received: by 2002:a05:6512:e86:b0:55a:4c3a:b122 with SMTP id 2adb3069b0e04-55cd8c109cdmr541585e87.10.1754976952115;
        Mon, 11 Aug 2025 22:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoiBCdQDgAPLdc9mYi2nhz8mzpqDm1DftNE1ohp1+HyEI1M3tjFqiiZy3jbdNo8Jn3YvWg5A==
X-Received: by 2002:a05:6512:e86:b0:55a:4c3a:b122 with SMTP id 2adb3069b0e04-55cd8c109cdmr541555e87.10.1754976951633;
        Mon, 11 Aug 2025 22:35:51 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b9fc2a13csm3565415e87.132.2025.08.11.22.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 22:35:50 -0700 (PDT)
Message-ID: <81ca37d5-b1ff-46de-8dcc-b222af350c77@redhat.com>
Date: Tue, 12 Aug 2025 08:35:49 +0300
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
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250812024036.690064-4-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/12/25 05:40, Balbir Singh wrote:

> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
> device pages as compound pages during device pfn migration.
>
> migrate_device code paths go through the collect, setup
> and finalize phases of migration.
>
> The entries in src and dst arrays passed to these functions still
> remain at a PAGE_SIZE granularity. When a compound page is passed,
> the first entry has the PFN along with MIGRATE_PFN_COMPOUND
> and other flags set (MIGRATE_PFN_MIGRATE, MIGRATE_PFN_VALID), the
> remaining entries (HPAGE_PMD_NR - 1) are filled with 0's. This
> representation allows for the compound page to be split into smaller
> page sizes.
>
> migrate_vma_collect_hole(), migrate_vma_collect_pmd() are now THP
> page aware. Two new helper functions migrate_vma_collect_huge_pmd()
> and migrate_vma_insert_huge_pmd_page() have been added.
>
> migrate_vma_collect_huge_pmd() can collect THP pages, but if for
> some reason this fails, there is fallback support to split the folio
> and migrate it.
>
> migrate_vma_insert_huge_pmd_page() closely follows the logic of
> migrate_vma_insert_page()
>
> Support for splitting pages as needed for migration will follow in
> later patches in this series.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  include/linux/migrate.h |   2 +
>  mm/migrate_device.c     | 457 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 396 insertions(+), 63 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index acadd41e0b5c..d9cef0819f91 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -129,6 +129,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>  #define MIGRATE_PFN_VALID	(1UL << 0)
>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>  #define MIGRATE_PFN_WRITE	(1UL << 3)
> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>  #define MIGRATE_PFN_SHIFT	6
>  
>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
> @@ -147,6 +148,7 @@ enum migrate_vma_direction {
>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
>  	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
> +	MIGRATE_VMA_SELECT_COMPOUND = 1 << 3,
>  };
>  
>  struct migrate_vma {
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 0ed337f94fcd..6621bba62710 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -14,6 +14,7 @@
>  #include <linux/pagewalk.h>
>  #include <linux/rmap.h>
>  #include <linux/swapops.h>
> +#include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>  #include "internal.h"
>  
> @@ -44,6 +45,23 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	if (!vma_is_anonymous(walk->vma))
>  		return migrate_vma_collect_skip(start, end, walk);
>  
> +	if (thp_migration_supported() &&
> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
> +						MIGRATE_PFN_COMPOUND;
> +		migrate->dst[migrate->npages] = 0;
> +		migrate->npages++;
> +		migrate->cpages++;
> +
> +		/*
> +		 * Collect the remaining entries as holes, in case we
> +		 * need to split later
> +		 */
> +		return migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
> +	}
> +
>  	for (addr = start; addr < end; addr += PAGE_SIZE) {
>  		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
>  		migrate->dst[migrate->npages] = 0;
> @@ -54,57 +72,151 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	return 0;
>  }
>  
> -static int migrate_vma_collect_pmd(pmd_t *pmdp,
> -				   unsigned long start,
> -				   unsigned long end,
> -				   struct mm_walk *walk)
> +/**
> + * migrate_vma_collect_huge_pmd - collect THP pages without splitting the
> + * folio for device private pages.
> + * @pmdp: pointer to pmd entry
> + * @start: start address of the range for migration
> + * @end: end address of the range for migration
> + * @walk: mm_walk callback structure
> + *
> + * Collect the huge pmd entry at @pmdp for migration and set the
> + * MIGRATE_PFN_COMPOUND flag in the migrate src entry to indicate that
> + * migration will occur at HPAGE_PMD granularity
> + */
> +static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
> +					unsigned long end, struct mm_walk *walk,
> +					struct folio *fault_folio)
>  {
> +	struct mm_struct *mm = walk->mm;
> +	struct folio *folio;
>  	struct migrate_vma *migrate = walk->private;
> -	struct folio *fault_folio = migrate->fault_page ?
> -		page_folio(migrate->fault_page) : NULL;
> -	struct vm_area_struct *vma = walk->vma;
> -	struct mm_struct *mm = vma->vm_mm;
> -	unsigned long addr = start, unmapped = 0;
>  	spinlock_t *ptl;
> -	pte_t *ptep;
> +	swp_entry_t entry;
> +	int ret;
> +	unsigned long write = 0;
>  
> -again:
> -	if (pmd_none(*pmdp))
> +	ptl = pmd_lock(mm, pmdp);
> +	if (pmd_none(*pmdp)) {
> +		spin_unlock(ptl);
>  		return migrate_vma_collect_hole(start, end, -1, walk);
> +	}
>  
>  	if (pmd_trans_huge(*pmdp)) {
> -		struct folio *folio;
> -
> -		ptl = pmd_lock(mm, pmdp);
> -		if (unlikely(!pmd_trans_huge(*pmdp))) {
> +		if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
>  			spin_unlock(ptl);
> -			goto again;
> +			return migrate_vma_collect_skip(start, end, walk);
>  		}
>  
>  		folio = pmd_folio(*pmdp);
>  		if (is_huge_zero_folio(folio)) {
>  			spin_unlock(ptl);
> -			split_huge_pmd(vma, pmdp, addr);
> -		} else {
> -			int ret;
> +			return migrate_vma_collect_hole(start, end, -1, walk);
> +		}
> +		if (pmd_write(*pmdp))
> +			write = MIGRATE_PFN_WRITE;
> +	} else if (!pmd_present(*pmdp)) {
> +		entry = pmd_to_swp_entry(*pmdp);
> +		folio = pfn_swap_entry_folio(entry);
> +
> +		if (!is_device_private_entry(entry) ||
> +			!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
> +			(folio->pgmap->owner != migrate->pgmap_owner)) {
> +			spin_unlock(ptl);
> +			return migrate_vma_collect_skip(start, end, walk);
> +		}
>  
> -			folio_get(folio);
> +		if (is_migration_entry(entry)) {
> +			migration_entry_wait_on_locked(entry, ptl);
>  			spin_unlock(ptl);
> -			/* FIXME: we don't expect THP for fault_folio */
> -			if (WARN_ON_ONCE(fault_folio == folio))
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> -			if (unlikely(!folio_trylock(folio)))
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> -			ret = split_folio(folio);
> -			if (fault_folio != folio)
> -				folio_unlock(folio);
> -			folio_put(folio);
> -			if (ret)
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> +			return -EAGAIN;
>  		}
> +
> +		if (is_writable_device_private_entry(entry))
> +			write = MIGRATE_PFN_WRITE;
> +	} else {
> +		spin_unlock(ptl);
> +		return -EAGAIN;
> +	}
> +
> +	folio_get(folio);
> +	if (folio != fault_folio && unlikely(!folio_trylock(folio))) {
> +		spin_unlock(ptl);
> +		folio_put(folio);
> +		return migrate_vma_collect_skip(start, end, walk);
> +	}
> +
> +	if (thp_migration_supported() &&
> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> +
> +		struct page_vma_mapped_walk pvmw = {
> +			.ptl = ptl,
> +			.address = start,
> +			.pmd = pmdp,
> +			.vma = walk->vma,
> +		};
> +
> +		unsigned long pfn = page_to_pfn(folio_page(folio, 0));
> +
> +		migrate->src[migrate->npages] = migrate_pfn(pfn) | write
> +						| MIGRATE_PFN_MIGRATE
> +						| MIGRATE_PFN_COMPOUND;
> +		migrate->dst[migrate->npages++] = 0;
> +		migrate->cpages++;
> +		ret = set_pmd_migration_entry(&pvmw, folio_page(folio, 0));
> +		if (ret) {
> +			migrate->npages--;
> +			migrate->cpages--;
> +			migrate->src[migrate->npages] = 0;
> +			migrate->dst[migrate->npages] = 0;
> +			goto fallback;
> +		}
> +		migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
> +fallback:
> +	spin_unlock(ptl);
> +	if (!folio_test_large(folio))
> +		goto done;
> +	ret = split_folio(folio);
> +	if (fault_folio != folio)
> +		folio_unlock(folio);
> +	folio_put(folio);
> +	if (ret)
> +		return migrate_vma_collect_skip(start, end, walk);
> +	if (pmd_none(pmdp_get_lockless(pmdp)))
> +		return migrate_vma_collect_hole(start, end, -1, walk);
> +
> +done:
> +	return -ENOENT;
> +}
> +
> +static int migrate_vma_collect_pmd(pmd_t *pmdp,
> +				   unsigned long start,
> +				   unsigned long end,
> +				   struct mm_walk *walk)
> +{
> +	struct migrate_vma *migrate = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long addr = start, unmapped = 0;
> +	spinlock_t *ptl;
> +	struct folio *fault_folio = migrate->fault_page ?
> +		page_folio(migrate->fault_page) : NULL;
> +	pte_t *ptep;
> +
> +again:
> +	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
> +		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
> +
> +		if (ret == -EAGAIN)
> +			goto again;
> +		if (ret == 0)
> +			return 0;
>  	}
>  
>  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> @@ -222,8 +334,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
>  		}
>  
> -		/* FIXME support THP */
> -		if (!page || !page->mapping || PageTransCompound(page)) {
> +		if (!page || !page->mapping) {
>  			mpfn = 0;
>  			goto next;
>  		}
> @@ -394,14 +505,6 @@ static bool migrate_vma_check_page(struct page *page, struct page *fault_page)
>  	 */
>  	int extra = 1 + (page == fault_page);
>  
> -	/*
> -	 * FIXME support THP (transparent huge page), it is bit more complex to
> -	 * check them than regular pages, because they can be mapped with a pmd
> -	 * or with a pte (split pte mapping).
> -	 */
> -	if (folio_test_large(folio))
> -		return false;
> -

You cannot remove this check unless support normal mTHP folios migrate to device, 
which I think this series doesn't do, but maybe should?

--Mika



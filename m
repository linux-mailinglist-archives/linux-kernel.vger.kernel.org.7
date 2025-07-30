Return-Path: <linux-kernel+bounces-750645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE5FB15F26
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B8F542341
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107F27F160;
	Wed, 30 Jul 2025 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0C2ebSX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F111DDC15
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874224; cv=none; b=C9eSnydccSvI7Rz1OStxPUFLZIJqjvLIavFaKRuoRaQFHYR4w+7L1213mseOdDHLQd/aHay3uxTH5tScfoLmhyhFzCTbWUASCtErSde8PewTgp7gA+ejU6ZRXQHm76/qt5ytqz6RM6L0RXg/0+EZahFHgYQq1Uf21bAY3anzf/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874224; c=relaxed/simple;
	bh=LTD16EOwxCrJVoK7xkoTVx21o0VOsrq/8M2g/+axzTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFJoZ+ttwQW3cfc1MUTcWrOmQYiRMRFUAz0DPHtjDYm0xMRa1PrdRrKeqZVsgNCfBZybHZptTOmLK802BRb5jZyWDKS1vSRNwIPjQAZW/dZ9OFGu+U1iN0Y/Iapp8PtOtMS3KkjTL1b6uVIhdzWHZGzqRhrx3wZPiDcm+kSUYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0C2ebSX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753874220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvUZl8UsRxarX+a47kb4o3MCQM4rqegqmRJ5/HY1RYM=;
	b=B0C2ebSXi/4zUWDCooJ2pAj/nk0RNd/W63ZDows3k3BsB0IAqXGMknYScPCu/xkAXhjtCG
	jwkuoqnWZGNoDoDnLtVTpj9WnojMj74ZBD/Zw5nqAF0o9nE6IwJmo0J4uQGmdMKaeXMj19
	gRiLT5l8rdp6Hvko+ME0ymUeeCQomew=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-XgGLsLiCPI2kwAtmBMC4KA-1; Wed, 30 Jul 2025 07:16:59 -0400
X-MC-Unique: XgGLsLiCPI2kwAtmBMC4KA-1
X-Mimecast-MFC-AGG-ID: XgGLsLiCPI2kwAtmBMC4KA_1753874218
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55b8085bdabso409844e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753874217; x=1754479017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvUZl8UsRxarX+a47kb4o3MCQM4rqegqmRJ5/HY1RYM=;
        b=MzD+EXN///rLS++E32gCAhR6krvSND1L2a7J45pKvJAl7gCzk+30igJ1dgDxW20zn8
         fo2THeujLhVsUDCx51sLDXSzXRAxjL56Y0T4bEJOP6SMXX2AX3L1H2tHHZcmhG0ejo1k
         Wzi2uSq53abOV73u1ZaFpa+VImUU0E3QdLcFszCpDEksWlb8n+edU3InqmBGlGIlh+dX
         rk15YezLK/JbpeKhO5iFs6p/CuxWNz7yLduiztZHNPiAOJIZIo6g+qydHGcxdMLJrx/t
         Fo9NAvC50Xfewzb7Df41NV+0JHQ7H2sWObmgEfU0+oj6X2dyKDcCoAmz6qmr6OwZAxo1
         Ej8A==
X-Gm-Message-State: AOJu0YyYz4/ah+BTnnqK0FYeBbXYBnbicsuJkJ5GYVG+f0QKvJzqk3m/
	92TsaNj4H50OyHYXed2Piu7bU493iN3UkNhgQ5/CoWuGJHkZSvpDKEO5iEcoZQjdy6/tbnm5DFe
	5IJYgUfoI/HsLAuxlZy/46J7E56d4XnBgzGkGn0T6i9XQK2B1R8u6kQePkRQT2EoE
X-Gm-Gg: ASbGncsSlX1zwJLUb9t5gE8XB81WKL3YzAUCwLy61YDyt21d+hr3RG7rvefo+ongLIU
	32Aje/pYaD5ehZaArxiq80wFRfQajgBfhrhoJ9dMjIM1zqsDWiFR4cSy2Dphbp3SqA8e5NKJ/6D
	49x6UB5Q8FoIxcf76DwCX9NxUin12Szh7uz7D0KRh5aAIaIBD8gB0oioR2LIuJ14UJL6M2dWu2J
	IShxTLonCiyiPwaJ1rlUQxrofT3ea0PdZbnVnGAz4+au6nY7PX4qj/AIX5E1NppT/U9VOw1WM52
	i3Qjbh0VrjfTgfqTFfho/GJJBa8+ND+nO5Osq+q4+OfYgT2r25gg2Em1EoSyZ9lg3A==
X-Received: by 2002:a05:6512:4154:b0:55a:c9f0:a01c with SMTP id 2adb3069b0e04-55b7c0a5bf9mr547843e87.53.1753874217292;
        Wed, 30 Jul 2025 04:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn9i5LR+L5e7rVqqc3z2wJjWwtz+exUpZ3SHaIfX3F/NhAiWhrcRtNvN2AldXvieg3Lp906A==
X-Received: by 2002:a05:6512:4154:b0:55a:c9f0:a01c with SMTP id 2adb3069b0e04-55b7c0a5bf9mr547830e87.53.1753874216740;
        Wed, 30 Jul 2025 04:16:56 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6317ba40sm2084515e87.46.2025.07.30.04.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 04:16:56 -0700 (PDT)
Message-ID: <c2f2fe52-a358-489e-a1f2-5c0a6f5b4db5@redhat.com>
Date: Wed, 30 Jul 2025 14:16:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 02/11] mm/thp: zone_device awareness in THP handling code
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-3-balbirs@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250730092139.3890844-3-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 7/30/25 12:21, Balbir Singh wrote:
> Make THP handling code in the mm subsystem for THP pages aware of zone
> device pages. Although the code is designed to be generic when it comes
> to handling splitting of pages, the code is designed to work for THP
> page sizes corresponding to HPAGE_PMD_NR.
>
> Modify page_vma_mapped_walk() to return true when a zone device huge
> entry is present, enabling try_to_migrate() and other code migration
> paths to appropriately process the entry. page_vma_mapped_walk() will
> return true for zone device private large folios only when
> PVMW_THP_DEVICE_PRIVATE is passed. This is to prevent locations that are
> not zone device private pages from having to add awareness. The key
> callback that needs this flag is try_to_migrate_one(). The other
> callbacks page idle, damon use it for setting young/dirty bits, which is
> not significant when it comes to pmd level bit harvesting.
>
> pmd_pfn() does not work well with zone device entries, use
> pfn_pmd_entry_to_swap() for checking and comparison as for zone device
> entries.
>
> Zone device private entries when split via munmap go through pmd split,
> but need to go through a folio split, deferred split does not work if a
> fault is encountered because fault handling involves migration entries
> (via folio_migrate_mapping) and the folio sizes are expected to be the
> same there. This introduces the need to split the folio while handling
> the pmd split. Because the folio is still mapped, but calling
> folio_split() will cause lock recursion, the __split_unmapped_folio()
> code is used with a new helper to wrap the code
> split_device_private_folio(), which skips the checks around
> folio->mapping, swapcache and the need to go through unmap and remap
> folio.
>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  include/linux/huge_mm.h |   1 +
>  include/linux/rmap.h    |   2 +
>  include/linux/swapops.h |  17 +++
>  mm/huge_memory.c        | 268 +++++++++++++++++++++++++++++++++-------
>  mm/page_vma_mapped.c    |  13 +-
>  mm/pgtable-generic.c    |   6 +
>  mm/rmap.c               |  22 +++-
>  7 files changed, 278 insertions(+), 51 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b..2a6f5ff7bca3 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -345,6 +345,7 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>  int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		unsigned int new_order);
> +int split_device_private_folio(struct folio *folio);
>  int min_order_for_split(struct folio *folio);
>  int split_folio_to_list(struct folio *folio, struct list_head *list);
>  bool uniform_split_supported(struct folio *folio, unsigned int new_order,
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 20803fcb49a7..625f36dcc121 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -905,6 +905,8 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
>  #define PVMW_SYNC		(1 << 0)
>  /* Look for migration entries rather than present PTEs */
>  #define PVMW_MIGRATION		(1 << 1)
> +/* Look for device private THP entries */
> +#define PVMW_THP_DEVICE_PRIVATE	(1 << 2)
>  
>  struct page_vma_mapped_walk {
>  	unsigned long pfn;
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 64ea151a7ae3..2641c01bd5d2 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -563,6 +563,7 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>  {
>  	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
>  }
> +
>  #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>  static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>  		struct page *page)
> @@ -594,6 +595,22 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>  }
>  #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>  
> +#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
> +
> +static inline int is_pmd_device_private_entry(pmd_t pmd)
> +{
> +	return is_swap_pmd(pmd) && is_device_private_entry(pmd_to_swp_entry(pmd));
> +}
> +
> +#else /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
> +
> +static inline int is_pmd_device_private_entry(pmd_t pmd)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
> +
>  static inline int non_swap_entry(swp_entry_t entry)
>  {
>  	return swp_type(entry) >= MAX_SWAPFILES;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9c38a95e9f09..e373c6578894 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -72,6 +72,10 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
>  					  struct shrink_control *sc);
>  static unsigned long deferred_split_scan(struct shrinker *shrink,
>  					 struct shrink_control *sc);
> +static int __split_unmapped_folio(struct folio *folio, int new_order,
> +		struct page *split_at, struct xa_state *xas,
> +		struct address_space *mapping, bool uniform_split);
> +
>  static bool split_underused_thp = true;
>  
>  static atomic_t huge_zero_refcount;
> @@ -1711,8 +1715,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	if (unlikely(is_swap_pmd(pmd))) {
>  		swp_entry_t entry = pmd_to_swp_entry(pmd);
>  
> -		VM_BUG_ON(!is_pmd_migration_entry(pmd));
> -		if (!is_readable_migration_entry(entry)) {
> +		VM_WARN_ON(!is_pmd_migration_entry(pmd) &&
> +				!is_pmd_device_private_entry(pmd));
> +
> +		if (is_migration_entry(entry) &&
> +			is_writable_migration_entry(entry)) {
>  			entry = make_readable_migration_entry(
>  							swp_offset(entry));
>  			pmd = swp_entry_to_pmd(entry);
> @@ -1722,6 +1729,32 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  				pmd = pmd_swp_mkuffd_wp(pmd);
>  			set_pmd_at(src_mm, addr, src_pmd, pmd);
>  		}
> +
> +		if (is_device_private_entry(entry)) {
> +			if (is_writable_device_private_entry(entry)) {
> +				entry = make_readable_device_private_entry(
> +					swp_offset(entry));
> +				pmd = swp_entry_to_pmd(entry);
> +
> +				if (pmd_swp_soft_dirty(*src_pmd))
> +					pmd = pmd_swp_mksoft_dirty(pmd);
> +				if (pmd_swp_uffd_wp(*src_pmd))
> +					pmd = pmd_swp_mkuffd_wp(pmd);
> +				set_pmd_at(src_mm, addr, src_pmd, pmd);
> +			}
> +
> +			src_folio = pfn_swap_entry_folio(entry);
> +			VM_WARN_ON(!folio_test_large(src_folio));
> +
> +			folio_get(src_folio);
> +			/*
> +			 * folio_try_dup_anon_rmap_pmd does not fail for
> +			 * device private entries.
> +			 */
> +			VM_WARN_ON(folio_try_dup_anon_rmap_pmd(src_folio,
> +					  &src_folio->page, dst_vma, src_vma));
> +		}
> +
>  		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>  		mm_inc_nr_ptes(dst_mm);
>  		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
> @@ -2219,15 +2252,22 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			folio_remove_rmap_pmd(folio, page, vma);
>  			WARN_ON_ONCE(folio_mapcount(folio) < 0);
>  			VM_BUG_ON_PAGE(!PageHead(page), page);
> -		} else if (thp_migration_supported()) {
> +		} else if (is_pmd_migration_entry(orig_pmd) ||
> +				is_pmd_device_private_entry(orig_pmd)) {
>  			swp_entry_t entry;
>  
> -			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
>  			entry = pmd_to_swp_entry(orig_pmd);
>  			folio = pfn_swap_entry_folio(entry);
>  			flush_needed = 0;
> -		} else
> -			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
> +
> +			if (!thp_migration_supported())
> +				WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
> +
> +			if (is_pmd_device_private_entry(orig_pmd)) {
> +				folio_remove_rmap_pmd(folio, &folio->page, vma);
> +				WARN_ON_ONCE(folio_mapcount(folio) < 0);
> +			}
> +		}
>  
>  		if (folio_test_anon(folio)) {
>  			zap_deposited_table(tlb->mm, pmd);
> @@ -2247,6 +2287,15 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  				folio_mark_accessed(folio);
>  		}
>  
> +		/*
> +		 * Do a folio put on zone device private pages after
> +		 * changes to mm_counter, because the folio_put() will
> +		 * clean folio->mapping and the folio_test_anon() check
> +		 * will not be usable.
> +		 */
> +		if (folio_is_device_private(folio))
> +			folio_put(folio);
> +
>  		spin_unlock(ptl);
>  		if (flush_needed)
>  			tlb_remove_page_size(tlb, &folio->page, HPAGE_PMD_SIZE);
> @@ -2375,7 +2424,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		struct folio *folio = pfn_swap_entry_folio(entry);
>  		pmd_t newpmd;
>  
> -		VM_BUG_ON(!is_pmd_migration_entry(*pmd));
> +		VM_WARN_ON(!is_pmd_migration_entry(*pmd) &&
> +			   !folio_is_device_private(folio));
>  		if (is_writable_migration_entry(entry)) {
>  			/*
>  			 * A protection check is difficult so
> @@ -2388,6 +2438,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			newpmd = swp_entry_to_pmd(entry);
>  			if (pmd_swp_soft_dirty(*pmd))
>  				newpmd = pmd_swp_mksoft_dirty(newpmd);
> +		} else if (is_writable_device_private_entry(entry)) {
> +			entry = make_readable_device_private_entry(
> +							swp_offset(entry));
> +			newpmd = swp_entry_to_pmd(entry);
>  		} else {
>  			newpmd = *pmd;
>  		}
> @@ -2834,6 +2888,44 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
>  	pmd_populate(mm, pmd, pgtable);
>  }
>  
> +/**
> + * split_huge_device_private_folio - split a huge device private folio into
> + * smaller pages (of order 0), currently used by migrate_device logic to
> + * split folios for pages that are partially mapped
> + *
> + * @folio: the folio to split
> + *
> + * The caller has to hold the folio_lock and a reference via folio_get
> + */
> +int split_device_private_folio(struct folio *folio)
> +{
> +	struct folio *end_folio = folio_next(folio);
> +	struct folio *new_folio;
> +	int ret = 0;
> +
> +	/*
> +	 * Split the folio now. In the case of device
> +	 * private pages, this path is executed when
> +	 * the pmd is split and since freeze is not true
> +	 * it is likely the folio will be deferred_split.
> +	 *
> +	 * With device private pages, deferred splits of
> +	 * folios should be handled here to prevent partial
> +	 * unmaps from causing issues later on in migration
> +	 * and fault handling flows.
> +	 */
> +	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));

Why can't this freeze fail? The folio is still mapped afaics, why can't there be other references in addition to the caller?

> +	ret = __split_unmapped_folio(folio, 0, &folio->page, NULL, NULL, true);

Confusing to  __split_unmapped_folio() if folio is mapped...

--Mika




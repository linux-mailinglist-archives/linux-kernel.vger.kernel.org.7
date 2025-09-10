Return-Path: <linux-kernel+bounces-809371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB5B50CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466F7446981
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F1926D4F8;
	Wed, 10 Sep 2025 04:06:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF807199BC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757477192; cv=none; b=fzd3hRAidQWWQGP58NwlUvaB6h5V8gEY7l/4tQIelSl5dnNGnSzY83yZHZhEHVzXuRx9lp21l+xE/9Cyz/fQVa1h+pdTIVar3AlDX3FhMZNADvZ/6VUOtE3J1yXaHRer+v404WSyjnfjm6vdxN+fSn+CElifeckA00G26NRhPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757477192; c=relaxed/simple;
	bh=U0JXJ/7n51Kts9btcObJG0iKMTWOA2Btxw1//eHNdvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p975+/GqjFg60QQ40+ZDDGw0sRZXjd+heO1mWaCiJQPuVLRH4oHXnZNd1czkkg7kMExbQBY0ed773YjMz+NncuzkAG6npirx6SKl4QgbvZqA++Qs8fyOL18Mbd0JWcxoJHvZJ4VEBTNb1S1yzAd1rTYyRUp5+lWo5yJHsTrSOhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD8191596;
	Tue,  9 Sep 2025 21:06:21 -0700 (PDT)
Received: from [10.163.41.55] (unknown [10.163.41.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BDC43F66E;
	Tue,  9 Sep 2025 21:06:19 -0700 (PDT)
Message-ID: <8f0cdb97-ea43-4142-993a-17d47762602c@arm.com>
Date: Wed, 10 Sep 2025 09:36:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: Drop all references of writable and
 SCAN_PAGE_RO
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 kas@kernel.org, willy@infradead.org, hughd@google.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, richard.weiyang@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250908075028.38431-1-dev.jain@arm.com>
 <20250908075028.38431-3-dev.jain@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250908075028.38431-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/09/25 1:20 PM, Dev Jain wrote:
> Now that all actionable outcomes from checking pte_write() are gone,
> drop the related references.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/trace/events/huge_memory.h | 19 ++++++-------------
>  mm/khugepaged.c                    | 14 +++-----------
>  2 files changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 2305df6cb485..dd94d14a2427 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -19,7 +19,6 @@
>  	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
>  	EM( SCAN_PTE_UFFD_WP,		"pte_uffd_wp")			\
>  	EM( SCAN_PTE_MAPPED_HUGEPAGE,	"pte_mapped_hugepage")		\
> -	EM( SCAN_PAGE_RO,		"no_writable_page")		\
>  	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
>  	EM( SCAN_PAGE_NULL,		"page_null")			\
>  	EM( SCAN_SCAN_ABORT,		"scan_aborted")			\
> @@ -55,15 +54,14 @@ SCAN_STATUS
>  
>  TRACE_EVENT(mm_khugepaged_scan_pmd,
>  
> -	TP_PROTO(struct mm_struct *mm, struct folio *folio, bool writable,
> +	TP_PROTO(struct mm_struct *mm, struct folio *folio,
>  		 int referenced, int none_or_zero, int status, int unmapped),
>  
> -	TP_ARGS(mm, folio, writable, referenced, none_or_zero, status, unmapped),
> +	TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
>  
>  	TP_STRUCT__entry(
>  		__field(struct mm_struct *, mm)
>  		__field(unsigned long, pfn)
> -		__field(bool, writable)
>  		__field(int, referenced)
>  		__field(int, none_or_zero)
>  		__field(int, status)
> @@ -73,17 +71,15 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
>  	TP_fast_assign(
>  		__entry->mm = mm;
>  		__entry->pfn = folio ? folio_pfn(folio) : -1;
> -		__entry->writable = writable;
>  		__entry->referenced = referenced;
>  		__entry->none_or_zero = none_or_zero;
>  		__entry->status = status;
>  		__entry->unmapped = unmapped;
>  	),
>  
> -	TP_printk("mm=%p, scan_pfn=0x%lx, writable=%d, referenced=%d, none_or_zero=%d, status=%s, unmapped=%d",
> +	TP_printk("mm=%p, scan_pfn=0x%lx, referenced=%d, none_or_zero=%d, status=%s, unmapped=%d",
>  		__entry->mm,
>  		__entry->pfn,
> -		__entry->writable,
>  		__entry->referenced,
>  		__entry->none_or_zero,
>  		__print_symbolic(__entry->status, SCAN_STATUS),
> @@ -117,15 +113,14 @@ TRACE_EVENT(mm_collapse_huge_page,
>  TRACE_EVENT(mm_collapse_huge_page_isolate,
>  
>  	TP_PROTO(struct folio *folio, int none_or_zero,
> -		 int referenced, bool  writable, int status),
> +		 int referenced, int status),
>  
> -	TP_ARGS(folio, none_or_zero, referenced, writable, status),
> +	TP_ARGS(folio, none_or_zero, referenced, status),
>  
>  	TP_STRUCT__entry(
>  		__field(unsigned long, pfn)
>  		__field(int, none_or_zero)
>  		__field(int, referenced)
> -		__field(bool, writable)
>  		__field(int, status)
>  	),
>  
> @@ -133,15 +128,13 @@ TRACE_EVENT(mm_collapse_huge_page_isolate,
>  		__entry->pfn = folio ? folio_pfn(folio) : -1;
>  		__entry->none_or_zero = none_or_zero;
>  		__entry->referenced = referenced;
> -		__entry->writable = writable;
>  		__entry->status = status;
>  	),
>  
> -	TP_printk("scan_pfn=0x%lx, none_or_zero=%d, referenced=%d, writable=%d, status=%s",
> +	TP_printk("scan_pfn=0x%lx, none_or_zero=%d, referenced=%d, status=%s",
>  		__entry->pfn,
>  		__entry->none_or_zero,
>  		__entry->referenced,
> -		__entry->writable,
>  		__print_symbolic(__entry->status, SCAN_STATUS))
>  );
>  
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a0f1df2a7ae6..af5f5c80fe4e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -39,7 +39,6 @@ enum scan_result {
>  	SCAN_PTE_NON_PRESENT,
>  	SCAN_PTE_UFFD_WP,
>  	SCAN_PTE_MAPPED_HUGEPAGE,
> -	SCAN_PAGE_RO,
>  	SCAN_LACK_REFERENCED_PAGE,
>  	SCAN_PAGE_NULL,
>  	SCAN_SCAN_ABORT,
> @@ -557,7 +556,6 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  	struct folio *folio = NULL;
>  	pte_t *_pte;
>  	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
> -	bool writable = false;
>  
>  	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>  	     _pte++, address += PAGE_SIZE) {
> @@ -671,9 +669,6 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
>  								     address)))
>  			referenced++;
> -
> -		if (pte_write(pteval))
> -			writable = true;
>  	}
>  
>  	if (unlikely(cc->is_khugepaged && !referenced)) {
> @@ -681,13 +676,13 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  	} else {
>  		result = SCAN_SUCCEED;
>  		trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
> -						    referenced, writable, result);
> +						    referenced, result);
>  		return result;
>  	}
>  out:
>  	release_pte_pages(pte, _pte, compound_pagelist);
>  	trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
> -					    referenced, writable, result);
> +					    referenced, result);
>  	return result;
>  }
>  
> @@ -1280,7 +1275,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  	unsigned long _address;
>  	spinlock_t *ptl;
>  	int node = NUMA_NO_NODE, unmapped = 0;
> -	bool writable = false;
>  
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  
> @@ -1344,8 +1338,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  			result = SCAN_PTE_UFFD_WP;
>  			goto out_unmap;
>  		}
> -		if (pte_write(pteval))
> -			writable = true;
>  
>  		page = vm_normal_page(vma, _address, pteval);
>  		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
> @@ -1435,7 +1427,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  		*mmap_locked = false;
>  	}
>  out:
> -	trace_mm_khugepaged_scan_pmd(mm, folio, writable, referenced,
> +	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
>  				     none_or_zero, result, unmapped);
>  	return result;
>  }



Return-Path: <linux-kernel+bounces-835420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A605BA709E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B422C3BB040
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296AD2DC762;
	Sun, 28 Sep 2025 12:56:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4798217B50A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759064179; cv=none; b=NIT+v4FsNrY3IOZD40ohyXnb/EHrYD7wWT4F8hnpYh3MBl+PSFx8NEN1oxGxsy+uzVp0IrGPASZFttDFEaC0ADSJ0ADqT54nsF40Gl39fSOohL0omBvv/08jTal/6Vi+l9rC0utosX/QYIOJIo+yri2WRfaaD/Q+1HVhzNOmKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759064179; c=relaxed/simple;
	bh=bKevjmyRdsdsLaRE5vmt5SVjNSOSz52ILMJJDZA26FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhKeb/Sw0B2Z0d2NxkJzKKjGz2CHNNUGFV4fLdIvIlCD7WHhm5/E8NjWZaiG1HOzX7wOT7j74xsE8bMHD4fy8fRxYe2GT12ecxgbI2Qlf+yPW4j9RLWc+NeGdW9FgFYsqPC4SgthFXxLpCn9DSb7vsnF71k8l/I517m4pWB4LBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BBC826BC;
	Sun, 28 Sep 2025 05:56:07 -0700 (PDT)
Received: from [10.163.64.48] (unknown [10.163.64.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8CD43F694;
	Sun, 28 Sep 2025 05:56:12 -0700 (PDT)
Message-ID: <933cfdc7-9e3f-4dec-a5d9-bb193b0b7f13@arm.com>
Date: Sun, 28 Sep 2025 18:26:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: Fix some typos in hugetlb module
To: "jianyun.gao" <jianyungao89@gmail.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250927064926.1496579-1-jianyungao89@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250927064926.1496579-1-jianyungao89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/09/25 12:19 pm, jianyun.gao wrote:
> There are som typos in the code comments as follows:
>
>    differenciate ==> differentiate
>    refernece ==> reference
>    permissons ==> permissions
>    indepdenent ==> independent
>    Spliting ==> Splitting
>
> Just fix it.
>
> Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> ---
>   mm/hugetlb.c         | 6 +++---
>   mm/hugetlb_vmemmap.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index eed59cfb5d21..8ff9edd09504 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2954,7 +2954,7 @@ typedef enum {
>   	 * NOTE: This is mostly identical to MAP_CHG_NEEDED, except
>   	 * that currently vma_needs_reservation() has an unwanted side
>   	 * effect to either use end() or commit() to complete the
> -	 * transaction.	 Hence it needs to differenciate from NEEDED.
> +	 * transaction.	 Hence it needs to differentiate from NEEDED.
>   	 */
>   	MAP_CHG_ENFORCED = 2,
>   } map_chg_state;
> @@ -5998,7 +5998,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   	/*
>   	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
>   	 * could defer the flush until now, since by holding i_mmap_rwsem we
> -	 * guaranteed that the last refernece would not be dropped. But we must
> +	 * guaranteed that the last reference would not be dropped. But we must
>   	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
>   	 * dropped and the last reference to the shared PMDs page might be
>   	 * dropped as well.
> @@ -7179,7 +7179,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>   		} else if (unlikely(is_pte_marker(pte))) {
>   			/*
>   			 * Do nothing on a poison marker; page is
> -			 * corrupted, permissons do not apply.  Here
> +			 * corrupted, permissions do not apply.  Here

Can also fix the extra space between "apply" and "Here".

>   			 * pte_marker_uffd_wp()==true implies !poison
>   			 * because they're mutual exclusive.
>   			 */
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index ba0fb1b6a5a8..e6f79b2c63ee 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -75,7 +75,7 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
>   	if (likely(pmd_leaf(*pmd))) {
>   		/*
>   		 * Higher order allocations from buddy allocator must be able to
> -		 * be treated as indepdenent small pages (as they can be freed
> +		 * be treated as independent small pages (as they can be freed
>   		 * individually).
>   		 */
>   		if (!PageReserved(head))
> @@ -684,7 +684,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
>   		ret = hugetlb_vmemmap_split_folio(h, folio);
>   
>   		/*
> -		 * Spliting the PMD requires allocating a page, thus lets fail
> +		 * Splitting the PMD requires allocating a page, thus lets fail

lets -> let's or let us

>   		 * early once we encounter the first OOM. No point in retrying
>   		 * as it can be dynamically done on remap with the memory
>   		 * we get back from the vmemmap deduplication.
> @@ -715,7 +715,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
>   		/*
>   		 * Pages to be freed may have been accumulated.  If we
>   		 * encounter an ENOMEM,  free what we have and try again.
> -		 * This can occur in the case that both spliting fails
> +		 * This can occur in the case that both splitting fails
>   		 * halfway and head page allocation also failed. In this
>   		 * case __hugetlb_vmemmap_optimize_folio() would free memory
>   		 * allowing more vmemmap remaps to occur.

As Wei says, this patch can be merged with the earlier, thanks.



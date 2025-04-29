Return-Path: <linux-kernel+bounces-624437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6836AA0399
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 08:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4654E4674DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 06:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C1274FE8;
	Tue, 29 Apr 2025 06:41:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB32749E1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908909; cv=none; b=c0WTap4RB5cv/uah/F7ug0FqBcp/9t5Rkuxk0IZ32vs/JQEZNPcQdxXUT4B94S5Q8Rqouv+yxQvHN0zvBON4V5uW3Kp/cj1nrTf9abjHbYZ4GCEtJ7qg2a1trsMdWRMx/ORxL/37GvUQ3oofFfWt46rjQsBnBthUVToaXaut9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908909; c=relaxed/simple;
	bh=gJJ5StyvAs+3gjIZtp0EXr7O3BgJ+UUdegfPthinzOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3Y0LcNFvBL5PGenqMDOMO/0OvxFfEJKUp8eU//x/KOK/5sCM7NhsDY4/HWoru59X7XjkifxJgPFn2hJmvFib1hGnMAZb46g1mvOCLaaeo1sJqGGaMuAVUdkaSKJwTTSx58r4TduuGeRLnlH8C+IZvO50DRrBhzAuOVaWv6wIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BBA51515;
	Mon, 28 Apr 2025 23:41:38 -0700 (PDT)
Received: from [10.163.52.122] (unknown [10.163.52.122])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7B13F66E;
	Mon, 28 Apr 2025 23:41:33 -0700 (PDT)
Message-ID: <43dc2d0b-1ce9-4d56-a260-d1dfc4545c99@arm.com>
Date: Tue, 29 Apr 2025 12:11:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mm: Refactor code in mprotect
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, david@redhat.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
 will@kernel.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 vbabka@suse.cz, jannh@google.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 namit@vmware.com, hughd@google.com, yang@os.amperecomputing.com,
 ziy@nvidia.com
References: <20250429052336.18912-1-dev.jain@arm.com>
 <20250429052336.18912-2-dev.jain@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250429052336.18912-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/25 10:53, Dev Jain wrote:
> Reduce indentation in change_pte_range() by refactoring some of the code
> into a new function. No functional change.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/mprotect.c | 116 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 68 insertions(+), 48 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 88608d0dc2c2..70f59aa8c2a8 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -83,6 +83,71 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  	return pte_dirty(pte);
>  }
>  
> +
> +
> +static bool prot_numa_skip(struct vm_area_struct *vma, struct folio *folio,
> +		int target_node)
> +{
> +	bool toptier;
> +	int nid;
> +
> +	/* Also skip shared copy-on-write pages */
> +	if (is_cow_mapping(vma->vm_flags) &&
> +	    (folio_maybe_dma_pinned(folio) ||
> +	     folio_maybe_mapped_shared(folio)))
> +		return true;
> +
> +	/*
> +	 * While migration can move some dirty pages,
> +	 * it cannot move them all from MIGRATE_ASYNC
> +	 * context.
> +	 */
> +	if (folio_is_file_lru(folio) &&
> +	    folio_test_dirty(folio))
> +		return true;
> +
> +	/*
> +	 * Don't mess with PTEs if page is already on the node
> +	 * a single-threaded process is running on.
> +	 */
> +	nid = folio_nid(folio);
> +	if (target_node == nid)
> +		return true;
> +	toptier = node_is_toptier(nid);
> +
> +	/*
> +	 * Skip scanning top tier node if normal numa
> +	 * balancing is disabled
> +	 */
> +	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> +	    toptier)
> +		return true;
> +	return false;
> +}
> +
> +static bool prot_numa_avoid_fault(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t oldpte, int target_node)
> +{
> +	struct folio *folio;
> +	int ret;
> +
> +	/* Avoid TLB flush if possible */
> +	if (pte_protnone(oldpte))
> +		return true;
> +
> +	folio = vm_normal_folio(vma, addr, oldpte);
> +	if (!folio || folio_is_zone_device(folio) ||
> +	    folio_test_ksm(folio))
> +		return true;
> +	ret = prot_numa_skip(vma, folio, target_node);

What purpose does it solve to create additional helper prot_numa_skip().
IOW - why cannot all of these be inside prot_numa_avoid_fault() itself.

> +	if (ret)
> +		return ret;
> +	if (folio_use_access_time(folio))
> +		folio_xchg_access_time(folio,
> +			jiffies_to_msecs(jiffies));
> +	return false;
> +}
> +
>  static long change_pte_range(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
>  		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
> @@ -116,56 +181,11 @@ static long change_pte_range(struct mmu_gather *tlb,
>  			 * Avoid trapping faults against the zero or KSM
>  			 * pages. See similar comment in change_huge_pmd.
>  			 */
> -			if (prot_numa) {
> -				struct folio *folio;
> -				int nid;
> -				bool toptier;
> -
> -				/* Avoid TLB flush if possible */
> -				if (pte_protnone(oldpte))
> -					continue;
> -
> -				folio = vm_normal_folio(vma, addr, oldpte);
> -				if (!folio || folio_is_zone_device(folio) ||
> -				    folio_test_ksm(folio))
> -					continue;
> -
> -				/* Also skip shared copy-on-write pages */
> -				if (is_cow_mapping(vma->vm_flags) &&
> -				    (folio_maybe_dma_pinned(folio) ||
> -				     folio_maybe_mapped_shared(folio)))
> -					continue;
> -
> -				/*
> -				 * While migration can move some dirty pages,
> -				 * it cannot move them all from MIGRATE_ASYNC
> -				 * context.
> -				 */
> -				if (folio_is_file_lru(folio) &&
> -				    folio_test_dirty(folio))
> +			if (prot_numa &&
> +			    prot_numa_avoid_fault(vma, addr,
> +						  oldpte, target_node))
>  					continue;
>  
> -				/*
> -				 * Don't mess with PTEs if page is already on the node
> -				 * a single-threaded process is running on.
> -				 */
> -				nid = folio_nid(folio);
> -				if (target_node == nid)
> -					continue;
> -				toptier = node_is_toptier(nid);
> -
> -				/*
> -				 * Skip scanning top tier node if normal numa
> -				 * balancing is disabled
> -				 */
> -				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> -				    toptier)
> -					continue;
> -				if (folio_use_access_time(folio))
> -					folio_xchg_access_time(folio,
> -						jiffies_to_msecs(jiffies));
> -			}
> -
>  			oldpte = ptep_modify_prot_start(vma, addr, pte);
>  			ptent = pte_modify(oldpte, newprot);
>  


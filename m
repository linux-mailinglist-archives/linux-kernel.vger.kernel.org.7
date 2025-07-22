Return-Path: <linux-kernel+bounces-740702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A9CB0D81A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08FC189BBE4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1022E2F1C;
	Tue, 22 Jul 2025 11:25:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B887289811
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183507; cv=none; b=ko8AqMAm+eFtSsz33FUV5JS7sAPBa4Ao8phIF+TBJeQ6HxaqW2gx+rwWmH93nqyL9QL1I2fbdPhnqp9ptHuLw1In+FVV67F4cso3GW9RVZpqzBg9PyfGQcDTjKJAbC9I/ctC3rLbRsRKxIs1gi6vfPhJYkSMHAdPz8TZOTgFaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183507; c=relaxed/simple;
	bh=CHS+1lDwG4RKhNRs4RdFSgLJwKj3ZZWuLF23+NulHjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKYemmRV6c8/pnVo/fpy7qKQim8ZOvUuDVYAlCGk3Ow/tDDDQe+QFDUhwcoUxF5EEyd9DrhB61JKv+WdGhmhKtKmiaQwN386gSHumSwXZdEGacSCI0oWGF5+xVYTbfWSTrZTAOH7++QvUuMtax4vYo/6ntrDv6raVSzZLSP59aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBEB8152B;
	Tue, 22 Jul 2025 04:24:58 -0700 (PDT)
Received: from [10.1.30.167] (XHFQ2J9959.cambridge.arm.com [10.1.30.167])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C27A3F66E;
	Tue, 22 Jul 2025 04:25:01 -0700 (PDT)
Message-ID: <dc0b5e94-f5aa-407e-bad2-150814dc4885@arm.com>
Date: Tue, 22 Jul 2025 12:25:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] mm: Refactor MM_CP_PROT_NUMA skipping case into
 new function
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
 joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-2-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250718090244.21092-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2025 10:02, Dev Jain wrote:
> Reduce indentation by refactoring the prot_numa case into a new function.
> No functional change intended.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/mprotect.c | 101 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 55 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 88709c01177b..2a9c73bd0778 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -83,6 +83,59 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  	return pte_dirty(pte);
>  }
>  
> +static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
> +			   pte_t oldpte, pte_t *pte, int target_node)
> +{
> +	struct folio *folio;
> +	bool toptier;
> +	int nid;
> +
> +	/* Avoid TLB flush if possible */
> +	if (pte_protnone(oldpte))
> +		return true;
> +
> +	folio = vm_normal_folio(vma, addr, oldpte);
> +	if (!folio)
> +		return true;
> +
> +	if (folio_is_zone_device(folio) || folio_test_ksm(folio))
> +		return true;
> +
> +	/* Also skip shared copy-on-write pages */
> +	if (is_cow_mapping(vma->vm_flags) &&
> +	    (folio_maybe_dma_pinned(folio) || folio_maybe_mapped_shared(folio)))
> +		return true;
> +
> +	/*
> +	 * While migration can move some dirty pages,
> +	 * it cannot move them all from MIGRATE_ASYNC
> +	 * context.
> +	 */
> +	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
> +		return true;
> +
> +	/*
> +	 * Don't mess with PTEs if page is already on the node
> +	 * a single-threaded process is running on.
> +	 */
> +	nid = folio_nid(folio);
> +	if (target_node == nid)
> +		return true;
> +
> +	toptier = node_is_toptier(nid);
> +
> +	/*
> +	 * Skip scanning top tier node if normal numa
> +	 * balancing is disabled
> +	 */
> +	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) && toptier)
> +		return true;
> +
> +	if (folio_use_access_time(folio))
> +		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));

Perhaps this bit should be kept in the original location? It's got nothing to do
with determining if the pte should be skipped.

Thanks,
Ryan

> +	return false;
> +}
> +
>  static long change_pte_range(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
>  		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
> @@ -117,53 +170,9 @@ static long change_pte_range(struct mmu_gather *tlb,
>  			 * pages. See similar comment in change_huge_pmd.
>  			 */
>  			if (prot_numa) {
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
> -					continue;
> -
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
> +				if (prot_numa_skip(vma, addr, oldpte, pte,
> +						   target_node))
>  					continue;
> -				if (folio_use_access_time(folio))
> -					folio_xchg_access_time(folio,
> -						jiffies_to_msecs(jiffies));
>  			}
>  
>  			oldpte = ptep_modify_prot_start(vma, addr, pte);



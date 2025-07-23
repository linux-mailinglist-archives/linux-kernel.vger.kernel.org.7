Return-Path: <linux-kernel+bounces-741797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F58B0E90C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4E1564E04
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5644923C512;
	Wed, 23 Jul 2025 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bXb7mXUn"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DFF9E8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753241361; cv=none; b=mH7NinuJvmAB5H27NEVDc1MGd9bQV1s4rEkud69S/KBcL1Y63HBjlFWqWU1z7XJzoVJgSbHyInlto8OiEs71/WvK9gjamZvskcA4IwBHOoQeyzJgvoala8YMd9fTqN1bu2wnoDMEGi7M8rhLG65EbaAY+etTo3QN9Wq+sgi9RAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753241361; c=relaxed/simple;
	bh=KykIRhvIw9SpQgeesBGM/mVufvu7q2/NuBze9CTXnLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1qDNsvKttwFtLvz/6LmoMKWG0DwX8qbxBIK06YNiD4dbmvZ2yuPIEb2MXaNnPkhDrbOKUUnGFsyNCbqMwSR6uiYtDo8XiZpqRbsmYQSYR44a8VMSLkcxCVeA0GZMjW8Sy7AxHu7/WlUM0VTLJX4jDHC+SWEcZ6JxKzShSzYgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bXb7mXUn; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753241350; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P6Jagj2jPuRvwPABsY6jnls738Yft9yLjN8PP/NZGf0=;
	b=bXb7mXUnoDs8F+/9eU/ZXdmO5BZ0reSRqVqE5VN5r6QpLj+Wruu+Gdla//AwJdEfzM1MOyGdYNe+eAFCxHQc0xIM0ClqGX+fL7DQip2eNRHDGAuMz0kYKX34hxNvtTJ7cg7FlFLJMRVSNjJEQVpmj6R8iX9yv9wJbyfX83KH2mo=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjZl.Qi_1753241348 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Jul 2025 11:29:09 +0800
Message-ID: <2dfb2d7a-40c4-4ab6-be71-4a03670ea994@linux.alibaba.com>
Date: Wed, 23 Jul 2025 11:29:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm: add get_and_clear_ptes() and clear_ptes()
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com
Cc: ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250722150559.96465-1-dev.jain@arm.com>
 <20250722150559.96465-2-dev.jain@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250722150559.96465-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/22 23:05, Dev Jain wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> From: David Hildenbrand <david@redhat.com>
> 
> Let's add variants to be used where "full" does not apply -- which will
> be the majority of cases in the future. "full" really only applies if
> we are about to tear down a full MM.
> 
> Use get_and_clear_ptes() in existing code, clear_ptes() users will
> be added next.
> 
> Should we make these inline functions instead and add separate docs?
> Probably not worth it for now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   arch/arm64/mm/mmu.c     | 2 +-
>   include/linux/pgtable.h | 6 ++++++
>   mm/mremap.c             | 2 +-
>   mm/rmap.c               | 2 +-
>   4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index abd9725796e9..20a89ab97dc5 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1528,7 +1528,7 @@ early_initcall(prevent_bootmem_remove_init);
>   pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long addr,
>   			     pte_t *ptep, unsigned int nr)
>   {
> -	pte_t pte = get_and_clear_full_ptes(vma->vm_mm, addr, ptep, nr, /* full = */ 0);
> +	pte_t pte = get_and_clear_ptes(vma->vm_mm, addr, ptep, nr);
>   
>   	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
>   		/*
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e3b99920be05..e45986b54277 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -736,6 +736,9 @@ static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
>   }
>   #endif
>   
> +#define get_and_clear_ptes(_mm, _addr, _ptep, _nr) \
> +	get_and_clear_full_ptes(_mm, _addr, _ptep, _nr, 0)
> +
>   #ifndef clear_full_ptes
>   /**
>    * clear_full_ptes - Clear present PTEs that map consecutive pages of the same
> @@ -768,6 +771,9 @@ static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
>   }
>   #endif
>   
> +#define clear_ptes(_mm, _addr, _ptep, _nr) \
> +	clear_full_ptes(_mm, _addr, _ptep, _nr, 0)
> +
>   /*
>    * If two threads concurrently fault at the same page, the thread that
>    * won the race updates the PTE and its local TLB/Cache. The other thread
> diff --git a/mm/mremap.c b/mm/mremap.c
> index ac39845e9718..677a4d744df9 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -280,7 +280,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
>   							 old_pte, max_nr_ptes);
>   			force_flush = true;
>   		}
> -		pte = get_and_clear_full_ptes(mm, old_addr, old_ptep, nr_ptes, 0);
> +		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
>   		pte = move_pte(pte, old_addr, new_addr);
>   		pte = move_soft_dirty_pte(pte);
>   
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f93ce27132ab..568198e9efc2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2036,7 +2036,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			flush_cache_range(vma, address, end_addr);
>   
>   			/* Nuke the page table entry. */
> -			pteval = get_and_clear_full_ptes(mm, address, pvmw.pte, nr_pages, 0);
> +			pteval = get_and_clear_ptes(mm, address, pvmw.pte, nr_pages);
>   			/*
>   			 * We clear the PTE but do not flush so potentially
>   			 * a remote CPU could still be writing to the folio.



Return-Path: <linux-kernel+bounces-841512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E71BB78E7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64A434E55DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69912C08CA;
	Fri,  3 Oct 2025 16:33:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF567274B59
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509207; cv=none; b=RRqlDYzFnGtkte6Sium/6/+7tecBaT/ZNP50ATsK3FKa9gE8jxfirGtiOAScoOh2cf16QtWqO0EwSyXKRkt1eU/nBk0xT/dlGDaVfzNNhV14s18uNDdcmen4pCPFUsFHWYQR3dngKpdRHKBk8RFjTQLSG1fbnD9filFYln3cwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509207; c=relaxed/simple;
	bh=im9VFR3hf7/ztjJ4uqFlHx9zalqHDqMxC4tn7T7ExUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFtdd8r8N2Ql5pGCpUQBD2U3aG+BeX6417j3dvtymOD7lb5pmeYTByq/rYFaKlJh1LzH2qaYMdee6h0lmUY87/qz9lk5tt8wsLf14prlgvUBAOdpSEvY9aIIwgdy+5AyPnmSBirU8W4DwrwNzqp44aahRGUsGo65+oJhpX8P2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F13D1655;
	Fri,  3 Oct 2025 09:33:17 -0700 (PDT)
Received: from [10.163.65.114] (unknown [10.163.65.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E3AC3F5A1;
	Fri,  3 Oct 2025 09:33:18 -0700 (PDT)
Message-ID: <b8fc9ab7-a96f-4763-9432-8aa8c3c2a87d@arm.com>
Date: Fri, 3 Oct 2025 22:03:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 1/2] mm/khugepaged: optimize PTE scanning with
 if-else-if-else-if chain
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-2-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251002073255.14867-2-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/10/25 1:02 pm, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> As pointed out by Dev, the PTE checks for disjoint conditions in the
> scanning loops can be optimized. is_swap_pte, (pte_none && is_zero_pfn),
> and pte_uffd_wp are mutually exclusive.
>
> This patch refactors the loops in both __collapse_huge_page_isolate() and
> hpage_collapse_scan_pmd() to use a continuous if-else-if-else-if chain
> instead of separate if blocks.
>
> Also, this is a preparatory step to make it easier to merge the
> almost-duplicated scanning logic in these two functions, as suggested
> by David.
>
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   mm/khugepaged.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index f4f57ba69d72..808523f92c7b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -548,8 +548,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>   	     _pte++, addr += PAGE_SIZE) {
>   		pte_t pteval = ptep_get(_pte);
> -		if (pte_none(pteval) || (pte_present(pteval) &&
> -				is_zero_pfn(pte_pfn(pteval)))) {
> +		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {

Should have mentioned in the description that pte_present() is not required
here, so removing it.

Reviewed-by: Dev Jain <dev.jain@arm.com>

>   			++none_or_zero;
>   			if (!userfaultfd_armed(vma) &&
>   			    (!cc->is_khugepaged ||
> @@ -560,12 +559,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>   				goto out;
>   			}
> -		}
> -		if (!pte_present(pteval)) {
> +		} else if (!pte_present(pteval)) {
>   			result = SCAN_PTE_NON_PRESENT;
>   			goto out;
> -		}
> -		if (pte_uffd_wp(pteval)) {
> +		} else if (pte_uffd_wp(pteval)) {
>   			result = SCAN_PTE_UFFD_WP;
>   			goto out;
>   		}
> @@ -1316,8 +1313,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>   				goto out_unmap;
>   			}
> -		}
> -		if (pte_uffd_wp(pteval)) {
> +		} else if (pte_uffd_wp(pteval)) {
>   			/*
>   			 * Don't collapse the page if any of the small
>   			 * PTEs are armed with uffd write protection.


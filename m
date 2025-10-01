Return-Path: <linux-kernel+bounces-838713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C115BAFFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3D13B735A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73779296BBF;
	Wed,  1 Oct 2025 10:20:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E23D1A3165
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314048; cv=none; b=sQ0RqNKEFnQeMJafiZYJpUS/YN/cHGiE6qiZtwcT6chH8YwUyq9fX4q26FTX2uMFIZrTpqxXwQ0t79Bd/7pQao+E1+se7SRFUiGCJbdWCxkHUgb2E4Q8Qd4tfOlIYVmHg0Y5gZtsDrOTRy825eNcdKvA1dtRcV687UlCcpTlCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314048; c=relaxed/simple;
	bh=ufX2gSIr1AmDhY08nJvRMf2JOGKmK77sHDrOjj2utZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shQWQXw3bMCGlZIgeRlVh+U8moHRsxwg9gN+IJe6mkncYwguyVVfRq963bhHrHfRivrT3hRuP0GDBANf92DEjq4VYu+VM8RHuMQSGqCoS8y2nIqvfScA2sIxN1Tmxlv3Va1y/EpwqnDooBEM09DrnnVtAJ4IUIeyzaS3nWcfwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7AA416F2;
	Wed,  1 Oct 2025 03:20:37 -0700 (PDT)
Received: from [10.164.18.53] (MacBook-Pro.blr.arm.com [10.164.18.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 735BF3F66E;
	Wed,  1 Oct 2025 03:20:40 -0700 (PDT)
Message-ID: <a1df234c-d003-4696-8f1f-609a360fdeda@arm.com>
Date: Wed, 1 Oct 2025 15:50:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com
References: <20251001032251.85888-1-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251001032251.85888-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 01/10/25 8:52 am, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> Currently, special non-swap entries (like migration, hwpoison, or PTE
> markers) are not caught early in hpage_collapse_scan_pmd(), leading to
> failures deep in the swap-in logic.
>
> hpage_collapse_scan_pmd()
>   `- collapse_huge_page()
>       `- __collapse_huge_page_swapin() -> fails!
>
> As David suggested[1], this patch skips any such non-swap entries
> early. If any one is found, the scan is aborted immediately with the
> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
> work.
>
> [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> v1 -> v2:
>   - Skip all non-present entries except swap entries (per David) thanks!
>   - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/
>
>   mm/khugepaged.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 7ab2d1a42df3..d0957648db19 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>   	     _pte++, addr += PAGE_SIZE) {
>   		pte_t pteval = ptep_get(_pte);
> -		if (is_swap_pte(pteval)) {
> +		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> +			++none_or_zero;
> +			if (!userfaultfd_armed(vma) &&
> +			    (!cc->is_khugepaged ||
> +			     none_or_zero <= khugepaged_max_ptes_none)) {
> +				continue;
> +			} else {
> +				result = SCAN_EXCEED_NONE_PTE;
> +				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +				goto out_unmap;
> +			}
> +		} else if (!pte_present(pteval)) {

If you are trying to merge this with the _isolate() conditions, we can do
a micro-optimization here - is_swap_pte, (pte_none && is_zero_pfn), and pte_uffd_wp
are disjoint conditions, so we can use if-else-if-else-if to write them.

> +			if (non_swap_entry(pte_to_swp_entry(pteval))) {
> +				result = SCAN_PTE_NON_PRESENT;
> +				goto out_unmap;
> +			}
> +
>   			++unmapped;
>   			if (!cc->is_khugepaged ||
>   			    unmapped <= khugepaged_max_ptes_swap) {
> @@ -1293,7 +1309,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   				 * enabled swap entries.  Please see
>   				 * comment below for pte_uffd_wp().
>   				 */
> -				if (pte_swp_uffd_wp_any(pteval)) {
> +				if (pte_swp_uffd_wp(pteval)) {
>   					result = SCAN_PTE_UFFD_WP;

Could have mentioned in the changelog "while at it, convert pte_swp_uffd_wp_any to
pte_swp_uffd_wp since we are in the swap pte branch".

>   					goto out_unmap;
>   				}
> @@ -1304,18 +1320,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   				goto out_unmap;
>   			}
>   		}
> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> -			++none_or_zero;
> -			if (!userfaultfd_armed(vma) &&
> -			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> -				continue;
> -			} else {
> -				result = SCAN_EXCEED_NONE_PTE;
> -				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> -				goto out_unmap;
> -			}
> -		}
>   		if (pte_uffd_wp(pteval)) {
>   			/*
>   			 * Don't collapse the page if any of the small

Otherwise LGTM

Reviewed-by: Dev Jain <dev.jain@arm.com>



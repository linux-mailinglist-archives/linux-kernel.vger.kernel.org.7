Return-Path: <linux-kernel+bounces-838697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AB7BAFF42
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE11C715A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E4D29A31C;
	Wed,  1 Oct 2025 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NP+oJT9X"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC326F2BF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759313182; cv=none; b=RG2BXeZl/AexgD9KYRu6xEq15bbpYN652MqNuDwdA0aUB2Ndis9TdpTA3LGx8XxZz7iG0Sc9bBFPQP07EETPw20YBz6V2JgtMcRYdHehlySf9qlh8CdAzVhhshsnueIcmEDqxCq0/pyKSflieY9k1sZI4jztBT8Wbku5BT88+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759313182; c=relaxed/simple;
	bh=r4Ve0ZAjFPnnIreiUJrCpPqpN+b/1y2UACdqWzPdy/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9tsj5qC+BvmbK6iY4FY7QazraWWCre8BDsyJYIJCrjEK7gkcpbOXEek7SRvv4s0X3UKEHP8xw6FfLuAY2Wt41GZqKajLsVd4lrgFld7hRdzv/X80l/zVmlMvqO8BHoRqf26odNU0FFBKMS+7yQ6UlR3SEH2T/KpBrjETOQvn38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NP+oJT9X; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1d09acbf-ccc9-4f06-9392-669c98e34661@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759313176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=393rN1ZpjbBC/kxJBIELF7diTurMQySclAxKyAjIUr4=;
	b=NP+oJT9Xu+AIdWD3V7YlGutu+9IPikN9WZKVvB11Dhj7ychLuogT3WtOw5FNQXyilQPRnp
	dmwRpn5dn5cV7eXJ7Gf1MxlWz95XyJ1jBzFfPsHAfTHsrStEKsNUb6mJqGtTglcsiJxw71
	1Z6rlohEHy+UlVPl7khZgQyjYDHluhY=
Date: Wed, 1 Oct 2025 18:05:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 dev.jain@arm.com, hughd@google.com, ioworker0@gmail.com,
 kirill@shutemov.name, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <20251001085425.5iq2mgfom6sqkbbx@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251001085425.5iq2mgfom6sqkbbx@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/1 16:54, Wei Yang wrote:
> On Wed, Oct 01, 2025 at 11:22:51AM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Currently, special non-swap entries (like migration, hwpoison, or PTE
>> markers) are not caught early in hpage_collapse_scan_pmd(), leading to
>> failures deep in the swap-in logic.
>>
>> hpage_collapse_scan_pmd()
>> `- collapse_huge_page()
>>      `- __collapse_huge_page_swapin() -> fails!
>>
>> As David suggested[1], this patch skips any such non-swap entries
>> early. If any one is found, the scan is aborted immediately with the
>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>> work.
>>
>> [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
>> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> v1 -> v2:
>> - Skip all non-present entries except swap entries (per David) thanks!
>> - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/
>>
>> mm/khugepaged.c | 32 ++++++++++++++++++--------------
>> 1 file changed, 18 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 7ab2d1a42df3..d0957648db19 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>> 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>> 	     _pte++, addr += PAGE_SIZE) {
>> 		pte_t pteval = ptep_get(_pte);
>> -		if (is_swap_pte(pteval)) {
> 
> It looks is_swap_pte() is mis-leading?

Hmm.. not to me, IMO. is_swap_pte() just means:

!pte_none(pte) && !pte_present(pte)

> 
>> +		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> +			++none_or_zero;
>> +			if (!userfaultfd_armed(vma) &&
>> +			    (!cc->is_khugepaged ||
>> +			     none_or_zero <= khugepaged_max_ptes_none)) {
>> +				continue;
>> +			} else {
>> +				result = SCAN_EXCEED_NONE_PTE;
>> +				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> +				goto out_unmap;
>> +			}
>> +		} else if (!pte_present(pteval)) {
>> +			if (non_swap_entry(pte_to_swp_entry(pteval))) {
>> +				result = SCAN_PTE_NON_PRESENT;
>> +				goto out_unmap;
>> +			}
>> +
>> 			++unmapped;
>> 			if (!cc->is_khugepaged ||
>> 			    unmapped <= khugepaged_max_ptes_swap) {
>> @@ -1293,7 +1309,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>> 				 * enabled swap entries.  Please see
>> 				 * comment below for pte_uffd_wp().
>> 				 */
>> -				if (pte_swp_uffd_wp_any(pteval)) {
>> +				if (pte_swp_uffd_wp(pteval)) {
> 
> I am not sure why we want to change this. There is no description in the
> change log.
> 
> Would you mind giving some hint on this?

The reason is that pte_swp_uffd_wp_any(pte) is broader than what
we need :)

static inline bool pte_swp_uffd_wp_any(pte_t pte)
{
#ifdef CONFIG_PTE_MARKER_UFFD_WP
	if (!is_swap_pte(pte))
		return false;

	if (pte_swp_uffd_wp(pte))
		return true;

	if (pte_marker_uffd_wp(pte))
		return true;
#endif
	return false;
}

In the context within hpage_collapse_scan_pmd(), we are already inside
an is_swap_pte() block, and we have just handled all non-swap entries
(which would include pte_marker_uffd_wp()).

So we only need to check if the swap entry itself is write-protected
for userfaultfd ;)

Hope that explains it. I skipped it in the changelog as it's a tiny
cleanup ...

Thanks,
Lance

> 
>> 					result = SCAN_PTE_UFFD_WP;
>> 					goto out_unmap;
>> 				}
>> @@ -1304,18 +1320,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>> 				goto out_unmap;
>> 			}
>> 		}
>> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> -			++none_or_zero;
>> -			if (!userfaultfd_armed(vma) &&
>> -			    (!cc->is_khugepaged ||
>> -			     none_or_zero <= khugepaged_max_ptes_none)) {
>> -				continue;
>> -			} else {
>> -				result = SCAN_EXCEED_NONE_PTE;
>> -				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> -				goto out_unmap;
>> -			}
>> -		}
>> 		if (pte_uffd_wp(pteval)) {
>> 			/*
>> 			 * Don't collapse the page if any of the small
>> -- 
>> 2.49.0
> 



Return-Path: <linux-kernel+bounces-843819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1ADBC0566
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CEE189E4A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955741DDA1E;
	Tue,  7 Oct 2025 06:30:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECB71F936
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818615; cv=none; b=eNQ9it4FKgBmYLwaVAXGLgZvkRcKoviifLdy3ywTQsSAYlZiVTA715ASRt39nZA3zC3d0idMqMqncjH4dbQzUAUw9gTZsnkBf6Fxg4ZoelMDEQF3hfKvo4xhtzaeqO1gN2jcGZmTemfhwxtcpo0hsv4OizZwVMayTfKdTdsdmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818615; c=relaxed/simple;
	bh=Lbe8ZT0ceTL1YIksr/EVnxhD1mGGOqPvdn8I5FdfI78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLQOghi8TtcqDvEnK5MFof5R1DMWBxJsYN4Kc83NAz6afBCeYs6fhFMJfQeyENihPKf+MGfPyiR0l574lLSvdzdwFIzNVU5yhkCQNoW9ikGa0A9xiiEsCQIH9IjAhHdSoW/e3K64TLJjSRz9w88tJ0uNSizeWG0Whkl+F3q8HxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6060A14BF;
	Mon,  6 Oct 2025 23:30:04 -0700 (PDT)
Received: from [10.163.65.24] (unknown [10.163.65.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 655C73F59E;
	Mon,  6 Oct 2025 23:30:07 -0700 (PDT)
Message-ID: <586f6282-ac7e-42d2-b132-0ba067623ddc@arm.com>
Date: Tue, 7 Oct 2025 11:58:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 3/3] mm/khugepaged: merge PTE scanning logic
 into a new helper
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251006144338.96519-1-lance.yang@linux.dev>
 <20251006144338.96519-4-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251006144338.96519-4-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/10/25 8:13 pm, Lance Yang wrote:
> +static inline int thp_collapse_check_pte(pte_t pte, struct vm_area_struct *vma,
> +		unsigned long addr, struct collapse_control *cc,
> +		struct folio **foliop, int *none_or_zero, int *unmapped,
> +		int *shared, int *scan_result)

Nit: Will prefer the cc parameter to go at the last.

> +{
> +	struct folio *folio = NULL;
> +	struct page *page = NULL;
> +
> +	if (pte_none(pte) || is_zero_pfn(pte_pfn(pte))) {
> +		(*none_or_zero)++;
> +		if (!userfaultfd_armed(vma) &&
> +		    (!cc->is_khugepaged ||
> +		     *none_or_zero <= khugepaged_max_ptes_none)) {
> +			return PTE_CHECK_CONTINUE;
> +		} else {
> +			*scan_result = SCAN_EXCEED_NONE_PTE;
> +			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +			return PTE_CHECK_FAIL;
> +		}
> +	} else if (!pte_present(pte)) {
> +		if (!unmapped) {
> +			*scan_result = SCAN_PTE_NON_PRESENT;
> +			return PTE_CHECK_FAIL;
> +		}
> +
> +		if (non_swap_entry(pte_to_swp_entry(pte))) {
> +			*scan_result = SCAN_PTE_NON_PRESENT;
> +			return PTE_CHECK_FAIL;
> +		}
> +
> +		(*unmapped)++;
> +		if (!cc->is_khugepaged ||
> +		    *unmapped <= khugepaged_max_ptes_swap) {
> +			/*
> +			 * Always be strict with uffd-wp enabled swap
> +			 * entries. Please see comment below for
> +			 * pte_uffd_wp().
> +			 */
> +			if (pte_swp_uffd_wp(pte)) {
> +				*scan_result = SCAN_PTE_UFFD_WP;
> +				return PTE_CHECK_FAIL;
> +			}
> +			return PTE_CHECK_CONTINUE;
> +		} else {
> +			*scan_result = SCAN_EXCEED_SWAP_PTE;
> +			count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
> +			return PTE_CHECK_FAIL;
> +		}
> +	} else if (pte_uffd_wp(pte)) {
> +		/*
> +		 * Don't collapse the page if any of the small PTEs are
> +		 * armed with uffd write protection. Here we can also mark
> +		 * the new huge pmd as write protected if any of the small
> +		 * ones is marked but that could bring unknown userfault
> +		 * messages that falls outside of the registered range.
> +		 * So, just be simple.
> +		 */
> +		*scan_result = SCAN_PTE_UFFD_WP;
> +		return PTE_CHECK_FAIL;
> +	}
> +
> +	page = vm_normal_page(vma, addr, pte);

You should use vm_normal_folio here and drop struct page altogether - this was also
noted during the review of the mTHP collapse patchset.



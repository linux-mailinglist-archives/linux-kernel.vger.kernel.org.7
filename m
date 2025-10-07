Return-Path: <linux-kernel+bounces-843937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77972BC0A27
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CE7034D179
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4302566DD;
	Tue,  7 Oct 2025 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="poFK5QJq"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9C13BC3F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825945; cv=none; b=ZBtOG0xjVaM4/0vy/TJYR50MGOuabdFkv9jeQR0po9j0o0uqDfJBkeyzzRM2tLV8VVheYl4+/j9HA9DP0codkhQxL2nKivNlnMYwYDbDqcN4JA/LCxK8/oQTY5pbyBozmqIdnGNaCS5FNPpeRC//eW3H9QFT2J5pjtqWOLGJdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825945; c=relaxed/simple;
	bh=W5Jzxep2mhNyuaY2GBbgXVerVfRC2WubWc0dwOCBfo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnC01J1bat4kpjBeS05O2EGNCPvJRI5HxkbnVYgQHkFAROAxpo4SvVkR27MPu0VAAxwq9Onfu4Gl2nkceLzXnja38smhtJjUlXSlkO3YVblCBAwnutYc4I6kHviJ1+k+3NO414wzRL9tL3Ttw9zLsdTQp4DvYzqRxNcE3cXxKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=poFK5QJq; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c89256b8-bec3-4bc8-8399-cb44794f70f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759825934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=708hk4v3K6U22ycgyF+Dfx1gxlMvrf8ku8x+RwSAqRg=;
	b=poFK5QJqDXcZYwm/pfaHunbTVH62Gwx6FqZESEIDH0vgX6lQXYC8rbj8UPeUdHGaDODAak
	viQKiHuOefku37kxtGPpa8PnhP8iE+Kns9Tw5w4yDfaA/0yX0DrIOMyBYXpPosVIo31OEn
	ki2kZeCXxQKJMQWzEEYm4GgIgb8sFXo=
Date: Tue, 7 Oct 2025 16:32:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 3/3] mm/khugepaged: merge PTE scanning logic
 into a new helper
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, david@redhat.com
References: <20251006144338.96519-1-lance.yang@linux.dev>
 <20251006144338.96519-4-lance.yang@linux.dev>
 <586f6282-ac7e-42d2-b132-0ba067623ddc@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <586f6282-ac7e-42d2-b132-0ba067623ddc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/7 14:28, Dev Jain wrote:
> 
> On 06/10/25 8:13 pm, Lance Yang wrote:
>> +static inline int thp_collapse_check_pte(pte_t pte, struct 
>> vm_area_struct *vma,
>> +        unsigned long addr, struct collapse_control *cc,
>> +        struct folio **foliop, int *none_or_zero, int *unmapped,
>> +        int *shared, int *scan_result)
> 
> Nit: Will prefer the cc parameter to go at the last.

Yep, got it.

> 
>> +{
>> +    struct folio *folio = NULL;
>> +    struct page *page = NULL;
>> +
>> +    if (pte_none(pte) || is_zero_pfn(pte_pfn(pte))) {
>> +        (*none_or_zero)++;
>> +        if (!userfaultfd_armed(vma) &&
>> +            (!cc->is_khugepaged ||
>> +             *none_or_zero <= khugepaged_max_ptes_none)) {
>> +            return PTE_CHECK_CONTINUE;
>> +        } else {
>> +            *scan_result = SCAN_EXCEED_NONE_PTE;
>> +            count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> +            return PTE_CHECK_FAIL;
>> +        }
>> +    } else if (!pte_present(pte)) {
>> +        if (!unmapped) {
>> +            *scan_result = SCAN_PTE_NON_PRESENT;
>> +            return PTE_CHECK_FAIL;
>> +        }
>> +
>> +        if (non_swap_entry(pte_to_swp_entry(pte))) {
>> +            *scan_result = SCAN_PTE_NON_PRESENT;
>> +            return PTE_CHECK_FAIL;
>> +        }
>> +
>> +        (*unmapped)++;
>> +        if (!cc->is_khugepaged ||
>> +            *unmapped <= khugepaged_max_ptes_swap) {
>> +            /*
>> +             * Always be strict with uffd-wp enabled swap
>> +             * entries. Please see comment below for
>> +             * pte_uffd_wp().
>> +             */
>> +            if (pte_swp_uffd_wp(pte)) {
>> +                *scan_result = SCAN_PTE_UFFD_WP;
>> +                return PTE_CHECK_FAIL;
>> +            }
>> +            return PTE_CHECK_CONTINUE;
>> +        } else {
>> +            *scan_result = SCAN_EXCEED_SWAP_PTE;
>> +            count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>> +            return PTE_CHECK_FAIL;
>> +        }
>> +    } else if (pte_uffd_wp(pte)) {
>> +        /*
>> +         * Don't collapse the page if any of the small PTEs are
>> +         * armed with uffd write protection. Here we can also mark
>> +         * the new huge pmd as write protected if any of the small
>> +         * ones is marked but that could bring unknown userfault
>> +         * messages that falls outside of the registered range.
>> +         * So, just be simple.
>> +         */
>> +        *scan_result = SCAN_PTE_UFFD_WP;
>> +        return PTE_CHECK_FAIL;
>> +    }
>> +
>> +    page = vm_normal_page(vma, addr, pte);
> 
> You should use vm_normal_folio here and drop struct page altogether - 
> this was also
> noted during the review of the mTHP collapse patchset.

Right, I missed that vm_normal_folio() was the way to go here :)

Thanks for the pointer!
Lance


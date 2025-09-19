Return-Path: <linux-kernel+bounces-823923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307EDB87BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69851896B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887318BBB9;
	Fri, 19 Sep 2025 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kkZnUCqS"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589891F875A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758249926; cv=none; b=IlOL6KfzpTkNh9kvbiy3hO2pUAGZKk8ho3cEA6YEjIA/aSkEl+JL4v3fiyBr2kH59SiMOH9wsiKkdgbdi3xAKNwhAQpQyC63O2ONFUHyze2rW7gGnLnmIBPUIVri7+SQaRaLgoF+1D0Z+W0DKnYfzGiH7H7crmCpXvkuA+NS2Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758249926; c=relaxed/simple;
	bh=6zFDx2Zuzm7i23PZ+F83cFt4yBUktJbixiLg31FQI5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkxTFska/4m7Qh681jkzdcjtjIxyk6mxittFKpqhBJ6JrlfW8QmWNwJUcPvTRG3eKna+i/ujxauv0oeyILYsoHMrqPoTYkWo6IhdL+WWy6h0kUEwfax3UxVL3OtUkNBJDvhSlQuQrXTiIPh/e5lTcI1upIlO7VmlONX7Z4gKUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kkZnUCqS; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <20e0fb73-3476-4b1c-959e-c1af38f8e1a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758249922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEd4CRxp0Qy3iytKkYSUgyoNAPH5uPPdhfTDAiqFt+Q=;
	b=kkZnUCqSVKS2D7eOJzEGuV3v+zGK9iIe7bTiuC/CxNG5peUXCkMg8QwHhrIUCzAA3fPGtj
	H5dS3iVmdASVXo6qgjNsHY2nKaNPMk5MXf8dk4yu9aiRvB+36+Nq6NC4YvSuED6HU0WwFj
	/DE5F2zJxguD24b6ukaUVsKcEQQp55k=
Date: Fri, 19 Sep 2025 10:44:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, kirill@shutemov.name, hughd@google.com,
 mpenttil@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
 <6BAE5498-D0AB-40F5-85F8-B92A05CA72AD@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <6BAE5498-D0AB-40F5-85F8-B92A05CA72AD@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/19 03:12, Zi Yan wrote:
> On 18 Sep 2025, at 1:04, Lance Yang wrote:
> 
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
>> lightweight guard regions.
>>
>> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail when
>> encountering such a range.
>>
>> MADV_COLLAPSE fails deep inside the collapse logic when trying to swap-in
>> the special marker in __collapse_huge_page_swapin().
>>
>> hpage_collapse_scan_pmd()
>>   `- collapse_huge_page()
>>       `- __collapse_huge_page_swapin() -> fails!
>>
>> khugepaged's behavior is slightly different due to its max_ptes_swap limit
>> (default 64). It won't fail as deep, but it will still needlessly scan up
>> to 64 swap entries before bailing out.
>>
>> IMHO, we can and should detect this much earlier.
>>
>> This patch adds a check directly inside the PTE scan loop. If a guard
>> marker is found, the scan is aborted immediately with SCAN_PTE_NON_PRESENT,
>> avoiding wasted work.
>>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 9ed1af2b5c38..70ebfc7c1f3e 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>   					result = SCAN_PTE_UFFD_WP;
>>   					goto out_unmap;
>>   				}
>> +				/*
>> +				 * Guard PTE markers are installed by
>> +				 * MADV_GUARD_INSTALL. Any collapse path must
>> +				 * not touch them, so abort the scan immediately
>> +				 * if one is found.
>> +				 */
>> +				if (is_guard_pte_marker(pteval)) {
> 
> pteval is already is_swap_pte(), would is_guard_swp_entry() be a better
> choice here? Save one is_swap_pte() call.

Yeah. Good spot! Will do ;)

Thanks,
Lance

> 
>> +					result = SCAN_PTE_NON_PRESENT;
>> +					goto out_unmap;
>> +				}
>>   				continue;
>>   			} else {
>>   				result = SCAN_EXCEED_SWAP_PTE;
>> -- 
>> 2.49.0
> 
> 
> Best Regards,
> Yan, Zi



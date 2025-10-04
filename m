Return-Path: <linux-kernel+bounces-841924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF063BB88AF
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606B13C2C6D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601EA41C71;
	Sat,  4 Oct 2025 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QFiiD5fQ"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE61F9C0
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759547179; cv=none; b=QvIBM8OSIr/az4kcMhg4yBOFjyzTmuUHSQT3iTFyAdPS3GvcA7NcEqyvEzbgyCfAPNWGYw3IYhyFK6eIrDgFIA99sNwTRVPv8Rnrbh3uNKa9GdPuJ00upLCZMOEn8exyLKO6iUyMyJtQrG/cLZzuHZz8dFCSS8sYnOut92VpPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759547179; c=relaxed/simple;
	bh=HD6yOrpFaMTM4o+sS+vXSeulxyFFdSnPq8JKD25RFCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6NRJoMph0tOGDlvXwIMlKwzygh355KDMiYuW83NozUXzKKe0BXzdR8W/zfukXMhs3SvNmn2DpvRNTXY0UpkCIK1c8LH95wZ/XzHrO6k2hWCb0K4/rME/Bl74DtxwfVs0ptZ19Czwimsci/0JTa69lEldgGdo4Pq0KpDY3ttxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QFiiD5fQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2d2f634-c587-4639-8191-8d74357fe8fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759547176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXNNFB9m2tpLPVfzBH/OyS3UoK141cw9zK+ucGD3NqE=;
	b=QFiiD5fQfK8Dx7oW/mtMnx22p7DIXuSnRzi9FM6gwKqugyl7A35FGw56L/dJgRpG2TgTXT
	aGtDUze/msQHXXHOCfRz7nNPrM49gbEwx16cXMq+1VT1oWJUyDDPcR3g0uw3T3VHVA2Td9
	3osGwZBkPG/d+s1POuCdUAQvCZEcSyU=
Date: Sat, 4 Oct 2025 11:06:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into a
 new helper
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-3-lance.yang@linux.dev>
 <9DF437D8-E98B-4061-A8C7-521D89070C97@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <9DF437D8-E98B-4061-A8C7-521D89070C97@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/4 01:11, Zi Yan wrote:
> On 2 Oct 2025, at 3:32, Lance Yang wrote:
> 
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>> and __collapse_huge_page_isolate() was almost duplicated.
>>
>> This patch cleans things up by moving all the common PTE checking logic
>> into a new shared helper, thp_collapse_check_pte().
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 167 ++++++++++++++++++++++++++++++------------------
>>   1 file changed, 104 insertions(+), 63 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 808523f92c7b..2a897cfb1d03 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -61,6 +61,12 @@ enum scan_result {
>>   	SCAN_PAGE_FILLED,
>>   };
>>
>> +enum pte_check_result {
>> +	PTE_CHECK_SUCCEED,
>> +	PTE_CHECK_CONTINUE,
>> +	PTE_CHECK_FAIL,
>> +};
>> +
>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/huge_memory.h>
>>
>> @@ -533,6 +539,87 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>>   	}
>>   }
>>
>> +/*
>> + * thp_collapse_check_pte - Check if a PTE is suitable for THP collapse
>> + * @pte:           PTE to check
>> + * @vma:           VMA the PTE belongs to
>> + * @cc:            Collapse control settings
>> + * @scan_swap_pte: Allow scanning of swap PTEs if true
>> + * @none_or_zero:  Counter for none/zero PTEs (must be non-NULL)
>> + * @unmapped:      Counter for swap PTEs (must be non-NULL if scan_swap_pte
>> + *                 is true)
>> + * @scan_result:   Used to return the failure reason (SCAN_*) on a
>> + *                 PTE_CHECK_FAIL return. Must be non-NULL
>> + *
>> + * Returns:
>> + *   PTE_CHECK_SUCCEED  - Valid PTE, proceed with collapse
>> + *   PTE_CHECK_CONTINUE - Skip this none/zero PTE but continue scanning
>> + *   PTE_CHECK_FAIL     - Abort collapse scan
>> + */
>> +static inline int thp_collapse_check_pte(pte_t pte, struct vm_area_struct *vma,
>> +		struct collapse_control *cc, bool scan_swap_pte,
>> +		int *none_or_zero, int *unmapped, int *scan_result)
>> +{
>> +	VM_BUG_ON(!none_or_zero || !scan_result);
>> +	VM_BUG_ON(scan_swap_pte && !unmapped);
> 
> Please use VM_WARN_ONCE_ON and just return. Or put all stats in a struct,
> pass and check the struct pointer instead.

Yes, will use VM_WARN_ONCE_ON instead of VM_BUG_ON, and just return 
PTE_CHECK_FAIL.

Thanks,
Lance

> 
> 
> Best Regards,
> Yan, Zi



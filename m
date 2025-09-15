Return-Path: <linux-kernel+bounces-817211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C67EFB57F52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCFF1A27398
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177A432A3CC;
	Mon, 15 Sep 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m8NJI9pn"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150731C565
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947333; cv=none; b=UM9K4+ZjfFlbJio3aMNEekqjZ180K0eT6FBlDcJgukVZGvhd0PnfD6bQ6IQ0VFP4gwrJcaNXU2pJWusVX/uLyJRnIlbkzCbRyoT+8KSewi6cGw/0SQpSdefcBS7Zxl+x8dhAJ4jEQYgiFIARe3FBZ6dEs5ttNzR5ZUCMPN2VXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947333; c=relaxed/simple;
	bh=MsgQ+XEybDBFnv1Sn7YCQ6b2cPbqNlmkdHgNFFRWULQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juJ9HCSFWH3QMo0jBsBMzlGJThIjPOy1qiUKTmiFQtAmkg7nosjrTjyBDRWwjHGtmW/rUgllJBeKwZbPqNmlmBiMc9jjR5PyClJ4R/bKCOyHRuRFMfUQ8YtJ8grUOTmt4F3HBMY8pqIHTq6/BM+xjo0kER8H1dQNZFSvUA0WfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m8NJI9pn; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <121a0947-88cd-4515-bf14-a2af9b69eb0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757947329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otD0lF88c/W1mhXnZZlmqwcx36asc6J+ruH2BHy82vs=;
	b=m8NJI9pn7LA1CV/E/15NfiRNHl0491YASPDwDn4YMfZP3tGltyzJLFHg+HiEf4XsPtEI1s
	h0OVkE2EOubpGiDYXx9Ycwl2n+i0QGGB2Bw2l++MvS+vszzPFGSj1ni4Q7I1hioL12BmpY
	X88TdsxVe7494tG2OsZwjvuzm/deTls=
Date: Mon, 15 Sep 2025 22:42:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 3/3] mm/khugepaged: abort collapse scan on guard
 PTEs
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-4-lance.yang@linux.dev>
 <59519b0f-af14-4486-9aca-4e721842d45b@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <59519b0f-af14-4486-9aca-4e721842d45b@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/15 22:08, Lorenzo Stoakes wrote:
> On Sun, Sep 14, 2025 at 10:35:47PM +0800, Lance Yang wrote:
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
>> IMHO, we can and should detect this much earlier ;)
> 
> No smileys in commit messages please... :)

Got it. Apparently, I'm a bit too fond of them ... Will remove it in v2.

> 
>>
>> This patch adds a check directly inside the PTE scan loop. If a guard
>> marker is found, the scan is aborted immediately with a new SCAN_PTE_GUARD
>> status, avoiding wasted work.
>>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index e54f99bb0b57..910a6f2ec8a9 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -59,6 +59,7 @@ enum scan_result {
>>   	SCAN_STORE_FAILED,
>>   	SCAN_COPY_MC,
>>   	SCAN_PAGE_FILLED,
>> +	SCAN_PTE_GUARD,
> 
> I wonder if we really need to have it literally called out though, can we just
> use:
> 
> SCAN_PTE_NON_PRESENT
> 
> Instead?
> 
> As it is, indeed, non-present :)

Makes sense to me. A guard PTE is indeed a special non-present case.

So, let's reuse SCAN_PTE_NON_PRESENT for that case ;)

Cheers,
Lance

> 
>>   };
>>
>>   #define CREATE_TRACE_POINTS
>> @@ -1317,6 +1318,16 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
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
>> +					result = SCAN_PTE_GUARD;
>> +					goto out_unmap;
>> +				}
>>   				continue;
>>   			} else {
>>   				result = SCAN_EXCEED_SWAP_PTE;
>> @@ -2860,6 +2871,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>>   		case SCAN_PAGE_COMPOUND:
>>   		case SCAN_PAGE_LRU:
>>   		case SCAN_DEL_PAGE_LRU:
>> +		case SCAN_PTE_GUARD:
>>   			last_fail = result;
>>   			break;
>>   		default:
>> --
>> 2.49.0
>>
> 
> Cheers, Lorenzo



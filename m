Return-Path: <linux-kernel+bounces-816062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7625EB56EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 028E94E0222
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942762641FB;
	Mon, 15 Sep 2025 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tBNKvV6S"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E226AA94
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757907402; cv=none; b=H/qGdhkr+PmBEv+soUPiwzG/xNQfyppNe2ZRCvbQofZbx0iHYlfEtGSwxTQYCkVlvm343AYvyZCU37Z4/5fPcX3Kxq527XyS0tlZW8pnBcBHfdA6tN4PNL13lLpSPFmQZjeAr5PqlbdAMsItGAT+6cvVrcCRZF3VRwVpGGkeUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757907402; c=relaxed/simple;
	bh=YcOkd7y+I07yftr3b/zuLZrawi1IpCDJgMnekwxa64s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbccnhI5TEocf2XPus8j6LWq36wsvbs4WcJ5zs2MZOIGbjtAeTAP9ULxErf121ZLgGIY7FHzOtmGOaXyX22P6IR0drYXf3SJofDgGyZZAcQGwlUVdhkIq7vw5Jya0s+zNjKmRGkVzKQKtexO6Vzi5VzeSuCTA3Bc9rfycUi0oNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tBNKvV6S; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9d4d761-202f-48ce-8e3d-fb9075671ff3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757907397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOq3tAKiSS4SZqaYiFMa6a3N6kv3gCmuXSnB/b8DG10=;
	b=tBNKvV6SZaIls4AXk4gIFyG3o230C77+N2DZwtS9pXCUvz6lsvQeQHICJB9R5dxFrK8gM8
	uXnIAkjTZJ0S+mF6qaMqKrZBiG9lw68joa3qKdLmq/yfOJvP/kdOIrP3s/CJ/A6NjZS93q
	tpUnkLgdwseB7YLAZGp+rMcdf4pG3/w=
Date: Mon, 15 Sep 2025 11:36:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 3/3] mm/khugepaged: abort collapse scan on guard
 PTEs
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, ryan.roberts@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-4-lance.yang@linux.dev>
 <750a06dc-db3d-43c6-b234-95efb393a9df@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <750a06dc-db3d-43c6-b234-95efb393a9df@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/15 01:03, Dev Jain wrote:
> 
> On 14/09/25 8:05 pm, Lance Yang wrote:
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
>>   `- collapse_huge_page()
>>       `- __collapse_huge_page_swapin() -> fails!
>>
>> khugepaged's behavior is slightly different due to its max_ptes_swap 
>> limit
>> (default 64). It won't fail as deep, but it will still needlessly scan up
>> to 64 swap entries before bailing out.
>>
>> IMHO, we can and should detect this much earlier ;)
>>
>> This patch adds a check directly inside the PTE scan loop. If a guard
>> marker is found, the scan is aborted immediately with a new 
>> SCAN_PTE_GUARD
>> status, avoiding wasted work.
>>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index e54f99bb0b57..910a6f2ec8a9 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -59,6 +59,7 @@ enum scan_result {
>>       SCAN_STORE_FAILED,
>>       SCAN_COPY_MC,
>>       SCAN_PAGE_FILLED,
>> +    SCAN_PTE_GUARD,
>>   };
>>   #define CREATE_TRACE_POINTS
>> @@ -1317,6 +1318,16 @@ static int hpage_collapse_scan_pmd(struct 
>> mm_struct *mm,
>>                       result = SCAN_PTE_UFFD_WP;
>>                       goto out_unmap;
>>                   }
>> +                /*
>> +                 * Guard PTE markers are installed by
>> +                 * MADV_GUARD_INSTALL. Any collapse path must
>> +                 * not touch them, so abort the scan immediately
>> +                 * if one is found.
>> +                 */
>> +                if (is_guard_pte_marker(pteval)) {
>> +                    result = SCAN_PTE_GUARD;
>> +                    goto out_unmap;
>> +                }
>>                   continue;
> 
> This looks good, but see below.
> 
>>               } else {
>>                   result = SCAN_EXCEED_SWAP_PTE;
>> @@ -2860,6 +2871,7 @@ int madvise_collapse(struct vm_area_struct *vma, 
>> unsigned long start,
>>           case SCAN_PAGE_COMPOUND:
>>           case SCAN_PAGE_LRU:
>>           case SCAN_DEL_PAGE_LRU:
>> +        case SCAN_PTE_GUARD:
>>               last_fail = result;
> 
> Should we not do this, and just send this case over to the default case. 
> That
> would mean immediate exit with -EINVAL, instead of iterating over the 
> complete
> range, potentially collapsing a non-guard range, and returning -EINVAL. 

That makes sense to me ;)

> I do not
> think we should spend a significant time in the kernel when the user is 
> literally
> invoking madvise(MADV_GUARD_INSTALL) and madvise(MADV_COLLAPSE) on 
> overlapping regions.

I'm just a bit unsure because the MADV_COLLAPSE man page[1] describes it
as a "best-effort" collapse. This patch follows that idea, collapsing what
it can.

        MADV_COLLAPSE (since Linux 6.1)
               Perform a best-effort synchronous collapse of the native
               pages mapped by the memory range into Transparent Huge
               Pages (THPs).  MADV_COLLAPSE operates on the current state
               of memory of the calling process and makes no persistent
               changes or guarantees on how pages will be mapped,
               constructed, or faulted in the future.

A hard-fail on a guard PTE marker might go against that.

Well, I'm open to either approach. What do other folks think?

[1] https://man7.org/linux/man-pages/man2/madvise.2.html

Cheers,
Lance

> 
>>               break;
>>           default:




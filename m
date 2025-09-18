Return-Path: <linux-kernel+bounces-822301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A82B837BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84931C82B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DAA2F2612;
	Thu, 18 Sep 2025 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M5YnV4AA"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72412EFD88
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183097; cv=none; b=rEVKKzUUglSdhQ5yMTu6YILr2BO6tYm1vv0yFMPR5WgvBOXrkWi0PgwqcmsYGogTXr9gaKGwYqwL0+eY4H4KEj0B6Wjxd6gmMzqHXUp40NyU6HLn4yCeOFzk7S4MBYbiQXzIhAr/pw+FU2Eaf5EkhmW6JxDxcKTbYPN3qYLj2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183097; c=relaxed/simple;
	bh=SdhwhcNlJ1nV8CH4uyU08FVWAsLK/OB1V48VnTIvZLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLkepIIum6k3ndvtalQZ5o3OM3zjBM0ZrcHnHRS8Ihx+V1DrInauPHtYju5kVZMaiYX7WCAu5hRuV7JDiU4RFZszy3FwyWWSoi2rXwPchqzB6ZGygjm0faywGF1/X0ns40Q8LtA7ylxUaQVjo+ri5jLuEqH2++UfrLxbHcfx5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M5YnV4AA; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <db182c88-04d6-408a-b36e-a708dc7eb3de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758183093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hchChWtwLQOxGyljAivB4hYgL0w8MxSX4qQYtSpmXc=;
	b=M5YnV4AAlwAIyMsfjkSwpmcD1EeIFgGdofp5XRQmaOtLY8h87Q8IE+iWJg5O4r7HWnqzNP
	R4Di5InjHFUxI1aeV20Iox2vG1nLWpu66cztX6dN0du3p7c/mD/infBxiQAnTnAlkPMZrd
	DNc9R+TQ1TST6OUdp3N7fP6+9nVWynI=
Date: Thu, 18 Sep 2025 16:11:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, kirill@shutemov.name, hughd@google.com,
 mpenttil@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
 <f6073afe-a604-485a-8cea-7aa08e46a0cf@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f6073afe-a604-485a-8cea-7aa08e46a0cf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/18 15:37, Dev Jain wrote:
> 
> On 18/09/25 10:34 am, Lance Yang wrote:
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
>> IMHO, we can and should detect this much earlier.
>>
>> This patch adds a check directly inside the PTE scan loop. If a guard
>> marker is found, the scan is aborted immediately with 
>> SCAN_PTE_NON_PRESENT,
>> avoiding wasted work.
>>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 9ed1af2b5c38..70ebfc7c1f3e 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct 
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
>> +                    result = SCAN_PTE_NON_PRESENT;
>> +                    goto out_unmap;
>> +                }
>>                   continue;
>>               } else {
>>                   result = SCAN_EXCEED_SWAP_PTE;
>>
>>
> 
> I would like to hear everyone else's thoughts on
> https://lore.kernel.org/linux-mm/750a06dc-db3d-43c6- 
> b234-95efb393a9df@arm.com/
> wherein I suggest that we should not continue to try collapsing other 
> regions
> but immediately exit. The SCAN_PTE_NON_PRESENT case does not exit.

Yes! Let's hear what other folks think on that[1].

[1] 
https://lore.kernel.org/linux-mm/c9d4d761-202f-48ce-8e3d-fb9075671ff3@linux.dev

Cheers,
Lance






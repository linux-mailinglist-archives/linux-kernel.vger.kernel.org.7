Return-Path: <linux-kernel+bounces-822607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AB3B844CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA8A16AC46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51C302770;
	Thu, 18 Sep 2025 11:10:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72EE2E0406
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193841; cv=none; b=ZM86vbSpRmCUrvmNbEsP+09Wjlfaw9Pd+MSk7NhLLKcKcYuU+n249TXoolImo7OGrqvpsBageJNrOSQ2MWMRzSXHpbofZaM0ouPjy+wSBrL2oGIlejmHvO9iLsnf7+a5KvYUKY1WdyOjKYBtqaceiBWhpCvo55QIzXjQyM0lyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193841; c=relaxed/simple;
	bh=LakOfQDdOkA9LVxw6GcGH6eFP+BaWE0gCCQ2ZY+TsQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFAf+60k63Pwc2I4vN7t9q8XIXjwgFB8Otb36Scy1OU4LW7F9zd703tUEDdxRI5ivgvgYGTXqsJjJM61nTXGfOW9A2v8gSbHqdoWpcJDZggbMo/Ooa7SYOQgZ60zMtc1GYcL4UbryM8sBk+Rjh4iQLW1YVV5yocrN576roouWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D57A21762;
	Thu, 18 Sep 2025 04:10:29 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7873B3F66E;
	Thu, 18 Sep 2025 04:10:33 -0700 (PDT)
Message-ID: <482fb9e1-7def-48c4-b6b2-e3a5ea2ac36e@arm.com>
Date: Thu, 18 Sep 2025 16:40:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 kirill@shutemov.name, hughd@google.com, mpenttil@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
 <f6073afe-a604-485a-8cea-7aa08e46a0cf@arm.com>
 <db182c88-04d6-408a-b36e-a708dc7eb3de@linux.dev>
 <7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18/09/25 3:36 pm, Lorenzo Stoakes wrote:
> On Thu, Sep 18, 2025 at 04:11:21PM +0800, Lance Yang wrote:
>>
>> On 2025/9/18 15:37, Dev Jain wrote:
>>> On 18/09/25 10:34 am, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
>>>> lightweight guard regions.
>>>>
>>>> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail when
>>>> encountering such a range.
>>>>
>>>> MADV_COLLAPSE fails deep inside the collapse logic when trying to swap-in
>>>> the special marker in __collapse_huge_page_swapin().
>>>>
>>>> hpage_collapse_scan_pmd()
>>>>    `- collapse_huge_page()
>>>>        `- __collapse_huge_page_swapin() -> fails!
>>>>
>>>> khugepaged's behavior is slightly different due to its max_ptes_swap
>>>> limit
>>>> (default 64). It won't fail as deep, but it will still needlessly scan up
>>>> to 64 swap entries before bailing out.
>>>>
>>>> IMHO, we can and should detect this much earlier.
>>>>
>>>> This patch adds a check directly inside the PTE scan loop. If a guard
>>>> marker is found, the scan is aborted immediately with
>>>> SCAN_PTE_NON_PRESENT,
>>>> avoiding wasted work.
>>>>
>>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>> ---
>>>>    mm/khugepaged.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 9ed1af2b5c38..70ebfc7c1f3e 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct
>>>> mm_struct *mm,
>>>>                        result = SCAN_PTE_UFFD_WP;
>>>>                        goto out_unmap;
>>>>                    }
>>>> +                /*
>>>> +                 * Guard PTE markers are installed by
>>>> +                 * MADV_GUARD_INSTALL. Any collapse path must
>>>> +                 * not touch them, so abort the scan immediately
>>>> +                 * if one is found.
>>>> +                 */
>>>> +                if (is_guard_pte_marker(pteval)) {
>>>> +                    result = SCAN_PTE_NON_PRESENT;
>>>> +                    goto out_unmap;
>>>> +                }
>>>>                    continue;
>>>>                } else {
>>>>                    result = SCAN_EXCEED_SWAP_PTE;
>>>>
>>>>
>>> I would like to hear everyone else's thoughts on
>>> https://lore.kernel.org/linux-mm/750a06dc-db3d-43c6-
>>> b234-95efb393a9df@arm.com/
>>> wherein I suggest that we should not continue to try collapsing other
>>> regions
>>> but immediately exit. The SCAN_PTE_NON_PRESENT case does not exit.
>> Yes! Let's hear what other folks think on that[1].
>>
>> [1] https://lore.kernel.org/linux-mm/c9d4d761-202f-48ce-8e3d-fb9075671ff3@linux.dev
> Since the code has changed let's discuss on this thread.
>
> Dev - You can have guard regions in a range that prevent one PMD from being
> collapsed, I'm struggling to understand why you'd want to abort the whole
> thing?
>
> Your reasoning there isn't clear at all, so if I had a guard region in one
> page in a giant range I was trying to collapse, you're saying we should
> just abort the whole thing?

My reasoning was that it doesn't seem correct that the user will operate in
any capacity on a guard region when it knows it is a guard region.

But, as you say, we then won't be able to collapse a large region in one go
and will have to do multiple madvise() calls to prevent overlapping with a
guard region. So I agree with you.

>
> I really don't understand why we would do that? You just skip over what you
> can't collapse right?
>
> There's no reason at all to assume that overlapping regions here matter, we
> can't predict how users will use this.

True.

>
> As Lance says, it's best effort. And also note we already do this with UFFD
> WP. And note this is also a non-present, PTE marker.
>
> And also this would change existing behaviour which treats this as a swap
> entry then just fails later down the line right?
>
> So yeah I don't agree, I think it's fine as is, unless I'm missing
> something here.

Thanks for your explanation!

>
> Cheers, Lorenzo


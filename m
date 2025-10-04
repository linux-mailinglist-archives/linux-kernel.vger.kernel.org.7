Return-Path: <linux-kernel+bounces-841953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A2BB89BC
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 07:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250D619C109E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 05:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48493155CB3;
	Sat,  4 Oct 2025 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tznUARli"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F091FC3
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759555484; cv=none; b=Sf8m799o4oLi+Yq3P4DuaSCs1MLQH5obdiGQQEBM0Cs/Sz+27BXhFchQkor7rjbXASgHOT2OqF1a0mM6z2Twqvc0Greq5fvFTr4XjUcWreUArxHaUwkSvZ7AsTf2TYjn2+XAxAiIUfynHwvIP1PZ2HzXGttb7HmGBtiYVLrMHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759555484; c=relaxed/simple;
	bh=OQlB3W5wdZPcpi4H/c12R1xL+Zk8Kdkzwzmj24tQ8uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8KDivbGt9oO1sT5y/JKLhsk/9z33R4UZBMI6HsKGk8MioPlESQUBFoFQ4ORFogmG158KtMk+12iqaTiRMqcbskSRjYY4i3C/EtoIfolx5MX6r335K7Aw2/u6y9SaDqF+s4BbK/VNw1q+a1QV8VEO0Jp5AfTGu9HrABU1FA/yHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tznUARli; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44d529b6-a538-4131-a00c-76c73ae49d81@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759555479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krAO9cVScKxnq0tyI21OqQImIBgM9hOhnJCkOerMbok=;
	b=tznUARlix33V/Dh3vG3SYEpL/6iSYMloakXilkcJK1RXFcZIt7XmtZmPg7g5vaZJ5JIGmq
	WVK0w2XjqPTyPZXmj0Z21rALpyCwCONyy3Iw38WXM59xn6dr7/qJNZ+v6ms0nXq6PFTKhY
	KrMKMWysn1CU2uBhQVS0ZP87yDHGPeg=
Date: Sat, 4 Oct 2025 13:24:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into a
 new helper
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, david@redhat.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, akpm@linux-foundation.org
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-3-lance.yang@linux.dev>
 <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
 <a36c9776-d158-4add-86d0-c41a09e4a255@linux.dev>
 <f9f62e40-92a6-4ee8-aba0-6bb9b2929f41@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f9f62e40-92a6-4ee8-aba0-6bb9b2929f41@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/4 12:42, Dev Jain wrote:
> 
> On 04/10/25 8:33 am, Lance Yang wrote:
>>
>>
>> On 2025/10/4 01:05, Dev Jain wrote:
>>>
>>> On 02/10/25 1:02 pm, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>>>> and __collapse_huge_page_isolate() was almost duplicated.
>>>>
>>>> This patch cleans things up by moving all the common PTE checking logic
>>>> into a new shared helper, thp_collapse_check_pte().
>>>>
>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>> ---
>>>
>>> In hpage_collapse_scan_pmd(), we enter with mmap lock held, so for
>>> an anonymous vma, is it even possible to hit if (! 
>>> folio_test_anon(folio))?
>>
>> Ah, indeed :)
>>
>>> In which case we can replace this with VM_BUG_ON_FOLIO and abstract away
>>> till the folio_maybe_mapped_shared() block?
>>
>> So you meant something like this:
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 2a897cfb1d03..ef87d7fe3d50 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1374,11 +1374,7 @@ static int hpage_collapse_scan_pmd(struct 
>> mm_struct *mm,
>>                         goto out_unmap;
>>                 }
>>                 folio = page_folio(page);
>> -
>> -               if (!folio_test_anon(folio)) {
>> -                       result = SCAN_PAGE_ANON;
>> -                       goto out_unmap;
>> -               }
>> +               VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
> 
> Yes, I would suggest a different patch making this change, then in the
> 
> last patch you can abstract away till the shared statistics line since that
> 
> much code will become common between scan_pmd and _isolate.

Nice. Makes sense to me!

I'll rework the series into three patches then:

1) The if-else-if-else-if optimization
2) Convert the !folio_test_anon() check to a VM_BUG_ON_FOLIO()
3) The final merge of the scanning logic into a new helper

Thanks,
Lance

> 
> 
>>
>>                 /*
>>                  * We treat a single page as shared if any part of the 
>> THP
>>
>>



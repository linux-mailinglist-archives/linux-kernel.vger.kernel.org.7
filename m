Return-Path: <linux-kernel+bounces-805285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB139B48670
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734CD7A2D02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC1B2E92D2;
	Mon,  8 Sep 2025 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PMZ3gWn5"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F229A309
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319222; cv=none; b=LUeL22YibFNLhXbCCncfaXRzq2F3V00XtHOLKrhTfsQheETh9NelkmQwG4FSelTAB27PFRZFi/rtYRvqdXMFCoHGwOdGnOAV0wGqDp6AHYQbVziRbMiKMGGs64CyjE0Fg5kZ1tmRoVuFRGGfG3OzfmMFQE4vXyB/RCtpUNDdULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319222; c=relaxed/simple;
	bh=xNCph5gCMPZUC6IM3MiLEhO6Tc/nSgFQKzDXZDROOng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fey+DzXVlFfTPT1e7XCUC/Q0kF71qoQd3fvI+2fUSQSJx3MmVOy6zw6/0VkA8l6Uk1Wn2F4mguZlHVoMT6jKHguachWEhSx0g2mejrTwRujtYc+sUBYnzWYPIOohjyoDv7cwmAnXzRKLkX8Y+feWEAFtNCOzsoYtjyUIyUxX620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PMZ3gWn5; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bc1182e7-3f70-4645-b8c4-a97898e57041@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757319218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w104asye4dQPBM14xEIAY+w47JIy6lcQtIGWUqDYksg=;
	b=PMZ3gWn5RLox4cEF7MNlYLQlI+O8S+N7tB5ZArAXTLyA9mD6jXXEnLu72tLpOyswDB+6CK
	w7WV09Rk7nLSg+AbYPq9jAVYIMUz40W1PoqbwmR6SV/FU06dVoEHcXh+jObj0oDylC4Zra
	P0Wssmz6tZvL/bgGwXQUpugaIqAIC2Q=
Date: Mon, 8 Sep 2025 16:13:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm: avoid processing mlocked THPs in deferred split
 shrinker
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 usamaarif642@gmail.com, ziy@nvidia.com, akpm@linux-foundation.org
References: <20250908040713.42960-1-lance.yang@linux.dev>
 <5a1429ad-3900-404a-bdca-f25623ce603a@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <5a1429ad-3900-404a-bdca-f25623ce603a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/8 15:38, David Hildenbrand wrote:
> On 08.09.25 06:07, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
> 
> Subject should likely be more specific:
> 
> mm: skip mlocked THPs that are underused early in deferred_split_scan()

Right, that's a much better and more precise subject. Thanks!

> 
>>
>> When a new THP is faulted in or collapsed, it is unconditionally added to
>> the deferred split queue. If this THP is subsequently mlocked, it remains
>> on the queue but is removed from the LRU and marked unevictable.
>>
>> During memory reclaim, deferred_split_scan() will still pick up this 
>> large
>> folio. Because it's not partially mapped, it will proceed to call
>> thp_underused() and then attempt to split_folio() to free all zero-filled
>> subpages.
>>
>> This is a pointless waste of CPU cycles. The folio is mlocked and
>> unevictable, so any attempt to reclaim memory from it via splitting is
>> doomed to fail.
> 
> I think the whole description is a bit misleading: we're not reclaiming
> memory from fully-mapped THPs even when they are underused, because it
> could violate mlock() semantics where we don't want a page fault+memory 
> allocation on next access.
> 
> So something like the following might be clearer.
> 
> "When we stumble over a fully-mapped THP in the deferred shrinker, it 
> does not make sense trying to detect whether it is underused, because 
> try_to_map_unused_to_zeropage(), called while splitting the folio, will 
> not actually replace any zero-ed pages by the shared zeropage.
> 
> Splitting the folio in that case does not make any sense, so let's not 
> even scan if the folio is underused.
> "

Nice, that makes it much clearer. My understanding was indeed imprecise.

> 
> 
> 
> If I run my reproducer from [1] and mlock() the pages just after 
> allocating them, then I essentially get
> 
> AnonHugePages:   1048576 kB
> 
> converted to
> 
> Anonymous:       1048580 kB
> 
> Which makes sense (no memory optimized out) as discussed above.

Yes, my reproducer also shows exactly that. It's clear a lot of work is
done but no memory is actually optimized out ;)

> 
> 
> [1] https://lkml.kernel.org/r/20250905141137.3529867-1-david@redhat.com
> 
>>
>> So, let's add an early folio_test_mlocked() check to skip this case.
>>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/huge_memory.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 77f0c3417973..d2e84015d6b4 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -4183,6 +4183,9 @@ static unsigned long deferred_split_scan(struct 
>> shrinker *shrink,
>>           bool underused = false;
>>           if (!folio_test_partially_mapped(folio)) {
>> +            /* An mlocked folio is not a candidate for the shrinker. */
> 
> /*
>   * See try_to_map_unused_to_zeropage(): we cannot optimize zero-filled
>   * pages after splitting an mlocked folio.
>   */

Got it. I'll update the changelog and this comment as suggested.

> 
>> +            if (folio_test_mlocked(folio))
>> +                goto next;
>>               underused = thp_underused(folio);
>>               if (!underused)
>>                   goto next;
> 
>

Cheers,
Lance


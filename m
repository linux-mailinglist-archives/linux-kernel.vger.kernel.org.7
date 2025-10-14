Return-Path: <linux-kernel+bounces-852562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD38BD9545
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6105F54141A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553BB313E27;
	Tue, 14 Oct 2025 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A8XfJO2I"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E576313549
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444738; cv=none; b=cSaZv9JKTi5qXJWqE9KvpZ6IEhLuQKpVneb6Wd4pPybAJwNuHduX/LAF1G5h4j4OtJUJU501pgoF9a/lftdRmmxQlsXGq58to2/hri3KBrYYXzs1x6zUefCjflcPcC1++41CJgC+N+A8QqfOozfmyOgkDpeNGGUdjB+ThnuZFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444738; c=relaxed/simple;
	bh=XFOLr/cnekypotduLRqnkNRiLqmpK6WX/6E02roh9sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IceKiJkTnPw/mxQ6X9Yw6GgLbb9vmEiSpAidJFG8zRd2fkCGxn33zQl+97ydG/urGIcamyr3qXO948++AS4SUNNITCufP+/I9BO3spJZZlnQzcE4fscd4LvYfBWlNeO6PHP5F68qDizJrdybXD6Se71Q85YxXBx0mUnNojZZw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A8XfJO2I; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d1cf240b-6e2f-453a-9119-23cfe5480f84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760444722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEyKC0rXBxwWC68IHciD57Sf1EbPHHc3LfBBqhTpsxE=;
	b=A8XfJO2IaHs0uBIzI1sOG5BrgAcC/xVeyCtYb1cJSlO53QVE5Hu99nfMcQOO9jsHYLFeKP
	HAWri20mPdxvd80KXySc9d8mZZLTAUWFiNulkUNM+i0MC2J0mLe8yF2/y2UGGvLLIlwbo6
	FzInSHzUp00rt1na9sF4jeqlMoaiz7c=
Date: Tue, 14 Oct 2025 20:25:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when
 remapping zero-filled mTHP subpage to shared zeropage
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, peterx@redhat.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
 ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, usamaarif642@gmail.com,
 yuzhao@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com, stable@vger.kernel.org
References: <20250930081040.80926-1-lance.yang@linux.dev>
 <91c443e1-3d7d-4b95-ab62-b970b047936f@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <91c443e1-3d7d-4b95-ab62-b970b047936f@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Thanks for the super energetic review!

On 2025/10/14 19:19, Lorenzo Stoakes wrote:
> Feels like the mTHP implementation is hitting up on the buffers of the THP code
> being something of a mess... :)

Haha, yeah, it really feels that way sometimes ;)

> 
> On Tue, Sep 30, 2025 at 04:10:40PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When splitting an mTHP and replacing a zero-filled subpage with the shared
>> zeropage, try_to_map_unused_to_zeropage() currently drops several important
>> PTE bits.
>>
>> For userspace tools like CRIU, which rely on the soft-dirty mechanism for
> 
> It's slightly by-the-by, but CRIU in my view - as it relies on kernel
> implementation details that can always change to operate - is not actually
> something we have to strictly keep working.
> 
> HOWEVER, if we can reasonably do so without causing issues for us in the kernel
> we ought to do so.
> 
>> incremental snapshots, losing the soft-dirty bit means modified pages are
>> missed, leading to inconsistent memory state after restore.
>>
>> As pointed out by David, the more critical uffd-wp bit is also dropped.
>> This breaks the userfaultfd write-protection mechanism, causing writes
>> to be silently missed by monitoring applications, which can lead to data
>> corruption.
> 
> Again, uffd-wp is a total mess. We shouldn't be in a position where its state
> being correctly retained relies on everybody always getting the subtle,
> uncommented, open-coded details right everywhere all the time.
> 
> But this is again a general comment... :)

:)

> 
>>
>> Preserve both the soft-dirty and uffd-wp bits from the old PTE when
>> creating the new zeropage mapping to ensure they are correctly tracked.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Dev Jain <dev.jain@arm.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> 
> Overall LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Cheers!

> 
>> ---
>> v4 -> v5:
>>   - Move ptep_get() call after the !pvmw.pte check, which handles PMD-mapped
>>     THP migration entries.
>>   - https://lore.kernel.org/linux-mm/20250930071053.36158-1-lance.yang@linux.dev/
>>
>> v3 -> v4:
>>   - Minor formatting tweak in try_to_map_unused_to_zeropage() function
>>     signature (per David and Dev)
>>   - Collect Reviewed-by from Dev - thanks!
>>   - https://lore.kernel.org/linux-mm/20250930060557.85133-1-lance.yang@linux.dev/
>>
>> v2 -> v3:
>>   - ptep_get() gets called only once per iteration (per Dev)
>>   - https://lore.kernel.org/linux-mm/20250930043351.34927-1-lance.yang@linux.dev/
>>
>> v1 -> v2:
>>   - Avoid calling ptep_get() multiple times (per Dev)
>>   - Double-check the uffd-wp bit (per David)
>>   - Collect Acked-by from David - thanks!
>>   - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@linux.dev/
>>
>>   mm/migrate.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index ce83c2c3c287..e3065c9edb55 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -296,8 +296,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
>>   }
>>
>>   static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>> -					  struct folio *folio,
>> -					  unsigned long idx)
>> +		struct folio *folio, pte_t old_pte, unsigned long idx)
>>   {
>>   	struct page *page = folio_page(folio, idx);
>>   	pte_t newpte;
>> @@ -306,7 +305,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>>   		return false;
>>   	VM_BUG_ON_PAGE(!PageAnon(page), page);
>>   	VM_BUG_ON_PAGE(!PageLocked(page), page);
>> -	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
>> +	VM_BUG_ON_PAGE(pte_present(old_pte), page);
> 
> Kinda ugly that we pass old_pte when it's avaiable via the shared state object,
> but probably nothing to really concern ourselves about.
> 
> Guess you could argue it both ways :)
> 
> It'd be good to convert these VM_BUG_ON_*() to VM_WARN_ON_*() but I guess that's

I agree.

> somewhat out of the scope of the code here and would be inconsistent to change
> it for just one condition.

Since this fix already landed in the mainline, just leave it as is here :)

Thanks,
Lance


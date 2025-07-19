Return-Path: <linux-kernel+bounces-737567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F8FB0ADF0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 06:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E431C209D8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 04:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024BE193079;
	Sat, 19 Jul 2025 04:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H28apTkJ"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F4D846C
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 04:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752899576; cv=none; b=tZ+jPrZ5c35CSzFDfCjWJUTSwaQ6BuOWU/q8oduVCyo1SHmhZlUmxYxO9y8I8azOa1FnFfzJyEjUeGORGKmtjp94vN36YUa1NEuW+cicPeYrT8H2qd05cxt7soCkTCBwrjp7tRUwbKKBIZW8jEwogWohwXknKf4luMNtfshRorY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752899576; c=relaxed/simple;
	bh=ylEPsHIhUXxSM0DSMgdyH3PSOKHg5OYOWjVFRsDxBHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rj5uGZLsUjxLhbK3QowEN8xofZZw7WArXpZ8InX0ByYwWTIWjvO9kAxVJqa8Bf3vGsV9bwAX6yjhFp6En1HTZjYQd8/1/nJVg7vLR1x2KeQDavr63h9pNW4fkSoAADe/ObQqP4UTEJd1NOSitUE5EYVOTCKGNBGf5c4RRIpCamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H28apTkJ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752899564; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WIfcKFqW1HEmdhY1I90ltqa+jRIcL78choQIblUJOfc=;
	b=H28apTkJzIABQxwwzj+mm3MtuzjZmAaLtFiwyGyC0HGSq2jmW3gevfpyJBz8Zq7dd7R0iS/XbcTTsXmsfyYuxx6kR0EveftyTBsCfPqY6TAJrtaxZn2Ijsy8VXHaCvo/KB2Mpz7T8ucj1xbV/74i/nmJZWoS/kzxNhUgm6zpz1o=
Received: from 30.134.69.216(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjDqIoK_1752899562 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 19 Jul 2025 12:32:43 +0800
Message-ID: <f8bb53a3-c328-4dde-a19b-520d3fbd0fd0@linux.alibaba.com>
Date: Sat, 19 Jul 2025 12:32:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 2/2] mm/shmem: writeout free swap if
 swap_writeout() reactivates
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>,
 David Rientjes <rientjes@google.com>, Kairui Song <ryncsn@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
 <5c911f7a-af7a-5029-1dd4-2e00b66d565c@google.com>
 <853a5211-cdab-4bdf-b0c4-8092dd943ff5@linux.alibaba.com>
 <a6f83e63-c5af-cd27-5379-0e8fcb347e18@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <a6f83e63-c5af-cd27-5379-0e8fcb347e18@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/19 08:51, Hugh Dickins wrote:
> On Thu, 17 Jul 2025, Baolin Wang wrote:
> 
>> Hi Hugh,
>>
>> On 2025/7/16 16:08, Hugh Dickins wrote:
>>> If swap_writeout() returns AOP_WRITEPAGE_ACTIVATE (for example, because
>>> zswap cannot compress and memcg disables writeback), there is no virtue
>>> in keeping that folio in swap cache and holding the swap allocation:
>>> shmem_writeout() switch it back to shmem page cache before returning.
>>>
>>> Folio lock is held, and folio->memcg_data remains set throughout, so
>>> there is no need to get into any memcg or memsw charge complications:
>>> swap_free_nr() and delete_from_swap_cache() do as much as is needed (but
>>> beware the race with shmem_free_swap() when inode truncated or evicted).
>>>
>>> Doing the same for an anonymous folio is harder, since it will usually
>>> have been unmapped, with references to the swap left in the page tables.
>>> Adding a function to remap the folio would be fun, but not worthwhile
>>> unless it has other uses, or an urgent bug with anon is demonstrated.
>>>
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> ---
>>>    mm/shmem.c | 33 ++++++++++++++++++++++++++++++++-
>>>    1 file changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 33675361031b..5a7ce4c8bad6 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -1655,6 +1655,7 @@ int shmem_writeout(struct folio *folio, struct
>>> swap_iocb **plug,
>>>    
>>>     if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC |
>>>     __GFP_NOWARN)) {
>>>    		bool first_swapped = shmem_recalc_inode(inode, 0, nr_pages);
>>> +		int error;
>>>    
>>>      /*
>>>    		 * Add inode to shmem_unuse()'s list of swapped-out inodes,
>>> @@ -1675,7 +1676,37 @@ int shmem_writeout(struct folio *folio, struct
>>> swap_iocb **plug,
>>>      shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
>>>    
>>>    		BUG_ON(folio_mapped(folio));
>>> -		return swap_writeout(folio, plug);
>>> +		error = swap_writeout(folio, plug);
>>> +		if (error != AOP_WRITEPAGE_ACTIVATE) {
>>> +			/* folio has been unlocked */
>>> +			return error;
>>> +		}
>>> +
>>> +		/*
>>> +		 * The intention here is to avoid holding on to the swap when
>>> +		 * zswap was unable to compress and unable to writeback; but
>>> +		 * it will be appropriate if other reactivate cases are added.
>>> +		 */
>>> +		error = shmem_add_to_page_cache(folio, mapping, index,
>>> +				swp_to_radix_entry(folio->swap),
>>> +				__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
>>> +		/* Swap entry might be erased by racing shmem_free_swap() */
>>> +		if (!error) {
>>> +			spin_lock(&info->lock);
>>> +			info->swapped -= nr_pages;
>>> +			spin_unlock(&info->lock);
>>
>> Using the helper 'shmem_recalc_inode(inode, 0, -nr_pages)' seems more
>> readable?
> 
> Yes, that's better, thanks: I don't know if I'd say "more readable",
> but it is much more in the spirit of shmem_recalc_inode(), bringing
> the counts into balance sooner rather than later.
> 
> I'll follow up with a "fix" patch to Andrew.
> 
>>
>>> +			swap_free_nr(folio->swap, nr_pages);
>>> +		}
>>> +
>>> +		/*
>>> +		 * The delete_from_swap_cache() below could be left for
>>> +		 * shrink_folio_list()'s folio_free_swap() to dispose of;
>>> +		 * but I'm a little nervous about letting this folio out of
>>> +		 * shmem_writeout() in a hybrid half-tmpfs-half-swap state
>>> +		 * e.g. folio_mapping(folio) might give an unexpected answer.
>>> +		 */
>>> +		delete_from_swap_cache(folio);
>>
>> IIUC, Should the delete_from_swap_cache() also be moved into the 'if (!error)'
>> branch? Since if shmem_free_swap() has freed the swap entry, it would also
>> reclaim the swap cache, no?
> 
> No, but it was a good point to raise, and led into more research than
> I had anticipated.
> 
> No: because shmem_free_swap->free_swap_and_cache_nr->__try_to_reclaim_swap
> has to return after doing nothing if its folio_trylock fails: it cannot do
> the delete_from_swap_cache() part of the job, which we do here - on this
> AOP_WRITEPAGE_ACTIVATE path, we hold the folio_lock throughout.

I missed the 'folio_trylock', yes, you are right. Thanks for explanation.

> But it led into more research, because I wanted to point you to the
> equivalent coding in shmem_swapin_folio(): but, to my initial alarm,
> the equivalent is not there; but used to be.
> 
> See 5.8 commit 14235ab36019 ("mm: shmem: remove rare optimization when
> swapin races with hole punching").  There (in the deleted lines) you can
> see the helpful comment on this case, with its delete_from_swap_cache()
> when shmem_add_to_page_cache() fails.  But for memcg-charging reasons,
> 5.8 found it simpler to drop that, and just let shrink_page_list()
> clear up the debris later.
> 
> Here in shmem_writeout(), holding folio_lock throughout, we have no
> memcg complications, and can go ahead with delete_from_swap_cache(),
> both when successfully added back to page cache, and when that fails.

OK. Thanks for pointing out the change history here, and I have no 
further questions.

With your following changes, feel free to add:

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


Return-Path: <linux-kernel+bounces-819943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B633B7CAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 173AB4E1DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9CE266B52;
	Wed, 17 Sep 2025 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M+rT2PzQ"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD84DDA9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081018; cv=none; b=Iwf2StjFopiVEBHhTgcBtl3kS2ci3lbZd/cKJFH1mgHCi6FmX2q4BYJBK+AltfRY0ilH4vulLuSrUCB7NBNzlXOMyaYh91YWCFL1Q9fbum348CeXIeavaSmJYJp3XwGaTn6scYCdcbIrjjjRMx2f7sOcXZdbbfNCqZIRb3E7dLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081018; c=relaxed/simple;
	bh=1q/uyyE1opkCVPZZTNPTusI0tpUu0/goPHXTyC1hNxg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lHy89pYUCQctt7T8f5dFdLHBIzyjyFK1zycT1pYNp+RyEva/3r3ZyObdcvFGTKWj6UcC466eNYyyZWSsUVzpu+WTz3oqqrwAg3233jROphB5GKaaZYN4N2DIHuScKYdClSJ8/z0XVbwNYN/D3nZsd7LVJiqiBgayqdARWK/r3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M+rT2PzQ; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758081012; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=vm9MyVs3qndFLbwrsQ4E2tRYO2NcQgheP6ENpSIsgMU=;
	b=M+rT2PzQqCjetZY6Tqqv0uk/hfJ20mUvJvK/Wfa2MDq7fk8/zEXstPK0DeBjNne5yzcAspYZ+0bFJYGl0L2h3pJXI/lDvkaUJdxwncmLvHiBOqvsFALeGmnxgizhDr9QILiJAKZKYZZG3ZkBquH5Z4TyxdT7rUSLlxsCs9TpS78=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoB5YhN_1758081010 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Sep 2025 11:50:10 +0800
Message-ID: <7eace9f6-e257-498d-ac10-ae86b5713e3a@linux.alibaba.com>
Date: Wed, 17 Sep 2025 11:50:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, david@redhat.com, mhocko@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <qe56xt2natnxnkht7wgknsb5nqjhinaaajomvvvgnfpwry2jih@hsj2w5zqj6wv>
 <02798d6c-1ad3-4109-be3a-e09feb5e4eda@linux.alibaba.com>
 <9b01a2cc-7cdb-e008-f5bc-ff9aa313621a@google.com>
 <6ebb5cd0-0897-4de7-9303-422d0caa18cb@linux.alibaba.com>
In-Reply-To: <6ebb5cd0-0897-4de7-9303-422d0caa18cb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/16 15:18, Baolin Wang wrote:
> 
> 
> On 2025/9/16 12:00, Hugh Dickins wrote:
>> On Sat, 13 Sep 2025, Baolin Wang wrote:
>>> On 2025/9/13 00:13, Shakeel Butt wrote:
>>>> On Fri, Sep 12, 2025 at 11:45:07AM +0800, Baolin Wang wrote:
>>>>> Currently, we no longer attempt to write back filesystem folios in
>>>>> pageout(),
>>>>> and only tmpfs/shmem folios and anonymous swapcache folios can be 
>>>>> written
>>>>> back.
>>>>> Moreover, tmpfs/shmem and swapcache folios do not use the 
>>>>> PG_private flag,
>>>>> which means no fs-private private data is used. Therefore, we can 
>>>>> remove
>>>>> the
>>>>> redundant folio_test_private() checks and related buffer_head release
>>>>> logic.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>>    mm/vmscan.c | 16 +---------------
>>>>>    1 file changed, 1 insertion(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>> index f1fc36729ddd..8056fccb9cc4 100644
>>>>> --- a/mm/vmscan.c
>>>>> +++ b/mm/vmscan.c
>>>>> @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, 
>>>>> struct
>>>>> address_space *mapping,
>>>>>      * swap_backing_dev_info is bust: it doesn't reflect the
>>>>>      * congestion state of the swapdevs.  Easy to fix, if needed.
>>>>>      */
>>>>> -    if (!is_page_cache_freeable(folio))
>>>>> +    if (!is_page_cache_freeable(folio) || !mapping)
>>>>>            return PAGE_KEEP;
>>>>> -    if (!mapping) {
>>>>> -        /*
>>>>> -         * Some data journaling orphaned folios can have
>>>>> -         * folio->mapping == NULL while being dirty with clean
>>>>> buffers.
>>>>> -         */
>>>>
>>>> Can this case not happen anymore and try_to_free_buffers is not needed?
>>>
>>> For dirty file folios, pageout() will return PAGE_KEEP and put them 
>>> back on
>>> the LRU list. So even if mapping = NULL, background workers for 
>>> writeback will
>>> continue to handle them, rather than in shrink_folio_list().
>>
>> You've persuaded everyone else, but I'm still not convinced:
>> what are those "background workers for writeback",
>> that manage to work on orphaned folios with NULL mapping?
> 
> Sorry for not being clear. The ‘background workers for writeback’ here 
> refer to the workers responsible for handling the writeback of dirty 
> data (see wb_workfn()).
> 
>> I think *this* is the place which deals with that case, and you're
>> now proposing to remove it (and returning PAGE_KEEP not PAGE_CLEAN,
>> so it misses the filemap_release_folio() below the switch(pageout())).
>>
>> There's even a comment over in migrate_folio_unmap():
>> "Everywhere else except page reclaim, the page is invisible to the vm".
>>
>> And your argument that the code *afterwards* rejects everything but
>> shmem or anon, and neither of those would have folio_test_private(),
>> certainly did not convince me.
>>
>> Please persuade me.  But I've no evidence that this case does or does
>> not still arise; and agree that there must be cleaner ways of doing it.
> 
> I did some further analysis, and seems you are right. The flush worker 
> does check the folio mapping when writeback, but it does not further 
> release the private data, for example, in mpage_prepare_extent_to_map():
> 
> /*
>   * If the page is no longer dirty, or its mapping no
>   * longer corresponds to inode we are writing (which
>   * means it has been truncated or invalidated), or the
>   * page is already under writeback and we are not doing
>   * a data integrity writeback, skip the page
>   */
> if (!folio_test_dirty(folio) ||
>      (folio_test_writeback(folio) &&
>       (mpd->wbc->sync_mode == WB_SYNC_NONE)) ||
>      unlikely(folio->mapping != mapping)) {
>      folio_unlock(folio);
>      continue;
> }
> 
> This is somewhat beyond my expectations. I expected the flush worker 
> could handle such cases, allowing page reclaim to skip from handling 
> dirty file folios to improve reclaim efficiency. Obviously, I overlooked 
> this corner case.
> 
> Additionally, I'm still struggling to understand this case where a folio 
> is dirty but has a NULL mapping, but I might understand that ext3 
> journaling might do this from the comments in truncate_cleanup_folio().
> 
> But I still doubt whether this case exists because the refcount check in 
> is_page_cache_freeable() considers the pagecache. This means if this 
> dirty folio's mapping is NULL, the following check would return false. 
> If it returns true, it means that even if we release the private data 
> here, the orphaned folio's refcount still doesn't meet the requirements 
> for being reclaimed. Please correct me if I missed anything.
> 
> static inline int is_page_cache_freeable(struct folio *folio)
> {
>          /*
>           * A freeable page cache folio is referenced only by the caller
>           * that isolated the folio, the page cache and optional filesystem
>           * private data at folio->private.
>           */
>          return folio_ref_count(folio) - folio_test_private(folio) ==
>                  1 + folio_nr_pages(folio);
> }
> 

I continued to dig into the historical commits, where the private check 
was introduced in 2005 by commit ce91b575332b ("orphaned pagecache 
memleak fix"), as the commit message mentioned, it was to address the 
issue where reiserfs pagecache may be truncated while still pinned:

"
Chris found that with data journaling a reiserfs pagecache may be 
truncate while still pinned.  The truncation removes the page->mapping, 
but the page is still listed in the VM queues because it still has 
buffers.  Then during the journaling process, a buffer is marked dirty 
and that sets the PG_dirty bitflag as well (in mark_buffer_dirty). 
After that the page is leaked because it's both dirty and without a mapping.

So we must allow pages without mapping and dirty to reach the 
PagePrivate check.  The page->mapping will be checked again right after 
the PagePrivate check.
"

In 2008, commit a2b345642f530 ("Fix dirty page accounting leak with ext3 
data=journal") seems to be dealing with a similar issue, where the page 
becomes dirty after truncation, and provides a very useful call stack:
truncate_complete_page()
       cancel_dirty_page() // PG_dirty cleared, decr. dirty pages
       do_invalidatepage()
         ext3_invalidatepage()
           journal_invalidatepage()
             journal_unmap_buffer()
               __dispose_buffer()
                 __journal_unfile_buffer()
                   __journal_temp_unlink_buffer()
                     mark_buffer_dirty(); // PG_dirty set, incr. dirty pages

In this fix, we forcefully clear the page's dirty flag during truncation 
(in truncate_complete_page()).

However, I am still unsure how the reiserfs case is checked through 
is_page_cache_freeable() (if the pagecache is truncated, then the 
pagecache refcount would be decreased). Fortunately, reiserfs was 
removed in 2024 by commit fb6f20ecb121 ("reiserfs: The last commit").


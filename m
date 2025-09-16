Return-Path: <linux-kernel+bounces-818258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD6BB58EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D7D2A8635
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672028134C;
	Tue, 16 Sep 2025 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C2QTNGim"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393B27AC57
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007122; cv=none; b=tk0sWUHMKDBomhkELxEttRx/9tZJHJnkCXA5Scr/sAFL0OknAOU/kY/bknVbnZ0mqEtcTrU4SpoZ/O58n43UAhbIb9uryWapOO9TmzYjeu+PkV4vD6shIfzBTh4BX8n52F+0nR90zCmcWF6Ic+kk4v0RE7r7nOdcB7m56oeGM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007122; c=relaxed/simple;
	bh=dNrHKdHCvZRO4rxtXLAcTpH4HfxC/JtqxV+gB/yed4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H87reTF3Z01W0WBaztv7C5/8Aib04UkGP/L6IfK2Uk7ltN88XDrsoZ0CW1/HiBfXLDqD+IN2tgr35SGFEq86C3hNe6GtpgNgHct1ZLSBsu1PkOIoMK8HPD2VQEiA4SoWfP2ATOcCkc4Zn9gke0MtNN/4mrLUoVBksK8BDT6aie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C2QTNGim; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758007111; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jEIJopGBHha5mxI192yQ8swZlaL8UDF92y3iDqtrvSw=;
	b=C2QTNGim5GM0h+aM6japy8pL+YfGku0cMC/3tdEVPSymK4cZJUNowCR6QOCCHoQf/Fc44jObWNCtWB7Pb4/8fdY/fziZ/zSkq3hk/Lf0gX5PN3oSf3J/TMzXknbDF7tnRS/xfn6alQHtJu+BXh41s541kjciqAzMGEVmc0if9Wg=
Received: from 30.74.146.196(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wo7PMF3_1758007109 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Sep 2025 15:18:29 +0800
Message-ID: <6ebb5cd0-0897-4de7-9303-422d0caa18cb@linux.alibaba.com>
Date: Tue, 16 Sep 2025 15:18:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <9b01a2cc-7cdb-e008-f5bc-ff9aa313621a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/16 12:00, Hugh Dickins wrote:
> On Sat, 13 Sep 2025, Baolin Wang wrote:
>> On 2025/9/13 00:13, Shakeel Butt wrote:
>>> On Fri, Sep 12, 2025 at 11:45:07AM +0800, Baolin Wang wrote:
>>>> Currently, we no longer attempt to write back filesystem folios in
>>>> pageout(),
>>>> and only tmpfs/shmem folios and anonymous swapcache folios can be written
>>>> back.
>>>> Moreover, tmpfs/shmem and swapcache folios do not use the PG_private flag,
>>>> which means no fs-private private data is used. Therefore, we can remove
>>>> the
>>>> redundant folio_test_private() checks and related buffer_head release
>>>> logic.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    mm/vmscan.c | 16 +---------------
>>>>    1 file changed, 1 insertion(+), 15 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index f1fc36729ddd..8056fccb9cc4 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct
>>>> address_space *mapping,
>>>>      * swap_backing_dev_info is bust: it doesn't reflect the
>>>>      * congestion state of the swapdevs.  Easy to fix, if needed.
>>>>      */
>>>> -	if (!is_page_cache_freeable(folio))
>>>> +	if (!is_page_cache_freeable(folio) || !mapping)
>>>>    		return PAGE_KEEP;
>>>> -	if (!mapping) {
>>>> -		/*
>>>> -		 * Some data journaling orphaned folios can have
>>>> -		 * folio->mapping == NULL while being dirty with clean
>>>> buffers.
>>>> -		 */
>>>
>>> Can this case not happen anymore and try_to_free_buffers is not needed?
>>
>> For dirty file folios, pageout() will return PAGE_KEEP and put them back on
>> the LRU list. So even if mapping = NULL, background workers for writeback will
>> continue to handle them, rather than in shrink_folio_list().
> 
> You've persuaded everyone else, but I'm still not convinced:
> what are those "background workers for writeback",
> that manage to work on orphaned folios with NULL mapping?

Sorry for not being clear. The ‘background workers for writeback’ here 
refer to the workers responsible for handling the writeback of dirty 
data (see wb_workfn()).

> I think *this* is the place which deals with that case, and you're
> now proposing to remove it (and returning PAGE_KEEP not PAGE_CLEAN,
> so it misses the filemap_release_folio() below the switch(pageout())).
> 
> There's even a comment over in migrate_folio_unmap():
> "Everywhere else except page reclaim, the page is invisible to the vm".
> 
> And your argument that the code *afterwards* rejects everything but
> shmem or anon, and neither of those would have folio_test_private(),
> certainly did not convince me.
> 
> Please persuade me.  But I've no evidence that this case does or does
> not still arise; and agree that there must be cleaner ways of doing it.

I did some further analysis, and seems you are right. The flush worker 
does check the folio mapping when writeback, but it does not further 
release the private data, for example, in mpage_prepare_extent_to_map():

/*
  * If the page is no longer dirty, or its mapping no
  * longer corresponds to inode we are writing (which
  * means it has been truncated or invalidated), or the
  * page is already under writeback and we are not doing
  * a data integrity writeback, skip the page
  */
if (!folio_test_dirty(folio) ||
     (folio_test_writeback(folio) &&
      (mpd->wbc->sync_mode == WB_SYNC_NONE)) ||
     unlikely(folio->mapping != mapping)) {
	folio_unlock(folio);
	continue;
}

This is somewhat beyond my expectations. I expected the flush worker 
could handle such cases, allowing page reclaim to skip from handling 
dirty file folios to improve reclaim efficiency. Obviously, I overlooked 
this corner case.

Additionally, I'm still struggling to understand this case where a folio 
is dirty but has a NULL mapping, but I might understand that ext3 
journaling might do this from the comments in truncate_cleanup_folio().

But I still doubt whether this case exists because the refcount check in 
is_page_cache_freeable() considers the pagecache. This means if this 
dirty folio's mapping is NULL, the following check would return false. 
If it returns true, it means that even if we release the private data 
here, the orphaned folio's refcount still doesn't meet the requirements 
for being reclaimed. Please correct me if I missed anything.

static inline int is_page_cache_freeable(struct folio *folio)
{
         /*
          * A freeable page cache folio is referenced only by the caller
          * that isolated the folio, the page cache and optional filesystem
          * private data at folio->private.
          */
         return folio_ref_count(folio) - folio_test_private(folio) ==
                 1 + folio_nr_pages(folio);
}



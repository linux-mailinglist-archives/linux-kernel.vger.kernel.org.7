Return-Path: <linux-kernel+bounces-850076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A5BD1C76
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E8A4343F06
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993A02E88B6;
	Mon, 13 Oct 2025 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O1Zjb7eQ"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F91145B3E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340523; cv=none; b=n6E1KZnamOOulu+fg3KZu4SCdVmKYK+PNQF9OY8MZWtmnTtM81h7m1ZGZfGqC+5lweuhEGR0SBkT9FsL0K9AMJGy5e4Vn4mSapO1iBU5Q7lIg+8PZGnChgs8QmJsiycworQ97RHq6VC1rE8/3RiSXsezSHyW6tUy51Cfpa70VII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340523; c=relaxed/simple;
	bh=m/1YodZeSj5G3x4jAf6N3F7pdgV0hahLXHdLENXg8Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZ+Q5fQo6nptNg2Yh8mTnFWecqaew+ygvITUjW094syG5nOcw7n4uNTidavdONIiSj3CMZya/e7hV9FPWHsyCnMhQcx43oibFstI1jmotI6KSRDGT/YslkkfmonbOrmGvlYhUSG1XvMzxn4FI+dBRXb3GAjlCqkTt9Xd/dl91lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O1Zjb7eQ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba2ec325-72d1-4a11-943f-b36a090cb68b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760340519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkLKvSUaQ4BnGmUhizr6OnCKnUnuAC5ZuO6XhuLGhRQ=;
	b=O1Zjb7eQu5+hY64dyZyuiEp94+2tjMc+TNk3zePZG8N6CXTZ9bs0B6nz5bcpd/RRprCWyi
	k2CWFu4wddIDJRoOQUQZIyP/lCul2iotxNRRoGS2Rd2lTtDFfvercH+HFzJQ/FAxPIEwCq
	T2orOfnrwXuArjHFGynllIFgiY7dmmU=
Date: Mon, 13 Oct 2025 15:28:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1759510072.git.zhengqi.arch@bytedance.com>
 <304df1ad1e8180e102c4d6931733bcc77774eb9e.1759510072.git.zhengqi.arch@bytedance.com>
 <x4d36plhxcbyp76q4gmesktnnh7yi7bfifx3amk3fwx2moqkk6@77umpnw6rkg3>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <x4d36plhxcbyp76q4gmesktnnh7yi7bfifx3amk3fwx2moqkk6@77umpnw6rkg3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Shakeel,

On 10/7/25 7:16 AM, Shakeel Butt wrote:
> On Sat, Oct 04, 2025 at 12:53:17AM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> The maintenance of the folio->_deferred_list is intricate because it's
>> reused in a local list.
>>
>> Here are some peculiarities:
>>
>>     1) When a folio is removed from its split queue and added to a local
>>        on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>>        updated, leading to an inconsistency between it and the actual
>>        number of folios in the split queue.
>>
>>     2) When the folio is split via split_folio() later, it's removed from
>>        the local list while holding the split queue lock. At this time,
>>        this lock protects the local list, not the split queue.
> 
> I think the above text needs some massaging. Rather than saying lock
> protects the local list, I think, it would be better to say that the
> lock is not needed as it is not protecting anything.

Make sense, will do.

> 
>>
>>     3) To handle the race condition with a third-party freeing or migrating
>>        the preceding folio, we must ensure there's always one safe (with
>>        raised refcount) folio before by delaying its folio_put(). More
>>        details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>>        split queue not partially_mapped"). It's rather tricky.
>>
>> We can use the folio_batch infrastructure to handle this clearly. In this
>> case, ->split_queue_len will be consistent with the real number of folios
>> in the split queue. If list_empty(&folio->_deferred_list) returns false,
>> it's clear the folio must be in its split queue (not in a local list
>> anymore).
>>
>> In the future, we will reparent LRU folios during memcg offline to
>> eliminate dying memory cgroups, which requires reparenting the split queue
>> to its parent first. So this patch prepares for using
>> folio_split_queue_lock_irqsave() as the memcg may change then.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> One nit below.
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!

> 
>> ---
>>   mm/huge_memory.c | 85 ++++++++++++++++++++++--------------------------
>>   1 file changed, 39 insertions(+), 46 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 134666503440d..59ddebc9f3232 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3782,21 +3782,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>   		struct lruvec *lruvec;
>>   		int expected_refs;
>>   
>> -		if (folio_order(folio) > 1 &&
>> -		    !list_empty(&folio->_deferred_list)) {
>> -			ds_queue->split_queue_len--;
>> +		if (folio_order(folio) > 1) {
>> +			if (!list_empty(&folio->_deferred_list)) {
>> +				ds_queue->split_queue_len--;
>> +				/*
>> +				 * Reinitialize page_deferred_list after removing the
>> +				 * page from the split_queue, otherwise a subsequent
>> +				 * split will see list corruption when checking the
>> +				 * page_deferred_list.
>> +				 */
>> +				list_del_init(&folio->_deferred_list);
>> +			}
>>   			if (folio_test_partially_mapped(folio)) {
>>   				folio_clear_partially_mapped(folio);
>>   				mod_mthp_stat(folio_order(folio),
>>   					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>   			}
>> -			/*
>> -			 * Reinitialize page_deferred_list after removing the
>> -			 * page from the split_queue, otherwise a subsequent
>> -			 * split will see list corruption when checking the
>> -			 * page_deferred_list.
>> -			 */
>> -			list_del_init(&folio->_deferred_list);
>>   		}
>>   		split_queue_unlock(ds_queue);
>>   		if (mapping) {
>> @@ -4185,35 +4186,40 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>   {
>>   	struct deferred_split *ds_queue;
>>   	unsigned long flags;
>> -	LIST_HEAD(list);
>> -	struct folio *folio, *next, *prev = NULL;
>> -	int split = 0, removed = 0;
>> +	struct folio *folio, *next;
>> +	int split = 0, i;
>> +	struct folio_batch fbatch;
>>   
>> +	folio_batch_init(&fbatch);
>> +
>> +retry:
>>   	ds_queue = split_queue_lock_irqsave(sc->nid, sc->memcg, &flags);
>>   	/* Take pin on all head pages to avoid freeing them under us */
>>   	list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
>>   							_deferred_list) {
>>   		if (folio_try_get(folio)) {
>> -			list_move(&folio->_deferred_list, &list);
>> -		} else {
>> +			folio_batch_add(&fbatch, folio);
>> +		} else if (folio_test_partially_mapped(folio)) {
>>   			/* We lost race with folio_put() */
>> -			if (folio_test_partially_mapped(folio)) {
>> -				folio_clear_partially_mapped(folio);
>> -				mod_mthp_stat(folio_order(folio),
>> -					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>> -			}
>> -			list_del_init(&folio->_deferred_list);
>> -			ds_queue->split_queue_len--;
>> +			folio_clear_partially_mapped(folio);
>> +			mod_mthp_stat(folio_order(folio),
>> +				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>   		}
>> +		list_del_init(&folio->_deferred_list);
>> +		ds_queue->split_queue_len--;
>>   		if (!--sc->nr_to_scan)
>>   			break;
>> +		if (!folio_batch_space(&fbatch))
>> +			break;
>>   	}
>>   	split_queue_unlock_irqrestore(ds_queue, flags);
>>   
>> -	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
>> +	for (i = 0; i < folio_batch_count(&fbatch); i++) {
>>   		bool did_split = false;
>>   		bool underused = false;
>> +		struct deferred_split *fqueue;
>>   
>> +		folio = fbatch.folios[i];
>>   		if (!folio_test_partially_mapped(folio)) {
>>   			/*
>>   			 * See try_to_map_unused_to_zeropage(): we cannot
>> @@ -4236,38 +4242,25 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>   		}
>>   		folio_unlock(folio);
>>   next:
>> +		if (did_split || !folio_test_partially_mapped(folio))
>> +			continue;
>>   		/*
>> -		 * split_folio() removes folio from list on success.
>>   		 * Only add back to the queue if folio is partially mapped.
>>   		 * If thp_underused returns false, or if split_folio fails
>>   		 * in the case it was underused, then consider it used and
>>   		 * don't add it back to split_queue.
>>   		 */
>> -		if (did_split) {
>> -			; /* folio already removed from list */
>> -		} else if (!folio_test_partially_mapped(folio)) {
>> -			list_del_init(&folio->_deferred_list);
>> -			removed++;
>> -		} else {
>> -			/*
>> -			 * That unlocked list_del_init() above would be unsafe,
>> -			 * unless its folio is separated from any earlier folios
>> -			 * left on the list (which may be concurrently unqueued)
>> -			 * by one safe folio with refcount still raised.
>> -			 */
>> -			swap(folio, prev);
>> +		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
>> +		if (list_empty(&folio->_deferred_list)) {
>> +			list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
>> +			fqueue->split_queue_len++;
>>   		}
>> -		if (folio)
>> -			folio_put(folio);
>> +		split_queue_unlock_irqrestore(fqueue, flags);
> 
> Is it possible to move this lock/list_add/unlock code chunk out of loop
> and before the folios_put(). I think it would be possible if you tag the
> corresponding index or have a separate bool array. It is also reasonable
> to claim that the contention of this lock is not a concern for now.

Considering the code complexity, perhaps we could wait until contention
on this lock becomes a problem?

Thanks,
Qi

> 
>>   	}
>> +	folios_put(&fbatch);
>>   
>> -	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>> -	list_splice_tail(&list, &ds_queue->split_queue);
>> -	ds_queue->split_queue_len -= removed;
>> -	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>> -
>> -	if (prev)
>> -		folio_put(prev);
>> +	if (sc->nr_to_scan)
>> +		goto retry;
>>   
>>   	/*
>>   	 * Stop shrinker if we didn't split any page, but the queue is empty.
>> -- 
>> 2.20.1
>>



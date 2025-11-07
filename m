Return-Path: <linux-kernel+bounces-889706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48247C3E484
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A235834A785
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EED12D9EF0;
	Fri,  7 Nov 2025 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bzZlJvVZ"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620BF9EC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483895; cv=none; b=AGABuBlBGO93v2n4tPCK6Mf8cnvSE0b+Z91iaHPQp28clfK9RNvmUKFI+kS9W5spFMEizeBrwzaSaGc8RxrQVugI1deT2hldFMxRxGrk1GHuBBTBfAwa6K26JVDnYnJZqk9c9P+QadPGRScpKEgQZcqORwak7zU7FEcpO1kKLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483895; c=relaxed/simple;
	bh=1jSn69IIhJ9XN0dFUxMyhDviVS0J5fURCDium71+Fs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfKx4AMnv8rDSkm7fQZeEC6lMXhTB3pqO/lKEjVtRQ/BRiv0WG+AAYKMmlVLuagNRe3NsH9prBnxFg4/hb3TPIP1Jq2auZ44/F4dJnzvzwSBkkoA3054Sa5hK6OKLf2vVhKNiySq1kqmccxccjC2PgCS4adxmmoObeIew8voZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bzZlJvVZ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <131176ed-8901-4a04-92ce-e270fc536404@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762483890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DG0Pm3cx15SZFs+emOMlWtRSV7YqmPrwZzDA3RG3IYY=;
	b=bzZlJvVZxZRP5AChCD7RthMKFu+lDwVz0r/gOn4BxXW7bSJ4JxWILPObhbvN8szk3TQahV
	Db8ybcuhKqZmUQKyyueNTvvaomWY5OcKZB0m4AbdLIaW/A0qt+RQoJf8KqhqaQ6HUjCEU5
	Xy99rJl48vXIlMO3YaGG4kmPV817K3A=
Date: Fri, 7 Nov 2025 10:51:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
To: Wei Yang <richard.weiyang@gmail.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
 <20251106145213.jblfgslgjzfr3z7h@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20251106145213.jblfgslgjzfr3z7h@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/6/25 10:52 PM, Wei Yang wrote:
> On Wed, Oct 15, 2025 at 02:35:32PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> The maintenance of the folio->_deferred_list is intricate because it's
>> reused in a local list.
>>
>> Here are some peculiarities:
>>
>>    1) When a folio is removed from its split queue and added to a local
>>       on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>>       updated, leading to an inconsistency between it and the actual
>>       number of folios in the split queue.
>>
>>    2) When the folio is split via split_folio() later, it's removed from
>>       the local list while holding the split queue lock. At this time,
>>       the lock is not needed as it is not protecting anything.
>>
>>    3) To handle the race condition with a third-party freeing or migrating
>>       the preceding folio, we must ensure there's always one safe (with
>>       raised refcount) folio before by delaying its folio_put(). More
>>       details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>>       split queue not partially_mapped"). It's rather tricky.
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
>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> ---
>> mm/huge_memory.c | 87 +++++++++++++++++++++++-------------------------
>> 1 file changed, 41 insertions(+), 46 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index a68f26547cd99..e850bc10da3e2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3782,21 +3782,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>> 		struct lruvec *lruvec;
>> 		int expected_refs;
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
>> 			if (folio_test_partially_mapped(folio)) {
>> 				folio_clear_partially_mapped(folio);
>> 				mod_mthp_stat(folio_order(folio),
>> 					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>> 			}
>> -			/*
>> -			 * Reinitialize page_deferred_list after removing the
>> -			 * page from the split_queue, otherwise a subsequent
>> -			 * split will see list corruption when checking the
>> -			 * page_deferred_list.
>> -			 */
>> -			list_del_init(&folio->_deferred_list);
> 
> @Andrew
> 
> Current mm-new looks not merge the code correctly?
> 
> The above removed code is still there.
> 
> @Qi
> 
> After rescan this, I am confused about this code change.
> 
> The difference here is originally it would check/clear partially_mapped if
> folio is on a list. But now we would do this even folio is not on a list.
> 
> If my understanding is correct, after this change, !list_empty() means folio
> is on its ds_queue. And there are total three places to remove it from
> ds_queue.
> 
>    1) __folio_unqueue_deferred_split()
>    2) deferred_split_scan()
>    3) __folio_split()
> 
> In 1) and 2) we all clear partially_mapped bit before removing folio from
> ds_queue, this means if the folio is not on ds_queue in __folio_split(), it is
> not necessary to check/clear partially_mapped bit.

In deferred_split_scan(), if folio_try_get() succeeds, then only the
folio will be removed from ds_queue, but not clear partially_mapped.

> 
> Maybe I missed something, would you mind correct me on this?
> 



Return-Path: <linux-kernel+bounces-862544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C1DBF5925
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B99954FEB41
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB8B2EA47C;
	Tue, 21 Oct 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IHGqQc8U"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B8231845
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039827; cv=none; b=SwZ21jrR1/96vqt2VyQdP0iUH7zGOi7SY3QD+vh37O0elDyqwIci89FuvyLWwWj01fTSQ4oinkPMIXC/d+244eCrmhOfmicXwK0pox/2G47jCKMieNpBjWtAZT4SwNGav0ujWJ7YxEgKEg4nRnstJM2eIsdTdmdnR23g1me92aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039827; c=relaxed/simple;
	bh=c+cYyz1M+ePaM/3v1a6Dwno79+CTdxJdrhK32/Bcvvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnQHL5hDnyzcsADzlAYMZuWgTDzslruAnzPYkHVdNSgdW6kzUkf3fr5bspXcdeqv3abIcH2Sv0aYMbPyf49Wn6bmkZoBLodYyEjICc+bHN/DmA6J6bR0zDxL3TAGT4cxRqDUsa+Eap3VUryBixYQCX1wf2rt+tqYEZJHR4urgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IHGqQc8U; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba8bb85a-af2c-47b4-8d68-5b4c554dc819@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761039822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y68f6ioof0lkMrxXjDHFuuOelLAqNc2E80mHKKj9Gtg=;
	b=IHGqQc8UE6T0NyZE6pCdcE3h8Yl/eLqkrpDlLIATgAoiT1JduWDb/ea4MBvvF8ZrdG9tRg
	6uhsjfaZ6mMEJ/SEvNDefSRRiBusqvxC8/Qj9hgS1ueBAUA/iPG80IzM6Td8Q2uwOgPsBF
	CGtSKKuxjN+y5gEimmBK5eil6Q6SvNI=
Date: Tue, 21 Oct 2025 17:43:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <645f537dee489faa45e611d303bf482a06f0ece7.1760509767.git.zhengqi.arch@bytedance.com>
 <aPcjnKAapap5jrK-@hyeyoo> <3acbf7df-b890-4679-bbbe-959bd45fdef3@linux.dev>
 <aPdSbO-6xTmr4IsX@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aPdSbO-6xTmr4IsX@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/21/25 5:29 PM, Harry Yoo wrote:
> On Tue, Oct 21, 2025 at 02:21:55PM +0800, Qi Zheng wrote:
>>
>>
>> On 10/21/25 2:09 PM, Harry Yoo wrote:
>>> On Wed, Oct 15, 2025 at 02:35:33PM +0800, Qi Zheng wrote:
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> Similar to list_lru, the split queue is relatively independent and does
>>>> not need to be reparented along with objcg and LRU folios (holding
>>>> objcg lock and lru lock). So let's apply the similar mechanism as list_lru
>>>> to reparent the split queue separately when memcg is offine.
>>>>
>>>> This is also a preparation for reparenting LRU folios.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> Acked-by: Zi Yan <ziy@nvidia.com>
>>>> Reviewed-by: Muchun Song <muchun.song@linux.dev>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>> ---
>>>
>>> Looks good to me,
>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>
>> Thanks.
>>
>>>
>>> with a question:
>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index e850bc10da3e2..9323039418201 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -1117,8 +1117,19 @@ static struct deferred_split *split_queue_lock(int nid, struct mem_cgroup *memcg
>>>>    {
>>>>    	struct deferred_split *queue;
>>>> +retry:
>>>>    	queue = memcg_split_queue(nid, memcg);
>>>>    	spin_lock(&queue->split_queue_lock);
>>>> +	/*
>>>> +	 * There is a period between setting memcg to dying and reparenting
>>>> +	 * deferred split queue, and during this period the THPs in the deferred
>>>> +	 * split queue will be hidden from the shrinker side.
>>>> +	 */
>>>
>>> You mean it will be hidden if the shrinker bit is not set for the node
>>> in the parent memcg, right?
>>
>> Look at the following situation:
>>
>> CPU 0                   CPU 1
>> -----                   -----
>>
>> set CSS_DYING
>>                          deferred_split_scan
>>                              /*
>>                               * See CSS_DYING, and return the parent
>>                               * memcg's ds_queue. But the pages on the
>>                               * child memcg's ds_queue has not yet been
>>                               * reparented to the parent memcg, that is,
>>                               * it is hidden.
>>                               */
>>                          --> ds_queue = split_queue_lock_irqsave()
>>
>> reparent_deferred_split_queue
> 
> Ah, I see what you meant. Thanks.
> 
> So we may end up shrinking the parent memcg twice if it's
> hidden, but I guess it's fine as it'll be rare?

Yeah.

> 
>> Thanks,
>> Qi
> 



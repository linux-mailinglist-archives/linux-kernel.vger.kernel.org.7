Return-Path: <linux-kernel+bounces-830276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C18B9943A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CBA27B0001
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC9D2DA749;
	Wed, 24 Sep 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fmBWDnou"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0C2D9EC5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707862; cv=none; b=RoZnX52yS8sufl5QDAjOf5m3ipCLP9ru6QqEczQaRducHYxNTeArpr2T1EPmiTOYpnRpOKpwkYWjqA7r5XWgjXnEVeGe0Y0WkVkSn/7iSNeRKp09RKbS6bNsays1WeUb5g7tgNN5P56V0+6ABjN7HxWW9eR+Lu1pKx5MdcHI1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707862; c=relaxed/simple;
	bh=PlTlCAQTbFsYg1Q+cD3eTy1Y0CHBpbfZENgL01ToVoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPPuICsmOhgh6YBmCjqvDVpWQc7vBPJ3CvIbr3BAmyWoWskrNwIGSCcC8HCGs+gZyWYBEd0v07t7Nv//KQ8MC/IJGN6P33iKcmiIPpfUwPZsE+AK+2z58TJgWM71zy9hxPurzUEdTKBFypFdG170am169ah7Q6EUewS5IgksSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fmBWDnou; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f3580ab80so3689602b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758707855; x=1759312655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feWoks1URwNxECdx0kBnKSduIOhZ1zoC6naom/ljIvQ=;
        b=fmBWDnouTK7IospaMlz08xaIT8e7TEbL1bKlQvGeBjOLiTpDqSX5x8L9KoLPsg1gP9
         ny54CKLol6bQdOr875+JHLlPdgbfoF/LhnPsuqMjZj95OoZBaEd2LooNglj98NkdxOOd
         xLOh85SMyjaIlinHoVb8bci8gnMEeEfNqcsBmImOdYNRNouM1T8xmxrP1/cIHf/UuHf1
         ybu9d6N/yC35Xn+XB/hzGL1VRjVkuAsf73SnDKWqYr+ZqgvFNqiR6K2uMUHmFmQgIlZ5
         4FQki6cUPjEE0r17UxLSTV7EaC0BkmCmUQjp9uHC9EDGFLOuzFynqG3ynWwk2Y+/FEVq
         SOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707855; x=1759312655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=feWoks1URwNxECdx0kBnKSduIOhZ1zoC6naom/ljIvQ=;
        b=IW/pfKSgPplmNF888iIMR83K4/hxrFwc7sdG2SIElwYeqRF//lxU54Wd49CjdN44MV
         bKSJGrX6gNo38ibMBcliaSLagH0UwRrKp0fUD6gQPFS52DZ5k7rgmZ/ACDu3QQ3jU1ce
         pzBiwAQpw0YfL58zXng1P0qS2W2ZuMr8RRjoRDY9r+bDHpWLoEi1PjiJhAbLJTywJvVQ
         U15BLxOoNJnBOuCmwV8+XIziGAc2gGTwHZAfgvWaGP2vXjPcLHWcl002c9QDZFkhOrkN
         Y6U/qYcAL5lMBB/bhPik0DBUAGTGId6zneZ/B7BKr1tWcXu5GgsVlRm9ELNpFgL5PI2F
         ylGw==
X-Forwarded-Encrypted: i=1; AJvYcCV06X2jvSphHL0meiQu7Fmyt1MHXq2w3BFMIZfldITaC/IjZI5bkRyuC36YkYLYo4bq3uTF7quuI65sFgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5gdEg2MVWbU0d1v9OMMLLU+rWy56gw0F/c3/YYH1tqSxg44S
	iO+qMPfHd/edKyDjkCO3hNt2s68Bphqok4RXGsTTbUanDfQ+KZLd3+QaKDaLpnEQIVY=
X-Gm-Gg: ASbGncuRnP/75gBz7N026hXX5lx8MpXt71sIBcH/jJylj4WvpBSRjjBB/Jnx6A/MgnC
	yZmWswcFZK4q0ERh693BjjKtzlvyybn4lOfdk7HorY2TAaeeDdwUqpSW02RDdX+aLj6OZdw9Vx0
	CeR/Ukws+eTl0ZiQHj3DWyHf1cjfCy7yFEoM5TEc6PszoT9h4hDkawRSfQQ13Dn+ZixH0/JJpyP
	YPu7Emhi53MU+LZrpeg2Ks8qDOqf3dQtv0cBkUDNOYwDv6A7igkYmhD/CNaJRv0MWGdgy0hSphc
	wmqxkkegFW732d/Cdo4Xh2qKoxZVY4OzDowAq+dSuGe+65WLY/hVO4bLz67YYeDxEzlzW+rpePk
	EzuGPrlA1RsGOJjsWq4DGtO9VvAx7c3XT3976E4onhHlkAXwhYEpzEcY2Bw==
X-Google-Smtp-Source: AGHT+IHcogPZLoIfoB/HwHpwoOkYoaHEaLHCbtFP1GStNJWfELLsdO2LyRM5voSYtico8yl3cdiwAw==
X-Received: by 2002:a05:6a20:e293:b0:2c1:b47d:bcc9 with SMTP id adf61e73a8af0-2cff49b176emr7797143637.48.1758707854901;
        Wed, 24 Sep 2025 02:57:34 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55352ae6d2sm11066918a12.37.2025.09.24.02.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 02:57:34 -0700 (PDT)
Message-ID: <7d0bf9a8-7890-4002-9e02-5f7884ab0bca@bytedance.com>
Date: Wed, 24 Sep 2025 17:57:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
To: Zi Yan <ziy@nvidia.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <782da2d3eca63d9bf152c58c6733c4e16b06b740.1758618527.git.zhengqi.arch@bytedance.com>
 <A64EA303-74CD-4CF9-B892-C0FF9699F3FF@nvidia.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <A64EA303-74CD-4CF9-B892-C0FF9699F3FF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zi,

On 9/23/25 11:31 PM, Zi Yan wrote:
> On 23 Sep 2025, at 5:16, Qi Zheng wrote:
> 
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
>>
>>     3) To handle the race condition with a third-party freeing or migrating
>>        the preceding folio, we must ensure there's always one safe (with
>>        raised refcount) folio before by delaying its folio_put(). More
>>        details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>>        split queue not partially_mapped"). It's rather tricky.
>>
>> We can use the folio_batch infrastructure to handle this clearly. In this
> 
> Can you add more details on how folio_batch handles the above three concerns
> in the original code? That would guide me what to look for during code review.

Sure.

For 1), after adding folio to folio_batch, we immediatelly decrement the
ds_queue->split_queue_len, so there are no more inconsistencies.

For 2), after adding folio to folio_batch, we will see list_empty() in
__folio_split(), so there is no longer a situation where
split_queue_lock protects the local list.

For 3), after adding folio to folio_batch, we call folios_put() at the
end to decrement the refcount of folios, which looks more natural.

> 
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
>> ---
>>   mm/huge_memory.c | 84 ++++++++++++++++++++++--------------------------
>>   1 file changed, 38 insertions(+), 46 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2f41b8f0d4871..48b51e6230a67 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3781,21 +3781,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
> 
> folio_test_partially_mapped() is done regardless the folio is on _deferred_list
> or not, is it because the folio can be on a folio batch and its _deferred_list
> is empty?

Yes.

> 
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
>> @@ -4194,40 +4195,44 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>   	struct pglist_data *pgdata = NODE_DATA(sc->nid);
>>   	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>>   	unsigned long flags;
>> -	LIST_HEAD(list);
>> -	struct folio *folio, *next, *prev = NULL;
>> -	int split = 0, removed = 0;
>> +	struct folio *folio, *next;
>> +	int split = 0, i;
>> +	struct folio_batch fbatch;
>>
>>   #ifdef CONFIG_MEMCG
>>   	if (sc->memcg)
>>   		ds_queue = &sc->memcg->deferred_split_queue;
>>   #endif
>>
>> +	folio_batch_init(&fbatch);
>> +retry:
>>   	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
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
> 
> At this point, the folio can be following conditions:
> 1. deferred_split_scan() gets it,
> 2. it is freed by folio_put().
> 
> In both cases, it is removed from deferred_split_queue, right?

Right. For the case 1), we may add folio back to deferred_split_queue.

> 
>>   		if (!--sc->nr_to_scan)
>>   			break;
>> +		if (!folio_batch_space(&fbatch))
>> +			break;
>>   	}
>>   	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
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
>> @@ -4250,38 +4255,25 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
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
> 
> fqueue should be the same as ds_queue, right? Just want to make sure
> I understand the code.

After patch #4, fqueue may be the deferred_split of parent memcg.

Thanks,
Qi

> 
>>   		}
>> -		if (folio)
>> -			folio_put(folio);
>> +		split_queue_unlock_irqrestore(fqueue, flags);
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
> 
> 
> Best Regards,
> Yan, Zi



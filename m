Return-Path: <linux-kernel+bounces-827146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F572B906D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E49544E212E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39965304BA4;
	Mon, 22 Sep 2025 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZuOzSJDf"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278082EC54B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540981; cv=none; b=ZIEe1wMBfm+OFVe2ZzEYyTUqG7V4c00oDpT+0ZueWC66ShXqldl8k1RfCo+o6YpubV+cDFm8ofJF23ry9HbjxoPJ9s74pJGH8VTT8mQ+4XaT9RhPyesKSvndnCPcVosvh21juIeRewt4gn4opBvk+14qTVg2f6rowcoZ42ncStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540981; c=relaxed/simple;
	bh=/i/QjJCSnl81HMVrz6IGeARxHKvGKeRUP+nDaWfI3CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcFpUo5Z26oiUPZQo5+4DHvaGy39PoD/kH/p2U545nONBR2C2d/yn0bkA04Skdq/5If0HZzmxExPZGYKgbkNasZfzqJ6maQvL5E77Vt0HNOAlSYZVknjvLusTSixfw6tZmfsRb/Ol834aDF2K+t+NjWI0KV9udMGIFLrdy/c6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZuOzSJDf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-330469eb750so4848395a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758540978; x=1759145778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0u+YpSV/wxdA6FA5LVbjzCi32nJBgZrsJFyY0iW11c=;
        b=ZuOzSJDfcvdDKZKCQ6FkDl+n49rMGZiobUVgRCFxb8t6+cd8h4bCf1UH2GagNfOPz2
         oOBfAChkH3RvonK89f44L2zeJv8IY5Q7i064CoGODz9xyvG7mTP8qHLK13+S2kI/C3xe
         o97i+tNgkRBetd7A9oc0tVq31UdjYut3aeLhACxw648fA7VZU2yYLwoTmR13h7y5aPso
         YpFMzPLhDkkRszZdw3dlcTd5AU/Wi/vB/RF/sVyZnUj58ZhA2RW3an3DIspoLP2m2veg
         4xixAOUeUAVAbJ17CVezsT3sAp+63KQ9X4zjPrSCDvEzKJHB4ZqnzubDtpREd+C7E+pq
         lAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758540978; x=1759145778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0u+YpSV/wxdA6FA5LVbjzCi32nJBgZrsJFyY0iW11c=;
        b=RProF5/wKtEuaYkeRJO9MiQtM2z7S99YxQIw8rJPrKJZYmbvfMf4ty4BI4GaSQbj2z
         rDBqA69+o5INZobfoqRQdHrbCJt1CCajhzzBIH1hYxbwsPognY0iWja3hD6cDVxsTUrF
         IC1BGt+OgwXs6ywUfqlx5VRR4d6GzZ+SEWYXw9cxfCI1u63eXPcyPRPF0hvgLdJLoTmQ
         xpFXc4HekwcWYmZNeaegASweTw84K6OlTAQa564Mq7BnS96LdoqG49YPrpwXoFUdbDIv
         3+9Uwc3TmOKIYiWlMg58sm/SPjTiCHfhKV7fogrzk8Y9aliUO/2TFmrqxIhs2FpvfCtp
         WEKA==
X-Forwarded-Encrypted: i=1; AJvYcCW3IeY8zm9HAAOi34FD8iG/3CU2APIe8zqCCo/pHbSskOmymKYDSUbcy/bCxpXr1NiS5Nbq5OuI6uYSGSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQtx/8iK+l3XKU4wvhJLeWNsCjMsDW6/s2a8C+rvIgLwBsV7d
	p1SRI45Fqz7nP0QYZZzuFpEcjANYeQxY1KYUZJsIOteYv5iQfkMNLifui6Fr51n38Yg=
X-Gm-Gg: ASbGncuw81SrkHsevDzHO2PfPCDPh+guGEURq4hTa+ucxFp86nHz3f2XxytKQ7JA+7n
	HngCDlHjeVOybnpPg0HFlxZmlfAYXMgCcq/aFEdi0OC91PqJbRhqck7fyX0ftLRt6+HX2f5s5kr
	d/SsarLi0GAJXDhnPwZwL9yFE5K6kOicauMLuJNeCYmjYz3WUGnT72YkeYN90Z1iK7+dzXVMfyQ
	Eqvni387FrTsFTF26UahtY1LCGYNX34/ylyit/QJ9tYHE81Uq7OOYzkW+O0J1gXjeVod3T8o9YI
	OcBSxYPcf5mjXT/HuRGlf5PlmDCvpZYDa5JpArd4j3R+sVc1Jdsy7b5OAbPBPV0Xas4Ny4UFOrp
	Xur65Igl/tsdipVowwv9WWXUup3rClPNPRkfa+mG+joRnw1TtExFOPqMeXeOsIg==
X-Google-Smtp-Source: AGHT+IFu8eiVI48iUvVgVKbcFTq4WvOFa2+0AYyjYOZYbm0gMsPD46CwjI8fpjFeWEGqYdUgtuMPzA==
X-Received: by 2002:a17:90b:2788:b0:32b:94a2:b0d5 with SMTP id 98e67ed59e1d1-3309838dff7mr15360958a91.37.1758540978490;
        Mon, 22 Sep 2025 04:36:18 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea0852a82sm10802765a91.0.2025.09.22.04.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 04:36:17 -0700 (PDT)
Message-ID: <65b6c32a-7eb4-4023-94c0-968735b784f6@bytedance.com>
Date: Mon, 22 Sep 2025 19:36:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm: thp: use folio_batch to handle THP splitting in
 deferred_split_scan()
To: David Hildenbrand <david@redhat.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
 <3db5da29d767162a006a562963eb52df9ce45a51.1758253018.git.zhengqi.arch@bytedance.com>
 <40772b34-30c8-4f16-833c-34fdd7c69176@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <40772b34-30c8-4f16-833c-34fdd7c69176@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 9/22/25 4:43 PM, David Hildenbrand wrote:
> On 19.09.25 05:46, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> The maintenance of the folio->_deferred_list is intricate because it's
>> reused in a local list.
>>
>> Here are some peculiarities:
>>
>>     1) When a folio is removed from its split queue and added to a local
>>        on-stack list in deferred_split_scan(), the ->split_queue_len 
>> isn't
>>        updated, leading to an inconsistency between it and the actual
>>        number of folios in the split queue.
> 
> deferred_split_count() will now return "0" even though there might be 
> concurrent scanning going on. I assume that's okay because we are not 
> returning SHRINK_EMPTY (which is a difference).
> 
>>
>>     2) When the folio is split via split_folio() later, it's removed from
>>        the local list while holding the split queue lock. At this time,
>>        this lock protects the local list, not the split queue.
>>
>>     3) To handle the race condition with a third-party freeing or 
>> migrating
>>        the preceding folio, we must ensure there's always one safe (with
>>        raised refcount) folio before by delaying its folio_put(). More
>>        details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>>        split queue not partially_mapped"). It's rather tricky.
>>
>> We can use the folio_batch infrastructure to handle this clearly. In this
>> case, ->split_queue_len will be consistent with the real number of folios
>> in the split queue. If list_empty(&folio->_deferred_list) returns false,
>> it's clear the folio must be in its split queue (not in a local list
>> anymore).
>>
>> In the future, we will reparent LRU folios during memcg offline to
>> eliminate dying memory cgroups, which requires reparenting the split 
>> queue
>> to its parent first. So this patch prepares for using
>> folio_split_queue_lock_irqsave() as the memcg may change then.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/huge_memory.c | 88 +++++++++++++++++++++++-------------------------
>>   1 file changed, 42 insertions(+), 46 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index d34516a22f5bb..ab16da21c94e0 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3760,21 +3760,22 @@ static int __folio_split(struct folio *folio, 
>> unsigned int new_order,
>>           struct lruvec *lruvec;
>>           int expected_refs;
>> -        if (folio_order(folio) > 1 &&
>> -            !list_empty(&folio->_deferred_list)) {
>> -            ds_queue->split_queue_len--;
>> +        if (folio_order(folio) > 1) {
>> +            if (!list_empty(&folio->_deferred_list)) {
>> +                ds_queue->split_queue_len--;
>> +                /*
>> +                 * Reinitialize page_deferred_list after removing the
>> +                 * page from the split_queue, otherwise a subsequent
>> +                 * split will see list corruption when checking the
>> +                 * page_deferred_list.
>> +                 */
>> +                list_del_init(&folio->_deferred_list);
>> +            }
>>               if (folio_test_partially_mapped(folio)) {
>>                   folio_clear_partially_mapped(folio);
>>                   mod_mthp_stat(folio_order(folio),
>>                             MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>               }
>> -            /*
>> -             * Reinitialize page_deferred_list after removing the
>> -             * page from the split_queue, otherwise a subsequent
>> -             * split will see list corruption when checking the
>> -             * page_deferred_list.
>> -             */
>> -            list_del_init(&folio->_deferred_list);
>>           }
> 
> BTW I am not sure about holding the split_queue_lock before freezing the 
> refcount (comment above the freeze):
> 
> freezing should properly sync against the folio_try_get(): one of them 
> would fail.
> 
> So not sure if that is still required. But I recall something nasty 
> regarding that :)

I'm not sure either, need some investigation.

> 
> 
>>           split_queue_unlock(ds_queue);
>>           if (mapping) {
>> @@ -4173,40 +4174,48 @@ static unsigned long 
>> deferred_split_scan(struct shrinker *shrink,
>>       struct pglist_data *pgdata = NODE_DATA(sc->nid);
>>       struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>>       unsigned long flags;
>> -    LIST_HEAD(list);
>> -    struct folio *folio, *next, *prev = NULL;
>> -    int split = 0, removed = 0;
>> +    struct folio *folio, *next;
>> +    int split = 0, i;
>> +    struct folio_batch fbatch;
>> +    bool done;
> 
> Is "done" really required? Can't we just use sc->nr_to_scan tos ee if 
> there is work remaining to be done so we retry?

I think you are right, will do in the next version.

> 
>>   #ifdef CONFIG_MEMCG
>>       if (sc->memcg)
>>           ds_queue = &sc->memcg->deferred_split_queue;
>>   #endif
>> +    folio_batch_init(&fbatch);
>> +retry:
>> +    done = true;
>>       spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>       /* Take pin on all head pages to avoid freeing them under us */
>>       list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
>>                               _deferred_list) {
>>           if (folio_try_get(folio)) {
>> -            list_move(&folio->_deferred_list, &list);
>> -        } else {
>> +            folio_batch_add(&fbatch, folio);
>> +        } else if (folio_test_partially_mapped(folio)) {
>>               /* We lost race with folio_put() */
>> -            if (folio_test_partially_mapped(folio)) {
>> -                folio_clear_partially_mapped(folio);
>> -                mod_mthp_stat(folio_order(folio),
>> -                          MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>> -            }
>> -            list_del_init(&folio->_deferred_list);
>> -            ds_queue->split_queue_len--;
>> +            folio_clear_partially_mapped(folio);
>> +            mod_mthp_stat(folio_order(folio),
>> +                      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>           }
>> +        list_del_init(&folio->_deferred_list);
>> +        ds_queue->split_queue_len--;
>>           if (!--sc->nr_to_scan)
>>               break;
>> +        if (folio_batch_space(&fbatch) == 0) {
> 
> Nit: if (!folio_batch_space(&fbatch)) {

OK, will do.

Thanks,
Qi

> 
> 



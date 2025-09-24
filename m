Return-Path: <linux-kernel+bounces-830300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 088D1B99589
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB9314E1E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9955825A34F;
	Wed, 24 Sep 2025 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PgQdGmnK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3215624D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708391; cv=none; b=cDXAcTEUk4lELdKy5R+hmCTptCjXdWYzmzxu75iBbicw070JZ4nl+5AaIFQP/nG1m4rj9m6lhQrKwtYBUGhqF5Eu5S5x19gXybDklUjYepZJDIpD7qai+0dNRksuosUBglvzwIMioXlXJkKK+kAb/23WIkOWLr0sWel6TVoIqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708391; c=relaxed/simple;
	bh=U4NgULEgdH3+wVK2A6tyf0ydUVdvgU3xgFrasX8sbIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEv9SyioHVAsT/qVry1b86vEqXY4w8swHnUyzMeWq90G2CkHn5AM08tAoVAsaxc8+4Ev/Pv3AEYWQlphGiCcoCY968E4KxDnfTOgtfE3d+A6hSH0wefjXDt0F1CtdSRP2C5TFH+4EpQ1pcQlGgDM/1nY+A2U8Xnxe2em4KosO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PgQdGmnK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso6211603b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758708386; x=1759313186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfE2mgVlyr7iNmaZ4vQXyrWE/ZvZPrZL7XGUEK7ATPc=;
        b=PgQdGmnK5nIVXYhMWW3bI7kcM88aqLrVQiCm3VpCZ9kfz8ppcHGXAyhT6/mkg80kjn
         u6oU3JVrexWEB1xJ+/VAkup5Itikih+4zPfW7MnxssX6xUOdoqBCLee5NdTqBP6hZkNs
         fiT9SwLkG4I1c/nxntfjl2bD5qDT4FHWXQDqDZHpzYT6YFMCriCogOV8lew/7cC0sGuk
         dn3u7AENDoe++ZI7OCRTInsiOwlM/owEc3ubmxy5m0pUFYp1lIsOpJq/Cz3mZ99hS0T4
         lRAfWgPrMmKXgjTFve76jY63yDCobpe4E/7kFv0BXWC/qbNH+sIRL3UU5XD5bTXRB8Td
         G82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708386; x=1759313186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EfE2mgVlyr7iNmaZ4vQXyrWE/ZvZPrZL7XGUEK7ATPc=;
        b=xB6KB6g2tMl+K67DdyNHgLAbUoZZS3LMy5NXK7+Fs/3MVoXsMozi5YLUpGzanwrfbJ
         j7czfEsSKm5IFZEzb4RCkB6nJDDaoJX/c6Jd4qdRso8kE8+NI8qRhaa/7nQ8F6OQgMEh
         ZoXJRDjKPcU2Bb/TA/OIKSLHDj4YPqAVe3b6PmjCe43Q1EpSjZO6FA6ft16Yx0+g/Tnz
         4Oud/DNq7xm+BinuxDn9RqmHnmXw+KIyshhEWZIyNVv+SYcPuaOaDWvTGVdTYsqb8Ose
         yZBFnnkHLezb+GP9Qh2NQW0EhMPJMj3BgLOBWzuZQFLVUSjD1RbhaimwtmQjr7jUjsjS
         tlAA==
X-Forwarded-Encrypted: i=1; AJvYcCW55q5gYLiUy1XC+4gQ9CSfAdZe8G8osDN8SPrLfQsX5jH2hksdHJBpek+ryWLNU2DvB9v7pcfZbAmZwio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0FF+WxeIqgQ2QexBwVHh0hBpndaByjXeZmKPT2/0JFYmrqlUy
	eSyY01BsaID6cNtuHF/kGAzV5UxyJYhDZZz6+2Xiu83jG/M+815EDiJIi168Ddt4g80=
X-Gm-Gg: ASbGncvPJwHav4oI2hdcGk8rNj8dxIzrvPnuKOdJ3HMbtJiBjOqdfMqAWHR+rWh4CjM
	hcYW/H7N+HacD8kRpcTC0ToBBBxn7voIvWMaCJqIJeOE1/knGLDF4eKsYLewq8HVgqOweoRxYlB
	XhygNkhroe+21JRmVgXk7xFW5GFJKujQroY2GMPQBGcIiM9CBMqszkOnDfgAETIXp4x3quKbXDp
	GVyu5vhW07sMNK8fKOu4d1zyzysIb2BF+TzLjFxUN/2/SCEdABt0BG1DjOTdFMSyaStb8ki+JrN
	e302ttaoSWS4Nd3VBXdKyA2H9tx/1j1jhWzhUEs1nHSlfpCkVL1/20B/Kp0NL6HTie+TWE9iWU+
	69SR2MPvu8DbpAS6xS5mRmdtHJ0Rhasxrp6djdObRugqfdJK8CjONu9iGzE5zKoSoDHD3
X-Google-Smtp-Source: AGHT+IFhsnsZYVlejzedhp8ryD+eY+C2FjhYDyPffnI2uMukcLjw9DOqyDy7/D84SWZQ/6CRngyUhw==
X-Received: by 2002:a05:6a00:1990:b0:77f:1a7e:7bc0 with SMTP id d2e1a72fcca58-77f53acfa71mr6945066b3a.31.1758708385394;
        Wed, 24 Sep 2025 03:06:25 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0da43089sm13920289b3a.90.2025.09.24.03.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:06:24 -0700 (PDT)
Message-ID: <72d23e4d-6c59-4adf-86ba-aa3ae8566bde@bytedance.com>
Date: Wed, 24 Sep 2025 18:06:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <7ia4bjn06w62.fsf@castle.c.googlers.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <7ia4bjn06w62.fsf@castle.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Roman,

On 9/24/25 5:23 PM, Roman Gushchin wrote:
> Qi Zheng <zhengqi.arch@bytedance.com> writes:
> 
>> In the future, we will reparent LRU folios during memcg offline to
>> eliminate dying memory cgroups, which requires reparenting the split queue
>> to its parent.
> 
> Nit: commit logs should really focus on the actual change, not the future
> plans.

Got it.

> 
>>
>> Similar to list_lru, the split queue is relatively independent and does
>> not need to be reparented along with objcg and LRU folios (holding
>> objcg lock and lru lock). So let's apply the same mechanism as list_lru
>> to reparent the split queue separately when memcg is offine.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/huge_mm.h |  2 ++
>>   include/linux/mmzone.h  |  1 +
>>   mm/huge_memory.c        | 39 +++++++++++++++++++++++++++++++++++++++
>>   mm/memcontrol.c         |  1 +
>>   mm/mm_init.c            |  1 +
>>   5 files changed, 44 insertions(+)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index f327d62fc9852..a0d4b751974d2 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -417,6 +417,7 @@ static inline int split_huge_page(struct page *page)
>>   	return split_huge_page_to_list_to_order(page, NULL, ret);
>>   }
>>   void deferred_split_folio(struct folio *folio, bool partially_mapped);
>> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
>>   
>>   void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>   		unsigned long address, bool freeze);
>> @@ -611,6 +612,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
>>   }
>>   
>>   static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>> +static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>>   #define split_huge_pmd(__vma, __pmd, __address)	\
>>   	do { } while (0)
>>   
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 7fb7331c57250..f3eb81fee056a 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1346,6 +1346,7 @@ struct deferred_split {
>>   	spinlock_t split_queue_lock;
>>   	struct list_head split_queue;
>>   	unsigned long split_queue_len;
>> +	bool is_dying;
>>   };
>>   #endif
>>   
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 48b51e6230a67..de7806f759cba 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1094,9 +1094,15 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>>   	struct deferred_split *queue;
>>   
>>   	memcg = folio_memcg(folio);
>> +retry:
>>   	queue = memcg ? &memcg->deferred_split_queue :
>>   			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>>   	spin_lock(&queue->split_queue_lock);
>> +	if (unlikely(queue->is_dying == true)) {
>> +		spin_unlock(&queue->split_queue_lock);
>> +		memcg = parent_mem_cgroup(memcg);
>> +		goto retry;
>> +	}
>>   
>>   	return queue;
>>   }
>> @@ -1108,9 +1114,15 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
>>   	struct deferred_split *queue;
>>   
>>   	memcg = folio_memcg(folio);
>> +retry:
>>   	queue = memcg ? &memcg->deferred_split_queue :
>>   			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>>   	spin_lock_irqsave(&queue->split_queue_lock, *flags);
>> +	if (unlikely(queue->is_dying == true)) {
>> +		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
>> +		memcg = parent_mem_cgroup(memcg);
>> +		goto retry;
>> +	}
>>   
>>   	return queue;
>>   }
>> @@ -4284,6 +4296,33 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>   	return split;
>>   }
>>   
>> +void reparent_deferred_split_queue(struct mem_cgroup *memcg)
>> +{
>> +	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
>> +	struct deferred_split *ds_queue = &memcg->deferred_split_queue;
>> +	struct deferred_split *parent_ds_queue = &parent->deferred_split_queue;
>> +	int nid;
>> +
>> +	spin_lock_irq(&ds_queue->split_queue_lock);
>> +	spin_lock_nested(&parent_ds_queue->split_queue_lock, SINGLE_DEPTH_NESTING);
>> +
>> +	if (!ds_queue->split_queue_len)
>> +		goto unlock;
>> +
>> +	list_splice_tail_init(&ds_queue->split_queue, &parent_ds_queue->split_queue);
>> +	parent_ds_queue->split_queue_len += ds_queue->split_queue_len;
>> +	ds_queue->split_queue_len = 0;
>> +	/* Mark the ds_queue dead */
>> +	ds_queue->is_dying = true;
>> +
>> +	for_each_node(nid)
>> +		set_shrinker_bit(parent, nid, shrinker_id(deferred_split_shrinker));
> 
> Does this loop need to be under locks?

I think it is not necessary, but the loop overhead should not be high.

> 
>> +
>> +unlock:
>> +	spin_unlock(&parent_ds_queue->split_queue_lock);
>> +	spin_unlock_irq(&ds_queue->split_queue_lock);
>> +}
>> +
>>   #ifdef CONFIG_DEBUG_FS
>>   static void split_huge_pages_all(void)
>>   {
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index e090f29eb03bd..d03da72e7585d 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3887,6 +3887,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>>   	zswap_memcg_offline_cleanup(memcg);
>>   
>>   	memcg_offline_kmem(memcg);
>> +	reparent_deferred_split_queue(memcg);
>>   	reparent_shrinker_deferred(memcg);
> 
> I guess the naming can be a bit more consistent here :)

Do you mean to change them all to:

memcg_offline_xxx()

or

reparent_xxx() ?

Thanks,
Qi

> 
> Thanks!



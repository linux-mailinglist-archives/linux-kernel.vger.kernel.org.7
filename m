Return-Path: <linux-kernel+bounces-830278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC43AB99467
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B616F3BE5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4B22D94AC;
	Wed, 24 Sep 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="b45RflKN"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616C26CE0C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707935; cv=none; b=gvAvo0T3I39R3pFt+4XECFrw+jGVkPsyY6Mwx/XKyh7YBmAs46ETtT4xudsEUv2HpxQN1XSyHmzKc5OGeW4v30uEExXjksgqqW3pqf6eDCRI46HM7nACj8VsaTSUAQV21o1+wOoC06mlalxdKoykwX1EGM8NmsHabZ02sPECl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707935; c=relaxed/simple;
	bh=phY6RvVbnxsN7L0GipExTQMawwSkCPv6aSriDeehH0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLDiX5Pj5BK2G7wA2yp3xefbvn/4XdEYjtuZTFwC4Zfd2AsimXYGzCYryik67KAdKZSrQT15Fmr1+EbqsyQlR/L/T7OX1be7YvnghHursnEKaIL3dUDkziY40eubM3/PuEZBauV3Ho4KWVaUuIKKfDvJeEkBjKt/W/6QXnjIhmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=b45RflKN; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b523fb676efso5829557a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758707929; x=1759312729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avFLT9/zrgVxo7hnCTRMxJbrYoXVl3Ka4VB6cXLWScg=;
        b=b45RflKNUlsIoKilYCt92OxMOLyWTP6K0AGwjd6V+dRYN/7qru53R0OolnYMGtYioL
         uA3DWDizGEe1HeezYHAsEAwDXETOie+j7OP1H/rFbVSi1rQr1ivL6MEiVDhycfhltRCC
         B4uTkcYXCXmDXmjjBTSCDFTQpJoF7APKzbePBS1NMO0CgWi8+SET8tkev0xzjdeBmlR7
         F9Da7hvS+MDR0KSbiVyyU52N0hegvDOhP9lVhYsSzMU2mTQ4TiAqK26McE8xJWhbT5+5
         P6g+X6psjoo7hv/Z6KJMcxjuYcaChfVIZMLAcYns/kucBOVryCMoxIk/bjtacPT1vopq
         Xnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707929; x=1759312729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=avFLT9/zrgVxo7hnCTRMxJbrYoXVl3Ka4VB6cXLWScg=;
        b=iLG078HrtKOmMW+ESM1MjrkMT7HNGfPpDeCiECC9sFC5HbIn2gzvt46mkMTc1DebQv
         SL1CSKIp/FCOqI56WTYqE/bFNWtcXRrDfXDyNMwSMNcrhlZEwNwoSO1mZ4cn/CwwtJtn
         PmTGjDMzelLNzM0y4jmHm04G5YclB19t0kR4JZRoqCI5VRC3JFY8EqOhv2FWIVWwHGNI
         5+TLcniKjPV4w4sAXGUw8rVOf2rcJmtIGx2lgbA7jnId3j2TFngN19w72QHfOI4tvvnf
         IudUQrrm2M8PXirPRJOqktUQTTQzG3VAT570PxE0mfXqp92dYtPdnHwElWcJJTDQldQg
         /xCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2xKeGbkYLh7QTK295NTsZoBBqnijrKY0jrL+n4XEJ5iLFhuSk5edLL9LUM0HBtOuRNYH03PJHlTxCYSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQzscIIwN/l+Vrzy8vQbprCKgkHruA72Z1neNfkU7xGe31wrpu
	8+nWhT/QkQSVUxToyF7ImZRxzPUWklPQWXi46Zp0cnoJbRFAj6ou3izAGF86LS2jdM8=
X-Gm-Gg: ASbGnctAq3/Z4WU0XET4QQXE3ggotlKpTauWOsqS16FDBtI1dOoweEpdy1FaXtMspIU
	i3GVaeu6oPHI2Vj/br1rhTUyBz+eDLVbGALE58Ke9dsiPOYHHqywBXm8Eo5+GI4DnMbASczN0cD
	Mdzq1b1GlreeChqeG86tpfY+4lwjhp7ABzk9nfasEKBcSv218CfLyToVLy/EUFWeHYD8SKRnYRD
	zjiEVZ00O7MpJWYVCAqq8X/83MN8fqLxDN3th2Ye5FIHiw0CtKJ5GINRTHU2rF16LS5jZRloDs1
	gDoR83p2i/Fp8Z2/qI3VSJ2+QATFGIkLvqIiECYjeCo92qqphwaj3FRSiBrL0xTiQdgdH65DlxK
	kblmnwoLJuLtE09Ds64muhgBChv6ZRJXG2b3gu7s0xf+g5/6bfRLqIpDevw==
X-Google-Smtp-Source: AGHT+IEUbjYRQ/MBtudU8ME5ZjlRil0hIRiHs6tLk5o3IUdn5h9aQrZs1iIENTC2rBUyUMBREV5BCA==
X-Received: by 2002:a17:903:8c6:b0:269:b2e5:ee48 with SMTP id d9443c01a7336-27cc7404c14mr74664935ad.52.1758707929142;
        Wed, 24 Sep 2025 02:58:49 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802fe096sm186571915ad.104.2025.09.24.02.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 02:58:48 -0700 (PDT)
Message-ID: <ed226e93-8d3c-400d-9129-ae8fee755dca@bytedance.com>
Date: Wed, 24 Sep 2025 17:58:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Zi Yan <ziy@nvidia.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <303D9A50-FC6D-4710-8405-2283A05CD41D@nvidia.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <303D9A50-FC6D-4710-8405-2283A05CD41D@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/25 11:44 PM, Zi Yan wrote:
> On 23 Sep 2025, at 5:16, Qi Zheng wrote:
> 
>> In the future, we will reparent LRU folios during memcg offline to
>> eliminate dying memory cgroups, which requires reparenting the split queue
>> to its parent.
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
> 
> Should ds_queue still be marked as dying even if it is empty?
> Otherwise, new folios still can be added to it, based on my
> understanding of the changes to folio_split_queue_lock*().

I think you are right, will do in the next version.

Thanks,
Qi

> 
>> +
>> +	list_splice_tail_init(&ds_queue->split_queue, &parent_ds_queue->split_queue);
>> +	parent_ds_queue->split_queue_len += ds_queue->split_queue_len;
>> +	ds_queue->split_queue_len = 0;
>> +	/* Mark the ds_queue dead */
>> +	ds_queue->is_dying = true;
>> +
>> +	for_each_node(nid)
>> +		set_shrinker_bit(parent, nid, shrinker_id(deferred_split_shrinker));
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
>>   	wb_memcg_offline(memcg);
>>   	lru_gen_offline_memcg(memcg);
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 3db2dea7db4c5..cbda5c2ee3241 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1387,6 +1387,7 @@ static void pgdat_init_split_queue(struct pglist_data *pgdat)
>>   	spin_lock_init(&ds_queue->split_queue_lock);
>>   	INIT_LIST_HEAD(&ds_queue->split_queue);
>>   	ds_queue->split_queue_len = 0;
>> +	ds_queue->is_dying = false;
>>   }
>>   #else
>>   static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
>> -- 
>> 2.20.1
> 
> 
> Best Regards,
> Yan, Zi



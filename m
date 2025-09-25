Return-Path: <linux-kernel+bounces-831818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6854B9D9E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB0016A81A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCECB2ECD32;
	Thu, 25 Sep 2025 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FN3G5Ure"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226D2ECD05
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781788; cv=none; b=Qu3hmvB6yqCXRjAN8CoUuyrvbvWm4qUWd6DVMCvDHHu/EBxPVdodZLKjXQL0rRttPwYCIsMgpAkd2NQJ8MAihx+l1B4K0RlSbTOtwmYw0Ex2LikU6ClkllNTv8T8fpC0GQg0T8Vk7Mas26lyiRJjkKieAucTHux1hxfbS9+rzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781788; c=relaxed/simple;
	bh=ocfCkwFjc0I4FHV5WpKQR66vTwtaBg8ZxSR4+GATfs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ncq4Ag0vJ0T4zsqY3YHlFDW/bnX5xR5w96+270WtcsWA3SdmTuA6xC9Ed6M1fiEmoyjRdbQalTcNXYDaFTwb0+fJwxpqyceFmo8Ud2Oi5n8U8v5EEiqYxIXaH9fW6RtpCOku39eV5qeklyBwHUboNts9RznArE6kgkhvsB89E/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FN3G5Ure; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78100be28easo414226b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758781785; x=1759386585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8V0lwTpuXsxcfHaxZsvIL+kGsolkwkY6GPwdx3nz5yU=;
        b=FN3G5Ure85ZtEYeDbkv9FedXs2pJw7g2ZLmenevZnB2LnRVbOoZdY+Juj1V+yIlxhi
         n5FKxrBqNVqhCmR7UcwY8wBivXmbYqPj4NBoe2FicsmXe4d8gApsr9+ylzgON/FrS5fg
         cEPW9p89vml0j6suBVkqePeQoPvg/BGlAWcYPKki8aergL7DlCnT5pA9vB+rxwZ/uhyy
         WDryJz1cZNHomIsKYOFA1SzfMU30nk3vxDV5p1H2bEUQ8zqkHYcPjs9F8nXLaf8bk7za
         hlAEctKAlVa+nhVP0g85fzDkIBKfn9Dzei55V6RydwISTS8/Mevvrj+hO44EK5pGbaq3
         bnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781785; x=1759386585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8V0lwTpuXsxcfHaxZsvIL+kGsolkwkY6GPwdx3nz5yU=;
        b=hkfVgI3z7Ydmu4XlauNXsbA1deavWdWejeXFvZflyL3PZj7UKqJu0NGA2IsF5VyfVG
         FjFA5/h6DR89TXZrh30TMUUqo8uf79VAKXjmleoDGoBXKyksWr1a4q4/3qSGqR0MDCfb
         zWXjxaIddnAto6622eDV8Cr4eqEMm/qySiTlftC19CclB6sM0sifxx9iMKu/TVjMD80v
         RdAwhpVY3HprlWZWXr0d9+fq2baL2MgfVBzTCQrqHTz3Fk2H6HXs3DL2Z+faziyKdG8m
         dYSqp+Jmcrfx7gfe1Rum7/WvzIXMUFac4toHcQnf/sX/NtDxFuUnj1tZtoSbSgpaGu2f
         fguQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV58Wti7PxewBmf/E9RJKTES6L96glB7fZhwbHQ7kV1oZmUsm4ugS5r3k8YeM+Wf5/OBrbz0Buu0h/pWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJSNMSs/c1idrArrWTMXJRCA4FWf88DCVjPmW7wAMwAv+y0cBD
	XGDJjVjO13d6ErUTkq0bvttT64RC/qrfNbFrzRpWoBAVzPG9gvBMCfL9Bnm4VQ7XjBE=
X-Gm-Gg: ASbGncuh9bYB2DAAN4/cgdrpsQ6+ht528yckCy6KzJs4ss7GlF2qsUImxg892Qh7f1R
	gNVBDmHjSWwAVyMRgbXkVuNpX9b/etuEdQEKdovsyVecehxTj9MIGO/93Qj2c3Dj+OjkPbiIEJe
	ETnOhdwhRiHGVy1o72COdCfuOx85uxO1tlj8K1GXGrxz4DpEfTjmxvmiS1dpswXEUgV19P9g+Wu
	UnObxdUm+XgTFDGcA61v9xRY6aI8MYPaSTVvQlqCfwWshzfyF4ajfPGUm+ewHC5e6P/WMLQBvOi
	LC8+cpmswJ2yFNYp4JNZdyKeYfoKkgfnqRlc5n/yzCPYZcc18qHvAFkf7wOHhZeuHFa1W2EU4zk
	xQuFP9IkQB8o0tB4BnqoGO1/8+gLHvo4eiSpR0wbO6p+/fkmf/dT/EeGPRw==
X-Google-Smtp-Source: AGHT+IG1LqAYu9jhNBG55xyv+UGKIWKzgZ4CKtKvlXs/Xd5vgIieh3XV27iBoLmTtXwYy9tOxqb0JQ==
X-Received: by 2002:a05:6a20:3ca2:b0:2d5:e559:d23a with SMTP id adf61e73a8af0-2e7d3db6116mr3182046637.55.1758781784872;
        Wed, 24 Sep 2025 23:29:44 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b2ec47sm961356b3a.50.2025.09.24.23.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 23:29:44 -0700 (PDT)
Message-ID: <77114896-5a7a-413d-afa1-7d0a17312c99@bytedance.com>
Date: Thu, 25 Sep 2025 14:29:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <aNP-rT1neQB0EdyQ@hyeyoo>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <aNP-rT1neQB0EdyQ@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harry,

On 9/24/25 10:22 PM, Harry Yoo wrote:
> On Tue, Sep 23, 2025 at 05:16:25PM +0800, Qi Zheng wrote:
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
> 
> The scheme in Muchun's version was:
> 
> retry:
> queue = folio_split_queue(folio);
> spin_lock(&queue->split_queue_lock);
> if (folio_memcg(folio) != folio_split_queue_memcg(folio, queue)) {
>      /* split queue was reparented, retry */
>      spin_unlock(&queue->split_queue_lock);
>      goto retry;
> }
> /* now we have a stable mapping between the folio and the split queue */
> spin_unlock(&queue->split_queue_lock);
> 
> Oh, I see. We can't use this scheme yet because we don't reparent LRU
> folios. (I was wondering why we're adding is_dying property)

Right. And reparenting THP split queue independently can avoid the
following situations:

```
acquire child and parent split_queue_lock
acquire child and parent objcg_lock
acquire child and parent lru lock

reparent THP split queue
reparent objcg
reparent LRU folios

release child and parent lru lock
release child and parent objcg_lock
release child and parent split_queue_lock
```

> 
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 48b51e6230a67..de7806f759cba 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1094,9 +1094,15 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>>   	struct deferred_split *queue;
> 
> 
> For now it's safe to not call rcu_read_lock() here because memcgs won't
> disappear under us as long as there are folios to split (we don't reparent
> LRU folios), right?

Right. We will add rcu_read_lock() when reparenting LRU folios.

Thanks,
Qi

> 
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
>>   	return queue;
>>   }
> 



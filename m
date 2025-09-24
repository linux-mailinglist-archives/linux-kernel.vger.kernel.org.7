Return-Path: <linux-kernel+bounces-830508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C489CB99DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EBC17A381B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C099E2FD1BB;
	Wed, 24 Sep 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZShnzjuv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF81FB1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717525; cv=none; b=qrS63/9UVGww5RxZSbH+Xvjhs/2JRz5b0cblp4O48FUHlz7BRhrT27ZOfDf1js+wF+iF1kwn0iZjX1/berOrg5VFvGZky14k0Aoyy6gGTkBnLbVZSQqE+CYbM+vwvq6lpBlhVJdNmPnZBlhWcLpO5KTeCGMJH9WmToN5qhHk1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717525; c=relaxed/simple;
	bh=+4ZKfWEcexel5KoU1Ye0etPWmee3qFMkby77GOlb2Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaRe6l6J+KQZqnEIVuTRoTfZHxc/8BiA+RzZWiTPGlX9sIYj1b6LwfbpyVQygZny4KDxWBPfIZtW8ZJ7xvg8Nyu/Hch5WvJliFv/cZ/95FJcmT0RQMaB5SuiRlLdYo7G/gymsFUE7J77rQicXiH/Zw2D9TCOtLeYwGI9062b4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZShnzjuv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758717523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aPF6Jvl0Op5T7a596f1x716IHLymgMCe8uM8IFM2SCQ=;
	b=ZShnzjuvndEzIbuPFBQRHzZo7tqGw0XzVnZpMEt9n6U5iurYvtT7TSq2GEDztGb2AqM4YF
	LzbVftl0LTaQ2qzhDblD03eVxLfoljC08rniAdDLt3G/fJAWha7VzuvJvmrGB9pTma/GuU
	ZiHJQQBmIUT7rPobWc2mKhxdPef/yNI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-42bX5NCDMOqvBpB06-CrDw-1; Wed, 24 Sep 2025 08:38:41 -0400
X-MC-Unique: 42bX5NCDMOqvBpB06-CrDw-1
X-Mimecast-MFC-AGG-ID: 42bX5NCDMOqvBpB06-CrDw_1758717520
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso53896595e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717520; x=1759322320;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPF6Jvl0Op5T7a596f1x716IHLymgMCe8uM8IFM2SCQ=;
        b=hGzPs7WN9QQPoxcdkyrWKswIDhR9PkX04MeEO8MCXVudCpnIiJ8iatqgUp/geUJXQ5
         PF3KyaEp0LMALjO6j4EP6RNObPDWKROHsPsg4c59xo0Qk36vofBW0HHhsvkBOOq9J8TK
         iQJdyL0EURvHkmjJeNHuB2y7csdMPd4EwI9NQ+MkQV8eS6Dzw4WSvCH1yKDPJ7Q+FWLJ
         PHgfH6YGEMrQvZIqna8UbvIi0rEDtFJ9SevDdozFon5B2Z9AoW6vtLgivnpnAlKhy0I+
         pN8FVzuoHakYJwk1uKmccrCJkNXli3DwigLZa1Jhm49Yc+uExDCn3N7Bb+OaqGuYAnbM
         m4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgeId23A2YJn8LjbrF6NsJIn82tS6zSOOpIRMCBle4rP9Y2SToTacEuEER7l8467WUjwCdVktDha0gdIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOmEJS1e1ztL5cJx9SOw5QvMj973zRgMvQK2az0cjwdz5NNCX
	vC8BJIldwh4TUzG1FQlEXnSERQjhnZ4fMN5Yd2TcoNlzfu/o445yYD/0So3gSK9CHKp8FahyR1a
	sUhnEiv59O0w0bUJxWuV7ZaumCu/gCYNyDgnBlzJfi9Bwsr9UTngzVL/8b6ZL5nHm6g==
X-Gm-Gg: ASbGncvaKLm/HIlCImmfekOe7jFEDezDW7F+MN9kEwXhrFc6NGrw0o7a5KsNhk9QFhD
	pWVPKo9WY/elqs2FfqwNXxg7lFVTb2UM1h3oqJEZKu3fG0OiuqXXlUAqRbM4YsJzLZb78zVSXKv
	yYA+8+TsNYzM2ljysvUcx1PgbNGKi+JLbPZnIGo5lca5+B67tBBrxpZr0wYSRusqMSWET7KHAd3
	+ioJI3S1/jlXyxR3+sTfW28udeqy1Az1fM/9xigNlnGUIicMnNUTy4sYkO4Yl22bQz2x6XPz4/6
	luYTE+CCzOLjUEKIHlSc5s6qyxp+6jnJDsAqUpPdmr1bDlcTTdfdCoqLhks2XPFhpfu9Refl88i
	AF2lF2OLxayN8Zx5Na7lKs5okcV9dCglVoHifKIjk0vakeF0Xj3ZzcQSh6a9Ee2O8Uw==
X-Received: by 2002:a05:600c:1d02:b0:45d:d2d2:f081 with SMTP id 5b1f17b1804b1-46e1dab45bemr71219615e9.20.1758717520189;
        Wed, 24 Sep 2025 05:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoOcDJrZXb/FAj2GHp5vwDQ3FVAghlcebAFZ1Ij8pdYpyP5A1mb01GFXI6T1WFSkm200TrjA==
X-Received: by 2002:a05:600c:1d02:b0:45d:d2d2:f081 with SMTP id 5b1f17b1804b1-46e1dab45bemr71219115e9.20.1758717519643;
        Wed, 24 Sep 2025 05:38:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1ce10bacsm40101155e9.0.2025.09.24.05.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:38:39 -0700 (PDT)
Message-ID: <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
Date: Wed, 24 Sep 2025 14:38:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 11:16, Qi Zheng wrote:
> In the future, we will reparent LRU folios during memcg offline to
> eliminate dying memory cgroups, which requires reparenting the split queue
> to its parent.
> 
> Similar to list_lru, the split queue is relatively independent and does
> not need to be reparented along with objcg and LRU folios (holding
> objcg lock and lru lock). So let's apply the same mechanism as list_lru
> to reparent the split queue separately when memcg is offine.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   include/linux/huge_mm.h |  2 ++
>   include/linux/mmzone.h  |  1 +
>   mm/huge_memory.c        | 39 +++++++++++++++++++++++++++++++++++++++
>   mm/memcontrol.c         |  1 +
>   mm/mm_init.c            |  1 +
>   5 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc9852..a0d4b751974d2 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -417,6 +417,7 @@ static inline int split_huge_page(struct page *page)
>   	return split_huge_page_to_list_to_order(page, NULL, ret);
>   }
>   void deferred_split_folio(struct folio *folio, bool partially_mapped);
> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
>   
>   void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>   		unsigned long address, bool freeze);
> @@ -611,6 +612,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
>   }
>   
>   static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
> +static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>   #define split_huge_pmd(__vma, __pmd, __address)	\
>   	do { } while (0)
>   
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 7fb7331c57250..f3eb81fee056a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1346,6 +1346,7 @@ struct deferred_split {
>   	spinlock_t split_queue_lock;
>   	struct list_head split_queue;
>   	unsigned long split_queue_len;
> +	bool is_dying;

It's a bit weird to query whether the "struct deferred_split" is dying. 
Shouldn't this be a memcg property? (and in particular, not exist for 
the pglist_data part where it might not make sense at all?).

>   };
>   #endif
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 48b51e6230a67..de7806f759cba 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1094,9 +1094,15 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>   	struct deferred_split *queue;
>   
>   	memcg = folio_memcg(folio);
> +retry:
>   	queue = memcg ? &memcg->deferred_split_queue :
>   			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>   	spin_lock(&queue->split_queue_lock);
> +	if (unlikely(queue->is_dying == true)) {

if (unlikely(queue->is_dying))

> +		spin_unlock(&queue->split_queue_lock);
> +		memcg = parent_mem_cgroup(memcg);
> +		goto retry;
> +	}
>   
>   	return queue;
>   }
> @@ -1108,9 +1114,15 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
>   	struct deferred_split *queue;
>   
>   	memcg = folio_memcg(folio);
> +retry:
>   	queue = memcg ? &memcg->deferred_split_queue :
>   			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>   	spin_lock_irqsave(&queue->split_queue_lock, *flags);
> +	if (unlikely(queue->is_dying == true)) {

if (unlikely(queue->is_dying))

> +		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
> +		memcg = parent_mem_cgroup(memcg);
> +		goto retry;
> +	}
>   
>   	return queue;
>   }

Nothing else jumped at me, but I am not a memcg expert :)

-- 
Cheers

David / dhildenb



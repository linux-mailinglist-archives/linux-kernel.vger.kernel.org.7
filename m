Return-Path: <linux-kernel+bounces-826797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC2B8F5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F0F189FC3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA132EC0A9;
	Mon, 22 Sep 2025 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a3PaLiap"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A62F5498
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527772; cv=none; b=nH/2rmf/loKPgqEJvOb/6tYeS4i7zaeHVHXtd9S/pSOlWhN3wQpz3WOUG/q1OXqUrD73kpuYc2HV/eZK1N2s3VWBRKyXDZPkXSwD36EXBAb8//fB9QY/3RxXCwLBQmUNaSouiEQ9XIbTDZURD2VRuMOx80cgwV4D6jht3lnzjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527772; c=relaxed/simple;
	bh=8i6WR7wNxUdNym60gmmuLGp0ENk6YF3tjgR/S8buY1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8UUZJ5BE6WqbfThO4OEpHwFb0rr/cyBDNWukivBT34vLyUP2VsYObB8eWSXYsFdlGv90NTYwSuJPdSgr0yFwM6YLn/IgNAeZNjz/7vcZ8NfbkBHi+z1w+9OBoowdAJeNNG0GQlZKAjZpbRLByrJ0ucgTVnpcY88iPf4l2uoQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a3PaLiap; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f3405c38aso642750b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758527770; x=1759132570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOLEn6wbExiWX7ZHkvEGaEspEQHvpxYxacH64/69EaI=;
        b=a3PaLiap22YdBcgqmGpEdF6p+r/ZDcctgYIvbd0qUDcdBLwqvJzcvgX3KldLDCVCXr
         6UziWnzVTGeG72pL879ISCzwZdYt30rUPm+H7sN0EQhQ7KlzEzis3f8Df51M707jeliQ
         v16UXMsi4V5IxGdPCRFKgQvAUYOQraiVUIJfF08S/VOq1/otpa91CdrAwqpGK6Y9cqG1
         a8AzynSkHw94HaneBKToOs+XgR0vwjYScyQqHEmB7yJCnZwJ3ouRyoZBhNxkSQaUwcRf
         6XIP/KRj58w8ZUx34ftjZMXji5DyLa5+Wt8qWq70mEXUkD7xrXyXidC3PNhSR3YNc63O
         Xn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758527770; x=1759132570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fOLEn6wbExiWX7ZHkvEGaEspEQHvpxYxacH64/69EaI=;
        b=ENCOqZNXJFDRWY5pMP/7TBWfzf4IjpmRWcPT8b5Rr3ex7uNrKUUmRmrDA713WD7dpN
         lkfIj3Ebb9xFI466lk6oFSdyHX63+WVyePpCeFnqoNdTh1klgyKTM06msiNeWwKeUAGV
         D3vM/1l1c/aVqCiG24gd527KD5Jvxz60ZtKeKc2HsYDPMzIPpWxKrcUAjPMJIdA6Sxkk
         k5mgIzKlTwUKIPn97VVGDTbcKIZ9fclXpdMZfZjDIQ11e/qgJDK+dM3fwm/QFYPep/hi
         QKhbwdhjt5UY4aJjZwb9VqxENV+i7LaoX/FntXHP/fpq58svAuBwHAgs81RtYmjAQ8KU
         NjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn7MgBwiLO7zTcsl8q+/f4IBKgtVsKhQfXYAvrrPr4IhfcI8jkpKD0IIEHAteB4dGxj3ovpfqut5rc9Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLVx+dunZI3If++czHMrJ7la9nxDwF7Cavi3NcYNbnQsArsGe
	a+9ISbVG5oWBABiT8H90pKNd/t2rXsME1Q+On6XCDOHFZLutRPONNx5NbAPHS51GzTc=
X-Gm-Gg: ASbGncuFzXQk6eSwvB5hqCpvUYkRaN+mJnKPSrRou06Aj+PO4CTZnVLyGpNhmLGEdnT
	6We+AlY4TfK9+eNmamSXe3hDXZfcCR00OBTv/FJ+fij1Vpl39y2S/0hUE27HPQ3SIcVxLHfXbJS
	FBx5kXkUxnmkYC7v3HjNvBErgSmsC9+VwYmK/DLjIVTLMVmBrPTH/3ph3tY+G/a0bkbQR4fUCk4
	HMSAKX9zQbJWB01ck8wX4HIdVRqimfD2cdT1Im29Y588+tlsI6nQvq8sT2Z0BkmbXqLXIEpiPA5
	6H8d6X2rP9qq6CrbPfDJCnYyJBV1LIWdkSMycBLUaqPS0Rqm7vx/L0BPEZxNInNSUNU3zpxqH8M
	y7wav2nlR6Ul+7AxPgnc+SnaXdE3id/csOBj3r7X4gZjlqDwiYm4=
X-Google-Smtp-Source: AGHT+IEWHzTu8qZR9GiLSVFONI5X3EclZtypFRTqQ5ScW2UO6ECeFRJ94ii2oT0N3yQZaQcdiH589Q==
X-Received: by 2002:a05:6a21:6d9d:b0:266:1f27:a01e with SMTP id adf61e73a8af0-2926f79d201mr16735986637.39.1758527769805;
        Mon, 22 Sep 2025 00:56:09 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5f867d30sm9103152b3a.38.2025.09.22.00.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 00:56:09 -0700 (PDT)
Message-ID: <28f36249-f064-4d32-9d8a-ba03db5b491c@bytedance.com>
Date: Mon, 22 Sep 2025 15:56:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm: thp: introduce folio_split_queue_lock and its
 variants
To: Zi Yan <ziy@nvidia.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
 <eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch@bytedance.com>
 <E62A91B2-4221-43B2-9C17-1E48AA5D5544@nvidia.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <E62A91B2-4221-43B2-9C17-1E48AA5D5544@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zi,

On 9/19/25 11:39 PM, Zi Yan wrote:
> On 18 Sep 2025, at 23:46, Qi Zheng wrote:
> 
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In future memcg removal, the binding between a folio and a memcg may
>> change, making the split lock within the memcg unstable when held.
>>
>> A new approach is required to reparent the split queue to its parent. This
>> patch starts introducing a unified way to acquire the split lock for
>> future work.
>>
>> It's a code-only refactoring with no functional changes.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/memcontrol.h | 10 +++++
>>   mm/huge_memory.c           | 89 ++++++++++++++++++++++++++------------
>>   2 files changed, 71 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 16fe0306e50ea..99876af13c315 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1662,6 +1662,11 @@ int alloc_shrinker_info(struct mem_cgroup *memcg);
>>   void free_shrinker_info(struct mem_cgroup *memcg);
>>   void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
>>   void reparent_shrinker_deferred(struct mem_cgroup *memcg);
>> +
>> +static inline int shrinker_id(struct shrinker *shrinker)
>> +{
>> +	return shrinker->id;
>> +}
>>   #else
>>   #define mem_cgroup_sockets_enabled 0
>>
>> @@ -1693,6 +1698,11 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg,
>>   				    int nid, int shrinker_id)
>>   {
>>   }
>> +
>> +static inline int shrinker_id(struct shrinker *shrinker)
>> +{
>> +	return -1;
>> +}
>>   #endif
>>
>>   #ifdef CONFIG_MEMCG
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 582628ddf3f33..d34516a22f5bb 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1078,26 +1078,62 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>>
>>   #ifdef CONFIG_MEMCG
>>   static inline
>> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
>> +struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
>> +					   struct deferred_split *queue)
>>   {
>> -	struct mem_cgroup *memcg = folio_memcg(folio);
>> -	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
>> -
>> -	if (memcg)
>> -		return &memcg->deferred_split_queue;
>> -	else
>> -		return &pgdat->deferred_split_queue;
>> +	if (mem_cgroup_disabled())
>> +		return NULL;
>> +	if (&NODE_DATA(folio_nid(folio))->deferred_split_queue == queue)
>> +		return NULL;
>> +	return container_of(queue, struct mem_cgroup, deferred_split_queue);
>>   }
>>   #else
>>   static inline
>> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
>> +struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
>> +					   struct deferred_split *queue)
>>   {
>> -	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
>> -
>> -	return &pgdat->deferred_split_queue;
>> +	return NULL;
>>   }
>>   #endif
>>
>> +static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>> +{
>> +	struct mem_cgroup *memcg;
>> +	struct deferred_split *queue;
>> +
>> +	memcg = folio_memcg(folio);
>> +	queue = memcg ? &memcg->deferred_split_queue :
>> +			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>> +	spin_lock(&queue->split_queue_lock);
>> +
>> +	return queue;
>> +}
>> +
>> +static struct deferred_split *
>> +folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
>> +{
>> +	struct mem_cgroup *memcg;
>> +	struct deferred_split *queue;
>> +
>> +	memcg = folio_memcg(folio);
>> +	queue = memcg ? &memcg->deferred_split_queue :
>> +			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>> +	spin_lock_irqsave(&queue->split_queue_lock, *flags);
>> +
>> +	return queue;
>> +}
> 
> A helper function to get queue from a folio would get rid of duplicated
> code in the two functions above. Hmm, that is the deleted
> get_deferred_split_queue(). So probably retain it.

After PATCH #4, we may retry after getting parent memcg in the above
functions. so we may not need to retrieve get_deferred_split_queue().

> 
> Otherwise, LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks!

> 
> Best Regards,
> Yan, Zi



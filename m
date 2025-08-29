Return-Path: <linux-kernel+bounces-791962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7AFB3BECB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DB01CC1F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483D320CD5;
	Fri, 29 Aug 2025 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCqEjcKE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1F183CC3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479799; cv=none; b=NaZitWD/jGDcVH6rvY6PxI8PdjfEs9Q/AzbZzZ9Koqv502R09jRkNtHTfK1hmLPE8XvqxMMW65lsr372AwVDLRHIQv60l0cnBGKI3xTBq02qFXRtEa76ydXwbezqfKokxqAPmq+gGawI0/OBowOUd5i68cebDenWv+sA/NCkvcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479799; c=relaxed/simple;
	bh=uLYWjpuCn0RXckogAjiEDwxJQT7bPA6aiXCDaOfcSOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RNbWUXIXRkBSq7WGEZmi8nrhSi8exxtuHE+3sfo89XyEkTrfNqRU0jEn+fUy0o7F6VMFXAyR0SPOVnpYiEezNZ1nV9idhFL/nBBqHfxzJ+rrc5aVU514TpswaB0lR90YjX2QpOIY/BB1WWlO3RsZZ5aqDc2Kd7cZ5vXQPU/UCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCqEjcKE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756479797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XNfFvDK/InbGYpz7hUnx7wVGBM0fCoifXZYcngqomxM=;
	b=UCqEjcKEWLN/2x8EQ9WKaqHrNKg0cJ0pqVV+o9V2XGO5Sz/5WVFUDuhnTHMX9h4plGOhwO
	307CruyqWzbg9G1NqKve21VRtw0jmtHG3pvqOV/8f3l/q6tGL98GZK58JFL8UnLdiR/FMm
	k15oLJUybnecBtO0yQQrIO4YgR2hAWQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-cNSr7qF_MESIm-de7IHsVg-1; Fri, 29 Aug 2025 11:03:10 -0400
X-MC-Unique: cNSr7qF_MESIm-de7IHsVg-1
X-Mimecast-MFC-AGG-ID: cNSr7qF_MESIm-de7IHsVg_1756479789
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso14729425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756479789; x=1757084589;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNfFvDK/InbGYpz7hUnx7wVGBM0fCoifXZYcngqomxM=;
        b=D/xmDHoEAscBES1bONfoEUUwPFslzdd74ltapPHqH9twfXzz+MohVE/Ah4wce/C33b
         1vyGpC4NG16Lp5ZHBeGsTWSvpyGB/K2cp6SGVr5KUVS1Ii+dUM2ZwO40T96WRiNCMeB+
         xW/1vqb/efzMdc4tAXYaKo3yxzjq5xe0VxHu05/QueOyd1QRoO+fKj11L4BA5Is9EnoX
         SDN1+4lMf+EN6fyZHd3h43uS0/9Z3HpMwW5Y8O53Dm9U6UUYoq91W9xl/ke2/TUq4HQR
         UaRBRwN9TDeUM7sfcDDeeklMM6uVjjhCJvdTAQNQylHIt1MIZOjdIAvwdKZyyE9fzyZY
         YUMA==
X-Forwarded-Encrypted: i=1; AJvYcCX1FP4hoCCXZ7FyHny7eK0PHKpQqSz5JL+AY2dsTdi40uIkJv3PHrdB99ifcTY1aiFBzFCewIi9a+4nkiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6T0Spl+dhuUFu0uWF6SgA83/P2EAv3tzPl/lNwtO80EZ8zBt3
	ZBvPJs6XNrgYxFSr9Cj47dhpotoY4KNviDwuiqKitP/zYkRjQxgxhMuav/m/z/CQvUVjJhL+nCS
	IdenMG6zvI+xZX1gGUv0JeZBtSQiOilAZuNPNIkogGyvI6/BjmXg9b9RaUFRdDKGJAw==
X-Gm-Gg: ASbGncumc4Mupim+2z7HrglzR//tNnObtdBsVo3L5R1JDTAr3ALEe+EFWx4hFT0petL
	yDVG0JEb8cN7ePhiKaxGpSHoAHvL9QmnpX1dS4pwSGzs5v6lWxJ1ooO4SLbL8YO2503IU6FansU
	1k1bkUTvdUcPaN4XqfV7jpaRI8PLX5TDMKyM000Z/Z7YsOc52hW8JM/5UKebr21Enhg1tQLpW49
	4Cr3h+xHA+3yypyCgSg+EGP+xtf80+ZJt8hm1Jq5I2tfk5GbbQROv6qZOsmy0I+cGgNQbZXyaYl
	sweoM8X3qEHJu8EAdVB3BUDmWb0sZL90ym2KS1GQsQZtfXuDRwsE3rv1bpZTqoUh8zQ6pVHaKVX
	4cRohH60Q/PzHfG5yDlwglEV5E/7bycibmNja4wqLftBFEajuQKeCzMn2+tPofv8y
X-Received: by 2002:a05:600c:46cd:b0:45b:75d6:73c5 with SMTP id 5b1f17b1804b1-45b7631191emr63877225e9.18.1756479788994;
        Fri, 29 Aug 2025 08:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGikMHhze19oU7j9Z8WXvy9UKdfjn+TUWuWpcko8WMcBWDfVJcAonsPeRL4wy1QqmkB93j00w==
X-Received: by 2002:a05:600c:46cd:b0:45b:75d6:73c5 with SMTP id 5b1f17b1804b1-45b7631191emr63876935e9.18.1756479788506;
        Fri, 29 Aug 2025 08:03:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:100:4f8e:bb13:c3c7:f854? (p200300d82f1d01004f8ebb13c3c7f854.dip0.t-ipconnect.de. [2003:d8:2f1d:100:4f8e:bb13:c3c7:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66b6985bsm87177855e9.2.2025.08.29.08.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 08:03:07 -0700 (PDT)
Message-ID: <8a6c0cca-c0cf-4511-86f0-df0b9e2c179b@redhat.com>
Date: Fri, 29 Aug 2025 17:03:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v3] mm/hugetlb: Retry to allocate for early boot hugepage
 allocation
To: lirongqing <lirongqing@baidu.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, giorgitchankvetadze1997@gmail.com
References: <20250829095241.2651-1-lirongqing@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250829095241.2651-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.08.25 11:52, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In cloud environments with massive hugepage reservations (95%+ of system
> RAM), single-attempt allocation during early boot often fails due to
> memory pressure.
> 
> Commit 91f386bf0772 ("hugetlb: batch freeing of vmemmap pages") intensified
> this by deferring page frees, increase peak memory usage during allocation.
> 
> Introduce a retry mechanism that leverages vmemmap optimization reclaim
> (~1.6% memory) when available. Upon initial allocation failure, the system
> retries until successful or no further progress is made, ensuring reliable
> hugepage allocation while preserving batched vmemmap freeing benefits.
> 
> Testing on a 256G machine allocating 252G of hugepages:
> Before: 128056/129024 hugepages allocated
> After:  Successfully allocated all 129024 hugepages
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v2: auto retry mechanism
> Diff with v1: add log if two-phase hugepage allocation is triggered
> 		add the knod to control split ratio
> 
>   mm/hugetlb.c | 27 +++++++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 753f99b..18e54ea 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3589,10 +3589,9 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
>   
>   	unsigned long jiffies_start;
>   	unsigned long jiffies_end;
> +	unsigned long remaining;
>   
>   	job.thread_fn	= hugetlb_pages_alloc_boot_node;
> -	job.start	= 0;
> -	job.size	= h->max_huge_pages;
>   
>   	/*
>   	 * job.max_threads is 25% of the available cpu threads by default.
> @@ -3616,10 +3615,30 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
>   	}
>   
>   	job.max_threads	= hugepage_allocation_threads;
> -	job.min_chunk	= h->max_huge_pages / hugepage_allocation_threads;
>   
>   	jiffies_start = jiffies;
> -	padata_do_multithreaded(&job);
> +	do {
> +		remaining = h->max_huge_pages - h->nr_huge_pages;
> +
> +		job.start     = h->nr_huge_pages;
> +		job.size      = remaining;
> +		job.min_chunk = remaining / hugepage_allocation_threads;
> +		padata_do_multithreaded(&job);
> +
> +		if (h->nr_huge_pages == h->max_huge_pages)
> +			break;
> +
> +		/*
> +		 * Retry allocation if vmemmap optimization is available, the
> +		 * optimization frees ~1.6% of memory of hugepages, this reclaimed
> +		 * memory enables additional hugepage allocations

As I said, please remove any calculation details about the vmemmap. 
That's not the place to have such calculations easily become stale.

Something like the following:

/*
  * Retry only if the vmemmap optimization might have been able to free
  * some memory back to the system.
  */

> +		 */
> +		if (!hugetlb_vmemmap_optimizable(h))
> +			break;
> +
> +	/* Continue if progress was made in last iteration */

Comment wrongly indented.

> +	} while (remaining != (h->max_huge_pages - h->nr_huge_pages));

Why would you want to retry if you allocated all pages (IOW the common 
case)?

E.g.,

remaining == 1
h->max_huge_pages == 1
h->nr_huge_pages == 1

while (1 != 1 -1) -> while (1 != 0)


you should probably do

do {
	...
	
	/* Stop if there is no progress */
	if (remaining == h->max_huge_pages - h->nr_huge_pages)
		break;
} (h->max_huge_pages != h->nr_huge_pages);

-- 
Cheers

David / dhildenb



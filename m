Return-Path: <linux-kernel+bounces-786793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F63B36A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5366EA00A76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B2434DCE8;
	Tue, 26 Aug 2025 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjZGSZ8W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191512FF64C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218167; cv=none; b=NUs9BYf/pzqJKGbWHMEtsOwvKvfr8I/p9e6SftJUgcvF4z/VECLkLdXNWUOShbBaKUVEoBwV9KqF+Rxs2dbjzfiYzh/G5J6Br98Gv8N7cx06ZCOTPG8Lr9ptppdeZ8UTkOltGEc1wsFL8pHJVOZtLjB4Ot3jZNtDMAhw5l9up4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218167; c=relaxed/simple;
	bh=75gxLLZWMDA7GQc1jZj6uicFdGhMJDgcWUhcPZfIw48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPVZoL6IwWZ1ILYsvfSC/kJpTshPG9x2jemLw6E4lc6x+rctyZQiHu8ZTqS2Psdtocga1StCvz9kCR8sjXZDVmGElKYdtULIjOCO/io4RDreqYHHARgngCHJEoJ20vGhf6Q+MPhbZFlduijaFpVe53/WJpJXT0eweEd1XZoKJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjZGSZ8W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756218165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h39i1jZswq+DsNG6K29l9TcQzwNCCY98bFn/fI62p0M=;
	b=NjZGSZ8WoGrTDqtD1D1R2sedcCNgCBRsQHMjDQUV2hWOCjSyoZ2onj0LTDot3UWOVLP2PO
	L9dacWephzdHNq77KkCry6bBFzkJ7ZjB6L7lWrOVxn6n/ruEpTmf+bkmcy3Nt8TRAX0+oK
	yK7f6QV2ggpua1dP+0zWkl7B+K43tOM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-uL49xH5KPtCWQyL64jwAjw-1; Tue, 26 Aug 2025 10:22:43 -0400
X-MC-Unique: uL49xH5KPtCWQyL64jwAjw-1
X-Mimecast-MFC-AGG-ID: uL49xH5KPtCWQyL64jwAjw_1756218162
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c79f0a6050so1402286f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218162; x=1756822962;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h39i1jZswq+DsNG6K29l9TcQzwNCCY98bFn/fI62p0M=;
        b=bMWpsrG8o6CYwach3Wk1+iJbC8SBOJcsMjyGIcl0VX4VjVSKa45HXgwphX1gnbRJ4Y
         L91QEgEaNMaS8lubUiAYyJ19LxPZ6WB+rovSgRbJ3yPA4TbeBSssPPmMN7gRV2pNw9d/
         vwMMKiy+E09aJDTo1woYVMVWDAJIc4IhoOlxlCZZ9xUNtXqCwDL8Ep/w5RSPPLVmLTtv
         eOIuoIBWpiVnVOF4EuX0A6ubXCnrTCShs314705QKSnrazs4xJr0+PFxqnYhm+e8v78V
         v9qRQM4gjJir/YhIcGEl0Kr0lBoQfmJ4GCa+3TwJGLd4aQtS6XVRaIpguGL/tq8IONTh
         8DPg==
X-Forwarded-Encrypted: i=1; AJvYcCUNcqtVObf8GKncfGn/HJXuMHE9XUKiYBDPeuC0dRQsVnMEW/AOWBFfkAsSXYGXDLIqAmutDZLwrA8zj3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuML47JhsuN0i8an1HHkNsK2ltv5sV4j8rvL2jrdVb5CdpzfL
	iZdmo95zToNN8xDKGUo1ul0T404Lg3Do7NnX8ULhFW8X6j7GarGm0V5TYrbm1qe2D0J9ChbUxHw
	K96m7GVCctPgmNZl15YW/Zgkxor9tCqCGuc0CkE4PkbBCVOLNBZcs/tcnq+VerO6Y4A==
X-Gm-Gg: ASbGncuTM66L5RiB0XjQMqa42e1zWtllLZGn4cKk7FEVIsJ6mAt+MbtaAQq6J8Kr2Y3
	uctJfqutV/E/1e61qfeafRcntsvEFugNbcr7Jkw8MZ8t+NzWlGFxsM93/z8zCIf29OrLFNXa3Fl
	bHY9t06WbnZP6urGJibjS7gElMshRRJKc7hnasEs7focMluaJVcAHkm771JQdngZOLs/u3ZsIQN
	6XjeQhVdsI2c+J6sWoeGxOJWRK6XZVsA3hZiAigItFEAonJKFW9o1Y/7+A7Lg1BKHE5Dw1d9YPm
	5mga7jacbluKlxrB0omdTzvy3mA2lNodhWro5Y5k8+O0szqjeFsx1gazjBScY9XxOThPVfa+NA=
	=
X-Received: by 2002:a05:6000:18ad:b0:3b7:940e:6529 with SMTP id ffacd0b85a97d-3c5da73ee7bmr12909620f8f.10.1756218162329;
        Tue, 26 Aug 2025 07:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoilF3OQdCbMR7mv9ylZSZkZgVzsErxb/ICdf5VRA2VO3gRqFa7W9pSbkINxHmbx1/dDo64A==
X-Received: by 2002:a05:6000:18ad:b0:3b7:940e:6529 with SMTP id ffacd0b85a97d-3c5da73ee7bmr12909579f8f.10.1756218161800;
        Tue, 26 Aug 2025 07:22:41 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711d9f3a8sm16439115f8f.62.2025.08.26.07.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 07:22:41 -0700 (PDT)
Message-ID: <54bfb6c0-eb35-4e53-ab45-04139623abb0@redhat.com>
Date: Tue, 26 Aug 2025 16:22:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 01/11] mm/zone_device: support large zone device private
 folios
To: Balbir Singh <balbirs@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250812024036.690064-1-balbirs@nvidia.com>
 <20250812024036.690064-2-balbirs@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250812024036.690064-2-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.25 04:40, Balbir Singh wrote:
> Add routines to support allocation of large order zone device folios
> and helper functions for zone device folios, to check if a folio is
> device private and helpers for setting zone device data.
> 
> When large folios are used, the existing page_free() callback in
> pgmap is called when the folio is freed, this is true for both
> PAGE_SIZE and higher order pages.
> 
> Zone device private large folios do not support deferred split and
> scan like normal THP folios.

[...]


>   #else
>   static inline void *devm_memremap_pages(struct device *dev,
>   		struct dev_pagemap *pgmap)
> diff --git a/mm/memremap.c b/mm/memremap.c
> index b0ce0d8254bd..13e87dd743ad 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -427,20 +427,19 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
>   void free_zone_device_folio(struct folio *folio)
>   {
>   	struct dev_pagemap *pgmap = folio->pgmap;
> +	unsigned long nr = folio_nr_pages(folio);
> +	int i;

Not that it will currently matter much but

unsigned long i, nr = folio_nr_pages(folio);

might be more consistent

>   
>   	if (WARN_ON_ONCE(!pgmap))
>   		return;
>   
>   	mem_cgroup_uncharge(folio);
>   
> -	/*
> -	 * Note: we don't expect anonymous compound pages yet. Once supported
> -	 * and we could PTE-map them similar to THP, we'd have to clear
> -	 * PG_anon_exclusive on all tail pages.
> -	 */
>   	if (folio_test_anon(folio)) {
> -		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> -		__ClearPageAnonExclusive(folio_page(folio, 0));
> +		for (i = 0; i < nr; i++)
> +			__ClearPageAnonExclusive(folio_page(folio, i));
> +	} else {
> +		VM_WARN_ON_ONCE(folio_test_large(folio));
>   	}
>   
>   	/*
> @@ -464,11 +463,15 @@ void free_zone_device_folio(struct folio *folio)
>   
>   	switch (pgmap->type) {
>   	case MEMORY_DEVICE_PRIVATE:

Why are you effectively dropping the

if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->page_free))

> +		percpu_ref_put_many(&folio->pgmap->ref, nr);
> +		pgmap->ops->page_free(&folio->page);


> +		folio->page.mapping = NULL;

Why are we adding this here? Does not seem large-folio specific.

> +		break;
>   	case MEMORY_DEVICE_COHERENT:
>   		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->page_free))
>   			break;
> -		pgmap->ops->page_free(folio_page(folio, 0));
> -		put_dev_pagemap(pgmap);
> +		pgmap->ops->page_free(&folio->page);
> +		percpu_ref_put(&folio->pgmap->ref);

This looks like an independent change that does not belong in this patch.


Can't you just leave the code as is and simply convert percpu_ref_put
to percpu_ref_put_many()? What am I missing?

>   		break;
>   
>   	case MEMORY_DEVICE_GENERIC:
> @@ -491,14 +494,23 @@ void free_zone_device_folio(struct folio *folio)
>   	}
>   }
>   
> -void zone_device_page_init(struct page *page)
> +void zone_device_folio_init(struct folio *folio, unsigned int order)
>   {
> +	struct page *page = folio_page(folio, 0);
> +
> +	VM_WARN_ON_ONCE(order > MAX_ORDER_NR_PAGES);

order vs. pages is wrong.

In context of [1] this should probably be

	VM_WARN_ON_ONCE(order > MAX_FOLIO_ORDER);

And before that is in

	VM_WARN_ON_ONCE((1u << order) > MAX_FOLIO_NR_PAGES);

because we don't involve the buddy, so likely buddy limits do not apply.

[1] https://lore.kernel.org/all/20250821200701.1329277-1-david@redhat.com/

> +
>   	/*
>   	 * Drivers shouldn't be allocating pages after calling
>   	 * memunmap_pages().
>   	 */
> -	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_pgmap(page)->ref));
> -	set_page_count(page, 1);
> +	WARN_ON_ONCE(!percpu_ref_tryget_many(&page_pgmap(page)->ref, 1 << order));
> +	folio_set_count(folio, 1);
>   	lock_page(page);
> +
> +	if (order > 1) {
> +		prep_compound_page(page, order);
> +		folio_set_large_rmappable(folio);
> +	}
>   }
> -EXPORT_SYMBOL_GPL(zone_device_page_init);
> +EXPORT_SYMBOL_GPL(zone_device_folio_init);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 568198e9efc2..b5837075b6e0 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1769,9 +1769,13 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   	 * the folio is unmapped and at least one page is still mapped.
>   	 *
>   	 * Check partially_mapped first to ensure it is a large folio.
> +	 *
> +	 * Device private folios do not support deferred splitting and
> +	 * shrinker based scanning of the folios to free.
>   	 */
>   	if (partially_mapped && folio_test_anon(folio) &&
> -	    !folio_test_partially_mapped(folio))
> +	    !folio_test_partially_mapped(folio) &&
> +		!folio_is_device_private(folio))

Please indent like the previous line.

if (partially_mapped && folio_test_anon(folio) &&
    !folio_test_partially_mapped(folio) &&
    !folio_is_device_private(folio))

>   		deferred_split_folio(folio, true);
>   
>   	__folio_mod_stat(folio, -nr, -nr_pmdmapped);


-- 
Cheers

David / dhildenb



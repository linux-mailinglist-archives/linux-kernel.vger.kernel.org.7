Return-Path: <linux-kernel+bounces-750513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BADB15D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661774E5AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534AE1E25E1;
	Wed, 30 Jul 2025 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxvADw85"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916E20E6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869020; cv=none; b=sHZaGmpdXQvRAB8qHRyx6rDDiPr7Gxd5XleitCwbQDCj+ZrsjcYOMyLdj8wi2lV9ccYt81qHpU9tKOvMUVDDjn5h4E6+hEIRPWAScTPEEj66BFwDWDdBcuqxs/EDgLhiH8DxhHtZKnLyf28XSHZ5jnyxzatW4FHaltyez2r8tYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869020; c=relaxed/simple;
	bh=cN11rKI0/8XSSZmz95B2+qKT1Lg0iuvLYP4HazSN5AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpjskvMJpI4z4AHknivzsd8z9E42mFodDtLJoXIlW4a7kXFhoWGexTAB+UKFkSseVgcrwnJJdCDw8QmLPs6VRrOR7ehjVLPwmVORfogB0LUrEp6CD4mkTWMdU985XulgFSqUg43oAHb9OQk1nC45Sn3QgWPEDM7RE4noH0ffXOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxvADw85; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753869017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QUgKZRVMDl3NhvMSN0LsfGZHWOZBeE6am+rhVof/Ejg=;
	b=dxvADw85FkbCKmr94h7fM/lhIXo9RGzULYDTDRVxUL0PYcd7sPOCxndbNR+nE0JE3SeJDt
	1YfjJN8PhrG3MJkWBnnRE4zGzm6k1tMtiyc7NBG8yJJ9h35ZvWtv96xwAmGvdpqiVHYbsk
	vx3vgBf7TR9Mx6059Z5RE9frHr98Sek=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-YxVENy85MomQ5uh3C6nYSQ-1; Wed, 30 Jul 2025 05:50:15 -0400
X-MC-Unique: YxVENy85MomQ5uh3C6nYSQ-1
X-Mimecast-MFC-AGG-ID: YxVENy85MomQ5uh3C6nYSQ_1753869015
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b79629bd88so287813f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753869015; x=1754473815;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QUgKZRVMDl3NhvMSN0LsfGZHWOZBeE6am+rhVof/Ejg=;
        b=Hzj3uR2ytY3KxLXyLtL5U/i3eQbuCgYozzUAZD41QkvbAebuxHHzzLhSdLQDoQB2Mc
         e4+BUs9GDm1Pib5zAsSlbdKOjwevZn+hCkwgECGHKCT7L24dksB23VY4aUETdYkgHkz0
         1LrLWbmlnQD7i3HaIJO1xHBnn2o/snQq4qSew2/QybKmEhBfxlc3kox87I5rX0Ugq0qQ
         uID+pma803RR49Ti8BmCwuwyTxqcoXjX0AP16oH7EMnfHSeLD9G6EVov3wmKHmIhpwKJ
         MVJySxbveQTt5zmkMjPPL8lZ793XtPeaKkxMOM+zFz4//pF4gOLf2xM2rgqtiHGxhQiQ
         /aMA==
X-Gm-Message-State: AOJu0YwBRnaeZfukfvvONDWqr9TZOyXvpnLVCuK29SEn5DxadPc9v+H5
	76WwFzUequblxHX6BX1pV6QtTgGZR6IWmqx267yzphHj215LDhj5G86y3yp3gTvCFLLf0JKEVbz
	OJTXiSkp3Q3RN0lUI8daJENUxD6CeDHRfaKY4jKJI8wXFU9w99h+H9lauB6WIOX2s+w==
X-Gm-Gg: ASbGncvwMWAhvTPL9lL1qS+RUXlHDhsInE8j0VTdgIfBmLmO9t2DuBml0nHRbot7p7i
	rNETK1/39sOl2EdvhDP+42NBReGP/uOXzNUw8IeR08cN8Qz4ASxa5/22yz8FyvVyEOCxC2k0wQw
	if74exlRIBjh3H1PsefQQcPwrrf4aufDyybM0IW6xgifJR8ABKlNjyDb72IXcD6D1IeU5gqMZZG
	DdJ7eL9EukwxNGZymdYUCZ/zLanujMJxxobKAiZci6n/hgyrXt4AyNiI19xcuY3FaEMPcmEXYMj
	I5RxuxURcuVG6/2B0cV+rdN+xKw1wpWMGmwrje0vQHN70D5+Uaw+H+9GB6YaDQ==
X-Received: by 2002:a05:6000:2212:b0:3b7:944d:e5e6 with SMTP id ffacd0b85a97d-3b794ff1593mr1943249f8f.36.1753869014484;
        Wed, 30 Jul 2025 02:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqBKdJ+PU+n21Ilgc5DHwWl9Q+AlsJ7MBOHJX8HsuwQakd63Pz2XTTFoHVvEo2YgYITY4RRw==
X-Received: by 2002:a05:6000:2212:b0:3b7:944d:e5e6 with SMTP id ffacd0b85a97d-3b794ff1593mr1943199f8f.36.1753869013969;
        Wed, 30 Jul 2025 02:50:13 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b788f5f255sm9239196f8f.13.2025.07.30.02.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 02:50:13 -0700 (PDT)
Message-ID: <dbebbba0-3c59-4ee1-b32c-4b9f6ed90d92@redhat.com>
Date: Wed, 30 Jul 2025 11:50:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 01/11] mm/zone_device: support large zone device private
 folios
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>,
 Ralph Campbell <rcampbell@nvidia.com>, =?UTF-8?Q?Mika_Penttil=C3=A4?=
 <mpenttil@redhat.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-2-balbirs@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250730092139.3890844-2-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.07.25 11:21, Balbir Singh wrote:
> Add routines to support allocation of large order zone device folios
> and helper functions for zone device folios, to check if a folio is
> device private and helpers for setting zone device data.
> 
> When large folios are used, the existing page_free() callback in
> pgmap is called when the folio is freed, this is true for both
> PAGE_SIZE and higher order pages.
> 
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
> 
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>   include/linux/memremap.h | 10 ++++++++-
>   mm/memremap.c            | 48 +++++++++++++++++++++++++++++-----------
>   2 files changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 4aa151914eab..a0723b35eeaa 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -199,7 +199,7 @@ static inline bool folio_is_fsdax(const struct folio *folio)
>   }
>   
>   #ifdef CONFIG_ZONE_DEVICE
> -void zone_device_page_init(struct page *page);
> +void zone_device_folio_init(struct folio *folio, unsigned int order);
>   void *memremap_pages(struct dev_pagemap *pgmap, int nid);
>   void memunmap_pages(struct dev_pagemap *pgmap);
>   void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
> @@ -209,6 +209,14 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>   bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
>   
>   unsigned long memremap_compat_align(void);
> +
> +static inline void zone_device_page_init(struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +
> +	zone_device_folio_init(folio, 0);
> +}
> +
>   #else
>   static inline void *devm_memremap_pages(struct device *dev,
>   		struct dev_pagemap *pgmap)
> diff --git a/mm/memremap.c b/mm/memremap.c
> index b0ce0d8254bd..3ca136e7455e 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -427,20 +427,19 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
>   void free_zone_device_folio(struct folio *folio)
>   {
>   	struct dev_pagemap *pgmap = folio->pgmap;
> +	unsigned int nr = folio_nr_pages(folio);
> +	int i;

"unsigned long" is to be future-proof.

(folio_nr_pages() returns long and probably soon unsigned long)

[ I'd probably all it "nr_pages" ]

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
> @@ -464,11 +463,20 @@ void free_zone_device_folio(struct folio *folio)
>   
>   	switch (pgmap->type) {
>   	case MEMORY_DEVICE_PRIVATE:
> +		if (folio_test_large(folio)) {

Could do "nr > 1" if we already have that value around.

> +			folio_unqueue_deferred_split(folio);

I think I asked that already but maybe missed the reply: Should these 
folios ever be added to the deferred split queue and is there any value 
in splitting them under memory pressure in the shrinker?

My gut feeling is "No", because the buddy cannot make use of these 
folios, but maybe there is an interesting case where we want that behavior?

> +
> +			percpu_ref_put_many(&folio->pgmap->ref, nr - 1);
> +		}
> +		pgmap->ops->page_free(&folio->page);
> +		percpu_ref_put(&folio->pgmap->ref);

Coold you simply do a

	percpu_ref_put_many(&folio->pgmap->ref, nr);

here, or would that be problematic?

> +		folio->page.mapping = NULL;
> +		break;
>   	case MEMORY_DEVICE_COHERENT:
>   		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->page_free))
>   			break;
> -		pgmap->ops->page_free(folio_page(folio, 0));
> -		put_dev_pagemap(pgmap);
> +		pgmap->ops->page_free(&folio->page);
> +		percpu_ref_put(&folio->pgmap->ref);
>   		break;
>   
>   	case MEMORY_DEVICE_GENERIC:
> @@ -491,14 +499,28 @@ void free_zone_device_folio(struct folio *folio)
>   	}
>   }
>   
> -void zone_device_page_init(struct page *page)
> +void zone_device_folio_init(struct folio *folio, unsigned int order)
>   {
> +	struct page *page = folio_page(folio, 0);
> +
> +	VM_WARN_ON_ONCE(order > MAX_ORDER_NR_PAGES);
> +
> +	/*
> +	 * Only PMD level migration is supported for THP migration
> +	 */

Talking about something that does not exist yet (and is very specific) 
sounds a bit weird.

Should this go into a different patch, or could we rephrase the comment 
to be a bit more generic?

In this patch here, nothing would really object to "order" being 
intermediate.

(also, this is a device_private limitation? shouldn't that check go 
somehwere where we can perform this device-private limitation check?)

> +	WARN_ON_ONCE(order && order != HPAGE_PMD_ORDER);
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


-- 
Cheers,

David / dhildenb



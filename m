Return-Path: <linux-kernel+bounces-759271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA88B1DB4C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD0CE7A9B84
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608D26CE2E;
	Thu,  7 Aug 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCCGH98n"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6326CE14
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582774; cv=none; b=Ael/p0OrLk2+yUpMxGZqh+va9DteOJIVE6xRQVV+gNBlimx7K2YV/H/9qqEhVfbmh8bbOz9/hSBh1gN5eK4stInQMFmKDFLF1+QraNsQVIY92D6lFV4txKRtMiq9+lOzO3TBQM0PMHKJHC01EKalJi15W3M0cQcfEFbSBIx0Ftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582774; c=relaxed/simple;
	bh=m5OD47T9u28wJPFJNjugDG/Ks8NrQrnQw4IC+UnaYEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWeMJRP0DHZD5yFMxSBRG9zMZF39Ex1OIZhQ6EGKVDLVap1iaOUFcrc+cbbAQTOh1sEXQQjwk7Jgxa6X7n2zy0DHYEkf1N/BLIPIKYpze1LqFkGMNvbrf87sObjXYyI9DvVUfVuAS6BhqSbJTQS57FA0sC+r13NEoyp3sVw1dTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCCGH98n; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-332341d99dbso1800881fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754582771; x=1755187571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJBjqu3YD7XRAedLpR3J+C+OqUxVoJiaJAbOSselMEQ=;
        b=TCCGH98nk240nj9GKhvdnpPMyhI6M9mfIU0zpTAI87VPvoCwr6vvJmgs5mMeZqJPIW
         I/t0JVBizifPV74tXY5ua3w5nBrizpAdnat9znysMvX9LrsYfQ0ryK+TQKbSuPWQO0mj
         c2rwZTfTe6+6RFNQjGQACk4Fbj1OBOJHug889EP54qXbFK/6xhWwEpFnuTHTPBWaghEY
         bslT0rUNI6YpXATkC0BC1VcEzTB0gn6aabwuQym6bLIT2sxwUfZkfd1j9zQ2bbqs9T1n
         rI5eJbuPf04UFATrStVHjNMf2DxRaomBqmH7aaw+f+mvc53WvrRDBur9RavpXnrm27ZX
         ojGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582771; x=1755187571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJBjqu3YD7XRAedLpR3J+C+OqUxVoJiaJAbOSselMEQ=;
        b=RK2/woPoLeXr8cMioWW8LzT/rSyn3rEJdn0dxX9TIPzS7gRmYSW+AAe8WGY22Gkfxd
         dghrhskLS4hzQmazDYMJGDXp0zcRO9aYjo3UvVn0utReuy70vkvVUlsBVAbhlLkvTACr
         v0PuvhqbHveoCCzvmNltFzSbFl+o6MIrApOyC+VDb2g1YkNT5nk/XVWrKivf9GUa2c3D
         p2uBVtK3/2WeAt7u8GWZSG8QBjXgKRlCe2gGOkfd6CsQfURGFn0espw+rFcWRJ3tSMEF
         8Qoq17+1sCsp9JUQLgjqXfWg6p5kugsQAjsOUiVhM6a1ROw8yhgSOsh0WOTK7STY1GfR
         ePTA==
X-Forwarded-Encrypted: i=1; AJvYcCX67blLQIiNjd2hPlVRDaiCZ7v18MR+xNIDOicNnFjFtXQ1Vr1CScwqNs4p017NYRegAbxpPUCouEV8w+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQknFCheA01R0HmlQf4HUVvwSuDFHL+TN4F/y91Zo1TNiWQ7XY
	yJpWimt4kiV55Nd1J902THQ7cvQEsoxoyVIlt24ZFDQqICw1/nUEm2y4
X-Gm-Gg: ASbGncsbcvvOqquNSOhsKGvmM/Apwucmk2W9p9ea7LA6cNWHIg0BCexqcttI4ppJiPP
	LZDr0cy2/WSf2I2oZi/mxBlRPgf+HI0uJf77LLR67wzMICoSnAARJHQgS/fib/JQ3LDr/tCFv7j
	kmQ4UAi+ptKkkJFk5ISNHT86D5B+etfZEe/nXTnGZyvB8ZNIoLc9AEQFTWFFlUqzOZ1q/gAWtKj
	OcYHcQa5NcOyWBwzvtsVRFDBopZAqDlj/t8cC1IkN45xB5CQ8G1CNJ3zbXUzygkGsSxf1YwvETS
	i2EXdZLu3ptDpM8aSmmW97Ub0DlHEEAV1an89wJ+8HG1sXVe0GiV5p3qcso1PYc4kB73k5s1pSe
	isxMdOciJL+kdHRRRMKlYTrUQtIUd
X-Google-Smtp-Source: AGHT+IFHF81LeQAj8VhkvZSN48lQMwN14izUC9rPxv1TIYTDZL9tj4CKnu9CWhEAPd3obwD23VnlvQ==
X-Received: by 2002:a05:651c:4112:20b0:32a:714c:12c4 with SMTP id 38308e7fff4ca-333812151c8mr5823071fa.1.1754582770692;
        Thu, 07 Aug 2025 09:06:10 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332388d87ebsm26736341fa.55.2025.08.07.09.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 09:06:10 -0700 (PDT)
Message-ID: <0d24f6b7-0e4c-4879-87f2-e31ad988baad@gmail.com>
Date: Thu, 7 Aug 2025 18:05:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm/kasan, mm/vmalloc: Respect GFP flags in
 kasan_populate_vmalloc()
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Alexander Potapenko <glider@google.com>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-6-urezki@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250807075810.358714-6-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/7/25 9:58 AM, Uladzislau Rezki (Sony) wrote:

> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index d2c70cd2afb1..5edfc1f6b53e 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -335,13 +335,13 @@ static void ___free_pages_bulk(struct page **pages, int nr_pages)
>  	}
>  }
>  
> -static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
> +static int ___alloc_pages_bulk(struct page **pages, int nr_pages, gfp_t gfp_mask)
>  {
>  	unsigned long nr_populated, nr_total = nr_pages;
>  	struct page **page_array = pages;
>  
>  	while (nr_pages) {
> -		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
> +		nr_populated = alloc_pages_bulk(gfp_mask, nr_pages, pages);
>  		if (!nr_populated) {
>  			___free_pages_bulk(page_array, nr_total - nr_pages);
>  			return -ENOMEM;
> @@ -353,25 +353,33 @@ static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
>  	return 0;
>  }
>  
> -static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
> +static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_t gfp_mask)
>  {
>  	unsigned long nr_pages, nr_total = PFN_UP(end - start);
> +	bool noblock = !gfpflags_allow_blocking(gfp_mask);
>  	struct vmalloc_populate_data data;
> +	unsigned int flags;
>  	int ret = 0;

gfp_mask = (gfp_mask & GFP_RECLAIM_MASK);


But it might be better to do this in alloc_vmap_area().
In alloc_vmap_area() we have this:

retry:
	if (IS_ERR_VALUE(addr)) {
		preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);

which probably needs GFP_RECLAIM_MASK too.

>  
> -	data.pages = (struct page **)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	data.pages = (struct page **)__get_free_page(gfp_mask | __GFP_ZERO);
>  	if (!data.pages)
>  		return -ENOMEM;
>  
>  	while (nr_total) {
>  		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
> -		ret = ___alloc_pages_bulk(data.pages, nr_pages);
> +		ret = ___alloc_pages_bulk(data.pages, nr_pages, gfp_mask);
>  		if (ret)
>  			break;
>  
>  		data.start = start;
> +		if (noblock)
> +			flags = memalloc_noreclaim_save();
> +


This should be the same as in __vmalloc_area_node():

	if (noblock)
		flags = memalloc_noreclaim_save();
	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
 		flags = memalloc_nofs_save();
 	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
 		flags = memalloc_noio_save();


It would be better to fix noio/nofs stuff first with separate patch, as it's
bug and needs cc stable. And add support for noblock in follow up.

It might be a good idea to consolidate such logic in separate function,
memalloc_save(gfp_mask)/memalloc_restore(gfp_mask, flags) ?

>  		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
>  					  kasan_populate_vmalloc_pte, &data);
> +		if (noblock)
> +			memalloc_noreclaim_restore(flags);
> +
>  		___free_pages_bulk(data.pages, nr_pages);
>  		if (ret)


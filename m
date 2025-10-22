Return-Path: <linux-kernel+bounces-865669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F27EBFDB55
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA37A50579E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B92DCBF2;
	Wed, 22 Oct 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIiHRXMB"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE92C08CD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155427; cv=none; b=OsceY6z08OcTyYSCN6qtYaknpl9RQ5W2ooVL1Y00xfgwo4HcTG3AbpbogsZERSjYDDMydocO3QHtdJBnTAazOY/oiPj8ZsvRBEja4oUQ5/I1jB7rBrebUTLAc1C4I4qCQDkGA2sLf75Zmx6o21wXZyq9qLPp4oFtbSaKxc+JWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155427; c=relaxed/simple;
	bh=o8xFt3YqzifqKsyJBGB27U8y3wdOe85Gf5RuV0Urk9M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWBF0CgUoW568UDQ3tmO0T3W3kZ9d9DJ09Rg9dQAhSGt711+EL9sA/PRXyHMv/RdUQvueRjNro9a7Wsb8HT8APP8KCFdxJLU7dhZEJHoIcobNo8Vs1ZQrQQsXzA9EltqGwNJEr985e3ZIrmYx6R8Jabzdm1vb3PlyfR9QDaFpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIiHRXMB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57e36125e8aso6780077e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761155424; x=1761760224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj7KPYHen4iD4FElTa0Z8YdaUj+MGLwuw15fxyPIN/c=;
        b=eIiHRXMBrg0IWcpeWS6ZEv0wHgvGnGhHolRF6Yq8fYbKOkTbjo/EDjFrFy1UQNBi+H
         u9Oi5aRIaszMTx3XgXYSBD1CE8dPmlQ7VIACETzERvuYQ69S7Jh+UjzwzxpwZZQAYfc2
         JQVUJhKbpXnELpPGSHkaWmM2JMDcVt0jaVPUj6oPwobrCyOT/Z59qSgq7j4e5F0PJGq6
         b26Sz+TT9YSuMV1CVrPN4X2qT6u/Ug8rWTmZ6EbOe7tZkDR0Td76pMsQ5X4g2gofpJPz
         gRo7OnpMIDAHJzMqXesZbViDKeW+FnMtO/DE9hVknkXJh2GMKuO52g8XCprvIBYeuXo1
         YCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155424; x=1761760224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj7KPYHen4iD4FElTa0Z8YdaUj+MGLwuw15fxyPIN/c=;
        b=uUKtiFSmpmFSUsPICXvLbzlKKQk/3kz66Um1wbRMXEiXR6x0iXDMKWxxxSsWjhIv0x
         O2Q2d59/xsZmsvqXmTyEBe01MfJJyBKtHvucAdiPDmdf+1pvYZ1mGQqGHgQLMlBSnugX
         8gIKmRmh/GkbD6KFhHZB5uaGWht+5RHZwNVVz+URsc+WnIGnf6KK7Gev6RKIkxeAVqBt
         hFTxdAa7s1PhSHwcrMXssSZZiRGZG2JqTdXrss5XBlXs0qB5DYWSl0pLkpa6Fu4iu/QT
         ZEu4KokfwrTbetVO7DrkIxbuwceDzH2IhcILaOLOdxinNGJpwkqAS+TWPlitvegZBAuf
         75WQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9MyKM5YevNFxTdekmgAhjBPH6QstZysYXCZNzklX1RtXaC1zHyxSMAM97q2sxkgukgJGNclEUHZSGJho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Q2oPpAP0d07jHfIqeQ9eics6AybxSRUH+KuCLuD5nJpbRa/k
	wqxO+jM3V2MXjpeCQF+RuTAH0yTE+L15KfRLbw+ZH2fnivpKu3X3ZsTN
X-Gm-Gg: ASbGncuAJTjXZ/lp8DyiMT/gBLYJ0bHMFjJZ81XXFBGMWwQlUI657A9BSZPaPQvrUMr
	HLsnb4m5oPi8rIzrm26RjSZyUIZNqMGKiRX7plFCT3vAvm9FMcWTtOIiccCbSsubL/vz9/O/Gdq
	axX3BFxF910r4dzBmTn5ouiqeEk/Q8LbDvBu+e+dONA7JACUGf8llIiz7mPbFCxYIt6XViaNkka
	7v6uGBrbG0QNRPsdwdbRbMqNRWZjozjK2Ya1jQNCU2EJeSL88JnO+iu+33lQ+lJAVReWG/iKhYq
	E23Q5oSJgHptOoMogMQiBFRM22RYvm1EV6N28j8vYZP+tPwNGTIwXsdPnuc0lK8AD4AKftY2fVJ
	X+LMh4NVEn4LcqwnHl2yCGUs61B6EESb58l3mv1tmObE=
X-Google-Smtp-Source: AGHT+IHWyRJq6tFiZtAn35KR7NImL9zjR4bm4p1s04aULCvEQT/pY7P8N/svSK90+dOJQatGcRCt+Q==
X-Received: by 2002:a05:6512:3f1f:b0:57e:f60:2330 with SMTP id 2adb3069b0e04-591d854accdmr6241116e87.21.1761155423561;
        Wed, 22 Oct 2025 10:50:23 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592ddc3662fsm1193388e87.84.2025.10.22.10.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:50:22 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 22 Oct 2025 19:50:21 +0200
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aPkZXbUON37M59As@milan>
References: <20251021194455.33351-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021194455.33351-2-vishal.moola@gmail.com>

On Tue, Oct 21, 2025 at 12:44:56PM -0700, Vishal Moola (Oracle) wrote:
> Sometimes, vm_area_alloc_pages() will want many pages from the buddy
> allocator. Rather than making requests to the buddy allocator for at
> most 100 pages at a time, we can eagerly request large order pages a
> smaller number of times.
> 
> We still split the large order pages down to order-0 as the rest of the
> vmalloc code (and some callers) depend on it. We still defer to the bulk
> allocator and fallback path in case of order-0 pages or failure.
> 
> Running 1000 iterations of allocations on a small 4GB system finds:
> 
> 1000 2mb allocations:
> 	[Baseline]			[This patch]
> 	real    46.310s			real    0m34.582
> 	user    0.001s			user    0.006s
> 	sys     46.058s			sys     0m34.365s
> 
> 10000 200kb allocations:
> 	[Baseline]			[This patch]
> 	real    56.104s			real    0m43.696
> 	user    0.001s			user    0.003s
> 	sys     55.375s			sys     0m42.995s
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> 
> -----
> RFC:
> https://lore.kernel.org/linux-mm/20251014182754.4329-1-vishal.moola@gmail.com/
> 
> Changes since rfc:
>   - Mask off NO_FAIL in large_gfp
>   - Mask off GFP_COMP in large_gfp
> There was discussion about warning on and rejecting unsupported GFP
> flags in vmalloc, I'll have a separate patch for that.
> 
>   - Introduce nr_remaining variable to track total pages
>   - Calculate large order as (min(max_order, ilog2())
>   - Attempt lower orders on failure before falling back to original path
>   - Drop unnecessary fallback comment change
> ---
>  mm/vmalloc.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index adde450ddf5e..0832f944544c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3619,8 +3619,44 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		unsigned int order, unsigned int nr_pages, struct page **pages)
>  {
>  	unsigned int nr_allocated = 0;
> +	unsigned int nr_remaining = nr_pages;
> +	unsigned int max_attempt_order = MAX_PAGE_ORDER;
>  	struct page *page;
>  	int i;
> +	gfp_t large_gfp = (gfp &
> +		~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL | __GFP_COMP))
> +		| __GFP_NOWARN;
> +	unsigned int large_order = ilog2(nr_remaining);
> +
> +	large_order = min(max_attempt_order, large_order);
> +
> +	/*
> +	 * Initially, attempt to have the page allocator give us large order
> +	 * pages. Do not attempt allocating smaller than order chunks since
> +	 * __vmap_pages_range() expects physically contigous pages of exactly
> +	 * order long chunks.
> +	 */
> +	while (large_order > order && nr_remaining) {
> +		if (nid == NUMA_NO_NODE)
> +			page = alloc_pages_noprof(large_gfp, large_order);
> +		else
> +			page = alloc_pages_node_noprof(nid, large_gfp, large_order);
> +
> +		if (unlikely(!page)) {
> +			max_attempt_order = --large_order;
> +			continue;
> +		}
> +
> +		split_page(page, large_order);
> +		for (i = 0; i < (1U << large_order); i++)
> +			pages[nr_allocated + i] = page + i;
> +
> +		nr_allocated += 1U << large_order;
> +		nr_remaining = nr_pages - nr_allocated;
> +
> +		large_order = ilog2(nr_remaining);
> +		large_order = min(max_attempt_order, large_order);
> +	}
>  
>  	/*
>  	 * For order-0 pages we make use of bulk allocator, if
> -- 
> 2.51.0
> 
I like the idea of page allocation using larger-order :)

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki


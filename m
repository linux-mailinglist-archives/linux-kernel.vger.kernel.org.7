Return-Path: <linux-kernel+bounces-854021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7DBBDD5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA4C1898C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9F2D46B2;
	Wed, 15 Oct 2025 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOVa/ecS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B726560B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516605; cv=none; b=hSbGZIhHG6Byxc+WnbSEqwwplqkfWVCz9+/9G2kvHVV/asxzZemcRV4bi56NwOA+OdMAOv+qSi/AdC4I1Ho72w5Nmm56K9TPxBxTmk4ig/Z5JJK7NVSyl3IKX5XJIEGki00GR4VUWLiTya/pk1ZoBMSEbgTk0KaB6lBvIKbpEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516605; c=relaxed/simple;
	bh=txmzO8BgwuIE6F2Nk0Ekxtx4swBIzt09zRKFpoNqwdw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EO+KoKDrpq+2MsI4SJBEbxPDzZ3/wlRffFVwxJlX7YFOfHH8SYjDJJmNC87mdcRySTpDMU7yDWJl0qJZKxD8qyCmX3XK/mI+byUcvpv3grkgVNt16LUSBv29MpCiMX0J/IYFkZKLmUNr/DEHDq+IxYqq9oHCgiKFIyQDM3bDzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOVa/ecS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-36a6a3974fdso67809931fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760516602; x=1761121402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mf/kC+OIjNsVWQTW5KyvVpDANmQ6eLIZpAk+yfTTfM8=;
        b=MOVa/ecSIMPVfIIyoBgEf5RdK4mvS62RwDdsruLo16SxfnSCVD7NULSyqb1DvdywW5
         ojeZPFYS66KA2UCInHiDkerB3vY3Wpwc6JwyA79KvbliWX0cV7tlvh11mmPnOrzZhzhL
         p1RX47oqf+zzthUWn+Z1hDTRbbgaPV5UHVKqTCPSnGay8Mnk8va/uEDe7Jo9Ia8IXU87
         HugfSI4Ai+0pkpNxklJPXy32jlvr2vTHhbnk1GLV834qZSW9UAyc+9dP4J0Iyo/jKs8q
         CoYkNF3njVSXbfpMWErKkA4JOJLtYKVuBMH2lULnVfZD1iKHxi/2VAsIx1ON1M1D5NVS
         zIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516602; x=1761121402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf/kC+OIjNsVWQTW5KyvVpDANmQ6eLIZpAk+yfTTfM8=;
        b=GuAh3y426P0NzfNKig7VYBrR8Il/XNDkXsxkaWzW+EQJUDKktgcw6r5yiSxyT9pyfW
         xZvHBF4gEZa/OYEFdZaOoaOs5DWEYJpNdscR+xBlo51nDA1ago0dBbwHwiMsOhpKe+/E
         qazV3kUU6Uu60nie4y5oij23q5NJTlTlcaKTFpfNq+X/3hpz3PHBqGKpkT4zC4DxNe/g
         ceGf+V1nYxGlMdjxCjfjB5h8PdfahXJSfVr5imWwrPA4djEgM2Rx0QgXHU8alVF+T3dw
         oqRadQVfeO0s0JJvamrrJUL8F1z2zXOK1p+MrRuOFk1kz7BSxvUrW1AevA6CKY683PFh
         kbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVED1lH6N1zOv4C8B5Y/AlMkG149EOVMnmOUmW8e8CmqimmkmnXe5J2HxaJRNXyNv+Z8N1EmOIp6HuWSmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12SC+oB3nHvR9ZSwJBsYiOu/EaPa9zqaAXvw4X0v0H9+e64Aw
	NoNFfWwlc2Nk74y2k3xAkMFmy516oF9OHTTCayz89t/bahOGPSfdfFUB
X-Gm-Gg: ASbGncuA8HaGYmzfk0qhHMDRi5Vg88JC11Wk/eKcB1r/pGmbiIzvMxR+MSi4aY1uwjO
	UtWZXOOX0/Yi54gU47goD4pEEMr+5w8C0rZvHGfGs3W5YsVOEaiGrfwrZ9kFrMCBl5sBPFtROih
	8Fod3+CYAU2Z1nLbVZSa+ee2G0AE+oqf6p8G6avOmaT6u/CEBqlgGh5D78kbSZFXhCimVqHMNbc
	0sx6tCmyslOw0M/J7BsUY2RC7jixj0b/7r2+rO7gsp3WQ+Bw+YoXG76UobpqK446TvgNSKhNLL/
	FWyt++5aggkF7Kmbx+KeI+o9oaEQN+kL9hNQc/HrUo8yigAbd8dMLmHQaKMbZcAfPQlbNK0w2eR
	8Y/Xx0COU
X-Google-Smtp-Source: AGHT+IEDfPLZF1XUkUC6PKH6VKbUwMfZxNo1JP9Fexm8vGn0nDS/kZEDNU2PautB7TCBU/85QBFQfA==
X-Received: by 2002:a2e:be86:0:b0:377:7ca5:7997 with SMTP id 38308e7fff4ca-3777ca57b3fmr2778641fa.44.1760516601525;
        Wed, 15 Oct 2025 01:23:21 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762e7b461esm45980461fa.16.2025.10.15.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:23:20 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 15 Oct 2025 10:23:19 +0200
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aO9Z90vphRcyFv2n@milan>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014182754.4329-1-vishal.moola@gmail.com>

On Tue, Oct 14, 2025 at 11:27:54AM -0700, Vishal Moola (Oracle) wrote:
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
> 	real    46.310s			real    34.380s
> 	user    0.001s			user    0.008s
> 	sys     46.058s			sys     34.152s
> 
> 10000 200kb allocations:
> 	[Baseline]			[This patch]
> 	real    56.104s			real    43.946s
> 	user    0.001s			user    0.003s
> 	sys     55.375s			sys     43.259s
> 
> 10000 20kb allocations:
> 	[Baseline]			[This patch]
> 	real    0m8.438s		real    0m9.160s
> 	user    0m0.001s		user    0m0.002s
> 	sys     0m7.936s		sys     0m8.671s
> 
> This is an RFC, comments and thoughts are welcomed. There is a
> clear benefit to be had for large allocations, but there is
> some regression for smaller allocations.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/vmalloc.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 97cef2cc14d3..0a25e5cf841c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3621,6 +3621,38 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	unsigned int nr_allocated = 0;
>  	struct page *page;
>  	int i;
> +	gfp_t large_gfp = (gfp & ~__GFP_DIRECT_RECLAIM) | __GFP_NOWARN;
> +	unsigned int large_order = ilog2(nr_pages - nr_allocated);
>
If large_order is > MAX_ORDER - 1 then there is no need even try
larger_order attempt.

>> unsigned int large_order = ilog2(nr_pages - nr_allocated);
I think, it is better to introduce "remaining" variable which
is nr_pages - nr_allocated. And on entry "remaining" can be set
to just nr_pages because "nr_allocated" is zero.

Maybe it is worth to drop/warn if __GFP_COMP is set also?

> +
> +	/*
> +	 * Initially, attempt to have the page allocator give us large order
> +	 * pages. Do not attempt allocating smaller than order chunks since
> +	 * __vmap_pages_range() expects physically contigous pages of exactly
> +	 * order long chunks.
> +	 */
> +	while (large_order > order && nr_allocated < nr_pages) {
> +		/*
> +		 * High-order nofail allocations are really expensive and
> +		 * potentially dangerous (pre-mature OOM, disruptive reclaim
> +		 * and compaction etc.
> +		 */
> +		if (gfp & __GFP_NOFAIL)
> +			break;
> +		if (nid == NUMA_NO_NODE)
> +			page = alloc_pages_noprof(large_gfp, large_order);
> +		else
> +			page = alloc_pages_node_noprof(nid, large_gfp, large_order);
> +
> +		if (unlikely(!page))
> +			break;
> +
> +		split_page(page, large_order);
> +		for (i = 0; i < (1U << large_order); i++)
> +			pages[nr_allocated + i] = page + i;
> +
> +		nr_allocated += 1U << large_order;
> +		large_order = ilog2(nr_pages - nr_allocated);
> +	}
>  
So this is a third path for page allocation. The question is should we
try all orders? Like already noted by Matthew, if there is no 5-order
page but there is 4-order page? Try until we check all orders. For
example we can get different order pages to fulfill the request.

The concern is then if it is a waste of high-order pages. Because we can
easily go with a single page allocator. Whereas someone in a system can not.

Apart of that, maybe we can drop the bulk_path instead of having three paths?

--
Uladzislau Rezki


Return-Path: <linux-kernel+bounces-863724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A4ABF8EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6D61898C40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75F1922FD;
	Tue, 21 Oct 2025 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fd7YyQbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9728A1CC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081877; cv=none; b=pCT8HG+CJpq/NJo2P+0ozoXECIu3Jkh0L5/YnUx14pGKBqV3FaRflM9JIMKlyoVCvkMcd1/AvHrF6qNPESNOK99JkI9yk4X9+h3oVyIrvnx3HeERr5Om3Ql0hq/BgZhYUCZ0CVQs4DeOyyBNPES/NFV6sz+sDPwtG2jICidcfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081877; c=relaxed/simple;
	bh=oqkW0jXITuUuP1+YPYte4eJvwGa2Mg1pWU6Rq32htJo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GSaOgOyncPOAuNPv3korEvHA5aT9sjE3AsZkiIQ8YQPk1fTSZlAIttjsQ0VnC8onTlRAnPwSlcYJn3qMTG0uV24NOVejQbWlAlRl5KZh4jdelfqbUR/JmZiDKdodOiu1HnQVyhxVEoQMrM9vjj0xtZDtddhWcouIpI/8R3B3IwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fd7YyQbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E9EC4CEF1;
	Tue, 21 Oct 2025 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761081877;
	bh=oqkW0jXITuUuP1+YPYte4eJvwGa2Mg1pWU6Rq32htJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fd7YyQbgM7JOcm0pPSTvo8rC23g00gbXsNPzTfSAX65pGNKoko2XIkUo3Gv+Ifr88
	 ZZmmnayyqQ409qX+8bfe83maT//uPddN1a1uxkb3gPBuThXRApnYAyZom3aLrMzM1m
	 dwGQGQIwC32drpZYgkPIUfhwpp57HPhP/hPwXf6M=
Date: Tue, 21 Oct 2025 14:24:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Uladzislau Rezki
 <urezki@gmail.com>
Subject: Re: [PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-Id: <20251021142436.323fec204aa6e9d4b674a4aa@linux-foundation.org>
In-Reply-To: <20251021194455.33351-2-vishal.moola@gmail.com>
References: <20251021194455.33351-2-vishal.moola@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 12:44:56 -0700 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> Sometimes, vm_area_alloc_pages() will want many pages from the buddy
> allocator. Rather than making requests to the buddy allocator for at
> most 100 pages at a time, we can eagerly request large order pages a
> smaller number of times.

Does this have potential to inadvertently reduce the availability of
hugepages?

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

Nice, but how significant is this change likely to be for a real workload?

> ...
>
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

Gee, why is this so complicated?

> +	unsigned int large_order = ilog2(nr_remaining);

Should nr_remaining be rounded up to next-power-of-two?

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


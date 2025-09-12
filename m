Return-Path: <linux-kernel+bounces-814474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA5B55483
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8585B17D276
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D673164A3;
	Fri, 12 Sep 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="epZf1NZ6"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461BD30EF64
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693595; cv=none; b=g4OeAg/aLzPeML+weEvSgkmtNzM6vSk/GywJkC2KSjV5xpiLnc7Z/FkqlkdVXNRKPcyipuT9GLW88Bm/GCrJxL0E7l5ZYAemPPIF/XKeiFUSXhw4O/1kGN8duLiGsINGKidrE7W8duwiRIsu74nYuLhW9t1Yf7bMNZa2/2PFCdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693595; c=relaxed/simple;
	bh=Xil4/2xxZ6Lqpjd9roZ0GUYzcYPP/3GYiIuqJGcGGYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNc3gdJYPVIbhmTf/OLsE5jNOhQSv1QwVlXsa1j7fxgA7nO6yRsxWRokRK71U5QKRP3oh79Xspm15qv4NNSLE6wWZD5lsWYshfhsLfrfpob7VSy4olRmrVRZws5lz9DaZ8UDLhABXQlki7S7R4rfu5hULszYOCB5DdOHoLfFRO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=epZf1NZ6; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 09:13:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757693590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8EycLHCQ1ab18SBt2ew+m+Nf9Rse51xt4sZeCcpwKU=;
	b=epZf1NZ6MtODr26KHOCJ6w57aBjFtc8qnGUh/M8xLbRAVFGsAQYr9wPTqrQE3aOknly5pD
	77fmvTRZSQ6pLHiBa/WcLzC7ELXFsbWSBYfL/56Cbv1CPJOm1GZKSkbAGOJ3HB5atJFG5a
	+rlNMSY1+2LO3q4yoEhtJSa16Fzi0uw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	mhocko@kernel.org, zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, 
	hughd@google.com, willy@infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
Message-ID: <qe56xt2natnxnkht7wgknsb5nqjhinaaajomvvvgnfpwry2jih@hsj2w5zqj6wv>
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 12, 2025 at 11:45:07AM +0800, Baolin Wang wrote:
> Currently, we no longer attempt to write back filesystem folios in pageout(),
> and only tmpfs/shmem folios and anonymous swapcache folios can be written back.
> Moreover, tmpfs/shmem and swapcache folios do not use the PG_private flag,
> which means no fs-private private data is used. Therefore, we can remove the
> redundant folio_test_private() checks and related buffer_head release logic.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/vmscan.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f1fc36729ddd..8056fccb9cc4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
>  	 * swap_backing_dev_info is bust: it doesn't reflect the
>  	 * congestion state of the swapdevs.  Easy to fix, if needed.
>  	 */
> -	if (!is_page_cache_freeable(folio))
> +	if (!is_page_cache_freeable(folio) || !mapping)
>  		return PAGE_KEEP;
> -	if (!mapping) {
> -		/*
> -		 * Some data journaling orphaned folios can have
> -		 * folio->mapping == NULL while being dirty with clean buffers.
> -		 */

Can this case not happen anymore and try_to_free_buffers is not needed?

> -		if (folio_test_private(folio)) {
> -			if (try_to_free_buffers(folio)) {
> -				folio_clear_dirty(folio);
> -				pr_info("%s: orphaned folio\n", __func__);
> -				return PAGE_CLEAN;
> -			}
> -		}
> -		return PAGE_KEEP;
> -	}
>  
>  	if (!shmem_mapping(mapping) && !folio_test_anon(folio))
>  		return PAGE_ACTIVATE;
> -- 
> 2.43.7
> 


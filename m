Return-Path: <linux-kernel+bounces-813421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8277AB54529
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35D41B24FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F5C2D3ED2;
	Fri, 12 Sep 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oX70Eznt"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E132D6E6D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665336; cv=none; b=DwvrXTvlsgvsQY5lbeGS56599fBKplmTjiPUXC26YSEs8oPOXeGu0Tt63kUfHnPXf/cP5745zKadZNPIEV7kZQGh+UNcXy+ltmXjlPK/OFnTfv7Z1bK4aovomZraINkFs2ALDRVC7Ugd1PmHKgx5dioM1n0bDaRBmCj5I9DQdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665336; c=relaxed/simple;
	bh=nVUTEQBfoeqTO4sOiLQwgZp23HBV3yAR4Uze7AXkKdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqdBhmGkK2h2N/jXsyp3q6z7mYucumEW9OEpd+Kl8gIGHTdSrHnLWh2TdVmsMkqIv1+bPg2T5osQATx60YSrzdAAhGyG3J9Sx1Bzb1bFMWzhD4SBj9p2aFq6QrDaAwOT6F/zxsZ+9hfNzKo463uvhhfrLc2Oq4viUc/+JdgCHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oX70Eznt; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757665326; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=a04ysXcVM3EZCSALMoyb9EewsnLnr/d3s7vYk7XR0aY=;
	b=oX70EzntosG4A15Fnu+zdIKMomPMDdA9+MZgFkrak2DXUYTAJQQtS4ZZ5+YzP06VKcjFjQOXOz4EMFD7yDa2ZeEQ2fOz0/2tWRVDYqrXCapfXAxIurYJJkOAGn5KlMhSpOtPSVDEBLHR4ZtnFb6pX/UKGBNc34IDzqSUnyB5jWw=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnqIOy8_1757665324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 16:22:05 +0800
Message-ID: <0cb2bc82-1957-4efe-8c85-8558743dcf80@linux.alibaba.com>
Date: Fri, 12 Sep 2025 16:22:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] mm/shmem, swap: remove redundant error handling
 for replacing folio
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
 <20250910160833.3464-10-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250910160833.3464-10-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/11 00:08, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Shmem may replace a folio in the swap cache if the cached one doesn't
> fit the swapin's GFP zone. When doing so, shmem has already double
> checked that the swap cache folio is locked, still has the swap cache
> flag set, and contains the wanted swap entry. So it is impossible to
> fail due to an XArray mismatch. There is even a comment for that.
> 
> Delete the defensive error handling path, and add a WARN_ON instead:
> if that happened, something has broken the basic principle of how the
> swap cache works, we should catch and fix that.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/shmem.c | 42 ++++++++++++------------------------------
>   1 file changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 410f27bc4752..5f395fab489c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1661,13 +1661,13 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
>   		}
>   
>   		/*
> -		 * The delete_from_swap_cache() below could be left for
> +		 * The swap_cache_del_folio() below could be left for
>   		 * shrink_folio_list()'s folio_free_swap() to dispose of;
>   		 * but I'm a little nervous about letting this folio out of
>   		 * shmem_writeout() in a hybrid half-tmpfs-half-swap state
>   		 * e.g. folio_mapping(folio) might give an unexpected answer.
>   		 */
> -		delete_from_swap_cache(folio);
> +		swap_cache_del_folio(folio);
>   		goto redirty;
>   	}
>   	if (nr_pages > 1)
> @@ -2045,7 +2045,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
>   	new->swap = entry;
>   
>   	memcg1_swapin(entry, nr_pages);
> -	shadow = get_shadow_from_swap_cache(entry);
> +	shadow = swap_cache_get_shadow(entry);

Again, there are still some issues with the patch split. The swapcache 
related APIs replacement should be placed in Patch 8, otherwise there 
will be buidling errors after applying Patch 8.

With this issue fixed:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   	if (shadow)
>   		workingset_refault(new, shadow);
>   	folio_add_lru(new);
> @@ -2121,35 +2121,17 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>   	/* Swap cache still stores N entries instead of a high-order entry */
>   	xa_lock_irq(&swap_mapping->i_pages);
>   	for (i = 0; i < nr_pages; i++) {
> -		void *item = xas_load(&xas);
> -
> -		if (item != old) {
> -			error = -ENOENT;
> -			break;
> -		}
> -
> -		xas_store(&xas, new);
> +		WARN_ON_ONCE(xas_store(&xas, new));
>   		xas_next(&xas);
>   	}
> -	if (!error) {
> -		mem_cgroup_replace_folio(old, new);
> -		shmem_update_stats(new, nr_pages);
> -		shmem_update_stats(old, -nr_pages);
> -	}
>   	xa_unlock_irq(&swap_mapping->i_pages);
>   
> -	if (unlikely(error)) {
> -		/*
> -		 * Is this possible?  I think not, now that our callers
> -		 * check both the swapcache flag and folio->private
> -		 * after getting the folio lock; but be defensive.
> -		 * Reverse old to newpage for clear and free.
> -		 */
> -		old = new;
> -	} else {
> -		folio_add_lru(new);
> -		*foliop = new;
> -	}
> +	mem_cgroup_replace_folio(old, new);
> +	shmem_update_stats(new, nr_pages);
> +	shmem_update_stats(old, -nr_pages);
> +
> +	folio_add_lru(new);
> +	*foliop = new;
>   
>   	folio_clear_swapcache(old);
>   	old->private = NULL;
> @@ -2183,7 +2165,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>   	nr_pages = folio_nr_pages(folio);
>   	folio_wait_writeback(folio);
>   	if (!skip_swapcache)
> -		delete_from_swap_cache(folio);
> +		swap_cache_del_folio(folio);
>   	/*
>   	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
>   	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
> @@ -2422,7 +2404,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   		folio->swap.val = 0;
>   		swapcache_clear(si, swap, nr_pages);
>   	} else {
> -		delete_from_swap_cache(folio);
> +		swap_cache_del_folio(folio);
>   	}
>   	folio_mark_dirty(folio);
>   	swap_free_nr(swap, nr_pages);



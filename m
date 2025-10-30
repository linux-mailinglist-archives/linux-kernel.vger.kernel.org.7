Return-Path: <linux-kernel+bounces-879237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DABCC229B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E173E4E8105
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AA133B6E4;
	Thu, 30 Oct 2025 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="avDThudj"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0927FD76
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864815; cv=none; b=U536QcmA2hxPgftErjOdJYzLDLbsVrrwvhMhWAK17IR5/oOy65fLQf0GcB6uNUDvDvWmQQpFpNG2T60pa9HCxeB+at4YiCUCHZuPjDLG/IvUNIBM1IT8qD6tfuRbaKqLPb3MnmkedZWVbdJO3+J8Xkps9Holc6GDH6t0jWao42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864815; c=relaxed/simple;
	bh=ZXuqNELKrBVwOoxUpozZScmR81ZTvAZfvhcuY5eZY5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hehJn4WSsoUps3CCvcp410YWLICtI4lpB5Cy3G2a8XAyi+pn941d6vlxPlmnFsNGHSfVpZSI4v87eJC7EEKLVLN2BOBcWGcTlIqwukpz3oAU5oUAC275vh+Qre0we5AgxkE3cIieGl/RagvUyB2lcb1ILwj3oxdxx0upWvYteDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=avDThudj; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 30 Oct 2025 22:53:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761864807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1qA2vWPGU8Cj9JuIKZwmwfLammDUxSGwGNWhYdWVBk=;
	b=avDThudjCDJNHNsHc4M8wuCiaBsP5T8rU4tubZNUWgW48ZcekS07dUXtfQmytSHETrPFyN
	fYspDU0vPwOVVD/55t4MDB5ehoOw9xAySMm2jWdhoaPrim20zzqPujKugHFASf7cGnpf7C
	AAkZmcCj5SQEfXtwsj9t9yN/2ajVpUo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 01/19] mm/swap: rename __read_swap_cache_async to
 swap_cache_alloc_folio
Message-ID: <ufy26fqfvaxqjywneec3hcuky7ozpa2fm63pxcuuberrvicffv@bkblomeix35w>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-1-3d43f3b6ec32@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-swap-table-p2-v1-1-3d43f3b6ec32@tencent.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 29, 2025 at 11:58:27PM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> __read_swap_cache_async is widely used to allocate and ensure a folio is
> in swapcache, or get the folio if a folio is already there.
> 
> It's not async, and it's not doing any read. Rename it to better present
> its usage, and prepare to be reworked as part of new swap cache APIs.
> 
> Also, add some comments for the function. Worth noting that the
> skip_if_exists argument is an long existing workaround that will be
> dropped soon.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap.h       |  6 +++---
>  mm/swap_state.c | 49 ++++++++++++++++++++++++++++++++-----------------
>  mm/swapfile.c   |  2 +-
>  mm/zswap.c      |  4 ++--
>  4 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/swap.h b/mm/swap.h
> index d034c13d8dd2..0fff92e42cfe 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -249,6 +249,9 @@ struct folio *swap_cache_get_folio(swp_entry_t entry);
>  void *swap_cache_get_shadow(swp_entry_t entry);
>  void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow);
>  void swap_cache_del_folio(struct folio *folio);
> +struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
> +				     struct mempolicy *mpol, pgoff_t ilx,
> +				     bool *alloced, bool skip_if_exists);
>  /* Below helpers require the caller to lock and pass in the swap cluster. */
>  void __swap_cache_del_folio(struct swap_cluster_info *ci,
>  			    struct folio *folio, swp_entry_t entry, void *shadow);
> @@ -261,9 +264,6 @@ void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
>  struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		struct vm_area_struct *vma, unsigned long addr,
>  		struct swap_iocb **plug);
> -struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
> -		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
> -		bool skip_if_exists);
>  struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>  		struct mempolicy *mpol, pgoff_t ilx);
>  struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index b13e9c4baa90..7765b9474632 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -402,9 +402,28 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
>  	}
>  }
>  
> -struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
> -		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
> -		bool skip_if_exists)
> +/**
> + * swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
> + * @entry: the swapped out swap entry to be binded to the folio.
> + * @gfp_mask: memory allocation flags
> + * @mpol: NUMA memory allocation policy to be applied
> + * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
> + * @new_page_allocated: sets true if allocation happened, false otherwise
> + * @skip_if_exists: if the slot is a partially cached state, return NULL.
> + *                  This is a workaround that would be removed shortly.
> + *
> + * Allocate a folio in the swap cache for one swap slot, typically before
> + * doing IO (swap in or swap out). The swap slot indicated by @entry must
> + * have a non-zero swap count (swapped out). Currently only supports order 0.

Is it used for swap in? That's confusing because the next sentence
mention that it needs to be already swapped out.

I suspect you're referring to the zswap writeback use case, but in this
case we're still "swapping-in" the folio from zswap to swap it out to
disk. I'd avoid mentioning swap in here because it's confusing.

Otherwise LGTM:
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> + *
> + * Context: Caller must protect the swap device with reference count or locks.
> + * Return: Returns the existing folio if @entry is cached already. Returns
> + * NULL if failed due to -ENOMEM or @entry have a swap count < 1.
> + */
> +struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
> +				     struct mempolicy *mpol, pgoff_t ilx,
> +				     bool *new_page_allocated,
> +				     bool skip_if_exists)
>  {
>  	struct swap_info_struct *si = __swap_entry_to_info(entry);
>  	struct folio *folio;
> @@ -452,12 +471,12 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  			goto put_and_return;
>  
>  		/*
> -		 * Protect against a recursive call to __read_swap_cache_async()
> +		 * Protect against a recursive call to swap_cache_alloc_folio()
>  		 * on the same entry waiting forever here because SWAP_HAS_CACHE
>  		 * is set but the folio is not the swap cache yet. This can
>  		 * happen today if mem_cgroup_swapin_charge_folio() below
>  		 * triggers reclaim through zswap, which may call
> -		 * __read_swap_cache_async() in the writeback path.
> +		 * swap_cache_alloc_folio() in the writeback path.
>  		 */
>  		if (skip_if_exists)
>  			goto put_and_return;
> @@ -466,7 +485,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 * We might race against __swap_cache_del_folio(), and
>  		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
>  		 * has not yet been cleared.  Or race against another
> -		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
> +		 * swap_cache_alloc_folio(), which has set SWAP_HAS_CACHE
>  		 * in swap_map, but not yet added its folio to swap cache.
>  		 */
>  		schedule_timeout_uninterruptible(1);
> @@ -509,10 +528,6 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   * and reading the disk if it is not already cached.
>   * A failure return means that either the page allocation failed or that
>   * the swap entry is no longer in use.
> - *
> - * get/put_swap_device() aren't needed to call this function, because
> - * __read_swap_cache_async() call them and swap_read_folio() holds the
> - * swap cache folio lock.
>   */
>  struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		struct vm_area_struct *vma, unsigned long addr,
> @@ -529,7 +544,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		return NULL;
>  
>  	mpol = get_vma_policy(vma, addr, 0, &ilx);
> -	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
> +	folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
>  					&page_allocated, false);
>  	mpol_cond_put(mpol);
>  
> @@ -647,9 +662,9 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  	blk_start_plug(&plug);
>  	for (offset = start_offset; offset <= end_offset ; offset++) {
>  		/* Ok, do the async read-ahead now */
> -		folio = __read_swap_cache_async(
> -				swp_entry(swp_type(entry), offset),
> -				gfp_mask, mpol, ilx, &page_allocated, false);
> +		folio = swap_cache_alloc_folio(
> +			swp_entry(swp_type(entry), offset), gfp_mask, mpol, ilx,
> +			&page_allocated, false);
>  		if (!folio)
>  			continue;
>  		if (page_allocated) {
> @@ -666,7 +681,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  	lru_add_drain();	/* Push any new pages onto the LRU now */
>  skip:
>  	/* The page was likely read above, so no need for plugging here */
> -	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
> +	folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
>  					&page_allocated, false);
>  	if (unlikely(page_allocated))
>  		swap_read_folio(folio, NULL);
> @@ -761,7 +776,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  			continue;
>  		pte_unmap(pte);
>  		pte = NULL;
> -		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
> +		folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
>  						&page_allocated, false);
>  		if (!folio)
>  			continue;
> @@ -781,7 +796,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  	lru_add_drain();
>  skip:
>  	/* The folio was likely read above, so no need for plugging here */
> -	folio = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
> +	folio = swap_cache_alloc_folio(targ_entry, gfp_mask, mpol, targ_ilx,
>  					&page_allocated, false);
>  	if (unlikely(page_allocated))
>  		swap_read_folio(folio, NULL);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c35bb8593f50..849be32377d9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1573,7 +1573,7 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
>   *   CPU1				CPU2
>   *   do_swap_page()
>   *     ...				swapoff+swapon
> - *     __read_swap_cache_async()
> + *     swap_cache_alloc_folio()
>   *       swapcache_prepare()
>   *         __swap_duplicate()
>   *           // check swap_map
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 5d0f8b13a958..a7a2443912f4 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1014,8 +1014,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  		return -EEXIST;
>  
>  	mpol = get_task_policy(current);
> -	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
> -			NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
> +	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, mpol,
> +				       NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
>  	put_swap_device(si);
>  	if (!folio)
>  		return -ENOMEM;
> 
> -- 
> 2.51.1
> 


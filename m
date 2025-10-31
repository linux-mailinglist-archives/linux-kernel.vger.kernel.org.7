Return-Path: <linux-kernel+bounces-879536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AB0C2353B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 299B334D61B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87FE2EA754;
	Fri, 31 Oct 2025 06:11:18 +0000 (UTC)
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE982E7F08
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891078; cv=none; b=Q1+JiR+xRBAoxPZKLFZmCcrgvMGnjMxozP4PUSQg+DCgX5Exm351Z37Yzja14n9FmO05gvM1ETMvE6sdE41Djrl9xiI8CrwxZFFYb7VGVxxMOuyZ6LVl2e9DMt0hJgMrU2IdZ5zKh7AgTfoQEnDJeYfDQOXQupxFebUR1dqvdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891078; c=relaxed/simple;
	bh=dbqvvWDRQoe863OC/4NgIAgMUiU1JzQtS6aqucXqPvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unWp05QiqVjVYzkeuqenGH22+D1SqdP9kmV+ZvDbWLET7g7fv6cmb618GgyyHSyQdP/k9WXVB2HU5nx06anTszwhySIfsX67H6ogwGBKKH7qsT2AL9sexeUnwQpyMSEPUXeLrnAO0OLVPpoq9JVIwDmMm6IjfmweLXT+2xVg5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 31 Oct 2025 14:56:12 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 31 Oct 2025 14:56:12 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 15/19] mm, swap: add folio to swap cache directly on
 allocation
Message-ID: <aQRPfIqCcMLyf6oX@yjaykim-PowerEdge-T330>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-15-3d43f3b6ec32@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-swap-table-p2-v1-15-3d43f3b6ec32@tencent.com>

On Wed, Oct 29, 2025 at 11:58:41PM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>

Hello Kairui 

> The allocator uses SWAP_HAS_CACHE to pin a swap slot upon allocation.
> SWAP_HAS_CACHE is being deprecated as it caused a lot of confusion.
> This pinning usage here can be dropped by adding the folio to swap
> cache directly on allocation.
> 
> All swap allocations are folio-based now (except for hibernation), so
> the swap allocator can always take the folio as the parameter. And now
> both swap cache (swap table) and swap map are protected by the cluster
> lock, scanning the map and inserting the folio can be done in the same
> critical section. This eliminates the time window that a slot is pinned
> by SWAP_HAS_CACHE, but it has no cache, and avoids touching the lock
> multiple times.
> 
> This is both a cleanup and an optimization.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h |   5 --
>  mm/swap.h            |   8 +--
>  mm/swap_state.c      |  56 +++++++++++-------
>  mm/swapfile.c        | 161 +++++++++++++++++++++------------------------------
>  4 files changed, 105 insertions(+), 125 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index ac3caa4c6999..4b4b81fbc6a3 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -452,7 +452,6 @@ static inline long get_nr_swap_pages(void)
>  }
>  
>  extern void si_swapinfo(struct sysinfo *);
> -void put_swap_folio(struct folio *folio, swp_entry_t entry);
>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>  int swap_type_of(dev_t device, sector_t offset);
>  int find_first_swap(dev_t *device);
> @@ -534,10 +533,6 @@ static inline void swap_put_entries_direct(swp_entry_t ent, int nr)
>  {
>  }
>  
> -static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
> -{
> -}
> -
>  static inline int __swap_count(swp_entry_t entry)
>  {
>  	return 0;
> diff --git a/mm/swap.h b/mm/swap.h
> index 74c61129d7b7..03694ffa662f 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -277,13 +277,13 @@ void __swapcache_clear_cached(struct swap_info_struct *si,
>   */
>  struct folio *swap_cache_get_folio(swp_entry_t entry);
>  void *swap_cache_get_shadow(swp_entry_t entry);
> -int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> -			 void **shadow, bool alloc);
>  void swap_cache_del_folio(struct folio *folio);
>  struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
>  				     struct mempolicy *mpol, pgoff_t ilx,
>  				     bool *alloced);
>  /* Below helpers require the caller to lock and pass in the swap cluster. */
> +void __swap_cache_add_folio(struct swap_cluster_info *ci,
> +			    struct folio *folio, swp_entry_t entry);
>  void __swap_cache_del_folio(struct swap_cluster_info *ci,
>  			    struct folio *folio, swp_entry_t entry, void *shadow);
>  void __swap_cache_replace_folio(struct swap_cluster_info *ci,
> @@ -459,8 +459,8 @@ static inline void *swap_cache_get_shadow(swp_entry_t entry)
>  	return NULL;
>  }
>  
> -static inline int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> -				       void **shadow, bool alloc)
> +static inline void *__swap_cache_add_folio(struct swap_cluster_info *ci,
> +		struct folio *folio, swp_entry_t entry)
>  {
>  }

Just a nit,
void* return nothing. 

changed to void (original function prototype is return void)
or how about just remove If this is not used on !CONFIG_SWAP

> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d2bcca92b6e0..85d9f99c384f 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -122,6 +122,34 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>  	return NULL;
>  }
>  
> +void __swap_cache_add_folio(struct swap_cluster_info *ci,
> +			    struct folio *folio, swp_entry_t entry)
> +{
> +	unsigned long new_tb;
> +	unsigned int ci_start, ci_off, ci_end;
> +	unsigned long nr_pages = folio_nr_pages(folio);
> +
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
> +
> +	new_tb = folio_to_swp_tb(folio);
> +	ci_start = swp_cluster_offset(entry);
> +	ci_off = ci_start;
> +	ci_end = ci_start + nr_pages;
> +	do {
> +		VM_WARN_ON_ONCE(swp_tb_is_folio(__swap_table_get(ci, ci_off)));
> +		__swap_table_set(ci, ci_off, new_tb);
> +	} while (++ci_off < ci_end);
> +
> +	folio_ref_add(folio, nr_pages);
> +	folio_set_swapcache(folio);
> +	folio->swap = entry;
> +
> +	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
> +	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
> +}
> +
>  /**
>   * swap_cache_add_folio - Add a folio into the swap cache.
>   * @folio: The folio to be added.
> @@ -136,23 +164,18 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>   * The caller also needs to update the corresponding swap_map slots with
>   * SWAP_HAS_CACHE bit to avoid race or conflict.
>   */
> -int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> -			 void **shadowp, bool alloc)
> +static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> +				void **shadowp)

It is also a small thing.
"alloc" parameter removed then the comment might be updated.

Thanks,
Youngjun Park


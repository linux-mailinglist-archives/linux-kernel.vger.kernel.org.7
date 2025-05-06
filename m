Return-Path: <linux-kernel+bounces-636052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F38AAC578
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC6A524B84
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3267921B9DE;
	Tue,  6 May 2025 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h2Gwclv+"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95A221773D
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537215; cv=none; b=LtR8Rml7qa72eCTgdP+d/fdYKNbuTHI0nG6XK9VvZ+DSCzTVPKDGzV26h9b5vwkquHKqrp13V0Mp/A/DrlmWv4o5kHaEpLFwrNdi6jgW/pPFwfo7hIwnJlLv+BYziy/199LKTdnQx0jr6iC/4Fp8KqBCwtrxAwxA9ObX9b8bqOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537215; c=relaxed/simple;
	bh=mgsGk9gCT3M1lf9HueIEtSPHqqF57smwqeFtLbtqDZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZQZrYiAv32FdqF/ql0qXhLaBVmr9dZKcltXOMW3Y6lcd5LZvUY9qaE7DK4XEIf/meQv+rn1JJgRm5zB7Z2FdpdRdAmneYvL17bwtoDpKAq5JzrxevuWc2/pESh7whJJdwRJRpTTi83K87z8SOENVLcBE6MumtSGaX+yPm8Xoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h2Gwclv+; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 May 2025 13:13:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746537209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wfa4l7beRgLCNqc7AkmKuNjzqaMq8QBn/PTMeTLAvM=;
	b=h2Gwclv+gkyG4vFbtwLU2+HPz3NoIiu/6uxj2EKCZqh8IfvM5Y4vMtOR+94EZH31HKVDoN
	W7fGlqksfFwNu4UizLy9/zssX/JLHKyQrBCfsM47G5MQXl2Omw3fvPbiux76zo65pIgBWX
	VLVwd4ENr9JA8uGYxulCKp1Ylmjelmg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Igor Belousov <igor.b@beldev.am>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] mm/zblock: use vmalloc for page allocations
Message-ID: <aBoK7f7rtfbPFGap@google.com>
References: <20250502080156.1672957-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502080156.1672957-1-vitaly.wool@konsulko.se>
X-Migadu-Flow: FLOW_OUT

On Fri, May 02, 2025 at 10:01:56AM +0200, Vitaly Wool wrote:
> From: Igor Belousov <igor.b@beldev.am>
> 
> Use vmalloc for page allocations for zblock blocks to avoid extra
> pressure on the memmory subsystem with multiple higher order
> allocations.
> 
> While at it, introduce a module parameter to opportunistically
> allocate pages of lower orders via try_page_alloc() for faster
> allocations whenever possible.
> 
> Since vmalloc works fine with non-power of 2 numbers of pages,
> rewrite the block size tables to use that opportunity.
> 
> Signed-off-by: Igor Belousov <igor.b@beldev.am>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

Keep in mind that zswap_decompress() will always do an extra copy if the
address returned by zpool_obj_read_begin() is a vmalloc address. To
avoid this we need to enlighten the scatterlist API to work with vmalloc
addresses.

(CC'ing Herbert as he was looking into this)

If we can use vmalloc for zblock, then we can probably also use vmalloc
in zsmalloc and get rid of the chaining logic completely. This would
make zsmalloc simpler and closer to zblock in that regard.

Sergey, WDYT?

> ---
> 
> Tests run on qemu-arm64 (8 CPUs, 1.5G RAM, 4K pages):
> 1. zblock
> 43205.38user
> 7320.53system
> 2:12:04elapsed
> zswpin 346127
> zswpout 1642438
> 
> 2. zsmalloc
> 47194.61user 
> 7978.48system 
> 2:25:03elapsed 
> zswpin 448031
> zswpout 1810485
> 
> So zblock gives a nearly 10% advantage.
> 
> Please note that zsmalloc *crashes* on 16K page tests so I couldn't
> compare performance in that case.
> 
>  mm/zblock.c | 101 ++++++++++++++++++++++------------
>  mm/zblock.h | 153 ++++++++++++++++++++++++++++++----------------------
>  2 files changed, 156 insertions(+), 98 deletions(-)
> 
> diff --git a/mm/zblock.c b/mm/zblock.c
> index e2036a6e1617..38468028e129 100644
> --- a/mm/zblock.c
> +++ b/mm/zblock.c
> @@ -24,12 +24,17 @@
>  #include <linux/preempt.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/vmalloc.h>
>  #include <linux/zpool.h>
>  #include "zblock.h"
>  
>  static struct rb_root block_desc_tree = RB_ROOT;
>  static struct dentry *zblock_debugfs_root;
>  
> +/* allocate order 0 blocks using vmalloc? <-- disabled by default */
> +static bool vmalloc_small_blocks;
> +module_param_named(vmalloc_small_blocks, vmalloc_small_blocks, bool, 0644);
> +
>  /* Encode handle of a particular slot in the pool using metadata */
>  static inline unsigned long metadata_to_handle(struct zblock_block *block,
>  				unsigned int block_type, unsigned int slot)
> @@ -56,13 +61,14 @@ static inline struct zblock_block *find_and_claim_block(struct block_list *b,
>  	struct list_head *l = &b->active_list;
>  	unsigned int slot;
>  
> -	if (!list_empty(l)) {
> +	spin_lock(&b->lock);
> +	if (likely(!list_empty(l))) {
>  		struct zblock_block *z = list_first_entry(l, typeof(*z), link);
>  
>  		if (--z->free_slots == 0)
> -			list_move(&z->link, &b->full_list);
> +			__list_del_clearprev(&z->link);
>  		/*
> -		 * There is a slot in the block and we just made sure it would
> +		 * There is a slot in the block and we just made sure it will
>  		 * remain.
>  		 * Find that slot and set the busy bit.
>  		 */
> @@ -74,31 +80,57 @@ static inline struct zblock_block *find_and_claim_block(struct block_list *b,
>  					slot)) {
>  			if (!test_and_set_bit(slot, z->slot_info))
>  				break;
> -			barrier();
>  		}
> +		spin_unlock(&b->lock);
>  
> -		WARN_ON(slot >= block_desc[block_type].slots_per_block);
>  		*handle = metadata_to_handle(z, block_type, slot);
>  		return z;
>  	}
> +	spin_unlock(&b->lock);
>  	return NULL;
>  }
>  
> +static inline int zblock_get_order(unsigned int num_pages)
> +{
> +	switch (num_pages) {
> +	case 1:
> +	case 2:
> +		return num_pages - 1;
> +	case 4:
> +		return 2;
> +	default:
> +		break;
> +	}
> +	return -1;
> +}
>  /*
>   * allocate new block and add it to corresponding block list
>   */
>  static struct zblock_block *alloc_block(struct zblock_pool *pool,
>  					int block_type, gfp_t gfp,
> -					unsigned long *handle)
> +					unsigned long *handle,
> +					unsigned int nid)
>  {
> +	struct block_list *block_list = &pool->block_lists[block_type];
> +	unsigned int num_pages = block_desc[block_type].num_pages;
>  	struct zblock_block *block;
> -	struct block_list *block_list;
> +	struct page *page = NULL;
>  
> -	block = (void *)__get_free_pages(gfp, block_desc[block_type].order);
> -	if (!block)
> -		return NULL;
> +	if (!vmalloc_small_blocks && zblock_get_order(num_pages) >= 0) {
> +		page = try_alloc_pages(nid, zblock_get_order(num_pages));
> +		if (page) {
> +			page->private = PAGE_SMALL_BLOCK;
> +			block = page_address(page);
> +		}
> +	}
> +	if (!page) {
> +		block = __vmalloc_node(PAGE_SIZE * num_pages, PAGE_SIZE, gfp, nid, NULL);
> +		if (!block)
> +			return NULL;
>  
> -	block_list = &pool->block_lists[block_type];
> +		page = vmalloc_to_page(block);
> +		page->private = 0;
> +	}
>  
>  	/* init block data  */
>  	block->free_slots = block_desc[block_type].slots_per_block - 1;
> @@ -122,8 +154,8 @@ static int zblock_blocks_show(struct seq_file *s, void *v)
>  		struct block_list *block_list = &pool->block_lists[i];
>  
>  		seq_printf(s, "%d: %ld blocks of %d pages (total %ld pages)\n",
> -			i, block_list->block_count, 1 << block_desc[i].order,
> -			block_list->block_count << block_desc[i].order);
> +			i, block_list->block_count, block_desc[i].num_pages,
> +			block_list->block_count * block_desc[i].num_pages);
>  	}
>  	return 0;
>  }
> @@ -142,19 +174,17 @@ DEFINE_SHOW_ATTRIBUTE(zblock_blocks);
>   */
>  static struct zblock_pool *zblock_create_pool(gfp_t gfp)
>  {
> -	struct zblock_pool *pool;
> -	struct block_list *block_list;
> +	struct zblock_pool *pool = kmalloc(sizeof(struct zblock_pool), gfp);
>  	int i;
>  
> -	pool = kmalloc(sizeof(struct zblock_pool), gfp);
>  	if (!pool)
>  		return NULL;
>  
>  	/* init each block list */
>  	for (i = 0; i < ARRAY_SIZE(block_desc); i++) {
> -		block_list = &pool->block_lists[i];
> +		struct block_list *block_list = &pool->block_lists[i];
> +
>  		spin_lock_init(&block_list->lock);
> -		INIT_LIST_HEAD(&block_list->full_list);
>  		INIT_LIST_HEAD(&block_list->active_list);
>  		block_list->block_count = 0;
>  	}
> @@ -187,7 +217,7 @@ static void zblock_destroy_pool(struct zblock_pool *pool)
>   * a new slot.
>   */
>  static int zblock_alloc(struct zblock_pool *pool, size_t size, gfp_t gfp,
> -			unsigned long *handle)
> +			unsigned long *handle, unsigned int nid)
>  {
>  	int block_type = -1;
>  	struct zblock_block *block;
> @@ -196,7 +226,7 @@ static int zblock_alloc(struct zblock_pool *pool, size_t size, gfp_t gfp,
>  	if (!size)
>  		return -EINVAL;
>  
> -	if (size > PAGE_SIZE)
> +	if (size > block_desc[ARRAY_SIZE(block_desc) - 1].slot_size)
>  		return -ENOSPC;
>  
>  	/* find basic block type with suitable slot size */
> @@ -220,19 +250,15 @@ static int zblock_alloc(struct zblock_pool *pool, size_t size, gfp_t gfp,
>  	}
>  	if (WARN_ON(block_type < 0))
>  		return -EINVAL;
> -	if (block_type >= ARRAY_SIZE(block_desc))
> -		return -ENOSPC;
>  
>  	block_list = &pool->block_lists[block_type];
>  
> -	spin_lock(&block_list->lock);
>  	block = find_and_claim_block(block_list, block_type, handle);
> -	spin_unlock(&block_list->lock);
>  	if (block)
>  		return 0;
>  
>  	/* not found block with free slots try to allocate new empty block */
> -	block = alloc_block(pool, block_type, gfp & ~(__GFP_MOVABLE | __GFP_HIGHMEM), handle);
> +	block = alloc_block(pool, block_type, gfp, handle, nid);
>  	return block ? 0 : -ENOMEM;
>  }
>  
> @@ -251,17 +277,25 @@ static void zblock_free(struct zblock_pool *pool, unsigned long handle)
>  	block = handle_to_metadata(handle, &block_type, &slot);
>  	block_list = &pool->block_lists[block_type];
>  
> +	/* clear bit early, this will shorten the search */
> +	clear_bit(slot, block->slot_info);
> +
>  	spin_lock(&block_list->lock);
> -	/* if all slots in block are empty delete whole block */
> +	/* if all slots in block are empty delete the whole block */
>  	if (++block->free_slots == block_desc[block_type].slots_per_block) {
> +		struct page *page = vmalloc_to_page(block);
> +		int num_pages = block_desc[block_type].num_pages;
> +
>  		block_list->block_count--;
> -		list_del(&block->link);
> +		__list_del_clearprev(&block->link);
>  		spin_unlock(&block_list->lock);
> -		free_pages((unsigned long)block, block_desc[block_type].order);
> +		if (page->private & PAGE_SMALL_BLOCK)
> +			__free_pages(page, zblock_get_order(num_pages));
> +		else
> +			vfree(block);
>  		return;
>  	} else if (block->free_slots == 1)
> -		list_move_tail(&block->link, &block_list->active_list);
> -	clear_bit(slot, block->slot_info);
> +		list_add(&block->link, &block_list->active_list);
>  	spin_unlock(&block_list->lock);
>  }
>  
> @@ -329,7 +363,7 @@ static u64 zblock_get_total_pages(struct zblock_pool *pool)
>  
>  	total_size = 0;
>  	for (i = 0; i < ARRAY_SIZE(block_desc); i++)
> -		total_size += pool->block_lists[i].block_count << block_desc[i].order;
> +		total_size += pool->block_lists[i].block_count * block_desc[i].num_pages;
>  
>  	return total_size;
>  }
> @@ -351,7 +385,7 @@ static void zblock_zpool_destroy(void *pool)
>  static int zblock_zpool_malloc(void *pool, size_t size, gfp_t gfp,
>  			unsigned long *handle, const int nid)
>  {
> -	return zblock_alloc(pool, size, gfp, handle);
> +	return zblock_alloc(pool, size, gfp, handle, nid);
>  }
>  
>  static void zblock_zpool_free(void *pool, unsigned long handle)
> @@ -407,6 +441,7 @@ static int __init create_rbtree(void)
>  {
>  	int i;
>  
> +	BUILD_BUG_ON(ARRAY_SIZE(block_desc) > MAX_TABLE_SIZE);
>  	for (i = 0; i < ARRAY_SIZE(block_desc); i++) {
>  		struct block_desc_node *block_node = kmalloc(sizeof(*block_node),
>  							GFP_KERNEL);
> @@ -425,7 +460,7 @@ static int __init create_rbtree(void)
>  		block_node->this_slot_size = block_desc[i].slot_size;
>  		block_node->block_idx = i;
>  		if (i == ARRAY_SIZE(block_desc) - 1)
> -			block_node->next_slot_size = PAGE_SIZE;
> +			block_node->next_slot_size = PAGE_SIZE * 2;
>  		else
>  			block_node->next_slot_size = block_desc[i+1].slot_size;
>  		while (*new) {
> diff --git a/mm/zblock.h b/mm/zblock.h
> index 9af11f392f97..d433237d6ad4 100644
> --- a/mm/zblock.h
> +++ b/mm/zblock.h
> @@ -10,13 +10,11 @@
>  #include <linux/rbtree.h>
>  #include <linux/types.h>
>  
> -#define SLOT_FREE 0
> -#define BIT_SLOT_OCCUPIED 0
> -#define BIT_SLOT_MAPPED 1
> +#define PAGE_SMALL_BLOCK	1
>  
>  #if PAGE_SIZE == 0x1000
> -/* max 128 slots per block, max table size 32 */
> -#define SLOT_BITS 7
> +/* max 64 slots per block, max table size 64 */
> +#define SLOT_BITS 6
>  #elif PAGE_SIZE == 0x4000
>  /* max 256 slots per block, max table size 64 */
>  #define SLOT_BITS 8
> @@ -25,24 +23,26 @@
>  #define SLOT_BITS 8
>  #endif
>  
> +#define MAX_TABLE_SIZE (1 << (PAGE_SHIFT - SLOT_BITS))
> +
>  #define MAX_SLOTS (1 << SLOT_BITS)
>  #define SLOT_MASK ((0x1UL << SLOT_BITS) - 1)
>  
>  #define ZBLOCK_HEADER_SIZE	round_up(sizeof(struct zblock_block), sizeof(long))
> -#define BLOCK_DATA_SIZE(order) ((PAGE_SIZE << order) - ZBLOCK_HEADER_SIZE)
> -#define SLOT_SIZE(nslots, order) (round_down((BLOCK_DATA_SIZE(order) / nslots), sizeof(long)))
> +#define BLOCK_DATA_SIZE(num) ((PAGE_SIZE * (num)) - ZBLOCK_HEADER_SIZE)
> +#define SLOT_SIZE(nslots, num) (round_down((BLOCK_DATA_SIZE(num) / nslots), sizeof(long)))
>  
>  /**
>   * struct zblock_block - block metadata
> - * Block consists of several (1/2/4/8) pages and contains fixed
> + * Block consists of several pages and contains fixed
>   * integer number of slots for allocating compressed pages.
>   *
>   * free_slots:	number of free slots in the block
>   * slot_info:	contains data about free/occupied slots
>   */
>  struct zblock_block {
> -	struct list_head link;
>  	DECLARE_BITMAP(slot_info, 1 << SLOT_BITS);
> +	struct list_head link;
>  	u32 free_slots;
>  };
>  
> @@ -54,12 +54,12 @@ struct zblock_block {
>   *
>   * slot_size:		size of slot for this list
>   * slots_per_block:	number of slots per block for this list
> - * order:		order for __get_free_pages
> + * num_pages:		number of pages per block
>   */
>  struct block_desc {
>  	unsigned int slot_size;
>  	unsigned short slots_per_block;
> -	unsigned short order;
> +	unsigned short num_pages;
>  };
>  
>  struct block_desc_node {
> @@ -71,78 +71,103 @@ struct block_desc_node {
>  
>  static const struct block_desc block_desc[] = {
>  #if PAGE_SIZE == 0x1000
> -	{ SLOT_SIZE(63, 0), 63, 0 },
> -	{ SLOT_SIZE(32, 0), 32, 0 },
> -	{ SLOT_SIZE(21, 0), 21, 0 },
> -	{ SLOT_SIZE(15, 0), 15, 0 },
> -	{ SLOT_SIZE(12, 0), 12, 0 },
> -	{ SLOT_SIZE(10, 0), 10, 0 },
> -	{ SLOT_SIZE(9, 0), 9, 0 },
> -	{ SLOT_SIZE(8, 0), 8, 0 },
> -	{ SLOT_SIZE(29, 2), 29, 2 },
> -	{ SLOT_SIZE(13, 1), 13, 1 },
> -	{ SLOT_SIZE(6, 0), 6, 0 },
> -	{ SLOT_SIZE(11, 1), 11, 1 },
> -	{ SLOT_SIZE(5, 0), 5, 0 },
> -	{ SLOT_SIZE(9, 1), 9, 1 },
> -	{ SLOT_SIZE(8, 1), 8, 1 },
> -	{ SLOT_SIZE(29, 3), 29, 3 },
> +	{ SLOT_SIZE(28, 1), 28, 1 },
> +	{ SLOT_SIZE(18, 1), 18, 1 },
> +	{ SLOT_SIZE(12, 1), 12, 1 },
> +	{ SLOT_SIZE(10, 1), 10, 1 },
> +	{ SLOT_SIZE(17, 2), 17, 2 },
> +	{ SLOT_SIZE(15, 2), 15, 2 },
>  	{ SLOT_SIZE(13, 2), 13, 2 },
> -	{ SLOT_SIZE(12, 2), 12, 2 },
> +	{ SLOT_SIZE(6, 1), 6, 1 },
>  	{ SLOT_SIZE(11, 2), 11, 2 },
> -	{ SLOT_SIZE(10, 2), 10, 2 },
> +	{ SLOT_SIZE(5, 1), 5, 1 },
> +	{ SLOT_SIZE(19, 4), 19, 4 },
>  	{ SLOT_SIZE(9, 2), 9, 2 },
> -	{ SLOT_SIZE(17, 3), 17, 3 },
> -	{ SLOT_SIZE(8, 2), 8, 2 },
> -	{ SLOT_SIZE(15, 3), 15, 3 },
> -	{ SLOT_SIZE(14, 3), 14, 3 },
> -	{ SLOT_SIZE(13, 3), 13, 3 },
> -	{ SLOT_SIZE(6, 2), 6, 2 },
> +	{ SLOT_SIZE(17, 4), 17, 4 },
> +	{ SLOT_SIZE(4, 1), 4, 1 },
> +	{ SLOT_SIZE(23, 6), 23, 6 },
>  	{ SLOT_SIZE(11, 3), 11, 3 },
> +	{ SLOT_SIZE(7, 2), 7, 2 },
>  	{ SLOT_SIZE(10, 3), 10, 3 },
> -	{ SLOT_SIZE(9, 3), 9, 3 },
> -	{ SLOT_SIZE(4, 2), 4, 2 },
> +	{ SLOT_SIZE(19, 6), 19, 6 },
> +	{ SLOT_SIZE(6, 2), 6, 2 },
> +	{ SLOT_SIZE(14, 5), 14, 5 },
> +	{ SLOT_SIZE(8, 3), 8, 3 },
> +	{ SLOT_SIZE(5, 2), 5, 2 },
> +	{ SLOT_SIZE(12, 5), 12, 5 },
> +	{ SLOT_SIZE(9, 4), 9, 4 },
> +	{ SLOT_SIZE(15, 7), 15, 7 },
> +	{ SLOT_SIZE(2, 1), 2, 1 },
> +	{ SLOT_SIZE(15, 8), 15, 8 },
> +	{ SLOT_SIZE(9, 5), 9, 5 },
> +	{ SLOT_SIZE(12, 7), 12, 7 },
> +	{ SLOT_SIZE(13, 8), 13, 8 },
> +	{ SLOT_SIZE(6, 4), 6, 4 },
> +	{ SLOT_SIZE(11, 8), 11, 8 },
> +	{ SLOT_SIZE(9, 7), 9, 7 },
> +	{ SLOT_SIZE(6, 5), 6, 5 },
> +	{ SLOT_SIZE(9, 8), 9, 8 },
> +	{ SLOT_SIZE(4, 4), 4, 4 },
>  #else
> -	{ SLOT_SIZE(255, 0), 255, 0 },
> -	{ SLOT_SIZE(185, 0), 185, 0 },
> -	{ SLOT_SIZE(145, 0), 145, 0 },
> -	{ SLOT_SIZE(113, 0), 113, 0 },
> -	{ SLOT_SIZE(92, 0), 92, 0 },
> -	{ SLOT_SIZE(75, 0), 75, 0 },
> -	{ SLOT_SIZE(60, 0), 60, 0 },
> -	{ SLOT_SIZE(51, 0), 51, 0 },
> -	{ SLOT_SIZE(43, 0), 43, 0 },
> -	{ SLOT_SIZE(37, 0), 37, 0 },
> -	{ SLOT_SIZE(32, 0), 32, 0 },
> -	{ SLOT_SIZE(27, 0), 27, 0 },
> -	{ SLOT_SIZE(23, 0), 23, 0 },
> -	{ SLOT_SIZE(19, 0), 19, 0 },
> -	{ SLOT_SIZE(17, 0), 17, 0 },
> -	{ SLOT_SIZE(15, 0), 15, 0 },
> -	{ SLOT_SIZE(13, 0), 13, 0 },
> -	{ SLOT_SIZE(11, 0), 11, 0 },
> -	{ SLOT_SIZE(10, 0), 10, 0 },
> -	{ SLOT_SIZE(9, 0), 9, 0 },
> -	{ SLOT_SIZE(8, 0), 8, 0 },
> -	{ SLOT_SIZE(15, 1), 15, 1 },
> -	{ SLOT_SIZE(14, 1), 14, 1 },
> -	{ SLOT_SIZE(13, 1), 13, 1 },
> +	{ SLOT_SIZE(185, 1), 185, 1 },
> +	{ SLOT_SIZE(113, 1), 113, 1 },
> +	{ SLOT_SIZE(86, 1), 86, 1 },
> +	{ SLOT_SIZE(72, 1), 72, 1 },
> +	{ SLOT_SIZE(58, 1), 58, 1 },
> +	{ SLOT_SIZE(49, 1), 49, 1 },
> +	{ SLOT_SIZE(42, 1), 42, 1 },
> +	{ SLOT_SIZE(37, 1), 37, 1 },
> +	{ SLOT_SIZE(33, 1), 33, 1 },
> +	{ SLOT_SIZE(59, 2), 59, 2 },
> +	{ SLOT_SIZE(27, 1), 27, 1 },
> +	{ SLOT_SIZE(25, 1), 25, 1 },
> +	{ SLOT_SIZE(23, 1), 23, 1 },
> +	{ SLOT_SIZE(21, 1), 21, 1 },
> +	{ SLOT_SIZE(39, 2), 39, 2 },
> +	{ SLOT_SIZE(37, 2), 37, 2 },
> +	{ SLOT_SIZE(35, 2), 35, 2 },
> +	{ SLOT_SIZE(33, 2), 33, 2 },
> +	{ SLOT_SIZE(31, 2), 31, 2 },
> +	{ SLOT_SIZE(29, 2), 29, 2 },
> +	{ SLOT_SIZE(27, 2), 27, 2 },
> +	{ SLOT_SIZE(25, 2), 25, 2 },
>  	{ SLOT_SIZE(12, 1), 12, 1 },
>  	{ SLOT_SIZE(11, 1), 11, 1 },
> +	{ SLOT_SIZE(21, 2), 21, 2 },
>  	{ SLOT_SIZE(10, 1), 10, 1 },
> +	{ SLOT_SIZE(19, 2), 19, 2 },
>  	{ SLOT_SIZE(9, 1), 9, 1 },
> +	{ SLOT_SIZE(17, 2), 17, 2 },
>  	{ SLOT_SIZE(8, 1), 8, 1 },
>  	{ SLOT_SIZE(15, 2), 15, 2 },
>  	{ SLOT_SIZE(14, 2), 14, 2 },
>  	{ SLOT_SIZE(13, 2), 13, 2 },
>  	{ SLOT_SIZE(12, 2), 12, 2 },
> +	{ SLOT_SIZE(23, 4), 23, 4 },
>  	{ SLOT_SIZE(11, 2), 11, 2 },
> +	{ SLOT_SIZE(21, 4), 21, 4 },
>  	{ SLOT_SIZE(10, 2), 10, 2 },
> +	{ SLOT_SIZE(19, 4), 19, 4 },
>  	{ SLOT_SIZE(9, 2), 9, 2 },
> +	{ SLOT_SIZE(17, 4), 17, 4 },
>  	{ SLOT_SIZE(8, 2), 8, 2 },
> -	{ SLOT_SIZE(7, 2), 7, 2 },
> -	{ SLOT_SIZE(6, 2), 6, 2 },
> +	{ SLOT_SIZE(15, 4), 15, 4 },
> +	{ SLOT_SIZE(14, 4), 14, 4 },
> +	{ SLOT_SIZE(10, 3), 10, 3 },
> +	{ SLOT_SIZE(16, 5), 16, 5 },
> +	{ SLOT_SIZE(12, 4), 12, 4 },
> +	{ SLOT_SIZE(11, 4), 11, 4 },
> +	{ SLOT_SIZE(8, 3), 8, 3 },
>  	{ SLOT_SIZE(5, 2), 5, 2 },
> +	{ SLOT_SIZE(7, 3), 7, 3 },
> +	{ SLOT_SIZE(11, 5), 11, 5 },
> +	{ SLOT_SIZE(4, 2), 4, 2 },
> +	{ SLOT_SIZE(9, 5), 9, 5 },
> +	{ SLOT_SIZE(8, 5), 8, 5 },
> +	{ SLOT_SIZE(3, 2), 3, 2 },
> +	{ SLOT_SIZE(4, 3), 4, 3 },
> +	{ SLOT_SIZE(7, 6), 7, 6 },
> +	{ SLOT_SIZE(4, 4), 4, 4 },
>  #endif /* PAGE_SIZE */
>  };
>  
> @@ -150,13 +175,11 @@ static const struct block_desc block_desc[] = {
>   * struct block_list - stores metadata of particular list
>   * lock:		protects the list of blocks
>   * active_list:		linked list of active (non-full) blocks
> - * full_list:		linked list of full blocks
>   * block_count:		total number of blocks in the list
>   */
>  struct block_list {
>  	spinlock_t lock;
>  	struct list_head active_list;
> -	struct list_head full_list;
>  	unsigned long block_count;
>  };
>  
> -- 
> 2.39.2
> 


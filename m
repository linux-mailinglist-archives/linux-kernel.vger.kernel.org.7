Return-Path: <linux-kernel+bounces-738020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BADE5B0B33D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 04:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9641177CC4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E494F18858C;
	Sun, 20 Jul 2025 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cnQXHhSo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895A1F92E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752980217; cv=none; b=HIq71AM3pahXl6yPjp9ZRl6pEO+oKBSXawQ/UgeCTLm4QoBL8PzDaaLoJkYl+zrw07bm4xT+Rfsw7+j0lWfEciMQIx330FLUCSnaZw5R8jZdqGtUpsC286b25R95WIOqZH8suuD6oMLyEHj3zv89XzdOCvFf69W78WmmxZmNg4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752980217; c=relaxed/simple;
	bh=GDoS+qRYwZQlgurvCArkJc0A3ZI7EBV9jx6OXSHHTYQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WH/5sykWigGSV1+wp5LE+BDslvYJlY0Zm7P9fQ6zieYx3fXZIUt5/6F0BdrkDXlEEVCUeCaruGjmhradT0nMn19NvfgUyj8PVLLt13Nr0eQcpwqZRifGO1hLi6OeqK/xp6pYOeOJ16RmiDN+2JtlC7MzR6lfXAXipUP7Fhzic9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cnQXHhSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDC3C4CEE3;
	Sun, 20 Jul 2025 02:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752980216;
	bh=GDoS+qRYwZQlgurvCArkJc0A3ZI7EBV9jx6OXSHHTYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cnQXHhSo7dwc13x+Yk/VTGyuE4Y3hFFay8GGrbFP2PAQ3FxGmYhTQE1qSlwDmOjMG
	 0VU9PQVUBtv9kbXxWgLPcoQ6Qo+UhpNztszz0nnkFHnLUy2GAojYmryn1dQ8VZQno/
	 Hq0RZmx9sD04JWko6vl6dr10OSGbztlErV7T+liM=
Date: Sat, 19 Jul 2025 19:56:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Nhat Pham
 <nphamcs@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner
 <hannes@cmpxchg.org>, Igor Belousov <igor.b@beldev.am>
Subject: Re: [PATCH v4] mm: add zblock allocator
Message-Id: <20250719195656.cd586785b04863b4bcfabb0c@linux-foundation.org>
In-Reply-To: <20250412154207.2152667-1-vitaly.wool@konsulko.se>
References: <20250412154207.2152667-1-vitaly.wool@konsulko.se>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Apr 2025 17:42:07 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:

> zblock is a special purpose allocator for storing compressed pages.
> It stores integer number of same size objects per its block. These
> blocks consist of several physical pages (2**n, i. e. 1/2/4/8).
> 
> With zblock, it is possible to densely arrange objects of various sizes
> resulting in low internal fragmentation. Also this allocator tries to
> fill incomplete blocks instead of adding new ones, in many cases
> providing a compression ratio comparable to zmalloc's.
> 
> zblock is also in most cases superior to zsmalloc with regard to
> average performance and worst execution times, thus allowing for better
> response time and real-time characteristics of the whole system.
> 
> High memory and page migration are currently not supported by zblock.

Well dang, I was about to drop zblock as this version (and its nine
-fix patches) have been in mm.git for three months without reported
issues and review is very stuck.

But I now realize that it has been in mm.git's mm-new branch for all
that time and has had no -next exposure.  Sorry about that.

So after the 6.17 release I'll move the patch into mm-unstable (and
hence linux-next) to get you some linux-next exposure.  After some time
there I expect I will drop the patch.

If you wish to persist with this I suggest you update the changelog to
address all review comments which have been received thus far and
resend.

Current version:

From: Vitaly Wool <vitaly.wool@konsulko.se>
Subject: mm: add zblock allocator
Date: Sat, 12 Apr 2025 17:42:07 +0200

zblock is a special purpose allocator for storing compressed pages.  It
stores integer number of same size objects per its block.  These blocks
consist of several physical pages (2**n, i.  e.  1/2/4/8).

With zblock, it is possible to densely arrange objects of various sizes
resulting in low internal fragmentation.  Also this allocator tries to
fill incomplete blocks instead of adding new ones, in many cases providing
a compression ratio comparable to zmalloc's.

zblock is also in most cases superior to zsmalloc with regard to average
performance and worst execution times, thus allowing for better response
time and real-time characteristics of the whole system.

High memory and page migration are currently not supported by zblock.

Test results (zstd compressor, 8 core Ryzen 9 VM, make bzImage):
- zblock:
    real	6m52.621s
    user	33m41.771s
    sys 	6m28.825s
    Zswap:            162328 kB
    Zswapped:         754468 kB
    zswpin 93851
    zswpout 542481
    zswpwb 935
- zsmalloc:
    real	7m4.355s
    user	34m37.538s
    sys 	6m22.086s
    zswpin 101243
    zswpout 448217
    zswpwb 640
    Zswap:            175704 kB
    Zswapped:         778692 kB

[akpm@linux-foundation.org: fix build]
[akpm@linux-foundation.org: export try_alloc_pages_noprof() to modules for CONFIG_ZBLOCK=m]
[akpm@linux-foundation.org: try_alloc_pages() was renamed]
[akpm@linux-foundation.org: fix kerneldoc for zblock_create_pool()]
[igor.b@beldev.am: add debugfs]
  Link: https://lkml.kernel.org/r/20250428064924.53496-1-igor.b@beldev.am
[igor.b@beldev.am: avoid failing the build]
  Link: https://lkml.kernel.org/r/20250428065727.57990-1-igor.b@beldev.am
[akpm@linux-foundation.org: s/#warn/#warning/]
[igor.b@beldev.am: use vmalloc for page allocations]
  Link: https://lkml.kernel.org/r/20250506220329.2355482-1-vitaly.wool@konsulko.se
[vitaly.wool@konsulko.se: make active_list rcu_list]
  Link: https://lkml.kernel.org/r/20250508122925.2600217-1-vitaly.wool@konsulko.se
Link: https://lkml.kernel.org/r/20250412154207.2152667-1-vitaly.wool@konsulko.se
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
Signed-off-by: Igor Belousov <igor.b@beldev.am>
Tested-by: Igor Belousov <igor.b@beldev.am>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/mm/zblock.rst |   24 +
 MAINTAINERS                 |    7 
 mm/Kconfig                  |   12 
 mm/Makefile                 |    1 
 mm/page_alloc.c             |    1 
 mm/zblock.c                 |  473 ++++++++++++++++++++++++++++++++++
 mm/zblock.h                 |  205 ++++++++++++++
 7 files changed, 723 insertions(+)

diff --git a/Documentation/mm/zblock.rst a/Documentation/mm/zblock.rst
new file mode 100644
--- /dev/null
+++ a/Documentation/mm/zblock.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+zblock
+======
+
+zblock is a special purpose allocator for storing compressed pages.
+It stores integer number of compressed objects per its block. These
+blocks consist of several physical pages (2**n, i. e. 1/2/4/8).
+
+With zblock, it is possible to densely arrange objects of various sizes
+resulting in low internal fragmentation. Also this allocator tries to
+fill incomplete blocks instead of adding new ones,  in many cases
+providing a compression ratio substantially higher than z3fold and zbud
+(though lower than zmalloc's).
+
+zblock does not require MMU to operate and also is superior to zsmalloc
+with regard to average performance and worst execution times, thus
+allowing for better response time and real-time characteristics of the
+whole system.
+
+E. g. on a series of stress-ng tests run on a Raspberry Pi 5, we get
+5-10% higher value for bogo ops/s in zblock/zsmalloc comparison.
+
--- a/MAINTAINERS~mm-add-zblock-allocator
+++ a/MAINTAINERS
@@ -27383,6 +27383,13 @@ F:	Documentation/networking/device_drive
 F:	drivers/net/hamradio/*scc.c
 F:	drivers/net/hamradio/z8530.h
 
+ZBLOCK COMPRESSED SLAB MEMORY ALLOCATOR
+M:	Vitaly Wool <vitaly.wool@konsulko.se>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/mm/zblock.rst
+F:	mm/zblock.[ch]
+
 ZD1211RW WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
--- a/mm/Kconfig~mm-add-zblock-allocator
+++ a/mm/Kconfig
@@ -152,6 +152,18 @@ config ZSWAP_ZPOOL_DEFAULT
        default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
        default ""
 
+config ZBLOCK
+	tristate "Fast compression allocator with high density"
+	depends on ZPOOL
+	help
+	  A special purpose allocator for storing compressed pages.
+	  It stores integer number of same size compressed objects per
+	  its block. These blocks consist of several physical pages
+	  (2**n, i. e. 1/2/4/8).
+
+	  With zblock, it is possible to densely arrange objects of
+	  various sizes resulting in low internal fragmentation.
+
 config ZSMALLOC
 	tristate
 	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)
--- a/mm/Makefile~mm-add-zblock-allocator
+++ a/mm/Makefile
@@ -116,6 +116,7 @@ obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_
 obj-$(CONFIG_PAGE_OWNER) += page_owner.o
 obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
 obj-$(CONFIG_ZPOOL)	+= zpool.o
+obj-$(CONFIG_ZBLOCK)	+= zblock.o
 obj-$(CONFIG_ZSMALLOC)	+= zsmalloc.o
 obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
 obj-$(CONFIG_CMA)	+= cma.o
--- a/mm/page_alloc.c~mm-add-zblock-allocator
+++ a/mm/page_alloc.c
@@ -7593,3 +7593,4 @@ struct page *alloc_pages_nolock_noprof(i
 	kmsan_alloc_page(page, order, alloc_gfp);
 	return page;
 }
+EXPORT_SYMBOL_GPL(alloc_pages_nolock_noprof);
diff --git a/mm/zblock.c a/mm/zblock.c
new file mode 100644
--- /dev/null
+++ a/mm/zblock.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * zblock.c
+ *
+ * Author: Vitaly Wool <vitaly.wool@konsulko.se>
+ * Based on the work from Ananda Badmaev <a.badmaev@clicknet.pro>
+ * Copyright (C) 2022-2025, Konsulko AB.
+ *
+ * Zblock is a small object allocator with the intention to serve as a
+ * zpool backend. It operates on page blocks which consist of number
+ * of physical pages being a power of 2 and store integer number of
+ * compressed pages per block which results in determinism and simplicity.
+ *
+ * zblock doesn't export any API and is meant to be used via zpool API.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/debugfs.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/preempt.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/vmalloc.h>
+#include <linux/zpool.h>
+#include "zblock.h"
+
+static struct rb_root block_desc_tree = RB_ROOT;
+static struct dentry *zblock_debugfs_root;
+
+/* Encode handle of a particular slot in the pool using metadata */
+static inline unsigned long metadata_to_handle(struct zblock_block *block, unsigned int slot)
+{
+	return (unsigned long)(block) | slot;
+}
+
+/* Return block, block type and slot in the pool corresponding to handle */
+static inline struct zblock_block *handle_to_metadata(unsigned long handle, unsigned int *slot)
+{
+	*slot = handle & SLOT_MASK;
+	return (struct zblock_block *)(handle & ~SLOT_MASK);
+}
+
+/*
+ * Find a block with at least one free slot and claim it.
+ * We make sure that the first block, if exists, will always work.
+ */
+static inline struct zblock_block *find_and_claim_block(struct block_list *b,
+		int block_type, unsigned long *handle)
+{
+	struct list_head *l = &b->active_list;
+	unsigned int slot;
+	struct zblock_block *z;
+
+	rcu_read_lock();
+retry_claim:
+	z = list_first_or_null_rcu(l, typeof(*z), link);
+	if (z) {
+		spin_lock(&b->lock);
+		if (unlikely(!z->free_slots)) {
+			spin_unlock(&b->lock);
+			goto retry_claim;
+		}
+		if (--z->free_slots == 0)
+			list_bidir_del_rcu(&z->link);
+		spin_unlock(&b->lock);
+		/*
+		 * There is a slot in the block and we just made sure it will
+		 * remain.
+		 * Find that slot and set the busy bit.
+		 */
+		for (slot = find_first_zero_bit(z->slot_info,
+					block_desc[block_type].slots_per_block);
+		     slot < block_desc[block_type].slots_per_block;
+		     slot = find_next_zero_bit(z->slot_info,
+					block_desc[block_type].slots_per_block,
+					slot)) {
+			if (!test_and_set_bit(slot, z->slot_info))
+				break;
+		}
+
+		*handle = metadata_to_handle(z, slot);
+	}
+	rcu_read_unlock();
+	return z;
+}
+
+/*
+ * allocate new block and add it to corresponding block list
+ */
+static struct zblock_block *alloc_block(struct zblock_pool *pool,
+					int block_type, gfp_t gfp,
+					unsigned long *handle,
+					unsigned int nid)
+{
+	struct block_list *block_list = &pool->block_lists[block_type];
+	unsigned int num_pages = block_desc[block_type].num_pages;
+	struct zblock_block *block;
+
+	block = __vmalloc_node(PAGE_SIZE * num_pages, PAGE_SIZE, gfp, nid, NULL);
+	if (!block)
+		return NULL;
+
+	/* init block data */
+	init_rcu_head(&block->rcu);
+	block->block_type = block_type;
+	block->free_slots = block_desc[block_type].slots_per_block - 1;
+	memset(&block->slot_info, 0, sizeof(block->slot_info));
+	set_bit(0, block->slot_info);
+	*handle = metadata_to_handle(block, 0);
+
+	spin_lock(&block_list->lock);
+	list_add_rcu(&block->link, &block_list->active_list);
+	block_list->block_count++;
+	spin_unlock(&block_list->lock);
+	return block;
+}
+
+static int zblock_blocks_show(struct seq_file *s, void *v)
+{
+	struct zblock_pool *pool = s->private;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(block_desc); i++) {
+		struct block_list *block_list = &pool->block_lists[i];
+
+		seq_printf(s, "%d: %ld blocks of %d pages (total %ld pages)\n",
+			i, block_list->block_count, block_desc[i].num_pages,
+			block_list->block_count * block_desc[i].num_pages);
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(zblock_blocks);
+
+/*****************
+ * API Functions
+ *****************/
+/**
+ * zblock_create_pool() - create a new zblock pool
+ * @gfp:	gfp flags when allocating the zblock pool structure
+ *
+ * Return: pointer to the new zblock pool or NULL if the metadata allocation
+ * failed.
+ */
+static struct zblock_pool *zblock_create_pool(gfp_t gfp)
+{
+	struct zblock_pool *pool = kmalloc(sizeof(struct zblock_pool), gfp);
+	int i;
+
+	if (!pool)
+		return NULL;
+
+	/* init each block list */
+	for (i = 0; i < ARRAY_SIZE(block_desc); i++) {
+		struct block_list *block_list = &pool->block_lists[i];
+
+		spin_lock_init(&block_list->lock);
+		INIT_LIST_HEAD(&block_list->active_list);
+		block_list->block_count = 0;
+	}
+
+	pool->block_header_cache = kmem_cache_create("zblock",
+						     sizeof(struct zblock_block),
+						     (1 << SLOT_BITS), 0, NULL);
+	if (!pool->block_header_cache)
+		goto out;
+
+	debugfs_create_file("blocks", S_IFREG | 0444, zblock_debugfs_root,
+			    pool, &zblock_blocks_fops);
+	return pool;
+
+out:
+	kfree(pool);
+	return NULL;
+}
+
+/**
+ * zblock_destroy_pool() - destroys an existing zblock pool
+ * @pool:	the zblock pool to be destroyed
+ *
+ */
+static void zblock_destroy_pool(struct zblock_pool *pool)
+{
+	kmem_cache_destroy(pool->block_header_cache);
+	kfree(pool);
+}
+
+
+/**
+ * zblock_alloc() - allocates a slot of appropriate size
+ * @pool:	zblock pool from which to allocate
+ * @size:	size in bytes of the desired allocation
+ * @gfp:	gfp flags used if the pool needs to grow
+ * @handle:	handle of the new allocation
+ *
+ * Return: 0 if success and handle is set, otherwise -EINVAL if the size or
+ * gfp arguments are invalid or -ENOMEM if the pool was unable to allocate
+ * a new slot.
+ */
+static int zblock_alloc(struct zblock_pool *pool, size_t size, gfp_t gfp,
+			unsigned long *handle, unsigned int nid)
+{
+	int block_type = -1;
+	struct zblock_block *block;
+	struct block_list *block_list;
+
+	if (!size)
+		return -EINVAL;
+
+	if (size > block_desc[ARRAY_SIZE(block_desc) - 1].slot_size)
+		return -ENOSPC;
+
+	/* find basic block type with suitable slot size */
+	if (size < block_desc[0].slot_size)
+		block_type = 0;
+	else {
+		struct block_desc_node *block_node;
+		struct rb_node *node = block_desc_tree.rb_node;
+
+		while (node) {
+			block_node = container_of(node, typeof(*block_node), node);
+			if (size < block_node->this_slot_size)
+				node = node->rb_left;
+			else if (size >= block_node->next_slot_size)
+				node = node->rb_right;
+			else {
+				block_type = block_node->block_idx + 1;
+				break;
+			}
+		}
+	}
+	if (WARN_ON(block_type < 0))
+		return -EINVAL;
+
+	block_list = &pool->block_lists[block_type];
+
+	block = find_and_claim_block(block_list, block_type, handle);
+	if (block)
+		return 0;
+
+	/* not found block with free slots try to allocate new empty block */
+	block = alloc_block(pool, block_type, gfp, handle, nid);
+	return block ? 0 : -ENOMEM;
+}
+
+/**
+ * zblock_free() - frees the allocation associated with the given handle
+ * @pool:	pool in which the allocation resided
+ * @handle:	handle associated with the allocation returned by zblock_alloc()
+ *
+ */
+static void zblock_free(struct zblock_pool *pool, unsigned long handle)
+{
+	unsigned int slot, block_type;
+	struct zblock_block *block;
+	struct block_list *block_list;
+
+	block = handle_to_metadata(handle, &slot);
+	block_type = block->block_type;
+	block_list = &pool->block_lists[block_type];
+
+	/* clear bit early, this will shorten the search */
+	clear_bit(slot, block->slot_info);
+
+	spin_lock(&block_list->lock);
+	/* if all slots in block are empty delete the whole block */
+	if (++block->free_slots == block_desc[block_type].slots_per_block) {
+		block_list->block_count--;
+		list_bidir_del_rcu(&block->link);
+		spin_unlock(&block_list->lock);
+		kvfree_rcu(block, rcu);
+		return;
+	} else if (block->free_slots == 1)
+		list_add_tail_rcu(&block->link, &block_list->active_list);
+	spin_unlock(&block_list->lock);
+}
+
+/**
+ * zblock_map() - maps the allocation associated with the given handle
+ * @pool:	pool in which the allocation resides
+ * @handle:	handle associated with the allocation to be mapped
+ *
+ *
+ * Returns: a pointer to the mapped allocation
+ */
+static void *zblock_map(struct zblock_pool *pool, unsigned long handle)
+{
+	unsigned int slot;
+	struct zblock_block *block = handle_to_metadata(handle, &slot);
+	unsigned long offs = ZBLOCK_HEADER_SIZE + slot * block_desc[block->block_type].slot_size;
+
+	return (void *)block + offs;
+}
+
+/**
+ * zblock_unmap() - unmaps the allocation associated with the given handle
+ * @pool:	pool in which the allocation resides
+ * @handle:	handle associated with the allocation to be unmapped
+ */
+static void zblock_unmap(struct zblock_pool *pool, unsigned long handle)
+{
+}
+
+/**
+ * zblock_write() - write to the memory area defined by handle
+ * @pool:	pool in which the allocation resides
+ * @handle:	handle associated with the allocation
+ * @handle_mem: pointer to source memory block
+ * @mem_len:	length of the memory block to write
+ */
+static void zblock_write(struct zblock_pool *pool, unsigned long handle,
+			 void *handle_mem, size_t mem_len)
+{
+	unsigned int slot;
+	struct zblock_block *block = handle_to_metadata(handle, &slot);
+	unsigned long offs = ZBLOCK_HEADER_SIZE + slot * block_desc[block->block_type].slot_size;
+
+	memcpy((void *)block + offs, handle_mem, mem_len);
+}
+
+/**
+ * zblock_get_total_pages() - gets the zblock pool size in pages
+ * @pool:	pool being queried
+ *
+ * Returns: size in bytes of the given pool.
+ */
+static u64 zblock_get_total_pages(struct zblock_pool *pool)
+{
+	u64 total_size;
+	int i;
+
+	total_size = 0;
+	for (i = 0; i < ARRAY_SIZE(block_desc); i++)
+		total_size += pool->block_lists[i].block_count * block_desc[i].num_pages;
+
+	return total_size;
+}
+
+/*****************
+ * zpool
+ ****************/
+
+static void *zblock_zpool_create(const char *name, gfp_t gfp)
+{
+	return zblock_create_pool(gfp);
+}
+
+static void zblock_zpool_destroy(void *pool)
+{
+	zblock_destroy_pool(pool);
+}
+
+static int zblock_zpool_malloc(void *pool, size_t size, gfp_t gfp,
+			unsigned long *handle, const int nid)
+{
+	return zblock_alloc(pool, size, gfp, handle, nid);
+}
+
+static void zblock_zpool_free(void *pool, unsigned long handle)
+{
+	zblock_free(pool, handle);
+}
+
+static void *zblock_zpool_read_begin(void *pool, unsigned long handle,
+				void *local_copy)
+{
+	return zblock_map(pool, handle);
+}
+
+static void zblock_zpool_obj_write(void *pool, unsigned long handle,
+				void *handle_mem, size_t mem_len)
+{
+	zblock_write(pool, handle, handle_mem, mem_len);
+}
+
+static void zblock_zpool_read_end(void *pool, unsigned long handle,
+				void *handle_mem)
+{
+	zblock_unmap(pool, handle);
+}
+
+static u64 zblock_zpool_total_pages(void *pool)
+{
+	return zblock_get_total_pages(pool);
+}
+
+static struct zpool_driver zblock_zpool_driver = {
+	.type =			"zblock",
+	.owner =		THIS_MODULE,
+	.create =		zblock_zpool_create,
+	.destroy =		zblock_zpool_destroy,
+	.malloc =		zblock_zpool_malloc,
+	.free =			zblock_zpool_free,
+	.obj_read_begin =	zblock_zpool_read_begin,
+	.obj_read_end =		zblock_zpool_read_end,
+	.obj_write =		zblock_zpool_obj_write,
+	.total_pages =		zblock_zpool_total_pages,
+};
+
+MODULE_ALIAS("zpool-zblock");
+
+static void delete_rbtree(void)
+{
+	while (!RB_EMPTY_ROOT(&block_desc_tree))
+		rb_erase(block_desc_tree.rb_node, &block_desc_tree);
+}
+
+static int __init create_rbtree(void)
+{
+	int i;
+
+	BUILD_BUG_ON(ARRAY_SIZE(block_desc) > MAX_TABLE_SIZE);
+	for (i = 0; i < ARRAY_SIZE(block_desc); i++) {
+		struct block_desc_node *block_node = kmalloc(sizeof(*block_node),
+							GFP_KERNEL);
+		struct rb_node **new = &block_desc_tree.rb_node, *parent = NULL;
+
+		if (!block_node) {
+			delete_rbtree();
+			return -ENOMEM;
+		}
+		if (i > 0 && block_desc[i].slot_size <= block_desc[i-1].slot_size) {
+			pr_err("%s: block descriptors not in ascending order\n",
+				__func__);
+			delete_rbtree();
+			return -EINVAL;
+		}
+		block_node->this_slot_size = block_desc[i].slot_size;
+		block_node->block_idx = i;
+		if (i == ARRAY_SIZE(block_desc) - 1)
+			block_node->next_slot_size = PAGE_SIZE * 2;
+		else
+			block_node->next_slot_size = block_desc[i+1].slot_size;
+		while (*new) {
+			parent = *new;
+			/* the array is sorted so we will always go to the right */
+			new = &((*new)->rb_right);
+		}
+		rb_link_node(&block_node->node, parent, new);
+		rb_insert_color(&block_node->node, &block_desc_tree);
+	}
+	return 0;
+}
+
+static int __init init_zblock(void)
+{
+	int ret = create_rbtree();
+
+	if (ret)
+		return ret;
+
+	zpool_register_driver(&zblock_zpool_driver);
+
+	zblock_debugfs_root = debugfs_create_dir("zblock", NULL);
+	return 0;
+}
+
+static void __exit exit_zblock(void)
+{
+	zpool_unregister_driver(&zblock_zpool_driver);
+	debugfs_remove_recursive(zblock_debugfs_root);
+	delete_rbtree();
+}
+
+module_init(init_zblock);
+module_exit(exit_zblock);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Vitaly Wool <vitaly.wool@konsulko.se>");
+MODULE_DESCRIPTION("Block allocator for compressed pages");
diff --git a/mm/zblock.h a/mm/zblock.h
new file mode 100644
--- /dev/null
+++ a/mm/zblock.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Vitaly Wool <vitaly.wool@konsulko.com>
+ * Copyright (C) 2025, Konsulko AB.
+ */
+#ifndef __ZBLOCK_H__
+#define __ZBLOCK_H__
+
+#include <linux/mm.h>
+#include <linux/rbtree.h>
+#include <linux/rculist.h>
+#include <linux/types.h>
+
+#if PAGE_SIZE == 0x1000
+/* max 64 slots per block, max table size 64 */
+#define SLOT_BITS 6
+#elif PAGE_SIZE == 0x4000
+/* max 256 slots per block, max table size 64 */
+#define SLOT_BITS 8
+#else
+#warning This PAGE_SIZE is not quite supported yet
+#define SLOT_BITS 8
+#endif
+
+#define MAX_TABLE_SIZE (1 << (PAGE_SHIFT - SLOT_BITS))
+
+#define MAX_SLOTS (1 << SLOT_BITS)
+#define SLOT_MASK ((0x1UL << SLOT_BITS) - 1)
+
+#define ZBLOCK_HEADER_SIZE	round_up(sizeof(struct zblock_block), sizeof(long))
+#define BLOCK_DATA_SIZE(num) ((PAGE_SIZE * (num)) - ZBLOCK_HEADER_SIZE)
+#define SLOT_SIZE(nslots, num) (round_down((BLOCK_DATA_SIZE(num) / nslots), sizeof(long)))
+#define ZBLOCK_MAX_PAGES_PER_BLOCK	8
+
+/**
+ * struct zblock_block - block metadata
+ * Block consists of several pages and contains fixed
+ * integer number of slots for allocating compressed pages.
+ *
+ * free_slots:	number of free slots in the block
+ * slot_info:	contains data about free/occupied slots
+ */
+struct zblock_block {
+	DECLARE_BITMAP(slot_info, 1 << SLOT_BITS);
+	struct list_head link;
+	struct rcu_head rcu;
+	unsigned short block_type;
+	unsigned short free_slots;
+};
+
+/**
+ * struct block_desc - general metadata for block lists
+ * Each block list stores only blocks of corresponding type which means
+ * that all blocks in it have the same number and size of slots.
+ * All slots are aligned to size of long.
+ *
+ * slot_size:		size of slot for this list
+ * slots_per_block:	number of slots per block for this list
+ * num_pages:		number of pages per block
+ */
+struct block_desc {
+	unsigned int slot_size;
+	unsigned short slots_per_block;
+	unsigned short num_pages;
+};
+
+struct block_desc_node {
+	struct rb_node node;
+	unsigned int this_slot_size;
+	unsigned int next_slot_size;
+	unsigned int block_idx;
+};
+
+static const struct block_desc block_desc[] = {
+#if PAGE_SIZE == 0x1000
+	{ SLOT_SIZE(28, 1), 28, 1 },
+	{ SLOT_SIZE(18, 1), 18, 1 },
+	{ SLOT_SIZE(12, 1), 12, 1 },
+	{ SLOT_SIZE(10, 1), 10, 1 },
+	{ SLOT_SIZE(17, 2), 17, 2 },
+	{ SLOT_SIZE(15, 2), 15, 2 },
+	{ SLOT_SIZE(13, 2), 13, 2 },
+	{ SLOT_SIZE(6, 1), 6, 1 },
+	{ SLOT_SIZE(11, 2), 11, 2 },
+	{ SLOT_SIZE(5, 1), 5, 1 },
+	{ SLOT_SIZE(19, 4), 19, 4 },
+	{ SLOT_SIZE(9, 2), 9, 2 },
+	{ SLOT_SIZE(17, 4), 17, 4 },
+	{ SLOT_SIZE(4, 1), 4, 1 },
+	{ SLOT_SIZE(23, 6), 23, 6 },
+	{ SLOT_SIZE(11, 3), 11, 3 },
+	{ SLOT_SIZE(7, 2), 7, 2 },
+	{ SLOT_SIZE(10, 3), 10, 3 },
+	{ SLOT_SIZE(19, 6), 19, 6 },
+	{ SLOT_SIZE(6, 2), 6, 2 },
+	{ SLOT_SIZE(14, 5), 14, 5 },
+	{ SLOT_SIZE(8, 3), 8, 3 },
+	{ SLOT_SIZE(5, 2), 5, 2 },
+	{ SLOT_SIZE(12, 5), 12, 5 },
+	{ SLOT_SIZE(9, 4), 9, 4 },
+	{ SLOT_SIZE(15, 7), 15, 7 },
+	{ SLOT_SIZE(2, 1), 2, 1 },
+	{ SLOT_SIZE(15, 8), 15, 8 },
+	{ SLOT_SIZE(9, 5), 9, 5 },
+	{ SLOT_SIZE(12, 7), 12, 7 },
+	{ SLOT_SIZE(13, 8), 13, 8 },
+	{ SLOT_SIZE(6, 4), 6, 4 },
+	{ SLOT_SIZE(11, 8), 11, 8 },
+	{ SLOT_SIZE(9, 7), 9, 7 },
+	{ SLOT_SIZE(6, 5), 6, 5 },
+	{ SLOT_SIZE(9, 8), 9, 8 },
+	{ SLOT_SIZE(4, 4), 4, 4 },
+#else
+	{ SLOT_SIZE(185, 1), 185, 1 },
+	{ SLOT_SIZE(113, 1), 113, 1 },
+	{ SLOT_SIZE(86, 1), 86, 1 },
+	{ SLOT_SIZE(72, 1), 72, 1 },
+	{ SLOT_SIZE(58, 1), 58, 1 },
+	{ SLOT_SIZE(49, 1), 49, 1 },
+	{ SLOT_SIZE(42, 1), 42, 1 },
+	{ SLOT_SIZE(37, 1), 37, 1 },
+	{ SLOT_SIZE(33, 1), 33, 1 },
+	{ SLOT_SIZE(59, 2), 59, 2 },
+	{ SLOT_SIZE(27, 1), 27, 1 },
+	{ SLOT_SIZE(25, 1), 25, 1 },
+	{ SLOT_SIZE(23, 1), 23, 1 },
+	{ SLOT_SIZE(21, 1), 21, 1 },
+	{ SLOT_SIZE(39, 2), 39, 2 },
+	{ SLOT_SIZE(37, 2), 37, 2 },
+	{ SLOT_SIZE(35, 2), 35, 2 },
+	{ SLOT_SIZE(33, 2), 33, 2 },
+	{ SLOT_SIZE(31, 2), 31, 2 },
+	{ SLOT_SIZE(29, 2), 29, 2 },
+	{ SLOT_SIZE(27, 2), 27, 2 },
+	{ SLOT_SIZE(25, 2), 25, 2 },
+	{ SLOT_SIZE(12, 1), 12, 1 },
+	{ SLOT_SIZE(11, 1), 11, 1 },
+	{ SLOT_SIZE(21, 2), 21, 2 },
+	{ SLOT_SIZE(10, 1), 10, 1 },
+	{ SLOT_SIZE(19, 2), 19, 2 },
+	{ SLOT_SIZE(9, 1), 9, 1 },
+	{ SLOT_SIZE(17, 2), 17, 2 },
+	{ SLOT_SIZE(8, 1), 8, 1 },
+	{ SLOT_SIZE(15, 2), 15, 2 },
+	{ SLOT_SIZE(14, 2), 14, 2 },
+	{ SLOT_SIZE(27, 4), 27, 4 },
+	{ SLOT_SIZE(13, 2), 13, 2 },
+	{ SLOT_SIZE(25, 4), 25, 4 },
+	{ SLOT_SIZE(12, 2), 12, 2 },
+	{ SLOT_SIZE(23, 4), 23, 4 },
+	{ SLOT_SIZE(11, 2), 11, 2 },
+	{ SLOT_SIZE(21, 4), 21, 4 },
+	{ SLOT_SIZE(10, 2), 10, 2 },
+	{ SLOT_SIZE(19, 4), 19, 4 },
+	{ SLOT_SIZE(9, 2), 9, 2 },
+	{ SLOT_SIZE(17, 4), 17, 4 },
+	{ SLOT_SIZE(4, 1), 4, 1 },
+	{ SLOT_SIZE(23, 6), 23, 6 },
+	{ SLOT_SIZE(11, 3), 11, 3 },
+	{ SLOT_SIZE(7, 2), 7, 2 },
+	{ SLOT_SIZE(10, 3), 10, 3 },
+	{ SLOT_SIZE(16, 5), 16, 5 },
+	{ SLOT_SIZE(6, 2), 6, 2 },
+	{ SLOT_SIZE(11, 4), 11, 4 },
+	{ SLOT_SIZE(8, 3), 8, 3 },
+	{ SLOT_SIZE(5, 2), 5, 2 },
+	{ SLOT_SIZE(7, 3), 7, 3 },
+	{ SLOT_SIZE(11, 5), 11, 5 },
+	{ SLOT_SIZE(4, 2), 4, 2 },
+	{ SLOT_SIZE(9, 5), 9, 5 },
+	{ SLOT_SIZE(8, 5), 8, 5 },
+	{ SLOT_SIZE(3, 2), 3, 2 },
+	{ SLOT_SIZE(7, 6), 7, 6 },
+	{ SLOT_SIZE(4, 4), 4, 4 },
+#endif /* PAGE_SIZE */
+};
+
+/**
+ * struct block_list - stores metadata of particular list
+ * lock:		protects the list of blocks
+ * active_list:		linked list of active (non-full) blocks
+ * block_count:		total number of blocks in the list
+ */
+struct block_list {
+	spinlock_t lock;
+	struct list_head active_list;
+	unsigned long block_count;
+};
+
+/**
+ * struct zblock_pool - stores metadata for each zblock pool
+ * @block_lists:	array of block lists
+ * @zpool:		zpool driver
+ *
+ * This structure is allocated at pool creation time and maintains metadata
+ * for a particular zblock pool.
+ */
+struct zblock_pool {
+	struct block_list block_lists[ARRAY_SIZE(block_desc)];
+	struct kmem_cache *block_header_cache;
+	struct zpool *zpool;
+};
+
+
+#endif
_



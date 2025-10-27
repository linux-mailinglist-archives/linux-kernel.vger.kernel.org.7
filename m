Return-Path: <linux-kernel+bounces-871458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F962C0D5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E40A40710E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F8E3002CE;
	Mon, 27 Oct 2025 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYFQX64H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78892FF645
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566037; cv=none; b=nq30LYLevODytq7lpardbNLtAtpeHUm7cHNL5C/eOwnGO7hbtx3CYz4t5gbux4JeMVqqSydRgvXmXOoQGXbHk1/GyxiDH1QeX7jz72aorT7aayo9/qc7aCou7M/HfUVcoaSVZx8FVICIBl2kJW4YDXh91CWLlEHoUwWwpB5VUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566037; c=relaxed/simple;
	bh=mEcXfEJHQwC/0GY9cUemzKJV7wKJTXWdbECdehbeaao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSBx65DivvGKEgY1ySIifdNnf5kgQ2wUzXUbfdo3/BueigU75odUDk9ZPAP77Q/EvgCkuTtov6ex80AEXpppc55XuqnvZsfywtEuJUFIIPyPeqGLxwzw/h45F6LV1Bkl5Vm/lIyKXUrqqAzaEskmZLpPyyjMYn3dKuwFEExJRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYFQX64H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E48C4CEF1;
	Mon, 27 Oct 2025 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761566037;
	bh=mEcXfEJHQwC/0GY9cUemzKJV7wKJTXWdbECdehbeaao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYFQX64HJqMpdTlFS3SzfZf0QfTy3EsiHDcN6GyI3a1dmqIWb3TTjYrXV4DONsmqj
	 zzqPPGeko0sVOH6jNTdiWJU52+WLTP4Wf7GWzrk9CU8xo+e/iW1oqF2fBuKSNxRng9
	 NL5YD9T5Eq5Y/rxfVm+7FwkjBiHS3TZEC3avgOdeepKR9urbfwJIySY9F4c02RgmjX
	 G6PuERtWHFWGyGAyZyfo5uuVjV/ZK/TV6UznbJeCD4+q3nbjVsVZmiyg15Du4ZvvWN
	 3SEUPRa1qEq7nLDGjdXmoFFRnxCZ5ykV91axLppjuosVubxV6momXCbjS+StdO27e1
	 0TNGKR+GKWheA==
Date: Mon, 27 Oct 2025 13:53:48 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
Message-ID: <aP9dTNhZ4LduuXb3@kernel.org>
References: <20251020100306.2709352-1-jasonmiu@google.com>
 <20251020100306.2709352-2-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020100306.2709352-2-jasonmiu@google.com>

On Mon, Oct 20, 2025 at 03:03:04AM -0700, Jason Miu wrote:
> Introduce a radix tree data structure for tracking preserved
> memory pages in KHO, which will replace the current xarray-based
> implementation.
> 
> The primary motivation for this change is to eliminate the need for
> serialization. By marking preserved pages directly in the new KHO
> radix tree and passing them to the next kernel, the entire
> serialization process can be removed. This ultimately allows for the
> removal of the KHO finalize and abort states, simplifying the overall
> design.
> 
> The preserved page physical address and its order are encoded in to a
> value. The KHO radix tree has multiple level of nodes where each node
> is a table contining a descriptor to the next level of nodes. The
> encoded value get split and stored its parts along the tree
> traversal. The tree traversal ends with the `kho_bitmap_table`, where
> each bit represents a single preserved page.
> 
> Instead of serializing the memory map, the first kernel store the KHO
> radix tree root in the FDT. This KHO radix tree root is passed to the
> second kernel after kexec, hence elimitated the KHO finalize and abort
> states.
> 
> The second kernel walks the passed-in KHO radix tree from its root. It
> restores the memory pages and their orders by decoding the value
> stored in the KHO radix tree.
> 
> This architectural shift to using a shared radix tree structure
> simplifies the KHO design and eliminates the overhead of serializing
> and deserializing the preserved memory map.
> 
> Signed-off-by: Jason Miu <jasonmiu@google.com>
> ---
>  MAINTAINERS                                   |   2 +
>  include/linux/kexec_handover.h                |  23 +-
>  .../linux/live_update/abi/kexec_handover.h    |  10 +
>  kernel/kexec_handover.c                       | 861 +++++++++---------
>  4 files changed, 458 insertions(+), 438 deletions(-)
>  create mode 100644 include/linux/live_update/abi/kexec_handover.h
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 348844cffb13..bc2f9e060a79 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -45,6 +28,7 @@ int kho_preserve_folio(struct folio *folio);
>  int kho_preserve_phys(phys_addr_t phys, size_t size);
>  struct folio *kho_restore_folio(phys_addr_t phys);
>  int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
> +int kho_remove_subtree(const char *name);

This change seems unrelated.

>  int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
>  
>  int register_kho_notifier(struct notifier_block *nb);
> @@ -86,6 +70,11 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int kho_remove_subtree(const char *name)
> +{
> +	return -EOPNOTSUPP;
> +}
> +

Ditto.

>  static inline int register_kho_notifier(struct notifier_block *nb)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/include/linux/live_update/abi/kexec_handover.h b/include/linux/live_update/abi/kexec_handover.h
> new file mode 100644
> index 000000000000..3154e5c33851
> --- /dev/null
> +++ b/include/linux/live_update/abi/kexec_handover.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ABI__KEXEC_HANDOVER_H
> +#define _ABI__KEXEC_HANDOVER_H
> +
> +#define KHO_FDT_COMPATIBLE "kho-v2"
> +#define PROP_PRESERVED_PAGE_RADIX_TREE "preserved-page-radix-tree"

The property describes the preserved memory, it's not important if it's a
radix tree, a linked list or whatever else, so I don't think
page-radix-tree is a good name.

IMHO we can keep the preserved-memory-map name because version bump ensures
we won't attempt to parse v1 data structure.

> +#define PROP_SUB_FDT "fdt"
> +
> +#endif
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index ecd1ac210dbd..2fc5975690a7 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -46,143 +45,305 @@ static int __init kho_parse_enable(char *p)
>  }
>  early_param("kho", kho_parse_enable);
>  
> +typedef int (*kho_radix_tree_walk_callback_t)(unsigned long encoded);
> +
>  /*
> - * Keep track of memory that is to be preserved across KHO.

Please leave this sentence.

> + * The KHO radix tree tracks preserved memory pages. It is a hierarchical
> + * structure that starts with a single root `kho_radix_tree`. This single
> + * tree stores pages of all orders.

I'd combine this comment and the comment above declaration of enum
kho_radix_consts into something like this:

/*
 * KHO tracks preserved memory using a radix tree data structure. Each node of
 * the tree is PAGE_SIZE and it is PAGE_SIZE aligned.
 *
 * The leaf nodes of the tree are bitmaps where each set bit represents a
 * single preserved page. The intermediate and root nodes of the tree are
 * tables of physical addresses that point to a lower level node:
 *
 * kho_radix_tree_root
 * +-------------------+
 * |     Level 5       | (struct kho_radix_tree)
 * +-------------------+
 *   |
 *   v
 * +-------------------+
 * |     Level 4       | (struct kho_radix_tree)
 * +-------------------+
 *   |
 *   | ... (intermediate levels)
 *   |
 *   v
 * +-------------------+
 * |      Level 0      | (struct kho_bitmap_table)
 * +-------------------+
 *
 * The physical address of the preserved page and its order are encoded into a
 * single unsigned long value where higher bits represent the order and the
 * lower bits represent the page offset:
 *
 *   <-- Higher Bits ------------------------------------ Lower Bits -->
 *  +--------------------------+-----------------------------------------+
 *  |        Order Bits        |               Page Offset               |
 *  +--------------------------+-----------------------------------------+
 *  |0| ... 0 0 0 1            | pa >> (PAGE_SHIFT + 0)                  |
 *  |1| ... 0 0 0 0 1            | pa >> (PAGE_SHIFT + 1)                |
 *  |2| ... 0 0 0 0 0 1            | pa >> (PAGE_SHIFT + 2)              |
 *  +------------------------------+-------------------------------------+
 *                  ^
 *                  |
 *  This single '1' bit's position uniquely identifies the 'order'.
 *
 * Page Offset:
 * The 'page offset' is the physical address normalized for its order. It
 * effectively represents the page offset for the given order.
 *
 * Order Bits:
 * The 'order bits' encode the page order by setting a single bit at a
 * specific position. The position of this bit itself represents the order.
 *
 * For instance, on a 64-bit system with 4KB pages (PAGE_SHIFT = 12), the
 * maximum range for a page offset (for order 0) is 52 bits (64 - 12). This
 * offset occupies bits [0-51]. For order 0, the order bit is set at
 * position 52.
 *
 * As the order increases, the number of bits required for the 'page offset'
 * decreases. For example, order 1 requires one less bit for its page
 * offset. This allows its order bit to be set at position 51,
 * i.e. shifting right, without conflicting with the page offset bits.
 *
 * Bitfields in this encoded value are used as indices into the tables for
 * upper levels and as bitmap index for the lowest level.
 *
 * The following diagram illustrates how the encoded value is split into
 * indices for the tree levels, with PAGE_SIZE of 4KB:
 *
 *      63:60   59:51    50:42    41:33    32:24    23:15         14:0
 * +---------+--------+--------+--------+--------+--------+-----------------+
 * |    0    |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1  |  Lv 0 (bitmap)  |
 * +---------+--------+--------+--------+--------+--------+-----------------+
 *
 * This design stores pages of all sizes (orders) in a single 6-level table.
 * It efficiently shares lower table levels, especially due to common zero top
 * address bits, allowing a single, efficient algorithm to manage all pages.
 *
 * < a paragraph about memory consumption >
 */

> + *
> + * This is achieved by encoding the page's physical address and its order into
> + * a single `unsigned long` value. This encoded value is then used to traverse
> + * the tree.

...

> + * Each `kho_radix_tree` (Levels 1-5) and `kho_bitmap_table` (Level 0) is
> + * PAGE_SIZE. Each entry in a `kho_radix_tree` is a descriptor (a physical
> + * address) pointing to the next level node. For Level 1 `kho_radix_tree`
> + * nodes, these descriptors point to a `kho_bitmap_table`. The final
> + * `kho_bitmap_table` is a bitmap where each set bit represents a single
> + * preserved page.
>   */

Please add an empty line between description and the declaration.

> +struct kho_radix_tree {

I think the name should reflect that this data structure is for tracking
memory in KHO. Otherwise it reads like a generic data structure that can be
used with KHO, like kho_array Pratyush proposed a while ago.

Maybe struct kho_mem_radix_tree? Or even drop the 'radix', I don't think
it's really important here.

> +	phys_addr_t table[PAGE_SIZE / sizeof(phys_addr_t)];
> +};
>  
> -#define PRESERVE_BITS (512 * 8)
> -
> -struct kho_mem_phys_bits {
> -	DECLARE_BITMAP(preserve, PRESERVE_BITS);
> +struct kho_bitmap_table {
> +	unsigned long bitmaps[PAGE_SIZE / sizeof(unsigned long)];

What's wrong with kho_mem_phys_bits and DECLARE_BITMAP?
Simply adjust PRESERVE_BITS to match PAGE_SIZE.

>  };
>  
> -struct kho_mem_phys {
> +/*
> + * The KHO radix tree tracks preserved pages by encoding a page's physical

...

> + * address bits, allowing a single, efficient algorithm to manage all pages.
> + */
> +enum kho_radix_consts {

I think this should be declared before the structs, so that there will be
one long description before the enum, structs and code.

> +	/* The bit position of a 0-order page, only supports 64bits system */
> +	ORDER_0_LG2 = 64 - PAGE_SHIFT,
> +	/* Bit number used for each level of tables */
> +	TABLE_SIZE_LG2 = const_ilog2(PAGE_SIZE / sizeof(phys_addr_t)),
> +	/* Bit number used for lowest level of bitmaps */
> +	BITMAP_SIZE_LG2 = PAGE_SHIFT + const_ilog2(BITS_PER_BYTE),
>  	/*
> -	 * Points to kho_mem_phys_bits, a sparse bitmap array. Each bit is sized
> -	 * to order.
> +	 * The total tree depth is the number of intermediate levels
> +	 * and 1 bitmap level.
>  	 */
> -	struct xarray phys_bits;
> +	TREE_MAX_DEPTH = DIV_ROUND_UP(ORDER_0_LG2 - BITMAP_SIZE_LG2,
> +				      TABLE_SIZE_LG2) + 1,
>  };
>  
> -struct kho_mem_track {
> -	/* Points to kho_mem_phys, each order gets its own bitmap tree */
> -	struct xarray orders;
> -};
> +/*
> + * `kho_radix_tree_root` points to a page thats serves as the root of the
> + * KHO radix tree. This page is allocated during KHO module initialization.
> + * Its physical address is written to the FDT and passed to the next kernel
> + * during kexec.
> + */
> +static struct kho_radix_tree *kho_radix_tree_root;
> +static DECLARE_RWSEM(kho_radix_tree_root_sem);

I believe it's clearer to have struct kho_mem_track containing the pointer
to root and the semaphore, e.g.

struct kho_mem_track {
	struct kho_mem_tree *root;
	struct rw_semaphore sem;
};
  
> -struct khoser_mem_chunk;
> +static inline phys_addr_t kho_radix_tree_desc(struct kho_radix_tree *va)

I think kho_mem_tree is a better prefix than kho_radix.

> +{
> +	return (phys_addr_t)virt_to_phys(va);
> +}
>  
> -struct kho_serialization {
> -	struct page *fdt;
> -	struct list_head fdt_list;
> -	struct dentry *sub_fdt_dir;
> -	struct kho_mem_track track;
> -	/* First chunk of serialized preserved memory map */
> -	struct khoser_mem_chunk *preserved_mem_map;
> -};
> +static inline struct kho_radix_tree *kho_radix_tree(phys_addr_t desc)

This is not really a 'desc', this is a plain physical address, i.e. 'pa'.
It's probably will be clearer to just use phys_to_virt() and virt_to_phys()
directly rather than introduce these wrappers.

> +{
> +	return (struct kho_radix_tree *)(phys_to_virt(desc));
> +}
>  
> -static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
> +static struct kho_radix_tree *kho_alloc_radix_tree(void)
>  {
> -	void *elm, *res;
> +	return (struct kho_radix_tree *)get_zeroed_page(GFP_KERNEL);
> +}
>  
> -	elm = xa_load(xa, index);
> -	if (elm)
> -		return elm;
> +static unsigned long kho_radix_encode(phys_addr_t pa, unsigned int order)

This name is really cryptic. Encode to what? Can't say I have great ideas,
but this name should reflect that physical address and order are encoded
into combined index into the tree.

Maybe _encode_indices()?

> +{
> +	/* Order bits part */
> +	unsigned long h = 1UL << (ORDER_0_LG2 - order);
> +	/* Page offset part */
> +	unsigned long l = pa >> (PAGE_SHIFT + order);
>  
> -	elm = kzalloc(sz, GFP_KERNEL);
> -	if (!elm)
> -		return ERR_PTR(-ENOMEM);
> +	return h | l;
> +}
>  
> -	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
> -	if (xa_is_err(res))
> -		res = ERR_PTR(xa_err(res));
> +static phys_addr_t kho_radix_decode(unsigned long encoded, unsigned int *order)

The same here. Maybe

	_decode_indices(unsigned long indices, unsigned int *order)

> +{
> +	unsigned int order_bit = fls64(encoded);
> +	phys_addr_t pa;
>  
> -	if (res) {
> -		kfree(elm);
> -		return res;
> -	}
> +	/* order_bit is numbered starting at 1 from fls64 */
> +	*order = ORDER_0_LG2 - order_bit + 1;
> +	/* The order is discarded by the shift */
> +	pa = encoded << (PAGE_SHIFT + *order);
>  
> -	return elm;
> +	return pa;
>  }
>  
> -static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
> -			     unsigned long end_pfn)
> +static unsigned long kho_radix_get_index(unsigned long encoded,

I don't like 'encoded' here and below as well.

> +					 unsigned int level)
>  {
> -	struct kho_mem_phys_bits *bits;
> -	struct kho_mem_phys *physxa;
> -
> -	while (pfn < end_pfn) {
> -		const unsigned int order =
> -			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> -		const unsigned long pfn_high = pfn >> order;
> +	int s;
>  
> -		physxa = xa_load(&track->orders, order);
> -		if (!physxa)
> -			continue;
> +	if (level == 0)
> +		return encoded % (1 << BITMAP_SIZE_LG2);
>  
> -		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
> -		if (!bits)
> -			continue;
> +	s = ((level - 1) * TABLE_SIZE_LG2) + BITMAP_SIZE_LG2;
> +	return (encoded >> s) % (1 << TABLE_SIZE_LG2);
> +}
>  
> -		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
> +static int kho_radix_set_bitmap(struct kho_bitmap_table *bit_tlb,

                                                           ^ bitmap

> +				unsigned long offset)
> +{
> +	if (!bit_tlb ||
> +	    offset >= PAGE_SIZE * BITS_PER_BYTE)

No need for two lines here

> +		return -EINVAL;
>  
> -		pfn += 1 << order;
> -	}
> +	__set_bit(offset, bit_tlb->bitmaps);
> +	return 0;
>  }
>  
> -static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
> -				unsigned int order)
> +static int kho_radix_preserve_page(phys_addr_t pa, unsigned int order)
>  {
> -	struct kho_mem_phys_bits *bits;
> -	struct kho_mem_phys *physxa, *new_physxa;
> -	const unsigned long pfn_high = pfn >> order;
> +	unsigned long encoded = kho_radix_encode(pa, order);
> +	struct kho_radix_tree *current_tree, *new_tree;

current_ is excessive IMHO and 'node' seems to be a better name for a tree
iterator:

	struct kho_radix_tree *node;

is fine, the new_tree can be declared in the scope that uses it.

> +	struct kho_bitmap_table *bitmap_table;

_table is excessive on both the type name and variable name

> +	unsigned int tree_level = TREE_MAX_DEPTH - 1;

Just 'level' is enough.

> +	unsigned int err = 0;

err is signed.

> +	unsigned int i, idx;
>  
> -	might_sleep();
> +	down_write(&kho_radix_tree_root_sem);
>  
> -	physxa = xa_load(&track->orders, order);
> -	if (!physxa) {
> -		int err;
> +	if (!kho_radix_tree_root) {

Isn't this an assert? 
Also I don't see concurrency for accessing the root, the assertion can be
outside the lock.

> +		err = -EINVAL;
> +		goto out;
> +	}
>  
> -		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
> -		if (!new_physxa)
> -			return -ENOMEM;
> +	current_tree = kho_radix_tree_root;
>  
> -		xa_init(&new_physxa->phys_bits);
> -		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
> -				    GFP_KERNEL);
> +	/* Go from high levels to low levels */
> +	for (i = tree_level; i >= 0; i--) {
> +		idx = kho_radix_get_index(encoded, i);
>  
> -		err = xa_err(physxa);
> -		if (err || physxa) {
> -			xa_destroy(&new_physxa->phys_bits);
> -			kfree(new_physxa);
> +		if (i == 0) {
> +			bitmap_table = (struct kho_bitmap_table *)current_tree;
> +			err = kho_radix_set_bitmap(bitmap_table, idx);

I'd consider making the loop until 'i > 0' and putting this outside the
loop.

> +			goto out;
> +		}
> +

		if (node->table[idx]) {
			node = kho_radix_tree(node->table[idx]);
			continue;
		}

and reduce the indentation for allocating a new table.

> +		if (!current_tree->table[idx]) {
> +			new_tree = kho_alloc_radix_tree();
> +			if (!new_tree) {
> +				err = -ENOMEM;
> +				goto out;
> +			}
>  
> -			if (err)
> -				return err;
> +			current_tree->table[idx] =
> +				kho_radix_tree_desc(new_tree);
> +			current_tree = new_tree;
>  		} else {
> -			physxa = new_physxa;
> +			current_tree = kho_radix_tree(current_tree->table[idx]);
>  		}
>  	}
>  
> -	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
> -				sizeof(*bits));
> -	if (IS_ERR(bits))
> -		return PTR_ERR(bits);
> +out:
> +	up_write(&kho_radix_tree_root_sem);
> +	return err;
> +}
> +
> +static int kho_radix_walk_bitmaps(struct kho_bitmap_table *bit_tlb,
> +				  unsigned long encoded,
> +				  kho_radix_tree_walk_callback_t cb)
> +{
> +	unsigned long *bitmap = (unsigned long *)bit_tlb;
> +	unsigned int i;
> +	int err = 0;
> +
> +	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
> +		err = cb(encoded | i);
> +		if (err)
> +			return err;
> +	}
>  
> -	set_bit(pfn_high % PRESERVE_BITS, bits->preserve);
> +	return 0;
> +}
> +
> +static int kho_radix_walk_trees(struct kho_radix_tree *root, unsigned int level,

static int kho_radix_walk_tree(struct kho_radix_tree *parent, ...

> +				unsigned long start,
> +				kho_radix_tree_walk_callback_t cb)
> +{
> +	struct kho_radix_tree *next_tree;

	struct kho_radix_tree *node;

> +	struct kho_bitmap_table *bitmap_table;

                                ^ bitmap;

> +	unsigned long encoded, i;
> +	unsigned int level_shift;

This can move to the scope where it's used and 'shift' would be enough.

> +	int err = 0;

...

> +static int __kho_preserve_order(unsigned long pfn, unsigned int order)
> +{
> +	unsigned long pa = PFN_PHYS(pfn);
> +
> +	might_sleep();
> +
> +	return kho_radix_preserve_page(pa, order);

I don't think that __kho_preserve_order() wrapper is useful, just rename
kho_radix_preserve_page to __kho_preserve_order()

> +}
> +
>  /* almost as free_reserved_page(), just don't free the page */
>  static void kho_restore_page(struct page *page, unsigned int order)
>  {
> @@ -224,152 +385,49 @@ struct folio *kho_restore_folio(phys_addr_t phys)
>  }
>  EXPORT_SYMBOL_GPL(kho_restore_folio);

...

> -static int kho_mem_serialize(struct kho_serialization *ser)
> +static int __init kho_radix_walk_trees_memblock_callback(unsigned long encoded)

I wonder if we expect other callbacks for tree traversal?
For now there's only one case when we traverse the tree, so it seems
simpler to just merge the code here into kho_radix_walk_bitmaps() and
rename kho_radix_walk_trees() and kho_radix_walk_bitmaps() to reflect that
they are reserving the preserved memory.

>  {
> +	unsigned int order;
> +	unsigned long pa;
> +	struct page *page;
> +	int sz;
> 
> +	pa = kho_radix_decode(encoded, &order);
> +	sz = 1 << (order + PAGE_SHIFT);
> +	page = phys_to_page(pa);
>  
> +	/* Reserve the memory preserved in KHO radix tree in memblock */
> +	memblock_reserve(pa, sz);
> +	memblock_reserved_mark_noinit(pa, sz);
> +	page->private = order;
>  }
>  
>  static void __init kho_mem_deserialize(const void *fdt)

Well, it's not deserialize anymore.

>  {
> @@ -599,6 +657,35 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
>  	return 0;
>  }

It seems that a lot of the changes below are not related to changing the
mechanism for tracking the preserved memory.

I'm stopping here.

-- 
Sincerely yours,
Mike.


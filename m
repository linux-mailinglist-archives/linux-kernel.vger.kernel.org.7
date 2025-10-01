Return-Path: <linux-kernel+bounces-838313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B32BAEF16
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 03:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0629619424A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278D23F40D;
	Wed,  1 Oct 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYKRqKGV"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC921D9663
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759281591; cv=none; b=DDO459FaWLboHMIsrP9KfHByOJc+wGVJYZ6wuyRNNislMqizapD8yd9PRK3nBQ1Xh2el7GASlT+i1GFZUYekFvM25g61C5F16LszJslKI19PIvcqLHUF2K9htT5bg61XyDWviRQ1tFnOXQMuiZvvr3BggLKuB+I2R49NfPXnXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759281591; c=relaxed/simple;
	bh=OMy9A9SqZGQf0tjcKqASd6TeRIal9Kox3RhJbc6xON0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=not+c7GG51fO9RHN2rsjL6hp59wuGNpn5CZeI/j4QzDHFSx57lfQa7Nq3k33sIgYCyhXpxidrIWNsJOzITKDe+FAZUCQ575BkC4/07VKwl1zVkcggt2QXoCDLjx4uH9aEns3osQxkAOzaPiNWi3WH124vvzggDdxm0wFozd8VVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYKRqKGV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27eeb9730d9so54459135ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759281588; x=1759886388; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aeA8pNm0Fq4shIPD7vJcUgfL7lzd9fMzUIFSk5mhTv4=;
        b=GYKRqKGV8/KZDHqmxiJKkWHpnTBxibWGRUc9f/zPOY4g9S5wpndcniCUDp2R+C//qr
         Swicf0Y4lJxd5Vk+whiE0AjMfi6nffrdoyUV3KUwBkQkaEcjuh2As4PDbXKA0E/NpTHZ
         Apl1UYaaGZUMSqizMjuMt8xswbeHG4jB+TGvQDGh1ye1A3GTIMJC4dexWJ6Sy8cJCnL1
         Wg8fSYq/YzhUTcSkXCxf/7iXtsq7VmD3gJ9yRqqWNqCNuQG0Egfp/hN180OygiYOjdI6
         NRcjneOQctfghvYMBNcumXerSHPsXjKnKdZslObyrUOgBu+Ui7LJeCQ4Gi1i263OxEx2
         YafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759281588; x=1759886388;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeA8pNm0Fq4shIPD7vJcUgfL7lzd9fMzUIFSk5mhTv4=;
        b=SX05j1TZ3D9zITsr5mp8PVL0+YS+VYVMA9zv1wlmiAXQVbaFla5FdmvPNdaZBK8Akx
         GIXLelJSJkBG2qHlFIeE8Ni/f6VPS0ocJc6AzqHdoWXW9L7c8/GTBmsAr/yCGsTZ4zj/
         12SvcZLG/l6vJof0bJdyGgJ3q+ZtBEgnAgE/D95FKOxGJs07JRmHgsOT86ZlBwg4949y
         +MKmWuz/q1+2oGTczGy0t9X6bfVe5LsM2uGRu78Xq42w/pSmRn1pq/PkG1OEbpH7bidB
         e3uqjfqgo6valBjN6n9EYUAZrrEWgEa5ekAN+5dDTtgeb8DD9e4csQN3S9sJO5rBkalb
         o6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS/wgEp/+h5B23RKpZ0s5almcOLw+IGXDvFzwtQoDSN7O6g40bjvLho2zyxFcrV7oOYIkrsGivKSKxoCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5N59LEWrtDOYodtDublHHsij55dkFI5bX7jpWGr6OStATsg2M
	4Kkc7NsBkiuI0eWgxSUJQyhyVA8XXLI/NX2Eq8jUVwybDs7C0KbFD9A9jyka7WJzicfAVtGu3jo
	L+JI25YFPLDxUsA==
X-Google-Smtp-Source: AGHT+IESrZiX8ecOTHtWIxgWXgm8rK3Z4Z0P+E9YaEUe495lkH4WCES4F2JmaDmVF2Sy3OapzD9Bxbw4JHZeSQ==
X-Received: from plek4.prod.google.com ([2002:a17:903:4504:b0:248:7db1:3800])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:289:b0:273:c463:7b2c with SMTP id d9443c01a7336-28e7f26f319mr20106045ad.3.1759281587846;
 Tue, 30 Sep 2025 18:19:47 -0700 (PDT)
Date: Tue, 30 Sep 2025 18:19:39 -0700
In-Reply-To: <20251001011941.1513050-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001011941.1513050-2-jasonmiu@google.com>
Subject: [PATCH v1 1/3] kho: Adopt KHO radix tree data structures
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Introduce a radix tree data structure for tracking preserved
memory pages in KHO, which will replace the current xarray-based
implementation.

The primary motivation for this change is to eliminate the need for
serialization. By marking preserved pages directly in the new KHO
radix tree and passing them to the next kernel, the entire
serialization process can be removed. This ultimately allows for the
removal of the KHO finalize and abort states, simplifying the overall
design.

The preserved page physical address and its order are encoded in to a
value. The KHO radix tree has multiple level of nodes where each node
is a table contining a descriptor to the next level of nodes. The
encoded value get split and stored its parts along the tree
traversal. The tree traversal ends with the `kho_bitmap_table`, where
each bit represents a single preserved page.

Instead of serializing the memory map, the first kernel store the KHO
radix tree root in the FDT. This KHO radix tree root is passed to the
second kernel after kexec, hence elimitated the KHO finalize and abort
states.

The second kernel walks the passed-in KHO radix tree from its root. It
restores the memory pages and their orders by decoding the value
stored in the KHO radix tree.

This architectural shift to using a shared radix tree structure
simplifies the KHO design and eliminates the overhead of serializing
and deserializing the preserved memory map.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h |  17 -
 kernel/kexec_handover.c        | 729 +++++++++++++++------------------
 2 files changed, 322 insertions(+), 424 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb13..c8229cb11f4b 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -19,23 +19,6 @@ enum kho_event {
 struct folio;
 struct notifier_block;
 
-#define DECLARE_KHOSER_PTR(name, type) \
-	union {                        \
-		phys_addr_t phys;      \
-		type ptr;              \
-	} name
-#define KHOSER_STORE_PTR(dest, val)               \
-	({                                        \
-		typeof(val) v = val;              \
-		typecheck(typeof((dest).ptr), v); \
-		(dest).phys = virt_to_phys(v);    \
-	})
-#define KHOSER_LOAD_PTR(src)                                                 \
-	({                                                                   \
-		typeof(src) s = src;                                         \
-		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
-	})
-
 struct kho_serialization;
 
 #ifdef CONFIG_KEXEC_HANDOVER
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd..34cf0ce4f359 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
+#include <linux/rwsem.h>
 
 #include <asm/early_ioremap.h>
 
@@ -29,7 +30,7 @@
 #include "kexec_internal.h"
 
 #define KHO_FDT_COMPATIBLE "kho-v1"
-#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
+#define PROP_PRESERVED_PAGE_RADIX_TREE "preserved-page-radix-tree"
 #define PROP_SUB_FDT "fdt"
 
 static bool kho_enable __ro_after_init;
@@ -46,143 +47,306 @@ static int __init kho_parse_enable(char *p)
 }
 early_param("kho", kho_parse_enable);
 
+typedef int (*kho_radix_tree_walk_callback_t)(unsigned long encoded);
+
 /*
- * Keep track of memory that is to be preserved across KHO.
+ * The KHO radix tree tracks preserved memory pages. It is a hierarchical
+ * structure that starts with a single root `kho_radix_tree`. This single
+ * tree stores pages of all orders.
+ *
+ * This is achieved by encoding the page's physical address and its order into
+ * a single `unsigned long` value. This encoded value is then used to traverse
+ * the tree.
+ *
+ * The tree hierarchy is shown below:
+ *
+ * kho_radix_tree_root
+ * +-------------------+
+ * |     Level 6       | (struct kho_radix_tree)
+ * +-------------------+
+ *   |
+ *   v
+ * +-------------------+
+ * |     Level 5       | (struct kho_radix_tree)
+ * +-------------------+
+ *   |
+ *   | ... (intermediate levels)
+ *   |
+ *   v
+ * +-------------------+
+ * |      Level 1      | (struct kho_bitmap_table)
+ * +-------------------+
+ *
+ * The following diagram illustrates how the encoded value is split into
+ * indices for the tree levels:
  *
- * The serializing side uses two levels of xarrays to manage chunks of per-order
- * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
- * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
- * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
- * 512K of bitmap memory will be needed for order 0.
+ *      63:60   59:51    50:42    41:33    32:24    23:15         14:0
+ * +---------+--------+--------+--------+--------+--------+-----------------+
+ * |    0    |  Lv 6  |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1 (bitmap)  |
+ * +---------+--------+--------+--------+--------+--------+-----------------+
  *
- * This approach is fully incremental, as the serialization progresses folios
- * can continue be aggregated to the tracker. The final step, immediately prior
- * to kexec would serialize the xarray information into a linked list for the
- * successor kernel to parse.
+ * Each `kho_radix_tree` (Levels 2-6) and `kho_bitmap_table` (Level 1) is
+ * PAGE_SIZE. Each entry in a `kho_radix_tree` is a descriptor (a physical
+ * address) pointing to the next level node. For Level 2 `kho_radix_tree`
+ * nodes, these descriptors point to a `kho_bitmap_table`. The final
+ * `kho_bitmap_table` is a bitmap where each set bit represents a single
+ * preserved page.
  */
+struct kho_radix_tree {
+	unsigned long table[PAGE_SIZE / sizeof(unsigned long)];
+};
 
-#define PRESERVE_BITS (512 * 8)
-
-struct kho_mem_phys_bits {
-	DECLARE_BITMAP(preserve, PRESERVE_BITS);
+struct kho_bitmap_table {
+	unsigned long bitmaps[PAGE_SIZE / sizeof(unsigned long)];
 };
 
-struct kho_mem_phys {
+/*
+ * `kho_radix_tree_root` points to a page thats serves as the root of the
+ * KHO radix tree. This page is allocated during KHO module initialization.
+ * Its physical address is written to the FDT and passed to the next kernel
+ * during kexec.
+ */
+static struct kho_radix_tree *kho_radix_tree_root;
+static DECLARE_RWSEM(kho_radix_tree_root_sem);
+
+static int kho_radix_tree_max_depth(void)
+{
+	int page_offset_bit_num = BITS_PER_LONG - PAGE_SHIFT;
+	int order_bit_num = ilog2(__roundup_pow_of_two(page_offset_bit_num));
+	int bitmap_bit_num = PAGE_SHIFT + ilog2(BITS_PER_BYTE);
+	int table_bit_num = ilog2(PAGE_SIZE / sizeof(unsigned long));
+	int table_level_num = DIV_ROUND_UP(page_offset_bit_num -
+					   bitmap_bit_num + order_bit_num,
+					   table_bit_num);
+
 	/*
-	 * Points to kho_mem_phys_bits, a sparse bitmap array. Each bit is sized
-	 * to order.
+	 * The total tree depth is the number of intermediate levels
+	 * and 1 bitmap level.
 	 */
-	struct xarray phys_bits;
-};
+	return table_level_num + 1;
+}
 
-struct kho_mem_track {
-	/* Points to kho_mem_phys, each order gets its own bitmap tree */
-	struct xarray orders;
-};
+static struct kho_radix_tree *kho_alloc_radix_tree(void)
+{
+	return (struct kho_radix_tree *)get_zeroed_page(GFP_KERNEL);
+}
 
-struct khoser_mem_chunk;
+/*
+ * The KHO radix tree tracks preserved pages by encoding a page's physical
+ * address (pa) and its order into a single unsigned long value. This value
+ * is then used to traverse the tree. The encoded value is composed of two
+ * parts: the 'order bits' in the upper part and the 'page offset' in the
+ * lower part.
+ *
+ *   <-- Higher Bits ------------------------------------ Lower Bits -->
+ *  +--------------------------+-----------------------------------------+
+ *  |        Order Bits        |               Page Offset               |
+ *  +--------------------------+-----------------------------------------+
+ *  | ... 0 0 1 0 0 ...        | pa >> (PAGE_SHIFT + order)              |
+ *  +--------------------------+-----------------------------------------+
+ *            ^
+ *            |
+ *  This single '1' bit's position
+ *  uniquely identifies the 'order'.
+ *
+ *
+ * Page Offset:
+ * The 'page offset' is the physical address normalized for its order. It
+ * effectively represents the page offset for the given order.
+ *
+ * Order Bits:
+ * The 'order bits' encode the page order by setting a single bit at a
+ * specific position. The position of this bit itself represents the order.
+ *
+ * For instance, on a 64-bit system with 4KB pages (PAGE_SHIFT = 12), the
+ * maximum range for a page offset (for order 0) is 52 bits (64 - 12). This
+ * offset occupies bits [0-51]. For order 0, the order bit is set at
+ * position 52.
+ *
+ * As the order increases, the number of bits required for the 'page offset'
+ * decreases. For example, order 1 requires one less bit for its page
+ * offset. This allows its order bit to be set at position 51 without
+ * conflicting with the page offset bits.
+ *
+ * This scheme ensures that the single order bit is always in a higher
+ * position than any bit used by the page offset for that same order,
+ * preventing collisions.
+ */
+static unsigned long kho_radix_encode(unsigned long pa, unsigned int order)
+{
+	unsigned long h = 1UL << (BITS_PER_LONG - PAGE_SHIFT - order);
+	unsigned long l = pa >> (PAGE_SHIFT + order);
 
-struct kho_serialization {
-	struct page *fdt;
-	struct list_head fdt_list;
-	struct dentry *sub_fdt_dir;
-	struct kho_mem_track track;
-	/* First chunk of serialized preserved memory map */
-	struct khoser_mem_chunk *preserved_mem_map;
-};
+	return h | l;
+}
 
-static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
+static unsigned long kho_radix_decode(unsigned long encoded, unsigned int *order)
 {
-	void *elm, *res;
+	unsigned long order_bit = fls64(encoded);
+	unsigned long pa;
 
-	elm = xa_load(xa, index);
-	if (elm)
-		return elm;
+	*order = BITS_PER_LONG - PAGE_SHIFT - order_bit + 1;
+	pa = encoded << (PAGE_SHIFT + *order);
 
-	elm = kzalloc(sz, GFP_KERNEL);
-	if (!elm)
-		return ERR_PTR(-ENOMEM);
-
-	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
-	if (xa_is_err(res))
-		res = ERR_PTR(xa_err(res));
+	return pa;
+}
 
-	if (res) {
-		kfree(elm);
-		return res;
+static unsigned long kho_radix_get_index(unsigned long encoded, int level)
+{
+	int table_bit_num = ilog2(PAGE_SIZE / sizeof(unsigned long));
+	int bitmap_bit_num = PAGE_SHIFT + ilog2(BITS_PER_BYTE);
+	unsigned long mask;
+	int s;
+
+	if (level == 1) {
+		s = 0;
+		mask = (1UL << bitmap_bit_num) - 1;
+	} else {
+		s = ((level - 2) * table_bit_num) + bitmap_bit_num;
+		mask = (1UL << table_bit_num) - 1;
 	}
 
-	return elm;
+	return (encoded >> s) & mask;
 }
 
-static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
-			     unsigned long end_pfn)
+static int kho_radix_set_bitmap(struct kho_bitmap_table *bit_tlb, unsigned long offset)
 {
-	struct kho_mem_phys_bits *bits;
-	struct kho_mem_phys *physxa;
+	if (!bit_tlb ||
+	    offset >= PAGE_SIZE * BITS_PER_BYTE)
+		return -EINVAL;
 
-	while (pfn < end_pfn) {
-		const unsigned int order =
-			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		const unsigned long pfn_high = pfn >> order;
+	set_bit(offset, bit_tlb->bitmaps);
+	return 0;
+}
 
-		physxa = xa_load(&track->orders, order);
-		if (!physxa)
-			continue;
+static int kho_radix_preserve_page(unsigned long pa, unsigned int order)
+{
+	unsigned long encoded = kho_radix_encode(pa, order);
+	int num_tree_level = kho_radix_tree_max_depth();
+	struct kho_radix_tree *current_tree, *new_tree;
+	struct kho_bitmap_table *bitmap_table;
+	int err = 0;
+	int i, idx;
 
-		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (!bits)
-			continue;
+	down_write(&kho_radix_tree_root_sem);
 
-		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+	current_tree = kho_radix_tree_root;
 
-		pfn += 1 << order;
+	/* Go from high levels to low levels */
+	for (i = num_tree_level; i >= 1; i--) {
+		idx = kho_radix_get_index(encoded, i);
+
+		if (i == 1) {
+			bitmap_table = (struct kho_bitmap_table *)current_tree;
+			err = kho_radix_set_bitmap(bitmap_table, idx);
+			goto out;
+		}
+
+		if (!current_tree->table[idx]) {
+			new_tree = kho_alloc_radix_tree();
+			if (!new_tree) {
+				err = -ENOMEM;
+				goto out;
+			}
+
+			current_tree->table[idx] =
+				(unsigned long)virt_to_phys(new_tree);
+		}
+
+		current_tree = (struct kho_radix_tree *)
+			phys_to_virt(current_tree->table[idx]);
 	}
+
+out:
+	up_write(&kho_radix_tree_root_sem);
+	return err;
 }
 
-static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
-				unsigned int order)
+static int kho_radix_walk_bitmaps(struct kho_bitmap_table *bit_tlb,
+				  unsigned long offset,
+				  kho_radix_tree_walk_callback_t cb)
 {
-	struct kho_mem_phys_bits *bits;
-	struct kho_mem_phys *physxa, *new_physxa;
-	const unsigned long pfn_high = pfn >> order;
+	unsigned long encoded = offset << (PAGE_SHIFT + ilog2(BITS_PER_BYTE));
+	unsigned long *bitmap = (unsigned long *)bit_tlb;
+	int err = 0;
+	int i;
 
-	might_sleep();
+	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
+		err = cb(encoded | i);
+		if (err)
+			return err;
+	}
 
-	physxa = xa_load(&track->orders, order);
-	if (!physxa) {
-		int err;
+	return 0;
+}
 
-		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
-		if (!new_physxa)
-			return -ENOMEM;
+static int kho_radix_walk_trees(struct kho_radix_tree *root, int level,
+				unsigned long offset,
+				kho_radix_tree_walk_callback_t cb)
+{
+	int level_shift = ilog2(PAGE_SIZE / sizeof(unsigned long));
+	struct kho_radix_tree *next_tree;
+	unsigned long encoded, i;
+	int err = 0;
 
-		xa_init(&new_physxa->phys_bits);
-		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
-				    GFP_KERNEL);
+	if (level == 1) {
+		encoded = offset;
+		return kho_radix_walk_bitmaps((struct kho_bitmap_table *)root,
+					      encoded, cb);
+	}
 
-		err = xa_err(physxa);
-		if (err || physxa) {
-			xa_destroy(&new_physxa->phys_bits);
-			kfree(new_physxa);
+	for (i = 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
+		if (root->table[i]) {
+			encoded = offset << level_shift | i;
 
+			next_tree = (struct kho_radix_tree *)
+				phys_to_virt(root->table[i]);
+			err = kho_radix_walk_trees(next_tree, level - 1, encoded, cb);
 			if (err)
 				return err;
-		} else {
-			physxa = new_physxa;
 		}
 	}
 
-	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
-				sizeof(*bits));
-	if (IS_ERR(bits))
-		return PTR_ERR(bits);
+	return 0;
+}
 
-	set_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+static int kho_memblock_reserve(phys_addr_t pa, int order)
+{
+	int sz = 1 << (order + PAGE_SHIFT);
+	struct page *page = phys_to_page(pa);
+
+	memblock_reserve(pa, sz);
+	memblock_reserved_mark_noinit(pa, sz);
+	page->private = order;
 
 	return 0;
 }
 
+static int kho_radix_walk_trees_callback(unsigned long encoded)
+{
+	unsigned int order;
+	unsigned long pa;
+
+	pa = kho_radix_decode(encoded, &order);
+
+	return kho_memblock_reserve(pa, order);
+}
+
+struct kho_serialization {
+	struct page *fdt;
+	struct list_head fdt_list;
+	struct dentry *sub_fdt_dir;
+};
+
+static int __kho_preserve_order(unsigned long pfn, unsigned int order)
+{
+	unsigned long pa = PFN_PHYS(pfn);
+
+	might_sleep();
+
+	return kho_radix_preserve_page(pa, order);
+}
+
 /* almost as free_reserved_page(), just don't free the page */
 static void kho_restore_page(struct page *page, unsigned int order)
 {
@@ -224,152 +388,29 @@ struct folio *kho_restore_folio(phys_addr_t phys)
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
 
-/* Serialize and deserialize struct kho_mem_phys across kexec
- *
- * Record all the bitmaps in a linked list of pages for the next kernel to
- * process. Each chunk holds bitmaps of the same order and each block of bitmaps
- * starts at a given physical address. This allows the bitmaps to be sparse. The
- * xarray is used to store them in a tree while building up the data structure,
- * but the KHO successor kernel only needs to process them once in order.
- *
- * All of this memory is normal kmalloc() memory and is not marked for
- * preservation. The successor kernel will remain isolated to the scratch space
- * until it completes processing this list. Once processed all the memory
- * storing these ranges will be marked as free.
- */
-
-struct khoser_mem_bitmap_ptr {
-	phys_addr_t phys_start;
-	DECLARE_KHOSER_PTR(bitmap, struct kho_mem_phys_bits *);
-};
-
-struct khoser_mem_chunk_hdr {
-	DECLARE_KHOSER_PTR(next, struct khoser_mem_chunk *);
-	unsigned int order;
-	unsigned int num_elms;
-};
-
-#define KHOSER_BITMAP_SIZE                                   \
-	((PAGE_SIZE - sizeof(struct khoser_mem_chunk_hdr)) / \
-	 sizeof(struct khoser_mem_bitmap_ptr))
-
-struct khoser_mem_chunk {
-	struct khoser_mem_chunk_hdr hdr;
-	struct khoser_mem_bitmap_ptr bitmaps[KHOSER_BITMAP_SIZE];
-};
-
-static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
-
-static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
-					  unsigned long order)
-{
-	struct khoser_mem_chunk *chunk;
-
-	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!chunk)
-		return NULL;
-	chunk->hdr.order = order;
-	if (cur_chunk)
-		KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
-	return chunk;
-}
-
-static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
-{
-	struct khoser_mem_chunk *chunk = first_chunk;
-
-	while (chunk) {
-		struct khoser_mem_chunk *tmp = chunk;
-
-		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		kfree(tmp);
-	}
-}
-
-static int kho_mem_serialize(struct kho_serialization *ser)
-{
-	struct khoser_mem_chunk *first_chunk = NULL;
-	struct khoser_mem_chunk *chunk = NULL;
-	struct kho_mem_phys *physxa;
-	unsigned long order;
-
-	xa_for_each(&ser->track.orders, order, physxa) {
-		struct kho_mem_phys_bits *bits;
-		unsigned long phys;
-
-		chunk = new_chunk(chunk, order);
-		if (!chunk)
-			goto err_free;
-
-		if (!first_chunk)
-			first_chunk = chunk;
-
-		xa_for_each(&physxa->phys_bits, phys, bits) {
-			struct khoser_mem_bitmap_ptr *elm;
-
-			if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
-				chunk = new_chunk(chunk, order);
-				if (!chunk)
-					goto err_free;
-			}
-
-			elm = &chunk->bitmaps[chunk->hdr.num_elms];
-			chunk->hdr.num_elms++;
-			elm->phys_start = (phys * PRESERVE_BITS)
-					  << (order + PAGE_SHIFT);
-			KHOSER_STORE_PTR(elm->bitmap, bits);
-		}
-	}
-
-	ser->preserved_mem_map = first_chunk;
-
-	return 0;
-
-err_free:
-	kho_mem_ser_free(first_chunk);
-	return -ENOMEM;
-}
-
-static void __init deserialize_bitmap(unsigned int order,
-				      struct khoser_mem_bitmap_ptr *elm)
-{
-	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
-	unsigned long bit;
-
-	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
-		int sz = 1 << (order + PAGE_SHIFT);
-		phys_addr_t phys =
-			elm->phys_start + (bit << (order + PAGE_SHIFT));
-		struct page *page = phys_to_page(phys);
-
-		memblock_reserve(phys, sz);
-		memblock_reserved_mark_noinit(phys, sz);
-		page->private = order;
-	}
-}
-
 static void __init kho_mem_deserialize(const void *fdt)
 {
-	struct khoser_mem_chunk *chunk;
 	const phys_addr_t *mem;
 	int len;
+	struct kho_radix_tree *tree_root;
 
-	mem = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
+	/* Retrieve the KHO radix tree from passed-in FDT. */
+	mem = fdt_getprop(fdt, 0, PROP_PRESERVED_PAGE_RADIX_TREE, &len);
 
 	if (!mem || len != sizeof(*mem)) {
-		pr_err("failed to get preserved memory bitmaps\n");
+		pr_err("failed to get preserved KHO memory tree\n");
 		return;
 	}
 
-	chunk = *mem ? phys_to_virt(*mem) : NULL;
-	while (chunk) {
-		unsigned int i;
+	tree_root = *mem ?
+		(struct kho_radix_tree *)phys_to_virt(*mem) :
+		NULL;
 
-		for (i = 0; i != chunk->hdr.num_elms; i++)
-			deserialize_bitmap(chunk->hdr.order,
-					   &chunk->bitmaps[i]);
-		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-	}
+	if (!tree_root)
+		return;
+
+	kho_radix_walk_trees(tree_root, kho_radix_tree_max_depth(),
+			     0, kho_radix_walk_trees_callback);
 }
 
 /*
@@ -633,25 +674,15 @@ EXPORT_SYMBOL_GPL(kho_add_subtree);
 
 struct kho_out {
 	struct blocking_notifier_head chain_head;
-
 	struct dentry *dir;
-
-	struct mutex lock; /* protects KHO FDT finalization */
-
 	struct kho_serialization ser;
-	bool finalized;
 };
 
 static struct kho_out kho_out = {
 	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
-	.lock = __MUTEX_INITIALIZER(kho_out.lock),
 	.ser = {
 		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
-		.track = {
-			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
-		},
 	},
-	.finalized = false,
 };
 
 int register_kho_notifier(struct notifier_block *nb)
@@ -679,12 +710,8 @@ int kho_preserve_folio(struct folio *folio)
 {
 	const unsigned long pfn = folio_pfn(folio);
 	const unsigned int order = folio_order(folio);
-	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
-	return __kho_preserve_order(track, pfn, order);
+	return __kho_preserve_order(pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
 
@@ -701,14 +728,8 @@ EXPORT_SYMBOL_GPL(kho_preserve_folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size)
 {
 	unsigned long pfn = PHYS_PFN(phys);
-	unsigned long failed_pfn = 0;
-	const unsigned long start_pfn = pfn;
 	const unsigned long end_pfn = PHYS_PFN(phys + size);
 	int err = 0;
-	struct kho_mem_track *track = &kho_out.ser.track;
-
-	if (kho_out.finalized)
-		return -EBUSY;
 
 	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
 		return -EINVAL;
@@ -717,19 +738,14 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
 
-		err = __kho_preserve_order(track, pfn, order);
-		if (err) {
-			failed_pfn = pfn;
-			break;
-		}
+		err = __kho_preserve_order(pfn, order);
+		if (err)
+			return err;
 
 		pfn += 1 << order;
 	}
 
-	if (err)
-		__kho_unpreserve(track, start_pfn, failed_pfn);
-
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
@@ -737,150 +753,6 @@ EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
 static struct dentry *debugfs_root;
 
-static int kho_out_update_debugfs_fdt(void)
-{
-	int err = 0;
-	struct fdt_debugfs *ff, *tmp;
-
-	if (kho_out.finalized) {
-		err = kho_debugfs_fdt_add(&kho_out.ser.fdt_list, kho_out.dir,
-					  "fdt", page_to_virt(kho_out.ser.fdt));
-	} else {
-		list_for_each_entry_safe(ff, tmp, &kho_out.ser.fdt_list, list) {
-			debugfs_remove(ff->file);
-			list_del(&ff->list);
-			kfree(ff);
-		}
-	}
-
-	return err;
-}
-
-static int kho_abort(void)
-{
-	int err;
-	unsigned long order;
-	struct kho_mem_phys *physxa;
-
-	xa_for_each(&kho_out.ser.track.orders, order, physxa) {
-		struct kho_mem_phys_bits *bits;
-		unsigned long phys;
-
-		xa_for_each(&physxa->phys_bits, phys, bits)
-			kfree(bits);
-
-		xa_destroy(&physxa->phys_bits);
-		kfree(physxa);
-	}
-	xa_destroy(&kho_out.ser.track.orders);
-
-	if (kho_out.ser.preserved_mem_map) {
-		kho_mem_ser_free(kho_out.ser.preserved_mem_map);
-		kho_out.ser.preserved_mem_map = NULL;
-	}
-
-	err = blocking_notifier_call_chain(&kho_out.chain_head, KEXEC_KHO_ABORT,
-					   NULL);
-	err = notifier_to_errno(err);
-
-	if (err)
-		pr_err("Failed to abort KHO finalization: %d\n", err);
-
-	return err;
-}
-
-static int kho_finalize(void)
-{
-	int err = 0;
-	u64 *preserved_mem_map;
-	void *fdt = page_to_virt(kho_out.ser.fdt);
-
-	err |= fdt_create(fdt, PAGE_SIZE);
-	err |= fdt_finish_reservemap(fdt);
-	err |= fdt_begin_node(fdt, "");
-	err |= fdt_property_string(fdt, "compatible", KHO_FDT_COMPATIBLE);
-	/**
-	 * Reserve the preserved-memory-map property in the root FDT, so
-	 * that all property definitions will precede subnodes created by
-	 * KHO callers.
-	 */
-	err |= fdt_property_placeholder(fdt, PROP_PRESERVED_MEMORY_MAP,
-					sizeof(*preserved_mem_map),
-					(void **)&preserved_mem_map);
-	if (err)
-		goto abort;
-
-	err = kho_preserve_folio(page_folio(kho_out.ser.fdt));
-	if (err)
-		goto abort;
-
-	err = blocking_notifier_call_chain(&kho_out.chain_head,
-					   KEXEC_KHO_FINALIZE, &kho_out.ser);
-	err = notifier_to_errno(err);
-	if (err)
-		goto abort;
-
-	err = kho_mem_serialize(&kho_out.ser);
-	if (err)
-		goto abort;
-
-	*preserved_mem_map = (u64)virt_to_phys(kho_out.ser.preserved_mem_map);
-
-	err |= fdt_end_node(fdt);
-	err |= fdt_finish(fdt);
-
-abort:
-	if (err) {
-		pr_err("Failed to convert KHO state tree: %d\n", err);
-		kho_abort();
-	}
-
-	return err;
-}
-
-static int kho_out_finalize_get(void *data, u64 *val)
-{
-	mutex_lock(&kho_out.lock);
-	*val = kho_out.finalized;
-	mutex_unlock(&kho_out.lock);
-
-	return 0;
-}
-
-static int kho_out_finalize_set(void *data, u64 _val)
-{
-	int ret = 0;
-	bool val = !!_val;
-
-	mutex_lock(&kho_out.lock);
-
-	if (val == kho_out.finalized) {
-		if (kho_out.finalized)
-			ret = -EEXIST;
-		else
-			ret = -ENOENT;
-		goto unlock;
-	}
-
-	if (val)
-		ret = kho_finalize();
-	else
-		ret = kho_abort();
-
-	if (ret)
-		goto unlock;
-
-	kho_out.finalized = val;
-	ret = kho_out_update_debugfs_fdt();
-
-unlock:
-	mutex_unlock(&kho_out.lock);
-	return ret;
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
-			 kho_out_finalize_set, "%llu\n");
-
 static int scratch_phys_show(struct seq_file *m, void *v)
 {
 	for (int i = 0; i < kho_scratch_cnt; i++)
@@ -921,11 +793,6 @@ static __init int kho_out_debugfs_init(void)
 	if (IS_ERR(f))
 		goto err_rmdir;
 
-	f = debugfs_create_file("finalize", 0600, dir, NULL,
-				&fops_kho_out_finalize);
-	if (IS_ERR(f))
-		goto err_rmdir;
-
 	kho_out.dir = dir;
 	kho_out.ser.sub_fdt_dir = sub_fdt_dir;
 	return 0;
@@ -1037,6 +904,37 @@ static __init int kho_in_debugfs_init(const void *fdt)
 	return err;
 }
 
+static int kho_out_fdt_init(void)
+{
+	int err = 0;
+	void *fdt = page_to_virt(kho_out.ser.fdt);
+	u64 *preserved_radix_tree_root;
+
+	err |= fdt_create(fdt, PAGE_SIZE);
+	err |= fdt_finish_reservemap(fdt);
+	err |= fdt_begin_node(fdt, "");
+	err |= fdt_property_string(fdt, "compatible", KHO_FDT_COMPATIBLE);
+
+	err |= fdt_property_placeholder(fdt, PROP_PRESERVED_PAGE_RADIX_TREE,
+					sizeof(*preserved_radix_tree_root),
+					(void **)&preserved_radix_tree_root);
+	if (err)
+		goto abort;
+
+	down_read(&kho_radix_tree_root_sem);
+	*preserved_radix_tree_root = (u64)virt_to_phys(kho_radix_tree_root);
+	up_read(&kho_radix_tree_root_sem);
+
+	err |= fdt_end_node(fdt);
+	err |= fdt_finish(fdt);
+
+abort:
+	if (err)
+		pr_err("Failed to convert KHO memory tree: %d\n", err);
+
+	return err;
+}
+
 static __init int kho_init(void)
 {
 	int err = 0;
@@ -1051,15 +949,29 @@ static __init int kho_init(void)
 		goto err_free_scratch;
 	}
 
+	kho_radix_tree_root = (struct kho_radix_tree *)
+		kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!kho_radix_tree_root) {
+		err = -ENOMEM;
+		goto err_free_fdt;
+	}
+
+	err = kho_out_fdt_init();
+	if (err)
+		goto err_free_kho_radix_tree_root;
+
 	debugfs_root = debugfs_create_dir("kho", NULL);
 	if (IS_ERR(debugfs_root)) {
 		err = -ENOENT;
-		goto err_free_fdt;
+		goto err_free_kho_radix_tree_root;
 	}
 
 	err = kho_out_debugfs_init();
 	if (err)
-		goto err_free_fdt;
+		goto err_free_kho_radix_tree_root;
+
+	/* Preserve the memory page of FDT for the next kernel */
+	kho_preserve_phys(page_to_phys(kho_out.ser.fdt), PAGE_SIZE);
 
 	if (fdt) {
 		err = kho_in_debugfs_init(fdt);
@@ -1087,6 +999,9 @@ static __init int kho_init(void)
 
 	return 0;
 
+err_free_kho_radix_tree_root:
+	kfree(kho_radix_tree_root);
+	kho_radix_tree_root = NULL;
 err_free_fdt:
 	put_page(kho_out.ser.fdt);
 	kho_out.ser.fdt = NULL;
-- 
2.51.0.618.g983fd99d29-goog



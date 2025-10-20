Return-Path: <linux-kernel+bounces-860547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7CBF0626
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B8D3B54D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C262F6182;
	Mon, 20 Oct 2025 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UO9dITq3"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060382EC0A9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954595; cv=none; b=AKh2rqLP22uVulVCCoJNm4JAN3Itw/wkBn7U39unNQ8JfN1k24Z7BuVMXGLViKmDcWRsfdKnqrNA9BaYEbVImKLPstxHaAYnHuGY7sc8iw9ZUO/4oZNd2OObffPu4YrUqsd1YCsWDsVlBIbnWWiqabiaKDV0ZQSJ5q87CwPPLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954595; c=relaxed/simple;
	bh=nkOyz+9em2Qh8y5xn4Mcv59praiEYq0V7XwX8yfZVO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WlFQPaJDpgL6eEqDchDVe+Y9POlHkLSTwxcxgyTlOvHHhLpsbLkHtnBbx4m9Et0BGyGDpz3VcDX+iOtkIErmJ7Qk2wLC2GY8ZppJ9OBm9yycTZgXejWfcU5tMF2mHPAn/q3Pjwx+xW1YU+4q56tmiY7aVhtGxHr0WYKh/3lGIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UO9dITq3; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-3c9a451bf90so4460802fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760954592; x=1761559392; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46avciXP+wDDB1rrnPvhiOKFIaVNjdbDgGW6Fg141+E=;
        b=UO9dITq3y92R6pOquw30ZiFMu56AWMYIKw8nXfVmXIg9YGGWGBqXUr7R1LOlbJN3ce
         m9+P2xi9+uexf9ABHHQErUQlEoVzUC5J2jQ8Vl+mJHeM07e+Mb/qDvcJp0S0kZWbfLGD
         mzZ6+nbmG78QC/M/8BFer75ce3j5H1qlBYXWTpcNxG7hE14aev/RRp72UtRe6Ihqsfvp
         Q6rpk6Xda3wVTouMMQ+vHPE/D/V3iwjEsBiVL2cve8EgF211jQ3yXigK7sO4jRZJVhhd
         Jy8RJgQilpMMBrqVTKDp0ugQqOusJtB7UGocCOqyUr8rGypN1BzebJMXwSpCLs6D73wm
         0dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954592; x=1761559392;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46avciXP+wDDB1rrnPvhiOKFIaVNjdbDgGW6Fg141+E=;
        b=ROnMF9GcOJEXeS/w4+8pBwj10Z5dvCfTq7z/spyjAJ81OipcFT+zIftvgVXhhjy5O/
         rnDFlQ5fdMGkPKUvcHpPuFh2UlA03ewLZgm+4eqQFvo+aIL69lhGqkvDn3aNZsPgLN8w
         S00kPTdo2jkMetWINKmbdeltt8zFl47ERCjqdAEpTK0uXv8EiIKrH7hGS6nMvw6dDE1Z
         p6qios5VNm6bvho8UKNmjNPr8MwvfUCgqf+QfW6RVe2iuMBazwK2SmCGZjbUqJ4pva1x
         5+W7lWjDPNG2CN3Itk/kLHvsOz3TWkznKrjkt7s06J0eCTZzUBdIBvFvA5BzHkcANvG3
         g4ig==
X-Forwarded-Encrypted: i=1; AJvYcCVRxullTSvfdxZpQowGTLeGDrEoe6BrbO/DS7N1lgg/1T+fkv29Fzy9ppByQ2xw4YlWOJKBQ54ELEC19kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkWYCxzYSdpl2jIjCLmteOF8kZZM+5o+jBkD4+U3YIPwkW/UM
	dHXYjUpN+4D35IP5WIwsy+NdRArzOC0qidXxN1fgR7606KJOFt56Dqf0uo1cMrUH6pgdmZDhoDM
	6K7lp2Dw/b2BGbQ==
X-Google-Smtp-Source: AGHT+IHIsHf56dfwack38fFkvt9ze/bU0E4NumK1WzqPusv8r1s6nhynHYTKhwoi2l0k2rVe3PaOUPu6wYf0KA==
X-Received: from pgbfm22.prod.google.com ([2002:a05:6a02:4996:b0:b4e:4eb5:3895])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:a995:b0:3c9:86d7:6d03 with SMTP id 586e51a60fabf-3c98d145ca5mr5741162fac.51.1760954591970;
 Mon, 20 Oct 2025 03:03:11 -0700 (PDT)
Date: Mon, 20 Oct 2025 03:03:04 -0700
In-Reply-To: <20251020100306.2709352-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251020100306.2709352-2-jasonmiu@google.com>
Subject: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
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
 MAINTAINERS                                   |   2 +
 include/linux/kexec_handover.h                |  23 +-
 .../linux/live_update/abi/kexec_handover.h    |  10 +
 kernel/kexec_handover.c                       | 861 +++++++++---------
 4 files changed, 458 insertions(+), 438 deletions(-)
 create mode 100644 include/linux/live_update/abi/kexec_handover.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ab92f471cb8..046a333ba0d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13550,12 +13550,14 @@ KEXEC HANDOVER (KHO)
 M:	Alexander Graf <graf@amazon.com>
 M:	Mike Rapoport <rppt@kernel.org>
 M:	Changyuan Lyu <changyuanl@google.com>
+M:	Jason Miu <jasonmiu@google.com>
 L:	kexec@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
+F:	include/linux/live_update/abi/kexec_handover.h
 F:	kernel/kexec_handover.c
 F:	tools/testing/selftests/kho/
 
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb13..bc2f9e060a79 100644
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
@@ -45,6 +28,7 @@ int kho_preserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+int kho_remove_subtree(const char *name);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
 int register_kho_notifier(struct notifier_block *nb);
@@ -86,6 +70,11 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_remove_subtree(const char *name)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int register_kho_notifier(struct notifier_block *nb)
 {
 	return -EOPNOTSUPP;
diff --git a/include/linux/live_update/abi/kexec_handover.h b/include/linux/live_update/abi/kexec_handover.h
new file mode 100644
index 000000000000..3154e5c33851
--- /dev/null
+++ b/include/linux/live_update/abi/kexec_handover.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ABI__KEXEC_HANDOVER_H
+#define _ABI__KEXEC_HANDOVER_H
+
+#define KHO_FDT_COMPATIBLE "kho-v2"
+#define PROP_PRESERVED_PAGE_RADIX_TREE "preserved-page-radix-tree"
+#define PROP_SUB_FDT "fdt"
+
+#endif
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd..2fc5975690a7 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -15,9 +15,12 @@
 #include <linux/kexec_handover.h>
 #include <linux/libfdt.h>
 #include <linux/list.h>
+#include <linux/log2.h>
 #include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
+#include <linux/rwsem.h>
+#include <linux/live_update/abi/kexec_handover.h>
 
 #include <asm/early_ioremap.h>
 
@@ -28,10 +31,6 @@
 #include "../mm/internal.h"
 #include "kexec_internal.h"
 
-#define KHO_FDT_COMPATIBLE "kho-v1"
-#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
-#define PROP_SUB_FDT "fdt"
-
 static bool kho_enable __ro_after_init;
 
 bool kho_is_enabled(void)
@@ -46,143 +45,305 @@ static int __init kho_parse_enable(char *p)
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
+ * |     Level 5       | (struct kho_radix_tree)
+ * +-------------------+
+ *   |
+ *   v
+ * +-------------------+
+ * |     Level 4       | (struct kho_radix_tree)
+ * +-------------------+
+ *   |
+ *   | ... (intermediate levels)
+ *   |
+ *   v
+ * +-------------------+
+ * |      Level 0      | (struct kho_bitmap_table)
+ * +-------------------+
  *
- * The serializing side uses two levels of xarrays to manage chunks of per-order
- * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
- * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
- * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
- * 512K of bitmap memory will be needed for order 0.
+ * The following diagram illustrates how the encoded value is split into
+ * indices for the tree levels, with PAGE_SIZE is 4KB:
  *
- * This approach is fully incremental, as the serialization progresses folios
- * can continue be aggregated to the tracker. The final step, immediately prior
- * to kexec would serialize the xarray information into a linked list for the
- * successor kernel to parse.
+ *      63:60   59:51    50:42    41:33    32:24    23:15         14:0
+ * +---------+--------+--------+--------+--------+--------+-----------------+
+ * |    0    |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1  |  Lv 0 (bitmap)  |
+ * +---------+--------+--------+--------+--------+--------+-----------------+
+ *
+ * Each `kho_radix_tree` (Levels 1-5) and `kho_bitmap_table` (Level 0) is
+ * PAGE_SIZE. Each entry in a `kho_radix_tree` is a descriptor (a physical
+ * address) pointing to the next level node. For Level 1 `kho_radix_tree`
+ * nodes, these descriptors point to a `kho_bitmap_table`. The final
+ * `kho_bitmap_table` is a bitmap where each set bit represents a single
+ * preserved page.
  */
+struct kho_radix_tree {
+	phys_addr_t table[PAGE_SIZE / sizeof(phys_addr_t)];
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
+ * offset. This allows its order bit to be set at position 51,
+ * i.e. shifting right, without conflicting with the page offset bits.
+ *
+ * This design stores pages of all sizes (orders) in a single 6-level table.  It
+ * efficiently shares lower table levels, especially due to common zero top
+ * address bits, allowing a single, efficient algorithm to manage all pages.
+ */
+enum kho_radix_consts {
+	/* The bit position of a 0-order page, only supports 64bits system */
+	ORDER_0_LG2 = 64 - PAGE_SHIFT,
+	/* Bit number used for each level of tables */
+	TABLE_SIZE_LG2 = const_ilog2(PAGE_SIZE / sizeof(phys_addr_t)),
+	/* Bit number used for lowest level of bitmaps */
+	BITMAP_SIZE_LG2 = PAGE_SHIFT + const_ilog2(BITS_PER_BYTE),
 	/*
-	 * Points to kho_mem_phys_bits, a sparse bitmap array. Each bit is sized
-	 * to order.
+	 * The total tree depth is the number of intermediate levels
+	 * and 1 bitmap level.
 	 */
-	struct xarray phys_bits;
+	TREE_MAX_DEPTH = DIV_ROUND_UP(ORDER_0_LG2 - BITMAP_SIZE_LG2,
+				      TABLE_SIZE_LG2) + 1,
 };
 
-struct kho_mem_track {
-	/* Points to kho_mem_phys, each order gets its own bitmap tree */
-	struct xarray orders;
-};
+/*
+ * `kho_radix_tree_root` points to a page thats serves as the root of the
+ * KHO radix tree. This page is allocated during KHO module initialization.
+ * Its physical address is written to the FDT and passed to the next kernel
+ * during kexec.
+ */
+static struct kho_radix_tree *kho_radix_tree_root;
+static DECLARE_RWSEM(kho_radix_tree_root_sem);
 
-struct khoser_mem_chunk;
+static inline phys_addr_t kho_radix_tree_desc(struct kho_radix_tree *va)
+{
+	return (phys_addr_t)virt_to_phys(va);
+}
 
-struct kho_serialization {
-	struct page *fdt;
-	struct list_head fdt_list;
-	struct dentry *sub_fdt_dir;
-	struct kho_mem_track track;
-	/* First chunk of serialized preserved memory map */
-	struct khoser_mem_chunk *preserved_mem_map;
-};
+static inline struct kho_radix_tree *kho_radix_tree(phys_addr_t desc)
+{
+	return (struct kho_radix_tree *)(phys_to_virt(desc));
+}
 
-static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
+static struct kho_radix_tree *kho_alloc_radix_tree(void)
 {
-	void *elm, *res;
+	return (struct kho_radix_tree *)get_zeroed_page(GFP_KERNEL);
+}
 
-	elm = xa_load(xa, index);
-	if (elm)
-		return elm;
+static unsigned long kho_radix_encode(phys_addr_t pa, unsigned int order)
+{
+	/* Order bits part */
+	unsigned long h = 1UL << (ORDER_0_LG2 - order);
+	/* Page offset part */
+	unsigned long l = pa >> (PAGE_SHIFT + order);
 
-	elm = kzalloc(sz, GFP_KERNEL);
-	if (!elm)
-		return ERR_PTR(-ENOMEM);
+	return h | l;
+}
 
-	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
-	if (xa_is_err(res))
-		res = ERR_PTR(xa_err(res));
+static phys_addr_t kho_radix_decode(unsigned long encoded, unsigned int *order)
+{
+	unsigned int order_bit = fls64(encoded);
+	phys_addr_t pa;
 
-	if (res) {
-		kfree(elm);
-		return res;
-	}
+	/* order_bit is numbered starting at 1 from fls64 */
+	*order = ORDER_0_LG2 - order_bit + 1;
+	/* The order is discarded by the shift */
+	pa = encoded << (PAGE_SHIFT + *order);
 
-	return elm;
+	return pa;
 }
 
-static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
-			     unsigned long end_pfn)
+static unsigned long kho_radix_get_index(unsigned long encoded,
+					 unsigned int level)
 {
-	struct kho_mem_phys_bits *bits;
-	struct kho_mem_phys *physxa;
-
-	while (pfn < end_pfn) {
-		const unsigned int order =
-			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		const unsigned long pfn_high = pfn >> order;
+	int s;
 
-		physxa = xa_load(&track->orders, order);
-		if (!physxa)
-			continue;
+	if (level == 0)
+		return encoded % (1 << BITMAP_SIZE_LG2);
 
-		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (!bits)
-			continue;
+	s = ((level - 1) * TABLE_SIZE_LG2) + BITMAP_SIZE_LG2;
+	return (encoded >> s) % (1 << TABLE_SIZE_LG2);
+}
 
-		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+static int kho_radix_set_bitmap(struct kho_bitmap_table *bit_tlb,
+				unsigned long offset)
+{
+	if (!bit_tlb ||
+	    offset >= PAGE_SIZE * BITS_PER_BYTE)
+		return -EINVAL;
 
-		pfn += 1 << order;
-	}
+	__set_bit(offset, bit_tlb->bitmaps);
+	return 0;
 }
 
-static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
-				unsigned int order)
+static int kho_radix_preserve_page(phys_addr_t pa, unsigned int order)
 {
-	struct kho_mem_phys_bits *bits;
-	struct kho_mem_phys *physxa, *new_physxa;
-	const unsigned long pfn_high = pfn >> order;
+	unsigned long encoded = kho_radix_encode(pa, order);
+	struct kho_radix_tree *current_tree, *new_tree;
+	struct kho_bitmap_table *bitmap_table;
+	unsigned int tree_level = TREE_MAX_DEPTH - 1;
+	unsigned int err = 0;
+	unsigned int i, idx;
 
-	might_sleep();
+	down_write(&kho_radix_tree_root_sem);
 
-	physxa = xa_load(&track->orders, order);
-	if (!physxa) {
-		int err;
+	if (!kho_radix_tree_root) {
+		err = -EINVAL;
+		goto out;
+	}
 
-		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
-		if (!new_physxa)
-			return -ENOMEM;
+	current_tree = kho_radix_tree_root;
 
-		xa_init(&new_physxa->phys_bits);
-		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
-				    GFP_KERNEL);
+	/* Go from high levels to low levels */
+	for (i = tree_level; i >= 0; i--) {
+		idx = kho_radix_get_index(encoded, i);
 
-		err = xa_err(physxa);
-		if (err || physxa) {
-			xa_destroy(&new_physxa->phys_bits);
-			kfree(new_physxa);
+		if (i == 0) {
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
 
-			if (err)
-				return err;
+			current_tree->table[idx] =
+				kho_radix_tree_desc(new_tree);
+			current_tree = new_tree;
 		} else {
-			physxa = new_physxa;
+			current_tree = kho_radix_tree(current_tree->table[idx]);
 		}
 	}
 
-	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
-				sizeof(*bits));
-	if (IS_ERR(bits))
-		return PTR_ERR(bits);
+out:
+	up_write(&kho_radix_tree_root_sem);
+	return err;
+}
+
+static int kho_radix_walk_bitmaps(struct kho_bitmap_table *bit_tlb,
+				  unsigned long encoded,
+				  kho_radix_tree_walk_callback_t cb)
+{
+	unsigned long *bitmap = (unsigned long *)bit_tlb;
+	unsigned int i;
+	int err = 0;
+
+	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
+		err = cb(encoded | i);
+		if (err)
+			return err;
+	}
 
-	set_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+	return 0;
+}
+
+static int kho_radix_walk_trees(struct kho_radix_tree *root, unsigned int level,
+				unsigned long start,
+				kho_radix_tree_walk_callback_t cb)
+{
+	struct kho_radix_tree *next_tree;
+	struct kho_bitmap_table *bitmap_table;
+	unsigned long encoded, i;
+	unsigned int level_shift;
+	int err = 0;
+
+	for (i = 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
+		if (root->table[i]) {
+			level_shift = ((level - 1) * TABLE_SIZE_LG2) +
+				BITMAP_SIZE_LG2;
+			encoded = start | (i << level_shift);
+
+			next_tree = kho_radix_tree(root->table[i]);
+
+			if (level > 1) {
+				err = kho_radix_walk_trees(next_tree, level - 1,
+							   encoded, cb);
+				if (err)
+					return err;
+			} else {
+				/*
+				 * we are at level 1,
+				 * next_tree is pointing to the level 0 bitmap.
+				 */
+				bitmap_table =
+					(struct kho_bitmap_table *)next_tree;
+				return kho_radix_walk_bitmaps(bitmap_table,
+							      encoded, cb);
+			}
+		}
+	}
 
 	return 0;
 }
 
+struct kho_serialization {
+	struct page *fdt;
+	struct list_head fdt_list;
+	struct dentry *sub_fdt_dir;
+	struct mutex fdt_mutex;		/* Lock for the output FDT */
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
@@ -224,152 +385,49 @@ struct folio *kho_restore_folio(phys_addr_t phys)
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
+static int __init kho_radix_walk_trees_memblock_callback(unsigned long encoded)
 {
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
+	unsigned int order;
+	unsigned long pa;
+	struct page *page;
+	int sz;
 
-			if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
-				chunk = new_chunk(chunk, order);
-				if (!chunk)
-					goto err_free;
-			}
+	pa = kho_radix_decode(encoded, &order);
 
-			elm = &chunk->bitmaps[chunk->hdr.num_elms];
-			chunk->hdr.num_elms++;
-			elm->phys_start = (phys * PRESERVE_BITS)
-					  << (order + PAGE_SHIFT);
-			KHOSER_STORE_PTR(elm->bitmap, bits);
-		}
-	}
+	sz = 1 << (order + PAGE_SHIFT);
+	page = phys_to_page(pa);
 
-	ser->preserved_mem_map = first_chunk;
+	/* Reserve the memory preserved in KHO radix tree in memblock */
+	memblock_reserve(pa, sz);
+	memblock_reserved_mark_noinit(pa, sz);
+	page->private = order;
 
 	return 0;
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
 }
 
 static void __init kho_mem_deserialize(const void *fdt)
 {
-	struct khoser_mem_chunk *chunk;
+	struct kho_radix_tree *tree_root;
 	const phys_addr_t *mem;
 	int len;
 
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
+	kho_radix_walk_trees(tree_root, TREE_MAX_DEPTH - 1,
+			     0, kho_radix_walk_trees_memblock_callback);
 }
 
 /*
@@ -599,6 +657,35 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 	return 0;
 }
 
+static int kho_debugfs_fdt_remove(struct list_head *list, const char *name)
+{
+	struct fdt_debugfs *f, *tmp;
+
+	list_for_each_entry_safe(f, tmp, list, list) {
+		if (strcmp(f->file->d_name.name, name) == 0) {
+			debugfs_remove(f->file);
+			list_del(&f->list);
+			kfree(f);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+	struct dentry *dir;
+	struct kho_serialization ser;
+};
+
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.ser = {
+		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
+	},
+};
+
 /**
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
  * @ser: serialization control object passed by KHO notifiers.
@@ -616,43 +703,90 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
  */
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
 {
-	int err = 0;
+	void *root_fdt = page_to_virt(kho_out.ser.fdt);
 	u64 phys = (u64)virt_to_phys(fdt);
-	void *root = page_to_virt(ser->fdt);
+	int offset, err;
 
-	err |= fdt_begin_node(root, name);
-	err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
-	err |= fdt_end_node(root);
+	guard(mutex)(&kho_out.ser.fdt_mutex);
 
-	if (err)
-		return err;
+	offset = fdt_path_offset(root_fdt, "/");
+	if (offset < 0) {
+		pr_err("Failed to find the root FDT node: %s\n",
+		       fdt_strerror(offset));
+		return (offset == -FDT_ERR_NOTFOUND) ? -ENOENT : -EINVAL;
+	}
+
+	offset = fdt_add_subnode(root_fdt, offset, name);
+	if (offset < 0) {
+		pr_err("Failed to add root FDT subnode '%s': %s\n",
+		       name, fdt_strerror(offset));
+		return -ENOSPC;
+	}
+
+	err = fdt_setprop(root_fdt, offset, PROP_SUB_FDT,
+			  &phys, sizeof(phys));
+	if (err) {
+		pr_err("Failed to set property for FDT subnode '%s': %s\n",
+		       name, fdt_strerror(err));
+		fdt_del_node(root_fdt, offset);
+		return -ENOSPC;
+	}
 
-	return kho_debugfs_fdt_add(&ser->fdt_list, ser->sub_fdt_dir, name, fdt);
+	return kho_debugfs_fdt_add(&kho_out.ser.fdt_list,
+				   kho_out.ser.sub_fdt_dir, name, fdt);
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-struct kho_out {
-	struct blocking_notifier_head chain_head;
+/**
+ * kho_remove_subtree - remove a previously added sub FDT.
+ * @name: name of the sub tree to remove.
+ *
+ * Removes a child node named @name from the KHO root FDT that was
+ * previously added with kho_add_subtree().
+ *
+ * The corresponding debugfs blob entry at
+ * ``/sys/kernel/debug/kho/out/sub_fdts/@name`` is also removed.
+ *
+ * Return: 0 on success, error code on failure.
+ */
+int kho_remove_subtree(const char *name)
+{
+	void *root_fdt = page_to_virt(kho_out.ser.fdt);
+	int offset, err;
 
-	struct dentry *dir;
+	guard(mutex)(&kho_out.ser.fdt_mutex);
 
-	struct mutex lock; /* protects KHO FDT finalization */
+	offset = fdt_path_offset(root_fdt, "/");
+	if (offset < 0) {
+		pr_err("Failed to find the root FDT node: %s\n",
+		       fdt_strerror(offset));
+		err = (offset == -FDT_ERR_NOTFOUND) ? -ENOENT : -EINVAL;
+		goto remove_debugfs;
+	}
 
-	struct kho_serialization ser;
-	bool finalized;
-};
+	offset = fdt_subnode_offset(root_fdt, offset, name);
+	if (offset < 0) {
+		pr_err("Error finding root FDT subnode '%s': %s\n", name,
+		       fdt_strerror(offset));
+		err = (offset == -FDT_ERR_NOTFOUND) ? -ENOENT : -EINVAL;
+		goto remove_debugfs;
+	}
 
-static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
-	.lock = __MUTEX_INITIALIZER(kho_out.lock),
-	.ser = {
-		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
-		.track = {
-			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
-		},
-	},
-	.finalized = false,
-};
+	err = fdt_del_node(root_fdt, offset);
+	if (err < 0) {
+		pr_err("Failed to delete subnode '%s': %s\n", name,
+		       fdt_strerror(err));
+		err = -EINVAL;
+		goto remove_debugfs;
+	}
+
+remove_debugfs:
+	if (kho_debugfs_fdt_remove(&kho_out.ser.fdt_list, name) && !err)
+		err = -ENOENT;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(kho_remove_subtree);
 
 int register_kho_notifier(struct notifier_block *nb)
 {
@@ -679,12 +813,8 @@ int kho_preserve_folio(struct folio *folio)
 {
 	const unsigned long pfn = folio_pfn(folio);
 	const unsigned int order = folio_order(folio);
-	struct kho_mem_track *track = &kho_out.ser.track;
-
-	if (kho_out.finalized)
-		return -EBUSY;
 
-	return __kho_preserve_order(track, pfn, order);
+	return __kho_preserve_order(pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
 
@@ -701,14 +831,8 @@ EXPORT_SYMBOL_GPL(kho_preserve_folio);
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
@@ -717,19 +841,14 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
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
 
@@ -737,150 +856,6 @@ EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
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
@@ -921,11 +896,6 @@ static __init int kho_out_debugfs_init(void)
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
@@ -1037,6 +1007,36 @@ static __init int kho_in_debugfs_init(const void *fdt)
 	return err;
 }
 
+static int kho_out_fdt_init(void)
+{
+	void *fdt = page_to_virt(kho_out.ser.fdt);
+	u64 preserved_radix_tree_pa;
+	int err = 0;
+
+	err = fdt_create_empty_tree(fdt, PAGE_SIZE);
+	if (err)
+		goto out;
+
+	err = fdt_setprop_string(fdt, 0, "compatible", KHO_FDT_COMPATIBLE);
+	if (err)
+		goto out;
+
+	down_read(&kho_radix_tree_root_sem);
+	preserved_radix_tree_pa = (u64)virt_to_phys(kho_radix_tree_root);
+	up_read(&kho_radix_tree_root_sem);
+
+	err = fdt_setprop(fdt, 0, PROP_PRESERVED_PAGE_RADIX_TREE,
+			  &preserved_radix_tree_pa, sizeof(u64));
+	if (err)
+		goto out;
+
+out:
+	if (err)
+		pr_err("Failed to convert KHO memory tree: %d\n", err);
+
+	return err;
+}
+
 static __init int kho_init(void)
 {
 	int err = 0;
@@ -1051,15 +1051,31 @@ static __init int kho_init(void)
 		goto err_free_scratch;
 	}
 
+	down_write(&kho_radix_tree_root_sem);
+	kho_radix_tree_root = (struct kho_radix_tree *)
+		kzalloc(PAGE_SIZE, GFP_KERNEL);
+	up_write(&kho_radix_tree_root_sem);
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
@@ -1087,6 +1103,9 @@ static __init int kho_init(void)
 
 	return 0;
 
+err_free_kho_radix_tree_root:
+	kfree(kho_radix_tree_root);
+	kho_radix_tree_root = NULL;
 err_free_fdt:
 	put_page(kho_out.ser.fdt);
 	kho_out.ser.fdt = NULL;
@@ -1100,7 +1119,7 @@ static __init int kho_init(void)
 	kho_enable = false;
 	return err;
 }
-late_initcall(kho_init);
+subsys_initcall(kho_init);
 
 static void __init kho_release_scratch(void)
 {
-- 
2.51.0.858.gf9c4a03a3a-goog



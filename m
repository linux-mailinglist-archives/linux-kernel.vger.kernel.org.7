Return-Path: <linux-kernel+bounces-808446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21301B4FFD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEB41C6179B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597DF34F494;
	Tue,  9 Sep 2025 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTCMk9Ub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06334F490
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429082; cv=none; b=b9V7dUHtkaTroD7Q6thLrVCAN+c9GNZvVBf2omWoTYecFIJ/e8jDrecxOcYJfXBVa6InzEdjCgcEMLaqSGgTvZkZrcvNAe2AB2d8Wvt0FJTjtcEMg/mvlNmumjIMzKQIekFdPiOFI1K+4784LqZwRE2Ir6cMG1NGggUKNZL/qHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429082; c=relaxed/simple;
	bh=9MZqSQvw5qyTZgNHswRXw8wMGyHQiJ8VgjtL5Ns5Ug4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owoOhyZr5K6/Tc3frs86r7eAtV0QdNgtmH/KVtYjSQLwK/prOObDC3gSP2q0AD6z7W8Pp5vfOXqzoVGtg7j7GYKGc+E/vpzVHFSLD1UmNAjQZOFJLmpHZfuEPA6WnSs6w+vQsyOlh4NAoDU3n45T6Ryxc7X3u0AJlGvlM+IzgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTCMk9Ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1801C4CEF4;
	Tue,  9 Sep 2025 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757429082;
	bh=9MZqSQvw5qyTZgNHswRXw8wMGyHQiJ8VgjtL5Ns5Ug4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTCMk9Ub9Ng4v+4IqxsqNkL1aWkxpzQIFyf+EXDEwI319MXSJoe6p59xW7F5cMZer
	 juosq20FywgDc+qbSFwXismNwfJE2hPy6oFtTPvDYl0BHz19MJFqdquTnx3V7eKfj3
	 QTrauj37Pq/l709vyei0pdqxuQnr69m+mdsOk7JV1+zLyX0j6w7A4Mhw6r9PlxPHEb
	 GCV3X6k1uqS+eMqGyTddkfqGpNuljywn0mPJB+gGDW5QSeOABCXFWFMBsgEbGJtaMf
	 HSI+sHNEbu369ei3q/LC0EL7G7DmDx94Jziq5At/SYHfPCI1OutZQS3WELmFc32DSh
	 YhTtId0FXEHzQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] kho: use KHO array for preserved memory bitmap serialization
Date: Tue,  9 Sep 2025 16:44:22 +0200
Message-ID: <20250909144426.33274-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909144426.33274-1-pratyush@kernel.org>
References: <20250909144426.33274-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The preserved memory bitmap preservation creates a linked list of pages
to track the bitmaps for preserved memory. Essentially, it is a
scattered list of pointers grouped by folio order. Use a KHO array to
hold the pointers to the bitmaps instead. This moves the burden of
tracking this metadata to the KHO array layer, and makes the KHO core
simpler.

Currently, the bitmaps are held in chunks, which is a fixed-size array
of pointers, plus some metadata including the order of the preserved
folios. The KHO array holds only pointers and has no mechanism for
grouping. To make the serialization format simpler, move the folio order
from struct khoser_mem_chunk to struct khoser_mem_bitmap_ptr.

The chunks to hold the bitmaps are not KHO-preserved since they are only
used during the scratch-only phase. The same holds true with the KHO
array. The pages which track the KHO array metadata are not
KHO-preserved and thus are only valid during the scratch phase of the
next kernel. After that, they are discarded and freed to buddy.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

The diff is a bit hard to read. The final result can be found at
https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/tree/kernel/kexec_handover.c?h=kho-array-rfc-v1#n227

 kernel/kexec_handover.c | 148 +++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 79 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd7..26f9f5295f07d 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
+#include <linux/kho_array.h>
 
 #include <asm/early_ioremap.h>
 
@@ -80,15 +81,13 @@ struct kho_mem_track {
 	struct xarray orders;
 };
 
-struct khoser_mem_chunk;
-
 struct kho_serialization {
 	struct page *fdt;
 	struct list_head fdt_list;
 	struct dentry *sub_fdt_dir;
 	struct kho_mem_track track;
-	/* First chunk of serialized preserved memory map */
-	struct khoser_mem_chunk *preserved_mem_map;
+	/* Serialized preserved memory map */
+	struct kho_array *preserved_mem_map;
 };
 
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
@@ -226,11 +225,11 @@ EXPORT_SYMBOL_GPL(kho_restore_folio);
 
 /* Serialize and deserialize struct kho_mem_phys across kexec
  *
- * Record all the bitmaps in a linked list of pages for the next kernel to
- * process. Each chunk holds bitmaps of the same order and each block of bitmaps
- * starts at a given physical address. This allows the bitmaps to be sparse. The
- * xarray is used to store them in a tree while building up the data structure,
- * but the KHO successor kernel only needs to process them once in order.
+ * Record all the bitmaps in a KHO array for the next kernel to process. Each
+ * bitmap stores the order of the folios and starts at a given physical address.
+ * This allows the bitmaps to be sparse. The xarray is used to store them in a
+ * tree while building up the data structure, but the KHO successor kernel only
+ * needs to process them once in order.
  *
  * All of this memory is normal kmalloc() memory and is not marked for
  * preservation. The successor kernel will remain isolated to the scratch space
@@ -240,118 +239,107 @@ EXPORT_SYMBOL_GPL(kho_restore_folio);
 
 struct khoser_mem_bitmap_ptr {
 	phys_addr_t phys_start;
-	DECLARE_KHOSER_PTR(bitmap, struct kho_mem_phys_bits *);
-};
-
-struct khoser_mem_chunk_hdr {
-	DECLARE_KHOSER_PTR(next, struct khoser_mem_chunk *);
 	unsigned int order;
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
+	unsigned int __reserved;
+	DECLARE_KHOSER_PTR(bitmap, struct kho_mem_phys_bits *);
 };
 
-static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
-
-static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
-					  unsigned long order)
+static struct khoser_mem_bitmap_ptr *new_bitmap(phys_addr_t start,
+						struct kho_mem_phys_bits *bits,
+						unsigned int order)
 {
-	struct khoser_mem_chunk *chunk;
+	struct khoser_mem_bitmap_ptr *bitmap;
 
-	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!chunk)
+	bitmap = kzalloc(sizeof(*bitmap), GFP_KERNEL);
+	if (!bitmap)
 		return NULL;
-	chunk->hdr.order = order;
-	if (cur_chunk)
-		KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
-	return chunk;
+
+	bitmap->phys_start = start;
+	bitmap->order = order;
+	KHOSER_STORE_PTR(bitmap->bitmap, bits);
+	return bitmap;
 }
 
-static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
+static void kho_mem_ser_free(struct kho_array *ka)
 {
-	struct khoser_mem_chunk *chunk = first_chunk;
+	struct khoser_mem_bitmap_ptr *elm;
+	struct ka_iter iter;
 
-	while (chunk) {
-		struct khoser_mem_chunk *tmp = chunk;
+	if (!ka)
+		return;
 
-		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		kfree(tmp);
-	}
+	ka_iter_init_read(&iter, ka);
+	ka_iter_for_each(&iter, elm)
+		kfree(elm);
+
+	kho_array_destroy(ka);
+	kfree(ka);
 }
 
 static int kho_mem_serialize(struct kho_serialization *ser)
 {
-	struct khoser_mem_chunk *first_chunk = NULL;
-	struct khoser_mem_chunk *chunk = NULL;
 	struct kho_mem_phys *physxa;
-	unsigned long order;
+	unsigned long order, pos = 0;
+	struct kho_array *ka = NULL;
+	struct ka_iter iter;
+
+	ka = kzalloc(sizeof(*ka), GFP_KERNEL);
+	if (!ka)
+		return -ENOMEM;
+	ka_iter_init_write(&iter, ka);
 
 	xa_for_each(&ser->track.orders, order, physxa) {
 		struct kho_mem_phys_bits *bits;
 		unsigned long phys;
 
-		chunk = new_chunk(chunk, order);
-		if (!chunk)
-			goto err_free;
-
-		if (!first_chunk)
-			first_chunk = chunk;
-
 		xa_for_each(&physxa->phys_bits, phys, bits) {
 			struct khoser_mem_bitmap_ptr *elm;
+			phys_addr_t start;
+
+			start = (phys * PRESERVE_BITS) << (order + PAGE_SHIFT);
+			elm = new_bitmap(start, bits, order);
+			if (!elm)
+				goto err_free;
 
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
+			ka_iter_setpos(&iter, pos);
+			if (ka_iter_setentry(&iter, elm))
+				goto err_free;
+			pos++;
 		}
 	}
 
-	ser->preserved_mem_map = first_chunk;
+	ser->preserved_mem_map = ka;
 
 	return 0;
 
 err_free:
-	kho_mem_ser_free(first_chunk);
+	kho_mem_ser_free(ka);
 	return -ENOMEM;
 }
 
-static void __init deserialize_bitmap(unsigned int order,
-				      struct khoser_mem_bitmap_ptr *elm)
+static void __init deserialize_bitmap(struct khoser_mem_bitmap_ptr *elm)
 {
 	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
 	unsigned long bit;
 
 	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
-		int sz = 1 << (order + PAGE_SHIFT);
+		int sz = 1 << (elm->order + PAGE_SHIFT);
 		phys_addr_t phys =
-			elm->phys_start + (bit << (order + PAGE_SHIFT));
+			elm->phys_start + (bit << (elm->order + PAGE_SHIFT));
 		struct page *page = phys_to_page(phys);
 
 		memblock_reserve(phys, sz);
 		memblock_reserved_mark_noinit(phys, sz);
-		page->private = order;
+		page->private = elm->order;
 	}
 }
 
 static void __init kho_mem_deserialize(const void *fdt)
 {
-	struct khoser_mem_chunk *chunk;
+	struct khoser_mem_bitmap_ptr *elm;
 	const phys_addr_t *mem;
+	struct kho_array *ka;
+	struct ka_iter iter;
 	int len;
 
 	mem = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
@@ -361,15 +349,17 @@ static void __init kho_mem_deserialize(const void *fdt)
 		return;
 	}
 
-	chunk = *mem ? phys_to_virt(*mem) : NULL;
-	while (chunk) {
-		unsigned int i;
-
-		for (i = 0; i != chunk->hdr.num_elms; i++)
-			deserialize_bitmap(chunk->hdr.order,
-					   &chunk->bitmaps[i]);
-		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+	ka = *mem ? phys_to_virt(*mem) : NULL;
+	if (!ka)
+		return;
+	if (!kho_array_valid(ka)) {
+		pr_err("invalid KHO array for preserved memory bitmaps\n");
+		return;
 	}
+
+	ka_iter_init_read(&iter, ka);
+	ka_iter_for_each(&iter, elm)
+		deserialize_bitmap(elm);
 }
 
 /*
-- 
2.47.3



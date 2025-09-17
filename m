Return-Path: <linux-kernel+bounces-819901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55095B7D220
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2676F3BF9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B72F548A;
	Wed, 17 Sep 2025 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzpsCtt0"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D62F60C0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077444; cv=none; b=ZIRrKZhFdF86fzz68FTZOjjbsIU6JgyWLrGVxkmwAuq0bQbura6aGvevX36LJrWc9qgx3NXndG5FiGE16mirzElkzg78VyKZ0M4Gw0hg8qt9XmWaBHAyZ5iDHFJ1js2nQjlQ2X5WfqB6XeLuP58/xyWIlI/4Hogr5WXFBcjArf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077444; c=relaxed/simple;
	bh=ZeFJ5CJ93ezJ9ud5P1PKnY1D5bX4jEEc7kPQgimxR9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cA5sjb1GX/y9wMIQdiLhh1+ssBAra3eYoGQQc0bhH/ARbWtsinO4b8lERD7KBlEO7ep2RKrKr9wI4jyNqJZhbmoQ72Ks0GkaYDXPKXQ0ZrcrxH9rMdO5lxFvY50XcbMft52vLvhCkbmz47d9H2co27JTr3CrJjI0tPRYPwHAtKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hzpsCtt0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54b311beabso3297677a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758077441; x=1758682241; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RU6/kpZEGAR06M2wVDolyGswZ9cjx0r+1Ic9uqduI2Q=;
        b=hzpsCtt0nhXZset6gmWkYJAFRgFTcQYGV1oSKUtFwfXOd8IMGd/jpcWh52YC5a/2gF
         SdIfvwLwaK4p3jB9VAKJCwvfUuKed0YMBqUWIos4BWS/l6+/dZs2MzYD9Nj1jnmXrPH+
         AvBFRCHddAMxd1J4Pfi8jW4ARYll40jygc0MmWQ/bJpspJFdNm17PvRwQAIrDWxja5ZU
         FD5oigYUcPrlJB51BorS3+Uw1E5Z79dGny6Cma4uN+4+ZKksfn7eIstRogNvKy7Ice8A
         zCicdnffnC0k0opeEhRpWivG/YAO/0Ya1ABN/HeOmhp08Z1AWZTUzj1wFCkcW6IxRafw
         9/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077441; x=1758682241;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RU6/kpZEGAR06M2wVDolyGswZ9cjx0r+1Ic9uqduI2Q=;
        b=saJWNE9W7CXSyXFImpLghoeaptJrKF9Q2W9bqlNsmuqIlhsjxB3VkN/xDWNzy1acKS
         V29T7icOBNfmH3XraseHvClvj/B967SkAsPCM7jxacjSNJFeoy7Bg6CyrYYMiy4Tbfuj
         JdeBEm6YMiReAt4lwJiyRK2ypqbw0uUZ3OGs29nxZ8QFYczmGCV3elaNlSnUiR7xjngf
         KtH604M9Fha9R5tWn2JH2WS5gRtrHem+iX6Zx442fNIM3J+gB1Wvj87RkDzLlJr9gsyv
         8w+N4A76VYXz4m16aemr+QsDz8A6QsWvUAL8+TuWeRmz6zdrtzf8i51cJbGmNHCmRWKi
         8Tzg==
X-Forwarded-Encrypted: i=1; AJvYcCULcLJ8xkldUpdsHFs8doAB5lQFNWL1dkiwlm0rJOImOHU4Fx78gUvs1wspg3B0CaaFDjdQcbjBWmPMV/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxKqi6+QrJJWWr0tGSnEXC0IzkfMZgUGGBivZvmwyscSs1w7j
	uXh4v0ExWNCz0DDjNdcObjMIUfMrCIs5+fz2BL4poYTuM/A6Ggo4mDQ+fVTdeo04yADMig/j+x3
	OJXx2dQagr6qUoA==
X-Google-Smtp-Source: AGHT+IErFehkHx558QRyQefB1/NtFlc2KGjefUET9/Av+8/Gyz/SnvIhDvJdH2sa4sKdNORbBQODik0RC7MKrg==
X-Received: from plkb5.prod.google.com ([2002:a17:903:fa5:b0:264:7b3c:4fe4])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c406:b0:260:df70:f753 with SMTP id d9443c01a7336-268137fd0a4mr6203875ad.38.1758077441117;
 Tue, 16 Sep 2025 19:50:41 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:50:17 -0700
In-Reply-To: <20250917025019.1585041-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917025019.1585041-3-jasonmiu@google.com>
Subject: [RFC v1 2/4] kho: Adopt KHO page tables and remove serialization
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Transition the KHO system to use the new page table data structures
for managing preserved memory, replacing the previous xarray-based
approach. Remove the serialization process and the associated
finalization and abort logic.

Update the methods for marking memory to be preserved to use the KHO
page table hierarchy. Remove the former system of tracking preserved
pages using an xarray-based structure.

Change the method of passing preserved memory information to the next
kernel to be direct. Instead of serializing the memory map, place the
physical address of the `kho_order_table`, which holds the roots of
the KHO page tables for each order, in the FDT. Remove the explicit
`kho_finalize()` and `kho_abort()` functions and the logic supporting
the finalize and abort states, as they are no longer needed. This
simplifies the KHO lifecycle.

Enable the next kernel's initialization process to read the
`kho_order_table` address from the FDT. The kernel will then traverse
the KHO page table structures to discover all preserved memory
regions, reserving them to prevent early boot-time allocators from
overwriting them.

This architectural shift to using a shared page table structure
simplifies the KHO design and eliminates the overhead of serializing
and deserializing the preserved memory map.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h |  17 --
 kernel/kexec_handover.c        | 532 +++++----------------------------
 2 files changed, 71 insertions(+), 478 deletions(-)

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
index 0daed51c8fb7..578d1c1b9cea 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -29,7 +29,7 @@
 #include "kexec_internal.h"
 
 #define KHO_FDT_COMPATIBLE "kho-v1"
-#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
+#define PROP_PRESERVED_ORDER_TABLE "preserved-order-table"
 #define PROP_SUB_FDT "fdt"
 
 static bool kho_enable __ro_after_init;
@@ -297,15 +297,7 @@ static int __kho_preserve_page_table(unsigned long pa, int order)
 	return 0;
 }
 
-/*
- * TODO: __maybe_unused is added to the functions:
- * kho_preserve_page_table()
- * kho_walk_tables()
- * kho_memblock_reserve()
- * since they are not actually being called in this change.
- * __maybe_unused will be removed in the next patch.
- */
-static __maybe_unused int kho_preserve_page_table(unsigned long pfn, int order)
+static int kho_preserve_page_table(unsigned long pfn, int order)
 {
 	unsigned long pa = PFN_PHYS(pfn);
 
@@ -365,8 +357,8 @@ static int __kho_walk_page_tables(int order, int level,
 	return 0;
 }
 
-static __maybe_unused int kho_walk_page_tables(struct kho_page_table *top, int order,
-					       kho_walk_callback_t cb)
+static int kho_walk_page_tables(struct kho_page_table *top, int order,
+				kho_walk_callback_t cb)
 {
 	int num_table_level;
 
@@ -378,7 +370,7 @@ static __maybe_unused int kho_walk_page_tables(struct kho_page_table *top, int o
 	return 0;
 }
 
-static __maybe_unused int kho_memblock_reserve(phys_addr_t pa, int order)
+static int kho_memblock_reserve(phys_addr_t pa, int order)
 {
 	int sz = 1 << (order + PAGE_SHIFT);
 	struct page *page = phys_to_page(pa);
@@ -390,143 +382,12 @@ static __maybe_unused int kho_memblock_reserve(phys_addr_t pa, int order)
 	return 0;
 }
 
-/*
- * Keep track of memory that is to be preserved across KHO.
- *
- * The serializing side uses two levels of xarrays to manage chunks of per-order
- * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
- * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
- * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
- * 512K of bitmap memory will be needed for order 0.
- *
- * This approach is fully incremental, as the serialization progresses folios
- * can continue be aggregated to the tracker. The final step, immediately prior
- * to kexec would serialize the xarray information into a linked list for the
- * successor kernel to parse.
- */
-
-#define PRESERVE_BITS (512 * 8)
-
-struct kho_mem_phys_bits {
-	DECLARE_BITMAP(preserve, PRESERVE_BITS);
-};
-
-struct kho_mem_phys {
-	/*
-	 * Points to kho_mem_phys_bits, a sparse bitmap array. Each bit is sized
-	 * to order.
-	 */
-	struct xarray phys_bits;
-};
-
-struct kho_mem_track {
-	/* Points to kho_mem_phys, each order gets its own bitmap tree */
-	struct xarray orders;
-};
-
-struct khoser_mem_chunk;
-
 struct kho_serialization {
 	struct page *fdt;
 	struct list_head fdt_list;
 	struct dentry *sub_fdt_dir;
-	struct kho_mem_track track;
-	/* First chunk of serialized preserved memory map */
-	struct khoser_mem_chunk *preserved_mem_map;
 };
 
-static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
-{
-	void *elm, *res;
-
-	elm = xa_load(xa, index);
-	if (elm)
-		return elm;
-
-	elm = kzalloc(sz, GFP_KERNEL);
-	if (!elm)
-		return ERR_PTR(-ENOMEM);
-
-	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
-	if (xa_is_err(res))
-		res = ERR_PTR(xa_err(res));
-
-	if (res) {
-		kfree(elm);
-		return res;
-	}
-
-	return elm;
-}
-
-static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
-			     unsigned long end_pfn)
-{
-	struct kho_mem_phys_bits *bits;
-	struct kho_mem_phys *physxa;
-
-	while (pfn < end_pfn) {
-		const unsigned int order =
-			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		const unsigned long pfn_high = pfn >> order;
-
-		physxa = xa_load(&track->orders, order);
-		if (!physxa)
-			continue;
-
-		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (!bits)
-			continue;
-
-		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
-
-		pfn += 1 << order;
-	}
-}
-
-static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
-				unsigned int order)
-{
-	struct kho_mem_phys_bits *bits;
-	struct kho_mem_phys *physxa, *new_physxa;
-	const unsigned long pfn_high = pfn >> order;
-
-	might_sleep();
-
-	physxa = xa_load(&track->orders, order);
-	if (!physxa) {
-		int err;
-
-		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
-		if (!new_physxa)
-			return -ENOMEM;
-
-		xa_init(&new_physxa->phys_bits);
-		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
-				    GFP_KERNEL);
-
-		err = xa_err(physxa);
-		if (err || physxa) {
-			xa_destroy(&new_physxa->phys_bits);
-			kfree(new_physxa);
-
-			if (err)
-				return err;
-		} else {
-			physxa = new_physxa;
-		}
-	}
-
-	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
-				sizeof(*bits));
-	if (IS_ERR(bits))
-		return PTR_ERR(bits);
-
-	set_bit(pfn_high % PRESERVE_BITS, bits->preserve);
-
-	return 0;
-}
-
 /* almost as free_reserved_page(), just don't free the page */
 static void kho_restore_page(struct page *page, unsigned int order)
 {
@@ -568,151 +429,29 @@ struct folio *kho_restore_folio(phys_addr_t phys)
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
-	int len;
-
-	mem = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
+	int len, i;
+	struct kho_order_table *order_table;
 
+	/* Retrieve the KHO order table from passed-in FDT. */
+	mem = fdt_getprop(fdt, 0, PROP_PRESERVED_ORDER_TABLE, &len);
 	if (!mem || len != sizeof(*mem)) {
-		pr_err("failed to get preserved memory bitmaps\n");
+		pr_err("failed to get preserved order table\n");
 		return;
 	}
 
-	chunk = *mem ? phys_to_virt(*mem) : NULL;
-	while (chunk) {
-		unsigned int i;
+	order_table = *mem ?
+		(struct kho_order_table *)phys_to_virt(*mem) :
+		NULL;
 
-		for (i = 0; i != chunk->hdr.num_elms; i++)
-			deserialize_bitmap(chunk->hdr.order,
-					   &chunk->bitmaps[i]);
-		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+	if (!order_table)
+		return;
+
+	for (i = 0; i < HUGETLB_PAGE_ORDER + 1; i++) {
+		kho_walk_page_tables(kho_page_table(order_table->orders[i]),
+				     i, kho_memblock_reserve);
 	}
 }
 
@@ -977,25 +716,15 @@ EXPORT_SYMBOL_GPL(kho_add_subtree);
 
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
@@ -1023,12 +752,8 @@ int kho_preserve_folio(struct folio *folio)
 {
 	const unsigned long pfn = folio_pfn(folio);
 	const unsigned int order = folio_order(folio);
-	struct kho_mem_track *track = &kho_out.ser.track;
-
-	if (kho_out.finalized)
-		return -EBUSY;
 
-	return __kho_preserve_order(track, pfn, order);
+	return kho_preserve_page_table(pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
 
@@ -1045,14 +770,8 @@ EXPORT_SYMBOL_GPL(kho_preserve_folio);
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
@@ -1061,19 +780,14 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
 
-		err = __kho_preserve_order(track, pfn, order);
-		if (err) {
-			failed_pfn = pfn;
-			break;
-		}
+		err = kho_preserve_page_table(pfn, order);
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
 
@@ -1081,150 +795,6 @@ EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
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
@@ -1265,11 +835,6 @@ static __init int kho_out_debugfs_init(void)
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
@@ -1381,6 +946,35 @@ static __init int kho_in_debugfs_init(const void *fdt)
 	return err;
 }
 
+static int kho_out_fdt_init(void)
+{
+	int err = 0;
+	void *fdt = page_to_virt(kho_out.ser.fdt);
+	u64 *preserved_order_table;
+
+	err |= fdt_create(fdt, PAGE_SIZE);
+	err |= fdt_finish_reservemap(fdt);
+	err |= fdt_begin_node(fdt, "");
+	err |= fdt_property_string(fdt, "compatible", KHO_FDT_COMPATIBLE);
+
+	err |= fdt_property_placeholder(fdt, PROP_PRESERVED_ORDER_TABLE,
+					sizeof(*preserved_order_table),
+					(void **)&preserved_order_table);
+	if (err)
+		goto abort;
+
+	*preserved_order_table = (u64)virt_to_phys(kho_order_table);
+
+	err |= fdt_end_node(fdt);
+	err |= fdt_finish(fdt);
+
+abort:
+	if (err)
+		pr_err("Failed to convert KHO state tree: %d\n", err);
+
+	return err;
+}
+
 static __init int kho_init(void)
 {
 	int err = 0;
@@ -1395,15 +989,26 @@ static __init int kho_init(void)
 		goto err_free_scratch;
 	}
 
+	kho_order_table = (struct kho_order_table *)
+		kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!kho_order_table) {
+		err = -ENOMEM;
+		goto err_free_fdt;
+	}
+
+	err = kho_out_fdt_init();
+	if (err)
+		goto err_free_kho_order_table;
+
 	debugfs_root = debugfs_create_dir("kho", NULL);
 	if (IS_ERR(debugfs_root)) {
 		err = -ENOENT;
-		goto err_free_fdt;
+		goto err_free_kho_order_table;
 	}
 
 	err = kho_out_debugfs_init();
 	if (err)
-		goto err_free_fdt;
+		goto err_free_kho_order_table;
 
 	if (fdt) {
 		err = kho_in_debugfs_init(fdt);
@@ -1431,6 +1036,9 @@ static __init int kho_init(void)
 
 	return 0;
 
+err_free_kho_order_table:
+	kfree(kho_order_table);
+	kho_order_table = NULL;
 err_free_fdt:
 	put_page(kho_out.ser.fdt);
 	kho_out.ser.fdt = NULL;
@@ -1581,6 +1189,8 @@ int kho_fill_kimage(struct kimage *image)
 		return 0;
 
 	image->kho.fdt = page_to_phys(kho_out.ser.fdt);
+	/* Preserve the memory page of FDT for the next kernel */
+	kho_preserve_phys(image->kho.fdt, PAGE_SIZE);
 
 	scratch_size = sizeof(*kho_scratch) * kho_scratch_cnt;
 	scratch = (struct kexec_buf){
-- 
2.51.0.384.g4c02a37b29-goog



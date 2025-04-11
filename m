Return-Path: <linux-kernel+bounces-599370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA35AA85330
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 07:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B99D1B85078
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 05:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A827EC87;
	Fri, 11 Apr 2025 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORr7L3r8"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17227E1DD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744349912; cv=none; b=nbbTrMyxFVtaiOwdllAMNn8oDHoMykVCiNBesTgstlCCU1751tSERJ0P106d9Km78MjBIIfFADkBwCuG3qjoc7rJJYiDFaeTSb4J0gucv+qTSxAJ7ZbQoPxNB9g6s4CmroEF5ebIsfepdf7I2QYHI1lSZ+RnNLni+N9T/NuZ8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744349912; c=relaxed/simple;
	bh=Q43yVaWBF4AIJXpGFaOkzBIORD6w7MKle5u5H63xUKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ToWvSdYQ4l0L156aDAf4QWa+W/5a5EXK6n5kzVK4T/g7e9n1DNMX3Jj4QtZRimI1icQKErPSIFZCwEMqo90tqYsrxPo/CpNJ7kSFxg9l8GWrJVv2vhp26oO9TSMcsj9DOwJhcMcbrZip1UTo1IuifDaBGP0g4mmN8Ngt9YfWoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORr7L3r8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225974c6272so13492305ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 22:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744349910; x=1744954710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lff/IlhssaSE8/N5WWt3O745ULQMov2cvh2wPJvEqbY=;
        b=ORr7L3r8QPk1jlkGueSHXnwE2G4r+CHgw8zn+66n6G8VipcY3jptAWs+OLjhK+4ixu
         lFXTjERnhjw7VRhXgDGvrMlWDxjBm9GQuRu4ap5Rkpl9AO1ZLypzobq5q+500jCCQ5kQ
         EsVeFaO+FAiTVQl+qyTgaYTAsevX67M6eVcnQP6rOywVOt1VpWg3AFL3SLduze+x3HFv
         W0b5yHK/7cuc1cMAw1e4HhV+MiLl2F7HQEapTLhDI/1s6QzsexZMqnOKJJQDiBpP3HxT
         aNUdFRF1PgK9sFWP8HRvtD6LdMDl/1UQDYlNLaneAZ6udsJ7KfPiN7GT/XygK6pXYLPr
         0+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744349910; x=1744954710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lff/IlhssaSE8/N5WWt3O745ULQMov2cvh2wPJvEqbY=;
        b=WHSwOGXiDvvuH8JJER6IPKmphkrdSrkRWHATSoFgvn7AavHsa7qzEUE28eBWRVG3HY
         q5erUFlu5f6emYNx90xsf8Wy50r2nzXeaorezp0i14mgtKsi0KqYKYf7o0Xa4Dn12O+E
         o39aiNuzVJTR+XzBH5HNz+Ily7WMPU1cVhylPOnPWGl67lPOCrkQYkpFIoSoLLSImv4F
         LXM9e06WJ/8fjhiwVXP2ZGOFbg+qxJXn5gZ+Cs6bWBcGc2UZ/ReVK8zb8aKcNX1TKPD7
         FAW24Ra0cqSdrVQzyccTDcWmXqLtkO1uXUlsjL3tGLyb1Ou8WZ80ur/Sq3ZNG0a+CjbZ
         Chow==
X-Gm-Message-State: AOJu0YxD7ShZd6VQgX29rYPSSGx18sp1mDyeHHH8qPmB5cfEQNa/b1Ts
	vg1FUk6qfjn+59UM19gREHtcoZK2szcW7q09mwPr1NJ31EpaoAYkUYceKBLaeUaJmeoqXTVagBf
	QNhe1aEaGgPGS7iJ0QLN1cZHWr5FMEZVr9s2OQ/D+2tKn/YlS8R9VCxmMYYBdRCSmTuEf3g1YIk
	zorrm8/gu7BZTjg28SFTO1Ubd2h4jdrH5eBggeUOt1lmBeKexd39m3/tCkWjhcjQ==
X-Google-Smtp-Source: AGHT+IEeiwtLzkCdqR92c0X+CgHOPc95gWH4nzUne44aCdHmdyons9NHHROp5P+cGzv44OjKXLvj1zX98VnQItkb
X-Received: from plblc7.prod.google.com ([2002:a17:902:fa87:b0:21f:40e5:a651])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f54f:b0:220:ff82:1c60 with SMTP id d9443c01a7336-22b694abda1mr76874555ad.14.1744349909808;
 Thu, 10 Apr 2025 22:38:29 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:37:37 -0700
In-Reply-To: <20250411053745.1817356-1-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250411053745.1817356-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411053745.1817356-7-changyuanl@google.com>
Subject: [PATCH v6 06/14] kexec: enable KHO support for memory preservation
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org, 
	rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	will@kernel.org, x86@kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Introduce APIs allowing KHO users to preserve memory across kexec and
get access to that memory after boot of the kexeced kernel

kho_preserve_folio() - record a folio to be preserved over kexec
kho_restore_folio() - recreates the folio from the preserved memory
kho_preserve_phys() - record physically contiguous range to be
preserved over kexec.

The memory preservations are tracked by two levels of xarrays to manage
chunks of per-order 512 byte bitmaps. For instance if PAGE_SIZE = 4096,
the entire 1G order of a 1TB x86 system would fit inside a single 512
byte bitmap. For order 0 allocations each bitmap will cover 16M of
address space. Thus, for 16G of memory at most 512K of bitmap memory
will be needed for order 0.

At serialization time all bitmaps are recorded in a linked list of pages
for the next kernel to process and the physical address of the list is
recorded in KHO FDT.

The next kernel then processes that list, reserves the memory ranges and
later, when a user requests a folio or a physical range, KHO restores
corresponding memory map entries.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/kexec_handover.h |  39 ++++
 kernel/kexec_handover.c        | 401 +++++++++++++++++++++++++++++++++
 2 files changed, 440 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 2b77d4b9fbc3c..d96ba4fb27704 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -15,13 +15,35 @@ enum kho_event {
 	KEXEC_KHO_ABORT = 1,
 };
 
+struct folio;
 struct notifier_block;
 
+#define DECLARE_KHOSER_PTR(name, type) \
+	union {                        \
+		phys_addr_t phys;      \
+		type ptr;              \
+	} name
+#define KHOSER_STORE_PTR(dest, val)               \
+	({                                        \
+		typeof(val) v = val;              \
+		typecheck(typeof((dest).ptr), v); \
+		(dest).phys = virt_to_phys(v);    \
+	})
+#define KHOSER_LOAD_PTR(src)                                                 \
+	({                                                                   \
+		typeof(src) s = src;                                         \
+		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
+	})
+
 struct kho_serialization;
 
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
 
+int kho_preserve_folio(struct kho_serialization *ser, struct folio *folio);
+int kho_preserve_phys(struct kho_serialization *ser, phys_addr_t phys,
+		      size_t size);
+struct folio *kho_restore_folio(phys_addr_t phys);
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
@@ -38,6 +60,23 @@ static inline bool kho_is_enabled(void)
 	return false;
 }
 
+static inline int kho_preserve_folio(struct kho_serialization *ser,
+				     struct folio *folio)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int kho_preserve_phys(struct kho_serialization *ser,
+				    phys_addr_t phys, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct folio *kho_restore_folio(phys_addr_t phys)
+{
+	return NULL;
+}
+
 static inline int kho_add_subtree(struct kho_serialization *ser,
 				  const char *name, void *fdt)
 {
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index a1e1cd0330143..a594da2a22912 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "KHO: " fmt
 
 #include <linux/cma.h>
+#include <linux/count_zeros.h>
 #include <linux/debugfs.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
@@ -41,12 +42,369 @@ static int __init kho_parse_enable(char *p)
 }
 early_param("kho", kho_parse_enable);
 
+/*
+ * Keep track of memory that is to be preserved across KHO.
+ *
+ * The serializing side uses two levels of xarrays to manage chunks of per-order
+ * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
+ * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
+ * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
+ * 512K of bitmap memory will be needed for order 0.
+ *
+ * This approach is fully incremental, as the serialization progresses folios
+ * can continue be aggregated to the tracker. The final step, immediately prior
+ * to kexec would serialize the xarray information into a linked list for the
+ * successor kernel to parse.
+ */
+
+#define PRESERVE_BITS (512 * 8)
+
+struct kho_mem_phys_bits {
+	DECLARE_BITMAP(preserve, PRESERVE_BITS);
+};
+
+struct kho_mem_phys {
+	/*
+	 * Points to kho_mem_phys_bits, a sparse bitmap array. Each bit is sized
+	 * to order.
+	 */
+	struct xarray phys_bits;
+};
+
+struct kho_mem_track {
+	/* Points to kho_mem_phys, each order gets its own bitmap tree */
+	struct xarray orders;
+};
+
+struct khoser_mem_chunk;
+
 struct kho_serialization {
 	struct page *fdt;
 	struct list_head fdt_list;
 	struct dentry *sub_fdt_dir;
+	struct kho_mem_track track;
+	/* First chunk of serialized preserved memory map */
+	struct khoser_mem_chunk *preserved_mem_map;
+};
+
+static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
+{
+	void *elm, *res;
+
+	elm = xa_load(xa, index);
+	if (elm)
+		return elm;
+
+	elm = kzalloc(sz, GFP_KERNEL);
+	if (!elm)
+		return ERR_PTR(-ENOMEM);
+
+	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
+	if (xa_is_err(res))
+		res = ERR_PTR(xa_err(res));
+
+	if (res) {
+		kfree(elm);
+		return res;
+	}
+
+	return elm;
+}
+
+static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
+			     unsigned long end_pfn)
+{
+	struct kho_mem_phys_bits *bits;
+	struct kho_mem_phys *physxa;
+
+	while (pfn < end_pfn) {
+		const unsigned int order =
+			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
+		const unsigned long pfn_high = pfn >> order;
+
+		physxa = xa_load(&track->orders, order);
+		if (!physxa)
+			continue;
+
+		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
+		if (!bits)
+			continue;
+
+		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+
+		pfn += 1 << order;
+	}
+}
+
+static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
+				unsigned int order)
+{
+	struct kho_mem_phys_bits *bits;
+	struct kho_mem_phys *physxa;
+	const unsigned long pfn_high = pfn >> order;
+
+	might_sleep();
+
+	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa));
+	if (IS_ERR(physxa))
+		return PTR_ERR(physxa);
+
+	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
+				sizeof(*bits));
+	if (IS_ERR(bits))
+		return PTR_ERR(bits);
+
+	set_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+
+	return 0;
+}
+
+/**
+ * kho_preserve_folio - preserve a folio across kexec.
+ * @ser: serialization control object passed by KHO notifiers.
+ * @folio: folio to preserve.
+ *
+ * Instructs KHO to preserve the whole folio across kexec. The order
+ * will be preserved as well.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_preserve_folio(struct kho_serialization *ser, struct folio *folio)
+{
+	const unsigned long pfn = folio_pfn(folio);
+	const unsigned int order = folio_order(folio);
+
+	return __kho_preserve_order(&ser->track, pfn, order);
+}
+EXPORT_SYMBOL_GPL(kho_preserve_folio);
+
+/**
+ * kho_preserve_phys - preserve a physically contiguous range across kexec.
+ * @ser: serialization control object passed by KHO notifiers.
+ * @phys: physical address of the range.
+ * @size: size of the range.
+ *
+ * Instructs KHO to preserve the memory range from @phys to @phys + @size
+ * across kexec.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_preserve_phys(struct kho_serialization *ser, phys_addr_t phys,
+		      size_t size)
+{
+	unsigned long pfn = PHYS_PFN(phys);
+	unsigned long failed_pfn = 0;
+	const unsigned long start_pfn = pfn;
+	const unsigned long end_pfn = PHYS_PFN(phys + size);
+	int err = 0;
+
+	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
+		return -EINVAL;
+
+	while (pfn < end_pfn) {
+		const unsigned int order =
+			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
+
+		err = __kho_preserve_order(&ser->track, pfn, order);
+		if (err) {
+			failed_pfn = pfn;
+			break;
+		}
+
+		pfn += 1 << order;
+	}
+
+	if (err)
+		__kho_unpreserve(&ser->track, start_pfn, failed_pfn);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(kho_preserve_phys);
+
+/* almost as free_reserved_page(), just don't free the page */
+static void kho_restore_page(struct page *page)
+{
+	ClearPageReserved(page);
+	init_page_count(page);
+	adjust_managed_page_count(page, 1);
+}
+
+/**
+ * kho_restore_folio - recreates the folio from the preserved memory.
+ * @phys: physical address of the folio.
+ *
+ * Return: pointer to the struct folio on success, NULL on failure.
+ */
+struct folio *kho_restore_folio(phys_addr_t phys)
+{
+	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
+	unsigned long order;
+
+	if (!page)
+		return NULL;
+
+	order = page->private;
+	if (order) {
+		if (order > MAX_PAGE_ORDER)
+			return NULL;
+
+		prep_compound_page(page, order);
+	} else {
+		kho_restore_page(page);
+	}
+
+	return page_folio(page);
+}
+EXPORT_SYMBOL_GPL(kho_restore_folio);
+
+/* Serialize and deserialize struct kho_mem_phys across kexec
+ *
+ * Record all the bitmaps in a linked list of pages for the next kernel to
+ * process. Each chunk holds bitmaps of the same order and each block of bitmaps
+ * starts at a given physical address. This allows the bitmaps to be sparse. The
+ * xarray is used to store them in a tree while building up the data structure,
+ * but the KHO successor kernel only needs to process them once in order.
+ *
+ * All of this memory is normal kmalloc() memory and is not marked for
+ * preservation. The successor kernel will remain isolated to the scratch space
+ * until it completes processing this list. Once processed all the memory
+ * storing these ranges will be marked as free.
+ */
+
+struct khoser_mem_bitmap_ptr {
+	phys_addr_t phys_start;
+	DECLARE_KHOSER_PTR(bitmap, struct kho_mem_phys_bits *);
+};
+
+struct khoser_mem_chunk_hdr {
+	DECLARE_KHOSER_PTR(next, struct khoser_mem_chunk *);
+	unsigned int order;
+	unsigned int num_elms;
 };
 
+#define KHOSER_BITMAP_SIZE                                   \
+	((PAGE_SIZE - sizeof(struct khoser_mem_chunk_hdr)) / \
+	 sizeof(struct khoser_mem_bitmap_ptr))
+
+struct khoser_mem_chunk {
+	struct khoser_mem_chunk_hdr hdr;
+	struct khoser_mem_bitmap_ptr bitmaps[KHOSER_BITMAP_SIZE];
+};
+
+static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
+
+static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
+					  unsigned long order)
+{
+	struct khoser_mem_chunk *chunk;
+
+	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!chunk)
+		return NULL;
+	chunk->hdr.order = order;
+	if (cur_chunk)
+		KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
+	return chunk;
+}
+
+static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
+{
+	struct khoser_mem_chunk *chunk = first_chunk;
+
+	while (chunk) {
+		struct khoser_mem_chunk *tmp = chunk;
+
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+		kfree(tmp);
+	}
+}
+
+static int kho_mem_serialize(struct kho_serialization *ser)
+{
+	struct khoser_mem_chunk *first_chunk = NULL;
+	struct khoser_mem_chunk *chunk = NULL;
+	struct kho_mem_phys *physxa;
+	unsigned long order;
+
+	xa_for_each(&ser->track.orders, order, physxa) {
+		struct kho_mem_phys_bits *bits;
+		unsigned long phys;
+
+		chunk = new_chunk(chunk, order);
+		if (!chunk)
+			goto err_free;
+
+		if (!first_chunk)
+			first_chunk = chunk;
+
+		xa_for_each(&physxa->phys_bits, phys, bits) {
+			struct khoser_mem_bitmap_ptr *elm;
+
+			if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
+				chunk = new_chunk(chunk, order);
+				if (!chunk)
+					goto err_free;
+			}
+
+			elm = &chunk->bitmaps[chunk->hdr.num_elms];
+			chunk->hdr.num_elms++;
+			elm->phys_start = (phys * PRESERVE_BITS)
+					  << (order + PAGE_SHIFT);
+			KHOSER_STORE_PTR(elm->bitmap, bits);
+		}
+	}
+
+	ser->preserved_mem_map = first_chunk;
+
+	return 0;
+
+err_free:
+	kho_mem_ser_free(first_chunk);
+	return -ENOMEM;
+}
+
+static void deserialize_bitmap(unsigned int order,
+			       struct khoser_mem_bitmap_ptr *elm)
+{
+	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
+	unsigned long bit;
+
+	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
+		int sz = 1 << (order + PAGE_SHIFT);
+		phys_addr_t phys =
+			elm->phys_start + (bit << (order + PAGE_SHIFT));
+		struct page *page = phys_to_page(phys);
+
+		memblock_reserve(phys, sz);
+		memblock_reserved_mark_noinit(phys, sz);
+		page->private = order;
+	}
+}
+
+static void __init kho_mem_deserialize(const void *fdt)
+{
+	struct khoser_mem_chunk *chunk;
+	const phys_addr_t *mem;
+	int len;
+
+	mem = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
+
+	if (!mem || len != sizeof(*mem)) {
+		pr_err("failed to get preserved memory bitmaps\n");
+		return;
+	}
+
+	chunk = *mem ? phys_to_virt(*mem) : NULL;
+	while (chunk) {
+		unsigned int i;
+
+		for (i = 0; i != chunk->hdr.num_elms; i++)
+			deserialize_bitmap(chunk->hdr.order,
+					   &chunk->bitmaps[i]);
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+	}
+}
+
 /*
  * With KHO enabled, memory can become fragmented because KHO regions may
  * be anywhere in physical address space. The scratch regions give us a
@@ -321,6 +679,9 @@ static struct kho_out kho_out = {
 	.lock = __MUTEX_INITIALIZER(kho_out.lock),
 	.ser = {
 		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
+		.track = {
+			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
+		},
 	},
 	.finalized = false,
 };
@@ -363,6 +724,25 @@ static int kho_out_update_debugfs_fdt(void)
 static int kho_abort(void)
 {
 	int err;
+	unsigned long order;
+	struct kho_mem_phys *physxa;
+
+	xa_for_each(&kho_out.ser.track.orders, order, physxa) {
+		struct kho_mem_phys_bits *bits;
+		unsigned long phys;
+
+		xa_for_each(&physxa->phys_bits, phys, bits)
+			kfree(bits);
+
+		xa_destroy(&physxa->phys_bits);
+		kfree(physxa);
+	}
+	xa_destroy(&kho_out.ser.track.orders);
+
+	if (kho_out.ser.preserved_mem_map) {
+		kho_mem_ser_free(kho_out.ser.preserved_mem_map);
+		kho_out.ser.preserved_mem_map = NULL;
+	}
 
 	err = blocking_notifier_call_chain(&kho_out.chain_head, KEXEC_KHO_ABORT,
 					   NULL);
@@ -377,12 +757,25 @@ static int kho_abort(void)
 static int kho_finalize(void)
 {
 	int err = 0;
+	u64 *preserved_mem_map;
 	void *fdt = page_to_virt(kho_out.ser.fdt);
 
 	err |= fdt_create(fdt, PAGE_SIZE);
 	err |= fdt_finish_reservemap(fdt);
 	err |= fdt_begin_node(fdt, "");
 	err |= fdt_property_string(fdt, "compatible", KHO_FDT_COMPATIBLE);
+	/**
+	 * Reserve the preserved-memory-map property in the root FDT, so
+	 * that all property definitions will precede subnodes created by
+	 * KHO callers.
+	 */
+	err |= fdt_property_placeholder(fdt, PROP_PRESERVED_MEMORY_MAP,
+					sizeof(*preserved_mem_map),
+					(void **)&preserved_mem_map);
+	if (err)
+		goto abort;
+
+	err = kho_preserve_folio(&kho_out.ser, page_folio(kho_out.ser.fdt));
 	if (err)
 		goto abort;
 
@@ -392,6 +785,12 @@ static int kho_finalize(void)
 	if (err)
 		goto abort;
 
+	err = kho_mem_serialize(&kho_out.ser);
+	if (err)
+		goto abort;
+
+	*preserved_mem_map = (u64)virt_to_phys(kho_out.ser.preserved_mem_map);
+
 	err |= fdt_end_node(fdt);
 	err |= fdt_finish(fdt);
 
@@ -697,6 +1096,8 @@ void __init kho_memory_init(void)
 	if (kho_in.scratch_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 		kho_release_scratch();
+
+		kho_mem_deserialize(kho_get_fdt());
 	} else {
 		kho_reserve_scratch();
 	}
-- 
2.49.0.604.gff1f9ca942-goog



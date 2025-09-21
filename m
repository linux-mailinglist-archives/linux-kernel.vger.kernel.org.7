Return-Path: <linux-kernel+bounces-826014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEF7B8D553
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C4F7B30E7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2925C6FF;
	Sun, 21 Sep 2025 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSr8p7Wr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148BE2737F6
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758433517; cv=none; b=OJerZNRYhe+z3mniSl7HaPtaRnQuyLES6dszymO7QvgxBR2ZjVGjTrPZ0U/axKi73CnBfLaYrYtJ42hEuqHii4E9lCoGwx9ws/Yer0C9RILgXoSLlWU+kBI2mSAsBbJ6iO2774oOZzr+gJ0/dye9cM8S/MJihvqJcj57QaHYCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758433517; c=relaxed/simple;
	bh=UdtTBv2QwpatAQr/Knzj1gnaKukQZfcywFkm+eSQ/P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JI44/k5rt0AjXX8RbcX+YXdqerJG6HBzIHwfR7wggh7zGmPLjOchCGkcRSn5P2UWO+IIpVSkMizprjow0b2fHyj8ZodYpsTPBbzFgU0WBD/89GtUGIb833dVAnnl/AZD/RhZkeoRjhZQhjO8rEE1a1Ap9ndML/za5BtBohlPlSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSr8p7Wr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE285C4CEF7;
	Sun, 21 Sep 2025 05:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758433516;
	bh=UdtTBv2QwpatAQr/Knzj1gnaKukQZfcywFkm+eSQ/P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSr8p7Wr5TDnHz9WPa0os9hZsLx46C7O86UNp2ohW1ItbgvYLKqqzYmsL+H2t+5h4
	 HWJOia1lWYZHclS0A3V0T47Uy7j0yuShx6D9GmeK0YN37YIPDMq7jV3/DsGmjCPEIl
	 oAItSLYspzhwKytrAL3I+3GvTMTJbOFEIMP/vdO15nf9XIazfrrUIi6Aq+Zz+Kjm7g
	 9O54f7dCFauLEu85+N2FEg0oJ+FXRMPDyT4LgZRdWfrTKWvV/r9a8HH32ezKhV/KbR
	 tTQiIGa1LsyPHrDNr0H74C1IvoLDZgRLpML7jQRQ56S+xclzJhGqyPcdFLpuHMfFts
	 zcV5q4slubTSQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] kho: add support for preserving vmalloc allocations
Date: Sun, 21 Sep 2025 08:44:57 +0300
Message-ID: <20250921054458.4043761-4-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250921054458.4043761-1-rppt@kernel.org>
References: <20250921054458.4043761-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

A vmalloc allocation is preserved using binary structure similar to
global KHO memory tracker. It's a linked list of pages where each page
is an array of physical address of pages in vmalloc area.

kho_preserve_vmalloc() hands out the physical address of the head page
to the caller. This address is used as the argument to
kho_vmalloc_restore() to restore the mapping in the vmalloc address
space and populate it with the preserved pages.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/linux/kexec_handover.h |  28 ++++
 kernel/kexec_handover.c        | 281 +++++++++++++++++++++++++++++++++
 2 files changed, 309 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index cc5c49b0612b..49e36d4ae5dc 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -39,12 +39,23 @@ struct page;
 
 struct kho_serialization;
 
+struct kho_vmalloc_chunk;
+struct kho_vmalloc {
+        DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);
+        unsigned int total_pages;
+        unsigned short flags;
+        unsigned short order;
+};
+
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
 int kho_preserve_pages(struct page *page, unsigned int nr_pages);
+int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
 struct folio *kho_restore_folio(phys_addr_t phys);
+struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
+void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
@@ -71,11 +82,28 @@ static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_preserve_vmalloc(void *ptr,
+				       struct kho_vmalloc *preservation)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	return NULL;
 }
 
+static inline struct page *kho_restore_pages(phys_addr_t phys,
+					     unsigned int nr_pages)
+{
+	return NULL;
+}
+
+static inline void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
+{
+	return NULL;
+}
+
 static inline int kho_add_subtree(struct kho_serialization *ser,
 				  const char *name, void *fdt)
 {
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index fd80be3b12fd..e6380d8dce57 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
+#include <linux/vmalloc.h>
 
 #include <asm/early_ioremap.h>
 
@@ -274,6 +275,37 @@ struct folio *kho_restore_folio(phys_addr_t phys)
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
 
+/**
+ * kho_restore_pages - restore list of contiguous order 0 pages.
+ * @phys: physical address of the first page.
+ * @nr_pages: number of pages.
+ *
+ * Restore a contiguous list of order 0 pages that was preserved with
+ * kho_preserve_pages().
+ *
+ * Return: 0 on success, error code on failure
+ */
+struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
+{
+	const unsigned long start_pfn = PHYS_PFN(phys);
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn = start_pfn;
+
+	while (pfn < end_pfn) {
+		const unsigned int order =
+			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
+		struct page *page = kho_restore_page(PFN_PHYS(pfn));
+
+		if (!page)
+			return NULL;
+		split_page(page, order);
+		pfn += 1 << order;
+	}
+
+	return pfn_to_page(start_pfn);
+}
+EXPORT_SYMBOL_GPL(kho_restore_pages);
+
 /* Serialize and deserialize struct kho_mem_phys across kexec
  *
  * Record all the bitmaps in a linked list of pages for the next kernel to
@@ -763,6 +795,255 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_pages);
 
+struct kho_vmalloc_hdr {
+	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
+};
+
+#define KHO_VMALLOC_SIZE				\
+	((PAGE_SIZE - sizeof(struct kho_vmalloc_hdr)) / \
+	 sizeof(phys_addr_t))
+
+struct kho_vmalloc_chunk {
+	struct kho_vmalloc_hdr hdr;
+	phys_addr_t phys[KHO_VMALLOC_SIZE];
+};
+
+static_assert(sizeof(struct kho_vmalloc_chunk) == PAGE_SIZE);
+
+/* vmalloc flags KHO supports */
+#define KHO_VMALLOC_SUPPORTED_FLAGS	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
+
+/* KHO internal flags for vmalloc preservations */
+#define KHO_VMALLOC_ALLOC	0x0001
+#define KHO_VMALLOC_HUGE_VMAP	0x0002
+
+static unsigned short vmalloc_flags_to_kho(unsigned int vm_flags)
+{
+	unsigned short kho_flags = 0;
+
+	if (vm_flags & VM_ALLOC)
+		kho_flags |= KHO_VMALLOC_ALLOC;
+	if (vm_flags & VM_ALLOW_HUGE_VMAP)
+		kho_flags |= KHO_VMALLOC_HUGE_VMAP;
+
+	return kho_flags;
+}
+
+static unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
+{
+	unsigned int vm_flags = 0;
+
+	if (kho_flags & KHO_VMALLOC_ALLOC)
+		vm_flags |= VM_ALLOC;
+	if (kho_flags & KHO_VMALLOC_HUGE_VMAP)
+		vm_flags |= VM_ALLOW_HUGE_VMAP;
+
+	return vm_flags;
+}
+
+static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
+{
+	struct kho_vmalloc_chunk *chunk;
+	int err;
+
+	chunk = (struct kho_vmalloc_chunk *)get_zeroed_page(GFP_KERNEL);
+	if (!chunk)
+		return NULL;
+
+	err = kho_preserve_pages(virt_to_page(chunk), 1);
+	if (err)
+		goto err_free;
+	if (cur)
+		KHOSER_STORE_PTR(cur->hdr.next, chunk);
+	return chunk;
+
+err_free:
+	free_page((unsigned long)chunk);
+	return NULL;
+}
+
+static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
+{
+	struct kho_mem_track *track = &kho_out.ser.track;
+	unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
+
+	__kho_unpreserve(track, pfn, pfn + 1);
+
+	for (int i = 0; chunk->phys[i]; i++) {
+		pfn = PHYS_PFN(chunk->phys[i]);
+		__kho_unpreserve(track, pfn, pfn + 1);
+	}
+}
+
+static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
+{
+	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(kho_vmalloc->first);
+
+	while (chunk) {
+		struct kho_vmalloc_chunk *tmp = chunk;
+
+		kho_vmalloc_unpreserve_chunk(chunk);
+
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+		kfree(tmp);
+	}
+}
+
+/**
+ * kho_preserve_vmalloc - preserve memory allocated with vmalloc() across kexec
+ * @ptr: pointer to the area in vmalloc address space
+ * @preservation: placeholder for preservation metadata
+ *
+ * Instructs KHO to preserve the area in vmalloc address space at @ptr. The
+ * physical pages mapped at @ptr will be preserved and on successful return
+ * @preservation will hold the physical address of a structure that describes
+ * the preservation.
+ *
+ * NOTE: The memory allocated with vmalloc_node() variants cannot be reliably
+ * restored on the same node
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
+{
+	struct kho_vmalloc_chunk *chunk;
+	struct vm_struct *vm = find_vm_area(ptr);
+	unsigned int order, flags, nr_contig_pages;
+	unsigned int idx = 0;
+	int err;
+
+	if (!vm)
+		return -EINVAL;
+
+	if (vm->flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
+		return -EOPNOTSUPP;
+
+	flags = vmalloc_flags_to_kho(vm->flags);
+	order = get_vm_area_page_order(vm);
+
+	chunk = new_vmalloc_chunk(NULL);
+	if (!chunk)
+		return -ENOMEM;
+	KHOSER_STORE_PTR(preservation->first, chunk);
+
+	nr_contig_pages = (1 << order);
+	for (int i = 0; i < vm->nr_pages; i += nr_contig_pages) {
+		phys_addr_t phys = page_to_phys(vm->pages[i]);
+
+		err = kho_preserve_pages(vm->pages[i], nr_contig_pages);
+		if (err)
+			goto err_free;
+
+		chunk->phys[idx++] = phys;
+		if (idx == ARRAY_SIZE(chunk->phys)) {
+			chunk = new_vmalloc_chunk(chunk);
+			if (!chunk)
+				goto err_free;
+			idx = 0;
+		}
+	}
+
+	preservation->total_pages = vm->nr_pages;
+	preservation->flags = flags;
+	preservation->order = order;
+
+	return 0;
+
+err_free:
+	kho_vmalloc_free_chunks(preservation);
+	return err;
+}
+EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
+
+/**
+ * kho_restore_vmalloc - recreates and populates an area in vmalloc address
+ * space from the preserved memory.
+ * @preservation: preservation metadata.
+ *
+ * Recreates an area in vmalloc address space and populates it with memory that
+ * was preserved using kho_preserve_vmalloc().
+ *
+ * Return: pointer to the area in the vmalloc address space, NULL on failure.
+ */
+void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
+{
+	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
+	unsigned int align, order, shift, vm_flags;
+	unsigned long total_pages, contig_pages;
+	unsigned long addr, size;
+	struct vm_struct *area;
+	struct page **pages;
+	unsigned int idx = 0;
+	int err;
+
+	vm_flags = kho_flags_to_vmalloc(preservation->flags);
+	if (vm_flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
+		return NULL;
+
+	total_pages = preservation->total_pages;
+	pages = kvmalloc_array(total_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return NULL;
+	order = preservation->order;
+	contig_pages = (1 << order);
+	shift = PAGE_SHIFT + order;
+	align = 1 << shift;
+
+	while (chunk) {
+		struct page *page;
+
+		for (int i = 0; chunk->phys[i]; i++) {
+			phys_addr_t phys = chunk->phys[i];
+
+			if (idx + contig_pages > total_pages)
+				goto err_free_pages_array;
+
+			page = kho_restore_pages(phys, contig_pages);
+			if (!page)
+				goto err_free_pages_array;
+
+			for (int j = 0; j < contig_pages; j++)
+				pages[idx++] = page;
+
+			phys += contig_pages * PAGE_SIZE;
+		}
+
+		page = kho_restore_pages(virt_to_phys(chunk), 1);
+		if (!page)
+			goto err_free_pages_array;
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+		__free_page(page);
+	}
+
+	if (idx != total_pages)
+		goto err_free_pages_array;
+
+	area = __get_vm_area_node(total_pages * PAGE_SIZE, align, shift,
+				  vm_flags, VMALLOC_START, VMALLOC_END,
+				  NUMA_NO_NODE, GFP_KERNEL,
+				  __builtin_return_address(0));
+	if (!area)
+		goto err_free_pages_array;
+
+	addr = (unsigned long)area->addr;
+	size = get_vm_area_size(area);
+	err = vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, shift);
+	if (err)
+		goto err_free_vm_area;
+
+	area->nr_pages = total_pages;
+	area->pages = pages;
+
+	return area->addr;
+
+err_free_vm_area:
+	free_vm_area(area);
+err_free_pages_array:
+	kvfree(pages);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
+
 /* Handling for debug/kho/out */
 
 static struct dentry *debugfs_root;
-- 
2.50.1



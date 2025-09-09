Return-Path: <linux-kernel+bounces-808447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC40FB4FFD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7265A5E341E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7DB338F23;
	Tue,  9 Sep 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTeyXhqa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD3352095
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429084; cv=none; b=ePJCvT5aYxk9RatTDAmokredB6UDaKhJlB+7KN215x5cDMEtm17anjw7YnRO/mh4x2KfXVq/gK7KT/HeVfA+dxv8cCk9JA9X3Omwz4rqonY+GILJ6EWUXjqJlTRzAVwEKL7cOs/ubb+K4IW315d1q9/pn3BJxSxOt9TAfVgqtmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429084; c=relaxed/simple;
	bh=R58t8Ck7gaCyPwSxTfKs4rf/zne/bpphAKyTAFsHSEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuPGOp9sh647t5ZCuBLHCVutHiHyPxNgAPU2M7Y4El/HEKmEKT42mulEwQ+9eLUBAEz8hTBqVsWErxnO/7Oq3gQ5FjsX5rrzn7TJWF0Bl93UZrBMXNT0cXrpXIK44rXImDjMKJAyk0ZcqzmVTx/v9MCcB4JeBx0X258R2+/zCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTeyXhqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547C8C4CEFC;
	Tue,  9 Sep 2025 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757429084;
	bh=R58t8Ck7gaCyPwSxTfKs4rf/zne/bpphAKyTAFsHSEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTeyXhqaog50wiTHSSHI/usuM6Lz1jubOhD0MerikJmeK4c/dobUWCoKgpcwy2wFK
	 Lb39k544yz4KwqKbBp7ObMKBgessNF88sW9kNtV3Ueo704WFmO60mTKjH0CrO62j2O
	 HdVlqYH1A3Y42pMDsi8xJAc9FsgOPyNeayWGFy1Wd6wgpbDhyiUjCPscw9EP/5yrSi
	 tVhcWdijota3s2Uc6HG8jMDzcVTXp1inUWpKioo0B3Dj28uWySSwbWDLOIe8VwGI0j
	 8IqLOJNwnFkzlz3AxXHJiIA4jQt3cWdaBsmtSeyUztA1fDXjqYXiEOiWJnuxVX7HlF
	 uHD9wGZNDLPpw==
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
Subject: [RFC PATCH 3/4] kho: add support for preserving vmalloc allocations
Date: Tue,  9 Sep 2025 16:44:23 +0200
Message-ID: <20250909144426.33274-4-pratyush@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

A vmalloc allocation is preserved using binary structure similar to
global KHO memory tracker. It's a linked list of pages where each page
is an array of physical address of pages in vmalloc area.

kho_preserve_vmalloc() hands out the physical address of the head page
to the caller. This address is used as the argument to
kho_vmalloc_restore() to restore the mapping in the vmalloc address
space and populate it with the preserved pages.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
[pratyush@kernel.org: use KHO array instead of linked list of pages to
track physical addresses]
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/linux/kexec_handover.h |  21 +++++
 kernel/kexec_handover.c        | 143 +++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb136..633f94cec1a35 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/kho_array.h>
 
 struct kho_scratch {
 	phys_addr_t addr;
@@ -37,13 +38,23 @@ struct notifier_block;
 	})
 
 struct kho_serialization;
+struct kho_vmalloc;
 
 #ifdef CONFIG_KEXEC_HANDOVER
+struct kho_vmalloc {
+	struct kho_array ka;
+	unsigned int total_pages;
+	unsigned int flags;
+	unsigned short order;
+};
+
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
+void *kho_restore_vmalloc(struct kho_vmalloc *preservation);
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
@@ -70,11 +81,21 @@ static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	return NULL;
 }
 
+static inline void *kho_restore_vmalloc(struct kho_vmalloc *preservation)
+{
+	return NULL;
+}
+
 static inline int kho_add_subtree(struct kho_serialization *ser,
 				  const char *name, void *fdt)
 {
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 26f9f5295f07d..5f89134ceeee0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -19,6 +19,7 @@
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
 #include <linux/kho_array.h>
+#include <linux/vmalloc.h>
 
 #include <asm/early_ioremap.h>
 
@@ -723,6 +724,148 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
+#define KHO_VMALLOC_FLAGS_MASK	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
+
+/**
+ * kho_preserve_vmalloc - preserve memory allocated with vmalloc() across kexec
+ * @ptr: pointer to the area in vmalloc address space
+ * @preservation: pointer to metadata for preserved data.
+ *
+ * Instructs KHO to preserve the area in vmalloc address space at @ptr. The
+ * physical pages mapped at @ptr will be preserved and on successful return
+ * @preservation will hold the structure that describes the metadata for the
+ * preserved pages. @preservation itself is not KHO-preserved. The caller must
+ * do that.
+ *
+ * NOTE: The memory allocated with vmalloc_node() variants cannot be reliably
+ * restored on the same node
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
+{
+	struct kho_mem_track *track = &kho_out.ser.track;
+	struct vm_struct *vm = find_vm_area(ptr);
+	unsigned int order, flags;
+	struct ka_iter iter;
+	int err;
+
+	if (!vm)
+		return -EINVAL;
+
+	if (vm->flags & ~KHO_VMALLOC_FLAGS_MASK)
+		return -EOPNOTSUPP;
+
+	flags = vm->flags & KHO_VMALLOC_FLAGS_MASK;
+	order = get_vm_area_page_order(vm);
+
+	preservation->total_pages = vm->nr_pages;
+	preservation->flags = flags;
+	preservation->order = order;
+
+	ka_iter_init_write(&iter, &preservation->ka);
+
+	for (int i = 0, pos = 0; i < vm->nr_pages; i += (1 << order), pos++) {
+		phys_addr_t phys = page_to_phys(vm->pages[i]);
+
+		err = __kho_preserve_order(track, PHYS_PFN(phys), order);
+		if (err)
+			goto err_free;
+
+		err = ka_iter_setpos(&iter, pos);
+		if (err)
+			goto err_free;
+
+		err = ka_iter_setentry(&iter, ka_mk_value(phys));
+		if (err)
+			goto err_free;
+	}
+
+	err = kho_array_preserve(&preservation->ka);
+	if (err)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	kho_array_destroy(&preservation->ka);
+	return err;
+}
+EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
+
+/**
+ * kho_restore_vmalloc - recreates and populates an area in vmalloc address
+ * space from the preserved memory.
+ * @preservation: the preservation metadata.
+ *
+ * Recreates an area in vmalloc address space and populates it with memory that
+ * was preserved using kho_preserve_vmalloc().
+ *
+ * Return: pointer to the area in the vmalloc address space, NULL on failure.
+ */
+void *kho_restore_vmalloc(struct kho_vmalloc *preservation)
+{
+	unsigned int align, order, shift, flags;
+	unsigned int idx = 0, nr;
+	unsigned long addr, size;
+	struct vm_struct *area;
+	struct page **pages;
+	struct ka_iter iter;
+	void *entry;
+	int err;
+
+	flags = preservation->flags;
+	if (flags & ~KHO_VMALLOC_FLAGS_MASK)
+		return NULL;
+
+	err = ka_iter_init_restore(&iter, &preservation->ka);
+	if (err)
+		return NULL;
+
+	nr = preservation->total_pages;
+	pages = kvmalloc_array(nr, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		goto err_ka_destroy;
+	order = preservation->order;
+	shift = PAGE_SHIFT + order;
+	align = 1 << shift;
+
+	ka_iter_for_each(&iter, entry) {
+		phys_addr_t phys = ka_to_value(entry);
+		struct page *page;
+
+		page = phys_to_page(phys);
+		kho_restore_page(page, 0);
+		pages[idx++] = page;
+		phys += PAGE_SIZE;
+	}
+
+	area = __get_vm_area_node(nr * PAGE_SIZE, align, shift, flags,
+				  VMALLOC_START, VMALLOC_END, NUMA_NO_NODE,
+				  GFP_KERNEL, __builtin_return_address(0));
+	if (!area)
+		goto err_free_pages_array;
+
+	addr = (unsigned long)area->addr;
+	size = get_vm_area_size(area);
+	err = vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, shift);
+	if (err)
+		goto err_free_vm_area;
+
+	kho_array_destroy(&preservation->ka);
+
+	return area->addr;
+
+err_free_vm_area:
+	free_vm_area(area);
+err_free_pages_array:
+	kvfree(pages);
+err_ka_destroy:
+	kho_array_destroy(&preservation->ka);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
+
 /* Handling for debug/kho/out */
 
 static struct dentry *debugfs_root;
-- 
2.47.3



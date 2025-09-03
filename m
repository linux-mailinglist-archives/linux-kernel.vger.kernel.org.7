Return-Path: <linux-kernel+bounces-797774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01040B41536
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F553BDBCC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FD32D836D;
	Wed,  3 Sep 2025 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K12YYfWJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7471A5B9E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881029; cv=none; b=Ftd9b/a0ivw/y/NGMIvlGoAowEE2dkumpm5ww/ji2czijBykB9waH87/Se5w2IbO5r1oWbbEJY7n/Kc4MODoirzsxk3sFGZYA0ihDpzbGmF6woGXvB0DAdBdpd3UTy7Wa1zVuKZgtfAzzcw/o+Qe49LF2kgHVMOH6NxHcanpxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881029; c=relaxed/simple;
	bh=71VhAKjgW0E1aO+puSjE7uBqc/1v+0Vas8jZUkLzLuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJL2guHgH1dMcU05qL1KdKeQAojeFTFEAdR2HgGKV4gQUnnrSAxq/HpvKxrxonMQjBN8OZjE6ZtIuwZcQyUA30Uz/bnAXQe0E78qJ++aqGAE5Dc6SNsCfN2oYIVeJH2T9XiHl3LazsBVOV28M/DAOlFLYK29SgeVTkARo8cxLyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K12YYfWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1168CC4CEF1;
	Wed,  3 Sep 2025 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756881029;
	bh=71VhAKjgW0E1aO+puSjE7uBqc/1v+0Vas8jZUkLzLuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K12YYfWJlksaS+EWHjzH/MCzJZAzvwF42oeLtOIsRgk4D+3RztSI8WhbMfCjqJxmR
	 eplt3hMq0MVq+NIojWepYjQWaRZCMARGfsRSr0854+nCxMqRFbm6F9rDv/cbfQSrqT
	 ys8u6+IBxtZD8sD9pLU/HvRfwzXwsf5Pr036ogTFzG8vV+vA0QwH+iQhpi5oUxZLC5
	 7sGTLV9Bj+sgMH/SG8aLnDrKZXk2f/NvNptrTHkZjXgEawFmwf/cwC/jR7DIft+I9F
	 MBfH3Jt3v/VWqh1CkKzm1zgoqSXV8eDEb4vhx9rwaWivag2I3VH47wVc3MPjRYlRZa
	 7wbfsptG8q5MQ==
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
Subject: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Date: Wed,  3 Sep 2025 09:30:17 +0300
Message-ID: <20250903063018.3346652-2-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903063018.3346652-1-rppt@kernel.org>
References: <20250903063018.3346652-1-rppt@kernel.org>
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
---
 include/linux/kexec_handover.h |  12 +++
 kernel/kexec_handover.c        | 140 +++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb13..b7bf3bf11019 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -42,8 +42,10 @@ struct kho_serialization;
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
+void *kho_restore_vmalloc(phys_addr_t preservation);
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
@@ -70,11 +72,21 @@ static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	return NULL;
 }
 
+static inline void *kho_restore_vmalloc(phys_addr_t preservation)
+{
+	return NULL;
+}
+
 static inline int kho_add_subtree(struct kho_serialization *ser,
 				  const char *name, void *fdt)
 {
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd..a11ae79d6bc9 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
+#include <linux/vmalloc.h>
 
 #include <asm/early_ioremap.h>
 
@@ -733,6 +734,145 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
+struct kho_vmalloc_chunk;
+
+struct kho_vmalloc_hdr {
+	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
+	unsigned int total_pages;	/* only valid in the first chunk */
+	unsigned int num_elms;
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
+static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
+{
+	struct kho_vmalloc_chunk *chunk;
+	int err;
+
+	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!chunk)
+		return NULL;
+
+	err = kho_preserve_phys(virt_to_phys(chunk), PAGE_SIZE);
+	if (err)
+		goto err_free;
+	if (cur)
+		KHOSER_STORE_PTR(cur->hdr.next, chunk);
+	return chunk;
+
+err_free:
+	kfree(chunk);
+	return NULL;
+}
+
+static void kho_vmalloc_free_chunks(struct kho_vmalloc_chunk *first_chunk)
+{
+	struct kho_mem_track *track = &kho_out.ser.track;
+	struct kho_vmalloc_chunk *chunk = first_chunk;
+
+	while (chunk) {
+		unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
+		struct kho_vmalloc_chunk *tmp = chunk;
+
+		__kho_unpreserve(track, pfn, pfn + 1);
+
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+		kfree(tmp);
+	}
+}
+
+int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation)
+{
+	struct kho_vmalloc_chunk *chunk, *first_chunk;
+	struct vm_struct *vm = find_vm_area(ptr);
+	int err;
+
+	if (!vm)
+		return -EINVAL;
+
+	/* we don't support HUGE_VMAP yet */
+	if (get_vm_area_page_order(vm))
+		return -EOPNOTSUPP;
+
+	chunk = new_vmalloc_chunk(NULL);
+	if (!chunk)
+		return -ENOMEM;
+	first_chunk = chunk;
+	first_chunk->hdr.total_pages = vm->nr_pages;
+
+	for (int i = 0; i < vm->nr_pages; i++) {
+		phys_addr_t phys = page_to_phys(vm->pages[i]);
+
+		err = kho_preserve_phys(phys, PAGE_SIZE);
+		if (err)
+			goto err_free;
+
+		chunk->phys[chunk->hdr.num_elms] = phys;
+		chunk->hdr.num_elms++;
+		if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->phys)) {
+			chunk = new_vmalloc_chunk(chunk);
+			if (!chunk)
+				goto err_free;
+		}
+	}
+
+	*preservation = virt_to_phys(first_chunk);
+	return 0;
+
+err_free:
+	kho_vmalloc_free_chunks(first_chunk);
+	return err;
+}
+EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
+
+void *kho_restore_vmalloc(phys_addr_t preservation)
+{
+	struct kho_vmalloc_chunk *chunk = phys_to_virt(preservation);
+	unsigned int idx = 0, nr = 0;
+	struct page **pages;
+	void *ptr;
+
+	nr = chunk->hdr.total_pages;
+	pages = kvmalloc_array(nr, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	while (chunk) {
+		struct page *page;
+
+		for (int i = 0; i < chunk->hdr.num_elms; i++) {
+			page = phys_to_page(chunk->phys[i]);
+			kho_restore_page(page, 0);
+			pages[idx++] = page;
+		}
+
+		page = virt_to_page(chunk);
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+		kho_restore_page(page, 0);
+		__free_page(page);
+	}
+
+	ptr = vmap(pages, nr, VM_MAP_PUT_PAGES, PAGE_KERNEL);
+	if (!ptr)
+		goto err_free_pages_array;
+
+	return ptr;
+
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



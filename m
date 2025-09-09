Return-Path: <linux-kernel+bounces-808445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049CB4FFCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896934E11D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4804834F485;
	Tue,  9 Sep 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFQRGQQo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029A350D6E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429080; cv=none; b=h3foaXqGTYvIsPxJp+ETdLZg/F81WbcrsyoRnr3o4dvD2HKqBdDUWdbpw7Ujsi48QFJFS1Bm8trCapwnBTCJn6JRkW5VDeGcBg9h9nsU+fCgv+Je5Pv4L66Vr1cQ0YGoF8HOsKOlvv4FrzAUZk1QtZawskI1ls1KS/nSA1GLR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429080; c=relaxed/simple;
	bh=itvehA1F3CQanfjmtCZ1QgZPkfSvDpGGOIlOKdv/l3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=al26nLtUfVhjkNHMYC3CNXqZtDpc6HXq5Etgzt3lVV/LFZAK+CcqHSYp1s2tkifoARCL1+l+IaxU+yGPj836JvMlMBzR8udnz7xXruKImS2jxKCfyRbFKAta0hnSiuiB580wduMzT+JetZb7LNMHxf/bWaMzQeq3yr71Ff7LThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFQRGQQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C748C4CEF7;
	Tue,  9 Sep 2025 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757429079;
	bh=itvehA1F3CQanfjmtCZ1QgZPkfSvDpGGOIlOKdv/l3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFQRGQQoQt2px906Eer8M14KNDMAupGvwN7g+S0njThSf2VPXwqXizWDww+56Jzfu
	 HULAZD3c+EWcTfPshZNkRv/lpFDmyvNhHbQN0L2miMJg+DfkkNdSyMFrc2YPjPao0p
	 BM7APgrH8qTlnQGcFdKXxyoLD6srs6RdQJwuQrHhPn5xg+uuF7IX87wkfDhWPpwmcq
	 IeqPmbkOS+7Aq/BUDUXgieLgGrKR7I9LTYB6rnAc66SwGHBsJCHKxT64GA6hOvFdI/
	 0JmwHgbjAHLOhW8j6OGXjZA63EzOepv+Uu1OsdtBnqwHag3MhrtRIMToVdEYrTkEEM
	 KFftNK6qDQNog==
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
Subject: [RFC PATCH 1/4] kho: introduce the KHO array
Date: Tue,  9 Sep 2025 16:44:21 +0200
Message-ID: <20250909144426.33274-2-pratyush@kernel.org>
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

The KHO Array is a data structure that behaves like a sparse array of
pointers. It is designed to be preserved and restored over Kexec
Handover (KHO), and targets only 64-bit platforms. It can store 8-byte
aligned pointers. It can also store integers between 0 and LONG_MAX. It
supports sparse indices, though it performs best with densely clustered
indices.

The goal with KHO array is to provide a fundamental data type that can
then be used to build serialization logic for higher layers. Moving the
complexity of tracking these scattered list of pages to the KHO array
layer makes higher layers simpler.

The data format consists of a descriptor of the array which contains a
magic number, format version, and pointer to the first page. Each page
contains the starting position of the entries in the page and a pointer
to the next page, forming a linked list. This linked list allows for the
array to be built with non-contiguous pages. Visually, the data format
looks like below:

  kho_array
 +----------+
 |  Magic   |
 +----------+                   kho_array_page
 | Version  |         +----------+----------+-----------
 +----------+    +--->|   Next   | Startpos | Entries...
 | Reserved |    |    +----------+----------+-----------
 +----------+    |          |               kho_array_page
 |  First   |----+          |    +----------+----------+-----------
 +----------+               +--->|   Next   | Startpos | Entries...
                                 +----------+----------+-----------
                                       |
                                       |
                                       +--->...

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 MAINTAINERS               |   2 +
 include/linux/kho_array.h | 300 ++++++++++++++++++++++++++++++++++++++
 kernel/Makefile           |   1 +
 kernel/kho_array.c        | 209 ++++++++++++++++++++++++++
 4 files changed, 512 insertions(+)
 create mode 100644 include/linux/kho_array.h
 create mode 100644 kernel/kho_array.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef8..e66bc05bce0e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13550,7 +13550,9 @@ S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
+F:	include/linux/kho_array.h
 F:	kernel/kexec_handover.c
+F:	kernel/kho_array.c
 F:	tools/testing/selftests/kho/
 
 KEYS-ENCRYPTED
diff --git a/include/linux/kho_array.h b/include/linux/kho_array.h
new file mode 100644
index 0000000000000..39ab5532ee765
--- /dev/null
+++ b/include/linux/kho_array.h
@@ -0,0 +1,300 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
+ * Pratyush Yadav <pratyush@kernel.org>
+ */
+
+/**
+ * DOC: KHO Array
+ *
+ * The KHO Array is a data structure that behaves like a sparse array of
+ * pointers. It is designed to be preserved and restored over Kexec Handover
+ * (KHO), and targets only 64-bit platforms. It can store 8-byte aligned
+ * pointers. It can also store integers between 0 and LONG_MAX. It supports
+ * sparse indices, though it performs best with densely clustered indices. The
+ * data structure does not provide any locking. Callers must ensure they have
+ * exclusive access.
+ *
+ * To keep the data format simple, the data structure is designed to only be
+ * accessed linearly. When reading or writing the data structure, the values
+ * should be accessed from the lowest index to the highest.
+ *
+ * The data format consists of a descriptor of the array which contains a magic
+ * number, format version, and pointer to the first page. Each page contains the
+ * starting position of the entries in the page and a pointer to the next page,
+ * forming a linked list. This linked list allows for the array to be built with
+ * non-contiguous pages.
+ *
+ * The starting position of each page an offset that is applied to calculate the
+ * index of each entry in the array. For example, of the starting position is
+ * 1000, entry 0 has index 1000, entry 1 has index 1001, and so on. This
+ * facilitates memory-efficient handling of holes in the array.
+ *
+ * The diagram below shows the data format visually:
+ *
+ *   kho_array
+ *  +----------+
+ *  |  Magic   |
+ *  +----------+                   kho_array_page
+ *  | Version  |         +----------+----------+-----------
+ *  +----------+    +--->|   Next   | Startpos | Entries...
+ *  | Reserved |    |    +----------+----------+-----------
+ *  +----------+    |          |               kho_array_page
+ *  |  First   |----+          |    +----------+----------+-----------
+ *  +----------+               +--->|   Next   | Startpos | Entries...
+ *                                  +----------+----------+-----------
+ *                                        |
+ *                                        |
+ *                                        +--->...
+ */
+
+#ifndef LINUX_KHO_ARRAY_H
+#define LINUX_KHO_ARRAY_H
+
+#include <linux/bug.h>
+
+#define KHO_ARRAY_MAGIC		0x4b415252 /* ASCII for 'KARR' */
+#define KHO_ARRAY_VERSION	0
+
+/**
+ * struct kho_array - Descriptor for a KHO array.
+ * @magic: Magic number to ensure valid descriptor.
+ * @version: Data format version.
+ * @__reserved: Reserved bytes. Must be set to 0.
+ * @first: Physical address of the first page in the list of pages. If 0, the
+ *         list is empty.
+ */
+struct kho_array {
+	u32		magic;
+	u16		version;
+	u16		__reserved;
+	__aligned_u64	first;
+} __packed;
+
+/**
+ * struct kho_array_page - A page in the KHO array.
+ * @next: Physical address of the next page in the list. If 0, there is no next
+ *        page.
+ * @startpos: Position at which entries in this page start.
+ * @entries: Entries in the array.
+ */
+struct kho_array_page {
+	__aligned_u64	next;
+	__aligned_u64	startpos;
+	__aligned_u64	entries[];
+} __packed;
+
+#define KA_PAGE_NR_ENTRIES ((PAGE_SIZE - sizeof(struct kho_array_page)) / sizeof(u64))
+
+#define KA_ITER_PAGEPOS(iter) ((iter)->pos - (iter)->cur->startpos)
+#define KA_PAGE(phys) ((phys) ? (struct kho_array_page *)__va((phys)) : NULL)
+
+/**
+ * kho_array_valid() - Validate KHO array descriptor.
+ * @ka: KHO array.
+ *
+ * Return: %true if valid, %false otherwise.
+ */
+bool kho_array_valid(struct kho_array *ka);
+
+/**
+ * kho_array_init() - Initialize an empty KHO array.
+ * @ka: KHO array.
+ *
+ * Initilizes @ka to an empty KHO array full of NULL entries.
+ */
+void kho_array_init(struct kho_array *ka);
+
+/**
+ * kho_array_destroy() - Free the KHO array.
+ * @ka: KHO array.
+ *
+ * After calling this function, @ka is destroyed and all its pages have been
+ * freed. It must be initialized again before reuse.
+ */
+void kho_array_destroy(struct kho_array *ka);
+
+/**
+ * kho_array_preserve() - KHO-preserve all pages of the array
+ * @ka: KHO array.
+ *
+ * Mark all pages of the array to be preserved across KHO.
+ *
+ * Note: the memory for the struct @ka itself is not marked as preserved. The
+ * caller must take care of doing that, likely embedding it in a larger
+ * serialized data structure.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int kho_array_preserve(struct kho_array *ka);
+
+/**
+ * kho_array_restore() - KHO-restore all pages of the array
+ * @ka: KHO array.
+ *
+ * Validate the magic and version of @ka, and if they match, restore all pages
+ * ka from KHO to set the array up for being accessed.
+ *
+ * Note: the memory for the struct @ka itself is not KHO-restored. The caller
+ * must take care of doing that, likely embedding it in a larger serialized data
+ * structure.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int kho_array_restore(struct kho_array *ka);
+
+/**
+ * ka_is_value() - Determine if an entry is a value.
+ * @entry: KHO array entry.
+ *
+ * Return: %true if the entry is a value, %false if it is a pointer.
+ */
+static inline bool ka_is_value(const void *entry)
+{
+	return (unsigned long)entry & 1;
+}
+
+/**
+ * ka_to_value() - Get value stored in an KHO array entry.
+ * @entry: KHO array entry.
+ *
+ * Return: The value stored in @entry.
+ */
+static inline unsigned long ka_to_value(const void *entry)
+{
+	return (unsigned long)entry >> 1;
+}
+
+/**
+ * ka_mk_value() - Create an KHO array entry from an integer.
+ * @v: Value to store in KHO array.
+ *
+ * Return: An entry suitable for storing in a KHO array.
+ */
+static inline void *ka_mk_value(unsigned long v)
+{
+	WARN_ON((long)v < 0);
+	return (void *)((v << 1) | 1);
+}
+
+enum ka_iter_mode {
+	KA_ITER_READ,
+	KA_ITER_WRITE,
+};
+
+struct ka_iter {
+	struct kho_array	*ka;
+	struct kho_array_page	*cur;
+	unsigned long		pos;
+	enum ka_iter_mode	mode;
+};
+
+/**
+ * ka_iter_init_read() - Initialize iterator for reading.
+ * @iter: KHO array iterator.
+ * @ka: KHO array.
+ *
+ * Initialize @iter in read mode for reading @ka. After the function returns,
+ * @iter points to the first non-empty entry in the array, if any. @ka must be a
+ * valid KHO array. No validation on @ka is performed.
+ */
+void ka_iter_init_read(struct ka_iter *iter, struct kho_array *ka);
+
+/**
+ * ka_iter_init_write() - Initialize iterator for writing.
+ * @iter: KHO array iterator.
+ * @ka: KHO array.
+ *
+ * Initialize @ka to an empty array and then initialize @iter in write mode
+ * for building @ka. All data in @ka is over-written, so it must be an
+ * un-initialized array. After the function returns, @iter points to the first
+ * entry in the array.
+ */
+void ka_iter_init_write(struct ka_iter *iter, struct kho_array *ka);
+
+/**
+ * ka_iter_init_restore() - Restore KHO array and initialize iterator for reading.
+ * @iter: KHO array iterator.
+ * @ka: KHO array.
+ *
+ * KHO-restore @ka, performing version and format validation, and initialize
+ * @iter in read mode for reading the array. After the function returns, @iter
+ * points to the first non-empty entry in the array, if any
+ *
+ * Returns: 0 on success, -errno on failure.
+ */
+int ka_iter_init_restore(struct ka_iter *iter, struct kho_array *ka);
+
+/**
+ * ka_iter_setentry() - Set entry at current iterator position.
+ * @iter: KHO array iterator in write mode.
+ * @value: Value or pointer to store.
+ *
+ * Store @value at the current position of @iter. @iter must be in write mode.
+ * The iterator position is not advanced.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int ka_iter_setentry(struct ka_iter *iter, const void *value);
+
+/**
+ * ka_iter_nextentry() - Advance iterator to next non-empty entry.
+ * @iter: KHO array iterator.
+ *
+ * Advance @iter to the next non-empty entry in the array, skipping over
+ * empty entries and holes between pages.
+ *
+ * Return: The entry, or %NULL if end of array reached.
+ */
+void *ka_iter_nextentry(struct ka_iter *iter);
+
+/**
+ * ka_iter_setpos() - Set iterator position.
+ * @iter: KHO array iterator.
+ * @pos: New position (must be >= current position).
+ *
+ * Set the iterator position to @pos. The position can only be moved forward.
+ * The iterator will point to the appropriate page for the given position.
+ *
+ * Return: 0 on success, -EINVAL if @pos is less than current position.
+ */
+int ka_iter_setpos(struct ka_iter *iter, unsigned long pos);
+
+/**
+ * ka_iter_end() - Check if iterator has reached end of array.
+ * @iter: KHO array iterator.
+ *
+ * Return: %true if iterator is at end of array, %false otherwise.
+ */
+bool ka_iter_end(struct ka_iter *iter);
+
+/**
+ * ka_iter_getpos() - Get current iterator position.
+ * @iter: KHO array iterator.
+ *
+ * Return: Current position in the array.
+ */
+static inline unsigned long ka_iter_getpos(struct ka_iter *iter)
+{
+	return iter->pos;
+}
+
+/**
+ * ka_iter_getentry() - Get entry at current iterator position.
+ * @iter: KHO array iterator.
+ *
+ * Return: Pointer to entry at current position, or %NULL if none.
+ */
+void *ka_iter_getentry(struct ka_iter *iter);
+
+/**
+ * ka_iter_for_each - Iterate over all non-empty entries in array.
+ * @iter: KHO array iterator.
+ * @entry: Variable to store current entry.
+ *
+ * Loop over all non-empty entries in the array starting from current position.
+ */
+#define ka_iter_for_each(iter, entry)					\
+	for ((entry) = ka_iter_getentry(iter); (entry); (entry) = ka_iter_nextentry((iter)))
+
+#endif /* LINUX_KHO_ARRAY_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index c60623448235f..8baef3cb3979f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
 obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER) += kho_array.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kho_array.c b/kernel/kho_array.c
new file mode 100644
index 0000000000000..bdac471c45c58
--- /dev/null
+++ b/kernel/kho_array.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
+ * Pratyush Yadav <pratyush@kernel.org>
+ */
+
+#include <linux/kexec_handover.h>
+#include <linux/kho_array.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/bug.h>
+#include <linux/types.h>
+
+#define KA_PAGE_NR_ENTRIES ((PAGE_SIZE - sizeof(struct kho_array_page)) / sizeof(u64))
+
+#define KA_ITER_PAGEPOS(iter) ((iter)->pos - (iter)->cur->startpos)
+#define KA_PAGE(phys) ((phys) ? (struct kho_array_page *)__va((phys)) : NULL)
+
+bool ka_iter_end(struct ka_iter *iter)
+{
+	return !iter->cur || (KA_ITER_PAGEPOS(iter) >= KA_PAGE_NR_ENTRIES && !iter->cur->next);
+}
+
+void *ka_iter_getentry(struct ka_iter *iter)
+{
+	if (!iter->cur || KA_ITER_PAGEPOS(iter) >= KA_PAGE_NR_ENTRIES)
+		return NULL;
+
+	return (void *)iter->cur->entries[KA_ITER_PAGEPOS(iter)];
+}
+
+static int ka_iter_extend(struct ka_iter *iter)
+{
+	struct kho_array_page *kap;
+	struct folio *folio;
+	u64 phys;
+
+	if (!ka_iter_end(iter))
+		return 0;
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!folio)
+		return -ENOMEM;
+
+	kap = folio_address(folio);
+	kap->startpos = rounddown(iter->pos, KA_PAGE_NR_ENTRIES);
+
+	phys = (u64)PFN_PHYS(folio_pfn(folio));
+	/*
+	 * If the iterator already has a page, insert the page after it.
+	 * Otherwise, set the page as the first in the array.
+	 */
+	if (iter->cur)
+		iter->cur->next = phys;
+	else
+		iter->ka->first = phys;
+
+	iter->cur = kap;
+
+	return 0;
+}
+
+void ka_iter_init_read(struct ka_iter *iter, struct kho_array *ka)
+{
+	memset(iter, 0, sizeof(*iter));
+	iter->ka = ka;
+	iter->mode = KA_ITER_READ;
+	iter->cur = KA_PAGE(ka->first);
+
+	/* Make the iterator point to first valid entry. */
+	if (!ka_iter_getentry(iter))
+		ka_iter_nextentry(iter);
+}
+
+void ka_iter_init_write(struct ka_iter *iter, struct kho_array *ka)
+{
+	kho_array_init(ka);
+	memset(iter, 0, sizeof(*iter));
+	iter->ka = ka;
+	iter->mode = KA_ITER_WRITE;
+}
+
+int ka_iter_init_restore(struct ka_iter *iter, struct kho_array *ka)
+{
+	int err;
+
+	err = kho_array_restore(ka);
+	if (err)
+		return err;
+
+	ka_iter_init_read(iter, ka);
+	return 0;
+}
+
+int ka_iter_setpos(struct ka_iter *iter, unsigned long pos)
+{
+	if (pos < iter->pos)
+		return -EINVAL;
+
+	iter->pos = pos;
+
+	/*
+	 * The iterator must point to the highest page with startpos <= pos.
+	 * Advance it as far as possible.
+	 */
+	while (iter->cur && KA_PAGE(iter->cur->next) &&
+	       KA_PAGE(iter->cur->next)->startpos <= pos)
+		iter->cur = KA_PAGE(iter->cur->next);
+
+	return 0;
+}
+
+int ka_iter_setentry(struct ka_iter *iter, const void *value)
+{
+	int err = 0;
+
+	if (iter->mode != KA_ITER_WRITE)
+		return -EPERM;
+
+	err = ka_iter_extend(iter);
+	if (err)
+		return err;
+
+	iter->cur->entries[KA_ITER_PAGEPOS(iter)] = (u64)value;
+	return 0;
+}
+
+void *ka_iter_nextentry(struct ka_iter *iter)
+{
+	ka_iter_setpos(iter, iter->pos + 1);
+	while (!ka_iter_end(iter) && !ka_iter_getentry(iter)) {
+		/*
+		 * If we are in the hole between two pages, jump to the next
+		 * page.
+		 */
+		if (KA_ITER_PAGEPOS(iter) >= KA_PAGE_NR_ENTRIES)
+			/*
+			 * The check for ka_iter_end() above makes sure next
+			 * page exists.
+			 *
+			 * TODO: This is a bit nasty and might attract review
+			 * comments. Can I make it cleaner?
+			 */
+			ka_iter_setpos(iter, KA_PAGE(iter->cur->next)->startpos);
+		else
+			ka_iter_setpos(iter, iter->pos + 1);
+	}
+
+	return ka_iter_getentry(iter);
+}
+
+bool kho_array_valid(struct kho_array *ka)
+{
+	return ka->magic == KHO_ARRAY_MAGIC && ka->version == KHO_ARRAY_VERSION;
+}
+
+void kho_array_init(struct kho_array *ka)
+{
+	memset(ka, 0, sizeof(*ka));
+	ka->magic = KHO_ARRAY_MAGIC;
+	ka->version = KHO_ARRAY_VERSION;
+}
+
+void kho_array_destroy(struct kho_array *ka)
+{
+	u64 cur = ka->first, next;
+
+	while (cur) {
+		next = KA_PAGE(cur)->next;
+		folio_put(pfn_folio(PHYS_PFN(cur)));
+		cur = next;
+	}
+
+	ka->magic = 0;
+}
+
+int kho_array_preserve(struct kho_array *ka)
+{
+	u64 cur = ka->first;
+	int err;
+
+	while (cur) {
+		err = kho_preserve_folio(pfn_folio(PHYS_PFN(cur)));
+		if (err)
+			return err;
+
+		cur = KA_PAGE(cur)->next;
+	}
+
+	return 0;
+}
+
+int kho_array_restore(struct kho_array *ka)
+{
+	u64 cur = ka->first;
+	struct folio *folio;
+
+	if (!kho_array_valid(ka))
+		return -EOPNOTSUPP;
+
+	while (cur) {
+		folio = kho_restore_folio(cur);
+		if (!folio)
+			return -ENOMEM;
+		cur = KA_PAGE(cur)->next;
+	}
+
+	return 0;
+}
-- 
2.47.3



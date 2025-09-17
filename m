Return-Path: <linux-kernel+bounces-819900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96759B7D3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908DD1B26AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE7A29A9FA;
	Wed, 17 Sep 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnj2ubLP"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0B165F16
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077438; cv=none; b=EmJgcSavK5YDXb2AWReDl4oWUbqejN0v7D/Cf+SBdwc7pchvG81VEuYIVagWmgFyG+E/+Tj8ml5nXYWvoZx9oEJSlNwEiG/elbpedWkjjY8b/w0W7zRd9jRRIwfoPya7RHS6TLyrX/4TJV2H5D+nc7A61H3UZhmEKObh0ErysfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077438; c=relaxed/simple;
	bh=la2sRRtzR5JDMIAAh/doGQw8WebURrqNFVMYWyGCFPA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=b4JPF/wHmhrGxegBxiKOnoAOplvbRzKAXnspnMhsZvBqamG1McZPw2CSxZWJ2QHwfiBdxlerF2fGLEmeMNgsRn6rIpBBAgxq8hACfuGZbGNjPe6gDMSLKMg5BU1IIzJXQgOFZrWZqW+TWc0v/HBMpjP2Gf4BlGUHLyBGuGtApxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fnj2ubLP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2659a7488a2so57838515ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758077436; x=1758682236; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wAnisGajbcYa8IELNM7cwb6nACj53AhyM2UU/05uLE=;
        b=fnj2ubLPXr8FWqlJjE4QOH8/Q2Sjr10a/UIMj3nIeIZY8/vDteuP1lPf75/54eTa/D
         aPGuZSEmPAgghccRPoHptOwuoH6pAbQdq91aXvmsLvcOkN98adfUkPAs4TB5DqNbTwaX
         FXGOYyrA4lbaNeFmR2LiTT72+AHUDPQ4EULQNMlpdCxbL2hfMfXPBbnRUgr6OxEp7/p8
         g7ll15mZSd/e2cM9cwS3rt/jqxP4h2rEPkZHGVe6trMCckyLYqf4Pa0RVMx69OV97fLv
         7Lt6l++pyswnD9Y4V7r7ISonkcoo6eUfEWzWfFi+NsGL2uuYeYMuGIPkgbuUg2NygfnQ
         T3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077436; x=1758682236;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wAnisGajbcYa8IELNM7cwb6nACj53AhyM2UU/05uLE=;
        b=UCt4GoOdDg2/QDJsS28sSKQBFSncGOscHBGaWaMpmb9rqRDPERR8MRE9PG5a+2k3BD
         NOIGxY/MDxAoVhnjzQdtiMiXyDMNpobW0t1dSAQR72ApJH/Q566CkkKo/ZS8aYeVKD4u
         aWpOIovsSTSi3yMHsXUYAI1DoM6UmSdWNZjK79rZPg/VE5KttHJt1AHWy8jrOJIKeiqp
         eUpM1V7If4CwF9a1eAURRyPoLF8YixBVaS4udab1gUpgbEyYd9GAt1P//ugH2/wGw0v7
         RCOOiVKRw4+QYDcM6/QvJex4XZFZzPw68WU8x9W/PjRGVHwna2xGABWRWFFIzT+mcBn9
         x7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwLuzsrhoCgFSFXHCiUL/+36+OZmXEzUtMCN56gZaLBZXST849qEuNIAe9B15ANnG3bWO7PM203yxqbL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+zasWP6HegKyAqUOmkVFOhtwHcpZWOSRlBlOOZmZMHG60QQb
	kE1WvRgvHoGSGQzfr4A3J0eN+3KjcH4YXR8PFM6lJbaEK6IRHJRMhVGHSLEfbucYGYl5dYvhr2R
	kHhGGOxcQ6xQc5g==
X-Google-Smtp-Source: AGHT+IEpg0QQAP6xJjBpVWMcX87q/1xHOaFPzqUck3HzcEwQKjUg13HBNsgVlIXij2DbclZb+DlqACShaMT9mQ==
X-Received: from pluq14.prod.google.com ([2002:a17:903:4b4e:b0:267:b6b7:9ac3])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b24:b0:24d:4d8b:a17 with SMTP id d9443c01a7336-26813cf391amr6167545ad.56.1758077435641;
 Tue, 16 Sep 2025 19:50:35 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:50:16 -0700
In-Reply-To: <20250917025019.1585041-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917025019.1585041-2-jasonmiu@google.com>
Subject: [RFC v1 1/4] kho: Introduce KHO page table data structures
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

Introduce a page-table-like data structure for tracking preserved
memory pages, which will replace the current xarray-based
implementation.

The primary motivation for this change is to eliminate the need for
serialization. By marking preserved pages directly in these new tables
and passing them to the next kernel, the entire serialization process
can be removed. This ultimately allows for the removal of the KHO
finalize and abort states, simplifying the overall design.

The new KHO page table is a hierarchical structure that maps physical
addresses to preservation metadata. It begins with a root
`kho_order_table` that contains an entry for each page order. Each
entry points to a separate, multi-level tree of `kho_page_table`s that
splits a physical address into indices. The traversal terminates at a
`kho_bitmap_table`, where each bit represents a single preserved page.

This commit adds the core data structures for this hierarchy:
  - kho_order_table: The root table, indexed by page order.
  - kho_page_table: Intermediate-level tables.
  - kho_bitmap_table: The lowest-level table where individual pages
are marked.

The new functions are not yet integrated with the public
`kho_preserve_*` APIs and are marked `__maybe_unused`. The full
integration and the removal of the old xarray code will follow in a
subsequent commit.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 kernel/kexec_handover.c | 344 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 344 insertions(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd..0daed51c8fb7 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -46,6 +46,350 @@ static int __init kho_parse_enable(char *p)
 }
 early_param("kho", kho_parse_enable);
 
+/*
+ * KHO page tables provide a page-table-like data structure for tracking
+ * preserved memory pages. It is a hierarchical structure that starts with a
+ * `struct kho_order_table`. Each entry in this table points to the root of a
+ * `struct kho_page_table` tree, which tracks the preserved memory pages for a
+ * specific page order.
+ *
+ * Each entry in a `struct kho_page_table` points to the next level page table,
+ * until level 2, which points to a `struct kho_bitmap_table`. The lowest level
+ * (level 1) is a bitmap table where each bit represents a preserved page.
+ *
+ * The table hierarchy is shown as below.
+ *
+ * kho_order_table
+ * +-------------------------------+--------------------+
+ * | 0 order| 1 order| 2 order ... | HUGETLB_PAGE_ORDER |
+ * ++------------------------------+--------------------+
+ *  |
+ *  |
+ *  v
+ * ++------+
+ * |  Lv6  | kho_page_table
+ * ++------+
+ *  |
+ *  |
+ *  |   +-------+
+ *  +-> |  Lv5  | kho_page_table
+ *      ++------+
+ *       |
+ *       |
+ *       |   +-------+
+ *       +-> |  Lv4  | kho_page_table
+ *           ++------+
+ *            |
+ *            |
+ *            |   +-------+
+ *            +-> |  Lv3  | kho_page_table
+ *                ++------+
+ *                 |
+ *                 |
+ *                 |  +-------+
+ *                 +> |  Lv2  | kho_page_table
+ *                    ++------+
+ *                     |
+ *                     |
+ *                     |   +-------+
+ *                     +-> |  Lv1  | kho_bitmap_table
+ *                         +-------+
+ *
+ * The depth of the KHO page tables depends on the system's page size and the
+ * page order. Both larger page sizes and higher page orders result in
+ * shallower KHO page tables. For example, on a system with a 4KB native
+ * page size, 0-order tables have a depth of 6 levels.
+ *
+ * The following diagram illustrates how a physical address is split into
+ * indices for the different KHO page table levels and the final bitmap.
+ *
+ *      63      62:54    53:45    44:36    35:27        26:0
+ * +--------+--------+--------+--------+--------+-----------------+
+ * |  Lv 6  |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1 (bitmap)  |
+ * +--------+--------+--------+--------+--------+-----------------+
+ *
+ * For higher order pages, the bit fields for each level shift to the left by
+ * the page order.
+ *
+ * Each KHO page table and bitmap table is PAGE_SIZE in size. For 0-order
+ * pages, the bitmap table contains (PAGE_SIZE * 8) bits, covering a
+ * (PAGE_SIZE * 8 * PAGE_SIZE) memory range. For example, on a system with a
+ * 4KB native page size, the bitmap table contains 32768 bits and covers a
+ * 128MB memory range.
+ *
+ * Each KHO page table contains (PAGE_SIZE / 8) entries, where each entry is a
+ * descriptor (a physical address) pointing to the next level table.
+ * For example, with a 4KB page size, each page table holds 512 entries.
+ * The level 2 KHO page table is an exception, where each entry points to a
+ * KHO bitmap table instead.
+ *
+ * An entry of a KHO page table of a 4KB page system is shown as below as an
+ * example.
+ *
+ *         63:12                       11:0
+ * +------------------------------+--------------+
+ * | descriptor to next table     |    zeros     |
+ * +------------------------------+--------------+
+ */
+
+#define BITMAP_TABLE_SHIFT(_order) (PAGE_SHIFT + PAGE_SHIFT + 3 + (_order))
+#define BITMAP_TABLE_MASK(_order) ((1ULL << BITMAP_TABLE_SHIFT(_order)) - 1)
+#define PRESERVED_PAGE_OFFSET_SHIFT(_order) (PAGE_SHIFT + (_order))
+#define PAGE_TABLE_SHIFT_PER_LEVEL (ilog2(PAGE_SIZE / sizeof(unsigned long)))
+#define PAGE_TABLE_LEVEL_MASK ((1ULL << PAGE_TABLE_SHIFT_PER_LEVEL) - 1)
+#define PTR_PER_LEVEL (PAGE_SIZE / sizeof(unsigned long))
+
+typedef int (*kho_walk_callback_t)(phys_addr_t pa, int order);
+
+struct kho_bitmap_table {
+	unsigned long bitmaps[PAGE_SIZE / sizeof(unsigned long)];
+};
+
+struct kho_page_table {
+	unsigned long tables[PTR_PER_LEVEL];
+};
+
+struct kho_order_table {
+	unsigned long orders[HUGETLB_PAGE_ORDER + 1];
+};
+
+/*
+ * `kho_order_table` points to a page that serves as the root of the KHO page
+ * table hierarchy. This page is allocated during KHO module initialization.
+ * Its physical address is written to the FDT and passed to the next kernel
+ * during kexec.
+ */
+static struct kho_order_table *kho_order_table;
+
+static unsigned long kho_page_table_level_shift(int level, int order)
+{
+	/*
+	 * Calculate the cumulative bit shift required to extract the page table
+	 * index for a given physical address at a specific `level` and `order`.
+	 *
+	 * - Level 1 is the bitmap table, which has its own indexing logic, so
+	 *   the shift is 0.
+	 * - Level 2 and above: The base shift is `BITMAP_TABLE_SHIFT(order)`,
+	 *   which corresponds to the entire address space covered by a single
+	 *   level 1 bitmap table.
+	 * - Each subsequent level adds `PAGE_TABLE_SHIFT_PER_LEVEL` to the
+	 *   total shift amount.
+	 */
+	return level <= 1 ? 0 :
+		BITMAP_TABLE_SHIFT(order) + PAGE_TABLE_SHIFT_PER_LEVEL * (level - 2);
+}
+
+static int kho_get_bitmap_table_index(unsigned long pa, int order)
+{
+	/* 4KB (12bits of addr) + 8B per entries (6bits of addr) + order bits */
+	unsigned long idx = pa >> (PAGE_SHIFT + 6 + order);
+
+	return idx;
+}
+
+static int kho_get_page_table_index(unsigned long pa, int order, int level)
+{
+	unsigned long high_addr;
+	unsigned long page_table_offset;
+	unsigned long shift;
+
+	if (level == 1)
+		return kho_get_bitmap_table_index(pa, order);
+
+	shift = kho_page_table_level_shift(level, order);
+	high_addr = pa >> shift;
+
+	page_table_offset = high_addr & PAGE_TABLE_LEVEL_MASK;
+	return page_table_offset;
+}
+
+static int kho_table_level(int order)
+{
+	unsigned long bits_to_resolve;
+	int page_table_num;
+
+	/* We just need 1 bitmap table to cover all addresses */
+	if (BITMAP_TABLE_SHIFT(order) >= 64)
+		return 1;
+
+	bits_to_resolve = 64 - BITMAP_TABLE_SHIFT(order);
+
+	/*
+	 * The level we need is the bits to resolve over the bits a page tabel
+	 * can resolve. Get the ceiling as ceil(a/b) = (a + b - 1) / b.
+	 * Total level is the all table levels plus the buttom
+	 * bitmap level.
+	 */
+	page_table_num = (bits_to_resolve + PAGE_TABLE_SHIFT_PER_LEVEL - 1)
+		/ PAGE_TABLE_SHIFT_PER_LEVEL;
+	return page_table_num + 1;
+}
+
+static struct kho_page_table *kho_alloc_page_table(void)
+{
+	return (struct kho_page_table *)get_zeroed_page(GFP_KERNEL);
+}
+
+static void kho_set_preserved_page_bit(struct kho_bitmap_table *bitmap_table,
+				       unsigned long pa, int order)
+{
+	int bitmap_table_index = kho_get_bitmap_table_index(pa, order);
+	int offset;
+
+	/* Get the bit offset in a 64bits bitmap entry */
+	offset = (pa >> PRESERVED_PAGE_OFFSET_SHIFT(order)) & 0x3f;
+
+	set_bit(offset,
+		(unsigned long *)&bitmap_table->bitmaps[bitmap_table_index]);
+}
+
+static unsigned long kho_pgt_desc(struct kho_page_table *va)
+{
+	return (unsigned long)virt_to_phys(va);
+}
+
+static struct kho_page_table *kho_page_table(unsigned long desc)
+{
+	return (struct kho_page_table *)phys_to_virt(desc);
+}
+
+static int __kho_preserve_page_table(unsigned long pa, int order)
+{
+	int num_table_level = kho_table_level(order);
+	struct kho_page_table *cur;
+	struct kho_page_table *next;
+	struct kho_bitmap_table *bitmap_table;
+	int i, page_table_index;
+	unsigned long page_table_desc;
+
+	if (!kho_order_table->orders[order]) {
+		cur = kho_alloc_page_table();
+		if (!cur)
+			return -ENOMEM;
+		page_table_desc = kho_pgt_desc(cur);
+		kho_order_table->orders[order] = page_table_desc;
+	}
+
+	cur = kho_page_table(kho_order_table->orders[order]);
+
+	/* Go from high level tables to low level tables */
+	for (i = num_table_level; i > 1; i--) {
+		page_table_index = kho_get_page_table_index(pa, order, i);
+
+		if (!cur->tables[page_table_index]) {
+			next = kho_alloc_page_table();
+			if (!next)
+				return -ENOMEM;
+			cur->tables[page_table_index] = kho_pgt_desc(next);
+		} else {
+			next = kho_page_table(cur->tables[page_table_index]);
+		}
+
+		cur = next;
+	}
+
+	/* Cur is now pointing to the level 1 bitmap table */
+	bitmap_table = (struct kho_bitmap_table *)cur;
+	kho_set_preserved_page_bit(bitmap_table,
+				   pa & BITMAP_TABLE_MASK(order),
+				   order);
+
+	return 0;
+}
+
+/*
+ * TODO: __maybe_unused is added to the functions:
+ * kho_preserve_page_table()
+ * kho_walk_tables()
+ * kho_memblock_reserve()
+ * since they are not actually being called in this change.
+ * __maybe_unused will be removed in the next patch.
+ */
+static __maybe_unused int kho_preserve_page_table(unsigned long pfn, int order)
+{
+	unsigned long pa = PFN_PHYS(pfn);
+
+	might_sleep();
+
+	return __kho_preserve_page_table(pa, order);
+}
+
+static int __kho_walk_bitmap_table(int order,
+				   struct kho_bitmap_table *bitmap_table,
+				   unsigned long pa,
+				   kho_walk_callback_t cb)
+{
+	int i;
+	unsigned long offset;
+	int ret = 0;
+	int order_factor = 1 << order;
+	unsigned long *bitmap = (unsigned long *)bitmap_table;
+
+	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
+		offset = (unsigned long)PAGE_SIZE * order_factor * i;
+		ret = cb(offset + pa, order);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int __kho_walk_page_tables(int order, int level,
+				  struct kho_page_table *cur, unsigned long pa,
+				  kho_walk_callback_t cb)
+{
+	struct kho_page_table *next;
+	struct kho_bitmap_table *bitmap_table;
+	int i;
+	unsigned long offset;
+	int ret = 0;
+
+	if (level == 1) {
+		bitmap_table = (struct kho_bitmap_table *)cur;
+		return __kho_walk_bitmap_table(order, bitmap_table, pa, cb);
+	}
+
+	for (i = 0; i < PTR_PER_LEVEL; i++) {
+		if (cur->tables[i]) {
+			next = kho_page_table(cur->tables[i]);
+			offset = i;
+			offset <<= kho_page_table_level_shift(level, order);
+			ret = __kho_walk_page_tables(order, level - 1,
+						     next, offset + pa, cb);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static __maybe_unused int kho_walk_page_tables(struct kho_page_table *top, int order,
+					       kho_walk_callback_t cb)
+{
+	int num_table_level;
+
+	if (top) {
+		num_table_level = kho_table_level(order);
+		return __kho_walk_page_tables(order, num_table_level, top, 0, cb);
+	}
+
+	return 0;
+}
+
+static __maybe_unused int kho_memblock_reserve(phys_addr_t pa, int order)
+{
+	int sz = 1 << (order + PAGE_SHIFT);
+	struct page *page = phys_to_page(pa);
+
+	memblock_reserve(pa, sz);
+	memblock_reserved_mark_noinit(pa, sz);
+	page->private = order;
+
+	return 0;
+}
+
 /*
  * Keep track of memory that is to be preserved across KHO.
  *
-- 
2.51.0.384.g4c02a37b29-goog



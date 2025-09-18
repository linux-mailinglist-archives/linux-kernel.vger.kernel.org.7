Return-Path: <linux-kernel+bounces-810632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5610BB51D23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AD41C87889
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A33375DE;
	Wed, 10 Sep 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoZpny/m"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68C33EAE6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520584; cv=none; b=p9+2bTrpUoVa41CHQXKyXpPD/KmhNGRZvWIlZwSIyYOvDlgvtjiAnhn+XfnlUB+Uozl/LYcFT9OKlNLQ0CDRS1iel6pg+A4a5TlF9WfWW+0iq0DtCc4m5d0h9IMo5LWsLfTkZke3PN7pvhLvnmYFurSOlQnqo1yYebDzuO8T6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520584; c=relaxed/simple;
	bh=aeZ+y0q2aSQE8aNO1ajCkRy1xI+YWzxbLPzYGeb4V/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry/sDWEY1Z/NwwLXCAXCv20LL2hTFausBb8Xw747AbV6XONqDcSKQmW4+pufYsWCxUm73yMCXp+ivtReWYcsNzEr5KlsfujcMSkNuh46p/nfNkg/fvir1xmxIlv6JVQGvXQBpTxbaI+EwYtcgY8ShioiEHPlXVRuLfwGU9Zx8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoZpny/m; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772679eb358so6640976b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520581; x=1758125381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1JSpL7ZCq9Q4IZEbmZCVrVHvMcatBTvNzr50xCRGm9o=;
        b=LoZpny/mI3ZwF2AtdIzR/VTYCFWOhwIdm/6js9U9Fk5p5RFfyM4LQyEc5GiF3igJjq
         hy9otbLQVSOkgUJj/TtxnuOs6n3OKUrv0HJ5J3N6+SGlNofWz9ZAkcmg6CFx/HtHNBUk
         qd04WRXeW/XNB/9JvBiidSPQGfrSx92ZOqPiXEgmoWSFpO4p2IMNCL/UjAvb5jm7g4wX
         1OlO9R2Vc/62io+VUWGIwWAZt4c60kdQWi9gpj2inTIEl8pLehzCmvAybybxLRF4y2H8
         Q7XyyphiOYVoFgVASPEeEE055Z84zrzoGzOOmVfjIjLTUcSJ/rjJdAHznUDvHFrQStvI
         +e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520581; x=1758125381;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JSpL7ZCq9Q4IZEbmZCVrVHvMcatBTvNzr50xCRGm9o=;
        b=nl0Xl3FghItR48A8cLNUCljdiOCfVltx7ybeEVlAu/YvY7vSPEXjXNh7hmWrnUzVzL
         Ac6TduBKVVHcusrmXvEr1wrxEaR1O8cwHoGhHvcobvgDBlMHTb1i1/Gm21QtF0UVcNQB
         rJgNo2wWJiROVAbDnuVz2Fzymc9p2qsv8aykn5vyLWvCKf+567slNCd4zlJruBapspRA
         DDjme79+0rK1LcDbayVIwk5H9iyF/NPQqzutdyAaUgxjFI9Mu2OqAtlueLWBAosqepRo
         vAS1KeWfhVoBZJU2HDDWhgBD1ZMJ9uZyTGdD9DGE50pJqlSr0b1Cyqukd7MrlBurDB4V
         FpYw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Fyz6gcY6O61LWyu+B3JaF1zPSm1Zp4+15sxCIQBigxnJsBokThFSPCJhzWlDs6VlnYmQUlh/6NnNX2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXE1OA0u3lKg6PiefAscyI0yr3kTcxS0i3A7egSYJQH5SFnfod
	0bkLp6WPXPVf83ELYMNplWTZLoQj2bA3gPycfXRp5U9cNI5ssNg/c3KM
X-Gm-Gg: ASbGncsQ2Fwjc0nuIGZeyfXn2PTlqliJu6G8rQSI7GVtZKu3Ki2izxQbFLaxaG7OmRu
	9yxZrloBqjHfpSjtPPxjA0NdFhN+oTnu1BedtlzwM+/DBh5ieJg0hG9jfKj+Usy4zAQq2HyrdTP
	37IPsBds9RqFDa+w8l+nOyAMrJVoGx5uCMtoFgtvwBPxMLMWjwNdFQAYQ0XyhF/NBFkvWjKINaY
	Nns29TDvNVykMTpp86uHAnK3WAVU88oNO3jREAe4B07egGftbYzGtA0UI232RVbF5sfC8M+jf5o
	3TF2GCxaNiIeoCNPoS9HI+D5BFpzHEGuxweXT8kd5vwpJx1WB8pOKdybaqw9oKa0c795PFZdrMF
	vJ//Ga34B78/gVBf5eLBZ1xGU1UlXkoqrsgb+LytUDRBG0gIqBVNZ1I9JFw==
X-Google-Smtp-Source: AGHT+IGzdfVdQOR0+tFkF7v1qxuYTr8o+dH9tTF5cvN+EsZ096h2fv+en+7YHy9W1aYlsUBZZis87A==
X-Received: by 2002:a05:6a21:32aa:b0:24e:84c9:e999 with SMTP id adf61e73a8af0-2533f4e683cmr23413568637.22.1757520580633;
        Wed, 10 Sep 2025 09:09:40 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:40 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 11/15] mm, swap: use the swap table for the swap cache and switch API
Date: Thu, 11 Sep 2025 00:08:29 +0800
Message-ID: <20250910160833.3464-12-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910160833.3464-1-ryncsn@gmail.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Introduce basic swap table infrastructures, which are now just a
fixed-sized flat array inside each swap cluster, with access wrappers.

Each cluster contains a swap table of 512 entries. Each table entry is
an opaque atomic long. It could be in 3 types: a shadow type (XA_VALUE),
a folio type (pointer), or NULL.

In this first step, it only supports storing a folio or shadow, and it
is a drop-in replacement for the current swap cache. Convert all swap
cache users to use the new sets of APIs. Chris Li has been suggesting
using a new infrastructure for swap cache for better performance, and
that idea combined well with the swap table as the new backing
structure. Now the lock contention range is reduced to 2M clusters,
which is much smaller than the 64M address_space. And we can also drop
the multiple address_space design.

All the internal works are done with swap_cache_get_* helpers. Swap
cache lookup is still lock-less like before, and the helper's contexts
are same with original swap cache helpers. They still require a pin
on the swap device to prevent the backing data from being freed.

Swap cache updates are now protected by the swap cluster lock
instead of the Xarray lock. This is mostly handled internally, but new
__swap_cache_* helpers require the caller to lock the cluster. So, a
few new cluster access and locking helpers are also introduced.

A fully cluster-based unified swap table can be implemented on top
of this to take care of all count tracking and synchronization work,
with dynamic allocation. It should reduce the memory usage while
making the performance even better.

Co-developed-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Chris Li <chrisl@kernel.org>
---
 MAINTAINERS          |   1 +
 include/linux/swap.h |   2 -
 mm/huge_memory.c     |  13 +-
 mm/migrate.c         |  19 ++-
 mm/shmem.c           |   8 +-
 mm/swap.h            | 154 +++++++++++++++++------
 mm/swap_state.c      | 293 +++++++++++++++++++------------------------
 mm/swap_table.h      |  97 ++++++++++++++
 mm/swapfile.c        | 100 +++++++++++----
 mm/vmscan.c          |  20 ++-
 10 files changed, 459 insertions(+), 248 deletions(-)
 create mode 100644 mm/swap_table.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d113bfc3c82..4c8bbf70a3c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16232,6 +16232,7 @@ F:	include/linux/swapops.h
 F:	mm/page_io.c
 F:	mm/swap.c
 F:	mm/swap.h
+F:	mm/swap_table.h
 F:	mm/swap_state.c
 F:	mm/swapfile.c
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 762f8db0e811..e818fbade1e2 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -480,8 +480,6 @@ extern int __swap_count(swp_entry_t entry);
 extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
 struct backing_dev_info;
-extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
-extern void exit_swap_address_space(unsigned int type);
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4c66e358685b..a9fc7a09167a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3720,7 +3720,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
-		struct address_space *swap_cache = NULL;
+		struct swap_cluster_info *ci = NULL;
 		struct lruvec *lruvec;
 		int expected_refs;
 
@@ -3764,8 +3764,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 				goto fail;
 			}
 
-			swap_cache = swap_address_space(folio->swap);
-			xa_lock(&swap_cache->i_pages);
+			ci = swap_cluster_get_and_lock(folio);
 		}
 
 		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
@@ -3797,8 +3796,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			 * Anonymous folio with swap cache.
 			 * NOTE: shmem in swap cache is not supported yet.
 			 */
-			if (swap_cache) {
-				__swap_cache_replace_folio(folio, new_folio);
+			if (ci) {
+				__swap_cache_replace_folio(ci, folio, new_folio);
 				continue;
 			}
 
@@ -3833,8 +3832,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 		unlock_page_lruvec(lruvec);
 
-		if (swap_cache)
-			xa_unlock(&swap_cache->i_pages);
+		if (ci)
+			swap_cluster_unlock(ci);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 		ret = -EAGAIN;
diff --git a/mm/migrate.c b/mm/migrate.c
index c69cc13db692..946253c39807 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -563,6 +563,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int expected_count)
 {
 	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
+	struct swap_cluster_info *ci = NULL;
 	struct zone *oldzone, *newzone;
 	int dirty;
 	long nr = folio_nr_pages(folio);
@@ -591,9 +592,16 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	oldzone = folio_zone(folio);
 	newzone = folio_zone(newfolio);
 
-	xas_lock_irq(&xas);
+	if (folio_test_swapcache(folio))
+		ci = swap_cluster_get_and_lock_irq(folio);
+	else
+		xas_lock_irq(&xas);
+
 	if (!folio_ref_freeze(folio, expected_count)) {
-		xas_unlock_irq(&xas);
+		if (ci)
+			swap_cluster_unlock(ci);
+		else
+			xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
@@ -624,7 +632,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	}
 
 	if (folio_test_swapcache(folio))
-		__swap_cache_replace_folio(folio, newfolio);
+		__swap_cache_replace_folio(ci, folio, newfolio);
 	else
 		xas_store(&xas, newfolio);
 
@@ -635,8 +643,11 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	 */
 	folio_ref_unfreeze(folio, expected_count - nr);
 
-	xas_unlock(&xas);
 	/* Leave irq disabled to prevent preemption while updating stats */
+	if (ci)
+		swap_cluster_unlock(ci);
+	else
+		xas_unlock(&xas);
 
 	/*
 	 * If moved to a different zone then also account
diff --git a/mm/shmem.c b/mm/shmem.c
index 8930780325da..8147a99a4b07 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2083,9 +2083,9 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 				struct shmem_inode_info *info, pgoff_t index,
 				struct vm_area_struct *vma)
 {
+	struct swap_cluster_info *ci;
 	struct folio *new, *old = *foliop;
 	swp_entry_t entry = old->swap;
-	struct address_space *swap_mapping = swap_address_space(entry);
 	int nr_pages = folio_nr_pages(old);
 	int error = 0;
 
@@ -2116,9 +2116,9 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	new->swap = entry;
 	folio_set_swapcache(new);
 
-	xa_lock_irq(&swap_mapping->i_pages);
-	__swap_cache_replace_folio(old, new);
-	xa_unlock_irq(&swap_mapping->i_pages);
+	ci = swap_cluster_get_and_lock_irq(old);
+	__swap_cache_replace_folio(ci, old, new);
+	swap_cluster_unlock(ci);
 
 	mem_cgroup_replace_folio(old, new);
 	shmem_update_stats(new, nr_pages);
diff --git a/mm/swap.h b/mm/swap.h
index fe579c81c6c4..742db4d46d23 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -2,6 +2,7 @@
 #ifndef _MM_SWAP_H
 #define _MM_SWAP_H
 
+#include <linux/atomic.h> /* for atomic_long_t */
 struct mempolicy;
 struct swap_iocb;
 
@@ -35,6 +36,7 @@ struct swap_cluster_info {
 	u16 count;
 	u8 flags;
 	u8 order;
+	atomic_long_t *table;	/* Swap table entries, see mm/swap_table.h */
 	struct list_head list;
 };
 
@@ -55,6 +57,11 @@ enum swap_cluster_flags {
 #include <linux/swapops.h> /* for swp_offset */
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
+static inline unsigned int swp_cluster_offset(swp_entry_t entry)
+{
+	return swp_offset(entry) % SWAPFILE_CLUSTER;
+}
+
 /*
  * Callers of all helpers below must ensure the entry, type, or offset is
  * valid, and protect the swap device with reference count or locks.
@@ -81,6 +88,25 @@ static inline struct swap_cluster_info *__swap_offset_to_cluster(
 	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
 }
 
+static inline struct swap_cluster_info *__swap_entry_to_cluster(swp_entry_t entry)
+{
+	return __swap_offset_to_cluster(__swap_entry_to_info(entry),
+					swp_offset(entry));
+}
+
+static __always_inline struct swap_cluster_info *__swap_cluster_lock(
+		struct swap_info_struct *si, unsigned long offset, bool irq)
+{
+	struct swap_cluster_info *ci = __swap_offset_to_cluster(si, offset);
+
+	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
+	if (irq)
+		spin_lock_irq(&ci->lock);
+	else
+		spin_lock(&ci->lock);
+	return ci;
+}
+
 /**
  * swap_cluster_lock - Lock and return the swap cluster of given offset.
  * @si: swap device the cluster belongs to.
@@ -92,11 +118,49 @@ static inline struct swap_cluster_info *__swap_offset_to_cluster(
 static inline struct swap_cluster_info *swap_cluster_lock(
 		struct swap_info_struct *si, unsigned long offset)
 {
-	struct swap_cluster_info *ci = __swap_offset_to_cluster(si, offset);
+	return __swap_cluster_lock(si, offset, false);
+}
 
-	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
-	spin_lock(&ci->lock);
-	return ci;
+static inline struct swap_cluster_info *__swap_cluster_get_and_lock(
+		const struct folio *folio, bool irq)
+{
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
+	return __swap_cluster_lock(__swap_entry_to_info(folio->swap),
+				   swp_offset(folio->swap), irq);
+}
+
+/*
+ * swap_cluster_get_and_lock - Locks the cluster that holds a folio's entries.
+ * @folio: The folio.
+ *
+ * This locks and returns the swap cluster that contains a folio's swap
+ * entries. The swap entries of a folio are always in one single cluster.
+ * The folio has to be locked so its swap entries won't change and the
+ * cluster won't be freed.
+ *
+ * Context: Caller must ensure the folio is locked and in the swap cache.
+ * Return: Pointer to the swap cluster.
+ */
+static inline struct swap_cluster_info *swap_cluster_get_and_lock(
+		const struct folio *folio)
+{
+	return __swap_cluster_get_and_lock(folio, false);
+}
+
+/*
+ * swap_cluster_get_and_lock_irq - Locks the cluster that holds a folio's entries.
+ * @folio: The folio.
+ *
+ * Same as swap_cluster_get_and_lock but also disable IRQ.
+ *
+ * Context: Caller must ensure the folio is locked and in the swap cache.
+ * Return: Pointer to the swap cluster.
+ */
+static inline struct swap_cluster_info *swap_cluster_get_and_lock_irq(
+		const struct folio *folio)
+{
+	return __swap_cluster_get_and_lock(folio, true);
 }
 
 static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
@@ -104,6 +168,11 @@ static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
 	spin_unlock(&ci->lock);
 }
 
+static inline void swap_cluster_unlock_irq(struct swap_cluster_info *ci)
+{
+	spin_unlock_irq(&ci->lock);
+}
+
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
@@ -123,10 +192,11 @@ void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
 #define SWAP_ADDRESS_SPACE_SHIFT	14
 #define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
 #define SWAP_ADDRESS_SPACE_MASK		(SWAP_ADDRESS_SPACE_PAGES - 1)
-extern struct address_space *swapper_spaces[];
-#define swap_address_space(entry)			    \
-	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
-		>> SWAP_ADDRESS_SPACE_SHIFT])
+extern struct address_space swap_space;
+static inline struct address_space *swap_address_space(swp_entry_t entry)
+{
+	return &swap_space;
+}
 
 /*
  * Return the swap device position of the swap entry.
@@ -136,15 +206,6 @@ static inline loff_t swap_dev_pos(swp_entry_t entry)
 	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
 }
 
-/*
- * Return the swap cache index of the swap entry.
- */
-static inline pgoff_t swap_cache_index(swp_entry_t entry)
-{
-	BUILD_BUG_ON((SWP_OFFSET_MASK | SWAP_ADDRESS_SPACE_MASK) != SWP_OFFSET_MASK);
-	return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
-}
-
 /**
  * folio_matches_swap_entry - Check if a folio matches a given swap entry.
  * @folio: The folio.
@@ -180,14 +241,14 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry);
 void *swap_cache_get_shadow(swp_entry_t entry);
-int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
-			 gfp_t gfp, void **shadow);
+void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow);
 void swap_cache_del_folio(struct folio *folio);
-void __swap_cache_del_folio(struct folio *folio,
-			    swp_entry_t entry, void *shadow);
-void __swap_cache_replace_folio(struct folio *old, struct folio *new);
-void swap_cache_clear_shadow(int type, unsigned long begin,
-			     unsigned long end);
+/* Below helpers require the caller to lock and pass in the swap cluster. */
+void __swap_cache_del_folio(struct swap_cluster_info *ci,
+			    struct folio *folio, swp_entry_t entry, void *shadow);
+void __swap_cache_replace_folio(struct swap_cluster_info *ci,
+				struct folio *old, struct folio *new);
+void __swap_cache_clear_shadow(swp_entry_t entry, int nr_ents);
 
 void show_swap_cache_info(void);
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
@@ -255,6 +316,32 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 
 #else /* CONFIG_SWAP */
 struct swap_iocb;
+static inline struct swap_cluster_info *swap_cluster_lock(
+	struct swap_info_struct *si, pgoff_t offset, bool irq)
+{
+	return NULL;
+}
+
+static inline struct swap_cluster_info *swap_cluster_get_and_lock(
+		struct folio *folio)
+{
+	return NULL;
+}
+
+static inline struct swap_cluster_info *swap_cluster_get_and_lock_irq(
+		struct folio *folio)
+{
+	return NULL;
+}
+
+static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
+{
+}
+
+static inline void swap_cluster_unlock_irq(struct swap_cluster_info *ci)
+{
+}
+
 static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t entry)
 {
 	return NULL;
@@ -272,11 +359,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
 	return NULL;
 }
 
-static inline pgoff_t swap_cache_index(swp_entry_t entry)
-{
-	return 0;
-}
-
 static inline bool folio_matches_swap_entry(const struct folio *folio, swp_entry_t entry)
 {
 	return false;
@@ -323,21 +405,21 @@ static inline void *swap_cache_get_shadow(swp_entry_t entry)
 	return NULL;
 }
 
-static inline int swap_cache_add_folio(swp_entry_t entry, struct folio *folio,
-				       gfp_t gfp, void **shadow)
+static inline void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow)
 {
-	return -EINVAL;
 }
 
 static inline void swap_cache_del_folio(struct folio *folio)
 {
 }
 
-static inline void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry, void *shadow)
+static inline void __swap_cache_del_folio(struct swap_cluster_info *ci,
+		struct folio *folio, swp_entry_t entry, void *shadow)
 {
 }
 
-static inline void __swap_cache_replace_folio(struct folio *old, struct folio *new)
+static inline void __swap_cache_replace_folio(struct swap_cluster_info *ci,
+		struct folio *old, struct folio *new)
 {
 }
 
@@ -371,8 +453,10 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
  */
 static inline pgoff_t folio_index(struct folio *folio)
 {
+#ifdef CONFIG_SWAP
 	if (unlikely(folio_test_swapcache(folio)))
-		return swap_cache_index(folio->swap);
+		return swp_offset(folio->swap);
+#endif
 	return folio->index;
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d1f5b8fa52fc..f4a579c23087 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -23,6 +23,7 @@
 #include <linux/huge_mm.h>
 #include <linux/shmem_fs.h>
 #include "internal.h"
+#include "swap_table.h"
 #include "swap.h"
 
 /*
@@ -36,8 +37,10 @@ static const struct address_space_operations swap_aops = {
 #endif
 };
 
-struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
-static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
+struct address_space swap_space __read_mostly = {
+	.a_ops = &swap_aops,
+};
+
 static bool enable_vma_readahead __read_mostly = true;
 
 #define SWAP_RA_ORDER_CEILING	5
@@ -83,11 +86,20 @@ void show_swap_cache_info(void)
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry)
 {
-	struct folio *folio = filemap_get_folio(swap_address_space(entry),
-						swap_cache_index(entry));
-	if (IS_ERR(folio))
-		return NULL;
-	return folio;
+	unsigned long swp_tb;
+	struct folio *folio;
+
+	for (;;) {
+		swp_tb = __swap_table_get(__swap_entry_to_cluster(entry),
+					  swp_cluster_offset(entry));
+		if (!swp_tb_is_folio(swp_tb))
+			return NULL;
+		folio = swp_tb_to_folio(swp_tb);
+		if (likely(folio_try_get(folio)))
+			return folio;
+	}
+
+	return NULL;
 }
 
 /**
@@ -100,13 +112,13 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)
  */
 void *swap_cache_get_shadow(swp_entry_t entry)
 {
-	struct address_space *address_space = swap_address_space(entry);
-	pgoff_t idx = swap_cache_index(entry);
-	void *shadow;
+	unsigned long swp_tb;
+
+	swp_tb = __swap_table_get(__swap_entry_to_cluster(entry),
+				  swp_cluster_offset(entry));
+	if (swp_tb_is_shadow(swp_tb))
+		return swp_tb_to_shadow(swp_tb);
 
-	shadow = xa_load(&address_space->i_pages, idx);
-	if (xa_is_value(shadow))
-		return shadow;
 	return NULL;
 }
 
@@ -119,61 +131,48 @@ void *swap_cache_get_shadow(swp_entry_t entry)
  *
  * Context: Caller must ensure @entry is valid and protect the swap device
  * with reference count or locks.
- * The caller also needs to mark the corresponding swap_map slots with
- * SWAP_HAS_CACHE to avoid race or conflict.
- * Return: Returns 0 on success, error code otherwise.
+ * The caller also needs to update the corresponding swap_map slots with
+ * SWAP_HAS_CACHE bit to avoid race or conflict.
  */
-int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
-			 gfp_t gfp, void **shadowp)
+void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp)
 {
-	struct address_space *address_space = swap_address_space(entry);
-	pgoff_t idx = swap_cache_index(entry);
-	XA_STATE_ORDER(xas, &address_space->i_pages, idx, folio_order(folio));
-	unsigned long i, nr = folio_nr_pages(folio);
-	void *old;
-
-	xas_set_update(&xas, workingset_update_node);
-
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
-	VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio), folio);
+	void *shadow = NULL;
+	unsigned long old_tb, new_tb;
+	struct swap_cluster_info *ci;
+	unsigned int ci_start, ci_off, ci_end;
+	unsigned long nr_pages = folio_nr_pages(folio);
+
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
+
+	new_tb = folio_to_swp_tb(folio);
+	ci_start = swp_cluster_offset(entry);
+	ci_end = ci_start + nr_pages;
+	ci_off = ci_start;
+	ci = swap_cluster_lock(__swap_entry_to_info(entry), swp_offset(entry));
+	do {
+		old_tb = __swap_table_xchg(ci, ci_off, new_tb);
+		WARN_ON_ONCE(swp_tb_is_folio(old_tb));
+		if (swp_tb_is_shadow(old_tb))
+			shadow = swp_tb_to_shadow(old_tb);
+	} while (++ci_off < ci_end);
 
-	folio_ref_add(folio, nr);
+	folio_ref_add(folio, nr_pages);
 	folio_set_swapcache(folio);
 	folio->swap = entry;
+	swap_cluster_unlock(ci);
 
-	do {
-		xas_lock_irq(&xas);
-		xas_create_range(&xas);
-		if (xas_error(&xas))
-			goto unlock;
-		for (i = 0; i < nr; i++) {
-			VM_BUG_ON_FOLIO(xas.xa_index != idx + i, folio);
-			if (shadowp) {
-				old = xas_load(&xas);
-				if (xa_is_value(old))
-					*shadowp = old;
-			}
-			xas_store(&xas, folio);
-			xas_next(&xas);
-		}
-		address_space->nrpages += nr;
-		__node_stat_mod_folio(folio, NR_FILE_PAGES, nr);
-		__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr);
-unlock:
-		xas_unlock_irq(&xas);
-	} while (xas_nomem(&xas, gfp));
-
-	if (!xas_error(&xas))
-		return 0;
+	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
 
-	folio_clear_swapcache(folio);
-	folio_ref_sub(folio, nr);
-	return xas_error(&xas);
+	if (shadowp)
+		*shadowp = shadow;
 }
 
 /**
  * __swap_cache_del_folio - Removes a folio from the swap cache.
+ * @ci: The locked swap cluster.
  * @folio: The folio.
  * @entry: The first swap entry that the folio corresponds to.
  * @shadow: shadow value to be filled in the swap cache.
@@ -181,34 +180,36 @@ int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
  * Removes a folio from the swap cache and fills a shadow in place.
  * This won't put the folio's refcount. The caller has to do that.
  *
- * Context: Caller must hold the xa_lock, ensure the folio is
- * locked and in the swap cache, using the index of @entry.
+ * Context: Caller must ensure the folio is locked and in the swap cache
+ * using the index of @entry, and lock the cluster that holds the entries.
  */
-void __swap_cache_del_folio(struct folio *folio,
+void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 			    swp_entry_t entry, void *shadow)
 {
-	struct address_space *address_space = swap_address_space(entry);
-	int i;
-	long nr = folio_nr_pages(folio);
-	pgoff_t idx = swap_cache_index(entry);
-	XA_STATE(xas, &address_space->i_pages, idx);
-
-	xas_set_update(&xas, workingset_update_node);
-
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
-	VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
-
-	for (i = 0; i < nr; i++) {
-		void *entry = xas_store(&xas, shadow);
-		VM_BUG_ON_PAGE(entry != folio, entry);
-		xas_next(&xas);
-	}
+	unsigned long old_tb, new_tb;
+	unsigned int ci_start, ci_off, ci_end;
+	unsigned long nr_pages = folio_nr_pages(folio);
+
+	VM_WARN_ON_ONCE(__swap_entry_to_cluster(entry) != ci);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_writeback(folio), folio);
+
+	new_tb = shadow_swp_to_tb(shadow);
+	ci_start = swp_cluster_offset(entry);
+	ci_end = ci_start + nr_pages;
+	ci_off = ci_start;
+	do {
+		/* If shadow is NULL, we sets an empty shadow */
+		old_tb = __swap_table_xchg(ci, ci_off, new_tb);
+		WARN_ON_ONCE(!swp_tb_is_folio(old_tb) ||
+			     swp_tb_to_folio(old_tb) != folio);
+	} while (++ci_off < ci_end);
+
 	folio->swap.val = 0;
 	folio_clear_swapcache(folio);
-	address_space->nrpages -= nr;
-	__node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
-	__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
+	node_stat_mod_folio(folio, NR_FILE_PAGES, -nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr_pages);
 }
 
 /**
@@ -223,12 +224,12 @@ void __swap_cache_del_folio(struct folio *folio,
  */
 void swap_cache_del_folio(struct folio *folio)
 {
+	struct swap_cluster_info *ci;
 	swp_entry_t entry = folio->swap;
-	struct address_space *address_space = swap_address_space(entry);
 
-	xa_lock_irq(&address_space->i_pages);
-	__swap_cache_del_folio(folio, entry, NULL);
-	xa_unlock_irq(&address_space->i_pages);
+	ci = swap_cluster_lock(__swap_entry_to_info(entry), swp_offset(entry));
+	__swap_cache_del_folio(ci, folio, entry, NULL);
+	swap_cluster_unlock(ci);
 
 	put_swap_folio(folio, entry);
 	folio_ref_sub(folio, folio_nr_pages(folio));
@@ -236,6 +237,7 @@ void swap_cache_del_folio(struct folio *folio)
 
 /**
  * __swap_cache_replace_folio - Replace a folio in the swap cache.
+ * @ci: The locked swap cluster.
  * @old: The old folio to be replaced.
  * @new: The new folio.
  *
@@ -244,65 +246,62 @@ void swap_cache_del_folio(struct folio *folio)
  * entries. Replacement will take the new folio's swap entry value as
  * the starting offset to override all slots covered by the new folio.
  *
- * Context: Caller must ensure both folios are locked, also lock the
- * swap address_space that holds the old folio to avoid races.
+ * Context: Caller must ensure both folios are locked, and lock the
+ * cluster that holds the old folio to be replaced.
  */
-void __swap_cache_replace_folio(struct folio *old, struct folio *new)
+void __swap_cache_replace_folio(struct swap_cluster_info *ci,
+				struct folio *old, struct folio *new)
 {
 	swp_entry_t entry = new->swap;
 	unsigned long nr_pages = folio_nr_pages(new);
-	unsigned long offset = swap_cache_index(entry);
-	unsigned long end = offset + nr_pages;
-
-	XA_STATE(xas, &swap_address_space(entry)->i_pages, offset);
+	unsigned int ci_off = swp_cluster_offset(entry);
+	unsigned int ci_end = ci_off + nr_pages;
+	unsigned long old_tb, new_tb;
 
 	VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapcache(new));
 	VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(new));
 	VM_WARN_ON_ONCE(!entry.val);
 
 	/* Swap cache still stores N entries instead of a high-order entry */
+	new_tb = folio_to_swp_tb(new);
 	do {
-		WARN_ON_ONCE(xas_store(&xas, new) != old);
-		xas_next(&xas);
-	} while (++offset < end);
+		old_tb = __swap_table_xchg(ci, ci_off, new_tb);
+		WARN_ON_ONCE(!swp_tb_is_folio(old_tb) || swp_tb_to_folio(old_tb) != old);
+	} while (++ci_off < ci_end);
+
+	/*
+	 * If the old folio is partially replaced (e.g., splitting a large
+	 * folio, the old folio is shrunk, and new split sub folios replace
+	 * the shrunk part), ensure the new folio doesn't overlap it.
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_VM) &&
+	    folio_order(old) != folio_order(new)) {
+		ci_off = swp_cluster_offset(old->swap);
+		ci_end = ci_off + folio_nr_pages(old);
+		while (ci_off++ < ci_end)
+			WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get(ci, ci_off)) != old);
+	}
 }
 
 /**
  * swap_cache_clear_shadow - Clears a set of shadows in the swap cache.
- * @type: Indicates the swap device.
- * @begin: Beginning offset of the range.
- * @end: Ending offset of the range.
+ * @entry: The starting index entry.
+ * @nr_ents: How many slots need to be cleared.
  *
- * Context: Caller must ensure the range is valid and hold a reference to
- * the swap device.
+ * Context: Caller must ensure the range is valid, not occupied by,
+ * any folio and protect the swap device with reference count or locks.
  */
-void swap_cache_clear_shadow(int type, unsigned long begin,
-			     unsigned long end)
+void __swap_cache_clear_shadow(swp_entry_t entry, int nr_ents)
 {
-	unsigned long curr = begin;
-	void *old;
-
-	for (;;) {
-		swp_entry_t entry = swp_entry(type, curr);
-		unsigned long index = curr & SWAP_ADDRESS_SPACE_MASK;
-		struct address_space *address_space = swap_address_space(entry);
-		XA_STATE(xas, &address_space->i_pages, index);
-
-		xas_set_update(&xas, workingset_update_node);
-
-		xa_lock_irq(&address_space->i_pages);
-		xas_for_each(&xas, old, min(index + (end - curr), SWAP_ADDRESS_SPACE_PAGES)) {
-			if (!xa_is_value(old))
-				continue;
-			xas_store(&xas, NULL);
-		}
-		xa_unlock_irq(&address_space->i_pages);
+	struct swap_cluster_info *ci = __swap_entry_to_cluster(entry);
+	unsigned int ci_off = swp_cluster_offset(entry), ci_end;
+	unsigned long old;
 
-		/* search the next swapcache until we meet end */
-		curr = ALIGN((curr + 1), SWAP_ADDRESS_SPACE_PAGES);
-		if (curr > end)
-			break;
-	}
+	ci_end = ci_off + nr_ents;
+	do {
+		old = __swap_table_xchg(ci, ci_off, null_to_swp_tb());
+		WARN_ON_ONCE(swp_tb_is_folio(old));
+	} while (++ci_off < ci_end);
 }
 
 /*
@@ -482,10 +481,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (mem_cgroup_swapin_charge_folio(new_folio, NULL, gfp_mask, entry))
 		goto fail_unlock;
 
-	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (swap_cache_add_folio(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
-		goto fail_unlock;
-
+	swap_cache_add_folio(new_folio, entry, &shadow);
 	memcg1_swapin(entry, 1);
 
 	if (shadow)
@@ -677,41 +673,6 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	return folio;
 }
 
-int init_swap_address_space(unsigned int type, unsigned long nr_pages)
-{
-	struct address_space *spaces, *space;
-	unsigned int i, nr;
-
-	nr = DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
-	spaces = kvcalloc(nr, sizeof(struct address_space), GFP_KERNEL);
-	if (!spaces)
-		return -ENOMEM;
-	for (i = 0; i < nr; i++) {
-		space = spaces + i;
-		xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ);
-		atomic_set(&space->i_mmap_writable, 0);
-		space->a_ops = &swap_aops;
-		/* swap cache doesn't use writeback related tags */
-		mapping_set_no_writeback_tags(space);
-	}
-	nr_swapper_spaces[type] = nr;
-	swapper_spaces[type] = spaces;
-
-	return 0;
-}
-
-void exit_swap_address_space(unsigned int type)
-{
-	int i;
-	struct address_space *spaces = swapper_spaces[type];
-
-	for (i = 0; i < nr_swapper_spaces[type]; i++)
-		VM_WARN_ON_ONCE(!mapping_empty(&spaces[i]));
-	kvfree(spaces);
-	nr_swapper_spaces[type] = 0;
-	swapper_spaces[type] = NULL;
-}
-
 static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
 			   unsigned long *end)
 {
@@ -884,7 +845,7 @@ static const struct attribute_group swap_attr_group = {
 	.attrs = swap_attrs,
 };
 
-static int __init swap_init_sysfs(void)
+static int __init swap_init(void)
 {
 	int err;
 	struct kobject *swap_kobj;
@@ -899,11 +860,13 @@ static int __init swap_init_sysfs(void)
 		pr_err("failed to register swap group\n");
 		goto delete_obj;
 	}
+	/* Swap cache writeback is LRU based, no tags for it */
+	mapping_set_no_writeback_tags(&swap_space);
 	return 0;
 
 delete_obj:
 	kobject_put(swap_kobj);
 	return err;
 }
-subsys_initcall(swap_init_sysfs);
+subsys_initcall(swap_init);
 #endif
diff --git a/mm/swap_table.h b/mm/swap_table.h
new file mode 100644
index 000000000000..e1f7cc009701
--- /dev/null
+++ b/mm/swap_table.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _MM_SWAP_TABLE_H
+#define _MM_SWAP_TABLE_H
+
+#include "swap.h"
+
+/*
+ * A swap table entry represents the status of a swap slot on a swap
+ * (physical or virtual) device. The swap table in each cluster is a
+ * 1:1 map of the swap slots in this cluster.
+ *
+ * Each swap table entry could be a pointer (folio), a XA_VALUE
+ * (shadow), or NULL.
+ */
+
+/*
+ * Helpers for casting one type of info into a swap table entry.
+ */
+static inline unsigned long null_to_swp_tb(void)
+{
+	BUILD_BUG_ON(sizeof(unsigned long) != sizeof(atomic_long_t));
+	return 0;
+}
+
+static inline unsigned long folio_to_swp_tb(struct folio *folio)
+{
+	BUILD_BUG_ON(sizeof(unsigned long) != sizeof(void *));
+	return (unsigned long)folio;
+}
+
+static inline unsigned long shadow_swp_to_tb(void *shadow)
+{
+	BUILD_BUG_ON((BITS_PER_XA_VALUE + 1) !=
+		     BITS_PER_BYTE * sizeof(unsigned long));
+	VM_WARN_ON_ONCE(shadow && !xa_is_value(shadow));
+	return (unsigned long)shadow;
+}
+
+/*
+ * Helpers for swap table entry type checking.
+ */
+static inline bool swp_tb_is_null(unsigned long swp_tb)
+{
+	return !swp_tb;
+}
+
+static inline bool swp_tb_is_folio(unsigned long swp_tb)
+{
+	return !xa_is_value((void *)swp_tb) && !swp_tb_is_null(swp_tb);
+}
+
+static inline bool swp_tb_is_shadow(unsigned long swp_tb)
+{
+	return xa_is_value((void *)swp_tb);
+}
+
+/*
+ * Helpers for retrieving info from swap table.
+ */
+static inline struct folio *swp_tb_to_folio(unsigned long swp_tb)
+{
+	VM_WARN_ON(!swp_tb_is_folio(swp_tb));
+	return (void *)swp_tb;
+}
+
+static inline void *swp_tb_to_shadow(unsigned long swp_tb)
+{
+	VM_WARN_ON(!swp_tb_is_shadow(swp_tb));
+	return (void *)swp_tb;
+}
+
+/*
+ * Helpers for accessing or modifying the swap table of a cluster,
+ * the swap cluster must be locked.
+ */
+static inline void __swap_table_set(struct swap_cluster_info *ci,
+				    unsigned int off, unsigned long swp_tb)
+{
+	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	atomic_long_set(&ci->table[off], swp_tb);
+}
+
+static inline unsigned long __swap_table_xchg(struct swap_cluster_info *ci,
+					      unsigned int off, unsigned long swp_tb)
+{
+	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	/* Ordering is guaranteed by cluster lock, relax */
+	return atomic_long_xchg_relaxed(&ci->table[off], swp_tb);
+}
+
+static inline unsigned long __swap_table_get(struct swap_cluster_info *ci,
+					     unsigned int off)
+{
+	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	return atomic_long_read(&ci->table[off]);
+}
+#endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6f5206255789..a81ada4a361d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -46,6 +46,7 @@
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
 #include <linux/swap_cgroup.h>
+#include "swap_table.h"
 #include "internal.h"
 #include "swap.h"
 
@@ -420,6 +421,34 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
 	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
 }
 
+static int swap_cluster_alloc_table(struct swap_cluster_info *ci)
+{
+	WARN_ON(ci->table);
+	ci->table = kzalloc(sizeof(unsigned long) * SWAPFILE_CLUSTER, GFP_KERNEL);
+	if (!ci->table)
+		return -ENOMEM;
+	return 0;
+}
+
+static void swap_cluster_free_table(struct swap_cluster_info *ci)
+{
+	unsigned int ci_off;
+	unsigned long swp_tb;
+
+	if (!ci->table)
+		return;
+
+	for (ci_off = 0; ci_off < SWAPFILE_CLUSTER; ci_off++) {
+		swp_tb = __swap_table_get(ci, ci_off);
+		if (!swp_tb_is_null(swp_tb))
+			pr_err_once("swap: unclean swap space on swapoff: 0x%lx",
+				    swp_tb);
+	}
+
+	kfree(ci->table);
+	ci->table = NULL;
+}
+
 static void move_cluster(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci, struct list_head *list,
 			 enum swap_cluster_flags new_flags)
@@ -702,6 +731,26 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 	return true;
 }
 
+/*
+ * Currently, the swap table is not used for count tracking, just
+ * do a sanity check here to ensure nothing leaked, so the swap
+ * table should be empty upon freeing.
+ */
+static void swap_cluster_assert_table_empty(struct swap_cluster_info *ci,
+				unsigned int start, unsigned int nr)
+{
+	unsigned int ci_off = start % SWAPFILE_CLUSTER;
+	unsigned int ci_end = ci_off + nr;
+	unsigned long swp_tb;
+
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+		do {
+			swp_tb = __swap_table_get(ci, ci_off);
+			VM_WARN_ON_ONCE(!swp_tb_is_null(swp_tb));
+		} while (++ci_off < ci_end);
+	}
+}
+
 static bool cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster_info *ci,
 				unsigned int start, unsigned char usage,
 				unsigned int order)
@@ -721,6 +770,7 @@ static bool cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 		ci->order = order;
 
 	memset(si->swap_map + start, usage, nr_pages);
+	swap_cluster_assert_table_empty(ci, start, nr_pages);
 	swap_range_alloc(si, nr_pages);
 	ci->count += nr_pages;
 
@@ -1123,7 +1173,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			swap_slot_free_notify(si->bdev, offset);
 		offset++;
 	}
-	swap_cache_clear_shadow(si->type, begin, end);
+	__swap_cache_clear_shadow(swp_entry(si->type, begin), nr_entries);
 
 	/*
 	 * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
@@ -1280,16 +1330,7 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp)
 	if (!entry.val)
 		return -ENOMEM;
 
-	/*
-	 * XArray node allocations from PF_MEMALLOC contexts could
-	 * completely exhaust the page allocator. __GFP_NOMEMALLOC
-	 * stops emergency reserves from being allocated.
-	 *
-	 * TODO: this could cause a theoretical memory reclaim
-	 * deadlock in the swap out path.
-	 */
-	if (swap_cache_add_folio(folio, entry, gfp | __GFP_NOMEMALLOC, NULL))
-		goto out_free;
+	swap_cache_add_folio(folio, entry, NULL);
 
 	return 0;
 
@@ -1555,6 +1596,7 @@ static void swap_entries_free(struct swap_info_struct *si,
 
 	mem_cgroup_uncharge_swap(entry, nr_pages);
 	swap_range_free(si, offset, nr_pages);
+	swap_cluster_assert_table_empty(ci, offset, nr_pages);
 
 	if (!ci->count)
 		free_cluster(si, ci);
@@ -2633,6 +2675,18 @@ static void wait_for_allocation(struct swap_info_struct *si)
 	}
 }
 
+static void free_cluster_info(struct swap_cluster_info *cluster_info,
+			      unsigned long maxpages)
+{
+	int i, nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
+
+	if (!cluster_info)
+		return;
+	for (i = 0; i < nr_clusters; i++)
+		swap_cluster_free_table(&cluster_info[i]);
+	kvfree(cluster_info);
+}
+
 /*
  * Called after swap device's reference count is dead, so
  * neither scan nor allocation will use it.
@@ -2767,12 +2821,13 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	swap_file = p->swap_file;
 	p->swap_file = NULL;
-	p->max = 0;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
 	zeromap = p->zeromap;
 	p->zeromap = NULL;
 	cluster_info = p->cluster_info;
+	free_cluster_info(cluster_info, p->max);
+	p->max = 0;
 	p->cluster_info = NULL;
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
@@ -2783,10 +2838,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->global_cluster = NULL;
 	vfree(swap_map);
 	kvfree(zeromap);
-	kvfree(cluster_info);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
-	exit_swap_address_space(p->type);
 
 	inode = mapping->host;
 
@@ -3170,8 +3223,11 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	if (!cluster_info)
 		goto err;
 
-	for (i = 0; i < nr_clusters; i++)
+	for (i = 0; i < nr_clusters; i++) {
 		spin_lock_init(&cluster_info[i].lock);
+		if (swap_cluster_alloc_table(&cluster_info[i]))
+			goto err_free;
+	}
 
 	if (!(si->flags & SWP_SOLIDSTATE)) {
 		si->global_cluster = kmalloc(sizeof(*si->global_cluster),
@@ -3232,9 +3288,8 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	}
 
 	return cluster_info;
-
 err_free:
-	kvfree(cluster_info);
+	free_cluster_info(cluster_info, maxpages);
 err:
 	return ERR_PTR(err);
 }
@@ -3428,13 +3483,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		}
 	}
 
-	error = init_swap_address_space(si->type, maxpages);
-	if (error)
-		goto bad_swap_unlock_inode;
-
 	error = zswap_swapon(si->type, maxpages);
 	if (error)
-		goto free_swap_address_space;
+		goto bad_swap_unlock_inode;
 
 	/*
 	 * Flush any pending IO and dirty mappings before we start using this
@@ -3469,8 +3520,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	goto out;
 free_swap_zswap:
 	zswap_swapoff(si->type);
-free_swap_address_space:
-	exit_swap_address_space(si->type);
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
@@ -3485,7 +3534,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
 	kvfree(zeromap);
-	kvfree(cluster_info);
+	if (cluster_info)
+		free_cluster_info(cluster_info, maxpages);
 	if (inced_nr_rotate_swap)
 		atomic_dec(&nr_rotate_swap);
 	if (swap_file)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c79c6806560b..e170c12e2065 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -730,13 +730,18 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 {
 	int refcount;
 	void *shadow = NULL;
+	struct swap_cluster_info *ci;
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(mapping != folio_mapping(folio));
 
-	if (!folio_test_swapcache(folio))
+	if (folio_test_swapcache(folio)) {
+		ci = swap_cluster_get_and_lock_irq(folio);
+	} else {
 		spin_lock(&mapping->host->i_lock);
-	xa_lock_irq(&mapping->i_pages);
+		xa_lock_irq(&mapping->i_pages);
+	}
+
 	/*
 	 * The non racy check for a busy folio.
 	 *
@@ -776,9 +781,9 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
-		__swap_cache_del_folio(folio, swap, shadow);
+		__swap_cache_del_folio(ci, folio, swap, shadow);
 		memcg1_swapout(folio, swap);
-		xa_unlock_irq(&mapping->i_pages);
+		swap_cluster_unlock_irq(ci);
 		put_swap_folio(folio, swap);
 	} else {
 		void (*free_folio)(struct folio *);
@@ -816,9 +821,12 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 	return 1;
 
 cannot_free:
-	xa_unlock_irq(&mapping->i_pages);
-	if (!folio_test_swapcache(folio))
+	if (folio_test_swapcache(folio)) {
+		swap_cluster_unlock_irq(ci);
+	} else {
+		xa_unlock_irq(&mapping->i_pages);
 		spin_unlock(&mapping->host->i_lock);
+	}
 	return 0;
 }
 
-- 
2.51.0



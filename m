Return-Path: <linux-kernel+bounces-627892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670B0AA5647
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 22:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D4A9E5106
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474632D47DB;
	Wed, 30 Apr 2025 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObXdk1ho"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D52D3A98;
	Wed, 30 Apr 2025 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046406; cv=none; b=uFP2f2iFq3S6CJAqE3cs8r+MLHkWaJBFVl5COQ3jMjqp0zmx4hkCjqvsuQu4xnGn1SXZF9xy2vmdPoHabOcC4pMrEqTfk4waiHO2wNK7Z7OzDu7OyLVXS8ZNqHrY5JRGNAm+sypbNm8mcH/sGGsSXRA9KEAPXmvl1T233pwwjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046406; c=relaxed/simple;
	bh=DDaOA19vkB8fzpz/hF+6UEVXZdzAdZ5S5Yw7TXl9byM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E0Q6gLLCmJDaZqvddRLC1OJFLBhjWGBz3xJ7KySYMy8OpXTFmxBU0ZC4g79msjMAyB4zOks/y/dWgSP8gaEwjeX6a98f7W7/7ozjuD27b4qZMX54qJvdUWbzXvUlrAJxoZW7xrbp2rPFArkWODIngkZc1VP25Zu0ha0Qjga/Bwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObXdk1ho; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746046404; x=1777582404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DDaOA19vkB8fzpz/hF+6UEVXZdzAdZ5S5Yw7TXl9byM=;
  b=ObXdk1hopkuBegkfIPQop63X3Vaay/D7oPMuIWjEGMdVYOeNeTxh/KzH
   7Uyx2PhDFu1UHENkDPn7b2aJSVsI3KMfdt6zBQdNsAwXwFfG2cpfEZk4G
   BQGjaemnwI6jJftHAkT8kdEdPdjBfo4WcnmVKqmx7A59XAk0uYGS+Ia3C
   WicspoNoX6hWCXHrRcKjx3lpEIjQ78XfYR0tUiNZOeReFPoxGJpjNoFuc
   NmrAbf94Q9w6ewLHeNLGaVXqvyroPyU6vsjjdhkWOoWg6voO6QF8WFPbS
   OpjioMjyGFZYcrx/fRvF1Li8ISZGL/+3K4ivZhRssWse/q1j+0PkWXyTt
   A==;
X-CSE-ConnectionGUID: VhXuLxaTSAOYegi1pTOK6w==
X-CSE-MsgGUID: x548cQcQQZCsr12zIbilWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51388729"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="51388729"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:53:22 -0700
X-CSE-ConnectionGUID: 2N9YmZPURRG0BctXYVgV3w==
X-CSE-MsgGUID: RnR/ko3ATRSQLNGN4z86iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="138248945"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 30 Apr 2025 13:53:21 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v9 18/19] mm: zswap: zswap_store() will process a folio in batches.
Date: Wed, 30 Apr 2025 13:53:04 -0700
Message-Id: <20250430205305.22844-19-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250430205305.22844-1-kanchana.p.sridhar@intel.com>
References: <20250430205305.22844-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies zswap_store() to store a batch of pages at a time,
instead of storing one page at a time. It does this by calling a new
procedure zswap_store_pages() with "batch_size" pages. If the folio is
of order-0, the batch_size is 1. If zswap_store() is processing a large
folio:

 - If the compressor supports batching, the batch_size will be the
   pool->nr_reqs.

 - If the compressor does not support batching, the batch_size will be
   ZSWAP_MAX_BATCH_SIZE.

zswap_store_pages() implements all the computes done earlier in
zswap_store_page() for a single-page, for multiple pages in a folio,
namely the "batch". zswap_store_pages() starts by allocating all zswap
entries required to store the batch. Next, it calls zswap_compress() to
sequentially compress each page in the batch. Finally, it adds the
batch's zswap entries to the xarray and LRU, charges zswap memory and
increments zswap stats.

The error handling and cleanup required for all failure scenarios that can
occur while storing a batch in zswap are consolidated to a single
"store_pages_failed" label in zswap_store_pages().

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 199 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 130 insertions(+), 69 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2273dbfd460f..1d6795704350 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1518,81 +1518,125 @@ static void shrink_worker(struct work_struct *w)
 * main API
 **********************************/
 
-static bool zswap_store_page(struct page *page,
-			     struct obj_cgroup *objcg,
-			     struct zswap_pool *pool)
+/*
+ * Store multiple pages in @folio, starting from the page at index @start up to
+ * the page at index @end-1.
+ */
+static bool zswap_store_pages(struct folio *folio,
+			      long start,
+			      long end,
+			      struct obj_cgroup *objcg,
+			      struct zswap_pool *pool)
 {
-	swp_entry_t page_swpentry = page_swap_entry(page);
-	struct zswap_entry *entry, *old;
-
-	/* allocate entry */
-	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
-	if (!entry) {
-		zswap_reject_kmemcache_fail++;
-		return false;
-	}
+	struct zswap_entry *entries[ZSWAP_MAX_BATCH_SIZE];
+	int node_id = folio_nid(folio);
+	u8 i, store_fail_idx = 0, nr_pages = end - start;
 
-	if (!zswap_compress(page, entry, pool))
-		goto compress_failed;
+	for (i = 0; i < nr_pages; ++i) {
+		entries[i] = zswap_entry_cache_alloc(GFP_KERNEL, node_id);
 
-	old = xa_store(swap_zswap_tree(page_swpentry),
-		       swp_offset(page_swpentry),
-		       entry, GFP_KERNEL);
-	if (xa_is_err(old)) {
-		int err = xa_err(old);
+		if (unlikely(!entries[i])) {
+			zswap_reject_kmemcache_fail++;
+			/*
+			 * While handling this error, we only need to call
+			 * zswap_entry_cache_free() for entries[0 .. i-1].
+			 */
+			nr_pages = i;
+			goto store_pages_failed;
+		}
 
-		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
-		zswap_reject_alloc_fail++;
-		goto store_failed;
+		/*
+		 * Initialize the handle to an error value. This facilitates
+		 * having a consolidated failure handling
+		 * 'goto store_pages_failed' that can inspect the value of the
+		 * handle to determine whether zpool memory needs to be
+		 * de-allocated.
+		 */
+		entries[i]->handle = (unsigned long)ERR_PTR(-EINVAL);
 	}
 
-	/*
-	 * We may have had an existing entry that became stale when
-	 * the folio was redirtied and now the new version is being
-	 * swapped out. Get rid of the old.
-	 */
-	if (old)
-		zswap_entry_free(old);
+	for (i = 0; i < nr_pages; ++i) {
+		struct page *page = folio_page(folio, start + i);
 
-	/*
-	 * The entry is successfully compressed and stored in the tree, there is
-	 * no further possibility of failure. Grab refs to the pool and objcg,
-	 * charge zswap memory, and increment zswap_stored_pages.
-	 * The opposite actions will be performed by zswap_entry_free()
-	 * when the entry is removed from the tree.
-	 */
-	zswap_pool_get(pool);
-	if (objcg) {
-		obj_cgroup_get(objcg);
-		obj_cgroup_charge_zswap(objcg, entry->length);
+		if (!zswap_compress(page, entries[i], pool))
+			goto store_pages_failed;
 	}
-	atomic_long_inc(&zswap_stored_pages);
 
-	/*
-	 * We finish initializing the entry while it's already in xarray.
-	 * This is safe because:
-	 *
-	 * 1. Concurrent stores and invalidations are excluded by folio lock.
-	 *
-	 * 2. Writeback is excluded by the entry not being on the LRU yet.
-	 *    The publishing order matters to prevent writeback from seeing
-	 *    an incoherent entry.
-	 */
-	entry->pool = pool;
-	entry->swpentry = page_swpentry;
-	entry->objcg = objcg;
-	entry->referenced = true;
-	if (entry->length) {
-		INIT_LIST_HEAD(&entry->lru);
-		zswap_lru_add(&zswap_list_lru, entry);
+	for (i = 0; i < nr_pages; ++i) {
+		swp_entry_t page_swpentry = page_swap_entry(folio_page(folio, start + i));
+		struct zswap_entry *old, *entry = entries[i];
+
+		old = xa_store(swap_zswap_tree(page_swpentry),
+			       swp_offset(page_swpentry),
+			       entry, GFP_KERNEL);
+		if (unlikely(xa_is_err(old))) {
+			int err = xa_err(old);
+
+			WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
+			zswap_reject_alloc_fail++;
+			/*
+			 * Entries up to this point have been stored in the
+			 * xarray. zswap_store() will erase them from the xarray
+			 * and call zswap_entry_free(). Local cleanup in
+			 * 'store_pages_failed' only needs to happen for
+			 * entries from [@i to @nr_pages).
+			 */
+			store_fail_idx = i;
+			goto store_pages_failed;
+		}
+
+		/*
+		 * We may have had an existing entry that became stale when
+		 * the folio was redirtied and now the new version is being
+		 * swapped out. Get rid of the old.
+		 */
+		if (unlikely(old))
+			zswap_entry_free(old);
+
+		/*
+		 * The entry is successfully compressed and stored in the tree, there is
+		 * no further possibility of failure. Grab refs to the pool and objcg,
+		 * charge zswap memory, and increment zswap_stored_pages.
+		 * The opposite actions will be performed by zswap_entry_free()
+		 * when the entry is removed from the tree.
+		 */
+		zswap_pool_get(pool);
+		if (objcg) {
+			obj_cgroup_get(objcg);
+			obj_cgroup_charge_zswap(objcg, entry->length);
+		}
+		atomic_long_inc(&zswap_stored_pages);
+
+		/*
+		 * We finish initializing the entry while it's already in xarray.
+		 * This is safe because:
+		 *
+		 * 1. Concurrent stores and invalidations are excluded by folio lock.
+		 *
+		 * 2. Writeback is excluded by the entry not being on the LRU yet.
+		 *    The publishing order matters to prevent writeback from seeing
+		 *    an incoherent entry.
+		 */
+		entry->pool = pool;
+		entry->swpentry = page_swpentry;
+		entry->objcg = objcg;
+		entry->referenced = true;
+		if (likely(entry->length)) {
+			INIT_LIST_HEAD(&entry->lru);
+			zswap_lru_add(&zswap_list_lru, entry);
+		}
 	}
 
 	return true;
 
-store_failed:
-	zpool_free(pool->zpool, entry->handle);
-compress_failed:
-	zswap_entry_cache_free(entry);
+store_pages_failed:
+	for (i = store_fail_idx; i < nr_pages; ++i) {
+		if (!IS_ERR_VALUE(entries[i]->handle))
+			zpool_free(pool->zpool, entries[i]->handle);
+
+		zswap_entry_cache_free(entries[i]);
+	}
+
 	return false;
 }
 
@@ -1603,8 +1647,9 @@ bool zswap_store(struct folio *folio)
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
+	unsigned int batch_size;
 	bool ret = false;
-	long index;
+	long start, end;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1638,10 +1683,26 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	for (index = 0; index < nr_pages; ++index) {
-		struct page *page = folio_page(folio, index);
+	/*
+	 * If a large folio is being swapped out and the zswap compressor
+	 * supports batching, i.e., has multiple acomp requests, the folio will
+	 * be compressed in batches of @pool->nr_reqs. If the compressor has
+	 * only one acomp request, the folio will be compressed in batches of
+	 * ZSWAP_MAX_BATCH_SIZE pages, where each page in the batch is
+	 * compressed sequentially. We see better performance by processing the
+	 * folio in batches of ZSWAP_MAX_BATCH_SIZE, due to cache locality of
+	 * working set structures such as the array of zswap_entry's for the
+	 * batch.
+	 */
+	batch_size = (nr_pages > 1) ? ((pool->nr_reqs > 1) ?
+					pool->nr_reqs : ZSWAP_MAX_BATCH_SIZE)
+				    : 1;
+
+	/* Store the folio in batches of "batch_size" pages. */
+	for (start = 0; start < nr_pages; start += batch_size) {
+		end = min(start + batch_size, nr_pages);
 
-		if (!zswap_store_page(page, objcg, pool))
+		if (!zswap_store_pages(folio, start, end, objcg, pool))
 			goto put_pool;
 	}
 
@@ -1671,9 +1732,9 @@ bool zswap_store(struct folio *folio)
 		struct zswap_entry *entry;
 		struct xarray *tree;
 
-		for (index = 0; index < nr_pages; ++index) {
-			tree = swap_zswap_tree(swp_entry(type, offset + index));
-			entry = xa_erase(tree, offset + index);
+		for (start = 0; start < nr_pages; ++start) {
+			tree = swap_zswap_tree(swp_entry(type, offset + start));
+			entry = xa_erase(tree, offset + start);
 			if (entry)
 				zswap_entry_free(entry);
 		}
-- 
2.27.0



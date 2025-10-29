Return-Path: <linux-kernel+bounces-876615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF8C1C21A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A0D567E58
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039833F364;
	Wed, 29 Oct 2025 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgB25pwo"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6204345CAD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753544; cv=none; b=iP5gBAtxevOjIxwZsNFs+dhEyTYzYB7FXwryr56Nrd9DfTs4FYlD0mirqR5Qxn7h8n18asmmH+LT9pSAIzdNlcRLLIG6jljuWkbEHIgGuLLyBCz057vIXiayxoK5lZH/I/b4vvVxo+jONeJwHnmkNfmr0zab2y/K2+isyON16JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753544; c=relaxed/simple;
	bh=0w+LhiAGXLbL/cQ8dosPZUQ597KiXaQmrRCfZk2pdCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/WoC+RozVACF1HeJJx9Dyrzisn1JJnmZCCUJGvCZwSF4XdbrmJQ9KpJQW1/xe6DMAD8+fCIYoOsnBH/jZ/evmtld4YXZnzbrUiSY29U6K45sI+529ky4ANGSYAm3ptPMYC5FfJeIUdcyc9v9a7Uv4sPeRL381l7P42+C9OtuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgB25pwo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6cf3174ca4so5202036a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753542; x=1762358342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pu3PoeCbPMR/s39iM0CKCsQHdYun12Iw5kqNeSZR2xk=;
        b=lgB25pwoQcIT7hg+FYVx1dMTTzgT56cNPDiClMXQOlkciA9CuDddbYhfke0ymM6v1i
         18GjmW5w6GoUNi5ACU+3xkf6zasbduX1mDLRIHNnY0gJ99Jmlbvvp+3ZOk3qnCssCEi4
         HNScoOkLBxg5ziCqCPdRULF+W71sBP/v2lyvy/ZKB+sidWM9XXuuoOMuCRGdX1d5z4gh
         gwW+mgmocFxESCsOKaOctQiZZukiUlw1PyYqcRXZTpe3lAGPmKEkXdvDpkMJslt+4yAQ
         I6pcgq3hUaD8Hw0SmgAxNiBONKSUxyMxF+GfBl8Y5A2RKUWlSPvA9zTHawG1zKTXSnz5
         IZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753542; x=1762358342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pu3PoeCbPMR/s39iM0CKCsQHdYun12Iw5kqNeSZR2xk=;
        b=caWqhzlKfx1NbBwrF76OzEUyg6LF39KgCFZuM0kk03LEHsxVxvkVt3s4loLtzqtxpu
         2CFU0DzrEEKz4O0R5cJjQBSFaZdU/NK3cOIr+T/OX887TEj47iqo29lQH0COdk6SdAFT
         uYgdEZmWfYEPcYoM+t4znsiQgHpYVtvowmlo2UfB/3zrE2fdwJWWVq3+RrudHtMRwCXJ
         YRgN6wLt1cB6nTGt4Ggx5yExErFBxu8nKRmSuQqEaBHj2bTjlrWj2hr+cotCvaitUkKD
         iWXAG6jhT1lBL5Vwzd8+fbS8mndmWk39HdCrr/eFC43ZpMncklECZMBLCvp4QFYMIZUa
         6dNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVINWseWNPh3iZCj9046L5TvkDY4vADTUH7234Ky/C3qD2Xtnr33KIR2cXdOFLML1Ku4BwN/9fcdxa1qd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJp+6Z/uIDC1hujj4ItyF6WZUD9vGOjIk4FugN16FMQ5plne7b
	lkOGOnQe2WBF25bsSVBthZcL9khO1Sp0R4a/Jqwe0BTEATpwfdrcM5bYT50ovBh1kZM=
X-Gm-Gg: ASbGncuRH3q/NtrANvkMXe3+F+++v8/5v0JU9wsxuapKU5iT4aeJsxzjFvlLhtqGSTW
	gKvFY0pvT7WSuzsSlxwvth2I6LWUInwXMnnHjcBwkTU/yd1PsZ3s5KrCi4IZXuQUB+HU9Rn4AnG
	wh9G4R7BT9bUQZKAH44vOE4TJAaeidYBfG9hyj3MGvF6olzHTXZRTdKM8/WiM1YnHBQPjNyaAkA
	0xszP+fs+godEcr+xVZMyl88c98zO64qj8IOGuZqGPpxaoi5idnj5Q6x5/Ja2rk6sYvOSe2v6Q9
	A9SFCV4dQS+m3dkvFs2e6dmr87K3WTSU5c9NHa/8w+4ycnsptjJsq9Qp5DjAfKEhBjC1GNQicqo
	BBopt37t0lQgm2jU68Tm8IdcJ4rBalqze2vAEJkSF5wp0YqFd4GZbRhyG48zuCPgRbC/7OySE+r
	43cPLpmww9eg==
X-Google-Smtp-Source: AGHT+IFb1iX3tuV0DGXqg+fZe0C14p3sGVHz3BXLkVY5YOZsG0Sk2fwS8XqgdeRiLf9YYVqpNW2Uew==
X-Received: by 2002:a17:903:2f8d:b0:269:9a8f:a4ab with SMTP id d9443c01a7336-294deef0a25mr38448885ad.60.1761753541822;
        Wed, 29 Oct 2025 08:59:01 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:01 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:27 +0800
Subject: [PATCH 01/19] mm/swap: rename __read_swap_cache_async to
 swap_cache_alloc_folio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-1-3d43f3b6ec32@tencent.com>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@redhat.com>, 
 Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

__read_swap_cache_async is widely used to allocate and ensure a folio is
in swapcache, or get the folio if a folio is already there.

It's not async, and it's not doing any read. Rename it to better present
its usage, and prepare to be reworked as part of new swap cache APIs.

Also, add some comments for the function. Worth noting that the
skip_if_exists argument is an long existing workaround that will be
dropped soon.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       |  6 +++---
 mm/swap_state.c | 49 ++++++++++++++++++++++++++++++++-----------------
 mm/swapfile.c   |  2 +-
 mm/zswap.c      |  4 ++--
 4 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index d034c13d8dd2..0fff92e42cfe 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -249,6 +249,9 @@ struct folio *swap_cache_get_folio(swp_entry_t entry);
 void *swap_cache_get_shadow(swp_entry_t entry);
 void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow);
 void swap_cache_del_folio(struct folio *folio);
+struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
+				     struct mempolicy *mpol, pgoff_t ilx,
+				     bool *alloced, bool skip_if_exists);
 /* Below helpers require the caller to lock and pass in the swap cluster. */
 void __swap_cache_del_folio(struct swap_cluster_info *ci,
 			    struct folio *folio, swp_entry_t entry, void *shadow);
@@ -261,9 +264,6 @@ void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
 struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug);
-struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
-		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
-		bool skip_if_exists);
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b13e9c4baa90..7765b9474632 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -402,9 +402,28 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
 	}
 }
 
-struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
-		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
-		bool skip_if_exists)
+/**
+ * swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
+ * @entry: the swapped out swap entry to be binded to the folio.
+ * @gfp_mask: memory allocation flags
+ * @mpol: NUMA memory allocation policy to be applied
+ * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
+ * @new_page_allocated: sets true if allocation happened, false otherwise
+ * @skip_if_exists: if the slot is a partially cached state, return NULL.
+ *                  This is a workaround that would be removed shortly.
+ *
+ * Allocate a folio in the swap cache for one swap slot, typically before
+ * doing IO (swap in or swap out). The swap slot indicated by @entry must
+ * have a non-zero swap count (swapped out). Currently only supports order 0.
+ *
+ * Context: Caller must protect the swap device with reference count or locks.
+ * Return: Returns the existing folio if @entry is cached already. Returns
+ * NULL if failed due to -ENOMEM or @entry have a swap count < 1.
+ */
+struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
+				     struct mempolicy *mpol, pgoff_t ilx,
+				     bool *new_page_allocated,
+				     bool skip_if_exists)
 {
 	struct swap_info_struct *si = __swap_entry_to_info(entry);
 	struct folio *folio;
@@ -452,12 +471,12 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			goto put_and_return;
 
 		/*
-		 * Protect against a recursive call to __read_swap_cache_async()
+		 * Protect against a recursive call to swap_cache_alloc_folio()
 		 * on the same entry waiting forever here because SWAP_HAS_CACHE
 		 * is set but the folio is not the swap cache yet. This can
 		 * happen today if mem_cgroup_swapin_charge_folio() below
 		 * triggers reclaim through zswap, which may call
-		 * __read_swap_cache_async() in the writeback path.
+		 * swap_cache_alloc_folio() in the writeback path.
 		 */
 		if (skip_if_exists)
 			goto put_and_return;
@@ -466,7 +485,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * We might race against __swap_cache_del_folio(), and
 		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
 		 * has not yet been cleared.  Or race against another
-		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
+		 * swap_cache_alloc_folio(), which has set SWAP_HAS_CACHE
 		 * in swap_map, but not yet added its folio to swap cache.
 		 */
 		schedule_timeout_uninterruptible(1);
@@ -509,10 +528,6 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
  * and reading the disk if it is not already cached.
  * A failure return means that either the page allocation failed or that
  * the swap entry is no longer in use.
- *
- * get/put_swap_device() aren't needed to call this function, because
- * __read_swap_cache_async() call them and swap_read_folio() holds the
- * swap cache folio lock.
  */
 struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
@@ -529,7 +544,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		return NULL;
 
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
-	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+	folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
 	mpol_cond_put(mpol);
 
@@ -647,9 +662,9 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	blk_start_plug(&plug);
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
-		folio = __read_swap_cache_async(
-				swp_entry(swp_type(entry), offset),
-				gfp_mask, mpol, ilx, &page_allocated, false);
+		folio = swap_cache_alloc_folio(
+			swp_entry(swp_type(entry), offset), gfp_mask, mpol, ilx,
+			&page_allocated, false);
 		if (!folio)
 			continue;
 		if (page_allocated) {
@@ -666,7 +681,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+	folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
 	if (unlikely(page_allocated))
 		swap_read_folio(folio, NULL);
@@ -761,7 +776,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 			continue;
 		pte_unmap(pte);
 		pte = NULL;
-		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+		folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
 		if (!folio)
 			continue;
@@ -781,7 +796,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	lru_add_drain();
 skip:
 	/* The folio was likely read above, so no need for plugging here */
-	folio = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
+	folio = swap_cache_alloc_folio(targ_entry, gfp_mask, mpol, targ_ilx,
 					&page_allocated, false);
 	if (unlikely(page_allocated))
 		swap_read_folio(folio, NULL);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c35bb8593f50..849be32377d9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1573,7 +1573,7 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
  *   CPU1				CPU2
  *   do_swap_page()
  *     ...				swapoff+swapon
- *     __read_swap_cache_async()
+ *     swap_cache_alloc_folio()
  *       swapcache_prepare()
  *         __swap_duplicate()
  *           // check swap_map
diff --git a/mm/zswap.c b/mm/zswap.c
index 5d0f8b13a958..a7a2443912f4 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1014,8 +1014,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		return -EEXIST;
 
 	mpol = get_task_policy(current);
-	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
-			NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
+	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, mpol,
+				       NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
 	put_swap_device(si);
 	if (!folio)
 		return -ENOMEM;

-- 
2.51.1



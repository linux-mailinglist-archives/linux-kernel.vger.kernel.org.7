Return-Path: <linux-kernel+bounces-810629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819ABB51D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907A45811C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD6335BBC;
	Wed, 10 Sep 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayx9600/"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E4334733
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520568; cv=none; b=Z6KepTx3TGVxlSXMmf8XMq2xcfuYZWHx6IIjbTHHocINhsGf/7AlajLYvZiz4lznS/EWd17ETdRQWBjkjYVIu2qqN1MG73iJJiWS6mPmdZJUqRvgm5NL6iUUBZWzOe986SMKCeXU+hnFdcLCFcLTv3UJXcFM7pcbHadpl6e422E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520568; c=relaxed/simple;
	bh=LOotFfbZVx0rWQf/JEDe/ZG6D+kArOuTSBSkBrqVv9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uidb+93VzikIc3k9nBoyAyGLuDXj0Iu12ll+RmDWs3JwdORvDfBDkN7t2Fe8Ngqi6eTtYJTJQDwUHvXdlI59YRmYECV+wXOCu4d54IaTNfq1GzWRk5fW9qTA7t27awh1KQder3fKfWkFCk9UOrdzTtt04tIAqhFkQbIcFdIBS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ayx9600/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77256e75eacso6346656b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520566; x=1758125366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=41IrheQrU1uNONBC2D87eHUDc3ROCWh6baPpZqwFKeI=;
        b=Ayx9600/wC14DhdS8GRdYU64qP2ApX6jUkqYW+akMkIW/ZTcMdwDAofRv0pO1celg/
         iOEe+iQl+JAJFKkhXuUH3u0lct4LFq0SWJgOO6ekC4DkSf2zipmErRbDekpKsbH0zF6V
         f2RyGjRFojE1ImXNxys+zUdpJgjPqeMoI6JFCJhvcVVV3k+WnirEyxFYhte4vlbs97Fp
         C3NNLqPu/OwFYstLvhV1baS6fVZuW9Thmd0TuW3ilGkcz+nMd4hbr51u8lZr74HrFBeN
         Z8+KrHcTh8nXMLO1S+wHwi57o80P+1lg9K7hDimE9mYGCnMtTFweRiOWU0dPoh+eudF+
         voWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520566; x=1758125366;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41IrheQrU1uNONBC2D87eHUDc3ROCWh6baPpZqwFKeI=;
        b=gLAfoRr2wScRNiSkUXeTkz5xLxTfzOmWKmDcOf80tN5n0t8HB3f6XI+BwzVa0LZV3h
         OGfmsSQ+hALSVR4N4US32PW8Peyuq2HPVUkrLNEHJHJutOMFc1o9oDt4u2xQPdzcJeYI
         ZYJWtUHdTjk92K2RLok92ymuFeWxAI+lAdEYpHHjtTgXZdPWYUPnglqJJQR1boWsotA8
         EtwetT3gPWs2/p7uCt4z/hLCm5p2K5zmsG7T4r78kdEgv6k7kt+lEodw9TElpFyZDRCl
         /YmDtfa1vU1Xp5HiX6ax0y920NFUtAxHIwuuepME+zFbep5yRcYQgH/wzjTD9GVgAU+3
         pV3A==
X-Forwarded-Encrypted: i=1; AJvYcCV1x1QnEmwMYaBy/D6wlry/bQqnz2d1uw+1Jxi7F5b+JOziwnob8qUJuSzBRVX6fULNMQXchtkQHB7suXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkLONRYWDSv8z4/9n1w7i23ZQv3HNVBSOrbq2LPSXUXvChUoy
	LS/juap/ggYLdnDtoPZOo93wOzQs6xPo5h9zDOd97xQ8TPzGtQJ6T5KI
X-Gm-Gg: ASbGncu0crGVvTtWwAGWmfYyRjvqjXxMZn6nVxsraamkOaYuIRkzj1MwhvHRqofnSDy
	RWPypvsoY7mDsuJoz3rOjJVPJxCnNWiMJNIN9cZT95Y3mSjWzdBKMqOfxDPhyasfbbV3IeCB9Nh
	oqE8wjYGbCU243aIFChMGO2vciIH1EWDYqJ/QxHml5FCTv06OSfDtzq68j/wS9itzMSM48raikN
	HNJil9RATuSLfqt+uL6WKPCOkzzi8NTKzyG2VcOyaEBm/NOw9ub+9+MzKAkGp8dKMOThGUThpA6
	x06kCPNSR8KT5BUJN5K2oyHRfGzH1Ql7UZsLpSeFnMLwTAC9sRPQijxrXE0WMYFza81eIsQugqY
	XsAHhLC5lMJ5R35LhM5epbStu7ZBi5ctCW2zlfm1wBiOF2OSQIRROQft2Jg==
X-Google-Smtp-Source: AGHT+IGX1OhgXhkIxofCcoD4B7nQIR9FtlH0Q7qIyxMOhhjXQBkvBpqTM/Oc2XmvflNOYzzMsOTu9A==
X-Received: by 2002:a05:6a20:2591:b0:24e:c235:d7e6 with SMTP id adf61e73a8af0-2533d5fed90mr25408969637.5.1757520565690;
        Wed, 10 Sep 2025 09:09:25 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:25 -0700 (PDT)
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
Subject: [PATCH v3 08/15] mm, swap: cleanup swap cache API and add kerneldoc
Date: Thu, 11 Sep 2025 00:08:26 +0800
Message-ID: <20250910160833.3464-9-ryncsn@gmail.com>
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

In preparation for replacing the swap cache backend with the swap table,
clean up and add proper kernel doc for all swap cache APIs. Now all swap
cache APIs are well-defined with consistent names.

No feature change, only renaming and documenting.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/filemap.c        |  2 +-
 mm/memory-failure.c |  2 +-
 mm/memory.c         |  2 +-
 mm/swap.h           | 48 ++++++++++++++-----------
 mm/swap_state.c     | 86 ++++++++++++++++++++++++++++++++-------------
 mm/swapfile.c       |  8 ++---
 mm/vmscan.c         |  2 +-
 mm/zswap.c          |  2 +-
 8 files changed, 98 insertions(+), 54 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8d078aa2738a..2a05b1fdd445 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4525,7 +4525,7 @@ static void filemap_cachestat(struct address_space *mapping,
 				 * invalidation, so there might not be
 				 * a shadow in the swapcache (yet).
 				 */
-				shadow = get_shadow_from_swap_cache(swp);
+				shadow = swap_cache_get_shadow(swp);
 				if (!shadow)
 					goto resched;
 			}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6d9134e3d115..3edebb0cda30 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1127,7 +1127,7 @@ static int me_swapcache_clean(struct page_state *ps, struct page *p)
 	struct folio *folio = page_folio(p);
 	int ret;
 
-	delete_from_swap_cache(folio);
+	swap_cache_del_folio(folio);
 
 	ret = delete_from_lru_cache(folio) ? MF_FAILED : MF_RECOVERED;
 	folio_unlock(folio);
diff --git a/mm/memory.c b/mm/memory.c
index 5808c4ef21b3..41e641823558 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4699,7 +4699,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 				memcg1_swapin(entry, nr_pages);
 
-				shadow = get_shadow_from_swap_cache(entry);
+				shadow = swap_cache_get_shadow(entry);
 				if (shadow)
 					workingset_refault(folio, shadow);
 
diff --git a/mm/swap.h b/mm/swap.h
index 30b1039c27fe..6c4acb549bec 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -167,17 +167,29 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
 	return folio_entry.val == round_down(entry.val, nr_pages);
 }
 
+/*
+ * All swap cache helpers below require the caller to ensure the swap entries
+ * used are valid and stablize the device by any of the following ways:
+ * - Hold a reference by get_swap_device(): this ensures a single entry is
+ *   valid and increases the swap device's refcount.
+ * - Locking a folio in the swap cache: this ensures the folio's swap entries
+ *   are valid and pinned, also implies reference to the device.
+ * - Locking anything referencing the swap entry: e.g. PTL that protects
+ *   swap entries in the page table, similar to locking swap cache folio.
+ * - See the comment of get_swap_device() for more complex usage.
+ */
+struct folio *swap_cache_get_folio(swp_entry_t entry);
+void *swap_cache_get_shadow(swp_entry_t entry);
+int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
+			 gfp_t gfp, void **shadow);
+void swap_cache_del_folio(struct folio *folio);
+void __swap_cache_del_folio(struct folio *folio,
+			    swp_entry_t entry, void *shadow);
+void swap_cache_clear_shadow(int type, unsigned long begin,
+			     unsigned long end);
+
 void show_swap_cache_info(void);
-void *get_shadow_from_swap_cache(swp_entry_t entry);
-int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
-		      gfp_t gfp, void **shadowp);
-void __delete_from_swap_cache(struct folio *folio,
-			      swp_entry_t entry, void *shadow);
-void delete_from_swap_cache(struct folio *folio);
-void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				  unsigned long end);
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
-struct folio *swap_cache_get_folio(swp_entry_t entry);
 struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug);
@@ -305,28 +317,22 @@ static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
 	return NULL;
 }
 
-static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
+static inline void *swap_cache_get_shadow(swp_entry_t entry)
 {
 	return NULL;
 }
 
-static inline int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
-					gfp_t gfp_mask, void **shadowp)
-{
-	return -1;
-}
-
-static inline void __delete_from_swap_cache(struct folio *folio,
-					swp_entry_t entry, void *shadow)
+static inline int swap_cache_add_folio(swp_entry_t entry, struct folio *folio,
+				       gfp_t gfp, void **shadow)
 {
+	return -EINVAL;
 }
 
-static inline void delete_from_swap_cache(struct folio *folio)
+static inline void swap_cache_del_folio(struct folio *folio)
 {
 }
 
-static inline void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				unsigned long end)
+static inline void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry, void *shadow)
 {
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0ad4f3b41f1b..f3a32a06a950 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -78,8 +78,8 @@ void show_swap_cache_info(void)
  * Context: Caller must ensure @entry is valid and protect the swap device
  * with reference count or locks.
  * Return: Returns the found folio on success, NULL otherwise. The caller
- * must lock and check if the folio still matches the swap entry before
- * use (e.g. with folio_matches_swap_entry).
+ * must lock nd check if the folio still matches the swap entry before
+ * use (e.g., folio_matches_swap_entry).
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry)
 {
@@ -90,7 +90,15 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)
 	return folio;
 }
 
-void *get_shadow_from_swap_cache(swp_entry_t entry)
+/**
+ * swap_cache_get_shadow - Looks up a shadow in the swap cache.
+ * @entry: swap entry used for the lookup.
+ *
+ * Context: Caller must ensure @entry is valid and protect the swap device
+ * with reference count or locks.
+ * Return: Returns either NULL or an XA_VALUE (shadow).
+ */
+void *swap_cache_get_shadow(swp_entry_t entry)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	pgoff_t idx = swap_cache_index(entry);
@@ -102,12 +110,21 @@ void *get_shadow_from_swap_cache(swp_entry_t entry)
 	return NULL;
 }
 
-/*
- * add_to_swap_cache resembles filemap_add_folio on swapper_space,
- * but sets SwapCache flag and 'swap' instead of mapping and index.
+/**
+ * swap_cache_add_folio - Add a folio into the swap cache.
+ * @folio: The folio to be added.
+ * @entry: The swap entry corresponding to the folio.
+ * @gfp: gfp_mask for XArray node allocation.
+ * @shadowp: If a shadow is found, return the shadow.
+ *
+ * Context: Caller must ensure @entry is valid and protect the swap device
+ * with reference count or locks.
+ * The caller also needs to mark the corresponding swap_map slots with
+ * SWAP_HAS_CACHE to avoid race or conflict.
+ * Return: Returns 0 on success, error code otherwise.
  */
-int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
-			gfp_t gfp, void **shadowp)
+int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
+			 gfp_t gfp, void **shadowp)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	pgoff_t idx = swap_cache_index(entry);
@@ -155,12 +172,20 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 	return xas_error(&xas);
 }
 
-/*
- * This must be called only on folios that have
- * been verified to be in the swap cache.
+/**
+ * __swap_cache_del_folio - Removes a folio from the swap cache.
+ * @folio: The folio.
+ * @entry: The first swap entry that the folio corresponds to.
+ * @shadow: shadow value to be filled in the swap cache.
+ *
+ * Removes a folio from the swap cache and fills a shadow in place.
+ * This won't put the folio's refcount. The caller has to do that.
+ *
+ * Context: Caller must hold the xa_lock, ensure the folio is
+ * locked and in the swap cache, using the index of @entry.
  */
-void __delete_from_swap_cache(struct folio *folio,
-			swp_entry_t entry, void *shadow)
+void __swap_cache_del_folio(struct folio *folio,
+			    swp_entry_t entry, void *shadow)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	int i;
@@ -186,27 +211,40 @@ void __delete_from_swap_cache(struct folio *folio,
 	__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
 }
 
-/*
- * This must be called only on folios that have
- * been verified to be in the swap cache and locked.
- * It will never put the folio into the free list,
- * the caller has a reference on the folio.
+/**
+ * swap_cache_del_folio - Removes a folio from the swap cache.
+ * @folio: The folio.
+ *
+ * Same as __swap_cache_del_folio, but handles lock and refcount. The
+ * caller must ensure the folio is either clean or has a swap count
+ * equal to zero, or it may cause data loss.
+ *
+ * Context: Caller must ensure the folio is locked and in the swap cache.
  */
-void delete_from_swap_cache(struct folio *folio)
+void swap_cache_del_folio(struct folio *folio)
 {
 	swp_entry_t entry = folio->swap;
 	struct address_space *address_space = swap_address_space(entry);
 
 	xa_lock_irq(&address_space->i_pages);
-	__delete_from_swap_cache(folio, entry, NULL);
+	__swap_cache_del_folio(folio, entry, NULL);
 	xa_unlock_irq(&address_space->i_pages);
 
 	put_swap_folio(folio, entry);
 	folio_ref_sub(folio, folio_nr_pages(folio));
 }
 
-void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				unsigned long end)
+/**
+ * swap_cache_clear_shadow - Clears a set of shadows in the swap cache.
+ * @type: Indicates the swap device.
+ * @begin: Beginning offset of the range.
+ * @end: Ending offset of the range.
+ *
+ * Context: Caller must ensure the range is valid and hold a reference to
+ * the swap device.
+ */
+void swap_cache_clear_shadow(int type, unsigned long begin,
+			     unsigned long end)
 {
 	unsigned long curr = begin;
 	void *old;
@@ -393,7 +431,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			goto put_and_return;
 
 		/*
-		 * We might race against __delete_from_swap_cache(), and
+		 * We might race against __swap_cache_del_folio(), and
 		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
 		 * has not yet been cleared.  Or race against another
 		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
@@ -412,7 +450,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		goto fail_unlock;
 
 	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (add_to_swap_cache(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
+	if (swap_cache_add_folio(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
 		goto fail_unlock;
 
 	memcg1_swapin(entry, 1);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 51c159aa646c..6f5206255789 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -266,7 +266,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (!need_reclaim)
 		goto out_unlock;
 
-	delete_from_swap_cache(folio);
+	swap_cache_del_folio(folio);
 	folio_set_dirty(folio);
 	ret = nr_pages;
 out_unlock:
@@ -1123,7 +1123,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			swap_slot_free_notify(si->bdev, offset);
 		offset++;
 	}
-	clear_shadow_from_swap_cache(si->type, begin, end);
+	swap_cache_clear_shadow(si->type, begin, end);
 
 	/*
 	 * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
@@ -1288,7 +1288,7 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp)
 	 * TODO: this could cause a theoretical memory reclaim
 	 * deadlock in the swap out path.
 	 */
-	if (add_to_swap_cache(folio, entry, gfp | __GFP_NOMEMALLOC, NULL))
+	if (swap_cache_add_folio(folio, entry, gfp | __GFP_NOMEMALLOC, NULL))
 		goto out_free;
 
 	return 0;
@@ -1758,7 +1758,7 @@ bool folio_free_swap(struct folio *folio)
 	if (folio_swapped(folio))
 		return false;
 
-	delete_from_swap_cache(folio);
+	swap_cache_del_folio(folio);
 	folio_set_dirty(folio);
 	return true;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ca9e1cd3cd68..c79c6806560b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -776,7 +776,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
-		__delete_from_swap_cache(folio, swap, shadow);
+		__swap_cache_del_folio(folio, swap, shadow);
 		memcg1_swapout(folio, swap);
 		xa_unlock_irq(&mapping->i_pages);
 		put_swap_folio(folio, swap);
diff --git a/mm/zswap.c b/mm/zswap.c
index c88ad61b232c..3dda4310099e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1069,7 +1069,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 out:
 	if (ret && ret != -EEXIST) {
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 		folio_unlock(folio);
 	}
 	folio_put(folio);
-- 
2.51.0



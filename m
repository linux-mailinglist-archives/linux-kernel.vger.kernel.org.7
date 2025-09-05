Return-Path: <linux-kernel+bounces-803652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E210B4635E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFD41C8487C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26EA28D836;
	Fri,  5 Sep 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thnd7pZ7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986C28B7DB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099701; cv=none; b=CM5ppsxlEFAnRQqDTlFvUz3D5uUCJlELZiAy8eCjkbHEnfqxosNT1Af8JWuPNaFkapoZC5o/M+fiRvtJWyYDzRy/veyoKf+iU4xVJ/qPjvEKSEmq+dkWPWdjuDPD4qzNsh+3DcnluU7S8NryBrXjVfKTVN/em3UaVHMBemE1jEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099701; c=relaxed/simple;
	bh=su9xnhRSPMiQBdNnNB2mYr3cxQkTWMIJ4vLB7YAq34M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RljIf/9L36lMlVm1JuNLJTOljsI0V8trMTrH74g2Ibx8zRV37nJim4iixo7m0XZXrCbfETjGwYSMwZtY4P3CEN53htt2HY2uipcTYv3s8U0p4ehMTjfwLUqWDISdh0lKimEFdyRAr3O56g6sEC3RboBl4tNFN/dHxgvYUENqhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Thnd7pZ7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772301f8ae2so2190155b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099699; x=1757704499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E3aNJoCVROccJngmuYyj6rXHVyByugeVfWJigOc5CDQ=;
        b=Thnd7pZ7bI8TpvO9jqnmlctj1soCONPyQqrbjHyPf5J8umY9JEBd1n1I4Crdgr09Ag
         i+KTggZ4tCogvgbp/Vsu3Nt+zAnboFVL922zCnyYO6P4/WFeK6Bwr4SqtoFmVMYxD91S
         SVWQM5+fmsE8/YQ6eJRwDjIdz3ZAVrWpTxMUSzNnRHv3gFjhT4QiZGBcxkcE3zjLkWxI
         /rmuyrNekthy74UNTqOmFlH2USIcKHLOA4NU6OEgntCbr5SnWqGFnz0S0eru4iP3LkJ3
         hBap3SCYuDJ929sh4YfS1rPVstjsUyFYFBPjIcRt9VsdtG9lCtpk2YWkVe0dM45rpP3E
         xwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099699; x=1757704499;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3aNJoCVROccJngmuYyj6rXHVyByugeVfWJigOc5CDQ=;
        b=IXYCXPQbdqDpiq/j0DatsbJYZePrsTc10eRRIK++CedhBERrk0dmcD4jdXE3n1OMzL
         EBOiNcKvgeQEUu4NDnANrpsXHZrTnzlcrZsmouiSUgAqFoFciHknBTudlcIQSXO2r/jl
         fTmCL/iF1j1G2wChIfP4DWCXuuBeTvQbh15Bw8vpYPUt8No49p48yShGQ/zAqvm1a4SN
         c7Vwc7He5jtL0Iv1UKRLcM6QKTliKp6eXlnQ8KJWsFLYYkM2FP0SmOLKeQ683Ym2NL/I
         +vH8tnI1NzE0NwKn26BmwCSuogq1PCNAvSxr6EqjbapITA0IhL1tDORYRkbUT5Uz6cOT
         hvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhzytYE8WHnbCAMTX1uOGkwa5+qncgtr64rgv5V3Lqczg4/NjlINeWOowRbQBpz5kMD89A8v7yODoGP2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfitaFz7e2J6vSW83h8ObBE66Ktv7mdX1GZ+wJ1OvRynvGveWt
	OybQWntDXofRJj3Fohy0DMxW2L1xgqicyGtotsY0vko+GvjKvZffs16N
X-Gm-Gg: ASbGncubxWI7gx19/snYXrYqRpPfnj3v/WlJwgl5hlEhu5dgRSvv2sY0XEMlvrpBi68
	6Ie8v9Ul06Ro0aZ8Ti8craUWiCid60BX6LViR1jizdftEkZqpwlKdCaO2GDez9qurl1i+3P5In4
	I/nbdAl3v9/Ta8sGaZUJopxrgWHRAJC7AW168wcGlZt7mV/poaI7Oev4LBS1nGcf4XTq0NRC3yt
	7sRERbgZfDqn2otX8dDpJI2iJSFe0oL1I+ppFwoMeNPCG8XVL97vP1ygUnGRh3wcNHcidaCTWYR
	iluLfRZQK4rO6Uk7aJwhGSXzVpO+YDzW1bZqxbqA2SL7cYurJe0m3zaup+k+yBUuMXBfTk1R+NX
	HoEico6gVQgxM3rgB2Glig4naSon+U/Ss9Tkvi38zRKhChJXuvgjLjMIgsA==
X-Google-Smtp-Source: AGHT+IFkFSys4IRUs0tnQpRxvyD0XxRc9V7ETW+LXR3DXREnaZW5aW0gNaD7ew1XW/XButtm1AKAsw==
X-Received: by 2002:a05:6a00:3e29:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7723e224181mr25962922b3a.10.1757099698697;
        Fri, 05 Sep 2025 12:14:58 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.14.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:14:58 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH v2 09/15] mm, swap: cleanup swap cache API and add kerneldoc
Date: Sat,  6 Sep 2025 03:13:51 +0800
Message-ID: <20250905191357.78298-10-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905191357.78298-1-ryncsn@gmail.com>
References: <20250905191357.78298-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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
index 344ab106c21c..29ea56999a16 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4517,7 +4517,7 @@ static void filemap_cachestat(struct address_space *mapping,
 				 * invalidation, so there might not be
 				 * a shadow in the swapcache (yet).
 				 */
-				shadow = get_shadow_from_swap_cache(swp);
+				shadow = swap_cache_get_shadow(swp);
 				if (!shadow)
 					goto resched;
 			}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b93ab99ad3ef..922526533cd9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1199,7 +1199,7 @@ static int me_swapcache_clean(struct page_state *ps, struct page *p)
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
index a65e72edb087..8b38577a4e04 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -164,17 +164,29 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
 	return folio->swap.val == round_down(entry.val, folio_nr_pages(folio));
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
@@ -302,28 +314,22 @@ static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
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
+static inline void __swap_cache_del_folio(swp_entry_t entry, struct folio *folio, void *shadow)
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
index 367481d319cd..731b541b1d33 100644
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



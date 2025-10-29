Return-Path: <linux-kernel+bounces-876616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5998DC1BF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08B535C28AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42230346E50;
	Wed, 29 Oct 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wuh3tqtl"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D52346A06
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753549; cv=none; b=lHLfhb+dWNd9UmYjYAKCIA+gnLe1NuEBxnfUqufJUmNMg1QvCxszAJ1u4pmAGG6q88DCgYFxKeJKtku6fmd9fqxkuVHk12HYSr/c4xddEJAlScQ5VjJ1Od396b/Ie5s//7zsc2wkRsiJCaqPz+lQ5wFYnNJ+dvHCLJwo5LqkX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753549; c=relaxed/simple;
	bh=C4HNnx59ip33zop2vo9YU3h8Tqz0Rt0QbDIcaFbssQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmGv4clnrydqWoEPVMvo85Ddg3hi4wWFzhtHa+YdJNd726xRuMvaN88dpqT9HJI0b5MuBd4AB2yH+/iZ2G980zNENaXM+5781IlEbb+IObPTlt7zvLnV0GioOHsu1NJ5K1G14YVGt7oI258/RkQkjV2pVenKZ5OnXbVS53mVq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wuh3tqtl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso42316a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753547; x=1762358347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhK86G+HkMMGSPEaLHkQ5V4087sDn+TsFFEp/mH7iIA=;
        b=Wuh3tqtl3bc6mwic2+vG1uyb5wvKq5gfy9pcRscoAbt1DbkIZuZBgT98HvcplcIdsX
         zqLa046OKrQ8xAz6UFkwL7rzlXpZy4haKE60jHLnlGvYHXU1Nn4BmxR7DCo4eFr5lwKb
         +iSLuKxyuUrDpUqHTey/M7RLLmRpWrTQM6lNpFhCAAqrdZOj+VzAD5lzV7tVqxjfXzGI
         be20Kr+az+g7WGfooMz+/DV+kncuXs10kpt+u0hBkgoScNahBo1+963x79URFLzpQjkD
         OToQN/kn4Kj9JKMizwTHry3kmvqsaSkNeNBnbsvQ7x2c1MYVCjQ6Tbl9L3b2E0yjrNfW
         1Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753547; x=1762358347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhK86G+HkMMGSPEaLHkQ5V4087sDn+TsFFEp/mH7iIA=;
        b=WlejjubdL7PtKORRdq9ptFIXTVc/amZr4vHcvBp3pZIBksnDKHkp8gbY49JGZ3iD5z
         1JJa+zXBRt4vm2mg9HUToAfX2yfas8WTy4Xpp/D6H7K4lvMxajBti/xyrjkZnYF7/DtO
         gUkyV3uv8hueyh2QdEfvZ+wRTt8/exvRWMmZm8e4Be2l80AED8pOqS1Ye5o8fydVvo1A
         y6/uiHqb0lkcKkyntIiSf0uA8AyQlf8W9Hezl6jbI/syxkeoV82Ac5GCBBbSliAWYuYG
         xLbX5Yo1tvBuitr0GDsj0ErX9ysw3YBleecFb/h7qDd4SF7DCVKzRQ75n++3tc7X1wEn
         AWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqCo3bCWFK2wIXRVWhY0m/1h0ScYkqOgO9xsgKXsWJ5B70NWXJjFJqJ2FI6EjN8ihB+fb6+FAVTK/KX2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSX9eAw1iDfBjj1msInf+BdeOCBNMsBmnLzv4ZNqkX2b9Tu6E
	nCe7q1sFvA9PSWpn2YfyqSUPumVm+ifEvgaHgfetzv7ojyH4qEpi/Tzl
X-Gm-Gg: ASbGncsjE+iHLWGFKjSwqu6mTrAWvrChdFzsqfjKqhUT1atJEwW+6fVM+k0UQnRWPM7
	+x5SDCR4sxmRRIymjXnlOlE8t1BZ+A03ecgp4kYWLvJRDUEE1Yel4WyYPxsUxCjZ/EwCdgv4Tx+
	NBIw51dKwS9hdpis4meUP+CPrfkI6x6WLwxoOQqnof9ZNGFqdHfxPbCZadVNTlPXOQaE5z5ufIf
	XmRisGmp2PJsN43zptyXO/m7/Bm5V3LOmufDT4eAlyTv9UOhyAYg5L7LGDTBC4fKDr5iXY4h5Fd
	jv3gRaYcqcl8efuWTO4pycSKAgQnIJfwfIbUAfJCpzHPvaNuhaHjS9FdvecaIjBbCpmJO1ti1CK
	Csj3P9UoaIL+eVnc7kz5n5F4pTGkFjZBq0vgrdPmmzXP/JPy4i3jlXjpMtTeuCIWU2QGIgll5va
	uSdWQLLcrABA==
X-Google-Smtp-Source: AGHT+IHSchAAxtIz4UwFm8I+ff4dKglO2Nxh47GBLubgc7ZgXuU8QFpULQuCMGz4Njd/WWeyBqBAiQ==
X-Received: by 2002:a17:90b:4a08:b0:33e:2d0f:4788 with SMTP id 98e67ed59e1d1-3403a2a2323mr3784546a91.18.1761753546699;
        Wed, 29 Oct 2025 08:59:06 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:06 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:28 +0800
Subject: [PATCH 02/19] mm, swap: split swap cache preparation loop into a
 standalone helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-2-3d43f3b6ec32@tencent.com>
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

To prepare for the removal of swap cache bypass swapin, introduce a new
helper that accepts an allocated and charged fresh folio, prepares the
folio, the swap map, and then adds the folio to the swap cache.

This doesn't change how swap cache works yet, we are still depending on
the SWAP_HAS_CACHE in the swap map for synchronization. But all
synchronization hacks are now all in this single helper.

No feature change.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 197 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 109 insertions(+), 88 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 7765b9474632..d18ca765c04f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -402,6 +402,97 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
 	}
 }
 
+/**
+ * __swap_cache_prepare_and_add - Prepare the folio and add it to swap cache.
+ * @entry: swap entry to be bound to the folio.
+ * @folio: folio to be added.
+ * @gfp: memory allocation flags for charge, can be 0 if @charged if true.
+ * @charged: if the folio is already charged.
+ * @skip_if_exists: if the slot is in a cached state, return NULL.
+ *                  This is an old workaround that will be removed shortly.
+ *
+ * Update the swap_map and add folio as swap cache, typically before swapin.
+ * All swap slots covered by the folio must have a non-zero swap count.
+ *
+ * Context: Caller must protect the swap device with reference count or locks.
+ * Return: Returns the folio being added on success. Returns the existing
+ * folio if @entry is cached. Returns NULL if raced with swapin or swapoff.
+ */
+static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
+						  struct folio *folio,
+						  gfp_t gfp, bool charged,
+						  bool skip_if_exists)
+{
+	struct folio *swapcache;
+	void *shadow;
+	int ret;
+
+	/*
+	 * Check and pin the swap map with SWAP_HAS_CACHE, then add the folio
+	 * into the swap cache. Loop with a schedule delay if raced with
+	 * another process setting SWAP_HAS_CACHE. This hackish loop will
+	 * be fixed very soon.
+	 */
+	for (;;) {
+		ret = swapcache_prepare(entry, folio_nr_pages(folio));
+		if (!ret)
+			break;
+
+		/*
+		 * The skip_if_exists is for protecting against a recursive
+		 * call to this helper on the same entry waiting forever
+		 * here because SWAP_HAS_CACHE is set but the folio is not
+		 * in the swap cache yet. This can happen today if
+		 * mem_cgroup_swapin_charge_folio() below triggers reclaim
+		 * through zswap, which may call this helper again in the
+		 * writeback path.
+		 *
+		 * Large order allocation also needs special handling on
+		 * race: if a smaller folio exists in cache, swapin needs
+		 * to fallback to order 0, and doing a swap cache lookup
+		 * might return a folio that is irrelevant to the faulting
+		 * entry because @entry is aligned down. Just return NULL.
+		 */
+		if (ret != -EEXIST || skip_if_exists || folio_test_large(folio))
+			return NULL;
+
+		/*
+		 * Check the swap cache again, we can only arrive
+		 * here because swapcache_prepare returns -EEXIST.
+		 */
+		swapcache = swap_cache_get_folio(entry);
+		if (swapcache)
+			return swapcache;
+
+		/*
+		 * We might race against __swap_cache_del_folio(), and
+		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
+		 * has not yet been cleared.  Or race against another
+		 * swap_cache_alloc_folio(), which has set SWAP_HAS_CACHE
+		 * in swap_map, but not yet added its folio to swap cache.
+		 */
+		schedule_timeout_uninterruptible(1);
+	}
+
+	__folio_set_locked(folio);
+	__folio_set_swapbacked(folio);
+
+	if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, entry)) {
+		put_swap_folio(folio, entry);
+		folio_unlock(folio);
+		return NULL;
+	}
+
+	swap_cache_add_folio(folio, entry, &shadow);
+	memcg1_swapin(entry, folio_nr_pages(folio));
+	if (shadow)
+		workingset_refault(folio, shadow);
+
+	/* Caller will initiate read into locked folio */
+	folio_add_lru(folio);
+	return folio;
+}
+
 /**
  * swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
  * @entry: the swapped out swap entry to be binded to the folio.
@@ -427,99 +518,29 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
 {
 	struct swap_info_struct *si = __swap_entry_to_info(entry);
 	struct folio *folio;
-	struct folio *new_folio = NULL;
 	struct folio *result = NULL;
-	void *shadow = NULL;
 
 	*new_page_allocated = false;
-	for (;;) {
-		int err;
-
-		/*
-		 * Check the swap cache first, if a cached folio is found,
-		 * return it unlocked. The caller will lock and check it.
-		 */
-		folio = swap_cache_get_folio(entry);
-		if (folio)
-			goto got_folio;
-
-		/*
-		 * Just skip read ahead for unused swap slot.
-		 */
-		if (!swap_entry_swapped(si, entry))
-			goto put_and_return;
-
-		/*
-		 * Get a new folio to read into from swap.  Allocate it now if
-		 * new_folio not exist, before marking swap_map SWAP_HAS_CACHE,
-		 * when -EEXIST will cause any racers to loop around until we
-		 * add it to cache.
-		 */
-		if (!new_folio) {
-			new_folio = folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
-			if (!new_folio)
-				goto put_and_return;
-		}
-
-		/*
-		 * Swap entry may have been freed since our caller observed it.
-		 */
-		err = swapcache_prepare(entry, 1);
-		if (!err)
-			break;
-		else if (err != -EEXIST)
-			goto put_and_return;
-
-		/*
-		 * Protect against a recursive call to swap_cache_alloc_folio()
-		 * on the same entry waiting forever here because SWAP_HAS_CACHE
-		 * is set but the folio is not the swap cache yet. This can
-		 * happen today if mem_cgroup_swapin_charge_folio() below
-		 * triggers reclaim through zswap, which may call
-		 * swap_cache_alloc_folio() in the writeback path.
-		 */
-		if (skip_if_exists)
-			goto put_and_return;
+	/* Check the swap cache again for readahead path. */
+	folio = swap_cache_get_folio(entry);
+	if (folio)
+		return folio;
 
-		/*
-		 * We might race against __swap_cache_del_folio(), and
-		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
-		 * has not yet been cleared.  Or race against another
-		 * swap_cache_alloc_folio(), which has set SWAP_HAS_CACHE
-		 * in swap_map, but not yet added its folio to swap cache.
-		 */
-		schedule_timeout_uninterruptible(1);
-	}
-
-	/*
-	 * The swap entry is ours to swap in. Prepare the new folio.
-	 */
-	__folio_set_locked(new_folio);
-	__folio_set_swapbacked(new_folio);
-
-	if (mem_cgroup_swapin_charge_folio(new_folio, NULL, gfp_mask, entry))
-		goto fail_unlock;
-
-	swap_cache_add_folio(new_folio, entry, &shadow);
-	memcg1_swapin(entry, 1);
+	/* Skip allocation for unused swap slot for readahead path. */
+	if (!swap_entry_swapped(si, entry))
+		return NULL;
 
-	if (shadow)
-		workingset_refault(new_folio, shadow);
-
-	/* Caller will initiate read into locked new_folio */
-	folio_add_lru(new_folio);
-	*new_page_allocated = true;
-	folio = new_folio;
-got_folio:
-	result = folio;
-	goto put_and_return;
-
-fail_unlock:
-	put_swap_folio(new_folio, entry);
-	folio_unlock(new_folio);
-put_and_return:
-	if (!(*new_page_allocated) && new_folio)
-		folio_put(new_folio);
+	/* Allocate a new folio to be added into the swap cache. */
+	folio = folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
+	if (!folio)
+		return NULL;
+	/* Try add the new folio, returns existing folio or NULL on failure. */
+	result = __swap_cache_prepare_and_add(entry, folio, gfp_mask,
+					      false, skip_if_exists);
+	if (result == folio)
+		*new_page_allocated = true;
+	else
+		folio_put(folio);
 	return result;
 }
 

-- 
2.51.1



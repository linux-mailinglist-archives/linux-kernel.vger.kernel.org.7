Return-Path: <linux-kernel+bounces-876622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE446C1BE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38B1189CB04
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C1F34DCD8;
	Wed, 29 Oct 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMpEI4/S"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7E34DB59
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753573; cv=none; b=eIJaPMsXCFaSYYQdbc9+4kEr3iXe4L7nY9ln3DI/leN543Wb+tbWyYJ+jjVXCaxgB9rAYkbOmjSNxy8E5RGRIubq72ZJMd6kEHz3huHETYotqLFPRoer69czlBHXR8uq55zKtHjPL1B8Wk8szpMYnvd3g1assZv6VJU/LEe//yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753573; c=relaxed/simple;
	bh=NNs4g+7G79cPTsm+6/8/54t0N8X7gATkIrTuv/UFieU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWsX+lxkgBgAk6tgWzXO4nnV5ca1mXH7/DC5IZf/DvWt9pUkYQFMwsnq4FY8Ph7ufmEc8raP23CM+1KtA341sNiT6ep4KdFDFUeDTbWVYgS5sg8f17yHWlABForCVxwXNq++wfzFUFTowvk+LhL36neERDGNVh24LsYYbe67k40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMpEI4/S; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a4176547bfso70082b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753571; x=1762358371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//x7l/ZVG5GFT0i4YAgVrYYCeiDcBTswgh555TzkaWQ=;
        b=eMpEI4/S3Uni5g/k3OCoBN8TNZKOsqRCpM0uubnLfSKiPlYQt455K2aKmLj/tGxtDO
         csnZrYDzrz2GMT1vY30DySyt5V0wVfRuyWj5Bgf+3dCA55pO96cWXhYYi5Th/b/kDwqz
         7pgIBoKOJX82xoNeCJj2kPKTQwi1srqnvn2QxXLG1s8kBVlhFhleAHnR/y450l9RFHuQ
         75cm01adrcTlgiMGJrtucycZMi1Tw7IM66T9HqfqOnKTqTpIM2bcHOLT4cxhF2mR2RPx
         LzC3B9kj3ceQt/yFtQRxBtL0RprRcKPU2gypQRxWWscrAu+cz1+8LxTPRwylkbHPf6nP
         80ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753571; x=1762358371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//x7l/ZVG5GFT0i4YAgVrYYCeiDcBTswgh555TzkaWQ=;
        b=XSO3ANDKv14sM9OYv0am+b08quEjRjKyLibzwIZ20A4i796pS6qPxM/XoXaPzP9RBS
         0T8bB68OEWM8z8i//Oesq4YoO8WfxByhwxSGPrhp88h/gVALFrQ1ZWojiTN1ID83d/zf
         E5u+/mwwMbst4ffth6XSkAqytRwFATbCNqyY9FUb5fb4d0jkMhCv/EQLByKmvydQpb0R
         JL1MJODRHrK+ydpBLEZMSgEVwAZX4TvFp+m+VsvuPzahpyYiLWfZzz5P9Iq9nsUa1r2z
         gHrTNCcnjHrQHl99hlxJCIvuE/kaiU41fwXNYQH0w67JRxO55AD0Yf0xH4wRK5lLDQJh
         av1w==
X-Forwarded-Encrypted: i=1; AJvYcCXyjjX6XPQfxyD/Y+T1Vi0UOY/E3wMhAsRb2nPilgMMMZJ508/shzie0KUXSycKlZ8TCOnTxQ9tBu0ITSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEE2y9tUlq86Fk4v5Ga/G7ewvbZdlWBhmE1j2cDhOKxWEYufjO
	7fpiKDNyteIjcTRRAGvnASIrgydKdEaTVd3U9DImhKS8Wl24LWFE4cKh
X-Gm-Gg: ASbGnct1t8gFR0JsBXGmMWgT1jO9pjWQyAvA0HPimCSVA6lvziQiZtNnfezI1pJLOSS
	+QOYW2tnFkkkpI6nYOJpeiVy1cl99sbIZToOAaUpgctYPYgfxwa5Vx0JyHFOcDbgrlplIpPTUA5
	/FAGm2SeArAa5M/9c4MYogVyVi5DvECO0aNgQA6DMvIhUUUQWoHAt05ARKbCtE2DoKqkwDhM0Id
	RRNsRreLPs61Er3e5yz1seyIrB/hTVXQuvrwwBIHWwTHhuAomymz/cwj/YfhdbivcqOd0+dIOO8
	hokwh+YaK9gsfPPZEFovPTfwNrmmsQu3aJi5GRo+Jyw/Y+ThaBiA1ANnSRsGUrqFeik4tVrsaC+
	RbVqyqc2UiyQbfZz0adLQiTlESZPr8tRTh+WA7RoYBrYGgxUGD7kumQbU+KjXZNV1lVymcdLWD/
	zC0e7DhMKP4vGUeZgcut+U
X-Google-Smtp-Source: AGHT+IEWtY10yvvY4Cp0RzOTU6HW9O3cstRaZVUbKF1PyT4VABvIddsgFxCghFW1F8bVuzsAePb2qg==
X-Received: by 2002:a17:902:ec81:b0:268:1034:ac8b with SMTP id d9443c01a7336-294dee334b3mr41546155ad.26.1761753570876;
        Wed, 29 Oct 2025 08:59:30 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:30 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:33 +0800
Subject: [PATCH 07/19] mm/shmem: never bypass the swap cache for
 SWP_SYNCHRONOUS_IO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-7-3d43f3b6ec32@tencent.com>
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

Now the overhead of the swap cache is trivial to none, bypassing the
swap cache is no longer a valid optimization.

We have removed the cache bypass swapin for anon memory, now do the same
for shmem. Many helpers and functions can be dropped now.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c    | 65 +++++++++++++++++------------------------------------------
 mm/swap.h     |  4 ----
 mm/swapfile.c | 35 +++++++++-----------------------
 3 files changed, 27 insertions(+), 77 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6580f3cd24bb..759981435953 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2012,10 +2012,9 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 		swp_entry_t entry, int order, gfp_t gfp)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct folio *new, *swapcache;
 	int nr_pages = 1 << order;
-	struct folio *new;
 	gfp_t alloc_gfp;
-	void *shadow;
 
 	/*
 	 * We have arrived here because our zones are constrained, so don't
@@ -2055,34 +2054,19 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 		goto fallback;
 	}
 
-	/*
-	 * Prevent parallel swapin from proceeding with the swap cache flag.
-	 *
-	 * Of course there is another possible concurrent scenario as well,
-	 * that is to say, the swap cache flag of a large folio has already
-	 * been set by swapcache_prepare(), while another thread may have
-	 * already split the large swap entry stored in the shmem mapping.
-	 * In this case, shmem_add_to_page_cache() will help identify the
-	 * concurrent swapin and return -EEXIST.
-	 */
-	if (swapcache_prepare(entry, nr_pages)) {
+	swapcache = swapin_folio(entry, new);
+	if (swapcache != new) {
 		folio_put(new);
-		new = ERR_PTR(-EEXIST);
-		/* Try smaller folio to avoid cache conflict */
-		goto fallback;
+		if (!swapcache) {
+			/*
+			 * The new folio is charged already, swapin can
+			 * only fail due to another raced swapin.
+			 */
+			new = ERR_PTR(-EEXIST);
+			goto fallback;
+		}
 	}
-
-	__folio_set_locked(new);
-	__folio_set_swapbacked(new);
-	new->swap = entry;
-
-	memcg1_swapin(entry, nr_pages);
-	shadow = swap_cache_get_shadow(entry);
-	if (shadow)
-		workingset_refault(new, shadow);
-	folio_add_lru(new);
-	swap_read_folio(new, NULL);
-	return new;
+	return swapcache;
 fallback:
 	/* Order 0 swapin failed, nothing to fallback to, abort */
 	if (!order)
@@ -2172,8 +2156,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 }
 
 static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
-					 struct folio *folio, swp_entry_t swap,
-					 bool skip_swapcache)
+					 struct folio *folio, swp_entry_t swap)
 {
 	struct address_space *mapping = inode->i_mapping;
 	swp_entry_t swapin_error;
@@ -2189,8 +2172,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 
 	nr_pages = folio_nr_pages(folio);
 	folio_wait_writeback(folio);
-	if (!skip_swapcache)
-		swap_cache_del_folio(folio);
+	swap_cache_del_folio(folio);
 	/*
 	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
 	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
@@ -2289,7 +2271,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	swp_entry_t swap, index_entry;
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
-	bool skip_swapcache = false;
 	int error, nr_pages, order;
 	pgoff_t offset;
 
@@ -2332,7 +2313,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 				folio = NULL;
 				goto failed;
 			}
-			skip_swapcache = true;
 		} else {
 			/* Cached swapin only supports order 0 folio */
 			folio = shmem_swapin_cluster(swap, gfp, info, index);
@@ -2388,9 +2368,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	 * and swap cache folios are never partially freed.
 	 */
 	folio_lock(folio);
-	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
-	    shmem_confirm_swap(mapping, index, swap) < 0 ||
-	    folio->swap.val != swap.val) {
+	if (!folio_matches_swap_entry(folio, swap) ||
+	    shmem_confirm_swap(mapping, index, swap) < 0) {
 		error = -EEXIST;
 		goto unlock;
 	}
@@ -2422,12 +2401,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (sgp == SGP_WRITE)
 		folio_mark_accessed(folio);
 
-	if (skip_swapcache) {
-		folio->swap.val = 0;
-		swapcache_clear(si, swap, nr_pages);
-	} else {
-		swap_cache_del_folio(folio);
-	}
+	swap_cache_del_folio(folio);
 	folio_mark_dirty(folio);
 	swap_free_nr(swap, nr_pages);
 	put_swap_device(si);
@@ -2438,14 +2412,11 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (shmem_confirm_swap(mapping, index, swap) < 0)
 		error = -EEXIST;
 	if (error == -EIO)
-		shmem_set_folio_swapin_error(inode, index, folio, swap,
-					     skip_swapcache);
+		shmem_set_folio_swapin_error(inode, index, folio, swap);
 unlock:
 	if (folio)
 		folio_unlock(folio);
 failed_nolock:
-	if (skip_swapcache)
-		swapcache_clear(si, folio->swap, folio_nr_pages(folio));
 	if (folio)
 		folio_put(folio);
 	put_swap_device(si);
diff --git a/mm/swap.h b/mm/swap.h
index 214e7d041030..e0f05babe13a 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -403,10 +403,6 @@ static inline int swap_writeout(struct folio *folio,
 	return 0;
 }
 
-static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
-{
-}
-
 static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
 {
 	return NULL;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 849be32377d9..3898c3a2be62 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1613,22 +1613,6 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
-static void swap_entries_put_cache(struct swap_info_struct *si,
-				   swp_entry_t entry, int nr)
-{
-	unsigned long offset = swp_offset(entry);
-	struct swap_cluster_info *ci;
-
-	ci = swap_cluster_lock(si, offset);
-	if (swap_only_has_cache(si, offset, nr)) {
-		swap_entries_free(si, ci, entry, nr);
-	} else {
-		for (int i = 0; i < nr; i++, entry.val++)
-			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
-	}
-	swap_cluster_unlock(ci);
-}
-
 static bool swap_entries_put_map(struct swap_info_struct *si,
 				 swp_entry_t entry, int nr)
 {
@@ -1764,13 +1748,21 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
 	struct swap_info_struct *si;
+	struct swap_cluster_info *ci;
+	unsigned long offset = swp_offset(entry);
 	int size = 1 << swap_entry_order(folio_order(folio));
 
 	si = _swap_info_get(entry);
 	if (!si)
 		return;
 
-	swap_entries_put_cache(si, entry, size);
+	ci = swap_cluster_lock(si, offset);
+	if (swap_only_has_cache(si, offset, size))
+		swap_entries_free(si, ci, entry, size);
+	else
+		for (int i = 0; i < size; i++, entry.val++)
+			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
+	swap_cluster_unlock(ci);
 }
 
 int __swap_count(swp_entry_t entry)
@@ -3778,15 +3770,6 @@ int swapcache_prepare(swp_entry_t entry, int nr)
 	return __swap_duplicate(entry, SWAP_HAS_CACHE, nr);
 }
 
-/*
- * Caller should ensure entries belong to the same folio so
- * the entries won't span cross cluster boundary.
- */
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
-{
-	swap_entries_put_cache(si, entry, nr);
-}
-
 /*
  * add_swap_count_continuation - called when a swap count is duplicated
  * beyond SWAP_MAP_MAX, it allocates a new page and links that to the entry's

-- 
2.51.1



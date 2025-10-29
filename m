Return-Path: <linux-kernel+bounces-876631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F40C1BE83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCBB189FB52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F11534A3AA;
	Wed, 29 Oct 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atMskfNA"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739502ECE9B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753617; cv=none; b=BqDsThyxH4b2dOIMPd2gDN+nWgmeT8sNJQOU7ev21HY7OjFTcJHmw4QSApuwlMwtDbJY1u5gJWQMDhdVPsi9aI3Myc9O3VTBNfm0GPDdSF+YR1dhlIMOOSDnBZ8GxZzVfLKNrzpiBeqxIkqAqjss0wfpyPWgt2F7Lx0jutkF5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753617; c=relaxed/simple;
	bh=8Cy65yUBycdypGydFeuJoL8OWFxHeEQ49FZio9knumo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJw4WJ3ei0s24L6C/kDKNHrYewHGEaIMMN2lacsMeZe3ASPFK4dtxjzlC+lLEtC1eGiLhHab3VV9HGY6SjT9EPhjhHVYAJskIjXeErxf5mCMK8dzO1Gys6J8vscnQy0WMya/XE1QcRXVDMGMRahpeLoCe4bqrkAfam27rkos6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atMskfNA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781997d195aso53739b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753615; x=1762358415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8nOl+SU4PPYP3fCDuFL6r8khIpsm6yNyf/3hVmtV4SM=;
        b=atMskfNA3Z5y/lgIXhXR8lg/WEkwPK8h5gh/C6zbqNrB0SVsyYLJoBsrMbDnijKf/p
         qzARzXDkkG2JC+dcMjlbYxuwTSlKPHhALsUZpCgQozJk1sJWyQ7OAuWlbtTO8It7AigH
         XFzWx+WbRoym3PlL+IENq6ghKtg3ynleZUrHbP0GWq8Ca+Vk5yT2TwipKldpFHIUpcXr
         f1LylYhThPvSuALI3GlG58l23PPS8SHwepZGzROyDaVc5g/DEcnp5gb0fxgpput5+hDh
         k00ULpiYpEHhhZKuEUVyTnAAXHIIVRbixI7Zx159W0tXKGos7r21qNqITSOb0LYSmNr8
         wrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753615; x=1762358415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nOl+SU4PPYP3fCDuFL6r8khIpsm6yNyf/3hVmtV4SM=;
        b=ckezyRmlvIahYGUwj7q0hOMz9ElBU+xM/TWbbLadvwh8X3Pj95VtJXQF7z2GhHw4RG
         n3exTkEEs8YCZXMRuvO3eZZsDXvfm9eiecbXFbiaENuvizOpGvMoujcz/nR9IXOMk/HY
         +5vaVZyUayDze2g0svLX/03UG5N3UoVumS9LwHJFsMKDLfok/PlTsBYUDSv7NbARo7OS
         do1DYY04IZ6HPQLgNQQRrOoZ90w8n1GcUJqOfx3vlW65/Wp1BIdLIMFi9N+N1GOEwi3B
         3zA/RVA8tUX8X1Xd115Zg6kgOPYXbn46FH826LaZz+ZKJx3qUdvdg3lIk/Oug5WKy8ud
         tCkA==
X-Forwarded-Encrypted: i=1; AJvYcCWBf+kXIpinH2kkbvm2hBoAZ8rVmBNU4ke7TNvuSMzmkpGLNAIri+vrYuZ9AoGOzs+8jlY3Yj0Hhwqrc+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyx4Q0gKoKsepS/BZeop0uq5bjo2pdpLFsTQFML6DfHHhB73+G
	k0E5oovVUi5RHNJ+mSSfqQuKHeShPryNwvtcV6nIeQ53d8ZzgwOpRh2k
X-Gm-Gg: ASbGncvDf+p+n1BVUoB3+3lwWakCNcjNLzjHFJBe+IWMkG+cLJ8AfwlLFLeoPwaJ12p
	kOJrEi8yVCKCQvUu5IOFepXKeXQ1jTORDtEhs0mJBV5/P5n8zisk++G4+Berxnt6D5InZz0lRvQ
	yUoAxfHI5de4vw/pYb4her744lutzn2uMKx9XoAUd1PNaI9gb6rk5hw6PiporF+hcdlLbkLQgMO
	kBFNU06TBXN0xOe+Q4xrUUHv5IQBwza8PxangPRevHvQws0P0C0jHngnkaK/6vPbCvM0qzAiJEU
	mSS0BYA0RW8DdkmLJLuSLdnnwhkm2rnvqAQDreSAy070AkuD1pqTr8owgm6mxj9l/p0vdQ9yYO4
	LS5R2DiWj4rgfrOQ78Z3/srRvomOeX3tggdkqr0kBT98YnjLBwaAdUN/bW2Oebr9j73Wif5qPva
	3D6l7RQ/MLG5YMsmgzT7Wr
X-Google-Smtp-Source: AGHT+IEdDsTYIcn1GU0ePW/OQ5eneMt6fHxiUdQrsAB+BibqdhzsnSDNaoYabLh0JhIuhC4B204MNA==
X-Received: by 2002:a17:90b:1dcc:b0:32e:4924:690f with SMTP id 98e67ed59e1d1-3403a143773mr3962982a91.6.1761753614344;
        Wed, 29 Oct 2025 09:00:14 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:00:13 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:42 +0800
Subject: [PATCH 16/19] mm, swap: check swap table directly for checking
 cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-16-3d43f3b6ec32@tencent.com>
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

Instead of looking at the swap map, check swap table directly to tell
if a swap slot is cached. Prepares for the removal of SWAP_HAS_CACHE.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h        | 11 ++++++++---
 mm/swap_state.c  | 16 ++++++++++++++++
 mm/swapfile.c    | 55 +++++++++++++++++++++++++++++--------------------------
 mm/userfaultfd.c | 10 +++-------
 4 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 03694ffa662f..73f07bcea5f0 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -275,6 +275,7 @@ void __swapcache_clear_cached(struct swap_info_struct *si,
  *   swap entries in the page table, similar to locking swap cache folio.
  * - See the comment of get_swap_device() for more complex usage.
  */
+bool swap_cache_check_folio(swp_entry_t entry);
 struct folio *swap_cache_get_folio(swp_entry_t entry);
 void *swap_cache_get_shadow(swp_entry_t entry);
 void swap_cache_del_folio(struct folio *folio);
@@ -335,8 +336,6 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 
 static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 {
-	struct swap_info_struct *si = __swap_entry_to_info(entry);
-	pgoff_t offset = swp_offset(entry);
 	int i;
 
 	/*
@@ -345,8 +344,9 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 	 * be in conflict with the folio in swap cache.
 	 */
 	for (i = 0; i < max_nr; i++) {
-		if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
+		if (swap_cache_check_folio(entry))
 			return i;
+		entry.val++;
 	}
 
 	return i;
@@ -449,6 +449,11 @@ static inline int swap_writeout(struct folio *folio,
 	return 0;
 }
 
+static inline bool swap_cache_check_folio(swp_entry_t entry)
+{
+	return false;
+}
+
 static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
 {
 	return NULL;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 85d9f99c384f..41d4fa056203 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -103,6 +103,22 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)
 	return NULL;
 }
 
+/**
+ * swap_cache_check_folio - Check if a swap slot has cache.
+ * @entry: swap entry indicating the slot.
+ *
+ * Context: Caller must ensure @entry is valid and protect the swap
+ * device with reference count or locks.
+ */
+bool swap_cache_check_folio(swp_entry_t entry)
+{
+	unsigned long swp_tb;
+
+	swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
+				swp_cluster_offset(entry));
+	return swp_tb_is_folio(swp_tb);
+}
+
 /**
  * swap_cache_get_shadow - Looks up a shadow in the swap cache.
  * @entry: swap entry used for the lookup.
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8d98f28907bc..3b7df5768d7f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -788,23 +788,18 @@ static unsigned int cluster_reclaim_range(struct swap_info_struct *si,
 	unsigned int nr_pages = 1 << order;
 	unsigned long offset = start, end = start + nr_pages;
 	unsigned char *map = si->swap_map;
-	int nr_reclaim;
+	unsigned long swp_tb;
 
 	spin_unlock(&ci->lock);
 	do {
-		switch (READ_ONCE(map[offset])) {
-		case 0:
+		if (swap_count(READ_ONCE(map[offset])))
 			break;
-		case SWAP_HAS_CACHE:
-			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
-			if (nr_reclaim < 0)
-				goto out;
-			break;
-		default:
-			goto out;
+		swp_tb = swap_table_get(ci, offset % SWAPFILE_CLUSTER);
+		if (swp_tb_is_folio(swp_tb)) {
+			if (__try_to_reclaim_swap(si, offset, TTRS_ANYWAY) < 0)
+				break;
 		}
 	} while (++offset < end);
-out:
 	spin_lock(&ci->lock);
 
 	/*
@@ -820,37 +815,41 @@ static unsigned int cluster_reclaim_range(struct swap_info_struct *si,
 	 * Recheck the range no matter reclaim succeeded or not, the slot
 	 * could have been be freed while we are not holding the lock.
 	 */
-	for (offset = start; offset < end; offset++)
-		if (READ_ONCE(map[offset]))
+	for (offset = start; offset < end; offset++) {
+		swp_tb = __swap_table_get(ci, offset % SWAPFILE_CLUSTER);
+		if (swap_count(map[offset]) || !swp_tb_is_null(swp_tb))
 			return SWAP_ENTRY_INVALID;
+	}
 
 	return start;
 }
 
 static bool cluster_scan_range(struct swap_info_struct *si,
 			       struct swap_cluster_info *ci,
-			       unsigned long start, unsigned int nr_pages,
+			       unsigned long offset, unsigned int nr_pages,
 			       bool *need_reclaim)
 {
-	unsigned long offset, end = start + nr_pages;
+	unsigned long end = offset + nr_pages;
 	unsigned char *map = si->swap_map;
+	unsigned long swp_tb;
 
 	if (cluster_is_empty(ci))
 		return true;
 
-	for (offset = start; offset < end; offset++) {
-		switch (READ_ONCE(map[offset])) {
-		case 0:
-			continue;
-		case SWAP_HAS_CACHE:
+	do {
+		if (swap_count(map[offset]))
+			return false;
+		swp_tb = __swap_table_get(ci, offset % SWAPFILE_CLUSTER);
+		if (swp_tb_is_folio(swp_tb)) {
+			WARN_ON_ONCE(!(map[offset] & SWAP_HAS_CACHE));
 			if (!vm_swap_full())
 				return false;
 			*need_reclaim = true;
-			continue;
-		default:
-			return false;
+		} else {
+			/* A entry with no count and no cache must be null */
+			VM_WARN_ON_ONCE(!swp_tb_is_null(swp_tb));
 		}
-	}
+	} while (++offset < end);
 
 	return true;
 }
@@ -1013,7 +1012,8 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 		to_scan--;
 
 		while (offset < end) {
-			if (READ_ONCE(map[offset]) == SWAP_HAS_CACHE) {
+			if (!swap_count(READ_ONCE(map[offset])) &&
+			    swp_tb_is_folio(__swap_table_get(ci, offset % SWAPFILE_CLUSTER))) {
 				spin_unlock(&ci->lock);
 				nr_reclaim = __try_to_reclaim_swap(si, offset,
 								   TTRS_ANYWAY);
@@ -1957,6 +1957,7 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
 	struct swap_info_struct *si;
 	bool any_only_cache = false;
 	unsigned long offset;
+	unsigned long swp_tb;
 
 	si = get_swap_device(entry);
 	if (WARN_ON_ONCE(!si))
@@ -1981,7 +1982,9 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
 	 */
 	for (offset = start_offset; offset < end_offset; offset += nr) {
 		nr = 1;
-		if (READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
+		swp_tb = swap_table_get(__swap_offset_to_cluster(si, offset),
+					offset % SWAPFILE_CLUSTER);
+		if (!swap_count(READ_ONCE(si->swap_map[offset])) && swp_tb_is_folio(swp_tb)) {
 			/*
 			 * Folios are always naturally aligned in swap so
 			 * advance forward to the next boundary. Zero means no
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 00122f42718c..5411fd340ac3 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1184,17 +1184,13 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 		 * Check if the swap entry is cached after acquiring the src_pte
 		 * lock. Otherwise, we might miss a newly loaded swap cache folio.
 		 *
-		 * Check swap_map directly to minimize overhead, READ_ONCE is sufficient.
 		 * We are trying to catch newly added swap cache, the only possible case is
 		 * when a folio is swapped in and out again staying in swap cache, using the
 		 * same entry before the PTE check above. The PTL is acquired and released
-		 * twice, each time after updating the swap_map's flag. So holding
-		 * the PTL here ensures we see the updated value. False positive is possible,
-		 * e.g. SWP_SYNCHRONOUS_IO swapin may set the flag without touching the
-		 * cache, or during the tiny synchronization window between swap cache and
-		 * swap_map, but it will be gone very quickly, worst result is retry jitters.
+		 * twice, each time after updating the swap table. So holding
+		 * the PTL here ensures we see the updated value.
 		 */
-		if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE) {
+		if (swap_cache_check_folio(entry)) {
 			double_pt_unlock(dst_ptl, src_ptl);
 			return -EAGAIN;
 		}

-- 
2.51.1



Return-Path: <linux-kernel+bounces-876632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AEEC1C262
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74269807FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C032C94A;
	Wed, 29 Oct 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj4qSBkD"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505934AB06
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753622; cv=none; b=Npf4U3/DPypyLvFNOw4DLCxhmBtnZLvpqZtw0knb0OfG4SqXfLBb7FrvgUABV3ixWCOhHjO+H/pWoVL21wtdPSwLEoT7DK11BwLDorjUV0rISITAo6D3ldg+cr79qxz28lHjnTDzR9PeZ1uFsbhdo9+p6Iez+/fDGQ05/MIn+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753622; c=relaxed/simple;
	bh=SBcMbXsf3YpRjcnepEnmkt7v+J8flPyweFFgb9xT/9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuhZfEGih7zr4hN8kihhBhz3ppzkW4trh+4tr5wqGuSs6UoEEvi3P+FzkBdWgKRFaxFssLUQIpjQb5f8+fryuO3osmN22HwoMhvCfT90NGUJ2tTbykFskn8+uJ1GUd/ppZvuknNNewD558AJyYUqgT0vN8WPWdNPLlP3lT+M044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj4qSBkD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290cd62acc3so82793115ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753620; x=1762358420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zoVrXsn7rvX5B7PiDhrEJ9ULAwxtbalHy9W90Ojrs4=;
        b=Mj4qSBkDRWkbeK8pV7uVy050xalFC7lfoxzqinf2vxb+UU3ReJME9sEqwV2E0Rw9Ad
         V8lVNk3hvtYNqQOJqQ7GCrSTFy/3W/csWAfd4P8S5BEyVUayJPfXUeo+m/Fipc+7lcYp
         9W0ops1PSBpLs0SMPGCdJUKx5zUh8Odi4sOSA66UWr8aADbIaIvvXikS6PJnK9hrRXLI
         eHrkOMdz7WLoeZcPyaxh1elfGtrKsZQ7UsEHDG+Wy8+3ZR6G9f1cTvvXi144sS+yE7WZ
         MD2tT+WJUm2vqGTUWH4qDrIwuPQkr6AXQoXtTrQPjfhxAqq4mBoi3XAFqGoA1b3Sm0HT
         Jkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753620; x=1762358420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zoVrXsn7rvX5B7PiDhrEJ9ULAwxtbalHy9W90Ojrs4=;
        b=TB/zFpltkZUue9xL55xTiQVSlA/sK1NIgrzgB8IgnDgMWFSHCEjLDGsHgzCHV1IXr6
         Xh3q2bZI1s2JvnqAADefB7RAPr0Fo7nqURiDxsExCgBmCTxJuFzUioZCZ/MQHFOL6kP1
         tzvCEW6ww1kkhm4DowyEfBcpOSXza7RVT76+YOi2Bzv3TDp1aOWDwEuv2MPFZ5ZIIL0p
         GmbOP3xcK4isETUX0e8EJ6OcKS85ZBiwvHZDP4a/6Ope+VqTlR4Iys56L4kzVROivQQf
         VeFeSPK8WXhH+ESa7XR83nE+JxZgAXcuIoDB4nD+4p5mYgM9JzALby8aKLyRbWFDTBRO
         J13g==
X-Forwarded-Encrypted: i=1; AJvYcCVYmRC8o/Nwy95qqe+svrkbLqYo/yLkxgxfgD+MaMrpxkoZ+W7XK96t6UrX6THgxE2ZaEicxL1XHWUg6wA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyu0WsBppZLy3sGX2f0897DmAwzXugNdGQBA4s3VALhSv6vxsX
	PeGYfNfr2aDLCSxxErCaZ3z10fWMjGi+Dy4eHuMRaXcHNwwwoybgnk+v
X-Gm-Gg: ASbGncttRr4IA9YND6mfk4T8k/lNrDP7zb2HMwBcIkvElYQSrXraKlseBwjb1PN2M+h
	5bL4DAwhO/1cIPBf2W42yNX0NBP30ucue1szTP3aRcyrbfHJGCsgmIiOqkMcMbs5okx1Eikers3
	X9PjgdyFfWRsPBTdZIB2ycnymzMptHtOm3JT7TmLvMVjW7xfNq0khtxNZKn2Iq/ONb4kQuPXkqX
	0BhorvDrHsvxS4kkfYnLJGh+2MBcKozidfJHfI0eOhR1NtIbKBSfvNYilw1COIR1kQUw/Dw/OEn
	XKMuilFLvz4/+ZBqSq7Am/hQiNYNriZnxvpiwMNtBWgV5UUmvXX6BZEcGe4UAv/qXwVSvOI34cl
	YPOvFOHl0SisGXqCBA+0POdGeuAYi37GvtAx9q0HKcwBnHw19PjSNSZjfmJPj2nKWQr0dhLEcyU
	6buheN53fXj1Bq1d7DPIWgoqM0JuIE/9c=
X-Google-Smtp-Source: AGHT+IHuvrF0Tu5VI3bO4fs+LvM+8CgRisU1xPC+GDqoRvkRBpcU82/x1EVGEJmBaKM2vuBkXY2ETw==
X-Received: by 2002:a17:902:ea0c:b0:294:9919:b29f with SMTP id d9443c01a7336-294def471f3mr45839805ad.58.1761753619498;
        Wed, 29 Oct 2025 09:00:19 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.09.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:00:18 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:43 +0800
Subject: [PATCH 17/19] mm, swap: clean up and improve swap entries freeing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-17-3d43f3b6ec32@tencent.com>
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

There are a few problems with the current freeing of swap entries.

When freeing a set of swap entries directly (swap_put_entries_direct,
typically from zapping the page table), it scans the whole swap region
multiple times. First, it scans the whole region to check if it can be
batch freed and if there is any cached folio. Then do a batch free only
if the whole region's swap count equals 1. And if any entry is cached,
even if only one, it will have to walk the whole region again to clean
up the cache.

And if any entry is not in a consistent status with other entries, it
will fall back to order 0 freeing. For example, if only one of them is
cached, the batch free will fall back.

And the current batch freeing workflow relies on the swap map's
SWAP_HAS_CACHE bit for both continuous checking and batch freeing, which
isn't compatible with the swap table design.

Tidy this up, introduce a new cluster scoped helper for all swap entry
freeing job. It will batch frees all continuous entries, and just start
a new batch if any inconsistent entry is found. This may improve the
batch size when the clusters are fragmented. This should also be more
robust with more sanity checks, and make it clear that a slot pinned by
swap cache will be cleared upon cache reclaim.

And the cache reclaim scan is also now limited to each cluster. If a
cluster has any clean swap cache left after putting the swap count,
reclaim the cluster only instead of the whole region.

And since a folio's entries are always in the same cluster, putting swap
entries from a folio can also use the new helper directly.

This should be both an optimization and a cleanup, and the new helper is
adapted to the swap table.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 238 +++++++++++++++++++++++-----------------------------------
 1 file changed, 96 insertions(+), 142 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3b7df5768d7f..12a1ab6f7b32 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -55,12 +55,14 @@ static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 static void free_swap_count_continuations(struct swap_info_struct *);
 static void swap_entries_free(struct swap_info_struct *si,
 			      struct swap_cluster_info *ci,
-			      swp_entry_t entry, unsigned int nr_pages);
+			      unsigned long start, unsigned int nr_pages);
 static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries);
 static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr);
-static bool swap_entries_put_map(struct swap_info_struct *si,
-				 swp_entry_t entry, int nr);
+static void swap_put_entry_locked(struct swap_info_struct *si,
+				  struct swap_cluster_info *ci,
+				  unsigned long offset,
+				  unsigned char usage);
 static bool folio_swapcache_freeable(struct folio *folio);
 static void move_cluster(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci, struct list_head *list,
@@ -197,25 +199,6 @@ static bool swap_only_has_cache(struct swap_info_struct *si,
 	return true;
 }
 
-static bool swap_is_last_map(struct swap_info_struct *si,
-		unsigned long offset, int nr_pages, bool *has_cache)
-{
-	unsigned char *map = si->swap_map + offset;
-	unsigned char *map_end = map + nr_pages;
-	unsigned char count = *map;
-
-	if (swap_count(count) != 1)
-		return false;
-
-	while (++map < map_end) {
-		if (*map != count)
-			return false;
-	}
-
-	*has_cache = !!(count & SWAP_HAS_CACHE);
-	return true;
-}
-
 /*
  * returns number of pages in the folio that backs the swap entry. If positive,
  * the folio was reclaimed. If negative, the folio was not reclaimed. If 0, no
@@ -1420,6 +1403,76 @@ static bool swap_sync_discard(void)
 	return false;
 }
 
+/**
+ * swap_put_entries_cluster - Decrease the swap count of a set of slots.
+ * @si: The swap device.
+ * @start: start offset of slots.
+ * @nr: number of slots.
+ * @reclaim_cache: if true, also reclaim the swap cache.
+ *
+ * This helper decreases the swap count of a set of slots and tries to
+ * batch free them. Also reclaims the swap cache if @reclaim_cache is true.
+ * Context: The caller must ensure that all slots belong to the same
+ * cluster and their swap count doesn't go underflow.
+ */
+static void swap_put_entries_cluster(struct swap_info_struct *si,
+				     unsigned long start, int nr,
+				     bool reclaim_cache)
+{
+	unsigned long offset = start, end = start + nr;
+	unsigned long batch_start = SWAP_ENTRY_INVALID;
+	struct swap_cluster_info *ci;
+	bool need_reclaim = false;
+	unsigned int nr_reclaimed;
+	unsigned long swp_tb;
+	unsigned int count;
+
+	ci = swap_cluster_lock(si, offset);
+	do {
+		swp_tb = __swap_table_get(ci, offset % SWAPFILE_CLUSTER);
+		count = si->swap_map[offset];
+		VM_WARN_ON(swap_count(count) < 1 || count == SWAP_MAP_BAD);
+		if (swap_count(count) == 1) {
+			/* count == 1 and non-cached slots will be batch freed. */
+			if (!swp_tb_is_folio(swp_tb)) {
+				if (!batch_start)
+					batch_start = offset;
+				continue;
+			}
+			/* count will be 0 after put, slot can be reclaimed */
+			VM_WARN_ON(!(count & SWAP_HAS_CACHE));
+			need_reclaim = true;
+		}
+		/*
+		 * A count != 1 or cached slot can't be freed. Put its swap
+		 * count and then free the interrupted pending batch. Cached
+		 * slots will be freed when folio is removed from swap cache
+		 * (__swap_cache_del_folio).
+		 */
+		swap_put_entry_locked(si, ci, offset, 1);
+		if (batch_start) {
+			swap_entries_free(si, ci, batch_start, offset - batch_start);
+			batch_start = SWAP_ENTRY_INVALID;
+		}
+	} while (++offset < end);
+
+	if (batch_start)
+		swap_entries_free(si, ci, batch_start, offset - batch_start);
+	swap_cluster_unlock(ci);
+
+	if (!need_reclaim || !reclaim_cache)
+		return;
+
+	offset = start;
+	do {
+		nr_reclaimed = __try_to_reclaim_swap(si, offset,
+						     TTRS_UNMAPPED | TTRS_FULL);
+		offset++;
+		if (nr_reclaimed)
+			offset = round_up(offset, abs(nr_reclaimed));
+	} while (offset < end);
+}
+
 /**
  * folio_alloc_swap - allocate swap space for a folio
  * @folio: folio we want to move to swap
@@ -1521,6 +1574,7 @@ void folio_put_swap(struct folio *folio, struct page *subpage)
 {
 	swp_entry_t entry = folio->swap;
 	unsigned long nr_pages = folio_nr_pages(folio);
+	struct swap_info_struct *si = __swap_entry_to_info(entry);
 
 	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_swapcache(folio), folio);
@@ -1530,7 +1584,7 @@ void folio_put_swap(struct folio *folio, struct page *subpage)
 		nr_pages = 1;
 	}
 
-	swap_entries_put_map(__swap_entry_to_info(entry), entry, nr_pages);
+	swap_put_entries_cluster(si, swp_offset(entry), nr_pages, false);
 }
 
 static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
@@ -1567,12 +1621,11 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 	return NULL;
 }
 
-static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
-					   struct swap_cluster_info *ci,
-					   swp_entry_t entry,
-					   unsigned char usage)
+static void swap_put_entry_locked(struct swap_info_struct *si,
+				  struct swap_cluster_info *ci,
+				  unsigned long offset,
+				  unsigned char usage)
 {
-	unsigned long offset = swp_offset(entry);
 	unsigned char count;
 	unsigned char has_cache;
 
@@ -1598,9 +1651,7 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
 	if (usage)
 		WRITE_ONCE(si->swap_map[offset], usage);
 	else
-		swap_entries_free(si, ci, entry, 1);
-
-	return usage;
+		swap_entries_free(si, ci, offset, 1);
 }
 
 /*
@@ -1668,70 +1719,6 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
-static bool swap_entries_put_map(struct swap_info_struct *si,
-				 swp_entry_t entry, int nr)
-{
-	unsigned long offset = swp_offset(entry);
-	struct swap_cluster_info *ci;
-	bool has_cache = false;
-	unsigned char count;
-	int i;
-
-	if (nr <= 1)
-		goto fallback;
-	count = swap_count(data_race(si->swap_map[offset]));
-	if (count != 1)
-		goto fallback;
-
-	ci = swap_cluster_lock(si, offset);
-	if (!swap_is_last_map(si, offset, nr, &has_cache)) {
-		goto locked_fallback;
-	}
-	if (!has_cache)
-		swap_entries_free(si, ci, entry, nr);
-	else
-		for (i = 0; i < nr; i++)
-			WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
-	swap_cluster_unlock(ci);
-
-	return has_cache;
-
-fallback:
-	ci = swap_cluster_lock(si, offset);
-locked_fallback:
-	for (i = 0; i < nr; i++, entry.val++) {
-		count = swap_entry_put_locked(si, ci, entry, 1);
-		if (count == SWAP_HAS_CACHE)
-			has_cache = true;
-	}
-	swap_cluster_unlock(ci);
-	return has_cache;
-}
-
-/*
- * Only functions with "_nr" suffix are able to free entries spanning
- * cross multi clusters, so ensure the range is within a single cluster
- * when freeing entries with functions without "_nr" suffix.
- */
-static bool swap_entries_put_map_nr(struct swap_info_struct *si,
-				    swp_entry_t entry, int nr)
-{
-	int cluster_nr, cluster_rest;
-	unsigned long offset = swp_offset(entry);
-	bool has_cache = false;
-
-	cluster_rest = SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER;
-	while (nr) {
-		cluster_nr = min(nr, cluster_rest);
-		has_cache |= swap_entries_put_map(si, entry, cluster_nr);
-		cluster_rest = SWAPFILE_CLUSTER;
-		nr -= cluster_nr;
-		entry.val += cluster_nr;
-	}
-
-	return has_cache;
-}
-
 /*
  * Check if it's the last ref of swap entry in the freeing path.
  */
@@ -1746,9 +1733,9 @@ static inline bool __maybe_unused swap_is_last_ref(unsigned char count)
  */
 static void swap_entries_free(struct swap_info_struct *si,
 			      struct swap_cluster_info *ci,
-			      swp_entry_t entry, unsigned int nr_pages)
+			      unsigned long offset, unsigned int nr_pages)
 {
-	unsigned long offset = swp_offset(entry);
+	swp_entry_t entry = swp_entry(si->type, offset);
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
 
@@ -1954,10 +1941,8 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
 {
 	const unsigned long start_offset = swp_offset(entry);
 	const unsigned long end_offset = start_offset + nr;
+	unsigned long offset, cluster_end;
 	struct swap_info_struct *si;
-	bool any_only_cache = false;
-	unsigned long offset;
-	unsigned long swp_tb;
 
 	si = get_swap_device(entry);
 	if (WARN_ON_ONCE(!si))
@@ -1965,44 +1950,13 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
 	if (WARN_ON_ONCE(end_offset > si->max))
 		goto out;
 
-	/*
-	 * First free all entries in the range.
-	 */
-	any_only_cache = swap_entries_put_map_nr(si, entry, nr);
-
-	/*
-	 * Short-circuit the below loop if none of the entries had their
-	 * reference drop to zero.
-	 */
-	if (!any_only_cache)
-		goto out;
-
-	/*
-	 * Now go back over the range trying to reclaim the swap cache.
-	 */
-	for (offset = start_offset; offset < end_offset; offset += nr) {
-		nr = 1;
-		swp_tb = swap_table_get(__swap_offset_to_cluster(si, offset),
-					offset % SWAPFILE_CLUSTER);
-		if (!swap_count(READ_ONCE(si->swap_map[offset])) && swp_tb_is_folio(swp_tb)) {
-			/*
-			 * Folios are always naturally aligned in swap so
-			 * advance forward to the next boundary. Zero means no
-			 * folio was found for the swap entry, so advance by 1
-			 * in this case. Negative value means folio was found
-			 * but could not be reclaimed. Here we can still advance
-			 * to the next boundary.
-			 */
-			nr = __try_to_reclaim_swap(si, offset,
-						   TTRS_UNMAPPED | TTRS_FULL);
-			if (nr == 0)
-				nr = 1;
-			else if (nr < 0)
-				nr = -nr;
-			nr = ALIGN(offset + 1, nr) - offset;
-		}
-	}
-
+	/* Put entries and reclaim cache in each cluster */
+	offset = start_offset;
+	do {
+		cluster_end = min(round_up(offset + 1, SWAPFILE_CLUSTER), end_offset);
+		swap_put_entries_cluster(si, offset, cluster_end - offset, true);
+		offset = cluster_end;
+	} while (offset < end_offset);
 out:
 	put_swap_device(si);
 }
@@ -2051,7 +2005,7 @@ void swap_free_hibernation_slot(swp_entry_t entry)
 		return;
 
 	ci = swap_cluster_lock(si, offset);
-	swap_entry_put_locked(si, ci, entry, 1);
+	swap_put_entry_locked(si, ci, offset, 1);
 	WARN_ON(swap_entry_swapped(si, offset));
 	swap_cluster_unlock(ci);
 
@@ -3799,10 +3753,10 @@ void __swapcache_clear_cached(struct swap_info_struct *si,
 			      swp_entry_t entry, unsigned int nr)
 {
 	if (swap_only_has_cache(si, swp_offset(entry), nr)) {
-		swap_entries_free(si, ci, entry, nr);
+		swap_entries_free(si, ci, swp_offset(entry), nr);
 	} else {
 		for (int i = 0; i < nr; i++, entry.val++)
-			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
+			swap_put_entry_locked(si, ci, swp_offset(entry), SWAP_HAS_CACHE);
 	}
 }
 
@@ -3923,7 +3877,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
  * into, carry if so, or else fail until a new continuation page is allocated;
  * when the original swap_map count is decremented from 0 with continuation,
  * borrow from the continuation and report whether it still holds more.
- * Called while __swap_duplicate() or caller of swap_entry_put_locked()
+ * Called while __swap_duplicate() or caller of swap_put_entry_locked()
  * holds cluster lock.
  */
 static bool swap_count_continued(struct swap_info_struct *si,

-- 
2.51.1



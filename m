Return-Path: <linux-kernel+bounces-876634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC40C1C551
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D50623A34
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A54351FD7;
	Wed, 29 Oct 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpLHuXN7"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C363329C52
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753632; cv=none; b=gnh7bUgvn4tkI7cdA8WccPJXYOuLIDXm8AzZN/YrhvgO/hFYv/w5QtoOPCCEgMXxVas7YHAbKw9fVkY0oBOtZyTwkloTH6Dqf/HIOUETWaui161Mr2MzTXwRpdE/x5/t6+yBBRuIBp4n/5Vp0/sWrf9qM7HPEcd3gXdnJFzJyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753632; c=relaxed/simple;
	bh=IkoUZKVm/dcdG0tdShD1YcTPNdqbWnFEuLXBvvHL70w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T6mOaAuZDlDuJaPh04LAYu9Znefv7MM3VwWV0uihKwzsFmvdtwTJDyt6FLsqJwaWRKZouX8SaeE2FCwVRtq3mcKiUUwe4l/1vgWEcir0Qx93lMKkNVM7B/CWWvIB6Ip5ALlNWZvh4tYjSERWfTva3RMbtsomGea5Kf+1atQZKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpLHuXN7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so39376a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753629; x=1762358429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=js7VbMzO/PyCsGbnIWOZ2XRn9F05cVP9JsAjpW1ZYIc=;
        b=CpLHuXN7T9fhpc/gZhEI5M2X+By1amyIeFTN0Lt6oLV2lUzOAY14V1niWkiHhMHB3E
         AsjVtpabjEBC77m9aNpMJ2/+FhVBeXkIVLciNzSbW0byYZoheqKJJmpm7gM7EQrWtbOx
         axmf9bskUp4oUZuJfn7iflwo+/rUJH2gp7BwAw76QB4hB/NpiVXXNQOdd7u51BCtJJO0
         jcvP8WMN2rMGSxBFyeWYyIOokppP6j+Zvrf04aRLapYCfEdRWQImyXK0GTh7SdHhW693
         StU2UtL/CDina5CMk69nTagCheU0dZSaZ6JgvdilWYVlJRID0j4ciq8l5huUttzcZJVr
         bgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753629; x=1762358429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js7VbMzO/PyCsGbnIWOZ2XRn9F05cVP9JsAjpW1ZYIc=;
        b=jzQE/SPScU3D1JtW5BQzftNUwnI62D8+O4lIYxo2g+WoCLeR7XcwvSTvLHY3DYIic8
         OF/bpMAC5Ra7RC1Nuz+4agU6rwV4H+mhel3vgZl8XRASicdrwzWdc+B3wUCoL1+OHqIB
         pb4OThN0iQMtO7sWB9wVetbC1cyPPEUlWQjRCdYapn5ijZcxgCDJvWj6aXztOqNuRf3x
         YKMb2lO3wdMLokxSuje0MwzXKmqDQoEEiio/bpszrRs4fnDI+Rrlfe8kDLXtg9ohyedP
         gmYkcRfcZqtVZLZWBwnPJZwdsfxUEOA5b2pEVBvFKRCFZqZUeN/c81z+vEuHg1bJynsz
         KPQw==
X-Forwarded-Encrypted: i=1; AJvYcCWjqV3zswa5/iKuWgv2MfxNoBFnhYu40MwzoC6WVmrDp8/Q4TN9/gjfWTy83visMa7dINFZ6/HG4sB2SAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmIkcvZgXB0sMM7eWeP5dgrzs/x68gCLYsgNVs9LJO91141jYn
	9ivVO/SovxbFq3UhqXTc+esIeVNoCnkJdm6wKWNoI3b4BuS0LZc1ki5u
X-Gm-Gg: ASbGncvPus8wqL6CHrPSePebMc/chIPIWqVM/j9Oj6bPmjy/mhbbBUCNONbLaYT/mT4
	e5IUqrBwCFwly9iOgNy9+Sqzr201wVs/PIdq/7C5G0nTepEBaIdlH7zKgwJk8dZtSoeQ30VjV5z
	VTNHlHiEwWeDsjIF8564JaqkV2qDjqoIzL+G18O6/5N2aJt5xLpJ8ZjQuLLOk48gVU0Fh6SV9rX
	z8eegSnqMfeQvlfbW0fUzcbwsZTZuoLyKxmmcmqeMOKI2F3q6fiHjqz7DFaf7YQwAXQSZYaFjXn
	SO6u5boaEkLoRzHJXXwdpGfCMb+9gF/PFyBG5Gu85lJ9BeMjQlNX/RL9glbualI8J+Cb7CiBnJc
	XqEAiH8zn9Yhtc02WiVFwOvRWHoQ04NFMokMxvC67RYS8/LHRtG2p3MQG/KIA3NbfCrDi2x7aEh
	Q1H2NkmZLGMpollB51wDWn
X-Google-Smtp-Source: AGHT+IGWCQLviFcQvcj4hei5TQb5babvs+IdShmaI91V27dhBK786K4d+NOP4MaEXVIILQVw35I/iA==
X-Received: by 2002:a17:90b:4f44:b0:32d:90c7:c63b with SMTP id 98e67ed59e1d1-3403a2f218amr3958243a91.30.1761753624639;
        Wed, 29 Oct 2025 09:00:24 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:00:23 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:44 +0800
Subject: [PATCH 18/19] mm, swap: drop the SWAP_HAS_CACHE flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-18-3d43f3b6ec32@tencent.com>
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

Now, the swap cache is managed by the swap table. All swap cache users
are checking the swap table directly to check the swap cache state.
SWAP_HAS_CACHE is now just a temporary pin before the first increase
from 0 to 1 of a slot's swap count (swap_dup_entries), or before the
final free of slots pinned by folio in swap cache (put_swap_folio).

Drop these two usages. For the first dup, SWAP_HAS_CACHE pinning was
hard to kill because it used to have multiple meanings, more than just
"a slot is cached". We have simplified that and just defined that the
first dup is always done with folio locked in swap cache (folio_dup_swap),
so it can just check the swap cache (swap table) directly.

As for freeing, just let the swap cache free all swap entries of a folio
that have a swap count of zero directly upon folio removal. We have also
just cleaned up freeing to cover the swap cache usage in the swap table,
a slot with swap cache will not be freed until its cache is gone.
Now, making the removal of a folio and freeing the slots being done in
the same critical section, this should improve the performance and gets
rid of the SWAP_HAS_CACHE pin.

After these two changes, SWAP_HAS_CACHE no longer has any users. Remove
all related logic and helpers. swap_map is now only used for tracking
the count, so all swap_map users can just need to read it directly,
ignoring the swap_count helper, which was previously used to filter out
the SWAP_HAS_CACHE bit.

The idea of dropping SWAP_HAS_CACHE and using the swap table directly
was initially from Chris's idea of merging all the metadata usage of all
swaps into one place.

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   1 -
 mm/swap.h            |  13 ++--
 mm/swap_state.c      |  28 +++++----
 mm/swapfile.c        | 163 ++++++++++++++++-----------------------------------
 4 files changed, 71 insertions(+), 134 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4b4b81fbc6a3..dcb1760e36c3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -224,7 +224,6 @@ enum {
 #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
 
 /* Bit flag in swap_map */
-#define SWAP_HAS_CACHE	0x40	/* Flag page is cached, in first swap_map */
 #define COUNT_CONTINUED	0x80	/* Flag swap_map continuation for full count */
 
 /* Special value in first swap_map */
diff --git a/mm/swap.h b/mm/swap.h
index 73f07bcea5f0..331424366487 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -205,6 +205,11 @@ int folio_alloc_swap(struct folio *folio);
 int folio_dup_swap(struct folio *folio, struct page *subpage);
 void folio_put_swap(struct folio *folio, struct page *subpage);
 
+/* For internal use */
+extern void swap_entries_free(struct swap_info_struct *si,
+			      struct swap_cluster_info *ci,
+			      unsigned long offset, unsigned int nr_pages);
+
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
@@ -256,14 +261,6 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
 	return folio_entry.val == round_down(entry.val, nr_pages);
 }
 
-/* Temporary internal helpers */
-void __swapcache_set_cached(struct swap_info_struct *si,
-			    struct swap_cluster_info *ci,
-			    swp_entry_t entry);
-void __swapcache_clear_cached(struct swap_info_struct *si,
-			      struct swap_cluster_info *ci,
-			      swp_entry_t entry, unsigned int nr);
-
 /*
  * All swap cache helpers below require the caller to ensure the swap entries
  * used are valid and stablize the device by any of the following ways:
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 41d4fa056203..2bf72d58f6ee 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -215,17 +215,6 @@ static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 			shadow = swp_tb_to_shadow(old_tb);
 		offset++;
 	} while (++ci_off < ci_end);
-
-	ci_off = ci_start;
-	offset = swp_offset(entry);
-	do {
-		/*
-		 * Still need to pin the slots with SWAP_HAS_CACHE since
-		 * swap allocator depends on that.
-		 */
-		__swapcache_set_cached(si, ci, swp_entry(swp_type(entry), offset));
-		offset++;
-	} while (++ci_off < ci_end);
 	__swap_cache_add_folio(ci, folio, entry);
 	swap_cluster_unlock(ci);
 	if (shadowp)
@@ -256,6 +245,7 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 	struct swap_info_struct *si;
 	unsigned long old_tb, new_tb;
 	unsigned int ci_start, ci_off, ci_end;
+	bool folio_swapped = false, need_free = false;
 	unsigned long nr_pages = folio_nr_pages(folio);
 
 	VM_WARN_ON_ONCE(__swap_entry_to_cluster(entry) != ci);
@@ -273,13 +263,27 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 		old_tb = __swap_table_xchg(ci, ci_off, new_tb);
 		WARN_ON_ONCE(!swp_tb_is_folio(old_tb) ||
 			     swp_tb_to_folio(old_tb) != folio);
+		if (__swap_count(swp_entry(si->type,
+				 swp_offset(entry) + ci_off - ci_start)))
+			folio_swapped = true;
+		else
+			need_free = true;
 	} while (++ci_off < ci_end);
 
 	folio->swap.val = 0;
 	folio_clear_swapcache(folio);
 	node_stat_mod_folio(folio, NR_FILE_PAGES, -nr_pages);
 	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr_pages);
-	__swapcache_clear_cached(si, ci, entry, nr_pages);
+
+	if (!folio_swapped) {
+		swap_entries_free(si, ci, swp_offset(entry), nr_pages);
+	} else if (need_free) {
+		do {
+			if (!__swap_count(entry))
+				swap_entries_free(si, ci, swp_offset(entry), 1);
+			entry.val++;
+		} while (--nr_pages);
+	}
 }
 
 /**
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 12a1ab6f7b32..49916fdb8b70 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -48,21 +48,18 @@
 #include <linux/swap_cgroup.h>
 #include "swap_table.h"
 #include "internal.h"
+#include "swap_table.h"
 #include "swap.h"
 
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
 static void free_swap_count_continuations(struct swap_info_struct *);
-static void swap_entries_free(struct swap_info_struct *si,
-			      struct swap_cluster_info *ci,
-			      unsigned long start, unsigned int nr_pages);
 static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries);
 static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr);
 static void swap_put_entry_locked(struct swap_info_struct *si,
 				  struct swap_cluster_info *ci,
-				  unsigned long offset,
-				  unsigned char usage);
+				  unsigned long offset);
 static bool folio_swapcache_freeable(struct folio *folio);
 static void move_cluster(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci, struct list_head *list,
@@ -149,11 +146,6 @@ static struct swap_info_struct *swap_entry_to_info(swp_entry_t entry)
 	return swap_type_to_info(swp_type(entry));
 }
 
-static inline unsigned char swap_count(unsigned char ent)
-{
-	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
-}
-
 /*
  * Use the second highest bit of inuse_pages counter as the indicator
  * if one swap device is on the available plist, so the atomic can
@@ -185,15 +177,20 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
 #define TTRS_FULL		0x4
 
 static bool swap_only_has_cache(struct swap_info_struct *si,
-			      unsigned long offset, int nr_pages)
+				struct swap_cluster_info *ci,
+				unsigned long offset, int nr_pages)
 {
+	unsigned int ci_off = offset % SWAPFILE_CLUSTER;
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
+	unsigned long swp_tb;
 
 	do {
-		VM_BUG_ON(!(*map & SWAP_HAS_CACHE));
-		if (*map != SWAP_HAS_CACHE)
+		swp_tb = __swap_table_get(ci, ci_off);
+		VM_WARN_ON_ONCE(!swp_tb_is_folio(swp_tb));
+		if (*map)
 			return false;
+		++ci_off;
 	} while (++map < map_end);
 
 	return true;
@@ -254,7 +251,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	 * reference or pending writeback, and can't be allocated to others.
 	 */
 	ci = swap_cluster_lock(si, offset);
-	need_reclaim = swap_only_has_cache(si, offset, nr_pages);
+	need_reclaim = swap_only_has_cache(si, ci, offset, nr_pages);
 	swap_cluster_unlock(ci);
 	if (!need_reclaim)
 		goto out_unlock;
@@ -775,7 +772,7 @@ static unsigned int cluster_reclaim_range(struct swap_info_struct *si,
 
 	spin_unlock(&ci->lock);
 	do {
-		if (swap_count(READ_ONCE(map[offset])))
+		if (READ_ONCE(map[offset]))
 			break;
 		swp_tb = swap_table_get(ci, offset % SWAPFILE_CLUSTER);
 		if (swp_tb_is_folio(swp_tb)) {
@@ -800,7 +797,7 @@ static unsigned int cluster_reclaim_range(struct swap_info_struct *si,
 	 */
 	for (offset = start; offset < end; offset++) {
 		swp_tb = __swap_table_get(ci, offset % SWAPFILE_CLUSTER);
-		if (swap_count(map[offset]) || !swp_tb_is_null(swp_tb))
+		if (map[offset] || !swp_tb_is_null(swp_tb))
 			return SWAP_ENTRY_INVALID;
 	}
 
@@ -820,11 +817,10 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 		return true;
 
 	do {
-		if (swap_count(map[offset]))
+		if (map[offset])
 			return false;
 		swp_tb = __swap_table_get(ci, offset % SWAPFILE_CLUSTER);
 		if (swp_tb_is_folio(swp_tb)) {
-			WARN_ON_ONCE(!(map[offset] & SWAP_HAS_CACHE));
 			if (!vm_swap_full())
 				return false;
 			*need_reclaim = true;
@@ -882,11 +878,6 @@ static bool cluster_alloc_range(struct swap_info_struct *si,
 	if (likely(folio)) {
 		order = folio_order(folio);
 		nr_pages = 1 << order;
-		/*
-		 * Pin the slot with SWAP_HAS_CACHE to satisfy swap_dup_entries.
-		 * This is the legacy allocation behavior, will drop it very soon.
-		 */
-		memset(si->swap_map + offset, SWAP_HAS_CACHE, nr_pages);
 		__swap_cache_add_folio(ci, folio, swp_entry(si->type, offset));
 	} else {
 		order = 0;
@@ -995,8 +986,8 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 		to_scan--;
 
 		while (offset < end) {
-			if (!swap_count(READ_ONCE(map[offset])) &&
-			    swp_tb_is_folio(__swap_table_get(ci, offset % SWAPFILE_CLUSTER))) {
+			if (!READ_ONCE(map[offset]) &&
+			    swp_tb_is_folio(swap_table_get(ci, offset % SWAPFILE_CLUSTER))) {
 				spin_unlock(&ci->lock);
 				nr_reclaim = __try_to_reclaim_swap(si, offset,
 								   TTRS_ANYWAY);
@@ -1431,8 +1422,8 @@ static void swap_put_entries_cluster(struct swap_info_struct *si,
 	do {
 		swp_tb = __swap_table_get(ci, offset % SWAPFILE_CLUSTER);
 		count = si->swap_map[offset];
-		VM_WARN_ON(swap_count(count) < 1 || count == SWAP_MAP_BAD);
-		if (swap_count(count) == 1) {
+		VM_WARN_ON(count < 1 || count == SWAP_MAP_BAD);
+		if (count == 1) {
 			/* count == 1 and non-cached slots will be batch freed. */
 			if (!swp_tb_is_folio(swp_tb)) {
 				if (!batch_start)
@@ -1440,7 +1431,6 @@ static void swap_put_entries_cluster(struct swap_info_struct *si,
 				continue;
 			}
 			/* count will be 0 after put, slot can be reclaimed */
-			VM_WARN_ON(!(count & SWAP_HAS_CACHE));
 			need_reclaim = true;
 		}
 		/*
@@ -1449,7 +1439,7 @@ static void swap_put_entries_cluster(struct swap_info_struct *si,
 		 * slots will be freed when folio is removed from swap cache
 		 * (__swap_cache_del_folio).
 		 */
-		swap_put_entry_locked(si, ci, offset, 1);
+		swap_put_entry_locked(si, ci, offset);
 		if (batch_start) {
 			swap_entries_free(si, ci, batch_start, offset - batch_start);
 			batch_start = SWAP_ENTRY_INVALID;
@@ -1602,13 +1592,8 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 	offset = swp_offset(entry);
 	if (offset >= si->max)
 		goto bad_offset;
-	if (data_race(!si->swap_map[swp_offset(entry)]))
-		goto bad_free;
 	return si;
 
-bad_free:
-	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
-	goto out;
 bad_offset:
 	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
 	goto out;
@@ -1623,21 +1608,12 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 
 static void swap_put_entry_locked(struct swap_info_struct *si,
 				  struct swap_cluster_info *ci,
-				  unsigned long offset,
-				  unsigned char usage)
+				  unsigned long offset)
 {
 	unsigned char count;
-	unsigned char has_cache;
 
 	count = si->swap_map[offset];
-
-	has_cache = count & SWAP_HAS_CACHE;
-	count &= ~SWAP_HAS_CACHE;
-
-	if (usage == SWAP_HAS_CACHE) {
-		VM_BUG_ON(!has_cache);
-		has_cache = 0;
-	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
+	if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
 		if (count == COUNT_CONTINUED) {
 			if (swap_count_continued(si, offset, count))
 				count = SWAP_MAP_MAX | COUNT_CONTINUED;
@@ -1647,10 +1623,8 @@ static void swap_put_entry_locked(struct swap_info_struct *si,
 			count--;
 	}
 
-	usage = count | has_cache;
-	if (usage)
-		WRITE_ONCE(si->swap_map[offset], usage);
-	else
+	WRITE_ONCE(si->swap_map[offset], count);
+	if (!count && !swp_tb_is_folio(__swap_table_get(ci, offset % SWAPFILE_CLUSTER)))
 		swap_entries_free(si, ci, offset, 1);
 }
 
@@ -1719,21 +1693,13 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
-/*
- * Check if it's the last ref of swap entry in the freeing path.
- */
-static inline bool __maybe_unused swap_is_last_ref(unsigned char count)
-{
-	return (count == SWAP_HAS_CACHE) || (count == 1);
-}
-
 /*
  * Drop the last ref of swap entries, caller have to ensure all entries
  * belong to the same cgroup and cluster.
  */
-static void swap_entries_free(struct swap_info_struct *si,
-			      struct swap_cluster_info *ci,
-			      unsigned long offset, unsigned int nr_pages)
+void swap_entries_free(struct swap_info_struct *si,
+		       struct swap_cluster_info *ci,
+		       unsigned long offset, unsigned int nr_pages)
 {
 	swp_entry_t entry = swp_entry(si->type, offset);
 	unsigned char *map = si->swap_map + offset;
@@ -1746,7 +1712,7 @@ static void swap_entries_free(struct swap_info_struct *si,
 
 	ci->count -= nr_pages;
 	do {
-		VM_BUG_ON(!swap_is_last_ref(*map));
+		VM_WARN_ON(*map > 1);
 		*map = 0;
 	} while (++map < map_end);
 
@@ -1765,7 +1731,7 @@ int __swap_count(swp_entry_t entry)
 	struct swap_info_struct *si = __swap_entry_to_info(entry);
 	pgoff_t offset = swp_offset(entry);
 
-	return swap_count(si->swap_map[offset]);
+	return si->swap_map[offset];
 }
 
 /**
@@ -1779,7 +1745,7 @@ bool swap_entry_swapped(struct swap_info_struct *si, unsigned long offset)
 	int count;
 
 	ci = swap_cluster_lock(si, offset);
-	count = swap_count(si->swap_map[offset]);
+	count = si->swap_map[offset];
 	swap_cluster_unlock(ci);
 
 	return count && count != SWAP_MAP_BAD;
@@ -1806,7 +1772,7 @@ int swp_swapcount(swp_entry_t entry)
 
 	ci = swap_cluster_lock(si, offset);
 
-	count = swap_count(si->swap_map[offset]);
+	count = si->swap_map[offset];
 	if (!(count & COUNT_CONTINUED))
 		goto out;
 
@@ -1844,12 +1810,12 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 
 	ci = swap_cluster_lock(si, offset);
 	if (nr_pages == 1) {
-		if (swap_count(map[roffset]))
+		if (map[roffset])
 			ret = true;
 		goto unlock_out;
 	}
 	for (i = 0; i < nr_pages; i++) {
-		if (swap_count(map[offset + i])) {
+		if (map[offset + i]) {
 			ret = true;
 			break;
 		}
@@ -2005,7 +1971,7 @@ void swap_free_hibernation_slot(swp_entry_t entry)
 		return;
 
 	ci = swap_cluster_lock(si, offset);
-	swap_put_entry_locked(si, ci, offset, 1);
+	swap_put_entry_locked(si, ci, offset);
 	WARN_ON(swap_entry_swapped(si, offset));
 	swap_cluster_unlock(ci);
 
@@ -2412,6 +2378,7 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 					unsigned int prev)
 {
 	unsigned int i;
+	unsigned long swp_tb;
 	unsigned char count;
 
 	/*
@@ -2422,7 +2389,11 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 	 */
 	for (i = prev + 1; i < si->max; i++) {
 		count = READ_ONCE(si->swap_map[i]);
-		if (count && swap_count(count) != SWAP_MAP_BAD)
+		swp_tb = swap_table_get(__swap_offset_to_cluster(si, i),
+					i % SWAPFILE_CLUSTER);
+		if (count == SWAP_MAP_BAD)
+			continue;
+		if (count || swp_tb_is_folio(swp_tb))
 			break;
 		if ((i % LATENCY_LIMIT) == 0)
 			cond_resched();
@@ -3649,39 +3620,26 @@ static int swap_dup_entries(struct swap_info_struct *si,
 			    unsigned char usage, int nr)
 {
 	int i;
-	unsigned char count, has_cache;
+	unsigned char count;
 
 	for (i = 0; i < nr; i++) {
 		count = si->swap_map[offset + i];
-
 		/*
 		 * Allocator never allocates bad slots, and readahead is guarded
 		 * by swap_entry_swapped.
 		 */
-		if (WARN_ON(swap_count(count) == SWAP_MAP_BAD))
-			return -ENOENT;
-
-		has_cache = count & SWAP_HAS_CACHE;
-		count &= ~SWAP_HAS_CACHE;
-
-		if (!count && !has_cache) {
-			return -ENOENT;
-		} else if (usage == SWAP_HAS_CACHE) {
-			if (has_cache)
-				return -EEXIST;
-		} else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
-			return -EINVAL;
-		}
+		VM_WARN_ON(count == SWAP_MAP_BAD);
+		/*
+		 * Swap count duplication is guranteed by either locked swap cache
+		 * folio (folio_dup_swap) or external lock (swap_dup_entry_direct).
+		 */
+		VM_WARN_ON(!count &&
+			   !swp_tb_is_folio(__swap_table_get(ci, offset % SWAPFILE_CLUSTER)));
 	}
 
 	for (i = 0; i < nr; i++) {
 		count = si->swap_map[offset + i];
-		has_cache = count & SWAP_HAS_CACHE;
-		count &= ~SWAP_HAS_CACHE;
-
-		if (usage == SWAP_HAS_CACHE)
-			has_cache = SWAP_HAS_CACHE;
-		else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
+		if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
 			count += usage;
 		else if (swap_count_continued(si, offset + i, count))
 			count = COUNT_CONTINUED;
@@ -3693,7 +3651,7 @@ static int swap_dup_entries(struct swap_info_struct *si,
 			return -ENOMEM;
 		}
 
-		WRITE_ONCE(si->swap_map[offset + i], count | has_cache);
+		WRITE_ONCE(si->swap_map[offset + i], count);
 	}
 
 	return 0;
@@ -3739,27 +3697,6 @@ int swap_dup_entry_direct(swp_entry_t entry)
 	return err;
 }
 
-/* Mark the swap map as HAS_CACHE, caller need to hold the cluster lock */
-void __swapcache_set_cached(struct swap_info_struct *si,
-			    struct swap_cluster_info *ci,
-			    swp_entry_t entry)
-{
-	WARN_ON(swap_dup_entries(si, ci, swp_offset(entry), SWAP_HAS_CACHE, 1));
-}
-
-/* Clear the swap map as !HAS_CACHE, caller need to hold the cluster lock */
-void __swapcache_clear_cached(struct swap_info_struct *si,
-			      struct swap_cluster_info *ci,
-			      swp_entry_t entry, unsigned int nr)
-{
-	if (swap_only_has_cache(si, swp_offset(entry), nr)) {
-		swap_entries_free(si, ci, swp_offset(entry), nr);
-	} else {
-		for (int i = 0; i < nr; i++, entry.val++)
-			swap_put_entry_locked(si, ci, swp_offset(entry), SWAP_HAS_CACHE);
-	}
-}
-
 /*
  * add_swap_count_continuation - called when a swap count is duplicated
  * beyond SWAP_MAP_MAX, it allocates a new page and links that to the entry's
@@ -3805,7 +3742,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 
 	ci = swap_cluster_lock(si, offset);
 
-	count = swap_count(si->swap_map[offset]);
+	count = si->swap_map[offset];
 
 	if ((count & ~COUNT_CONTINUED) != SWAP_MAP_MAX) {
 		/*

-- 
2.51.1



Return-Path: <linux-kernel+bounces-810627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3380B51D28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB2C580E09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAFA334728;
	Wed, 10 Sep 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI0SvO3S"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A68338F3D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520558; cv=none; b=n+4ucRXJ+PSdA+uIOJnIGz6y7rQs9UCtGTfKvKIMUGk3/NIgtSXDXkco2+EYClnTu9EciKrMxQp8jsvNU3pPDZk5f7vvuKzOFQrO2kmt3L7abdsWOsnKG7i3wpZxcSKdxqspYla0/SRz5EfYDS6UGb1tAJRNheR3DZ2L4LhH/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520558; c=relaxed/simple;
	bh=tp9jK+cTl4ybe0NoVzXfXV2KqwiGZy4ZtyO0uOEresg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJPcN9BiKmfzy5N28m+rY72WA7uE2XTC+f4ONULUroyVTzg1faw3XakGUPilY+m+Fz3hdCo9RGwtDUb5L8EEgoMaT4uEmmFFNOtsHR2uwh6Tt26ZKHMpBB/5EJchC2MYjx4+ir74Wl76D1NHPPPWao3eby6E7c6dTa/0GMMbnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI0SvO3S; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7728a8862ccso870502b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520556; x=1758125356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s5HcJVxJqYzxUZjEo3aLu6n8KHT0yS8P2J4twu7LXww=;
        b=gI0SvO3SJ68e4t+k/PPvLJtfMNHne6qWnbTnUOxzPJgdIpEnSdb2nRbf377KCJfjmj
         IwN2XLR2b5HOgU5ZyKlR4wBLb2SbfP2f+JraCyusnMRFmf6fJ7VLBztzqWi0GGRtIc76
         4CQyOOn5WD2TYotdrs4h+2Uglwtxj+a6fJKk3lO+Zfx4c7Ed2+UCbD41Jsy3ebbL0frJ
         E2Pwt696vl/oOHUiBIRiNKtJr00WMAaMeVRAA/a+F6W9umZxokqRKJRT6RoO9pZrMz87
         NhvOyh1V56CcyufrD4LQR6qHvnVqwY86NUFnsf+EqGmQtSHUx1mSebHEjcJ9/mB1QhYc
         jhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520556; x=1758125356;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5HcJVxJqYzxUZjEo3aLu6n8KHT0yS8P2J4twu7LXww=;
        b=Ma19kBRz4dlc8l7W+PeI31sePIXUt2DZx2Jw1VwLUUgBt6fd3JpmqhuordlpMSiuNi
         Wu8QZd/+w4PVojd5sCCn8eGent28VYjpag0CrFVHv/+ZnsM1oJgAlf2nUVx3d4cCw0WK
         fVYpATET3IPH9PyKY8t8Llqkv2I0osudGhyfod0jiiJ30rmby7sCAFC+fSB/bjJFA0XZ
         Nyyl9ofAYdiZV0Jq1DKpU19FRWUOSKg75Bj/0Pbd6H9cdz1NLzCjvemJ41gqZYpS6iah
         9q8gvWSXlffKtKX6B8LQPCZTT67E5u4JOFP3ziuAxK+dRHl6DiCB8vL4ipVviDwRe81I
         i/8g==
X-Forwarded-Encrypted: i=1; AJvYcCVOsHzS0xdN02gMB5h2jzURwft1mV6J5UrEdVsYu3xFCEexsfLNhJ2s1Kj2plAXxr6IzpCie0kgw5DInHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/vFhQ07J1QWFBviYlPNasmZi/LvHApOCqR3XVWJQXsFmlwJE
	LDbQnU3g44yL+D6lF32r3NvI7rXvjVs4pREI8ufTiKhN93/+4dFyNjZh
X-Gm-Gg: ASbGncspFI+ifqn9RR8SHkyAJfbFL9yTkzsnt3NsJCV6gCdYE53pl9PcZBmAr7utlOA
	ghPGmb/52VKtXnFNYnpOgvR5i02HDY0hyoFHXXDyys5x6b2BvJl9sdPPQEgy48pxnP/ueLDgu91
	ngJ7SCkMXRf9zrDBS5RbmNlyL5VOsdtUhwVE/OkBQ3ozCIfXUlLIME7cJlipsSZpamVpPTarY5j
	O5kq19Q7rEKJYvCtWuya2vEPAClP0VlqxfG13TalTygEM6juekG+EH6rHtJdnMGn/HSsoASez4x
	6TtiWDaDnNfQL5ZzjeV/p623U3UeTtsnoWdOZgDM1xbmoUY1jflYdiZTZ5Qcu9bYVDEMff4TjAO
	nJLMaiOLfHGw+UVo4tAxOXI5Dj17kaL6Xtuu6cdCMNJkIgRo=
X-Google-Smtp-Source: AGHT+IGH4gi7IyV/95U3LFCHhW1okK8q/O9STR4M1KwOMk1ioCbsGLzlOVyMoaTZn7dFGHmQS+afqg==
X-Received: by 2002:a05:6a20:4327:b0:243:b965:1bb7 with SMTP id adf61e73a8af0-25d0a5cd9c0mr198373637.19.1757520555556;
        Wed, 10 Sep 2025 09:09:15 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:14 -0700 (PDT)
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
Subject: [PATCH v3 06/15] mm, swap: rename and move some swap cluster definition and helpers
Date: Thu, 11 Sep 2025 00:08:24 +0800
Message-ID: <20250910160833.3464-7-ryncsn@gmail.com>
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

No feature change, move cluster related definitions and helpers to
mm/swap.h, also tidy up and add a "swap_" prefix for cluster lock/unlock
helpers, so they can be used outside of swap files. And while at it, add
kerneldoc.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: Chris Li <chrisl@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swap.h | 34 ----------------
 mm/swap.h            | 70 ++++++++++++++++++++++++++++++++
 mm/swapfile.c        | 97 +++++++++++++-------------------------------
 3 files changed, 99 insertions(+), 102 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a2bb20841616..78cc48a65512 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -235,40 +235,6 @@ enum {
 /* Special value in each swap_map continuation */
 #define SWAP_CONT_MAX	0x7f	/* Max count */
 
-/*
- * We use this to track usage of a cluster. A cluster is a block of swap disk
- * space with SWAPFILE_CLUSTER pages long and naturally aligns in disk. All
- * free clusters are organized into a list. We fetch an entry from the list to
- * get a free cluster.
- *
- * The flags field determines if a cluster is free. This is
- * protected by cluster lock.
- */
-struct swap_cluster_info {
-	spinlock_t lock;	/*
-				 * Protect swap_cluster_info fields
-				 * other than list, and swap_info_struct->swap_map
-				 * elements corresponding to the swap cluster.
-				 */
-	u16 count;
-	u8 flags;
-	u8 order;
-	struct list_head list;
-};
-
-/* All on-list cluster must have a non-zero flag. */
-enum swap_cluster_flags {
-	CLUSTER_FLAG_NONE = 0, /* For temporary off-list cluster */
-	CLUSTER_FLAG_FREE,
-	CLUSTER_FLAG_NONFULL,
-	CLUSTER_FLAG_FRAG,
-	/* Clusters with flags above are allocatable */
-	CLUSTER_FLAG_USABLE = CLUSTER_FLAG_FRAG,
-	CLUSTER_FLAG_FULL,
-	CLUSTER_FLAG_DISCARD,
-	CLUSTER_FLAG_MAX,
-};
-
 /*
  * The first page in the swap file is the swap header, which is always marked
  * bad to prevent it from being allocated as an entry. This also prevents the
diff --git a/mm/swap.h b/mm/swap.h
index 7d868f8de696..138b5197c35e 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -7,10 +7,80 @@ struct swap_iocb;
 
 extern int page_cluster;
 
+#ifdef CONFIG_THP_SWAP
+#define SWAPFILE_CLUSTER	HPAGE_PMD_NR
+#define swap_entry_order(order)	(order)
+#else
+#define SWAPFILE_CLUSTER	256
+#define swap_entry_order(order)	0
+#endif
+
+/*
+ * We use this to track usage of a cluster. A cluster is a block of swap disk
+ * space with SWAPFILE_CLUSTER pages long and naturally aligns in disk. All
+ * free clusters are organized into a list. We fetch an entry from the list to
+ * get a free cluster.
+ *
+ * The flags field determines if a cluster is free. This is
+ * protected by cluster lock.
+ */
+struct swap_cluster_info {
+	spinlock_t lock;	/*
+				 * Protect swap_cluster_info fields
+				 * other than list, and swap_info_struct->swap_map
+				 * elements corresponding to the swap cluster.
+				 */
+	u16 count;
+	u8 flags;
+	u8 order;
+	struct list_head list;
+};
+
+/* All on-list cluster must have a non-zero flag. */
+enum swap_cluster_flags {
+	CLUSTER_FLAG_NONE = 0, /* For temporary off-list cluster */
+	CLUSTER_FLAG_FREE,
+	CLUSTER_FLAG_NONFULL,
+	CLUSTER_FLAG_FRAG,
+	/* Clusters with flags above are allocatable */
+	CLUSTER_FLAG_USABLE = CLUSTER_FLAG_FRAG,
+	CLUSTER_FLAG_FULL,
+	CLUSTER_FLAG_DISCARD,
+	CLUSTER_FLAG_MAX,
+};
+
 #ifdef CONFIG_SWAP
 #include <linux/swapops.h> /* for swp_offset */
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
+static inline struct swap_cluster_info *swp_offset_cluster(
+		struct swap_info_struct *si, pgoff_t offset)
+{
+	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
+}
+
+/**
+ * swap_cluster_lock - Lock and return the swap cluster of given offset.
+ * @si: swap device the cluster belongs to.
+ * @offset: the swap entry offset, pointing to a valid slot.
+ *
+ * Context: The caller must ensure the offset is in the valid range and
+ * protect the swap device with reference count or locks.
+ */
+static inline struct swap_cluster_info *swap_cluster_lock(
+		struct swap_info_struct *si, unsigned long offset)
+{
+	struct swap_cluster_info *ci = swp_offset_cluster(si, offset);
+
+	spin_lock(&ci->lock);
+	return ci;
+}
+
+static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
+{
+	spin_unlock(&ci->lock);
+}
+
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f1a4d381d719..3bfe9cf06fd2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -58,9 +58,6 @@ static void swap_entries_free(struct swap_info_struct *si,
 static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries);
 static bool folio_swapcache_freeable(struct folio *folio);
-static struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
-					      unsigned long offset);
-static inline void unlock_cluster(struct swap_cluster_info *ci);
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
@@ -257,9 +254,9 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	 * swap_map is HAS_CACHE only, which means the slots have no page table
 	 * reference or pending writeback, and can't be allocated to others.
 	 */
-	ci = lock_cluster(si, offset);
+	ci = swap_cluster_lock(si, offset);
 	need_reclaim = swap_only_has_cache(si, offset, nr_pages);
-	unlock_cluster(ci);
+	swap_cluster_unlock(ci);
 	if (!need_reclaim)
 		goto out_unlock;
 
@@ -384,19 +381,6 @@ static void discard_swap_cluster(struct swap_info_struct *si,
 	}
 }
 
-#ifdef CONFIG_THP_SWAP
-#define SWAPFILE_CLUSTER	HPAGE_PMD_NR
-
-#define swap_entry_order(order)	(order)
-#else
-#define SWAPFILE_CLUSTER	256
-
-/*
- * Define swap_entry_order() as constant to let compiler to optimize
- * out some code if !CONFIG_THP_SWAP
- */
-#define swap_entry_order(order)	0
-#endif
 #define LATENCY_LIMIT		256
 
 static inline bool cluster_is_empty(struct swap_cluster_info *info)
@@ -424,34 +408,12 @@ static inline unsigned int cluster_index(struct swap_info_struct *si,
 	return ci - si->cluster_info;
 }
 
-static inline struct swap_cluster_info *offset_to_cluster(struct swap_info_struct *si,
-							  unsigned long offset)
-{
-	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
-}
-
 static inline unsigned int cluster_offset(struct swap_info_struct *si,
 					  struct swap_cluster_info *ci)
 {
 	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
 }
 
-static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
-						     unsigned long offset)
-{
-	struct swap_cluster_info *ci;
-
-	ci = offset_to_cluster(si, offset);
-	spin_lock(&ci->lock);
-
-	return ci;
-}
-
-static inline void unlock_cluster(struct swap_cluster_info *ci)
-{
-	spin_unlock(&ci->lock);
-}
-
 static void move_cluster(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci, struct list_head *list,
 			 enum swap_cluster_flags new_flags)
@@ -807,7 +769,7 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	}
 out:
 	relocate_cluster(si, ci);
-	unlock_cluster(ci);
+	swap_cluster_unlock(ci);
 	if (si->flags & SWP_SOLIDSTATE) {
 		this_cpu_write(percpu_swap_cluster.offset[order], next);
 		this_cpu_write(percpu_swap_cluster.si[order], si);
@@ -874,7 +836,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 		if (ci->flags == CLUSTER_FLAG_NONE)
 			relocate_cluster(si, ci);
 
-		unlock_cluster(ci);
+		swap_cluster_unlock(ci);
 		if (to_scan <= 0)
 			break;
 	}
@@ -913,7 +875,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		if (offset == SWAP_ENTRY_INVALID)
 			goto new_cluster;
 
-		ci = lock_cluster(si, offset);
+		ci = swap_cluster_lock(si, offset);
 		/* Cluster could have been used by another order */
 		if (cluster_is_usable(ci, order)) {
 			if (cluster_is_empty(ci))
@@ -921,7 +883,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 			found = alloc_swap_scan_cluster(si, ci, offset,
 							order, usage);
 		} else {
-			unlock_cluster(ci);
+			swap_cluster_unlock(ci);
 		}
 		if (found)
 			goto done;
@@ -1202,7 +1164,7 @@ static bool swap_alloc_fast(swp_entry_t *entry,
 	if (!si || !offset || !get_swap_device_info(si))
 		return false;
 
-	ci = lock_cluster(si, offset);
+	ci = swap_cluster_lock(si, offset);
 	if (cluster_is_usable(ci, order)) {
 		if (cluster_is_empty(ci))
 			offset = cluster_offset(si, ci);
@@ -1210,7 +1172,7 @@ static bool swap_alloc_fast(swp_entry_t *entry,
 		if (found)
 			*entry = swp_entry(si->type, found);
 	} else {
-		unlock_cluster(ci);
+		swap_cluster_unlock(ci);
 	}
 
 	put_swap_device(si);
@@ -1478,14 +1440,14 @@ static void swap_entries_put_cache(struct swap_info_struct *si,
 	unsigned long offset = swp_offset(entry);
 	struct swap_cluster_info *ci;
 
-	ci = lock_cluster(si, offset);
-	if (swap_only_has_cache(si, offset, nr))
+	ci = swap_cluster_lock(si, offset);
+	if (swap_only_has_cache(si, offset, nr)) {
 		swap_entries_free(si, ci, entry, nr);
-	else {
+	} else {
 		for (int i = 0; i < nr; i++, entry.val++)
 			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
 	}
-	unlock_cluster(ci);
+	swap_cluster_unlock(ci);
 }
 
 static bool swap_entries_put_map(struct swap_info_struct *si,
@@ -1503,7 +1465,7 @@ static bool swap_entries_put_map(struct swap_info_struct *si,
 	if (count != 1 && count != SWAP_MAP_SHMEM)
 		goto fallback;
 
-	ci = lock_cluster(si, offset);
+	ci = swap_cluster_lock(si, offset);
 	if (!swap_is_last_map(si, offset, nr, &has_cache)) {
 		goto locked_fallback;
 	}
@@ -1512,21 +1474,20 @@ static bool swap_entries_put_map(struct swap_info_struct *si,
 	else
 		for (i = 0; i < nr; i++)
 			WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
-	unlock_cluster(ci);
+	swap_cluster_unlock(ci);
 
 	return has_cache;
 
 fallback:
-	ci = lock_cluster(si, offset);
+	ci = swap_cluster_lock(si, offset);
 locked_fallback:
 	for (i = 0; i < nr; i++, entry.val++) {
 		count = swap_entry_put_locked(si, ci, entry, 1);
 		if (count == SWAP_HAS_CACHE)
 			has_cache = true;
 	}
-	unlock_cluster(ci);
+	swap_cluster_unlock(ci);
 	return has_cache;
-
 }
 
 /*
@@ -1576,7 +1537,7 @@ static void swap_entries_free(struct swap_info_struct *si,
 	unsigned char *map_end = map + nr_pages;
 
 	/* It should never free entries across different clusters */
-	VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
+	VM_BUG_ON(ci != swp_offset_cluster(si, offset + nr_pages - 1));
 	VM_BUG_ON(cluster_is_empty(ci));
 	VM_BUG_ON(ci->count < nr_pages);
 
@@ -1651,9 +1612,9 @@ bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry)
 	struct swap_cluster_info *ci;
 	int count;
 
-	ci = lock_cluster(si, offset);
+	ci = swap_cluster_lock(si, offset);
 	count = swap_count(si->swap_map[offset]);
-	unlock_cluster(ci);
+	swap_cluster_unlock(ci);
 	return !!count;
 }
 
@@ -1676,7 +1637,7 @@ int swp_swapcount(swp_entry_t entry)
 
 	offset = swp_offset(entry);
 
-	ci = lock_cluster(si, offset);
+	ci = swap_cluster_lock(si, offset);
 
 	count = swap_count(si->swap_map[offset]);
 	if (!(count & COUNT_CONTINUED))
@@ -1699,7 +1660,7 @@ int swp_swapcount(swp_entry_t entry)
 		n *= (SWAP_CONT_MAX + 1);
 	} while (tmp_count & COUNT_CONTINUED);
 out:
-	unlock_cluster(ci);
+	swap_cluster_unlock(ci);
 	return count;
 }
 
@@ -1714,7 +1675,7 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 	int i;
 	bool ret = false;
 
-	ci = lock_cluster(si, offset);
+	ci = swap_cluster_lock(si, offset);
 	if (nr_pages == 1) {
 		if (swap_count(map[roffset]))
 			ret = true;
@@ -1727,7 +1688,7 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 		}
 	}
 unlock_out:
-	unlock_cluster(ci);
+	swap_cluster_unlock(ci);
 	return ret;
 }
 
@@ -2661,8 +2622,8 @@ static void wait_for_allocation(struct swap_info_struct *si)
 	BUG_ON(si->flags & SWP_WRITEOK);
 
 	for (offset = 0; offset < end; offset += SWAPFILE_CLUSTER) {
-		ci = lock_cluster(si, offset);
-		unlock_cluster(ci);
+		ci = swap_cluster_lock(si, offset);
+		swap_cluster_unlock(ci);
 	}
 }
 
@@ -3578,7 +3539,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	offset = swp_offset(entry);
 	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
 	VM_WARN_ON(usage == 1 && nr > 1);
-	ci = lock_cluster(si, offset);
+	ci = swap_cluster_lock(si, offset);
 
 	err = 0;
 	for (i = 0; i < nr; i++) {
@@ -3633,7 +3594,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	}
 
 unlock_out:
-	unlock_cluster(ci);
+	swap_cluster_unlock(ci);
 	return err;
 }
 
@@ -3732,7 +3693,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 
 	offset = swp_offset(entry);
 
-	ci = lock_cluster(si, offset);
+	ci = swap_cluster_lock(si, offset);
 
 	count = swap_count(si->swap_map[offset]);
 
@@ -3792,7 +3753,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 out_unlock_cont:
 	spin_unlock(&si->cont_lock);
 out:
-	unlock_cluster(ci);
+	swap_cluster_unlock(ci);
 	put_swap_device(si);
 outer:
 	if (page)
-- 
2.51.0



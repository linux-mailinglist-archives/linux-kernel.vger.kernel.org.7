Return-Path: <linux-kernel+bounces-810635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4510AB51D39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6814611D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398163376AB;
	Wed, 10 Sep 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG9/OLl3"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E133340DA6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520598; cv=none; b=q3+0mscO+wyI7RRixHcUNjDkpsLR9dFaM9tXWNt3q1IzXeXev56o//zw6k+WRCsu/ZqKtKQuW5y6eCQbiMcaQAB2uSSkLrRTycWt6pUSbqbHbrJPtKEErBcAq3N0ZhYtYcDY4UR98q3cHnTf/5COlET2rGVwImNszbVKBTcUWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520598; c=relaxed/simple;
	bh=Jd6aPP8P7OyaDhFSAzivqWPYpoDwtzJxgjnfvz85MaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOT3BzdcefHUSCtg9ugnbN0rvhF6GZon95qjMWu9mYuy5NgtrXzQ2wUG0GGXuDV6fi5PnkUqypvbpY1GZzyMTKxCtF1XUS4jVbp6GiDWXMLrajXj+ztrVNqGeigTivsdXpyeq5T1QvZ5pMg6wRZAeJ3PKYq5CeQI9NMAWvEA9wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG9/OLl3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c8bee055cso5947574a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520596; x=1758125396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gqqOh+GurbkmfIODxteOTLsF6NzKFWqzUJ203IGMWLQ=;
        b=nG9/OLl3xknbBeVba5h1iju1dtHRmn/4ENDeQovAHUH5h12RPJ32uYvPgxQdWiEq1x
         ovY/EjPtrZTX05K6lp/pLQAnT1IcamD2EERDL/E3+Frd8c8YE5RdSRht/l8eQMF5Tqsp
         8tfbZKLU+7vq7drbN+Lj7khN+zIZ3risKFmeFFE0498pP+RKCABRukvB1zv03TJZqO9J
         Xg0v5J4/Iqc3yHEZKNwJNiHt86VSBvbdu7YBePd2CqJTD6P3xBhhMGn1p7dK9C1DLHaC
         mFvoKly0uNVbcDR5ILMffB5foq85S6avWJoqGblYSDU094Z+4dazJySOhTZBDkeJDAXe
         O6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520596; x=1758125396;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gqqOh+GurbkmfIODxteOTLsF6NzKFWqzUJ203IGMWLQ=;
        b=pki196aWLfhshcO8vcazN+05UApYanrSNDMuCu+9Hiz1GZsq7OTMHfTD+5Wgc4VaHd
         lT3dkHCnUsTTatgvYK6rcZhmFlyTDrO25ClDqFMNfVL3luGAKKBiMljL+LTsEBWKiyhZ
         pQsEn+w6jAhzJj5YEwPzBjgmzF+0kdUPSBurQDDyp7THyk/n1Grv50cAOam31LlUZPgk
         cgFzlatJDR/I9zbGq9PmKrwWEmLAF/X2gEoldpl6Vgp173mRYQxXN/jSggqeEWeUdBRU
         o+x+K04R+rckn7R/0Igy4hNPye0gy0VkbiLRIXbEhOv68oVIVUZnbTtHkfL0zx2oGUmu
         FN9g==
X-Forwarded-Encrypted: i=1; AJvYcCUNettcneJ5xBlO13VpePNZvQJnmp8vclavVW6IlY39kzcLAOyGpsSOSbSMeG8/oe2V3ZSQ5tnU7sMxS0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+fejRc7xOMc+B9JX00PI7rRJ3Zq7VvzV/3Z0o8GSFMlIu7wHV
	WEOhrO2C8jvz4/rI181fJUK5MhAo6mhA1vEznnE17ACUXtGrjjt+ha9l
X-Gm-Gg: ASbGnctKcCFjlgiuTAuW/S4xOBh19Zwp7glpvP6hQn/xjGYSS39f79koZP7EIrsoOgm
	pad87vQOq0uQXaAgIrsLpAOve/+1DvDWDKGCxeWjdyRQXMwihoLx4SKwdAZqlemCUQRnwwq5HLY
	6eZ9PvagT+Urk8i1glV51iWPUIzdSfSbf4dQD2j5W0M58/KIYY2gK0HM2IK21K79W6rmmF30pXz
	mTDRw+9qSh2fu5NshM+4OMGnK5vm4XNYtLYrsLF+T3HA3t2d9/4LaRKSbVAjJsLCVFO3TpZ0fBr
	kvTDHIhCRkcvfhShqQ7hSPc4z6zO8JXN8uuuuJ9SiJo9VhOW2x7ucFYdtOcd6UIoxwXgdqKCtuZ
	PhYoBxEJxfyf6dhHAce5Eg8Jjrp5GmoUMm6euOOVEPOnAQG9fFgviR+ljCw==
X-Google-Smtp-Source: AGHT+IG2o7GH+yYlWdqcHRNV6LJZ6go0DoQV2Ggmh0ko7bTKjKCSNDKVLaOYql/uI8eSn27eyHKBeQ==
X-Received: by 2002:a17:90b:1802:b0:32b:ca6f:1231 with SMTP id 98e67ed59e1d1-32d43f05005mr19821868a91.1.1757520595521;
        Wed, 10 Sep 2025 09:09:55 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:55 -0700 (PDT)
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
Subject: [PATCH v3 14/15] mm, swap: implement dynamic allocation of swap table
Date: Thu, 11 Sep 2025 00:08:32 +0800
Message-ID: <20250910160833.3464-15-ryncsn@gmail.com>
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

Now swap table is cluster based, which means free clusters can free its
table since no one should modify it.

There could be speculative readers, like swap cache look up, protect
them by making them RCU protected. All swap table should be filled with
null entries before free, so such readers will either see a NULL pointer
or a null filled table being lazy freed.

On allocation, allocate the table when a cluster is used by any order.

This way, we can reduce the memory usage of large swap device
significantly.

This idea to dynamically release unused swap cluster data was initially
suggested by Chris Li while proposing the cluster swap allocator and
it suits the swap table idea very well.

Co-developed-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Chris Li <chrisl@kernel.org>
---
 mm/swap.h       |   2 +-
 mm/swap_state.c |   9 +--
 mm/swap_table.h |  37 ++++++++-
 mm/swapfile.c   | 202 ++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 199 insertions(+), 51 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index fe5c20922082..8d8efdf1297a 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -36,7 +36,7 @@ struct swap_cluster_info {
 	u16 count;
 	u8 flags;
 	u8 order;
-	atomic_long_t *table;	/* Swap table entries, see mm/swap_table.h */
+	atomic_long_t __rcu *table;	/* Swap table entries, see mm/swap_table.h */
 	struct list_head list;
 };
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 97372539a575..1fc3a9eff8f2 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -91,8 +91,8 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)
 	struct folio *folio;
 
 	for (;;) {
-		swp_tb = __swap_table_get(__swap_entry_to_cluster(entry),
-					  swp_cluster_offset(entry));
+		swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
+					swp_cluster_offset(entry));
 		if (!swp_tb_is_folio(swp_tb))
 			return NULL;
 		folio = swp_tb_to_folio(swp_tb);
@@ -115,11 +115,10 @@ void *swap_cache_get_shadow(swp_entry_t entry)
 {
 	unsigned long swp_tb;
 
-	swp_tb = __swap_table_get(__swap_entry_to_cluster(entry),
-				  swp_cluster_offset(entry));
+	swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
+				swp_cluster_offset(entry));
 	if (swp_tb_is_shadow(swp_tb))
 		return swp_tb_to_shadow(swp_tb);
-
 	return NULL;
 }
 
diff --git a/mm/swap_table.h b/mm/swap_table.h
index e1f7cc009701..52254e455304 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -2,8 +2,15 @@
 #ifndef _MM_SWAP_TABLE_H
 #define _MM_SWAP_TABLE_H
 
+#include <linux/rcupdate.h>
+#include <linux/atomic.h>
 #include "swap.h"
 
+/* A typical flat array in each cluster as swap table */
+struct swap_table {
+	atomic_long_t entries[SWAPFILE_CLUSTER];
+};
+
 /*
  * A swap table entry represents the status of a swap slot on a swap
  * (physical or virtual) device. The swap table in each cluster is a
@@ -76,22 +83,46 @@ static inline void *swp_tb_to_shadow(unsigned long swp_tb)
 static inline void __swap_table_set(struct swap_cluster_info *ci,
 				    unsigned int off, unsigned long swp_tb)
 {
+	atomic_long_t *table = rcu_dereference_protected(ci->table, true);
+
+	lockdep_assert_held(&ci->lock);
 	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
-	atomic_long_set(&ci->table[off], swp_tb);
+	atomic_long_set(&table[off], swp_tb);
 }
 
 static inline unsigned long __swap_table_xchg(struct swap_cluster_info *ci,
 					      unsigned int off, unsigned long swp_tb)
 {
+	atomic_long_t *table = rcu_dereference_protected(ci->table, true);
+
+	lockdep_assert_held(&ci->lock);
 	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
 	/* Ordering is guaranteed by cluster lock, relax */
-	return atomic_long_xchg_relaxed(&ci->table[off], swp_tb);
+	return atomic_long_xchg_relaxed(&table[off], swp_tb);
 }
 
 static inline unsigned long __swap_table_get(struct swap_cluster_info *ci,
 					     unsigned int off)
 {
+	atomic_long_t *table;
+
 	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
-	return atomic_long_read(&ci->table[off]);
+	table = rcu_dereference_check(ci->table, lockdep_is_held(&ci->lock));
+
+	return atomic_long_read(&table[off]);
+}
+
+static inline unsigned long swap_table_get(struct swap_cluster_info *ci,
+					unsigned int off)
+{
+	atomic_long_t *table;
+	unsigned long swp_tb;
+
+	rcu_read_lock();
+	table = rcu_dereference(ci->table);
+	swp_tb = table ? atomic_long_read(&table[off]) : null_to_swp_tb();
+	rcu_read_unlock();
+
+	return swp_tb;
 }
 #endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 89659928465e..faf867a6c5c1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -105,6 +105,8 @@ static DEFINE_SPINLOCK(swap_avail_lock);
 
 struct swap_info_struct *swap_info[MAX_SWAPFILES];
 
+static struct kmem_cache *swap_table_cachep;
+
 static DEFINE_MUTEX(swapon_mutex);
 
 static DECLARE_WAIT_QUEUE_HEAD(proc_poll_wait);
@@ -400,10 +402,17 @@ static inline bool cluster_is_discard(struct swap_cluster_info *info)
 	return info->flags == CLUSTER_FLAG_DISCARD;
 }
 
+static inline bool cluster_table_is_alloced(struct swap_cluster_info *ci)
+{
+	return rcu_dereference_protected(ci->table, lockdep_is_held(&ci->lock));
+}
+
 static inline bool cluster_is_usable(struct swap_cluster_info *ci, int order)
 {
 	if (unlikely(ci->flags > CLUSTER_FLAG_USABLE))
 		return false;
+	if (!cluster_table_is_alloced(ci))
+		return false;
 	if (!order)
 		return true;
 	return cluster_is_empty(ci) || order == ci->order;
@@ -421,32 +430,98 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
 	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
 }
 
-static int swap_cluster_alloc_table(struct swap_cluster_info *ci)
+static void swap_cluster_free_table(struct swap_cluster_info *ci)
 {
-	WARN_ON(ci->table);
-	ci->table = kzalloc(sizeof(unsigned long) * SWAPFILE_CLUSTER, GFP_KERNEL);
-	if (!ci->table)
-		return -ENOMEM;
-	return 0;
+	unsigned int ci_off;
+	struct swap_table *table;
+
+	/* Only empty cluster's table is allow to be freed  */
+	lockdep_assert_held(&ci->lock);
+	VM_WARN_ON_ONCE(!cluster_is_empty(ci));
+	for (ci_off = 0; ci_off < SWAPFILE_CLUSTER; ci_off++)
+		VM_WARN_ON_ONCE(!swp_tb_is_null(__swap_table_get(ci, ci_off)));
+	table = (void *)rcu_dereference_protected(ci->table, true);
+	rcu_assign_pointer(ci->table, NULL);
+
+	kmem_cache_free(swap_table_cachep, table);
 }
 
-static void swap_cluster_free_table(struct swap_cluster_info *ci)
+/*
+ * Allocate a swap table may need to sleep, which leads to migration,
+ * so attempt an atomic allocation first then fallback and handle
+ * potential race.
+ */
+static struct swap_cluster_info *
+swap_cluster_alloc_table(struct swap_info_struct *si,
+			 struct swap_cluster_info *ci,
+			 int order)
 {
-	unsigned int ci_off;
-	unsigned long swp_tb;
+	struct swap_cluster_info *pcp_ci;
+	struct swap_table *table;
+	unsigned long offset;
 
-	if (!ci->table)
-		return;
+	/*
+	 * Only cluster isolation from the allocator does table allocation.
+	 * Swap allocator uses a percpu cluster and holds the local lock.
+	 */
+	lockdep_assert_held(&ci->lock);
+	lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
+
+	table = kmem_cache_zalloc(swap_table_cachep,
+				  __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
+	if (table) {
+		rcu_assign_pointer(ci->table, table);
+		return ci;
+	}
+
+	/*
+	 * Try a sleep allocation. Each isolated free cluster may cause
+	 * a sleep allocation, but there is a limited number of them, so
+	 * the potential recursive allocation should be limited.
+	 */
+	spin_unlock(&ci->lock);
+	if (!(si->flags & SWP_SOLIDSTATE))
+		spin_unlock(&si->global_cluster_lock);
+	local_unlock(&percpu_swap_cluster.lock);
+	table = kmem_cache_zalloc(swap_table_cachep, __GFP_HIGH | GFP_KERNEL);
 
-	for (ci_off = 0; ci_off < SWAPFILE_CLUSTER; ci_off++) {
-		swp_tb = __swap_table_get(ci, ci_off);
-		if (!swp_tb_is_null(swp_tb))
-			pr_err_once("swap: unclean swap space on swapoff: 0x%lx",
-				    swp_tb);
+	local_lock(&percpu_swap_cluster.lock);
+	if (!(si->flags & SWP_SOLIDSTATE))
+		spin_lock(&si->global_cluster_lock);
+	/*
+	 * Back to atomic context. First, check if we migrated to a new
+	 * CPU with a usable percpu cluster. If so, try using that instead.
+	 * No need to check it for the spinning device, as swap is
+	 * serialized by the global lock on them.
+	 *
+	 * The is_usable check is a bit rough, but ensures order 0 success.
+	 */
+	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
+	if ((si->flags & SWP_SOLIDSTATE) && offset) {
+		pcp_ci = swap_cluster_lock(si, offset);
+		if (cluster_is_usable(pcp_ci, order) &&
+		    pcp_ci->count < SWAPFILE_CLUSTER) {
+			ci = pcp_ci;
+			goto free_table;
+		}
+		swap_cluster_unlock(pcp_ci);
 	}
 
-	kfree(ci->table);
-	ci->table = NULL;
+	if (!table)
+		return NULL;
+
+	spin_lock(&ci->lock);
+	/* Nothing should have touched the dangling empty cluster. */
+	if (WARN_ON_ONCE(cluster_table_is_alloced(ci)))
+		goto free_table;
+
+	rcu_assign_pointer(ci->table, table);
+	return ci;
+
+free_table:
+	if (table)
+		kmem_cache_free(swap_table_cachep, table);
+	return ci;
 }
 
 static void move_cluster(struct swap_info_struct *si,
@@ -478,7 +553,7 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 
 static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
-	lockdep_assert_held(&ci->lock);
+	swap_cluster_free_table(ci);
 	move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
 	ci->order = 0;
 }
@@ -493,15 +568,11 @@ static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info
  * this returns NULL for an non-empty list.
  */
 static struct swap_cluster_info *isolate_lock_cluster(
-		struct swap_info_struct *si, struct list_head *list)
+		struct swap_info_struct *si, struct list_head *list, int order)
 {
-	struct swap_cluster_info *ci, *ret = NULL;
+	struct swap_cluster_info *ci, *found = NULL;
 
 	spin_lock(&si->lock);
-
-	if (unlikely(!(si->flags & SWP_WRITEOK)))
-		goto out;
-
 	list_for_each_entry(ci, list, list) {
 		if (!spin_trylock(&ci->lock))
 			continue;
@@ -513,13 +584,19 @@ static struct swap_cluster_info *isolate_lock_cluster(
 
 		list_del(&ci->list);
 		ci->flags = CLUSTER_FLAG_NONE;
-		ret = ci;
+		found = ci;
 		break;
 	}
-out:
 	spin_unlock(&si->lock);
 
-	return ret;
+	if (found && !cluster_table_is_alloced(found)) {
+		/* Only an empty free cluster's swap table can be freed. */
+		VM_WARN_ON_ONCE(list != &si->free_clusters);
+		VM_WARN_ON_ONCE(!cluster_is_empty(found));
+		return swap_cluster_alloc_table(si, found, order);
+	}
+
+	return found;
 }
 
 /*
@@ -652,17 +729,27 @@ static void relocate_cluster(struct swap_info_struct *si,
  * added to free cluster list and its usage counter will be increased by 1.
  * Only used for initialization.
  */
-static void inc_cluster_info_page(struct swap_info_struct *si,
+static int inc_cluster_info_page(struct swap_info_struct *si,
 	struct swap_cluster_info *cluster_info, unsigned long page_nr)
 {
 	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
+	struct swap_table *table;
 	struct swap_cluster_info *ci;
 
 	ci = cluster_info + idx;
+	if (!ci->table) {
+		table = kmem_cache_zalloc(swap_table_cachep, GFP_KERNEL);
+		if (!table)
+			return -ENOMEM;
+		rcu_assign_pointer(ci->table, table);
+	}
+
 	ci->count++;
 
 	VM_BUG_ON(ci->count > SWAPFILE_CLUSTER);
 	VM_BUG_ON(ci->flags);
+
+	return 0;
 }
 
 static bool cluster_reclaim_range(struct swap_info_struct *si,
@@ -844,7 +931,7 @@ static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
 	unsigned int found = SWAP_ENTRY_INVALID;
 
 	do {
-		struct swap_cluster_info *ci = isolate_lock_cluster(si, list);
+		struct swap_cluster_info *ci = isolate_lock_cluster(si, list, order);
 		unsigned long offset;
 
 		if (!ci)
@@ -869,7 +956,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 	if (force)
 		to_scan = swap_usage_in_pages(si) / SWAPFILE_CLUSTER;
 
-	while ((ci = isolate_lock_cluster(si, &si->full_clusters))) {
+	while ((ci = isolate_lock_cluster(si, &si->full_clusters, 0))) {
 		offset = cluster_offset(si, ci);
 		end = min(si->max, offset + SWAPFILE_CLUSTER);
 		to_scan--;
@@ -1017,6 +1104,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 done:
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster_lock);
+
 	return found;
 }
 
@@ -1884,7 +1972,13 @@ swp_entry_t get_swap_page_of_type(int type)
 	/* This is called for allocating swap entry, not cache */
 	if (get_swap_device_info(si)) {
 		if (si->flags & SWP_WRITEOK) {
+			/*
+			 * Grab the local lock to be complaint
+			 * with swap table allocation.
+			 */
+			local_lock(&percpu_swap_cluster.lock);
 			offset = cluster_alloc_swap_entry(si, 0, 1);
+			local_unlock(&percpu_swap_cluster.lock);
 			if (offset) {
 				entry = swp_entry(si->type, offset);
 				atomic_long_dec(&nr_swap_pages);
@@ -2678,12 +2772,21 @@ static void wait_for_allocation(struct swap_info_struct *si)
 static void free_cluster_info(struct swap_cluster_info *cluster_info,
 			      unsigned long maxpages)
 {
+	struct swap_cluster_info *ci;
 	int i, nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 
 	if (!cluster_info)
 		return;
-	for (i = 0; i < nr_clusters; i++)
-		swap_cluster_free_table(&cluster_info[i]);
+	for (i = 0; i < nr_clusters; i++) {
+		ci = cluster_info + i;
+		/* Cluster with bad marks count will have a remaining table */
+		spin_lock(&ci->lock);
+		if (rcu_dereference_protected(ci->table, true)) {
+			ci->count = 0;
+			swap_cluster_free_table(ci);
+		}
+		spin_unlock(&ci->lock);
+	}
 	kvfree(cluster_info);
 }
 
@@ -2719,6 +2822,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	struct address_space *mapping;
 	struct inode *inode;
 	struct filename *pathname;
+	unsigned int maxpages;
 	int err, found = 0;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -2825,8 +2929,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->swap_map = NULL;
 	zeromap = p->zeromap;
 	p->zeromap = NULL;
+	maxpages = p->max;
 	cluster_info = p->cluster_info;
-	free_cluster_info(cluster_info, p->max);
 	p->max = 0;
 	p->cluster_info = NULL;
 	spin_unlock(&p->lock);
@@ -2838,6 +2942,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->global_cluster = NULL;
 	vfree(swap_map);
 	kvfree(zeromap);
+	free_cluster_info(cluster_info, maxpages);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
 
@@ -3216,11 +3321,8 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	if (!cluster_info)
 		goto err;
 
-	for (i = 0; i < nr_clusters; i++) {
+	for (i = 0; i < nr_clusters; i++)
 		spin_lock_init(&cluster_info[i].lock);
-		if (swap_cluster_alloc_table(&cluster_info[i]))
-			goto err_free;
-	}
 
 	if (!(si->flags & SWP_SOLIDSTATE)) {
 		si->global_cluster = kmalloc(sizeof(*si->global_cluster),
@@ -3239,16 +3341,23 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	 * See setup_swap_map(): header page, bad pages,
 	 * and the EOF part of the last cluster.
 	 */
-	inc_cluster_info_page(si, cluster_info, 0);
+	err = inc_cluster_info_page(si, cluster_info, 0);
+	if (err)
+		goto err;
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 
 		if (page_nr >= maxpages)
 			continue;
-		inc_cluster_info_page(si, cluster_info, page_nr);
+		err = inc_cluster_info_page(si, cluster_info, page_nr);
+		if (err)
+			goto err;
+	}
+	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++) {
+		err = inc_cluster_info_page(si, cluster_info, i);
+		if (err)
+			goto err;
 	}
-	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++)
-		inc_cluster_info_page(si, cluster_info, i);
 
 	INIT_LIST_HEAD(&si->free_clusters);
 	INIT_LIST_HEAD(&si->full_clusters);
@@ -3962,6 +4071,15 @@ static int __init swapfile_init(void)
 
 	swapfile_maximum_size = arch_max_swapfile_size();
 
+	/*
+	 * Once a cluster is freed, it's swap table content is read
+	 * only, and all swap cache readers (swap_cache_*) verifies
+	 * the content before use. So it's safe to use RCU slab here.
+	 */
+	swap_table_cachep = kmem_cache_create("swap_table",
+			    sizeof(struct swap_table),
+			    0, SLAB_PANIC | SLAB_TYPESAFE_BY_RCU, NULL);
+
 #ifdef CONFIG_MIGRATION
 	if (swapfile_maximum_size >= (1UL << SWP_MIG_TOTAL_BITS))
 		swap_migration_ad_supported = true;
-- 
2.51.0



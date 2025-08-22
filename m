Return-Path: <linux-kernel+bounces-782620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084C0B322C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2637B4707
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563372D0C9A;
	Fri, 22 Aug 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj07X/x/"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5B2D29CE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890497; cv=none; b=AekoSIyn7KJGmXC8MQ1YPpJ/lMTJZZ4ntQwm/Hk1CW9kDImrY5JtD7rUl3Tp5eB7dtBDcXZhkDQXyjfmrZgH+5kAOcF8eU2D+Um4gw4ojzOyx4IYK4S3b6sS4cS+AXM4PrHjGuQEEIpqi+qwm/Zy8ljrKv5qOSkAT/nlDjcyf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890497; c=relaxed/simple;
	bh=5rK4SwRFvQzbgX/TQX0tgetfJggWpeZNg1M09C8OTjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jX2JyP2pamOjXkyAWxRAwsn/i+P9tnfBjmaEiZMbFnAV0ijvVkX0J3KobnWbcFS31DC2mYyf7vRvJgCOl5FQHyzp74u0s0LhMvxPBrDrHxYNFHlDcFPqgCWp+w7yVcqDNLePHJM1khdVBoz59Ejmh3MRw9sHZD9+8jUQd4AqZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj07X/x/; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70ba7aa13dcso21653446d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890494; x=1756495294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2L+hJE+IB0iUcVlUYZZhbpmVEvEPmj5Vj/KEQQntKcM=;
        b=Kj07X/x/+QZXIH3xFjON5tvtVRHt6IfnXKMs3061enY0Z8fXDIdI84ggDFrnXKTENL
         8v3J9/wl98pO8drd/Qkku3GCImbX+nRAUDJdJ2hN0hzVc2+5knRlLF0q7v/+l1EuKqcp
         5NaR52DeYRHaImx7G501NJI9qyBmDcsrDS4c5HRXeo95E9OpbNOkZdUkTHG5+cB1rLMc
         mFFgpC0JgLltldf6sFn0rqK+t1tJNp2+Oq2FHQ8WJ6v1TyUB99kfY8LC1hL6GVbOlWMq
         RCJ7QEU5Mxy2rSyc+nyPJh+3CoEB5FDZ+391JZQDKeHAK9sQDdPl2OjEErQUbtyw7GWA
         FpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890494; x=1756495294;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2L+hJE+IB0iUcVlUYZZhbpmVEvEPmj5Vj/KEQQntKcM=;
        b=gFiEdcQ9WBpeFqKb8HP8NzwoBQ/RfHAbylQjQkRhyTJqw0wz9cVteUZQFxK9ie5avd
         qWB/+CbNhjwA4p5xm8ybelF8b+/9r3TsqSvqEakPaXXdqvfbsmDsxwVMbpJmphU/enbX
         0bb6mVnP4Iw6sdTkEJpefgAQKQkysIseXd7vzottcv3XirtQsPws24KHx+ABJR5ZxNWH
         OXUQtR/GU53jghY2xNgApvf7PhDa1+t694AA581erOTMnRMAuZocpLAhT2PB3CSHIewd
         DdePxNtzkhx2U7BDe/EiCJTtYZVuFd3eXgKBvjNovN29+I/g/pRVqzFSslNRGtUVpwZk
         B4lA==
X-Forwarded-Encrypted: i=1; AJvYcCXvbl8IYcBCy1BxYQtTbDJrYdWhJCQgQkcGGxtNx1TnH3AvKHKDb3tQJj/iAgAea1Lzrrqzd+9gIF15uTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxE8baIYK8JSerar7RKqPn0yeSs8k6SOjG9daI5mR7Sj4tjRY7
	+fNEYE5Ki07J6ghN/AlAS/ivmUgwa0TgyRrWIUCww5FX9SkKbt6/zaq/
X-Gm-Gg: ASbGnctKY7H70nc01wTXMGZBEAYRBiD+TowUKefSnp6cJXvqnLPDQ4xGKSHWQPZlCCF
	nOtZOSyEbnIPH+RZDNatJQKkGgaZNAKvFAnl9dyCCQxlhXEfk9PYCQ2qekPHAmNjDbGihT2oy93
	88H3EErS3z3F09RYoU0fCV31pmcstCKtgoY7QLgzYYZ8ld6g7TxfAnNnVHdnTxFHFUO2R4w10oB
	d8luy+HZZqfRuocR2hHYPdnTwVN8zdKf8NEDLa0ZIYSJ1JQZ9KCLKlDjhJyniW4mLN1f6tFAlOx
	gRXEeLHDQv8Ln9/TvkbbkoOvxKlXaEGDP5NQiP2wnATB2QbI4v51B5CU/YP/mgAm4vU8BggkZbl
	sriekADDeuM0buLQUMhxvQB5byFQfFA9817VhT0IqlGM=
X-Google-Smtp-Source: AGHT+IGGbnFrGqyosDOoF0G2Qyk9vRWcSTgBb+CggxPJw9xuwtxeZh8Y9UnfLYcZ+rG800PIBXDPzQ==
X-Received: by 2002:a05:6214:21cd:b0:709:f305:705d with SMTP id 6a1803df08f44-70d9722c613mr53385776d6.19.1755890493703;
        Fri, 22 Aug 2025 12:21:33 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm3843656d6.52.2025.08.22.12.21.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 12:21:33 -0700 (PDT)
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
Subject: [PATCH 8/9] mm, swap: implement dynamic allocation of swap table
Date: Sat, 23 Aug 2025 03:20:22 +0800
Message-ID: <20250822192023.13477-9-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822192023.13477-1-ryncsn@gmail.com>
References: <20250822192023.13477-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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
them by making them RCU safe. All swap table should be filled with null
entries before free, so such readers will either see a NULL pointer or
a null filled table being lazy freed.

On allocation, allocate the table when a cluster is used by any order.

This way, we can reduce the memory usage of large swap device
significantly.

This idea to dynamically release unused swap cluster data was initially
suggested by Chris Li while proposing the cluster swap allocator and
I found it suits the swap table idea very well.

Co-developed-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       |   2 +-
 mm/swap_state.c |   9 ++-
 mm/swap_table.h |  32 +++++++-
 mm/swapfile.c   | 202 ++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 197 insertions(+), 48 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index ce3ec62cc05e..ee33733027f4 100644
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
index c0342024b4a8..a0120d822fbe 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -87,7 +87,8 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)
 	struct folio *folio;
 
 	for (;;) {
-		swp_tb = __swap_table_get(swp_cluster(entry), swp_cluster_offset(entry));
+		swp_tb = swap_table_get(swp_cluster(entry),
+					swp_cluster_offset(entry));
 		if (!swp_tb_is_folio(swp_tb))
 			return NULL;
 		folio = swp_tb_to_folio(swp_tb);
@@ -107,10 +108,9 @@ void *swap_cache_get_shadow(swp_entry_t entry)
 {
 	unsigned long swp_tb;
 
-	swp_tb = __swap_table_get(swp_cluster(entry), swp_cluster_offset(entry));
+	swp_tb = swap_table_get(swp_cluster(entry), swp_cluster_offset(entry));
 	if (swp_tb_is_shadow(swp_tb))
 		return swp_tb_to_shadow(swp_tb);
-
 	return NULL;
 }
 
@@ -135,6 +135,9 @@ int swap_cache_add_folio(swp_entry_t entry, struct folio *folio, void **shadowp)
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
 
 	ci = swap_cluster_lock(swp_info(entry), swp_offset(entry));
+	if (unlikely(!ci->table))
+		goto fail;
+
 	ci_start = swp_cluster_offset(entry);
 	ci_end = ci_start + nr_pages;
 	ci_off = ci_start;
diff --git a/mm/swap_table.h b/mm/swap_table.h
index ed9676547071..4e97513b11ef 100644
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
@@ -76,15 +83,36 @@ static inline void *swp_tb_to_shadow(unsigned long swp_tb)
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
 
 static inline void __swap_table_set_folio(struct swap_cluster_info *ci,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0c8001c99f30..00651e947eb2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -105,6 +105,8 @@ static DEFINE_SPINLOCK(swap_avail_lock);
 
 struct swap_info_struct *swap_info[MAX_SWAPFILES];
 
+static struct kmem_cache *swap_table_cachep;
+
 static DEFINE_MUTEX(swapon_mutex);
 
 static DECLARE_WAIT_QUEUE_HEAD(proc_poll_wait);
@@ -402,10 +404,17 @@ static inline bool cluster_is_discard(struct swap_cluster_info *info)
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
@@ -423,32 +432,98 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
 	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
 }
 
-static int swap_table_alloc_table(struct swap_cluster_info *ci)
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
@@ -480,7 +555,7 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 
 static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
-	lockdep_assert_held(&ci->lock);
+	swap_cluster_free_table(ci);
 	move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
 	ci->order = 0;
 }
@@ -495,15 +570,11 @@ static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info
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
@@ -515,13 +586,19 @@ static struct swap_cluster_info *isolate_lock_cluster(
 
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
@@ -654,17 +731,27 @@ static void relocate_cluster(struct swap_info_struct *si,
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
@@ -845,7 +932,7 @@ static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
 	unsigned int found = SWAP_ENTRY_INVALID;
 
 	do {
-		struct swap_cluster_info *ci = isolate_lock_cluster(si, list);
+		struct swap_cluster_info *ci = isolate_lock_cluster(si, list, order);
 		unsigned long offset;
 
 		if (!ci)
@@ -870,7 +957,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 	if (force)
 		to_scan = swap_usage_in_pages(si) / SWAPFILE_CLUSTER;
 
-	while ((ci = isolate_lock_cluster(si, &si->full_clusters))) {
+	while ((ci = isolate_lock_cluster(si, &si->full_clusters, 0))) {
 		offset = cluster_offset(si, ci);
 		end = min(si->max, offset + SWAPFILE_CLUSTER);
 		to_scan--;
@@ -1018,6 +1105,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 done:
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster_lock);
+
 	return found;
 }
 
@@ -1885,7 +1973,13 @@ swp_entry_t get_swap_page_of_type(int type)
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
-		if (swap_table_alloc_table(&cluster_info[i]))
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



Return-Path: <linux-kernel+bounces-819219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B692FB59CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1491D3A624F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF1B3054FC;
	Tue, 16 Sep 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugsrz9iG"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180D31FEFE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038573; cv=none; b=tAeGxdax0X3TnuqMkBKlcfehT124B/IR90bk0RCpfymldtPcVQjA/sTMTz6NFI15g5MLRoIPT6ZlD31KhjzrA17cfAlY3MVuw0A0nyVOFg30TD9nW459Ckl7SThxMJ3GwnTi+dcHv66JgsTa5vhDWGsC900z7ZPiEv/BpeHskuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038573; c=relaxed/simple;
	bh=ESgZ4Pu7dz4sQrjEgwaAL/nLhTL2WCOWrRvYy9cFBe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn+p4uJ+2RLavR8lj9t9gZr8ja7CDPAZketh2m1AzLOaV+lxcimlvYO3A82eaSbDlx3cKu51axpsSLZ7vPuXQJEb6hRh7nRMw0O28cJmc9T7ZQuHorZRD7Jt6Clh8+PravKT2GCxz+msB9PHyuCGnGzm470JcAObUqKoF0/+Nus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ugsrz9iG; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-80a6937c8c6so674021085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038571; x=1758643371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9A/r73fYL/BjndHTsKAtIDgbtMgmgaZIN32sPZEUv0=;
        b=Ugsrz9iGfbnRe5g2nxE+ZRFLbSePFf+omaLxB6LHtHOxL7CfKhAlZW0LgzoCDfeO6D
         +WodREt0eNPOt83WZQG5FJmXrvOg88mJvzj0lJylKhgG9kvRs8IQLOgzh/EghxNrIWxU
         clXe7gQdvTDkbNIaXSrDpR/669cT+Th+O6VhOBt4O7cJxgEaoIjvRg1DJy8MLL61eYiR
         OMHLdXsjiS2CFec6P4KZXj+fsAMDUfLfD3hCiLiDJ4nK6DJ0GIwqaegdvoZXI5kkuAnC
         uXAQGzlLXLhea9uXGY1l3VgQK6/SloMTaNs2wRqHU4ErddHOoMc7RNSUZYMFBJGkTNJB
         4J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038571; x=1758643371;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9A/r73fYL/BjndHTsKAtIDgbtMgmgaZIN32sPZEUv0=;
        b=nW/YZ9ZKwdyS/ATVSMeybwbPw8kcwNH22XDSKnA/MxwTkvq2DePVODYH3MOvicS4Bh
         QsOWYKmGXLopHKZbDMiS0UNJSZt/IdwY9U+3P4E7kXj2cfhNdY7K8KhcF4exSpiU46OJ
         v4/9cIwrPbzNiA6+G3g2i8Jvxz4ITq8130QE+BTCF0d061nHoNGYOTDf3TA8DKx/60/L
         nj0B/bKGBaIOtBUd8clB78BAfbDxtl5uUZQ6HA9KmX4sKSSUwzoTw75Nqv63W5sLRAcF
         UjYALU+8qshZBd7yraI8GsT94WHrZlcsOH1e+QVnWe6pLWTRhiYDdBb7qInQPj0s73jV
         F2RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmjdvNTUyE2Wt9NWh146Nf32fNj6S5yV0jGfz1zkJT65/5/sjsV7oT3DKSgKO6GUxUJWh4NUZ6qcc75Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF858HrbszZwr9uPYQLom1kGoGbzpzjMFyiTqqMjFQjCw7jqlP
	CIB3dRLD3nF7Ps9xOAhQ6eRrgd0QABu5XKaIWc64KTCKCviCKe0JfROF
X-Gm-Gg: ASbGncsSoU5cWcoQDi1kNe7PrP/p9I19xf37ofKrNvtG+zLlw/26vFOriL1yRktDi0a
	NUauRxE4H8JBObz229QZHR8OXT7kNslIPd9lst7tJ8rw+XUbtN+Uc1cS5uJQet56f1Zx4iGlWTX
	Gj770ANPR8M84sme32l2AO7QRLOFGMA2cETd0fw6WhfGz6k9zCS5Svv4Eh0zVqcL0d2OpW72Z6/
	sX95KLmidEOx+lQTqfOxwPiTlAsPHtOTtEC806vygdjj1gaM3k4+zKxYMphNuvRXfrDAq4y8tLr
	eNCR9WNoZlNLNn1EwpRYsi/pi036MMz7j7D9TIWUTlBw47UmdKz1U//0Hpj5iJzcZVvu61moijp
	o2IDTy77RLNc20QV+1pd1DpA8LwFWW8Wh/LBh4/wtMtm2N5Q=
X-Google-Smtp-Source: AGHT+IF5wX/REvlgTwvjKzwh4z5xhh7WT1WZw3CdRiSULPQtDINM9vMmX/dyP5zoX4P09Uasw0kMqw==
X-Received: by 2002:a05:620a:2951:b0:82b:3775:666e with SMTP id af79cd13be357-82b37756728mr503323685a.36.1758038570391;
        Tue, 16 Sep 2025 09:02:50 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm969765485a.37.2025.09.16.09.02.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 09:02:49 -0700 (PDT)
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
Subject: [PATCH v4 15/15] mm, swap: use a single page for swap table when the size fits
Date: Wed, 17 Sep 2025 00:01:00 +0800
Message-ID: <20250916160100.31545-16-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916160100.31545-1-ryncsn@gmail.com>
References: <20250916160100.31545-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

We have a cluster size of 512 slots. Each slot consumes 8 bytes in swap
table so the swap table size of each cluster is exactly one page (4K).

If that condition is true, allocate one page direct and disable the slab
cache to reduce the memory usage of swap table and avoid fragmentation.

Co-developed-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Chris Li <chrisl@kernel.org>
---
 mm/swap_table.h |  2 ++
 mm/swapfile.c   | 51 +++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/mm/swap_table.h b/mm/swap_table.h
index 52254e455304..ea244a57a5b7 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -11,6 +11,8 @@ struct swap_table {
 	atomic_long_t entries[SWAPFILE_CLUSTER];
 };
 
+#define SWP_TABLE_USE_PAGE (sizeof(struct swap_table) == PAGE_SIZE)
+
 /*
  * A swap table entry represents the status of a swap slot on a swap
  * (physical or virtual) device. The swap table in each cluster is a
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 094e3e75849f..890b410d77b6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -434,6 +434,38 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
 	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
 }
 
+static struct swap_table *swap_table_alloc(gfp_t gfp)
+{
+	struct folio *folio;
+
+	if (!SWP_TABLE_USE_PAGE)
+		return kmem_cache_zalloc(swap_table_cachep, gfp);
+
+	folio = folio_alloc(gfp | __GFP_ZERO, 0);
+	if (folio)
+		return folio_address(folio);
+	return NULL;
+}
+
+static void swap_table_free_folio_rcu_cb(struct rcu_head *head)
+{
+	struct folio *folio;
+
+	folio = page_folio(container_of(head, struct page, rcu_head));
+	folio_put(folio);
+}
+
+static void swap_table_free(struct swap_table *table)
+{
+	if (!SWP_TABLE_USE_PAGE) {
+		kmem_cache_free(swap_table_cachep, table);
+		return;
+	}
+
+	call_rcu(&(folio_page(virt_to_folio(table), 0)->rcu_head),
+		 swap_table_free_folio_rcu_cb);
+}
+
 static void swap_cluster_free_table(struct swap_cluster_info *ci)
 {
 	unsigned int ci_off;
@@ -447,7 +479,7 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 	table = (void *)rcu_dereference_protected(ci->table, true);
 	rcu_assign_pointer(ci->table, NULL);
 
-	kmem_cache_free(swap_table_cachep, table);
+	swap_table_free(table);
 }
 
 /*
@@ -470,8 +502,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	/* The cluster must be free and was just isolated from the free list. */
 	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
 
-	table = kmem_cache_zalloc(swap_table_cachep,
-				  __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
+	table = swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
 	if (table) {
 		rcu_assign_pointer(ci->table, table);
 		return ci;
@@ -487,8 +518,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 		spin_unlock(&si->global_cluster_lock);
 	local_unlock(&percpu_swap_cluster.lock);
 
-	table = kmem_cache_zalloc(swap_table_cachep,
-				  __GFP_HIGH | __GFP_NOMEMALLOC | GFP_KERNEL);
+	table = swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | GFP_KERNEL);
 
 	/*
 	 * Back to atomic context. We might have migrated to a new CPU with a
@@ -506,7 +536,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	/* Nothing except this helper should touch a dangling empty cluster. */
 	if (WARN_ON_ONCE(cluster_table_is_alloced(ci))) {
 		if (table)
-			kmem_cache_free(swap_table_cachep, table);
+			swap_table_free(table);
 		return ci;
 	}
 
@@ -734,7 +764,7 @@ static int inc_cluster_info_page(struct swap_info_struct *si,
 
 	ci = cluster_info + idx;
 	if (!ci->table) {
-		table = kmem_cache_zalloc(swap_table_cachep, GFP_KERNEL);
+		table = swap_table_alloc(GFP_KERNEL);
 		if (!table)
 			return -ENOMEM;
 		rcu_assign_pointer(ci->table, table);
@@ -4072,9 +4102,10 @@ static int __init swapfile_init(void)
 	 * only, and all swap cache readers (swap_cache_*) verifies
 	 * the content before use. So it's safe to use RCU slab here.
 	 */
-	swap_table_cachep = kmem_cache_create("swap_table",
-			    sizeof(struct swap_table),
-			    0, SLAB_PANIC | SLAB_TYPESAFE_BY_RCU, NULL);
+	if (!SWP_TABLE_USE_PAGE)
+		swap_table_cachep = kmem_cache_create("swap_table",
+				    sizeof(struct swap_table),
+				    0, SLAB_PANIC | SLAB_TYPESAFE_BY_RCU, NULL);
 
 #ifdef CONFIG_MIGRATION
 	if (swapfile_maximum_size >= (1UL << SWP_MIG_TOTAL_BITS))
-- 
2.51.0



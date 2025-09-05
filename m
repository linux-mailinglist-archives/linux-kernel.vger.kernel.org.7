Return-Path: <linux-kernel+bounces-803658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20420B46366
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C6F5A7822
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E05280A52;
	Fri,  5 Sep 2025 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrVCZyET"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96892C11D7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099734; cv=none; b=sUvgfI0WQkRjCKFYtQWjxTcqUIoXzfZ35inZ0vuve676jaVh/3Y2kAzi+wZ3X7bn104fUUJ4GTa7C5MlZXv868apd8Eo0lICM9Hy3wP1RIbrvKNrM+RZ/DsA02GlyCo57I1QBugsKefTn519jlK1RWF9kgJbGFr2ReEvGzzDFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099734; c=relaxed/simple;
	bh=NGwrA9wyWoMs2ccSuQdy7uAj7hR7kS65CEQYH5Ncug4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq6+G5W0PXzWzz68GxYmXg9mxTWbmA1WtnltwQD5IY1K/AYHKedbCMoMUoN6PO2gyq/kMPM9T+6+O+m04ObX0j5TzDCIcBxSE6xANBjYLwPoND1PvEvBP7BzDiV8u9rtiZ+nVs/ebUVprE0j8jdn6V0S6EWxeVkMkb+oez1puF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrVCZyET; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77256e75eacso2307540b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099732; x=1757704532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e9tXoC30u8cptZoeY7RVmNYN+rcCikIe4hnTmAJUGE4=;
        b=TrVCZyETTQoxt7geUAVsxxKF7gQ7xVxwxo5osgwrswycibhMo4gesANTQUNtLHcvqS
         eIYyc8iPx8d/vRz968FJ4aHla/wZm0J5QrhBZRrQ2+tZediv1LyU/jj5So+e5QoEEALs
         T7Rs/E3/Wm5OBaXwJoL9BErMGQVQ5tSLfHy5/srOdar8UYpaynujuJ85vPQH5ITEkO41
         qupzPdjbaB47nwnKz3cgiQfyPq6HMBRFEUk7MRY5tGKU6AsV+vLBUaW8r+3GQIWK7Dyl
         m6MZCM+Sk/0c4348A6yDLoupLra9k9g/LaRyaptpipjmOHvlpA7Qz+9mxPjzMIwupAQT
         XVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099732; x=1757704532;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9tXoC30u8cptZoeY7RVmNYN+rcCikIe4hnTmAJUGE4=;
        b=acQNu4KGMCzQ0kuTyVPUH0nAcoDAfMGckmKeYAhH1OyPdfKwfBRCNtcFdf7QocGPQR
         U5cicKNb5uRgOi4vlSFMaGjTE3xRJB5aN0RGXSSzpHkdZ0djhS6cfeuzu+lkrm+qjcM2
         GOoZ8A1D7j3EvRxIzX3kr1qeibZs/V8ckUCcG1oJBn8dUBnNEALnJsqaVY8yp5mSy7kf
         qUKM38gv0VnPcJDtPwcZoBWANkPEPcOPjxMkZH4tSfZ1OsTWWxCg4FPcrCKSpwXqlCeM
         AfaWMiOzwRie2XANcO3bd+2/6gzWtuOreWARxafu8taxZaP3Z5YMhdC4h8lpJDIuEDH/
         RmVg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Phf5Nn7qZPzq3i9RBXN0OjCAPSt1pbN1cIu0p9i0i4JMdw8+b1Aev/YWP3EGU5ZmQr+4SzIq4mvY4pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5Ab8icQ5mbmjK+Q8bH0YNceEasKrARWx6zfBRoY1I09Ia5qj
	hrojxCM/+Duuurpp3yKOPwI6dynX5Q8CCfnQj6Jr1mSXTtCXoSk5PoTC
X-Gm-Gg: ASbGncuTSmOGam70Ddt2YDudjn9ZXuYqbnmWeI+g3ySCtYaEr4Hzi93Uq5IvNrm+i4Q
	dgCJyX0UcpWrBlAeoLYYgrpObn3l/QRT2COtfL9935Sytwn5p65r621RUsbOaEyysql5YkeXvkt
	M6eqfKPr9OhYrLW12v0OjmdOZzmLEhFytNSgft7Y7h2sdu/guPb4b3+DBDtAIAt9B04ZVQ9YKjK
	2HbQorLd7v2taKho/hP8H1LFgDt7HetdD0Fu0NmFcKKiMCHxoZIIzMdYOtbUGNvS0puaN/ssm31
	gLZqaT8SUYLx6bcHcz8KEskiZAAeXnpzIPHAX3lnssJKHBj7qaGzkFVTNjs4VKbTB+8Dr8jJcgR
	GahX7dDSrZx0gxooqfjHOAWl7pnaeeHx6yQEjXQt3yKZ+QCs=
X-Google-Smtp-Source: AGHT+IHA4LeWAP5Z6VrdlIQxPr/w7slkyPGU20hMWH4nHy3XJM2DXNYOG9uwEY4Srtf0PoS266Phcw==
X-Received: by 2002:a05:6a20:a109:b0:24f:2251:84f9 with SMTP id adf61e73a8af0-24f2252f7c0mr5988998637.15.1757099731766;
        Fri, 05 Sep 2025 12:15:31 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.15.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:15:31 -0700 (PDT)
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
Subject: [PATCH v2 15/15] mm, swap: use a single page for swap table when the size fits
Date: Sat,  6 Sep 2025 03:13:57 +0800
Message-ID: <20250905191357.78298-16-ryncsn@gmail.com>
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
 mm/swapfile.c   | 50 ++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 9 deletions(-)

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
index 49f93069faef..ab6e877b0644 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -430,6 +430,38 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
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
@@ -443,7 +475,7 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 	table = (void *)rcu_dereference_protected(ci->table, true);
 	rcu_assign_pointer(ci->table, NULL);
 
-	kmem_cache_free(swap_table_cachep, table);
+	swap_table_free(table);
 }
 
 /*
@@ -467,8 +499,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	lockdep_assert_held(&ci->lock);
 	lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
 
-	table = kmem_cache_zalloc(swap_table_cachep,
-				  __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
+	table = swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
 	if (table) {
 		rcu_assign_pointer(ci->table, table);
 		return ci;
@@ -483,7 +514,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster_lock);
 	local_unlock(&percpu_swap_cluster.lock);
-	table = kmem_cache_zalloc(swap_table_cachep, __GFP_HIGH | GFP_KERNEL);
+	table = swap_table_alloc(__GFP_HIGH | GFP_KERNEL);
 
 	local_lock(&percpu_swap_cluster.lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
@@ -520,7 +551,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 
 free_table:
 	if (table)
-		kmem_cache_free(swap_table_cachep, table);
+		swap_table_free(table);
 	return ci;
 }
 
@@ -738,7 +769,7 @@ static int inc_cluster_info_page(struct swap_info_struct *si,
 
 	ci = cluster_info + idx;
 	if (!ci->table) {
-		table = kmem_cache_zalloc(swap_table_cachep, GFP_KERNEL);
+		table = swap_table_alloc(GFP_KERNEL);
 		if (!table)
 			return -ENOMEM;
 		rcu_assign_pointer(ci->table, table);
@@ -4075,9 +4106,10 @@ static int __init swapfile_init(void)
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



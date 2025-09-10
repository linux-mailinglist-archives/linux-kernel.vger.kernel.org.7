Return-Path: <linux-kernel+bounces-810636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D41CB51D27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3596A038B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DB1340DBB;
	Wed, 10 Sep 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhPYkQLv"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643973376B7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520603; cv=none; b=a5ZHWSIWpVN6+P5J4aFzEPr9TgaaEAIkJ61ZbGUA0wpdUsmtxU+xtK9LgIFpq53XZb6RX4WCCuv+X2JjWPjhyBbKQJVLtShVIKTsX/RvBzIVbDapegpt3A+43xZ79bXaNX1N9kozuOBANLFEX4ArRNTEULyuIzYDG9yfdRZbt/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520603; c=relaxed/simple;
	bh=QL36JjOd6NS2P9etFIDhKrt8BasNgA9JZNK8noTcJxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJAYZGoXdVuIesZ3Iynk5kyJt88XZ73mWhy5wcsM/aVOIMTv5Ae4h7CDLQ/BsARC6E6mKS+sKzgNS5HuQjWod+IcNQ64FEjGFsO6IyYFo/NG34nDO27dd5i3NaVM2OLLN5DW0RSVD8z2SKyGkJVf7PIqcDMTw00NKNuFm22xMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhPYkQLv; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso4496242a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520601; x=1758125401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9X8IezR3SoWMo8wYuh3xUkeHhs7bAkncRRB5ILkQmNw=;
        b=YhPYkQLv1OSmGQm0fAL3bdtLtE2aye6wSAf4fIbp3cYSF5A6Gzu+EXfj3/vMKWpkfC
         aTluOPt11XKbEtW9qGUdFZWFScjDDJpH/7ffow0M98cPf43+yl4lP9LUvI8r/68E6D31
         GN0Ix88Ti6wE9KskQt3ZLsa3LaF7NIUGdtvwhFk45jtkpnR/XbrMmYgpULAeRC3z5NG8
         DsNAKz3abXUv/DVydKUJxEzAYqO1DKZ5x183HwZMle8fEgL81c8slOFTnDqgWRjOg3wn
         g+SZfV2aftMyUVWQdHFiy+tEcNbWM5eVZdV5COVa35ZQjVDmdfu3bPj8ofkmFyhmFqkO
         xp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520601; x=1758125401;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9X8IezR3SoWMo8wYuh3xUkeHhs7bAkncRRB5ILkQmNw=;
        b=PsnKJEx2ETxEtD1u9EozNLJf9xdTvuHy15aNRYiqa3isnDUqd98ahCn2iKzeB9WEYR
         xzM1/k2bfZMEfZETelYoJaoUJRRqeQO0GfM+e4c52NORyCT062IcTK4P43XZ1B+Y5Srw
         zsanCFZNqN43MSusZCkNPxLDqAEMtsIhDTMQhKOyoAhQgDwPpAl4u+NQWwXtefLUshBJ
         sbvmLivLYKBhL0x7+/xyEvLm4UNw3pvWWMJXlEUSyBULhGdcCH05mwlDqPLHWBiRYxbU
         6V8aNYb5kww0ZN76UZVriWZCwDlYKG88PMp4QQN+B8Z3LAdjIj8QnPzKQdd+1s3m9Ce3
         PL7A==
X-Forwarded-Encrypted: i=1; AJvYcCVOpziJOjEI66TfmHfZ0Ebq28HdMVxAHQG5uhlA1IeC0CC9Y7QUsnT/pqC5kfFn4xpjf3nvaxsTlWCKspk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvwStBRpnJwlyy+J83kOZX8sTE4Bly6acNYGw0+LggXDdwMQ03
	9zJe2tOBMdK0IJ+KsZMDbTTXHjH3YOCYuS+RaSn0N7B2Iexzi7+ufzGG
X-Gm-Gg: ASbGncsibfEmwaHBmcznDzg1v6IgHS1zFlCnkrZQTTxT2e/VsiRev2IyHrlAw0xy9dC
	jYAez+TDtHNeBjFLgDMJH5mivSD3taX81KruoHtLNr7I4eV/rdOpAxP5ISDutWEtMVXHed9IzDn
	8n3z4D2e1SttjrGFUbYqdFRMA2JAGGbo4E1Y3+qyH4Ij1luAVkLuZOMiqg0398rsh/96ck1qMAH
	Txv0D1z9vc0K7CbA12OtcjKWNZ346QKmQh76X5if9j1mRc4f5evDzUG4meFINieWCoFRLEYOcDN
	I1J8N1ofGLaoK3IwaILXpJuhvMrq+KDwXblMRgPdctS1GZ0iZjyVO4ZOAXZcSMMhq+rlEC+c+mm
	VQajze2S8zr04ciAIMSTASyGPvcRu76OP4EKrUbaiT3lygObofux2eGbnbw==
X-Google-Smtp-Source: AGHT+IGH73IxV7jUuJYAM9aSrRqAGj9iR4ECuxZxMfuieRYNWITXMqhhRKZss7t1YGKHwvp/sLs/2Q==
X-Received: by 2002:a17:90b:3d4e:b0:32d:cab5:a51b with SMTP id 98e67ed59e1d1-32dcab5a716mr1672236a91.29.1757520600531;
        Wed, 10 Sep 2025 09:10:00 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:59 -0700 (PDT)
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
Subject: [PATCH v3 15/15] mm, swap: use a single page for swap table when the size fits
Date: Thu, 11 Sep 2025 00:08:33 +0800
Message-ID: <20250910160833.3464-16-ryncsn@gmail.com>
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
index faf867a6c5c1..cebf2dcfaab0 100644
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
@@ -4076,9 +4107,10 @@ static int __init swapfile_init(void)
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



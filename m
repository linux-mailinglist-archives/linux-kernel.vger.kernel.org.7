Return-Path: <linux-kernel+bounces-782621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 550FDB322C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC11CC918C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D432D1F42;
	Fri, 22 Aug 2025 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWLbgAj/"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E662D3228
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890502; cv=none; b=tgDnt2Fu9VFdLIgq9Yl324ILpcZmsnUdCz9Pm1g2dI3TB1jJQixwokuhTpKBleL//2KoR0y7YUPGdCEUJ0DQMc+vrvDGM+fTh+ZLAjW6lMpZCNM0eU8jlzFVJPh5DIJ5/yAml3Gy0azs6FezI9301XUPKZUMBy5FwxXnINxMENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890502; c=relaxed/simple;
	bh=BIAou0EJH+Cde+0lcC7baB0kaHraaOyHB1jhoaFuDZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhCBJWq+X17B9jOdJ+NgOovr3+4uAY25AOgYPBVtP2jNNWaAuLha7mKhU0t1FOrPlzbHyJaGmoXGzyeRJ6008GqBaaBW/lj+XsMBfP1sKfaZHJAifn3y0XcBB58AHf6CDkkdvKmp37evcKB7f2IEL/fXDMlDgW/STwO3QQO9BNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWLbgAj/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70d9a65c373so12705056d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890500; x=1756495300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=beM5HIc5H97tJfr+Bv+Qn5iVpdoA6CB95zAhcoVOSug=;
        b=BWLbgAj/kOQPDNNBGrDAW4YTZO9lJDIrF9mv6KsoWkcgy/2pRycC11kAFq2Aolqth3
         a8uxuh2kmM5gBKG5pGIr2ZFOA6VSXe7L8L1S39nL9feKBsFTAFK8DlYldOL9Hae09RIr
         DQck99WXkJfRVI39ubNP4/mQrjvoDUXpKMXADgjWBv3QIBeof/A9wrzDSSkycuEBaMCo
         vF+nxuSx3b4XSS2mukXqp5HQP9ud851ucJu3bhICbakDvhS4vaXDU5jcQykOurZoCqJg
         ISlF1TCeCVNprf+5BdMiFOx8zkrPMxgDV2nI4cmWH8BuSvHYn9vwHfKH8hAwDLYPwNI/
         Q7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890500; x=1756495300;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beM5HIc5H97tJfr+Bv+Qn5iVpdoA6CB95zAhcoVOSug=;
        b=THeU730gRlja/OcP5BxfgSspiObo/IjrYizhJSrCLbeqY/aE6sMjUZUAHf1iYKkmGn
         wqd5Q5uWzc/fY3Nx+jdbFdsbDiKYsrLeGGZbL8RbbbQISlTKsdItVVol06X+TrVF5DGO
         9EBu4VDGfONR5SVpOCkhrllT5thRkTUlSSZe9OHnApvAsEZkVYU89cPMW7+zCrK+a8Cm
         u2H6mwyEQFcOtAFo1QigNK2OVSKaIjJ6bRombBfgXJu/9SMJGfXxhSoFSbtlBlI9RF2V
         CHzzHovt/74/vYZ0Y1txv9L3Z8sL2rxDCu/FxFiMafb6eR72LYK89ieQkhWEmO9va7SO
         5rQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTKS83L9aXveEsU+99/NHTwBjzdGVjff8d3eYRx7ZI9ZlU1yJlw7Emg8cVKycEFBbesYkrnjq6QhUNT/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFD8MorxvrO6xJNBpmSt99aUViKAoDDCjU84+ERwhKeF8iBtF3
	WCtc+D9MSBra6J73QgTPsFrXofJ+jl/+tzdBGXSJYu6bAiVZbZXwFadeRQl9nF+ogQU=
X-Gm-Gg: ASbGncu1sQQSz70rMLqG4/qmmSj9YygieYXXPgkh7QpKhxI3TJ36MuxQpJWi7fuF7qz
	XDdtq02COi/OdfMRsAum3fQ/bITOkeWbDzm6YZr2Ik5bBPFQeYtbZcPewbSht71yPa4IK4YYmNv
	4kyabvQF3AslKw9zovL5rqvGxNEKYCgTEkiD7R5cSBWDRx+0DwiiTV0bhfvftYo9gU7CZPakWjr
	HRxLOVc8z/YqAtD1DqXEaKg2oU6qHpq0ETqR2/0EbtDjzRmG+c3QHHLM7sXU7aR7KcQAvSs7fbf
	IbXSWtMyXktBgS1XjT8Mejby6UtZTwOSOdtjre6Miu5I2bOSAnZgOUn16u9LfuN/BccTwxC5WR4
	8lsmdjaLnPg8+EJ/wkLYze9YQHPyvItuvVz3VdkW8azw=
X-Google-Smtp-Source: AGHT+IGDvVKjUk3ao3C3T4+HLvJurBFSlIikKQIK2AlVn7WhL5Fvzgj5Yph3zvj5UA7QSkPoWKGNyw==
X-Received: by 2002:ad4:4b32:0:b0:70d:a44c:786d with SMTP id 6a1803df08f44-70da44c7c63mr16656606d6.7.1755890499801;
        Fri, 22 Aug 2025 12:21:39 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm3843656d6.52.2025.08.22.12.21.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 12:21:39 -0700 (PDT)
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
Subject: [PATCH 9/9] mm, swap: use a single page for swap table when the size fits
Date: Sat, 23 Aug 2025 03:20:23 +0800
Message-ID: <20250822192023.13477-10-ryncsn@gmail.com>
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

We have a cluster size of 512 slots. Each slot consumes 8 bytes in swap
table so the swap table size of each cluster is exactly one page (4K).

If that condition is true, allocate one page direct and disable the slab
cache to reduce the memory usage of swap table and avoid fragmentation.

Co-developed-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_table.h |  2 ++
 mm/swapfile.c   | 50 ++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/mm/swap_table.h b/mm/swap_table.h
index 4e97513b11ef..984474e37dd7 100644
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
index 00651e947eb2..7539ee26d59a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -432,6 +432,38 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
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
@@ -445,7 +477,7 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 	table = (void *)rcu_dereference_protected(ci->table, true);
 	rcu_assign_pointer(ci->table, NULL);
 
-	kmem_cache_free(swap_table_cachep, table);
+	swap_table_free(table);
 }
 
 /*
@@ -469,8 +501,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	lockdep_assert_held(&ci->lock);
 	lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
 
-	table = kmem_cache_zalloc(swap_table_cachep,
-				  __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
+	table = swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
 	if (table) {
 		rcu_assign_pointer(ci->table, table);
 		return ci;
@@ -485,7 +516,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster_lock);
 	local_unlock(&percpu_swap_cluster.lock);
-	table = kmem_cache_zalloc(swap_table_cachep, __GFP_HIGH | GFP_KERNEL);
+	table = swap_table_alloc(__GFP_HIGH | GFP_KERNEL);
 
 	local_lock(&percpu_swap_cluster.lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
@@ -522,7 +553,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 
 free_table:
 	if (table)
-		kmem_cache_free(swap_table_cachep, table);
+		swap_table_free(table);
 	return ci;
 }
 
@@ -740,7 +771,7 @@ static int inc_cluster_info_page(struct swap_info_struct *si,
 
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



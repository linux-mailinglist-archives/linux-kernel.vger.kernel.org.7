Return-Path: <linux-kernel+bounces-708819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA214AED580
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 09:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C0416D8BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 07:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1074921FF55;
	Mon, 30 Jun 2025 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PYJU+RIT"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE341E8837
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268386; cv=none; b=fwz4gNUrhLjDfztNDsxHqxHrvo8aKTJEU6+7WyoaUaeh6+1odopHGpplcsQ7gVuORe20DbKjiw8ARRFkr5wdh6Gbx/8NQBWKBIbEv4cuT43dYurBdWWJtpvt8EvkKqGy4O6TXfZtFQwC+9dypuOtuYkEu069GsH3GKqM6qHYYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268386; c=relaxed/simple;
	bh=I8UxxhJLQof/tyH0p5dB+cMNEwpvSA6ZIOKFcqg3So8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS7BcE0ZutfglysCmvxzfHSN7nU2u/1g2NN2NSYI5GWJ80RBzRKzAlJoxB1BEJ4901t8eGqXHgLJTplSDe6KGGThrdBBNnjr7TCQrNgyeB26FRIzkwI4z+UyMN6FMLLAq6FrNSlFXNT7SJfVb4LyKRFerMI9ajtWEJ8iXHGCiyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PYJU+RIT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234fcadde3eso20418465ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751268384; x=1751873184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PVaNAK39uQ8LNi2b1TX8lzENExPvD+xSUsW8/NwSUM=;
        b=PYJU+RITWAUs7ZtAF/eYEpAC4io8FUSM9JmT8POa7YY/xgX4uE0wbuKtw7EGrhgrN6
         A2RHVdSlDGRQm3JsUQwxuvhx9m82ZP+Zleyl1iDcm3hdZH/Bg/0LyHJpbEjlpFijtV13
         yv0ir++rnccW5aA9SY9MqrBvtJQNSW3/3u8tDcHO9g56cV/usICWhEQkRnsb+x5fmGeI
         NfkmsaTY1A8yY1UQx4wWZdvIFFsv9xKJA7nLXdURWW0EOd4/AWVlHwD9AhB7SvEkhGTi
         r9+3sc+RHEOIATumWwPBsYrHij14fw1BQb6sO+33DB89PWwcRYkGbiLMsilL/YoqMolo
         l4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751268384; x=1751873184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PVaNAK39uQ8LNi2b1TX8lzENExPvD+xSUsW8/NwSUM=;
        b=FZ8NMnAtIs8ExoH0CJF7j3nFl9b9yQnc7Wo89Sc5x1MOYQ562Jgn8dpwMd8eOgz2T+
         s/ag2Bweb3HYAUOUk7ZqANqLLZP5g12FwVOofaB/8DCpO+pSP9q9bGFrJneUs/Y7BRix
         riS6QgiuTW14mVidH7n9HPMwI6pafMSdWLCY6/0PQx+tS2jIqxLKBCkjZMbQ0fcqHl0p
         L0+yUwZo7yI20eYlow98SVmdqPDJNoQ20dhfSLg195kKzhIcYiIOaXVuDKGaTqUuye/c
         9Ta2OG+QnPsh0LzkQnUTgwvH4c4x27YVQr73QxHeFTQeYYoHpdKe5gF5M1RTzO/MY4Nw
         c88A==
X-Forwarded-Encrypted: i=1; AJvYcCXtu/5sNKhPCyma1kI5V8QLdAyOucb9QJbs4mXSk9nAdHJJ7SjpkZaD9FLWMpIigo8jyvK/HJjeQ7ODFmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pGAqGW0dNTBHcKDEZXOPyuyQc4jnAE9gnYxl6PAfdzPkYlUe
	AgA/lf6SCCAxe19voT2EcpaGnsATSlkZ2mKZ4EUt7+JMgW7GrxAINOFOuamGDabv4dY=
X-Gm-Gg: ASbGncvch7kOPWtalePRrHStqcJuRLhYTEzPHf7SrXedYXdKPp7ove3Sp0wkyP7Au4e
	FdDqwG6K92IbDjinrJy3EsDf61UyyRi98at2A6pI+hcqO/nIx1xmM5ZD6wU3bznT9Y2fppa86x0
	eXR6Xbx2tYlVeSlBztRUIcWjwcKPqUigrBwgwgbmrmx6g6ytapMUbBcNS5mBLUYqd1mIlCSi9V3
	v56jtvWapNlJVxBa0nsjm0UDvOBmUZfmYrTPaP0ptscEqtvcAxzj9Bd5KhjkvhpytaY/O1Rx5qr
	z/kvsvDpmNxSRkohRHCK3JbZappXcHaDavVTrN32sy7rylQ7gzj6q/0k4kx4A5jD4tfh5rESsd9
	x+i8PC+YhRfgkAg==
X-Google-Smtp-Source: AGHT+IET0HnvzCWLV3S27jQoYp87eESrgMK8N5WMX/2EoH+qyQ0Aoqvn9euxjP43pOMWjkx9W6YRAA==
X-Received: by 2002:a17:903:1ad0:b0:235:f18f:2924 with SMTP id d9443c01a7336-23ac40dc567mr176220125ad.15.1751268383947;
        Mon, 30 Jun 2025 00:26:23 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f17f5sm77237555ad.62.2025.06.30.00.26.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 30 Jun 2025 00:26:23 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com,
	jgg@ziepe.ca,
	david@redhat.com,
	peterx@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lizhe.67@bytedance.com
Subject: [PATCH 1/4] vfio/type1: optimize vfio_pin_pages_remote() for large folios
Date: Mon, 30 Jun 2025 15:25:15 +0800
Message-ID: <20250630072518.31846-2-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250630072518.31846-1-lizhe.67@bytedance.com>
References: <20250630072518.31846-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

When vfio_pin_pages_remote() is called with a range of addresses that
includes large folios, the function currently performs individual
statistics counting operations for each page. This can lead to significant
performance overheads, especially when dealing with large ranges of pages.

This patch optimize this process by batching the statistics counting
operations.

The performance test results for completing the 16G VFIO IOMMU DMA mapping
are as follows.

Base(v6.16-rc4):
------- AVERAGE (MADV_HUGEPAGE) --------
VFIO MAP DMA in 0.047 s (340.2 GB/s)
------- AVERAGE (MAP_POPULATE) --------
VFIO MAP DMA in 0.280 s (57.2 GB/s)
------- AVERAGE (HUGETLBFS) --------
VFIO MAP DMA in 0.052 s (310.5 GB/s)

With this patch:
------- AVERAGE (MADV_HUGEPAGE) --------
VFIO MAP DMA in 0.027 s (596.5 GB/s)
------- AVERAGE (MAP_POPULATE) --------
VFIO MAP DMA in 0.290 s (55.2 GB/s)
------- AVERAGE (HUGETLBFS) --------
VFIO MAP DMA in 0.031 s (511.1 GB/s)

For large folio, we achieve an over 40% performance improvement.
For small folios, the performance test results indicate a
particularly minor performance drop.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 93 ++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 1136d7ac6b59..a2d7abd4f2c2 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -318,7 +318,13 @@ static void vfio_dma_bitmap_free_all(struct vfio_iommu *iommu)
 /*
  * Helper Functions for host iova-pfn list
  */
-static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
+
+/*
+ * Find the highest vfio_pfn that overlapping the range
+ * [iova_start, iova_end) in rb tree.
+ */
+static struct vfio_pfn *vfio_find_vpfn_range(struct vfio_dma *dma,
+		dma_addr_t iova_start, dma_addr_t iova_end)
 {
 	struct vfio_pfn *vpfn;
 	struct rb_node *node = dma->pfn_list.rb_node;
@@ -326,9 +332,9 @@ static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
 	while (node) {
 		vpfn = rb_entry(node, struct vfio_pfn, node);
 
-		if (iova < vpfn->iova)
+		if (iova_end <= vpfn->iova)
 			node = node->rb_left;
-		else if (iova > vpfn->iova)
+		else if (iova_start > vpfn->iova)
 			node = node->rb_right;
 		else
 			return vpfn;
@@ -336,6 +342,11 @@ static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
 	return NULL;
 }
 
+static inline struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
+{
+	return vfio_find_vpfn_range(dma, iova, iova + PAGE_SIZE);
+}
+
 static void vfio_link_pfn(struct vfio_dma *dma,
 			  struct vfio_pfn *new)
 {
@@ -614,6 +625,56 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 	return ret;
 }
 
+static long contig_pages(struct vfio_dma *dma,
+		struct vfio_batch *batch, dma_addr_t iova)
+{
+	struct page *page = batch->pages[batch->offset];
+	struct folio *folio = page_folio(page);
+	long idx = folio_page_idx(folio, page);
+	long max = min_t(long, batch->size, folio_nr_pages(folio) - idx);
+	long nr_pages;
+
+	for (nr_pages = 1; nr_pages < max; nr_pages++) {
+		if (batch->pages[batch->offset + nr_pages] !=
+				folio_page(folio, idx + nr_pages))
+			break;
+	}
+
+	return nr_pages;
+}
+
+static long vpfn_pages(struct vfio_dma *dma,
+		dma_addr_t iova_start, long nr_pages)
+{
+	dma_addr_t iova_end = iova_start + (nr_pages << PAGE_SHIFT);
+	struct vfio_pfn *top = vfio_find_vpfn_range(dma, iova_start, iova_end);
+	long ret = 1;
+	struct vfio_pfn *vpfn;
+	struct rb_node *prev;
+	struct rb_node *next;
+
+	if (likely(!top))
+		return 0;
+
+	prev = next = &top->node;
+
+	while ((prev = rb_prev(prev))) {
+		vpfn = rb_entry(prev, struct vfio_pfn, node);
+		if (vpfn->iova < iova_start)
+			break;
+		ret++;
+	}
+
+	while ((next = rb_next(next))) {
+		vpfn = rb_entry(next, struct vfio_pfn, node);
+		if (vpfn->iova >= iova_end)
+			break;
+		ret++;
+	}
+
+	return ret;
+}
+
 /*
  * Attempt to pin pages.  We really don't want to track all the pfns and
  * the iommu can only map chunks of consecutive pfns anyway, so get the
@@ -680,32 +741,40 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 		 * and rsvd here, and therefore continues to use the batch.
 		 */
 		while (true) {
+			long nr_pages, acct_pages = 0;
+
 			if (pfn != *pfn_base + pinned ||
 			    rsvd != is_invalid_reserved_pfn(pfn))
 				goto out;
 
+			nr_pages = contig_pages(dma, batch, iova);
+			if (!rsvd) {
+				acct_pages = nr_pages;
+				acct_pages -= vpfn_pages(dma, iova, nr_pages);
+			}
+
 			/*
 			 * Reserved pages aren't counted against the user,
 			 * externally pinned pages are already counted against
 			 * the user.
 			 */
-			if (!rsvd && !vfio_find_vpfn(dma, iova)) {
+			if (acct_pages) {
 				if (!dma->lock_cap &&
-				    mm->locked_vm + lock_acct + 1 > limit) {
+						mm->locked_vm + lock_acct + acct_pages > limit) {
 					pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
 						__func__, limit << PAGE_SHIFT);
 					ret = -ENOMEM;
 					goto unpin_out;
 				}
-				lock_acct++;
+				lock_acct += acct_pages;
 			}
 
-			pinned++;
-			npage--;
-			vaddr += PAGE_SIZE;
-			iova += PAGE_SIZE;
-			batch->offset++;
-			batch->size--;
+			pinned += nr_pages;
+			npage -= nr_pages;
+			vaddr += PAGE_SIZE * nr_pages;
+			iova += PAGE_SIZE * nr_pages;
+			batch->offset += nr_pages;
+			batch->size -= nr_pages;
 
 			if (!batch->size)
 				break;
-- 
2.20.1



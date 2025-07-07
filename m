Return-Path: <linux-kernel+bounces-719278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 379B7AFAC1E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 08:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791D63A56F5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 06:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC22927FD75;
	Mon,  7 Jul 2025 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UBR1UjVl"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803627A451
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871018; cv=none; b=awjvG+9DOqdcTZCqYjunqA25LmHsF5Y9vqw+o2SUGuttHY/VXyjv9bk0i/U6HJAnCSsRXn38R0DZfVeIdhiAZjroBB/SJ+uJd+qJRrfoMiq4p7vU+KZI6wVuPXcbbmUmfPHvgIFW0nNC8R2TOItF6n50wKq/GHvOVgA0oCXnH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871018; c=relaxed/simple;
	bh=fb6co8jrIb0ye1DMUwvR0cGT/E/Yrsdll1Jah3tS+yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoGBpVbc6z9uQbyEul7FzbZygKvVc1RLe013wU8TKjZ2hQh4K9wwpFlzGBMjvXjT80811wOsOTBKdrpnMn4HraF4ndusECT/Z8bH41H3GJQkvENnShr3iNXIzDr1NXejQS0SvuqKkgEQGbU+2tAKAI8dsw3kZmUFuaoVn3uOCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UBR1UjVl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23c703c471dso31210285ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jul 2025 23:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751871016; x=1752475816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8Cadi1skh4P1ApGM+PqU48O5jgE1uMvu2URGbuzsOs=;
        b=UBR1UjVluBNaTGe5tQTWF3yhhXj1kxwWFOueTxtjq5IlWPGaCB6p6FcIjAYi6bS+2L
         n8UIgzaGXxuD48j8Du69t0ZYr6U2cgdsKMPs1J3TsLi5qkFdI0A33ecuR+td0oqiSH7Y
         16DKoCjRC7k+6GwGPu5CLiwsC3J175GECCE0hYYEwzCNtAW5gCeKR3Rlc+iDKH0OMuyu
         fHDGjkutpbQnMuNAMhuNN8E4gjowc17jTAW12d5IFKELwP/jGcq1w733F86b9z6mfqiz
         PC+wt+w6ITpXBw9hktwLiM19yAF+3khA4aSmWN3RmsSK0tlnF94W2GLD6IUtawJ+EXNK
         6RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751871016; x=1752475816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8Cadi1skh4P1ApGM+PqU48O5jgE1uMvu2URGbuzsOs=;
        b=oNgaYJJEflJzPP4RCOB80K7KIeyoGh/iJGjP0UGTJbMWtCon5MiVg7wMdBH48lIo1X
         +WTkI2wTYHnjNnGImBC54gPmxfSBEiKahqdRnOzBZCgefQ5yCOWriwqZH0GRDXdl/cHs
         Yj553JgvdWpjBpo9PZc5t0/wRr2UjorXvxeH7kvRycJNWsRnlNXQf6na0Gms2L6PNwIl
         dt+XKbKs3VZE+bwNBDf2woeORygu3GxIRpAJdNs+5qvkhymoZt1KA0pjjbMmDgIEdS5+
         jzl+E8y6cjU+j2qCw9r7wiqCx05U06B63EUzcIyf0699Zx3CCN16NPpMKxNrbdxo8WlJ
         4+FA==
X-Forwarded-Encrypted: i=1; AJvYcCWd+h42EfWR5e62+6reVMiUMNFtU+I5GINbbj5toXKZOpOMAJuO2ChXQ28uXV3mcv/AWOjhdlEPIkmXoVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY8gIdTEjq+VGNlar8qUEcOvQoVUBGTqryei3D0TIs7HoemKbL
	jYAvzvwSz+YRXBkMT7ROrcbjfKpzezII1f6fHWS2kWo8v2E/FpGbyBr4Kns8szN7Yn0=
X-Gm-Gg: ASbGncuQwshUQ6eqdVqffbeTr2tUdKhrJlTGsuOrodY9VwxLf2LWb8gNk23OZ7w+tT+
	RxIftEUj0+CFEBhdX0tqKevKoEvTac9f3Y0xgN2ERJmFhlLHlgliFESvPXJCv5x0HNkslj1v/Nr
	1QEKkdkfWrSVL1sZ56gzWTIN9RUg71J8CkX/z7NhWGKc+3NryBErygfs96DjYlWwemQTXY93YF3
	Cio6boVk+w1O8SrGXKVtQvFUbsp4MHQLdjM5Tw8Nk50LSiwWv3JqAh2MyGT+Vsfw0RfNXYoBVD7
	fh3AYl8nXcQAP1EeAVRLeurkcsQMZQnkf+bdRp1urN0ubK3ebTum8eDr3YzpR9epO2/2+ITsZtY
	4d9Mtz/75B1XK
X-Google-Smtp-Source: AGHT+IFDMC5zNe5FLEop89MsvruvqnioIQVRr64gsK9+ppHn/U4Xbh1NwxhORd/zYO8Y0kwaArR9Dg==
X-Received: by 2002:a17:902:e80f:b0:236:6f43:7053 with SMTP id d9443c01a7336-23c85886bb4mr158575025ad.2.1751871015977;
        Sun, 06 Jul 2025 23:50:15 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a1aasm77377635ad.15.2025.07.06.23.50.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Jul 2025 23:50:15 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	jgg@ziepe.ca,
	peterx@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com
Subject: [PATCH v3 2/5] vfio/type1: optimize vfio_pin_pages_remote()
Date: Mon,  7 Jul 2025 14:49:47 +0800
Message-ID: <20250707064950.72048-3-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250707064950.72048-1-lizhe.67@bytedance.com>
References: <20250707064950.72048-1-lizhe.67@bytedance.com>
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
Batch processing of statistical counting operations can effectively enhance
performance.

In addition, the pages obtained through longterm GUP are neither invalid
nor reserved. Therefore, we can reduce the overhead associated with some
calls to function is_invalid_reserved_pfn().

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
VFIO MAP DMA in 0.027 s (602.1 GB/s)
------- AVERAGE (MAP_POPULATE) --------
VFIO MAP DMA in 0.257 s (62.4 GB/s)
------- AVERAGE (HUGETLBFS) --------
VFIO MAP DMA in 0.031 s (517.4 GB/s)

For large folio, we achieve an over 40% performance improvement.
For small folios, the performance test results indicate a
slight improvement.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 83 ++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 1136d7ac6b59..03fce54e1372 100644
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
@@ -614,6 +625,39 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 	return ret;
 }
 
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
@@ -680,32 +724,47 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 		 * and rsvd here, and therefore continues to use the batch.
 		 */
 		while (true) {
+			long nr_pages, acct_pages = 0;
+
 			if (pfn != *pfn_base + pinned ||
 			    rsvd != is_invalid_reserved_pfn(pfn))
 				goto out;
 
+			/*
+			 * Using GUP with the FOLL_LONGTERM in
+			 * vaddr_get_pfns() will not return invalid
+			 * or reserved pages.
+			 */
+			nr_pages = num_pages_contiguous(
+					&batch->pages[batch->offset],
+					batch->size);
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



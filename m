Return-Path: <linux-kernel+bounces-725282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F11AFFCDC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E21A5448CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D273728FFDE;
	Thu, 10 Jul 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JF0cEiYx"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9628FABA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137658; cv=none; b=I1FRZDSOFEqIGi5pq3bg1+aR3iH7dNjbkUtf6baQyfQYLzLp3Koin02twlJbidIj+9oVxO57GRCU6GDfBAllZLUMP12iiDjj7z99vsoIK2R61HVA5xi3IARE73T8no5hnmjl9RSBH6EDIX7/YCSDKJpTMGemy3XO0AoqsDY7Q5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137658; c=relaxed/simple;
	bh=bvjnKLbum3GXpvkII6kS2kG30yi+AHK7jxW0XhSUXi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVQ+LdBEg+8hEP0JKOtkHwmGPRYMB1PHHQgTZs1N8m4VdUDDQ+HKaWaWzXahtfo+zWpLm0Idi28snz4ZJ99ldFgPqxFifbmrPk6l02QrTpWR9Mwd6/5I8Fs4WNvJloJfCv9+uVHLhd4LCpqvma+BDzWLlqosAdFXs955BIBLJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JF0cEiYx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31393526d0dso641109a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752137656; x=1752742456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M40RlGNwuu5qNc+KyVxXFsF2gHBPU6g2HcwSX76Yw4=;
        b=JF0cEiYxUGsx3I/UUBPoX/xBRJ3xb9GNkQk4FqIXrvq9ksNv0Pmqfjrnhv8VMhkZNu
         W2STjcKCKN0RYvXgYK7IDZqAAt/N8rlNZGdro5eNdnYBwoaMu+VSLOkVDpY2bIZH8gf9
         eWqXAY2LW7T5HSZDCGsyn73eSgJ9ZdAhzbsYiOrsHfVzyPMxQ83AgVlJIHWzppm4DWwX
         Ib2AT8xQMVFqVrZ0PpUEds6Xr1k+GJPf28ILR1r0dZiXzpxngsBJBBpECMNE5TTnOyuM
         6HjXW/q555Gg3YFoZ8J3IQWSjx4RmVHdKbRnM13QI0rRUGR4fDWm2nstWtl2s1dBIVaP
         6R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137656; x=1752742456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M40RlGNwuu5qNc+KyVxXFsF2gHBPU6g2HcwSX76Yw4=;
        b=os0jxYzI5uEm7We51r3bnfpFTpl3+H157tSSvxQkPNHi8j7qI3AUj00R1TooOw1RDq
         B1cZguf5IvNTLbwsf9P8bXQ29pEDKYOhg/svw4tChoS69nFYXWBF159ZqQIVdbaW4vJB
         G1ZG6HQKN/I9DU9m/6JqVwBXHh0l40GEbmjx628HgvJ/pjIN/5QAqpaAspFZM+wB5xW1
         C087mrZP0CYpdaC5t8qssT46YSU0AXQgKN8fdchCZbwNwRYKt0ouQsJz6w6/YwbOqcEJ
         a1ThtWk9NzZbGBiuBxKscnC8SOB60W0dkmEcAQj1sDvk+hZBhEQyt7KfAgYTiM0MNvEe
         c/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt98GX7VRAqeS1dX8Lx8IF50FZpK8o1X3HooUIQNN4mTamWGGMakLVo9spz3aX9d95/ScpEXr2vzB68AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvi+cN6NBdw50b8n/WObkdWDLwOXNK9X0UntdRlOtHJityuJMr
	OnPg0QQzU6eVsnh/ZIt5BbAo/pLpxVdUlyhsj6k3MVO2P2eXB2pkuJm+fDR+tjvwwtQ=
X-Gm-Gg: ASbGncs99oSt3UcNLtT01l3hrI+brogrHhQrYKvTiO0LIWo0GH0ck3XppaMUT+uEv+L
	2I4lzEBmaBCqAzXp6rWes9Z8WgAYB9aMjApUCYwgqWDRgyxPX01+uzqtKltQQGTFE/KBsZUNFQD
	u3BXf3ckHqDfXxCTsgVKoB1V/cs3T+zkIGybkN6LXgXnKVkFzVlNzCO/w8jp2zVc/NxNSd8hC0M
	bUX/6IAfE5a6KtNg8gMu8OtHLm1zcv7UDJT+f20LPDW9qDR8rMeDvdE+nswihRJ3Vasfl/bjxhY
	eqSnxyyGhVFaqwQldjsis2ZGMEewI0xZ3SWfBDhKeKz5JTHPypqxmkXSXocZ5X2bMTp57R8IWIv
	BMizt1YBjlsAI/A==
X-Google-Smtp-Source: AGHT+IGdJiBeouQW4gmVvNkRjswMRfLMAfXS8gTDRoMqK+yKXRLmxVryApvFY7wzc49IWY06qUyFWQ==
X-Received: by 2002:a17:90b:28c8:b0:312:e49b:c972 with SMTP id 98e67ed59e1d1-31c3c2a215cmr5805568a91.15.1752137655717;
        Thu, 10 Jul 2025 01:54:15 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e975d41sm1650228a91.13.2025.07.10.01.54.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Jul 2025 01:54:15 -0700 (PDT)
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
Subject: [PATCH v4 2/5] vfio/type1: optimize vfio_pin_pages_remote()
Date: Thu, 10 Jul 2025 16:53:52 +0800
Message-ID: <20250710085355.54208-3-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710085355.54208-1-lizhe.67@bytedance.com>
References: <20250710085355.54208-1-lizhe.67@bytedance.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 83 ++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 1136d7ac6b59..6909275e46c2 100644
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
+				     mm->locked_vm + lock_acct + acct_pages > limit) {
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



Return-Path: <linux-kernel+bounces-656799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCBCABEAF2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 06:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928573B26A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 04:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DEF22DA0E;
	Wed, 21 May 2025 04:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R/dbI5pt"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F34430
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747801531; cv=none; b=VMshzhRLbmABEq//oxfb3dgjIUYr+XH74VyD35ac9AfoJsATO8VAVXpo3jm5TC/L5y0968QwhP83gy3bqJpNYz5PqEQGvVx5j9/jpRsMQoTzDYDfjqzjBjHwejQPltoXNixzIUybVQIebG4ASchyhvkg0rV1X9oBlQ3MMbN10xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747801531; c=relaxed/simple;
	bh=hp2vDBcdaEDXuAq1yTvXyqCsHoGPRwY8JFqBf4PFWdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDeCMkwfhL40aaRA8QQ3ruQue7Nhq6PAy57H3pGx9sRR1nsVJ47XQVR0fTi3B45VDhnh80OLsCSlCQU4fSTACiMW5OJ3yvmkHwueORfY4rwgjHLdr6qhBbGe8ObvbXXLKD+DVLn1tQQt4pp7Ebm1AQ93uCGg35HxRaOxweIgylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R/dbI5pt; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af51596da56so4789511a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 21:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747801529; x=1748406329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vABuEA7BM6EMbnMrczmzBFOnp0rzRj5DlxMMU8V7wNI=;
        b=R/dbI5ptQABREzohwY8p0+wmSf6Lmv0yV5Jeu8duohK/LvRRLx4ca0OQQFzX8Vo2dl
         ho1jXkr/NooRh7URM9ZltBDbLoefR0Qbija1zVAvZMTKJQaZ0NLP1Bo0vG9b44FwZBSf
         tUQ4DAdPRv7tqPjs+IBVpvNtYdzNufI3srfeBqET4FWCU2KLTmF7nqVnpDn2GxMSAJ8H
         KdnplGuzDkdsLUvFPJUppAY9Qq5iB6CJMzZM1PO6j8P8A2Nmh02Cy2TW0nTTFuSnVJuU
         WIG0hi/MSZgk9PCIvRl/cBAFAiBBECzZpS5sAp/1qmsMISv20z1utndvTT0XLFxfqeNT
         rSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747801529; x=1748406329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vABuEA7BM6EMbnMrczmzBFOnp0rzRj5DlxMMU8V7wNI=;
        b=A3Y6Uc/teRw7dadf/7gwSZaplZ4TG3vvQHtg/CF0ithX/iLvVbQM4rCpEJNgpBUkLC
         suoy/q0VFZXdsLhD50jOQmowdlKE9aBuIO6lMO6apuickhZOIr3DhfMzHGyKpMlwxPgo
         YLM1/6COi315wzbKlOhIMg0PG4mzTlJzDdZ23tjkYn3e5EJAfFicd4jfzSAB3ncvii9Y
         5IFaY3cxvmOU14R1gJ95toFaga1nhEKeWC7C2uOOdKFT0tkvO5G0272nvc89QNw18n0X
         1wYD4kXZQ3P2bLTCIumZureO+Sgpfj88OkTfDuGY5W5eOH3eikVB/QNOI5dkUdfCsDzZ
         0v7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWII5Y61uzAa7ZPZR2jpnekUoW4JkUHfM99+50KlzS03CTRA7VrGqhSrg5ECuPUFaOtQSNkR515FXz+9q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJK0de53xPtCQj3fS4ZUIByw8tHbrY8SUNfpQF0+p1DS4gjo68
	8bfztVtNSJDS5giXzU7am2/66phB31euViIwNwTtphoMvTjrZidIjqZttGoQWh7SICA=
X-Gm-Gg: ASbGncsIUvtzTgAYbw9tfAnzs5iBU5x7awGlM5e2/Djtqskmv37yD3DUTD+RHUnLyGD
	M5QQ00fT3CuUZ/n5QDkV9cmk0GIY0B7WWlG1xPswa+U1pKW9EzhKu6Z075kj4bvtN6xFwf/ZZdj
	j8C3JFsV4JmoMsZlmYplMxmKiykOBw1gtMmTDZWtdGuYnMQvQ4I5p0bzF4MGBgV9lo8icca8jbN
	GTomk+VmoLT+o2MxqYAaHv6UrBoUf9aYGyR4F/qwwMmFVcWxE2WM7VpbAs7ymvizVCwITndLGGW
	lwEQKeDcvauW7CA0wqmbwovGFotWEvghgDeHtrIxM0lpyLIVu+pfDe6wAQkdv4UAkD4GXjHtvTd
	Gf7s=
X-Google-Smtp-Source: AGHT+IH6e825nz8KuFGrSjI7GGy7EEog0pBWTY3SAZNW0fc9er2plgBrRRvK0cQUDyD6Q6X6OaSByA==
X-Received: by 2002:a17:903:25c7:b0:231:e331:b7ca with SMTP id d9443c01a7336-231e331bc48mr157460425ad.3.1747801528777;
        Tue, 20 May 2025 21:25:28 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231e26d83c6sm80880005ad.47.2025.05.20.21.25.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 May 2025 21:25:28 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com
Cc: david@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	peterx@redhat.com,
	lizhe.67@bytedance.com
Subject: [PATCH v4] vfio/type1: optimize vfio_pin_pages_remote() for large folios
Date: Wed, 21 May 2025 12:25:07 +0800
Message-ID: <20250521042507.77205-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
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

The performance test results for completing the 8G VFIO IOMMU DMA mapping,
obtained through trace-cmd, are as follows. In this case, the 8G virtual
address space has been mapped to physical memory using hugetlbfs with
pagesize=2M.

Before this patch:
funcgraph_entry:      # 33813.703 us |  vfio_pin_map_dma();

After this patch:
funcgraph_entry:      # 16071.378 us |  vfio_pin_map_dma();

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
Changelogs:

v3->v4:
- Use min_t() to obtain the step size, rather than min().
- Fix some issues in commit message and title.

v2->v3:
- Code simplification.
- Fix some issues in comments.

v1->v2:
- Fix some issues in comments and formatting.
- Consolidate vfio_find_vpfn_range() and vfio_find_vpfn().
- Move the processing logic for hugetlbfs folio into the while(true) loop
  and use a variable with a default value of 1 to indicate the number of
  consecutive pages.

v3 patch: https://lore.kernel.org/all/20250520070020.6181-1-lizhe.67@bytedance.com/
v2 patch: https://lore.kernel.org/all/20250519070419.25827-1-lizhe.67@bytedance.com/
v1 patch: https://lore.kernel.org/all/20250513035730.96387-1-lizhe.67@bytedance.com/

 drivers/vfio/vfio_iommu_type1.c | 48 +++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0ac56072af9f..bd46ed9361fe 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -319,15 +319,22 @@ static void vfio_dma_bitmap_free_all(struct vfio_iommu *iommu)
 /*
  * Helper Functions for host iova-pfn list
  */
-static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
+
+/*
+ * Find the first vfio_pfn that overlapping the range
+ * [iova, iova + PAGE_SIZE * npage) in rb tree.
+ */
+static struct vfio_pfn *vfio_find_vpfn_range(struct vfio_dma *dma,
+		dma_addr_t iova, unsigned long npage)
 {
 	struct vfio_pfn *vpfn;
 	struct rb_node *node = dma->pfn_list.rb_node;
+	dma_addr_t end_iova = iova + PAGE_SIZE * npage;
 
 	while (node) {
 		vpfn = rb_entry(node, struct vfio_pfn, node);
 
-		if (iova < vpfn->iova)
+		if (end_iova <= vpfn->iova)
 			node = node->rb_left;
 		else if (iova > vpfn->iova)
 			node = node->rb_right;
@@ -337,6 +344,11 @@ static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
 	return NULL;
 }
 
+static inline struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
+{
+	return vfio_find_vpfn_range(dma, iova, 1);
+}
+
 static void vfio_link_pfn(struct vfio_dma *dma,
 			  struct vfio_pfn *new)
 {
@@ -681,32 +693,46 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 		 * and rsvd here, and therefore continues to use the batch.
 		 */
 		while (true) {
+			struct folio *folio = page_folio(batch->pages[batch->offset]);
+			long nr_pages;
+
 			if (pfn != *pfn_base + pinned ||
 			    rsvd != is_invalid_reserved_pfn(pfn))
 				goto out;
 
+			/*
+			 * Note: The current nr_pages does not achieve the optimal
+			 * performance in scenarios where folio_nr_pages() exceeds
+			 * batch->capacity. It is anticipated that future enhancements
+			 * will address this limitation.
+			 */
+			nr_pages = min_t(long, batch->size, folio_nr_pages(folio) -
+						folio_page_idx(folio, batch->pages[batch->offset]));
+			if (nr_pages > 1 && vfio_find_vpfn_range(dma, iova, nr_pages))
+				nr_pages = 1;
+
 			/*
 			 * Reserved pages aren't counted against the user,
 			 * externally pinned pages are already counted against
 			 * the user.
 			 */
-			if (!rsvd && !vfio_find_vpfn(dma, iova)) {
+			if (!rsvd && (nr_pages > 1 || !vfio_find_vpfn(dma, iova))) {
 				if (!dma->lock_cap &&
-				    mm->locked_vm + lock_acct + 1 > limit) {
+				    mm->locked_vm + lock_acct + nr_pages > limit) {
 					pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
 						__func__, limit << PAGE_SHIFT);
 					ret = -ENOMEM;
 					goto unpin_out;
 				}
-				lock_acct++;
+				lock_acct += nr_pages;
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



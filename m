Return-Path: <linux-kernel+bounces-743538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F0AB0FFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB4B1CC45D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1096D20966B;
	Thu, 24 Jul 2025 05:23:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5151F5858
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334600; cv=none; b=b5Ulp36mTI1dfxUdgeR7PTwjm4jtdCasoxyAwmtVfD1VfkASuCVCFpJvrFzLTL+M6AJD+9+jeFqMP9B2y0ztAGwtQjsGRZ7hEZf3uCZrwG2usEBV/yYAN+5ybuPl0n+dwdMXJ9PWRQTGwWv5uKvQ3nlRSJG3s+nbYJK1VdxJT6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334600; c=relaxed/simple;
	bh=2+mp5bwXBA8QFK86urm4iyXpcpmBsszoaOcFKK7qRn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s99ux6nvZtIQ47Ym0ySwmHxOw5dk6RQ/zoyQfHZLZQg95LXhk034kRqiM9v2xSUL/4kpRYlnkOn+/3OjW+Q0FfitxvODJgVuF+QltY1YeHDm3VVSZdmrlKGEi6YFPx0JvIIjex8Fmf0WszwcZBvle9J+7d4X+1ojRLE+sUi8+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91A411A32;
	Wed, 23 Jul 2025 22:23:12 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3969C3F66E;
	Wed, 23 Jul 2025 22:23:14 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	baohua@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v4 2/3] khugepaged: Optimize __collapse_huge_page_copy_succeeded() by PTE batching
Date: Thu, 24 Jul 2025 10:53:00 +0530
Message-Id: <20250724052301.23844-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250724052301.23844-1-dev.jain@arm.com>
References: <20250724052301.23844-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use PTE batching to batch process PTEs mapping the same large folio. An
improvement is expected due to batching refcount-mapcount manipulation on
the folios, and for arm64 which supports contig mappings, the number of
TLB flushes is also reduced.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a55fb1dcd224..f23e943506bc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -700,12 +700,15 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 						spinlock_t *ptl,
 						struct list_head *compound_pagelist)
 {
+	unsigned long end = address + HPAGE_PMD_SIZE;
 	struct folio *src, *tmp;
-	pte_t *_pte;
 	pte_t pteval;
+	pte_t *_pte;
+	unsigned int nr_ptes;
 
-	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
-	     _pte++, address += PAGE_SIZE) {
+	for (_pte = pte; _pte < pte + HPAGE_PMD_NR; _pte += nr_ptes,
+	     address += nr_ptes * PAGE_SIZE) {
+		nr_ptes = 1;
 		pteval = ptep_get(_pte);
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
 			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
@@ -722,18 +725,26 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 			struct page *src_page = pte_page(pteval);
 
 			src = page_folio(src_page);
-			if (!folio_test_large(src))
+
+			if (folio_test_large(src)) {
+				unsigned int max_nr_ptes = (end - address) >> PAGE_SHIFT;
+
+				nr_ptes = folio_pte_batch(src, _pte, pteval, max_nr_ptes);
+			} else {
 				release_pte_folio(src);
+			}
+
 			/*
 			 * ptl mostly unnecessary, but preempt has to
 			 * be disabled to update the per-cpu stats
 			 * inside folio_remove_rmap_pte().
 			 */
 			spin_lock(ptl);
-			ptep_clear(vma->vm_mm, address, _pte);
-			folio_remove_rmap_pte(src, src_page, vma);
+			clear_ptes(vma->vm_mm, address, _pte, nr_ptes);
+			folio_remove_rmap_ptes(src, src_page, nr_ptes, vma);
 			spin_unlock(ptl);
-			free_folio_and_swap_cache(src);
+			free_swap_cache(src);
+			folio_put_refs(src, nr_ptes);
 		}
 	}
 
-- 
2.30.2



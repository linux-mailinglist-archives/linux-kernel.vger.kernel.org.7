Return-Path: <linux-kernel+bounces-741096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD72FB0E006
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8167A563B10
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653128A1EA;
	Tue, 22 Jul 2025 15:06:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7FA1E8320
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196787; cv=none; b=Jg5bws1Z34KN37Pv3xTuYPz/H+Chbg11msuHaRUgfGqIa1YVUEF0tC01rgfQwlUptCO72F+qMehkdrjGjPbnCBVOIrCY4g21TBRJwTsm1wz9Fg5hw39gEExYMlqVj7iPdbP7vdjCDxP85AhZE7Vu/gFzjCzDvazAf1V3uB3xaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196787; c=relaxed/simple;
	bh=t9/tPmYresC045E3z38JghIzYZjCr3lnQYnP61HpYWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTupzy2j/Nc7MQRcIYP1vn9vW1822qTJuo3eL47WS/eWOvIgGs/Fv6fPMpcYIfABTD3acVpRya2d5IDOy5BWRrrvItzb1+6NIm8E9KnwcDHJIX8ufAB7y7u2ePtkc2Ab7ZH9j/bkrQJNtvDhTqhi/SS6N/fYOsWDm/hkgYZdxWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73E59152B;
	Tue, 22 Jul 2025 08:06:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.163.92.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EFB1F3F6A8;
	Tue, 22 Jul 2025 08:06:20 -0700 (PDT)
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
Subject: [PATCH v3 2/3] khugepaged: Optimize __collapse_huge_page_copy_succeeded() by PTE batching
Date: Tue, 22 Jul 2025 20:35:58 +0530
Message-Id: <20250722150559.96465-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250722150559.96465-1-dev.jain@arm.com>
References: <20250722150559.96465-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use PTE batching to optimize __collapse_huge_page_copy_succeeded().

On arm64, suppose khugepaged is scanning a pte-mapped 2MB THP for collapse.
Then, calling ptep_clear() for every pte will cause a TLB flush for every
contpte block. Instead, clear_ptes() does a contpte_try_unfold_partial()
which will flush the TLB only for the (if any) starting and ending contpte
block, if they partially overlap with the range khugepaged is looking at.

For all arches, there should be a benefit due to batching atomic operations
on mapcounts due to folio_remove_rmap_ptes() and saving some calls.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a55fb1dcd224..63517ef7eafb 100644
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
+	int nr_ptes;
 
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
+				int max_nr_ptes = (end - address) >> PAGE_SHIFT;
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



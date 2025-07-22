Return-Path: <linux-kernel+bounces-741098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E3EB0E007
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1070F56483B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7B92EBDE6;
	Tue, 22 Jul 2025 15:06:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21A28CF47
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196791; cv=none; b=kJPzQglWKT4xHFj1yy4GhH2ohzhUnu/5NaaXP0q8Ib22HNNSBHAvrsli8CEtXx1m9HNFdslW/fIeuR45wrj912QQEpAfslMHGIMVEJAN8LnJ2isxJM9JaYMGXIYhXqrilcivnEK+9AF6MeSaln54uKaneHVWiBbS6sg+FozQlcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196791; c=relaxed/simple;
	bh=DDdUn0036EOEcs0aETvQn2pUt2pDL5Df0uvPUlfO6tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GId0lg2KelQVDSUeQBa5TQjRyEP9fhMqdsErv2GofuquDCOkePTzAcn5lbvMJMLJuimAqnIr+4bo3hBvcozez7PfPUfGTGdWcLX0PrSvbmw/SlxhmAWupDWAyK8qcj9fYFbThMNGx6q+Bt7+pROdYENUCMlSVwHv10lVBzaHMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14530152B;
	Tue, 22 Jul 2025 08:06:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.163.92.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFC053F6A8;
	Tue, 22 Jul 2025 08:06:25 -0700 (PDT)
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
Subject: [PATCH v3 3/3] khugepaged: Optimize collapse_pte_mapped_thp() by PTE batching
Date: Tue, 22 Jul 2025 20:35:59 +0530
Message-Id: <20250722150559.96465-4-dev.jain@arm.com>
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

Use PTE batching to optimize collapse_pte_mapped_thp().

On arm64, suppose khugepaged is scanning a pte-mapped 2MB THP for collapse.
Then, calling ptep_clear() for every pte will cause a TLB flush for every
contpte block. Instead, clear_ptes() does a contpte_try_unfold_partial()
which will flush the TLB only for the (if any) starting and ending contpte
block, if they partially overlap with the range khugepaged is looking at.

For all arches, there should be a benefit due to batching atomic operations
on mapcounts due to folio_remove_rmap_ptes() and saving some calls.

Note that we do not need to make a change to the check
"if (folio_page(folio, i) != page)"; if i'th page of the folio is equal
to the first page of our batch, then i + 1, .... i + nr_batch_ptes - 1
pages of the folio will be equal to the corresponding pages of our
batch mapping consecutive pages.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 63517ef7eafb..1ff0c7dd2be4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1503,15 +1503,16 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			    bool install_pmd)
 {
+	int nr_mapped_ptes = 0, nr_batch_ptes, result = SCAN_FAIL;
 	struct mmu_notifier_range range;
 	bool notified = false;
 	unsigned long haddr = addr & HPAGE_PMD_MASK;
+	unsigned long end = haddr + HPAGE_PMD_SIZE;
 	struct vm_area_struct *vma = vma_lookup(mm, haddr);
 	struct folio *folio;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd, pgt_pmd;
 	spinlock_t *pml = NULL, *ptl;
-	int nr_ptes = 0, result = SCAN_FAIL;
 	int i;
 
 	mmap_assert_locked(mm);
@@ -1625,11 +1626,15 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto abort;
 
 	/* step 2: clear page table and adjust rmap */
-	for (i = 0, addr = haddr, pte = start_pte;
-	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
+	for (i = 0, addr = haddr, pte = start_pte; i < HPAGE_PMD_NR;
+	     i += nr_batch_ptes, addr += nr_batch_ptes * PAGE_SIZE,
+	     pte += nr_batch_ptes) {
+		int max_nr_batch_ptes = (end - addr) >> PAGE_SHIFT;
 		struct page *page;
 		pte_t ptent = ptep_get(pte);
 
+		nr_batch_ptes = 1;
+
 		if (pte_none(ptent))
 			continue;
 		/*
@@ -1643,26 +1648,29 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			goto abort;
 		}
 		page = vm_normal_page(vma, addr, ptent);
+
 		if (folio_page(folio, i) != page)
 			goto abort;
 
+		nr_batch_ptes = folio_pte_batch(folio, pte, ptent, max_nr_batch_ptes);
+
 		/*
 		 * Must clear entry, or a racing truncate may re-remove it.
 		 * TLB flush can be left until pmdp_collapse_flush() does it.
 		 * PTE dirty? Shmem page is already dirty; file is read-only.
 		 */
-		ptep_clear(mm, addr, pte);
-		folio_remove_rmap_pte(folio, page, vma);
-		nr_ptes++;
+		clear_ptes(mm, addr, pte, nr_batch_ptes);
+		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
+		nr_mapped_ptes += nr_batch_ptes;
 	}
 
 	if (!pml)
 		spin_unlock(ptl);
 
 	/* step 3: set proper refcount and mm_counters. */
-	if (nr_ptes) {
-		folio_ref_sub(folio, nr_ptes);
-		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
+	if (nr_mapped_ptes) {
+		folio_ref_sub(folio, nr_mapped_ptes);
+		add_mm_counter(mm, mm_counter_file(folio), -nr_mapped_ptes);
 	}
 
 	/* step 4: remove empty page table */
@@ -1695,10 +1703,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			: SCAN_SUCCEED;
 	goto drop_folio;
 abort:
-	if (nr_ptes) {
+	if (nr_mapped_ptes) {
 		flush_tlb_mm(mm);
-		folio_ref_sub(folio, nr_ptes);
-		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
+		folio_ref_sub(folio, nr_mapped_ptes);
+		add_mm_counter(mm, mm_counter_file(folio), -nr_mapped_ptes);
 	}
 unlock:
 	if (start_pte)
-- 
2.30.2



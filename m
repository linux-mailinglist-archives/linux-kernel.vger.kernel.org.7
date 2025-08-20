Return-Path: <linux-kernel+bounces-777267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B21B2D795
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5D65A0525
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D52DCF51;
	Wed, 20 Aug 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CMoGiUu6"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707C2D979E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680866; cv=none; b=oIPUNpu53ca6fM22eY0eeTT8YqpDBvxehgGZBmy+9/oc6SVUlkJQsydbH8ILhHDs2vVBDO5V9FXYK0SulGfDwYJDRNp/z0DPBW4G6UUFXP8cr6Ixpb3NF99GII5BvYUbyikJVvuLsIQnW+mxPbNfzgiFK+Cs3clKgRTkxAIJycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680866; c=relaxed/simple;
	bh=6x5ijexvDuF+H/p4E44IabCbASCkw+qyUIigZZiJT8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUXshsHY74R/XeLqspy2OViYhT+AdC6Jx0g/7yr3Y7nsJFjxEURt9FBfb7GfMznKvMkkZnI4RWyGFs1RLCF4YM6sgVUrX0XorX+olVnHqdcG2ldw5dS7k+tY0ksrxQXbGuYN4rE//zvjShzWb2AraBmpnTvyiKogxExTmLyvZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CMoGiUu6; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680860; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=d861k2/gR3LU0SyA7Qgfbs2BiibixgL7AImClvK96mk=;
	b=CMoGiUu6LJJOISzSs6PfHe3l/yYY0cjVCfqRT0J53oQibjYB3138hJcl5N6S6zDc45vhH8P4+0rvMx2WM4toCUCouXzMtKsBEy4x2RQvnIQ4YIRLal+bdP70R2ivUM1GYm8fMpUmY0UhTN0FbDyugFF15+ZbWWnskqbkukbPZl8=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBY55V_1755680857 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:38 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/11] mm: khugepaged: add shmem/file mTHP collapse support
Date: Wed, 20 Aug 2025 17:07:15 +0800
Message-ID: <a05642935d6e38963d8d71de1570d9ffbfa96ab6.1755677674.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
References: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Khugepaged already supports the anonymous mTHP collapse. Similarly, let
khugepaged also support the shmem/file mTHP collapse. The strategy for
shmem/file mTHP collapse follows the anonymous mTHP collapse, which is,
quoting from Nico:

"while scanning PMD ranges for potential collapse candidates, keep
track of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER PTEs.

After the scan is complete, we will perform binary recursion on the bitmap
to determine which mTHP size would be most efficient to collapse to. The
'max_ptes_none' will be scaled by the attempted collapse order to determine
how full a THP must be to be eligible.
"

Moreover, to facilitate the scanning of shmem/file folios, extend the
'cc->mthp_bitmap_temp' bitmap to record whether each index within the
PMD range corresponds to a present page, and then this temp bitmap is used
to determine whether each chunk should be marked as present for mTHP
collapse.

Currently, the collapse_pte_mapped_thp() does not build the mapping for mTHP.
Cause we still expect to establish the mTHP mapping via refault under the
control of fault_around. So collapse_pte_mapped_thp() remains responsible
only for building the mapping for PMD-sized THP, which is reasonable and
makes life easier.

Note that we do not need to remove pte page tables for shmem/file mTHP
collapse.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 133 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 107 insertions(+), 26 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 195c26699118..53ca7bb72fbc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -113,7 +113,7 @@ struct collapse_control {
 	 * 1bit = order KHUGEPAGED_MIN_MTHP_ORDER mTHP
 	 */
 	DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
-	DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
+	DECLARE_BITMAP(mthp_bitmap_temp, HPAGE_PMD_NR);
 	struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
 };
 
@@ -147,6 +147,10 @@ static struct khugepaged_scan khugepaged_scan = {
 	.mm_head = LIST_HEAD_INIT(khugepaged_scan.mm_head),
 };
 
+static int collapse_file(struct mm_struct *mm, unsigned long addr,
+			struct file *file, pgoff_t start,
+			struct collapse_control *cc, int order);
+
 #ifdef CONFIG_SYSFS
 static ssize_t scan_sleep_millisecs_show(struct kobject *kobj,
 					 struct kobj_attribute *attr,
@@ -1366,7 +1370,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 
 /* Recursive function to consume the bitmap */
 static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
-			int referenced, int unmapped, struct collapse_control *cc,
+			struct file *file, int referenced, int unmapped,
+			pgoff_t start, struct collapse_control *cc,
 			bool *mmap_locked, unsigned long enabled_orders)
 {
 	u8 order, next_order;
@@ -1401,10 +1406,14 @@ static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
 
 		/* Check if the region is "almost full" based on the threshold */
 		if (bits_set > threshold_bits || is_pmd_only
-			|| test_bit(order, &huge_anon_orders_always)) {
-			ret = collapse_huge_page(mm, address, referenced, unmapped,
-						 cc, mmap_locked, order,
-						 offset * KHUGEPAGED_MIN_MTHP_NR);
+			|| (!file && test_bit(order, &huge_anon_orders_always))) {
+			if (file)
+				ret = collapse_file(mm, address, file,
+						start + offset * KHUGEPAGED_MIN_MTHP_NR, cc, order);
+			else
+				ret = collapse_huge_page(mm, address, referenced, unmapped,
+						cc, mmap_locked, order,
+						offset * KHUGEPAGED_MIN_MTHP_NR);
 
 			/*
 			 * Analyze failure reason to determine next action:
@@ -1418,6 +1427,7 @@ static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
 				collapsed += (1 << order);
 			case SCAN_PAGE_RO:
 			case SCAN_PTE_MAPPED_HUGEPAGE:
+			case SCAN_PAGE_COMPOUND:
 				continue;
 			/* Cases were lower orders might still succeed */
 			case SCAN_LACK_REFERENCED_PAGE:
@@ -1481,7 +1491,7 @@ static int collapse_scan_pmd(struct mm_struct *mm,
 		goto out;
 
 	bitmap_zero(cc->mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
-	bitmap_zero(cc->mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
+	bitmap_zero(cc->mthp_bitmap_temp, HPAGE_PMD_NR);
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
 
@@ -1649,8 +1659,8 @@ static int collapse_scan_pmd(struct mm_struct *mm,
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
 	if (result == SCAN_SUCCEED) {
-		result = collapse_scan_bitmap(mm, address, referenced, unmapped, cc,
-					      mmap_locked, enabled_orders);
+		result = collapse_scan_bitmap(mm, address, NULL, referenced, unmapped,
+					      0, cc, mmap_locked, enabled_orders);
 		if (result > 0)
 			result = SCAN_SUCCEED;
 		else
@@ -2067,6 +2077,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			 struct collapse_control *cc,
 			 int order)
 {
+	int max_scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
 	struct address_space *mapping = file->f_mapping;
 	struct page *dst;
 	struct folio *folio, *tmp, *new_folio;
@@ -2128,9 +2139,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 				}
 				nr_none++;
 
-				if (cc->is_khugepaged && nr_none > khugepaged_max_ptes_none) {
+				if (cc->is_khugepaged && nr_none > max_scaled_none) {
 					result = SCAN_EXCEED_NONE_PTE;
 					count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+					count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);
 					goto xa_locked;
 				}
 
@@ -2223,6 +2235,18 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			goto out_unlock;
 		}
 
+		/*
+		 * If the folio order is greater than the collapse order, there is
+		 * no need to continue attempting to collapse.
+		 * And should return SCAN_PAGE_COMPOUND instead of SCAN_PTE_MAPPED_HUGEPAGE,
+		 * then we can build the mapping under the control of fault_around
+		 * when refaulting.
+		 */
+		if (folio_order(folio) >= order) {
+			result = SCAN_PAGE_COMPOUND;
+			goto out_unlock;
+		}
+
 		if (folio_mapping(folio) != mapping) {
 			result = SCAN_TRUNCATED;
 			goto out_unlock;
@@ -2443,12 +2467,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	xas_unlock_irq(&xas);
 
 	/*
-	 * Remove pte page tables, so we can re-fault the page as huge.
+	 * Remove pte page tables for PMD-sized THP collapse, so we can re-fault
+	 * the page as huge.
 	 * If MADV_COLLAPSE, adjust result to call collapse_pte_mapped_thp().
 	 */
-	retract_page_tables(mapping, start);
-	if (cc && !cc->is_khugepaged)
-		result = SCAN_PTE_MAPPED_HUGEPAGE;
+	if (order == HPAGE_PMD_ORDER)
+		retract_page_tables(mapping, start);
 	folio_unlock(new_folio);
 
 	/*
@@ -2504,21 +2528,35 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 
-static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
-			      struct file *file, pgoff_t start,
+static int collapse_scan_file(struct mm_struct *mm, struct vm_area_struct *vma,
+			      unsigned long addr, struct file *file, pgoff_t start,
 			      struct collapse_control *cc)
 {
+	int max_scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER);
+	enum tva_type type = cc->is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
 	struct folio *folio = NULL;
 	struct address_space *mapping = file->f_mapping;
 	XA_STATE(xas, &mapping->i_pages, start);
-	int present, swap;
+	int present, swap, nr_pages;
+	unsigned long enabled_orders;
 	int node = NUMA_NO_NODE;
 	int result = SCAN_SUCCEED;
+	bool is_pmd_only;
 
 	present = 0;
 	swap = 0;
+	bitmap_zero(cc->mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
+	bitmap_zero(cc->mthp_bitmap_temp, HPAGE_PMD_NR);
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
+
+	if (cc->is_khugepaged)
+		enabled_orders = thp_vma_allowable_orders(vma, vma->vm_flags,
+				type, THP_ORDERS_ALL_FILE_DEFAULT);
+	else
+		enabled_orders = BIT(HPAGE_PMD_ORDER);
+	is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
+
 	rcu_read_lock();
 	xas_for_each(&xas, folio, start + HPAGE_PMD_NR - 1) {
 		if (xas_retry(&xas, folio))
@@ -2587,7 +2625,20 @@ static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		 * is just too costly...
 		 */
 
-		present += folio_nr_pages(folio);
+		nr_pages = folio_nr_pages(folio);
+		present += nr_pages;
+
+		/*
+		 * If there are folios present, keep track of it in the bitmap
+		 * for file/shmem mTHP collapse.
+		 */
+		if (!is_pmd_only) {
+			pgoff_t pgoff = max_t(pgoff_t, start, folio->index) - start;
+
+			nr_pages = min_t(int, HPAGE_PMD_NR - pgoff, nr_pages);
+			bitmap_set(cc->mthp_bitmap_temp, pgoff, nr_pages);
+		}
+
 		folio_put(folio);
 
 		if (need_resched()) {
@@ -2597,16 +2648,46 @@ static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	}
 	rcu_read_unlock();
 
-	if (result == SCAN_SUCCEED) {
-		if (cc->is_khugepaged &&
-		    present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
-			result = SCAN_EXCEED_NONE_PTE;
-			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-		} else {
-			result = collapse_file(mm, addr, file, start, cc, HPAGE_PMD_ORDER);
+	if (result != SCAN_SUCCEED)
+		goto out;
+
+	if (cc->is_khugepaged && is_pmd_only &&
+	    present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
+		result = SCAN_EXCEED_NONE_PTE;
+		count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+		goto out;
+	}
+
+	/*
+	 * Check each KHUGEPAGED_MIN_MTHP_NR page chunks, and keep track of it
+	 * in the bitmap if this chunk has enough present folios.
+	 */
+	if (!is_pmd_only) {
+		int i;
+
+		for (i = 0; i < HPAGE_PMD_NR; i += KHUGEPAGED_MIN_MTHP_NR) {
+			if (bitmap_weight(cc->mthp_bitmap_temp, KHUGEPAGED_MIN_MTHP_NR) >
+					  KHUGEPAGED_MIN_MTHP_NR - max_scaled_none)
+				bitmap_set(cc->mthp_bitmap, i / KHUGEPAGED_MIN_MTHP_NR, 1);
+
+			bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitmap_temp,
+					   KHUGEPAGED_MIN_MTHP_NR, HPAGE_PMD_NR);
 		}
+
+		bitmap_zero(cc->mthp_bitmap_temp, HPAGE_PMD_NR);
+	}
+	result = collapse_scan_bitmap(mm, addr, file, 0, 0, start,
+				      cc, NULL, enabled_orders);
+	if (result > 0) {
+		if (cc && !cc->is_khugepaged)
+			result = SCAN_PTE_MAPPED_HUGEPAGE;
+		else
+			result = SCAN_SUCCEED;
+	} else {
+		result = SCAN_FAIL;
 	}
 
+out:
 	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
 	return result;
 }
@@ -2628,7 +2709,7 @@ static int collapse_single_pmd(unsigned long addr,
 
 		mmap_read_unlock(mm);
 		*mmap_locked = false;
-		result = collapse_scan_file(mm, addr, file, pgoff, cc);
+		result = collapse_scan_file(mm, vma, addr, file, pgoff, cc);
 		fput(file);
 		if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
 			mmap_read_lock(mm);
-- 
2.43.5



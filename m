Return-Path: <linux-kernel+bounces-797722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7262B4147C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8F95E58DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBE52D77E4;
	Wed,  3 Sep 2025 05:46:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D70D2D6E7D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878416; cv=none; b=MhMHgkEKSknUt8Q/W0ZEJXn4KPpGgHzdrtEQ8aT6JERNv+YiF/Nh+WoRD0NBN4TTm941V16pTHJIME83VKCDA9ZBNpA0J8S6m89+gtGo61VhCa4F9tzeFsLn+dq+rSi31xZUgXaH//lm2yMAAKcj89ODjfKH/raYwaIkq6N/+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878416; c=relaxed/simple;
	bh=Jl3WpVHXIZdY2ca7KshMjbxNVbQkn15azD0gWvUsNZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rIgMucbz/BcVrsAsgO6oHVd+7hA5RVgIsmtzi/HYe1dXI2bB+BY3qwRfpo35Ia+c8u49zWD721Qdlsg7hEnMaPLBFHh75k+kZLw6tWvk8PmwzSkzMNaD9OuVGwAgQL1ZKVzfH2johoa/4AlnOewzPgQ/uB2otp6oBRv5RAhrR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64C451692;
	Tue,  2 Sep 2025 22:46:44 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 923DE3F694;
	Tue,  2 Sep 2025 22:46:48 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	kas@kernel.org,
	willy@infradead.org,
	hughd@google.com
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
Subject: [PATCH 2/2] mm: Drop all references of writable and SCAN_PAGE_RO
Date: Wed,  3 Sep 2025 11:16:35 +0530
Message-Id: <20250903054635.19949-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250903054635.19949-1-dev.jain@arm.com>
References: <20250903054635.19949-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all actionable outcomes from checking pte_write() are gone,
drop the related references.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 include/trace/events/huge_memory.h | 19 ++++++-------------
 mm/khugepaged.c                    | 14 +++-----------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 2305df6cb485..dd94d14a2427 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -19,7 +19,6 @@
 	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
 	EM( SCAN_PTE_UFFD_WP,		"pte_uffd_wp")			\
 	EM( SCAN_PTE_MAPPED_HUGEPAGE,	"pte_mapped_hugepage")		\
-	EM( SCAN_PAGE_RO,		"no_writable_page")		\
 	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
 	EM( SCAN_PAGE_NULL,		"page_null")			\
 	EM( SCAN_SCAN_ABORT,		"scan_aborted")			\
@@ -55,15 +54,14 @@ SCAN_STATUS
 
 TRACE_EVENT(mm_khugepaged_scan_pmd,
 
-	TP_PROTO(struct mm_struct *mm, struct folio *folio, bool writable,
+	TP_PROTO(struct mm_struct *mm, struct folio *folio,
 		 int referenced, int none_or_zero, int status, int unmapped),
 
-	TP_ARGS(mm, folio, writable, referenced, none_or_zero, status, unmapped),
+	TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
 		__field(unsigned long, pfn)
-		__field(bool, writable)
 		__field(int, referenced)
 		__field(int, none_or_zero)
 		__field(int, status)
@@ -73,17 +71,15 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
 	TP_fast_assign(
 		__entry->mm = mm;
 		__entry->pfn = folio ? folio_pfn(folio) : -1;
-		__entry->writable = writable;
 		__entry->referenced = referenced;
 		__entry->none_or_zero = none_or_zero;
 		__entry->status = status;
 		__entry->unmapped = unmapped;
 	),
 
-	TP_printk("mm=%p, scan_pfn=0x%lx, writable=%d, referenced=%d, none_or_zero=%d, status=%s, unmapped=%d",
+	TP_printk("mm=%p, scan_pfn=0x%lx, referenced=%d, none_or_zero=%d, status=%s, unmapped=%d",
 		__entry->mm,
 		__entry->pfn,
-		__entry->writable,
 		__entry->referenced,
 		__entry->none_or_zero,
 		__print_symbolic(__entry->status, SCAN_STATUS),
@@ -117,15 +113,14 @@ TRACE_EVENT(mm_collapse_huge_page,
 TRACE_EVENT(mm_collapse_huge_page_isolate,
 
 	TP_PROTO(struct folio *folio, int none_or_zero,
-		 int referenced, bool  writable, int status),
+		 int referenced, int status),
 
-	TP_ARGS(folio, none_or_zero, referenced, writable, status),
+	TP_ARGS(folio, none_or_zero, referenced, status),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, pfn)
 		__field(int, none_or_zero)
 		__field(int, referenced)
-		__field(bool, writable)
 		__field(int, status)
 	),
 
@@ -133,15 +128,13 @@ TRACE_EVENT(mm_collapse_huge_page_isolate,
 		__entry->pfn = folio ? folio_pfn(folio) : -1;
 		__entry->none_or_zero = none_or_zero;
 		__entry->referenced = referenced;
-		__entry->writable = writable;
 		__entry->status = status;
 	),
 
-	TP_printk("scan_pfn=0x%lx, none_or_zero=%d, referenced=%d, writable=%d, status=%s",
+	TP_printk("scan_pfn=0x%lx, none_or_zero=%d, referenced=%d, status=%s",
 		__entry->pfn,
 		__entry->none_or_zero,
 		__entry->referenced,
-		__entry->writable,
 		__print_symbolic(__entry->status, SCAN_STATUS))
 );
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a0f1df2a7ae6..af5f5c80fe4e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -39,7 +39,6 @@ enum scan_result {
 	SCAN_PTE_NON_PRESENT,
 	SCAN_PTE_UFFD_WP,
 	SCAN_PTE_MAPPED_HUGEPAGE,
-	SCAN_PAGE_RO,
 	SCAN_LACK_REFERENCED_PAGE,
 	SCAN_PAGE_NULL,
 	SCAN_SCAN_ABORT,
@@ -557,7 +556,6 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	struct folio *folio = NULL;
 	pte_t *_pte;
 	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
-	bool writable = false;
 
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, address += PAGE_SIZE) {
@@ -671,9 +669,6 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
 								     address)))
 			referenced++;
-
-		if (pte_write(pteval))
-			writable = true;
 	}
 
 	if (unlikely(cc->is_khugepaged && !referenced)) {
@@ -681,13 +676,13 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	} else {
 		result = SCAN_SUCCEED;
 		trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
-						    referenced, writable, result);
+						    referenced, result);
 		return result;
 	}
 out:
 	release_pte_pages(pte, _pte, compound_pagelist);
 	trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
-					    referenced, writable, result);
+					    referenced, result);
 	return result;
 }
 
@@ -1280,7 +1275,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	unsigned long _address;
 	spinlock_t *ptl;
 	int node = NUMA_NO_NODE, unmapped = 0;
-	bool writable = false;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
@@ -1344,8 +1338,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 			result = SCAN_PTE_UFFD_WP;
 			goto out_unmap;
 		}
-		if (pte_write(pteval))
-			writable = true;
 
 		page = vm_normal_page(vma, _address, pteval);
 		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
@@ -1435,7 +1427,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		*mmap_locked = false;
 	}
 out:
-	trace_mm_khugepaged_scan_pmd(mm, folio, writable, referenced,
+	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
 				     none_or_zero, result, unmapped);
 	return result;
 }
-- 
2.30.2



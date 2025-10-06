Return-Path: <linux-kernel+bounces-843091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FA8BBE63D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3AE18865AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041502D6E52;
	Mon,  6 Oct 2025 14:46:19 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B861C6B4
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761978; cv=none; b=s65rGO7+ZvkbWxw9nAKsQ+LW5XkHyFXZTKNBQp1er6IzRNCjZ24nKDNn774XvEdFHRw4A12VxqNbQBFEw0XpuAnk2enzfwqwK/JVYk/6QCsfScLurbTBhvDKLW2Mev39xOrFV27t1DO4RxiwdtF+RzWU6BgHWdsdslLzo5vMIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761978; c=relaxed/simple;
	bh=J1a8h9/BCLeHn/rrIox4M4re1XCtlGmPzhSigCowvBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGwC7BVRe5y/3rtRAh+s20enLTxTRwv57OXBDo6JqlK/vhYkl5YrJB4KMgbdF+h0h2WUv7hV56fkRYT+2PmPS21r09PpqI6VIZBX1baRYZ+IYwVYEcWHdTMSWAeGiJyGRp1YPvTgdG20wZpSrpKjM5GFdYuOjJFM+r6BmwLFvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso31064505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761974; x=1760366774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuqcl+A9rzc72Ea/feTXtRnC4gt7duKqUHLzgITS2ys=;
        b=b5w7PDl3qSNz9VYQGzUUBKEeCZlzj6iI1eRF1ioctKnmsD0Zbsl/IB1UXKUSWcdAfV
         hwIdbeE3kPpb4fCuu5l2PAZxO1fZy9Xzl8y4Rknz1g6C1o4bYR1UlSnM53g28X6Kj72J
         mGheGCG0bZDF4xxeH3wujsnhaRvfMmuD988NSdMFXSawV3AlP1empY8Tvst54rnfRZlf
         uilRc2AqibG7I07Ug5cyM76scap74AIOouQli8VOfIYnMTLxIkBEnM6zz4i/E63FZmZf
         r1Ex8RHwvy5bi7VIyAVq0ElGbQfPnI3Si/YRR+4L0jAIICbqAqgKvOqSWV70i0wfANIa
         rUxA==
X-Forwarded-Encrypted: i=1; AJvYcCUejI2YmV8MsWs6gOKZzpkrMkhe1cjNDUaF0bSz9n0rBPeYVcHQhzLmgD2Xc8ZYk/p5FEcGdLXRyiQUPoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcH0GjKsWfkzVnr65g3+9pJZ1wY1yoDtTIcVRlRqOyTdYNsPtS
	Utf6Hp3Eq42YCbT46Po7+z1TYUyDyLYJ2k+26Fb5JE1F7AMp0E74LhU6
X-Gm-Gg: ASbGnct5fs9h2L9tIh/1AUpDyYDVW3t0tA0t9mi9ZKbblzFIyx4+ce8s0bC+JHJKi9/
	wcogjDXAGdTlbJWANoiRqPI16mtRHTH+J3kWpVqoXdsPaX3Hi6XarLph+yj1Chx1r/HUHaL7Y34
	9YxZ+5wBud9Pj9hQNryrHHz1/jTFJV5q9Q9EJ8WcNNb0XXrhax2Ntp5c5OCun2aVeRhISCzXJcl
	EUrOlDQXTm4BHu26Jd6iysTEgN9epUo0s/mTek6Hq5dBUtNj1kEWY+I9zsIVWTYQPuTkmsaaY3L
	/12Vz2aUJxu2RbqWUbTY44yG5uNeb+mxOkT6J6YpsjJ1+ECRGxoBDd6VglHg1I9q9dcSQe8IxCx
	mT4ec+WZ9T/1j9CUvnHQ8U1fWUDChi4YqF4DWx5s=
X-Google-Smtp-Source: AGHT+IHFHcUdMzS1csXhoGyXZeti7+KMioYMHOfR7zhdo2kycZLG0GjGV8+xFl9piJYAU+8ueDHsMg==
X-Received: by 2002:a05:6000:2f83:b0:3da:e7d7:f1e0 with SMTP id ffacd0b85a97d-42567174959mr8714398f8f.27.1759761973329;
        Mon, 06 Oct 2025 07:46:13 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm21242624f8f.18.2025.10.06.07.46.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Oct 2025 07:46:13 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	richard.weiyang@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new v2 3/3] mm/khugepaged: merge PTE scanning logic into a new helper
Date: Mon,  6 Oct 2025 22:43:38 +0800
Message-ID: <20251006144338.96519-4-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251006144338.96519-1-lance.yang@linux.dev>
References: <20251006144338.96519-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
and __collapse_huge_page_isolate() was almost duplicated.

This patch cleans things up by moving all the common PTE checking logic
into a new shared helper, thp_collapse_check_pte().

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 244 ++++++++++++++++++++++++++----------------------
 1 file changed, 131 insertions(+), 113 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 87a8df90b3a6..96ea8d1b9fed 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -61,6 +61,12 @@ enum scan_result {
 	SCAN_PAGE_FILLED,
 };
 
+enum pte_check_result {
+	PTE_CHECK_SUCCEED,
+	PTE_CHECK_CONTINUE,
+	PTE_CHECK_FAIL,
+};
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/huge_memory.h>
 
@@ -533,62 +539,140 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 	}
 }
 
+/*
+ * thp_collapse_check_pte - Check if a PTE is suitable for THP collapse
+ * @pte:           The PTE to check
+ * @vma:           The VMA the PTE belongs to
+ * @addr:          The virtual address corresponding to this PTE
+ * @cc:            Collapse control settings
+ * @foliop:        On success, used to return a pointer to the folio
+ *                 Must be non-NULL
+ * @none_or_zero:  Counter for none/zero PTEs. Must be non-NULL
+ * @unmapped:      Counter for swap PTEs. Can be NULL if not scanning swaps
+ * @shared:        Counter for shared pages. Must be non-NULL
+ * @scan_result:   Used to return the failure reason (SCAN_*) on a
+ *                 PTE_CHECK_FAIL return. Must be non-NULL
+ *
+ * Returns:
+ *   PTE_CHECK_SUCCEED  - PTE is suitable, proceed with further checks
+ *   PTE_CHECK_CONTINUE - Skip this PTE and continue scanning
+ *   PTE_CHECK_FAIL     - Abort collapse scan
+ */
+static inline int thp_collapse_check_pte(pte_t pte, struct vm_area_struct *vma,
+		unsigned long addr, struct collapse_control *cc,
+		struct folio **foliop, int *none_or_zero, int *unmapped,
+		int *shared, int *scan_result)
+{
+	struct folio *folio = NULL;
+	struct page *page = NULL;
+
+	if (pte_none(pte) || is_zero_pfn(pte_pfn(pte))) {
+		(*none_or_zero)++;
+		if (!userfaultfd_armed(vma) &&
+		    (!cc->is_khugepaged ||
+		     *none_or_zero <= khugepaged_max_ptes_none)) {
+			return PTE_CHECK_CONTINUE;
+		} else {
+			*scan_result = SCAN_EXCEED_NONE_PTE;
+			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+			return PTE_CHECK_FAIL;
+		}
+	} else if (!pte_present(pte)) {
+		if (!unmapped) {
+			*scan_result = SCAN_PTE_NON_PRESENT;
+			return PTE_CHECK_FAIL;
+		}
+
+		if (non_swap_entry(pte_to_swp_entry(pte))) {
+			*scan_result = SCAN_PTE_NON_PRESENT;
+			return PTE_CHECK_FAIL;
+		}
+
+		(*unmapped)++;
+		if (!cc->is_khugepaged ||
+		    *unmapped <= khugepaged_max_ptes_swap) {
+			/*
+			 * Always be strict with uffd-wp enabled swap
+			 * entries. Please see comment below for
+			 * pte_uffd_wp().
+			 */
+			if (pte_swp_uffd_wp(pte)) {
+				*scan_result = SCAN_PTE_UFFD_WP;
+				return PTE_CHECK_FAIL;
+			}
+			return PTE_CHECK_CONTINUE;
+		} else {
+			*scan_result = SCAN_EXCEED_SWAP_PTE;
+			count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
+			return PTE_CHECK_FAIL;
+		}
+	} else if (pte_uffd_wp(pte)) {
+		/*
+		 * Don't collapse the page if any of the small PTEs are
+		 * armed with uffd write protection. Here we can also mark
+		 * the new huge pmd as write protected if any of the small
+		 * ones is marked but that could bring unknown userfault
+		 * messages that falls outside of the registered range.
+		 * So, just be simple.
+		 */
+		*scan_result = SCAN_PTE_UFFD_WP;
+		return PTE_CHECK_FAIL;
+	}
+
+	page = vm_normal_page(vma, addr, pte);
+	if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		*scan_result = SCAN_PAGE_NULL;
+		return PTE_CHECK_FAIL;
+	}
+
+	folio = page_folio(page);
+	if (!folio_test_anon(folio)) {
+		VM_WARN_ON_FOLIO(true, folio);
+		*scan_result = SCAN_PAGE_ANON;
+		return PTE_CHECK_FAIL;
+	}
+
+	/*
+	 * We treat a single page as shared if any part of the THP
+	 * is shared.
+	 */
+	if (folio_maybe_mapped_shared(folio)) {
+		(*shared)++;
+		if (cc->is_khugepaged && *shared > khugepaged_max_ptes_shared) {
+			*scan_result = SCAN_EXCEED_SHARED_PTE;
+			count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
+			return PTE_CHECK_FAIL;
+		}
+	}
+
+	*foliop = folio;
+
+	return PTE_CHECK_SUCCEED;
+}
+
 static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 					unsigned long start_addr,
 					pte_t *pte,
 					struct collapse_control *cc,
 					struct list_head *compound_pagelist)
 {
-	struct page *page = NULL;
 	struct folio *folio = NULL;
 	unsigned long addr = start_addr;
 	pte_t *_pte;
 	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
+	int pte_check_res;
 
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
-			++none_or_zero;
-			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
-				continue;
-			} else {
-				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-				goto out;
-			}
-		} else if (!pte_present(pteval)) {
-			result = SCAN_PTE_NON_PRESENT;
-			goto out;
-		} else if (pte_uffd_wp(pteval)) {
-			result = SCAN_PTE_UFFD_WP;
-			goto out;
-		}
-		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
-			result = SCAN_PAGE_NULL;
-			goto out;
-		}
 
-		folio = page_folio(page);
-		if (!folio_test_anon(folio)) {
-			VM_WARN_ON_FOLIO(true, folio);
-			result = SCAN_PAGE_ANON;
-			goto out;
-		}
+		pte_check_res = thp_collapse_check_pte(pteval, vma, addr, cc,
+					&folio, &none_or_zero, NULL, &shared, &result);
 
-		/* See hpage_collapse_scan_pmd(). */
-		if (folio_maybe_mapped_shared(folio)) {
-			++shared;
-			if (cc->is_khugepaged &&
-			    shared > khugepaged_max_ptes_shared) {
-				result = SCAN_EXCEED_SHARED_PTE;
-				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
-				goto out;
-			}
-		}
+		if (pte_check_res == PTE_CHECK_CONTINUE)
+			continue;
+		else if (pte_check_res == PTE_CHECK_FAIL)
+			goto out;
 
 		if (folio_test_large(folio)) {
 			struct folio *f;
@@ -1259,11 +1343,11 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	pte_t *pte, *_pte;
 	int result = SCAN_FAIL, referenced = 0;
 	int none_or_zero = 0, shared = 0;
-	struct page *page = NULL;
 	struct folio *folio = NULL;
 	unsigned long addr;
 	spinlock_t *ptl;
 	int node = NUMA_NO_NODE, unmapped = 0;
+	int pte_check_res;
 
 	VM_BUG_ON(start_addr & ~HPAGE_PMD_MASK);
 
@@ -1282,81 +1366,15 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
-			++none_or_zero;
-			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
-				continue;
-			} else {
-				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-				goto out_unmap;
-			}
-		} else if (!pte_present(pteval)) {
-			if (non_swap_entry(pte_to_swp_entry(pteval))) {
-				result = SCAN_PTE_NON_PRESENT;
-				goto out_unmap;
-			}
-
-			++unmapped;
-			if (!cc->is_khugepaged ||
-			    unmapped <= khugepaged_max_ptes_swap) {
-				/*
-				 * Always be strict with uffd-wp
-				 * enabled swap entries.  Please see
-				 * comment below for pte_uffd_wp().
-				 */
-				if (pte_swp_uffd_wp(pteval)) {
-					result = SCAN_PTE_UFFD_WP;
-					goto out_unmap;
-				}
-				continue;
-			} else {
-				result = SCAN_EXCEED_SWAP_PTE;
-				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
-				goto out_unmap;
-			}
-		} else if (pte_uffd_wp(pteval)) {
-			/*
-			 * Don't collapse the page if any of the small
-			 * PTEs are armed with uffd write protection.
-			 * Here we can also mark the new huge pmd as
-			 * write protected if any of the small ones is
-			 * marked but that could bring unknown
-			 * userfault messages that falls outside of
-			 * the registered range.  So, just be simple.
-			 */
-			result = SCAN_PTE_UFFD_WP;
-			goto out_unmap;
-		}
 
-		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
-			result = SCAN_PAGE_NULL;
-			goto out_unmap;
-		}
-		folio = page_folio(page);
+		pte_check_res = thp_collapse_check_pte(pteval, vma, addr, cc,
+					&folio, &none_or_zero, &unmapped,
+					&shared, &result);
 
-		if (!folio_test_anon(folio)) {
-			VM_WARN_ON_FOLIO(true, folio);
-			result = SCAN_PAGE_ANON;
+		if (pte_check_res == PTE_CHECK_CONTINUE)
+			continue;
+		else if (pte_check_res == PTE_CHECK_FAIL)
 			goto out_unmap;
-		}
-
-		/*
-		 * We treat a single page as shared if any part of the THP
-		 * is shared.
-		 */
-		if (folio_maybe_mapped_shared(folio)) {
-			++shared;
-			if (cc->is_khugepaged &&
-			    shared > khugepaged_max_ptes_shared) {
-				result = SCAN_EXCEED_SHARED_PTE;
-				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
-				goto out_unmap;
-			}
-		}
 
 		/*
 		 * Record which node the original page is from and save this
-- 
2.49.0



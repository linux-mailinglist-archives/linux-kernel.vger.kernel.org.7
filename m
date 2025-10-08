Return-Path: <linux-kernel+bounces-845037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD4BC3553
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A21864F1971
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DC02BEC53;
	Wed,  8 Oct 2025 04:40:26 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5F2BEC3A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898425; cv=none; b=BpzQIMIppeVTYw8LSdtPUGb8Sd4hpszZkLzDbjiyTOJgk3/GVvI5jVwwFpe04AUdRmUt7HbnBszQTHGpozIxtlSemv4EFQ7bP+YLLtF3SU0ucaKrICT3p1RT+Lm0jkBpFsC+ZkBl7ploO+A+jSWo1CaATA1wfn/kU06fpP8sIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898425; c=relaxed/simple;
	bh=qSNZNuXhi64kHU7q22LPeQqfDx8xX+FcK9o+ua0+r/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqNpjmIHp7SSb5Gu+C4uv3Pm1qQhtRb4HaCSul+7Jfk8Lvg1Saj1tr15n8HYILsaMi6qE02HnIlf2cHHk9FRjo1coqSVgptgiS+RvDqzdKPOggPOL1oTqwAZrGLPmboGsnw61cuUDLsf7ZFRMvAKXUqi7/3XQarfq6UZJiTmaG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42420c7de22so3744187f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898421; x=1760503221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4CdxE8CMoT0aWE1+y5A5fa72do+/1xnsq0UYyqE6iA=;
        b=R0ZWqBajM/aePmWNwb+6EgEI345TP6qp4FtI4KXh2H38TLYj13r3/UxV0H95qaYoAl
         IqplC86zMdAh2eiOsTdHHNAhzI/rmc4cjUcO3H7NSuKQUW9yzxlC/3jiIh+2RrJ7M1H1
         BAf+LOMKXtW0zflHOtf5X8F6V79uS2UTej/QyU7yJiCGPM1ankm6VW+ycDeAC5vUgrHs
         nPaX4LWzFp6Hv+W/9eE6N1PPqP12P7XZr04TU1WyycfmWkDkqDnxQmbNoQwgDd4d3sR+
         DnDPu52ic+veInMZ0OsawKJzWLX+3jEHSLN3MaQyhVFaYIznKHMJwiatcfIhZts1/WZq
         34Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXEMMSiOFSLxDo7b55R+izm/hyyY0zFoZ4Tgrq/swDrBUsW6aTKjMMYqbiN7zMy+fXitmRfmFUhj6c66U4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4Tg5USadS0YkeKMPyvqD+5AFH2LGSgET3nhPTgiMITZ38id/
	/I4mGLAh4RtB8sYcVNXJ0F1q60aLp6uYzH+i6S/khr05DB8nW3Z2G6QY
X-Gm-Gg: ASbGncv/7UlvA0Mdo64Mms7YYlGSuHOAChFDLCSK6+ZeCvunIr7exqjAsluFeT4G5Lc
	bY8g36in5RpXhwjYrFShxFv1WyG4sV3x2esQbFYG2zVSBjQ/Rf6AvErgP7j1zzCqz+Vy79vl5Wd
	B+2jzFQ6lw+4TGmjWj0VZKPz69eYBGypNJg3Jahj/7z1JuiyD1WxH86wAl5seSmFGWSD5k+CGad
	Bj4se/kwnuY8PI6oWaTNG5dSLWDw1Bs53eGRUxCHGfF1VRClxft3efpWVJvXBXYKHowr5UF4Fg+
	8FjeI8wPNOft5XWxIs93Gj0mxGYdXE3MV17bN+YAs7dM2BSGNeqX9aj2U2mDSsuiny2cnqaW/Ef
	B7wn0XNrG0bEFgK+TK4u6F3pl6QVU8BCs6UlxVck=
X-Google-Smtp-Source: AGHT+IHch9/ftJLZar+bagytdzxWRTkDWRmOOzIGqnFNZ4Rsbi6RYB3Zvqgd5s1fv1Io5v5ehi2r0A==
X-Received: by 2002:a05:6000:26c2:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-4266e7beb57mr772457f8f.23.1759898421384;
        Tue, 07 Oct 2025 21:40:21 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::30b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c49sm28159164f8f.3.2025.10.07.21.40.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Oct 2025 21:40:21 -0700 (PDT)
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
Subject: [PATCH mm-new v3 3/3] mm/khugepaged: merge PTE scanning logic into a new helper
Date: Wed,  8 Oct 2025 12:37:48 +0800
Message-ID: <20251008043748.45554-4-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251008043748.45554-1-lance.yang@linux.dev>
References: <20251008043748.45554-1-lance.yang@linux.dev>
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
into a new shared helper, thp_collapse_check_pte(). While at it, we use
vm_normal_folio() instead of vm_normal_page().

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 243 ++++++++++++++++++++++++++----------------------
 1 file changed, 130 insertions(+), 113 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b5c0295c3414..7116caae1fa4 100644
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
 
@@ -533,62 +539,139 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 	}
 }
 
+/*
+ * thp_collapse_check_pte - Check if a PTE is suitable for THP collapse
+ * @pte:           The PTE to check
+ * @vma:           The VMA the PTE belongs to
+ * @addr:          The virtual address corresponding to this PTE
+ * @foliop:        On success, used to return a pointer to the folio
+ *                 Must be non-NULL
+ * @none_or_zero:  Counter for none/zero PTEs. Must be non-NULL
+ * @unmapped:      Counter for swap PTEs. Can be NULL if not scanning swaps
+ * @shared:        Counter for shared pages. Must be non-NULL
+ * @scan_result:   Used to return the failure reason (SCAN_*) on a
+ *                 PTE_CHECK_FAIL return. Must be non-NULL
+ * @cc:            Collapse control settings
+ *
+ * Returns:
+ *   PTE_CHECK_SUCCEED  - PTE is suitable, proceed with further checks
+ *   PTE_CHECK_CONTINUE - Skip this PTE and continue scanning
+ *   PTE_CHECK_FAIL     - Abort collapse scan
+ */
+static inline int thp_collapse_check_pte(pte_t pte, struct vm_area_struct *vma,
+		unsigned long addr, struct folio **foliop, int *none_or_zero,
+		int *unmapped, int *shared, int *scan_result,
+		struct collapse_control *cc)
+{
+	struct folio *folio = NULL;
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
+	folio = vm_normal_folio(vma, addr, pte);
+	if (unlikely(!folio) || unlikely(folio_is_zone_device(folio))) {
+		*scan_result = SCAN_PAGE_NULL;
+		return PTE_CHECK_FAIL;
+	}
+
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
+		pte_check_res = thp_collapse_check_pte(pteval, vma, addr,
+					&folio, &none_or_zero, NULL, &shared,
+					&result, cc);
 
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
@@ -1264,11 +1347,11 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
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
 
@@ -1287,81 +1370,15 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
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
+		pte_check_res = thp_collapse_check_pte(pteval, vma, addr,
+					&folio, &none_or_zero, &unmapped,
+					&shared, &result, cc);
 
-		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
-			result = SCAN_PAGE_NULL;
-			goto out_unmap;
-		}
-		folio = page_folio(page);
-
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



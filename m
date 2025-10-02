Return-Path: <linux-kernel+bounces-839910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68ABB2B41
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C73A3816CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8E2C15B4;
	Thu,  2 Oct 2025 07:35:20 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA23AC1C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390519; cv=none; b=QUH0xrc7oaeQKvlyq5kHuX/kH/lGVLBEwjwqoecxRmo7+pbLr5QlHfU9xXJK3nz6YbtVPNj+HGGdCPTxvZbbvg2EkAGOAA7oIU2qrBdBFHKeABjSnPD34Qg8ZvDQIyUslEhFosiGOeX8G8+be27g8rqJhiXmaWyEtT4pwFwv3do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390519; c=relaxed/simple;
	bh=rmuM0MD2ciX1Pd8Rg9KHh0EbnOzgRa+Zfy5b760c6+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPIzYDnt9mqRzHPnKmDvV6nEA2z+ar9nU0/cmJrPwDOGL0qjjy986Fwm4mj7fKlzBmo84lUVSINe82CsDKE/wCullSSZ3c3l7rMWv0bMUWdtFOWZXB5sVxWivUXmm2zYi+juDuqwTebjYR3XHaQvMBvgQ+NvVt/iaYy5CGGMza4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so6785535e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759390516; x=1759995316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2P+QxCKNk8CP42mvLpExWTtDqGlhoKEfhagqG2LkgdE=;
        b=g070ME5D7lrby3alo7VfWGiPqbDGHZ/ttdiB9D2Rk2QOMwHKHSMZJgPrZOrzQ9H4UO
         8CBZxNYiK99otStBcigSk5gEzOfiCOuJrJpDXMQXpQDuenOmK4g663PhCcHtb/OJXrA7
         8cluxNpkLnC/0gee9bULJyJbQNm6GsPTBcvVUeXWuVlxdUx2bucsvxbRN74P4tV6mNLA
         NcJ+W/ePWU6OznF7hUAYqo2lGLKhrXv8VIwGHGNK/pGJTyCPafR5s2KitwdJW9v6pErN
         DO3NYrUl+r5UhMnjSZCERSKcv1bwPSXte/u6JpCFEWSsi5rUtd6806ob4hO4djgU7H7Y
         8GRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwfJBOhrUaT8DsvzV3vDMQBrjxurO/LKSOLQ4/m8XR5ySEiEZSfjBUnTBpa/lEknP3Wj3FNJDn6pnxLoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzjCJh9tTwF+ChnzTqeNKzMfAxAY14bOCRugLds3xWQWb+pJaV
	8CfJV7Nk1hNIS4zg1rvjyoQsY2/Az23pd74poGrXRxrENJcRx88GTdn3
X-Gm-Gg: ASbGncuMlgWEgkWGPaATU9jkxBkv/lfg7di7u0Q7GWPKzevEV0oO3+4GfMUoCbGmDSh
	lU5bRxPWvbmGsbS6dl7d+CEIpdH0JTbP2SULzEvvD+oDKJFHTEYfYKJnSwy9wTD+BuCAUENTicH
	numOgZlLOfHOLNV6jA7JkOiW21ZkM9neNwbhpi1nLwvX7OIBoGaJQuUqnBtrA4a/zp8kvCxH6rS
	SFPIhXoDTKyZDsq4j1AGv1JHaMU0t2o+8TlKEy6iuqJiasT4CXdOp8qN4w7UEqMaamsXwFEySkm
	64/0tQdzJOBB5q92CUexdPm1hqgqMKFyzcgkxuh/ZUHqC4xxNr1TfwnaZ3CX3F2dnDvuJRdkmIZ
	v+XX5Ym/nhJym+4lycfqq4zRjnd2QCqe3J+9Fypk=
X-Google-Smtp-Source: AGHT+IHwYErkeuuJqmW0yYHHSaG/VO1vFpQ/Hjjaa4y+3AfuoUXztvBinSjkxvpo2QRl7b9xEIGvKw==
X-Received: by 2002:a05:600c:1382:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-46e6863e130mr18122025e9.7.1759390516191;
        Thu, 02 Oct 2025 00:35:16 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6a692af6sm17856135e9.21.2025.10.02.00.35.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Oct 2025 00:35:15 -0700 (PDT)
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
Subject: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into a new helper
Date: Thu,  2 Oct 2025 15:32:55 +0800
Message-ID: <20251002073255.14867-3-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251002073255.14867-1-lance.yang@linux.dev>
References: <20251002073255.14867-1-lance.yang@linux.dev>
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
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 167 ++++++++++++++++++++++++++++++------------------
 1 file changed, 104 insertions(+), 63 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 808523f92c7b..2a897cfb1d03 100644
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
 
@@ -533,6 +539,87 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 	}
 }
 
+/*
+ * thp_collapse_check_pte - Check if a PTE is suitable for THP collapse
+ * @pte:           PTE to check
+ * @vma:           VMA the PTE belongs to
+ * @cc:            Collapse control settings
+ * @scan_swap_pte: Allow scanning of swap PTEs if true
+ * @none_or_zero:  Counter for none/zero PTEs (must be non-NULL)
+ * @unmapped:      Counter for swap PTEs (must be non-NULL if scan_swap_pte
+ *                 is true)
+ * @scan_result:   Used to return the failure reason (SCAN_*) on a
+ *                 PTE_CHECK_FAIL return. Must be non-NULL
+ *
+ * Returns:
+ *   PTE_CHECK_SUCCEED  - Valid PTE, proceed with collapse
+ *   PTE_CHECK_CONTINUE - Skip this none/zero PTE but continue scanning
+ *   PTE_CHECK_FAIL     - Abort collapse scan
+ */
+static inline int thp_collapse_check_pte(pte_t pte, struct vm_area_struct *vma,
+		struct collapse_control *cc, bool scan_swap_pte,
+		int *none_or_zero, int *unmapped, int *scan_result)
+{
+	VM_BUG_ON(!none_or_zero || !scan_result);
+	VM_BUG_ON(scan_swap_pte && !unmapped);
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
+		if (!scan_swap_pte) {
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
+			 * Always be strict with uffd-wp
+			 * enabled swap entries. Please see
+			 * comment below for pte_uffd_wp().
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
+		 * Don't collapse the page if any of the small
+		 * PTEs are armed with uffd write protection.
+		 * Here we can also mark the new huge pmd as
+		 * write protected if any of the small ones is
+		 * marked but that could bring unknown
+		 * userfault messages that falls outside of
+		 * the registered range.  So, just be simple.
+		 */
+		*scan_result = SCAN_PTE_UFFD_WP;
+		return PTE_CHECK_FAIL;
+	}
+
+	return PTE_CHECK_SUCCEED;
+}
+
 static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 					unsigned long start_addr,
 					pte_t *pte,
@@ -544,28 +631,20 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
+		pte_check_res = thp_collapse_check_pte(
+			pteval, vma, cc, false, /* scan_swap_pte = false */
+			&none_or_zero, NULL, &result);
+
+		if (pte_check_res == PTE_CHECK_CONTINUE)
+			continue;
+		else if (pte_check_res == PTE_CHECK_FAIL)
 			goto out;
-		}
+
 		page = vm_normal_page(vma, addr, pteval);
 		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
 			result = SCAN_PAGE_NULL;
@@ -1260,6 +1339,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	unsigned long addr;
 	spinlock_t *ptl;
 	int node = NUMA_NO_NODE, unmapped = 0;
+	int pte_check_res;
 
 	VM_BUG_ON(start_addr & ~HPAGE_PMD_MASK);
 
@@ -1278,54 +1358,15 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
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
+		pte_check_res = thp_collapse_check_pte(
+			pteval, vma, cc, true, /* scan_swap_pte = true */
+			&none_or_zero, &unmapped, &result);
+
+		if (pte_check_res == PTE_CHECK_CONTINUE)
+			continue;
+		else if (pte_check_res == PTE_CHECK_FAIL)
 			goto out_unmap;
-		}
 
 		page = vm_normal_page(vma, addr, pteval);
 		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
-- 
2.49.0



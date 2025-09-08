Return-Path: <linux-kernel+bounces-805255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 358FBB4860C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FE61898248
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FDD2E8DF4;
	Mon,  8 Sep 2025 07:51:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511F52E8B8F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317879; cv=none; b=GCtAW8iZCzFqYbVOZWWVwULnEgIYjpM8cdNXXop38qf0WS4p7bPz682jIChxPBkVmEb+x2Onn6fXNJkoQ/nQKCv5BHYDjqQ9ht3t3YKIbPhJHyVNp/1dZtWTtGJbbE4AZRXNSoAHT8mvanDdNVAQ2U3Ybzs/O7lUOAz+r2PTuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317879; c=relaxed/simple;
	bh=C308Md0Nbn3hdTAR4O3V1gw5jJJbnHnhb8i2lR8f7ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2BOe8WhlkBPfE0xoxsgrRgL+cj+c6Em8KzqaytfC8O9TXrsi+RsGhaj1BByIFs/9W0MtkkOZA1VPxXkQdsA6uqEX6SUnUJSDBhC2xSMHMPTdp6ZPwrBV/49WGDaFaIVH3HCeoWDIPsAh66wSR79me1mdKS110BTieXRZ8DL5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DC7E169C;
	Mon,  8 Sep 2025 00:51:07 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 759E33F63F;
	Mon,  8 Sep 2025 00:51:11 -0700 (PDT)
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
	richard.weiyang@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 1/2] mm: Enable khugepaged anonymous collapse on non-writable regions
Date: Mon,  8 Sep 2025 13:20:27 +0530
Message-Id: <20250908075028.38431-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250908075028.38431-1-dev.jain@arm.com>
References: <20250908075028.38431-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently khugepaged does not collapse an anonymous region which does not
have a single writable pte. This is wasteful since a region mapped with
non-writable ptes, for example, non-writable VMAs mapped by the
application, won't benefit from THP collapse.

An additional consequence of this constraint is that MADV_COLLAPSE does not
perform a collapse on a non-writable VMA, and this restriction is nowhere
to be found on the manpage - the restriction itself sounds wrong to me
since the user knows the protection of the memory it has mapped, so
collapsing read-only memory via madvise() should be a choice of the
user which shouldn't be overridden by the kernel.

Therefore, remove this restriction by not honouring SCAN_PAGE_RO.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com> 
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4ec324a4c1fe..a0f1df2a7ae6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			writable = true;
 	}
 
-	if (unlikely(!writable)) {
-		result = SCAN_PAGE_RO;
-	} else if (unlikely(cc->is_khugepaged && !referenced)) {
+	if (unlikely(cc->is_khugepaged && !referenced)) {
 		result = SCAN_LACK_REFERENCED_PAGE;
 	} else {
 		result = SCAN_SUCCEED;
@@ -1421,9 +1419,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		     mmu_notifier_test_young(vma->vm_mm, _address)))
 			referenced++;
 	}
-	if (!writable) {
-		result = SCAN_PAGE_RO;
-	} else if (cc->is_khugepaged &&
+	if (cc->is_khugepaged &&
 		   (!referenced ||
 		    (unmapped && referenced < HPAGE_PMD_NR / 2))) {
 		result = SCAN_LACK_REFERENCED_PAGE;
@@ -2830,7 +2826,6 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 		case SCAN_PMD_NULL:
 		case SCAN_PTE_NON_PRESENT:
 		case SCAN_PTE_UFFD_WP:
-		case SCAN_PAGE_RO:
 		case SCAN_LACK_REFERENCED_PAGE:
 		case SCAN_PAGE_NULL:
 		case SCAN_PAGE_COUNT:
-- 
2.30.2



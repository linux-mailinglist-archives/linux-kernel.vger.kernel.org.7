Return-Path: <linux-kernel+bounces-816058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0584B56ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AEA3B64F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2E26A1D9;
	Mon, 15 Sep 2025 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xTUUm3bk"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E01527B4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757907027; cv=none; b=cYDzz8TBl44wThjVMhuI0m51QOJCQ2xfMzJtYCQUaBAz+UBFJsHFynf0yMDPjS9flrJv8QWt8ZOgpqgy4rjGrfnlkFE7L6IE3FF8aNVka6AZMiRiydH/hVllVVA2zuGTE97hsyACe3kc031M6G7ICtIih6IEftXjz5QmtDsVn60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757907027; c=relaxed/simple;
	bh=Z/9i1GMtrLinZ0JgIPhedH1rmENVy8HgASCv5V/T8Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpBT2fYwVmSj6DG4W26ipFy3wmYJDtaOfrUTQC5qrrVBSqCq2Nm4WQYmNqiBjx8qYyjq/P0ANbYqVrNFiQU9JbABROBsGA/PmUlq/oiChRqLLuAF898GcFl5LETXG/sGGMejJDQFqMT7ok0Q+TOPHgomCsJuHZ8zKGJK2uVUlKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xTUUm3bk; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757907016; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EltDD6XaVHb4ywefi6tfTUXJyF6xjUHuaP+jJuKR6OU=;
	b=xTUUm3bk6sKa6+X66NCIcRlgDaFGek2cxSVqDDYjyZMNL3cfFALNeIy2jwro5OlYHf9DfaLVTcSaZ/4l1ZJ5NksDKwewgS1sDq/rErbDoGrM+ehmlV225BSfg8WInFI9RU8SMEkiDlAXaUMGAiKp0ec2sEuP4UOZd0l6rEbC9Jk=
Received: from localhost.localdomain(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wnx2CMR_1757907013 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Sep 2025 11:30:14 +0800
From: Huang Ying <ying.huang@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Yin Fengwei <fengwei_yin@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/2] mm: add spurious fault fixing support for huge pmd
Date: Mon, 15 Sep 2025 11:29:45 +0800
Message-Id: <20250915032946.33203-2-ying.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915032946.33203-1-ying.huang@linux.alibaba.com>
References: <20250915032946.33203-1-ying.huang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current kernel, there is spurious fault fixing support for pte,
but not for huge pmd because no architectures need it. But in the
next patch in the series, we will change the write protection fault
handling logic on arm64, so that some stale huge pmd entries may
remain in the TLB. These entries need to be flushed via the huge pmd
spurious fault fixing mechanism.

Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Yin Fengwei <fengwei_yin@linux.alibaba.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/pgtable.h |  4 ++++
 mm/huge_memory.c        | 25 +++++++++++++++++++++----
 mm/internal.h           |  4 ++--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2b80fd456c8b..d7604ad34d36 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1232,6 +1232,10 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 #define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_page(vma, address)
 #endif
 
+#ifndef flush_tlb_fix_spurious_fault_pmd
+#define flush_tlb_fix_spurious_fault_pmd(vma, address, ptep) do { } while (0)
+#endif
+
 /*
  * When walking page tables, get the address of the next boundary,
  * or the end address of the range if that comes earlier.  Although no
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9c38a95e9f09..0e2ef6b007c2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1650,8 +1650,8 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
-void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
-	       pmd_t *pmd, bool write)
+int touch_pmd(struct vm_area_struct *vma, unsigned long addr,
+	      pmd_t *pmd, bool write)
 {
 	pmd_t _pmd;
 
@@ -1659,8 +1659,12 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (write)
 		_pmd = pmd_mkdirty(_pmd);
 	if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
-				  pmd, _pmd, write))
+				  pmd, _pmd, write)) {
 		update_mmu_cache_pmd(vma, addr, pmd);
+		return 1;
+	}
+
+	return 0;
 }
 
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -1857,7 +1861,20 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
 	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd)))
 		goto unlock;
 
-	touch_pmd(vmf->vma, vmf->address, vmf->pmd, write);
+	if (!touch_pmd(vmf->vma, vmf->address, vmf->pmd, write)) {
+		/* Skip spurious TLB flush for retried page fault */
+		if (vmf->flags & FAULT_FLAG_TRIED)
+			goto unlock;
+		/*
+		 * This is needed only for protection faults but the arch code
+		 * is not yet telling us if this is a protection fault or not.
+		 * This still avoids useless tlb flushes for .text page faults
+		 * with threads.
+		 */
+		if (vmf->flags & FAULT_FLAG_WRITE)
+			flush_tlb_fix_spurious_fault_pmd(vmf->vma, vmf->address,
+							 vmf->pmd);
+	}
 
 unlock:
 	spin_unlock(vmf->ptl);
diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..743ce97c7248 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1406,8 +1406,8 @@ int __must_check try_grab_folio(struct folio *folio, int refs,
  */
 void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 	       pud_t *pud, bool write);
-void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
-	       pmd_t *pmd, bool write);
+int touch_pmd(struct vm_area_struct *vma, unsigned long addr,
+	      pmd_t *pmd, bool write);
 
 /*
  * Parses a string with mem suffixes into its order. Useful to parse kernel
-- 
2.39.5



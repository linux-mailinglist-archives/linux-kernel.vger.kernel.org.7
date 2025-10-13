Return-Path: <linux-kernel+bounces-850212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2572BD2407
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C993B70C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C0A2FD1C2;
	Mon, 13 Oct 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AtrNoBa3"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D7027E056
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347291; cv=none; b=kC/sMZQTCQNcszVCQTWllpwnCH0gW7OcThkwubho1o2FT56uuwWEEjLatfOsov1veIRgkUPxPh56c7HI8djPS/bTxhRphAkbNzKjjcq4I0WI0+oU7jFi8/+t14YQH0JJDVDUP2naASpktKWnE95/npqPDxnmHTBlIPDnB591kFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347291; c=relaxed/simple;
	bh=pPUZHHzBVMY7B1eu3vIlrEjFJa2e23CkBuoEmF9Rx1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ayv8mHusGE+wNxnPtt31UH9G27VL/xQSHojkbgjcI76PGHJ4gUt1HvrJT1zu7N7fALGJgZ78EJ6JfgGpU1iLRIec4+6kB44Qp9C8O6ZfDtlM3ZT32VvaHFlz19Z+qkUuI3lU7CgxKjfPnL83nks8Axy9gNO0lr5QS7VLXfujYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AtrNoBa3; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760347287; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aWm1WdWttrhOYiXiJuOMK69KNjE6Idu3TEdWrDwmXPQ=;
	b=AtrNoBa3F3m0Ly+Wx3DPDNc4Ir7xn8lVA6ZzhDRVd0wBEb5C3DXNfkEgcT0J52HwyMzDDDppRdaGQac0KiJdfi1+8LVSFPig0gXMDEwIdR0xHHIiQMaLyiSmp7JZVgNtNetz0PeYfP+sstghG6tOtoJcHc5Iu7GlKvQAGpnS0Ro=
Received: from localhost.localdomain(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wq1nigk_1760347285 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 17:21:25 +0800
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
Subject: [PATCH -v2 1/2] mm: add spurious fault fixing support for huge pmd
Date: Mon, 13 Oct 2025 17:20:37 +0800
Message-Id: <20251013092038.6963-2-ying.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
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
 mm/huge_memory.c        | 22 +++++++++++++++++-----
 mm/internal.h           |  4 ++--
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 32e8457ad535..341622ec80e4 100644
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
index 1b81680b4225..8533457c52b7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1641,17 +1641,22 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
-void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
-	       pmd_t *pmd, bool write)
+/* Returns whether the PMD entry is changed */
+int touch_pmd(struct vm_area_struct *vma, unsigned long addr,
+	      pmd_t *pmd, bool write)
 {
+	int changed;
 	pmd_t _pmd;
 
 	_pmd = pmd_mkyoung(*pmd);
 	if (write)
 		_pmd = pmd_mkdirty(_pmd);
-	if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
-				  pmd, _pmd, write))
+	changed = pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
+					pmd, _pmd, write);
+	if (changed)
 		update_mmu_cache_pmd(vma, addr, pmd);
+
+	return changed;
 }
 
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -1849,7 +1854,14 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
 	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd)))
 		goto unlock;
 
-	touch_pmd(vmf->vma, vmf->address, vmf->pmd, write);
+	if (!touch_pmd(vmf->vma, vmf->address, vmf->pmd, write)) {
+		/* See corresponding comments in handle_pte_fault(). */
+		if (vmf->flags & FAULT_FLAG_TRIED)
+			goto unlock;
+		if (vmf->flags & FAULT_FLAG_WRITE)
+			flush_tlb_fix_spurious_fault_pmd(vmf->vma, vmf->address,
+							 vmf->pmd);
+	}
 
 unlock:
 	spin_unlock(vmf->ptl);
diff --git a/mm/internal.h b/mm/internal.h
index 1561fc2ff5b8..8b58ab00a7cd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1402,8 +1402,8 @@ int __must_check try_grab_folio(struct folio *folio, int refs,
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



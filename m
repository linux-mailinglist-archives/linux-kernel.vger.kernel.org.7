Return-Path: <linux-kernel+bounces-743537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA71B0FFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C064816CAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FC720409A;
	Thu, 24 Jul 2025 05:23:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838F20296C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334597; cv=none; b=SWel6mjwP7DrdwNCbwRtWQqMtudV3Jx91fFKx91Lt2i2rYYQsiYNqay1xV+YA4A1DrYoglKbe15wMA3aNMcWgo7sNPCYn/o2hyFlGSCT3qdj3ApPE53GMpxwCn+6J/qebaNHa4Q6yDJiGmR0GVsTw3PuQuiJ4dXKntppWK3gzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334597; c=relaxed/simple;
	bh=O+wGFrs8njA14m5dllNKrj4nzx1Qzamm4wQY+p8+QHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAyrDcRCO2MLxPHD/Sr7wNG0FKAhpS6eFFG3EhqiWOQNKCLRX+2vuNb+LO2dVBh3RrPtXGgPYM+Qoy2KOUuoRur01NAREav2PRQllIUJX4ZZiNzsufweruxIFMqJ3ro6dAdmDkOdYuysIxyOOXyN3ycWgW++mp3FYVFoRdQFLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BDCD1CC4;
	Wed, 23 Jul 2025 22:23:08 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 156693F66E;
	Wed, 23 Jul 2025 22:23:10 -0700 (PDT)
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
Subject: [PATCH v4 1/3] mm: add get_and_clear_ptes() and clear_ptes()
Date: Thu, 24 Jul 2025 10:52:59 +0530
Message-Id: <20250724052301.23844-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250724052301.23844-1-dev.jain@arm.com>
References: <20250724052301.23844-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

Let's add variants to be used where "full" does not apply -- which will
be the majority of cases in the future. "full" really only applies if
we are about to tear down a full MM.

Use get_and_clear_ptes() in existing code, clear_ptes() users will
be added next.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 arch/arm64/mm/mmu.c     |  2 +-
 include/linux/pgtable.h | 45 +++++++++++++++++++++++++++++++++++++++++
 mm/mremap.c             |  2 +-
 mm/rmap.c               |  2 +-
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index abd9725796e9..20a89ab97dc5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1528,7 +1528,7 @@ early_initcall(prevent_bootmem_remove_init);
 pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t *ptep, unsigned int nr)
 {
-	pte_t pte = get_and_clear_full_ptes(vma->vm_mm, addr, ptep, nr, /* full = */ 0);
+	pte_t pte = get_and_clear_ptes(vma->vm_mm, addr, ptep, nr);
 
 	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
 		/*
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e3b99920be05..4c035637eeb7 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -736,6 +736,29 @@ static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
 }
 #endif
 
+/**
+ * get_and_clear_ptes - Clear present PTEs that map consecutive pages of
+ *			the same folio, collecting dirty/accessed bits.
+ * @mm: Address space the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to clear.
+ *
+ * Use this instead of get_and_clear_full_ptes() if it is known that we don't
+ * need to clear the full mm, which is mostly the case.
+ *
+ * Note that PTE bits in the PTE range besides the PFN can differ. For example,
+ * some PTEs might be write-protected.
+ *
+ * Context: The caller holds the page table lock.  The PTEs map consecutive
+ * pages that belong to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline pte_t get_and_clear_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, unsigned int nr)
+{
+	return get_and_clear_full_ptes(mm, addr, ptep, nr, 0);
+}
+
 #ifndef clear_full_ptes
 /**
  * clear_full_ptes - Clear present PTEs that map consecutive pages of the same
@@ -768,6 +791,28 @@ static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
 }
 #endif
 
+/**
+ * clear_ptes - Clear present PTEs that map consecutive pages of the same folio.
+ * @mm: Address space the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to clear.
+ *
+ * Use this instead of clear_full_ptes() if it is known that we don't need to
+ * clear the full mm, which is mostly the case.
+ *
+ * Note that PTE bits in the PTE range besides the PFN can differ. For example,
+ * some PTEs might be write-protected.
+ *
+ * Context: The caller holds the page table lock.  The PTEs map consecutive
+ * pages that belong to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline void clear_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, unsigned int nr)
+{
+	clear_full_ptes(mm, addr, ptep, nr, 0);
+}
+
 /*
  * If two threads concurrently fault at the same page, the thread that
  * won the race updates the PTE and its local TLB/Cache. The other thread
diff --git a/mm/mremap.c b/mm/mremap.c
index ac39845e9718..677a4d744df9 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -280,7 +280,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 							 old_pte, max_nr_ptes);
 			force_flush = true;
 		}
-		pte = get_and_clear_full_ptes(mm, old_addr, old_ptep, nr_ptes, 0);
+		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
 		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index f93ce27132ab..568198e9efc2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2036,7 +2036,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			flush_cache_range(vma, address, end_addr);
 
 			/* Nuke the page table entry. */
-			pteval = get_and_clear_full_ptes(mm, address, pvmw.pte, nr_pages, 0);
+			pteval = get_and_clear_ptes(mm, address, pvmw.pte, nr_pages);
 			/*
 			 * We clear the PTE but do not flush so potentially
 			 * a remote CPU could still be writing to the folio.
-- 
2.30.2



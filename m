Return-Path: <linux-kernel+bounces-852676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 221D9BD9961
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0884F8266
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FD2318151;
	Tue, 14 Oct 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cR/djIVU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD500318142
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447271; cv=none; b=qeaK9OmAFH39gj8rG2M26pnFxdOXF/i5/sFRxlEpjpxWkF6RTSPhiA6rXyRQQocbVH60A1PQzns5Ic67dEcOnP/ahaVq1f5h9w7Dq74GgIsIDgmnXpNddgoTKtk1DwMUWTcHwjsE5jvjW/Su0dOKFXCfqlekbZBpLPdQhbiToWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447271; c=relaxed/simple;
	bh=3LqwvcyCTUGBDDv54GKFHPFhtunF891CzWSsBDlRHvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtbkqJfWQgPzSIskwisGGqe7B7xQODd5CVkVmWF0RTuYxkLms4t8he/PKU2ir1D4ynt47Pd14yQLVj8LBHZ9HqoJoA91pfWrTqn6hQUPoPvY9eUbqRMwjMEHBSPhpWZG7W+aQva/HRUoL8FU97PWgAxRqnpI1s4/eMOHWAOqroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cR/djIVU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760447270; x=1791983270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3LqwvcyCTUGBDDv54GKFHPFhtunF891CzWSsBDlRHvg=;
  b=cR/djIVUW9/E+DmNiF9fI6klxUZjTGu1rIqBeY606kVBBa9MEyIJBKVI
   fIMS3fNVX7j/i2gq24eVQdyF732BL/BnWlPW4NlChuqnMoT+7zTV0XiYP
   dY34zCVcdfrQjonutslN9eOMAUSp7GvhDP1IgLE77xbfgWtQyhAWkNhlz
   Be93bQ7meM6NCKobkqDYVw+C1+wuv7EWcsFJ/tlXSRUsiycOq4gp9Z20u
   MtZ63+zB/WW3Dnbv+kpmCm6J3W4rxz2nbOKs3tpI3Dw8/DpR/gGbdcRpp
   UfOQnxDA2lz1cimWCfM/JfzCsGtk4uUFSBJ5h3A2xOEXIuln0PllozeaI
   A==;
X-CSE-ConnectionGUID: AqRuVWPERhqgTxssFR7NVQ==
X-CSE-MsgGUID: Ei+a9jT1RB2bAHTTViiHAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62515378"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62515378"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:07:50 -0700
X-CSE-ConnectionGUID: wkKPsVjuQIOO3qPNmRmAVw==
X-CSE-MsgGUID: z+j4SIdnSy2mQrtAx02caw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="182675618"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2025 06:07:43 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 3/7] x86/mm: Use 'ptdesc' when freeing PMD pages
Date: Tue, 14 Oct 2025 21:04:33 +0800
Message-ID: <20251014130437.1090448-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

There are a billion ways to refer to a physical memory address.
One of the x86 PMD freeing code location chooses to use a 'pte_t *' to
point to a PMD page and then call a PTE-specific freeing function for
it.  That's a bit wonky.

Just use a 'struct ptdesc *' instead. Its entire purpose is to refer
to page table pages. It also means being able to remove an explicit
cast.

Right now, pte_free_kernel() is a one-liner that calls
pagetable_dtor_free(). Effectively, all this patch does is
remove one superfluous __pa(__va(paddr)) conversion and then
call pagetable_dtor_free() directly instead of through a helper.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/mm.h    |  6 ++++--
 arch/x86/mm/pgtable.c | 12 ++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 15ce0c415d36..94e2ec6c5685 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3203,8 +3203,7 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
 	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
 		NULL: pte_offset_kernel(pmd, address))
 
-#if defined(CONFIG_SPLIT_PMD_PTLOCKS)
-
+#if defined(CONFIG_SPLIT_PMD_PTLOCKS) || defined(CONFIG_X86_64)
 static inline struct page *pmd_pgtable_page(pmd_t *pmd)
 {
 	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
@@ -3215,6 +3214,9 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 {
 	return page_ptdesc(pmd_pgtable_page(pmd));
 }
+#endif
+
+#if defined(CONFIG_SPLIT_PMD_PTLOCKS)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ddf248c3ee7d..c830ccbc2fd8 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -729,7 +729,7 @@ int pmd_clear_huge(pmd_t *pmd)
 int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	pmd_t *pmd, *pmd_sv;
-	pte_t *pte;
+	struct ptdesc *pt;
 	int i;
 
 	pmd = pud_pgtable(*pud);
@@ -750,8 +750,8 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 
 	for (i = 0; i < PTRS_PER_PMD; i++) {
 		if (!pmd_none(pmd_sv[i])) {
-			pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
-			pte_free_kernel(&init_mm, pte);
+			pt = pmd_ptdesc(&pmd_sv[i]);
+			pagetable_dtor_free(pt);
 		}
 	}
 
@@ -772,15 +772,15 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
  */
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
-	pte_t *pte;
+	struct ptdesc *pt;
 
-	pte = (pte_t *)pmd_page_vaddr(*pmd);
+	pt = pmd_ptdesc(pmd);
 	pmd_clear(pmd);
 
 	/* INVLPG to clear all paging-structure caches */
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
 
-	pte_free_kernel(&init_mm, pte);
+	pagetable_dtor_free(pt);
 
 	return 1;
 }
-- 
2.43.0



Return-Path: <linux-kernel+bounces-791708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E7B3BA55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F048E3B70F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52831B123;
	Fri, 29 Aug 2025 11:53:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854F31AF3E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468400; cv=none; b=dp7TvUjRAvj6DOakJJepfoByF+8jvcWop+iDs/G1IgSuXn9ZxH9pQk1uZzOd0rsBumbPB1Ip4aW5w2f+brJRa4kVsYqFey1UYl8qzsTaQDiy3FypnLtpNOfrWtC8lfXRE/N7rKTFaPpRWLovfSlcKHSk2gLI9XVyJzsvC4FXFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468400; c=relaxed/simple;
	bh=IrSB7ZTcdacSg0eupJyaRjx+UzrmjEXbm0lg7sIzDbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7BxRe4xj569GhJ+IvkeH5sJ3aMSyBavkmKiK9OzpGeUJ5Ij6UpWHZ4midbmcUwCFWp6YboXl/vSppT4gLEAfztSpcwW6giRGiQIuPAm5f3/Tj7egcnYbuFqYcxhcoCB7LWPOWIITSajHnKAR4asm2zNbzjPdzkoKQFkSkjsfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ACFE19F0;
	Fri, 29 Aug 2025 04:53:10 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8498A3F694;
	Fri, 29 Aug 2025 04:53:16 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v7 6/6] arm64: mm: Optimize linear_map_split_to_ptes()
Date: Fri, 29 Aug 2025 12:52:47 +0100
Message-ID: <20250829115250.2395585-7-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829115250.2395585-1-ryan.roberts@arm.com>
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When splitting kernel leaf mappings, either via
split_kernel_leaf_mapping_locked() or linear_map_split_to_ptes(),
previously a leaf mapping was always split to the next size down. e.g.
pud -> contpmd -> pmd -> contpte -> pte. But for
linear_map_split_to_ptes() we can avoid the contpmd and contpte states
because we know we want to split all the way down to ptes.

This avoids visiting all the ptes in a table if it was created by
splitting a pmd, which is noticible on systems with a lot of memory.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/mmu.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6bd0b065bd97..8e45cd08bf3a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -550,7 +550,7 @@ static void split_contpte(pte_t *ptep)
 		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
 }
 
-static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
+static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
 {
 	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
 	unsigned long pfn = pmd_pfn(pmd);
@@ -568,7 +568,9 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
 		tableprot |= PMD_TABLE_PXN;
 
 	prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) | PTE_TYPE_PAGE);
-	prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+	prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
+	if (to_cont)
+		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
 		__set_pte(ptep, pfn_pte(pfn, prot));
@@ -592,7 +594,7 @@ static void split_contpmd(pmd_t *pmdp)
 		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
 }
 
-static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
+static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
 {
 	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
 	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
@@ -611,7 +613,9 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
 		tableprot |= PUD_TABLE_PXN;
 
 	prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
-	prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+	prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
+	if (to_cont)
+		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
 		set_pmd(pmdp, pfn_pmd(pfn, prot));
@@ -669,7 +673,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 	if (!pud_present(pud))
 		goto out;
 	if (pud_leaf(pud)) {
-		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL);
+		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
 		if (ret)
 			goto out;
 	}
@@ -694,7 +698,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 		 */
 		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
 			goto out;
-		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL);
+		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
 		if (ret)
 			goto out;
 	}
@@ -771,7 +775,7 @@ static int __init split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
 	int ret = 0;
 
 	if (pud_leaf(pud))
-		ret = split_pud(pudp, pud, GFP_ATOMIC);
+		ret = split_pud(pudp, pud, GFP_ATOMIC, false);
 
 	return ret;
 }
@@ -786,7 +790,13 @@ static int __init split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
 	if (pmd_leaf(pmd)) {
 		if (pmd_cont(pmd))
 			split_contpmd(pmdp);
-		ret = split_pmd(pmdp, pmd, GFP_ATOMIC);
+		ret = split_pmd(pmdp, pmd, GFP_ATOMIC, false);
+
+		/*
+		 * We have split the pmd directly to ptes so there is no need to
+		 * visit each pte to check if they are contpte.
+		 */
+		walk->action = ACTION_CONTINUE;
 	}
 
 	return ret;
-- 
2.43.0



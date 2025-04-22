Return-Path: <linux-kernel+bounces-613766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF24AA960DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 10:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB5E16D8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BC24C07F;
	Tue, 22 Apr 2025 08:18:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABD91EBA16
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309925; cv=none; b=ZLLx0/wNc912U0ZkoX4nP0IYEeAFtqfPD5TAMlXOWbVObeYFbaxoq3iQLWDqDIcIR2fxEm4lrdUA6SBXk+9gaKkL9cVPXExK4slDzehPFZHoVKjayXdJ5Chk81qL+1Pi5RZPlDzcsE4iVeuDGlO6pYaaWNoXz6qwNW7rwPFkO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309925; c=relaxed/simple;
	bh=E8D3cSLQeYoyZ/dgADsYWqeVLa+kpZ+5c5Oicqh2HQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNct7OUIDY9WFPeRjSbY+zqDPfVpvMCrhnf37WK76iEaiP5P40M8yemIvPfRDqcgK19D5yqYJoHOWe+fuUy/0TLmiztxeHCOQyqa9TsSagwGzIgqTZkmc4XTdkJhg6j0tRhin7DLdbI9gh9U0G6ifIDqOtOw5MbQpK/7aw/rqb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D9F176A;
	Tue, 22 Apr 2025 01:18:38 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F1B13F66E;
	Tue, 22 Apr 2025 01:18:41 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/11] arm64: hugetlb: Cleanup huge_pte size discovery mechanisms
Date: Tue, 22 Apr 2025 09:18:09 +0100
Message-ID: <20250422081822.1836315-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422081822.1836315-1-ryan.roberts@arm.com>
References: <20250422081822.1836315-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all huge_pte helper APIs explicitly provide the size of the
huge_pte. So the helpers have to depend on various methods to determine
the size of the huge_pte. Some of these methods are dubious.

Let's clean up the code to use preferred methods and retire the dubious
ones. The options in order of preference:

 - If size is provided as parameter, use it together with
   num_contig_ptes(). This is explicit and works for both present and
   non-present ptes.

 - If vma is provided as a parameter, retrieve size via
   huge_page_size(hstate_vma(vma)) and use it together with
   num_contig_ptes(). This is explicit and works for both present and
   non-present ptes.

 - If the pte is present and contiguous, use find_num_contig() to walk
   the pgtable to find the level and infer the number of ptes from
   level. Only works for *present* ptes.

 - If the pte is present and not contiguous and you can infer from this
   that only 1 pte needs to be operated on. This is ok if you don't care
   about the absolute size, and just want to know the number of ptes.

 - NEVER rely on resolving the PFN of a present pte to a folio and
   getting the folio's size. This is fragile at best, because there is
   nothing to stop the core-mm from allocating a folio twice as big as
   the huge_pte then mapping it across 2 consecutive huge_ptes. Or just
   partially mapping it.

Where we require that the pte is present, add warnings if not-present.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index cfe8cb8ba1cc..701394aa7734 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -129,7 +129,7 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
 		return orig_pte;
 
-	ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
+	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 	for (i = 0; i < ncontig; i++, ptep++) {
 		pte_t pte = __ptep_get(ptep);
 
@@ -438,16 +438,19 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	pgprot_t hugeprot;
 	pte_t orig_pte;
 
+	VM_WARN_ON(!pte_present(pte));
+
 	if (!pte_cont(pte))
 		return __ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
+	ncontig = num_contig_ptes(huge_page_size(hstate_vma(vma)), &pgsize);
 	dpfn = pgsize >> PAGE_SHIFT;
 
 	if (!__cont_access_flags_changed(ptep, pte, ncontig))
 		return 0;
 
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
+	VM_WARN_ON(!pte_present(orig_pte));
 
 	/* Make sure we don't lose the dirty or young state */
 	if (pte_dirty(orig_pte))
@@ -472,7 +475,10 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	size_t pgsize;
 	pte_t pte;
 
-	if (!pte_cont(__ptep_get(ptep))) {
+	pte = __ptep_get(ptep);
+	VM_WARN_ON(!pte_present(pte));
+
+	if (!pte_cont(pte)) {
 		__ptep_set_wrprotect(mm, addr, ptep);
 		return;
 	}
@@ -496,11 +502,15 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	size_t pgsize;
 	int ncontig;
+	pte_t pte;
+
+	pte = __ptep_get(ptep);
+	VM_WARN_ON(!pte_present(pte));
 
-	if (!pte_cont(__ptep_get(ptep)))
+	if (!pte_cont(pte))
 		return ptep_clear_flush(vma, addr, ptep);
 
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
+	ncontig = num_contig_ptes(huge_page_size(hstate_vma(vma)), &pgsize);
 	return get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
 }
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-736570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFE9B09E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4C71C476B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43072957AC;
	Fri, 18 Jul 2025 09:03:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7A32951C9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829434; cv=none; b=jLJixGwEhYsTuTKWv+Av1WWfJyy8LPGxcAjjMjcO35d+z44O25BU+4uuoZABi/OF/LD7S3vkYN+qYGoQrcOU1Fv4U3ewOTAzIHkjy+4aEkY7AW3f8hpFf8jcMsnIpXao21BAu+Beb0pRAsoygZtB5pSBgYx0ol6JwJEu/WBQLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829434; c=relaxed/simple;
	bh=D6v2UBGvzI8pa3KQ9JeB2IONHW+6Rt1+5t4VQP6N09Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YpW8IB6RkN895xtkrnXOe1Fg7HKKCsXVfk/iN/V6rwDFt5VNrtguO7YCDABLjkMctnXig/VvGNrC6Ud3h184c2o5rQpWhIMIfVHpOmAMKwBcKhEByZR20IBXfMFeF2Y8qVcSdsOFSOtOU/nIkjF3Mt2vfKUCaGTjStJZ3TCV0Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B42C71A32;
	Fri, 18 Jul 2025 02:03:44 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0853C3F66E;
	Fri, 18 Jul 2025 02:03:43 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	anshuman.khandual@arm.com,
	peterx@redhat.com,
	joey.gouly@arm.com,
	ioworker0@gmail.com,
	baohua@kernel.org,
	kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com,
	christophe.leroy@csgroup.eu,
	yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	hughd@google.com,
	yang@os.amperecomputing.com,
	ziy@nvidia.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
Date: Fri, 18 Jul 2025 14:32:43 +0530
Message-Id: <20250718090244.21092-7-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718090244.21092-1-dev.jain@arm.com>
References: <20250718090244.21092-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use folio_pte_batch to batch process a large folio. Note that, PTE
batching here will save a few function calls, and this strategy in certain
cases (not this one) batches atomic operations in general, so we have
a performance win for all arches. This patch paves the way for patch 7
which will help us elide the TLBI per contig block on arm64.

The correctness of this patch lies on the correctness of setting the
new ptes based upon information only from the first pte of the batch
(which may also have accumulated a/d bits via modify_prot_start_ptes()).

Observe that the flag combination we pass to mprotect_folio_pte_batch()
guarantees that the batch is uniform w.r.t the soft-dirty bit and the
writable bit. Therefore, the only bits which may differ are the a/d bits.
So we only need to worry about code which is concerned about the a/d bits
of the PTEs.

Setting extra a/d bits on the new ptes where previously they were not set,
is fine - setting access bit when it was not set is not an incorrectness
problem but will only possibly delay the reclaim of the page mapped by
the pte (which is in fact intended because the kernel just operated on this
region via mprotect()!). Setting dirty bit when it was not set is again
not an incorrectness problem but will only possibly force an unnecessary
writeback.

So now we need to reason whether something can go wrong via
can_change_pte_writable(). The pte_protnone, pte_needs_soft_dirty_wp,
and userfaultfd_pte_wp cases are solved due to uniformity in the
corresponding bits guaranteed by the flag combination. The ptes all
belong to the same VMA (since callers guarantee that [start, end) will
lie within the VMA) therefore the conditional based on the VMA is also
safe to batch around.

Since the dirty bit on the PTE really is just an indication that the folio
got written to - even if the PTE is not actually dirty but one of the PTEs
in the batch is, the wp-fault optimization can be made. Therefore, it is
safe to batch around pte_dirty() in can_change_shared_pte_writable()
(in fact this is better since without batching, it may happen that
some ptes aren't changed to writable just because they are not dirty,
even though the other ptes mapping the same large folio are dirty).

To batch around the PageAnonExclusive case, we must check the corresponding
condition for every single page. Therefore, from the large folio batch,
we process sub batches of ptes mapping pages with the same
PageAnonExclusive condition, and process that sub batch, then determine
and process the next sub batch, and so on. Note that this does not cause
any extra overhead; if suppose the size of the folio batch is 512, then
the sub batch processing in total will take 512 iterations, which is the
same as what we would have done before.

For pte_needs_flush():

ppc does not care about the a/d bits.

For x86, PAGE_SAVED_DIRTY is ignored. We will flush only when a/d bits
get cleared; since we can only have extra a/d bits due to batching,
we will only have an extra flush, not a case where we elide a flush due
to batching when we shouldn't have.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/mprotect.c | 125 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 113 insertions(+), 12 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index a1c7d8a4648d..2ddd37b2f462 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -106,7 +106,7 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 }
 
 static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
-				    pte_t pte, int max_nr_ptes)
+				    pte_t pte, int max_nr_ptes, fpb_t flags)
 {
 	/* No underlying folio, so cannot batch */
 	if (!folio)
@@ -115,7 +115,7 @@ static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
 	if (!folio_test_large(folio))
 		return 1;
 
-	return folio_pte_batch(folio, ptep, pte, max_nr_ptes);
+	return folio_pte_batch_flags(folio, NULL, ptep, &pte, max_nr_ptes, flags);
 }
 
 static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
@@ -177,6 +177,102 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
 	return ret;
 }
 
+/* Set nr_ptes number of ptes, starting from idx */
+static void prot_commit_flush_ptes(struct vm_area_struct *vma, unsigned long addr,
+		pte_t *ptep, pte_t oldpte, pte_t ptent, int nr_ptes,
+		int idx, bool set_write, struct mmu_gather *tlb)
+{
+	/*
+	 * Advance the position in the batch by idx; note that if idx > 0,
+	 * then the nr_ptes passed here is <= batch size - idx.
+	 */
+	addr += idx * PAGE_SIZE;
+	ptep += idx;
+	oldpte = pte_advance_pfn(oldpte, idx);
+	ptent = pte_advance_pfn(ptent, idx);
+
+	if (set_write)
+		ptent = pte_mkwrite(ptent, vma);
+
+	modify_prot_commit_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes);
+	if (pte_needs_flush(oldpte, ptent))
+		tlb_flush_pte_range(tlb, addr, nr_ptes * PAGE_SIZE);
+}
+
+/*
+ * Get max length of consecutive ptes pointing to PageAnonExclusive() pages or
+ * !PageAnonExclusive() pages, starting from start_idx. Caller must enforce
+ * that the ptes point to consecutive pages of the same anon large folio.
+ */
+static int page_anon_exclusive_sub_batch(int start_idx, int max_len,
+		struct page *first_page, bool expected_anon_exclusive)
+{
+	int idx;
+
+	for (idx = start_idx + 1; idx < start_idx + max_len; ++idx) {
+		if (expected_anon_exclusive != PageAnonExclusive(first_page + idx))
+			break;
+	}
+	return idx - start_idx;
+}
+
+/*
+ * This function is a result of trying our very best to retain the
+ * "avoid the write-fault handler" optimization. In can_change_pte_writable(),
+ * if the vma is a private vma, and we cannot determine whether to change
+ * the pte to writable just from the vma and the pte, we then need to look
+ * at the actual page pointed to by the pte. Unfortunately, if we have a
+ * batch of ptes pointing to consecutive pages of the same anon large folio,
+ * the anon-exclusivity (or the negation) of the first page does not guarantee
+ * the anon-exclusivity (or the negation) of the other pages corresponding to
+ * the pte batch; hence in this case it is incorrect to decide to change or
+ * not change the ptes to writable just by using information from the first
+ * pte of the batch. Therefore, we must individually check all pages and
+ * retrieve sub-batches.
+ */
+static void commit_anon_folio_batch(struct vm_area_struct *vma,
+		struct folio *folio, unsigned long addr, pte_t *ptep,
+		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
+{
+	struct page *first_page = folio_page(folio, 0);
+	bool expected_anon_exclusive;
+	int sub_batch_idx = 0;
+	int len;
+
+	while (nr_ptes) {
+		expected_anon_exclusive = PageAnonExclusive(first_page + sub_batch_idx);
+		len = page_anon_exclusive_sub_batch(sub_batch_idx, nr_ptes,
+					first_page, expected_anon_exclusive);
+		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, len,
+				       sub_batch_idx, expected_anon_exclusive, tlb);
+		sub_batch_idx += len;
+		nr_ptes -= len;
+	}
+}
+
+static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
+		struct folio *folio, unsigned long addr, pte_t *ptep,
+		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
+{
+	bool set_write;
+
+	if (vma->vm_flags & VM_SHARED) {
+		set_write = can_change_shared_pte_writable(vma, ptent);
+		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
+				       /* idx = */ 0, set_write, tlb);
+		return;
+	}
+
+	set_write = maybe_change_pte_writable(vma, ptent) &&
+		    (folio && folio_test_anon(folio));
+	if (!set_write) {
+		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
+				       /* idx = */ 0, set_write, tlb);
+		return;
+	}
+	commit_anon_folio_batch(vma, folio, addr, ptep, oldpte, ptent, nr_ptes, tlb);
+}
+
 static long change_pte_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
@@ -206,8 +302,9 @@ static long change_pte_range(struct mmu_gather *tlb,
 		nr_ptes = 1;
 		oldpte = ptep_get(pte);
 		if (pte_present(oldpte)) {
+			const fpb_t flags = FPB_RESPECT_SOFT_DIRTY | FPB_RESPECT_WRITE;
 			int max_nr_ptes = (end - addr) >> PAGE_SHIFT;
-			struct folio *folio;
+			struct folio *folio = NULL;
 			pte_t ptent;
 
 			/*
@@ -221,11 +318,16 @@ static long change_pte_range(struct mmu_gather *tlb,
 
 					/* determine batch to skip */
 					nr_ptes = mprotect_folio_pte_batch(folio,
-						  pte, oldpte, max_nr_ptes);
+						  pte, oldpte, max_nr_ptes, /* flags = */ 0);
 					continue;
 				}
 			}
 
+			if (!folio)
+				folio = vm_normal_folio(vma, addr, oldpte);
+
+			nr_ptes = mprotect_folio_pte_batch(folio, pte, oldpte, max_nr_ptes, flags);
+
 			oldpte = modify_prot_start_ptes(vma, addr, pte, nr_ptes);
 			ptent = pte_modify(oldpte, newprot);
 
@@ -248,14 +350,13 @@ static long change_pte_range(struct mmu_gather *tlb,
 			 * COW or special handling is required.
 			 */
 			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
-			    !pte_write(ptent) &&
-			    can_change_pte_writable(vma, addr, ptent))
-				ptent = pte_mkwrite(ptent, vma);
-
-			modify_prot_commit_ptes(vma, addr, pte, oldpte, ptent, nr_ptes);
-			if (pte_needs_flush(oldpte, ptent))
-				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
-			pages++;
+			     !pte_write(ptent))
+				set_write_prot_commit_flush_ptes(vma, folio,
+				addr, pte, oldpte, ptent, nr_ptes, tlb);
+			else
+				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
+					nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);
+			pages += nr_ptes;
 		} else if (is_swap_pte(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
 			pte_t newpte;
-- 
2.30.2



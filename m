Return-Path: <linux-kernel+bounces-871757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB1FC0E443
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F0F44FB9D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D47307AC4;
	Mon, 27 Oct 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HNX4wW2n"
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85002797B5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573780; cv=none; b=NWfUzDMYd50xuGsrCwJi6LOfF7RIr3dmrBuW3yXiscHubMQsdOAnNkgRNdLLx8ARRR5ZEGmW6AIFAiRs0rMaWv3flr92+M8NjoXERc3LdcEGRGdmxAyHQJRnRj06fFyh3WPnbCjhAtIUbXEDtCl1Z8GtdF4i/bFo7cKG0DGsZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573780; c=relaxed/simple;
	bh=RuoU9NHI0Lc/hu9JvWBE164HheGR5QGXYctzMG1DgVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUGfe+QkoGBVouj2Hx9QmyjJLTPbZMMcuqr1ZbiaOLWTL2Z5ricfJmNF0to7tsh9w+Czg/KgiYwTLsmk35d4DBH7E+6d8ygoIssEGQIdx2Ls5bbwRhbo6HpXn7N0DLFghN3yVhH27j0uKJyz9VDxOQnupUblK+1mBvwoCNWYGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HNX4wW2n; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0wHX/jcFSsUS6b4WnCUTKJ0MhfSl8GdycqH5o0g1oq8=;
	b=HNX4wW2nCkvKdY3yB8QgsKRNFSRNFWV24QPTSH0Vs1EnYBwDkezmFOzbIk9O/vBEpONuwlV2Z
	HD1XCXxxJMTvvKTZ/YnqU2s/bs9rxHETVqavCtSzjEpxpGPxb3yrPjjuzwTeF5hO+MWbAcEtWlb
	M0xM0VA7YvydlVV9ABhhvkk=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cwFZB44BPzKm4k;
	Mon, 27 Oct 2025 22:02:26 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 3954F1800B2;
	Mon, 27 Oct 2025 22:02:54 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 27 Oct
 2025 22:02:53 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<jannh@google.com>, <pfalcato@suse.de>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [RFC PATCH 1/3] mm: Introduce can_pte_batch_count() for PTEs batch optimization.
Date: Mon, 27 Oct 2025 22:03:13 +0800
Message-ID: <20251027140315.907864-2-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027140315.907864-1-zhangqilong3@huawei.com>
References: <20251027140315.907864-1-zhangqilong3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500012.china.huawei.com (7.185.36.8)

Currently, the PTEs batch requires folio access, with the maximum
quantity limited to the PFNs contained within the folio. However,
in certain case (such as mremap_folio_pte_batch and mincore_pte_range),
accessing the folio is unnecessary and expensive.

For scenarios that do not require folio access, this patch introduces
can_pte_batch_count(). With contiguous physical addresses and identical
PTE attribut bits, we can now process more page table entries at once,
in batch, not just limited to entries mapped within a single folio. On
the other hand, it avoid the folio access.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 mm/internal.h | 76 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1561fc2ff5b8..92034ca9092d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -233,61 +233,62 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
 		pte = pte_wrprotect(pte);
 	return pte_mkold(pte);
 }
 
 /**
- * folio_pte_batch_flags - detect a PTE batch for a large folio
- * @folio: The large folio to detect a PTE batch for.
+ * can_pte_batch_count - detect a PTE batch in range [ptep, to ptep + max_nr)
  * @vma: The VMA. Only relevant with FPB_MERGE_WRITE, otherwise can be NULL.
  * @ptep: Page table pointer for the first entry.
  * @ptentp: Pointer to a COPY of the first page table entry whose flags this
  *	    function updates based on @flags if appropriate.
  * @max_nr: The maximum number of table entries to consider.
  * @flags: Flags to modify the PTE batch semantics.
  *
- * Detect a PTE batch: consecutive (present) PTEs that map consecutive
- * pages of the same large folio in a single VMA and a single page table.
+ * This interface is designed for this case that do not require folio access.
+ * If folio consideration is needed, please call folio_pte_batch_flags instead.
+ *
+ * Detect a PTE batch: consecutive (present) PTEs that map consecutive pages
+ * in a single VMA and a single page table.
  *
  * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
  * the accessed bit, writable bit, dirty bit (unless FPB_RESPECT_DIRTY is set)
  * and soft-dirty bit (unless FPB_RESPECT_SOFT_DIRTY is set).
  *
- * @ptep must map any page of the folio. max_nr must be at least one and
+ * @ptep point to the first entry in range, max_nr must be at least one and
  * must be limited by the caller so scanning cannot exceed a single VMA and
  * a single page table.
  *
  * Depending on the FPB_MERGE_* flags, the pte stored at @ptentp will
  * be updated: it's crucial that a pointer to a COPY of the first
  * page table entry, obtained through ptep_get(), is provided as @ptentp.
  *
- * This function will be inlined to optimize based on the input parameters;
- * consider using folio_pte_batch() instead if applicable.
+ * The following folio_pte_batch_flags() deal with PTEs that mapped in a
+ * single folio. However can_pte_batch_count has the capability to handle
+ * PTEs that mapped in consecutive folios. If flags is not set, it will ignore
+ * the accessed, writable and dirty bits. Once the flags is set, the respect
+ * bit(s) will be compared in pte_same(), if the advanced pte_batch_hint()
+ * respect pte bit is different, pte_same() will return false and break. This
+ * ensures the correctness of handling multiple folio PTEs.
+ *
+ * This function will be inlined to optimize based on the input parameters.
  *
  * Return: the number of table entries in the batch.
  */
-static inline unsigned int folio_pte_batch_flags(struct folio *folio,
-		struct vm_area_struct *vma, pte_t *ptep, pte_t *ptentp,
-		unsigned int max_nr, fpb_t flags)
+static inline unsigned int can_pte_batch_count(struct vm_area_struct *vma,
+		pte_t *ptep, pte_t *ptentp, unsigned int max_nr, fpb_t flags)
 {
 	bool any_writable = false, any_young = false, any_dirty = false;
 	pte_t expected_pte, pte = *ptentp;
 	unsigned int nr, cur_nr;
 
-	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
-	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
-	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
+	VM_WARN_ON(!pte_present(pte));
 	/*
 	 * Ensure this is a pointer to a copy not a pointer into a page table.
 	 * If this is a stack value, it won't be a valid virtual address, but
 	 * that's fine because it also cannot be pointing into the page table.
 	 */
 	VM_WARN_ON(virt_addr_valid(ptentp) && PageTable(virt_to_page(ptentp)));
-
-	/* Limit max_nr to the actual remaining PFNs in the folio we could batch. */
-	max_nr = min_t(unsigned long, max_nr,
-		       folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte));
-
 	nr = pte_batch_hint(ptep, pte);
 	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
 	ptep = ptep + nr;
 
 	while (nr < max_nr) {
@@ -317,10 +318,49 @@ static inline unsigned int folio_pte_batch_flags(struct folio *folio,
 		*ptentp = pte_mkdirty(*ptentp);
 
 	return min(nr, max_nr);
 }
 
+/**
+ * folio_pte_batch_flags - detect a PTE batch for a large folio
+ * @folio: The large folio to detect a PTE batch for.
+ * @vma: The VMA. Only relevant with FPB_MERGE_WRITE, otherwise can be NULL.
+ * @ptep: Page table pointer for the first entry.
+ * @ptentp: Pointer to a COPY of the first page table entry whose flags this
+ *         function updates based on @flags if appropriate.
+ * @max_nr: The maximum number of table entries to consider.
+ * @flags: Flags to modify the PTE batch semantics.
+ *
+ * Detect a PTE batch: consecutive (present) PTEs that map consecutive
+ * pages of the same large folio and have the same PTE bits set excluding the
+ * PFN, the accessed bit, writable bit, dirty bit. (unless FPB_RESPECT_DIRTY
+ * is set) and soft-dirty bit (unless FPB_RESPECT_SOFT_DIRTY is set).
+ *
+ * @ptep must map any page of the folio.
+ *
+ * This function will be inlined to optimize based on the input parameters;
+ * consider using folio_pte_batch() instead if applicable.
+ *
+ * Return: the number of table entries in the batch.
+ */
+static inline unsigned int folio_pte_batch_flags(struct folio *folio,
+		struct vm_area_struct *vma, pte_t *ptep, pte_t *ptentp,
+		unsigned int max_nr, fpb_t flags)
+{
+	pte_t pte = *ptentp;
+
+	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
+	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
+	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
+
+	/* Limit max_nr to the actual remaining PFNs in the folio we could batch. */
+	max_nr = min_t(unsigned long, max_nr,
+		       folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte));
+
+	return can_pte_batch_count(vma, ptep, ptentp, max_nr, flags);
+}
+
 unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
 		unsigned int max_nr);
 
 /**
  * pte_move_swp_offset - Move the swap entry offset field of a swap pte
-- 
2.43.0



Return-Path: <linux-kernel+bounces-736567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF0B09E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95AA16A461
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75DA295D95;
	Fri, 18 Jul 2025 09:03:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB288220F30
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829408; cv=none; b=erPj7wTtFLpOLemIanzThTxgJ2rCmK2mTgBXcK/75CfgcEu+irnDqlOfZi49JVDe7FES/bhdi4L7WN+IwcaAlGnxd717kuZk+Ld9LkXBEbm+0kGo694E/MR6GJEO5/IfuuYq9uqOkDu41Ovznbw5scGXngkVgc26Edfselx/PBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829408; c=relaxed/simple;
	bh=aUkDKKNXtSqOHP0pGZ4lu6Uz8r/p5f3PIthySzrM0RA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0wpUd2bcyJG8gQAC4O7ZGqoqQ4+LXXbjgDw3zx1iBal5UcpYjO2qhEXi9McHsQczOh4rlU1g6TKz9T2qQca+5h3/AoUqNttgAzyF+p3wN0FVEBsL74zre0KHRJgmXszW5ZkJytMNBsUX53UbNd2ScBOEUBBkjFCi9daRzqdJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF8B176C;
	Fri, 18 Jul 2025 02:03:18 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 094223F66E;
	Fri, 18 Jul 2025 02:03:17 -0700 (PDT)
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
Subject: [PATCH v5 3/7] mm: Add batched versions of ptep_modify_prot_start/commit
Date: Fri, 18 Jul 2025 14:32:40 +0530
Message-Id: <20250718090244.21092-4-dev.jain@arm.com>
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

Batch ptep_modify_prot_start/commit in preparation for optimizing mprotect,
implementing them as a simple loop over the corresponding single pte
helpers. Architecture may override these helpers.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 include/linux/pgtable.h | 84 ++++++++++++++++++++++++++++++++++++++++-
 mm/mprotect.c           |  4 +-
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index cf1515c163e2..e3b99920be05 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1331,7 +1331,9 @@ static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
 
 /*
  * Commit an update to a pte, leaving any hardware-controlled bits in
- * the PTE unmodified.
+ * the PTE unmodified. The pte returned from ptep_modify_prot_start() may
+ * additionally have young and/or dirty bits set where previously they were not,
+ * so the updated pte may have these additional changes.
  */
 static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 					   unsigned long addr,
@@ -1340,6 +1342,86 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 	__ptep_modify_prot_commit(vma, addr, ptep, pte);
 }
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
+
+/**
+ * modify_prot_start_ptes - Start a pte protection read-modify-write transaction
+ * over a batch of ptes, which protects against asynchronous hardware
+ * modifications to the ptes. The intention is not to prevent the hardware from
+ * making pte updates, but to prevent any updates it may make from being lost.
+ * Please see the comment above ptep_modify_prot_start() for full description.
+ *
+ * @vma: The virtual memory area the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries.
+ *
+ * May be overridden by the architecture; otherwise, implemented as a simple
+ * loop over ptep_modify_prot_start(), collecting the a/d bits from each pte
+ * in the batch.
+ *
+ * Note that PTE bits in the PTE batch besides the PFN can differ.
+ *
+ * Context: The caller holds the page table lock.  The PTEs map consecutive
+ * pages that belong to the same folio. All other PTE bits must be identical for
+ * all PTEs in the batch except for young and dirty bits.  The PTEs are all in
+ * the same PMD.
+ */
+#ifndef modify_prot_start_ptes
+static inline pte_t modify_prot_start_ptes(struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep, unsigned int nr)
+{
+	pte_t pte, tmp_pte;
+
+	pte = ptep_modify_prot_start(vma, addr, ptep);
+	while (--nr) {
+		ptep++;
+		addr += PAGE_SIZE;
+		tmp_pte = ptep_modify_prot_start(vma, addr, ptep);
+		if (pte_dirty(tmp_pte))
+			pte = pte_mkdirty(pte);
+		if (pte_young(tmp_pte))
+			pte = pte_mkyoung(pte);
+	}
+	return pte;
+}
+#endif
+
+/**
+ * modify_prot_commit_ptes - Commit an update to a batch of ptes, leaving any
+ * hardware-controlled bits in the PTE unmodified.
+ *
+ * @vma: The virtual memory area the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @old_pte: Old page table entry (for the first entry) which is now cleared.
+ * @pte: New page table entry to be set.
+ * @nr: Number of entries.
+ *
+ * May be overridden by the architecture; otherwise, implemented as a simple
+ * loop over ptep_modify_prot_commit().
+ *
+ * Context: The caller holds the page table lock. The PTEs are all in the same
+ * PMD. On exit, the set ptes in the batch map the same folio. The ptes set by
+ * ptep_modify_prot_start() may additionally have young and/or dirty bits set
+ * where previously they were not, so the updated ptes may have these
+ * additional changes.
+ */
+#ifndef modify_prot_commit_ptes
+static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned long addr,
+		pte_t *ptep, pte_t old_pte, pte_t pte, unsigned int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; ++i, ++ptep, addr += PAGE_SIZE) {
+		ptep_modify_prot_commit(vma, addr, ptep, old_pte, pte);
+
+		/* Advance PFN only, set same prot */
+		old_pte = pte_next_pfn(old_pte);
+		pte = pte_next_pfn(pte);
+	}
+}
+#endif
+
 #endif /* CONFIG_MMU */
 
 /*
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 97adc62c50ab..4977f198168e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -204,7 +204,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 				}
 			}
 
-			oldpte = ptep_modify_prot_start(vma, addr, pte);
+			oldpte = modify_prot_start_ptes(vma, addr, pte, nr_ptes);
 			ptent = pte_modify(oldpte, newprot);
 
 			if (uffd_wp)
@@ -230,7 +230,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 			    can_change_pte_writable(vma, addr, ptent))
 				ptent = pte_mkwrite(ptent, vma);
 
-			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
+			modify_prot_commit_ptes(vma, addr, pte, oldpte, ptent, nr_ptes);
 			if (pte_needs_flush(oldpte, ptent))
 				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
 			pages++;
-- 
2.30.2



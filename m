Return-Path: <linux-kernel+bounces-791703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DE4B3BA4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949A9A20C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E331A04C;
	Fri, 29 Aug 2025 11:53:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB76C31577A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468390; cv=none; b=Q5kCGHkhMyr6J6b7JSgAZFIYRpxjYanca8182heUKOkpudt3+YMK+jtOrxEeExIK9fPGysnM/MKzSdeV61TY9uJg9342NI3dphV05hb3D/1Y1/sVUbZtt7GJMPPRBnrYNLtYClffnNA+rIemqxHBZoIkQhk5Cbh0NhYgKtG1mkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468390; c=relaxed/simple;
	bh=NnDuLgS3NywngyAXngyd1ZqozwEDAGkMaukBpNBiHi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOZvAfQFcntaPE+nPcGumdpn7yy8h9N/O2R5g5GrxV0jw3lkuTOLLSOSKnqE71E3kjAkhiFP8oZ9BjbhDYpikuJyPev+Xa0lQBQaZ2qkVKFagSr1Tu4oCZoDcyHcyeWO3ml8RQ6ZBmvpSjUIK7J3g0QM2V6Twcyf2OsQgvVqr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B50151BCB;
	Fri, 29 Aug 2025 04:52:58 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFE013F694;
	Fri, 29 Aug 2025 04:53:04 -0700 (PDT)
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
Subject: [PATCH v7 1/6] arm64: Enable permission change on arm64 kernel block mappings
Date: Fri, 29 Aug 2025 12:52:42 +0100
Message-ID: <20250829115250.2395585-2-ryan.roberts@arm.com>
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

From: Dev Jain <dev.jain@arm.com>

This patch paves the path to enable huge mappings in vmalloc space and
linear map space by default on arm64. For this we must ensure that we
can handle any permission games on the kernel (init_mm) pagetable.
Previously, __change_memory_common() used apply_to_page_range() which
does not support changing permissions for block mappings. We move away
from this by using the pagewalk API, similar to what riscv does right
now. It is the responsibility of the caller to ensure that the range
over which permissions are being changed falls on leaf mapping
boundaries. For systems with BBML2, this will be handled in future
patches by dyanmically splitting the mappings when required.

Unlike apply_to_page_range(), the pagewalk API currently enforces the
init_mm.mmap_lock to be held. To avoid the unnecessary bottleneck of the
mmap_lock for our usecase, this patch extends this generic API to be
used locklessly, so as to retain the existing behaviour for changing
permissions. Apart from this reason, it is noted at [1] that KFENCE can
manipulate kernel pgtable entries during softirqs. It does this by
calling set_memory_valid() -> __change_memory_common(). This being a
non-sleepable context, we cannot take the init_mm mmap lock.

Add comments to highlight the conditions under which we can use the
lockless variant - no underlying VMA, and the user having exclusive
control over the range, thus guaranteeing no concurrent access.

We require that the start and end of a given range do not partially
overlap block mappings, or cont mappings. Return -EINVAL in case a
partial block mapping is detected in any of the PGD/P4D/PUD/PMD levels;
add a corresponding comment in update_range_prot() to warn that
eliminating such a condition is the responsibility of the caller.

Note that, the pte level callback may change permissions for a whole
contpte block, and that will be done one pte at a time, as opposed to an
atomic operation for the block mappings. This is fine as any access will
decode either the old or the new permission until the TLBI.

apply_to_page_range() currently performs all pte level callbacks while
in lazy mmu mode. Since arm64 can optimize performance by batching
barriers when modifying kernel pgtables in lazy mmu mode, we would like
to continue to benefit from this optimisation. Unfortunately
walk_kernel_page_table_range() does not use lazy mmu mode. However,
since the pagewalk framework is not allocating any memory, we can safely
bracket the whole operation inside lazy mmu mode ourselves. Therefore,
wrap the call to walk_kernel_page_table_range() with the lazy MMU
helpers.

Link: https://lore.kernel.org/linux-arm-kernel/89d0ad18-4772-4d8f-ae8a-7c48d26a927e@arm.com/ [1]
Signed-off-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/pageattr.c | 153 +++++++++++++++++++++++++++++++--------
 include/linux/pagewalk.h |   3 +
 mm/pagewalk.c            |  36 ++++++---
 3 files changed, 149 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 04d4a8f676db..6da8cbc32f46 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -8,6 +8,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
+#include <linux/pagewalk.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable-prot.h>
@@ -20,6 +21,99 @@ struct page_change_data {
 	pgprot_t clear_mask;
 };
 
+static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
+{
+	struct page_change_data *masks = walk->private;
+
+	val &= ~(pgprot_val(masks->clear_mask));
+	val |= (pgprot_val(masks->set_mask));
+
+	return val;
+}
+
+static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pgd_t val = pgdp_get(pgd);
+
+	if (pgd_leaf(val)) {
+		if (WARN_ON_ONCE((next - addr) != PGDIR_SIZE))
+			return -EINVAL;
+		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
+		set_pgd(pgd, val);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	p4d_t val = p4dp_get(p4d);
+
+	if (p4d_leaf(val)) {
+		if (WARN_ON_ONCE((next - addr) != P4D_SIZE))
+			return -EINVAL;
+		val = __p4d(set_pageattr_masks(p4d_val(val), walk));
+		set_p4d(p4d, val);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pud_t val = pudp_get(pud);
+
+	if (pud_leaf(val)) {
+		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
+			return -EINVAL;
+		val = __pud(set_pageattr_masks(pud_val(val), walk));
+		set_pud(pud, val);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pmd_t val = pmdp_get(pmd);
+
+	if (pmd_leaf(val)) {
+		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
+			return -EINVAL;
+		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
+		set_pmd(pmd, val);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pte_t val = __ptep_get(pte);
+
+	val = __pte(set_pageattr_masks(pte_val(val), walk));
+	__set_pte(pte, val);
+
+	return 0;
+}
+
+static const struct mm_walk_ops pageattr_ops = {
+	.pgd_entry	= pageattr_pgd_entry,
+	.p4d_entry	= pageattr_p4d_entry,
+	.pud_entry	= pageattr_pud_entry,
+	.pmd_entry	= pageattr_pmd_entry,
+	.pte_entry	= pageattr_pte_entry,
+};
+
 bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
 
 bool can_set_direct_map(void)
@@ -37,32 +131,35 @@ bool can_set_direct_map(void)
 		arm64_kfence_can_set_direct_map() || is_realm_world();
 }
 
-static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
+static int update_range_prot(unsigned long start, unsigned long size,
+			     pgprot_t set_mask, pgprot_t clear_mask)
 {
-	struct page_change_data *cdata = data;
-	pte_t pte = __ptep_get(ptep);
+	struct page_change_data data;
+	int ret;
 
-	pte = clear_pte_bit(pte, cdata->clear_mask);
-	pte = set_pte_bit(pte, cdata->set_mask);
+	data.set_mask = set_mask;
+	data.clear_mask = clear_mask;
 
-	__set_pte(ptep, pte);
-	return 0;
+	arch_enter_lazy_mmu_mode();
+
+	/*
+	 * The caller must ensure that the range we are operating on does not
+	 * partially overlap a block mapping, or a cont mapping. Any such case
+	 * must be eliminated by splitting the mapping.
+	 */
+	ret = walk_kernel_page_table_range_lockless(start, start + size,
+						    &pageattr_ops, NULL, &data);
+	arch_leave_lazy_mmu_mode();
+
+	return ret;
 }
 
-/*
- * This function assumes that the range is mapped with PAGE_SIZE pages.
- */
 static int __change_memory_common(unsigned long start, unsigned long size,
-				pgprot_t set_mask, pgprot_t clear_mask)
+				  pgprot_t set_mask, pgprot_t clear_mask)
 {
-	struct page_change_data data;
 	int ret;
 
-	data.set_mask = set_mask;
-	data.clear_mask = clear_mask;
-
-	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
-					&data);
+	ret = update_range_prot(start, size, set_mask, clear_mask);
 
 	/*
 	 * If the memory is being made valid without changing any other bits
@@ -174,32 +271,26 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
-	struct page_change_data data = {
-		.set_mask = __pgprot(0),
-		.clear_mask = __pgprot(PTE_VALID),
-	};
+	pgprot_t clear_mask = __pgprot(PTE_VALID);
+	pgprot_t set_mask = __pgprot(0);
 
 	if (!can_set_direct_map())
 		return 0;
 
-	return apply_to_page_range(&init_mm,
-				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+	return update_range_prot((unsigned long)page_address(page),
+				 PAGE_SIZE, set_mask, clear_mask);
 }
 
 int set_direct_map_default_noflush(struct page *page)
 {
-	struct page_change_data data = {
-		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
-		.clear_mask = __pgprot(PTE_RDONLY),
-	};
+	pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
+	pgprot_t clear_mask = __pgprot(PTE_RDONLY);
 
 	if (!can_set_direct_map())
 		return 0;
 
-	return apply_to_page_range(&init_mm,
-				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+	return update_range_prot((unsigned long)page_address(page),
+				 PAGE_SIZE, set_mask, clear_mask);
 }
 
 static int __set_memory_enc_dec(unsigned long addr,
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 682472c15495..88e18615dd72 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -134,6 +134,9 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 int walk_kernel_page_table_range(unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		pgd_t *pgd, void *private);
+int walk_kernel_page_table_range_lockless(unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		pgd_t *pgd, void *private);
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
 			void *private);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 648038247a8d..936689d8bcac 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -606,10 +606,32 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 int walk_kernel_page_table_range(unsigned long start, unsigned long end,
 		const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
 {
-	struct mm_struct *mm = &init_mm;
+	/*
+	 * Kernel intermediate page tables are usually not freed, so the mmap
+	 * read lock is sufficient. But there are some exceptions.
+	 * E.g. memory hot-remove. In which case, the mmap lock is insufficient
+	 * to prevent the intermediate kernel pages tables belonging to the
+	 * specified address range from being freed. The caller should take
+	 * other actions to prevent this race.
+	 */
+	mmap_assert_locked(&init_mm);
+
+	return walk_kernel_page_table_range_lockless(start, end, ops, pgd,
+						     private);
+}
+
+/*
+ * Use this function to walk the kernel page tables locklessly. It should be
+ * guaranteed that the caller has exclusive access over the range they are
+ * operating on - that there should be no concurrent access, for example,
+ * changing permissions for vmalloc objects.
+ */
+int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end,
+		const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
+{
 	struct mm_walk walk = {
 		.ops		= ops,
-		.mm		= mm,
+		.mm		= &init_mm,
 		.pgd		= pgd,
 		.private	= private,
 		.no_vma		= true
@@ -620,16 +642,6 @@ int walk_kernel_page_table_range(unsigned long start, unsigned long end,
 	if (!check_ops_valid(ops))
 		return -EINVAL;
 
-	/*
-	 * Kernel intermediate page tables are usually not freed, so the mmap
-	 * read lock is sufficient. But there are some exceptions.
-	 * E.g. memory hot-remove. In which case, the mmap lock is insufficient
-	 * to prevent the intermediate kernel pages tables belonging to the
-	 * specified address range from being freed. The caller should take
-	 * other actions to prevent this race.
-	 */
-	mmap_assert_locked(mm);
-
 	return walk_pgd_range(start, end, &walk);
 }
 
-- 
2.43.0



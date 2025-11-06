Return-Path: <linux-kernel+bounces-888935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9888DC3C524
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5978B505346
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FAF340DA6;
	Thu,  6 Nov 2025 16:10:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78E734B693
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445399; cv=none; b=O6NQFQwfsKKYq7NBZOYrAJ9af8Ajo8M/BMNEekaUT8uK12fiX7cO9gxuj01mpvXOU7B9cppkHBAHcV5ekkAtz6SLBmj3sOGbKRhr++nSH1hoYeOgxEPpxu1TTPHtQ2DEFf9fvOtzqhRIQ1xuBBIh+gRV1NpCFFPwVhjjtjU6rX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445399; c=relaxed/simple;
	bh=NAHL8aX/40wLvrJMxbZ062XZ3alLXaEAr1S+QCSspBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBdsotnAtkdyZACRh0AeaY3GQVElTyXB1q7Xbv+y81jSSJvfWTCJuBuQTQSX72Qdo5tTLhqQ9uKSwHLnCTKwr5R0DdTtHhtlcEU5lb5ykFIjK4AUoWi0NTCO5TTgWMD6n2JWoGFkYFBqIF6mpclAwqktvFIN4recedgCY5F86JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845DE168F;
	Thu,  6 Nov 2025 08:09:49 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDCED3F66E;
	Thu,  6 Nov 2025 08:09:55 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com,
	david@redhat.com,
	ardb@kernel.org,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <groeck@google.com>
Subject: [PATCH v2 1/3] arm64: mm: Don't sleep in split_kernel_leaf_mapping() when in atomic context
Date: Thu,  6 Nov 2025 16:09:41 +0000
Message-ID: <20251106160945.3182799-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106160945.3182799-1-ryan.roberts@arm.com>
References: <20251106160945.3182799-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been reported that split_kernel_leaf_mapping() is trying to sleep
in non-sleepable context. It does this when acquiring the
pgtable_split_lock mutex, when either CONFIG_DEBUG_PAGEALLOC or
CONFIG_KFENCE are enabled, which change linear map permissions within
softirq context during memory allocation and/or freeing. All other paths
into this function are called from sleepable context and so are safe.

But it turns out that the memory for which these 2 features may attempt
to modify the permissions is always mapped by pte, so there is no need
to attempt to split the mapping. So let's exit early in these cases and
avoid attempting to take the mutex.

There is one wrinkle to this approach; late-initialized kfence allocates
it's pool from the buddy which may be block mapped. So we must hook that
allocation and convert it to pte-mappings up front. Previously this was
done as a side-effect of kfence protecting all the individual pages in
its pool at init-time, but this no longer works due to the added early
exit path in split_kernel_leaf_mapping().

So instead, do this via the existing arch_kfence_init_pool() arch hook,
and reuse the existing linear_map_split_to_ptes() infrastructure.

Closes: https://lore.kernel.org/all/f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net/
Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
Tested-by: Guenter Roeck <groeck@google.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/kfence.h |  3 +-
 arch/arm64/mm/mmu.c             | 92 +++++++++++++++++++++++----------
 2 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
index a81937fae9f6..21dbc9dda747 100644
--- a/arch/arm64/include/asm/kfence.h
+++ b/arch/arm64/include/asm/kfence.h
@@ -10,8 +10,6 @@
 
 #include <asm/set_memory.h>
 
-static inline bool arch_kfence_init_pool(void) { return true; }
-
 static inline bool kfence_protect_page(unsigned long addr, bool protect)
 {
 	set_memory_valid(addr, 1, !protect);
@@ -25,6 +23,7 @@ static inline bool arm64_kfence_can_set_direct_map(void)
 {
 	return !kfence_early_init;
 }
+bool arch_kfence_init_pool(void);
 #else /* CONFIG_KFENCE */
 static inline bool arm64_kfence_can_set_direct_map(void) { return false; }
 #endif /* CONFIG_KFENCE */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b8d37eb037fc..a364ac2c9c61 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -708,6 +708,16 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 	return ret;
 }
 
+static inline bool force_pte_mapping(void)
+{
+	bool bbml2 = system_capabilities_finalized() ?
+		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
+
+	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
+			   is_realm_world())) ||
+		debug_pagealloc_enabled();
+}
+
 static DEFINE_MUTEX(pgtable_split_lock);
 
 int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
@@ -723,6 +733,16 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
 	if (!system_supports_bbml2_noabort())
 		return 0;
 
+	/*
+	 * If the region is within a pte-mapped area, there is no need to try to
+	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
+	 * change permissions from atomic context so for those cases (which are
+	 * always pte-mapped), we must not go any further because taking the
+	 * mutex below may sleep.
+	 */
+	if (force_pte_mapping() || is_kfence_address((void *)start))
+		return 0;
+
 	/*
 	 * Ensure start and end are at least page-aligned since this is the
 	 * finest granularity we can split to.
@@ -758,30 +778,30 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
 	return ret;
 }
 
-static int __init split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
-					  unsigned long next,
-					  struct mm_walk *walk)
+static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
+				   unsigned long next, struct mm_walk *walk)
 {
+	gfp_t gfp = *(gfp_t *)walk->private;
 	pud_t pud = pudp_get(pudp);
 	int ret = 0;
 
 	if (pud_leaf(pud))
-		ret = split_pud(pudp, pud, GFP_ATOMIC, false);
+		ret = split_pud(pudp, pud, gfp, false);
 
 	return ret;
 }
 
-static int __init split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
-					  unsigned long next,
-					  struct mm_walk *walk)
+static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
+				   unsigned long next, struct mm_walk *walk)
 {
+	gfp_t gfp = *(gfp_t *)walk->private;
 	pmd_t pmd = pmdp_get(pmdp);
 	int ret = 0;
 
 	if (pmd_leaf(pmd)) {
 		if (pmd_cont(pmd))
 			split_contpmd(pmdp);
-		ret = split_pmd(pmdp, pmd, GFP_ATOMIC, false);
+		ret = split_pmd(pmdp, pmd, gfp, false);
 
 		/*
 		 * We have split the pmd directly to ptes so there is no need to
@@ -793,9 +813,8 @@ static int __init split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
 	return ret;
 }
 
-static int __init split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
-					  unsigned long next,
-					  struct mm_walk *walk)
+static int split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
+				   unsigned long next, struct mm_walk *walk)
 {
 	pte_t pte = __ptep_get(ptep);
 
@@ -805,12 +824,18 @@ static int __init split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
 	return 0;
 }
 
-static const struct mm_walk_ops split_to_ptes_ops __initconst = {
+static const struct mm_walk_ops split_to_ptes_ops = {
 	.pud_entry	= split_to_ptes_pud_entry,
 	.pmd_entry	= split_to_ptes_pmd_entry,
 	.pte_entry	= split_to_ptes_pte_entry,
 };
 
+static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
+{
+	return walk_kernel_page_table_range_lockless(start, end,
+					&split_to_ptes_ops, NULL, &gfp);
+}
+
 static bool linear_map_requires_bbml2 __initdata;
 
 u32 idmap_kpti_bbml2_flag;
@@ -847,11 +872,9 @@ static int __init linear_map_split_to_ptes(void *__unused)
 		 * PTE. The kernel alias remains static throughout runtime so
 		 * can continue to be safely mapped with large mappings.
 		 */
-		ret = walk_kernel_page_table_range_lockless(lstart, kstart,
-						&split_to_ptes_ops, NULL, NULL);
+		ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
 		if (!ret)
-			ret = walk_kernel_page_table_range_lockless(kend, lend,
-						&split_to_ptes_ops, NULL, NULL);
+			ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
 		if (ret)
 			panic("Failed to split linear map\n");
 		flush_tlb_kernel_range(lstart, lend);
@@ -1002,6 +1025,33 @@ static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp)
 	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
 	__kfence_pool = phys_to_virt(kfence_pool);
 }
+
+bool arch_kfence_init_pool(void)
+{
+	unsigned long start = (unsigned long)__kfence_pool;
+	unsigned long end = start + KFENCE_POOL_SIZE;
+	int ret;
+
+	/* Exit early if we know the linear map is already pte-mapped. */
+	if (!system_supports_bbml2_noabort() || force_pte_mapping())
+		return true;
+
+	/* Kfence pool is already pte-mapped for the early init case. */
+	if (kfence_early_init)
+		return true;
+
+	mutex_lock(&pgtable_split_lock);
+	ret = range_split_to_ptes(start, end, GFP_PGTABLE_KERNEL);
+	mutex_unlock(&pgtable_split_lock);
+
+	/*
+	 * Since the system supports bbml2_noabort, tlb invalidation is not
+	 * required here; the pgtable mappings have been split to pte but larger
+	 * entries may safely linger in the TLB.
+	 */
+
+	return !ret;
+}
 #else /* CONFIG_KFENCE */
 
 static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
@@ -1009,16 +1059,6 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
 
 #endif /* CONFIG_KFENCE */
 
-static inline bool force_pte_mapping(void)
-{
-	bool bbml2 = system_capabilities_finalized() ?
-		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
-
-	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
-			   is_realm_world())) ||
-		debug_pagealloc_enabled();
-}
-
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
-- 
2.43.0



Return-Path: <linux-kernel+bounces-791705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D8AB3BA53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D73A9D77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999D031AF07;
	Fri, 29 Aug 2025 11:53:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D71A31A566
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468395; cv=none; b=knJjRhFZMa9c56aROzWd30O9iqQDTYJNtRPfD9IVYOE5C2sRDdyzfftE1y5KEQoOQJFypZdM91uGj0yO0/mjBKd0RpY59H6cea07sh2uBYvkjhT6hNX83uTYxfe8tp1WcPSlInMSNAaC7CWNiGPrjphTsu9gdtIVIjuZAGsKLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468395; c=relaxed/simple;
	bh=LTCrRgEwhuySozcpIHGWjeL5aZXOlPJqfdzM7bNwdLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvU1wqJqomY9cuYyCxyGKSjrXuX3pTu6LrKZMZ0H1PDx2gaCeybLDEW5GnxQovbvf6f7SsJnMXM1CstUHe4LDyVsvgY4S+oM231pEyuvHxD/gA6esD67XLeN5dRtQUI6AJMO7DXZu2hgzZF1lPTuOexxYmbbSk4BuwUG0ZWmqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50FE11BCB;
	Fri, 29 Aug 2025 04:53:03 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA503F694;
	Fri, 29 Aug 2025 04:53:09 -0700 (PDT)
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
Subject: [PATCH v7 3/6] arm64: mm: support large block mapping when rodata=full
Date: Fri, 29 Aug 2025 12:52:44 +0100
Message-ID: <20250829115250.2395585-4-ryan.roberts@arm.com>
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

From: Yang Shi <yang@os.amperecomputing.com>

When rodata=full is specified, kernel linear mapping has to be mapped at
PTE level since large page table can't be split due to break-before-make
rule on ARM64.

This resulted in a couple of problems:
  - performance degradation
  - more TLB pressure
  - memory waste for kernel page table

With FEAT_BBM level 2 support, splitting large block page table to
smaller ones doesn't need to make the page table entry invalid anymore.
This allows kernel split large block mapping on the fly.

Add kernel page table split support and use large block mapping by
default when FEAT_BBM level 2 is supported for rodata=full.  When
changing permissions for kernel linear mapping, the page table will be
split to smaller size.

The machine without FEAT_BBM level 2 will fallback to have kernel linear
mapping PTE-mapped when rodata=full.

With this we saw significant performance boost with some benchmarks and
much less memory consumption on my AmpereOne machine (192 cores, 1P)
with 256GB memory.

* Memory use after boot
Before:
MemTotal:       258988984 kB
MemFree:        254821700 kB

After:
MemTotal:       259505132 kB
MemFree:        255410264 kB

Around 500MB more memory are free to use.  The larger the machine, the
more memory saved.

* Memcached
We saw performance degradation when running Memcached benchmark with
rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
With this patchset we saw ops/sec is increased by around 3.5%, P99
latency is reduced by around 9.6%.
The gain mainly came from reduced kernel TLB misses.  The kernel TLB
MPKI is reduced by 28.5%.

The benchmark data is now on par with rodata=on too.

* Disk encryption (dm-crypt) benchmark
Ran fio benchmark with the below command on a 128G ramdisk (ext4) with
disk encryption (by dm-crypt).
fio --directory=/data --random_generator=lfsr --norandommap            \
    --randrepeat 1 --status-interval=999 --rw=write --bs=4k --loops=1  \
    --ioengine=sync --iodepth=1 --numjobs=1 --fsync_on_close=1         \
    --group_reporting --thread --name=iops-test-job --eta-newline=1    \
    --size 100G

The IOPS is increased by 90% - 150% (the variance is high, but the worst
number of good case is around 90% more than the best number of bad
case). The bandwidth is increased and the avg clat is reduced
proportionally.

* Sequential file read
Read 100G file sequentially on XFS (xfs_io read with page cache
populated). The bandwidth is increased by 150%.

Co-developed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/cpufeature.h |   2 +
 arch/arm64/include/asm/mmu.h        |   1 +
 arch/arm64/include/asm/pgtable.h    |   5 +
 arch/arm64/kernel/cpufeature.c      |   7 +-
 arch/arm64/mm/mmu.c                 | 248 +++++++++++++++++++++++++++-
 arch/arm64/mm/pageattr.c            |   4 +
 6 files changed, 261 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index bf13d676aae2..e223cbf350e4 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -871,6 +871,8 @@ static inline bool system_supports_pmuv3(void)
 	return cpus_have_final_cap(ARM64_HAS_PMUV3);
 }
 
+bool cpu_supports_bbml2_noabort(void);
+
 static inline bool system_supports_bbml2_noabort(void)
 {
 	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 6e8aa8e72601..56fca81f60ad 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -71,6 +71,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       pgprot_t prot, bool page_mappings_only);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
+extern int split_kernel_leaf_mapping(unsigned long start, unsigned long end);
 
 /*
  * This check is triggered during the early boot before the cpufeature
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index abd2dee416b3..aa89c2e67ebc 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -371,6 +371,11 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
 	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
 }
 
+static inline pmd_t pmd_mknoncont(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) & ~PMD_SECT_CONT);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b93f4ee57176..a8936c1023ea 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2217,7 +2217,7 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
 	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
 }
 
-static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
+bool cpu_supports_bbml2_noabort(void)
 {
 	/*
 	 * We want to allow usage of BBML2 in as wide a range of kernel contexts
@@ -2251,6 +2251,11 @@ static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int sco
 	return true;
 }
 
+static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
+{
+	return cpu_supports_bbml2_noabort();
+}
+
 #ifdef CONFIG_ARM64_PAN
 static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 34e5d78af076..114b88216b0c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -481,6 +481,8 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
 			     int flags);
 #endif
 
+#define INVALID_PHYS_ADDR	-1
+
 static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
 				       enum pgtable_type pgtable_type)
 {
@@ -488,7 +490,9 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
 	phys_addr_t pa;
 
-	BUG_ON(!ptdesc);
+	if (!ptdesc)
+		return INVALID_PHYS_ADDR;
+
 	pa = page_to_phys(ptdesc_page(ptdesc));
 
 	switch (pgtable_type) {
@@ -509,16 +513,240 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
 	return pa;
 }
 
+static phys_addr_t
+try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
+{
+	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
+}
+
 static phys_addr_t __maybe_unused
 pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
 {
-	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
+	phys_addr_t pa;
+
+	pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
+	BUG_ON(pa == INVALID_PHYS_ADDR);
+	return pa;
 }
 
 static phys_addr_t
 pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
 {
-	return __pgd_pgtable_alloc(NULL, pgtable_type);
+	phys_addr_t pa;
+
+	pa = __pgd_pgtable_alloc(NULL, pgtable_type);
+	BUG_ON(pa == INVALID_PHYS_ADDR);
+	return pa;
+}
+
+static void split_contpte(pte_t *ptep)
+{
+	int i;
+
+	ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
+	for (i = 0; i < CONT_PTES; i++, ptep++)
+		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
+}
+
+static int split_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
+	unsigned long pfn = pmd_pfn(pmd);
+	pgprot_t prot = pmd_pgprot(pmd);
+	phys_addr_t pte_phys;
+	pte_t *ptep;
+	int i;
+
+	pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE);
+	if (pte_phys == INVALID_PHYS_ADDR)
+		return -ENOMEM;
+	ptep = (pte_t *)phys_to_virt(pte_phys);
+
+	if (pgprot_val(prot) & PMD_SECT_PXN)
+		tableprot |= PMD_TABLE_PXN;
+
+	prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) | PTE_TYPE_PAGE);
+	prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+
+	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
+		__set_pte(ptep, pfn_pte(pfn, prot));
+
+	/*
+	 * Ensure the pte entries are visible to the table walker by the time
+	 * the pmd entry that points to the ptes is visible.
+	 */
+	dsb(ishst);
+	__pmd_populate(pmdp, pte_phys, tableprot);
+
+	return 0;
+}
+
+static void split_contpmd(pmd_t *pmdp)
+{
+	int i;
+
+	pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
+	for (i = 0; i < CONT_PMDS; i++, pmdp++)
+		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
+}
+
+static int split_pud(pud_t *pudp, pud_t pud)
+{
+	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
+	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
+	unsigned long pfn = pud_pfn(pud);
+	pgprot_t prot = pud_pgprot(pud);
+	phys_addr_t pmd_phys;
+	pmd_t *pmdp;
+	int i;
+
+	pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD);
+	if (pmd_phys == INVALID_PHYS_ADDR)
+		return -ENOMEM;
+	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
+
+	if (pgprot_val(prot) & PMD_SECT_PXN)
+		tableprot |= PUD_TABLE_PXN;
+
+	prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
+	prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+
+	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
+		set_pmd(pmdp, pfn_pmd(pfn, prot));
+
+	/*
+	 * Ensure the pmd entries are visible to the table walker by the time
+	 * the pud entry that points to the pmds is visible.
+	 */
+	dsb(ishst);
+	__pud_populate(pudp, pmd_phys, tableprot);
+
+	return 0;
+}
+
+static int split_kernel_leaf_mapping_locked(unsigned long addr)
+{
+	pgd_t *pgdp, pgd;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+	int ret = 0;
+
+	/*
+	 * PGD: If addr is PGD aligned then addr already describes a leaf
+	 * boundary. If not present then there is nothing to split.
+	 */
+	if (ALIGN_DOWN(addr, PGDIR_SIZE) == addr)
+		goto out;
+	pgdp = pgd_offset_k(addr);
+	pgd = pgdp_get(pgdp);
+	if (!pgd_present(pgd))
+		goto out;
+
+	/*
+	 * P4D: If addr is P4D aligned then addr already describes a leaf
+	 * boundary. If not present then there is nothing to split.
+	 */
+	if (ALIGN_DOWN(addr, P4D_SIZE) == addr)
+		goto out;
+	p4dp = p4d_offset(pgdp, addr);
+	p4d = p4dp_get(p4dp);
+	if (!p4d_present(p4d))
+		goto out;
+
+	/*
+	 * PUD: If addr is PUD aligned then addr already describes a leaf
+	 * boundary. If not present then there is nothing to split. Otherwise,
+	 * if we have a pud leaf, split to contpmd.
+	 */
+	if (ALIGN_DOWN(addr, PUD_SIZE) == addr)
+		goto out;
+	pudp = pud_offset(p4dp, addr);
+	pud = pudp_get(pudp);
+	if (!pud_present(pud))
+		goto out;
+	if (pud_leaf(pud)) {
+		ret = split_pud(pudp, pud);
+		if (ret)
+			goto out;
+	}
+
+	/*
+	 * CONTPMD: If addr is CONTPMD aligned then addr already describes a
+	 * leaf boundary. If not present then there is nothing to split.
+	 * Otherwise, if we have a contpmd leaf, split to pmd.
+	 */
+	if (ALIGN_DOWN(addr, CONT_PMD_SIZE) == addr)
+		goto out;
+	pmdp = pmd_offset(pudp, addr);
+	pmd = pmdp_get(pmdp);
+	if (!pmd_present(pmd))
+		goto out;
+	if (pmd_leaf(pmd)) {
+		if (pmd_cont(pmd))
+			split_contpmd(pmdp);
+		/*
+		 * PMD: If addr is PMD aligned then addr already describes a
+		 * leaf boundary. Otherwise, split to contpte.
+		 */
+		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
+			goto out;
+		ret = split_pmd(pmdp, pmd);
+		if (ret)
+			goto out;
+	}
+
+	/*
+	 * CONTPTE: If addr is CONTPTE aligned then addr already describes a
+	 * leaf boundary. If not present then there is nothing to split.
+	 * Otherwise, if we have a contpte leaf, split to pte.
+	 */
+	if (ALIGN_DOWN(addr, CONT_PTE_SIZE) == addr)
+		goto out;
+	ptep = pte_offset_kernel(pmdp, addr);
+	pte = __ptep_get(ptep);
+	if (!pte_present(pte))
+		goto out;
+	if (pte_cont(pte))
+		split_contpte(ptep);
+
+out:
+	return ret;
+}
+
+static DEFINE_MUTEX(pgtable_split_lock);
+
+int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
+{
+	int ret;
+
+	/*
+	 * !BBML2_NOABORT systems should not be trying to change permissions on
+	 * anything that is not pte-mapped in the first place. Just return early
+	 * and let the permission change code raise a warning if not already
+	 * pte-mapped.
+	 */
+	if (!system_supports_bbml2_noabort())
+		return 0;
+
+	/*
+	 * Ensure start and end are at least page-aligned since this is the
+	 * finest granularity we can split to.
+	 */
+	if (start != PAGE_ALIGN(start) || end != PAGE_ALIGN(end))
+		return -EINVAL;
+
+	mutex_lock(&pgtable_split_lock);
+	arch_enter_lazy_mmu_mode();
+
+	ret = split_kernel_leaf_mapping_locked(start);
+	if (!ret)
+		ret = split_kernel_leaf_mapping_locked(end);
+
+	arch_leave_lazy_mmu_mode();
+	mutex_unlock(&pgtable_split_lock);
+	return ret;
 }
 
 /*
@@ -640,6 +868,16 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
 
 #endif /* CONFIG_KFENCE */
 
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
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
@@ -665,7 +903,7 @@ static void __init map_mem(pgd_t *pgdp)
 
 	early_kfence_pool = arm64_kfence_alloc_pool();
 
-	if (can_set_direct_map())
+	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
@@ -1367,7 +1605,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 	VM_BUG_ON(!mhp_range_allowed(start, size, true));
 
-	if (can_set_direct_map())
+	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 6da8cbc32f46..0aba80a38cef 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -140,6 +140,10 @@ static int update_range_prot(unsigned long start, unsigned long size,
 	data.set_mask = set_mask;
 	data.clear_mask = clear_mask;
 
+	ret = split_kernel_leaf_mapping(start, start + size);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
 	arch_enter_lazy_mmu_mode();
 
 	/*
-- 
2.43.0



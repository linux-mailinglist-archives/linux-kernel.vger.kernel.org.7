Return-Path: <linux-kernel+bounces-791707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607AB3BA54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA1877BA757
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FD431B102;
	Fri, 29 Aug 2025 11:53:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37831AF04
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468398; cv=none; b=HUIkB2lp6V0VdpUFENO7BbZPRoUdQLJn5nyE5eGkykoh32sp3bvlxh3ehfmnCTtcL2D4hKaymPXFjVFADzUlbMosH6d40R71yjcm5j+n48Ugx5AtYWrzrmt8x9Xz4q6ON38K5XWB4Lj8yHKGilU6CSd6dqc7Yj/W61Bsve93AfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468398; c=relaxed/simple;
	bh=khbIPk8FBJ+g1Nr+2e809/n84xIPP0zHZZfcAKD9JD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkyTJvXM0kzY6HkidfpqCZDIoC/pYcP8QhI8ezb/akEVUFN30PsOyr7BNnPOcldrHw+KpBIg2WamQLbekq1z53X+FSHMzWO5dxY5N/hLTwGjApFCVz3ROdJrh7Qwbp8geaQEF0/zGxGH9fYgxPFSJzUSKH4OzNUhhyz9J3jGC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D691BCB;
	Fri, 29 Aug 2025 04:53:07 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BC823F694;
	Fri, 29 Aug 2025 04:53:14 -0700 (PDT)
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
Subject: [PATCH v7 5/6] arm64: mm: split linear mapping if BBML2 unsupported on secondary CPUs
Date: Fri, 29 Aug 2025 12:52:46 +0100
Message-ID: <20250829115250.2395585-6-ryan.roberts@arm.com>
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

The kernel linear mapping is painted in very early stage of system boot.
The cpufeature has not been finalized yet at this point. So the linear
mapping is determined by the capability of boot CPU only. If the boot
CPU supports BBML2, large block mappings will be used for linear
mapping.

But the secondary CPUs may not support BBML2, so repaint the linear
mapping if large block mapping is used and the secondary CPUs don't
support BBML2 once cpufeature is finalized on all CPUs.

If the boot CPU doesn't support BBML2 or the secondary CPUs have the
same BBML2 capability with the boot CPU, repainting the linear mapping
is not needed.

Repainting is implemented by the boot CPU, which we know supports BBML2,
so it is safe for the live mapping size to change for this CPU. The
linear map region is walked using the pagewalk API and any discovered
large leaf mappings are split to pte mappings using the existing helper
functions. Since the repainting is performed inside of a stop_machine(),
we must use GFP_ATOMIC to allocate the extra intermediate pgtables. But
since we are still early in boot, it is expected that there is plenty of
memory available so we will never need to sleep for reclaim, and so
GFP_ATOMIC is acceptable here.

The secondary CPUs are all put into a waiting area with the idmap in
TTBR0 and reserved map in TTBR1 while this is performed since they
cannot be allowed to observe any size changes on the live mappings. Some
of this infrastructure is reused from the kpti case. Specifically we
share the same flag (was __idmap_kpti_flag, now idmap_kpti_bbml2_flag)
since it means we don't have to reserve any extra pgtable memory to
idmap the extra flag.

Co-developed-by: Yang Shi <yang@os.amperecomputing.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/mmu.h   |   2 +
 arch/arm64/kernel/cpufeature.c |   3 +
 arch/arm64/mm/mmu.c            | 168 +++++++++++++++++++++++++++++----
 arch/arm64/mm/proc.S           |  27 ++++--
 4 files changed, 175 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 56fca81f60ad..2acfa7801d02 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -72,6 +72,8 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
 extern int split_kernel_leaf_mapping(unsigned long start, unsigned long end);
+extern void init_idmap_kpti_bbml2_flag(void);
+extern void linear_map_maybe_split_to_ptes(void);
 
 /*
  * This check is triggered during the early boot before the cpufeature
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a8936c1023ea..461d286f40b1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -85,6 +85,7 @@
 #include <asm/insn.h>
 #include <asm/kvm_host.h>
 #include <asm/mmu_context.h>
+#include <asm/mmu.h>
 #include <asm/mte.h>
 #include <asm/hypervisor.h>
 #include <asm/processor.h>
@@ -2027,6 +2028,7 @@ static void __init kpti_install_ng_mappings(void)
 	if (arm64_use_ng_mappings)
 		return;
 
+	init_idmap_kpti_bbml2_flag();
 	stop_machine(__kpti_install_ng_mappings, NULL, cpu_online_mask);
 }
 
@@ -3930,6 +3932,7 @@ void __init setup_system_features(void)
 {
 	setup_system_capabilities();
 
+	linear_map_maybe_split_to_ptes();
 	kpti_install_ng_mappings();
 
 	sve_setup();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8b5b19e1154b..6bd0b065bd97 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -27,6 +27,8 @@
 #include <linux/kfence.h>
 #include <linux/pkeys.h>
 #include <linux/mm_inline.h>
+#include <linux/pagewalk.h>
+#include <linux/stop_machine.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -483,11 +485,11 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
 
 #define INVALID_PHYS_ADDR	-1
 
-static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
+static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
 				       enum pgtable_type pgtable_type)
 {
 	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
+	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
 	phys_addr_t pa;
 
 	if (!ptdesc)
@@ -514,9 +516,9 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
 }
 
 static phys_addr_t
-try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
+try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
 {
-	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
+	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
 }
 
 static phys_addr_t __maybe_unused
@@ -524,7 +526,7 @@ pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
 {
 	phys_addr_t pa;
 
-	pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
+	pa = __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
 	BUG_ON(pa == INVALID_PHYS_ADDR);
 	return pa;
 }
@@ -534,7 +536,7 @@ pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
 {
 	phys_addr_t pa;
 
-	pa = __pgd_pgtable_alloc(NULL, pgtable_type);
+	pa = __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
 	BUG_ON(pa == INVALID_PHYS_ADDR);
 	return pa;
 }
@@ -548,7 +550,7 @@ static void split_contpte(pte_t *ptep)
 		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
 }
 
-static int split_pmd(pmd_t *pmdp, pmd_t pmd)
+static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
 {
 	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
 	unsigned long pfn = pmd_pfn(pmd);
@@ -557,7 +559,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd)
 	pte_t *ptep;
 	int i;
 
-	pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE);
+	pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE, gfp);
 	if (pte_phys == INVALID_PHYS_ADDR)
 		return -ENOMEM;
 	ptep = (pte_t *)phys_to_virt(pte_phys);
@@ -590,7 +592,7 @@ static void split_contpmd(pmd_t *pmdp)
 		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
 }
 
-static int split_pud(pud_t *pudp, pud_t pud)
+static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
 {
 	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
 	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
@@ -600,7 +602,7 @@ static int split_pud(pud_t *pudp, pud_t pud)
 	pmd_t *pmdp;
 	int i;
 
-	pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD);
+	pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD, gfp);
 	if (pmd_phys == INVALID_PHYS_ADDR)
 		return -ENOMEM;
 	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
@@ -667,7 +669,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 	if (!pud_present(pud))
 		goto out;
 	if (pud_leaf(pud)) {
-		ret = split_pud(pudp, pud);
+		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL);
 		if (ret)
 			goto out;
 	}
@@ -692,7 +694,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 		 */
 		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
 			goto out;
-		ret = split_pmd(pmdp, pmd);
+		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL);
 		if (ret)
 			goto out;
 	}
@@ -761,6 +763,132 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
 	return ret;
 }
 
+static int __init split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
+					  unsigned long next,
+					  struct mm_walk *walk)
+{
+	pud_t pud = pudp_get(pudp);
+	int ret = 0;
+
+	if (pud_leaf(pud))
+		ret = split_pud(pudp, pud, GFP_ATOMIC);
+
+	return ret;
+}
+
+static int __init split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
+					  unsigned long next,
+					  struct mm_walk *walk)
+{
+	pmd_t pmd = pmdp_get(pmdp);
+	int ret = 0;
+
+	if (pmd_leaf(pmd)) {
+		if (pmd_cont(pmd))
+			split_contpmd(pmdp);
+		ret = split_pmd(pmdp, pmd, GFP_ATOMIC);
+	}
+
+	return ret;
+}
+
+static int __init split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
+					  unsigned long next,
+					  struct mm_walk *walk)
+{
+	pte_t pte = __ptep_get(ptep);
+
+	if (pte_cont(pte))
+		split_contpte(ptep);
+
+	return 0;
+}
+
+static const struct mm_walk_ops split_to_ptes_ops __initconst = {
+	.pud_entry	= split_to_ptes_pud_entry,
+	.pmd_entry	= split_to_ptes_pmd_entry,
+	.pte_entry	= split_to_ptes_pte_entry,
+};
+
+static bool linear_map_requires_bbml2 __initdata;
+
+u32 idmap_kpti_bbml2_flag;
+
+void __init init_idmap_kpti_bbml2_flag(void)
+{
+	WRITE_ONCE(idmap_kpti_bbml2_flag, 1);
+	/* Must be visible to other CPUs before stop_machine() is called. */
+	smp_mb();
+}
+
+static int __init linear_map_split_to_ptes(void *__unused)
+{
+	/*
+	 * Repainting the linear map must be done by CPU0 (the boot CPU) because
+	 * that's the only CPU that we know supports BBML2. The other CPUs will
+	 * be held in a waiting area with the idmap active.
+	 */
+	if (!smp_processor_id()) {
+		unsigned long lstart = _PAGE_OFFSET(vabits_actual);
+		unsigned long lend = PAGE_END;
+		unsigned long kstart = (unsigned long)lm_alias(_stext);
+		unsigned long kend = (unsigned long)lm_alias(__init_begin);
+		int ret;
+
+		/*
+		 * Wait for all secondary CPUs to be put into the waiting area.
+		 */
+		smp_cond_load_acquire(&idmap_kpti_bbml2_flag, VAL == num_online_cpus());
+
+		/*
+		 * Walk all of the linear map [lstart, lend), except the kernel
+		 * linear map alias [kstart, kend), and split all mappings to
+		 * PTE. The kernel alias remains static throughout runtime so
+		 * can continue to be safely mapped with large mappings.
+		 */
+		ret = walk_kernel_page_table_range_lockless(lstart, kstart,
+						&split_to_ptes_ops, NULL, NULL);
+		if (!ret)
+			ret = walk_kernel_page_table_range_lockless(kend, lend,
+						&split_to_ptes_ops, NULL, NULL);
+		if (ret)
+			panic("Failed to split linear map\n");
+		flush_tlb_kernel_range(lstart, lend);
+
+		/*
+		 * Relies on dsb in flush_tlb_kernel_range() to avoid reordering
+		 * before any page table split operations.
+		 */
+		WRITE_ONCE(idmap_kpti_bbml2_flag, 0);
+	} else {
+		typedef void (wait_split_fn)(void);
+		extern wait_split_fn wait_linear_map_split_to_ptes;
+		wait_split_fn *wait_fn;
+
+		wait_fn = (void *)__pa_symbol(wait_linear_map_split_to_ptes);
+
+		/*
+		 * At least one secondary CPU doesn't support BBML2 so cannot
+		 * tolerate the size of the live mappings changing. So have the
+		 * secondary CPUs wait for the boot CPU to make the changes
+		 * with the idmap active and init_mm inactive.
+		 */
+		cpu_install_idmap();
+		wait_fn();
+		cpu_uninstall_idmap();
+	}
+
+	return 0;
+}
+
+void __init linear_map_maybe_split_to_ptes(void)
+{
+	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()) {
+		init_idmap_kpti_bbml2_flag();
+		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
+	}
+}
+
 /*
  * This function can only be used to modify existing table entries,
  * without allocating new levels of table. Note that this permits the
@@ -915,6 +1043,8 @@ static void __init map_mem(pgd_t *pgdp)
 
 	early_kfence_pool = arm64_kfence_alloc_pool();
 
+	linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map();
+
 	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
@@ -1048,7 +1178,7 @@ void __pi_map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
 		    int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
 
 static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
-	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
+	  kpti_bbml2_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
 
 static void __init create_idmap(void)
 {
@@ -1060,15 +1190,17 @@ static void __init create_idmap(void)
 		       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
 		       __phys_to_virt(ptep) - ptep);
 
-	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) && !arm64_use_ng_mappings) {
-		extern u32 __idmap_kpti_flag;
-		u64 pa = __pa_symbol(&__idmap_kpti_flag);
+	if (linear_map_requires_bbml2 ||
+	    (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) && !arm64_use_ng_mappings)) {
+		u64 pa = __pa_symbol(&idmap_kpti_bbml2_flag);
 
 		/*
 		 * The KPTI G-to-nG conversion code needs a read-write mapping
-		 * of its synchronization flag in the ID map.
+		 * of its synchronization flag in the ID map. This is also used
+		 * when splitting the linear map to ptes if a secondary CPU
+		 * doesn't support bbml2.
 		 */
-		ptep = __pa_symbol(kpti_ptes);
+		ptep = __pa_symbol(kpti_bbml2_ptes);
 		__pi_map_range(&ptep, pa, pa + sizeof(u32), pa, PAGE_KERNEL,
 			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
 			       __phys_to_virt(ptep) - ptep);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 8c75965afc9e..86818511962b 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -245,10 +245,6 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
  *
  * Called exactly once from stop_machine context by each CPU found during boot.
  */
-	.pushsection	".data", "aw", %progbits
-SYM_DATA(__idmap_kpti_flag, .long 1)
-	.popsection
-
 SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 	cpu		.req	w0
 	temp_pte	.req	x0
@@ -273,7 +269,7 @@ SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 
 	mov	x5, x3				// preserve temp_pte arg
 	mrs	swapper_ttb, ttbr1_el1
-	adr_l	flag_ptr, __idmap_kpti_flag
+	adr_l	flag_ptr, idmap_kpti_bbml2_flag
 
 	cbnz	cpu, __idmap_kpti_secondary
 
@@ -416,7 +412,25 @@ alternative_else_nop_endif
 __idmap_kpti_secondary:
 	/* Uninstall swapper before surgery begins */
 	__idmap_cpu_set_reserved_ttbr1 x16, x17
+	b scondary_cpu_wait
+
+	.unreq	swapper_ttb
+	.unreq	flag_ptr
+SYM_FUNC_END(idmap_kpti_install_ng_mappings)
+	.popsection
+#endif
+
+	.pushsection ".idmap.text", "a"
+SYM_TYPED_FUNC_START(wait_linear_map_split_to_ptes)
+	/* Must be same registers as in idmap_kpti_install_ng_mappings */
+	swapper_ttb	.req	x3
+	flag_ptr	.req	x4
+
+	mrs     swapper_ttb, ttbr1_el1
+	adr_l   flag_ptr, idmap_kpti_bbml2_flag
+	__idmap_cpu_set_reserved_ttbr1 x16, x17
 
+scondary_cpu_wait:
 	/* Increment the flag to let the boot CPU we're ready */
 1:	ldxr	w16, [flag_ptr]
 	add	w16, w16, #1
@@ -436,9 +450,8 @@ __idmap_kpti_secondary:
 
 	.unreq	swapper_ttb
 	.unreq	flag_ptr
-SYM_FUNC_END(idmap_kpti_install_ng_mappings)
+SYM_FUNC_END(wait_linear_map_split_to_ptes)
 	.popsection
-#endif
 
 /*
  *	__cpu_setup
-- 
2.43.0



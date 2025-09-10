Return-Path: <linux-kernel+bounces-809990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEEDB51468
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34FD7BE0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18D5238D42;
	Wed, 10 Sep 2025 10:45:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3EA3164C8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501109; cv=none; b=RDxrzCBOf+dTlMAPeFDOAa2fML6hYmDaCvUv9Thn3p2UVRfxcFcx+p5zivyagnbQ62y3O21SaOh1/2O6Aq7S6lBTegHIhg8mE3HVo0Mr4kbTf7EJSwHnIssiRIO2wmTUbN+qdK1A1UP0BYNfgOND7yit5hSeco7r3QyBVG6rV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501109; c=relaxed/simple;
	bh=ofXBXq9c6SMXO25BMXx4sHiuk3nK3z6Gv52WCxyl9lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z82Spa2OCrgiklhIcncwEk+/5Z4EkBxmKusGLraVKHBzYkoHVj3GzdkyYUL7EjqmfafrIRAPNrQE0NCnVmKh2BO5xyX2Yiq5JeIWAAqNUERPMC7HLXLa4cLyJyNiNTs6Wv4QHwl+xvJeH9Cr9YxVhDPQqe9mWSgwmh2bkCSRCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D6DB16F8;
	Wed, 10 Sep 2025 03:44:58 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 988173F66E;
	Wed, 10 Sep 2025 03:45:04 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH] arm64: mm: Move KPTI helpers to mmu.c
Date: Wed, 10 Sep 2025 11:44:54 +0100
Message-ID: <20250910104454.317067-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_kpti_ng_temp_pgd() is currently defined (as an alias) in
mmu.c without matching declaration in a header; instead cpufeature.c
makes its own declaration. This is clearly not pretty, and as commit
ceca927c86e6 ("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
function signature") showed, it also makes it very easy for the
prototypes to go out of sync.

All this would be much simpler if kpti_install_ng_mappings() and
associated functions lived in mmu.c, where they logically belong.
This is what this patch does:
- Move kpti_install_ng_mappings() and associated functions from
  cpufeature.c to mmu.c, add a declaration to <asm/mmu.h>
- Make create_kpti_ng_temp_pgd() a static function that simply calls
  __create_pgd_mapping_locked() instead of aliasing it
- Mark all these functions __init
- Move __initdata after kpti_ng_temp_alloc (as suggested by
  checkpatch)

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
Note: as things stand, create_kpti_ng_temp_pgd() could be removed,
but a separate patch [1] will make use of it to add an
assertion.

[1] https://lore.kernel.org/all/20250813145607.1612234-3-chaitanyas.prakash@arm.com/
---
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <kees@kernel.org>,
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/mmu.h   |   6 ++
 arch/arm64/kernel/cpufeature.c |  97 ------------------------------
 arch/arm64/mm/mmu.c            | 106 ++++++++++++++++++++++++++++++---
 3 files changed, 103 insertions(+), 106 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 49f1a810df16..624edd6c4964 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -104,5 +104,11 @@ static inline bool kaslr_requires_kpti(void)
 	return true;
 }
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+void kpti_install_ng_mappings(void);
+#else
+static inline void kpti_install_ng_mappings(void) {}
+#endif
+
 #endif	/* !__ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ef269a5a37e1..b99eaad48c14 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1940,103 +1940,6 @@ static bool has_pmuv3(const struct arm64_cpu_capabilities *entry, int scope)
 }
 #endif
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-#define KPTI_NG_TEMP_VA		(-(1UL << PMD_SHIFT))
-
-extern
-void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
-			     phys_addr_t size, pgprot_t prot,
-			     phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags);
-
-static phys_addr_t __initdata kpti_ng_temp_alloc;
-
-static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
-{
-	kpti_ng_temp_alloc -= PAGE_SIZE;
-	return kpti_ng_temp_alloc;
-}
-
-static int __init __kpti_install_ng_mappings(void *__unused)
-{
-	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
-	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
-	kpti_remap_fn *remap_fn;
-
-	int cpu = smp_processor_id();
-	int levels = CONFIG_PGTABLE_LEVELS;
-	int order = order_base_2(levels);
-	u64 kpti_ng_temp_pgd_pa = 0;
-	pgd_t *kpti_ng_temp_pgd;
-	u64 alloc = 0;
-
-	if (levels == 5 && !pgtable_l5_enabled())
-		levels = 4;
-	else if (levels == 4 && !pgtable_l4_enabled())
-		levels = 3;
-
-	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
-
-	if (!cpu) {
-		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
-		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
-		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
-
-		//
-		// Create a minimal page table hierarchy that permits us to map
-		// the swapper page tables temporarily as we traverse them.
-		//
-		// The physical pages are laid out as follows:
-		//
-		// +--------+-/-------+-/------ +-/------ +-\\\--------+
-		// :  PTE[] : | PMD[] : | PUD[] : | P4D[] : ||| PGD[]  :
-		// +--------+-\-------+-\------ +-\------ +-///--------+
-		//      ^
-		// The first page is mapped into this hierarchy at a PMD_SHIFT
-		// aligned virtual address, so that we can manipulate the PTE
-		// level entries while the mapping is active. The first entry
-		// covers the PTE[] page itself, the remaining entries are free
-		// to be used as a ad-hoc fixmap.
-		//
-		create_kpti_ng_temp_pgd(kpti_ng_temp_pgd, __pa(alloc),
-					KPTI_NG_TEMP_VA, PAGE_SIZE, PAGE_KERNEL,
-					kpti_ng_pgd_alloc, 0);
-	}
-
-	cpu_install_idmap();
-	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
-	cpu_uninstall_idmap();
-
-	if (!cpu) {
-		free_pages(alloc, order);
-		arm64_use_ng_mappings = true;
-	}
-
-	return 0;
-}
-
-static void __init kpti_install_ng_mappings(void)
-{
-	/* Check whether KPTI is going to be used */
-	if (!arm64_kernel_unmapped_at_el0())
-		return;
-
-	/*
-	 * We don't need to rewrite the page-tables if either we've done
-	 * it already or we have KASLR enabled and therefore have not
-	 * created any global mappings at all.
-	 */
-	if (arm64_use_ng_mappings)
-		return;
-
-	stop_machine(__kpti_install_ng_mappings, NULL, cpu_online_mask);
-}
-
-#else
-static inline void kpti_install_ng_mappings(void)
-{
-}
-#endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
-
 static void cpu_enable_kpti(struct arm64_cpu_capabilities const *cap)
 {
 	if (__this_cpu_read(this_cpu_vector) == vectors) {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 183801520740..eff3295393ee 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -27,6 +27,7 @@
 #include <linux/kfence.h>
 #include <linux/pkeys.h>
 #include <linux/mm_inline.h>
+#include <linux/stop_machine.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -466,14 +467,6 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	mutex_unlock(&fixmap_lock);
 }
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-extern __alias(__create_pgd_mapping_locked)
-void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
-			     phys_addr_t size, pgprot_t prot,
-			     phys_addr_t (*pgtable_alloc)(enum pgtable_type),
-			     int flags);
-#endif
-
 static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
 				       enum pgtable_type pgtable_type)
 {
@@ -735,7 +728,102 @@ static void __init declare_vma(struct vm_struct *vma,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-static pgprot_t kernel_exec_prot(void)
+#define KPTI_NG_TEMP_VA		(-(1UL << PMD_SHIFT))
+
+static phys_addr_t kpti_ng_temp_alloc __initdata;
+
+static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
+{
+	kpti_ng_temp_alloc -= PAGE_SIZE;
+	return kpti_ng_temp_alloc;
+}
+
+static void __init create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys,
+					   unsigned long virt, phys_addr_t size,
+					   pgprot_t prot,
+					   phys_addr_t (*pgtable_alloc)(enum pgtable_type),
+					   int flags)
+{
+	__create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
+				    pgtable_alloc, flags);
+}
+
+static int __init __kpti_install_ng_mappings(void *__unused)
+{
+	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
+	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
+	kpti_remap_fn *remap_fn;
+
+	int cpu = smp_processor_id();
+	int levels = CONFIG_PGTABLE_LEVELS;
+	int order = order_base_2(levels);
+	u64 kpti_ng_temp_pgd_pa = 0;
+	pgd_t *kpti_ng_temp_pgd;
+	u64 alloc = 0;
+
+	if (levels == 5 && !pgtable_l5_enabled())
+		levels = 4;
+	else if (levels == 4 && !pgtable_l4_enabled())
+		levels = 3;
+
+	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
+
+	if (!cpu) {
+		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
+		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
+		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
+
+		//
+		// Create a minimal page table hierarchy that permits us to map
+		// the swapper page tables temporarily as we traverse them.
+		//
+		// The physical pages are laid out as follows:
+		//
+		// +--------+-/-------+-/------ +-/------ +-\\\--------+
+		// :  PTE[] : | PMD[] : | PUD[] : | P4D[] : ||| PGD[]  :
+		// +--------+-\-------+-\------ +-\------ +-///--------+
+		//      ^
+		// The first page is mapped into this hierarchy at a PMD_SHIFT
+		// aligned virtual address, so that we can manipulate the PTE
+		// level entries while the mapping is active. The first entry
+		// covers the PTE[] page itself, the remaining entries are free
+		// to be used as a ad-hoc fixmap.
+		//
+		create_kpti_ng_temp_pgd(kpti_ng_temp_pgd, __pa(alloc),
+					KPTI_NG_TEMP_VA, PAGE_SIZE, PAGE_KERNEL,
+					kpti_ng_pgd_alloc, 0);
+	}
+
+	cpu_install_idmap();
+	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
+	cpu_uninstall_idmap();
+
+	if (!cpu) {
+		free_pages(alloc, order);
+		arm64_use_ng_mappings = true;
+	}
+
+	return 0;
+}
+
+void __init kpti_install_ng_mappings(void)
+{
+	/* Check whether KPTI is going to be used */
+	if (!arm64_kernel_unmapped_at_el0())
+		return;
+
+	/*
+	 * We don't need to rewrite the page-tables if either we've done
+	 * it already or we have KASLR enabled and therefore have not
+	 * created any global mappings at all.
+	 */
+	if (arm64_use_ng_mappings)
+		return;
+
+	stop_machine(__kpti_install_ng_mappings, NULL, cpu_online_mask);
+}
+
+static pgprot_t __init kernel_exec_prot(void)
 {
 	return rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
 }

base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
-- 
2.47.0



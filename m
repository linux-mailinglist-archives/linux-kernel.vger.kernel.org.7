Return-Path: <linux-kernel+bounces-650976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E157EAB9878
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 11:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C811BC388D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2EA22AE7A;
	Fri, 16 May 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdfdKfo2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA922FF39;
	Fri, 16 May 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386946; cv=none; b=uKSo9fGa6F78LCOSay1CQSJWPnclpFMssPo6bdDAconqrYmaNOvTu0vTAqfnv4zLhedfVofqAkWPkYyOCWg1FMRvH5k6oM3G7mD/uUHkoyIVXkQKZoKJj4SLbpfV00r4M5YO0+fqPzR5eoCmRo/3tx+1oVZhx5iEiow65QnGpS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386946; c=relaxed/simple;
	bh=jL+uCRUE8lDqeJXJnyY03TRBly9Cd5B13xMPh7t8+q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvtSc9FwVWxatMPBtYPAQ8uY6bN/BICT0FDrjHHA2jrc1YVopNs+bY3YIYkzW9eXgg46SBA1vBhLc16Q7qY9stKSh/gBPa1lqpJ6ZUUblMojktRlXHNJLpTHIyn2GZyTQRj0vlPATae9Pp6+/RZDugowluMI0G6QL3EvVob8wwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdfdKfo2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747386944; x=1778922944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jL+uCRUE8lDqeJXJnyY03TRBly9Cd5B13xMPh7t8+q0=;
  b=NdfdKfo2P+b/h++x5rvCkJZBeCM4PjRSrKyllBbYTrkOY+QX7ANCbcBv
   t4jivPgrPfsSWdmPHdjbr0cuFcQpQ23aV8+s45vykKf8jcJEY/MKw0EKg
   6kVTuhPtEquqM7JQ8qImCS+dg9rWtTRkOE8CqopWDkhCgeejmlL8s9/oA
   5mP0qjsbqbpc9gJrPDjC8vLgWXzmAuidKMeqA1LpiujxdWrFmfrAELLqC
   fg0vw6Y4yxk2doENPrnM14Y9QEuMR6os6A7VhceqUwKNUMR0UNBKSGWpp
   MKDbL5wv+TMEGEQXuDxmjywhRnZfe5PmC2GDC2OaTXq8sfEtT+7pnDLpA
   A==;
X-CSE-ConnectionGUID: QPn2o32yTr+PmqcPPTcSeg==
X-CSE-MsgGUID: REWOVGgiTUq5iI7uDoKSLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60375778"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="60375778"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:15:43 -0700
X-CSE-ConnectionGUID: pecmxtR4RASsa0Ai0aYm9w==
X-CSE-MsgGUID: 1NA7uBIDRT6IgNLNtW30TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138527544"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 16 May 2025 02:15:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2645D47A; Fri, 16 May 2025 12:15:37 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support unconditional
Date: Fri, 16 May 2025 12:15:33 +0300
Message-ID: <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both Intel and AMD CPUs support 5-level paging, which is expected to
become more widely adopted in the future.

Remove CONFIG_X86_5LEVEL and ifdeffery for it to make it more readable.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
---
 Documentation/arch/x86/cpuinfo.rst            |  8 +++----
 .../arch/x86/x86_64/5level-paging.rst         |  9 --------
 arch/x86/Kconfig                              | 22 +------------------
 arch/x86/Kconfig.cpufeatures                  |  4 ----
 arch/x86/boot/compressed/pgtable_64.c         | 11 ++--------
 arch/x86/boot/header.S                        |  4 ----
 arch/x86/boot/startup/map_kernel.c            |  5 +----
 arch/x86/include/asm/page_64.h                |  2 --
 arch/x86/include/asm/page_64_types.h          |  7 ------
 arch/x86/include/asm/pgtable_64_types.h       | 18 ---------------
 arch/x86/kernel/alternative.c                 |  2 +-
 arch/x86/kernel/head64.c                      |  2 --
 arch/x86/kernel/head_64.S                     |  2 --
 arch/x86/mm/init.c                            |  4 ----
 arch/x86/mm/pgtable.c                         |  2 +-
 drivers/firmware/efi/libstub/x86-5lvl.c       |  2 +-
 16 files changed, 10 insertions(+), 94 deletions(-)

diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index f80e2a558d2a..dd8b7806944e 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -173,10 +173,10 @@ For example, when an old kernel is running on new hardware.
 The kernel disabled support for it at compile-time
 --------------------------------------------------
 
-For example, if 5-level-paging is not enabled when building (i.e.,
-CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show up [#f1]_.
+For example, if Linear Address Masking (LAM) is not enabled when building (i.e.,
+CONFIG_ADDRESS_MASKING is not selected) the flag "lam" will not show up.
 Even though the feature will still be detected via CPUID, the kernel disables
-it by clearing via setup_clear_cpu_cap(X86_FEATURE_LA57).
+it by clearing via setup_clear_cpu_cap(X86_FEATURE_LAM).
 
 The feature is disabled at boot-time
 ------------------------------------
@@ -200,5 +200,3 @@ missing at runtime. For example, AVX flags will not show up if XSAVE feature
 is disabled since they depend on XSAVE feature. Another example would be broken
 CPUs and them missing microcode patches. Due to that, the kernel decides not to
 enable a feature.
-
-.. [#f1] 5-level paging uses linear address of 57 bits.
diff --git a/Documentation/arch/x86/x86_64/5level-paging.rst b/Documentation/arch/x86/x86_64/5level-paging.rst
index 71f882f4a173..ad7ddc13f79d 100644
--- a/Documentation/arch/x86/x86_64/5level-paging.rst
+++ b/Documentation/arch/x86/x86_64/5level-paging.rst
@@ -22,15 +22,6 @@ QEMU 2.9 and later support 5-level paging.
 Virtual memory layout for 5-level paging is described in
 Documentation/arch/x86/x86_64/mm.rst
 
-
-Enabling 5-level paging
-=======================
-CONFIG_X86_5LEVEL=y enables the feature.
-
-Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
-In this case additional page table level -- p4d -- will be folded at
-runtime.
-
 User-space and large virtual address space
 ==========================================
 On x86, 5-level paging enables 56-bit userspace virtual address space.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 45b36a019b5e..7aed3fa0e780 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -427,8 +427,7 @@ config DYNAMIC_PHYSICAL_MASK
 
 config PGTABLE_LEVELS
 	int
-	default 5 if X86_5LEVEL
-	default 4 if X86_64
+	default 5 if X86_64
 	default 3 if X86_PAE
 	default 2
 
@@ -1464,25 +1463,6 @@ config X86_PAE
 	  has the cost of more pagetable lookup overhead, and also
 	  consumes more pagetable space per process.
 
-config X86_5LEVEL
-	bool "Enable 5-level page tables support"
-	default y
-	depends on X86_64
-	help
-	  5-level paging enables access to larger address space:
-	  up to 128 PiB of virtual address space and 4 PiB of
-	  physical address space.
-
-	  It will be supported by future Intel CPUs.
-
-	  A kernel with the option enabled can be booted on machines that
-	  support 4- or 5-level paging.
-
-	  See Documentation/arch/x86/x86_64/5level-paging.rst for more
-	  information.
-
-	  Say N if unsure.
-
 config X86_DIRECT_GBPAGES
 	def_bool y
 	depends on X86_64
diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index e12d5b7e39a2..250c10627ab3 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -132,10 +132,6 @@ config X86_DISABLED_FEATURE_OSPKE
 	def_bool y
 	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
 
-config X86_DISABLED_FEATURE_LA57
-	def_bool y
-	depends on !X86_5LEVEL
-
 config X86_DISABLED_FEATURE_PTI
 	def_bool y
 	depends on !MITIGATION_PAGE_TABLE_ISOLATION
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 5a6c7a190e5b..bdd26050dff7 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -10,12 +10,10 @@
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
 
-#ifdef CONFIG_X86_5LEVEL
 /* __pgtable_l5_enabled needs to be in .data to avoid being cleared along with .bss */
 unsigned int __section(".data") __pgtable_l5_enabled;
 unsigned int __section(".data") pgdir_shift = 39;
 unsigned int __section(".data") ptrs_per_p4d = 1;
-#endif
 
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
@@ -114,18 +112,13 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	 * Check if LA57 is desired and supported.
 	 *
 	 * There are several parts to the check:
-	 *   - if the kernel supports 5-level paging: CONFIG_X86_5LEVEL=y
 	 *   - if user asked to disable 5-level paging: no5lvl in cmdline
 	 *   - if the machine supports 5-level paging:
 	 *     + CPUID leaf 7 is supported
 	 *     + the leaf has the feature bit set
-	 *
-	 * That's substitute for boot_cpu_has() in early boot code.
 	 */
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) &&
-			!cmdline_find_option_bool("no5lvl") &&
-			native_cpuid_eax(0) >= 7 &&
-			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
+	if (!cmdline_find_option_bool("no5lvl") &&
+	    native_cpuid_eax(0) >= 7 && (native_cpuid_ecx(7) & BIT(16))) {
 		l5_required = true;
 
 		/* Initialize variables for 5-level paging */
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9cb91421b4e4..e30649e44d8f 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -361,12 +361,8 @@ xloadflags:
 #endif
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_X86_5LEVEL
 #define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
 #else
-#define XLF56 XLF_5LEVEL
-#endif
-#else
 #define XLF56 0
 #endif
 
diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
index 905e8734b5a3..332dbe6688c4 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -16,9 +16,6 @@ extern unsigned int next_early_pgt;
 
 static inline bool check_la57_support(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
-		return false;
-
 	/*
 	 * 5-level paging is detected and enabled at kernel decompression
 	 * stage. Only check if it has been enabled there.
@@ -129,7 +126,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pgd = rip_rel_ptr(early_top_pgt);
 	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
 
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
+	if (la57) {
 		p4d = (p4dval_t *)rip_rel_ptr(level4_kernel_pgt);
 		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
 
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index d3aab6f4e59a..015d23f3e01f 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -62,7 +62,6 @@ static inline void clear_page(void *page)
 void copy_page(void *to, void *from);
 KCFI_REFERENCE(copy_page);
 
-#ifdef CONFIG_X86_5LEVEL
 /*
  * User space process size.  This is the first address outside the user range.
  * There are a few constraints that determine this:
@@ -93,7 +92,6 @@ static __always_inline unsigned long task_size_max(void)
 
 	return ret;
 }
-#endif	/* CONFIG_X86_5LEVEL */
 
 #endif	/* !__ASSEMBLER__ */
 
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 6b8c8169c71d..7400dab373fe 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -48,14 +48,7 @@
 /* See Documentation/arch/x86/x86_64/mm.rst for a description of the memory map. */
 
 #define __PHYSICAL_MASK_SHIFT	52
-
-#ifdef CONFIG_X86_5LEVEL
 #define __VIRTUAL_MASK_SHIFT	(pgtable_l5_enabled() ? 56 : 47)
-/* See task_size_max() in <asm/page_64.h> */
-#else
-#define __VIRTUAL_MASK_SHIFT	47
-#define task_size_max()		((_AC(1,UL) << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
-#endif
 
 #define TASK_SIZE_MAX		task_size_max()
 #define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index eee06f77b245..4604f924d8b8 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -23,7 +23,6 @@ typedef struct { pmdval_t pmd; } pmd_t;
 
 extern unsigned int __pgtable_l5_enabled;
 
-#ifdef CONFIG_X86_5LEVEL
 #ifdef USE_EARLY_PGTABLE_L5
 /*
  * cpu_feature_enabled() is not available in early boot code.
@@ -37,17 +36,11 @@ static inline bool pgtable_l5_enabled(void)
 #define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
 #endif /* USE_EARLY_PGTABLE_L5 */
 
-#else
-#define pgtable_l5_enabled() 0
-#endif /* CONFIG_X86_5LEVEL */
-
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
 #endif	/* !__ASSEMBLER__ */
 
-#ifdef CONFIG_X86_5LEVEL
-
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
@@ -65,17 +58,6 @@ extern unsigned int ptrs_per_p4d;
 
 #define MAX_POSSIBLE_PHYSMEM_BITS	52
 
-#else /* CONFIG_X86_5LEVEL */
-
-/*
- * PGDIR_SHIFT determines what a top-level page table entry can map
- */
-#define PGDIR_SHIFT		39
-#define PTRS_PER_PGD		512
-#define MAX_PTRS_PER_P4D	1
-
-#endif /* CONFIG_X86_5LEVEL */
-
 /*
  * 3rd level page
  */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 29572927f9c5..ecfe7b497cad 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -596,7 +596,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 
 	/*
-	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * KASAN_SHADOW_START is defined using
 	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
 	 * During the process, KASAN becomes confused seeing partial LA57
 	 * conversion and triggers a false-positive out-of-bound report.
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 9f617be64fa9..533fcf5636fc 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -51,13 +51,11 @@ unsigned int __initdata next_early_pgt;
 SYM_PIC_ALIAS(next_early_pgt);
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
-#ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled __ro_after_init;
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
-#endif
 
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 069420853304..3e9b3a3bd039 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -649,13 +649,11 @@ SYM_DATA_START_PTI_ALIGNED(init_top_pgt)
 SYM_DATA_END(init_top_pgt)
 #endif
 
-#ifdef CONFIG_X86_5LEVEL
 SYM_DATA_START_PAGE_ALIGNED(level4_kernel_pgt)
 	.fill	511,8,0
 	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 SYM_DATA_END(level4_kernel_pgt)
 SYM_PIC_ALIAS(level4_kernel_pgt)
-#endif
 
 SYM_DATA_START_PAGE_ALIGNED(level3_kernel_pgt)
 	.fill	L3_START_KERNEL,8,0
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index aa56d9ac0b8f..7456df985d96 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -174,11 +174,7 @@ __ref void *alloc_low_pages(unsigned int num)
  * randomization is enabled.
  */
 
-#ifndef CONFIG_X86_5LEVEL
-#define INIT_PGD_PAGE_TABLES    3
-#else
 #define INIT_PGD_PAGE_TABLES    4
-#endif
 
 #ifndef CONFIG_RANDOMIZE_MEMORY
 #define INIT_PGD_PAGE_COUNT      (2 * INIT_PGD_PAGE_TABLES)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 59c42dec7076..62777ba4de1a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -592,7 +592,7 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 }
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-#ifdef CONFIG_X86_5LEVEL
+#if CONFIG_PGTABLE_LEVELS > 4
 /**
  * p4d_set_huge - Set up kernel P4D mapping
  * @p4d: Pointer to the P4D entry
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index 77359e802181..f1c5fb45d5f7 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -62,7 +62,7 @@ efi_status_t efi_setup_5level_paging(void)
 
 void efi_5level_switch(void)
 {
-	bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
+	bool want_la57 = !efi_no5lvl;
 	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
 	bool need_toggle = want_la57 ^ have_la57;
 	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
-- 
2.47.2



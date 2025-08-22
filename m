Return-Path: <linux-kernel+bounces-781095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA47B30D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730781882682
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26F290DBB;
	Fri, 22 Aug 2025 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdl4CyyM"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EC28C878
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836348; cv=none; b=k9VtCy88LCxmK8ZSRFSUl8bL9x3gwXF7yWmRylQr0gtnMIQC4O9NflDt6QTpVxl8NSA6pLIVYgLjyM83Fyu/Joly9Vd3ymNWFEl5mG6CJyXMSLaY9I3ORJ0O4q0MIUENxRlRgUqFhCEPX+ZGZggK1++V8tPpId0xR2kdeEHO79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836348; c=relaxed/simple;
	bh=57QzwA7Fd6AsftIWENPip3kRvCH+AoAdRE1Aa9JfmUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA7RMps1wMhFsJGOVTXGekLMBG6d3FivCQcKlrebz0lqaynsuSb3L56XCbnqbqRx6eEuF/b8UHBkStw+Yg9+pNimkxlt0IQs8ZHw0BLHOnuyjejxZc3+jte3EguilJ+htjFsVKa5HhpLrkrUHLAin9fuY3i5zmHZa+hQ44DDp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jdl4CyyM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e67c95so1922277a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755836345; x=1756441145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcM18VY1tENoNDxX/DPNjvebKkwkKLOrpMH6jQw8TJM=;
        b=Jdl4CyyMFrwdduR987l4LAsmPgwBluPk69lRdX9e9djYpFBZYwu/YQCMLjyDY9duNh
         C8NPj3SFVBXc5n800Fkr2PQ4iTLSRWE9mkwIhYbUAnv/2DntLguC5/OKEw90QIcinK69
         PWHr8Hs9jG5BAdGXxYAsKY5Z3OBVSGomB+L764dz17iaVGmNCsBSHIUouCbuqpbEvnmt
         fIeUHlpkXT6D32U6F4/dxcqHng6BXRHvjgosRGXHk1eC1Bb3pjLv0TRD5BWwGV/CC+gl
         brqFz9AugdDFsYixnuO92RnkeU9/EJCEzhH2fwQILnzAv+H4mKGnHs81VXvDc5jZMdBA
         tNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836345; x=1756441145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcM18VY1tENoNDxX/DPNjvebKkwkKLOrpMH6jQw8TJM=;
        b=adtM/Bg9d9cNZ3pI+/w4iNxJzHJ4/zBaEPn0G6bvFhDZXsvuZUP9tjMZYhJsGdTfn4
         4lxvb0qraBcV5KRRQMuqKY6jCJDo0rJ8a9fFV7QdONE4v89RRWp2uduBKrHtflVFnJL7
         q04tSwjWwgCjYoay/3IyZsPNJcf4lQs/6Byax1c2bZLFEnHoS5DsH+Fwm8nEUAVQsLrQ
         qhOY48uxrO9O3tZJv2zHnjUmXKuGguIOp4LBeScGa4OwSMtUuDKxjXsS/hEsDRUUspVt
         f71ShyWs7gNeHDx5QVuTlED3xIuwJcjzsc++8BTdsb6wSbSXxpI2yRC5qZOrs7tUHm/w
         Ek3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvzaZR+e/3hdzni2wKeKGXdNQ9UHNSwB5X7slmD8EtFeO4/yhRKcL6knyYzPsSTAL/Oe4fxkuNBBpan/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx55Rg4NPa7WmFfJytt3gIggOJQyyam4bsCFMNw7xSYnvSp+CQH
	UnrBBvMpNttee5VuaJE5LubKPJ0eVmtt+BcjRw0CUXaZrNbf7vZC2L0NHQxwWSBD49E=
X-Gm-Gg: ASbGncsJi0Re4N6S8ekNVfH8s/tOE8lmP5aspV+fnKQF35Pns1tbUw+NtJXdAsd43Fg
	WgC6ZUh97OHrCVJ5CTfEN3kNdRu3ajBdgLdu7bsY6AD2s21etQZNzfr62sbDXo/dJUhhO/VM3ud
	SbA1BG5E28nSMmoVZytSyYittDJrToXTFg7/0a7ybHx0/leo86zjK3bycyaKVghcgygMM77F+wp
	bAsMz2oXoij2rDK6sXtx3cvAMn5oBXW4cvNSUThoGwRcqNlz4TVOM0KiN1ubonSMAAscem3C1Ga
	HUvrb9AhR03iz9ILlGfsWzmbsnz2hiNpKSgH4FXMLZsqscnRPR7WlsU7YYN8lmECsEKdywSweuw
	NQEbWqJEU80jcDu+XhZChIn6CN7/rjq4QhMBhkhL0fUqjsYITCII1d+VND4q1Fw==
X-Google-Smtp-Source: AGHT+IHIfEZOEC0dksw3gI4Fl8FoMSKbicJ0AzsNuk/fKbqFNpOqq7Ob9OmAurZWLS5oTpjVRA2aEA==
X-Received: by 2002:a17:90b:1d06:b0:321:2f06:d3ab with SMTP id 98e67ed59e1d1-32515eab619mr2529581a91.21.1755836345417;
        Thu, 21 Aug 2025 21:19:05 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:ba38:b533:dcf5:1e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1375a3sm9534559b3a.43.2025.08.21.21.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:19:04 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 3/3] arm64: mm: Represent physical memory with phys_addr_t and resource_size_t
Date: Thu, 21 Aug 2025 21:15:38 -0700
Message-ID: <20250822041538.467514-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250822041538.467514-1-CFSworks@gmail.com>
References: <20250822041538.467514-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a type-correctness cleanup to MMU/boot code that replaces
several instances of void * and u64 with phys_addr_t (to represent
addresses) and resource_size_t (to represent sizes) to emphasize that
the code in question concerns physical memory specifically.

The rationale for this change is to improve clarity and readability in
a few modules that handle both types (physical and virtual) of address
and differentiation is essential.

I have left u64 in cases where the address may be either physical or
virtual, where the address is exclusively virtual but used in heavy
pointer arithmetic, and in cases I may have overlooked. I do not
necessarily consider u64 the ideal type in those situations, but it
avoids breaking existing semantics in this cleanup.

This patch provably has no effect at runtime: I have verified that
.text of vmlinux is identical after this change.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/kernel/pi/map_kernel.c | 26 +++++++++++++-------------
 arch/arm64/kernel/pi/map_range.c  | 20 ++++++++++++--------
 arch/arm64/kernel/pi/pi.h         |  9 +++++----
 arch/arm64/mm/init.c              |  6 +++---
 arch/arm64/mm/mmu.c               | 17 +++++++++--------
 5 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index 5dc4107b5a7f..deb15074d289 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -18,9 +18,9 @@
 
 extern const u8 __eh_frame_start[], __eh_frame_end[];
 
-extern void idmap_cpu_replace_ttbr1(void *pgdir);
+extern void idmap_cpu_replace_ttbr1(phys_addr_t pgdir);
 
-static void __init map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
+static void __init map_segment(pgd_t *pg_dir, phys_addr_t *pgd, u64 va_offset,
 			       void *start, void *end, pgprot_t prot,
 			       bool may_use_cont, int root_level)
 {
@@ -40,7 +40,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 {
 	bool enable_scs = IS_ENABLED(CONFIG_UNWIND_PATCH_PAC_INTO_SCS);
 	bool twopass = IS_ENABLED(CONFIG_RELOCATABLE);
-	u64 pgdp = (u64)init_pg_dir + PAGE_SIZE;
+	phys_addr_t pgdp = (phys_addr_t)init_pg_dir + PAGE_SIZE;
 	pgprot_t text_prot = PAGE_KERNEL_ROX;
 	pgprot_t data_prot = PAGE_KERNEL;
 	pgprot_t prot;
@@ -90,7 +90,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 		    true, root_level);
 	dsb(ishst);
 
-	idmap_cpu_replace_ttbr1(init_pg_dir);
+	idmap_cpu_replace_ttbr1((phys_addr_t)init_pg_dir);
 
 	if (twopass) {
 		if (IS_ENABLED(CONFIG_RELOCATABLE))
@@ -129,10 +129,10 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 	/* Copy the root page table to its final location */
 	memcpy((void *)swapper_pg_dir + va_offset, init_pg_dir, PAGE_SIZE);
 	dsb(ishst);
-	idmap_cpu_replace_ttbr1(swapper_pg_dir);
+	idmap_cpu_replace_ttbr1((phys_addr_t)swapper_pg_dir);
 }
 
-static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
+static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(phys_addr_t ttbr)
 {
 	u64 sctlr = read_sysreg(sctlr_el1);
 	u64 tcr = read_sysreg(tcr_el1) | TCR_DS;
@@ -172,7 +172,7 @@ static void __init remap_idmap_for_lpa2(void)
 	 */
 	create_init_idmap(init_pg_dir, mask);
 	dsb(ishst);
-	set_ttbr0_for_lpa2((u64)init_pg_dir);
+	set_ttbr0_for_lpa2((phys_addr_t)init_pg_dir);
 
 	/*
 	 * Recreate the initial ID map with the same granularity as before.
@@ -185,17 +185,17 @@ static void __init remap_idmap_for_lpa2(void)
 	dsb(ishst);
 
 	/* switch back to the updated initial ID map */
-	set_ttbr0_for_lpa2((u64)init_idmap_pg_dir);
+	set_ttbr0_for_lpa2((phys_addr_t)init_idmap_pg_dir);
 
 	/* wipe the temporary ID map from memory */
 	memset(init_pg_dir, 0, (char *)init_pg_end - (char *)init_pg_dir);
 }
 
-static void *__init map_fdt(u64 fdt)
+static void *__init map_fdt(phys_addr_t fdt)
 {
 	static u8 ptes[INIT_IDMAP_FDT_SIZE] __initdata __aligned(PAGE_SIZE);
-	u64 efdt = fdt + MAX_FDT_SIZE;
-	u64 ptep = (u64)ptes;
+	phys_addr_t efdt = fdt + MAX_FDT_SIZE;
+	phys_addr_t ptep = (phys_addr_t)ptes; /* Stack is idmapped */
 
 	/*
 	 * Map up to MAX_FDT_SIZE bytes, but avoid overlap with
@@ -232,7 +232,7 @@ static bool __init ng_mappings_allowed(void)
 	return true;
 }
 
-asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
+asmlinkage void __init early_map_kernel(u64 boot_status, phys_addr_t fdt)
 {
 	static char const chosen_str[] __initconst = "/chosen";
 	u64 va_base, pa_base = (u64)&_text;
@@ -240,7 +240,7 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 	int root_level = 4 - CONFIG_PGTABLE_LEVELS;
 	int va_bits = VA_BITS;
 	int chosen;
-	void *fdt_mapped = map_fdt((u64)fdt);
+	void *fdt_mapped = map_fdt(fdt);
 
 	/* Clear BSS and the initial page tables */
 	memset(__bss_start, 0, (char *)init_pg_end - (char *)__bss_start);
diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index 7982788e7b9a..de52cd85c691 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -26,8 +26,9 @@
  * @va_offset:		Offset between a physical page and its current mapping
  * 			in the VA space
  */
-void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
-		      int level, pte_t *tbl, bool may_use_cont, u64 va_offset)
+void __init map_range(phys_addr_t *pte, u64 start, u64 end, phys_addr_t pa,
+		      pgprot_t prot, int level, pte_t *tbl, bool may_use_cont,
+		      u64 va_offset)
 {
 	u64 cmask = (level == 3) ? CONT_PTE_SIZE - 1 : U64_MAX;
 	ptdesc_t protval = pgprot_val(prot) & ~PTE_TYPE_MASK;
@@ -87,19 +88,22 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 	}
 }
 
-asmlinkage u64 __init create_init_idmap(pgd_t *pg_dir, ptdesc_t clrmask)
+asmlinkage phys_addr_t __init create_init_idmap(pgd_t *pg_dir, ptdesc_t clrmask)
 {
-	u64 ptep = (u64)pg_dir + PAGE_SIZE;
+	phys_addr_t ptep = (phys_addr_t)pg_dir + PAGE_SIZE; /* MMU is off */
 	pgprot_t text_prot = PAGE_KERNEL_ROX;
 	pgprot_t data_prot = PAGE_KERNEL;
 
 	pgprot_val(text_prot) &= ~clrmask;
 	pgprot_val(data_prot) &= ~clrmask;
 
-	map_range(&ptep, (u64)_stext, (u64)__initdata_begin, (u64)_stext,
-		  text_prot, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0);
-	map_range(&ptep, (u64)__initdata_begin, (u64)_end, (u64)__initdata_begin,
-		  data_prot, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0);
+	/* MMU is off; pointer casts to phys_addr_t are safe */
+	map_range(&ptep, (u64)_stext, (u64)__initdata_begin,
+		  (phys_addr_t)_stext, text_prot, IDMAP_ROOT_LEVEL,
+		  (pte_t *)pg_dir, false, 0);
+	map_range(&ptep, (u64)__initdata_begin, (u64)_end,
+		  (phys_addr_t)__initdata_begin, data_prot, IDMAP_ROOT_LEVEL,
+		  (pte_t *)pg_dir, false, 0);
 
 	return ptep;
 }
diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
index 46cafee7829f..08ef9f80456b 100644
--- a/arch/arm64/kernel/pi/pi.h
+++ b/arch/arm64/kernel/pi/pi.h
@@ -29,9 +29,10 @@ u64 kaslr_early_init(void *fdt, int chosen);
 void relocate_kernel(u64 offset);
 int scs_patch(const u8 eh_frame[], int size);
 
-void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
-	       int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
+void map_range(phys_addr_t *pte, u64 start, u64 end, phys_addr_t pa,
+	       pgprot_t prot, int level, pte_t *tbl, bool may_use_cont,
+	       u64 va_offset);
 
-asmlinkage void early_map_kernel(u64 boot_status, void *fdt);
+asmlinkage void early_map_kernel(u64 boot_status, phys_addr_t fdt);
 
-asmlinkage u64 create_init_idmap(pgd_t *pgd, ptdesc_t clrmask);
+asmlinkage phys_addr_t create_init_idmap(pgd_t *pgd, ptdesc_t clrmask);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ea84a61ed508..70c2ca813c18 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -243,7 +243,7 @@ void __init arm64_memblock_init(void)
 	 */
 	if (memory_limit != PHYS_ADDR_MAX) {
 		memblock_mem_limit_remove_map(memory_limit);
-		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
+		memblock_add(__pa_symbol(_text), (resource_size_t)(_end - _text));
 	}
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
@@ -252,8 +252,8 @@ void __init arm64_memblock_init(void)
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = phys_initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(phys_initrd_start + phys_initrd_size) - base;
+		phys_addr_t base = phys_initrd_start & PAGE_MASK;
+		resource_size_t size = PAGE_ALIGN(phys_initrd_start + phys_initrd_size) - base;
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 34e5d78af076..de463040582c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -794,17 +794,18 @@ static void __init declare_kernel_vmas(void)
 	declare_vma(&vmlinux_seg[4], _data, _end, 0);
 }
 
-void __pi_map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
-		    int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
+void __pi_map_range(phys_addr_t *pte, u64 start, u64 end, phys_addr_t pa,
+		    pgprot_t prot, int level, pte_t *tbl, bool may_use_cont,
+		    u64 va_offset);
 
 static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
 	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
 
 static void __init create_idmap(void)
 {
-	u64 start = __pa_symbol(__idmap_text_start);
-	u64 end   = __pa_symbol(__idmap_text_end);
-	u64 ptep  = __pa_symbol(idmap_ptes);
+	phys_addr_t start = __pa_symbol(__idmap_text_start);
+	phys_addr_t end   = __pa_symbol(__idmap_text_end);
+	phys_addr_t ptep  = __pa_symbol(idmap_ptes);
 
 	__pi_map_range(&ptep, start, end, start, PAGE_KERNEL_ROX,
 		       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
@@ -812,7 +813,7 @@ static void __init create_idmap(void)
 
 	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) && !arm64_use_ng_mappings) {
 		extern u32 __idmap_kpti_flag;
-		u64 pa = __pa_symbol(&__idmap_kpti_flag);
+		phys_addr_t pa = __pa_symbol(&__idmap_kpti_flag);
 
 		/*
 		 * The KPTI G-to-nG conversion code needs a read-write mapping
@@ -1331,8 +1332,8 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 struct range arch_get_mappable_range(void)
 {
 	struct range mhp_range;
-	u64 start_linear_pa = __pa(_PAGE_OFFSET(vabits_actual));
-	u64 end_linear_pa = __pa(PAGE_END - 1);
+	phys_addr_t start_linear_pa = __pa(_PAGE_OFFSET(vabits_actual));
+	phys_addr_t end_linear_pa = __pa(PAGE_END - 1);
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		/*
-- 
2.49.1



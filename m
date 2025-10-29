Return-Path: <linux-kernel+bounces-876261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896BC1B1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8B9F5A5CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D0B21420B;
	Wed, 29 Oct 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YPWJXF1O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0313559E5;
	Wed, 29 Oct 2025 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745358; cv=none; b=IKvPrAZwA9evDXMu7sR83oxSsAaZK9gQkUz/SdI79NsftzMFoKI1fuSRDeVzhl93paYttihnvImphTvGg/RbTdwHlCFG0JvNuqQrnwRA3Hir1oMFAATl292AmiGdk5zRSH/I5BOvYFevJAS6sUJAY0uMsfXsSYH4D5f2fwMB6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745358; c=relaxed/simple;
	bh=czapEAqwxgSsMdTDkJ4zxUmYh3/pZ1jRSVMkwZl8Nqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EybAHTHI3ugxmkVZ+aoEmq06LxagXXUUBT74GxmtOFaViu0ZeWN/uhdBfwjlStIBxZhO8yEfnXDoFx2R+VGYIKjL1Iqjf0ntlq6gcvafi/Pn2y4MRCHsY/kGAEOs4zhKWLDA93Xh9+8ZkhWBpYkQQzuOrU34po+GiPna5ImHHn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YPWJXF1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463C7C4CEF7;
	Wed, 29 Oct 2025 13:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761745358;
	bh=czapEAqwxgSsMdTDkJ4zxUmYh3/pZ1jRSVMkwZl8Nqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPWJXF1OPXyXlYMcTMgrXyk/154oqRa9ht9rf0/+DK84ahSzUhjBxapYrbqsbPhgG
	 rxFygxqZxrIJoyZw7uA2bw54Oa09endqAFpxuDKEwB9GoEZ1/9gmiFbWKkqJvP1Krh
	 T+Yy7d1uPxjy3vG3r5jUiK6g0yL6BhkOs0y/mtog=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.56
Date: Wed, 29 Oct 2025 14:41:55 +0100
Message-ID: <2025102955-purplish-curve-2fdb@gregkh>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102954-afford-herself-8e53@gregkh>
References: <2025102954-afford-herself-8e53@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
index 9ea1e4cd0709..69be6affa9b5 100644
--- a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
@@ -85,13 +85,21 @@ required:
   - reg
   - "#address-cells"
   - "#size-cells"
-  - dma-ranges
   - ranges
   - clocks
   - clock-names
   - interrupts
   - power-domains
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: fsl,imx8mp-dwc3
+    then:
+      required:
+        - dma-ranges
+
 additionalProperties: false
 
 examples:
diff --git a/Makefile b/Makefile
index d4c679b2d4bc..a1e3d73c5b74 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 55
+SUBLEVEL = 56
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
@@ -1372,11 +1372,11 @@ endif
 
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
+	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
+	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
 # ---------------------------------------------------------------------------
 # Kernel selftest
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 447bfa060918..209f99b1ceae 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -263,6 +263,9 @@ gicv2: interrupt-controller@7fff9000 {
 			      <0x7fffc000 0x2000>,
 			      <0x7fffe000 0x2000>;
 			interrupt-controller;
+			#address-cells = <0>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+					IRQ_TYPE_LEVEL_HIGH)>;
 			#interrupt-cells = <3>;
 		};
 	};
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5ba8376735cb..eb57ddb5ecc5 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -212,7 +212,8 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
-	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
+	if (pte_sw_dirty(pte))
+		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
 	return pte;
 }
 
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a7bb20055ce0..9e734d6314e0 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -25,8 +25,13 @@ void copy_highpage(struct page *to, struct page *from)
 		page_kasan_tag_reset(to);
 
 	if (system_supports_mte() && page_mte_tagged(from)) {
-		/* It's a new page, shouldn't have been tagged yet */
-		WARN_ON_ONCE(!try_page_mte_tagging(to));
+		/*
+		 * Most of the time it's a new page that shouldn't have been
+		 * tagged yet. However, folio migration can end up reusing the
+		 * same page without untagging it. Ignore the warning if the
+		 * page is already tagged.
+		 */
+		try_page_mte_tagging(to);
 		mte_copy_page_tags(kto, kfrom);
 		set_page_mte_tagged(to);
 	}
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 362bcfa0aed1..5127d3d3b867 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1213,7 +1213,7 @@ UnsignedEnum	43:40	TraceFilt
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-UnsignedEnum	39:36	DoubleLock
+SignedEnum	39:36	DoubleLock
 	0b0000	IMP
 	0b1111	NI
 EndEnum
@@ -1861,7 +1861,7 @@ UnsignedEnum	11:8	ASID2
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-SignedEnum	7:4	EIESB
+UnsignedEnum	7:4	EIESB
 	0b0000	NI
 	0b0001	ToEL3
 	0b0010	ToELx
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 14c64a6f1217..50ec92651d5a 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -350,12 +350,12 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 #include <asm-generic/bitops/ffz.h>
 #else
 
-static inline int find_first_zero_bit(const unsigned long *vaddr,
-				      unsigned size)
+static inline unsigned long find_first_zero_bit(const unsigned long *vaddr,
+						unsigned long size)
 {
 	const unsigned long *p = vaddr;
-	int res = 32;
-	unsigned int words;
+	unsigned long res = 32;
+	unsigned long words;
 	unsigned long num;
 
 	if (!size)
@@ -376,8 +376,9 @@ static inline int find_first_zero_bit(const unsigned long *vaddr,
 }
 #define find_first_zero_bit find_first_zero_bit
 
-static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
-				     int offset)
+static inline unsigned long find_next_zero_bit(const unsigned long *vaddr,
+					       unsigned long size,
+					       unsigned long offset)
 {
 	const unsigned long *p = vaddr + (offset >> 5);
 	int bit = offset & 31UL, res;
@@ -406,11 +407,12 @@ static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
 }
 #define find_next_zero_bit find_next_zero_bit
 
-static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
+static inline unsigned long find_first_bit(const unsigned long *vaddr,
+					   unsigned long size)
 {
 	const unsigned long *p = vaddr;
-	int res = 32;
-	unsigned int words;
+	unsigned long res = 32;
+	unsigned long words;
 	unsigned long num;
 
 	if (!size)
@@ -431,8 +433,9 @@ static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
 }
 #define find_first_bit find_first_bit
 
-static inline int find_next_bit(const unsigned long *vaddr, int size,
-				int offset)
+static inline unsigned long find_next_bit(const unsigned long *vaddr,
+					  unsigned long size,
+					  unsigned long offset)
 {
 	const unsigned long *p = vaddr + (offset >> 5);
 	int bit = offset & 31UL, res;
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 3a2836e9d856..2a3fd8bbf6c2 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -47,7 +47,7 @@ static struct resource standard_io_resources[] = {
 		.name = "keyboard",
 		.start = 0x60,
 		.end = 0x6f,
-		.flags = IORESOURCE_IO | IORESOURCE_BUSY
+		.flags = IORESOURCE_IO
 	},
 	{
 		.name = "dma page reg",
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index da122a5fa43b..8528ab1f222c 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -142,6 +142,20 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 	*max_high = PFN_DOWN(memblock_end_of_DRAM());
 }
 
+static void __init adjust_lowmem_bounds(void)
+{
+	phys_addr_t block_start, block_end;
+	u64 i;
+	phys_addr_t memblock_limit = 0;
+
+	for_each_mem_range(i, &block_start, &block_end) {
+		if (block_end > memblock_limit)
+			memblock_limit = block_end;
+	}
+
+	memblock_set_current_limit(memblock_limit);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	console_verbose();
@@ -155,6 +169,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Keep a copy of command line */
 	*cmdline_p = boot_command_line;
 
+	adjust_lowmem_bounds();
 	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
 	max_mapnr = max_low_pfn;
 
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 2f72ad885332..2ec5431ce1be 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -20,18 +20,6 @@ struct mm_struct;
 #include <asm/nohash/pgtable.h>
 #endif /* !CONFIG_PPC_BOOK3S */
 
-/*
- * Protection used for kernel text. We want the debuggers to be able to
- * set breakpoints anywhere, so don't write protect the kernel text
- * on platforms where such control is possible.
- */
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
-#else
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
-#endif
-
 /* Make modules code happy. We don't set RO yet */
 #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
 
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 2db167f4233f..507e2ef50bd7 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -204,7 +204,7 @@ int mmu_mark_initmem_nx(void)
 
 	for (i = 0; i < nb - 1 && base < top;) {
 		size = bat_block_size(base, top);
-		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
 		base += size;
 	}
 	if (base < top) {
@@ -215,7 +215,7 @@ int mmu_mark_initmem_nx(void)
 				pr_warn("Some RW data is getting mapped X. "
 					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
 		}
-		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
 		base += size;
 	}
 	for (; i < nb; i++)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 787b22206386..e52d036c7a83 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -109,7 +109,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 	p = memstart_addr + s;
 	for (; s < top; s += PAGE_SIZE) {
 		ktext = core_kernel_text(v);
-		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
+		map_kernel_page(v, p, ktext ? PAGE_KERNEL_X : PAGE_KERNEL);
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
 	}
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 03881122506a..87c7d94c71f1 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -655,6 +655,8 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+#define pgprot_dmacoherent pgprot_writecombine
+
 /*
  * THP functions
  */
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index f6b13e9f5e6c..3dbc8cc557dd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -62,10 +62,8 @@ int __init riscv_early_of_processor_hartid(struct device_node *node, unsigned lo
 		return -ENODEV;
 	}
 
-	if (!of_device_is_available(node)) {
-		pr_info("CPU with hartid=%lu is not available\n", *hart);
+	if (!of_device_is_available(node))
 		return -ENODEV;
-	}
 
 	if (of_property_read_string(node, "riscv,isa-base", &isa))
 		goto old_interface;
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cea0ca2bf2a2..fc62548888c5 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -25,6 +25,11 @@ static void hwprobe_arch_id(struct riscv_hwprobe *pair,
 	bool first = true;
 	int cpu;
 
+	if (pair->key != RISCV_HWPROBE_KEY_MVENDORID &&
+	    pair->key != RISCV_HWPROBE_KEY_MIMPID &&
+	    pair->key != RISCV_HWPROBE_KEY_MARCHID)
+		goto out;
+
 	for_each_cpu(cpu, cpus) {
 		u64 cpu_id;
 
@@ -55,6 +60,7 @@ static void hwprobe_arch_id(struct riscv_hwprobe *pair,
 		}
 	}
 
+out:
 	pair->value = id;
 }
 
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index f5dece935353..a2ec82ec78ac 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -43,9 +43,13 @@ __initcall(page_table_register_sysctl);
 
 unsigned long *crst_table_alloc(struct mm_struct *mm)
 {
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, CRST_ALLOC_ORDER);
+	gfp_t gfp = GFP_KERNEL_ACCOUNT;
+	struct ptdesc *ptdesc;
 	unsigned long *table;
 
+	if (mm == &init_mm)
+		gfp &= ~__GFP_ACCOUNT;
+	ptdesc = pagetable_alloc(gfp, CRST_ALLOC_ORDER);
 	if (!ptdesc)
 		return NULL;
 	table = ptdesc_to_virt(ptdesc);
@@ -142,7 +146,7 @@ struct ptdesc *page_table_alloc_pgste(struct mm_struct *mm)
 	struct ptdesc *ptdesc;
 	u64 *table;
 
-	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, 0);
 	if (ptdesc) {
 		table = (u64 *)ptdesc_to_virt(ptdesc);
 		__arch_set_page_dat(table, 1);
@@ -161,10 +165,13 @@ void page_table_free_pgste(struct ptdesc *ptdesc)
 
 unsigned long *page_table_alloc(struct mm_struct *mm)
 {
+	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct ptdesc *ptdesc;
 	unsigned long *table;
 
-	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	if (mm == &init_mm)
+		gfp &= ~__GFP_ACCOUNT;
+	ptdesc = pagetable_alloc(gfp, 0);
 	if (!ptdesc)
 		return NULL;
 	if (!pagetable_pte_ctor(ptdesc)) {
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 910accfeb785..5d2949b1e4b3 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -182,7 +182,7 @@ static bool need_sha_check(u32 cur_rev)
 	}
 
 	switch (cur_rev >> 8) {
-	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x80012: return cur_rev <= 0x8001277; break;
 	case 0x80082: return cur_rev <= 0x800820f; break;
 	case 0x83010: return cur_rev <= 0x830107c; break;
 	case 0x86001: return cur_rev <= 0x860010e; break;
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 58b02e4b254b..544964c9c530 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -95,6 +95,11 @@ acpi_tb_print_table_header(acpi_physical_address address,
 {
 	struct acpi_table_header local_header;
 
+#pragma GCC diagnostic push
+#if defined(__GNUC__) && __GNUC__ >= 11
+#pragma GCC diagnostic ignored "-Wstringop-overread"
+#endif
+
 	if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) {
 
 		/* FACS only has signature and length fields */
@@ -135,4 +140,5 @@ acpi_tb_print_table_header(acpi_physical_address address,
 			   local_header.asl_compiler_id,
 			   local_header.asl_compiler_revision));
 	}
+#pragma GCC diagnostic pop
 }
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bdf09e8b898d..186c182fd656 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -846,17 +846,8 @@ static int binder_inc_node_nilocked(struct binder_node *node, int strong,
 	} else {
 		if (!internal)
 			node->local_weak_refs++;
-		if (!node->has_weak_ref && list_empty(&node->work.entry)) {
-			if (target_list == NULL) {
-				pr_err("invalid inc weak node for %d\n",
-					node->debug_id);
-				return -EINVAL;
-			}
-			/*
-			 * See comment above
-			 */
+		if (!node->has_weak_ref && target_list && list_empty(&node->work.entry))
 			binder_enqueue_work_ilocked(&node->work, target_list);
-		}
 	}
 	return 0;
 }
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 3ebe77566788..176429904d39 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -341,7 +341,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		 * frequency (by keeping the initial capacity_freq_ref value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
+		if (!IS_ERR_OR_NULL(cpu_clk)) {
 			per_cpu(capacity_freq_ref, cpu) =
 				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
 			clk_put(cpu_clk);
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index c795edad1b96..e9a8bd9b20ea 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -23,50 +23,46 @@ struct devcd_entry {
 	void *data;
 	size_t datalen;
 	/*
-	 * Here, mutex is required to serialize the calls to del_wk work between
-	 * user/kernel space which happens when devcd is added with device_add()
-	 * and that sends uevent to user space. User space reads the uevents,
-	 * and calls to devcd_data_write() which try to modify the work which is
-	 * not even initialized/queued from devcoredump.
+	 * There are 2 races for which mutex is required.
 	 *
+	 * The first race is between device creation and userspace writing to
+	 * schedule immediately destruction.
 	 *
+	 * This race is handled by arming the timer before device creation, but
+	 * when device creation fails the timer still exists.
 	 *
-	 *        cpu0(X)                                 cpu1(Y)
+	 * To solve this, hold the mutex during device_add(), and set
+	 * init_completed on success before releasing the mutex.
 	 *
-	 *        dev_coredump() uevent sent to user space
-	 *        device_add()  ======================> user space process Y reads the
-	 *                                              uevents writes to devcd fd
-	 *                                              which results into writes to
+	 * That way the timer will never fire until device_add() is called,
+	 * it will do nothing if init_completed is not set. The timer is also
+	 * cancelled in that case.
 	 *
-	 *                                             devcd_data_write()
-	 *                                               mod_delayed_work()
-	 *                                                 try_to_grab_pending()
-	 *                                                   del_timer()
-	 *                                                     debug_assert_init()
-	 *       INIT_DELAYED_WORK()
-	 *       schedule_delayed_work()
-	 *
-	 *
-	 * Also, mutex alone would not be enough to avoid scheduling of
-	 * del_wk work after it get flush from a call to devcd_free()
-	 * mentioned as below.
-	 *
-	 *	disabled_store()
-	 *        devcd_free()
-	 *          mutex_lock()             devcd_data_write()
-	 *          flush_delayed_work()
-	 *          mutex_unlock()
-	 *                                   mutex_lock()
-	 *                                   mod_delayed_work()
-	 *                                   mutex_unlock()
-	 * So, delete_work flag is required.
+	 * The second race involves multiple parallel invocations of devcd_free(),
+	 * add a deleted flag so only 1 can call the destructor.
 	 */
 	struct mutex mutex;
-	bool delete_work;
+	bool init_completed, deleted;
 	struct module *owner;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
 	void (*free)(void *data);
+	/*
+	 * If nothing interferes and device_add() was returns success,
+	 * del_wk will destroy the device after the timer fires.
+	 *
+	 * Multiple userspace processes can interfere in the working of the timer:
+	 * - Writing to the coredump will reschedule the timer to run immediately,
+	 *   if still armed.
+	 *
+	 *   This is handled by using "if (cancel_delayed_work()) {
+	 *   schedule_delayed_work() }", to prevent re-arming after having
+	 *   been previously fired.
+	 * - Writing to /sys/class/devcoredump/disabled will destroy the
+	 *   coredump synchronously.
+	 *   This is handled by using disable_delayed_work_sync(), and then
+	 *   checking if deleted flag is set with &devcd->mutex held.
+	 */
 	struct delayed_work del_wk;
 	struct device *failing_dev;
 };
@@ -95,14 +91,27 @@ static void devcd_dev_release(struct device *dev)
 	kfree(devcd);
 }
 
+static void __devcd_del(struct devcd_entry *devcd)
+{
+	devcd->deleted = true;
+	device_del(&devcd->devcd_dev);
+	put_device(&devcd->devcd_dev);
+}
+
 static void devcd_del(struct work_struct *wk)
 {
 	struct devcd_entry *devcd;
+	bool init_completed;
 
 	devcd = container_of(wk, struct devcd_entry, del_wk.work);
 
-	device_del(&devcd->devcd_dev);
-	put_device(&devcd->devcd_dev);
+	/* devcd->mutex serializes against dev_coredumpm_timeout */
+	mutex_lock(&devcd->mutex);
+	init_completed = devcd->init_completed;
+	mutex_unlock(&devcd->mutex);
+
+	if (init_completed)
+		__devcd_del(devcd);
 }
 
 static ssize_t devcd_data_read(struct file *filp, struct kobject *kobj,
@@ -122,12 +131,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mutex_lock(&devcd->mutex);
-	if (!devcd->delete_work) {
-		devcd->delete_work = true;
-		mod_delayed_work(system_wq, &devcd->del_wk, 0);
-	}
-	mutex_unlock(&devcd->mutex);
+	/*
+	 * Although it's tempting to use mod_delayed work here,
+	 * that will cause a reschedule if the timer already fired.
+	 */
+	if (cancel_delayed_work(&devcd->del_wk))
+		schedule_delayed_work(&devcd->del_wk, 0);
 
 	return count;
 }
@@ -155,11 +164,21 @@ static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
+	/*
+	 * To prevent a race with devcd_data_write(), disable work and
+	 * complete manually instead.
+	 *
+	 * We cannot rely on the return value of
+	 * disable_delayed_work_sync() here, because it might be in the
+	 * middle of a cancel_delayed_work + schedule_delayed_work pair.
+	 *
+	 * devcd->mutex here guards against multiple parallel invocations
+	 * of devcd_free().
+	 */
+	disable_delayed_work_sync(&devcd->del_wk);
 	mutex_lock(&devcd->mutex);
-	if (!devcd->delete_work)
-		devcd->delete_work = true;
-
-	flush_delayed_work(&devcd->del_wk);
+	if (!devcd->deleted)
+		__devcd_del(devcd);
 	mutex_unlock(&devcd->mutex);
 	return 0;
 }
@@ -183,12 +202,10 @@ static ssize_t disabled_show(const struct class *class, const struct class_attri
  *                                                                 put_device() <- last reference
  *             error = fn(dev, data)                           devcd_dev_release()
  *             devcd_free(dev, data)                           kfree(devcd)
- *             mutex_lock(&devcd->mutex);
  *
  *
- * In the above diagram, It looks like disabled_store() would be racing with parallely
- * running devcd_del() and result in memory abort while acquiring devcd->mutex which
- * is called after kfree of devcd memory  after dropping its last reference with
+ * In the above diagram, it looks like disabled_store() would be racing with parallelly
+ * running devcd_del() and result in memory abort after dropping its last reference with
  * put_device(). However, this will not happens as fn(dev, data) runs
  * with its own reference to device via klist_node so it is not its last reference.
  * so, above situation would not occur.
@@ -376,7 +393,7 @@ void dev_coredumpm_timeout(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
-	devcd->delete_work = false;
+	devcd->deleted = false;
 
 	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
@@ -385,8 +402,14 @@ void dev_coredumpm_timeout(struct device *dev, struct module *owner,
 		     atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
-	mutex_lock(&devcd->mutex);
 	dev_set_uevent_suppress(&devcd->devcd_dev, true);
+
+	/* devcd->mutex prevents devcd_del() completing until init finishes */
+	mutex_lock(&devcd->mutex);
+	devcd->init_completed = false;
+	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
+	schedule_delayed_work(&devcd->del_wk, timeout);
+
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -403,13 +426,20 @@ void dev_coredumpm_timeout(struct device *dev, struct module *owner,
 
 	dev_set_uevent_suppress(&devcd->devcd_dev, false);
 	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
-	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
-	schedule_delayed_work(&devcd->del_wk, timeout);
+
+	/*
+	 * Safe to run devcd_del() now that we are done with devcd_dev.
+	 * Alternatively we could have taken a ref on devcd_dev before
+	 * dropping the lock.
+	 */
+	devcd->init_completed = true;
 	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
-	put_device(&devcd->devcd_dev);
 	mutex_unlock(&devcd->mutex);
+	cancel_delayed_work_sync(&devcd->del_wk);
+	put_device(&devcd->devcd_dev);
+
  put_module:
 	module_put(owner);
  free:
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index de692eed9874..deb298371a6a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -52,6 +52,7 @@
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static struct workqueue_struct *nbd_del_wq;
+static struct cred *nbd_cred;
 static int nbd_total_devices = 0;
 
 struct nbd_sock {
@@ -557,6 +558,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 	int result;
 	struct msghdr msg = {} ;
 	unsigned int noreclaim_flag;
+	const struct cred *old_cred;
 
 	if (unlikely(!sock)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -565,6 +567,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		return -EINVAL;
 	}
 
+	old_cred = override_creds(nbd_cred);
+
 	msg.msg_iter = *iter;
 
 	noreclaim_flag = memalloc_noreclaim_save();
@@ -589,6 +593,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
+	revert_creds(old_cred);
+
 	return result;
 }
 
@@ -2605,7 +2611,15 @@ static int __init nbd_init(void)
 		return -ENOMEM;
 	}
 
+	nbd_cred = prepare_kernel_cred(&init_task);
+	if (!nbd_cred) {
+		destroy_workqueue(nbd_del_wq);
+		unregister_blkdev(NBD_MAJOR, "nbd");
+		return -ENOMEM;
+	}
+
 	if (genl_register_family(&nbd_genl_family)) {
+		put_cred(nbd_cred);
 		destroy_workqueue(nbd_del_wq);
 		unregister_blkdev(NBD_MAJOR, "nbd");
 		return -EINVAL;
@@ -2660,6 +2674,7 @@ static void __exit nbd_cleanup(void)
 	/* Also wait for nbd_dev_remove_work() completes */
 	destroy_workqueue(nbd_del_wq);
 
+	put_cred(nbd_cred);
 	idr_destroy(&nbd_index_idr);
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 85df941afb6c..3a4db68fc2e6 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2734,20 +2734,32 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 
 	struct btintel_dsbr_cmd cmd;
 	struct sk_buff *skb;
+	u32 dsbr, cnvi;
 	u8 status;
-	u32 dsbr;
-	bool apply_dsbr;
 	int err;
 
-	/* DSBR command needs to be sent for BlazarI + B0 step product after
-	 * downloading IML image.
+	cnvi = ver->cnvi_top & 0xfff;
+	/* DSBR command needs to be sent for,
+	 * 1. BlazarI or BlazarIW + B0 step product in IML image.
+	 * 2. Gale Peak2 or BlazarU in OP image.
 	 */
-	apply_dsbr = (ver->img_type == BTINTEL_IMG_IML &&
-		((ver->cnvi_top & 0xfff) == BTINTEL_CNVI_BLAZARI) &&
-		INTEL_CNVX_TOP_STEP(ver->cnvi_top) == 0x01);
 
-	if (!apply_dsbr)
+	switch (cnvi) {
+	case BTINTEL_CNVI_BLAZARI:
+	case BTINTEL_CNVI_BLAZARIW:
+		if (ver->img_type == BTINTEL_IMG_IML &&
+		    INTEL_CNVX_TOP_STEP(ver->cnvi_top) == 0x01)
+			break;
+		return 0;
+	case BTINTEL_CNVI_GAP:
+	case BTINTEL_CNVI_BLAZARU:
+		if (ver->img_type == BTINTEL_IMG_OP &&
+		    hdev->bus == HCI_USB)
+			break;
 		return 0;
+	default:
+		return 0;
+	}
 
 	dsbr = 0;
 	err = btintel_uefi_get_dsbr(&dsbr);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index b448c67e8ed9..fa43eb137821 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -53,6 +53,9 @@ struct intel_tlv {
 } __packed;
 
 #define BTINTEL_CNVI_BLAZARI		0x900
+#define BTINTEL_CNVI_BLAZARIW		0x901
+#define BTINTEL_CNVI_GAP		0x910
+#define BTINTEL_CNVI_BLAZARU		0x930
 
 #define BTINTEL_IMG_BOOTLOADER		0x01	/* Bootloader image */
 #define BTINTEL_IMG_IML			0x02	/* Intermediate image */
diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 393966c09740..ef38e9ad98f6 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -368,7 +368,7 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
 	unsigned int count = 0;
 	const unsigned int num_sample_bytes = comedi_bytes_per_sample(s);
 
-	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA)) {
+	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA) || async->cmd.chanlist_len == 0) {
 		async->munge_count += num_bytes;
 		return num_bytes;
 	}
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 3eb543b1644d..a87c08f7eb68 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -199,20 +199,17 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	 *
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
+	 *
+	 * However, if the number of remaining samples is too small to exclude
+	 * any more outliers, allow the deepest available idle state to be
+	 * selected because there are systems where the time spent by CPUs in
+	 * deep idle states is correlated to the maximum frequency the CPUs
+	 * can get to.  On those systems, shallow idle states should be avoided
+	 * unless there is a clear indication that the given CPU is most likley
+	 * going to be woken up shortly.
 	 */
-	if (divisor * 4 <= INTERVALS * 3) {
-		/*
-		 * If there are sufficiently many data points still under
-		 * consideration after the outliers have been eliminated,
-		 * returning without a prediction would be a mistake because it
-		 * is likely that the next interval will not exceed the current
-		 * maximum, so return the latter in that case.
-		 */
-		if (divisor >= INTERVALS / 2)
-			return max;
-
+	if (divisor * 4 <= INTERVALS * 3)
 		return UINT_MAX;
-	}
 
 	thresh = max - 1;
 	goto again;
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index cdec50a698a1..87acc795f743 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -297,10 +297,28 @@ enum debug_counters {
 	SCMI_DEBUG_COUNTERS_LAST
 };
 
-static inline void scmi_inc_count(atomic_t *arr, int stat)
+/**
+ * struct scmi_debug_info  - Debug common info
+ * @top_dentry: A reference to the top debugfs dentry
+ * @name: Name of this SCMI instance
+ * @type: Type of this SCMI instance
+ * @is_atomic: Flag to state if the transport of this instance is atomic
+ * @counters: An array of atomic_c's used for tracking statistics (if enabled)
+ */
+struct scmi_debug_info {
+	struct dentry *top_dentry;
+	const char *name;
+	const char *type;
+	bool is_atomic;
+	atomic_t counters[SCMI_DEBUG_COUNTERS_LAST];
+};
+
+static inline void scmi_inc_count(struct scmi_debug_info *dbg, int stat)
 {
-	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS))
-		atomic_inc(&arr[stat]);
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS)) {
+		if (dbg)
+			atomic_inc(&dbg->counters[stat]);
+	}
 }
 
 enum scmi_bad_msg {
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index f1abe605865a..79866f3b6b3e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -111,22 +111,6 @@ struct scmi_protocol_instance {
 
 #define ph_to_pi(h)	container_of(h, struct scmi_protocol_instance, ph)
 
-/**
- * struct scmi_debug_info  - Debug common info
- * @top_dentry: A reference to the top debugfs dentry
- * @name: Name of this SCMI instance
- * @type: Type of this SCMI instance
- * @is_atomic: Flag to state if the transport of this instance is atomic
- * @counters: An array of atomic_c's used for tracking statistics (if enabled)
- */
-struct scmi_debug_info {
-	struct dentry *top_dentry;
-	const char *name;
-	const char *type;
-	bool is_atomic;
-	atomic_t counters[SCMI_DEBUG_COUNTERS_LAST];
-};
-
 /**
  * struct scmi_info - Structure representing a SCMI instance
  *
@@ -787,6 +771,7 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 			hash_del(&xfer->node);
 			xfer->pending = false;
 		}
+		xfer->flags = 0;
 		hlist_add_head(&xfer->node, &minfo->free_xfers);
 	}
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
@@ -805,8 +790,6 @@ void scmi_xfer_raw_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
-	xfer->flags &= ~SCMI_XFER_FLAG_IS_RAW;
-	xfer->flags &= ~SCMI_XFER_FLAG_CHAN_SET;
 	return __scmi_xfer_put(&info->tx_minfo, xfer);
 }
 
@@ -1000,7 +983,7 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNEXPECTED);
-		scmi_inc_count(info->dbg->counters, ERR_MSG_UNEXPECTED);
+		scmi_inc_count(info->dbg, ERR_MSG_UNEXPECTED);
 
 		return xfer;
 	}
@@ -1028,7 +1011,7 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 			msg_type, xfer_id, msg_hdr, xfer->state);
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_INVALID);
-		scmi_inc_count(info->dbg->counters, ERR_MSG_INVALID);
+		scmi_inc_count(info->dbg, ERR_MSG_INVALID);
 
 		/* On error the refcount incremented above has to be dropped */
 		__scmi_xfer_put(minfo, xfer);
@@ -1073,7 +1056,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 			PTR_ERR(xfer));
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_NOMEM);
-		scmi_inc_count(info->dbg->counters, ERR_MSG_NOMEM);
+		scmi_inc_count(info->dbg, ERR_MSG_NOMEM);
 
 		scmi_clear_channel(info, cinfo);
 		return;
@@ -1089,7 +1072,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
 			    xfer->hdr.id, "NOTI", xfer->hdr.seq,
 			    xfer->hdr.status, xfer->rx.buf, xfer->rx.len);
-	scmi_inc_count(info->dbg->counters, NOTIFICATION_OK);
+	scmi_inc_count(info->dbg, NOTIFICATION_OK);
 
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
 		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts);
@@ -1149,10 +1132,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
 		scmi_clear_channel(info, cinfo);
 		complete(xfer->async_done);
-		scmi_inc_count(info->dbg->counters, DELAYED_RESPONSE_OK);
+		scmi_inc_count(info->dbg, DELAYED_RESPONSE_OK);
 	} else {
 		complete(&xfer->done);
-		scmi_inc_count(info->dbg->counters, RESPONSE_OK);
+		scmi_inc_count(info->dbg, RESPONSE_OK);
 	}
 
 	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
@@ -1261,7 +1244,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					"timed out in resp(caller: %pS) - polling\n",
 					(void *)_RET_IP_);
 				ret = -ETIMEDOUT;
-				scmi_inc_count(info->dbg->counters, XFERS_RESPONSE_POLLED_TIMEOUT);
+				scmi_inc_count(info->dbg, XFERS_RESPONSE_POLLED_TIMEOUT);
 			}
 		}
 
@@ -1286,7 +1269,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					    "RESP" : "resp",
 					    xfer->hdr.seq, xfer->hdr.status,
 					    xfer->rx.buf, xfer->rx.len);
-			scmi_inc_count(info->dbg->counters, RESPONSE_POLLED_OK);
+			scmi_inc_count(info->dbg, RESPONSE_POLLED_OK);
 
 			if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
 				scmi_raw_message_report(info->raw, xfer,
@@ -1301,7 +1284,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 			dev_err(dev, "timed out in resp(caller: %pS)\n",
 				(void *)_RET_IP_);
 			ret = -ETIMEDOUT;
-			scmi_inc_count(info->dbg->counters, XFERS_RESPONSE_TIMEOUT);
+			scmi_inc_count(info->dbg, XFERS_RESPONSE_TIMEOUT);
 		}
 	}
 
@@ -1385,13 +1368,13 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	    !is_transport_polling_capable(info->desc)) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
-		scmi_inc_count(info->dbg->counters, SENT_FAIL_POLLING_UNSUPPORTED);
+		scmi_inc_count(info->dbg, SENT_FAIL_POLLING_UNSUPPORTED);
 		return -EINVAL;
 	}
 
 	cinfo = idr_find(&info->tx_idr, pi->proto->id);
 	if (unlikely(!cinfo)) {
-		scmi_inc_count(info->dbg->counters, SENT_FAIL_CHANNEL_NOT_FOUND);
+		scmi_inc_count(info->dbg, SENT_FAIL_CHANNEL_NOT_FOUND);
 		return -EINVAL;
 	}
 	/* True ONLY if also supported by transport. */
@@ -1425,19 +1408,19 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	ret = info->desc->ops->send_message(cinfo, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "Failed to send message %d\n", ret);
-		scmi_inc_count(info->dbg->counters, SENT_FAIL);
+		scmi_inc_count(info->dbg, SENT_FAIL);
 		return ret;
 	}
 
 	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
 			    xfer->hdr.id, "CMND", xfer->hdr.seq,
 			    xfer->hdr.status, xfer->tx.buf, xfer->tx.len);
-	scmi_inc_count(info->dbg->counters, SENT_OK);
+	scmi_inc_count(info->dbg, SENT_OK);
 
 	ret = scmi_wait_for_message_response(cinfo, xfer);
 	if (!ret && xfer->hdr.status) {
 		ret = scmi_to_linux_errno(xfer->hdr.status);
-		scmi_inc_count(info->dbg->counters, ERR_PROTOCOL);
+		scmi_inc_count(info->dbg, ERR_PROTOCOL);
 	}
 
 	if (info->desc->ops->mark_txdone)
diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index f03ccd0f534c..f60872d1e8a5 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -59,6 +59,7 @@ static const struct regmap_config idio_16_regmap_config = {
 	.reg_stride = 1,
 	.val_bits = 8,
 	.io_port = true,
+	.max_register = 0x5,
 	.wr_table = &idio_16_wr_table,
 	.rd_table = &idio_16_rd_table,
 	.volatile_table = &idio_16_rd_table,
diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index c2a9b4253974..c3a595c6f6c7 100644
--- a/drivers/gpio/gpio-ljca.c
+++ b/drivers/gpio/gpio-ljca.c
@@ -281,22 +281,14 @@ static void ljca_gpio_event_cb(void *context, u8 cmd, const void *evt_data,
 {
 	const struct ljca_gpio_packet *packet = evt_data;
 	struct ljca_gpio_dev *ljca_gpio = context;
-	int i, irq;
+	int i;
 
 	if (cmd != LJCA_GPIO_INT_EVENT)
 		return;
 
 	for (i = 0; i < packet->num; i++) {
-		irq = irq_find_mapping(ljca_gpio->gc.irq.domain,
-				       packet->item[i].index);
-		if (!irq) {
-			dev_err(ljca_gpio->gc.parent,
-				"gpio_id %u does not mapped to IRQ yet\n",
-				packet->item[i].index);
-			return;
-		}
-
-		generic_handle_domain_irq(ljca_gpio->gc.irq.domain, irq);
+		generic_handle_domain_irq(ljca_gpio->gc.irq.domain,
+					packet->item[i].index);
 		set_bit(packet->item[i].index, ljca_gpio->reenable_irqs);
 	}
 
diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 44c0a21b1d1d..5827b18d190b 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -41,6 +41,7 @@ static const struct regmap_config idio_16_regmap_config = {
 	.reg_stride = 1,
 	.val_bits = 8,
 	.io_port = true,
+	.max_register = 0x7,
 	.wr_table = &idio_16_wr_table,
 	.rd_table = &idio_16_rd_table,
 	.volatile_table = &idio_16_rd_table,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 3279f347660c..bcb296a954f2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -287,6 +287,9 @@ void dcn401_init_hw(struct dc *dc)
 		 */
 		struct dc_link *link = dc->links[i];
 
+		if (link->ep_type != DISPLAY_ENDPOINT_PHY)
+			continue;
+
 		link->link_enc->funcs->hw_init(link->link_enc);
 
 		/* Check for enabled DIG to identify enabled display */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 41c76ba9ba56..62a39204fe0b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -44,7 +44,13 @@
  */
 #define MAX_PIPES 6
 #define MAX_PHANTOM_PIPES (MAX_PIPES / 2)
-#define MAX_LINKS (MAX_PIPES * 2 +2)
+
+#define MAX_DPIA 6
+#define MAX_CONNECTOR 6
+#define MAX_VIRTUAL_LINKS 4
+
+#define MAX_LINKS (MAX_DPIA + MAX_CONNECTOR + MAX_VIRTUAL_LINKS)
+
 #define MAX_DIG_LINK_ENCODERS 7
 #define MAX_DWB_PIPES	1
 #define MAX_HPO_DP2_ENCODERS	4
diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index f128d345b16d..0aa87eafdacd 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -306,6 +306,9 @@ static void drm_panic_logo_rect(struct drm_rect *rect, const struct font_desc *f
 static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *rect,
 				const struct font_desc *font, u32 fg_color)
 {
+	if (rect->x2 > sb->width || rect->y2 > sb->height)
+		return;
+
 	if (logo_mono)
 		drm_panic_blit(sb, rect, logo_mono->data,
 			       DIV_ROUND_UP(drm_rect_width(rect), 8), 1, fg_color);
@@ -615,7 +618,10 @@ static int _draw_panic_static_qr_code(struct drm_scanout_buffer *sb)
 	pr_debug("QR width %d and scale %d\n", qr_width, scale);
 	r_qr_canvas = DRM_RECT_INIT(0, 0, qr_canvas_width * scale, qr_canvas_width * scale);
 
-	v_margin = (sb->height - drm_rect_height(&r_qr_canvas) - drm_rect_height(&r_msg)) / 5;
+	v_margin = sb->height - drm_rect_height(&r_qr_canvas) - drm_rect_height(&r_msg);
+	if (v_margin < 0)
+		return -ENOSPC;
+	v_margin /= 5;
 
 	drm_rect_translate(&r_qr_canvas, (sb->width - r_qr_canvas.x2) / 2, 2 * v_margin);
 	r_qr = DRM_RECT_INIT(r_qr_canvas.x1 + QR_MARGIN * scale, r_qr_canvas.y1 + QR_MARGIN * scale,
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index b57824abeb9e..2214dbf472fa 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1168,10 +1168,14 @@ panthor_vm_op_ctx_prealloc_vmas(struct panthor_vm_op_ctx *op_ctx)
 		break;
 
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP:
-		/* Partial unmaps might trigger a remap with either a prev or a next VA,
-		 * but not both.
+		/* Two VMAs can be needed for an unmap, as an unmap can happen
+		 * in the middle of a drm_gpuva, requiring a remap with both
+		 * prev & next VA. Or an unmap can span more than one drm_gpuva
+		 * where the first and last ones are covered partially, requring
+		 * a remap for the first with a prev VA and remap for the last
+		 * with a next VA.
 		 */
-		vma_count = 1;
+		vma_count = 2;
 		break;
 
 	default:
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 650b0bcc2359..94466e28dc56 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -294,24 +294,26 @@ static struct sht3x_data *sht3x_update_client(struct device *dev)
 	return data;
 }
 
-static int temp1_input_read(struct device *dev)
+static int temp1_input_read(struct device *dev, long *temp)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return data->temperature;
+	*temp = data->temperature;
+	return 0;
 }
 
-static int humidity1_input_read(struct device *dev)
+static int humidity1_input_read(struct device *dev, long *humidity)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return data->humidity;
+	*humidity = data->humidity;
+	return 0;
 }
 
 /*
@@ -709,6 +711,7 @@ static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long *val)
 {
 	enum sht3x_limits index;
+	int ret;
 
 	switch (type) {
 	case hwmon_chip:
@@ -723,10 +726,12 @@ static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_input:
-			*val = temp1_input_read(dev);
-			break;
+			return temp1_input_read(dev, val);
 		case hwmon_temp_alarm:
-			*val = temp1_alarm_read(dev);
+			ret = temp1_alarm_read(dev);
+			if (ret < 0)
+				return ret;
+			*val = ret;
 			break;
 		case hwmon_temp_max:
 			index = limit_max;
@@ -751,10 +756,12 @@ static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_humidity:
 		switch (attr) {
 		case hwmon_humidity_input:
-			*val = humidity1_input_read(dev);
-			break;
+			return humidity1_input_read(dev, val);
 		case hwmon_humidity_alarm:
-			*val = humidity1_alarm_read(dev);
+			ret = humidity1_alarm_read(dev);
+			if (ret < 0)
+				return ret;
+			*val = ret;
 			break;
 		case hwmon_humidity_max:
 			index = limit_max;
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9d8e51351ff8..d6c55c338b06 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -384,6 +384,8 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 	}
 	spin_unlock(&fl->lock);
 
+	dma_buf_put(buf);
+
 	return ret;
 }
 
diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index 015927665678..00ed2147113e 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -44,6 +44,9 @@ static void lkdtm_FORTIFY_STR_MEMBER(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+	if (!src)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
@@ -109,6 +112,9 @@ static void lkdtm_FORTIFY_MEM_MEMBER(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+	if (!src)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index bc40b940ae21..a4f75dc36929 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -120,6 +120,8 @@
 #define MEI_DEV_ID_PTL_H      0xE370  /* Panther Lake H */
 #define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
 
+#define MEI_DEV_ID_WCL_P      0x4D70  /* Wildcat Lake P */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 3f9c60b579ae..bc0fc584a8e4 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -127,6 +127,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_H, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_WCL_P, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 485d5ca39951..988e33f27970 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -929,6 +929,10 @@ static void release_mdev(struct device *dev)
 {
 	struct most_dev *mdev = to_mdev_from_dev(dev);
 
+	kfree(mdev->busy_urbs);
+	kfree(mdev->cap);
+	kfree(mdev->conf);
+	kfree(mdev->ep_address);
 	kfree(mdev);
 }
 /**
@@ -1093,7 +1097,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 err_free_conf:
 	kfree(mdev->conf);
 err_free_mdev:
-	put_device(&mdev->dev);
+	kfree(mdev);
 	return ret;
 }
 
@@ -1121,13 +1125,6 @@ static void hdm_disconnect(struct usb_interface *interface)
 	if (mdev->dci)
 		device_unregister(&mdev->dci->dev);
 	most_deregister_interface(&mdev->iface);
-
-	kfree(mdev->busy_urbs);
-	kfree(mdev->cap);
-	kfree(mdev->conf);
-	kfree(mdev->ep_address);
-	put_device(&mdev->dci->dev);
-	put_device(&mdev->dev);
 }
 
 static int hdm_suspend(struct usb_interface *interface, pm_message_t message)
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 00204e42de2e..46628a7ed497 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2951,7 +2951,7 @@ static void bond_mii_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    mii_work.work);
-	bool should_notify_peers = false;
+	bool should_notify_peers;
 	bool commit;
 	unsigned long delay;
 	struct slave *slave;
@@ -2963,30 +2963,33 @@ static void bond_mii_monitor(struct work_struct *work)
 		goto re_arm;
 
 	rcu_read_lock();
+
 	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
-	if (bond->send_peer_notif) {
-		rcu_read_unlock();
-		if (rtnl_trylock()) {
-			bond->send_peer_notif--;
-			rtnl_unlock();
-		}
-	} else {
-		rcu_read_unlock();
-	}
 
-	if (commit) {
+	rcu_read_unlock();
+
+	if (commit || bond->send_peer_notif) {
 		/* Race avoidance with bond_close cancel of workqueue */
 		if (!rtnl_trylock()) {
 			delay = 1;
-			should_notify_peers = false;
 			goto re_arm;
 		}
 
-		bond_for_each_slave(bond, slave, iter) {
-			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
+		if (commit) {
+			bond_for_each_slave(bond, slave, iter) {
+				bond_commit_link_state(slave,
+						       BOND_SLAVE_NOTIFY_LATER);
+			}
+			bond_miimon_commit(bond);
+		}
+
+		if (bond->send_peer_notif) {
+			bond->send_peer_notif--;
+			if (should_notify_peers)
+				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
+							 bond->dev);
 		}
-		bond_miimon_commit(bond);
 
 		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
@@ -2994,13 +2997,6 @@ static void bond_mii_monitor(struct work_struct *work)
 re_arm:
 	if (bond->params.miimon)
 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
-
-	if (should_notify_peers) {
-		if (!rtnl_trylock())
-			return;
-		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
-		rtnl_unlock();
-	}
 }
 
 static int bond_upper_dev_walk(struct net_device *upper,
diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index bfc60eb33dc3..333ad42ea73b 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -842,7 +842,7 @@ static netdev_tx_t bxcan_start_xmit(struct sk_buff *skb,
 	u32 id;
 	int i, j;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (bxcan_tx_busy(priv))
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index abe8dc051d94..77d165ed0d53 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -285,7 +285,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
-		if (!priv->do_set_mode) {
+		unsigned int restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+
+		if (restart_ms != 0 && !priv->do_set_mode) {
 			NL_SET_ERR_MSG(extack,
 				       "Device doesn't support restart from Bus Off");
 			return -EOPNOTSUPP;
@@ -294,7 +296,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
-		priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+		priv->restart_ms = restart_ms;
 	}
 
 	if (data[IFLA_CAN_RESTART]) {
diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index c80032bc1a52..73e66f9a3781 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -254,7 +254,7 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	u32 acc_id;
 	u32 acc_dlc;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* Access core->tx_fifo_tail only once because it may be changed
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 865a15e033a9..12200dcfd338 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -72,7 +72,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	int err;
 	u8 i;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (!netif_subqueue_maybe_stop(priv->ndev, 0,
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index c744e10e6403..f56a14e09d4a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1077,8 +1077,7 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
 	dma_addr_t addr;
 
 	buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
-	aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
-				  DPAA2_ETH_TX_BUF_ALIGN);
+	aligned_start = PTR_ALIGN(buffer_start, DPAA2_ETH_TX_BUF_ALIGN);
 	if (aligned_start >= skb->head)
 		buffer_start = aligned_start;
 	else
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index d8272b7a55fc..749b65aab14a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1246,6 +1246,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd;
 		struct sk_buff *skb;
@@ -1281,7 +1283,9 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		rx_byte_cnt += skb->len + ETH_HLEN;
 		rx_frm_cnt++;
 
+		enetc_unlock_mdio();
 		napi_gro_receive(napi, skb);
+		enetc_lock_mdio();
 	}
 
 	rx_ring->next_to_clean = i;
@@ -1289,6 +1293,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -1598,6 +1604,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd, *orig_rxbd;
 		int orig_i, orig_cleaned_cnt;
@@ -1657,7 +1665,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			if (unlikely(!skb))
 				goto out;
 
+			enetc_unlock_mdio();
 			napi_gro_receive(napi, skb);
+			enetc_lock_mdio();
 			break;
 		case XDP_TX:
 			tx_ring = priv->xdp_tx_ring[rx_ring->index];
@@ -1692,7 +1702,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			}
 			break;
 		case XDP_REDIRECT:
+			enetc_unlock_mdio();
 			err = xdp_do_redirect(rx_ring->ndev, &xdp_buff, prog);
+			enetc_lock_mdio();
 			if (unlikely(err)) {
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				rx_ring->stats.xdp_redirect_failures++;
@@ -1712,8 +1724,11 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
-	if (xdp_redirect_frm_cnt)
+	if (xdp_redirect_frm_cnt) {
+		enetc_unlock_mdio();
 		xdp_do_flush();
+		enetc_lock_mdio();
+	}
 
 	if (xdp_tx_frm_cnt)
 		enetc_update_tx_ring_tail(tx_ring);
@@ -1722,6 +1737,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
 				     rx_ring->xdp.xdp_tx_in_flight);
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -1740,6 +1757,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < v->count_tx_rings; i++)
 		if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
 			complete = false;
+	enetc_unlock_mdio();
 
 	prog = rx_ring->xdp.prog;
 	if (prog)
@@ -1751,10 +1769,8 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	if (work_done)
 		v->rx_napi_work = true;
 
-	if (!complete) {
-		enetc_unlock_mdio();
+	if (!complete)
 		return budget;
-	}
 
 	napi_complete_done(napi, work_done);
 
@@ -1763,6 +1779,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 
 	v->rx_napi_work = false;
 
+	enetc_lock_mdio();
 	/* enable interrupts */
 	enetc_wr_reg_hot(v->rbier, ENETC_RBIER_RXTIE);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index fb7d98d57783..bf72b2825fa6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -41,7 +41,7 @@ struct enetc_tx_swbd {
 };
 
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
-#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
+#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
 #define ENETC_RXB_DMA_SIZE	\
 	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index e048a667e075..f2952a6b0db7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -512,6 +512,12 @@ struct mlx5e_xdpsq {
 	struct mlx5e_channel      *channel;
 } ____cacheline_aligned_in_smp;
 
+struct mlx5e_xdp_buff {
+	struct xdp_buff xdp;
+	struct mlx5_cqe64 *cqe;
+	struct mlx5e_rq *rq;
+};
+
 struct mlx5e_ktls_resync_resp;
 
 struct mlx5e_icosq {
@@ -710,6 +716,7 @@ struct mlx5e_rq {
 	struct mlx5e_xdpsq    *xdpsq;
 	DECLARE_BITMAP(flags, 8);
 	struct page_pool      *page_pool;
+	struct mlx5e_xdp_buff mxbuf;
 
 	/* AF_XDP zero-copy */
 	struct xsk_buff_pool  *xsk_pool;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 58ec5e44aa7a..3dac708c0d75 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -99,7 +99,7 @@ u8 mlx5e_mpwrq_umr_entry_size(enum mlx5e_mpwrq_umr_mode mode)
 		return sizeof(struct mlx5_ksm) * 4;
 	}
 	WARN_ONCE(1, "MPWRQ UMR mode %d is not known\n", mode);
-	return 0;
+	return 1;
 }
 
 u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index e054db1e10f8..75256cf978c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -45,12 +45,6 @@
 	(MLX5E_XDP_INLINE_WQE_MAX_DS_CNT * MLX5_SEND_WQE_DS - \
 	 sizeof(struct mlx5_wqe_inline_seg))
 
-struct mlx5e_xdp_buff {
-	struct xdp_buff xdp;
-	struct mlx5_cqe64 *cqe;
-	struct mlx5e_rq *rq;
-};
-
 /* XDP packets can be transmitted in different ways. On completion, we need to
  * distinguish between them to clean up things in a proper way.
  */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 9aff779c77c8..78e78b6f8146 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -337,6 +337,7 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *slave_priv,
 				  struct mlx5e_priv *master_priv);
 void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event);
+void mlx5e_ipsec_disable_events(struct mlx5e_priv *priv);
 
 static inline struct mlx5_core_dev *
 mlx5e_ipsec_sa2dev(struct mlx5e_ipsec_sa_entry *sa_entry)
@@ -382,6 +383,10 @@ static inline void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *sl
 static inline void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event)
 {
 }
+
+static inline void mlx5e_ipsec_disable_events(struct mlx5e_priv *priv)
+{
+}
 #endif
 
 #endif	/* __MLX5E_IPSEC_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 59b9653f573c..131eb9b4eba6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -2421,9 +2421,30 @@ void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *slave_priv,
 
 void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event)
 {
-	if (!priv->ipsec)
-		return; /* IPsec not supported */
+	if (!priv->ipsec || mlx5_devcom_comp_get_size(priv->devcom) < 2)
+		return; /* IPsec not supported or no peers */
 
 	mlx5_devcom_send_event(priv->devcom, event, event, priv);
 	wait_for_completion(&priv->ipsec->comp);
 }
+
+void mlx5e_ipsec_disable_events(struct mlx5e_priv *priv)
+{
+	struct mlx5_devcom_comp_dev *tmp = NULL;
+	struct mlx5e_priv *peer_priv;
+
+	if (!priv->devcom)
+		return;
+
+	if (!mlx5_devcom_for_each_peer_begin(priv->devcom))
+		goto out;
+
+	peer_priv = mlx5_devcom_get_next_peer_data(priv->devcom, &tmp);
+	if (peer_priv)
+		complete_all(&peer_priv->ipsec->comp);
+
+	mlx5_devcom_for_each_peer_end(priv->devcom);
+out:
+	mlx5_devcom_unregister_component(priv->devcom);
+	priv->devcom = NULL;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4a2f58a9d706..7e04a17fa3b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -257,6 +257,7 @@ static void mlx5e_devcom_cleanup_mpv(struct mlx5e_priv *priv)
 	}
 
 	mlx5_devcom_unregister_component(priv->devcom);
+	priv->devcom = NULL;
 }
 
 static int blocking_event(struct notifier_block *nb, unsigned long event, void *data)
@@ -5830,6 +5831,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	if (mlx5e_monitor_counter_supported(priv))
 		mlx5e_monitor_counter_cleanup(priv);
 
+	mlx5e_ipsec_disable_events(priv);
 	mlx5e_disable_blocking_events(priv);
 	if (priv->en_trap) {
 		mlx5e_deactivate_trap(priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 673043d9ed11..59aa10f1a9d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1691,17 +1691,17 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		struct mlx5e_xdp_buff mxbuf;
+		struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 
 		net_prefetchw(va); /* xdp_frame data area */
 		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-				 cqe_bcnt, &mxbuf);
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf))
+				 cqe_bcnt, mxbuf);
+		if (mlx5e_xdp_handle(rq, prog, mxbuf))
 			return NULL; /* page/packet was consumed by XDP */
 
-		rx_headroom = mxbuf.xdp.data - mxbuf.xdp.data_hard_start;
-		metasize = mxbuf.xdp.data - mxbuf.xdp.data_meta;
-		cqe_bcnt = mxbuf.xdp.data_end - mxbuf.xdp.data;
+		rx_headroom = mxbuf->xdp.data - mxbuf->xdp.data_hard_start;
+		metasize = mxbuf->xdp.data - mxbuf->xdp.data_meta;
+		cqe_bcnt = mxbuf->xdp.data_end - mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
@@ -1720,11 +1720,11 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
 {
 	struct mlx5e_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
+	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 	struct mlx5e_wqe_frag_info *head_wi = wi;
 	u16 rx_headroom = rq->buff.headroom;
 	struct mlx5e_frag_page *frag_page;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	u32 frag_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
@@ -1744,8 +1744,8 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	net_prefetch(va + rx_headroom);
 
 	mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-			 frag_consumed_bytes, &mxbuf);
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+			 frag_consumed_bytes, mxbuf);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 	truesize = 0;
 
 	cqe_bcnt -= frag_consumed_bytes;
@@ -1757,8 +1757,9 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 		frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page,
-					       wi->offset, frag_consumed_bytes);
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp,
+					       frag_page, wi->offset,
+					       frag_consumed_bytes);
 		truesize += frag_info->frag_stride;
 
 		cqe_bcnt -= frag_consumed_bytes;
@@ -1767,31 +1768,46 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	}
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (prog && mlx5e_xdp_handle(rq, prog, &mxbuf)) {
-		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-			struct mlx5e_wqe_frag_info *pwi;
+	if (prog) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
+			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT,
+						 rq->flags)) {
+				struct mlx5e_wqe_frag_info *pwi;
+
+				wi -= old_nr_frags - sinfo->nr_frags;
+
+				for (pwi = head_wi; pwi < wi; pwi++)
+					pwi->frag_page->frags++;
+			}
+			return NULL; /* page/packet was consumed by XDP */
+		}
 
-			for (pwi = head_wi; pwi < wi; pwi++)
-				pwi->frag_page->frags++;
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			wi -= nr_frags_free;
+			truesize -= nr_frags_free * frag_info->frag_stride;
 		}
-		return NULL; /* page/packet was consumed by XDP */
 	}
 
-	skb = mlx5e_build_linear_skb(rq, mxbuf.xdp.data_hard_start, rq->buff.frame0_sz,
-				     mxbuf.xdp.data - mxbuf.xdp.data_hard_start,
-				     mxbuf.xdp.data_end - mxbuf.xdp.data,
-				     mxbuf.xdp.data - mxbuf.xdp.data_meta);
+	skb = mlx5e_build_linear_skb(
+		rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
+		mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
+		mxbuf->xdp.data_end - mxbuf->xdp.data,
+		mxbuf->xdp.data - mxbuf->xdp.data_meta);
 	if (unlikely(!skb))
 		return NULL;
 
 	skb_mark_for_recycle(skb);
 	head_wi->frag_page->frags++;
 
-	if (xdp_buff_has_frags(&mxbuf.xdp)) {
+	if (xdp_buff_has_frags(&mxbuf->xdp)) {
 		/* sinfo->nr_frags is reset by build_skb, calculate again. */
 		xdp_update_skb_shared_info(skb, wi - head_wi - 1,
 					   sinfo->xdp_frags_size, truesize,
-					   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+					   xdp_buff_is_frag_pfmemalloc(
+						&mxbuf->xdp));
 
 		for (struct mlx5e_wqe_frag_info *pwi = head_wi + 1; pwi < wi; pwi++)
 			pwi->frag_page->frags++;
@@ -1991,11 +2007,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
+	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	unsigned int truesize = 0;
+	u32 pg_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
 	u32 linear_frame_sz;
@@ -2040,20 +2057,23 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		}
 	}
 
-	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz, linear_data_len, &mxbuf);
+	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz,
+			 linear_data_len, mxbuf);
 
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
-		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+		pg_consumed_bytes =
+			min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
 		else
 			truesize += ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz));
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page, frag_offset,
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp,
+					       frag_page, frag_offset,
 					       pg_consumed_bytes);
 		byte_cnt -= pg_consumed_bytes;
 		frag_offset = 0;
@@ -2061,10 +2081,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+		u32 len;
+
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
+				frag_page -= old_nr_frags - sinfo->nr_frags;
+
 				for (pfp = head_page; pfp < frag_page; pfp++)
 					pfp->frags++;
 
@@ -2074,10 +2099,20 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		skb = mlx5e_build_linear_skb(rq, mxbuf.xdp.data_hard_start,
-					     linear_frame_sz,
-					     mxbuf.xdp.data - mxbuf.xdp.data_hard_start, 0,
-					     mxbuf.xdp.data - mxbuf.xdp.data_meta);
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			frag_page -= nr_frags_free;
+			truesize -= (nr_frags_free - 1) * PAGE_SIZE +
+				ALIGN(pg_consumed_bytes,
+				      BIT(rq->mpwqe.log_stride_sz));
+		}
+
+		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
+
+		skb = mlx5e_build_linear_skb(
+			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
+			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
+			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq, &wi->linear_page);
 			return NULL;
@@ -2087,29 +2122,34 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		wi->linear_page.frags++;
 		mlx5e_page_release_fragmented(rq, &wi->linear_page);
 
-		if (xdp_buff_has_frags(&mxbuf.xdp)) {
+		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
 			/* sinfo->nr_frags is reset by build_skb, calculate again. */
 			xdp_update_skb_shared_info(skb, frag_page - head_page,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+						   xdp_buff_is_frag_pfmemalloc(
+							&mxbuf->xdp));
 
 			pagep = head_page;
 			do
 				pagep->frags++;
 			while (++pagep < frag_page);
+
+			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
+					skb->data_len);
+			__pskb_pull_tail(skb, headlen);
 		}
-		__pskb_pull_tail(skb, headlen);
 	} else {
 		dma_addr_t addr;
 
-		if (xdp_buff_has_frags(&mxbuf.xdp)) {
+		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
 			xdp_update_skb_shared_info(skb, sinfo->nr_frags,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+						   xdp_buff_is_frag_pfmemalloc(
+							&mxbuf->xdp));
 
 			pagep = frag_page - sinfo->nr_frags;
 			do
@@ -2159,20 +2199,20 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		struct mlx5e_xdp_buff mxbuf;
+		struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 
 		net_prefetchw(va); /* xdp_frame data area */
 		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-				 cqe_bcnt, &mxbuf);
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+				 cqe_bcnt, mxbuf);
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
 				frag_page->frags++;
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		rx_headroom = mxbuf.xdp.data - mxbuf.xdp.data_hard_start;
-		metasize = mxbuf.xdp.data - mxbuf.xdp.data_meta;
-		cqe_bcnt = mxbuf.xdp.data_end - mxbuf.xdp.data;
+		rx_headroom = mxbuf->xdp.data - mxbuf->xdp.data_hard_start;
+		metasize =  mxbuf->xdp.data -  mxbuf->xdp.data_meta;
+		cqe_bcnt =  mxbuf->xdp.data_end -  mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index cc4f0d16c763..641ad4054df4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2203,15 +2203,35 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 		skb_tx_timestamp(skb);
 	}
-	/* Descriptor type must be set after all the above writes */
-	dma_wmb();
+
 	if (num_tx_desc > 1) {
 		desc->die_dt = DT_FEND;
 		desc--;
+		/* When using multi-descriptors, DT_FEND needs to get written
+		 * before DT_FSTART, but the compiler may reorder the memory
+		 * writes in an attempt to optimize the code.
+		 * Use a dma_wmb() barrier to make sure DT_FEND and DT_FSTART
+		 * are written exactly in the order shown in the code.
+		 * This is particularly important for cases where the DMA engine
+		 * is already running when we are running this code. If the DMA
+		 * sees DT_FSTART without the corresponding DT_FEND it will enter
+		 * an error condition.
+		 */
+		dma_wmb();
 		desc->die_dt = DT_FSTART;
 	} else {
+		/* Descriptor type must be set after all the above writes */
+		dma_wmb();
 		desc->die_dt = DT_FSINGLE;
 	}
+
+	/* Before ringing the doorbell we need to make sure that the latest
+	 * writes have been committed to memory, otherwise it could delay
+	 * things until the doorbell is rang again.
+	 * This is in replacement of the read operation mentioned in the HW
+	 * manuals.
+	 */
+	dma_wmb();
 	ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
 
 	priv->cur_tx[q] += num_tx_desc;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 8f90eae93774..d152afa48d5c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1721,14 +1721,15 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 		}
 	} else {
 		if (bsp_priv->clk_enabled) {
+			if (bsp_priv->ops && bsp_priv->ops->set_clock_selection) {
+				bsp_priv->ops->set_clock_selection(bsp_priv,
+					      bsp_priv->clock_input, false);
+			}
+
 			clk_bulk_disable_unprepare(bsp_priv->num_clks,
 						   bsp_priv->clks);
 			clk_disable_unprepare(bsp_priv->clk_phy);
 
-			if (bsp_priv->ops && bsp_priv->ops->set_clock_selection)
-				bsp_priv->ops->set_clock_selection(bsp_priv,
-					      bsp_priv->clock_input, false);
-
 			bsp_priv->clk_enabled = false;
 		}
 	}
diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index 59d6ab989c55..8ffbfaa3ab18 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -163,7 +163,9 @@ struct am65_cpts {
 	struct device_node *clk_mux_np;
 	struct clk *refclk;
 	u32 refclk_freq;
-	struct list_head events;
+	/* separate lists to handle TX and RX timestamp independently */
+	struct list_head events_tx;
+	struct list_head events_rx;
 	struct list_head pool;
 	struct am65_cpts_event pool_data[AM65_CPTS_MAX_EVENTS];
 	spinlock_t lock; /* protects events lists*/
@@ -227,6 +229,24 @@ static void am65_cpts_disable(struct am65_cpts *cpts)
 	am65_cpts_write32(cpts, 0, int_enable);
 }
 
+static int am65_cpts_purge_event_list(struct am65_cpts *cpts,
+				      struct list_head *events)
+{
+	struct list_head *this, *next;
+	struct am65_cpts_event *event;
+	int removed = 0;
+
+	list_for_each_safe(this, next, events) {
+		event = list_entry(this, struct am65_cpts_event, list);
+		if (time_after(jiffies, event->tmo)) {
+			list_del_init(&event->list);
+			list_add(&event->list, &cpts->pool);
+			++removed;
+		}
+	}
+	return removed;
+}
+
 static int am65_cpts_event_get_port(struct am65_cpts_event *event)
 {
 	return (event->event1 & AM65_CPTS_EVENT_1_PORT_NUMBER_MASK) >>
@@ -239,20 +259,12 @@ static int am65_cpts_event_get_type(struct am65_cpts_event *event)
 		AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT;
 }
 
-static int am65_cpts_cpts_purge_events(struct am65_cpts *cpts)
+static int am65_cpts_purge_events(struct am65_cpts *cpts)
 {
-	struct list_head *this, *next;
-	struct am65_cpts_event *event;
 	int removed = 0;
 
-	list_for_each_safe(this, next, &cpts->events) {
-		event = list_entry(this, struct am65_cpts_event, list);
-		if (time_after(jiffies, event->tmo)) {
-			list_del_init(&event->list);
-			list_add(&event->list, &cpts->pool);
-			++removed;
-		}
-	}
+	removed += am65_cpts_purge_event_list(cpts, &cpts->events_tx);
+	removed += am65_cpts_purge_event_list(cpts, &cpts->events_rx);
 
 	if (removed)
 		dev_dbg(cpts->dev, "event pool cleaned up %d\n", removed);
@@ -287,7 +299,7 @@ static int __am65_cpts_fifo_read(struct am65_cpts *cpts)
 						 struct am65_cpts_event, list);
 
 		if (!event) {
-			if (am65_cpts_cpts_purge_events(cpts)) {
+			if (am65_cpts_purge_events(cpts)) {
 				dev_err(cpts->dev, "cpts: event pool empty\n");
 				ret = -1;
 				goto out;
@@ -306,11 +318,21 @@ static int __am65_cpts_fifo_read(struct am65_cpts *cpts)
 				cpts->timestamp);
 			break;
 		case AM65_CPTS_EV_RX:
+			event->tmo = jiffies +
+				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
+
+			list_move_tail(&event->list, &cpts->events_rx);
+
+			dev_dbg(cpts->dev,
+				"AM65_CPTS_EV_RX e1:%08x e2:%08x t:%lld\n",
+				event->event1, event->event2,
+				event->timestamp);
+			break;
 		case AM65_CPTS_EV_TX:
 			event->tmo = jiffies +
 				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
 
-			list_move_tail(&event->list, &cpts->events);
+			list_move_tail(&event->list, &cpts->events_tx);
 
 			dev_dbg(cpts->dev,
 				"AM65_CPTS_EV_TX e1:%08x e2:%08x t:%lld\n",
@@ -828,7 +850,7 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 	return found;
 }
 
-static void am65_cpts_find_ts(struct am65_cpts *cpts)
+static void am65_cpts_find_tx_ts(struct am65_cpts *cpts)
 {
 	struct am65_cpts_event *event;
 	struct list_head *this, *next;
@@ -837,7 +859,7 @@ static void am65_cpts_find_ts(struct am65_cpts *cpts)
 	LIST_HEAD(events);
 
 	spin_lock_irqsave(&cpts->lock, flags);
-	list_splice_init(&cpts->events, &events);
+	list_splice_init(&cpts->events_tx, &events);
 	spin_unlock_irqrestore(&cpts->lock, flags);
 
 	list_for_each_safe(this, next, &events) {
@@ -850,7 +872,7 @@ static void am65_cpts_find_ts(struct am65_cpts *cpts)
 	}
 
 	spin_lock_irqsave(&cpts->lock, flags);
-	list_splice_tail(&events, &cpts->events);
+	list_splice_tail(&events, &cpts->events_tx);
 	list_splice_tail(&events_free, &cpts->pool);
 	spin_unlock_irqrestore(&cpts->lock, flags);
 }
@@ -861,7 +883,7 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
 	unsigned long flags;
 	long delay = -1;
 
-	am65_cpts_find_ts(cpts);
+	am65_cpts_find_tx_ts(cpts);
 
 	spin_lock_irqsave(&cpts->txq.lock, flags);
 	if (!skb_queue_empty(&cpts->txq))
@@ -905,7 +927,7 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
 
 	spin_lock_irqsave(&cpts->lock, flags);
 	__am65_cpts_fifo_read(cpts);
-	list_for_each_safe(this, next, &cpts->events) {
+	list_for_each_safe(this, next, &cpts->events_rx) {
 		event = list_entry(this, struct am65_cpts_event, list);
 		if (time_after(jiffies, event->tmo)) {
 			list_move(&event->list, &cpts->pool);
@@ -1155,7 +1177,8 @@ struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
 		return ERR_PTR(ret);
 
 	mutex_init(&cpts->ptp_clk_lock);
-	INIT_LIST_HEAD(&cpts->events);
+	INIT_LIST_HEAD(&cpts->events_tx);
+	INIT_LIST_HEAD(&cpts->events_rx);
 	INIT_LIST_HEAD(&cpts->pool);
 	spin_lock_init(&cpts->lock);
 	skb_queue_head_init(&cpts->txq);
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 92e9eb4146d9..f60cf630bdb3 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3870,6 +3870,8 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 {
 	struct lan8814_shared_priv *shared = phydev->shared->priv;
 
+	shared->phydev = phydev;
+
 	/* Initialise shared lock for clock*/
 	mutex_init(&shared->shared_lock);
 
@@ -3921,8 +3923,6 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 
 	phydev_dbg(phydev, "successfully registered ptp clock\n");
 
-	shared->phydev = phydev;
-
 	/* The EP.4 is shared between all the PHYs in the package and also it
 	 * can be accessed by any of the PHYs
 	 */
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 92add3daadbb..278e6cb6f4d9 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -685,9 +685,16 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 	rtl8150_t *dev = netdev_priv(netdev);
 	int count, res;
 
+	/* pad the frame and ensure terminating USB packet, datasheet 9.2.3 */
+	count = max(skb->len, ETH_ZLEN);
+	if (count % 64 == 0)
+		count++;
+	if (skb_padto(skb, count)) {
+		netdev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
 	netif_stop_queue(netdev);
-	count = (skb->len < 60) ? 60 : skb->len;
-	count = (count & 0x3f) ? count : count + 1;
 	dev->tx_skb = skb;
 	usb_fill_bulk_urb(dev->tx_urb, dev->udev, usb_sndbulkpipe(dev->udev, 2),
 		      skb->data, count, write_bulk_callback, dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d1365f558d3..0dd548e2b367 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6048,6 +6048,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 {
 	u16 v;
 	int ret;
+	unsigned int firstbit;
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 
 	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
@@ -6065,7 +6066,10 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 			rq = mps;
 	}
 
-	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
+	firstbit = ffs(rq);
+	if (firstbit < 8)
+		return -EINVAL;
+	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, firstbit - 8);
 
 	if (bridge->no_inc_mrrs) {
 		int max_mrrs = pcie_get_readrq(dev);
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 918cdc31de57..e37682b280db 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -198,7 +198,7 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	hisi_pmu = to_hisi_pmu(event->pmu);
-	if (event->attr.config > hisi_pmu->check_event)
+	if ((event->attr.config & HISI_EVENTID_MASK) > hisi_pmu->check_event)
 		return -EINVAL;
 
 	if (hisi_pmu->on_cpu == -1)
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 25b2d43b72bf..ab5d54170b41 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -43,7 +43,8 @@
 		return FIELD_GET(GENMASK_ULL(hi, lo), event->attr.config);  \
 	}
 
-#define HISI_GET_EVENTID(ev) (ev->hw.config_base & 0xff)
+#define HISI_EVENTID_MASK		GENMASK(7, 0)
+#define HISI_GET_EVENTID(ev)		((ev)->hw.config_base & HISI_EVENTID_MASK)
 
 #define HISI_PMU_EVTYPE_BITS		8
 #define HISI_PMU_EVTYPE_SHIFT(idx)	((idx) % 4 * HISI_PMU_EVTYPE_BITS)
diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
index 8fcf38eed7f0..66deb475f807 100644
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -569,6 +569,11 @@ static ssize_t hsmp_metric_tbl_read(struct file *filp, struct kobject *kobj,
 	if (!sock)
 		return -EINVAL;
 
+	if (!sock->metric_tbl_addr) {
+		dev_err(sock->dev, "Metrics table address not available\n");
+		return -ENOMEM;
+	}
+
 	/* Do not support lseek(), reads entire metric table */
 	if (count < bin_attr->size) {
 		dev_err(sock->dev, "Wrong buffer size\n");
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index efbd80db778d..bd9919c01e50 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2546,7 +2546,7 @@ ptp_ocp_sma_fb_init(struct ptp_ocp *bp)
 		for (i = 0; i < OCP_SMA_NUM; i++) {
 			bp->sma[i].fixed_fcn = true;
 			bp->sma[i].fixed_dir = true;
-			bp->sma[1].dpll_prop.capabilities &=
+			bp->sma[i].dpll_prop.capabilities &=
 				~DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE;
 		}
 		return;
diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 1369691a997b..b78163eaed61 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -192,6 +192,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -206,13 +214,6 @@ enum airoha_snand_cs {
 	SPI_CHIP_SEL_LOW,
 };
 
-struct airoha_snand_dev {
-	size_t buf_len;
-
-	u8 *txrx_buf;
-	dma_addr_t dma_addr;
-};
-
 struct airoha_snand_ctrl {
 	struct device *dev;
 	struct regmap *regmap_ctrl;
@@ -394,10 +395,26 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
 	return regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -416,16 +433,32 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
 
@@ -617,14 +650,18 @@ static bool airoha_snand_supports_op(struct spi_mem *mem,
 
 static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(desc->mem->spi);
+	u8 *txrx_buf = spi_get_ctldata(desc->mem->spi);
 
-	if (!as_dev->txrx_buf)
+	if (!txrx_buf)
 		return -EINVAL;
 
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
@@ -634,10 +671,11 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_device *spi = desc->mem->spi;
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
 	struct spi_mem_op *op = &desc->info.op_tmpl;
+	struct spi_device *spi = desc->mem->spi;
 	struct airoha_snand_ctrl *as_ctrl;
+	u8 *txrx_buf = spi_get_ctldata(spi);
+	dma_addr_t dma_addr;
 	u32 val, rd_mode;
 	int err;
 
@@ -660,16 +698,19 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
-	dma_sync_single_for_device(as_ctrl->dev, as_dev->dma_addr,
-				   as_dev->buf_len, DMA_BIDIRECTIONAL);
+	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_FROM_DEVICE);
+	err = dma_mapping_error(as_ctrl->dev, dma_addr);
+	if (err)
+		goto error_dma_mode_off;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
-			   as_dev->dma_addr);
+			   dma_addr);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* set cust sec size */
 	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
@@ -678,58 +719,59 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_READ_DATA_BYTE_NUM, val);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* set read command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL2,
 			   op->cmd.opcode);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* set read mode */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
 			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, rd_mode));
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
-	/* set read addr */
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* set nfi read */
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
 				 SPI_NFI_OPMODE,
 				 FIELD_PREP(SPI_NFI_OPMODE, 6));
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
 			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* trigger dma start read */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_RD_TRIG);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 			      SPI_NFI_RD_TRIG);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_read_poll_timeout(as_ctrl->regmap_nfi,
 				       REG_SPI_NFI_SNF_STA_CTL1, val,
 				       (val & SPI_NFI_READ_FROM_CACHE_DONE),
 				       0, 1 * USEC_PER_SEC);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/*
 	 * SPI_NFI_READ_FROM_CACHE_DONE bit must be written at the end
@@ -739,35 +781,43 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				SPI_NFI_READ_FROM_CACHE_DONE,
 				SPI_NFI_READ_FROM_CACHE_DONE);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_read_poll_timeout(as_ctrl->regmap_nfi, REG_SPI_NFI_INTR,
 				       val, (val & SPI_NFI_AHB_DONE), 0,
 				       1 * USEC_PER_SEC);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* DMA read need delay for data ready from controller to DRAM */
 	udelay(1);
 
-	dma_sync_single_for_cpu(as_ctrl->dev, as_dev->dma_addr,
-				as_dev->buf_len, DMA_BIDIRECTIONAL);
+	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
+			 DMA_FROM_DEVICE);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
 		return err;
 
-	memcpy(buf, as_dev->txrx_buf + offs, len);
+	memcpy(buf, txrx_buf + offs, len);
 
 	return len;
+
+error_dma_unmap:
+	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
+			 DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
+	return err;
 }
 
 static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 					 u64 offs, size_t len, const void *buf)
 {
-	struct spi_device *spi = desc->mem->spi;
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
 	struct spi_mem_op *op = &desc->info.op_tmpl;
+	struct spi_device *spi = desc->mem->spi;
+	u8 *txrx_buf = spi_get_ctldata(spi);
 	struct airoha_snand_ctrl *as_ctrl;
+	dma_addr_t dma_addr;
 	u32 wr_mode, val;
 	int err;
 
@@ -776,19 +826,20 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	dma_sync_single_for_cpu(as_ctrl->dev, as_dev->dma_addr,
-				as_dev->buf_len, DMA_BIDIRECTIONAL);
-	memcpy(as_dev->txrx_buf + offs, buf, len);
-	dma_sync_single_for_device(as_ctrl->dev, as_dev->dma_addr,
-				   as_dev->buf_len, DMA_BIDIRECTIONAL);
+	memcpy(txrx_buf + offs, buf, len);
+	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_TO_DEVICE);
+	err = dma_mapping_error(as_ctrl->dev, dma_addr);
+	if (err)
+		return err;
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
-		return err;
+		goto error_dma_unmap;
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	if (op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_QUAD ||
 	    op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD)
@@ -797,9 +848,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		wr_mode = 0;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
-			   as_dev->dma_addr);
+			   dma_addr);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
 			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
@@ -807,65 +858,67 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL1,
 			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD,
 				      op->cmd.opcode));
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
 			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, wr_mode));
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2, 0x0);
+	/* set write addr: zero page offset + descriptor write offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   desc->info.offset);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
 				SPI_NFI_READ_MODE);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
 				 SPI_NFI_OPMODE,
 				 FIELD_PREP(SPI_NFI_OPMODE, 3));
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
 			      SPI_NFI_DMA_MODE);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_WR_TRIG);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 			      SPI_NFI_WR_TRIG);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_read_poll_timeout(as_ctrl->regmap_nfi, REG_SPI_NFI_INTR,
 				       val, (val & SPI_NFI_AHB_DONE), 0,
 				       1 * USEC_PER_SEC);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_read_poll_timeout(as_ctrl->regmap_nfi,
 				       REG_SPI_NFI_SNF_STA_CTL1, val,
 				       (val & SPI_NFI_LOAD_TO_CACHE_DONE),
 				       0, 1 * USEC_PER_SEC);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/*
 	 * SPI_NFI_LOAD_TO_CACHE_DONE bit must be written at the end
@@ -875,24 +928,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 				SPI_NFI_LOAD_TO_CACHE_DONE,
 				SPI_NFI_LOAD_TO_CACHE_DONE);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
+	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
+			 DMA_TO_DEVICE);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
 		return err;
 
 	return len;
+
+error_dma_unmap:
+	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
+			 DMA_TO_DEVICE);
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
+	return err;
 }
 
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
+	int op_len, addr_len, dummy_len;
+	u8 buf[20], *data;
 	int i, err;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -903,40 +980,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(as_ctrl, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(as_ctrl, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
@@ -956,42 +1033,20 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
-	struct airoha_snand_dev *as_dev;
-
-	as_ctrl = spi_controller_get_devdata(spi->controller);
-
-	as_dev = devm_kzalloc(as_ctrl->dev, sizeof(*as_dev), GFP_KERNEL);
-	if (!as_dev)
-		return -ENOMEM;
+	u8 *txrx_buf;
 
 	/* prepare device buffer */
-	as_dev->buf_len = SPI_NAND_CACHE_SIZE;
-	as_dev->txrx_buf = devm_kzalloc(as_ctrl->dev, as_dev->buf_len,
-					GFP_KERNEL);
-	if (!as_dev->txrx_buf)
-		return -ENOMEM;
-
-	as_dev->dma_addr = dma_map_single(as_ctrl->dev, as_dev->txrx_buf,
-					  as_dev->buf_len, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(as_ctrl->dev, as_dev->dma_addr))
+	as_ctrl = spi_controller_get_devdata(spi->controller);
+	txrx_buf = devm_kzalloc(as_ctrl->dev, SPI_NAND_CACHE_SIZE,
+				GFP_KERNEL);
+	if (!txrx_buf)
 		return -ENOMEM;
 
-	spi_set_ctldata(spi, as_dev);
+	spi_set_ctldata(spi, txrx_buf);
 
 	return 0;
 }
 
-static void airoha_snand_cleanup(struct spi_device *spi)
-{
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
-	struct airoha_snand_ctrl *as_ctrl;
-
-	as_ctrl = spi_controller_get_devdata(spi->controller);
-	dma_unmap_single(as_ctrl->dev, as_dev->dma_addr,
-			 as_dev->buf_len, DMA_BIDIRECTIONAL);
-	spi_set_ctldata(spi, NULL);
-}
-
 static int airoha_snand_nfi_setup(struct airoha_snand_ctrl *as_ctrl)
 {
 	u32 val, sec_size, sec_num;
@@ -1093,7 +1148,6 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
-	ctrl->cleanup = airoha_snand_cleanup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
 	err = airoha_snand_nfi_setup(as_ctrl);
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 5a1e55a01c52..b569302f22e6 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -665,6 +665,12 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 				   0, POLL_TOUT, true);
 	if (ret)
 		dev_warn(f->dev, "DLL lock failed, please fix it!\n");
+
+	/*
+	 * For ERR050272, DLL lock status bit is not accurate,
+	 * wait for 4us more as a workaround.
+	 */
+	udelay(4);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 51894c93c8a3..83d186c038cd 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -620,7 +620,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index b7a75db15249..5ed6514ec88a 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -39,6 +39,8 @@
 #define PCI_DEVICE_ID_ACCESSIO_COM_4SM		0x10db
 #define PCI_DEVICE_ID_ACCESSIO_COM_8SM		0x10ea
 
+#define PCI_DEVICE_ID_ADVANTECH_XR17V352	0x0018
+
 #define PCI_DEVICE_ID_COMMTECH_4224PCI335	0x0002
 #define PCI_DEVICE_ID_COMMTECH_4222PCI335	0x0004
 #define PCI_DEVICE_ID_COMMTECH_2324PCI335	0x000a
@@ -1678,6 +1680,12 @@ static const struct exar8250_board pbn_fastcom35x_8 = {
 	.exit		= pci_xr17v35x_exit,
 };
 
+static const struct exar8250_board pbn_adv_XR17V352 = {
+	.num_ports	= 2,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
 static const struct exar8250_board pbn_exar_XR17V4358 = {
 	.num_ports	= 12,
 	.setup		= pci_xr17v35x_setup,
@@ -1752,6 +1760,9 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	USR_DEVICE(XR17C152, 2980, pbn_exar_XR17C15x),
 	USR_DEVICE(XR17C152, 2981, pbn_exar_XR17C15x),
 
+	/* ADVANTECH devices */
+	EXAR_DEVICE(ADVANTECH, XR17V352, pbn_adv_XR17V352),
+
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
 	EXAR_DEVICE(EXAR, XR17C152, pbn_exar_XR17C15x),
 	EXAR_DEVICE(EXAR, XR17C154, pbn_exar_XR17C15x),
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b9cca210e171..1c878986fcec 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -435,6 +435,7 @@ static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 	while
 		(serial_in(up, MTK_UART_DEBUG0));
 
+	clk_disable_unprepare(data->uart_clk);
 	clk_disable_unprepare(data->bus_clk);
 
 	return 0;
@@ -445,6 +446,7 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
 	clk_prepare_enable(data->bus_clk);
+	clk_prepare_enable(data->uart_clk);
 
 	return 0;
 }
@@ -475,13 +477,13 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 	int dmacnt;
 #endif
 
-	data->uart_clk = devm_clk_get(&pdev->dev, "baud");
+	data->uart_clk = devm_clk_get_enabled(&pdev->dev, "baud");
 	if (IS_ERR(data->uart_clk)) {
 		/*
 		 * For compatibility with older device trees try unnamed
 		 * clk when no baud clk can be found.
 		 */
-		data->uart_clk = devm_clk_get(&pdev->dev, NULL);
+		data->uart_clk = devm_clk_get_enabled(&pdev->dev, NULL);
 		if (IS_ERR(data->uart_clk)) {
 			dev_warn(&pdev->dev, "Can't get uart clock\n");
 			return PTR_ERR(data->uart_clk);
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 835bd453c0e8..8ed8ee58e318 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -585,13 +585,6 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 		div /= prescaler;
 	}
 
-	/* Enable enhanced features */
-	sc16is7xx_efr_lock(port);
-	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
-			      SC16IS7XX_EFR_ENABLE_BIT,
-			      SC16IS7XX_EFR_ENABLE_BIT);
-	sc16is7xx_efr_unlock(port);
-
 	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index c0fd8ab3fe8f..c322d0c1d965 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -464,6 +464,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Huawei 4G LTE module */
 	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
+	{ USB_DEVICE(0x12d1, 0x15c1), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
 	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
 
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 112fd18d8c99..c713a9854a3e 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -667,8 +667,6 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
 		return ERR_PTR(-EINVAL);
 	if (!usb_raw_io_flags_valid(io->flags))
 		return ERR_PTR(-EINVAL);
-	if (io->length > PAGE_SIZE)
-		return ERR_PTR(-EINVAL);
 	if (get_from_user)
 		data = memdup_user(ptr + sizeof(*io), io->length);
 	else {
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 123506681ef0..e36e2c031a8f 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -891,7 +891,8 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			dev_info(dbc->dev, "DbC configured\n");
 			portsc = readl(&dbc->regs->portsc);
 			writel(portsc, &dbc->regs->portsc);
-			return EVT_GSER;
+			ret = EVT_GSER;
+			break;
 		}
 
 		return EVT_DONE;
@@ -951,7 +952,8 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			break;
 		case TRB_TYPE(TRB_TRANSFER):
 			dbc_handle_xfer_event(dbc, evt);
-			ret = EVT_XFER_DONE;
+			if (ret != EVT_GSER)
+				ret = EVT_XFER_DONE;
 			break;
 		default:
 			break;
@@ -1387,8 +1389,15 @@ int xhci_dbc_suspend(struct xhci_hcd *xhci)
 	if (!dbc)
 		return 0;
 
-	if (dbc->state == DS_CONFIGURED)
+	switch (dbc->state) {
+	case DS_ENABLED:
+	case DS_CONNECTED:
+	case DS_CONFIGURED:
 		dbc->resume_required = 1;
+		break;
+	default:
+		break;
+	}
 
 	xhci_dbc_stop(dbc);
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 62e984d20e59..5de856f65f0d 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -273,6 +273,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM05CN			0x0312
 #define QUECTEL_PRODUCT_EM05G_GR		0x0313
 #define QUECTEL_PRODUCT_EM05G_RS		0x0314
+#define QUECTEL_PRODUCT_RG255C			0x0316
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_RM520N			0x0801
@@ -617,6 +618,7 @@ static void option_instat_callback(struct urb *urb);
 #define UNISOC_VENDOR_ID			0x1782
 /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
 #define TOZED_PRODUCT_LT70C			0x4055
+#define UNISOC_PRODUCT_UIS7720			0x4064
 /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
 #define LUAT_PRODUCT_AIR720U			0x4e00
 
@@ -1270,6 +1272,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0xff, 0x40) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
@@ -1398,10 +1403,14 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a2, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a3, 0xff),	/* Telit FN920C04 (ECM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a7, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a8, 0xff),	/* Telit FN920C04 (ECM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a9, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
@@ -2466,6 +2475,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, UNISOC_PRODUCT_UIS7720, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
 	  .driver_info = NCTRL(1) },
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 92ce01b7d049..b0e6c58e6a59 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7696,9 +7696,9 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 	port->partner_desc.identity = &port->partner_ident;
 
-	port->role_sw = usb_role_switch_get(port->dev);
+	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
 	if (!port->role_sw)
-		port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
+		port->role_sw = usb_role_switch_get(port->dev);
 	if (IS_ERR(port->role_sw)) {
 		err = PTR_ERR(port->role_sw);
 		goto out_destroy_wq;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 69f9d5f5cc3c..b0d4ad7fbe48 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2029,7 +2029,13 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
 	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
 	if (!fs_info->super_copy || !fs_info->super_for_commit) {
-		btrfs_free_fs_info(fs_info);
+		/*
+		 * Dont call btrfs_free_fs_info() to free it as it's still
+		 * initialized partially.
+		 */
+		kfree(fs_info->super_copy);
+		kfree(fs_info->super_for_commit);
+		kvfree(fs_info);
 		return -ENOMEM;
 	}
 	btrfs_init_fs_info(fs_info);
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 8afac6e2dff0..7b4b6977dcd6 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -730,7 +730,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_device_deregister(ls);
 
-	if (force < 3 && dlm_user_daemon_available())
+	if (force != 3 && dlm_user_daemon_available())
 		do_uevent(ls, 0);
 
 	dlm_recoverd_stop(ls);
diff --git a/fs/exec.c b/fs/exec.c
index d60794372963..030240d99ab7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -717,7 +717,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
 		    int executable_stack)
 {
-	unsigned long ret;
+	int ret;
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 9e27dd8bef88..38ea69ca2303 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -321,12 +321,6 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	gfs2_sbstats_inc(gl, GFS2_LKS_DCOUNT);
 	gfs2_update_request_times(gl);
 
-	/* don't want to call dlm if we've unmounted the lock protocol */
-	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
-		gfs2_glock_free(gl);
-		return;
-	}
-
 	/*
 	 * When the lockspace is released, all remaining glocks will be
 	 * unlocked automatically.  This is more efficient than unlocking them
@@ -348,6 +342,11 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		goto again;
 	}
 
+	if (error == -ENODEV) {
+		gfs2_glock_free(gl);
+		return;
+	}
+
 	if (error) {
 		fs_err(sdp, "gdlm_unlock %x,%llx err=%d\n",
 		       gl->gl_name.ln_type,
diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 34e9804e0f36..e46f650b5e9c 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -21,7 +21,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -115,6 +115,12 @@ int hfs_brec_find(struct hfs_find_data *fd)
 	__be32 data;
 	int height, res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	tree = fd->tree;
 	if (fd->bnode)
 		hfs_bnode_put(fd->bnode);
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 896396554bcc..b01db1fae147 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -179,6 +179,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *parent;
 	int end_off, rec_off, data_off, size;
+	int src, dst, len;
 
 	tree = fd->tree;
 	node = fd->bnode;
@@ -208,10 +209,14 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	}
 	hfs_bnode_write_u16(node, offsetof(struct hfs_bnode_desc, num_recs), node->num_recs);
 
-	if (rec_off == end_off)
-		goto skip;
 	size = fd->keylength + fd->entrylength;
 
+	if (rec_off == end_off) {
+		src = fd->keyoffset;
+		hfs_bnode_clear(node, src, size);
+		goto skip;
+	}
+
 	do {
 		data_off = hfs_bnode_read_u16(node, rec_off);
 		hfs_bnode_write_u16(node, rec_off + 2, data_off - size);
@@ -219,9 +224,23 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	} while (rec_off >= end_off);
 
 	/* fill hole */
-	hfs_bnode_move(node, fd->keyoffset, fd->keyoffset + size,
-		       data_off - fd->keyoffset - size);
+	dst = fd->keyoffset;
+	src = fd->keyoffset + size;
+	len = data_off - src;
+
+	hfs_bnode_move(node, dst, src, len);
+
+	src = dst + len;
+	len = data_off - src;
+
+	hfs_bnode_clear(node, src, len);
+
 skip:
+	/*
+	 * Remove the obsolete offset to free space.
+	 */
+	hfs_bnode_write_u16(node, end_off, 0);
+
 	hfs_bnode_dump(node);
 	if (!fd->record)
 		hfs_brec_update_parent(fd);
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 8082eb01127c..bf811347bb07 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -172,7 +172,7 @@ int hfs_mdb_get(struct super_block *sb)
 		pr_warn("continuing without an alternate MDB\n");
 	}
 
-	HFS_SB(sb)->bitmap = kmalloc(8192, GFP_KERNEL);
+	HFS_SB(sb)->bitmap = kzalloc(8192, GFP_KERNEL);
 	if (!HFS_SB(sb)->bitmap)
 		goto out;
 
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d20..26ebac4c6042 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -158,6 +158,12 @@ int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare)
 	__be32 data;
 	int height, res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	tree = fd->tree;
 	if (fd->bnode)
 		hfs_bnode_put(fd->bnode);
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 14f4995588ff..407d5152eb41 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -18,47 +18,6 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
-static inline
-bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
-{
-	bool is_valid = off < node->tree->node_size;
-
-	if (!is_valid) {
-		pr_err("requested invalid offset: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off);
-	}
-
-	return is_valid;
-}
-
-static inline
-int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
-{
-	unsigned int node_size;
-
-	if (!is_bnode_offset_valid(node, off))
-		return 0;
-
-	node_size = node->tree->node_size;
-
-	if ((off + len) > node_size) {
-		int new_len = (int)node_size - off;
-
-		pr_err("requested length has been corrected: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, "
-		       "requested_len %d, corrected_len %d\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off, len, new_len);
-
-		return new_len;
-	}
-
-	return len;
-}
 
 /* Copy a specified range of bytes from the raw data of a node */
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 9e1732a2b92a..fe6a54c4083c 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -393,6 +393,12 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	len = hfs_brec_lenoff(node, 2, &off16);
 	off = off16;
 
+	if (!is_bnode_offset_valid(node, off)) {
+		hfs_bnode_put(node);
+		return ERR_PTR(-EIO);
+	}
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	data = kmap_local_page(*pagep);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 5389918bbf29..6c19935d6f50 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -575,6 +575,48 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
 	return class;
 }
 
+static inline
+bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+{
+	bool is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline
+int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((off + len) > node_size) {
+		int new_len = (int)node_size - off;
+
+		pr_err("requested length has been corrected: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, "
+		       "requested_len %d, corrected_len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
+
 /* compatibility */
 #define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 97920202790f..0831cd7aa5de 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -67,13 +67,26 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
-	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
-	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
-	mutex_init(&HFSPLUS_I(inode)->extents_lock);
-	HFSPLUS_I(inode)->flags = 0;
+	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	HFSPLUS_I(inode)->first_blocks = 0;
+	HFSPLUS_I(inode)->clump_blocks = 0;
+	HFSPLUS_I(inode)->alloc_blocks = 0;
+	HFSPLUS_I(inode)->cached_start = U32_MAX;
+	HFSPLUS_I(inode)->cached_blocks = 0;
+	memset(HFSPLUS_I(inode)->first_extents, 0, sizeof(hfsplus_extent_rec));
+	memset(HFSPLUS_I(inode)->cached_extents, 0, sizeof(hfsplus_extent_rec));
 	HFSPLUS_I(inode)->extent_state = 0;
+	mutex_init(&HFSPLUS_I(inode)->extents_lock);
 	HFSPLUS_I(inode)->rsrc_inode = NULL;
-	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	HFSPLUS_I(inode)->create_date = 0;
+	HFSPLUS_I(inode)->linkid = 0;
+	HFSPLUS_I(inode)->flags = 0;
+	HFSPLUS_I(inode)->fs_blocks = 0;
+	HFSPLUS_I(inode)->userflags = 0;
+	HFSPLUS_I(inode)->subfolders = 0;
+	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
+	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
+	HFSPLUS_I(inode)->phys_size = 0;
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||
 	    inode->i_ino == HFSPLUS_ROOT_CNID) {
@@ -531,7 +544,7 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
 		hfs_find_exit(&fd);
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
-			err = -EINVAL;
+			err = -EIO;
 			goto out_put_root;
 		}
 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index e933f9c65d90..d2aa8985c055 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -17,6 +17,7 @@
 #include "fanotify/fanotify.h"
 #include "fdinfo.h"
 #include "fsnotify.h"
+#include "../internal.h"
 
 #if defined(CONFIG_PROC_FS)
 
@@ -46,7 +47,12 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 
 	size = f->handle_bytes >> 2;
 
+	if (!super_trylock_shared(inode->i_sb))
+		return;
+
 	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
+	up_read(&inode->i_sb->s_umount);
+
 	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
 
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index f9d6a4f9ca92..aa595cd1ab6f 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -868,6 +868,11 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
 			mlog_errno(ret);
 			goto out;
 		}
+		/*
+		 * Invalidate extent cache after moving/defragging to prevent
+		 * stale cached data with outdated extent flags.
+		 */
+		ocfs2_extent_map_trunc(inode, cpos);
 
 		context->clusters_moved += alloc_size;
 next:
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index b74637ae9085..6a35e884b41f 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -703,7 +703,7 @@ struct TCP_Server_Info {
 	bool nosharesock;
 	bool tcp_nodelay;
 	bool terminate;
-	unsigned int credits;  /* send no more requests at once */
+	int credits;  /* send no more requests at once */
 	unsigned int max_credits; /* can override large 32000 default at mnt */
 	unsigned int in_flight;  /* number of requests on the wire to server */
 	unsigned int max_in_flight; /* max number of requests that were on wire */
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 816f136ce5c4..ce5c50ac987c 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -263,10 +263,16 @@ static void ipc_msg_handle_free(int handle)
 
 static int handle_response(int type, void *payload, size_t sz)
 {
-	unsigned int handle = *(unsigned int *)payload;
+	unsigned int handle;
 	struct ipc_msg_table_entry *entry;
 	int ret = 0;
 
+	/* Prevent 4-byte read beyond declared payload size */
+	if (sz < sizeof(unsigned int))
+		return -EINVAL;
+
+	handle = *(unsigned int *)payload;
+
 	ipc_update_last_active();
 	down_read(&ipc_msg_table_lock);
 	hash_for_each_possible(ipc_msg_table, entry, ipc_table_hlist, handle) {
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 05dfef7ad67f..bf79c066a982 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -938,12 +938,15 @@ static int smb_direct_flush_send_list(struct smb_direct_transport *t,
 			       struct smb_direct_sendmsg,
 			       list);
 
+	if (send_ctx->need_invalidate_rkey) {
+		first->wr.opcode = IB_WR_SEND_WITH_INV;
+		first->wr.ex.invalidate_rkey = send_ctx->remote_key;
+		send_ctx->need_invalidate_rkey = false;
+		send_ctx->remote_key = 0;
+	}
+
 	last->wr.send_flags = IB_SEND_SIGNALED;
 	last->wr.wr_cqe = &last->cqe;
-	if (is_last && send_ctx->need_invalidate_rkey) {
-		last->wr.opcode = IB_WR_SEND_WITH_INV;
-		last->wr.ex.invalidate_rkey = send_ctx->remote_key;
-	}
 
 	ret = smb_direct_post_send(t, &first->wr);
 	if (!ret) {
diff --git a/fs/xfs/scrub/nlinks.c b/fs/xfs/scrub/nlinks.c
index 80aee30886c4..02f5522552db 100644
--- a/fs/xfs/scrub/nlinks.c
+++ b/fs/xfs/scrub/nlinks.c
@@ -376,6 +376,36 @@ xchk_nlinks_collect_pptr(
 	return error;
 }
 
+static uint
+xchk_nlinks_ilock_dir(
+	struct xfs_inode	*ip)
+{
+	uint			lock_mode = XFS_ILOCK_SHARED;
+
+	/*
+	 * We're going to scan the directory entries, so we must be ready to
+	 * pull the data fork mappings into memory if they aren't already.
+	 */
+	if (xfs_need_iread_extents(&ip->i_df))
+		lock_mode = XFS_ILOCK_EXCL;
+
+	/*
+	 * We're going to scan the parent pointers, so we must be ready to
+	 * pull the attr fork mappings into memory if they aren't already.
+	 */
+	if (xfs_has_parent(ip->i_mount) && xfs_inode_has_attr_fork(ip) &&
+	    xfs_need_iread_extents(&ip->i_af))
+		lock_mode = XFS_ILOCK_EXCL;
+
+	/*
+	 * Take the IOLOCK so that other threads cannot start a directory
+	 * update while we're scanning.
+	 */
+	lock_mode |= XFS_IOLOCK_SHARED;
+	xfs_ilock(ip, lock_mode);
+	return lock_mode;
+}
+
 /* Walk a directory to bump the observed link counts of the children. */
 STATIC int
 xchk_nlinks_collect_dir(
@@ -394,8 +424,7 @@ xchk_nlinks_collect_dir(
 		return 0;
 
 	/* Prevent anyone from changing this directory while we walk it. */
-	xfs_ilock(dp, XFS_IOLOCK_SHARED);
-	lock_mode = xfs_ilock_data_map_shared(dp);
+	lock_mode = xchk_nlinks_ilock_dir(dp);
 
 	/*
 	 * The dotdot entry of an unlinked directory still points to the last
@@ -452,7 +481,6 @@ xchk_nlinks_collect_dir(
 	xchk_iscan_abort(&xnc->collect_iscan);
 out_unlock:
 	xfs_iunlock(dp, lock_mode);
-	xfs_iunlock(dp, XFS_IOLOCK_SHARED);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 201a86b3574d..77eaff6e16b1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1232,16 +1232,25 @@ suffix_kstrtoint(
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
-	struct fs_parameter	*param,
-	uint64_t		flag,
-	bool			value)
+	struct fs_parameter	*param)
 {
-	/* Don't print the warning if reconfiguring and current mount point
-	 * already had the flag set
+	/*
+	 * Always warn about someone passing in a deprecated mount option.
+	 * Previously we wouldn't print the warning if we were reconfiguring
+	 * and current mount point already had the flag set, but that was not
+	 * the right thing to do.
+	 *
+	 * Many distributions mount the root filesystem with no options in the
+	 * initramfs and rely on mount -a to remount the root fs with the
+	 * options in fstab.  However, the old behavior meant that there would
+	 * never be a warning about deprecated mount options for the root fs in
+	 * /etc/fstab.  On a single-fs system, that means no warning at all.
+	 *
+	 * Compounding this problem are distribution scripts that copy
+	 * /proc/mounts to fstab, which means that we can't remove mount
+	 * options unless we're 100% sure they have only ever been advertised
+	 * in /proc/mounts in response to explicitly provided mount options.
 	 */
-	if ((fc->purpose & FS_CONTEXT_FOR_RECONFIGURE) &&
-            !!(XFS_M(fc->root->d_sb)->m_features & flag) == value)
-		return;
 	xfs_warn(fc->s_fs_info, "%s mount option is deprecated.", param->key);
 }
 
@@ -1380,19 +1389,19 @@ xfs_fs_parse_param(
 #endif
 	/* Following mount options will be removed in September 2025 */
 	case Opt_ikeep:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_IKEEP;
 		return 0;
 	case Opt_noikeep:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, false);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features &= ~XFS_FEAT_IKEEP;
 		return 0;
 	case Opt_attr2:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_ATTR2, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_ATTR2;
 		return 0;
 	case Opt_noattr2:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_NOATTR2, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_NOATTR2;
 		return 0;
 	default:
diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index c6c624eb9866..5c0a02bfeb55 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -55,7 +55,6 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *file)
 	struct io_ring_ctx *ctx = file->private_data;
 	struct io_overflow_cqe *ocqe;
 	struct io_rings *r = ctx->rings;
-	struct rusage sq_usage;
 	unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
 	unsigned int sq_head = READ_ONCE(r->sq.head);
 	unsigned int sq_tail = READ_ONCE(r->sq.tail);
@@ -155,14 +154,15 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *file)
 		 * thread termination.
 		 */
 		if (tsk) {
+			u64 usec;
+
 			get_task_struct(tsk);
 			rcu_read_unlock();
-			getrusage(tsk, RUSAGE_SELF, &sq_usage);
+			usec = io_sq_cpu_usec(tsk);
 			put_task_struct(tsk);
 			sq_pid = sq->task_pid;
 			sq_cpu = sq->sq_cpu;
-			sq_total_time = (sq_usage.ru_stime.tv_sec * 1000000
-					 + sq_usage.ru_stime.tv_usec);
+			sq_total_time = usec;
 			sq_work_time = sq->work_time;
 		} else {
 			rcu_read_unlock();
diff --git a/io_uring/filetable.c b/io_uring/filetable.c
index 997c56d32ee6..6183d61c7222 100644
--- a/io_uring/filetable.c
+++ b/io_uring/filetable.c
@@ -62,7 +62,7 @@ void io_free_file_tables(struct io_file_table *table)
 
 static int io_install_fixed_file(struct io_ring_ctx *ctx, struct file *file,
 				 u32 slot_index)
-	__must_hold(&req->ctx->uring_lock)
+	__must_hold(&ctx->uring_lock)
 {
 	struct io_fixed_file *file_slot;
 	int ret;
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 2faa3058b2d0..44e7959b52d9 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -11,6 +11,7 @@
 #include <linux/audit.h>
 #include <linux/security.h>
 #include <linux/cpuset.h>
+#include <linux/sched/cputime.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
@@ -175,7 +176,38 @@ static inline bool io_sqd_events_pending(struct io_sq_data *sqd)
 	return READ_ONCE(sqd->state);
 }
 
-static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
+struct io_sq_time {
+	bool started;
+	u64 usec;
+};
+
+u64 io_sq_cpu_usec(struct task_struct *tsk)
+{
+	u64 utime, stime;
+
+	task_cputime_adjusted(tsk, &utime, &stime);
+	do_div(stime, 1000);
+	return stime;
+}
+
+static void io_sq_update_worktime(struct io_sq_data *sqd, struct io_sq_time *ist)
+{
+	if (!ist->started)
+		return;
+	ist->started = false;
+	sqd->work_time += io_sq_cpu_usec(current) - ist->usec;
+}
+
+static void io_sq_start_worktime(struct io_sq_time *ist)
+{
+	if (ist->started)
+		return;
+	ist->started = true;
+	ist->usec = io_sq_cpu_usec(current);
+}
+
+static int __io_sq_thread(struct io_ring_ctx *ctx, struct io_sq_data *sqd,
+			  bool cap_entries, struct io_sq_time *ist)
 {
 	unsigned int to_submit;
 	int ret = 0;
@@ -188,6 +220,8 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 	if (to_submit || !wq_list_empty(&ctx->iopoll_list)) {
 		const struct cred *creds = NULL;
 
+		io_sq_start_worktime(ist);
+
 		if (ctx->sq_creds != current_cred())
 			creds = override_creds(ctx->sq_creds);
 
@@ -261,23 +295,11 @@ static bool io_sq_tw_pending(struct llist_node *retry_list)
 	return retry_list || !llist_empty(&tctx->task_list);
 }
 
-static void io_sq_update_worktime(struct io_sq_data *sqd, struct rusage *start)
-{
-	struct rusage end;
-
-	getrusage(current, RUSAGE_SELF, &end);
-	end.ru_stime.tv_sec -= start->ru_stime.tv_sec;
-	end.ru_stime.tv_usec -= start->ru_stime.tv_usec;
-
-	sqd->work_time += end.ru_stime.tv_usec + end.ru_stime.tv_sec * 1000000;
-}
-
 static int io_sq_thread(void *data)
 {
 	struct llist_node *retry_list = NULL;
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
-	struct rusage start;
 	unsigned long timeout = 0;
 	char buf[TASK_COMM_LEN];
 	DEFINE_WAIT(wait);
@@ -315,6 +337,7 @@ static int io_sq_thread(void *data)
 	mutex_lock(&sqd->lock);
 	while (1) {
 		bool cap_entries, sqt_spin = false;
+		struct io_sq_time ist = { };
 
 		if (io_sqd_events_pending(sqd) || signal_pending(current)) {
 			if (io_sqd_handle_event(sqd))
@@ -323,9 +346,8 @@ static int io_sq_thread(void *data)
 		}
 
 		cap_entries = !list_is_singular(&sqd->ctx_list);
-		getrusage(current, RUSAGE_SELF, &start);
 		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
-			int ret = __io_sq_thread(ctx, cap_entries);
+			int ret = __io_sq_thread(ctx, sqd, cap_entries, &ist);
 
 			if (!sqt_spin && (ret > 0 || !wq_list_empty(&ctx->iopoll_list)))
 				sqt_spin = true;
@@ -333,15 +355,18 @@ static int io_sq_thread(void *data)
 		if (io_sq_tw(&retry_list, IORING_TW_CAP_ENTRIES_VALUE))
 			sqt_spin = true;
 
-		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
-			if (io_napi(ctx))
+		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
+			if (io_napi(ctx)) {
+				io_sq_start_worktime(&ist);
 				io_napi_sqpoll_busy_poll(ctx);
+			}
+		}
+
+		io_sq_update_worktime(sqd, &ist);
 
 		if (sqt_spin || !time_after(jiffies, timeout)) {
-			if (sqt_spin) {
-				io_sq_update_worktime(sqd, &start);
+			if (sqt_spin)
 				timeout = jiffies + sqd->sq_thread_idle;
-			}
 			if (unlikely(need_resched())) {
 				mutex_unlock(&sqd->lock);
 				cond_resched();
diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
index b83dcdec9765..fd2f6f29b516 100644
--- a/io_uring/sqpoll.h
+++ b/io_uring/sqpoll.h
@@ -29,6 +29,7 @@ void io_sq_thread_unpark(struct io_sq_data *sqd);
 void io_put_sq_data(struct io_sq_data *sqd);
 void io_sqpoll_wait_sq(struct io_ring_ctx *ctx);
 int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx, cpumask_var_t mask);
+u64 io_sq_cpu_usec(struct task_struct *tsk);
 
 static inline struct task_struct *sqpoll_task_locked(struct io_sq_data *sqd)
 {
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 39972e834e7a..035dda07ab0d 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -23,6 +23,7 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/swiotlb.h>
 #include <asm/sections.h>
 #include "debug.h"
 
@@ -594,7 +595,9 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
 			"cacheline tracking EEXIST, overlapping mappings aren't supported\n");
 	}
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 1c9fe741fe6d..d839b564522f 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -722,11 +722,24 @@ static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
  * Adjustment of CPU performance values after boot, when all CPUs capacites
  * are correctly calculated.
  */
-static void em_adjust_new_capacity(struct device *dev,
-				   struct em_perf_domain *pd,
-				   u64 max_cap)
+static void em_adjust_new_capacity(unsigned int cpu, struct device *dev,
+				   struct em_perf_domain *pd)
 {
+	unsigned long cpu_capacity = arch_scale_cpu_capacity(cpu);
 	struct em_perf_table *em_table;
+	struct em_perf_state *table;
+	unsigned long em_max_perf;
+
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
+	em_max_perf = table[pd->nr_perf_states - 1].performance;
+	rcu_read_unlock();
+
+	if (em_max_perf == cpu_capacity)
+		return;
+
+	pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n", cpu,
+		 cpu_capacity, em_max_perf);
 
 	em_table = em_table_dup(pd);
 	if (!em_table) {
@@ -742,10 +755,7 @@ static void em_adjust_new_capacity(struct device *dev,
 static void em_check_capacity_update(void)
 {
 	cpumask_var_t cpu_done_mask;
-	struct em_perf_state *table;
-	struct em_perf_domain *pd;
-	unsigned long cpu_capacity;
-	int cpu;
+	int cpu, failed_cpus = 0;
 
 	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
 		pr_warn("no free memory\n");
@@ -755,7 +765,7 @@ static void em_check_capacity_update(void)
 	/* Check if CPUs capacity has changed than update EM */
 	for_each_possible_cpu(cpu) {
 		struct cpufreq_policy *policy;
-		unsigned long em_max_perf;
+		struct em_perf_domain *pd;
 		struct device *dev;
 
 		if (cpumask_test_cpu(cpu, cpu_done_mask))
@@ -763,41 +773,25 @@ static void em_check_capacity_update(void)
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy) {
-			pr_debug("Accessing cpu%d policy failed\n", cpu);
-			schedule_delayed_work(&em_update_work,
-					      msecs_to_jiffies(1000));
-			break;
+			failed_cpus++;
+			continue;
 		}
 		cpufreq_cpu_put(policy);
 
-		pd = em_cpu_get(cpu);
+		dev = get_cpu_device(cpu);
+		pd = em_pd_get(dev);
 		if (!pd || em_is_artificial(pd))
 			continue;
 
 		cpumask_or(cpu_done_mask, cpu_done_mask,
 			   em_span_cpus(pd));
 
-		cpu_capacity = arch_scale_cpu_capacity(cpu);
-
-		rcu_read_lock();
-		table = em_perf_state_from_pd(pd);
-		em_max_perf = table[pd->nr_perf_states - 1].performance;
-		rcu_read_unlock();
-
-		/*
-		 * Check if the CPU capacity has been adjusted during boot
-		 * and trigger the update for new performance values.
-		 */
-		if (em_max_perf == cpu_capacity)
-			continue;
-
-		pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n",
-			 cpu, cpu_capacity, em_max_perf);
-
-		dev = get_cpu_device(cpu);
-		em_adjust_new_capacity(dev, pd, cpu_capacity);
+		em_adjust_new_capacity(cpu, dev, pd);
 	}
 
+	if (failed_cpus)
+		schedule_delayed_work(&em_update_work, msecs_to_jiffies(1000));
+
 	free_cpumask_var(cpu_done_mask);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a441990fe808..cf541c4502d9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3731,11 +3731,9 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	struct cpumask *cpumask;
 	int cid;
 
 	lockdep_assert_rq_held(rq);
-	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
 		mm_cid_snapshot_time(rq, mm);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 029b67d48d30..92df29fc44fd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3720,6 +3720,9 @@ static bool thp_underused(struct folio *folio)
 	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
 		return false;
 
+	if (folio_contain_hwpoisoned_page(folio))
+		return false;
+
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
 			if (++num_zero_pages > khugepaged_max_ptes_none)
diff --git a/mm/migrate.c b/mm/migrate.c
index 2bcfc41b7e4c..bc6d5aeec718 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -203,8 +203,9 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	struct page *page = folio_page(folio, idx);
 	pte_t newpte;
 
-	if (PageCompound(page))
+	if (PageCompound(page) || PageHWPoison(page))
 		return false;
+
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(pte_present(old_pte), page);
diff --git a/mm/slub.c b/mm/slub.c
index 24e65d7048ba..64fdd1d122b9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1941,9 +1941,9 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	}
 }
 
-static inline void mark_failed_objexts_alloc(struct slab *slab)
+static inline bool mark_failed_objexts_alloc(struct slab *slab)
 {
-	slab->obj_exts = OBJEXTS_ALLOC_FAIL;
+	return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
 }
 
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
@@ -1965,7 +1965,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
-static inline void mark_failed_objexts_alloc(struct slab *slab) {}
+static inline bool mark_failed_objexts_alloc(struct slab *slab) { return false; }
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 			struct slabobj_ext *vec, unsigned int objects) {}
 
@@ -1998,8 +1998,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec) {
-		/* Mark vectors which failed to allocate */
-		mark_failed_objexts_alloc(slab);
+		/*
+		 * Try to mark vectors which failed to allocate.
+		 * If this operation fails, there may be a racing process
+		 * that has already completed the allocation.
+		 */
+		if (!mark_failed_objexts_alloc(slab) &&
+		    slab_obj_exts(slab))
+			return 0;
 
 		return -ENOMEM;
 	}
@@ -2008,6 +2014,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 #ifdef CONFIG_MEMCG
 	new_exts |= MEMCG_DATA_OBJEXTS;
 #endif
+retry:
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
 	if (new_slab) {
@@ -2017,8 +2024,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * be simply assigned.
 		 */
 		slab->obj_exts = new_exts;
-	} else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
-		   cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
+	} else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
 		/*
 		 * If the slab is already in use, somebody can allocate and
 		 * assign slabobj_exts in parallel. In this case the existing
@@ -2027,6 +2033,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		mark_objexts_empty(vec);
 		kfree(vec);
 		return 0;
+	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
+		/* Retry if a racing thread changed slab->obj_exts from under us. */
+		goto retry;
 	}
 
 	kmemleak_not_leak(vec);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4d0ee1c9002a..650c3c20e79f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4414,9 +4414,6 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	u16 vid;
 
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
-		return -EPERM;
-
 	if (!del_bulk) {
 		err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX,
 					     NULL, extack);
diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 5c1652181805..f5a7d5a38755 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -169,13 +169,14 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				chunk->head_skb = chunk->skb;
 
 			/* skbs with "cover letter" */
-			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
+			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len) {
+				if (WARN_ON(!skb_shinfo(chunk->skb)->frag_list)) {
+					__SCTP_INC_STATS(dev_net(chunk->skb->dev),
+							 SCTP_MIB_IN_PKT_DISCARDS);
+					sctp_chunk_free(chunk);
+					goto next_chunk;
+				}
 				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
-
-			if (WARN_ON(!chunk->skb)) {
-				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
-				sctp_chunk_free(chunk);
-				goto next_chunk;
 			}
 		}
 
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index a944e7dcb8b9..a94084b4a498 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -56,7 +56,6 @@ static struct inet_protosw smc_inet_protosw = {
 	.protocol	= IPPROTO_SMC,
 	.prot		= &smc_inet_prot,
 	.ops		= &smc_inet_stream_ops,
-	.flags		= INET_PROTOSW_ICSK,
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -104,27 +103,15 @@ static struct inet_protosw smc_inet6_protosw = {
 	.protocol	= IPPROTO_SMC,
 	.prot		= &smc_inet6_prot,
 	.ops		= &smc_inet6_stream_ops,
-	.flags		= INET_PROTOSW_ICSK,
 };
 #endif /* CONFIG_IPV6 */
 
-static unsigned int smc_sync_mss(struct sock *sk, u32 pmtu)
-{
-	/* No need pass it through to clcsock, mss can always be set by
-	 * sock_create_kern or smc_setsockopt.
-	 */
-	return 0;
-}
-
 static int smc_inet_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 
 	/* init common smc sock */
 	smc_sk_init(net, sk, IPPROTO_SMC);
-
-	inet_csk(sk)->icsk_sync_mss = smc_sync_mss;
-
 	/* create clcsock */
 	return smc_create_clcsk(net, sk, sk->sk_family);
 }
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ef519b55a3d9..68a9d4214584 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,12 +487,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport) {
-		if (vsk->transport == new_transport) {
-			ret = 0;
-			goto err;
-		}
+	if (vsk->transport && vsk->transport == new_transport) {
+		ret = 0;
+		goto err;
+	}
 
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
+
+	if (vsk->transport) {
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
@@ -512,20 +526,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->peer_shutdown = 0;
 	}
 
-	/* We increase the module refcnt to prevent the transport unloading
-	 * while there are open sockets assigned to it.
-	 */
-	if (!new_transport || !try_module_get(new_transport->module)) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/* It's safe to release the mutex after a successful try_module_get().
-	 * Whichever transport `new_transport` points at, it won't go away until
-	 * the last module_put() below or in vsock_deassign_transport().
-	 */
-	mutex_unlock(&vsock_register_mutex);
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(remote_cid)) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d4d82bb9b551..59ca5b0c093d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -209,6 +209,7 @@ static bool is_rust_noreturn(const struct symbol *func)
 	 * these come from the Rust standard library).
 	 */
 	return str_ends_with(func->name, "_4core5sliceSp15copy_from_slice17len_mismatch_fail")		||
+	       str_ends_with(func->name, "_4core6option13expect_failed")				||
 	       str_ends_with(func->name, "_4core6option13unwrap_failed")				||
 	       str_ends_with(func->name, "_4core6result13unwrap_failed")				||
 	       str_ends_with(func->name, "_4core9panicking5panic")					||
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6b22b8c73742..4ad0787451f4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3722,7 +3722,7 @@ endpoint_tests()
 	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
 	if reset "implicit EP" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3747,7 +3747,7 @@ endpoint_tests()
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
@@ -3897,7 +3897,7 @@ endpoint_tests()
 
 	# flush and re-add
 	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 2
 		# broadcast IP: no packet for this address will be received on ns1
diff --git a/tools/testing/selftests/net/sctp_hello.c b/tools/testing/selftests/net/sctp_hello.c
index f02f1f95d227..a04dac0b8027 100644
--- a/tools/testing/selftests/net/sctp_hello.c
+++ b/tools/testing/selftests/net/sctp_hello.c
@@ -29,7 +29,6 @@ static void set_addr(struct sockaddr_storage *ss, char *ip, char *port, int *len
 static int do_client(int argc, char *argv[])
 {
 	struct sockaddr_storage ss;
-	char buf[] = "hello";
 	int csk, ret, len;
 
 	if (argc < 5) {
@@ -56,16 +55,10 @@ static int do_client(int argc, char *argv[])
 
 	set_addr(&ss, argv[3], argv[4], &len);
 	ret = connect(csk, (struct sockaddr *)&ss, len);
-	if (ret < 0) {
-		printf("failed to connect to peer\n");
+	if (ret < 0)
 		return -1;
-	}
 
-	ret = send(csk, buf, strlen(buf) + 1, 0);
-	if (ret < 0) {
-		printf("failed to send msg %d\n", ret);
-		return -1;
-	}
+	recv(csk, NULL, 0, 0);
 	close(csk);
 
 	return 0;
@@ -75,7 +68,6 @@ int main(int argc, char *argv[])
 {
 	struct sockaddr_storage ss;
 	int lsk, csk, ret, len;
-	char buf[20];
 
 	if (argc < 2 || (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
 		printf("%s server|client ...\n", argv[0]);
@@ -125,11 +117,6 @@ int main(int argc, char *argv[])
 		return -1;
 	}
 
-	ret = recv(csk, buf, sizeof(buf), 0);
-	if (ret <= 0) {
-		printf("failed to recv msg %d\n", ret);
-		return -1;
-	}
 	close(csk);
 	close(lsk);
 
diff --git a/tools/testing/selftests/net/sctp_vrf.sh b/tools/testing/selftests/net/sctp_vrf.sh
index c854034b6aa1..667b211aa8a1 100755
--- a/tools/testing/selftests/net/sctp_vrf.sh
+++ b/tools/testing/selftests/net/sctp_vrf.sh
@@ -20,9 +20,9 @@ setup() {
 	modprobe sctp_diag
 	setup_ns CLIENT_NS1 CLIENT_NS2 SERVER_NS
 
-	ip net exec $CLIENT_NS1 sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
-	ip net exec $CLIENT_NS2 sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
-	ip net exec $SERVER_NS sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
+	ip net exec $CLIENT_NS1 sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip net exec $CLIENT_NS2 sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip net exec $SERVER_NS sysctl -wq net.ipv6.conf.default.accept_dad=0
 
 	ip -n $SERVER_NS link add veth1 type veth peer name veth1 netns $CLIENT_NS1
 	ip -n $SERVER_NS link add veth2 type veth peer name veth1 netns $CLIENT_NS2
@@ -62,17 +62,40 @@ setup() {
 }
 
 cleanup() {
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
+	wait_client $CLIENT_NS1
+	wait_client $CLIENT_NS2
+	stop_server
 	cleanup_ns $CLIENT_NS1 $CLIENT_NS2 $SERVER_NS
 }
 
-wait_server() {
+start_server() {
 	local IFACE=$1
 	local CNT=0
 
-	until ip netns exec $SERVER_NS ss -lS src $SERVER_IP:$SERVER_PORT | \
-		grep LISTEN | grep "$IFACE" 2>&1 >/dev/null; do
-		[ $((CNT++)) = "20" ] && { RET=3; return $RET; }
+	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP $SERVER_PORT $IFACE &
+	disown
+	until ip netns exec $SERVER_NS ss -SlH | grep -q "$IFACE"; do
+		[ $((CNT++)) -eq 30 ] && { RET=3; return $RET; }
+		sleep 0.1
+	done
+}
+
+stop_server() {
+	local CNT=0
+
+	ip netns exec $SERVER_NS pkill sctp_hello
+	while ip netns exec $SERVER_NS ss -SaH | grep -q .; do
+		[ $((CNT++)) -eq 30 ] && break
+		sleep 0.1
+	done
+}
+
+wait_client() {
+	local CLIENT_NS=$1
+	local CNT=0
+
+	while ip netns exec $CLIENT_NS ss -SaH | grep -q .; do
+		[ $((CNT++)) -eq 30 ] && break
 		sleep 0.1
 	done
 }
@@ -81,14 +104,12 @@ do_test() {
 	local CLIENT_NS=$1
 	local IFACE=$2
 
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE || return $RET
+	start_server $IFACE || return $RET
 	timeout 3 ip netns exec $CLIENT_NS ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT
 	RET=$?
+	wait_client $CLIENT_NS
+	stop_server
 	return $RET
 }
 
@@ -96,25 +117,21 @@ do_testx() {
 	local IFACE1=$1
 	local IFACE2=$2
 
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE1 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE1 || return $RET
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE2 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE2 || return $RET
+	start_server $IFACE1 || return $RET
+	start_server $IFACE2 || return $RET
 	timeout 3 ip netns exec $CLIENT_NS1 ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null && \
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT && \
 	timeout 3 ip netns exec $CLIENT_NS2 ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT
 	RET=$?
+	wait_client $CLIENT_NS1
+	wait_client $CLIENT_NS2
+	stop_server
 	return $RET
 }
 
 testup() {
-	ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=1 2>&1 >/dev/null
+	ip netns exec $SERVER_NS sysctl -wq net.sctp.l3mdev_accept=1
 	echo -n "TEST 01: nobind, connect from client 1, l3mdev_accept=1, Y "
 	do_test $CLIENT_NS1 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
@@ -123,7 +140,7 @@ testup() {
 	do_test $CLIENT_NS2 && { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 
-	ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=0 2>&1 >/dev/null
+	ip netns exec $SERVER_NS sysctl -wq net.sctp.l3mdev_accept=0
 	echo -n "TEST 03: nobind, connect from client 1, l3mdev_accept=0, N "
 	do_test $CLIENT_NS1 && { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
@@ -160,7 +177,7 @@ testup() {
 	do_testx vrf-1 vrf-2 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 
-	echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N "
+	echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, Y "
 	do_testx vrf-2 vrf-1 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 }


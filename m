Return-Path: <linux-kernel+bounces-799647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A04B42E77
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1DF1BC6418
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC621DE2D7;
	Thu,  4 Sep 2025 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4Kx1AIO"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3C1A83FB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947161; cv=none; b=H4GEb2HOq7mJIT35Q4TbnhznQY8HzKtAwls/22cHxfHMscdKDDyWijIPhopZhQTSnTtA40n+xAf2UznkoHPJQKDepEnWsVZcmJnDw2UDRJsH9WW6W0C5qvSphjv+174mQd1ex/0XWLS7FAIdXuXw7v7Su7bE4QICmm8UNUwgdqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947161; c=relaxed/simple;
	bh=WpMe8biLwNqQumQW6P/WEzAXtw4mFoY2kXv2lN3d3YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E10ETvSkfiS3nqt9IStu3Dr/uk6yf2MkKdF7evpqO0LZgbgEJpZTXA30GvTnmYfn2R5beeXAyTKKxofs8XEbAl0NPCi+hD4yXTuHTmpES9SzLYxyNstVDACBVK12aDDL7CfEHJCKvmTrGGkg0HY07VVK8ZgrqOa5wzvItJjQijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4Kx1AIO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323266d6f57so512308a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756947158; x=1757551958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+SdkyD8EaHhN4WfiLsJb50fWJo9nRspmtjnVTNLB4Y=;
        b=H4Kx1AIOGKRN0PhUYhcjc4WF3pJ67caMHO04rWLdMPIPm9GxN8LoGn3Y7zV19/8woN
         DqJNMa6C3k6Aa5jPMq9WfaPVZVTYWbEuzxVONeqiYQm4yDATZGlPm7a2eYnotgJOuP9+
         QIknhJxZjw2JmdcWTeDkOKQt2OhKJsf1fJVB10WtkG1XEKIhy3ig+9eSvHz/xY8QhSk3
         TiHsELkuiuRf00ao5WBSOYWsdrS9IvmTAfMnS0KLbeixqSG0cPyG7473RM4EsOp2IRNJ
         kcyFSeSap1RXzcyGnDlK0Gl2DfrhW5orcaT1bLw0o91ODkKjU/EJLALqtxtCKZHukwPV
         g9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756947158; x=1757551958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+SdkyD8EaHhN4WfiLsJb50fWJo9nRspmtjnVTNLB4Y=;
        b=WVDeWrK3Cc9yuPiHcwk5seXLuW88pNQsGMhdFbbZRy29ualSG5bwbtMp+/TsyL0HPn
         rh1gezY/JNq3f9H+TZhCC8RodiGnb5PyJwkcJmJnrVJsnHPXMuSxI8qBFeMIhrJFBtQS
         altcANg67e2S8gxC81b9eDY+hmSt2MHf+rMXlF35a8+FqE4TgngT/ul3X5Mo9VlJVKtr
         EQfMvPzXz8/3ujzkf4c+ki92hQ7QwCBV5V2UdW1jzVDK8XdWZfOeIdDXtrkQjWvi+3Cb
         xDmTwyWtmY5GTBpiOJYbRoDmz4HPRKDjGxRuZwSgvc1tL3/nvlh3Ls+1NowAutd7E3CN
         NHAA==
X-Forwarded-Encrypted: i=1; AJvYcCWK0nyBVcK8VWauZQUESU+gBuABGaplvCclcqXVLIhioIrgjEc5fq31Y8obxurds2yWtz2B8LnqhYusJXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYH8MKrsIybL1l3n1/RRy8PlSaFZKOMQR59yqD/7lcwrJabNz
	Cq15d7K5b/4wJ7wTuYDat2hdBA0wtI5zLifNZMS5DidqMyDiaGqryS3I
X-Gm-Gg: ASbGncvK1XYNRwPdVI153kpK+nYCM6LG3aI2Jch6ynD+jZgChuzVYODSDJcgCUDftAN
	8SzZHXlCzSDm4Kdtd8Le3OaBj6kxQGyvWBgOVv1JTka2pktYpzTh7s0jSe0Yfg8HJuvfiRO3nRv
	FL/AmrOuvYp8pb2N2rQFmpdaEeKSn6pk9bCnIRlzF1/Wa/imPYO2ofJwkziu/LmTJfdeC5NBUzU
	rv2z2yvCUFxrD1rV8H2wAI6pi7TfjgOCCRVMS/0ggXpi5Gzna32qKw70dzGpWUJnCgEOjmpZVTn
	UiOvCRF7YYSXK7nlRU76zObpSqCJUczFTEnlSf000hHsPg6lLQj+4wCBYIVVPJk2IlbIUWBAd68
	Crm3rSj44tqn+Aek0JQ4ei1+s1Qmp5y6vcN5wTHsYLtF5WLnEBiSZ2iax1YYh
X-Google-Smtp-Source: AGHT+IHyadE3jl5HQRtGbq1lFi6dmgfRxVUuU0Bz/rb8cf7dXnlVf2g0/qnidFpuclLnGJ7t8jfqHQ==
X-Received: by 2002:a17:90b:52ce:b0:327:8c05:f8b6 with SMTP id 98e67ed59e1d1-328156df7b8mr20557946a91.28.1756947158160;
        Wed, 03 Sep 2025 17:52:38 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:882:283c:10f0:c999])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28b3849sm15748931a12.31.2025.09.03.17.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:52:37 -0700 (PDT)
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
Subject: [PATCH v2 3/3] arm64: mm: Represent physical memory with phys_addr_t and resource_size_t
Date: Wed,  3 Sep 2025 17:52:09 -0700
Message-ID: <20250904005209.1494370-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250904005209.1494370-1-CFSworks@gmail.com>
References: <20250904005209.1494370-1-CFSworks@gmail.com>
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
index 5dc4107b5a7f..e6d35eff1486 100644
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
+	phys_addr_t ptep = (phys_addr_t)ptes; /* We're idmapped when called */
 
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



Return-Path: <linux-kernel+bounces-873364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8AEC13C29
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60482345E81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691B3054E1;
	Tue, 28 Oct 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="f4sGwxQZ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB7302747
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643047; cv=none; b=uYU8FVreETLYroGQGwwbixXuoj+Ogf217MI/JQdTDWiJEsp7ELpbIDhuJyDn46spRF0aomiX1XWezlWfb1Soxc7vWHBBPbffAHBlKg9QBmUrPfTSiF3QMqvTPY0KTii76FhbHOQziAlgqw+q1FfyWf8dj3PPX7BsrcIONnQ60lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643047; c=relaxed/simple;
	bh=dydLLqvv9GfPDw2CeThambI3wNtkxs7fMg/amODW+pI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUSVejGKQDZkfVXMLfnX9fdTECdJ8mo0DGF+L+PXslPxIfH9c9pazBlrCMfD4/oKMiHx53jP7S/xlSDdJHoHWEs7i4uuADFyy99PwDOwlZeBOGzoBr0arb/hKe4keq51OjWaN65Gs8wD06cZZnDUz7wWiRKSPMi67xOoL+ooj3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=f4sGwxQZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643043;
	bh=dydLLqvv9GfPDw2CeThambI3wNtkxs7fMg/amODW+pI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f4sGwxQZpk7mblNTexMQtkekFpAHFYAQrtXOCJ/5kdC9miO83xedGgFpC5+8P9VsD
	 FnkEQCobG/Fwu0j2tKtfV8f3JpnF1Hz1cZTD+BrsAXmsD1l2h2dNFnuz3Pn0az+5rg
	 deu3+/bnFxLedVyg7+dkWj1EMj8oZL0QouL3vCOI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:41 +0100
Subject: [PATCH 06/10] um: Remove fixaddr_user_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-6-e930063eff5f@weissschuh.net>
References: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
In-Reply-To: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=3743;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dydLLqvv9GfPDw2CeThambI3wNtkxs7fMg/amODW+pI=;
 b=FE436oxVhFe82l0jtHD/HvpcwSmrp0Hh5AuY180kd9J+qoZp3cVjbhqXIPrPYxLyuvokqHzrV
 9kUcalb4qCOBnlsULjIBymngzXQ+6WLimdvyCFPdni/Bql4qjjT7o2T
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

With the removal of the vDSO passthrough from the host,
FIXADDR_USER_START is always 0 and fixaddr_user_init() is dead code.

Remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/kernel/mem.c | 107 ---------------------------------------------------
 1 file changed, 107 deletions(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index dc938715ec9d..39c4a7e21c6f 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -84,109 +84,6 @@ void __init mem_init(void)
 	kmalloc_ok = 1;
 }
 
-#if IS_ENABLED(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA)
-/*
- * Create a page table and place a pointer to it in a middle page
- * directory entry.
- */
-static void __init one_page_table_init(pmd_t *pmd)
-{
-	if (pmd_none(*pmd)) {
-		pte_t *pte = (pte_t *) memblock_alloc_low(PAGE_SIZE,
-							  PAGE_SIZE);
-		if (!pte)
-			panic("%s: Failed to allocate %lu bytes align=%lx\n",
-			      __func__, PAGE_SIZE, PAGE_SIZE);
-
-		set_pmd(pmd, __pmd(_KERNPG_TABLE +
-					   (unsigned long) __pa(pte)));
-		BUG_ON(pte != pte_offset_kernel(pmd, 0));
-	}
-}
-
-static void __init one_md_table_init(pud_t *pud)
-{
-#if CONFIG_PGTABLE_LEVELS > 2
-	pmd_t *pmd_table = (pmd_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-	if (!pmd_table)
-		panic("%s: Failed to allocate %lu bytes align=%lx\n",
-		      __func__, PAGE_SIZE, PAGE_SIZE);
-
-	set_pud(pud, __pud(_KERNPG_TABLE + (unsigned long) __pa(pmd_table)));
-	BUG_ON(pmd_table != pmd_offset(pud, 0));
-#endif
-}
-
-static void __init one_ud_table_init(p4d_t *p4d)
-{
-#if CONFIG_PGTABLE_LEVELS > 3
-	pud_t *pud_table = (pud_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-	if (!pud_table)
-		panic("%s: Failed to allocate %lu bytes align=%lx\n",
-		      __func__, PAGE_SIZE, PAGE_SIZE);
-
-	set_p4d(p4d, __p4d(_KERNPG_TABLE + (unsigned long) __pa(pud_table)));
-	BUG_ON(pud_table != pud_offset(p4d, 0));
-#endif
-}
-
-static void __init fixrange_init(unsigned long start, unsigned long end,
-				 pgd_t *pgd_base)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	int i, j;
-	unsigned long vaddr;
-
-	vaddr = start;
-	i = pgd_index(vaddr);
-	j = pmd_index(vaddr);
-	pgd = pgd_base + i;
-
-	for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
-		p4d = p4d_offset(pgd, vaddr);
-		if (p4d_none(*p4d))
-			one_ud_table_init(p4d);
-		pud = pud_offset(p4d, vaddr);
-		if (pud_none(*pud))
-			one_md_table_init(pud);
-		pmd = pmd_offset(pud, vaddr);
-		for (; (j < PTRS_PER_PMD) && (vaddr < end); pmd++, j++) {
-			one_page_table_init(pmd);
-			vaddr += PMD_SIZE;
-		}
-		j = 0;
-	}
-}
-
-static void __init fixaddr_user_init( void)
-{
-	long size = FIXADDR_USER_END - FIXADDR_USER_START;
-	pte_t *pte;
-	phys_t p;
-	unsigned long v, vaddr = FIXADDR_USER_START;
-
-	if (!size)
-		return;
-
-	fixrange_init( FIXADDR_USER_START, FIXADDR_USER_END, swapper_pg_dir);
-	v = (unsigned long) memblock_alloc_low(size, PAGE_SIZE);
-	if (!v)
-		panic("%s: Failed to allocate %lu bytes align=%lx\n",
-		      __func__, size, PAGE_SIZE);
-
-	memcpy((void *) v , (void *) FIXADDR_USER_START, size);
-	p = __pa(v);
-	for ( ; size > 0; size -= PAGE_SIZE, vaddr += PAGE_SIZE,
-		      p += PAGE_SIZE) {
-		pte = virt_to_kpte(vaddr);
-		pte_set_val(*pte, p, PAGE_READONLY);
-	}
-}
-#endif
-
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
@@ -199,10 +96,6 @@ void __init paging_init(void)
 
 	max_zone_pfn[ZONE_NORMAL] = high_physmem >> PAGE_SHIFT;
 	free_area_init(max_zone_pfn);
-
-#if IS_ENABLED(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA)
-	fixaddr_user_init();
-#endif
 }
 
 /*

-- 
2.51.1.dirty



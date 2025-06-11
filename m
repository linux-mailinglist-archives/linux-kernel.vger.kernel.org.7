Return-Path: <linux-kernel+bounces-680799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B1AD49E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 06:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1969189CF71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 04:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE920766E;
	Wed, 11 Jun 2025 04:00:22 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346838479
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614422; cv=none; b=ty8QRYeQ1eBBCRG03iGZCAR6OuIzt47XdNrewIa/NsRS7M3gBJe/ztb72yvY6jjQO9xNRePzjEpt6tfktbSWQNVT00w4UgKaIvlFIi/pn5UJyLHBAFcdCZ2CeRSqq+ikF+sS7YN5KrTDgpfusvBbqbOmLPYKeD0AyRASvQX+v0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614422; c=relaxed/simple;
	bh=5RwXiP9db3ZiMTTmqPZMvskn3c84oxlF0u3TQMV3CdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SG51dpS2VvXDW/szJMGGk0SnL9Er4syvsCSwPrxgXHK4xNBwUZOI0H5GhRR0KP0vV4eA1/X5x+tsg3FWU6a9ZmuEqj4GQOYlEnbQmn2RUVPCWI/7dEQubKCJEVtl/V8ecPBJYAb/vgXLoeypZ3VwbkcnGBea9ds/7rc89hHZrv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 93d4abfe467811f0b29709d653e92f7d-20250611
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_LOWREP, SRC_LOWREP, DN_TRUSTED
	SRC_TRUSTED, SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:010c2c17-c08a-46c3-974c-89085e73af37,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:010c2c17-c08a-46c3-974c-89085e73af37,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:7886f4f76f0732cf613984976019cadc,BulkI
	D:250610171448GAXS4QNI,BulkQuantity:3,Recheck:0,SF:17|19|25|38|45|66|78|81
	|82|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 93d4abfe467811f0b29709d653e92f7d-20250611
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.104.40.103)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 769213250; Wed, 11 Jun 2025 12:00:13 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org
Cc: guodongtai@kylinos.cn,
	duanchenghao@kylinos.cn,
	youling.tang@linux.dev,
	jianghaoran@kylinos.cn
Subject: [PATCH v1 1/5] LoongArch: Support fixmap
Date: Wed, 11 Jun 2025 11:59:48 +0800
Message-Id: <20250611035952.111182-2-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611035952.111182-1-duanchenghao@kylinos.cn>
References: <20250611035952.111182-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: George Guo <guodongtai@kylinos.cn>

Support fixmap for Loongarch.

In the functions patch_map and patch_unmap, __set_fixmap are used.
Therefore, remove the __init identifier from these functions.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/include/asm/fixmap.h |   2 +
 arch/loongarch/kernel/setup.c       |   1 +
 arch/loongarch/mm/init.c            | 111 ++++++++++++++++++++++++++--
 3 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/fixmap.h b/arch/loongarch/include/asm/fixmap.h
index d2e55ae55..b579ad2be 100644
--- a/arch/loongarch/include/asm/fixmap.h
+++ b/arch/loongarch/include/asm/fixmap.h
@@ -13,6 +13,7 @@
 enum fixed_addresses {
 	FIX_HOLE,
 	FIX_EARLYCON_MEM_BASE,
+	FIX_TEXT_POKE0,
 	__end_of_fixed_addresses
 };
 
@@ -20,6 +21,7 @@ enum fixed_addresses {
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 #define FIXMAP_PAGE_IO	PAGE_KERNEL_SUC
 
+void __init early_fixmap_init(void);
 extern void __set_fixmap(enum fixed_addresses idx,
 			 phys_addr_t phys, pgprot_t flags);
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 56934fe58..368786952 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -597,6 +597,7 @@ void __init setup_arch(char **cmdline_p)
 	memblock_init();
 	pagetable_init();
 	bootcmdline_init(cmdline_p);
+	early_fixmap_init();
 	parse_early_param();
 	reserve_initrd_mem();
 
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 188b52bbb..68abb7bad 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -36,6 +36,109 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
+#define SPAN_NR_ENTRIES(vstart, vend, shift) \
+	((((vend) - 1) >> (shift)) - ((vstart) >> (shift)) + 1)
+
+#define NR_BM_PTE_TABLES \
+	SPAN_NR_ENTRIES(FIXADDR_START, FIXADDR_TOP, PMD_SHIFT)
+#define NR_BM_PMD_TABLES \
+	SPAN_NR_ENTRIES(FIXADDR_START, FIXADDR_TOP, PUD_SHIFT)
+
+static_assert(NR_BM_PMD_TABLES == 1);
+
+#define __BM_TABLE_IDX(addr, shift) \
+	(((addr) >> (shift)) - (FIXADDR_START >> (shift)))
+
+#define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
+
+static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
+static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
+static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
+
+static inline pte_t *fixmap_pte(unsigned long addr)
+{
+	return &bm_pte[BM_PTE_TABLE_IDX(addr)][pte_index(addr)];
+}
+
+static void __init early_fixmap_init_pte(pmd_t *pmdp, unsigned long addr)
+{
+	pmd_t pmd = READ_ONCE(*pmdp);
+	pte_t *ptep;
+
+	if (!pmd_present(pmd)) {
+		ptep = bm_pte[BM_PTE_TABLE_IDX(addr)];
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+		kernel_pte_init(ptep);
+	}
+}
+
+static void __init early_fixmap_init_pmd(pud_t *pudp, unsigned long addr,
+					 unsigned long end)
+{
+	unsigned long next;
+	pud_t pud = READ_ONCE(*pudp);
+	pmd_t *pmdp;
+
+	if (pud_none(pud))
+		pud_populate(&init_mm, pudp, bm_pmd);
+
+	pmdp = pmd_offset(pudp, addr);
+
+#ifndef __PAGETABLE_PMD_FOLDED
+	pmd_init(pmdp);
+#endif
+	do {
+		next = pmd_addr_end(addr, end);
+		early_fixmap_init_pte(pmdp, addr);
+	} while (pmdp++, addr = next, addr != end);
+}
+
+static void __init early_fixmap_init_pud(p4d_t *p4dp, unsigned long addr,
+					 unsigned long end)
+{
+	p4d_t p4d = READ_ONCE(*p4dp);
+	pud_t *pudp;
+
+#ifndef __PAGETABLE_PUD_FOLDED
+	if (CONFIG_PGTABLE_LEVELS > 3 && !p4d_none(p4d) &&
+	    p4d_phys(p4d) != __pa_symbol(bm_pud)) {
+		/*
+		 * We only end up here if the kernel mapping and the fixmap
+		 * share the top level pgd entry, which should only happen on
+		 * 16k/4 levels configurations.
+		 */
+		BUG_ON(!IS_ENABLED(CONFIG_PAGE_SIZE_16KB));
+	}
+#endif
+
+	if (p4d_none(p4d))
+		p4d_populate(&init_mm, p4dp, bm_pud);
+
+	pudp = pud_offset(p4dp, addr);
+
+#ifndef __PAGETABLE_PUD_FOLDED
+	pud_init(pudp);
+#endif
+	early_fixmap_init_pmd(pudp, addr, end);
+}
+
+/*
+ * The p*d_populate functions call virt_to_phys implicitly so they can't be used
+ * directly on kernel symbols (bm_p*d). This function is called too early to use
+ * lm_alias so __p*d_populate functions must be used to populate with the
+ * physical address from __pa_symbol.
+ */
+void __init early_fixmap_init(void)
+{
+	unsigned long addr = FIXADDR_START;
+	unsigned long end = FIXADDR_TOP;
+
+	pgd_t *pgdp = pgd_offset_k(addr);
+	p4d_t *p4dp = p4d_offset(pgdp, addr);
+
+	early_fixmap_init_pud(p4dp, addr, end);
+}
+
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
@@ -209,7 +312,7 @@ pte_t * __init populate_kernel_pte(unsigned long addr)
 	return pte_offset_kernel(pmd, addr);
 }
 
-void __init __set_fixmap(enum fixed_addresses idx,
+void __set_fixmap(enum fixed_addresses idx,
 			       phys_addr_t phys, pgprot_t flags)
 {
 	unsigned long addr = __fix_to_virt(idx);
@@ -217,11 +320,7 @@ void __init __set_fixmap(enum fixed_addresses idx,
 
 	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
 
-	ptep = populate_kernel_pte(addr);
-	if (!pte_none(ptep_get(ptep))) {
-		pte_ERROR(*ptep);
-		return;
-	}
+	ptep = fixmap_pte(addr);
 
 	if (pgprot_val(flags))
 		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
-- 
2.25.1



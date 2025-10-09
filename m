Return-Path: <linux-kernel+bounces-846147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71AEBC7289
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99DE3BADC1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF0192B75;
	Thu,  9 Oct 2025 01:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hRSXTbDp"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A81A3178
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975136; cv=none; b=bO5xoYAX/8NWC1ZouvZSv751TxpLjaCsSzAV2r+A0v2p0tpwvoBCA37OIuk/PSgk7f9zW8nL6TKuaTPSVn5ot/kaKOlg2HI7cVgI6MK9j4/URR9i3l+yaJhJjCOj62Jsd+Vmc0Y+HKNiDvKGYRaHwQAqHP2vVqmpjc+M2DJs72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975136; c=relaxed/simple;
	bh=4iE+BElr5tCvcHp/7PrmSuTMj2Avilu9p/M506Ojxi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWQ0d3D0OgKmh76fac00MnDqbxWngjHvn1MEcdaK1mdQldQw5IvsUdqNq7ycGmituqNYsGk59c4wcXQVwA9IevZgeoUVLCmYY/Dz8AKdKaf6YMiuLrqak22yq6vzjY7ku1Fapj0WnH5SGdWbOTKuri7OJXl40cEc58cN2MryGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hRSXTbDp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2698384978dso3076775ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975130; x=1760579930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec90szP6RRRVh+VBwVOMiqXzA3Ep/76H50/prlBRjCs=;
        b=hRSXTbDpmZykYRezFdI5CnHnlXAcV2E8HE4/pAU+xTEKlYv8NtES+zbHsJt5nrsiXy
         1FUxW5OeFHNvISlwt4zXUInB6KiSqP9XQoWPurbhcmQbOcDmeo2e1+rFdpbp+wn3VK4l
         CVoUIMOQczJQcI1A/uKf12y722vaDTo8z1La+hD45Xmh2TFU8476+dFHHfAZhcf9S0qE
         GzPH9Z5fuJRlOBCW63me9aHdA2vz/Ju9CCc2jyfV9dMTIaDplrdxNE2KSKYG6HCQkLzm
         CQPU85imjg0qPOYgPvku/n1Oww75omfhZEVnyhEibcNH12S5+CdAtgMWiNY/vwvbvqmG
         zhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975130; x=1760579930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec90szP6RRRVh+VBwVOMiqXzA3Ep/76H50/prlBRjCs=;
        b=o+xqhlZ3019qw4EHE8y6lzOG+YI0hNsH5tB8PgcU6Z/cqJz+I8cZ+Ivgx5ac/5TlGc
         8sA4WdPnRSKAl6hBMCNTuYgCwewIC7CS6AT8Va5PPz3uAC5aDwPg20h3ZljrhnOlJCou
         jUKfwDLHLqeOIZiPZQI3xNVCN76EOkXnUWaX3FEvQiEoKtxPyof8RCoy/z7fMaxoHV7o
         YbD3hiLYVaNw9QBVXWm2yDek79jX+R9K2SlAqw+XdgQe5Xk0Y7HNyTGR4VeVuE8c7XWU
         Y5OrCRoLJ/NNGRlDceQdMxdUeQdAKoB0QfeP5Ib0PMN0GK10ih587EL+gQq51hapeefj
         VUYw==
X-Forwarded-Encrypted: i=1; AJvYcCU7kK46P1XFl+AZdF+uxzmMO/IWPq+IyIYWfSoykfPs7OEs9pS6i8f9EDMjcvqhF3UXHJGOtNvdO5DILwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp//Z9nBI8ttH1dxk3DXmi9rE17KW5qR4EXaPt6zAscVMQ+KOv
	V05Qsv8Zd6AbaqHEQnlGlK8YA2VDUK6EItegB8fQMtk8+XKDC5RRpEhsaTk5VYUTY4Y=
X-Gm-Gg: ASbGncsOQU/GFL12drN7RqXtw9JM0M/Ym2YF1qimswdwTkOo0ouct0ulXaGk5R7x9pF
	ld5vwN3qArEU37DynPq1VxDrWRzgeifmXg8m8A0q0IAtJ1eBQljHR05YnuIXrpDUyYsPoaAuErW
	set50vw3JpOzZ0zdchkZJwxU3K00YauCvtB/xqbsLjthbzjjbmOTikbZ3GWAL7H8Qg/GX5Dlk9V
	9GPG+982lqMHStfj6i4xvk/KK0gq3eq+qNTcrysFf6jRbjRDV82iADcEpKOLS/xAmNYnxUIDiOq
	C/z7usMmFXWH+NPims61A15Cl3y27TKy/Zjwyjfosz9eKHAOoq3N5Tc6tzoxKuk5dVFhsOmf9fw
	mYSlwI9Uv3OmQgXxGAgTUYhG54LFyqSUw1VIGpo/KS7Y1DrLYIasbjYe3UV06PErCdjBr
X-Google-Smtp-Source: AGHT+IGpkTz+5DqTXkYh21z2iDwfeA2aj1AmfA+AuBtWgtsAEZk0JO74N45z8X0OyPDJv6obEnt7aQ==
X-Received: by 2002:a17:903:8cd:b0:269:8d85:2249 with SMTP id d9443c01a7336-29027240d03mr62723845ad.22.1759975129634;
        Wed, 08 Oct 2025 18:58:49 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:49 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 07/18] riscv: mm: Always use page table accessor functions
Date: Wed,  8 Oct 2025 18:57:43 -0700
Message-ID: <20251009015839.3460231-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009015839.3460231-1-samuel.holland@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the semantically appropriate accessor function instead of a raw
pointer dereference. This will become important once these functions
start transforming the PTE value on some platforms.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 arch/riscv/include/asm/pgtable.h |  8 ++--
 arch/riscv/kvm/gstage.c          |  6 +--
 arch/riscv/mm/init.c             | 68 +++++++++++++++++---------------
 arch/riscv/mm/pgtable.c          |  9 +++--
 4 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 8150677429398..2bc89e36406da 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -949,7 +949,7 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 #ifdef CONFIG_SMP
 	pud_t pud = __pud(xchg(&pudp->pud, 0));
 #else
-	pud_t pud = *pudp;
+	pud_t pud = pudp_get(pudp);
 
 	pud_clear(pudp);
 #endif
@@ -1126,13 +1126,15 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
  */
 #define set_p4d_safe(p4dp, p4d) \
 ({ \
-	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
+	p4d_t old = p4dp_get(p4dp); \
+	WARN_ON_ONCE(p4d_present(old) && !p4d_same(old, p4d)); \
 	set_p4d(p4dp, p4d); \
 })
 
 #define set_pgd_safe(pgdp, pgd) \
 ({ \
-	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
+	pgd_t old = pgdp_get(pgdp); \
+	WARN_ON_ONCE(pgd_present(old) && !pgd_same(old, pgd)); \
 	set_pgd(pgdp, pgd); \
 })
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index 24c270d6d0e27..ea298097fa403 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -154,7 +154,7 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 		ptep = &next_ptep[gstage_pte_index(map->addr, current_level)];
 	}
 
-	if (pte_val(*ptep) != pte_val(map->pte)) {
+	if (pte_val(ptep_get(ptep)) != pte_val(map->pte)) {
 		set_pte(ptep, map->pte);
 		if (gstage_pte_leaf(ptep))
 			gstage_tlb_flush(gstage, current_level, map->addr);
@@ -241,12 +241,12 @@ void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 		if (op == GSTAGE_OP_CLEAR)
 			put_page(virt_to_page(next_ptep));
 	} else {
-		old_pte = *ptep;
+		old_pte = ptep_get(ptep);
 		if (op == GSTAGE_OP_CLEAR)
 			set_pte(ptep, __pte(0));
 		else if (op == GSTAGE_OP_WP)
 			set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_PAGE_WRITE));
-		if (pte_val(*ptep) != pte_val(old_pte))
+		if (pte_val(ptep_get(ptep)) != pte_val(old_pte))
 			gstage_tlb_flush(gstage, ptep_level, addr);
 	}
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 15683ae13fa5d..d951a354c216d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -458,8 +458,8 @@ static void __meminit create_pte_mapping(pte_t *ptep, uintptr_t va, phys_addr_t
 
 	BUG_ON(sz != PAGE_SIZE);
 
-	if (pte_none(ptep[pte_idx]))
-		ptep[pte_idx] = pfn_pte(PFN_DOWN(pa), prot);
+	if (pte_none(ptep_get(ptep + pte_idx)))
+		set_pte(ptep + pte_idx, pfn_pte(PFN_DOWN(pa), prot));
 }
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -541,18 +541,19 @@ static void __meminit create_pmd_mapping(pmd_t *pmdp,
 	uintptr_t pmd_idx = pmd_index(va);
 
 	if (sz == PMD_SIZE) {
-		if (pmd_none(pmdp[pmd_idx]))
-			pmdp[pmd_idx] = pfn_pmd(PFN_DOWN(pa), prot);
+		if (pmd_none(pmdp_get(pmdp + pmd_idx)))
+			set_pmd(pmdp + pmd_idx, pfn_pmd(PFN_DOWN(pa), prot));
 		return;
 	}
 
-	if (pmd_none(pmdp[pmd_idx])) {
+	if (pmd_none(pmdp_get(pmdp + pmd_idx))) {
 		pte_phys = pt_ops.alloc_pte(va);
-		pmdp[pmd_idx] = pfn_pmd(PFN_DOWN(pte_phys), PAGE_TABLE);
+		set_pmd(pmdp + pmd_idx,
+			pfn_pmd(PFN_DOWN(pte_phys), PAGE_TABLE));
 		ptep = pt_ops.get_pte_virt(pte_phys);
 		memset(ptep, 0, PAGE_SIZE);
 	} else {
-		pte_phys = PFN_PHYS(_pmd_pfn(pmdp[pmd_idx]));
+		pte_phys = PFN_PHYS(_pmd_pfn(pmdp_get(pmdp + pmd_idx)));
 		ptep = pt_ops.get_pte_virt(pte_phys);
 	}
 
@@ -643,18 +644,19 @@ static void __meminit create_pud_mapping(pud_t *pudp, uintptr_t va, phys_addr_t
 	uintptr_t pud_index = pud_index(va);
 
 	if (sz == PUD_SIZE) {
-		if (pud_val(pudp[pud_index]) == 0)
-			pudp[pud_index] = pfn_pud(PFN_DOWN(pa), prot);
+		if (pud_val(pudp_get(pudp + pud_index)) == 0)
+			set_pud(pudp + pud_index, pfn_pud(PFN_DOWN(pa), prot));
 		return;
 	}
 
-	if (pud_val(pudp[pud_index]) == 0) {
+	if (pud_val(pudp_get(pudp + pud_index)) == 0) {
 		next_phys = pt_ops.alloc_pmd(va);
-		pudp[pud_index] = pfn_pud(PFN_DOWN(next_phys), PAGE_TABLE);
+		set_pud(pudp + pud_index,
+			pfn_pud(PFN_DOWN(next_phys), PAGE_TABLE));
 		nextp = pt_ops.get_pmd_virt(next_phys);
 		memset(nextp, 0, PAGE_SIZE);
 	} else {
-		next_phys = PFN_PHYS(_pud_pfn(pudp[pud_index]));
+		next_phys = PFN_PHYS(_pud_pfn(pudp_get(pudp + pud_index)));
 		nextp = pt_ops.get_pmd_virt(next_phys);
 	}
 
@@ -669,18 +671,19 @@ static void __meminit create_p4d_mapping(p4d_t *p4dp, uintptr_t va, phys_addr_t
 	uintptr_t p4d_index = p4d_index(va);
 
 	if (sz == P4D_SIZE) {
-		if (p4d_val(p4dp[p4d_index]) == 0)
-			p4dp[p4d_index] = pfn_p4d(PFN_DOWN(pa), prot);
+		if (p4d_val(p4dp_get(p4dp + p4d_index)) == 0)
+			set_p4d(p4dp + p4d_index, pfn_p4d(PFN_DOWN(pa), prot));
 		return;
 	}
 
-	if (p4d_val(p4dp[p4d_index]) == 0) {
+	if (p4d_val(p4dp_get(p4dp + p4d_index)) == 0) {
 		next_phys = pt_ops.alloc_pud(va);
-		p4dp[p4d_index] = pfn_p4d(PFN_DOWN(next_phys), PAGE_TABLE);
+		set_p4d(p4dp + p4d_index,
+			pfn_p4d(PFN_DOWN(next_phys), PAGE_TABLE));
 		nextp = pt_ops.get_pud_virt(next_phys);
 		memset(nextp, 0, PAGE_SIZE);
 	} else {
-		next_phys = PFN_PHYS(_p4d_pfn(p4dp[p4d_index]));
+		next_phys = PFN_PHYS(_p4d_pfn(p4dp_get(p4dp + p4d_index)));
 		nextp = pt_ops.get_pud_virt(next_phys);
 	}
 
@@ -726,18 +729,19 @@ void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa, phy
 	uintptr_t pgd_idx = pgd_index(va);
 
 	if (sz == PGDIR_SIZE) {
-		if (pgd_val(pgdp[pgd_idx]) == 0)
-			pgdp[pgd_idx] = pfn_pgd(PFN_DOWN(pa), prot);
+		if (pgd_val(pgdp_get(pgdp + pgd_idx)) == 0)
+			set_pgd(pgdp + pgd_idx, pfn_pgd(PFN_DOWN(pa), prot));
 		return;
 	}
 
-	if (pgd_val(pgdp[pgd_idx]) == 0) {
+	if (pgd_val(pgdp_get(pgdp + pgd_idx)) == 0) {
 		next_phys = alloc_pgd_next(va);
-		pgdp[pgd_idx] = pfn_pgd(PFN_DOWN(next_phys), PAGE_TABLE);
+		set_pgd(pgdp + pgd_idx,
+			pfn_pgd(PFN_DOWN(next_phys), PAGE_TABLE));
 		nextp = get_pgd_next_virt(next_phys);
 		memset(nextp, 0, PAGE_SIZE);
 	} else {
-		next_phys = PFN_PHYS(_pgd_pfn(pgdp[pgd_idx]));
+		next_phys = PFN_PHYS(_pgd_pfn(pgdp_get(pgdp + pgd_idx)));
 		nextp = get_pgd_next_virt(next_phys);
 	}
 
@@ -1568,14 +1572,14 @@ struct execmem_info __init *execmem_arch_setup(void)
 #ifdef CONFIG_MEMORY_HOTPLUG
 static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 {
-	struct page *page = pmd_page(*pmd);
+	struct page *page = pmd_page(pmdp_get(pmd));
 	struct ptdesc *ptdesc = page_ptdesc(page);
 	pte_t *pte;
 	int i;
 
 	for (i = 0; i < PTRS_PER_PTE; i++) {
 		pte = pte_start + i;
-		if (!pte_none(*pte))
+		if (!pte_none(ptep_get(pte)))
 			return;
 	}
 
@@ -1589,14 +1593,14 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 
 static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemmap)
 {
-	struct page *page = pud_page(*pud);
+	struct page *page = pud_page(pudp_get(pud));
 	struct ptdesc *ptdesc = page_ptdesc(page);
 	pmd_t *pmd;
 	int i;
 
 	for (i = 0; i < PTRS_PER_PMD; i++) {
 		pmd = pmd_start + i;
-		if (!pmd_none(*pmd))
+		if (!pmd_none(pmdp_get(pmd)))
 			return;
 	}
 
@@ -1611,13 +1615,13 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemm
 
 static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 {
-	struct page *page = p4d_page(*p4d);
+	struct page *page = p4d_page(p4dp_get(p4d));
 	pud_t *pud;
 	int i;
 
 	for (i = 0; i < PTRS_PER_PUD; i++) {
 		pud = pud_start + i;
-		if (!pud_none(*pud))
+		if (!pud_none(pudp_get(pud)))
 			return;
 	}
 
@@ -1662,7 +1666,7 @@ static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long addr, un
 
 		ptep = pte_base + pte_index(addr);
 		pte = ptep_get(ptep);
-		if (!pte_present(*ptep))
+		if (!pte_present(ptep_get(ptep)))
 			continue;
 
 		pte_clear(&init_mm, addr, ptep);
@@ -1692,7 +1696,7 @@ static void __meminit remove_pmd_mapping(pmd_t *pmd_base, unsigned long addr, un
 			continue;
 		}
 
-		pte_base = (pte_t *)pmd_page_vaddr(*pmdp);
+		pte_base = (pte_t *)pmd_page_vaddr(pmdp_get(pmdp));
 		remove_pte_mapping(pte_base, addr, next, is_vmemmap, altmap);
 		free_pte_table(pte_base, pmdp);
 	}
@@ -1771,10 +1775,10 @@ static void __meminit remove_pgd_mapping(unsigned long va, unsigned long end, bo
 		next = pgd_addr_end(addr, end);
 		pgd = pgd_offset_k(addr);
 
-		if (!pgd_present(*pgd))
+		if (!pgd_present(pgdp_get(pgd)))
 			continue;
 
-		if (pgd_leaf(*pgd))
+		if (pgd_leaf(pgdp_get(pgd)))
 			continue;
 
 		p4d_base = p4d_offset(pgd, 0);
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 8b6c0a112a8db..c4b85a828797e 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -95,8 +95,8 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	flush_tlb_kernel_range(addr, addr + PUD_SIZE);
 
 	for (i = 0; i < PTRS_PER_PMD; i++) {
-		if (!pmd_none(pmd[i])) {
-			pte_t *pte = (pte_t *)pmd_page_vaddr(pmd[i]);
+		if (!pmd_none(pmdp_get(pmd + i))) {
+			pte_t *pte = (pte_t *)pmd_page_vaddr(pmdp_get(pmd + i));
 
 			pte_free_kernel(NULL, pte);
 		}
@@ -158,8 +158,9 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		      pud_t *pudp)
 {
-	VM_WARN_ON_ONCE(!pud_present(*pudp));
-	pud_t old = pudp_establish(vma, address, pudp, pud_mkinvalid(*pudp));
+	VM_WARN_ON_ONCE(!pud_present(pudp_get(pudp)));
+	pud_t old = pudp_establish(vma, address, pudp,
+				   pud_mkinvalid(pudp_get(pudp)));
 
 	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
 	return old;
-- 
2.47.2



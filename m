Return-Path: <linux-kernel+bounces-829012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A29DB960A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC52189596E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E073732857C;
	Tue, 23 Sep 2025 13:37:32 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CB3595C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634652; cv=none; b=VqBEqVEoU7te5qc2pJ8YIyE/xlkdds8RQkbviW0CM64jEfqxb4LztXZRwBcENQqduRpKqfMKo517UhV4GFYGY0mV1fgh1UOrvcTQ+vy7hMfnINJSpN0D1U8RFJlojcaLiz9dZfZqSO9xe/aCMfDtoEVQlw8YIXOk5Izpn48McX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634652; c=relaxed/simple;
	bh=+2lQ+TuqqiVyx33/V9JZnkYYzZR22xBYswPJscjMXm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtOBxLVT8Jn4QiWmbuFEKuU756IuiBfqXftPztjdOR2CXql7kavrbFn1+Co8gP+7joIrdjEefb4nqnhlr4IX+eiVmdKovq4v1f9qr3rg+EG6jmgSom8pJCX+2VcDpRR43/LLolXe4EAB61PAXh5o5hB1q0mOm8bqodO+vY3T0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cWLWj1Z2SzVgCP;
	Tue, 23 Sep 2025 21:32:49 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 98ABD1401E9;
	Tue, 23 Sep 2025 21:37:27 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 21:37:25 +0800
From: Yin Tirui <yintirui@huawei.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <anshuman.khandual@arm.com>,
	<yangyicong@hisilicon.com>, <ardb@kernel.org>, <willy@infradead.org>,
	<apopple@nvidia.com>, <samuel.holland@sifive.com>,
	<luxu.kernel@bytedance.com>, <abrestic@rivosinc.com>,
	<yongxuan.wang@sifive.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <wangkefeng.wang@huawei.com>, <chenjun102@huawei.com>,
	<yintirui@huawei.com>
Subject: [PATCH RFC 2/2] mm: add PMD-level huge page support for remap_pfn_range()
Date: Tue, 23 Sep 2025 21:31:04 +0800
Message-ID: <20250923133104.926672-3-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923133104.926672-1-yintirui@huawei.com>
References: <20250923133104.926672-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500001.china.huawei.com (7.202.194.229)

Add PMD-level huge page support to remap_pfn_range(), automatically
creating huge mappings when prerequisites are satisfied (size, alignment,
architecture support, etc.) and falling back to normal page mappings
otherwise.

Implement special huge PMD splitting by utilizing the pgtable deposit/
withdraw mechanism. When splitting is needed, the deposited pgtable is
withdrawn and populated with individual PTEs created from the original
huge mapping, using pte_clrhuge() to clear huge page attributes.

Update arch_needs_pgtable_deposit() to return true when PMD pfnmap
support is enabled, ensuring proper pgtable management for huge
pfnmap operations.

Introduce pfnmap_max_page_shift parameter to control maximum page
size and "nohugepfnmap" boot option to disable huge pfnmap entirely.

Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 include/linux/pgtable.h |  6 +++-
 mm/huge_memory.c        | 22 ++++++++----
 mm/memory.c             | 74 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 85 insertions(+), 17 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 4c035637eeb7..4028318552ca 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1025,7 +1025,11 @@ extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 #endif
 
 #ifndef arch_needs_pgtable_deposit
-#define arch_needs_pgtable_deposit() (false)
+#define arch_needs_pgtable_deposit arch_needs_pgtable_deposit
+static inline bool arch_needs_pgtable_deposit(void)
+{
+	return IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP);
+}
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9c38a95e9f09..9f20adcbbb55 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2857,14 +2857,22 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
 	if (!vma_is_anonymous(vma)) {
 		old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
-		/*
-		 * We are going to unmap this huge page. So
-		 * just go ahead and zap it
-		 */
-		if (arch_needs_pgtable_deposit())
-			zap_deposited_table(mm, pmd);
-		if (!vma_is_dax(vma) && vma_is_special_huge(vma))
+		if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
+			pte_t entry;
+
+			pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+			if (unlikely(!pgtable))
+				return;
+			pmd_populate(mm, &_pmd, pgtable);
+			pte = pte_offset_map(&_pmd, haddr);
+			entry = pte_clrhuge(pfn_pte(pmd_pfn(old_pmd), pmd_pgprot(old_pmd)));
+			set_ptes(mm, haddr, pte, entry, HPAGE_PMD_NR);
+			pte_unmap(pte);
+
+			smp_wmb(); /* make pte visible before pmd */
+			pmd_populate(mm, pmd, pgtable);
 			return;
+		}
 		if (unlikely(is_pmd_migration_entry(old_pmd))) {
 			swp_entry_t entry;
 
diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..c4aaf3bd9cad 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2674,6 +2674,19 @@ vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 	return __vm_insert_mixed(vma, addr, pfn, true);
 }
 
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+static unsigned int __ro_after_init pfnmap_max_page_shift = BITS_PER_LONG - 1;
+
+static int __init set_nohugepfnmap(char *str)
+{
+	pfnmap_max_page_shift = PAGE_SHIFT;
+	return 0;
+}
+early_param("nohugepfnmap", set_nohugepfnmap);
+#else /* CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP */
+static const unsigned int pfnmap_max_page_shift = PAGE_SHIFT;
+#endif	/* CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP */
+
 /*
  * maps a range of physical memory into the requested pages. the old
  * mappings are removed. any references to nonexistent pages results
@@ -2705,9 +2718,47 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	return err;
 }
 
+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+static int remap_try_huge_pmd(struct mm_struct *mm, pmd_t *pmd,
+			unsigned long addr, unsigned long end,
+			unsigned long pfn, pgprot_t prot,
+			unsigned int page_shift)
+{
+	pgtable_t pgtable;
+	spinlock_t *ptl;
+
+	if (page_shift < PMD_SHIFT)
+		return 0;
+
+	if ((end - addr) != PMD_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(addr, PMD_SIZE))
+		return 0;
+
+	if (!IS_ALIGNED(pfn, 1 << (PMD_SHIFT - PAGE_SHIFT)))
+		return 0;
+
+	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
+		return 0;
+
+	set_pmd_at(mm, addr, pmd, pmd_mkspecial(pmd_mkhuge(pfn_pmd(pfn, prot))));
+
+	pgtable = pte_alloc_one(mm);
+	if (unlikely(!pgtable))
+		return 1;
+	mm_inc_nr_ptes(mm);
+	ptl = pmd_lock(mm, pmd);
+	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	spin_unlock(ptl);
+
+	return 1;
+}
+#endif
+
 static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 			unsigned long addr, unsigned long end,
-			unsigned long pfn, pgprot_t prot)
+			unsigned long pfn, pgprot_t prot, unsigned int max_page_shift)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -2720,6 +2771,12 @@ static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 	VM_BUG_ON(pmd_trans_huge(*pmd));
 	do {
 		next = pmd_addr_end(addr, end);
+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+		if (remap_try_huge_pmd(mm, pmd, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot, max_page_shift)) {
+			continue;
+		}
+#endif
 		err = remap_pte_range(mm, pmd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
@@ -2730,7 +2787,7 @@ static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 
 static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
 			unsigned long addr, unsigned long end,
-			unsigned long pfn, pgprot_t prot)
+			unsigned long pfn, pgprot_t prot, unsigned int max_page_shift)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -2743,7 +2800,7 @@ static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
 	do {
 		next = pud_addr_end(addr, end);
 		err = remap_pmd_range(mm, pud, addr, next,
-				pfn + (addr >> PAGE_SHIFT), prot);
+				pfn + (addr >> PAGE_SHIFT), prot, max_page_shift);
 		if (err)
 			return err;
 	} while (pud++, addr = next, addr != end);
@@ -2752,7 +2809,7 @@ static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
 
 static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 			unsigned long addr, unsigned long end,
-			unsigned long pfn, pgprot_t prot)
+			unsigned long pfn, pgprot_t prot, unsigned int max_page_shift)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -2765,7 +2822,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	do {
 		next = p4d_addr_end(addr, end);
 		err = remap_pud_range(mm, p4d, addr, next,
-				pfn + (addr >> PAGE_SHIFT), prot);
+				pfn + (addr >> PAGE_SHIFT), prot, max_page_shift);
 		if (err)
 			return err;
 	} while (p4d++, addr = next, addr != end);
@@ -2773,7 +2830,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 }
 
 static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot)
+		unsigned long pfn, unsigned long size, pgprot_t prot, unsigned int max_page_shift)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -2817,7 +2874,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	do {
 		next = pgd_addr_end(addr, end);
 		err = remap_p4d_range(mm, pgd, addr, next,
-				pfn + (addr >> PAGE_SHIFT), prot);
+				pfn + (addr >> PAGE_SHIFT), prot, max_page_shift);
 		if (err)
 			return err;
 	} while (pgd++, addr = next, addr != end);
@@ -2832,8 +2889,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
-	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
-
+	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot, pfnmap_max_page_shift);
 	if (!error)
 		return 0;
 
-- 
2.43.0



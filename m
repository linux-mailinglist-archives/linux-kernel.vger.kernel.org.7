Return-Path: <linux-kernel+bounces-856105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D56CEBE3164
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A00C3532E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FBB31A7FA;
	Thu, 16 Oct 2025 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S9aEoxsh"
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C9D26F44C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614405; cv=none; b=fl3+rgN5ZsusMIKDsyFUYOi4zweUhO/rhB5rbU3ycaDJVGxroTUGp4ctzmw3SYlqOJUZu8++EfdO69sSvxUYhVTm07prlC2Ibgp0ZtGEPZoO7boJRugtLnRoc5ZHlAxH7sLzWacnUk/sler2VUt0dJ3C2DALgWGT32mVyKV9nW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614405; c=relaxed/simple;
	bh=s3Ulpj5Z4SXIPSn3dnF1AFdpDxSPpHHZ+DXpgJ7JCwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C08AlgYA4dDjiAnxEs3SkG2z7gMnSZLhfzVGcpFjNBBUgGXJ2gD1vR66Rw/qMVE7NW7IwNGyCjW1bma5d7Om2XOco7L/OnD2CKwD240g2q7uWdoV0kLQZlgcN51ldSPjy6Xzkr/ptMBfjOafuGIyjwADMM5ROUWM1DsZ97RGsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S9aEoxsh; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=I8/Q9I7t7Qi4x/ZrI5Kaz0t842MDdUKD3sBtEPlbIMk=;
	b=S9aEoxshqgJ1DGVDyxEs704Lhfm/eP0YArwn6D7TVeJAzSaVZleG2UL/AteUOOOW1+p0/dpR1
	RIEMjxyngwhUFbMkJMvey91qwrJiQwRo+BFSLN3X0uTmdncij78NRBLOfh7FmW61eP/8lMha7Rq
	yhIYbwtgEzbjRnQW1uMkw60=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cnQmj57QwzLlVc;
	Thu, 16 Oct 2025 19:32:53 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id A4CE61A0188;
	Thu, 16 Oct 2025 19:33:14 +0800 (CST)
Received: from huawei.com (10.50.87.63) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Oct
 2025 19:33:13 +0800
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
Date: Thu, 16 Oct 2025 19:27:04 +0800
Message-ID: <20251016112704.179280-3-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016112704.179280-1-yintirui@huawei.com>
References: <20251016112704.179280-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 include/linux/pgtable.h |  6 +++++-
 mm/huge_memory.c        | 26 +++++++++++++++++++-------
 mm/memory.c             | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 25a7257052ff..9ae015cb67a0 100644
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
index 9c38a95e9f09..b5eecd8fc1bf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2857,14 +2857,26 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
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
+		} else if (arch_needs_pgtable_deposit()) {
+			/* Zap for the non-special mappings. */
+			zap_deposited_table(mm, pmd);
+		}
+
 		if (unlikely(is_pmd_migration_entry(old_pmd))) {
 			swp_entry_t entry;
 
diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..4e8f2248a86f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2705,6 +2705,40 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	return err;
 }
 
+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+static int remap_try_huge_pmd(struct mm_struct *mm, pmd_t *pmd,
+			unsigned long addr, unsigned long end,
+			unsigned long pfn, pgprot_t prot)
+{
+	pgtable_t pgtable;
+	spinlock_t *ptl;
+
+	if ((end - addr) != PMD_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(addr, PMD_SIZE))
+		return 0;
+
+	if (!IS_ALIGNED(pfn, HPAGE_PMD_NR))
+		return 0;
+
+	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
+		return 0;
+
+	pgtable = pte_alloc_one(mm);
+	if (unlikely(!pgtable))
+		return 0;
+
+	mm_inc_nr_ptes(mm);
+	ptl = pmd_lock(mm, pmd);
+	set_pmd_at(mm, addr, pmd, pmd_mkspecial(pmd_mkhuge(pfn_pmd(pfn, prot))));
+	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	spin_unlock(ptl);
+
+	return 1;
+}
+#endif
+
 static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 			unsigned long addr, unsigned long end,
 			unsigned long pfn, pgprot_t prot)
@@ -2720,6 +2754,12 @@ static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 	VM_BUG_ON(pmd_trans_huge(*pmd));
 	do {
 		next = pmd_addr_end(addr, end);
+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+		if (remap_try_huge_pmd(mm, pmd, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot)) {
+			continue;
+		}
+#endif
 		err = remap_pte_range(mm, pmd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
-- 
2.43.0



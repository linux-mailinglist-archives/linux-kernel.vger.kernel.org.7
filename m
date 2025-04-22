Return-Path: <linux-kernel+bounces-613773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86D6A960E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F1317A350
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000742571B3;
	Tue, 22 Apr 2025 08:19:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169BD256C86
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309942; cv=none; b=gQAhA1TKm1dC9ZTxxh7JYBuDKJNVpFvulvjia214ZsL00D4IyZ2U2XWd7pT535cSjAqiDHviToK4z5+RwYRTv52a0wM6UF76+egkaRbguSfIhpgwUG7taDmVSmbDEbQy12OtizdkjU/IONiObUHncntrQvaXNEqZP7YEbKa9Om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309942; c=relaxed/simple;
	bh=sJqLePHA9b3ixpCb+unmyiOKQtG+Q3r/RUEOnwQgkEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0Ij+tn3j61Ukk8q4c9j2DgfnQXvRxyV0opeqeQBsZ8jtf7XiP8HqS9nNGyJ+Tu/9yQsGQ2/+1SoE6mCH2KWMT4LjHaMHwkRiclHOsCPKyewO4cw0GP44ZE3cieAmpQoqux0tZ+ECbsDK2cfu0vffuv8YlaRT/4vDycdFgI6q7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18458176A;
	Tue, 22 Apr 2025 01:18:56 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64C2F3F66E;
	Tue, 22 Apr 2025 01:18:58 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] arm64/mm: Support huge pte-mapped pages in vmap
Date: Tue, 22 Apr 2025 09:18:17 +0100
Message-ID: <20250422081822.1836315-10-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422081822.1836315-1-ryan.roberts@arm.com>
References: <20250422081822.1836315-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the required arch functions to enable use of contpte in the
vmap when VM_ALLOW_HUGE_VMAP is specified. This speeds up vmap
operations due to only having to issue a DSB and ISB per contpte block
instead of per pte. But it also means that the TLB pressure reduces due
to only needing a single TLB entry for the whole contpte block.

Since vmap uses set_huge_pte_at() to set the contpte, that API is now
used for kernel mappings for the first time. Although in the vmap case
we never expect it to be called to modify a valid mapping so
clear_flush() should never be called, it's still wise to make it robust
for the kernel case, so amend the tlb flush function if the mm is for
kernel space.

Tested with vmalloc performance selftests:

  # kself/mm/test_vmalloc.sh \
	run_test_mask=1
	test_repeat_count=5
	nr_pages=256
	test_loop_count=100000
	use_huge=1

Duration reduced from 1274243 usec to 1083553 usec on Apple M2 for 15%
reduction in time taken.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/vmalloc.h | 45 ++++++++++++++++++++++++++++++++
 arch/arm64/mm/hugetlbpage.c      |  5 +++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 38fafffe699f..12f534e8f3ed 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -23,6 +23,51 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
 }
 
+#define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
+static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
+						unsigned long end, u64 pfn,
+						unsigned int max_page_shift)
+{
+	/*
+	 * If the block is at least CONT_PTE_SIZE in size, and is naturally
+	 * aligned in both virtual and physical space, then we can pte-map the
+	 * block using the PTE_CONT bit for more efficient use of the TLB.
+	 */
+	if (max_page_shift < CONT_PTE_SHIFT)
+		return PAGE_SIZE;
+
+	if (end - addr < CONT_PTE_SIZE)
+		return PAGE_SIZE;
+
+	if (!IS_ALIGNED(addr, CONT_PTE_SIZE))
+		return PAGE_SIZE;
+
+	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
+		return PAGE_SIZE;
+
+	return CONT_PTE_SIZE;
+}
+
+#define arch_vmap_pte_range_unmap_size arch_vmap_pte_range_unmap_size
+static inline unsigned long arch_vmap_pte_range_unmap_size(unsigned long addr,
+							   pte_t *ptep)
+{
+	/*
+	 * The caller handles alignment so it's sufficient just to check
+	 * PTE_CONT.
+	 */
+	return pte_valid_cont(__ptep_get(ptep)) ? CONT_PTE_SIZE : PAGE_SIZE;
+}
+
+#define arch_vmap_pte_supported_shift arch_vmap_pte_supported_shift
+static inline int arch_vmap_pte_supported_shift(unsigned long size)
+{
+	if (size >= CONT_PTE_SIZE)
+		return CONT_PTE_SHIFT;
+
+	return PAGE_SHIFT;
+}
+
 #endif
 
 #define arch_vmap_pgprot_tagged arch_vmap_pgprot_tagged
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index d34703846ef4..0c8737f4f2ce 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -209,7 +209,10 @@ static void clear_flush(struct mm_struct *mm,
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		__ptep_get_and_clear_anysz(mm, ptep, pgsize);
 
-	__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, true);
+	if (mm == &init_mm)
+		flush_tlb_kernel_range(saddr, addr);
+	else
+		__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, true);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-- 
2.43.0



Return-Path: <linux-kernel+bounces-613772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D38CA960E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 10:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2FF189B1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA43C256C84;
	Tue, 22 Apr 2025 08:19:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA42566F7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309940; cv=none; b=BxG1YSLbH3ATXnAtdH2GqHZY0bjkiMKr1DqZzG7nnRmWux5TF9PxARRPSG54Gg5AAzpBeXfLfRKz5jkcyDWNx+CXUA09b+CVKLRVPmUrTZwavL2GyazBHNxLiBHF+e6eRTIbBRhn/ylrANYPkvLbA7zFlK/TMPZGw7ahu1M653A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309940; c=relaxed/simple;
	bh=wa+lNOjyuh0rEn3s9jZtbk0yhidJ6K3BufxfXoYMM/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok1mRk1LHSf2ldCHYflwf6AQZsR4ygOBkdaJbHuUb0BZG3396g6BJPrr0KasRXGaNTeWzFXIF+jTIExeOQAtSa1piAuN4+NEeI9GZuaEgawmZ8vnhq+sZTPb2PD3SbZlUO9DgZ1J530Dbja0SCX45dL7Gui6JpYKnd8EHs/AxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5AD319F0;
	Tue, 22 Apr 2025 01:18:53 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E4B73F66E;
	Tue, 22 Apr 2025 01:18:56 -0700 (PDT)
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
Subject: [PATCH v4 08/11] mm/vmalloc: Gracefully unmap huge ptes
Date: Tue, 22 Apr 2025 09:18:16 +0100
Message-ID: <20250422081822.1836315-9-ryan.roberts@arm.com>
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

Commit f7ee1f13d606 ("mm/vmalloc: enable mapping of huge pages at pte
level in vmap") added its support by reusing the set_huge_pte_at() API,
which is otherwise only used for user mappings. But when unmapping those
huge ptes, it continued to call ptep_get_and_clear(), which is a
layering violation. To date, the only arch to implement this support is
powerpc and it all happens to work ok for it.

But arm64's implementation of ptep_get_and_clear() can not be safely
used to clear a previous set_huge_pte_at(). So let's introduce a new
arch opt-in function, arch_vmap_pte_range_unmap_size(), which can
provide the size of a (present) pte. Then we can call
huge_ptep_get_and_clear() to tear it down properly.

Note that if vunmap_range() is called with a range that starts in the
middle of a huge pte-mapped page, we must unmap the entire huge page so
the behaviour is consistent with pmd and pud block mappings. In this
case emit a warning just like we do for pmd/pud mappings.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/vmalloc.h |  8 ++++++++
 mm/vmalloc.c            | 18 ++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 31e9ffd936e3..16dd4cba64f2 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -113,6 +113,14 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr, uns
 }
 #endif
 
+#ifndef arch_vmap_pte_range_unmap_size
+static inline unsigned long arch_vmap_pte_range_unmap_size(unsigned long addr,
+							   pte_t *ptep)
+{
+	return PAGE_SIZE;
+}
+#endif
+
 #ifndef arch_vmap_pte_supported_shift
 static inline int arch_vmap_pte_supported_shift(unsigned long size)
 {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d60d3a29d149..fe2e2cc8da94 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -350,12 +350,26 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			     pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
+	pte_t ptent;
+	unsigned long size = PAGE_SIZE;
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
-		pte_t ptent = ptep_get_and_clear(&init_mm, addr, pte);
+#ifdef CONFIG_HUGETLB_PAGE
+		size = arch_vmap_pte_range_unmap_size(addr, pte);
+		if (size != PAGE_SIZE) {
+			if (WARN_ON(!IS_ALIGNED(addr, size))) {
+				addr = ALIGN_DOWN(addr, size);
+				pte = PTR_ALIGN_DOWN(pte, sizeof(*pte) * (size >> PAGE_SHIFT));
+			}
+			ptent = huge_ptep_get_and_clear(&init_mm, addr, pte, size);
+			if (WARN_ON(end - addr < size))
+				size = end - addr;
+		} else
+#endif
+			ptent = ptep_get_and_clear(&init_mm, addr, pte);
 		WARN_ON(!pte_none(ptent) && !pte_present(ptent));
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	} while (pte += (size >> PAGE_SHIFT), addr += size, addr != end);
 	*mask |= PGTBL_PTE_MODIFIED;
 }
 
-- 
2.43.0



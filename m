Return-Path: <linux-kernel+bounces-843820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F5BC056C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD6654F1A65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9A3219302;
	Tue,  7 Oct 2025 06:31:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C7D1B2186
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818669; cv=none; b=MKmqVI5KzHSWtSA1E964sg6DPs80e0pZsfKU1GFflpRG1v+d/0ksSPHTNA1grWOwE24TgghETFr/b6/rb3XRpanxnrCgqp9Q4uPY4FuM82hRVyMDmU/ANiPs3ca0J0rUgJm0LXJNi7sS5lgKUJuqgLidNl4pbnM6GgZOaXfFk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818669; c=relaxed/simple;
	bh=86mtmsHV9KCOVXlETPaFOszfsui00cGAhiUOBYDW93g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FOtbzAXBUONNhYckzZIeheeOT/oUVZEVx0oibp+ojA1HXK05FHksLg1ocQ9vPN8/oE8mNnvlUw5ZlE5+C0e7hkFlYxR/3ESwNFuCBlQ4baOLKZ9rPM1swwIWLCLWEjoO4SwbxVQkh5uGT09H9AjqLQnMoAjm/mualT8MmqG3my8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0FF714BF;
	Mon,  6 Oct 2025 23:30:58 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D75343F59E;
	Mon,  6 Oct 2025 23:31:05 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Replace READ_ONCE() with standard page table accessors
Date: Tue,  7 Oct 2025 07:31:00 +0100
Message-Id: <20251007063100.2396936-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all READ_ONCE() with a standard page table accessors i.e pxdp_get()
that defaults into READ_ONCE() in cases where platform does not override.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/gup.c            | 10 +++++-----
 mm/hmm.c            |  2 +-
 mm/memory.c         |  4 ++--
 mm/mprotect.c       |  2 +-
 mm/sparse-vmemmap.c |  2 +-
 mm/vmscan.c         |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 0bc4d140fc07..37e2af5ed96d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -964,7 +964,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	pudp = pud_offset(p4dp, address);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
 	if (pud_leaf(pud)) {
@@ -989,7 +989,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	p4d_t *p4dp, p4d;
 
 	p4dp = p4d_offset(pgdp, address);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	BUILD_BUG_ON(p4d_leaf(p4d));
 
 	if (!p4d_present(p4d) || p4d_bad(p4d))
@@ -3080,7 +3080,7 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
 	do {
-		pud_t pud = READ_ONCE(*pudp);
+		pud_t pud = pudp_get(pudp);
 
 		next = pud_addr_end(addr, end);
 		if (unlikely(!pud_present(pud)))
@@ -3106,7 +3106,7 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
 	do {
-		p4d_t p4d = READ_ONCE(*p4dp);
+		p4d_t p4d = p4dp_get(p4dp);
 
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(p4d))
@@ -3128,7 +3128,7 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 
 	pgdp = pgd_offset(current->mm, addr);
 	do {
-		pgd_t pgd = READ_ONCE(*pgdp);
+		pgd_t pgd = pgdp_get(pgdp);
 
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
diff --git a/mm/hmm.c b/mm/hmm.c
index d545e2494994..126c3f42e525 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -431,7 +431,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 	/* Normally we don't want to split the huge page */
 	walk->action = ACTION_CONTINUE;
 
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud)) {
 		spin_unlock(ptl);
 		return hmm_vma_walk_hole(start, end, -1, walk);
diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..50f841ee6e84 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6549,12 +6549,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 		goto out;
 
 	p4dp = p4d_offset(pgdp, address);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	if (p4d_none(p4d) || unlikely(p4d_bad(p4d)))
 		goto out;
 
 	pudp = pud_offset(p4dp, address);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (pud_none(pud))
 		goto out;
 	if (pud_leaf(pud)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 113b48985834..988c366137d5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -599,7 +599,7 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 			break;
 		}
 
-		pud = READ_ONCE(*pudp);
+		pud = pudp_get(pudp);
 		if (pud_none(pud))
 			continue;
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index dbd8daccade2..37522d6cb398 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -439,7 +439,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			return -ENOMEM;
 
 		pmd = pmd_offset(pud, addr);
-		if (pmd_none(READ_ONCE(*pmd))) {
+		if (pmd_none(pmdp_get(pmd))) {
 			void *p;
 
 			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 674999999cd0..14c2722b955b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3772,7 +3772,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 	pud = pud_offset(p4d, start & P4D_MASK);
 restart:
 	for (i = pud_index(start), addr = start; addr != end; i++, addr = next) {
-		pud_t val = READ_ONCE(pud[i]);
+		pud_t val = pudp_get(pud + i);
 
 		next = pud_addr_end(addr, end);
 
-- 
2.30.2



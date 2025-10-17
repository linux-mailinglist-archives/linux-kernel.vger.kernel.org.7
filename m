Return-Path: <linux-kernel+bounces-857277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B22BE663F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6242E1A61983
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EC430EF67;
	Fri, 17 Oct 2025 05:15:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B15E30F540
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760678108; cv=none; b=lkV+u3sguKZkWEkp8iJICDGrAM0c5geQXY90ySstgp5O2M3LA9aOVxK937pbwBtf1Gydd4wcAlhKvc8w9kDzHuct/xjpobAtw/MqAlJfCCzDjO1XRB0gzNJIOMovhwN9oc9pkyXeBHETuBqr2xgoXXA14Lp4SsM0kFyaw2JtYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760678108; c=relaxed/simple;
	bh=LuPDCxMSehqdFjEEW839ZSMWC2a20vWfTM3wRi3lPBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4GVu8RQ4t/3e8Z/9pA1huamnnzI/f1pt32fjGVs2y898mfUDWuQDtK1OIrNvAwjrl45moVOlwNXrpobACNUhzZhNeQgIKqrAQwhIORuIwkMa9rswMirNYlZuucWYo6GHiOushBCTNwsBk133W129FXgdjVCSF4OfcXWcEHBYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21812153B;
	Thu, 16 Oct 2025 22:14:56 -0700 (PDT)
Received: from a079125.blr.arm.com (a079125.arm.com [10.164.21.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E3E0D3F66E;
	Thu, 16 Oct 2025 22:14:59 -0700 (PDT)
From: Linu Cherian <linu.cherian@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Dev Jain <dev.jain@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Linu Cherian <linu.cherian@arm.com>
Subject: [PATCH v4 2/2] arm64/mm: Rename try_pgd_pgtable_alloc_init_mm
Date: Fri, 17 Oct 2025 10:44:37 +0530
Message-ID: <20251017051437.2836080-3-linu.cherian@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017051437.2836080-1-linu.cherian@arm.com>
References: <20251017051437.2836080-1-linu.cherian@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With BUG_ON in pgd_pgtable_alloc_init_mm moved up to higher layer,
gfp flags is the only difference between try_pgd_pgtable_alloc_init_mm
and pgd_pgtable_alloc_init_mm. Hence rename the "try" version
to pgd_pgtable_alloc_init_mm_gfp.

Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Linu Cherian <linu.cherian@arm.com>
---
Changelog:
v4:
No changes.

 arch/arm64/mm/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 99555ebbab38..f604a7983de3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -560,7 +560,7 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
 }
 
 static phys_addr_t
-try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
+pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
 {
 	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
 }
@@ -568,7 +568,7 @@ try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
 static phys_addr_t __maybe_unused
 pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
 {
-	return __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
+	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
 }
 
 static phys_addr_t
@@ -595,7 +595,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
 	pte_t *ptep;
 	int i;
 
-	pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE, gfp);
+	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
 	if (pte_phys == INVALID_PHYS_ADDR)
 		return -ENOMEM;
 	ptep = (pte_t *)phys_to_virt(pte_phys);
@@ -640,7 +640,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
 	pmd_t *pmdp;
 	int i;
 
-	pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD, gfp);
+	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
 	if (pmd_phys == INVALID_PHYS_ADDR)
 		return -ENOMEM;
 	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
-- 
2.43.0



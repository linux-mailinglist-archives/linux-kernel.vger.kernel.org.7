Return-Path: <linux-kernel+bounces-850114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C28BBD1E97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588601898B22
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391F2EBDE5;
	Mon, 13 Oct 2025 08:03:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D562EB858
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342591; cv=none; b=eMv1fFIRCxiSUrb3lHpOQmYKTgbVmGWwNP2pB4voxyLwb7RueiCwZ6n41t4GWPIx5Xib/FWbjYJ2lwlUYZWSlgA1JXrYshDlThKo3K9Xxk2TV0MnqDxyLxZUfU4lld9t4/ZK7+7Wu5a7KI067qQxhzQmpMD7C2pruo1s2IXBYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342591; c=relaxed/simple;
	bh=E6yBXGMy4k0V1jGrc6wWbdUi+s23kdJWNluRAxVoZBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghBQxV48CA8BkBs+2t16y9E+NK4UG2BQKcYY7qqp5HlEzWCFDav+fezzcPE18y3a6wpVB8HQKyfKfb8QHyTTFCxa9oFBGTF24moYAawBiYhZvd4MLiO8iHK+/yrerIDiAMMOE++sF+dNevi5POBChWj5GUp6YhfJ95dRK59Nkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 454FD12FC;
	Mon, 13 Oct 2025 01:03:01 -0700 (PDT)
Received: from a079125.blr.arm.com (a079125.arm.com [10.164.21.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 256AE3F738;
	Mon, 13 Oct 2025 01:03:04 -0700 (PDT)
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
Subject: [PATCH v2 2/2] arm64/mm: Rename try_pgd_pgtable_alloc_init_mm
Date: Mon, 13 Oct 2025 13:32:20 +0530
Message-ID: <20251013080220.2027757-3-linu.cherian@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013080220.2027757-1-linu.cherian@arm.com>
References: <20251013080220.2027757-1-linu.cherian@arm.com>
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

Signed-off-by: Linu Cherian <linu.cherian@arm.com>
---
 arch/arm64/mm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 34602339c1bf..ede591346196 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -559,7 +559,7 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
 }
 
 static phys_addr_t
-try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
+pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
 {
 	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
 }
@@ -594,7 +594,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
 	pte_t *ptep;
 	int i;
 
-	pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE, gfp);
+	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
 	if (pte_phys == INVALID_PHYS_ADDR)
 		return -ENOMEM;
 	ptep = (pte_t *)phys_to_virt(pte_phys);
@@ -639,7 +639,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
 	pmd_t *pmdp;
 	int i;
 
-	pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD, gfp);
+	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
 	if (pmd_phys == INVALID_PHYS_ADDR)
 		return -ENOMEM;
 	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
-- 
2.43.0



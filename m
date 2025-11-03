Return-Path: <linux-kernel+bounces-882287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025BFC2A109
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED98F1885AD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F381D2868BD;
	Mon,  3 Nov 2025 05:26:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C587241695
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147591; cv=none; b=YdhOXddy+x0G+y35KlLs2Bmmji/dOm/D4IzpQiNaH2M6eIg5ceBkSZmemhEiQrAA15Qc5n60DzthxPegkuqWIEaMeJ6R8eTtc1Rtj1PlJSlcQUt8M4yuP3krK3NSnw2DjMG28c4gsCzLbnYD2P6cjRnXNkH0WKA0wQbZVk+/mTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147591; c=relaxed/simple;
	bh=SC8jSBLRPuTUepXjfloPoNHLm0O2CqF7xWJylgTM+aA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+4H7ygho2DBDc+Ygv8UASnfFsZIWws2PIDM4GjRQesP+8xrVyYBBR2Vd+DPAitF8PgNVjfFhdCS7cSbE7Y084hCIekkQBCFIujj8sfOe7YCNQxrRkZw8Xlrskt8W6oQFyc5MAKlfIPJr7NPnHIOafrYtkKAnVnf5FUyfSOW+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A12912936;
	Sun,  2 Nov 2025 21:26:21 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 228FD3F63F;
	Sun,  2 Nov 2025 21:26:27 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arm64/mm: Directly use TTBRx_EL1_CnP
Date: Mon,  3 Nov 2025 05:26:14 +0000
Message-Id: <20251103052618.586763-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251103052618.586763-1-anshuman.khandual@arm.com>
References: <20251103052618.586763-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all TTBR_CNP_BIT macro instances with TTBRx_EL1_CNP_BIT which
is a standard field from tools sysreg format. No functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kernel/mte.c | 4 ++--
 arch/arm64/mm/context.c | 2 +-
 arch/arm64/mm/mmu.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 43f7a2f39403..ba2e3e9d1f73 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -315,8 +315,8 @@ void mte_cpu_setup(void)
 	 * CnP is not a boot feature so MTE gets enabled before CnP, but let's
 	 * make sure that is the case.
 	 */
-	BUG_ON(read_sysreg(ttbr0_el1) & TTBR_CNP_BIT);
-	BUG_ON(read_sysreg(ttbr1_el1) & TTBR_CNP_BIT);
+	BUG_ON(read_sysreg(ttbr0_el1) & TTBRx_EL1_CnP);
+	BUG_ON(read_sysreg(ttbr1_el1) & TTBRx_EL1_CnP);
 
 	/* Normal Tagged memory type at the corresponding MAIR index */
 	sysreg_clear_set(mair_el1,
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 718c495832d0..0f4a28b87469 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -354,7 +354,7 @@ void cpu_do_switch_mm(phys_addr_t pgd_phys, struct mm_struct *mm)
 
 	/* Skip CNP for the reserved ASID */
 	if (system_supports_cnp() && asid)
-		ttbr0 |= TTBR_CNP_BIT;
+		ttbr0 |= TTBRx_EL1_CnP;
 
 	/* SW PAN needs a copy of the ASID in TTBR0 for entry */
 	if (IS_ENABLED(CONFIG_ARM64_SW_TTBR0_PAN))
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b8d37eb037fc..e80bb623ef53 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -2084,7 +2084,7 @@ void __cpu_replace_ttbr1(pgd_t *pgdp, bool cnp)
 	phys_addr_t ttbr1 = phys_to_ttbr(virt_to_phys(pgdp));
 
 	if (cnp)
-		ttbr1 |= TTBR_CNP_BIT;
+		ttbr1 |= TTBRx_EL1_CnP;
 
 	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
-- 
2.30.2



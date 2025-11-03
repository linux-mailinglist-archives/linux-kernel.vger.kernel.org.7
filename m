Return-Path: <linux-kernel+bounces-882286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF8C2A103
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2043F4EC7D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1827FB1F;
	Mon,  3 Nov 2025 05:26:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD2B28DB3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147591; cv=none; b=aWWkDwOu0T9pvappKy/BfWOhb7VQftsV72LrsBFXb2Dgrzr6N/ELljcd9mo/9+8N+IK125P0qSTRsh2T1kSgetRdAX/BjUVXoBDe0v/mANRQKrwUEYNOJ9sDY+ZLNseH0lO3R21qXfD+rLZ7ovIRm1hmg4dL0ASCUfcY1KQ1gdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147591; c=relaxed/simple;
	bh=+8B9nK2NwQ4tZJu3O02bdjaoACAiFxg47VSJaGzF8IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XHg34NmKX+gHfEcFzWu3obPiQzC//XbKWTcrokjIhN1GJKL5U3NJm5XqfDhphHtyf+VUruy7EB8z+l53D0xiLrGHFMkDr7DUuy00LbRbMRUf0cXbaEpqFe3zD4D0Mqe39vaMEmvbZ7EW/lJG/N6n83kwXOVuifwxZKHPB/9U4us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F02E7292B;
	Sun,  2 Nov 2025 21:26:19 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E7403F63F;
	Sun,  2 Nov 2025 21:26:26 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] arm64/mm: Directly use TTBRx_EL1_ASID_MASK
Date: Mon,  3 Nov 2025 05:26:13 +0000
Message-Id: <20251103052618.586763-2-anshuman.khandual@arm.com>
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

Replace all TTBR_ASID_MASK macro instances with TTBRx_EL1_ASID_MASK which
is a standard field mask from tools sysreg format. No functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 2 +-
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/include/asm/uaccess.h     | 6 +++---
 arch/arm64/kernel/entry.S            | 2 +-
 arch/arm64/mm/context.c              | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 9148f5a31968..12aa6a283249 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -15,7 +15,7 @@
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	.macro	__uaccess_ttbr0_disable, tmp1
 	mrs	\tmp1, ttbr1_el1			// swapper_pg_dir
-	bic	\tmp1, \tmp1, #TTBR_ASID_MASK
+	bic	\tmp1, \tmp1, #TTBRx_EL1_ASID_MASK
 	sub	\tmp1, \tmp1, #RESERVED_SWAPPER_OFFSET	// reserved_pg_dir
 	msr	ttbr0_el1, \tmp1			// set reserved TTBR0_EL1
 	add	\tmp1, \tmp1, #RESERVED_SWAPPER_OFFSET
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 0dbe3b29049b..59f8b9b40184 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -218,7 +218,7 @@ static inline void update_saved_ttbr0(struct task_struct *tsk,
 	if (mm == &init_mm)
 		ttbr = phys_to_ttbr(__pa_symbol(reserved_pg_dir));
 	else
-		ttbr = phys_to_ttbr(virt_to_phys(mm->pgd)) | ASID(mm) << 48;
+		ttbr = phys_to_ttbr(virt_to_phys(mm->pgd)) | ASID(mm) << TTBRx_EL1_ASID_SHIFT;
 
 	WRITE_ONCE(task_thread_info(tsk)->ttbr0, ttbr);
 }
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 1aa4ecb73429..52daf9c2ba42 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -62,7 +62,7 @@ static inline void __uaccess_ttbr0_disable(void)
 
 	local_irq_save(flags);
 	ttbr = read_sysreg(ttbr1_el1);
-	ttbr &= ~TTBR_ASID_MASK;
+	ttbr &= ~TTBRx_EL1_ASID_MASK;
 	/* reserved_pg_dir placed before swapper_pg_dir */
 	write_sysreg(ttbr - RESERVED_SWAPPER_OFFSET, ttbr0_el1);
 	/* Set reserved ASID */
@@ -85,8 +85,8 @@ static inline void __uaccess_ttbr0_enable(void)
 
 	/* Restore active ASID */
 	ttbr1 = read_sysreg(ttbr1_el1);
-	ttbr1 &= ~TTBR_ASID_MASK;		/* safety measure */
-	ttbr1 |= ttbr0 & TTBR_ASID_MASK;
+	ttbr1 &= ~TTBRx_EL1_ASID_MASK;		/* safety measure */
+	ttbr1 |= ttbr0 & TTBRx_EL1_ASID_MASK;
 	write_sysreg(ttbr1, ttbr1_el1);
 
 	/* Restore user page table */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f8018b5c1f9a..9e1bcc821a16 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -473,7 +473,7 @@ alternative_else_nop_endif
 	 */
 SYM_CODE_START_LOCAL(__swpan_entry_el1)
 	mrs	x21, ttbr0_el1
-	tst	x21, #TTBR_ASID_MASK		// Check for the reserved ASID
+	tst	x21, #TTBRx_EL1_ASID_MASK	// Check for the reserved ASID
 	orr	x23, x23, #PSR_PAN_BIT		// Set the emulated PAN in the saved SPSR
 	b.eq	1f				// TTBR0 access already disabled
 	and	x23, x23, #~PSR_PAN_BIT		// Clear the emulated PAN in the saved SPSR
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index b2ac06246327..718c495832d0 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -358,11 +358,11 @@ void cpu_do_switch_mm(phys_addr_t pgd_phys, struct mm_struct *mm)
 
 	/* SW PAN needs a copy of the ASID in TTBR0 for entry */
 	if (IS_ENABLED(CONFIG_ARM64_SW_TTBR0_PAN))
-		ttbr0 |= FIELD_PREP(TTBR_ASID_MASK, asid);
+		ttbr0 |= FIELD_PREP(TTBRx_EL1_ASID_MASK, asid);
 
 	/* Set ASID in TTBR1 since TCR.A1 is set */
-	ttbr1 &= ~TTBR_ASID_MASK;
-	ttbr1 |= FIELD_PREP(TTBR_ASID_MASK, asid);
+	ttbr1 &= ~TTBRx_EL1_ASID_MASK;
+	ttbr1 |= FIELD_PREP(TTBRx_EL1_ASID_MASK, asid);
 
 	cpu_set_reserved_ttbr0_nosync();
 	write_sysreg(ttbr1, ttbr1_el1);
-- 
2.30.2



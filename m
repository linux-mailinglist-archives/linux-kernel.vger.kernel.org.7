Return-Path: <linux-kernel+bounces-853618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAE5BDC1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F283B506B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35FB3090D0;
	Wed, 15 Oct 2025 02:10:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834A93081CA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494236; cv=none; b=Tp8uXHqkHHcOQkec2wQneS7CMb8GEjKvDouaW1TPLnw503x9jJIEJ/20Wh2md3tTzAp7m3W1+xCUwsANvBsJG3+DVH26f6OULgEqr1Rv/VvAE/p2SKZyop60KC7opUoA9jXmY0Cu7jh1Unsj8AJdKi7fVY0HQHjF7aOFIi7tILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494236; c=relaxed/simple;
	bh=yB617cmhPJFksMtAgmDAP2ixLgzxBiofFTu5bYu42zc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ufBti4l14ROVnFy/1Th+TMLQy2vgiTrPJgv3xKDGRuDz/Bdw5wNhWGrZ+NSkEvreKC+gcZ0LrUqlpn2gZWJgne1TC5IwwCMAeumOHW7t1Qo6otJ4QK3h1zUQ+c4sW0l0GrPmQAWOGllESKtfflHM7UU14qFrBwW7ZzkBJ0MvNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B25F1A32;
	Tue, 14 Oct 2025 19:10:24 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD4833F738;
	Tue, 14 Oct 2025 19:10:30 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ryan.roberts@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop cpu_set_[default|idmap]_tcr_t0sz()
Date: Wed, 15 Oct 2025 03:10:24 +0100
Message-Id: <20251015021024.366722-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These TCR_El1 helpers don't have any other callers. Drop these redundant
indirections completely thus making this code more compact and readable.
No functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/mmu_context.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 1b4ac7b23e18..0375ca3162ff 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -61,11 +61,6 @@ static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
 	cpu_do_switch_mm(virt_to_phys(pgd),mm);
 }
 
-/*
- * TCR.T0SZ value to use when the ID map is active.
- */
-#define idmap_t0sz	TCR_T0SZ(IDMAP_VA_BITS)
-
 /*
  * Ensure TCR.T0SZ is set to the provided value.
  */
@@ -82,9 +77,6 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 	isb();
 }
 
-#define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(vabits_actual))
-#define cpu_set_idmap_tcr_t0sz()	__cpu_set_tcr_t0sz(idmap_t0sz)
-
 /*
  * Remove the idmap from TTBR0_EL1 and install the pgd of the active mm.
  *
@@ -103,7 +95,7 @@ static inline void cpu_uninstall_idmap(void)
 
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	cpu_set_default_tcr_t0sz();
+	__cpu_set_tcr_t0sz(TCR_T0SZ(vabits_actual));
 
 	if (mm != &init_mm && !system_uses_ttbr0_pan())
 		cpu_switch_mm(mm->pgd, mm);
@@ -113,7 +105,7 @@ static inline void cpu_install_idmap(void)
 {
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	cpu_set_idmap_tcr_t0sz();
+	__cpu_set_tcr_t0sz(TCR_T0SZ(IDMAP_VA_BITS));
 
 	cpu_switch_mm(lm_alias(idmap_pg_dir), &init_mm);
 }
-- 
2.30.2



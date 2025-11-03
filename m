Return-Path: <linux-kernel+bounces-882290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF73C2A100
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5009347599
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8226CE25;
	Mon,  3 Nov 2025 05:26:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8328B4F0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147596; cv=none; b=G9ce0JKqGhgj1shhI2fTka6nn8Qk84M/Xs0Pb0FtWKe2RcsHJgr0nOVQ8f0Rflm9hSzlRgtC61i9aDaXFz35j4GdZ2+TVoJ0CeZAMERfmvcdBxZhSmCnDsaxdDO5McB3WOfLC5AziXZHUcXYCc2XuYDDg7X6SBPjiM+Z4Tf4lVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147596; c=relaxed/simple;
	bh=aGvapYLXCuLH4VJFyaZvlpdc6h+prlxUfBzZN3jrGsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+s20uSjzNc3gNbHwKJuB2pxDcOqPq1m6bafK2WgV8DGEwLVP8EkDWxh3YaiIsDsluSKUcJrn6FXhFUIswMsyU3qIhgMcLXMJ5dMR8yHtfkrcjFCwbbeJSY0dZFa03QIW6WUpq9eFDg6rHbBmYPqPBJi+pztynKjlRMaZwA8seE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7E5292B;
	Sun,  2 Nov 2025 21:26:26 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 479CF3F63F;
	Sun,  2 Nov 2025 21:26:33 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64/mm: Describe 52 PA folding into TTBRx_EL1
Date: Mon,  3 Nov 2025 05:26:17 +0000
Message-Id: <20251103052618.586763-6-anshuman.khandual@arm.com>
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

A 52 bit physical address gets stored in TTBR_BADDR_MASK_52 in a folded
manner. Shifting PA[51:0] right ward by '46' bits aligns PA[51:48] into
TTBRx_EL1[5:2] which gets ORed for the final TTBRx_EL1 encoding.

Define TTBR_BADDR_HIGH_52_PA_PIVOT which describes this inflection point
where this right shift is done thus bringing some clarity to this 52 PA
address folding process in TTBRx_EL1.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/assembler.h     |  2 +-
 arch/arm64/include/asm/pgtable-hwdef.h | 14 ++++++++++++++
 arch/arm64/include/asm/pgtable.h       |  3 ++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index d5eb09fc5f8a..731b29d0506c 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -605,7 +605,7 @@ alternative_endif
  */
 	.macro	phys_to_ttbr, ttbr, phys
 #ifdef CONFIG_ARM64_PA_BITS_52
-	orr	\ttbr, \phys, \phys, lsr #46
+	orr	\ttbr, \phys, \phys, lsr #TTBR_BADDR_52_PA_PIVOT
 	and	\ttbr, \ttbr, #TTBR_BADDR_MASK_52
 #else
 	mov	\ttbr, \phys
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index e192c4dc624b..fb9f651375a9 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -333,6 +333,20 @@
  * TTBR_ELx[1] is RES0 in this configuration.
  */
 #define TTBR_BADDR_MASK_52	(TTBRx_EL1_BADDR_MASK & ~GENMASK(1, 1))
+
+/*
+ * A 52 bit physical address gets stored in TTBR_BADDR_MASK_52 i.e
+ * GENMASK(47, 2) in a folded manner. Shifting PA[51:0] right ward
+ * by 46 bits aligns PA[51:48] into TTBRx_EL1[5:2] which gets ORed
+ * subsequently for the final TTBRx_EL1 encoding.
+ *
+ * 47                                              5          2  0
+ * +----------------------------------------------+-----------+--+
+ * |                      PA[47:X]                | PA[51:48] |  |
+ * +----------------------------------------------+-----------+--+
+ *
+ */
+#define TTBR_BADDR_52_PA_PIVOT 46
 #endif
 
 #ifdef CONFIG_ARM64_VA_BITS_52
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c3110040c137..3457045c1045 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1602,7 +1602,8 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
 
 #ifdef CONFIG_ARM64_PA_BITS_52
-#define phys_to_ttbr(addr)	(((addr) | ((addr) >> 46)) & TTBR_BADDR_MASK_52)
+#define phys_to_ttbr(addr)	(((addr) | ((addr) >> TTBR_BADDR_52_PA_PIVOT)) & \
+				 TTBR_BADDR_MASK_52)
 #else
 #define phys_to_ttbr(addr)	(addr & TTBRx_EL1_BADDR_MASK)
 #endif
-- 
2.30.2



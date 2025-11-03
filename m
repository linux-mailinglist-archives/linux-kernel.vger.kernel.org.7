Return-Path: <linux-kernel+bounces-882289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE2EC2A106
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BAA54EE319
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158328C840;
	Mon,  3 Nov 2025 05:26:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0BB241695
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147594; cv=none; b=TFmtqWK+5ERwVoAyI/xLtdWxdbEJMO95taM3TqM0NIqeT2xJwkCOiDiNB34NkasiuIb+/SG2ibV2GJu+M9Mjt6OmRgBzR92lODAVAkKeAGynuAVY1sOvIL0ylHSJlBnDYFEJZgBXqUUTWxn7R92cTTxULTxDevsYaAxKuWl246Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147594; c=relaxed/simple;
	bh=OzfK6dEVcshY/zkzH05K6gZlKS8WuKVkwI+Kb/zEX4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzivWJ/S04NpvuHeGla2ZebY+TtPxze0YMymTlQ36zIJ8tv2qRB4cKN3e18ReRaAIY2/qs5rHLV+bXyPbtM0yhs1OBQeyaBBxAr2fcPqbAl/7sl/65Wh47kdd8JmZztf0g4iPMFVHuOaZazvE9kURqdp4jIs8Zlw0NcsrmRVcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E2C328FA;
	Sun,  2 Nov 2025 21:26:25 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 891F23F63F;
	Sun,  2 Nov 2025 21:26:31 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64/mm: Ensure correct 48 bit PA gets into TTBRx_EL1
Date: Mon,  3 Nov 2025 05:26:16 +0000
Message-Id: <20251103052618.586763-5-anshuman.khandual@arm.com>
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

Even though 48 bit PA representation in TTBRx_EL1 does not involve shifting
partial bits like 52 bit variant does, they sill need to be masked properly
for correctness. Hence mask 48 bit PA with TTBRx_EL1_BADDR_MASK.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/assembler.h | 1 +
 arch/arm64/include/asm/pgtable.h   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 23be85d93348..d5eb09fc5f8a 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -609,6 +609,7 @@ alternative_endif
 	and	\ttbr, \ttbr, #TTBR_BADDR_MASK_52
 #else
 	mov	\ttbr, \phys
+	and	\ttbr, \ttbr, #TTBRx_EL1_BADDR_MASK
 #endif
 	.endm
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0944e296dd4a..c3110040c137 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1604,7 +1604,7 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #ifdef CONFIG_ARM64_PA_BITS_52
 #define phys_to_ttbr(addr)	(((addr) | ((addr) >> 46)) & TTBR_BADDR_MASK_52)
 #else
-#define phys_to_ttbr(addr)	(addr)
+#define phys_to_ttbr(addr)	(addr & TTBRx_EL1_BADDR_MASK)
 #endif
 
 /*
-- 
2.30.2



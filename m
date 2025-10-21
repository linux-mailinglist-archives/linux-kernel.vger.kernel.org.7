Return-Path: <linux-kernel+bounces-862189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E31BF4A20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863EC18C46B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF65F25A324;
	Tue, 21 Oct 2025 05:20:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1577246BD7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024038; cv=none; b=gXNanVeWVlU6aF+L75WRyebPf191K1yqDedfj5AzrSe6WwEhKuNkm2lAcmzpFPxPEavmbblTjYR6PACJ82ihM19zyznPBLVsBXop3RBOvXzAGAo2HlOA1XEdBt5d1W7m9la9ontDAPIRobhyEz5zfw6m0B2THOtCofdWWZeYreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024038; c=relaxed/simple;
	bh=GaVG21qFGL5Wv3M+puZKLzXL3wwihN2P/oPJ2RoSpRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cWpTVcyqLPe/gmZg9GEmAZLEfguNVDtSTEn6tsVdpYr7CJWWIKQ3UPSASNu/Ic0O1aPbyWvzJXl505QtHugy0T1/0zYTas/JGmEZN5TRlrSp37Lj6C1mKr+wgfNZjbQi+l8aKPQBZ+UXIbvnM7I13f00DfseHXSeV1aPPu2VnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 045AD19F0;
	Mon, 20 Oct 2025 22:20:28 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D754D3F59E;
	Mon, 20 Oct 2025 22:20:34 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64/mm: Add remaining TLBI_XXX_MASK macros
Date: Tue, 21 Oct 2025 06:20:22 +0100
Message-Id: <20251021052022.2898275-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251021052022.2898275-1-anshuman.khandual@arm.com>
References: <20251021052022.2898275-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add remaining TLBI_XXX_MASK macros and replace current open encoded fields.
While here replace hard coded page size based shifts but with derived ones
via ilog2() thus adding some required context.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 131096094f5b..cf75fc2a06c3 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -57,9 +57,10 @@
 /* This macro creates a properly formatted VA operand for the TLBI */
 #define __TLBI_VADDR(addr, asid)				\
 	({							\
-		unsigned long __ta = (addr) >> 12;		\
-		__ta &= GENMASK_ULL(43, 0);			\
-		__ta |= (unsigned long)(asid) << 48;		\
+		unsigned long __ta = (addr) >> ilog2(SZ_4K);	\
+		__ta &= TLBI_BADDR_MASK;			\
+		__ta &= ~TLBI_ASID_MASK;			\
+		__ta |= FIELD_PREP(TLBI_ASID_MASK, asid);	\
 		__ta;						\
 	})
 
@@ -100,8 +101,17 @@ static inline unsigned long get_trans_granule(void)
  *
  * For Stage-2 invalidation, use the level values provided to that effect
  * in asm/stage2_pgtable.h.
+ *
+ * +----------+------+-------+--------------------------------------+
+ * |   ASID   |  TG  |  TTL  |                 BADDR                |
+ * +-----------------+-------+--------------------------------------+
+ * |63      48|47  46|45   44|43                                   0|
+ * +----------+------+-------+--------------------------------------+
  */
-#define TLBI_TTL_MASK		GENMASK_ULL(47, 44)
+#define TLBI_ASID_MASK		GENMASK_ULL(63, 48)
+#define TLBI_TG_MASK		GENMASK_ULL(47, 46)
+#define TLBI_TTL_MASK		GENMASK_ULL(45, 44)
+#define TLBI_BADDR_MASK		GENMASK_ULL(43, 0)
 
 #define TLBI_TTL_UNKNOWN	INT_MAX
 
@@ -110,10 +120,10 @@ static inline unsigned long get_trans_granule(void)
 									\
 	if (alternative_has_cap_unlikely(ARM64_HAS_ARMv8_4_TTL) &&	\
 	    level >= 0 && level <= 3) {					\
-		u64 ttl = level;					\
-		ttl |= get_trans_granule() << 2;			\
+		arg &= ~TLBI_TG_MASK;					\
+		arg |= FIELD_PREP(TLBI_TG_MASK, get_trans_granule());	\
 		arg &= ~TLBI_TTL_MASK;					\
-		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
+		arg |= FIELD_PREP(TLBI_TTL_MASK, level);		\
 	}								\
 									\
 	__tlbi(op, arg);						\
@@ -383,7 +393,7 @@ do {									\
 	typeof(pages) __flush_pages = pages;				\
 	int num = 0;							\
 	int scale = 3;							\
-	int shift = lpa2 ? 16 : PAGE_SHIFT;				\
+	int shift = lpa2 ? ilog2(SZ_64K) : PAGE_SHIFT;			\
 	unsigned long addr;						\
 									\
 	while (__flush_pages > 0) {					\
-- 
2.30.2



Return-Path: <linux-kernel+bounces-882291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7E2C2A10C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74703B1FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0B291C33;
	Mon,  3 Nov 2025 05:26:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D17528D8CC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147597; cv=none; b=sfQLOHo+j1TbFNTNeJac774bDCYBlEtkRTYpU8Pv5Is3RW8IJUdp7fLBR6lfpHQf3EMRDRV0ZxzFOFiPDTJhLqcPNtZhjZwna+cSG7dplhcYNmmbvvKSOMSrB7A2/cBGCLVHP76HNH6E6NZRhaL+sFJrP59y9SLr8IXj06OaEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147597; c=relaxed/simple;
	bh=Z/y6w325RCO5ce3AI9VlqvFaOO28YYFIcCVhqt1U7Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0QfGPs5WkrROx8udRkw7G5f8yoGduwL2Uq48SdI1dXRiJqbSmvEv83jj9ELKUXvpRWSBIYVTpt1M+go9YV6sUsogcASqm07WI94dpDDp7J9v4yabKpYT6zD1gr1p2Ezdn10tLvmbv6lSmpKLq6qsfNphaQGcyhLRxDU5icREfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C7F228FA;
	Sun,  2 Nov 2025 21:26:28 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 037DA3F63F;
	Sun,  2 Nov 2025 21:26:34 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64/mm: Describe TTBR1_BADDR_4852_OFFSET
Date: Mon,  3 Nov 2025 05:26:18 +0000
Message-Id: <20251103052618.586763-7-anshuman.khandual@arm.com>
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

TTBR1_BADDR_4852_OFFSET is a constant offset which gets added into kernel
page table physical address for TTBR1_EL1 when kernel is build for 52 bit
VA but found to be running on 48 bit VA capable system. Although there is
no explanation on how the macro is computed.

Describe TTBR1_BADDR_4852_OFFSET computation in detail via deriving from
all required parameters involved thus improving clarity and readability.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index fb9f651375a9..e3d070fdae6a 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -350,9 +350,12 @@
 #endif
 
 #ifdef CONFIG_ARM64_VA_BITS_52
+#define PTRS_PER_PGD_52_VA (UL(1) << (52 - PGDIR_SHIFT))
+#define PTRS_PER_PGD_48_VA (UL(1) << (48 - PGDIR_SHIFT))
+#define PTRS_PER_PGD_EXTRA (PTRS_PER_PGD_52_VA - PTRS_PER_PGD_48_VA)
+
 /* Must be at least 64-byte aligned to prevent corruption of the TTBR */
-#define TTBR1_BADDR_4852_OFFSET	(((UL(1) << (52 - PGDIR_SHIFT)) - \
-				 (UL(1) << (48 - PGDIR_SHIFT))) * 8)
+#define TTBR1_BADDR_4852_OFFSET (PTRS_PER_PGD_EXTRA << PTDESC_ORDER)
 #endif
 
 #endif
-- 
2.30.2



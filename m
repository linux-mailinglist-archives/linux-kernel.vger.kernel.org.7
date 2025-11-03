Return-Path: <linux-kernel+bounces-882288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E027C2A0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8243B2672
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E128A1E6;
	Mon,  3 Nov 2025 05:26:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CFA72614
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147594; cv=none; b=YYTdZVJdX0R5Zl3c4IqQ0R8VZG2+WhlEe0IR5SnkhRYeNYfbdSj0rBxD58Ld+U9vVUHwv1KCamm/rcusTIXvDM69qx9o+B3QXGiCA8WIxGaaIsXqkVLaZk6zhauqTk4IrVm7Kdg0y+T3zCygWnqyDk2sHoLu2MlPJ08P+Us+3oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147594; c=relaxed/simple;
	bh=NsA6MstwVKVb6qAUKC43Hsur9WtUnv6BWJyTcFCB9aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEqWu3XJp9DiVNeJg3+jlmGmcK9Z3qnrDihqIMd8royTb7zQuBxdysveb420hUz44CeJL0WwmH7bCU9NTNgBiqzcEaAjEDGhAGMGR1zr2qdGNW8w5SDNTSTzoC5HZ4VAtk1A5/AynLNu3B1c/PVQy+vhNknUdIypHS5n+YPFbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 626E42938;
	Sun,  2 Nov 2025 21:26:23 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CACD53F63F;
	Sun,  2 Nov 2025 21:26:29 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64/mm: Represent TTBR_BADDR_MASK_52 with TTBRx_EL1_BADDR_MASK
Date: Mon,  3 Nov 2025 05:26:15 +0000
Message-Id: <20251103052618.586763-4-anshuman.khandual@arm.com>
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

TTBR_BADDR_MASK_52 discards bit[1] which is RES0, when TTBRx_EL1 register
contains 52 bits PA. Let's just keep the custom macro but redefine it via
tools sysreg register field format TTBRx_EL1_BADDR_MASK.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index f3b77deedfa2..e192c4dc624b 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -332,7 +332,7 @@
 /*
  * TTBR_ELx[1] is RES0 in this configuration.
  */
-#define TTBR_BADDR_MASK_52	GENMASK_ULL(47, 2)
+#define TTBR_BADDR_MASK_52	(TTBRx_EL1_BADDR_MASK & ~GENMASK(1, 1))
 #endif
 
 #ifdef CONFIG_ARM64_VA_BITS_52
-- 
2.30.2



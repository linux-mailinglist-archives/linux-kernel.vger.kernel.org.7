Return-Path: <linux-kernel+bounces-879581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E7C23825
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBEBE4F075A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54566327203;
	Fri, 31 Oct 2025 07:13:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2F13271F9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894784; cv=none; b=R8HXgap2jXRv/sr8rqzmQEWmcLlG61H447sqkb2x4yMjomQwztrx9aXW1B+PBPlnv6EvdjpcjxVqAohJ7LHIZEWOcQE9DZ2lThhPWZK6FsKx93gFItD3oTq4+eFsmIe7Ls2xgDRKTmRtYjnB+2ej/8QjfFb6afBSjDPi5g6gyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894784; c=relaxed/simple;
	bh=H32UaZBzakVlFxKSnLtgEU39K7zsbRcWtrPNj5VfTmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNpjYpSTjf7oZ957eFDRFBI3T0nywmF56/loYF+8vY20rBJsNHkyKO54Aj2yaRp0/96aE2YYJBF36btouvpGFuc+tesnVXqoE1iRiZ4TXc7DqpOXdzzC7YuDU3JEZMupgSm/WC6cBx4tAHmvL2ZQG2UipWARu08xDUmvudAN++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C4E81595;
	Fri, 31 Oct 2025 00:12:53 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54DC73F63F;
	Fri, 31 Oct 2025 00:13:00 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Ensure PGD_SIZE is aligned to 64 bytes when PA_BITS = 52
Date: Fri, 31 Oct 2025 07:12:55 +0000
Message-Id: <20251031071255.3335501-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the comment clearly states about PGD table's alignment requirement
(when PA_BITS = 52) but the subsequent BUILD_BUG_ON() tests size comparison
to 64 bytes instead. So change it as an actual alignment test.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/pgd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 8160cff35089..bf5110b91e2f 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -56,7 +56,7 @@ void __init pgtable_cache_init(void)
 	 * With 52-bit physical addresses, the architecture requires the
 	 * top-level table to be aligned to at least 64 bytes.
 	 */
-	BUILD_BUG_ON(PGD_SIZE < 64);
+	BUILD_BUG_ON(!IS_ALIGNED(PGD_SIZE, 64));
 #endif
 
 	/*
-- 
2.30.2



Return-Path: <linux-kernel+bounces-731173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297CB05067
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F737A8A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981B12D1913;
	Tue, 15 Jul 2025 04:39:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA32D12E1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752554385; cv=none; b=JNFo3dy/dlyY9CX3ty9hdxX2MwRKT8TZs8H9PnjbXAMsEAId/7C08TsM4NwK3cF3l+MDB49kQsrGjtAXX1jqJxtwZud3t2DkOIacwRAHujg2Ur5l1TB/VA9crcV073jb6EWrnFszm/obxauvWdNBYMV2BNAIwnkIDAvHcm7uzxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752554385; c=relaxed/simple;
	bh=n10kQxDbIIcMFCsSBSOBIt0O5HebwKLVYb0lHAYy3m0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QlSqV63LOcEsPmRaqQKPY3wePShytizM25WAf0IJD4Yf/VImjs/tnKbYQAnpgA+UY3jFe4ewsMRahgGStBmlzMDeHPgBDqZskEqO/xwcborxEjdF+ucQGoaSlIn/Rg+JfV16fDJQG5AQBJq0E8i0iFj3MueyMWI2EGKGgcvU9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD3551515;
	Mon, 14 Jul 2025 21:39:26 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84E993F6A8;
	Mon, 14 Jul 2025 21:39:34 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop redundant addr increment in set_huge_pte_at()
Date: Tue, 15 Jul 2025 05:39:22 +0100
Message-Id: <20250715043922.57195-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'addr' need not be incremented while operating on single entry basis as
BBM is not required for such updates.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0c8737f4f2ce..1d90a7e75333 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -225,7 +225,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	ncontig = num_contig_ptes(sz, &pgsize);
 
 	if (!pte_present(pte)) {
-		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
+		for (i = 0; i < ncontig; i++, ptep++)
 			__set_ptes_anysz(mm, ptep, pte, 1, pgsize);
 		return;
 	}
-- 
2.30.2



Return-Path: <linux-kernel+bounces-822564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD61B8423B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4258B1627B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7784927FD48;
	Thu, 18 Sep 2025 10:36:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0D22628C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191812; cv=none; b=MkPfnf2Vmfb4WpOg9YNsy43eN6CHjjQqPzZGeGq1QmesSNE9orAUvuns+mZCZe5BLG6Bx1DMc0L2OQ4p46t8+VVp7ZK4IZJ8hqYrIUBwhEq4RhMLpZ6qzN02H4zM3qFR8YPrF/MMK3BnvZ7O9w5D7/4MCbqYqOJQzTR0fXS0xTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191812; c=relaxed/simple;
	bh=Xyj/YlO6tdAphJTcqYcM0jEInHXKTptvdq5xmiXsHnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNfzL4yHYurYn/MG4r1Oc7fpXUazGODcaUB33uzOt87Z7NH5BHYOrHEIDAxs5YCTyhPuOYKi4XA8mr+8IQrAWou1HrGWdlm3aqUNxaKUtTswmN33bxzXFZMTzhym9Esz/8akg1Qe+Aj7uTvceP0L6oSz6oCEDMQm8tXehCiraeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 073451A25;
	Thu, 18 Sep 2025 03:36:40 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F1A4A3F673;
	Thu, 18 Sep 2025 03:36:44 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: anshuman.khandual@arm.com,
	wangkefeng.wang@huawei.com,
	ryan.roberts@arm.com,
	baohua@kernel.org,
	pjaroszynski@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] arm64/mm: Elide TLB flush in certain pte protection transitions
Date: Thu, 18 Sep 2025 16:06:38 +0530
Message-Id: <20250918103638.77282-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently arm64 does an unconditional TLB flush in mprotect(). This is not
required for some cases, for example, when changing from PROT_NONE to
PROT_READ | PROT_WRITE (a real usecase - glibc malloc does this to emulate
growing into the non-main heaps), and unsetting uffd-wp in a range.

Therefore, implement pte_needs_flush() for arm64, which is already
implemented by some other arches as well.

Running a userspace program changing permissions back and forth between
PROT_NONE and PROT_READ | PROT_WRITE, and measuring the average time taken
for the none->rw transition, I get a reduction from 3.2 microseconds to
2.95 microseconds, giving an 8.5% improvement.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
mm-selftests pass. Based on 6.17-rc6.

 arch/arm64/include/asm/tlbflush.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 18a5dc0c9a54..4a566d589100 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -524,6 +524,35 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
 {
 	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
 }
+
+static inline bool __pte_flags_need_flush(pteval_t oldval, pteval_t newval)
+{
+	pteval_t diff = oldval ^ newval;
+
+	/* invalid to valid transition requires no flush */
+	if (!(oldval & PTE_VALID) || (oldval & PTE_PRESENT_INVALID))
+		return false;
+
+	/* Transition in the SW bits and access flag requires no flush */
+	diff &= ~(PTE_SWBITS_MASK | PTE_AF);
+
+	if (!diff)
+		return false;
+	return true;
+}
+
+static inline bool pte_needs_flush(pte_t oldpte, pte_t newpte)
+{
+	return __pte_flags_need_flush(pte_val(oldpte), pte_val(newpte));
+}
+#define pte_needs_flush pte_needs_flush
+
+static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
+{
+	return __pte_flags_need_flush(pmd_val(oldpmd), pmd_val(newpmd));
+}
+#define huge_pmd_needs_flush huge_pmd_needs_flush
+
 #endif
 
 #endif
-- 
2.30.2



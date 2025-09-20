Return-Path: <linux-kernel+bounces-825500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CAEB8BF8B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 07:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C561567FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B162222C0;
	Sat, 20 Sep 2025 05:11:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A01D13AD1C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758345063; cv=none; b=JcX/d2ILhkqLEHYAPI869UJbLtyUtKUQnmByvBoNxivMvOxWBEhBDR8jXtGJwhK918JwoUlNDHezA2qSf2dNzu0RQshKZFQrTSXlg1wcEMMsKV2ik3oocRtXbkHvlBuGVFnKF4DVDZs024Rk5o3gJNkvcCJqNeqhIKgk/PAWZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758345063; c=relaxed/simple;
	bh=cWOc6vLpQ2APLMR4i2pRRUIZRmy1NcaFr3QbisZo+MM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ngT+G8qIZ8ytYiAU0IQSCvjlL4kv8wFslxNgsfWtgO8IptPuPoloPCFpcmZKRPGr4P7iS8I4hdbketPYVlbH5uxk5k4YoQ+bAFPgFpb8ebyXK1e0YpHgiQ8dQR3Shs/TsKKN4KxpSDk5WqlBmxpxuiVns4d67VV5ljNq9STjJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 767B41688;
	Fri, 19 Sep 2025 22:10:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.163.75.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB8F93F673;
	Fri, 19 Sep 2025 22:10:56 -0700 (PDT)
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
Subject: [PATCH v2] arm64/mm: Elide TLB flush in certain pte protection transitions
Date: Sat, 20 Sep 2025 10:40:43 +0530
Message-Id: <20250920051043.16421-1-dev.jain@arm.com>
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
2.85 microseconds, giving a 12.3% improvement.

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
mm-selftests pass.

v1->v2:
 - Drop PTE_PRESENT_INVALID and PTE_AF checks, use ptdesc_t instead of
   pteval_t, return !!diff (Ryan)

 arch/arm64/include/asm/tlbflush.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 18a5dc0c9a54..40df783ba09a 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -524,6 +524,33 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
 {
 	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
 }
+
+static inline bool __pte_flags_need_flush(ptdesc_t oldval, ptdesc_t newval)
+{
+	ptdesc_t diff = oldval ^ newval;
+
+	/* invalid to valid transition requires no flush */
+	if (!(oldval & PTE_VALID))
+		return false;
+
+	/* Transition in the SW bits requires no flush */
+	diff &= ~PTE_SWBITS_MASK;
+
+	return !!diff;
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



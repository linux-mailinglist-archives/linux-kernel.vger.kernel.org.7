Return-Path: <linux-kernel+bounces-888937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDAEC3C563
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 889CC4FEF97
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4C534DB71;
	Thu,  6 Nov 2025 16:10:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0753534CFBC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445402; cv=none; b=ewXggCXEuWj7sImgFJRWq+J1RPP/7T+YOATAFN/t7hhQxnKahwF7IJ0QjwP8o97EX2nzeTX6TvqrVZ8OrXppM9/S8gnKZlGfD1uhunbQOFIKi4jLXT1eWIgo58DPqSTZQ9uWHPiOaT19HNZpCm8BTFFhqdmogeXjn/pBwF2KUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445402; c=relaxed/simple;
	bh=zl7sUm3Roi+xYSTdbpG6i/QWcWRVDBqGiezbcNG0vrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3EXI3FZMoEJ2NHy18Noay7X3N1YPWTtYJw6I72jmB3o0EeHxps248aKAh1qGhqdShp0MLUUdekCyuTPdipwguZJd5OpKPFQOCwgrGbXjuQZxtBntRiRJ6np38WVMfLmJMNvTJhtxOWFeIdVyOldN4acHPuauLAg0eHfL4N+NGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8D7C15A1;
	Thu,  6 Nov 2025 08:09:52 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E69B3F66E;
	Thu,  6 Nov 2025 08:09:59 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com,
	david@redhat.com,
	ardb@kernel.org,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH v2 3/3] arm64: mm: Tidy up force_pte_mapping()
Date: Thu,  6 Nov 2025 16:09:43 +0000
Message-ID: <20251106160945.3182799-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106160945.3182799-1-ryan.roberts@arm.com>
References: <20251106160945.3182799-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy up the implementation of force_pte_mapping() to make it easier to
read and introduce the split_leaf_mapping_possible() helper to reduce
code duplication in split_kernel_leaf_mapping() and
arch_kfence_init_pool().

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/mmu.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 652bb8c14035..2ba01dc8ef82 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -710,12 +710,26 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 
 static inline bool force_pte_mapping(void)
 {
-	bool bbml2 = system_capabilities_finalized() ?
+	const bool bbml2 = system_capabilities_finalized() ?
 		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
 
-	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
-			   is_realm_world())) ||
-		debug_pagealloc_enabled();
+	if (debug_pagealloc_enabled())
+		return true;
+	if (bbml2)
+		return false;
+	return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world();
+}
+
+static inline bool split_leaf_mapping_possible(void)
+{
+	/*
+	 * !BBML2_NOABORT systems should never run into scenarios where we would
+	 * have to split. So exit early and let calling code detect it and raise
+	 * a warning.
+	 */
+	if (!system_supports_bbml2_noabort())
+		return false;
+	return !force_pte_mapping();
 }
 
 static DEFINE_MUTEX(pgtable_split_lock);
@@ -725,22 +739,11 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
 	int ret;
 
 	/*
-	 * !BBML2_NOABORT systems should not be trying to change permissions on
-	 * anything that is not pte-mapped in the first place. Just return early
-	 * and let the permission change code raise a warning if not already
-	 * pte-mapped.
-	 */
-	if (!system_supports_bbml2_noabort())
-		return 0;
-
-	/*
-	 * If the region is within a pte-mapped area, there is no need to try to
-	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
-	 * change permissions from atomic context so for those cases (which are
-	 * always pte-mapped), we must not go any further because taking the
-	 * mutex below may sleep.
+	 * Exit early if the region is within a pte-mapped area or if we can't
+	 * split. For the latter case, the permission change code will raise a
+	 * warning if not already pte-mapped.
 	 */
-	if (force_pte_mapping() || is_kfence_address((void *)start))
+	if (!split_leaf_mapping_possible() || is_kfence_address((void *)start))
 		return 0;
 
 	/*
@@ -1039,7 +1042,7 @@ bool arch_kfence_init_pool(void)
 	int ret;
 
 	/* Exit early if we know the linear map is already pte-mapped. */
-	if (!system_supports_bbml2_noabort() || force_pte_mapping())
+	if (!split_leaf_mapping_possible())
 		return true;
 
 	/* Kfence pool is already pte-mapped for the early init case. */
-- 
2.43.0



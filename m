Return-Path: <linux-kernel+bounces-888936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 001CAC3C531
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74DD450220E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF734D91C;
	Thu,  6 Nov 2025 16:10:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7047234C990
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445400; cv=none; b=mvK+ZPzRMUf2dGLFOMqZL+Z1xY499Z8ObhzMmCjdy9Y2+DRA8YZFtBD1hckPJb4+Y4OnUtQlrI55M0fV3b5KLCMTqdTj6SonzxxQs7jxux1icmZPL/xkda5KtfziSVVvCZESl+qCmRCQUtSTs8Ln2NlyzYVVEZ7J5p6Lw2ngt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445400; c=relaxed/simple;
	bh=/SIvofTh0hLevurcB7lx/H3anGNdb7zvthzKCyZDmP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtDlQiqnVBVmrBzXPAbG0oq2Qfs3A/d8pKZvnSGx/dlh6qu5hnxwUWCudF201dkgjY/SVEd0FPUTk1N3P0Q8UEKcTn3CHt8xbP2i5tMayzeVOXnPGDcXTaelp8p+MX8yl0+IEiTH16OEYe0QObmJAziTd25jU6uFh7GzE5Z3TYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26FE3169C;
	Thu,  6 Nov 2025 08:09:51 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B1433F66E;
	Thu,  6 Nov 2025 08:09:57 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: mm: Optimize range_split_to_ptes()
Date: Thu,  6 Nov 2025 16:09:42 +0000
Message-ID: <20251106160945.3182799-3-ryan.roberts@arm.com>
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

Enter lazy_mmu mode while splitting a range of memory to pte mappings.
This causes barriers, which would otherwise be emitted after every pte
(and pmd/pud) write, to be deferred until exiting lazy_mmu mode.

For large systems, this is expected to significantly speed up fallback
to pte-mapping the linear map for the case where the boot CPU has
BBML2_NOABORT, but secondary CPUs do not. I haven't directly measured
it, but this is equivalent to commit 1fcb7cea8a5f ("arm64: mm: Batch dsb
and isb when populating pgtables").

Note that for the path from arch_kfence_init_pool(), we may sleep while
allocating memory inside the lazy_mmu mode. Sleeping is not allowed by
generic code inside lazy_mmu, but we know that the arm64 implementation
is sleep-safe. So this is ok and follows the same pattern already used
by split_kernel_leaf_mapping().

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/mmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a364ac2c9c61..652bb8c14035 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -832,8 +832,14 @@ static const struct mm_walk_ops split_to_ptes_ops = {
 
 static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
 {
-	return walk_kernel_page_table_range_lockless(start, end,
+	int ret;
+
+	arch_enter_lazy_mmu_mode();
+	ret = walk_kernel_page_table_range_lockless(start, end,
 					&split_to_ptes_ops, NULL, &gfp);
+	arch_leave_lazy_mmu_mode();
+
+	return ret;
 }
 
 static bool linear_map_requires_bbml2 __initdata;
-- 
2.43.0



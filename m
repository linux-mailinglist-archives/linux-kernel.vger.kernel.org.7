Return-Path: <linux-kernel+bounces-791706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D434BB3BA52
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A95D3AECD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C444313544;
	Fri, 29 Aug 2025 11:53:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763E8314A72
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468395; cv=none; b=XkEqpb0nlb0SkRpQrl57EgJu3CyUXotYpe7Pe9MM8+OC7Por6oImgfh0SKJUoM78cm7XqsPwsRE8D0W0fa/0yFqqJBjAzxPA73s6E3uTMD+EK8w9gkm+e4Z6FwRHHWyHfg65qqiZaBgLQPycgbMvllFxeKDbPOdAPvKwelFx6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468395; c=relaxed/simple;
	bh=VMmgHVOzMooQM73FXANE/E3cueAoe+1GbPqE0emYPPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlbIGkHSe6/197EJcc9We2G5ZvsHRB6HpQkgLrLrU6CS6zu1eedq3E/4dlL9tmrh0u5hXoUdbrxlHQMk/RwNBFMqkrPEgqMZ8S179W9OD7Q2+xoaJrG51/dcevEHp+4HHwOH2Cbv9kV6LTWhIEY6e4JhIDMd5YqHqR9c73BU2iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9999819F0;
	Fri, 29 Aug 2025 04:53:05 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E687F3F694;
	Fri, 29 Aug 2025 04:53:11 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v7 4/6] arm64: mm: Optimize split_kernel_leaf_mapping()
Date: Fri, 29 Aug 2025 12:52:45 +0100
Message-ID: <20250829115250.2395585-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829115250.2395585-1-ryan.roberts@arm.com>
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The common case for split_kernel_leaf_mapping() is for a single page.
Let's optimize this by only calling split_kernel_leaf_mapping_locked()
once.

Since the start and end address are PAGE_SIZE apart, they must be
contained within the same contpte block. Further, if start is at the
beginning of the block or end is at the end of the block, then the other
address must be in the _middle_ of the block. So if we split on this
middle-of-the-contpte-block address, it is guaranteed that the
containing contpte block is split to ptes and both start and end are
therefore mapped by pte.

This avoids the second call to split_kernel_leaf_mapping_locked()
meaning we only have to walk the pgtable once.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/mmu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 114b88216b0c..8b5b19e1154b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -740,9 +740,21 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
 	mutex_lock(&pgtable_split_lock);
 	arch_enter_lazy_mmu_mode();
 
-	ret = split_kernel_leaf_mapping_locked(start);
-	if (!ret)
-		ret = split_kernel_leaf_mapping_locked(end);
+	/*
+	 * Optimize for the common case of splitting out a single page from a
+	 * larger mapping. Here we can just split on the "least aligned" of
+	 * start and end and this will guarantee that there must also be a split
+	 * on the more aligned address since the both addresses must be in the
+	 * same contpte block and it must have been split to ptes.
+	 */
+	if (end - start == PAGE_SIZE) {
+		start = __ffs(start) < __ffs(end) ? start : end;
+		ret = split_kernel_leaf_mapping_locked(start);
+	} else {
+		ret = split_kernel_leaf_mapping_locked(start);
+		if (!ret)
+			ret = split_kernel_leaf_mapping_locked(end);
+	}
 
 	arch_leave_lazy_mmu_mode();
 	mutex_unlock(&pgtable_split_lock);
-- 
2.43.0



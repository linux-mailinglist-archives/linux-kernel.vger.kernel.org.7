Return-Path: <linux-kernel+bounces-797730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF927B41491
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982785E0ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2EE2D73B9;
	Wed,  3 Sep 2025 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYa7H8e9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBAB2D6E54
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878935; cv=none; b=JBDWbO+7G5ny3y4Yvyy+87hq1AfWSPFvkwzuKt7CIx9UoEpskxQkebLlLPthiSoFtxMt1Z0yyMupxaBaT0/s6AzSMrmLYoeE7EBbDSnBApfjOa5AJhQ8GByOUZD7mmxpNhYLb2M10Yvt8l4s0umphRKVYgh9pgbor2H5W1wnAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878935; c=relaxed/simple;
	bh=TQMJY4G8FEZ42i48idBOqNZD/59sazNIl6ctJiyy854=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTbBg+KVBRgFxOK3j7ummID7b3KcqhA9pePRAusTxBw2Fq8/QCtt8GbZy8Phx6+lBkGjFxrrsc/TgGRNgcNw1wlRquQlXqWtvBgiudvfNdtfqsMTLWZDjUvqEF/KYmi9AzWISEGU0UwStueQ0RPg3zEfKhN6LhJkEOXYiquCmmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYa7H8e9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756878934; x=1788414934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQMJY4G8FEZ42i48idBOqNZD/59sazNIl6ctJiyy854=;
  b=jYa7H8e9pEnlf4d2NAO4zm1Z+ML5rXPs2a8e4x1sysCm0Fw9TpEp6ie6
   glSnaqwJ2LMkiilpsx9z+PQCrbu4UxcqTiNMxNKBxfrUBmGwhqj48qRmR
   go/AeniPh3GI6s+0v/6s9hdcrhqxQrmuVzjh6sune5/VV89BlFFmrr5zU
   rFvwjCwY4xs4+sTaMj1Wx7/3x1l1ZNX8qCmDiiGxa8OyrjIFAMoV4A5Ay
   ILvq3Vd4kWlMHIF3VLYlNkp9oAsM/euiTAA1tzmnzlx0/Zg8RzmvyG7Kt
   lj6QSU7lmzKhWah5iNpNYHj7/yhJZoPZGbQtTtjBPYfi+OVtuviT6cM7k
   Q==;
X-CSE-ConnectionGUID: xo+WGmd0SDeljTTK64kXWw==
X-CSE-MsgGUID: kzjujlm1QV+jdmkieat5iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59294870"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="59294870"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 22:55:33 -0700
X-CSE-ConnectionGUID: 4r7xdCxnTY+GFUyKtNvejw==
X-CSE-MsgGUID: bBljKCp7TuGb6TQI/mGFCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171868211"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2025 22:55:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Eugene Koira <eugkoira@amazon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Fix __domain_mapping()'s usage of switch_to_super_page()
Date: Wed,  3 Sep 2025 13:53:29 +0800
Message-ID: <20250903055329.2876815-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903055329.2876815-1-baolu.lu@linux.intel.com>
References: <20250903055329.2876815-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eugene Koira <eugkoira@amazon.com>

switch_to_super_page() assumes the memory range it's working on is aligned
to the target large page level. Unfortunately, __domain_mapping() doesn't
take this into account when using it, and will pass unaligned ranges
ultimately freeing a PTE range larger than expected.

Take for example a mapping with the following iov_pfn range [0x3fe400,
0x4c0600), which should be backed by the following mappings:

   iov_pfn [0x3fe400, 0x3fffff] covered by 2MiB pages
   iov_pfn [0x400000, 0x4bffff] covered by 1GiB pages
   iov_pfn [0x4c0000, 0x4c05ff] covered by 2MiB pages

Under this circumstance, __domain_mapping() will pass [0x400000, 0x4c05ff]
to switch_to_super_page() at a 1 GiB granularity, which will in turn
free PTEs all the way to iov_pfn 0x4fffff.

Mitigate this by rounding down the iov_pfn range passed to
switch_to_super_page() in __domain_mapping()
to the target large page level.

Additionally add range alignment checks to switch_to_super_page.

Fixes: 9906b9352a35 ("iommu/vt-d: Avoid duplicate removing in __domain_mapping()")
Signed-off-by: Eugene Koira <eugkoira@amazon.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lore.kernel.org/r/20250826143816.38686-1-eugkoira@amazon.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9c3ab9d9f69a..dff2d895b8ab 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1575,6 +1575,10 @@ static void switch_to_super_page(struct dmar_domain *domain,
 	unsigned long lvl_pages = lvl_to_nr_pages(level);
 	struct dma_pte *pte = NULL;
 
+	if (WARN_ON(!IS_ALIGNED(start_pfn, lvl_pages) ||
+		    !IS_ALIGNED(end_pfn + 1, lvl_pages)))
+		return;
+
 	while (start_pfn <= end_pfn) {
 		if (!pte)
 			pte = pfn_to_dma_pte(domain, start_pfn, &level,
@@ -1650,7 +1654,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 				unsigned long pages_to_remove;
 
 				pteval |= DMA_PTE_LARGE_PAGE;
-				pages_to_remove = min_t(unsigned long, nr_pages,
+				pages_to_remove = min_t(unsigned long,
+							round_down(nr_pages, lvl_pages),
 							nr_pte_to_next_page(pte) * lvl_pages);
 				end_pfn = iov_pfn + pages_to_remove - 1;
 				switch_to_super_page(domain, iov_pfn, end_pfn, largepage_lvl);
-- 
2.43.0



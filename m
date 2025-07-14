Return-Path: <linux-kernel+bounces-729353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF230B03559
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A343177DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068AD20E330;
	Mon, 14 Jul 2025 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8LTbZw/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15E20A5F5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468780; cv=none; b=lymdxvqJOZjNC6U8mouS05flDe4OxXgUeQ9kxyFotWU1FMG1q6sy/HIsZjlQKwn9xJNNgbcaHXWOU3Xyhmu42YZFCgblTxYuQB8q0Y8abel+u16yNpGdnUBUtf/u0NvDFdZ1R5pCnHxmiahgBmHBbTmbr+HMcAp5phOdsurjeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468780; c=relaxed/simple;
	bh=GTHbngVd52A1C620pmn/9G2aoaRoLssEGXLHdKtA9EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bf+Q2fsBhOZevILONVzaeFnNCxaHjnRgDeESipJLCFcdZH5odGpiKzjcXcRhY59vvD8t7T7pduWEdQkmhrlZUKlPp1hB7/soS/J7MSEn/GOIHq8iaIJyP4yoQLjKE4X5FFP/IRFebj1FV6mQ37c13UagUWVFitRpSrAlyCAdCt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8LTbZw/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468778; x=1784004778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GTHbngVd52A1C620pmn/9G2aoaRoLssEGXLHdKtA9EQ=;
  b=S8LTbZw/4h9ZxpYUo5kMfSQPA72kNR51BCgKYtSXU/xZud+GTY1IKKqi
   sWcVW7fSEzlMS/pwCrlezJXh0w3xN4Apt0kIqqpe+AZo56WvnirXPN01z
   rb1T4ToINh3nrMHv9KUN7bVI4i1QkDe40sk1HypMMD+5uhuVReL43VUco
   YI0kQadBi9mQD/npb4SI2ahBNEi7t0G4k9+UB1Dahc+9sY6EGRkyEOlvE
   XmyDCHahLG2kEQKNLwPewSv6VwxngJ8a5+OD9z23Lw2y48ShLtTMf1mpu
   4XELcY7iW1K2s6TORWJqyZomWlsRyfmLScw7Vtqp50ml/LOINwYMJGbNa
   A==;
X-CSE-ConnectionGUID: CNjo504WRoqxrpNB6qIJkg==
X-CSE-MsgGUID: /TdEyxieR/WFG7occXIwmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765065"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765065"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:58 -0700
X-CSE-ConnectionGUID: 0EofOn55SR2Euldm+wgHUQ==
X-CSE-MsgGUID: MCXsC1bqTwCh8GgxK0j1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166201"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] iommu/vt-d: Split intel_iommu_enforce_cache_coherency()
Date: Mon, 14 Jul 2025 12:50:25 +0800
Message-ID: <20250714045028.958850-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

First Stage and Second Stage have very different ways to deny
no-snoop. The first stage uses the PGSNP bit which is global per-PASID so
enabling requires loading new PASID entries for all the attached devices.

Second stage uses a bit per PTE, so enabling just requires telling future
maps to set the bit.

Since we now have two domain ops we can have two functions that can
directly code their required actions instead of a bunch of logic dancing
around use_first_level.

Combine domain_set_force_snooping() into the new functions since they are
the only caller.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/6-v3-dbbe6f7e7ae3+124ffe-vtd_prep_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 47 +++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b7b1a3d2cbfc..95619640b027 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3643,44 +3643,41 @@ static bool domain_support_force_snooping(struct dmar_domain *domain)
 	return support;
 }
 
-static void domain_set_force_snooping(struct dmar_domain *domain)
+static bool intel_iommu_enforce_cache_coherency_fs(struct iommu_domain *domain)
 {
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct device_domain_info *info;
 
-	assert_spin_locked(&domain->lock);
-	/*
-	 * Second level page table supports per-PTE snoop control. The
-	 * iommu_map() interface will handle this by setting SNP bit.
-	 */
-	if (!domain->use_first_level) {
-		domain->set_pte_snp = true;
-		return;
-	}
+	guard(spinlock_irqsave)(&dmar_domain->lock);
 
-	list_for_each_entry(info, &domain->devices, link)
+	if (dmar_domain->force_snooping)
+		return true;
+
+	if (!domain_support_force_snooping(dmar_domain))
+		return false;
+
+	dmar_domain->force_snooping = true;
+	list_for_each_entry(info, &dmar_domain->devices, link)
 		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
 						     IOMMU_NO_PASID);
+	return true;
 }
 
-static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
+static bool intel_iommu_enforce_cache_coherency_ss(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long flags;
 
-	if (dmar_domain->force_snooping)
-		return true;
-
-	spin_lock_irqsave(&dmar_domain->lock, flags);
+	guard(spinlock_irqsave)(&dmar_domain->lock);
 	if (!domain_support_force_snooping(dmar_domain) ||
-	    (!dmar_domain->use_first_level && dmar_domain->has_mappings)) {
-		spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	    dmar_domain->has_mappings)
 		return false;
-	}
 
-	domain_set_force_snooping(dmar_domain);
+	/*
+	 * Second level page table supports per-PTE snoop control. The
+	 * iommu_map() interface will handle this by setting SNP bit.
+	 */
+	dmar_domain->set_pte_snp = true;
 	dmar_domain->force_snooping = true;
-	spin_unlock_irqrestore(&dmar_domain->lock, flags);
-
 	return true;
 }
 
@@ -4407,7 +4404,7 @@ const struct iommu_domain_ops intel_fs_paging_domain_ops = {
 	.iotlb_sync = intel_iommu_tlb_sync,
 	.iova_to_phys = intel_iommu_iova_to_phys,
 	.free = intel_iommu_domain_free,
-	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency_fs,
 };
 
 const struct iommu_domain_ops intel_ss_paging_domain_ops = {
@@ -4420,7 +4417,7 @@ const struct iommu_domain_ops intel_ss_paging_domain_ops = {
 	.iotlb_sync = intel_iommu_tlb_sync,
 	.iova_to_phys = intel_iommu_iova_to_phys,
 	.free = intel_iommu_domain_free,
-	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency_ss,
 };
 
 const struct iommu_ops intel_iommu_ops = {
-- 
2.43.0



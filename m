Return-Path: <linux-kernel+bounces-729349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2051B03555
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF823B8AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B19212B05;
	Mon, 14 Jul 2025 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ny920KeH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0EB20A5F5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468775; cv=none; b=Gydu5IULvb++Qsqfk3H3EcjQNBOPT0l3nMG8tP2JvgBUDoT1Kx5YxRs3cNsE1791UzXuqx1uP2pVT93Hg2sJRjSfVnNB3cfDIB53W1NSSzlO61sR/aHFysbNVITWA344eJ4js54QT3CV+6NkwMoe72ofl6CP5C57v+9mKeiE790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468775; c=relaxed/simple;
	bh=w6OHcfYvWgcpddF27T2R8sT+80U+FhVKBRnhQQgCvck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdXFdS/ApJoZrfZLYOrYUi4CGcvqE7MDnIIpIR+oGm4wXU0l34oi5EeAndG4chtIdnU1bkhFCHbPzVIc1pATHjxxuEc054C+N+UR55noBjuUnti7kJEPAsLbfX109Y6AmBBzYv9Q+TaOkYKq8XKCy7T7IqcgbXQUeBXitnweol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ny920KeH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468774; x=1784004774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w6OHcfYvWgcpddF27T2R8sT+80U+FhVKBRnhQQgCvck=;
  b=Ny920KeHl6TTw90odQFPq9nDXAlT06YU4oT7vVq4ZjGjYZrIv5xFJvnB
   c3GcYOxWhWMRkfCWd1LG6S4VQr3t76niA04dYoDli/lfrHqyUNu3/wG66
   lZRD+bIY+YBEOmQMnUOxVeiA1S1609NYIWPnnhra0ZbWVHfvlDPCxzLoj
   kKOPiT2o9nLVa52s9TmmNKB5eII7+QC2GruFHG+QQyWUPog0lZW1sr5fX
   wsvfFrs3jMAykZabaL8FEwAAIVzbtBrOlhm+/HBo8YMga80PFbLk5Eg0H
   WKf/SNZH6ZQ2Plh4kDfH6sdDUSwgrOJ6EBiOpowSOwJZdfz70D4y2FuBL
   Q==;
X-CSE-ConnectionGUID: tg3LKJ+fRwywVjeOANcgSA==
X-CSE-MsgGUID: ngWk/yB5QWCtUnyeKLBP0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765045"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765045"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:52 -0700
X-CSE-ConnectionGUID: n4Z9TJjUSCinaLmyOmNjpg==
X-CSE-MsgGUID: OH7tv5bvQ62+zZEO63pAYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166159"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:52 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] iommu/vt-d: Fold domain_exit() into intel_iommu_domain_free()
Date: Mon, 14 Jul 2025 12:50:21 +0800
Message-ID: <20250714045028.958850-5-baolu.lu@linux.intel.com>
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

It has only one caller, no need for two functions.

Correct the WARN_ON() error handling to leak the entire page table if the
HW is still referencing it so we don't UAF during WARN_ON recovery.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/2-v3-dbbe6f7e7ae3+124ffe-vtd_prep_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 38 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2e5e682a41..5c798f30dbc4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1396,23 +1396,6 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	}
 }
 
-static void domain_exit(struct dmar_domain *domain)
-{
-	if (domain->pgd) {
-		struct iommu_pages_list freelist =
-			IOMMU_PAGES_LIST_INIT(freelist);
-
-		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
-		iommu_put_pages_list(&freelist);
-	}
-
-	if (WARN_ON(!list_empty(&domain->devices)))
-		return;
-
-	kfree(domain->qi_batch);
-	kfree(domain);
-}
-
 /*
  * For kdump cases, old valid entries may be cached due to the
  * in-flight DMA and copied pgtable, but there is no unmapping
@@ -3406,9 +3389,24 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 
-	WARN_ON(dmar_domain->nested_parent &&
-		!list_empty(&dmar_domain->s1_domains));
-	domain_exit(dmar_domain);
+	if (WARN_ON(dmar_domain->nested_parent &&
+		    !list_empty(&dmar_domain->s1_domains)))
+		return;
+
+	if (WARN_ON(!list_empty(&dmar_domain->devices)))
+		return;
+
+	if (dmar_domain->pgd) {
+		struct iommu_pages_list freelist =
+			IOMMU_PAGES_LIST_INIT(freelist);
+
+		domain_unmap(dmar_domain, 0, DOMAIN_MAX_PFN(dmar_domain->gaw),
+			     &freelist);
+		iommu_put_pages_list(&freelist);
+	}
+
+	kfree(dmar_domain->qi_batch);
+	kfree(dmar_domain);
 }
 
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
-- 
2.43.0



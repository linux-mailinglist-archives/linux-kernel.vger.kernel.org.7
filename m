Return-Path: <linux-kernel+bounces-729354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4405AB0355A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAAF17845E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08D5223DCF;
	Mon, 14 Jul 2025 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nO/Jbhz0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2622259E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468784; cv=none; b=Qo4n0bfDfnvkXDN2jJfaBrJ7tFGVbZnGwIk5zXpZKqQuG1sm79NYG1JASRXg7UdnNrp9aMMalmNRM2WMrMobkXCZR7/ZiiWPmUMCDA+ib8/II9k2A65PZPeJQWzc586/dP75Taj1yqn6wAbg2JKgJ0VURqIuVSwP6sF8R78r3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468784; c=relaxed/simple;
	bh=21iTm4okT/mj4EyVviTYK024U2GXvJIK9ISDdy7bclo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKLAlA4az7mD8bjOBj+9OrYuX+6hLcPDwvrK7jSOxmnWfFQbqnZfyORtQhzP9xU9GiUo+0wdS9RfIWYdbL+UpP4SZdMN9b4bBhkc2dU3gKFpy1CiIerqvp7tvOZcwz26a7KuA0E7Nq/0zNZpTOvBD3lIBYw3Jj80D6/X3h3amio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nO/Jbhz0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468782; x=1784004782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=21iTm4okT/mj4EyVviTYK024U2GXvJIK9ISDdy7bclo=;
  b=nO/Jbhz0evL0enljpaR+w9ko+I02yKbYgieuS0Gs+y3C/eH5XL85rxPx
   I2xiMXeUmIsXjVZlFBgu+O/r+UUxa4RHxNTmEiFATFmtwwR8D9ZkH1oLa
   0dj+DAw32OZlWYRq1PO9Jg5yDXb59fYsYqntS7zc/uWTbtIbPxRjB87Jk
   MdZPNVZicQ/KFBEzT0DqQ/p/NF4/84wBai0Aqodf0WbfTrepS1vZU1gDt
   p37azgZx7R4ADQYinovFT1mRUbioYzsas2KBcBk319hrpKQiqvKw8f5dC
   SubSzexrsPubLvOMMVFG9pTwSWOx1bdElLBeuy2otaTIfaTSldE4eItM4
   g==;
X-CSE-ConnectionGUID: aZXau4JYSk2uYspIkLSqNQ==
X-CSE-MsgGUID: RExxSPy5QwqtyxvdOq7PTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765081"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765081"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:53:02 -0700
X-CSE-ConnectionGUID: Oote/yaxTva9hxmCI4etyw==
X-CSE-MsgGUID: 1LqInSeyTmeEFhdBMZNLpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166210"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:59 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] iommu/vt-d: Split paging_domain_compatible()
Date: Mon, 14 Jul 2025 12:50:26 +0800
Message-ID: <20250714045028.958850-10-baolu.lu@linux.intel.com>
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

Make First/Second stage specific functions that follow the same pattern in
intel_iommu_domain_alloc_first/second_stage() for computing
EOPNOTSUPP. This makes the code easier to understand as if we couldn't
create a domain with the parameters for this IOMMU instance then we
certainly are not compatible with it.

Check superpage support directly against the per-stage cap bits and the
pgsize_bitmap.

Add a note that the force_snooping is read without locking. The locking
needs to cover the compatible check and the add of the device to the list.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/7-v3-dbbe6f7e7ae3+124ffe-vtd_prep_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 66 ++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 95619640b027..ddb981ad0e19 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3431,33 +3431,75 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 	kfree(dmar_domain);
 }
 
+static int paging_domain_compatible_first_stage(struct dmar_domain *dmar_domain,
+						struct intel_iommu *iommu)
+{
+	if (WARN_ON(dmar_domain->domain.dirty_ops ||
+		    dmar_domain->nested_parent))
+		return -EINVAL;
+
+	/* Only SL is available in legacy mode */
+	if (!sm_supported(iommu) || !ecap_flts(iommu->ecap))
+		return -EINVAL;
+
+	/* Same page size support */
+	if (!cap_fl1gp_support(iommu->cap) &&
+	    (dmar_domain->domain.pgsize_bitmap & SZ_1G))
+		return -EINVAL;
+	return 0;
+}
+
+static int
+paging_domain_compatible_second_stage(struct dmar_domain *dmar_domain,
+				      struct intel_iommu *iommu)
+{
+	unsigned int sslps = cap_super_page_val(iommu->cap);
+
+	if (dmar_domain->domain.dirty_ops && !ssads_supported(iommu))
+		return -EINVAL;
+	if (dmar_domain->nested_parent && !nested_supported(iommu))
+		return -EINVAL;
+
+	/* Legacy mode always supports second stage */
+	if (sm_supported(iommu) && !ecap_slts(iommu->ecap))
+		return -EINVAL;
+
+	/* Same page size support */
+	if (!(sslps & BIT(0)) && (dmar_domain->domain.pgsize_bitmap & SZ_2M))
+		return -EINVAL;
+	if (!(sslps & BIT(1)) && (dmar_domain->domain.pgsize_bitmap & SZ_1G))
+		return -EINVAL;
+	return 0;
+}
+
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu = info->iommu;
+	int ret = -EINVAL;
 	int addr_width;
 
-	if (WARN_ON_ONCE(!(domain->type & __IOMMU_DOMAIN_PAGING)))
-		return -EPERM;
+	if (intel_domain_is_fs_paging(dmar_domain))
+		ret = paging_domain_compatible_first_stage(dmar_domain, iommu);
+	else if (intel_domain_is_ss_paging(dmar_domain))
+		ret = paging_domain_compatible_second_stage(dmar_domain, iommu);
+	else if (WARN_ON(true))
+		ret = -EINVAL;
+	if (ret)
+		return ret;
 
+	/*
+	 * FIXME this is locked wrong, it needs to be under the
+	 * dmar_domain->lock
+	 */
 	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
 		return -EINVAL;
 
-	if (domain->dirty_ops && !ssads_supported(iommu))
-		return -EINVAL;
-
 	if (dmar_domain->iommu_coherency !=
 			iommu_paging_structure_coherency(iommu))
 		return -EINVAL;
 
-	if (dmar_domain->iommu_superpage !=
-			iommu_superpage_capability(iommu, dmar_domain->use_first_level))
-		return -EINVAL;
-
-	if (dmar_domain->use_first_level &&
-	    (!sm_supported(iommu) || !ecap_flts(iommu->ecap)))
-		return -EINVAL;
 
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
-- 
2.43.0



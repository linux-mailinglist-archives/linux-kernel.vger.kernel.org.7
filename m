Return-Path: <linux-kernel+bounces-707654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB6AEC67F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9ED71BC42FE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59398246348;
	Sat, 28 Jun 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OenCAe3j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322D238D54
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751105178; cv=none; b=pQ07s0p0HGVGKUEbieVGpUf+qnIAHu5e/1M32u1reHxQat3O7DxP3cDQQt2zCojNkGjWYsMtqHfSF02ut5SqW4lEPDLZoBkm7gRftCnuxh3DM/vv/KH94gZv1cG9pdVV9hCNZBUYp0/9fFssLGIPPI4LAswWDrWgoSrjMzq8Nag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751105178; c=relaxed/simple;
	bh=3l8UFV9x79Upw/9RrC4Qr9JaEAAmL3UA6/CITQKquCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDI87OWOCMLiHd98Ow1X+9XJNLyjXzwEr53ObucyQmrX2zZRFpQvOavEdFxwDgKxMAQFxQ31j8Y4/OGNMZGTLbBCAP1j8RPJPyrxU2QXW4qp/RaurA+dYGa5X+kiavdPS82wshp/LIjwd0yZv5iXHfiljaLXnTidzkuj6t2Ukng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OenCAe3j; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751105177; x=1782641177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3l8UFV9x79Upw/9RrC4Qr9JaEAAmL3UA6/CITQKquCY=;
  b=OenCAe3jO0X9LMPbvqnpPVNp1lThMeZNt1Z327juUVY/2TgVhNQfFdqu
   J8x/QwHDU85UeVLAXpHBaoSnSbWVeL3fW3g27M9TVKrx6txI/+5uythg8
   qZosoJ9BNVcXlQAnKLdBynwuk+tx7ScN08Zz3YBJu0jQjDNcXSQ7gPqqk
   dujaLt4jxqsMup/4DulcFT6oD8SehTLCigJDbt1jotAScVIjfN7d+vSPF
   TKHtXBRsIDrzL8F6y+bQDCnW8CqKyx68V2wGiO0I4iAU2TgnWD2E8mUAG
   Npo/JNOQZWnsGnBEqvR04aazem7AvtmFHYV/GyQ2DHLxg2w0txeKEdR2s
   w==;
X-CSE-ConnectionGUID: 8TrOeXr4TYOx1wyIVoAr7Q==
X-CSE-MsgGUID: CfMA+zHQS7GJR0fx2SxW5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="64002258"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="64002258"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 03:06:16 -0700
X-CSE-ConnectionGUID: JsBDiP6OR3Gn6ocJpP8ASQ==
X-CSE-MsgGUID: gBvViQiIQ+q7SMlZBGIjWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="157551290"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa004.jf.intel.com with ESMTP; 28 Jun 2025 03:06:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Assign devtlb cache tag on ATS enablement
Date: Sat, 28 Jun 2025 18:03:51 +0800
Message-ID: <20250628100351.3198955-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250628100351.3198955-1-baolu.lu@linux.intel.com>
References: <20250628100351.3198955-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <4f1492efb495> ("iommu/vt-d: Revert ATS timing change to fix boot
failure") placed the enabling of ATS in the probe_finalize callback. This
occurs after the default domain attachment, which is when the ATS cache
tag is assigned. Consequently, the device TLB cache tag is missed when the
domain is attached, leading to the device TLB not being invalidated in the
iommu_unmap paths.

Fix this by assigning the CACHE_TAG_DEVTLB cache tag when ATS is enabled.

Fixes: 4f1492efb495 ("iommu/vt-d: Revert ATS timing change to fix boot failure")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20250625050135.3129955-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/cache.c |  5 ++---
 drivers/iommu/intel/iommu.c | 11 ++++++++++-
 drivers/iommu/intel/iommu.h |  2 ++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index fc35cba59145..47692cbfaabd 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -40,9 +40,8 @@ static bool cache_tage_match(struct cache_tag *tag, u16 domain_id,
 }
 
 /* Assign a cache tag with specified type to domain. */
-static int cache_tag_assign(struct dmar_domain *domain, u16 did,
-			    struct device *dev, ioasid_t pasid,
-			    enum cache_tag_type type)
+int cache_tag_assign(struct dmar_domain *domain, u16 did, struct device *dev,
+		     ioasid_t pasid, enum cache_tag_type type)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7aa3932251b2..148b944143b8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3780,8 +3780,17 @@ static void intel_iommu_probe_finalize(struct device *dev)
 	    !pci_enable_pasid(to_pci_dev(dev), info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev))
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
 		iommu_enable_pci_ats(info);
+		/* Assign a DEVTLB cache tag to the default domain. */
+		if (info->ats_enabled && info->domain) {
+			u16 did = domain_id_iommu(info->domain, iommu);
+
+			if (cache_tag_assign(info->domain, did, dev,
+					     IOMMU_NO_PASID, CACHE_TAG_DEVTLB))
+				iommu_disable_pci_ats(info);
+		}
+	}
 	iommu_enable_pci_pri(info);
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3ddbcc603de2..2d1afab5eedc 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1289,6 +1289,8 @@ struct cache_tag {
 	unsigned int users;
 };
 
+int cache_tag_assign(struct dmar_domain *domain, u16 did, struct device *dev,
+		     ioasid_t pasid, enum cache_tag_type type);
 int cache_tag_assign_domain(struct dmar_domain *domain,
 			    struct device *dev, ioasid_t pasid);
 void cache_tag_unassign_domain(struct dmar_domain *domain,
-- 
2.43.0



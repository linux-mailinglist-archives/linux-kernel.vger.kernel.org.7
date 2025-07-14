Return-Path: <linux-kernel+bounces-729355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AA2B0355B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B61177F56
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7A2248B5;
	Mon, 14 Jul 2025 04:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHJd7sXQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E11F8BD6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468785; cv=none; b=D6trnSWpR+BcowVE2wwdYeZtMDm/tXQBbx2eYz7Pp68v2bG/+fgAjypphx8xvt412ZMotxOp5MOXzJdqxokgwUAnDLmA9YclrENiq6Wu3sFL7Spp/NN6HHPDTN0uP+B0mQZZbh+LV1Jvx0l7JO/+gpJfivWlJ55xMvmvdgkKjw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468785; c=relaxed/simple;
	bh=DzEkyFZQ28u7x7SePqyWjjDO5a/QUmvg26E6ZupBXSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvZytcpqT3O515Z6uFnm2E7sUYHq3/gpIgm2l4rAjp6iGywcCs/7B+NRQxBNq2n3dAmnkB1kgq5SOLtnFIS/gvM01WJjyPcbMZ0hQQ1zOOZdFQsdxyzmV4wIO6yV4WkFUx+WEy7BwXfhgkPven133JywcIaYrdVWjrPScnLP/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHJd7sXQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468784; x=1784004784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DzEkyFZQ28u7x7SePqyWjjDO5a/QUmvg26E6ZupBXSw=;
  b=mHJd7sXQl3Am/BMcrvkXyJq0sp2HLZQMl3uKTGsyPxliToh74KOVTcCK
   5fkBf6AIVO4bYE+eygBnURstXhJPs6v4U+DtySt5eiGwe68g2J1mku/8Q
   EsUEY/iC/FajCZApU7txLhLjc/hpQ7O+WH81yQhF1NLbFnSe3P8UGTTvl
   RW1kp/nQre++pn7meJ3ivK0XhbJPMQxEITrIWhnerrK2Z6vvFYcXzBvE7
   kCW69XwLO2It6Jd4HF89D+GB+wAo/IPkmz9NCMo0v9ZD+cCnXl6TArSNL
   m9ZCnIib5mdp+VoVzlYbLi/PTGC4s2/+fgqnjJOmIIM8GD8iffXYodOTe
   g==;
X-CSE-ConnectionGUID: exOHJg+yShqma7fxNG/3aQ==
X-CSE-MsgGUID: YKROnb5JQL+T1fYSfCSJFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765085"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765085"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:53:03 -0700
X-CSE-ConnectionGUID: Lt7pOygmSAur0rtlYmbjuQ==
X-CSE-MsgGUID: 1wMDH8jnTxe1+aIhgi0kaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166219"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:53:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] iommu/vt-d: Fix missing PASID in dev TLB flush with cache_tag_flush_all
Date: Mon, 14 Jul 2025 12:50:27 +0800
Message-ID: <20250714045028.958850-11-baolu.lu@linux.intel.com>
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

From: Ethan Milon <ethan.milon@eviden.com>

The function cache_tag_flush_all() was originally implemented with
incorrect device TLB invalidation logic that does not handle PASID, in
commit c4d27ffaa8eb ("iommu/vt-d: Add cache tag invalidation helpers")

This causes regressions where full address space TLB invalidations occur
with a PASID attached, such as during transparent hugepage unmapping in
SVA configurations or when calling iommu_flush_iotlb_all(). In these
cases, the device receives a TLB invalidation that lacks PASID.

This incorrect logic was later extracted into
cache_tag_flush_devtlb_all(), in commit 3297d047cd7f ("iommu/vt-d:
Refactor IOTLB and Dev-IOTLB flush for batching")

The fix replaces the call to cache_tag_flush_devtlb_all() with
cache_tag_flush_devtlb_psi(), which properly handles PASID.

Fixes: 4f609dbff51b ("iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs")
Fixes: 4e589a53685c ("iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all")
Signed-off-by: Ethan Milon <ethan.milon@eviden.com>
Link: https://lore.kernel.org/r/20250708214821.30967-1-ethan.milon@eviden.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cache.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 876630e10849..071f78e67fcb 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -422,22 +422,6 @@ static void cache_tag_flush_devtlb_psi(struct dmar_domain *domain, struct cache_
 					     domain->qi_batch);
 }
 
-static void cache_tag_flush_devtlb_all(struct dmar_domain *domain, struct cache_tag *tag)
-{
-	struct intel_iommu *iommu = tag->iommu;
-	struct device_domain_info *info;
-	u16 sid;
-
-	info = dev_iommu_priv_get(tag->dev);
-	sid = PCI_DEVID(info->bus, info->devfn);
-
-	qi_batch_add_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
-			       MAX_AGAW_PFN_WIDTH, domain->qi_batch);
-	if (info->dtlb_extra_inval)
-		qi_batch_add_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
-				       MAX_AGAW_PFN_WIDTH, domain->qi_batch);
-}
-
 /*
  * Invalidates a range of IOVA from @start (inclusive) to @end (inclusive)
  * when the memory mappings in the target domain have been modified.
@@ -508,7 +492,7 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 			break;
 		case CACHE_TAG_DEVTLB:
 		case CACHE_TAG_NESTING_DEVTLB:
-			cache_tag_flush_devtlb_all(domain, tag);
+			cache_tag_flush_devtlb_psi(domain, tag, 0, MAX_AGAW_PFN_WIDTH);
 			break;
 		}
 
-- 
2.43.0



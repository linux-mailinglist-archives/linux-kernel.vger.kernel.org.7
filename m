Return-Path: <linux-kernel+bounces-729347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485CBB03553
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC033B4A14
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F841FF61E;
	Mon, 14 Jul 2025 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKuTArE3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC21F4624
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468771; cv=none; b=T1n/OI8+pUak69J4iwJYGHxkKJSf1uECyjjldHZMoGqHQdt/OAKFX77aP94+zDW4yAqvk2a6Xb2S/0yOliGKlHgRhLOPjfjf84l4ELPB9l0J09iiw5Hgo9UaHAUgPKJfKBda47wHBh4uJUNbrBV6BnXrRVUvDuJKlzCkjXnGVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468771; c=relaxed/simple;
	bh=DwUhOZ8kbcjWYIdLnos9Z/vLhWxZdh9oLPf3cntU9Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4v857vNpzsaGZaAfQF6bbtiSJgIozOMRdm4OxIfmn50dGcjKKrPoLJbIo+Jp00gJu+XVvb8LKzsJBAjsXTZ5XYprfltkrBNpUnCb2gtjEShfXCPeZEG57hyOgYslzNP6VuZB4MwMyeS4wbezitbvGc6Js9yMWUYvgaQ43mZcaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKuTArE3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468769; x=1784004769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwUhOZ8kbcjWYIdLnos9Z/vLhWxZdh9oLPf3cntU9Sk=;
  b=jKuTArE3xyT/gNgBLuumRyromW4QYpf9uG61l5YyNhwp/DWLi5fDOnO2
   1SznpihD/DMN4Qy8QqY1C6v8Lb+uio/BtXpbR+zSsCwS0lDY3CnaoTpoB
   2ifqoTIs/MoIIqGetwjj/IjSSWNWKEeBXi+NTo97J/QSXQ+3tAET6QPIa
   hpjKNosAvWxRBf5QnvWQDFV6yx99V6RJaIPSIBnQoRpzTuQFvdw5bK6pX
   mjyAtPeAEp85hUCyx0e4ns0zUVPOn4+p97+Jdh5rp5PyiZnIMLA4Tr0xm
   X4Up378M2M/grIzWTyxFVHX1MdNDjynlsAG/GIXcLzUz8iRsPmO/lKD6p
   A==;
X-CSE-ConnectionGUID: yjcwdAn1TEq6KE2RFeCBIQ==
X-CSE-MsgGUID: 21I0S2p+QMOCeyQK9URJrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765038"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765038"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:49 -0700
X-CSE-ConnectionGUID: PKVbN8MVQQK2OS1dUDJbXQ==
X-CSE-MsgGUID: 7dT/4QJATLiy2tFd5rfK7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166146"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] iommu/vt-d: Optimize iotlb_sync_map for non-caching/non-RWBF modes
Date: Mon, 14 Jul 2025 12:50:19 +0800
Message-ID: <20250714045028.958850-3-baolu.lu@linux.intel.com>
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

The iotlb_sync_map iommu ops allows drivers to perform necessary cache
flushes when new mappings are established. For the Intel iommu driver,
this callback specifically serves two purposes:

- To flush caches when a second-stage page table is attached to a device
  whose iommu is operating in caching mode (CAP_REG.CM==1).
- To explicitly flush internal write buffers to ensure updates to memory-
  resident remapping structures are visible to hardware (CAP_REG.RWBF==1).

However, in scenarios where neither caching mode nor the RWBF flag is
active, the cache_tag_flush_range_np() helper, which is called in the
iotlb_sync_map path, effectively becomes a no-op.

Despite being a no-op, cache_tag_flush_range_np() involves iterating
through all cache tags of the iommu's attached to the domain, protected
by a spinlock. This unnecessary execution path introduces overhead,
leading to a measurable I/O performance regression. On systems with NVMes
under the same bridge, performance was observed to drop from approximately
~6150 MiB/s down to ~4985 MiB/s.

Introduce a flag in the dmar_domain structure. This flag will only be set
when iotlb_sync_map is required (i.e., when CM or RWBF is set). The
cache_tag_flush_range_np() is called only for domains where this flag is
set. This flag, once set, is immutable, given that there won't be mixed
configurations in real-world scenarios where some IOMMUs in a system
operate in caching mode while others do not. Theoretically, the
immutability of this flag does not impact functionality.

Reported-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2115738
Link: https://lore.kernel.org/r/20250701171154.52435-1-ioanna-maria.alifieraki@canonical.com
Fixes: 129dab6e1286 ("iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20250703031545.3378602-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 19 ++++++++++++++++++-
 drivers/iommu/intel/iommu.h |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 148b944143b8..b23efb70b52c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1796,6 +1796,18 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 					  (pgd_t *)pgd, flags, old);
 }
 
+static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
+				       struct intel_iommu *iommu)
+{
+	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
+		return true;
+
+	if (rwbf_quirk || cap_rwbf(iommu->cap))
+		return true;
+
+	return false;
+}
+
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
@@ -1833,6 +1845,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
+	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);
+
 	return 0;
 
 out_block_translation:
@@ -3954,7 +3968,10 @@ static bool risky_device(struct pci_dev *pdev)
 static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				      unsigned long iova, size_t size)
 {
-	cache_tag_flush_range_np(to_dmar_domain(domain), iova, iova + size - 1);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	if (dmar_domain->iotlb_sync_map)
+		cache_tag_flush_range_np(dmar_domain, iova, iova + size - 1);
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 2d1afab5eedc..61f42802fe9e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -614,6 +614,9 @@ struct dmar_domain {
 	u8 has_mappings:1;		/* Has mappings configured through
 					 * iommu_map() interface.
 					 */
+	u8 iotlb_sync_map:1;		/* Need to flush IOTLB cache or write
+					 * buffer when creating mappings.
+					 */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
-- 
2.43.0



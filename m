Return-Path: <linux-kernel+bounces-655132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E28ABD147
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 10:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F132E7A383B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4280E21323C;
	Tue, 20 May 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWsbV1Z7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B0211A16
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747728089; cv=none; b=Dt5DF4n4bqNk+VJ3uUIlxGEkLEoJnGS2cJlJepBzh5QIcZOSNrd3PsPVnJorpsHiQ3UdYas31fs/erKz+xeTLt+sk34avu4LfvEkOX8uLalkpJNYj1CWSldNdgfBFnGLt2687dbaHQptFHkIZecpuARZwnOqgh1VhwvEi6Hmkvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747728089; c=relaxed/simple;
	bh=Kp8AEk3j4jfkGSU09VIZZO5bhdolbL+41gXg15FaQE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Myy+CkvBinAKRMpkJQnqrrNQB9DGZldxPtPsWXhtkvHT7Ue4yZKHAz0RgKos6Jc/P302RqXnsoJVvdPoh/sBQ92Bj4u5C9+LgxvQG5MrXTU8XgCR+5qOs/Nm1ZwwfxoFhvULBriDdbRm0Ub4WCV6RGfC/HDuv2WgeqGXX3nDfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWsbV1Z7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747728087; x=1779264087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kp8AEk3j4jfkGSU09VIZZO5bhdolbL+41gXg15FaQE4=;
  b=aWsbV1Z7fETNh2h3Q8NCme5+b7+YI76hcf2fSOeb618ZM6yrfrxcCktl
   4DH7dmUdl1k45qGM6NPW9D4SAmmV7bpI2/G/d6k2lIxw/fJSY5h3NQGdP
   jkPePwjA1iilZlXWWGD7Uc+UeWaZfDBTeqNjsMU3fM4xk/UJmp2AlQYvK
   9pqduyTp+e2AkvxRvHRf8KtDV916q77A7DInTXOzzzjXJIo+qWAE0RPSV
   Jp7BHumsHYgCZiH52XolePgDQ3VIBy9bZ5uuVJq4buCHG0Oo4530reQb8
   uj9TrW6aKxLqAEWhPA2TWulDB8ho6ubghKR8fzZa9Hl5HkwmHTkkZsJgn
   g==;
X-CSE-ConnectionGUID: EJGr/4+hSumrJ12WKOoZxQ==
X-CSE-MsgGUID: sJO8ReOWQcaTjmZaXHPPVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48763139"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48763139"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 01:01:26 -0700
X-CSE-ConnectionGUID: 7MiVnuz0RKaN0LFPjnNcBw==
X-CSE-MsgGUID: D6e1aTm4RoyBWU98px0cWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144474229"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa005.fm.intel.com with ESMTP; 20 May 2025 01:01:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Restore context entry setup order for aliased devices
Date: Tue, 20 May 2025 15:58:49 +0800
Message-ID: <20250520075849.755012-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520075849.755012-1-baolu.lu@linux.intel.com>
References: <20250520075849.755012-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
changed the context entry setup during domain attachment from a
set-and-check policy to a clear-and-reset approach. This inadvertently
introduced a regression affecting PCI aliased devices behind PCIe-to-PCI
bridges.

Specifically, keyboard and touchpad stopped working on several Apple
Macbooks with below messages:

 kernel: platform pxa2xx-spi.3: Adding to iommu group 20
 kernel: input: Apple SPI Keyboard as
 /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.3/spi_master/spi2/spi-APP000D:00/input/input0
 kernel: DMAR: DRHD: handling fault status reg 3
 kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
 0xffffa000 [fault reason 0x06] PTE Read access is not set
 kernel: DMAR: DRHD: handling fault status reg 3
 kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
 0xffffa000 [fault reason 0x06] PTE Read access is not set
 kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
 kernel: DMAR: DRHD: handling fault status reg 3
 kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
 0xffffa000 [fault reason 0x06] PTE Read access is not set
 kernel: DMAR: DRHD: handling fault status reg 3
 kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00

Fix this by restoring the previous context setup order.

Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
Closes: https://lore.kernel.org/all/4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch/
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20250514060523.2862195-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c  | 11 +++++++++++
 drivers/iommu/intel/iommu.h  |  1 +
 drivers/iommu/intel/nested.c |  4 ++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 49530d5d8c85..7aa3932251b2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1809,6 +1809,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		return ret;
 
 	info->domain = domain;
+	info->domain_attached = true;
 	spin_lock_irqsave(&domain->lock, flags);
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -3206,6 +3207,10 @@ void device_block_translation(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 
+	/* Device in DMA blocking state. Noting to do. */
+	if (!info->domain_attached)
+		return;
+
 	if (info->domain)
 		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 
@@ -3217,6 +3222,9 @@ void device_block_translation(struct device *dev)
 			domain_context_clear(info);
 	}
 
+	/* Device now in DMA blocking state. */
+	info->domain_attached = false;
+
 	if (!info->domain)
 		return;
 
@@ -4302,6 +4310,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 	else
 		ret = device_setup_pass_through(dev);
 
+	if (!ret)
+		info->domain_attached = true;
+
 	return ret;
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index cbfb8bb4c94a..3ddbcc603de2 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -774,6 +774,7 @@ struct device_domain_info {
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
 	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
+	u8 domain_attached:1;	/* Device has domain attached */
 	u8 ats_qdep;
 	unsigned int iopf_refcount;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index d2a94025d0a0..fc312f649f9e 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -27,8 +27,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret = 0;
 
-	if (info->domain)
-		device_block_translation(dev);
+	device_block_translation(dev);
 
 	if (iommu->agaw < dmar_domain->s2_domain->agaw) {
 		dev_err_ratelimited(dev, "Adjusted guest address width not compatible\n");
@@ -66,6 +65,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 		goto disable_iopf;
 
 	info->domain = dmar_domain;
+	info->domain_attached = true;
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_add(&info->link, &dmar_domain->devices);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
-- 
2.43.0



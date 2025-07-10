Return-Path: <linux-kernel+bounces-725790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21011B003F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009B816A7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004B426E6F0;
	Thu, 10 Jul 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qwe+8sMP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F7626D4CF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154961; cv=none; b=U8c/fCFWKOKk628gclHHLcly+hH6d82Bfxs18vRoXU35tWCiFjvtKIN/oYte21nkSOFohcba08KongbGtJtMa1PYpeUxcwzxc392nW6rRaAXr5k+gOtRV+86pQclnx0sqPtkgKFT0fqfjCaoCC0HOiQE1eRARPDPRxx2wAJ08gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154961; c=relaxed/simple;
	bh=++9QqGL5xGzI1k7HkFDsKPdBKvQU6+NJOIQG63S2Sqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9Z4uP//V61RHiE/CClG4JSvZYlEznK88l9GPh9UIZEymeeeooRw8k831icZ7rbC3NhC7Dv3hR4KoD4xIjp5aTUgS9HjrRcYnM7P0PtPaE+MAfTSrB14cT1ap3OwELDdw75tMsA7EnmdhN3Xd2UiA1ArxihUMzVgvq6r6M0hUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qwe+8sMP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752154960; x=1783690960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=++9QqGL5xGzI1k7HkFDsKPdBKvQU6+NJOIQG63S2Sqo=;
  b=Qwe+8sMP3CWCdwCY4WynXIPXLxRUqoPy38GRDdLWYow1wX7jf2vxn/py
   1cFAIzWJIkmnO34jsKUl5O35pLy6GZQook6WL6Y1JLCvjiVP0kiguUEJh
   ahSUOmNvbM1BeAXdCmrrWnQywjHaRj+rkugYTXDp7jZnJbPGo3jXwKASX
   XQM+W679ZSH6nizLXF658MYg4qcUYl48LYhbmzCdD/2IKLvFP0JFRbiSf
   FIs24/Snvi2zN+n/bCnGxYiNsymFiPF2dbA+ZnHCWfqsoEm/p+MNgNNnC
   D0gHXNb3ml7eQnEo3/cw6cksPLHLy7eHbuiuAe4phcaJDy+9xAPQetZmV
   Q==;
X-CSE-ConnectionGUID: SVJqdOjqQD+wAH5+Tu+y0g==
X-CSE-MsgGUID: gnA4CczgTEG/oXHaJQ6LIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65787682"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65787682"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:42:40 -0700
X-CSE-ConnectionGUID: oIbFHR2uQPymFCkL1rI3GA==
X-CSE-MsgGUID: Gw5oI0mHS3yueTKJYuuNCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156809436"
Received: from gnrd8.igk.intel.com ([10.123.232.137])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2025 06:42:37 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] iommu: Add rid_notifier array to the dev_iommu structure
Date: Thu, 10 Jul 2025 13:42:13 +0000
Message-ID: <20250710134215.97840-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rid_notifier array to struct dev_iommu to facilitate
requester notification of IOMMU faults.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/iommu.c | 9 +++++++++
 include/linux/iommu.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a4b606c591da..3789c16806a1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -354,6 +354,7 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 		return NULL;
 
 	mutex_init(&param->lock);
+	xa_init(&param->rid_notifiers);
 	dev->iommu = param;
 	return param;
 }
@@ -361,8 +362,16 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 void dev_iommu_free(struct device *dev)
 {
 	struct dev_iommu *param = dev->iommu;
+	struct rid_notifier *notifier;
+	unsigned long rid;
 
 	dev->iommu = NULL;
+
+	xa_for_each(&param->rid_notifiers, rid, notifier)
+		kfree(notifier);
+
+	xa_destroy(&param->rid_notifiers);
+
 	if (param->fwspec) {
 		fwnode_handle_put(param->fwspec->iommu_fwnode);
 		kfree(param->fwspec);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4ddb63a3f2cf..2062623fdf32 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -795,6 +795,8 @@ struct iommu_fault_param {
  * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
  * @require_direct: device requires IOMMU_RESV_DIRECT regions
  * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
+ * @rid_notifiers: holds pointers and data to the notifier functions for
+ *                   specific RIDs
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -810,6 +812,8 @@ struct dev_iommu {
 	u32				pci_32bit_workaround:1;
 	u32				require_direct:1;
 	u32				shadow_on_flush:1;
+
+	struct xarray			rid_notifiers;
 };
 
 int iommu_device_register(struct iommu_device *iommu,
-- 
2.43.0



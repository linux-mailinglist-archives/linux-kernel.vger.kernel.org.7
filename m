Return-Path: <linux-kernel+bounces-899809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3A0C58D04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0723BEAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EE835CB8A;
	Thu, 13 Nov 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwhG7xFZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2E35C1B6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051241; cv=none; b=gUn7V4ED4RPHZcQlVj/iXU7usFxQB6bxV8fyqFVx6nZjNE+jpyAHPTMLd8GmP68RyQAkQhobRDVciPsdPfItv0qGorkuPOTDfitmLBhy1Rr64biU7wq1qxzOgl0JnB0cvqlWpNYl/ysVKucW+WxoFKkjlc7tJWd1Y63cr7UtZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051241; c=relaxed/simple;
	bh=b6bHE2NWpx3/0Mi/dM/PxYqjKxh5deLzFeMeaeVZSeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYNVLgC+WvD0IU/1VMHUVziOpVE4baCR7dGuNUMaF8R8MIwtazrajRAy+OZn5eP1FbxwNgm2weKLN+6WhtjLow0R+mDWgHcFUBuSboqAcEeAT3bKhsuIgNWBJj5gRrfkrSfCvlxvrzUTU0qOTuyZDwRLYAFJr6cAMl1NBQr2ikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwhG7xFZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051239; x=1794587239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b6bHE2NWpx3/0Mi/dM/PxYqjKxh5deLzFeMeaeVZSeo=;
  b=GwhG7xFZFwVxDapBTAJc0MONSy0HA+cQt7iYenysl3ZMF/kmLn3B1FND
   mVAabm1ky17RDOr5fpsGWqTi65ZbX7lqjgRer15pLhxL1VAeG7LyG0Jda
   2UBOGje6spxtvIOAE9MUpo5cz/YtnuBiKYzBKrDL4Xxb/JCMXE8zu5enF
   Q69b9+XgKq4zPRTQaC4IHqO7YVD/z+A3inxbrSyDVkPrLTeXR4XeQptYD
   vlNS4kDAzBDPea/wjUIM/GU3LLKQbYyRHhQgVNSuKoFR5gVruAmw+aq76
   6mFW3+aDn5CMzC3+8ISKYDVswwcFJtZG9CaqvDU2CWvdkJIM+I8SlcQz8
   A==;
X-CSE-ConnectionGUID: Rccv7ZtRRjiM5GC5mxG3Ig==
X-CSE-MsgGUID: UeEV55Y4RRmoajG2NkccGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="82767215"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="82767215"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:16 -0800
X-CSE-ConnectionGUID: Np/szchjTiq4/Ch1EPt/Dg==
X-CSE-MsgGUID: 9n6RuKcET1SxFXRNEuApiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="190310091"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 13 Nov 2025 08:27:15 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6FF5B97; Thu, 13 Nov 2025 17:27:14 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Chong Qiao <qiaochong@loongson.cn>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v2 1/2] mfd: ls2kbmc: Fully convert to use managed resources
Date: Thu, 13 Nov 2025 17:22:50 +0100
Message-ID: <20251113162713.3143777-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251113162713.3143777-1-andriy.shevchenko@linux.intel.com>
References: <20251113162713.3143777-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mixing of managed and non-managed resources may lead to possible
use-after-free bugs. In this driver the problematic part is the device
functionality that may just have gone behind the functions back, e.g.,
when interrupt is being served. Fix this by switching to managed resources
for PCI.

Fixes: 91a3e1f5453a ("mfd: ls2kbmc: Check for devm_mfd_add_devices() failure")
Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/ls2k-bmc-core.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 5f38514fa89e..1d8be9cdb3a8 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -464,25 +464,23 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	resource_size_t base;
 	int ret;
 
-	ret = pci_enable_device(dev);
+	ret = pcim_enable_device(dev);
 	if (ret)
 		return ret;
 
 	ddata = devm_kzalloc(&dev->dev, sizeof(*ddata), GFP_KERNEL);
-	if (!ddata) {
-		ret = -ENOMEM;
-		goto disable_pci;
-	}
+	if (!ddata)
+		return -ENOMEM;
 
 	ddata->dev = &dev->dev;
 
 	ret = ls2k_bmc_init(ddata);
 	if (ret)
-		goto disable_pci;
+		return ret;
 
 	ret = ls2k_bmc_parse_mode(dev, &pd);
 	if (ret)
-		goto disable_pci;
+		return ret;
 
 	ls2k_bmc_cells[LS2K_BMC_DISPLAY].platform_data = &pd;
 	ls2k_bmc_cells[LS2K_BMC_DISPLAY].pdata_size = sizeof(pd);
@@ -490,23 +488,12 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	/* Remove conflicting efifb device */
 	ret = aperture_remove_conflicting_devices(base, SZ_4M, "simple-framebuffer");
-	if (ret) {
-		dev_err(&dev->dev, "Failed to removed firmware framebuffers: %d\n", ret);
-		goto disable_pci;
-	}
+	if (ret)
+		return dev_err_probe(&dev->dev, ret, "Failed to remove firmware framebuffers\n");
 
 	return devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
 				    ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_cells),
 				    &dev->resource[0], 0, NULL);
-
-disable_pci:
-	pci_disable_device(dev);
-	return ret;
-}
-
-static void ls2k_bmc_remove(struct pci_dev *dev)
-{
-	pci_disable_device(dev);
 }
 
 static struct pci_device_id ls2k_bmc_devices[] = {
@@ -519,7 +506,6 @@ static struct pci_driver ls2k_bmc_driver = {
 	.name = "ls2k-bmc",
 	.id_table = ls2k_bmc_devices,
 	.probe = ls2k_bmc_probe,
-	.remove = ls2k_bmc_remove,
 };
 module_pci_driver(ls2k_bmc_driver);
 
-- 
2.50.1



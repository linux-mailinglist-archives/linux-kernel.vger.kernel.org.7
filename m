Return-Path: <linux-kernel+bounces-878131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E620C1FDA8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1008E3AABED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ADA33B963;
	Thu, 30 Oct 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efjjS2Ig"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0E2E0904
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824261; cv=none; b=FUeyU/BzBm6LNlnwgdU/H2+0epfa1WW5n7XALG+ig3+4p/fgmwEymqxODgp5+T67Fd0xEtKNQEz0IzcJ1N8sCxagXWSFNg+xITbvRB95GMD8UVOPhLclzfQvVtJjBNEJfC/ElDT+Nq8W0kusZ17HJRojakwoPZ95bERDpyOurWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824261; c=relaxed/simple;
	bh=kjwK4SC2pidEH56wn9wr/J1HVaOm57Hnqtb2qsiBqko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWAheQY0ClvclBMzJbgeBbEwgKb8tBbB4FlapIjiY4mDvWAejPkJO28Hd5hUvc9pxF5XC1/KSdPo5AkXJWV8ZFSOkDmlOATDSk3nnocEUFuMf3Krg4OZfW9v6x8m6Lz9F823oFTUHYvnT2Xq5amPYX+Wh4K1vsZ71F47DgIPM+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efjjS2Ig; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761824259; x=1793360259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kjwK4SC2pidEH56wn9wr/J1HVaOm57Hnqtb2qsiBqko=;
  b=efjjS2Igmyp2xOCnWrl9GCof6q2GVhR5jEqdIx9k5+mE/L3cBxUz+Nqj
   oJyuqa84BYvTucXVpSRdlLd9QHpYmToHEAqlT2PzgS1XnOQj/4N+JeB0c
   dbP3x3fn8ta4ETyqabG4FN9/xDido2twae3h1xCUZ/7w6GlUx0fMsPBft
   eKDHYiSdkBe3/TGrAYOhMQODtxX2Uhjg0LKAkKjADDY9kdGkJhsDkI2Dg
   Oup6NZ1dnRu09qI7ex2gf0WibXBFd1LFNR0R9eVXFG4KLJv1v+2GrcH/3
   pkNKC38rsoCFNvtAbMU3+yu/I+xKJ4hbj+lYxJLQrTQtdaWhmzuIvpAII
   g==;
X-CSE-ConnectionGUID: znYRwq1ITm+b/cIGAUcZ8w==
X-CSE-MsgGUID: 5A1yWmHCSjqgM2Qp6u6Mgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75309919"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="75309919"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 04:37:38 -0700
X-CSE-ConnectionGUID: 4gFP82IDTb6eiZP6QFUWSg==
X-CSE-MsgGUID: yWVg4iOLSdSUDNDQeHuvIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186277946"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 30 Oct 2025 04:37:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B8C7F96; Thu, 30 Oct 2025 12:37:36 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Chong Qiao <qiaochong@loongson.cn>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 1/2] mfd: ls2kbmc: Fully convert to use managed resources
Date: Thu, 30 Oct 2025 12:36:33 +0100
Message-ID: <20251030113735.3741913-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251030113735.3741913-1-andriy.shevchenko@linux.intel.com>
References: <20251030113735.3741913-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mixing managed and non-managed resources lay lead to all possible
use-after-free bugs. In this driver the problematic part is the configuration
space bits that may just gone behind the functions back, e.g., when interrupt
is being served. Fix this by switching to managed resources for PCI.

Fixes: 91a3e1f5453a ("mfd: ls2kbmc: Check for devm_mfd_add_devices() failure")
Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/ls2k-bmc-core.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 69387dad6661..616ff0a28b00 100644
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
@@ -490,27 +488,12 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	/* Remove conflicting efifb device */
 	ret = aperture_remove_conflicting_devices(base, SZ_4M, "simple-framebuffer");
-	if (ret) {
-		dev_err(&dev->dev, "Failed to removed firmware framebuffers: %d\n", ret);
-		goto disable_pci;
-	}
-
-	ret = devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
-				   ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_cells),
-				   &dev->resource[0], 0, NULL);
 	if (ret)
-		goto disable_pci;
+		return dev_err_probe(&dev->dev, ret, "Failed to removed firmware framebuffers\n");
 
-	return 0;
-
-disable_pci:
-	pci_disable_device(dev);
-	return ret;
-}
-
-static void ls2k_bmc_remove(struct pci_dev *dev)
-{
-	pci_disable_device(dev);
+	return devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
+				    ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_cells),
+				    &dev->resource[0], 0, NULL);
 }
 
 static struct pci_device_id ls2k_bmc_devices[] = {
@@ -523,7 +506,6 @@ static struct pci_driver ls2k_bmc_driver = {
 	.name = "ls2k-bmc",
 	.id_table = ls2k_bmc_devices,
 	.probe = ls2k_bmc_probe,
-	.remove = ls2k_bmc_remove,
 };
 module_pci_driver(ls2k_bmc_driver);
 
-- 
2.50.1



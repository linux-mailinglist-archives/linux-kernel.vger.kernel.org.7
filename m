Return-Path: <linux-kernel+bounces-899806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DC1C59314
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2413542913
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D8635C1BA;
	Thu, 13 Nov 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjW2Ah6w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62335C194
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051239; cv=none; b=YUQcr4QPR/bLziW1VezIiisx/dw0Z5sg+ZNpow6k7ft/Af2QOKpqqiN2jvWiJz3hQlEzlHQUAvdcDPGW+mFk3VF5WZpZzpkfotzb+SGeSj9tYTEkKqCpePpkjzU6qvQLTNDK0fD6BAY/a+/6zWjz/8ryaCnK1dBMUZqIRQFR4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051239; c=relaxed/simple;
	bh=qhiVYPaTzOXWS2Ke+4CzViT4jKAP8FPtBW2bXvRa2js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIQ5/lbU5+2AYIMLNrW4f3We/Au9pR3GPUDCtiG1MmzvWVorwe2kVDR4ddJoVFkgnNyFkklj0Uco6wPdFliSxHMIRTeg8XmzYqz3U9MMh8RpIjAH1ODnz40mpJZZzqGeoZhwdc+LRpuv4YH1yAUsVjXJBNI1SYkF1l9/6WVwD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjW2Ah6w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051237; x=1794587237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qhiVYPaTzOXWS2Ke+4CzViT4jKAP8FPtBW2bXvRa2js=;
  b=WjW2Ah6w16HA9CxVo1LL/5qiQkjiOd0su2thIJA2hSsDHVcMEAeCsKMO
   i6NYR8sKnXs5rsiLdATUPUmPGivG/HeOsL6GRBQlHTncIasOL80n7T6+e
   R4f0Fq4zJcnwr6avx6TW/dNqefjI+tN9EI3CsUmqzhWjEag+wYJyIRhmj
   Ij9aoq35dkQaMiJjoiHFVqK7dp4PAfliar8euB9aTq6YmxgiUrK4fKcXo
   gjSy1F4e9YNFzkk+ZtukNGOVTkaT2TD7D+Mr6CkTWqo25exW3M4THFsFu
   LAR8KbPIvxKLf3zBO5AtUsMtugOjiPCs48yQD7s6bwbGacv0c2sGNVvsg
   Q==;
X-CSE-ConnectionGUID: +CALNUmGQEKxvpjZ3LI5/A==
X-CSE-MsgGUID: 5hOX2huHRoKjwzDjFsIEhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="82767218"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="82767218"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:16 -0800
X-CSE-ConnectionGUID: 5vY+y9SeSgSeItH9jNmYqA==
X-CSE-MsgGUID: Camf+tjARJux6HttU6bkOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="190310092"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 13 Nov 2025 08:27:15 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7413398; Thu, 13 Nov 2025 17:27:14 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Chong Qiao <qiaochong@loongson.cn>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v2 2/2] mfd: ls2kbmc: Use PCI API instead of direct accesses
Date: Thu, 13 Nov 2025 17:22:51 +0100
Message-ID: <20251113162713.3143777-3-andriy.shevchenko@linux.intel.com>
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

There is a PCI API to access device resources. Use it instead of
direct accesses.

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/ls2k-bmc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 1d8be9cdb3a8..7be8ddc520ac 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -484,7 +484,7 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	ls2k_bmc_cells[LS2K_BMC_DISPLAY].platform_data = &pd;
 	ls2k_bmc_cells[LS2K_BMC_DISPLAY].pdata_size = sizeof(pd);
-	base = dev->resource[0].start + LS2K_DISPLAY_RES_START;
+	base = pci_resource_start(dev, 0) + LS2K_DISPLAY_RES_START;
 
 	/* Remove conflicting efifb device */
 	ret = aperture_remove_conflicting_devices(base, SZ_4M, "simple-framebuffer");
@@ -493,7 +493,7 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	return devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
 				    ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_cells),
-				    &dev->resource[0], 0, NULL);
+				    pci_resource_n(dev, 0), 0, NULL);
 }
 
 static struct pci_device_id ls2k_bmc_devices[] = {
-- 
2.50.1



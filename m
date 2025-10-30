Return-Path: <linux-kernel+bounces-878132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27FC1FDA9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4708B34106C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D14F33FE00;
	Thu, 30 Oct 2025 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaiEOWFq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D1E2FFDEB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824262; cv=none; b=tF6V/Yt+4UDdnlKDCCBhFdq5aNG2C5nw9DpptaZcMeujhM6CH1y1n2MuTYN3cUCCIAAGiVUNwPL8k2SQOALu4VWykMLWdElWb6Ijo4osWEPNdFTkQMgHqDYSIaEI9VOBuWhpBr+FOOiwEJ1UiHuTkHTG/hrLT+jTtS9ffj5hNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824262; c=relaxed/simple;
	bh=3/7lBlNqYyL0yIScNNtmwKdPed/28cnVNOyHFT4nmtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lA8w6LrSR+r2IourkkfoeD8xl1jFJ8/Ga4GoesurOhTtkQgwpZAceeX4hlH4SeY+HiMZ2jwjfx1ZXQ8HsU4l8/jUco7Bud9WE4IWb+zNpsmYMTBoEZgRpQPOxLSScmbzXhR/7R5R04KxxKSwVhCTRJW1MeXwddNTJqDfMopSLkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaiEOWFq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761824261; x=1793360261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3/7lBlNqYyL0yIScNNtmwKdPed/28cnVNOyHFT4nmtg=;
  b=KaiEOWFq75VqzMjtQXThgUe0lOorO4dK9a+hYCUwHaTVNJTYBxNrnwPh
   PQfUd2fvvGJCBi+Uu4gdVqiAfCrJvR/BEO5rKs7Iy0n/DqM2VVfuDmY+f
   C7483us2NbrjGJFS6ivk99UGrTqDoNuDRY6rJS5Oa16dyQ2R5Yna36YYx
   JiyH5NWHT7Myrsls2PxYIvs/zrTttZuEyUWFEWgDSsLbnPokW+fnDLtgn
   6rGDNzTynmILjVvroSbWMIby+hCga1hD4w7jOAHbD/R0Ty5A3hCbS8RkM
   NSMedzLZqqi6BbjonE77CFxXHANCFBmXisJv2sTafsur5NvZbckk5IHJy
   A==;
X-CSE-ConnectionGUID: PseuQDntQ268nOuFIuHMIA==
X-CSE-MsgGUID: HDKC3UefRpyNY+tglZ7Y+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002272"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="64002272"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 04:37:39 -0700
X-CSE-ConnectionGUID: du2nLlzbQW+ZYo1AGeWclg==
X-CSE-MsgGUID: JkRDfpMvT+mbsrACYEfaQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="216785206"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 30 Oct 2025 04:37:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BD21F97; Thu, 30 Oct 2025 12:37:36 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Chong Qiao <qiaochong@loongson.cn>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 2/2] mfd: ls2kbmc: Use PCI API instead of direct accesses
Date: Thu, 30 Oct 2025 12:36:34 +0100
Message-ID: <20251030113735.3741913-3-andriy.shevchenko@linux.intel.com>
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

There is PCI API to access device resources. Use it instead of
direct accesses.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/ls2k-bmc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 616ff0a28b00..7b0a5fed1d1d 100644
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



Return-Path: <linux-kernel+bounces-797991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470AAB41820
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFCA3A7363
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090BA2E8896;
	Wed,  3 Sep 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVEDTgFT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331228315D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887260; cv=none; b=BLLrGZz0QIPEgxCS4zWvAisPZ9mGZDUXbrFB2rK78Ln92puDsknE1eqKmeoCHhxSQ7RqBeCWo54EUVNcpEpqTmyx0JvG82FXh4FKwkbkVOn5nzSpnmFddJE04fc72TSyyCoV7oVgE2drwO94yTDfktLvr1+PdzCrAm1XzfZgDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887260; c=relaxed/simple;
	bh=fQEW/ktFyXYtZKhe9AS3WT1ne7TP7u25aXgnO7fKS9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0TPf6uCxsmON/yvw725vtdEWxJ2gXqzgYyFn1A0qaAXguAYzEccB3Wgm6DOqmwa4FU3QBQnwbef6Sjl5uXRTxlQneTTeuamPOLCRnaHvm+oGXn9fkt/nU8biMchR5EBBgSvim+rJcBfLztVqW75dHfBQchidRNT47sq6faSdW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVEDTgFT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756887259; x=1788423259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fQEW/ktFyXYtZKhe9AS3WT1ne7TP7u25aXgnO7fKS9M=;
  b=fVEDTgFT0rvtZFR23mxbKd3OF+LClEWkI0mqeHxq0f7kARPUhIhOoCSC
   9n48fK7Zn129u5KApE0hyrS+XEaZQp5jXFStp4z1wvC6vwI5osxHCvL/1
   9AtMTubmo/PhVDoYvc39N35BbUhskO0QxbCACCktKma3LGowqOCp0qXfM
   DkUaJRMf4zpmTfpG1UOZtVYbFeS5m1Y1LpNk+kj+OIVCY1QbjBy6uxP2N
   kKdoQdMMDvoE+eixKEOKTud1MZYwcH4OwzQuOUwC4ryF2LNlSTabkA2dx
   pMuN456Gg+KRPuj228+K371NIwRTw8UHw/oHtVFqH5M2lAR9Jtd27NHdv
   g==;
X-CSE-ConnectionGUID: 0oGxuFFJQxGFCRpRbnT0yQ==
X-CSE-MsgGUID: lKpB61e0Q8++VRSYLJUikw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="70621386"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="70621386"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:14:19 -0700
X-CSE-ConnectionGUID: aHiDDOKiTp+jpsmB8bb34g==
X-CSE-MsgGUID: CFNzqkc1SrmK2pg5vAL6fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171092929"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 03 Sep 2025 01:14:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id C23E796; Wed, 03 Sep 2025 10:14:15 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Peter Tyser <ptyser@xes-inc.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 2/2] mfd: lpc_ich: Convert to use resource_rebase()
Date: Wed,  3 Sep 2025 10:12:29 +0200
Message-ID: <20250903081414.1972179-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com>
References: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the resource handling by converting to use resource_rebase().
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/lpc_ich.c | 38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 4b7d0cb9340f..6942a744e87b 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -132,15 +132,12 @@ static struct mfd_cell lpc_ich_gpio_cell = {
 	.ignore_resource_conflicts = true,
 };
 
-#define INTEL_GPIO_RESOURCE_SIZE	0x1000
-
 struct lpc_ich_gpio_info {
 	const char *hid;
 	const struct mfd_cell *devices;
 	size_t nr_devices;
 	struct resource **resources;
 	size_t nr_resources;
-	const resource_size_t *offsets;
 };
 
 #define APL_GPIO_NORTH		0
@@ -151,31 +148,23 @@ struct lpc_ich_gpio_info {
 #define APL_GPIO_NR_DEVICES	4
 #define APL_GPIO_NR_RESOURCES	4
 
-/* Offset data for Apollo Lake GPIO controllers */
-static const resource_size_t apl_gpio_offsets[APL_GPIO_NR_RESOURCES] = {
-	[APL_GPIO_NORTH]	= 0xc50000,
-	[APL_GPIO_NORTHWEST]	= 0xc40000,
-	[APL_GPIO_WEST]		= 0xc70000,
-	[APL_GPIO_SOUTHWEST]	= 0xc00000,
-};
-
 #define APL_GPIO_IRQ			14
 
 static struct resource apl_gpio_resources[APL_GPIO_NR_DEVICES][2] = {
 	[APL_GPIO_NORTH] = {
-		DEFINE_RES_MEM(0, 0),
+		DEFINE_RES_MEM(0xc50000, 0x1000),
 		DEFINE_RES_IRQ(APL_GPIO_IRQ),
 	},
 	[APL_GPIO_NORTHWEST] = {
-		DEFINE_RES_MEM(0, 0),
+		DEFINE_RES_MEM(0xc40000, 0x1000),
 		DEFINE_RES_IRQ(APL_GPIO_IRQ),
 	},
 	[APL_GPIO_WEST] = {
-		DEFINE_RES_MEM(0, 0),
+		DEFINE_RES_MEM(0xc70000, 0x1000),
 		DEFINE_RES_IRQ(APL_GPIO_IRQ),
 	},
 	[APL_GPIO_SOUTHWEST] = {
-		DEFINE_RES_MEM(0, 0),
+		DEFINE_RES_MEM(0xc00000, 0x1000),
 		DEFINE_RES_IRQ(APL_GPIO_IRQ),
 	},
 };
@@ -224,7 +213,6 @@ static const struct lpc_ich_gpio_info apl_gpio_info = {
 	.nr_devices = ARRAY_SIZE(apl_gpio_devices),
 	.resources = apl_gpio_mem_resources,
 	.nr_resources = ARRAY_SIZE(apl_gpio_mem_resources),
-	.offsets = apl_gpio_offsets,
 };
 
 #define DNV_GPIO_NORTH		0
@@ -233,17 +221,11 @@ static const struct lpc_ich_gpio_info apl_gpio_info = {
 #define DNV_GPIO_NR_DEVICES	1
 #define DNV_GPIO_NR_RESOURCES	2
 
-/* Offset data for Denverton GPIO controllers */
-static const resource_size_t dnv_gpio_offsets[DNV_GPIO_NR_RESOURCES] = {
-	[DNV_GPIO_NORTH]	= 0xc20000,
-	[DNV_GPIO_SOUTH]	= 0xc50000,
-};
-
 #define DNV_GPIO_IRQ			14
 
 static struct resource dnv_gpio_resources[DNV_GPIO_NR_RESOURCES + 1] = {
-	[DNV_GPIO_NORTH] = DEFINE_RES_MEM(0, 0),
-	[DNV_GPIO_SOUTH] = DEFINE_RES_MEM(0, 0),
+	[DNV_GPIO_NORTH] = DEFINE_RES_MEM(0xc20000, 0x1000),
+	[DNV_GPIO_SOUTH] = DEFINE_RES_MEM(0xc50000, 0x1000),
 	DEFINE_RES_IRQ(DNV_GPIO_IRQ),
 };
 
@@ -267,7 +249,6 @@ static const struct lpc_ich_gpio_info dnv_gpio_info = {
 	.nr_devices = ARRAY_SIZE(dnv_gpio_devices),
 	.resources = dnv_gpio_mem_resources,
 	.nr_resources = ARRAY_SIZE(dnv_gpio_mem_resources),
-	.offsets = dnv_gpio_offsets,
 };
 
 static struct mfd_cell lpc_ich_spi_cell = {
@@ -1251,12 +1232,9 @@ static int lpc_ich_init_pinctrl(struct pci_dev *dev)
 
 	for (i = 0; i < info->nr_resources; i++) {
 		struct resource *mem = info->resources[i];
-		resource_size_t offset = info->offsets[i];
 
-		/* Fill MEM resource */
-		mem->start = base.start + offset;
-		mem->end = base.start + offset + INTEL_GPIO_RESOURCE_SIZE - 1;
-		mem->flags = base.flags;
+		/* Rebase MEM resource */
+		resource_rebase(mem, base.start);
 	}
 
 	return mfd_add_devices(&dev->dev, 0, info->devices, info->nr_devices,
-- 
2.50.1



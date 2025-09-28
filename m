Return-Path: <linux-kernel+bounces-835173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F221CBA6703
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31033BA5F5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182F258CE1;
	Sun, 28 Sep 2025 03:24:23 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601942571B9;
	Sun, 28 Sep 2025 03:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759029863; cv=none; b=cVTPZgD6Gd3qpOZ67Kmu6h2MRbvJljv81ft/CfUlY0L3iEayTQohlGfuPHD63Vzt99GQjIh5xJh6roNSL+ksSYZjT+GdBMby/RlQD+XTwRYQfa5aKHa/5l/JDj7Ic3iYTuJVqC4tShwkUfOiy+JyWGXOXPJldtpa0R/ei4yWMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759029863; c=relaxed/simple;
	bh=ncHQ74VMBeChHXw3LJSTDTOQY+esT2CeSqVWwsaaPSU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHu/MJFEFkgS1dB28qMv2LI7xxCz2RR0rjFg9t67AUQP1LQFixmikpV5MoCbvBKrv5lKIMt8TllUW293dPGWzG6ZMuJAfv1NAbFwt7ZCsp0hticZLgsJhnQQYrcfPSfacOULoIpx5EJ9z2Mg2oySgBLDTUqGQobfPHjX5kMW3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 28 Sep
 2025 11:24:07 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 28 Sep 2025 11:24:07 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] usb: ehci: Add Aspeed AST2700 support
Date: Sun, 28 Sep 2025 11:24:07 +0800
Message-ID: <20250928032407.27764-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250928032407.27764-1-ryan_chen@aspeedtech.com>
References: <20250928032407.27764-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Unlike earlier Aspeed SoCs (AST2400/2500/2600) which are limited to
32-bit DMA addressing, the EHCI controller in AST2700 supports 64-bit
DMA. Update the EHCI platform driver to make use of this capability by
selecting a 64-bit DMA mask when the "aspeed,ast2700-ehci" compatible
is present in device tree.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/usb/host/ehci-platform.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 6aab45c8525c..bcd1c9073515 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/sys_soc.h>
@@ -239,9 +240,11 @@ static int ehci_platform_probe(struct platform_device *dev)
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
+	const struct of_device_id *match;
 	struct ehci_platform_priv *priv;
 	struct ehci_hcd *ehci;
 	int err, irq, clk = 0;
+	bool dma_mask_64;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -253,8 +256,13 @@ static int ehci_platform_probe(struct platform_device *dev)
 	if (!pdata)
 		pdata = &ehci_platform_defaults;
 
+	dma_mask_64 = pdata->dma_mask_64;
+	match = of_match_device(dev->dev.driver->of_match_table, &dev->dev);
+	if (match && match->data)
+		dma_mask_64 = true;
+
 	err = dma_coerce_mask_and_coherent(&dev->dev,
-		pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
+		dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
 	if (err) {
 		dev_err(&dev->dev, "Error: DMA mask configuration failed\n");
 		return err;
@@ -298,7 +306,9 @@ static int ehci_platform_probe(struct platform_device *dev)
 		if (of_device_is_compatible(dev->dev.of_node,
 					    "aspeed,ast2500-ehci") ||
 		    of_device_is_compatible(dev->dev.of_node,
-					    "aspeed,ast2600-ehci"))
+					    "aspeed,ast2600-ehci") ||
+		    of_device_is_compatible(dev->dev.of_node,
+					    "aspeed,ast2700-ehci"))
 			ehci->is_aspeed = 1;
 
 		if (soc_device_match(quirk_poll_match))
@@ -485,6 +495,7 @@ static const struct of_device_id vt8500_ehci_ids[] = {
 	{ .compatible = "wm,prizm-ehci", },
 	{ .compatible = "generic-ehci", },
 	{ .compatible = "cavium,octeon-6335-ehci", },
+	{ .compatible = "aspeed,ast2700-ehci",	.data = (void *)1 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
-- 
2.34.1



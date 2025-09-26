Return-Path: <linux-kernel+bounces-833524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE434BA2389
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5BE3A77AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB4726A0DB;
	Fri, 26 Sep 2025 02:33:23 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393A02641E3;
	Fri, 26 Sep 2025 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854003; cv=none; b=SCGrlRxppaYqX6JnF3uR5IiauItzt+G8u8e9b+nGlsG4d1rVTUYKZXtu5nmhphBEvPxiCiOn961ib31jM7jXKXDXBXGwOfP3zNYQVe46yF4azlBKMS2w82piBBtFhMfcyKfqg2MWbmQReMj6tvHeSzwcswwOUi+nJqa/KVz76vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854003; c=relaxed/simple;
	bh=w27IKR9yHgPoc2iDFNIDygZ+UnWWnMDTOM8eCL9Imc8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/5VeDRVP0BHUID15zoQqOYDNjWoQzvwySZyHcOWS2osfv0POXL54mud7wZdIz4xMqu+LMDVSEvyaAeA+WJ2PXvlfM6HbiTIiG/RgomEjorMlYkbwzp0kO/1ZUc3IYsxwCA1srd80y+X5bjv5wpzSo3w44LQ2N5yiQmUBSuI97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 26 Sep
 2025 10:33:08 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 10:33:08 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] usb: ehci: Add Aspeed AST2700 support
Date: Fri, 26 Sep 2025 10:33:08 +0800
Message-ID: <20250926023308.2890607-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926023308.2890607-1-ryan_chen@aspeedtech.com>
References: <20250926023308.2890607-1-ryan_chen@aspeedtech.com>
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
 drivers/usb/host/ehci-platform.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 6aab45c8525c..18e231d345d0 100644
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
@@ -239,6 +240,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
+	const struct of_device_id *match;
 	struct ehci_platform_priv *priv;
 	struct ehci_hcd *ehci;
 	int err, irq, clk = 0;
@@ -253,6 +255,10 @@ static int ehci_platform_probe(struct platform_device *dev)
 	if (!pdata)
 		pdata = &ehci_platform_defaults;
 
+	match = of_match_device(dev->dev.driver->of_match_table, &dev->dev);
+	if (match && match->data)
+		pdata->dma_mask_64 = 1;
+
 	err = dma_coerce_mask_and_coherent(&dev->dev,
 		pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
 	if (err) {
@@ -298,7 +304,9 @@ static int ehci_platform_probe(struct platform_device *dev)
 		if (of_device_is_compatible(dev->dev.of_node,
 					    "aspeed,ast2500-ehci") ||
 		    of_device_is_compatible(dev->dev.of_node,
-					    "aspeed,ast2600-ehci"))
+					    "aspeed,ast2600-ehci") ||
+		    of_device_is_compatible(dev->dev.of_node,
+					    "aspeed,ast2700-ehci"))
 			ehci->is_aspeed = 1;
 
 		if (soc_device_match(quirk_poll_match))
@@ -485,6 +493,7 @@ static const struct of_device_id vt8500_ehci_ids[] = {
 	{ .compatible = "wm,prizm-ehci", },
 	{ .compatible = "generic-ehci", },
 	{ .compatible = "cavium,octeon-6335-ehci", },
+	{ .compatible = "aspeed,ast2700-ehci",	.data = (void *)1 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
-- 
2.34.1



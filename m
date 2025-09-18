Return-Path: <linux-kernel+bounces-822168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6911B8333A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDE07B1A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F52E8DF0;
	Thu, 18 Sep 2025 06:49:35 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097E2E7651;
	Thu, 18 Sep 2025 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178174; cv=none; b=Wih0Fqvut0XgapWPuUczzZ7NKLn7TDbCBdkmNJH2fak16bqJzWKI9YpPu0p9pZ0cR/16HylNXOd/8MyHfxOZ5MdMZDleWcXvgnlYmAkVuWvjert6nLBcHN009Tmd29HSTZMvS2PT1sGifpGoLaB5opJudQ/T46M5G3LD2oMnhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178174; c=relaxed/simple;
	bh=9Eh/tQsW+3HEfoySbMTj71AIMcMtFp4eVvbvHsN2PqQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZJCMSJvZzcWVBwe4FDlCgw3Luama4hWoEi3VnDWzF0o0kKLeJE3cP78saoybNA40siWFB6NW5mI1bohIZI43stHpnkMRn058u0myvaoku99ycynMzA+qP1yWyNmINiX8hSKfOmhzMSTiUexj6xHmSp2DubX9exPcG2EWois9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 18 Sep
 2025 14:49:20 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 14:49:20 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] usb: ehci: Add Aspeed AST2700 support
Date: Thu, 18 Sep 2025 14:49:19 +0800
Message-ID: <20250918064919.224927-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918064919.224927-1-ryan_chen@aspeedtech.com>
References: <20250918064919.224927-1-ryan_chen@aspeedtech.com>
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
 drivers/usb/host/ehci-platform.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 6aab45c8525c..edf1fb4033c2 100644
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
@@ -122,10 +123,18 @@ static const struct ehci_driver_overrides platform_overrides __initconst = {
 	.extra_priv_size =	sizeof(struct ehci_platform_priv),
 };
 
+#define EHCI_PDATA_COMMON        \
+	.power_on		= ehci_platform_power_on,	\
+	.power_suspend	= ehci_platform_power_off,	\
+	.power_off		= ehci_platform_power_off
+
 static struct usb_ehci_pdata ehci_platform_defaults = {
-	.power_on =		ehci_platform_power_on,
-	.power_suspend =	ehci_platform_power_off,
-	.power_off =		ehci_platform_power_off,
+	EHCI_PDATA_COMMON,
+};
+
+static const struct usb_ehci_pdata ehci_ast2700_platform = {
+	EHCI_PDATA_COMMON,
+	.dma_mask_64 = 1,
 };
 
 /**
@@ -239,6 +248,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
+	const struct of_device_id *match;
 	struct ehci_platform_priv *priv;
 	struct ehci_hcd *ehci;
 	int err, irq, clk = 0;
@@ -250,7 +260,10 @@ static int ehci_platform_probe(struct platform_device *dev)
 	 * Use reasonable defaults so platforms don't have to provide these
 	 * with DT probing on ARM.
 	 */
-	if (!pdata)
+	match = of_match_device(dev->dev.driver->of_match_table, &dev->dev);
+	if (match && match->data)
+		pdata = (struct usb_ehci_pdata *)match->data;
+	else if (!pdata)
 		pdata = &ehci_platform_defaults;
 
 	err = dma_coerce_mask_and_coherent(&dev->dev,
@@ -298,7 +311,9 @@ static int ehci_platform_probe(struct platform_device *dev)
 		if (of_device_is_compatible(dev->dev.of_node,
 					    "aspeed,ast2500-ehci") ||
 		    of_device_is_compatible(dev->dev.of_node,
-					    "aspeed,ast2600-ehci"))
+					    "aspeed,ast2600-ehci") ||
+		    of_device_is_compatible(dev->dev.of_node,
+					    "aspeed,ast2700-ehci"))
 			ehci->is_aspeed = 1;
 
 		if (soc_device_match(quirk_poll_match))
@@ -485,6 +500,7 @@ static const struct of_device_id vt8500_ehci_ids[] = {
 	{ .compatible = "wm,prizm-ehci", },
 	{ .compatible = "generic-ehci", },
 	{ .compatible = "cavium,octeon-6335-ehci", },
+	{ .compatible = "aspeed,ast2700-ehci",	.data = &ehci_ast2700_platform },
 	{}
 };
 MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
-- 
2.34.1



Return-Path: <linux-kernel+bounces-812929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D010B53E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7F21B28BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199002E54D3;
	Thu, 11 Sep 2025 21:57:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B02E0B68
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627821; cv=none; b=t+hpIjv10cHxwZ+l/kWcCyyYS8VLU4ljd94NRQQdnsW+yvff3V8i/u9TxxzRHO+Dk+M1Uk9GEhwSfSBKvykIhp0sfkwinhuNTOsclQyP+toD0wnZkT0H3XTIACYKeFG8Y1WDHlbnHJhnItskV5orZ2Sq39Nno8gwPDHhH5uEAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627821; c=relaxed/simple;
	bh=YVmSvLmXA4fSHddIJODfvJPQ3kUAobuiJCXsXHGJMhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=He/ZocKDuCmPyrgUgpDQvvm4GfVWc2a7uTY5ve1HppWd2CB3uW5J7GHnEU3+f5Y+4AHhoixbAVyciBYIzxwjmNkPpPvyoXLDqWtcgtvDzde9eYJvEZE0q9d7DPAEeV2GU1v1ZdaUyfoLdI5swwYi1JIISFZAg4O5I2LGB5/GO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwpHe-0004g5-G9; Thu, 11 Sep 2025 23:56:50 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 11 Sep 2025 23:56:51 +0200
Subject: [PATCH v2 10/10] dmaengine: imx-sdma: make use of dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-v6-16-topic-sdma-v2-10-d315f56343b5@pengutronix.de>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
In-Reply-To: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add dev_err_probe() at return path of probe() to support users to
identify issues easier.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a7e6554ca223e2e980caf2e2dea832db9ad60ed6..d4430e6e56deda7de3538e42af7987a456957b43 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2292,7 +2292,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to set DMA mask\n");
 
 	sdma = devm_kzalloc(dev, sizeof(*sdma), GFP_KERNEL);
 	if (!sdma)
@@ -2309,24 +2309,24 @@ static int sdma_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return irq;
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
 
 	sdma->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sdma->regs))
-		return PTR_ERR(sdma->regs);
+		return dev_err_probe(dev, PTR_ERR(sdma->regs), "ioremap failed\n");
 
 	sdma->clk_ipg = devm_clk_get_prepared(dev, "ipg");
 	if (IS_ERR(sdma->clk_ipg))
-		return PTR_ERR(sdma->clk_ipg);
+		return dev_err_probe(dev, PTR_ERR(sdma->clk_ipg), "IPG clk_get_prepared failed\n");
 
 	sdma->clk_ahb = devm_clk_get_prepared(dev, "ahb");
 	if (IS_ERR(sdma->clk_ahb))
-		return PTR_ERR(sdma->clk_ahb);
+		return dev_err_probe(dev, PTR_ERR(sdma->clk_ahb), "AHB clk_get_prepared failed\n");
 
 	ret = devm_request_irq(dev, irq, sdma_int_handler, 0,
 			       dev_name(dev), sdma);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
 
 	sdma->irq = irq;
 
@@ -2367,11 +2367,11 @@ static int sdma_probe(struct platform_device *pdev)
 
 	ret = sdma_init(sdma);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "sdma_init failed\n");
 
 	ret = sdma_event_remap(sdma);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "sdma_event_remap failed\n");
 
 	if (sdma->drvdata->script_addrs)
 		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
@@ -2398,28 +2398,21 @@ static int sdma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sdma);
 
 	ret = dma_async_device_register(&sdma->dma_device);
-	if (ret) {
-		dev_err(dev, "unable to register\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to register\n");
 
 	ret = devm_add_action_or_reset(dev, sdma_dma_device_unregister_action, sdma);
-	if (ret) {
-		dev_err(dev, "Unable to register release hook\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to register release hook\n");
 
 	ret = of_dma_controller_register(np, sdma_xlate, sdma);
-	if (ret) {
-		dev_err(dev, "failed to register controller\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register controller\n");
 
 	ret = devm_add_action_or_reset(dev, sdma_dma_of_dma_controller_unregister_action, sdma);
-	if (ret) {
-		dev_err(dev, "failed to register of-dma-controller unregister hook\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register of-dma-controller unregister hook\n");
 
 	/*
 	 * Because that device tree does not encode ROM script address,

-- 
2.47.3



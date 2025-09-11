Return-Path: <linux-kernel+bounces-812923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F041AB53E32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792745A5F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F7B2E040B;
	Thu, 11 Sep 2025 21:56:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89482DC34B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627818; cv=none; b=KaEtUAeaJ0lIVWO2KPeW1HG9+FOnrwRhumHfUu+1m71VUo+SUKFgmH2TLeR9xqdAOfoYAXuCx+cYVauR7wPD49QlqFWGPvZM9RHiHZFxWZjPVNvWbn0zk4l1vXxYYMMwBrfsf9BKIq7kqs72eFDMZh6nPOGwh5iT1HfemwzZq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627818; c=relaxed/simple;
	bh=Zifnmig/mmN0xCIOodUFIJ/i4rpbpjL4rBicSOwNiOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mhlUZbT504RT7P0YFfOh4ye9v1lcKrdubxsJQTYbZH3hGlIfa6On6kfav4GyzwVOJHU8JWApINj6LgPxszxEI7cKLRXtEAI1P7wFw1gRxTFtRH8kycGAfbjyoeGmlTTNuuTatUTp/5SlvOpDGMzPqXsiFbGVc+7NO+sD2KoniNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwpHe-0004g5-7I; Thu, 11 Sep 2025 23:56:50 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 11 Sep 2025 23:56:46 +0200
Subject: [PATCH v2 05/10] dmaengine: imx-sdma: cosmetic cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-v6-16-topic-sdma-v2-5-d315f56343b5@pengutronix.de>
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

Make use of local struct device pointer to not dereference the
platform_device pointer everytime.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 44411c15029c9b09f307c4b9e3f7b1ab77fa5093..b0def2bde77fe53b0805bddc0c5d6116c9cefcbe 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2266,7 +2266,8 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 
 static int sdma_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	const char *fw_name;
 	int ret;
 	int irq;
@@ -2274,18 +2275,18 @@ static int sdma_probe(struct platform_device *pdev)
 	struct sdma_engine *sdma;
 	s32 *saddr_arr;
 
-	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-	sdma = devm_kzalloc(&pdev->dev, sizeof(*sdma), GFP_KERNEL);
+	sdma = devm_kzalloc(dev, sizeof(*sdma), GFP_KERNEL);
 	if (!sdma)
 		return -ENOMEM;
 
 	spin_lock_init(&sdma->channel_0_lock);
 
-	sdma->dev = &pdev->dev;
-	sdma->drvdata = of_device_get_match_data(sdma->dev);
+	sdma->dev = dev;
+	sdma->drvdata = of_device_get_match_data(dev);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -2295,11 +2296,11 @@ static int sdma_probe(struct platform_device *pdev)
 	if (IS_ERR(sdma->regs))
 		return PTR_ERR(sdma->regs);
 
-	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	sdma->clk_ipg = devm_clk_get(dev, "ipg");
 	if (IS_ERR(sdma->clk_ipg))
 		return PTR_ERR(sdma->clk_ipg);
 
-	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	sdma->clk_ahb = devm_clk_get(dev, "ahb");
 	if (IS_ERR(sdma->clk_ahb))
 		return PTR_ERR(sdma->clk_ahb);
 
@@ -2311,8 +2312,8 @@ static int sdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
-				dev_name(&pdev->dev), sdma);
+	ret = devm_request_irq(dev, irq, sdma_int_handler, 0,
+			       dev_name(dev), sdma);
 	if (ret)
 		goto err_irq;
 
@@ -2357,7 +2358,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
 	if (sdma->iram_pool)
-		dev_info(&pdev->dev, "alloc bd from iram.\n");
+		dev_info(dev, "alloc bd from iram.\n");
 
 	ret = sdma_init(sdma);
 	if (ret)
@@ -2370,7 +2371,7 @@ static int sdma_probe(struct platform_device *pdev)
 	if (sdma->drvdata->script_addrs)
 		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
 
-	sdma->dma_device.dev = &pdev->dev;
+	sdma->dma_device.dev = dev;
 
 	sdma->dma_device.device_alloc_chan_resources = sdma_alloc_chan_resources;
 	sdma->dma_device.device_free_chan_resources = sdma_free_chan_resources;
@@ -2393,13 +2394,13 @@ static int sdma_probe(struct platform_device *pdev)
 
 	ret = dma_async_device_register(&sdma->dma_device);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to register\n");
+		dev_err(dev, "unable to register\n");
 		goto err_init;
 	}
 
 	ret = of_dma_controller_register(np, sdma_xlate, sdma);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register controller\n");
+		dev_err(dev, "failed to register controller\n");
 		goto err_register;
 	}
 
@@ -2411,11 +2412,11 @@ static int sdma_probe(struct platform_device *pdev)
 	ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
 				      &fw_name);
 	if (ret) {
-		dev_warn(&pdev->dev, "failed to get firmware name\n");
+		dev_warn(dev, "failed to get firmware name\n");
 	} else {
 		ret = sdma_get_firmware(sdma, fw_name);
 		if (ret)
-			dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
+			dev_warn(dev, "failed to get firmware from device tree\n");
 	}
 
 	return 0;

-- 
2.47.3



Return-Path: <linux-kernel+bounces-798619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB72B4207C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E486848D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF83054D5;
	Wed,  3 Sep 2025 13:06:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B9270572
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904787; cv=none; b=MKUnUTrSLL6HX3hPoW0Ro639/xswzVV7eagoBaN7eU0ld0hCjabD572uxvBdWOYxPr46t7iLJifS5c5em6Jg9GkNERyqbhUMahw+/77Itk+Ivdb+DkRwHry55s1COu4382HGoBQLXc6HHRqnmoBbZEk5DT6IXC3C00ppCmuLNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904787; c=relaxed/simple;
	bh=tQSJBiKibb4DJjgBw5ixcANjVU0K2CDPdBXgX70RmkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4RoUgTsU526yn4uWdzdv8WBV4kz1PcXEYASn4cKjBR5uFOh8HjH+OoLTfq1HPPJ0A17RBdSCXWEgOLryyK151MwoXMnEg5laijWd/C+7xs3DVcfIcicFA5XJJLwVjXGPtxaYgMVTMO5lkq3OA4+L3nForHsIE7bTRh1UTc4Kz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1utnBl-00006Z-MM; Wed, 03 Sep 2025 15:06:13 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 03 Sep 2025 15:06:11 +0200
Subject: [PATCH 03/11] dmaengine: imx-sdma: cosmetic cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-v6-16-topic-sdma-v1-3-ac7bab629e8b@pengutronix.de>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
In-Reply-To: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Make use of local struct device pointer to not dereference the
platform_device pointer everytime.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 422086632d3445b2ce3f2e5df9b2130174a311e8..a85739d279f51fdb517fce90b3dc67673cf2b56c 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2234,7 +2234,8 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 
 static int sdma_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct device_node *spba_bus;
 	const char *fw_name;
 	int ret;
@@ -2244,18 +2245,18 @@ static int sdma_probe(struct platform_device *pdev)
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
@@ -2265,11 +2266,11 @@ static int sdma_probe(struct platform_device *pdev)
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
 
@@ -2281,8 +2282,8 @@ static int sdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
-				dev_name(&pdev->dev), sdma);
+	ret = devm_request_irq(dev, irq, sdma_int_handler, 0,
+			       dev_name(dev), sdma);
 	if (ret)
 		goto err_irq;
 
@@ -2327,7 +2328,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
 	if (sdma->iram_pool)
-		dev_info(&pdev->dev, "alloc bd from iram.\n");
+		dev_info(dev, "alloc bd from iram.\n");
 
 	ret = sdma_init(sdma);
 	if (ret)
@@ -2340,7 +2341,7 @@ static int sdma_probe(struct platform_device *pdev)
 	if (sdma->drvdata->script_addrs)
 		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
 
-	sdma->dma_device.dev = &pdev->dev;
+	sdma->dma_device.dev = dev;
 
 	sdma->dma_device.device_alloc_chan_resources = sdma_alloc_chan_resources;
 	sdma->dma_device.device_free_chan_resources = sdma_free_chan_resources;
@@ -2363,13 +2364,13 @@ static int sdma_probe(struct platform_device *pdev)
 
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
 
@@ -2389,11 +2390,11 @@ static int sdma_probe(struct platform_device *pdev)
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
2.47.2



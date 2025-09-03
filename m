Return-Path: <linux-kernel+bounces-798622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85352B42071
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CF016F268
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D0D305E29;
	Wed,  3 Sep 2025 13:06:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F862EC548
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904787; cv=none; b=VTHnqPLAyZrdOYqh9Y9rKDxibxtgfZxraiXxzjY8QA/ZiSgQXVz/WpyYA2ppMJlzQvxF513dni5GPWrkPItzNcavlhiTeEzB5Dj45oxk6ZDniJLudr8/VYfSnCUYisESrHcpsvbvHSzIDkUe4oeYGIjTRtO7tfleTyKsPzZwNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904787; c=relaxed/simple;
	bh=SXF4nsn0QyxKfg2TjtolWOsatjZF/s1c7n5JCV+kVAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooIGX4XxdVr4hdPq94e+xHgxwVJ9xnYvRb6ba+UdWzd//ZBAsdiUjz6rMul6SzkUElOFuZR631fOrWh3i9SQYsrsVIe2Y0YO37mVzxo+2XFNuz7POTaeKiFRSeVTQOzYh9BAQApPcxygk1FnmoFSeeYmsm1Ibta3WJNkmB2GN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1utnBl-00006Z-J9; Wed, 03 Sep 2025 15:06:13 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 03 Sep 2025 15:06:09 +0200
Subject: [PATCH 01/11] dmaengine: imx-sdma: drop legacy device_node np
 check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-v6-16-topic-sdma-v1-1-ac7bab629e8b@pengutronix.de>
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

The legacy 'if (np)' was required in past where we had pdata and dt.
Nowadays the driver binds only to dt platforms. So using a new kernel
but still use pdata is not possible, therefore we can drop the legacy
'if' code path.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 02a85d6f1bea2df7d355858094c0c0b0bd07148e..89b4b1266726a9c8a552dc48670825ae00717e1c 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2325,11 +2325,9 @@ static int sdma_probe(struct platform_device *pdev)
 			vchan_init(&sdmac->vc, &sdma->dma_device);
 	}
 
-	if (np) {
-		sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
-		if (sdma->iram_pool)
-			dev_info(&pdev->dev, "alloc bd from iram.\n");
-	}
+	sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
+	if (sdma->iram_pool)
+		dev_info(&pdev->dev, "alloc bd from iram.\n");
 
 	ret = sdma_init(sdma);
 	if (ret)
@@ -2369,21 +2367,19 @@ static int sdma_probe(struct platform_device *pdev)
 		goto err_init;
 	}
 
-	if (np) {
-		ret = of_dma_controller_register(np, sdma_xlate, sdma);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to register controller\n");
-			goto err_register;
-		}
+	ret = of_dma_controller_register(np, sdma_xlate, sdma);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register controller\n");
+		goto err_register;
+	}
 
-		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
-		ret = of_address_to_resource(spba_bus, 0, &spba_res);
-		if (!ret) {
-			sdma->spba_start_addr = spba_res.start;
-			sdma->spba_end_addr = spba_res.end;
-		}
-		of_node_put(spba_bus);
+	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
+	ret = of_address_to_resource(spba_bus, 0, &spba_res);
+	if (!ret) {
+		sdma->spba_start_addr = spba_res.start;
+		sdma->spba_end_addr = spba_res.end;
 	}
+	of_node_put(spba_bus);
 
 	/*
 	 * Because that device tree does not encode ROM script address,

-- 
2.47.2



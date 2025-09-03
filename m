Return-Path: <linux-kernel+bounces-798627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F9B42086
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E4D1BC02F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD5E3093C8;
	Wed,  3 Sep 2025 13:06:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79F30505B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904789; cv=none; b=gc2urVymUhIsSJvMkzVpJfi4lGUNaMVf4stpt5FIhqJwK5ZdpkzEvGLqGvIDUkbpFV0nmU65Q56Z+Uc31s/YCW2eGfjOkZvShmFbY+GS1MnX1OK8ZSqB0qIrN0/V2pyHyAMLMV9ZGl/jvOhD+Jdn0yyJqQ3mw8LbjeV2pUrDWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904789; c=relaxed/simple;
	bh=l+p0YSax35ZqpVK6u/Uh/pohy4HYLDe2vbH2/NkXimo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lN+Fww331W0m5jE0Fx9kr4q8E7XGXcoTwXVjuHYUy/4eBJgzo3msc0ytPGYt5X1CjkSH8dlsHkjzwHCbOOR+Ru6cJTAgQ7uMXB1a/f9sNMkl3kyZcpydM6OlR4RXHpt48+jAPlbG1R68qLW56mJ3eoxSifFqWDSPbCMpJBhxflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1utnBm-00006Z-2s; Wed, 03 Sep 2025 15:06:14 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 03 Sep 2025 15:06:19 +0200
Subject: [PATCH 11/11] dmaengine: imx-sdma: fix spba-bus handling for
 i.MX8M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-v6-16-topic-sdma-v1-11-ac7bab629e8b@pengutronix.de>
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

Starting with i.MX8M* devices there are multiple spba-busses so we can't
just search the whole DT for the first spba-bus match and take it.
Instead we need to check for each device to which bus it belongs and
setup the spba_{start,end}_addr accordingly per sdma_channel.

While on it, don't ignore errors from of_address_to_resource() if they
are valid.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 56 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index c31785977351163d6fddf4d8b2f90dfebb508400..3ef415aa578a96e35a969ac2488d08bcab9fadc3 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -461,6 +461,8 @@ struct sdma_channel {
 	dma_addr_t			per_address, per_address2;
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
+	u32				spba_start_addr;
+	u32				spba_end_addr;
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
 	struct imx_dma_data		data;
@@ -534,8 +536,6 @@ struct sdma_engine {
 	u32				script_number;
 	struct sdma_script_start_addrs	*script_addrs;
 	const struct sdma_driver_data	*drvdata;
-	u32				spba_start_addr;
-	u32				spba_end_addr;
 	unsigned int			irq;
 	dma_addr_t			bd0_phys;
 	struct sdma_buffer_descriptor	*bd0;
@@ -1236,8 +1236,6 @@ static void sdma_channel_synchronize(struct dma_chan *chan)
 
 static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-
 	int lwml = sdmac->watermark_level & SDMA_WATERMARK_LEVEL_LWML;
 	int hwml = (sdmac->watermark_level & SDMA_WATERMARK_LEVEL_HWML) >> 16;
 
@@ -1263,12 +1261,12 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 		swap(sdmac->event_mask[0], sdmac->event_mask[1]);
 	}
 
-	if (sdmac->per_address2 >= sdma->spba_start_addr &&
-			sdmac->per_address2 <= sdma->spba_end_addr)
+	if (sdmac->per_address2 >= sdmac->spba_start_addr &&
+			sdmac->per_address2 <= sdmac->spba_end_addr)
 		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SP;
 
-	if (sdmac->per_address >= sdma->spba_start_addr &&
-			sdmac->per_address <= sdma->spba_end_addr)
+	if (sdmac->per_address >= sdmac->spba_start_addr &&
+			sdmac->per_address <= sdmac->spba_end_addr)
 		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;
 
 	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
@@ -1447,6 +1445,31 @@ static void sdma_desc_free(struct virt_dma_desc *vd)
 	kfree(desc);
 }
 
+static int sdma_config_spba_slave(struct dma_chan *chan)
+{
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct device_node *spba_bus;
+	struct resource spba_res;
+	int ret;
+
+	spba_bus = of_get_parent(chan->slave->of_node);
+	/* Device doesn't belong to the spba-bus */
+	if (!of_device_is_compatible(spba_bus, "fsl,spba-bus"))
+		return 0;
+
+	ret = of_address_to_resource(spba_bus, 0, &spba_res);
+	of_node_put(spba_bus);
+	if (ret) {
+		dev_err(sdmac->sdma->dev, "Failed to get spba-bus resources\n");
+		return -EINVAL;
+	}
+
+	sdmac->spba_start_addr = spba_res.start;
+	sdmac->spba_end_addr = spba_res.end;
+
+	return 0;
+}
+
 static int sdma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
@@ -1527,6 +1550,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdmac->event_id0 = 0;
 	sdmac->event_id1 = 0;
+	sdmac->spba_start_addr = 0;
+	sdmac->spba_end_addr = 0;
 
 	sdma_set_channel_priority(sdmac, 0);
 
@@ -1837,6 +1862,7 @@ static int sdma_config(struct dma_chan *chan,
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
+	int ret;
 
 	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
 
@@ -1867,6 +1893,10 @@ static int sdma_config(struct dma_chan *chan,
 		sdma_event_enable(sdmac, sdmac->event_id1);
 	}
 
+	ret = sdma_config_spba_slave(chan);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2251,11 +2281,9 @@ static int sdma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *spba_bus;
 	const char *fw_name;
 	int ret;
 	int irq;
-	struct resource spba_res;
 	int i;
 	struct sdma_engine *sdma;
 	s32 *saddr_arr;
@@ -2379,14 +2407,6 @@ static int sdma_probe(struct platform_device *pdev)
 
 	devm_add_action_or_reset(dev, sdma_dma_of_dma_controller_unregister_action, sdma);
 
-	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
-	ret = of_address_to_resource(spba_bus, 0, &spba_res);
-	if (!ret) {
-		sdma->spba_start_addr = spba_res.start;
-		sdma->spba_end_addr = spba_res.end;
-	}
-	of_node_put(spba_bus);
-
 	/*
 	 * Because that device tree does not encode ROM script address,
 	 * the RAM script in firmware is mandatory for device tree

-- 
2.47.2



Return-Path: <linux-kernel+bounces-798621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE1B4207F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A0D686991
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374BF3054EF;
	Wed,  3 Sep 2025 13:06:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C80304BD5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904787; cv=none; b=LlqtVlXNyPsqI9ULw9Ma2+1XVsONayEtEtEeZPhGY/Ceo3XRW7wsqSx7O/ULr/Oce7uacP9aKPPcOxExj4aGLJOs3Qi+BId5VrHdlrbYkp9TyFlrbnTMLTWAp3WJU4SkC17od7fubNc+u2NhB+flWEVrjVVK0ymudTLujg73Kwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904787; c=relaxed/simple;
	bh=Y/6IWMSaWYLc08RevVjoMexLbVWlu7SZensZC9s3Sa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5BuPPqG3oml2rJd1fTRD1s2DPouRDN4+NGxVRb6OvWpKBIfLPFAgInmgbJjElZHPXbVs4fnibzLvu5C+NCdfLcFdRwFeS3rBbhjtAobH5fwI+vsivVGemktQnKotvLuBpppRJ5tjaj6Rgyps39Hkqne0NLzOIHh64Q9r8UFwgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1utnBl-00006Z-KX; Wed, 03 Sep 2025 15:06:13 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 03 Sep 2025 15:06:10 +0200
Subject: [PATCH 02/11] dmaengine: imx-sdma: sdma_remove minor cleanups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-v6-16-topic-sdma-v1-2-ac7bab629e8b@pengutronix.de>
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

We don't need to set the pdev driver data to NULL since the device will
be freed anyways.

Also drop the tasklet_kill() since this is done by the virt-dma driver
during the vchan_synchronize().

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 89b4b1266726a9c8a552dc48670825ae00717e1c..422086632d3445b2ce3f2e5df9b2130174a311e8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2423,11 +2423,8 @@ static void sdma_remove(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->vc.task);
 		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
-
-	platform_set_drvdata(pdev, NULL);
 }
 
 static struct platform_driver sdma_driver = {

-- 
2.47.2



Return-Path: <linux-kernel+bounces-812934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C4B53E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA511C82947
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B0335BD0;
	Thu, 11 Sep 2025 22:00:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD7329F1F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628051; cv=none; b=jq7X3oI/WHj4ifb6ceC0fhpTyXKIXLt0htgm0r3tEHbIe1QlyksqXjQAdV8fLMjlFZhjZNOtIM1MfevqVaKjOb28RLLAxlOSK2b8kLeo2gCdDvUeq+QBxWmTMQSiurYxynI9w9UwsMLNHZqHdAHiOOrFGczcY9el9YiXUKRg6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628051; c=relaxed/simple;
	bh=NMqZyM7F1/2gyalRZwDIJ+zvaEMeLaDzM/RD+zRYdRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTGJQnV6MrRT/UZaOfjRR5mbhXPFwjwhlBX2LJDPZ4IUy+EL/cMwLmxYZYTtPut15EscZaaXk0mP/sWkqk0cbC6JgR2WAcAsej97tYry8DKAz1qjHqzC5sFyXDOpDJTcmKlTNtSi2EOw5uehgs9z+3BpUG6jxv8yntj8nltx7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwpLU-0005sG-L2; Fri, 12 Sep 2025 00:00:48 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 12 Sep 2025 00:00:41 +0200
Subject: [PATCH 1/2] dmaengine: add device_link support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-v6-16-topic-dma-devlink-v1-1-4debc2fbf901@pengutronix.de>
References: <20250912-v6-16-topic-dma-devlink-v1-0-4debc2fbf901@pengutronix.de>
In-Reply-To: <20250912-v6-16-topic-dma-devlink-v1-0-4debc2fbf901@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Shift the device dependency handling to the driver core by adding
support for devlinks.

The link between the consumer device and the dmaengine device is
established by the consumer via the dma_request_chan() automatically if
the dmaengine driver supports it (create_devlink flag set).

By adding the devlink support it is ensured that the supplier can't be
removed while the consumer still uses the dmaengine. Furthermore it
ensures that the supplier driver is present and actual bound before the
consumer is uses the supplier.

Additional PM and runtime-PM dependency handling can be added easily too
by setting the required flags (not implemented by this commit).

The new create_devlink flag controlls the devlink creation to not cause
any regressions with existing dmaengine drivers. This flag can be
removed once all drivers are successfully tested to support devlinks.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/dmaengine.c   | 15 +++++++++++++++
 include/linux/dmaengine.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 758fcd0546d8bde8e8dddc6039848feeb1e24475..e81985ab806ae87ff3aa4739fe6f6328b2587f2e 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -858,6 +858,21 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	/* No functional issue if it fails, users are supposed to test before use */
 #endif
 
+	/*
+	 * Devlinks between the dmaengine device and the consumer device
+	 * are optional till all dmaengine drivers are converted/tested.
+	 */
+	if (chan->device->create_devlink) {
+		struct device_link *dl;
+
+		dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!dl) {
+			dev_err(dev, "failed to create device link to %s\n",
+					dev_name(chan->device->dev));
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
 	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
 	if (!chan->name)
 		return chan;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index bb146c5ac3e4ccd7bc0afbf3b28e5b3d659ad62f..c67737a358df659f2bf050a9ccb8d23b17ceb357 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -817,6 +817,8 @@ struct dma_filter {
  *	DMA tansaction with no software intervention for reinitialization.
  *	Zero value means unlimited number of entries.
  * @descriptor_reuse: a submitted transfer can be resubmitted after completion
+ * @create_devlink: create a devlink between a dma_chan_dev supplier and
+ *	dma-channel consumer device
  * @residue_granularity: granularity of the transfer residue reported
  *	by tx_status
  * @device_alloc_chan_resources: allocate resources and return the
@@ -894,6 +896,7 @@ struct dma_device {
 	u32 max_burst;
 	u32 max_sg_burst;
 	bool descriptor_reuse;
+	bool create_devlink;
 	enum dma_residue_granularity residue_granularity;
 
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);

-- 
2.47.3



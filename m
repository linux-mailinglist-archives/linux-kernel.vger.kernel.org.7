Return-Path: <linux-kernel+bounces-618679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D79A9B1C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6854D1B8291D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27D3200B99;
	Thu, 24 Apr 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k2BAAqgy"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CB1A83E2;
	Thu, 24 Apr 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507317; cv=none; b=h3wVptGt2j+tw+8REny8nc10ULpLva+huQK6fjLtx4sLugMBF5XCM37H7RhvzVMTJWkBdkdQA+Wgf+jzPQs9ZEgBXVrIM/FmF0nmYWMc4qLbzRwkTftfFxUaVkQV3Mn51iqgIPD/g9SXHyDhDTWq5NRJhi1+6JuNY91qDLNqBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507317; c=relaxed/simple;
	bh=z6b0mzrpF2aZNgQo9qIcpvObLgZx1nJObxipm36NDhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/ZP5kb4IilaerI8YtMFQE1Vdka4uZCEkD/2ZoN4NLgqSTZtNLyrnmx581OjfC8k32zPaj+prNVVvoZBfL6tJwlkc8ikgbx9A9KWoPvKAkTRBGJYJOkNyKM0ooPGOgDttEaALTxv7IKLkcCDXJFc9MeKm1BcpD2m+ihxz55jGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k2BAAqgy; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE74E43B28;
	Thu, 24 Apr 2025 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745507306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Dknd1WYoRwFoYs5Ic/5aWkOPzzA922MzeBd+WtZEH0=;
	b=k2BAAqgyV2SHRY0iWQSduWkBsJXxJ5+pnZZlO5ME8V3jG7ubHVgZksTqDnsBjipOjRnsM1
	570PSjO/zio9dFb/0K/2PEmzzO7Vgauilp8tNiwBla0g3yc6fRgwJpePnB4nVCkW/pniBA
	1DwT5m2XH1s8SFoGrETpazF1v9CUhPXn7Dq5kanC5sha4Frt3UFUMb3Ihcjre4thNqZdbA
	pxHID0xubAknh4+Sn3ghEkDMRJNdKnN/Lg6TJBVuWKLL0Pn/PvUfrndGB1vo7HPsnlrVrn
	Yt20jC51t4UNTyr2he0XMk2ugr91uOICr7QKj+887HD4chY/dcx+Z1B90qwiZQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 24 Apr 2025 17:07:41 +0200
Subject: [PATCH RFC v2 3/5] drm/panel: ilitek-ili9881c: Add support for
 two-lane configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-feature_sfto340xc-v2-3-ff7da6192df2@bootlin.com>
References: <20250424-feature_sfto340xc-v2-0-ff7da6192df2@bootlin.com>
In-Reply-To: <20250424-feature_sfto340xc-v2-0-ff7da6192df2@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeljeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvr
 hdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghjvghsshiihhgrnhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Enable support for two-lane configuration which is done by setting the
LANSEL_SW_EN and LANSEL_SW bits in the Pad Control register.

Use the data-lanes device tree parameter to configure the number of lanes.
The default configuration remains set to four lanes.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Read the data-lanes parameter from the port endpoint and use
  drm_of_get_data_lanes_count instead of of_property_read_u32.
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 33 +++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 28cd7560e5db1d5734b10babdb4e4e553c6e07d0..2e38dea28336f445cb6a074dbbec006f0659287a 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -16,6 +16,7 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -1263,6 +1264,21 @@ static int ili9881c_send_cmd_data(struct ili9881c *ctx, u8 cmd, u8 data)
 	return 0;
 }
 
+static int ili9881c_set_lanes_cfg(struct ili9881c *ctx)
+{
+	int ret;
+
+	if (ctx->dsi->lanes != 2)
+		/* Nothing to do */
+		return 0;
+
+	ret = ili9881c_switch_page(ctx, 1);
+	if (ret)
+		return ret;
+
+	return ili9881c_send_cmd_data(ctx, 0xB7, 0x3);
+}
+
 static int ili9881c_prepare(struct drm_panel *panel)
 {
 	struct ili9881c *ctx = panel_to_ili9881c(panel);
@@ -1295,6 +1311,10 @@ static int ili9881c_prepare(struct drm_panel *panel)
 			return ret;
 	}
 
+	ret = ili9881c_set_lanes_cfg(ctx);
+	if (ret)
+		return ret;
+
 	ret = ili9881c_switch_page(ctx, 0);
 	if (ret)
 		return ret;
@@ -1503,8 +1523,9 @@ static const struct drm_panel_funcs ili9881c_funcs = {
 
 static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 {
+	struct device_node *endpoint;
 	struct ili9881c *ctx;
-	int ret;
+	int ret, lanes;
 
 	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -1545,11 +1566,19 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
+	endpoint = of_graph_get_endpoint_by_regs(dsi->dev.of_node, -1, -1);
+	lanes = drm_of_get_data_lanes_count(endpoint, 2, 4);
+	of_node_put(endpoint);
+	if (lanes == -EINVAL)
+		lanes = 4;
+	else if (lanes < 0)
+		return lanes;
+
 	drm_panel_add(&ctx->panel);
 
 	dsi->mode_flags = ctx->desc->mode_flags;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->lanes = 4;
+	dsi->lanes = lanes;
 
 	return mipi_dsi_attach(dsi);
 }

-- 
2.34.1



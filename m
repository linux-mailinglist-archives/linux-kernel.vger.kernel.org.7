Return-Path: <linux-kernel+bounces-754615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA4B19A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084CE16FD40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 02:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0215E204592;
	Mon,  4 Aug 2025 02:14:13 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196B1F1527;
	Mon,  4 Aug 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754273652; cv=none; b=KsieDCxCDCzkseJYOq9n8kewJHILftLvq6Z0KzNl8YzsRo0m7anHb7VRmtTL49tEFOsVxkN1plKXUbv8P04TloUAaPyrgvnkUd+D6YcIshDs+fhCgvt8WQs3TFSxlcqYtrzQ5f44eXEtMH8Uphow4plvJ13FdMHOIfaJCwVEsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754273652; c=relaxed/simple;
	bh=v4Qtuw0iQCGaRh9wXepraWYmf0E+O5vuzs/bBBqvwyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWf6VPkhlPMf9uHHOWZSwBGAeP1A7cdje2jdooKp+LLOh9Ueo1CpSibcCPb+ERYNJkr+eSPz2lX0fANn23YWIeyWqTkTuN2RBAJYngUxPYTHIDRFb9qumQqKUAexXuEF/74hyZhZWO1BKNXKHta3kj0bCD+ztCBrGeYcWP7bEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DC52420036B;
	Mon,  4 Aug 2025 04:08:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DF26200349;
	Mon,  4 Aug 2025 04:08:06 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3C4B5180023F;
	Mon,  4 Aug 2025 10:08:04 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Mon, 04 Aug 2025 11:07:42 +0900
Subject: [PATCH v2 3/3] drm: bridge: Add waveshare DSI2DPI unit driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-waveshare-v2-3-0a1b3ce92a95@nxp.com>
References: <20250804-waveshare-v2-0-0a1b3ce92a95@nxp.com>
In-Reply-To: <20250804-waveshare-v2-0-0a1b3ce92a95@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, victor.liu@nxp.com, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754273277; l=7757;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=v4Qtuw0iQCGaRh9wXepraWYmf0E+O5vuzs/bBBqvwyM=;
 b=vHVh/efFmKg8q0f59H0/OHJ4RpnTc3nG5nOBTQBqbt+GhOLG5eOlywavMTtl1W8dK/sxAjMXf
 oJpVK8o1auEBRLTtf7UQDLvaGyHWf6LLRq6eRUj87adZOeBATLXpRnq
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP

Waveshare touchscreen consists of a DPI panel and a driver board.
The waveshare driver board consists of ICN6211 and a MCU to
convert DSI to DPI and control the backlight.
This driver treats the MCU and ICN6211 board as a whole unit.
It can support all resolution waveshare DSI2DPI based panel,
the timing table should come from 'panel-dpi' panel in the device tree.

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
 drivers/gpu/drm/bridge/Kconfig         |  11 ++
 drivers/gpu/drm/bridge/Makefile        |   1 +
 drivers/gpu/drm/bridge/waveshare-dsi.c | 210 +++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index cb3b797fcea1c73e83c9187fef6582296b340305..26fec25c61ed7d950c094e0224f1196946079485 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -472,4 +472,15 @@ config DRM_ITE_IT6161
 	help
 	  ITE IT6161 bridge chip driver.
 
+config DRM_WAVESHARE_BRIDGE
+	tristate "Waveshare DSI bridge"
+	depends on OF
+	select DRM_PANEL_BRIDGE
+	select DRM_KMS_HELPER
+	select DRM_MIPI_DSI
+	select REGMAP_I2C
+	help
+	  Driver for waveshare DSI to DPI bridge board.
+	  Please say Y if you have such hardware
+
 endmenu
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index d1db90688a150fdc3a5fd40acebe740798c452b0..3caa4d8f71675804328aa5a51ec67b2587938621 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -48,3 +48,4 @@ obj-$(CONFIG_DRM_ITE_IT6263) += it6263.o
 obj-$(CONFIG_DRM_ITE_IT6161) += it6161.o
 obj-$(CONFIG_DRM_SEC_MIPI_DSIM) += sec-dsim.o
 obj-$(CONFIG_DRM_NXP_SEIKO_43WVFIG) += nxp-seiko-43wvfig.o
+obj-$(CONFIG_DRM_WAVESHARE_BRIDGE) += waveshare-dsi.o
diff --git a/drivers/gpu/drm/bridge/waveshare-dsi.c b/drivers/gpu/drm/bridge/waveshare-dsi.c
new file mode 100644
index 0000000000000000000000000000000000000000..efb3a2fc501b5725b02f49862526d1704a3a4b7b
--- /dev/null
+++ b/drivers/gpu/drm/bridge/waveshare-dsi.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright 2025 NXP
+ * Based on panel-raspberrypi-touchscreen by Broadcom
+ */
+
+#include <linux/backlight.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/regmap.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
+struct ws_bridge {
+	struct drm_bridge bridge;
+	struct drm_bridge *next_bridge;
+	struct backlight_device *backlight;
+	struct device *dev;
+	struct regmap *reg_map;
+};
+
+static const struct regmap_config ws_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xff,
+	.disable_debugfs = true,
+};
+
+static struct ws_bridge *bridge_to_ws_bridge(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct ws_bridge, bridge);
+}
+
+static int ws_bridge_attach_dsi(struct ws_bridge *ws)
+{
+	struct device_node *dsi_host_node;
+	struct mipi_dsi_host *host;
+	struct mipi_dsi_device *dsi;
+	const struct mipi_dsi_device_info info = {
+		.type = "ws-bridge",
+		.channel = 0,
+		.node = NULL,
+	};
+	struct device *dev = ws->dev;
+	int ret;
+
+	dsi_host_node = of_graph_get_remote_node(dev->of_node, 0, 0);
+	if (!dsi_host_node) {
+		dev_err(dev, "Failed to get remote port\n");
+		return -ENODEV;
+	}
+
+	host = of_find_mipi_dsi_host_by_node(dsi_host_node);
+
+	of_node_put(dsi_host_node);
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to find dsi_host\n");
+
+	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
+
+	if (IS_ERR(dsi))
+		return dev_err_probe(dev, PTR_ERR(dsi), "Failed to create dsi device\n");
+
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 2;
+
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to attach dsi to host\n");
+
+	return 0;
+}
+
+static int ws_bridge_bridge_attach(struct drm_bridge *bridge,
+				   enum drm_bridge_attach_flags flags)
+{
+	struct ws_bridge *ws = bridge_to_ws_bridge(bridge);
+	int ret;
+
+	ret = ws_bridge_attach_dsi(ws);
+	if (ret)
+		return ret;
+
+	return drm_bridge_attach(ws->bridge.encoder, ws->next_bridge,
+				 &ws->bridge, flags);
+}
+
+static void ws_bridge_bridge_enable(struct drm_bridge *bridge)
+{
+	struct ws_bridge *ws = bridge_to_ws_bridge(bridge);
+
+	regmap_write(ws->reg_map, 0xad, 0x01);
+	backlight_enable(ws->backlight);
+}
+
+static void ws_bridge_bridge_disable(struct drm_bridge *bridge)
+{
+	struct ws_bridge *ws = bridge_to_ws_bridge(bridge);
+
+	backlight_disable(ws->backlight);
+	regmap_write(ws->reg_map, 0xad, 0x00);
+}
+
+static const struct drm_bridge_funcs ws_bridge_bridge_funcs = {
+	.enable = ws_bridge_bridge_enable,
+	.disable = ws_bridge_bridge_disable,
+	.attach = ws_bridge_bridge_attach,
+};
+
+static int ws_bridge_bl_update_status(struct backlight_device *bl)
+{
+	struct ws_bridge *ws = bl_get_data(bl);
+
+	regmap_write(ws->reg_map, 0xab, 0xff - backlight_get_brightness(bl));
+	regmap_write(ws->reg_map, 0xaa, 0x01);
+
+	return 0;
+}
+
+static const struct backlight_ops ws_bridge_bl_ops = {
+	.update_status = ws_bridge_bl_update_status,
+};
+
+static struct backlight_device *ws_bridge_create_backlight(struct ws_bridge *ws)
+{
+	struct device *dev = ws->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = 255,
+		.max_brightness = 255,
+	};
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, ws,
+					      &ws_bridge_bl_ops, &props);
+}
+
+static int ws_bridge_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct ws_bridge *ws;
+	struct drm_panel *panel;
+	int ret;
+	struct backlight_device *backlight;
+
+	ws = devm_kzalloc(dev, sizeof(*ws), GFP_KERNEL);
+	if (!ws)
+		return -ENOMEM;
+
+	ws->dev = dev;
+
+	ws->reg_map = devm_regmap_init_i2c(i2c, &ws_regmap_config);
+	if (IS_ERR(ws->reg_map))
+		return dev_err_probe(dev, PTR_ERR(ws->reg_map), "Failed to allocate regmap\n");
+
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, -1, &panel, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to find remote panel\n");
+
+	ws->next_bridge = devm_drm_panel_bridge_add(dev, panel);
+	if (IS_ERR(ws->next_bridge))
+		return PTR_ERR(ws->next_bridge);
+
+	ws->backlight = ws_bridge_create_backlight(ws);
+	if (IS_ERR(backlight)) {
+		ret = PTR_ERR(backlight);
+		dev_err(dev, "Failed to create backlight: %d\n", ret);
+		return ret;
+	}
+
+	regmap_write(ws->reg_map, 0xc0, 0x01);
+	regmap_write(ws->reg_map, 0xc2, 0x01);
+	regmap_write(ws->reg_map, 0xac, 0x01);
+
+	ws->bridge.funcs = &ws_bridge_bridge_funcs;
+	ws->bridge.type = DRM_MODE_CONNECTOR_DPI;
+	ws->bridge.of_node = dev->of_node;
+	devm_drm_bridge_add(dev, &ws->bridge);
+
+	return 0;
+}
+
+static const struct of_device_id ws_bridge_of_ids[] = {
+	{.compatible = "waveshare,dsi2dpi",},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, ws_bridge_of_ids);
+
+static struct i2c_driver ws_bridge_driver = {
+	.driver = {
+		.name = "ws_dsi2dpi",
+		.of_match_table = ws_bridge_of_ids,
+	},
+	.probe = ws_bridge_probe,
+};
+module_i2c_driver(ws_bridge_driver);
+
+MODULE_AUTHOR("Joseph Guo <qijian.guo@nxp.com>");
+MODULE_DESCRIPTION("Waveshare DSI2DPI bridge driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1



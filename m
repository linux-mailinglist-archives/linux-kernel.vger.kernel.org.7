Return-Path: <linux-kernel+bounces-862317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA88BF4FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0E104F586A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1090283151;
	Tue, 21 Oct 2025 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VfPFD/Ip"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86324678F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032075; cv=none; b=fWrmkOB+q9Lvl/m5Z5M/WoxfAPRJhA8u7IHsSqzyspBHvjM61kjZ/xxYCtdPKjTc7YUmF1lk5Cyh1/8wGZqBD7Y13ID6L1D7RqF8kO0J71RIbSYS7gK0OBWWIgp8xh9NSjElU1MxJJjftY1chotZX56MbXuWejsyialEEBLNb/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032075; c=relaxed/simple;
	bh=VWcsQQmtMMPprJYFhwx9LBpXMjquD6WWswAcguEEYnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtQGL9+WFQBque4Ih13xXjOgucey3Br/arpKUg+HQlMK6R1meWqKLGnvdUYQgScyaa5w4k/LR7o67v52KbWuIo3oSkPy8Xj70cDXxNivd9vz5arvnbi3DC8vuAOcFKtcM0hiqpykF4mjvhqm1EEriM3vyhMWFitBZf6L9Kcr9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VfPFD/Ip; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C51BE4E4123A;
	Tue, 21 Oct 2025 07:34:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9B85F606DC;
	Tue, 21 Oct 2025 07:34:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D373102F23F0;
	Tue, 21 Oct 2025 09:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761032070; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=z+kgTQOFPEDg9FXXA69hvmT2E05f/I1KjA7iDvn7ytE=;
	b=VfPFD/IpvEJY0YfN21snvcb4YRxewqOfLQv4SmHueocAbm8wnJJLbezfOBMTXKrCbO381G
	CZg8ZUfD8NpBy83kXXsv//DgvSTrOpG7J4HgjKL3HccybaZ/sgRZ3KJ9GN5zAaThCmhvbo
	Nisx4ZKJsAQ3c+u4pcD914p3gSVO3mN2TgX1YVS7UkkZfoUE+UvBG47nZ9ssW9LfFl7cVB
	O+waUV4FN6MdsAqI0SwuA8fC01fppVJYZGFXeJuyDG8jppEkAQeCVbg9R4/2rpUJuOlbxu
	/chP/9ACj5RJqWTRtLV2KUYK9MNShUf9msnVHUMYSCpJNuVlCdinveehlPFnyg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/3] drm/panel: Add support for the Leadtek LTK08QV25BYL panel
Date: Tue, 21 Oct 2025 09:34:04 +0200
Message-ID: <20251021073408.195959-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021073408.195959-1-herve.codina@bootlin.com>
References: <20251021073408.195959-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Leadtek LTK08QV25BYL is a 2.8" 240x320 DSI display.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  12 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-leadtek-ltk028qv25byl.c   | 304 ++++++++++++++++++
 3 files changed, 317 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 407c5f6a268b..faa417195b6e 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -367,6 +367,18 @@ config DRM_PANEL_KINGDISPLAY_KD097D04
 	  24 bit RGB per pixel. It provides a MIPI DSI interface to
 	  the host and has a built-in LED backlight.
 
+config DRM_PANEL_LEADTEK_LTK028QV25BYL
+	tristate "Leadtek LTK028QV25BYL panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for Leadtek LTK028QV25BYL
+	  TFT-LCD modules. The panel has a 240x320 resolution and uses
+	  18 bit RGB per pixel. It provides a MIPI DSI interface to
+	  the host and has a built-in LED backlight.
+
+
 config DRM_PANEL_LEADTEK_LTK050H3146W
 	tristate "Leadtek LTK050H3146W panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 3615a761b44f..12073c34e0f5 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_DRM_PANEL_JDI_LPM102A188A) += panel-jdi-lpm102a188a.o
 obj-$(CONFIG_DRM_PANEL_JDI_R63452) += panel-jdi-fhd-r63452.o
 obj-$(CONFIG_DRM_PANEL_KHADAS_TS050) += panel-khadas-ts050.o
 obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) += panel-kingdisplay-kd097d04.o
+obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK028QV25BYL) += panel-leadtek-ltk028qv25byl.o
 obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) += panel-leadtek-ltk050h3146w.o
 obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) += panel-leadtek-ltk500hd1829.o
 obj-$(CONFIG_DRM_PANEL_LINCOLNTECH_LCD197) += panel-lincolntech-lcd197.o
diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c b/drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c
new file mode 100644
index 000000000000..2e3482b2b95c
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Leadtek LTK08QV25BYL 2.8" MIPI-DSI panel driver
+ * Copyright (c) 2025, Bootlin
+ *
+ * base on panel-leadtek-ltk050h346w.c
+ * Copyright (C) 2020 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+struct ltk028qv25byl {
+	struct device *dev;
+	struct drm_panel panel;
+	struct gpio_desc *reset_gpio;
+	struct regulator *vci;
+	struct regulator *iovcc;
+};
+
+static inline struct ltk028qv25byl *panel_to_ltk028qv25byl(struct drm_panel *panel)
+{
+	return container_of(panel, struct ltk028qv25byl, panel);
+}
+
+static int ltk028qv25byl_init_sequence(struct ltk028qv25byl *ctx)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+
+	/*
+	 * Init sequence was supplied by the panel vendor. All documentation
+	 * provided by the vendor (i.e comments in the provided init sequence)
+	 * is also given here as comments without modification.
+	 */
+
+	/* Password */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xdf, 0x98, 0x51, 0xe9);
+
+	/* Page 0 */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde, 0x00);
+
+	/* VGMP, VGSP, VGMN, VGSN 4.3 */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb7, 0x1e, 0x85, 0x1e, 0x33);
+
+	/* Set_R_GAMMA */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x3f, 0x2e, 0x25, 0x21, 0x23,
+				     0x25, 0x1f, 0x1e, 0x1c, 0x1b, 0x19, 0x11,
+				     0x0e, 0x0a, 0x06, 0x0e, 0x3f, 0x2e, 0x26,
+				     0x21, 0x24, 0x25, 0x1f, 0x1f, 0x1d, 0x1c,
+				     0x19,  0x11,  0x0e,  0x0a,  0x06,  0x0e);
+
+	/* POW_CTRL */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x33, 0x08, 0xcc);
+
+	/* DCDC_SEL */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbb, 0x44, 0x7a, 0x30, 0x40, 0x7c,
+				     0x60, 0x70, 0x70);
+
+	/* VDD_CTRL */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbc, 0x38, 0x3c);
+
+	/* SETSTBA */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0x31, 0x20);
+
+	/* SETPANEL(default) */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x12);
+
+	/* SETRGBCYC */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x08, 0x00, 0x0a, 0x10, 0x08,
+				     0x54, 0x45, 0x71, 0x2c);
+
+	/* SETRGBCYC(default) */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x00, 0xa0, 0x79, 0x0e, 0x0a,
+				     0x16, 0x79, 0x0e, 0x0a, 0x16, 0x79, 0x0e,
+				     0x0a, 0x16, 0x82, 0x00, 0x03);
+
+	/* SET_GD(default) */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd0, 0x04, 0x0c, 0x6a, 0x0f, 0x00, 0x03);
+
+	/* RAMCTRL(default) */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx,  0xd7,  0x13,  0x00);
+
+	/* Page 2 */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx,  0xde,  0x02);
+
+	/* DCDC_SET */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x1d, 0xa0, 0x2f, 0x2c, 0x2b);
+
+	/* SETRGBCYC2 */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x10, 0x66, 0x66, 0x01);
+
+	/* Page 0 */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde, 0x00);
+
+	/* SLPOUT  + 120ms delay */
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	/* Page 2 */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde,  0x02);
+
+	/* OSCM */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc5, 0x4e, 0x00, 0x00);
+
+	/* SETMIPI_2 */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0x30, 0x20, 0xf4);
+
+	/* Page 4 */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde, 0x04);
+
+	/* SETPHY3 */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd3, 0x3c);
+
+	/* Page 0 */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde, 0x00);
+
+	/* Display on + 20ms delay */
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	return dsi_ctx.accum_err;
+}
+
+static int ltk028qv25byl_unprepare(struct drm_panel *panel)
+{
+	struct ltk028qv25byl *ctx = panel_to_ltk028qv25byl(panel);
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
+	regulator_disable(ctx->iovcc);
+	regulator_disable(ctx->vci);
+
+	return 0;
+}
+
+static int ltk028qv25byl_prepare(struct drm_panel *panel)
+{
+	struct ltk028qv25byl *ctx = panel_to_ltk028qv25byl(panel);
+	int ret;
+
+	ret = regulator_enable(ctx->vci);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to enable vcc supply (%d)\n", ret);
+		return ret;
+	}
+	ret = regulator_enable(ctx->iovcc);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to enable iovcc supply (%d)\n", ret);
+		goto disable_vci;
+	}
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	msleep(20);
+
+	ret = ltk028qv25byl_init_sequence(ctx);
+	if (ret)
+		goto force_reset;
+
+	return 0;
+
+force_reset:
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	regulator_disable(ctx->iovcc);
+disable_vci:
+	regulator_disable(ctx->vci);
+	return ret;
+}
+
+static const struct drm_display_mode ltk028qv25byl_mode = {
+	.hdisplay       = 240,
+	.hsync_start    = 240 + 120,
+	.hsync_end      = 240 + 120 + 4,
+	.htotal         = 240 + 120 + 4 + 120,
+	.vdisplay       = 320,
+	.vsync_start    = 320 + 8,
+	.vsync_end      = 320 + 8 + 2,
+	.vtotal         = 320 + 8 + 2 + 6,
+	.clock          = 10000000 / 1000,
+	.flags          = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+	.width_mm       = 45,
+	.height_mm      = 62,
+};
+
+static int ltk028qv25byl_get_modes(struct drm_panel *panel,
+				   struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &ltk028qv25byl_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	connector->display_info.width_mm = mode->width_mm;
+	connector->display_info.height_mm = mode->height_mm;
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs ltk028qv25byl_funcs = {
+	.unprepare = ltk028qv25byl_unprepare,
+	.prepare = ltk028qv25byl_prepare,
+	.get_modes = ltk028qv25byl_get_modes,
+};
+
+static int ltk028qv25byl_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct ltk028qv25byl *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
+				   &ltk028qv25byl_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset gpio\n");
+
+	ctx->vci = devm_regulator_get(dev, "vci");
+	if (IS_ERR(ctx->vci))
+		return dev_err_probe(dev, PTR_ERR(ctx->vci),
+				     "Failed to get vcc regulator\n");
+
+	ctx->iovcc = devm_regulator_get(dev, "iovcc");
+	if (IS_ERR(ctx->iovcc))
+		return dev_err_probe(dev, PTR_ERR(ctx->iovcc),
+				     "Failed to get iovcc regulator\n");
+
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	ctx->dev = dev;
+
+	dsi->lanes = 1;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET;
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return ret;
+
+	drm_panel_add(&ctx->panel);
+
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0) {
+		drm_panel_remove(&ctx->panel);
+		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
+	}
+
+	return 0;
+}
+
+static void ltk028qv25byl_remove(struct mipi_dsi_device *dsi)
+{
+	struct ltk028qv25byl *ctx = mipi_dsi_get_drvdata(dsi);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id ltk028qv25byl_of_match[] = {
+	{ .compatible = "leadtek,ltk028qv25byl" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ltk028qv25byl_of_match);
+
+static struct mipi_dsi_driver ltk028qv25byl_driver = {
+	.driver = {
+		.name = "panel-leadtek-ltk028qv25byl",
+		.of_match_table = ltk028qv25byl_of_match,
+	},
+	.probe	= ltk028qv25byl_probe,
+	.remove = ltk028qv25byl_remove,
+};
+module_mipi_dsi_driver(ltk028qv25byl_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("DRM driver for Leadtek LTK028QV25BYL MIPI DSI panel");
+MODULE_LICENSE("GPL");
-- 
2.51.0



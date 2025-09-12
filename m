Return-Path: <linux-kernel+bounces-813284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066F9B54321
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64F2AA19F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F4B296BDE;
	Fri, 12 Sep 2025 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkA8Cewh"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3313285C98
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659404; cv=none; b=ZA0qHS8giAyTsEIQA6jNYyIlQtMpE8B3JVtnhCg4Muk8oiRD5Ve51Vt0aFYMoIytRGYDPd+fXfYViU83ajlcKYBN5/Iz80Bu3Ss+bP8DMc/Axy3Cb0imuFGXHgrbxxwEQiEdMFvbplinfQhsa+IltZEVAczDNlK2TWZsuyv9D2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659404; c=relaxed/simple;
	bh=TGYboeqNo3SZSBH2Smduu+OOjFH3M1jhGll/No5dNcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciDSjHv/7cCLdecI6x0THJBfeqNb53iBIeh3YWft946NApKdzSIdOLz2kIlLqtDsZ5nZOlP2a9Cvq9WvZBlG2MwFEgDgwgxF9KKV2Tqi5TmA1CqS5i/4wHoyeee2UThTRf26Jg60ylUiosHjO2xD8j0NR1IvtPZhgSY2GpGy+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkA8Cewh; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so1529558e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659401; x=1758264201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3P046ExiqSt0dhR7HxTwDiLPsz73i1JrV/6JS498U/E=;
        b=nkA8CewhUIgx/usjoYrjKhKld8TCjaAE1F/PB96ARiQwiLXuS76zGdzqouCxykIpi/
         L0H8hz28NvR4Xnu/nkbRW/QokBTmFS3qjImuab5OGdosEZ8nw3xpZg31AEDRWi8CUFCa
         9QcEgPJKSp28/PPgYSrnsbmdTmyg/MBia2Kv2P60oV7e1MznrThEvvn0ge+09CtATId2
         M8JEKeUiadYcdzzBt7zI7FjOXAaVKIcUMqfkRs5rIE5fAKiWcctCxHPlJqiA2lg+x2Al
         AcclvBPu+V3NnGjh6GlSrqtrA7NuN/9+AreoIwTaebwP97tw0FpCbSmn7CuzTmZ0jnfE
         +eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659401; x=1758264201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3P046ExiqSt0dhR7HxTwDiLPsz73i1JrV/6JS498U/E=;
        b=f+W/p44YmP4c0mjyrNSipr0fQyi34TYqsr77ipi/tW0W2Av4znq8aAtGUAYY/8IYwD
         oFVXRf99Zl5/qfTauThCxw79d2TMyihVLHIkf/GW3c7zGOJBLsh2nxYkV9CK6RlZbZYD
         414dX+oohk+GQH+sHKXxecSl1CafWrTVM9XnEm8tzY3ESA3NZymyafY30sLyN/gZwKpv
         VTQUaLHJT+CJSZ0E+ngF/5xkribvrKpacccAnSZbT+7yACYIxAVQCNt06Jx95mxXqofP
         AEO+iM8xQpH/15TWmuqlZIChD/mflTwToJG6d9RRy9+Li25u6ra+PvST4IPEvPPIOnm2
         JviQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbgGryUNfM5TDBh+PpbvFb1W/1vPYbZlru+VD3RZoi7GZjmVw82vkXEvW86cOXseN80drDbYBXszHK8Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6C5EYezrxdk7z9iTjvJU2cjgTI5pZVKJUexBnxXjsuITUeyN
	DrDyr+k6w2EvaCU1trjQKtynR7fz2qMZK/WW1JfKdgNS2rcjkEjVfKBN
X-Gm-Gg: ASbGncs0dMGZ+dUzxo00ra7+0pPLXCLj9aVx6sVB6xe9AFoVok6J6luIW2DFIXrmAY5
	yyj8s9AlHTAv8HM3ddbGb25Wfnl399R1V0Z5XjzTDiFrmLU0JIuz5LFkbsi1TyuPX9Bx2BB2ryj
	5PpfoOZO+dBTNzxS79PJ8OTjx1kOG7fskDT145wlt+S8mllp3IXOTWtFVmWpKGiHK+iNL2AM8R4
	MZZQHKIG53QrwXx76oyMIdYeKLrkH46l33611Nx1LpJV8lDDm0wr3QuVs0hhOzsmtZQhbSOhu9p
	2UVY1W0+vGM/V1a/EbHuz7aYQ7eF/tFrFx+wboyviVKXZ8BfaXGKrTC0hPy8yGOPTWJuyR/g1JH
	5DmIuEWdQk4lKVX29y9RkNAXF
X-Google-Smtp-Source: AGHT+IGhqp4JsrCoDF2N+iHFyxeFf/WpwBUR4XG+lmFA7BGhK+mqUolgLmiQfsoc9YLRP5nyx11QPw==
X-Received: by 2002:a05:6512:b89:b0:55c:d5f8:787c with SMTP id 2adb3069b0e04-5704f5a7c90mr656997e87.54.1757659400507;
        Thu, 11 Sep 2025 23:43:20 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e64bd15e6sm917403e87.116.2025.09.11.23.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:43:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] gpu/drm: panel: Add Sharp LQ079L1SX01 panel support
Date: Fri, 12 Sep 2025 09:42:53 +0300
Message-ID: <20250912064253.26346-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250912064253.26346-1-clamor95@gmail.com>
References: <20250912064253.26346-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This panel requires dual-channel mode. The device accepts video-mode data
on 8 lanes and will therefore need a dual-channel DSI controller. The two
interfaces that make up this device need to be instantiated in the
controllers that gang up to provide the dual-channel DSI host.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  15 ++
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-sharp-lq079l1sx01.c   | 233 ++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-sharp-lq079l1sx01.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index aad4e0da8f75..51f3bd2d3048 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -841,6 +841,21 @@ config DRM_PANEL_SEIKO_43WVF1G
 	  Say Y here if you want to enable support for the Seiko
 	  43WVF1G controller for 800x480 LCD panels
 
+config DRM_PANEL_SHARP_LQ079L1SX01
+	tristate "Sharp LQ079L1SX01 panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	select VIDEOMODE_HELPERS
+	help
+	  Say Y here if you want to enable support for Sharp LQ079L1SX01
+	  TFT-LCD modules. The panel has a 2560x1600 resolution and uses
+	  24 bit RGB per pixel. It provides a dual MIPI DSI interface to
+	  the host.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called panel-sharp-lq079l1sx01.
+
 config DRM_PANEL_SHARP_LQ101R1SX01
 	tristate "Sharp LQ101R1SX01 panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index a6a100e4c4e6..166d1969d024 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01) += panel-samsung-s6e88a0-ams4
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_SOFEF00) += panel-samsung-sofef00.o
 obj-$(CONFIG_DRM_PANEL_SEIKO_43WVF1G) += panel-seiko-43wvf1g.o
+obj-$(CONFIG_DRM_PANEL_SHARP_LQ079L1SX01) += panel-sharp-lq079l1sx01.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LS043T1LE01) += panel-sharp-ls043t1le01.o
diff --git a/drivers/gpu/drm/panel/panel-sharp-lq079l1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq079l1sx01.c
new file mode 100644
index 000000000000..5b516ba6c132
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-sharp-lq079l1sx01.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2016 XiaoMi, Inc.
+ * Copyright (c) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+static const struct regulator_bulk_data sharp_supplies[] = {
+	{ .supply = "avdd" }, { .supply = "vddio" },
+	{ .supply = "vsp" }, { .supply = "vsn" },
+};
+
+struct sharp_panel {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi[2];
+
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data *supplies;
+
+	const struct drm_display_mode *mode;
+};
+
+#define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, cmd, seq...)	\
+		do {								\
+			dsi_ctx.dsi = dsi0;					\
+			mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);	\
+			dsi_ctx.dsi = dsi1;					\
+			mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);	\
+		} while (0)
+
+static inline struct sharp_panel *to_sharp_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct sharp_panel, panel);
+}
+
+static void sharp_panel_reset(struct sharp_panel *sharp)
+{
+	gpiod_set_value_cansleep(sharp->reset_gpio, 1);
+	usleep_range(2000, 3000);
+	gpiod_set_value_cansleep(sharp->reset_gpio, 0);
+	usleep_range(2000, 3000);
+}
+
+static int sharp_panel_prepare(struct drm_panel *panel)
+{
+	struct sharp_panel *sharp = to_sharp_panel(panel);
+	struct device *dev = panel->dev;
+	struct mipi_dsi_device *dsi0 = sharp->dsi[0];
+	struct mipi_dsi_device *dsi1 = sharp->dsi[1];
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = NULL };
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(sharp_supplies), sharp->supplies);
+	if (ret) {
+		dev_err(dev, "error enabling regulators (%d)\n", ret);
+		return ret;
+	}
+
+	msleep(24);
+
+	if (sharp->reset_gpio)
+		sharp_panel_reset(sharp);
+
+	msleep(32);
+
+	mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, MIPI_DCS_EXIT_SLEEP_MODE);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1,
+					  MIPI_DCS_SET_DISPLAY_BRIGHTNESS, 0xff);
+	mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1,
+					  MIPI_DCS_WRITE_POWER_SAVE, 0x01);
+	mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1,
+					  MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x2c);
+
+	mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, MIPI_DCS_SET_DISPLAY_ON);
+
+	return 0;
+}
+
+static int sharp_panel_unprepare(struct drm_panel *panel)
+{
+	struct sharp_panel *sharp = to_sharp_panel(panel);
+	struct mipi_dsi_device *dsi0 = sharp->dsi[0];
+	struct mipi_dsi_device *dsi1 = sharp->dsi[1];
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = NULL };
+
+	mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, MIPI_DCS_SET_DISPLAY_OFF);
+	mipi_dsi_msleep(&dsi_ctx, 100);
+	mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, MIPI_DCS_ENTER_SLEEP_MODE);
+	mipi_dsi_msleep(&dsi_ctx, 150);
+
+	if (sharp->reset_gpio)
+		gpiod_set_value_cansleep(sharp->reset_gpio, 1);
+
+	return regulator_bulk_disable(ARRAY_SIZE(sharp_supplies), sharp->supplies);
+}
+
+static const struct drm_display_mode default_mode = {
+	.clock = (1536 + 136 + 28 + 28) * (2048 + 14 + 8 + 2) * 60 / 1000,
+	.hdisplay = 1536,
+	.hsync_start = 1536 + 136,
+	.hsync_end = 1536 + 136 + 28,
+	.htotal = 1536 + 136 + 28 + 28,
+	.vdisplay = 2048,
+	.vsync_start = 2048 + 14,
+	.vsync_end = 2048 + 14 + 8,
+	.vtotal = 2048 + 14 + 8 + 2,
+	.width_mm = 120,
+	.height_mm = 160,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int sharp_panel_get_modes(struct drm_panel *panel,
+				 struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &default_mode);
+}
+
+static const struct drm_panel_funcs sharp_panel_funcs = {
+	.unprepare = sharp_panel_unprepare,
+	.prepare = sharp_panel_prepare,
+	.get_modes = sharp_panel_get_modes,
+};
+
+static int sharp_panel_probe(struct mipi_dsi_device *dsi)
+{
+	const struct mipi_dsi_device_info info = { "sharp-link1", 0, NULL };
+	struct device *dev = &dsi->dev;
+	struct device_node *dsi_r;
+	struct mipi_dsi_host *dsi_r_host;
+	struct sharp_panel *sharp;
+	int i, ret;
+
+	sharp = devm_drm_panel_alloc(dev, struct sharp_panel, panel,
+				     &sharp_panel_funcs, DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(sharp))
+		return PTR_ERR(sharp);
+
+	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(sharp_supplies),
+					    sharp_supplies, &sharp->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get supplies\n");
+
+	sharp->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(sharp->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(sharp->reset_gpio),
+				     "failed to get reset GPIO\n");
+
+	/* Panel is always connected to two DSI hosts, DSI0 is left, DSI1 is right */
+	dsi_r = of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
+	if (!dsi_r)
+		return dev_err_probe(dev, -ENODEV, "failed to find second DSI host node\n");
+
+	dsi_r_host = of_find_mipi_dsi_host_by_node(dsi_r);
+	of_node_put(dsi_r);
+	if (!dsi_r_host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "cannot get secondary DSI host\n");
+
+	sharp->dsi[1] = devm_mipi_dsi_device_register_full(dev, dsi_r_host, &info);
+	if (IS_ERR(sharp->dsi[1]))
+		return dev_err_probe(dev, PTR_ERR(sharp->dsi[1]),
+				     "second link registration failed\n");
+
+	sharp->dsi[0] = dsi;
+	mipi_dsi_set_drvdata(dsi, sharp);
+
+	ret = drm_panel_of_backlight(&sharp->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+
+	drm_panel_add(&sharp->panel);
+
+	for (i = 0; i < ARRAY_SIZE(sharp->dsi); i++) {
+		if (!sharp->dsi[i])
+			continue;
+
+		sharp->dsi[i]->lanes = 4;
+		sharp->dsi[i]->format = MIPI_DSI_FMT_RGB888;
+		sharp->dsi[i]->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
+
+		ret = devm_mipi_dsi_attach(dev, sharp->dsi[i]);
+		if (ret < 0) {
+			drm_panel_remove(&sharp->panel);
+			return dev_err_probe(dev, ret, "failed to attach to DSI%d\n", i);
+		}
+	}
+
+	return 0;
+}
+
+static void sharp_panel_remove(struct mipi_dsi_device *dsi)
+{
+	struct sharp_panel *sharp = mipi_dsi_get_drvdata(dsi);
+
+	drm_panel_remove(&sharp->panel);
+}
+
+static const struct of_device_id sharp_of_match[] = {
+	{ .compatible = "sharp,lq079l1sx01" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sharp_of_match);
+
+static struct mipi_dsi_driver sharp_panel_driver = {
+	.driver = {
+		.name = "panel-sharp-lq079l1sx01",
+		.of_match_table = sharp_of_match,
+	},
+	.probe = sharp_panel_probe,
+	.remove = sharp_panel_remove,
+};
+module_mipi_dsi_driver(sharp_panel_driver);
+
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("Sharp LQ079L1SX01 panel driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1



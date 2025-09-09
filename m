Return-Path: <linux-kernel+bounces-807404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52147B4A3F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1C1541B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6D30ACF3;
	Tue,  9 Sep 2025 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLFeEq76"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151363093B2;
	Tue,  9 Sep 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403528; cv=none; b=bjXFledZTTXQQdcnOAoXZqzSRa4TxBxtJlaz4GxrbZiuC/cMn5HAEGI7CMcJHd0I8G00mc215gxAF++g7PSvZxDGmDLabtjG01wKVVzxaNtDewUpzk1oPagVFYAQbMfrWT+6dRwnHuogNnlSR2ogFS6RsjoFB5s3UoBmCHpbVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403528; c=relaxed/simple;
	bh=emVvBHfqWbjh/TPffNovN39uCyWMiF9ttD3XidlG51Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXeq5iP/h15+dWUOFXgAY520qa1C3q7LhHZ4JU3RwIwFN5Z8E1FjYmrErYibS84+3KwkRUanH4SO/Ynh/7k/wTlm8H9ROw/Fk3ZoWTogogniBqgbw4KHau2IrHOVJ5UOo03Dt/q03zoRlZ8XoxubtfNXkH1e1PZTO9dUh9BK3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLFeEq76; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-560880bb751so5296677e87.3;
        Tue, 09 Sep 2025 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757403524; x=1758008324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOZVpbVl5rqwnG97iPPBtlhSFXm5i0T7JrmpKEWQy4Q=;
        b=CLFeEq76VRmpi3EfVYLRLXmhtOJbQ+2mE8lI559jrz9V7+f/LFLyoS/9oIqgmXeryu
         UKhndzHZXeF9Xh+XAU2yWninAatlzEi49D9lqsGygCW3OZB13uHRAP6rM/055lUOJVBI
         ybD0iXi8tv6LHPHeeic56djCkehGTq2a1oH/MoYf0UwlxKkU6iE5c/u7Ew0zHbLv3vaU
         JTQDv3lSD1ILRjxuQAiVdFvOAipVKGV9ivyYXCF/EpWO/N4BOUOLRZck5ELQM2UqA+FW
         1XPurdz65VIUcgNgndUIJcFovNWgv9Zr5D+eYTu90zFRLhDJsZki01Ls8QoLeAb52ZYH
         pUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403524; x=1758008324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOZVpbVl5rqwnG97iPPBtlhSFXm5i0T7JrmpKEWQy4Q=;
        b=BFJ+vNSl1i3RElD9VYDpPGka5Hxoi2kyVVAZ9fPz2oVDw2km/BSh8R+jJbuwTjWOOY
         GPN/6kdI7hQtSCvImd+F/7wFkD+yDtY0IVmVI22LiHBCq1bysJ4cSDNomBHTCltZXtxj
         uO6OCpb5z7A+0Yd/pNzHOCj5u2YW9+XDjN4AlL3L+tthcJ94Flbb/FoR8z0c9ZLXgK7s
         +oSGKAUl1/h7SaF4mvS0qmpkVSKm4ri8Gw3bsM7a5e5V/6Ype/x2LPMFnVni8L7aS3YD
         svT2henpyzkl8SOjsg2cd+swS33Tz14admfzlriHGj033xSXCSAqUvPBLuRWLCXUpiPc
         Mszw==
X-Forwarded-Encrypted: i=1; AJvYcCVkSM95Ns4uxtAU8V+NjATdjCRfh9f/mcVV86vqqgIYwFua4HYtIPbJiWeLtDXPQ8G+7ziJytvhDyZW@vger.kernel.org, AJvYcCXuNSemTCzGCn3jD5dlIJ10JPDJ+W0RTkLxt4QhTPX1pu6TxoOPeGozawntYaUvKZ1B+3DG0u6BfPSkScAx@vger.kernel.org
X-Gm-Message-State: AOJu0YxYO1glXMjvM9Cubt9d65H2qWVbFRcjUXvHt+QxiqRRKZ8QNQBU
	ilvNaxZpWOWB2zRVGtt1ecWK7XNlNU9p5fNWWk13eUE0aCd8DTTQlir8
X-Gm-Gg: ASbGncskSijF3FpXMOLbm5BovA8sv+qbp6JXh0xoMA/tiPGBTEtw3xMx7ECUy+A0hdz
	kXdc3wun7PFKZUv5utBwNVUQ1O9VwrMsZLG4mF8bqWIhk0J26Ou6MiKE0wv5gIh5p7Q3ihn8zeK
	kk8KInaHLZ7jdBvHqQj2/F4qL1ZEj8Urjqko1z/sTut4TbRFoJCV6pkPeRvWtYkmGMo7cDa7TBw
	DOhSEWmzbeyjUG6dEgqNlF4di77Hq3uRYvc2XausIFn/AvGHYrTbI/ohkeRIWhJuB1ltoioi9g0
	zj0m6SIeLl3EiM3ZeB76lalAd/Ef9yIxtlLBcoNmtXZ7tChzrC+Tvb6JKL7WsA1fPb1Kr6DWAI+
	8DHzXpYb3k5UcOadIjvFVSt8t
X-Google-Smtp-Source: AGHT+IEiAhhZEeKktjYUvBBQt25bqdnRcAYNxs6E2cTMeAWljxATylD0OU0lGDfQHCIlvitEuWNl0w==
X-Received: by 2002:a05:6512:33cd:b0:55f:489d:7bd with SMTP id 2adb3069b0e04-5625d28e732mr3169417e87.0.1757403523312;
        Tue, 09 Sep 2025 00:38:43 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cfe2496sm342580e87.61.2025.09.09.00.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:38:42 -0700 (PDT)
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
Subject: [PATCH v1 2/2] drm/panel: Add Sharp LQ079L1SX01 support
Date: Tue,  9 Sep 2025 10:38:31 +0300
Message-ID: <20250909073831.91881-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909073831.91881-1-clamor95@gmail.com>
References: <20250909073831.91881-1-clamor95@gmail.com>
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
---
 drivers/gpu/drm/panel/Kconfig                 |  15 ++
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-sharp-lq079l1sx01.c   | 232 ++++++++++++++++++
 3 files changed, 248 insertions(+)
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
index 000000000000..7696dfe18e31
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-sharp-lq079l1sx01.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2014 NVIDIA Corporation
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
+	gpiod_set_value_cansleep(sharp->reset_gpio, 1);
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



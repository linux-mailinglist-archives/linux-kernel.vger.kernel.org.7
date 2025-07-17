Return-Path: <linux-kernel+bounces-735392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D694B08EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067A87BAED0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8362F7CF2;
	Thu, 17 Jul 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvR9J5G2"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB22F5C5E;
	Thu, 17 Jul 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760694; cv=none; b=BBp6Um+ONjiSz4PBQYqcUx0EEVLZEOvESaETp60Y9YKzjql6zIuDedU9Rt7wIvt+SlGXmMKbE6suj6YJHW5hecYhK2i0o+bihXWeebGwHOrP8mgO4h+N5MwTx4hUeRcadaHPRtS7TD32XJPRa0D5aMq+GLv+47288i3kKonlrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760694; c=relaxed/simple;
	bh=6cbyJby+M0s+3nPed3JjrZ9mR/x2knG7iLvpDgIyhu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9bXf3doZkPGHsGTThl5JC2t4+LH9YcWnlzUM14IkysrpryS1xbfCMh41ccSBvmWlmDghKOeZ89HqrccVcZiYH5ijUjKpDmpDFHnvdnHAS3pPeItWMLgtCm1r4tSMbSRUYte5Y+5KSp3Kiaqkuy6s2z31hSeHcChJVktcTk4Ubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvR9J5G2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b553e33e6so8839101fa.2;
        Thu, 17 Jul 2025 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752760690; x=1753365490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkyH4BjkOxSjeLn8y6BpfQkQZw8dMPRSoQq4+YQveTs=;
        b=LvR9J5G2JPm+rzZ1s/ZdpmFUHuzT/jgRyWD8VfsLwkOw04UjdK5ADqIrkwKvcOcQ7m
         0eYL9so9JrHZEGZjmQ0pFnSELdHI0wt/CR1EVl62iqL+VDMQQ/LpFLWG+7ZM9//McKUF
         odLRguHQEpcpwXyIu0NkOdoXSNxS2ZByZ5hJCeJ67uEYbztIZWKK9gMV1lOR8bijxybn
         jem2c7zjY2DjK4fQuKmcVTMK0qnsc0ZFgEw23+tdxeGsCoD4TB10GvLCGUFIrxntLMa3
         ORjUc4Nix2tROwZpSGN1WwCRM2HUlE9MzGHckiW05ujVJYJM0gC76pzBlOcOVMgKWmsQ
         JahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760690; x=1753365490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkyH4BjkOxSjeLn8y6BpfQkQZw8dMPRSoQq4+YQveTs=;
        b=CASSL1KoUmtk9TD43SMTvUlP4CsK/JuVjKTQrUHfCo0ZN+xF5esz9PLYj4rlBKLTmA
         rfwcCPWgDt7izPb02tExiu3lhwi6cNbxTcdghSJVKudCm5oN49Eb3htev6Oq8yy8MyPq
         wk/InWVb6tXNqcSKORRRcBvCW7+/QYns2Z4T2qA5z2sj/GFSYulaWRzfQlI+xhAn72Eu
         Sz4XmthGZx0UI7iFC7mnLNt/nHb5PftmzLh68xb0oeaNZh/7ihZvc4k4zHosVBQocK3o
         jr2bIof84OGkEzivkdhL+Oa2fxySl4xv29omTg5Ka7WEgFoFz0MQRqOltJK8icyVRuxu
         Wfow==
X-Forwarded-Encrypted: i=1; AJvYcCUtQn3k39vNs3oVakC+E9FLFEvaMkGWsAmQOoS62cGzyzB3e0go6sPCBvi378e6ybqKbgmgM2h+RXXL@vger.kernel.org, AJvYcCXutF5EtADVG1NvOty1MXWZ+JLzgSJ1qo+wCJb396qHQkRV8LoHwQNogXK7lzHG8+WZ9NgmI6Op8vIwEY43@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40PzKQL5Sq6fGDiyyN94r01Z5SyWe2EG1Klubg6am3ZYw+Nvd
	qloGsL+LA3TybBGDXkaP8SP1Y6PWDRFVS0EpU8HDaluaEnvqqhXsnPvz
X-Gm-Gg: ASbGncsygHT9mGu0XP0j8oDnJl1rNpGjEXiJLYGSAN5ZnY1bccoh47YpDr7QM7vLwcC
	4lfVpPgTSApWH2L4Onqn9MVLP4004cvLXq/29RVf2XRknPIAco9ZnsPHUz0iuNp9H7NqSa0DEMe
	Qqa1QdNTsVjsxM9nX5OllRMvh/v6yvN+f1JdR0IRP2RkjxudHG/LRcmjWVWpTW4REsVwRZrBZJm
	F8XJ1JUenVQfnbdFr+cBZb/SPbf/ZQSIZ/JM+2+YjEkXvJUl5TQMzY/dbeNF3Uz0KIOyMot+/Qr
	f5xe6ZyQEvHCgwXdZDY5yFr3/bSE0TmaxvCqcTQGGzdcE6cA7cr3QtgU/Pmlku3V2NWbJaUaXiN
	5hFlbYj2147/gww==
X-Google-Smtp-Source: AGHT+IFruvdf++zeyKRK4ktDKT2siirwv2iVqlOwOgtCqSgrzV1R/UzMe3QgTKUKppZDqCCQ76IEtQ==
X-Received: by 2002:a05:651c:54a:b0:32a:7122:58d8 with SMTP id 38308e7fff4ca-3308f486e60mr19665031fa.8.1752760689779;
        Thu, 17 Jul 2025 06:58:09 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134fcsm23794421fa.15.2025.07.17.06.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:58:09 -0700 (PDT)
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
Subject: [PATCH v1 2/2] drm: panel: Add support for Hydis HV101HD1 MIPI DSI panel
Date: Thu, 17 Jul 2025 16:57:52 +0300
Message-ID: <20250717135752.55958-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250717135752.55958-1-clamor95@gmail.com>
References: <20250717135752.55958-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HV101HD1-1E1 is a color active matrix TFT LCD module using amorphous
silicon TFT's (Thin Film Transistors) as an active switching devices. This
module has a 10.1 inch diagonally measured active area with HD resolutions
(1366 horizontal by 768 vertical pixel array).

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig                |  13 ++
 drivers/gpu/drm/panel/Makefile               |   1 +
 drivers/gpu/drm/panel/panel-hydis-hv101hd1.c | 188 +++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-hydis-hv101hd1.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index e059b06e0239..eb547da38d56 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -185,6 +185,19 @@ config DRM_PANEL_HIMAX_HX8394
 
 	  If M is selected the module will be called panel-himax-hx8394.
 
+config DRM_PANEL_HYDIS_HV101HD1
+	tristate "Hydis HV101HD1 panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for the Hydis HV101HD1
+	  2-lane 1366x768 MIPI DSI panel found in ASUS VivoTab RT TF600T.
+	  HV101HD1 is a color active matrix TFT LCD module using amorphous
+	  silicon TFT's (Thin Film Transistors) as an active switching devices.
+
+	  If M is selected the module will be called panel-hydis-hv101hd1
+
 config DRM_PANEL_ILITEK_IL9322
 	tristate "Ilitek ILI9322 320x240 QVGA panels"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 1bb8ae46b59b..dd910c712996 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX83102) += panel-himax-hx83102.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112A) += panel-himax-hx83112a.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) += panel-himax-hx8394.o
+obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) += panel-hydis-hv101hd1.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9805) += panel-ilitek-ili9805.o
diff --git a/drivers/gpu/drm/panel/panel-hydis-hv101hd1.c b/drivers/gpu/drm/panel/panel-hydis-hv101hd1.c
new file mode 100644
index 000000000000..46426c388932
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-hydis-hv101hd1.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+struct hv101hd1 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct regulator_bulk_data *supplies;
+};
+
+static const struct regulator_bulk_data hv101hd1_supplies[] = {
+	{ .supply = "vdd" },
+	{ .supply = "vio" },
+};
+
+static inline struct hv101hd1 *to_hv101hd1(struct drm_panel *panel)
+{
+	return container_of(panel, struct hv101hd1, panel);
+}
+
+static int hv101hd1_prepare(struct drm_panel *panel)
+{
+	struct hv101hd1 *hv = to_hv101hd1(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = hv->dsi };
+	struct device *dev = &hv->dsi->dev;
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(hv101hd1_supplies), hv->supplies);
+	if (ret) {
+		dev_err(dev, "error enabling regulators (%d)\n", ret);
+		return ret;
+	}
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 20);
+
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 20);
+
+	return 0;
+}
+
+static int hv101hd1_disable(struct drm_panel *panel)
+{
+	struct hv101hd1 *hv = to_hv101hd1(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = hv->dsi };
+
+	mipi_dsi_dcs_set_display_off_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 120);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 20);
+
+	return 0;
+}
+
+static int hv101hd1_unprepare(struct drm_panel *panel)
+{
+	struct hv101hd1 *hv = to_hv101hd1(panel);
+
+	return regulator_bulk_disable(ARRAY_SIZE(hv101hd1_supplies),
+				      hv->supplies);
+}
+
+static const struct drm_display_mode hv101hd1_mode = {
+	.clock = (1366 + 74 + 36 + 24) * (768 + 21 + 7 + 4) * 60 / 1000,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 74,
+	.hsync_end = 1366 + 74 + 36,
+	.htotal = 1366 + 74 + 36 + 24,
+	.vdisplay = 768,
+	.vsync_start = 768 + 21,
+	.vsync_end = 768 + 21 + 7,
+	.vtotal = 768 + 21 + 7 + 4,
+	.width_mm = 140,
+	.height_mm = 220,
+};
+
+static int hv101hd1_get_modes(struct drm_panel *panel, struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &hv101hd1_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+
+	connector->display_info.width_mm = mode->width_mm;
+	connector->display_info.height_mm = mode->height_mm;
+
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs hv101hd1_panel_funcs = {
+	.prepare = hv101hd1_prepare,
+	.disable = hv101hd1_disable,
+	.unprepare = hv101hd1_unprepare,
+	.get_modes = hv101hd1_get_modes,
+};
+
+static int hv101hd1_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct hv101hd1 *hv;
+	int ret;
+
+	hv = devm_drm_panel_alloc(dev, struct hv101hd1, panel,
+				  &hv101hd1_panel_funcs,
+				  DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(hv))
+		return PTR_ERR(hv);
+
+	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(hv101hd1_supplies),
+					    hv101hd1_supplies, &hv->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
+
+	hv->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, hv);
+
+	dsi->lanes = 2;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
+
+	ret = drm_panel_of_backlight(&hv->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+
+	drm_panel_add(&hv->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret) {
+		drm_panel_remove(&hv->panel);
+		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
+	}
+
+	return 0;
+}
+
+static void hv101hd1_remove(struct mipi_dsi_device *dsi)
+{
+	struct hv101hd1 *hv = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev,
+			"Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&hv->panel);
+}
+
+static const struct of_device_id hv101hd1_of_match[] = {
+	{ .compatible = "hydis,hv101hd1" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, hv101hd1_of_match);
+
+static struct mipi_dsi_driver hv101hd1_driver = {
+	.driver = {
+		.name = "panel-hv101hd1",
+		.of_match_table = hv101hd1_of_match,
+	},
+	.probe = hv101hd1_probe,
+	.remove = hv101hd1_remove,
+};
+module_mipi_dsi_driver(hv101hd1_driver);
+
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("DRM driver for Hydis HV101HD1 panel");
+MODULE_LICENSE("GPL");
-- 
2.48.1



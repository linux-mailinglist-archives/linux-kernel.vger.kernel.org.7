Return-Path: <linux-kernel+bounces-849990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A6EBD18EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45344ED675
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C32E6CD1;
	Mon, 13 Oct 2025 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOlaoyMV"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDF2E2F0E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334984; cv=none; b=ZWpRUI/HbNG/415bIcer9e2EtjOzbJJVpY8yWMXh1FIfm1qKsvgw8BmUuO5Hl5ibvJoS24U5/SPdCj0BtFmoKZgNK+Ds5WxUxSl/SbR6BNp5KndyUAvx3Mf6jkG42YdWooqFG5hciNJwBYAQCoxbDOubPsmB/pw4d5qE5ZQUF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334984; c=relaxed/simple;
	bh=SdZCEzKCCGPm/tecLXel6T2iDt75VCQKY+YZCfWX8i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXIEiOEIdfnkFpuphnGcrnetEuT3QRVb3FYoJArzXGMujmc9YlnAopYxRWwolKE75l/vA8vIoR2SSkTDps/3BsZ7XdwMYUdodBQZlBh7yHibkQXs6oUnEIhkeH39uEe201+OvVD2Vre49+qMQkJu4yvZM0C6zivBX+voUXMwDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOlaoyMV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4f323cf89bso669325866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334981; x=1760939781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fab5qCv2aotV3Fj8kDbJUnYTD33aHY7VjmYq2cPYjic=;
        b=hOlaoyMVMiMGpjt1ROPvG0T5s/tTjDxZGG9STMWI4Nc/Xy62U5I6dpRANzzVDTxk6/
         UryzU7XWfIXjUJz7ZRhHEr63GlwuxvXikLy/VAJMswwugRhbHluY39hSTSv78tMWV/TY
         g44mVJWtXyHhk1lxrIppBsSBuxSewBjH2Ac7y/vNPGs4DwLOnTTrkIwAMwwt6uEchYqS
         4WWuoHtelLkijm2TBZ7bsj++AgxvqwcmfMHGX4cg0AgjPY5Ngh4lyz48+DdrjvqmbMS9
         zf7jgJ/n1qToD+ZOskdrpePo66f/Q2ryGSPquljoavF6ZubbwsDceN/KmttoiX5xVVSc
         +Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334981; x=1760939781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fab5qCv2aotV3Fj8kDbJUnYTD33aHY7VjmYq2cPYjic=;
        b=YFYi10XE7zRIamfsKq09YiG869FxdTmpLHbpPhEE0pKvFuJv3hc+tpW772jRrivIaa
         Tlum2ai5ZCSI/kcGsNLgKEM8I2HoeYVtR3aAEw3rd/aTb8C8R26KzOYCnA7j77UWCW86
         0EQ54sg6y7rz6uoM5WAY5VjP8Q38qViDi3nIFpGeWEase2BR/bRUIttKuiXzj39I8/2S
         6+vFRhXytimdqdTo0uvhqHx97euVpVtgfhSBuYqpAM//JL6SFAhQciVgqknxuJBf1tcx
         Y24f2pxQaSpQbMf7DiwuCSfKIznI9+GYH1sRHfp2ki7++nVETxcsS9+hJJiNfQhG7KB1
         vz6w==
X-Forwarded-Encrypted: i=1; AJvYcCVfdNs0ISghi6KW6jI+9DFpzsUsF3wcPb7hHJ+KV5eQ81erMuWV2yVip0pYM6hbiyhtWf1XCX4o8p3auqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYY1NVxeRfoySP1zte1JPCil3NHg19G5i3VDg61X/tE511wmP
	bOPbTVAxCIQ4/Zzynrwokz84/dcfNFxUddoAUFtVLFgGXj6vBS0CuIs5
X-Gm-Gg: ASbGncuhVCsf6rtZ09ktsPrU5GJnKQqm6VEoCNtIf0/3GLvs7R4yQlymM1bejh83Jg+
	WkAYsro+TCY/9Ntn4j9BbbyLc3hUIcqNFg8iSpaEU9CvXLUSEfBEPjlFzi/5Cf0/J5OgsWVNC9X
	VjcZZetAwgporV1EoiFrL86/9ESAt/C3HDhM4kefMULf/AlZ6zxnU4MfbsIFjRo1As3eUWheJtG
	Ni75T+dgHHcNAXpwkLr4h9RfympjoYzd1irTh8I9C2OeGuzKD6lEjMQoFp9/S3GRuC8QSBAeQ+S
	bXfLLd6pKJgjHKABXAkO7JiLjd+rciMCNknUNVxZoO8bgbxpS0LJd9nRDv/cCG67eUgTHczx5/6
	ScE44KLc09TpGsF4R0QoZ4cQKRmJY9l5VkljM/PyeDEk=
X-Google-Smtp-Source: AGHT+IHhPKhxcXUlwbbGNWfoJzODtqnzgGMFW3d0c2n5rlC5WbdXeHwstRcFJWpz05yxLA2YLIemVw==
X-Received: by 2002:a17:907:d06:b0:b0d:416e:2892 with SMTP id a640c23a62f3a-b50abaacf16mr2035054366b.32.1760334980674;
        Sun, 12 Oct 2025 22:56:20 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d63c9a3csm860912566b.23.2025.10.12.22.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:56:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 7/7] gpu/drm: panel: add Samsung LTL106HL02 MIPI DSI panel driver
Date: Mon, 13 Oct 2025 08:55:42 +0300
Message-ID: <20251013055543.43185-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013055543.43185-1-clamor95@gmail.com>
References: <20251013055543.43185-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Anton Bambura <jenneron@protonmail.com>

LTL106HL02 is a color active matrix TFT (Thin Film Transistor) liquid
crystal display (LCD) that uses amorphous silicon TFT as switching
devices. This model is composed of a TFT LCD panel, a driver circuit and a
backlight unit. The resolution of a 10.6" contains 1920 x 1080 pixels and
can display up to 16,8M color with wide viewing angle.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  13 ++
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-samsung-ltl106hl02.c  | 179 ++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-ltl106hl02.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 1f660ba065a1..2433a2931f63 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -781,6 +781,19 @@ config DRM_PANEL_SAMSUNG_LD9040
 	depends on BACKLIGHT_CLASS_DEVICE
 	select VIDEOMODE_HELPERS
 
+config DRM_PANEL_SAMSUNG_LTL106HL02
+	tristate "Samsung LTL106HL02 panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	select VIDEOMODE_HELPERS
+	help
+	  Say Y here if you want to enable support for the Samsung LTL106HL02
+	  panel driver which is used in Microsoft Surface 2.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called panel-samsung-ltl106hl02.
+
 config DRM_PANEL_SAMSUNG_S6E3FA7
 	tristate "Samsung S6E3FA7 panel driver"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 9281221183ac..a87ae98362bd 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_AMS639RQ08) += panel-samsung-ams639rq08.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20) += panel-samsung-atna33xc20.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_DB7430) += panel-samsung-db7430.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
+obj-$(CONFIG_DRM_PANEL_SAMSUNG_LTL106HL02) += panel-samsung-ltl106hl02.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D16D0) += panel-samsung-s6d16d0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D27A1) += panel-samsung-s6d27a1.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D7AA0) += panel-samsung-s6d7aa0.o
diff --git a/drivers/gpu/drm/panel/panel-samsung-ltl106hl02.c b/drivers/gpu/drm/panel/panel-samsung-ltl106hl02.c
new file mode 100644
index 000000000000..1618841b7caa
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-samsung-ltl106hl02.c
@@ -0,0 +1,179 @@
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
+#include <drm/drm_probe_helper.h>
+
+struct samsung_ltl106hl02 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+
+	struct regulator *supply;
+	struct gpio_desc *reset_gpio;
+};
+
+static inline struct samsung_ltl106hl02 *to_samsung_ltl106hl02(struct drm_panel *panel)
+{
+	return container_of(panel, struct samsung_ltl106hl02, panel);
+}
+
+static void samsung_ltl106hl02_reset(struct samsung_ltl106hl02 *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(2000, 3000);
+}
+
+static int samsung_ltl106hl02_prepare(struct drm_panel *panel)
+{
+	struct samsung_ltl106hl02 *ctx = to_samsung_ltl106hl02(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	ret = regulator_enable(ctx->supply);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable power supply %d\n", ret);
+		return ret;
+	}
+
+	if (ctx->reset_gpio)
+		samsung_ltl106hl02_reset(ctx);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 70);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 5);
+
+	return dsi_ctx.accum_err;
+}
+
+static int samsung_ltl106hl02_unprepare(struct drm_panel *panel)
+{
+	struct samsung_ltl106hl02 *ctx = to_samsung_ltl106hl02(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 150);
+
+	if (ctx->reset_gpio)
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
+	regulator_disable(ctx->supply);
+
+	return 0;
+}
+
+static const struct drm_display_mode samsung_ltl106hl02_mode = {
+	.clock = (1920 + 32 + 32 + 64) * (1080 + 6 + 3 + 22) * 60 / 1000,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 32,
+	.hsync_end = 1920 + 32 + 32,
+	.htotal = 1920 + 32 + 32 + 64,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 6,
+	.vsync_end = 1080 + 6 + 3,
+	.vtotal = 1080 + 6 + 3 + 22,
+	.width_mm = 235,
+	.height_mm = 132,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int samsung_ltl106hl02_get_modes(struct drm_panel *panel,
+					struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &samsung_ltl106hl02_mode);
+}
+
+static const struct drm_panel_funcs samsung_ltl106hl02_panel_funcs = {
+	.prepare = samsung_ltl106hl02_prepare,
+	.unprepare = samsung_ltl106hl02_unprepare,
+	.get_modes = samsung_ltl106hl02_get_modes,
+};
+
+static int samsung_ltl106hl02_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct samsung_ltl106hl02 *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, struct samsung_ltl106hl02, panel,
+				   &samsung_ltl106hl02_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ctx->supply = devm_regulator_get(dev, "power");
+	if (IS_ERR(ctx->supply))
+		return dev_err_probe(dev, PTR_ERR(ctx->supply),
+				     "Failed to get power regulator\n");
+
+	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
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
+static void samsung_ltl106hl02_remove(struct mipi_dsi_device *dsi)
+{
+	struct samsung_ltl106hl02 *ctx = mipi_dsi_get_drvdata(dsi);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id samsung_ltl106hl02_of_match[] = {
+	{ .compatible = "samsung,ltl106hl02-001" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, samsung_ltl106hl02_of_match);
+
+static struct mipi_dsi_driver samsung_ltl106hl02_driver = {
+	.driver = {
+		.name = "panel-samsung-ltl106hl02",
+		.of_match_table = samsung_ltl106hl02_of_match,
+	},
+	.probe = samsung_ltl106hl02_probe,
+	.remove = samsung_ltl106hl02_remove,
+};
+module_mipi_dsi_driver(samsung_ltl106hl02_driver);
+
+MODULE_AUTHOR("Anton Bambura <jenneron@protonmail.com>");
+MODULE_DESCRIPTION("DRM driver for Samsung LTL106HL02 video mode DSI panel");
+MODULE_LICENSE("GPL");
-- 
2.48.1



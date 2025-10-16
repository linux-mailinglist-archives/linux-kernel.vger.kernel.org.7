Return-Path: <linux-kernel+bounces-855859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC91BE2832
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E573D3BB0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D542E2DFB;
	Thu, 16 Oct 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="2pzid519"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43962D3EFC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608264; cv=none; b=U9MVxPl5RWY71ND1BPRHMSzHvfsMjjvBD66lvV//u9oiMRbuw0b1VfmTlcBKd2FlTlrHWixD3OL71uauL1WFKWnzYR26ssDky7SAM41n2baowauA95I26+ZXwVHohWW0k7Ot3pvGb7fVRc7047/V05g+WaTZUL4zlQIh9wMXEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608264; c=relaxed/simple;
	bh=uWk39fUFrvpyBDX2lm7zrHVUVZqOVhaqbxns637gDhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PN4jxPlA9Jkic16hQWU4rKPJRHdUmlkKAFvEV0g/aM3BY4mV42UqekGHTlsODQ8ghQNe/6XMFIBcZrCxqWV0ZwANoq79Ed1GYTsjgRJmi7BfJUhVL+vaNEmwFH6KPPmmIyS4n7hPYnzjjc8zNUoPvuBKBTPBpJW+RpCRAGGID8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=2pzid519; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339d53f4960so546304a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1760608259; x=1761213059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFs3EGtGlK6OwlG3/AgKjm9aiJuGxxNuTS0QmzI5toQ=;
        b=2pzid519fqOc8TP3DTKHbMpB5/XxfyZknCa/GNEvemMUmc1g7pPKZuWbbkGLxLn2GX
         IFbMFU0cwgIB+1CXg2U1b0PobE2v3D4WJuUvUQnfpWdVk+uY0KpusN6eOlgaW0YLB0lg
         nObMhDHz+UDwc6Bcez1kWGE6+9xWkTNlc3d0vMdj5BGlpdCBuzEnQrKKvwd815iLf8dP
         XVwjWzoEwZHTaHUir4AMyXI0NRazKejP7leodUC1pbk11JpJlODHpiB/0I4f3X46JUwJ
         fSD4r5tW5oKCct4B6I2hwUXMZ/mk7ouFClcLEYFKNkZF8dbsJWtkjoRDkGkRM4ozw0Cu
         yrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760608259; x=1761213059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFs3EGtGlK6OwlG3/AgKjm9aiJuGxxNuTS0QmzI5toQ=;
        b=NG12lCk5TziQzqVgBuAYD59TzB/opjsQdBGtxSQkiMLTEEx4ZDEV5Gd2l1zx0a6TLt
         pcZtI5ta+QDljxDUtnrT8nQOhmgtQBOkH/tHB+xfN1wDrrSkcBybCSYct1rRvA68pVxR
         D1q29fxzrNDdIEihXA3440cocjZx4Bf1eS99UJj+FYbiAqEleYi6yhC9jmuL+aSTsNzk
         bDbtXItaXsYddQC6cwBfPzW1C3XJDcTDIIdry4OrwO5RP4Esk6EIB1EZ5BNoNrWW6d+C
         eQFEcS6gB5N7QTjRzLerbsxVIvlbxPC5ZT7LxG6NosfkcUAZ3f+A5cVtgim2xj6PZpUo
         9gsg==
X-Forwarded-Encrypted: i=1; AJvYcCW41cuaPU4c7qC8+mxG3osrQ628QyJqkGRLx8HIed3q10o1TfrybFtpuL5XRgztdFgWOtqr/QFrLJ9TuSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhW72VwCopuEgcSbzZC2gg3OTYlzf9d8pgMYYJdCpeuRf5kHJI
	bHndK9q2CV8ehu4rUidSxiCxYaukfZ55HeESrQg+Vkib172uU43EEunhJ/+s6kG1dDM=
X-Gm-Gg: ASbGnctmsWfeUr0lINieqrNA1xph7F9x8CCeqEcpP2dGpuKULzyXFaiwbxZX5YyoiKy
	staG8B9OgSJNFwagUNG9y9tYMNFpTEq4D3QNKmeK6l2ArjX82fFbV3Y27RgQOvb93zLesw6Dngr
	g9Qzb6ECmYUztziHOa4RBeOWwP8SHiE30oDXDWWP9WpSYuWBsX1HKINTih0Lcwh7bBxZLORi6wk
	sDQDAH0TYqYwrInkcywNsUDfrVPq+mGpjhaieDiLp1W+xwoC3NwTKCX3E/Yxvi5NCHrDVNn2O5K
	gwYEc0eAy8CQV0Mf0SifgZ56yjUyQfpT6DllvXlvauIx8nEGBP82XNL7GakkwxtBKNBKZp6rrrh
	A6E8RJ4nctbZtlvaRsN4yMgjgvhzk7HFT0B8O0B1ovx8hV3lXCjh9kdHz5t5Iltik2qgwk16o9k
	7+Tr6aUjYpSKh1ooXiPx22ai0ar5yg0sJnNGy9R9CIzsVXL1gWpuxbfIi8UA==
X-Google-Smtp-Source: AGHT+IE1EUi1+7BD9Qmr9q3KVeE2U3k6HZTCCxGbpg+g2pzJT8BF4zuNi1u/SE9s6oHhJCVragcTew==
X-Received: by 2002:a17:90b:4a0b:b0:330:6f16:c4e0 with SMTP id 98e67ed59e1d1-33b5116a4b1mr45144549a91.12.1760608258877;
        Thu, 16 Oct 2025 02:50:58 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6519421sm1272402a91.1.2025.10.16.02.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:50:58 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v3 2/2] drm/panel: Add driver for Ilitek IL79900A-based panels
Date: Thu, 16 Oct 2025 17:50:43 +0800
Message-Id: <20251016095043.1694736-3-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016095043.1694736-1-yelangyan@huaqin.corp-partner.google.com>
References: <20251016095043.1694736-1-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a DRM panel driver for the Ilitek IL79900A MIPI-DSI LCD controller.

The controller is used in panels such as the Tianma TL121BVMS07-00.
It requires multiple power supplies (AVDD, AVEE, 1.8V logic), an enable
GPIO, and a backlight device.

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-ilitek-il79900a.c | 358 ++++++++++++++++++
 1 file changed, 358 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-il79900a.c

diff --git a/drivers/gpu/drm/panel/panel-ilitek-il79900a.c b/drivers/gpu/drm/panel/panel-ilitek-il79900a.c
new file mode 100644
index 000000000000..22338bef5609
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-ilitek-il79900a.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Panels based on the Ilitek IL79900A display controller.
+ *
+ * Based on drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+ */
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+
+#include <video/mipi_display.h>
+
+struct il79900a;
+
+/*
+ * Use this descriptor struct to describe different panels using the
+ * Ilitek IL79900A display controller.
+ */
+struct panel_desc {
+	const struct drm_display_mode *modes;
+	unsigned int bpc;
+	unsigned long mode_flags;
+	enum mipi_dsi_pixel_format format;
+	int (*init)(struct il79900a *boe);
+	unsigned int lanes;
+};
+
+struct il79900a {
+	struct drm_panel base;
+	struct mipi_dsi_device *dsi;
+
+	const struct panel_desc *desc;
+
+	enum drm_panel_orientation orientation;
+	struct regulator *pp1800;
+	struct regulator *avee;
+	struct regulator *avdd;
+	struct gpio_desc *enable_gpio;
+};
+
+/* IL79900A-specific commands, add new commands as you decode them */
+#define IL79900A_DCS_SWITCH_PAGE	0xFF
+
+#define il79900a_switch_page(ctx, page) \
+	mipi_dsi_dcs_write_seq_multi(ctx, IL79900A_DCS_SWITCH_PAGE, \
+				     0x5a, 0xa5, (page))
+
+static int tianma_il79900a_init(struct il79900a *ili)
+{
+	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
+
+	mipi_dsi_usleep_range(&ctx, 5000, 5100);
+
+	il79900a_switch_page(&ctx, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3e, 0x62);
+
+	il79900a_switch_page(&ctx, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5e, 0x40);
+
+	il79900a_switch_page(&ctx, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0X29, 0x00);
+
+	il79900a_switch_page(&ctx, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x92, 0x22);
+
+	il79900a_switch_page(&ctx, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_EXIT_SLEEP_MODE);
+
+	mipi_dsi_msleep(&ctx, 120);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_ON);
+
+	mipi_dsi_msleep(&ctx, 80);
+
+	return 0;
+};
+
+static inline struct il79900a *to_il79900a(struct drm_panel *panel)
+{
+	return container_of(panel, struct il79900a, base);
+}
+
+static int il79900a_enter_sleep_mode(struct mipi_dsi_multi_context *ctx)
+{
+	mipi_dsi_dcs_set_display_off_multi(ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(ctx);
+	return ctx->accum_err;
+}
+
+static int il79900a_disable(struct drm_panel *panel)
+{
+	struct il79900a *ili = to_il79900a(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
+	int ret;
+
+	il79900a_switch_page(&ctx, 0x00);
+	if (ctx.accum_err)
+		return ctx.accum_err;
+
+	ret = il79900a_enter_sleep_mode(&ctx);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
+		return ret;
+	}
+
+	mipi_dsi_msleep(&ctx, 150);
+
+	return 0;
+}
+
+static int il79900a_unprepare(struct drm_panel *panel)
+{
+	struct il79900a *ili = to_il79900a(panel);
+
+	gpiod_set_value(ili->enable_gpio, 0);
+	usleep_range(1000, 2000);
+	regulator_disable(ili->avee);
+	regulator_disable(ili->avdd);
+	usleep_range(5000, 7000);
+	regulator_disable(ili->pp1800);
+
+	return 0;
+}
+
+static int il79900a_prepare(struct drm_panel *panel)
+{
+	struct il79900a *ili = to_il79900a(panel);
+	int ret;
+
+	gpiod_set_value(ili->enable_gpio, 0);
+	usleep_range(1000, 1500);
+
+	ret = regulator_enable(ili->pp1800);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(3000, 5000);
+
+	ret = regulator_enable(ili->avdd);
+	if (ret < 0)
+		goto poweroff1v8;
+	ret = regulator_enable(ili->avee);
+	if (ret < 0)
+		goto poweroffavdd;
+
+	usleep_range(10000, 11000);
+
+	// MIPI needs to keep the LP11 state before the lcm_reset pin is pulled high
+	ret = mipi_dsi_dcs_nop(ili->dsi);
+	if (ret < 0) {
+		dev_err(&ili->dsi->dev, "Failed to send NOP: %d\n", ret);
+		goto poweroff;
+	}
+	usleep_range(1000, 2000);
+
+	gpiod_set_value(ili->enable_gpio, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value(ili->enable_gpio, 0);
+	usleep_range(10000, 11000);
+	gpiod_set_value(ili->enable_gpio, 1);
+	usleep_range(20000, 21000);
+
+	ret = ili->desc->init(ili);
+	if (ret < 0)
+		goto poweroff;
+
+	return 0;
+
+poweroff:
+	gpiod_set_value(ili->enable_gpio, 0);
+	regulator_disable(ili->avee);
+poweroffavdd:
+	regulator_disable(ili->avdd);
+poweroff1v8:
+	usleep_range(5000, 7000);
+	regulator_disable(ili->pp1800);
+
+	return ret;
+}
+
+static int il79900a_enable(struct drm_panel *panel)
+{
+	return 0;
+}
+
+static const struct drm_display_mode tianma_il79900a_default_mode = {
+	.clock = 264355,
+	.hdisplay = 1600,
+	.hsync_start = 1600 + 20,
+	.hsync_end = 1600 + 20 + 4,
+	.htotal = 1600 + 20 + 4 + 20,
+	.vdisplay = 2560,
+	.vsync_start = 2560 + 82,
+	.vsync_end = 2560 + 82 + 2,
+	.vtotal = 2560 + 82 + 2 + 36,
+	.width_mm = 163,
+	.height_mm = 260,
+};
+
+static const struct panel_desc tianma_il79900a_desc = {
+	.modes = &tianma_il79900a_default_mode,
+	.bpc = 8,
+	.lanes = 3,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init = tianma_il79900a_init,
+};
+
+static int il79900a_get_modes(struct drm_panel *panel,
+			      struct drm_connector *connector)
+{
+	struct il79900a *ili = to_il79900a(panel);
+	const struct drm_display_mode *m = ili->desc->modes;
+	int num_modes;
+
+	num_modes = drm_connector_helper_get_modes_fixed(connector, m);
+	if (num_modes <= 0)
+		return 0;
+
+	connector->display_info.bpc = ili->desc->bpc;
+
+	return num_modes;
+}
+
+static enum drm_panel_orientation il79900a_get_orientation(struct drm_panel *panel)
+{
+	struct il79900a *ili = to_il79900a(panel);
+
+	return ili->orientation;
+}
+
+static const struct drm_panel_funcs il79900a_funcs = {
+	.disable = il79900a_disable,
+	.unprepare = il79900a_unprepare,
+	.prepare = il79900a_prepare,
+	.enable = il79900a_enable,
+	.get_modes = il79900a_get_modes,
+	.get_orientation = il79900a_get_orientation,
+};
+
+static int il79900a_add(struct il79900a *ili)
+{
+	struct device *dev = &ili->dsi->dev;
+	int err;
+
+	ili->avdd = devm_regulator_get(dev, "avdd");
+	if (IS_ERR(ili->avdd))
+		return PTR_ERR(ili->avdd);
+
+	ili->avee = devm_regulator_get(dev, "avee");
+	if (IS_ERR(ili->avee))
+		return PTR_ERR(ili->avee);
+
+	ili->pp1800 = devm_regulator_get(dev, "pp1800");
+	if (IS_ERR(ili->pp1800))
+		return PTR_ERR(ili->pp1800);
+
+	ili->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ili->enable_gpio)) {
+		dev_err(dev, "cannot get reset-gpios %ld\n",
+			PTR_ERR(ili->enable_gpio));
+		return PTR_ERR(ili->enable_gpio);
+	}
+
+	gpiod_set_value(ili->enable_gpio, 0);
+
+	drm_panel_init(&ili->base, dev, &il79900a_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+	err = of_drm_get_panel_orientation(dev->of_node, &ili->orientation);
+	if (err < 0) {
+		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
+		return err;
+	}
+
+	err = drm_panel_of_backlight(&ili->base);
+	if (err)
+		return err;
+
+	ili->base.funcs = &il79900a_funcs;
+	ili->base.dev = &ili->dsi->dev;
+
+	drm_panel_add(&ili->base);
+
+	return 0;
+}
+
+static int il79900a_probe(struct mipi_dsi_device *dsi)
+{
+	struct il79900a *ili;
+	int ret;
+	const struct panel_desc *desc;
+
+	ili = devm_kzalloc(&dsi->dev, sizeof(*ili), GFP_KERNEL);
+	if (!ili)
+		return -ENOMEM;
+
+	desc = of_device_get_match_data(&dsi->dev);
+	dsi->lanes = desc->lanes;
+	dsi->format = desc->format;
+	dsi->mode_flags = desc->mode_flags;
+	ili->desc = desc;
+	ili->dsi = dsi;
+	ret = il79900a_add(ili);
+	if (ret < 0)
+		return ret;
+
+	mipi_dsi_set_drvdata(dsi, ili);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret)
+		drm_panel_remove(&ili->base);
+
+	return ret;
+}
+
+static void il79900a_remove(struct mipi_dsi_device *dsi)
+{
+	struct il79900a *ili = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+
+	if (ili->base.dev)
+		drm_panel_remove(&ili->base);
+}
+
+static const struct of_device_id il79900a_of_match[] = {
+	{ .compatible = "tianma,il79900a", .data = &tianma_il79900a_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, il79900a_of_match);
+
+static struct mipi_dsi_driver il79900a_driver = {
+	.driver = {
+		.name = "panel-il79900a",
+		.of_match_table = il79900a_of_match,
+	},
+	.probe = il79900a_probe,
+	.remove = il79900a_remove,
+};
+module_mipi_dsi_driver(il79900a_driver);
+
+MODULE_AUTHOR("Langyan Ye <yelangyan@huaqin.corp-partner.google.com>");
+MODULE_DESCRIPTION("Ilitek IL79900A-based panels driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1



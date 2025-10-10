Return-Path: <linux-kernel+bounces-848060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5044BCC60D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75F640592C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ECF283FC2;
	Fri, 10 Oct 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="S26EiD4t"
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F332773FC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089095; cv=none; b=pMmvtc9Qp+QOx7OcBcSLOqKrgIeBemVyMWPOweM8qf9MtEHTltvep3QNi9pl1qTTSpHffslHhO/d67lmzHHJ7Tfb9I5Lh0m2sBw++2YZC1JoGSyXgRMLaB8DQRcvaWP0Ky+D6vhuL73HbThtCh+n2E9NXmk0zblCgKsq5jyyudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089095; c=relaxed/simple;
	bh=qD5bxdwUXkXh7HDo9GOHLamHnwGdD83GPqbP2mHxUnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lR7KedvpDzT6Ftp/gvEeziBv1GiEigjyCUD2c1UNDZe4Bm4/C59qBdkTx+27P4zfu1/GulaP3RdewVoubv28gxlU3MuUrt54chIIEyC9lEtPaJB9vaRBZZBTAJQHU2aCT7Kv4Bo5mt1JQwGdAhJ+q6B6nP9a/SgVsYhCVcDrK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=S26EiD4t; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1577491a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1760089091; x=1760693891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nh9zC4V4YKxutemHzLAgfDIBQaLAquwFq5cYZiKzVc=;
        b=S26EiD4tTqxLbIX3w2qh0YEATne3h4zesfE2P8olQL2uHvmk5nFP8vh/i7baHlTGLr
         6MzOBaL0jUmmB2Yy6PhCCh3loWK83PByzf11h1KYkuqHSgj3+0eVa22VfNi2MN6Todi3
         hv5jmLcF00bQDoL+x3EClFEpgSAHQagtV+pkCS3OOpxBPZLIceXUMKl8yzJqJhvAOcGE
         c9P0tizAfuSVN9Nbm30DSomYIDOKgvljnilWpe28XFMEoNWvP4Owxlzotab4eTvOtPYt
         9iusaz45qhcE47YcxwquZB22pKVGOb/gXYBw5SjpN+wwuR+FPr5DR/dfnU9kPQlEFGKE
         Nh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089091; x=1760693891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nh9zC4V4YKxutemHzLAgfDIBQaLAquwFq5cYZiKzVc=;
        b=NDgxCPBMUwwGqbeNGpDcMTAfNxHCkkc5mjwnzc70IP6o5stc0enYjDXmMCMUtlZk6T
         xAr008pLVHrKB24TGB0B6x9BPv37hmc/jb0uqGjlPsYCv/lcbl0/kKDYUlvIig9rplBi
         +lxvqUa9Nq0kzKfSw8CsEitOjMzjt71K9cEqxYBO7QCenRGj61k29RR8g3HcQEpX9G/o
         7axMqnsQg/foF0nod0q25jvEKPwekSS4cjbD7Ng04Eb6mhWa6rIk70kLevxrb8lMTcWj
         d7KpvZxrLcB/jVIiVgzkGoGBMPG+dGzi9zGDRDO6n49UjgrF6KjLX6S4E8NL1f06OOAy
         bZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdpj0QGKnAymYaI8O60MJpgZw/XR7xhJcpJJYjaxJZ7XZZDaawx+NzOKKYZZJ2DIlMWyirUnNwGNyU4S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybluDKd6wjwXHKW7lUodXt0ctiq7jOwPbBVOy+mSoHgcSN+Q2q
	YpfrtkDWUilkDTbjSIh/qTSNxi0Eo0CKRVjqzK2CMFFzwx5stAylqbR38bwpm5IJmgg=
X-Gm-Gg: ASbGncvf6gduC2PDm9nCm8qi8z2LNJJHYxiSMUR+GaRLhQa9h7LlA8YaTgr9YQEacDI
	7b/CQ2mWDAU6GvXuoZsNZU1L6S7eizN/au8Oe9Z3MvmExNn/uBOAJqVQXBZndMOQuhNMGZ96Y7A
	fs8/97IBRgf+fBW8Jj+Ir3/XMD9TR5HgGGbexgzB1YwaWMivA5GQMyX5KvHxw4XoDKXrK393qou
	S7KGEbDk70SA3gmLH2Z+awftQCaIwrz4+WUIxJxHt8c7lh76aHy9yrXJ4khmJQoIEUtaHC9fl1J
	miTs0J5QW4T4oSJ+gsuPkEE1UQrLxHyIHAroiR2dETRZnCqLH4Gx8Bp+BMJwFEPiVAmIXvpohPp
	53+iTaIkp8JAoQTpYU4UPpjrMQlV+v132VEjR0vq9P+SCE4mkg6+WG2gVabmqWPyRFK5vMJISXq
	vhOBvmt6SAO9A7
X-Google-Smtp-Source: AGHT+IGW6cmTBrb0/ErIg3j7xelwSrJqJnF8VJGLy2SHks6obc5hjQ+LNHrpCNjQZhmBhTbaVBOTwQ==
X-Received: by 2002:a17:90b:3b45:b0:32b:cb15:5fdc with SMTP id 98e67ed59e1d1-33b513a24c4mr14715950a91.30.1760089090607;
        Fri, 10 Oct 2025 02:38:10 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a392cdsm2668196a91.7.2025.10.10.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:38:10 -0700 (PDT)
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
Subject: [PATCH v2 2/2] drm/panel: Add driver for Ilitek IL79900A-based panels
Date: Fri, 10 Oct 2025 17:37:51 +0800
Message-Id: <20251010093751.2793492-3-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010093751.2793492-1-yelangyan@huaqin.corp-partner.google.com>
References: <20251010093751.2793492-1-yelangyan@huaqin.corp-partner.google.com>
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
 drivers/gpu/drm/panel/panel-ilitek-il79900a.c | 394 ++++++++++++++++++
 1 file changed, 394 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-il79900a.c

diff --git a/drivers/gpu/drm/panel/panel-ilitek-il79900a.c b/drivers/gpu/drm/panel/panel-ilitek-il79900a.c
new file mode 100644
index 000000000000..2134f8af673e
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-ilitek-il79900a.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Panels based on the Ilitek IL79900A display controller.
+ */
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_connector.h>
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
+
+	/**
+	 * @width_mm: width of the panel's active display area
+	 * @height_mm: height of the panel's active display area
+	 */
+	struct {
+		unsigned int width_mm;
+		unsigned int height_mm;
+	} size;
+
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
+	usleep_range(5000, 5100);
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
+	if (ctx.accum_err)
+		return ctx.accum_err;
+
+	msleep(120);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_ON);
+	if (ctx.accum_err)
+		return ctx.accum_err;
+
+	msleep(80);
+
+	return 0;
+};
+
+static inline struct il79900a *to_il79900a(struct drm_panel *panel)
+{
+	return container_of(panel, struct il79900a, base);
+}
+
+static int il79900a_enter_sleep_mode(struct il79900a *ili)
+{
+	struct mipi_dsi_device *dsi = ili->dsi;
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0)
+		return ret;
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0)
+		return ret;
+
+	return 0;
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
+	ret = il79900a_enter_sleep_mode(ili);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
+		return ret;
+	}
+
+	msleep(150);
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
+	msleep(130);
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
+};
+
+static const struct panel_desc tianma_il79900a_desc = {
+	.modes = &tianma_il79900a_default_mode,
+	.bpc = 8,
+	.size = {
+		.width_mm = 163,
+		.height_mm = 260,
+	},
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
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, m);
+	if (!mode) {
+		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
+			m->hdisplay, m->vdisplay, drm_mode_vrefresh(m));
+		return -ENOMEM;
+	}
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+
+	connector->display_info.width_mm = ili->desc->size.width_mm;
+	connector->display_info.height_mm = ili->desc->size.height_mm;
+	connector->display_info.bpc = ili->desc->bpc;
+
+	return 1;
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
+	{ .compatible = "tianma,il79900a",
+	  .data = &tianma_il79900a_desc
+	},
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



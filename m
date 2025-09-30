Return-Path: <linux-kernel+bounces-837299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752CBABE76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45647188EEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FECA2C3272;
	Tue, 30 Sep 2025 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="kfmREGUi"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2562C0F7C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218668; cv=none; b=rEvTYzk/duNSIyFUO2DQ1klg7BTjJvllHRwa8mYAfQgYo8YUDarzPqM0gZbK0NXIJqolrdOUDYcgoxrxOxSKwLU48FE653amN3XHJdmBduPCimYCKOBl1wHcrUvYlz5Xoi4g+Ah1/McpphwvNIRBTAZHkPIK24MJq7f+IANs3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218668; c=relaxed/simple;
	bh=pet/N8sFaNRIHeMu67LUBKma+8CENtX3Toq6EdvBO/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RnyaV3GZ/cM9e9bORV78/c4kw5Ad14ZuNGW6xXNAXwtYk8uX17p5JbkinytaahrRKlNJjGq4F506gnui6d6k8cUzQOxI1R2Lt2t1N0YDGgEQwqeZ1E5o39bI5tU4GjS+qiYk2Hddzdlf7Jr+rIyvUmNUC9PsYhmuxIk3i+W3xvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=kfmREGUi; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-279e2554c8fso57730675ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1759218665; x=1759823465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60hr+t3VU3n6O3UnBPMWzfsQUhzglMdEt7VA1TIh1So=;
        b=kfmREGUidEO1y+rCrIDS8ampWyJm6/UOSPJCf5s43+uN1Z34A/Jwf6v2GPnkYB8ob7
         8titDmQ4J1feGvvLcu5ev7jvidzXkhSHIOEQS0tkKG5+DLEbBj9GWVwc023Jk3wpF0dm
         W412y6SR3o6Wwz56AjSce8O0AI03ot7O0FhFsLgVlKST96ailbJGLXIZhabcNNagf8Fu
         xNE/22yR1lp+MCZrB6cEg3Nz9e2acSELOtLbOuxP5eayxOSK2nAhWMYwRlXB9bEko5uI
         Lr58dwuLs6IQZK4d25ywi4fA43zJspEaoYftfkWQtbocgZGR1HHK4i2RD6k8WM6Lw1ju
         VhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218665; x=1759823465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60hr+t3VU3n6O3UnBPMWzfsQUhzglMdEt7VA1TIh1So=;
        b=P3HllousGdhDpfPRXsjbodb7iA84O4JdpLCX7rMisKlM+9PGX16s/o1FSLRbZhEAjn
         HHRnFHIvAvE4YeokVHUMqRv1FNrP/6zZ4v4TOX+XktA5OXGg70JrqiMRPccrH5vPg8F+
         +YXR2jZv8J5CytDbjump55Bg/A9KWBggrjVFneMBhU9ZjesX60pEpwEGfwniYNWKL8bN
         pUA3ASj09ziVJQMe+afoIACerf2B4s+IUD18xG1319v7JKXTKEYNZDGjHabEnwiPelbP
         f7ubPuhzI1Fe5/qCz2SKQWp0uv2QEe1okzG6EIkb5F9g7pAVnbMbeMMUlfzIDTCPaUyu
         uTZg==
X-Forwarded-Encrypted: i=1; AJvYcCUNNxrOrVpVnqfrqcjpXQpS9bLQPrkSAI1cA/yEJ+GA23JyM14O3m4Y6uRPIljhidbMArTQGNvzn95TjL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAv1ZmDAJX3K6xqLHkkky4T0VNEAd50+tWNPflThsqXjxC8UA
	dDlw9r6pICw6mT681bsx/GgRuTas7FUxsEEdnPmQndFyxj+8UQuEJQbbPb8Uwt2//wGCyud0fV8
	7t9PmqunewA==
X-Gm-Gg: ASbGncscQy1iA+e5U0yNoMk2zbSuGaSSJ5COG1Bs5nvWbIO5XRY14TcWODbJDtAnfXI
	ZF/03TTl5+KSA5runA11xXEQ7Mbzu2clfpKzxya1BNQjCDwU7mo8gGvog9Qh/zdWXFr1fLBXNO6
	UV+mLwAA6B9sT/W4I8RcNqXMWGlWPAwoO7NkDByJKCrFNyspPEPN5gCiI8YfEoUiqIiwPfeAm3w
	QArK/t/3AtO53vwiePkeieP71E3y7wuiMuPHwSZfKv067CgWgLYswV4RuRndpYMbu5grsovu0nq
	lfC/T54EAml04xW/rCpVIV5TpX0/cI1ct/BJtgrfRI4qx7t1VSNzJ3bT1MDsy1mBuL/On87A6Of
	Zeso2ZoC44QWniEEzNaX1XXW4SNxfEBEuvSJ8QLbIXpzzWlKp22HiNpkEksS+NPw4Oje/TDmEWE
	IzX0VrTvjRa+RpJlGIGw==
X-Google-Smtp-Source: AGHT+IGhRjc/a14/eaZ4YvqMOpu6kLwlxEUo+yCQX0UzgJOr1NpZ0sRtE5db0gL+ZNvRxuseuwI2sQ==
X-Received: by 2002:a17:902:e890:b0:24c:a269:b6d5 with SMTP id d9443c01a7336-27ed493e891mr192104545ad.0.1759218665443;
        Tue, 30 Sep 2025 00:51:05 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed688223dsm152313565ad.86.2025.09.30.00.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:51:05 -0700 (PDT)
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
Subject: [PATCH v1 2/2] drm/panel: Add driver for Tianma TL121BVMS07-00 panel
Date: Tue, 30 Sep 2025 15:50:44 +0800
Message-Id: <20250930075044.1368134-3-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930075044.1368134-1-yelangyan@huaqin.corp-partner.google.com>
References: <20250930075044.1368134-1-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a DRM panel driver for the Tianma TL121BVMS07-00 12.1"
MIPI-DSI TFT LCD panel. The panel requires multiple power
supplies (AVDD, AVEE, 1.8V logic), an enable GPIO, and a
backlight device. The panel is based on the Ilitek IL79900A
controller.

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 .../drm/panel/panel-tianma-tl121bvms07-00.c   | 419 ++++++++++++++++++
 1 file changed, 419 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-tianma-tl121bvms07-00.c

diff --git a/drivers/gpu/drm/panel/panel-tianma-tl121bvms07-00.c b/drivers/gpu/drm/panel/panel-tianma-tl121bvms07-00.c
new file mode 100644
index 000000000000..5facffeda864
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-tianma-tl121bvms07-00.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DRM panel driver for Tianma TL121BVMS07-00 12.1" MIPI-DSI TFT LCD panel
+ *
+ * Based on drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+ */
+
+
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
+struct tm_panel;
+
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
+	int (*init)(struct tm_panel *tm);
+	unsigned int lanes;
+	bool discharge_on_disable;
+	bool lp11_before_reset;
+};
+
+struct tm_panel {
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
+
+	bool prepared;
+};
+
+static int tm_tl121bvms07_00_init(struct tm_panel *tm)
+{
+	struct mipi_dsi_multi_context ctx = { .dsi = tm->dsi };
+	struct mipi_dsi_device *dsi = ctx.dsi;
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x5a, 0xa5, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3e, 0x62);
+
+
+	mipi_dsi_generic_write_seq(dsi, 0xff, 0x5a, 0xa5, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5e, 0x40);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x5a, 0xa5, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0X29, 0x00);
+
+	mipi_dsi_generic_write_seq(dsi, 0xff, 0x5a, 0xa5, 0x00);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0X11);
+
+	if (ctx.accum_err)
+		return ctx.accum_err;
+
+	msleep(120);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0X29);
+
+	if (ctx.accum_err)
+		return ctx.accum_err;
+
+	msleep(80);
+
+	return 0;
+};
+
+static inline struct tm_panel *to_tm_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct tm_panel, base);
+}
+
+static int tm_panel_enter_sleep_mode(struct tm_panel *tm)
+{
+	struct mipi_dsi_device *dsi = tm->dsi;
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
+static int tm_panel_disable(struct drm_panel *panel)
+{
+	struct tm_panel *tm = to_tm_panel(panel);
+	int ret;
+
+	ret = tm_panel_enter_sleep_mode(tm);
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
+static int tm_panel_unprepare(struct drm_panel *panel)
+{
+	struct tm_panel *tm = to_tm_panel(panel);
+
+	if (!tm->prepared)
+		return 0;
+
+	if (tm->desc->discharge_on_disable) {
+		regulator_disable(tm->avee);
+		regulator_disable(tm->avdd);
+		usleep_range(5000, 7000);
+		gpiod_set_value(tm->enable_gpio, 0);
+		usleep_range(5000, 7000);
+		regulator_disable(tm->pp1800);
+	} else {
+		gpiod_set_value(tm->enable_gpio, 0);
+		usleep_range(1000, 2000);
+		regulator_disable(tm->avee);
+		regulator_disable(tm->avdd);
+		usleep_range(5000, 7000);
+		regulator_disable(tm->pp1800);
+	}
+
+	tm->prepared = false;
+
+	return 0;
+}
+
+static int tm_panel_prepare(struct drm_panel *panel)
+{
+	struct tm_panel *tm = to_tm_panel(panel);
+	int ret;
+
+	if (tm->prepared)
+		return 0;
+
+	ret = regulator_enable(tm->pp1800);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(6000, 8000);
+
+	ret = regulator_enable(tm->avdd);
+	if (ret < 0)
+		goto poweroff1v8;
+	ret = regulator_enable(tm->avee);
+	if (ret < 0)
+		goto poweroffavdd;
+
+	usleep_range(11000, 12000);
+
+	gpiod_set_value(tm->enable_gpio, 1);
+
+	if (tm->desc->lp11_before_reset) {
+		ret = mipi_dsi_dcs_nop(tm->dsi);
+		if (ret < 0) {
+			dev_err(&tm->dsi->dev, "Failed to send NOP: %d\n", ret);
+			goto poweroff;
+		}
+		usleep_range(1000, 2000);
+	}
+	gpiod_set_value(tm->enable_gpio, 0);
+	usleep_range(1000, 2000);
+	gpiod_set_value(tm->enable_gpio, 1);
+	usleep_range(20000, 21000);
+
+	ret = tm->desc->init(tm);
+	if (ret < 0)
+		goto poweroff;
+
+	tm->prepared = true;
+	return 0;
+
+poweroff:
+	gpiod_set_value(tm->enable_gpio, 0);
+	regulator_disable(tm->avee);
+poweroffavdd:
+	regulator_disable(tm->avdd);
+poweroff1v8:
+	usleep_range(5000, 7000);
+	regulator_disable(tm->pp1800);
+
+	return ret;
+}
+
+static int tm_panel_enable(struct drm_panel *panel)
+{
+	msleep(130);
+	return 0;
+}
+
+static const struct drm_display_mode tm_tl121bvms07_00_default_mode = {
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
+static const struct panel_desc tm_tl121bvms07_00_desc = {
+	.modes = &tm_tl121bvms07_00_default_mode,
+	.bpc = 8,
+	.size = {
+		.width_mm = 163,
+		.height_mm = 260,
+	},
+	.lanes = 3,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init = tm_tl121bvms07_00_init,
+	.lp11_before_reset = true,
+};
+
+static int tm_panel_get_modes(struct drm_panel *panel,
+			       struct drm_connector *connector)
+{
+	struct tm_panel *tm = to_tm_panel(panel);
+	const struct drm_display_mode *m = tm->desc->modes;
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
+	connector->display_info.width_mm = tm->desc->size.width_mm;
+	connector->display_info.height_mm = tm->desc->size.height_mm;
+	connector->display_info.bpc = tm->desc->bpc;
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
+	drm_connector_set_panel_orientation(connector, tm->orientation);
+
+	return 1;
+}
+
+static enum drm_panel_orientation tm_panel_get_orientation(struct drm_panel *panel)
+{
+	struct tm_panel *tm = to_tm_panel(panel);
+
+	return tm->orientation;
+}
+
+static const struct drm_panel_funcs tm_panel_funcs = {
+	.disable = tm_panel_disable,
+	.unprepare = tm_panel_unprepare,
+	.prepare = tm_panel_prepare,
+	.enable = tm_panel_enable,
+	.get_modes = tm_panel_get_modes,
+	.get_orientation = tm_panel_get_orientation,
+};
+
+static int tm_panel_add(struct tm_panel *tm)
+{
+	struct device *dev = &tm->dsi->dev;
+	int err;
+
+	tm->avdd = devm_regulator_get(dev, "avdd");
+	if (IS_ERR(tm->avdd))
+		return PTR_ERR(tm->avdd);
+
+	tm->avee = devm_regulator_get(dev, "avee");
+	if (IS_ERR(tm->avee))
+		return PTR_ERR(tm->avee);
+
+	tm->pp1800 = devm_regulator_get(dev, "pp1800");
+	if (IS_ERR(tm->pp1800))
+		return PTR_ERR(tm->pp1800);
+
+	tm->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(tm->enable_gpio)) {
+		dev_err(dev, "cannot get reset-gpios %ld\n",
+			PTR_ERR(tm->enable_gpio));
+		return PTR_ERR(tm->enable_gpio);
+	}
+
+	gpiod_set_value(tm->enable_gpio, 0);
+
+	tm->base.prepare_prev_first = true;
+
+	drm_panel_init(&tm->base, dev, &tm_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+	err = of_drm_get_panel_orientation(dev->of_node, &tm->orientation);
+	if (err < 0) {
+		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
+		return err;
+	}
+
+	err = drm_panel_of_backlight(&tm->base);
+	if (err)
+		return err;
+
+	tm->base.funcs = &tm_panel_funcs;
+	tm->base.dev = &tm->dsi->dev;
+
+	drm_panel_add(&tm->base);
+
+	return 0;
+}
+
+static int tm_panel_probe(struct mipi_dsi_device *dsi)
+{
+	struct tm_panel *tm;
+	int ret;
+	const struct panel_desc *desc;
+
+	tm = devm_kzalloc(&dsi->dev, sizeof(*tm), GFP_KERNEL);
+	if (!tm)
+		return -ENOMEM;
+
+	desc = of_device_get_match_data(&dsi->dev);
+	dsi->lanes = desc->lanes;
+	dsi->format = desc->format;
+	dsi->mode_flags = desc->mode_flags;
+	tm->desc = desc;
+	tm->dsi = dsi;
+	ret = tm_panel_add(tm);
+	if (ret < 0)
+		return ret;
+
+	mipi_dsi_set_drvdata(dsi, tm);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret)
+		drm_panel_remove(&tm->base);
+	return ret;
+}
+
+static void tm_panel_shutdown(struct mipi_dsi_device *dsi)
+{
+	struct tm_panel *tm = mipi_dsi_get_drvdata(dsi);
+
+	drm_panel_disable(&tm->base);
+	drm_panel_unprepare(&tm->base);
+}
+
+static void tm_panel_remove(struct mipi_dsi_device *dsi)
+{
+	struct tm_panel *tm = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	tm_panel_shutdown(dsi);
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+
+	if (tm->base.dev)
+		drm_panel_remove(&tm->base);
+}
+
+static const struct of_device_id tm_of_match[] = {
+	{ .compatible = "tianma,tl121bvms07-00",
+	  .data = &tm_tl121bvms07_00_desc
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tm_of_match);
+
+static struct mipi_dsi_driver tm_panel_driver = {
+	.driver = {
+		.name = "panel-tianma-tl121bvms07-00",
+		.of_match_table = tm_of_match,
+	},
+	.probe = tm_panel_probe,
+	.remove = tm_panel_remove,
+	.shutdown = tm_panel_shutdown,
+};
+module_mipi_dsi_driver(tm_panel_driver);
+
+MODULE_AUTHOR("Langyan Ye <yelangyan@huaqin.corp-partner.google.com>");
+MODULE_DESCRIPTION("TM tl121bvms07-00 1600x2560 video mode panel driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1



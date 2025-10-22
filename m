Return-Path: <linux-kernel+bounces-864941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4F0BFBE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94EE3AA5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB6C346761;
	Wed, 22 Oct 2025 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="LH+fR9vL"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAE313E00
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137210; cv=none; b=t1mh3Sf6fsc9kz8taTTQaUw5LcwlFwTEmSWmlgLM5GSVGRz8bYGu7f6sOoHul7QXxJIKTCVMhGVjpU1D2MlIuGNy9u7BxD1WL+xgdXPWx4xIBIzL0nID4nhDqh1UvRsyIp+OJI2f4UGrpM3eZNBsxw0x7qpG8uAKoaofp1OBRqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137210; c=relaxed/simple;
	bh=EIcxozrl0rB2ac42rQCsvVKluIqu7CmvvB/bFukp00M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uwt1s/YQcDjPQxMPOdRD8T0TjNE4CSriWQBBFX5iWbf511eSBTAEN0AjfVhHFzDT7pOEpI+KiSl7Z45EOGrR0Qjx+IfE+V7nn2IqanBa51MuAjdZEu3TDaQdJUej4e8sknNZo7/UJLVIjGY8e5T+gAgzLZm+osfO8xPegCQ0Cr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=LH+fR9vL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so301412b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1761137205; x=1761742005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+NH/aT8hlW+F0DlQAJG3UacKe8/nPKjgQkeP9+wF1w=;
        b=LH+fR9vLK34NMClAyCPG/oBashdNeYLjWg6tJCRKWcKuxvgEHwdT0c897zGhcdJ6y0
         Wt4kzJ4gXl9yHr7ucXewlrx2xOpQYjKFUCOPhrPGJQasRR+IRoH0O8Vxud6t/tIg7Gwc
         N9Ka6W3Bm18t4F3JBvgCWGAUDJJSlhzCQmohYvLaRN4QTf//BaUSG2Gvb78Df5pZEsdT
         f/S4HLRYJM6ijLLZBxu0iWbZkajAYe5qOkjfsAvq/hJ4T6XN8pKvakf0PgQd1eQL60xh
         00RIGgMx4yhRJO/B/QRODWccnCC/Z02mzY8kjBhq/gZXJP/1pxFdEbbpUL/qKZC4n4E2
         7Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137205; x=1761742005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+NH/aT8hlW+F0DlQAJG3UacKe8/nPKjgQkeP9+wF1w=;
        b=vTWI38VMU0dSpaWvOV1+i1Ixc0YxrosB/KmiO0MG9C5aQmknxWyqQ2sq/xOMS3VMs0
         AZPaXr1iB9joAPkIbyfYrVx7lWhWzSS4fkzErvTZRkCIXjcY3PQTXlwpHKLSXiogODI+
         9hr8fCLezZ9snPgL+XW8kKYdEtuF1mDDsW/4Gnge+6sFRDwaID0OkpCrzVJz86BgKPmL
         9FYfMekV9QrW387Zm+WmeHSMHqBRwab9HoHyleDc4wmTbcc4gYEzVJ+W86ao5DwJrxLw
         R9Jg6bft3CTN6boilCxxPp5yTqF8KrE9V6NSDibwdDvlai3X9N1ZBxvzNUOLWvOWXw1K
         OiFg==
X-Forwarded-Encrypted: i=1; AJvYcCUSCS6toPNrXet3cqtdyGhm8rtM9+xzqdZkIekOb5Hkc9Gj3Tcocz3CYEF2IY7xZWG/gHWw/2292OAeFQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+12+KMoX1ip377+pIIr4mSYkqykMe/DdGCcn2XIpmyVDqMfN
	6XuCITRpqmMT4hn+SkyGX04cG/KgFTn+5wFUFlCsJP/Hg+HFRls+wjadMepFpEtIY5E=
X-Gm-Gg: ASbGncvkIf2Vmw3aPhUJG85gSahjhDbeuiawTw+pMsSQKX3Rh0FxkJ2Wc/GCUFlxH++
	9wiaH/jaNtbKUttLZW2UYJhInE+aAEka9WhljraAggQc0Km0vG34+5TUwxi/sef+wSkA+5FgXcL
	KCbj5Z+MPKk1DK2IJfCZ8F4euBs0pZasJDbCqpJiVjE9xuR7H23vl8GC6ls/t9sBRaWWly5vdME
	quv0zDY2f9O33W0jc9dsFqXXahOpdbl+173pN73gDdh5KTfNiMaOxrC512aAT/E3LqzoNA3H262
	PItKhHSKFU0lfWhbGw/h/TUc8m94D/4AB+wgkQihBKkB05XKUX78YU057gbdUE89d2AYcMLfWyi
	ez+zEQhUwTINmZAv6CR/v3YvxR8jk542zwxXb9PkEN0oJXRdhTGcC2S72ioJBE1mJCsw9ywiU/A
	DbQOz6XtNaD9qwd+4R79craT7EQDMyGTzyJ9ltbx6P25uZ3l1NI8W2J+oPNA==
X-Google-Smtp-Source: AGHT+IE8a8+6ACPG8wIq/ttQqQZG3AYg7Faf2H7dXLpHiq39qDJvSnhSllCzxQgB6sRPhHyhpmgb5Q==
X-Received: by 2002:a05:6a20:72a2:b0:334:8002:740f with SMTP id adf61e73a8af0-334a85bacd8mr26645510637.41.1761137204614;
        Wed, 22 Oct 2025 05:46:44 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e25asm14363935b3a.56.2025.10.22.05.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:46:44 -0700 (PDT)
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
Subject: [PATCH v4 2/2] drm/panel: Add driver for Ilitek IL79900A-based panels
Date: Wed, 22 Oct 2025 20:46:28 +0800
Message-Id: <20251022124628.311544-3-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022124628.311544-1-yelangyan@huaqin.corp-partner.google.com>
References: <20251022124628.311544-1-yelangyan@huaqin.corp-partner.google.com>
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
index 000000000000..b2fa9b8860f7
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
+static const struct panel_desc tianma_tl121bvms07_desc = {
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
+	{ .compatible = "tianma,tl121bvms07-00", .data = &tianma_tl121bvms07_desc },
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



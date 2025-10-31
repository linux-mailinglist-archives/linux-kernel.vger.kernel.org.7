Return-Path: <linux-kernel+bounces-879901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71234C245D9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059CA1898E82
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29402FB990;
	Fri, 31 Oct 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="FwsPqu8W"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A3334682
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905106; cv=none; b=SNpkJB9BHcdvNVzXJbeP315GSF4y5w8AhM3c6LKI0wdLr+mJdSrcG1A3fKs6MhybChuly/qXldLVnxLa96jg2+T7TNkiJa2mX5F68+U57pHSl2ZrqjF8hie7AlOVlrdIytlbzwPPUaeU/ZzzhKulTBBRs26ADFAUMI2I5qW3JQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905106; c=relaxed/simple;
	bh=RA2ffTxjmwnG7Kd0+crA6vcO9h5AkbQtUlwc/WGyzWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPlOmrds7bKtGyHkYwSiGDC+PfG4ELK9+WnAeCmSvm6NPj5HFkedmKWbF71+ymmtGckc2qbTPkwP1b5r1SJOBGKLQlbeHbWq+TehrEOcIph66knG35bwQn2AZN3icb5eRSJ7RkXt4/H+yVOTrW+gfzVZwtntOUktmrHEb2mPxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=FwsPqu8W; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso2018621b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1761905103; x=1762509903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEUFh8n08DQQphEfu7D6Jjf0DyrDDA8NGdeNReXL22I=;
        b=FwsPqu8WvkG8v7qYCuaxqdxi18LkDgp53zTJ3YYXAKUHdJWvLPGpr6xcn7yoBFYDa7
         Q+BihNnGQVaOoI6t8jvlo85reVNeGu8Ea6U9eFQqNbf1Xdwl5FGPQiDnAa8EN9DP2lRU
         9gjPjr96g1psmiJ0h/lEZYnyJ151KU/QwRGKQ9sgSAcgIBk2iyFw1uGi1RT2nzWkBC9g
         9qA2qlGLoN68HcMGWft7V+fGHNPi30K7OP5/xwy2ydBH+3xPlmtFmDdkh6Xbcjs1/feh
         nirAbCFE5M3pP/iXkZHrrmA6wBscLa55UGr135Z4b9U4YWxw0ew8VbbtruWn1lz0x49K
         0qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905103; x=1762509903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEUFh8n08DQQphEfu7D6Jjf0DyrDDA8NGdeNReXL22I=;
        b=Rumm6rV/AzdymfG5nCNvxGPL0IpvyH+Czs4UKlK+lFSqEd1Tf2ieUHF3CqMbg3w4rZ
         qPp0MXJvTxb82FsskfaXJ4T2M2/LHx22zNmOS095FNH6PN3BlaS019/iCjgogcv5HtFM
         PKjQbPO4y/N0XoxBoaXd0v8W3iGtcT9YiRbjrMaaPYxtuhOW5WGQDFOvcr+RosobXNkv
         IU0NHcjPktdxGwWJCxpH0TGKcBqmEpv39DPlxsyaNnAPLkRspZmoie9yPVG0jr//AZBM
         +7OknabTY7t9mRQkHldnFAlJMij4Vzz9AU0FXfDpuDEy9RvsnJGbKUHt8Eu3Vu2Mo/Es
         hJbw==
X-Forwarded-Encrypted: i=1; AJvYcCUXIf2OjcOuoBuOtwVMrdvJeTrOx2LMwENOSr0gk5spyhUVBrAgooW9T5ZMGeqVj6HZ9Qgwy5YZOgD8xMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjsFKgIpDu6Kca6as+Juk4RT14vrQhw7bT2EDQcnMHOydK1zE
	UpQ8UuT3SJCN9qHA3XUoG7e2jK4vSuDF9M49b6yvbrG3549Mc8WoNGO+XormNPefn3Q=
X-Gm-Gg: ASbGncv9H5H4fwxPtcvyZeTGNHPSsqR3xgpYQyl3Zo2PjIi2MofXD+VmF+hFf8BCRpb
	gsW6YMR8jiS8O9UDer2DpCJrd3boxm3Au6yRiwDXM6OgEBTiiQ2gObMMZRfefLQF2MJqgcREjhG
	F/H0uFOZdkoQ+mXAyaONzxvFtyNj1E6DqnY4dg685aOqqUyacZ9B+2f4nd3/zwBkR6BcIhJjI8q
	32dLtdJukduVdj3C6Il2L+zxOp+T1SVZEbwiGPBVUEF0HO8fnMqyrJLeOUrgTFeH3E7Vphwsvs/
	Pu8MZNUYYdJoteZajIm22KyoeCecExuKfh9D6vKFtJYOrGmLlKZRmAnSL1vCOGPlj7b64ekVGH+
	H9+HmhI+VbfZxqlQP76NGmbqKchemIe7xH7izc1dmhjeKjsySXbSVgTY745IY1knbxAx8UIaqhp
	g0TpJtHJZQrwe6B4g/YtnLMhOWnpUwkYncUkfa9LTN5NcYfj8CS1dfuqYpHw==
X-Google-Smtp-Source: AGHT+IH//IxQyYKyB5E1QEm5vaYIp9M6eCvuPoYVqMg/AVtwUeanmUa0KKSrJP5wn5URAlX+DhkZZQ==
X-Received: by 2002:a05:6a00:4fcf:b0:781:1a9f:aeeb with SMTP id d2e1a72fcca58-7a776e94027mr3603542b3a.1.1761905102532;
        Fri, 31 Oct 2025 03:05:02 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982117sm1644352b3a.15.2025.10.31.03.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:05:02 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
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
Subject: [PATCH v5 2/2] drm/panel: ilitek-ili9882t: Add support for Ilitek IL79900A-based panels
Date: Fri, 31 Oct 2025 18:04:47 +0800
Message-Id: <20251031100447.253164-3-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031100447.253164-1-yelangyan@huaqin.corp-partner.google.com>
References: <20251031100447.253164-1-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Ilitek IL79900A display controller is similar to the ILI9882T and can
be supported within the existing `panel-ilitek-ili9882t.c` driver.

This patch extends the ILI9882T driver to handle IL79900A-based panels,
such as the Tianma TL121BVMS07-00. The IL79900A uses a similar command
sequence and initialization flow, with minor differences in power supply
configuration and timing.

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 85c7059be214..c52f20863fc7 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -61,6 +61,13 @@ struct ili9882t {
 	mipi_dsi_dcs_write_seq_multi(ctx, ILI9882T_DCS_SWITCH_PAGE, \
 				     0x98, 0x82, (page))
 
+/* IL79900A-specific commands, add new commands as you decode them */
+#define IL79900A_DCS_SWITCH_PAGE	0xFF
+
+#define il79900a_switch_page(ctx, page) \
+	mipi_dsi_dcs_write_seq_multi(ctx, IL79900A_DCS_SWITCH_PAGE, \
+				     0x5a, 0xa5, (page))
+
 static int starry_ili9882t_init(struct ili9882t *ili)
 {
 	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
@@ -413,6 +420,38 @@ static int starry_ili9882t_init(struct ili9882t *ili)
 	return ctx.accum_err;
 };
 
+static int tianma_il79900a_init(struct ili9882t *ili)
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
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
+
+	mipi_dsi_msleep(&ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
+
+	mipi_dsi_msleep(&ctx, 80);
+
+	return 0;
+};
+
 static inline struct ili9882t *to_ili9882t(struct drm_panel *panel)
 {
 	return container_of(panel, struct ili9882t, base);
@@ -529,6 +568,19 @@ static const struct drm_display_mode starry_ili9882t_default_mode = {
 	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 };
 
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
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
 static const struct panel_desc starry_ili9882t_desc = {
 	.modes = &starry_ili9882t_default_mode,
 	.bpc = 8,
@@ -543,6 +595,20 @@ static const struct panel_desc starry_ili9882t_desc = {
 	.init = starry_ili9882t_init,
 };
 
+static const struct panel_desc tianma_tl121bvms07_desc = {
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
 static int ili9882t_get_modes(struct drm_panel *panel,
 			      struct drm_connector *connector)
 {
@@ -680,6 +746,9 @@ static const struct of_device_id ili9882t_of_match[] = {
 	{ .compatible = "starry,ili9882t",
 	  .data = &starry_ili9882t_desc
 	},
+	{ .compatible = "tianma,tl121bvms07-00",
+	  .data = &tianma_tl121bvms07_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ili9882t_of_match);
-- 
2.34.1



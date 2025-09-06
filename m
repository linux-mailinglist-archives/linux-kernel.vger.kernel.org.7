Return-Path: <linux-kernel+bounces-804316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA90B471E0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2351C24803
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D56289811;
	Sat,  6 Sep 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="omvFoEId";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="O6rumKYe"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C931224240;
	Sat,  6 Sep 2025 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171917; cv=none; b=QluF/rk3vqF9DDoc7AXOc+DjlqhriBfyzePqL0fIUA6mnYPCL6wIJuI3npEOl2KEcY41Ab2fzi7bhbt1eSWukF9HFULjnFk7ZwdJxeKeIbUOeWChoLc3/iYyVe4g3lwomomlJ5LRnqgwWVeON+YuHXR/wVtoWx7fghYNxgxEKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171917; c=relaxed/simple;
	bh=ifqCx8unph7aTJwnUP4w6DR157Jzj/htkEOxOLpHPec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stE7r+XI/j/VA2Dj9Rym1FM6UxAOt9Wxx5J2Kd5hC3vRAh862RBoOhi6ur6ijipTkEznK4Qkhn0L3jggPcJ/XQ5HVM4xkEhuPkL/JeqMa68TvILbD4LbnOEUenkweMJMmPUpiUc2L1IPn+piUush/Q3ijGy6leP1Jd0KXK2Q1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=omvFoEId; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=O6rumKYe; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757171907; bh=ifqCx8unph7aTJwnUP4w6DR157Jzj/htkEOxOLpHPec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=omvFoEIduChhwvEruxrKKxi3TXHgTm9iyZLUX3nhW3guLFk48bkYfrLdLK8UKc3KP
	 jD08uswziFk9hfPowJ2P3qkOTh3qAKpKN7cUpfmOG9tVotxF2s7qo32ZbxEUasLpxi
	 t25ANMHcYB12YC9MKkcVqhXMqt7b0pnjQasKW7lLQrwKanFRQoE+ZvjLPztOVZmMXF
	 i11TKCTaOLpwwURVplHHZaSvSiKzk43q4I3bWTheHzxqJmRPmNDcjUSuZ00k5V5uVe
	 xKoqgR+QYUB+3Jzg6obTY66foRmNhhlC9cnbmhVep6dSvGGw2mdQywRyyhtEQfwupy
	 o12pkRVG9JBLA==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 853EBFB05;
	Sat,  6 Sep 2025 17:18:27 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nFC-YZS6P2uS; Sat,  6 Sep 2025 17:18:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757171901; bh=ifqCx8unph7aTJwnUP4w6DR157Jzj/htkEOxOLpHPec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O6rumKYexiAYjeiLc3bx0nPB3+0qYQaUK5Of/eSM3Zs2eZiMyiXapunFNm3CQXXML
	 JANxI/SXkxYzNNy6SwQgcgx2DicdakBO6rvOcFZqKUkY3iwRzGiF7VlaRSPWOguJQl
	 E9fAJkgVYTYRjofoyFvMFF68+Iva1PWx7NjCK5glBW+574J/+OQroqpYAa9u6YPtLK
	 aUsxC5eTnhkdsakNTwPZqtMzUTgctg+/JibUuMg1AlJ+bqzasnfQ9qfCBTMAuxLvbO
	 S7yFEYevUaWdUJy+53197NPNcEq3qk/QvN0FQUimleYzjzyeX3Q+8m/dcdF+MU2kvl
	 wOHfED0h78UDA==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Sat, 06 Sep 2025 17:17:27 +0200
Subject: [PATCH v2 3/3] drm/panel: visionox-rm69299: Add backlight support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250906-shift6mq-panel-v2-3-aa5e585d8717@sigxcpu.org>
References: <20250906-shift6mq-panel-v2-0-aa5e585d8717@sigxcpu.org>
In-Reply-To: <20250906-shift6mq-panel-v2-0-aa5e585d8717@sigxcpu.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3690; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=ifqCx8unph7aTJwnUP4w6DR157Jzj/htkEOxOLpHPec=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm92RkMwT0hrMFhSemRPVEROa1puYmpUVzBMY1czCldLK2I5QnloTjdPQkdKMWN4
 UldKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYUx4UXRBQUt
 DUkFsdjRaU1N2ekI0NGtBRC80am5teHY5L0srOFE1WkZ5am1aL0FLWk1haFRxYjJNbWlzMnVHcg
 ptcWVnNkhVcnJINzRGY0hEMTZBMUpYSFVRZmNOT0haTFVLd1ArMU1qak9NUVY4NVlkbXQ2NDAxe
 Hg0Zm5vazlSCk5HQWZxVFJta2dZUkhiZDRXMXlYWmFYNjd6eWhHZ3ZGczBGQWJ4Z2lDNXRtZWNU
 U1V1SUdCMTJCR3gwc3JLSkIKMzdVTG01cHZXOWNXdFV1VkxPY0hqQVRuZld3cytJRi9nbjRrOFl
 sZ2p3SWgyMW11NFdLTGs1S0J5NXJVSVYzdAo2ODRkMmRXU1M1RmhOeld3RTRxTWNKaDd1TTI5SW
 RNc0l2YlhWczFiZEt5MHdaVXlydFNBZWJ6WEVKMDVCQkVvCkNpQmNqWldsd1Nia3BvV1dRWTBGa
 XhvNG1KODR6QzJIQ25GSDkwMVZTWVBUU0hydnBpdHBCdndaL2E1VjZkTGMKaXV4YjVuOTFDL1k5
 VkUrRmEzQ25iRFdoZHM4cEdmdmhwQzZHRTdOM09rVGdtVzU0RTcwVk4vb3J0VGI3M2UzQgp2cEM
 yN2VtZnF6OFp1anZGb2tXemxJb2s1NnJDUU83dkRDSTMwQmpzQVYyUTcvSXE3dkpQVzBEbGpPTC
 9YV0ptCk5nTktnT1BlNlIrWXd5eXdSdktlNEFIN01FVVY3d2RTRk5CODdxWkFyYXc0MllIeWVIN
 2JCanFRb0lXajVIczIKcHVYTUpsY3dYYUR2eUsxbUkyQ3NDWW04Z2QzSGJYVWFHZUlOaGtUNGVo
 QkRWODJpK0RhOWI3TjA1Q1hxSEIwKwpMeWxhUTd5OWptWVFDRW9jMW9IVGNJUmt0RjFaaGJyclN
 uQWVUQ0RNM29nWFovRTFjRkpGY21sMmhrS1JKTEtFCkZENkFJdz09Cj1BMlk0Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3

The shift6mq's variant supports controlling the backlight via DSI
commands. Use that if a max_brightness is set in the device specific
data.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 67 ++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 2216d38366ea37368d15480f9d8a8ccbfe77ba3b..5e5ff6056c80e67a5bf8fe4911cdbc588db5d03b 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/property.h>
@@ -20,6 +21,8 @@ struct visionox_rm69299_panel_desc {
 	const struct drm_display_mode *mode;
 	const u8 *init_seq;
 	unsigned int init_seq_len;
+	int max_brightness;
+	int initial_brightness;
 };
 
 struct visionox_rm69299 {
@@ -285,6 +288,63 @@ static const struct drm_panel_funcs visionox_rm69299_drm_funcs = {
 	.get_modes = visionox_rm69299_get_modes,
 };
 
+static int visionox_rm69299_bl_get_brightness(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness;
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return brightness;
+}
+
+static int visionox_rm69299_bl_update_status(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness = backlight_get_brightness(bl);
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return 0;
+}
+
+static const struct backlight_ops visionox_rm69299_bl_ops = {
+	.update_status = visionox_rm69299_bl_update_status,
+	.get_brightness = visionox_rm69299_bl_get_brightness,
+};
+
+static struct backlight_device *
+visionox_rm69299_create_backlight(struct visionox_rm69299 *ctx)
+{
+	struct device *dev = &ctx->dsi->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = ctx->desc->initial_brightness,
+		.max_brightness = ctx->desc->max_brightness,
+	};
+
+	if (!ctx->desc->max_brightness)
+		return 0;
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, ctx->dsi,
+					      &visionox_rm69299_bl_ops,
+					      &props);
+}
+
 static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -316,6 +376,11 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
+	ctx->panel.backlight = visionox_rm69299_create_backlight(ctx);
+	if (IS_ERR(ctx->panel.backlight))
+		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
+				     "Failed to create backlight\n");
+
 	drm_panel_add(&ctx->panel);
 
 	dsi->lanes = 4;
@@ -353,6 +418,8 @@ const struct visionox_rm69299_panel_desc visionox_rm69299_shift_desc = {
 	.mode = &visionox_rm69299_1080x2160_60hz,
 	.init_seq = (const u8 *)visionox_rm69299_1080x2160_60hz_init_seq,
 	.init_seq_len = ARRAY_SIZE(visionox_rm69299_1080x2160_60hz_init_seq),
+	.max_brightness = 255,
+	.initial_brightness = 50,
 };
 
 static const struct of_device_id visionox_rm69299_of_match[] = {

-- 
2.51.0



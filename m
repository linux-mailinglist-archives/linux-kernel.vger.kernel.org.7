Return-Path: <linux-kernel+bounces-810693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62733B51E06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749D73BB1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B864271446;
	Wed, 10 Sep 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="xsFVk8Ds";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="W4IO7sqX"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DFE2773FC;
	Wed, 10 Sep 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522463; cv=none; b=RmyqdUV41thZUJSzUr101p6YROpsnyClT07YKaNu8rj9oOtTao0ikO4u4YqE+VuvhWDIswZ/2D2dfrGzNrb5+1Pz/Ri5gkMIemm0yjIMHtNtBizQxG3efKs/9RvhyAFHP/ok6uF4tbFvx8hjEwXkGwVwtE/pZiNZdUMyD2Q7tek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522463; c=relaxed/simple;
	bh=9Yw8grUh1cFbMy7hkshDzj8q9xtvDCOgYiEuQuV7J9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HIsKQtTd++wa9z9P4/tJh95/pvywZQHCmUrmSjQz8VdsS7ObfN4PEDPLRY7E2jwz7frmIYgnZQTXOEFjdReUu/0D7hxdirY17lFYBSoi/SGdjIJlu3tZIdzAXoeubXOEDwAXISyQsudrcomouiAu4sMuNZ5AN+08X1qLi0KEqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=xsFVk8Ds; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=W4IO7sqX; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757522453; bh=9Yw8grUh1cFbMy7hkshDzj8q9xtvDCOgYiEuQuV7J9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=xsFVk8DsqIGPSC+X7iAv0Mg1cNVHKktwiyjXwxvMSXt9M0K4A7rvPcdgVTehb6xFg
	 10foLL8BsTJlafCldlxEF6qkAkPbVopf+eISE2NagCiXNZvauNWZkMAEq7L0Pn+Q2z
	 AeHn2nBDWk1qLzbmM3gLXWGcJJArtj3PQtpxdzAKDwHT9uONOJUyr+60RN6Wm/2+Cy
	 5nZi8gwShHJVr05RNBI+6AQ6b8JpSRwI0Co9Ym+j7FzaT6ZiwAtIEV8zzWUxtrMU5P
	 mHHztVnoL4Hg9JFihQ7xe9eajuzhkKUYyWiIchgalhNZsKNppgEBMrBGdqbHme2tkn
	 U/4hE9vOhT1iQ==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 41FC3FB06;
	Wed, 10 Sep 2025 18:40:53 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ys9VigrlREY; Wed, 10 Sep 2025 18:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757522443; bh=9Yw8grUh1cFbMy7hkshDzj8q9xtvDCOgYiEuQuV7J9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W4IO7sqX6tRHtGIITLRKPkLbTviYwhyvT7Nk20CsnDi14NyT/QUwZewg0+baGb6wg
	 SRN/lUtGVcu4wR+SgPCy5ulXzvvRClceArb7UN5ZBGJQfuL0FqkXsWPycRoE7ymUJy
	 UGo7qnE4AWgzOX/hOPEnl8Hq4CW0fqfpy02GerQVEPoDbgoD6ve0jYScePXQN4kXQG
	 zQQ+mvNjZvRv3pkY6yp5Xo132vX5d6CaXofvRSD9rJPG9tp++9vQnt+0IMGgLGGeLA
	 KkyWnmhjHFff4Wy11zgJdkXtzLa1UPYAMHSD55o6UhLh0OoEDwBDVTSFSW2AvOlpu+
	 LF58ZO9sCnJVw==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Wed, 10 Sep 2025 18:39:58 +0200
Subject: [PATCH v3 3/3] drm/panel: visionox-rm69299: Add backlight support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-shift6mq-panel-v3-3-a7729911afb9@sigxcpu.org>
References: <20250910-shift6mq-panel-v3-0-a7729911afb9@sigxcpu.org>
In-Reply-To: <20250910-shift6mq-panel-v3-0-a7729911afb9@sigxcpu.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Kaehlcke <mka@chromium.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3690; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=9Yw8grUh1cFbMy7hkshDzj8q9xtvDCOgYiEuQuV7J9k=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm93YW9FOTBXcnRUN2lwQnRFYmUrRDdzMkYyMm5UCm9KQnU0OXMraFVmL2hVWEhB
 OENKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYU1HcUJBQUt
 DUkFsdjRaU1N2ekI0ODVqRUFDRlBNaHIvNEQzbXdPVEozNW1HOGxuWVJzYTRTVFZMZzRrN1F2bQ
 pzaHNROFk0d1dkbWJHY3llQlhKQUZqRUFOZ1VsRUxsK3A5Z1VtWGpNSFA4QUhvd0hzOEdEVWFYc
 U1jRlRqaDkzCmNrb1pPOUVsRFAzaW1URjU5WkkzczYyYXVlOTlmUjhranJ2ZnFydlVqOTc1d0Rw
 M2tMTjUxYUJUakRDVkNaRi8KZ3h6a1lQUUw3a2pOR2FFcG40cFpHaWhQWHVxc3RiZUpYUlNmNE5
 jM0JnOUEzTTNBQ2oxRlVKdjVSSUtDTnFkYwptU1QvOEUyYXlOTVNXa2pjVnpaZU4wODQwaTBQeW
 FBOGRpMTZDd21FREd3RUYzbFhpMnVjaFJvRUoyUGRSMTJxCjdadzdNaE9idS84TXdnWXljSmVzL
 zhrcXQwVjMxYWVjNEplVndCU0pyL1drdEdvQldTaWVBUGNsWW1US1oxMmwKRUs1N1RCWldtV3Ba
 OGFXVjlwVjd6dm8vak53dlJ1UGkva1c4MmVHMkNOSnRnMTVhSjlFL3E2Q0NzZUkwMHJEdQpKVFN
 wVlBHQXFiTStnWG9rZnY3SXNhZGM2QlhQOUpBN01SdllsZHFmbGZKb0x6ZmtHZDRXd0FreUhaR1
 NiWHUzCk9MbzJXTjQ2bVRsdCtJRndMTzA5ekRDTlZibXZsK2NqcDV1dUhNSnRReUhKWllYRlpVZ
 3g1eXFmN1RyeUdqMEEKQjViT25CcHZRQzMwcENvRHdJS3FUdFJlcDNuWTlwa25WaUFHTXRPeEFJ
 VXNvTEU4VGRvSlplTkorenZWSWd4RQpwWkdURytBb25vblRUdlhDcDVodTEzWnRCdEpyekk0c05
 OTVVDWGNmVHJkUTBlQVk2U2pqYVBoSzA1akVCdjNWClU5NGlmZz09Cj1iQ3JjCi0tLS0tRU5EIF
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
index 66c30db3b73a71f23b587b6e994a22dba5e85d25..e5e688cf98fdc571ae9726f3c9afe7c83db1caf7 100644
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



Return-Path: <linux-kernel+bounces-748946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C766B147E6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D9D4E439C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D767E2494F8;
	Tue, 29 Jul 2025 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="GddqZDia"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF1246BAF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767894; cv=none; b=hcAS+LOon+WB+Xl7ewbst4QNlprSLgo5JAlbq/nPR4Zmw+CePxSaYGQSb0Vev8WyKuKmZ5joSBJL66KzHwbbhLbK1OJTgNVuTpO5cepsAKa4R+NgZIMMrY0y8BiXvRqFNoxiab0TE8FLWFJlZnq5V6BGEER3xASHZmvJlxsOtXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767894; c=relaxed/simple;
	bh=yobi2p0pLeWDZVdDfR07HBHFAOsj7C+c/CBCoHHONno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AglUio8mK+sMmLNcWk0ItyFbYuRwV1UnndiNetP1grHzBJfzRl14tzR+W334vzoQYtIvhgWA0jHbObEGIPixBEMk6T9PmePWBERU+GwareL9s2vLm24MiHW3DS6xIKVE4wTGEOsTBnFNBEZaa5mYCp9Ll/roZyU5yeEMzF/hQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=GddqZDia; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-769a9c3bbc4so352223b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753767892; x=1754372692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COKSRSkCv2e/sYoB0EHqFBJc3uH7WpbNSgSDA8clFRo=;
        b=GddqZDiaouiLkBvALCy5DCMm8EPNLJQZ7gazaVYyou68YCb4qzcoJLMwxGAAxWbGcz
         aN5j+cJxoiznhlVv193IyKoYYhHvMO1cTNEARvXeukk7e3EfhV2hGeZES4zMg4M6OE3c
         jn07m7JI4gFl4Y4TXu8GnCw4uckUPkwIVNyXS7pdp3a4u+GYqz23LcCp6nSkMRAum7Sn
         dar2wydRN6/aSzg5qW52TxJlUTCL2AnA1XfOIudiGfT+tzjzm38Z6oYluTAGA6YNgyRl
         jxx8zMxhROLn6+F4H9OTFaZCS8tYuB568LjWXgv0tYltnniupDgl3CVNrVXoCDwOSK2D
         40rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767892; x=1754372692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COKSRSkCv2e/sYoB0EHqFBJc3uH7WpbNSgSDA8clFRo=;
        b=wSJQnC6BoI4kz8u4RcdNGXW53+bt2VFUIdt52cvGELTQutaNCdGroe2y8mnmUw7+p+
         N1nB6X+sl67yHTbuL5nAl8WFxijfaplAi7J6I9Ac+fZS1gSI8HKjXwJvb841K3StTL5g
         9iuNJbriL6Uzmv4/cHCkpST7NYgvCIFNTKQFPYCksocxeSTo6n5RL3mAG3AZwX/sRtju
         ZXW6rDh/8uuiODg79RyXwUEW1KbRFLmp6wT3eTFM4jGAKOnGa6EL3p3amQRz+vQV4zXh
         DaYFKfkuuX/E6Ox9ZvlV3fdibfHE0BrWoZePM0AHzTMQJYZNrGWHwCtNVcZwoakLNU43
         8ltw==
X-Forwarded-Encrypted: i=1; AJvYcCWR1m2FIjG+WVJtccnErdEw2ZG5cOrFnUqpluPM8aAEEXwLhiacB9xfNUjrW7wjiW+lDcQ47wEgThR5dKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Mu3z66lkZ3v/OA8xFxeZxyf1UUgkxuTUkQElnN5eVCEYVchs
	oU1NewQ815imreef8tMSXrmu3TGgj+k074jyfFJaT0GSWaS5CKfTGWqrcwq2KJMNb4g=
X-Gm-Gg: ASbGncsyFljrWe8sI/5hO3RLok+g+TFFFMxh5rzXNPc1Et8QJQjC4mrUWX/21JMnRFb
	OVglsOvsrXK9WQLeGRnRHiwkc9swHyF0qIp//XF8ygVyGflv92G6AKHX3v9vwC5L+2dbL6iLdUH
	2qlf9RAMTmzW68Nbra24PZB2HC3Y9Wwo5RHS0yGHRIQGPImnP+Smwk9XIUhEH+bge9K7Z3H195c
	t3Y008qAEjb4j9pNkaoxVg9Xl9q/Ijsq1DqBPdd4hzxhZucsL8+O5fWWPQs0TtCG7/4BxPCb8ng
	MmZLeTB2DJR7VG+ARYrgF5aimFYHzXf6l10rQksKym91T+Ukq5xVWJ4VI0bRayahn20rJ5/ZeJO
	Y6UCDzeXO0aMauWuS3xAtt/IlAhXnsJNfrHuXWdeviILsoMFG4g==
X-Google-Smtp-Source: AGHT+IEKT4VdUWeYSI+Yxmg18Ry8MecXTM672YvlbxnqiUXUEIyKJRacPTbA4pdEHGHlr/606bjVYg==
X-Received: by 2002:a05:6a21:339b:b0:232:1d30:cd90 with SMTP id adf61e73a8af0-23d6ffe4a50mr20873371637.5.1753767891630;
        Mon, 28 Jul 2025 22:44:51 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640872a500sm6972462b3a.22.2025.07.28.22.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:44:50 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linus.walleij@linaro.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	sam@ravnborg.org
Cc: dianders@chromium.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v2 3/3] drm/panel: novatek-nt35560: Clean up driver
Date: Mon, 28 Jul 2025 23:44:35 -0600
Message-ID: <20250729054435.1209156-4-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729054435.1209156-1-me@brighamcampbell.com>
References: <20250729054435.1209156-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update driver to use the "multi" variants of MIPI functions which
facilitate improved error handling and cleaner driver code.

Remove information from a comment which was made obsolete by commit
994ea402c767 ("drm/panel: Rename Sony ACX424 to Novatek NT35560"), which
determined that this driver supports the Novatek NT35560 panel
controller.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 198 ++++++------------
 1 file changed, 60 insertions(+), 138 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35560.c b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
index 17898a29efe8..561e6643dcbb 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35560.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
@@ -148,24 +148,20 @@ static inline struct nt35560 *panel_to_nt35560(struct drm_panel *panel)
 static int nt35560_set_brightness(struct backlight_device *bl)
 {
 	struct nt35560 *nt = bl_get_data(bl);
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(nt->dev);
-	int period_ns = 1023;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = to_mipi_dsi_device(nt->dev)
+	};
 	int duty_ns = bl->props.brightness;
+	int period_ns = 1023;
 	u8 pwm_ratio;
 	u8 pwm_div;
-	u8 par;
-	int ret;
 
 	if (backlight_is_blank(bl)) {
 		/* Disable backlight */
-		par = 0x00;
-		ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
-					 &par, 1);
-		if (ret < 0) {
-			dev_err(nt->dev, "failed to disable display backlight (%d)\n", ret);
-			return ret;
-		}
-		return 0;
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
+					     MIPI_DCS_WRITE_CONTROL_DISPLAY,
+					     0x00);
+		return dsi_ctx.accum_err;
 	}
 
 	/* Calculate the PWM duty cycle in n/256's */
@@ -176,12 +172,6 @@ static int nt35560_set_brightness(struct backlight_device *bl)
 
 	/* Set up PWM dutycycle ONE byte (differs from the standard) */
 	dev_dbg(nt->dev, "calculated duty cycle %02x\n", pwm_ratio);
-	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
-				 &pwm_ratio, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "failed to set display PWM ratio (%d)\n", ret);
-		return ret;
-	}
 
 	/*
 	 * Sequence to write PWMDIV:
@@ -192,46 +182,23 @@ static int nt35560_set_brightness(struct backlight_device *bl)
 	 *	0x22		PWMDIV
 	 *	0x7F		0xAA   CMD2 page 1 lock
 	 */
-	par = 0xaa;
-	ret = mipi_dsi_dcs_write(dsi, 0xf3, &par, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "failed to unlock CMD 2 (%d)\n", ret);
-		return ret;
-	}
-	par = 0x01;
-	ret = mipi_dsi_dcs_write(dsi, 0x00, &par, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "failed to enter page 1 (%d)\n", ret);
-		return ret;
-	}
-	par = 0x01;
-	ret = mipi_dsi_dcs_write(dsi, 0x7d, &par, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "failed to disable MTP reload (%d)\n", ret);
-		return ret;
-	}
-	ret = mipi_dsi_dcs_write(dsi, 0x22, &pwm_div, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "failed to set PWM divisor (%d)\n", ret);
-		return ret;
-	}
-	par = 0xaa;
-	ret = mipi_dsi_dcs_write(dsi, 0x7f, &par, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "failed to lock CMD 2 (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_var_seq_multi(&dsi_ctx,
+					 MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
+					 pwm_ratio);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0xaa);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x01);
+
+	mipi_dsi_dcs_write_var_seq_multi(&dsi_ctx, 0x22, pwm_div);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0xaa);
 
 	/* Enable backlight */
-	par = 0x24;
-	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
-				 &par, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "failed to enable display backlight (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY,
+				     0x24);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static const struct backlight_ops nt35560_bl_ops = {
@@ -244,32 +211,23 @@ static const struct backlight_properties nt35560_bl_props = {
 	.max_brightness = 1023,
 };
 
-static int nt35560_read_id(struct nt35560 *nt)
+static void nt35560_read_id(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(nt->dev);
+	struct device dev = dsi_ctx->dsi->dev;
 	u8 vendor, version, panel;
 	u16 val;
-	int ret;
 
-	ret = mipi_dsi_dcs_read(dsi, NT35560_DCS_READ_ID1, &vendor, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "could not vendor ID byte\n");
-		return ret;
-	}
-	ret = mipi_dsi_dcs_read(dsi, NT35560_DCS_READ_ID2, &version, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "could not read device version byte\n");
-		return ret;
-	}
-	ret = mipi_dsi_dcs_read(dsi, NT35560_DCS_READ_ID3, &panel, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "could not read panel ID byte\n");
-		return ret;
-	}
+	mipi_dsi_dcs_read_multi(dsi_ctx, NT35560_DCS_READ_ID1, &vendor, 1);
+	mipi_dsi_dcs_read_multi(dsi_ctx, NT35560_DCS_READ_ID2, &version, 1);
+	mipi_dsi_dcs_read_multi(dsi_ctx, NT35560_DCS_READ_ID3, &panel, 1);
+
+	if (dsi_ctx->accum_err < 0)
+		return;
 
 	if (vendor == 0x00) {
-		dev_err(nt->dev, "device vendor ID is zero\n");
-		return -ENODEV;
+		dev_err(&dev, "device vendor ID is zero\n");
+		dsi_ctx->accum_err = -ENODEV;
+		return;
 	}
 
 	val = (vendor << 8) | panel;
@@ -278,16 +236,16 @@ static int nt35560_read_id(struct nt35560 *nt)
 	case DISPLAY_SONY_ACX424AKP_ID2:
 	case DISPLAY_SONY_ACX424AKP_ID3:
 	case DISPLAY_SONY_ACX424AKP_ID4:
-		dev_info(nt->dev, "MTP vendor: %02x, version: %02x, panel: %02x\n",
+		dev_info(&dev,
+			 "MTP vendor: %02x, version: %02x, panel: %02x\n",
 			 vendor, version, panel);
 		break;
 	default:
-		dev_info(nt->dev, "unknown vendor: %02x, version: %02x, panel: %02x\n",
+		dev_info(&dev,
+			 "unknown vendor: %02x, version: %02x, panel: %02x\n",
 			 vendor, version, panel);
 		break;
 	}
-
-	return 0;
 }
 
 static int nt35560_power_on(struct nt35560 *nt)
@@ -322,92 +280,56 @@ static void nt35560_power_off(struct nt35560 *nt)
 static int nt35560_prepare(struct drm_panel *panel)
 {
 	struct nt35560 *nt = panel_to_nt35560(panel);
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(nt->dev);
-	const u8 mddi = 3;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = to_mipi_dsi_device(nt->dev)
+	};
 	int ret;
 
 	ret = nt35560_power_on(nt);
 	if (ret)
 		return ret;
 
-	ret = nt35560_read_id(nt);
-	if (ret) {
-		dev_err(nt->dev, "failed to read panel ID (%d)\n", ret);
-		goto err_power_off;
-	}
+	nt35560_read_id(&dsi_ctx);
 
-	/* Enabe tearing mode: send TE (tearing effect) at VBLANK */
-	ret = mipi_dsi_dcs_set_tear_on(dsi,
+	/* Enable tearing mode: send TE (tearing effect) at VBLANK */
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx,
 				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret) {
-		dev_err(nt->dev, "failed to enable vblank TE (%d)\n", ret);
-		goto err_power_off;
-	}
 
 	/*
 	 * Set MDDI
 	 *
 	 * This presumably deactivates the Qualcomm MDDI interface and
 	 * selects DSI, similar code is found in other drivers such as the
-	 * Sharp LS043T1LE01 which makes us suspect that this panel may be
-	 * using a Novatek NT35565 or similar display driver chip that shares
-	 * this command. Due to the lack of documentation we cannot know for
-	 * sure.
+	 * Sharp LS043T1LE01.
 	 */
-	ret = mipi_dsi_dcs_write(dsi, NT35560_DCS_SET_MDDI,
-				 &mddi, sizeof(mddi));
-	if (ret < 0) {
-		dev_err(nt->dev, "failed to set MDDI (%d)\n", ret);
-		goto err_power_off;
-	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, NT35560_DCS_SET_MDDI, 3);
 
-	/* Exit sleep mode */
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret) {
-		dev_err(nt->dev, "failed to exit sleep mode (%d)\n", ret);
-		goto err_power_off;
-	}
-	msleep(140);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 140);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret) {
-		dev_err(nt->dev, "failed to turn display on (%d)\n", ret);
-		goto err_power_off;
-	}
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 	if (nt->video_mode) {
-		/* In video mode turn peripheral on */
-		ret = mipi_dsi_turn_on_peripheral(dsi);
-		if (ret) {
-			dev_err(nt->dev, "failed to turn on peripheral\n");
-			goto err_power_off;
-		}
+		mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
 	}
 
-	return 0;
-
-err_power_off:
-	nt35560_power_off(nt);
-	return ret;
+	if (dsi_ctx.accum_err < 0)
+		nt35560_power_off(nt);
+	return dsi_ctx.accum_err;
 }
 
 static int nt35560_unprepare(struct drm_panel *panel)
 {
 	struct nt35560 *nt = panel_to_nt35560(panel);
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(nt->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = to_mipi_dsi_device(nt->dev)
+	};
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret) {
-		dev_err(nt->dev, "failed to turn display off (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+
+	if (dsi_ctx.accum_err < 0)
+		return dsi_ctx.accum_err;
 
-	/* Enter sleep mode */
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret) {
-		dev_err(nt->dev, "failed to enter sleep mode (%d)\n", ret);
-		return ret;
-	}
 	msleep(85);
 
 	nt35560_power_off(nt);
-- 
2.50.1



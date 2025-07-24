Return-Path: <linux-kernel+bounces-744888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6B8B11227
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9367D7B9999
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70319253B56;
	Thu, 24 Jul 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="Qo7PzteH"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0E24678C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388629; cv=none; b=EvhfT2ng/1jrJVKEqHuyTfGhssBTKIsJfBFxWwpFa9Yc4MqWjSveiYDJIV3g4IQO1jF8ptK1Ox/LMSmYfaeq72u1Qm/cYsA4wd/C4eTsjO2lWv3Awg3RVNw3FMhRSSfCAk6Yqd+i9mF01bUt6zksCHF9f73VS+cr+8amswkDZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388629; c=relaxed/simple;
	bh=D2nzBWw+rmym8ekiQRD854CLb41uACrLZoLRZZVu8PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raHCNnPb+ojlgVeQhqqk482HbWjfVsU2anghrHpA5B6GpM8cxKq5EAMb4BY42IVL2ccf7zq+30IHNDDPZfFD3liZGAc+qReX3R7RVnmz1MoeZXh/Axa3K57IC/HhfMaR87uKLIomLIP1U7t3QtMy55HqiyMba58Y+XQGJzuAuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=Qo7PzteH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234fcadde3eso19306615ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753388627; x=1753993427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSasu8evaUWWMoOuuhmm9nOEmDXvMxCw6Wpj8VzSApY=;
        b=Qo7PzteHv8TERiRydqWZshlKRNKHqIDFGCC+ORpg6gGRIe6YbU/f1uemwfSAyQ5QTH
         VBw8ntKTDJ1VNdp72WiJfgqdEJPYx5u6luasQU8SM1W5qDGHLPMoayaDizd/HfW2EAkU
         4dzB7HKwIYzn3fAzdFjcQfczSNLpmmb80ALrZYghSGA718vuhGlt8tA68qn4P718gKGB
         HO1z75JXc7R4OTdZdpWmon/ilJqc/eObqxSdUHNhcdTPoZAK4LqjSilGwo9khrNOYag8
         WKdG3ixJxyZfOpD3dawAXHNbLjb+Ym5AwpVBTd4DPNLD/Xzxp1VWM4UGtYeGznCQmcnv
         WvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388627; x=1753993427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSasu8evaUWWMoOuuhmm9nOEmDXvMxCw6Wpj8VzSApY=;
        b=Po8IDYM5Nr5T+TmocDcA10lK14amXRrxFyP3azfIms6NLdStWLjf/gd373PKKIe9y4
         TpdJZJjkr8Q/5zH02o+dRpDTqxo4fWgp3rY2i2fHbcLVY8slC0TvKZtJWoVqXF+TluWx
         /giRi48/GKnM1HfW9sVRKGnipmtHzvTJRY+S1e/WnuMytKpzfR8WP99D5XwuXPfMogSH
         aGt6cMuZ4vLEVgNR27rMIRq5YX06gYK0gHFChwaTp4fu7+ycOjtjb1JGdXsKvF7Q33ms
         +j8jli/xUcgOBnOHNxIz5zWQg42HRJLBxPIkC+RpwdOF2hYwXl6Z22VQLlrymYjb/hvh
         ydeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP9iW5JItcb6V6LtJZ6EqHQpNiDXKKQlCQq+I/5O3B6ukEgZWRD9N/34WgKdiErcSP4XbLiHJqsT5oWBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrkMQX8V5xg3PCETQpIHIf/pz86xIHs+URNUUCDSHf4ixgyh/
	nEHJhOUaXTmfNevzbri0dJS5DWOfs7E/t/OTRkDo4nF/Zi28kiHKAWUiIvk51X7wbMk=
X-Gm-Gg: ASbGncvPNmM6TWBEkeLJHfSRKX57F5H+qsch8Kq8sr8fzsKhB75E+TgU0AlDpjhOcIG
	I8xpO55y/KOEZmeOpZCQZFH66HTtF/KDGqWa476V5BYweBkvY47BK2wHmwaNnDvQqi4+drQEwE+
	sD0KOfI/2KtTA9rBDrOUBJWxvCIaU+Ot/Ci8XGyVjyhQKY8NNtYzFUJkNW9MGEZb2HNPYcVsRgR
	TgzpPFgcXCmcASw9dwMMn285c9E7LFRciLkvnZ5N4DvkYa7WhlvIRCg5tkgpTxJsO6JPfO4rQoo
	Z+IVVM40BYD49najjZI/IJa03qIv/oW7IgggAYuM3cRj/IsNO2ffSfTlxRjHEvJJYs9rqdyGuN7
	bYP09AsucI2N35BIl1k0hzb76wtv7l6Rcr6kFxnVkkxYuoKTdIQ==
X-Google-Smtp-Source: AGHT+IHRgNWTC8OCTxYdaCU+FIFDMdBosmCQabhWPX3aueV8WhIlOuTIXZOUF8mCDwZ02ObeqMYCyw==
X-Received: by 2002:a17:903:fab:b0:23d:d2d2:b511 with SMTP id d9443c01a7336-23f9813f2dfmr113683615ad.19.1753388626899;
        Thu, 24 Jul 2025 13:23:46 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48dbfccsm22077815ad.138.2025.07.24.13.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:23:46 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/panel: novatek-nt35560: Fix bug and clean up
Date: Thu, 24 Jul 2025 14:23:38 -0600
Message-ID: <20250724202338.648499-3-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724202338.648499-1-me@brighamcampbell.com>
References: <20250724202338.648499-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bug in nt35560_set_brightness() which causes the function to
erroneously report an error. mipi_dsi_dcs_write() returns either a
negative value when an error occurred or a positive number of bytes
written when no error occurred. The buggy code reports and error under
either condition.

Update driver to use the "multi" variants of MIPI functions which
facilitate improved error handling and cleaner driver code.

Fixes: 7835ed6a9e86 ("drm/panel-sony-acx424akp: Modernize backlight handling")
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---

The usage of the u8 array, mipi_buf_out, in nt35560_set_brightness() may
be a little curious. It's useful here because pwm_ratio and pwm_div
aren't constant, therefore we must store them in a buffer at runtime.

Using mipi_dsi_dcs_write_{seq,buffer}_multi() in place of
mipi_dsi_dcs_write() gives the added benefit that kmalloc() isn't used
to write mipi commands.

The jdi-lpm102a188a driver's unprepare() function will ignore errors
reported by mipi_dsi_dcs_{set_display_off,enter_sleep_mode}. This
driver, however, will fail to unprepare the panel if either function
returns an error. The behavior of the jdi-lpm102a188a panel makes more
sense to me, but I strongly prefer not to change the behavior of this
driver without personally having access to hardware to test.

Removed information from a comment which was made obsolete by commit
994ea402c767 ("drm/panel: Rename Sony ACX424 to Novatek NT35560")

 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 212 ++++++------------
 1 file changed, 66 insertions(+), 146 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35560.c b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
index 98f0782c8411..60758ce1401e 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35560.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
@@ -148,24 +148,21 @@ static inline struct nt35560 *panel_to_nt35560(struct drm_panel *panel)
 static int nt35560_set_brightness(struct backlight_device *bl)
 {
 	struct nt35560 *nt = bl_get_data(bl);
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(nt->dev);
-	int period_ns = 1023;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = to_mipi_dsi_device(nt->dev)
+	};
 	int duty_ns = bl->props.brightness;
+	static u8 mipi_buf_out[2];
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
-		if (ret) {
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
@@ -176,62 +173,28 @@ static int nt35560_set_brightness(struct backlight_device *bl)
 
 	/* Set up PWM dutycycle ONE byte (differs from the standard) */
 	dev_dbg(nt->dev, "calculated duty cycle %02x\n", pwm_ratio);
-	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
-				 &pwm_ratio, 1);
-	if (ret < 0) {
-		dev_err(nt->dev, "failed to set display PWM ratio (%d)\n", ret);
-		return ret;
-	}
 
-	/*
-	 * Sequence to write PWMDIV:
-	 *	address		data
-	 *	0xF3		0xAA   CMD2 Unlock
-	 *	0x00		0x01   Enter CMD2 page 0
-	 *	0X7D		0x01   No reload MTP of CMD2 P1
-	 *	0x22		PWMDIV
-	 *	0x7F		0xAA   CMD2 page 1 lock
-	 */
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
+	mipi_buf_out[0] = MIPI_DCS_SET_DISPLAY_BRIGHTNESS;
+	mipi_buf_out[1] = pwm_ratio;
+	mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, mipi_buf_out,
+					ARRAY_SIZE(mipi_buf_out));
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0xaa);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x01);
+
+	mipi_buf_out[0] = 0x22;
+	mipi_buf_out[1] = pwm_div;
+	mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, mipi_buf_out,
+					ARRAY_SIZE(mipi_buf_out));
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
@@ -244,32 +207,23 @@ static const struct backlight_properties nt35560_bl_props = {
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
@@ -278,16 +232,18 @@ static int nt35560_read_id(struct nt35560 *nt)
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
 
-	return 0;
+	return;
 }
 
 static int nt35560_power_on(struct nt35560 *nt)
@@ -322,92 +278,56 @@ static void nt35560_power_off(struct nt35560 *nt)
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
+	 * Sharp LS043T1LE01
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



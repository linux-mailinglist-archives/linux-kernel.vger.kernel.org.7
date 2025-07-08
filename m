Return-Path: <linux-kernel+bounces-721063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D67AFC44D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBDD174159
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5908929ACF6;
	Tue,  8 Jul 2025 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="QP6XP51I"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DA299ABD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960351; cv=none; b=ZFxj8oqT6qgLvvKtGux/8f0N6aHckbm2esZDKYYUf5WCfyXUGJt1ziFEtRt1o1w7EJOdzuOuG6dVOJPqdNcQdqBDRYmXC1UKybMxtVUAKRUpkWAp5764R4uEy3jCyFJ+o9E5tBCL6B3UrZjyQFWg0ObK4zTjMCpuOpJsshzesPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960351; c=relaxed/simple;
	bh=Ci1N7Dwuf85dZbfJ4gM0FO7/K/9m4JSgEXVJKoKi3Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTO/B9S7eL7wx1tQNgzDmsKtqOmPeieEJmVepX/ulbiqEMa4UGxSI8MmbvonkF0D04RhFtQM4phNhP7mBQjcEj1yxzrsgjfzTNLrz4dv92VlyWgmcRpMe243/5lI3HDJfh0hONAF0eq62NwYcbEqYVRpJDckj8DoJDatOHaFwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=QP6XP51I; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7481600130eso5457811b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 00:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1751960349; x=1752565149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJltklMaBQd1uonax5ZyjgM8LqOkZCVtDNyE9v7JUsU=;
        b=QP6XP51If163mCyvYP+Npx4jvb/75/BSlvq3dShkzNaDPCrGFQp8xWfHSwaM9atPZa
         iaI0jKL/JeiH7M1OKqOjyLlFwzWEx2uffkAGdz0SPQkDCqpUnlpcBGf8F1OPt/Z2OISY
         8N68X3VoZALZXdfJoF98FjoFHnDDjM53PNv5erPzohd3KnfuW878RObh7fjKaziCSwsP
         WLiBUNf3eXsxaFVEcWwPNVpCvLR+r/wOMywHJYhud30B3/z6rgLCwlg8gbUVfnrmwFQX
         9+Z1NiblJjF+gsaMTLoUI7nerzf/yYGi3IWpPgoPJkNT6kRVAL8RGrwQJuJaVsUmR3SY
         OAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960349; x=1752565149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJltklMaBQd1uonax5ZyjgM8LqOkZCVtDNyE9v7JUsU=;
        b=qrNKwimGIV0Dj9KKp2TvX0bp9wEnWGQ6sdi0zR9ZaDXPZUWA6cPfRxkUHx/khhut+I
         Wa3Bq1sK5AO8MS8/37WK+W48Qm0Ab8qLg64uV8esmme1nUdkRNxvGNrOdgUi+al5/gb8
         VCqhEuMuyyjRy9p2RZvAucv/bJz3k2y80fLxgkeK2Cz1rMLWBBAQCvu58jH0c3ykUk19
         UDMMUoqPs9vWzljUSl80ThtQNXt/z7P2s0YzNxnbubvtNVtuOPYYsg0TztSLlc/J3f+z
         IRI8jdljW3Iks5+Dhd4tnHmeyqEjsnwkj5CeaLeqV/DYwZVdViiD8CjDZwl90EljjIu+
         kh5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrh91qr4hEGDZrliR9r06uGVrlbTsovZq7DicotJ2Pztil2xkPvr4KNaVh22A5UXypDcgBXuHHMhg9si0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywieSA6bhOP78bli468E9vMdgdk5ksYc6ngp0r4Hl5dGWipZIl
	J0kEQoveIEioLWibu9Dq+tgWxIZKO27on0gKNTuhFfrpvNvvsEF1e+8jP5YcXWYNORo=
X-Gm-Gg: ASbGncsH+ButXAUtQ+9s/gFbVWY9Nd993DNV9FZnUun+saVsZ/HHgXbnLrHQkQbt+dz
	QYd0LNXU8/VsMeumfCWIaGw0Tu9cOEDZTQTvEkZFFdUv0ONJaKjg4y2uhnjgf4sajzLDKztaBDh
	Mp4tW2DfpF8ew8BBxykk5pPMmmxu/rV/NWROqxG34DtkyLfRqpAVOUR1vaUNYgpNF/ogpC6vWsM
	7spRmGVZ2SyIDP+7hsldSbO9oqUfySRWVNJLdVO/Xm8QGtn/aGw4iT7El2hCM2lChGvd0xG2HGM
	IdyCER0Y6gnwMSMRvxt5vu7ZRQJ/f2oepWFdEeEh9NVt7ylWOH8oAUPW2kqLNYqoXel8LRmx30g
	auQvd/sbUgx61POR0gw==
X-Google-Smtp-Source: AGHT+IHqUANsx8EsCJUxSKG4kP9NMyIVzSoN04mrpiatlzPSJx49O9nENQOctY2sHFDwZ4RpAEfzug==
X-Received: by 2002:a05:6a00:14c9:b0:748:eb38:8830 with SMTP id d2e1a72fcca58-74ce6669b0emr19597687b3a.13.1751960349086;
        Tue, 08 Jul 2025 00:39:09 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a540bsm11633523b3a.140.2025.07.08.00.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 00:39:08 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v2 1/3] drm/panel: jdi-lpm102a188a: Update deprecated MIPI function calls
Date: Tue,  8 Jul 2025 01:38:58 -0600
Message-ID: <20250708073901.90027-2-me@brighamcampbell.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708073901.90027-1-me@brighamcampbell.com>
References: <20250708073901.90027-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update jdi-lpm102a188a panel driver to use the "multi" variant of MIPI
functions in order to facilitate improved error handling and remove the
panel's dependency on deprecated MIPI functions.

This patch's usage of the mipi_dsi_multi_context struct is not
idiomatic. Rightfully, the struct wasn't designed to cater to the needs
of panels with multiple MIPI DSI interfaces. This panel is an oddity
which requires swapping the dsi pointer between MIPI function calls in
order to preserve the exact behavior implemented using the non-multi
variant of the macro.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 160 +++++++-----------
 1 file changed, 59 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
index 5b5082efb282..5001bea1798f 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
@@ -81,25 +81,20 @@ static int jdi_panel_disable(struct drm_panel *panel)
 static int jdi_panel_unprepare(struct drm_panel *panel)
 {
 	struct jdi_panel *jdi = to_panel_jdi(panel);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx;
 
-	ret = mipi_dsi_dcs_set_display_off(jdi->link1);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", ret);
-
-	ret = mipi_dsi_dcs_set_display_off(jdi->link2);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+	dsi_ctx.dsi = jdi->link1;
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	dsi_ctx.dsi = jdi->link2;
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
 	/* Specified by JDI @ 50ms, subject to change */
 	msleep(50);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(jdi->link1);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
-	ret = mipi_dsi_dcs_enter_sleep_mode(jdi->link2);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
+	dsi_ctx.dsi = jdi->link1;
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	dsi_ctx.dsi = jdi->link2;
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	/* Specified by JDI @ 150ms, subject to change */
 	msleep(150);
@@ -123,72 +118,64 @@ static int jdi_panel_unprepare(struct drm_panel *panel)
 	/* Specified by JDI @ 20ms, subject to change */
 	msleep(20);
 
-	return ret;
+	return dsi_ctx.accum_err;
 }
 
 static int jdi_setup_symmetrical_split(struct mipi_dsi_device *left,
 				       struct mipi_dsi_device *right,
 				       const struct drm_display_mode *mode)
 {
-	int err;
+	struct mipi_dsi_multi_context dsi_ctx;
 
-	err = mipi_dsi_dcs_set_column_address(left, 0, mode->hdisplay / 2 - 1);
-	if (err < 0) {
-		dev_err(&left->dev, "failed to set column address: %d\n", err);
-		return err;
-	}
+	dsi_ctx.dsi = left;
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0, mode->hdisplay / 2 - 1);
+	dsi_ctx.dsi = right;
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0, mode->hdisplay / 2 - 1);
 
-	err = mipi_dsi_dcs_set_column_address(right, 0, mode->hdisplay / 2 - 1);
-	if (err < 0) {
-		dev_err(&right->dev, "failed to set column address: %d\n", err);
-		return err;
-	}
+	dsi_ctx.dsi = left;
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0, mode->vdisplay - 1);
+	dsi_ctx.dsi = right;
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0, mode->vdisplay - 1);
 
-	err = mipi_dsi_dcs_set_page_address(left, 0, mode->vdisplay - 1);
-	if (err < 0) {
-		dev_err(&left->dev, "failed to set page address: %d\n", err);
-		return err;
-	}
-
-	err = mipi_dsi_dcs_set_page_address(right, 0, mode->vdisplay - 1);
-	if (err < 0) {
-		dev_err(&right->dev, "failed to set page address: %d\n", err);
-		return err;
-	}
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
 {
+	struct mipi_dsi_multi_context dsi_ctx;
+
 	/* Clear the manufacturer command access protection */
-	mipi_dsi_generic_write_seq(jdi->link1, MCS_CMD_ACS_PROT,
+	dsi_ctx.dsi = jdi->link1;
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_CMD_ACS_PROT,
 				   MCS_CMD_ACS_PROT_OFF);
-	mipi_dsi_generic_write_seq(jdi->link2, MCS_CMD_ACS_PROT,
+	dsi_ctx.dsi = jdi->link2;
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_CMD_ACS_PROT,
 				   MCS_CMD_ACS_PROT_OFF);
 	/*
-	 * Change the VGH/VGL divide rations to move the noise generated by the
+	 * Change the VGH/VGL divide ratios to move the noise generated by the
 	 * TCONN. This should hopefully avoid interaction with the backlight
 	 * controller.
 	 */
-	mipi_dsi_generic_write_seq(jdi->link1, MCS_PWR_CTRL_FUNC,
+	dsi_ctx.dsi = jdi->link1;
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_PWR_CTRL_FUNC,
+				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
+				   MCS_PWR_CTRL_PARAM1_DEFAULT,
+				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
+				   MCS_PWR_CTRL_PARAM2_DEFAULT);
+	dsi_ctx.dsi = jdi->link2;
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_PWR_CTRL_FUNC,
 				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
 				   MCS_PWR_CTRL_PARAM1_DEFAULT,
 				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
 				   MCS_PWR_CTRL_PARAM2_DEFAULT);
 
-	mipi_dsi_generic_write_seq(jdi->link2, MCS_PWR_CTRL_FUNC,
-				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
-				   MCS_PWR_CTRL_PARAM1_DEFAULT,
-				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
-				   MCS_PWR_CTRL_PARAM2_DEFAULT);
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int jdi_panel_prepare(struct drm_panel *panel)
 {
 	struct jdi_panel *jdi = to_panel_jdi(panel);
+	struct mipi_dsi_multi_context dsi_ctx;
 	int err;
 
 	/* Disable backlight to avoid showing random pixels
@@ -239,57 +226,32 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	err = mipi_dsi_dcs_set_tear_scanline(jdi->link1,
+	dsi_ctx.dsi = jdi->link1;
+	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx,
 					     jdi->mode->vdisplay - 16);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear scanline: %d\n", err);
-		goto poweroff;
-	}
-
-	err = mipi_dsi_dcs_set_tear_scanline(jdi->link2,
+	dsi_ctx.dsi = jdi->link2;
+	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx,
 					     jdi->mode->vdisplay - 16);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear scanline: %d\n", err);
-		goto poweroff;
-	}
 
-	err = mipi_dsi_dcs_set_tear_on(jdi->link1,
+	dsi_ctx.dsi = jdi->link1;
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx,
 				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear on: %d\n", err);
-		goto poweroff;
-	}
-
-	err = mipi_dsi_dcs_set_tear_on(jdi->link2,
+	dsi_ctx.dsi = jdi->link2;
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx,
 				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear on: %d\n", err);
-		goto poweroff;
-	}
 
-	err = mipi_dsi_dcs_set_pixel_format(jdi->link1, MIPI_DCS_PIXEL_FMT_24BIT);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set pixel format: %d\n", err);
-		goto poweroff;
-	}
+	dsi_ctx.dsi = jdi->link1;
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx, MIPI_DCS_PIXEL_FMT_24BIT);
+	dsi_ctx.dsi = jdi->link2;
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx, MIPI_DCS_PIXEL_FMT_24BIT);
 
-	err = mipi_dsi_dcs_set_pixel_format(jdi->link2, MIPI_DCS_PIXEL_FMT_24BIT);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set pixel format: %d\n", err);
-		goto poweroff;
-	}
+	dsi_ctx.dsi = jdi->link1;
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	dsi_ctx.dsi = jdi->link2;
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
-	err = mipi_dsi_dcs_exit_sleep_mode(jdi->link1);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
+	if (dsi_ctx.accum_err < 0)
 		goto poweroff;
-	}
-
-	err = mipi_dsi_dcs_exit_sleep_mode(jdi->link2);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		goto poweroff;
-	}
 
 	err = jdi_write_dcdc_registers(jdi);
 	if (err < 0) {
@@ -302,17 +264,13 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 	 */
 	msleep(150);
 
-	err = mipi_dsi_dcs_set_display_on(jdi->link1);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
-		goto poweroff;
-	}
+	dsi_ctx.dsi = jdi->link1;
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	dsi_ctx.dsi = jdi->link2;
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	err = mipi_dsi_dcs_set_display_on(jdi->link2);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
+	if (dsi_ctx.accum_err < 0)
 		goto poweroff;
-	}
 
 	jdi->link1->mode_flags &= ~MIPI_DSI_MODE_LPM;
 	jdi->link2->mode_flags &= ~MIPI_DSI_MODE_LPM;
-- 
2.49.0



Return-Path: <linux-kernel+bounces-737633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79764B0AEAB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9879C4E1E30
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBE9238159;
	Sat, 19 Jul 2025 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="Ih1cdxrr"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81192367D9
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913628; cv=none; b=JNezeXTQK7DcAWe8Pu4ipdKsj0DrAN/FvosNIHz57qfV7z7281/4Eg32kW6y61CLigFdJpZeWDMTMLt3gW9/9mFQYYEXDysUKmjwvEyumNvqHcHxLhJBFsv1MPClJ8MujZ5YYTGlrhb9Fli46nWmpsBCtAkbGJhMIG8HBQkS8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913628; c=relaxed/simple;
	bh=hEUxj2idb7hiXYnoLISUQ6LiygwEV/cIZLteWEue9pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVTV4pA/gen0hKej6AcZZBp3JNh6K8GWfuK3cGkgN0Jvtv9h4j9JgyLU1At+7WucT5pJTSL2YtvteRdoWve7O0MztEC6LLP5hoiTgjGzgxzidP2rMTxeY7C+u7m1+eg86ukK9ZRodKqeufvThgIeteFvW7QJQhPUhg62WhU31xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=Ih1cdxrr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso2119365a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 01:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752913626; x=1753518426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUcB18wkzXWaipSAyhcb0vwOoxhZL3UK8zpTQMvqMYk=;
        b=Ih1cdxrrZIHKIc+Tbg79ICX/JALmpp6KJusu5ME0TSJHm1y0xK/A8ccteRI9K7Arn2
         DjoH4jAeshw95EtTJpsSgjvSWB63Ae10CeiJYOTk84GViYJYsUVLcDiIA5jW3fAMYJgN
         HGR/eZdwjV7Mp2ePKyRoltC6AheD6Z8YfP0Y4VHBZVBUm6HgXf+1fGXcaI9xc+TBx2nI
         h353/4xNJl2EXpfH+AchaUucF9CB7axwAxDQfhGN78z8wabGA7z6DDzDoMLRJc5dGHBy
         NLsW2rg3I+hqOQimOwle/rHJzD+kLHV4JCh3r7tBfcjFTZBWpBVAXwa3lbjZSr1+nBxQ
         1gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752913626; x=1753518426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUcB18wkzXWaipSAyhcb0vwOoxhZL3UK8zpTQMvqMYk=;
        b=l9Z3WuYLSPJdzx9LW152T4rtdjAkiNNss8VBUlhNw4BxQGtjonCNEI89TGgagWukNC
         PrAPAUNKWT8ww1LPo/eTaGZTQtsJ/NlLae1OHL23jM8olrnBIC1VHfw3g0Gp0U2qTVgP
         zxUKK7iQflJA/Aa+0bsZFecsSim1mfifvTUWw3SmvSIpNog1D2j1Xu1RoX8WPsO5nF2a
         jGnJxM8bMdNyBFrnMReB1dZRrwpPRWYmy/Sd/Ppbd15RYjaaqbVIc6B3sUeDHVji8Qqf
         Pj8MfSaHPbYW3DhDxSpcva4z2tA5ZOcPMLv0KeYf4uf+jrij+IxjvbmR7qUZ5mMbT6SA
         hQxA==
X-Forwarded-Encrypted: i=1; AJvYcCVVmyYgHk7qfc/Buiu3KqMtTnB2hPSSZCW+2dIFfS3AaHqfYLH1e4S/a5wHE+R0nnkZF+AL2R9ybiBwipE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1Ak44z9TWxJCWLDLMvDaxhFMxpzoP7cAoFzEGZ35Syv7HixG
	iuY2FmZEyfhRZ27yjxiIN98We5d9FUxizY+eGOdpHBElRhZiw8RQjB+JxXn8nUvtki8=
X-Gm-Gg: ASbGnct+w5ar7emiKqUS2IHlDMciEYT6oWTABnoEdLU0HoxiBwndhEpIfo1j+UnyAC8
	szJFcsb54EHRh5XHKMl6BKYPPNXXp+hsskjH7/EpXHl5aR0XTJPP7+xrWtJyk/oEbs8BuozhfuU
	tPXEUgjdGXJpmHvNm8zNf47HBON2N7YEoZ2Iaxs37jxvpr/5AKhUW9qsXhwHtLW/SU8j01nX5F6
	3U/EX8vuIXS2OA3GuV/A2H3ZUVmALlE4YmFZzHUHO0AUt4+KM2hyVDS/kzq1fGRRPLR2zvfkIsa
	ZWVKmBY1mVTIt/Y8KmiEvv//MIFf2CbHAK9S3LDmjNYbOyvZzJu820okZ1EvsEM8dpsmMxZXa02
	wj/Nf9B/KBw41Rw2Gck1JToCUUCpMh9vuxrTmP4qTVn0x49RHll2kHsjewg1c
X-Google-Smtp-Source: AGHT+IFPkdczjlK6LPkmOOuAv9fB6yl68RLosEVxYgGWeJCmhuywE1ktO67Cl/QDs6XE7vA8gZzPUw==
X-Received: by 2002:a05:6a21:6daa:b0:234:98ee:daae with SMTP id adf61e73a8af0-23812457aa5mr20792945637.21.1752913626173;
        Sat, 19 Jul 2025 01:27:06 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb157635sm2475260b3a.83.2025.07.19.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:27:05 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	diogo.ivo@tecnico.ulisboa.pt,
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
Subject: [PATCH v5 2/4] drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
Date: Sat, 19 Jul 2025 02:26:36 -0600
Message-ID: <20250719082639.307545-3-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250719082639.307545-1-me@brighamcampbell.com>
References: <20250719082639.307545-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bug in unprepare() which causes the function's return value to be
that of the last mipi "enter sleep mode" command.

Update driver to use the "multi" variant of MIPI functions in order to
facilitate improved error handling and remove the panel's dependency on
deprecated MIPI functions.

Use the new mipi_dsi_dual macro to reduce code duplication.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Tested-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 196 ++++++------------
 1 file changed, 59 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
index 5f897e143758..243483a58c45 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
@@ -81,25 +81,25 @@ static int jdi_panel_disable(struct drm_panel *panel)
 static int jdi_panel_unprepare(struct drm_panel *panel)
 {
 	struct jdi_panel *jdi = to_panel_jdi(panel);
-	int ret;
 
-	ret = mipi_dsi_dcs_set_display_off(jdi->link1);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+	/*
+	 * One context per panel since we'll continue trying to shut down the
+	 * other panel even if one isn't responding.
+	 */
+	struct mipi_dsi_multi_context dsi_ctx1 = { .dsi = jdi->link1 };
+	struct mipi_dsi_multi_context dsi_ctx2 = { .dsi = jdi->link2 };
 
-	ret = mipi_dsi_dcs_set_display_off(jdi->link2);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx1);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx2);
 
 	/* Specified by JDI @ 50ms, subject to change */
 	msleep(50);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(jdi->link1);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
-	ret = mipi_dsi_dcs_enter_sleep_mode(jdi->link2);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
+	/* Doesn't hurt to try sleep mode even if display off fails */
+	dsi_ctx1.accum_err = 0;
+	dsi_ctx2.accum_err = 0;
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx1);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx2);
 
 	/* Specified by JDI @ 150ms, subject to change */
 	msleep(150);
@@ -123,72 +123,46 @@ static int jdi_panel_unprepare(struct drm_panel *panel)
 	/* Specified by JDI @ 20ms, subject to change */
 	msleep(20);
 
-	return ret;
-}
-
-static int jdi_setup_symmetrical_split(struct mipi_dsi_device *left,
-				       struct mipi_dsi_device *right,
-				       const struct drm_display_mode *mode)
-{
-	int err;
-
-	err = mipi_dsi_dcs_set_column_address(left, 0, mode->hdisplay / 2 - 1);
-	if (err < 0) {
-		dev_err(&left->dev, "failed to set column address: %d\n", err);
-		return err;
-	}
-
-	err = mipi_dsi_dcs_set_column_address(right, 0, mode->hdisplay / 2 - 1);
-	if (err < 0) {
-		dev_err(&right->dev, "failed to set column address: %d\n", err);
-		return err;
-	}
-
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
 	return 0;
 }
 
-static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
+static void jdi_setup_symmetrical_split(struct mipi_dsi_multi_context *dsi_ctx,
+					struct mipi_dsi_device *left,
+					struct mipi_dsi_device *right,
+					const struct drm_display_mode *mode)
+{
+	mipi_dsi_dual(mipi_dsi_dcs_set_column_address_multi,
+		      left, right, dsi_ctx,
+		      0, mode->hdisplay / 2 - 1);
+	mipi_dsi_dual(mipi_dsi_dcs_set_page_address_multi,
+		      left, right, dsi_ctx,
+		      0, mode->vdisplay - 1);
+}
+
+static void jdi_write_dcdc_registers(struct mipi_dsi_multi_context *dsi_ctx,
+				     struct jdi_panel *jdi)
 {
 	/* Clear the manufacturer command access protection */
-	mipi_dsi_generic_write_seq(jdi->link1, MCS_CMD_ACS_PROT,
-				   MCS_CMD_ACS_PROT_OFF);
-	mipi_dsi_generic_write_seq(jdi->link2, MCS_CMD_ACS_PROT,
-				   MCS_CMD_ACS_PROT_OFF);
+	mipi_dsi_dual_generic_write_seq_multi(jdi->link1, jdi->link2, dsi_ctx,
+					      MCS_CMD_ACS_PROT,
+					      MCS_CMD_ACS_PROT_OFF);
 	/*
-	 * Change the VGH/VGL divide rations to move the noise generated by the
+	 * Change the VGH/VGL divide ratios to move the noise generated by the
 	 * TCONN. This should hopefully avoid interaction with the backlight
 	 * controller.
 	 */
-	mipi_dsi_generic_write_seq(jdi->link1, MCS_PWR_CTRL_FUNC,
-				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
-				   MCS_PWR_CTRL_PARAM1_DEFAULT,
-				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
-				   MCS_PWR_CTRL_PARAM2_DEFAULT);
-
-	mipi_dsi_generic_write_seq(jdi->link2, MCS_PWR_CTRL_FUNC,
-				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
-				   MCS_PWR_CTRL_PARAM1_DEFAULT,
-				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
-				   MCS_PWR_CTRL_PARAM2_DEFAULT);
-
-	return 0;
+	mipi_dsi_dual_generic_write_seq_multi(jdi->link1, jdi->link2, dsi_ctx,
+					      MCS_PWR_CTRL_FUNC,
+					      MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
+					      MCS_PWR_CTRL_PARAM1_DEFAULT,
+					      MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
+					      MCS_PWR_CTRL_PARAM2_DEFAULT);
 }
 
 static int jdi_panel_prepare(struct drm_panel *panel)
 {
 	struct jdi_panel *jdi = to_panel_jdi(panel);
+	struct mipi_dsi_multi_context dsi_ctx = {};
 	int err;
 
 	/* Disable backlight to avoid showing random pixels
@@ -231,88 +205,36 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 	 * put in place to communicate the configuration back to the DSI host
 	 * controller.
 	 */
-	err = jdi_setup_symmetrical_split(jdi->link1, jdi->link2,
-					  jdi->mode);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set up symmetrical split: %d\n",
-			err);
-		goto poweroff;
-	}
+	jdi_setup_symmetrical_split(&dsi_ctx, jdi->link1, jdi->link2,
+				    jdi->mode);
 
-	err = mipi_dsi_dcs_set_tear_scanline(jdi->link1,
-					     jdi->mode->vdisplay - 16);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear scanline: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dual(mipi_dsi_dcs_set_tear_scanline_multi,
+		      jdi->link1, jdi->link2, &dsi_ctx,
+		      jdi->mode->vdisplay - 16);
 
-	err = mipi_dsi_dcs_set_tear_scanline(jdi->link2,
-					     jdi->mode->vdisplay - 16);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear scanline: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dual(mipi_dsi_dcs_set_tear_on_multi,
+		      jdi->link1, jdi->link2, &dsi_ctx,
+		      MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 
-	err = mipi_dsi_dcs_set_tear_on(jdi->link1,
-				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear on: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dual(mipi_dsi_dcs_set_pixel_format_multi,
+		      jdi->link1, jdi->link2, &dsi_ctx,
+		      MIPI_DCS_PIXEL_FMT_24BIT);
 
-	err = mipi_dsi_dcs_set_tear_on(jdi->link2,
-				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear on: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dual(mipi_dsi_dcs_exit_sleep_mode_multi,
+		      jdi->link1, jdi->link2, &dsi_ctx);
 
-	err = mipi_dsi_dcs_set_pixel_format(jdi->link1, MIPI_DCS_PIXEL_FMT_24BIT);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set pixel format: %d\n", err);
-		goto poweroff;
-	}
-
-	err = mipi_dsi_dcs_set_pixel_format(jdi->link2, MIPI_DCS_PIXEL_FMT_24BIT);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set pixel format: %d\n", err);
-		goto poweroff;
-	}
-
-	err = mipi_dsi_dcs_exit_sleep_mode(jdi->link1);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		goto poweroff;
-	}
-
-	err = mipi_dsi_dcs_exit_sleep_mode(jdi->link2);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		goto poweroff;
-	}
-
-	err = jdi_write_dcdc_registers(jdi);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to write dcdc registers: %d\n", err);
-		goto poweroff;
-	}
+	jdi_write_dcdc_registers(&dsi_ctx, jdi);
 	/*
-	 * We need to wait 150ms between mipi_dsi_dcs_exit_sleep_mode() and
-	 * mipi_dsi_dcs_set_display_on().
+	 * We need to wait 150ms between mipi_dsi_dcs_exit_sleep_mode_multi()
+	 * and mipi_dsi_dcs_set_display_on_multi().
 	 */
-	msleep(150);
+	mipi_dsi_msleep(&dsi_ctx, 150);
 
-	err = mipi_dsi_dcs_set_display_on(jdi->link1);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dual(mipi_dsi_dcs_set_display_on_multi,
+		      jdi->link1, jdi->link2, &dsi_ctx);
 
-	err = mipi_dsi_dcs_set_display_on(jdi->link2);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
+	if (dsi_ctx.accum_err < 0)
 		goto poweroff;
-	}
 
 	jdi->link1->mode_flags &= ~MIPI_DSI_MODE_LPM;
 	jdi->link2->mode_flags &= ~MIPI_DSI_MODE_LPM;
-- 
2.50.1



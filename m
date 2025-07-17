Return-Path: <linux-kernel+bounces-735648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213C0B09214
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C6E7BEB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE00C2FCFFC;
	Thu, 17 Jul 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="g3/IJL6A"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311012FCE35
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770503; cv=none; b=GuVW/0juQ81G9x0YGJTpEaWlDT3sjs0WrDNBqxRUDG4a2gd8H4WzdpLT7BYR+5GU+f7G7+S0WCivyaH0fCarVnveGJ6/aFwmaUvZsvAUtasi3ba8d9G7KqfAn+q4R2V0n5ZjozPJlH6+CPYKE2XZrQtws/p0q4aa0ZdMUbUTHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770503; c=relaxed/simple;
	bh=YJcap+yEvAid5W9WWkuP6Wec7Pqo1OzPt2QIGwIPW98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmSy33B+7k/QEET1+I+6h1JLebtOauIo02GsCHckh5JhOqsuDEaLTVp6r1NvFhcqmVaS+ImET6ONC0aovdwRo9xwe6spBD00Lcq5DO7YIyZ3r7DGLlJQXQt6bL5SBBxk3FaJwrcBwfd6VbAFQH+A18JmPbyPnDLMFjySORO3zlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=g3/IJL6A; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso1266412a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752770501; x=1753375301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESsJwhHHQM2UwCSmgVX/iDa6sRNhhsQlObhdf5dpUJc=;
        b=g3/IJL6AnF9Df1NCcFrOqM7O2ITgP1Jj2KKoVLo88Hfz3v3EHUO+PT1KsVvSM4SJQA
         8a9tk/DFogwUTZ3YnhTZB+FfUqm2NCsFiUaNpcTDxOMSu9mj8UlhwftHkGm0hbrVNB7t
         cTxE/ymjr+wHpLgQx+DbiyLK6euLxh5AUDyOc9EBoYjitOFFjgGH+aLZfi7RMfiTjDtV
         4Bckt8gREex+CWUCJn26lts41HJ9yRCk/t4b3WeQs/3brpQRReZsGqhY0GWzgGyt7oIp
         vRmF/rPt4aUY8R90zE01bWy0Yi3jOYJeEm4kJCR+PQjoraCq9VVVTauQEBsEwz8Bplqn
         7Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770501; x=1753375301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESsJwhHHQM2UwCSmgVX/iDa6sRNhhsQlObhdf5dpUJc=;
        b=g6Ym3tWFSAzlI/Zm40Cgc0dt9SxIx2ZNha/IbQgwkAIg2AYS0Cgj6WMI2jNaFgcLk1
         EB2hFL2yetkevi1QLd3jGpQ4hAXk4wIqPeu5tB+tY3E9SxXUPcIjEdQKmc1M5Rjn4sGb
         5I3C6A/cftEFOqhIk0iJbVnYpxqtneTh8+78FiOCL6l1YZGBNa8DEDQ5Z1XOjYKNnGf1
         V6KLvILm2X4KaHYqTPej6GkAGUwsKAl+fm5c5SX8Kl9SJB/xXNx8BopPflbX++DVD+cb
         /ndkoi0x57a7CjOHor98eLRQOS/IFEK67YfGBf8BeX0LuC2eV1OZd9N7OpZxby4PCnEG
         5QuA==
X-Forwarded-Encrypted: i=1; AJvYcCV8RCtXn5A7x2Ep/7lQ/XsQuI99MutvOSA6egNLymvUOw3eG/n4JZFLld6RryH1DqLgghFkoW2itd6AQ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7f3J1V37aN9wW9t17scdk+WZlrcqRT/owl96SszhoOdvMquB
	DYJ8Z0J79Up44vnQkT9/2lfcY6/tw0zAvyNkAoY6a2XZ4OB+kRJ54gJNLFghXE32iQg=
X-Gm-Gg: ASbGnctSfjH8UJFij9zRIYO1xCIyULxUKhPsTJVvLTrhnKuY8WB02xNztCJGbSvBcM6
	azl7dCWjjU63c5VnCu5qa3QoJkLfeBVjRhTg2XHTJkoXUX4wfhuIR8rA2xTybjSKhzwS/zryPkI
	KY95zhDkfAxIfmpo9NMIgwF+GA4Xs3OOSXcPfg80snbGflVn+lnuPfMNcDTiPRt/jv/YZUPKsWQ
	FIBhWD0vMCoYur/TZYTRdBGV0hBnWvl1QkpCf4wnzxC0pTS/Gqpi92bou5AdvrWLoJ4nGDoyfM+
	yC1+rk2C9ROz5RmPgKGOOk6dbith2jEBs6Xqe7dnxNLZIipKlGhCxqaRe9zNPhMPuH9O4LZeoPb
	sTr6IgOR4ZQGoGFuf0I39QjT3q7EEN+m1fNHMOjSqbmt4BycQAQ==
X-Google-Smtp-Source: AGHT+IE1CeicV0sGbGU0VIzyRprxdceU7A8ofLGqRq5vhUsMS9h/1MhYpXvlkdqyMZ62HVrnUhNCVw==
X-Received: by 2002:a17:90b:2682:b0:311:b5ac:6f63 with SMTP id 98e67ed59e1d1-31caf8db5aemr4794419a91.21.1752770501250;
        Thu, 17 Jul 2025 09:41:41 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf7e8ae4sm1821750a91.24.2025.07.17.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:41:40 -0700 (PDT)
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
Subject: [PATCH v4 2/4] drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
Date: Thu, 17 Jul 2025 10:40:50 -0600
Message-ID: <20250717164053.284969-3-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717164053.284969-1-me@brighamcampbell.com>
References: <20250717164053.284969-1-me@brighamcampbell.com>
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

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 197 ++++++------------
 1 file changed, 60 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
index 5b5082efb282..9df67facdc47 100644
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
@@ -123,72 +123,47 @@ static int jdi_panel_unprepare(struct drm_panel *panel)
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
+	mipi_dsi_dual(mipi_dsi_generic_write_seq_multi,
+		      jdi->link1, jdi->link2, dsi_ctx,
+		      MCS_CMD_ACS_PROT, MCS_CMD_ACS_PROT_OFF);
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
+	mipi_dsi_dual(mipi_dsi_generic_write_seq_multi,
+		      jdi->link1, jdi->link2, dsi_ctx,
+		      MCS_PWR_CTRL_FUNC,
+		      MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
+		      MCS_PWR_CTRL_PARAM1_DEFAULT,
+		      MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
+		      MCS_PWR_CTRL_PARAM2_DEFAULT);
 }
 
 static int jdi_panel_prepare(struct drm_panel *panel)
 {
 	struct jdi_panel *jdi = to_panel_jdi(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .accum_err = 0 };
 	int err;
 
 	/* Disable backlight to avoid showing random pixels
@@ -231,88 +206,36 @@ static int jdi_panel_prepare(struct drm_panel *panel)
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



Return-Path: <linux-kernel+bounces-740076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BAAB0CF69
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049CB7B2706
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3091DF25D;
	Tue, 22 Jul 2025 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="UaKropK8"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20C1D7E37
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149206; cv=none; b=amrwGASAgsa4pfbKSHoqSaocOoxHkCNEwgNyaLSil01nPWQDVwfz2mAyVfqCQQcOe/q5IN42y6/mT6lm42fT2Rl98NPmB3jBZIf5ruK5YwkDyCA9KI4VfR6tbgIpg+E87V/7JnimkFMazGzH6vV2W1dc3k+xRMLY1cR2sLqqG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149206; c=relaxed/simple;
	bh=HJd/uxeFhKLnwgHoJB/OuGOikkLBkMQyDKkPMYdhplI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJQ5NZxKaB978P2CEX8i1wKMHkjSTZD/JBc7BeL31es9TEX5vtaihz2VdMWnQcF4T0Fe4510ORyjZ2iCPw1nvsSMxt5RzHpBfvX/sdSdbULotxADHzrTyMBJ1g/cZVoeGzT5cSuokYdwsMNbhNiUq92CYMnPHd+YJi1AGSKJTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=UaKropK8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-75ce8f8a3cdso1016735b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753149204; x=1753754004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIE4v7JeEKOf0+NcHojgY9bNkRsPUmFKUDfYCasnV9Q=;
        b=UaKropK8E1gjavHvXSPwYHH6F4vVZc+vmqAMxmADd7qITZ3+KkgMe4/fzVs5Lc6A+v
         tmCHEv+KRQme/5nTUNLKG7wAY7LcL4DiPFwg6mvqg4D/3cOH9YxSjaV/Ddphlh9zXemt
         b+fXrYKSaO18Aowj6IRzYPXJNntNaDaSZGy5PjuT/YdQ8fHy4idSCsMNkMROWY7+4bW1
         MaVkNh/pNfcWOyQBL7Ikb0aQ1Z+fYKyW7jPW+3q1ABAbgOCHKMAharkSiO42iosJjQNo
         r+kSTFBlhlxyZia7UT3Mp5elmwtdpTxij7D09FOXLoaJZ6yP+cTav0Ud3q0v+aqk5I9/
         eTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753149204; x=1753754004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIE4v7JeEKOf0+NcHojgY9bNkRsPUmFKUDfYCasnV9Q=;
        b=EvYwd7zOPCDjbr3OhMvS+O0Gg6buEQncIa0ZRlO/YZSLK6BSVXxvPtFI/mMizEUu4Q
         JloqpM0dujij+jwwmkUfXlZ0dosWE+0NXqbc1Ek5OhYVqXUNdWIHCQRwy2mTWCOpyIyE
         uweOfgIUf88jCStTk+g/plGp39722Mwjk+Sj4SB9zUYUSRdoJcljIQCO5ATEqlZHkZ3e
         XDhv2K9MTjEKhX6IacEOlnk2vUAMtaAJ/j6pQy8WezBAanjVi7ap8RECaeSeXJu+xp+S
         9IGhgW6a3jM3KpGX2JOjC3wuADrXXQLD7eBvm3+HIoJjRLHeNbGnpnzXqmDeyBZCdJZ+
         Qksw==
X-Forwarded-Encrypted: i=1; AJvYcCVqQZp0bPxmurVGTuGrcOoOPbm/5A6/WZgZLDuXLn0CyOA631dg4PQZfg+lXVxzIOkH758/RmOPXIq6Vw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaUalO8oObYX9aXLmUb5yKN8HJeX9F11MwHbOOThE/fuYOEAb
	khqb3iP1zAtoDMlHwY6HEsAlJxbYuhmu4JpDM88RKus+aj80c71GBT32ZWuFEZ9OGDQ=
X-Gm-Gg: ASbGncs+8ngIhqyzPjTJL0sOzcKOpLNQbHFnw8q9/340smSk68/qbTCIIhsVQkiB8a+
	YnmY23pnN61n5QrMStxsBe5by7yjIUx6KF8jsFeyIuvb84BRqt4PBz10nhJ88j1olSjZkmYVNIO
	dipo5oLU/Du+1DoMkjwdBWTR0uBL0BYJUnAXPHxSZMCM/iwV8bSU35T5HYMCNuPf0pMOUHDXNP7
	hdA7K61Ujz2HdOW7OzmjPr9xVYH0byNkbMPYoKIEvv574K3ZxL0XEAbR8bQiRdjYmHq1WOMsHSZ
	KEfrOgXK6BvX/otRk7L/B0avTe3+VHN2LhL7SDdaXQJoKnyBKpet9QM2fD+fHMdXuQJYmeo/YhR
	pZGlmWdwS9ioxOWrFOZn5u04O1W+ZvYmUFxnvrelsFF+QSj84inCZMOIOWI4s
X-Google-Smtp-Source: AGHT+IH50wKdP58q2GIjp8iwkio5MwzNoXZJkZOhU0XFG9sQuu8h6dwlQ1hq17mYtUFsOoMH6DGedg==
X-Received: by 2002:a05:6a00:4644:b0:746:298e:4ed0 with SMTP id d2e1a72fcca58-756ea1de0c1mr30341135b3a.13.1753149203634;
        Mon, 21 Jul 2025 18:53:23 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe62d9fsm6017441a12.1.2025.07.21.18.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 18:53:23 -0700 (PDT)
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
Subject: [PATCH v6 2/4] drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
Date: Mon, 21 Jul 2025 19:53:09 -0600
Message-ID: <20250722015313.561966-3-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722015313.561966-1-me@brighamcampbell.com>
References: <20250722015313.561966-1-me@brighamcampbell.com>
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
index 5f897e143758..83656bb4b0b2 100644
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
+		      dsi_ctx, left, right,
+		      0, mode->hdisplay / 2 - 1);
+	mipi_dsi_dual(mipi_dsi_dcs_set_page_address_multi,
+		      dsi_ctx, left, right,
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
+	mipi_dsi_dual_generic_write_seq_multi(dsi_ctx, jdi->link1, jdi->link2,
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
+	mipi_dsi_dual_generic_write_seq_multi(dsi_ctx, jdi->link1, jdi->link2,
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
+		      &dsi_ctx, jdi->link1, jdi->link2,
+		      jdi->mode->vdisplay - 16);
 
-	err = mipi_dsi_dcs_set_tear_scanline(jdi->link2,
-					     jdi->mode->vdisplay - 16);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear scanline: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dual(mipi_dsi_dcs_set_tear_on_multi,
+		      &dsi_ctx, jdi->link1, jdi->link2,
+		      MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 
-	err = mipi_dsi_dcs_set_tear_on(jdi->link1,
-				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear on: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dual(mipi_dsi_dcs_set_pixel_format_multi,
+		      &dsi_ctx, jdi->link1, jdi->link2,
+		      MIPI_DCS_PIXEL_FMT_24BIT);
 
-	err = mipi_dsi_dcs_set_tear_on(jdi->link2,
-				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear on: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dual(mipi_dsi_dcs_exit_sleep_mode_multi,
+		      &dsi_ctx, jdi->link1, jdi->link2);
 
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
+		      &dsi_ctx, jdi->link1, jdi->link2);
 
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



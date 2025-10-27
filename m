Return-Path: <linux-kernel+bounces-871009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 894FEC0C3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6659C348BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78EC2E7650;
	Mon, 27 Oct 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG7HO8Uq"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B12E6CC3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552388; cv=none; b=PncUQPx87FfzoA2PuTKgvvy+97F517NbXP7ZPFKdbucHRwv3x481sr7wYceEpYosbcQ+NA9jOQcfX35c+kjJCc7GXWreb1aGSKtNtZx2f/cadjq9OCnXcZOf76wVk9ZyRkX1zdDAYV1F1MTdWRImzEGXGIrGOO1CISq114jdDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552388; c=relaxed/simple;
	bh=uQbA0rKYunCTI3/XflhoFu8URyEuC+L2ECojxVblZ4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1JcovHc2AOaowS5Jkg+fKsf0gQHSdJZ5j4+5F7iKPUrfWaJXAkJOi3a6uy0RpOnNSsstA1KrNlGLzSC4zZLjimvhBlCXxcPQRXEnJbWvLtRp8XzJ0e5Yuo7Zr3O9tG7PlxMj3TIH+SMbbk81nlPRP0lV7cis+8qYTrAqQZCs0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG7HO8Uq; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-591ea9ccfc2so5566246e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761552384; x=1762157184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wUcuvxBU9o0BNgp3mGWY+OrsEhxOyvnPdUxXgFT92U=;
        b=PG7HO8UqfTLqyc+/BFrecpnoR7EzYaxxjA1zsp+G/gc8Dug6+EKnV5u8HWBDozlNSh
         mzTpGBPXjda7Acnd0hTSCE55MMbka2eSzwbuUB5WJLRb7GY1aGIoKQzaEZssF/NFf4yI
         rqbMk7JJs51X7Cw6NNV6U+QmjMmPji7jX/t5jnQzJO4VvIoce3d35o2Tcwm+6gBLPsLJ
         fGrTRB706Ug1JFa84BiIyzJ2XcHdQioEgvwUjqvEP8VvCog02imM7qaKNJejtIBvHL4/
         dIjY14PySzoc4jp9+rBoZOtdoWfFqH7o/UtHwlooqe8CHV+QYUkEWhscTMQxF0YIrY3a
         2xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552384; x=1762157184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wUcuvxBU9o0BNgp3mGWY+OrsEhxOyvnPdUxXgFT92U=;
        b=nXiku4PmAO5rSKgB9mvvpHMbQVqvvmA+70ZbypCxkmR0UHNNO8gtnEUvJ+t7qt76bW
         Ic4ovSUaJQ6WC+eqLEEhzr2zi08Qjwr7phdn2fjC8il8u5CZRBju36q8GGhWxazQmtaS
         O2ZEPfk9YUF3z0u102aror85nzivrpDrtUE1+wT8nbfFMK7Zgsm5QX+PJd/n4jxHk9HS
         8RkGBn9CsxgbUvToVowdAJ3dvi3QOGLMOpTKIJdl4DLfnFAbSf3nftkMXmBGRjny66Uh
         w9BMUNJZai3ysRmGum4nr0vPyUpePwcELbvSN7cwBRBLMd32Ie4LDmPlcdm7Os8bE1FC
         o+cA==
X-Forwarded-Encrypted: i=1; AJvYcCWzlMqPAUv+yncXvbIxMEt8Ohwi2CGjc3++zRGrrBg3PAbcrXQ6uiTvQxhUH/yV0XtO48AD29ijfeSNE1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfNtTt39OcGL7pre7ZEVVTtpLN9vUWXLr4GbYTG67g+CWYxkm
	lWbQi/2tNDPOVK7KfFszuUh4XOZcXTI9u8JiGx+DQx+AGKbtEcdHki34
X-Gm-Gg: ASbGncsYmrFjH77swv2YQAo3F3DByP6t0fkb4grTa4NdJwWJ024gGUhudf0ToKiK8Om
	HNQWBcecFUHtv/30/QGCWwGZglawKfQr3mzGs4N8S5n/lSqUeAS7C5rEktxO0rwt5bopT3IIXwz
	pRHMH1ID6lvGZHm8wfXegy25w4PY6fCz8kVc6d8KCWD2LRsV9WCCtojYiMogsfy6rJZdkzUW+/Y
	LrSU1LNUBlh78CY03x77CjLgGRRYZ1BBeD04bGMz9zRffcZqDvQo5WYeuCrxhIgxFcqmn/x8Yk5
	pR/qcS0VHsKKq5cK5/xlb/fBf65ek2RbVyMFb2Dbj67k3lEftgoPIxg26vtIuf0Ylltk90K2b5y
	A4YTeBNPF2HNpVDTyUyADmXhEeZF1rfXFeQbKK2a1Tth1bfzE/ZsyhQQTzDnagRyguB1aonyB/9
	ALytRhqjF9gQmBcubKzlF7/BtMBZBztKvrInvrY7c/5rGcZ1nX+SJkOgY=
X-Google-Smtp-Source: AGHT+IHQLiB9sMkcyROtmjEeaXbI24k2BrWqYqJNsE5MgNRn9Q3TM1orHUyAeTwZvuKdWojnragSdw==
X-Received: by 2002:a05:6512:6c8:b0:57a:8eb7:1ea2 with SMTP id 2adb3069b0e04-592fc154dd4mr3156635e87.27.1761552383809;
        Mon, 27 Oct 2025 01:06:23 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm2210689e87.6.2025.10.27.01.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:06:22 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 27 Oct 2025 09:05:41 +0100
Subject: [PATCH v2 1/6] drm/sitronix/st7571-i2c: rename 'struct drm_device'
 in st7571_device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-st7571-split-v2-1-8352fb278d21@gmail.com>
References: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>
In-Reply-To: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7030;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=uQbA0rKYunCTI3/XflhoFu8URyEuC+L2ECojxVblZ4c=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo/yfejWKPA2jbFMsz2tZ1j5znPFP13D1ywrh68
 efLU3i428mJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaP8n3gAKCRCIgE5vWV1S
 MtyyD/9Q0LjBzLqpbGdDWU7cVqRQIF7w1xCwikr04evge3uf2R+1vxMP0fT8DYs0102vuX98IYN
 pYSzurCQlzxounNsTVEoVODIlrZuLk0tNe1/dDFWeEeveRxWvkOLmiz2h/MIALWl9kCQ9ALNG7z
 A5LuLYYUs/JnVIV2kgjT3jskK63JLMcb70+CKSeMicL/cA8iWh8JTRwjO38s1uPZqzx+yQj9qiN
 WZ9TVrc1zUH7kw94jbubzPUlyNir/34D4mll08u3PnA3DonRHrZeWFDsfCj+SrtYgtsmI1kUKxr
 yQ6tFcZy7fTR0aSJIPBseamBKsUeRQLXKzuV/PvCxa4Z4okXsjZbMhKR1FxyyHEfIEYNUa7lsaN
 nxqPighXRaBGZ1gKrhS+dsrEGTnYrbrVryuSRtb2S6v41F7bH230CSGLJaEbhMcU2XdhfC+rx7H
 2hckFffe3S88uxU12iDPzL0JMikLSrSgN6HNzXJQQ/2Fpr626VSnxR3x48oQa7JQeaD5mPib1sx
 LzePCWdzyvaC3aZ6cvgP825zAgOXEVa0XyPLsgA8r3C4FkekFNQe3/MYGxSf42qfiDjgp03Ncd2
 61qhQLDRiOKcmgn0yTp2/+6W5R4fKkilIO0h0uYAVsnQ/Ld2AKJL8iIs0IO17wBYTleJ/IoN7nY
 9w4QpY7bAerivXQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Rename st7571_device.dev to st7571_device.drm in preparation to
introduce a 'struct device' member to this structure.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 60 +++++++++++++++++------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 4e73c8b415d677dab5b421666b56f4bb3697b982..71814a3eb93b7adf554da082a0237da371e5f5b5 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -112,7 +112,7 @@ struct st7571_panel_format {
 };
 
 struct st7571_device {
-	struct drm_device dev;
+	struct drm_device drm;
 
 	struct drm_plane primary_plane;
 	struct drm_crtc crtc;
@@ -166,9 +166,9 @@ struct st7571_device {
 	u8 *row;
 };
 
-static inline struct st7571_device *drm_to_st7571(struct drm_device *dev)
+static inline struct st7571_device *drm_to_st7571(struct drm_device *drm)
 {
-	return container_of(dev, struct st7571_device, dev);
+	return container_of(drm, struct st7571_device, drm);
 }
 
 static int st7571_regmap_write(void *context, const void *data, size_t count)
@@ -467,7 +467,7 @@ static void st7571_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_atomic_helper_damage_iter iter;
-	struct drm_device *dev = plane->dev;
+	struct drm_device *drm = plane->dev;
 	struct drm_rect damage;
 	struct st7571_device *st7571 = drm_to_st7571(plane->dev);
 	int ret, idx;
@@ -479,7 +479,7 @@ static void st7571_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	if (ret)
 		return;
 
-	if (!drm_dev_enter(dev, &idx))
+	if (!drm_dev_enter(drm, &idx))
 		goto out_drm_gem_fb_end_cpu_access;
 
 	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
@@ -501,11 +501,11 @@ static void st7571_primary_plane_helper_atomic_update(struct drm_plane *plane,
 static void st7571_primary_plane_helper_atomic_disable(struct drm_plane *plane,
 						       struct drm_atomic_state *state)
 {
-	struct drm_device *dev = plane->dev;
+	struct drm_device *drm = plane->dev;
 	struct st7571_device *st7571 = drm_to_st7571(plane->dev);
 	int idx;
 
-	if (!drm_dev_enter(dev, &idx))
+	if (!drm_dev_enter(drm, &idx))
 		return;
 
 	st7571_fb_clear_screen(st7571);
@@ -621,20 +621,20 @@ static struct drm_display_mode st7571_mode(struct st7571_device *st7571)
 
 static int st7571_mode_config_init(struct st7571_device *st7571)
 {
-	struct drm_device *dev = &st7571->dev;
+	struct drm_device *drm = &st7571->drm;
 	const struct st7571_panel_constraints *constraints = &st7571->pdata->constraints;
 	int ret;
 
-	ret = drmm_mode_config_init(dev);
+	ret = drmm_mode_config_init(drm);
 	if (ret)
 		return ret;
 
-	dev->mode_config.min_width = constraints->min_ncols;
-	dev->mode_config.min_height = constraints->min_nlines;
-	dev->mode_config.max_width = constraints->max_ncols;
-	dev->mode_config.max_height = constraints->max_nlines;
-	dev->mode_config.preferred_depth = 24;
-	dev->mode_config.funcs = &st7571_mode_config_funcs;
+	drm->mode_config.min_width = constraints->min_ncols;
+	drm->mode_config.min_height = constraints->min_nlines;
+	drm->mode_config.max_width = constraints->max_ncols;
+	drm->mode_config.max_height = constraints->max_nlines;
+	drm->mode_config.preferred_depth = 24;
+	drm->mode_config.funcs = &st7571_mode_config_funcs;
 
 	return 0;
 }
@@ -643,10 +643,10 @@ static int st7571_plane_init(struct st7571_device *st7571,
 			     const struct st7571_panel_format *pformat)
 {
 	struct drm_plane *primary_plane = &st7571->primary_plane;
-	struct drm_device *dev = &st7571->dev;
+	struct drm_device *drm = &st7571->drm;
 	int ret;
 
-	ret = drm_universal_plane_init(dev, primary_plane, 0,
+	ret = drm_universal_plane_init(drm, primary_plane, 0,
 				       &st7571_primary_plane_funcs,
 				       pformat->formats,
 				       pformat->nformats,
@@ -665,10 +665,10 @@ static int st7571_crtc_init(struct st7571_device *st7571)
 {
 	struct drm_plane *primary_plane = &st7571->primary_plane;
 	struct drm_crtc *crtc = &st7571->crtc;
-	struct drm_device *dev = &st7571->dev;
+	struct drm_device *drm = &st7571->drm;
 	int ret;
 
-	ret = drm_crtc_init_with_planes(dev, crtc, primary_plane, NULL,
+	ret = drm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
 					&st7571_crtc_funcs, NULL);
 	if (ret)
 		return ret;
@@ -682,10 +682,10 @@ static int st7571_encoder_init(struct st7571_device *st7571)
 {
 	struct drm_encoder *encoder = &st7571->encoder;
 	struct drm_crtc *crtc = &st7571->crtc;
-	struct drm_device *dev = &st7571->dev;
+	struct drm_device *drm = &st7571->drm;
 	int ret;
 
-	ret = drm_encoder_init(dev, encoder, &st7571_encoder_funcs, DRM_MODE_ENCODER_NONE, NULL);
+	ret = drm_encoder_init(drm, encoder, &st7571_encoder_funcs, DRM_MODE_ENCODER_NONE, NULL);
 	if (ret)
 		return ret;
 
@@ -700,10 +700,10 @@ static int st7571_connector_init(struct st7571_device *st7571)
 {
 	struct drm_connector *connector = &st7571->connector;
 	struct drm_encoder *encoder = &st7571->encoder;
-	struct drm_device *dev = &st7571->dev;
+	struct drm_device *drm = &st7571->drm;
 	int ret;
 
-	ret = drm_connector_init(dev, connector, &st7571_connector_funcs,
+	ret = drm_connector_init(drm, connector, &st7571_connector_funcs,
 				 DRM_MODE_CONNECTOR_Unknown);
 	if (ret)
 		return ret;
@@ -934,15 +934,15 @@ static int st7571_lcd_init(struct st7571_device *st7571)
 static int st7571_probe(struct i2c_client *client)
 {
 	struct st7571_device *st7571;
-	struct drm_device *dev;
+	struct drm_device *drm;
 	int ret;
 
 	st7571 = devm_drm_dev_alloc(&client->dev, &st7571_driver,
-				    struct st7571_device, dev);
+				    struct st7571_device, drm);
 	if (IS_ERR(st7571))
 		return PTR_ERR(st7571);
 
-	dev = &st7571->dev;
+	drm = &st7571->drm;
 	st7571->client = client;
 	i2c_set_clientdata(client, st7571);
 	st7571->pdata = device_get_match_data(&client->dev);
@@ -1010,14 +1010,14 @@ static int st7571_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, ret,
 				     "Failed to initialize connector\n");
 
-	drm_mode_config_reset(dev);
+	drm_mode_config_reset(drm);
 
-	ret = drm_dev_register(dev, 0);
+	ret = drm_dev_register(drm, 0);
 	if (ret)
 		return dev_err_probe(&client->dev, ret,
 				     "Failed to register DRM device\n");
 
-	drm_client_setup(dev, NULL);
+	drm_client_setup(drm, NULL);
 	return 0;
 }
 
@@ -1025,7 +1025,7 @@ static void st7571_remove(struct i2c_client *client)
 {
 	struct st7571_device *st7571 = i2c_get_clientdata(client);
 
-	drm_dev_unplug(&st7571->dev);
+	drm_dev_unplug(&st7571->drm);
 }
 
 static const struct st7571_panel_data st7567_config = {

-- 
2.50.1



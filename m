Return-Path: <linux-kernel+bounces-868700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B7C05E66
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8733A678A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E243161BC;
	Fri, 24 Oct 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7Epv16O"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF453587CA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303457; cv=none; b=V1onTc//nZA25ZOUAbILNDqzvvNif+fWaAzw4vGmC/G+zvh7CZiPRgx5WYmzz/pN1xXRKaEBgQQFqllBOjaDTPzl/YDEy91P55v2wlgtSuvTWkkxC3xnwwdMVLhv0yu1Tz/TJn8gVhnCvken6zSra6ebl6YZRiFZXURTn/V/JyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303457; c=relaxed/simple;
	bh=uQbA0rKYunCTI3/XflhoFu8URyEuC+L2ECojxVblZ4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECzy97JlQwan0aahyb1gJTox6SsPn2Y4FEvG+2NvbpqXI7ZmujlDey2N0ioVuon1EDtUd6v0/yQwtX3m3BoSVgrYtSHAjdz3gHZ01WdUYiKQAsB5MODl5889M09EdGTmMnfJrpA9OfO71w6f88R/hku+xAbrEj1VVFH1k2RW25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7Epv16O; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-592fa38fe60so1597957e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761303453; x=1761908253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wUcuvxBU9o0BNgp3mGWY+OrsEhxOyvnPdUxXgFT92U=;
        b=K7Epv16OIU/wqq+shpSEv8Ds/XHaL1JNpDyc7BKhrAAza+qXBcOjlC/ere7FQfr8gH
         7qXTdrb62cXZ7kUAaHC1meb8eWMNlKJ4z1DDInJWl6/QdRJ8EAQwgxpqnYaK9KbEUX2q
         +Fp9L5aL5FYb2SQLrklIzFrnf1sqRwC7HjQd4uTrV6ljfyups5k0FyPIXZXUImsXh1Oa
         Zsw+96rXVl9r41E/rOspD3SnMIsM8ApdBtMNL+APOZioXPUVq7pdeIPsU2++hFEI7mzo
         dCgPyIrkbPJjjvy0BRtRFn1wcFf/mbr8epI7vkO8OORsGPNndvlbBpYFJcQbIsRD00I4
         n4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303453; x=1761908253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wUcuvxBU9o0BNgp3mGWY+OrsEhxOyvnPdUxXgFT92U=;
        b=BJWznHYB7vBkBzhZVmWvL/omj52GGWcf1aDthB0yr+ajmsW+iP/V333XcmPrWROh4U
         ISCk8e0+fOQZC4umTKlTM0m/WJt/luX4kzR06joiPOOiizSIwW5v14aUa7ozyDV0/O7f
         uEmDM4ApPizvJ0OD8Gi0k/ZucK2Z36Tlcp35/Onp2MKVBG3Yb/xXyo7pzqao5yqVAz3p
         z+cozbQgEcYccZtaMY0pHLVTMlChQ0faWS8lxcrcTk5JkwmTMcwdiqagDwpODYMwGpWc
         BrS+3wLgZW8rRFgTcWBr73fYB6hARJqcAjUijtpVc7C+5bsbP8FPXyIc1gQ06yHuoo5M
         b6dA==
X-Forwarded-Encrypted: i=1; AJvYcCUqdz1TRk/uHF8m183H3np6DEXBbRLweFnj6u5QfbwZDfRkgWGaj7VKJ23oCPwmthu33qKS4CS9zk2+2lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3KQyUVMppMy8mAOz/gJktIap2WlBCXLsfgQsPvXbZ1f50o8Kd
	JFg0XTdP5NANeiALTY7xJ49QIG/HhlWNpeUysvXQlK0vSbNE1oZ/8rCL
X-Gm-Gg: ASbGncvZ3FXRhpgJY1SS8D+hAFFCs0LkXkKyuC8qTTPu3tkUc7YZBOB46viCNWouboq
	YiAVsCf9cauAzZ2ja1Wef6QpQkxqYRvBcLhczB26t1NDjnMiQLBqnF62wiA9KPbWx1NZmY561aH
	1fAKr9Hk7H4Xwwl9+yuRT9fyNk/7eo4ZN06vA6kIjmajiUJwibNUtKfzDLgM+NPFIA9vMhdkz/E
	Zk7uF/jLVa2mSSYEQP0uXOEoJzrKAozSyR+n1Lrq0YM7JfFsCMHOc8VIJ/qrOT1BOZtFv96xGi1
	xoohfRA9im6lILEdBdzR3gWixJac4wGf2biBZb3ZVIEltzvClCbxXOl5tiXzvZzz70ZP2a0ol/s
	cSpQDIzmupK6I7sr3+H26AcS5/NPFJuDTdz1bf1k8IIkqf9wvfZf5ThWUiDXICFG1tCVMy8VYc5
	aiQ2pb9qvcGsyvebAzx7YmE2FfC8ZU1etVw7BW33ZEsXJwmuWQieBYsg0=
X-Google-Smtp-Source: AGHT+IHOOl3WF5PX5cB7hE/P3hEVHISioDgU3UYsW/kZF/bhPuwy8TT1minCOY/eWu61VRd+C4gNgw==
X-Received: by 2002:a2e:be93:0:b0:376:4c71:75 with SMTP id 38308e7fff4ca-378e43d6016mr6262631fa.46.1761303452743;
        Fri, 24 Oct 2025 03:57:32 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67db8fesm10375671fa.38.2025.10.24.03.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:57:31 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 24 Oct 2025 12:56:52 +0200
Subject: [PATCH 1/6] drm/sitronix/st7571-i2c: rename 'struct drm_device' in
 st7571_device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-st7571-split-v1-1-d3092b98130f@gmail.com>
References: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
In-Reply-To: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7030;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=uQbA0rKYunCTI3/XflhoFu8URyEuC+L2ECojxVblZ4c=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo+1t80dRfpAEIGXfmXC3DFUw8j0Hdkb5Uhx97Q
 CpMIGEfEjqJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaPtbfAAKCRCIgE5vWV1S
 Mgw0D/4icAPFotSrOzvHs8S/7LeLSts4UJKr8NiINmca5vtlUf4PhZagPe8rHKjoqKEa96sX/oa
 6lDDvBPHjZm810XWnV8jfwpG1LDl0ZlyT9rEHN5b4j5i1uHz/grfxTXK9989+MbgpdEr6excNbQ
 CL3GnNLZ+ay0j1Ae1rYbEU0vL9PsU18ueI5iFSQT8fRL7um+8/zYI7439JsPZqvychszuuhRC8b
 0un043V+zdX7z06/OGDdRydHcWSS9abkT+xTp1n4k2f5f9wBFg4hSvUBOLPkN8D60Ig150Xe6Og
 nswjdfErzE0B5+KzpCEtxcB2K2ns0Dgv0LW6BMjSOZYWYWNzAGsus71fF4GmvEWCBiFxETNqcNd
 vrvffTqsvPH54nPqGhIlDPtroVdS4HgPjtJQNWnQlZQCTekgUqyKufJbtroQHq0C2P94hyPRBMe
 7ot+bDhQpagGAr/j7viH0RE69kJ9oewDa42mFA2W11hung6KMnCoKANipQDw/GPSlKQuXJzsUhs
 abEZfG1Zvk9lAPyJ6FCJY3YaCWFoMdorrXQyTUTktqPPkeMv2mxoXTo1W11uyjBXdj03cDZTy+g
 tNIwdAa2DKOU0ahIFqeAQlmXYxK1I7sAZH5Lum2jc6YOKRLJXhxQJnBJ6uxBIbknECQe9GtYGYF
 6b3Yx1FxwOw6MKw==
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



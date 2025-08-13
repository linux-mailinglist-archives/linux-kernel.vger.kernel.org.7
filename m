Return-Path: <linux-kernel+bounces-767619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E2B256E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05879E135C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B32F9995;
	Wed, 13 Aug 2025 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjLtzth2"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A832F39D1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124812; cv=none; b=E1KyD0skFUarATvS5eIm/v6YnwgVCRnRAgmJXMVF2NgXdXUDXVRH7aCCVWf/Ud8jITl7xYdMxF2Y2IXVkNsD41XMj1jbjuN9OtJKJObOzEX296IfGNxfTx+fZB0uyUBpE1fpVkYJTaJ4wlBdb3f/dotAHsL8S09ZBcFT/XmtP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124812; c=relaxed/simple;
	bh=q1rqTlvL5W1hHG6HS8s34aHs5XP/loCVCsEiSXeN3UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upN+nWM0CVJVtyNJwdXRgFfUfH0dvZ070h5A8EenIM57CVByp+ut1VYifHe8iHVIIlroxL2QjTFF9a3XjwfnWe9dduFbRlo+yOhE/HehsOltRi97zCAoW/3C9ldzh82VT/UhoB6IrgDDns5Fx3jQ90kNboiq/p1+Q6G2fYtswUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjLtzth2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so1261035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755124808; x=1755729608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ0jpiugHLgI/5Z1g0NOk55lz83PPv65RbA/jaeoNyA=;
        b=bjLtzth2WUoFJ5yILxqlpCOW5haZoeU1UVzaxTkwWm2Q71gQzVpA+rz+c0eQ+65OrB
         3XvK08Z2IDJJLvwm9kcIR1/h0luEfpHLzpZPa9bfjfCdCZ+a97y6pwAUELZ7hOW+H3r2
         7KwjSnq2H5FqO2vZkyp8a7QTZ78twAGDvEa4M2bPBYj4AzlcyU+Oz/aMypXsU2BQe74I
         tzcfwtEMTuysCxboPkMwmUBzBcEicu9/VdiJiWNBcHmGeBjesqusd7+iBrHeJK1QnoUs
         6JOWQa6rnMZVwIEvzf9/HptW75FgFYoLsvGSg/QuIoRB0VEEAL5npf+fS+/TKwPk/zST
         Xbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755124808; x=1755729608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJ0jpiugHLgI/5Z1g0NOk55lz83PPv65RbA/jaeoNyA=;
        b=X0CLHW41js0kHTWXGbBwK4H4brH9XO95o/myeDG4FV9lbE7mJIw4uikh4iiBFRyJND
         szDLgQK7pPcWoo1t3dqz3ypWpp/w8oGeNIVlc2yUp7C1PUXUdUN3dXR0kR1zql9obrvS
         FSKoplzFrmXH+UtwnoULv+gOZJAvbB/pp2QGy87QKtb7ZfQ7DcPnFVzT1vN2liR4y8jl
         K75ajL49SZPpywrneuZKRoVB5Jj44ead9k9+MWUuX1D+iRYTkrXI0pYN5K+Wc5SIEDlT
         HOYdjfIAD6bAuOeb6zGXo1QXm8geXAltZ2ebNMPpATue/vBeZV4bS2jJCjIPKeSsJZ8M
         hiog==
X-Forwarded-Encrypted: i=1; AJvYcCVoYIqJxWxON8atK/kS6S4yKfZbpIhdn3eRiOE/zyo2QKZrwlwjci9qTGOmslsQ6SWOpxkgfr8/n5W+M1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqAwCdn3KRrwCfsPw79IukFyjeJOaeASt1Lb/4PnkZgjUHB+2t
	vw2XhERcaL/3MAz9KfMwWQBtkSLjrO/DanVMG43gzGO8AH6fZrH0aB9+
X-Gm-Gg: ASbGnctn2DQHaGTIEJQrFXy2+DqQJyYXjgoIHptXL2HNbFrqHuk25N442P9uJNNCpC3
	4ar5Ns3b7UU3XbPT10ejy0y2XfWp0YJY2y+Xdz9U982+sFMG19hQtWR8L5UHjeijxcxo7AZiN5d
	DeGuesNfwbNT2O0TiS8wkz6GSG3c1UwbESEoCDuTOJ+BYf13mWjYVsH2Hk6uImQaD3bVyk7zqnw
	4bE0QHIcl9PHHk4eWTE3Qn6yhJlHlureHseDhdnVLeogYh2OHRP1bBTms1Dq98fKn8k3pxY9DyN
	TOQT2otAoDZ+PyRuLY46MrTJEpkcpNsZsGCfTxtu+lFeTaMBPJazMwiXw4iZvl24uKt0ugGNnjF
	s1syi7aE6fu6MLtV21VAtbttW3TF9BDTaN5KnYcN3b4MVfBXpCuie1rULoXttjMd8ZKWUgL45eY
	+tQSt6RjfY
X-Google-Smtp-Source: AGHT+IHoUgJngPB4year933qgBkg1hDcTIbk0ko+wffW2kEKlhvVPX96a6fiNTTXlbNSCzCTKhjEOA==
X-Received: by 2002:a05:6000:2311:b0:3a3:7593:818b with SMTP id ffacd0b85a97d-3b9edfb6e7dmr643402f8f.21.1755124808309;
        Wed, 13 Aug 2025 15:40:08 -0700 (PDT)
Received: from ekhafagy-ROG-Zephyrus-M16-GU603HR-GU603HR.. ([156.204.193.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a541c3bsm16550085e9.29.2025.08.13.15.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:40:07 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
	Dharma Balasubiramani <dharma.b@microchip.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.com,
	eslam.medhat1993@gmail.com
Subject: [PATCH v4] drm: atmel-hlcdc: replace dev_* print functions with drm_* variants
Date: Thu, 14 Aug 2025 01:39:52 +0300
Message-ID: <20250813224000.130292-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the Atmel HLCDC code to use DRM print macros drm_*() instead of
dev_warn() and dev_err(). This change ensures consistency with DRM
subsystem logging conventions [1].

[1]
Link: https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 21 ++++++++++---------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 14 ++++++-------
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c  |  3 ++-
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |  6 +++---
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 0f7ffb3ced20..e0efc7309b1b 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -20,6 +20,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
@@ -215,32 +216,32 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
 		if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
 					     !(status & ATMEL_XLCDC_CM),
 					     10, 1000))
-			dev_warn(dev->dev, "Atmel LCDC status register CMSTS timeout\n");
+			drm_warn(dev, "Atmel LCDC status register CMSTS timeout\n");
 
 		regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_XLCDC_SD);
 		if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
 					     status & ATMEL_XLCDC_SD,
 					     10, 1000))
-			dev_warn(dev->dev, "Atmel LCDC status register SDSTS timeout\n");
+			drm_warn(dev, "Atmel LCDC status register SDSTS timeout\n");
 	}
 
 	regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_DISP);
 	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
 				     !(status & ATMEL_HLCDC_DISP),
 				    10, 1000))
-		dev_warn(dev->dev, "Atmel LCDC status register DISPSTS timeout\n");
+		drm_warn(dev, "Atmel LCDC status register DISPSTS timeout\n");
 
 	regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_SYNC);
 	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
 				     !(status & ATMEL_HLCDC_SYNC),
 				    10, 1000))
-		dev_warn(dev->dev, "Atmel LCDC status register LCDSTS timeout\n");
+		drm_warn(dev, "Atmel LCDC status register LCDSTS timeout\n");
 
 	regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_PIXEL_CLK);
 	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
 				     !(status & ATMEL_HLCDC_PIXEL_CLK),
 				    10, 1000))
-		dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
+		drm_warn(dev, "Atmel LCDC status register CLKSTS timeout\n");
 
 	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
 	pinctrl_pm_select_sleep_state(dev->dev);
@@ -269,32 +270,32 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
 				     status & ATMEL_HLCDC_PIXEL_CLK,
 				     10, 1000))
-		dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
+		drm_warn(dev, "Atmel LCDC status register CLKSTS timeout\n");
 
 	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_SYNC);
 	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
 				     status & ATMEL_HLCDC_SYNC,
 				     10, 1000))
-		dev_warn(dev->dev, "Atmel LCDC status register LCDSTS timeout\n");
+		drm_warn(dev, "Atmel LCDC status register LCDSTS timeout\n");
 
 	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_DISP);
 	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
 				     status & ATMEL_HLCDC_DISP,
 				     10, 1000))
-		dev_warn(dev->dev, "Atmel LCDC status register DISPSTS timeout\n");
+		drm_warn(dev, "Atmel LCDC status register DISPSTS timeout\n");
 
 	if (crtc->dc->desc->is_xlcdc) {
 		regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_CM);
 		if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
 					     status & ATMEL_XLCDC_CM,
 					     10, 1000))
-			dev_warn(dev->dev, "Atmel LCDC status register CMSTS timeout\n");
+			drm_warn(dev, "Atmel LCDC status register CMSTS timeout\n");
 
 		regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_SD);
 		if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
 					     !(status & ATMEL_XLCDC_SD),
 					     10, 1000))
-			dev_warn(dev->dev, "Atmel LCDC status register SDSTS timeout\n");
+			drm_warn(dev, "Atmel LCDC status register SDSTS timeout\n");
 	}
 
 	pm_runtime_put_sync(dev->dev);
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index fa8ad94e431a..acb017a2486b 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -724,19 +724,19 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
 
 	ret = atmel_hlcdc_create_outputs(dev);
 	if (ret) {
-		dev_err(dev->dev, "failed to create HLCDC outputs: %d\n", ret);
+		drm_err(dev, "failed to create HLCDC outputs: %d\n", ret);
 		return ret;
 	}
 
 	ret = atmel_hlcdc_create_planes(dev);
 	if (ret) {
-		dev_err(dev->dev, "failed to create planes: %d\n", ret);
+		drm_err(dev, "failed to create planes: %d\n", ret);
 		return ret;
 	}
 
 	ret = atmel_hlcdc_crtc_create(dev);
 	if (ret) {
-		dev_err(dev->dev, "failed to create crtc\n");
+		drm_err(dev, "failed to create crtc\n");
 		return ret;
 	}
 
@@ -778,7 +778,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 
 	ret = clk_prepare_enable(dc->hlcdc->periph_clk);
 	if (ret) {
-		dev_err(dev->dev, "failed to enable periph_clk\n");
+		drm_err(dev, "failed to enable periph_clk\n");
 		return ret;
 	}
 
@@ -786,13 +786,13 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 
 	ret = drm_vblank_init(dev, 1);
 	if (ret < 0) {
-		dev_err(dev->dev, "failed to initialize vblank\n");
+		drm_err(dev, "failed to initialize vblank\n");
 		goto err_periph_clk_disable;
 	}
 
 	ret = atmel_hlcdc_dc_modeset_init(dev);
 	if (ret < 0) {
-		dev_err(dev->dev, "failed to initialize mode setting\n");
+		drm_err(dev, "failed to initialize mode setting\n");
 		goto err_periph_clk_disable;
 	}
 
@@ -802,7 +802,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 	ret = atmel_hlcdc_dc_irq_install(dev, dc->hlcdc->irq);
 	pm_runtime_put_sync(dev->dev);
 	if (ret < 0) {
-		dev_err(dev->dev, "failed to install IRQ handler\n");
+		drm_err(dev, "failed to install IRQ handler\n");
 		goto err_periph_clk_disable;
 	}
 
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 50fee6a93964..0b8a86afb096 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -15,6 +15,7 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
+#include <drm/drm_print.h>
 #include <drm/drm_simple_kms_helper.h>
 
 #include "atmel_hlcdc_dc.h"
@@ -92,7 +93,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 	output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
 	of_node_put(ep);
 	if (output->bus_fmt < 0) {
-		dev_err(dev->dev, "endpoint %d: invalid bus width\n", endpoint);
+		drm_err(dev, "endpoint %d: invalid bus width\n", endpoint);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 4a7ba0918eca..817284509b57 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -1034,7 +1034,7 @@ static void atmel_hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
 	if (isr &
 	    (ATMEL_HLCDC_LAYER_OVR_IRQ(0) | ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
 	     ATMEL_HLCDC_LAYER_OVR_IRQ(2)))
-		dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
+		drm_dbg(plane->base.dev, "overrun on plane %s\n",
 			desc->name);
 }
 
@@ -1051,7 +1051,7 @@ static void atmel_xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
 	if (isr &
 	    (ATMEL_XLCDC_LAYER_OVR_IRQ(0) | ATMEL_XLCDC_LAYER_OVR_IRQ(1) |
 	     ATMEL_XLCDC_LAYER_OVR_IRQ(2)))
-		dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
+		drm_dbg(plane->base.dev, "overrun on plane %s\n",
 			desc->name);
 }
 
@@ -1140,7 +1140,7 @@ static void atmel_hlcdc_plane_reset(struct drm_plane *p)
 	if (state) {
 		if (atmel_hlcdc_plane_alloc_dscrs(p, state)) {
 			kfree(state);
-			dev_err(p->dev->dev,
+			drm_err(p->dev,
 				"Failed to allocate initial plane state\n");
 			return;
 		}
-- 
2.43.0



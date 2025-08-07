Return-Path: <linux-kernel+bounces-759422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5368B1DD5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BAD18C7B9F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CAA2737FF;
	Thu,  7 Aug 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaepP3+c"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AC23DE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593749; cv=none; b=QR0peqvOhGYrWWzianhWLhoEY/ngFb+iTufVGy0SMGdFYhdND1x4+bFtm8cxcd/MFZDFO40BfTUZUo3opMxtKn1Aj7pec8ZCIG7nn8SCmX/KvkhbpL7d8v/+ibv1pxrff/K1VLug6KSrJRE9ikFDA2mMLsa2kfibMr7uPfNUfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593749; c=relaxed/simple;
	bh=s591I6oynnReSxV3Au7zUb5EcbAqH7epNKeOHAuJfAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMudjeGWkOH1mNUvApx6ahBCJAyOTa5Nhxgn/kBjO1P4HcDOblnt6iR9Bv342Pt+wu++LSpy/49V+VprGE8UF4qqpQD4hNFe1CXZU4nUdryEJjGuAjTUasa89PmE/yYr8ybsXM+UKR87e+BYuhazz1cPnCH7fWXqJLou0UV9yVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaepP3+c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45994a72356so11092695e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754593746; x=1755198546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g45HxYT9zBnvjsNtcvhDhW+w7if+fXdh8cchCdpgOBs=;
        b=JaepP3+c/eFYulj8HhvNEfRMXyCLeqyFDbm9Grs+PsbKQUY4biFvJmpCOVPugHSEyi
         OIYBbCl6x371TNyDEuQ9+02THaVhkH9DOI0SX/kMDp2rQlnEBEI4U8xt7Vs7EUkuXHMh
         gU5SRR/kSeim3Adqy+xv8Ug1EbIJ0OlobKcV/pBRa+ExRDs/dytb3U1YOviGa1j/x+Hv
         sqtBivXWI9Vapk5SNPwUDUsw4z9jY0ishg2sAApoko6rVlqFtN4u2LcYpdTvVRb/ojnW
         TlUvgLB9vMHlbjp2LLkCyrMkiiJbx6WCoZYF10OhtfMbPV2b7hqkPDiqob8GXmt3ZvNz
         yYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754593746; x=1755198546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g45HxYT9zBnvjsNtcvhDhW+w7if+fXdh8cchCdpgOBs=;
        b=v3U/0p5m60JzvUt0uxHFgRUMJ3nIoIcpKoZw/OkLRp1g1JcmniC2vt3eOlZqDNdTnR
         qKuoZdRYEICZMnwfyR5o9+JDoQsCbouPwOQTSSQ5PhWumzfJTw2c33m1xAxbyWrDNJmV
         0nEv/YcRKc6fpZt71/eR/r31bAYNx2ztP5z7/2YgZBqHY11T/ZN/3PGknSKeLAJ6xtiq
         ePVdU/oRY8okNp4zpy2YLaW5TwR/if8O4rYBF1IRJ3SSRenD4ijhZi0RLvIGLEyUwsDc
         xwRosK8D/nvm3q/Id2G00amRfO+skzPY7/0vY8t+opTXNUlTfRTM/UMgkUivdgDU5sUS
         mObA==
X-Forwarded-Encrypted: i=1; AJvYcCW7c18N2b5bc6zY3rR6Qk/2s/77mYG7pfQDqiW0OiJWzmDYdFEbcih0lboRiPybiP7qbtL9wdNsX/Iz/Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJiTiUB7WiECNirigaMNOmfUNwylFrwQ/cijiR7owxzzf12/v5
	n3XdGqk82VdATRNOUeDnFfSsv7n+C6PBoPiPuh9PmcuFfwW++8ZjzfrJ
X-Gm-Gg: ASbGncsST4pvFhQfY2w2cwGBSrh5UK0X44zNVAHJsXKqgNvdv+Dk/IulQgI9apXGTsK
	+ARtPG+ck0YKKF4wKlFS0dZAMlt238YH13JkbAkdkX49ACkqUdxZWRCOvQlo8bPrWT1vQ3RlvZD
	RrJDX6TR32zADfCI4cDKqgGSo1Kg08m179ZFS4urpf9YnZVmmT+ciY3okgbshFeDVAw6XaohMHz
	6H4qSDFR/8pi499LWz6mX3nOHrwT871oq71lQNDeVdqanNW13idPrR+hJ/vE4niSqnmmLDfCrOY
	6P7lnOOTZye0SA1IOQX0O+kkYN5SZDuX6GUoymQrFvgPcgTifHoa1/tLrjOw5qcXnEu5tTNExpo
	iNLBMNmXC3sIB73Iw0XegS2rH/LaMTw1H6mMbHVVfEEgKVwriRzKX06NE2PbQ76LtSRisL4ez0S
	4=
X-Google-Smtp-Source: AGHT+IFobf4kIojYuJxP0fDlodEmVFPL4ql9FtQA1VuvrVstvddIqRAyKDvTstbs/lgtnuFoO8r1Zg==
X-Received: by 2002:a05:600c:4c84:b0:459:dd4e:4435 with SMTP id 5b1f17b1804b1-459ede7d688mr31015785e9.5.1754593745799;
        Thu, 07 Aug 2025 12:09:05 -0700 (PDT)
Received: from ekhafagy-ROG-Zephyrus-M16-GU603HR-GU603HR.. ([156.204.172.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9074sm27131957f8f.17.2025.08.07.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:09:05 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: 
Cc: skhan@linuxfoundation.com,
	Eslam Khafagy <eslam.medhat1993@gmail.com>,
	Manikandan Muralidharan <manikandan.m@microchip.com>,
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
Subject: [PATCH v3] drm: atmel-hlcdc: replace dev_* print funtions with drm_* variants
Date: Thu,  7 Aug 2025 22:03:12 +0300
Message-ID: <20250807190857.92431-1-eslam.medhat1993@gmail.com>
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
https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
v3:
* include header file to fix compilation. Thanks Manikandan.

v2:
* replace dev_dbg with drm_dbg  in atmel_hlcdc_plane.c
* https://lore.kernel.org/all/20250806183049.52112-2-eslam.medhat1993@gmail.com/

v1:
* replace dev_* print funtions with drm_* variants
*https://lore.kernel.org/all/20250806000141.239753-2-eslam.medhat1993@gmail.com/

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



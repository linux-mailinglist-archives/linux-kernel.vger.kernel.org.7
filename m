Return-Path: <linux-kernel+bounces-891765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC2C436C8
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 01:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D43834E1A76
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 00:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4118635D;
	Sun,  9 Nov 2025 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdXI5fve"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F29443
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762647652; cv=none; b=mHk7xU8HTKCOvJQfInTh77mEphXo7UVBPfjvobz3IeNTQjUIV0Li59pcddfqvDpnF1T3tN0GtxMfksnWvtoO6B3imkXIILmTiCFDKqJxCbYMrpyDz3mYCtYFGCviToubrKZXjYQgf8ZN/GddnzJCfF2WK4bGgxC71BsvXZc90Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762647652; c=relaxed/simple;
	bh=DUk0EGi6uoMXiizPUZVMjnzd3iLS70c1Uk8T1q38fwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hhIs9X8ele3rt0OA3MSj+NWM652nzN//b4H/iNhUTCgF8/DBpKw13jmZdTSr/VM0IvMiZq03L0u+d6Ne18mRB4N6kXkPw2qYzwMucrArsRs07Ib3Oaq3Bac2NlNOuFYzRg08IUfW0n1kjI7grR0G2tUAGe9vtiGWnTwT1rIeA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdXI5fve; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47778b23f64so905225e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 16:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762647649; x=1763252449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFi0sAyKoBCnKFhTmWWYtrg2wpuTBa2Vsv6Uy0z7Gaw=;
        b=QdXI5fve5g7Lg+My88lSCvdGGLhnyRuqt1mEu/RM5eW6etmB+CWIARu4NTwIESG3/B
         axPQOVr8ldt3KBLLijmvj2VthoNjMTAtMJQapnHqfnLC+/kPug/dENHc+TmUG2na0uGu
         oPnou4nOOqowTYujgcjv3RBcNtCKFA4N+dN4iRZ0B8ORweFGtPt4wWRCnvcimwdcRfXX
         FzrjbPfA58D7n8aFHmqKvV7stvVU4Xk7PInUkCl0MsbBVl19uJyWPc6DJWzsLHdt5Zo5
         Z0eHYElSBq+Wd2rfcS04SFcVemGibu3GWlTabtcxruYlaug+jBoI9igmcYWxjPHOIaMo
         h47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762647649; x=1763252449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFi0sAyKoBCnKFhTmWWYtrg2wpuTBa2Vsv6Uy0z7Gaw=;
        b=r/hreZYtvExBFAkscmtMDPwn1SDzv7d53XDjer0bQduemuKF+UcZ0H8ErSByEwt+W6
         JaV4WOYLgLZqbAeFJbkS9srMHfpdFVPxxNYX2NAPGgXglB4kvh9ppW0wrVLNpEvPsrgU
         zOHIFqHDLyv7Fo3Yp8P/aWUhcPOlKzbdqAT3FSm0PfqE9Mrvqy9HunuUDTKkK2APbY7q
         gVI+0uKH52qmOXcuKF4qSAEWqrnXIp/pZ6HUovChFJ0JhbAZQIHnjsmDMhO7/h6UV9KJ
         K4AmNGZV755xQqPN4yXKnI5zVT+/Zx2FLfgyUbxuJaYj4nGObnQf+ILMKxUgIpjirCos
         uz7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0dXknHVo1h4qXRXuYAUZpJNa6cIF8IlR2vktqxdqqPJF4L4+bYZPH/IFIBKUHQ/358Nqt3RcZoV3Uapo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKajTDKLHVV9zvzvm9GSDyCxbfJd2lfjqZ7TbJtFuKBAwraaUr
	ozhc0/VtKuP8VlcyT3khwrAp9NrVcmTR0dOtoVXGI9MsMCpPAMWDxCCj
X-Gm-Gg: ASbGncvi6Or8IfXMicQ34LLxAcbL/+kiNmRXxO0vgVwFf6AIpJd6NMX0/rXFRWzBt0M
	bmaAJQ/NjYloaptRekd2NjW3+gowzydb8FXnvER2xJNG4Kd7H16R+tZGNy0uPDjArxmQxDS4F2Q
	iiQ2/5mzkYGCXHxFgDq/i4k2LdOhoyP5z0TpUWc8cboPIW3Zgv8XEfPl/WcCHm16xFvZGPdtzuT
	mmUmg6yTdrzGLlSa4hxmA5w/p8F9kueaRXqvNEz8h7XJnEX1NoyFZH3EqbRYEnZYQ9olT3tJVfI
	FPJB7LnfPkyhdYO56PH1BgUd5bCAMxkqAIhrH1Hg3yFR275PyFkREqFyxaSRxWOm30YFBmg23U+
	RvOvD9oHhiPmlz9C6Oh3Vlx2xsa8iNs5CV6rf4epNascMNr2lZbqhXr9yg1WAe/znkXWyThTcS7
	JnCPBjkm/kT4eF4bfVF1XuZLyFP8mxHVo=
X-Google-Smtp-Source: AGHT+IGAX52TOu3xcrF7k0Z2xnSH9aSnRjH25BVqUHGKDaJCpk1xP1pbe94SWO8edzPJTDz+fWzgvg==
X-Received: by 2002:a05:600c:1382:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-47773293056mr29900615e9.28.1762647648706;
        Sat, 08 Nov 2025 16:20:48 -0800 (PST)
Received: from ekhafagy-ROG-Strix.. ([156.204.26.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm13604647f8f.9.2025.11.08.16.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 16:20:48 -0800 (PST)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: linus.walleij@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	eslam.medhat1993@gmail.com
Subject: [PATCH] drm: pl111: replace dev_* print functions with drm_* variants
Date: Sun,  9 Nov 2025 02:19:56 +0200
Message-ID: <20251109001956.2359111-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the PL111 CLCD driver to use DRM print macros drm_*() instead of
dev_*(). This change ensures consistency with DRM subsystem
logging conventions [1].

[1]
Link: https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/gpu/drm/pl111/pl111_display.c   |  4 +-
 drivers/gpu/drm/pl111/pl111_drv.c       | 28 ++++++-------
 drivers/gpu/drm/pl111/pl111_nomadik.c   |  4 +-
 drivers/gpu/drm/pl111/pl111_nomadik.h   |  4 +-
 drivers/gpu/drm/pl111/pl111_versatile.c | 52 ++++++++++++-------------
 drivers/gpu/drm/pl111/pl111_versatile.h |  2 +-
 6 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index b9fe926a49e8..bc7acb3a2810 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -137,7 +137,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 
 	ret = clk_set_rate(priv->clk, mode->clock * 1000);
 	if (ret) {
-		dev_err(drm->dev,
+		drm_err(drm,
 			"Failed to set pixel clock rate to %d: %d\n",
 			mode->clock * 1000, ret);
 	}
@@ -549,7 +549,7 @@ pl111_init_clock_divider(struct drm_device *drm)
 	int ret;
 
 	if (IS_ERR(parent)) {
-		dev_err(drm->dev, "CLCD: unable to get clcdclk.\n");
+		drm_err(drm, "CLCD: unable to get clcdclk.\n");
 		return PTR_ERR(parent);
 	}
 
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 56ff6a3fb483..4833d18b4040 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -98,7 +98,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 		struct drm_panel *tmp_panel;
 		struct drm_bridge *tmp_bridge;
 
-		dev_dbg(dev->dev, "checking endpoint %d\n", i);
+		drm_dbg(dev, "checking endpoint %d\n", i);
 
 		ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
 						  0, i,
@@ -114,18 +114,18 @@ static int pl111_modeset_init(struct drm_device *dev)
 				defer = true;
 			} else if (ret != -ENODEV) {
 				/* Continue, maybe something else is working */
-				dev_err(dev->dev,
+				drm_err(dev,
 					"endpoint %d returns %d\n", i, ret);
 			}
 		}
 
 		if (tmp_panel) {
-			dev_info(dev->dev,
+			drm_info(dev,
 				 "found panel on endpoint %d\n", i);
 			panel = tmp_panel;
 		}
 		if (tmp_bridge) {
-			dev_info(dev->dev,
+			drm_info(dev,
 				 "found bridge on endpoint %d\n", i);
 			bridge = tmp_bridge;
 		}
@@ -149,9 +149,9 @@ static int pl111_modeset_init(struct drm_device *dev)
 			goto finish;
 		}
 	} else if (bridge) {
-		dev_info(dev->dev, "Using non-panel bridge\n");
+		drm_info(dev, "Using non-panel bridge\n");
 	} else {
-		dev_err(dev->dev, "No bridge, exiting\n");
+		drm_err(dev, "No bridge, exiting\n");
 		return -ENODEV;
 	}
 
@@ -163,7 +163,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 
 	ret = pl111_display_init(dev);
 	if (ret != 0) {
-		dev_err(dev->dev, "Failed to init display\n");
+		drm_err(dev, "Failed to init display\n");
 		goto out_bridge;
 	}
 
@@ -175,7 +175,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 	if (!priv->variant->broken_vblank) {
 		ret = drm_vblank_init(dev, 1);
 		if (ret != 0) {
-			dev_err(dev->dev, "Failed to init vblank\n");
+			drm_err(dev, "Failed to init vblank\n");
 			goto out_bridge;
 		}
 	}
@@ -255,13 +255,13 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 
 	ret = of_reserved_mem_device_init(dev);
 	if (!ret) {
-		dev_info(dev, "using device-specific reserved memory\n");
+		drm_info(drm, "using device-specific reserved memory\n");
 		priv->use_device_memory = true;
 	}
 
 	if (of_property_read_u32(dev->of_node, "max-memory-bandwidth",
 				 &priv->memory_bw)) {
-		dev_info(dev, "no max memory bandwidth specified, assume unlimited\n");
+		drm_info(drm, "no max memory bandwidth specified, assume unlimited\n");
 		priv->memory_bw = 0;
 	}
 
@@ -276,17 +276,17 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 
 	priv->regs = devm_ioremap_resource(dev, &amba_dev->res);
 	if (IS_ERR(priv->regs)) {
-		dev_err(dev, "%s failed mmio\n", __func__);
+		drm_err(drm, "%s failed mmio\n", __func__);
 		ret = PTR_ERR(priv->regs);
 		goto dev_put;
 	}
 
 	/* This may override some variant settings */
-	ret = pl111_versatile_init(dev, priv);
+	ret = pl111_versatile_init(drm, priv);
 	if (ret)
 		goto dev_put;
 
-	pl111_nomadik_init(dev);
+	pl111_nomadik_init(drm);
 
 	/* turn off interrupts before requesting the irq */
 	writel(0, priv->regs + priv->ienb);
@@ -294,7 +294,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	ret = devm_request_irq(dev, amba_dev->irq[0], pl111_irq, 0,
 			       variant->name, priv);
 	if (ret != 0) {
-		dev_err(dev, "%s failed irq %d\n", __func__, ret);
+		drm_err(drm, "%s failed irq %d\n", __func__, ret);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/pl111/pl111_nomadik.c b/drivers/gpu/drm/pl111/pl111_nomadik.c
index 6f385e59be22..f3218d59c5f1 100644
--- a/drivers/gpu/drm/pl111/pl111_nomadik.c
+++ b/drivers/gpu/drm/pl111/pl111_nomadik.c
@@ -9,7 +9,7 @@
 #define PMU_CTRL_OFFSET 0x0000
 #define PMU_CTRL_LCDNDIF BIT(26)
 
-void pl111_nomadik_init(struct device *dev)
+void pl111_nomadik_init(struct drm_device *dev)
 {
 	struct regmap *pmu_regmap;
 
@@ -31,6 +31,6 @@ void pl111_nomadik_init(struct device *dev)
 			   PMU_CTRL_OFFSET,
 			   PMU_CTRL_LCDNDIF,
 			   0);
-	dev_info(dev, "set Nomadik PMU mux to CLCD mode\n");
+	drm_info(dev, "set Nomadik PMU mux to CLCD mode\n");
 }
 EXPORT_SYMBOL_GPL(pl111_nomadik_init);
diff --git a/drivers/gpu/drm/pl111/pl111_nomadik.h b/drivers/gpu/drm/pl111/pl111_nomadik.h
index 47ccf5c839fc..b2c9f7cc1c8c 100644
--- a/drivers/gpu/drm/pl111/pl111_nomadik.h
+++ b/drivers/gpu/drm/pl111/pl111_nomadik.h
@@ -8,11 +8,11 @@ struct device;
 
 #ifdef CONFIG_ARCH_NOMADIK
 
-void pl111_nomadik_init(struct device *dev);
+void pl111_nomadik_init(struct drm_device *dev);
 
 #else
 
-static inline void pl111_nomadik_init(struct device *dev)
+static inline void pl111_nomadik_init(struct drm_device *dev)
 {
 }
 
diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 5f460b296c0c..ec8683a1b5fc 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -116,7 +116,7 @@ static void pl111_integrator_enable(struct drm_device *drm, u32 format)
 {
 	u32 val;
 
-	dev_info(drm->dev, "enable Integrator CLCD connectors\n");
+	drm_info(drm, "enable Integrator CLCD connectors\n");
 
 	/* FIXME: really needed? */
 	val = INTEGRATOR_CLCD_LCD_STATIC1 | INTEGRATOR_CLCD_LCD_STATIC2 |
@@ -134,7 +134,7 @@ static void pl111_integrator_enable(struct drm_device *drm, u32 format)
 		val |= INTEGRATOR_CLCD_LCDMUX_VGA555;
 		break;
 	default:
-		dev_err(drm->dev, "unhandled format on Integrator 0x%08x\n",
+		drm_err(drm, "unhandled format on Integrator 0x%08x\n",
 			format);
 		break;
 	}
@@ -156,7 +156,7 @@ static void pl111_impd1_enable(struct drm_device *drm, u32 format)
 {
 	u32 val;
 
-	dev_info(drm->dev, "enable IM-PD1 CLCD connectors\n");
+	drm_info(drm, "enable IM-PD1 CLCD connectors\n");
 	val = IMPD1_CTRL_DISP_VGA | IMPD1_CTRL_DISP_ENABLE;
 
 	regmap_update_bits(versatile_syscon_map,
@@ -167,7 +167,7 @@ static void pl111_impd1_enable(struct drm_device *drm, u32 format)
 
 static void pl111_impd1_disable(struct drm_device *drm)
 {
-	dev_info(drm->dev, "disable IM-PD1 CLCD connectors\n");
+	drm_info(drm, "disable IM-PD1 CLCD connectors\n");
 
 	regmap_update_bits(versatile_syscon_map,
 			   IMPD1_CTRL_OFFSET,
@@ -194,7 +194,7 @@ static void pl111_impd1_disable(struct drm_device *drm)
 
 static void pl111_versatile_disable(struct drm_device *drm)
 {
-	dev_info(drm->dev, "disable Versatile CLCD connectors\n");
+	drm_info(drm, "disable Versatile CLCD connectors\n");
 	regmap_update_bits(versatile_syscon_map,
 			   SYS_CLCD,
 			   SYS_CLCD_CONNECTOR_MASK,
@@ -205,7 +205,7 @@ static void pl111_versatile_enable(struct drm_device *drm, u32 format)
 {
 	u32 val = 0;
 
-	dev_info(drm->dev, "enable Versatile CLCD connectors\n");
+	drm_info(drm, "enable Versatile CLCD connectors\n");
 
 	switch (format) {
 	case DRM_FORMAT_ABGR8888:
@@ -227,7 +227,7 @@ static void pl111_versatile_enable(struct drm_device *drm, u32 format)
 		val |= SYS_CLCD_MODE_5551;
 		break;
 	default:
-		dev_err(drm->dev, "unhandled format on Versatile 0x%08x\n",
+		drm_err(drm, "unhandled format on Versatile 0x%08x\n",
 			format);
 		break;
 	}
@@ -247,7 +247,7 @@ static void pl111_versatile_enable(struct drm_device *drm, u32 format)
 
 static void pl111_realview_clcd_disable(struct drm_device *drm)
 {
-	dev_info(drm->dev, "disable RealView CLCD connectors\n");
+	drm_info(drm, "disable RealView CLCD connectors\n");
 	regmap_update_bits(versatile_syscon_map,
 			   SYS_CLCD,
 			   SYS_CLCD_CONNECTOR_MASK,
@@ -256,7 +256,7 @@ static void pl111_realview_clcd_disable(struct drm_device *drm)
 
 static void pl111_realview_clcd_enable(struct drm_device *drm, u32 format)
 {
-	dev_info(drm->dev, "enable RealView CLCD connectors\n");
+	drm_info(drm, "enable RealView CLCD connectors\n");
 	regmap_update_bits(versatile_syscon_map,
 			   SYS_CLCD,
 			   SYS_CLCD_CONNECTOR_MASK,
@@ -376,7 +376,7 @@ static const struct pl111_variant_data pl111_vexpress = {
 #define VEXPRESS_FPGAMUX_DAUGHTERBOARD_1	0x01
 #define VEXPRESS_FPGAMUX_DAUGHTERBOARD_2	0x02
 
-static int pl111_vexpress_clcd_init(struct device *dev, struct device_node *np,
+static int pl111_vexpress_clcd_init(struct drm_device *dev, struct device_node *np,
 				    struct pl111_drm_dev_private *priv)
 {
 	struct platform_device *pdev;
@@ -433,22 +433,22 @@ static int pl111_vexpress_clcd_init(struct device *dev, struct device_node *np,
 		mux_motherboard = false;
 
 	if (mux_motherboard) {
-		dev_info(dev, "DVI muxed to motherboard CLCD\n");
+		drm_info(dev, "DVI muxed to motherboard CLCD\n");
 		val = VEXPRESS_FPGAMUX_MOTHERBOARD;
-	} else if (ct_clcd == dev->of_node) {
-		dev_info(dev,
+	} else if (ct_clcd == dev->dev->of_node) {
+		drm_info(dev,
 			 "DVI muxed to daughterboard 1 (core tile) CLCD\n");
 		val = VEXPRESS_FPGAMUX_DAUGHTERBOARD_1;
 	} else {
-		dev_info(dev, "core tile graphics present\n");
-		dev_info(dev, "this device will be deactivated\n");
+		drm_info(dev, "core tile graphics present\n");
+		drm_info(dev, "this device will be deactivated\n");
 		return -ENODEV;
 	}
 
 	/* Call into deep Vexpress configuration API */
 	pdev = of_find_device_by_node(np);
 	if (!pdev) {
-		dev_err(dev, "can't find the sysreg device, deferring\n");
+		drm_err(dev, "can't find the sysreg device, deferring\n");
 		return -EPROBE_DEFER;
 	}
 
@@ -461,17 +461,17 @@ static int pl111_vexpress_clcd_init(struct device *dev, struct device_node *np,
 	ret = regmap_write(map, 0, val);
 	platform_device_put(pdev);
 	if (ret) {
-		dev_err(dev, "error setting DVI muxmode\n");
+		drm_err(dev, "error setting DVI muxmode\n");
 		return -ENODEV;
 	}
 
 	priv->variant = &pl111_vexpress;
-	dev_info(dev, "initializing Versatile Express PL111\n");
+	drm_info(dev, "initializing Versatile Express PL111\n");
 
 	return 0;
 }
 
-int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
+int pl111_versatile_init(struct drm_device *dev, struct pl111_drm_dev_private *priv)
 {
 	const struct of_device_id *clcd_id;
 	enum versatile_clcd versatile_clcd_type;
@@ -492,7 +492,7 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 		int ret = pl111_vexpress_clcd_init(dev, np, priv);
 		of_node_put(np);
 		if (ret)
-			dev_err(dev, "Versatile Express init failed - %d", ret);
+			drm_err(dev, "Versatile Express init failed - %d", ret);
 		return ret;
 	}
 
@@ -511,7 +511,7 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 	map = syscon_node_to_regmap(np);
 	of_node_put(np);
 	if (IS_ERR(map)) {
-		dev_err(dev, "no Versatile syscon regmap\n");
+		drm_err(dev, "no Versatile syscon regmap\n");
 		return PTR_ERR(map);
 	}
 
@@ -520,14 +520,14 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 		versatile_syscon_map = map;
 		priv->variant = &pl110_integrator;
 		priv->variant_display_enable = pl111_integrator_enable;
-		dev_info(dev, "set up callbacks for Integrator PL110\n");
+		drm_info(dev, "set up callbacks for Integrator PL110\n");
 		break;
 	case INTEGRATOR_IMPD1:
 		versatile_syscon_map = map;
 		priv->variant = &pl110_impd1;
 		priv->variant_display_enable = pl111_impd1_enable;
 		priv->variant_display_disable = pl111_impd1_disable;
-		dev_info(dev, "set up callbacks for IM-PD1 PL110\n");
+		drm_info(dev, "set up callbacks for IM-PD1 PL110\n");
 		break;
 	case VERSATILE_CLCD:
 		versatile_syscon_map = map;
@@ -542,7 +542,7 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 		 */
 		priv->ienb = CLCD_PL111_IENB;
 		priv->ctrl = CLCD_PL111_CNTL;
-		dev_info(dev, "set up callbacks for Versatile PL110\n");
+		drm_info(dev, "set up callbacks for Versatile PL110\n");
 		break;
 	case REALVIEW_CLCD_EB:
 	case REALVIEW_CLCD_PB1176:
@@ -553,10 +553,10 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 		priv->variant = &pl111_realview;
 		priv->variant_display_enable = pl111_realview_clcd_enable;
 		priv->variant_display_disable = pl111_realview_clcd_disable;
-		dev_info(dev, "set up callbacks for RealView PL111\n");
+		drm_info(dev, "set up callbacks for RealView PL111\n");
 		break;
 	default:
-		dev_info(dev, "unknown Versatile system controller\n");
+		drm_info(dev, "unknown Versatile system controller\n");
 		break;
 	}
 
diff --git a/drivers/gpu/drm/pl111/pl111_versatile.h b/drivers/gpu/drm/pl111/pl111_versatile.h
index 143877010042..7a15c5f7efe8 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.h
+++ b/drivers/gpu/drm/pl111/pl111_versatile.h
@@ -7,6 +7,6 @@
 struct device;
 struct pl111_drm_dev_private;
 
-int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv);
+int pl111_versatile_init(struct drm_device *dev, struct pl111_drm_dev_private *priv);
 
 #endif
-- 
2.43.0



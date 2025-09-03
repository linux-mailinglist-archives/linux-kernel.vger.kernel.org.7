Return-Path: <linux-kernel+bounces-799256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E69DB42915
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0A55816DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C0C36934A;
	Wed,  3 Sep 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U6oWkHLN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2B368097
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925502; cv=none; b=EveDSyVTc/GAg11IHxVGrbiWOMRazkYKhxtT9GSHDTDrXEyakr0d0ENynGceVAth/7rKfP0h8a++Z+2bUECxd7WxoWaMpgsTWKFz8X14yko/mzn39LxM7dHGozd7FPvhBtERLVE/n+jfCq5Cj1yJ7Rs3qJhhNM7+myJu+BJ2Wb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925502; c=relaxed/simple;
	bh=R0oflqcTBWlX0b4YCyWSou1MTD7R2HRR3jtaeYRxJbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzqgLayChMX9eAjg59HKZdYqNrUDAN/NpRUs8NjDBA6f4vsPiCszS67UlGBWT7g/U6xibPADKVbt2IXYsQBwF5MvuEAuKOnYphKppZ1weohM7+21uR4meIApKAcR11ICnLjCCFSgbEPtMUZ4w0YzJ1NmCEBNYabVXI+nK3oVGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U6oWkHLN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756925498;
	bh=R0oflqcTBWlX0b4YCyWSou1MTD7R2HRR3jtaeYRxJbE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U6oWkHLNgFsMr372iGKU0vgp9oh/H36eTC9Wa5sznTgNeAS2Rbz/e5j/cCll+Ysd6
	 bo+SHro9I3ezrZBWVxSdFV20DRfGpppRLH3ahqlsu3apQAuQKEUNxnp0nOrhNShd3n
	 rvyCtjxrqObjvOboaC77Z62pKeGZwyuOdHPHHmrZk7vU9JtCuhRq9skwRMqPDbZ4Yi
	 Dxap/27yhkFQxTLTZe5frhVzk8Yc/+BqiEVxbjuRh3aJVWnL/ptr6Oc/5SWVNAftgy
	 ProROScqdasCOhhXhBm9VMtkr9sljfH1UB5UUbCb6XjlpJ33K1OAnKIZ9nLMHfIfpy
	 +5ii3FWfEysDw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 49B6B17E1301;
	Wed,  3 Sep 2025 20:51:38 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 03 Sep 2025 21:51:01 +0300
Subject: [PATCH v4 3/6] drm/rockchip: dw_hdmi_qp: Improve error handling
 with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-rk3588-hdmi-cec-v4-3-fa25163c4b08@collabora.com>
References: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
In-Reply-To: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>
X-Mailer: b4 0.14.2

The error handling in dw_hdmi_qp_rockchip_bind() is quite inconsistent,
i.e. in some cases the error code is not included in the message, while
in some other cases there is no check for -EPROBE_DEFER.

Since this is part of the probe path, address the aforementioned issues
by switching to dev_err_probe(), which also reduces the code a bit.

Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 62 ++++++++++----------------
 1 file changed, 24 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index ed6e8f036f4b3d76425725c130394cedf039acd0..a775d89f20fc20e9103ecbac0dcf3db10ba9984f 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -455,10 +455,8 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return -ENODEV;
 
 	if (!cfg->ctrl_ops || !cfg->ctrl_ops->io_init ||
-	    !cfg->ctrl_ops->irq_callback || !cfg->ctrl_ops->hardirq_callback) {
-		dev_err(dev, "Missing platform ctrl ops\n");
-		return -ENODEV;
-	}
+	    !cfg->ctrl_ops->irq_callback || !cfg->ctrl_ops->hardirq_callback)
+		return dev_err_probe(dev, -ENODEV, "Missing platform ctrl ops\n");
 
 	hdmi->ctrl_ops = cfg->ctrl_ops;
 	hdmi->dev = &pdev->dev;
@@ -471,10 +469,9 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 			break;
 		}
 	}
-	if (hdmi->port_id < 0) {
-		dev_err(hdmi->dev, "Failed to match HDMI port ID\n");
-		return hdmi->port_id;
-	}
+	if (hdmi->port_id < 0)
+		return dev_err_probe(hdmi->dev, hdmi->port_id,
+				     "Failed to match HDMI port ID\n");
 
 	plat_data.phy_ops = cfg->phy_ops;
 	plat_data.phy_data = hdmi;
@@ -495,39 +492,30 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 
 	hdmi->regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
 						       "rockchip,grf");
-	if (IS_ERR(hdmi->regmap)) {
-		dev_err(hdmi->dev, "Unable to get rockchip,grf\n");
-		return PTR_ERR(hdmi->regmap);
-	}
+	if (IS_ERR(hdmi->regmap))
+		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->regmap),
+				     "Unable to get rockchip,grf\n");
 
 	hdmi->vo_regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
 							  "rockchip,vo-grf");
-	if (IS_ERR(hdmi->vo_regmap)) {
-		dev_err(hdmi->dev, "Unable to get rockchip,vo-grf\n");
-		return PTR_ERR(hdmi->vo_regmap);
-	}
+	if (IS_ERR(hdmi->vo_regmap))
+		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->vo_regmap),
+				     "Unable to get rockchip,vo-grf\n");
 
 	ret = devm_clk_bulk_get_all_enabled(hdmi->dev, &clks);
-	if (ret < 0) {
-		dev_err(hdmi->dev, "Failed to get clocks: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(hdmi->dev, ret, "Failed to get clocks\n");
 
 	hdmi->enable_gpio = devm_gpiod_get_optional(hdmi->dev, "enable",
 						    GPIOD_OUT_HIGH);
-	if (IS_ERR(hdmi->enable_gpio)) {
-		ret = PTR_ERR(hdmi->enable_gpio);
-		dev_err(hdmi->dev, "Failed to request enable GPIO: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(hdmi->enable_gpio))
+		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->enable_gpio),
+				     "Failed to request enable GPIO\n");
 
 	hdmi->phy = devm_of_phy_get_by_index(dev, dev->of_node, 0);
-	if (IS_ERR(hdmi->phy)) {
-		ret = PTR_ERR(hdmi->phy);
-		if (ret != -EPROBE_DEFER)
-			dev_err(hdmi->dev, "failed to get phy: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(hdmi->phy))
+		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->phy),
+				     "Failed to get phy\n");
 
 	cfg->ctrl_ops->io_init(hdmi);
 
@@ -556,17 +544,15 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 
 	hdmi->hdmi = dw_hdmi_qp_bind(pdev, encoder, &plat_data);
 	if (IS_ERR(hdmi->hdmi)) {
-		ret = PTR_ERR(hdmi->hdmi);
 		drm_encoder_cleanup(encoder);
-		return ret;
+		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->hdmi),
+				     "Failed to bind dw-hdmi-qp");
 	}
 
 	connector = drm_bridge_connector_init(drm, encoder);
-	if (IS_ERR(connector)) {
-		ret = PTR_ERR(connector);
-		dev_err(hdmi->dev, "failed to init bridge connector: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(connector))
+		return dev_err_probe(hdmi->dev, PTR_ERR(connector),
+				     "Failed to init bridge connector\n");
 
 	return drm_connector_attach_encoder(connector, encoder);
 }

-- 
2.51.0



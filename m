Return-Path: <linux-kernel+bounces-722277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3076EAFD735
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EEA7A2066
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228862264D9;
	Tue,  8 Jul 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LFiLadoq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989122264A3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003460; cv=none; b=Uhd1VgCiW3+6IfFKa/JAZ8H3rEnhB+EYMD4vosc/GyDOQgqTMVhhnycb7mfTpcL8oWRp08/37bu3gC28+Nal84F7yH9lQgSvVIhSOVwFbx4JgmaGcimpC4IgwfNCcnDG1UBP26eAN/9nDc2sRzY/VvIZmsrYeJ4Mh6QN/Jvjp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003460; c=relaxed/simple;
	bh=5dQ0pMExHH9Kjg4AVLoBbYdvBCDQ1/JHCihaKBltBb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MWc5PiF/2MTArthy4vsie97fnqdDqj1v+HVnrq3Fl+D/541NcnwTHEnfFU7xGODf5KRUPzwy2jfAIw6UzlRGQhjMzA1yWUAA0ZmVN/x3n4zW3HpG6W+w5XPmDUizTrifGX9V08xdqURzQJde/tbxWcoRs+HOi7FitMfvD12DC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LFiLadoq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752003457;
	bh=5dQ0pMExHH9Kjg4AVLoBbYdvBCDQ1/JHCihaKBltBb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LFiLadoq64Rz6aYjArqW0oWTXmLocN72v0RZ1QXbunm/QFUdFqoLlFSNpEhVinx3n
	 KixD8na1alhHioEjy5qgrih/Kqa67Jgk1AmtSa/jUbTU/ufflBfOWVUieL6uOfmpj/
	 j0z+JAquSpCb610JnRibgb7xj7UpciCdTO/OMt+rbSnHrD9tF9FNL5Q5tcpOMvWYLx
	 vPNyf4iG61yyeYl5H+YuerZxDDg2ujbw6HAURBUdfOieXmZtowojbQMJ8WUyWERM9H
	 SbvznXbuhc8+/LM/C6x/8Js2rEz2VgD6abn0ScZmfrpRiHeLDQs0or3bQvqA3K4u91
	 i6XmkdNrDhH+g==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 0411817E097F;
	Tue,  8 Jul 2025 21:37:36 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 08 Jul 2025 22:35:52 +0300
Subject: [PATCH 11/12] phy: rockchip: samsung-hdptx: Extend
 rk_hdptx_phy_verify_hdmi_config() helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-phy-hdptx-frl-v1-11-cfe096e224f4@collabora.com>
References: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
In-Reply-To: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

In order to facilitate introduction of HDMI 2.1 FRL support and to avoid
recomputing the link rate after verifying the HDMI configuration given
as input, extend rk_hdptx_phy_verify_hdmi_config() by providing an
optional output parameter to store the validated configuration.

For improved code readability, also rename the existing hdmi input
parameter.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 35 ++++++++++++-----------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 325d2596395123b88e4720cb503bee4436292e85..daccaf134c0ee36972f8f7c0eebf3dac86faeff1 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1477,25 +1477,24 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
 }
 
 static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
-					   struct phy_configure_opts_hdmi *hdmi)
+					   struct phy_configure_opts_hdmi *hdmi_in,
+					   struct rk_hdptx_hdmi_cfg *hdmi_out)
 {
 	int i;
 
-	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
+	if (!hdmi_in->tmds_char_rate || hdmi_in->tmds_char_rate > HDMI20_MAX_RATE)
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(rk_hdptx_tmds_ropll_cfg); i++)
-		if (hdmi->tmds_char_rate == rk_hdptx_tmds_ropll_cfg[i].rate)
+		if (hdmi_in->tmds_char_rate == rk_hdptx_tmds_ropll_cfg[i].rate)
 			break;
 
 	if (i == ARRAY_SIZE(rk_hdptx_tmds_ropll_cfg) &&
-	    !rk_hdptx_phy_clk_pll_calc(hdmi->tmds_char_rate, NULL))
+	    !rk_hdptx_phy_clk_pll_calc(hdmi_in->tmds_char_rate, NULL))
 		return -EINVAL;
 
-	if (!hdmi->bpc)
-		hdmi->bpc = 8;
-
-	switch (hdmi->bpc) {
+	switch (hdmi_in->bpc) {
+	case 0:
 	case 8:
 	case 10:
 	case 12:
@@ -1505,6 +1504,11 @@ static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
 		return -EINVAL;
 	}
 
+	if (hdmi_out) {
+		hdmi_out->rate = hdmi_in->tmds_char_rate;
+		hdmi_out->bpc = hdmi_in->bpc ?: 8;
+	}
+
 	return 0;
 }
 
@@ -1770,17 +1774,15 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 	int ret;
 
 	if (mode != PHY_MODE_DP) {
-		ret = rk_hdptx_phy_verify_hdmi_config(hdptx, &opts->hdmi);
+		ret = rk_hdptx_phy_verify_hdmi_config(hdptx, &opts->hdmi, &hdptx->hdmi_cfg);
 		if (ret) {
 			dev_err(hdptx->dev, "invalid hdmi params for phy configure\n");
 		} else {
-			hdptx->hdmi_cfg.rate = opts->hdmi.tmds_char_rate;
-			hdptx->hdmi_cfg.bpc = opts->hdmi.bpc;
 			hdptx->restrict_rate_change = true;
+			dev_dbg(hdptx->dev, "%s rate=%llu bpc=%u\n", __func__,
+				hdptx->hdmi_cfg.rate, hdptx->hdmi_cfg.bpc);
 		}
 
-		dev_dbg(hdptx->dev, "%s rate=%llu bpc=%u\n", __func__,
-			hdptx->hdmi_cfg.rate, hdptx->hdmi_cfg.bpc);
 		return ret;
 	}
 
@@ -1824,7 +1826,7 @@ static int rk_hdptx_phy_validate(struct phy *phy, enum phy_mode mode,
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
 
 	if (mode != PHY_MODE_DP)
-		return rk_hdptx_phy_verify_hdmi_config(hdptx, &opts->hdmi);
+		return rk_hdptx_phy_verify_hdmi_config(hdptx, &opts->hdmi, NULL);
 
 	return rk_hdptx_phy_verify_dp_config(hdptx, &opts->dp);
 }
@@ -1966,12 +1968,11 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 		struct phy_configure_opts_hdmi hdmi = {
 			.tmds_char_rate = rate,
 		};
-		int ret = rk_hdptx_phy_verify_hdmi_config(hdptx, &hdmi);
+
+		int ret = rk_hdptx_phy_verify_hdmi_config(hdptx, &hdmi, &hdptx->hdmi_cfg);
 
 		if (ret)
 			return ret;
-
-		hdptx->hdmi_cfg.rate = rate;
 	}
 
 	/*

-- 
2.50.0



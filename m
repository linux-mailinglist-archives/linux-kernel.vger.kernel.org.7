Return-Path: <linux-kernel+bounces-722276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C5BAFD734
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D673F1BC856E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1CF23B61F;
	Tue,  8 Jul 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gXnAMRDG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A567223DCE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003459; cv=none; b=ssH15Ip06M2UXr1xMw6gI9t78xmCvljM3On/tLjoEiBpmzdTOfqr9Ld+kvj3VyKtTjDCMnogtaImNlTGGsu0wfXjtsQW97ib74edD6/J3Vn/6wS5WxDu/rD7qZouSpcBWWoNypar5NULd6BC71CmLxJ3P1lgrkDbhvYsGd4REi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003459; c=relaxed/simple;
	bh=UF5ZXXMqvTtkif2zXehGRm+1hTMKVFVyOLPHZ1+Bikg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KX6BAdQinTEufCZPqJD/lJWN6ZTu6FiNyCIqseJn4cZeYBQ8b2S1Tp15lFL2baFJPZIw9as8xw2SyKX7gp+FMY3XnDdZ+9W15/MP65VjBgg2SVQ0uwByFF3+kI0wK9DpStRDXny9aT+efO9+a8GFkod1Oe5z1d9J6x0x7CuuCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gXnAMRDG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752003456;
	bh=UF5ZXXMqvTtkif2zXehGRm+1hTMKVFVyOLPHZ1+Bikg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gXnAMRDGbEZqfrGAO0Pi8JEccvkSP8GcV8ZUsDxl9UmPUXId7DhBAXdU48cIyY4BL
	 IZ746gT/v65PDXz5SJurmoa28+OeRtRn7lrEpc3JjpEQ/jFm8Tt/XEpGiUWyCSYWG4
	 nHqesF/7G+tFlf5GD35GveGgWZI/9G+vm9jANEUddHcNWHkg2LOcMhipkBP/NVdk3a
	 dfbnap9dTAnfJatpZ5RpvR70ns7CDy1G/6uCFuYhiuNqurp4o2XZ/bgkLVpS/mXkZ1
	 5jPkTKF8bDoYaiLrzAaA+o9bG9an1qhu+7VOrpa8j1ZqmATEtubhAfGgLpPdW/AuhN
	 WboqQVgTobVZA==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 2E96617E088B;
	Tue,  8 Jul 2025 21:37:36 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 08 Jul 2025 22:35:51 +0300
Subject: [PATCH 10/12] phy: rockchip: samsung-hdptx: Switch to driver
 specific HDMI config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-phy-hdptx-frl-v1-10-cfe096e224f4@collabora.com>
References: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
In-Reply-To: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

In preparation to support the FRL operation mode which gets configured
via the lanes and rate per lane tuple, switch to a driver specific
struct for configuring the link rate and bpc.

This simplifies and optimizes the implementation by allowing implicit
switches between TMDS and FRL rates, without requiring additional checks
of the active PHY mode followed by recalculations of the link rate when
operating in FRL mode.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 46 +++++++++++++----------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index e86bbc270a4ca448f55ca58b4b5b52d378730d74..325d2596395123b88e4720cb503bee4436292e85 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -387,6 +387,11 @@ struct rk_hdptx_phy_cfg {
 	unsigned int phy_ids[MAX_HDPTX_PHY_NUM];
 };
 
+struct rk_hdptx_hdmi_cfg {
+	unsigned long long rate;
+	unsigned int bpc;
+};
+
 struct rk_hdptx_phy {
 	struct device *dev;
 	struct regmap *regmap;
@@ -394,7 +399,7 @@ struct rk_hdptx_phy {
 
 	int phy_id;
 	struct phy *phy;
-	struct phy_configure_opts_hdmi hdmi_cfg;
+	struct rk_hdptx_hdmi_cfg hdmi_cfg;
 	struct clk_bulk_data *clks;
 	int nr_clks;
 	struct reset_control_bulk_data rsts[RST_MAX];
@@ -966,19 +971,19 @@ static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 	struct ropll_config rc = {0};
 	int ret, i;
 
-	if (!hdptx->hdmi_cfg.tmds_char_rate)
+	if (!hdptx->hdmi_cfg.rate)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(rk_hdptx_tmds_ropll_cfg); i++)
-		if (hdptx->hdmi_cfg.tmds_char_rate == rk_hdptx_tmds_ropll_cfg[i].rate) {
+		if (hdptx->hdmi_cfg.rate == rk_hdptx_tmds_ropll_cfg[i].rate) {
 			cfg = &rk_hdptx_tmds_ropll_cfg[i];
 			break;
 		}
 
 	if (!cfg) {
-		if (!rk_hdptx_phy_clk_pll_calc(hdptx->hdmi_cfg.tmds_char_rate, &rc)) {
+		if (!rk_hdptx_phy_clk_pll_calc(hdptx->hdmi_cfg.rate, &rc)) {
 			dev_err(hdptx->dev, "%s cannot find pll cfg for rate=%llu\n",
-				__func__, hdptx->hdmi_cfg.tmds_char_rate);
+				__func__, hdptx->hdmi_cfg.rate);
 			return -EINVAL;
 		}
 
@@ -986,7 +991,7 @@ static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 	}
 
 	dev_dbg(hdptx->dev, "%s rate=%llu mdiv=%u sdiv=%u sdm_en=%u k_sign=%u k=%u lc=%u\n",
-		__func__, hdptx->hdmi_cfg.tmds_char_rate, cfg->pms_mdiv, cfg->pms_sdiv + 1,
+		__func__, hdptx->hdmi_cfg.rate, cfg->pms_mdiv, cfg->pms_sdiv + 1,
 		cfg->sdm_en, cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
 
 	rk_hdptx_pre_power_up(hdptx);
@@ -1028,7 +1033,7 @@ static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 
 	ret = rk_hdptx_post_enable_pll(hdptx);
 	if (!ret)
-		hdptx->hw_rate = hdptx->hdmi_cfg.tmds_char_rate;
+		hdptx->hw_rate = hdptx->hdmi_cfg.rate;
 
 	return ret;
 }
@@ -1039,7 +1044,7 @@ static int rk_hdptx_tmds_ropll_mode_config(struct rk_hdptx_phy *hdptx)
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
 
-	if (hdptx->hdmi_cfg.tmds_char_rate > HDMI14_MAX_RATE) {
+	if (hdptx->hdmi_cfg.rate > HDMI14_MAX_RATE) {
 		/* For 1/40 bitrate clk */
 		rk_hdptx_multi_reg_write(hdptx, rk_hdptx_tmds_lntop_highbr_seq);
 	} else {
@@ -1410,19 +1415,19 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 	int ret, lane;
 
 	if (mode != PHY_MODE_DP) {
-		if (!hdptx->hdmi_cfg.tmds_char_rate) {
+		if (!hdptx->hdmi_cfg.rate) {
 			/*
 			 * FIXME: Temporary workaround to setup TMDS char rate
 			 * from the RK DW HDMI QP bridge driver.
 			 * Will be removed as soon the switch to the HDMI PHY
 			 * configuration API has been completed on both ends.
 			 */
-			hdptx->hdmi_cfg.tmds_char_rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
-			hdptx->hdmi_cfg.tmds_char_rate *= 100;
+			hdptx->hdmi_cfg.rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
+			hdptx->hdmi_cfg.rate *= 100;
 		}
 
 		dev_dbg(hdptx->dev, "%s rate=%llu bpc=%u\n", __func__,
-			hdptx->hdmi_cfg.tmds_char_rate, hdptx->hdmi_cfg.bpc);
+			hdptx->hdmi_cfg.rate, hdptx->hdmi_cfg.bpc);
 	}
 
 	ret = rk_hdptx_phy_consumer_get(hdptx);
@@ -1769,12 +1774,13 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 		if (ret) {
 			dev_err(hdptx->dev, "invalid hdmi params for phy configure\n");
 		} else {
-			hdptx->hdmi_cfg = opts->hdmi;
+			hdptx->hdmi_cfg.rate = opts->hdmi.tmds_char_rate;
+			hdptx->hdmi_cfg.bpc = opts->hdmi.bpc;
 			hdptx->restrict_rate_change = true;
 		}
 
 		dev_dbg(hdptx->dev, "%s rate=%llu bpc=%u\n", __func__,
-			hdptx->hdmi_cfg.tmds_char_rate, hdptx->hdmi_cfg.bpc);
+			hdptx->hdmi_cfg.rate, hdptx->hdmi_cfg.bpc);
 		return ret;
 	}
 
@@ -1956,7 +1962,7 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * To be dropped as soon as the RK DW HDMI QP bridge driver
 	 * switches to make use of phy_configure().
 	 */
-	if (!hdptx->restrict_rate_change && rate != hdptx->hdmi_cfg.tmds_char_rate) {
+	if (!hdptx->restrict_rate_change && rate != hdptx->hdmi_cfg.rate) {
 		struct phy_configure_opts_hdmi hdmi = {
 			.tmds_char_rate = rate,
 		};
@@ -1965,7 +1971,7 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (ret)
 			return ret;
 
-		hdptx->hdmi_cfg = hdmi;
+		hdptx->hdmi_cfg.rate = rate;
 	}
 
 	/*
@@ -1973,7 +1979,7 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * hence ensure rk_hdptx_phy_clk_set_rate() won't be invoked with
 	 * a different rate argument.
 	 */
-	return hdptx->hdmi_cfg.tmds_char_rate;
+	return hdptx->hdmi_cfg.rate;
 }
 
 static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1982,10 +1988,10 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
 	/* Revert any unlikely TMDS char rate change since round_rate() */
-	if (hdptx->hdmi_cfg.tmds_char_rate != rate) {
+	if (hdptx->hdmi_cfg.rate != rate) {
 		dev_warn(hdptx->dev, "Reverting unexpected rate change from %lu to %llu\n",
-			 rate, hdptx->hdmi_cfg.tmds_char_rate);
-		hdptx->hdmi_cfg.tmds_char_rate = rate;
+			 rate, hdptx->hdmi_cfg.rate);
+		hdptx->hdmi_cfg.rate = rate;
 	}
 
 	/*

-- 
2.50.0



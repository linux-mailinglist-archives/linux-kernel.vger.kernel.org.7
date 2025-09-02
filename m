Return-Path: <linux-kernel+bounces-797316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A70B40EB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6057E5E79D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C8535E4CF;
	Tue,  2 Sep 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QZ5V3Wqr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0B35AAB5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845903; cv=none; b=sWEJDdKI4kPa1lgrdQAfEkEOVrBskr5Gs1FherjpXqlz+7KWaHUSgJT3ObWZSxjp8hxYmegmUdB1n16TKISyDcJtfjr5rE5guyM9kJ3ROrAPmFEYy4x3Gs/5TBBSGaY/Pd6/GVCyvPJpTuFnSuH4d1IfIQioQ1K/1uoFC17WDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845903; c=relaxed/simple;
	bh=OnGaTNNIrYKdiTZa5++7KD4our7EsqapbDZunkTLn6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwyJDbChoJQNd7Q66DTuiJ4L0o+K/Gt5Lsjw23DgZ+OnzV5oqiBtmv9pX3pEv/VURMzxm4YpK6rPLU823/fF0W8JeDaARX6XjLKM3X2rMY0BHHksC4tbVocBGMlUEalguLI3wEqCRVSADkK3581ofAC+jPuLmesF6fEy7VADNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QZ5V3Wqr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756845900;
	bh=OnGaTNNIrYKdiTZa5++7KD4our7EsqapbDZunkTLn6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QZ5V3WqrzS8+ZQPEPFD8NEHAD17+UGtQ0jq817JdxSTEnV5T5+GgwvzBCr/EpCh/X
	 tUIkkBuf3I7V9Ce3DScA/2jtFNYmY3DajfX/DoFjsDCtsPI4eEgUbc2PyJnLYSpHew
	 PDy5tNGwBgYl/7t0aKlriOz5njYSkbhCGy9AnPzNuTcE6RVPH04rSBxmdg7vedLdxl
	 n0O1wDldiKyGRNPXA2wtPLfcby+ShqDK+Vdd/6yU6Sk7Oh+doks5+mSmdV4dsTcIsY
	 dYB+fDUVeLsZ8Q/J7Np7BvmNl/5zxx/7xd6iwp1PsF0pfBI9Q8fhBhgmeWDbT4GaZv
	 Jg9ksEIJGfU7A==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id DCA4A17E136C;
	Tue,  2 Sep 2025 22:44:59 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 23:44:44 +0300
Subject: [PATCH v4 09/11] phy: rockchip: samsung-hdptx: Switch to driver
 specific HDMI config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-phy-hdptx-frl-v4-9-7d69176373ce@collabora.com>
References: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
In-Reply-To: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
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
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 44 +++++++++++++----------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 7b1526c1ea3dfc26323d7b90631dc9fd2e3a7266..358625790d5ee3e2a3971abe22cc98e8e73e1066 100644
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
@@ -964,19 +969,19 @@ static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 	struct ropll_config rc = {0};
 	int i;
 
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
 
@@ -984,7 +989,7 @@ static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 	}
 
 	dev_dbg(hdptx->dev, "%s rate=%llu mdiv=%u sdiv=%u sdm_en=%u k_sign=%u k=%u lc=%u\n",
-		__func__, hdptx->hdmi_cfg.tmds_char_rate, cfg->pms_mdiv, cfg->pms_sdiv + 1,
+		__func__, hdptx->hdmi_cfg.rate, cfg->pms_mdiv, cfg->pms_sdiv + 1,
 		cfg->sdm_en, cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
 
 	rk_hdptx_pre_power_up(hdptx);
@@ -1033,7 +1038,7 @@ static int rk_hdptx_tmds_ropll_mode_config(struct rk_hdptx_phy *hdptx)
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
 
-	if (hdptx->hdmi_cfg.tmds_char_rate > HDMI14_MAX_RATE) {
+	if (hdptx->hdmi_cfg.rate > HDMI14_MAX_RATE) {
 		/* For 1/40 bitrate clk */
 		rk_hdptx_multi_reg_write(hdptx, rk_hdptx_tmds_lntop_highbr_seq);
 	} else {
@@ -1404,19 +1409,19 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
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
@@ -1763,12 +1768,13 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
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
 
@@ -1948,7 +1954,7 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * To be dropped as soon as the RK DW HDMI QP bridge driver
 	 * switches to make use of phy_configure().
 	 */
-	if (!hdptx->restrict_rate_change && rate != hdptx->hdmi_cfg.tmds_char_rate) {
+	if (!hdptx->restrict_rate_change && rate != hdptx->hdmi_cfg.rate) {
 		struct phy_configure_opts_hdmi hdmi = {
 			.tmds_char_rate = rate,
 		};
@@ -1957,7 +1963,7 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (ret)
 			return ret;
 
-		hdptx->hdmi_cfg = hdmi;
+		hdptx->hdmi_cfg.rate = rate;
 	}
 
 	/*
@@ -1965,7 +1971,7 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * hence ensure rk_hdptx_phy_clk_set_rate() won't be invoked with
 	 * a different rate argument.
 	 */
-	return DIV_ROUND_CLOSEST_ULL(hdptx->hdmi_cfg.tmds_char_rate * 8, hdptx->hdmi_cfg.bpc);
+	return DIV_ROUND_CLOSEST_ULL(hdptx->hdmi_cfg.rate * 8, hdptx->hdmi_cfg.bpc);
 }
 
 static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1975,10 +1981,10 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long long tmds_rate = DIV_ROUND_CLOSEST_ULL(rate * hdptx->hdmi_cfg.bpc, 8);
 
 	/* Revert any unlikely TMDS char rate change since round_rate() */
-	if (hdptx->hdmi_cfg.tmds_char_rate != tmds_rate) {
+	if (hdptx->hdmi_cfg.rate != tmds_rate) {
 		dev_warn(hdptx->dev, "Reverting unexpected rate change from %llu to %llu\n",
-			 tmds_rate, hdptx->hdmi_cfg.tmds_char_rate);
-		hdptx->hdmi_cfg.tmds_char_rate = tmds_rate;
+			 tmds_rate, hdptx->hdmi_cfg.rate);
+		hdptx->hdmi_cfg.rate = tmds_rate;
 	}
 
 	/*

-- 
2.51.0



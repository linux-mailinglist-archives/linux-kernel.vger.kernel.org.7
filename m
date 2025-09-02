Return-Path: <linux-kernel+bounces-797314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB05B40EB4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4809C1B64D94
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450935AAD6;
	Tue,  2 Sep 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EpcfYCy/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B03570DB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845901; cv=none; b=t9H+3UMn0SkOcCKjzqnOj1km7T++7TNq7HB1KqhjCrusj+STgRCXGmV24XENLQDiSYsdR2HotXFOwciSUoMuF2JSTRJ5r89jxjMsvQQi4PvXjMxwEL4JazSny13F1oxhG6/mvccg3RlVbr7/FbSUkQFqMbuJ5xoIpm9HyYrPrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845901; c=relaxed/simple;
	bh=EeHJeDSHpbH+IexE1yw0lzjuysLYioK+B9ubY4ryVHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4dAWh3KHKRY/JvYW1OOcvtqCX/BOK3lOOgytjsTS4WErVU90WWZrQsbZpnvb2GRtvP+oZyz8lU8RsbRqcDFsIFKn9qcRvU3dEgr7iCTpmxOLNfbU94GSEMG2fCNmAG1q74tXvoBjvzvAJhxfETtqma7rKsAf0NLbNeV47nalAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EpcfYCy/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756845898;
	bh=EeHJeDSHpbH+IexE1yw0lzjuysLYioK+B9ubY4ryVHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EpcfYCy/tQqZiTCo2bwQc4KdIcB1SddsV+5TI5s5kkB/LQIFoOBHM6bVPPTk3AR/X
	 prMuF/eTpWElI+brOSwefY/cjWhuEnCj42mbKWuCu9sMMKHw6HEoZGXbBJ6I//vxTq
	 BuNxYxoLolU6jpnDgyh6OQMZXat1LbeaUBswyKL1mXp4YRoRFdndqvRc1p6H8i11Mu
	 Hji56tHMkjgVYQhya9zY9hlDxZWdehCoP85IbPKjWu1lcrEwrjpMNfuabR7ZVC6qjx
	 BG5b8+f+BPE7Zob2VFvdWTLp+DF6MMj59Gvb4D6hBedA6RsSIOq48yKdtZHCuCfzfN
	 sPLbFFqjsBpog==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 38D8017E0579;
	Tue,  2 Sep 2025 22:44:58 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 23:44:42 +0300
Subject: [PATCH v4 07/11] phy: rockchip: samsung-hdptx: Compute clk rate
 from PLL config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-phy-hdptx-frl-v4-7-7d69176373ce@collabora.com>
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

Improve ->recalc_rate() callback of hdptx_phy_clk_ops to calculate the
initial clock rate based on the actual PHY PLL configuration as
retrieved from the related hardware registers.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 91 ++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 8e38adcb8f13325b87e27d6d809cfa1bfd91521c..2303c132172135d3a2678cbd5a1bac6a3e139c47 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1850,12 +1850,101 @@ static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)
 	rk_hdptx_phy_consumer_put(hdptx, true);
 }
 
+#define PLL_REF_CLK 24000000ULL
+
+static u64 rk_hdptx_phy_clk_calc_rate_from_pll_cfg(struct rk_hdptx_phy *hdptx)
+{
+	struct ropll_config ropll_hw;
+	u64 fout, sdm;
+	u32 mode, val;
+	int ret;
+
+	ret = regmap_read(hdptx->regmap, CMN_REG(0008), &mode);
+	if (ret)
+		return 0;
+
+	if (mode & LCPLL_LCVCO_MODE_EN_MASK)
+		return 0;
+
+	ret = regmap_read(hdptx->regmap, CMN_REG(0051), &val);
+	if (ret)
+		return 0;
+	ropll_hw.pms_mdiv = val;
+
+	ret = regmap_read(hdptx->regmap, CMN_REG(005E), &val);
+	if (ret)
+		return 0;
+	ropll_hw.sdm_en = val & ROPLL_SDM_EN_MASK;
+
+	ret = regmap_read(hdptx->regmap, CMN_REG(0064), &val);
+	if (ret)
+		return 0;
+	ropll_hw.sdm_num_sign = val & ROPLL_SDM_NUM_SIGN_RBR_MASK;
+
+	ret = regmap_read(hdptx->regmap, CMN_REG(0065), &val);
+	if (ret)
+		return 0;
+	ropll_hw.sdm_num = val;
+
+	ret = regmap_read(hdptx->regmap, CMN_REG(0060), &val);
+	if (ret)
+		return 0;
+	ropll_hw.sdm_deno = val;
+
+	ret = regmap_read(hdptx->regmap, CMN_REG(0069), &val);
+	if (ret)
+		return 0;
+	ropll_hw.sdc_n = (val & ROPLL_SDC_N_RBR_MASK) + 3;
+
+	ret = regmap_read(hdptx->regmap, CMN_REG(006c), &val);
+	if (ret)
+		return 0;
+	ropll_hw.sdc_num = val;
+
+	ret = regmap_read(hdptx->regmap, CMN_REG(0070), &val);
+	if (ret)
+		return 0;
+	ropll_hw.sdc_deno = val;
+
+	ret = regmap_read(hdptx->regmap, CMN_REG(0086), &val);
+	if (ret)
+		return 0;
+	ropll_hw.pms_sdiv = ((val & PLL_PCG_POSTDIV_SEL_MASK) >> 4) + 1;
+
+	fout = PLL_REF_CLK * ropll_hw.pms_mdiv;
+	if (ropll_hw.sdm_en) {
+		sdm = div_u64(PLL_REF_CLK * ropll_hw.sdc_deno *
+			      ropll_hw.pms_mdiv * ropll_hw.sdm_num,
+			      16 * ropll_hw.sdm_deno *
+			      (ropll_hw.sdc_deno * ropll_hw.sdc_n - ropll_hw.sdc_num));
+
+		if (ropll_hw.sdm_num_sign)
+			fout = fout - sdm;
+		else
+			fout = fout + sdm;
+	}
+
+	return div_u64(fout * 2, ropll_hw.pms_sdiv * 10);
+}
+
 static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
 						  unsigned long parent_rate)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
+	u32 status;
+	u64 rate;
+	int ret;
+
+	if (hdptx->hw_rate)
+		return hdptx->hw_rate;
+
+	ret = regmap_read(hdptx->grf, GRF_HDPTX_CON0, &status);
+	if (ret || !(status & HDPTX_I_PLL_EN))
+		return 0;
+
+	rate = rk_hdptx_phy_clk_calc_rate_from_pll_cfg(hdptx);
 
-	return hdptx->hw_rate;
+	return DIV_ROUND_CLOSEST_ULL(rate * 8, hdptx->hdmi_cfg.bpc);
 }
 
 static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.51.0



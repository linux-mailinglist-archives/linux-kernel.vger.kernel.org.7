Return-Path: <linux-kernel+bounces-774320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC8CB2B11C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907D13BD0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015333CE83;
	Mon, 18 Aug 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h+czZw8A"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B14338F2E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543572; cv=none; b=XWLbn1mQDAAHApAzFvsoiqQ2gZZ6rhe++YRWnmMMqYZPF/AGdy9GwqtMxFIad8E1oMVeWWCWVZ/pPjeZna0fsLn0bfVipXT0BC+Y1uV43JFX8n5Az9ZOXJfLXqaFwqUHOFw3VJF30++0ZiNsxGHI7OwV6/lAQ50xulB4GE4NtiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543572; c=relaxed/simple;
	bh=8PriDLdyw36f96US4S20mKBUaPRnAWhfKgLzqyYORbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rBN3ERPq6wUp00RZKEme4xqK3Q2syJeZPB6FLAcC+kRLx9XbiOZXXWrkFdl5vk+/NHkDIO8P/I56vMcHqpKcb6EyfOk3WtHsuQefxkR4UNDPKAQuBk1/65ntQstTjiF+q6bOJyNQnQqvzI6RZYiEIlMNu9hWj5IBCrWEu9CFlqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h+czZw8A; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755543568;
	bh=8PriDLdyw36f96US4S20mKBUaPRnAWhfKgLzqyYORbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h+czZw8AQLo3CgiCNmVkdb/dWP9Gc7oJyME28wWXfhzEu/l/CLU8oVwsQzD2yg4PB
	 lOM2j/saJpN8scuyosvuwhm19apY0MAPY5BFHggqNmIlTDL5ncaL/0rUFXTR2npfTp
	 wyq2hum4hOO8pNgbMy7d35Fe0d2NDmM4dj3gK4cu+j2kdsLrfFI44K5c8L2v0LL2LO
	 Ozy025MA8Kw9bVMe+L6LrrRnbOxgIM72tM24PKpeyTmAyuHF7lGo6n8Bn653COpWlf
	 TxIDErY/sdAUV7KgSwkw+oYqmz2RpSXbsOZn7hY03VXUd1lx8xPenHjGHI+F20oa9k
	 ItaC76h8vr//Q==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 1F05817E1322;
	Mon, 18 Aug 2025 20:59:28 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 18 Aug 2025 21:59:10 +0300
Subject: [PATCH v3 10/14] phy: rockchip: samsung-hdptx: Compute clk rate
 from PLL config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-phy-hdptx-frl-v3-10-c79997d8bb2b@collabora.com>
References: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
In-Reply-To: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
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
index 699b86732b8d7d77b3f9ec3a7a8c801392b796f6..6e2443f78968948b84e4261e33761fe0d189553b 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1851,12 +1851,101 @@ static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)
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
2.50.1



Return-Path: <linux-kernel+bounces-699480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE2AE5A94
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 05:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDD27A444A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 03:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3401DED5D;
	Tue, 24 Jun 2025 03:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BIaYE+kG"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224518CC15;
	Tue, 24 Jun 2025 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750736350; cv=none; b=loMpoUKH06ccByQOBgv30wjTgHf/uJODd++nvj8XDikQgUHwfL7efE1cH6m6vLiaRRZ3+PtNpwR33TvjVEJ819Y0mFgQFKkjKBX9cBHX7Tq0q1ROZadGVPly7ZkQS6cDEDrDuiAf35BX87fFwD6kpLhraUQCBevfbx8Te+ACaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750736350; c=relaxed/simple;
	bh=kk8aEKh2fJd3e1Ek81l+3ODfhDNcSe/kwx/ujxWASc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9O+hP1j2jlmcGiK6LR/uj1JPday2cupNUIcDFp0II5vydTLyQem3FEYxcl2IdkBUKMxkrbLj8O96i/TMG4AdxU/nnw77e8Ut2KbiUFBza3fDdvzJCKIPOYFarAuZyU1tuwut4QoBocmpS0UbKcR0Og19O0wBPbIcAsfZAPyNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BIaYE+kG; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1E4C923023;
	Tue, 24 Jun 2025 05:39:06 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qbcNZQnYY21; Tue, 24 Jun 2025 05:39:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750736340; bh=kk8aEKh2fJd3e1Ek81l+3ODfhDNcSe/kwx/ujxWASc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BIaYE+kGIxj0lDfQiADrR2QlKCoP8DD0bjIW0xSE+Qc4UIXKvuQ29txvDFrzks/R/
	 GKaE3LswOIZfgy/epf5NRGa+BbeSzDV2oR2PVVJFUYQs0lLlv6me8poFItyh1TfxsL
	 drN1OOYBKkdPeisV/9oFS/I3rERK/atQIL/YskcXSF/Aj+Kvhu4dj6kX9MyGYD+c42
	 5E2+ulbtBUH70CWv6Fm0b2itola2EKnI1wQ0S+CBv45njBfSkxNY8+n/AAyaXy8nPG
	 SuJtB7LdHi71kPJ2VYrfFl6J0f2yMMlOgfCBf7cSA4iyqUr3FRX6hW3u9D592ieete
	 O0T+7AFy9Rnqg==
From: Yao Zi <ziyao@disroot.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 4/6] phy: rockchip: naneng-combphy: Add SoC prefix to register definitions
Date: Tue, 24 Jun 2025 03:37:31 +0000
Message-ID: <20250624033733.50197-5-ziyao@disroot.org>
In-Reply-To: <20250624033733.50197-1-ziyao@disroot.org>
References: <20250624033733.50197-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All supported variants of naneng-combphy follow a register layout
similar to the RK3568 variant with some exceptions of SoC-specific
registers.

Add RK3568 prefix for the common set of registers and the corresponding
SoC prefix for SoC-specific registers, making usage of definitions clear
and preparing for future COMBPHY variants with a different register
layout.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../rockchip/phy-rockchip-naneng-combphy.c    | 560 +++++++++---------
 1 file changed, 288 insertions(+), 272 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index ce91fb1d5167..1d1c7723584b 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -21,78 +21,80 @@
 #define REF_CLOCK_100MHz		(100 * HZ_PER_MHZ)
 
 /* COMBO PHY REG */
-#define PHYREG6				0x14
-#define PHYREG6_PLL_DIV_MASK		GENMASK(7, 6)
-#define PHYREG6_PLL_DIV_SHIFT		6
-#define PHYREG6_PLL_DIV_2		1
-
-#define PHYREG7				0x18
-#define PHYREG7_TX_RTERM_MASK		GENMASK(7, 4)
-#define PHYREG7_TX_RTERM_SHIFT		4
-#define PHYREG7_TX_RTERM_50OHM		8
-#define PHYREG7_RX_RTERM_MASK		GENMASK(3, 0)
-#define PHYREG7_RX_RTERM_SHIFT		0
-#define PHYREG7_RX_RTERM_44OHM		15
-
-#define PHYREG8				0x1C
-#define PHYREG8_SSC_EN			BIT(4)
-
-#define PHYREG10			0x24
-#define PHYREG10_SSC_PCM_MASK		GENMASK(3, 0)
-#define PHYREG10_SSC_PCM_3500PPM	7
-
-#define PHYREG11			0x28
-#define PHYREG11_SU_TRIM_0_7		0xF0
-
-#define PHYREG12			0x2C
-#define PHYREG12_PLL_LPF_ADJ_VALUE	4
-
-#define PHYREG13			0x30
-#define PHYREG13_RESISTER_MASK		GENMASK(5, 4)
-#define PHYREG13_RESISTER_SHIFT		0x4
-#define PHYREG13_RESISTER_HIGH_Z	3
-#define PHYREG13_CKRCV_AMP0		BIT(7)
-
-#define PHYREG14			0x34
-#define PHYREG14_CKRCV_AMP1		BIT(0)
-
-#define PHYREG15			0x38
-#define PHYREG15_CTLE_EN		BIT(0)
-#define PHYREG15_SSC_CNT_MASK		GENMASK(7, 6)
-#define PHYREG15_SSC_CNT_SHIFT		6
-#define PHYREG15_SSC_CNT_VALUE		1
-
-#define PHYREG16			0x3C
-#define PHYREG16_SSC_CNT_VALUE		0x5f
-
-#define PHYREG17			0x40
-
-#define PHYREG18			0x44
-#define PHYREG18_PLL_LOOP		0x32
-
-#define PHYREG21			0x50
-#define PHYREG21_RX_SQUELCH_VAL		0x0D
-
-#define PHYREG27			0x6C
-#define PHYREG27_RX_TRIM_RK3588		0x4C
-
-#define PHYREG30			0x74
-
-#define PHYREG32			0x7C
-#define PHYREG32_SSC_MASK		GENMASK(7, 4)
-#define PHYREG32_SSC_DIR_MASK		GENMASK(5, 4)
-#define PHYREG32_SSC_DIR_SHIFT		4
-#define PHYREG32_SSC_UPWARD		0
-#define PHYREG32_SSC_DOWNWARD		1
-#define PHYREG32_SSC_OFFSET_MASK	GENMASK(7, 6)
-#define PHYREG32_SSC_OFFSET_SHIFT	6
-#define PHYREG32_SSC_OFFSET_500PPM	1
-
-#define PHYREG33			0x80
-#define PHYREG33_PLL_KVCO_MASK		GENMASK(4, 2)
-#define PHYREG33_PLL_KVCO_SHIFT		2
-#define PHYREG33_PLL_KVCO_VALUE		2
-#define PHYREG33_PLL_KVCO_VALUE_RK3576	4
+#define RK3568_PHYREG6				0x14
+#define RK3568_PHYREG6_PLL_DIV_MASK		GENMASK(7, 6)
+#define RK3568_PHYREG6_PLL_DIV_SHIFT		6
+#define RK3568_PHYREG6_PLL_DIV_2		1
+
+#define RK3568_PHYREG7				0x18
+#define RK3568_PHYREG7_TX_RTERM_MASK		GENMASK(7, 4)
+#define RK3568_PHYREG7_TX_RTERM_SHIFT		4
+#define RK3568_PHYREG7_TX_RTERM_50OHM		8
+#define RK3568_PHYREG7_RX_RTERM_MASK		GENMASK(3, 0)
+#define RK3568_PHYREG7_RX_RTERM_SHIFT		0
+#define RK3568_PHYREG7_RX_RTERM_44OHM		15
+
+#define RK3568_PHYREG8				0x1C
+#define RK3568_PHYREG8_SSC_EN			BIT(4)
+
+#define RK3568_PHYREG11				0x28
+#define RK3568_PHYREG11_SU_TRIM_0_7		0xF0
+
+#define RK3568_PHYREG12				0x2C
+#define RK3568_PHYREG12_PLL_LPF_ADJ_VALUE	4
+
+#define RK3568_PHYREG13				0x30
+#define RK3568_PHYREG13_RESISTER_MASK		GENMASK(5, 4)
+#define RK3568_PHYREG13_RESISTER_SHIFT		0x4
+#define RK3568_PHYREG13_RESISTER_HIGH_Z		3
+#define RK3568_PHYREG13_CKRCV_AMP0		BIT(7)
+
+#define RK3568_PHYREG14				0x34
+#define RK3568_PHYREG14_CKRCV_AMP1		BIT(0)
+
+#define RK3568_PHYREG15				0x38
+#define RK3568_PHYREG15_CTLE_EN			BIT(0)
+#define RK3568_PHYREG15_SSC_CNT_MASK		GENMASK(7, 6)
+#define RK3568_PHYREG15_SSC_CNT_SHIFT		6
+#define RK3568_PHYREG15_SSC_CNT_VALUE		1
+
+#define RK3568_PHYREG16				0x3C
+#define RK3568_PHYREG16_SSC_CNT_VALUE		0x5f
+
+#define RK3568_PHYREG18				0x44
+#define RK3568_PHYREG18_PLL_LOOP		0x32
+
+#define RK3568_PHYREG32				0x7C
+#define RK3568_PHYREG32_SSC_MASK		GENMASK(7, 4)
+#define RK3568_PHYREG32_SSC_DIR_MASK		GENMASK(5, 4)
+#define RK3568_PHYREG32_SSC_DIR_SHIFT		4
+#define RK3568_PHYREG32_SSC_UPWARD		0
+#define RK3568_PHYREG32_SSC_DOWNWARD		1
+#define RK3568_PHYREG32_SSC_OFFSET_MASK	GENMASK(7, 6)
+#define RK3568_PHYREG32_SSC_OFFSET_SHIFT	6
+#define RK3568_PHYREG32_SSC_OFFSET_500PPM	1
+
+#define RK3568_PHYREG33				0x80
+#define RK3568_PHYREG33_PLL_KVCO_MASK		GENMASK(4, 2)
+#define RK3568_PHYREG33_PLL_KVCO_SHIFT		2
+#define RK3568_PHYREG33_PLL_KVCO_VALUE		2
+#define RK3576_PHYREG33_PLL_KVCO_VALUE		4
+
+/* RK3588 COMBO PHY registers */
+#define RK3588_PHYREG27				0x6C
+#define RK3588_PHYREG27_RX_TRIM			0x4C
+
+/* RK3576 COMBO PHY registers */
+#define RK3576_PHYREG10				0x24
+#define RK3576_PHYREG10_SSC_PCM_MASK		GENMASK(3, 0)
+#define RK3576_PHYREG10_SSC_PCM_3500PPM		7
+
+#define RK3576_PHYREG17				0x40
+
+#define RK3576_PHYREG21				0x50
+#define RK3576_PHYREG21_RX_SQUELCH_VAL		0x0D
+
+#define RK3576_PHYREG30				0x74
 
 struct rockchip_combphy_priv;
 
@@ -405,9 +407,8 @@ static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
 	switch (priv->type) {
 	case PHY_TYPE_PCIE:
 		/* Set SSC downward spread spectrum */
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
-					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
-					 PHYREG32);
+		val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
@@ -416,29 +417,30 @@ static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
 		break;
 	case PHY_TYPE_USB3:
 		/* Set SSC downward spread spectrum */
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
-					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
-					 PHYREG32);
+		val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val,
+					 RK3568_PHYREG32);
 
 		/* Enable adaptive CTLE for USB3.0 Rx */
-		rockchip_combphy_updatel(priv, PHYREG15_CTLE_EN,
-					 PHYREG15_CTLE_EN, PHYREG15);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG15_CTLE_EN,
+					 RK3568_PHYREG15_CTLE_EN, RK3568_PHYREG15);
 
 		/* Set PLL KVCO fine tuning signals */
-		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK, BIT(3), PHYREG33);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+					 BIT(3), RK3568_PHYREG33);
 
 		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
-		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+		writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
 		/* Set PLL input clock divider 1/2 */
-		val = FIELD_PREP(PHYREG6_PLL_DIV_MASK, PHYREG6_PLL_DIV_2);
-		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK, val, PHYREG6);
+		val = FIELD_PREP(RK3568_PHYREG6_PLL_DIV_MASK, RK3568_PHYREG6_PLL_DIV_2);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK, val, RK3568_PHYREG6);
 
 		/* Set PLL loop divider */
-		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
+		writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
 
 		/* Set PLL KVCO to min and set PLL charge pump current to max */
-		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+		writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_usb, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
@@ -456,11 +458,12 @@ static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
 	case REF_CLOCK_24MHz:
 		if (priv->type == PHY_TYPE_USB3) {
 			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
-			val = FIELD_PREP(PHYREG15_SSC_CNT_MASK, PHYREG15_SSC_CNT_VALUE);
-			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
-						 val, PHYREG15);
+			val = FIELD_PREP(RK3568_PHYREG15_SSC_CNT_MASK,
+					 RK3568_PHYREG15_SSC_CNT_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG15_SSC_CNT_MASK,
+						 val, RK3568_PHYREG15);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 		}
 		break;
 	case REF_CLOCK_25MHz:
@@ -470,19 +473,20 @@ static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
 		if (priv->type == PHY_TYPE_PCIE) {
 			/* PLL KVCO tuning fine */
-			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE);
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = FIELD_PREP(RK3568_PHYREG33_PLL_KVCO_MASK,
+					 RK3568_PHYREG33_PLL_KVCO_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Enable controlling random jitter, aka RMJ */
-			writel(0x4, priv->mmio + PHYREG12);
+			writel(0x4, priv->mmio + RK3568_PHYREG12);
 
-			val = PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
-						 val, PHYREG6);
+			val = RK3568_PHYREG6_PLL_DIV_2 << RK3568_PHYREG6_PLL_DIV_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK,
+						 val, RK3568_PHYREG6);
 
-			writel(0x32, priv->mmio + PHYREG18);
-			writel(0xf0, priv->mmio + PHYREG11);
+			writel(0x32, priv->mmio + RK3568_PHYREG18);
+			writel(0xf0, priv->mmio + RK3568_PHYREG11);
 		}
 		break;
 	default:
@@ -493,20 +497,21 @@ static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
 	if (priv->ext_refclk) {
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
-			val = PHYREG13_RESISTER_HIGH_Z << PHYREG13_RESISTER_SHIFT;
-			val |= PHYREG13_CKRCV_AMP0;
-			rockchip_combphy_updatel(priv, PHYREG13_RESISTER_MASK, val, PHYREG13);
-
-			val = readl(priv->mmio + PHYREG14);
-			val |= PHYREG14_CKRCV_AMP1;
-			writel(val, priv->mmio + PHYREG14);
+			val = RK3568_PHYREG13_RESISTER_HIGH_Z << RK3568_PHYREG13_RESISTER_SHIFT;
+			val |= RK3568_PHYREG13_CKRCV_AMP0;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG13_RESISTER_MASK, val,
+						 RK3568_PHYREG13);
+
+			val = readl(priv->mmio + RK3568_PHYREG14);
+			val |= RK3568_PHYREG14_CKRCV_AMP1;
+			writel(val, priv->mmio + RK3568_PHYREG14);
 		}
 	}
 
 	if (priv->enable_ssc) {
-		val = readl(priv->mmio + PHYREG8);
-		val |= PHYREG8_SSC_EN;
-		writel(val, priv->mmio + PHYREG8);
+		val = readl(priv->mmio + RK3568_PHYREG8);
+		val |= RK3568_PHYREG8_SSC_EN;
+		writel(val, priv->mmio + RK3568_PHYREG8);
 	}
 
 	return 0;
@@ -553,9 +558,9 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 	switch (priv->type) {
 	case PHY_TYPE_PCIE:
 		/* Set SSC downward spread spectrum. */
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
-					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
-					 PHYREG32);
+		val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
@@ -565,30 +570,28 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 
 	case PHY_TYPE_USB3:
 		/* Set SSC downward spread spectrum. */
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
-					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
-					 PHYREG32);
+		val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT,
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		/* Enable adaptive CTLE for USB3.0 Rx. */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 
 		/* Set PLL KVCO fine tuning signals. */
-		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-					 PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT,
-					 PHYREG33);
+		val = RK3568_PHYREG33_PLL_KVCO_VALUE << RK3568_PHYREG33_PLL_KVCO_SHIFT;
+		rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK, val, RK3568_PHYREG33);
 
 		/* Enable controlling random jitter. */
-		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+		writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
 		/* Set PLL input clock divider 1/2. */
-		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
-					 PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT,
-					 PHYREG6);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK,
+					 RK3568_PHYREG6_PLL_DIV_2 << RK3568_PHYREG6_PLL_DIV_SHIFT,
+					 RK3568_PHYREG6);
 
-		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
-		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+		writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
+		writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_usb, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
@@ -598,16 +601,16 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 
 	case PHY_TYPE_SATA:
 		/* Enable adaptive CTLE for SATA Rx. */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 		/*
 		 * Set tx_rterm=50ohm and rx_rterm=44ohm for SATA.
 		 * 0: 60ohm, 8: 50ohm 15: 44ohm (by step abort 1ohm)
 		 */
-		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
-		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
-		writel(val, priv->mmio + PHYREG7);
+		val = RK3568_PHYREG7_TX_RTERM_50OHM << RK3568_PHYREG7_TX_RTERM_SHIFT;
+		val |= RK3568_PHYREG7_RX_RTERM_44OHM << RK3568_PHYREG7_RX_RTERM_SHIFT;
+		writel(val, priv->mmio + RK3568_PHYREG7);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
@@ -642,11 +645,11 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 	case REF_CLOCK_24MHz:
 		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
 			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz. */
-			val = PHYREG15_SSC_CNT_VALUE << PHYREG15_SSC_CNT_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
-						 val, PHYREG15);
+			val = RK3568_PHYREG15_SSC_CNT_VALUE << RK3568_PHYREG15_SSC_CNT_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG15_SSC_CNT_MASK,
+						 val, RK3568_PHYREG15);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 		}
 		break;
 
@@ -658,24 +661,26 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
 		if (priv->type == PHY_TYPE_PCIE) {
 			/* PLL KVCO  fine tuning. */
-			val = PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = RK3568_PHYREG33_PLL_KVCO_VALUE << RK3568_PHYREG33_PLL_KVCO_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Enable controlling random jitter. */
-			writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+			writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
-			val = PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
-						 val, PHYREG6);
+			val = RK3568_PHYREG6_PLL_DIV_2 << RK3568_PHYREG6_PLL_DIV_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK,
+						 val, RK3568_PHYREG6);
 
-			writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
-			writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+			writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
+			writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 		} else if (priv->type == PHY_TYPE_SATA) {
 			/* downward spread spectrum +500ppm */
-			val = PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT;
-			val |= PHYREG32_SSC_OFFSET_500PPM << PHYREG32_SSC_OFFSET_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+			val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+			val |= RK3568_PHYREG32_SSC_OFFSET_500PPM <<
+			       RK3568_PHYREG32_SSC_OFFSET_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val,
+						 RK3568_PHYREG32);
 		}
 		break;
 
@@ -687,20 +692,21 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 	if (priv->ext_refclk) {
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
-			val = PHYREG13_RESISTER_HIGH_Z << PHYREG13_RESISTER_SHIFT;
-			val |= PHYREG13_CKRCV_AMP0;
-			rockchip_combphy_updatel(priv, PHYREG13_RESISTER_MASK, val, PHYREG13);
-
-			val = readl(priv->mmio + PHYREG14);
-			val |= PHYREG14_CKRCV_AMP1;
-			writel(val, priv->mmio + PHYREG14);
+			val = RK3568_PHYREG13_RESISTER_HIGH_Z << RK3568_PHYREG13_RESISTER_SHIFT;
+			val |= RK3568_PHYREG13_CKRCV_AMP0;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG13_RESISTER_MASK, val,
+						 RK3568_PHYREG13);
+
+			val = readl(priv->mmio + RK3568_PHYREG14);
+			val |= RK3568_PHYREG14_CKRCV_AMP1;
+			writel(val, priv->mmio + RK3568_PHYREG14);
 		}
 	}
 
 	if (priv->enable_ssc) {
-		val = readl(priv->mmio + PHYREG8);
-		val |= PHYREG8_SSC_EN;
-		writel(val, priv->mmio + PHYREG8);
+		val = readl(priv->mmio + RK3568_PHYREG8);
+		val |= RK3568_PHYREG8_SSC_EN;
+		writel(val, priv->mmio + RK3568_PHYREG8);
 	}
 
 	return 0;
@@ -759,8 +765,8 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 	switch (priv->type) {
 	case PHY_TYPE_PCIE:
 		/* Set SSC downward spread spectrum */
-		val = FIELD_PREP(PHYREG32_SSC_MASK, PHYREG32_SSC_DOWNWARD);
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+		val = FIELD_PREP(RK3568_PHYREG32_SSC_MASK, RK3568_PHYREG32_SSC_DOWNWARD);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
@@ -770,32 +776,33 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 
 	case PHY_TYPE_USB3:
 		/* Set SSC downward spread spectrum */
-		val = FIELD_PREP(PHYREG32_SSC_MASK, PHYREG32_SSC_DOWNWARD);
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+		val = FIELD_PREP(RK3568_PHYREG32_SSC_MASK, RK3568_PHYREG32_SSC_DOWNWARD);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		/* Enable adaptive CTLE for USB3.0 Rx */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 
 		/* Set PLL KVCO fine tuning signals */
-		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK, BIT(3), PHYREG33);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK, BIT(3),
+					 RK3568_PHYREG33);
 
 		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
-		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+		writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
 		/* Set PLL input clock divider 1/2 */
-		val = FIELD_PREP(PHYREG6_PLL_DIV_MASK, PHYREG6_PLL_DIV_2);
-		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK, val, PHYREG6);
+		val = FIELD_PREP(RK3568_PHYREG6_PLL_DIV_MASK, RK3568_PHYREG6_PLL_DIV_2);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK, val, RK3568_PHYREG6);
 
 		/* Set PLL loop divider */
-		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
+		writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
 
 		/* Set PLL KVCO to min and set PLL charge pump current to max */
-		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+		writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 
 		/* Set Rx squelch input filler bandwidth */
-		writel(PHYREG21_RX_SQUELCH_VAL, priv->mmio + PHYREG21);
+		writel(RK3576_PHYREG21_RX_SQUELCH_VAL, priv->mmio + RK3576_PHYREG21);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
@@ -804,14 +811,14 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 
 	case PHY_TYPE_SATA:
 		/* Enable adaptive CTLE for SATA Rx */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 
 		/* Set tx_rterm = 50 ohm and rx_rterm = 43.5 ohm */
-		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
-		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
-		writel(val, priv->mmio + PHYREG7);
+		val = RK3568_PHYREG7_TX_RTERM_50OHM << RK3568_PHYREG7_TX_RTERM_SHIFT;
+		val |= RK3568_PHYREG7_RX_RTERM_44OHM << RK3568_PHYREG7_RX_RTERM_SHIFT;
+		writel(val, priv->mmio + RK3568_PHYREG7);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
@@ -833,19 +840,21 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_24m, true);
 		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
 			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
-			val = FIELD_PREP(PHYREG15_SSC_CNT_MASK, PHYREG15_SSC_CNT_VALUE);
-			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
-						 val, PHYREG15);
+			val = FIELD_PREP(RK3568_PHYREG15_SSC_CNT_MASK,
+					 RK3568_PHYREG15_SSC_CNT_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG15_SSC_CNT_MASK,
+						 val, RK3568_PHYREG15);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 		} else if (priv->type == PHY_TYPE_PCIE) {
 			/* PLL KVCO tuning fine */
-			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = FIELD_PREP(RK3568_PHYREG33_PLL_KVCO_MASK,
+					 RK3576_PHYREG33_PLL_KVCO_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Set up rx_pck invert and rx msb to disable */
-			writel(0x00, priv->mmio + PHYREG27);
+			writel(0x00, priv->mmio + RK3588_PHYREG27);
 
 			/*
 			 * Set up SU adjust signal:
@@ -853,11 +862,11 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 			 * su_trim[15:8],  PLL LPF R1 adujst bits[9:7]=3'b011
 			 * su_trim[31:24], CKDRV adjust
 			 */
-			writel(0x90, priv->mmio + PHYREG11);
-			writel(0x02, priv->mmio + PHYREG12);
-			writel(0x57, priv->mmio + PHYREG14);
+			writel(0x90, priv->mmio + RK3568_PHYREG11);
+			writel(0x02, priv->mmio + RK3568_PHYREG12);
+			writel(0x57, priv->mmio + RK3568_PHYREG14);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 		}
 		break;
 
@@ -869,15 +878,16 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
 		if (priv->type == PHY_TYPE_PCIE) {
 			/* gate_tx_pck_sel length select work for L1SS */
-			writel(0xc0, priv->mmio + PHYREG30);
+			writel(0xc0, priv->mmio + RK3576_PHYREG30);
 
 			/* PLL KVCO tuning fine */
-			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = FIELD_PREP(RK3568_PHYREG33_PLL_KVCO_MASK,
+					 RK3576_PHYREG33_PLL_KVCO_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
-			writel(0x4c, priv->mmio + PHYREG27);
+			writel(0x4c, priv->mmio + RK3588_PHYREG27);
 
 			/*
 			 * Set up SU adjust signal:
@@ -887,20 +897,23 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 			 * su_trim[23:16], CKRCV adjust
 			 * su_trim[31:24], CKDRV adjust
 			 */
-			writel(0x90, priv->mmio + PHYREG11);
-			writel(0x43, priv->mmio + PHYREG12);
-			writel(0x88, priv->mmio + PHYREG13);
-			writel(0x56, priv->mmio + PHYREG14);
+			writel(0x90, priv->mmio + RK3568_PHYREG11);
+			writel(0x43, priv->mmio + RK3568_PHYREG12);
+			writel(0x88, priv->mmio + RK3568_PHYREG13);
+			writel(0x56, priv->mmio + RK3568_PHYREG14);
 		} else if (priv->type == PHY_TYPE_SATA) {
 			/* downward spread spectrum +500ppm */
-			val = FIELD_PREP(PHYREG32_SSC_DIR_MASK, PHYREG32_SSC_DOWNWARD);
-			val |= FIELD_PREP(PHYREG32_SSC_OFFSET_MASK, PHYREG32_SSC_OFFSET_500PPM);
-			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+			val = FIELD_PREP(RK3568_PHYREG32_SSC_DIR_MASK,
+					 RK3568_PHYREG32_SSC_DOWNWARD);
+			val |= FIELD_PREP(RK3568_PHYREG32_SSC_OFFSET_MASK,
+					  RK3568_PHYREG32_SSC_OFFSET_500PPM);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val,
+						 RK3568_PHYREG32);
 
 			/* ssc ppm adjust to 3500ppm */
-			rockchip_combphy_updatel(priv, PHYREG10_SSC_PCM_MASK,
-						 PHYREG10_SSC_PCM_3500PPM,
-						 PHYREG10);
+			rockchip_combphy_updatel(priv, RK3576_PHYREG10_SSC_PCM_MASK,
+						 RK3576_PHYREG10_SSC_PCM_3500PPM,
+						 RK3576_PHYREG10);
 		}
 		break;
 
@@ -912,12 +925,13 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 	if (priv->ext_refclk) {
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
-			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = FIELD_PREP(RK3568_PHYREG33_PLL_KVCO_MASK,
+					 RK3576_PHYREG33_PLL_KVCO_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Set up rx_trim: PLL LPF C1 85pf R1 2.5kohm */
-			writel(0x0c, priv->mmio + PHYREG27);
+			writel(0x0c, priv->mmio + RK3588_PHYREG27);
 
 			/*
 			 * Set up SU adjust signal:
@@ -927,25 +941,25 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 			 * su_trim[23:16], CKRCV adjust
 			 * su_trim[31:24], CKDRV adjust
 			 */
-			writel(0x90, priv->mmio + PHYREG11);
-			writel(0x43, priv->mmio + PHYREG12);
-			writel(0x88, priv->mmio + PHYREG13);
-			writel(0x56, priv->mmio + PHYREG14);
+			writel(0x90, priv->mmio + RK3568_PHYREG11);
+			writel(0x43, priv->mmio + RK3568_PHYREG12);
+			writel(0x88, priv->mmio + RK3568_PHYREG13);
+			writel(0x56, priv->mmio + RK3568_PHYREG14);
 		}
 	}
 
 	if (priv->enable_ssc) {
-		val = readl(priv->mmio + PHYREG8);
-		val |= PHYREG8_SSC_EN;
-		writel(val, priv->mmio + PHYREG8);
+		val = readl(priv->mmio + RK3568_PHYREG8);
+		val |= RK3568_PHYREG8_SSC_EN;
+		writel(val, priv->mmio + RK3568_PHYREG8);
 
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_24MHz) {
 			/* Set PLL loop divider */
-			writel(0x00, priv->mmio + PHYREG17);
-			writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
+			writel(0x00, priv->mmio + RK3576_PHYREG17);
+			writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
 
 			/* Set up rx_pck invert and rx msb to disable */
-			writel(0x00, priv->mmio + PHYREG27);
+			writel(0x00, priv->mmio + RK3588_PHYREG27);
 
 			/*
 			 * Set up SU adjust signal:
@@ -954,16 +968,17 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 			 * su_trim[23:16], CKRCV adjust
 			 * su_trim[31:24], CKDRV adjust
 			 */
-			writel(0x90, priv->mmio + PHYREG11);
-			writel(0x02, priv->mmio + PHYREG12);
-			writel(0x08, priv->mmio + PHYREG13);
-			writel(0x57, priv->mmio + PHYREG14);
-			writel(0x40, priv->mmio + PHYREG15);
+			writel(0x90, priv->mmio + RK3568_PHYREG11);
+			writel(0x02, priv->mmio + RK3568_PHYREG12);
+			writel(0x08, priv->mmio + RK3568_PHYREG13);
+			writel(0x57, priv->mmio + RK3568_PHYREG14);
+			writel(0x40, priv->mmio + RK3568_PHYREG15);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 
-			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
-			writel(val, priv->mmio + PHYREG33);
+			val = FIELD_PREP(RK3568_PHYREG33_PLL_KVCO_MASK,
+					 RK3576_PHYREG33_PLL_KVCO_VALUE);
+			writel(val, priv->mmio + RK3568_PHYREG33);
 		}
 	}
 
@@ -1033,30 +1048,28 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 		break;
 	case PHY_TYPE_USB3:
 		/* Set SSC downward spread spectrum */
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
-					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
-					 PHYREG32);
+		val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		/* Enable adaptive CTLE for USB3.0 Rx. */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 
 		/* Set PLL KVCO fine tuning signals. */
-		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-					 PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT,
-					 PHYREG33);
+		val = RK3568_PHYREG33_PLL_KVCO_VALUE << RK3568_PHYREG33_PLL_KVCO_SHIFT,
+		rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK, val, RK3568_PHYREG33);
 
 		/* Enable controlling random jitter. */
-		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+		writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
 		/* Set PLL input clock divider 1/2. */
-		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
-					 PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT,
-					 PHYREG6);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK,
+					 RK3568_PHYREG6_PLL_DIV_2 << RK3568_PHYREG6_PLL_DIV_SHIFT,
+					 RK3568_PHYREG6);
 
-		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
-		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+		writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
+		writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
@@ -1064,16 +1077,16 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 		break;
 	case PHY_TYPE_SATA:
 		/* Enable adaptive CTLE for SATA Rx. */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 		/*
 		 * Set tx_rterm=50ohm and rx_rterm=44ohm for SATA.
 		 * 0: 60ohm, 8: 50ohm 15: 44ohm (by step abort 1ohm)
 		 */
-		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
-		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
-		writel(val, priv->mmio + PHYREG7);
+		val = RK3568_PHYREG7_TX_RTERM_50OHM << RK3568_PHYREG7_TX_RTERM_SHIFT;
+		val |= RK3568_PHYREG7_RX_RTERM_44OHM << RK3568_PHYREG7_RX_RTERM_SHIFT;
+		writel(val, priv->mmio + RK3568_PHYREG7);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
@@ -1095,11 +1108,11 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 	case REF_CLOCK_24MHz:
 		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
 			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz. */
-			val = PHYREG15_SSC_CNT_VALUE << PHYREG15_SSC_CNT_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
-						 val, PHYREG15);
+			val = RK3568_PHYREG15_SSC_CNT_VALUE << RK3568_PHYREG15_SSC_CNT_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG15_SSC_CNT_MASK,
+						 val, RK3568_PHYREG15);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 		}
 		break;
 
@@ -1110,23 +1123,25 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
 		if (priv->type == PHY_TYPE_PCIE) {
 			/* PLL KVCO fine tuning. */
-			val = 4 << PHYREG33_PLL_KVCO_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = 4 << RK3568_PHYREG33_PLL_KVCO_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Enable controlling random jitter. */
-			writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+			writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
 			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
-			writel(PHYREG27_RX_TRIM_RK3588, priv->mmio + PHYREG27);
+			writel(RK3588_PHYREG27_RX_TRIM, priv->mmio + RK3588_PHYREG27);
 
 			/* Set up su_trim:  */
-			writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+			writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 		} else if (priv->type == PHY_TYPE_SATA) {
 			/* downward spread spectrum +500ppm */
-			val = PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT;
-			val |= PHYREG32_SSC_OFFSET_500PPM << PHYREG32_SSC_OFFSET_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+			val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+			val |= RK3568_PHYREG32_SSC_OFFSET_500PPM <<
+			       RK3568_PHYREG32_SSC_OFFSET_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val,
+						 RK3568_PHYREG32);
 		}
 		break;
 	default:
@@ -1137,20 +1152,21 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 	if (priv->ext_refclk) {
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
-			val = PHYREG13_RESISTER_HIGH_Z << PHYREG13_RESISTER_SHIFT;
-			val |= PHYREG13_CKRCV_AMP0;
-			rockchip_combphy_updatel(priv, PHYREG13_RESISTER_MASK, val, PHYREG13);
-
-			val = readl(priv->mmio + PHYREG14);
-			val |= PHYREG14_CKRCV_AMP1;
-			writel(val, priv->mmio + PHYREG14);
+			val = RK3568_PHYREG13_RESISTER_HIGH_Z << RK3568_PHYREG13_RESISTER_SHIFT;
+			val |= RK3568_PHYREG13_CKRCV_AMP0;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG13_RESISTER_MASK, val,
+						 RK3568_PHYREG13);
+
+			val = readl(priv->mmio + RK3568_PHYREG14);
+			val |= RK3568_PHYREG14_CKRCV_AMP1;
+			writel(val, priv->mmio + RK3568_PHYREG14);
 		}
 	}
 
 	if (priv->enable_ssc) {
-		val = readl(priv->mmio + PHYREG8);
-		val |= PHYREG8_SSC_EN;
-		writel(val, priv->mmio + PHYREG8);
+		val = readl(priv->mmio + RK3568_PHYREG8);
+		val |= RK3568_PHYREG8_SSC_EN;
+		writel(val, priv->mmio + RK3568_PHYREG8);
 	}
 
 	return 0;
-- 
2.49.0



Return-Path: <linux-kernel+bounces-799159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBADB427D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6BC17FB6E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77766335BA5;
	Wed,  3 Sep 2025 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn/VF9KV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4E3126BF;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919954; cv=none; b=YAqxvQ+BQFggwSUaPjtAZKB6sK1uuZsyRYUDyQ2Hn4eE0ir2hqUgN9m/y/JO0UIvLVIrlSntz5irNlbxiyFoeNRNMX/fxlDF6F6fjH3bK+7Ui3F+PZp5Xt17rVp9oRutq9hM8FJndC9t/D+D2LXVtw+1ouzKzBQ7c4fXDZmSzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919954; c=relaxed/simple;
	bh=U9NS79r/yfxF2enN0dgFxeqELCwhpIKV/1W2Bi08Osk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dnryh99LQ2Wh3AbX2otaoMPP1/rbNrWAQf90l4c5hh8ds3MbjrDN6glFC10d1T1Md7/AIXqrv2TOd2FxPxh6symOwpvpQk73BQks8qF5ShN+TYqT2WCC1Nd1yUDdKlEuBtIQ1n3E7VtgDzFDPD4ubOst8zjCdb/PzDcLHG+AZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn/VF9KV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91A0FC4CEF4;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756919953;
	bh=U9NS79r/yfxF2enN0dgFxeqELCwhpIKV/1W2Bi08Osk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pn/VF9KVFLiDLBhawe3Y+3l7u0Yiz5xsrUleUdjmU1iwUAPwTBtAdS2LI2GflQNVa
	 xt3pzz4Gbs7Rjz/dO6Hrm1pGMcNbU9u2A9uttux4dsn36KB0PEn8DYbMCjtsvoYgpc
	 iC5Ac/GqPS/FnK0rmtz5CbrwQ8wFH4gqwDEGK4M75uFPfb0M7/Dp1hyJm0175DUZ57
	 Bt8BZHkeCjUG0v7bi5NL+gyqkhU8F1uGlabhEEVVKzSOyUjPq/vgj337zgRRluNBcO
	 H4hTSBvayqdHRl7e6pS9pITH0DWEBjydfQRdK0b2IDud/wPu1Zupydb+oWohtk6i8r
	 xbgZCH1F4siZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D33CA0FF2;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Wed, 03 Sep 2025 19:04:53 +0200
Subject: [PATCH v4 5/7] phy: rockchip: phy-rockchip-inno-csidphy: allow for
 different reset lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v4-5-a4f340a7f0cf@collabora.com>
References: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Collabora Kernel Team <kernel@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, 
 Michael Riesch <michael.riesch@collabora.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756919100; l=4524;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=ouqlgbnwWSp9gE4kXLQdfgX4LelZawR0mUFaykrHL9U=;
 b=NRuarniyeddlvm8uHBr/1dfXaIebfkSTrMveSDbVes8hWlBDX9Cbj175m1OMiyAeFmHJLVISe
 gdtoUNWEX9MCU3fSObSPlZTSV4ciMzlw0cxfSAxYdndDufzBOAc8OYH
X-Developer-Key: i=michael.riesch@collabora.com; a=ed25519;
 pk=+MWX1fffLFZtTPG/I6XdYm/+OSvpRE8D9evQaWbiN04=
X-Endpoint-Received: by B4 Relay for michael.riesch@collabora.com/20250410
 with auth_id=371
X-Original-From: Michael Riesch <michael.riesch@collabora.com>
Reply-To: michael.riesch@collabora.com

From: Michael Riesch <michael.riesch@collabora.com>

The RK3588 MIPI CSI-2 DPHY variant requires two reset lines. Add support
for different sets of reset lines to the phy-rockchip-inno-csidphy driver
as preparation for the introduction of the RK3588 variant.

Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c | 34 +++++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
index 75533d071025..6c4ddcd7e5de 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
@@ -67,6 +67,8 @@
 #define RK1808_CSIDPHY_CLK_CALIB_EN		0x168
 #define RK3568_CSIDPHY_CLK_CALIB_EN		0x168
 
+#define RESETS_MAX				2
+
 /*
  * The higher 16-bit of this register is used for write protection
  * only if BIT(x + 16) set to 1 the BIT(x) can be written.
@@ -127,6 +129,8 @@ struct dphy_drv_data {
 	const struct hsfreq_range *hsfreq_ranges;
 	int num_hsfreq_ranges;
 	const struct dphy_reg *grf_regs;
+	const char *const *resets;
+	unsigned int resets_num;
 };
 
 struct rockchip_inno_csidphy {
@@ -134,7 +138,8 @@ struct rockchip_inno_csidphy {
 	void __iomem *phy_base;
 	struct clk *pclk;
 	struct regmap *grf;
-	struct reset_control *rst;
+	struct reset_control_bulk_data resets[RESETS_MAX];
+	unsigned int resets_num;
 	const struct dphy_drv_data *drv_data;
 	struct phy_configure_opts_mipi_dphy config;
 	u8 hsfreq;
@@ -174,6 +179,10 @@ static const struct hsfreq_range rk3368_mipidphy_hsfreq_ranges[] = {
 	{1249, 0x0c}, {1349, 0x0d}, {1500, 0x0e}
 };
 
+static const char *const rk3368_reset_names[] = {
+	"apb"
+};
+
 static void rockchip_inno_csidphy_ths_settle(struct rockchip_inno_csidphy *priv,
 					     int hsfreq, int offset)
 {
@@ -344,6 +353,8 @@ static const struct dphy_drv_data rk1808_mipidphy_drv_data = {
 	.hsfreq_ranges = rk1808_mipidphy_hsfreq_ranges,
 	.num_hsfreq_ranges = ARRAY_SIZE(rk1808_mipidphy_hsfreq_ranges),
 	.grf_regs = rk1808_grf_dphy_regs,
+	.resets = rk3368_reset_names,
+	.resets_num = ARRAY_SIZE(rk3368_reset_names),
 };
 
 static const struct dphy_drv_data rk3326_mipidphy_drv_data = {
@@ -353,6 +364,8 @@ static const struct dphy_drv_data rk3326_mipidphy_drv_data = {
 	.hsfreq_ranges = rk3326_mipidphy_hsfreq_ranges,
 	.num_hsfreq_ranges = ARRAY_SIZE(rk3326_mipidphy_hsfreq_ranges),
 	.grf_regs = rk3326_grf_dphy_regs,
+	.resets = rk3368_reset_names,
+	.resets_num = ARRAY_SIZE(rk3368_reset_names),
 };
 
 static const struct dphy_drv_data rk3368_mipidphy_drv_data = {
@@ -362,6 +375,8 @@ static const struct dphy_drv_data rk3368_mipidphy_drv_data = {
 	.hsfreq_ranges = rk3368_mipidphy_hsfreq_ranges,
 	.num_hsfreq_ranges = ARRAY_SIZE(rk3368_mipidphy_hsfreq_ranges),
 	.grf_regs = rk3368_grf_dphy_regs,
+	.resets = rk3368_reset_names,
+	.resets_num = ARRAY_SIZE(rk3368_reset_names),
 };
 
 static const struct dphy_drv_data rk3568_mipidphy_drv_data = {
@@ -371,6 +386,8 @@ static const struct dphy_drv_data rk3568_mipidphy_drv_data = {
 	.hsfreq_ranges = rk1808_mipidphy_hsfreq_ranges,
 	.num_hsfreq_ranges = ARRAY_SIZE(rk1808_mipidphy_hsfreq_ranges),
 	.grf_regs = rk3568_grf_dphy_regs,
+	.resets = rk3368_reset_names,
+	.resets_num = ARRAY_SIZE(rk3368_reset_names),
 };
 
 static const struct of_device_id rockchip_inno_csidphy_match_id[] = {
@@ -404,6 +421,7 @@ static int rockchip_inno_csidphy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
 	struct phy *phy;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -435,10 +453,18 @@ static int rockchip_inno_csidphy_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->pclk);
 	}
 
-	priv->rst = devm_reset_control_get(dev, "apb");
-	if (IS_ERR(priv->rst)) {
+	if (priv->drv_data->resets_num > RESETS_MAX) {
+		dev_err(dev, "invalid number of resets\n");
+		return -EINVAL;
+	}
+	priv->resets_num = priv->drv_data->resets_num;
+	for (unsigned int i = 0; i < priv->resets_num; i++)
+		priv->resets[i].id = priv->drv_data->resets[i];
+	ret = devm_reset_control_bulk_get_exclusive(dev, priv->resets_num,
+						    priv->resets);
+	if (ret) {
 		dev_err(dev, "failed to get system reset control\n");
-		return PTR_ERR(priv->rst);
+		return ret;
 	}
 
 	phy = devm_phy_create(dev, NULL, &rockchip_inno_csidphy_ops);

-- 
2.39.5




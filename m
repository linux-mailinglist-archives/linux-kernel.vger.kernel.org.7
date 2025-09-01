Return-Path: <linux-kernel+bounces-795335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B34DB3F047
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C3C7B20C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CC275B0A;
	Mon,  1 Sep 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXFRoTce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EDE20B1F5;
	Mon,  1 Sep 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760513; cv=none; b=NDR39JOTXInr2dh0uq6ZfZ12aEAEI57cFMSX3MyJBJnehM6rgN2rTuG41ZtfTtZZ5CklkIDEpAKz4ULbUiDnmoa2qsNDJbtrAFFTU24/dan/hdjL7dBxmWpB5U9gL4ct9MKkoEVyxD3Gpa3LFT95SxATBcwGsmpAMn1hO3UWtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760513; c=relaxed/simple;
	bh=U9NS79r/yfxF2enN0dgFxeqELCwhpIKV/1W2Bi08Osk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SShXxk1ol9Suz72x0MqXkker8sg8zag+8NH3OwXYXm1F2kjUAg8XGJMlGspui01EU/gKqamBi+ddMRgJu+WRD31YaGGElkvTKETSFbhxppe4oHA0GLrbYLTbTeFJh+jfTMt3rnd+801jbc4nKcpuWH70MCXJNWQIxdhY9EreBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXFRoTce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E016DC113CF;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760512;
	bh=U9NS79r/yfxF2enN0dgFxeqELCwhpIKV/1W2Bi08Osk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cXFRoTce7BDdHKBZ25VFpKZoCFqQ3e+tq0lMO8eMaEf0oB3UwbG95KRDWbXXymB34
	 g3ym9Y3O2WA4l3f/slTO/EBuSaAYUG99e4+fOrjAunumynHlc0ysZ2tNaGWgd2QwCK
	 KLDGxOxI2TJuRz6OYVZSuf78PfsjACxV+kGY6VjfRS7v+NxEDWBRZgE7zo6UKxrsjE
	 AJzZwi6+8mSXzbpiupzYRe09p92hkMEI2UyvFjglHaGoekEe6REaCTIaSTUnOkyvAz
	 lmKMHol7KD0FfkvJXfVjCkOr+uvQV36LxGFWMqXntF9bow3X5XkMkUOhNp+iMv2weH
	 KGu0HYtnxH5Iw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F9CA100C;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Mon, 01 Sep 2025 22:47:46 +0200
Subject: [PATCH v3 5/7] phy: rockchip: phy-rockchip-inno-csidphy: allow for
 different reset lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v3-5-a5ccd5f1f438@collabora.com>
References: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756759662; l=4524;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=ouqlgbnwWSp9gE4kXLQdfgX4LelZawR0mUFaykrHL9U=;
 b=iIw40vlnqv7ELAPioeNy9fNahML68VfNknHBX8bNvDq/Q++vyjwVq9KwJHjq3DUEIa+ffqc40
 msCSS1kBtTIC5eI9qI1Rf6+nzQldjKi8zqvPXc3H0x5St48/voapoXl
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




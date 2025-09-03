Return-Path: <linux-kernel+bounces-799160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDBAB427D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E9217A689
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66814335BA1;
	Wed,  3 Sep 2025 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5iS8JgP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F25313E1D;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919954; cv=none; b=tu92wBWSXEsq99/jKtk4/oSb8NqgS/Cf5xt5OKKAfXQZUh1jS55P94h45JazrlSN9oAAlUX1JZOL6MQunk015p1xgGsR7I6yEGNN2GnESuI14gZo03EOmDAo9dQuZw9mLMKb7ddZ9qs2j3HwzS5eLOYhK/wIFuDzCKImjo2at8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919954; c=relaxed/simple;
	bh=Gc8hKhZmvez+1R7qBtxkfGOQDqE59bJ02H/Yc1b0Phs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLomP+VdN537ZIFlenf5kQBgSZcw9dCer3yakcvE2E7vKyq0PYl6aCSRtz+CvT+mZueYlEYeaSNcnu0X1z9lnf+VSR1ilOs3hf3MwjBVHA/5bxU7TkuHGTBaDxH2uX2huyTS0J9mT/mFPBRsKXPczr1H+j+Pe0Ddui1GmLMbmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5iS8JgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99C0BC116B1;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756919953;
	bh=Gc8hKhZmvez+1R7qBtxkfGOQDqE59bJ02H/Yc1b0Phs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z5iS8JgPXLTbleFtrgMt3NnyJLlz8sDKkgp71jW0ZHKi36JXYfmYJchnDzvtLztr1
	 hpvDqyxjeRZTyxR5X9YytimuOJA8CiVMtB+lummuLG5FjpCwbFEHUDodDcW9HmMQuP
	 jbAdRAtua0DSDRslnnIaQwlmfe1BlzEhJ7l4vEeTYClLToEh0NG4LSaLGuo2aT8b2a
	 RcQ2NZhzlOFTsjsbkn2YUE6+cscQhAWcUaGXm+Bs2DdqwLOI4Yn8oshQP5Ue1DTwsa
	 Lr1o7yvSyzodQd+lSnaXXke1hHO03X55zEkrCZxHMOM2g0cqdf1m2J5mZqd731pSBF
	 9KsVpXC6pUF/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BCECA1009;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Wed, 03 Sep 2025 19:04:54 +0200
Subject: [PATCH v4 6/7] phy: rockchip: phy-rockchip-inno-csidphy: add
 support for rk3588 variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v4-6-a4f340a7f0cf@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756919100; l=2783;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=yeQXRqZNa57y0uWiIJSkXVpQ6zTLhd7z989yNwE9ju8=;
 b=09kf8MWdVIJYt17xvFCMxwQMzZX4u4Brgl+1iUwO4QTsnjcHQsNMRCpKITxjEFx6OTIW6WZC7
 UIWb9h766jYBnPxX3zwxp41iqewKxuENTlmphSwD+LVqfdfDCL3HtRr
X-Developer-Key: i=michael.riesch@collabora.com; a=ed25519;
 pk=+MWX1fffLFZtTPG/I6XdYm/+OSvpRE8D9evQaWbiN04=
X-Endpoint-Received: by B4 Relay for michael.riesch@collabora.com/20250410
 with auth_id=371
X-Original-From: Michael Riesch <michael.riesch@collabora.com>
Reply-To: michael.riesch@collabora.com

From: Michael Riesch <michael.riesch@collabora.com>

The Rockchip RK3588 MIPI CSI-2 DPHY can be supported using the existing
phy-rockchip-inno-csidphy driver, the notable differences being
 - the control bits in the GRF
 - the additional reset line
Add support for this variant.

Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
index 6c4ddcd7e5de..c79fb53d8ee5 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
@@ -30,6 +30,8 @@
 #define RK3568_GRF_VI_CON0		0x0340
 #define RK3568_GRF_VI_CON1		0x0344
 
+#define RK3588_CSIDPHY_GRF_CON0		0x0000
+
 /* PHY */
 #define CSIDPHY_CTRL_LANE_ENABLE		0x00
 #define CSIDPHY_CTRL_LANE_ENABLE_CK		BIT(6)
@@ -117,6 +119,12 @@ static const struct dphy_reg rk3568_grf_dphy_regs[] = {
 	[GRF_DPHY_CSIPHY_CLKLANE_EN] = PHY_REG(RK3568_GRF_VI_CON0, 1, 8),
 };
 
+static const struct dphy_reg rk3588_grf_dphy_regs[] = {
+	[GRF_DPHY_CSIPHY_FORCERXMODE] = PHY_REG(RK3588_CSIDPHY_GRF_CON0, 4, 0),
+	[GRF_DPHY_CSIPHY_DATALANE_EN] = PHY_REG(RK3588_CSIDPHY_GRF_CON0, 4, 4),
+	[GRF_DPHY_CSIPHY_CLKLANE_EN] = PHY_REG(RK3588_CSIDPHY_GRF_CON0, 1, 8),
+};
+
 struct hsfreq_range {
 	u32 range_h;
 	u8 cfg_bit;
@@ -183,6 +191,11 @@ static const char *const rk3368_reset_names[] = {
 	"apb"
 };
 
+static const char *const rk3588_reset_names[] = {
+	"apb",
+	"phy"
+};
+
 static void rockchip_inno_csidphy_ths_settle(struct rockchip_inno_csidphy *priv,
 					     int hsfreq, int offset)
 {
@@ -390,6 +403,17 @@ static const struct dphy_drv_data rk3568_mipidphy_drv_data = {
 	.resets_num = ARRAY_SIZE(rk3368_reset_names),
 };
 
+static const struct dphy_drv_data rk3588_mipidphy_drv_data = {
+	.pwrctl_offset = -1,
+	.ths_settle_offset = RK3568_CSIDPHY_CLK_WR_THS_SETTLE,
+	.calib_offset = RK3568_CSIDPHY_CLK_CALIB_EN,
+	.hsfreq_ranges = rk1808_mipidphy_hsfreq_ranges,
+	.num_hsfreq_ranges = ARRAY_SIZE(rk1808_mipidphy_hsfreq_ranges),
+	.grf_regs = rk3588_grf_dphy_regs,
+	.resets = rk3588_reset_names,
+	.resets_num = ARRAY_SIZE(rk3588_reset_names),
+};
+
 static const struct of_device_id rockchip_inno_csidphy_match_id[] = {
 	{
 		.compatible = "rockchip,px30-csi-dphy",
@@ -411,6 +435,10 @@ static const struct of_device_id rockchip_inno_csidphy_match_id[] = {
 		.compatible = "rockchip,rk3568-csi-dphy",
 		.data = &rk3568_mipidphy_drv_data,
 	},
+	{
+		.compatible = "rockchip,rk3588-csi-dphy",
+		.data = &rk3588_mipidphy_drv_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, rockchip_inno_csidphy_match_id);

-- 
2.39.5




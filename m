Return-Path: <linux-kernel+bounces-742476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 421CBB0F229
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F191C8603D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51B2E6118;
	Wed, 23 Jul 2025 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="AZNi5pnJ"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E392E7182
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273437; cv=none; b=Yjm9uxRybfgZcs86KiBQ10w8KNxLbQ12OGM6Az5gBSj2NYoA4sSxuFGNf+Lxiu6qneEyd6MAOXorj9WIaYZ9bXIsTo/icdx3oCKa0h9p9WXAqOGmi8uU8gb6gUXrcuUsIrYth1nCxo4aaALNZa2J1+TJKWVEqwX65Q32eyQeJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273437; c=relaxed/simple;
	bh=cdNBkQlutdrvrcaHH16yIRxSKS/R7TMRMZ65Ez/Jxsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWa59NbPfSGTNIXOqar/dWSFfNz4cX8g5vIIyJrONlJfXtwTe6TH0VjYvqRpNOJbjmn0dGUcgO8EjS2znahm1wM6h48LD0hdoqnly29AbAV3V9kuBValSOlbMEIKCyKmQTZ2pDdSZZ3h5yEpphdoLCmTIoeKSfAmAw0nyjfQB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=AZNi5pnJ; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753273434; bh=zhhvg5zJxU5T4KsEk/esqcxT0PtM2GilClP+9BqeGhw=;
 b=AZNi5pnJ4s3VvOH7espO4hV+Ti3iAYLnnBbD2skDfHDZmbx7oIA/rjcoXUGoHv3I2MgkREzTa
 Y5Y12sdZx9ukdoLGzCRu1Mw/BPOmQosNnp6HYyK0QaCIyOZWjmFjA0LzIb2Jj1nY/DcV4ziiqax
 CpgDREw267yLvobYd3yyfE1Ug4ZoVFK0OpHopzuC5yx0bD23RVGBs/vIxppIDanXoCEzStt6g9j
 HqDRamDEA9NsB0fb8zsJQ1/hwANCiyYVmWH/4sE8Ax6PU2ixb6FqhgSroPezOsvl1oRcmUCjHgy
 Zjgynsl9ie4d7z0GJYrQBDEV5as36RSueS3AQl21l52A==
X-Forward-Email-ID: 6880d457cb0ee86f9731a0cb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Jianwei Zheng <jianwei.zheng@rock-chips.com>
Subject: [PATCH 05/11] phy: rockchip: inno-usb2: Add support for RK3528
Date: Wed, 23 Jul 2025 12:23:03 +0000
Message-ID: <20250723122323.2344916-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723122323.2344916-1-jonas@kwiboo.se>
References: <20250723122323.2344916-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianwei Zheng <jianwei.zheng@rock-chips.com>

The RK3528 has a single USB2PHY with a otg and host port.

Add support for the RK3528 variant of USB2PHY.

PHY tuning for RK3528:

- Turn off differential receiver in suspend mode to save power
  consumption.

- Set HS eye-height to 400mV instead of default 450mV.

- Choose the Tx fs/ls data as linestate from TX driver for otg port
  which uses dwc3 controller to improve fs/ls devices compatibility with
  long cables.

This is based on vendor kernel linux-stan-6.1-rkr5 tag.

Signed-off-by: Jianwei Zheng <jianwei.zheng@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index cd1a02b990ef..b8950d9f9e97 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1507,6 +1507,28 @@ static int rk3128_usb2phy_tuning(struct rockchip_usb2phy *rphy)
 				BIT(2) << BIT_WRITEABLE_SHIFT | 0);
 }
 
+static int rk3528_usb2phy_tuning(struct rockchip_usb2phy *rphy)
+{
+	int ret = 0;
+
+	/* Turn off otg port differential receiver in suspend mode */
+	ret |= regmap_write(rphy->phy_base, 0x30, BIT(18) | 0x0000);
+
+	/* Turn off host port differential receiver in suspend mode */
+	ret |= regmap_write(rphy->phy_base, 0x430, BIT(18) | 0x0000);
+
+	/* Set otg port HS eye height to 400mv (default is 450mv) */
+	ret |= regmap_write(rphy->phy_base, 0x30, GENMASK(22, 20) | 0x0000);
+
+	/* Set host port HS eye height to 400mv (default is 450mv) */
+	ret |= regmap_write(rphy->phy_base, 0x430, GENMASK(22, 20) | 0x0000);
+
+	/* Choose the Tx fs/ls data as linestate from TX driver for otg port */
+	ret |= regmap_write(rphy->phy_base, 0x94, GENMASK(22, 19) | 0x0018);
+
+	return ret;
+}
+
 static int rk3576_usb2phy_tuning(struct rockchip_usb2phy *rphy)
 {
 	int ret;
@@ -1920,6 +1942,57 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3528_phy_cfgs[] = {
+	{
+		.reg = 0xffdf0000,
+		.num_ports	= 2,
+		.phy_tuning	= rk3528_usb2phy_tuning,
+		.clkout_ctl_phy	= { 0x041c, 7, 2, 0, 0x27 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x004c, 8, 0, 0, 0x1d1 },
+				.bvalid_det_en	= { 0x0074, 3, 2, 0, 3 },
+				.bvalid_det_st	= { 0x0078, 3, 2, 0, 3 },
+				.bvalid_det_clr	= { 0x007c, 3, 2, 0, 3 },
+				.idfall_det_en	= { 0x0074, 5, 5, 0, 1 },
+				.idfall_det_st	= { 0x0078, 5, 5, 0, 1 },
+				.idfall_det_clr	= { 0x007c, 5, 5, 0, 1 },
+				.idrise_det_en	= { 0x0074, 4, 4, 0, 1 },
+				.idrise_det_st	= { 0x0078, 4, 4, 0, 1 },
+				.idrise_det_clr	= { 0x007c, 4, 4, 0, 1 },
+				.ls_det_en	= { 0x0074, 0, 0, 0, 1 },
+				.ls_det_st	= { 0x0078, 0, 0, 0, 1 },
+				.ls_det_clr	= { 0x007c, 0, 0, 0, 1 },
+				.utmi_avalid	= { 0x006c, 1, 1, 0, 1 },
+				.utmi_bvalid	= { 0x006c, 0, 0, 0, 1 },
+				.utmi_id	= { 0x006c, 6, 6, 0, 1 },
+				.utmi_ls	= { 0x006c, 5, 4, 0, 1 },
+			},
+			[USB2PHY_PORT_HOST] = {
+				.phy_sus	= { 0x005c, 8, 0, 0x1d2, 0x1d1 },
+				.ls_det_en	= { 0x0090, 0, 0, 0, 1 },
+				.ls_det_st	= { 0x0094, 0, 0, 0, 1 },
+				.ls_det_clr	= { 0x0098, 0, 0, 0, 1 },
+				.utmi_ls	= { 0x006c, 13, 12, 0, 1 },
+				.utmi_hstdet	= { 0x006c, 15, 15, 0, 1 },
+			}
+		},
+		.chg_det = {
+			.opmode		= { 0x004c, 3, 0, 5, 1 },
+			.cp_det		= { 0x006c, 19, 19, 0, 1 },
+			.dcp_det	= { 0x006c, 18, 18, 0, 1 },
+			.dp_det		= { 0x006c, 20, 20, 0, 1 },
+			.idm_sink_en	= { 0x0058, 1, 1, 0, 1 },
+			.idp_sink_en	= { 0x0058, 0, 0, 0, 1 },
+			.idp_src_en	= { 0x0058, 2, 2, 0, 1 },
+			.rdm_pdwn_en	= { 0x0058, 3, 3, 0, 1 },
+			.vdm_src_en	= { 0x0058, 5, 5, 0, 1 },
+			.vdp_src_en	= { 0x0058, 4, 4, 0, 1 },
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3562_phy_cfgs[] = {
 	{
 		.reg = 0xff740000,
@@ -2287,6 +2360,7 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
 	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
 	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
+	{ .compatible = "rockchip,rk3528-usb2phy", .data = &rk3528_phy_cfgs },
 	{ .compatible = "rockchip,rk3562-usb2phy", .data = &rk3562_phy_cfgs },
 	{ .compatible = "rockchip,rk3568-usb2phy", .data = &rk3568_phy_cfgs },
 	{ .compatible = "rockchip,rk3576-usb2phy", .data = &rk3576_phy_cfgs },
-- 
2.50.1



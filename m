Return-Path: <linux-kernel+bounces-742474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122A8B0F223
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07478967F96
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FF32E6D3D;
	Wed, 23 Jul 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="woenmJN1"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3852E62CE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273432; cv=none; b=dc6r04S2NDM9gb4fKmvchjsUkSER4nd6G3ZH13PArpmkZh9ipaJiROAmFaNqtBeBHAx/UMSxAZoXL9jueZ5TlTCPiMsMXQUl1eZeRCqKrCvllNGIIId9ILzMSIbyyPYDrwRgp7TRnDOvnEovKzL53jx9+EQJ1R0njyKECg7wOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273432; c=relaxed/simple;
	bh=DTnFKaqXMEEGzhsDNMlfzfA05S3UXxqZxcGj8rtyYVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFeBLAk3x5UQZMQdey3cD4Kn1yzRrNiVXhTRsZ9z20/CyEQMrkR8DnlyG4UpNp4DlrDJjP5lO1hnqbqKA/4GqSeJ6bjZuU9Qu+BlOVov6pvrakiy9j0Nrc3+E1qKkxeHKsOGTfyYFPtH31M3L/gvoXwM38idbxakqhg1Mm0YjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=woenmJN1; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753273430; bh=G7HtzhH5QPJr92DGCLq8/qfM86Vj1rU2kScnrBc1jhM=;
 b=woenmJN1aBXmGg8d8qEPz2IJtXUlhqaQ59x/4DbJEp+GE1zVul0sD/XzInEs6MRJESwHfuNdg
 TMcz9anhctM/DMFruIGqa7SSo1drlOAnHufQWKfdR+78H23WEOV9L0WUTDlA+PTIQyJG9tm225u
 eVBydH8zeAvpU9nFqabc9qvLWDJuTNBKFUZEZJPH/O/76QU4bqyZznIuz8b7VBJ57dzBgNi8YFK
 qi/W2oxAvFVfonawHXMSrCqtdNHyOmQz6U2pvoQtm2wGJG/kqO4nHt5uFao6zLkvdDVnPFpe5mE
 FHuGsE4e/FXJgLhI7G0oKxapeqlo4ynCHs8WBAAB9hqA==
X-Forward-Email-ID: 6880d453cb0ee86f9731a09c
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
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 04/11] phy: rockchip: inno-usb2: Add clkout_ctl_phy support
Date: Wed, 23 Jul 2025 12:23:02 +0000
Message-ID: <20250723122323.2344916-5-jonas@kwiboo.se>
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

The 480m clk is controlled using regs in the PHY address space and not
in the USB GRF address space on e.g. RK3528 and RK3506.

Add a clkout_ctl_phy usb2phy_reg to handle enable/disable of the 480m
clk on these SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 47 +++++++++++++++----
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 130f03474719..cd1a02b990ef 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -179,6 +179,7 @@ struct rockchip_usb2phy_cfg {
 	unsigned int	num_ports;
 	int (*phy_tuning)(struct rockchip_usb2phy *rphy);
 	struct usb2phy_reg	clkout_ctl;
+	struct usb2phy_reg	clkout_ctl_phy;
 	const struct rockchip_usb2phy_port_cfg	port_cfgs[USB2PHY_NUM_PORTS];
 	const struct rockchip_chg_det_reg	chg_det;
 };
@@ -228,6 +229,7 @@ struct rockchip_usb2phy_port {
  * struct rockchip_usb2phy - usb2.0 phy driver data.
  * @dev: pointer to device.
  * @grf: General Register Files regmap.
+ * @phy_base: USB PHY regmap.
  * @clks: array of phy input clocks.
  * @clk480m: clock struct of phy output clk.
  * @clk480m_hw: clock struct of phy output clk management.
@@ -245,6 +247,7 @@ struct rockchip_usb2phy_port {
 struct rockchip_usb2phy {
 	struct device	*dev;
 	struct regmap	*grf;
+	struct regmap	*phy_base;
 	struct clk_bulk_data	*clks;
 	struct clk	*clk480m;
 	struct clk_hw	clk480m_hw;
@@ -312,15 +315,33 @@ static void rockchip_usb2phy_clk_bulk_disable(void *data)
 	clk_bulk_disable_unprepare(rphy->num_clks, rphy->clks);
 }
 
-static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
+static void
+rockchip_usb2phy_clk480m_clkout_ctl(struct clk_hw *hw, struct regmap **base,
+				    const struct usb2phy_reg **clkout_ctl)
 {
 	struct rockchip_usb2phy *rphy =
 		container_of(hw, struct rockchip_usb2phy, clk480m_hw);
+
+	if (rphy->phy_cfg->clkout_ctl_phy.enable) {
+		*base = rphy->phy_base;
+		*clkout_ctl = &rphy->phy_cfg->clkout_ctl_phy;
+	} else {
+		*base = rphy->grf;
+		*clkout_ctl = &rphy->phy_cfg->clkout_ctl;
+	}
+}
+
+static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
+{
+	const struct usb2phy_reg *clkout_ctl;
+	struct regmap *base;
 	int ret;
 
+	rockchip_usb2phy_clk480m_clkout_ctl(hw, &base, &clkout_ctl);
+
 	/* turn on 480m clk output if it is off */
-	if (!property_enabled(rphy->grf, &rphy->phy_cfg->clkout_ctl)) {
-		ret = property_enable(rphy->grf, &rphy->phy_cfg->clkout_ctl, true);
+	if (!property_enabled(base, clkout_ctl)) {
+		ret = property_enable(base, clkout_ctl, true);
 		if (ret)
 			return ret;
 
@@ -333,19 +354,23 @@ static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
 
 static void rockchip_usb2phy_clk480m_unprepare(struct clk_hw *hw)
 {
-	struct rockchip_usb2phy *rphy =
-		container_of(hw, struct rockchip_usb2phy, clk480m_hw);
+	const struct usb2phy_reg *clkout_ctl;
+	struct regmap *base;
+
+	rockchip_usb2phy_clk480m_clkout_ctl(hw, &base, &clkout_ctl);
 
 	/* turn off 480m clk output */
-	property_enable(rphy->grf, &rphy->phy_cfg->clkout_ctl, false);
+	property_enable(base, clkout_ctl, false);
 }
 
 static int rockchip_usb2phy_clk480m_prepared(struct clk_hw *hw)
 {
-	struct rockchip_usb2phy *rphy =
-		container_of(hw, struct rockchip_usb2phy, clk480m_hw);
+	const struct usb2phy_reg *clkout_ctl;
+	struct regmap *base;
+
+	rockchip_usb2phy_clk480m_clkout_ctl(hw, &base, &clkout_ctl);
 
-	return property_enabled(rphy->grf, &rphy->phy_cfg->clkout_ctl);
+	return property_enabled(base, clkout_ctl);
 }
 
 static unsigned long
@@ -1332,9 +1357,13 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 	if (!dev->parent || !dev->parent->of_node ||
 	    of_property_present(np, "rockchip,usbgrf")) {
+		rphy->phy_base = device_node_to_regmap(np);
+		if (IS_ERR(rphy->phy_base))
+			return PTR_ERR(rphy->phy_base);
 		rphy->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,usbgrf");
 	} else {
 		rphy->grf = syscon_node_to_regmap(dev->parent->of_node);
+		rphy->phy_base = rphy->grf;
 	}
 	if (IS_ERR(rphy->grf))
 		return PTR_ERR(rphy->grf);
-- 
2.50.1



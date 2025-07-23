Return-Path: <linux-kernel+bounces-742004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFD1B0EBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E81E7A68BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE1272E63;
	Wed, 23 Jul 2025 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="RFP7DkE/"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5726CE2B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255423; cv=none; b=F9Ki1ejjxgcOoHKFY+eNMeZpT3+g0LUidfGVCecxSb+4vr4dzcJB3NgWnbC/flOtOxp8iyCMomxvue/3YdWBa2F91AZPg61ROobDF1YqrCXEYM6yGtuHdpnlqoK8uwAe2DGulsS4MbUQb/A1O7GKggqzfkTQTG8/zUs78O9N2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255423; c=relaxed/simple;
	bh=8mi92YNzYL2sjB0TAj9E3So69H63Em9D7zzr52GWm/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGJPcGsZ6xhv682KBpCivNh3rHBlPkeztBEDGkBXi3W/nYQ01OyJImpG03JLaUwtH/pHbDaZwFKIpOJgz5JuslTM5hHsEfMV0SrWFoJkRE6z2nkexkYM1TZx1nTJRu+M2ipYeFvV/AI0coGBOSjBZjgWJGhLbryxxEapDktcKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=RFP7DkE/; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1753255414;
 bh=0C0aN8MLHW4J4HYuVSaQCCwJddLZcpEJzicpIxJWh/Y=;
 b=RFP7DkE/vPwLGB0LM7iPc6iJX6iZ7UZv2feJZlmaVxmsTFTosU+3eoH3EzsNMGdromgCxZ0BA
 6hAzABSmrOllUZPisdyAVhfC8NFbZnPgy7YRyGz6AjgWUq2OwavDMA8JmhaabF7Q3JE8zg4jUvB
 w3190l1cA0vGpK4cKItJ3oWB3WFA6+DmkirE1rM0wyVS8AzzKkIsppbiHwh+lSuWkdYahIA1Joh
 jgMKBFhoBVbIm1cqS3YQrtd/MVmXpfsC5D9Roi8zs/im4uVRh7oRj4jUyMXCyRfmlk9IUDRPG+Z
 r8skYJj8hDz7sXKbwYwUsQzgG8jvnqk/Y7g/rnILXteA==
X-Forward-Email-ID: 68808df2a1f2afba60dd694c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>,
	Johan Jonker <jbx6244@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: rockchip: naneng-combphy: Enable U3 OTG port for RK3568
Date: Wed, 23 Jul 2025 07:23:22 +0000
Message-ID: <20250723072324.2246498-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The boot firmware may disable the U3 port early during boot and leave it
up to the controller or PHY driver to re-enable U3 when needed.

The Rockchip USBDP PHY driver currently does this for RK3576 and RK3588,
something the Rockchip Naneng Combo PHY driver never does for RK3568.
This may result in USB 3.0 ports being limited to only using USB 2.0 or
in special cases not working at all on RK3568.

Write to PIPE_GRF USB3OTGx_CON1 reg to ensure the U3 port is enabled
when a PHY with PHY_TYPE_USB3 mode is used.

Fixes: 7160820d742a ("phy: rockchip: add naneng combo phy for RK3568")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Mainline U-Boot currently do not disable the U3 ports early, something
that possibly may change in a future release of U-Boot.

A pending U-Boot series will likely include a patch similar to
("rockchip: rk3588: Disable USB3OTG U3 ports early") [1] for RK3568.

[1] http://https//lore.kernel.org/r/20250721220734.1617117-9-jonas@kwiboo.se/
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index bf00a85a113b..66fd0f59c21a 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -178,6 +178,8 @@ struct rockchip_combphy_grfcfg {
 	struct combphy_reg pipe_xpcs_phy_ready;
 	struct combphy_reg pipe_pcie1l0_sel;
 	struct combphy_reg pipe_pcie1l1_sel;
+	struct combphy_reg u3otg0_port_en;
+	struct combphy_reg u3otg1_port_en;
 };
 
 struct rockchip_combphy_cfg {
@@ -777,6 +779,14 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
+		switch (priv->id) {
+		case 0:
+			rockchip_combphy_param_write(priv->pipe_grf, &cfg->u3otg0_port_en, true);
+			break;
+		case 1:
+			rockchip_combphy_param_write(priv->pipe_grf, &cfg->u3otg1_port_en, true);
+			break;
+		}
 		break;
 
 	case PHY_TYPE_SATA:
@@ -923,6 +933,8 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
 	/* pipe-grf */
 	.pipe_con0_for_sata	= { 0x0000, 15, 0, 0x00, 0x2220 },
 	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },
+	.u3otg0_port_en		= { 0x0104, 15, 0, 0x0181, 0x1100 },
+	.u3otg1_port_en		= { 0x0144, 15, 0, 0x0181, 0x1100 },
 };
 
 static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
-- 
2.50.1



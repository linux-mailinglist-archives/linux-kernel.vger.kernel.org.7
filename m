Return-Path: <linux-kernel+bounces-680559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D96AD46D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 01:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D56C7A4200
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 23:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B38269B01;
	Tue, 10 Jun 2025 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tfNYDMO7"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD112D5414
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598601; cv=none; b=cOi0BSMUNXYB3fvSUIcSykBbZP0w9xKSYkkaSP8xe6o7dwd5+5IBjDw8Ut2KbIb822rAcUmu4ur3Lm4N5X+RERu0oxa6mLgwME+FRJV3wxb6glLJWTtj1gPCytE+HQJYz12xWaPye+93nVLKFrvq0jBJ3eoCQ1ZZalnAzW7Vs1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598601; c=relaxed/simple;
	bh=a9mHbrJOiLHj5NsYMvttJmJI0NUURDRVikwiQPz8Cus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQ6qonTV2ej/zrVWZB7PNB1S02CpabO8Rx1RaIo/flKLyp3ca4tUgSuRJuQEz54eg7ztv0npavAol2wCLrxmpPPfaRFw5GxLpum6rSk5iLWPEAXUPMILFERPCOW7n9uUwYb2ZNjJGA0DNJpbLM4frfzsinq+VniQKZP2rPpHQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tfNYDMO7; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749598587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8RdlCinf2+TlX4dL62XH9+5xu9xSdaTA7tP0qW17CU=;
	b=tfNYDMO7Au3DTDerxjE0DGvNgY2OqXdcMVgnOQRqTXw9fXo84yvLvCA+DQrgu/1mgMY49P
	AloQrvAIeqAJVRzRHJqN0KqMCq+q47mn4yAeP4w5nE6U6j1xHayiqE5ZE4OQEbIpGxEpth
	Ko22Xk0VPSTDvSugTlfI42g/jJi184c=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [net-next PATCH v6 08/10] net: macb: Move most of mac_config to mac_prepare
Date: Tue, 10 Jun 2025 19:35:47 -0400
Message-Id: <20250610233547.3588356-1-sean.anderson@linux.dev>
In-Reply-To: <20250610233134.3588011-1-sean.anderson@linux.dev>
References: <20250610233134.3588011-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

mac_prepare is called every time the interface is changed, so we can do
all of our configuration there, instead of in mac_config. This will be
useful for the next patch where we will set the PCS bit based on whether
we are using our internal PCS. No functional change intended.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v6:
- Fix use of spin_lock instead of spin_unlock

Changes in v2:
- Fix docs for macb_pcs_config_an
- Include change to macb_pcs_get_state which was previously in the next
  patch

 drivers/net/ethernet/cadence/macb_main.c | 209 ++++++++++++++---------
 1 file changed, 132 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d1f1ae5ea161..78433d8f3746 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -549,19 +549,91 @@ static void macb_set_tx_clk(struct macb *bp, int speed)
 		netdev_err(bp->dev, "adjusting tx_clk failed.\n");
 }
 
-static void macb_usx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
-				 phy_interface_t interface, int speed,
-				 int duplex)
-{
-	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
-	u32 config;
-
-	config = gem_readl(bp, USX_CONTROL);
-	config = GEM_BFINS(SERDES_RATE, MACB_SERDES_RATE_10G, config);
-	config = GEM_BFINS(USX_CTRL_SPEED, HS_SPEED_10000M, config);
-	config &= ~(GEM_BIT(TX_SCR_BYPASS) | GEM_BIT(RX_SCR_BYPASS));
-	config |= GEM_BIT(TX_EN);
-	gem_writel(bp, USX_CONTROL, config);
+static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+			       struct phylink_link_state *state)
+{
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+
+	phylink_mii_c22_pcs_decode_state(state, neg_mode, gem_readl(bp, PCSSTS),
+					 gem_readl(bp, PCSANLPBASE));
+}
+
+/**
+ * macb_pcs_config_an() - Configure autonegotiation settings for PCSs
+ * @bp: The macb to operate on
+ * @neg_mode: The autonegotiation mode
+ * @interface: The interface to use
+ * @advertising: The advertisement mask
+ *
+ * This provides common configuration for PCS autonegotiation.
+ *
+ * Context: Call with @bp->lock held.
+ * Return: 1 if any registers were changed; 0 otherwise
+ */
+static int macb_pcs_config_an(struct macb *bp, unsigned int neg_mode,
+			      phy_interface_t interface,
+			      const unsigned long *advertising)
+{
+	bool changed = false;
+	int old, new;
+
+	old = gem_readl(bp, PCSANADV);
+	new = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
+	if (new != -EINVAL && old != new) {
+		changed = true;
+		gem_writel(bp, PCSANADV, new);
+	}
+
+	old = new = gem_readl(bp, PCSCNTRL);
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		new |= BMCR_ANENABLE;
+	else
+		new &= ~BMCR_ANENABLE;
+	if (old != new) {
+		changed = true;
+		gem_writel(bp, PCSCNTRL, new);
+	}
+	return changed;
+}
+
+static int macb_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
+			   phy_interface_t interface,
+			   const unsigned long *advertising,
+			   bool permit_pause_to_mac)
+{
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+	bool changed = false;
+	unsigned long flags;
+	u32 old, new;
+
+	spin_lock_irqsave(&bp->lock, flags);
+	old = new = gem_readl(bp, NCFGR);
+	new |= GEM_BIT(SGMIIEN);
+	if (old != new) {
+		changed = true;
+		gem_writel(bp, NCFGR, new);
+	}
+
+	if (macb_pcs_config_an(bp, mode, interface, advertising))
+		changed = true;
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+	return changed;
+}
+
+static void macb_pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+	u32 bmcr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	bmcr = gem_readl(bp, PCSCNTRL);
+	bmcr |= BMCR_ANENABLE;
+	gem_writel(bp, PCSCNTRL, bmcr);
+
+	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
 static void macb_usx_pcs_get_state(struct phylink_pcs *pcs,
@@ -589,45 +661,60 @@ static int macb_usx_pcs_config(struct phylink_pcs *pcs,
 			       bool permit_pause_to_mac)
 {
 	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
+	unsigned long flags;
+	bool changed;
+	u16 old, new;
 
-	gem_writel(bp, USX_CONTROL, gem_readl(bp, USX_CONTROL) |
-		   GEM_BIT(SIGNAL_OK));
+	spin_lock_irqsave(&bp->lock, flags);
+	if (macb_pcs_config_an(bp, neg_mode, interface, advertising))
+		changed = true;
 
-	return 0;
-}
+	old = new = gem_readl(bp, USX_CONTROL);
+	new |= GEM_BIT(SIGNAL_OK);
+	if (old != new) {
+		changed = true;
+		gem_writel(bp, USX_CONTROL, new);
+	}
 
-static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
-			       struct phylink_link_state *state)
-{
-	state->link = 0;
-}
+	old = new = gem_readl(bp, USX_CONTROL);
+	new = GEM_BFINS(SERDES_RATE, MACB_SERDES_RATE_10G, new);
+	new = GEM_BFINS(USX_CTRL_SPEED, HS_SPEED_10000M, new);
+	new &= ~(GEM_BIT(TX_SCR_BYPASS) | GEM_BIT(RX_SCR_BYPASS));
+	new |= GEM_BIT(TX_EN);
+	if (old != new) {
+		changed = true;
+		gem_writel(bp, USX_CONTROL, new);
+	}
 
-static void macb_pcs_an_restart(struct phylink_pcs *pcs)
-{
-	/* Not supported */
-}
-
-static int macb_pcs_config(struct phylink_pcs *pcs,
-			   unsigned int neg_mode,
-			   phy_interface_t interface,
-			   const unsigned long *advertising,
-			   bool permit_pause_to_mac)
-{
-	return 0;
+	spin_unlock_irqrestore(&bp->lock, flags);
+	return changed;
 }
 
 static const struct phylink_pcs_ops macb_phylink_usx_pcs_ops = {
 	.pcs_get_state = macb_usx_pcs_get_state,
 	.pcs_config = macb_usx_pcs_config,
-	.pcs_link_up = macb_usx_pcs_link_up,
 };
 
 static const struct phylink_pcs_ops macb_phylink_pcs_ops = {
 	.pcs_get_state = macb_pcs_get_state,
-	.pcs_an_restart = macb_pcs_an_restart,
 	.pcs_config = macb_pcs_config,
+	.pcs_an_restart = macb_pcs_an_restart,
 };
 
+static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
+					       phy_interface_t interface)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(ndev);
+
+	if (interface == PHY_INTERFACE_MODE_10GBASER)
+		return &bp->phylink_usx_pcs;
+	else if (interface == PHY_INTERFACE_MODE_SGMII)
+		return &bp->phylink_sgmii_pcs;
+	else
+		return NULL;
+}
+
 static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 			    const struct phylink_link_state *state)
 {
@@ -646,18 +733,14 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 		if (state->interface == PHY_INTERFACE_MODE_RMII)
 			ctrl |= MACB_BIT(RM9200_RMII);
 	} else if (macb_is_gem(bp)) {
-		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
-		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
-
-		if (state->interface == PHY_INTERFACE_MODE_SGMII) {
-			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
-		} else if (state->interface == PHY_INTERFACE_MODE_10GBASER) {
+		if (macb_mac_select_pcs(config, state->interface))
 			ctrl |= GEM_BIT(PCSSEL);
-			ncr |= GEM_BIT(ENABLE_HS_MAC);
-		} else if (bp->caps & MACB_CAPS_MIIONRGMII &&
-			   bp->phy_interface == PHY_INTERFACE_MODE_MII) {
+		else
+			ctrl &= ~GEM_BIT(PCSSEL);
+
+		if (bp->caps & MACB_CAPS_MIIONRGMII &&
+		    bp->phy_interface == PHY_INTERFACE_MODE_MII)
 			ncr |= MACB_BIT(MIIONRGMII);
-		}
 	}
 
 	/* Apply the new configuration, if any */
@@ -667,22 +750,6 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 	if (old_ncr ^ ncr)
 		macb_or_gem_writel(bp, NCR, ncr);
 
-	/* Disable AN for SGMII fixed link configuration, enable otherwise.
-	 * Must be written after PCSSEL is set in NCFGR,
-	 * otherwise writes will not take effect.
-	 */
-	if (macb_is_gem(bp) && state->interface == PHY_INTERFACE_MODE_SGMII) {
-		u32 pcsctrl, old_pcsctrl;
-
-		old_pcsctrl = gem_readl(bp, PCSCNTRL);
-		if (mode == MLO_AN_FIXED)
-			pcsctrl = old_pcsctrl & ~GEM_BIT(PCSAUTONEG);
-		else
-			pcsctrl = old_pcsctrl | GEM_BIT(PCSAUTONEG);
-		if (old_pcsctrl != pcsctrl)
-			gem_writel(bp, PCSCNTRL, pcsctrl);
-	}
-
 	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
@@ -735,10 +802,12 @@ static void macb_mac_link_up(struct phylink_config *config,
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 		ctrl &= ~MACB_BIT(PAE);
 		if (macb_is_gem(bp)) {
-			ctrl &= ~GEM_BIT(GBE);
+			ctrl &= ~(GEM_BIT(GBE) | GEM_BIT(ENABLE_HS_MAC));
 
 			if (speed == SPEED_1000)
 				ctrl |= GEM_BIT(GBE);
+			else if (speed == SPEED_10000)
+				ctrl |= GEM_BIT(ENABLE_HS_MAC);
 		}
 
 		if (rx_pause)
@@ -776,20 +845,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 	netif_tx_wake_all_queues(ndev);
 }
 
-static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
-					       phy_interface_t interface)
-{
-	struct net_device *ndev = to_net_dev(config->dev);
-	struct macb *bp = netdev_priv(ndev);
-
-	if (interface == PHY_INTERFACE_MODE_10GBASER)
-		return &bp->phylink_usx_pcs;
-	else if (interface == PHY_INTERFACE_MODE_SGMII)
-		return &bp->phylink_sgmii_pcs;
-	else
-		return NULL;
-}
-
 static const struct phylink_mac_ops macb_phylink_ops = {
 	.mac_select_pcs = macb_mac_select_pcs,
 	.mac_config = macb_mac_config,
-- 
2.35.1.1320.gc452695387.dirty



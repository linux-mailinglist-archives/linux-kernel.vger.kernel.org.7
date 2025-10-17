Return-Path: <linux-kernel+bounces-857875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3C1BE81E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5532565286
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32CC31A554;
	Fri, 17 Oct 2025 10:48:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C363176E7
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698082; cv=none; b=PdUDtyqYw+CHkcAPnmbS/3kFuJU+d6Jnmsf/dWfnGmfA05E8DnsVeq2grKwLmllwztpl85gfCpxXmZe7fOt7AS9S/VecIZFjzG5Xii3jlImznf8GiA4tVkddU7mEkTTBFqEM8oN7GAxD/aQis9EH0yeOfTZhjH+6bCSWR7jZeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698082; c=relaxed/simple;
	bh=xsnBDWksIFYs2tN6AROUWU7MAjR27N2SOy5nKWnhUYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lj3VpAV8rD8UARzoDjm8q1pRsA/yFGZJdIbI+fEVFZGk3Mt10JqUafPka+N1yFb1IJr2gYZQeyb3ERWqQTtv7RMOhaazlqVyyXlry3gMBuO/XKFKJWjQonCSxsIoXGUW9kZIY0xi6AsIxP++dnq64zWxD2IrdylLnuTxlh2IiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzn-0000AL-1j; Fri, 17 Oct 2025 12:47:39 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzl-0042n9-0x;
	Fri, 17 Oct 2025 12:47:37 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzl-0000000F0Aw-0kGd;
	Fri, 17 Oct 2025 12:47:37 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>,
	Roan van Dijk <roan@protonic.nl>
Subject: [PATCH net-next v6 5/5] net: phy: dp83td510: add MSE interface support for 10BASE-T1L
Date: Fri, 17 Oct 2025 12:47:32 +0200
Message-ID: <20251017104732.3575484-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017104732.3575484-1-o.rempel@pengutronix.de>
References: <20251017104732.3575484-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Implement get_mse_capability() and get_mse_snapshot() for the DP83TD510E
to expose its Mean Square Error (MSE) register via the new PHY MSE
UAPI.

The DP83TD510E does not document any peak MSE values; it only exposes
a single average MSE register used internally to derive SQI. This
implementation therefore advertises only PHY_MSE_CAP_AVG, along with
LINK and channel-A selectors. Scaling is fixed to 0xFFFF, and the
refresh interval/number of symbols are estimated from 10BASE-T1L
symbol rate (7.5 MBd) and typical diagnostic intervals (~1 ms).

For 10BASE-T1L deployments, SQI is a reliable indicator of link
modulation quality once the link is established, but it does not
indicate whether autonegotiation pulses will be correctly received
in marginal conditions. MSE provides a direct measurement of slicer
error rate that can be used to evaluate if autonegotiation is likely
to succeed under a given cable length and condition. In practice,
testing such scenarios often requires forcing a fixed-link setup to
isolate MSE behaviour from the autonegotiation process.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83td510.c | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index 23af1ac194fa..6875f418fa78 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -61,6 +61,7 @@
 #define DP83TD510E_MASTER_SLAVE_RESOL_FAIL	BIT(15)
 
 #define DP83TD510E_MSE_DETECT			0xa85
+#define DP83TD510E_MSE_MAX			U16_MAX
 
 #define DP83TD510_SQI_MAX	7
 
@@ -249,6 +250,63 @@ struct dp83td510_priv {
 #define DP83TD510E_ALCD_COMPLETE			BIT(15)
 #define DP83TD510E_ALCD_CABLE_LENGTH			GENMASK(10, 0)
 
+static int dp83td510_get_mse_capability(struct phy_device *phydev,
+					struct phy_mse_capability *cap)
+{
+	/* DP83TD510E documents only a single (average) MSE register
+	 * (used to derive SQI); no peak or worst-peak counters are
+	 * described. Advertise only PHY_MSE_CAP_AVG.
+	 */
+	cap->supported_caps = PHY_MSE_CAP_AVG;
+	/* 10BASE-T1L is a single-pair medium, so there are no B/C/D channels.
+	 * We still advertise PHY_MSE_CAP_CHANNEL_A to indicate that the PHY
+	 * can attribute the measurement to a specific pair (the only one),
+	 * rather than exposing it only as a link-aggregate.
+	 *
+	 * Rationale:
+	 *  - Keeps the ethtool MSE_GET selection logic consistent: per-channel
+	 *    (A/B/C/D) is preferred over WORST/LINK, so userspace receives a
+	 *    CHANNEL_A nest instead of LINK.
+	 *  - Signals to tools that "per-pair" data is available (even if there's
+	 *    just one pair), avoiding the impression that only aggregate values
+	 *    are supported.
+	 *  - Remains compatible with multi-pair PHYs and uniform UI handling.
+	 *
+	 * Note: WORST and other channels are not advertised on 10BASE-T1L.
+	 */
+	cap->supported_caps |= PHY_MSE_CHANNEL_A | PHY_MSE_CAP_LINK;
+	cap->max_average_mse = DP83TD510E_MSE_MAX;
+
+	/* The datasheet does not specify the refresh rate or symbol count,
+	 * but based on similar PHYs and standards, we can assume a common
+	 * value. For 10BASE-T1L, the symbol rate is 7.5 MBd. A common
+	 * diagnostic interval is around 1ms.
+	 * 7.5e6 symbols/sec * 0.001 sec = 7500 symbols.
+	 */
+	cap->refresh_rate_ps = 1000000000; /* 1 ms */
+	cap->num_symbols = 7500;
+
+	return 0;
+}
+
+static int dp83td510_get_mse_snapshot(struct phy_device *phydev, u32 channel,
+				      struct phy_mse_snapshot *snapshot)
+{
+	int ret;
+
+	if (channel != PHY_MSE_CHANNEL_LINK &&
+	    channel != PHY_MSE_CHANNEL_A)
+		return -EOPNOTSUPP;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_MSE_DETECT);
+	if (ret < 0)
+		return ret;
+
+	snapshot->average_mse = ret;
+
+	return 0;
+}
+
 static int dp83td510_led_brightness_set(struct phy_device *phydev, u8 index,
 					enum led_brightness brightness)
 {
@@ -893,6 +951,9 @@ static struct phy_driver dp83td510_driver[] = {
 	.get_phy_stats	= dp83td510_get_phy_stats,
 	.update_stats	= dp83td510_update_stats,
 
+	.get_mse_capability = dp83td510_get_mse_capability,
+	.get_mse_snapshot = dp83td510_get_mse_snapshot,
+
 	.led_brightness_set = dp83td510_led_brightness_set,
 	.led_hw_is_supported = dp83td510_led_hw_is_supported,
 	.led_hw_control_set = dp83td510_led_hw_control_set,
-- 
2.47.3



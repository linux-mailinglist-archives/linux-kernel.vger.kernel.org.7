Return-Path: <linux-kernel+bounces-678943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E5AD3055
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD0A165F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1552820CF;
	Tue, 10 Jun 2025 08:30:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59F27FD7E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749544203; cv=none; b=imGZ2gWM2jMLm8fhQhmVZa0Typ8ho06idqdnrsBWQ/2pVjPus8wtJjMq/A9kSibIG29Whir2dT51dfc0cSBagIzqmGVo7pcbVu0grJlnqDaoz0YAymOea/t4SFlAUANNTgswkl3wWyMXEe8YvVaB4jMVFPqXBxSIW61JZYlDTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749544203; c=relaxed/simple;
	bh=womUStL4FmravSMae7BUndIaCWMA0mdK+0Ej0yn5NnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7EflNaNErwN2biSCvmgmsfMDszrA091IeIvML4Nw1rtldiIGfwAWmUxu1lvEWTKI6USLaWSS2t/EEUsfYfI497v1Vl0/a6aX5Lmbx2HplygxSwMCZ2C1eSbRb8Ew8yrwA9C3doNbBI+7YfuXUpSszEmHYDHm95RN0+q5l8MdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4T-0006BF-Dh; Tue, 10 Jun 2025 10:11:01 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4S-002jx3-0Y;
	Tue, 10 Jun 2025 10:11:00 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4S-00G7cZ-0K;
	Tue, 10 Jun 2025 10:11:00 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Jander <david@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 1/3] net: phy: dp83tg720: implement soft reset with asymmetric delay
Date: Tue, 10 Jun 2025 10:10:57 +0200
Message-Id: <20250610081059.3842459-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610081059.3842459-1-o.rempel@pengutronix.de>
References: <20250610081059.3842459-1-o.rempel@pengutronix.de>
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

From: David Jander <david@protonic.nl>

Add a .soft_reset callback for the DP83TG720 PHY that issues a hardware
reset followed by an asymmetric post-reset delay. The delay differs
based on the PHY's master/slave role to avoid synchronized reset
deadlocks, which are known to occur when both link partners use
identical reset intervals.

The delay includes:
- a fixed 1ms wait to satisfy MDC access timing per datasheet, and
- an empirically chosen extra delay (97ms for master, 149ms for slave).

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/phy/dp83tg720.c | 75 ++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 7e76323409c4..2c86d05bf857 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -12,6 +12,42 @@
 
 #include "open_alliance_helpers.h"
 
+/*
+ * DP83TG720 PHY Limitations and Workarounds
+ *
+ * The DP83TG720 1000BASE-T1 PHY has several limitations that require
+ * software-side mitigations. These workarounds are implemented throughout
+ * this driver. This section documents the known issues and their corresponding
+ * mitigation strategies.
+ *
+ * 1. Unreliable Link Detection and Synchronized Reset Deadlock
+ * ------------------------------------------------------------
+ * After a link loss or during link establishment, the DP83TG720 PHY may fail
+ * to detect or report link status correctly. To work around this, the PHY must
+ * be reset periodically when no link is detected.
+ *
+ * However, in point-to-point setups where both link partners use the same
+ * driver (e.g. Linux on both sides), a synchronized reset pattern may emerge.
+ * This leads to a deadlock, where both PHYs reset at the same time and
+ * continuously miss each other during auto-negotiation.
+ *
+ * To address this, the reset procedure includes two components:
+ *
+ * - A **fixed minimum delay of 1ms** after issuing a hardware reset, as
+ *   required by the "DP83TG720S-Q1 1000BASE-T1 Automotive Ethernet PHY with
+ *   SGMII and RGMII" datasheet. This ensures MDC access timing is respected
+ *   before any further MDIO operations.
+ *
+ * - An **additional asymmetric delay**, empirically chosen based on
+ *   master/slave role. This reduces the risk of synchronized resets on both
+ *   link partners. Values are selected to avoid periodic overlap and ensure
+ *   the link is re-established within a few cycles.
+ *
+ * The functions that implement this logic are:
+ * - dp83tg720_soft_reset()
+ * - dp83tg720_get_next_update_time()
+ */
+
 /*
  * DP83TG720S_POLL_ACTIVE_LINK - Polling interval in milliseconds when the link
  *				 is active.
@@ -19,6 +55,10 @@
  *				 the link is down.
  * DP83TG720S_POLL_NO_LINK_MAX - Maximum polling interval in milliseconds when
  *				 the link is down.
+ * DP83TG720S_RESET_DELAY_MS_MASTER - Delay after a reset before attempting
+ *				 to establish a link again for master phy.
+ * DP83TG720S_RESET_DELAY_MS_SLAVE  - Delay after a reset before attempting
+ *				 to establish a link again for slave phy.
  *
  * These values are not documented or officially recommended by the vendor but
  * were determined through empirical testing. They achieve a good balance in
@@ -28,6 +68,8 @@
 #define DP83TG720S_POLL_ACTIVE_LINK		1000
 #define DP83TG720S_POLL_NO_LINK_MIN		100
 #define DP83TG720S_POLL_NO_LINK_MAX		1000
+#define DP83TG720S_RESET_DELAY_MS_MASTER	97
+#define DP83TG720S_RESET_DELAY_MS_SLAVE		149
 
 #define DP83TG720S_PHY_ID			0x2000a284
 
@@ -201,6 +243,26 @@ static int dp83tg720_update_stats(struct phy_device *phydev)
 	return 0;
 }
 
+static int dp83tg720_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_write(phydev, DP83TG720S_PHY_RESET, DP83TG720S_HW_RESET);
+	if (ret)
+		return ret;
+
+	/* Include mandatory MDC-access delay (1ms) + extra asymmetric delay to
+	 * avoid synchronized reset deadlock. See section 1 in the top-of-file
+	 * comment block.
+	 */
+	if (phydev->master_slave_state == MASTER_SLAVE_STATE_SLAVE)
+		msleep(DP83TG720S_RESET_DELAY_MS_SLAVE);
+	else
+		msleep(DP83TG720S_RESET_DELAY_MS_MASTER);
+
+	return ret;
+}
+
 static void dp83tg720_get_link_stats(struct phy_device *phydev,
 				     struct ethtool_link_ext_stats *link_stats)
 {
@@ -477,19 +539,11 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 {
 	int ret;
 
-	/* Software Restart is not enough to recover from a link failure.
-	 * Using Hardware Reset instead.
-	 */
-	ret = phy_write(phydev, DP83TG720S_PHY_RESET, DP83TG720S_HW_RESET);
+	/* Reset the PHY to recover from a link failure */
+	ret = dp83tg720_soft_reset(phydev);
 	if (ret)
 		return ret;
 
-	/* Wait until MDC can be used again.
-	 * The wait value of one 1ms is documented in "DP83TG720S-Q1 1000BASE-T1
-	 * Automotive Ethernet PHY with SGMII and RGMII" datasheet.
-	 */
-	usleep_range(1000, 2000);
-
 	if (phy_interface_is_rgmii(phydev)) {
 		ret = dp83tg720_config_rgmii_delay(phydev);
 		if (ret)
@@ -582,6 +636,7 @@ static struct phy_driver dp83tg720_driver[] = {
 
 	.flags          = PHY_POLL_CABLE_TEST,
 	.probe		= dp83tg720_probe,
+	.soft_reset	= dp83tg720_soft_reset,
 	.config_aneg	= dp83tg720_config_aneg,
 	.read_status	= dp83tg720_read_status,
 	.get_features	= genphy_c45_pma_read_ext_abilities,
-- 
2.39.5



Return-Path: <linux-kernel+bounces-820383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F5DB7D09A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E94F2A0DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD0309F0C;
	Wed, 17 Sep 2025 09:48:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB074342CBE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102492; cv=none; b=AURo1uVNKjpJ72uLJz/P6AwRf0GZcKAxfKVLmtRwaWNEbNY51YLlYc4CCrx0ySw4V65CxLhxlwolFrGch+iNx13H1O5imFV8T76S+AoThXKFHIHh9sG3da/juXIFOpAk+jLs7J+FUEdo97cpi9hqq4X455Tp8DLm5gUm10ivhPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102492; c=relaxed/simple;
	bh=LZfBT4URMH11Jl5GzO1eDEuKsLJO0uRezv7HzJw7xb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDUHSLrYbGjJIMrKP1Ju5QH+6Ru5QfOCvRA7CzX12ChYvBR0LFpwVz+bszRdtMjMo6y9Rq80LW5MNg4DJTTsukIZqcSi5FrzKtWRwBgwgThK2X3lgObV1IkM8QFAMOjVEiHQRzomLVVgoIHAMbNsWXJB7VBpiTx8cBLpE4YcBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uyolW-0002AY-3W; Wed, 17 Sep 2025 11:47:54 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyolV-001jwD-08;
	Wed, 17 Sep 2025 11:47:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uyolU-00000008oe8-41pl;
	Wed, 17 Sep 2025 11:47:52 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v3 1/1] net: phy: clear link parameters on admin link down
Date: Wed, 17 Sep 2025 11:47:51 +0200
Message-ID: <20250917094751.2101285-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
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

When a PHY is halted (e.g. `ip link set dev lan2 down`), several
fields in struct phy_device may still reflect the last active
connection. This leads to ethtool showing stale values even though
the link is down.

Reset selected fields in _phy_state_machine() when transitioning
to PHY_HALTED and the link was previously up:

- speed/duplex -> UNKNOWN, but only in autoneg mode (in forced mode
  these fields carry configuration, not status)
- master_slave_state -> UNKNOWN if previously supported
- mdix -> INVALID (state only, same meaning as "unknown")
- lp_advertising -> always cleared

The cleanup is skipped if the PHY is in PHY_ERROR state, so the
last values remain available for diagnostics.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- rework commit message
- move cleaning sequence to PHY_HALTED case in _phy_state_machine()
changes v2:
- rebase and resned against net-next

 drivers/net/phy/phy.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e046dd858f15..02da4a203ddd 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1548,6 +1548,19 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 		}
 		break;
 	case PHY_HALTED:
+		if (phydev->link) {
+			if (phydev->autoneg == AUTONEG_ENABLE) {
+				phydev->speed = SPEED_UNKNOWN;
+				phydev->duplex = DUPLEX_UNKNOWN;
+			}
+			if (phydev->master_slave_state !=
+						MASTER_SLAVE_STATE_UNSUPPORTED)
+				phydev->master_slave_state =
+						MASTER_SLAVE_STATE_UNKNOWN;
+			phydev->mdix = ETH_TP_MDI_INVALID;
+			linkmode_zero(phydev->lp_advertising);
+		}
+		fallthrough;
 	case PHY_ERROR:
 		if (phydev->link) {
 			phydev->link = 0;
--
2.47.3



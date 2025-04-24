Return-Path: <linux-kernel+bounces-618416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D32C9A9AE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 15:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A65F1B65F12
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE6527C866;
	Thu, 24 Apr 2025 13:02:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8786218AE2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499762; cv=none; b=opY4LLJWK2s9A1cP0qa1u6PFUxrZXXMi7vZVLqSqWWOyHSO3g5tPtzbRVDYrhMdMUiT0u8MO8syTm6/xZLPYyiOdfvENnoyrtmDiFf+VjbrVba8RkrgDGQWFBkidx4ufQ096drpRw80qkANPktHPlEE4wfqIeQuix7OUpoXGRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499762; c=relaxed/simple;
	bh=X0xbmq6mopiAXygxzFtiRf/NAA9I6JQft0huv5sX+5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5o+gxmQX0dseE51xBsB3Lytcz4Zn6r1BQuAju/+QoXfINYsITRYsp/1AsZ3taU5knKi0WWjHMHEXUm4Sq5o2a2ljdjHeW7Ahl6hJWdWV4rKjiS7JfnJR61o5HKIg0c+OGII5ED0WMvBXJ4EMfSz09HzH23ZEyNPdwRDZPSriKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u7wDh-0002ZV-3v; Thu, 24 Apr 2025 15:02:25 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u7wDf-001swI-24;
	Thu, 24 Apr 2025 15:02:23 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u7wDf-00Gc55-1i;
	Thu, 24 Apr 2025 15:02:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v1 3/4] net: phy: Don't report advertised EEE modes if EEE is disabled
Date: Thu, 24 Apr 2025 15:02:21 +0200
Message-Id: <20250424130222.3959457-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424130222.3959457-1-o.rempel@pengutronix.de>
References: <20250424130222.3959457-1-o.rempel@pengutronix.de>
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

Currently, `ethtool --show-eee` reports "Advertised EEE link modes" even when
EEE is disabled, which can be misleading. For example:

  EEE settings for lan1:
          EEE status: disabled
          Tx LPI: disabled
          Supported EEE link modes:  100baseT/Full
                                     1000baseT/Full
          Advertised EEE link modes:  100baseT/Full
                                      1000baseT/Full
          Link partner advertised EEE link modes:  Not reported

This may lead to confusion for users who aren't familiar with kernel internals
but understand that EEE functionality depends on proper advertisement during
link negotiation. Seeing advertised EEE modes in this case might incorrectly
suggest that EEE is still being advertised.

After this change, if EEE is disabled, the output becomes:

  EEE settings for lan1:
          EEE status: disabled
          Tx LPI: disabled
          Supported EEE link modes:  100baseT/Full
                                     1000baseT/Full
          Advertised EEE link modes:  Not reported
          Link partner advertised EEE link modes:  Not reported

This better reflects the actual EEE configuration. The fix ensures
advertised EEE modes are only reported when eee_cfg.eee_enabled is true.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/phy-c45.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index bdd70d424491..8eb12433387d 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1517,7 +1517,8 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 	data->eee_active = phydev->eee_active;
 	linkmode_andnot(data->supported, phydev->supported_eee,
 			phydev->eee_disabled_modes);
-	linkmode_copy(data->advertised, phydev->advertising_eee);
+	if (phydev->eee_cfg.eee_enabled)
+		linkmode_copy(data->advertised, phydev->advertising_eee);
 	return 0;
 }
 EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
-- 
2.39.5



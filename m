Return-Path: <linux-kernel+bounces-720130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6EAFB76F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BEE3BC628
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FD71DB92C;
	Mon,  7 Jul 2025 15:32:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FF72610
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902367; cv=none; b=gc0mFcdjYw0NWSgen2lI0Yf7zVYDAy1/ne50XC/J9Illi9uMkZtM+dSWolTtix0jyuvEb9gQA4i+74ALGDCzJQ4Q6GJVpiSqvz99suDQqahQ1/xuTyg5AL94nIQfZh7hhIpqko/OqQN6X1BK48bOlqh2P7z3Nd/z3RBgtORa1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902367; c=relaxed/simple;
	bh=5Echb8zj2aHQG67ZuO+XMw2fUTv38gNoRuoKlbYv9do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZvXq9dHUSx7OC9VD8Qd6Inbeui9rRPeELAd7NxCR+PNI9iZioNhI1Y1zkfAy59jSZ/Oc3hCTIgDX+t/a1Em3tzcHOqXFmwrz8Vvfh4+c62zKIIlvTHugCf0ttTbRZf+9eKWj1V5oJmhW8rnC6kcsU1PnXo4ApuW1uwjm6zj7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpb-0007aJ-Qr; Mon, 07 Jul 2025 17:32:35 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpa-007GvT-0R;
	Mon, 07 Jul 2025 17:32:34 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpZ-004YFN-36;
	Mon, 07 Jul 2025 17:32:33 +0200
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
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH net v1 1/2] net: phy: enable polling when driver implements get_next_update_time
Date: Mon,  7 Jul 2025 17:32:31 +0200
Message-Id: <20250707153232.1082819-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250707153232.1082819-1-o.rempel@pengutronix.de>
References: <20250707153232.1082819-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Make phylib’s state-machine timer run for drivers that provide
get_next_update_time() but not update_stats().

phy_polling_mode() currently switches to polling only when either
- the PHY runs in interrupt-less mode, or
- the driver exposes update_stats() (needed by several
  statistics-gathering drivers).

Upcoming support for adaptive polling in the SMSC LAN9512/LAN8700 family
relies on get_next_update_time() alone, so the helper must also trigger
polling for that callback. No in-tree drivers have required this until
now, so the change does not alter existing behaviour.

Fixes: 8bf47e4d7b87 ("net: phy: Add support for driver-specific next update time")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 74c1bcf64b3c..b37b981fc9be 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1628,7 +1628,7 @@ static inline bool phy_polling_mode(struct phy_device *phydev)
 		if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
 			return true;
 
-	if (phydev->drv->update_stats)
+	if (phydev->drv->update_stats || phydev->drv->get_next_update_time)
 		return true;
 
 	return phydev->irq == PHY_POLL;
-- 
2.39.5



Return-Path: <linux-kernel+bounces-711259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B003FAEF839
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 14:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F4216A467
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 12:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10D273D76;
	Tue,  1 Jul 2025 12:22:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7E28373
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372520; cv=none; b=EfOMQq6zZfu6fUjkbAQFGncdb4RRysk9dZU1yerymNQV7ORpSgAYyQ1Sv8BnyFB42RnWhmkgRB6UtM2jEF52RpfoM3I/Qk7hjMYRJXa2VAViLEKMONKFamdnR3R7/VgQGMPjGg7PR1AcjgsIesE8iG4p3bEyHVtQBqmbkrOfxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372520; c=relaxed/simple;
	bh=eSDv5lNnaaHDCNYMnyrzvsMt3cx1EZuw6AXE2orFyUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZuGF5JUreLfUU+pbD8Af/x5Z8nND1NtcphlWuWLkvFFm99qealorAxrGc4X3TU+v4XmuojGWOZsY5Db6aQa6Q1dNFBAaBpmwG6g4VFN84IfVy8dZoduca0muQGXMhlzlbHH/WsqUHLbpvBQtOaNU9u0Luqx5Z5/rPOqZu03Ba6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzh-0007K0-6S; Tue, 01 Jul 2025 14:21:49 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzf-006GdD-29;
	Tue, 01 Jul 2025 14:21:47 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzf-0009GI-1s;
	Tue, 01 Jul 2025 14:21:47 +0200
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
Subject: [PATCH net v1 0/4] net: phy: smsc: robustness fixes for LAN87xx/LAN9500
Date: Tue,  1 Jul 2025 14:21:42 +0200
Message-Id: <20250701122146.35579-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

Hi all,

The SMSC 10/100 PHYs (LAN87xx family) found in smsc95xx (lan95xx)
USB-Ethernet adapters show several quirks around the Auto-MDIX feature:

- A hardware strap (AUTOMDIX_EN) may boot the PHY in fixed-MDI mode, and
  the current driver cannot always override it.

- When Auto-MDIX is left enabled while autonegotiation is forced off,
  the PHY endlessly swaps the TX/RX pairs and never links up.

- The driver sets the enable bit for Auto-MDIX but forgets the override
  bit, so userspace requests are silently ignored.

- Rapid configuration changes can wedge the link if PHY IRQs are
  enabled.

The four patches below make the MDIX state fully predictable and prevent
link failures in every tested strap / autoneg / MDI-X permutation.

Tested on LAN9512 Eval board.

Best Regards,
Oleksij

Oleksij Rempel (4):
  net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
  net: phy: smsc: Force predictable MDI-X state on LAN87xx
  net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
  net: phy: smsc: Disable IRQ support to prevent link state corruption

 drivers/net/phy/smsc.c | 61 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 9 deletions(-)

--
2.39.5



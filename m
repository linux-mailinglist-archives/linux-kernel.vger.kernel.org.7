Return-Path: <linux-kernel+bounces-808231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC5B4FC21
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B14C3B4AE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E3340D87;
	Tue,  9 Sep 2025 13:13:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C7255F5E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423582; cv=none; b=Pbx0qRX5bMQAH441BoQOhfL6FY8vGbHTIHieEpJoV2+CGDKxXubgxAmugeFeSWgZW9ouxdhn+4KUPugLVJCc4hWdqv/uReC0E5z7hSbthvKCxqMyXJnzSFlYt9lz/YyQt0MjmuIErXprYTwynMLwy1E++VDJPDRoU6Hzzaibyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423582; c=relaxed/simple;
	bh=6qQ3DItVAex3a+IFW57jqNRLGBgS5DJ1kwYkirTXp/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sN+NbYzinR1t89kPH841ZmE/tKra5QSmCbG7q5xBinMFTmlNQsSH3XPgSfILL/PsK9qOemk8mLHJwQBVPY0+H6OGEeSLQMQlBSPujPjU1qFXZMvsrzIPp/IAkGptWBm9V0PhOHZK1wQF6FDNxIRGnd4v3XBSSLblhoQN+g+rH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvy9T-0003qv-9v; Tue, 09 Sep 2025 15:12:51 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvy9R-000QbE-2T;
	Tue, 09 Sep 2025 15:12:49 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uvy9R-0000000HPAU-2vA7;
	Tue, 09 Sep 2025 15:12:49 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 1/1] net: phy: clear EEE runtime state in PHY_HALTED/PHY_ERROR
Date: Tue,  9 Sep 2025 15:12:48 +0200
Message-ID: <20250909131248.4148301-1-o.rempel@pengutronix.de>
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

Clear EEE runtime flags when the PHY transitions to HALTED or ERROR
and the state machine drops the link. This avoids stale EEE state being
reported via ethtool after the PHY is stopped or hits an error.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Related discussion: https://lore.kernel.org/r/aKg7nf8YczCT6N0O@shell.armlinux.org.uk
---
 drivers/net/phy/phy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 13df28445f02..b8963d26af26 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1555,6 +1555,8 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 	case PHY_ERROR:
 		if (phydev->link) {
 			phydev->link = 0;
+			phydev->eee_active = false;
+			phydev->enable_tx_lpi = false;
 			phy_link_down(phydev);
 		}
 		state_work = PHY_STATE_WORK_SUSPEND;
--
2.47.3



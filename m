Return-Path: <linux-kernel+bounces-727344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D2CB018B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A697E7658DA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DBB27FB26;
	Fri, 11 Jul 2025 09:49:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AA27E043
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227362; cv=none; b=cYpZdzAkpQgOxeb4PFpOXmZqVh1Dqel6aoyPCWstRS1wxg39egyDkVPQASLPscGfC/xT6ALUkXTmBKutno1XpVUC1rQHSNBiIp7Eyi+p30C/3wQlKZszhNBUPZ+N/2q/XjB8wplRQBW9RV+cnNbtK+incdTsxI8/lcNjcj0ycrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227362; c=relaxed/simple;
	bh=z7zcbjKhSKUviabBl30iOgZwAH/q4ejRejd08eNu8KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mljajL6LfcWApRhLelsXai0MbRSCrnosdM3rc6QPHYijON4Qln5OxgItuScm7e9MrThSFQpzSvbhDXsl+lkeViljIyivBSPlq1r6bpmScM/gfaLWu4LS1PkgBCJdVUjPAp+dznCIEnpxz5Cy0cQZ04zOALKiN8aBaPBrkKO4u6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uaANU-0007fV-6b; Fri, 11 Jul 2025 11:49:12 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uaANS-007tqH-1L;
	Fri, 11 Jul 2025 11:49:10 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uaANS-004YgH-16;
	Fri, 11 Jul 2025 11:49:10 +0200
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
Subject: [PATCH net v3 1/3] net: phy: enable polling when driver implements get_next_update_time
Date: Fri, 11 Jul 2025 11:49:07 +0200
Message-Id: <20250711094909.1086417-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711094909.1086417-1-o.rempel@pengutronix.de>
References: <20250711094909.1086417-1-o.rempel@pengutronix.de>
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

Currently, phy_polling_mode() enables polling only if:
- the PHY is in interrupt-less mode, or
- the driver provides an update_stats() callback.

This excludes drivers that implement get_next_update_time()
to support adaptive polling but do not provide update_stats().
As a result, the state machine timer will not run, and the
get_next_update_time() callback is never used.

This patch extends the polling condition to include drivers that
implement get_next_update_time(). This change is required to support
adaptive polling in the SMSC LAN9512/LAN8700 PHY family, which cannot
reliably use interrupts.

No in-tree drivers rely on this mechanism yet, so existing behavior is
unchanged. If any out-of-tree driver incorrectly implements
get_next_update_time(), enabling polling is still the correct behavior.

Fixes: 8bf47e4d7b87 ("net: phy: Add support for driver-specific next update time")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
changes v2:
- update commit message
---
 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4c2b8b6e7187..2688c0435b9b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1636,7 +1636,7 @@ static inline bool phy_polling_mode(struct phy_device *phydev)
 		if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
 			return true;
 
-	if (phydev->drv->update_stats)
+	if (phydev->drv->update_stats || phydev->drv->get_next_update_time)
 		return true;
 
 	return phydev->irq == PHY_POLL;
-- 
2.39.5



Return-Path: <linux-kernel+bounces-720458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0682AFBC05
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A7E177AAF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884EF267AF1;
	Mon,  7 Jul 2025 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ufujgqru"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB320ED
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918314; cv=none; b=gY9f26vFINXzvSN/mQLuj/aOulo3EYwXbCGLq02vG6YiQmEElRV4uIm3QaOZl4/1O9wks0/tfOXdiu4TP0qrsFBSKqlQo5LqpsVIKEEMfJWYn/C0uzk9WFq90oNmhEClV3RmNaBJ7EDWGAYgLml1CjkgId+tfaOqnEvkImIKMbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918314; c=relaxed/simple;
	bh=wznz3Z05KE3+tZK0Ya4RD2mYFhA5mOms+wEdmOwiNZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bytIqvvl64vjksHJMfWaT1NgeU/UGe71m+EAEvCTnAEGpMbw0mJuzCVtWkbWlUcmTdR+/xPB1VZhD4fGCpANxNN7BUf4LvVd0tMKxkNzrVm015DlbcOXkeeIugM2XhrMH19kerS9eyxiEOfrEuDoU7zdh1O37ab/10DeccVwkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ufujgqru; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751918300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=65BJl8ocG1KQAiuDzNGpuZkOHdbRIob/5tkT9VskyOU=;
	b=ufujgqruNCdnVsqsIAmE7PUddGAsWLhDKkjAB9eeMyUQzRuY4wslgRKnzb/ka+bfBal9Aw
	HonzuD2F2PGzqhA3np/ZTnpFGazLrljjC1SQkF4Ey6J+VWLaRPOa6Ddv8RkE+40ueeT1Bw
	WDv8pv28rRvBTrG98gQ/ha3Qlvjllig=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net] net: phy: Don't register LEDs for genphy
Date: Mon,  7 Jul 2025 15:58:03 -0400
Message-Id: <20250707195803.666097-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If a PHY has no driver, the genphy driver is probed/removed directly in
phy_attach/detach. If the PHY's ofnode has an "leds" subnode, then the
LEDs will be (un)registered when probing/removing the genphy driver.
This could occur if the leds are for a non-generic driver that isn't
loaded for whatever reason. Synchronously removing the PHY device in
phy_detach leads to the following deadlock:

rtnl_lock()
ndo_close()
    ...
    phy_detach()
        phy_remove()
            phy_leds_unregister()
                led_classdev_unregister()
                    led_trigger_set()
                        netdev_trigger_deactivate()
                            unregister_netdevice_notifier()
                                rtnl_lock()

There is a corresponding deadlock on the open/register side of things
(and that one is reported by lockdep), but it requires a race while this
one is deterministic.

Generic PHYs do not support LEDs anyway, so don't bother registering
them.

Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/phy/phy_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73f9cb2e2844..f76ee8489504 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3416,7 +3416,8 @@ static int phy_probe(struct device *dev)
 	/* Get the LEDs from the device tree, and instantiate standard
 	 * LEDs for them.
 	 */
-	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
+	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev) &&
+	    !phy_driver_is_genphy_10g(phydev))
 		err = of_phy_leds(phydev);
 
 out:
@@ -3433,7 +3434,8 @@ static int phy_remove(struct device *dev)
 
 	cancel_delayed_work_sync(&phydev->state_queue);
 
-	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
+	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev) &&
+	    !phy_driver_is_genphy_10g(phydev))
 		phy_leds_unregister(phydev);
 
 	phydev->state = PHY_DOWN;
-- 
2.35.1.1320.gc452695387.dirty



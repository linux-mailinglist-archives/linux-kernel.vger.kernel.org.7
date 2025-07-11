Return-Path: <linux-kernel+bounces-727340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2CB018B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB0B7662C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7071A27D781;
	Fri, 11 Jul 2025 09:49:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB827C15A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227361; cv=none; b=mbomd4dfokgIyBM18Vau1VXPEzTfEjNCIfdq5Jiytzt/x6R4AsyAP1wbkpsg45OOyYjTYBESjlSEmpGSrlLUyhF87t8e7ofFBrivKk3xcwYHJ5LWmO+Zt3IcLCDFx+lrtZvS6iGh3w/6RzKTXqQfUIH9iVjGj7O+I1SN5lEEunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227361; c=relaxed/simple;
	bh=y5RotNcW0Y5gIVty/I/E5cUGKRe0IULGdW19fLqEzdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tGcDc1DoBJYmjZC6ObnNU+Mr6jtxAGgMNfvXpLKHuEzfPqieq21MOONTZfXMXm0g59EwYkV51ylU+ovMXGhTuR1YGpHJncq39der4GeEX5G8eFTgMnn2D2X9MKerFB3NjPbJ0/2gpHIC2mGYAHzkLduClDDJrWbPQhxXphBpydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uaANU-0007fU-6b; Fri, 11 Jul 2025 11:49:12 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uaANS-007tqG-1E;
	Fri, 11 Jul 2025 11:49:10 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uaANS-004Yg7-11;
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
Subject: [PATCH net v3 0/3] net: phy: smsc: use IRQ + relaxed polling to fix missed link-up
Date: Fri, 11 Jul 2025 11:49:06 +0200
Message-Id: <20250711094909.1086417-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

This series makes the SMSC LAN8700 (as used in LAN9512 and similar USB
adapters) reliable again in configurations where it is forced to 10 Mb/s
and the link partner still advertises autonegotiation.

In this scenario, the PHY may miss the final link-up interrupt, causing
the network interface to remain down even though a valid link is
present.

To address this:

Patch 1 – phylib: Enable polling if the driver implements
get_next_update_time(). This ensures the state machine is active even
without update_stats().

Patch 2 – phylib: Allow drivers to return PHY_STATE_IRQ to explicitly
disable polling.

Patch 3 – smsc: Implement get_next_update_time() with adaptive 1 Hz
polling for up to 30 seconds after the last interrupt in the affected
10M autoneg-off mode.  All other configurations rely on IRQs only.

Testing:

The LAN9512 (LAN8700 core) was tested against an Intel I350 NIC using
baseline, parallel-detection, and advertisement test suites. All
relevant tests passed.

Changes in v3:
- handle conflicting configuration if update_stats are supported

Changes in v2:
- Introduced explicit disable polling via PHY_STATE_IRQ
- Changed the workaround logic to apply 1 Hz polling only for 30 seconds
  after the last IRQ
- Dropped relaxed 30s polling while link is up
- Reworded commit messages and comments to reflect updated logic
- Split core changes into two separate patches for clarity

Thanks,
Oleksij Rempel

Oleksij Rempel (3):
  net: phy: enable polling when driver implements get_next_update_time
  net: phy: allow drivers to disable polling via get_next_update_time()
  net: phy: smsc: recover missed link-up IRQs on LAN8700 with adaptive
    polling

 drivers/net/phy/phy.c  | 27 ++++++++++++++++++++-------
 drivers/net/phy/smsc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/phy.h    | 17 +++++++++++++++--
 3 files changed, 75 insertions(+), 9 deletions(-)

--
2.39.5



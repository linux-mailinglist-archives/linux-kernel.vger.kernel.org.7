Return-Path: <linux-kernel+bounces-720129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC48AFB76D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A182F4A43B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F119F461;
	Mon,  7 Jul 2025 15:32:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C34A1D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902367; cv=none; b=oVU1ECY/SvQNKkJWyeErPolknSMpIhYe9YXBZxAIda9IQdgtMiet8uds1Ur8qg3qjmvyvpInfu/THiglDAXWR0yrL6HQTdBGYtf1jzKGBhHWrNkucIk2oblRc4j5o6kRjs11Cn2uUG3W4ML3vpTG3sABtZZQd3M6NTqgJFm/UUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902367; c=relaxed/simple;
	bh=3H0CG6IpeGFzd6/CFArKmAex/IIH+zHe8rbOipSW5EY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=brkBj5LunByEv7JMM5TTDT1BocLhZMLogHXWziyt3VYcTzmU88EnSwy6AzM83P2BSxv6MsM11p9SvMNEiu9Cpo1zaSLCXST1M+HkIUxTpMpb9I8yGX/z+sBK901OnOvP61zi7tCEA42MqcIBq0RnIvIGZsul+Y9Rd+rZyMKJkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpb-0007aI-Qr; Mon, 07 Jul 2025 17:32:35 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpa-007GvS-0E;
	Mon, 07 Jul 2025 17:32:34 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpZ-004YEe-30;
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
Subject: [PATCH net v1 0/2] net: phy: smsc: use IRQ + relaxed polling to fix missed link-up
Date: Mon,  7 Jul 2025 17:32:30 +0200
Message-Id: <20250707153232.1082819-1-o.rempel@pengutronix.de>
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

This series makes the SMSC LAN8700 (LAN9512) family reliable again
when it is forced to 10 Mb/s and the link partner still advertises
autonegotiation:

Patch 1 – core: treat get_next_update_time() as a reason to keep
the phylib timer running.

Patch 2 – smsc-phy: combine the existing interrupt line with a new
adaptive poll:
- poll every 1 s while the link is down or for 30 s after the last
  interrupt (catches the silent link-up),
- poll only every 30 s once the link is up (reduces wake-ups and saves
  power).  IRQs are still delivered immediately, so genuine link changes
  are reported with minimal latency.

Testing:
Baseline, parallel-detection and advertisement test suites were run on a
LAN9512 (LAN8700 core) against an Intel I350 NIC. All relevant tests
passed.

Thanks,
Oleksij Rempel

Oleksij Rempel (2):
  net: phy: enable polling when driver implements get_next_update_time
  net: phy: smsc: add adaptive polling to recover missed link-up on
    LAN8700

 drivers/net/phy/smsc.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy.h    |  2 +-
 2 files changed, 44 insertions(+), 1 deletion(-)

--
2.39.5



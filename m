Return-Path: <linux-kernel+bounces-679024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32111AD317D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 11:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0EB7A96C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9628B415;
	Tue, 10 Jun 2025 09:14:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97E28B3EB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546846; cv=none; b=FcW0/CyxAMA9gzAfWc4W72mHsJfXjsIhHVvU19+KsjydYYf7cp6MQ/iAcQ3dkKEGudnWME8xl7QcD6JzbYcrcvRxwjx+6BV+HVg2gsyPsRMRg6xUklkqfNr6DHa1wI88vueMAF9mbLuk3tsNKfoi6qnzcRJjGygohulYC2Yb2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546846; c=relaxed/simple;
	bh=eAP/Pgxs/9S4eWPhajMtCxZYCSMA8XaOpnWO4Mni19I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sgoTtV17VqnKaRBk4aF2ayFn87WFP6zoKwPtvi3MMPYR3i+mfWXpFk4S4r+ZUIM6OBXScs4E/Lc4WoTDCvUKGp7CB3NNQehSG70ISkQrxQt0sLML2O3zv+6kxyL+VKySJW71s50uJ5/+pNT6AiglTgFcp/jAr8LXGCbTagbzDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uOv3M-000487-VW; Tue, 10 Jun 2025 11:13:57 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOv3L-002kQH-1d;
	Tue, 10 Jun 2025 11:13:55 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOv3L-00H2Jv-1O;
	Tue, 10 Jun 2025 11:13:55 +0200
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
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 0/3] net: phy: micrel: add extended PHY support for KSZ9477-class devices
Date: Tue, 10 Jun 2025 11:13:51 +0200
Message-Id: <20250610091354.4060454-1-o.rempel@pengutronix.de>
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

Hi all,

This patch series extends the PHY driver support for the Microchip
KSZ9477-class switch-integrated PHYs. These changes enhance ethtool
functionality and diagnostic capabilities by implementing the following
features:
- MDI/MDI-X configuration support
  All crossover modes (auto, MDI, MDI-X) are now configurable.

- RX error counter reporting
  The RXER counter (reg 0x15) is now accumulated and exported via
ethtool stats.

- Cable test support
  Reuses the KSZ9131 implementation to enable open/short fault
detection and approximate fault length reporting.

Oleksij Rempel (3):
  net: phy: micrel: add MDI/MDI-X control support for KSZ9477
    switch-integrated PHYs
  net: phy: micrel: Add RX error counter support for KSZ9477
    switch-integrated PHYs
  net: phy: micrel: add cable test support for KSZ9477-class PHYs

 drivers/net/phy/micrel.c | 111 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

--
2.39.5



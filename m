Return-Path: <linux-kernel+bounces-747216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48258B1310E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E4E1896DA7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E751225388;
	Sun, 27 Jul 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="tPlwoUvE"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2C221F00
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639408; cv=none; b=G0yxK+4x+e7J59ppB2XINARWFqCMorxkjWp5R8fjQCjCdliM1JZsLCekYBIdUtpCuiOX0rKx4qGHuNzTgtEBBTjnGCFGmHH6nSjxtNu6+1kksQp6SZzXpHNHn4QjxDx45Ak5LpJIleOZbGLUx+YKq/9ud3GgnUH9oxF4nt5FbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639408; c=relaxed/simple;
	bh=PIAw8y1W5w8r1TtfFn1teWoNJMydjl0fp+DD/lIPseQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWDEXdC91eiyjSeFFdb3JeFM67K6YvKCqtAaFZWiC2DVO8Zbya8lgfESVUkb/KV1E1+SgO37AKSvEjPozST4AnJyomPyV4U3yoLe5lb9S2pnPbF85ZlDarRFS81jQOFTFA954Zr3iwScs895z91jqy5GHSLUAEwdelrxUF6+6jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=tPlwoUvE; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1753639405;
 bh=3C4qr/FhtbdmuHtZf4xYJuWPpDOV55jd2UZ3CTOGfBc=;
 b=tPlwoUvEkcUYseKyG2xvdF020KyQtFVogedEq23KgflTbn0oDbKLcDx5PBmITEw8wE4vviyQG
 lcHkvQCuh66r+ytZDCDRUHj/sdij2p2q0QzTLrnc7jd0BoJ8B/TukA9Mh2+EcMLFchtWP2VD4sb
 OmiO40JnVErpFJyyztlnw8EVwUPAaVYlvpZxgzKN/s5WmX65t+wmKsMldWIpRzTa0gVQyhUFKkR
 WsFNhHGv/m2Y2RxjUkkQj4JrPBhRv97bbIaoFfUWyAX1/wnrQ0E+mAFRGKWcpMuaD3XvenW7Ste
 tbEZsYbki+bUQjeDrEGklS2A3AI5FTGU6hq6he2D4/5w==
X-Forward-Email-ID: 688669dfc509b9ee169cf2fc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Heiko Stuebner <heiko@sntech.de>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH net-next 0/3] net: dsa: realtek: Add support for use of an optional mdio node
Date: Sun, 27 Jul 2025 18:02:57 +0000
Message-ID: <20250727180305.381483-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Radxa E24C, a Rockchip RK3528A based device, uses a MDIO-connected
RTL8367RB-VB switch to expose four Ethernet ports on the device.

Trying to describe this switch in the device tree in a way that makes
it work for the driver results in dtschema complaining that use of an
mdio child OF node is not allowed.

This series relaxes the realtek dsa drivers requirement of having a mdio
child OF node to probe and instead have it register a user_mii_bus to
make it function when a mdio child OF node is missing.

Another option could also be to adjust the dt-bindings schema to allow
use of a mdio child OF node for MDIO-connected switches.

With this series dtschema is happy and the switch can work:

  rtl8365mb-mdio stmmac-0:1d: found an RTL8367RB-VB switch
  rtl8365mb-mdio stmmac-0:1d: configuring for fixed/rgmii-id link mode
  rtl8365mb-mdio stmmac-0:1d: Link is Up - 1Gbps/Full - flow control off
  rtl8365mb-mdio stmmac-0:1d wan (uninitialized): PHY [stmmac-0:1d:user_mii:00] driver [RTL8365MB-VC Gigabit Ethernet] (irq=74)
  rtl8365mb-mdio stmmac-0:1d lan1 (uninitialized): PHY [stmmac-0:1d:user_mii:01] driver [RTL8365MB-VC Gigabit Ethernet] (irq=75)
  rtl8365mb-mdio stmmac-0:1d lan2 (uninitialized): PHY [stmmac-0:1d:user_mii:02] driver [RTL8365MB-VC Gigabit Ethernet] (irq=76)
  rtl8365mb-mdio stmmac-0:1d lan3 (uninitialized): PHY [stmmac-0:1d:user_mii:03] driver [RTL8365MB-VC Gigabit Ethernet] (irq=77)
  rtl8365mb-mdio stmmac-0:1d wan: configuring for phy/gmii link mode
  rtl8365mb-mdio stmmac-0:1d wan: Link is Up - 1Gbps/Full - flow control off

The device tree changes builds on top of the "arm64: dts: rockchip: Add
Radxa E24C" series at [1].

[1] https://lore.kernel.org/r/20250727144409.327740-1-jonas@kwiboo.se

Jonas Karlman (3):
  net: dsa: realtek: remove unused user_mii_bus from realtek_priv
  net: dsa: realtek: Add support for use of an optional mdio node
  arm64: dts: rockchip: Add RTL8367RB-VB switch to Radxa E24C

 .../boot/dts/rockchip/rk3528-radxa-e24c.dts   | 55 +++++++++++++++++++
 drivers/net/dsa/realtek/realtek.h             |  1 -
 drivers/net/dsa/realtek/rtl83xx.c             | 28 ++++++++--
 3 files changed, 77 insertions(+), 7 deletions(-)

-- 
2.50.1



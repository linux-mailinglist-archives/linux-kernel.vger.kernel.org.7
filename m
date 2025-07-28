Return-Path: <linux-kernel+bounces-747837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8ADB138F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1613B6CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41801223335;
	Mon, 28 Jul 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dHDeHco/"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42628FD;
	Mon, 28 Jul 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698634; cv=none; b=UBo+XN/p5jDt2RGsIsxAcygpoB00VlyQfPvjw6srZyy6WWQKBvrMae3rNOdSNIv6onBCfG/eJhNIEdFZd050rpxiHTkkixGwUf747EQdj5O1TouAEZTLlfW9RIaqrXv5i1OpYXJTQFFbqRv06P/B6Cn86LQpR0uBctKzuHdHq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698634; c=relaxed/simple;
	bh=jSpz3ZqNo1DKtrmKgUQO2U/uGqVFys+hvUVK/NIUdzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyiBXQXmReBPhT/A+PdF5r6iKEss3fGo5beHNcbx1+YF2YHelEljjANNjkCwEfjYmW8os8262iBzpHJIv5GR6LUjMVk6bS7gtq3AKh4JgJ1blPdl5VV33urMAOE8XPJfR6j6U3yuY3zuT0VNqe2ZHTo/Mmb6AATzIMb9TwvZ76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dHDeHco/; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D60E42072F;
	Mon, 28 Jul 2025 12:30:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hQED-crO9Jye; Mon, 28 Jul 2025 12:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753698628; bh=jSpz3ZqNo1DKtrmKgUQO2U/uGqVFys+hvUVK/NIUdzI=;
	h=From:To:Cc:Subject:Date;
	b=dHDeHco/I06vbOKOHf9r4qBuYKA+HL6FmDa+OWPx+LnVskHS9RjpRbPO+GvM/aqOg
	 Iz14cNCW/uyV3J0UDEsvnSCWyc5ee0YjrlmWCFADoyz66AiMFCwAT9iizw4/u1aZIz
	 wdn1WgcEjZSp3qj2p8BGuyFu3Kxl6R26a57OtzkahrzTo+qt3BvR88Qk7sWRZ2Qd1K
	 c88yC4OO0TtjIHPuiLIEtJsvWZOy7SyiwoP+y9pGE92FgJtWvvDXBhrwWMhRsdSKJo
	 rEsRNYSom8RO+gaE8rHrCIgAWJrZpPc056xbwOg1jnP8KHSj0X2yTGj6s9zDMFzPO+
	 m5Cc3kT/1DzWw==
From: Yao Zi <ziyao@disroot.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] Support RK3528 variant of Rockchip naneng-combphy
Date: Mon, 28 Jul 2025 10:29:42 +0000
Message-ID: <20250728102947.38984-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 ships a naneng-combphy that operates in either PCIe or
USB 3.0 mode. It has a similar control logic to previous generations of
naneng-combphy but an apparently different register layout.

This series prepares phy-rockchip-naneng-combphy.c for variants with a
different register layout and add RK3528 support.

Testing is done on both Radxa E20C and Radxa Rock 2A with downstream           devicetree changes, both USB 3 and PCIe modes are verified with mainline
driver, and reach a reasonable speed.

This series depends on patch "phy: rockchip: naneng-combphy: Enable U3
OTG port for RK3568"[1], and the dts patch depends on v2 of patch
"arm64: dts: rockchip: convert rk3528 power-domains to dt-binding
constants"[2] to build.

[1]: https://lore.kernel.org/all/20250723072324.2246498-1-jonas@kwiboo.se/
[2]: https://lore.kernel.org/all/20250620201715.1572609-1-heiko@sntech.de/

Changed from v4
- Collect review tags
- Add extra handling of USB3OTG_CON1 when operating in USB3 mode
- Link to v4: https://lore.kernel.org/all/20250624033733.50197-1-ziyao@disroot.org/
Changed from v3
- Add a dt-binding patch to allow power-domains property when describing
  Rockchip naneng combphys
- devicetree patch
  - Break down long lines
  - Sort properties to keep the style consistent
  - Add power-domains property to the combphy node
- Link to v3: https://lore.kernel.org/linux-rockchip/20250519161612.14261-1-ziyao@disroot.org/
Changed from v2
- phy binding patch
  - Fix format issue
  - drop review tags
- Link to v2: https://lore.kernel.org/all/20250509004121.36058-2-ziyao@disroot.
org/
Changed from v1
- Collect review tags
- Restyle RK3528 register definitions in the combphy driver
- Drop unused include of phy.h in SoC devicetree
- Link to v1: https://lore.kernel.org/all/20250508134332.14668-2-ziyao@disroo
t.org/

Yao Zi (6):
  dt-bindings: soc: rockchip: Add RK3528 pipe-phy GRF syscon
  dt-bindings: phy: rockchip: naneng-combphy: Add power-domains property
  dt-bindings: phy: rockchip: naneng-combphy: Add RK3528 variant
  phy: rockchip: naneng-combphy: Add SoC prefix to register definitions
  phy: rockchip: naneng-combphy: Add RK3528 support
  arm64: dts: rockchip: Add naneng-combphy for RK3528

 .../phy/phy-rockchip-naneng-combphy.yaml      |   8 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml |   1 +
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      |  24 +
 .../rockchip/phy-rockchip-naneng-combphy.c    | 749 +++++++++++-------
 4 files changed, 508 insertions(+), 274 deletions(-)

-- 
2.50.1



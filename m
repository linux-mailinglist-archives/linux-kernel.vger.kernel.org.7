Return-Path: <linux-kernel+bounces-799154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7710B427CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A8B3BA79B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A816320CB4;
	Wed,  3 Sep 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLJUyjSz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3CA29DB99;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919953; cv=none; b=EtVebycEr7CnTNw/3VGCo+DJP8d5h/y/HkBQYdt/cYZeeUVKogtdPywKBdPRr24XYiQrFtNG5V2Y+xoTyKfUZGmiiSybtbsm9egQWUVPJGS6gVDe2GoJSWdEVFxzPagL2h9ZP5EmXCAHbMiT/1AfaTMz0QJvYah7jjuxzsQq/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919953; c=relaxed/simple;
	bh=Sp1oVh07PV5J1vHgtpAOsZp9J99yIuyi/v/VuN5rhXY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g6AWRFQ4yfdubC8F98Wh2S9UaoGQysrytPenK+83ACDx/NmkJYoj5l1lbm4WclWtWPx7A0K7+0/16UnJU38wK59OfB26G2XJ5oOg1xiQ+A2KFjW+L6MqljGH48X6O6eI4xZeCrD40sANG9g/GVxeGqiDiDQDojzIOFce4U3bj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLJUyjSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FF96C4CEE7;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756919953;
	bh=Sp1oVh07PV5J1vHgtpAOsZp9J99yIuyi/v/VuN5rhXY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nLJUyjSz1A3QYo+DKInQOEKZrKIxS2wQCAU/CJs5YUCPXejgY635za65x8RyRjCY5
	 VLuGU6xqlHhZOhSijyqsetXiCYcB5JeM1JA+FT3B88wP3nNd+b0kiFX3YIiK/FIQzy
	 04/AqhKDWH14nflHPiuhfmnOe3fahs/8afgZqw3bPu2VPDaddL1aGwzHEA2h+/5Yyg
	 ohk2eaF9RBVjAjZUzBjJCiqDR0l72Xv6MHZXFCZlX1B1eWStndFmvakn5j0/94xNKh
	 SiYArxA6L0zoFqp815kwje5X3ISWHMDwRFqsrhEzG+ai+HwPPZm7Am0lSAxUOZoczB
	 ZH4BFV0XGDDNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F90CA0FF2;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Subject: [PATCH v4 0/7] phy: rockchip: phy-rockchip-inno-csidphy: add
 support for rk3588 variant
Date: Wed, 03 Sep 2025 19:04:48 +0200
Message-Id: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADB1uGgC/4XNTQ7CIBCG4as0rMXw10JdeQ/jAgawRC0NmMam6
 d2lXRpNl++XzDMzyi4Fl9GpmlFyY8gh9iXEoULQ6f7mcLClESOsJg1tcLrzWikMOWA7dBOG1lm
 mrQDbelSuhuR8eG/i5Vq6C/kV07Q9GOm6/rdGiglWwhlumJa8gTPEx0ObmPQR4hOt3sh2DFYMq
 VvhiWyNpOyXwXcMXgxdA9jaUy+4+jaWZfkApc8QXjoBAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Collabora Kernel Team <kernel@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, 
 Michael Riesch <michael.riesch@collabora.com>, stable@kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756919100; l=2751;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=Sp1oVh07PV5J1vHgtpAOsZp9J99yIuyi/v/VuN5rhXY=;
 b=6NCRuBLPC+EN/UwAOUVq62wlOgaZhr5BntQTg7A08B7KaV3CqcIuHyxpxS4zRDkiBeOAmpxWv
 CdsHYjMsTyWAa8YaBkBU/u+ViTzmhn/1Z4nhnjnBDbcw7n9svQkPeKq
X-Developer-Key: i=michael.riesch@collabora.com; a=ed25519;
 pk=+MWX1fffLFZtTPG/I6XdYm/+OSvpRE8D9evQaWbiN04=
X-Endpoint-Received: by B4 Relay for michael.riesch@collabora.com/20250410
 with auth_id=371
X-Original-From: Michael Riesch <michael.riesch@collabora.com>
Reply-To: michael.riesch@collabora.com

Habidere,

The Rockchip RK3588 features two MIPI CSI-2 DPHYs (not to be confused with
the two combo MIPI DSI/CSI CPHY/DPHY blocks). The CSI-2 DPHYs can be
supported using the existing phy-rockchip-inno-csidphy driver, the notable
differences being
 - the control bits in the GRF
 - the additional reset line
This patch series adds support for this variant.

As you may have guessed, this is part of the efforts to bring the support
for the RK3588 Video Capture (VICAP) unit mainline.

Looking forward to your comments!

Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
---
Changes in v4:
- fixed commit message "false negatives" -> "false positives"
- fixed mipi csi dphy node addition -> mipidcphy1 remains as-is now
- moved allOf: block after required: block (Krzysztof)
- added remark w.r.t. the description of the original reset (Krzysztof)
- name of the new reset remains "phy" as I didn't find any better
  name. Suggestions welcome! (Krzysztof)
- Link to v3: https://lore.kernel.org/r/20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com

Changes in v3:
- added if:then: for required 'power-domains' (Krzysztof)
- fixed restriction of resets/reset-names (Rob)
- Link to v2: https://lore.kernel.org/r/20250616-rk3588-csi-dphy-v2-0-7a94f079b712@collabora.com

Changes in v2:
- rebased onto v6.17-rc1
- added patch that makes 'power-domains' non-required (Diederik)
- added patch that allows for different sets of resets (Neil)
- introduced name for additional reset line (Neil)
- fixed example in bindings (Rob, Diederik)
- Link to v1: https://lore.kernel.org/r/20250616-rk3588-csi-dphy-v1-0-84eb3b2a736c@collabora.com

---
Michael Riesch (7):
      dt-bindings: soc: rockchip: add rk3588 csidphy grf syscon
      dt-bindings: phy: rockchip-inno-csi-dphy: make power-domains non-required
      dt-bindings: phy: rockchip-inno-csi-dphy: add rk3588 variant
      phy: rockchip: phy-rockchip-inno-csidphy: allow writes to grf register 0
      phy: rockchip: phy-rockchip-inno-csidphy: allow for different reset lines
      phy: rockchip: phy-rockchip-inno-csidphy: add support for rk3588 variant
      arm64: dts: rockchip: add mipi csi-2 dphy nodes to rk3588

 .../bindings/phy/rockchip-inno-csi-dphy.yaml       | 65 ++++++++++++++++++++-
 .../devicetree/bindings/soc/rockchip/grf.yaml      |  1 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 34 +++++++++++
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c   | 67 ++++++++++++++++++++--
 4 files changed, 159 insertions(+), 8 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250616-rk3588-csi-dphy-c9ed2ad4cd9f

Best regards,
-- 
Michael Riesch <michael.riesch@collabora.com>




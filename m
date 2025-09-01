Return-Path: <linux-kernel+bounces-795333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20A0B3F041
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559831B20A55
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628B9274B31;
	Mon,  1 Sep 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgLv11YI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909A1E515;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760512; cv=none; b=bt3eWtv+t8HlnWxAVFdb7ejbu7fafHpySeYqdp8YYvXRaej2pHtsCoA7GN0YQRW+SoTNa2LbCSKaFMH6onk5b71dcQoVL7xgL0GVdomPq72NDugOXzo3Y/ieCGHQJtWMdnl2ixJMl0w7N3ORBe1fRzvEn/EfgVfOM+xy6aaxOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760512; c=relaxed/simple;
	bh=4CrokqEf8Oyhtq/Lgi/8eYv79LyWQCJPt1fZ+7MTR/k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Foloce1RovEk94DWWSnoxOSjqeNiAXUIBGvkbByS9Ett/2zRYPEJEr/bnBI76TpytzJBaBDUFq7YCiY5vL4ABBHgwFri336kB7eI/4hK0eGFKq9yj5laeri8U5qwqIeNNBFUlnjwOfFBuQ1AJrqayl4kdGmle9BQw9WtBM8Ak18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgLv11YI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88844C4CEF0;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760512;
	bh=4CrokqEf8Oyhtq/Lgi/8eYv79LyWQCJPt1fZ+7MTR/k=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AgLv11YIOm6/5UW8gHlkMmitCgN67jbXhaXRccK58g9Pj1acxJWe1J0amHJs7UKQ2
	 sBTSs2UgOmZTFUB+3XBsFLUaJyUOaBTU2fvnPrXLEQwfMJlS+FuucG3JOWfmm3HGrd
	 snLK/ZjPwhrZRCRlv4XsttQ0tqZnTy9LF63aivTd4whhLxpJkV61nut+GblFflp1Md
	 HYEu+3r5QbsTAbjy/dID3FqyqmRhDjDJG8zDw09sS6ajA5Ww8FcjFvdn+TiHPMd/BD
	 SeE2675Xm1ulS+iTpEsZ/FIHSRchdsa5TjsPob7nWnOIXXtFNpgkwdbYjVss1wbn4Q
	 Ws6W3kJphxEWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76732CA1007;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Subject: [PATCH v3 0/7] phy: rockchip: phy-rockchip-inno-csidphy: add
 support for rk3588 variant
Date: Mon, 01 Sep 2025 22:47:41 +0200
Message-Id: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG0GtmgC/4XNyw6CMBCF4VchXTumF6DUle9hXPSGTFRKWtNIC
 O9uYWliXP4nmW8WknxEn8ipWkj0GROGsYQ4VMQOerx5QFeacMob2rIW4l00XQc2IbhpmMEq77h
 2tXWqJ+Vqir7H9y5erqUHTK8Q5/1BZtv628oMKHS1N8JwLUVrzzY8HtqEqI82PMnmZf7H4MWQW
 tU9lcpIxr+NdV0/6MrL3PYAAAA=
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
 Michael Riesch <michael.riesch@collabora.com>, stable@kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756759662; l=2265;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=4CrokqEf8Oyhtq/Lgi/8eYv79LyWQCJPt1fZ+7MTR/k=;
 b=Ua9pG946E3TVXk5J62FKrlwGkZTP22Uscs6kARSnHiU729If4wNnfo3rRTNLKeRzPr4I95I9T
 rxGX2eQ3tZtB4d7gaKaCIh37SKK8uyTDkB18w+wbdN14BL2dT5jBWdj
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
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 33 +++++++++++
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c   | 67 ++++++++++++++++++++--
 4 files changed, 158 insertions(+), 8 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250616-rk3588-csi-dphy-c9ed2ad4cd9f

Best regards,
-- 
Michael Riesch <michael.riesch@collabora.com>




Return-Path: <linux-kernel+bounces-774584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8609B2B484
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA952A1536
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB0C27B505;
	Mon, 18 Aug 2025 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX6CB5T5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE7258ED8;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558873; cv=none; b=g8CvMpSqN0bWpqcNKS3W6gve4JjS0KwZchvaNQ2JeASrjFGLdiDpNpR0n471A2yUimaCRDnt84DXk5+9U/F12bhqjHkVU/I36au+h+OfzeFgfT8YcGrBino+Y2GX7eI8/U/aYFRuUGMYIsYtpYQK1/NwLgAg0+MPtn/e0XQyqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558873; c=relaxed/simple;
	bh=1a1Pkt0EvyEZQWW/s13OKuuiFcIkA40/CYxanM3w+9k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h3xHh85M5DpcBewscElRbgKGdbIFZpHMBe1eCpT2rsW/k7lPvjmRmp4uVfb0lKQflQxuw9iIdQOyv4yFmXmJIfo6TKREMfIfr9Sx5aoRIQxSuaq+g85XSs57IrDywRy/u0x0ew3e2A8+uudfl1LvLZqOzunfIdg0CH4kVBSP07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX6CB5T5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55D78C4CEEB;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755558873;
	bh=1a1Pkt0EvyEZQWW/s13OKuuiFcIkA40/CYxanM3w+9k=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=SX6CB5T5IQuFDl6QNBZasScEdnsovVSJ+iwEP+Q36FfYmng+oIzVVzUYaIGbQwc+u
	 4269NHtijTkQRh22vaDb5oEK9QHRoxqgioyVHlsm2g51x32C9Tt35V1KS13whMjh5U
	 otU3OnSguBtN37aLjdm0HSlwWPsJF1Xn7emGBqcfgP5tFCv1AJtX6iorTktQ1Ueyma
	 d1hzYnJxNm9Kt4VZygo3PYobBG9/V8xnf4hShABy8LvCAqFTzWd6/CDfTZc1fuflM1
	 444VvIIwOIWvsEDjGIaAiflFTF6gDHFTySnCrpemMARkfLu+xrvfmiHWTr/vseQOA/
	 R6pIeKhg1S1uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443DFCA0EC0;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Subject: [PATCH v2 0/7] phy: rockchip: phy-rockchip-inno-csidphy: add
 support for rk3588 variant
Date: Tue, 19 Aug 2025 01:00:34 +0200
Message-Id: <20250616-rk3588-csi-dphy-v2-0-7a94f079b712@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJKwo2gC/3WNQQ6CMBBFr0Jm7RgoUMGV9zAsynSQiUhJaxoJ4
 e5W9i7fS/77GwT2wgGu2QaeowRxcwJ1yoBGMz8YxSYGlas614VG/yzrpkEKgnYZV6SWrTK2Its
 OkFaL50E+R/HeJR4lvJ1fj4NY/Oz/Viwwx6bivuyVuZSabuSmyfTOmzO5F3T7vn8BzFVvw7IAA
 AA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755558041; l=2041;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=1a1Pkt0EvyEZQWW/s13OKuuiFcIkA40/CYxanM3w+9k=;
 b=nPWx2kQxGMIhjPK6/OMn3h27OpqKKGQap4h9iXwezh+pNZgwJI5wgHNJGT5ugJKzXmJGwuA3x
 H238ii8w0vMAthBf7d7rZZBqQpiXMsaK3VME5mQU+9AzI+SfK2iQaYb
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

 .../bindings/phy/rockchip-inno-csi-dphy.yaml       | 61 ++++++++++++++++++--
 .../devicetree/bindings/soc/rockchip/grf.yaml      |  1 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 33 +++++++++++
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c   | 67 ++++++++++++++++++++--
 4 files changed, 151 insertions(+), 11 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250616-rk3588-csi-dphy-c9ed2ad4cd9f

Best regards,
-- 
Michael Riesch <michael.riesch@collabora.com>




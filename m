Return-Path: <linux-kernel+bounces-827101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE391B90519
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C0C3BBBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EA1302773;
	Mon, 22 Sep 2025 11:11:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55292FD7B1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539487; cv=none; b=KTwZTgyh6z6Ficyxaa9oBD4kxQpN2m5fcY57TMREbPOBwqMsw8fufgXVQctnW3gkj5qZN7vYGzgltsfz7MFXhJ3K0bUr2QV27hzVX8oiQBFN3lDkkDOwi64LUu2SgKq6oJRv4hFUETTYt0dkLVxYPBxnDEJbJQ3nsewQB9kU5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539487; c=relaxed/simple;
	bh=7QFjO8uzNm9hY4U+sWRX9qDV5/YD4htnFLFO4rr5rZA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YVsXSYflz0ksrB+7o2z3va6MTt41vs1rRHAXFE3Gtj7eXRq+b6wtlf8V7KiBE/8EbR3VI3lelxd95US8AuFfw7w9pXNgCXKK9w/Eh8foel1ogtc7n4halH0f9dLEIbx3Hro4Jo6iaB2QqjpZjSoCeMAnwEAVb11qi6kDVYZ9gK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1v0eRk-0002HM-ET; Mon, 22 Sep 2025 13:11:04 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 0/5] arm64: dts: imx8mp-skov: add new 10" variant
Date: Mon, 22 Sep 2025 13:10:51 +0200
Message-Id: <20250922-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v2-0-abbb759cf8ef@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALsu0WgC/52NQQ6DIBBFr2JYdxogWrUr79G4sDLotBEIILEx3
 r3UI3T18/7ivZ0F9ISB3YudeUwUyJoM8lKwcR7MhEAqM5NcVryRAtINRA3ROhqBlq1ZHIS3TaB
 igNca7TrOIDiZPC3qVg9DXVWiZFnoPGraztijzzxTiNZ/znYSv/evTBLA4Vm2EnXDayVk59BMa
 /TW0HZVyPrjOL4D5acR6QAAAA==
X-Change-ID: 20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-9ef9faa75514
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add a new board variant for the Skov i.MX8MP based family of boards.

This variant uses a different 10" panel than the existing ones.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v2:
- add wider compat "eeti,exc80h84" after "eeti,exc81w32" to pass CHECK_DTB 
- add Acked-by and Reviewed-By
- Link to v1: https://lore.kernel.org/r/20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de

---
Steffen Trumtrar (5):
      dt-bindings: vendor-prefixes: Add JuTouch Technology Co, Ltd
      dt-bindings: display: simple: Add JuTouch JT101TM023 panel
      drm/panel: simple: add JuTouch JT101TM023
      dt-bindings: arm: fsl: add compatible for Skov i.MX8MP variant
      arm64: dts: imx8mp-skov: support new 10" panel board

 Documentation/devicetree/bindings/arm/fsl.yaml     |  1 +
 .../bindings/display/panel/panel-simple.yaml       |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
 arch/arm64/boot/dts/freescale/Makefile             |  1 +
 .../imx8mp-skov-revc-jutouch-jt101tm023.dts        | 79 ++++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               | 35 ++++++++++
 6 files changed, 120 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-9ef9faa75514

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>



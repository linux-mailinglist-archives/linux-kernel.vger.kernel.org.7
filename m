Return-Path: <linux-kernel+bounces-865176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E563BFC6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CE862757F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE38534B41A;
	Wed, 22 Oct 2025 14:06:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79E34B436
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141963; cv=none; b=auHl3afRstKRufrvYTCYyyXbTDDbyF7cl1Uyjnro6L/283jODmgKbkxUGu8T49wYRzLgP+pkNOkamNm8f0mwF7k55F0DxGHIyTPIYrig1Bqz+ra9XjPAsPLoTCy4KFhI3QhvoScepUiwZzyFYlL3U/uyAtjbstvJ67mYFLW92XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141963; c=relaxed/simple;
	bh=vNt59W7eOCQQYu9m5bd21AADPf3V+70JPqFIN7Nxffo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SCZdI5lyYQyEzCsKr273VPLxTAPtMndNutn4bkkIbuM5m6+aDek+0nInQh7W0KLIFRqeIUUrSdIWC7tKavfN3TECijYQfD6cvJ+E2liBhvq0Pp+a0Vj5+r76O4UfHUZwa2FR20YmMyAITFrtnI59G2BHP2Pj7ygIEYPC2tIJ0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude06.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::5c])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pflug@pengutronix.de>)
	id 1vBZTI-0000vR-9a; Wed, 22 Oct 2025 16:05:48 +0200
From: Fabian Pflug <f.pflug@pengutronix.de>
Subject: [PATCH v3 0/2] Add devicetree for NXP i.MX93 FRDM board
Date: Wed, 22 Oct 2025 16:05:21 +0200
Message-Id: <20251022-fpg-nxp-imx93-frdm-v3-0-03ec40a1ccc0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLk+GgC/33NTQ6CMBCG4auQrq3pDyXgynsYF7WdwiwoTYukh
 nB3CysTjcv3S+aZlSSICIlcqpVEWDDh5EvIU0XMoH0PFG1pIphQTAlJXeipz4HimLtS0Y5UGcN
 bprmzuiPlMERwmA/0di89YJqn+Dp+LHxf/3ILp4yqunkIK2vRKnUN4PvnHCeP+WyB7OYiPp3mp
 yOKA0pbBk6DkfLL2bbtDU5DSxQBAQAA
X-Change-ID: 20250523-fpg-nxp-imx93-frdm-5cc180a1fda9
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Fabian Pflug <f.pflug@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Haidong Zheng <haidong.zheng@nxp.com>, Danwei Luo <danwei.luo@nxp.com>, 
 Lei Xu <lei.xu@nxp.com>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::5c
X-SA-Exim-Mail-From: f.pflug@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

I could not test all features of the board, therefore a lot of stuff is
omitted from the devicetree. but this is enough to have the board boot
via eMMC or SD-Card, debug via debug USB connector and have a network
connection.

The FRDM i.MX 93 development board is a low-cost and compact development
board featuring the i.MX93 applications processor.

It features:
- Dual Cortex-A55
- 2 GB LPDDR4X / LPDDR4
- 32 GB eMMC5.1
- MicroSD slot
- GbE RJ45 x 2
- USB2.0 1x Type C, 1x Type A

This file is based upon the one provided by nxp in their own kernel and
yocto meta layer for the device, but adapted for mainline.

Signed-off-by: Fabian Pflug <f.pflug@pengutronix.de>
---
Changes in v3:
- Add Signed-off for original NXP contributors.
- Fixed whitespace errors (Thanks Francesco Valla)
- Added mu1 with status okay (Thanks Francesco Valla)
- Removed address cells from lpi2c3 (Thanks Frank Li)
- Configure pin for watchdog (Thanks Peng Fan)
- Updated regulator config
- Configure i2c0
- Link to v2: https://lore.kernel.org/r/20250526-fpg-nxp-imx93-frdm-v2-0-e5ad0efaec33@pengutronix.de

Changes in v2:
- 1/2: remove CAN node, as it has not been tested.
- 1/2: ran dt-format (Thanks Frank Li)
	But also reordered some nodes afterwards again to have
	regulator-min before regulator-max, have the pinmux at the end
	of the file, and have the regulator-name as the first node
	inside the regulators.
	Re-added comments, that were deleted.
- 1/2: changes subjet to ar64:dts (Thanks Fabio Estevan)
- 1/2: removed reg_vdd_12v (Tanks Fabio Estevan)
- 1/2: added aliases for rtc, emmc, serial (Thanks Fabio Estevan)
- reordered the series to have documentation before dts. (Thanks
  Krzystof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20250523-fpg-nxp-imx93-frdm-v1-0-546b2d342855@pengutronix.de

---
Fabian Pflug (2):
      dt-bindings: arm: fsl: add i.MX93 11x11 FRDM board
      arm64: dts: freescale: add support for NXP i.MX93 FRDM

 Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 658 +++++++++++++++++++++
 3 files changed, 660 insertions(+)
---
base-commit: 552c50713f273b494ac6c77052032a49bc9255e2
change-id: 20250523-fpg-nxp-imx93-frdm-5cc180a1fda9

Best regards,
-- 
Fabian Pflug <f.pflug@pengutronix.de>



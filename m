Return-Path: <linux-kernel+bounces-877613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E38C1E958
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A1A3B4BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B3C32D0F2;
	Thu, 30 Oct 2025 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlDL1fkO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E52DC76C;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806142; cv=none; b=fLOKJtmuiV4LAl6CzCwIW9kPZpNPc8590mnZiw+8yS6l6+x173uEYkqQpqAzukygrR1AR7L0NLT+aaEMuEIWYmrwi0UggU8yfsEETSGFJdhN5lQftpFWkZqPeBZOBwoCz8e9ehKFL3OQ/mYs1g1fw7otbXvxf/o0B/0u0msoAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806142; c=relaxed/simple;
	bh=U7srSnWzfH6yj+mfSTGf2OP0Gg/vZlzbpPNFl8Dk7XQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CnxMnWCLX/t83bHvqxJBD/24uCN773YJm/AUEx0/xJRIZpZOx+VA853HsfRHCsyzJEgWh8CS/i75O9nha+TLWPjqfjPoXFLIZG2J53iGuCef12x+ZeP/chPDvRdd8FGMwQBz0Il22zZhxtKWE9ALVcudU+GpFdCDupCdUBTVNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlDL1fkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE418C4CEF1;
	Thu, 30 Oct 2025 06:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761806141;
	bh=U7srSnWzfH6yj+mfSTGf2OP0Gg/vZlzbpPNFl8Dk7XQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NlDL1fkOcAvWdTiWh1qtupEVkylVn1RCIvJ+Ecjz5Oz1PDX6y8bXubduJuudCf07i
	 LCmJxNofOQoRyt3bMHI4qEr0Xt6n0oJjHCMpCeBX+V/6+tuQiSNkTdXeow1yIUTSv2
	 PgbOCoRVkPwNfrZhWtr7vHionZGSVsLxEOCG/zMN9XufSTj5LKgLOLuY37HeBY3ICr
	 /vrSwoXJjPpPMwxIeoHAcfNWaRJDtgnbgl63QX53xtCfVIxVSFyODmSwVCxPURc+x5
	 fC9+x1NZOa5BOfCtR6HyoEO2sTjD+y2GBdkiZXtsuHBQaEc9TShNMEoWnywD8BB2Kr
	 1coGiCDQUhPDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B982CCCF9F0;
	Thu, 30 Oct 2025 06:35:41 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Subject: [PATCH v3 0/6] arm64: dts: freescale: add support for the
 GOcontroll Moduline IV/Mini
Date: Thu, 30 Oct 2025 07:35:36 +0100
Message-Id: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgHA2kC/2WMwQqDMBAFf0X23JRkNdT01P8opYQ00QVNJJHQI
 v57o5cWPM7jzSyQbCSb4FotEG2mRMEXqE8VmF77zjJ6FQbkKAXnio3k6UmZaS6tNGgEYg3lPUX
 r6L2X7o/CPaU5xM8ezmJbj40sGGeubltlGoWNvNy6YIKfYxiGswkjbKGMfzLiT8YiI9eudUprI
 5qDvK7rF7GCyXHgAAAA
X-Change-ID: 20251009-mini_iv-a05e5c2c1223
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761806140; l=2171;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=U7srSnWzfH6yj+mfSTGf2OP0Gg/vZlzbpPNFl8Dk7XQ=;
 b=dUk+8sCZB3oHVtlOsJveFBg7XJlVdMloMj3tLjhulGXp3ipCK3pKsZ3y9+/ItK5lwGpdeSH5w
 w8ba6dfY5LSB1w1EJjYBMGOe9hQZkJEhiH4z1nI3D8f52VgHf6f8MpU
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

Add initial support for the Moduline IV and Moduline Mini embedded
controllers.

These systems are powered by the Ka-Ro Electronics tx8m-1610 COM, which
features an imx8mm SoC.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
Changes in v3:
- Add patch fixing the pmic driver
- Use the proper feedback properties for BUCK6
- Slightly rework the compatibles, acked by conor dropped
- Add missing CAN interface supplies, remove the leftover comment
- Add missing vled-supply
- Add missing ethernet phy interrupt (doesn't work)
- Fix the cs-gpios properties in all spi interfaces
- Fix the order of properties in all spi interfaces
- Remove unused labels for regulators of the PMIC
- Link to v2: https://lore.kernel.org/r/20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com

Changes in v2:
- Fix allignment issue in imx8mm-tx8m-1610.dtsi (fec1)
- Move phy-reset into fec (works better in barebox)
- Make the gpio-line-names groups of four on every line
- Link to v1: https://lore.kernel.org/r/20251009-mini_iv-v1-0-f3889c492457@gocontroll.com

---
Maud Spierings (6):
      dt-bindings: arm: fsl: Add GOcontroll Moduline IV/Mini
      regulator: bd718x7: Fix voltages scaled by resistor divider
      arm64: dts: imx8mm: Add pinctrl config definitions
      arm64: dts: freescale: add Ka-Ro Electronics tx8m-1610 COM
      arm64: dts: freescale: Add the GOcontroll Moduline IV
      arm64: dts: freescale: Add the GOcontroll Moduline Mini

 Documentation/devicetree/bindings/arm/fsl.yaml     |   8 +
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h     |  33 +
 .../imx8mm-tx8m-1610-moduline-iv-306-d.dts         | 800 +++++++++++++++++++++
 .../imx8mm-tx8m-1610-moduline-mini-111.dts         | 688 ++++++++++++++++++
 .../arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi | 444 ++++++++++++
 drivers/regulator/bd718x7-regulator.c              |   2 +
 7 files changed, 1978 insertions(+)
---
base-commit: 7c3ba4249a3604477ea9c077e10089ba7ddcaa03
change-id: 20251009-mini_iv-a05e5c2c1223

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>




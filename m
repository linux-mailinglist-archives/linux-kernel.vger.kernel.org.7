Return-Path: <linux-kernel+bounces-864321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97286BFA846
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 163FC3421C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CB2F7AA2;
	Wed, 22 Oct 2025 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCDAuass"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A302F616A;
	Wed, 22 Oct 2025 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117765; cv=none; b=XueliUmCtI5nkOdZq64kTjVC9nycOVVMpJ3tudbGwhQ8EwxomtxeL7TE3pt4+pQZ/A+N77QShU9e7kN5KmHMLPqoPKQADqsXJ+vEpjSVxdMp+5vR5a0Swf0fjZaPefC+Y8/YqdwRcIsUncX5C3lBYnhavy8am+UGDZnoBWGBDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117765; c=relaxed/simple;
	bh=6MxoejU7iKxp9mf2s8THn5c4jDLFtHOP5ivmjYnDox0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C29Re8NP/fFdU9x8W83Mjnou5N4HTfeID4unScWmZLszvc3yS+10lljukyaFhG9jBSmDes1Ls1c/TTvc0iBTpO6dYbetwWZnvlKvUQzkQvRakynAPE6oy+fDSPMoD1Q5KwWlOrJyN9FVhKiYzIuy0r08nbVrHlC3Xv4I+sUEgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCDAuass; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF02EC4CEF7;
	Wed, 22 Oct 2025 07:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761117764;
	bh=6MxoejU7iKxp9mf2s8THn5c4jDLFtHOP5ivmjYnDox0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tCDAuass2USKptSp3Urz8RFIJHosHnDRCL4O9vUQ3W3xWunIvmY5E8wNzeUr9cdXp
	 2Aq822wED1ySumLmTyB04CNMJLDr+pV/bD7yCddj6zLV6PZh29zYSOTJCsvpg9b0Lt
	 92k4Y2sL7b0dgHcWJt01DN4MWEPOnaPvWQlqmGBJlwitgEk2ACamqmFURB5qU2DNnv
	 lmBDWIsK35ebK1ILK2favwL67F6tdq1OaD0dURQvaZwNpbGeyc+3R+f9H+zwzTZq/F
	 BVC0RNq/gtS9wWUfNBcZsofpLWW8AlVhcqMe/RazTNBroARP1E9iyA4VI1Y3kxVppy
	 IbWISFKwt97eA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4D7CCD195;
	Wed, 22 Oct 2025 07:22:44 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Subject: [PATCH v2 0/5] arm64: dts: freescale: add support for the
 GOcontroll Moduline IV/Mini
Date: Wed, 22 Oct 2025 09:22:36 +0200
Message-Id: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADyG+GgC/2XMQQqDMBCF4avIrJuSjIZqV71HkSLpqAOaKYmEF
 sndm7rt8n88vh0iBaYI12qHQIkjiy+BpwrcPPiJFD9LA2q0RutOrez5wUkN2pJ16AxiDeX9CjT
 y+5DufemZ4ybhc8DJ/NZ/Ixml1Vi3beeaDht7uU3ixG9BluXsZIU+5/wFvo3v0aMAAAA=
X-Change-ID: 20251009-mini_iv-a05e5c2c1223
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761117763; l=1486;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=6MxoejU7iKxp9mf2s8THn5c4jDLFtHOP5ivmjYnDox0=;
 b=8EDC4BIHHluETyJsGoyj3Ub5ZCMaVm7eZYUrj9HEkXC3ILQwIrUDvDuWDi3lD+10vmAFhAPht
 fbrq37zJBZJCz9pkBRodQSo996DWROXX/di837e4v0DP/zUj/N4dKZ4
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
Changes in v2:
- Fix allignment issue in imx8mm-tx8m-1610.dtsi (fec1)
- Move phy-reset into fec (works better in barebox)
- Make the gpio-line-names groups of four on every line
- Link to v1: https://lore.kernel.org/r/20251009-mini_iv-v1-0-f3889c492457@gocontroll.com

---
Maud Spierings (5):
      dt-bindings: arm: fsl: Add GOcontroll Moduline IV/Mini
      arm64: dts: imx8mm: Add pinctrl config definitions
      arm64: dts: freescale: add Ka-Ro Electronics tx8m-1610 COM
      arm64: dts: freescale: Add the GOcontroll Moduline IV
      arm64: dts: freescale: Add the GOcontroll Moduline Mini

 Documentation/devicetree/bindings/arm/fsl.yaml     |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h     |  33 +
 .../imx8mm-tx8m-1610-moduline-iv-306-d.dts         | 801 +++++++++++++++++++++
 .../imx8mm-tx8m-1610-moduline-mini-111.dts         | 691 ++++++++++++++++++
 .../arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi | 439 +++++++++++
 6 files changed, 1969 insertions(+)
---
base-commit: 7c3ba4249a3604477ea9c077e10089ba7ddcaa03
change-id: 20251009-mini_iv-a05e5c2c1223

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>




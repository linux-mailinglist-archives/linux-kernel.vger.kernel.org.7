Return-Path: <linux-kernel+bounces-584550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB5BA7888C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 09:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402E53B0524
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 07:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5358C233D65;
	Wed,  2 Apr 2025 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyi6Rl47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23B20CCE8;
	Wed,  2 Apr 2025 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577642; cv=none; b=T7Mp+SPQEnlTgy1gr+Rao1kjL4ih/L1WCQQfsLthbFK5+Hy06j8DRZptvSvZxBoFKpi0eVAzYd2rJlaJxK2pxCQE3WXFhnRpPXbpd2/B19GX2v2dYl/PldU9WbHx4Bumz9l7/xg+lmmxD0Fm4WMUroS+KDqRkyuOgvl5VAgcCBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577642; c=relaxed/simple;
	bh=6Ng+hdOoNno07pilCVpRF8PT7c6ejjDq52moQll8qjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=azsymdE2Nl48MMjLn1NcdDTCEGKqP/GXMUAcBAV7urLmZrUH2x1akU1z6JcS+YMmNOmf26MbPZp+apf7XeT2lsiMDqXgKZa9xWmv/8gOn44ZfFUE2htxJ6bauKMoYqK7rgVUpNqXk+HQMIc8SeF2ELdYV4YVmRdgqee3LE1buGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyi6Rl47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1522EC4CEEE;
	Wed,  2 Apr 2025 07:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743577642;
	bh=6Ng+hdOoNno07pilCVpRF8PT7c6ejjDq52moQll8qjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Cyi6Rl47wJj0leESfcJ3KKDXV49U3b+3nAqFaHUzxeElohzFwvdphI93lSKQEPM4B
	 To4/QhsaMn9A2FhbjPIvE1sjMUABdNs/9YgrjBh0/dvl0AJlo6WntRZZPwulXAvRM8
	 cviiCT8aXEddgLRyztPjj6Ru0iWtUz5VFvXUuHCniGsynnNyAXbvxphCUQVmnfQK+c
	 L7Hg0HsBGLrDEI9W+3PEN+BAecFhlWdJjyi8OXdAhvJLjMHlinVsR1eFNyuAIflG22
	 dd5Xo2SjsLiVAGvQdVIxBjUywdMQyTiF44zh724QvfdoO8H17CwH0j4e+DCgNYSngT
	 /idK7S2Jzdc8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CBFC3601B;
	Wed,  2 Apr 2025 07:07:22 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Wed, 02 Apr 2025 09:07:05 +0200
Subject: [PATCH v4 2/9] arm64: dts: imx8mp: Add pinctrl config definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-initial_display-v4-2-9f898838a864@gocontroll.com>
References: <20250402-initial_display-v4-0-9f898838a864@gocontroll.com>
In-Reply-To: <20250402-initial_display-v4-0-9f898838a864@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743577640; l=2170;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=mrxqwhYhMzGSTJWlhyHKyT15kZQ0Bh3K/pqX9Brfdms=;
 b=RSWJLRi+yCrV9P8qgazfvQVlwOXVi+fUOwjn7H9V2eRa6F25Q6DY2xPl+QPpoARL6a3Gqyof8
 6+AeYLUHr5nCZN3Ut4gOQPHRxmU4Tb90bsMuAR4IRah96Edlm9eWx/4
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Currently to configure each IOMUXC_SW_PAD_CTL_PAD the raw value of this
register is written in the dts, these values are not obvious. Add defines
which describe the fields of this register which can be or-ed together to
produce readable settings.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
This patch has already been sent in a different group of patches: [1]
It was requested there to submit it along with a user, this series also
includes some users for it.

[1]: https://lore.kernel.org/all/20250218-pinctrl_defines-v2-2-c554cad0e1d2@gocontroll.com/
---
 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
index 0fef066471ba607be02d0ab15da5a048a8a213a7..19a23d148246f4fb990050a9d06d20b6e769f254 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
@@ -6,6 +6,39 @@
 #ifndef __DTS_IMX8MP_PINFUNC_H
 #define __DTS_IMX8MP_PINFUNC_H
 
+/* Drive Strength */
+#define MX8MP_DSE_X1 0x0
+#define MX8MP_DSE_X2 0x4
+#define MX8MP_DSE_X4 0x2
+#define MX8MP_DSE_X6 0x6
+
+/* Slew Rate */
+#define MX8MP_FSEL_FAST 0x10
+#define MX8MP_FSEL_SLOW 0x0
+
+/* Open Drain */
+#define MX8MP_ODE_ENABLE 0x20
+#define MX8MP_ODE_DISABLE 0x0
+
+#define MX8MP_PULL_DOWN 0x0
+#define MX8MP_PULL_UP 0x40
+
+/* Hysteresis */
+#define MX8MP_HYS_CMOS 0x0
+#define MX8MP_HYS_SCHMITT 0x80
+
+#define MX8MP_PULL_ENABLE 0x100
+#define MX8MP_PULL_DISABLE 0x0
+
+/* SION force input mode */
+#define MX8MP_SION 0x40000000
+
+/* long defaults */
+#define MX8MP_USDHC_DATA_DEFAULT (MX8MP_FSEL_FAST | MX8MP_PULL_UP | \
+								  MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+#define MX8MP_I2C_DEFAULT (MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | \
+						   MX8MP_PULL_ENABLE | MX8MP_SION)
+
 /*
  * The pin function ID is a tuple of
  * <mux_reg conf_reg input_reg mux_mode input_val>

-- 
2.49.0




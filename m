Return-Path: <linux-kernel+bounces-823186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0269B85C51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64B41886731
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EAE30F80C;
	Thu, 18 Sep 2025 15:45:07 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93197241664;
	Thu, 18 Sep 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210307; cv=none; b=AsI8mQGBH7vbi6ny8Fyh9QHWur+THxNyR95OEwJ8vxIkTn/S4P8z/9dV4V9EMgzLK/W/bw8YwKhtMEkZT2sj1xirekJcBPl8JDMpOBZK77D02SQ1jLVYqyxB7K4odsYE4D37DA4PGUow2I2k/dzEnJmMPozksUZkzH+OGgjBbX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210307; c=relaxed/simple;
	bh=NjGa7QM3IjkSYtulZR2XLlOCz2BXmZy2Osv7sp8SoE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBIvNq1bbrd5uuClJ3388Uszf0uUw2WVX1lS+FziSJrTsMH+ez2aU/wluPK7WzY8zy+gPSnrYOMW1Wf57hokk/cXuEcPg6dDhuKFAdZ71Qxa4PqpJUcJRdh9ek4yXL4nrjnyqn6yuevx0Cw+WDouesqrqZQ/Qo/5DBoUpbfzbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uzGod-00B1eF-Gf;
	Thu, 18 Sep 2025 15:44:59 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 7/7] arm64: dts: imx8mp-venice-gw702x: remove off-board sdhc1
Date: Thu, 18 Sep 2025 08:44:51 -0700
Message-Id: <20250918154451.2531802-8-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918154451.2531802-1-tharvey@gateworks.com>
References: <20250918154451.2531802-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SDHC1 on the GW702x SOM routes to a connector for use on a baseboard
and as such are defined in the baseboard device-trees.

Remove it from the gw702x SOM device-tree.

Fixes: 0d5b288c2110 ("arm64: dts: freescale: Add imx8mp-venice-gw7905-2x")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - no changes
---
 .../dts/freescale/imx8mp-venice-gw702x.dtsi   | 20 -------------------
 .../dts/freescale/imx8mp-venice-gw72xx.dtsi   | 11 ----------
 2 files changed, 31 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index dba35b3394bc..de852ebff571 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -403,15 +403,6 @@ &uart2 {
 	status = "okay";
 };
 
-/* off-board */
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-};
-
 /* eMMC */
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
@@ -514,17 +505,6 @@ MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
 		>;
 	};
 
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
-			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0
-			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0
-			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0
-			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0
-			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
-		>;
-	};
-
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
index cf747ec6fa16..76020ef89bf3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
@@ -365,17 +365,6 @@ MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX	0x140
 		>;
 	};
 
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
-			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0
-			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0
-			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0
-			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0
-			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
-		>;
-	};
-
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
-- 
2.25.1



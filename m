Return-Path: <linux-kernel+bounces-819227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3503B59D16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7148C4E0C25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB5D37C0E4;
	Tue, 16 Sep 2025 16:05:34 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055D37428A;
	Tue, 16 Sep 2025 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038734; cv=none; b=GhVki+LtUcLAH5yyDHP02GPg200GKABBfxF+UBfv3k02FC5q5OwV7W8RqRA/9i9vYsR3XT+Zl+nmF3mYCX/+QcuqTUNaIieoqfBQPnSILXR3sIN/drdH2hRUWs/w72IdoVi72gP0uf05F/2I2cyvDQJheTyLKJ7fenJvPE5LdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038734; c=relaxed/simple;
	bh=mxrtv/69/+bXmmAeqkI7fArQfAwows48YYy0GhlgOLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqcRRCBSxo+U9w00G4qgH7gvMx4EZgAobwHiqqn6lyyb9Pq1sw+V7R141Ia/WyMh7BXQUm6SPQVSTu+cZig7pSHSaCS2zVkrdfJ3gLh2bGRpUrubzUXOT8kY40ZtsUr1Cw7l1VsdJq+KBP8x5sxQjANc6nOK9r6V5Y1YuWv8byY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uyXfM-00Aysu-1P;
	Tue, 16 Sep 2025 15:32:24 +0000
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
Subject: [PATCH 6/7] arm64: dts: imx8mp-venice-gw702x: remove off-board uart
Date: Tue, 16 Sep 2025 08:32:15 -0700
Message-Id: <20250916153216.1042625-7-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916153216.1042625-1-tharvey@gateworks.com>
References: <20250916153216.1042625-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UART1 and UART3 go to a connector for use on a baseboard and as such are
defined in the baseboard device-trees. Remove them from the gw702x SOM
device-tree.

Fixes: 0d5b288c2110 ("arm64: dts: freescale: Add imx8mp-venice-gw7905-2x")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/freescale/imx8mp-venice-gw702x.dtsi   | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index dd9eeb3479fd..dba35b3394bc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -396,13 +396,6 @@ &i2c3 {
 	status = "okay";
 };
 
-/* off-board header */
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
 /* console */
 &uart2 {
 	pinctrl-names = "default";
@@ -410,13 +403,6 @@ &uart2 {
 	status = "okay";
 };
 
-/* off-board header */
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
 /* off-board */
 &usdhc1 {
 	pinctrl-names = "default";
@@ -521,13 +507,6 @@ MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19	0x400001c2
 		>;
 	};
 
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
-			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
-		>;
-	};
-
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
@@ -535,13 +514,6 @@ MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
 		>;
 	};
 
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140
-			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140
-		>;
-	};
-
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
-- 
2.25.1



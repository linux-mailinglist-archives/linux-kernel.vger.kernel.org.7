Return-Path: <linux-kernel+bounces-739039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB68B0C0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014DE4E1994
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C228DB50;
	Mon, 21 Jul 2025 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="TwCaLgpG"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A128ECFC;
	Mon, 21 Jul 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092530; cv=none; b=gZqwGRjBFzJ4H1nUzPW7ri9npn7wr+IA8VwfI1U5WF7yApEMxVt06EV7nShY+Y2JJLvm0NFnrYxWh+eURtc6yeF3hFHJoKKyiYe6sZlUdLS/nqAO+VBK8RZF8h87lM0iUMWS7MGrh7ZrabfO0IH1qwTqCv8XH53N6b/ew4C2XKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092530; c=relaxed/simple;
	bh=cSIVc5cj/naj8UPMpuoHR8p2hC7oa1fC6SznprK8FHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUIHMB96OkNFE+gwaPGKhD5akgq9bEBmNyqgRoMcpX2euFdmf710CG5oQux3y5HUMuerYOalggy7xZ79fjNNtLMgakEC1jQenNYBeDRH1O+XTXK9YB3ZvggHQdgic8zawndL/RfJE8mmH/yOHgKYVKNXORQl+9zjGvPu/Mmjf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=TwCaLgpG; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87A7DC75FC;
	Mon, 21 Jul 2025 12:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092527; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iWu52B/V45Sj+zawQFQZIAYKWu1W4y6AIeR9Ixu3gtc=;
	b=TwCaLgpGlStdT6qP1n2kaHo+2U2YCd0a0ZUJm4gIREFYnEpPHEstGmD1rzDq8ziSuco62z
	v/xPuWuoHFP4bPwpsjSZZeQn+uELRkhioBbsGEDaqvvBz1voOawpX2GRqp0UT8phiy/64V
	R19hzNDvmU04CVUSVtg2cPVGh8q7qN0pvVH3aDU+HqtxrliKVAwSrAYX+43IpniQDen1w1
	1yrt7z0fn57HwprwiEZCaOT/hQwT2Y6365aUv3ucRx1ie5vuaj2t4FW23RS28NydyvoBnP
	sU8Gb1ZwRN2Iu0AR88f3i0fC2ncY+mpGgM480+hIDxhs27k3Um5jPE0qVJio3g==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Annette Kobou <annette.kobou@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 08/12] arm64: dts: imx8mp-kontron: Fix GPIO labels for latest BL board
Date: Mon, 21 Jul 2025 12:05:42 +0200
Message-ID: <20250721100701.115548-9-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721100701.115548-1-frieder@fris.de>
References: <20250721100701.115548-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Hardware rev 3 changed a few signals. Reflect these changes in
the GPIO labels.

* digital IOs were moved to GPIO expander
* remove labels for unused signals
* add labels for TFT, CSI and USB hub IOs

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../dts/freescale/imx8mp-kontron-bl-osm-s.dts | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
index 4aa5c261b865d..bbcd76e9e9913 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
@@ -123,38 +123,36 @@ &gpio2 {
 
 /*
  * Rename SoM signals according to board usage:
- *   GPIO_B_0      -> DIO1_OUT
- *   GPIO_B_1      -> DIO2_OUT
+ *   GPIO_B_0      -> IO_EXP_INT
+ *   GPIO_B_1      -> IO_EXP_RST
  */
 &gpio3 {
 	gpio-line-names = "PCIE_WAKE", "PCIE_CLKREQ", "PCIE_A_PERST", "SDIO_B_D5",
 			  "SDIO_B_D6", "SDIO_B_D7", "SPI_A_WP", "SPI_A_HOLD",
 			  "UART_B_RTS", "UART_B_CTS", "SDIO_B_D0", "SDIO_B_D1",
 			  "SDIO_B_D2", "SDIO_B_D3", "SDIO_B_WP", "SDIO_B_D4",
-			  "PCIE_SM_ALERT", "SDIO_B_CLK", "SDIO_B_CMD", "DIO1_OUT",
-			  "DIO2_OUT", "", "BOOT_SEL0", "BOOT_SEL1",
+			  "PCIE_SM_ALERT", "SDIO_B_CLK", "SDIO_B_CMD", "IO_EXP_INT",
+			  "IO_EXP_RST", "", "BOOT_SEL0", "BOOT_SEL1",
 			  "", "", "SDIO_B_CD", "SDIO_B_PWR_EN",
 			  "HDMI_CEC", "HDMI_HPD";
 };
 
 /*
- * Rename SoM signals according to board usage:
- *   GPIO_B_5      -> DIO2_IN
- *   GPIO_B_6      -> DIO3_IN
- *   GPIO_B_7      -> DIO4_IN
- *   GPIO_B_3      -> DIO4_OUT
- *   GPIO_B_4      -> DIO1_IN
- *   GPIO_B_2      -> DIO3_OUT
+ * Rename SoM signals according to board usage and remove labels for unsed pins:
+ *   GPIO_A_6      -> TFT_RESET
+ *   GPIO_A_7      -> TFT_STBY
+ *   GPIO_B_3      -> CSI_ENABLE
+ *   GPIO_B_2      -> USB_HUB_RST
  */
 &gpio4 {
-	gpio-line-names = "DIO2_IN", "DIO3_IN", "DIO4_IN", "GPIO_C_0",
+	gpio-line-names = "", "", "", "",
 			  "ETH_A_MDC", "ETH_A_MDIO", "ETH_A_RXD0", "ETH_A_RXD1",
 			  "ETH_A_RXD2", "ETH_A_RXD3", "ETH_A_RX_DV", "ETH_A_RX_CLK",
 			  "ETH_A_TXD0", "ETH_A_TXD1", "ETH_A_TXD2", "ETH_A_TXD3",
-			  "ETH_A_TX_EN", "ETH_A_TX_CLK", "DIO4_OUT", "DIO1_IN",
-			  "DIO3_OUT", "GPIO_A_6", "CAN_A_TX", "UART_A_CTS",
+			  "ETH_A_TX_EN", "ETH_A_TX_CLK", "CSI_ENABLE", "",
+			  "USB_HUB_RST", "TFT_RESET", "CAN_A_TX", "UART_A_CTS",
 			  "UART_A_RTS", "CAN_A_RX", "CAN_B_TX", "CAN_B_RX",
-			  "GPIO_A_7", "CARRIER_PWR_EN", "I2S_A_DATA_IN", "I2S_LRCLK";
+			  "TFT_STBY", "CARRIER_PWR_EN", "I2S_A_DATA_IN", "I2S_LRCLK";
 };
 
 /*
@@ -325,4 +323,4 @@ pinctrl_usb_hub: usbhubgrp {
 			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14		0x46
 		>;
 	};
-};
\ No newline at end of file
+};
-- 
2.50.1



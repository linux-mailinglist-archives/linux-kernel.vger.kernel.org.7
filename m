Return-Path: <linux-kernel+bounces-730213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43959B04166
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932D2169896
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072322571A5;
	Mon, 14 Jul 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="H075nMUA"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3925CC75;
	Mon, 14 Jul 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502832; cv=none; b=QIrAknTaH84sfUQySzXHrG/DETPFKnfpzsIQ1u7oeLxiX7dI9u+NikovdZDcoarwbJk2YUZ6nWpxABSLCLH9H5v2yvOFu3fFvJrtYAvz788/7edpxnkNmSOMOk6cSccdbQ3E/oGZI2zYzZgpmCHquN5yt2rj0hLesTxWQwDMfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502832; c=relaxed/simple;
	bh=cSIVc5cj/naj8UPMpuoHR8p2hC7oa1fC6SznprK8FHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgJuEnAI3HPF5Pz1fN3SqhvghkELh2Y4CGP7v1GscG5WpXFv2FfWADUE3wGetLFuqcx9Y106LRI6w840mGJrobEbAvlmkVw49V7npwGECxnjeAU8dQgeJXKfXQeAX+Wk7TCwPwEEfRn7izSrx/Mhew+k+hY7nWdVJpWkrLW65/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=H075nMUA; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5CAAC753B;
	Mon, 14 Jul 2025 16:20:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1752502829; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iWu52B/V45Sj+zawQFQZIAYKWu1W4y6AIeR9Ixu3gtc=;
	b=H075nMUAryfiTjjXkh4NHGhnjvKu4X/PbXOBcPh1WQDB/oWUcUydF9BgX449/rBjDVPYo3
	7gqAUc5yWozk82qk4U1qz16GGLrSGWFx5PuQPRSGGrKRljyFCMD/Qo9AqUw9A435ZdG46t
	utK2drUWyaGr4zW+68dUsqOhfmg9y8MRAkeNEQEpRh8i5mo1vdfNUncl0Il5iGEkIQAKE1
	hmLljy8GnqXnyRUPp4EYsFWrpLpBbU0NICQ5/YghCjTz9JPS1Gw5Cj6LdIQDHKiEeJLgxw
	s3GFKr25YCIMduu5ZD5ViymZqNLbC8lVSBoPZNJaQFGYckGweMR9h6KRp8o6Yg==
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
Subject: [PATCH 08/12] arm64: dts: imx8mp-kontron: Fix GPIO labels for latest BL board
Date: Mon, 14 Jul 2025 16:17:34 +0200
Message-ID: <20250714141852.116455-9-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714141852.116455-1-frieder@fris.de>
References: <20250714141852.116455-1-frieder@fris.de>
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



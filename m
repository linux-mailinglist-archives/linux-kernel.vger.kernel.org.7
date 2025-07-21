Return-Path: <linux-kernel+bounces-739035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20072B0C0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118C84E11B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8E28EA65;
	Mon, 21 Jul 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="ItJCCtQ9"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDF28DB7E;
	Mon, 21 Jul 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092522; cv=none; b=XWRs/NhWEr8jEmSz8TPQzFwtssiFGHissSM1U1XguewbrLY2LD/OtFwxg/Zaw0GT/1HOvprDItFxTliwS3P3NAPts/dLRhRqTWd4SuCZCO0/IO68dpqWBnPKUYFcM3gffeKQR2KGEuzhJXS5vRDlgjasjnaAaqnpu/llf4/tCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092522; c=relaxed/simple;
	bh=janIChdf5G6IMOEIZktEYbOobBm0Gj/FpYAgXhJJl30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMr7OdVLZ75R/wUpRzJNbR2zk/LSxpwPLWKr2EvN2/548I6/92BvhsOaI/8fh1/qc6EkUoAIXt94MlDpTfC5N12bMsRvQeZtiBxI4mqTFeaF+12plnwj1GtLQdtNTFWjlV+r1jwu8knBfBPvjgKx/gUEtxYS5y7B5bOqaT3CLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=ItJCCtQ9; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 961CBC75FC;
	Mon, 21 Jul 2025 12:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092511; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WPwvhrgvdLTtJt+7HBgUaeZ45ADec5RzNRm5Hexhxo0=;
	b=ItJCCtQ9pBvUdP8KWoh+Emu/C3Krlyaem00jtBM/BPmvJXYeafPcfuLkOwPQMppkT+hnok
	d1xiLa+Ygkl7jUx++1+P7RZv2484YkJ0nyUHXrByK/2pc/mvbZRMfnKQ70DVmiJ5Fc4Sb1
	Nzsj3v7nr5mJU5F+iKkrSpdETmC0+rmKjbUBFTRTU/j4oaBoBfcqvzmJXU67brupkfP3F1
	cq5Ptqz1QE522QBHEV41+j4ZbskRlu5Rn/c9cwiOwfuMfGEpkE1uCUj430dCsFYezPHzor
	NK/5GBdZ4hgGVdTtB2xNn5mkx4DegHzfJfkp+DtS9upnH/m6zLRgHLbtPZABPA==
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
Cc: Annette Kobou <annette.kobou@kontron.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andrej Picej <andrej.picej@norik.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Teresa Remmet <t.remmet@phytec.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 01/12] arm64: dts: imx8mm-kontron: Add overlay for LTE extension board
Date: Mon, 21 Jul 2025 12:05:35 +0200
Message-ID: <20250721100701.115548-2-frieder@fris.de>
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

From: Annette Kobou <annette.kobou@kontron.de>

This is an addon for the BL i.MX8MM that features an LTE
modem, a TPM module, some LEDs and a pushbutton.

Signed-off-by: Annette Kobou <annette.kobou@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx8mm-kontron-bl-lte.dtso  | 186 ++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-lte.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0b473a23d1200..05d58ce3f6550 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -341,8 +341,10 @@ imx95-19x19-evk-pcie1-ep-dtbs += imx95-19x19-evk.dtb imx-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-pcie0-ep.dtb imx95-19x19-evk-pcie1-ep.dtb
 
 imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
+imx8mm-kontron-bl-lte-dtbs		:= imx8mm-kontron-bl.dtb imx8mm-kontron-bl-lte.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-bl-lte.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-lte.dtso b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-lte.dtso
new file mode 100644
index 0000000000000..324004b0eca3e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-lte.dtso
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2025 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+#include "imx8mm-pinfunc.h"
+
+&{/} {
+	compatible = "kontron,imx8mm-bl", "kontron,imx8mm-sl", "fsl,imx8mm";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		key-user {
+			label = "user";
+			linux,code = <BTN_0>;
+			gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led_lte>;
+
+		lte-led1-b {
+			label = "lte-led1-blue";
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
+		};
+
+		lte-led1-g {
+			label = "lte-led1-green";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+		};
+
+		lte-led1-r {
+			label = "lte-led1-red";
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>;
+		};
+
+		lte-led2-b {
+			label = "lte-led2-blue";
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>;
+		};
+
+		lte-led2-g {
+			label = "lte-led2-green";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>;
+		};
+
+		lte-led2-r {
+			label = "lte-led2-red";
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&ecspi3 {
+	status = "disabled";
+};
+
+&i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	tpm@2e {
+		compatible = "infineon,slb9673", "tcg,tpm-tis-i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tpm>;
+		reg = <0x2e>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio3>;
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "", "VDD_IO_REF", "TPM_PIRQ#",
+			  "TPM_RESET# ", "", "", "",
+			  "", "LTE_LED1_B", "LTE_LED1_G", "",
+			  "";
+
+	vdd-io-ref-hog {
+		gpio-hog;
+		gpios = <10 GPIO_ACTIVE_HIGH>;
+		line-name = "VDD_IO_REF";
+		output-high;
+	};
+
+	tpm-reset-hog {
+		gpio-hog;
+		gpios = <12 GPIO_ACTIVE_LOW>;
+		line-name = "TPM_RESET#";
+		output-low;
+	};
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio4>;
+	gpio-line-names = "", "", "LTE_RESET", "",
+			  "", "", "", "",
+			  "", "", "", "LTE_PWRKEY",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "LTE_PWR_EN";
+};
+
+&gpio5 {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "LTE_LED2_G", "LTE_LED1_R",
+			  "LTE_LED2_R", "LTE_LED2_B";
+};
+
+&iomuxc {
+	pinctrl_gpio3: gpio3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_DATA04_GPIO3_IO10		0x19 /* VDD_IO_REF */
+		>;
+	};
+
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2		0x19 /* LTE_RESET */
+			MX8MM_IOMUXC_SAI1_TXC_GPIO4_IO11 		0x19 /* LTE_PWRKEY */
+			MX8MM_IOMUXC_SAI1_MCLK_GPIO4_IO20		0x19 /* LTE_PWR_EN */
+		>;
+	};
+
+	pinctrl_gpio_keys: gpiokeysgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12		0x19 /* Pushbutton */
+		>;
+	};
+
+	pinctrl_gpio_led_lte: gpioledltegrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_GPIO3_IO17		0x19 /* LTE_LED1_B */
+			MX8MM_IOMUXC_NAND_WP_B_GPIO3_IO18		0x19 /* LTE_LED1_G */
+			MX8MM_IOMUXC_UART1_TXD_GPIO5_IO23		0x19 /* LTE_LED1_R */
+			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x19 /* LTE_LED2_B */
+			MX8MM_IOMUXC_UART1_RXD_GPIO5_IO22		0x19 /* LTE_LED2_G */
+			MX8MM_IOMUXC_UART2_RXD_GPIO5_IO24		0x19 /* LTE_LED2_R */
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x40000083 /* I2C_A_SCL */
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x40000083 /* I2C_A_SDA */
+		>;
+	};
+
+	pinctrl_tpm: tpmgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_DATA05_GPIO3_IO11		0x19 /* TPM_PIRQ# */
+			MX8MM_IOMUXC_NAND_DATA06_GPIO3_IO12		0x39 /* TPM_RESET# */
+		>;
+	};
+};
-- 
2.50.1



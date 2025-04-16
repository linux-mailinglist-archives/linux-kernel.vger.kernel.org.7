Return-Path: <linux-kernel+bounces-604420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3987A8943A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 08:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23BBA17B57C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 06:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE72797BC;
	Tue, 15 Apr 2025 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAO2rKKb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1F27587D;
	Tue, 15 Apr 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700068; cv=none; b=UYfSIMxqXFr9GnjZwuj3mEiaWYOKhgkfInoNzH3vjBaK2u/cIbJ0YBIiwcwLV+Jh39HxvxphNitw3FcJ06ulk521OYwSEcsj84I7g351IYghi0sXuNKzoKsyl4bqniE3Kj2s4mlhulUq3l8180sHbqTzNQFYMuwPCIz4TlDZH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700068; c=relaxed/simple;
	bh=nFLcCxtjPajV4K6nKMZsoDSF6ba4hBX8t30OvlQ4nJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxXZg8WFJRQ2hXHlfMASdfgvdHojjWTlBK+bfVFLLGwQv5LjPuCOkJ0Q1B9PV7o0QK8wofbR8qwrV5bCwCbKbPFJuaJk34IbHCAqZsuW4SqifxvYYOuS4CWC3cJ2WbGXgvERdhmB+cZ99oar26dhKVVRYFHZhwcyh8DDGmpvIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAO2rKKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52FFDC4CEF5;
	Tue, 15 Apr 2025 06:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744700068;
	bh=nFLcCxtjPajV4K6nKMZsoDSF6ba4hBX8t30OvlQ4nJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cAO2rKKbckPbJin5bIQnkd/vsWwrhwGHYNlacKGV8yi675tiWdJZSOj5roeDoTjR4
	 X2T4NFR/MfREgMCvCw1o88DHrPWH1LkNx52I8ffGBBCVs4yl1tBbLCaJAH8UI0Fi+v
	 zGyZXOzsDHE9kSSbsSgMYFKeszNZQ3zNE2LC76bfHcQV/FDU06h4Jbr6EjUbvxlfc/
	 0YsiyajDOv2K1eIKfvir+LomvlxZLUxucyVLpfQnB1hftXm+Oc+B7IgKaBpaj592dY
	 bcAWRXWmG0ar6D+V+87SX//ny7PdfMQtJ7eN/LrN0ZYqrCdjTubqGuP62hOK2kGwId
	 m0cOD7N0cL4wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49058C369B8;
	Tue, 15 Apr 2025 06:54:28 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Tue, 15 Apr 2025 08:54:29 +0200
Subject: [PATCH v5 6/8] arm64: dts: freescale: Add the GOcontroll Moduline
 Display baseboard
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-initial_display-v5-6-f309f8d71499@gocontroll.com>
References: <20250415-initial_display-v5-0-f309f8d71499@gocontroll.com>
In-Reply-To: <20250415-initial_display-v5-0-f309f8d71499@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744700066; l=14933;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=FbElz7h9Q9+Rezp4sqeRAQ+rTOuCMOZi7wWzuak62ws=;
 b=LnNRBwsKme0uVjvPsFAiuhoyWEwtAsMVJE5VMuhW9icGtCElzTDIUwSdpZo+w0Xc8UGedd0OM
 5k7ZEymegdQAaQwxvrGIpiWXhgJE7est0mLNEqkfbIP2ig5TLdY/2gJ
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

The Moduline Display platform is a part of the wider GOcontroll Moduline
ecosystem. These are embedded controllers that focus on modularity with
their swappable IO modules.

The base Moduline Display board includes a board-to-board connector with
various busses to enable adding new display types required by the
application. It includes 2 Moduline IO module slots, a simple mono
codec/amplifier, a four channel adc, 2 CAN busses, an RTC and optional
wifi/bluetooth.

busses to the display adapter include:
- 4 lane LVDS
- 4 lane MIPI-DSI
- 4 lane MIPI-CSI
- HDMI 2.0a
- USB 2.0
- I2S
- I2C
- SPI

Also a couple of GPIO and PWM pins for controlling various ICs on the
display adapter board.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 .../imx8mp-tx8p-ml81-moduline-display-106.dts      | 525 +++++++++++++++++++++
 1 file changed, 525 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106.dts b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106.dts
new file mode 100644
index 0000000000000000000000000000000000000000..0de49775a0bb2879d60956f8135dd263eaab6c69
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106.dts
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2025 GOcontroll B.V.
+ * Author: Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mp-tx8p-ml81.dtsi"
+
+/ {
+	compatible = "gocontroll,moduline-display", "fsl,imx8mp";
+	chassis-type = "embedded";
+	hardware = "Moduline Display V1.06";
+
+	aliases {
+		can0 = &flexcan1;
+		can1 = &flexcan2;
+		ethernet0 = &eqos;
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc2;
+		rtc0 = &rtc_pcf; /* i2c rtc is the main rtc */
+		rtc1 = &snvs_rtc;
+		spi0 = &ecspi2; /* spidev number compatibility */
+		spi1 = &ecspi1; /* spidev number compatibility */
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	external-sensor-supply {
+		compatible = "regulator-output";
+		vout-supply = <&reg_5v0_sensor>;
+	};
+
+	reg_1v8_per: regulator-1v8-per {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&pinctrl_reg_1v8>;
+		pinctrl-names = "default";
+		power-supply = <&reg_3v3_per>;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "1v8-per";
+		gpio = <&gpio3 25 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_3v3_per: regulator-3v3-per {
+		compatible = "regulator-fixed";
+		power-supply = <&reg_6v4>;
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3v3-per";
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		power-supply = <&reg_6v4>;
+		regulator-always-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "5v0";
+	};
+
+	reg_5v0_sensor: regulator-5v0-sensor {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&pinctrl_reg_5v0_sensor>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "5v0-supply-external-sensor";
+		gpio = <&gpio4 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_6v4: regulator-6v4 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <6400000>;
+		regulator-min-microvolt = <6400000>;
+		regulator-name = "6v4";
+	};
+
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&pinctrl_flexcan1_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can1-stby";
+		gpio = <&gpio4 3 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&pinctrl_flexcan2_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can2-stby";
+		gpio = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&cpudai>;
+		simple-audio-card,name = "tas2505-audio";
+		simple-audio-card,routing = "Speaker", "DAC";
+		simple-audio-card,widgets = "Speaker", "Speaker External";
+
+		simple-audio-card,codec {
+			sound-dai = <&tas2505>;
+		};
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai = <&sai6>;
+		};
+	};
+
+	wifi_powerseq: wifi-powerseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-0 = <&pinctrl_wl_reg>;
+		pinctrl-names = "default";
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <500000>;
+		reset-gpios = <&gpio2 19 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>,
+			   <&gpio1 11 GPIO_ACTIVE_LOW>,
+			   <&gpio1 10 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	connector@0 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <0>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		i2c-bus = <&i2c2>;
+		reset-gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
+		slot-number = <1>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_3v3_per>;
+	};
+
+	connector@1 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <1>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		i2c-bus = <&i2c2>;
+		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		slot-number = <2>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_3v3_per>;
+	};
+
+	adc@2 {
+		compatible = "microchip,mcp3004";
+		reg = <2>;
+		spi-max-frequency = <2300000>;
+		vref-supply = <&reg_vdd_3v3>;
+	};
+};
+
+&flexcan1 {
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	pinctrl-names = "default";
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	pinctrl-names = "default";
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	tas2505: audio-codec@18 {
+		compatible = "ti,tas2505";
+		reg = <0x18>;
+		clocks = <&clk IMX8MP_CLK_AUDIOMIX_SAI6_MCLK1>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+		aic32x4-gpio-func = <0xff 0xff 0xff 0xff 0xff>;
+		av-supply = <&reg_1v8_per>;
+		dv-supply = <&reg_1v8_per>;
+		iov-supply = <&reg_vdd_3v3>;
+		pinctrl-0 = <&pinctrl_tas_reset>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
+	};
+
+	rtc_pcf: rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+		quartz-load-femtofarads = <7000>;
+
+		clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_bt: btgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14
+			MX8MP_DSE_X1
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15
+			MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI
+			MX8MP_DSE_X4
+			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO
+			(MX8MP_DSE_X4 | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK
+			MX8MP_DSE_X4
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12
+			MX8MP_DSE_X1
+			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11
+			MX8MP_DSE_X1
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10
+			MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			 MX8MP_IOMUXC_SPDIF_RX__CAN1_RX
+			 (MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			 MX8MP_IOMUXC_SPDIF_TX__CAN1_TX
+			 (MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_flexcan1_reg: flexcan1reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			 MX8MP_IOMUXC_UART3_TXD__CAN2_RX
+			 (MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			 MX8MP_IOMUXC_UART3_RXD__CAN2_TX
+			 (MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_flexcan2_reg: flexcan2reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL
+			MX8MP_I2C_DEFAULT
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA
+			MX8MP_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2-gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16
+			MX8MP_I2C_DEFAULT
+			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17
+			MX8MP_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_MISO__I2C4_SCL
+			MX8MP_I2C_DEFAULT
+			MX8MP_IOMUXC_ECSPI2_SS0__I2C4_SDA
+			MX8MP_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_i2c4_gpio: i2c4-gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_MISO__GPIO5_IO12
+			MX8MP_I2C_DEFAULT
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13
+			MX8MP_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_usdhc2: pinctrlusdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD
+			(MX8MP_DSE_X2 | MX8MP_USDHC_DATA_DEFAULT)
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0
+			(MX8MP_DSE_X2 | MX8MP_USDHC_DATA_DEFAULT)
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1
+			(MX8MP_DSE_X2 | MX8MP_USDHC_DATA_DEFAULT)
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2
+			(MX8MP_DSE_X2 | MX8MP_USDHC_DATA_DEFAULT)
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3
+			(MX8MP_DSE_X2 | MX8MP_USDHC_DATA_DEFAULT)
+		>;
+	};
+
+	pinctrl_reg_1v8: reg-1v8-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_MCLK__GPIO3_IO25
+			MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_reg_5v0_sensor: reg-5v0-sensorgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD7__GPIO4_IO09
+			MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_sai6: sai6grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD6__AUDIOMIX_SAI6_TX_SYNC
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_SAI1_RXD4__AUDIOMIX_SAI6_TX_BCLK
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_SAI1_TXD5__AUDIOMIX_SAI6_TX_DATA00
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_SAI1_TXD7__AUDIOMIX_SAI6_MCLK
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_SAI1_RXD5__AUDIOMIX_SAI6_RX_DATA00
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_tas_reset: tasresetgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD3__GPIO3_IO24
+			MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_SAI3_RXD__UART2_DCE_RTS
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_SAI3_RXC__UART2_DCE_CTS
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B
+			(MX8MP_DSE_X6 | MX8MP_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_wl_int: wlintgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13
+			(MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_wl_reg: wlreggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19
+			MX8MP_DSE_X1
+		>;
+	};
+};
+
+&sai6 {
+	assigned-clocks = <&clk IMX8MP_CLK_SAI6>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+	pinctrl-0 = <&pinctrl_sai6>;
+	pinctrl-names = "default";
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&pinctrl_uart2>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "infineon,cyw43439-bt", "brcm,bcm4329-bt";
+		interrupt-parent = <&gpio1>;
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "host-wakeup";
+		device-wakeup-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		max-speed = <921600>;
+		pinctrl-0 = <&pinctrl_bt>;
+		pinctrl-names = "default";
+		shutdown-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&reg_3v3_per>;
+		vddio-supply = <&reg_3v3_per>;
+	};
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "peripheral";
+};
+
+&usdhc2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
+	assigned-clock-rates = <50000000>;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	max-frequency = <50000000>;
+	mmc-pwrseq = <&wifi_powerseq>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-names = "default";
+	sd-uhs-sdr25;
+	vmmc-supply = <&reg_3v3_per>;
+	status = "okay";
+
+	wifi@1 {
+		compatible = "infineon,cyw43439-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "host-wake";
+		pinctrl-0 = <&pinctrl_wl_int>;
+		pinctrl-names = "default";
+		brcm,board-type = "GOcontroll,moduline";
+	};
+};
+
+&wdog1 {
+	pinctrl-0 = <&pinctrl_wdog>;
+	pinctrl-names = "default";
+	fsl,ext-reset-output;
+	status = "okay";
+};

-- 
2.49.0




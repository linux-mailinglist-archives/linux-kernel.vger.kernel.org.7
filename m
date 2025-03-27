Return-Path: <linux-kernel+bounces-578756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A502A73611
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 16:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4603AB7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14041C8FB4;
	Thu, 27 Mar 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1MZ178y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99019DF75;
	Thu, 27 Mar 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090759; cv=none; b=pxSis51pfYEdGiZcqmV5VdeGPVFqI9Pdb1mlcZ3Ug1LH5eWiL4KgPEw+H02tDt9Zjj1wPO7Yb2Elj/2cSvZiVsXzOkEuZFgpn6PwL4dYP9LxyBjJGVzypVuZyIfppehWaWuLxl3vGGrUDDB3OEvZcN2VtOBSy1+0ky0EiYn1ufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090759; c=relaxed/simple;
	bh=iF2Ayu2qCnX2JHCCmtZUm0aS2PaC0IJWjU52Ou3B5EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H1yhLz8PE4ung3f6iddYXpjEZrzpmj8E5IK4Cm43tGfYTNfQwkMBU6snRFQ1K87fUC6IuYj+Gym6m+SiFudIuYSbGzevLOfLEqzuLYa1uOMj2C/LGqdXE858xS7mhMTVMCeuzgu/kQKkGmFR2sMatSHOf/q2oq/hKt024GcHE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1MZ178y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 718C9C4CEF7;
	Thu, 27 Mar 2025 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743090759;
	bh=iF2Ayu2qCnX2JHCCmtZUm0aS2PaC0IJWjU52Ou3B5EE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z1MZ178yPkE9DGABfz7QnOd/h/g6HyQrrfeG9dH4TKr3HQKyQAhBoaWCQMMFECojm
	 iNh9BZ9Dy3h8K6pedtv7ih17PUHD/m9hkf6W2X4YTDKIlCumVocuuc201TtjKZZz9a
	 cuZ8NFxYNX3JSzuOToMWXgJOkFMYE1P+VJp06H+EhsubrpcJ/aAQ/PmxiWIS5rjVzQ
	 xdD5OrfhFBhg6JceD58V03enO3s53JG/GfgtxtjANgI0aiZf3kwLFcemK3i8FibWER
	 0TQzemsBwY03Xg1iVcO2NpIjy7Fbi73fKTEiVG73gXkPOHIx5qXRgNHOUh6YP0El1D
	 qKSGliQSvKWXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6406FC36010;
	Thu, 27 Mar 2025 15:52:39 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 27 Mar 2025 16:52:41 +0100
Subject: [PATCH v3 6/8] arm64: dts: freescale: Add the GOcontroll Moduline
 Display baseboard
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-initial_display-v3-6-4e89ea1676ab@gocontroll.com>
References: <20250327-initial_display-v3-0-4e89ea1676ab@gocontroll.com>
In-Reply-To: <20250327-initial_display-v3-0-4e89ea1676ab@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743090757; l=16634;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=sGxXlPEp0IYObrLt0XyIE0e57nwcYtizz9HWa0Ky/lg=;
 b=Mi/La9KCUCOJv/acZyiAR8vghQJglF/NK8FZ78O5UFNWcXqFZ2kuq9kpbLWJxVAbbjSsFzxzR
 ZkYNOfWfSasD2sH1PI17FzNc6jGj0jSVGr1sBIdZQ+TwUK06OUVmWtV
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
 .../imx8mp-tx8p-ml81-moduline-display-106.dtsi     | 535 +++++++++++++++++++++
 1 file changed, 535 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..a3ab389c9744f5189d5a8a802aa4c4ebb9f7b12b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106.dtsi
@@ -0,0 +1,535 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2025 GOcontroll B.V.
+ * Author: Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+#include "imx8mp-tx8p-ml81.dtsi"
+
+/ {
+	chassis-type = "embedded";
+	compatible = "gocontroll,moduline-display", "fsl,imx8mp";
+	hardware =  "Moduline Display V1.06";
+
+	aliases {
+		ethernet0 = &eqos;
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc2;
+		spi0 = &ecspi2; /* spidev number compatibility */
+		spi1 = &ecspi1; /* spidev number compatibility */
+		can0 = &flexcan1;
+		can1 = &flexcan2;
+		rtc0 = &rtc_pcf; /* i2c rtc is the main rtc */
+		rtc1 = &snvs_rtc;
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
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can1-stby";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan1_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 3 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan2_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_1v8_per: regulator-1v8-per {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8-per";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_1v8>;
+		gpio = <&gpio3 25 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		power-supply = <&reg_3v3_per>;
+	};
+
+	reg_3v3_per: regulator-3v3-per {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3-per";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		power-supply = <&reg_6v4>;
+	};
+
+	reg_5v0_sensor: regulator-5v0-sensor {
+		compatible = "regulator-fixed";
+		regulator-name = "5v0-supply-external-sensor";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_5v0_sensor>;
+		gpio = <&gpio4 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		power-supply = <&reg_6v4>;
+	};
+
+	reg_6v4: regulator-6v4 {
+		compatible = "regulator-fixed";
+		regulator-name = "6v4";
+		regulator-min-microvolt = <6400000>;
+		regulator-max-microvolt = <6400000>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "tas2505-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&cpudai>;
+		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,widgets =
+		"Speaker", "Speaker External";
+		simple-audio-card,routing =
+		"Speaker", "DAC";
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai = <&sai6>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&tas2505>;
+		};
+	};
+
+	wifi_powerseq: wifi-powerseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wl_reg>;
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <500000>;
+		reset-gpios = <&gpio2 19 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <
+	&gpio2 12 GPIO_ACTIVE_LOW
+	&gpio1 11 GPIO_ACTIVE_LOW
+	&gpio1 10 GPIO_ACTIVE_LOW
+	>;
+	status = "okay";
+
+	connector@0 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <0>;
+		reset-gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
+		sync-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&reg_3v3_per>;
+		vddp-supply = <&reg_5v0>;
+		vddhpp-supply = <&reg_6v4>;
+		i2c-bus = <&i2c2>;
+		slot-number = <1>;
+		spi-max-frequency = <54000000>;
+
+	};
+
+	connector@1 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <1>;
+		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		sync-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&reg_3v3_per>;
+		vddp-supply = <&reg_5v0>;
+		vddhpp-supply = <&reg_6v4>;
+		i2c-bus = <&i2c2>;
+		slot-number = <2>;
+		spi-max-frequency = <54000000>;
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
+/* I2C2 bus to modules */
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	sda-gpios = <&gpio5 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio5 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	tas2505: tas2505@18 {
+		compatible = "ti,tas2505";
+		reg = <0x18>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tas_reset>;
+		reset-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+
+		dv-supply = <&reg_1v8_per>;
+		iov-supply = <&reg_vdd_3v3>;
+		av-supply = <&reg_1v8_per>;
+
+		clocks = <&clk IMX8MP_CLK_AUDIOMIX_SAI6_MCLK1>;
+		clock-names = "mclk";
+		aic32x4-gpio-func= <
+			0xff
+			0xff
+			0xff
+			0xff
+			0xff
+		>;
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
+/* tas2505 */
+&sai6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai6>;
+	status = "okay";
+	assigned-clocks = <&clk IMX8MP_CLK_SAI6>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+};
+
+/* debug/external */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+	status = "okay";
+
+	/* muRata 1YN/1DX */
+	bluetooth {
+		compatible = "infineon,cyw43439-bt", "brcm,bcm4329-bt";
+		max-speed = <921600>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_bt>;
+		device-wakeup-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "host-wakeup";
+		vddio-supply = <&reg_3v3_per>;
+		vbat-supply = <&reg_3v3_per>;
+	};
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "peripheral";
+};
+
+&usdhc2 {
+	max-frequency = <50000000>;
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
+	assigned-clock-rates = <50000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	mmc-pwrseq = <&wifi_powerseq>;
+	vmmc-supply = <&reg_3v3_per>;
+
+	cap-power-off-card;
+	keep-power-in-suspend;
+	non-removable;
+	sd-uhs-sdr25;
+
+	status = "okay";
+
+	/* muRata 1YN/1DX */
+	wifi@1 {
+		compatible = "infineon,cyw43439-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		brcm,board-type = "GOcontroll,moduline";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wl_int>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "host-wake";
+	};
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_reg_1v8: reg-1v8-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_MCLK__GPIO3_IO25 /* COM pin 144 */
+			MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_reg_5v0_sensor: reg-5v0-sensorgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD7__GPIO4_IO09 /* COM pin 108 */
+			MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_tas_reset: tasresetgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD3__GPIO3_IO24 /* COM pin 143 */
+			MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_bt: btgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14 /* COM pin 27 */
+			MX8MP_DSE_X1
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12 /* COM pin 34 */
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15 /* COM pin 28 */
+			MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+		MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI /* COM pin 46 */
+		MX8MP_DSE_X4
+		MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO /* COM pin 47 */
+		(MX8MP_DSE_X4 | MX8MP_HYS_SCHMITT)
+		MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK /* COM pin 48 */
+		MX8MP_DSE_X4
+		MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12 /* COM pin 51 */
+		MX8MP_DSE_X1
+		MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11 /* COM pin 162 */
+		MX8MP_DSE_X1
+		MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10 /* COM pin 161 */
+		MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			 MX8MP_IOMUXC_SPDIF_RX__CAN1_RX /* COM pin 81 */
+			 (MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			 MX8MP_IOMUXC_SPDIF_TX__CAN1_TX /* COM pin 76 */
+			 (MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_flexcan1_reg: flexcan1reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03 /* COM pin 101 */
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			 MX8MP_IOMUXC_UART3_TXD__CAN2_RX /* COM pin 61 */
+			 (MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			 MX8MP_IOMUXC_UART3_RXD__CAN2_TX /* COM pin 62 */
+			 (MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_flexcan2_reg: flexcan2reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09 /* COM pin 44 */
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL /* COM pin 41 */
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA /* COM pin 40 */
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2-gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16 /* COM pin 41 */
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17 /* COM pin 40 */
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_MISO__I2C4_SCL /* COM pin 70 */
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+			MX8MP_IOMUXC_ECSPI2_SS0__I2C4_SDA /* COM pin 69 */
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+		>;
+	};
+
+	pinctrl_i2c4_gpio: i2c4-gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_MISO__GPIO5_IO12 /* COM pin 70 */
+			(MX8MP_DSE_X4 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13 /* COM pin 69 */
+			(MX8MP_DSE_X4 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+		>;
+	};
+
+	pinctrl_sai6: sai6grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD6__AUDIOMIX_SAI6_TX_SYNC /* COM pin 95 */
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_SAI1_RXD4__AUDIOMIX_SAI6_TX_BCLK /* COM pin 105 */
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_SAI1_TXD5__AUDIOMIX_SAI6_TX_DATA00 /* COM pin 110 */
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_SAI1_TXD7__AUDIOMIX_SAI6_MCLK /* COM pin 96 */
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT)
+			MX8MP_IOMUXC_SAI1_RXD5__AUDIOMIX_SAI6_RX_DATA00 /* COM pin 106 */
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX /* COM pin 60 */
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX /* COM pin 59 */
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX /* COM pin 64 */
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX /* COM pin 63 */
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_SAI3_RXD__UART2_DCE_RTS /* COM pin 65 */
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_SAI3_RXC__UART2_DCE_CTS /* COM pin 66 */
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_usdhc2: pinctrlusdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK /* COM pin 57 */
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD /* COM pin 56 */
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0 /* COM pin 52 */
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1 /* COM pin 53 */
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2 /* COM pin 54 */
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3 /* COM pin 55 */
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B /* COM pin 153 */
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_wl_int: wlintgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13 /* COM pin 36 */
+			(MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_wl_reg: wlreggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19 /* COM pin 15 */
+			MX8MP_DSE_X1
+		>;
+	};
+};

-- 
2.49.0




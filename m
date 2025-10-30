Return-Path: <linux-kernel+bounces-877616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A87C1E961
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74DE54E78BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D436732E699;
	Thu, 30 Oct 2025 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP+G3ucg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772AF3002C2;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806142; cv=none; b=teeb3zN9hkmxECI/uxnqg1VwymnpQQn+VNkbCY+Io9Ph7QxQxFbo4zIfCd1e2+WaEbIenpzqho0R994lTirdQm1Zf/lJU3KXjU7gPaxCWIBwluynoF/E5UTXQuEvGwVwf9t0TCVSXRibBdlFbIzHQcA2LdOZ9ASaS+UfaeIKfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806142; c=relaxed/simple;
	bh=pKRFX8L+lf5Nl1kxUW4q1OqIM4A5ZoN8Ej0z5TNMIRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQMOZQje5lhH5FH8E3pjHxOdAV80GdPkoKiORC9pghDoBrXu/ZkkaZUlO8CaRXWM3NhwItn3C+GoFnTdWBM0oudbZYneTK1M6kKch5CA+PxKHcvhyiIwgkFpC8m2bEUQJc5t1PlHLEUy+Ljw+Qf0pYzl+vZdssviifyqa9FaFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP+G3ucg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EDA5C116D0;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761806142;
	bh=pKRFX8L+lf5Nl1kxUW4q1OqIM4A5ZoN8Ej0z5TNMIRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rP+G3ucgXar4LJRRMENZfTGPatYM7SNjMLP7jPnU7CyHSPdoa1O+tdUoZXLKXp94k
	 iQiyGAI0dCis+3cWLr7NAq3/E2rZGQbiIQwhlUlQZzUTuhYE0KauyB7uj3EP9bbHtS
	 VIfdZHpnI+7p9afXMy3x36SlMn4d7VvJls/zfOhml+esI3ABQZI1zK+Y92IJZc/PKa
	 7Qu2JwV9+GqFfLMaVBzs2HT8ZGVGOoHiWu8ra8yfW2yRFc9h/zR3z0votZ4ZCc4zsc
	 Xm5MtB7NYfq5VbdNA+ZhujKZ5/Wzxg6Sm1RlUbMUXhPj1jDNTssm7x/S6XpjRFH0ks
	 nJ8u5WDyWjgZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AF2CCF9F8;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 30 Oct 2025 07:35:42 +0100
Subject: [PATCH v3 6/6] arm64: dts: freescale: Add the GOcontroll Moduline
 Mini
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-mini_iv-v3-6-ef56c4d9f219@gocontroll.com>
References: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
In-Reply-To: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761806140; l=18231;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=ef1OSb1C1wE1iHOzW7FGqaSt5I9yrhaRRUey9Gei/8Y=;
 b=aKhfOI2RaY3pYvCBbd/m1cU2f6tyd1FO8RMhAIASrhLHUJpPAWgp2xiF8N1yQc927xvCCg6io
 RNFZc3Muu4NCchTrBOBa9jxe86733SUMcPpsMgG6Sf5eDBpo3plt1P2
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

The Moduline Mini is a part of the wider GOcontroll Moduline ecosystem. These
are embedded controllers that focus on modularity with their swappable IO
modules.

Features:
- up to 4 Moduline IO modules
- 2 CAN busses
- 1 Ethernet
- 4 RGB leds
- 1 3D accelerometer
- optional Wi-Fi/Bluetooth
- optional 4G/GPS

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 .../imx8mm-tx8m-1610-moduline-mini-111.dts         | 688 +++++++++++++++++++++
 2 files changed, 689 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index b2fef44e0a370..0a84c7dc89e39 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -125,6 +125,7 @@ imx8mm-evkb-pcie-ep-dtbs += imx8mm-evkb.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk-pcie-ep.dtb imx8mm-evkb-pcie-ep.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-tx8m-1610-moduline-iv-306-d.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-tx8m-1610-moduline-mini-111.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610-moduline-mini-111.dts b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610-moduline-mini-111.dts
new file mode 100644
index 0000000000000..0091196a27d22
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610-moduline-mini-111.dts
@@ -0,0 +1,688 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mm-tx8m-1610.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	chassis-type = "embedded";
+	compatible = "gocontroll,moduline-mini-111", "karo,imx8mm-tx8m-1610", "fsl,imx8mm";
+	hardware = "Moduline Mini V1.11";
+	model = "GOcontroll Moduline Mini";
+
+	aliases {
+		usb-host = &usbotg2;
+		usbotg = &usbotg1;
+		spi0 = &ecspi2; /* spidev number compatibility */
+		spi1 = &ecspi3; /* spidev number compatibility */
+		spi2 = &ecspi1; /* spidev number compatibility */
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	mcp_clock: mcp-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <20000000>;
+	};
+
+	reg_3v3_comm: regulator-3v3-communication {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pinctrl_reg_comm>;
+		pinctrl-names = "default";
+		power-supply = <&reg_6v4>;
+		/* also powers the cellular modem which can't vote on the regulator */
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3v3_comm";
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
+		gpio = <&gpio2 12 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&pinctrl_can1_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can1-stby";
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		gpio = <&gpio3 15 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&pinctrl_can2_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can2-stby";
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-0 = <&pinctrl_wl_reg>;
+		pinctrl-names = "default";
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <500000>;
+		reset-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>,
+		   <&gpio3 23 GPIO_ACTIVE_LOW>,
+		   <&gpio3 1 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	connector@0 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <0>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+		slot-number = <3>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	connector@1 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <1>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
+		slot-number = <4>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
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
+&ecspi2 {
+	cs-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>,
+		   <&gpio3 9 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	can@0 {
+		compatible = "microchip,mcp25625";
+		reg = <0>;
+		clocks = <&mcp_clock>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_can1>;
+		pinctrl-names = "default";
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&reg_vdd_3v3>;
+		xceiver-supply = <&reg_can1_stby>;
+	};
+
+	can@1 {
+		compatible = "microchip,mcp25625";
+		reg = <1>;
+		clocks = <&mcp_clock>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_can2>;
+		pinctrl-names = "default";
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&reg_vdd_3v3>;
+		xceiver-supply = <&reg_can2_stby>;
+	};
+};
+
+&ecspi3 {
+	cs-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>,
+		   <&gpio1 2 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	connector@0 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <0>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+		slot-number = <1>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	connector@1 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <1>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
+		slot-number = <2>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+};
+
+&gpu_2d {
+	status = "disabled";
+};
+
+&gpu_3d {
+	status = "disabled";
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
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	lp5012@14 {
+		compatible = "ti,lp5012";
+		reg = <0x14>;
+		vled-supply = <&reg_6v4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		multi-led@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "case-led1";
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
+		};
+
+		multi-led@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "case-led2";
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
+		};
+
+		multi-led@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "case-led3";
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
+		};
+
+		multi-led@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "case-led4";
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
+		};
+	};
+
+	accelerometer@18 {
+		compatible = "st,lis2dw12";
+		reg = <0x18>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <3 IRQ_TYPE_EDGE_RISING>, <5 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-0 = <&pinctrl_lis_int>;
+		pinctrl-names = "default";
+		vddio-supply = <&reg_vdd_3v3>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	humidity-sensor@5f {
+		compatible = "st,hts221";
+		reg = <0x5f>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <10 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-0 = <&pinctrl_hts_int>;
+		pinctrl-names = "default";
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+};
+
+&iomuxc {
+	pinctrl_bt: btgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_can1: can1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_can1_reg: can1reggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12
+				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_can2: can2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_NAND_DATA00_GPIO3_IO6
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_can2_reg: can2reggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_RE_B_GPIO3_IO15
+				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO
+				(MX8MM_DSE_X4 | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_NAND_CE0_B_GPIO3_IO1
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO
+				(MX8MM_DSE_X4 | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_NAND_DATA03_GPIO3_IO9
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO
+				(MX8MM_DSE_X4 | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_GPIO1_IO02_GPIO1_IO2
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_hts_int: htsintgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_DATA04_GPIO3_IO10
+				(MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL
+				MX8MM_I2C_DEFAULT
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA
+				MX8MM_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2-gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16
+				MX8MM_I2C_DEFAULT
+			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17
+				MX8MM_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL
+				MX8MM_I2C_DEFAULT
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA
+				MX8MM_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3-gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18
+				MX8MM_I2C_DEFAULT
+			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19
+				MX8MM_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_lis_int: lisintgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3
+				(MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5
+				(MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_reg_comm: reg_commgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_sysfs_gpios: sysfsgpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_SD2_WP_GPIO2_IO20
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_usdhc2: pinctrlusdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK
+				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+		>;
+	};
+
+	pinctrl_wl_int: wlintgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20
+				(MX8MM_PULL_UP | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_wl_reg: wlreggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART4_RXD_GPIO5_IO28
+				MX8MM_DSE_X1
+		>;
+	};
+};
+
+&uart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "infineon,cyw43439-bt", "brcm,bcm4329-bt";
+		device-wakeup-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wakeup";
+		interrupt-parent = <&gpio3>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		max-speed = <921600>;
+		pinctrl-0 = <&pinctrl_bt>;
+		pinctrl-names = "default";
+		shutdown-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&reg_3v3_comm>;
+		vddio-supply = <&reg_3v3_comm>;
+	};
+};
+
+&uart2 {
+	pinctrl-0 = <&pinctrl_uart2>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-0 = <&pinctrl_uart3>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usbotg1 {
+	disable-over-current;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbotg2 {
+	disable-over-current;
+	dr_mode = "host";
+	vbus-supply = <&reg_5v0>;
+	status = "okay";
+};
+
+&usdhc2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	max-frequency = <50000000>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-names = "default";
+	sd-uhs-sdr25;
+	vmmc-supply = <&reg_3v3_comm>;
+	status = "okay";
+
+	wifi@1 {
+		compatible = "infineon,cyw43439-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		pinctrl-0 = <&pinctrl_wl_int>;
+		pinctrl-names = "default";
+		interrupt-names = "host-wake";
+		interrupt-parent = <&gpio3>;
+		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+		brcm,board-type = "GOcontroll,moduline";
+	};
+};
+
+&vpu_blk_ctrl {
+	status = "disabled";
+};
+
+&vpu_g1 {
+	status = "disabled";
+};
+
+&vpu_g2 {
+	status = "disabled";
+};
+
+&wdog1 {
+	status = "okay";
+};

-- 
2.51.2




Return-Path: <linux-kernel+bounces-869039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8319C06C89
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4791B87E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CA830C361;
	Fri, 24 Oct 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="o8Sk0x0M"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56C239E80;
	Fri, 24 Oct 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317383; cv=none; b=Vgd13ISd3dqZ2EcDNFbQPYoSQQAL3fJN794wZMFJ/dk23hdDPqEMUGuSGrrIuDUd7z6GaiPK8C2XHFgSPw/Vw6SP8DCGu3W90c511E7HStdCmK6+JmNZBYCmj/zhwoGIYfXyV05jO7wCy9cdrIulzwZZYFR7iAFa6FZ4zyYxWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317383; c=relaxed/simple;
	bh=2sL7uTFC/tb/qDWfhblrg1CV0gedMnasJtGXnESteCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeK3+31W3XuKNxbrjIUwH27tTlF246J7ctYGvTGfW0es9ws8J1NHF709P3Erk6noUzLEgRb3cbC4qMP79CZX8stKjEY0N6K/hTj8p2JKH+xp//jsO1YS81JMDS8qhW0xQSvE2S5fBB6u7BpDwAk8nNJPHdkv0wqQ5tojKl7MWoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=o8Sk0x0M; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DA3E525C7A;
	Fri, 24 Oct 2025 16:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1761317371;
	bh=EfvyVNIwWLrffqUlxU6dL8rreAgi0eMRlkQSodkyAko=; h=From:To:Subject;
	b=o8Sk0x0MkfzOHaZMd1nBZkBnK0bDYJ1/8jLyui4sDXz4f2PDZUrxBu1J0OwLWy60i
	 xTsh6ZF0Nc8WDVVbV56HlbSfG2uBJkHGEv0Zt5wmgDxE8vGcHMtw11dR+ahF0+3/Ed
	 6mb97LGlBvJl9FAhKOnCh8PjpB+R2F5EJWaOFqn1qoILg6RVdH8cUcZ03IZOGOt6v/
	 adJEqXVlROOgkLjIBma+GdiBzj2cpzWdPJ2bgc65ZDzm1rehmrr6IiEbZSnWQmaG9M
	 cmbuoJL/HwJ7/GFr+8roxCQXPRNcClfuRqT5/TYOr/Q51LgONrmFHNZvHZtAs8iyO4
	 D/DdZvQVd958A==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	Vitor Soares <vitor.soares@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/2] arm64: dts: freescale: add Toradex SMARC iMX95
Date: Fri, 24 Oct 2025 16:49:21 +0200
Message-Id: <20251024144921.77714-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251024144921.77714-1-francesco@dolcini.it>
References: <20251024144921.77714-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

Add DT support for Toradex SMARC iMX95 SoM and Development carrier
board.

The module consists of an NXP i.MX95 family SoC, up to 16GB of LPDDR5
RAM and up to 128GB of storage, a USB 3.0 Host Hub and 2.0 OTG, two
Gigabit Ethernet PHYs, a 10 Gigabit Ethernet interface, an I2C EEPROM
and Temperature Sensor, an RX8130 RTC, a Quad/Dual lane CSI interface,
and some optional addons: TPM 2.0, DSI, LVDS, DisplayPort (through a
DSI-DP bridge), and Wi-Fi/BT module.

Link: https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
Link: https://www.toradex.com/products/carrier-board/smarc-development-board-kit
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Co-developed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Co-developed-by: Vitor Soares <vitor.soares@toradex.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |    1 +
 .../dts/freescale/imx95-toradex-smarc-dev.dts |  277 ++++
 .../dts/freescale/imx95-toradex-smarc.dtsi    | 1153 +++++++++++++++++
 3 files changed, 1431 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-toradex-smarc-dev.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 525ef180481d..53f764d8c9a8 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -373,6 +373,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx943-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-15x15-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx95-toradex-smarc-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-tqma9596sa-mb-smarc-2.dtb
 
 imx95-15x15-evk-pcie0-ep-dtbs = imx95-15x15-evk.dtb imx-pcie0-ep.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc-dev.dts b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc-dev.dts
new file mode 100644
index 000000000000..5b05f256fd52
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc-dev.dts
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
+ * https://www.toradex.com/products/carrier-board/smarc-development-board-kit
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/pwm/pwm.h>
+#include "imx95-toradex-smarc.dtsi"
+
+/ {
+	model = "Toradex SMARC iMX95 on Toradex SMARC Development Board";
+	compatible = "toradex,smarc-imx95-dev",
+		     "toradex,smarc-imx95",
+		     "fsl,imx95";
+
+	reg_carrier_1p8v: regulator-carrier-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "On-carrier 1V8";
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "tdx-smarc-wm8904";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN2L", "Line In Jack",
+			"IN2R", "Line In Jack",
+			"Microphone Jack", "MICBIAS",
+			"IN1L", "Microphone Jack";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack";
+
+		codec_dai: simple-audio-card,codec {
+			clocks = <&scmi_clk IMX95_CLK_SAI3>;
+			sound-dai = <&wm8904_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+	};
+};
+
+/* SMARC GBE0 */
+&enetc_port0 {
+	status = "okay";
+};
+
+/* SMARC GBE1 */
+&enetc_port1 {
+	status = "okay";
+};
+
+/* SMARC CAN0 */
+&flexcan1 {
+	status = "okay";
+};
+
+/* SMARC CAN1 */
+&flexcan2 {
+	status = "okay";
+};
+
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio12>, <&pinctrl_gpio13>;
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio10>, <&pinctrl_gpio11>;
+};
+
+&gpio5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio2>,
+		    <&pinctrl_gpio3>,
+		    <&pinctrl_gpio4>,
+		    <&pinctrl_gpio6>,
+		    <&pinctrl_gpio8>,
+		    <&pinctrl_gpio9>;
+};
+
+/* SMARC I2C_CAM0 */
+&i2c_cam0 {
+	status = "okay";
+};
+
+/* SMARC I2C_CAM1 */
+&i2c_cam1 {
+	status = "okay";
+};
+
+/* SMARC I2C_GP */
+&lpi2c2 {
+	status = "okay";
+
+	wm8904_1a: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sai3>, <&pinctrl_sai3_mclk>;
+		#sound-dai-cells = <0>;
+		clocks = <&scmi_clk IMX95_CLK_SAI3>;
+		clock-names = "mclk";
+		AVDD-supply = <&reg_carrier_1p8v>;
+		CPVDD-supply = <&reg_carrier_1p8v>;
+		DBVDD-supply = <&reg_carrier_1p8v>;
+		DCVDD-supply = <&reg_carrier_1p8v>;
+		MICVDD-supply = <&reg_carrier_1p8v>;
+	};
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp1075";
+		reg = <0x4f>;
+	};
+
+	eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+
+};
+
+/* SMARC I2C_PM */
+&lpi2c3 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	fan_controller: fan@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+		#pwm-cells = <2>;
+
+		fan {
+			cooling-levels = <255>;
+			pwms = <&fan_controller 40000 PWM_POLARITY_INVERTED>;
+		};
+	};
+
+	/* Current measurement into module VCC */
+	hwmon@40 {
+		compatible = "ti,ina226";
+		reg = <0x40>;
+		shunt-resistor = <5000>;
+	};
+};
+
+/* SMARC I2C_LCD */
+&lpi2c5 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9543";
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* I2C on DSI Connector Pins 4/6 */
+		i2c_dsi_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* I2C on DSI Connector Pins 52/54 */
+		i2c_dsi_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* SMARC SPI0 */
+&lpspi6 {
+	status = "okay";
+};
+
+/* SMARC SER1, used as the Linux Console */
+&lpuart1 {
+	status = "okay";
+};
+
+/* SMARC SER0, RS485 */
+&lpuart2 {
+	linux,rs485-enabled-at-boot-time;
+	rs485-rts-active-low;
+	rs485-rx-during-tx;
+	status = "okay";
+};
+
+/* SMARC SER3, RS232 */
+&lpuart3 {
+	status = "okay";
+};
+
+/* SMARC MDIO, shared between all ethernet ports */
+&netc_emdio {
+	status = "okay";
+
+	ethphy3: ethernet-phy@4 {
+		reg = <4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio7>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+/* SMARC PCIE_A / M2 Key B */
+&pcie0 {
+	status = "okay";
+};
+
+/* SMARC PCIE_B /  M2 Key E */
+&pcie1 {
+	status = "okay";
+};
+
+/* SMARC I2S0 */
+&sai3 {
+	status = "okay";
+};
+
+/* SMARC LCD0_BKLT_PWM */
+&tpm3 {
+	status = "okay";
+};
+
+/* SMARC LCD1_BKLT_PWM */
+&tpm4 {
+	status = "okay";
+};
+
+/* SMARC GPIO5 as PWM */
+&tpm5 {
+	status = "okay";
+};
+
+/* SMARC USB0 */
+&usb2 {
+	status = "okay";
+};
+
+/* SMARC USB1..4 */
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	status = "okay";
+};
+
+&usb3_phy {
+	status = "okay";
+};
+
+/* SMARC SDIO */
+&usdhc2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
new file mode 100644
index 000000000000..e99f1a57af8c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
@@ -0,0 +1,1153 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include "imx95.dtsi"
+
+/ {
+	aliases {
+		can0 = &flexcan1;
+		can1 = &flexcan2;
+		ethernet0 = &enetc_port0;
+		ethernet1 = &enetc_port1;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		rtc0 = &rtc_i2c;
+		rtc1 = &scmi_bbm;
+		serial0 = &lpuart2;
+		serial1 = &lpuart1;
+		serial3 = &lpuart3;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	clk_dsi2dp_bridge: clock-dsi2dp-bridge {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
+
+	clk_serdes_eth_ref: clock-eth-ref {
+		compatible = "gpio-gate-clock";
+		#clock-cells = <0>;
+		/* CTRL_ETH_REF_CLK_STBY# */
+		enable-gpios = <&som_gpio_expander_1 13 GPIO_ACTIVE_HIGH>;
+	};
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		/* SMARC P64 - USB0_OTG_ID */
+		id-gpios = <&som_gpio_expander_0 3 GPIO_ACTIVE_HIGH>;
+		label = "USB0";
+		self-powered;
+		type = "micro";
+		vbus-supply = <&reg_usb0_vbus>;
+
+		port {
+			usb_dr_connector: endpoint {
+				remote-endpoint = <&usb0_otg_id>;
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		smarc_key_sleep: key-sleep {
+			gpios = <&som_ec_gpio_expander 4 GPIO_ACTIVE_LOW>;
+			label = "SMARC_SLEEP#";
+			wakeup-source;
+			linux,code = <KEY_SLEEP>;
+		};
+
+		smarc_switch_lid: switch-lid {
+			gpios = <&som_ec_gpio_expander 2 GPIO_ACTIVE_LOW>;
+			label = "SMARC_LID#";
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+		};
+	};
+
+	reg_module_1p8v: regulator-module-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "On-module +V1.8";
+	};
+
+	/* Non PMIC On-module Supplies */
+	reg_module_dp_1p2v: regulator-module-dp-1p2v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1200000>;
+		regulator-min-microvolt = <1200000>;
+		regulator-name = "On-module +V1.2_DP";
+		vin-supply = <&reg_module_1p8v>;
+	};
+
+	reg_usb0_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+		/* SMARC P62 - USB0_EN_OC# */
+		gpios = <&som_gpio_expander_0 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "USB0_EN_OC#";
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		/* CTRL_V_BUS_USB_HUB or SMARC P71 - USB2_EN_OC# */
+		gpios = <&som_gpio_expander_0 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "CTRL_V_BUS_USB_HUB";
+	};
+
+	reg_usdhc2_vmmc: regulator-vmmc-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_pwr_en>;
+		enable-active-high;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <100000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "SDIO_PWR_EN";
+		startup-delay-us = <20000>;
+	};
+
+	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_vsel>;
+		gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+		regulator-name = "PMIC_SD2_VSEL";
+	};
+
+	reg_wifi_en: regulator-wifi-en {
+		compatible = "regulator-fixed";
+		/* CTRL_EN_WIFI */
+		gpios = <&som_gpio_expander_1 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "CTRL_EN_WIFI";
+		startup-delay-us = <2000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x3c000000>;
+			alloc-ranges = <0 0x80000000 0 0x7F000000>;
+			linux,cma-default;
+		};
+	};
+};
+
+/* SMARC GBE0 */
+&enetc_port0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enetc0>, <&pinctrl_enetc0_1588_tmr>;
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+};
+
+/* SMARC GBE1 */
+&enetc_port1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enetc1>, <&pinctrl_enetc1_1588_tmr>;
+	phy-handle = <&ethphy2>;
+	phy-mode = "rgmii-id";
+};
+
+/* SMARC CAN0 */
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+};
+
+/* SMARC CAN1 */
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+};
+
+&gpio1 {
+	gpio-line-names = "", /* 0 */
+			  "",
+			  "SMARC_I2C_GP_CK",
+			  "SMARC_I2C_GP_DAT",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "", /* 10 */
+			  "",
+			  "",
+			  "",
+			  "CTRL_IO_EXP_INT_B";
+	status = "okay";
+};
+
+&gpio2 {
+	gpio-line-names = "SMARC_SPI0_CS0#", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SMARC_GPIO5",
+			  "",
+			  "I2C_CAM_DAT",
+			  "I2C_CAM_CK",
+			  "SMARC_GPIO12", /* 10 */
+			  "SMARC_GPIO13",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SMARC_SPI1_CS0#",
+			  "",
+			  "", /* 20 */
+			  "",
+			  "SMARC_I2C_LCD_DAT",
+			  "SMARC_I2C_LCD_CK",
+			  "SMARC_SPI0_CS1#",
+			  "",
+			  "",
+			  "",
+			  "SMARC_I2C_PM_DAT",
+			  "SMARC_I2C_PM_CK",
+			  "I2C_SOM_DAT", /* 30 */
+			  "I2C_SOM_CK";
+	status = "okay";
+};
+
+&gpio3 {
+	gpio-line-names = "SMARC_SDIO_CD#", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SMARC_SDIO_PWR_EN",
+			  "",
+			  "",
+			  "", /* 10 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "PMIC_SD2_VSEL";
+	status = "okay";
+};
+
+&gpio4 {
+	gpio-line-names = "", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "", /* 10 */
+			  "",
+			  "",
+			  "",
+			  "SMARC_GPIO11",
+			  "SMARC_GPIO10",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "", /* 20 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SMARC_SMB_ALERT#";
+	status = "okay";
+};
+
+&gpio5 {
+	gpio-line-names = "SMARC_GPIO2", /* 0 */
+			  "SMARC_GPIO3",
+			  "SMARC_GPIO4",
+			  "SMARC_GPIO6",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SMARC_GPIO9",
+			  "SMARC_GPIO7",
+			  "SMARC_GPIO8", /* 10 */
+			  "SMARC_SPI1_CS1#",
+			  "",
+			  "SPI1_TPM_CS#";
+	status = "okay";
+};
+
+/* SMARC I2C_GP */
+&lpi2c2 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "st,24c32", "atmel,24c32";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
+};
+
+/* SMARC I2C_PM */
+&lpi2c3 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* I2C_SOM */
+&lpi2c4 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c4>, <&pinctrl_ctrl_io_exp_int_b>;
+	pinctrl-1 = <&pinctrl_lpi2c4_gpio>, <&pinctrl_ctrl_io_exp_int_b>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio2 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	som_gpio_expander_0: gpio@20 {
+		compatible = "nxp,pcal6408";
+		reg = <0x20>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"SMARC_PCIE_WAKE#", /* 0 */
+			"SMARC_PCIE_B_RST#",
+			"SMARC_PCIE_A_RST#",
+			"SMARC_USB0_OTG_ID",
+			"SMARC_USB0_EN", /* SMARC USB0_EN_OC# - Open Drain Output */
+			"SMARC_USB0_OC#", /* SMARC USB0_EN_OC# - Over-Current Sense Input */
+			"",
+			"SMARC_PCIE_C_RST#";
+	};
+
+	som_gpio_expander_1: gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"SMARC_GPIO0", /* 0 */
+			"SMARC_GPIO1",
+			"SMARC_LCD0_VDD_EN",
+			"SMARC_LCD0_BKLT_EN",
+			"SMARC_LCD1_VDD_EN",
+			"SMARC_LCD1_BKLT_EN",
+			"",
+			"",
+			"",
+			"",
+			"", /* 10 */
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"SMARC_SDIO_WP";
+	};
+
+	embedded-controller@28 {
+		compatible = "toradex,smarc-imx95-ec", "toradex,smarc-ec";
+		reg = <0x28>;
+	};
+
+	som_ec_gpio_expander: gpio@29 {
+		compatible = "toradex,ecgpiol16", "nxp,pcal6416";
+		reg = <0x29>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ec_int>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"SMARC_CHARGER_PRSNT#",
+			"SMARC_CHARGING#",
+			"SMARC_LID#",
+			"SMARC_BATLOW#",
+			"SMARC_SLEEP#";
+	};
+
+	/* SMARC DP0 */
+	som_dsi2dp_bridge: bridge@2c {
+		compatible = "ti,sn65dsi86";
+		reg = <0x2c>;
+		clocks = <&clk_dsi2dp_bridge>;
+		clock-names = "refclk";
+		vcc-supply = <&reg_module_dp_1p2v>;
+		vcca-supply = <&reg_module_dp_1p2v>;
+		vccio-supply = <&reg_module_1p8v>;
+		vpll-supply = <&reg_module_1p8v>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				sn65dsi86_in: endpoint {
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				sn65dsi86_out: endpoint {
+					data-lanes = <3 2 1 0>;
+				};
+			};
+		};
+	};
+
+	rtc_i2c: rtc@32 {
+		compatible = "epson,rx8130";
+		reg = <0x32>;
+	};
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp1075";
+		reg = <0x48>;
+	};
+
+	eeprom@50 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+/* SMARC I2C_LCD */
+&lpi2c5 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c5>;
+	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio2 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* I2C_CAM */
+&lpi2c7 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c7>;
+	pinctrl-1 = <&pinctrl_lpi2c7_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio2 9 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9543";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* SMARC I2C_CAM0 */
+		i2c_cam0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* SMARC I2C_CAM1 */
+		i2c_cam1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* SMARC SPI1 */
+&lpspi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi4>;
+	cs-gpios = <&gpio2 18 GPIO_ACTIVE_LOW>,
+		   <&gpio5 11 GPIO_ACTIVE_LOW>,
+		   <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	som_tpm: tpm@2 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0x2>;
+		spi-max-frequency = <18500000>;
+	};
+};
+
+/* SMARC SPI0 */
+&lpspi6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi6>;
+	cs-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>,
+		   <&gpio2 24 GPIO_ACTIVE_LOW>;
+};
+
+/* SMARC SER1, used as the Linux Console */
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+/* SMARC SER0 */
+&lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+};
+
+/* SMARC SER3 */
+&lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+};
+
+/* SMARC MDIO, shared between all ethernet ports */
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+
+	ethphy1: ethernet-phy@1 {
+		reg = <1>;
+		interrupt-parent = <&som_gpio_expander_1>;
+		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+	};
+
+	ethphy2: ethernet-phy@2 {
+		reg = <2>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+	};
+};
+
+&netcmix_blk_ctrl {
+	status = "okay";
+};
+
+&netc_blk_ctrl {
+	status = "okay";
+};
+
+&netc_timer {
+	status = "okay";
+};
+
+/* SMARC PCIE_A */
+&pcie0 {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	reset-gpios = <&som_gpio_expander_0 2 GPIO_ACTIVE_LOW>;
+};
+
+/* SMARC PCIE_B */
+&pcie1 {
+	pinctrl-0 = <&pinctrl_pcie1>;
+	pinctrl-names = "default";
+	reset-gpios = <&som_gpio_expander_0 1 GPIO_ACTIVE_LOW>;
+};
+
+/* SMARC I2S0 */
+&sai3 {
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <12288000>;
+	fsl,sai-mclk-direction-output;
+};
+
+&thermal_zones {
+	/* PF09 Main PMIC */
+	pf09-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 2>;
+
+		trips {
+			trip0 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+
+	/* PF53 VDD_ARM PMIC */
+	pf53-arm-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 4>;
+
+		trips {
+			trip0 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+
+	/* PF53 VDD_SOC PMIC */
+	pf53-soc-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 3>;
+
+		trips {
+			trip0 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+};
+
+/* SMARC LCD0_BKLT_PWM */
+&tpm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcd0_bklt_pwm>;
+};
+
+/* SMARC LCD1_BKLT_PWM */
+&tpm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcd1_bklt_pwm>;
+};
+
+/* SMARC GPIO5 as PWM */
+&tpm5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio5_pwm>;
+};
+
+/* SMARC USB0 */
+&usb2 {
+	adp-disable;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	vbus-supply = <&reg_usb0_vbus>;
+
+	port {
+		usb0_otg_id: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
+};
+
+&usb3 {
+	fsl,disable-port-power-control;
+};
+
+/* SMARC USB1..4  */
+&usb3_dwc3 {
+	dr_mode = "host";
+};
+
+&usb3_phy {
+	vbus-supply = <&reg_usb1_vbus>;
+};
+
+/* On-module eMMC */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+/* SMARC SDIO */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>,<&pinctrl_usdhc2_cd>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_usdhc2_vqmmc>;
+	wp-gpios = <&som_gpio_expander_1 15 GPIO_ACTIVE_HIGH>;
+};
+
+/* On-module Wi-Fi */
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	keep-power-in-suspend;
+	non-removable;
+	vmmc-supply = <&reg_wifi_en>;
+};
+
+&scmi_bbm {
+	linux,code = <KEY_POWER>;
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	/* SMARC CAM_MCK */
+	pinctrl_cam_mck: cammckgrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO1__CCMSRCGPCMIX_TOP_CLKO_1	0x51e>; /* SMARC S6 - CAM_MCK */
+	};
+
+	pinctrl_ec_int: ecintgrp {
+		fsl,pins = <IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11	0x31e>; /* SAI1_TXFS - EC_MCU_INT# */
+	};
+
+	/* SMARC MDIO, shared between all ethernet ports */
+	pinctrl_emdio: emdiogrp {
+		fsl,pins = <IMX95_PAD_ENET1_MDC__NETCMIX_TOP_NETC_MDC		0x50e>, /* SMARC S45 - MDIO_CLK */
+			   <IMX95_PAD_ENET1_MDIO__NETCMIX_TOP_NETC_MDIO		0x90e>; /* SMARC S46 - MDIO_DAT */
+	};
+
+	/* SMARC GBE0 */
+	pinctrl_enetc0: enetc0grp {
+		fsl,pins = <IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x57e>, /* ENET1_TX_CTL */
+			   <IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK		0x58e>, /* ENET1_TXC    */
+			   <IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0		0x50e>, /* ENET1_TDO    */
+			   <IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1		0x50e>, /* ENET1_TD1    */
+			   <IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2		0x50e>, /* ENET1_TD2    */
+			   <IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3		0x50e>, /* ENET1_TD3    */
+			   <IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x57e>, /* ENET1_RX_CTL */
+			   <IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK		0x58e>, /* ENET1_RXC    */
+			   <IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0		0x57e>, /* ENET1_RD0    */
+			   <IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1		0x57e>, /* ENET1_RD1    */
+			   <IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2		0x57e>, /* ENET1_RD2    */
+			   <IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3		0x57e>; /* ENET1_RD3    */
+	};
+
+	/* SMARC GBE0_SDP */
+	pinctrl_enetc0_1588_tmr: enetc01588tmrgrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO2__NETCMIX_TOP_NETC_TMR_1588_PP1	0x51e>; /* SMARC P6 - GBE0_SDP */
+	};
+
+	/* SMARC GBE1 */
+	pinctrl_enetc1: enetc1grp {
+		fsl,pins = <IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RGMII_TX_CTL	0x57e>, /* ENET2_TX_CTL */
+			   <IMX95_PAD_ENET2_TXC__NETCMIX_TOP_ETH1_RGMII_TX_CLK		0x58e>, /* ENET2_TXC    */
+			   <IMX95_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RGMII_TD0		0x50e>, /* ENET2_TD0    */
+			   <IMX95_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RGMII_TD1		0x50e>, /* ENET2_TD1    */
+			   <IMX95_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RGMII_TD2		0x50e>, /* ENET2_TD2    */
+			   <IMX95_PAD_ENET2_TD3__NETCMIX_TOP_ETH1_RGMII_TD3		0x50e>, /* ENET2_TD3    */
+			   <IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RGMII_RX_CTL	0x57e>, /* ENET2_RX_CTL */
+			   <IMX95_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RGMII_RX_CLK		0x58e>, /* ENET2_RXC    */
+			   <IMX95_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RGMII_RD0		0x57e>, /* ENET2_RD0    */
+			   <IMX95_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RGMII_RD1		0x57e>, /* ENET2_RD1    */
+			   <IMX95_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RGMII_RD2		0x57e>, /* ENET2_RD2    */
+			   <IMX95_PAD_ENET2_RD3__NETCMIX_TOP_ETH1_RGMII_RD3		0x57e>; /* ENET2_RD3    */
+	};
+
+	/* SMARC GBE1_SDP */
+	pinctrl_enetc1_1588_tmr: enetc11588tmrgrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO4__NETCMIX_TOP_NETC_TMR_1588_PP2	0x51e>; /* SMARC P5 - GBE1_SDP */
+	};
+
+	/* SMARC CAN0 */
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <IMX95_PAD_PDM_CLK__AONMIX_TOP_CAN1_TX		0x39e>, /* SMARC P143 - CAN0_TX */
+			   <IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_CAN1_RX	0x39e>; /* SMARC P144 - CAN0_RX */
+	};
+
+	/* SMARC CAN1 */
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO25__CAN2_TX	0x39e>, /* SMARC P145 - CAN1_TX */
+			   <IMX95_PAD_GPIO_IO27__CAN2_RX	0x39e>; /* SMARC P146 - CAN1_RX */
+	};
+
+	/* SMARC GPIO2 */
+	pinctrl_gpio2: gpio2grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA0__GPIO5_IO_BIT0	0x31e>; /* SMARC P110 - GPIO2 */
+	};
+
+	/* SMARC GPIO3 */
+	pinctrl_gpio3: gpio3grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA1__GPIO5_IO_BIT1	0x31e>; /* SMARC P111 - GPIO3 */
+	};
+
+	/* SMARC GPIO4 */
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA2__GPIO5_IO_BIT2	0x31e>; /* SMARC P112 - GPIO4 */
+	};
+
+	/* SMARC GPIO5 */
+	pinctrl_gpio5: gpio5grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO06__GPIO2_IO_BIT6	0x31e>; /* SMARC P113 - GPIO5 */
+	};
+
+	/* SMARC GPIO5 as PWM */
+	pinctrl_gpio5_pwm: gpio5pwmgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO06__TPM5_CH0	0x11e>; /* SMARC P113 - PWM_OUT */
+	};
+
+	/* SMARC GPIO6 */
+	pinctrl_gpio6: gpio6grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA3__GPIO5_IO_BIT3	0x31e>; /* SMARC P114 - GPIO6 */
+	};
+
+	/* SMARC GPIO7 */
+	pinctrl_gpio7: gpio7grp {
+		fsl,pins = <IMX95_PAD_XSPI1_SCLK__GPIO5_IO_BIT9 0x31e>; /* SMARC P115 - GPIO7 */
+	};
+
+	/* SMARC GPIO8 */
+	pinctrl_gpio8: gpio8grp {
+		fsl,pins = <IMX95_PAD_XSPI1_SS0_B__GPIO5_IO_BIT10	0x31e>; /* SMARC P116 - GPIO8 */
+	};
+
+	/* SMARC GPIO9 */
+	pinctrl_gpio9: gpio9grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DQS__GPIO5_IO_BIT8	0x31e>; /* SMARC P117 - GPIO9 */
+	};
+
+	/* SMARC GPIO10 */
+	pinctrl_gpio10: gpio10grp {
+		fsl,pins = <IMX95_PAD_ENET2_MDIO__GPIO4_IO_BIT15	0x31e>; /* SMARC P118 - GPIO10 */
+	};
+
+	/* SMARC GPIO11 */
+	pinctrl_gpio11: gpio11grp {
+		fsl,pins = <IMX95_PAD_ENET2_MDC__GPIO4_IO_BIT14	0x31e>; /* SMARC P119 - GPIO11 */
+	};
+
+	/* SMARC GPIO12 */
+	pinctrl_gpio12: gpio12grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO10__GPIO2_IO_BIT10	0x31e>; /* SMARC S142 - GPIO12 */
+	};
+
+	/* SMARC GPIO13 */
+	pinctrl_gpio13: gpio13grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO11__GPIO2_IO_BIT11	0x31e>; /* SMARC S123 - GPIO13 */
+	};
+
+	pinctrl_ctrl_io_exp_int_b: ioexpintgrp {
+		fsl,pins = <IMX95_PAD_SAI1_RXD0__AONMIX_TOP_GPIO1_IO_BIT14 0x31e>; /* CTRL_IO_EXP_INT_B */
+	};
+
+	/* SMARC LCD0_BKLT_PWM */
+	pinctrl_lcd0_bklt_pwm: lcd0bkltpwmgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO12__TPM3_CH2	0x51e>; /* SMARC S141 - LCD0_BKLT_PWM */
+	};
+
+	/* SMARC LCD1_BKLT_PWM */
+	pinctrl_lcd1_bklt_pwm: lcd1bkltpwmgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO13__TPM4_CH2	0x51e>; /* SMARC S122 - LCD1_BKLT_PWM */
+	};
+
+	/* SMARC I2C_GP */
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL	0x40001b9e>, /* SMARC S48 - I2C_GP_CK  */
+			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA	0x40001b9e>; /* SMARC S49 - I2C_GP_DAT */
+	};
+
+	/* SMARC I2C_GP as GPIOs */
+	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
+		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_GPIO1_IO_BIT2	0x40001b9e>, /* SMARC S48 - I2C_GP_CK  */
+			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_GPIO1_IO_BIT3	0x40001b9e>; /* SMARC S49 - I2C_GP_DAT */
+	};
+
+	/* SMARC I2C_PM */
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__LPI2C3_SDA	0x40001b9e>, /* SMARC P122 - I2C_PM_DAT */
+			   <IMX95_PAD_GPIO_IO29__LPI2C3_SCL	0x40001b9e>; /* SMARC P121 - I2C_PM_CK  */
+	};
+
+	/* SMARC I2C_PM as GPIOs */
+	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__GPIO2_IO_BIT28	0x40001b9e>, /* SMARC P122 - I2C_PM_DAT */
+			   <IMX95_PAD_GPIO_IO29__GPIO2_IO_BIT29	0x40001b9e>; /* SMARC P121 - I2C_PM_CK  */
+	};
+
+	/* I2C_SOM */
+	pinctrl_lpi2c4: lpi2c4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO31__LPI2C4_SCL	0x40001b9e>, /* I2C_SOM_CK  */
+			   <IMX95_PAD_GPIO_IO30__LPI2C4_SDA	0x40001b9e>; /* I2C_SOM_DAT */
+	};
+
+	/* I2C_SOM as GPIOs */
+	pinctrl_lpi2c4_gpio: lpi2c4gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO31__GPIO2_IO_BIT31	0x40001b9e>, /* I2C_SOM_CK  */
+			   <IMX95_PAD_GPIO_IO30__GPIO2_IO_BIT30	0x40001b9e>; /* I2C_SOM_DAT */
+	};
+
+	/* SMARC I2C_LCD */
+	pinctrl_lpi2c5: lpi2c5grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO22__LPI2C5_SDA	0x40001b9e>, /* SMARC S140 - I2C_LCD_DAT */
+			   <IMX95_PAD_GPIO_IO23__LPI2C5_SCL	0x40001b9e>; /* SMARC S139 - I2C_LCD_CK  */
+	};
+
+	/* SMARC I2C_LCD as GPIOs */
+	pinctrl_lpi2c5_gpio: lpi2c5gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO22__GPIO2_IO_BIT22	0x40001b9e>, /* SMARC S140 - I2C_LCD_DAT */
+			   <IMX95_PAD_GPIO_IO23__GPIO2_IO_BIT23	0x40001b9e>; /* SMARC S139 - I2C_LCD_CK  */
+	};
+
+	/* I2C_CAM */
+	pinctrl_lpi2c7: lpi2c7grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO08__LPI2C7_SDA	0x40001b9e>, /* I2C_CAM_DAT */
+			   <IMX95_PAD_GPIO_IO09__LPI2C7_SCL	0x40001b9e>; /* I2C_CAM_CK  */
+	};
+
+	/* I2C_CAM as GPIOs */
+	pinctrl_lpi2c7_gpio: lpi2c7gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO08__GPIO2_IO_BIT8	0x40001b9e>, /* I2C_CAM_DAT */
+			   <IMX95_PAD_GPIO_IO09__GPIO2_IO_BIT9	0x40001b9e>; /* I2C_CAM_CK  */
+	};
+
+	/* SMARC SPI1 */
+	pinctrl_lpspi4: lpspi4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO37__LPSPI4_SCK		0x3fe>, /* SMARC P56 - SPI1_CK   */
+			   <IMX95_PAD_GPIO_IO36__LPSPI4_SOUT		0x3fe>, /* SMARC P58 - SPI1_DO   */
+			   <IMX95_PAD_GPIO_IO19__LPSPI4_SIN		0x3fe>, /* SMARC P57 - SPI1_DIN  */
+			   <IMX95_PAD_GPIO_IO33__GPIO5_IO_BIT13		0x3fe>, /* SPI1_TPM_CS#          */
+			   <IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18		0x3fe>, /* SMARC P54 - SPI1_CS0# */
+			   <IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11	0x3fe>; /* SMARC P55 - SPI1_CS1# */
+	};
+
+	/* SMARC SPI0 */
+	pinctrl_lpspi6: lpspi6grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO00__GPIO2_IO_BIT0		0x3fe>, /* SMARC P43 - SPI0_CS0# */
+			   <IMX95_PAD_GPIO_IO24__GPIO2_IO_BIT24		0x3fe>, /* SMARC P31 - SPI0_CS1# */
+			   <IMX95_PAD_GPIO_IO01__LPSPI6_SIN		0x3fe>, /* SMARC P45 - SPI0_DIN  */
+			   <IMX95_PAD_GPIO_IO02__LPSPI6_SOUT		0x3fe>, /* SMARC P46 - SPI0_DO   */
+			   <IMX95_PAD_GPIO_IO03__LPSPI6_SCK		0x3fe>; /* SMARC P44 - SPI0_CK   */
+	};
+
+	/* SMARC PCIE_A */
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B	0x40001b1e>; /* SMARC P78 - PCIE_A_CKREQ# */
+	};
+
+	/* SMARC PCIE_B */
+	pinctrl_pcie1: pcie1grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B	0x40001b1e>; /* SMARC P77 - PCIE_B_CKREQ# */
+	};
+
+	/* SMARC I2S0 */
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK		0x11e>, /* SMARC S38 - I2S0_CK */
+			   <IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0	0x11e>, /* SMARC S41 - I2S0_SDIN */
+			   <IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0	0x11e>, /* SMARC S40 - I2S0_SDOUT */
+			   <IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC		0x11e>; /* SMARC S39 - I2S0_LRCK */
+	};
+
+	/* SMARC AUDIO_MCK */
+	pinctrl_sai3_mclk: sai3mclkgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO17__SAI3_MCLK	0x31e>; /* SMARC S42 - AUDIO_MCK */
+	};
+
+	/* SMARC I2S2 */
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA6__SAI5_TX_BCLK		0x11e>, /* SMARC S53 - I2S2_CK */
+			   <IMX95_PAD_XSPI1_DATA4__SAI5_TX_DATA_BIT0	0x11e>, /* SMARC S51 - I2S2_SDOUT */
+			   <IMX95_PAD_XSPI1_DATA7__SAI5_RX_DATA_BIT0	0x11e>, /* SMARC S52 - I2S2_SDIN */
+			   <IMX95_PAD_XSPI1_DATA5__SAI5_TX_SYNC		0x11e>; /* SMARC S50 - I2S2_LRCK */
+	};
+
+	/* SMARC SMB_ALERT# */
+	pinctrl_smb_alert_gpio: smbalertgrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO3__GPIO4_IO_BIT28	0x31e>; /* SMARC P1 - SMB_ALERT# */
+	};
+
+	/* SMARC SER1, used as the Linux Console */
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX	0x31e>, /* SMARC P134 - SER1_TX */
+			   <IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX	0x31e>; /* SMARC P135 - SER1_RX */
+	};
+
+	/* SMARC SER0 */
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <IMX95_PAD_SAI1_TXC__AONMIX_TOP_LPUART2_CTS_B	0x31e>, /* SMARC P132 - SER0_CTS# */
+			   <IMX95_PAD_SAI1_TXD0__AONMIX_TOP_LPUART2_RTS_B	0x31e>, /* SMARC P131 - SER0_RTS# */
+			   <IMX95_PAD_UART2_RXD__AONMIX_TOP_LPUART2_RX		0x31e>, /* SMARC P130 - SER0_RX   */
+			   <IMX95_PAD_UART2_TXD__AONMIX_TOP_LPUART2_TX		0x31e>; /* SMARC P129 - SER0_TX   */
+	};
+
+	/* SMARC SER3 */
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO14__LPUART3_TX	0x31e>, /* SMARC P140 - SER3_TX */
+			   <IMX95_PAD_GPIO_IO15__LPUART3_RX	0x31e>; /* SMARC P141 - SER3_RX */
+	};
+
+	/* On-module eMMC */
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x158e>, /* SD1_CLK    */
+			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x138e>, /* SD1_CMD    */
+			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x138e>, /* SD1_DATA0  */
+			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x138e>, /* SD1_DATA1  */
+			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x138e>, /* SD1_DATA2  */
+			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x138e>, /* SD1_DATA3  */
+			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x138e>, /* SD1_DATA4  */
+			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x138e>, /* SD1_DATA5  */
+			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x138e>, /* SD1_DATA6  */
+			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x138e>, /* SD1_DATA7  */
+			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x158e>; /* SD1_STROBE */
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x15fe>, /* SD1_CLK    */
+			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x13fe>, /* SD1_CMD    */
+			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe>, /* SD1_DATA0  */
+			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe>, /* SD1_DATA1  */
+			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe>, /* SD1_DATA2  */
+			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe>, /* SD1_DATA3  */
+			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe>, /* SD1_DATA4  */
+			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe>, /* SD1_DATA5  */
+			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe>, /* SD1_DATA6  */
+			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe>, /* SD1_DATA7  */
+			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe>; /* SD1_STROBE */
+	};
+
+	/* SMARC SDIO */
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK		0x158e>, /* SMARC P36 - SDIO_CK  */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD		0x138e>, /* SMARC P34 - SDIO_CMD */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e>, /* SMARC P39 - SDIO_D0  */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e>, /* SMARC P40 - SDIO_D1  */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e>, /* SMARC P41 - SDIO_D2  */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e>; /* SMARC P42 - SDIO_D3  */
+	};
+
+	/* SMARC SDIO */
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK		0x15fe>, /* SMARC P36 - SDIO_CK  */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD		0x13fe>, /* SMARC P34 - SDIO_CMD */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x13fe>, /* SMARC P39 - SDIO_D0  */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x13fe>, /* SMARC P40 - SDIO_D1  */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x13fe>, /* SMARC P41 - SDIO_D2  */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x13fe>; /* SMARC P42 - SDIO_D3  */
+	};
+
+	/* SMARC SDIO */
+	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK		0x400>, /* SMARC P36 - SDIO_CK  */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD		0x400>, /* SMARC P34 - SDIO_CMD */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x400>, /* SMARC P39 - SDIO_D0  */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x400>, /* SMARC P40 - SDIO_D1  */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x400>, /* SMARC P41 - SDIO_D2  */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x400>; /* SMARC P42 - SDIO_D3  */
+	};
+
+	/* SMARC SDIO_CD# */
+	pinctrl_usdhc2_cd: usdhc2-cdgrp {
+		fsl,pins = <IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0	0x1100>; /* SMARC P35 - SDIO_CD# */
+	};
+
+	/* SMARC SDIO_PWR_EN */
+	pinctrl_usdhc2_pwr_en: usdhc2-pwrengrp {
+		fsl,pins = <IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7	0x11e>; /* SMARC P37 - SDIO_PWR_EN */
+	};
+
+	pinctrl_usdhc2_vsel: usdhc2-vselgrp {
+		fsl,pins = <IMX95_PAD_SD2_VSELECT__GPIO3_IO_BIT19	0x4>; /* PMIC_SD2_VSEL */
+	};
+
+	/* On-module Wi-Fi */
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <IMX95_PAD_SD3_CLK__USDHC3_CLK	0x158e>, /* SD3_CLK   */
+			   <IMX95_PAD_SD3_CMD__USDHC3_CMD	0x138e>, /* SD3_CMD   */
+			   <IMX95_PAD_SD3_DATA0__USDHC3_DATA0	0x138e>, /* SD3_DATA0 */
+			   <IMX95_PAD_SD3_DATA1__USDHC3_DATA1	0x138e>, /* SD3_DATA1 */
+			   <IMX95_PAD_SD3_DATA2__USDHC3_DATA2	0x138e>, /* SD3_DATA2 */
+			   <IMX95_PAD_SD3_DATA3__USDHC3_DATA3	0x138e>; /* SD3_DATA3 */
+	};
+
+	/* On-module Wi-Fi */
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD3_CLK__USDHC3_CLK	0x15fe>, /* SD3_CLK   */
+			   <IMX95_PAD_SD3_CMD__USDHC3_CMD	0x13fe>, /* SD3_CMD   */
+			   <IMX95_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe>, /* SD3_DATA1 */
+			   <IMX95_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe>, /* SD3_DATA2 */
+			   <IMX95_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe>, /* SD3_DATA3 */
+			   <IMX95_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe>; /* SD3_DATA4 */
+	};
+};
-- 
2.39.5



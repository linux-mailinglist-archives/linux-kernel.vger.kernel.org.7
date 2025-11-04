Return-Path: <linux-kernel+bounces-884979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE8CC31A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF903B8E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABAD330B24;
	Tue,  4 Nov 2025 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="RVm0C4a3"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20232E75C;
	Tue,  4 Nov 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267980; cv=none; b=GuC6sEo2ZaqYpMRGwZoWuSKX8RH1qLsm0b8h2mSA4mhnEiQnXmaIZeIcLGds+MqA8qRKRNFkbigHl4nzVIFZCUppddA1iwAiltZKeyk/SrQAKnfjbTtCVPLyCZDtWBbJyEiBUmRzEJ5jvPWYLELonw7BWGWqaFkqAT7VJeTP54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267980; c=relaxed/simple;
	bh=OR6lKo19VsO6qd9YjimXaofwW3n8vRUWqaATJno6eJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWxoR177htqpmamUhyzcfkmdTVa9NWZZ6rsYilAPC6W8IH+B9gO5n/+R8fZri3zFyWVg330hDc3FNypGx8+ayqZv7Ce6RAb6BPlCF4mQK1pAq+8CuOOKx4SnAcAFtSOmGuIRoovbtdiN9i7BPuyYdXUXfkq4FlcjlpELYOZ1f3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=RVm0C4a3; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id A61611FAE2;
	Tue,  4 Nov 2025 15:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762267975;
	bh=R5ETbgBOogaaUjCeMFsixqUptfUPuVyUkwJLDUHin0U=; h=From:To:Subject;
	b=RVm0C4a3Ylxcnt0i997gAJTsoAM57LZUaG96nSkG6HH9IAhHEUP8gwRmUu0GMkWd3
	 zjt4wZAiXNpL4E+h1/0b2XhVJtiTLmeYTS2JSqPrdCqqgWd/EJDlu570RgFXD3rh3G
	 kL4BCx1JL7q6agq6U1jx6bG1oWqjJT1VAyL3CO7ed9rDsELXZKf+U5x9Qsc9tUODZu
	 YEW1VfYg4ASGlj52uFR1chhjfsHZFD+oZmUiv0ohc9ejLuCeWGLZ4rB8SdPJ9wAdm4
	 odGJ2+D4rIpgkpXFFh9U65b4+qh13x2ZAsJj9CKcP5Z8FfweoT3q6fR0nbZj6sx6qm
	 lvmagSNJ3OnWg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 3/3] arm64: dts: ti: am69-aquila: Add Clover
Date: Tue,  4 Nov 2025 15:52:37 +0100
Message-ID: <20251104145240.61219-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104145240.61219-1-francesco@dolcini.it>
References: <20251104144915.60445-1-francesco@dolcini.it>
 <20251104145240.61219-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add support for Aquila AM69 mated with Clover carrier board.

Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
Link: https://www.toradex.com/products/carrier-board/clover
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../boot/dts/ti/k3-am69-aquila-clover.dts     | 451 ++++++++++++++++++
 2 files changed, 452 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 6ce652fe98fa..38a93b689fe7 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -153,6 +153,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
 
 # Boards with J784s4 SoC
+dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-clover.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk-pcie0-ep.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
new file mode 100644
index 000000000000..55fd214a82e4
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
+ * https://www.toradex.com/products/carrier-board/clover
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/pwm/pwm.h>
+#include "k3-am69-aquila.dtsi"
+
+/ {
+	model = "Toradex Aquila AM69 on Clover Board";
+	compatible = "toradex,aquila-am69-clover",
+		     "toradex,aquila-am69",
+		     "ti,j784s4";
+
+	aliases {
+		eeprom1 = &carrier_eeprom;
+	};
+
+	reg_3v3_dp: regulator-3v3-dp {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_21_dp>;
+		/* Aquila GPIO_21_DP (AQUILA B57) */
+		gpio = <&main_gpio0 37 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "DP_3V3";
+		startup-delay-us = <10000>;
+	};
+
+	/* Aquila DP_1 */
+	dp-connector {
+		compatible = "dp-connector";
+		dp-pwr-supply = <&reg_3v3_dp>;
+		label = "Display Port";
+		type = "full-size";
+
+		port {
+			dp_connector_in: endpoint {
+				remote-endpoint = <&dp0_out>;
+			};
+		};
+	};
+};
+
+/* On-module ETH_1 MDIO */
+&davinci_mdio {
+	status = "okay";
+};
+
+&dp0_ports {
+	port@4 {
+		reg = <4>;
+		dp0_out: endpoint {
+			remote-endpoint = <&dp_connector_in>;
+		};
+	};
+};
+
+&dss {
+	status = "okay";
+};
+
+&main0_thermal {
+	cooling-maps {
+		map0 {
+			cooling-device = <&fan 1 1>;
+			trip = <&main0_alert0>;
+		};
+
+		map1 {
+			cooling-device = <&fan 2 2>;
+			trip = <&main0_alert1>;
+		};
+	};
+};
+
+&main1_thermal {
+	cooling-maps {
+		map0 {
+			cooling-device = <&fan 1 1>;
+			trip = <&main1_alert0>;
+		};
+
+		map1 {
+			cooling-device = <&fan 2 2>;
+			trip = <&main1_alert1>;
+		};
+	};
+};
+
+&main2_thermal {
+	cooling-maps {
+		map0 {
+			cooling-device = <&fan 1 1>;
+			trip = <&main2_alert0>;
+		};
+
+		map1 {
+			cooling-device = <&fan 2 2>;
+			trip = <&main2_alert1>;
+		};
+	};
+};
+
+&main3_thermal {
+	cooling-maps {
+		map0 {
+			cooling-device = <&fan 1 1>;
+			trip = <&main3_alert0>;
+		};
+
+		map1 {
+			cooling-device = <&fan 2 2>;
+			trip = <&main3_alert1>;
+		};
+	};
+};
+
+&main4_thermal {
+	cooling-maps {
+		map0 {
+			cooling-device = <&fan 1 1>;
+			trip = <&main4_alert0>;
+		};
+
+		map1 {
+			cooling-device = <&fan 2 2>;
+			trip = <&main4_alert1>;
+		};
+	};
+};
+
+/* Aquila ETH_2 */
+&main_cpsw0 {
+	status = "okay";
+};
+
+/* Aquila ETH_2 SGMII PHY */
+&main_cpsw0_port8  {
+	phy-handle = <&cpsw0_port8_phy4>;
+	status = "okay";
+};
+
+/* Aquila ETH_2_XGMII_MDIO */
+&main_cpsw0_mdio {
+	status = "okay";
+
+	cpsw0_port8_phy4: ethernet-phy@4 {
+		reg = <4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eth2_int>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+/* Aquila PWM_1 */
+&main_ehrpwm0 {
+	status = "okay";
+};
+
+/* Aquila PWM_2 */
+&main_ehrpwm1 {
+	status = "okay";
+};
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_01>, /* Aquila GPIO_01 */
+		    <&pinctrl_gpio_02>, /* Aquila GPIO_02 */
+		    <&pinctrl_gpio_03>; /* Aquila GPIO_03 */
+};
+
+/* Aquila I2C_6 */
+&main_i2c5 {
+	status = "okay";
+};
+
+/* Aquila CAN_1 */
+&main_mcan10 {
+	status = "okay";
+};
+
+/* Aquila CAN_3 */
+&main_mcan13 {
+	status = "okay";
+};
+
+/* Aquila SD_1 */
+&main_sdhci1 {
+	status = "okay";
+};
+
+/* Aquila SPI_2 */
+&main_spi0 {
+	status = "okay";
+};
+
+/* Aquila SPI_1 */
+&main_spi2 {
+	pinctrl-0 = <&pinctrl_main_spi2>,
+		    <&pinctrl_main_spi2_cs0>,
+		    <&pinctrl_gpio_05>;
+	cs-gpios = <0>, <&wkup_gpio0 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	tpm@1 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_06>;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <18500000>;
+	};
+};
+
+/* Aquila UART_1 */
+&main_uart4 {
+	status = "okay";
+};
+
+/* Aquila UART_3, used as the Linux console */
+&main_uart8 {
+	status = "okay";
+};
+
+&mcu_cpsw {
+	status = "okay";
+};
+
+/* On-module ETH_1 RGMII */
+&mcu_cpsw_port1 {
+	status = "okay";
+};
+
+/* Aquila I2C_1 */
+&mcu_i2c0 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	fan_controller: fan@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+		#pwm-cells = <2>;
+
+		fan: fan {
+			cooling-levels = <102 179 255>;
+			#cooling-cells = <2>;
+			pwms = <&fan_controller 40000 PWM_POLARITY_INVERTED>;
+		};
+	};
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp1075";
+		reg = <0x4f>;
+	};
+
+	/* USB-C OTG (TCPC USB PD PHY) */
+	tcpc@52 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x52>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb1_int>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C OTG";
+			power-role = "dual";
+			try-power-role = "sink";
+			self-powered;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <1000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_con_hs: endpoint {
+						remote-endpoint = <&usb0_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_con_ss: endpoint {
+						remote-endpoint = <&usb0_ss_mux>;
+					};
+				};
+			};
+		};
+	};
+
+	carrier_eeprom: eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+};
+
+/* Aquila I2C_2 */
+&mcu_i2c1 {
+	status = "okay";
+};
+
+/* Aquila CAN_2 */
+&mcu_mcan0 {
+	status = "okay";
+};
+
+/* Aquila CAN_4 */
+&mcu_mcan1 {
+	status = "okay";
+};
+
+/* Aquila UART_4 */
+&mcu_uart0 {
+	status = "okay";
+};
+
+&mhdp {
+	status = "okay";
+};
+
+/* Aquila QSPI_1 */
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcu_ospi0_4bit>, <&pinctrl_mcu_ospi0_cs0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <66000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		cdns,read-delay = <0>;
+		cdns,tchsh-ns = <3>;
+		cdns,tsd2d-ns = <10>;
+		cdns,tshsl-ns = <30>;
+		cdns,tslch-ns = <8>;
+	};
+};
+
+/* Aquila PCIE_1 */
+&pcie0_rc {
+	status = "okay";
+};
+
+/* Aquila PCIE_2 */
+&pcie1_rc {
+	status = "okay";
+};
+
+&serdes2 {
+	status = "okay";
+};
+
+&serdes4 {
+	status = "okay";
+};
+
+&serdes_wiz2 {
+	status = "okay";
+};
+
+&serdes_wiz4 {
+	status = "okay";
+};
+
+/* Aquila ADC_[1-4] */
+&tscadc0 {
+	status = "okay";
+};
+
+&usbss0 {
+	status = "okay";
+};
+
+&usb0ss_mux {
+	status = "okay";
+
+	port {
+		usb0_ss_mux: endpoint {
+			remote-endpoint = <&usb_1_con_ss>;
+		};
+	};
+};
+
+&usb0 {
+	status = "okay";
+
+	port {
+		usb0_hs: endpoint {
+			remote-endpoint = <&usb_1_con_hs>;
+		};
+	};
+};
+
+&wkup0_thermal {
+	cooling-maps {
+		map0 {
+			cooling-device = <&fan 1 1>;
+			trip = <&wkup0_alert0>;
+		};
+
+		map1 {
+			cooling-device = <&fan 2 2>;
+			trip = <&wkup0_alert1>;
+		};
+	};
+};
+
+&wkup1_thermal {
+	cooling-maps {
+		map0 {
+			cooling-device = <&fan 1 1>;
+			trip = <&wkup1_alert0>;
+		};
+
+		map1 {
+			cooling-device = <&fan 2 2>;
+			trip = <&wkup1_alert1>;
+		};
+	};
+};
+
+&wkup_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_04>; /* Aquila GPIO_04 */
+};
+
+/* Aquila UART_2 */
+&wkup_uart0 {
+	status = "okay";
+};
-- 
2.47.3



Return-Path: <linux-kernel+bounces-865177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F68BFC6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3AD5E821E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DA132F763;
	Wed, 22 Oct 2025 14:06:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95734B438
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141964; cv=none; b=BfxJqqvsX+BNEeFlusiHFp9UTbXt4b+VzH4Zszl1N4OqigfGxA2cdru/pLl+OAjPeLx/FGRAVTk/k+KUyqs/OcmSppyqRvhTAidrTVftU8Y0olO3cyG8t8hk4NghUG1RC2xFHQgx4bFJyGvzfTKSOkqkxZxDmd8GSWx4Dh53xuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141964; c=relaxed/simple;
	bh=CG+abs5h92dR6RQr4Prb+kM1ENGWGiWZycfg8QpCcak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HubfbLJt54k2vbwxat5Palo/K6HYTjiDNXk2Kud6I+YnVdBCwtiHyEZfy2Okgj47dXIE0DLbRNR85wDVGKnsK3wZRjV+1ACejhAEYtxk5OYnp6JH4Z+S69qzOdDwCrkD7n3UNcY+XJhF8SkUT8HIqPZnQ8LOViWXD6wClxJQE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude06.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::5c])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pflug@pengutronix.de>)
	id 1vBZTI-0000vR-EH; Wed, 22 Oct 2025 16:05:48 +0200
From: Fabian Pflug <f.pflug@pengutronix.de>
Date: Wed, 22 Oct 2025 16:05:23 +0200
Subject: [PATCH v3 2/2] arm64: dts: freescale: add support for NXP i.MX93
 FRDM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-fpg-nxp-imx93-frdm-v3-2-03ec40a1ccc0@pengutronix.de>
References: <20251022-fpg-nxp-imx93-frdm-v3-0-03ec40a1ccc0@pengutronix.de>
In-Reply-To: <20251022-fpg-nxp-imx93-frdm-v3-0-03ec40a1ccc0@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Fabian Pflug <f.pflug@pengutronix.de>, 
 Haidong Zheng <haidong.zheng@nxp.com>, Danwei Luo <danwei.luo@nxp.com>, 
 Lei Xu <lei.xu@nxp.com>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::5c
X-SA-Exim-Mail-From: f.pflug@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The FRDM i.MX 93 development board is a low-cost and compact development
board featuring the i.MX93 applications processor.

It features:
- Dual Cortex-A55
- 2 GB LPDDR4X / LPDDR4
- 32 GB eMMC5.1
- MicroSD slot
- GbE RJ45 x 2
- USB2.0 1x Type C, 1x Type A

This file is based upon the one provided by nxp in their own kernel and
yocto meta layer for the device, but adapted for mainline.

Signed-off-by: Haidong Zheng <haidong.zheng@nxp.com>
Signed-off-by: Danwei Luo <danwei.luo@nxp.com>
Signed-off-by: Lei Xu <lei.xu@nxp.com>
Signed-off-by: Fabian Pflug <f.pflug@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 658 +++++++++++++++++++++
 2 files changed, 659 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 525ef180481d3..a7e5fdd6faff1 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -351,6 +351,7 @@ imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb-i3c.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-frdm.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-14x14-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
new file mode 100644
index 0000000000000..1f21eeb15b721
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
@@ -0,0 +1,658 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx93.dtsi"
+
+/ {
+	compatible = "fsl,imx93-11x11-frdm", "fsl,imx93";
+	model = "NXP i.MX93 11X11 FRDM board";
+
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		mmc0 = &usdhc1; /* EMMC */
+		mmc1 = &usdhc2; /* uSD */
+		rtc0 = &pcf2131;
+		serial0 = &lpuart1;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		off-on-delay-us = <12000>;
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		pinctrl-names = "default";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "VSD_3V3";
+		vin-supply = <&buck4>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc3_vmmc: regulator-usdhc3 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "WLAN_EN";
+		vin-supply = <&buck4>;
+		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		/*
+		 * IW612 wifi chip needs more delay than other wifi chips to complete
+		 * the host interface initialization after power up, otherwise the
+		 * internal state of IW612 may be unstable, resulting in the failure of
+		 * the SDIO3.0 switch voltage.
+		 */
+		startup-delay-us = <20000>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x30000000>;
+			reusable;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+
+		rsc_table: rsc-table@2021e000 {
+			reg = <0 0x2021e000 0 0x1000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@a4000000 {
+			reg = <0 0xa4000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@a4008000 {
+			reg = <0 0xa4008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@a4010000 {
+			reg = <0 0xa4010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@a4018000 {
+			reg = <0 0xa4018000 0 0x8000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@a4020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4020000 0 0x100000>;
+			no-map;
+		};
+	};
+
+	usdhc3_pwrseq: usdhc3_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pcal6524 12 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&adc1 {
+	vref-supply = <&buck5>;
+	status = "okay";
+};
+
+&mu1 {
+	status = "okay";
+};
+
+&cm33 {
+	mboxes = <&mu1 0 1>,
+		 <&mu1 1 1>,
+		 <&mu1 3 1>;
+	mbox-names = "tx", "rx", "rxdb";
+	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+	status = "okay";
+};
+
+&eqos {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-1 = <&pinctrl_fec_sleep>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy2>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy2: ethernet-phy@2 {
+			reg = <2>;
+			eee-broken-1000t;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	it6263: hdmi@4c {
+		compatible = "ite,it6263";
+		reg = <0x4c>;
+		ivdd-supply = <&buck5>;
+		ovdd-supply = <&buck4>;
+		txavcc18-supply = <&buck5>;
+		txavcc33-supply = <&buck4>;
+		pvcc1-supply = <&buck5>;
+		pvcc2-supply = <&buck5>;
+		avcc-supply = <&buck4>;
+		anvdd-supply = <&buck5>;
+		apvdd-supply = <&buck5>;
+	};
+};
+
+&lpi2c2 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		pinctrl-names = "default";
+		/* does not boot with supplier set, because it is the bucks interrupt parent */
+		/* vcc-supply = <&buck4>; */
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+
+			buck1: BUCK1 {
+				regulator-name = "VDD_SOC_0V8";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <950000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "LPD4_x_VDDQ_0V6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <670000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4 {
+				regulator-name = "VDD_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck5: BUCK5 {
+				regulator-name = "VDD_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "LPD4_x_VDD2_1V1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "NVCC_BBSM_1V8";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <1980000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "VDD_ANA_0V8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <840000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "NVCC_SD";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+		vcc-supply = <&buck4>;
+	};
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <15000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+					PDO_VAR(5000, 20000, 3000)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&lpuart1 { /* console */
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usbotg1 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	status = "okay";
+
+	port {
+
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usbotg2 {
+	disable-over-current;
+	dr_mode = "host";
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	status = "okay";
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	vmmc-supply = <&buck4>;
+	status = "okay";
+};
+
+&usdhc2 {
+	bus-width = <4>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&wdog3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
+			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
+			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
+			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x58e
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
+			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
+			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
+			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
+		>;
+	};
+
+	pinctrl_eqos_sleep: eqossleepgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_MDC__GPIO4_IO00			0x31e
+			MX93_PAD_ENET1_MDIO__GPIO4_IO01			0x31e
+			MX93_PAD_ENET1_RD0__GPIO4_IO10			0x31e
+			MX93_PAD_ENET1_RD1__GPIO4_IO11			0x31e
+			MX93_PAD_ENET1_RD2__GPIO4_IO12			0x31e
+			MX93_PAD_ENET1_RD3__GPIO4_IO13			0x31e
+			MX93_PAD_ENET1_RXC__GPIO4_IO09			0x31e
+			MX93_PAD_ENET1_RX_CTL__GPIO4_IO08		0x31e
+			MX93_PAD_ENET1_TD0__GPIO4_IO05			0x31e
+			MX93_PAD_ENET1_TD1__GPIO4_IO04			0x31e
+			MX93_PAD_ENET1_TD2__GPIO4_IO03			0x31e
+			MX93_PAD_ENET1_TD3__GPIO4_IO02			0x31e
+			MX93_PAD_ENET1_TXC__GPIO4_IO07			0x31e
+			MX93_PAD_ENET1_TX_CTL__GPIO4_IO06		0x31e
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e
+			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x57e
+			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
+			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
+			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
+			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
+			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x58e
+			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
+			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
+			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
+			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
+			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
+			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x58e
+			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
+		>;
+	};
+
+	pinctrl_fec_sleep: fecsleepgrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDC__GPIO4_IO14			0x51e
+			MX93_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
+			MX93_PAD_ENET2_RD0__GPIO4_IO24			0x51e
+			MX93_PAD_ENET2_RD1__GPIO4_IO25			0x51e
+			MX93_PAD_ENET2_RD2__GPIO4_IO26			0x51e
+			MX93_PAD_ENET2_RD3__GPIO4_IO27			0x51e
+			MX93_PAD_ENET2_RXC__GPIO4_IO23			0x51e
+			MX93_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
+			MX93_PAD_ENET2_TD0__GPIO4_IO19			0x51e
+			MX93_PAD_ENET2_TD1__GPIO4_IO18			0x51e
+			MX93_PAD_ENET2_TD2__GPIO4_IO17			0x51e
+			MX93_PAD_ENET2_TD3__GPIO4_IO16			0x51e
+			MX93_PAD_ENET2_TXC__GPIO4_IO21			0x51e
+			MX93_PAD_ENET2_TX_CTL__GPIO4_IO20		0x51e
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO25__CAN2_TX			0x139e
+			MX93_PAD_GPIO_IO27__CAN2_RX			0x139e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07		0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x1582
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x40001382
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x40001382
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x40001382
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x40001382
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x40001382
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x40001382
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x40001382
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x40001382
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x40001382
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x158e
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000138e
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000138e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000138e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000138e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000138e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000138e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000138e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000138e
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400013fe
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x400013fe
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x400013fe
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013fe
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x400013fe
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x400013fe
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x400013fe
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x400013fe
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x400013fe
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x1582
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x40001382
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x40001382
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x40001382
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x40001382
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x40001382
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000138e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000138e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x400013fe
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x400013fe
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x400013fe
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x400013fe
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x400013fe
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__GPIO3_IO01		0x51e
+			MX93_PAD_SD2_CMD__GPIO3_IO02		0x51e
+			MX93_PAD_SD2_DATA0__GPIO3_IO03		0x51e
+			MX93_PAD_SD2_DATA1__GPIO3_IO04		0x51e
+			MX93_PAD_SD2_DATA2__GPIO3_IO05		0x51e
+			MX93_PAD_SD2_DATA3__GPIO3_IO06		0x51e
+			MX93_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX93_PAD_WDOG_ANY__WDOG1_WDOG_ANY	0x31e
+		>;
+	};
+};

-- 
2.47.3



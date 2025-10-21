Return-Path: <linux-kernel+bounces-862580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9ECBF5AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0463ADA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C32BEFED;
	Tue, 21 Oct 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="ocpkYQvY"
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B33303A0F;
	Tue, 21 Oct 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040807; cv=none; b=ImGhGeqc/e2TXLm5CshaSdr8FnKdI8sKt035WwF2IZV4bjS+N9AvpWNTo2xwnR1stxxRuja6bBsfYAZ1DJydn/5VNMVke/2++sFNnvXsWxJGyEzXrsOMM0gFYjd0KpnSeTQ39RSOMkEgqa2MgjWbTtO7zYyz9gnpVFa+YcxqGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040807; c=relaxed/simple;
	bh=0dO+IQllYACH7qrQzWxeqrOUAGCMfZXxijBNp3UHTJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiskNvEWJ13qLFs67f5dw46/KIvi+9QfhIRklDSSPOx4wQE8gbvKfNaawqF+/i71xZYSTAm3H2NMe47zWoiVJC+eW0vu3Qo8kmJ0QgXDfse+rQkTC3cal83wFKCHJ5vPrJ6Gy5aLgHcfLcV2UFNfMJPWp7kEKdWqiTPpg7N6zHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=ocpkYQvY; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dtPvlyyddmhQmIJXKfCbxozagUBJVI2IUjCtu4wNZG4=; b=ocpkYQvYabRzkul/hKTVUrkQnp
	ejkALLEaBunMAVueLuDRxGaNgU0vKORHQJNw3Bk7o1tqcqptWzYPX2A/1oK/XzRC+8PpEFoFeccoh
	phX5Yj5nzFtvsylcIhVv0RqMjDd3RpK0J9H9djiBcObu2wkRw0tjwBn+BMhiIaleC8++nP0t2xsOW
	KAOL7itpXXfRPE0PHnOje6AXlkLKtfKGYWYBvliw5nMriWLt9i763MwvoX4ASUQ0j3i027sQVVzpb
	E4+BhMjeY9XhbPK8CgStUjlNvBiRHXUV6257UAw/4f2QXbaBCLzwBvxIkSh1w5d4NBNyt0qwW/i4J
	cUnz8T/Q==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:33124 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1vB8nj-00000004LXL-40Mm;
	Tue, 21 Oct 2025 11:37:05 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH 2/2] arm64: dts: freescale: Add phyBOARD-Segin-i.MX91 support
Date: Tue, 21 Oct 2025 11:37:04 +0200
Message-Id: <20251021093704.690410-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021093704.690410-1-primoz.fiser@norik.com>
References: <20251021093704.690410-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add initial support for the PHYTEC phyBOARD-Segin-i.MX91 board [1] based
on the PHYTEC phyCORE-i.MX91 SoM (System-on-Module) [2].

Supported features:
* Audio
* CAN
* eMMC
* Ethernet
* I2C
* RTC
* SD-Card
* UART
* USB

For more details see the product pages for the development board and the
SoM:

[1] https://www.phytec.eu/en/produkte/development-kits/phyboard-segin-kit/
[2] https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx91-phyboard-segin.dts    | 344 ++++++++++++++++++
 .../boot/dts/freescale/imx91-phycore-som.dtsi | 304 ++++++++++++++++
 3 files changed, 649 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-phyboard-segin.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-phycore-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 525ef180481d..34a81d34de39 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -344,6 +344,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-9x9-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx91-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx91-tqma9131-mba91xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 
diff --git a/arch/arm64/boot/dts/freescale/imx91-phyboard-segin.dts b/arch/arm64/boot/dts/freescale/imx91-phyboard-segin.dts
new file mode 100644
index 000000000000..bb631439f9cf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx91-phyboard-segin.dts
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Christoph Stoidner <c.stoidner@phytec.de>
+ *
+ * Product homepage:
+ * phyBOARD-Segin carrier board is reused for the i.MX91 design.
+ * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
+ */
+/dts-v1/;
+
+#include "imx91-phycore-som.dtsi"
+
+/{
+	model = "PHYTEC phyBOARD-Segin-i.MX91";
+	compatible = "phytec,imx91-phyboard-segin", "phytec,imx91-phycore-som",
+		     "fsl,imx91";
+
+	aliases {
+		ethernet1 = &eqos;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		rtc0 = &i2c_rtc;
+		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	flexcan1_tc: can-phy0 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <1000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan1_tc>;
+		enable-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_sound_1v8: regulator-sound-1v8 {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "VCC1V8_AUDIO";
+	};
+
+	reg_sound_3v3: regulator-sound-3v3 {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VCC3V3_ANALOG";
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_OTG1_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_OTG2_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "VCC_SD";
+	};
+
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "phyBOARD-Segin-TLV320AIC3007";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,widgets =
+			"Line", "Line In",
+			"Line", "Line Out",
+			"Speaker", "Speaker";
+		simple-audio-card,routing =
+			"Line Out", "LLOUT",
+			"Line Out", "RLOUT",
+			"Speaker", "SPOP",
+			"Speaker", "SPOM",
+			"LINE1L", "Line In",
+			"LINE1R", "Line In";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&audio_codec>;
+			clocks = <&clk IMX93_CLK_SAI1>;
+		};
+	};
+};
+
+/* Ethernet */
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy2>;
+	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
+				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+	assigned-clock-rates = <100000000>, <50000000>;
+	status = "okay";
+};
+
+&mdio {
+	ethphy2: ethernet-phy@2 {
+		compatible = "ethernet-phy-id0022.1561";
+		reg = <2>;
+		clocks = <&clk IMX91_CLK_ENET2_REGULAR>;
+		clock-names = "rmii-ref";
+		micrel,led-mode = <1>;
+	};
+};
+
+/* CAN */
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	phys = <&flexcan1_tc>;
+	status = "okay";
+};
+
+/* I2C2 */
+&lpi2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2_gpio>;
+	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	/* Codec */
+	audio_codec: audio-codec@18 {
+		compatible = "ti,tlv320aic3007";
+		reg = <0x18>;
+		#sound-dai-cells = <0>;
+		AVDD-supply = <&reg_sound_3v3>;
+		IOVDD-supply = <&reg_sound_3v3>;
+		DRVDD-supply = <&reg_sound_3v3>;
+		DVDD-supply = <&reg_sound_1v8>;
+	};
+
+	/* RTC */
+	i2c_rtc: rtc@68 {
+		compatible = "microcrystal,rv4162";
+		reg = <0x68>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+/* Console */
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* Audio */
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clk IMX93_CLK_SAI1>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <19200000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+/* USB  */
+&usbphynop1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+};
+
+&usbphynop2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+};
+
+&usbotg1 {
+	disable-over-current;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbotg2 {
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* SD-Card */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
+	bus-width = <4>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_TD2__ENET_QOS_CLOCK_GENERATE_CLK	0x4000050e
+			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0		0x57e
+			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1		0x57e
+			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0		0x50e
+			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1		0x50e
+			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x57e
+			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x50e
+			MX91_PAD_ENET1_RXC__ENET_QOS_RX_ER		0x57e
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX91_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
+			MX91_PAD_PDM_CLK__CAN1_TX		0x139e
+		>;
+	};
+
+	pinctrl_flexcan1_tc: flexcan1tcgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_TD3__GPIO4_IO16		0x31e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX91_PAD_I2C2_SCL__LPI2C2_SCL		0x40000b9e
+			MX91_PAD_I2C2_SDA__LPI2C2_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
+		fsl,pins = <
+			MX91_PAD_I2C2_SCL__GPIO1_IO2		0x31e
+			MX91_PAD_I2C2_SDA__GPIO1_IO3		0x31e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_RESET_B__GPIO3_IO7		0x31e
+		>;
+	};
+
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_RD2__GPIO4_IO26		0x31e
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX91_PAD_UART2_RXD__SAI1_MCLK		0x1202
+			MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC	0x1202
+			MX91_PAD_SAI1_TXC__SAI1_TX_BCLK		0x1202
+			MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0	0x1402
+			MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0	0x1402
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX91_PAD_UART1_RXD__LPUART1_RX		0x31e
+			MX91_PAD_UART1_TXD__LPUART1_TX		0x30e
+		>;
+	};
+
+	pinctrl_usdhc2_cd: usdhc2cdgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_default: usdhc2grp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1386
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x139e
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x159e
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x139e
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x139e
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x139e
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x139e
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x139e
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx91-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx91-phycore-som.dtsi
new file mode 100644
index 000000000000..0d9310f86f45
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx91-phycore-som.dtsi
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Christoph Stoidner <c.stoidner@phytec.de>
+ *
+ * Product homepage:
+ * https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
+ */
+
+#include <dt-bindings/leds/common.h>
+
+#include "imx91.dtsi"
+
+/ {
+	model = "PHYTEC phyCORE-i.MX91";
+	compatible = "phytec,imx91-phycore-som", "fsl,imx91";
+
+	aliases {
+		ethernet0 = &fec;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reg_vdda_1v8: regulator-vdda-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDA_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&buck5>;
+	};
+};
+
+/* ADC */
+&adc1 {
+	vref-supply = <&reg_vdda_1v8>;
+};
+
+/* Ethernet */
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+
+	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
+			  <&clk IMX91_CLK_ENET2_REGULAR>;
+	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
+				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+	assigned-clock-rates = <100000000>, <50000000>;
+	status = "okay";
+
+	mdio: mdio {
+		clock-frequency = <5000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			reset-gpios = <&gpio4 23 GPIO_ACTIVE_HIGH>;
+			reset-assert-us = <30>;
+		};
+	};
+};
+
+/* I2C3 */
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
+	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "VDD_SOC";
+				regulator-min-microvolt = <610000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "VDDQ_0V6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <600000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4: BUCK4 {
+				regulator-name = "VDD_3V3_BUCK";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5 {
+				regulator-name = "VDD_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "VDD_1V1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "PMIC_SNVS_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "VDD_0V8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "NVCC_SD2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	/* EEPROM */
+	eeprom@50 {
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+		pagesize = <32>;
+		vcc-supply = <&buck4>;
+	};
+};
+
+/* eMMC */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	status = "okay";
+};
+
+/* Watchdog */
+&wdog3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__ENET2_MDC			0x50e
+			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x502
+			/* the three pins below are connected to PHYs straps,
+			 * that is what the pull-up/down setting is for.
+			 */
+			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x37e
+			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x37e
+			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
+			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x50e
+			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x50e
+			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x50e
+			MX91_PAD_ENET2_TD2__ENET2_TX_CLK2		0x4000050e
+			MX91_PAD_ENET2_RXC__GPIO4_IO23			0x51e
+		>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		fsl,pins = <
+			MX91_PAD_I2C1_SDA__GPIO1_IO1		0x11e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO28__LPI2C3_SDA		0x40000b9e
+			MX91_PAD_GPIO_IO29__LPI2C3_SCL		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO28__GPIO2_IO28		0x31e
+			MX91_PAD_GPIO_IO29__GPIO2_IO29		0x31e
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_RD3__GPIO4_IO27		0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x179e
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1386
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1386
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1386
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1386
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1386
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1386
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1386
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x17be
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x139e
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x139e
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13be
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x139e
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x139e
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x139e
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x139e
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x139e
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x17be
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x139e
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x139e
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13be
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13be
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13be
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13be
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13be
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13be
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13be
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX91_PAD_WDOG_ANY__WDOG1_WDOG_ANY	0x31e
+		>;
+	};
+};
-- 
2.34.1



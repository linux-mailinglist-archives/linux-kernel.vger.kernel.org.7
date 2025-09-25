Return-Path: <linux-kernel+bounces-833217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CF7BA16FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86653189E2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F913218C4;
	Thu, 25 Sep 2025 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="snSj4+SA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MQWlmZA2"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D17321438;
	Thu, 25 Sep 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833562; cv=none; b=Y93/4a/UNzAPuneATLeU4J2dwuywgqC9M2r5/4VG2+j6pIDnz9Br+WAOkFReyjbF9sOCmMRThVVY4wFfskCF3AIN/EQuCsNoMSFvybguRUcGs/HCwwkltcbyPY+rn/3S/hgg0HT/kHr2SJd1zH0oVAtRhT8qyXta98GxMDkCvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833562; c=relaxed/simple;
	bh=D5S4tUqluLODLIc5FQGiXmG7zsWMpXiOg6qAH65vmDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oulbWcVxKC3yF8TziTD0XViZE5houMtKuKQQMSjQa3hTycUwpEgy7vKKZ6EGXbA3SWbIpwiyltbGkpORP3UptrWXXvs0t0qcpGtooVUks/X1YUCbGP8DnennLi8OFeqmba7YjkqdV5BXU7MX3qKjXgYKLGOpjemACpxRAtDVSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=snSj4+SA; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MQWlmZA2; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cXmBG4spDz9tTp;
	Thu, 25 Sep 2025 22:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758833558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRi8Msx0UADycP4UF4Arf7Uu/v2t8MbPA3Ic/OoFKbg=;
	b=snSj4+SAeaQij73+Ui4Qdtwb5A85Hbau5UkhFwRyWRiYazznjJXwNroQFpDRbJpgKYSz/O
	si7QW9/hLnN+kVsjqWFUJJ9iNU+szJ1NGS6uqhtP5ZpYap8U2m5OckqcvwPe/zLIc847Ze
	FHuyqdL91vkcFcfVNROt7pH064BdsFNV1dB9cciqBYIhhS0DH9cckjRrzl6Z5AGG8S9lm4
	C+ynzGfFr/i6iPHYgOJBxFXOnZDRK0mqWKPolcLuXihu0uSkAhckrvBflgCnFhy31QN0So
	ctMMPe8WZ+tlXOxl1F1XGELmNbgCIJGGtRZ8SS1RxW9HZHRsTdX824DPFKVemA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=MQWlmZA2;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758833556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRi8Msx0UADycP4UF4Arf7Uu/v2t8MbPA3Ic/OoFKbg=;
	b=MQWlmZA22gxW6r3YilIKZ7NnqsS9xKbu3kH4KfXZ7912Y15pRXLuiNTznJ0jCjlnmRFmYu
	hbl5QeyNGByPGlLBA8nvPjMB2EiYRQUL9Cw1G1d0X5sDgWDtj4CO871bJflWSaGR8pcJEH
	X6gzC0Z1FwOhhldjQEW/eRmD1U3fdTTzN5l/BSvluUN3EBj1Cohly6jd3ZY9vF9iwKDNl2
	svhL6fnXgoRQbiOfSYCEWz7eQpc3jP8SrwUcS1SqqjTlzl8WeLxlwzqIa4MneoRiSNe+jg
	HWR3Bx4mfCTIFTDIbHEex+F1NYWD/zBXwunhLi1ZtHWf79vAnjGCFCf9k6RAAQ==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Goncalves <jpaulo.silvagoncalves@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: freescale: add initial support for i.MX 95 Verdin Evaluation Kit (EVK)
Date: Thu, 25 Sep 2025 22:51:55 +0200
Message-ID: <20250925205211.171699-2-marek.vasut@mailbox.org>
In-Reply-To: <20250925205211.171699-1-marek.vasut@mailbox.org>
References: <20250925205211.171699-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kmhdhmppe339bpo66txbsug1jre1hsp5
X-MBO-RS-ID: 052a94c151a4cde5c14
X-Rspamd-Queue-Id: 4cXmBG4spDz9tTp

Add initial support for i.MX 95 Verdin Evaluation Kit (EVK), which
used to be the Titan EVK. Currently supported is lpuart1 as console,
SDHC1/2/3 as storage, WM8904 Audio, USB3.0 and ENETC ethernet RGMII
Gigabit port.

Note that the SoM used in this EVK is a derivative SoM from Verdin
line of SoMs, an actual i.MX95 Verdin SoM is under development.

[1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95-evaluation-kit

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Tested-by: João Paulo Gonçalves <joao.goncalves@toradex.com> # i.MX95 Verdin EVK
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Joao Goncalves <joao.goncalves@toradex.com>
Cc: Joao Goncalves <jpaulo.silvagoncalves@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
V2: - Drop pwm.h
    - Write machine compatible string on single line
    - Add RB/TB from João
V3: - Add RB from Fabio
    - Sort pinctrl nodes
---
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx95-19x19-verdin-evk.dts  | 695 ++++++++++++++++++
 2 files changed, 697 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-verdin-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 525ef180481d3..c996bae3eb0ec 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -382,6 +382,8 @@ imx95-19x19-evk-pcie1-ep-dtbs += imx95-19x19-evk.dtb imx-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-pcie0-ep.dtb imx95-19x19-evk-pcie1-ep.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-libra-rdk-fpsc.dtb
 
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-verdin-evk.dtb
+
 imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
 imx8mm-kontron-bl-lte-dtbs		:= imx8mm-kontron-bl.dtb imx8mm-kontron-bl-lte.dtbo
 
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-verdin-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-verdin-evk.dts
new file mode 100644
index 0000000000000..2b0ff232f680d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-verdin-evk.dts
@@ -0,0 +1,695 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 NXP
+ * Copyright 2025 Marek Vasut <marek.vasut@mailbox.org>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx95.dtsi"
+
+#define FALLING_EDGE			1
+#define RISING_EDGE			2
+
+#define BRD_SM_CTRL_SD3_WAKE		0x8000	/* PCAL6408A-0 */
+#define BRD_SM_CTRL_PCIE1_WAKE		0x8001	/* PCAL6408A-4 */
+#define BRD_SM_CTRL_BT_WAKE		0x8002	/* PCAL6408A-5 */
+#define BRD_SM_CTRL_PCIE2_WAKE		0x8003	/* PCAL6408A-6 */
+#define BRD_SM_CTRL_BUTTON		0x8004	/* PCAL6408A-7 */
+
+/ {
+	model = "i.MX 95 Verdin Evaluation Kit (EVK)";
+	compatible = "toradex,verdin-imx95-19x19-evk", "fsl,imx95";
+
+	aliases {
+		ethernet0 = &enetc_port0;
+		ethernet1 = &enetc_port1;
+		ethernet2 = &enetc_port2;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x7f000000>;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+			reusable;
+		};
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_m2_pwr: regulator-m2-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "M.2-power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 4 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_pcie0: regulator-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE_WLAN_EN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_m2_pwr>;
+		gpio = <&i2c7_pcal6524 18 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VDD_SD2_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <12000>;
+	};
+
+	usdhc3_pwrseq: usdhc3-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&i2c7_pcal6524 11 GPIO_ACTIVE_HIGH>;
+	};
+
+	sound-wm8904 {
+		compatible = "fsl,imx-audio-wm8904";
+		model = "wm8904-audio";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8904>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"AMIC", "MICBIAS",
+			"IN2L", "AMIC";
+	};
+};
+
+&enetc_port0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enetc0>;
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&flexspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexspi1_reset>;
+		reset-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
+&lpi2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c4>;
+	status = "okay";
+
+	wm8904: codec@1a {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		clocks = <&scmi_clk IMX95_CLK_SAI3>;
+		clock-names = "mclk";
+		AVDD-supply = <&reg_1p8v>;
+		CPVDD-supply = <&reg_1p8v>;
+		DBVDD-supply = <&reg_1p8v>;
+		DCVDD-supply = <&reg_1p8v>;
+		MICVDD-supply = <&reg_1p8v>;
+	};
+};
+
+&lpi2c5 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c5>;
+	status = "okay";
+};
+
+&lpi2c6 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c6>;
+	status = "okay";
+};
+
+&lpi2c7 {
+	clock-frequency = <1000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c7>;
+	status = "okay";
+
+	i2c7_pcal6524: i2c7-gpio@23 {
+		compatible = "nxp,pcal6524";
+		reg = <0x23>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c7_pcal6524>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	/* Current measurement at SoM 5V power output */
+	hwmon@41 {
+		compatible = "ti,ina219";
+		reg = <0x41>;
+		shunt-resistor = <10000>;
+	};
+
+	/* Current measurement at Board power input */
+	hwmon@45 {
+		compatible = "ti,ina219";
+		reg = <0x45>;
+		shunt-resistor = <10000>;
+	};
+
+	eeprom@50 {
+		compatible = "st,24c02";
+		reg = <0x50>;
+	};
+
+	ptn5110: tcpc@52 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x52>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+
+		typec_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec_con_hs: endpoint {
+						remote-endpoint = <&usb3_data_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					typec_con_ss: endpoint {
+						remote-endpoint = <&usb3_data_ss>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&lpuart1 {
+	/* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&mu7 {
+	status = "okay";
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
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+	status = "okay";
+
+	ethphy0: ethernet-phy@1 {
+		reg = <1>;
+		realtek,clkout-disable;
+	};
+};
+
+&pcie0 {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	reset-gpio = <&i2c7_pcal6524 17 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-0 = <&pinctrl_pcie1>;
+	pinctrl-names = "default";
+	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&sai1 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI1>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&sai3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
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
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	role-switch-default-mode = "peripheral";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+	status = "okay";
+
+	port {
+		usb3_data_hs: endpoint {
+			remote-endpoint = <&typec_con_hs>;
+		};
+	};
+};
+
+&usb3_phy {
+	fsl,phy-tx-preemp-amp-tune-microamp = <600>;
+	orientation-switch;
+	status = "okay";
+
+	port {
+		usb3_data_ss: endpoint {
+			remote-endpoint = <&typec_con_ss>;
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	mmc-pwrseq = <&usdhc3_pwrseq>;
+	vmmc-supply = <&reg_pcie0>;
+	bus-width = <4>;
+	keep-power-in-suspend;
+	non-removable;
+	status = "okay";
+};
+
+&scmi_misc {
+	nxp,ctrl-ids = <BRD_SM_CTRL_SD3_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_PCIE1_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_BT_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_PCIE2_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_BUTTON	FALLING_EDGE>;
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO04__GPIO2_IO_BIT4			0x3fe>;
+	};
+
+	pinctrl_emdio: emdiogrp {
+		fsl,pins =
+			<IMX95_PAD_ENET1_MDC__NETCMIX_TOP_NETC_MDC		0x57e>,
+			<IMX95_PAD_ENET1_MDIO__NETCMIX_TOP_NETC_MDIO		0x97e>;
+	};
+
+	pinctrl_enetc0: enetc0grp {
+		fsl,pins =
+			<IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3	0x57e>,
+			<IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2	0x57e>,
+			<IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1	0x57e>,
+			<IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0	0x57e>,
+			<IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x57e>,
+			<IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK	0x58e>,
+			<IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x57e>,
+			<IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK	0x58e>,
+			<IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0	0x57e>,
+			<IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1	0x57e>,
+			<IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2	0x57e>,
+			<IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3	0x57e>;
+	};
+
+	pinctrl_flexspi1: flexspi1grp {
+		fsl,pins =
+			<IMX95_PAD_XSPI1_SS0_B__FLEXSPI1_A_SS0_B		0x3fe>,
+			<IMX95_PAD_XSPI1_SCLK__FLEXSPI1_A_SCLK			0x3fe>,
+			<IMX95_PAD_XSPI1_DQS__FLEXSPI1_A_DQS			0x3fe>,
+			<IMX95_PAD_XSPI1_DATA0__FLEXSPI1_A_DATA_BIT0		0x3fe>,
+			<IMX95_PAD_XSPI1_DATA1__FLEXSPI1_A_DATA_BIT1		0x3fe>,
+			<IMX95_PAD_XSPI1_DATA2__FLEXSPI1_A_DATA_BIT2		0x3fe>,
+			<IMX95_PAD_XSPI1_DATA3__FLEXSPI1_A_DATA_BIT3		0x3fe>,
+			<IMX95_PAD_XSPI1_DATA4__FLEXSPI1_A_DATA_BIT4		0x3fe>,
+			<IMX95_PAD_XSPI1_DATA5__FLEXSPI1_A_DATA_BIT5		0x3fe>,
+			<IMX95_PAD_XSPI1_DATA6__FLEXSPI1_A_DATA_BIT6		0x3fe>,
+			<IMX95_PAD_XSPI1_DATA7__FLEXSPI1_A_DATA_BIT7		0x3fe>;
+	};
+
+	pinctrl_flexspi1_reset: flexspi1-reset-grp {
+		fsl,pins =
+			<IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11			0x3fe>;
+	};
+
+	pinctrl_hp: hpgrp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO11__GPIO2_IO_BIT11			0x31e>;
+	};
+
+	pinctrl_i2c4_pcal6408: i2c4pcal6498grp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18			0x31e>;
+	};
+
+	pinctrl_i2c7_pcal6524: i2c7pcal6524grp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO36__GPIO5_IO_BIT16			0x31e>;
+	};
+
+	pinctrl_lpi2c4: lpi2c4grp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO30__LPI2C4_SDA			0x40000b9e>,
+			<IMX95_PAD_GPIO_IO31__LPI2C4_SCL			0x40000b9e>;
+	};
+
+	pinctrl_lpi2c5: lpi2c5grp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO22__LPI2C5_SDA			0x40000b9e>,
+			<IMX95_PAD_GPIO_IO23__LPI2C5_SCL			0x40000b9e>;
+	};
+
+	pinctrl_lpi2c6: lpi2c6grp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO02__LPI2C6_SDA			0x40000b9e>,
+			<IMX95_PAD_GPIO_IO03__LPI2C6_SCL			0x40000b9e>;
+	};
+
+	pinctrl_lpi2c7: lpi2c7grp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO08__LPI2C7_SDA			0x40000b9e>,
+			<IMX95_PAD_GPIO_IO09__LPI2C7_SCL			0x40000b9e>;
+	};
+
+	pinctrl_pcal6416: pcal6416grp {
+		fsl,pins =
+			<IMX95_PAD_CCM_CLKO3__GPIO4_IO_BIT28			0x31e>;
+	};
+
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B	0x4000031e>;
+	};
+
+	pinctrl_pcie1: pcie1grp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B	0x4000031e>;
+	};
+
+	pinctrl_pdm: pdmgrp {
+		fsl,pins =
+			<IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK				0x31e>,
+			<IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_PDM_BIT_STREAM_BIT0	0x31e>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins =
+			<IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7		0x31e>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins =
+			<IMX95_PAD_SAI1_RXD0__AONMIX_TOP_SAI1_RX_DATA_BIT0	0x31e>,
+			<IMX95_PAD_SAI1_TXC__AONMIX_TOP_SAI1_TX_BCLK		0x31e>,
+			<IMX95_PAD_SAI1_TXFS__AONMIX_TOP_SAI1_TX_SYNC		0x31e>,
+			<IMX95_PAD_SAI1_TXD0__AONMIX_TOP_SAI1_TX_DATA_BIT0	0x31e>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins =
+			<IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_SAI2_RX_BCLK		0x31e>,
+			<IMX95_PAD_ENET2_MDC__NETCMIX_TOP_SAI2_RX_SYNC		0x31e>,
+			<IMX95_PAD_ENET2_TD3__NETCMIX_TOP_SAI2_RX_DATA_BIT0	0x31e>,
+			<IMX95_PAD_ENET2_TD2__NETCMIX_TOP_SAI2_RX_DATA_BIT1	0x31e>,
+			<IMX95_PAD_ENET2_TXC__NETCMIX_TOP_SAI2_TX_BCLK		0x31e>,
+			<IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_SAI2_TX_SYNC	0x31e>,
+			<IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_SAI2_TX_DATA_BIT0	0x31e>,
+			<IMX95_PAD_ENET2_RXC__NETCMIX_TOP_SAI2_TX_DATA_BIT1	0x31e>,
+			<IMX95_PAD_ENET2_RD0__NETCMIX_TOP_SAI2_TX_DATA_BIT2	0x31e>,
+			<IMX95_PAD_ENET2_RD1__NETCMIX_TOP_SAI2_TX_DATA_BIT3	0x31e>,
+			<IMX95_PAD_ENET2_RD2__NETCMIX_TOP_SAI2_MCLK		0x31e>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO17__SAI3_MCLK			0x31e>,
+			<IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK		0x31e>,
+			<IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC		0x31e>,
+			<IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0		0x31e>,
+			<IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0		0x31e>;
+	};
+
+	pinctrl_tpm6: tpm6grp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO19__TPM6_CH2			0x51e>;
+	};
+
+	pinctrl_typec: typecgrp {
+		fsl,pins =
+			<IMX95_PAD_GPIO_IO34__GPIO5_IO_BIT14		0x31e>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins =
+			<IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX	0x31e>,
+			<IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX	0x31e>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins =
+			<IMX95_PAD_SD1_CLK__USDHC1_CLK			0x158e>,
+			<IMX95_PAD_SD1_CMD__USDHC1_CMD			0x138e>,
+			<IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x138e>,
+			<IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x138e>,
+			<IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x138e>,
+			<IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x138e>,
+			<IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x138e>,
+			<IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x138e>,
+			<IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x138e>,
+			<IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x138e>,
+			<IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x158e>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins =
+			<IMX95_PAD_SD1_CLK__USDHC1_CLK			0x158e>,
+			<IMX95_PAD_SD1_CMD__USDHC1_CMD			0x138e>,
+			<IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x138e>,
+			<IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x138e>,
+			<IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x138e>,
+			<IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x138e>,
+			<IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x138e>,
+			<IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x138e>,
+			<IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x138e>,
+			<IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x138e>,
+			<IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x158e>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins =
+			<IMX95_PAD_SD1_CLK__USDHC1_CLK			0x15fe>,
+			<IMX95_PAD_SD1_CMD__USDHC1_CMD			0x13fe>,
+			<IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x13fe>,
+			<IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x13fe>,
+			<IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x13fe>,
+			<IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x13fe>,
+			<IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x13fe>,
+			<IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x13fe>,
+			<IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x13fe>,
+			<IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x13fe>,
+			<IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x15fe>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins =
+			<IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0		0x31e>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins =
+			<IMX95_PAD_SD2_CLK__USDHC2_CLK			0x158e>,
+			<IMX95_PAD_SD2_CMD__USDHC2_CMD			0x138e>,
+			<IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e>,
+			<IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e>,
+			<IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e>,
+			<IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e>,
+			<IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins =
+			<IMX95_PAD_SD2_CLK__USDHC2_CLK			0x158e>,
+			<IMX95_PAD_SD2_CMD__USDHC2_CMD			0x138e>,
+			<IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e>,
+			<IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e>,
+			<IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e>,
+			<IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e>,
+			<IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins =
+			<IMX95_PAD_SD2_CLK__USDHC2_CLK			0x15fe>,
+			<IMX95_PAD_SD2_CMD__USDHC2_CMD			0x13fe>,
+			<IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x13fe>,
+			<IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x13fe>,
+			<IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x13fe>,
+			<IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x13fe>,
+			<IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins =
+			<IMX95_PAD_SD3_CLK__USDHC3_CLK			0x158e>,
+			<IMX95_PAD_SD3_CMD__USDHC3_CMD			0x138e>,
+			<IMX95_PAD_SD3_DATA0__USDHC3_DATA0		0x138e>,
+			<IMX95_PAD_SD3_DATA1__USDHC3_DATA1		0x138e>,
+			<IMX95_PAD_SD3_DATA2__USDHC3_DATA2		0x138e>,
+			<IMX95_PAD_SD3_DATA3__USDHC3_DATA3		0x138e>;
+	};
+};
-- 
2.51.0



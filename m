Return-Path: <linux-kernel+bounces-877617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C354C1E96D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40C5E4E85F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEFA32ED48;
	Thu, 30 Oct 2025 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbCnDEI6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AD301004;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806142; cv=none; b=m/BGCtr8d7qn5dI6lsPT++jxNmCj1P4kS/P/drCz1YwKJbXE9W7TvoKAWXrvqgNeGBJR5ImI89a9bXnv6C5b+pGEseqVs+rL9up+bfoPbuYvnGTbTzaPWGFoKOmqY3Oix9bORL5rcdGYjAtSCp7+lkp58mExWxmGh/lU3YUDYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806142; c=relaxed/simple;
	bh=Ma9S1MiEWHeTP+z84iPAUK6C7dIUoddkYZ0/XXmKMfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDTGQjaHo+nm8DszI4iWKo8aPrV9v/HHVOa2iVqYho2u15fJZ4+3JU7oQxzn7b7kmTFSpJEx5jWLvYsLyp8Pnuh/hA4OnJxw/GIW44e0JviXJFfY7HfIDresTDL15fj9Bb/xz9vi9D5UCvCIMlf6x8zAWCeSDwOyxyXKLbLjXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbCnDEI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AECAC16AAE;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761806142;
	bh=Ma9S1MiEWHeTP+z84iPAUK6C7dIUoddkYZ0/XXmKMfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kbCnDEI69CKzeU1AmNh1KE2+wf4gmwB01wcthC3Q3hUYInG9ax2BoKjbCeWdNFF3L
	 BSfgA5nXcB+Zx8QfdxE9u2BkrRECxuPdPGsp/9XPjpOIKXerAKnVc7h2lux+iRVhuL
	 +dR7Mt57Jqvqf/jiO5OwUFFf5CAq0Ka4/AOAlT6cPd7EvJnjYG44NLFnoa+FyIyU6m
	 7IByQH0HAktQ2BPmnXSsHZHe8t6AqupNiFOalON7OcFWzQp6vWtIHwKwokwqPrLEBl
	 H9dK/T9LXmd204CRZ7UoFzpjBU0tr39+eUBqYay6eTsrjnBAf4tiIGs3C/aMNqZC7R
	 BSVubPW1+Yifg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BD7CCF9FC;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 30 Oct 2025 07:35:40 +0100
Subject: [PATCH v3 4/6] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251030-mini_iv-v3-4-ef56c4d9f219@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761806140; l=14085;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=mM5zkndvpY3wSFdRNuLQZbA3Bw/wyjuh2hndAkyqoOE=;
 b=+FD0wu3/k5yaUNS9ddmTxxAwfMPSl82Py1Xddc1Ts5qrcVh76aWiJYnyng1pNQfXdiX8qDwlw
 Jc2V2UP9ljuAJHCwmjo00GFoypbBE/V6124+jSSP4dAVGNbhHpTB8OF
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

The Ka-Ro Electronics tx8m-1610 is a COM based on the imx8mm SOC. It has
1 GB of ram and 4 GB of eMMC storage on board.

Add it to enable boards based on this module

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 .../arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi | 444 +++++++++++++++++++++
 1 file changed, 444 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
new file mode 100644
index 0000000000000..53bf70793ac01
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 Lothar Waßmann <LW@KARO-electronics.de>
+ * 2025 Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+#include "imx8mm.dtsi"
+
+/ {
+	model = "Ka-Ro Electronics TX8M-1610";
+	compatible = "karo,imx8mm-tx8m-1610", "fsl,imx8mm";
+
+	reg_3v3_etn: regulator-3v3-etn {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 23 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pinctrl_reg_3v3_etn>;
+		pinctrl-names = "default";
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3v3-etn";
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&ddrc {
+	operating-points-v2 = <&ddrc_opp_table>;
+
+	ddrc_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+		};
+	};
+};
+
+&fec1 {
+	assigned-clocks = <&clk IMX8MM_CLK_ENET_AXI>,
+			  <&clk IMX8MM_CLK_ENET_TIMER>,
+			  <&clk IMX8MM_CLK_ENET_REF>,
+			  <&clk IMX8MM_CLK_ENET_REF>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
+				 <&clk IMX8MM_SYS_PLL2_100M>,
+				 <&clk IMX8MM_SYS_PLL2_50M>,
+				 <&clk IMX8MM_SYS_PLL2_50M>;
+	assigned-clock-rates = <0>, <100000000>, <50000000>, <50000000>;
+	clocks = <&clk IMX8MM_CLK_ENET1_ROOT>,
+		 <&clk IMX8MM_CLK_ENET1_ROOT>,
+		 <&clk IMX8MM_CLK_ENET_TIMER>,
+		 <&clk IMX8MM_CLK_ENET_REF>;
+	phy-handle = <&ethphy0>;
+	phy-mode = "rmii";
+	phy-reset-duration = <25>;
+	phy-reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
+	phy-reset-post-delay = <1>;
+	phy-supply = <&reg_3v3_etn>;
+	pinctrl-0 = <&pinctrl_fec1>, <&pinctrl_ethphy_rst>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			clocks = <&clk IMX8MM_CLK_ENET_REF>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-0 = <&pinctrl_ethphy_int>;
+			pinctrl-names = "default";
+			smsc,disable-energy-detect;
+		};
+	};
+};
+
+&gpio1 {
+	gpio-line-names = "SODIMM_152", "SODIMM_42", "SODIMM_153", "PMIC_IRQ_B",
+			  "SODIMM_154", "SODIMM_155", "SODIMM_156", "SODIMM_157",
+			  "SODIMM_158", "SODIMM_159", "SODIMM_161", "SODIMM_162",
+			  "SODIMM_34", "SODIMM_36", "SODIMM_27", "SODIMM_28",
+			  "", "", "", "",
+			  "", "", "", "ENET_POWER",
+			  "", "", "", "",
+			  "ENET_nINT", "ENET_nRST", "", "";
+};
+
+&gpio2 {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "SODIMM_51", "SODIMM_57", "SODIMM_56", "SODIMM_52",
+			  "SODIMM_53", "SODIMM_54", "SODIMM_55", "SODIMM_15",
+			  "SODIMM_45", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names = "SODIMM_103", "SODIMM_104", "SODIMM_105", "SODIMM_106",
+			  "SODIMM_107", "SODIMM_112", "SODIMM_108", "SODIMM_109",
+			  "SODIMM_95", "SODIMM_110", "SODIMM_96", "SODIMM_97",
+			  "SODIMM_98", "SODIMM_99", "SODIMM_113", "SODIMM_114",
+			  "SODIMM_115", "SODIMM_101", "SODIMM_100", "SODIMM_77",
+			  "SODIMM_72", "SODIMM_73", "SODIMM_74", "SODIMM_75",
+			  "SODIMM_76", "SODIMM_43", "", "",
+			  "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names = "SODIMM_178", "SODIMM_180", "SODIMM_184", "SODIMM_185",
+			  "SODIMM_186", "SODIMM_187", "SODIMM_188", "SODIMM_189",
+			  "SODIMM_190", "SODIMM_191", "SODIMM_179", "SODIMM_181",
+			  "SODIMM_192", "SODIMM_193", "SODIMM_194", "SODIMM_195",
+			  "SODIMM_196", "SODIMM_197", "SODIMM_198", "SODIMM_199",
+			  "SODIMM_182", "SODIMM_79", "SODIMM_78", "SODIMM_84",
+			  "SODIMM_87", "SODIMM_86", "SODIMM_85", "SODIMM_83",
+			  "SODIMM_81", "SODIMM_80", "SODIMM_90", "SODIMM_93";
+};
+
+&gpio5 {
+	gpio-line-names = "SODIMM_92", "SODIMM_91", "SODIMM_89", "SODIMM_144",
+			  "SODIMM_143", "SODIMM_146", "SODIMM_68", "SODIMM_67",
+			  "SODIMM_70", "SODIMM_69", "SODIMM_48", "SODIMM_46",
+			  "SODIMM_47", "SODIMM_44", "PMIC_SCL", "PMIC_SDA",
+			  "SODIMM_41", "SODIMM_40", "SODIMM_148", "SODIMM_149",
+			  "SODIMM_150", "SODIMM_151", "SODIMM_60", "SODIMM_59",
+			  "SODIMM_64", "SODIMM_63", "SODIMM_62", "SODIMM_61",
+			  "SODIMM_66", "SODIMM_65", "", "";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	pmic: pmic@4b {
+		compatible = "rohm,bd71847";
+		reg = <0x4b>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_pmic>;
+		pinctrl-names = "default";
+		rohm,reset-snvs-powered;
+
+		regulators {
+			BUCK1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <900000>;
+				regulator-min-microvolt = <780000>;
+				regulator-name = "buck1";
+				regulator-ramp-delay = <1250>;
+			};
+
+			reg_vdd_arm: BUCK2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <805000>;
+				regulator-name = "buck2";
+				regulator-ramp-delay = <1250>;
+				rohm,dvs-run-voltage = <950000>;
+				rohm,dvs-idle-voltage = <810000>;
+			};
+
+			BUCK3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <900000>;
+				regulator-min-microvolt = <805000>;
+				regulator-name = "buck3";
+			};
+
+			reg_vdd_3v3: BUCK4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "buck4";
+			};
+
+			reg_vdd_1v8: BUCK5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1950000>;
+				regulator-min-microvolt = <1700000>;
+				regulator-name = "buck5";
+			};
+
+			BUCK6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1349494>;
+				regulator-max-microvolt = <1349494>;
+				rohm,fb-pull-up-microvolt = <0>;
+				rohm,feedback-pull-up-r1-ohms = <2200>;
+				rohm,feedback-pull-up-r2-ohms = <499>;
+				regulator-name = "buck6";
+			};
+
+			LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1980000>;
+				regulator-min-microvolt = <1620000>;
+				regulator-name = "ldo1";
+			};
+
+			LDO2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <900000>;
+				regulator-min-microvolt = <760000>;
+				regulator-name = "ldo2";
+			};
+
+			LDO3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1890000>;
+				regulator-min-microvolt = <1710000>;
+				regulator-name = "ldo3";
+			};
+
+			LDO4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <855000>;
+				regulator-name = "ldo4";
+			};
+
+			LDO5 {
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "ldo5";
+			};
+
+			LDO6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1260000>;
+				regulator-min-microvolt = <1140000>;
+				regulator-name = "ldo6";
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_ethphy_int: etnphy-intgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_RD2_GPIO1_IO28
+				(MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_ethphy_rst: etnphy-rstgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_RD3_GPIO1_IO29
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC
+				(MX8MM_DSE_X4 | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO
+				(MX8MM_DSE_X4 | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_ENET_TD2_ENET1_TX_CLK
+				(MX8MM_FSEL_FAST | MX8MM_SION)
+			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0
+				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST)
+			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1
+				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST)
+			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0
+				(MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1
+				(MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_ENET_RXC_ENET1_RX_ER
+				MX8MM_FSEL_FAST
+			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL
+				MX8MM_FSEL_FAST
+			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL
+				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST)
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL
+				MX8MM_I2C_DEFAULT
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA
+				MX8MM_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14
+				MX8MM_I2C_DEFAULT
+			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15
+				MX8MM_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3
+				(MX8MM_PULL_UP | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_reg_3v3_etn: reg-3v3-etngrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_TXC_GPIO1_IO23
+				(MX8MM_DSE_X4 | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK
+				(MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD
+				MX8MM_USDHC_DATA_DEFAULT
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0
+				MX8MM_USDHC_DATA_DEFAULT
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1
+				MX8MM_USDHC_DATA_DEFAULT
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2
+				MX8MM_USDHC_DATA_DEFAULT
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3
+				MX8MM_USDHC_DATA_DEFAULT
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4
+				MX8MM_USDHC_DATA_DEFAULT
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5
+				MX8MM_USDHC_DATA_DEFAULT
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6
+				MX8MM_USDHC_DATA_DEFAULT
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7
+				MX8MM_USDHC_DATA_DEFAULT
+			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE
+				(MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B
+				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK
+				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE
+				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B
+				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK
+				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD
+				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0
+				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1
+				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2
+				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3
+				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4
+				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5
+				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6
+				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7
+				(MX8MM_DSE_X6 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE
+				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B
+				(MX8MM_DSE_X6 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+};
+
+&usdhc1 {
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC1>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	vmmc-supply = <&reg_vdd_3v3>;
+	vqmmc-supply = <&reg_vdd_1v8>;
+	status = "okay";
+};

-- 
2.51.2




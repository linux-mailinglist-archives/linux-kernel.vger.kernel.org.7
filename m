Return-Path: <linux-kernel+bounces-578758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB47A73616
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 16:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E88189A717
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD0621859A;
	Thu, 27 Mar 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAU+Mp8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA019DFA7;
	Thu, 27 Mar 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090759; cv=none; b=SXl62kDINUPJ5SsmNwH9IKK6QRDNpyyaWyiIhwQRLShzpDquTZB4PAWErtzLq86CJ63HNUxzSS//tEI4AHJx7jzqumhRq/2meiNbO4n6UBGwoawUmEIXGqqukj4TNSlCZX/Pz7qJryOiu6qi/uwFBfhFOAQRpOYvaFDjjt699aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090759; c=relaxed/simple;
	bh=hf+LTa4cPiIkXOE147WcGauPs8mw816HOZ12faXpxgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUCR0FQcp7/WMOwLDFkLULjBWbYnnEyUtWBUGwmFuKAF92woVg5u1AeKzjhSKPRDuLP8WNlkqc2sI6BF2y/M/++lqC49cphsiYrIPV2bSsZ0JomLBF5JNiejRq9ksKGqIDNcYxTYxp3ndQDVvvEZC07Esw5Rrw3gAYABpbw5R20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAU+Mp8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52DCCC4CEF4;
	Thu, 27 Mar 2025 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743090759;
	bh=hf+LTa4cPiIkXOE147WcGauPs8mw816HOZ12faXpxgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hAU+Mp8VKIBN0874ZbvhLVC5T2gWVHkL3xHdgllAN9DL+WGdQln2ysQmgkOnEY6D9
	 DPKI0b2ypSuuD1H8vkuGT0juxJyoPsh92Am2yvKPI9w0oDDz8Z99keX4LoJ8lXCCKx
	 nXbfY9e2unR0gm6kfA16veMfaacwY7TQQZd0gEKXHSyAH6AScjLl+ET8LJwBI9bwtq
	 ZTh04eCcf5BfqcW3BAsGUxsqEP7YaAnCn9Sj9BC735jeM9twZDFKMnxME6sUcVFMBC
	 DxKCFGnIuAX66PtMSz08tDWX2IBnAxzo1m62+VyjC3gpqM/K/vgZj8AJpq5d8VAkt6
	 WbPz2sU2lqFKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49046C36011;
	Thu, 27 Mar 2025 15:52:39 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 27 Mar 2025 16:52:40 +0100
Subject: [PATCH v3 5/8] arm64: dts: freescale: add Ka-Ro Electronics
 tx8p-ml81 COM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250327-initial_display-v3-5-4e89ea1676ab@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743090757; l=16023;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=6/4MC2HlxHuUt7vXFjtv43gHyOLPAnTiEY+dSNJgTjU=;
 b=TM0/4gX5j5+xIbs/GGAwscB3X9+N6baA5aw1C63UOWf4IeY9ehtOyss/VSplu4BxqjkQxYHiO
 lb8pTHd79+UATNN8JvgYIWcmEtr0XMsBmr9rBBkXkd/Th2qkmmXweIR
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

The Ka-Ro Electronics tx8p-ml81 is a COM based on the imx8mp SOC. It has
2 GB or ram and 8 GB of eMMC storage on board.

Add it to enable boards based on this Module

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 .../arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi | 549 +++++++++++++++++++++
 1 file changed, 549 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..9c4304e909b96afeb62962198da377319eda8506
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi
@@ -0,0 +1,549 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2020 Lothar Waßmann <LW@KARO-electronics.de>
+ * 2025 Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+#include "imx8mp.dtsi"
+
+/ {
+	/* PHY regulator */
+	regulator-3v3-etn {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_3v3_etn>;
+		regulator-name = "3v3-etn";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_vdd_3v3>;
+		gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
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
+
+&eqos {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
+	assigned-clocks = <&clk IMX8MP_CLK_ENET_AXI>,
+			  <&clk IMX8MP_CLK_ENET_QOS_TIMER>,
+			  <&clk IMX8MP_CLK_ENET_QOS>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
+				 <&clk IMX8MP_SYS_PLL2_100M>,
+				 <&clk IMX8MP_SYS_PLL2_50M>;
+	assigned-clock-rates = <0>, <100000000>, <50000000>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ethphy_rst_b>;
+		reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+		reset-delay-us = <25000>;
+
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ethphy_int_b>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
+			clocks = <&clk IMX8MP_CLK_ENET_QOS>;
+			smsc,disable-energy-detect;
+		};
+	};
+};
+
+&gpio1 {
+	gpio-line-names = "SODIMM_152",
+		"SODIMM_42",
+		"PMIC_WDOG_B SODIMM_153",
+		"PMIC_IRQ_B",
+		"SODIMM_154",
+		"SODIMM_155",
+		"SODIMM_156",
+		"SODIMM_157",
+		"SODIMM_158",
+		"SODIMM_159",
+		"SODIMM_161",
+		"SODIMM_162",
+		"SODIMM_34",
+		"SODIMM_36",
+		"SODIMM_27",
+		"SODIMM_28",
+		"ENET_MDC",
+		"ENET_MDIO",
+		"",
+		"ENET_XTAL1/CLKIN",
+		"ENET_TXD1",
+		"ENET_TXD0",
+		"ENET_TXEN",
+		"ENET_POWER",
+		"ENET_COL/CRS_DV",
+		"ENET_RXER",
+		"ENET_RXD0",
+		"ENET_RXD1",
+		"",
+		"",
+		"",
+		"";
+};
+
+&gpio2 {
+	gpio-line-names = "",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"SODIMM_51",
+		"SODIMM_57",
+		"SODIMM_56",
+		"SODIMM_52",
+		"SODIMM_53",
+		"SODIMM_54",
+		"SODIMM_55",
+		"SODIMM_15",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"";
+};
+
+&gpio3 {
+	gpio-line-names = "",
+		"",
+		"EMMC_DS",
+		"EMMC_DAT5",
+		"EMMC_DAT6",
+		"EMMC_DAT7",
+		"",
+		"",
+		"",
+		"",
+		"EMMC_DAT0",
+		"EMMC_DAT1",
+		"EMMC_DAT2",
+		"EMMC_DAT3",
+		"",
+		"EMMC_DAT4",
+		"",
+		"EMMC_CLK",
+		"EMMC_CMD",
+		"SODIMM_75",
+		"SODIMM_145",
+		"SODIMM_163",
+		"SODIMM_164",
+		"SODIMM_165",
+		"SODIMM_143",
+		"SODIMM_144",
+		"SODIMM_72",
+		"SODIMM_73",
+		"SODIMM_74",
+		"SODIMM_93",
+		"",
+		"";
+};
+
+&gpio4 {
+	gpio-line-names = "SODIMM_98",
+		"SODIMM_99",
+		"SODIMM_100",
+		"SODIMM_101",
+		"SODIMM_45",
+		"SODIMM_43",
+		"SODIMM_105",
+		"SODIMM_106",
+		"SODIMM_107",
+		"SODIMM_108",
+		"SODIMM_104",
+		"SODIMM_103",
+		"SODIMM_115",
+		"SODIMM_114",
+		"SODIMM_113",
+		"SODIMM_112",
+		"SODIMM_109",
+		"SODIMM_110",
+		"SODIMM_95",
+		"SODIMM_96",
+		"SODIMM_97",
+		"ENET_nINT",
+		"ENET_nRST",
+		"SODIMM_84",
+		"SODIMM_87",
+		"SODIMM_86",
+		"SODIMM_85",
+		"SODIMM_83",
+		"",
+		"SODIMM_66",
+		"SODIMM_65",
+		"";
+};
+
+&gpio5 {
+	gpio-line-names = "",
+		"",
+		"",
+		"SODIMM_76",
+		"SODIMM_81",
+		"SODIMM_146",
+		"SODIMM_48",
+		"SODIMM_46",
+		"SODIMM_47",
+		"SODIMM_44",
+		"SODIMM_49",
+		"",
+		"SODIMM_70",
+		"SODIMM_69",
+		"PMIC_SCL",
+		"PMIC_SDA",
+		"SODIMM_41",
+		"SODIMM_40",
+		"SODIMM_148",
+		"SODIMM_149",
+		"SODIMM_150",
+		"SODIMM_151",
+		"SODIMM_60",
+		"SODIMM_59",
+		"SODIMM_64",
+		"SODIMM_63",
+		"SODIMM_62",
+		"SODIMM_61",
+		"SODIMM_68",
+		"SODIMM_67",
+		"",
+		"";
+};
+
+&i2c1 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	pmic@25 {
+		reg = <0x25>;
+		compatible = "nxp,pca9450c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			reg_vdd_soc: BUCK1 {
+				regulator-name = "vdd-soc";
+				regulator-min-microvolt = <805000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			reg_vdd_arm: BUCK2 {
+				regulator-name = "vdd-core";
+				regulator-min-microvolt = <805000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			reg_vdd_3v3: BUCK4 {
+				regulator-name = "3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_nand: BUCK5 {
+				regulator-name = "nvcc-nand";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_dram: BUCK6 {
+				regulator-name = "nvcc-dram";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_snvs_1v8: LDO1 {
+				regulator-name = "snvs-1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-always-on;
+			};
+
+			reg_vdda_1v8: LDO3 {
+				regulator-name = "vdda-1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo5_reg: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&usdhc3 { /* eMMC */
+	max-frequency = <200000000>;
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
+	assigned-clock-rates = <200000000>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <8>;
+	vmmc-supply = <&reg_vdd_3v3>;
+	vqmmc-supply = <&reg_nvcc_nand>;
+	voltage-ranges = <3300 3300>;
+	non-removable;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_TD2__CCM_ENET_QOS_CLOCK_GENERATE_REF_CLK
+			(MX8MP_DSE_X4 | MX8MP_PULL_UP | MX8MP_PULL_ENABLE | MX8MP_SION)
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC
+			(MX8MP_DSE_X4 | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO
+			(MX8MP_DSE_X4 | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST)
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST)
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_RXC__ENET_QOS_RX_ER
+			(MX8MP_FSEL_FAST | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST)
+		>;
+	};
+
+	pinctrl_eqos_sleep: eqos-sleep-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_TD2__GPIO1_IO19
+			(MX8MP_ODE_ENABLE | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_MDC__GPIO1_IO16
+			(MX8MP_ODE_ENABLE | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_MDIO__GPIO1_IO17
+			(MX8MP_ODE_ENABLE | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_TD0__GPIO1_IO21
+			(MX8MP_ODE_ENABLE | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_TD1__GPIO1_IO20
+			(MX8MP_ODE_ENABLE | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_RD0__GPIO1_IO26
+			(MX8MP_ODE_ENABLE | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_RD1__GPIO1_IO27
+			(MX8MP_ODE_ENABLE | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_RXC__GPIO1_IO25
+			(MX8MP_ODE_ENABLE | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_RX_CTL__GPIO1_IO24
+			(MX8MP_ODE_ENABLE | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_ENET_TX_CTL__GPIO1_IO22
+			(MX8MP_ODE_ENABLE | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_ethphy_int_b: ethphy-int-bgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21
+			(MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_ethphy_rst_b: ethphy-rst-bgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15
+			(MX8MP_DSE_X6 | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE | MX8MP_SION)
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03
+			(MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_reg_3v3_etn: reg-3v3-etngrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_TXC__GPIO1_IO23
+			(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK
+			(MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7
+			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE
+			(MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE
+			(MX8MP_DSE_X2 | MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE
+			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_HYS_SCHMITT | MX8MP_PULL_ENABLE)
+		>;
+	};
+};

-- 
2.49.0




Return-Path: <linux-kernel+bounces-846635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B59BC89C3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A0143520BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566B72E03F2;
	Thu,  9 Oct 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7+1aLcN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2E2DE6FC;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007261; cv=none; b=ta3oF4waRJSjvJZBTYJy8oLQj1ZbnvhVwYoHWy7Qw//tRv9PuhhoMiy0X3Ry5RM51UMXMNw1rSLFiYkeMYV8vXj+wNMd12xImxYFEyxe1KX8Sqm8CaFCUyV49OXULPgfxlDOVVN/+cksfiRao5y3VfjLZl90SmQYS0pIwer9ibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007261; c=relaxed/simple;
	bh=9MM/UZ4L2wsqN4A7R9/XNM5qY3KWuRiCCtPnwmfK+1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TeV6CCscQvGPjoG99RWBk7VzIRnTFXftMjGg5VmjQ91mgg4xwTVsfMrQoB8sQJKKKN2YH7uVEHbUSNF5nyCCcSUwOA6zea1q8Nh4BgR5eX8itkVYVvglDqP1cuVuprOSSRGVapnPehFPiOsJt3QkZhGYakIQrF/6wzD+EIYFaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7+1aLcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5382C116D0;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760007260;
	bh=9MM/UZ4L2wsqN4A7R9/XNM5qY3KWuRiCCtPnwmfK+1Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j7+1aLcNi8UgysyEbZoltZ4DV5b33RslRruhr16OaQIe1CqcABQRChuEiDSA0dseR
	 dW84F/iISufuhLyALkt3PhlWG9McuXzYdZUDCZnqqiYLMPdHuBeIk8OPqMw2lyENNU
	 RgD5oJ5/thCgZulcG5WAjKhiHzNpokWrynAn7JfBR580CR3sSZR1ezMd7nFLjKv1fi
	 MCb8XjHA3MciWwFuAZ4R9pa/7mmILNF6mA7NDpAg6msuN/RRdi2zlP4t2EuhlvzU8k
	 NVzV8l5coqEKWhNIWiNbKa/Yl77A52ji6GYhW9Swi2gPh/wV94Atjsr4Elk7fL22Kh
	 zCaCHR6Bz4GRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9332CCD18C;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 09 Oct 2025 12:54:19 +0200
Subject: [PATCH 3/5] arm64: dts: freescale: add Ka-Ro Electronics tx8m-1610
 COM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-mini_iv-v1-3-f3889c492457@gocontroll.com>
References: <20251009-mini_iv-v1-0-f3889c492457@gocontroll.com>
In-Reply-To: <20251009-mini_iv-v1-0-f3889c492457@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760007259; l=14868;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=CKLOQaO6unaE+E83cje9uohVXRu3Eil4/Ut+dV8Brcg=;
 b=dysHhe9AomvYhCagprW+9Rq2zmox5WR0oNewEuZSPyyRS3gUWp7mXACPQb/wG9LNQhQoRPJPx
 EXZSUlyKqIjASOGj2dA53zRVWYxWXpQFu6gd2uYLHoKOGWpjn0VEp8N
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
 .../arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi | 562 +++++++++++++++++++++
 1 file changed, 562 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
new file mode 100644
index 0000000000000..6ed86b10c4310
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 Lothar Waßmann <LW@KARO-electronics.de>
+ * 2025 Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+#include "imx8mm.dtsi"
+
+/ {
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
+		vin-supply = <&reg_vdd_3v3>;
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
+	<&clk IMX8MM_CLK_ENET_TIMER>,
+	<&clk IMX8MM_CLK_ENET_REF>,
+	<&clk IMX8MM_CLK_ENET_REF>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
+	<&clk IMX8MM_SYS_PLL2_100M>,
+	<&clk IMX8MM_SYS_PLL2_50M>,
+	<&clk IMX8MM_SYS_PLL2_50M>;
+	assigned-clock-rates = <0>, <100000000>, <50000000>, <50000000>;
+	clocks = <&clk IMX8MM_CLK_ENET1_ROOT>,
+		 <&clk IMX8MM_CLK_ENET1_ROOT>,
+		 <&clk IMX8MM_CLK_ENET_TIMER>,
+		 <&clk IMX8MM_CLK_ENET_REF>;
+	phy-handle = <&ethphy0>;
+	phy-mode = "rmii";
+	phy-supply = <&reg_3v3_etn>;
+	pinctrl-0 = <&pinctrl_fec1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pinctrl_ethphy_rst>;
+		pinctrl-names = "default";
+		reset-delay-us = <25000>;
+		reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
+		reset-post-delay-us = <100>;
+
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			clocks = <&clk IMX8MM_CLK_ENET_REF>;
+			smsc,disable-energy-detect;
+		};
+	};
+};
+
+&gpio1 {
+	gpio-line-names = "SODIMM_152",
+			  "SODIMM_42",
+			  "SODIMM_153",
+			  "PMIC_IRQ_B",
+			  "SODIMM_154",
+			  "SODIMM_155",
+			  "SODIMM_156",
+			  "SODIMM_157",
+			  "SODIMM_158",
+			  "SODIMM_159",
+			  "SODIMM_161",
+			  "SODIMM_162",
+			  "SODIMM_34",
+			  "SODIMM_36",
+			  "SODIMM_27",
+			  "SODIMM_28",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "ENET_POWER",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "ENET_nINT",
+			  "ENET_nRST",
+			  "",
+			  "";
+};
+
+&gpio2 {
+	gpio-line-names = "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_51",
+			  "SODIMM_57",
+			  "SODIMM_56",
+			  "SODIMM_52",
+			  "SODIMM_53",
+			  "SODIMM_54",
+			  "SODIMM_55",
+			  "SODIMM_15",
+			  "SODIMM_45",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "";
+};
+
+&gpio3 {
+	gpio-line-names = "SODIMM_103",
+			  "SODIMM_104",
+			  "SODIMM_105",
+			  "SODIMM_106",
+			  "SODIMM_107",
+			  "SODIMM_112",
+			  "SODIMM_108",
+			  "SODIMM_109",
+			  "SODIMM_95",
+			  "SODIMM_110",
+			  "SODIMM_96",
+			  "SODIMM_97",
+			  "SODIMM_98",
+			  "SODIMM_99",
+			  "SODIMM_113",
+			  "SODIMM_114",
+			  "SODIMM_115",
+			  "SODIMM_101",
+			  "SODIMM_100",
+			  "SODIMM_77",
+			  "SODIMM_72",
+			  "SODIMM_73",
+			  "SODIMM_74",
+			  "SODIMM_75",
+			  "SODIMM_76",
+			  "SODIMM_43",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "";
+};
+
+&gpio4 {
+	gpio-line-names = "SODIMM_178",
+			  "SODIMM_180",
+			  "SODIMM_184",
+			  "SODIMM_185",
+			  "SODIMM_186",
+			  "SODIMM_187",
+			  "SODIMM_188",
+			  "SODIMM_189",
+			  "SODIMM_190",
+			  "SODIMM_191",
+			  "SODIMM_179",
+			  "SODIMM_181",
+			  "SODIMM_192",
+			  "SODIMM_193",
+			  "SODIMM_194",
+			  "SODIMM_195",
+			  "SODIMM_196",
+			  "SODIMM_197",
+			  "SODIMM_198",
+			  "SODIMM_199",
+			  "SODIMM_182",
+			  "SODIMM_79",
+			  "SODIMM_78",
+			  "SODIMM_84",
+			  "SODIMM_87",
+			  "SODIMM_86",
+			  "SODIMM_85",
+			  "SODIMM_83",
+			  "SODIMM_81",
+			  "SODIMM_80",
+			  "SODIMM_90",
+			  "SODIMM_93";
+};
+
+&gpio5 {
+	gpio-line-names = "SODIMM_92",
+			  "SODIMM_91",
+			  "SODIMM_89",
+			  "SODIMM_144",
+			  "SODIMM_143",
+			  "SODIMM_146",
+			  "SODIMM_68",
+			  "SODIMM_67",
+			  "SODIMM_70",
+			  "SODIMM_69",
+			  "SODIMM_48",
+			  "SODIMM_46",
+			  "SODIMM_47",
+			  "SODIMM_44",
+			  "PMIC_SCL",
+			  "PMIC_SDA",
+			  "SODIMM_41",
+			  "SODIMM_40",
+			  "SODIMM_148",
+			  "SODIMM_149",
+			  "SODIMM_150",
+			  "SODIMM_151",
+			  "SODIMM_60",
+			  "SODIMM_59",
+			  "SODIMM_64",
+			  "SODIMM_63",
+			  "SODIMM_62",
+			  "SODIMM_61",
+			  "SODIMM_66",
+			  "SODIMM_65",
+			  "",
+			  "";
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
+			reg_vdd_soc: BUCK1 {
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
+			reg_vdd_dram: BUCK3 {
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
+				/*
+				 * The default output voltage is 1.1V, bumped
+				 * to 1.35V in HW by a 499R/2.2K voltage divider in the
+				 * feedback path.
+				 */
+				regulator-max-microvolt = <1100000>;
+				regulator-min-microvolt = <1100000>;
+				regulator-name = "buck6";
+			};
+
+			reg_snvs_1v8: LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1980000>;
+				regulator-min-microvolt = <1620000>;
+				regulator-name = "ldo1";
+			};
+
+			reg_snvs_0v8: LDO2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <900000>;
+				regulator-min-microvolt = <760000>;
+				regulator-name = "ldo2";
+			};
+
+			reg_vdda_1v8: LDO3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1890000>;
+				regulator-min-microvolt = <1710000>;
+				regulator-name = "ldo3";
+			};
+
+			reg_vdd_phy_0v9: LDO4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <855000>;
+				regulator-name = "ldo4";
+			};
+
+			ldo5_reg: LDO5 {
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "ldo5";
+			};
+
+			reg_vdd_phy_1v2: LDO6 {
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
2.51.0




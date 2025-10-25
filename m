Return-Path: <linux-kernel+bounces-869836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6FC08D48
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2E33BB62C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5DF2D592D;
	Sat, 25 Oct 2025 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="KaKR063j"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089AC3BB4A;
	Sat, 25 Oct 2025 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761376747; cv=none; b=JJR+OAxBoJESjyH2PbwXWnpXabke4RKCn4m6db/aRPsC7Jeuclf+X1sjG3M3JTEYhHVHruRj1EJjkXprYnU1hJKgdqg2xdF1kfqGbEzKCbEjgQXijN+Tfko2Ln8lcsrj1NslrhO7jTUptGxg/TwYv7fE6OoQA4O+H+1u10An3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761376747; c=relaxed/simple;
	bh=Fj6df5XxMk5WoEXy1kyB2bsby4rQd0pD0LDLRt4nIw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aogv6Sw2ScNIM9pfauivqpsRL8vASpiSsyGSItC5Q/Re1wXuVlnBfTRLHHWhtdcE1HxDHmNxwFjwoUuh8+OzFcXgMgo7YOMAtcTaJK7/i+LpzwqDnzC35VcNq9QznkjG9racNP6VarhYKtwRDLZfj3m3vbzQ9s/coYQSQ3oN/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=KaKR063j; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=MwX/s5SYASd0iKGYB0XTDuYgCV0T6REyfugcDNoJpbI=;
	b=KaKR063j3AwQa7jCa9q37XeA7OL63ew6l7t+cOFjS/WOFhuLOIxqZAS330KkUu
	1yR7rAZ1g+1kz4pqma48zs6maL39Yydt2b4aPzlIthM03mb7VqfLIIy9CcVBeuGB
	8Dn0exz3iX88KX6YMABw84bCwLafcY2+ALWBQvBsqO/VU=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3BzBHefxoBGWeAA--.50533S3;
	Sat, 25 Oct 2025 15:16:25 +0800 (CST)
Date: Sat, 25 Oct 2025 15:16:22 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Rogerio Pimentel <rpimentel.silva@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, xiaofeng.wei@nxp.com,
	kernel@pengutronix.de, festevam@gmail.com,
	alexander.stein@ew.tq-group.com,
	dario.binacchi@amarulasolutions.com, marex@denx.de,
	Markus.Niebel@tq-group.com, y.moog@phytec.de,
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de,
	josua@solid-run.com, francesco.dolcini@toradex.com,
	primoz.fiser@norik.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
Message-ID: <aPx5RpFeqWmmhQs5@dragon>
References: <20250922232523.844633-1-rpimentel.silva@gmail.com>
 <20250922232523.844633-2-rpimentel.silva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922232523.844633-2-rpimentel.silva@gmail.com>
X-CM-TRANSID:Ms8vCgD3BzBHefxoBGWeAA--.50533S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3try8XF4fZw43ZF1fCF13twb_yoWkCF4Upr
	9xJrsrCw4vkr1Syas3J3W7Krn8Xa95G3Wq9w1DuFy8AF9rAasIqrn0krn8GrsrJrs8Z3y8
	uFWjvryI9FnIgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbVysUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIAnJL2j8eUkYHwAA3s

On Mon, Sep 22, 2025 at 07:25:23PM -0400, Rogerio Pimentel wrote:
> The FRDM-i.MX8MP is an NXP development platform based on the i.MX8M Plus
> SoC, featuring a quad Cortex-A53, Cortex-M7 co-processor, 4GB LPDDR4,
> 32GB eMMC, Wi-Fi 6/Bluetooth 5.4/802.15.4 tri-radio, Ethernet, HDMI/MIPI
> display interfaces, camera connectors, and standard expansion headers.
> 
> Based on the device tree found in the NXP repository at github
> https://github.com/nxp-imx-support/meta-imx-frdm and on imx8mp-evk
> board kernel mainline device tree.
> 
> This is a basic device tree supporting:
> 
>  - Quad Cortex-A53
>  - 4GB LPDDR4 DRAM
>  - PCA9450C PMIC with regulators
>  - Two NXP PCAL6416 GPIO expanders
>  - RGB LEDs via GPIO expander
>  - I2C1, I2C2, I2C3 controllers
>  - UART2 (console) and UART3 (with RTS/CTS)
>  - USDHC3 (8-bit eMMC)
>  - SNVS power key (onboard power button)
> 
> Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>
> Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> 
> ---
> 
> Changes in v3:
> 
>  - Removing the following tags and names added
>  on v2 by mistake: 
>  Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
>  Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>  Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> 
> Changes in v2:
> 
>  - Fixed dt-binding schema warnings
>  - Renamed nodes 'red, green and blue' to
>    'led-0, led-1 and led-2'
>  - Renamed led labels 'led-0, led-1 and led-2'
>    to 'red, green and blue'
>  - Added Reviewed-by and Signed-off-by tags
>  
>  
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  arch/arm64/boot/dts/freescale/imx8mp-frdm.dts | 355 ++++++++++++++++++
>  2 files changed, 356 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-frdm.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 525ef180481d..d861e576779a 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -206,6 +206,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-picoitx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-edm-g-wb.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-frdm.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-mate.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pro.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pulse.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-frdm.dts b/arch/arm64/boot/dts/freescale/imx8mp-frdm.dts
> new file mode 100644
> index 000000000000..9138c65739aa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-frdm.dts
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2019 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp.dtsi"
> +
> +/ {
> +	model = "NXP i.MX8MPlus FRDM board";
> +	compatible = "fsl,imx8mp-frdm", "fsl,imx8mp";
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			label = "red";
> +			gpios = <&pcal6416 13 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		led-1 {
> +			label = "green";
> +			gpios = <&pcal6416 14 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +
> +		led-2 {
> +			label = "blue";
> +			gpios = <&pcal6416 15 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0 0xc0000000>,
> +		      <0x1 0x00000000 0 0x40000000>;
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic@25 {

Please sort I2C devices in order of slave address?

> +		compatible = "nxp,pca9450c";
> +		reg = <0x25>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +
> +		regulators {
> +			BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <720000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			reg_arm: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <720000>;
> +				regulator-max-microvolt = <1025000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +			};
> +
> +			BUCK4 {
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_buck5: BUCK5 {
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1045000>;
> +				regulator-max-microvolt = <1155000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <1710000>;
> +				regulator-max-microvolt = <1890000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	pcal6416: gpio@20 {
> +		compatible = "nxp,pcal6416";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcal6416_int>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names = "CSI1_nRST",
> +			"CSI2_nRST",
> +			"DSI_CTP_RST",
> +			"EXT_PWREN1",
> +			"CAN_STBY",
> +			"EXP_P0_5",
> +			"EXP_P0_6",
> +			"P0_7",
> +			"LVDS0_BLT_EN",
> +			"LVDS1_BLT_EN",
> +			"LVDS0_CTP_RST",
> +			"LVDS1_CTP_RST",
> +			"SPK_PWREN",
> +			"RLED_GPIO",
> +			"GLED_GPIO",
> +			"BLED_GPIO";
> +	};
> +
> +	pcal6416_1: gpio@21 {

Would it be better to label these two pcal6416 devices as

	pcal6416_1
	pcal6416_2

or
	pcal6416_0
	pcal6416_1
?

Shawn

> +		compatible = "nxp,pcal6416";
> +		reg = <0x21>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcal6416_1_int>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names = "P0_0",
> +			"P0_1",
> +			"AUD_nINT",
> +			"RTC_nINTA",
> +			"USB1_SS_SEL",
> +			"USB2_PWR_EN",
> +			"SPI_EXP_SEL",
> +			"P0_7",
> +			"W2_HOST_WAKE_SD_3V3",
> +			"W2_HOST_WAKE_BT_3V3",
> +			"EXP_WIFI_BT_PDN_3V3",
> +			"EXP_BT_RST_3V3",
> +			"W2_RST_IND_3V3",
> +			"SPI_nINT_3V3",
> +			"KEYM_PCIE_nWAKE",
> +			"P1_7";
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +};
> +
> +&snvs_pwrkey {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
> +	assigned-clock-rates = <400000000>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL	0x400001c2
> +			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA	0x400001c2
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL	0x400001c2
> +			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA	0x400001c2
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL	0x400001c2
> +			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA	0x400001c2
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x000001c0
> +		>;
> +	};
> +
> +	pinctrl_pcal6416_int: pcal6416_int_grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x146
> +		>;
> +	};
> +
> +	pinctrl_pcal6416_1_int: pcal6416_1_int_grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11	0x146
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
> +			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX	0x140
> +			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX	0x140
> +			MX8MP_IOMUXC_ECSPI1_SS0__UART3_DCE_RTS	0x140
> +			MX8MP_IOMUXC_ECSPI1_MISO__UART3_DCE_CTS	0x140
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
> +		>;
> +	};
> +};
> -- 
> 2.25.1
> 



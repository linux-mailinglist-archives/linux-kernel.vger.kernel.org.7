Return-Path: <linux-kernel+bounces-799626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21364B42E43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA4B54E4745
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C928195808;
	Thu,  4 Sep 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BV1mGANI"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68E502BE;
	Thu,  4 Sep 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945952; cv=none; b=BhiZuUk+4ihcDF1WBTaa26kBARz5+lDSxjvK7Zq6bs4YghF42bGBD8PJctCeJlCalgfT0dWg3gUsNItkIoeOeSsLm78fPfv9TDJy4ERudGISOi0t/pj5pAAhBP9rDdqI1ddDcEGw6z38OQi5DOlPRYkqkoCbfo/7pPDv1yhKODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945952; c=relaxed/simple;
	bh=15RAin8RVr5DtSvOY/l5KZ0IMWckIsT8XC7ASlQvY8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eAu7NCeSHZEZPYZ9A3LGbkCsrPjEWsW99KIeVN0KrtUSD9aY7eScjgA3BqEVPmyw/VAkG76I58U2PayyvQe7oIX96L6FdzbKsdOgCiHvNx8d5fOU+boGf+1V6F8p7MudHdkPOkXKTwIAlTmAifz3l17d67c95Ua5/7ezpVEf3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BV1mGANI; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5840WMDZ3384193;
	Wed, 3 Sep 2025 19:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756945942;
	bh=jZ2dwryEpAaqKx6NOKXsLAFfc6Z2UHCkJYqUcHeCaVw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BV1mGANIIFvmVrVz/4aXs8qDORheVZ+jTFFihUTIKmgGF++9xucaryxSmSl+gStNv
	 f4209rcCWyLq9LGUEnsgpPBzzS/qyT6B0HduqCbzvo+Iu9tp3xJ8Y2P2oxwVE7MPAB
	 4bgcQgfvVwaS6Ihk/pkeknjjLM3UuP5xuVesR0IE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5840WM0X467869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 19:32:22 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 19:32:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 19:32:22 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5840WM2f2121193;
	Wed, 3 Sep 2025 19:32:22 -0500
Message-ID: <4c4e1619-51e9-468d-931b-82796bcf7142@ti.com>
Date: Wed, 3 Sep 2025 19:32:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64: dts: ti: var-som-am62p: Add support for
 Variscite Symphony Board
To: Stefano Radaelli <stefano.radaelli21@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250829165327.20007-1-stefano.radaelli21@gmail.com>
 <20250829165327.20007-4-stefano.radaelli21@gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250829165327.20007-4-stefano.radaelli21@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Stefano,

On 8/29/25 11:53 AM, Stefano Radaelli wrote:
> Add device tree support for the Variscite Symphony carrier board with
> the VAR-SOM-AM62P system on module.
> 
> The Symphony board includes
> - uSD Card support
> - USB ports and OTG
> - Additional Gigabit Ethernet interface
> - Uart interfaces
> - OV5640 Camera support
> - GPIO Expander
> - CAN, I2C and general purpose interfaces
> 
> Link: https://www.variscite.it/product/single-board-computers/symphony-board/
> 
> Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
> ---
> v5:
>   - Update to match up with coding guidelines for device tree
> v4:
>   - Moved every MCUs-related node into the SOM dtsi
> v3:
>   - Change compatible string to match existing mainline format
>   - Fixed underscore typo
> v2:
>   - Fixed warnings and cleanup
> 
>   arch/arm64/boot/dts/ti/Makefile               |   1 +
>   .../dts/ti/k3-am62p5-var-som-symphony.dts     | 500 ++++++++++++++++++
>   2 files changed, 501 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index aad9177930e6..b11cbf33422d 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -38,6 +38,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62d2-evm.dtb
>   
>   # Boards with AM62Px SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am62p5-var-som-symphony.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-dahlia.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-dev.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-ivy.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts b/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
> new file mode 100644
> index 000000000000..76c8dd31616c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Variscite Symphony carrier board for VAR-SOM-AM62P
> + *
> + * Link: https://www.variscite.it/product/single-board-computers/symphony-board/
> + *
> + * Copyright (C) 2025 Variscite Ltd. - https://www.variscite.com/
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am62p5-var-som.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-AM62P on Symphony-Board";
> +	compatible = "variscite,var-som-am62p-symphony", "variscite,var-som-am62p", "ti,am62p5";
> +
> +	aliases {
> +		ethernet0 = &cpsw_port1;
> +		ethernet1 = &cpsw_port2;
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
> +		mmc2 = &sdhci2;
> +		serial0 = &main_uart0;
> +		serial2 = &main_uart2;
> +		serial5 = &main_uart5;
> +		serial6 = &main_uart6;
> +		spi5 = &main_spi2;
> +		usb0 = &usb0;
> +		usb1 = &usb1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	clk_ov5640_fixed: clock-24000000 {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		button-back {
> +			label = "Back";
> +			linux,code = <KEY_BACK>;
> +			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		button-home {
> +			label = "Home";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		button-menu {
> +			label = "Menu";
> +			linux,code = <KEY_MENU>;
> +			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		led-heartbeat {
> +			label = "Heartbeat";
> +			linux,default-trigger = "heartbeat";
> +			gpios = <&pca9534 0 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	reg_2p8v: regulator-2p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "2P8V";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		vin-supply = <&reg_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1P8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&reg_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	reg_1p5v: regulator-1p5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1P5V";
> +		regulator-min-microvolt = <1500000>;
> +		regulator-max-microvolt = <1500000>;
> +		vin-supply = <&reg_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	reg_sdhc1_vmmc: regulator-sdhc1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "+V3.3_SD";
> +		vin-supply = <&reg_sdhc1_vmmc_int>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio = <&main_gpio0 30 GPIO_ACTIVE_HIGH>;
> +		bootph-all;
> +	};
> +
> +	reg_sdhc1_vmmc_int: regulator-sdhc1-int {
> +		compatible = "regulator-fixed";
> +		regulator-name = "+V3.3_SD_INT";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sd1_vmmc>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio = <&main_gpio0 53 GPIO_ACTIVE_HIGH>;
> +		bootph-all;
> +	};
> +
> +	reg_sdhc1_vqmmc: regulator-sdhci1-vqmmc {
> +		compatible = "regulator-gpio";
> +		regulator-name = "+V3.3_SD_VQMMC";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sd1_vqmmc>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		gpios = <&main_gpio0 56 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +		bootph-all;
> +	};
> +
> +	reg_ov5640_buf_en: regulator-camera-buf-en {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ov5640_buf_en";
> +		gpios = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	transceiver1: can-phy {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +
> +	connector {
> +		compatible = "gpio-usb-b-connector", "usb-b-connector";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_extcon>;
> +		label = "USB-C";
> +		id-gpios = <&main_gpio1 12 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +
> +		port {
> +			usb_con_hs: endpoint {
> +				remote-endpoint = <&typec_hs>;
> +			};
> +		};
> +	};
> +};
> +
> +&cdns_csi2rx0 {
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		csi0_port0: port@0 {
> +			reg = <0>;
> +			status = "okay";
> +
> +			csi2rx0_in_sensor: endpoint {
> +				remote-endpoint = <&csi2_cam0>;
> +				bus-type = <4>; /* CSI2 DPHY. */
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1>,
> +		    <&pinctrl_rgmii2>;
> +	status = "okay";
> +};
> +
> +&cpsw3g_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mdio1>;
> +	status = "okay";
> +
> +	cpsw3g_phy1: ethernet-phy@5 {
> +		compatible = "ethernet-phy-id0283.bc30";
> +		reg = <5>;
> +		reset-gpios = <&pca9534 5 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <100000>;
> +	};
> +};
> +
> +&cpsw_port2 {
> +	/*
> +	 * The required RGMII TX and RX 2ns delays are implemented directly
> +	 * in hardware via passive delay elements on the Symphony PCB.
> +	 * No delay configuration is needed in software via PHY driver.
> +	 */
> +	phy-mode = "rgmii";
> +	phy-handle = <&cpsw3g_phy1>;
> +	status = "okay";
> +};
> +
> +&dphy0 {
> +	status = "okay";
> +};
> +
> +&main_i2c0{
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c0>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	ov5640: camera@3c {
> +		compatible = "ovti,ov5640";
> +		reg = <0x3c>;
> +		clocks = <&clk_ov5640_fixed>;
> +		clock-names = "xclk";
> +		AVDD-supply = <&reg_2p8v>;
> +		DOVDD-supply = <&reg_1p8v>;
> +		DVDD-supply = <&reg_1p5v>;
> +		powerdown-gpios = <&main_gpio0 10 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ov5640>;
> +
> +		port {
> +			csi2_cam0: endpoint {
> +				remote-endpoint = <&csi2rx0_in_sensor>;
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +
> +	/* GPIO expander */
> +	pca9534: gpio@20 {
> +		compatible = "nxp,pca9534";
> +		reg = <0x20>;
> +		gpio-controller;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pca9534>;
> +		interrupt-parent = <&main_gpio1>;
> +		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
> +		#gpio-cells = <2>;
> +		status = "okay";
> +
> +		usb3-sel-hog {
> +			gpio-hog;
> +			gpios = <4 0>;
> +			output-low;
> +			line-name = "usb3_sel";
> +		};
> +
> +		eth-som-vselect-hog {
> +			gpio-hog;
> +			gpios = <6 0>;
> +			output-low;
> +			line-name = "eth-vselect";
> +		};
> +
> +		eth-mdio-enable-hog {
> +			gpio-hog;
> +			gpios = <7 0>;
> +			output-high;
> +			line-name = "eth-mdio-enable";
> +		};
> +	};
> +};
> +
> +&main_i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	rtc@68 {
> +		compatible = "dallas,ds1337";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&main_mcan0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mcan0>;
> +	phys = <&transceiver1>;
> +	status = "okay";
> +};
> +
> +&main_pmx0 {
> +	pinctrl_extcon: main-extcon-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01a8, PIN_INPUT, 7) /* (F25) MCASP0_AFSX.GPIO1_12 */
> +		>;
> +	};
> +
> +	pinctrl_i2c0: main-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (B25) I2C0_SCL */
> +			AM62PX_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (A24) I2C0_SDA */
> +		>;
> +	};
> +
> +	pinctrl_i2c1: main-i2c1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (C24) I2C1_SCL */
> +			AM62PX_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (B24) I2C1_SDA */
> +		>;
> +		bootph-all;
> +	};
> +
> +	pinctrl_mcan0: main-mcan0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01dc, PIN_INPUT, 0) /* (F20) MCAN0_RX */
> +			AM62PX_IOPAD(0x01d8, PIN_OUTPUT, 0) /* (B23) MCAN0_TX */
> +		>;
> +	};
> +
> +	pinctrl_mmc1: main-mmc1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x023c, PIN_INPUT, 0) /* (H20) MMC1_CMD */
> +			AM62PX_IOPAD(0x0234, PIN_OUTPUT, 0) /* (J24) MMC1_CLK */
> +			AM62PX_IOPAD(0x0230, PIN_INPUT, 0) /* (H21) MMC1_DAT0 */
> +			AM62PX_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H23) MMC1_DAT1 */
> +			AM62PX_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (H22) MMC1_DAT2 */
> +			AM62PX_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */

If you have external pulls, perhaps its a good idea to drop the internal
pulls? So as to not risk violating the minimum spec requirement.

~ Judith



> +			AM62PX_IOPAD(0x0240, PIN_INPUT, 0) /* (D23) MMC1_SDCD */
> +		>;
> +		bootph-all;
> +	};
> +
> +	pinctrl_rgmii2: main-rgmii2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0184, PIN_INPUT, 0) /* (E19) RGMII2_RD0 */
> +			AM62PX_IOPAD(0x0188, PIN_INPUT, 0) /* (E16) RGMII2_RD1 */
> +			AM62PX_IOPAD(0x018c, PIN_INPUT, 0) /* (E17) RGMII2_RD2 */
> +			AM62PX_IOPAD(0x0190, PIN_INPUT, 0) /* (C19) RGMII2_RD3 */
> +			AM62PX_IOPAD(0x0180, PIN_INPUT, 0) /* (D19) RGMII2_RXC */
> +			AM62PX_IOPAD(0x017c, PIN_INPUT, 0) /* (F19) RGMII2_RX_CTL */
> +			AM62PX_IOPAD(0x016c, PIN_INPUT, 0) /* (B19) RGMII2_TD0 */
> +			AM62PX_IOPAD(0x0170, PIN_INPUT, 0) /* (A21) RGMII2_TD1 */
> +			AM62PX_IOPAD(0x0174, PIN_INPUT, 0) /* (D17) RGMII2_TD2 */
> +			AM62PX_IOPAD(0x0178, PIN_INPUT, 0) /* (A19) RGMII2_TD3 */
> +			AM62PX_IOPAD(0x0168, PIN_INPUT_PULLDOWN, 0) /* (D16) RGMII2_TXC */
> +			AM62PX_IOPAD(0x0164, PIN_INPUT, 0) /* (A20) RGMII2_TX_CTL */
> +		>;
> +	};
> +
> +	pinctrl_spi2: main-spi2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01b0, PIN_INPUT, 1) /* (G20) MCASP0_ACLKR.SPI2_CLK */
> +			AM62PX_IOPAD(0x0194, PIN_OUTPUT, 1) /* (D25) MCASP0_AXR3.SPI2_D0 */
> +			AM62PX_IOPAD(0x0198, PIN_INPUT, 1) /* (E25) MCASP0_AXR2.SPI2_D1 */
> +			AM62PX_IOPAD(0x01ac, PIN_OUTPUT, 7) /* (G23) MCASP0_AFSR.GPIO1_13 */
> +		>;
> +	};
> +
> +	pinctrl_uart0: main-uart0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x1c8, PIN_INPUT, 0)	/* (A22) UART0_RXD */
> +			AM62PX_IOPAD(0x1cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
> +		>;
> +		bootph-all;
> +	};
> +
> +	pinctrl_uart2: main-uart2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x005c, PIN_INPUT_PULLUP, 2) /* (AC25) GPMC0_AD8.UART2_RXD */
> +			AM62PX_IOPAD(0x0060, PIN_OUTPUT, 2) /* (AB25) GPMC0_AD9.UART2_TXD */
> +		>;
> +	};
> +
> +	pinctrl_uart6: main-uart6-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x009c, PIN_INPUT_PULLUP, 3) /* (AD24) GPMC0_WAIT1.UART6_RXD */
> +			AM62PX_IOPAD(0x0244, PIN_OUTPUT, 1) /* (D24) MMC1_SDWP.UART6_TXD */
> +		>;
> +	};
> +
> +	pinctrl_usb1: main-usb1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0258, PIN_OUTPUT, 0) /* (G21) USB1_DRVVBUS */
> +		>;
> +	};
> +
> +	pinctrl_ov5640: main-ov5640-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0028, PIN_OUTPUT, 7) /* (N20) OSPI0_D7.GPIO0_10 */
> +			AM62PX_IOPAD(0x0054, PIN_OUTPUT, 7) /* (V24) GPMC0_AD6.GPIO0_21 */
> +			AM62PX_IOPAD(0x0058, PIN_OUTPUT, 7) /* (W25) GPMC0_AD7.GPIO0_22 */
> +		>;
> +	};
> +
> +	pinctrl_pca9534: main-pca9534-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01f0, PIN_INPUT, 7) /* (C25) EXT_REFCLK1.GPIO1_30 */
> +		>;
> +	};
> +
> +	pinctrl_sd1_vmmc: main-sd1-vmmc-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0078, PIN_OUTPUT, 7) /* (AC24) GPMC0_AD15.GPIO0_30 */
> +			AM62PX_IOPAD(0x00d8, PIN_OUTPUT, 7) /* (AE22) VOUT0_DATA8.GPIO0_53 */
> +		>;
> +		bootph-all;
> +	};
> +
> +	pinctrl_sd1_vqmmc: main-sd1-vqmmc-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x00e4, PIN_OUTPUT, 7) /* (AE21) VOUT0_DATA11.GPIO0_56 */
> +		>;
> +		bootph-all;
> +	};
> +};
> +
> +&main_spi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi2>;
> +	ti,pindir-d0-out-d1-in;
> +	cs-gpios = <&main_gpio1 13 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&main_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart0>;
> +	status = "okay";
> +};
> +
> +&main_uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&main_uart6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart6>;
> +	status = "okay";
> +};
> +
> +&sdhci1 {
> +	/* SD Card */
> +	vmmc-supply = <&reg_sdhc1_vmmc>;
> +	vqmmc-supply = <&reg_sdhc1_vqmmc>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mmc1>;
> +	disable-wp;
> +	bootph-all;
> +	status="okay";
> +};
> +
> +&ti_csi2rx0 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	usb-role-switch;
> +	status = "okay";
> +
> +	port {
> +		typec_hs: endpoint {
> +			remote-endpoint = <&usb_con_hs>;
> +		};
> +	};
> +};
> +
> +&usb1 {
> +	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb1>;
> +	status = "okay";
> +};
> +
> +&usbss0 {
> +	status = "okay";
> +};
> +
> +&usbss1 {
> +	status = "okay";
> +};



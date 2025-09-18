Return-Path: <linux-kernel+bounces-799623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12268B42E34
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30D016FABA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA6165F13;
	Thu,  4 Sep 2025 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L7QwvIEq"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5F9476;
	Thu,  4 Sep 2025 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945781; cv=none; b=MTXXmQYRqBPdT+z8RhV6QFL8GRAxvTB3GemkktWcgIUDjU18OG2ea/i2VXdU8Slbd+NXHfucUqmGDJN3A3yzcyIVdO9am7Sg0nY2/3QShrRki5MtfmnRn4/SbSa3v4Dlm00CFtx3hqWUaYKe5D3P7EhPgBAu5Gzz+LHIkLWWO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945781; c=relaxed/simple;
	bh=aFSJtQdqfi5zNqHe/6BDFwojpfXn/rEAC6VuIMKg9Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sh5AtyZwNsCpQ6eEVplJuNkImXvsY1gjSkFIM0IZBDwJX5CroypoWVmeq14gRX74ivK4jzQMFdZG+lDn6yuOXZqTzxPVG70Mfs1vHses/3tPha0OlYoM8/OX5W7yo59HTVG5EXVeOX+8vLbKiIcozslF1GDp/5oTfT6qVRWnNfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L7QwvIEq; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5840TUKo3345571;
	Wed, 3 Sep 2025 19:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756945770;
	bh=iSZo4WKOdFxKYGhY7tUHJE8semIladyMFt+cZNxLLM8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=L7QwvIEqwNQAM/qFxXTPgJYA//7VqhYVubhIEil+BBuSAPMZsfTaIffQA6xv9Cizu
	 fsAX3lmw6XiQf9QZgbJbvPUSJl0e22nXjsiXDlhQ5E9rl1WQwO8lZ4DrQ1j1iSawfx
	 XThUvqz9W3DE2Z1mzy9eZYbK+id7zs6ncDD8qU9o=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5840TTZa465567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 19:29:30 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 19:29:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 19:29:29 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5840TTdU2403508;
	Wed, 3 Sep 2025 19:29:29 -0500
Message-ID: <9b65bac7-716e-416d-a8e3-04b955edfae9@ti.com>
Date: Wed, 3 Sep 2025 19:29:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: ti: Add support for Variscite
 VAR-SOM-AM62P
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
 <20250829165327.20007-3-stefano.radaelli21@gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250829165327.20007-3-stefano.radaelli21@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Stefano,

On 8/29/25 11:53 AM, Stefano Radaelli wrote:
> Add device tree support for the Variscite VAR-SOM-AM62P system on module.
> This SOM is designed to be used with various carrier boards.
> 
> The module includes:
> - AM62P Sitara MPU processor
> - Up to 8GB of DDR4-3733 memory
> - eMMC storage memory
> - PS6522430 chip as a Power Management Integrated circuit (PMIC)
> - Integrated 10/100/1000 Mbps Ethernet Transceiver Analog Devices ADIN1300
> - Resistive touch panel interface controller TI TSC2046
> - I2C interfaces
> 
> Only SOM-specific peripherals are enabled by default. Carrier board
> specific interfaces are left disabled to be enabled in the respective
> carrier board device trees.
> 
> Link: https://www.variscite.it/product/system-on-module-som/cortex-a53-krait/var-som-am62p-ti-sitara-am62px/
> 
> Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
> ---
> v5:
>   - Update to match up with coding guidelines for device tree
> v4:
>   - Moved every MCUs-related node into the SOM dtsi
>   - Removed unused audio node
> v3:
>   - Change compatible string to match existing mainline format
>   - Lower case hex digits
>   - Generic node names
> v2:
>   - Fixed warnings and cleanup
> 
>   arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 387 ++++++++++++++++++
>   1 file changed, 387 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> new file mode 100644
> index 000000000000..46fdf8d242b3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> @@ -0,0 +1,387 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common dtsi for Variscite VAR-SOM-AM62P
> + *
> + * Link: https://www.variscite.com/product/system-on-module-som/cortex-a53-krait/var-som-am62p-ti-sitara-am62px/
> + *
> + * Copyright (C) 2025 Variscite Ltd. - https://www.variscite.com/
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include "k3-am62p5.dtsi"
> +
> +/ {
> +	compatible = "variscite,var-som-am62p", "ti,am62p5";
> +
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		post-power-on-delay-ms = <100>;
> +		power-off-delay-us = <10000>;
> +		reset-gpios = <&main_gpio0 54 GPIO_ACTIVE_LOW>,	/* WIFI_PWR_EN */
> +			      <&main_gpio0 59 GPIO_ACTIVE_LOW>;	/* WIFI_EN */
> +	};
> +
> +	mmc_pwrseq: mmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_mmc_pwrseq>;
> +		reset-gpios = <&main_gpio0 49 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	memory@80000000 {
> +		/* 8G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> +		      <0x00000008 0x80000000 0x00000001 0x80000000>;
> +		device_type = "memory";
> +		bootph-pre-ram;
> +	};
> +
> +	opp-table {
> +		/* Add 1.4GHz OPP for am62p5-sk board. Requires VDD_CORE at 0v85 */
> +		opp-1400000000 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			opp-supported-hw = <0x01 0x0004>;
> +			clock-latency-ns = <6000000>;
> +		};
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		rtos_ipc_memory_region: rtos-ipc-memory@9b500000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9b500000 0x00 0x00300000>;
> +			no-map;
> +		};
> +
> +		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9b800000 0x00 0x00100000>;
> +			no-map;
> +		};
> +
> +		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9b900000 0x00 0x00f00000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9c800000 0x00 0x00100000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9c900000 0x00 0x01e00000>;
> +			no-map;
> +		};
> +
> +		secure_tfa_ddr: tfa@9e780000 {
> +			reg = <0x00 0x9e780000 0x00 0x80000>;
> +			no-map;
> +		};
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			no-map;
> +		};
> +	};
> +
> +	reg_3v3: regulator-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "On-module +V3.3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_1v8: regulator-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "On-module +V1.8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&reg_3v3>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_3v3_phy: regulator-3v3-phy {
> +		compatible = "regulator-fixed";
> +		regulator-name = "On-module +V3.3_PHY";
> +		gpios = <&main_gpio0 45 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +};
> +
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1>;
> +};
> +
> +&cpsw3g_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mdio1>;
> +	status = "okay";
> +
> +	cpsw3g_phy0: ethernet-phy@4 {
> +		compatible = "ethernet-phy-id0283.bc30";
> +		reg = <4>;
> +		reset-gpios = <&main_gpio0 46 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <100000>;
> +	};
> +};
> +
> +&cpsw_port1 {
> +	/*
> +	 * The required RGMII TX and RX 2ns delays are implemented directly
> +	 * in hardware via passive delay elements on the SOM PCB.
> +	 * No delay configuration is needed in software via PHY driver.
> +	 */
> +	phy-mode = "rgmii";
> +	phy-handle = <&cpsw3g_phy0>;
> +	status = "okay";
> +};
> +
> +&main_i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&main_i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&main_pmx0 {
> +	pinctrl_mmc_pwrseq: main-emmc-pwrseq-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x00c8, PIN_OUTPUT, 7) /* (AB23) VOUT0_DATA4.GPIO0_49 */
> +		>;
> +	};
> +
> +	pinctrl_i2c2: main-i2c2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (T22) GPMC0_CSn2.I2C2_SCL */
> +			AM62PX_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (U25) GPMC0_CSn3.I2C2_SDA */
> +		>;
> +	};
> +
> +	pinctrl_i2c3: main-i2c3-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A23) UART0_CTSn.I2C3_SCL */
> +			AM62PX_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (C22) UART0_RTSn.I2C3_SDA */
> +		>;
> +	};
> +
> +	pinctrl_mdio1: main-mdio1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
> +			AM62PX_IOPAD(0x015c, PIN_INPUT, 0) /* (F16) MDIO0_MDIO */
> +		>;
> +	};
> +
> +	pinctrl_mmc2: main-mmc2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0120, PIN_INPUT_PULLUP, 0) /* (K24) MMC2_CMD */
> +			AM62PX_IOPAD(0x0118, PIN_INPUT_PULLDOWN, 0) /* (K21) MMC2_CLK */
> +			AM62PX_IOPAD(0x011c, PIN_INPUT_PULLUP, 0) /* () MMC2_CLKLB */
> +			AM62PX_IOPAD(0x0114, PIN_INPUT_PULLUP, 0) /* (K23) MMC2_DAT0 */
> +			AM62PX_IOPAD(0x0110, PIN_INPUT_PULLUP, 0) /* (K22) MMC2_DAT1 */
> +			AM62PX_IOPAD(0x010c, PIN_INPUT_PULLUP, 0) /* (L20) MMC2_DAT2 */
> +			AM62PX_IOPAD(0x0108, PIN_INPUT_PULLUP, 0) /* (L21) MMC2_DAT3 */
> +		>;
> +	};
> +
> +	pinctrl_rgmii1: main-rgmii1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x014c, PIN_INPUT, 0) /* (B15) RGMII1_RD0 */
> +			AM62PX_IOPAD(0x0150, PIN_INPUT, 0) /* (B16) RGMII1_RD1 */
> +			AM62PX_IOPAD(0x0154, PIN_INPUT, 0) /* (A14) RGMII1_RD2 */
> +			AM62PX_IOPAD(0x0158, PIN_INPUT, 0) /* (B14) RGMII1_RD3 */
> +			AM62PX_IOPAD(0x0148, PIN_INPUT, 0) /* (A16) RGMII1_RXC */
> +			AM62PX_IOPAD(0x0144, PIN_INPUT, 0) /* (A15) RGMII1_RX_CTL */
> +			AM62PX_IOPAD(0x0134, PIN_INPUT, 0) /* (A18) RGMII1_TD0 */
> +			AM62PX_IOPAD(0x0138, PIN_INPUT, 0) /* (C17) RGMII1_TD1 */
> +			AM62PX_IOPAD(0x013c, PIN_INPUT, 0) /* (A17) RGMII1_TD2 */
> +			AM62PX_IOPAD(0x0140, PIN_INPUT, 0) /* (C16) RGMII1_TD3 */
> +			AM62PX_IOPAD(0x0130, PIN_INPUT, 0) /* (B17) RGMII1_TXC */
> +			AM62PX_IOPAD(0x012c, PIN_INPUT, 0) /* (B18) RGMII1_TX_CTL */
> +		>;
> +		bootph-all;
> +	};
> +
> +	pinctrl_spi0: main-spi0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (B21) SPI0_CLK */
> +			AM62PX_IOPAD(0x01b4, PIN_OUTPUT, 0) /* (D20) SPI0_CS0 */
> +			AM62PX_IOPAD(0x01c0, PIN_OUTPUT, 0) /* (B20) SPI0_D0 */
> +			AM62PX_IOPAD(0x01c4, PIN_INPUT, 0) /* (C21) SPI0_D1 */
> +		>;
> +	};
> +
> +	pinctrl_uart5: main-uart5-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x00ec, PIN_INPUT, 4) /* (AC21) VOUT0_DATA13.UART5_CTSn */
> +			AM62PX_IOPAD(0x00e8, PIN_OUTPUT, 4) /* (AD21) VOUT0_DATA12.UART5_RTSn */
> +			AM62PX_IOPAD(0x00d0, PIN_INPUT, 4) /* (AC23) VOUT0_DATA6.UART5_RXD */
> +			AM62PX_IOPAD(0x00d4, PIN_OUTPUT, 4) /* (AE23) VOUT0_DATA7.UART5_TXD */
> +		>;
> +	};
> +
> +	pinctrl_bt: main-btgrp-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x00f4, PIN_OUTPUT, 7) /* (Y20) VOUT0_DATA15.GPIO0_60 (BT_EN) */
> +		>;
> +	};
> +
> +	pinctrl_restouch: main-restouch-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x00c4, PIN_INPUT_PULLUP, 7) /* (Y23) VOUT0_DATA3.GPIO0_48 */
> +		>;
> +	};
> +
> +	pinctrl_wifi: main-wifi-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x00dc, PIN_OUTPUT, 7) /* (AC22) VOUT0_DATA9.GPIO0_54 - WIFI_PWR_EN - */
> +			AM62PX_IOPAD(0x00f0, PIN_OUTPUT, 7) /* (AA20) VOUT0_DATA14.GPIO0_59 - WIFI_EN - */
> +		>;
> +	};
> +};
> +
> +&mcu_pmx0 {
> +	pinctrl_wkup_clkout0: wkup-clkout0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_MCU_IOPAD(0x0084, PIN_OUTPUT, 0) /* (F13) WKUP_CLKOUT0 */
> +		>;
> +	};
> +};
> +
> +&main_spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi0>;
> +	ti,pindir-d0-out-d1-in;
> +	status = "okay";
> +};
> +
> +&main_uart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>, <&pinctrl_bt>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "nxp,88w8987-bt";
> +	};
> +};
> +
> +&sdhci0 {
> +	ti,driver-strength-ohm = <50>;
> +	mmc-pwrseq = <&mmc_pwrseq>;
> +	disable-wp;

This is not really needed right? Since the property is not used with
eMMC or SDIO device.

> +	bootph-all;
> +	status = "okay";
> +};
> +
> +&sdhci2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mmc2>, <&pinctrl_wifi>;
> +	bus-width = <4>;
> +	disable-wp;

Same comment here

> +	non-removable;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	ti,fails-without-test-cd;
> +	status = "okay";
> +};
> +
> +&usbss0 {
> +	ti,vbus-divider;
> +};
> +
> +&usbss1 {
> +	ti,vbus-divider;
> +};
> +
> +&mailbox0_cluster0 {
> +	status = "okay";
> +
> +	mbox_r5_0: mbox-r5-0 {
> +		ti,mbox-rx = <0 0 0>;
> +		ti,mbox-tx = <1 0 0>;
> +	};
> +};
> +
> +&mailbox0_cluster1 {
> +	status = "okay";
> +
> +	mbox_mcu_r5_0: mbox-mcu-r5-0 {
> +		ti,mbox-rx = <0 0 0>;
> +		ti,mbox-tx = <1 0 0>;
> +	};
> +};
> +
> +&mcu_r5fss0 {
> +	status = "okay";
> +};
> +
> +&mcu_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
> +	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> +			<&mcu_r5fss0_core0_memory_region>;
> +};
> +
> +&wkup_r5fss0 {
> +	status = "okay";
> +};
> +
> +&wkup_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
> +	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> +			<&wkup_r5fss0_core0_memory_region>;
> +};
> +
> +/* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
> +&mcu_gpio0 {
> +	status = "reserved";
> +};
> +
> +&mcu_gpio_intr {
> +	status = "reserved";
> +};
> +
> +&wkup_rtc0 {
> +	status = "disabled";
> +};
> +
> +&wkup_rti0 {
> +	/* WKUP RTI0 is used by DM firmware */
> +	status = "reserved";
> +};
> +
> +&wkup_uart0 {
> +	/* WKUP UART0 is used by DM firmware */
> +	status = "reserved";
> +};
> +
> +&main_uart1 {
> +	/* Main UART1 is used by TIFS firmware */
> +	status = "reserved";
> +};



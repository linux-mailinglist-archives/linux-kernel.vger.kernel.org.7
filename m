Return-Path: <linux-kernel+bounces-766775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A024DB24AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC3F165596
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B032EA49B;
	Wed, 13 Aug 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l4RB3NRw"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823A2A8C1;
	Wed, 13 Aug 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092638; cv=none; b=W6SY49wUnROrj4QX+lXAbEotBc4lKDmK4Qc3l0c0wAl/aPq+B2z2vnpNWt6vidzP+Eb+0LXWbrWUEVCC4LGXgbKYeafn9x9MMBX8Vpmj4kErCFu91m20W+TmWCzOddauR0gr6mH1jCHlRa0+sT0ZXiOGSw+fpISlF6l+SDcmLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092638; c=relaxed/simple;
	bh=2szuhK3e5YrXLWJEA2Q9G+kp9wVZw+oAhUbFUQDFwXM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjGdtIngAlWP+wwpCB2C9lPj7Bz0X1ZTX3k+TorgAOJGpgxBytm2xIY6gH4xp8xfJz+TpG1AFYkzFn2ezbPWScHjkE/Dem4xsOEdoE0X2dXtIKK/b4mwLWttrI0wvVXrGxgYgBgwagEs6+R8NybsQw/QztfjmzV7FrLMVXwkCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l4RB3NRw; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DDhlk81709691;
	Wed, 13 Aug 2025 08:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755092627;
	bh=5oWkkSzvP8gm8v9+kLB6DzRHYImOIXHSxltOc96ZVhw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=l4RB3NRwwfDL51ZKCns7amrY1l+if04W/WF7cUHLI92hqpwqBffyXVJWFsfLfmrzG
	 0AONFJl0d3z0sABG0qtlYKRKCcCxkmtQD18UbsaO/tN461u31wy7+5e5V3nbM6ZHL7
	 W9Gb5U9fABBa7fg9ar6YulmWPG4ohsj8tHVhHdi4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DDhlsW1111824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 08:43:47 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 08:43:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 08:43:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DDhlik2377645;
	Wed, 13 Aug 2025 08:43:47 -0500
Date: Wed, 13 Aug 2025 08:43:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] arm64: dts: ti: Add support for Variscite
 VAR-SOM-AM62P
Message-ID: <20250813134347.6dmoniycumnzuezy@implosion>
References: <20250711140507.17574-1-stefano.radaelli21@gmail.com>
 <20250711140507.17574-3-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250711140507.17574-3-stefano.radaelli21@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:04-20250711, Stefano Radaelli wrote:
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

Could you update to match up with coding guidelines for device tree?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

I see a few ones below that I tagged.

> v4:
>  - Moved every MCUs-related node into the SOM dtsi
>  - Removed unused audio node
> v3:
>  - Change compatible string to match existing mainline format
>  - Lower case hex digits
>  - Generic node names
> v2:
>  - Fixed warnings and cleanup
> 
>  arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 408 ++++++++++++++++++
>  1 file changed, 408 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> new file mode 100644
> index 000000000000..9c8046111701
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> @@ -0,0 +1,408 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common dtsi for Variscite VAR-SOM-AM62P

Please add the link to the SoM here, I think it is
https://www.variscite.com/product/system-on-module-som/cortex-a53-krait/var-som-am62p-ti-sitara-am62px/

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
> +		status="okay";


Why status = "okay"  - default is okay.

> +	};
> +};
> +
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1>;
> +};
> +
> +&cpsw3g_mdio {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mdio1>;
Please move status here
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

Please add an EoL here

> +	cpsw3g_phy0: ethernet-phy@4 {
> +		reg = <4>;
> +		compatible = "ethernet-phy-id0283.bc30";

reg after compatible
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

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
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi0>;
> +	ti,pindir-d0-out-d1-in;

Status here
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

> +
> +	touchscreen@0 {
> +		compatible = "ti,ads7846";

Do you have the touch screen controller on the SoM? Typically they tend
to be on the display panel, no? If that is the case, you might want to
do an overlay for the display panel and add the touchscreen there.

> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_restouch>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <48 IRQ_TYPE_EDGE_FALLING>;
> +		spi-max-frequency = <1500000>;
> +		pendown-gpio = <&main_gpio0 48 GPIO_ACTIVE_LOW>;
> +		ti,x-min = /bits/ 16 <125>;
> +		ti,x-max = /bits/ 16 <4008>;
> +		ti,y-min = /bits/ 16 <282>;
> +		ti,y-max = /bits/ 16 <3864>;
> +		ti,x-plate-ohms = /bits/ 16 <180>;
> +		ti,pressure-max = /bits/ 16 <255>;
> +		ti,debounce-max = /bits/ 16 <10>;
> +		ti,debounce-tol = /bits/ 16 <3>;
> +		ti,debounce-rep = /bits/ 16 <1>;
> +		ti,settle-delay-usec = /bits/ 16 <150>;
> +		ti,keep-vref-on;
> +		wakeup-source;

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

> +	};
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
> +	status = "okay";
> +	ti,driver-strength-ohm = <50>;
> +	mmc-pwrseq = <&mmc_pwrseq>;
> +	disable-wp;
> +	bootph-all;
> +};
> +
> +&sdhci2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mmc2>, <&pinctrl_wifi>;
> +	bus-width = <4>;
> +	disable-wp;
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
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


Return-Path: <linux-kernel+bounces-598681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0FCA84962
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CA87B1C35
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90F91EDA12;
	Thu, 10 Apr 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VojcS6o3"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450C1E3DFE;
	Thu, 10 Apr 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301724; cv=none; b=T0C+84gaor2bg9yE6y6zkwy1eygRlut7AphiCzuxphriS7SD8E283ymZdDb/t+HYsMPwMBEBUGTLVDG53YrQwdT2EHugQqkhF22jBuRxDtxmAfeFCOWlyqQ8G7y6gn4Pkbfs2PT58+BZ/gVDOBToX98TKW4MFYs3EGTEtHoAkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301724; c=relaxed/simple;
	bh=lG/a6p85gew00QmBACjy+P4lYLNJGfB40yD24PBcldY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYh4r8go2AsNB5z18d2kRBBNt3F/6SxGf+WisSU76zyGxToi7LfcmtROVBswkqtNTBdfcOX9J3hdnGi7IBRbMiZW5d5WcdpfJtdLT9V1c5ZTN5sk9WNsQMuQoYzPRO0IYs1T5ZaHgLHUC2s0A0GVDifvfue6+6uvSZAlW09NHe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VojcS6o3; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53AGF9xc1327252
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 11:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744301710;
	bh=4aQkHnP8GOpOouNt/avQKqNEzSGojCfIjF4EyK5xups=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=VojcS6o3h82b0dOJ2uB4U0sCNK8afRo1TBUJbKd4SMo+OIitw9B0foNbGCLh6JOMv
	 +NKcr2BR9iRCabw26hwopsLxg/gygL1Sxh9wA2zT2N7qUkQzr3rxjGJavlQl1MNvJD
	 bCr2tXVjKZtcyp9VOBK9/O4ultfx2LqAZf5r+yJM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53AGF963028224
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Apr 2025 11:15:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 11:15:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 11:15:09 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53AGF9qc039474;
	Thu, 10 Apr 2025 11:15:09 -0500
Date: Thu, 10 Apr 2025 11:15:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, Judith Mendez
	<jm@ti.com>,
        Andrei Aldea <a-aldea@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Deepak Khatri
	<lorforlinux@beagleboard.org>,
        Ayush Singh <ayush@beagleboard.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: Add k3-am62-pocketbeagle2
Message-ID: <20250410161509.yviucf36uhox4wvm@unedited>
References: <20250408231823.826163-1-robertcnelson@gmail.com>
 <20250408231823.826163-2-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250408231823.826163-2-robertcnelson@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 18:18-20250408, Robert Nelson wrote:
> BeagleBoard.org PocketBeagle 2 is an upgraded version of the popular
> PocketBeagle.  It is based on Texas Instruments AM6232 or AM6254 SoC.
> Its dual or quad A53 cores can provide higher performance than classic
> PocketBeagle. The new design comes with pre-soldered headers, a 3-pin
> JST-SH 1.00mm UART debug port, a USB-C port, Texas Instruments
> MSPM0L1105 Cortex-M0+ MCU for ADC, 512MB RAM, and a LiPo Battery charger.
> 
> https://www.beagleboard.org/boards/pocketbeagle-2
> https://openbeagle.org/pocketbeagle/pocketbeagle-2
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Andrew Davis <afd@ti.com>
> CC: Roger Quadros <rogerq@kernel.org>
> CC: Siddharth Vadapalli <s-vadapalli@ti.com>
> CC: Judith Mendez <jm@ti.com>
> CC: Andrei Aldea <a-aldea@ti.com>
> CC: Dhruva Gole <d-gole@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> CC: Ayush Singh <ayush@beagleboard.org>
> ---
> Changes since v1:
>  - fix '_' in main-i2c2-default-pins
>  - aliases i2c match original pocketbeagle
>  - add mcu_m4fss with reseved memory and mailbox
>  - drop unused main_gpio0_pins_default pinmux
>  - drop unused main_gpio1_pins_default pinmux
>  - drop unused main_spi2_pins_gpio pinmux
>  - Reserve 128MiB of global CMA
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  .../boot/dts/ti/k3-am62-pocketbeagle2.dts     | 528 ++++++++++++++++++
>  2 files changed, 529 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 03d4cecfc001..4f8fcb69a2c1 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am62x-phyboard-lyra-gpio-fan.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-nand.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-am62-pocketbeagle2.dtb
>  
>  # Boards with AM62Ax SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> new file mode 100644
> index 000000000000..65000ed8196f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> @@ -0,0 +1,528 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * https://www.beagleboard.org/boards/pocketbeagle-2
> + *
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2025 Robert Nelson, BeagleBoard.org Foundation
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "k3-am625.dtsi"
> +
> +/ {
> +	compatible = "beagle,am62-pocketbeagle2", "ti,am625";
> +	model = "BeagleBoard.org PocketBeagle2";
> +
> +	aliases {
> +		serial0 = &wkup_uart0;
> +		serial1 = &main_uart1;
> +		serial2 = &main_uart6;
> +		serial3 = &main_uart3;
> +		serial4 = &main_uart4;
> +		serial5 = &main_uart5;
> +		serial6 = &main_uart2;
> +		serial7 = &main_uart0;


We just seem to have 3 uarts pinned out. so why alias the rest? those
seem unused?

> +		mmc0 = &sdhci0;
Same - unused?
> +		mmc1 = &sdhci1;
> +		usb0 = &usb0;
> +		usb1 = &usb1;
> +		i2c1 = &main_i2c1;

same - unused?

> +		i2c2 = &main_i2c2;
> +		i2c3 = &wkup_i2c0;
> +	};
> +
> +	chosen {
> +		stdout-path = &main_uart6;
> +	};
> +
> +	memory@80000000 {
> +		/* 512MB RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x20000000>;
> +		device_type = "memory";
> +		bootph-pre-ram;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* global cma region */
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x00 0x8000000>;
> +			linux,cma-default;
> +		};
> +
> +		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9cb00000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9cc00000 0x00 0xe00000>;
> +			no-map;
> +		};
> +
> +		secure_tfa_ddr: tfa@9e780000 {
> +			reg = <0x00 0x9e780000 0x00 0x80000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9db00000 0x00 0xc00000>;
> +			no-map;
> +		};
> +	};
> +
> +	vsys_5v0: regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		bootph-all;
> +	};
> +
> +	vdd_3v3: regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vsys_5v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		bootph-all;
> +	};
> +
> +	vdd_mmc1: regulator-3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_3v3_sd_pins_default>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		regulator-always-on;
> +		vin-supply = <&vdd_3v3>;
> +		gpio = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;
> +		bootph-all;
> +	};
> +
> +	vdd_sd_dv: regulator-4 {
> +		compatible = "regulator-gpio";
> +		regulator-name = "sd_hs200_switch";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vdd_3v3>;
> +		gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +		bootph-all;
> +	};
> +
> +	adc_vref: regulator-5 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "default";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +	};
> +
> +	leds {
> +		bootph-all;
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_default>;
bootph-all here?
Please check Documentation/devicetree/bindings/dts-coding-style.rst

1. "compatible"
2. "reg"
3. "ranges"
4. Standard/common properties (defined by common bindings, e.g. without
   vendor-prefixes)

^^ bootph property last one here.

5. Vendor-specific properties
6. "status" (if applicable)
7. Child nodes, where each node is preceded with a blank line

Could you make sure that all the nodes follow the convention?

> +
> +		led-1 {
> +			bootph-all;
> +			gpios = <&main_gpio0 6 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			linux,default-trigger = "heartbeat";
> +			function = LED_FUNCTION_HEARTBEAT;
> +			default-state = "on";
Same
> +		};
> +
> +		led-2 {
> +			bootph-all;
> +			gpios = <&main_gpio0 5 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DISK_ACTIVITY;
> +			linux,default-trigger = "mmc1";
> +		};
> +
> +		led-3 {
> +			bootph-all;
> +			gpios = <&main_gpio0 4 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led-4 {
> +			bootph-all;
> +			gpios = <&main_gpio0 3 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_INDICATOR;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&main_pmx0 {
> +	led_pins_default: led-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x000c, PIN_OUTPUT, 7) /* (E25) OSPI0_D0.GPIO0_3 */
> +			AM62X_IOPAD(0x0010, PIN_OUTPUT, 7) /* (G24) OSPI0_D1.GPIO0_4 */
> +			AM62X_IOPAD(0x0014, PIN_OUTPUT, 7) /* (F25) OSPI0_D2.GPIO0_5 */
> +			AM62X_IOPAD(0x0018, PIN_OUTPUT, 7) /* (F24) OSPI0_D3.GPIO0_6 */
> +		>;
> +		bootph-all;
> +	};
> +
> +	main_i2c0_pins_default: main-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
> +			AM62X_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
> +		>;
> +		bootph-all;
> +	};
> +
> +	main_i2c2_pins_default: main-i2c2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (K22) GPMC0_CSn2.I2C2_SCL */
> +			AM62X_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */
> +		>;
> +		bootph-all;
> +	};
> +
> +	main_uart0_pins_default: main-uart0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
> +			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
> +		>;
> +		bootph-all;
> +	};
> +
> +	main_uart1_pins_default: main-uart1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19/B18) MCASP0_AXR3.UART1_CTSn */
> +			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19/B17) MCASP0_AXR2.UART1_RTSn */
> +			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19/D15) MCASP0_AFSR.UART1_RXD */
> +			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20/D16) MCASP0_ACLKR.UART1_TXD */
> +		>;
> +		bootph-all;
> +	};
> +
> +	main_uart6_pins_default: main-uart6-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x001c, PIN_INPUT, 3) /* (J23) OSPI0_D4.UART6_RXD */
> +			AM62X_IOPAD(0x0020, PIN_OUTPUT, 3) /* (J25) OSPI0_D5.UART6_TXD */
> +		>;
> +	};
> +
> +	main_mmc1_pins_default: main-mmc1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x23c, PIN_INPUT, 0) /* (A21/C18) MMC1_CMD */
> +			AM62X_IOPAD(0x234, PIN_INPUT, 0) /* (B22/A20) MMC1_CLK */
> +			AM62X_IOPAD(0x230, PIN_INPUT, 0) /* (A22/A19) MMC1_DAT0 */
> +			AM62X_IOPAD(0x22c, PIN_INPUT, 0) /* (B21/B19) MMC1_DAT1 */
> +			AM62X_IOPAD(0x228, PIN_INPUT, 0) /* (C21/B20) MMC1_DAT2 */
> +			AM62X_IOPAD(0x224, PIN_INPUT, 0) /* (D22/C19) MMC1_DAT3 */
> +			AM62X_IOPAD(0x240, PIN_INPUT, 7) /* (D17/C15) MMC1_SDCD.GPIO1_48 */
> +		>;
> +		bootph-all;
> +	};
> +
> +	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0244, PIN_OUTPUT, 7) /* (P25) GPMC0_CLK.GPIO1_49 */
> +		>;
> +		bootph-all;
> +	};
> +
> +	pmic_irq_pins_default: pmic-irq-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x01f4, PIN_INPUT_PULLUP, 0) /* (D16) EXTINTn */
> +		>;
> +		bootph-all;
> +	};
> +
> +	vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0000, PIN_OUTPUT, 7) /* (H24) OSPI0_CLK.GPIO0_0 */
> +		>;
> +		bootph-all;
> +	};
> +
> +	usb1_pins_default: usb1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0258, PIN_INPUT, 0) /* (F18) USB1_DRVVBUS */
> +		>;
> +		bootph-all;
> +	};
> +
> +	epwm2_pins_default: epwm2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x01e8, PIN_OUTPUT, 8) /* (B17) I2C1_SCL.EHRPWM2_A */
> +		>;
> +	};
> +};
> +
> +&cpsw3g {
> +	status = "disabled";
> +};

This should have been disabled at am62-main.dtsi level (like it was done
in j784s4) - lets fix that then apply the pb2 without these disabled
nodes.
> +
> +&cpsw_port1 {
> +	status = "disabled";
> +};
> +
> +&cpsw_port2 {
> +	status = "disabled";
> +};
> +
> +&epwm2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&epwm2_pins_default>;
> +};
> +
> +&mailbox0_cluster0 {
> +	mbox_m4_0: mbox-m4-0 {
> +		ti,mbox-rx = <0 0 0>;
> +		ti,mbox-tx = <1 0 0>;
> +	};
> +};
> +
> +&main_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
> +	bootph-all;
> +	status = "okay";
> +};
> +
> +&main_uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart1_pins_default>;
> +	bootph-pre-ram;
> +	status = "reserved";
> +};
> +
> +&main_uart6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart6_pins_default>;
> +	bootph-all;
> +	status = "okay";
> +};
> +
> +&main_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +	bootph-all;
> +	status = "okay";
> +
> +	ad7291: adc@20 {
> +		compatible = "adi,ad7291";

I think the commit message says MSPM0L1105 ? is this in emulation mode?
if so, we should document this.

> +		reg = <0x20>;
> +		vref-supply = <&adc_vref>;
> +	};
> +
> +	eeprom: eeprom@50 {
> +		compatible = "atmel,24c32";

is this the same? MSPM0L1105 doing eeprom? if so, please document.
> +		reg = <0x50>;
> +	};
> +};
> +
> +&main_i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c2_pins_default>;
> +	clock-frequency = <400000>;
> +	bootph-all;
> +	status = "okay";
> +};
> +
> +&mcu_m4fss {
> +	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
> +	memory-region = <&mcu_m4fss_dma_memory_region>,
> +			<&mcu_m4fss_memory_region>;
> +	status = "okay";
> +};
> +
> +&mcu_pmx0 {
> +	wkup_uart0_pins_default: wkup-uart0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C6/A7) WKUP_UART0_CTSn */
> +			AM62X_MCU_IOPAD(0x030, PIN_OUTPUT, 0)	/* (A4/B4) WKUP_UART0_RTSn */
> +			AM62X_MCU_IOPAD(0x024, PIN_INPUT, 0)	/* (B4/B5) WKUP_UART0_RXD */
> +			AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (C5/C6) WKUP_UART0_TXD */
> +		>;
> +		bootph-all;
> +	};
> +
> +	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_MCU_IOPAD(0x004c, PIN_INPUT_PULLUP, 0)	/* (B9) WKUP_I2C0_SCL */
> +			AM62X_MCU_IOPAD(0x0050, PIN_INPUT_PULLUP, 0)	/* (A9) WKUP_I2C0_SDA */
> +		>;
> +		bootph-all;
> +	};
> +};
> +
> +&sdhci1 {
> +	/* SD/MMC */
> +	vmmc-supply = <&vdd_mmc1>;
> +	vqmmc-supply = <&vdd_sd_dv>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc1_pins_default>;
> +	disable-wp;
> +	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
> +	cd-debounce-delay-ms = <100>;
> +	bootph-all;
> +	ti,fails-without-test-cd;
> +	status = "okay";
> +};
> +
> +&usbss0 {
> +	bootph-all;
> +	ti,vbus-divider;
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	bootph-all;
> +	dr_mode = "peripheral";

Can this operate in "otg" instead? maybe use a type-c dock?

> +};
> +
> +&usbss1 {
> +	ti,vbus-divider;
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb1_pins_default>;
> +};

is'nt this over https://www.beagleboard.org/boards/techlab or
https://www.beagleboard.org/boards/pocketbeagle-gamepup-cape or
https://github.com/mwelling/pocket-bob ?

I think it is better as an overlay? Let us not enable something that
will add power for no benefit :)
Further USB1.ID has options for PRU as well. Let the daughter overlay
deal with it.

On the flip side, we could work the other way - since majority of
daughter cards use USB host, it could be that the other overlays can
just disable usbss1 and usb1

Thoughts?

> +
> +&wkup_uart0 {
> +	/* WKUP UART0 is used by Device Manager firmware */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	bootph-all;
> +	status = "reserved";
> +};
> +
> +&wkup_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
> +	clock-frequency = <100000>;
> +	bootph-all;
> +	status = "okay";
> +
> +	tps65219: pmic@30 {
> +		compatible = "ti,tps65219";
> +		reg = <0x30>;
> +		buck1-supply = <&vsys_5v0>;
> +		buck2-supply = <&vsys_5v0>;
> +		buck3-supply = <&vsys_5v0>;
> +		ldo1-supply = <&vdd_3v3>;
> +		ldo2-supply = <&buck2_reg>;
> +		ldo3-supply = <&vdd_3v3>;
> +		ldo4-supply = <&vdd_3v3>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		bootph-all;
> +		system-power-controller;
> +		ti,power-button;
> +
> +		regulators {
> +			buck1_reg: buck1 {
> +				regulator-name = "VDD_CORE";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck2_reg: buck2 {
> +				regulator-name = "VDD_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck3_reg: buck3 {
> +				regulator-name = "VDD_1V2";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1_reg: ldo1 {
> +				/*
> +				 * Regulator is left as is unused, vdd_sd
> +				 * is controlled via GPIO with bypass config
> +				 * as per the NVM configuration
> +				 */
> +				regulator-name = "VDD_SD_3V3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-allow-bypass;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: ldo2 {
> +				regulator-name = "VDDA_0V85";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: ldo3 {
> +				regulator-name = "VDDA_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: ldo4 {
> +				regulator-name = "VDD_2V5";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.47.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


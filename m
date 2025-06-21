Return-Path: <linux-kernel+bounces-696614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A12AE2982
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086B73B7454
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B01A3172;
	Sat, 21 Jun 2025 14:33:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899495FB95;
	Sat, 21 Jun 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750516437; cv=none; b=iW5HOYu/NFGq8KOUEYKhx/MoI73F4d2UpZy2hZiHwNYmQH9KL4ZwCOvxmAd3XhE5ULPQhTCblOD3c0DEkry3Fh/2QUnDZGpLsGKVMgqv1WBKN9tmm+l92A/5SOCCvD7cNfl2k9wXtc1l4u4GMqAp283ZhMilQuiDil+Hr8NdOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750516437; c=relaxed/simple;
	bh=VJJEGWhpH2uEJDnTPUxtrZMoCJt2jX4EG9beBJKatlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INOb1JD/5Ea3/dS4G8QhaSgCkIijtGEatSFIZmraeN+D1kXvsFJTEASzLz+/nKWkIfjNDOm7VYupq8t5HB2mKLPpqRLreLSnG7q2e2CcREy+FiqGij2/ZqTzhTEkWfi7G4wwUsS+J8zdfopfztrYMWxf5LmDDbNiIw7v1pxZ3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01EBE1691;
	Sat, 21 Jun 2025 07:33:28 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D2013F58B;
	Sat, 21 Jun 2025 07:33:45 -0700 (PDT)
Date: Sat, 21 Jun 2025 15:32:29 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: allwinner: t527: Add OrangePi 4A board
Message-ID: <20250621153229.6796e824@minigeek.lan>
In-Reply-To: <20250619173007.3367034-6-wens@kernel.org>
References: <20250619173007.3367034-1-wens@kernel.org>
	<20250619173007.3367034-6-wens@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 01:30:07 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi Chen-Yu,

many thanks for piecing this together!
I compared this against the schematic, and found only some minor nits,
see below.

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The OrangePi 4A is a typical Raspberry Pi model B sized development
> board from Xunlong designed around an Allwinner T527 SoC.
> 
> The board has the following features:
> - Allwinner T527 SoC
> - AXP717B + AXP323 PMICs
> - Up to 4GB LPDDR4 DRAM
> - micro SD slot
> - optional eMMC module
> - M.2 slot for PCIe 2.0 x1
> - 16 MB SPI-NOR flash
> - 4x USB 2.0 type-A ports (one can be used in gadget mode)
> - 1x Gigabit ethernet w/ Motorcomm PHY (through yet to be supported GMAC200)
> - 3.5mm audio jack via internal audio codec
> - HDMI 2.0 output
> - eDP, MIPI CSI (2-lane and 4-lane) and MIPI DSI (4-lane) connectors
> - USB type-C port purely for power
> - AP6256 (Broadcom BCM4345) WiFi 5.0 + BT 5.0
> - unsoldered headers for ADC and an additional USB 2.0 host port
> - 40-pin GPIO header
> 
> Add a device tree for it, enabling all peripherals currently supported.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../dts/allwinner/sun55i-t527-orangepi-4a.dts | 378 ++++++++++++++++++
>  2 files changed, 379 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 773cc02a13d0..780aeba0f3a4 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -57,3 +57,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h700-anbernic-rg35xx-sp.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun55i-a527-cubie-a5e.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun55i-h728-x96qpro+.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun55i-t527-avaota-a1.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun55i-t527-orangepi-4a.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> new file mode 100644
> index 000000000000..8a62607e584c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (C) 2025 Chen-Yu Tsai <wens@csie.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun55i-a523.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "OrangePi 4A";
> +	compatible = "xunlong,orangepi-4a", "allwinner,sun55i-t527";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	ext_osc32k: ext-osc32k-clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		clock-output-names = "ext_osc32k";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		/* PWM capable pin, but PWM isn't supported yet. */
> +		led {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
> +		};
> +	};
> +
> +	wifi_pwrseq: pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&r_pio 1 1 GPIO_ACTIVE_LOW>; /* PM1 */
> +		clocks = <&rtc CLK_OSC32K_FANOUT>;
> +		clock-names = "ext_clock";
> +	};
> +
> +	reg_otg_vbus: regulator-otg-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "otg-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&reg_vcc5v>;
> +		gpio = <&r_pio 0 4 GPIO_ACTIVE_HIGH>;	/* PL4 */
> +		enable-active-high;
> +	};
> +
> +	reg_pcie_vcc3v3: regulator-pcie-vcc3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-pcie-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&reg_vcc5v>;
> +		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>;	/* PL8 */
> +		enable-active-high;
> +	};
> +
> +	reg_usb_vbus: regulator-usb-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&reg_vcc5v>;
> +		gpio = <&r_pio 0 12 GPIO_ACTIVE_HIGH>;	/* PL12 */
> +		enable-active-high;
> +	};
> +
> +	reg_vcc5v: regulator-vcc5v {
> +		/* board wide 5V supply from USB type-C port */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_cldo3>;
> +	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	bus-width = <4>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	non-removable;
> +	vmmc-supply = <&reg_dldo1_323>;
> +	vqmmc-supply = <&reg_bldo1>;
> +	status = "okay";
> +
> +	brcmf: wifi@1 {
> +		compatible = "brcm,bcm4329-fmac";
> +		reg = <1>;
> +		interrupt-parent = <&r_pio>;
> +		interrupts = <1 0 IRQ_TYPE_LEVEL_LOW>; /* PM0 */
> +		interrupt-names = "host-wake";
> +	};
> +};
> +
> +&mmc2 {
> +	bus-width = <8>;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	vmmc-supply = <&reg_cldo3>;
> +	vqmmc-supply = <&reg_cldo1>;
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&pio {
> +	vcc-pb-supply = <&reg_cldo3>;	/* via VCC-IO */
> +	vcc-pc-supply = <&reg_cldo1>;
> +	vcc-pd-supply = <&reg_cldo3>;
> +	vcc-pe-supply = <&reg_aldo2>;
> +	vcc-pf-supply = <&reg_cldo3>;	/* VCC-IO for 3.3v; VCC-MCSI for 1.8v */
> +	vcc-pg-supply = <&reg_bldo1>;
> +	vcc-ph-supply = <&reg_cldo3>;	/* via VCC-IO */
> +	vcc-pi-supply = <&reg_cldo3>;
> +	vcc-pj-supply = <&reg_cldo1>;
> +	vcc-pk-supply = <&reg_cldo1>;
> +};
> +
> +&r_i2c0 {
> +	status = "okay";
> +
> +	axp717: pmic@35 {
> +		compatible = "x-powers,axp717";
> +		reg = <0x35>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		interrupts-extended = <&nmi_intc 0 IRQ_TYPE_LEVEL_LOW>;
> +
> +		vin1-supply = <&reg_vcc5v>;
> +		vin2-supply = <&reg_vcc5v>;
> +		vin3-supply = <&reg_vcc5v>;
> +		vin4-supply = <&reg_vcc5v>;
> +		aldoin-supply = <&reg_vcc5v>;
> +		bldoin-supply = <&reg_vcc5v>;
> +		cldoin-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			/* Supplies the "little" cluster (1.4 GHz cores) */
> +			reg_dcdc1: dcdc1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1160000>;
> +				regulator-name = "vdd-cpul";
> +			};
> +
> +			reg_dcdc2: dcdc2 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <920000>;
> +				regulator-max-microvolt = <920000>;
> +				regulator-name = "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdc3: dcdc3 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1160000>;
> +				regulator-max-microvolt = <1160000>;
> +				regulator-name = "vcc-dram";
> +			};
> +
> +			reg_dcdc4: dcdc4 {
> +				/* feeds 3.3V pin on GPIO header */
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vdd-io";
> +			};
> +
> +			reg_aldo1: aldo1 {
> +				regulator-name = "avdd-csi";
> +			};
> +
> +			reg_aldo2: aldo2 {
> +				regulator-name = "vcc-pe";
> +			};
> +
> +			reg_aldo3: aldo3 {
> +				/* supplies the I2C pins for this PMIC */
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-pl-usb";
> +			};
> +
> +			reg_aldo4: aldo4 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc-pll-dxco-avcc";
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc-pg-wifi";
> +			};
> +
> +			reg_bldo2: bldo2 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc-pm-lpddr";
> +			};
> +
> +			reg_bldo3: bldo3 {
> +				regulator-name = "dvdd-csi";

In my version of the schematic this is AFVCC-CSI (whatever that means),
and ...

> +			};
> +
> +			reg_bldo4: bldo4 {

... BLDO4 is DVDD-CSI.

Not that it really matters, since both are not used yet ...


> +				/* not connected */
> +			};
> +
> +			reg_cldo1: cldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc-cvp-pc-lvds-mcsi-pk-efuse-pcie-edp-1v8";
> +			};
> +
> +			reg_cldo2: cldo2 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3-csi";
> +			};
> +
> +			reg_cldo3: cldo3 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-io-mmc-nand-pd-pi-usb";
> +			};
> +
> +			reg_cldo4: cldo4 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-3v3-phy1-lcd";
> +			};
> +
> +			reg_cpusldo: cpusldo {
> +				/* supplies the management core */
> +				regulator-always-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdd-cpus";

This also supplies some 0.9V USB circuitry, so maybe add this to the
name?

> +			};
> +		};
> +	};
> +
> +	axp323: pmic@36 {
> +		compatible = "x-powers,axp323";
> +		reg = <0x36>;
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +		status = "okay";
> +
> +		vin1-supply = <&reg_vcc5v>;
> +		vin2-supply = <&reg_vcc5v>;
> +		vin3-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_aldo1_323: aldo1 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-wifi";
> +			};
> +
> +			reg_dldo1_323: dldo1 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-wifi2";
> +			};
> +
> +			/* Supplies the "big" cluster (1.8 GHz cores) */
> +			reg_dcdc1_323: dcdc1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1150000>;
> +				regulator-name = "vdd-cpub";
> +			};
> +
> +			/* DCDC2 is polyphased with DCDC1 */
> +
> +			/* Some RISC-V management core related voltage */
> +			reg_dcdc3_323: dcdc3 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdd-dnr";
> +			};
> +		};
> +	};
> +};
> +
> +&r_pio {
> +/*
> + * Specifying the supply would create a circular dependency.
> + *
> + *	vcc-pl-supply = <&reg_aldo3>;
> + */
> +	vcc-pm-supply = <&reg_bldo2>;
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pb_pins>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm4345c5";
> +		clocks = <&rtc CLK_OSC32K_FANOUT>;
> +		clock-names = "lpo";
> +		vbat-supply = <&reg_aldo1_323>;

Is that some kind of trick, to accommodate *two* power rails for the
chip? Because to me it looks like the AXP323 ALDO1 and DLDO1 are
connected together and both supply the WiFi-BT-combo chip.
It's probably fine to model this way, since ALDO1 is the weaker of
the two, and I'd guess the WiFi needs more power, but worth a comment, I
guess.

Rest looks good to me.

Cheers,
Andre


> +		vddio-supply = <&reg_bldo1>;
> +		device-wakeup-gpios = <&r_pio 1 3 GPIO_ACTIVE_HIGH>; /* PM3 */
> +		host-wakeup-gpios = <&r_pio 1 4 GPIO_ACTIVE_HIGH>; /* PM4 */
> +		shutdown-gpios = <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
> +	};
> +};
> +
> +&usb_otg {
> +	 /*
> +	  * The OTG controller is connected to one of the type-A ports.
> +	  * There is a regulator, controlled by a GPIO, to provide VBUS power
> +	  * to the port, and a VBUSDET GPIO, to detect externally provided
> +	  * power. But without ID or CC pins there is no real way to do a
> +	  * runtime role detection.
> +	  */
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb0_vbus-supply = <&reg_otg_vbus>;
> +	usb0_vbus_det-gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
> +	usb1_vbus-supply = <&reg_usb_vbus>;
> +	status = "okay";
> +};



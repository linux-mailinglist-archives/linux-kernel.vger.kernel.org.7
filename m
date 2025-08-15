Return-Path: <linux-kernel+bounces-770166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ACFB277E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95551CC0F72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390991A23AF;
	Fri, 15 Aug 2025 04:48:29 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149A946A;
	Fri, 15 Aug 2025 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755233308; cv=none; b=bspj7DC/beqqYiXwZohtp9jNxYtbQxKNfV1Vhyg0rG0+Io8Ln+ruTz/4UZdoZMKB4Jl9Tx5gyWfD2IV5uqOxakBfE2CCjd94rzMB/Surph0j6Im4+0vp/kD3ZN4SpTtyFBoFfavRRiBPhHYZuBH2R5kGxvRjF4rsr3wpMVNDshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755233308; c=relaxed/simple;
	bh=U/ZCHgoKFfc9QJaTrmXqmfqDcf1NaFhCKBUUw57nJOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGRjobzqmjnMsgnpkP2q65wxDym4rZWcFtE8bT7EwxF+vm/Z/4HelaKMhoQK4oEBjQr8fbVn+RfOr70DfA/H+aN3xf8KcbU91Z7E2N2x/CWTNBoYsepCk5Bt7NKHdSFIX9Jh47QVbSUhdr9OGVKd93mBJRvOyS7Yp92W2K/7Zlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1755233221t2e0b32c0
X-QQ-Originating-IP: 6TC+4b5E0Lxiic6TIb7TxO8916XUnNew5Zsms2h75R8=
Received: from [IPV6:240f:10b:7440:1:6d2d:e482 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 12:46:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11444169768326151993
Message-ID: <058E04574291144B+66620590-b680-44b9-92c5-7dc4c43080e7@radxa.com>
Date: Fri, 15 Aug 2025 13:46:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250727144409.327740-1-jonas@kwiboo.se>
 <20250727144409.327740-4-jonas@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250727144409.327740-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NMGzQWUSIfvTF6kabW8VppYGb62HavVU0fv9DLatrt6eH4VH9GS2uBYk
	grKtCBy8DAeRXPgNjy6sn04zHWQGXA32riJ50KMLPqnlTeQGg3jRrc31QPy9cX4dYlfKyh/
	YrdaADvmEEpoTyO/qbsyMElOy0ME9V68lT63bmoZPKBultH4kePVzcBy4Ki+4xIglgzgBD4
	YaOdx+T0Ey2GcDX0eTLuLO31WY03PMddA9Hnt9WRZe6pcd6xQ5qlVlof3i21Mbh5WQ5slWq
	l+CkYabcA14/zJIDA77M1BkKNwtqm+8MibhFbbUjV6Sc24tExQNluget5ArOOMzx+kzeO2o
	lRRZI8adUNj4p6vA++5CdTixMQVjDml5Ewm7/R/0AUAyqG9fVy8HBQXJKdT5PkvJNjaMRjR
	7D9iuLE9EW5nZQu631fV8ffkiGM3EdPq4h9tQVQbEwBaNicU5ALd6CfvNd2+y8EsuoXyZLp
	Hps3cuAeXIUCR8zwaz7d8H8axd/l+qjROFTKBpWnIaQ4vjs0FyB5gTjsmL4sKzdY4GKDa9a
	RDx9Ex28PUESz8T3EjlVcN1cBg6udChJLUHvnfqH9ax+cTSTTi/hr6fPbzPDiThCnrYfJ8t
	wkp7jgr5Z08NkWPej2sv2aexB/qSn6EZw5q/zjEoau05aH1bEFP59xAFVphzOjB3HipzCKm
	0XIcZ2jippT/fy2KgpbBV+jF+2JlsZgHh5KfAOU6pcRRDyNuz1o/ZuG1qwO3HS5irQ0usmb
	7H1YL645Lu/lOxnd3NDB2/d1fYXgQehA+ZAm+dZT1AFuWpeBnd169s9kHQ3t9gX4/n+yhZT
	pEvYBP3o4w7tvzEEWjYqjR2dqZ4JIe5PZeyOXnXVDDi8wAE+/etIEfHEI78jdTn04fSHiZa
	ubTDAD5fWONSqUdTQAmstGpqWfYLh6my8cwnwl9lMpVqWN+gk+mz5POgGCuBIYpE6VR9qaC
	1pHX+23IlL9d8HTLcST2lSD8uUF3uGab1gvBGatvyeAoh8LSpec7FHNReGZu1b47oRli1+z
	UnA+gpwUMw4jXKLDKn
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Hi Jonas,

On 7/27/25 23:44, Jonas Karlman wrote:
> The Radxa E24C is a compact, high-performance network computer
> developed by Radxa, based on the Rockchip RK3528A SoC.
> 
> Add initial device tree for the Radxa E24C.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Schematics: https://dl.radxa.com/e/e24c/docs/radxa_e24c_v1200_schematic.pdf
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>   .../boot/dts/rockchip/rk3528-radxa-e24c.dts   | 519 ++++++++++++++++++
>   2 files changed, 520 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 0662fcf00628..dc62fd5305be 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -92,6 +92,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-armsom-sige1.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-nanopi-zero2.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e20c.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e24c.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2a.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2f.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3562-evb2-v10.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
> new file mode 100644
> index 000000000000..225f2b0c5339
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
> @@ -0,0 +1,519 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include "rk3528.dtsi"
> +
> +/ {
> +	model = "Radxa E24C";
> +	compatible = "radxa,e24c", "rockchip,rk3528";
> +
> +	aliases {
> +		ethernet0 = &gmac1;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c5 = &i2c5;
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +		rtc0 = &hym8563;
> +		rtc1 = &rk805;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:1500000n8";
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +
> +		button-maskrom {
> +			label = "MASKROM";
> +			linux,code = <KEY_SETUP>;
> +			press-threshold-microvolt = <0>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio0_a0_user>;
> +
> +		button-user {
> +			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
> +			label = "USER";
> +			linux,code = <BTN_1>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "on";
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_LOW>;
> +			label = "SYS";

"label" is deprecated. "color" and "function" should be enough to 
explain what they are.

(Personally, I prefer LED_FUNCTION_STATUS to LED_FUNCTION_HEARTBEAT)

> +			linux,default-trigger = "heartbeat";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&sys_led_g>;
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_WAN;
> +			gpios = <&gpio4 RK_PA0 GPIO_ACTIVE_HIGH>;
> +			label = "WAN";

Ditto.

> +			linux,default-trigger = "netdev";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wan_led_g>;
> +		};
> +
> +		led-2 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_LAN;
> +			gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
> +			label = "LAN1";

Ditto.

You can use the following instead:
  function-enumerator = <1>;

> +			linux,default-trigger = "netdev";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lan1_led_g>;
> +		};
> +
> +		led-3 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_LAN;
> +			gpios = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
> +			label = "LAN2";

  function-enumerator = <2>;

> +			linux,default-trigger = "netdev";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lan2_led_g>;
> +		};
> +
> +		led-4 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_LAN;
> +			gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_HIGH>;
> +			label = "LAN3";

  function-enumerator = <3>;

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> +			linux,default-trigger = "netdev";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lan3_led_g>;
> +		};
> +	};
> +
> +	vcc3v3_mkey: regulator-3v3-vcc-mkey {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mkey_pwr_en>;
> +		regulator-name = "vcc3v3_mkey";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_sys: regulator-5v0-vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc_12v>;
> +	};
> +
> +	vcc5v0_usb20: regulator-5v0-vcc-usb20 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_host_en>;
> +		regulator-name = "vcc5v0_usb20";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc_12v: regulator-12v0-vcc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_12v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	avddl_1v1: avddh_3v3: avdd_rtl8367rb: regulator-avdd-rtl8367rb {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_8367_en>;
> +		regulator-name = "avdd_rtl8367rb";
> +		startup-delay-us = <10000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vccio_sd: regulator-vccio-sd {
> +		compatible = "regulator-gpio";
> +		gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc_vol_ctrl_h>;
> +		regulator-name = "vccio_sd";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		states = <1800000 0x0>, <3300000 0x1>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-mode = "rgmii-id";
> +	phy-supply = <&avdd_rtl8367rb>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
> +		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>, <&gmac1_rstn_l>;
> +	status = "okay";
> +
> +	fixed-link {
> +		speed = <1000>;
> +		full-duplex;
> +	};
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_logic>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0m0_xfer>;
> +	status = "okay";
> +
> +	rk805: pmic@18 {
> +		compatible = "rockchip,rk805";
> +		reg = <0x18>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
> +		#clock-cells = <1>;
> +		clock-output-names = "rk805-clkout1", "rk805-clkout2";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int>;
> +		system-power-controller;
> +		wakeup-source;
> +
> +		vcc1-supply = <&vcc5v0_sys>;
> +		vcc2-supply = <&vcc5v0_sys>;
> +		vcc3-supply = <&vcc5v0_sys>;
> +		vcc4-supply = <&vcc5v0_sys>;
> +		vcc5-supply = <&vcc5v0_sys>;
> +		vcc6-supply = <&vcc5v0_sys>;
> +
> +		regulators {
> +			vdd_arm: DCDC_REG1 {
> +				regulator-name = "vdd_arm";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <712500>;
> +				regulator-max-microvolt = <1450000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_logic: DCDC_REG2 {
> +				regulator-name = "vdd_logic";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <712500>;
> +				regulator-max-microvolt = <1450000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: DCDC_REG4 {
> +				regulator-name = "vcc_3v3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc_1v8: LDO_REG1 {
> +				regulator-name = "vcc_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcc1v8_emmc: LDO_REG2 {
> +				regulator-name = "vcc1v8_emmc";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd_0v9_p: LDO_REG3 {
> +				regulator-name = "vdd_0v9_p";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <900000>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1m0_xfer>;
> +	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "belling,bl24c16a", "atmel,24c16";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +		read-only;
> +		vcc-supply = <&vcc_3v3>;
> +	};
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5m0_xfer>;
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtc_int_l>;
> +		wakeup-source;
> +	};
> +};
> +
> +&mdio1 {
> +	reset-delay-us = <25000>;
> +	reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
> +	reset-post-delay-us = <100000>;
> +};
> +
> +&pinctrl {
> +	ethernet {
> +		gmac1_rstn_l: gmac1-rstn-l {
> +			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		gpio_8367_en: gpio-8367-en {
> +			rockchip,pins = <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		rtl8367rb_eint: rtl8367rb-eint {
> +			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		gpio0_a0_user: gpio0-a0-user {
> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	leds {
> +		lan1_led_g: lan1-led-g {
> +			rockchip,pins = <1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		lan2_led_g: lan2-led-g {
> +			rockchip,pins = <1 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		lan3_led_g: lan3-led-g {
> +			rockchip,pins = <1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		sys_led_g: sys-led-g {
> +			rockchip,pins = <4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		wan_led_g: wan-led-g {
> +			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie {
> +		mkey_pwr_en: mkey-pwr-en {
> +			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int: pmic-int {
> +			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	rtc {
> +		rtc_int_l: rtc-int-l {
> +			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	sdmmc {
> +		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
> +			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		usb_host_en: usb-host-en {
> +			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&saradc {
> +	vref-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc1v8_emmc>;
> +	status = "fail";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&sfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fspi_csn0>, <&fspi_pins>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <50000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <1>;
> +		vcc-supply = <&vcc1v8_emmc>;
> +	};
> +};
> +
> +&u2phy {
> +	status = "okay";
> +};
> +
> +&u2phy_host {
> +	phy-supply = <&vcc5v0_usb20>;
> +	status = "okay";
> +};
> +
> +&u2phy_otg {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0m0_xfer>;
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	extcon = <&u2phy>;
> +	maximum-speed = "high-speed";
> +	phys = <&u2phy_otg>;
> +	phy-names = "usb2-phy";
> +	status = "okay";
> +};



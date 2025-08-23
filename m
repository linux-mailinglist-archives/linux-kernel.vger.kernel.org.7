Return-Path: <linux-kernel+bounces-783324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338BBB32BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 21:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012E1189624B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F53241667;
	Sat, 23 Aug 2025 19:32:54 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B22BD03;
	Sat, 23 Aug 2025 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977574; cv=none; b=FYHVfmCKBMfoL1qbs//vXjlonicbH9n+qa+KLukDxuHD5e0vGNG9Z3MQECBoKzl093DnoJAxVL+XAx96Q3PAnHRNDKZg4YPAhPvnTn21q4snRcWTeKWQnWorXKBVFPVovub4uJ8gwsqH7KhcAfqmKYoVQakmdeOr2F0O4jlWCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977574; c=relaxed/simple;
	bh=F9vAKy3Kj8tLGDHWWzJhc98x9ouHBdjXV9lPFIAqsTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+qLuqO/lWZ/T9JUxR2AhchebHqyOhJ3fSD+9Ksbdgh3qfVx8gs/42o2k1nuSdLvfHr0+bjAiwbM0dzij3NFAadD4VW2747Tmn58wS3rAk3iPXD2bHuJDxIViW7VA4gjk/OvZraGvJHbUbxqdJlQx++v4Yp/BP948Z/pr9WiGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.216])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 640EAB4E009F;
	Sat, 23 Aug 2025 21:32:46 +0200 (CEST)
Message-ID: <fba0b49a-6906-46b8-92e4-d79e57b40d28@freeshell.de>
Date: Sat, 23 Aug 2025 12:32:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
 <20250821100930.71404-4-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250821100930.71404-4-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 03:09, Hal Feng wrote:
> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.
> 
> Board features:
> - JH7110S SoC
> - 2/4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 1x USB 3.0 host port
> - 3x USB 2.0 host port
> - 1x M.2 M-Key (size: 2242)
> - 1x MicroSD slot (optional non-removable eMMC)
> - 1x QSPI Flash
> - 1x I2C EEPROM
> - 1x 1Gbps Ethernet port
> - SDIO-based Wi-Fi & UART-based Bluetooth
> - 1x HDMI port
> - 1x 2-lane DSI
> - 1x 2-lane CSI
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |   2 +
>  .../jh7110s-starfive-visionfive-2-lite.dts    | 152 ++++++++++++++++++
>  2 files changed, 154 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
> 
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index b3bb12f78e7d..7265c363e2a9 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -13,3 +13,5 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
> +
> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110s-starfive-visionfive-2-lite.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
> new file mode 100644
> index 000000000000..a0cb9912eb80
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 StarFive Technology Co., Ltd.
> + * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +	model = "StarFive VisionFive 2 Lite";
> +	compatible = "starfive,visionfive-2-lite", "starfive,jh7110s";
> +};
> +
> +&cpu_opp {
> +	opp-312500000 {
> +		opp-hz = /bits/ 64 <312500000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-417000000 {
> +		opp-hz = /bits/ 64 <417000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-625000000 {
> +		opp-hz = /bits/ 64 <625000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1250000000 {
> +		opp-hz = /bits/ 64 <1250000000>;
> +		opp-microvolt = <1000000>;
> +	};
> +};
> +
> +&gmac0 {
> +	starfive,tx-use-rgmii-clk;
> +	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> +	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	bus-width = <4>;
> +	no-sdio;
> +	no-mmc;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_HIGH>;
> +	disable-wp;
> +	cap-sd-highspeed;
> +};
> +
> +&mmc1 {
> +	max-frequency = <50000000>;
> +	keep-power-in-suspend;
> +	non-removable;
> +};
> +
> +&pcie1 {
> +	enable-gpios = <&sysgpio 27 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&phy0 {
> +	motorcomm,tx-clk-adj-enabled;
> +	motorcomm,tx-clk-100-inverted;
> +	motorcomm,tx-clk-1000-inverted;
> +	motorcomm,rx-clk-drv-microamp = <3970>;
> +	motorcomm,rx-data-drv-microamp = <2910>;
> +	rx-internal-delay-ps = <1500>;
> +	tx-internal-delay-ps = <1500>;
> +};
> +
> +&pwm {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +};
> +
> +&syscrg {
> +	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <1250000000>;
> +};

Circling back to a topic where I don't understand CPU clocks in hardware
design, but I have questions, I would want to see 8 divisions instead of
4 divisions (for both JH7110S and for JH7110). Similar for JH7110S here as:

&syscrg {
	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <2500000000>;
};

and then in above &cpu_opp as:

&cpu_opp {
	opp-312500000 {
		opp-hz = /bits/ 64 <312500000>;
		opp-microvolt = <800000>;
	};
	opp-357000000 {
		opp-hz = /bits/ 64 <357000000>;
		opp-microvolt = <800000>;
	};
	opp-417000000 {
		opp-hz = /bits/ 64 <417000000>;
		opp-microvolt = <800000>;
	};
	opp-500000000 {
		opp-hz = /bits/ 64 <500000000>;
		opp-microvolt = <800000>;
	};
	opp-625000000 {
		opp-hz = /bits/ 64 <625000000>;
		opp-microvolt = <800000>;
	};
	opp-833000000 {
		opp-hz = /bits/ 64 <833000000>;
		opp-microvolt = <800000>;
	};
	opp-1250000000 {
		opp-hz = /bits/ 64 <1250000000>;
		opp-microvolt = <1000000>;
	};

	/* avoid division=1 2.5GHz omitted here, not supported by CPU */
};

What prevents this functionality I am asking about?  Specifically on
JH7110 the promotional block diagrams show 3.0GHz maximum (?  I think?
not sure but what else could this be?) so if that is true why do we not
divide down from that, avoiding divisions that are problematic?

-E

> +
> +&sysgpio {
> +	uart1_pins: uart1-0 {
> +		tx-pins {
> +			pinmux = <GPIOMUX(22, GPOUT_SYS_UART1_TX,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <12>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		rx-pins {
> +			pinmux = <GPIOMUX(23, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_UART1_RX)>;
> +			bias-pull-up;
> +			drive-strength = <2>;
> +			input-enable;
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};
> +
> +		cts-pins {
> +			pinmux = <GPIOMUX(24, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_UART1_CTS)>;
> +			input-enable;
> +		};
> +
> +		rts-pins {
> +			pinmux = <GPIOMUX(25, GPOUT_SYS_UART1_RTS,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			input-enable;
> +		};
> +	};
> +
> +	usb0_pins: usb0-0 {
> +		power-pins {
> +			pinmux = <GPIOMUX(26, GPOUT_HIGH,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			input-disable;
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>;
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_pins>;
> +	status = "okay";
> +};
> +
> +&usb_cdns3 {
> +	phys = <&usbphy0>, <&pciephy0>;
> +	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
> +};



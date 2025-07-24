Return-Path: <linux-kernel+bounces-744039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4666CB10736
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981A4AC82FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28C625A354;
	Thu, 24 Jul 2025 09:59:48 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935825A2C2;
	Thu, 24 Jul 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351188; cv=none; b=k0i+AuVrsTn5mYChwNg46rj8N+OlY3sBl7vQhmbYi2MqxP3YxZyHQ1CFsmqVtUEASr2XRN8fGiY4quapaikSeYZEScvw9CLRlc5bVhl+pvRXVYmgquOH6VEBS3Yp7jptusB/hDACpqnCQqMESn5zanlZtOSP/8qHIAMmXCljVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351188; c=relaxed/simple;
	bh=e8Kr6qHidQg5GTpisUorURaei4mV2rg75pt3clWPQRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXjj4l1/rohoeHzyvNuiJActXuIx/cR3DhbxOozCzbhdl1VcuscvUW4P8Tt0NsbJ5qSLPVXwvDi3gLTn0WBMjkzLnUKUFw636IoOXWbojxXPGuDckmqh3bXeki7J/Zyc2zVSAZWnFy/Dfj9LHfUT73JQTbq3oD6b5blk7GH2TfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [143.105.119.201])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 59289B4D0DFE;
	Thu, 24 Jul 2025 11:59:42 +0200 (CEST)
Message-ID: <d12350a6-bd8c-416d-8c57-2d96e47bacbd@freeshell.de>
Date: Thu, 24 Jul 2025 02:59:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] riscv: dts: starfive: add Milk-V Mars CM
 system-on-module
To: Conor Dooley <conor@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, E Shattow <e@freeshell.de>
References: <20250724094912.253723-1-e@freeshell.de>
 <20250724094912.253723-3-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250724094912.253723-3-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Oops... wrong S-o-by email address on this patch.

On 7/24/25 02:48, E Shattow wrote:
> Milk-V Mars CM is a System-on-Module based on the StarFive VisionFive 2
> board and Radxa CM3 System-on-Module compatible with the Raspberry Pi
> CM4IO Classic IO Board.
> 
> Mars CM SoM features:
> 
> - StarFive JH7110 System on Chip with RV64GC up to 1.5GHz
> - AXP15060 Power Management Unit
> - LPDDR4 2GB / 4GB / 8GB DRAM memory
> - BL24C04F 4K bits (512 x 8) EEPROM
> - GigaDevice 25LQ128EWIG QSPI NOR Flash 16M or SoC ROM UART loader for
>   boot (selectable by GPIO)
> - eMMC5.0 8GB / 16GB / 32GB flash storage onboard
> - AP6256 via SDIO 2.0 onboard wireless connectivity WiFi 5 + Bluetooth
>   5.2 (optional, present in models with WiFi feature)
> - 1x Motorcomm YT8531C Gigabit Ethernet PHY
> - IMG BXE-4-32 Integrated GPU with 3D Acceleration:
>   - H.264 & H.265 4K@60fps Decoding
>   - H.265 1080p@30fps Encoding
>   - JPEG encoder / decoder
> 
> Additional features available via 2x 100-pin connectors for CM4IO Board:
> - 1x HDMI 2.0
> - 1x MIPI DSI (4-lanes)
> - 1x 2CH Audio out (via GPIO)
> - 1x MIPI CSI (2x2-lanes or 1x4-lanes)
> - 1x USB 2.0
> - 1x PCIe 1-lane Host, Gen 2 (5Gbps)
> - Up to 28x GPIO, supporting 3.3V
> - UART x6
> - PWM x8
> - I2C x7
> - SPI
> - I2S
> 
> Link to Milk-V Mars CM schematics: https://github.com/milkv-mars/mars-files/tree/main/Mars-CM_Hardware_Schematices
> Link to StarFive JH7110 Technical Reference Manual: https://doc-en.rvspace.org/JH7110/TRM/index.html
> Link to Raspberry Pi CM4IO datasheet: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf
> 
> Add the devicetree file to make use of StarFive JH7110 common supported
> features PMIC, EEPROM, UART, I2C, GPIO, eMMC, PCIe, PWM DAC, QSPI Flash,
> PWM, and Ethernet. Also configure the common SD Card interface mmc1 for
> onboard SDIO BT+WiFi.
> 
> Signed-off-by: E Shattow <e@freenode.de>

Should be @freeshell.de

> ---
>  arch/riscv/boot/dts/starfive/Makefile         |   1 +
>  .../dts/starfive/jh7110-milkv-marscm-emmc.dts | 163 ++++++++++++++++++
>  2 files changed, 164 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
> 
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index b3bb12f78e7d..79742617ddab 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
>  
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-emmc.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
> new file mode 100644
> index 000000000000..59766cdb912b
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 E Shattow <e@freeshell.de>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +	model = "Milk-V Mars CM";
> +	compatible = "milkv,marscm-emmc", "starfive,jh7110";
> +
> +	aliases {
> +		i2c1 = &i2c1;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		serial3 = &uart3;
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&sysgpio 33 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&gmac0 {
> +	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> +	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> +	starfive,tx-use-rgmii-clk;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "disabled";
> +};
> +
> +&i2c6 {
> +	status = "disabled";
> +};
> +
> +&mmc1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	status = "okay";
> +
> +	ap6256: wifi@1 {
> +		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
> +		reg = <1>;
> +		interrupt-parent = <&sysgpio>;
> +		interrupts = <34 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "host-wake";
> +		pinctrl-0 = <&wifi_host_wake_irq>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&pcie0 {
> +	status = "okay";
> +};
> +
> +&phy0 {
> +	rx-internal-delay-ps = <1500>;
> +	tx-internal-delay-ps = <1500>;
> +	motorcomm,rx-clk-drv-microamp = <3970>;
> +	motorcomm,rx-data-drv-microamp = <2910>;
> +	motorcomm,tx-clk-10-inverted;
> +	motorcomm,tx-clk-100-inverted;
> +	motorcomm,tx-clk-1000-inverted;
> +	motorcomm,tx-clk-adj-enabled;
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
> +&sysgpio {
> +	uart1_pins: uart1-0 {
> +		tx-pins {
> +			pinmux = <GPIOMUX(16, GPOUT_SYS_UART1_TX,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <12>;
> +			input-disable;
> +			input-schmitt-disable;
> +		};
> +
> +		rx-pins {
> +			pinmux = <GPIOMUX(17, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_UART1_RX)>;
> +			bias-pull-up;
> +			input-enable;
> +			input-schmitt-enable;
> +		};
> +
> +		cts-pins {
> +			pinmux = <GPIOMUX(3, GPOUT_LOW,
> +					     GPOEN_DISABLE,
> +					     GPI_SYS_UART1_CTS)>;
> +			bias-disable;
> +			input-enable;
> +			input-schmitt-enable;
> +		};
> +
> +		rts-pins {
> +			pinmux = <GPIOMUX(2, GPOUT_SYS_UART1_RTS,
> +					     GPOEN_ENABLE,
> +					     GPI_NONE)>;
> +			bias-disable;
> +			input-disable;
> +			input-schmitt-disable;
> +		};
> +	};
> +
> +	usb0_pins: usb0-0 {
> +		vbus-pins {
> +			pinmux = <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	wifi_host_wake_irq: wifi-host-wake-irq {
> +		wake-pins {
> +			pinmux = <GPIOMUX(34, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			input-enable;
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	uart-has-rtscts;
> +	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_pins>;
> +	status = "okay";
> +};

-E


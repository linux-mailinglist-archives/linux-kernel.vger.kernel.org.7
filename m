Return-Path: <linux-kernel+bounces-872989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C0EC12C97
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E97674E630E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851117C21E;
	Tue, 28 Oct 2025 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="O4Bvlhrp"
Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com [45.254.49.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1227877D;
	Tue, 28 Oct 2025 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622895; cv=none; b=PMh/ourE8pJ3z+MgWd5EIzaDJhac6zb0958mz0pRfme8Zw9X6g98+31314RYERSwLc6H5V9Qq2hbHT7COxoYXdhXQF+pP0MeSgGRp2WEVRj/8Vbb6u5R0dVXeipckHt2bogpxV3tJZ3HBrACsF5Z4qc+wg/29I6bWijJA35TgDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622895; c=relaxed/simple;
	bh=2rF5qR2mz+L8RgjMiMeRME4iD/NzLjyueCcENqEwVao=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y5vKk9HT3oIOGLTiluJ5ihcWgQiog/yQaL/jNbPZwy8oeSd16PchsbPnPkN0rCPMBhVLqA1qvRewe1q9+24b9hscWsoD/RPkaifzEOeui0It1wTakdluJFsRlc5jvBUxjAg3uShLnP1bXBxKhkBHWlgVnRrk/5UE7xv/d+I92M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=O4Bvlhrp; arc=none smtp.client-ip=45.254.49.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 276b9cb1b;
	Tue, 28 Oct 2025 11:36:11 +0800 (GMT+08:00)
Message-ID: <fb7c9db4-fb22-4145-84f4-49d7e53d17fb@rock-chips.com>
Date: Tue, 28 Oct 2025 11:36:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add devicetree for the X3568 v4
To: Coia Prant <coiaprant@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20251025203711.3859240-1-coiaprant@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251025203711.3859240-1-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a28e33aad09cckunm3c7a7795f0454
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRpPGlYeS0kZShgeGR4fTB1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=O4BvlhrpsOEJdUqSkAI4vnEXLWk+ZA+XJ0bCeiYorcBJ/CDKny+i3TO3TRQvRTWVGjyTguIKHpbZuABC3oa7VrXFy6fsfSmCeFbfAv1mK/GVbpfGyJWyRZFeE/iS2Uo4mgjn1GDhtiGw8dHME6Jom3Jcp4hybrLz2eDBXS7LT38=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=XxfJ+cZwH3QgvhVaJGaYCbrSp2F0wdmzWMP7vl3XNKQ=;
	h=date:mime-version:subject:message-id:from;

在 2025/10/26 星期日 4:37, Coia Prant 写道:
> Specification:
> - SoC: RockChip RK3568 ARM64 (4 cores)
> - eMMC: 16-128 GB
> - RAM: 2-8 GB
> - Power: DC 12V 2A
> - Ethernet: 2x YT8521SC RGMII (10/100/1000 Mbps)
> - Wireless radio: 802.11b/g/n/ac/ax dual-band
> - LED:
>    Power: AlwaysOn
>    User: GPIO
> - Button:
>    VOL+: SARADC/0 <35k µV>
>    VOL-: SARADC/0 <450k µV>
>    Power/Reset: PMIC RK809
> - CAN
>    CAN/1: 4-pin (PH 2.0)
> - PWM
>    PWM/4: Backlight DSI/0 DSI/1
>    PWM/7: IR Receiver [may not install]
> - UART:
>    UART/2: Debug TTL - 1500000 8N1 (1.25mm)
>    UART/3: TTL (PH 2.0)
>    UART/4: TTL (PH 2.0)
>    UART/8: AP6275S Bluetooth
>    UART/9: TTL (PH 2.0)
> - I2C:
>    I2C/0: PMIC RK809
>    I2C/1: Touchscreen DSI/0 DSI/1
>    I2C/4: Camera
>    I2C/5: RTC@51 PCF8563
> - I2S:
>    I2S/0: miniHDMI Sound
>    I2S/1: RK809 Audio Codec
>    I2S/3: AP6275S Bluetooth Sound
> - SDMMC:
>    SDMMC/0: microSD (TF) slot
>    SDMMC/2: AP6275S SDIO WiFi card
> - Camera: 1x CSI
> - Video: miniHDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
> - Audio: miniHDMI / MIC on-board / Speaker / SPDIF / 3.5mm Headphones / AP6275S Bluetooth
> - USB:
>    USB 2.0 HOST x2
>    USB 2.0 HOST x3 (4-pin)
>    USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST) [slot may not install]
>    USB 3.0 HOST x1
>    USB 3.0 OTG/HOST x1
> - SATA: 1x SATA 3.0 with Power/4-pin [slot may not install]
> - PCIe: 1x PCIe 3.0 x2 (x4 connecter) [clock/slot may not install]

A side note: AFAICT, if clock may not be installed, you shouldn't
enable pcie3x2 or pcie3x4.. Otherwise it can't boot at all..

> 
> Link:
> - https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
> - https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flash.html
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> Tested-by: Coia Prant <coiaprant@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |  11 +
>   .../rockchip/rk3568-x3568-camera-demo.dtso    |  82 ++
>   .../boot/dts/rockchip/rk3568-x3568-v4.dts     | 884 ++++++++++++++++++
>   .../dts/rockchip/rk3568-x3568-video-demo.dtso | 141 +++
>   4 files changed, 1118 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index ad684e383..ea36334bb 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -150,6 +150,9 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3b.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-x3568-v4.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-x3568-camera-demo.dtso
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-x3568-video-demo.dtso
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5-v1.2-wifibt.dtbo
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-evb1-v10.dtb
> @@ -252,6 +255,14 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5-v1.2-wifibt.dtb
>   rk3576-armsom-sige5-v1.2-wifibt-dtbs := rk3576-armsom-sige5.dtb \
>   	rk3576-armsom-sige5-v1.2-wifibt.dtbo
>   
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-x3568-v4-camera-demo.dtb
> +rk3568-x3568-v4-camera-demo-dtbs := rk3568-x3568-v4.dtb \
> +	rk3568-x3568-camera-demo.dtso
> +
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-x3568-v4-video-demo.dtb
> +rk3568-x3568-v4-video-demo-dtbs := rk3568-x3568-v4.dtb \
> +	rk3568-x3568-video-demo.dtso
> +
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-wifi.dtb
>   rk3588-edgeble-neu6a-wifi-dtbs := rk3588-edgeble-neu6a-io.dtb \
>   	rk3588-edgeble-neu6a-wifi.dtbo
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso b/arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso
> new file mode 100644
> index 000000000..b144d0010
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +
> +// This is a sample reference, due to lack of hardware can not be tested, at your own risk
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/clock/rk3568-cru.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +
> +&{/} {
> +	vcc_cam: regulator-vcc-cam {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vcc_cam";
> +		vin-supply = <&vcc3v3_sys>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc_cam_en>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	cam {
> +		vcc_cam_en: vcc_cam_en {
> +			rockchip,pins =	<0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&csi_dphy {
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			mipi_in_ucam: endpoint@2 {
> +				reg = <2>;
> +				remote-endpoint = <&ucam_out>;
> +				data-lanes = <1 2 3 4>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	camera@37 {
> +		compatible = "ovti,ov5695";
> +		reg = <0x37>;
> +		clocks = <&cru CLK_CIF_OUT>;
> +		clock-names = "xvclk";
> +		avdd-supply = <&vcc_cam>;
> +		dvdd-supply = <&vcc_cam>;
> +		dovdd-supply = <&vcc_cam>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&cif_clk>;
> +		reset-gpios = <&gpio3 RK_PB6 GPIO_ACTIVE_LOW>;
> +		pwdn-gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_LOW>;
> +
> +		port {
> +			ucam_out: endpoint {
> +				remote-endpoint = <&mipi_in_ucam>;
> +				data-lanes = <1 2 3 4>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts b/arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
> new file mode 100644
> index 000000000..901735c6f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
> @@ -0,0 +1,884 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3568.dtsi"
> +
> +/ {
> +	model = "NineTripod X3568 v4";
> +	compatible = "ninetripod,x3568-v4", "rockchip,rk3568";
> +
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc0;
> +		mmc2 = &sdmmc2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +
> +		button-vol-up {
> +			label = "volume up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			press-threshold-microvolt = <50000>;
> +		};
> +
> +		button-vol-down {
> +			label = "volume down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			press-threshold-microvolt = <500000>;
> +		};
> +	};
> +
> +	hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led_work: led-0 {
> +			gpios = <&gpio0 RK_PC0 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			color = <LED_COLOR_ID_BLUE>;
> +			linux,default-trigger = "heartbeat";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&led_work_en>;
> +		};
> +	};
> +
> +	rk809-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,name = "Analog RK809";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s1_8ch>;
> +		};
> +		simple-audio-card,codec {
> +			sound-dai = <&rk809>;
> +		};
> +	};
> +
> +	pdm_codec: pdm-codec {
> +		compatible = "dmic-codec";
> +		num-channels = <2>;
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	pdm_sound: pdm-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "microphone";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&pdm>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&pdm_codec>;
> +		};
> +	};
> +
> +	spdif_dit: spdif-dit {
> +		compatible = "linux,spdif-dit";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	spdif_sound: spdif-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "SPDIF";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&spdif>;
> +		};
> +		simple-audio-card,codec {
> +			sound-dai = <&spdif_dit>;
> +		};
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rk809 1>;
> +		clock-names = "ext_clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable>;
> +		post-power-on-delay-ms = <100>;
> +		power-off-delay-us = <300>;
> +		reset-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	dc_12v: regulator-dc-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_12v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	pcie30_avdd0v9: regulator-pcie30-avdd0v9 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pcie30_avdd0v9";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pcie30_avdd1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vcc3v3_sys: regulator-vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	vcc3v3_pcie: regulator-vcc3v3-pcie {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_pcie";
> +		enable-active-high;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc3v3_pcie_en_pin>;
> +		gpio = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <5000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_sys: regulator-vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	vcc5v0_usb: regulator-vcc5v0-usb {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	vcc5v0_usb_host: regulator-vcc5v0-usb-host {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_usb_host_en>;
> +		regulator-name = "vcc5v0_usb_host";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +
> +	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_usb_otg_en>;
> +		regulator-name = "vcc5v0_usb_otg";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +};
> +
> +&can1 {
> +	assigned-clocks = <&cru CLK_CAN1>;
> +	assigned-clock-rates = <150000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&can1m1_pins>;
> +	status = "okay";
> +};
> +
> +/* used for usb_host0_xhci */
> +&combphy0 {
> +	status = "okay";
> +};
> +
> +/* used for usb_host1_xhci */
> +&combphy1 {
> +	status = "okay";
> +};
> +
> +/* connected to sata2 */
> +&combphy2 {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&gmac0 {
> +	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
> +	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>;
> +	assigned-clock-rates = <0>, <125000000>;
> +	clock_in_out = "output";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +			&gmac0_tx_bus2
> +			&gmac0_rx_bus2
> +			&gmac0_rgmii_clk
> +			&gmac0_rgmii_bus
> +			&gmac0_clkinout>;
> +	phy-handle = <&rgmii_phy0>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};
> +
> +&gmac1 {
> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
> +	assigned-clock-rates = <0>, <125000000>;
> +	clock_in_out = "output";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1m1_miim
> +			&gmac1m1_tx_bus2
> +			&gmac1m1_rx_bus2
> +			&gmac1m1_rgmii_clk
> +			&gmac1m1_rgmii_bus
> +			&gmac1m1_clkinout>;
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	avdd-0v9-supply = <&vdda0v9_image>;
> +	avdd-1v8-supply = <&vcca1v8_image>;
> +	status = "okay";
> +};
> +
> +&hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi>;
> +	};
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs4525";
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1150000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> +		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
> +		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
> +		#clock-cells = <1>;
> +		clock-names = "mclk";
> +		clocks = <&cru I2S1_MCLKOUT_TX>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int>, <&i2s1m0_mclk>;
> +		system-power-controller;
> +		#sound-dai-cells = <0>;
> +		vcc1-supply = <&vcc3v3_sys>;
> +		vcc2-supply = <&vcc3v3_sys>;
> +		vcc3-supply = <&vcc3v3_sys>;
> +		vcc4-supply = <&vcc3v3_sys>;
> +		vcc5-supply = <&vcc3v3_sys>;
> +		vcc6-supply = <&vcc3v3_sys>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc3v3_sys>;
> +		wakeup-source;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-name = "vdd_logic";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_gpu: DCDC_REG2 {
> +				regulator-name = "vdd_gpu";
> +				regulator-always-on;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu: DCDC_REG4 {
> +				regulator-name = "vdd_npu";
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: DCDC_REG5 {
> +				regulator-name = "vcc_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_image: LDO_REG1 {
> +				regulator-name = "vdda0v9_image";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v9: LDO_REG2 {
> +				regulator-name = "vdda_0v9";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_pmu: LDO_REG3 {
> +				regulator-name = "vdda0v9_pmu";
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
> +
> +			vccio_acodec: LDO_REG4 {
> +				regulator-name = "vccio_acodec";
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-name = "vccio_sd";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_pmu: LDO_REG6 {
> +				regulator-name = "vcc3v3_pmu";
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
> +			vcca_1v8: LDO_REG7 {
> +				regulator-name = "vcca_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pmu: LDO_REG8 {
> +				regulator-name = "vcca1v8_pmu";
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
> +			vcca1v8_image: LDO_REG9 {
> +				regulator-name = "vcca1v8_image";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: SWITCH_REG1 {
> +				regulator-name = "vcc_3v3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_sd: SWITCH_REG2 {
> +				regulator-name = "vcc3v3_sd";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +
> +		codec {
> +			rockchip,mic-in-differential;
> +		};
> +	};
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +
> +	rtc@51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +&i2s0_8ch {
> +	status = "okay";
> +};
> +
> +&i2s1_8ch {
> +	pinctrl-0 = <&i2s1m0_sclktx &i2s1m0_lrcktx &i2s1m0_sdi0 &i2s1m0_sdo0>;
> +	rockchip,trcm-sync-tx-only;
> +	status = "okay";
> +};
> +
> +/* used for AP6275S Bluetooth Sound */
> +&i2s3_2ch {
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	rgmii_phy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x0>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
> +
> +		leds {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			led@1 {
> +				reg = <1>;
> +				color = <LED_COLOR_ID_GREEN>;
> +				function = LED_FUNCTION_LAN;
> +				default-state = "keep";
> +			};
> +
> +			led@2 {
> +				reg = <2>;
> +				color = <LED_COLOR_ID_AMBER>;
> +				function = LED_FUNCTION_LAN;
> +				default-state = "keep";
> +			};
> +		};
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x0>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_LOW>;
> +
> +		leds {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			led@1 {
> +				reg = <1>;
> +				color = <LED_COLOR_ID_GREEN>;
> +				function = LED_FUNCTION_LAN;
> +				default-state = "keep";
> +			};
> +
> +			led@2 {
> +				reg = <2>;
> +				color = <LED_COLOR_ID_AMBER>;
> +				function = LED_FUNCTION_LAN;
> +				default-state = "keep";
> +			};
> +		};
> +	};
> +};
> +
> +&pcie30phy {
> +	status = "okay";
> +};
> +
> +&pcie3x2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_reset_pin>;
> +	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie>;
> +	status = "okay";
> +};
> +
> +&pdm {
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	leds {
> +		led_work_en: led_work_en {
> +			rockchip,pins = <0 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int: pmic_int {
> +			rockchip,pins =
> +				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	sdio-pwrseq {
> +		wifi_enable: wifi-enable {
> +			rockchip,pins = <3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
> +			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie {
> +		pcie_reset_pin: pcie-reset-pin {
> +			rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +		vcc3v3_pcie_en_pin: vcc3v3-pcie-en-pin {
> +			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc3v3_pmu>;
> +	pmuio2-supply = <&vcc3v3_pmu>;
> +	vccio1-supply = <&vccio_acodec>;
> +	vccio2-supply = <&vcc_1v8>;
> +	vccio3-supply = <&vccio_sd>;
> +	vccio4-supply = <&vcc_1v8>;
> +	vccio5-supply = <&vcc_3v3>;
> +	vccio6-supply = <&vcc_1v8>;
> +	vccio7-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> +
> +&pwm4 {
> +	status = "okay";
> +};
> +
> +/* Required remotectl for IR receiver */
> +&pwm7 {
> +	status = "disabled";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcca_1v8>;
> +	status = "okay";
> +};
> +
> +&sata2 {
> +	status = "okay";
> +};
> +
> +/* used for eMMC */
> +&sdhci {
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> +	status = "okay";
> +};
> +
> +/* used for microSD (TF) Slot */
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +/* used for AP6275S WiFi */
> +&sdmmc2 {
> +	bus-width = <4>;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc2m0_bus4 &sdmmc2m0_cmd &sdmmc2m0_clk>;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_sys>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&spdif {
> +	status = "okay";
> +};
> +
> +&tsadc {
> +	rockchip,hw-tshut-mode = <1>;
> +	rockchip,hw-tshut-polarity = <0>;
> +	status = "okay";
> +};
> +
> +/* used for Debug */
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-0 = <&uart3m1_xfer>;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-0 = <&uart4m1_xfer>;
> +	status = "okay";
> +};
> +
> +/* used for WiFi/BT AP6275S */
> +&uart8 {
> +	pinctrl-0 = <&uart8m0_xfer &uart8m0_ctsn>;
> +	status = "okay";
> +};
> +
> +&uart9 {
> +	pinctrl-0 = <&uart9m1_xfer>;
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	extcon = <&usb2phy0>;
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_xhci {
> +	status = "okay";
> +};
> +
> +&usb2phy0 {
> +	status = "okay";
> +};
> +
> +&usb2phy0_host {
> +	phy-supply = <&vcc5v0_usb_host>;
> +	status = "okay";
> +};
> +
> +&usb2phy0_otg {
> +	phy-supply = <&vcc5v0_usb_otg>;
> +	status = "okay";
> +};
> +
> +&usb2phy1 {
> +	status = "okay";
> +};
> +
> +&usb2phy1_host {
> +	phy-supply = <&vcc5v0_usb_host>;
> +	status = "okay";
> +};
> +
> +&usb2phy1_otg {
> +	phy-supply = <&vcc5v0_usb_host>;
> +	status = "okay";
> +};
> +
> +&vop {
> +	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
> +	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
> +	status = "okay";
> +};
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi_in_vp0>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso b/arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso
> new file mode 100644
> index 000000000..f819eff8f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +
> +// This is a sample reference, due to lack of hardware can not be tested, at your own risk
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/clock/rk3568-cru.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +
> +&{/} {	
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		brightness-levels = <20 220>;
> +		default-brightness-level = <100>;
> +		num-interpolated-steps = <200>;
> +		power-supply = <&vcc3v3_sys>;
> +		pwms = <&pwm4 0 25000 0>;
> +	};
> +
> +	vcc3v3_lcd0_n: regulator-vcc3v3-lcd0-n {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_lcd0_n";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&vcc3v3_sys>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc3v3_lcd0_n_en>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vcc3v3_lcd1_n: regulator-vcc3v3-lcd1-n {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_lcd1_n";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&vcc3v3_sys>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc3v3_lcd1_n_en>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	display {
> +		vcc3v3_lcd0_n_en: vcc3v3_lcd0_n_en {
> +			rockchip,pins = <0 RK_PC7 0 &pcfg_pull_none>;
> +		};
> +		vcc3v3_lcd1_n_en: vcc3v3_lcd1_n_en {
> +			rockchip,pins = <0 RK_PC5 0 &pcfg_pull_none>;
> +		};
> +	};
> +
> +	touchscreen {
> +		touch_int: touch_int {
> +			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +		touch_rst: touch_rst {
> +			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&dsi0 {
> +	clock-master;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "wanchanglong,w552793baa", "raydium,rm67200";
> +		reg = <0>;
> +		backlight = <&backlight>;
> +		iovcc-supply = <&vcc3v3_lcd0_n>;
> +		reset-gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&vcc3v3_lcd0_n>;
> +		vsn-supply = <&vcc5v0_sys>;
> +		vsp-supply = <&vcc5v0_sys>;
> +
> +		port {
> +			panel_in_dsi: endpoint {
> +				remote-endpoint = <&dsi0_out_panel>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsi0_in {
> +	dsi0_in_vp1: endpoint {
> +		remote-endpoint = <&vp1_out_dsi0>;
> +	};
> +};
> +
> +&dsi0_out {
> +	dsi0_out_panel: endpoint {
> +		remote-endpoint = <&panel_in_dsi>;
> +	};
> +};
> +
> +&dsi_dphy0 {
> +	status = "okay";
> +};
> +
> +&pwm4 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	touchscreen0: goodix@14 {
> +		compatible = "goodix,gt1151";
> +		reg = <0x14>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB5 IRQ_TYPE_EDGE_FALLING>;
> +		AVDD28-supply = <&vcc3v3_lcd0_n>;
> +		irq-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touch_int &touch_rst>;
> +		reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
> +		VDDIO-supply = <&vcc3v3_lcd0_n>;
> +	};
> +};
> +
> +&vp1 {
> +	vp1_out_dsi0: endpoint@ROCKCHIP_VOP2_EP_MIPI0 {
> +		reg = <ROCKCHIP_VOP2_EP_MIPI0>;
> +		remote-endpoint = <&dsi0_in_vp1>;
> +	};
> +};



Return-Path: <linux-kernel+bounces-874977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42007C17EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82E274F2475
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76842DE70E;
	Wed, 29 Oct 2025 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TpGbWhyP"
Received: from mail-m155105.qiye.163.com (mail-m155105.qiye.163.com [101.71.155.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7C27F00A;
	Wed, 29 Oct 2025 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701752; cv=none; b=KsKOiphcvUoD7o1lSsBVNCSaju1WRELBFZhjnHLOy3QTFjVddg4XQyoVCIkaIuz1N3lvPG6QlGg9plKbsqlII9WQBzN/kAZg9BDUg/3dLalHOik0SUklEKczPtysShewaWDOybEyLIGBlfsm2zU/6hb1bX62akLb0B5A26KUqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701752; c=relaxed/simple;
	bh=3B+Fos6fd6sYK1MkTO82hheH4XnvCaSox0gYF0AFEWI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eQUca1+9FuD4CoAmBdGO6H0ghZHfKgqVOsjQmpPbkv3E0ecOD4r9vmO0nOnf0wrsk4LdMGFLBuzVaGdISBv1Rd8NGsQegD/Hkkl+UqHrNegPk1WzHMyy+fyIn3W1AjTRzUoNu87MPlkltmnFZfJvNcKwzn3IJkqrKb0fP8PXfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TpGbWhyP; arc=none smtp.client-ip=101.71.155.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 278a781bf;
	Wed, 29 Oct 2025 08:20:03 +0800 (GMT+08:00)
Message-ID: <cfb5dc7f-c7f9-459f-9565-bbacabb86cb3@rock-chips.com>
Date: Wed, 29 Oct 2025 08:20:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add devicetree for the X3568 v4
To: Coia Prant <coiaprant@gmail.com>
References: <fb7c9db4-fb22-4145-84f4-49d7e53d17fb@rock-chips.com>
 <CALj3r0imfd1tUSdAN4ChRr_=q6BQEXgFeJPuq_a=g+RBYL-8hg@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CALj3r0imfd1tUSdAN4ChRr_=q6BQEXgFeJPuq_a=g+RBYL-8hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2d56060809cckunmf9c117ea252402
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhJQlZPTB9MHhlKH0JJShhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TpGbWhyPZdgcC/ITEmC+vLp6wA6V/8tJ6gIRJDGGZz7ycB7Iccv3QMpyFH+EOx1mmMKN7HkudvQvX0TVIPT5S3Yx4lRMLBw/0HAxzBlcamcKbOrhiSYawgPPZc+NXICLlIeFo9eeCRVOGihw0b/VU/ej9FMGwg+gJ4Ip+sKRNOc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=H4WujUpT/snsS4Vf3kev+9BslRZRxWrsrkb0pCImRRc=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/28 星期二 12:03, Coia Prant 写道:
> hmmmm
> I think my board doesn't have PCIe clk.
> It works fine.
> 
> The OEM documentation does say that, and they provide nopcie and pcie images
> 
> This is my dmesg for your reference
> 
> [    0.336879] phy phy-fe8c0000.phy.7: rockchip_p3phy_rk3568_init:
> lock failed 0x6890000, check input refclk and power supply
> [    0.338587] rockchip-dw-pcie: probe of 3c0800000.pcie failed with error -110
> 

It should work if only clk is missing.

My preset scenario is that you mentioned it doesn't have a slot
installed, the missing part includes PHY power supply, which should
block the boot if enabling.

> 2025-10-28 11:36 (GMT+08:00), Shawn Lin <shawn.lin@rock-chips.com> said:
>> 在 2025/10/26 星期日 4:37, Coia Prant 写道:
>> Specification:
>> - SoC: RockChip RK3568 ARM64 (4 cores)
>> - eMMC: 16-128 GB
>> - RAM: 2-8 GB
>> - Power: DC 12V 2A
>> - Ethernet: 2x YT8521SC RGMII (10/100/1000 Mbps)
>> - Wireless radio: 802.11b/g/n/ac/ax dual-band
>> - LED:
>> Power: AlwaysOn
>> User: GPIO
>> - Button:
>> VOL+: SARADC/0
>> VOL-: SARADC/0
>> Power/Reset: PMIC RK809
>> - CAN
>> CAN/1: 4-pin (PH 2.0)
>> - PWM
>> PWM/4: Backlight DSI/0 DSI/1
>> PWM/7: IR Receiver [may not install]
>> - UART:
>> UART/2: Debug TTL - 1500000 8N1 (1.25mm)
>> UART/3: TTL (PH 2.0)
>> UART/4: TTL (PH 2.0)
>> UART/8: AP6275S Bluetooth
>> UART/9: TTL (PH 2.0)
>> - I2C:
>> I2C/0: PMIC RK809
>> I2C/1: Touchscreen DSI/0 DSI/1
>> I2C/4: Camera
>> I2C/5: RTC@51 PCF8563
>> - I2S:
>> I2S/0: miniHDMI Sound
>> I2S/1: RK809 Audio Codec
>> I2S/3: AP6275S Bluetooth Sound
>> - SDMMC:
>> SDMMC/0: microSD (TF) slot
>> SDMMC/2: AP6275S SDIO WiFi card
>> - Camera: 1x CSI
>> - Video: miniHDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
>> - Audio: miniHDMI / MIC on-board / Speaker / SPDIF / 3.5mm Headphones / AP6275S
>> Bluetooth
>> - USB:
>> USB 2.0 HOST x2
>> USB 2.0 HOST x3 (4-pin)
>> USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST) [slot may not install]
>> USB 3.0 HOST x1
>> USB 3.0 OTG/HOST x1
>> - SATA: 1x SATA 3.0 with Power/4-pin [slot may not install]
>> - PCIe: 1x PCIe 3.0 x2 (x4 connecter) [clock/slot may not install]
>> A side note: AFAICT, if clock may not be installed, you shouldn't
>> enable pcie3x2 or pcie3x4.. Otherwise it can't boot at all..
>>
>> Link:
>> -
>> https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
>> - https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flash.html
>>
>> Signed-off-by: Coia Prant
>> Tested-by: Coia Prant
>> ---
>> arch/arm64/boot/dts/rockchip/Makefile         |  11 +
>> .../rockchip/rk3568-x3568-camera-demo.dtso    |  82 ++
>> .../boot/dts/rockchip/rk3568-x3568-v4.dts     | 884 ++++++++++++++++++
>> .../dts/rockchip/rk3568-x3568-video-demo.dtso | 141 +++
>> 4 files changed, 1118 insertions(+)
>> create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso
>> create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
>> create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile
>> b/arch/arm64/boot/dts/rockchip/Makefile
>> index ad684e383..ea36334bb 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -150,6 +150,9 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3b.dtb
>> dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
>> dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
>> dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-x3568-v4.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-x3568-camera-demo.dtso
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-x3568-video-demo.dtso
>> dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5.dtb
>> dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5-v1.2-wifibt.dtbo
>> dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-evb1-v10.dtb
>> @@ -252,6 +255,14 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=
>> rk3576-armsom-sige5-v1.2-wifibt.dtb
>> rk3576-armsom-sige5-v1.2-wifibt-dtbs := rk3576-armsom-sige5.dtb \
>> rk3576-armsom-sige5-v1.2-wifibt.dtbo
>>
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-x3568-v4-camera-demo.dtb
>> +rk3568-x3568-v4-camera-demo-dtbs := rk3568-x3568-v4.dtb \
>> +	rk3568-x3568-camera-demo.dtso
>> +
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-x3568-v4-video-demo.dtb
>> +rk3568-x3568-v4-video-demo-dtbs := rk3568-x3568-v4.dtb \
>> +	rk3568-x3568-video-demo.dtso
>> +
>> dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-wifi.dtb
>> rk3588-edgeble-neu6a-wifi-dtbs := rk3588-edgeble-neu6a-io.dtb \
>> rk3588-edgeble-neu6a-wifi.dtbo
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso
>> b/arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso
>> new file mode 100644
>> index 000000000..b144d0010
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso
>> @@ -0,0 +1,82 @@
>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
>> +
>> +// This is a sample reference, due to lack of hardware can not be tested, at
>> your own risk
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include
>> +#include
>> +#include
>> +
>> +&amp;{/} {
>> +	vcc_cam: regulator-vcc-cam {
>> +		compatible = "regulator-fixed";
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		enable-active-high;
>> +		gpio = ;
>> +		regulator-name = "vcc_cam";
>> +		vin-supply = ;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = ;
>> +
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +};
>> +
>> +&amp;pinctrl {
>> +	cam {
>> +		vcc_cam_en: vcc_cam_en {
>> +			rockchip,pins =	;
>> +		};
>> +	};
>> +};
>> +
>> +&amp;csi_dphy {
>> +	status = "okay";
>> +
>> +	ports {
>> +		#address-cells = ;
>> +		#size-cells = ;
>> +
>> +		port@0 {
>> +			reg = ;
>> +			#address-cells = ;
>> +			#size-cells = ;
>> +
>> +			mipi_in_ucam: endpoint@2 {
>> +				reg = ;
>> +				remote-endpoint = ;
>> +				data-lanes = ;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&amp;i2c4 {
>> +	status = "okay";
>> +
>> +	camera@37 {
>> +		compatible = "ovti,ov5695";
>> +		reg = ;
>> +		clocks = ;
>> +		clock-names = "xvclk";
>> +		avdd-supply = ;
>> +		dvdd-supply = ;
>> +		dovdd-supply = ;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = ;
>> +		reset-gpios = ;
>> +		pwdn-gpios = ;
>> +
>> +		port {
>> +			ucam_out: endpoint {
>> +				remote-endpoint = ;
>> +				data-lanes = ;
>> +			};
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
>> b/arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
>> new file mode 100644
>> index 000000000..901735c6f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
>> @@ -0,0 +1,884 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +#include
>> +#include
>> +#include
>> +#include
>> +#include
>> +#include "rk3568.dtsi"
>> +
>> +/ {
>> +	model = "NineTripod X3568 v4";
>> +	compatible = "ninetripod,x3568-v4", "rockchip,rk3568";
>> +
>> +	aliases {
>> +		ethernet0 = &amp;gmac0;
>> +		ethernet1 = &amp;gmac1;
>> +		mmc0 = &amp;sdhci;
>> +		mmc1 = &amp;sdmmc0;
>> +		mmc2 = &amp;sdmmc2;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial2:1500000n8";
>> +	};
>> +
>> +	adc-keys {
>> +		compatible = "adc-keys";
>> +		io-channels = ;
>> +		io-channel-names = "buttons";
>> +		keyup-threshold-microvolt = ;
>> +		poll-interval = ;
>> +
>> +		button-vol-up {
>> +			label = "volume up";
>> +			linux,code = ;
>> +			press-threshold-microvolt = ;
>> +		};
>> +
>> +		button-vol-down {
>> +			label = "volume down";
>> +			linux,code = ;
>> +			press-threshold-microvolt = ;
>> +		};
>> +	};
>> +
>> +	hdmi-con {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_con_in: endpoint {
>> +				remote-endpoint = ;
>> +			};
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		led_work: led-0 {
>> +			gpios = ;
>> +			function = LED_FUNCTION_HEARTBEAT;
>> +			color = ;
>> +			linux,default-trigger = "heartbeat";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = ;
>> +		};
>> +	};
>> +
>> +	rk809-sound {
>> +		compatible = "simple-audio-card";
>> +		simple-audio-card,format = "i2s";
>> +		simple-audio-card,name = "Analog RK809";
>> +		simple-audio-card,mclk-fs = ;
>> +
>> +		simple-audio-card,cpu {
>> +			sound-dai = ;
>> +		};
>> +		simple-audio-card,codec {
>> +			sound-dai = ;
>> +		};
>> +	};
>> +
>> +	pdm_codec: pdm-codec {
>> +		compatible = "dmic-codec";
>> +		num-channels = ;
>> +		#sound-dai-cells = ;
>> +	};
>> +
>> +	pdm_sound: pdm-sound {
>> +		compatible = "simple-audio-card";
>> +		simple-audio-card,name = "microphone";
>> +
>> +		simple-audio-card,cpu {
>> +			sound-dai = ;
>> +		};
>> +
>> +		simple-audio-card,codec {
>> +			sound-dai = ;
>> +		};
>> +	};
>> +
>> +	spdif_dit: spdif-dit {
>> +		compatible = "linux,spdif-dit";
>> +		#sound-dai-cells = ;
>> +	};
>> +
>> +	spdif_sound: spdif-sound {
>> +		compatible = "simple-audio-card";
>> +		simple-audio-card,name = "SPDIF";
>> +
>> +		simple-audio-card,cpu {
>> +			sound-dai = ;
>> +		};
>> +		simple-audio-card,codec {
>> +			sound-dai = ;
>> +		};
>> +	};
>> +
>> +	sdio_pwrseq: sdio-pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		clocks = ;
>> +		clock-names = "ext_clock";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = ;
>> +		post-power-on-delay-ms = ;
>> +		power-off-delay-us = ;
>> +		reset-gpios = ;
>> +	};
>> +
>> +	dc_12v: regulator-dc-12v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "dc_12v";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +	};
>> +
>> +	pcie30_avdd0v9: regulator-pcie30-avdd0v9 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "pcie30_avdd0v9";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		vin-supply = ;
>> +	};
>> +
>> +	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "pcie30_avdd1v8";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		vin-supply = ;
>> +	};
>> +
>> +	vcc3v3_sys: regulator-vcc3v3-sys {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc3v3_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		vin-supply = ;
>> +	};
>> +
>> +	vcc3v3_pcie: regulator-vcc3v3-pcie {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc3v3_pcie";
>> +		enable-active-high;
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = ;
>> +		gpio = ;
>> +		startup-delay-us = ;
>> +		vin-supply = ;
>> +	};
>> +
>> +	vcc5v0_sys: regulator-vcc5v0-sys {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		vin-supply = ;
>> +	};
>> +
>> +	vcc5v0_usb: regulator-vcc5v0-usb {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_usb";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		vin-supply = ;
>> +	};
>> +
>> +	vcc5v0_usb_host: regulator-vcc5v0-usb-host {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = ;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = ;
>> +		regulator-name = "vcc5v0_usb_host";
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		vin-supply = ;
>> +	};
>> +
>> +	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = ;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = ;
>> +		regulator-name = "vcc5v0_usb_otg";
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		vin-supply = ;
>> +	};
>> +};
>> +
>> +&amp;can1 {
>> +	assigned-clocks = ;
>> +	assigned-clock-rates = ;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = ;
>> +	status = "okay";
>> +};
>> +
>> +/* used for usb_host0_xhci */
>> +&amp;combphy0 {
>> +	status = "okay";
>> +};
>> +
>> +/* used for usb_host1_xhci */
>> +&amp;combphy1 {
>> +	status = "okay";
>> +};
>> +
>> +/* connected to sata2 */
>> +&amp;combphy2 {
>> +	status = "okay";
>> +};
>> +
>> +&amp;cpu0 {
>> +	cpu-supply = ;
>> +};
>> +
>> +&amp;cpu1 {
>> +	cpu-supply = ;
>> +};
>> +
>> +&amp;cpu2 {
>> +	cpu-supply = ;
>> +};
>> +
>> +&amp;cpu3 {
>> +	cpu-supply = ;
>> +};
>> +
>> +&amp;gmac0 {
>> +	assigned-clocks = , ;
>> +	assigned-clock-parents = ;
>> +	assigned-clock-rates = , ;
>> +	clock_in_out = "output";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 =  +			&amp;gmac0_tx_bus2
>> +			&amp;gmac0_rx_bus2
>> +			&amp;gmac0_rgmii_clk
>> +			&amp;gmac0_rgmii_bus
>> +			&amp;gmac0_clkinout;
>> +	phy-handle = ;
>> +	phy-mode = "rgmii-id";
>> +	status = "okay";
>> +};
>> +
>> +&amp;gmac1 {
>> +	assigned-clocks = , ;
>> +	assigned-clock-parents = ;
>> +	assigned-clock-rates = , ;
>> +	clock_in_out = "output";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 =  +			&amp;gmac1m1_tx_bus2
>> +			&amp;gmac1m1_rx_bus2
>> +			&amp;gmac1m1_rgmii_clk
>> +			&amp;gmac1m1_rgmii_bus
>> +			&amp;gmac1m1_clkinout;
>> +	phy-handle = ;
>> +	phy-mode = "rgmii-id";
>> +	status = "okay";
>> +};
>> +
>> +&amp;gpu {
>> +	mali-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;hdmi {
>> +	avdd-0v9-supply = ;
>> +	avdd-1v8-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;hdmi_in {
>> +	hdmi_in_vp0: endpoint {
>> +		remote-endpoint = ;
>> +	};
>> +};
>> +
>> +&amp;hdmi_out {
>> +	hdmi_out_con: endpoint {
>> +		remote-endpoint = ;
>> +	};
>> +};
>> +
>> +&amp;hdmi_sound {
>> +	status = "okay";
>> +};
>> +
>> +&amp;i2c0 {
>> +	status = "okay";
>> +
>> +	vdd_cpu: regulator@1c {
>> +		compatible = "tcs,tcs4525";
>> +		reg = ;
>> +		fcs,suspend-voltage-selector = ;
>> +		regulator-name = "vdd_cpu";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		regulator-ramp-delay = ;
>> +		vin-supply = ;
>> +
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +
>> +	rk809: pmic@20 {
>> +		compatible = "rockchip,rk809";
>> +		reg = ;
>> +		interrupt-parent = ;
>> +		interrupts = ;
>> +		assigned-clocks = ;
>> +		assigned-clock-parents = ;
>> +		#clock-cells = ;
>> +		clock-names = "mclk";
>> +		clocks = ;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = , ;
>> +		system-power-controller;
>> +		#sound-dai-cells = ;
>> +		vcc1-supply = ;
>> +		vcc2-supply = ;
>> +		vcc3-supply = ;
>> +		vcc4-supply = ;
>> +		vcc5-supply = ;
>> +		vcc6-supply = ;
>> +		vcc7-supply = ;
>> +		vcc8-supply = ;
>> +		vcc9-supply = ;
>> +		wakeup-source;
>> +
>> +		regulators {
>> +			vdd_logic: DCDC_REG1 {
>> +				regulator-name = "vdd_logic";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-initial-mode = ;
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +				regulator-ramp-delay = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_gpu: DCDC_REG2 {
>> +				regulator-name = "vdd_gpu";
>> +				regulator-always-on;
>> +				regulator-initial-mode = ;
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +				regulator-ramp-delay = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_ddr: DCDC_REG3 {
>> +				regulator-name = "vcc_ddr";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-initial-mode = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_npu: DCDC_REG4 {
>> +				regulator-name = "vdd_npu";
>> +				regulator-initial-mode = ;
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +				regulator-ramp-delay = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_1v8: DCDC_REG5 {
>> +				regulator-name = "vcc_1v8";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdda0v9_image: LDO_REG1 {
>> +				regulator-name = "vdda0v9_image";
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdda_0v9: LDO_REG2 {
>> +				regulator-name = "vdda_0v9";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdda0v9_pmu: LDO_REG3 {
>> +				regulator-name = "vdda0v9_pmu";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = ;
>> +				};
>> +			};
>> +
>> +			vccio_acodec: LDO_REG4 {
>> +				regulator-name = "vccio_acodec";
>> +				regulator-always-on;
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vccio_sd: LDO_REG5 {
>> +				regulator-name = "vccio_sd";
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc3v3_pmu: LDO_REG6 {
>> +				regulator-name = "vcc3v3_pmu";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = ;
>> +				};
>> +			};
>> +
>> +			vcca_1v8: LDO_REG7 {
>> +				regulator-name = "vcca_1v8";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcca1v8_pmu: LDO_REG8 {
>> +				regulator-name = "vcca1v8_pmu";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = ;
>> +				};
>> +			};
>> +
>> +			vcca1v8_image: LDO_REG9 {
>> +				regulator-name = "vcca1v8_image";
>> +				regulator-min-microvolt = ;
>> +				regulator-max-microvolt = ;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_3v3: SWITCH_REG1 {
>> +				regulator-name = "vcc_3v3";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc3v3_sd: SWITCH_REG2 {
>> +				regulator-name = "vcc3v3_sd";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +		};
>> +
>> +		codec {
>> +			rockchip,mic-in-differential;
>> +		};
>> +	};
>> +};
>> +
>> +&amp;i2c5 {
>> +	status = "okay";
>> +
>> +	rtc@51 {
>> +		compatible = "nxp,pcf8563";
>> +		reg = ;
>> +		#clock-cells = ;
>> +	};
>> +};
>> +
>> +&amp;i2s0_8ch {
>> +	status = "okay";
>> +};
>> +
>> +&amp;i2s1_8ch {
>> +	pinctrl-0 = ;
>> +	rockchip,trcm-sync-tx-only;
>> +	status = "okay";
>> +};
>> +
>> +/* used for AP6275S Bluetooth Sound */
>> +&amp;i2s3_2ch {
>> +	status = "okay";
>> +};
>> +
>> +&amp;mdio0 {
>> +	rgmii_phy0: ethernet-phy@0 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
>> +		reg = ;
>> +		reset-assert-us = ;
>> +		reset-deassert-us = ;
>> +		reset-gpios = ;
>> +
>> +		leds {
>> +			#address-cells = ;
>> +			#size-cells = ;
>> +
>> +			led@1 {
>> +				reg = ;
>> +				color = ;
>> +				function = LED_FUNCTION_LAN;
>> +				default-state = "keep";
>> +			};
>> +
>> +			led@2 {
>> +				reg = ;
>> +				color = ;
>> +				function = LED_FUNCTION_LAN;
>> +				default-state = "keep";
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&amp;mdio1 {
>> +	rgmii_phy1: ethernet-phy@0 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
>> +		reg = ;
>> +		reset-assert-us = ;
>> +		reset-deassert-us = ;
>> +		reset-gpios = ;
>> +
>> +		leds {
>> +			#address-cells = ;
>> +			#size-cells = ;
>> +
>> +			led@1 {
>> +				reg = ;
>> +				color = ;
>> +				function = LED_FUNCTION_LAN;
>> +				default-state = "keep";
>> +			};
>> +
>> +			led@2 {
>> +				reg = ;
>> +				color = ;
>> +				function = LED_FUNCTION_LAN;
>> +				default-state = "keep";
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&amp;pcie30phy {
>> +	status = "okay";
>> +};
>> +
>> +&amp;pcie3x2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = ;
>> +	reset-gpios = ;
>> +	vpcie3v3-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;pdm {
>> +	status = "okay";
>> +};
>> +
>> +&amp;pinctrl {
>> +	leds {
>> +		led_work_en: led_work_en {
>> +			rockchip,pins = ;
>> +		};
>> +	};
>> +
>> +	pmic {
>> +		pmic_int: pmic_int {
>> +			rockchip,pins =
>> +				;
>> +		};
>> +	};
>> +
>> +	sdio-pwrseq {
>> +		wifi_enable: wifi-enable {
>> +			rockchip,pins = ;
>> +		};
>> +	};
>> +
>> +	usb {
>> +		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
>> +			rockchip,pins = ;
>> +		};
>> +		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
>> +			rockchip,pins = ;
>> +		};
>> +	};
>> +
>> +	pcie {
>> +		pcie_reset_pin: pcie-reset-pin {
>> +			rockchip,pins = ;
>> +		};
>> +		vcc3v3_pcie_en_pin: vcc3v3-pcie-en-pin {
>> +			rockchip,pins = ;
>> +		};
>> +	};
>> +};
>> +
>> +&amp;pmu_io_domains {
>> +	pmuio1-supply = ;
>> +	pmuio2-supply = ;
>> +	vccio1-supply = ;
>> +	vccio2-supply = ;
>> +	vccio3-supply = ;
>> +	vccio4-supply = ;
>> +	vccio5-supply = ;
>> +	vccio6-supply = ;
>> +	vccio7-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;pwm4 {
>> +	status = "okay";
>> +};
>> +
>> +/* Required remotectl for IR receiver */
>> +&amp;pwm7 {
>> +	status = "disabled";
>> +};
>> +
>> +&amp;saradc {
>> +	vref-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;sata2 {
>> +	status = "okay";
>> +};
>> +
>> +/* used for eMMC */
>> +&amp;sdhci {
>> +	bus-width = ;
>> +	max-frequency = ;
>> +	mmc-hs200-1_8v;
>> +	non-removable;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = ;
>> +	status = "okay";
>> +};
>> +
>> +/* used for microSD (TF) Slot */
>> +&amp;sdmmc0 {
>> +	bus-width = ;
>> +	cap-sd-highspeed;
>> +	cd-gpios = ;
>> +	disable-wp;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = ;
>> +	sd-uhs-sdr104;
>> +	vmmc-supply = ;
>> +	vqmmc-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +/* used for AP6275S WiFi */
>> +&amp;sdmmc2 {
>> +	bus-width = ;
>> +	disable-wp;
>> +	cap-sd-highspeed;
>> +	cap-sdio-irq;
>> +	keep-power-in-suspend;
>> +	mmc-pwrseq = ;
>> +	non-removable;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = ;
>> +	sd-uhs-sdr12;
>> +	sd-uhs-sdr25;
>> +	sd-uhs-sdr50;
>> +	sd-uhs-sdr104;
>> +	vmmc-supply = ;
>> +	vqmmc-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;spdif {
>> +	status = "okay";
>> +};
>> +
>> +&amp;tsadc {
>> +	rockchip,hw-tshut-mode = ;
>> +	rockchip,hw-tshut-polarity = ;
>> +	status = "okay";
>> +};
>> +
>> +/* used for Debug */
>> +&amp;uart2 {
>> +	status = "okay";
>> +};
>> +
>> +&amp;uart3 {
>> +	pinctrl-0 = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;uart4 {
>> +	pinctrl-0 = ;
>> +	status = "okay";
>> +};
>> +
>> +/* used for WiFi/BT AP6275S */
>> +&amp;uart8 {
>> +	pinctrl-0 = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;uart9 {
>> +	pinctrl-0 = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb_host0_ehci {
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb_host0_ohci {
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb_host0_xhci {
>> +	extcon = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb_host1_ehci {
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb_host1_ohci {
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb_host1_xhci {
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb2phy0 {
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb2phy0_host {
>> +	phy-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb2phy0_otg {
>> +	phy-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb2phy1 {
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb2phy1_host {
>> +	phy-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;usb2phy1_otg {
>> +	phy-supply = ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;vop {
>> +	assigned-clocks = , ;
>> +	assigned-clock-parents = , ;
>> +	status = "okay";
>> +};
>> +
>> +&amp;vop_mmu {
>> +	status = "okay";
>> +};
>> +
>> +&amp;vp0 {
>> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>> +		reg = ;
>> +		remote-endpoint = ;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso
>> b/arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso
>> new file mode 100644
>> index 000000000..f819eff8f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso
>> @@ -0,0 +1,141 @@
>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
>> +
>> +// This is a sample reference, due to lack of hardware can not be tested, at
>> your own risk
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include
>> +#include
>> +#include
>> +
>> +&amp;{/} {
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		brightness-levels = ;
>> +		default-brightness-level = ;
>> +		num-interpolated-steps = ;
>> +		power-supply = ;
>> +		pwms = ;
>> +	};
>> +
>> +	vcc3v3_lcd0_n: regulator-vcc3v3-lcd0-n {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc3v3_lcd0_n";
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		enable-active-high;
>> +		gpio = ;
>> +		vin-supply = ;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = ;
>> +
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +
>> +	vcc3v3_lcd1_n: regulator-vcc3v3-lcd1-n {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc3v3_lcd1_n";
>> +		regulator-min-microvolt = ;
>> +		regulator-max-microvolt = ;
>> +		enable-active-high;
>> +		gpio = ;
>> +		vin-supply = ;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = ;
>> +
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +};
>> +
>> +&amp;pinctrl {
>> +	display {
>> +		vcc3v3_lcd0_n_en: vcc3v3_lcd0_n_en {
>> +			rockchip,pins = ;
>> +		};
>> +		vcc3v3_lcd1_n_en: vcc3v3_lcd1_n_en {
>> +			rockchip,pins = ;
>> +		};
>> +	};
>> +
>> +	touchscreen {
>> +		touch_int: touch_int {
>> +			rockchip,pins = ;
>> +		};
>> +		touch_rst: touch_rst {
>> +			rockchip,pins = ;
>> +		};
>> +	};
>> +};
>> +
>> +&amp;dsi0 {
>> +	clock-master;
>> +	#address-cells = ;
>> +	#size-cells = ;
>> +	status = "okay";
>> +
>> +	panel@0 {
>> +		compatible = "wanchanglong,w552793baa", "raydium,rm67200";
>> +		reg = ;
>> +		backlight = ;
>> +		iovcc-supply = ;
>> +		reset-gpios = ;
>> +		vdd-supply = ;
>> +		vsn-supply = ;
>> +		vsp-supply = ;
>> +
>> +		port {
>> +			panel_in_dsi: endpoint {
>> +				remote-endpoint = ;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&amp;dsi0_in {
>> +	dsi0_in_vp1: endpoint {
>> +		remote-endpoint = ;
>> +	};
>> +};
>> +
>> +&amp;dsi0_out {
>> +	dsi0_out_panel: endpoint {
>> +		remote-endpoint = ;
>> +	};
>> +};
>> +
>> +&amp;dsi_dphy0 {
>> +	status = "okay";
>> +};
>> +
>> +&amp;pwm4 {
>> +	status = "okay";
>> +};
>> +
>> +&amp;i2c1 {
>> +	status = "okay";
>> +
>> +	touchscreen0: goodix@14 {
>> +		compatible = "goodix,gt1151";
>> +		reg = ;
>> +		interrupt-parent = ;
>> +		interrupts = ;
>> +		AVDD28-supply = ;
>> +		irq-gpios = ;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = ;
>> +		reset-gpios = ;
>> +		VDDIO-supply = ;
>> +	};
>> +};
>> +
>> +&amp;vp1 {
>> +	vp1_out_dsi0: endpoint@ROCKCHIP_VOP2_EP_MIPI0 {
>> +		reg = ;
>> +		remote-endpoint = ;
>> +	};
>> +};
>>
> 



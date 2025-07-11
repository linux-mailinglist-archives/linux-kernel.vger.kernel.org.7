Return-Path: <linux-kernel+bounces-727123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E05AB01552
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083301C46671
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271C1F7554;
	Fri, 11 Jul 2025 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ah6cEsi+"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB961A0BE0;
	Fri, 11 Jul 2025 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220942; cv=none; b=GUKDAsjlomqHCZzkhwBtjZtj+/bN2XmL9tLx8RO4Q257Zfd01HuMfubHdZhDMRgpkjtNQn7AtdsgE03D+e13XVk1/NmOCIY4lsD/kVYeXPU0889PMo5vU5Aw2hDV0L96XKi8n4LvjWWtflX6kNoh6NYt6u++xt/ed3WgWRcqJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220942; c=relaxed/simple;
	bh=VE2lCCOi6rE2fup3Q3cdfzj12ujGs4bO3FlESNoXMKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK/1AZX2NAsejFgEyPwdhRrvi/nX3yayVkBXeJKhA0uGmeU/F3ywBu4psZr2ehhKfbz16B4Ug+5PJp6QnbugILhsEiZRUCVel1+5HQ4uXgaLm1q70H6ovpch4NXRh1jsO6XkqtznHBawgiuh5P00tqlQPF+8v9DhcuYd8Sy4WYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ah6cEsi+; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=SM7J3jSMrG/6U3kCP75eqDjxOiAC+I1mjsJl6VHyu3A=;
	b=ah6cEsi+aIrdsgZ/ngI+GlT8nPjCiinw2d93A7qMx49N18wXz9HOdMqCI9HSeS
	oLj8klKjSnk2j4JekK1c4Fdg7LfJU86Px/vAcCyvRr+peP44KbB1g3ex1STuWjSy
	bP2OKPfxVJD64C5NHo+aXg1p7bSej39zS3gEUIFPisSfI=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnDyHMxHBo8U5TAA--.57141S3;
	Fri, 11 Jul 2025 16:01:18 +0800 (CST)
Date: Fri, 11 Jul 2025 16:01:16 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: add description for solidrun imx8mp
 hummingboard variants
Message-ID: <aHDEzI6ggW8PevOR@dragon>
References: <20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com>
 <20250707-imx8mp-sr-som-v2-3-785814ef09a9@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-imx8mp-sr-som-v2-3-785814ef09a9@solid-run.com>
X-CM-TRANSID:Ms8vCgDnDyHMxHBo8U5TAA--.57141S3
X-Coremail-Antispam: 1Uf129KBjvAXoWftr4rZw1kAF48GF4rAw15XFb_yoW5GF45uo
	Wavrs5GrW8K34UJ3Zxtry7Cr1UA3Z3KF47tayDJrW3Ga10qFWaywnag3yUXr48try8tFyD
	G3yxGFyrCa12g3ykn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUFID7UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIg6aAGhwxM5ktwAA33

On Mon, Jul 07, 2025 at 07:11:58PM +0300, Josua Mayer wrote:
> Add descriptions for the SolidRun i.MX8M Plus System on Module based
> HummingBoard product-line. They share a common designed based on the
> "Pulse" version, defined by various assembly options.
> 
> The HummingBoard Pulse features:
> - 2x RJ45 Ethernet
> - 2x USB-3.0 Type A
> - HDMI connector
> - mini-HDMI connector
> - microSD connector
> - mini-PCI-E connector with SIM slot supporting USB-2.0/3.0 interfaces
> - M.2 connector with SIM slot supporting USB-2.0/3.0 interfaces
> - MIPI-CSI Camera Connector (not described without specific camera)
> - 3.5mm Analog Stereo Out / Microphone In Headphone Jack
> - RTC with backup battery
> 
> The variants Mate and Ripple are reduced versions of Pulse.
> 
> The HummingBoard Pro extends Pulse with PCI-E on M.2 connector.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   4 +
>  .../dts/freescale/imx8mp-hummingboard-mate.dts     |  31 ++
>  .../boot/dts/freescale/imx8mp-hummingboard-pro.dts |  76 ++++
>  .../freescale/imx8mp-hummingboard-pulse-codec.dtsi |  59 ++++
>  .../imx8mp-hummingboard-pulse-common.dtsi          | 384 +++++++++++++++++++++
>  .../freescale/imx8mp-hummingboard-pulse-hdmi.dtsi  |  44 +++
>  .../freescale/imx8mp-hummingboard-pulse-m2con.dtsi |  60 ++++
>  .../imx8mp-hummingboard-pulse-mini-hdmi.dtsi       |  81 +++++
>  .../dts/freescale/imx8mp-hummingboard-pulse.dts    |  84 +++++
>  .../dts/freescale/imx8mp-hummingboard-ripple.dts   |  31 ++
>  10 files changed, 854 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index e98c15eb949957a193eb3a7612f3f0f2b04790af..ccc1d6f98495589cb6a55b198d1933bcf076fcb8 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -203,6 +203,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-picoitx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-mate.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pro.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pulse.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-ripple.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-bl-osm-s.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..00614f5d58ea9de51aad9a5f36212dc3d4f3ecaf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp-sr-som.dtsi"
> +#include "imx8mp-hummingboard-pulse-common.dtsi"
> +#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
> +
> +/ {
> +	model = "SolidRun i.MX8MP HummingBoard Mate";
> +	compatible = "solidrun,imx8mp-hummingboard-mate",
> +		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
> +
> +	aliases {
> +		ethernet0 = &eqos;
> +		/delete-property/ ethernet1;
> +	};
> +};
> +
> +&fec {
> +	/* this board does not use second phy / ethernet on SoM */
> +	status = "disabled";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&mikro_rst_pins>;
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..36cd452f1583987a1e826d33798d9aecaaf21568
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +#include "imx8mp-sr-som.dtsi"
> +#include "imx8mp-hummingboard-pulse-codec.dtsi"
> +#include "imx8mp-hummingboard-pulse-common.dtsi"
> +#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
> +#include "imx8mp-hummingboard-pulse-m2con.dtsi"
> +#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
> +
> +/ {
> +	model = "SolidRun i.MX8MP HummingBoard Pro";
> +	compatible = "solidrun,imx8mp-hummingboard-pro",
> +		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
> +
> +	aliases {
> +		ethernet0 = &eqos;
> +		ethernet1 = &fec;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&hdmi_pins>,
> +		    <&m2_wwan_wake_pins>;
> +};
> +
> +&pcie {
> +	pinctrl-0 = <&m2_reset_pins>;
> +	pinctrl-names = "default";
> +	reset-gpio = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&pcie_phy {
> +	clocks = <&hsio_blk_ctrl>;
> +	clock-names = "ref";
> +	fsl,clkreq-unsupported;
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
> +	status = "okay";
> +};
> +
> +&phy0 {
> +	leds {
> +		/* ADIN1300 LED_0 pin */
> +		led@0 {
> +			reg = <0>;
> +			color = <LED_COLOR_ID_ORANGE>;
> +			function = LED_FUNCTION_LAN;
> +			default-state = "keep";
> +		};
> +
> +		/delete-node/ led@1;
> +	};
> +};
> +
> +&phy1 {
> +	leds {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* ADIN1300 LED_0 pin */
> +		led@0 {
> +			reg = <0>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_LAN;
> +			default-state = "keep";
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..fd16916676db4ec6f0e66d9c52355c37fe06b971
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +/ {
> +	sound-wm8904 {
> +		compatible = "fsl,imx-audio-wm8904";
> +		model = "audio-wm8904";
> +		audio-cpu = <&sai3>;
> +		audio-codec = <&codec>;
> +		audio-routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"AMIC", "MICBIAS",
> +			"IN2R", "AMIC";
> +	};
> +};
> +
> +&i2c2 {
> +	codec: codec@1a {

audio-codec for the node name.

> +		#sound-dai-cells = <0>;
> +		compatible = "wlf,wm8904";
> +		reg = <0x1a>;

Can we move "#sound-dai-cells" here?  We usually start with "compatible"
and "reg".

> +		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
> +		clock-names = "mclk";
> +		AVDD-supply = <&v_1_8>;
> +		CPVDD-supply = <&v_1_8>;
> +		DBVDD-supply = <&v_3_3>;
> +		DCVDD-supply = <&v_1_8>;
> +		MICVDD-supply = <&v_3_3>;
> +	};
> +};
> +
> +&iomuxc {
> +	sai3_pins: pinctrl-sai3-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
> +			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
> +			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
> +			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
> +			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
> +		>;
> +	};
> +};
> +
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sai3_pins>;
> +	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <12288000>;
> +	clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_IPG>, <&clk IMX8MP_CLK_DUMMY>,
> +		 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>, <&clk IMX8MP_CLK_DUMMY>,
> +		 <&clk IMX8MP_CLK_DUMMY>;
> +	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..3a43cf3e2ca00741fe15cd834df0ac7c9119ad09
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
> @@ -0,0 +1,384 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	aliases {
> +		rtc0 = &carrier_rtc;
> +		rtc1 = &snvs_rtc;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins>;
> +
> +		led-0 {
> +			label = "D30";
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
> +			default-state = "on";
> +		};
> +
> +		led-1 {
> +			label = "D31";
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
> +			default-state = "on";
> +		};
> +
> +		led-2 {
> +			label = "D32";
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
> +			default-state = "on";
> +		};
> +
> +		led-3 {
> +			label = "D33";
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
> +			default-state = "on";
> +		};
> +
> +		led-4 {
> +			label = "D34";
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
> +			default-state = "on";
> +		};
> +	};
> +
> +	rfkill-mpcie-wifi {
> +		/*
> +		 * The mpcie connector only has USB,
> +		 * therefore this rfkill is for cellular radios only.
> +		 */
> +		compatible = "rfkill-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mpcie_rfkill_pins>;
> +		label = "mpcie radio";
> +		radio-type = "wwan";
> +		/* rfkill-gpio inverts internally */
> +		shutdown-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vmmc: regulator-mmc {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vmmc_pins>;
> +		regulator-name = "vmmc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <250>;
> +	};
> +
> +	vbus1: regulator-vbus-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vbus1";
> +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vbus1_pins>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vbus2: regulator-vbus-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vbus2";
> +		gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vbus2_pins>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	v_1_2: regulator-1-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1v2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +	};
> +
> +	vmpcie {
> +		/* supplies mpcie and m2 connectors */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmpcie";
> +		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vmpcie_pins>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +/* mikrobus spi */
> +&ecspi2 {
> +	num-cs = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mikro_spi_pins>;
> +	status = "okay";
> +};
> +
> +&gpio1 {
> +	pinctrl-0 = <&mpcie_reset_pins>;
> +	pinctrl-names = "default";
> +
> +	mpcie-reset-hog {
> +		gpio-hog;
> +		gpios = <1 GPIO_ACTIVE_LOW>;
> +		output-low;
> +		line-name = "mpcie-reset";
> +	};
> +};
> +
> +&i2c3 {
> +	carrier_rtc: rtc@69 {
> +		compatible = "abracon,ab1805";
> +		reg = <0x69>;
> +		abracon,tc-diode = "schottky";
> +		abracon,tc-resistor = <3>;
> +	};
> +
> +	carrier_eeprom: eeprom@57{

Sort I2C devices in slave address.

> +		compatible = "st,24c02", "atmel,24c02";
> +		reg = <0x57>;
> +		pagesize = <16>;
> +	};
> +};
> +
> +&iomuxc {
> +	csi_pins: pinctrl-csi-grp {
> +		fsl,pins = <
> +			/* Pin 24: STROBE */
> +			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07		0x0
> +		>;
> +	};
> +
> +	mikro_int_pins: pinctrl-mikro-int-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09		0x0
> +		>;
> +	};
> +
> +	mikro_pwm_pins: pinctrl-mikro-pwm-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI1_MISO__GPIO5_IO08		0x0
> +		>;
> +	};
> +
> +	mikro_rst_pins: pinctrl-mikro-rst-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_RXD__GPIO4_IO30		0x0
> +		>;
> +	};
> +
> +	mikro_spi_pins: pinctrl-mikro-spi-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI2_SS0__ECSPI2_SS0		0x40000
> +			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x82
> +			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x82
> +			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x82
> +		>;
> +	};
> +
> +	mikro_uart_pins: pinctrl-mikro-uart-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x140
> +			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x140
> +		>;
> +	};
> +
> +	led_pins: pinctrl-led-grp {

This one is out of order?

> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22		0x0
> +			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21		0x0
> +			MX8MP_IOMUXC_SAI2_RXD0__GPIO4_IO23		0x0
> +			MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24		0x0
> +			MX8MP_IOMUXC_UART4_RXD__GPIO5_IO28		0x0
> +		>;
> +	};
> +
> +	mpcie_reset_pins: pinctrl-mpcie-reset-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01		0x0
> +		>;
> +	};
> +
> +	mpcie_rfkill_pins: pinctrl-pcie-rfkill-grp {
> +		fsl,pins = <
> +			/* weak i/o, open drain */
> +			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x20
> +		>;
> +	};
> +
> +	usb_hub_pins: pinctrl-usb-hub-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11		0x0
> +		>;
> +	};
> +
> +	usdhc2_pins: pinctrl-usdhc2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190
> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0
> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0
> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0
> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0
> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0
> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
> +			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
> +		>;
> +	};
> +
> +	usdhc2_100mhz_pins: pinctrl-usdhc2-100mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194
> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4
> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4
> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4
> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4
> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4
> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
> +			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
> +		>;
> +	};
> +
> +	usdhc2_200mhz_pins: pinctrl-usdhc2-200mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196
> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6
> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6
> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6
> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6
> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6
> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
> +			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
> +		>;
> +	};
> +
> +	vbus1_pins: pinctrl-vbus-1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14		0x20
> +		>;
> +	};
> +
> +	vbus2_pins: pinctrl-vbus-2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x20
> +		>;
> +	};
> +
> +	vmmc_pins: pinctrl-vmmc-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x41
> +		>;
> +	};
> +
> +	vmpcie_pins: pinctrl-vmpcie-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x0
> +		>;
> +	};
> +};
> +
> +&phy0 {
> +	leds {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* ADIN1300 LED_0 pin */
> +		led@0 {
> +			reg = <0>;
> +			color = <LED_COLOR_ID_ORANGE>;
> +			function = LED_FUNCTION_LAN;
> +			default-state = "keep";
> +		};
> +
> +		/* ADIN1300 LINK_ST pin */
> +		led@1 {
> +			reg = <1>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_LAN;
> +			default-state = "keep";
> +		};
> +	};
> +};
> +
> +&snvs_pwrkey {
> +	status = "okay";
> +};
> +
> +/* mikrobus uart */
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {
> +	fsl,phy-tx-preemp-amp-tune-microamp = <1200>;
> +	vbus-supply = <&vbus2>;
> +	status = "okay";
> +};
> +
> +&usb3_0 {
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	vbus-supply = <&vbus1>;
> +	status = "okay";
> +};
> +
> +&usb3_1 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_0 {
> +	dr_mode = "host";
> +};
> +
> +&usb_dwc3_1 {
> +	dr_mode = "host";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb_hub_pins>;
> +
> +	hub_2_0: hub@1 {
> +		compatible = "usb4b4,6502", "usb4b4,6506";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&v_1_2>;
> +		vdd2-supply = <&v_3_3>;
> +	};
> +
> +	hub_3_0: hub@2 {
> +		compatible = "usb4b4,6500", "usb4b4,6504";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&v_1_2>;
> +		vdd2-supply = <&v_3_3>;
> +	};
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&usdhc2_pins>;
> +	pinctrl-1 = <&usdhc2_100mhz_pins>;
> +	pinctrl-2 = <&usdhc2_200mhz_pins>;
> +	vmmc-supply = <&vmmc>;
> +	bus-width = <4>;
> +	cap-power-off-card;
> +	full-pwr-cycle;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..d7a999c0d7e06a8c47a61632a59eb97faea9e3d4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +/ {
> +	sound-hdmi {
> +		compatible = "fsl,imx-audio-hdmi";
> +		model = "audio-hdmi";
> +		audio-cpu = <&aud2htx>;
> +		hdmi-out;
> +	};
> +};
> +
> +&aud2htx {
> +	status = "okay";
> +};
> +
> +&hdmi_pvi {
> +	status = "okay";
> +};
> +
> +&hdmi_tx {
> +	status = "okay";
> +};
> +
> +&hdmi_tx_phy {
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	hdmi_pins: pinctrl-hdmi-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c3
> +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c3
> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x154
> +			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x154
> +		>;
> +	};
> +};
> +
> +&lcdif3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..b879ca4ed21428b8d4c6866f9a827bcfbef1caee
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +/ {
> +	rfkill-m2-gnss {
> +		compatible = "rfkill-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&m2_gnss_rfkill_pins>;
> +		label = "m.2 GNSS";
> +		radio-type = "gps";
> +		/* rfkill-gpio inverts internally */
> +		shutdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	/* M.2 is B-keyed, so w-disable is for WWAN */
> +	rfkill-m2-wwan {
> +		compatible = "rfkill-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&m2_wwan_rfkill_pins>;
> +		label = "m.2 WWAN";
> +		radio-type = "wwan";
> +		/* rfkill-gpio inverts internally */
> +		shutdown-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&iomuxc {
> +	m2_gnss_rfkill_pins: pinctrl-m2-gnss-rfkill-grp {
> +		fsl,pins = <
> +			/* weak i/o, open drain */
> +			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x20
> +		>;
> +	};
> +
> +	m2_wwan_rfkill_pins: pinctrl-m2-wwan-rfkill-grp {
> +		fsl,pins = <
> +			/* weak i/o, open drain */
> +			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x20
> +		>;
> +	};
> +
> +	m2_wwan_wake_pins: pinctrl-m2-wwan-wake-grp {
> +		fsl,pins = <
> +			/* weak i/o, open drain */
> +			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x20
> +		>;
> +	};
> +
> +	m2_reset_pins: pinctrl-m2-reset-grp {

This one is out of order?

> +		fsl,pins = <
> +			/*
> +			 * 3.3V domain on SoC, set open-drain to ensure
> +			 * 1.8V logic on connector
> +			 */
> +			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x20
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..46916ddc053355b6708629898fa13e55c6493cc2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +/ {
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "c";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&adv7535_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	hdmi@3d {
> +		compatible = "adi,adv7535";
> +		reg = <0x3d>, <0x3f>, <0x3c>, <0x38>;
> +		reg-names = "main", "edid", "cec", "packet";
> +		adi,dsi-lanes = <4>;
> +		avdd-supply = <&v_1_8>;
> +		dvdd-supply = <&v_1_8>;
> +		pvdd-supply = <&v_1_8>;
> +		a2vdd-supply = <&v_1_8>;
> +		v3p3-supply = <&v_3_3>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mini_hdmi_pins>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				adv7535_from_dsim: endpoint {
> +					remote-endpoint = <&dsim_to_adv7535>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				adv7535_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	mini_hdmi_pins: pinctrl-mini-hdmi-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27		0x0
> +		>;
> +	};
> +};
> +
> +&lcdif1 {
> +	status = "okay";
> +};
> +
> +&mipi_dsi {
> +	samsung,esc-clock-frequency = <10000000>;
> +	status = "okay";
> +
> +	port@1 {
> +		dsim_to_adv7535: endpoint {
> +			remote-endpoint = <&adv7535_from_dsim>;
> +			attach-bridge;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..e0d6f281837f106bb0b4661d8fe54eaa2cafc3c2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +#include "imx8mp-sr-som.dtsi"
> +#include "imx8mp-hummingboard-pulse-codec.dtsi"
> +#include "imx8mp-hummingboard-pulse-common.dtsi"
> +#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
> +#include "imx8mp-hummingboard-pulse-m2con.dtsi"
> +#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
> +
> +/ {
> +	model = "SolidRun i.MX8MP HummingBoard Pulse";
> +	compatible = "solidrun,imx8mp-hummingboard-pulse",
> +		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
> +
> +	aliases {
> +		ethernet0 = &eqos;
> +		ethernet1 = &pcie_eth;
> +	};
> +};
> +
> +&fec {
> +	/* this board does not use second phy / ethernet on SoM */
> +	status = "disabled";
> +};
> +
> +&gpio1 {
> +	pinctrl-0 = <&mpcie_reset_pins>, <&m2_reset_pins>;
> +	pinctrl-names = "default";
> +
> +	m2-reset-hog {
> +		gpio-hog;
> +		gpios = <6 GPIO_ACTIVE_LOW>;
> +		output-low;
> +		line-name = "m2-reset";
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&hdmi_pins>,
> +		    <&m2_wwan_wake_pins>;
> +
> +	pcie_eth_pins: pinctrl-pcie-eth-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28		0x0
> +		>;
> +	};
> +};
> +
> +&pcie {
> +	pinctrl-0 = <&pcie_eth_pins>;
> +	pinctrl-names = "default";
> +	reset-gpio = <&gpio4 28 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	root@0,0 {
> +		compatible = "pci16c3,abcd";
> +		reg = <0x00000000 0 0 0 0>;
> +

Nit: unnecessary newline

Shawn

> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		/* Intel i210 */
> +		pcie_eth: ethernet@1,0 {
> +			compatible = "pci8086,157b";
> +			reg = <0x00010000 0 0 0 0>;
> +		};
> +	};
> +};
> +
> +&pcie_phy {
> +	clocks = <&hsio_blk_ctrl>;
> +	clock-names = "ref";
> +	fsl,clkreq-unsupported;
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..4ce5b799b6abc514ca00e2e2134d5ff1606dc87d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp-sr-som.dtsi"
> +#include "imx8mp-hummingboard-pulse-common.dtsi"
> +#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
> +
> +/ {
> +	model = "SolidRun i.MX8MP HummingBoard Ripple";
> +	compatible = "solidrun,imx8mp-hummingboard-ripple",
> +		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
> +
> +	aliases {
> +		ethernet0 = &eqos;
> +		/delete-property/ ethernet1;
> +	};
> +};
> +
> +&fec {
> +	/* this board does not use second phy / ethernet on SoM */
> +	status = "disabled";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&mikro_rst_pins>;
> +};
> 
> -- 
> 2.43.0
> 



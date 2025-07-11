Return-Path: <linux-kernel+bounces-727154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ED9B015AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68671C84CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C62723A994;
	Fri, 11 Jul 2025 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="o1TJgCjS"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF32E371A;
	Fri, 11 Jul 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222034; cv=none; b=S69hBaCkny+YDBTsEokLzoFDPS5Mvl/dQjRSBKer77lIeJ9VRkRVpT73CkttSLHrmATDqqKzOQRLRHfp27Bc1R5fzOFJacTLoBFjHMWEs618tHuOr0l305EyPaXb64riZdACsEb3E7S+vHIxcSWEwJTu2tF7RgZ2JxecFDjXcIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222034; c=relaxed/simple;
	bh=EKL2IIzmsaVRIHrvev/3x06LRtDvdWbiVHEq/vi+Z0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3NwelsAlEfFe7rl4K5pvP4uSPd1bXXWlBLSey45SHHhXLiqFAJxDJBkRqBHHDG8JBaWlFLVx/r+ThHGVbO4NercvCqzHGuxdFkWwy2nzGY4NDMl1Gaq6SjHjNOwvwHovc0G0hU+Qv+wHTnXGArA9oXSFPnQAdP7aE4fOM3nfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=o1TJgCjS; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=fJjxgdjUE58JxCmvpT+l1THufjJYYANYad5kuZV3JwU=;
	b=o1TJgCjSFE9jG2B44OaF50hnkxu0ATe5dF5PQ/yourvxds1FWwxqR+MHKZYzMG
	c+IHYpuNdPN/oAC/+UBuKDQLGmDXc2JTh6CZ5ouIc3rKWO4bP3VmEyHenqfD7vkh
	/0Gm5P1jcRIgUcmiBdRQ9pB7R0BmI85BzNCUwJJKI9BUM=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDXVYokyXBolxZSAA--.49685S3;
	Fri, 11 Jul 2025 16:19:50 +0800 (CST)
Date: Fri, 11 Jul 2025 16:19:48 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Richard Hu <richard.hu@technexion.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Ray Chang <ray.chang@technexion.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mp: Add TechNexion
 EDM-G-IMX8M-PLUS SOM on WB-EDM-G carrier board
Message-ID: <aHDJJNVOsX7K-m4d@dragon>
References: <20250709-add-technexion-edm-g-imx8m-plus-som-v3-0-721d198ce20b@technexion.com>
 <20250709-add-technexion-edm-g-imx8m-plus-som-v3-2-721d198ce20b@technexion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-add-technexion-edm-g-imx8m-plus-som-v3-2-721d198ce20b@technexion.com>
X-CM-TRANSID:M88vCgDXVYokyXBolxZSAA--.49685S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfXry8KFyxZr4kAFWxXFykGrg_yoW5Cw1kXo
	WY93Z5AFyUKw1UZFnxGr17Ar4UXrs3KwsIkayDtrW3GF1ft39Yy340qayjqr48tw1FqFyk
	WayfGa4rCay2yw4kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0g4SUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIAexF2hwyScSyAAA3t

On Wed, Jul 09, 2025 at 01:47:45PM +0800, Richard Hu wrote:
> Add support for TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G carrier board.
> Key interfaces include:
> - Gigabit Ethernet
> - USB 3.0
> - I2S, UART, SPI, I2C, PWM, GPIO
> 
> Signed-off-by: Richard Hu <richard.hu@technexion.com>
> Signed-off-by: Ray Chang <ray.chang@technexion.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   1 +
>  arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts | 373 ++++++++++
>  arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi   | 806 ++++++++++++++++++++++
>  3 files changed, 1180 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 0b473a23d120..b56c866d4a9d 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-drc02.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-picoitx.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-edm-g-wb.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts b/arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts
> new file mode 100644
> index 000000000000..0e5c7bf219b0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts
> @@ -0,0 +1,373 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2024 TechNexion Ltd.
> + *
> + * Author: Ray Chang <ray.chang@technexion.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp-edm-g.dtsi"
> +
> +/ {
> +	compatible = "technexion,edm-g-imx8mp-wb", "technexion,edm-g-imx8mp", "fsl,imx8mp";
> +	model = "TechNexion EDM-G-IMX8MP SOM on WB-EDM-G";
> +
> +	connector {
> +		compatible = "usb-c-connector";
> +		data-role = "dual";
> +		label = "USB-C";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;

Have a newline between properties and child node.

> +				hs_ep: endpoint {
> +					remote-endpoint = <&usb3_hs_ep>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				ss_ep: endpoint {
> +					remote-endpoint = <&hd3ss3220_in_ep>;
> +				};
> +			};
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		led {
> +			default-state = "on";
> +			gpios = <&expander2 1 GPIO_ACTIVE_HIGH>;
> +			label = "gpio-led";
> +		};
> +	};
> +
> +	lvds_backlight: lvds-backlight {
> +		compatible = "pwm-backlight";
> +		brightness-levels = <0 36 72 108 144 180 216 255>;
> +		default-brightness-level = <6>;
> +		pwms = <&pwm2 0 50000 0>;
> +		status = "disabled";

Just out of curiosity, why is it disabled?

> +	};
> +
> +	native-hdmi-connector {
> +		compatible = "hdmi-connector";
> +		label = "HDMI OUT";
> +		type = "a";
> +
> +		port {
> +			hdmi_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_out>;
> +			};
> +		};
> +	};
> +
> +	pcie0_refclk: pcie0-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
> +	reg_pcie0: regulator-pcie {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "PCIE_CLKREQ_N";
> +		gpio = <&gpio1 13 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	reg_pwr_3v3: regulator-pwr-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "pwr-3v3";
> +	};
> +
> +	reg_pwr_5v: regulator-pwr-5v {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-name = "pwr-5v";
> +	};
> +
> +	sound-hdmi {
> +		compatible = "fsl,imx-audio-hdmi";
> +		audio-cpu = <&aud2htx>;
> +		hdmi-out;
> +		model = "audio-hdmi";
> +	};
> +
> +	sound-wm8960 {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,bitclock-master = <&cpudai>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&cpudai>;
> +		simple-audio-card,name = "wm8960-audio";
> +		simple-audio-card,routing = "Headphone Jack", "HP_L",
> +			"Headphone Jack", "HP_R",
> +			"External Speaker", "SPK_LP",
> +			"External Speaker", "SPK_LN",
> +			"External Speaker", "SPK_RP",
> +			"External Speaker", "SPK_RN",
> +			"LINPUT1", "Mic Jack",
> +			"RINPUT1", "Mic Jack",
> +			"Mic Jack", "MICB";
> +		simple-audio-card,widgets = "Headphone", "Headphone Jack",
> +			"Speaker", "External Speaker",
> +			"Microphone", "Mic Jack";
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&wm8960>;
> +		};
> +
> +		cpudai: simple-audio-card,cpu {
> +			sound-dai = <&sai3>;
> +		};
> +	};
> +};
> +
> +&aud2htx {
> +	status = "okay";
> +};
> +
> +&flexcan1 {
> +	status = "okay";
> +};
> +
> +&gpio1 {
> +	gpio-line-names = \

Hmm, not sure "\" is necessary.

> +		"", "", "", "", "", "", "DSI_RST", "",	\
> +		"", "", "", "", "", "", "", "",	\
> +		"", "", "", "", "", "", "", "",	\
> +		"", "", "", "", "", "", "", "";
> +	pinctrl-0 = <&pinctrl_gpio1>;
> +};
> +
> +&gpio4 {
> +	gpio-line-names = \
> +		"", "", "", "", "", "", "GPIO_P249", "GPIO_P251",	\
> +		"", "GPIO_P255", "", "", "", "", "", "",	\
> +		"DSI_BL_EN", "DSI_VDDEN", "", "", "", "", "", "",	\
> +		"", "", "", "", "", "", "", "";
> +	pinctrl-0 = <&pinctrl_gpio4>;
> +};
> +
> +&hdmi_pvi {
> +	status = "okay";
> +};
> +
> +&hdmi_tx {
> +	pinctrl-0 = <&pinctrl_hdmi>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			hdmi_tx_out: endpoint {
> +				remote-endpoint = <&hdmi_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi_tx_phy {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	wm8960: codec@1a {

audio-codec for the node name.

> +		compatible = "wlf,wm8960";
> +		reg = <0x1a>;
> +		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
> +		clock-names = "mclk";
> +		#sound-dai-cells = <0>;
> +		AVDD-supply = <&reg_pwr_3v3>;
> +		DBVDD-supply = <&reg_pwr_3v3>;
> +		DCVDD-supply = <&reg_pwr_3v3>;
> +		SPKVDD1-supply = <&reg_pwr_5v>;
> +		SPKVDD2-supply = <&reg_pwr_5v>;
> +		wlf,hp-cfg = <2 2 3>;
> +		wlf,shared-lrclk;
> +	};
> +
> +	expander1: gpio@21 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x21>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		gpio-line-names = "EXPOSURE_TRIG_IN1", "FLASH_OUT1",
> +				  "INFO_TRIG_IN1", "CAM_SHUTTER1", "XVS1",
> +				  "PWR1_TIME0", "PWR1_TIME1", "PWR1_TIME2",
> +				  "EXPOSURE_TRIG_IN2", "FLASH_OUT2",
> +				  "INFO_TRIG_IN2", "CAM_SHUTTER2", "XVS2",
> +				  "PWR2_TIME0", "PWR2_TIME1", "PWR2_TIME2";
> +	};
> +
> +	expander2: gpio@23 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x23>;
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		gpio-line-names = "M2_DISABLE_N", "LED_EN", "", "",
> +				  "", "", "", "USB_OTG_OC",
> +				  "EXT_GPIO8", "EXT_GPIO9", "", "",
> +				  "", "CSI1_PDB", "CSI2_PDB", "PD_FAULT";
> +		pinctrl-0 = <&pinctrl_expander2_irq>;
> +		pinctrl-names = "default";
> +	};
> +
> +	usb_typec: usb-typec@67 {
> +		compatible = "ti,hd3ss3220";
> +		reg = <0x67>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-0 = <&pinctrl_hd3ss3220_irq>;
> +		pinctrl-names = "default";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;

Have a newline between properties and child node.

Shawn

> +				hd3ss3220_in_ep: endpoint {
> +					remote-endpoint = <&ss_ep>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				hd3ss3220_out_ep: endpoint {
> +					remote-endpoint = <&usb3_role_switch>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c_0 {
> +	eeprom2: eeprom@51 {
> +		compatible = "atmel,24c02";
> +		reg = <0x51>;
> +		pagesize = <16>;
> +	};
> +};
> +
> +&lcdif3 {
> +	status = "okay";
> +};
> +
> +&pcie {
> +	vpcie-supply = <&reg_pcie0>;
> +	status = "okay";
> +};
> +
> +&pcie_phy {
> +	clocks = <&pcie0_refclk>;
> +	clock-names = "ref";
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +	status = "okay";
> +};
> +
> +&usb3_0 {
> +	status = "okay";
> +};
> +
> +&usb3_1 {
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_0 {
> +	/* dual role is implemented but not a full featured OTG */
> +	adp-disable;
> +	dr_mode = "otg";
> +	hnp-disable;
> +	role-switch-default-mode = "peripheral";
> +	srp-disable;
> +	usb-role-switch;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			usb3_hs_ep: endpoint {
> +				remote-endpoint = <&hs_ep>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			usb3_role_switch: endpoint {
> +				remote-endpoint = <&hd3ss3220_out_ep>;
> +			};
> +		};
> +	};
> +};
> +
> +&usb_dwc3_1 {
> +	dr_mode = "host";
> +};
> +
> +&iomuxc {
> +	pinctrl_expander2_irq: expander2-irqgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI1_TXC__GPIO4_IO11		0x140 /* GPIO_P247 */
> +		>;
> +	};
> +
> +	pinctrl_gpio1: gpio1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x16 /* DSI_RST */
> +		>;
> +	};
> +
> +	pinctrl_gpio4: gpio4grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI1_RXD4__GPIO4_IO06		0x16 /* GPIO_P249 */
> +			MX8MP_IOMUXC_SAI1_RXD5__GPIO4_IO07		0x16 /* GPIO_P251 */
> +			MX8MP_IOMUXC_SAI1_RXD7__GPIO4_IO09		0x16 /* GPIO_P255 */
> +			MX8MP_IOMUXC_SAI1_TXD4__GPIO4_IO16		0x16 /* DSI_BL_EN */
> +			MX8MP_IOMUXC_SAI1_TXD5__GPIO4_IO17		0x16 /* DSI_VDDEN */
> +		>;
> +	};
> +
> +	pinctrl_hd3ss3220_irq: hd3ss3220-irqgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI1_RXD6__GPIO4_IO08		0x41 /* GPIO_P253 */
> +		>;
> +	};
> +
> +	pinctrl_hdmi: hdmigrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c2
> +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c2
> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x10
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi
> new file mode 100644
> index 000000000000..66677cc5cb06
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi
> @@ -0,0 +1,806 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2024 TechNexion Ltd.
> + *
> + * Author: Ray Chang <ray.chang@technexion.com>
> + */
> +
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +#include <dt-bindings/usb/pd.h>
> +#include "imx8mp.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	i2c_0: i2c-0 {
> +		compatible = "i2c-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <100000>;
> +		pinctrl-0 = <&pinctrl_i2c_brd_conf>;
> +		pinctrl-names = "default";
> +		scl-gpios = <&gpio4 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		sda-gpios = <&gpio4 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +
> +		eeprom: eeprom@53 {
> +			compatible = "atmel,24c02";
> +			reg = <0x53>;
> +			pagesize = <16>;
> +		};
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		off-on-delay-us = <12000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "VSD_3V3";
> +		startup-delay-us = <100>;
> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	rfkill {
> +		compatible = "rfkill-gpio";
> +		name = "rfkill";
> +		pinctrl-0 = <&pinctrl_bt_ctrl>;
> +		pinctrl-names = "default";
> +		radio-type = "bluetooth";
> +		shutdown-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	wl_reg_on: wlreg-on {
> +		compatible = "regulator-fixed";
> +		off-on-delay-us = <20000>;
> +		pinctrl-0 = <&pinctrl_wifi_ctrl>;
> +		pinctrl-names = "default";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "WL_REG_ON";
> +		startup-delay-us = <100>;
> +		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	memory@40000000 {
> +		reg = <0x0 0x40000000 0 0xc0000000>,
> +		      <0x1 0x00000000 0 0xc0000000>;
> +		device_type = "memory";
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&ecspi1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +	num-cs = <1>;
> +	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
> +	pinctrl-names = "default";
> +};
> +
> +&eqos {
> +	phy-handle = <&ethphy0>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	pinctrl-names = "default";
> +	snps,force_thresh_dma_mode;
> +	snps,mtl-rx-config = <&mtl_rx_setup>;
> +	snps,mtl-tx-config = <&mtl_tx_setup>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +			eee-broken-1000t;
> +			reset-assert-us = <35000>;
> +			reset-deassert-us = <75000>;
> +			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +			realtek,clkout-disable;
> +		};
> +	};
> +
> +	mtl_rx_setup: rx-queues-config {
> +		snps,rx-queues-to-use = <5>;
> +		snps,rx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <0>;
> +			snps,priority = <0x1>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <1>;
> +			snps,priority = <0x2>;
> +		};
> +
> +		queue2 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <2>;
> +			snps,priority = <0x4>;
> +		};
> +
> +		queue3 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <3>;
> +			snps,priority = <0x8>;
> +		};
> +
> +		queue4 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <4>;
> +			snps,priority = <0xf0>;
> +		};
> +	};
> +
> +	mtl_tx_setup: tx-queues-config {
> +		snps,tx-queues-to-use = <5>;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x1>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x2>;
> +		};
> +
> +		queue2 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x4>;
> +		};
> +
> +		queue3 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x8>;
> +		};
> +
> +		queue4 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0xf0>;
> +		};
> +	};
> +};
> +
> +&flexcan1 {
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	pinctrl-names = "default";
> +};
> +
> +&flexcan2 {
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	pinctrl-names = "default";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	pmic: pmic@25 {
> +		compatible = "nxp,pca9450c";
> +		reg = <0x25>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 GPIO_ACTIVE_LOW>;
> +		/* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK1";
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK2";
> +				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK4";
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK5";
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK6";
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <1600000>;
> +				regulator-name = "LDO1";
> +			};
> +
> +			ldo2: LDO2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1150000>;
> +				regulator-min-microvolt = <800000>;
> +				regulator-name = "LDO2";
> +			};
> +
> +			ldo3: LDO3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <800000>;
> +				regulator-name = "LDO3";
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <800000>;
> +				regulator-name = "LDO4";
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-name = "LDO5";
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	/* I2C_B on EDMG */
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-names = "default";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	pinctrl-names = "default";
> +};
> +
> +&i2c4 {
> +	/* I2C_A on EDMG */
> +	clock-frequency = <100000>;
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	pinctrl-names = "default";
> +};
> +
> +&i2c5 {
> +	/* I2C_C on EDMG */
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_i2c5>;
> +	pinctrl-names = "default";
> +};
> +
> +&pcie {
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	pinctrl-names = "default";
> +	reset-gpio = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +};
> +
> +&pwm1 {
> +	pinctrl-0 = <&pinctrl_pwm1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	pinctrl-0 = <&pinctrl_pwm2>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&pwm3 {
> +	pinctrl-0 = <&pinctrl_pwm3>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&pwm4 {
> +	pinctrl-0 = <&pinctrl_pwm4>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&sai2 {
> +	/* AUD_B on EDMG */
> +	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
> +	assigned-clock-rates = <12288000>;
> +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	pinctrl-names = "default";
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&sai3 {
> +	/* AUD_A on EDMG */
> +	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
> +	assigned-clock-rates = <12288000>;
> +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	pinctrl-names = "default";
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	/* BT */
> +	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	/* UART_A on EDMG, console */
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	/* UART_C on EDMG */
> +	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	/* UART_B on EDMG */
> +	assigned-clocks = <&clk IMX8MP_CLK_UART4>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	/* WIFI SDIO */
> +	assigned-clocks = <&clk IMX8MP_CLK_USDHC1>;
> +	assigned-clock-rates = <200000000>;
> +	bus-width = <4>;
> +	keep-power-in-suspend;
> +	non-removable;
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	vmmc-supply = <&wl_reg_on>;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	/* SD card on baseboard */
> +	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
> +	assigned-clock-rates = <400000000>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	/* eMMC on SOM */
> +	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
> +	assigned-clock-rates = <400000000>;
> +	bus-width = <8>;
> +	non-removable;
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	pinctrl-names = "default";
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-0 = <&pinctrl_hog>;
> +	pinctrl-names = "default";
> +
> +	pinctrl_bt_ctrl: bt-ctrlgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05	0x41 /* BT_REG_ON */
> +			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19	0x41 /* BT_WAKE_HOST */
> +		>;
> +	};
> +
> +	pinctrl_ecspi1_cs: ecspi1csgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09	0x40000
> +		>;
> +	};
> +
> +	pinctrl_ecspi1: ecspi1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK	0x82
> +			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI	0x82
> +			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO	0x82
> +		>;
> +	};
> +
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC			0x3
> +			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO			0x23
> +			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0		0x91
> +			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1		0x91
> +			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2		0x91
> +			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3		0x91
> +			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
> +			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x91
> +			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0		0x1f
> +			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1		0x1f
> +			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2		0x1f
> +			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3		0x1f
> +			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x1f
> +			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
> +			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09			0x19
> +			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12			0x19
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: flexcan1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXD2__CAN1_RX		0x154
> +			MX8MP_IOMUXC_SAI5_RXD1__CAN1_TX		0x154
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX		0x154
> +			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX		0x154
> +		>;
> +	};
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD	0x40000019
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001a3
> +			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001a3
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001a3
> +			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001a3
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3
> +			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c3
> +			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c5: i2c5grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL		0x400001a3
> +			MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA		0x400001a3
> +		>;
> +	};
> +
> +	pinctrl_i2c_brd_conf: i2cbrdconfgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x1c3 /* BRD_CONF_SCL, bitbang */
> +			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x1c3 /* BRD_CONF_SDA, bitbang */
> +		>;
> +	};
> +
> +	pinctrl_pcie: pciegrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13	0x41 /* PCIE CLKREQ */
> +			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21	0x41 /* PCIE WAKE */
> +			MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01	0x41 /* PCIE RST */
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicirqgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x41
> +		>;
> +	};
> +
> +	pinctrl_pwm1: pwm1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SPDIF_EXT_CLK__PWM1_OUT	0x116
> +		>;
> +	};
> +
> +	pinctrl_pwm2: pwm2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXD0__PWM2_OUT	0x116
> +		>;
> +	};
> +
> +	pinctrl_pwm3: pwm3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXC__PWM3_OUT		0x116
> +		>;
> +	};
> +
> +	pinctrl_pwm4: pwm4grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXFS__PWM4_OUT	0x116
> +		>;
> +	};
> +
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK	0xd6
> +			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC	0xd6
> +			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
> +			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00	0xd6
> +			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
> +			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
> +			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
> +			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
> +			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
> +			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
> +			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS	0x140
> +			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
> +			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
> +			MX8MP_IOMUXC_UART4_RXD__UART2_DCE_CTS	0x140
> +			MX8MP_IOMUXC_UART4_TXD__UART2_DCE_RTS	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_DATA7__UART3_DCE_RX	0x140
> +			MX8MP_IOMUXC_SD1_DATA6__UART3_DCE_TX	0x140
> +			MX8MP_IOMUXC_SD1_STROBE__UART3_DCE_CTS	0x140
> +			MX8MP_IOMUXC_SD1_RESET_B__UART3_DCE_RTS	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart4: uart4grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI2_SCLK__UART4_DCE_RX	0x140
> +			MX8MP_IOMUXC_ECSPI2_MOSI__UART4_DCE_TX	0x140
> +			MX8MP_IOMUXC_ECSPI2_MISO__UART4_DCE_CTS	0x140
> +			MX8MP_IOMUXC_ECSPI2_SS0__UART4_DCE_RTS	0x140
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
> +			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0
> +			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0
> +			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0
> +			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0
> +			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x194
> +			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d4
> +			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d4
> +			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d4
> +			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d4
> +			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d4
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x196
> +			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d6
> +			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d6
> +			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d6
> +			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d6
> +			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d6
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194
> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4
> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196
> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6
> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
> +			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0xc6
> +		>;
> +	};
> +
> +	pinctrl_wifi_ctrl: wifi-ctrlgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO00__GPIO1_IO00	0x41 /* WL_REG_ON */
> +			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x41 /* WL_WAKE_HOST */
> +		>;
> +	};
> +};
> 
> -- 
> 2.43.0
> 



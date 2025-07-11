Return-Path: <linux-kernel+bounces-727111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B8BB01530
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14C33A5B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6850F1F4C8A;
	Fri, 11 Jul 2025 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="clwj9OTF"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428B1C5F2C;
	Fri, 11 Jul 2025 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220243; cv=none; b=WOwInFwd6REDcVX8MAKu+YRqMMC3F9ehcdroQnUKwnDRzpomfm+u2EI2hY+eP9qcSMRR57S2IxazssE3aXepdrQKOKV4aPyGixz/R6DkhMgcOI1WiO7dphNFBY5QqAAKL94ETTA9Q+dh7uPaJLWJshS3V/DUw/gxPzMz+c8/a4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220243; c=relaxed/simple;
	bh=DYNivw1tvok8T+VMROawW63CXB9iIXo/iYVKZByH7Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uza/LiHSvSqN4ZoB4L0sXL3GwZNY1462eGEUgeEVzuFRdDxvzwSHLLpgnYKhnOlyxEDqFHKCESbN0/7AMDpFzhh4kXdsdV6TBSqQidwpBmoPj8+WfKMw+JUvHj//Wl02DU2Oqa1hStqb/lHu3+icqnvXALdzF8CtKvOMMtEnIBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=clwj9OTF; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=7Um3nuXABG0/tAxGat8Kc3gvZlIN+TGs56zvq9922tY=;
	b=clwj9OTFHhLwIyIbinLxe3JOCo8BAlGW21M5elEn0mCh+zootfRIJ2kfQG2rR0
	xynWZ0gwwJp3z2zaZPLYfG8PicjowcHyrhRADfBCKGSc6nyDISf5ezPwwXyZ5qTd
	VIGAIqzLste9UnEW9FGwfmVD2RSaYnnU/ZuAsv56u+rW0=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgC358MSwnBoPhxTAA--.15417S3;
	Fri, 11 Jul 2025 15:49:40 +0800 (CST)
Date: Fri, 11 Jul 2025 15:49:38 +0800
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
Subject: Re: [PATCH v2 2/3] arm64: dts: add description for solidrun imx8mp
 som and cubox-m
Message-ID: <aHDCEhSZmduIA9p8@dragon>
References: <20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com>
 <20250707-imx8mp-sr-som-v2-2-785814ef09a9@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-imx8mp-sr-som-v2-2-785814ef09a9@solid-run.com>
X-CM-TRANSID:Mc8vCgC358MSwnBoPhxTAA--.15417S3
X-Coremail-Antispam: 1Uf129KBjvAXoWftFWUArW8urW7GFyUuw1xKrg_yoW8Kw1DKo
	WYg3ZYyFWDKw1UZFnxGr17CF4UXrn3KFZ3KayDtrW3WF1rtFZYyw1qqay2qr48Jr1FqFWD
	GFWfGa4rCay29ws5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzmhFUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiARmHZWhwks6hMgAAst

On Mon, Jul 07, 2025 at 07:11:57PM +0300, Josua Mayer wrote:
> Add description for the SolidRun i.MX8M Plus based System on Module, and
> the CuBox-M.
> 
> The SoM features:
> - 2x 1Gbps Ethernet with PHY
> - eMMC
> - 1/2/3/8GB DDR
> - MIPI-CSI Camera Connector (not described without specific camera)
> 
> The CuBox-M is a complete product with enclosure featuring:
> - 1x 1Gbps RJ45 Ethernet Port
> - 2x USB-3.0 Type A
> - HDMI connector
> - microSD connector
> - microUSB connector for console (using fdtdi chip)
> - IR receiver
> - RTC with backup battery
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile           |   1 +
>  arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts | 224 +++++++++
>  arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi | 591 +++++++++++++++++++++++
>  3 files changed, 816 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 0b473a23d12008ff79d6467d9e1c7ab2c4d6a9a6..e98c15eb949957a193eb3a7612f3f0f2b04790af 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -194,6 +194,7 @@ imx8mp-aristainetos3-helios-lvds-dtbs += imx8mp-aristainetos3-helios.dtb imx8mp-
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3-helios-lvds.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3-proton2s.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-beacon-kit.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-cubox-m.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-data-modul-edm-sbc.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-model-a.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-som-a-bmb-08.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts b/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..13da5e0196a3fc168efdde63d86f0fe776f999fb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +
> +#include "imx8mp-sr-som.dtsi"
> +
> +/ {
> +	model = "SolidRun i.MX8MP CuBox-M";
> +	compatible = "solidrun,imx8mp-cubox-m",
> +		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
> +
> +	aliases {
> +		ethernet0 = &eqos;
> +		/delete-property/ ethernet1;
> +		rtc0 = &carrier_rtc;
> +		rtc1 = &snvs_rtc;
> +	};
> +
> +	ir-receiver {
> +		compatible = "gpio-ir-receiver";
> +		gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ir_pins>;
> +		linux,autosuspend-period = <125>;
> +		wakeup-source;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins>;
> +
> +		status {
> +			label = "status";
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +		};
> +	};
> +
> +	sound-hdmi {
> +		compatible = "fsl,imx-audio-hdmi";
> +		model = "audio-hdmi";
> +		audio-cpu = <&aud2htx>;
> +		hdmi-out;
> +		status = "okay";

We usually use "okay" to flip a "disabled" device.  It's not required
here I guess?

> +	};
> +
> +	vbus: regulator-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vbus";
> +		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vbus_pins>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
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
> +};
> +
> +&aud2htx {
> +	status = "okay";
> +};
> +
> +&fec {
> +	/* this board does not use second phy / ethernet on SoM */
> +	status = "disabled";
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
> +&i2c3 {
> +	carrier_rtc: rtc@32 {
> +		compatible = "epson,rx8130";
> +		reg = <0x32>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_pins>;
> +
> +	hdmi_pins: pinctrl-hdmi-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c3
> +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c3
> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x154
> +			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x154
> +		>;
> +	};
> +
> +	ir_pins: pinctrl-ir-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x4f
> +		>;
> +	};
> +
> +	led_pins: pinctrl-led-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x0
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
> +	vbus_pins: pinctrl-vbus-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x100
> +		>;
> +	};
> +
> +	vmmc_pins: pinctrl-vmmc-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x0
> +		>;
> +	};
> +};
> +
> +&lcdif3 {
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {
> +	fsl,phy-tx-preemp-amp-tune-microamp = <1200>;
> +	vbus-supply = <&vbus>;
> +	status = "okay";
> +};
> +
> +&usb3_0 {
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	fsl,phy-tx-preemp-amp-tune-microamp = <1200>;
> +	vbus-supply = <&vbus>;
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
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..a7ee0a4d4f765581dbc27d3c5dfc656b026d27e6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi
> @@ -0,0 +1,591 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 Josua Mayer <josua@solid-run.com>
> + */
> +
> +#include "imx8mp.dtsi"
> +
> +/ {
> +	model = "SolidRun i.MX8MP SoM";
> +	compatible = "solidrun,imx8mp-sr-som", "fsl,imx8mp";
> +
> +	chosen {
> +		bootargs = "earlycon=ec_imx6q,0x30890000,115200";
> +		stdout-path = &uart2;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0 0xc0000000>,
> +		      <0x1 0x00000000 0 0xc0000000>;
> +	};
> +
> +	usdhc1_pwrseq: usdhc1-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	v_1_8: regulator-1-8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	v_3_3: regulator-3-3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +};
> +
> +&eqos {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&eqos_pins>, <&phy0_pins>;
> +	phy-mode = "rgmii-id";
> +	phy = <&phy0>;
> +	snps,force_thresh_dma_mode;
> +	snps,mtl-tx-config = <&mtl_tx_setup>;
> +	snps,mtl-rx-config = <&mtl_rx_setup>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			reset-gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
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
> +
> +	mtl_rx_setup: rx-queues-config {
> +		snps,rx-queues-to-use = <5>;
> +		snps,rx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x1>;
> +			snps,map-to-dma-channel = <0>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x2>;
> +			snps,map-to-dma-channel = <1>;
> +		};
> +
> +		queue2 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x4>;
> +			snps,map-to-dma-channel = <2>;
> +		};
> +
> +		queue3 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x8>;
> +			snps,map-to-dma-channel = <3>;
> +		};
> +
> +		queue4 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0xf0>;
> +			snps,map-to-dma-channel = <4>;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fec_pins>, <&phy1_pins>;
> +	phy-mode = "rgmii-id";
> +	phy = <&phy1>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy1: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0x1>;
> +			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c1_pins>;
> +	pinctrl-1 = <&i2c1_gpio_pins>;
> +	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +
> +	som_eeprom: eeprom@50{
> +		compatible = "st,24c01", "atmel,24c01";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
> +
> +	pmic: pmic@25 {

Sort I2C devices in slave address.

> +		compatible = "nxp,pca9450c";
> +		reg = <0x25>;
> +		pinctrl-0 = <&pmic_pins>;
> +		pinctrl-names = "default";
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 GPIO_ACTIVE_LOW>;
> +		nxp,i2c-lt-enable;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +			};
> +
> +			buck4: BUCK4{
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5{
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2: LDO2 {
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1150000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3: LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-1 = <&i2c2_gpio_pins>;
> +	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c3_pins>;
> +	pinctrl-1 = <&i2c3_gpio_pins>;
> +	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	/* routed to basler camera connector */
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c4_pins>;
> +	pinctrl-1 = <&i2c4_gpio_pins>;
> +	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	eqos_pins: pinctrl-eqos-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x3
> +			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x3
> +			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x91
> +			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x91
> +			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x91
> +			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x91
> +			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
> +			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x91
> +			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x1f
> +			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x1f
> +			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x1f
> +			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x1f
> +			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x1f
> +			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
> +		>;
> +	};
> +
> +	fec_pins: pinctrl-fec-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
> +			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3
> +			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91
> +			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91
> +			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x91
> +			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x91
> +			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91
> +			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91
> +			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x1f
> +			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x1f
> +			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x1f
> +			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x1f
> +			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f
> +			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x1f
> +		>;
> +	};
> +
> +	i2c1_pins: pinctrl-i2c1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL			0x400001c3
> +			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA			0x400001c3
> +		>;
> +	};
> +
> +	i2c1_gpio_pins: pinctrl-i2c1-gpio-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14		0x400001c3
> +			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15		0x400001c3
> +		>;
> +	};
> +
> +	i2c2_pins: pinctrl-i2c2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL			0x400001c3
> +			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA			0x400001c3
> +		>;
> +	};
> +
> +	i2c2_gpio_pins: pinctrl-i2c2-gpio-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16		0x400001c3
> +			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17		0x400001c3
> +		>;
> +	};
> +
> +	i2c3_pins: pinctrl-i2c3-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL			0x400001c3
> +			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA			0x400001c3
> +		>;
> +	};
> +
> +	i2c3_gpio_pins: pinctrl-i2c3-gpio-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18		0x400001c3
> +			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19		0x400001c3
> +		>;
> +	};
> +
> +	i2c4_pins: pinctrl-i2c4-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL			0x400001c3
> +			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA			0x400001c3
> +		>;
> +	};
> +
> +	i2c4_gpio_pins: pinctrl-i2c4-gpio-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20			0x400001c3
> +			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21			0x400001c3
> +		>;
> +	};
> +
> +	phy0_pins: pinctrl-phy0-grp {
> +		fsl,pins = <
> +			/* RESET_N: weak i/o, open drain, external 1k pull-up */
> +			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19		0x20
> +			/* INT_N: weak i/o, open drain, internal pull-up */
> +			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18		0x160
> +		>;
> +	};
> +
> +	phy1_pins: pinctrl-phy-1-grp {
> +		fsl,pins = <
> +			/* RESET_N: weak i/o, open drain, external 1k pull-up */
> +			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x20
> +			/* INT_N: weak i/o, open drain, internal pull-up */
> +			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03		0x160
> +		>;
> +	};
> +
> +	pmic_pins: pinctrl-pmic-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x41
> +		>;
> +	};
> +
> +	uart1_pins: pinctrl-uart1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX		0x140
> +			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX		0x140
> +			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS		0x140
> +			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS		0x140
> +			/* BT_REG_ON */
> +			MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x0
> +			/* BT_WAKE_DEV */
> +			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07		0x0
> +			/* BT_WAKE_HOST */
> +			MX8MP_IOMUXC_SD1_DATA6__GPIO2_IO08		0x100
> +		>;
> +	};
> +
> +	uart2_pins: pinctrl-uart2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX		0x49
> +			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX		0x49
> +		>;
> +	};
> +
> +	usdhc1_pins: pinctrl-usdhc1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x190
> +			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d0
> +			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d0
> +			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d0
> +			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d0
> +			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d0
> +			/* WL_REG_ON */
> +			MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11		0x0
> +			/* WL_WAKE_HOST */
> +			MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09		0x100
> +		>;
> +	};
> +
> +	usdhc1_100mhz_pins: pinctrl-usdhc1g-100mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x194
> +			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d4
> +			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d4
> +			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d4
> +			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d4
> +			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d4
> +		>;
> +	};
> +
> +	usdhc1_200mhz_pins: pinctrl-usdhc1-200mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x196
> +			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d6
> +			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d6
> +			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d6
> +			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d6
> +			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d6
> +		>;
> +	};
> +
> +	usdhc3_pins: pinctrl-usdhc3-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x190
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d0
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d0
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d0
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d0
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d0
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d0
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d0
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d0
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d0
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x190
> +		>;
> +	};
> +
> +	usdhc3_100mhz_pins: pinctrl-usdhc3-100mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d4
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d4
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d4
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d4
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d4
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d4
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d4
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d4
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x194
> +		>;
> +	};
> +
> +	usdhc3_200mhz_pins: pinctrl-usdhc3-200mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x196
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d6
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d6
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d6
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d6
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d6
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d6
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d6
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d6
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d6
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x196
> +		>;
> +	};
> +
> +	wdog1_pins: pinctrl-wdog1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0x140
> +		>;
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>;
> +	uart-has-rtscts;
> +	/* select 80MHz parent clock to support maximum baudrate 4Mbps */
> +	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm4345c5";
> +		device-wakeup-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
> +		shutdown-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> +		/* Murata 1MW module supports max. 3M baud */
> +		max-speed = <3000000>;
> +	};
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins>;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usdhc1_pins>;
> +	pinctrl-1 = <&usdhc1_100mhz_pins>;
> +	pinctrl-2 = <&usdhc1_200mhz_pins>;
> +	vmmc-supply = <&v_3_3>;
> +	vqmmc-supply = <&v_1_8>;
> +	bus-width = <4>;
> +	mmc-pwrseq = <&usdhc1_pwrseq>;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&usdhc3_pins>;
> +	pinctrl-1 = <&usdhc3_100mhz_pins>;
> +	pinctrl-2 = <&usdhc3_200mhz_pins>;
> +	vmmc-supply = <&v_3_3>;
> +	vqmmc-supply = <&v_1_8>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wdog1_pins>;
> +	status = "okay";
> +};
> +
> +/*
> + * Reserve all physical memory from within the first 1GB of DDR address
> + * space to avoid panic on low memory systems.
> + */
> +&dsp_reserved {

Can we  place this node in order too?

Shawn

> +	reg = <0 0x6f000000 0 0x1000000>;
> +};
> 
> -- 
> 2.43.0
> 



Return-Path: <linux-kernel+bounces-759128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B315B1D8E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023BA560645
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4364259CBC;
	Thu,  7 Aug 2025 13:21:41 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271D255F3F;
	Thu,  7 Aug 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572900; cv=none; b=JDR7Td2a55I+sqSpUs4XYFJ0G5hj3osq7JwYKKaHM9xrLY3XA0ubCnY2kG3VA1S2z57LDI2q/CSVLkapbH+eRiMO5QqDlv/s8MNcXUH827mgM3o9MQmxGi3DVRSyr9U02OliLqzjXPbZ5sbIftDr+/Ir2ZeD6D3MkZH+F7zfQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572900; c=relaxed/simple;
	bh=i5WzYUb8qasHABnSNXcBRBHg102GU2GpypZrOsvHBX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyAgtyU/R/pIjXV4rWfSuU1aC0oupgOu1UrtV8P7gKmTbB64BEEyGC70ggmS3+loUMKZU+aXsM9+su9l84l+gLGDQIs4gmaaOaxXJ/IoZDfQtsPvUKyam8JaXvkh2if3HfRYZ4gX3ifl4G/kNYqYYuFT2S9NjNQz88cWmyxKlbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1754572805tbbf5e4b0
X-QQ-Originating-IP: IRWSOT8T0e9+owEYTI+ROF8eIamdGc/lgq2ur46gpq8=
Received: from [IPV6:240f:10b:7440:1:e250:2ab5 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Aug 2025 21:20:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8002526544199666994
Message-ID: <3F4DB9BB67A7F9CF+becbefbd-4469-46ac-89c9-09a3a016aba8@radxa.com>
Date: Thu, 7 Aug 2025 22:20:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: Add support for CM5 IO
 carrier
To: Joseph Kogut <joseph.kogut@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jimmy Hon <honyuenkwun@gmail.com>
Cc: Steve deRosier <derosier@cal-sierra.com>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250617-rk3588s-cm5-io-dts-upstream-v5-0-8d96854a5bbd@gmail.com>
 <20250617-rk3588s-cm5-io-dts-upstream-v5-3-8d96854a5bbd@gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250617-rk3588s-cm5-io-dts-upstream-v5-3-8d96854a5bbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M75I2DDAzREF+U3N5R3jE+9h3CP+AdIQcXNJX1NwT26cXFbtJItDYeOS
	eIQvsjnFkSSfE8l0VP+fG169u+Yy8TPlpRX2rIZDh/PoJpUyo4dWIB8/CMHqvMsAPWzOBSW
	HfXagnkWGLQxigLRZUmJDJNJTrkLtc4/56Bod7mA6y1RtkzrVnVFCnhoIrhZUcNN97SAfIk
	gRiFwKA+DM/L/a7TiNlsSMIKKR91yCxBxSh2+Bia+NIHbCC3iKRDHOBz+T6mLAVMdEGwYW0
	H0pxlIi/G7kauTNN80JZvHKKgzaUOAe92KsTcLbRnEHG6XOor425Vq5zgeqXCaRBbIkd7WF
	MAmls1KZ0+hdZlhs8IX2ap3/O9P7GtSNimkCdBEc4H8McbVx/b1Li+OQsefaR8KtCY5WLK3
	brOVldZqjMT796ygPiJ/l0s0A+szWPgVJ8dAhCOq1XjZyF/NL8kBu8lo/5VAoiKtvdg0AK2
	uzbIVNVP3w81CNQ+XMnx2wJ/J1lVyYAVzrMp2Av2B/iTn79k6F3xA3kc1wpY/YCBe4eMxU1
	2lsxUjejspmuwhmUt+/UUw2ETEo9IsjIN0APCheDW0b+zfFAQb9dtsVTz8e4jDSPLAuQ5kR
	3zdI+9XI8MXaRDHsWDFU4v3XIl7U5ydTomsrDC2BZzq4b3tVIlOuD2o7T4cYq2TrxKcXJhk
	lfr0LX5sCTfDOiDj8WVPxbfaoBJlt7wb0Cn3NChMiwTW2CC2VlmXgZgpoaZ1MjkhqkweEKB
	NHdPfWxs1evP1HpYvSX6HSRuLX4T9rtJ5nYVBuUHmF3oo2qgQ8iofp4FxwKkdou8U/zB4il
	P43O216FKcE2y76jc0WMxmplM9O/OP7b+++f4dgt6sgaOIDJqbvuJ6f1f/4W1yrgSFuF/go
	teHajraZn+iPukSNjFHiDQgxYZB5lsFQAi3zMUbRb7y0Sg+Xvt0sE5brjg6TDY4KHsg2drr
	abnjnD6x4k8YycgYTZE0IXagnSZJbw4xsVXsa5vl5vKR1spjXf2H9S1ik
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hi Joseph,

On 6/18/25 07:12, Joseph Kogut wrote:
> Specification:
> - 1x HDMI
> - 2x MIPI DSI
> - 2x MIPI CSI
> - 1x eDP
> - 1x M.2 E key
> - 1x USB 3.0 Host
> - 1x USB 3.0 OTG
> - 2x USB 2.0 Host
> - Headphone jack w/ microphone
> - Gigabit Ethernet w/ PoE
> - microSD slot
> - 40-pin expansion header
> - 12V DC
> 
> Signed-off-by: Joseph Kogut <joseph.kogut@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>   .../boot/dts/rockchip/rk3588s-radxa-cm5-io.dts     | 486 +++++++++++++++++++++
>   2 files changed, 487 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 3e8771ef69ba1c1428117cc2ae29b84e13523e21..bc09420cacde4557c42935066e9f70bca1190f82 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -177,6 +177,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-odroid-m2.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5b.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-radxa-cm5-io.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5c.dtb
>   
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-radxa-cm5-io.dts b/arch/arm64/boot/dts/rockchip/rk3588s-radxa-cm5-io.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..18e11a9c7f03770c9b39056ccc91ae03a9d191c5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-radxa-cm5-io.dts
> @@ -0,0 +1,486 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2025 Joseph Kogut <joseph.kogut@gmail.com>
> + */
> +
> +/*
> + * CM5 IO board data sheet
> + * https://dl.radxa.com/cm5/v2200/radxa_cm5_io_v2200_schematic.pdf

The link from
  https://radxa.com/products/io-board/cm5-io-board#downloads
is
  https://dl.radxa.com/cm5/io_board_v2200/radxa_cm5_io_board_v2200_schematic.pdf.

(I think it's a mistake that the IO board schematic is under /v2200/, 
sorry!)

> + */
> +
> +/dts-v1/;
> +#include "rk3588s.dtsi"
> +#include "rk3588s-radxa-cm5.dtsi"
> +
> +/ {
> +	model = "Radxa Compute Module 5 (CM5) IO Board";
> +	compatible = "radxa,cm5-io", "radxa,cm5", "rockchip,rk3588s";
> +
> +	aliases {
> +		ethernet0 = &gmac1;
> +		mmc1 = &sdmmc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi0_out_con>;
> +			};
> +		};
> +	};
> +
> +	vcc12v_dcin: regulator-12v0-vcc-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc5v0_host: vcc5v0-host-regulator {

Node name should be '^regulator(-[0-9]+v[0-9]+|-[0-9a-z-]+)?$'.
Please see Documentation/devicetree/bindings/regulator/fixed-regulator.yaml.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_host";
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_host_en>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};

According to the schematic, the name of the regulator controlled by 
GPIO1_A0 is VCC5V0_USB1, its power supply is VCC5V0_USB, and its power 
supply is VCC12V_DCIN.
Also, the name of GPIO1_A0 is USB_HOST_PWREN_H.

> +	vcc5v0_sys: regulator-5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vbus5v0_typec: vbus5v0-typec {

Node name should be '^regulator(-[0-9]+v[0-9]+|-[0-9a-z-]+)?$'.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vbus5v0_typec";
> +		gpio = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vbus5v0_typec_en>;

The name of GPIO0_D5 is TYPEC5V_PWREN_H.

> +		enable-active-high;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc3v3_pcie: regulator-3v3-vcc-pcie {

Is it VCC3V3_WF?

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_pcie2x1l0";

I think the regulator-name should be aligned with the node label.

> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <50000>;
> +		vin-supply = <&vcc5v0_sys>;

pinctrl-* are missing.

> +	};
> +
> +	vcc_3v3_s0: pldo-reg4 {

Node name should be '^regulator(-[0-9]+v[0-9]+|-[0-9a-z-]+)?$'.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;

Are the following properties required?

> +		regulator-ramp-delay = <12500>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};

The power supply for VCC_3V3_S0 is VCC_3V3_S3.

> +	};
> +};
> +
> +&combphy0_ps {
> +	status = "okay";
> +};
> +
> +&combphy2_psu {
> +	status = "okay";
> +};
> +
> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-id";
> +	phy-supply = <&vcc_3v3_s0>;

VCC_3V3_S3?

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1_miim
> +		     &gmac1_tx_bus2
> +		     &gmac1_rx_bus2
> +		     &gmac1_rgmii_clk
> +		     &gmac1_rgmii_bus
> +		     &gmac1_clkinout>;
> +	status = "okay";
> +};
> +
> +&hdmi0 {
> +	status = "okay";
> +};
> +
> +&hdmi0_in {
> +	hdmi0_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi0>;
> +	};
> +};
> +
> +&hdmi0_out {
> +	hdmi0_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi0_sound {
> +	status = "okay";
> +};
> +
> +&hdptxphy0 {
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6m3_xfer>;
> +	status = "okay";
> +
> +	fusb302: usb-typec@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PC4 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbc0_int>;

CC_INT0_L?

> +		vbus-supply = <&vbus5v0_typec>;
> +
> +		connector {
> +			compatible = "usb-c-connector";
> +			data-role = "dual";
> +			label = "USB-C";
> +			power-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
> +			op-sink-microwatt = <1000000>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					usbc0_orientation_switch: endpoint {
> +						remote-endpoint = <&usbdp_phy0_orientation_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					usbc0_role_switch: endpoint {
> +						remote-endpoint = <&usb_host0_xhci_role_switch>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					usbc0_dp_altmode_mux: endpoint {
> +						remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2s5_8ch {
> +	status = "okay";
> +};
> +
> +&pcie2x1l2 {
> +	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	fusb302 {
> +		vbus5v0_typec_en: vbus5v0-typec-en {
> +			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		usbc0_int: usbc0-int {
> +			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	usb {
> +		vcc5v0_host_en: vcc5v0-host-en {
> +			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <200000000>;
> +	no-sdio;
> +	no-mmc;
> +	sd-uhs-sdr104;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_det>;
> +	vmmc-supply = <&vcc_3v3_s3>;
> +	vqmmc-supply = <&vccio_sd_s0>;
> +	status = "okay";
> +};
> +
> +&spi2 {
> +	assigned-clocks = <&cru CLK_SPI2>;
> +	assigned-clock-rates = <200000000>;
> +	num-cs = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> +	status = "okay";
> +
> +	pmic@0 {

The PMIC is on the CM5 board, not the IO board.

> +		compatible = "rockchip,rk806";
> +		reg = <0x0>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +		spi-max-frequency = <1000000>;
> +		system-power-controller;
> +
> +		vcc1-supply = <&vcc5v0_sys>;
> +		vcc2-supply = <&vcc5v0_sys>;
> +		vcc3-supply = <&vcc5v0_sys>;
> +		vcc4-supply = <&vcc5v0_sys>;
> +		vcc5-supply = <&vcc5v0_sys>;
> +		vcc6-supply = <&vcc5v0_sys>;
> +		vcc7-supply = <&vcc5v0_sys>;
> +		vcc8-supply = <&vcc5v0_sys>;
> +		vcc9-supply = <&vcc5v0_sys>;
> +		vcc10-supply = <&vcc5v0_sys>;

These are supplied by VCC_SYSIN, which is supplied by VCC5V0_SYS.

> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> +		vcc12-supply = <&vcc5v0_sys>;

VCC_SYSIN.

> +		vcc13-supply = <&vdd2_ddr_s3>;
> +		vcc14-supply = <&vdd2_ddr_s3>;

These are supplied by VCC_1V1_NLDO_S3, which is supplied by VCC_SYSIN.

> +		vcca-supply = <&vcc5v0_sys>;

VCC_SYSIN.

> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		rk806_dvs1_null: dvs1-null-pins {
> +			pins = "gpio_pwrctrl1";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs2_null: dvs2-null-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs3_null: dvs3-null-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun0";
> +		};
> +
> +		regulators {
> +			vdd_gpu_s0: dcdc-reg1 {
> +				regulator-name = "vdd_gpu_s0";
> +				regulator-boot-on;
> +				regulator-enable-ramp-delay = <400>;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_lit_s0: dcdc-reg2 {
> +				regulator-name = "vdd_cpu_lit_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};

I think dcdc-reg3, dcdc-reg4 and dcdc-reg5 should also be defined.

> +			vccio_sd_s0: pldo-reg5 {

Please move pldo-* further down.

> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vccio_sd_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd2_ddr_s3: dcdc-reg6 {
> +				regulator-name = "vdd2_ddr_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_2v0_pldo_s3: dcdc-reg7 {
> +				regulator-name = "vdd_2v0_pldo_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <2000000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <2000000>;
> +				};
> +			};
> +
> +			vcc_3v3_s3: dcdc-reg8 {
> +				regulator-name = "vcc_3v3_s3";
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

I think dcdc-reg9, dcdc-reg10, pldo-* and nldo-* should also be defined.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> +		};
> +	};
> +};
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&u2phy2 {
> +	status = "okay";
> +};
> +
> +&u2phy2_host {
> +	status = "okay";
> +};
> +
> +&u2phy3 {
> +	status = "okay";
> +};
> +
> +&u2phy3_host {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2m0_xfer>;
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
> +	dr_mode = "otg";
> +	usb-role-switch;
> +	status = "okay";
> +
> +	port {
> +		usb_host0_xhci_role_switch: endpoint {
> +			remote-endpoint = <&usbc0_role_switch>;
> +		};
> +	};
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
> +&usb_host2_xhci {
> +	status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +	mode-switch;
> +	orientation-switch;
> +	sbu1-dc-gpios = <&gpio3 RK_PC4 GPIO_ACTIVE_HIGH>;
> +	sbu2-dc-gpios = <&gpio3 RK_PD4 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usbdp_phy0_orientation_switch: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&usbc0_orientation_switch>;
> +		};
> +
> +		usbdp_phy0_dp_altmode_mux: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&usbc0_dp_altmode_mux>;
> +		};
> +	};
> +};
> +
> +&vop {
> +	status = "okay";
> +};
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi0_in_vp0>;
> +	};
> +};



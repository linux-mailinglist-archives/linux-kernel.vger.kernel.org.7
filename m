Return-Path: <linux-kernel+bounces-834368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53220BA48CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586861C06658
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D168233149;
	Fri, 26 Sep 2025 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="hBQRJu/Y"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A223313E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902903; cv=none; b=rKQaXKuerfs+5tO3AkZdPtY/Yzv+j428a70aILXS3eJcQhTqh54yRzCjMgFnYxCRRqKwTytFLu9QMl1NUKsPVSNLslrVeoYtTKu0dqkYqh1wvRPxV6DXQgd7qNqF83VfgV6ajKL94b2z0mEB+S1mBtCBgZIp1ZHdZf9Wy846h2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902903; c=relaxed/simple;
	bh=IdD3EJuUMekrbcqcI5PPOuQkfqCe/bqm8D2SgNgW3LI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=LL4hJsexCb61pGhWVKkZGuh0jFuFEeLfM6TNKBzQZPI0AegsYjBTYf12rlz/lpqsxeUsZgDUf3e7nLtMzGms3/l6n3oKr8CuI/01wkpBBYna+WwbFxaq4ZVE5vhrlWKXgzLtZt8sOpAWnQoN66z008IJZ2a4dFCJKJmfz0hCGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=hBQRJu/Y; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1758902896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2OMyj3O7OoFdc9oKmYXak3kh2Mqv9iUCKftoUYAOyY=;
	b=hBQRJu/YcqEV6GZncVT7vBvnAQsjiadLxD5elTKTAmxktjspMfdvXpKzpFZyZFl9Xz7fjB
	25HBeQu8gdqDFjqC1NZGcOb6eFxROA0UKWoQ6u00coqAN99hd9DevPCB460BXUAmGAwNn4
	Peg6/qZ0JBqqriJ8Rar/cYbv2gj5BqDj/i/TecHqws+DkcNNXKrBnXDNrWjKERELRnCbPb
	mFwSOkV4TE6nM74eMjgEyZBrHYlXOf7viEmy4s6Ae485loSpJxc9OjytCxWOKs/1ARGHMn
	c463bJC4k67BUBDiduWsbcE6kwZGhjdN+hvTIti6XNucRtSG8aOdJo4kCyp5CA==
Content-Type: multipart/signed;
 boundary=638a7dddfdd606a24de17a599a459483ce2d45af3a7b72e9a7d0a1173dc2;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 26 Sep 2025 18:07:58 +0200
Message-Id: <DD2V17FJ29MV.3YDX1VUWGKEH@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Tianling Shen" <cnsztl@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Dragan Simic"
 <dsimic@manjaro.org>, "Jonas Karlman" <jonas@kwiboo.se>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add devicetree for the
 FriendlyElec NanoPi R76S
References: <20250922091509.2695565-1-cnsztl@gmail.com>
 <20250922091509.2695565-2-cnsztl@gmail.com>
In-Reply-To: <20250922091509.2695565-2-cnsztl@gmail.com>
X-Migadu-Flow: FLOW_OUT

--638a7dddfdd606a24de17a599a459483ce2d45af3a7b72e9a7d0a1173dc2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Sep 22, 2025 at 11:15 AM CEST, Tianling Shen wrote:
> The NanoPi R76S (as "R76S") is an open-sourced mini IoT gateway
> device with two 2.5G, designed and developed by FriendlyElec.
>
> Specification:
> - Rockchip RK3576
> - 2/4GB LPDDR4X RAM
> - 2x 2500Base-T (PCIe, rtl8125b)
> - 3x LEDs (Power, LAN, WAN)
> - 32GB eMMC
> - MicroSD Slot
> - MDMI 1.4/2.0 OUT
> - M.2 E-Key SDIO slot
> - USB 3.0 Port
> - USB Type-C 5V Power
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3576-nanopi-r76s.dts  | 860 ++++++++++++++++++
>  2 files changed, 861 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/=
rockchip/Makefile
> index ad684e3831bc..2d4a1e29db6f 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -155,6 +155,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-armsom-sige5-=
v1.2-wifibt.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-luckfox-omni3576.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-nanopi-m5.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-nanopi-r76s.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-rock-4d.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3582-radxa-e52c.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts b/arch/a=
rm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
> new file mode 100644
> index 000000000000..731789a69677
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
> @@ -0,0 +1,860 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2025 FriendlyElec Computer Tech. Co., Ltd.
> + * (http://www.friendlyelec.com)
> + *
> + * Copyright (c) 2025 Tianling Shen <cnsztl@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +
> +#include "rk3576.dtsi"
> +
> +/ {
> +	model =3D "FriendlyElec NanoPi R76S";
> +	compatible =3D "friendlyarm,nanopi-r76s", "rockchip,rk3576";
> +
> +	aliases {
> +		mmc0 =3D &sdhci;
> +		mmc1 =3D &sdmmc;
> +		mmc2 =3D &sdio;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:1500000n8";
> +	};
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&reset_button_pin>;
> +
> +		button-reset {
> +			label =3D "reset";
> +			gpios =3D <&gpio4 RK_PA2 GPIO_ACTIVE_LOW>;
> +			debounce-interval =3D <50>;
> +			linux,code =3D <KEY_RESTART>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible =3D "gpio-leds";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&lan_led_pin>, <&power_led_pin>, <&wan_led_pin>;

It is recommended to use the labels in the schematics to define the
pinctl nodes (and thus their references). In quite a lot of cases that's
indeed the case, but not for gpio-keys (USER_BUT) or these gpio-leds
pinctls.

> +
> +		led-0 {
> +			color =3D <LED_COLOR_ID_GREEN>;
> +			function =3D LED_FUNCTION_LAN;
> +			gpios =3D <&gpio2 RK_PB0 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		power_led: led-1 {

power_led is never referenced, so you can drop it.

Cheers,
  Diederik

> +			color =3D <LED_COLOR_ID_RED>;
> +			function =3D LED_FUNCTION_POWER;
> +			gpios =3D <&gpio2 RK_PB3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger =3D "heartbeat";
> +		};
> +
> +		led-2 {
> +			color =3D <LED_COLOR_ID_GREEN>;
> +			function =3D LED_FUNCTION_WAN;
> +			gpios =3D <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	hdmi-con {
> +		compatible =3D "hdmi-connector";
> +		hdmi-pwr-supply =3D <&vcc5v_hdmi_tx>;
> +		type =3D "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint =3D <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		clocks =3D <&hym8563>;
> +		clock-names =3D "ext_clock";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&wifi_reg_on_h>;
> +		post-power-on-delay-ms =3D <200>;
> +		reset-gpios =3D <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	vcc5v_dcin: regulator-vcc5v-dcin {
> +		compatible =3D "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-name =3D "vcc5v_dcin";
> +	};
> +
> +	vcc5v_hdmi_tx: regulator-vcc5v-hdmi-tx {
> +		compatible =3D "regulator-fixed";
> +		enable-active-high;
> +		gpios =3D <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&hdmi_tx_on_h>;
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-name =3D "vcc5v_hdmi_tx";
> +		vin-supply =3D <&vcc5v0_sys_s5>;
> +	};
> +
> +	vcc3v3_rtc_s5: regulator-vcc3v3-rtc-s5 {
> +		compatible =3D "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-name =3D "vcc3v3_rtc_s5";
> +		vin-supply =3D <&vcc5v0_sys_s5>;
> +	};
> +
> +	vcc5v0_device_s0: regulator-vcc5v0-device-s0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-name =3D "vcc5v0_device_s0";
> +		vin-supply =3D <&vcc5v_dcin>;
> +	};
> +
> +	vcc5v0_sys_s5: regulator-vcc5v0-sys-s5 {
> +		compatible =3D "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-name =3D "vcc5v0_sys_s5";
> +		vin-supply =3D <&vcc5v_dcin>;
> +	};
> +
> +	vcc5v0_usb_otg0: regulator-vcc5v0-usb-otg0 {
> +		compatible =3D "regulator-fixed";
> +		enable-active-high;
> +		gpios =3D <&gpio0 RK_PD1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&usb_otg0_pwren_h>;
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-name =3D "vcc5v0_usb_otg0";
> +		vin-supply =3D <&vcc5v0_sys_s5>;
> +	};
> +
> +	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <1100000>;
> +		regulator-max-microvolt =3D <1100000>;
> +		regulator-name =3D "vcc_1v1_nldo_s3";
> +		vin-supply =3D <&vcc5v0_sys_s5>;
> +	};
> +
> +	vcc_1v8_s0: regulator-vcc-1v8-s0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		regulator-name =3D "vcc_1v8_s0";
> +		vin-supply =3D <&vcc_1v8_s3>;
> +	};
> +
> +	vcc_2v0_pldo_s3: regulator-vcc-2v0-pldo-s3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <2000000>;
> +		regulator-max-microvolt =3D <2000000>;
> +		regulator-name =3D "vcc_2v0_pldo_s3";
> +		vin-supply =3D <&vcc5v0_sys_s5>;
> +	};
> +
> +	vcc_3v3_s0: regulator-vcc-3v3-s0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-name =3D "vcc_3v3_s0";
> +		vin-supply =3D <&vcc_3v3_s3>;
> +	};
> +};
> +
> +&combphy0_ps {
> +	status =3D "okay";
> +};
> +
> +&combphy1_psu {
> +	status =3D "okay";
> +};
> +
> +&cpu_b0 {
> +	cpu-supply =3D <&vdd_cpu_big_s0>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply =3D <&vdd_cpu_big_s0>;
> +};
> +
> +&cpu_b2 {
> +	cpu-supply =3D <&vdd_cpu_big_s0>;
> +};
> +
> +&cpu_b3 {
> +	cpu-supply =3D <&vdd_cpu_big_s0>;
> +};
> +
> +&cpu_l0 {
> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&gpu {
> +	mali-supply =3D <&vdd_gpu_s0>;
> +	status =3D "okay";
> +};
> +
> +&hdmi {
> +	status =3D "okay";
> +};
> +
> +&hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint =3D <&vp0_out_hdmi>;
> +	};
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint =3D <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi_sound {
> +	status =3D "okay";
> +};
> +
> +&hdptxphy {
> +	status =3D "okay";
> +};
> +
> +&i2c1 {
> +	status =3D "okay";
> +
> +	pmic@23 {
> +		compatible =3D "rockchip,rk806";
> +		reg =3D <0x23>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		interrupt-parent =3D <&gpio0>;
> +		interrupts =3D <6 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pmic_pins>, <&rk806_dvs1_null>,
> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +		system-power-controller;
> +
> +		vcc1-supply =3D <&vcc5v0_sys_s5>;
> +		vcc2-supply =3D <&vcc5v0_sys_s5>;
> +		vcc3-supply =3D <&vcc5v0_sys_s5>;
> +		vcc4-supply =3D <&vcc5v0_sys_s5>;
> +		vcc5-supply =3D <&vcc5v0_sys_s5>;
> +		vcc6-supply =3D <&vcc5v0_sys_s5>;
> +		vcc7-supply =3D <&vcc5v0_sys_s5>;
> +		vcc8-supply =3D <&vcc5v0_sys_s5>;
> +		vcc9-supply =3D <&vcc5v0_sys_s5>;
> +		vcc10-supply =3D <&vcc5v0_sys_s5>;
> +		vcc11-supply =3D <&vcc_2v0_pldo_s3>;
> +		vcc12-supply =3D <&vcc5v0_sys_s5>;
> +		vcc13-supply =3D <&vcc_1v1_nldo_s3>;
> +		vcc14-supply =3D <&vcc_1v1_nldo_s3>;
> +		vcca-supply =3D <&vcc5v0_sys_s5>;
> +
> +		rk806_dvs1_null: dvs1-null-pins {
> +			pins =3D "gpio_pwrctrl1";
> +			function =3D "pin_fun0";
> +		};
> +
> +		rk806_dvs1_pwrdn: dvs1-pwrdn-pins {
> +			pins =3D "gpio_pwrctrl1";
> +			function =3D "pin_fun2";
> +		};
> +
> +		rk806_dvs1_rst: dvs1-rst-pins {
> +			pins =3D "gpio_pwrctrl1";
> +			function =3D "pin_fun3";
> +		};
> +
> +		rk806_dvs1_slp: dvs1-slp-pins {
> +			pins =3D "gpio_pwrctrl1";
> +			function =3D "pin_fun1";
> +		};
> +
> +		rk806_dvs2_dvs: dvs2-dvs-pins {
> +			pins =3D "gpio_pwrctrl2";
> +			function =3D "pin_fun4";
> +		};
> +
> +		rk806_dvs2_gpio: dvs2-gpio-pins {
> +			pins =3D "gpio_pwrctrl2";
> +			function =3D "pin_fun5";
> +		};
> +
> +		rk806_dvs2_null: dvs2-null-pins {
> +			pins =3D "gpio_pwrctrl2";
> +			function =3D "pin_fun0";
> +		};
> +
> +		rk806_dvs2_pwrdn: dvs2-pwrdn-pins {
> +			pins =3D "gpio_pwrctrl2";
> +			function =3D "pin_fun2";
> +		};
> +
> +		rk806_dvs2_rst: dvs2-rst-pins {
> +			pins =3D "gpio_pwrctrl2";
> +			function =3D "pin_fun3";
> +		};
> +
> +		rk806_dvs2_slp: dvs2-slp-pins {
> +			pins =3D "gpio_pwrctrl2";
> +			function =3D "pin_fun1";
> +		};
> +
> +		rk806_dvs3_dvs: dvs3-dvs-pins {
> +			pins =3D "gpio_pwrctrl3";
> +			function =3D "pin_fun4";
> +		};
> +
> +		rk806_dvs3_gpio: dvs3-gpio-pins {
> +			pins =3D "gpio_pwrctrl3";
> +			function =3D "pin_fun5";
> +		};
> +
> +		rk806_dvs3_null: dvs3-null-pins {
> +			pins =3D "gpio_pwrctrl3";
> +			function =3D "pin_fun0";
> +		};
> +
> +		rk806_dvs3_pwrdn: dvs3-pwrdn-pins {
> +			pins =3D "gpio_pwrctrl3";
> +			function =3D "pin_fun2";
> +		};
> +
> +		rk806_dvs3_rst: dvs3-rst-pins {
> +			pins =3D "gpio_pwrctrl3";
> +			function =3D "pin_fun3";
> +		};
> +
> +		rk806_dvs3_slp: dvs3-slp-pins {
> +			pins =3D "gpio_pwrctrl3";
> +			function =3D "pin_fun1";
> +		};
> +
> +		regulators {
> +			vdd_cpu_big_s0: dcdc-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-enable-ramp-delay =3D <400>;
> +				regulator-min-microvolt =3D <550000>;
> +				regulator-max-microvolt =3D <950000>;
> +				regulator-name =3D "vdd_cpu_big_s0";
> +				regulator-ramp-delay =3D <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu_s0: dcdc-reg2 {
> +				regulator-boot-on;
> +				regulator-enable-ramp-delay =3D <400>;
> +				regulator-min-microvolt =3D <550000>;
> +				regulator-max-microvolt =3D <950000>;
> +				regulator-name =3D "vdd_npu_s0";
> +				regulator-ramp-delay =3D <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_lit_s0: dcdc-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <550000>;
> +				regulator-max-microvolt =3D <950000>;
> +				regulator-name =3D "vdd_cpu_lit_s0";
> +				regulator-ramp-delay =3D <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt =3D <750000>;
> +				};
> +			};
> +
> +			vcc_3v3_s3: dcdc-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc_3v3_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D <3300000>;
> +				};
> +			};
> +
> +			vdd_gpu_s0: dcdc-reg5 {
> +				regulator-boot-on;
> +				regulator-enable-ramp-delay =3D <400>;
> +				regulator-min-microvolt =3D <550000>;
> +				regulator-max-microvolt =3D <900000>;
> +				regulator-name =3D "vdd_gpu_s0";
> +				regulator-ramp-delay =3D <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt =3D <850000>;
> +				};
> +			};
> +
> +			vddq_ddr_s0: dcdc-reg6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name =3D "vddq_ddr_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_logic_s0: dcdc-reg7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <550000>;
> +				regulator-max-microvolt =3D <800000>;
> +				regulator-name =3D "vdd_logic_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_s3: dcdc-reg8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-name =3D "vcc_1v8_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D <1800000>;
> +				};
> +			};
> +
> +			vdd2_ddr_s3: dcdc-reg9 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name =3D "vdd2_ddr_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_ddr_s0: dcdc-reg10 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <550000>;
> +				regulator-max-microvolt =3D <1200000>;
> +				regulator-name =3D "vdd_ddr_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca_1v8_s0: pldo-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-name =3D "vcca_1v8_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pldo2_s0: pldo-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-name =3D "vcca1v8_pldo2_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_1v2_s0: pldo-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <1200000>;
> +				regulator-max-microvolt =3D <1200000>;
> +				regulator-name =3D "vdda_1v2_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca_3v3_s0: pldo-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcca_3v3_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd_s0: pldo-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vccio_sd_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pldo6_s3: pldo-reg6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-name =3D "vcca1v8_pldo6_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D <1800000>;
> +				};
> +			};
> +
> +			vdd_0v75_s3: nldo-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <750000>;
> +				regulator-max-microvolt =3D <750000>;
> +				regulator-name =3D "vdd_0v75_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D <750000>;
> +				};
> +			};
> +
> +			vdda_ddr_pll_s0: nldo-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <850000>;
> +				regulator-max-microvolt =3D <850000>;
> +				regulator-name =3D "vdda_ddr_pll_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v75_hdmi_s0: nldo-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <837500>;
> +				regulator-max-microvolt =3D <837500>;
> +				regulator-name =3D "vdda0v75_hdmi_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v85_s0: nldo-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <850000>;
> +				regulator-max-microvolt =3D <850000>;
> +				regulator-name =3D "vdda_0v85_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v75_s0: nldo-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <750000>;
> +				regulator-max-microvolt =3D <750000>;
> +				regulator-name =3D "vdda_0v75_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	status =3D "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible =3D "haoyu,hym8563";
> +		reg =3D <0x51>;
> +		#clock-cells =3D <0>;
> +		clock-output-names =3D "hym8563";
> +		interrupt-parent =3D <&gpio0>;
> +		interrupts =3D <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&rtc_int_l>;
> +		wakeup-source;
> +	};
> +};
> +
> +&pcie0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie0_perstn>;
> +	reset-gpios =3D <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply =3D <&vcc_3v3_s3>;
> +	status =3D "okay";
> +};
> +
> +&pcie1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie1_perstn>;
> +	reset-gpios =3D <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply =3D <&vcc_3v3_s3>;
> +	status =3D "okay";
> +};
> +
> +&pinctrl {
> +	bt {
> +		bt_reg_on_h: bt-reg-on-h {
> +			rockchip,pins =3D <3 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		bt_wake_host_h: bt-wake-host-h {
> +			rockchip,pins =3D <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		host_wake_bt_h: host-wake-bt-h {
> +			rockchip,pins =3D <3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		reset_button_pin: reset-button-pin {
> +			rockchip,pins =3D <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		lan_led_pin: lan-led-pin {
> +			rockchip,pins =3D <2 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		power_led_pin: power-led-pin {
> +			rockchip,pins =3D <2 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		wan_led_pin: wan-led-pin {
> +			rockchip,pins =3D <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	hdmi {
> +		hdmi_tx_on_h: hdmi-tx-on-h {
> +			rockchip,pins =3D <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	hym8563 {
> +		rtc_int_l: rtc-int-l {
> +			rockchip,pins =3D <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	pcie {
> +		pcie0_perstn: pcie0-perstn {
> +			rockchip,pins =3D <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		pcie1_perstn: pcie1-perstn {
> +			rockchip,pins =3D <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	usb {
> +		usb_otg0_pwren_h: usb-otg0-pwren-h {
> +			rockchip,pins =3D <0 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	wifi {
> +		wifi_wake_host_h: wifi-wake-host-h {
> +			rockchip,pins =3D <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		wifi_reg_on_h: wifi-reg-on-h {
> +			rockchip,pins =3D <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&sai6 {
> +	status =3D "okay";
> +};
> +
> +&sdmmc {
> +	bus-width =3D <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	no-mmc;
> +	no-sdio;
> +	sd-uhs-sdr104;
> +	vmmc-supply =3D <&vcc_3v3_s3>;
> +	vqmmc-supply =3D <&vccio_sd_s0>;
> +	status =3D "okay";
> +};
> +
> +&sdio {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	bus-width =3D <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	disable-wp;
> +	keep-power-in-suspend;
> +	mmc-pwrseq =3D <&sdio_pwrseq>;
> +	no-mmc;
> +	no-sd;
> +	non-removable;
> +	sd-uhs-sdr104;
> +	vmmc-supply =3D <&vcc_3v3_s3>;
> +	vqmmc-supply =3D <&vcc_1v8_s3>;
> +	wakeup-source;
> +	status =3D "okay";
> +
> +	rtl8822cs: wifi@1 {
> +		reg =3D <1>;
> +		interrupt-parent =3D <&gpio0>;
> +		interrupts =3D <RK_PB0 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names =3D "host-wake";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&wifi_wake_host_h>;
> +	};
> +};
> +
> +&sdhci {
> +	bus-width =3D <8>;
> +	cap-mmc-highspeed;
> +	full-pwr-cycle-in-suspend;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	status =3D "okay";
> +};
> +
> +&saradc {
> +	vref-supply =3D <&vcca_1v8_s0>;
> +	status =3D "okay";
> +};
> +
> +&u2phy0 {
> +	status =3D "okay";
> +};
> +
> +&u2phy0_otg {
> +	phy-supply =3D <&vcc5v0_usb_otg0>;
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> +
> +&uart5 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart5m0_xfer &uart5m0_ctsn &uart5m0_rtsn>;
> +	uart-has-rtscts;
> +	status =3D "okay";
> +
> +	bluetooth {
> +		compatible =3D "realtek,rtl8822cs-bt";
> +		enable-gpios =3D <&gpio3 RK_PC7 GPIO_ACTIVE_HIGH>;
> +		device-wake-gpios =3D <&gpio3 RK_PD0 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios =3D <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&bt_wake_host_h &host_wake_bt_h &bt_reg_on_h>;
> +	};
> +};
> +
> +&usbdp_phy {
> +	status =3D "okay";
> +};
> +
> +&usb_drd0_dwc3 {
> +	dr_mode =3D "host";
> +	extcon =3D <&u2phy0>;
> +	status =3D "okay";
> +};
> +
> +&vop {
> +	status =3D "okay";
> +};
> +
> +&vop_mmu {
> +	status =3D "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg =3D <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint =3D <&hdmi_in_vp0>;
> +	};
> +};


--638a7dddfdd606a24de17a599a459483ce2d45af3a7b72e9a7d0a1173dc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaNa6YAAKCRDXblvOeH7b
bsz1AP9FERPh1ByUASXZQXPFGPltiyL5SZBsSE2dWTta8f9o3QD/fWdNBdJNxxbw
FuV9ZvEH7VhO97f8uNqYoy9XZ/zT2Qw=
=w76L
-----END PGP SIGNATURE-----

--638a7dddfdd606a24de17a599a459483ce2d45af3a7b72e9a7d0a1173dc2--


Return-Path: <linux-kernel+bounces-834853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542C6BA5A4F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0923A47DE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2872C236D;
	Sat, 27 Sep 2025 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="0E/3zNVl"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E422A4EA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758958667; cv=none; b=k5yPp96aivRImXZn3IPGdMZRZZeTQdusfjMjIKKp6qiYIpGMSnkyZaDdqFQfdt6RNb9eoaabVfS/Adja4PUPuUZjdWjdQEZZauRleq2kJfq/OURyr2/CWxbMnQnwxJLNhFNqXDAhj78DKJmeBHejYUeHm99gF8OteA51zecMr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758958667; c=relaxed/simple;
	bh=R88CjF5E8Uc2sOAvU2fuNtYjM+blGUpBjakCtD7QEs8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k2A+2waKFoaTnQRdnklOJl3g7Fj/8mfmrSPnLC/kdppzzQkXJT4E3qqF/30NFDBDPmiblQhIKNly+bo3LuHsK/LUm1H8/vvERJ3aqVkaQhnLpnko+xOcB52+59z2+9GtgcoDg52OiuBKkuB2I0Xu3PCO7OPVWaP0znNgCnQtxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=0E/3zNVl; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1758958652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faD3rVilkwc5sDFUF9sjivMsIvmbM/XwTP6AG6is/2A=;
	b=0E/3zNVlMNctJ2cfOpqZ7nBD7ZnJ7qItHZha/v4XAW8HjgxBlNkd8RTZN9ejsfVIlidAWi
	aSzdDKHA+9Vwf01+8GfE8NwdQ5KttLZu+R3H+RUmh3JrM85K/rQJHt+VBH7ooNSynNzMz7
	gHEdsMMgiBHyDO3AhUy110Y5yhheW5f1ECciKgR2unz0C57p7JT62BrOoKzP4jyOIvc4yY
	ke+RSiMpdvH8CHxuLdhhtOVAgrMyexk4VQzegUhSxXaWlEm/hvy+3ajiBG+NuvQ3GipfQO
	1SX0si4W7FC9csv9HhqASXT3100oE+aaJaZ03LjKp/AOILepQXGy6L+NmTYpXQ==
Content-Type: multipart/signed;
 boundary=5607581fafb5bfba5a0fbfae40896bc28ba6ec1b91c559ddb9802e4fbb76;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 27 Sep 2025 09:37:23 +0200
Message-Id: <DD3EST9Y5UHF.12FJMDJUSZNYL@cknow.org>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add devicetree for the
 FriendlyElec NanoPi R76S
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Tianling Shen" <cnsztl@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Dragan Simic"
 <dsimic@manjaro.org>, "Jonas Karlman" <jonas@kwiboo.se>
References: <20250922091509.2695565-1-cnsztl@gmail.com>
 <20250922091509.2695565-2-cnsztl@gmail.com>
 <DD2V17FJ29MV.3YDX1VUWGKEH@cknow.org>
 <1bb00ad6-ffe1-4783-909b-032dfb984180@gmail.com>
In-Reply-To: <1bb00ad6-ffe1-4783-909b-032dfb984180@gmail.com>
X-Migadu-Flow: FLOW_OUT

--5607581fafb5bfba5a0fbfae40896bc28ba6ec1b91c559ddb9802e4fbb76
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Sep 27, 2025 at 3:19 AM CEST, Tianling Shen wrote:
> On 2025/9/27 0:07, Diederik de Haas wrote:
>> On Mon Sep 22, 2025 at 11:15 AM CEST, Tianling Shen wrote:
>>> The NanoPi R76S (as "R76S") is an open-sourced mini IoT gateway
>>> device with two 2.5G, designed and developed by FriendlyElec.
>>>
>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>> ---
>>>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>>   .../boot/dts/rockchip/rk3576-nanopi-r76s.dts  | 860 +++++++++++++++++=
+
>>>   2 files changed, 861 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dt=
s
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dt=
s/rockchip/Makefile
>>> index ad684e3831bc..2d4a1e29db6f 100644
>>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>>> @@ -155,6 +155,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-armsom-sige=
5-v1.2-wifibt.dtbo
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-evb1-v10.dtb
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-luckfox-omni3576.dtb
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-nanopi-m5.dtb
>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-nanopi-r76s.dtb
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-roc-pc.dtb
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-rock-4d.dtb
>>>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3582-radxa-e52c.dtb
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts b/arch=
/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
>>> new file mode 100644
>>> index 000000000000..731789a69677
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
>>> @@ -0,0 +1,860 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>>> +/*
>>> + * Copyright (c) 2025 FriendlyElec Computer Tech. Co., Ltd.
>>> + * (http://www.friendlyelec.com)
>>> + *
>>> + * Copyright (c) 2025 Tianling Shen <cnsztl@gmail.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/leds/common.h>
>>> +#include <dt-bindings/pinctrl/rockchip.h>
>>> +#include <dt-bindings/soc/rockchip,vop2.h>
>>> +
>>> +#include "rk3576.dtsi"
>>> +
>>> +/ {
>>> +	model =3D "FriendlyElec NanoPi R76S";
>>> +	compatible =3D "friendlyarm,nanopi-r76s", "rockchip,rk3576";
>>> +
>>> +	aliases {
>>> +		mmc0 =3D &sdhci;
>>> +		mmc1 =3D &sdmmc;
>>> +		mmc2 =3D &sdio;
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path =3D "serial0:1500000n8";
>>> +	};
>>> +
>>> +	gpio-keys {
>>> +		compatible =3D "gpio-keys";
>>> +		pinctrl-names =3D "default";
>>> +		pinctrl-0 =3D <&reset_button_pin>;
>>> +
>>> +		button-reset {
>>> +			label =3D "reset";
>>> +			gpios =3D <&gpio4 RK_PA2 GPIO_ACTIVE_LOW>;
>>> +			debounce-interval =3D <50>;
>>> +			linux,code =3D <KEY_RESTART>;
>>> +			wakeup-source;
>>> +		};
>>> +	};
>>> +
>>> +	gpio-leds {
>>> +		compatible =3D "gpio-leds";
>>> +		pinctrl-names =3D "default";
>>> +		pinctrl-0 =3D <&lan_led_pin>, <&power_led_pin>, <&wan_led_pin>;
>>=20
>> It is recommended to use the labels in the schematics to define the
>> pinctl nodes (and thus their references). In quite a lot of cases that's
>> indeed the case, but not for gpio-keys (USER_BUT) or these gpio-leds
>> pinctls.
>
> I cannot find any specific naming rules from the gpio-keys[1] and=20
> gpio-leds[2] bindings, did I miss any update?
>
> I think this naming matches the current practice at least in rockchip's=
=20
> dt tree.

There is an unofficial rule/aim:
https://lore.kernel.org/linux-rockchip/5360173.ktpJ11cQ8Q@diego/
But granted, there is 'some' inconsistency.

And used in f.e.
https://lore.kernel.org/linux-rockchip/20250727144409.327740-4-jonas@kwiboo=
.se/

Where you can just copy the pinctrl labels from the dts[i] and paste
that in the schematic document and you're instantly at the right place.
Which is the exact purpose of that rule/aim.

> 1.=20
> https://www.kernel.org/doc/Documentation/devicetree/bindings/input/gpio-k=
eys.yaml
> 2.=20
> https://www.kernel.org/doc/Documentation/devicetree/bindings/leds/leds-gp=
io.yaml
>
>>=20
>>> +
>>> +		led-0 {
>>> +			color =3D <LED_COLOR_ID_GREEN>;
>>> +			function =3D LED_FUNCTION_LAN;
>>> +			gpios =3D <&gpio2 RK_PB0 GPIO_ACTIVE_HIGH>;
>>> +		};
>>> +
>>> +		power_led: led-1 {
>>=20
>> power_led is never referenced, so you can drop it.
>>=20
>
> This will be used by some downstream projects but I'm fine to remove it=
=20
> here.

I'm guessing OpenWrt and I have no problem to accomodate them, but I
don't know if that should be present in the upstream dts file. And if
so, whether that should be mentioned in the commit message (or not).
AFAIUI OpenWrt patches the (power-)LED definition anyway.=20

Cheers,
  Diederik

>>> +			color =3D <LED_COLOR_ID_RED>;
>>> +			function =3D LED_FUNCTION_POWER;
>>> +			gpios =3D <&gpio2 RK_PB3 GPIO_ACTIVE_HIGH>;
>>> +			linux,default-trigger =3D "heartbeat";
>>> +		};
>>> +
>>> +		led-2 {
>>> +			color =3D <LED_COLOR_ID_GREEN>;
>>> +			function =3D LED_FUNCTION_WAN;
>>> +			gpios =3D <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
>>> +		};
>>> +	};
>>> +
>>> +	hdmi-con {
>>> +		compatible =3D "hdmi-connector";
>>> +		hdmi-pwr-supply =3D <&vcc5v_hdmi_tx>;
>>> +		type =3D "a";
>>> +
>>> +		port {
>>> +			hdmi_con_in: endpoint {
>>> +				remote-endpoint =3D <&hdmi_out_con>;
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	sdio_pwrseq: sdio-pwrseq {
>>> +		compatible =3D "mmc-pwrseq-simple";
>>> +		clocks =3D <&hym8563>;
>>> +		clock-names =3D "ext_clock";
>>> +		pinctrl-names =3D "default";
>>> +		pinctrl-0 =3D <&wifi_reg_on_h>;
>>> +		post-power-on-delay-ms =3D <200>;
>>> +		reset-gpios =3D <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
>>> +	};
>>> +
>>> +	vcc5v_dcin: regulator-vcc5v-dcin {
>>> +		compatible =3D "regulator-fixed";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt =3D <5000000>;
>>> +		regulator-max-microvolt =3D <5000000>;
>>> +		regulator-name =3D "vcc5v_dcin";
>>> +	};
>>> +
>>> +	vcc5v_hdmi_tx: regulator-vcc5v-hdmi-tx {
>>> +		compatible =3D "regulator-fixed";
>>> +		enable-active-high;
>>> +		gpios =3D <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names =3D "default";
>>> +		pinctrl-0 =3D <&hdmi_tx_on_h>;
>>> +		regulator-min-microvolt =3D <5000000>;
>>> +		regulator-max-microvolt =3D <5000000>;
>>> +		regulator-name =3D "vcc5v_hdmi_tx";
>>> +		vin-supply =3D <&vcc5v0_sys_s5>;
>>> +	};
>>> +
>>> +	vcc3v3_rtc_s5: regulator-vcc3v3-rtc-s5 {
>>> +		compatible =3D "regulator-fixed";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt =3D <3300000>;
>>> +		regulator-max-microvolt =3D <3300000>;
>>> +		regulator-name =3D "vcc3v3_rtc_s5";
>>> +		vin-supply =3D <&vcc5v0_sys_s5>;
>>> +	};
>>> +
>>> +	vcc5v0_device_s0: regulator-vcc5v0-device-s0 {
>>> +		compatible =3D "regulator-fixed";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt =3D <5000000>;
>>> +		regulator-max-microvolt =3D <5000000>;
>>> +		regulator-name =3D "vcc5v0_device_s0";
>>> +		vin-supply =3D <&vcc5v_dcin>;
>>> +	};
>>> +
>>> +	vcc5v0_sys_s5: regulator-vcc5v0-sys-s5 {
>>> +		compatible =3D "regulator-fixed";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt =3D <5000000>;
>>> +		regulator-max-microvolt =3D <5000000>;
>>> +		regulator-name =3D "vcc5v0_sys_s5";
>>> +		vin-supply =3D <&vcc5v_dcin>;
>>> +	};
>>> +
>>> +	vcc5v0_usb_otg0: regulator-vcc5v0-usb-otg0 {
>>> +		compatible =3D "regulator-fixed";
>>> +		enable-active-high;
>>> +		gpios =3D <&gpio0 RK_PD1 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names =3D "default";
>>> +		pinctrl-0 =3D <&usb_otg0_pwren_h>;
>>> +		regulator-min-microvolt =3D <5000000>;
>>> +		regulator-max-microvolt =3D <5000000>;
>>> +		regulator-name =3D "vcc5v0_usb_otg0";
>>> +		vin-supply =3D <&vcc5v0_sys_s5>;
>>> +	};
>>> +
>>> +	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
>>> +		compatible =3D "regulator-fixed";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt =3D <1100000>;
>>> +		regulator-max-microvolt =3D <1100000>;
>>> +		regulator-name =3D "vcc_1v1_nldo_s3";
>>> +		vin-supply =3D <&vcc5v0_sys_s5>;
>>> +	};
>>> +
>>> +	vcc_1v8_s0: regulator-vcc-1v8-s0 {
>>> +		compatible =3D "regulator-fixed";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt =3D <1800000>;
>>> +		regulator-max-microvolt =3D <1800000>;
>>> +		regulator-name =3D "vcc_1v8_s0";
>>> +		vin-supply =3D <&vcc_1v8_s3>;
>>> +	};
>>> +
>>> +	vcc_2v0_pldo_s3: regulator-vcc-2v0-pldo-s3 {
>>> +		compatible =3D "regulator-fixed";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt =3D <2000000>;
>>> +		regulator-max-microvolt =3D <2000000>;
>>> +		regulator-name =3D "vcc_2v0_pldo_s3";
>>> +		vin-supply =3D <&vcc5v0_sys_s5>;
>>> +	};
>>> +
>>> +	vcc_3v3_s0: regulator-vcc-3v3-s0 {
>>> +		compatible =3D "regulator-fixed";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt =3D <3300000>;
>>> +		regulator-max-microvolt =3D <3300000>;
>>> +		regulator-name =3D "vcc_3v3_s0";
>>> +		vin-supply =3D <&vcc_3v3_s3>;
>>> +	};
>>> +};
>>> +
>>> +&combphy0_ps {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&combphy1_psu {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&cpu_b0 {
>>> +	cpu-supply =3D <&vdd_cpu_big_s0>;
>>> +};
>>> +
>>> +&cpu_b1 {
>>> +	cpu-supply =3D <&vdd_cpu_big_s0>;
>>> +};
>>> +
>>> +&cpu_b2 {
>>> +	cpu-supply =3D <&vdd_cpu_big_s0>;
>>> +};
>>> +
>>> +&cpu_b3 {
>>> +	cpu-supply =3D <&vdd_cpu_big_s0>;
>>> +};
>>> +
>>> +&cpu_l0 {
>>> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
>>> +};
>>> +
>>> +&cpu_l1 {
>>> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
>>> +};
>>> +
>>> +&cpu_l2 {
>>> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
>>> +};
>>> +
>>> +&cpu_l3 {
>>> +	cpu-supply =3D <&vdd_cpu_lit_s0>;
>>> +};
>>> +
>>> +&gpu {
>>> +	mali-supply =3D <&vdd_gpu_s0>;
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&hdmi {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&hdmi_in {
>>> +	hdmi_in_vp0: endpoint {
>>> +		remote-endpoint =3D <&vp0_out_hdmi>;
>>> +	};
>>> +};
>>> +
>>> +&hdmi_out {
>>> +	hdmi_out_con: endpoint {
>>> +		remote-endpoint =3D <&hdmi_con_in>;
>>> +	};
>>> +};
>>> +
>>> +&hdmi_sound {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&hdptxphy {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&i2c1 {
>>> +	status =3D "okay";
>>> +
>>> +	pmic@23 {
>>> +		compatible =3D "rockchip,rk806";
>>> +		reg =3D <0x23>;
>>> +		#gpio-cells =3D <2>;
>>> +		gpio-controller;
>>> +		interrupt-parent =3D <&gpio0>;
>>> +		interrupts =3D <6 IRQ_TYPE_LEVEL_LOW>;
>>> +		pinctrl-names =3D "default";
>>> +		pinctrl-0 =3D <&pmic_pins>, <&rk806_dvs1_null>,
>>> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
>>> +		system-power-controller;
>>> +
>>> +		vcc1-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc2-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc3-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc4-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc5-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc6-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc7-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc8-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc9-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc10-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc11-supply =3D <&vcc_2v0_pldo_s3>;
>>> +		vcc12-supply =3D <&vcc5v0_sys_s5>;
>>> +		vcc13-supply =3D <&vcc_1v1_nldo_s3>;
>>> +		vcc14-supply =3D <&vcc_1v1_nldo_s3>;
>>> +		vcca-supply =3D <&vcc5v0_sys_s5>;
>>> +
>>> +		rk806_dvs1_null: dvs1-null-pins {
>>> +			pins =3D "gpio_pwrctrl1";
>>> +			function =3D "pin_fun0";
>>> +		};
>>> +
>>> +		rk806_dvs1_pwrdn: dvs1-pwrdn-pins {
>>> +			pins =3D "gpio_pwrctrl1";
>>> +			function =3D "pin_fun2";
>>> +		};
>>> +
>>> +		rk806_dvs1_rst: dvs1-rst-pins {
>>> +			pins =3D "gpio_pwrctrl1";
>>> +			function =3D "pin_fun3";
>>> +		};
>>> +
>>> +		rk806_dvs1_slp: dvs1-slp-pins {
>>> +			pins =3D "gpio_pwrctrl1";
>>> +			function =3D "pin_fun1";
>>> +		};
>>> +
>>> +		rk806_dvs2_dvs: dvs2-dvs-pins {
>>> +			pins =3D "gpio_pwrctrl2";
>>> +			function =3D "pin_fun4";
>>> +		};
>>> +
>>> +		rk806_dvs2_gpio: dvs2-gpio-pins {
>>> +			pins =3D "gpio_pwrctrl2";
>>> +			function =3D "pin_fun5";
>>> +		};
>>> +
>>> +		rk806_dvs2_null: dvs2-null-pins {
>>> +			pins =3D "gpio_pwrctrl2";
>>> +			function =3D "pin_fun0";
>>> +		};
>>> +
>>> +		rk806_dvs2_pwrdn: dvs2-pwrdn-pins {
>>> +			pins =3D "gpio_pwrctrl2";
>>> +			function =3D "pin_fun2";
>>> +		};
>>> +
>>> +		rk806_dvs2_rst: dvs2-rst-pins {
>>> +			pins =3D "gpio_pwrctrl2";
>>> +			function =3D "pin_fun3";
>>> +		};
>>> +
>>> +		rk806_dvs2_slp: dvs2-slp-pins {
>>> +			pins =3D "gpio_pwrctrl2";
>>> +			function =3D "pin_fun1";
>>> +		};
>>> +
>>> +		rk806_dvs3_dvs: dvs3-dvs-pins {
>>> +			pins =3D "gpio_pwrctrl3";
>>> +			function =3D "pin_fun4";
>>> +		};
>>> +
>>> +		rk806_dvs3_gpio: dvs3-gpio-pins {
>>> +			pins =3D "gpio_pwrctrl3";
>>> +			function =3D "pin_fun5";
>>> +		};
>>> +
>>> +		rk806_dvs3_null: dvs3-null-pins {
>>> +			pins =3D "gpio_pwrctrl3";
>>> +			function =3D "pin_fun0";
>>> +		};
>>> +
>>> +		rk806_dvs3_pwrdn: dvs3-pwrdn-pins {
>>> +			pins =3D "gpio_pwrctrl3";
>>> +			function =3D "pin_fun2";
>>> +		};
>>> +
>>> +		rk806_dvs3_rst: dvs3-rst-pins {
>>> +			pins =3D "gpio_pwrctrl3";
>>> +			function =3D "pin_fun3";
>>> +		};
>>> +
>>> +		rk806_dvs3_slp: dvs3-slp-pins {
>>> +			pins =3D "gpio_pwrctrl3";
>>> +			function =3D "pin_fun1";
>>> +		};
>>> +
>>> +		regulators {
>>> +			vdd_cpu_big_s0: dcdc-reg1 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-enable-ramp-delay =3D <400>;
>>> +				regulator-min-microvolt =3D <550000>;
>>> +				regulator-max-microvolt =3D <950000>;
>>> +				regulator-name =3D "vdd_cpu_big_s0";
>>> +				regulator-ramp-delay =3D <12500>;
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdd_npu_s0: dcdc-reg2 {
>>> +				regulator-boot-on;
>>> +				regulator-enable-ramp-delay =3D <400>;
>>> +				regulator-min-microvolt =3D <550000>;
>>> +				regulator-max-microvolt =3D <950000>;
>>> +				regulator-name =3D "vdd_npu_s0";
>>> +				regulator-ramp-delay =3D <12500>;
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdd_cpu_lit_s0: dcdc-reg3 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <550000>;
>>> +				regulator-max-microvolt =3D <950000>;
>>> +				regulator-name =3D "vdd_cpu_lit_s0";
>>> +				regulator-ramp-delay =3D <12500>;
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +					regulator-suspend-microvolt =3D <750000>;
>>> +				};
>>> +			};
>>> +
>>> +			vcc_3v3_s3: dcdc-reg4 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <3300000>;
>>> +				regulator-max-microvolt =3D <3300000>;
>>> +				regulator-name =3D "vcc_3v3_s3";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-on-in-suspend;
>>> +					regulator-suspend-microvolt =3D <3300000>;
>>> +				};
>>> +			};
>>> +
>>> +			vdd_gpu_s0: dcdc-reg5 {
>>> +				regulator-boot-on;
>>> +				regulator-enable-ramp-delay =3D <400>;
>>> +				regulator-min-microvolt =3D <550000>;
>>> +				regulator-max-microvolt =3D <900000>;
>>> +				regulator-name =3D "vdd_gpu_s0";
>>> +				regulator-ramp-delay =3D <12500>;
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +					regulator-suspend-microvolt =3D <850000>;
>>> +				};
>>> +			};
>>> +
>>> +			vddq_ddr_s0: dcdc-reg6 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-name =3D "vddq_ddr_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdd_logic_s0: dcdc-reg7 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <550000>;
>>> +				regulator-max-microvolt =3D <800000>;
>>> +				regulator-name =3D "vdd_logic_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcc_1v8_s3: dcdc-reg8 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <1800000>;
>>> +				regulator-max-microvolt =3D <1800000>;
>>> +				regulator-name =3D "vcc_1v8_s3";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-on-in-suspend;
>>> +					regulator-suspend-microvolt =3D <1800000>;
>>> +				};
>>> +			};
>>> +
>>> +			vdd2_ddr_s3: dcdc-reg9 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-name =3D "vdd2_ddr_s3";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-on-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdd_ddr_s0: dcdc-reg10 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <550000>;
>>> +				regulator-max-microvolt =3D <1200000>;
>>> +				regulator-name =3D "vdd_ddr_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcca_1v8_s0: pldo-reg1 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <1800000>;
>>> +				regulator-max-microvolt =3D <1800000>;
>>> +				regulator-name =3D "vcca_1v8_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcca1v8_pldo2_s0: pldo-reg2 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <1800000>;
>>> +				regulator-max-microvolt =3D <1800000>;
>>> +				regulator-name =3D "vcca1v8_pldo2_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdda_1v2_s0: pldo-reg3 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <1200000>;
>>> +				regulator-max-microvolt =3D <1200000>;
>>> +				regulator-name =3D "vdda_1v2_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcca_3v3_s0: pldo-reg4 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <3300000>;
>>> +				regulator-max-microvolt =3D <3300000>;
>>> +				regulator-name =3D "vcca_3v3_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vccio_sd_s0: pldo-reg5 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <1800000>;
>>> +				regulator-max-microvolt =3D <3300000>;
>>> +				regulator-name =3D "vccio_sd_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcca1v8_pldo6_s3: pldo-reg6 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <1800000>;
>>> +				regulator-max-microvolt =3D <1800000>;
>>> +				regulator-name =3D "vcca1v8_pldo6_s3";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-on-in-suspend;
>>> +					regulator-suspend-microvolt =3D <1800000>;
>>> +				};
>>> +			};
>>> +
>>> +			vdd_0v75_s3: nldo-reg1 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <750000>;
>>> +				regulator-max-microvolt =3D <750000>;
>>> +				regulator-name =3D "vdd_0v75_s3";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-on-in-suspend;
>>> +					regulator-suspend-microvolt =3D <750000>;
>>> +				};
>>> +			};
>>> +
>>> +			vdda_ddr_pll_s0: nldo-reg2 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <850000>;
>>> +				regulator-max-microvolt =3D <850000>;
>>> +				regulator-name =3D "vdda_ddr_pll_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdda0v75_hdmi_s0: nldo-reg3 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <837500>;
>>> +				regulator-max-microvolt =3D <837500>;
>>> +				regulator-name =3D "vdda0v75_hdmi_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdda_0v85_s0: nldo-reg4 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <850000>;
>>> +				regulator-max-microvolt =3D <850000>;
>>> +				regulator-name =3D "vdda_0v85_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdda_0v75_s0: nldo-reg5 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt =3D <750000>;
>>> +				regulator-max-microvolt =3D <750000>;
>>> +				regulator-name =3D "vdda_0v75_s0";
>>> +
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&i2c2 {
>>> +	status =3D "okay";
>>> +
>>> +	hym8563: rtc@51 {
>>> +		compatible =3D "haoyu,hym8563";
>>> +		reg =3D <0x51>;
>>> +		#clock-cells =3D <0>;
>>> +		clock-output-names =3D "hym8563";
>>> +		interrupt-parent =3D <&gpio0>;
>>> +		interrupts =3D <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
>>> +		pinctrl-names =3D "default";
>>> +		pinctrl-0 =3D <&rtc_int_l>;
>>> +		wakeup-source;
>>> +	};
>>> +};
>>> +
>>> +&pcie0 {
>>> +	pinctrl-names =3D "default";
>>> +	pinctrl-0 =3D <&pcie0_perstn>;
>>> +	reset-gpios =3D <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
>>> +	vpcie3v3-supply =3D <&vcc_3v3_s3>;
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&pcie1 {
>>> +	pinctrl-names =3D "default";
>>> +	pinctrl-0 =3D <&pcie1_perstn>;
>>> +	reset-gpios =3D <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
>>> +	vpcie3v3-supply =3D <&vcc_3v3_s3>;
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&pinctrl {
>>> +	bt {
>>> +		bt_reg_on_h: bt-reg-on-h {
>>> +			rockchip,pins =3D <3 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +
>>> +		bt_wake_host_h: bt-wake-host-h {
>>> +			rockchip,pins =3D <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_down>;
>>> +		};
>>> +
>>> +		host_wake_bt_h: host-wake-bt-h {
>>> +			rockchip,pins =3D <3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +	};
>>> +
>>> +	gpio-keys {
>>> +		reset_button_pin: reset-button-pin {
>>> +			rockchip,pins =3D <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +	};
>>> +
>>> +	gpio-leds {
>>> +		lan_led_pin: lan-led-pin {
>>> +			rockchip,pins =3D <2 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +
>>> +		power_led_pin: power-led-pin {
>>> +			rockchip,pins =3D <2 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +
>>> +		wan_led_pin: wan-led-pin {
>>> +			rockchip,pins =3D <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +	};
>>> +
>>> +	hdmi {
>>> +		hdmi_tx_on_h: hdmi-tx-on-h {
>>> +			rockchip,pins =3D <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +	};
>>> +
>>> +	hym8563 {
>>> +		rtc_int_l: rtc-int-l {
>>> +			rockchip,pins =3D <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +	};
>>> +
>>> +	pcie {
>>> +		pcie0_perstn: pcie0-perstn {
>>> +			rockchip,pins =3D <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +
>>> +		pcie1_perstn: pcie1-perstn {
>>> +			rockchip,pins =3D <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +	};
>>> +
>>> +	usb {
>>> +		usb_otg0_pwren_h: usb-otg0-pwren-h {
>>> +			rockchip,pins =3D <0 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +	};
>>> +
>>> +	wifi {
>>> +		wifi_wake_host_h: wifi-wake-host-h {
>>> +			rockchip,pins =3D <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
>>> +		};
>>> +
>>> +		wifi_reg_on_h: wifi-reg-on-h {
>>> +			rockchip,pins =3D <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&sai6 {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&sdmmc {
>>> +	bus-width =3D <4>;
>>> +	cap-mmc-highspeed;
>>> +	cap-sd-highspeed;
>>> +	disable-wp;
>>> +	no-mmc;
>>> +	no-sdio;
>>> +	sd-uhs-sdr104;
>>> +	vmmc-supply =3D <&vcc_3v3_s3>;
>>> +	vqmmc-supply =3D <&vccio_sd_s0>;
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&sdio {
>>> +	#address-cells =3D <1>;
>>> +	#size-cells =3D <0>;
>>> +	bus-width =3D <4>;
>>> +	cap-sd-highspeed;
>>> +	cap-sdio-irq;
>>> +	disable-wp;
>>> +	keep-power-in-suspend;
>>> +	mmc-pwrseq =3D <&sdio_pwrseq>;
>>> +	no-mmc;
>>> +	no-sd;
>>> +	non-removable;
>>> +	sd-uhs-sdr104;
>>> +	vmmc-supply =3D <&vcc_3v3_s3>;
>>> +	vqmmc-supply =3D <&vcc_1v8_s3>;
>>> +	wakeup-source;
>>> +	status =3D "okay";
>>> +
>>> +	rtl8822cs: wifi@1 {
>>> +		reg =3D <1>;
>>> +		interrupt-parent =3D <&gpio0>;
>>> +		interrupts =3D <RK_PB0 IRQ_TYPE_LEVEL_HIGH>;
>>> +		interrupt-names =3D "host-wake";
>>> +		pinctrl-names =3D "default";
>>> +		pinctrl-0 =3D <&wifi_wake_host_h>;
>>> +	};
>>> +};
>>> +
>>> +&sdhci {
>>> +	bus-width =3D <8>;
>>> +	cap-mmc-highspeed;
>>> +	full-pwr-cycle-in-suspend;
>>> +	mmc-hs400-1_8v;
>>> +	mmc-hs400-enhanced-strobe;
>>> +	no-sdio;
>>> +	no-sd;
>>> +	non-removable;
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&saradc {
>>> +	vref-supply =3D <&vcca_1v8_s0>;
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&u2phy0 {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&u2phy0_otg {
>>> +	phy-supply =3D <&vcc5v0_usb_otg0>;
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&uart0 {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&uart5 {
>>> +	pinctrl-names =3D "default";
>>> +	pinctrl-0 =3D <&uart5m0_xfer &uart5m0_ctsn &uart5m0_rtsn>;
>>> +	uart-has-rtscts;
>>> +	status =3D "okay";
>>> +
>>> +	bluetooth {
>>> +		compatible =3D "realtek,rtl8822cs-bt";
>>> +		enable-gpios =3D <&gpio3 RK_PC7 GPIO_ACTIVE_HIGH>;
>>> +		device-wake-gpios =3D <&gpio3 RK_PD0 GPIO_ACTIVE_HIGH>;
>>> +		host-wake-gpios =3D <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names =3D "default";
>>> +		pinctrl-0 =3D <&bt_wake_host_h &host_wake_bt_h &bt_reg_on_h>;
>>> +	};
>>> +};
>>> +
>>> +&usbdp_phy {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&usb_drd0_dwc3 {
>>> +	dr_mode =3D "host";
>>> +	extcon =3D <&u2phy0>;
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&vop {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&vop_mmu {
>>> +	status =3D "okay";
>>> +};
>>> +
>>> +&vp0 {
>>> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>>> +		reg =3D <ROCKCHIP_VOP2_EP_HDMI0>;
>>> +		remote-endpoint =3D <&hdmi_in_vp0>;
>>> +	};
>>> +};
>>=20


--5607581fafb5bfba5a0fbfae40896bc28ba6ec1b91c559ddb9802e4fbb76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaNeUNQAKCRDXblvOeH7b
bvA3AP9roH5wERGnKqqY/C0J+1JrWJ4qHti93BvlNNftzsQj0AD+MtPdUTTH+qWK
Utm3WrPxgSTvGYJKrFytnKtOHNEYIgs=
=GQfK
-----END PGP SIGNATURE-----

--5607581fafb5bfba5a0fbfae40896bc28ba6ec1b91c559ddb9802e4fbb76--


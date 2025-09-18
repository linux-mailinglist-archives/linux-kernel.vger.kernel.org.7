Return-Path: <linux-kernel+bounces-823628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72859B870AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281D516BBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A07021CC4B;
	Thu, 18 Sep 2025 21:15:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FA42F5499;
	Thu, 18 Sep 2025 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230116; cv=none; b=VdpqshKvvmUCTqBi0i9nkVTp9J0NzSsT1nkbYbrqP3w0KQ+cwv/JHU6q/NIThT0FyJ6ElFkuEAdx/V0/nWdklbeGDHkwuWiF5Wv9VywWM4qZCW6110cPn0tsrwFQ+SC8bbe/cbmt/EA9Oljx4qXFcbILC3X2S/LSl6TwfBw+ZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230116; c=relaxed/simple;
	bh=Ms3HNJjYMryp7fDIfu74b4EK2oUQ6W2SnyZ2YbFx2ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qj0Ze21jXhvS6zt3rMqEluEVH/FKJLl5aAKaAODlxHlP6OftxT6NfOMwGVn1s0ugZ9rKREnkwHkXyzI+Edg5B3YzroFuQ0PMZa+dQsjdw1C9gW94nNAwupP0uy489dW76KgMG4IYmgFSG1D11zAuVZizh9g8o+a+YKyBLwHoRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71505176A;
	Thu, 18 Sep 2025 14:15:05 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF6D83F694;
	Thu, 18 Sep 2025 14:15:11 -0700 (PDT)
Date: Thu, 18 Sep 2025 22:14:24 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "J. =?UTF-8?B?TmV1c2Now6RmZXI=?= via B4 Relay"
 <devnull+j.ne.posteo.net@kernel.org>
Cc: j.ne@posteo.net, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: allwinner: h313: Add Amediatech X96Q
Message-ID: <20250918221424.638a5367@minigeek.lan>
In-Reply-To: <20250918-x96q-v2-2-51bd39928806@posteo.net>
References: <20250918-x96q-v2-0-51bd39928806@posteo.net>
	<20250918-x96q-v2-2-51bd39928806@posteo.net>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sep 2025 12:58:44 +0200
J. Neusch=C3=A4fer via B4 Relay <devnull+j.ne.posteo.net@kernel.org> wrote:

Hi,

> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
>=20
> The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> output, and infrared input.
>=20
>   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
>=20
> Tested, works:
> - debug UART
> - status LED
> - USB ports in host mode
> - MicroSD
> - eMMC
> - recovery button hidden behind audio/video port
> - analog audio (line out)
>=20
> Does not work:
> - Ethernet (requires AC200 MFD/EPHY driver)
> - WLAN (requires out-of-tree XRadio driver)
> - analog video output (requires AC200 driver)
> - HDMI audio/video output
>=20
> Untested:
> - "OTG" USB port in device mode
> - built-in IR receiver
> - external IR receiver
>=20
> Table of regulators on the downstream kernel, for reference:
>=20
>  vcc-5v      1   15      0 unknown  5000mV     0mA  5000mV  5000mV
>     dcdca    0    0      0 unknown   900mV     0mA     0mV     0mV
>     dcdcb    0    0      0 unknown  1350mV     0mA     0mV     0mV
>     dcdcc    0    0      0 unknown   900mV     0mA     0mV     0mV
>     dcdcd    0    0      0 unknown  1500mV     0mA     0mV     0mV
>     dcdce    0    0      0 unknown  3300mV     0mA     0mV     0mV
>     aldo1    0    0      0 unknown  3300mV     0mA     0mV     0mV
>     aldo2    0    0      0 unknown   700mV     0mA     0mV     0mV
>     aldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
>     bldo1    0    0      0 unknown  1800mV     0mA     0mV     0mV
>     bldo2    0    0      0 unknown  1800mV     0mA     0mV     0mV
>     bldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
>     bldo4    0    0      0 unknown   700mV     0mA     0mV     0mV
>     cldo1    0    0      0 unknown  2500mV     0mA     0mV     0mV
>     cldo2    0    0      0 unknown   700mV     0mA     0mV     0mV
>     cldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
>=20
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>

Looks good now, thanks for the changes!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Chen-Yu: any chance you can still push that, if you agree? U-Boot
depends on DTs in tagged releases to get this imported.

Cheers,
Andre

> ---
>=20
> v2:
> - remove mmc aliases, &mmc0/max-frequency property (Andre Przywara)
> - document reason for &mmc2/max-frequency property
> - clean up mmc-releated comments (Andre Przywara)
> - rename dcdcd regulator to vdd-dram, because it's the only source of
>   1.5V (needed by the Micron MT41J256M4 DDR3 RAM), and the system halts
>   when it's turned off.
> ---
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts | 230 +++++++++++++++=
++++++
>  2 files changed, 231 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index 780aeba0f3a4e14d69c9602e37b8d299165507b9..2edfa7bf4ab31c4aa934da98e=
5e042edc9aaf600 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-model-=
b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h313-tanix-tx1.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h313-x96q.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-cb1-manta.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts b/arch/ar=
m64/boot/dts/allwinner/sun50i-h313-x96q.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..b2275eb3d55b9dacbd9006b93=
795a8011e06bf2f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +/*
> + * Copyright (C) 2025 J. Neusch=C3=A4fer <j.ne@posteo.net>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +#include "sun50i-h616-cpu-opp.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model =3D "X96Q";
> +	compatible =3D "amediatech,x96q", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the DC input */
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc-5v";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +
> +		key-recovery {
> +			label =3D "Recovery";
> +			linux,code =3D <KEY_VENDOR>;
> +			gpios =3D <&pio 7 9 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led-0 {
> +			color =3D <LED_COLOR_ID_BLUE>;
> +			gpios =3D <&pio 7 6 GPIO_ACTIVE_LOW>;
> +			default-state =3D "on";
> +		};
> +	};
> +};
> +
> +&codec {
> +	allwinner,audio-routing =3D "Line Out", "LINEOUT";
> +	status =3D "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdca>;
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ehci3 {
> +	status =3D "okay";
> +};
> +
> +/* TODO: EMAC1 connected to AC200 PHY */
> +
> +&gpu {
> +	mali-supply =3D <&reg_dcdcc>;
> +	status =3D "okay";
> +};
> +
> +&ir {
> +	status =3D "okay";
> +};
> +
> +&mmc0 {
> +	/* microSD */
> +	vmmc-supply =3D <&reg_aldo1>;
> +	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	disable-wp;
> +	bus-width =3D <4>;
> +	status =3D "okay";
> +};
> +
> +/* TODO: XRadio XR819 WLAN @ mmc1 */
> +
> +&mmc2 {
> +	/* eMMC */
> +	vmmc-supply =3D <&reg_aldo1>;
> +	vqmmc-supply =3D <&reg_bldo1>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency =3D <100000000>; /* required for stable operation */
> +	bus-width =3D <8>;
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci3 {
> +	status =3D "okay";
> +};
> +
> +&r_i2c {
> +	status =3D "okay";
> +
> +	axp305: pmic@36 {
> +		compatible =3D "x-powers,axp305", "x-powers,axp805",
> +			     "x-powers,axp806";
> +		interrupt-controller;
> +		#interrupt-cells =3D <1>;
> +		reg =3D <0x36>;
> +
> +		x-powers,self-working-mode;
> +		vina-supply =3D <&reg_vcc5v>;
> +		vinb-supply =3D <&reg_vcc5v>;
> +		vinc-supply =3D <&reg_vcc5v>;
> +		vind-supply =3D <&reg_vcc5v>;
> +		vine-supply =3D <&reg_vcc5v>;
> +		aldoin-supply =3D <&reg_vcc5v>;
> +		bldoin-supply =3D <&reg_vcc5v>;
> +		cldoin-supply =3D <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_dcdca: dcdca {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <810000>;
> +				regulator-max-microvolt =3D <1100000>;
> +				regulator-name =3D "vdd-cpu";
> +			};
> +
> +			dcdcb {
> +				/* unused */
> +			};
> +
> +			reg_dcdcc: dcdcc {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <810000>;
> +				regulator-max-microvolt =3D <990000>;
> +				regulator-name =3D "vdd-gpu-sys";
> +			};
> +
> +			dcdcd {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <1500000>;
> +				regulator-max-microvolt =3D <1500000>;
> +				regulator-name =3D "vdd-dram";
> +			};
> +
> +			dcdce {
> +				/* unused */
> +			};
> +
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc3v3";
> +			};
> +
> +			aldo2 {
> +				/* unused */
> +			};
> +
> +			aldo3 {
> +				/* unused */
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-name =3D "vcc1v8";
> +			};
> +
> +			bldo2 {
> +				/* unused */
> +			};
> +
> +			bldo3 {
> +				/* unused */
> +			};
> +
> +			bldo4 {
> +				/* unused */
> +			};
> +
> +			cldo1 {
> +				/* unused */
> +			};
> +
> +			cldo2 {
> +				/* unused */
> +			};
> +
> +			cldo3 {
> +				/* unused */
> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart0_ph_pins>;
> +	status =3D "okay";
> +};
> +
> +&usbotg {
> +	dr_mode =3D "host";	/* USB A type receptacle */
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	status =3D "okay";
> +};
>=20



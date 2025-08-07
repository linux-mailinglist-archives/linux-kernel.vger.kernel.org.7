Return-Path: <linux-kernel+bounces-759138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80015B1D90B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906A5584D7C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2225C6E2;
	Thu,  7 Aug 2025 13:28:32 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62F25B311;
	Thu,  7 Aug 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573311; cv=none; b=eQcc5c6KJXcjcmd8qlJE0r14fAp2HqbOOLzl9MxGh+AqVIToHRg6s9JA7dOLD6gm8AJEvk5TQtDgCEdXwY94ST9usIcoOwa9aaaOAg3jC+5NC6IsjJ/KlI84vEMFS2oxvHCJGDyhER54md+k7PneSWxa7ojlfg0ziHExFa1R76Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573311; c=relaxed/simple;
	bh=XR8sH5/FlFcL+r2fHAHH7X1jRBJEAolt+aRufWhyZ8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtV/3Ar/zAmc4MrVUk97Kgva/t/QVpYFWpTgDK9+9Sp7rOlMC4q8DHii1sQVn/NNqSOrjtXHlSME/6PyutyYG1ZSOFUH8qoV/ZmemaS0DEyyWB6ZfaTUt99eAwOjYXwybZkhoP9db9m8ZzG3PVSnGLYJppxp6JfSBXkFsRrXGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1754573214ta6d0c65c
X-QQ-Originating-IP: nyXN8PHY58+Z0DZJJ687fky/hGKI08TIsEz0d60ZHTU=
Received: from [IPV6:240f:10b:7440:1:e250:2ab5 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Aug 2025 21:26:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6478878975056497933
Message-ID: <04D1B45242A546DF+12c39a6f-5aea-4229-b623-da257d09e9d2@radxa.com>
Date: Thu, 7 Aug 2025 22:26:48 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: rockchip: Add rk3588 based Radxa CM5
To: Joseph Kogut <joseph.kogut@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jimmy Hon <honyuenkwun@gmail.com>
Cc: Steve deRosier <derosier@cal-sierra.com>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250617-rk3588s-cm5-io-dts-upstream-v5-0-8d96854a5bbd@gmail.com>
 <20250617-rk3588s-cm5-io-dts-upstream-v5-2-8d96854a5bbd@gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250617-rk3588s-cm5-io-dts-upstream-v5-2-8d96854a5bbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OBDSLDo3By90qYTXoK/jbX3V0J2CywLXKaps1HJ9ymTJbR/D2yjmo4Cf
	yLkmGhgSceF6V/gVQHxsptcXzIHxEAYAQxU72o5dzvIjLaFHptjoZ75PD0qbnEBN7cwPNts
	ftmcP01EjoNYqMaoxNmrPlogFsGNJGFIPI7mrQWgA9pynXpMv0DPo7+tj0RUWZJcXuJu0GA
	9hiN9zbDgVHYEHmJce5dT+/lR4hGgg4OkaS3Sos2xiVi1bY87s8Fm6IWOfbqwAiblO/Lt30
	tcC70d2LJda1WK5PrIO2/zFi2DWIhfm0VZcSEFaYY4ayPXxckEoQozC6Qjoypcf1ATv74/7
	+wmx9zZY51E2fIqpao8J+pQGWDne3+V4vdf1SFWY6uTjrj11EGvsh1fn6V9p0uZxK+nEoC+
	BjEmnYklLxqji4yfiWv9ec8MgOH/j0omqkiCttVfOZnLYNfOnFKH82v8yQnGoDUy0Jjtvr6
	97MuMuTOV1oIwAizw7XRWziOjccdzxYwLlhgBo3ebg+zL9TQ+n8790H9aO1SdJdSURfFjtd
	zu8VT1+eoYzFKj5LiOmMvMqZoVEiDriqGTbXKrZL0uYIeO50FUoz3bWCSRjBjJz4XyySLHg
	NkX9cmtMuFZ5SuJDWShMBVVJSY6d2PkinG35kbeV2tabWPNWgNAYgTIVuACQCqdtC9wq/Tl
	Tsp6WaG8MPuY1l1L4LK8bT1PPqP1LrLLGykcxPFEouGeLW8JlQ8CQLiRc+KSqwa7MIiMkyV
	XWXc8RvhgyFqMfL45RN5uNZJz+OVIN3u3uVTSWq3z5Hib4u9+VZtuIXUOUw7tKjLVz4Oyg5
	tBtE2Ggkc5C/8KQnEVJ/yg/Ayq8lyVSriOA03dIn1jAhmoWPiTQ16MB9+/KF8TvLPl9pqzD
	ETOzfjzbgfkwL+wnsiwqGmzP79NzSyohHjE4OuY9IsWbFxKvSss5ja7fAOYFy4Mu7mugqvb
	RYe12oEAQwZy6FafznaAN9uY4mR2OknDgA8dsU9mQl2iXXmoV2wkqVeq4Fh5rbrqTSfc=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hi Joseph,

I overlooked a few things.

On 6/18/25 07:12, Joseph Kogut wrote:
> Add initial support for the Radxa Compute Module 5 (CM5). The CM5 uses a
> proprietary connector.
> 
> Specification:
> - Rockchip RK3588
> - Up to 32 GB LPDDR4X
> - Up to 128 GB eMMC
> - 1x HDMI TX up to 8k@60 hz
> - 1x eDP TX up to 4k@60 hz
> - Gigabit Ethernet PHY
> 
> Signed-off-by: Joseph Kogut <joseph.kogut@gmail.com>
> ---
>   .../arm64/boot/dts/rockchip/rk3588s-radxa-cm5.dtsi | 135 +++++++++++++++++++++
>   1 file changed, 135 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-radxa-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-radxa-cm5.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..6410ea5255dc783e5d24677853ccf1c78008e834
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-radxa-cm5.dtsi
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2025 Joseph Kogut <joseph.kogut@gmail.com>
> + */
> +
> +/*
> + * CM5 data sheet
> + * https://dl.radxa.com/cm5/v2210/radxa_cm5_v2210_schematic.pdf
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include <dt-bindings/usb/pd.h>
> +
> +/ {
> +	compatible = "radxa,cm5", "rockchip,rk3588s";
> +
> +	aliases {
> +		mmc0 = &sdhci;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led_sys: led-0 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			default-state = "on";
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_b3 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu_s0>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0m2_xfer>;
> +	status = "okay";
> +
> +	vdd_cpu_big0_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_big0_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;

VCC_SYSIN.

> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_cpu_big1_s0: regulator@43 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x43>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_big1_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;

VCC_SYSIN.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +	};
> +};
> +
> +&pd_gpu {
> +	domain-supply = <&vdd_gpu_s0>;
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	max-frequency = <200000000>;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	mmc-hs200-1_8v;
> +	status = "okay";
> +};
> +



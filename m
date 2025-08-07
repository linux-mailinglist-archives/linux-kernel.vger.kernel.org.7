Return-Path: <linux-kernel+bounces-759000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B090BB1D6EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CECD18889A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAE123507F;
	Thu,  7 Aug 2025 11:49:34 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15C196C7C;
	Thu,  7 Aug 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567373; cv=none; b=N5Xa/nRmUhqjinkK9N4sPNeqy0GprbQru110iSy8W8rM1JYDbj1jf3xXv7pBivOFZzDOrEeM/PmrR7YCEUrQ/ww6LIwuqyCr/4TTiF1XEZ6LSS6umWYukryzhOVfg0etszH3MTAWEoE4B9HiQBPqbu/MD0woUDY2AyHhEN+rNAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567373; c=relaxed/simple;
	bh=7VB3deSobFqRRYrxJWdOyLo4eZ2Jg7wtTAQhZHsOn6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CunjWdfLtgXAW2H1diaQR+7eajrMazqxVOkFF9iDJpkb4YaYtl7Z5UO76sW4+h3LjACuqh6hFGkeNgjeTp8jobxpotV14/Mo0YTfazTsoXX66Vukyzlwov8taB7cwoMf2ZosxTC6a8r569+/MPn30umH0RampyXvsNTWSweuCxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1754567235t8a796b49
X-QQ-Originating-IP: mmCBvCuxEsz+t7Bnuow0glS9H9YFEoLdKihw4Fq2iCc=
Received: from [IPV6:240f:10b:7440:1:e250:2ab5 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Aug 2025 19:47:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3419397945701426730
Message-ID: <15182C5FA04DB0A2+e2dbbd1f-24d6-4d9a-a822-222a71cc6dd8@radxa.com>
Date: Thu, 7 Aug 2025 20:47:11 +0900
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
X-QQ-XMAILINFO: MW2WLBvYEeCvozn6IR6114VdDJEeDAXqEaoS5O9L8r0IWBg6EDEfGLiJ
	WGErZjg1II8kwxfMZQ/BfhhwQyDOib6DhjKfBQGdlypOYWdPL7UmZAU3gzjRWWQ/tszV4t0
	XsuPcLH6NXxqpZrHR3/64rsarupAxsBYAfHzFL6rCwafApQG3rOQnUU0IqZj9KTB0ymycMV
	cVosiV3n6XTSjvESHT7ElsfhpJEw53Pim5ecHAwiV98aNaELlSN28Q+Zu36r4HdUHWpawvH
	zxXyvoZFLTgKcFPn2dsPo8pzbh9n8tjRuamxL6dUnhxxrNag6adrJTqrg2LbaLmJEj76+Gb
	wVy5S5j+bB+t13n+bhaGnDt5xw487Ihn1kHuO+u2hijKoXe9PKh8vc0KqwQeNz2TWx5JqsY
	wrs61wDK6nouwyR1WI0QUBRYedwGTemT2LB8LIJUAHzFd3MJH/fUq/5XQ7KKyKSyjkJduUy
	RwzrrOMr5vDfjinZJEQtHsJQLPnaP+r43F0j/PAsq6u3fLWxhx26TKpTI/aRzWdwsoE15Yj
	Cr0CErSTuTeeQ1h301HWb3FejdaCCZU9emyhdu8NJkjuk2Ns0mzcFNTDG9LU+nlDEMmQX35
	9or82EDGtR7/LQV97SUhfc7JxIna1xA508SpbjC7U4Gvm27K87/gbi5N0+fA/PR9mBW3ChK
	kRtdcET9Lq4DMZuQr2T/elycn27dSQA7Wzl4STyIUUXdFkE6jAsY5SG2Hm+9psOx++kqP0e
	JeoKC6l5kzuzjjWVq9xwRiqWa5bVjhuNN9uONvSn/0v5ugnY8fTdC7ug772WtOlTDK4iP1I
	LxPujcdkoIKYgjcx+zy/HZ1NZIc94VSttUPA271Ka+bfGzoFqjX97lPUHJ6mXBiLzfecIKI
	MiGjahGIjBdmOpYMuezypoX2lJrcV54Fllg65kOEXJxO80pjw9HjslclZDj5Pv0Gk00+19K
	kHq3pexWm/CaN0f2zW/51+VNctwO/UZh9sv1LbOcZzRdwoA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Hi Joseph,

First of all, thank you very much for your hard work!

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
> +
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

Please remove the last blank line.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.


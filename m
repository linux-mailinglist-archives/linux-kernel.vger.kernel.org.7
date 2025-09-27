Return-Path: <linux-kernel+bounces-834771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D250BA57BF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532E71C02C49
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED251F5434;
	Sat, 27 Sep 2025 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2a7yqIe"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007F81D5160
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935980; cv=none; b=P1vQkYz2DQ/4y0ZoqAKMpeBBvwESD0y1IPqDbsfu4MbD8Vj0xhyaK27uEw7EgJlklylAmRD8gyfr6SEqQfNmbwFYFU6fkvoSFuoLWqinSdtZqwp6FEH18arT5gKBD+2St6238Nx6KBORuUB3PFslLt0TjteWeH58iQ61CLO3g5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935980; c=relaxed/simple;
	bh=Sfa7AT/dfvDhhy8ffpHW/sCgMwSWf6BdJE8fz/B20IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Do23ZAIsJ8M/vWLn6242ybWWj+/9UyXPYgD+NjT7/wRW8GTDoE4Z7u/hvRDrPt6TceqTh8FaJmU3klBBLnYRh2XHoAkTBmrM7zhDb0/jO78Hmpo6QrOJ8IEk3KvbSG3hh0shY1c5zSbVRAQLVGckBZ+9bLLntYwyKzIla9iEyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2a7yqIe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781206cce18so986232b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758935976; x=1759540776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxxDdS9g/E2bCXmMMVj1KdY3LzJccHLzMEdhZUo/prk=;
        b=Y2a7yqIe8/mPzj/1Pf5mCUbzWTy1/9kVgz3oFyUijWTNa3mR9HnsCA96bxiar9XKW0
         Xn6KmAjBeNH4RPVif0sr4h8VktGtKF0CBqbw8cOSVNW55bmQqwgtpirrhIGU808I9sj7
         94qACye1O1cc0NT9cBH/W5iK8rci8WaFyq3j7UnhE5W+E8SqibV3c1nKFYriMDh/+Ng4
         K9qcFGE6vcmrB9zYNYHZB+M7sgMDYn6yqhDtxbNBD4qA/fcQWVd1MKB57tzeGuuGOwSs
         jI3m4Q8h1CzxSXgg5fe2v+HUVfOIsvOUZlp87v5JfSRolnQB976nxtlx5HuyHOFN9AMt
         FA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758935976; x=1759540776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vxxDdS9g/E2bCXmMMVj1KdY3LzJccHLzMEdhZUo/prk=;
        b=wfTLqHpdE2ClmjefAnYw6wfNQlE3wWyAsfzddlhgQpJnqPhWfjHRgI2sqIhFtZ1APt
         uF8Ttf36YLcHzVgtsiwzA3e86lpLVF2mmr0O7oXgfklZSsWwb/kei1hBEHZfj2weEHUN
         gehn2Tlu0CEqrkuQKKMZe1dI1gG7cZF8g8CZvRq0G/+9Bub9iyzcrvlS0k08pI+cepW/
         12Nx2C7qJnU71BeY4lUjeAs0rhLAA8D3r70utbeNekbXRZntGcLTB5N8KRV0/3rM9e1U
         +c21vh5cERIw4FA09Gvn6+Oq4SLngRrwiw6tM4UGjVlkH5KfChoOR2qgCldNVbC3kzSM
         D2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU71qDncFm3qJxjAb259JEkU/29CFZYlF2tYJrjtO6p8N6MUJ9FnJhZVGJxS2HpnhEbBqeVANbBZzuCLr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw06YVLLsMhW+860dGu8yGEL4SsxjteghGYnualCROVn0hvcta3
	aM5OhQIevd4G96o1klxI0BDOAY2YD74ku6PZJn4pdCDhb5s7agpZ8aJI
X-Gm-Gg: ASbGncvGwRu9cvbE3Br1dQJuEfNp7kjQiN0S+N2dNQD/A4zu4C5PQNEsXQ1ZHAdAthl
	pwD4Mj/9MOFhW0/vo3BvBk3a3aVJ6i5OZLpDcRBHoFuH1xMmU0biHX5tAXw7Cz7JoCSa/L13ffz
	VhgcoLnv4srtZqqsQICM9Lmdko5xQP3mxlsjTkHrbM03TJBgRBh4Lp4HQLhWwTsBtZ9Rju3rCGg
	eXO3n4weWplE5niE7/b9owFP+izvEyudqrFKNQguMKOo1acFWCW9dYqhR8KmceGzXUTwt+Lhh8l
	FT2Ldi4kED8AerJdzU9QsH19HKxnS/Nkxpqo59n4JnK6l4VyvtKlBnIRrqvzPl01mX+0nZ9iIlc
	MYl3bhMEvaB6lYnPs3LzWkHJa4UT9JXEK3ZkRTRzn0g==
X-Google-Smtp-Source: AGHT+IEuw7lP+OONVuRakn8p7umvJyj0yYMelaZ2GnOZVcPVl2Jjn+c4P5e7O7+KSTp0QvY6QfZBVg==
X-Received: by 2002:a05:6a20:7349:b0:2ba:1eb5:50e8 with SMTP id adf61e73a8af0-2e9a68ad8bdmr11497294637.17.1758935975658;
        Fri, 26 Sep 2025 18:19:35 -0700 (PDT)
Received: from ?IPV6:2408:8262:245d:4074:5a47:caff:fe76:9e11? ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2733fsm5603756b3a.94.2025.09.26.18.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 18:19:35 -0700 (PDT)
Message-ID: <1bb00ad6-ffe1-4783-909b-032dfb984180@gmail.com>
Date: Sat, 27 Sep 2025 09:19:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add devicetree for the
 FriendlyElec NanoPi R76S
To: Diederik de Haas <didi.debian@cknow.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250922091509.2695565-1-cnsztl@gmail.com>
 <20250922091509.2695565-2-cnsztl@gmail.com>
 <DD2V17FJ29MV.3YDX1VUWGKEH@cknow.org>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <DD2V17FJ29MV.3YDX1VUWGKEH@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/9/27 0:07, Diederik de Haas wrote:
> On Mon Sep 22, 2025 at 11:15 AM CEST, Tianling Shen wrote:
>> The NanoPi R76S (as "R76S") is an open-sourced mini IoT gateway
>> device with two 2.5G, designed and developed by FriendlyElec.
>>
>> Specification:
>> - Rockchip RK3576
>> - 2/4GB LPDDR4X RAM
>> - 2x 2500Base-T (PCIe, rtl8125b)
>> - 3x LEDs (Power, LAN, WAN)
>> - 32GB eMMC
>> - MicroSD Slot
>> - MDMI 1.4/2.0 OUT
>> - M.2 E-Key SDIO slot
>> - USB 3.0 Port
>> - USB Type-C 5V Power
>>
>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>   .../boot/dts/rockchip/rk3576-nanopi-r76s.dts  | 860 ++++++++++++++++++
>>   2 files changed, 861 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>> index ad684e3831bc..2d4a1e29db6f 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -155,6 +155,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5-v1.2-wifibt.dtbo
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-evb1-v10.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-luckfox-omni3576.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-nanopi-m5.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-nanopi-r76s.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-roc-pc.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-rock-4d.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3582-radxa-e52c.dtb
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
>> new file mode 100644
>> index 000000000000..731789a69677
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
>> @@ -0,0 +1,860 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>> +/*
>> + * Copyright (c) 2025 FriendlyElec Computer Tech. Co., Ltd.
>> + * (http://www.friendlyelec.com)
>> + *
>> + * Copyright (c) 2025 Tianling Shen <cnsztl@gmail.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/soc/rockchip,vop2.h>
>> +
>> +#include "rk3576.dtsi"
>> +
>> +/ {
>> +	model = "FriendlyElec NanoPi R76S";
>> +	compatible = "friendlyarm,nanopi-r76s", "rockchip,rk3576";
>> +
>> +	aliases {
>> +		mmc0 = &sdhci;
>> +		mmc1 = &sdmmc;
>> +		mmc2 = &sdio;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:1500000n8";
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&reset_button_pin>;
>> +
>> +		button-reset {
>> +			label = "reset";
>> +			gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <50>;
>> +			linux,code = <KEY_RESTART>;
>> +			wakeup-source;
>> +		};
>> +	};
>> +
>> +	gpio-leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&lan_led_pin>, <&power_led_pin>, <&wan_led_pin>;
> 
> It is recommended to use the labels in the schematics to define the
> pinctl nodes (and thus their references). In quite a lot of cases that's
> indeed the case, but not for gpio-keys (USER_BUT) or these gpio-leds
> pinctls.

I cannot find any specific naming rules from the gpio-keys[1] and 
gpio-leds[2] bindings, did I miss any update?

I think this naming matches the current practice at least in rockchip's 
dt tree.

1. 
https://www.kernel.org/doc/Documentation/devicetree/bindings/input/gpio-keys.yaml
2. 
https://www.kernel.org/doc/Documentation/devicetree/bindings/leds/leds-gpio.yaml

> 
>> +
>> +		led-0 {
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			function = LED_FUNCTION_LAN;
>> +			gpios = <&gpio2 RK_PB0 GPIO_ACTIVE_HIGH>;
>> +		};
>> +
>> +		power_led: led-1 {
> 
> power_led is never referenced, so you can drop it.
> 

This will be used by some downstream projects but I'm fine to remove it 
here.

Thanks,
Tianling.

> Cheers,
>    Diederik
> 
>> +			color = <LED_COLOR_ID_RED>;
>> +			function = LED_FUNCTION_POWER;
>> +			gpios = <&gpio2 RK_PB3 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +
>> +		led-2 {
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			function = LED_FUNCTION_WAN;
>> +			gpios = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
>> +		};
>> +	};
>> +
>> +	hdmi-con {
>> +		compatible = "hdmi-connector";
>> +		hdmi-pwr-supply = <&vcc5v_hdmi_tx>;
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_con_in: endpoint {
>> +				remote-endpoint = <&hdmi_out_con>;
>> +			};
>> +		};
>> +	};
>> +
>> +	sdio_pwrseq: sdio-pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		clocks = <&hym8563>;
>> +		clock-names = "ext_clock";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wifi_reg_on_h>;
>> +		post-power-on-delay-ms = <200>;
>> +		reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
>> +	};
>> +
>> +	vcc5v_dcin: regulator-vcc5v-dcin {
>> +		compatible = "regulator-fixed";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-name = "vcc5v_dcin";
>> +	};
>> +
>> +	vcc5v_hdmi_tx: regulator-vcc5v-hdmi-tx {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&hdmi_tx_on_h>;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-name = "vcc5v_hdmi_tx";
>> +		vin-supply = <&vcc5v0_sys_s5>;
>> +	};
>> +
>> +	vcc3v3_rtc_s5: regulator-vcc3v3-rtc-s5 {
>> +		compatible = "regulator-fixed";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-name = "vcc3v3_rtc_s5";
>> +		vin-supply = <&vcc5v0_sys_s5>;
>> +	};
>> +
>> +	vcc5v0_device_s0: regulator-vcc5v0-device-s0 {
>> +		compatible = "regulator-fixed";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-name = "vcc5v0_device_s0";
>> +		vin-supply = <&vcc5v_dcin>;
>> +	};
>> +
>> +	vcc5v0_sys_s5: regulator-vcc5v0-sys-s5 {
>> +		compatible = "regulator-fixed";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-name = "vcc5v0_sys_s5";
>> +		vin-supply = <&vcc5v_dcin>;
>> +	};
>> +
>> +	vcc5v0_usb_otg0: regulator-vcc5v0-usb-otg0 {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpios = <&gpio0 RK_PD1 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&usb_otg0_pwren_h>;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-name = "vcc5v0_usb_otg0";
>> +		vin-supply = <&vcc5v0_sys_s5>;
>> +	};
>> +
>> +	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <1100000>;
>> +		regulator-max-microvolt = <1100000>;
>> +		regulator-name = "vcc_1v1_nldo_s3";
>> +		vin-supply = <&vcc5v0_sys_s5>;
>> +	};
>> +
>> +	vcc_1v8_s0: regulator-vcc-1v8-s0 {
>> +		compatible = "regulator-fixed";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-name = "vcc_1v8_s0";
>> +		vin-supply = <&vcc_1v8_s3>;
>> +	};
>> +
>> +	vcc_2v0_pldo_s3: regulator-vcc-2v0-pldo-s3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <2000000>;
>> +		regulator-max-microvolt = <2000000>;
>> +		regulator-name = "vcc_2v0_pldo_s3";
>> +		vin-supply = <&vcc5v0_sys_s5>;
>> +	};
>> +
>> +	vcc_3v3_s0: regulator-vcc-3v3-s0 {
>> +		compatible = "regulator-fixed";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-name = "vcc_3v3_s0";
>> +		vin-supply = <&vcc_3v3_s3>;
>> +	};
>> +};
>> +
>> +&combphy0_ps {
>> +	status = "okay";
>> +};
>> +
>> +&combphy1_psu {
>> +	status = "okay";
>> +};
>> +
>> +&cpu_b0 {
>> +	cpu-supply = <&vdd_cpu_big_s0>;
>> +};
>> +
>> +&cpu_b1 {
>> +	cpu-supply = <&vdd_cpu_big_s0>;
>> +};
>> +
>> +&cpu_b2 {
>> +	cpu-supply = <&vdd_cpu_big_s0>;
>> +};
>> +
>> +&cpu_b3 {
>> +	cpu-supply = <&vdd_cpu_big_s0>;
>> +};
>> +
>> +&cpu_l0 {
>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>> +};
>> +
>> +&cpu_l1 {
>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>> +};
>> +
>> +&cpu_l2 {
>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>> +};
>> +
>> +&cpu_l3 {
>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>> +};
>> +
>> +&gpu {
>> +	mali-supply = <&vdd_gpu_s0>;
>> +	status = "okay";
>> +};
>> +
>> +&hdmi {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi_in {
>> +	hdmi_in_vp0: endpoint {
>> +		remote-endpoint = <&vp0_out_hdmi>;
>> +	};
>> +};
>> +
>> +&hdmi_out {
>> +	hdmi_out_con: endpoint {
>> +		remote-endpoint = <&hdmi_con_in>;
>> +	};
>> +};
>> +
>> +&hdmi_sound {
>> +	status = "okay";
>> +};
>> +
>> +&hdptxphy {
>> +	status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +	status = "okay";
>> +
>> +	pmic@23 {
>> +		compatible = "rockchip,rk806";
>> +		reg = <0x23>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		interrupt-parent = <&gpio0>;
>> +		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
>> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
>> +		system-power-controller;
>> +
>> +		vcc1-supply = <&vcc5v0_sys_s5>;
>> +		vcc2-supply = <&vcc5v0_sys_s5>;
>> +		vcc3-supply = <&vcc5v0_sys_s5>;
>> +		vcc4-supply = <&vcc5v0_sys_s5>;
>> +		vcc5-supply = <&vcc5v0_sys_s5>;
>> +		vcc6-supply = <&vcc5v0_sys_s5>;
>> +		vcc7-supply = <&vcc5v0_sys_s5>;
>> +		vcc8-supply = <&vcc5v0_sys_s5>;
>> +		vcc9-supply = <&vcc5v0_sys_s5>;
>> +		vcc10-supply = <&vcc5v0_sys_s5>;
>> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
>> +		vcc12-supply = <&vcc5v0_sys_s5>;
>> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
>> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
>> +		vcca-supply = <&vcc5v0_sys_s5>;
>> +
>> +		rk806_dvs1_null: dvs1-null-pins {
>> +			pins = "gpio_pwrctrl1";
>> +			function = "pin_fun0";
>> +		};
>> +
>> +		rk806_dvs1_pwrdn: dvs1-pwrdn-pins {
>> +			pins = "gpio_pwrctrl1";
>> +			function = "pin_fun2";
>> +		};
>> +
>> +		rk806_dvs1_rst: dvs1-rst-pins {
>> +			pins = "gpio_pwrctrl1";
>> +			function = "pin_fun3";
>> +		};
>> +
>> +		rk806_dvs1_slp: dvs1-slp-pins {
>> +			pins = "gpio_pwrctrl1";
>> +			function = "pin_fun1";
>> +		};
>> +
>> +		rk806_dvs2_dvs: dvs2-dvs-pins {
>> +			pins = "gpio_pwrctrl2";
>> +			function = "pin_fun4";
>> +		};
>> +
>> +		rk806_dvs2_gpio: dvs2-gpio-pins {
>> +			pins = "gpio_pwrctrl2";
>> +			function = "pin_fun5";
>> +		};
>> +
>> +		rk806_dvs2_null: dvs2-null-pins {
>> +			pins = "gpio_pwrctrl2";
>> +			function = "pin_fun0";
>> +		};
>> +
>> +		rk806_dvs2_pwrdn: dvs2-pwrdn-pins {
>> +			pins = "gpio_pwrctrl2";
>> +			function = "pin_fun2";
>> +		};
>> +
>> +		rk806_dvs2_rst: dvs2-rst-pins {
>> +			pins = "gpio_pwrctrl2";
>> +			function = "pin_fun3";
>> +		};
>> +
>> +		rk806_dvs2_slp: dvs2-slp-pins {
>> +			pins = "gpio_pwrctrl2";
>> +			function = "pin_fun1";
>> +		};
>> +
>> +		rk806_dvs3_dvs: dvs3-dvs-pins {
>> +			pins = "gpio_pwrctrl3";
>> +			function = "pin_fun4";
>> +		};
>> +
>> +		rk806_dvs3_gpio: dvs3-gpio-pins {
>> +			pins = "gpio_pwrctrl3";
>> +			function = "pin_fun5";
>> +		};
>> +
>> +		rk806_dvs3_null: dvs3-null-pins {
>> +			pins = "gpio_pwrctrl3";
>> +			function = "pin_fun0";
>> +		};
>> +
>> +		rk806_dvs3_pwrdn: dvs3-pwrdn-pins {
>> +			pins = "gpio_pwrctrl3";
>> +			function = "pin_fun2";
>> +		};
>> +
>> +		rk806_dvs3_rst: dvs3-rst-pins {
>> +			pins = "gpio_pwrctrl3";
>> +			function = "pin_fun3";
>> +		};
>> +
>> +		rk806_dvs3_slp: dvs3-slp-pins {
>> +			pins = "gpio_pwrctrl3";
>> +			function = "pin_fun1";
>> +		};
>> +
>> +		regulators {
>> +			vdd_cpu_big_s0: dcdc-reg1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-enable-ramp-delay = <400>;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-name = "vdd_cpu_big_s0";
>> +				regulator-ramp-delay = <12500>;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_npu_s0: dcdc-reg2 {
>> +				regulator-boot-on;
>> +				regulator-enable-ramp-delay = <400>;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-name = "vdd_npu_s0";
>> +				regulator-ramp-delay = <12500>;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_cpu_lit_s0: dcdc-reg3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-name = "vdd_cpu_lit_s0";
>> +				regulator-ramp-delay = <12500>;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +					regulator-suspend-microvolt = <750000>;
>> +				};
>> +			};
>> +
>> +			vcc_3v3_s3: dcdc-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vcc_3v3_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <3300000>;
>> +				};
>> +			};
>> +
>> +			vdd_gpu_s0: dcdc-reg5 {
>> +				regulator-boot-on;
>> +				regulator-enable-ramp-delay = <400>;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-name = "vdd_gpu_s0";
>> +				regulator-ramp-delay = <12500>;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +					regulator-suspend-microvolt = <850000>;
>> +				};
>> +			};
>> +
>> +			vddq_ddr_s0: dcdc-reg6 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-name = "vddq_ddr_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_logic_s0: dcdc-reg7 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <800000>;
>> +				regulator-name = "vdd_logic_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_1v8_s3: dcdc-reg8 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-name = "vcc_1v8_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1800000>;
>> +				};
>> +			};
>> +
>> +			vdd2_ddr_s3: dcdc-reg9 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-name = "vdd2_ddr_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_ddr_s0: dcdc-reg10 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <1200000>;
>> +				regulator-name = "vdd_ddr_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcca_1v8_s0: pldo-reg1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-name = "vcca_1v8_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcca1v8_pldo2_s0: pldo-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-name = "vcca1v8_pldo2_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdda_1v2_s0: pldo-reg3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1200000>;
>> +				regulator-max-microvolt = <1200000>;
>> +				regulator-name = "vdda_1v2_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcca_3v3_s0: pldo-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vcca_3v3_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vccio_sd_s0: pldo-reg5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vccio_sd_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcca1v8_pldo6_s3: pldo-reg6 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-name = "vcca1v8_pldo6_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1800000>;
>> +				};
>> +			};
>> +
>> +			vdd_0v75_s3: nldo-reg1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <750000>;
>> +				regulator-max-microvolt = <750000>;
>> +				regulator-name = "vdd_0v75_s3";
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <750000>;
>> +				};
>> +			};
>> +
>> +			vdda_ddr_pll_s0: nldo-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <850000>;
>> +				regulator-name = "vdda_ddr_pll_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdda0v75_hdmi_s0: nldo-reg3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <837500>;
>> +				regulator-max-microvolt = <837500>;
>> +				regulator-name = "vdda0v75_hdmi_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdda_0v85_s0: nldo-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <850000>;
>> +				regulator-name = "vdda_0v85_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdda_0v75_s0: nldo-reg5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <750000>;
>> +				regulator-max-microvolt = <750000>;
>> +				regulator-name = "vdda_0v75_s0";
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	status = "okay";
>> +
>> +	hym8563: rtc@51 {
>> +		compatible = "haoyu,hym8563";
>> +		reg = <0x51>;
>> +		#clock-cells = <0>;
>> +		clock-output-names = "hym8563";
>> +		interrupt-parent = <&gpio0>;
>> +		interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&rtc_int_l>;
>> +		wakeup-source;
>> +	};
>> +};
>> +
>> +&pcie0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie0_perstn>;
>> +	reset-gpios = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
>> +	vpcie3v3-supply = <&vcc_3v3_s3>;
>> +	status = "okay";
>> +};
>> +
>> +&pcie1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie1_perstn>;
>> +	reset-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
>> +	vpcie3v3-supply = <&vcc_3v3_s3>;
>> +	status = "okay";
>> +};
>> +
>> +&pinctrl {
>> +	bt {
>> +		bt_reg_on_h: bt-reg-on-h {
>> +			rockchip,pins = <3 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +
>> +		bt_wake_host_h: bt-wake-host-h {
>> +			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_down>;
>> +		};
>> +
>> +		host_wake_bt_h: host-wake-bt-h {
>> +			rockchip,pins = <3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	gpio-keys {
>> +		reset_button_pin: reset-button-pin {
>> +			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	gpio-leds {
>> +		lan_led_pin: lan-led-pin {
>> +			rockchip,pins = <2 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		power_led_pin: power-led-pin {
>> +			rockchip,pins = <2 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		wan_led_pin: wan-led-pin {
>> +			rockchip,pins = <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	hdmi {
>> +		hdmi_tx_on_h: hdmi-tx-on-h {
>> +			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	hym8563 {
>> +		rtc_int_l: rtc-int-l {
>> +			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	pcie {
>> +		pcie0_perstn: pcie0-perstn {
>> +			rockchip,pins = <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +
>> +		pcie1_perstn: pcie1-perstn {
>> +			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	usb {
>> +		usb_otg0_pwren_h: usb-otg0-pwren-h {
>> +			rockchip,pins = <0 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	wifi {
>> +		wifi_wake_host_h: wifi-wake-host-h {
>> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
>> +		};
>> +
>> +		wifi_reg_on_h: wifi-reg-on-h {
>> +			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +};
>> +
>> +&sai6 {
>> +	status = "okay";
>> +};
>> +
>> +&sdmmc {
>> +	bus-width = <4>;
>> +	cap-mmc-highspeed;
>> +	cap-sd-highspeed;
>> +	disable-wp;
>> +	no-mmc;
>> +	no-sdio;
>> +	sd-uhs-sdr104;
>> +	vmmc-supply = <&vcc_3v3_s3>;
>> +	vqmmc-supply = <&vccio_sd_s0>;
>> +	status = "okay";
>> +};
>> +
>> +&sdio {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	cap-sdio-irq;
>> +	disable-wp;
>> +	keep-power-in-suspend;
>> +	mmc-pwrseq = <&sdio_pwrseq>;
>> +	no-mmc;
>> +	no-sd;
>> +	non-removable;
>> +	sd-uhs-sdr104;
>> +	vmmc-supply = <&vcc_3v3_s3>;
>> +	vqmmc-supply = <&vcc_1v8_s3>;
>> +	wakeup-source;
>> +	status = "okay";
>> +
>> +	rtl8822cs: wifi@1 {
>> +		reg = <1>;
>> +		interrupt-parent = <&gpio0>;
>> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names = "host-wake";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wifi_wake_host_h>;
>> +	};
>> +};
>> +
>> +&sdhci {
>> +	bus-width = <8>;
>> +	cap-mmc-highspeed;
>> +	full-pwr-cycle-in-suspend;
>> +	mmc-hs400-1_8v;
>> +	mmc-hs400-enhanced-strobe;
>> +	no-sdio;
>> +	no-sd;
>> +	non-removable;
>> +	status = "okay";
>> +};
>> +
>> +&saradc {
>> +	vref-supply = <&vcca_1v8_s0>;
>> +	status = "okay";
>> +};
>> +
>> +&u2phy0 {
>> +	status = "okay";
>> +};
>> +
>> +&u2phy0_otg {
>> +	phy-supply = <&vcc5v0_usb_otg0>;
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	status = "okay";
>> +};
>> +
>> +&uart5 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart5m0_xfer &uart5m0_ctsn &uart5m0_rtsn>;
>> +	uart-has-rtscts;
>> +	status = "okay";
>> +
>> +	bluetooth {
>> +		compatible = "realtek,rtl8822cs-bt";
>> +		enable-gpios = <&gpio3 RK_PC7 GPIO_ACTIVE_HIGH>;
>> +		device-wake-gpios = <&gpio3 RK_PD0 GPIO_ACTIVE_HIGH>;
>> +		host-wake-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&bt_wake_host_h &host_wake_bt_h &bt_reg_on_h>;
>> +	};
>> +};
>> +
>> +&usbdp_phy {
>> +	status = "okay";
>> +};
>> +
>> +&usb_drd0_dwc3 {
>> +	dr_mode = "host";
>> +	extcon = <&u2phy0>;
>> +	status = "okay";
>> +};
>> +
>> +&vop {
>> +	status = "okay";
>> +};
>> +
>> +&vop_mmu {
>> +	status = "okay";
>> +};
>> +
>> +&vp0 {
>> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
>> +		remote-endpoint = <&hdmi_in_vp0>;
>> +	};
>> +};
> 



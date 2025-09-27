Return-Path: <linux-kernel+bounces-834883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46F3BA5BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3444E4C5329
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08312D6407;
	Sat, 27 Sep 2025 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/+8A4t1"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E132D6E67
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758964002; cv=none; b=a22ujIdvzBdhL5m7ePj86NQUKcHUUk+KVhrUMZ6bY+USOq2GBR34DhM+EUiD02DZdtKSRsz5jJbZj3aRSkR9UPHIH/ERjXQ38udIhquNI5qj2WrB1psFzY4FotYFVcBxMn8ZVPLVICXv4FFvS/GZjObfdUgVMqg+dv19FTN8npI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758964002; c=relaxed/simple;
	bh=upsSNxpjSF1ZGJMz+HhONf6kIaFj0GxJtROGWr/ns2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMoIiLif94M0VzICTaYZVMPteaIWTiGKeDu51q6z762HL/fleG4I6oaYdSmG6xCHHh3ZjmdqwmKsbY5XOHNl/NCa3DwJmvU3wve2ojnSzjHtlFd2+TaOKLVOOZCkLDL/HbeDP9CY7+I+mnEQPBRFQ0V/DqPhq5kN0JC8LY2m6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/+8A4t1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-336b9473529so201748a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758963999; x=1759568799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCbFTzd2dCpAjJI4drsuzgxcHVKU7jqLGZbU4ZNsBII=;
        b=e/+8A4t1yxiC7a3K8Q+tkTMAZafLKtgNqwH0dGygxadbmbFLp7KM8G2/gJXOG/c487
         L0sPTTLe5xo07ThPdL+1MOr9hXahz7Ul4RusYOV1zidYPCoi4q4Cs+WcsKAQQAb+fPrV
         CQZuBTbb5vB6uZ4FrqN5v0GMhnHGdPF8QhQOLyNivnSeSmUKY8XOaU+4i/qm2HG5Ngcn
         pF71gbiosPW+4nS9PCqSoc96xAAjCB/VhuDdXUs7SflHDoLtzQnryAV70Zwj5uSvMEq2
         mrlnnjXKbZbKuVjRsSWoXDQzk745HhsOBMTfi4fY8te22i5KnH3ZIFsj17XwjyhvUR4v
         VZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758963999; x=1759568799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QCbFTzd2dCpAjJI4drsuzgxcHVKU7jqLGZbU4ZNsBII=;
        b=obAImXc/a8pD+5V1L/OheMKhI++lHLy0ugQB066DQMS2P50xUpW9m0jXDJixmjiTs1
         Msk4JRqnfWT8MDzZH0mx5mQDzGRlRRvaCinXl6WnLurdgEpBR3zJyYSAqbJsMZqhRn60
         zjObsr9N5Rj6zlT1WQcy9lbEoSwfMW/aMs/uSwrecOlJDou7+bgaIWbubTy9gFRYCXWo
         XG8ifFbAd8Ee1HFZQPg3I7SKgjri8Q1+opSJU6tsVR6vjpV7JREcu1d7p9KACSzgfNDF
         mdi8u/jzcwT6cKoBxzsg9giMoQH1PBxQb8ifZSNpzO1dpplU7ElN3tFqu9rzbQlQWi38
         /F8w==
X-Forwarded-Encrypted: i=1; AJvYcCVp8dxLi7hA+Dd++qvgqXE2FgVV0w6UbfDhsQkfaCN450POwwv7GdYmoePNGcYuyylVB/nPabXWl0gE2KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfWwJfP99aKVgpU4ADlDYViSudBdoUYPwPUcZO1celQUICt6Ga
	dRubpGybYQgRJAct20zJCVrMheochds5SmsI7TIiwLgEDM0GQevVN/gxstFmqYreoYA=
X-Gm-Gg: ASbGnctpdwAj3gpUgUdzUTUnDdc7MtDbTRcZzHs/yjV5XfUpq6fdXYXK9cBKYTyA2xA
	OJPkUjyznMLhwk0ZaMyvhEDJTsVIKS+nFNED4gGA88E948krssiwK6EWttVG/TBnCnAeyFyNxZL
	wUmWIli5/nDdZgYwJzUWeqG4p4atSQwRbsYQh3sDFucoAfXobNaRTmOkGY9pKIdoFI06Ty6BBOv
	4TmSX+9FPUnVwF5oAV/YTj2l6ywW4LiPXZn6dP65pDyAfZMOrFYIjV6+OW5kXyYtjvKqB1NJwUp
	N0fw/wkCL4UHhlVINOQWqxVyz9rCU+lvAIjMYGQnl5A9ONeUgjk2F71SB7gD/sRrVz4mV6sR4Ul
	YKFqzFi54xzC9ZLwx/pghMfHeuKzN5Z9Aw17fLCGsz6ayGVJIl2gx
X-Google-Smtp-Source: AGHT+IE/VHvW1D90dey+Xemra0uqrGoSVK8QagHRBnEerqE/3J7oBvYb0FVYPIuZMHaF+Oi3h6O5oA==
X-Received: by 2002:a17:90b:2703:b0:335:29a7:70c9 with SMTP id 98e67ed59e1d1-336b3cb3f30mr2227160a91.15.1758963998519;
        Sat, 27 Sep 2025 02:06:38 -0700 (PDT)
Received: from ?IPV6:2408:8262:245d:4074:5a47:caff:fe76:9e11? ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be38382sm11141019a91.25.2025.09.27.02.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 02:06:38 -0700 (PDT)
Message-ID: <f1d6028e-b94c-46f7-9828-99829e7bb9c7@gmail.com>
Date: Sat, 27 Sep 2025 17:06:33 +0800
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
 <1bb00ad6-ffe1-4783-909b-032dfb984180@gmail.com>
 <DD3EST9Y5UHF.12FJMDJUSZNYL@cknow.org>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <DD3EST9Y5UHF.12FJMDJUSZNYL@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/9/27 15:37, Diederik de Haas wrote:
> On Sat Sep 27, 2025 at 3:19 AM CEST, Tianling Shen wrote:
>> On 2025/9/27 0:07, Diederik de Haas wrote:
>>> On Mon Sep 22, 2025 at 11:15 AM CEST, Tianling Shen wrote:
>>>> The NanoPi R76S (as "R76S") is an open-sourced mini IoT gateway
>>>> device with two 2.5G, designed and developed by FriendlyElec.
>>>>
>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>>> ---
>>>>    arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>>>    .../boot/dts/rockchip/rk3576-nanopi-r76s.dts  | 860 ++++++++++++++++++
>>>>    2 files changed, 861 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>>>> index ad684e3831bc..2d4a1e29db6f 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>>>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>>>> @@ -155,6 +155,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5-v1.2-wifibt.dtbo
>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-evb1-v10.dtb
>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-luckfox-omni3576.dtb
>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-nanopi-m5.dtb
>>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-nanopi-r76s.dtb
>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-roc-pc.dtb
>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-rock-4d.dtb
>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3582-radxa-e52c.dtb
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
>>>> new file mode 100644
>>>> index 000000000000..731789a69677
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
>>>> @@ -0,0 +1,860 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>>>> +/*
>>>> + * Copyright (c) 2025 FriendlyElec Computer Tech. Co., Ltd.
>>>> + * (http://www.friendlyelec.com)
>>>> + *
>>>> + * Copyright (c) 2025 Tianling Shen <cnsztl@gmail.com>
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/input/input.h>
>>>> +#include <dt-bindings/leds/common.h>
>>>> +#include <dt-bindings/pinctrl/rockchip.h>
>>>> +#include <dt-bindings/soc/rockchip,vop2.h>
>>>> +
>>>> +#include "rk3576.dtsi"
>>>> +
>>>> +/ {
>>>> +	model = "FriendlyElec NanoPi R76S";
>>>> +	compatible = "friendlyarm,nanopi-r76s", "rockchip,rk3576";
>>>> +
>>>> +	aliases {
>>>> +		mmc0 = &sdhci;
>>>> +		mmc1 = &sdmmc;
>>>> +		mmc2 = &sdio;
>>>> +	};
>>>> +
>>>> +	chosen {
>>>> +		stdout-path = "serial0:1500000n8";
>>>> +	};
>>>> +
>>>> +	gpio-keys {
>>>> +		compatible = "gpio-keys";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&reset_button_pin>;
>>>> +
>>>> +		button-reset {
>>>> +			label = "reset";
>>>> +			gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_LOW>;
>>>> +			debounce-interval = <50>;
>>>> +			linux,code = <KEY_RESTART>;
>>>> +			wakeup-source;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	gpio-leds {
>>>> +		compatible = "gpio-leds";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&lan_led_pin>, <&power_led_pin>, <&wan_led_pin>;
>>>
>>> It is recommended to use the labels in the schematics to define the
>>> pinctl nodes (and thus their references). In quite a lot of cases that's
>>> indeed the case, but not for gpio-keys (USER_BUT) or these gpio-leds
>>> pinctls.
>>
>> I cannot find any specific naming rules from the gpio-keys[1] and
>> gpio-leds[2] bindings, did I miss any update?
>>
>> I think this naming matches the current practice at least in rockchip's
>> dt tree.
> 
> There is an unofficial rule/aim:
> https://lore.kernel.org/linux-rockchip/5360173.ktpJ11cQ8Q@diego/
> But granted, there is 'some' inconsistency.
> 
> And used in f.e.
> https://lore.kernel.org/linux-rockchip/20250727144409.327740-4-jonas@kwiboo.se/
> 
> Where you can just copy the pinctrl labels from the dts[i] and paste
> that in the schematic document and you're instantly at the right place.
> Which is the exact purpose of that rule/aim.
> 

Oh I see, thanks for the explanation and information, I will update them 
in v2.

>> 1.
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/input/gpio-keys.yaml
>> 2.
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/leds/leds-gpio.yaml
>>
>>>
>>>> +
>>>> +		led-0 {
>>>> +			color = <LED_COLOR_ID_GREEN>;
>>>> +			function = LED_FUNCTION_LAN;
>>>> +			gpios = <&gpio2 RK_PB0 GPIO_ACTIVE_HIGH>;
>>>> +		};
>>>> +
>>>> +		power_led: led-1 {
>>>
>>> power_led is never referenced, so you can drop it.
>>>
>>
>> This will be used by some downstream projects but I'm fine to remove it
>> here.
> 
> I'm guessing OpenWrt and I have no problem to accomodate them, but I
> don't know if that should be present in the upstream dts file. And if
> so, whether that should be mentioned in the commit message (or not).
> AFAIUI OpenWrt patches the (power-)LED definition anyway.
> 

Let's drop it here then ;)

Thanks,
Tianling.

> Cheers,
>    Diederik
> 
>>>> +			color = <LED_COLOR_ID_RED>;
>>>> +			function = LED_FUNCTION_POWER;
>>>> +			gpios = <&gpio2 RK_PB3 GPIO_ACTIVE_HIGH>;
>>>> +			linux,default-trigger = "heartbeat";
>>>> +		};
>>>> +
>>>> +		led-2 {
>>>> +			color = <LED_COLOR_ID_GREEN>;
>>>> +			function = LED_FUNCTION_WAN;
>>>> +			gpios = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	hdmi-con {
>>>> +		compatible = "hdmi-connector";
>>>> +		hdmi-pwr-supply = <&vcc5v_hdmi_tx>;
>>>> +		type = "a";
>>>> +
>>>> +		port {
>>>> +			hdmi_con_in: endpoint {
>>>> +				remote-endpoint = <&hdmi_out_con>;
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +
>>>> +	sdio_pwrseq: sdio-pwrseq {
>>>> +		compatible = "mmc-pwrseq-simple";
>>>> +		clocks = <&hym8563>;
>>>> +		clock-names = "ext_clock";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&wifi_reg_on_h>;
>>>> +		post-power-on-delay-ms = <200>;
>>>> +		reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
>>>> +	};
>>>> +
>>>> +	vcc5v_dcin: regulator-vcc5v-dcin {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +		regulator-min-microvolt = <5000000>;
>>>> +		regulator-max-microvolt = <5000000>;
>>>> +		regulator-name = "vcc5v_dcin";
>>>> +	};
>>>> +
>>>> +	vcc5v_hdmi_tx: regulator-vcc5v-hdmi-tx {
>>>> +		compatible = "regulator-fixed";
>>>> +		enable-active-high;
>>>> +		gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&hdmi_tx_on_h>;
>>>> +		regulator-min-microvolt = <5000000>;
>>>> +		regulator-max-microvolt = <5000000>;
>>>> +		regulator-name = "vcc5v_hdmi_tx";
>>>> +		vin-supply = <&vcc5v0_sys_s5>;
>>>> +	};
>>>> +
>>>> +	vcc3v3_rtc_s5: regulator-vcc3v3-rtc-s5 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +		regulator-min-microvolt = <3300000>;
>>>> +		regulator-max-microvolt = <3300000>;
>>>> +		regulator-name = "vcc3v3_rtc_s5";
>>>> +		vin-supply = <&vcc5v0_sys_s5>;
>>>> +	};
>>>> +
>>>> +	vcc5v0_device_s0: regulator-vcc5v0-device-s0 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +		regulator-min-microvolt = <5000000>;
>>>> +		regulator-max-microvolt = <5000000>;
>>>> +		regulator-name = "vcc5v0_device_s0";
>>>> +		vin-supply = <&vcc5v_dcin>;
>>>> +	};
>>>> +
>>>> +	vcc5v0_sys_s5: regulator-vcc5v0-sys-s5 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +		regulator-min-microvolt = <5000000>;
>>>> +		regulator-max-microvolt = <5000000>;
>>>> +		regulator-name = "vcc5v0_sys_s5";
>>>> +		vin-supply = <&vcc5v_dcin>;
>>>> +	};
>>>> +
>>>> +	vcc5v0_usb_otg0: regulator-vcc5v0-usb-otg0 {
>>>> +		compatible = "regulator-fixed";
>>>> +		enable-active-high;
>>>> +		gpios = <&gpio0 RK_PD1 GPIO_ACTIVE_HIGH>;
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&usb_otg0_pwren_h>;
>>>> +		regulator-min-microvolt = <5000000>;
>>>> +		regulator-max-microvolt = <5000000>;
>>>> +		regulator-name = "vcc5v0_usb_otg0";
>>>> +		vin-supply = <&vcc5v0_sys_s5>;
>>>> +	};
>>>> +
>>>> +	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +		regulator-min-microvolt = <1100000>;
>>>> +		regulator-max-microvolt = <1100000>;
>>>> +		regulator-name = "vcc_1v1_nldo_s3";
>>>> +		vin-supply = <&vcc5v0_sys_s5>;
>>>> +	};
>>>> +
>>>> +	vcc_1v8_s0: regulator-vcc-1v8-s0 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +		regulator-min-microvolt = <1800000>;
>>>> +		regulator-max-microvolt = <1800000>;
>>>> +		regulator-name = "vcc_1v8_s0";
>>>> +		vin-supply = <&vcc_1v8_s3>;
>>>> +	};
>>>> +
>>>> +	vcc_2v0_pldo_s3: regulator-vcc-2v0-pldo-s3 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +		regulator-min-microvolt = <2000000>;
>>>> +		regulator-max-microvolt = <2000000>;
>>>> +		regulator-name = "vcc_2v0_pldo_s3";
>>>> +		vin-supply = <&vcc5v0_sys_s5>;
>>>> +	};
>>>> +
>>>> +	vcc_3v3_s0: regulator-vcc-3v3-s0 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +		regulator-min-microvolt = <3300000>;
>>>> +		regulator-max-microvolt = <3300000>;
>>>> +		regulator-name = "vcc_3v3_s0";
>>>> +		vin-supply = <&vcc_3v3_s3>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&combphy0_ps {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&combphy1_psu {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&cpu_b0 {
>>>> +	cpu-supply = <&vdd_cpu_big_s0>;
>>>> +};
>>>> +
>>>> +&cpu_b1 {
>>>> +	cpu-supply = <&vdd_cpu_big_s0>;
>>>> +};
>>>> +
>>>> +&cpu_b2 {
>>>> +	cpu-supply = <&vdd_cpu_big_s0>;
>>>> +};
>>>> +
>>>> +&cpu_b3 {
>>>> +	cpu-supply = <&vdd_cpu_big_s0>;
>>>> +};
>>>> +
>>>> +&cpu_l0 {
>>>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>>>> +};
>>>> +
>>>> +&cpu_l1 {
>>>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>>>> +};
>>>> +
>>>> +&cpu_l2 {
>>>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>>>> +};
>>>> +
>>>> +&cpu_l3 {
>>>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>>>> +};
>>>> +
>>>> +&gpu {
>>>> +	mali-supply = <&vdd_gpu_s0>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&hdmi {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&hdmi_in {
>>>> +	hdmi_in_vp0: endpoint {
>>>> +		remote-endpoint = <&vp0_out_hdmi>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&hdmi_out {
>>>> +	hdmi_out_con: endpoint {
>>>> +		remote-endpoint = <&hdmi_con_in>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&hdmi_sound {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&hdptxphy {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&i2c1 {
>>>> +	status = "okay";
>>>> +
>>>> +	pmic@23 {
>>>> +		compatible = "rockchip,rk806";
>>>> +		reg = <0x23>;
>>>> +		#gpio-cells = <2>;
>>>> +		gpio-controller;
>>>> +		interrupt-parent = <&gpio0>;
>>>> +		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
>>>> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
>>>> +		system-power-controller;
>>>> +
>>>> +		vcc1-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc2-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc3-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc4-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc5-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc6-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc7-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc8-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc9-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc10-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
>>>> +		vcc12-supply = <&vcc5v0_sys_s5>;
>>>> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
>>>> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
>>>> +		vcca-supply = <&vcc5v0_sys_s5>;
>>>> +
>>>> +		rk806_dvs1_null: dvs1-null-pins {
>>>> +			pins = "gpio_pwrctrl1";
>>>> +			function = "pin_fun0";
>>>> +		};
>>>> +
>>>> +		rk806_dvs1_pwrdn: dvs1-pwrdn-pins {
>>>> +			pins = "gpio_pwrctrl1";
>>>> +			function = "pin_fun2";
>>>> +		};
>>>> +
>>>> +		rk806_dvs1_rst: dvs1-rst-pins {
>>>> +			pins = "gpio_pwrctrl1";
>>>> +			function = "pin_fun3";
>>>> +		};
>>>> +
>>>> +		rk806_dvs1_slp: dvs1-slp-pins {
>>>> +			pins = "gpio_pwrctrl1";
>>>> +			function = "pin_fun1";
>>>> +		};
>>>> +
>>>> +		rk806_dvs2_dvs: dvs2-dvs-pins {
>>>> +			pins = "gpio_pwrctrl2";
>>>> +			function = "pin_fun4";
>>>> +		};
>>>> +
>>>> +		rk806_dvs2_gpio: dvs2-gpio-pins {
>>>> +			pins = "gpio_pwrctrl2";
>>>> +			function = "pin_fun5";
>>>> +		};
>>>> +
>>>> +		rk806_dvs2_null: dvs2-null-pins {
>>>> +			pins = "gpio_pwrctrl2";
>>>> +			function = "pin_fun0";
>>>> +		};
>>>> +
>>>> +		rk806_dvs2_pwrdn: dvs2-pwrdn-pins {
>>>> +			pins = "gpio_pwrctrl2";
>>>> +			function = "pin_fun2";
>>>> +		};
>>>> +
>>>> +		rk806_dvs2_rst: dvs2-rst-pins {
>>>> +			pins = "gpio_pwrctrl2";
>>>> +			function = "pin_fun3";
>>>> +		};
>>>> +
>>>> +		rk806_dvs2_slp: dvs2-slp-pins {
>>>> +			pins = "gpio_pwrctrl2";
>>>> +			function = "pin_fun1";
>>>> +		};
>>>> +
>>>> +		rk806_dvs3_dvs: dvs3-dvs-pins {
>>>> +			pins = "gpio_pwrctrl3";
>>>> +			function = "pin_fun4";
>>>> +		};
>>>> +
>>>> +		rk806_dvs3_gpio: dvs3-gpio-pins {
>>>> +			pins = "gpio_pwrctrl3";
>>>> +			function = "pin_fun5";
>>>> +		};
>>>> +
>>>> +		rk806_dvs3_null: dvs3-null-pins {
>>>> +			pins = "gpio_pwrctrl3";
>>>> +			function = "pin_fun0";
>>>> +		};
>>>> +
>>>> +		rk806_dvs3_pwrdn: dvs3-pwrdn-pins {
>>>> +			pins = "gpio_pwrctrl3";
>>>> +			function = "pin_fun2";
>>>> +		};
>>>> +
>>>> +		rk806_dvs3_rst: dvs3-rst-pins {
>>>> +			pins = "gpio_pwrctrl3";
>>>> +			function = "pin_fun3";
>>>> +		};
>>>> +
>>>> +		rk806_dvs3_slp: dvs3-slp-pins {
>>>> +			pins = "gpio_pwrctrl3";
>>>> +			function = "pin_fun1";
>>>> +		};
>>>> +
>>>> +		regulators {
>>>> +			vdd_cpu_big_s0: dcdc-reg1 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-enable-ramp-delay = <400>;
>>>> +				regulator-min-microvolt = <550000>;
>>>> +				regulator-max-microvolt = <950000>;
>>>> +				regulator-name = "vdd_cpu_big_s0";
>>>> +				regulator-ramp-delay = <12500>;
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdd_npu_s0: dcdc-reg2 {
>>>> +				regulator-boot-on;
>>>> +				regulator-enable-ramp-delay = <400>;
>>>> +				regulator-min-microvolt = <550000>;
>>>> +				regulator-max-microvolt = <950000>;
>>>> +				regulator-name = "vdd_npu_s0";
>>>> +				regulator-ramp-delay = <12500>;
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdd_cpu_lit_s0: dcdc-reg3 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <550000>;
>>>> +				regulator-max-microvolt = <950000>;
>>>> +				regulator-name = "vdd_cpu_lit_s0";
>>>> +				regulator-ramp-delay = <12500>;
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +					regulator-suspend-microvolt = <750000>;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vcc_3v3_s3: dcdc-reg4 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <3300000>;
>>>> +				regulator-max-microvolt = <3300000>;
>>>> +				regulator-name = "vcc_3v3_s3";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-on-in-suspend;
>>>> +					regulator-suspend-microvolt = <3300000>;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdd_gpu_s0: dcdc-reg5 {
>>>> +				regulator-boot-on;
>>>> +				regulator-enable-ramp-delay = <400>;
>>>> +				regulator-min-microvolt = <550000>;
>>>> +				regulator-max-microvolt = <900000>;
>>>> +				regulator-name = "vdd_gpu_s0";
>>>> +				regulator-ramp-delay = <12500>;
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +					regulator-suspend-microvolt = <850000>;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vddq_ddr_s0: dcdc-reg6 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-name = "vddq_ddr_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdd_logic_s0: dcdc-reg7 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <550000>;
>>>> +				regulator-max-microvolt = <800000>;
>>>> +				regulator-name = "vdd_logic_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vcc_1v8_s3: dcdc-reg8 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <1800000>;
>>>> +				regulator-max-microvolt = <1800000>;
>>>> +				regulator-name = "vcc_1v8_s3";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-on-in-suspend;
>>>> +					regulator-suspend-microvolt = <1800000>;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdd2_ddr_s3: dcdc-reg9 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-name = "vdd2_ddr_s3";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-on-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdd_ddr_s0: dcdc-reg10 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <550000>;
>>>> +				regulator-max-microvolt = <1200000>;
>>>> +				regulator-name = "vdd_ddr_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vcca_1v8_s0: pldo-reg1 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <1800000>;
>>>> +				regulator-max-microvolt = <1800000>;
>>>> +				regulator-name = "vcca_1v8_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vcca1v8_pldo2_s0: pldo-reg2 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <1800000>;
>>>> +				regulator-max-microvolt = <1800000>;
>>>> +				regulator-name = "vcca1v8_pldo2_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdda_1v2_s0: pldo-reg3 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <1200000>;
>>>> +				regulator-max-microvolt = <1200000>;
>>>> +				regulator-name = "vdda_1v2_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vcca_3v3_s0: pldo-reg4 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <3300000>;
>>>> +				regulator-max-microvolt = <3300000>;
>>>> +				regulator-name = "vcca_3v3_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vccio_sd_s0: pldo-reg5 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <1800000>;
>>>> +				regulator-max-microvolt = <3300000>;
>>>> +				regulator-name = "vccio_sd_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vcca1v8_pldo6_s3: pldo-reg6 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <1800000>;
>>>> +				regulator-max-microvolt = <1800000>;
>>>> +				regulator-name = "vcca1v8_pldo6_s3";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-on-in-suspend;
>>>> +					regulator-suspend-microvolt = <1800000>;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdd_0v75_s3: nldo-reg1 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <750000>;
>>>> +				regulator-max-microvolt = <750000>;
>>>> +				regulator-name = "vdd_0v75_s3";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-on-in-suspend;
>>>> +					regulator-suspend-microvolt = <750000>;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdda_ddr_pll_s0: nldo-reg2 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <850000>;
>>>> +				regulator-max-microvolt = <850000>;
>>>> +				regulator-name = "vdda_ddr_pll_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdda0v75_hdmi_s0: nldo-reg3 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <837500>;
>>>> +				regulator-max-microvolt = <837500>;
>>>> +				regulator-name = "vdda0v75_hdmi_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdda_0v85_s0: nldo-reg4 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <850000>;
>>>> +				regulator-max-microvolt = <850000>;
>>>> +				regulator-name = "vdda_0v85_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			vdda_0v75_s0: nldo-reg5 {
>>>> +				regulator-always-on;
>>>> +				regulator-boot-on;
>>>> +				regulator-min-microvolt = <750000>;
>>>> +				regulator-max-microvolt = <750000>;
>>>> +				regulator-name = "vdda_0v75_s0";
>>>> +
>>>> +				regulator-state-mem {
>>>> +					regulator-off-in-suspend;
>>>> +				};
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +};
>>>> +
>>>> +&i2c2 {
>>>> +	status = "okay";
>>>> +
>>>> +	hym8563: rtc@51 {
>>>> +		compatible = "haoyu,hym8563";
>>>> +		reg = <0x51>;
>>>> +		#clock-cells = <0>;
>>>> +		clock-output-names = "hym8563";
>>>> +		interrupt-parent = <&gpio0>;
>>>> +		interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&rtc_int_l>;
>>>> +		wakeup-source;
>>>> +	};
>>>> +};
>>>> +
>>>> +&pcie0 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&pcie0_perstn>;
>>>> +	reset-gpios = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
>>>> +	vpcie3v3-supply = <&vcc_3v3_s3>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&pcie1 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&pcie1_perstn>;
>>>> +	reset-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
>>>> +	vpcie3v3-supply = <&vcc_3v3_s3>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&pinctrl {
>>>> +	bt {
>>>> +		bt_reg_on_h: bt-reg-on-h {
>>>> +			rockchip,pins = <3 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
>>>> +		};
>>>> +
>>>> +		bt_wake_host_h: bt-wake-host-h {
>>>> +			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_down>;
>>>> +		};
>>>> +
>>>> +		host_wake_bt_h: host-wake-bt-h {
>>>> +			rockchip,pins = <3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	gpio-keys {
>>>> +		reset_button_pin: reset-button-pin {
>>>> +			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	gpio-leds {
>>>> +		lan_led_pin: lan-led-pin {
>>>> +			rockchip,pins = <2 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>>>> +		};
>>>> +
>>>> +		power_led_pin: power-led-pin {
>>>> +			rockchip,pins = <2 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
>>>> +		};
>>>> +
>>>> +		wan_led_pin: wan-led-pin {
>>>> +			rockchip,pins = <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	hdmi {
>>>> +		hdmi_tx_on_h: hdmi-tx-on-h {
>>>> +			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	hym8563 {
>>>> +		rtc_int_l: rtc-int-l {
>>>> +			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	pcie {
>>>> +		pcie0_perstn: pcie0-perstn {
>>>> +			rockchip,pins = <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
>>>> +		};
>>>> +
>>>> +		pcie1_perstn: pcie1-perstn {
>>>> +			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	usb {
>>>> +		usb_otg0_pwren_h: usb-otg0-pwren-h {
>>>> +			rockchip,pins = <0 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	wifi {
>>>> +		wifi_wake_host_h: wifi-wake-host-h {
>>>> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
>>>> +		};
>>>> +
>>>> +		wifi_reg_on_h: wifi-reg-on-h {
>>>> +			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
>>>> +		};
>>>> +	};
>>>> +};
>>>> +
>>>> +&sai6 {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&sdmmc {
>>>> +	bus-width = <4>;
>>>> +	cap-mmc-highspeed;
>>>> +	cap-sd-highspeed;
>>>> +	disable-wp;
>>>> +	no-mmc;
>>>> +	no-sdio;
>>>> +	sd-uhs-sdr104;
>>>> +	vmmc-supply = <&vcc_3v3_s3>;
>>>> +	vqmmc-supply = <&vccio_sd_s0>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&sdio {
>>>> +	#address-cells = <1>;
>>>> +	#size-cells = <0>;
>>>> +	bus-width = <4>;
>>>> +	cap-sd-highspeed;
>>>> +	cap-sdio-irq;
>>>> +	disable-wp;
>>>> +	keep-power-in-suspend;
>>>> +	mmc-pwrseq = <&sdio_pwrseq>;
>>>> +	no-mmc;
>>>> +	no-sd;
>>>> +	non-removable;
>>>> +	sd-uhs-sdr104;
>>>> +	vmmc-supply = <&vcc_3v3_s3>;
>>>> +	vqmmc-supply = <&vcc_1v8_s3>;
>>>> +	wakeup-source;
>>>> +	status = "okay";
>>>> +
>>>> +	rtl8822cs: wifi@1 {
>>>> +		reg = <1>;
>>>> +		interrupt-parent = <&gpio0>;
>>>> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_HIGH>;
>>>> +		interrupt-names = "host-wake";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&wifi_wake_host_h>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&sdhci {
>>>> +	bus-width = <8>;
>>>> +	cap-mmc-highspeed;
>>>> +	full-pwr-cycle-in-suspend;
>>>> +	mmc-hs400-1_8v;
>>>> +	mmc-hs400-enhanced-strobe;
>>>> +	no-sdio;
>>>> +	no-sd;
>>>> +	non-removable;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&saradc {
>>>> +	vref-supply = <&vcca_1v8_s0>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&u2phy0 {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&u2phy0_otg {
>>>> +	phy-supply = <&vcc5v0_usb_otg0>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&uart0 {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&uart5 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&uart5m0_xfer &uart5m0_ctsn &uart5m0_rtsn>;
>>>> +	uart-has-rtscts;
>>>> +	status = "okay";
>>>> +
>>>> +	bluetooth {
>>>> +		compatible = "realtek,rtl8822cs-bt";
>>>> +		enable-gpios = <&gpio3 RK_PC7 GPIO_ACTIVE_HIGH>;
>>>> +		device-wake-gpios = <&gpio3 RK_PD0 GPIO_ACTIVE_HIGH>;
>>>> +		host-wake-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&bt_wake_host_h &host_wake_bt_h &bt_reg_on_h>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&usbdp_phy {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&usb_drd0_dwc3 {
>>>> +	dr_mode = "host";
>>>> +	extcon = <&u2phy0>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&vop {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&vop_mmu {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&vp0 {
>>>> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>>>> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
>>>> +		remote-endpoint = <&hdmi_in_vp0>;
>>>> +	};
>>>> +};
>>>
> 



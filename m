Return-Path: <linux-kernel+bounces-590978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6EEA7D93D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 11:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A931D3A6E1E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E504822A7EC;
	Mon,  7 Apr 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwWw7xzN"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048122FE0D;
	Mon,  7 Apr 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017248; cv=none; b=cha6kkq6wkE4JyQZdmN4Ab0M8WMtVvSH9GIbi8wELVqcKeVfMgVK+aBxjieZGVrQMw9W4nr1qTQeDwSmg2iTWYClVOqLon9TrJkUo/rka9Qmz4n934j5AGQjgYKp6bK/ULwQyiakw3Fgzt4tmLbxHet8Y+OcHeFp0J2bzOBZ578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017248; c=relaxed/simple;
	bh=llyqzRiepZn1eaXPj7bPzdNczMVjfPc1azwe4JGjzqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTJcS0ByMvgabeA3vP+YtYPiKN2KySmN2VQGRmmY0eqkEL1DgHcf64eJ2IDeYDYTIioF9x+hXL7tKXooKYYVdqQnbAimT5/8mJePSotsWQ2vAMwX36QIUlzl5ME1avaoAYvo6LJK4QjLbKRmSOlJfbB4HrELVUJwZUIg1jMPWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwWw7xzN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so7298110a12.1;
        Mon, 07 Apr 2025 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744017244; x=1744622044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBK/bo90mG2yJkfgtxifXGsZGwTMqHQB5PZswUiloPE=;
        b=DwWw7xzNo+OOeaEPsN7zKWSSqRJKcjr7JNsaFtCw6yzfpCjzLqT/Z34EqdiJNWzciC
         HeZJZFH+72UKsoi6RkKazOCn9YvC1vkqurdl8MWg3nteW8guhO1gJ1NPEgzdirFrDx0l
         9OPSaGvv/obDi2BAJId3XjtwqYhx02yI/kUtsHU8+f6T+BgHzdEiu43g2PfCo01myF5p
         dvogyL/slsnOuYLIeZf2HAnxuOdrD/S5LOzrx7J0ohea9DGM5im74EycHrJJuWnRF7WW
         p67G6kAoryK3laFGx7qVRoFutY5UuOs+7KnB/wHk30lCMfJyUlGkC3lzzaXVrRc/YEtu
         E+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744017244; x=1744622044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBK/bo90mG2yJkfgtxifXGsZGwTMqHQB5PZswUiloPE=;
        b=G9PJshsiGHpBrWh1519BsCvwx1991r2kZkdbvmzixUB54GBQixguM9VyrKYGLaQrCf
         wg3UDE1dpyiUMieMCVNuRmjQ17IZBbxNlyKYqsQda2eCCg6HmDgTvxmy1ge39if20+fH
         j9RSBcO06n/UWabzYe29srrX6KHVlbdo1D4MoxyI80g/us9mzp+Wgri5YSPqTdjwRSNJ
         6rhrmyB96QKuYrtqD1uJY7jXnOuUE7n4h36cZ7cpcj5lTqwFiCCBAuqhxgbXGr8v7OMH
         eCBZ6LXXkKL0/lAtuvhImAmilYopHj8Li8rN3mv7zrdQlLWrYwhs/sqbHt2v2Xs8cb6C
         kSgw==
X-Forwarded-Encrypted: i=1; AJvYcCXm1L9deN8UBOw+pG6nFge1fB9EmAjWsrVFCv3p+S7e+vnXT68Wj+0gxiOOHrBOOTJfY9Nknxb0gUVg@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMr6VQHT/HLOCx5cOnl81oVF/fT61xUJ+LvElNS3hoWnvcUX+
	U1anlb1s5dstDElJ/IqhlfMtP9+xVqBr08PbaRhoJqBjIg4+GT1U
X-Gm-Gg: ASbGncsEMtAFAwXSyDuyMF9d+NKtC12FMknh7Ac6oAlfHLE2mQ8XDxOIOBrMi8CMmq+
	RCCv3GAOSYUK9lYetXcuOpc/W2g8R4KqeqQrl22YeMgVNxepEQ2DpIhe0ubey/Mps3dYxoVpW/M
	hYDjYg0PyfIWI9vYlHDY60wjORQkX4S597JiENy/UCpeHvbKirZd70yKL+WXoNrlnYScLki0jTg
	YN2plxcU2aALstpl6YxLgiEzMovCwjPkOrATEJNrcVWYh9zjZP/gCRhIGit/N0MgYiy2bXPK2eF
	Tisy2/Q8ejQi97/9Lhv5obF0z9fkq+ab4Et6rJiUnqJ25ME28C/+Iw==
X-Google-Smtp-Source: AGHT+IGs2hFBsSf+B3QSmV2ONEUmxuQI/ApfYiVv+0CZPMx9h7HJh6vmqY9SAP6QG+3Tv232TBOQSA==
X-Received: by 2002:a17:907:1c92:b0:ac3:afb1:dee7 with SMTP id a640c23a62f3a-ac7d18c050bmr1185306566b.28.1744017243223;
        Mon, 07 Apr 2025 02:14:03 -0700 (PDT)
Received: from [192.168.1.130] ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c5ffsm711485166b.23.2025.04.07.02.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 02:14:02 -0700 (PDT)
Message-ID: <f975ce82-51e9-4931-ba58-4d8557b2994a@gmail.com>
Date: Mon, 7 Apr 2025 11:14:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] ARM: dts: stm32: add initial support for
 stm32mp157-ultra-fly-sbc board
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250326094429.2397365-1-goran.radni@gmail.com>
 <20250326094429.2397365-4-goran.radni@gmail.com>
Content-Language: en-US
From: Goran Radenovic <goran.radni@gmail.com>
In-Reply-To: <20250326094429.2397365-4-goran.radni@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

thank You very much for the feedback so far. Do You have any update for me?

Best regards
Goran

On 26.03.25 10:44, Goran Rađenović wrote:
> Add support for Ultratronik's stm32mp157c fly board. This board embeds
> a STM32MP157c SOC and 1GB of DDR3. Several connections are available on
> this boards: 2*USB2.0, 1*USB2.0 MiniUSB, Debug UART, 1*UART, 1*USART,
> SDcard, RJ45, ...
>
> This patch enables basic support for a kernel boot - SD-card or eMMC.
>
> Signed-off-by: Goran Rađenović <goran.radni@gmail.com>
> ---
>   MAINTAINERS                                   |    6 +
>   arch/arm/boot/dts/st/Makefile                 |    3 +-
>   .../boot/dts/st/stm32mp157c-ultra-fly-sbc.dts | 1155 +++++++++++++++++
>   3 files changed, 1163 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b5fa8436987..11fa9f2f9f55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24341,6 +24341,12 @@ S:	Maintained
>   F:	drivers/usb/common/ulpi.c
>   F:	include/linux/ulpi/
>   
> +ULTRATRONIK BOARD SUPPORT
> +M:	Goran Rađenović <goran.radni@gmail.com>
> +M:	Börge Strümpfel <boerge.struempfel@gmail.com>
> +S:	Maintained
> +F:	arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
> +
>   UNICODE SUBSYSTEM
>   M:	Gabriel Krisman Bertazi <krisman@kernel.org>
>   L:	linux-fsdevel@vger.kernel.org
> diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
> index b7d5d305cbbe..270d1c699e1a 100644
> --- a/arch/arm/boot/dts/st/Makefile
> +++ b/arch/arm/boot/dts/st/Makefile
> @@ -66,7 +66,8 @@ dtb-$(CONFIG_ARCH_STM32) += \
>   	stm32mp157c-lxa-tac-gen2.dtb \
>   	stm32mp157c-odyssey.dtb \
>   	stm32mp157c-osd32mp1-red.dtb \
> -	stm32mp157c-phycore-stm32mp1-3.dtb
> +	stm32mp157c-phycore-stm32mp1-3.dtb \
> +	stm32mp157c-ultra-fly-sbc.dtb
>   dtb-$(CONFIG_ARCH_U8500) += \
>   	ste-snowball.dtb \
>   	ste-hrefprev60-stuib.dtb \
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts b/arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
> new file mode 100644
> index 000000000000..1778f5a527ba
> --- /dev/null
> +++ b/arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
> @@ -0,0 +1,1155 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) Ultratronik GmbH 2024-2025 - All Rights Reserved
> + */
> +
> +/dts-v1/;
> +#include "stm32mp157.dtsi"
> +#include "stm32mp15xc.dtsi"
> +#include "stm32mp15-pinctrl.dtsi"
> +#include "stm32mp15xxac-pinctrl.dtsi"
> +#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> +#include <dt-bindings/mfd/st,stpmic1.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "STM STM32MP15x Ultratronik MMI_A7 board";
> +	compatible = "ultratronik,stm32mp157c-ultra-fly-sbc", "st,stm32mp157";
> +
> +	aliases {
> +		ethernet0 = &ethernet0;
> +		serial0 = &uart4;
> +		serial1 = &uart5;
> +		serial2 = &uart7;
> +		serial3 = &usart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@c0000000 {
> +		device_type = "memory";
> +		reg = <0xC0000000 0x40000000>;
> +	};
> +
> +	usb_otg_vbus: regulator-0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpioh 3 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		retram: retram@38000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x38000000 0x10000>;
> +			no-map;
> +		};
> +
> +		mcuram: mcuram@30000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x30000000 0x40000>;
> +			no-map;
> +		};
> +
> +		mcuram2: mcuram2@10000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10000000 0x40000>;
> +			no-map;
> +		};
> +
> +		vdev0vring0: vdev0vring0@10040000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10040000 0x2000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@10042000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10042000 0x2000>;
> +			no-map;
> +		};
> +
> +		vdev0buffer: vdev0buffer@10044000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10044000 0x4000>;
> +			no-map;
> +		};
> +
> +		gpu_reserved: gpu@f8000000 {
> +			reg = <0xf8000000 0x8000000>;
> +			no-map;
> +		};
> +	};
> +
> +	leds: leds {
> +		compatible = "gpio-leds";
> +
> +		led0{
> +			label = "buzzer";
> +			gpios = <&gpiof 2 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +			linux,default-trigger = "none";
> +		};
> +
> +		led1 {
> +			label = "led1";
> +			gpios = <&gpioa 12 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +
> +		led2 {
> +			label = "led2";
> +			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +
> +		led3 {
> +			label = "led3";
> +			gpios = <&gpioa 14 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-1 {
> +			label = "KEY1";
> +			gpios = <&gpiod 1 GPIO_ACTIVE_HIGH>;
> +			wakeup-source;
> +			linux,code = <2>;
> +		};
> +
> +		key-2 {
> +			label = "KEY2";
> +			gpios = <&gpiod 7 GPIO_ACTIVE_HIGH>;
> +			wakeup-source;
> +			linux,code = <3>;
> +		};
> +	};
> +};
> +
> +&adc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&adc1_ux_ain_pins_a>;
> +	vdd-supply = <&vdd>;
> +	vdda-supply = <&vdd>;
> +	vref-supply = <&vrefbuf>;
> +	status = "okay";
> +
> +	adc1: adc@0 {
> +		st,min-sample-time-nsecs = <5000>;
> +		st,adc-channels = <0 1 6 13>; /* ANA0 ANA1 PF12 PC3 */
> +		status = "okay";
> +	};
> +
> +	adc2: adc@100 {
> +		st,adc-channels = <0 1 12>; /* ANA0 ANA1 INT_TEMP*/
> +		st,min-sample-time-nsecs = <10000>;
> +		status = "okay";
> +
> +		channel@12 {
> +			reg = <12>;  /* Channel 12 = internal temperature sensor */
> +			label = "internal_temp";
> +		};
> +	};
> +};
> +
> +&dac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dac_ux_ch1_pins_a &dac_ux_ch2_pins_a>;
> +	vref-supply = <&vrefbuf>;
> +	status = "okay";
> +
> +	dac1: dac@1 {
> +		status = "okay";
> +	};
> +
> +	dac2: dac@2 {
> +		status = "okay";
> +	};
> +};
> +
> +&dts {
> +	compatible = "st,stm32-thermal";
> +	status = "okay";
> +};
> +
> +&ethernet0 {
> +	status = "okay";
> +	pinctrl-0 = <&ethernet0_ux_rgmii_pins_a>;
> +	pinctrl-1 = <&ethernet0_ux_rgmii_pins_sleep_a>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rgmii-id";
> +	max-speed = <1000>;
> +	phy-handle = <&phy1>;
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy1: ethernet-phy@1 {
> +			reg = <1>;
> +			interrupt-parent = <&gpiod>;
> +			interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> +		};
> +	};
> +};
> +
> +&gpioa {
> +	gpio-line-names =
> +	"#PMIC_IRQ", "", "", "", "DAC1", "DAC2", "", "",
> +	"", "", "OTG_ID", "TIM1_4", "#LED1", "#LED2", "#LED3", "";
> +};
> +
> +&gpiob {
> +	gpio-line-names =
> +	"", "", "", "", "", "", "", "",
> +	"", "", "", "", "", "", "", "";
> +};
> +
> +&gpioc {
> +	gpio-line-names =
> +	"#AMP_SD", "", "", "ANA5", "", "", "", "",
> +	"", "", "", "", "", "PMIC_WAKEUP", "", "";
> +};
> +
> +&gpiod {
> +	gpio-line-names =
> +	"#G_INT", "#TASTER1", "", "", "GPIO1", "GPIO2", "", "#TASTER2",
> +	"", "", "", "", "", "", "TIM4_3", "TIM4_4";
> +};
> +
> +&gpioe {
> +	gpio-line-names =
> +	"", "", "", "", "", "", "", "",
> +	"", "", "PWM2", "", "", "", "", "";
> +};
> +
> +&gpiof {
> +	gpio-line-names =
> +	"#SD1_CD", "SD1_WP", "BUZZER", "#DISP_POW", "BKL_POW", "#CAM_RES", "", "",
> +	"", "TIM17_1N", "", "CAM_PWDN", "ANA6", "ENA_USB", "", "";
> +};
> +
> +&gpiog {
> +	gpio-line-names =
> +	"#ESP_RES", "#ESP_BOOT", "GPIO3", "GPIO4", "", "", "", "",
> +	"", "#TOUCH_IRQ", "", "", "", "", "", "#PCAP_RES";
> +};
> +
> +&gpioh {
> +	gpio-line-names =
> +	"", "CAM_LED", "", "USB_OTG_PWR", "", "USB_OTG_OC", "", "",
> +	"", "", "", "", "", "", "", "";
> +};
> +
> +&gpioi {
> +	gpio-line-names =
> +	"BKL_PWM", "", "", "", "", "", "", "",
> +	"#SPI_CS0", "", "", "#SPI_CS1", "", "", "", "";
> +};
> +
> +&gpioj {
> +	gpio-line-names =
> +	"", "", "", "", "", "", "", "",
> +	"", "", "", "", "", "", "", "";
> +};
> +
> +&gpiok {
> +	gpio-line-names =
> +	"", "", "", "", "", "", "", "",
> +	"", "", "", "", "", "", "", "";
> +};
> +
> +&gpioz {
> +	gpio-line-names =
> +	"", "", "", "#SPI_CS2", "", "", "", "",
> +	"", "", "", "", "", "", "", "";
> +};
> +
> +&gpu {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c1_ux_pins_a>;
> +	pinctrl-1 = <&i2c1_ux_pins_sleep_a>;
> +	i2c-scl-rising-time-ns = <100>;
> +	i2c-scl-falling-time-ns = <7>;
> +	status = "okay";
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	rtc@32 {
> +		compatible = "epson,rx8900";
> +		reg = <0x32>;
> +		epson,vdet-disable;
> +		trickle-diode-disable;
> +	};
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c4_ux_pins_a>;
> +	pinctrl-1 = <&i2c4_ux_pins_sleep_a>;
> +	i2c-scl-rising-time-ns = <185>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "okay";
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	pmic: pmic@33 {
> +		compatible = "st,stpmic1";
> +		reg = <0x33>;
> +		interrupts-extended = <&exti 0 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		regulators {
> +			compatible = "st,stpmic1-regulators";
> +
> +			ldo1-supply = <&v3v3>;
> +			ldo3-supply = <&vdd_ddr>;
> +			ldo6-supply = <&v3v3>;
> +			pwr_sw1-supply = <&bst_out>;
> +			pwr_sw2-supply = <&bst_out>;
> +
> +			vddcore: buck1 {
> +				regulator-name = "vddcore";
> +				regulator-min-microvolt = <1250000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd_ddr: buck2 {
> +				regulator-name = "vdd_ddr";
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd: buck3 {
> +				regulator-name = "vdd";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				st,mask-reset;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			v3v3: buck4 {
> +				regulator-name = "v3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +				regulator-initial-mode = <0>;
> +			};
> +
> +			vtt_ddr: ldo3 {
> +				regulator-name = "vtt_ddr";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd_usb: ldo4 {
> +				regulator-name = "vdd_usb";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				interrupts = <IT_CURLIM_LDO4 0>;
> +			};
> +
> +			v1v8: ldo6 {
> +				regulator-name = "v1v8";
> +				regulator-min-microvolt = <1600000>;/* offset +200 mv ??? */
> +				regulator-max-microvolt = <1600000>;/* real 1800000 */
> +				regulator-always-on;
> +				interrupts = <IT_CURLIM_LDO6 0>;
> +			};
> +
> +			vref_ddr: vref_ddr {
> +				regulator-name = "vref_ddr";
> +				regulator-always-on;
> +			};
> +
> +			bst_out: boost {
> +				regulator-name = "bst_out";
> +				interrupts = <IT_OCP_BOOST 0>;
> +			};
> +
> +			vbus_otg: pwr_sw1 {
> +				regulator-name = "vbus_otg";
> +				interrupts = <IT_OCP_OTG 0>;
> +				regulator-active-discharge = <1>;
> +			 };
> +
> +			 vbus_sw: pwr_sw2 {
> +				regulator-name = "vbus_sw";
> +				interrupts = <IT_OCP_SWOUT 0>;
> +				regulator-active-discharge = <1>;
> +			 };
> +		};
> +	};
> +};
> +
> +&iwdg2 {
> +	timeout-sec = <32>;
> +	status = "okay";
> +};
> +
> +&m_can2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&m_can2_ux_pins_a>;
> +	pinctrl-1 = <&m_can2_ux_sleep_pins_a>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +
> +	adc1_ux_ain_pins_a: adc1-ux-ain-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('F',12, ANALOG)>, /* ADC1 in6 */
> +				 <STM32_PINMUX('C', 3, ANALOG)>; /* ADC2 in13 */
> +		};
> +	};
> +
> +	dac_ux_ch1_pins_a: dac-ux-ch1-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 4, ANALOG)>;
> +		};
> +	};
> +
> +	dac_ux_ch2_pins_a: dac-ux-ch2-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 5, ANALOG)>;
> +		};
> +	};
> +
> +	ethernet0_ux_rgmii_pins_a: rgmii-ux-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
> +				 <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
> +				 <STM32_PINMUX('G', 13, AF11)>, /* ETH_RGMII_TXD0 */
> +				 <STM32_PINMUX('G', 14, AF11)>, /* ETH_RGMII_TXD1 */
> +				 <STM32_PINMUX('C', 2, AF11)>, /* ETH_RGMII_TXD2 */
> +				 <STM32_PINMUX('E', 2, AF11)>, /* ETH_RGMII_TXD3 */
> +				 <STM32_PINMUX('B', 11, AF11)>; /* ETH_RGMII_TX_CTL */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <2>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('C', 4, AF11)>, /* ETH_RGMII_RXD0 */
> +				 <STM32_PINMUX('C', 5, AF11)>, /* ETH_RGMII_RXD1 */
> +				 <STM32_PINMUX('B', 0, AF11)>, /* ETH_RGMII_RXD2 */
> +				 <STM32_PINMUX('H', 7, AF11)>, /* ETH_RGMII_RXD3 */
> +				 <STM32_PINMUX('A', 1, AF11)>, /* ETH_RGMII_RX_CLK */
> +				 <STM32_PINMUX('A', 7, AF11)>; /* ETH_RGMII_RX_CTL */
> +			bias-disable;
> +		};
> +		pins3 {
> +			pinmux = <STM32_PINMUX('C', 1, AF11)>; /* ETH_MDC */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins4 {
> +			pinmux = <STM32_PINMUX('A', 2, AF11)>; /* ETH_MDIO */
> +			bias-disable;
> +			drive-open-drain;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	ethernet0_ux_rgmii_pins_sleep_a: rgmii-ux-sleep-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_RGMII_CLK125 */
> +				 <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
> +				 <STM32_PINMUX('G', 13, ANALOG)>, /* ETH_RGMII_TXD0 */
> +				 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH_RGMII_TXD1 */
> +				 <STM32_PINMUX('C', 2, ANALOG)>, /* ETH_RGMII_TXD2 */
> +				 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RGMII_TXD3 */
> +				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH_RGMII_TX_CTL */
> +				 <STM32_PINMUX('A', 2, ANALOG)>, /* ETH_MDIO */
> +				 <STM32_PINMUX('C', 1, ANALOG)>, /* ETH_MDC */
> +				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
> +				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_RGMII_RXD1 */
> +				 <STM32_PINMUX('B', 0, ANALOG)>, /* ETH_RGMII_RXD2 */
> +				 <STM32_PINMUX('B', 1, ANALOG)>, /* ETH_RGMII_RXD3 */
> +				 <STM32_PINMUX('A', 1, ANALOG)>, /* ETH_RGMII_RX_CLK */
> +				 <STM32_PINMUX('A', 7, ANALOG)>; /* ETH_RGMII_RX_CTL */
> +		};
> +	};
> +
> +	i2c1_ux_pins_a: i2c1-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('F', 14, AF5)>, /* I2C1_SCL */
> +				 <STM32_PINMUX('F', 15, AF5)>; /* I2C1_SDA */
> +			bias-disable;
> +			drive-open-drain;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	i2c1_ux_pins_sleep_a: i2c1-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('F', 14, ANALOG)>, /* I2C1_SCL */
> +				 <STM32_PINMUX('F', 15, ANALOG)>; /* I2C1_SDA */
> +		};
> +	};
> +
> +	m_can2_ux_pins_a: m-can2-ux-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 6, AF9)>; /* CAN1_TX */
> +			slew-rate = <0>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 5, AF9)>; /* CAN1_RX */
> +			bias-disable;
> +		};
> +	};
> +
> +	m_can2_ux_sleep_pins_a: m-can2-ux-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('B', 6, ANALOG)>, /* CAN1_TX */
> +				 <STM32_PINMUX('B', 5, ANALOG)>; /* CAN1_RX */
> +		};
> +	};
> +	pwm1_ux_pins_a: pwm1-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A',11, AF1)>, /* TIM1_CH4 */
> +				 <STM32_PINMUX('E',10, AF1)>; /* TIM1_CH2N */
> +			bias-pull-down;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm1_ux_sleep_pins_a: pwm1-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A',11, ANALOG)>, /* TIM1_CH4 */
> +				 <STM32_PINMUX('E',10, ANALOG)>; /* TIM1_CH2N */
> +		};
> +	};
> +
> +	pwm4_ux_pins_a: pwm4-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('D', 14, AF2)>, /* TIM4_CH3 */
> +				 <STM32_PINMUX('D', 15, AF2)>; /* TIM4_CH4 */
> +			bias-disable;
> +		};
> +	};
> +
> +	pwm4_ux_sleep_pins_a: pwm4-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('D', 14, ANALOG)>, /* TIM4_CH3 */
> +				 <STM32_PINMUX('D', 15, ANALOG)>; /* TIM4_CH4 */
> +		};
> +	};
> +
> +	pwm5_ux_pins_a: pwm5-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('I', 0, AF2)>; /* TIM5_CH4 */
> +			bias-pull-down;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm5_ux_sleep_pins_a: pwm5-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('I', 0, ANALOG)>; /* TIM5_CH4 */
> +		};
> +	};
> +
> +	pwm17_ux_pins_a: pwm17-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('F', 9, AF1)>; /* TIM17_CH1N */
> +			bias-pull-down;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm17_ux_sleep_pins_a: pwm17-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('F', 9, ANALOG)>; /* TIM17_CH1N */
> +		};
> +	};
> +
> +	qspi_bk1_ux_pins_a: qspi-bk1-ux-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
> +				 <STM32_PINMUX('D',12, AF9)>, /* QSPI_BK1_IO1 */
> +				 <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
> +				 <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <1>;
> +		};
> +
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B',10, AF9)>; /* QSPI_BK1_NCS */
> +			bias-pull-up;
> +			drive-push-pull;
> +			slew-rate = <1>;
> +		};
> +	};
> +
> +	qspi_bk1_ux_sleep_pins_a: qspi-bk1-ux-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('F', 8, ANALOG)>, /* QSPI_BK1_IO0 */
> +				 <STM32_PINMUX('D',12, ANALOG)>, /* QSPI_BK1_IO1 */
> +				 <STM32_PINMUX('F', 7, ANALOG)>, /* QSPI_BK1_IO2 */
> +				 <STM32_PINMUX('F', 6, ANALOG)>, /* QSPI_BK1_IO3 */
> +				 <STM32_PINMUX('B',10, ANALOG)>; /* QSPI_BK1_NCS */
> +		};
> +	};
> +
> +	qspi_clk_ux_pins_a: qspi-clk_ux-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('G', 7, AF9)>; /* QSPI_CLK */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <3>;
> +		};
> +	};
> +
> +	qspi_clk_ux_sleep_pins_a: qspi-clk-ux-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('G', 7, ANALOG)>; /* QSPI_CLK */
> +		};
> +	};
> +
> +	sai2a_ux_pins_a: sai2a-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('I', 5, AF10)>, /* SAI2_SCK_A */
> +				 <STM32_PINMUX('D',11, AF10)>, /* SAI2_SD_A */
> +				 <STM32_PINMUX('I', 7, AF10)>, /* SAI2_FS_A */
> +				 <STM32_PINMUX('E', 0, AF10)>; /* SAI2_MCLK_A */
> +			slew-rate = <0>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +	};
> +
> +	sai2a_ux_sleep_pins_a: sai2a-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('I', 5, ANALOG)>, /* SAI2_SCK_A */
> +				 <STM32_PINMUX('D',11, ANALOG)>, /* SAI2_SD_A */
> +				 <STM32_PINMUX('I', 7, ANALOG)>, /* SAI2_FS_A */
> +				 <STM32_PINMUX('E', 0, ANALOG)>; /* SAI2_MCLK_A */
> +		};
> +	};
> +
> +	sdmmc1_ux_b4_pins_a: sdmmc1-ux-b4-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> +				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> +				 <STM32_PINMUX('C',10, AF12)>, /* SDMMC1_D2 */
> +				 <STM32_PINMUX('C',11, AF12)>, /* SDMMC1_D3 */
> +				 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
> +			slew-rate = <1>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
> +			slew-rate = <2>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +	};
> +
> +	sdmmc1_ux_b4_od_pins_a: sdmmc1-b4-od-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> +				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> +				 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
> +				 <STM32_PINMUX('C', 11, AF12)>; /* SDMMC1_D3 */
> +			slew-rate = <1>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
> +			slew-rate = <2>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +		pins3 {
> +			pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
> +			slew-rate = <1>;
> +			drive-open-drain;
> +			bias-disable;
> +		};
> +	};
> +
> +	sdmmc1_ux_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
> +				 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
> +				 <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
> +				 <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
> +				 <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
> +				 <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
> +		};
> +	};
> +
> +	sdmmc2_ux_b4_pins_a: sdmmc2-ux-b4-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
> +				<STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
> +				<STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
> +				<STM32_PINMUX('B', 4, AF9)>, /* SDMMC2_D3 */
> +				<STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
> +			slew-rate = <1>;
> +			drive-push-pull;
> +			bias-pull-up;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('E', 3, AF9)>; /* SDMMC2_CK */
> +			slew-rate = <2>;
> +			drive-push-pull;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	sdmmc2_ux_b4_od_pins_a: sdmmc2-ux-b4-od-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
> +				<STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
> +				<STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
> +				<STM32_PINMUX('B', 4, AF9)>; /* SDMMC2_D3 */
> +			slew-rate = <1>;
> +			drive-push-pull;
> +			bias-pull-up;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('E', 3, AF9)>; /* SDMMC2_CK */
> +			slew-rate = <2>;
> +			drive-push-pull;
> +			bias-pull-up;
> +		};
> +		pins3 {
> +			pinmux = <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
> +			slew-rate = <1>;
> +			drive-open-drain;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	sdmmc2_ux_b4_sleep_pins_a: sdmmc2-ux-b4-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC2_D0 */
> +				<STM32_PINMUX('B', 15, ANALOG)>, /* SDMMC2_D1 */
> +				<STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC2_D2 */
> +				<STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC2_D3 */
> +				<STM32_PINMUX('E', 3, ANALOG)>, /* SDMMC2_CK */
> +				<STM32_PINMUX('G', 6, ANALOG)>; /* SDMMC2_CMD */
> +		};
> +	};
> +
> +	sdmmc2_ux_d47_pins_a: sdmmc2-ux-d47-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
> +				<STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
> +				<STM32_PINMUX('E', 5, AF9)>, /* SDMMC2_D6 */
> +				<STM32_PINMUX('D', 3, AF9)>; /* SDMMC2_D7 */
> +			slew-rate = <1>;
> +			drive-push-pull;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	sdmmc2_ux_d47_sleep_pins_a: sdmmc2-ux-d47-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
> +				<STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
> +				<STM32_PINMUX('E', 5, ANALOG)>, /* SDMMC2_D6 */
> +				<STM32_PINMUX('D', 3, ANALOG)>; /* SDMMC2_D7 */
> +		};
> +	};
> +
> +	uart4_ux_pins_a: uart4-ux-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
> +			bias-disable;
> +		};
> +	};
> +
> +	uart4_ux_idle_pins_a: uart4-ux-idle-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('G', 11, ANALOG)>; /* UART4_TX */
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
> +			bias-disable;
> +		};
> +		};
> +
> +	uart4_ux_sleep_pins_a: uart4-ux-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('G', 11, ANALOG)>, /* UART4_TX */
> +				<STM32_PINMUX('B', 2, ANALOG)>; /* UART4_RX */
> +		};
> +	};
> +
> +	uart5_ux_pins_a: uart5-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 13, AF14)>; /* UART5_TX */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 12, AF14)>; /* UART5_RX */
> +			bias-disable;
> +		};
> +	};
> +
> +	uart5_ux_idle_pins_a: uart5-idle-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 13, ANALOG)>; /* UART5_TX */
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 12, AF14)>; /* UART5_RX*/
> +			bias-disable;
> +		};
> +	};
> +
> +	uart5_ux_sleep_pins_a: uart5-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('B', 13, ANALOG)>, /* UART5_TX */
> +				 <STM32_PINMUX('B', 12, ANALOG)>; /* UART5_RX */
> +		};
> +	};
> +
> +	uart7_ux_pins_a: uart7-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* USART7_TX */
> +			bias-pull-up;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +
> +		pins2 {
> +			pinmux = <STM32_PINMUX('E', 7, AF7)>; /* USART7_RX */
> +			bias-pull-up;
> +		};
> +		pins3 {
> +			pinmux = <STM32_PINMUX('E', 9, AF7)>; /* USART7_RTS/DE */
> +		};
> +	};
> +
> +	uart7_ux_idle_pins_a: uart7-idle-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('E', 8, ANALOG)>, /* USART7_TX */
> +				 <STM32_PINMUX('E', 9, AF7)>; /* USART7_RTS/DE */
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('E', 7, AF7)>; /* USART7_RX */
> +			bias-disable;
> +		};
> +	};
> +
> +	uart7_ux_sleep_pins_a: uart7-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('E', 8, ANALOG)>, /* USART7_TX */
> +				 <STM32_PINMUX('E', 9, AF7)>, /* USART7_RTS/DE */
> +				 <STM32_PINMUX('E', 7, ANALOG)>; /* USART7_RX */
> +		};
> +	};
> +};
> +
> +&pinctrl_z {
> +
> +	i2c4_ux_pins_a: i2c4-ux-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('Z', 4, AF6)>, /* I2C4_SCL */
> +				<STM32_PINMUX('Z', 5, AF6)>; /* I2C4_SDA */
> +			bias-disable;
> +			drive-open-drain;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	i2c4_ux_pins_sleep_a: i2c4-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('Z', 4, ANALOG)>, /* I2C4_SCL */
> +				<STM32_PINMUX('Z', 5, ANALOG)>; /* I2C4_SDA */
> +		};
> +	};
> +
> +	spi1_ux_pins_a: spi1-ux-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('Z', 0, AF5)>, /* SPI1_SCK */
> +				<STM32_PINMUX('Z', 2, AF5)>; /* SPI1_MOSI */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <1>;
> +		};
> +
> +		pins2 {
> +			pinmux = <STM32_PINMUX('Z', 1, AF5)>; /* SPI1_MISO */
> +			bias-disable;
> +		};
> +	};
> +
> +	spi1_ux_sleep_pins_a: spi1-ux-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('Z', 0, ANALOG)>, /* SPI1_SCK */
> +				<STM32_PINMUX('Z', 1, ANALOG)>, /* SPI1_MISO */
> +				<STM32_PINMUX('Z', 2, ANALOG)>; /* SPI1_MOSI */
> +		};
> +	};
> +};
> +
> +&pwr_regulators {
> +	vdd-supply = <&vdd>;
> +	vdd_3v3_usbfs-supply = <&vdd_usb>;
> +};
> +
> +&qspi {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&qspi_clk_ux_pins_a &qspi_bk1_ux_pins_a>;
> +	pinctrl-1 = <&qspi_clk_ux_sleep_pins_a &qspi_bk1_ux_sleep_pins_a>;
> +	reg = <0x58003000 0x1000>, <0x70000000 0x1000000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	flash0: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <133000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> +
> +&sdmmc1 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc1_ux_b4_pins_a>;
> +	pinctrl-1 = <&sdmmc1_ux_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc1_ux_b4_sleep_pins_a>;
> +	broken-cd;
> +	st,neg-edge;
> +	bus-width = <4>;
> +	vmmc-supply = <&v3v3>;
> +	no-1-8-v;
> +	status = "okay";
> +};
> +
> +&sdmmc2 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc2_ux_b4_pins_a &sdmmc2_ux_d47_pins_a>;
> +	pinctrl-1 = <&sdmmc2_ux_b4_od_pins_a &sdmmc2_ux_d47_pins_a>;
> +	pinctrl-2 = <&sdmmc2_ux_b4_sleep_pins_a &sdmmc2_ux_d47_sleep_pins_a>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	st,neg-edge;
> +	bus-width = <8>;
> +	vmmc-supply = <&v3v3>;
> +	vqmmc-supply = <&v3v3>;
> +	mmc-ddr-3_3v;
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&spi1_ux_pins_a>;
> +	pinctrl-1 = <&spi1_ux_sleep_pins_a>;
> +	status = "okay";
> +	cs-gpios = <&gpioi 8 0>, <&gpioi 11 0>, <&gpioz 3 0>;
> +
> +	flash: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +&timers1 {
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +
> +	pwm {
> +		pinctrl-0 = <&pwm1_ux_pins_a>;
> +		pinctrl-1 = <&pwm1_ux_sleep_pins_a>;
> +		pinctrl-names = "default", "sleep";
> +		status = "okay";
> +	};
> +
> +	timer@0 {
> +		status = "okay";
> +	};
> +};
> +
> +&timers4 {
> +	dmas = <&dmamux1 31 0x400 0x5>;
> +	dma-names = "ch3";
> +	status = "okay";
> +
> +	pwm4_4: pwm {
> +		pinctrl-0 = <&pwm4_ux_pins_a>;
> +		pinctrl-1 = <&pwm4_ux_sleep_pins_a>;
> +		pinctrl-names = "default", "sleep";
> +		status = "okay";
> +	};
> +};
> +
> +&timers5 {
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +
> +	pwm5_4: pwm {
> +		pinctrl-0 = <&pwm5_ux_pins_a>;
> +		pinctrl-1 = <&pwm5_ux_sleep_pins_a>;
> +		pinctrl-names = "default", "sleep";
> +		status = "okay";
> +	};
> +
> +	timer@4 {
> +		status = "okay";
> +	};
> +};
> +
> +&timers17 {
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +
> +	pwm17_4: pwm {
> +		pinctrl-0 = <&pwm17_ux_pins_a>;
> +		pinctrl-1 = <&pwm17_ux_sleep_pins_a>;
> +		pinctrl-names = "default", "sleep";
> +		status = "okay";
> +	};
> +
> +	timer@16 {
> +		status = "okay";
> +	};
> +};
> +
> +&uart4 {
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	pinctrl-names = "default", "sleep", "idle", "no_console_suspend";
> +	pinctrl-0 = <&uart4_ux_pins_a>;
> +	pinctrl-1 = <&uart4_ux_sleep_pins_a>;
> +	pinctrl-2 = <&uart4_ux_idle_pins_a>;
> +	pinctrl-3 = <&uart4_ux_pins_a>;
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	pinctrl-names = "default", "sleep", "idle";
> +	pinctrl-0 = <&uart5_ux_pins_a>;
> +	pinctrl-1 = <&uart5_ux_sleep_pins_a>;
> +	pinctrl-2 = <&uart5_ux_idle_pins_a>;
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	pinctrl-names = "default", "sleep", "idle";
> +	pinctrl-0 = <&uart7_ux_pins_a>;
> +	pinctrl-1 = <&uart7_ux_sleep_pins_a>;
> +	pinctrl-2 = <&uart7_ux_idle_pins_a>;
> +	status = "okay";
> +};
> +
> +&usart1 {
> +	/*Muxing happens in uboot*/
> +	status = "okay";
> +};
> +
> +&usbh_ehci {
> +	phys = <&usbphyc_port0>;
> +	phy-names = "usb";
> +	status = "okay";
> +};
> +
> +&usbh_ohci {
> +	phys = <&usbphyc_port0>;
> +	phy-names = "usb";
> +	status = "okay";
> +};
> +
> +&usbotg_hs {
> +	phys = <&usbphyc_port1 0>;
> +	phy-names = "usb2-phy";
> +	vbus-supply = <&usb_otg_vbus>;
> +	status = "okay";
> +};
> +
> +&usbphyc {
> +	status = "okay";
> +};
> +
> +&usbphyc_port0 {
> +	phy-supply = <&vdd_usb>;
> +	st,tune-hs-dc-level = <2>;
> +	st,enable-fs-rftime-tuning;
> +	st,enable-hs-rftime-reduction;
> +	st,trim-hs-current = <15>;
> +	st,trim-hs-impedance = <1>;
> +	st,tune-squelch-level = <3>;
> +	st,tune-hs-rx-offset = <2>;
> +	st,no-lsfs-sc;
> +};
> +
> +&usbphyc_port1 {
> +	phy-supply = <&vdd_usb>;
> +	st,tune-hs-dc-level = <2>;
> +	st,enable-fs-rftime-tuning;
> +	st,enable-hs-rftime-reduction;
> +	st,trim-hs-current = <15>;
> +	st,trim-hs-impedance = <1>;
> +	st,tune-squelch-level = <3>;
> +	st,tune-hs-rx-offset = <2>;
> +	st,no-lsfs-sc;
> +};
> +
> +&vrefbuf {
> +	regulator-min-microvolt = <2500000>;
> +	regulator-max-microvolt = <2500000>;
> +	vdda-supply = <&vdd>;
> +	status = "okay";
> +};


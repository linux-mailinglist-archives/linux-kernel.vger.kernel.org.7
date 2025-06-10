Return-Path: <linux-kernel+bounces-678873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B86AD2F55
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 09:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB7518850C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2698280304;
	Tue, 10 Jun 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPcxq6Th"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26427FD7A;
	Tue, 10 Jun 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542244; cv=none; b=B+wdH56CnDqoaoC4RM1iK7G66qHXvnHQGQdg9Q5DWbi9bKV2XAPSFCZEYCJc4fo97e/pXigoZnhhRpAPMwGoXghE3Anm1XxTYme/2evbKMIvYqU3ojLW3N3W09zLOwz91PqzqrNIF4999t3HBUCDh8DkGrLkYjHqMmsdKsoUlK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542244; c=relaxed/simple;
	bh=yvEzhaFzzoIJ3xrLr16gxSM7Jx0FuVpZu6mpNe5/s78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sm33FCex6ycLZqL8fjQMI1qJkVQTsEyNBYngQ9uo5G4e1E4y4/gvXy3HnJHjNcnhSeESB5pucp+aFEbdcXXtufSuNOLc69+lebRHUotNn3JGOBOSm9ax0D2ll2Sz8kG9K6y9r9oLr+w55q2zsTIGv1AkE6MMEgXEiJ+iF90M6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPcxq6Th; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad572ba1347so743294166b.1;
        Tue, 10 Jun 2025 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749542240; x=1750147040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXEz39qlPkRLfjKRravFg/i6u+sNIbt6DEgrjazchnc=;
        b=RPcxq6ThlVLdausInJnFS+pnIR9Ydpoma1SGBD6u1KGKbz1vFBF0O5H3pEblJvewIu
         iCdG9A2ZOW2x8hPu+McVI+7LZixP89zOMYbBK2GLESr9dHqZWiRKAMJeEo5js3F3C5Lm
         6CYusbRjKDR5AYNDME5kLSQqb4tzdGMhIyjG1U8gxe9HSb0Ym5b2oEbSUTJ6FSI3X0/p
         ZAIMGZZkYBap+320K7bVexnV7X0Ubvy33Gbx21nfiBtamsq/C+Sn08KkfKtu2rcgD41n
         O2dxjtckHe1C/hcG0dp8+PGFBoGu3HsIBlSd7duMsn+BZR5PMYbQ7lp257b5l0QMuR3z
         uhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749542240; x=1750147040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXEz39qlPkRLfjKRravFg/i6u+sNIbt6DEgrjazchnc=;
        b=C51fT73gI98xmeD3JGULOQyJsnUErhVbKAB96hDxZT2VBESQG5tTd+kgUKzNib5IK/
         ByXHYlDQoGXZDzGJgT1pJt1i/ThheMIVxIS0dbXKv4JJnlzNBdPr1YQMGdj5RxM+6MFl
         AFu9h8igqhNAPOcTWYNpgDnwrTGjOryUuux9CdniluTD7zwEHwh5XRzBLJma0AMns8gK
         oQror4/pRPtkj6igmJ8Q76qJMuDgUQVfSI2Ng7FT0cGOyw4yrEGj5Le+kJALMZuJUpSu
         e/zD2cigN+6yv9g1d0D2v6+4ifx7BulVlU0IjDw8TP6tm6Ne6LhHehf6lcDE0mPGF5GS
         OZgA==
X-Forwarded-Encrypted: i=1; AJvYcCUSoiGJgoRJ1knRwEa0Ww95+Zg+2+b25DCW8t+WNEQJudbD3/sgsOZQXepRaWfXpXSr4DardgdQSdaI@vger.kernel.org, AJvYcCWfNVr3Flt5sitLhOx4MPN6C+Jte0AylcJ5Xc7HucWrFooG5gM+vt/SBIVPAGbRLwZrTmePpMgSovjOMxIq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52AaEtBcxxdTn+xbJQMKh3jJGVbx2cO/ZYUqMyokPtPySNVhb
	KQnhSA/ercWbHiDJoF38CmpBcjVq6iNbuvxWpzJv4bN+XlPf2ddSAWMRbJHfpA==
X-Gm-Gg: ASbGncssHx6oFP2Zcb0uB32OicH+QLhotW5i0OAzx2fANY8eUxNQZQYyJFPFCJbf2FR
	1EQHZ+HtKCjqzomxd+9iA+eIDkqdE2+OeDZxW/cotq2hTxjePJ5yHbDrt8uQq8cs0xs529byEqU
	vP4KUyfzmstwvFlq6DusUF6CcjUFyvqFd0UfYzjFlgZniNExaqnEa1nAIGjPfGNA5HsORwa+IU7
	xMLcM0Q75xDg497thSRjbb6YTL8gx6XD6WbedgoAh5KTP0EfHlgBoTqoxAXnGUXyYITSHe7rpWe
	4MIfLhX4BJhB3xW/Kylu+FNevcSdG09LQ/Z3vKjQY7mOHRs5kmWE907B6sbt50O1h3H9SjusHIV
	uK+kJw/b8g0AtW6AHiJ4BnJkdIJ6k
X-Google-Smtp-Source: AGHT+IEsS/+RD/EAfhTF5UnI34QY3JxgQh7bcmSonLyX0ddXKzEGSeq1u6Th3PsLJT9K9zv5PEC9TA==
X-Received: by 2002:a17:906:5acf:b0:ade:4448:9a0a with SMTP id a640c23a62f3a-ade44489d2cmr748729766b.19.1749542239459;
        Tue, 10 Jun 2025 00:57:19 -0700 (PDT)
Received: from [192.168.1.130] (11-127.static.abakusbp.net. [46.17.127.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc37ae2sm673339666b.112.2025.06.10.00.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 00:57:19 -0700 (PDT)
Message-ID: <bf2eb64b-ac33-4c2b-8ad6-6a21d5d6bcb7@gmail.com>
Date: Tue, 10 Jun 2025 09:57:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: imx8mp: Add initial support for
 Ultratronik imx8mp-ultra-mach-sbc board
To: Frank Li <Frank.li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?=
 <boerge.struempfel@gmail.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250605142728.2891465-1-goran.radni@gmail.com>
 <20250605142728.2891465-4-goran.radni@gmail.com>
 <aEH4R5euW19fO/0f@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Goran Radenovic <goran.radni@gmail.com>
In-Reply-To: <aEH4R5euW19fO/0f@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Frank,

thank You for the review. I'll fix it in v2.

Best regards
Goran

Frank Li wrote:
> On Thu, Jun 05, 2025 at 04:27:26PM +0200, Goran Rađenović wrote:
>> Add initial device tree support for the Ultratronik Ultra-MACH SBC
>> based on the NXP i.MX8M Plus SoC with 2GB LPDDR4.
>>
>> The board features:
>> - 1 x USB 2.0 Host
>> - 1 x USB 2.0 via USB-C
>> - Debug UART + 1 x UART + 1 x USART
>> - SD card and eMMC support
>> - 2 x Ethernet (RJ45)
>> - HDMI
>>
>> This initial DTS enables basic board support for booting via
>> SD card or eMMC.
>>
>> Signed-off-by: Goran Rađenović <goran.radni@gmail.com>
>> ---
>>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>   .../dts/freescale/imx8mp-ultra-mach-sbc.dts   | 907 ++++++++++++++++++
>>   2 files changed, 908 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-ultra-mach-sbc.dts
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index 0b473a23d120..e2f2500238fe 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -229,6 +229,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revc-tian-g07017.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-toradex-smarc-dev.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mp-ras314.dtb
>> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-ultra-mach-sbc.dtb
> 
> new file, suggest run https://github.com/lznuaa/dt-format to maintain nice
> node order.
> 
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-var-som-symphony.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw71xx-2x.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw72xx-2x.dtb
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-ultra-mach-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-ultra-mach-sbc.dts
>> new file mode 100644
>> index 000000000000..7a599250e697
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-ultra-mach-sbc.dts
>> @@ -0,0 +1,907 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2023 Ultratronik
> 
> 2025
> 
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/usb/pd.h>
>> +#include "imx8mp.dtsi"
>> +
>> +/ {
>> +	model = "NXP i.MX8MPlus Ultratronik MMI_A53 board";
>> +	compatible = "ultratronik,imx8mp-ultra-mach-sbc", "fsl,imx8mp";
>> +
>> +	aliases {
>> +		ethernet0 = &fec;
>> +		ethernet1 = &eqos;
>> +		rtc0 = &hwrtc;
>> +		rtc1 = &snvs_rtc;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = &uart2;
>> +	};
>> +
>> +	gpio-sbu-mux {
>> +		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_sbu_mux>;
>> +		select-gpios = <&gpio4 20 GPIO_ACTIVE_HIGH>;
>> +		enable-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
>> +		orientation-switch;
>> +
>> +		port {
>> +			usb3_data_ss: endpoint {
>> +				remote-endpoint = <&typec_con_ss>;
>> +			};
>> +		};
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		button-0 {
>> +			gpios = <&gpio4 27 GPIO_ACTIVE_LOW>; /* Wakeup */
>> +			label = "Wakeup";
>> +			linux,code = <KEY_WAKEUP>;
>> +			pinctrl-0 = <&pinctrl_gpio_key_wakeup>;
>> +			pinctrl-names = "default";
>> +			wakeup-source;
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_gpio_leds>;
>> +
>> +		led1 {
>> +			label = "red";
>> +			gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>> +		};
>> +
>> +		led2 {
>> +			label = "green";
>> +			gpios = <&gpio4 25 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>> +		};
>> +
>> +		led3 {
>> +			label = "yellow";
>> +			gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>> +		};
>> +	};
>> +
>> +	reg_usba_vbus: regulator-usba-vbus {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "usb-A-vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +
>> +		pinctrl-names="default";
>> +		pinctrl-0 = <&pinctrl_usb1>;
>> +	};
>> +
>> +	reg_usdhc2_vmmc: regulator-usdhc2 {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
>> +		regulator-name = "VSD_3V3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +	};
>> +};
>> +
>> +&A53_0 {
>> +	cpu-supply = <&buck2>;
>> +};
>> +
>> +&A53_1 {
>> +	cpu-supply = <&buck2>;
>> +};
>> +
>> +&A53_2 {
>> +	cpu-supply = <&buck2>;
>> +};
>> +
>> +&A53_3 {
>> +	cpu-supply = <&buck2>;
>> +};
>> +
>> +&ecspi1 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
>> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +
>> +	slb9670: tpm@0 {
>> +		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
>> +		reg = <0>;
>> +		spi-max-frequency = <32000000>;
>> +		status = "okay";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_slb9670>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +};
>> +
>> +&ecspi2 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi2 &pinctrl_ecspi2_cs>;
>> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>,
>> +				<&gpio1 8 GPIO_ACTIVE_LOW>,
>> +				<&gpio1 9 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +
>> +	nfc: st95hf@1 {
> 
> use common node: maybe nfc-transceiver
> 
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_nfc>;
>> +		reg = <1>;
>> +		compatible = "st,st95hf";
>> +		spi-max-frequency = <100000>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>> +		enable-gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
>> +		status = "okay";
>> +	};
>> +};
>> +
>> +&eqos {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_eqos>;
>> +	phy-mode = "rgmii-id";
>> +	phy-handle = <&ethphy0>;
>> +	status = "okay";
>> +
>> +	mdio {
>> +		compatible = "snps,dwmac-mdio";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ethphy0: ethernet-phy@1 {
>> +			compatible = "ethernet-phy-ieee802.3-c22";
>> +			reg = <0x1>;
>> +			interrupt-parent = <&gpio4>;
>> +			interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
>> +		};
>> +	};
>> +};
>> +
>> +&fec {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_fec>;
>> +	phy-mode = "rgmii-id";
>> +	phy-handle = <&ethphy1>;
>> +	fsl,magic-packet;
>> +	status = "okay";
>> +
>> +	mdio {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ethphy1: ethernet-phy@2 {
>> +			compatible = "ethernet-phy-ieee802.3-c22";
>> +			reg = <0x2>;
>> +			interrupt-parent = <&gpio4>;
>> +			interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
>> +		};
>> +	};
>> +};
>> +
>> +&flexcan1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_flexcan1>;
>> +	status = "okay";
>> +};
>> +
>> +&gpio1 {
>> +	gpio-line-names =
>> +		"#TPM_IRQ", "GPIO1", "", "#PMIC_INT",
>> +		"SD2_VSEL", "#TOUCH_IRQ", "#NFC_INT_I", "#NFC_INT",
>> +		"#SPI2_CS2", "#SPI2_CS3", "#RTS4", "",
>> +		"USB_PWR", "GPIO2", "GPIO3", "";
>> +};
>> +
>> +&gpio2 {
>> +	gpio-line-names =
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "#SD2_CD", "", "", "",
>> +		"", "", "", "", "#USB-C_EN", "", "", "",
>> +		"", "", "", "", "", "", "", "";
>> +};
>> +
>> +&gpio3 {
>> +	gpio-line-names =
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "DISP_POW", "GPIO4",
>> +		"#", "", "", "", "", "", "", "";
>> +};
>> +
>> +&gpio4 {
>> +	gpio-line-names =
>> +		"BKL_POW", "#ETH1_INT", "#TPM_RES", "#PCAP_RES",
>> +		"", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "#ETH0_INT", "#USB-C_ALERT",
>> +		"#USB-C_SEL", "", "", "",
>> +		"LED_RED", "LED_GREEN", "LED_YELLOW", "#WAKEUP",
>> +		"", "", "", "";
>> +};
>> +
>> +&gpio5 {
>> +	gpio-line-names =
>> +		"", "", "", "", "", "", "", "",
>> +		"", "#SPI1_CS", "", "", "", "#SPI2_CS1", "", "",
>> +		"", "", "", "", "ENA_KAM", "ENA_LED", "", "",
>> +		"", "", "", "", "", "", "", "";
>> +};
>> +
>> +&hdmi_pvi {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi_tx {
>> +	ddc-i2c-bus = <&i2c5>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_hdmi>;
>> +	status = "okay";
>> +};
>> +
>> +&hdmi_tx_phy {
>> +	status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&pinctrl_i2c1>;
>> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
>> +	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +	status = "okay";
>> +
>> +	pmic: pca9450@25 {
> 
> pmic@25
> 
>> +		reg = <0x25>;
>> +		compatible = "nxp,pca9450c";
>> +		/* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
>> +		pinctrl-0 = <&pinctrl_pmic>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <3 GPIO_ACTIVE_LOW>;
>> +
>> +		/*
>> +		 * i.MX 8M Plus Data Sheet for Consumer Products
>> +		 * 3.1.4 Operating ranges
>> +		 * MIMX8ML8DVNLZAB
>> +		 */
>> +		regulators {
>> +			buck1: BUCK1 {	/* VDD_SOC (dual-phase with BUCK3) */
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <1050000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-ramp-delay = <3125>;
>> +			};
>> +
>> +			buck2: BUCK2 {	/* VDD_ARM */
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <1000000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-ramp-delay = <3125>;
>> +				nxp,dvs-run-voltage = <950000>;
>> +				nxp,dvs-standby-voltage = <850000>;
>> +			};
>> +
>> +			buck4: BUCK4 {	/* +3V3 */
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +			};
>> +
>> +			buck5: BUCK5 {	/* +1V8 */
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +			};
>> +
>> +			buck6: BUCK6 {	/* DRAM_1V1 */
>> +				regulator-min-microvolt = <1100000>;
>> +				regulator-max-microvolt = <1100000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +			};
>> +
>> +			ldo1: LDO1 {	/* NVCC_SNVS_1V8 */
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +			};
>> +
>> +			ldo3: LDO3 {	/* VDDA_1P8 */
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +			};
>> +
>> +			ldo4: LDO4 {	/* ENET_2V5 */
>> +				regulator-min-microvolt = <2500000>;
>> +				regulator-max-microvolt = <2500000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +			};
>> +
>> +			ldo5: LDO5 {	/* NVCC_SD2 */
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +			};
>> +		};
>> +	};
>> +
>> +	atecc508a@35 {
> 
> crypto@35
> 
>> +		compatible = "atmel,atecc508a";
>> +		reg = <0x35>;
>> +	};
>> +
>> +	eeprom@50 {
>> +		compatible = "atmel,24c16";
>> +		reg = <0x50>;
>> +		pagesize = <16>;
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&pinctrl_i2c2>;
>> +	pinctrl-1 = <&pinctrl_i2c2_gpio>;
>> +	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +	status = "okay";
>> +
>> +	hwrtc: rtc@32 {
>> +		compatible = "epson,rx8900";
>> +		reg = <0x32>;
>> +		epson,vdet-disable;
>> +		trickle-diode-disable;
>> +	};
>> +
>> +	ptn5110: ptn5110@52 {
> 
> tcpc@52
> 
>> +		compatible = "nxp,ptn5110", "tcpci";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_ptn5110>;
>> +		reg = <0x52>;
>> +		interrupt-parent = <&gpio4>;
>> +		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +		usb_con: connector {
>> +			compatible = "usb-c-connector";
>> +			label = "USB-C";
>> +			power-role = "dual";
>> +			data-role = "dual";
>> +			try-power-role = "sink";
>> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
>> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
>> +				     PDO_VAR(5000, 5000, 3000)>;
>> +			op-sink-microwatt = <15000000>;
>> +			self-powered;
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
> 
> extra empty line here
>> +				port@0 {
>> +					reg = <0>;
>> +					typec_dr_sw: endpoint {
>> +						remote-endpoint = <&usb3_drd_sw>;
>> +					};
>> +				};
> 
> extra empty line here
> 
> Frank
> 
>> +				port@1 {
>> +					reg = <1>;
>> +					typec_con_ss: endpoint {
>> +						remote-endpoint = <&usb3_data_ss>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&i2c3 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&pinctrl_i2c3>;
>> +	pinctrl-1 = <&pinctrl_i2c3_gpio>;
>> +	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c5 {	/* HDMI EDID bus */
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&pinctrl_i2c5>;
>> +	pinctrl-1 = <&pinctrl_i2c5_gpio>;
>> +	scl-gpios = <&gpio3 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +	sda-gpios = <&gpio3 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +	status = "okay";
>> +};
>> +
>> +&lcdif3 {
>> +	status = "okay";
>> +};
>> +
>> +&pwm1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm1>;
>> +	status = "okay";
>> +};
>> +
>> +&pwm2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm2>;
>> +	status = "okay";
>> +};
>> +
>> +&snvs_pwrkey {
>> +	status = "okay";
>> +};
>> +
>> +&uart2 {
>> +	/* system console */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart2>;
>> +	status = "okay";
>> +};
>> +
>> +&uart3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart3>;
>> +	status = "okay";
>> +};
>> +
>> +&uart4 {
>> +	/* expansion port serial connection */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart4>;
>> +	status = "okay";
>> +};
>> +
>> +&usb3_phy0 {
>> +	status = "okay";
>> +};
>> +
>> +&usb3_0 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_dwc3_0 {
>> +	dr_mode = "otg";
>> +	hnp-disable;
>> +	srp-disable;
>> +	adp-disable;
>> +	usb-role-switch;
>> +	status = "okay";
>> +
>> +	port {
>> +		usb3_drd_sw: endpoint {
>> +			remote-endpoint = <&typec_dr_sw>;
>> +		};
>> +	};
>> +};
>> +
>> +&usb3_phy1 {
>> +	vbus-supply = <&reg_usba_vbus>;
>> +	status = "okay";
>> +};
>> +
>> +&usb3_1 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_dwc3_1 {
>> +	dr_mode = "host";
>> +	status = "okay";
>> +	snps,hsphy_interface = "utmi";
>> +};
>> +
>> +&usdhc2 {
>> +	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
>> +	assigned-clock-rates = <400000000>;
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
>> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
>> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
>> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
>> +	bus-width = <4>;
>> +	vmmc-supply = <&reg_usdhc2_vmmc>;
>> +	vqmmc-supply = <&ldo5>;
>> +	status = "okay";
>> +};
>> +
>> +&usdhc3 {
>> +	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
>> +	assigned-clock-rates = <400000000>;
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc3>;
>> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
>> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
>> +	vmmc-supply = <&buck4>;
>> +	vqmmc-supply = <&buck5>;
>> +	bus-width = <8>;
>> +	no-sd;
>> +	no-sdio;
>> +	non-removable;
>> +	status = "okay";
>> +};
>> +
>> +&wdog1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_wdog>;
>> +	fsl,ext-reset-output;
>> +	status = "okay";
>> +};
>> +
>> +&iomuxc {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_hog>;
>> +
>> +	pinctrl_ecspi1_cs: ecspi1-cs-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09		0x40	/* #SPI1_CS */
>> +		>;
>> +	};
>> +
>> +	pinctrl_ecspi1: ecspi1-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK		0x82
>> +			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI		0x82
>> +			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO		0x82
>> +		>;
>> +	};
>> +
>> +	pinctrl_ecspi2_cs: ecspi2-cs-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13		0x40	/* #SPI2_CS */
>> +			MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08		0x40	/* #SPI2_CS2 */
>> +			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09		0x40	/* #SPI2_CS3 */
>> +		>;
>> +	};
>> +
>> +	pinctrl_ecspi2: ecspi2-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x82
>> +			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x82
>> +			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x82
>> +		>;
>> +	};
>> +
>> +	pinctrl_eqos: eqos-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x0
>> +			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x0
>> +			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x90
>> +			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x90
>> +			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x90
>> +			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x90
>> +			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
>> +			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x90
>> +			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x16
>> +			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x16
>> +			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x16
>> +			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x16
>> +			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x16
>> +			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
>> +			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18		0x10	/* #ETH0_INT */
>> +		>;
>> +	};
>> +
>> +	pinctrl_fec: fec-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC               0x0
>> +			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO              0x0
>> +			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0         0x90
>> +			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1         0x90
>> +			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2         0x90
>> +			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3         0x90
>> +			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC          0x90
>> +			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL      0x90
>> +			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0         0x16
>> +			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1         0x16
>> +			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2         0x16
>> +			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3         0x16
>> +			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL      0x16
>> +			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC         0x16
>> +			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01               0x10	/* #ETH1_INT */
>> +		>;
>> +	};
>> +
>> +	pinctrl_flexcan1: flexcan1-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX			0x154
>> +			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX			0x154
>> +		>;
>> +	};
>> +
>> +	pinctrl_gpio_key_wakeup: gpio-key-wakeup-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27		0x40	/* #WAKEUP */
>> +		>;
>> +	};
>> +
>> +	pinctrl_gpio_leds: gpio-leds-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24		0x40	/* LED_RED */
>> +			MX8MP_IOMUXC_SAI2_TXC__GPIO4_IO25		0x40	/* LED_GREEN */
>> +			MX8MP_IOMUXC_SAI2_TXD0__GPIO4_IO26		0x40	/* LED_YELLOW */
>> +		>;
>> +	};
>> +
>> +	pinctrl_hdmi: hdmi-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x154
>> +			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x154
>> +		>;
>> +	};
>> +
>> +	pinctrl_hog: hog-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01	0x40	/* GPIO1 */
>> +			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13	0x40	/* GPIO2 */
>> +			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x40	/* GPIO3 */
>> +			MX8MP_IOMUXC_SAI5_RXD2__GPIO3_IO23	0x40	/* GPIO4 */
>> +			MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20	0x40	/* ENA_KAM */
>> +			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21	0x40	/* ENA_LED */
>> +			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03	0x40	/* #PCAP_RES */
>> +			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10	0x40	/* #RTS4 */
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c1: i2c1-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL			0x400001c0
>> +			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA			0x400001c0
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c1_gpio: i2c1-gpio-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14		0xc0
>> +			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15		0xc0
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c2: i2c2-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL			0x400001c0
>> +			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA			0x400001c0
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c2_gpio: i2c2-gpio-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16		0xc0
>> +			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17		0xc0
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c3: i2c3-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL			0x400001c2
>> +			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA			0x400001c2
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c3_gpio: i2c3-gpio-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18		0xc2
>> +			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19		0xc2
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c5: i2c5-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_HDMI_DDC_SCL__I2C5_SCL		0x400000c4
>> +			MX8MP_IOMUXC_HDMI_DDC_SDA__I2C5_SDA		0x400000c4
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c5_gpio: i2c5-gpio-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_HDMI_DDC_SCL__GPIO3_IO26		0xc4
>> +			MX8MP_IOMUXC_HDMI_DDC_SDA__GPIO3_IO27		0xc4
>> +		>;
>> +	};
>> +
>> +	pinctrl_nfc: nfc-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x40	/* NFC_INT_I */
>> +			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x40	/* NFC_INT */
>> +		>;
>> +	};
>> +
>> +	pinctrl_pmic: pmic-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x40	/* #PMIC_INT */
>> +		>;
>> +	};
>> +
>> +	pinctrl_ptn5110: ptn5110-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19		0x1c4	/* #USB-C_ALERT */
>> +		>;
>> +	};
>> +
>> +	pinctrl_pwm1: pwm1-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SPDIF_EXT_CLK__PWM1_OUT		0x116
>> +		>;
>> +	};
>> +
>> +	pinctrl_pwm2: pwm2-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SAI5_RXD0__PWM2_OUT		0x116	/* EXT_PWM */
>> +		>;
>> +	};
>> +
>> +	pinctrl_reg_usdhc2_vmmc: reg-usdhc2-vmmc-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
>> +		>;
>> +	};
>> +
>> +	pinctrl_sbu_mux: sbu-mux-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20		0x16	/* #USB-C_SEL */
>> +			MX8MP_IOMUXC_SD2_WP__GPIO2_IO20			0x16	/* #USB-C_EN */
>> +		>;
>> +	};
>> +
>> +	pinctrl_slb9670: slb9670-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_GPIO1_IO00__GPIO1_IO00		0x40	/* #TPM_IRQ */
>> +			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x40	/* #TPM_RES */
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart2: uart2-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX		0x40
>> +			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX		0x40
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart3: uart3-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX		0x40
>> +			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX		0x40
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart4: uart4-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX		0x40
>> +			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX		0x40
>> +		>;
>> +	};
>> +
>> +	pinctrl_usb1: usb1-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x40	/* USB_PWR */
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2: usdhc2-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190
>> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0
>> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0
>> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0
>> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0
>> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0
>> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0xc0	/* SD2_VSEL */
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194
>> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4
>> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4
>> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4
>> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4
>> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4
>> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0xc0	/* SD2_VSEL */
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196
>> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6
>> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6
>> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6
>> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6
>> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6
>> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0xc0	/* SD2_VSEL */
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_gpio: usdhc2-gpio-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12		0x1c4
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc3: usdhc3-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x190
>> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d0
>> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d0
>> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d0
>> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d0
>> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d0
>> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d0
>> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d0
>> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d0
>> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d0
>> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x190
>> +			MX8MP_IOMUXC_NAND_READY_B__USDHC3_RESET_B	0x40	/* #SD3_RESET */
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194
>> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4
>> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d4
>> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d4
>> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d4
>> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d4
>> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d4
>> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d4
>> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d4
>> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d4
>> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x194
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x192
>> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d2
>> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d2
>> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d2
>> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d2
>> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d2
>> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d2
>> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d2
>> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d2
>> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d2
>> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x192
>> +		>;
>> +	};
>> +
>> +	pinctrl_wdog: wdog-grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0xc6	/* #WDOG */
>> +		>;
>> +	};
>> +};
>> --
>> 2.43.0
>>



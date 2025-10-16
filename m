Return-Path: <linux-kernel+bounces-856177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B78A6BE351D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CD664E5AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFA032D440;
	Thu, 16 Oct 2025 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdkkkW/S"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE132D423
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617164; cv=none; b=PRiCojq8DrgRVxJDdxjkaSzC6krc6SdWSgbPLACSrN6G26Cz9+fv6jn6NlkUrPjZnnFkYNj6Q4eAXGzYL0TfvDAFY8G0uMxCH8SPbt7mKKN5QmJW+f/BomVxPlw+Kffhabzy+0tbZZP5UecyDsphKWZXFugKIkyoghxsRuspsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617164; c=relaxed/simple;
	bh=GGNMI3GPEu1sWY4diCaBz6F3wXsQrCZkTmTYg4I9RvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVaLqRt4JL3pkv7NqO1oLpQgMkXzeUMWbbjZJwOEaUG2cd+bAMXpJygZz/WNs4b3zoRQ2GGCMSSNgk2RY2AZbgK88rQxz/ngagDVDVqEGV0R77pRuqk20jiAS2TpJkI0q/b9QsorR1A6ZTZqgIR76+mBAhA6z1Xb6rMn7C8V8Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdkkkW/S; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33b9df47d7dso991588a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760617161; x=1761221961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+bcf3umDoGYoksKlEOgW5aYfSBbLhP5hxsQ9JuZl78=;
        b=ZdkkkW/S71e6XLS4xC7ajj/CygkJCgfZG9ExdqdpeYaHFtL68jwEUJPHbQnA1XsZmz
         Jj/vv4r6rDTid4WzMQ4wNA0obq+1xG8CP8OwkOcPfESW+CA5gWyXfudHQfgzB0RO+DKm
         UgciWwrFb7pHWLt2l8Xn8Bs21Ui/APdsLZYphPTenFuIH4Qk+CcTHomaMPAbNGzQkAUl
         dxZYRi9nqJGWPeAMW4fK7o8HUQSPJS8lqaca4HbqSaG2ccB3H+8x/PWdzV1U82/xuEjQ
         6e/pk5OLyJzS/9B46r6lkcXf2g2jT17ZZ5bsD8Sko4h8eDQGUTF8PgvYOiw7g5GYE/od
         0V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760617161; x=1761221961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+bcf3umDoGYoksKlEOgW5aYfSBbLhP5hxsQ9JuZl78=;
        b=K87g1KDReQAlpTWSfoKWS3pBHm1NYd5Q84YoSImUcTqmpLdceD8L3lMsDqhFgmMV7W
         aVGJVLnBgBXV34dwNllVzIjvwspSNhF8OMGsLE0qaWCq/zKikmyzIvZ8L5LWIttZC+kR
         LXyXY7v2/STdsZNFD0r0U5gsud9pOrNYIxViiJ7kAY6PYU3DyTLjCITXFAGFj1r9dmk3
         92UEbTwFj+/7M2kZCT5nhjfz7q+R5Ox3AX2AAI4dvErTyC/FWjc8BwMTgKgZR+ptYUmg
         cs9M5pg9GNCLVPasBpPr2Xg23kgIyLVTCoYyyBJuLnjhHmC9NuF0R4/OxGGraiyTiEab
         ZIBg==
X-Forwarded-Encrypted: i=1; AJvYcCUPo/WemdQXMv8axxhcsWL3LRsk8VxtJShipHyiLXQmrVuJfmJiJb2nnN3/RieOw8nuMVUPFiMZTwa++t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykMWyX/cB/aRPD2igeHeeyNbnTOqSxc5W4fCDbtQHboFAGSS+p
	doZ9wCztodUOAxB78PekKbPobEC+N7lyu4ODOXqfHzES/0CeRZ7+pRaX
X-Gm-Gg: ASbGncuQUR1EnDE1dv4oyLERZ03SFaCsH1+23TdWJZ9ca3aco4DAtjPSvyjbDFxO1Tl
	zSmxlIoGfkc8gWWZGpi82oBBZAEfx/2w1Q72xB9z5DOzRPJiTgahJEqN7QLs4SAC4UwxOGamJNm
	GU/dhiM1Tt6WrwyKALK7oaSJ+hkzbh/oY8UOy1U4pqIEQ4ycT3vkKVF8cxA6PGhVGv5zp7joHVQ
	/b8BUUf7a7LnGCvacZWuUUzZ+neCspGPFLlJvsfSCeduy1dHYwks/Q1of9imhjzWILpBRT+y9/w
	HkZKgEonN88S3lTrOcy4Rn0MJcVbpnnGyH0vrMRcv9TUvYA5CW9v7YMrEuo6bNO1FI3R7rKwLgt
	MFU+UuHBo/1kzAcPhOBwrzvG+wFMl244VgbWPuSgoeKVtNhIlih0eo1G5T5Wa6pfV01ZCJ7RajU
	VjgJetBxQ6Bxhr
X-Google-Smtp-Source: AGHT+IGOqM/sSB8bc5tsx6A3B+0GYh0+swj8plpefRfH5q9tuhrr2ix8jkUCrZifLK7AgaZGx846KQ==
X-Received: by 2002:a17:90b:3d87:b0:32e:d011:ea1c with SMTP id 98e67ed59e1d1-33b51112272mr46341085a91.15.1760617160783;
        Thu, 16 Oct 2025 05:19:20 -0700 (PDT)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22bbe7a0sm2701372a12.38.2025.10.16.05.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 05:19:20 -0700 (PDT)
Message-ID: <68db625e-d0c4-4035-a368-47d6a51467d0@gmail.com>
Date: Thu, 16 Oct 2025 17:49:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add support for QCS615 talos evk
 board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251014120223.1914790-1-tessolveupstream@gmail.com>
 <20251014120223.1914790-3-tessolveupstream@gmail.com>
 <wbg34hghu4gl277ppitctxgs5swlchjyjk425cjf4sbojlymlj@ca62bvncptny>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <wbg34hghu4gl277ppitctxgs5swlchjyjk425cjf4sbojlymlj@ca62bvncptny>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/10/25 03:45, Dmitry Baryshkov wrote:
> On Tue, Oct 14, 2025 at 05:32:23PM +0530, Sudarshan Shetty wrote:
>> Introduce the device tree support for the QCS615-based talos-evk
>> platform, which follows the SMARC (Smart Mobility ARChitecture)
>> standard. The platform is composed of two main hardware
>> components: the talos-evk-som and the talos-evk carrier board.
>>
>> The talos-evk-som is a compact System on Module that integrates the
>> QCS615 SoC, PMIC, and essential GPIO connectivity. It follows the
>> SMARC standard, which defines a modular form factor allowing the SoM
>> to be paired with different carrier boards for varied applications.
>>
>> The talos-evk is one such carrier board, designed for evaluation
>> and development purposes. It provides additional peripherals
>> such as UART, USB, and other interfaces to enable rapid
>> prototyping and hardware bring-up.
>>
>> This initial device tree provides the basic configuration needed
>> to boot the platform to a UART shell. Further patches will extend
>> support for additional peripherals and subsystems.
>>
>> The initial device tree includes basic support for:
>>
>> - CPU and memory
>>
>> - UART
>>
>> - GPIOs
>>
>> - Regulators
>>
>> - PMIC
>>
>> - Early console
>>
>> - AT24MAC602 EEPROM
>>
>> - MCP2515 SPI to CAN
>>
>> QCS615 talos-evk uses a Quectel AF68E WiFi/BT module (PCIe for
>> WiFi and UART for Bluetooth), which is different from the RIDE
>> platform. Plan to enable these in a follow-up patch series.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>  arch/arm64/boot/dts/qcom/talos-evk-som.dtsi | 435 ++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/talos-evk.dts      |  42 ++
>>  3 files changed, 478 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk.dts
>>
>> +
>> +	extcon_usb_1: extcon-usb-1 {
>> +		compatible = "linux,extcon-usb-gpio";
>> +		vbus-gpio = <&pm8150_gpios 6 GPIO_ACTIVE_HIGH>;
>> +		id-gpio = <&pm8150_gpios 7 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-0 = <&usb1_vbus_det_default &usb1_id_det_default>;
>> +		pinctrl-names = "default";
>> +	};
> 
> Given that we are trying to switch to flattened DWC3 nodes and we are
> not going to support extcon in such a configuration (commit aeb0169217eb
> ("usb: dwc3: qcom: Remove extcon functionality from glue layer")), I
> don't think this is a way to go. Please add a proper
> gpio-usb-b-connector node.
> 
> Also... This is not correct if SW1 is switched to the USB-Host. The ID
> is still connected to the micro-USB port and so it might generate some
> unpredicted interference. Unfortunately, DT isn't well-fitting for
> describing board options and SW1 is definitely an SoM option. Depending
> on its position the EVK should either use this gpio-usb-b-connector or
> an onboard USB hub (which ideally should also be described in DT). So,
> it feels like you need two different DT files, one for each SW1
> position.

Thanks for the review.
The USB1 port on this board supports both host and device roles,
selectable using the SW1 switch on the SoM.

The board does not have VBUS or ID detect GPIOs — role selection
is purely manual via the hardware switch

The VBUS 5 V is sourced from the fixed 5 V rail (V5P0_OUT), which is
always on and not controlled by GPIO or regulator.

As suggested,
it feels like need two different DT files, one for each SW1 position.
talos-evk-som.dtsi - device-only mode
talos-evk-usbhost.dts - host-only mode

will it be okay to proceed with above scenario?
> 
>> +
>> +&pm8150_gpios {
>> +	usb2_en: usb2-en-state {
>> +		pins = "gpio10";
>> +		function = "normal";
>> +		output-enable;
>> +		power-source = <0>;
>> +	};
>> +
>> +	usb1_vbus_det_default: usb1-vbus-det-default-state {
>> +		pins = "gpio6";
>> +		function = "normal";
>> +		output-enable;
>> +		power-source = <0>;
>> +	};
>> +
>> +	usb1_id_det_default: usb1-id-det-default-state {
>> +		pins = "gpio7";
>> +		function = "normal";
>> +		output-enable;
>> +		power-source = <0>;
>> +	};
> 
> Do you want to also describe gpio8 here?
> 
>> +};
>> +
> 
> 
> [...]
> 
>> +&usb_1_hsphy {
>> +	vdd-supply = <&vreg_l5a>;
>> +	vdda-pll-supply = <&vreg_l12a>;
>> +	vdda-phy-dpdm-supply = <&vreg_l13a>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_qmpphy {
>> +	vdda-phy-supply = <&vreg_l5a>;
>> +	vdda-pll-supply = <&vreg_l12a>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1 {
>> +	status = "okay";
>> +};
>> +
>> +/*
>> + * USB1 port supports both host and device modes.
>> + * By default, it operates in device mode.
>> + * To enable host mode, set switch SW1 to 'ON' position on the SoM.
> 
> Is it device mode or is it an OTG mode? I don't have carrier board
> schematics, so I don't see if it is possible to enable VBUS on the
> micro-USB or not.

The board default in device mode.
The USB1 port role is determined entirely by the hardware
switch SW1 on the SoM:

There are no ID or VBUS detect pins, so dynamic OTG switching is
not possible. dr_mode in the DTS is therefore set explicitly to 
"peripheral" for device mode or "host" for host mode.
>
>> + */
>> +
>> +&usb_1_dwc3 {
>> +	dr_mode = "otg";
> 
> JFYI: it's a default and can be omitted. Only host / peripheral needs to
> be specified explicitly.

Sure, will update in v4 patch accordingly,
> 
>> +	extcon = <&extcon_usb_1>;
>> +};
>> +
> 



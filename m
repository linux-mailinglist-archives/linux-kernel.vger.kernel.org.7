Return-Path: <linux-kernel+bounces-732720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C049AB06B33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1197156391F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24EC265621;
	Wed, 16 Jul 2025 01:36:31 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8382C18A;
	Wed, 16 Jul 2025 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629791; cv=none; b=hf8YJlMYYtXv0xEUI2SsGATU9oXZgo1kZHsTcJzI1cqWB8Wg/t7j/NfP9j/JsobikGMZMzAHtd7ca7F9BkkW9Pbqre3amlkBM1UiEIfscbGuTIrjuTyf+RJG/BiHfMVe8SGdIanjaxTvTDF8PyEpJYtnyRI9DQbCa2rjZ65NWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629791; c=relaxed/simple;
	bh=CeL1Z2vZkHAyOW7t5MITp2UXBQD/Klw2OZ/1iJ/qUYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LG7mfggU6mWUkP0EiK+yNjeR7ykC2zm5Fdf16chloSTso68qjZ7olHnSxN7DmmFjTq6h9Jg0p3oRqRWF2lye7ANC8d5EPk8i2OEzPWfVOyTo+/otPH5qT6EAI4pLPNJJl3/7ymsCkF/wIJoe3Pm8R/qqGaVZivcxCl1vmrDol9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.71])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 9B71AB4D186C;
	Wed, 16 Jul 2025 03:30:59 +0200 (CEST)
Message-ID: <e2ec3809-a538-4475-ac3a-db289271fe7a@freeshell.de>
Date: Tue, 15 Jul 2025 18:30:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: dts: starfive: add DT for Orange Pi RV
To: Icenowy Zheng <uwu@icenowy.me>, Yao Zi <ziyao@disroot.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Jisheng Zhang <jszhang@kernel.org>,
 Michael Zhu <michael.zhu@starfivetech.com>,
 Drew Fustini <drew@beagleboard.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250409091801.855083-1-uwu@icenowy.me>
 <20250409091801.855083-2-uwu@icenowy.me> <Z_f30vAuATR1DCWk@pie>
 <8fbd6ffdd053760b6d0980173c7f8af6c09963ba.camel@icenowy.me>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <8fbd6ffdd053760b6d0980173c7f8af6c09963ba.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/10/25 18:29, Icenowy Zheng wrote:
> 在 2025-04-10星期四的 16:54 +0000，Yao Zi写道：
>> On Wed, Apr 09, 2025 at 05:18:01PM +0800, Icenowy Zheng wrote:
>>> Orange Pi RV is a newly released SBC with JH7110 SoC, single GbE
>>> port
>>> (connected to JH7110 GMAC0 via a YT8531 PHY), 4 USB ports (via a
>>> VL805
>>> PCIe USB controller connected to JH7110 PCIE0), a M.2 M-key slot
>>> (connected to JH7110 PCIE1), a HDMI video output, a 3.5mm audio
>>> output
>>> and a microSD slot.
>>>
>>> Onboard peripherals contain a SPI NOR (which contains the U-Boot
>>> firmware) and an Ampak AP6256 SDIO Wi-Fi module.
>>>
>>> As the schematics isn't available yet, the SDIO Wi-Fi is left
>>> disabled
>>> yet.
>>>
>>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>>> ---
>>>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
>>>  .../boot/dts/starfive/jh7110-orangepi-rv.dts  | 73
>>> +++++++++++++++++++
>>>  2 files changed, 74 insertions(+)
>>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-orangepi-
>>> rv.dts
>>>
>>> diff --git a/arch/riscv/boot/dts/starfive/Makefile
>>> b/arch/riscv/boot/dts/starfive/Makefile
>>> index b3bb12f78e7d5..24f1a44828350 100644
>>> --- a/arch/riscv/boot/dts/starfive/Makefile
>>> +++ b/arch/riscv/boot/dts/starfive/Makefile
>>> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-
>>> visionfive-v1.dtb
>>>  
>>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
>>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
>>> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-orangepi-rv.dtb
>>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
>>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-
>>> v1.2a.dtb
>>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-
>>> v1.3b.dtb
>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
>>> b/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
>>> new file mode 100644
>>> index 0000000000000..bde01f117e0b2
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
>>> @@ -0,0 +1,73 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>> +/*
>>> + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "jh7110-common.dtsi"
>>> +#include <dt-bindings/leds/common.h>
>>> +
>>> +/ {
>>> +       model = "Xunlong Orange Pi RV";
>>> +       compatible = "xunlong,orangepi-rv", "starfive,jh7110";
>>> +
>>> +       leds {
>>> +               compatible = "gpio-leds";
>>> +
>>> +               led-ack {
>>> +                       gpios = <&aongpio 3 GPIO_ACTIVE_HIGH>;
>>> +                       color = <LED_COLOR_ID_GREEN>;
>>> +                       function = LED_FUNCTION_HEARTBEAT;
>>> +                       linux,default-trigger = "heartbeat";
>>> +                       label = "ack";
>>
>> Should we sort the properties in alphabet order? i.e. color,
>> function,
>> gpios, label then linux,default-trigger. See dts-coding-style.rst,
> 
> Well in case of GPIO LED, I think gpios is something like reg? Although
> this is only my personal feel, and label really needs to be reordered
> then.
> 

Status led description here does instead belong in jh7110-common.dtsi
since all variant boards are using the same RGPIO3 (fourth GPIO on PMU
domain).

>>
>>> The following order of properties in device nodes is preferred:
>>>
>>> 1. "compatible"
>>> 2. "reg"
>>> 3. "ranges"
>>> 4. Standard/common properties (defined by common bindings, e.g.
>>> without
>>> vendor-prefixes)
>>> 5. Vendor-specific properties
>>> 6. "status" (if applicable)
>>> 7. Child nodes, where each node is preceded with a blank line
>>
>>> +               };
>>> +       };
>>> +};
>>> +
>>> +&gmac0 {
>>> +       starfive,tx-use-rgmii-clk;
>>> +       assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>>> +       assigned-clock-parents = <&aoncrg
>>> JH7110_AONCLK_GMAC0_RMII_RTX>;
>>> +       status = "okay";
>>
>> Vendor property starfive,tx-use-rgmii-clk should go after the common
>> ones.
> 
> Okay, I will fix this (and the one below) in next revision.
> 
> Thanks,
> Icenowy

Well then does the documentation follow recommended sort ordering?

https://www.kernel.org/doc/Documentation/devicetree/bindings/leds/common.yaml

Looks to me like it is not clear what is going on there with sort
ordering. The recently accepted dts in-tree are a mix of "who cares?",
alphabet sort, and preferentially but arbitrarily placing some things
above others. The documentation is even different than all that.

Maybe if the documentation should be followed we should follow it, else
fix the documentation firstly.

> 
>>> +};
>>> +
>>> +&i2c0 {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&mmc0 {
>>> +       /* TODO: Ampak AP6256 Wi-Fi module attached here */
>>> +       status = "disabled";
>>> +};

Orange Pi RV schematic is published now. Please implement this
description here.

You may also wish to review the StarFive JH7100 devicetree descriptions
(and schematic), and additionally the published Milk-V Mars CM / Mars CM
Lite schematic, for clues about AP6256. The required firmware files'
intellectual property when during the last discussion about
linux-firmware was determined to be Synaptics (labeled as Broadcomm) and
rejected from inclusion due to no clear licensed permission for
distribution. Maybe it is time to revisit this and find someone willing
to do the work of resolving the license ambiguity?

>>> +
>>> +&mmc1 {
>>> +       /delete-property/ cd-gpios;
>>> +       broken-cd;
>>> +};
>>> +
>>> +&pcie0 {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&pcie1 {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&phy0 {
>>> +       motorcomm,tx-clk-adj-enabled;
>>> +       motorcomm,tx-clk-10-inverted;
>>> +       motorcomm,tx-clk-100-inverted;
>>> +       motorcomm,tx-clk-1000-inverted;
>>> +       motorcomm,rx-clk-drv-microamp = <3970>;
>>> +       motorcomm,rx-data-drv-microamp = <2910>;
>>> +       rx-internal-delay-ps = <1500>;
>>> +       tx-internal-delay-ps = <1500>;
>>> +};
>>
>> Ditto, move the vendor properties below the common ones.

Yes and, one of us may review what is already in starfive/ dts to fix
and send a patch for this mess of devicetree sort order. The issue
repeats every time we look for an existing sample to use.

>>
>>> +&pwmdac {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&spi0 {
>>> +       status = "okay";
>>> +};
>>> -- 
>>> 2.49.0
>>>
>>
>> Best regards,
>> Yao Zi
> 

B.R.,  -E Shattow


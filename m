Return-Path: <linux-kernel+bounces-897283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA985C52819
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 686E64EA042
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6133891B;
	Wed, 12 Nov 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="hOyxI7jl"
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15870219A8E;
	Wed, 12 Nov 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954251; cv=none; b=TNRBTEUrIBbxSJXAEBnjiGN97vvsPkBEuufH9J66dpaOAi8hgM1k9y2iNez0WT7MEE5oQS8O/uyDBsjAzzKEwvQJhfgvrXuOr0h1eADk6SHFy9fUAPd4Dv6A9nySxSGYSbJx6zAPKdDsSdc6a/jxqWKx32OaTkBM5uVV8E6AKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954251; c=relaxed/simple;
	bh=9xUGMGeZu1ZGWb6VP2CRZrbITTacc90zTi4obQ2aJX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1NGigmeYEYtjfJ6djPo8JlJN4Ps/qPjqDoj7ckTrWPTPHXvyFopMorZoCvnqhAQXEjRcQPMZZMXV6lZjPc3mOU7DCeSRkYoQHo8giBSefRG45NVDl0tsmARsv2+k8iiEFGLkl9fayeJzsNa5XjWFNu4SEQI6ebyFSiyFukC1ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=hOyxI7jl; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1762954191;
	bh=TMkswUaXO9rYxhVHG5sXgtqYFuB/fttuEyt/nJcPcjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hOyxI7jl7lTghpDXWwS/Dboiuegh57+SVu1wveetuUpriZEazn0CFQXMaYhxjwt7u
	 nCtWyhOIeFnl5cOba4mz18pmSAJKSuMgo20+2v8+Ll6YTYIPpKNA+W9vbTOBY96iAa
	 ZULI3s8MZFpnUxbBL9Yh/tEiyStofrk54xqnOrR76b0+B3TJcDX3xrRozglgdyX0EB
	 6QMi1768iYJC0Mav835jp2tl1IkAVQbcmIRoVtRg5CvVAQYcu1MRsJAdzJBwp8/GkE
	 18wwuUyxhXK5JOFCQGYGqnVE/hSEVH8r4Zvzh0U1i5Envioc2+FlliqDICEt/lHWi3
	 w+NzPxCpVEY9g==
Received: from [192.168.2.54] (unknown [143.105.117.4])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 4C691B220091;
	Wed, 12 Nov 2025 14:29:48 +0100 (CET)
Message-ID: <49471cea-d4e9-46d3-98e5-82548f32437e@freeshell.de>
Date: Wed, 12 Nov 2025 05:29:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
To: Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <c05d8bcc-3024-45cd-8630-b0595682e778@freeshell.de>
 <6d0fb6aa-6d88-4069-a5e5-9e910523888e@canonical.com>
 <4b38ec00-dfc4-481b-8b8d-fa171ce8d12b@freeshell.de>
 <ZQ2PR01MB13079DACC0C7231B34F93C42E6CC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZQ2PR01MB13079DACC0C7231B34F93C42E6CC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/11/25 23:24, Hal Feng wrote:
>> On 07.11.25 20:02, E Shattow wrote:
>> On 11/7/25 03:21, Heinrich Schuchardt wrote:
>>> On 11/7/25 12:11, E Shattow wrote:
>>>>
>>>>
>>>> On 11/7/25 01:55, Hal Feng wrote:
>>>>> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S
>>>>> industrial SoC which can run at -40~85 degrees centigrade and up to
>> 1.25GHz.
>>>>>
>>>>> Board features:
>>>>> - JH7110S SoC
>>>>> - 4/8 GiB LPDDR4 DRAM
>>>>> - AXP15060 PMIC
>>>>> - 40 pin GPIO header
>>>>> - 1x USB 3.0 host port
>>>>> - 3x USB 2.0 host port
>>>>> - 1x M.2 M-Key (size: 2242)
>>>>> - 1x MicroSD slot (optional non-removable 64GiB eMMC)
>>>>> - 1x QSPI Flash
>>>>> - 1x I2C EEPROM
>>>>> - 1x 1Gbps Ethernet port
>>>>> - SDIO-based Wi-Fi & UART-based Bluetooth
>>>>> - 1x HDMI port
>>>>> - 1x 2-lane DSI
>>>>> - 1x 2-lane CSI
>>>>>
>>>>> VisionFive 2 Lite schematics: https://doc-en.rvspace.org/
>>>>> VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
>>>>> VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/
>>>>> VisionFive2Lite/VisionFive2LiteQSG/index.html
>>>>> More documents: https://doc-en.rvspace.org/Doc_Center/
>>>>> visionfive_2_lite.html
>>>>>
>>>>> Changes since v1:
>>>>> - Drop patch 1 because it is applied.
>>>>> - Rename jh7110.dtsi to jh711x.dtsi.
>>>>> - Move the content of jh7110-common.dtsi to the new file
>>>>>    jh711x-common.dtsi and move opp table to jh7110-common.dtsi.
>>>>> patch 4:
>>>>> - Move the uncommon nodes to jh7110-common.dtsi instead of board
>> dts.
>>>>> patch 5:
>>>>> - Add jh7110s-common.dtsi and include it in jh7110s-starfive-
>>>>> visionfive-2-lite.dtsi.
>>>>>
>>>>> Changes since RFC:
>>>>> - Add jh7110s compatible to the generic cpufreq driver.
>>>>> - Fix the dtbs_check error by adding the missing "enable-gpios"
>>>>> property
>>>>>    in jh7110 pcie dt-bindings.
>>>>> - Rebase on the latest mainline.
>>>>> - Add VisionFive 2 Lite eMMC board device tree and add a common
>>>>> board dtsi
>>>>>    for VisionFive 2 Lite variants.
>>>>> - Add usb switch pin configuration (GPIO62).
>>>>> - Improve the commit messages.
>>>>>
>>>>> History:
>>>>> v1: https://lore.kernel.org/all/20251016080054.12484-1-
>>>>> hal.feng@starfivetech.com/
>>>>> RFC: https://lore.kernel.org/all/20250821100930.71404-1-
>>>>> hal.feng@starfivetech.com/
>>>>>
>>>>> Hal Feng (8):
>>>>>    dt-bindings: PCI: starfive,jh7110-pcie: Add enable-gpios property
>>>>>    dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2
>>>>> Lite
>>>>>      board
>>>>>    riscv: dts: starfive: Rename jh7110.dtsi to jh711x.dtsi
>>>>>    riscv: dts: starfive: Split jh7110-common.dtsi and move opp table
>>>>> to
>>>>>      it
>>>>>    riscv: dts: starfive: jh711x-common: Move out some nodes to
>>>>> jh7110
>>>>>      common dtsi
>>>>>    riscv: dts: starfive: Add common board dtsi for JH7110s and
>>>>> VisionFive
>>>>>      2 Lite variants
>>>>>    riscv: dts: starfive: Add VisionFive 2 Lite board device tree
>>>>>    riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device
>>>>> tree
>>>>>
>>>>>   .../bindings/pci/starfive,jh7110-pcie.yaml    |   4 +
>>>>>   .../devicetree/bindings/riscv/starfive.yaml   |   6 +
>>>>>   arch/riscv/boot/dts/starfive/Makefile         |   3 +
>>>>>   .../boot/dts/starfive/jh7110-common.dtsi      | 653
>>>>> +----------------
>>>>>   .../boot/dts/starfive/jh7110s-common.dtsi     |  27 +
>>>>>   ...h7110s-starfive-visionfive-2-lite-emmc.dts |  22 +
>>>>>   .../jh7110s-starfive-visionfive-2-lite.dts    |  20 +
>>>>>   .../jh7110s-starfive-visionfive-2-lite.dtsi   | 126 ++++
>>>>>   .../boot/dts/starfive/jh711x-common.dtsi      | 656
>>>>> ++++++++++++++++++
>>>>>   .../dts/starfive/{jh7110.dtsi => jh711x.dtsi} |  16 -
>>>>>   10 files changed, 879 insertions(+), 654 deletions(-)
>>>>>   create mode 100644
>>>>> arch/riscv/boot/dts/starfive/jh7110s-common.dtsi
>>>>>   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-
>>>>> visionfive-2-lite-emmc.dts
>>>>>   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-
>>>>> visionfive-2-lite.dts
>>>>>   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-
>>>>> visionfive-2-lite.dtsi
>>>>>   create mode 100644 arch/riscv/boot/dts/starfive/jh711x-common.dtsi
>>>>>   rename arch/riscv/boot/dts/starfive/{jh7110.dtsi => jh711x.dtsi}
>>>>> (99%)
>>>>>
>>>>>
>>>>> base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
>>>>
>>>> Small nit that "lite-emmc" is confusing together. In patches to
>>>> U-Boot dev mailing list the EEPROM product id is demonstrated to be with
>> "SL"
>>>> suffix when compared to VisionFive 2 (JH7110) so I suggest avoid
>>>> confusion in upstream and use for VisionFive 2 Lite (JH7110S) these
>>>> compatible names:
>>>>
>>>> starfive,visionfive-2sl-lite
>>>> starfive,visionfive-2sl-emmc
>>>>
>>>> Also filenames:
>>>>
>>>> jh7110s-starfive-visionfive-2sl-lite.dts
>>>> jh7110s-starfive-visionfive-2sl.dtsi
>>>> jh7110s-starfive-visionfive-2sl-emmc.dts
>>>>
>>>> What do you think?
>>>>
>>>
>>> This is a serial number for the Lite board:
>>> VF7110SL-2310-D002E000-xxxxxxxx
>>>
>>> Here E000 encodes that we have no eMMC.
>>>
>>> The S is part of 7110S which we already have in 'jh7110s'. And the L
>>> is already decoded as 'lite' in this patch series. Duplicating this
>>> information as 'sl' as you suggested provides no benefit.
>>
>> The convention in dts file names is CPU model first so that will be redundant
>> or not redundant depending on the name of the product anyway; whether it
>> is redundant or not is not the driver of whether it is confusing to have
>> contradictory terminology in the product name and compatible names and dts
>> filenames.
>>
>>>
>>> Let's just stick with Hal's suggestion.
>>>
>>> Best regards
>>>
>>> Heinrich
>>
>> The "lite" product name in similar products refers to non-populated emmc
>> replaced by sd card, so there is benefit to choose a more concise name that is
>> not confusing.
>>
>> I did consider suggesting:
>>
>> jh7110s-starfive-visionfive-2-lite.dts
>> jh7110s-starfive-visionfive-2.dtsi
>> jh7110s-starfive-visionfive-2-emmc.dts
>>
>> but this is a loss of information and does not help readability. By extension
>> we're not duplicating information to be more descriptive with the product
>> name. Sure I'd go along with:
>>
>> jh7110s-starfive-visionfive-2-lite-card.dts
>> jh7110s-starfive-visionfive-2-lite.dtsi
>> jh7110s-starfive-visionfive-2-lite-emmc.dts
>>
>> But my suggestion remains:
>>
>> jh7110s-starfive-visionfive-2sl-lite.dts
>> jh7110s-starfive-visionfive-2sl.dtsi
>> jh7110s-starfive-visionfive-2sl-emmc.dts
>>
>> for the reason that it's very clearly not the "non-emmc" version of the
>> VisionFive 2. You can't mistake it if done the way I am suggesting.
> 
> VisionFive 2 Lite is not the "non-emmc" version of the VisionFive 2. "Lite" here means the
> light version and smaller size. I think we can't apply the name definition of another product
> to here. VisionFive 2 Lite is the official name of this product and the name we call in our
> official documents.
> 
> Best regards,
> Hal

Okay then LGTM, for the series,

Reviewed-by: E Shattow <e@freeshell.de>


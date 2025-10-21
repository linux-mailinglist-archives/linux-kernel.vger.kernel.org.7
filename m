Return-Path: <linux-kernel+bounces-863843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B214ABF9403
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D796581E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF02BE655;
	Tue, 21 Oct 2025 23:35:17 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D39350A02;
	Tue, 21 Oct 2025 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089717; cv=none; b=anXfKfaeEzdUl5/kxTv2unseIR71YfoiYNwf7jf6h0TUYiu2hrD4qnq9raawXJj8MiH5z4Khk7rTAWMVkUPn4ejjPINbbgNV4xq549K/ZZ0L2GGT3RdWka9XlGe77FnWkmX1c/MlnJ1aSHad9HJ95hzETAHMmKF2y+0cRu7vpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089717; c=relaxed/simple;
	bh=r+m8U0iErE67jQlOhGvNAC61ytioTgA98Z2QAM1yMrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z95cRltjpv5YZJpYz3Kw8gWaOQ2liZ/I9YMS5xf4IKYX3EVC47gTtwkKkf74pzKqJGa5xG+mhsdV2Bbuo1ZEmpQbyFpfqCRGmPixlL7DbHevHiCYVD9VBkjanNOc40gHkV4/tlqROhd2U8eQlwT+ttmwkNrmBo3BvlxMPhm0zTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.240])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id E38E5B220DAA;
	Wed, 22 Oct 2025 01:35:03 +0200 (CEST)
Message-ID: <cbb18fb1-200f-40b4-89a1-c29522fdaae5@freeshell.de>
Date: Tue, 21 Oct 2025 16:35:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] riscv: dts: starfive: add DT for Orange Pi RV
To: Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>,
 Michael Zhu <michael.zhu@starfivetech.com>,
 Drew Fustini <drew@beagleboard.org>, Yao Zi <ziyao@disroot.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250930100318.2131968-1-uwu@icenowy.me>
 <20250930100318.2131968-2-uwu@icenowy.me>
 <579dad6b4ab0c981b8d51383af2db3a9f4394609.camel@icenowy.me>
 <b8db0cdf-163e-416d-94b8-c9e1f10c8011@freeshell.de>
 <2e6ce092996f2717bc274e1c82873c42b2ab18ce.camel@icenowy.me>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <2e6ce092996f2717bc274e1c82873c42b2ab18ce.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/6/25 00:39, Icenowy Zheng wrote:
> 在 2025-10-05星期日的 11:47 -0700，E Shattow写道：
>> Hi Icenowy,
>>
>> On 9/30/25 08:51, Icenowy Zheng wrote:
>>> 在 2025-09-30星期二的 18:03 +0800，Icenowy Zheng写道：
>>>> Orange Pi RV is a newly released SBC with JH7110 SoC, single GbE
>>>> port
>>>> (connected to JH7110 GMAC0 via a YT8531 PHY), 4 USB ports (via a
>>>> VL805
>>>> PCIe USB controller connected to JH7110 PCIE0), a M.2 M-key slot
>>>> (connected to JH7110 PCIE1), a HDMI video output, a 3.5mm audio
>>>> output
>>>> and a microSD slot.
>>>>
>>>> Other Onboard peripherals contain a SPI NOR (which contains the
>>>> U-
>>>> Boot
>>>> firmware), a 24c02 EEPROM storing some StarFive-specific
>>>> information
>>>> (factory programmed and read only by default) and an Ampak AP6256
>>>> SDIO
>>>> Wi-Fi module.
>>>>
>>>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>>>> ---
>>>> Changes in v2:
>>>> - Property order change mentioned in the review of v1.
>>>> - Added Wi-Fi (along with the always on VCC3V3_PCIE regulator,
>>>> which
>>>> is
>>>>   used to power up WIFI_3V3). The OOB IRQ is still not possible
>>>> to
>>>> use
>>>>   because of some incompatibility between StarFive pinctrl driver
>>>> and
>>>>   brcmfmac.
>>>> - Removed the LED because it's in common DTSI.
>>>>
>>>>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
>>>>  .../boot/dts/starfive/jh7110-orangepi-rv.dts  | 87
>>>> +++++++++++++++++++
>>>>  2 files changed, 88 insertions(+)
>>>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-orangepi-
>>>> rv.dts
>>>>
>>>> diff --git a/arch/riscv/boot/dts/starfive/Makefile
>>>> b/arch/riscv/boot/dts/starfive/Makefile
>>>> index b3bb12f78e7d5..24f1a44828350 100644
>>>> --- a/arch/riscv/boot/dts/starfive/Makefile
>>>> +++ b/arch/riscv/boot/dts/starfive/Makefile
>>>> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-
>>>> visionfive-v1.dtb
>>>>  
>>>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
>>>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
>>>> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-orangepi-rv.dtb
>>>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
>>>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-
>>>> v1.2a.dtb
>>>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-
>>>> v1.3b.dtb
>>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
>>>> b/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
>>>> new file mode 100644
>>>> index 0000000000000..5a917b7db6f78
>>>> --- /dev/null
>>>> +++ b/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
>>>> @@ -0,0 +1,87 @@
>>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>>> +/*
>>>> + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +#include "jh7110-common.dtsi"
>>>> +
>>>> +/ {
>>>> +       model = "Xunlong Orange Pi RV";
>>>> +       compatible = "xunlong,orangepi-rv", "starfive,jh7110";
>>>> +
>>>> +       /* This regulator is always on by hardware */
>>>> +       reg_vcc3v3_pcie: regulator-vcc3v3-pcie {
>>>> +               compatible = "regulator-fixed";
>>>> +               regulator-name = "vcc3v3-pcie";
>>>> +               regulator-min-microvolt = <3300000>;
>>>> +               regulator-max-microvolt = <3300000>;
>>>> +               regulator-always-on;
>>>> +       };
>>>> +
>>>> +       wifi_pwrseq: wifi-pwrseq {
>>>> +               compatible = "mmc-pwrseq-simple";
>>>> +               reset-gpios = <&sysgpio 62 GPIO_ACTIVE_LOW>;
>>>> +       };
>>>> +};
>>>> +
>>>> +&gmac0 {
>>>> +       assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>>>> +       assigned-clock-parents = <&aoncrg
>>>> JH7110_AONCLK_GMAC0_RMII_RTX>;
>>>> +       starfive,tx-use-rgmii-clk;
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&mmc0 {
>>>> +       #address-cells = <1>;
>>>> +       #size-cells = <0>;
>>>> +       cap-sd-highspeed;
>>>> +       mmc-pwrseq = <&wifi_pwrseq>;
>>>> +       vmmc-supply = <&reg_vcc3v3_pcie>;
>>>> +       vqmmc-supply = <&vcc_3v3>;
>>>> +       status = "okay";
>>>> +
>>>> +       ap6256: wifi@1 {
>>>> +               compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-
>>>> fmac";
>>>> +               reg = <1>;
>>>> +               /* TODO: out-of-band IRQ on GPIO21 */
>>>> +       };
>>>> +};
>>>> +
>>
>>>> +&mmc0_pins {
>>>> +       /*
>>>> +        * As the MMC0 bus is used to connect a SDIO Wi-Fi card
>>>> instead of
>>>> +        * an eMMC card, and the eMMC RST is repurposed to be an
>>>> enablement
>>>> +        * pin of the SDIO Wi-Fi, remove it from the pinctrl node
>>>> and
>>>> manage
>>>> +        * it as a GPIO instead.
>>>> +        */
>>>> +       /delete-node/ rst-pins;
>>>> +};
>>>> +
>>
>> Listed on the schematic [1] as:
>> Default function SDIO0 RSTn GPIO62 for eMMC:J9
>> Highlighted (non-default?) function GPIO62 D17 << WIFI_EN_H_GPIO62
>> WIFI_EN_H_GPIO62 >> WIFI_PWREN (pin 12 WL_REG_ON of module AP6256)
>>
>> I've sent a patch [2] to portion out mmc0 reset pins from jh7110-
>> common.dtsi
>>
>>>> +&mmc1 {
>>>> +       /delete-property/ cd-gpios;
>>>> +       broken-cd;
>>>
>>> Well it's found that the card detect is working, although with
>>> different polarity with other boards.
>>>
>>> Here should be:
>>> ```
>>>         cd-gpios = <&sysgpio 41 GPIO_ACTIVE_HIGH>;
>>> ```
>>>
>>> Will be fixed in the next revision.
>>
>> Yes, listed on the schematic [1] as:
>> SD SDIO0 CD GPIO41 for MicroSD:J10
>>
>> There is not a mention of active high or active low on the schematic
>> label, however there is listed a 10Kohm pull-up to +Vdd1.833 for the
>> circuit diagram of the Micro SD Card. The card holder is referenced
>> to
>> ground and could reasonably be N/O or N/C switch operation depending
>> on
>> the exact part selected for manufacture.
>>
>>>
>>>> +};
>>>> +
>>>> +&pcie0 {
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&pcie1 {
>>>> +       status = "okay";
>>>> +};
>>>> +
>>
>>>> +&phy0 {
>>>> +       rx-internal-delay-ps = <1500>;
>>>> +       tx-internal-delay-ps = <1500>;
>>>> +       motorcomm,tx-clk-adj-enabled;
>>>> +       motorcomm,tx-clk-10-inverted;
>>>> +       motorcomm,tx-clk-100-inverted;
>>>> +       motorcomm,tx-clk-1000-inverted;
>>>> +       motorcomm,rx-clk-drv-microamp = <3970>;
>>>> +       motorcomm,rx-data-drv-microamp = <2910>;
>>>> +};
>>
>> 'motorcomm,rx' before 'motorcomm,tx' in `LANG=C sort` of vendor-
>> specific
>> properties.
>>
>>>> +
>>>> +&pwmdac {
>>>> +       status = "okay";
>>>> +};
>>>
>> Additional non-default GPIO as listed in the Orange Pi design:
>> GPIO21 WIFI_WAKE_HOST_H /* default vf2 function PCIE_PWREN_H_GPIO21
>> */
>> GPIO22 >> BT_UART_RXD /* default vf2 function MIPI_PWR_EN */
>> GPIO23 << BT_UART_TXD /* default vf2 function LCD RESET */
>> GPIO24 << BT_UART_CTS /* default vf2 function MIPI_LCD_BL */
>> GPIO25 << BT_UART_RTS /* default vf2 function TP_DET_GPIO25 */
>> GPIO30 << BT_EN_H_GPIO30 /* default vf2 function TP_INT_L */
>> GPIO31 << BT_WAKE_GPIO31 /* default vf2 function TP_RST_L */
>>
>> Of all the above, GPIO21 is defined in jh7110-common.dtsi
>> &pcie1_pins/wake-pins and may need consideration.
>>
>> There is a note about "PMIC_PWRON as Key" and so does this have the
>> meaning of it is used as an input device?
>>
>> Also noted is that the USB over-current circuit appears to be
>> implemented, different than being absent in other VF2 designs.
>>
>> 1:
>> http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi-RV.html
>> 2:
>> https://lore.kernel.org/lkml/20251005174450.1949110-1-e@freeshell.de/
>>
>> With the card detect describing hardware corrected, and clean up the
>> vendor property sort, then please confirm if you think GPIO21 is
>> described correctly.
> 
> Well yes, GPIO21 should be splitted from PCIe pinctrl and assigned to
> be the out-of-band IRQ of the Wi-Fi module. My DT omits this because
> the jh7110 pinctrl driver is currently not compatible with brcmfmac
> out-of-band IRQ code.
> 
> Should I add /delete-node/ for it?
> 

No, and thank you for the confirmation. This special change for GPIO21
can be something for future fix/enhancement. The "dts: starfive:
jh7110-common: split out mmc0 reset pins from common into boards" patch
has landed in riscv-dt-for-next so it is good now to address the other
review comments and send v3.

>>
>> Acked-by: E Shattow <e@freeshell.de>
>>
> 

-E


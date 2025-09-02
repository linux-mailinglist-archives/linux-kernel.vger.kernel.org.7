Return-Path: <linux-kernel+bounces-795855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E920B3F8B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4AD179283
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B842EBDE3;
	Tue,  2 Sep 2025 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mCe9ElLa"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4F2EBB9B;
	Tue,  2 Sep 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802041; cv=none; b=gp6ZGH93CuVv+PcNmS6fRQtZZYEHwO9cXxgpHkTM7+8PfpGVbHs1O8i/nxW8U+ALRTdeFlFdpCjDG2vSTg8a2Tp6d5VnPZwuR2M8YSCpX24r19cbeV9mGzGl18e34W0R6l77ALaGnE0aNvhlmjNr5RP1hC59ZtBCEQZM4xA9Dms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802041; c=relaxed/simple;
	bh=JuY0MyudkT5rFxLXrWqc9BLkW8qB3+0BBAFr6xiGy4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BqCdBNl0TrMAhP3XBL58CoaBRA0E1fF8Dzvw/ncrT9kVxWD4NXcuqZXnB03+K4+4umQFjASF01lLwgBs3GKo7MApDZ1RxL71vacdwxnep/k2ajEhVXqseG5+I+FFDGWUcRNN4IOairTi9JDJPb4bKX0rtE97fqcb/51ZL9mTzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mCe9ElLa; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5828XqHN2487218;
	Tue, 2 Sep 2025 03:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756802032;
	bh=lwYRQuQ9q81SHpYsQEpVnWlEvIcK3LgEhk4PAia0l1U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mCe9ElLaUjxh1MzX3Fm0lVqEVWZ4uKcKQMkctWCI7p0xDi1xqJRlU7+bdFoZOsniR
	 +JFxYh5tLA++deaOP+UrTN1fr3nmUoubyqL1mO1BVaR7sMUOnatoeD23wzNfIxMiBM
	 NyKW36h+Hx5Xjv7MdnGsvo6/OjedgUcTADoX42FU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5828XqX92605214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 03:33:52 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 03:33:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 03:33:51 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5828Xluc3502840;
	Tue, 2 Sep 2025 03:33:47 -0500
Message-ID: <5f94830d-8ad0-4abb-a109-bad88b4a9090@ti.com>
Date: Tue, 2 Sep 2025 14:03:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62d2-evm: Add support for OSPI flash
To: Paresh Bhagat <p-bhagat@ti.com>, Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <s-k6@ti.com>
References: <20250813090300.733295-1-p-bhagat@ti.com>
 <20250822183014.apyvqws4afiqiymb@specks>
 <f207b2e9-a910-40f3-a01e-1af33c7f4e6f@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <f207b2e9-a910-40f3-a01e-1af33c7f4e6f@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Paresh,

On 23/08/25 09:03, Paresh Bhagat wrote:
> Hi Nishanth,
> 
> 
> On 23/08/25 00:00, Nishanth Menon wrote:
>> On 14:33-20250813, Paresh Bhagat wrote:
>>> AM62D2 EVM has S28HS512T 64 MiB Octal SPI NOR flash connected to the
>>> OSPI interface. Add support for the flash and describe the partition
>>> information as per bootloader.
>>>
>>> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>

Thanks for the patch.

>>> ---
>>> Boot logs
>>> https://gist.github.com/paresh-bhagat12/262d8c64e692d22c4e48363d246fb083
>> We already have issues with am62d that needs fixing:
>> cpu cpu0: _of_add_opp_table_v2: no supported OPPs
>> cpu cpu0: OPP table can't be empty
>>
>> and
>>
>> Please enable defconfig for this device
>> arch/arm64/boot/dts/ti/k3-am62d2-evm.dts:       typec_pd0: usb-power- 
>> controller@3f {
>>
>> We can look at adding features for am62d after the above are done.
> 
> 
> The above fixes are now posted in upstream.

The patch seems fine wrt the SPI changes made. Good to go!

Reviewed-by: Santhosh Kumar K <s-k6@ti.com>

> 
> Thanks
>>> Tech Ref Manual-https://www.ti.com/lit/pdf/sprujd4
>>> Schematics Link-https://www.ti.com/lit/zip/sprcal5
>>>
>>>   arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 86 ++++++++++++++++++++++++
>>>   1 file changed, 86 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/ 
>>> boot/dts/ti/k3-am62d2-evm.dts
>>> index daea18b0bc61..aa943ef52fb5 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
>>> @@ -25,6 +25,7 @@ aliases {
>>>           rtc0 = &wkup_rtc0;
>>>           ethernet0 = &cpsw_port1;
>>>           ethernet1 = &cpsw_port2;
>>> +        spi0 = &ospi0;
>>>       };
>>>       chosen {
>>> @@ -367,6 +368,26 @@ usr_led_pins_default: usr-led-default-pins {
>>>               AM62DX_IOPAD(0x0244, PIN_INPUT, 7) /* (D18) 
>>> MMC1_SDWP.GPIO1_49 */
>>>           >;
>>>       };
>>> +
>>> +    ospi0_pins_default: ospi0-default-pins {
>>> +        pinctrl-single,pins = <
>>> +            AM62DX_IOPAD(0x0000, PIN_OUTPUT, 0) /* (L22) OSPI0_CLK */
>>> +            AM62DX_IOPAD(0x002c, PIN_OUTPUT, 0) /* (H21) OSPI0_CSn0 */
>>> +            AM62DX_IOPAD(0x0030, PIN_OUTPUT, 0) /* (G19) OSPI0_CSn1 */
>>> +            AM62DX_IOPAD(0x0034, PIN_OUTPUT, 0) /* (K20) OSPI0_CSn2 */
>>> +            AM62DX_IOPAD(0x0038, PIN_OUTPUT, 0) /* (G20) OSPI0_CSn3 */
>>> +            AM62DX_IOPAD(0x000c, PIN_INPUT, 0) /* (J21) OSPI0_D0 */
>>> +            AM62DX_IOPAD(0x0010, PIN_INPUT, 0) /* (J18) OSPI0_D1 */
>>> +            AM62DX_IOPAD(0x0014, PIN_INPUT, 0) /* (J19) OSPI0_D2 */
>>> +            AM62DX_IOPAD(0x0018, PIN_INPUT, 0) /* (H18) OSPI0_D3 */
>>> +            AM62DX_IOPAD(0x001c, PIN_INPUT, 0) /* (K21) OSPI0_D4 */
>>> +            AM62DX_IOPAD(0x0020, PIN_INPUT, 0) /* (H19) OSPI0_D5 */
>>> +            AM62DX_IOPAD(0x0024, PIN_INPUT, 0) /* (J20) OSPI0_D6 */
>>> +            AM62DX_IOPAD(0x0028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
>>> +            AM62DX_IOPAD(0x0008, PIN_INPUT, 0) /* (L21) OSPI0_DQS */
>>> +        >;
>>> +        bootph-all;
>>> +    };
>>>   };
>>>   &mcu_gpio0 {
>>> @@ -613,3 +634,68 @@ &c7x_0 {
>>>   &main_rti4 {
>>>       status = "reserved";
>>>   };
>>> +
>>> +&fss {
>>> +    status = "okay";
>>> +};
>>> +
>>> +&ospi0 {
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&ospi0_pins_default>;
>>> +    status = "okay";
>>> +
>>> +    flash@0{
>>> +        compatible = "jedec,spi-nor";
>>> +        reg = <0x0>;
>>> +        spi-tx-bus-width = <8>;
>>> +        spi-rx-bus-width = <8>;
>>> +        spi-max-frequency = <25000000>;
>>> +        cdns,tshsl-ns = <60>;
>>> +        cdns,tsd2d-ns = <60>;
>>> +        cdns,tchsh-ns = <60>;
>>> +        cdns,tslch-ns = <60>;
>>> +        cdns,read-delay = <4>;
>>> +
>>> +        partitions {
>>> +            compatible = "fixed-partitions";
>>> +            #address-cells = <1>;
>>> +            #size-cells = <1>;
>>> +
>>> +            partition@0 {
>>> +                label = "ospi.tiboot3";
>>> +                reg = <0x0 0x80000>;
>>> +            };
>>> +
>>> +            partition@80000 {
>>> +                label = "ospi.tispl";
>>> +                reg = <0x80000 0x200000>;
>>> +            };
>>> +
>>> +            partition@280000 {
>>> +                label = "ospi.u-boot";
>>> +                reg = <0x280000 0x400000>;
>>> +            };
>>> +
>>> +            partition@680000 {
>>> +                label = "ospi.env";
>>> +                reg = <0x680000 0x40000>;
>>> +            };
>>> +
>>> +            partition@6c0000 {
>>> +                label = "ospi.env.backup";
>>> +                reg = <0x6c0000 0x40000>;
>>> +            };
>>> +
>>> +            partition@800000 {
>>> +                label = "ospi.rootfs";
>>> +                reg = <0x800000 0x37c0000>;
>>> +            };
>>> +
>>> +            partition@3fc0000 {
>>> +                label = "ospi.phypattern";
>>> +                reg = <0x3fc0000 0x40000>;
>>> +                bootph-all;
>>> +            };
>>> +        };
>>> +    };
>>> +};
>>> -- 
>>> 2.34.1
>>>
>>>


